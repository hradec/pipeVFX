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

RM_STATUS NV_API_CALL os_lock_user_pages(
    void   *address,
    NvU64   page_count,
    void  **page_array
)
{
#if defined(NV_VM_INSERT_PAGE_PRESENT)
    RM_STATUS rmStatus;
    struct mm_struct *mm = current->mm;
    struct page **user_pages;
    NvU32 i, pinned;
    NvBool write = 1, force = 0;
    int ret;

    if (!NV_MAY_SLEEP())
    {
        nv_printf(NV_DBG_ERRORS,
            "NVRM: os_lock_user_memory(): invalid context!\n");
        return RM_ERR_NOT_SUPPORTED;
    }

    rmStatus = os_alloc_mem((void **)&user_pages,
            (page_count * sizeof(*user_pages)));
    if (rmStatus != RM_OK)
    {
        nv_printf(NV_DBG_ERRORS,
                "NVRM: failed to allocate page table!\n");
        return rmStatus;
    }

    down_read(&mm->mmap_sem);
    ret = get_user_pages(current, mm, (unsigned long)address,
            page_count, write, force, user_pages, NULL);
    up_read(&mm->mmap_sem);
    pinned = ret;

    if (ret < 0)
    {
        os_free_mem(user_pages);
        return RM_ERR_INVALID_ADDRESS;
    }
    else if (pinned < page_count)
    {
        for (i = 0; i < pinned; i++)
            page_cache_release(user_pages[i]);
        os_free_mem(user_pages);
        return RM_ERR_INVALID_ADDRESS;
    }

    *page_array = user_pages;

    return RM_OK;
#else
    return RM_ERR_NOT_SUPPORTED;
#endif
}

RM_STATUS NV_API_CALL os_unlock_user_pages(
    NvU64  page_count,
    void  *page_array
)
{
#if defined(NV_VM_INSERT_PAGE_PRESENT)
    NvBool write = 1;
    struct page **user_pages = page_array;
    NvU32 i;

    for (i = 0; i < page_count; i++)
    {
        if (write)
            set_page_dirty_lock(user_pages[i]);
        page_cache_release(user_pages[i]);
    }

    os_free_mem(user_pages);

    return RM_OK;
#else
    return RM_ERR_NOT_SUPPORTED;
#endif
}
