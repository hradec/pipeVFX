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

#include "uvm_ioctl.h"
#include "nvidia_uvm_common.h"
#include "nvidia_uvm_lite.h"

//
// nvidia_uvm_page_cache.c This file contains code to manage the UVM page cache.
//

static struct kmem_cache * g_uvmPageTrackingCache  __read_mostly = NULL;

//
// Locking: you must hold a write lock on the DriverPrivate.uvmPrivLock, before
// calling this routine, OR call it from the last remaining thread that was
// using DriverPrivate (such as during the fops->release callback).
//
// The purpose of this routine is to provide a rudimentary memory leak checker,
// on a per-process basis. In the absence of bugs in this driver, this routine
// will always find an empty list of pages. If, however, there are any pages
// leaking for each process, then we will get a report of how many pages leaked,
// and the (possibly DVS-based) test will be interrupted by a kernel panic, so
// that we can notice it and track it down.
//
void uvm_page_cache_verify_page_list_empty(DriverPrivate* pPriv,
                                           const char * caller)
{
    struct list_head * pos;
    NvLength count = 0;

    if (unlikely(!list_empty(&pPriv->pageList)))
    {
        list_for_each(pos, &pPriv->pageList)
            ++count;

        UVM_PANIC_ON_MSG(!list_empty(&pPriv->pageList),
                         "there are still %llu pages in the list\n",
                         count);
    }
}

//
// Locking: probably no need to lock this, as the kernel's module initialization
// is serialized.
//
int uvm_page_cache_init(void)
{
    NV_KMEM_CACHE_CREATE(g_uvmPageTrackingCache, "uvm_page_tracking_t",
                         struct UvmPageTracking_tag);
    if (!g_uvmPageTrackingCache)
        return -ENOMEM;

    return 0;
}

//
// Locking: must be called while holding the global lock.
//
void uvm_page_cache_destroy(void)
{
    kmem_cache_destroy(g_uvmPageTrackingCache);
}

//
// This returns a pointer to the tracking struct that was created, or NULL if it
// failed.
//
// Locking: you must hold a write lock on the DriverPrivate.uvmPrivLock, before
// calling this routine.
//
UvmPageTracking * uvm_page_cache_alloc_page(DriverPrivate* pPriv)
{
    UvmPageTracking * pTracking;
    struct page *page;

    page = alloc_pages(NV_UVM_GFP_FLAGS | GFP_HIGHUSER, 0);
    if (!page)
        return NULL;

    pTracking = (UvmPageTracking*)kmem_cache_zalloc(g_uvmPageTrackingCache,
                                                    NV_UVM_GFP_FLAGS);
    if (!pTracking)
    {
        __free_page(page);
        return NULL;
    }

    get_page(page);
    pTracking->uvmPage = page;

    list_add_tail(&pTracking->pageListNode, &pPriv->pageList);

    return pTracking;
}

//
// Locking: you must hold a write lock on the DriverPrivate.uvmPrivLock, before
// calling this routine.
//
void uvm_page_cache_free_page(UvmPageTracking *pTracking,
                              const char *caller)
{
    if (!pTracking)
        return;

    UVM_DBG_PRINT_RL("(%s) Freeing: "
                     "0x%p (pfn:0x%lx, refcount: %d)\n",
                     caller, pTracking->uvmPage,
                     page_to_pfn(pTracking->uvmPage),
                     page_count(pTracking->uvmPage));

    list_del(&pTracking->pageListNode);
    __free_page(pTracking->uvmPage);
    kmem_cache_free(g_uvmPageTrackingCache, pTracking);
}

