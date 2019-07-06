/*******************************************************************************
    Copyright (c) 2013 NVidia Corporation

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to
    deal in the Software without restriction, including without limitation the
    rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
    sell copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

        The above copyright notice and this permission notice shall be
        included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
    THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
    DEALINGS IN THE SOFTWARE.

*******************************************************************************/

//
// nvidia_uvm_linux.h
//
// This file, along with conftest.h and nvidia_umv_linux.c, helps to insulate
// the (out-of-tree) UVM driver from changes to the upstream Linux kernel.
//
//

#ifndef _NVIDIA_UVM_LINUX_H
#define _NVIDIA_UVM_LINUX_H

//
// TODO: bug 1349097: split nv-linux.h into a common portion, then include that
// from both here, and from the RM (approximately).
//
#include "conftest.h"

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

#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 18)
#  error This driver does not support kernels older than 2.6.18!
#elif LINUX_VERSION_CODE < KERNEL_VERSION(2, 7, 0)
#  define KERNEL_2_6
#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3, 0, 0)
#  define KERNEL_3
#else
#  error This driver does not support development kernels!
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
#if !defined(VM_MIXEDMAP)
#define VM_MIXEDMAP    0x00000000
#endif

#include <linux/init.h>             /* module_init, module_exit         */
#include <linux/types.h>            /* pic_t, size_t, __u32, etc        */
#include <linux/errno.h>            /* error codes                      */
#include <linux/list.h>             /* circular linked list             */
#include <linux/stddef.h>           /* NULL, offsetof                   */
#include <linux/wait.h>             /* wait queues                      */
#include <linux/string.h>           /* strchr(), strpbrk()              */

#include <linux/rwsem.h>
#include <linux/rbtree.h>
#include <asm/current.h>
#include <linux/cdev.h>

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

#include <linux/interrupt.h>        /* tasklets, interrupt helpers      */
#include <linux/timer.h>
#include <linux/time.h>             /* do_gettimeofday()*/

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

#if defined(NV_VM_INSERT_PAGE_PRESENT)
#include <linux/pagemap.h>
#include <linux/dma-mapping.h>
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
#include <linux/kref.h>

#if defined(CONFIG_X86_REMOTE_DEBUG)
#include <linux/gdb.h>
#endif

#if defined(DEBUG) && defined(CONFIG_KGDB) && \
    defined(NVCPU_ARM)
#include <asm/kgdb.h>
#endif

#define NV_UVM_FENCE()   mb()

#if defined(NV_LINUX_PRINTK_H_PRESENT)
#include <linux/printk.h>
#endif

#if defined(NV_LINUX_RATELIMIT_H_PRESENT)
#include <linux/ratelimit.h>
#endif

#if !defined(no_printk)
//
// TODO: bug 1329255: instead of this heavy-handed approach, use conftest to
// check for no_printk(), and provide the same inline routine, if it's missing.
//
#define no_printk(fmt, ...)
#endif

//
// printk.h already defined pr_fmt, so we have to redefine it so the pr_*
// routines pick up our version
//
#undef pr_fmt
#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

#if !defined(pr_err)
#define pr_err(fmt, ...) \
        printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
#endif

#if !defined(pr_devel)
#ifdef DEBUG
#define pr_devel(fmt, ...) \
        printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
#else
#define pr_devel(fmt, ...) \
        no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
#endif
#endif

#if !defined(printk_ratelimited)
#define printk_ratelimited(fmt, ...)                                    \
        no_printk(fmt, ##__VA_ARGS__)
#endif

#if !defined(pr_debug_ratelimited)
#define pr_debug_ratelimited(fmt, ...) \
        no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
#endif

#if LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0)
// Just too much compilation trouble with the rate-limiting printk feature
// until about k3.8. Because the non-rate-limited printing will cause surprises
// and problems, just turn it off entirely in this situation.
//
#undef pr_debug_ratelimited
#define pr_debug_ratelimited(fmt, ...) \
        no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
#endif

#if defined(NV_PRIO_TREE_PRESENT)
#include <linux/prio_tree.h>
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

#if !defined(GFP_DMA32)
/*
 * GFP_DMA32 is similar to GFP_DMA, but instructs the Linux zone
 * allocator to allocate memory from the first 4GB on platforms
 * such as Linux/x86-64; the alternative is to use an IOMMU such
 * as the one implemented with the K8 GART, if available.
 */
#define GFP_DMA32 0
#endif

#if !defined(__GFP_NOWARN)
#define __GFP_NOWARN 0
#endif

#if !defined(__GFP_NORETRY)
#define __GFP_NORETRY 0
#endif

#if !defined(DEBUG)
// For non-debug builds, we want to suppress warning about failures to allocate
// within atomic context, because these warnings should generally be false
// alarms. That is because the driver must allow for such failures, due to the
// small, limited pool of GFP_ATOMIC pages available.
#define NV_GFP_ATOMIC (GFP_ATOMIC | __GFP_NOWARN)
#else
#define NV_GFP_ATOMIC GFP_ATOMIC
#endif

#define NV_UVM_GFP_FLAGS (GFP_KERNEL | __GFP_NORETRY)

#if !defined(IRQF_SHARED)
#define IRQF_SHARED SA_SHIRQ
#endif

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

#define NV_IS_SUSER()                   capable(CAP_SYS_ADMIN)

#if defined(cpu_relax)
#define NV_CPU_RELAX() cpu_relax()
#else
#define NV_CPU_RELAX() barrier()
#endif

#ifndef IRQ_RETVAL
typedef void irqreturn_t;
#define IRQ_RETVAL(a)
#endif

#if defined(NV_VM_INSERT_PAGE_PRESENT)
#define NV_VM_INSERT_PAGE(vma, addr, page) \
    vm_insert_page(vma, addr, page)
#endif

#if defined(NV_REMAP_PFN_RANGE_PRESENT)
#define NV_REMAP_PAGE_RANGE(from, offset, x...) \
    remap_pfn_range(vma, from, ((offset) >> PAGE_SHIFT), x)
#elif defined(NV_REMAP_PAGE_RANGE_PRESENT)
#if (NV_REMAP_PAGE_RANGE_ARGUMENT_COUNT == 5)
#define NV_REMAP_PAGE_RANGE(x...) remap_page_range(vma, x)
#elif (NV_REMAP_PAGE_RANGE_ARGUMENT_COUNT == 4)
#define NV_REMAP_PAGE_RANGE(x...) remap_page_range(x)
#else
#error "NV_REMAP_PAGE_RANGE_ARGUMENT_COUNT value unrecognized!"
#endif
#else
#error "NV_REMAP_PAGE_RANGE() undefined!"
#endif

#if !defined(NV_ADDRESS_SPACE_INIT_ONCE_PRESENT)
    void address_space_init_once(struct address_space *mapping);
#endif

#if !defined(NV_FATAL_SIGNAL_PENDING_PRESENT)
    static inline int __fatal_signal_pending(struct task_struct *p)
    {
        return unlikely(sigismember(&p->pending.signal, SIGKILL));
    }

    static inline int fatal_signal_pending(struct task_struct *p)
    {
        return signal_pending(p) && __fatal_signal_pending(p);
    }
#endif

//
// Before the current->cred structure was introduced, current->euid,
// or early implementations of current_euid() were sufficient. However, the
// (non-GPL) UVM driver cannot use current_euid() macro now, because
// current_euid() pulls in the GPL symbol debug_lockdep_rcu_enabled() when the
// kernel is configured with CONFIG_PROVE_RCU. Fortunately, that GPL symbol is
// used only for debugging purposes, so we can reimplement the non-debug part
// of the current_euid() function here, and still get what we need.
//
// The Linux kernel relies on the assumption that only the current process
// is permitted to change it's cred structure. Therefore, current_euid() does
// not require the RCU's read lock on current->cred.
//
//
#if defined(NV_TASK_STRUCT_HAS_CRED)
#define NV_CURRENT_EUID() (__kuid_val(current->cred->euid))
#else
#define NV_CURRENT_EUID() (__kuid_val(current->euid))
#endif

#if !defined(NV_KUID_T_PRESENT)
typedef uid_t kuid_t;

static inline uid_t __kuid_val(kuid_t uid)
{
    return uid;
}
#endif

#define NV_ATOMIC_SET(data,val)         atomic_set(&(data), (val))
#define NV_ATOMIC_INC(data)             atomic_inc(&(data))
#define NV_ATOMIC_DEC(data)             atomic_dec(&(data))
#define NV_ATOMIC_DEC_AND_TEST(data)    atomic_dec_and_test(&(data))
#define NV_ATOMIC_READ(data)            atomic_read(&(data))


#ifndef NV_ALIGN_UP
#define NV_ALIGN_UP(v,g) (((v) + ((g) - 1)) & ~((g) - 1))
#endif
#ifndef NV_ALIGN_DOWN
#define NV_ALIGN_DOWN(v,g) ((v) & ~((g) - 1))
#endif

//
// This provides a value that can be used where vmf->flags would normally
// be used, but on older kernels that do not have a vmf, nor FAULT_FLAG_*
// definitions:
//
#define FAULT_FLAG_FROM_OLD_KERNEL     0x80000000

#if !defined(NV_KBASENAME_PRESENT)
static inline const char *kbasename(const char *str)
{
    const char *p = strrchr(str, '/');
    if (!p)
        return str;
    return p + 1;
}
#endif

#endif // _NVIDIA_UVM_LINUX_H

