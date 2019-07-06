/* _NVRM_COPYRIGHT_BEGIN_
 *
 * Copyright 1999-2013 by NVIDIA Corporation.  All rights reserved.  All
 * information contained herein is proprietary and confidential to NVIDIA
 * Corporation.  Any use, reproduction, or disclosure without the written
 * permission of NVIDIA Corporation is prohibited.
 *
 * _NVRM_COPYRIGHT_END_
 */

#define  __NO_VERSION__
#include "nv-misc.h"

#include "os-interface.h"
#include "nv-linux.h"

RM_STATUS NV_API_CALL os_disable_console_access(void)
{
    NV_ACQUIRE_CONSOLE_SEM();
    return RM_OK;
}

RM_STATUS NV_API_CALL os_enable_console_access(void)
{
    NV_RELEASE_CONSOLE_SEM();
    return RM_OK;
}

typedef struct semaphore os_mutex_t;

//
// os_alloc_mutex - Allocate the RM mutex
//
//  ppMutex - filled in with pointer to opaque structure to mutex data type
//
RM_STATUS NV_API_CALL os_alloc_mutex
(
    void **ppMutex
)
{
    RM_STATUS rmStatus;
    os_mutex_t *os_mutex;

    rmStatus = os_alloc_mem(ppMutex, sizeof(os_mutex_t));
    if (rmStatus != RM_OK)
    {
        nv_printf(NV_DBG_ERRORS, "NVRM: failed to allocate mutex!\n");
        return rmStatus;
    }
    os_mutex = (os_mutex_t *)*ppMutex;
    NV_INIT_MUTEX(os_mutex);

    return RM_OK;
}

//
// os_free_mutex - Free resources associated with mutex allocated
//                via os_alloc_mutex above. 
//
//  pMutex - Pointer to opaque structure to mutex data type
//
void NV_API_CALL os_free_mutex
(
    void  *pMutex
)
{
    os_mutex_t *os_mutex = (os_mutex_t *)pMutex;

    if (os_mutex != NULL)
    {
        os_free_mem(pMutex);
    }
}

//
//  pMutex - Pointer to opaque structure to mutex data type
//

RM_STATUS NV_API_CALL os_acquire_mutex
(
    void  *pMutex
)
{
    os_mutex_t *os_mutex = (os_mutex_t *)pMutex;

    if (!NV_MAY_SLEEP())
    {
        return RM_ERR_INVALID_REQUEST;
    }
    down(os_mutex);

    return RM_OK;
}

RM_STATUS NV_API_CALL os_cond_acquire_mutex
(
    void * pMutex
)
{
    os_mutex_t *os_mutex = (os_mutex_t *)pMutex;
    if (!NV_MAY_SLEEP())
    {
        return RM_ERR_INVALID_REQUEST;
    }

    if (down_trylock(os_mutex))
    {
        return RM_ERR_TIMEOUT_RETRY;
    }

    return RM_OK;
}


void NV_API_CALL os_release_mutex
(
    void *pMutex
)
{
    os_mutex_t *os_mutex = (os_mutex_t *)pMutex;
    up(os_mutex);
}

typedef struct os_semaphore_s
{
    struct completion  completion;
    nv_spinlock_t      lock;
    NvS32              count;
    NvS32              limit;
} os_semaphore_t;


void* NV_API_CALL os_alloc_semaphore
(
    NvU32 initialValue,
    NvU32 limit
)
{
    RM_STATUS rmStatus;
    os_semaphore_t *os_sema;

    rmStatus = os_alloc_mem((void *)&os_sema, sizeof(os_semaphore_t));
    if (rmStatus != RM_OK)
    {
        nv_printf(NV_DBG_ERRORS, "NVRM: failed to allocate semaphore!\n");
        return NULL;
    }

    init_completion(&os_sema->completion);
    NV_SPIN_LOCK_INIT(&os_sema->lock);
    os_sema->count = initialValue;
    os_sema->limit = limit;

    return (void *)os_sema;
}

void NV_API_CALL os_free_semaphore
(
    void *pSema
)
{
    os_semaphore_t *os_sema = (os_semaphore_t *)pSema;

    os_free_mem(os_sema);
}

RM_STATUS NV_API_CALL os_acquire_semaphore
(
    void *pSema
)
{
    os_semaphore_t *os_sema = (os_semaphore_t *)pSema;
    unsigned long old_irq;

    NV_SPIN_LOCK_IRQSAVE(&os_sema->lock, old_irq);
    if (os_sema->count <= 0)
    {
        os_sema->count--;
        NV_SPIN_UNLOCK_IRQRESTORE(&os_sema->lock, old_irq);
        wait_for_completion(&os_sema->completion);
    }
    else
    {
        os_sema->count--;
        NV_SPIN_UNLOCK_IRQRESTORE(&os_sema->lock, old_irq);
    }

    return RM_OK;
}

RM_STATUS NV_API_CALL os_release_semaphore
(
    void *pSema
)
{
    os_semaphore_t *os_sema = (os_semaphore_t *)pSema;
    unsigned long old_irq;
    BOOL doWakeup = FALSE;

    NV_SPIN_LOCK_IRQSAVE(&os_sema->lock, old_irq);
    if (os_sema->count < 0)
    {
        doWakeup = TRUE;
    }
    os_sema->count++;
    NV_SPIN_UNLOCK_IRQRESTORE(&os_sema->lock, old_irq);

    if (doWakeup)
        complete(&os_sema->completion);

    return RM_OK;
}

BOOL NV_API_CALL os_semaphore_may_sleep(void)
{
    return NV_MAY_SLEEP();
}

BOOL NV_API_CALL os_is_isr(void)
{
    return (in_irq());
}

// return TRUE if the caller is the super-user
BOOL NV_API_CALL os_is_administrator(
    PHWINFO pDev
)
{
    return NV_IS_SUSER();
}

NvU32 NV_API_CALL os_get_page_size(void)
{
    return PAGE_SIZE;
}

NvU64 NV_API_CALL os_get_page_mask(void)
{
    return NV_PAGE_MASK;
}

NvU8 NV_API_CALL os_get_page_shift(void)
{
    return PAGE_SHIFT;
}

NvU64 NV_API_CALL os_get_num_phys_pages(void)
{
    return (NvU64)NV_NUM_PHYSPAGES;
}

char* NV_API_CALL os_string_copy(
    char *dst,
    const char *src
)
{
    return strcpy(dst, src);
}

NvU32 NV_API_CALL os_string_length(
    const char* str
)
{
    return strlen(str);
}

NvU8* NV_API_CALL os_mem_copy(
    NvU8       *dst,
    const NvU8 *src,
    NvU32       length
)
{
    NvU8 *ret = dst;
    NvU32 dwords, bytes = length;

    if ((length >= 128) &&
        (((NvUPtr)dst & 3) == 0) & (((NvUPtr)src & 3) == 0))
    {
        dwords = (length / sizeof(NvU32));
        bytes = (length % sizeof(NvU32));

        while (dwords != 0)
        {
            *(NvU32 *)dst = *(const NvU32 *)src;
            dst += sizeof(NvU32);
            src += sizeof(NvU32);
            dwords--;
        }
    }

    while (bytes != 0)
    {
        *dst = *src;
        dst++;
        src++;
        bytes--;
    }

    return ret;
}

RM_STATUS NV_API_CALL os_memcpy_from_user(
    void       *to,
    const void *from,
    NvU32       n
)
{
    return (NV_COPY_FROM_USER(to, from, n) ? RM_ERR_INVALID_ADDRESS : RM_OK);
}

RM_STATUS NV_API_CALL os_memcpy_to_user(
    void       *to,
    const void *from,
    NvU32       n
)
{
    return (NV_COPY_TO_USER(to, from, n) ? RM_ERR_INVALID_ADDRESS : RM_OK);
}

void* NV_API_CALL os_mem_set(
    void  *dst,
    NvU8   c,
    NvU32  length
)
{
    NvU8 *ret = dst;
    NvU32 bytes = length;

    while (bytes != 0)
    {
        *(NvU8 *)dst = c;
        dst = ((NvU8 *)dst + 1);
        bytes--;
    }

    return ret;
}

NvS32 NV_API_CALL os_mem_cmp(
    const NvU8 *buf0,
    const NvU8* buf1,
    NvU32 length
)
{
    return memcmp(buf0, buf1, length);
}


/*
 * Operating System Memory Functions
 *
 * There are 2 interesting aspects of resource manager memory allocations
 * that need special consideration on Linux:
 *
 * 1. They are typically very large, (e.g. single allocations of 164KB)
 *
 * 2. The resource manager assumes that it can safely allocate memory in
 *    interrupt handlers.
 *
 * The first requires that we call vmalloc, the second kmalloc. We decide
 * which one to use at run time, based on the size of the request and the
 * context. Allocations larger than 128KB require vmalloc, in the context
 * of an ISR they fail.
 */

#define KMALLOC_LIMIT 131072
#define VMALLOC_ALLOCATION_SIZE_FLAG (1 << 0)

RM_STATUS NV_API_CALL os_alloc_mem(
    void **address,
    NvU32 size
)
{
    if (address == NULL)
        return RM_ERR_INVALID_ARGUMENT;

    *address = NULL;
    NV_MEM_TRACKING_PAD_SIZE(size);

    if (!NV_MAY_SLEEP())
    {
        if (size <= KMALLOC_LIMIT)
            NV_KMALLOC_ATOMIC(*address, size);
    }
    else
    {
        if (size <= KMALLOC_LIMIT)
        {
            NV_KMALLOC(*address, size);
        }
        if (*address == NULL)
        {
            NV_VMALLOC(*address, size);
            size |= VMALLOC_ALLOCATION_SIZE_FLAG;
        }
    }

    NV_MEM_TRACKING_HIDE_SIZE(address, size);

    return ((*address != NULL) ? RM_OK : RM_ERR_NO_MEMORY);
}

void NV_API_CALL os_free_mem(void *address)
{
    NvU32 size;

    NV_MEM_TRACKING_RETRIEVE_SIZE(address, size);

    if (size & VMALLOC_ALLOCATION_SIZE_FLAG)
    {
        size &= ~VMALLOC_ALLOCATION_SIZE_FLAG;
        NV_VFREE(address, size);
    }
    else
        NV_KFREE(address, size);
}


/*****************************************************************************
*
*   Name: osGetCurrentTime
*
*****************************************************************************/

RM_STATUS NV_API_CALL os_get_current_time(
    NvU32 *seconds,
    NvU32 *useconds
)
{
    struct timeval tm;

    do_gettimeofday(&tm);

    *seconds = tm.tv_sec;
    *useconds = tm.tv_usec;

    return RM_OK;
}

//---------------------------------------------------------------------------
//
//  Misc services.
//
//---------------------------------------------------------------------------

#define NV_MSECS_PER_JIFFIE         (1000 / HZ)
#define NV_MSECS_TO_JIFFIES(msec)   ((msec) * HZ / 1000)
#define NV_USECS_PER_JIFFIE         (1000000 / HZ)
#define NV_USECS_TO_JIFFIES(usec)   ((usec) * HZ / 1000000)

// #define NV_CHECK_DELAY_ACCURACY 1

/*
 * It is generally a bad idea to use udelay() to wait for more than
 * a few milliseconds. Since the caller is most likely not aware of
 * this, we use mdelay() for any full millisecond to be safe.
 */

RM_STATUS NV_API_CALL os_delay_us(NvU32 MicroSeconds)
{
    unsigned long mdelay_safe_msec;
    unsigned long usec;

#ifdef NV_CHECK_DELAY_ACCURACY
    struct timeval tm1, tm2;

    do_gettimeofday(&tm1);
#endif

    if (in_irq() && (MicroSeconds > NV_MAX_ISR_DELAY_US))
        return RM_ERROR;
    
    mdelay_safe_msec = MicroSeconds / 1000;
    if (mdelay_safe_msec)
        mdelay(mdelay_safe_msec);

    usec = MicroSeconds % 1000;
    if (usec)
        udelay(usec);

#ifdef NV_CHECK_DELAY_ACCURACY
    do_gettimeofday(&tm2);
    nv_printf(NV_DBG_ERRORS, "NVRM: osDelayUs %d: 0x%x 0x%x\n",
        MicroSeconds, tm2.tv_sec - tm1.tv_sec, tm2.tv_usec - tm1.tv_usec);
#endif

    return RM_OK;
}

/* 
 * On Linux, a jiffie represents the time passed in between two timer
 * interrupts. The number of jiffies per second (HZ) varies across the
 * supported platforms. On i386, where HZ is 100, a timer interrupt is
 * generated every 10ms; the resolution is a lot better on ia64, where
 * HZ is 1024. NV_MSECS_TO_JIFFIES should be accurate independent of
 * the actual value of HZ; any partial jiffies will be 'floor'ed, the
 * remainder will be accounted for with mdelay().
 */

RM_STATUS NV_API_CALL os_delay(NvU32 MilliSeconds)
{
    unsigned long MicroSeconds;
    unsigned long jiffies;
    unsigned long mdelay_safe_msec;
    struct timeval tm_end, tm_aux;
#ifdef NV_CHECK_DELAY_ACCURACY
    struct timeval tm_start;
#endif

    do_gettimeofday(&tm_aux);
#ifdef NV_CHECK_DELAY_ACCURACY
    tm_start = tm_aux;
#endif

    if (in_irq() && (MilliSeconds > NV_MAX_ISR_DELAY_MS))
        return RM_ERROR;

    if (!NV_MAY_SLEEP()) 
    {
        mdelay(MilliSeconds);
        return RM_OK;
    }

    MicroSeconds = MilliSeconds * 1000;
    tm_end.tv_usec = MicroSeconds;
    tm_end.tv_sec = 0;
    NV_TIMERADD(&tm_aux, &tm_end, &tm_end);

    /* do we have a full jiffie to wait? */
    jiffies = NV_USECS_TO_JIFFIES(MicroSeconds);

    if (jiffies)
    {
        //
        // If we have at least one full jiffy to wait, give up
        // up the CPU; since we may be rescheduled before
        // the requested timeout has expired, loop until less
        // than a jiffie of the desired delay remains.
        //
        current->state = TASK_INTERRUPTIBLE;
        do
        {
            schedule_timeout(jiffies);
            do_gettimeofday(&tm_aux);
            if (NV_TIMERCMP(&tm_aux, &tm_end, <))
            {
                NV_TIMERSUB(&tm_end, &tm_aux, &tm_aux);
                MicroSeconds = tm_aux.tv_usec + tm_aux.tv_sec * 1000000;
            }
            else
                MicroSeconds = 0;
        } while ((jiffies = NV_USECS_TO_JIFFIES(MicroSeconds)) != 0);
    }

    if (MicroSeconds > 1000)
    {
        mdelay_safe_msec = MicroSeconds / 1000;
        mdelay(mdelay_safe_msec);
        MicroSeconds %= 1000;
    }
    if (MicroSeconds)
    {
        udelay(MicroSeconds);
    }
#ifdef NV_CHECK_DELAY_ACCURACY
    do_gettimeofday(&tm_aux);
    timersub(&tm_aux, &tm_start, &tm_aux);
    nv_printf(NV_DBG_ERRORS, "NVRM: osDelay %dmsec: %d.%06dsec\n",
        MilliSeconds, tm_aux.tv_sec, tm_aux.tv_usec);
#endif

    return RM_OK;
}

NvU64 NV_API_CALL os_get_cpu_frequency(void)
{
    NvU64 cpu_hz = 0;
#if defined(CONFIG_CPU_FREQ) && !defined(NV_VMWARE)
    cpu_hz = (cpufreq_get(0) * 1000);
#elif (defined(NVCPU_X86) || defined(NVCPU_X86_64))
    NvU64 tsc[2];

    tsc[0] = nv_rdtsc();
    mdelay(250);
    tsc[1] = nv_rdtsc();

    cpu_hz = ((tsc[1] - tsc[0]) * 4);
#endif
    return cpu_hz;
}

NvU32 NV_API_CALL os_get_current_process(void)
{
    return NV_GET_CURRENT_PROCESS();
}

RM_STATUS NV_API_CALL os_get_current_thread(NvU64 *threadId)
{
    if (in_interrupt())
        *threadId = 0;
    else
        *threadId = (NvU64) current->pid;

    return RM_OK;
}

/*******************************************************************************/
/*                                                                             */
/* Debug and logging utilities follow                                          */
/*                                                                             */
/*******************************************************************************/


// The current debug display level (default to maximum debug level)
NvU32 cur_debuglevel = 0xffffffff;


//
// this is what actually outputs the data.
//
inline void NV_API_CALL out_string(const char *str)
{
#if defined(DEBUG)
    static int was_newline = 0;

    if (NV_NUM_CPUS() > 1 && was_newline)
    {
        printk("%d: %s", get_cpu(), str);
        put_cpu();
    }
    else
#endif
        printk("%s", str);

#if defined(DEBUG)
    if (NV_NUM_CPUS() > 1)
    {
        int len, i;

        len = strlen(str);
        if (len > 5) i = 5;
        else         i = len;
        was_newline = 0;
        while (i >= 0)
        {
            if (str[len - i] == '\n') was_newline = 1;
            i--;
        }
    }
#endif
}    



#define MAX_ERROR_STRING 512

/*
 * nv_printf() prints to the "error" log for the driver.
 * Just like printf, adds no newlines or names
 * Returns the number of characters written.
 */

static char nv_error_string[MAX_ERROR_STRING];

int NV_API_CALL nv_printf(
    NvU32 debuglevel,
    const char *printf_format,
    ...
  )
{
    char *p = nv_error_string;
    va_list arglist;
    int chars_written = 0;

    if (debuglevel >= ((cur_debuglevel>>4)&0x3))
    {
        va_start(arglist, printf_format);
        chars_written = vsnprintf(p, sizeof(nv_error_string), printf_format, arglist);
        va_end(arglist);
        out_string(p);
    }

    return chars_written;
}

void NV_API_CALL nv_prints(
    NvU32 debuglevel,
    const char *string
)
{
    char *s = NULL, *p = (char *)string;
    int l = 0, n = 0;

    if (debuglevel >= ((cur_debuglevel>>4)&0x3))
    {
        while ((s = strchr(p, '\n')) != NULL)
        {
            sprintf(nv_error_string, "NVRM: ");
            l = strlen(nv_error_string);
            n = NV_MIN((s - p) + 2, (MAX_ERROR_STRING - l));
            snprintf(nv_error_string + l, n, "%s", p);
            nv_error_string[MAX_ERROR_STRING - 1] = '\0';
            printk("%s", nv_error_string);
            p = s + 1;
        }
    }
}

NvS32 NV_API_CALL os_snprintf(
    char *buf,
    NvU32 size,
    const char *fmt,
    ...
)
{
    va_list arglist;
    int chars_written;

    va_start(arglist, fmt);
    chars_written = vsnprintf(buf, size, fmt, arglist);
    va_end(arglist);

    return chars_written;
}

void NV_API_CALL os_log_error(
    NvU32 log_level,
    NvU32 error_number,
    const char *fmt,
    va_list ap
)
{
    char    *sys_log_level;
    int     l;

    switch (log_level) {
    case NV_DBG_INFO:
        sys_log_level = KERN_INFO;
        break;
    case NV_DBG_SETUP:
        sys_log_level = KERN_DEBUG;
        break;
    case NV_DBG_USERERRORS:
        sys_log_level = KERN_NOTICE;
        break;
    case NV_DBG_WARNINGS:
        sys_log_level = KERN_WARNING;
        break;
    case NV_DBG_ERRORS:
    default:
        sys_log_level = KERN_ERR;
        break;
    }

    strcpy(nv_error_string, sys_log_level);
    strcat(nv_error_string, "NVRM: ");
    l = strlen(nv_error_string);
    vsnprintf(nv_error_string + l, MAX_ERROR_STRING - l, fmt, ap);
    nv_error_string[MAX_ERROR_STRING - 1] = 0;

    printk("%s", nv_error_string);
}

void NV_API_CALL os_io_write_byte(
    NvU32 address,
    NvU8 value
)
{
    outb(value, address);
}

void NV_API_CALL os_io_write_word(
    NvU32 address,
    NvU16 value
)
{
    outw(value, address);
}

void NV_API_CALL os_io_write_dword(
    NvU32 address,
    NvU32 value
)
{
    outl(value, address);
}

NvU8 NV_API_CALL os_io_read_byte(
    NvU32 address
)
{
    return inb(address);
}

NvU16 NV_API_CALL os_io_read_word(
    NvU32 address
)
{
    return inw(address);
}

NvU32 NV_API_CALL os_io_read_dword(
    NvU32 address
)
{
    return inl(address);
}


static NvBool NV_API_CALL xen_support_fully_virtualized_kernel(void)
{
#if defined(NV_XEN_SUPPORT_FULLY_VIRTUALIZED_KERNEL)
    return (os_is_vgx_hyper());
#endif
    return FALSE;
}

void* NV_API_CALL os_map_kernel_space(
    NvU64 start,
    NvU64 size_bytes,
    NvU32 mode,
    NvU32 memType
)
{
    void *vaddr;

    if (!xen_support_fully_virtualized_kernel() && start == 0)
    {
        if (mode != NV_MEMORY_CACHED)
        {
            nv_printf(NV_DBG_ERRORS,
                "NVRM: os_map_kernel_space: won't map address 0x%0llx UC!\n", start);
            return NULL;
        }
        else
            return (void *)PAGE_OFFSET;
    }

    if (!NV_MAY_SLEEP())
    {
        nv_printf(NV_DBG_ERRORS,
            "NVRM: os_map_kernel_space: can't map 0x%0llx, invalid context!\n", start);
        os_dbg_breakpoint();
        return NULL;
    }

#if defined(NVCPU_X86)
    if (start > 0xffffffff)
    {
        nv_printf(NV_DBG_ERRORS,
            "NVRM: os_map_kernel_space: can't map > 32-bit address 0x%0llx!\n", start);
        os_dbg_breakpoint();
        return NULL;
    }
#endif

    switch (mode)
    {
        case NV_MEMORY_CACHED:
            NV_IOREMAP_CACHE(vaddr, start, size_bytes);
            break;
        case NV_MEMORY_WRITECOMBINED:
            NV_IOREMAP_WC(vaddr, start, size_bytes);
            break;
        case NV_MEMORY_UNCACHED:
        case NV_MEMORY_DEFAULT:
            NV_IOREMAP_NOCACHE(vaddr, start, size_bytes);
            break;
        default:
            nv_printf(NV_DBG_ERRORS,
                "NVRM: os_map_kernel_space: unsupported mode!\n");
            return NULL;
    }

    return vaddr;
}

void NV_API_CALL os_unmap_kernel_space(
    void *addr,
    NvU64 size_bytes
)
{
    if (addr == (void *)PAGE_OFFSET)
        return;

    NV_IOUNMAP(addr, size_bytes);
}

// flush the cpu's cache, uni-processor version
RM_STATUS NV_API_CALL os_flush_cpu_cache()
{
    CACHE_FLUSH();
    return RM_OK;
}

// flush the cache of all cpus
RM_STATUS NV_API_CALL os_flush_cpu_cache_all()
{
#if defined(NVCPU_FAMILY_ARM)
    CACHE_FLUSH_ALL();
#if defined(NVCPU_ARM) && defined(NV_OUTER_FLUSH_ALL_PRESENT)
    /* flush the external L2 cache in cortex-A9 and cortex-a15 */
    OUTER_FLUSH_ALL();
#endif
    return RM_OK;
#endif
    return RM_ERR_NOT_SUPPORTED;
}

// Flush and/or invalidate a range of memory in user space.
// start, end are the user virtual addresses
// physStart, physEnd are the corresponding physical addresses
// Start addresses are inclusive, end addresses exclusive
// The flags argument states whether to flush, invalidate, or do both
RM_STATUS NV_API_CALL os_flush_user_cache(NvU64 start, NvU64 end, 
                                          NvU64 physStart, NvU64 physEnd, 
                                          NvU32 flags)
{
#if defined(NVCPU_FAMILY_ARM)
    if (!NV_MAY_SLEEP())
    {
        return RM_ERR_NOT_SUPPORTED;
    }

    if (flags & OS_UNIX_FLUSH_USER_CACHE)
    {
#if defined(NVCPU_AARCH64)
        //
        // The Linux kernel does not export an interface for flushing a range,
        // although it is possible. For now, just flush the entire cache to be
        // safe.
        //
        CACHE_FLUSH_ALL();
#else
        // Flush L1 cache
        __cpuc_flush_dcache_area((void *)(NvU32)start, (NvU32)(end-start));
#if defined(OUTER_FLUSH_RANGE)
        // Now flush L2 cache.
        OUTER_FLUSH_RANGE((NvU32)physStart, (NvU32)physEnd);
#endif
#endif
    }

    if (flags & OS_UNIX_INVALIDATE_USER_CACHE)
    {
        // Invalidate L1/L2 cache
        dma_sync_single_for_device(NULL, (dma_addr_t) physStart, (NvU32)(physEnd - physStart), DMA_FROM_DEVICE);
    }
    return RM_OK;
#else
    return RM_ERR_NOT_SUPPORTED;
#endif
}

void NV_API_CALL os_flush_cpu_write_combine_buffer()
{
    WRITE_COMBINE_FLUSH();
}

// override initial debug level from registry
void NV_API_CALL os_dbg_init(void)
{
    NvU32 new_debuglevel;
    nv_stack_t *sp = NULL;

    NV_KMEM_CACHE_ALLOC_STACK(sp);
    if (sp == NULL)
    {
        nv_printf(NV_DBG_ERRORS, "NVRM: failed to allocate stack!\n");
        return;
    }

    if (RM_OK == rm_read_registry_dword(sp, NULL,
                                        "NVreg",
                                        "ResmanDebugLevel",
                                        &new_debuglevel))
    {
        if (new_debuglevel != (NvU32)~0)
            cur_debuglevel = new_debuglevel;
    }

    NV_KMEM_CACHE_FREE_STACK(sp);
}

void NV_API_CALL os_dbg_set_level(NvU32 new_debuglevel)
{
    nv_printf(NV_DBG_SETUP, "NVRM: Changing debuglevel from 0x%x to 0x%x\n",
        cur_debuglevel, new_debuglevel);
    cur_debuglevel = new_debuglevel;
}

RM_STATUS NV_API_CALL os_schedule(void)
{
    if (NV_MAY_SLEEP())
    {
        set_current_state(TASK_INTERRUPTIBLE);
        schedule_timeout(1);
        return RM_OK;
    }
    else
    {
        nv_printf(NV_DBG_ERRORS, "NVRM: os_schedule: Attempted to yield"
                                 " the CPU while in atomic or interrupt"
                                 " context\n");
        return RM_ERR_ILLEGAL_ACTION;
    }
}

static void os_execute_work_item(
    NV_TASKQUEUE_DATA_T *data
)
{
    nv_work_t *work = NV_TASKQUEUE_UNPACK_DATA(data);
    nv_stack_t *sp = NULL;

    NV_KMEM_CACHE_ALLOC_STACK(sp);
    if (sp == NULL)
    {
        nv_printf(NV_DBG_ERRORS, "NVRM: failed to allocate stack!\n");
        return;
    }

    rm_execute_work_item(sp, work->data);

    os_free_mem((void *)work);

    NV_KMEM_CACHE_FREE_STACK(sp);
}

RM_STATUS NV_API_CALL os_queue_work_item(
    void *nv_work
)
{
    RM_STATUS status;
    nv_work_t *work;

    status = os_alloc_mem((void **)&work, sizeof(nv_work_t));

    if (RM_OK != status)
        return status;

    work->data = nv_work;

    NV_TASKQUEUE_INIT(&work->task, os_execute_work_item,
                      (void *)work);
    NV_TASKQUEUE_SCHEDULE(&work->task);

    return RM_OK;
}

RM_STATUS NV_API_CALL os_flush_work_queue(void)
{
    if (NV_MAY_SLEEP())
    {
        NV_TASKQUEUE_FLUSH();
        return RM_OK;
    }
    else
    {
        nv_printf(NV_DBG_ERRORS,
                  "NVRM: os_flush_work_queue: attempted to execute passive"
                  "work from an atomic or interrupt context.\n");
        return RM_ERR_ILLEGAL_ACTION;
    }
}

void NV_API_CALL os_dbg_breakpoint(void)
{
#if defined(DEBUG)
  #if defined(CONFIG_X86_REMOTE_DEBUG) || defined(CONFIG_KGDB) || defined(CONFIG_XMON)
    #if defined(NVCPU_X86) || defined(NVCPU_X86_64)
        __asm__ __volatile__ ("int $3");
    #elif defined(NVCPU_ARM)
        __asm__ __volatile__ (".word %c0" :: "i" (KGDB_COMPILED_BREAK));
    #elif defined(NVCPU_AARCH64)
        # warning "Need to implement os_dbg_breakpoint() for aarch64"
    #elif defined(NVCPU_PPC64LE)
        __asm__ __volatile__ ("trap");
    #endif // NVCPU_X86 || NVCPU_X86_64
  #elif defined(CONFIG_KDB)
      KDB_ENTER();
  #endif // CONFIG_X86_REMOTE_DEBUG || CONFIG_KGDB || CONFIG_XMON
#endif // DEBUG
}

NvU32 NV_API_CALL os_get_cpu_number()
{
    NvU32 cpu_id = get_cpu();
    put_cpu();
    return cpu_id;
}

NvU32 NV_API_CALL os_get_cpu_count()
{
    return NV_NUM_CPUS();
}

void NV_API_CALL os_register_compatible_ioctl(NvU32 cmd, NvU32 size)
{
#if defined(NVCPU_X86_64) && defined(CONFIG_IA32_EMULATION) && \
  !defined(NV_FILE_OPERATIONS_HAS_COMPAT_IOCTL)
    unsigned int request = _IOWR(NV_IOCTL_MAGIC, cmd, char[size]);
    register_ioctl32_conversion(request, (void *)sys_ioctl);
#endif
}

void NV_API_CALL os_unregister_compatible_ioctl(NvU32 cmd, NvU32 size)
{
#if defined(NVCPU_X86_64) && defined(CONFIG_IA32_EMULATION) && \
  !defined(NV_FILE_OPERATIONS_HAS_COMPAT_IOCTL)
    unsigned int request = _IOWR(NV_IOCTL_MAGIC, cmd, char[size]);
    unregister_ioctl32_conversion(request);
#endif
}

BOOL NV_API_CALL os_pat_supported(void)
{
#if !defined(NV_VMWARE)
    return (nv_pat_mode != NV_PAT_MODE_DISABLED);
#else
    return TRUE;
#endif
}

BOOL NV_API_CALL os_is_efi_enabled(void)
{
    return NV_EFI_ENABLED();
}

RM_STATUS NV_API_CALL os_get_efi_screen_info(
    NvU64 *pPhysicalAddress,
    NvU32 *pHeight,
    NvU32 *pPitch
)
{
#if !defined(NV_VMWARE) && (defined(NVCPU_X86) || defined(NVCPU_X86_64))
    if (NV_EFI_ENABLED())
    {
        *pPhysicalAddress = screen_info.lfb_base;
        *pHeight = screen_info.lfb_height;
        *pPitch = screen_info.lfb_linelength;
        return RM_OK;
    }
#endif
    return RM_ERR_NOT_SUPPORTED;
}

void NV_API_CALL os_dump_stack()
{
#if defined(DEBUG)
    dump_stack();
#endif
}

typedef struct os_spinlock_s
{
    nv_spinlock_t      lock;
    unsigned long      eflags;
} os_spinlock_t;

RM_STATUS NV_API_CALL os_alloc_spinlock(void **ppSpinlock)
{
    RM_STATUS rmStatus;
    os_spinlock_t *os_spinlock;

    rmStatus = os_alloc_mem(ppSpinlock, sizeof(os_spinlock_t));
    if (rmStatus != RM_OK)
    {
        nv_printf(NV_DBG_ERRORS, "NVRM: failed to allocate spinlock!\n");
        return rmStatus;
    }

    os_spinlock = (os_spinlock_t *)*ppSpinlock;
    NV_SPIN_LOCK_INIT(&os_spinlock->lock);
    os_spinlock->eflags = 0;
    return RM_OK;
}

void NV_API_CALL os_free_spinlock(void *pSpinlock)
{
    os_free_mem(pSpinlock);
}

NvU64 NV_API_CALL os_acquire_spinlock(void *pSpinlock)
{
    os_spinlock_t *os_spinlock = (os_spinlock_t *)pSpinlock;
    unsigned long eflags;

    NV_SPIN_LOCK_IRQSAVE(&os_spinlock->lock, eflags);
    os_spinlock->eflags = eflags;

#if defined(NVCPU_X86) || defined(NVCPU_X86_64)
    eflags &= X86_EFLAGS_IF;
#elif defined(NVCPU_FAMILY_ARM)
    eflags &= PSR_I_BIT;
#endif
    return eflags;
}

void NV_API_CALL os_release_spinlock(void *pSpinlock, NvU64 oldIrql)
{
    os_spinlock_t *os_spinlock = (os_spinlock_t *)pSpinlock;
    unsigned long eflags;

    eflags = os_spinlock->eflags;
    os_spinlock->eflags = 0;
    NV_SPIN_UNLOCK_IRQRESTORE(&os_spinlock->lock, eflags);
}

RM_STATUS NV_API_CALL os_get_address_space_info(
    NvU64 *userStartAddress,
    NvU64 *userEndAddress,
    NvU64 *kernelStartAddress,
    NvU64 *kernelEndAddress
)
{
    RM_STATUS status = RM_OK;

#if !defined(CONFIG_X86_4G) && !defined(NV_VMWARE)
    *kernelStartAddress = PAGE_OFFSET;
    *kernelEndAddress = (NvUPtr)0xffffffffffffffffULL;
    *userStartAddress = 0;
    *userEndAddress = TASK_SIZE;
#else
    *kernelStartAddress = 0;
    *kernelEndAddress = 0;   /* invalid */
    *userStartAddress = 0;
    *userEndAddress = 0;     /* invalid */
    status = RM_ERR_NOT_SUPPORTED;
#endif
    return status;
}

#define NV_KERNEL_RELEASE    ((LINUX_VERSION_CODE >> 16) & 0x0ff)
#define NV_KERNEL_VERSION    ((LINUX_VERSION_CODE >> 8)  & 0x0ff)
#define NV_KERNEL_SUBVERSION ((LINUX_VERSION_CODE)       & 0x0ff)

RM_STATUS NV_API_CALL os_get_version_info(os_version_info * pOsVersionInfo)
{
    RM_STATUS status      = RM_OK;

    pOsVersionInfo->os_major_version = NV_KERNEL_RELEASE;
    pOsVersionInfo->os_minor_version = NV_KERNEL_VERSION;
    pOsVersionInfo->os_build_number  = NV_KERNEL_SUBVERSION;

#if defined(UTS_RELEASE)
    do
    {
        char * version_string = NULL;
        status = os_alloc_mem((void **)&version_string,
                              (strlen(UTS_RELEASE) + 1));
        if (status != RM_OK)
        {
            return status;
        }
        strcpy(version_string, UTS_RELEASE);
        pOsVersionInfo->os_build_version_str = version_string;
    }while(0);
#endif

#if defined(UTS_VERSION)
    do
    {
        char * date_string    = NULL;
        status = os_alloc_mem((void **)&date_string, (strlen(UTS_VERSION) + 1));
        if (status != RM_OK)
        {
            return status;
        }
        strcpy(date_string, UTS_VERSION);
        pOsVersionInfo->os_build_date_plus_str = date_string;
    }while(0);
#endif

    return status;
}

NvBool NV_API_CALL os_is_xen_dom0(void)
{
#if defined(NV_DOM0_KERNEL_PRESENT)
    return TRUE;
#else
    return FALSE;
#endif
}

NvBool NV_API_CALL os_is_vgx_hyper(void)
{
#if defined(NV_VGX_HYPER)
    return TRUE;
#else
    return FALSE;
#endif
}

void NV_API_CALL os_bug_check(NvU32 bugCode, const char *bugCodeStr)
{
    panic(bugCodeStr);
}

