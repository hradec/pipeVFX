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

static void nv_fill_scatterlist
(
    struct scatterlist *sgl,
    struct page **pages,
    unsigned int page_count
)
{
    unsigned int i;
    struct scatterlist *sg;
#if defined(for_each_sg)
    for_each_sg(sgl, sg, page_count, i)
    {
        sg_set_page(sg, pages[i], PAGE_SIZE, 0);
    }
#else
    for (i = 0; i < page_count; i++)
    {
        sg = &(sgl)[i];
        sg->page = pages[i];
        sg->length = PAGE_SIZE;
        sg->offset = 0;
    }
#endif
}

RM_STATUS nv_create_dma_map_scatterlist(nv_dma_map_t *dma_map)
{
    RM_STATUS status = NV_ALLOC_DMA_MAP_SCATTERLIST(dma_map);
#if !defined(NV_SG_ALLOC_TABLE_FROM_PAGES_PRESENT)
    if (status == RM_OK)
    {
        nv_fill_scatterlist(NV_DMA_MAP_SCATTERLIST(dma_map),
            dma_map->user_pages, dma_map->page_count);
    }
#endif

    return status;
}

void nv_destroy_dma_map_scatterlist(nv_dma_map_t *dma_map)
{
#if defined(NV_SG_TABLE_PRESENT)
    sg_free_table(&dma_map->sgt);
#else
    os_free_mem(dma_map->sgl);
#endif
}

void nv_load_dma_map_scatterlist(
    nv_dma_map_t *dma_map,
    NvU64 *pte_array
)
{
    unsigned int i, j = 0;
    NvU64 sg_addr, sg_off, sg_len;
    struct scatterlist *sg;

    NV_FOR_EACH_DMA_MAP_SG(dma_map, sg, i)
    {
        /*
         * It is possible for pci_map_sg() to merge scatterlist entries, so
         * make sure we account for that here.
         */
        for (sg_addr = sg_dma_address(sg), sg_len = sg_dma_len(sg), sg_off = 0;
             (sg_off < sg_len) && (j < dma_map->page_count);
             sg_off += PAGE_SIZE, j++)
        {
            pte_array[j] = sg_addr + sg_off;
        }
    }
}

RM_STATUS NV_API_CALL nv_dma_map_pages(
    nv_state_t *nv,
    NvU64       page_count,
    NvU64      *pte_array,
    void      **priv
)
{
    RM_STATUS status;
    NvU64 i;
    nv_linux_state_t *nvl = NV_GET_NVL_FROM_NV_STATE(nv);
    nv_dma_map_t *dma_map = NULL;

    if (priv == NULL)
    {
        /*
         * IOMMU path has not been implemented yet to handle
         * anything except a nv_dma_map_t as the priv argument.
         */
        return RM_ERR_NOT_SUPPORTED;
    }

    if (page_count > os_get_num_phys_pages())
    {
        nv_printf(NV_DBG_ERRORS,
                "NVRM: DMA mapping request too large!\n");
        return RM_ERR_INVALID_REQUEST;
    }

    status = os_alloc_mem((void **)&dma_map, sizeof(nv_dma_map_t));
    if (status != RM_OK)
    {
        nv_printf(NV_DBG_ERRORS,
                "NVRM: Failed to allocate nv_dma_map_t!\n");
        return status;
    }

    dma_map->dev = nvl->dev;
    dma_map->user_pages = *priv;
    dma_map->page_count = page_count;
    dma_map->sg_map_count = 0;

    status = nv_create_dma_map_scatterlist(dma_map);
    if (status != RM_OK)
    {
        nv_printf(NV_DBG_ERRORS,
                "NVRM: Failed to allocate DMA mapping scatterlist!\n");
        os_free_mem(dma_map);
        return status;
    }

    dma_map->sg_map_count = pci_map_sg(dma_map->dev,
            NV_DMA_MAP_SCATTERLIST(dma_map),
            NV_DMA_MAP_SCATTERLIST_LENGTH(dma_map),
            PCI_DMA_BIDIRECTIONAL);
    if (dma_map->sg_map_count == 0)
    {
        nv_printf(NV_DBG_ERRORS,
                "NVRM: failed to create a DMA mapping!\n");
        (void)nv_dma_unmap_pages(nv, dma_map->page_count, pte_array,
                (void **)&dma_map);
        return RM_ERR_OPERATING_SYSTEM;
    }

    nv_load_dma_map_scatterlist(dma_map, pte_array);

    for (i = 0; i < page_count; i++)
    {
        if (!IS_DMA_ADDRESSABLE(nv, pte_array[i]))
        {
            nv_printf(NV_DBG_ERRORS,
                    "NVRM: DMA address not in addressable range of device "
                    "%04x:%02x:%02x (0x%llx, 0x%llx-0x%llx)\n",
                    NV_PCI_DOMAIN_NUMBER(dma_map->dev),
                    NV_PCI_BUS_NUMBER(dma_map->dev),
                    NV_PCI_SLOT_NUMBER(dma_map->dev),
                    pte_array[i], nv->dma_addressable_start,
                    nv->dma_addressable_limit);
            (void)nv_dma_unmap_pages(nv, dma_map->page_count, pte_array,
                    (void **)&dma_map);
            return RM_ERR_INVALID_ADDRESS;
        }
    }

    *priv = dma_map;

    return RM_OK;
}

RM_STATUS NV_API_CALL nv_dma_unmap_pages(
    nv_state_t *nv,
    NvU64       page_count,
    NvU64      *pte_array,
    void      **priv
)
{
    nv_dma_map_t *dma_map;

    if (priv == NULL)
    {
        /*
         * IOMMU path has not been implemented yet to handle
         * anything except a nv_dma_map_t as the priv argument.
         */
        return RM_ERR_NOT_SUPPORTED;
    }

    dma_map = *priv;

    if (page_count > os_get_num_phys_pages())
    {
        nv_printf(NV_DBG_ERRORS,
                "NVRM: DMA unmapping request too large!\n");
        return RM_ERR_INVALID_REQUEST;
    }

    if (page_count != dma_map->page_count)
    {
        nv_printf(NV_DBG_WARNINGS,
                "NVRM: Requested to DMA unmap %llu pages, but there are %llu "
                "in the mapping\n", page_count, dma_map->page_count);
        return RM_ERR_INVALID_REQUEST;
    }

    if (dma_map->sg_map_count != 0)
    {
        pci_unmap_sg(dma_map->dev, NV_DMA_MAP_SCATTERLIST(dma_map),
                NV_DMA_MAP_SCATTERLIST_LENGTH(dma_map), PCI_DMA_BIDIRECTIONAL);
    }

    *priv = dma_map->user_pages;

    nv_destroy_dma_map_scatterlist(dma_map);
    os_free_mem(dma_map);

    return RM_OK;
}
