/* _NVRM_COPYRIGHT_BEGIN_
 *
 * Copyright 1999-2013 by NVIDIA Corporation.  All rights reserved.  All
 * information contained herein is proprietary and confidential to NVIDIA
 * Corporation.  Any use, reproduction, or disclosure without the written
 * permission of NVIDIA Corporation is prohibited.
 *
 * _NVRM_COPYRIGHT_END_
 */

#include "nv-misc.h"
#include "os-interface.h"
#include "nv-linux.h"
#include "nv-p2p.h"
#include "nv-reg.h"
#include "rmil.h"

#if defined(NV_UVM_ENABLE) || defined(NV_UVM_NEXT_ENABLE)
#include "nv_uvm_interface.h"
#endif

#if !defined(NV_VMWARE)
#include "nv-frontend.h"
#endif

/* 
 * The module information macros for Linux single-module builds
 * are present in nv-frontend.c.
 */

#if defined(NV_VMWARE) || (NV_BUILD_MODULE_INSTANCES != 0)
#if defined(MODULE_LICENSE)
MODULE_LICENSE("NVIDIA");
#endif
#if defined(MODULE_INFO)
MODULE_INFO(supported, "external");
#endif
#if defined(MODULE_VERSION)
MODULE_VERSION(NV_VERSION_STRING);
#endif
#ifdef MODULE_ALIAS_CHARDEV_MAJOR
MODULE_ALIAS_CHARDEV_MAJOR(NV_MAJOR_DEVICE_NUMBER);
#endif
#endif

#include "conftest/patches.h"

/*
 * our global state; one per device
 */

static NvU32 num_nv_devices = 0;
NvU32 num_probed_nv_devices = 0;

NvU32 nv_assign_gpu_count = 0;
nv_pci_info_t nv_assign_gpu_pci_info[NV_MAX_DEVICES];

nv_linux_state_t *nv_linux_devices;
static nv_smu_state_t nv_smu_device;

#define NV_STACK_CACHE_STR      (NV_DEV_NAME"_stack_t")
#define NV_PTE_CACHE_STR        (NV_DEV_NAME"_pte_t")

#if defined(NVCPU_X86) || defined(NVCPU_X86_64)
NvU64 __nv_supported_pte_mask = ~_PAGE_NX;
#endif

/*
 * And one for the control device
 */

nv_linux_state_t nv_ctl_device = { { 0 } };
wait_queue_head_t nv_ctl_waitqueue;

#if defined(NV_CHANGE_PAGE_ATTR_BUG_PRESENT)
static const char *__cpgattr_warning = \
    "Your Linux kernel has known problems in its implementation of\n"
    "the change_page_attr() kernel interface.\n\n"
    "The NVIDIA graphics driver will attempt to work around these\n"
    "problems, but system stability may be adversely affected.\n"
    "It is recommended that you update to Linux 2.6.11 (or a newer\n"
    "Linux kernel release).\n";

static const char *__cpgattr_warning_2 = \
    "Your Linux kernel's version and architecture indicate that it\n"
    "may have an implementation of the change_page_attr() kernel\n"
    "kernel interface known to have problems. The NVIDIA graphics\n"
    "driver made an attempt to determine whether your kernel is\n"
    "affected, but could not. It will assume the interface does not\n"
    "work correctly and attempt to employ workarounds.\n"
    "This may adversely affect system stability.\n"
    "It is recommended that you update to Linux 2.6.11 (or a newer\n"
    "Linux kernel release).\n";
#endif

static int nv_mmconfig_failure_detected = 0;
static const char *__mmconfig_warning = \
    "Your current system configuration has known problems when\n"
    "accessing PCI Configuration Space that can lead to accesses\n"
    "to the PCI Configuration Space of the wrong PCI device. This\n"
    "is known to cause instabilities with the NVIDIA graphics driver.\n\n"
    "Please see the MMConfig section in the readme for more information\n"
    "on how to work around this problem.\n";

#if !defined(NV_VMWARE) && \
  (defined(NVCPU_X86) || defined(NVCPU_X86_64))
static int nv_fbdev_failure_detected = 0;
static const char *__fbdev_warning = \
    "Your system is not currently configured to drive a VGA console\n"
    "on the primary VGA device. The NVIDIA Linux graphics driver\n"
    "requires the use of a text-mode VGA console. Use of other console\n"
    "drivers including, but not limited to, vesafb, may result in\n"
    "corruption and stability problems, and is not supported.\n";
#endif

#if defined(NV_SG_MAP_BUFFERS) && defined(NV_NEED_REMAP_CHECK)
unsigned int nv_remap_count;
unsigned int nv_remap_limit;
#endif

#define NV_UPDATE_MEMORY_TYPES_DEFAULT 1

int nv_update_memory_types = NV_UPDATE_MEMORY_TYPES_DEFAULT;

nv_cpu_type_t nv_cpu_type = NV_CPU_TYPE_UNKNOWN;

void *nvidia_p2p_page_t_cache;
static void *nv_pte_t_cache;
void *nv_stack_t_cache;
static nv_stack_t *__nv_init_sp;

/*
 * vGPU specific macro to lock/unlock nv_linux_devices list
 * These macros are enabled only for vGPU module
 * Lock acquisition order while using the nv_linux_devices list
 * 1. LOCK_NV_LINUX_DEVICES()
 * 2. Traverse the list
 *    If the list is traversed to search for an element say nvl,
 *    acquire the nvl->ldata_lock before step 3
 * 3. UNLOCK_NV_LINUX_DEVICES()
 * 4. Release nvl->ldata_lock after any read/write access to the
 *    nvl element is complete
 */
#if defined(NV_VGX_HYPER)
struct semaphore nv_linux_devices_lock;
#define LOCK_NV_LINUX_DEVICES()     down(&nv_linux_devices_lock)
#define UNLOCK_NV_LINUX_DEVICES()   up(&nv_linux_devices_lock)
#else
#define LOCK_NV_LINUX_DEVICES()
#define UNLOCK_NV_LINUX_DEVICES()
#endif

// allow an easy way to convert all debug printfs related to events
// back and forth between 'info' and 'errors'
#if defined(NV_DBG_EVENTS)
#define NV_DBG_EVENTINFO NV_DBG_ERRORS
#else
#define NV_DBG_EVENTINFO NV_DBG_INFO
#endif

//
// Attempt to determine if we are running into the MMCONFIG coherency
// issue and, if so, warn the user and stop attempting to verify
// and correct the BAR values (see NV_CHECK_PCI_CONFIG_SPACE()), so
// that we do not do more harm than good.
//
#define NV_CHECK_MMCONFIG_FAILURE(nv,bar,value)                            \
    {                                                                      \
        nv_linux_state_t *nvl;                                             \
        for (nvl = nv_linux_devices; nvl != NULL;  nvl = nvl->next)        \
        {                                                                  \
            nv_state_t *nv_tmp = NV_STATE_PTR(nvl);                        \
            if (((nv) != nv_tmp) &&                                        \
                (nv_tmp->bars[(bar)].bus_address == (value)))              \
            {                                                              \
                nv_prints(NV_DBG_ERRORS, __mmconfig_warning);              \
                nv_procfs_add_warning("mmconfig", __mmconfig_warning);     \
                nv_mmconfig_failure_detected = 1;                          \
                return;                                                    \
            }                                                              \
        }                                                                  \
    }

static void
verify_pci_bars(
    nv_state_t  *nv,
    void        *dev_handle
)
{
    NvU32 bar, bar_hi, bar_lo;

    //
    // If an MMCONFIG specific failure was detected, skip the
    // PCI BAR verification to avoid overwriting the BAR(s)
    // of a given device with those of this GPU. See above for
    // more information.
    //
    if (nv_mmconfig_failure_detected)
        return;

    for (bar = 0; bar < NV_GPU_NUM_BARS; bar++)
    {
        nv_aperture_t *tmp = &nv->bars[bar];

        bar_lo = bar_hi = 0;
        if (tmp->offset == 0)
            continue;

        os_pci_read_dword(dev_handle, tmp->offset, &bar_lo);

        if ((bar_lo & NVRM_PCICFG_BAR_ADDR_MASK)
                != NvU64_LO32(tmp->bus_address))
        {
            nv_printf(NV_DBG_USERERRORS,
                "NVRM: BAR%u(L) is 0x%08x, will restore to 0x%08llx.\n",
                bar, bar_lo, NvU64_LO32(tmp->bus_address) |
                             (bar_lo & ~NVRM_PCICFG_BAR_ADDR_MASK));

            NV_CHECK_MMCONFIG_FAILURE(nv, bar,
                    (bar_lo & NVRM_PCICFG_BAR_ADDR_MASK));

            os_pci_write_dword(dev_handle, tmp->offset,
                NvU64_LO32(tmp->bus_address));
        }

        if ((bar_lo & NVRM_PCICFG_BAR_MEMTYPE_MASK)
                != NVRM_PCICFG_BAR_MEMTYPE_64BIT)
            continue;

        os_pci_read_dword(dev_handle, (tmp->offset + 4), &bar_hi);

        if (bar_hi != NvU64_HI32(tmp->bus_address))
        {
            nv_printf(NV_DBG_USERERRORS,
                "NVRM: BAR%u(H) is 0x%08x, will restore to 0x%08llx.\n",
                bar, bar_hi, NvU64_HI32(tmp->bus_address));

            os_pci_write_dword(dev_handle, (tmp->offset + 4),
                    NvU64_HI32(tmp->bus_address));
        }
    }
}

void nv_check_pci_config_space(nv_state_t *nv, BOOL check_the_bars)
{
    nv_linux_state_t *nvl = NV_GET_NVL_FROM_NV_STATE(nv);
    unsigned short cmd, flag = 0;

    pci_read_config_word(nvl->dev, PCI_COMMAND, &cmd);
    if (!(cmd & PCI_COMMAND_MASTER))
    {
        nv_printf(NV_DBG_USERERRORS, "NVRM: restoring bus mastering!\n");
        cmd |= PCI_COMMAND_MASTER;
        flag = 1;
    }

    if (!(cmd & PCI_COMMAND_MEMORY))
    {
        nv_printf(NV_DBG_USERERRORS, "NVRM: restoring MEM access!\n");
        cmd |= PCI_COMMAND_MEMORY;
        flag = 1;
    }

    if (cmd & PCI_COMMAND_SERR)
    {
        nv_printf(NV_DBG_USERERRORS, "NVRM: clearing SERR enable bit!\n");
        cmd &= ~PCI_COMMAND_SERR;
        flag = 1;
    }

    if (cmd & PCI_COMMAND_INTX_DISABLE)
    {
        nv_printf(NV_DBG_USERERRORS, "NVRM: clearing INTx disable bit!\n");
        cmd &= ~PCI_COMMAND_INTX_DISABLE;
        flag = 1;
    }

    if (flag)
        pci_write_config_word(nvl->dev, PCI_COMMAND, cmd);

    if (check_the_bars && NV_MAY_SLEEP() && !(nv->flags & NV_FLAG_PASSTHRU))
        verify_pci_bars(nv, nvl->dev);
}

void NV_API_CALL nv_verify_pci_config(
    nv_state_t *nv,
    BOOL        check_the_bars
)
{
    nv_linux_state_t *nvl;
    nv_stack_t *sp;

    if ((nv)->flags & NV_FLAG_USE_BAR0_CFG)
    {
        nvl = NV_GET_NVL_FROM_NV_STATE(nv);
        sp = nvl->pci_cfgchk_sp;

        rm_check_pci_config_space(sp, nv,
                check_the_bars, FALSE, NV_MAY_SLEEP());
    }
    else
        nv_check_pci_config_space(nv, NV_MAY_SLEEP());
}

/***
 *** STATIC functions, only in this file
 ***/

/* nvos_ functions.. do not take a state device parameter  */
static int      nvos_count_devices(nv_stack_t *);

static nv_alloc_t  *nvos_create_alloc(struct pci_dev *, int);
static int          nvos_free_alloc(nv_alloc_t *);

/* lock-related functions that should only be called from this file */
static void nv_lock_init_locks(nv_state_t *nv);


/***
 *** EXPORTS to Linux Kernel
 ***/

static int           nvidia_open           (struct inode *, struct file *);
static int           nvidia_close          (struct inode *, struct file *);
static unsigned int  nvidia_poll           (struct file *, poll_table *);
static int           nvidia_ioctl          (struct inode *, struct file *, unsigned int, unsigned long);
static long          nvidia_unlocked_ioctl (struct file *, unsigned int, unsigned long);
static void          nvidia_isr_bh         (unsigned long);
#if !defined(NV_IRQ_HANDLER_T_PRESENT) || (NV_IRQ_HANDLER_T_ARGUMENT_COUNT == 3)
static irqreturn_t   nvidia_isr            (int, void *, struct pt_regs *);
#else
static irqreturn_t   nvidia_isr            (int, void *);
#endif
static void          nvidia_rc_timer       (unsigned long);

static int           nvidia_ctl_open       (struct inode *, struct file *);
static int           nvidia_ctl_close      (struct inode *, struct file *);

static int           nvidia_probe          (struct pci_dev *, const struct pci_device_id *);
static void          nvidia_remove         (struct pci_dev *);
static int           nvidia_smu_probe      (struct pci_dev *);

#if defined(NV_PM_SUPPORT_DEVICE_DRIVER_MODEL)
static int           nvidia_suspend        (struct pci_dev *, pm_message_t);
static int           nvidia_smu_suspend    (void);
static int           nvidia_resume         (struct pci_dev *);
static int           nvidia_smu_resume     (void);
#endif

#if defined(NV_PCI_ERROR_RECOVERY)
static pci_ers_result_t nvidia_pci_error_detected   (struct pci_dev *, enum pci_channel_state);
static pci_ers_result_t nvidia_pci_mmio_enabled     (struct pci_dev *);
#endif

/***
 *** see nv.h for functions exported to other parts of resman
 ***/

static struct pci_device_id nv_pci_table[] = {
    {
        .vendor      = PCI_VENDOR_ID_NVIDIA,
        .device      = PCI_ANY_ID,
        .subvendor   = PCI_ANY_ID,
        .subdevice   = PCI_ANY_ID,
        .class       = (PCI_CLASS_DISPLAY_VGA << 8),
        .class_mask  = ~0
    },
    {
        .vendor      = PCI_VENDOR_ID_NVIDIA,
        .device      = PCI_ANY_ID,
        .subvendor   = PCI_ANY_ID,
        .subdevice   = PCI_ANY_ID,
        .class       = (PCI_CLASS_DISPLAY_3D << 8),
        .class_mask  = ~0
    },
    {
        .vendor      = PCI_VENDOR_ID_NVIDIA,
        .device      = NV_PCI_DEVICE_ID_SMU,
        .subvendor   = PCI_ANY_ID,
        .subdevice   = PCI_ANY_ID,
        .class       = (PCI_CLASS_PROCESSOR_CO << 8), /* SMU device class */
        .class_mask  = ~0
    },
    {
        .vendor      = PCI_VENDOR_ID_NVIDIA,
        .device      = 0x0e00,
        .subvendor   = PCI_ANY_ID,
        .subdevice   = PCI_ANY_ID,
        .class       = (PCI_CLASS_MULTIMEDIA_OTHER << 8),
        .class_mask  = ~0
    },
    { }
};

MODULE_DEVICE_TABLE(pci, nv_pci_table);

#if defined(NV_PCI_ERROR_RECOVERY)
static struct pci_error_handlers nv_pci_error_handlers = {
    .error_detected = nvidia_pci_error_detected,
    .mmio_enabled   = nvidia_pci_mmio_enabled,
};
#endif

static struct pci_driver nv_pci_driver = {
    .name     = NV_DEV_NAME,
    .id_table = nv_pci_table,
    .probe    = nvidia_probe,
#if defined(NV_VGX_HYPER)
    .remove   = nvidia_remove,
#endif
#if defined(NV_PM_SUPPORT_DEVICE_DRIVER_MODEL)
    .suspend  = nvidia_suspend,
    .resume   = nvidia_resume,
#endif
#if defined(NV_PCI_ERROR_RECOVERY)
    .err_handler = &nv_pci_error_handlers,
#endif
};

#if defined(NV_VMWARE)
/* character driver entry points */

static struct file_operations nv_fops = {
    .owner     = THIS_MODULE,
    .poll      = nvidia_poll,
#if defined(NV_FILE_OPERATIONS_HAS_IOCTL)
    .ioctl     = nvidia_ioctl,
#endif
#if defined(NV_FILE_OPERATIONS_HAS_UNLOCKED_IOCTL)
    .unlocked_ioctl = nvidia_unlocked_ioctl,
#endif
    .open      = nvidia_open,
    .release   = nvidia_close,
};
#else
static nvidia_module_t nv_fops = {
    .owner       = THIS_MODULE,
    .module_name = NV_DEV_NAME,
    .open        = nvidia_open,
    .close       = nvidia_close,
    .ioctl       = nvidia_ioctl,
    .mmap        = nvidia_mmap,
    .poll        = nvidia_poll,
};
#endif

#if defined(VM_CHECKER)
/* kernel virtual memory usage/allocation information */
NvU32 vm_usage = 0;
struct mem_track_t *vm_list = NULL;
nv_spinlock_t vm_lock;
#endif

#if defined(KM_CHECKER)
/* kernel logical memory usage/allocation information */
NvU32 km_usage = 0;
struct mem_track_t *km_list = NULL;
nv_spinlock_t km_lock;
#endif


/***
 *** STATIC functions
 ***/

static
nv_alloc_t *nvos_create_alloc(
    struct pci_dev *dev,
    int num_pages
)
{
    nv_alloc_t *at;
    unsigned int pt_size, i;

    NV_KMALLOC(at, sizeof(nv_alloc_t));
    if (at == NULL)
    {
        nv_printf(NV_DBG_ERRORS, "NVRM: failed to allocate alloc info\n");
        return NULL;
    }

    memset(at, 0, sizeof(nv_alloc_t));

    at->dev = dev;
    pt_size = num_pages *  sizeof(nv_pte_t *);
    if (os_alloc_mem((void **)&at->page_table, pt_size) != RM_OK)
    {
        nv_printf(NV_DBG_ERRORS, "NVRM: failed to allocate page table\n");
        NV_KFREE(at, sizeof(nv_alloc_t));
        return NULL;
    }

    memset(at->page_table, 0, pt_size);
    at->num_pages = num_pages;
    NV_ATOMIC_SET(at->usage_count, 0);

    for (i = 0; i < at->num_pages; i++)
    {
        NV_KMEM_CACHE_ALLOC(at->page_table[i], nv_pte_t_cache, nv_pte_t);
        if (at->page_table[i] == NULL)
        {
            nv_printf(NV_DBG_ERRORS,
                      "NVRM: failed to allocate page table entry\n");
            nvos_free_alloc(at);
            return NULL;
        }
        memset(at->page_table[i], 0, sizeof(nv_pte_t));
    }

    at->pid = os_get_current_process();

    return at;
}

static
int nvos_free_alloc(
    nv_alloc_t *at
)
{
    unsigned int i;

    if (at == NULL)
        return -1;

    if (NV_ATOMIC_READ(at->usage_count))
        return 1;

    for (i = 0; i < at->num_pages; i++)
    {
        if (at->page_table[i] != NULL)
            NV_KMEM_CACHE_FREE(at->page_table[i], nv_pte_t, nv_pte_t_cache);
    }
    os_free_mem(at->page_table);

    NV_KFREE(at, sizeof(nv_alloc_t));

    return 0;
}

NvU8 nv_find_pci_capability(struct pci_dev *dev, NvU8 capability)
{
    u16 status;
    u8  cap_ptr, cap_id;

    pci_read_config_word(dev, PCI_STATUS, &status);
    status &= PCI_STATUS_CAP_LIST;
    if (!status)
        return 0;

    switch (dev->hdr_type) {
        case PCI_HEADER_TYPE_NORMAL:
        case PCI_HEADER_TYPE_BRIDGE:
            pci_read_config_byte(dev, PCI_CAPABILITY_LIST, &cap_ptr);
            break;
        default:
            return 0;
    }

    do {
        cap_ptr &= 0xfc;
        pci_read_config_byte(dev, cap_ptr + PCI_CAP_LIST_ID, &cap_id);
        if (cap_id == capability)
            return cap_ptr;
        pci_read_config_byte(dev, cap_ptr + PCI_CAP_LIST_NEXT, &cap_ptr);
    } while (cap_ptr && cap_id != 0xff);

    return 0;
}

#if defined(NV_CHANGE_PAGE_ATTR_BUG_PRESENT)
/*
 * nv_verify_cpa_interface() - determine if the change_page_attr() large page
 * management accounting bug known to exist in early Linux/x86-64 kernels
 * is present in this kernel.
 *
 * There's really no good way to determine if change_page_attr() is working
 * correctly. We can't reliably use change_page_attr() on Linux/x86-64 2.6
 * kernels < 2.6.11: if we run into the accounting bug, the Linux kernel will
 * trigger a BUG() if we attempt to restore the WB memory type of a page
 * originally part of a large page.
 *
 * So if we can successfully allocate such a page, change its memory type to
 * UC and check if the accounting was done correctly, we can determine if
 * the change_page_attr() interface can be used safely.
 *
 * Return values:
 *    0 - test passed, the change_page_attr() interface works
 *    1 - test failed, the status is unclear
 *   -1 - test failed, the change_page_attr() interface is broken
 */

static inline pte_t *check_large_page(unsigned long vaddr)
{
    pgd_t *pgd = NULL;
    pmd_t *pmd = NULL;

    pgd = NV_PGD_OFFSET(vaddr, 1, NULL);
    if (!NV_PGD_PRESENT(pgd))
        return NULL;

    pmd = NV_PMD_OFFSET(vaddr, pgd);
    if (!pmd || pmd_none(*pmd))
        return NULL;

    if (!pmd_large(*pmd))
        return NULL;

    return (pte_t *) pmd;
}

#define CPA_FIXED_MAX_ALLOCS 500

int nv_verify_cpa_interface(void)
{
    unsigned int i, size;
    unsigned long large_page = 0;
    unsigned long *vaddr_list;
    size = sizeof(unsigned long) * CPA_FIXED_MAX_ALLOCS;

    NV_KMALLOC(vaddr_list, size);
    if (!vaddr_list)
    {
        nv_printf(NV_DBG_ERRORS,
            "NVRM: nv_verify_cpa_interface: failed to allocate "
            "page table\n");
        return 1;
    }

    memset(vaddr_list, 0, size);

    /* try to track down an allocation from a 2M page. */
    for (i = 0; i < CPA_FIXED_MAX_ALLOCS; i++)
    {
        vaddr_list[i] =  __get_free_page(GFP_KERNEL);
        if (!vaddr_list[i])
            continue;

#if defined(_PAGE_NX)
        if ((pgprot_val(PAGE_KERNEL) & _PAGE_NX) &&
                virt_to_phys((void *)vaddr_list[i]) < 0x400000)
            continue;
#endif

        if (check_large_page(vaddr_list[i]) != NULL)
        {
            large_page = vaddr_list[i];
            vaddr_list[i] = 0;
            break;
        }
    }

    for (i = 0; i < CPA_FIXED_MAX_ALLOCS; i++)
    {
        if (vaddr_list[i])
            free_page(vaddr_list[i]);
    }
    NV_KFREE(vaddr_list, size);

    if (large_page)
    {
        struct page *page = virt_to_page(large_page);
        struct page *kpte_page;
        pte_t *kpte;
        unsigned long kpte_val;
        pgprot_t prot;

        // lookup a pointer to our pte
        kpte = check_large_page(large_page);
        kpte_val = pte_val(*kpte);
        kpte_page = virt_to_page(((unsigned long)kpte) & PAGE_MASK);

        prot = PAGE_KERNEL_NOCACHE;
        pgprot_val(prot) &= __nv_supported_pte_mask;

        // this should split the large page
        change_page_attr(page, 1, prot);

        // broken kernels may get confused after splitting the page and
        // restore the page before returning to us. detect that case.
        if (((pte_val(*kpte) & ~_PAGE_NX) == kpte_val) &&
            (pte_val(*kpte) & _PAGE_PSE))
        {
            if ((pte_val(*kpte) & _PAGE_NX) &&
                    (__nv_supported_pte_mask & _PAGE_NX) == 0)
                clear_bit(_PAGE_BIT_NX, kpte);
            // don't change the page back, as it's already been reverted
            put_page(kpte_page);
            free_page(large_page);
            return -1;  // yep, we're broken
        }

        // ok, now see if our bookkeeping is broken
        if (page_count(kpte_page) != 0)
            return -1;  // yep, we're broken

        prot = PAGE_KERNEL;
        pgprot_val(prot) &= __nv_supported_pte_mask;

        // everything's ok!
        change_page_attr(page, 1, prot);
        free_page(large_page);
        return 0;
    }

    return 1;
}
#endif /* defined(NV_CHANGE_PAGE_ATTR_BUG_PRESENT) */

int __init nvidia_init_module(void)
{
    RM_STATUS status;
    int rc;
    NvU32 count, data, i;
    nv_state_t *nv = NV_STATE_PTR(&nv_ctl_device);
    nv_stack_t *sp = NULL;
    nv_linux_state_t *nvl;
    nv_smu_state_t *nv_smu = &nv_smu_device;

    if (NV_BUILD_MODULE_INSTANCES != 0)
    {
        nv_printf(NV_DBG_INFO, "NVRM: nvidia module instance %d\n", 
                  NV_MODULE_INSTANCE);
    }

    nv_user_map_init();

    rc = nv_heap_create();
    if (rc < 0)
    {
        goto failed4;
    }

    rc = nv_mem_pool_create();
    if (rc < 0)
    {
        goto failed4;
    }

#if defined(NV_LINUX_NVMAP_H_PRESENT) && defined(HAVE_NV_ANDROID)
    status = nv_nvmap_create_client();
    if (RM_OK != status)
    {
        rc = -EIO;
        goto failed4;
    }
#endif

#if defined(VM_CHECKER)
    NV_SPIN_LOCK_INIT(&vm_lock);
#endif
#if defined(KM_CHECKER)
    NV_SPIN_LOCK_INIT(&km_lock);
#endif

    NV_KMEM_CACHE_CREATE(nv_stack_t_cache, NV_STACK_CACHE_STR, nv_stack_t);
    if (nv_stack_t_cache == NULL)
    {
        nv_printf(NV_DBG_ERRORS, "NVRM: stack cache allocation failed!\n");
        rc = -ENOMEM;
        goto failed4;
    }

    NV_KMEM_CACHE_ALLOC_STACK(sp);
    if (sp == NULL)
    {
        NV_KMEM_CACHE_DESTROY(nv_stack_t_cache);
        nv_printf(NV_DBG_ERRORS, "NVRM: failed to allocate stack!\n");
        rc = -ENOMEM;
        goto failed4;
    }

    if (!rm_init_rm(sp))
    {
        NV_KMEM_CACHE_FREE_STACK(sp);
        NV_KMEM_CACHE_DESTROY(nv_stack_t_cache);
        nv_printf(NV_DBG_ERRORS, "NVRM: rm_init_rm() failed!\n");
        return -EIO;
    }

    count = nvos_count_devices(sp);
    if (count == 0)
    {
        if (NV_IS_ASSIGN_GPU_PCI_INFO_SPECIFIED())
        {
            nv_printf(NV_DBG_ERRORS,
                "NVRM: The requested GPU assignments are invalid. Please ensure\n"
                "NVRM: that the GPUs you wish to assign to this kernel module\n"
                "NVRM: are present and available.\n");
        }
        else
        {
            nv_printf(NV_DBG_ERRORS, "NVRM: No NVIDIA graphics adapter found!\n");
        }
        rc = -ENODEV;
        goto failed5;
    }

    nv_linux_devices = NULL;
#if defined(NV_VGX_HYPER)
    NV_INIT_MUTEX(&nv_linux_devices_lock);
#endif

    memset(&nv_smu_device, 0, sizeof(nv_smu_state_t));

    rc = nv_register_chrdev((void *)&nv_fops);
    if (rc < 0)
        goto failed5;

    /* create /proc/driver/nvidia/... */
    rc = nv_register_procfs();
    if (rc < 0)
        nv_printf(NV_DBG_ERRORS, "NVRM: failed to register procfs!\n");

    if (pci_register_driver(&nv_pci_driver) < 0)
    {
        rc = -ENODEV;
        nv_printf(NV_DBG_ERRORS, "NVRM: No NVIDIA graphics adapter found!\n");
        goto failed4;
    }

    if (nv_drm_init(&nv_pci_driver) < 0)
    {
        rc = -ENODEV;
        nv_printf(NV_DBG_ERRORS, "NVRM: DRM init failed\n");
        goto failed3;
    }

    if (nv_smu->handle != NULL)
    {
        /* init SMU functionality */
        rm_init_smu(sp, nv_smu);
    }

    if (num_probed_nv_devices != count)
    {
        nv_printf(NV_DBG_ERRORS,
            "NVRM: The NVIDIA probe routine was not called for %d device(s).\n",
            count - num_probed_nv_devices);
        nv_printf(NV_DBG_ERRORS,
            "NVRM: This can occur when a driver such as: \n"
            "NVRM: nouveau, rivafb, nvidiafb or rivatv "
#if (NV_BUILD_MODULE_INSTANCES != 0)
            "NVRM: or another NVIDIA kernel module "
#endif
            "\nNVRM: was loaded and obtained ownership of the NVIDIA device(s).\n");
        nv_printf(NV_DBG_ERRORS,
            "NVRM: Try unloading the conflicting kernel module (and/or\n"
            "NVRM: reconfigure your kernel without the conflicting\n"
            "NVRM: driver(s)), then try loading the NVIDIA kernel module\n"
            "NVRM: again.\n");
    }

    if (num_probed_nv_devices == 0)
    {
        rc = -ENODEV;
        nv_printf(NV_DBG_ERRORS, "NVRM: No NVIDIA graphics adapter probed!\n");
        goto failed2;
    }

    if (num_probed_nv_devices != num_nv_devices)
    {
        nv_printf(NV_DBG_ERRORS,
            "NVRM: The NVIDIA probe routine failed for %d device(s).\n",
            num_probed_nv_devices - num_nv_devices);
    }

    if (num_nv_devices == 0)
    {
        rc = -ENODEV;
        nv_printf(NV_DBG_ERRORS,
            "NVRM: None of the NVIDIA graphics adapters were initialized!\n");
        goto failed2;
    }

    nv_printf(NV_DBG_ERRORS, "NVRM: loading %s", pNVRM_ID);
    if (__nv_patches[0].short_description != NULL)
    {
        nv_printf(NV_DBG_ERRORS,
            " (applied patches: %s", __nv_patches[0].short_description);
        for (i = 1; __nv_patches[i].short_description; i++)
        {
            nv_printf(NV_DBG_ERRORS,
                ",%s", __nv_patches[i].short_description);
        }
        nv_printf(NV_DBG_ERRORS, ")");
    }
    nv_printf(NV_DBG_ERRORS, "\n");

    // init the nvidia control device
    nv->os_state = (void *) &nv_ctl_device;
    nv_lock_init_locks(nv);

    NV_KMEM_CACHE_CREATE(nv_pte_t_cache, NV_PTE_CACHE_STR, nv_pte_t);
    if (nv_pte_t_cache == NULL)
    {
        rc = -ENOMEM;
        nv_printf(NV_DBG_ERRORS, "NVRM: pte cache allocation failed\n");
        goto failed;
    }

    if (NV_BUILD_MODULE_INSTANCES == 0)
    {
        NV_KMEM_CACHE_CREATE(nvidia_p2p_page_t_cache, "nvidia_p2p_page_t",
                             nvidia_p2p_page_t);
        if (nvidia_p2p_page_t_cache == NULL)
        {
            rc = -ENOMEM;
            nv_printf(NV_DBG_ERRORS, 
                      "NVRM: p2p page cache allocation failed\n");
            goto failed;
        }
    }

#if defined(NV_SG_MAP_BUFFERS) && defined(NV_NEED_REMAP_CHECK)
    rm_read_registry_dword(sp, nv, "NVreg", "RemapLimit", &nv_remap_limit);

    // allow an override, but use default if no override
    if (nv_remap_limit == 0)
        nv_remap_limit = NV_REMAP_LIMIT_DEFAULT;

    nv_remap_count = 0;
#endif

#if !defined(NV_VMWARE) && \
  (defined(NVCPU_X86_64) || (defined(NVCPU_X86) && defined(CONFIG_X86_PAE)))
    if (boot_cpu_has(X86_FEATURE_NX))
    {
        NvU32 __eax, __edx;
        rdmsr(MSR_EFER, __eax, __edx);
        if ((__eax & EFER_NX) != 0)
            __nv_supported_pte_mask |= _PAGE_NX;
    }
    if (_PAGE_NX != ((NvU64)1<<63))
    {
        /*
         * Make sure we don't strip software no-execute
         * bits from PAGE_KERNEL(_NOCACHE) before calling
         * change_page_attr().
         */
        __nv_supported_pte_mask |= _PAGE_NX;
    }
#endif

    /*
     * Give users an opportunity to disable the driver's use of
     * the change_page_attr(), set_pages_{uc,wb}() and set_memory_{uc,wb}() kernel
     * interfaces.
     */
    status = rm_read_registry_dword(sp, nv,
            "NVreg", NV_REG_UPDATE_MEMORY_TYPES, &data);
    if ((status == RM_OK) && ((int)data != ~0))
    {
        nv_update_memory_types = data;
    }

#if defined(NV_CHANGE_PAGE_ATTR_BUG_PRESENT)
    /*
     * Unless we explicitely detect that the change_page_attr()
     * inteface is fixed, disable usage of the interface on
     * this kernel. Notify the user of this problem using the
     * driver's /proc warnings interface (read by the installer
     * and the bug report script).
     */
    else
    {
        rc = nv_verify_cpa_interface();
        if (rc < 0)
        {
            nv_prints(NV_DBG_ERRORS, __cpgattr_warning);
            nv_procfs_add_warning("change_page_attr", __cpgattr_warning);
            nv_update_memory_types = 0;
        }
        else if (rc != 0)
        {
            nv_prints(NV_DBG_ERRORS, __cpgattr_warning_2);
            nv_procfs_add_warning("change_page_attr", __cpgattr_warning_2);
            nv_update_memory_types = 0;
        }
    }
#endif /* defined(NV_CHANGE_PAGE_ATTR_BUG_PRESENT) */

#if defined(NVCPU_X86_64) && defined(CONFIG_IA32_EMULATION) && \
  !defined(NV_FILE_OPERATIONS_HAS_COMPAT_IOCTL)
    rm_register_compatible_ioctls(sp);
#endif

    rc = nv_init_pat_support(sp);
    if (rc < 0)
        goto failed;

    __nv_init_sp = sp;

    for (nvl = nv_linux_devices; nvl != NULL;  nvl = nvl->next)
    {
#if defined(NV_PM_VT_SWITCH_REQUIRED_PRESENT)
        pm_vt_switch_required(&nvl->dev->dev, NV_TRUE);
#endif
    }
    return 0;

failed:
    if (nvidia_p2p_page_t_cache != NULL)
        NV_KMEM_CACHE_DESTROY(nvidia_p2p_page_t_cache);

    if (nv_pte_t_cache != NULL)
        NV_KMEM_CACHE_DESTROY(nv_pte_t_cache);

    nv_unregister_chrdev((void *)&nv_fops);

failed2:
    while (nv_linux_devices != NULL)
    {
        nv_linux_state_t *tmp;
        if (nv_linux_devices->dev)
        {
            struct pci_dev *dev = nv_linux_devices->dev;
            release_mem_region(NV_PCI_RESOURCE_START(dev, NV_GPU_BAR_INDEX_REGS),
                               NV_PCI_RESOURCE_SIZE(dev, NV_GPU_BAR_INDEX_REGS));
            NV_PCI_DISABLE_DEVICE(dev);
            pci_set_drvdata(dev, NULL);
        }
        tmp = nv_linux_devices;
        nv_linux_devices = nv_linux_devices->next;
        NV_KFREE(tmp, sizeof(nv_linux_state_t));
    }

    nv_drm_exit(&nv_pci_driver);

failed3:
    if (nv_smu->handle != NULL)
    {
        struct pci_dev *dev = nv_smu->handle;
        rm_shutdown_smu(sp, nv_smu);
        release_mem_region(NV_PCI_RESOURCE_START(dev, 0),
                           NV_PCI_RESOURCE_SIZE(dev, 0));
        pci_disable_device(dev);
        pci_set_drvdata(dev, NULL);
        memset(&nv_smu_device, 0, sizeof(nv_smu_state_t));
    }

    pci_unregister_driver(&nv_pci_driver);

failed5:
    rm_shutdown_rm(sp);

    NV_KMEM_CACHE_FREE_STACK(sp);
    NV_KMEM_CACHE_DESTROY(nv_stack_t_cache);

failed4:
    nv_mem_pool_destroy();
    nv_heap_destroy();

    return rc;
}

void __exit nvidia_exit_module(void)
{
    nv_smu_state_t *nv_smu = &nv_smu_device;
    nv_stack_t *sp = __nv_init_sp;
    struct pci_dev *dev;

    nv_printf(NV_DBG_INFO, "NVRM: nvidia_exit_module\n");

    nv_drm_exit(&nv_pci_driver);

    if ((dev = (struct pci_dev *)(nv_smu->handle)) != NULL)
    {
        rm_shutdown_smu(sp, nv_smu);
        release_mem_region(NV_PCI_RESOURCE_START(dev, 0),
                           NV_PCI_RESOURCE_SIZE(dev, 0));
        pci_disable_device(dev);
        pci_set_drvdata(dev, NULL);
        memset(&nv_smu_device, 0, sizeof(nv_smu_state_t));
    }

    while (nv_linux_devices != NULL)
    {
        nv_linux_state_t *next = nv_linux_devices->next;

        if ((dev = nv_linux_devices->dev) != NULL)
        {
#if defined(NV_PM_VT_SWITCH_REQUIRED_PRESENT)
            pm_vt_switch_unregister(&dev->dev);
#endif
            nvidia_remove(dev);
        }
        nv_linux_devices = next;
    }

    pci_unregister_driver(&nv_pci_driver);

    /* remove /proc/driver/nvidia/... */
    nv_unregister_procfs();

    nv_unregister_chrdev((void *)&nv_fops);

#if defined(NV_LINUX_NVMAP_H_PRESENT) && defined(HAVE_NV_ANDROID)
    nv_nvmap_destroy_client();
#endif
    // Shutdown the resource manager
    rm_shutdown_rm(sp);

#if defined(NVCPU_X86_64) && defined(CONFIG_IA32_EMULATION) && \
  !defined(NV_FILE_OPERATIONS_HAS_COMPAT_IOCTL)
    rm_unregister_compatible_ioctls(sp);
#endif

    nv_teardown_pat_support();

#if defined(NV_ENABLE_MEM_TRACKING)
#if defined(VM_CHECKER)
    if (vm_usage != 0)
    {
        nv_list_mem("VM", vm_list);
        nv_printf(NV_DBG_ERRORS,
            "NVRM: final VM memory usage: 0x%x bytes\n", vm_usage);
    }
#endif
#if defined(KM_CHECKER)
    if (km_usage != 0)
    {
        nv_list_mem("KM", km_list);
        nv_printf(NV_DBG_ERRORS,
            "NVRM: final KM memory usage: 0x%x bytes\n", km_usage);
    }
#endif
#if defined(NV_SG_MAP_BUFFERS) && defined(NV_NEED_REMAP_CHECK)
    if (nv_remap_count != 0)
    {
        nv_printf(NV_DBG_ERRORS,
            "NVRM: final SG memory usage: 0x%x bytes\n", nv_remap_count);
    }
#endif
#endif /* NV_ENABLE_MEM_TRACKING */

    if (NV_BUILD_MODULE_INSTANCES == 0)
    {
        NV_KMEM_CACHE_DESTROY(nvidia_p2p_page_t_cache);
    }
    NV_KMEM_CACHE_DESTROY(nv_pte_t_cache);

    NV_KMEM_CACHE_FREE_STACK(sp);
    NV_KMEM_CACHE_DESTROY(nv_stack_t_cache);

    nv_mem_pool_destroy();
    nv_heap_destroy();
}


/* 
 * Module entry and exit functions for Linux single-module builds
 * are present in nv-frontend.c.
 */

#if defined(NV_VMWARE) || (NV_BUILD_MODULE_INSTANCES != 0)
module_init(nvidia_init_module);
module_exit(nvidia_exit_module);
#endif

void *nv_alloc_file_private(void)
{
    nv_file_private_t *nvfp;
    unsigned int i;

    NV_KMALLOC(nvfp, sizeof(nv_file_private_t));
    if (!nvfp)
        return NULL;

    memset(nvfp, 0, sizeof(nv_file_private_t));

    for (i = 0; i < NV_FOPS_STACK_INDEX_COUNT; ++i)
    {
        NV_INIT_MUTEX(&nvfp->fops_sp_lock[i]);
    }
    init_waitqueue_head(&nvfp->waitqueue);
    NV_SPIN_LOCK_INIT(&nvfp->fp_lock);

    return nvfp;
}

void nv_free_file_private(nv_file_private_t *nvfp)
{
    nvidia_event_t *nvet;

    if (nvfp == NULL)
        return;

    for (nvet = nvfp->event_head; nvet != NULL; nvet = nvfp->event_head)
    {
        nvfp->event_head = nvfp->event_head->next;
        NV_KFREE(nvet, sizeof(nvidia_event_t));
    }
    NV_KFREE(nvfp, sizeof(nv_file_private_t));
}


/*
** nvidia_open
**
** nv driver open entry point.  Sessions are created here.
*/
static int
nvidia_open(
    struct inode *inode,
    struct file *file
)
{
    nv_state_t *nv = NULL;
    nv_linux_state_t *nvl = NULL;
    NvU32 minor_num;
    int rc = 0;
    nv_file_private_t *nvfp = NULL;
    nv_stack_t *sp = NULL;
#if defined(NV_LINUX_PCIE_MSI_SUPPORTED)
    NvU32 msi_config = 0;
#endif
#if defined(NV_UVM_ENABLE) || defined(NV_UVM_NEXT_ENABLE)
    NvU8 *uuid;    
#endif
    unsigned int i;
    unsigned int k;

    nv_printf(NV_DBG_INFO, "NVRM: nvidia_open...\n");

    nvfp = nv_alloc_file_private();
    if (nvfp == NULL)
    {
        nv_printf(NV_DBG_ERRORS, "NVRM: failed to allocate file private!\n");
        return -ENOMEM;
    }

    NV_KMEM_CACHE_ALLOC_STACK(sp);
    if (sp == NULL)
    {
        nv_free_file_private(nvfp);
        nv_printf(NV_DBG_ERRORS, "NVRM: failed to allocate stack!\n");
        return -ENOMEM;
    }

    for (i = 0; i < NV_FOPS_STACK_INDEX_COUNT; ++i)
    {
        NV_KMEM_CACHE_ALLOC_STACK(nvfp->fops_sp[i]);
        if (nvfp->fops_sp[i] == NULL)
        {
            NV_KMEM_CACHE_FREE_STACK(sp);
            for (k = 0; k < i; ++k)
            {
                NV_KMEM_CACHE_FREE_STACK(nvfp->fops_sp[k]);
            }
            nv_free_file_private(nvfp);
            nv_printf(NV_DBG_ERRORS, "NVRM: failed to allocate stack[%d]\n", i);
            return -ENOMEM;
        }
    }

    /* what device are we talking about? */
    minor_num = NV_DEVICE_MINOR_NUMBER(inode);

    nvfp->minor_num = minor_num;

    NV_SET_FILE_PRIVATE(file, nvfp);
    nvfp->sp = sp;

    /* for control device, just jump to its open routine */
    /* after setting up the private data */
    if (NV_IS_CONTROL_DEVICE(inode))
    {
        rc = nvidia_ctl_open(inode, file);
        if (rc != 0)
            goto failed2;
        return rc;
    }

    LOCK_NV_LINUX_DEVICES();
    nvl = nv_linux_devices;
    while (nvl != NULL)
    {
        if (nvl->minor_num == minor_num)
            break;
        nvl = nvl->next;
    }

    if (nvl == NULL)
    {
        UNLOCK_NV_LINUX_DEVICES();
        rc = -ENODEV;
        goto failed2;
    }

    nv = NV_STATE_PTR(nvl);

    down(&nvl->ldata_lock);

    UNLOCK_NV_LINUX_DEVICES();

    if (IS_VGX_HYPER())
    {
        /* fail open if GPU is being unbound */
        if (nv->flags & NV_FLAG_UNBIND_LOCK)
        {
            rc = -ENODEV;
            nv_printf(NV_DBG_ERRORS, "NVRM: nvidia_open on device %04x:%02x:%02x.0"
                      " failed as GPU is locked for unbind operation\n",
                      nv->pci_info.domain, nv->pci_info.bus, nv->pci_info.slot);
            goto failed;
        }
    }

    nv_printf(NV_DBG_INFO, "NVRM: nvidia_open on device "
              "bearing minor number %d\n", minor_num);

    NV_CHECK_PCI_CONFIG_SPACE(sp, nv, TRUE, TRUE, NV_MAY_SLEEP());

    nvfp->nvptr = nvl;

    /*
     * map the memory and allocate isr on first open
     */

    if ( ! (nv->flags & NV_FLAG_OPEN))
    {
        if (nv->pci_info.device_id == 0)
        {
            nv_printf(NV_DBG_ERRORS, "NVRM: open of nonexistent "
                      "device bearing minor number %d\n", minor_num);
            rc = -ENXIO;
            goto failed;
        }

        if (!(nv->flags & NV_FLAG_PERSISTENT_SW_STATE))
        {
            NV_KMEM_CACHE_ALLOC_STACK(nvl->isr_sp);
            if (nvl->isr_sp == NULL)
            {
                rc = -ENOMEM;
                nv_printf(NV_DBG_ERRORS, "NVRM: failed to allocate stack!\n");
                goto failed;
            }

            NV_KMEM_CACHE_ALLOC_STACK(nvl->pci_cfgchk_sp);
            if (nvl->pci_cfgchk_sp == NULL)
            {
                rc = -ENOMEM;
                nv_printf(NV_DBG_ERRORS, "NVRM: failed to allocate stack!\n");
                goto failed;
            }

            NV_KMEM_CACHE_ALLOC_STACK(nvl->isr_bh_sp);
            if (nvl->isr_bh_sp == NULL)
            {
                rc = -ENOMEM;
                nv_printf(NV_DBG_ERRORS, "NVRM: failed to allocate stack!\n");
                goto failed;
            }

            NV_KMEM_CACHE_ALLOC_STACK(nvl->timer_sp);
            if (nvl->timer_sp == NULL)
            {
                rc = -ENOMEM;
                nv_printf(NV_DBG_ERRORS, "NVRM: failed to allocate stack!\n");
                goto failed;
            }
        }

#if defined(NV_LINUX_PCIE_MSI_SUPPORTED)
        if (!NV_IS_GVI_DEVICE(nv))
        {
            if (!(nv->flags & NV_FLAG_PERSISTENT_SW_STATE))
            {
                rm_read_registry_dword(sp, nv, "NVreg", NV_REG_ENABLE_MSI,
                                       &msi_config);
                if ((msi_config == 1) &&
                        (nv_find_pci_capability(nvl->dev, PCI_CAP_ID_MSI)))
                {
                    rc = pci_enable_msi(nvl->dev);
                    if (rc == 0)
                    {
                        nv->interrupt_line = nvl->dev->irq;
                        nv->flags |= NV_FLAG_USES_MSI;
                    }
                    else
                    {
                        nv->flags &= ~NV_FLAG_USES_MSI;
                        nv_printf(NV_DBG_ERRORS,
                                  "NVRM: failed to enable MSI, \n"
                                  "using PCIe virtual-wire interrupts.\n");
                    }
                }
            }
        }
#endif

        if (NV_IS_GVI_DEVICE(nv))
        {
            rc = request_irq(nv->interrupt_line, nv_gvi_kern_isr,
                             IRQF_SHARED, NV_DEV_NAME, (void *)nvl);
            if (rc == 0)
            {
                nvl->work.data = (void *)nvl;
                NV_TASKQUEUE_INIT(&nvl->work.task, nv_gvi_kern_bh,
                                  (void *)&nvl->work);
                rm_init_gvi_device(sp, nv);
                goto done;
            }
        }
        else
        {
            rc = 0;
            if (!(nv->flags & NV_FLAG_PERSISTENT_SW_STATE))
            {
                rc = request_irq(nv->interrupt_line, nvidia_isr, IRQF_SHARED,
                                 NV_DEV_NAME, (void *)nvl);
            }
        }
        if (rc != 0)
        {
            if ((nv->interrupt_line != 0) && (rc == -EBUSY))
            {
                nv_printf(NV_DBG_ERRORS,
                    "NVRM: Tried to get IRQ %d, but another driver\n",
                    (unsigned int) nv->interrupt_line);
                nv_printf(NV_DBG_ERRORS, "NVRM: has it and is not sharing it.\n");
                nv_printf(NV_DBG_ERRORS, "NVRM: You may want to verify that no audio driver");
                nv_printf(NV_DBG_ERRORS, " is using the IRQ.\n");
            }
            nv_printf(NV_DBG_ERRORS, "NVRM: request_irq() failed (%d)\n", rc);
            goto failed;
        }

        if (!(nv->flags & NV_FLAG_PERSISTENT_SW_STATE))
        {
            tasklet_init(&nvl->tasklet, nvidia_isr_bh, (NvUPtr)NV_STATE_PTR(nvl));
        }

        if (!rm_init_adapter(sp, nv))
        {
            if (!(nv->flags & NV_FLAG_PERSISTENT_SW_STATE))
            {
                tasklet_kill(&nvl->tasklet);
            }
            free_irq(nv->interrupt_line, (void *) nvl);
            nv_printf(NV_DBG_ERRORS, "NVRM: rm_init_adapter failed "
                      "for device bearing minor number %d\n", minor_num);
            rc = -EIO;
            goto failed;
        }

#if defined(NV_UVM_ENABLE) || defined(NV_UVM_NEXT_ENABLE)
        if (!NV_IS_GVI_DEVICE(nv))
        {
            if (rm_get_gpu_uuid_raw(sp, nv, &uuid, NULL) == RM_OK)
            {
                nv_uvm_notify_start_device(uuid);
                os_free_mem(uuid);
            }
        }
#endif
#if !defined(NV_VMWARE) && \
  (defined(NVCPU_X86) || defined(NVCPU_X86_64))
        if (nv->primary_vga && (screen_info.orig_video_isVGA != 0x01))
        {
            if (!nv_fbdev_failure_detected)
            {
                nv_prints(NV_DBG_ERRORS, __fbdev_warning);
                nv_procfs_add_warning("fbdev", __fbdev_warning);
            }
            nv_fbdev_failure_detected = 1;
        }
#endif

done:
        nv->flags |= NV_FLAG_OPEN;
    }

    NV_ATOMIC_INC(nvl->usage_count);

failed:
    if (rc != 0)
    {
#if defined(NV_LINUX_PCIE_MSI_SUPPORTED)
        if (nv->flags & NV_FLAG_USES_MSI)
        {
            nv->flags &= ~NV_FLAG_USES_MSI;
            NV_PCI_DISABLE_MSI(nvl->dev);
        }
#endif
        if (nvl->timer_sp != NULL)
            NV_KMEM_CACHE_FREE_STACK(nvl->timer_sp);
        if (nvl->isr_bh_sp != NULL)
            NV_KMEM_CACHE_FREE_STACK(nvl->isr_bh_sp);
        if (nvl->pci_cfgchk_sp != NULL)
            NV_KMEM_CACHE_FREE_STACK(nvl->pci_cfgchk_sp);
        if (nvl->isr_sp != NULL)
            NV_KMEM_CACHE_FREE_STACK(nvl->isr_sp);
    }
    up(&nvl->ldata_lock);
failed2:
    if (rc != 0)
    {
        if (nvfp != NULL)
        {
            NV_KMEM_CACHE_FREE_STACK(sp);
            for (i = 0; i < NV_FOPS_STACK_INDEX_COUNT; ++i)
            {
                NV_KMEM_CACHE_FREE_STACK(nvfp->fops_sp[i]);
            }
            nv_free_file_private(nvfp);
            NV_SET_FILE_PRIVATE(file, NULL);
        }
    }

    return rc;
}

/*
** nvidia_close
**
** Master driver close entry point.
*/

static int
nvidia_close(
    struct inode *inode,
    struct file *file
)
{
    nv_linux_state_t *nvl = NV_GET_NVL_FROM_FILEP(file);
    nv_state_t *nv = NV_STATE_PTR(nvl);
    nv_file_private_t *nvfp = NV_GET_FILE_PRIVATE(file);
    nv_stack_t *sp = nvfp->sp;
    unsigned int i;

    NV_CHECK_PCI_CONFIG_SPACE(sp, nv, TRUE, TRUE, NV_MAY_SLEEP());

    /* for control device, just jump to its open routine */
    /* after setting up the private data */
    if (NV_IS_CONTROL_DEVICE(inode))
        return nvidia_ctl_close(inode, file);

    nv_printf(NV_DBG_INFO, "NVRM: nvidia_close on device "
              "bearing minor number %d\n", NV_DEVICE_MINOR_NUMBER(inode));

    rm_free_unused_clients(sp, nv, nvfp);

    down(&nvl->ldata_lock);
    if (NV_ATOMIC_DEC_AND_TEST(nvl->usage_count))
    {
        if (NV_IS_GVI_DEVICE(nv))
        {
            rm_shutdown_gvi_device(sp, nv);
            NV_TASKQUEUE_FLUSH();
            free_irq(nv->interrupt_line, (void *)nvl);
        }
        else
        {
            rm_purge_mmap_contexts(sp, nv, NULL);
#if defined(NV_UVM_ENABLE) || defined(NV_UVM_NEXT_ENABLE)
            {
                NvU8 *uuid;
                // Inform UVM before disabling adapter
                if(rm_get_gpu_uuid_raw(sp, nv, &uuid, NULL) == RM_OK)
                {
                    // this function cannot fail
                    nv_uvm_notify_stop_device(uuid);
                    // get_uuid allocates memory for this call free it here
                    os_free_mem(uuid);
                }
            }
#endif
            if (nv->flags & NV_FLAG_PERSISTENT_SW_STATE)
            {
                rm_disable_adapter(sp, nv);
            }
            else
            {
                NV_SHUTDOWN_ADAPTER(sp, nv, nvl);
            }
        }

        if (!(nv->flags & NV_FLAG_PERSISTENT_SW_STATE))
        {
            NV_KMEM_CACHE_FREE_STACK(nvl->timer_sp);
            NV_KMEM_CACHE_FREE_STACK(nvl->isr_bh_sp);
            NV_KMEM_CACHE_FREE_STACK(nvl->pci_cfgchk_sp);
            NV_KMEM_CACHE_FREE_STACK(nvl->isr_sp);
        }

        /* leave INIT flag alone so we don't reinit every time */
        nv->flags &= ~NV_FLAG_OPEN;
    }
    up(&nvl->ldata_lock);

    for (i = 0; i < NV_FOPS_STACK_INDEX_COUNT; ++i)
    {
        NV_KMEM_CACHE_FREE_STACK(nvfp->fops_sp[i]);
    }

    nv_free_file_private(nvfp);
    NV_SET_FILE_PRIVATE(file, NULL);

    NV_KMEM_CACHE_FREE_STACK(sp);

    return 0;
}

static unsigned int
nvidia_poll(
    struct file *file,
    poll_table  *wait
)
{
    unsigned int mask = 0;
    nv_file_private_t *nvfp = NV_GET_FILE_PRIVATE(file);
    unsigned long eflags;

    if ((file->f_flags & O_NONBLOCK) == 0)
        poll_wait(file, &nvfp->waitqueue, wait);

    NV_SPIN_LOCK_IRQSAVE(&nvfp->fp_lock, eflags);

    if ((nvfp->event_head != NULL) || nvfp->event_pending)
    {
        mask = (POLLPRI | POLLIN);
        nvfp->event_pending = FALSE;
    }

    NV_SPIN_UNLOCK_IRQRESTORE(&nvfp->fp_lock, eflags);

    return mask;
}

#define NV_CTL_DEVICE_ONLY(nv)                 \
{                                              \
    if (((nv)->flags & NV_FLAG_CONTROL) == 0)  \
    {                                          \
        status = -EINVAL;                      \
        goto done;                             \
    }                                          \
}

static int
nvidia_ioctl(
    struct inode *inode,
    struct file *file,
    unsigned int cmd,
    unsigned long i_arg)
{
    RM_STATUS rmStatus;
    int status = 0;
    nv_linux_state_t *nvl = NV_GET_NVL_FROM_FILEP(file);
    nv_state_t *nv = NV_STATE_PTR(nvl);
    nv_file_private_t *nvfp = NV_GET_FILE_PRIVATE(file);
    nv_stack_t *sp = NULL;
    nv_ioctl_xfer_t ioc_xfer;
    void *arg_ptr = (void *) i_arg;
    void *arg_copy = NULL;
    size_t arg_size;
    int arg_cmd;

    nv_printf(NV_DBG_INFO, "NVRM: ioctl(0x%x, 0x%x, 0x%x)\n",
        _IOC_NR(cmd), (unsigned int) i_arg, _IOC_SIZE(cmd));

    down(&nvfp->fops_sp_lock[NV_FOPS_STACK_INDEX_IOCTL]);
    sp = nvfp->fops_sp[NV_FOPS_STACK_INDEX_IOCTL];

    NV_CHECK_PCI_CONFIG_SPACE(sp, nv, TRUE, TRUE, NV_MAY_SLEEP());

    arg_size = _IOC_SIZE(cmd);
    arg_cmd  = _IOC_NR(cmd);

    if (arg_cmd == NV_ESC_IOCTL_XFER_CMD)
    {
        if (arg_size != sizeof(nv_ioctl_xfer_t))
        {
            nv_printf(NV_DBG_ERRORS,
                    "NVRM: invalid ioctl XFER structure size!\n");
            status = -EINVAL;
            goto done;
        }

        if (NV_COPY_FROM_USER(&ioc_xfer, arg_ptr, sizeof(ioc_xfer)))
        {
            nv_printf(NV_DBG_ERRORS,
                    "NVRM: failed to copy in ioctl XFER data!\n");
            status = -EFAULT;
            goto done;
        }

        arg_cmd  = ioc_xfer.cmd;
        arg_size = ioc_xfer.size;
        arg_ptr  = NvP64_VALUE(ioc_xfer.ptr);

        if (arg_size > NV_ABSOLUTE_MAX_IOCTL_SIZE)
        {
            nv_printf(NV_DBG_ERRORS, "NVRM: invalid ioctl XFER size!\n");
            status = -EINVAL;
            goto done;
        }
    }

    NV_KMALLOC(arg_copy, arg_size);
    if (arg_copy == NULL)
    {
        nv_printf(NV_DBG_ERRORS, "NVRM: failed to allocate ioctl memory\n");
        status = -ENOMEM;
        goto done;
    }

    if (NV_COPY_FROM_USER(arg_copy, arg_ptr, arg_size))
    {
        nv_printf(NV_DBG_ERRORS, "NVRM: failed to copy in ioctl data!\n");
        status = -EFAULT;
        goto done;
    }

    switch (arg_cmd)
    {
        /* pass out info about the card */
        case NV_ESC_CARD_INFO:
        {
            nv_ioctl_card_info_t *ci;
            nv_linux_state_t *tnvl;
            nv_ioctl_rm_api_old_version_t *rm_api;

            NV_CTL_DEVICE_ONLY(nv);

            if (arg_size < (sizeof(*ci) * num_nv_devices))
            {
                status = -EINVAL;
                goto done;
            }

            /* the first element of card info passed from the client will have
             * the rm_api_version_magic value to show that the client is new
             * enough to support versioning. If the client is too old to
             * support versioning, our mmap interfaces are probably different
             * enough to cause serious damage.
             * just copy in the one dword to check.
             */
            rm_api = arg_copy;
            switch (rm_api->magic)
            {
                case NV_RM_API_OLD_VERSION_MAGIC_REQ:
                case NV_RM_API_OLD_VERSION_MAGIC_LAX_REQ:
                case NV_RM_API_OLD_VERSION_MAGIC_OVERRIDE_REQ:
                    /* the client is using the old major-minor-patch
                     * API version check; reject it.
                     */
                    nv_printf(NV_DBG_ERRORS,
                              "NVRM: API mismatch: the client has the version %d.%d-%d, but\n"
                              "NVRM: this kernel module has the version %s.  Please\n"
                              "NVRM: make sure that this kernel module and all NVIDIA driver\n"
                              "NVRM: components have the same version.\n",
                              rm_api->major, rm_api->minor, rm_api->patch,
                              NV_VERSION_STRING);
                    status = -EINVAL;
                    goto done;

                case NV_RM_API_OLD_VERSION_MAGIC_IGNORE:
                    /* the client is telling us to ignore the old
                     * version scheme; it will do a version check via
                     * NV_ESC_CHECK_VERSION_STR
                     */
                    break;
                default:
                    nv_printf(NV_DBG_ERRORS,
                        "NVRM: client does not support versioning!!\n");
                    status = -EINVAL;
                    goto done;
            }

            ci = arg_copy;
            memset(ci, 0, arg_size);
            LOCK_NV_LINUX_DEVICES();
            for (tnvl = nv_linux_devices; tnvl != NULL; tnvl = tnvl->next)
            {
                nv_state_t *tnv;
                tnv = NV_STATE_PTR(tnvl);
                if (tnv->pci_info.device_id)
                {
                    ci->flags = NV_IOCTL_CARD_INFO_FLAG_PRESENT;
                    ci->pci_info.domain = tnv->pci_info.domain;
                    ci->pci_info.bus = tnv->pci_info.bus;
                    ci->pci_info.slot = tnv->pci_info.slot;
                    ci->pci_info.vendor_id = tnv->pci_info.vendor_id;
                    ci->pci_info.device_id = tnv->pci_info.device_id;
                    ci->gpu_id = tnv->gpu_id;
                    ci->interrupt_line = tnv->interrupt_line;
                    ci->reg_address = tnv->regs->cpu_address;
                    ci->reg_size = tnv->regs->size;
                    ci->fb_address = tnv->fb->cpu_address;
                    ci->fb_size = tnv->fb->size;
                    ci->minor_number = tnvl->minor_num;
                    ci++;
                }
            }
            UNLOCK_NV_LINUX_DEVICES();
            break;
        }

        case NV_ESC_CHECK_VERSION_STR:
        {
            NV_CTL_DEVICE_ONLY(nv);

            rmStatus = rm_perform_version_check(sp, arg_copy, arg_size);
            status = ((rmStatus == RM_OK) ? 0 : -EINVAL);
            break;
        }

        default:
            rmStatus = rm_ioctl(sp, nv, nvfp, arg_cmd, arg_copy, arg_size);
            status = ((rmStatus == RM_OK) ? 0 : -EINVAL);
            break;
    }

done:
    up(&nvfp->fops_sp_lock[NV_FOPS_STACK_INDEX_IOCTL]);

    if (arg_copy != NULL)
    {
        if (status != -EFAULT)
        {
            if (NV_COPY_TO_USER(arg_ptr, arg_copy, arg_size))
            {
                nv_printf(NV_DBG_ERRORS, "NVRM: failed to copy out ioctl data\n");
                status = -EFAULT;
            }
        }
        NV_KFREE(arg_copy, arg_size);
    }

    return status;
}

static long
nvidia_unlocked_ioctl(
    struct file *file,
    unsigned int cmd,
    unsigned long i_arg
)
{
    return nvidia_ioctl(NV_FILE_INODE(file), file, cmd, i_arg);
}

/*
 * driver receives an interrupt
 *    if someone waiting, then hand it off.
 */
static irqreturn_t
nvidia_isr(
    int   irq,
    void *arg
#if !defined(NV_IRQ_HANDLER_T_PRESENT) || (NV_IRQ_HANDLER_T_ARGUMENT_COUNT == 3)
    ,struct pt_regs *regs
#endif
)
{
    nv_linux_state_t *nvl = (void *) arg;
    nv_state_t *nv = NV_STATE_PTR(nvl);
    NvU32 need_to_run_bottom_half = 0;
    BOOL rm_handled = FALSE,  uvm_handled = FALSE;

#if defined (NV_UVM_NEXT_ENABLE)
    //
    // Returns RM_OK if the UVM driver handled the interrupt
    // Returns RM_ERR_NO_INTR_PENDING if the interrupt is not for the UVM driver
    //
    if (nv_uvm_event_interrupt() == RM_OK)
        uvm_handled = TRUE;
#endif

    rm_handled = rm_isr(nvl->isr_sp, nv, &need_to_run_bottom_half);
    if (need_to_run_bottom_half)
    {
        tasklet_schedule(&nvl->tasklet);
    }

    return IRQ_RETVAL(rm_handled || uvm_handled);
}

static void
nvidia_isr_bh(
    unsigned long data
)
{
    nv_state_t *nv = (nv_state_t *) data;
    nv_linux_state_t *nvl = NV_GET_NVL_FROM_NV_STATE(nv);

    NV_CHECK_PCI_CONFIG_SPACE(nvl->isr_bh_sp, nv, TRUE, FALSE, FALSE);
    rm_isr_bh(nvl->isr_bh_sp, nv);
}

static void
nvidia_rc_timer(
    unsigned long data
)
{
    nv_linux_state_t *nvl = (nv_linux_state_t *) data;
    nv_state_t *nv = NV_STATE_PTR(nvl);

    NV_CHECK_PCI_CONFIG_SPACE(nvl->timer_sp, nv, TRUE, TRUE, FALSE);

    if (rm_run_rc_callback(nvl->timer_sp, nv) == RM_OK)
        mod_timer(&nvl->rc_timer, jiffies + HZ);  /* set another timeout in 1 second */
}

/*
** nvidia_ctl_open
**
** nv control driver open entry point.  Sessions are created here.
*/
static int
nvidia_ctl_open(
    struct inode *inode,
    struct file *file
)
{
    nv_linux_state_t *nvl = &nv_ctl_device;
    nv_state_t *nv = NV_STATE_PTR(nvl);
    nv_file_private_t *nvfp = NV_GET_FILE_PRIVATE(file);
    static int count = 0;

    nv_printf(NV_DBG_INFO, "NVRM: nvidia_ctl_open\n");

    down(&nvl->ldata_lock);

    /* save the nv away in file->private_data */
    nvfp->nvptr = nvl;

    if (NV_ATOMIC_READ(nvl->usage_count) == 0)
    {
        init_waitqueue_head(&nv_ctl_waitqueue);

        nv->flags |= (NV_FLAG_OPEN | NV_FLAG_CONTROL);

        if ((nv_acpi_init() < 0) &&
            (count++ < NV_MAX_RECURRING_WARNING_MESSAGES))
        {
            nv_printf(NV_DBG_ERRORS,
                "NVRM: failed to register with the ACPI subsystem!\n");
        }
    }

    NV_ATOMIC_INC(nvl->usage_count);
    up(&nvl->ldata_lock);

    return 0;
}


/*
** nvidia_ctl_close
*/
static int
nvidia_ctl_close(
    struct inode *inode,
    struct file *file
)
{
    nv_alloc_t *at, *next;
    nv_linux_state_t *nvl = NV_GET_NVL_FROM_FILEP(file);
    nv_state_t *nv = NV_STATE_PTR(nvl);
    nv_file_private_t *nvfp = NV_GET_FILE_PRIVATE(file);
    nv_stack_t *sp = nvfp->sp;
    static int count = 0;
    unsigned int i;

    nv_printf(NV_DBG_INFO, "NVRM: nvidia_ctl_close\n");

    down(&nvl->ldata_lock);
    if (NV_ATOMIC_DEC_AND_TEST(nvl->usage_count))
    {
        nv->flags &= ~NV_FLAG_OPEN;

        if ((nv_acpi_uninit() < 0) &&
            (count++ < NV_MAX_RECURRING_WARNING_MESSAGES))
        {
            nv_printf(NV_DBG_ERRORS,
                "NVRM: failed to unregister from the ACPI subsystem!\n");
        }
    }
    up(&nvl->ldata_lock);

    rm_purge_mmap_contexts(sp, nv, file);
    rm_free_unused_clients(sp, nv, nvfp);

    if (nvfp->free_list != NULL)
    {
        at = nvfp->free_list;
        while (at != NULL)
        {
            next = at->next;
            if (at->pid == os_get_current_process())
                NV_PRINT_AT(NV_DBG_MEMINFO, at);
            nv_free_pages(nv, at->num_pages,
                          NV_ALLOC_MAPPING_CONTIG(at->flags),
                          NV_ALLOC_MAPPING(at->flags),
                          (void *)at);
            at = next;
        }
    }

    for (i = 0; i < NV_FOPS_STACK_INDEX_COUNT; ++i)
    {
        NV_KMEM_CACHE_FREE_STACK(nvfp->fops_sp[i]);
    }

    nv_free_file_private(nvfp);
    NV_SET_FILE_PRIVATE(file, NULL);

    NV_KMEM_CACHE_FREE_STACK(sp);

    return 0;
}


void   NV_API_CALL  nv_set_dma_address_size(
    nv_state_t  *nv,
    NvU32       phys_addr_bits
)
{
    nv_linux_state_t *nvl;

    nvl = NV_GET_NVL_FROM_NV_STATE(nv);
    nvl->dev->dma_mask = (((u64)1) << phys_addr_bits) - 1;
}

#if defined(NV_VMAP_PRESENT)
static unsigned long
nv_map_guest_pages(nv_alloc_t *at,
                   NvU64 address,
                   NvU32 page_count,
                   NvU32 page_idx)
{
    struct page **pages;
    NvU32 j;
    unsigned long virt_addr;

    NV_KMALLOC(pages, sizeof(struct page *) * page_count);
    if (pages == NULL)
    {
        nv_printf(NV_DBG_ERRORS,
                  "NVRM: failed to allocate vmap() page descriptor table!\n");
        return 0;
    }

    for (j = 0; j < page_count; j++)
    {
        pages[j] = NV_GET_PAGE_STRUCT(at->page_table[page_idx+j]->phys_addr);
    }

    NV_VMAP(virt_addr, pages, page_count, NV_ALLOC_MAPPING_CACHED(at->flags));
    NV_KFREE(pages, sizeof(struct page *) * page_count);

    return virt_addr;
}
#endif

RM_STATUS NV_API_CALL
nv_alias_pages(
    nv_state_t *nv,
    NvU32 page_cnt,
    NvU32 contiguous,
    NvU32 cache_type,
    NvU64 guest_id,
    NvU64 *pte_array,
    void **priv_data
)
{
    nv_alloc_t *at;
    nv_linux_state_t *nvl = NV_GET_NVL_FROM_NV_STATE(nv);
    NvU32 i=0;
    nv_pte_t *page_ptr = NULL;

    at = nvos_create_alloc(nvl->dev, page_cnt);

    if (at == NULL)
    {
        return RM_ERR_NO_MEMORY;
    }

    at->flags = nv_alloc_init_flags(cache_type, contiguous, 0);
    at->flags |= NV_ALLOC_TYPE_GUEST;

    at->order = nv_calc_order(at->num_pages * PAGE_SIZE);

    for (i=0; i < at->num_pages; ++i)
    {
        page_ptr = at->page_table[i];

        if (contiguous && i>0)
        {
            page_ptr->dma_addr = pte_array[0] + (i << PAGE_SHIFT);
        }
        else
        {
            page_ptr->dma_addr  = pte_array[i];
        }

        page_ptr->phys_addr = page_ptr->dma_addr;

        /* aliased pages will be mapped on demand. */
        page_ptr->virt_addr = 0x0;
    }

    at->guest_id = guest_id;
    *priv_data = at;
    NV_ATOMIC_INC(at->usage_count);

    NV_PRINT_AT(NV_DBG_MEMINFO, at);

    return RM_OK;
}

void* NV_API_CALL nv_alloc_kernel_mapping(
    nv_state_t *nv,
    void       *pAllocPrivate,
    NvU64       pageIndex,
    NvU32       pageOffset,
    NvU64       size,
    void      **pPrivate
)
{
    nv_alloc_t *at = pAllocPrivate;
#if defined(NV_VMAP_PRESENT)
    NvU32 j, page_count;
    unsigned long virt_addr;
    struct page **pages;
#endif

    if (((size + pageOffset) <= PAGE_SIZE) &&
         !NV_ALLOC_MAPPING_GUEST(at->flags) && !NV_ALLOC_MAPPING_ALIASED(at->flags))
    {
        *pPrivate = NULL;
        return (void *)(at->page_table[pageIndex]->virt_addr + pageOffset);
    }
    else
    {
#if defined(NV_VMAP_PRESENT)
        size += pageOffset;
        page_count = (size >> PAGE_SHIFT) + ((size & ~NV_PAGE_MASK) ? 1 : 0);

        if (NV_ALLOC_MAPPING_GUEST(at->flags))
        {
            virt_addr = nv_map_guest_pages(at,
                                           nv->bars[NV_GPU_BAR_INDEX_REGS].cpu_address,
                                           page_count, pageIndex);
        }
        else
        {
            NV_KMALLOC(pages, sizeof(struct page *) * page_count);
            if (pages == NULL)
            {
                nv_printf(NV_DBG_ERRORS,
                          "NVRM: failed to allocate vmap() page descriptor table!\n");
                return NULL;
            }

            for (j = 0; j < page_count; j++)
              pages[j] = NV_GET_PAGE_STRUCT(at->page_table[pageIndex+j]->phys_addr);

            NV_VMAP(virt_addr, pages, page_count, NV_ALLOC_MAPPING_CACHED(at->flags));
            NV_KFREE(pages, sizeof(struct page *) * page_count);
        }

        if (virt_addr == 0)
        {
            nv_printf(NV_DBG_ERRORS, "NVRM: failed to map pages!\n");
            return NULL;
        }

        *pPrivate = (void *)(NvUPtr)page_count;
        return (void *)(virt_addr + pageOffset);
#else
        nv_printf(NV_DBG_ERRORS,
            "NVRM: This version of the Linux kernel does not provide the vmap()\n"
            "NVRM: kernel interface.  If you see this message, please update\n"
            "NVRM: your kernel to Linux 2.4.22 or install a distribution kernel\n"
            "NVRM: that supports the vmap() kernel interface.\n");
#endif
    }

    return NULL;
}

RM_STATUS NV_API_CALL nv_free_kernel_mapping(
    nv_state_t *nv,
    void       *pAllocPrivate,
    void       *address,
    void       *pPrivate
)
{
#if defined(NV_VMAP_PRESENT)
    nv_alloc_t *at = pAllocPrivate;
    unsigned long virt_addr;
    NvU32 page_count;

    virt_addr = ((NvUPtr)address & NV_PAGE_MASK);
    page_count = (NvUPtr)pPrivate;

    if (NV_ALLOC_MAPPING_GUEST(at->flags))
    {
        NV_IOUNMAP((void *)virt_addr, (page_count * PAGE_SIZE));
    }
    else if (pPrivate != NULL)
    {
        NV_VUNMAP(virt_addr, page_count);
    }
#endif
    return RM_OK;
}

RM_STATUS NV_API_CALL nv_alloc_pages(
    nv_state_t *nv,
    NvU32       page_count,
    NvBool      contiguous,
    NvU32       cache_type,
    NvBool      zeroed,
    NvU64      *pte_array,
    void      **priv_data
)
{
    nv_alloc_t *at;
    RM_STATUS status = RM_ERR_NO_MEMORY;
    nv_linux_state_t *nvl = NV_GET_NVL_FROM_NV_STATE(nv);
    NvU32 i, memory_type;

    nv_printf(NV_DBG_MEMINFO, "NVRM: VM: nv_alloc_pages: %d pages\n", page_count);
    nv_printf(NV_DBG_MEMINFO, "NVRM: VM:    contig %d  cache_type %d\n",
        contiguous, cache_type);

    memory_type = NV_MEMORY_TYPE_SYSTEM;

#if !defined(NV_VMWARE)
    if (nv_encode_caching(NULL, cache_type, memory_type))
        return RM_ERR_NOT_SUPPORTED;
#endif

    at = nvos_create_alloc(nvl->dev, page_count);
    if (at == NULL)
        return RM_ERR_NO_MEMORY;

    at->flags = nv_alloc_init_flags(cache_type, contiguous, zeroed);

    if (NV_ALLOC_MAPPING_CONTIG(at->flags))
        status = nv_alloc_contig_pages(nv, at);
    else
        status = nv_alloc_system_pages(nv, at);

    if (status != RM_OK)
        goto failed;

    for (i = 0; i < ((contiguous) ? 1 : page_count); i++)
        pte_array[i] = at->page_table[i]->dma_addr;

    *priv_data = at;
    NV_ATOMIC_INC(at->usage_count);

    NV_PRINT_AT(NV_DBG_MEMINFO, at);

    return RM_OK;

failed:
    nvos_free_alloc(at);

    return status;
}

RM_STATUS NV_API_CALL nv_free_pages(
    nv_state_t *nv,
    NvU32 page_count,
    NvBool contiguous,
    NvU32 cache_type,
    void *priv_data
)
{
    RM_STATUS rmStatus = RM_OK;
    nv_alloc_t *at = priv_data;

    nv_printf(NV_DBG_MEMINFO, "NVRM: VM: nv_free_pages: 0x%x\n", page_count);

    NV_PRINT_AT(NV_DBG_MEMINFO, at);

    /*
     * If the 'at' usage count doesn't drop to zero here, not all of
     * the user mappings have been torn down in time - we can't
     * safely free the memory. We report success back to the RM, but
     * defer the actual free operation until later.
     *
     * This is described in greater detail in the comments above the
     * nvidia_vma_(open|release)() callbacks in nv-mmap.c.
     */
    if (!NV_ATOMIC_DEC_AND_TEST(at->usage_count))
        return RM_OK;

    if (!NV_ALLOC_MAPPING_GUEST(at->flags))
    {
        if (NV_ALLOC_MAPPING_CONTIG(at->flags))
            nv_free_contig_pages(at);
        else
            nv_free_system_pages(at);
    }

    nvos_free_alloc(at);

    return rmStatus;
}

static void nv_lock_init_locks
(
    nv_state_t *nv
)
{
    nv_linux_state_t *nvl;
    nvl = NV_GET_NVL_FROM_NV_STATE(nv);

    NV_INIT_MUTEX(&nvl->ldata_lock);

    NV_ATOMIC_SET(nvl->usage_count, 0);
}

void NV_API_CALL nv_post_event(
    nv_state_t *nv,
    nv_event_t *event,
    NvU32       handle,
    NvU32       index,
    NvBool      data_valid
)
{
    nv_file_private_t *nvfp = event->file;
    unsigned long eflags;
    nvidia_event_t *nvet;

    NV_SPIN_LOCK_IRQSAVE(&nvfp->fp_lock, eflags);

    if (data_valid)
    {
        NV_KMALLOC_ATOMIC(nvet, sizeof(nvidia_event_t));
        if (nvet == NULL)
        {
            NV_SPIN_UNLOCK_IRQRESTORE(&nvfp->fp_lock, eflags);
            return;
        }

        if (nvfp->event_tail != NULL)
            nvfp->event_tail->next = nvet;
        if (nvfp->event_head == NULL)
            nvfp->event_head = nvet;
        nvfp->event_tail = nvet;
        nvet->next = NULL;

        nvet->event = *event;
        nvet->event.hObject = handle;
        nvet->event.index = index;
    }

    nvfp->event_pending = TRUE;
    wake_up_interruptible(&nvfp->waitqueue);

    NV_SPIN_UNLOCK_IRQRESTORE(&nvfp->fp_lock, eflags);
}

int NV_API_CALL nv_get_event(
    nv_state_t *nv,
    void       *file,
    nv_event_t *event,
    NvU32      *pending
)
{
    nv_file_private_t *nvfp = file;
    nvidia_event_t *nvet;
    unsigned long eflags;

    NV_SPIN_LOCK_IRQSAVE(&nvfp->fp_lock, eflags);

    nvet = nvfp->event_head;
    if (nvet == NULL)
    {
        NV_SPIN_UNLOCK_IRQRESTORE(&nvfp->fp_lock, eflags);
        return RM_ERROR;
    }

    *event = nvet->event;

    if (nvfp->event_tail == nvet)
        nvfp->event_tail = NULL;
    nvfp->event_head = nvet->next;

    *pending = (nvfp->event_head != NULL);

    NV_SPIN_UNLOCK_IRQRESTORE(&nvfp->fp_lock, eflags);

    NV_KFREE(nvet, sizeof(nvidia_event_t));

    return RM_OK;
}

int NV_API_CALL nv_start_rc_timer(
    nv_state_t *nv
)
{
    nv_linux_state_t *nvl = NV_GET_NVL_FROM_NV_STATE(nv);

    if (nv->rc_timer_enabled)
        return -1;

    nv_printf(NV_DBG_INFO, "NVRM: initializing rc timer\n");
    init_timer(&nvl->rc_timer);
    nvl->rc_timer.function = nvidia_rc_timer;
    nvl->rc_timer.data = (unsigned long) nvl;
    nv->rc_timer_enabled = 1;
    mod_timer(&nvl->rc_timer, jiffies + HZ); /* set our timeout for 1 second */
    nv_printf(NV_DBG_INFO, "NVRM: rc timer initialized\n");

    return 0;
}

int NV_API_CALL nv_stop_rc_timer(
    nv_state_t *nv
)
{
    nv_linux_state_t *nvl = NV_GET_NVL_FROM_NV_STATE(nv);

    if (!nv->rc_timer_enabled)
        return -1;

    nv_printf(NV_DBG_INFO, "NVRM: stopping rc timer\n");
    nv->rc_timer_enabled = 0;
    del_timer_sync(&nvl->rc_timer);
    nv_printf(NV_DBG_INFO, "NVRM: rc timer stopped\n");

    return 0;
}

static void
nvos_validate_assigned_gpus(struct pci_dev *dev)
{
    NvU32 i;

    if (NV_IS_ASSIGN_GPU_PCI_INFO_SPECIFIED())
    {
        for (i = 0; i < nv_assign_gpu_count; i++)
        {
            if ((nv_assign_gpu_pci_info[i].domain == NV_PCI_DOMAIN_NUMBER(dev)) &&
                (nv_assign_gpu_pci_info[i].bus == NV_PCI_BUS_NUMBER(dev)) &&
                (nv_assign_gpu_pci_info[i].slot == NV_PCI_SLOT_NUMBER(dev)))
            {
                nv_assign_gpu_pci_info[i].valid = NV_TRUE;
                return;
            }
        }
    }
}

/* make sure the pci_driver called probe for all of our devices.
 * we've seen cases where rivafb claims the device first and our driver
 * doesn't get called.
 */
static int
nvos_count_devices(nv_stack_t *sp)
{
    struct pci_dev *dev;
    int count = 0;

    dev = NV_PCI_GET_CLASS(PCI_CLASS_DISPLAY_VGA << 8, NULL);
    while (dev)
    {
        if ((dev->vendor == 0x10de) && (dev->device >= 0x20) &&
            !rm_is_legacy_device(sp, dev->device, TRUE))
        {
            count++;
            nvos_validate_assigned_gpus(dev);
        }
        dev = NV_PCI_GET_CLASS(PCI_CLASS_DISPLAY_VGA << 8, dev);
    }

    dev = NV_PCI_GET_CLASS(PCI_CLASS_DISPLAY_3D << 8, NULL);
    while (dev)
    {
        if ((dev->vendor == 0x10de) && (dev->device >= 0x20) &&
            !rm_is_legacy_device(sp, dev->device, TRUE))
        {
            count++;
            nvos_validate_assigned_gpus(dev);
        }
        dev = NV_PCI_GET_CLASS(PCI_CLASS_DISPLAY_3D << 8, dev);
    }

    dev = NV_PCI_GET_CLASS(PCI_CLASS_MULTIMEDIA_OTHER << 8, NULL);
    while (dev)
    {
        if ((dev->vendor == 0x10de) && (dev->device == 0x0e00))
            count++;
        dev = NV_PCI_GET_CLASS(PCI_CLASS_MULTIMEDIA_OTHER << 8, dev);
    }

    if (NV_IS_ASSIGN_GPU_PCI_INFO_SPECIFIED())
    {
        NvU32 i;

        for (i = 0; i < nv_assign_gpu_count; i++)
        {
            if (nv_assign_gpu_pci_info[i].valid == NV_TRUE)
                count++;
        }
    }

    return count;
}

/* find nvidia devices and set initial state */
static int
nvidia_probe
(
    struct pci_dev *dev,
    const struct pci_device_id *id_table
)
{
    nv_state_t *nv;
    nv_linux_state_t *nvl = NULL;
    unsigned int i, j;
    int flags = 0;
    nv_stack_t *sp = NULL;

    if (NV_IS_SMU_DEVICE(dev))
    {
        return nvidia_smu_probe(dev);
    }

    nv_printf(NV_DBG_SETUP, "NVRM: probing 0x%x 0x%x, class 0x%x\n",
        dev->vendor, dev->device, dev->class);

    if ((dev->class == (PCI_CLASS_MULTIMEDIA_OTHER << 8)) &&
        (dev->device == 0x0e00))
    {
        flags = NV_FLAG_GVI;
    }

    NV_KMEM_CACHE_ALLOC_STACK(sp);
    if (sp == NULL)
    {
        nv_printf(NV_DBG_ERRORS, "NVRM: failed to allocate stack!\n");
        return -1;
    }

    if (!(flags & NV_FLAG_GVI))
    {
        if ((dev->vendor != 0x10de) || (dev->device < 0x20) ||
            ((dev->class != (PCI_CLASS_DISPLAY_VGA << 8)) &&
             (dev->class != (PCI_CLASS_DISPLAY_3D << 8))) ||
            rm_is_legacy_device(sp, dev->device, FALSE))
        {
            nv_printf(NV_DBG_ERRORS, "NVRM: ignoring the legacy GPU %04x:%02x:%02x.%x\n",
                      NV_PCI_DOMAIN_NUMBER(dev), NV_PCI_BUS_NUMBER(dev), NV_PCI_SLOT_NUMBER(dev),
                      PCI_FUNC(dev->devfn));
            goto failed;
        }
    }

    if (NV_IS_ASSIGN_GPU_PCI_INFO_SPECIFIED())
    {
        for (i = 0; i < nv_assign_gpu_count; i++)
        {
            if (((nv_assign_gpu_pci_info[i].domain == NV_PCI_DOMAIN_NUMBER(dev)) &&
                 (nv_assign_gpu_pci_info[i].bus == NV_PCI_BUS_NUMBER(dev)) &&
                 (nv_assign_gpu_pci_info[i].slot == NV_PCI_SLOT_NUMBER(dev))) &&
                (nv_assign_gpu_pci_info[i].valid))
                break;
        }

        if (i == nv_assign_gpu_count)
        {
            goto failed;
        }
    }

    num_probed_nv_devices++;

    if (pci_enable_device(dev) != 0)
    {
        nv_printf(NV_DBG_ERRORS,
            "NVRM: pci_enable_device failed, aborting\n");
        goto failed;
    }

    if (dev->irq == 0)
    {
        nv_printf(NV_DBG_ERRORS, "NVRM: Can't find an IRQ for your NVIDIA card!\n");
        nv_printf(NV_DBG_ERRORS, "NVRM: Please check your BIOS settings.\n");
        nv_printf(NV_DBG_ERRORS, "NVRM: [Plug & Play OS] should be set to NO\n");
        nv_printf(NV_DBG_ERRORS, "NVRM: [Assign IRQ to VGA] should be set to YES \n");
        goto failed;
    }

    for (i = 0; i < (NV_GPU_NUM_BARS - 1); i++)
    {
        if (NV_PCI_RESOURCE_VALID(dev, i))
        {
#if defined(NV_PCI_MAX_MMIO_BITS_SUPPORTED)
            if ((NV_PCI_RESOURCE_FLAGS(dev, i) & PCI_BASE_ADDRESS_MEM_TYPE_64) &&
                ((NV_PCI_RESOURCE_START(dev, i) >> NV_PCI_MAX_MMIO_BITS_SUPPORTED)))
            {
                nv_printf(NV_DBG_ERRORS,
                    "NVRM: This is a 64-bit BAR mapped above %dGB by the system\n"
                    "NVRM: BIOS or the %s kernel. This PCI I/O region assigned\n"
                    "NVRM: to your NVIDIA device is not supported by the kernel.\n"
                    "NVRM: BAR%d is %dM @ 0x%llx (PCI:%04x:%02x:%02x.%x)\n",
                    (1 << (NV_PCI_MAX_MMIO_BITS_SUPPORTED - 30)),
                    NV_KERNEL_NAME, i,
                    (NV_PCI_RESOURCE_SIZE(dev, i) >> 20),
                    (NvU64)NV_PCI_RESOURCE_START(dev, i),
                    NV_PCI_DOMAIN_NUMBER(dev),
                    NV_PCI_BUS_NUMBER(dev), NV_PCI_SLOT_NUMBER(dev),
                    PCI_FUNC(dev->devfn));
                goto failed;
            }
#endif
#if !defined(NV_VMWARE)
            if ((NV_PCI_RESOURCE_FLAGS(dev, i) & PCI_BASE_ADDRESS_MEM_TYPE_64) &&
                (NV_PCI_RESOURCE_FLAGS(dev, i) & PCI_BASE_ADDRESS_MEM_PREFETCH))
            {
                struct pci_dev *bridge = dev->bus->self;
                NvU32 base_upper, limit_upper;

                if (bridge == NULL)
                    continue;

                pci_read_config_dword(dev, NVRM_PCICFG_BAR_OFFSET(i) + 4,
                        &base_upper);
                if (base_upper == 0)
                    continue;

                pci_read_config_dword(bridge, PCI_PREF_BASE_UPPER32,
                        &base_upper);
                pci_read_config_dword(bridge, PCI_PREF_LIMIT_UPPER32,
                        &limit_upper);

                if ((base_upper != 0) && (limit_upper != 0))
                    continue;

                nv_printf(NV_DBG_ERRORS,
                    "NVRM: This is a 64-bit BAR mapped above 4GB by the system\n"
                    "NVRM: BIOS or the %s kernel, but the PCI bridge\n"
                    "NVRM: immediately upstream of this GPU does not define\n"
                    "NVRM: a matching prefetchable memory window.\n",
                    NV_KERNEL_NAME);
                nv_printf(NV_DBG_ERRORS,
                    "NVRM: This may be due to a known Linux kernel bug.  Please\n"
                    "NVRM: see the README section on 64-bit BARs for additional\n"
                    "NVRM: information.\n");
                goto failed;
            }
#endif
                continue;
        }
        nv_printf(NV_DBG_ERRORS,
            "NVRM: This PCI I/O region assigned to your NVIDIA device is invalid:\n"
            "NVRM: BAR%d is %dM @ 0x%llx (PCI:%04x:%02x:%02x.%x)\n", i,
            (NV_PCI_RESOURCE_SIZE(dev, i) >> 20),
            (NvU64)NV_PCI_RESOURCE_START(dev, i),
            NV_PCI_DOMAIN_NUMBER(dev),
            NV_PCI_BUS_NUMBER(dev), NV_PCI_SLOT_NUMBER(dev), PCI_FUNC(dev->devfn));
#if defined(NVCPU_X86)
        if ((NV_PCI_RESOURCE_FLAGS(dev, i) & PCI_BASE_ADDRESS_MEM_TYPE_64) &&
            ((NV_PCI_RESOURCE_START(dev, i) >> PAGE_SHIFT) > 0xfffffULL))
        {
            nv_printf(NV_DBG_ERRORS,
                "NVRM: This is a 64-bit BAR mapped above 4GB by the system\n"
                "NVRM: BIOS or the Linux kernel.  The NVIDIA Linux/x86\n"
                "NVRM: graphics driver and other system software components\n"
                "NVRM: do not support this configuration.\n");
        }
        else
#endif
        if (NV_PCI_RESOURCE_FLAGS(dev, i) & PCI_BASE_ADDRESS_MEM_TYPE_64)
        {
            nv_printf(NV_DBG_ERRORS,
                "NVRM: This is a 64-bit BAR, which some operating system\n"
                "NVRM: kernels and other system software components are known\n"
                "NVRM: to handle incorrectly.  Please see the README section\n"
                "NVRM: on 64-bit BARs for more information.\n");
        }
        else
        {
            nv_printf(NV_DBG_ERRORS,
                "NVRM: The system BIOS may have misconfigured your GPU.\n");
        }
        goto failed;
    }

    if (!request_mem_region(NV_PCI_RESOURCE_START(dev, NV_GPU_BAR_INDEX_REGS),
                            NV_PCI_RESOURCE_SIZE(dev, NV_GPU_BAR_INDEX_REGS), NV_DEV_NAME))
    {
        nv_printf(NV_DBG_ERRORS,
            "NVRM: request_mem_region failed for %dM @ 0x%llx. This can\n"
            "NVRM: occur when a driver such as rivatv is loaded and claims\n"
            "NVRM: ownership of the device's registers.\n",
            (NV_PCI_RESOURCE_SIZE(dev, NV_GPU_BAR_INDEX_REGS) >> 20),
            (NvU64)NV_PCI_RESOURCE_START(dev, NV_GPU_BAR_INDEX_REGS));
        goto failed;
    }

    NV_KMALLOC(nvl, sizeof(nv_linux_state_t));
    if (nvl == NULL)
    {
        nv_printf(NV_DBG_ERRORS, "NVRM: failed to allocate memory\n");
        goto err_not_supported;
    }

    os_mem_set(nvl, 0, sizeof(nv_linux_state_t));

    nv  = NV_STATE_PTR(nvl);

    pci_set_drvdata(dev, (void *)nvl);

    /* default to 32-bit PCI bus address space */
    dev->dma_mask = 0xffffffffULL;

    nvl->dev               = dev;
    nv->pci_info.vendor_id = dev->vendor;
    nv->pci_info.device_id = dev->device;
    nv->subsystem_id       = dev->subsystem_device;
    nv->os_state           = (void *) nvl;
    nv->pci_info.domain    = NV_PCI_DOMAIN_NUMBER(dev);
    nv->pci_info.bus       = NV_PCI_BUS_NUMBER(dev);
    nv->pci_info.slot      = NV_PCI_SLOT_NUMBER(dev);
    nv->handle             = dev;
    nv->flags             |= flags;

    if (NVOS_IS_VMWARE)
    {
        nvl->minor_num     = num_nv_devices;
    }

    nv_lock_init_locks(nv);

    for (i = 0, j = 0; i < NVRM_PCICFG_NUM_BARS && j < NV_GPU_NUM_BARS; i++)
    {
        if ((NV_PCI_RESOURCE_VALID(dev, i)) &&
            (NV_PCI_RESOURCE_FLAGS(dev, i) & PCI_BASE_ADDRESS_SPACE)
                == PCI_BASE_ADDRESS_SPACE_MEMORY)
        {
            NvU32 bar = 0;
            nv->bars[j].offset = NVRM_PCICFG_BAR_OFFSET(i);
            pci_read_config_dword(dev, nv->bars[j].offset, &bar);
            nv->bars[j].bus_address = (bar & PCI_BASE_ADDRESS_MEM_MASK);
            if (NV_PCI_RESOURCE_FLAGS(dev, i) & PCI_BASE_ADDRESS_MEM_TYPE_64)
            {
                pci_read_config_dword(dev, nv->bars[j].offset + 4, &bar);
                nv->bars[j].bus_address |= (((NvU64)bar) << 32);
            }
            nv->bars[j].cpu_address = NV_PCI_RESOURCE_START(dev, i);
            nv->bars[j].strapped_size = NV_PCI_RESOURCE_SIZE(dev, i);
            nv->bars[j].size = nv->bars[j].strapped_size;
            j++;
        }
    }
    nv->regs = &nv->bars[NV_GPU_BAR_INDEX_REGS];
    nv->fb   = &nv->bars[NV_GPU_BAR_INDEX_FB];

    nv->interrupt_line = dev->irq;

    pci_set_master(dev);

#if defined(CONFIG_VGA_ARB)
#if defined(VGA_DEFAULT_DEVICE)
    vga_tryget(VGA_DEFAULT_DEVICE, VGA_RSRC_LEGACY_MASK);
#endif
    vga_set_legacy_decoding(dev, VGA_RSRC_NONE);
#endif

    if (rm_get_cpu_type(sp, &nv_cpu_type) != RM_OK)
        nv_printf(NV_DBG_ERRORS, "NVRM: error retrieving cpu type\n");
 
    if (NV_IS_GVI_DEVICE(nv))
    {
        if (!rm_gvi_init_private_state(sp, nv))
        {
            nv_printf(NV_DBG_ERRORS, "NVGVI: rm_init_gvi_private_state() failed!\n");
            goto err_not_supported;
        }

        if (rm_gvi_attach_device(sp, nv) != RM_OK)
        {
            rm_gvi_free_private_state(sp, nv);
            goto err_not_supported;
        }
    }
    else
    {
        NvU32 pmc_boot_0, pmc_boot_42;
        RM_STATUS status;

        NV_CHECK_PCI_CONFIG_SPACE(sp, nv, FALSE, TRUE, NV_MAY_SLEEP());

        if ((status = rm_is_supported_device(sp, nv, &pmc_boot_0, &pmc_boot_42)) != RM_OK)
        {
            if ((status != RM_ERR_NOT_SUPPORTED) ||
                !rm_is_legacy_arch(pmc_boot_0, pmc_boot_42))
            {
                nv_printf(NV_DBG_ERRORS,
                    "NVRM: The NVIDIA GPU %04x:%02x:%02x.%x (PCI ID: %04x:%04x)\n"
                    "NVRM: installed in this system is not supported by the %s\n"
                    "NVRM: NVIDIA %s driver release.  Please see 'Appendix\n"
                    "NVRM: A - Supported NVIDIA GPU Products' in this release's\n"
                    "NVRM: README, available on the %s driver download page\n"
                    "NVRM: at www.nvidia.com.\n",
                    nv->pci_info.domain, nv->pci_info.bus, nv->pci_info.slot,
                    PCI_FUNC(dev->devfn), nv->pci_info.vendor_id,
                    nv->pci_info.device_id, NV_VERSION_STRING, NV_KERNEL_NAME,
                    NV_KERNEL_NAME);
            }
            goto err_not_supported;
        }

        if (!rm_init_private_state(sp, nv))
        {
            nv_printf(NV_DBG_ERRORS, "NVRM: rm_init_private_state() failed!\n");
            goto err_zero_dev;
        }
    }

    nv_printf(NV_DBG_INFO,
              "NVRM: PCI:%04x:%02x:%02x.%x (%04x:%04x): BAR0 @ 0x%llx (%lluMB)\n",
              nv->pci_info.domain, nv->pci_info.bus, nv->pci_info.slot,
              PCI_FUNC(dev->devfn), nv->pci_info.vendor_id, nv->pci_info.device_id,
              nv->regs->cpu_address, (nv->regs->size >> 20));
    nv_printf(NV_DBG_INFO,
              "NVRM: PCI:%04x:%02x:%02x.%x (%04x:%04x): BAR1 @ 0x%llx (%lluMB)\n",
              nv->pci_info.domain, nv->pci_info.bus, nv->pci_info.slot,
              PCI_FUNC(dev->devfn), nv->pci_info.vendor_id, nv->pci_info.device_id,
              nv->fb->cpu_address, (nv->fb->size >> 20));

    num_nv_devices++;

    for (i = 0; i < NV_GPU_NUM_BARS; i++)
    {
        if (nv->bars[i].size != 0)
        {
            if (nv_user_map_register(nv->bars[i].cpu_address,
                nv->bars[i].strapped_size) != 0)
            {
                nv_printf(NV_DBG_ERRORS,
                          "NVRM: failed to register usermap for BAR %u!\n", i);
                for (j = 0; j < i; j++)
                {
                    nv_user_map_unregister(nv->bars[j].cpu_address,
                                           nv->bars[j].strapped_size);
                }
                goto err_zero_dev;
            }
        }
    }

    /*
     * The newly created nvl object is added to the nv_linux_devices global list
     * only after all the initialization operations for that nvl object are
     * completed, so as to protect against simultaneous lookup operations which
     * may discover a partially initialized nvl object in the list
     */
    LOCK_NV_LINUX_DEVICES();
    if (nv_linux_devices == NULL)
        nv_linux_devices = nvl;
    else
    {
        nv_linux_state_t *tnvl;
        for (tnvl = nv_linux_devices; tnvl->next != NULL;  tnvl = tnvl->next);
        tnvl->next = nvl;
    }
    UNLOCK_NV_LINUX_DEVICES();
#if !defined(NV_VMWARE)
    if (nvidia_frontend_add_device((void *)&nv_fops, nvl) != 0) 
        goto err_zero_dev;
#endif
    nv_procfs_add_gpu(nvl);

    NV_KMEM_CACHE_FREE_STACK(sp);

    return 0;

err_zero_dev:
    rm_free_private_state(sp, nv);
err_not_supported:
    if (nvl != NULL)
    {
        NV_KFREE(nvl, sizeof(nv_linux_state_t));
    }
    release_mem_region(NV_PCI_RESOURCE_START(dev, NV_GPU_BAR_INDEX_REGS),
                       NV_PCI_RESOURCE_SIZE(dev, NV_GPU_BAR_INDEX_REGS));
    NV_PCI_DISABLE_DEVICE(dev);
    pci_set_drvdata(dev, NULL);
failed:
    NV_KMEM_CACHE_FREE_STACK(sp);
    return -1;
}

void nvidia_remove(struct pci_dev *dev)
{
    nv_linux_state_t *nvl = NULL;
    nv_state_t *nv;
    nv_stack_t *sp = NULL;
    NvU32 i;

    nv_printf(NV_DBG_SETUP, "NVRM: removing GPU %04x:%02x:%02x.%x\n",
              NV_PCI_DOMAIN_NUMBER(dev), NV_PCI_BUS_NUMBER(dev),
              NV_PCI_SLOT_NUMBER(dev), PCI_FUNC(dev->devfn));

    if (NV_IS_SMU_DEVICE(dev))
    {
        return;
    }

    NV_KMEM_CACHE_ALLOC_STACK(sp);
    if (sp == NULL)
    {
        nv_printf(NV_DBG_ERRORS, "NVRM: %s failed to allocate stack!\n", __FUNCTION__);
        return;
    }

    LOCK_NV_LINUX_DEVICES();
    nvl = pci_get_drvdata(dev);
    if (!nvl || (nvl->dev != dev))
    {
        goto done;
    }

    nv = NV_STATE_PTR(nvl);
    if (nvl == nv_linux_devices)
        nv_linux_devices = nvl->next;
    else
    {
        nv_linux_state_t *tnvl;
        for (tnvl = nv_linux_devices; tnvl->next != nvl;  tnvl = tnvl->next);
        tnvl->next = nvl->next;
    }

    /* Remove proc entry for this GPU */
    nv_procfs_remove_gpu(nvl);

    down(&nvl->ldata_lock);
    UNLOCK_NV_LINUX_DEVICES();

#if !defined(NV_VMWARE)
    /* Update the frontend data structures */
    nvidia_frontend_remove_device((void *)&nv_fops, nvl);
#endif

#if defined(NV_UVM_ENABLE) || defined(NV_UVM_NEXT_ENABLE)
    if (!NV_IS_GVI_DEVICE(nv))
    {
        NvU8 *uuid;
        // Inform UVM before disabling adapter
        if(rm_get_gpu_uuid_raw(sp, nv, &uuid, NULL) == RM_OK)
        {
            // this function cannot fail
            nv_uvm_notify_stop_device(uuid);
            // get_uuid allocates memory for this call free it here
            os_free_mem(uuid);
        }
    }
#endif

    if ((nv->flags & NV_FLAG_PERSISTENT_SW_STATE) || (nv->flags & NV_FLAG_OPEN))
    {
        if (nv->flags & NV_FLAG_PERSISTENT_SW_STATE)
        {
            rm_disable_gpu_state_persistence(sp, nv);
        }
        NV_SHUTDOWN_ADAPTER(sp, nv, nvl);
        NV_KMEM_CACHE_FREE_STACK(nvl->timer_sp);
        NV_KMEM_CACHE_FREE_STACK(nvl->isr_bh_sp);
        NV_KMEM_CACHE_FREE_STACK(nvl->pci_cfgchk_sp);
        NV_KMEM_CACHE_FREE_STACK(nvl->isr_sp);
    }

    num_probed_nv_devices--;

    pci_set_drvdata(dev, NULL);

    if (NV_IS_GVI_DEVICE(nv))
    {
        NV_TASKQUEUE_FLUSH();
        rm_gvi_detach_device(sp, nv);
        rm_gvi_free_private_state(sp, nv);
    }
    else
    {
        for (i = 0; i < NV_GPU_NUM_BARS; i++)
        {
            if (nv->bars[i].size != 0)
            {
                nv_user_map_unregister(nv->bars[i].cpu_address,
                                       nv->bars[i].strapped_size);
            }
        }
        rm_i2c_remove_adapters(sp, nv);
        rm_free_private_state(sp, nv);
    }
    release_mem_region(NV_PCI_RESOURCE_START(dev, NV_GPU_BAR_INDEX_REGS),
                       NV_PCI_RESOURCE_SIZE(dev, NV_GPU_BAR_INDEX_REGS));
    NV_PCI_DISABLE_DEVICE(dev);
    num_nv_devices--;

    NV_KFREE(nvl, sizeof(nv_linux_state_t));
    NV_KMEM_CACHE_FREE_STACK(sp);
    return;

done:
    UNLOCK_NV_LINUX_DEVICES();
    NV_KMEM_CACHE_FREE_STACK(sp);
}

static int
nvidia_smu_probe
(
    struct pci_dev *dev
)
{
    nv_smu_state_t *nv = &nv_smu_device;

    nv_printf(NV_DBG_SETUP, "NVRM: probing 0x%x 0x%x, class 0x%x\n",
        dev->vendor, dev->device, dev->class);

    if ((dev->vendor != 0x10de) ||
        (dev->class != (PCI_CLASS_PROCESSOR_CO << 8)) ||
        (dev->device != NV_PCI_DEVICE_ID_SMU))
    {
        nv_printf(NV_DBG_INFO, "NVRM: ignoring the SMU %04x:%02x:%02x.%x\n",
                  NV_PCI_DOMAIN_NUMBER(dev), NV_PCI_BUS_NUMBER(dev),
                  NV_PCI_SLOT_NUMBER(dev), PCI_FUNC(dev->devfn));
        goto failed;
    }

    if (nv->handle != NULL)
    {
        nv_printf(NV_DBG_INFO,
            "NVRM: More than one SMU device? Driver not yet designed to handle this case\n");
        goto failed;
    }

    if (pci_enable_device(dev) != 0)
    {
        nv_printf(NV_DBG_INFO,
            "NVRM: pci_enable_device for SMU device failed, aborting\n");
        goto failed;
    }

    // validate BAR0
    if (!NV_PCI_RESOURCE_VALID(dev, 0))
    {
        nv_printf(NV_DBG_INFO,
            "NVRM: This PCI I/O region assigned to the SMU device is invalid:\n"
            "NVRM: BAR0 is %dM @ 0x%08x (PCI:%04x:%02x:%02x.%x)\n",
            NV_PCI_RESOURCE_SIZE(dev, 0) >> 20, NV_PCI_RESOURCE_START(dev, 0),
            NV_PCI_DOMAIN_NUMBER(dev), NV_PCI_BUS_NUMBER(dev),
            NV_PCI_SLOT_NUMBER(dev), PCI_FUNC(dev->devfn));
        goto failed;
    }

    if (!request_mem_region(NV_PCI_RESOURCE_START(dev, 0),
                            NV_PCI_RESOURCE_SIZE(dev, 0), NV_DEV_NAME))
    {
        nv_printf(NV_DBG_INFO,
            "NVRM: request_mem_region failed for %dM @ 0x%08x.\n",
            NV_PCI_RESOURCE_SIZE(dev, 0) >> 20,
            NV_PCI_RESOURCE_START(dev, 0));

        goto failed;
    }

    pci_set_drvdata(dev, (void *)nv);

    /* default to 32-bit PCI bus address space */
    dev->dma_mask = 0xffffffffULL;

    nv->pci_info.vendor_id     = dev->vendor;
    nv->pci_info.device_id     = dev->device;
    nv->pci_info.domain        = NV_PCI_DOMAIN_NUMBER(dev);
    nv->pci_info.bus           = NV_PCI_BUS_NUMBER(dev);
    nv->pci_info.slot          = NV_PCI_SLOT_NUMBER(dev);
    nv->handle                 = dev;

    if ((NV_PCI_RESOURCE_VALID(dev, 0)) &&
        (NV_PCI_RESOURCE_FLAGS(dev, 0) & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_MEMORY)
    {
        nv->bar0.cpu_address = NV_PCI_RESOURCE_START(dev, 0);
        nv->bar0.size        = NV_PCI_RESOURCE_SIZE(dev, 0);
        nv->bar0.offset      = NVRM_PCICFG_BAR_OFFSET(0);
    }

    nv->regs = &nv->bar0;

    nv_printf(NV_DBG_INFO, "NVRM: %04x:%02x:%02x.%x %04x:%04x - 0x%08x [size=%dK]\n",
              nv->pci_info.domain, nv->pci_info.bus, nv->pci_info.slot,
              PCI_FUNC(dev->devfn), nv->pci_info.vendor_id, nv->pci_info.device_id,
              nv->regs->cpu_address, nv->regs->size / (1024));

    return 0;

failed:
    return -1;
}

int NV_API_CALL nv_no_incoherent_mappings(void)
{
    return (nv_update_memory_types);
}

#if defined(NV_PM_SUPPORT_DEVICE_DRIVER_MODEL)

static int
nv_power_management(
    struct pci_dev *dev,
    u32 pci_state,
    u32 power_state
)
{
    nv_state_t *nv;
    nv_linux_state_t *lnv = NULL;
    int status = RM_OK;
    nv_stack_t *sp = NULL;

    nv_printf(NV_DBG_INFO, "NVRM: nv_power_management: %d\n", pci_state);
    lnv = pci_get_drvdata(dev);

    if (!lnv || (lnv->dev != dev))
    {
        nv_printf(NV_DBG_WARNINGS, "NVRM: PM: invalid device!\n");
        return -1;
    }

    NV_KMEM_CACHE_ALLOC_STACK(sp);
    if (sp == NULL)
    {
        nv_printf(NV_DBG_ERRORS, "NVRM: failed to allocate stack!\n");
        return -1;
    }

    nv = NV_STATE_PTR(lnv);
    NV_CHECK_PCI_CONFIG_SPACE(sp, nv, TRUE, TRUE, NV_MAY_SLEEP());

    switch (pci_state)
    {
         case PCI_D3hot:
            nv_printf(NV_DBG_INFO, "NVRM: ACPI: received suspend event\n");
            status = rm_power_management(sp, nv, 0, power_state);
            tasklet_kill(&lnv->tasklet);
            nv_disable_pat_support();
            nv_pci_save_state(dev);
            break;

        case PCI_D0:
            nv_printf(NV_DBG_INFO, "NVRM: ACPI: received resume event\n");
            nv_pci_restore_state(dev);
            nv_enable_pat_support();
            tasklet_init(&lnv->tasklet, nvidia_isr_bh, (NvUPtr)NV_STATE_PTR(lnv));
            status = rm_power_management(sp, nv, 0, power_state);
            break;

        default:
            nv_printf(NV_DBG_WARNINGS, "NVRM: PM: unsupported event: %d\n", pci_state);
            status = -1;
    }

    NV_KMEM_CACHE_FREE_STACK(sp);

    if (status != RM_OK)
        nv_printf(NV_DBG_ERRORS, "NVRM: PM: failed event: %d\n", pci_state);

    return status;
}

static int
nvidia_suspend(
    struct pci_dev *dev,
    pm_message_t state
)
{
    int pci_state = -1;
    u32 power_state;
    nv_state_t *nv;
    nv_linux_state_t *lnv = NULL;

    if (NV_IS_SMU_DEVICE(dev))
    {
        return nvidia_smu_suspend();
    }

    lnv = pci_get_drvdata(dev);

    if (!lnv || (lnv->dev != dev))
    {
        nv_printf(NV_DBG_WARNINGS, "NVRM: PM: invalid device!\n");
        return -1;
    }

    nv = NV_STATE_PTR(lnv);

    if (NV_IS_GVI_DEVICE(nv))
    {
        return nv_gvi_kern_suspend(dev, state);
    }

#if !defined(NV_PM_MESSAGE_T_PRESENT)
    pci_state = state;
#elif defined(NV_PCI_CHOOSE_STATE_PRESENT)
    pci_state = PCI_D3hot;
#endif

    power_state = NV_PM_ACPI_STANDBY;

#if defined(NV_PM_MESSAGE_T_HAS_EVENT)
    if (state.event == PM_EVENT_FREEZE) /* for hibernate */
        power_state = NV_PM_ACPI_HIBERNATE;
#endif

    return nv_power_management(dev, pci_state, power_state);
}

static int
nvidia_smu_suspend(void)
{
    nv_stack_t *sp = NULL;

    NV_KMEM_CACHE_ALLOC_STACK(sp);
    if (sp == NULL)
    {
        nv_printf(NV_DBG_ERRORS, "NVRM: failed to allocate stack!\n");
        return RM_ERR_NO_MEMORY;
    }

    rm_suspend_smu(sp);

    NV_KMEM_CACHE_FREE_STACK(sp);

    return 0;
}

static int
nvidia_resume(
    struct pci_dev *dev
)
{
    nv_state_t *nv;
    nv_linux_state_t *lnv = NULL;

    if (NV_IS_SMU_DEVICE(dev))
    {
        return nvidia_smu_resume();
    }

    lnv = pci_get_drvdata(dev);

    if (!lnv || (lnv->dev != dev))
    {
        nv_printf(NV_DBG_WARNINGS, "NVRM: PM: invalid device!\n");
        return -1;
    }

    nv = NV_STATE_PTR(lnv);

    if (NV_IS_GVI_DEVICE(nv))
    {
        return nv_gvi_kern_resume(dev);
    }

    return nv_power_management(dev, PCI_D0, NV_PM_ACPI_RESUME);
}

static int
nvidia_smu_resume(void)
{
    nv_stack_t *sp = NULL;

    NV_KMEM_CACHE_ALLOC_STACK(sp);
    if (sp == NULL)
    {
        nv_printf(NV_DBG_ERRORS, "NVRM: failed to allocate stack!\n");
        return RM_ERR_NO_MEMORY;
    }

    rm_resume_smu(sp);

    NV_KMEM_CACHE_FREE_STACK(sp);

    return 0;
}

#endif /* defined(NV_PM_SUPPORT_DEVICE_DRIVER_MODEL) */

#if defined(NV_PCI_ERROR_RECOVERY)
static pci_ers_result_t
nvidia_pci_error_detected(
    struct pci_dev *dev,
    enum pci_channel_state error
)
{
    nv_linux_state_t *nvl = NULL;

    nvl = pci_get_drvdata(dev);

    if ((nvl == NULL) || (nvl->dev != dev))
    {
        nv_printf(NV_DBG_ERRORS, "NVRM: %s: invalid device!\n", __FUNCTION__);
        return PCI_ERS_RESULT_NONE;
    }

    /*
     * TODO: See bug 1516040
     *
     * Collect driver state. Both MMIO and DMA (bus master) are disabled
     * during this callback, so we can't interact with GPU yet.
     */

    /*
     * Tell Linux to continue recovery of the device. The kernel will enable
     * MMIO for the GPU and call the mmio_enabled callback.
     */
    return PCI_ERS_RESULT_CAN_RECOVER;
}

static void
nv_print_buffer(
    NvU8    *buf,
    NvU32    size
)
{
    NvU32      size_count;
    NvU8       byte_count;
    const NvU8 bytes_per_line = 16;

    for (size_count = 0; size_count < size; size_count += bytes_per_line)
    {
        nv_printf(NV_DBG_ERRORS, "NVRM:   ");
        for (byte_count = 0;
             (byte_count < bytes_per_line) && (size_count + byte_count < size);
             byte_count++)
        {
            if (byte_count > 0 && ((byte_count % 4) == 0))
                nv_printf(NV_DBG_ERRORS, " ");

            nv_printf(NV_DBG_ERRORS, "%02X", buf[size_count + byte_count]);
        }

        nv_printf(NV_DBG_ERRORS, "\n");
    }
}

static pci_ers_result_t
nvidia_pci_mmio_enabled(
    struct pci_dev *dev
)
{
    RM_STATUS         status = RM_OK;
    nv_stack_t       *sp = NULL;
    nv_linux_state_t *nvl = NULL;
    nv_state_t       *nv = NULL;
    NvU32             size = NV_PCI_ERS_BUFFER_SIZE;
    void             *buf = NULL;

    nvl = pci_get_drvdata(dev);

    if ((nvl == NULL) || (nvl->dev != dev))
    {
        nv_printf(NV_DBG_ERRORS, "NVRM: %s: invalid device!\n", __FUNCTION__);
        goto done;
    }

    /* allocate memory to hold debug data for logging */
    if (os_alloc_mem(&buf, size) != RM_OK)
    {
        nv_printf(NV_DBG_ERRORS,
            "NVRM: %s: failed to allocate PCI ERS buffer!\n", __FUNCTION__);
        goto done;
    }

    NV_KMEM_CACHE_ALLOC_STACK(sp);
    if (sp == NULL)
    {
        nv_printf(NV_DBG_ERRORS, "NVRM: %s: failed to allocate stack!\n",
            __FUNCTION__);
        goto done;
    }

    /* collect the debug data to be logged */
    nv = NV_STATE_PTR(nvl);
    status = rm_get_gpu_debug_data(sp, nv, buf, &size);
    if (status != RM_OK)
    {
        nv_printf(NV_DBG_ERRORS,
            "NVRM: %s: failed to gather PCI ERS data! (0x%x)\n",
            __FUNCTION__, status);
        goto done;
    }

    /* dump the encoded debug data to syslog */
    nv_printf(NV_DBG_ERRORS,
        "NVRM: %s: PCI Error data (size %u bytes):\n", __FUNCTION__, size);
    nv_print_buffer((NvU8 *)buf, size);

done:
    if (buf != NULL)
    {
        if (sp != NULL)
        {
            NV_KMEM_CACHE_FREE_STACK(sp);
        }

        os_free_mem(buf);
    }

    /*
     * Tell Linux to abandon recovery of the device. The kernel might be able
     * to recover the device, but RM and clients don't yet support that.
     */
    return PCI_ERS_RESULT_DISCONNECT;
}
#endif

void* NV_API_CALL nv_get_adapter_state(
    NvU32 domain,
    NvU8  bus,
    NvU8  slot
)
{
    nv_linux_state_t *nvl;

    LOCK_NV_LINUX_DEVICES();
    for (nvl = nv_linux_devices; nvl != NULL;  nvl = nvl->next)
    {
        nv_state_t *nv = NV_STATE_PTR(nvl);
        if (nv->pci_info.domain == domain && nv->pci_info.bus == bus
            && nv->pci_info.slot == slot)
        {
            UNLOCK_NV_LINUX_DEVICES();
            return (void *) nv;
        }
    }
    UNLOCK_NV_LINUX_DEVICES();

    if (NV_PCI_MATCH_CTL_DEVICE(domain, bus, slot))
    {
        nv_state_t *nv = NV_STATE_PTR(&nv_ctl_device);
        return (void *) nv;
    }

    return NULL;
}

void* NV_API_CALL nv_get_smu_state(void)
{
    nv_smu_state_t *nv_smu = &nv_smu_device;

    if (nv_smu->handle == NULL)
    {
        return NULL;
    }

    return nv_smu;
}

RM_STATUS NV_API_CALL nv_log_error(
    nv_state_t *nv,
    NvU32       error_number,
    const char *format,
    va_list    ap
)
{
    RM_STATUS status = RM_OK;
#if defined(CONFIG_CRAY_XT)
    nv_linux_state_t *nvl = NV_GET_NVL_FROM_NV_STATE(nv);
    if (ap != NULL)
    {
        status = nvos_forward_error_to_cray(nvl->dev, error_number,
                format, ap);
    }
#endif
    return status;
}

NvU64 NV_API_CALL nv_get_dma_start_address(
    nv_state_t *nv
)
{
    NvU64 start = 0;
#if defined(NVCPU_PPC64LE)
    struct pci_controller *host;
    nv_linux_state_t      *nvl;
    struct pci_dev        *dev;
    dma_addr_t             dma_addr;
    NvU64                  saved_dma_mask;

    nvl = NV_GET_NVL_FROM_NV_STATE(nv);
    dev = nvl->dev;

    /*
     * IBM's Power platform, by default, only allows adapters to reserve a
     * maximum of 2GB of DMA address space. To request more, they provide
     * an "IODA2" mechanism to signal that the adapter will need more than
     * this.
     *
     * We first need to check if the platform supports this mechanism, and,
     * if it does, perform a trial DMA mapping to derive the DMA base address.
     */
    if (!machine_is(powernv))
    {
        goto done;
    }

    host = pci_bus_to_host(dev->bus);
    if ((host == NULL) || (host->dn == NULL))
    {
        goto done;
    }

    if (!of_device_is_compatible(host->dn, "ibm,ioda2-phb"))
    {
        goto done;
    }

    saved_dma_mask = dev->dma_mask;
    if (pci_set_dma_mask(dev, DMA_BIT_MASK(64)) != 0)
    {
        goto done;
    }

    dma_addr = pci_map_single(dev, NULL, 1, DMA_BIDIRECTIONAL);
    if (pci_dma_mapping_error(dev, dma_addr))
    {
        pci_set_dma_mask(dev, saved_dma_mask);
        goto done;
    }

    pci_unmap_single(dev, dma_addr, 1, DMA_BIDIRECTIONAL);

    /*
     * From IBM: "For IODA2, native DMA bypass or KVM TCE-based implementation
     * of full 64-bit DMA support will establish a window in address-space
     * with the high 14 bits being constant and the bottom up-to-50 bits
     * varying with the mapping."
     *
     * Unfortunately, we don't have any good interfaces or definitions from
     * the kernel to get information about the DMA offset assigned by OS.
     * However, we have been told that the offset will be defined by the top
     * 14 bits of the address, and bits 40-49 will not vary for any DMA
     * mappings until 1TB of system memory is surpassed; this limitation is
     * essential for us to function properly since our current GPUs only
     * support 40 physical address bits. We are in a fragile place where we
     * need to tell the OS that we're capable of 64-bit addressing, while
     * relying on the assumption that the top 24 bits will not vary in this
     * case.
     *
     * The way we try to compute the window, then, is mask the trial mapping
     * against the DMA capabilities of the device. That way, devices with
     * greater addressing capabilities will only take the bits it needs to
     * define the window.
     */
    start = dma_addr & ~(saved_dma_mask);

done:
#endif
    return start;
}

void NV_API_CALL nv_pci_trigger_recovery(
     nv_state_t *nv
)
{
#if defined(NV_PCI_ERROR_RECOVERY)
    nv_linux_state_t *nvl       = NV_GET_NVL_FROM_NV_STATE(nv);

    /*
     * Calling readl() will allow the kernel to check its state for the
     * device and update it accordingly. This needs to be done before
     * checking if the PCI channel is offline, so that we don't check
     * stale state.
     *
     * This will also kick off the recovery process for the device.
     */
    if (readl(nv->regs->map) == ~((NvU32)0))
    {
        if (pci_channel_offline(nvl->dev))
        {
            nv_printf(NV_DBG_ERRORS,
                "NVRM: PCI channel for device " NV_PCI_DEV_FMT " is offline\n",
                NV_PCI_DEV_FMT_ARGS(nv));
        }
    } 
#endif
}

RM_STATUS NV_API_CALL nv_set_primary_vga_status(
    nv_state_t *nv
)
{
    /* IORESOURCE_ROM_SHADOW wasn't added until 2.6.10 */
#if defined(IORESOURCE_ROM_SHADOW)
    nv_linux_state_t *nvl;
    struct pci_dev *dev;

    nvl = NV_GET_NVL_FROM_NV_STATE(nv);
    dev = nvl->dev;

    nv->primary_vga = ((NV_PCI_RESOURCE_FLAGS(dev, PCI_ROM_RESOURCE) &
        IORESOURCE_ROM_SHADOW) == IORESOURCE_ROM_SHADOW);
    return RM_OK;
#else
    return RM_ERR_NOT_SUPPORTED;
#endif
}
