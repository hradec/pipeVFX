/* _NVRM_COPYRIGHT_BEGIN_
 *
 * Copyright 1999-2014 by NVIDIA Corporation.  All rights reserved.  All
 * information contained herein is proprietary and confidential to NVIDIA
 * Corporation.  Any use, reproduction, or disclosure without the written
 * permission of NVIDIA Corporation is prohibited.
 *
 * _NVRM_COPYRIGHT_END_
 */


#ifndef _NV_H_
#define _NV_H_

#include <nvtypes.h>
#include <stdarg.h>

#if !defined(NV_MIN)
#define NV_MIN(_a,_b) ((_a) < (_b) ? (_a) : (_b))
#endif
#if !defined(NV_MAX)
#define NV_MAX(_a,_b) ((_a) > (_b) ? (_a) : (_b))
#endif

/* NVIDIA's reserved major character device number (Linux). */
#define NV_MAJOR_DEVICE_NUMBER 195

/* most cards in a single system */
#define NV_MAX_DEVICES 32

typedef struct {
    NvU32    domain;        /* PCI domain number   */
    NvU8     bus;           /* PCI bus number      */
    NvU8     slot;          /* PCI slot number     */
    NvU8     function;      /* PCI function number */
    NvU16    vendor_id;     /* PCI vendor ID       */
    NvU16    device_id;     /* PCI device ID       */
    NvBool   valid;         /* validation flag     */
} nv_pci_info_t;

/* NOTE: using an ioctl() number > 55 will overflow! */
#define NV_IOCTL_MAGIC      'F'
#define NV_IOCTL_BASE       200
#define NV_ESC_CARD_INFO         (NV_IOCTL_BASE + 0)
#define NV_ESC_ENV_INFO          (NV_IOCTL_BASE + 2)
#define NV_ESC_ALLOC_OS_EVENT    (NV_IOCTL_BASE + 6)
#define NV_ESC_FREE_OS_EVENT     (NV_IOCTL_BASE + 7)
#define NV_ESC_STATUS_CODE       (NV_IOCTL_BASE + 9)
#define NV_ESC_CHECK_VERSION_STR (NV_IOCTL_BASE + 10)
#define NV_ESC_IOCTL_XFER_CMD    (NV_IOCTL_BASE + 11)

#if defined(NV_SUNOS)
#define NV_PLATFORM_MAX_IOCTL_SIZE  255
#elif (defined(NV_LINUX) || defined(NV_BSD) || defined(NV_VMWARE))
#define NV_PLATFORM_MAX_IOCTL_SIZE  4096
#else
#error "The maximum ioctl() argument size is undefined!"
#endif

/*
 * #define an absolute maximum used as a sanity check for the
 * NV_ESC_IOCTL_XFER_CMD ioctl() size argument.
 */
#define NV_ABSOLUTE_MAX_IOCTL_SIZE  4096

/*
 * Solaris provides no more than 8 bits for the argument size in
 * the ioctl() command encoding; make sure we don't exceed this
 * limit.
 */
#define __NV_IOWR_ASSERT(type) ((sizeof(type) <= NV_PLATFORM_MAX_IOCTL_SIZE) ? 1 : -1)
#define __NV_IOWR(nr, type) ({                                        \
    typedef char __NV_IOWR_TYPE_SIZE_ASSERT[__NV_IOWR_ASSERT(type)];  \
    _IOWR(NV_IOCTL_MAGIC, (nr), type);                                \
})

/*
 * ioctl()'s with parameter structures too large for the
 * _IOC cmd layout use the nv_ioctl_xfer_t structure
 * and the NV_ESC_IOCTL_XFER_CMD ioctl() to pass the actual
 * size and user argument pointer into the RM, which
 * will then copy it to/from kernel space in separate steps.
 */
typedef struct nv_ioctl_xfer
{
    NvU32   cmd;
    NvU32   size;
    NvP64   ptr  NV_ALIGN_BYTES(8);
} nv_ioctl_xfer_t;

typedef struct nv_ioctl_card_info
{
    NvU16         flags;               /* see below                   */
    nv_pci_info_t pci_info;            /* PCI config information      */
    NvU32         gpu_id;
    NvU16         interrupt_line;
    NvU64         reg_address    NV_ALIGN_BYTES(8);
    NvU64         reg_size       NV_ALIGN_BYTES(8);
    NvU64         fb_address     NV_ALIGN_BYTES(8);
    NvU64         fb_size        NV_ALIGN_BYTES(8);
    NvU32         minor_number;
} nv_ioctl_card_info_t;

#define NV_IOCTL_CARD_INFO_BUS_TYPE_PCI            0x0001
#define NV_IOCTL_CARD_INFO_BUS_TYPE_AGP            0x0002
#define NV_IOCTL_CARD_INFO_BUS_TYPE_PCI_EXPRESS    0x0003

#define NV_IOCTL_CARD_INFO_FLAG_PRESENT       0x0001

#define SIM_ENV_GPU       0
#define SIM_ENV_IKOS      1
#define SIM_ENV_CSIM      2

#define NV_SLI_DISABLED   0
#define NV_SLI_ENABLED    1

typedef struct nv_ioctl_env_info
{
    NvU32 pat_supported;
} nv_ioctl_env_info_t;

/* old rm api check
 *
 * this used to be used to verify client/rm interaction both ways by
 * overloading the structure passed into the NV_IOCTL_CARD_INFO ioctl.
 * This interface is deprecated and NV_IOCTL_CHECK_VERSION_STR should
 * be used instead.  We keep the structure and defines here so that RM
 * can recognize and handle old clients.
 */
typedef struct nv_ioctl_rm_api_old_version
{
    NvU32 magic;
    NvU32 major;
    NvU32 minor;
    NvU32 patch;
} nv_ioctl_rm_api_old_version_t;

#define NV_RM_API_OLD_VERSION_MAGIC_REQ              0x0197fade
#define NV_RM_API_OLD_VERSION_MAGIC_REP              0xbead2929
#define NV_RM_API_OLD_VERSION_MAGIC_LAX_REQ         (NV_RM_API_OLD_VERSION_MAGIC_REQ ^ '1')
#define NV_RM_API_OLD_VERSION_MAGIC_OVERRIDE_REQ    (NV_RM_API_OLD_VERSION_MAGIC_REQ ^ '2')
#define NV_RM_API_OLD_VERSION_MAGIC_IGNORE           0xffffffff

typedef enum {
    NV_CPU_TYPE_UNKNOWN = 0,
    NV_CPU_TYPE_ARM_A9
} nv_cpu_type_t;

/* alloc event */
typedef struct nv_ioctl_alloc_os_event
{
    NvU32 hClient;
    NvU32 hDevice;
    NvU32 hOsEvent;
    NvU32 fd;
    NvU32 Status;
} nv_ioctl_alloc_os_event_t;

/* free event */
typedef struct nv_ioctl_free_os_event
{
    NvU32 hClient;
    NvU32 hDevice;
    NvU32 fd;
    NvU32 Status;
} nv_ioctl_free_os_event_t;

#define NV_CTL_DEVICE_PCI_DOMAIN        0
#define NV_CTL_DEVICE_PCI_BUS           255
#define NV_CTL_DEVICE_PCI_SLOT          255

#define NV_PCI_MATCH_CTL_DEVICE(domain, bus, slot) \
    (((domain) == NV_CTL_DEVICE_PCI_DOMAIN) && \
     ((bus) == NV_CTL_DEVICE_PCI_BUS) && ((slot) == NV_CTL_DEVICE_PCI_SLOT))

#define NV_PCI_DEV_FMT          "%04x:%02x:%02x.%x"
#define NV_PCI_DEV_FMT_ARGS(nv) (nv)->pci_info.domain, (nv)->pci_info.bus, \
                                (nv)->pci_info.slot, (nv)->pci_info.function

/* status code */
typedef struct nv_ioctl_status_code
{
    NvU32 domain;
    NvU8  bus;
    NvU8  slot;
    NvU32 status;
} nv_ioctl_status_code_t;

/* check version string */
#define NV_RM_API_VERSION_STRING_LENGTH 64

typedef struct nv_ioctl_rm_api_version
{
    NvU32 cmd;
    NvU32 reply;
    char versionString[NV_RM_API_VERSION_STRING_LENGTH];
} nv_ioctl_rm_api_version_t;

#define NV_RM_API_VERSION_CMD_STRICT         0
#define NV_RM_API_VERSION_CMD_RELAXED       '1'
#define NV_RM_API_VERSION_CMD_OVERRIDE      '2'

#define NV_RM_API_VERSION_REPLY_UNRECOGNIZED 0
#define NV_RM_API_VERSION_REPLY_RECOGNIZED   1

#ifdef NVRM

extern const char *pNVRM_ID;

/*
 * ptr arithmetic convenience
 */

typedef union
{
    volatile NvV8 Reg008[1];
    volatile NvV16 Reg016[1];
    volatile NvV32 Reg032[1];
} nv_hwreg_t, * nv_phwreg_t;


#define NVRM_PCICFG_NUM_BARS            6
#define NVRM_PCICFG_BAR_OFFSET(i)       (0x10 + (i) * 4)
#define NVRM_PCICFG_BAR_REQTYPE_MASK    0x00000001
#define NVRM_PCICFG_BAR_REQTYPE_MEMORY  0x00000000
#define NVRM_PCICFG_BAR_MEMTYPE_MASK    0x00000006
#define NVRM_PCICFG_BAR_MEMTYPE_64BIT   0x00000004
#define NVRM_PCICFG_BAR_ADDR_MASK       0xfffffff0

#define NVRM_PCICFG_NUM_DWORDS          16

#define NV_GPU_NUM_BARS                 3
#define NV_GPU_BAR_INDEX_REGS           0
#define NV_GPU_BAR_INDEX_FB             1
#define NV_GPU_BAR_INDEX_IMEM           2

typedef struct
{
    NvU64 cpu_address;
    NvU64 bus_address;
    NvU64 strapped_size;
    NvU64 size;
    NvU32 offset;
    NvU32 *map;
    nv_phwreg_t map_u;
} nv_aperture_t;

typedef struct
{
    char *node;
    char *name;
    NvU32 *data;
} nv_parm_t;

#define NV_RM_PAGE_SHIFT    12
#define NV_RM_PAGE_SIZE     (1 << NV_RM_PAGE_SHIFT)
#define NV_RM_PAGE_MASK     (NV_RM_PAGE_SIZE - 1)

#define NV_RM_TO_OS_PAGE_SHIFT      (OS_PAGE_SHIFT - NV_RM_PAGE_SHIFT)
#define NV_RM_PAGES_PER_OS_PAGE     (1U << NV_RM_TO_OS_PAGE_SHIFT)
#define NV_RM_PAGES_TO_OS_PAGES(count) \
    ((((NvUPtr)(count)) >> NV_RM_TO_OS_PAGE_SHIFT) + \
     ((((count) & ((1 << NV_RM_TO_OS_PAGE_SHIFT) - 1)) != 0) ? 1 : 0))

#if defined(NVCPU_X86_64)
#define NV_STACK_SIZE (NV_RM_PAGE_SIZE * 3)
#else
#define NV_STACK_SIZE (NV_RM_PAGE_SIZE * 2)
#endif

typedef struct nv_stack_s
{
    NvU32 size;
    void *top;
    NvU8  stack[NV_STACK_SIZE-16] __attribute__ ((aligned(16)));
} nv_stack_t;

/*
 * this is a wrapper for unix events
 * unlike the events that will be returned to clients, this includes
 * kernel-specific data, such as file pointer, etc..
 */
typedef struct nv_event_s
{
    NvU32 hParent;
    NvU32 hObject;
    NvU32 index;
    void  *file;  /* per file-descriptor data pointer */
    NvU32 handle;
    NvU32 fd;
    struct nv_event_s *next;
} nv_event_t;

typedef struct nv_kern_mapping_s
{
    void  *addr;
    NvU64 size;
    struct nv_kern_mapping_s *next;
} nv_kern_mapping_t;

typedef struct nv_mmap_context_s
{
    NvP64 addr;
    NvU64 size;
    NvU32 process_id;
    NvU32 thread_id;
    void *file;
    void *os_priv;
    struct nv_mmap_context_s *next;
} nv_mmap_context_t;

/*
 * per device state
 */

typedef struct
{
    void  *priv;                    /* private data */
    void  *os_state;                /* os-specific device state */

    int    flags;

    /* PCI config info */
    nv_pci_info_t pci_info;
    NvU16 subsystem_id;
    NvU32 gpu_id;
    void *handle;

    NvU32 pci_cfg_space[NVRM_PCICFG_NUM_DWORDS];

    /* physical characteristics */
    nv_aperture_t bars[NV_GPU_NUM_BARS];
    nv_aperture_t *regs;
    nv_aperture_t *fb, ud;

    NvU32  interrupt_line;

    NvBool primary_vga;

    NvU32 sim_env;

    NvU32 rc_timer_enabled;

    /* list of events allocated for this device */
    nv_event_t *event_list;

    nv_kern_mapping_t *kern_mappings;

    nv_mmap_context_t *mmap_contexts;
 
    /* DMA addressable range of the device */
    NvU64 dma_addressable_start;
    NvU64 dma_addressable_limit;
} nv_state_t;

// Forward define the gpu ops structures
typedef struct gpuSession      *nvgpuSessionHandle_t;
typedef struct gpuAddressSpace *nvgpuAddressSpaceHandle_t;
typedef struct gpuChannel      *nvgpuChannelHandle_t;
typedef struct gpuObject       *nvgpuObjectHandle_t;
typedef struct gpuChannelInfo  *nvgpuChannelInfo_t;
typedef struct gpuCaps *nvgpuCaps_t;

typedef struct
{
    /* PCI config info */
    nv_pci_info_t pci_info;
    void *handle;
    nv_aperture_t bar0;
    nv_aperture_t *regs;
} nv_smu_state_t;

/*
 * flags
 */

#define NV_FLAG_OPEN                   0x0001
#define NV_FLAG_WAS_POSTED             0x0002
#define NV_FLAG_CONTROL                0x0004
#define NV_FLAG_MAP_REGS_EARLY         0x0008
#define NV_FLAG_USE_BAR0_CFG           0x0010
#define NV_FLAG_USES_MSI               0x0020
// EMPTY SLOT                          0x0040
#define NV_FLAG_PASSTHRU               0x0080
#define NV_FLAG_GVI_IN_SUSPEND         0x0100
#define NV_FLAG_GVI                    0x0200
#define NV_FLAG_GVI_INTR_EN            0x0400
#define NV_FLAG_PERSISTENT_SW_STATE    0x0800
#define NV_FLAG_IN_RECOVERY            0x1000
#define NV_FLAG_SKIP_CFG_CHECK         0x2000
#define NV_FLAG_UNBIND_LOCK            0x4000

#define NV_PM_ACPI_HIBERNATE    0x0001
#define NV_PM_ACPI_STANDBY      0x0002
#define NV_PM_ACPI_RESUME       0x0003

#define NV_PRIMARY_VGA(nv)      ((nv)->primary_vga)

#define NV_IS_GVI_DEVICE(nv) ((nv)->flags & NV_FLAG_GVI)

/*                                                                                    
 * The ACPI specification defines IDs for various ACPI video                          
 * extension events like display switch events, AC/battery                            
 * events, docking events, etc..                                                      
 * Whenever an ACPI event is received by the corresponding                            
 * event handler installed within the core NVIDIA driver, the                         
 * code can verify the event ID before processing it.                                 
 */
#define ACPI_DISPLAY_DEVICE_CHANGE_EVENT      0x80 
#define NVIF_NOTIFY_DISPLAY_DETECT           0xCB
#define NVIF_DISPLAY_DEVICE_CHANGE_EVENT     NVIF_NOTIFY_DISPLAY_DETECT 
/*                                                                                    
 * NVIDIA ACPI event IDs to be passed into the core NVIDIA                            
 * driver for various events like display switch events,                              
 * AC/battery events, docking events, etc..                                           
 */                                                                                   
#define NV_SYSTEM_ACPI_DISPLAY_SWITCH_EVENT  0x8001                                   
#define NV_SYSTEM_ACPI_BATTERY_POWER_EVENT   0x8002                                   
#define NV_SYSTEM_ACPI_DOCK_EVENT            0x8003                                   

/*
 * Status bit definitions for display switch hotkey events.
 */
#define NV_HOTKEY_STATUS_DISPLAY_ENABLE_LCD 0x01
#define NV_HOTKEY_STATUS_DISPLAY_ENABLE_CRT 0x02
#define NV_HOTKEY_STATUS_DISPLAY_ENABLE_TV  0x04
#define NV_HOTKEY_STATUS_DISPLAY_ENABLE_DFP 0x08

/*                                                                                    
 * NVIDIA ACPI sub-event IDs (event types) to be passed into                          
 * to core NVIDIA driver for ACPI events.                                             
 */                                                                                   
#define NV_SYSTEM_ACPI_EVENT_VALUE_DISPLAY_SWITCH_DEFAULT    0                        
#define NV_SYSTEM_ACPI_EVENT_VALUE_POWER_EVENT_AC            0                        
#define NV_SYSTEM_ACPI_EVENT_VALUE_POWER_EVENT_BATTERY       1                        
#define NV_SYSTEM_ACPI_EVENT_VALUE_DOCK_EVENT_UNDOCKED       0                        
#define NV_SYSTEM_ACPI_EVENT_VALUE_DOCK_EVENT_DOCKED         1                        

#define NV_ACPI_NVIF_HANDLE_PRESENT 0x01
#define NV_ACPI_DSM_HANDLE_PRESENT  0x02
#define NV_ACPI_WMMX_HANDLE_PRESENT 0x04
#define NV_ACPI_MXMI_HANDLE_PRESENT 0x08
#define NV_ACPI_MXMS_HANDLE_PRESENT 0x10

#define NV_EVAL_ACPI_METHOD_NVIF     0x01
#define NV_EVAL_ACPI_METHOD_WMMX     0x02
#define NV_EVAL_ACPI_METHOD_MXMI     0x03
#define NV_EVAL_ACPI_METHOD_MXMS     0x04

#define NV_I2C_CMD_READ              1
#define NV_I2C_CMD_WRITE             2
#define NV_I2C_CMD_SMBUS_READ        3
#define NV_I2C_CMD_SMBUS_WRITE       4
#define NV_I2C_CMD_SMBUS_QUICK_WRITE 5
#define NV_I2C_CMD_SMBUS_QUICK_READ  6

/*
** where we hide our nv_state_t * ...
*/
#define NV_SET_NV_STATE(pgpu,p) ((pgpu)->pOsHwInfo = (p))
#define NV_GET_NV_STATE(pGpu) \
    (nv_state_t *)((pGpu) ? (pGpu)->pOsHwInfo : NULL)

#define IS_DMA_ADDRESSABLE(nv, offset)                                          \
    (((offset) >= (nv)->dma_addressable_start) &&                               \
     ((offset) <= (nv)->dma_addressable_limit))

#define IS_REG_OFFSET(nv, offset, length)                                       \
    (((offset) >= (nv)->regs->cpu_address) &&                                   \
    (((offset) + ((length)-1)) <=                                               \
        (nv)->regs->cpu_address + ((nv)->regs->size-1)))

#define IS_FB_OFFSET(nv, offset, length)                                        \
    (((offset) >= (nv)->fb->cpu_address) &&                                     \
    (((offset) + ((length)-1)) <= (nv)->fb->cpu_address + ((nv)->fb->size-1)))

#define IS_UD_OFFSET(nv, offset, length)                                        \
    (((nv)->ud.cpu_address != 0) && ((nv)->ud.size != 0) &&                     \
    ((offset) >= (nv)->ud.cpu_address) &&                                       \
    (((offset) + ((length)-1)) <= (nv)->ud.cpu_address + ((nv)->ud.size-1)))

#define IS_IMEM_OFFSET(nv, offset, length)                                      \
    (((nv)->bars[NV_GPU_BAR_INDEX_IMEM].cpu_address != 0) &&                    \
     ((nv)->bars[NV_GPU_BAR_INDEX_IMEM].size != 0) &&                           \
     ((offset) >= (nv)->bars[NV_GPU_BAR_INDEX_IMEM].cpu_address) &&             \
     (((offset) + ((length) - 1)) <=                                            \
        (nv)->bars[NV_GPU_BAR_INDEX_IMEM].cpu_address +                         \
            ((nv)->bars[NV_GPU_BAR_INDEX_IMEM].size - 1)))

/* device name length; must be atleast 8 */

#define NV_DEVICE_NAME_LENGTH 40

#define NV_MAX_ISR_DELAY_US           20000
#define NV_MAX_ISR_DELAY_MS           (NV_MAX_ISR_DELAY_US / 1000)

#define NV_TIMERCMP(a, b, CMP)                                              \
    (((a)->tv_sec == (b)->tv_sec) ?                                         \
        ((a)->tv_usec CMP (b)->tv_usec) : ((a)->tv_sec CMP (b)->tv_sec))

#define NV_TIMERADD(a, b, result)                                           \
    {                                                                       \
        (result)->tv_sec = (a)->tv_sec + (b)->tv_sec;                       \
        (result)->tv_usec = (a)->tv_usec + (b)->tv_usec;                    \
        if ((result)->tv_usec >= 1000000)                                   \
        {                                                                   \
            ++(result)->tv_sec;                                             \
            (result)->tv_usec -= 1000000;                                   \
        }                                                                   \
    }

#define NV_TIMERSUB(a, b, result)                                           \
    {                                                                       \
        (result)->tv_sec = (a)->tv_sec - (b)->tv_sec;                       \
        (result)->tv_usec = (a)->tv_usec - (b)->tv_usec;                    \
        if ((result)->tv_usec < 0)                                          \
        {                                                                   \
          --(result)->tv_sec;                                               \
          (result)->tv_usec += 1000000;                                     \
        }                                                                   \
    }

#ifndef NV_ALIGN_UP
#define NV_ALIGN_UP(v,g) (((v) + ((g) - 1)) & ~((g) - 1))
#endif
#ifndef NV_ALIGN_DOWN
#define NV_ALIGN_DOWN(v,g) ((v) & ~((g) - 1))
#endif

/*
 * driver internal interfaces
 */

#ifndef NVWATCH

/*
 * ---------------------------------------------------------------------------
 *
 * Function prototypes for UNIX specific OS interface.
 *
 * ---------------------------------------------------------------------------
 */

/*
 * Make sure that arguments to and from the core resource manager
 * are passed and expected on the stack. define duplicated in os-interface.h
 */
#if !defined(NV_API_CALL)
#if defined(NVCPU_X86)
#if defined(__use_altstack__)
#define NV_API_CALL __attribute__((regparm(0),altstack(false)))
#else
#define NV_API_CALL __attribute__((regparm(0)))
#endif
#elif defined(NVCPU_X86_64) && defined(__use_altstack__)
#define NV_API_CALL __attribute__((altstack(false)))
#else
#define NV_API_CALL
#endif
#endif /* !defined(NV_API_CALL) */


void*      NV_API_CALL  nv_alloc_kernel_mapping  (nv_state_t *, void *, NvU64, NvU32, NvU64, void **);
RM_STATUS  NV_API_CALL  nv_free_kernel_mapping   (nv_state_t *, void *, void *, void *);
RM_STATUS  NV_API_CALL  nv_alloc_user_mapping    (nv_state_t *, void *, NvU64, NvU32, NvU64, NvU32, NvU64 *, void **);
RM_STATUS  NV_API_CALL  nv_free_user_mapping     (nv_state_t *, void *, NvU64, void *);
RM_STATUS  NV_API_CALL  nv_create_user_mapping_context (nv_state_t *, NvU64, NvU64, void **);

NvU64  NV_API_CALL  nv_get_kern_phys_address     (NvU64);
NvU64  NV_API_CALL  nv_get_user_phys_address     (NvU64);
void*  NV_API_CALL  nv_get_adapter_state         (NvU32, NvU8, NvU8);

void   NV_API_CALL  nv_set_dma_address_size      (nv_state_t *, NvU32 );

RM_STATUS  NV_API_CALL  nv_alias_pages           (nv_state_t *, NvU32, NvU32, NvU32, NvU64, NvU64 *, void **);
RM_STATUS  NV_API_CALL  nv_alloc_pages           (nv_state_t *, NvU32, NvBool, NvU32, NvBool, NvU64 *, void **);
RM_STATUS  NV_API_CALL  nv_free_pages            (nv_state_t *, NvU32, NvBool, NvU32, void *);

RM_STATUS  NV_API_CALL  nv_dma_map_pages         (nv_state_t *, NvU64, NvU64 *, void **);
RM_STATUS  NV_API_CALL  nv_dma_unmap_pages       (nv_state_t *, NvU64, NvU64 *, void **);

NvS32  NV_API_CALL  nv_start_rc_timer            (nv_state_t *);
NvS32  NV_API_CALL  nv_stop_rc_timer             (nv_state_t *);

void   NV_API_CALL  nv_post_event                (nv_state_t *, nv_event_t *, NvU32, NvU32, NvBool);
NvS32  NV_API_CALL  nv_get_event                 (nv_state_t *, void *, nv_event_t *, NvU32 *);

NvS32  NV_API_CALL  nv_no_incoherent_mappings    (void);

void   NV_API_CALL  nv_verify_pci_config         (nv_state_t *, BOOL);

void*  NV_API_CALL  nv_i2c_add_adapter           (nv_state_t *, NvU32);
BOOL   NV_API_CALL  nv_i2c_del_adapter           (nv_state_t *, void *);

void   NV_API_CALL  nv_acpi_methods_init         (NvU32 *);
void   NV_API_CALL  nv_acpi_methods_uninit       (void);

RM_STATUS  NV_API_CALL  nv_acpi_method           (NvU32, NvU32, NvU32, void *, NvU16, NvU32 *, void *, NvU16 *);
RM_STATUS  NV_API_CALL  nv_acpi_dsm_method       (nv_state_t *, NvU8 *, NvU32, NvU32, void *, NvU16, NvU32 *, void *, NvU16 *);
RM_STATUS  NV_API_CALL  nv_acpi_ddc_method       (nv_state_t *, void *, NvU32 *);
RM_STATUS  NV_API_CALL  nv_acpi_dod_method       (nv_state_t *, NvU32 *, NvU32 *);
void*      NV_API_CALL  nv_get_smu_state         (void);
RM_STATUS  NV_API_CALL  nv_acpi_rom_method       (nv_state_t *, NvU32 *, NvU32 *);
RM_STATUS  NV_API_CALL  nv_log_error             (nv_state_t *, NvU32, const char *, va_list);

#if defined(NV_MOBILE_DGPU)
RM_STATUS  NV_API_CALL  nv_nvmap_create_client   (void);
void       NV_API_CALL  nv_nvmap_destroy_client  (void);
void       NV_API_CALL  nv_nvmap_free_handle_id  (NvU32);
RM_STATUS  NV_API_CALL  nv_nvmap_dup_handle_id   (NvU32 *, NvU32);
RM_STATUS  NV_API_CALL  nv_nvmap_get_page_list_info (NvU32, NvU32 *, NvU32 *, NvU32 *, BOOL *, NvU32 *);
RM_STATUS  NV_API_CALL  nv_nvmap_get_page_list   (nv_state_t *, void *, NvU64, NvU64 *, void **, NvU32);
RM_STATUS  NV_API_CALL  nv_nvmap_release_pages   (nv_state_t *, NvU64, NvU64 *, void *, NvU32);
#endif
RM_STATUS  NV_API_CALL  nv_alloc_os_descriptor_handle (nv_state_t *, NvS32, void *, NvU64, NvU32 *);
NvU64      NV_API_CALL  nv_get_dma_start_address (nv_state_t *);
void       NV_API_CALL  nv_pci_trigger_recovery  (nv_state_t *);
RM_STATUS  NV_API_CALL  nv_set_primary_vga_status(nv_state_t *);

#if defined(NVCPU_X86) || defined(NVCPU_X86_64)
NvBool     NV_API_CALL  nv_is_virtualized_system  (nv_stack_t *);
#endif

/*
 * ---------------------------------------------------------------------------
 *
 * Function prototypes for Resource Manager interface.
 *
 * ---------------------------------------------------------------------------
 */

BOOL       NV_API_CALL  rm_init_rm               (nv_stack_t *);
BOOL       NV_API_CALL  rm_shutdown_rm           (nv_stack_t *);
BOOL       NV_API_CALL  rm_init_private_state    (nv_stack_t *, nv_state_t *);
BOOL       NV_API_CALL  rm_free_private_state    (nv_stack_t *, nv_state_t *);
BOOL       NV_API_CALL  rm_init_adapter          (nv_stack_t *, nv_state_t *);
BOOL       NV_API_CALL  rm_disable_adapter       (nv_stack_t *, nv_state_t *);
BOOL       NV_API_CALL  rm_shutdown_adapter      (nv_stack_t *, nv_state_t *);
RM_STATUS  NV_API_CALL  rm_extract_mmap_context  (nv_stack_t *, nv_state_t *, NvP64, NvU64, void **);
void       NV_API_CALL  rm_purge_mmap_contexts   (nv_stack_t *, nv_state_t *, void *);
RM_STATUS  NV_API_CALL  rm_validate_mmap_request (nv_stack_t *, nv_state_t *, void *, NvU64, NvU64, NvU32 *, void **, NvU64 *);
RM_STATUS  NV_API_CALL  rm_acquire_api_lock      (nv_stack_t *);
RM_STATUS  NV_API_CALL  rm_release_api_lock      (nv_stack_t *);
RM_STATUS  NV_API_CALL  rm_ioctl                 (nv_stack_t *, nv_state_t *, void *, NvU32, void *, NvU32);
BOOL       NV_API_CALL  rm_isr                   (nv_stack_t *, nv_state_t *, NvU32 *);
void       NV_API_CALL  rm_isr_bh                (nv_stack_t *, nv_state_t *);
RM_STATUS  NV_API_CALL  rm_power_management      (nv_stack_t *, nv_state_t *, NvU32, NvU32);
RM_STATUS  NV_API_CALL  rm_save_low_res_mode     (nv_stack_t *, nv_state_t *);
RM_STATUS  NV_API_CALL  rm_get_vbios_version     (nv_stack_t *, nv_state_t *, NvU32 *, NvU32 *, NvU32 *, NvU32 *, NvU32 *);
RM_STATUS  NV_API_CALL  rm_get_gpu_uuid          (nv_stack_t *, nv_state_t *, NvU8 **, NvU32 *);
RM_STATUS  NV_API_CALL  rm_get_gpu_uuid_raw      (nv_stack_t *, nv_state_t *, NvU8 **, NvU32 *);
void       NV_API_CALL  rm_free_unused_clients   (nv_stack_t *, nv_state_t *, void *);
void       NV_API_CALL  rm_unbind_lock           (nv_stack_t *, nv_state_t *);

RM_STATUS  NV_API_CALL  rm_read_registry_dword   (nv_stack_t *, nv_state_t *, NvU8 *, NvU8 *, NvU32 *);
RM_STATUS  NV_API_CALL  rm_write_registry_dword  (nv_stack_t *, nv_state_t *, NvU8 *, NvU8 *, NvU32);
RM_STATUS  NV_API_CALL  rm_read_registry_binary  (nv_stack_t *, nv_state_t *, NvU8 *, NvU8 *, NvU8 *, NvU32 *);
RM_STATUS  NV_API_CALL  rm_write_registry_binary (nv_stack_t *, nv_state_t *, NvU8 *, NvU8 *, NvU8 *, NvU32);
RM_STATUS  NV_API_CALL  rm_write_registry_string (nv_stack_t *, nv_state_t *, NvU8 *, NvU8 *, const char *, NvU32);

RM_STATUS  NV_API_CALL  rm_run_rc_callback       (nv_stack_t *, nv_state_t *);
void       NV_API_CALL  rm_execute_work_item     (nv_stack_t *, void *);
RM_STATUS  NV_API_CALL  rm_get_device_name       (nv_stack_t *, nv_state_t *, NvU16, NvU16, NvU16, NvU32, NvU8 *);

NvU64      NV_API_CALL  nv_rdtsc                 (void);

void       NV_API_CALL  rm_register_compatible_ioctls   (nv_stack_t *);
void       NV_API_CALL  rm_unregister_compatible_ioctls (nv_stack_t *);

BOOL       NV_API_CALL  rm_is_legacy_device      (nv_stack_t *, NvU16, BOOL);
BOOL       NV_API_CALL  rm_is_legacy_arch        (NvU32, NvU32);
RM_STATUS  NV_API_CALL  rm_is_supported_device   (nv_stack_t *, nv_state_t *, NvU32 *, NvU32 *);


void       NV_API_CALL  rm_check_pci_config_space (nv_stack_t *, nv_state_t *nv, BOOL, BOOL, BOOL);

RM_STATUS  NV_API_CALL  rm_i2c_remove_adapters    (nv_stack_t *, nv_state_t *);
NvBool     NV_API_CALL  rm_i2c_is_smbus_capable   (nv_stack_t *, nv_state_t *, void *);
RM_STATUS  NV_API_CALL  rm_i2c_transfer           (nv_stack_t *, nv_state_t *, void *, NvU8, NvU8, NvU8, NvU32, NvU8 *);

RM_STATUS  NV_API_CALL  rm_perform_version_check  (nv_stack_t *, void *, NvU32);

RM_STATUS  NV_API_CALL  rm_system_event           (nv_stack_t *, NvU32, NvU32);
RM_STATUS  NV_API_CALL  rm_init_smu               (nv_stack_t *, nv_smu_state_t *);
RM_STATUS  NV_API_CALL  rm_shutdown_smu           (nv_stack_t *, nv_smu_state_t *);
RM_STATUS  NV_API_CALL  rm_suspend_smu            (nv_stack_t *);
RM_STATUS  NV_API_CALL  rm_resume_smu             (nv_stack_t *);

void       NV_API_CALL  rm_disable_gpu_state_persistence    (nv_stack_t *sp, nv_state_t *);
RM_STATUS  NV_API_CALL  rm_p2p_init_mapping       (nv_stack_t *, NvU64, NvU64 *, NvU64 *, NvU64 *, NvU64 *, NvU64, NvU64, NvU64, NvU64, void (*)(void *), void *);
RM_STATUS  NV_API_CALL  rm_p2p_destroy_mapping    (nv_stack_t *, NvU64);
RM_STATUS  NV_API_CALL  rm_p2p_get_pages          (nv_stack_t *, NvU64, NvU32, NvU64, NvU64, NvU64 **, NvU32 **, NvU32 **, NvU32 *, void *, void (*)(void *), void *);
RM_STATUS  NV_API_CALL  rm_p2p_put_pages          (nv_stack_t *, NvU64, NvU32, NvU64, void *);
RM_STATUS  NV_API_CALL  rm_get_cpu_type           (nv_stack_t *, nv_cpu_type_t *);
RM_STATUS  NV_API_CALL  rm_get_gpu_debug_data     (nv_stack_t *, nv_state_t *, void *, NvU32 *);

RM_STATUS  NV_API_CALL  rm_gpu_ops_create_session (nv_stack_t *, nvgpuSessionHandle_t *);
RM_STATUS  NV_API_CALL  rm_gpu_ops_destroy_session (nv_stack_t *, nvgpuSessionHandle_t);
RM_STATUS  NV_API_CALL  rm_gpu_ops_address_space_create(nv_stack_t *, nvgpuSessionHandle_t, unsigned long long, unsigned long long, nvgpuAddressSpaceHandle_t *);
RM_STATUS  NV_API_CALL  rm_gpu_ops_address_space_create_mirrored(nv_stack_t *, nvgpuSessionHandle_t, unsigned long long, unsigned long long, nvgpuAddressSpaceHandle_t *);
RM_STATUS  NV_API_CALL  rm_gpu_ops_address_space_destroy(nv_stack_t *, nvgpuAddressSpaceHandle_t);
RM_STATUS  NV_API_CALL  rm_gpu_ops_memory_alloc_fb(nv_stack_t *, nvgpuAddressSpaceHandle_t, NvLength, NvU64 *);
RM_STATUS  NV_API_CALL  rm_gpu_ops_memory_alloc_sys(nv_stack_t *, nvgpuAddressSpaceHandle_t, NvLength, NvU64 *);
RM_STATUS  NV_API_CALL  rm_gpu_ops_memory_cpu_map(nv_stack_t *, nvgpuAddressSpaceHandle_t, NvU64, NvLength, void **);
RM_STATUS  NV_API_CALL  rm_gpu_ops_memory_cpu_ummap(nv_stack_t *, nvgpuAddressSpaceHandle_t, void*);
RM_STATUS  NV_API_CALL  rm_gpu_ops_channel_allocate(nv_stack_t *, nvgpuAddressSpaceHandle_t, nvgpuChannelHandle_t *, nvgpuChannelInfo_t);
RM_STATUS  NV_API_CALL  rm_gpu_ops_channel_destroy(nv_stack_t *, nvgpuChannelHandle_t);
const char*  NV_API_CALL  rm_gpu_ops_channel_translate_error(nv_stack_t *, NvU32);
RM_STATUS  NV_API_CALL  rm_gpu_ops_copy_engine_allocate(nv_stack_t *, nvgpuChannelHandle_t, NvU32, NvU32*, nvgpuObjectHandle_t *);
RM_STATUS  NV_API_CALL rm_gpu_ops_memory_free(nv_stack_t *, nvgpuAddressSpaceHandle_t, NvU64);
RM_STATUS  NV_API_CALL rm_gpu_ops_query_caps(nv_stack_t *, nvgpuAddressSpaceHandle_t, nvgpuCaps_t);
RM_STATUS  NV_API_CALL rm_gpu_ops_get_attached_uuids(nv_stack_t *, NvU8 *pUuidList, unsigned *numGpus);
RM_STATUS  NV_API_CALL rm_gpu_ops_get_gpu_arch(nv_stack_t *, NvU8 *pUuid, unsigned uuidLength, NvU32 *pGpuArch);
RM_STATUS  NV_API_CALL rm_gpu_ops_get_uvm_priv_region(NvU64 *pPrivRegionStart, NvU64 *pPrivRegionLength);
RM_STATUS  NV_API_CALL rm_gpu_ops_service_device_interrupts_rm(nv_stack_t *, nvgpuChannelHandle_t);
RM_STATUS  NV_API_CALL rm_gpu_ops_check_ecc_error_slowpath(nv_stack_t *, nvgpuChannelHandle_t, NvBool *);
RM_STATUS  NV_API_CALL rm_gpu_ops_kill_channel(nv_stack_t *, nvgpuChannelHandle_t);

#endif /* NVWATCH */

#endif /* NVRM */

static inline int nv_count_bits(NvU64 word)
{
    NvU64 bits;

    bits = (word & 0x5555555555555555ULL) + ((word >>  1) & 0x5555555555555555ULL);
    bits = (bits & 0x3333333333333333ULL) + ((bits >>  2) & 0x3333333333333333ULL);
    bits = (bits & 0x0f0f0f0f0f0f0f0fULL) + ((bits >>  4) & 0x0f0f0f0f0f0f0f0fULL);
    bits = (bits & 0x00ff00ff00ff00ffULL) + ((bits >>  8) & 0x00ff00ff00ff00ffULL);
    bits = (bits & 0x0000ffff0000ffffULL) + ((bits >> 16) & 0x0000ffff0000ffffULL);
    bits = (bits & 0x00000000ffffffffULL) + ((bits >> 32) & 0x00000000ffffffffULL);

    return (int)(bits);
}

#endif
