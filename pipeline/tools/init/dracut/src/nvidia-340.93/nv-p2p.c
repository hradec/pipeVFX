/* _NVRM_COPYRIGHT_BEGIN_
 *
 * Copyright 2011 by NVIDIA Corporation.  All rights reserved.  All
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

#if (NV_BUILD_MODULE_INSTANCES == 0)
#include "nv-p2p.h"

static struct nvidia_status_mapping {
    RM_STATUS status;
    int error;
} nvidia_status_mappings[] = {
    { RM_ERROR,                      -EIO      },
    { RM_ERR_INSUFFICIENT_RESOURCES, -ENOMEM   },
    { RM_ERR_INVALID_ARGUMENT,       -EINVAL   },
    { RM_ERR_INVALID_OBJECT_HANDLE,  -EINVAL   },
    { RM_ERR_INVALID_STATE,          -EIO      },
    { RM_ERR_NOT_SUPPORTED,          -ENOTSUPP },
    { RM_ERR_OBJECT_NOT_FOUND,       -EINVAL   },
    { RM_ERR_STATE_IN_USE,           -EBUSY    },
    { RM_OK,                          0        },
};

#define NVIDIA_STATUS_MAPPINGS \
    (sizeof(nvidia_status_mappings) / sizeof(struct nvidia_status_mapping))

static int nvidia_p2p_map_status(RM_STATUS status)
{
    int error = -EIO;
    uint8_t i;

    for (i = 0; i < NVIDIA_STATUS_MAPPINGS; i++)
    {
        if (nvidia_status_mappings[i].status == status)
        {
            error = nvidia_status_mappings[i].error;
            break;
        }
    }
    return error;
}

int nvidia_p2p_init_mapping(
    uint64_t p2p_token,
    struct nvidia_p2p_params *params,
    void (*destroy_callback)(void *data),
    void *data
)
{
    nv_stack_t *sp = NULL;
    RM_STATUS status;
    union nvidia_p2p_mailbox_addresses *gpu, *tpd;

    if ((p2p_token == 0) || (params == NULL))
        return -EINVAL;

    if ((params->version > NVIDIA_P2P_PARAMS_VERSION) ||
        (params->architecture != NVIDIA_P2P_ARCHITECTURE_FERMI))
    {
        return -ENOTSUPP;
    }

    NV_KMEM_CACHE_ALLOC_STACK(sp);
    if (sp == NULL)
        return -ENOMEM;

    gpu = &params->addresses[NVIDIA_P2P_PARAMS_ADDRESS_INDEX_GPU];
    tpd = &params->addresses[NVIDIA_P2P_PARAMS_ADDRESS_INDEX_THIRD_PARTY_DEVICE];

    status = rm_p2p_init_mapping(sp, p2p_token, &gpu->fermi.wmb_addr,
            &gpu->fermi.wmb_data, &gpu->fermi.rreq_addr,
            &gpu->fermi.rcomp_addr, tpd->fermi.wmb_addr,
            tpd->fermi.wmb_data, tpd->fermi.rreq_addr, tpd->fermi.rcomp_addr,
            destroy_callback, data);

    NV_KMEM_CACHE_FREE_STACK(sp);

    return nvidia_p2p_map_status(status);
}

EXPORT_SYMBOL(nvidia_p2p_init_mapping);

int nvidia_p2p_destroy_mapping(uint64_t p2p_token)
{
    RM_STATUS status;
    nv_stack_t *sp = NULL;

    NV_KMEM_CACHE_ALLOC_STACK(sp);
    if (sp == NULL)
        return -ENOMEM;

    status = rm_p2p_destroy_mapping(sp, p2p_token);

    NV_KMEM_CACHE_FREE_STACK(sp);

    return nvidia_p2p_map_status(status);
}

EXPORT_SYMBOL(nvidia_p2p_destroy_mapping);

int nvidia_p2p_get_pages(
    uint64_t p2p_token,
    uint32_t va_space,
    uint64_t virtual_address,
    uint64_t length,
    struct nvidia_p2p_page_table **page_table,
    void (*free_callback)(void * data),
    void *data
)
{
    RM_STATUS status;
    nv_stack_t *sp = NULL;
    struct nvidia_p2p_page *page;
    NvU32 entries;
    NvU32 *wreqmb_h, *rreqmb_h;
    NvU64 *physical_addresses;
    NvU32 i, j;

    NV_KMEM_CACHE_ALLOC_STACK(sp);
    if (sp == NULL)
        return -ENOMEM;

    status = os_alloc_mem((void *)page_table, sizeof(**page_table));
    if (status != RM_OK)
        return -ENOMEM;

    status = rm_p2p_get_pages(sp, p2p_token, va_space,
            virtual_address, length, &physical_addresses, &wreqmb_h,
            &rreqmb_h, &entries, *page_table,
            free_callback, data);
    if (status != RM_OK)
    {
        os_free_mem(*page_table);
    }
    else
    {
        status = os_alloc_mem((void *)&(*page_table)->pages,
                (entries * sizeof(page)));
        if (status != RM_OK)
        {
            os_free_mem(*page_table);
        }
        else
        {
            (*page_table)->version = NVIDIA_P2P_PAGE_TABLE_VERSION;

            for (i = 0; i < entries; i++)
            {
                NV_KMEM_CACHE_ALLOC(page, nvidia_p2p_page_t_cache,
                        nvidia_p2p_page_t);
                if (page == NULL)
                    goto failed;

                memset(page, 0, sizeof(*page));

                page->physical_address = physical_addresses[i];
                page->registers.fermi.wreqmb_h = wreqmb_h[i];
                page->registers.fermi.rreqmb_h = rreqmb_h[i];

                (*page_table)->pages[i] = page;
            }

            os_free_mem(physical_addresses);
            os_free_mem(wreqmb_h);
            os_free_mem(rreqmb_h);

            (*page_table)->page_size = NVIDIA_P2P_PAGE_SIZE_64KB;
            (*page_table)->entries = entries;
        }
    }

    NV_KMEM_CACHE_FREE_STACK(sp);

    return nvidia_p2p_map_status(status);

failed:
    os_free_mem(physical_addresses);
    os_free_mem(wreqmb_h);
    os_free_mem(rreqmb_h);

    for (j = 0; j < i; j++)
    {
        NV_KMEM_CACHE_FREE((*page_table)->pages[j], nvidia_p2p_page_t,
                nvidia_p2p_page_t_cache);
    }

    rm_p2p_put_pages(sp, p2p_token, va_space, virtual_address,
            *page_table);

    os_free_mem((*page_table)->pages);
    os_free_mem(*page_table);

    NV_KMEM_CACHE_FREE_STACK(sp);

    return nvidia_p2p_map_status(status);
}

EXPORT_SYMBOL(nvidia_p2p_get_pages);

int nvidia_p2p_free_page_table(struct nvidia_p2p_page_table *page_table)
{
    NvU32 i;

    if (page_table == NULL)
        return -EINVAL;

    for (i = 0; i < page_table->entries; i++)
    {
        NV_KMEM_CACHE_FREE(page_table->pages[i], nvidia_p2p_page_t,
                nvidia_p2p_page_t_cache);
    }

    os_free_mem(page_table->pages);
    os_free_mem(page_table);

    return 0;
}

EXPORT_SYMBOL(nvidia_p2p_free_page_table);

int nvidia_p2p_put_pages(
    uint64_t p2p_token,
    uint32_t va_space,
    uint64_t virtual_address,
    struct nvidia_p2p_page_table *page_table
)
{
    RM_STATUS status;
    nv_stack_t *sp = NULL;

    NV_KMEM_CACHE_ALLOC_STACK(sp);
    if (sp == NULL)
        return -ENOMEM;

    status = rm_p2p_put_pages(sp, p2p_token, va_space, virtual_address,
            page_table);
    if (status == RM_OK)
        nvidia_p2p_free_page_table(page_table);

    NV_KMEM_CACHE_FREE_STACK(sp);

    return nvidia_p2p_map_status(status);
}

EXPORT_SYMBOL(nvidia_p2p_put_pages);
#endif
