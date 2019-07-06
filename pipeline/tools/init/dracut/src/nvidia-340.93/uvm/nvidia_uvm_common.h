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

    Authors: Mark Hairgrove (mhairgrove@nvidia.com)
             John Hubbard   (jhubbard@nvidia.com)
             Subhash Gutti  (sgutti@nvidia.com)

*******************************************************************************/

/*
 * nvidia_uvm_common.h
 *
 * This file contains common header code that can be used for all variants of
 * the UVM kernel module.
 *
 * Initially, UVM-Lite and Uvm-Next work is proceeding somewhat
 * independently, but the long- and short-term plan is for them to share the
 * same kernel module (this one). That's why, at least initially, you'll find
 * files for UVM-Lite, for Uvm-Next, and for common code. We'll refactor as
 * necessary, to achieve the right balance of sharing code and decoupling the
 * features.
 *
 * --jhubbard
 *
 */

#ifndef _NVIDIA_UVM_COMMON_H
#define _NVIDIA_UVM_COMMON_H

#include "uvmtypes.h"
#include "nvidia_uvm_linux.h"
#include "nvidia_uvm_utils.h"

#define NVIDIA_UVM_DEVICE_NAME          "nvidia-uvm"
#define NVIDIA_UVM_NUM_MINOR_DEVICES    2

#define UVM_PRINT_FUNC(func, fmt, ...)  \
    func("%s:%u %s[pid:%d]" fmt,           \
         kbasename(__FILE__),           \
         __LINE__,                      \
         __FUNCTION__,                  \
         current->pid,                  \
         ##__VA_ARGS__)

#ifdef DEBUG
#define UVM_ERR_PRINT(fmt, ...) \
    UVM_PRINT_FUNC(pr_err, " " fmt, ##__VA_ARGS__)

#define UVM_DBG_PRINT(fmt, ...) \
    UVM_PRINT_FUNC(pr_devel, " " fmt, ##__VA_ARGS__)

#define UVM_DBG_PRINT_RL(fmt, ...) \
    UVM_PRINT_FUNC(pr_debug_ratelimited, " " fmt, ##__VA_ARGS__)

#define UVM_INFO_PRINT(fmt, ...) \
    UVM_PRINT_FUNC(pr_info, " " fmt, ##__VA_ARGS__)
#else
#define UVM_ERR_PRINT(fmt, ...)
#define UVM_DBG_PRINT(fmt, ...)
#define UVM_DBG_PRINT_RL(fmt, ...)
#define UVM_INFO_PRINT(fmt, ...)
#endif

//
// Please see the documentation of format_uuid_to_buffer, for details on what
// this routine prints for you.
//
#define UVM_DBG_PRINT_UUID(msg, uuidPtr)                                \
    do {                                                                \
        char uuidBuffer[UVM_GPU_UUID_TEXT_BUFFER_LENGTH];               \
        format_uuid_to_buffer(uuidBuffer, sizeof(uuidBuffer), uuidPtr); \
        UVM_DBG_PRINT("%s: %s\n", msg, uuidBuffer);                        \
    } while(0)

#define UVM_PANIC()             UVM_PRINT_FUNC(panic, "\n")
#define UVM_PANIC_MSG(fmt, ...) UVM_PRINT_FUNC(panic, ": " fmt, ##__VA_ARGS__)

#define UVM_PANIC_ON_MSG(cond, fmt, ...)        \
    do {                                        \
        if (unlikely(cond))                     \
            UVM_PANIC_MSG(fmt, ##__VA_ARGS__);  \
    } while(0)

#define UVM_PANIC_ON(cond)  UVM_PANIC_ON_MSG(cond, "failed cond %s\n", #cond)


// Provide a short form of UUID's, typically for use in debug printing:
#define ABBREV_UUID(uuid) (unsigned)(uuid)

static int uvmlite_enabled(void)
{
#ifdef NVIDIA_UVM_LITE_ENABLED
    return 1;
#else
    return 0;
#endif
}

static int uvmnext_enabled(void)
{
#ifdef NVIDIA_UVM_NEXT_ENABLED
    return 1;
#else
    return 0;
#endif
}

static int rm_enabled(void)
{
#ifdef NVIDIA_UVM_RM_ENABLED
    return 1;
#else
    return 0;
#endif
}

static inline void kmem_cache_destroy_safe(struct kmem_cache* cache)
{
    if (cache)
        kmem_cache_destroy(cache);
}

//
// Documentation for the internal routines listed below may be found in the
// implementation file(s).
//
RM_STATUS errno_to_rm_status(int errnoCode);
unsigned uvm_get_stale_process_id(void);
NvBool uvm_user_id_security_check(uid_t euidTarget);
RM_STATUS uvm_map_page(struct vm_area_struct *vma, struct page *page,
                       unsigned long addr);

#endif /* _NVIDIA_UVM_COMMON_H */
