/* _NVRM_COPYRIGHT_BEGIN_
 *
 * Copyright 2001-2014 by NVIDIA Corporation.  All rights reserved.  All
 * information contained herein is proprietary and confidential to NVIDIA
 * Corporation.  Any use, reproduction, or disclosure without the written
 * permission of NVIDIA Corporation is prohibited.
 *
 * _NVRM_COPYRIGHT_END_
 */

#ifndef _NV_LINUX_H_
#define _NV_LINUX_H_

#include "nv.h"
#include "conftest.h"

#if !defined(NV_VMWARE)
#define NV_KERNEL_NAME "Linux"
#else
#include "nv-vmware.h"
#endif

#if defined(HAVE_NV_ANDROID)
#include <nv-android.h>
#endif

#ifndef AUTOCONF_INCLUDED
#if defined(NV_GENERATED_AUTOCONF_H_PRESENT)
#include <generated/autoconf.h>
#else
#include <linux/autoconf.h>
#endif
#endif

#if defined(NV_GENERATED_UTSRELEASE_H_PRESENT)
  #include <generated/utsrelease.h>
#endif

#if defined(NV_GENERATED_COMPILE_H_PRESENT)
  #include <generated/compile.h>
#endif

#include <linux/version.h>
#include <linux/utsname.h>

#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 9)
#error "This driver does not support kernels older than 2.6.9!"
#elif LINUX_VERSION_CODE < KERNEL_VERSION(2, 7, 0)
#  define KERNEL_2_6
#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3, 0, 0)
#  define KERNEL_3
#else
#error "This driver does not support development kernels!"
#endif

#if defined (CONFIG_SMP) && !defined (__SMP__)
#define __SMP__
#endif

#if defined (CONFIG_MODVERSIONS) && !defined (MODVERSIONS)
#  define MODVERSIONS
#endif

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/kmod.h>

#include <linux/mm.h>

#if !defined(VM_RESERVED)
#define VM_RESERVED    0x00000000
#endif
#if !defined(VM_DONTEXPAND)
#define VM_DONTEXPAND  0x00000000
#endif
#if !defined(VM_DONTDUMP)
#define VM_DONTDUMP    0x00000000
#endif

#include <linux/init.h>             /* module_init, module_exit         */
#include <linux/types.h>            /* pic_t, size_t, __u32, etc        */
#include <linux/errno.h>            /* error codes                      */
#include <linux/list.h>             /* circular linked list             */
#include <linux/stddef.h>           /* NULL, offsetof                   */
#include <linux/wait.h>             /* wait queues                      */
#include <linux/string.h>           /* strchr(), strpbrk()              */

#if !defined(NV_VMWARE)
#include <linux/ctype.h>            /* isspace(), etc                   */
#include <linux/console.h>          /* acquire_console_sem(), etc       */
#include <linux/cpufreq.h>          /* cpufreq_get                      */
#endif

#include <linux/slab.h>             /* kmalloc, kfree, etc              */
#include <linux/vmalloc.h>          /* vmalloc, vfree, etc              */

#include <linux/poll.h>             /* poll_wait                        */
#include <linux/delay.h>            /* mdelay, udelay                   */

#include <linux/sched.h>            /* suser(), capable() replacement   */
#include <linux/moduleparam.h>      /* module_param()                   */
#if !defined(NV_VMWARE)
#include <asm/tlbflush.h>           /* flush_tlb(), flush_tlb_all()     */
#endif
#include <asm/kmap_types.h>         /* page table entry lookup          */

#include <linux/pci.h>              /* pci_find_class, etc              */
#include <linux/interrupt.h>        /* tasklets, interrupt helpers      */
#include <linux/timer.h>

#include <asm/div64.h>              /* do_div()                         */
#if defined(NV_ASM_SYSTEM_H_PRESENT)
#include <asm/system.h>             /* cli, sli, save_flags             */
#endif
#include <asm/io.h>                 /* ioremap, virt_to_phys            */
#include <asm/uaccess.h>            /* access_ok                        */
#include <asm/page.h>               /* PAGE_OFFSET                      */
#include <asm/pgtable.h>            /* pte bit definitions              */

#if defined(NVCPU_X86_64) && !defined(HAVE_COMPAT_IOCTL)
#include <linux/syscalls.h>         /* sys_ioctl()                      */
#include <linux/ioctl32.h>          /* register_ioctl32_conversion()    */
#endif

#if !defined(NV_FILE_OPERATIONS_HAS_IOCTL) && \
  !defined(NV_FILE_OPERATIONS_HAS_UNLOCKED_IOCTL)
#error "struct file_operations compile test likely failed!"
#endif

#if defined(CONFIG_VGA_ARB)
#include <linux/vgaarb.h>
#endif

#if defined(NV_VM_INSERT_PAGE_PRESENT)
#include <linux/pagemap.h>
#include <linux/dma-mapping.h>
#endif

#if !defined(NV_SCATTERLIST_HAS_PAGE)
#include <linux/scatterlist.h>
#endif

#include <linux/spinlock.h>
#if defined(NV_LINUX_SEMAPHORE_H_PRESENT)
#include <linux/semaphore.h>
#else
#include <asm/semaphore.h>
#endif
#include <linux/completion.h>
#include <linux/highmem.h>

#include <linux/workqueue.h>        /* workqueue                        */

#if !defined(NV_VMWARE)
#if defined(NV_LINUX_EFI_H_PRESENT)
#include <linux/efi.h>              /* efi_enabled                      */
#endif
#if defined(NV_LINUX_SCREEN_INFO_H_PRESENT)
#include <linux/screen_info.h>      /* screen_info                      */
#else
#include <linux/tty.h>              /* screen_info                      */
#endif
#endif

#if !defined(CONFIG_PCI)
#warning "Attempting to build driver for a platform with no PCI support!"
#include <asm-generic/pci-dma-compat.h>
#endif

#if defined(NV_EFI_ENABLED_PRESENT) && defined(NV_EFI_ENABLED_ARGUMENT_COUNT)
#if (NV_EFI_ENABLED_ARGUMENT_COUNT == 1)
#define NV_EFI_ENABLED() efi_enabled(EFI_BOOT)
#else
#error "NV_EFI_ENABLED_ARGUMENT_COUNT value unrecognized!"
#endif
#elif !defined(NV_VMWARE) && \
  (defined(NV_EFI_ENABLED_PRESENT) || defined(efi_enabled))
#define NV_EFI_ENABLED() efi_enabled
#else
#define NV_EFI_ENABLED() 0
#endif

#if defined(CONFIG_CRAY_XT)
#include <cray/cray_nvidia.h>
RM_STATUS nvos_forward_error_to_cray(struct pci_dev *, NvU32,
        const char *, va_list);
#endif

#if defined(NV_SET_MEMORY_UC_PRESENT)
#undef NV_SET_PAGES_UC_PRESENT
#undef NV_CHANGE_PAGE_ATTR_PRESENT
#elif defined(NV_SET_PAGES_UC_PRESENT)
#undef NV_CHANGE_PAGE_ATTR_PRESENT
#endif

#if !defined(NV_VMWARE) && !defined(NVCPU_FAMILY_ARM) && !defined(NVCPU_PPC64LE)
#if !defined(NV_SET_MEMORY_UC_PRESENT) && !defined(NV_SET_PAGES_UC_PRESENT) && \
  !defined(NV_CHANGE_PAGE_ATTR_PRESENT)
#error "This driver requires the ability to change memory types!"
#endif
#endif

/*
 * Using change_page_attr() on early Linux/x86-64 2.6 kernels may
 * result in a BUG() being triggered. The underlying problem
 * actually exists on multiple architectures and kernels, but only
 * the above check for the condition and trigger a BUG().
 *
 * Note that this is a due to a bug in the Linux kernel, not an
 * NVIDIA driver bug.
 *
 * We therefore need to determine at runtime if change_page_attr()
 * can be used safely on these kernels.
 */
#if !defined(NV_VMWARE) && \
  defined(NV_CHANGE_PAGE_ATTR_PRESENT) && defined(NVCPU_X86_64) && \
  (LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 11))
#define NV_CHANGE_PAGE_ATTR_BUG_PRESENT
#endif

/*
 * Traditionally, CONFIG_XEN indicated that the target kernel was
 * built exclusively for use under a Xen hypervisor, requiring
 * modifications to or disabling of a variety of NVIDIA graphics
 * driver code paths. As of the introduction of CONFIG_PARAVIRT
 * and support for Xen hypervisors within the CONFIG_PARAVIRT_GUEST
 * architecture, CONFIG_XEN merely indicates that the target
 * kernel can run under a Xen hypervisor, but not that it will.
 *
 * If CONFIG_XEN and CONFIG_PARAVIRT are defined, the old Xen
 * specific code paths are disabled. If the target kernel executes
 * stand-alone, the NVIDIA graphics driver will work fine. If the
 * kernels executes under a Xen (or other) hypervisor, however, the
 * NVIDIA graphics driver has no way of knowing and is unlikely
 * to work correctly.
 */
#if defined(CONFIG_XEN) && !defined(CONFIG_PARAVIRT)
#include <asm/maddr.h>
#include <xen/interface/memory.h>
#define NV_XEN_SUPPORT_FULLY_VIRTUALIZED_KERNEL
#endif

#ifdef CONFIG_PROC_FS
#include <linux/proc_fs.h>
#include <linux/seq_file.h>
#endif

#ifdef CONFIG_KDB
#include <linux/kdb.h>
#include <asm/kdb.h>
#endif

#if defined(CONFIG_X86_REMOTE_DEBUG)
#include <linux/gdb.h>
#endif

#if defined(DEBUG) && defined(CONFIG_KGDB) && \
    defined(NVCPU_FAMILY_ARM)
#include <asm/kgdb.h>
#endif

#if (defined(NVCPU_X86) || defined(NVCPU_X86_64)) && \
  !defined(NV_XEN_SUPPORT_FULLY_VIRTUALIZED_KERNEL)
#define NV_ENABLE_PAT_SUPPORT
#endif

#define NV_PAT_MODE_DISABLED    0
#define NV_PAT_MODE_KERNEL      1
#define NV_PAT_MODE_BUILTIN     2

extern int nv_pat_mode;

#if !defined(NV_VMWARE) && defined(CONFIG_HOTPLUG_CPU)
#define NV_ENABLE_HOTPLUG_CPU
#include <linux/cpu.h>              /* CPU hotplug support              */
#include <linux/notifier.h>         /* struct notifier_block, etc       */
#endif

#if !defined(NV_VMWARE) && \
  (defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE))
#include <linux/i2c.h>
#endif

#if !defined(NV_VMWARE) && defined(CONFIG_ACPI)
#include <linux/acpi.h>
#if defined(NV_ACPI_DEVICE_OPS_HAS_MATCH) || defined(ACPI_VIDEO_HID)
#define NV_LINUX_ACPI_EVENTS_SUPPORTED 1
#endif
#endif

#if defined(NV_PCI_DMA_MAPPING_ERROR_PRESENT)
#if (NV_PCI_DMA_MAPPING_ERROR_ARGUMENT_COUNT == 2)
#define NV_PCI_DMA_MAPPING_ERROR(dev, addr) \
    pci_dma_mapping_error(dev, addr)
#elif (NV_PCI_DMA_MAPPING_ERROR_ARGUMENT_COUNT == 1)
#define NV_PCI_DMA_MAPPING_ERROR(dev, addr) \
    pci_dma_mapping_error(addr)
#else
#error "NV_PCI_DMA_MAPPING_ERROR_ARGUMENT_COUNT value unrecognized!"
#endif
#elif defined(NV_VM_INSERT_PAGE_PRESENT)
#error "NV_PCI_DMA_MAPPING_ERROR() undefined!"
#endif

#if defined(NV_LINUX_ACPI_EVENTS_SUPPORTED)
#if (NV_ACPI_WALK_NAMESPACE_ARGUMENT_COUNT == 6)
#define NV_ACPI_WALK_NAMESPACE(type, args...) acpi_walk_namespace(type, args)
#elif (NV_ACPI_WALK_NAMESPACE_ARGUMENT_COUNT == 7)
#define NV_ACPI_WALK_NAMESPACE(type, start_object, max_depth, \
        user_function, args...) \
    acpi_walk_namespace(type, start_object, max_depth, \
            user_function, NULL, args)
#else
#error "NV_ACPI_WALK_NAMESPACE_ARGUMENT_COUNT value unrecognized!"
#endif
#endif

#if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_PREEMPT_RT_FULL)
#define NV_CONFIG_PREEMPT_RT 1
#endif

typedef spinlock_t                nv_spinlock_t;
#define NV_SPIN_LOCK_INIT(lock)   spin_lock_init(lock)
#define NV_SPIN_LOCK_IRQ(lock)    spin_lock_irq(lock)
#define NV_SPIN_UNLOCK_IRQ(lock)  spin_unlock_irq(lock)
#define NV_SPIN_LOCK_IRQSAVE(lock,flags) spin_lock_irqsave(lock,flags)
#define NV_SPIN_UNLOCK_IRQRESTORE(lock,flags) spin_unlock_irqrestore(lock,flags)
#define NV_SPIN_LOCK(lock)        spin_lock(lock)
#define NV_SPIN_UNLOCK(lock)      spin_unlock(lock)
#define NV_SPIN_UNLOCK_WAIT(lock) spin_unlock_wait(lock)

#if defined(NVCPU_X86)
#ifndef write_cr4
#define write_cr4(x) __asm__ ("movl %0,%%cr4" :: "r" (x));
#endif

#ifndef read_cr4
#define read_cr4()                                  \
 ({                                                 \
      unsigned int __cr4;                           \
      __asm__ ("movl %%cr4,%0" : "=r" (__cr4));     \
      __cr4;                                        \
  })
#endif

#ifndef wbinvd
#define wbinvd() __asm__ __volatile__("wbinvd" ::: "memory");
#endif
#endif /* defined(NVCPU_X86) */

#if defined(NV_WRITE_CR4_PRESENT)
#define NV_READ_CR4()       read_cr4()
#define NV_WRITE_CR4(cr4)   write_cr4(cr4)
#else
#define NV_READ_CR4()       __read_cr4()
#define NV_WRITE_CR4(cr4)   __write_cr4(cr4)
#endif

#ifndef get_cpu
#define get_cpu() smp_processor_id()
#define put_cpu()
#endif

#if !defined(unregister_hotcpu_notifier)
#define unregister_hotcpu_notifier unregister_cpu_notifier
#endif
#if !defined(register_hotcpu_notifier)
#define register_hotcpu_notifier register_cpu_notifier
#endif

#if !defined (list_for_each)
#define list_for_each(pos, head) \
        for (pos = (head)->next; pos != (head); pos = (pos)->next)
#endif

#if defined(NVCPU_X86) || defined(NVCPU_X86_64)
#if !defined(pmd_large)
#define pmd_large(_pmd) \
    ((pmd_val(_pmd) & (_PAGE_PSE|_PAGE_PRESENT)) == (_PAGE_PSE|_PAGE_PRESENT))
#endif
#endif /* defined(NVCPU_X86) || defined(NVCPU_X86_64) */

#if !defined(NV_VMWARE)
#define NV_GET_PAGE_COUNT(page_ptr) \
  ((unsigned int)page_count(NV_GET_PAGE_STRUCT(page_ptr->phys_addr)))
#define NV_GET_PAGE_FLAGS(page_ptr) \
  (NV_GET_PAGE_STRUCT(page_ptr->phys_addr)->flags)
#define NV_LOCK_PAGE(ptr_ptr) \
  SetPageReserved(NV_GET_PAGE_STRUCT(page_ptr->phys_addr))
#define NV_UNLOCK_PAGE(page_ptr) \
  ClearPageReserved(NV_GET_PAGE_STRUCT(page_ptr->phys_addr))
#endif

#if !defined(__GFP_COMP)
#define __GFP_COMP 0
#endif

#if !defined(DEBUG) && defined(__GFP_NOWARN)
#define NV_GFP_KERNEL (GFP_KERNEL | __GFP_NOWARN)
#define NV_GFP_ATOMIC (GFP_ATOMIC | __GFP_NOWARN)
#else
#define NV_GFP_KERNEL (GFP_KERNEL)
#define NV_GFP_ATOMIC (GFP_ATOMIC)
#endif

#if defined(GFP_DMA32)
/*
 * GFP_DMA32 is similar to GFP_DMA, but instructs the Linux zone
 * allocator to allocate memory from the first 4GB on platforms
 * such as Linux/x86-64; the alternative is to use an IOMMU such
 * as the one implemented with the K8 GART, if available.
 */
#define NV_GFP_DMA32 (NV_GFP_KERNEL | GFP_DMA32)
#else
#define NV_GFP_DMA32 (NV_GFP_KERNEL)
#endif

#if defined(NVCPU_X86) || defined(NVCPU_X86_64)
#define CACHE_FLUSH()  asm volatile("wbinvd":::"memory")
#define WRITE_COMBINE_FLUSH() asm volatile("sfence":::"memory")
#elif defined(NVCPU_FAMILY_ARM)
#if defined(NVCPU_ARM)
    static inline void nv_flush_cache_cpu(void *info)
    {
        __cpuc_flush_kern_all();
    }
#define CACHE_FLUSH()            nv_flush_cache_cpu(NULL)
#define CACHE_FLUSH_ALL()        NV_ON_EACH_CPU(nv_flush_cache_cpu, NULL, 1)
#if defined(NV_OUTER_FLUSH_ALL_PRESENT)
#define OUTER_FLUSH_ALL()               outer_flush_all()
#endif
#if defined(CONFIG_OUTER_CACHE)
#define OUTER_FLUSH_RANGE(start, end)   outer_flush_range((start),(end))
#endif
#define WRITE_COMBINE_FLUSH()    { dsb(); outer_sync(); }
#elif defined(NVCPU_AARCH64)
    static inline void nv_flush_cache_cpu(void *info)
    {
        flush_cache_all();
    }
#define CACHE_FLUSH()            nv_flush_cache_cpu(NULL)
#define CACHE_FLUSH_ALL()        NV_ON_EACH_CPU(nv_flush_cache_cpu, NULL, 1)
#define WRITE_COMBINE_FLUSH()    mb()
#endif
#elif defined(NVCPU_PPC64LE)
#define CACHE_FLUSH()            asm volatile("sync":::"memory")
#define WRITE_COMBINE_FLUSH()    asm volatile("sync":::"memory")
#endif

#if !defined(IRQF_SHARED)
#define IRQF_SHARED SA_SHIRQ
#endif

#define NV_MAX_RECURRING_WARNING_MESSAGES 10

#if (defined(CONFIG_DMAR) || defined(CONFIG_INTEL_IOMMU))
#define NV_INTEL_IOMMU 1
#endif

/* add support for iommu.
 * On the x86-64 platform, the driver may need to remap system
 * memory pages via AMD K8/Intel VT-d IOMMUs if a given
 * GPUs addressing capabilities are limited such that it can
 * not access the original page directly. Examples of this
 * are legacy PCI-E devices.
 */
#if (defined(NVCPU_X86_64) && !defined(GFP_DMA32)) || \
   defined(NV_INTEL_IOMMU) || defined(NV_XEN_SUPPORT_FULLY_VIRTUALIZED_KERNEL) || \
   defined(NVCPU_PPC64LE)
#define NV_SG_MAP_BUFFERS 1
#endif

/*
 * Limit use of IOMMU space to 60 MB, leaving 4 MB for the rest
 * of the system (assuming a 64 MB IOMMU aperture).
 * This is not required if Intel VT-d IOMMU is used to remap pages.
 */
#if !defined(NV_INTEL_IOMMU) && !defined(NVCPU_PPC64LE)
#define NV_NEED_REMAP_CHECK 1
#define NV_REMAP_LIMIT_DEFAULT  (60 * 1024 * 1024)
#endif

#if defined(NV_SG_INIT_TABLE_PRESENT)
#define NV_SG_INIT_TABLE(sgl, nents) \
    sg_init_table(sgl, nents)
#else
#define NV_SG_INIT_TABLE(sgl, nents) \
    memset(sgl, 0, (sizeof(*(sgl)) * (nents)));
#endif

#ifndef NVWATCH

/* various memory tracking/debugging techniques
 * disabled for retail builds, enabled for debug builds
 */

// allow an easy way to convert all debug printfs related to memory
// management back and forth between 'info' and 'errors'
#if defined(NV_DBG_MEM)
#define NV_DBG_MEMINFO NV_DBG_ERRORS
#else
#define NV_DBG_MEMINFO NV_DBG_INFO
#endif

#if defined(NV_MEM_LOGGER)
#ifndef NV_ENABLE_MEM_TRACKING
#define NV_ENABLE_MEM_TRACKING 1
#endif
#endif

#define NV_MEM_TRACKING_PAD_SIZE(size) \
    (size) = NV_ALIGN_UP((size + sizeof(void *)), sizeof(void *))

#define NV_MEM_TRACKING_HIDE_SIZE(ptr, size)            \
    if ((ptr != NULL) && (*(ptr) != NULL))              \
    {                                                   \
        NvU8 *__ptr;                                    \
        *(unsigned long *) *(ptr) = (size);             \
        __ptr = *(ptr); __ptr += sizeof(void *);        \
        *(ptr) = (void *) __ptr;                        \
    }
#define NV_MEM_TRACKING_RETRIEVE_SIZE(ptr, size)        \
    {                                                   \
        NvU8 *__ptr = (ptr); __ptr -= sizeof(void *);   \
        (ptr) = (void *) __ptr;                         \
        (size) = *(unsigned long *) (ptr);              \
    }

/* poor man's memory allocation tracker.
 * main intention is just to see how much memory is being used to recognize
 * when memory usage gets out of control or if memory leaks are happening
 */

/* keep track of memory usage */
#if defined(NV_ENABLE_MEM_TRACKING)

/* print out a running tally of memory allocation amounts, disabled by default */
// #define POOR_MANS_MEM_CHECK 1


/* slightly more advanced memory allocation tracker.
 * track who's allocating memory and print out a list of currently allocated
 * memory at key points in the driver
 */

#define MEMDBG_ALLOC(a,b) (a = kmalloc(b, NV_GFP_ATOMIC))
#define MEMDBG_FREE(a)    (kfree(a))

#include "nv-memdbg.h"

#undef MEMDBG_ALLOC
#undef MEMDBG_FREE

/* print out list of memory allocations */
/* default to enabled for now */
#define LIST_MEM_CHECK 1

/* decide which memory types to apply mem trackers to */
#define VM_CHECKER 1
#define KM_CHECKER 1

#endif  /* NV_ENABLE_MEM_TRACKING */

#if defined(VM_CHECKER)
/* kernel virtual memory usage/allocation information */
extern NvU32 vm_usage;
extern struct mem_track_t *vm_list;
extern nv_spinlock_t vm_lock;

#  if defined(POOR_MANS_MEM_CHECK)
#    define VM_PRINT(str, args...)   printk(str, ##args)
#  else
#    define VM_PRINT(str, args...)
#  endif
#  if defined(LIST_MEM_CHECK)
#    define VM_ADD_MEM(a,b,c,d)      nv_add_mem(&vm_list, a, b, c, d)
#    define VM_FREE_MEM(a,b,c,d)     nv_free_mem(&vm_list, a, b, c, d)
#  else
#    define VM_ADD_MEM(a,b,c,d)
#    define VM_FREE_MEM(a,b,c,d)
#  endif
#  define VM_ALLOC_RECORD(ptr, size, name)                                   \
        if (ptr != NULL)                                                     \
        {                                                                    \
            NV_SPIN_LOCK(&vm_lock);                                          \
            vm_usage += size;                                                \
            VM_PRINT("NVRM: %s (0x%p: 0x%x): VM usage is now 0x%x bytes\n",  \
                name, (void *)ptr, size, vm_usage);                          \
            VM_ADD_MEM(ptr, size, __FILE__, __LINE__);                       \
            NV_SPIN_UNLOCK(&vm_lock);                                        \
        }
#  define VM_FREE_RECORD(ptr, size, name)                                    \
        if (ptr != NULL)                                                     \
        {                                                                    \
            NV_SPIN_LOCK(&vm_lock);                                          \
            vm_usage -= size;                                                \
            VM_PRINT("NVRM: %s (0x%p: 0x%x): VM usage is now 0x%x bytes\n",  \
                name, (void *)ptr, size, vm_usage);                          \
            VM_FREE_MEM(ptr, size, __FILE__, __LINE__);                      \
            NV_SPIN_UNLOCK(&vm_lock);                                        \
        }
#else
#  define VM_ALLOC_RECORD(a,b,c)
#  define VM_FREE_RECORD(a,b,c)
#endif

#if defined(KM_CHECKER)
/* kernel logical memory usage/allocation information */
extern NvU32 km_usage;
extern struct mem_track_t *km_list;
extern nv_spinlock_t km_lock;

#  if defined(POOR_MANS_MEM_CHECK)
#    define KM_PRINT(str, args...)   printk(str, ##args)
#  else
#    define KM_PRINT(str, args...)
#  endif
#  if defined(LIST_MEM_CHECK)
#    define KM_ADD_MEM(a,b,c,d)      nv_add_mem(&km_list, a, b, c, d)
#    define KM_FREE_MEM(a,b,c,d)     nv_free_mem(&km_list, a, b, c, d)
#  else
#    define KM_ADD_MEM(a,b,c,d)
#    define KM_FREE_MEM(a,b,c,d)
#  endif
#  define KM_ALLOC_RECORD(ptr, size, name)                                   \
        if (ptr != NULL)                                                     \
        {                                                                    \
            unsigned long __eflags;                                          \
            NV_SPIN_LOCK_IRQSAVE(&km_lock, __eflags);                        \
            km_usage += size;                                                \
            KM_PRINT("NVRM: %s (0x%p: 0x%x): KM usage is now 0x%x bytes\n",  \
                name, (void *)ptr, size, km_usage);                          \
            KM_ADD_MEM(ptr, size, __FILE__, __LINE__);                       \
            NV_SPIN_UNLOCK_IRQRESTORE(&km_lock, __eflags);                   \
        }
#  define KM_FREE_RECORD(ptr, size, name)                                    \
        if (ptr != NULL)                                                     \
        {                                                                    \
            unsigned long __eflags;                                          \
            NV_SPIN_LOCK_IRQSAVE(&km_lock, __eflags);                        \
            km_usage -= size;                                                \
            KM_PRINT("NVRM: %s (0x%p: 0x%x): KM usage is now 0x%x bytes\n",  \
                name, (void *)ptr, size, km_usage);                          \
            KM_FREE_MEM(ptr, size, __FILE__, __LINE__);                      \
            NV_SPIN_UNLOCK_IRQRESTORE(&km_lock, __eflags);                   \
        }
#else
#  define KM_ALLOC_RECORD(a,b,c)
#  define KM_FREE_RECORD(a,b,c)
#endif

#define NV_VMALLOC(ptr, size)                               \
    {                                                       \
        (ptr) = __vmalloc(size, GFP_KERNEL, PAGE_KERNEL);   \
        VM_ALLOC_RECORD(ptr, size, "vm_vmalloc");           \
    }

#define NV_VFREE(ptr, size)                         \
    {                                               \
        VM_FREE_RECORD(ptr, size, "vm_vfree");      \
        vfree((void *) (ptr));                      \
    }

#if !defined(NV_VMWARE)
#define NV_IOREMAP(ptr, physaddr, size) \
    { \
        (ptr) = ioremap(physaddr, size); \
        VM_ALLOC_RECORD(ptr, size, "vm_ioremap"); \
    }

#define NV_IOREMAP_NOCACHE(ptr, physaddr, size) \
    { \
        (ptr) = ioremap_nocache(physaddr, size); \
        VM_ALLOC_RECORD(ptr, size, "vm_ioremap_nocache"); \
    }

#if defined(NV_IOREMAP_CACHE_PRESENT)
#define NV_IOREMAP_CACHE(ptr, physaddr, size)            \
    {                                                    \
        (ptr) = ioremap_cache(physaddr, size);           \
        VM_ALLOC_RECORD(ptr, size, "vm_ioremap_cache");  \
    }
#else
#define NV_IOREMAP_CACHE NV_IOREMAP
#endif

#if defined(NV_IOREMAP_WC_PRESENT)
#define NV_IOREMAP_WC(ptr, physaddr, size)            \
    {                                                 \
        (ptr) = ioremap_wc(physaddr, size);           \
        VM_ALLOC_RECORD(ptr, size, "vm_ioremap_wc");  \
    }
#else
#define NV_IOREMAP_WC NV_IOREMAP_NOCACHE
#endif

#define NV_IOUNMAP(ptr, size) \
    { \
        VM_FREE_RECORD(ptr, size, "vm_iounmap"); \
        iounmap(ptr); \
    }

#define NV_KMALLOC(ptr, size) \
    { \
        (ptr) = kmalloc(size, NV_GFP_KERNEL); \
        KM_ALLOC_RECORD(ptr, size, "km_alloc"); \
    }

#define NV_KMALLOC_ATOMIC(ptr, size) \
    { \
        (ptr) = kmalloc(size, NV_GFP_ATOMIC); \
        KM_ALLOC_RECORD(ptr, size, "km_alloc_atomic"); \
    }


#define NV_KFREE(ptr, size) \
    { \
        KM_FREE_RECORD(ptr, size, "km_free"); \
        kfree((void *) (ptr)); \
    }

#define NV_GET_FREE_PAGES(ptr, order, gfp_mask)      \
    {                                                \
        (ptr) = __get_free_pages(gfp_mask, order);   \
    }

#define NV_FREE_PAGES(ptr, order)                    \
    {                                                \
        free_pages(ptr, order);                      \
    }

#if defined(NV_KMEM_CACHE_CREATE_PRESENT)
#if (NV_KMEM_CACHE_CREATE_ARGUMENT_COUNT == 6)
#define NV_KMEM_CACHE_CREATE(kmem_cache, name, type)            \
    {                                                           \
        kmem_cache = kmem_cache_create(name, sizeof(type),      \
                        0, 0, NULL, NULL);                      \
    }
#elif (NV_KMEM_CACHE_CREATE_ARGUMENT_COUNT == 5)
#define NV_KMEM_CACHE_CREATE(kmem_cache, name, type)            \
    {                                                           \
        kmem_cache = kmem_cache_create(name, sizeof(type),      \
                        0, 0, NULL);                            \
    }
#else
#error "NV_KMEM_CACHE_CREATE_ARGUMENT_COUNT value unrecognized!"
#endif
#define NV_KMEM_CACHE_DESTROY(kmem_cache)                       \
    {                                                           \
        kmem_cache_destroy(kmem_cache);                         \
        kmem_cache = NULL;                                      \
    }
#else
#error "NV_KMEM_CACHE_CREATE() undefined (kmem_cache_create() unavailable)!"
#endif

#define NV_KMEM_CACHE_ALLOC(ptr, kmem_cache, type)              \
    {                                                           \
        (ptr) = kmem_cache_alloc(kmem_cache, GFP_KERNEL);       \
    }

#define NV_KMEM_CACHE_FREE(ptr, type, kmem_cache)               \
    {                                                           \
        kmem_cache_free(kmem_cache, ptr);                       \
    }
#endif

extern void *nvidia_p2p_page_t_cache;
extern void *nv_stack_t_cache;

#if defined(NVCPU_X86) || defined(NVCPU_X86_64)
#define NV_KMEM_CACHE_ALLOC_STACK(ptr)                                  \
    {                                                                   \
        NV_KMEM_CACHE_ALLOC(ptr, nv_stack_t_cache, nv_stack_t);         \
        if ((ptr) != NULL)                                              \
        {                                                               \
            (ptr)->size = sizeof((ptr)->stack);                         \
            (ptr)->top = (ptr)->stack + (ptr)->size;                    \
        }                                                               \
    }

#define NV_KMEM_CACHE_FREE_STACK(ptr)                                   \
    {                                                                   \
        NV_KMEM_CACHE_FREE((ptr), nv_stack_t, nv_stack_t_cache);        \
        (ptr) = NULL;                                                   \
    }
#else
#define NV_KMEM_CACHE_ALLOC_STACK(ptr) (ptr) = ((void *)(NvUPtr)-1)
#define NV_KMEM_CACHE_FREE_STACK(ptr) (void)ptr
#endif

#if defined(NV_VMAP_PRESENT)
#if (NV_VMAP_ARGUMENT_COUNT == 2)
#define NV_VMAP_KERNEL(ptr, pages, count, prot)                         \
    {                                                                   \
        (ptr) = (unsigned long)vmap(pages, count);                      \
        VM_ALLOC_RECORD((void *)ptr, (count) * PAGE_SIZE, "vm_vmap");   \
    }
#elif (NV_VMAP_ARGUMENT_COUNT == 4)
#ifndef VM_MAP
#define VM_MAP  0
#endif
#define NV_VMAP_KERNEL(ptr, pages, count, prot)                         \
    {                                                                   \
        (ptr) = (unsigned long)vmap(pages, count, VM_MAP, prot);        \
        VM_ALLOC_RECORD((void *)ptr, (count) * PAGE_SIZE, "vm_vmap");   \
    }
#else
#error "NV_VMAP_ARGUMENT_COUNT value unrecognized!"
#endif
#else
#error "NV_VMAP() undefined (vmap() unavailable)!"
#endif

#define NV_VUNMAP_KERNEL(ptr, count)                                    \
    {                                                                   \
        VM_FREE_RECORD((void *)ptr, (count) * PAGE_SIZE, "vm_vunmap");  \
        vunmap((void *)(ptr));                                          \
    }

#if defined(NVCPU_X86) || defined(NVCPU_X86_64)
#define NV_VMAP(addr, pages, count, cached)                             \
    {                                                                   \
        pgprot_t __prot = (cached) ? PAGE_KERNEL : PAGE_KERNEL_NOCACHE; \
        void *__ptr = nv_vmap(pages, count, __prot);                    \
        (addr) = (unsigned long)__ptr;                                  \
    }
#elif defined(NVCPU_ARM)
#define NV_VMAP(addr, pages, count, cached)                             \
    {                                                                   \
        void *__ptr;                                                    \
        pgprot_t __prot = PAGE_KERNEL;                                  \
        if (!cached)                                                    \
            __prot = NV_PGPROT_UNCACHED(__prot);                        \
        __ptr = nv_vmap(pages, count, __prot);                          \
        (addr) = (unsigned long)__ptr;                                  \
    }
#elif defined(NVCPU_PPC64LE) || defined(NVCPU_AARCH64)
#define NV_VMAP(addr, pages, count, cached)                             \
    {                                                                   \
        /* All memory cached in PPC64LE; can't honor 'cached' input.
         * For now, treat all memory as cached on AArch64 as well. */   \
        void *__ptr = nv_vmap(pages, count, PAGE_KERNEL);               \
        (addr) = (unsigned long)__ptr;                                  \
    }
#endif

#define NV_VUNMAP(addr, count) nv_vunmap((void *)addr, count)

#endif /* !defined NVWATCH */

#if defined(NV_SMP_CALL_FUNCTION_PRESENT)
#if (NV_SMP_CALL_FUNCTION_ARGUMENT_COUNT == 4)
#define NV_SMP_CALL_FUNCTION(func, info, wait)               \
    ({                                                       \
        int __ret = smp_call_function(func, info, 1, wait);  \
        __ret;                                               \
     })
#elif (NV_SMP_CALL_FUNCTION_ARGUMENT_COUNT == 3)
#define NV_SMP_CALL_FUNCTION(func, info, wait)               \
    ({                                                       \
        int __ret = smp_call_function(func, info, wait);     \
        __ret;                                               \
     })
#else
#error "NV_SMP_CALL_FUNCTION_ARGUMENT_COUNT value unrecognized!"
#endif
#elif defined(CONFIG_SMP)
#error "NV_SMP_CALL_FUNCTION() undefined (smp_call_function() unavailable)!"
#endif

#if defined(NV_ON_EACH_CPU_PRESENT)
#if (NV_ON_EACH_CPU_ARGUMENT_COUNT == 4)
#define NV_ON_EACH_CPU(func, info, wait)               \
    ({                                                 \
        int __ret = on_each_cpu(func, info, 1, wait);  \
        __ret;                                         \
     })
#elif (NV_ON_EACH_CPU_ARGUMENT_COUNT == 3)
#define NV_ON_EACH_CPU(func, info, wait)               \
    ({                                                 \
        int __ret = on_each_cpu(func, info, wait);     \
        __ret;                                         \
     })
#else
#error "NV_ON_EACH_CPU_ARGUMENT_COUNT value unrecognized!"
#endif
#elif defined(CONFIG_SMP)
#error "NV_ON_EACH_CPU() undefined (on_each_cpu() unavailable)!"
#endif

static inline int nv_execute_on_all_cpus(void (*func)(void *info), void *info)
{
    int ret = 0;
#if !defined(CONFIG_SMP)
    func(info);
#else
    ret = NV_ON_EACH_CPU(func, info, 1);
#endif
    return ret;
}

#if defined(NV_CONFIG_PREEMPT_RT)
#define NV_INIT_MUTEX(mutex) sema_init(mutex,1)
#else
#if !defined(__SEMAPHORE_INITIALIZER) && defined(__COMPAT_SEMAPHORE_INITIALIZER)
#define __SEMAPHORE_INITIALIZER __COMPAT_SEMAPHORE_INITIALIZER
#endif
#define NV_INIT_MUTEX(mutex)                       \
    {                                              \
        struct semaphore __mutex =                 \
            __SEMAPHORE_INITIALIZER(*(mutex), 1);  \
        *(mutex) = __mutex;                        \
    }
#endif

#if !defined(NV_VMWARE)
#if defined(NV_GET_NUM_PHYSPAGES_PRESENT)
#define NV_NUM_PHYSPAGES                get_num_physpages()
#else
#define NV_NUM_PHYSPAGES                num_physpages
#endif
#define NV_GET_CURRENT_PROCESS()        current->tgid
#define NV_IN_ATOMIC()                  in_atomic()
#define NV_LOCAL_BH_DISABLE()           local_bh_disable()
#define NV_LOCAL_BH_ENABLE()            local_bh_enable()
#define NV_COPY_TO_USER(to, from, n)    copy_to_user(to, from, n)
#define NV_COPY_FROM_USER(to, from, n)  copy_from_user(to, from, n)
#endif

#define NV_IS_SUSER()                   capable(CAP_SYS_ADMIN)
#define NV_PCI_DEVICE_NAME(dev)         ((dev)->pretty_name)
#define NV_CLI()                        local_irq_disable()
#define NV_SAVE_FLAGS(eflags)           local_save_flags(eflags)
#define NV_RESTORE_FLAGS(eflags)        local_irq_restore(eflags)
#define NV_MAY_SLEEP()                  (!irqs_disabled() && !in_interrupt() && !NV_IN_ATOMIC())
#define NV_MODULE_PARAMETER(x)          module_param(x, int, 0)
#define NV_MODULE_STRING_PARAMETER(x)   module_param(x, charp, 0)
#undef  MODULE_PARM

#if !defined(NV_VMWARE)
#if defined(num_present_cpus)
#define NV_NUM_CPUS()                 num_present_cpus()
#else
#define NV_NUM_CPUS()                 num_online_cpus()
#endif
#endif

#if defined(NV_XEN_SUPPORT_FULLY_VIRTUALIZED_KERNEL)
#define NV_GET_DMA_ADDRESS(phys_addr) phys_to_machine(phys_addr)
#else
#define NV_GET_DMA_ADDRESS(phys_addr) (phys_addr)
#endif

#define NV_GET_PAGE_STRUCT(phys_page) virt_to_page(__va(phys_page))
#define NV_VMA_PGOFF(vma)             ((vma)->vm_pgoff)
#define NV_VMA_SIZE(vma)              ((vma)->vm_end - (vma)->vm_start)
#define NV_VMA_OFFSET(vma)            (((NvU64)(vma)->vm_pgoff) << PAGE_SHIFT)
#define NV_VMA_PRIVATE(vma)           ((vma)->vm_private_data)
#define NV_VMA_FILE(vma)              ((vma)->vm_file)

#define NV_DEVICE_MINOR_NUMBER(x)     minor((x)->i_rdev)
#if !defined(NV_VMWARE)
#define NV_CONTROL_DEVICE_MINOR       255
#endif
#define NV_IS_CONTROL_DEVICE(x)       (minor((x)->i_rdev) ==  \
                                      (NV_CONTROL_DEVICE_MINOR - NV_MODULE_INSTANCE))

#define NV_IS_SMU_DEVICE(dev)         (dev->class == (PCI_CLASS_PROCESSOR_CO << 8))
#define NV_PCI_DEVICE_ID_SMU          0x0aa3

#define NV_PCI_DISABLE_DEVICE(dev)                            \
    {                                                         \
        NvU16 __cmd[2];                                       \
        pci_read_config_word((dev), PCI_COMMAND, &__cmd[0]);  \
        pci_disable_device(dev);                              \
        pci_read_config_word((dev), PCI_COMMAND, &__cmd[1]);  \
        __cmd[1] |= PCI_COMMAND_MEMORY;                       \
        pci_write_config_word((dev), PCI_COMMAND,             \
                (__cmd[1] | (__cmd[0] & PCI_COMMAND_IO)));    \
    }

#define NV_PCI_RESOURCE_START(dev, bar) pci_resource_start(dev, (bar))
#define NV_PCI_RESOURCE_SIZE(dev, bar)  pci_resource_len(dev, (bar))
#define NV_PCI_RESOURCE_FLAGS(dev, bar) pci_resource_flags(dev, (bar))

#if defined(NVCPU_X86)
#define NV_PCI_RESOURCE_VALID(dev, bar)                                      \
    ((NV_PCI_RESOURCE_START(dev, bar) != 0) &&                               \
     (NV_PCI_RESOURCE_SIZE(dev, bar) != 0) &&                                \
     (!((NV_PCI_RESOURCE_FLAGS(dev, bar) & PCI_BASE_ADDRESS_MEM_TYPE_64) &&  \
       ((NV_PCI_RESOURCE_START(dev, bar) >> PAGE_SHIFT) > 0xfffffULL))))
#else
#define NV_PCI_RESOURCE_VALID(dev, bar)                                      \
    ((NV_PCI_RESOURCE_START(dev, bar) != 0) &&                               \
     (NV_PCI_RESOURCE_SIZE(dev, bar) != 0))
#endif

#if defined(NV_PCI_DOMAIN_NR_PRESENT)
#define NV_PCI_DOMAIN_NUMBER(dev)     (NvU32)pci_domain_nr(dev->bus)
#else
#define NV_PCI_DOMAIN_NUMBER(dev)     (0)
#endif
#define NV_PCI_BUS_NUMBER(dev)        (dev)->bus->number
#define NV_PCI_DEVFN(dev)             (dev)->devfn
#define NV_PCI_SLOT_NUMBER(dev)       PCI_SLOT(NV_PCI_DEVFN(dev))

#if defined(NV_PCI_GET_CLASS_PRESENT)
#define NV_PCI_DEV_PUT(dev)                    pci_dev_put(dev)
#define NV_PCI_GET_DEVICE(vendor,device,from)  pci_get_device(vendor,device,from)
#define NV_PCI_GET_CLASS(class,from)           pci_get_class(class,from)
#else
#define NV_PCI_DEV_PUT(dev)
#define NV_PCI_GET_DEVICE(vendor,device,from)  pci_find_device(vendor,device,from)
#define NV_PCI_GET_CLASS(class,from)           pci_find_class(class,from)
#endif

#if defined(CONFIG_X86_UV) && defined(NV_CONFIG_X86_UV)
#define NV_GET_DOMAIN_BUS_AND_SLOT(domain,bus,devfn)                        \
   ({                                                                       \
        struct pci_dev *__dev = NULL;                                       \
        while ((__dev = NV_PCI_GET_DEVICE(PCI_VENDOR_ID_NVIDIA,             \
                    PCI_ANY_ID, __dev)) != NULL)                            \
        {                                                                   \
            if ((NV_PCI_DOMAIN_NUMBER(__dev) == domain) &&                  \
                (NV_PCI_BUS_NUMBER(__dev) == bus) &&                        \
                (NV_PCI_DEVFN(__dev) == devfn))                             \
            {                                                               \
                break;                                                      \
            }                                                               \
        }                                                                   \
        if (__dev == NULL)                                                  \
        {                                                                   \
            while ((__dev = NV_PCI_GET_CLASS((PCI_CLASS_BRIDGE_HOST << 8),  \
                        __dev)) != NULL)                                    \
            {                                                               \
                if ((NV_PCI_DOMAIN_NUMBER(__dev) == domain) &&              \
                    (NV_PCI_BUS_NUMBER(__dev) == bus) &&                    \
                    (NV_PCI_DEVFN(__dev) == devfn))                         \
                {                                                           \
                    break;                                                  \
                }                                                           \
            }                                                               \
        }                                                                   \
        if (__dev == NULL)                                                  \
        {                                                                   \
            while ((__dev = NV_PCI_GET_CLASS((PCI_CLASS_BRIDGE_PCI << 8),   \
                        __dev)) != NULL)                                    \
            {                                                               \
                if ((NV_PCI_DOMAIN_NUMBER(__dev) == domain) &&              \
                    (NV_PCI_BUS_NUMBER(__dev) == bus) &&                    \
                    (NV_PCI_DEVFN(__dev) == devfn))                         \
                {                                                           \
                    break;                                                  \
                }                                                           \
            }                                                               \
        }                                                                   \
        if (__dev == NULL)                                                  \
        {                                                                   \
            while ((__dev = NV_PCI_GET_DEVICE(PCI_ANY_ID, PCI_ANY_ID,       \
                            __dev)) != NULL)                                \
            {                                                               \
                if ((NV_PCI_DOMAIN_NUMBER(__dev) == domain) &&              \
                    (NV_PCI_BUS_NUMBER(__dev) == bus) &&                    \
                    (NV_PCI_DEVFN(__dev) == devfn))                         \
                {                                                           \
                    break;                                                  \
                }                                                           \
            }                                                               \
        }                                                                   \
        __dev;                                                              \
    })
#elif defined(NV_PCI_GET_DOMAIN_BUS_AND_SLOT_PRESENT)
#define NV_GET_DOMAIN_BUS_AND_SLOT(domain,bus, devfn) \
    pci_get_domain_bus_and_slot(domain, bus, devfn)
#elif defined(NV_PCI_GET_CLASS_PRESENT)
#define NV_GET_DOMAIN_BUS_AND_SLOT(domain,bus,devfn)               \
   ({                                                              \
        struct pci_dev *__dev = NULL;                              \
        while ((__dev = NV_PCI_GET_DEVICE(PCI_ANY_ID, PCI_ANY_ID,  \
                    __dev)) != NULL)                               \
        {                                                          \
            if ((NV_PCI_DOMAIN_NUMBER(__dev) == domain) &&         \
                (NV_PCI_BUS_NUMBER(__dev) == bus) &&               \
                (NV_PCI_DEVFN(__dev) == devfn))                    \
            {                                                      \
                break;                                             \
            }                                                      \
        }                                                          \
        __dev;                                                     \
    })
#else
#define NV_GET_DOMAIN_BUS_AND_SLOT(domain,bus,devfn) pci_find_slot(bus,devfn)
#endif

#define NV_PRINT_AT(nv_debug_level,at)                                           \
    {                                                                            \
        nv_printf(nv_debug_level,                                                \
            "NVRM: VM: %s:%d: 0x%p, %d page(s), count = %d, flags = 0x%08x, "    \
            "page_table = 0x%p\n",  __FUNCTION__, __LINE__, at,                  \
            at->num_pages, NV_ATOMIC_READ(at->usage_count),                      \
            at->flags, at->page_table);                                          \
    }

#define NV_PRINT_VMA(nv_debug_level,vma)                                                 \
    {                                                                                    \
        nv_printf(nv_debug_level,                                                        \
            "NVRM: VM: %s:%d: 0x%lx - 0x%lx, 0x%08x bytes @ 0x%016llx, 0x%p, 0x%p\n",    \
            __FUNCTION__, __LINE__, vma->vm_start, vma->vm_end, NV_VMA_SIZE(vma),        \
            NV_VMA_OFFSET(vma), NV_VMA_PRIVATE(vma), NV_VMA_FILE(vma));                  \
    }

/*
 * On Linux 2.6, we support both APM and ACPI power management. On Linux
 * 2.4, we support APM, only. ACPI support has been back-ported to the
 * Linux 2.4 kernel, but the Linux 2.4 driver model is not sufficient for
 * full ACPI support: it may work with some systems, but not reliably
 * enough for us to officially support this configuration.
 *
 * We support two Linux kernel power managment interfaces: the original
 * pm_register()/pm_unregister() on Linux 2.4 and the device driver model
 * backed PCI driver power management callbacks introduced with Linux
 * 2.6.
 *
 * The code below determines which interface to support on this kernel
 * version, if any; if built for Linux 2.6, it will also determine if the
 * kernel comes with ACPI or APM power management support.
 */
#if !defined(NV_VMWARE) && defined(CONFIG_PM)
#define NV_PM_SUPPORT_DEVICE_DRIVER_MODEL
#if (defined(CONFIG_APM) || defined(CONFIG_APM_MODULE)) && !defined(CONFIG_ACPI)
#define NV_PM_SUPPORT_NEW_STYLE_APM
#endif
#endif

/*
 * On Linux 2.6 kernels >= 2.6.11, the PCI subsystem provides a new
 * interface that allows PCI drivers to determine the correct power state
 * for a given system power state; our suspend/resume callbacks now use
 * this interface and operate on PCI power state defines.
 *
 * Define these new PCI power state #define's here for compatibility with
 * older Linux 2.6 kernels.
 */
#if !defined(PCI_D0)
#define PCI_D0 PM_SUSPEND_ON
#define PCI_D3hot PM_SUSPEND_MEM
#endif

#if !defined(NV_PM_MESSAGE_T_PRESENT)
typedef u32 pm_message_t;
#endif

#ifndef minor
# define minor(x) MINOR(x)
#endif

#if defined(cpu_relax)
#define NV_CPU_RELAX() cpu_relax()
#else
#define NV_CPU_RELAX() barrier()
#endif

#ifndef IRQ_RETVAL
typedef void irqreturn_t;
#define IRQ_RETVAL(a)
#endif

#if !defined(PCI_COMMAND_SERR)
#define PCI_COMMAND_SERR            0x100
#endif
#if !defined(PCI_COMMAND_INTX_DISABLE)
#define PCI_COMMAND_INTX_DISABLE    0x400
#endif

#ifndef PCI_CAP_ID_EXP
#define PCI_CAP_ID_EXP 0x10
#endif

/*
 * On Linux on PPC64LE enable basic support for Linux PCI error recovery (see
 * Documentation/PCI/pci-error-recovery.txt). Currently RM only supports error
 * notification and data collection, not actual recovery of the device.
 */
#if defined(NVCPU_PPC64LE)
#define NV_PCI_ERROR_RECOVERY
#define NV_PCI_ERS_BUFFER_SIZE  0x1000
#endif

/*
 * Early 2.6 kernels have acquire_console_sem, but from 2.6.38+ it was
 * renamed to console_lock.
 */
#if defined(NV_ACQUIRE_CONSOLE_SEM_PRESENT)
#define NV_ACQUIRE_CONSOLE_SEM() acquire_console_sem()
#define NV_RELEASE_CONSOLE_SEM() release_console_sem()
#elif defined(NV_CONSOLE_LOCK_PRESENT)
#define NV_ACQUIRE_CONSOLE_SEM() console_lock()
#define NV_RELEASE_CONSOLE_SEM() console_unlock()
#else
#if !defined(NV_VMWARE)
#error "console lock api unrecognized!."
#else
#define NV_ACQUIRE_CONSOLE_SEM()
#define NV_RELEASE_CONSOLE_SEM()
#endif
#endif

/*
 * If the host OS has page sizes larger than 4KB, we may have a security
 * problem. Registers are typically grouped in 4KB pages, but if there are
 * larger pages, then the smallest userspace mapping possible (e.g., a page)
 * may give more access than intended to the user.
 *
 * The kernel may have a workaround for this, by providing a method to isolate
 * a single 4K page in a given mapping.
 */
#if (PAGE_SIZE > NV_RM_PAGE_SIZE)
#if defined(NVCPU_PPC64LE) && defined(_PAGE_4K_PFN)

typedef struct nv_mmap_isolation_s {
    NvP64 access_start;
    NvU64 access_len;
    NvP64 mmap_start;
    NvU64 mmap_len;
} nv_mmap_isolation_t;

#define NV_4K_PAGE_ISOLATION_PRESENT
#define NV_4K_PAGE_ISOLATION_REQUIRED(addr, size)                             \
    (((size) <= NV_RM_PAGE_SIZE) &&                                           \
        (((address) >> NV_RM_PAGE_SHIFT) ==                                   \
            (((address) + (size) - 1) >> NV_RM_PAGE_SHIFT)))
#define NV_4K_PAGE_ISOLATION_MMAP_ADDR(addr)                                  \
    ((NvP64)((void *)(((address) >> NV_RM_PAGE_SHIFT) << PAGE_SHIFT)))
#define NV_4K_PAGE_ISOLATION_MMAP_LEN(size)     PAGE_SIZE
#define NV_4K_PAGE_ISOLATION_ACCESS_START(addr)                               \
    ((NvP64)((void *)((addr) & ~NV_RM_PAGE_MASK)))
#define NV_4K_PAGE_ISOLATION_ACCESS_LEN(addr, size)                           \
    ((((address) & NV_RM_PAGE_MASK) + size + NV_RM_PAGE_MASK) &               \
        ~NV_RM_PAGE_MASK)
#define NV_PROT_4K_PAGE_ISOLATION _PAGE_4K_PFN
#else
#error "The kernel provides no known mechanism to isolate 4KB page mappings!"
#endif
#endif

#if defined(NV_VM_INSERT_PAGE_PRESENT)
#define NV_VM_INSERT_PAGE(vma, addr, page) \
    vm_insert_page(vma, addr, page)
#endif

#if !defined(NV_VMWARE)
static inline int nv_remap_page_range(struct vm_area_struct *vma,
    unsigned long virt_addr, NvU64 phys_addr, NvU64 size, pgprot_t prot)
{
    int ret = -1;
#if defined(NV_REMAP_PFN_RANGE_PRESENT)
#if defined(NV_4K_PAGE_ISOLATION_PRESENT) && defined(NV_PROT_4K_PAGE_ISOLATION)
    if ((size == PAGE_SIZE) &&
        ((pgprot_val(prot) & NV_PROT_4K_PAGE_ISOLATION) != 0))
    {
        /*
         * remap_4k_pfn() hardcodes the length to a single OS page, and checks
         * whether applying the page isolation workaround will cause PTE
         * corruption (in which case it will fail, and this is an unsupported
         * configuration).
         */
        ret = remap_4k_pfn(vma, virt_addr, (phys_addr >> PAGE_SHIFT), prot);
    }
    else
#endif
    {
        ret = remap_pfn_range(vma, virt_addr, (phys_addr >> PAGE_SHIFT), size,
            prot);
    }
#else
    /* 
     * remap_page_range() was replaced by remap_pfn_range() in 2.6.10, but we
     * still support 2.6.9.
     */
    ret = remap_page_range(vma, virt_addr, phys_addr, size, prot);
#endif /* defined(NV_REMAP_PFN_RANGE_PRESENT) */
    return ret;
}

static inline int nv_io_remap_page_range(struct vm_area_struct *vma,
    NvU64 phys_addr, NvU64 size, NvU32 extra_prot)
{
    int ret = -1;
#if !defined(NV_XEN_SUPPORT_FULLY_VIRTUALIZED_KERNEL)
    ret = nv_remap_page_range(vma, vma->vm_start, phys_addr, size,
        __pgprot(pgprot_val(vma->vm_page_prot) | extra_prot));
#else
    ret = io_remap_pfn_range(vma, vma->vm_start, (phys_addr >> PAGE_SHIFT),
        size, __pgprot(pgprot_val(vma->vm_page_prot) | extra_prot));
#endif
    return ret;
}
#endif /* !defined(NV_VMWARE) */

#define NV_PAGE_MASK    (NvU64)(long)PAGE_MASK

#define NV_PGD_OFFSET(address, kernel, mm)              \
   ({                                                   \
        struct mm_struct *__mm = (mm);                  \
        pgd_t *__pgd;                                   \
        if (!kernel)                                    \
            __pgd = pgd_offset(__mm, address);          \
        else                                            \
            __pgd = pgd_offset_k(address);              \
        __pgd;                                          \
    })

#define NV_PGD_PRESENT(pgd)                             \
   ({                                                   \
         if ((pgd != NULL) &&                           \
             (pgd_bad(*pgd) || pgd_none(*pgd)))         \
            /* static */ pgd = NULL;                    \
         pgd != NULL;                                   \
    })

#if defined(pmd_offset_map)
#define NV_PMD_OFFSET(address, pgd)                     \
   ({                                                   \
        pmd_t *__pmd;                                   \
        __pmd = pmd_offset_map(pgd, address);           \
   })
#define NV_PMD_UNMAP(pmd) pmd_unmap(pmd);
#else
#if defined(PUD_SHIFT) /* 4-level pgtable */
#define NV_PMD_OFFSET(address, pgd)                     \
   ({                                                   \
        pmd_t *__pmd = NULL;                            \
        pud_t *__pud;                                   \
        __pud = pud_offset(pgd, address);               \
        if ((__pud != NULL) &&                          \
            !(pud_bad(*__pud) || pud_none(*__pud)))     \
            __pmd = pmd_offset(__pud, address);         \
        __pmd;                                          \
    })
#else /* 3-level pgtable */
#define NV_PMD_OFFSET(address, pgd)                     \
   ({                                                   \
        pmd_t *__pmd;                                   \
        __pmd = pmd_offset(pgd, address);               \
    })
#endif
#define NV_PMD_UNMAP(pmd)
#endif

#define NV_PMD_PRESENT(pmd)                             \
   ({                                                   \
        if ((pmd != NULL) &&                            \
            (pmd_bad(*pmd) || pmd_none(*pmd)))          \
        {                                               \
            NV_PMD_UNMAP(pmd);                          \
            pmd = NULL; /* mark invalid */              \
        }                                               \
        pmd != NULL;                                    \
    })

#if defined(pte_offset_atomic)
#define NV_PTE_OFFSET(address, pmd)                     \
   ({                                                   \
        pte_t *__pte;                                   \
        __pte = pte_offset_atomic(pmd, address);        \
        NV_PMD_UNMAP(pmd); __pte;                       \
    })
#define NV_PTE_UNMAP(pte) pte_kunmap(pte);
#elif defined(pte_offset)
#define NV_PTE_OFFSET(address, pmd)                     \
   ({                                                   \
        pte_t *__pte;                                   \
        __pte = pte_offset(pmd, address);               \
        NV_PMD_UNMAP(pmd); __pte;                       \
    })
#define NV_PTE_UNMAP(pte)
#else
#define NV_PTE_OFFSET(address, pmd)                     \
   ({                                                   \
        pte_t *__pte;                                   \
        __pte = pte_offset_map(pmd, address);           \
        NV_PMD_UNMAP(pmd); __pte;                       \
    })
#define NV_PTE_UNMAP(pte) pte_unmap(pte);
#endif

#define NV_PTE_PRESENT(pte)                             \
   ({                                                   \
        if ((pte != NULL) && !pte_present(*pte))        \
        {                                               \
            NV_PTE_UNMAP(pte);                          \
            pte = NULL; /* mark invalid */              \
        }                                               \
        pte != NULL;                                    \
    })

#define NV_PTE_VALUE(pte)                               \
   ({                                                   \
        unsigned long __pte_value = pte_val(*pte);      \
        NV_PTE_UNMAP(pte);                              \
        __pte_value;                                    \
    })

static inline int nv_calc_order(unsigned int size)
    {
        int order = 0;
        while ( ((1 << order) * PAGE_SIZE) < (size))
        {
            order++;
        }
        return order;
    }

#if !defined(NV_VMWARE)
#if defined(NVCPU_X86) || defined(NVCPU_X86_64)
/* mark memory UC-, rather than UC (don't use _PAGE_PWT) */
static inline pgprot_t pgprot_noncached_weak(pgprot_t old_prot)
    {
        pgprot_t new_prot = old_prot;
        if (boot_cpu_data.x86 > 3)
            new_prot = __pgprot(pgprot_val(old_prot) | _PAGE_PCD);
        return new_prot;
    }

#if !defined (pgprot_noncached)
static inline pgprot_t pgprot_noncached(pgprot_t old_prot)
    {
        pgprot_t new_prot = old_prot;
        if (boot_cpu_data.x86 > 3)
            new_prot = __pgprot(pgprot_val(old_prot) | _PAGE_PCD | _PAGE_PWT);
        return new_prot;
    }
#endif
static inline pgprot_t pgprot_modify_writecombine(pgprot_t old_prot)
    {
        pgprot_t new_prot = old_prot;
        pgprot_val(new_prot) &= ~(_PAGE_PSE | _PAGE_PCD | _PAGE_PWT);
        new_prot = __pgprot(pgprot_val(new_prot) | _PAGE_PWT);
        return new_prot;
    }
#endif /* defined(NVCPU_X86) || defined(NVCPU_X86_64) */
#endif /* !defined(NV_VMWARE) */

#if defined(NVCPU_AARCH64)
/*
 * Don't rely on the kernel's definition of pgprot_noncached(), as on 64-bit
 * ARM that's not for system memory, but device memory instead.
 */
#define NV_PGPROT_UNCACHED(old_prot)    \
    __pgprot_modify(old_prot, PTE_ATTRINDX_MASK, PTE_ATTRINDX(MT_NORMAL_NC))
#else
#define NV_PGPROT_UNCACHED(old_prot)          pgprot_noncached(old_prot)
#endif

#if defined(NVCPU_ARM)
/*
 * Cortex-A15 requires BAR1 accesses to be uncached device.
 * The 32-bit ARM version of pgprot_noncached() notably doesn't add any device
 * bits, so we should use something different for framebuffer memory.
 */
#define NV_PROT_UNCACHED_DEVICE     (__PAGE_SHARED | L_PTE_DIRTY |            \
                                     L_PTE_SHARED | L_PTE_MT_DEV_SHARED)
#define NV_PGPROT_UNCACHED_DEVICE(old_prot)                                   \
    __pgprot_modify(old_prot, L_PTE_MT_MASK, NV_PROT_UNCACHED_DEVICE)
#define NV_PROT_WRITE_COMBINED_DEVICE   (__PAGE_SHARED | L_PTE_DIRTY |        \
                                         L_PTE_MT_DEV_WC)
#define NV_PGPROT_WRITE_COMBINED_DEVICE(old_prot)                             \
    __pgprot_modify(old_prot, L_PTE_MT_MASK, NV_PROT_WRITE_COMBINED_DEVICE)
#define NV_PGPROT_WRITE_COMBINED(old_prot)      pgprot_writecombine(old_prot)
#define NV_PGPROT_READ_ONLY(old_prot)                                         \
    __pgprot_modify(old_prot, 0, pgprot_val(__PAGE_READONLY))
#else
#define NV_PGPROT_UNCACHED_DEVICE(old_prot)     pgprot_noncached(old_prot)
#if defined(NVCPU_AARCH64)
#define NV_PROT_WRITE_COMBINED_DEVICE   (PROT_DEFAULT | PTE_PXN | PTE_UXN |   \
                                         PTE_ATTRINDX(MT_DEVICE_GRE))
#define NV_PGPROT_WRITE_COMBINED_DEVICE(old_prot)                             \
    __pgprot_modify(old_prot, PTE_ATTRINDX_MASK, NV_PROT_WRITE_COMBINED_DEVICE)
#define NV_PGPROT_WRITE_COMBINED(old_prot)      NV_PGPROT_UNCACHED(old_prot)
#define NV_PGPROT_READ_ONLY(old_prot)                                         \
            __pgprot_modify(old_prot, 0, PTE_RDONLY)
#elif defined(NVCPU_X86) || defined(NVCPU_X86_64)
#define NV_PGPROT_UNCACHED_WEAK(old_prot)       pgprot_noncached_weak(old_prot)
#define NV_PGPROT_WRITE_COMBINED_DEVICE(old_prot)                             \
    pgprot_modify_writecombine(old_prot)
#define NV_PGPROT_WRITE_COMBINED(old_prot)                                    \
    NV_PGPROT_WRITE_COMBINED_DEVICE(old_prot)
#define NV_PGPROT_READ_ONLY(old_prot)                                         \
    __pgprot(pgprot_val((old_prot)) & ~_PAGE_RW)
#elif defined(NVCPU_PPC64LE)
#define NV_PGPROT_WRITE_COMBINED_DEVICE(old_prot)                             \
    pgprot_writecombine(old_prot)
#define NV_PGPROT_WRITE_COMBINED(old_prot)                                    \
    NV_PGPROT_WRITE_COMBINED_DEVICE(old_prot)
#define NV_PGPROT_READ_ONLY(old_prot)                                         \
    __pgprot(pgprot_val((old_prot)) & ~_PAGE_RW)
#else
/* Writecombine is not supported */
#undef NV_PGPROT_WRITE_COMBINED_DEVICE(old_prot)
#undef NV_PGPROT_WRITE_COMBINED(old_prot)
#define NV_PGPROT_READ_ONLY(old_prot)
#endif
#endif

#if defined(NVCPU_FAMILY_ARM) || defined(NVCPU_PPC64LE)
#define NV_ALLOW_WRITE_COMBINING(mt)    1
#elif (defined(NVCPU_X86) || defined(NVCPU_X86_64))
#if defined(NV_ENABLE_PAT_SUPPORT)
#define NV_ALLOW_WRITE_COMBINING(mt)    \
    ((nv_pat_mode != NV_PAT_MODE_DISABLED) && \
     ((mt) != NV_MEMORY_TYPE_REGISTERS))
#else
#define NV_ALLOW_WRITE_COMBINING(mt)    0
#endif
#endif

#if defined(NVCPU_X86) || defined(NVCPU_X86_64)
/*
 * RAM is cached on Linux by default, we can assume there's
 * nothing to be done here. This is not the case for the
 * other memory spaces: we will have made an attempt to add
 * a WC MTRR for the frame buffer.
 *
 * If a WC MTRR is present, we can't satisfy the WB mapping
 * attempt here, since the achievable effective memory
 * types in that case are WC and UC, if not it's typically
 * UC (MTRRdefType is UC); we could only satisfy WB mapping
 * requests with a WB MTRR.
 */
#define NV_ALLOW_CACHING(mt)            ((mt) == NV_MEMORY_TYPE_SYSTEM)
#else
#define NV_ALLOW_CACHING(mt)            ((mt) != NV_MEMORY_TYPE_REGISTERS)
#endif

typedef struct nv_pte_s {
    NvU64           phys_addr;
    unsigned long   virt_addr;
    NvU64           dma_addr;
#ifdef CONFIG_XEN
    unsigned int    guest_pfn;
#endif
#ifdef NV_SG_MAP_BUFFERS
    NvBool          dma_mapped;
    struct scatterlist sg_list;
#endif
    unsigned int    page_count;
} nv_pte_t;

typedef struct nv_alloc_s {
    struct nv_alloc_s *next;
    struct pci_dev    *dev;
    atomic_t       usage_count;
    unsigned int   flags;
    unsigned int   num_pages;
    unsigned int   order;
    unsigned int   size;
    nv_pte_t     **page_table;          /* list of physical pages allocated */
    unsigned int   pid;
    NvU64         guest_id;             /* id of guest VM */
} nv_alloc_t;

#define NV_ALLOC_TYPE_PCI      (1<<0)
#define NV_ALLOC_TYPE_CONTIG   (1<<2)
#define NV_ALLOC_TYPE_GUEST    (1<<3)
#define NV_ALLOC_TYPE_ZEROED   (1<<4)
#define NV_ALLOC_TYPE_ALIASED  (1<<5)

#define NV_ALLOC_MAPPING_SHIFT      16
#define NV_ALLOC_MAPPING(flags)     (((flags)>>NV_ALLOC_MAPPING_SHIFT)&0xff)
#define NV_ALLOC_ENC_MAPPING(flags) ((flags)<<NV_ALLOC_MAPPING_SHIFT)

#define NV_ALLOC_MAPPING_CACHED(flags)        (NV_ALLOC_MAPPING(flags) == NV_MEMORY_CACHED)
#define NV_ALLOC_MAPPING_UNCACHED(flags)      (NV_ALLOC_MAPPING(flags) == NV_MEMORY_UNCACHED)
#define NV_ALLOC_MAPPING_WRITECOMBINED(flags) (NV_ALLOC_MAPPING(flags) == NV_MEMORY_WRITECOMBINED)

#define NV_ALLOC_MAPPING_CONTIG(flags)  ((flags) & NV_ALLOC_TYPE_CONTIG)
#define NV_ALLOC_MAPPING_GUEST(flags)   ((flags) & NV_ALLOC_TYPE_GUEST)
#define NV_ALLOC_MAPPING_ALIASED(flags) ((flags) & NV_ALLOC_TYPE_ALIASED)

static inline NvU32 nv_alloc_init_flags(int cached, int contiguous, int zeroed)
{
    NvU32 flags = NV_ALLOC_ENC_MAPPING(cached);
    flags |= NV_ALLOC_TYPE_PCI;
    if (contiguous)
        flags |= NV_ALLOC_TYPE_CONTIG;
    if (zeroed)
        flags |= NV_ALLOC_TYPE_ZEROED;
#if defined(NVCPU_FAMILY_ARM)
    if (!NV_ALLOC_MAPPING_CACHED(flags))
        flags |= NV_ALLOC_TYPE_ALIASED;
#endif
    return flags;
}

/*
 * TODO: Bug 1522381 will allow us to move these mapping relationships into
 *       common code.
 */
typedef struct nv_dma_map_s {
    struct page **user_pages;
    NvU64 page_count;
    NvU64 sg_map_count;
#if defined(NV_SG_TABLE_PRESENT)
    struct sg_table sgt;
#else
    struct scatterlist *sgl;
#endif
    struct pci_dev *dev;
} nv_dma_map_t;

#if defined(NV_SG_TABLE_PRESENT)
#define NV_DMA_MAP_SCATTERLIST(dm)          dm->sgt.sgl
#define NV_DMA_MAP_SCATTERLIST_LENGTH(dm)   dm->sgt.orig_nents
#else
#define NV_DMA_MAP_SCATTERLIST(dm)          dm->sgl
#define NV_DMA_MAP_SCATTERLIST_LENGTH(dm)   dm->page_count
#endif

#if defined(for_each_sg)
    #define NV_FOR_EACH_DMA_MAP_SG(d, s, i)                                   \
        for_each_sg(NV_DMA_MAP_SCATTERLIST((d)), (s), (d)->sg_map_count, (i))
#else
    #define NV_FOR_EACH_DMA_MAP_SG(d, s, i)                                   \
        for ((i) = 0, (s) = &NV_DMA_MAP_SCATTERLIST(d)[0];                    \
             (i) < (d)->sg_map_count; (s) = &NV_DMA_MAP_SCATTERLIST(d)[++i])
#endif

#if defined(NV_SG_ALLOC_TABLE_FROM_PAGES_PRESENT)
    #define NV_ALLOC_DMA_MAP_SCATTERLIST(dm)                                  \
        ((sg_alloc_table_from_pages(&dm->sgt, dm->user_pages, dm->page_count, \
            0, dm->page_count * PAGE_SIZE, NV_GFP_KERNEL) == 0) ? RM_OK :     \
                RM_ERR_OPERATING_SYSTEM)

#else /* !defined(NV_SG_ALLOC_TABLE_FROM_PAGES_PRESENT) */
    #if defined(NV_SG_TABLE_PRESENT)
        #if defined(NV_SG_ALLOC_TABLE_PRESENT)
            #define NV_ALLOC_DMA_MAP_SCATTERLIST(dm)                          \
                ((sg_alloc_table(&dm->sgt, dm->page_count, NV_GFP_KERNEL)) == \
                    0 ? RM_OK : RM_ERR_OPERATING_SYSTEM)

        #else
            #error "No known allocation function for sg_table present!"
        #endif
    #else /* !defined(NV_SG_TABLE_PRESENT) */
        #define NV_ALLOC_DMA_MAP_SCATTERLIST(dm)                              \
            os_alloc_mem((void **)&dm->sgl,                                   \
                dm->page_count * sizeof(struct scatterlist))

    #endif /* defined(NV_SG_TABLE_PRESENT) */

#endif /* defined(NV_SG_ALLOC_TABLE_FROM_PAGES_PRESENT) */

typedef struct work_struct nv_task_t;

typedef struct nv_work_s {
    nv_task_t task;
    void *data;
} nv_work_t;

#define NV_TASKQUEUE_SCHEDULE(work) schedule_work(work)
#define NV_TASKQUEUE_FLUSH()                           \
    flush_scheduled_work();
#if (NV_INIT_WORK_ARGUMENT_COUNT == 2)
#define NV_TASKQUEUE_INIT(tq,handler,data)             \
    {                                                  \
        struct work_struct __work =                    \
            __WORK_INITIALIZER(*(tq), handler);        \
        *(tq) = __work;                                \
    }
#define NV_TASKQUEUE_DATA_T nv_task_t
#define NV_TASKQUEUE_UNPACK_DATA(tq)                   \
    container_of((tq), nv_work_t, task)
#elif (NV_INIT_WORK_ARGUMENT_COUNT == 3)
#define NV_TASKQUEUE_INIT(tq,handler,data)             \
    {                                                  \
        struct work_struct __work =                    \
            __WORK_INITIALIZER(*(tq), handler, data);  \
        *(tq) = __work;                                \
    }
#define NV_TASKQUEUE_DATA_T void
#define NV_TASKQUEUE_UNPACK_DATA(tq) (nv_work_t *)(tq)
#else
#error "NV_INIT_WORK_ARGUMENT_COUNT value unrecognized!"
#endif

#define NV_MAX_REGISTRY_KEYS_LENGTH   512

/* linux-specific version of old nv_state_t */
/* this is a general os-specific state structure. the first element *must* be
   the general state structure, for the generic unix-based code */
typedef struct nv_linux_state_s {
    nv_state_t nv_state;
    atomic_t usage_count;

    struct pci_dev *dev;

    nv_stack_t *timer_sp;
    nv_stack_t *isr_sp;
    nv_stack_t *pci_cfgchk_sp;
    nv_stack_t *isr_bh_sp;

    char registry_keys[NV_MAX_REGISTRY_KEYS_LENGTH];

    /* keep track of any pending bottom halfes */
    struct tasklet_struct tasklet;
    nv_work_t work;

    /* get a timer callback every second */
    struct timer_list rc_timer;

    /* lock for linux-specific data, not used by core rm */
    struct semaphore ldata_lock;

    /* proc directory information */
    struct proc_dir_entry *proc_dir;

    NvU32 minor_num;
    struct nv_linux_state_s *next;

    /* DRM private information */
    struct drm_device *drm;
} nv_linux_state_t;

#if defined(NV_LINUX_ACPI_EVENTS_SUPPORTED)
/*
 * acpi data storage structure
 *
 * This structure retains the pointer to the device,
 * and any other baggage we want to carry along
 *
 */
#define NV_MAXNUM_DISPLAY_DEVICES 8

typedef struct
{
    acpi_handle dev_handle;
    int dev_id;
} nv_video_t;

typedef struct
{
    nv_stack_t *sp;
    struct acpi_device *device;

    nv_video_t pNvVideo[NV_MAXNUM_DISPLAY_DEVICES];

    int notify_handler_installed;
    int default_display_mask;
} nv_acpi_t;

#endif

/*
 * file-private data
 * hide a pointer to our data structures in a file-private ptr
 * there are times we need to grab this data back from the file
 * data structure..
 */

typedef struct nvidia_event
{
    struct nvidia_event *next;
    nv_event_t event;
} nvidia_event_t;

typedef enum
{
    NV_FOPS_STACK_INDEX_MMAP,
    NV_FOPS_STACK_INDEX_IOCTL,
    NV_FOPS_STACK_INDEX_PROCFS,
    NV_FOPS_STACK_INDEX_COUNT
} nvidia_entry_point_index_t;

typedef struct
{
    nv_stack_t *sp;
    nv_stack_t *fops_sp[NV_FOPS_STACK_INDEX_COUNT];
    struct semaphore fops_sp_lock[NV_FOPS_STACK_INDEX_COUNT];
    nv_alloc_t *free_list;
    void *nvptr;
    void *proc_data;
    void *data;
    nvidia_event_t *event_head, *event_tail;
    int event_pending;
    nv_spinlock_t fp_lock;
    wait_queue_head_t waitqueue;
    off_t off;
    NvU32 minor_num;
} nv_file_private_t;

#define NV_SET_FILE_PRIVATE(filep,data) ((filep)->private_data = (data))
#define NV_GET_FILE_PRIVATE(filep) ((nv_file_private_t *)(filep)->private_data)

/* for the card devices */
#define NV_GET_NVL_FROM_FILEP(filep)    (NV_GET_FILE_PRIVATE(filep)->nvptr)
#define NV_GET_NVL_FROM_NV_STATE(nv)    ((nv_linux_state_t *)nv->os_state)

#define NV_STATE_PTR(nvl)   (&((nvl)->nv_state))


#define NV_ATOMIC_SET(data,val)         atomic_set(&(data), (val))
#define NV_ATOMIC_INC(data)             atomic_inc(&(data))
#define NV_ATOMIC_DEC(data)             atomic_dec(&(data))
#define NV_ATOMIC_DEC_AND_TEST(data)    atomic_dec_and_test(&(data))
#define NV_ATOMIC_READ(data)            atomic_read(&(data))

#if (defined(CONFIG_X86_LOCAL_APIC) || defined(NVCPU_FAMILY_ARM) || \
     defined(NVCPU_PPC64LE)) && \
    (defined(CONFIG_PCI_MSI) || defined(CONFIG_PCI_USE_VECTOR))
#define NV_LINUX_PCIE_MSI_SUPPORTED
#endif

#if !defined(NV_LINUX_PCIE_MSI_SUPPORTED) || !defined(CONFIG_PCI_MSI)
#define NV_PCI_DISABLE_MSI(dev)
#else
#define NV_PCI_DISABLE_MSI(dev)         pci_disable_msi(dev)
#endif

#if (NV_PCI_SAVE_STATE_ARGUMENT_COUNT == 2)
/*
 * On Linux 2.6.9, pci_(save|restore)_state() requires a storage buffer to be
 * passed in by the caller. This went away in 2.6.10, so until we can drop
 * this support, use the original config space storage buffer for this call.
 */
static inline void nv_pci_save_state(struct pci_dev *dev)
{
    nv_linux_state_t *nvl = pci_get_drvdata(dev);
    nv_state_t *nv = NV_STATE_PTR(nvl);
    pci_save_state(dev, &nv->pci_cfg_space[0]);
}

static inline void nv_pci_restore_state(struct pci_dev *dev)
{
    nv_linux_state_t *nvl = pci_get_drvdata(dev);
    nv_state_t *nv = NV_STATE_PTR(nvl);
    pci_restore_state(dev, &nv->pci_cfg_space[0]);
}
#else
#define nv_pci_save_state(dev)      pci_save_state(dev)
#define nv_pci_restore_state(dev)   pci_restore_state(dev)
#endif

#define NV_PCIE_CFG_MAX_OFFSET 0x1000

#define NV_SHUTDOWN_ADAPTER(sp,nv,nvl)                              \
    {                                                               \
        rm_disable_adapter(sp, nv);                                 \
        tasklet_kill(&nvl->tasklet);                                \
        free_irq(nv->interrupt_line, (void *)nvl);                  \
        if (nv->flags & NV_FLAG_USES_MSI)                           \
            NV_PCI_DISABLE_MSI(nvl->dev);                           \
        rm_shutdown_adapter(sp, nv);                                \
    }

/*
 * Verify that access to PCI configuration space wasn't modified
 * by a third party.  Unfortunately, some X servers disable
 * memory access in PCI configuration space at various times (such
 * as when restoring initial PCI configuration space settings
 * during VT switches or when driving multiple GPUs), which may
 * cause BAR[n] reads/writes to fail and/or inhibit GPU initiator
 * functionality.
 */
#define NV_CHECK_PCI_CONFIG_SPACE(sp,nv,cb,as,mb)                   \
    {                                                               \
        if (!NV_IS_GVI_DEVICE(nv) &&                                \
            (((nv)->flags & NV_FLAG_SKIP_CFG_CHECK) == 0) &&        \
            (((nv)->flags & NV_FLAG_CONTROL) == 0))                 \
        {                                                           \
            if ((nv)->flags & NV_FLAG_USE_BAR0_CFG)                 \
                rm_check_pci_config_space(sp, nv, cb, as, mb);      \
            else                                                    \
                nv_check_pci_config_space(nv, cb);                  \
        }                                                           \
    }

extern int nv_update_memory_types;

#if defined(NVCPU_X86) || defined(NVCPU_X86_64)
/*
 * On Linux/x86-64 (and recent Linux/x86) kernels, the PAGE_KERNEL
 * and PAGE_KERNEL_NOCACHE protection bit masks include _PAGE_NX
 * to indicate that the no-execute protection page feature is used
 * for the page in question.
 *
 * We need to be careful to mask out _PAGE_NX when the host system
 * doesn't support this feature or when it's disabled: the kernel
 * may not do this in its implementation of the change_page_attr()
 * interface.
 */
#ifndef X86_FEATURE_NX
#define X86_FEATURE_NX (1*32+20)
#endif
#ifndef boot_cpu_has
#define boot_cpu_has(x) test_bit(x, boot_cpu_data.x86_capability)
#endif
#ifndef MSR_EFER
#define MSR_EFER 0xc0000080
#endif
#ifndef EFER_NX
#define EFER_NX (1 << 11)
#endif
#ifndef _PAGE_NX
#define _PAGE_NX ((NvU64)1 << 63)
#endif
extern NvU64 __nv_supported_pte_mask;
#endif

#include "nv-proto.h"

extern nv_pci_info_t nv_assign_gpu_pci_info[NV_MAX_DEVICES];
extern NvU32 nv_assign_gpu_count;

#define NV_IS_ASSIGN_GPU_PCI_INFO_SPECIFIED()     \
    (!((nv_assign_gpu_pci_info[0].domain == 0) && \
       (nv_assign_gpu_pci_info[0].bus == 0) &&    \
       (nv_assign_gpu_pci_info[0].slot == 0)))


#if defined(CONFIG_PROC_FS)

#if defined(NV_PROC_DIR_ENTRY_HAS_OWNER)
#define NV_SET_PROC_ENTRY_OWNER(entry) ((entry)->owner = THIS_MODULE)
#else
#define NV_SET_PROC_ENTRY_OWNER(entry)
#endif

#if defined(NV_PROC_CREATE_DATA_PRESENT)
# define NV_CREATE_PROC_ENTRY(name,mode,parent,fops,__data) \
    proc_create_data(name, __mode, parent, fops, __data)
#else
# define NV_CREATE_PROC_ENTRY(name,mode,parent,fops,__data) \
   ({                                                       \
        struct proc_dir_entry *__entry;                     \
        __entry = create_proc_entry(name, mode, parent);    \
        if (__entry != NULL)                                \
        {                                                   \
            NV_SET_PROC_ENTRY_OWNER(__entry);               \
            __entry->proc_fops = fops;                      \
            __entry->data = (__data);                       \
        }                                                   \
        __entry;                                            \
    })
#endif

#define NV_CREATE_PROC_FILE(filename,parent,__name,__data)               \
   ({                                                                    \
        struct proc_dir_entry *__entry;                                  \
        int __mode = (S_IFREG | S_IRUGO);                                \
        const struct file_operations *fops = &nv_procfs_##__name##_fops; \
        if (fops->write != 0)                                            \
            __mode |= S_IWUSR;                                           \
        __entry = NV_CREATE_PROC_ENTRY(filename, __mode, parent, fops,   \
            __data);                                                     \
        __entry;                                                         \
    })

/*
 * proc_mkdir_mode exists in Linux 2.6.9, but isn't exported until Linux 3.0.
 * Use the older interface instead unless the newer interface is necessary.
 */
#if defined(NV_PROC_REMOVE_PRESENT)
# define NV_PROC_MKDIR_MODE(name, mode, parent)                \
    proc_mkdir_mode(name, mode, parent)
#else
# define NV_PROC_MKDIR_MODE(name, mode, parent)                \
   ({                                                          \
        struct proc_dir_entry *__entry;                        \
        __entry = create_proc_entry(name, mode, parent);       \
        if (__entry != NULL)                                   \
            NV_SET_PROC_ENTRY_OWNER(__entry);                  \
        __entry;                                               \
    })
#endif

#define NV_CREATE_PROC_DIR(name,parent)                        \
   ({                                                          \
        struct proc_dir_entry *__entry;                        \
        int __mode = (S_IFDIR | S_IRUGO | S_IXUGO);            \
        __entry = NV_PROC_MKDIR_MODE(name, __mode, parent);    \
        __entry;                                               \
    })

#if defined(NV_PDE_DATA_PRESENT)
# define NV_PDE_DATA(inode) PDE_DATA(inode)
#else
# define NV_PDE_DATA(inode) PDE(inode)->data
#endif

#if defined(NV_PROC_REMOVE_PRESENT)
# define NV_REMOVE_PROC_ENTRY(entry)                           \
    proc_remove(entry);
#else
# define NV_REMOVE_PROC_ENTRY(entry)                           \
    remove_proc_entry(entry->name, entry->parent);
#endif

#define NV_DEFINE_PROCFS_SINGLE_FILE(__name)                                  \
    static int nv_procfs_open_##__name(                                       \
        struct inode *inode,                                                  \
        struct file *filep                                                    \
    )                                                                         \
    {                                                                         \
        return single_open(filep, nv_procfs_read_##__name,                    \
            NV_PDE_DATA(inode));                                              \
    }                                                                         \
                                                                              \
    static const struct file_operations nv_procfs_##__name##_fops = {         \
        .owner      = THIS_MODULE,                                            \
        .open       = nv_procfs_open_##__name,                                \
        .read       = seq_read,                                               \
        .llseek     = seq_lseek,                                              \
        .release    = single_release,                                         \
    };

#endif  /* CONFIG_PROC_FS */

#if defined(NV_FILE_HAS_INODE)
#define NV_FILE_INODE(file) (file)->f_inode
#else
#define NV_FILE_INODE(file) (file)->f_dentry->d_inode
#endif

/* Stub out UVM in multi-RM builds */

#if (NV_BUILD_MODULE_INSTANCES != 0)
#undef NV_UVM_ENABLE
#undef NV_UVM_NEXT_ENABLE
#endif

#if defined(NV_DOM0_KERNEL_PRESENT)
#define NV_VGX_HYPER
#endif

#endif  /* _NV_LINUX_H_ */
