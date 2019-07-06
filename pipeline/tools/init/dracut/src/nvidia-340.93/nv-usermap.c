/* _NVRM_COPYRIGHT_BEGIN_
 *
 * Copyright 1999-2014 by NVIDIA Corporation.  All rights reserved.  All
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

void nv_user_map_init(void)
{
}

int nv_user_map_register(
    NvU64 address,
    NvU64 size
)
{
    return 0;
}

void nv_user_map_unregister(
    NvU64 address,
    NvU64 size
)
{
}

RM_STATUS NV_API_CALL nv_create_user_mapping_context(
    nv_state_t *nv,
    NvU64       address,
    NvU64       size,
    void      **ppPrivate
)
{
    RM_STATUS status = RM_OK;

#if defined(NV_4K_PAGE_ISOLATION_PRESENT)
    nv_mmap_isolation_t *mmap_isolation = NULL;

    /* We only need to use page isolation for the BAR mappings. */
    if (IS_REG_OFFSET(nv, address, size) ||
        IS_FB_OFFSET(nv, address, size) ||
        IS_IMEM_OFFSET(nv, address, size))
    {
        if (NV_4K_PAGE_ISOLATION_REQUIRED(address, size))
        {
            status = os_alloc_mem(ppPrivate, sizeof(nv_mmap_isolation_t));
            if (status != RM_OK)
            {
                *ppPrivate = NULL;
                return status;
            }

            /*
             * Given the platform-specific isolation mechanism, the user will
             * only be able to access the isolated range, even though the
             * user will pass a wider range to mmap().
             */
            mmap_isolation = (nv_mmap_isolation_t *)*ppPrivate;
            mmap_isolation->access_start =
                NV_4K_PAGE_ISOLATION_ACCESS_START(address);
            mmap_isolation->access_len =
                NV_4K_PAGE_ISOLATION_ACCESS_LEN(address, size);
            mmap_isolation->mmap_start =
                NV_4K_PAGE_ISOLATION_MMAP_ADDR(address);
            mmap_isolation->mmap_len =
                NV_4K_PAGE_ISOLATION_MMAP_LEN(size);
        }
        else if (((address & ~NV_PAGE_MASK) != 0) ||
                 ((size & ~NV_PAGE_MASK) != 0))
        {
            /*
             * If page isolation wasn't required, the user mapping must be
             * aligned to the OS page size and be a multiple of the OS page
             * size to avoid any security concerns.
             */
            nv_printf(NV_DBG_ERRORS,
                      "NVRM: the requested mapping cannot be fulfilled "
                      "because the address (0x%llx) or size (0x%llx) is "
                      "not aligned to a page boundary!\n", address, size);
            *ppPrivate = NULL;
            return RM_ERR_INVALID_REQUEST;
        }
    }
    else
#endif
    {
        *ppPrivate = NULL;
    }

    return status;
}

RM_STATUS NV_API_CALL nv_alloc_user_mapping(
    nv_state_t *nv,
    void       *pAllocPrivate,
    NvU64       pageIndex,
    NvU32       pageOffset,
    NvU64       size,
    NvU32       protect,
    NvU64      *pUserAddress,
    void      **ppPrivate
)
{
    nv_alloc_t *at = pAllocPrivate;

    if (NV_ALLOC_MAPPING_CONTIG(at->flags))
        *pUserAddress = (at->page_table[0]->phys_addr + (pageIndex * PAGE_SIZE) + pageOffset);
    else
        *pUserAddress = (at->page_table[pageIndex]->phys_addr + pageOffset);

    return RM_OK;
}

RM_STATUS NV_API_CALL nv_free_user_mapping(
    nv_state_t *nv,
    void       *pAllocPrivate,
    NvU64       userAddress,
    void       *pPrivate
)
{
    return RM_OK;
}
