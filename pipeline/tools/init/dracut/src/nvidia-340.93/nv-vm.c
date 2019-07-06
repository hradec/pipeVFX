/* _NVRM_COPYRIGHT_BEGIN_
 *
 * Copyright 1999-2013 by NVIDIA Corporation.  All rights reserved.  All
 * information contained herein is proprietary and confidential to NVIDIA
 * Corporation.  Any use, reproduction, or disclosure without the written
 * permission of NVIDIA Corporation is prohibited.
 *
 * _NVRM_COPYRIGHT_END_
 */

#include "nv-misc.h"
#include "os-interface.h"
#include "nv.h"
#include "nv-linux.h"

static inline void nv_set_contig_memory_uc(nv_pte_t *page_ptr, NvU32 num_pages)
{
    if (nv_update_memory_types)
    {
#if defined(NV_SET_MEMORY_UC_PRESENT)
        struct page *page = NV_GET_PAGE_STRUCT(page_ptr->phys_addr);
        unsigned long addr = (unsigned long)page_address(page);
        set_memory_uc(addr, num_pages);
#elif defined(NV_SET_PAGES_UC_PRESENT)
        struct page *page = NV_GET_PAGE_STRUCT(page_ptr->phys_addr);
        set_pages_uc(page, num_pages);
#elif defined(NV_CHANGE_PAGE_ATTR_PRESENT)
        struct page *page = NV_GET_PAGE_STRUCT(page_ptr->phys_addr);
        pgprot_t prot = PAGE_KERNEL_NOCACHE;
#if defined(NVCPU_X86) || defined(NVCPU_X86_64)
        pgprot_val(prot) &= __nv_supported_pte_mask;
#endif
        change_page_attr(page, num_pages, prot);
#endif
    }
}


static inline void nv_set_contig_memory_wb(nv_pte_t *page_ptr, NvU32 num_pages)
{
    if (nv_update_memory_types)
    {
#if defined(NV_SET_MEMORY_UC_PRESENT)
        struct page *page = NV_GET_PAGE_STRUCT(page_ptr->phys_addr);
        unsigned long addr = (unsigned long)page_address(page);
        set_memory_wb(addr, num_pages);
#elif defined(NV_SET_PAGES_UC_PRESENT)
        struct page *page = NV_GET_PAGE_STRUCT(page_ptr->phys_addr);
        set_pages_wb(page, num_pages);
#elif defined(NV_CHANGE_PAGE_ATTR_PRESENT)
        struct page *page = NV_GET_PAGE_STRUCT(page_ptr->phys_addr);
        pgprot_t prot = PAGE_KERNEL;
#if defined(NVCPU_X86) || defined(NVCPU_X86_64)
        pgprot_val(prot) &= __nv_supported_pte_mask;
#endif
        change_page_attr(page, num_pages, prot);
#endif
    }
}

static inline int nv_set_memory_array_type_present(NvU32 type)
{
    switch (type)
    {
#if defined(NV_SET_MEMORY_ARRAY_UC_PRESENT)
        case NV_MEMORY_UNCACHED:
            return 1;
        case NV_MEMORY_WRITEBACK:
            return 1;
#endif
        default:
            return 0;
    }
}

static inline void nv_set_memory_array_type(
    unsigned long *pages,
    NvU32 num_pages,
    NvU32 type
)
{
    switch (type)
    {
#if defined(NV_SET_MEMORY_ARRAY_UC_PRESENT)
        case NV_MEMORY_UNCACHED:
            set_memory_array_uc(pages, num_pages);
            break;
        case NV_MEMORY_WRITEBACK:
            set_memory_array_wb(pages, num_pages);
            break;
#endif
        default:
            nv_printf(NV_DBG_ERRORS,
                "NVRM: %s(): type %d unimplemented\n",
                __FUNCTION__, type);
            break;
    }
}

static inline void nv_set_contig_memory_type(
    nv_pte_t *page_ptr,
    NvU32 num_pages,
    NvU32 type
)
{
    if (nv_update_memory_types)
    {
        switch (type)
        {
            case NV_MEMORY_UNCACHED:
                nv_set_contig_memory_uc(page_ptr, num_pages);
                break;
            case NV_MEMORY_WRITEBACK:
                nv_set_contig_memory_wb(page_ptr, num_pages);
                break;
            default:
                nv_printf(NV_DBG_ERRORS,
                    "NVRM: %s(): type %d unimplemented\n",
                    __FUNCTION__, type);
        }
    }
}

static inline void nv_set_memory_type(nv_alloc_t *at, NvU32 type)
{
    NvU32 i;
    RM_STATUS status;
    unsigned long *pages;
    nv_pte_t *page_ptr;
    struct page *page;

    if (nv_update_memory_types)
    {
        pages = NULL;

        if (nv_set_memory_array_type_present(type))
        {
            status = os_alloc_mem((void **)&pages,
                        at->num_pages * sizeof(unsigned long));
            if (status != RM_OK)
                pages = NULL;
        }

        if (pages)
        {
            for (i = 0; i < at->num_pages; i++)
            {
                page_ptr = at->page_table[i];
                page = NV_GET_PAGE_STRUCT(page_ptr->phys_addr);
                pages[i] = (unsigned long)page_address(page);
            }
            nv_set_memory_array_type(pages, at->num_pages, type);
            os_free_mem(pages);
        }
        else
        {
            for (i = 0; i < at->num_pages; i++)
                nv_set_contig_memory_type(at->page_table[i], 1, type);
        }
    }
}

#if defined(NV_SG_MAP_BUFFERS)

#if defined(NV_NEED_REMAP_CHECK)
extern unsigned int nv_remap_count;
extern unsigned int nv_remap_limit;
#endif

static inline int nv_map_sg(struct pci_dev *dev, struct scatterlist *sg)
{
    return pci_map_sg(dev, sg, 1, PCI_DMA_BIDIRECTIONAL);
}

static inline void nv_unmap_sg(struct pci_dev *dev, struct scatterlist *sg)
{
    pci_unmap_sg(dev, sg, 1, PCI_DMA_BIDIRECTIONAL);
}

#define NV_MAP_SG_MAX_RETRIES 16

static inline int nv_sg_map_buffer(
    struct pci_dev     *dev,
    nv_pte_t          **page_list,
    void               *base,
    unsigned int        num_pages
)
{
    struct scatterlist *sg_ptr = &page_list[0]->sg_list;
    struct scatterlist sg_tmp;
    unsigned int i;

    NV_SG_INIT_TABLE(sg_ptr, 1);

#if defined(NV_SCATTERLIST_HAS_PAGE)
    sg_ptr->page = virt_to_page(base);
#else
    sg_ptr->page_link = (NvUPtr)virt_to_page(base);
#endif
    sg_ptr->offset = ((unsigned long)base & ~NV_PAGE_MASK);
    sg_ptr->length  = num_pages * PAGE_SIZE;

#if !defined(NV_INTEL_IOMMU) && !defined(NVCPU_PPC64LE) && \
  !defined(NV_XEN_SUPPORT_FULLY_VIRTUALIZED_KERNEL)
    if (((virt_to_phys(base) + sg_ptr->length - 1) & ~dev->dma_mask) == 0)
    {
        sg_ptr->dma_address = virt_to_phys(base);
        goto done;
    }
#endif

#if defined(NV_NEED_REMAP_CHECK)
    if ((nv_remap_count + sg_ptr->length) > nv_remap_limit)
    {
        static int count = 0;
        if (count < NV_MAX_RECURRING_WARNING_MESSAGES)
        {
            nv_printf(NV_DBG_ERRORS,
                "NVRM: internal IOMMU remap limit (0x%x bytes) exceeded.\n",
                nv_remap_limit);

        }
        if (count++ == 0)
        {
            nv_printf(NV_DBG_ERRORS,
                "NVRM: please see the README section on IOMMU "
                "interaction for details.\n");
        }
        return 1;
    }
#endif

    i = NV_MAP_SG_MAX_RETRIES;
    do {
        if (nv_map_sg(dev, sg_ptr) == 0)
            return -1;

        if (sg_ptr->dma_address & ~NV_PAGE_MASK)
        {
            nv_unmap_sg(dev, sg_ptr);

            NV_SG_INIT_TABLE(&sg_tmp, 1);

#if defined(NV_SCATTERLIST_HAS_PAGE)
            sg_tmp.page = sg_ptr->page;
#else
            sg_tmp.page_link = sg_ptr->page_link;
#endif
            sg_tmp.offset = sg_ptr->offset;
            sg_tmp.length = 2048;

            if (nv_map_sg(dev, &sg_tmp) == 0)
                return -1;

            if (nv_map_sg(dev, sg_ptr) == 0)
            {
                nv_unmap_sg(dev, &sg_tmp);
                return -1;
            }

            nv_unmap_sg(dev, &sg_tmp);
        }
    }
    while (i-- && sg_ptr->dma_address & ~NV_PAGE_MASK);

    if (sg_ptr->dma_address & ~NV_PAGE_MASK)
    {
        nv_printf(NV_DBG_ERRORS,
            "NVRM: VM: nv_sg_map_buffer: failed to obtain aligned mapping\n");
        nv_unmap_sg(dev, sg_ptr);
        return -1;
    }

#if defined(NV_NEED_REMAP_CHECK)
    if (sg_ptr->dma_address != virt_to_phys(base))
        nv_remap_count += sg_ptr->length;
#endif

#if !defined(NV_INTEL_IOMMU) && !defined(NVCPU_PPC64LE) && \
  !defined(NV_XEN_SUPPORT_FULLY_VIRTUALIZED_KERNEL)
done:
#endif
    page_list[0]->dma_mapped = NV_TRUE;
    for (i = 1; i < num_pages; i++)
    {
        page_list[i]->sg_list.dma_address = sg_ptr->dma_address + (i * PAGE_SIZE);
    }

    return 0;
}

static inline int nv_sg_load(
    struct scatterlist *sg_ptr,
    nv_pte_t           *page_ptr
)
{
    page_ptr->dma_addr = sg_ptr->dma_address;
    return 0;
}

// make sure we only unmap the page if it was really mapped through the iommu
static inline void nv_sg_unmap_buffer(
    struct pci_dev     *dev,
    struct scatterlist *sg_ptr,
    nv_pte_t           *page_ptr
)
{
    if (page_ptr->dma_mapped)
    {
        nv_unmap_sg(dev, sg_ptr);
        page_ptr->dma_addr = 0;
        page_ptr->dma_mapped = NV_FALSE;
#if defined(NV_NEED_REMAP_CHECK)
        nv_remap_count -= sg_ptr->length;
#endif
    }
}
#endif  /* NV_SG_MAP_BUFFERS */

#if !defined(NV_VMWARE)
/*
 * Cache flushes and TLB invalidation
 *
 * Allocating new pages, we may change their kernel mappings' memory types
 * from cached to UC to avoid cache aliasing. One problem with this is
 * that cache lines may still contain data from these pages and there may
 * be then stale TLB entries.
 *
 * The Linux kernel's strategy for addressing the above has varied since
 * the introduction of change_page_attr(): it has been implicit in the
 * change_page_attr() interface, explicit in the global_flush_tlb()
 * interface and, as of this writing, is implicit again in the interfaces
 * replacing change_page_attr(), i.e. set_pages_*().
 *
 * In theory, any of the above should satisfy the NVIDIA graphics driver's
 * requirements. In practise, none do reliably:
 *
 *  - most Linux 2.6 kernels' implementations of the global_flush_tlb()
 *    interface fail to flush caches on all or some CPUs, for a
 *    variety of reasons.
 *
 * Due to the above, the NVIDIA Linux graphics driver is forced to perform
 * heavy-weight flush/invalidation operations to avoid problems due to
 * stale cache lines and/or TLB entries.
 */

static void nv_flush_cache(void *p)
{
#if defined(NVCPU_X86) || defined(NVCPU_X86_64)
    unsigned long reg0, reg1, reg2;
#endif

    CACHE_FLUSH();

    // flush global TLBs
#if defined(NVCPU_X86)
    asm volatile("movl %%cr4, %0;  \n"
                 "movl %0, %2;     \n"
                 "andl $~0x80, %0; \n"
                 "movl %0, %%cr4;  \n"
                 "movl %%cr3, %1;  \n"
                 "movl %1, %%cr3;  \n"
                 "movl %2, %%cr4;  \n"
                 : "=&r" (reg0), "=&r" (reg1), "=&r" (reg2)
                 : : "memory");
#elif defined(NVCPU_X86_64)
    asm volatile("movq %%cr4, %0;  \n"
                 "movq %0, %2;     \n"
                 "andq $~0x80, %0; \n"
                 "movq %0, %%cr4;  \n"
                 "movq %%cr3, %1;  \n"
                 "movq %1, %%cr3;  \n"
                 "movq %2, %%cr4;  \n"
                 : "=&r" (reg0), "=&r" (reg1), "=&r" (reg2)
                 : : "memory");
#endif
}
#endif

static void nv_flush_caches(void)
{
#if defined(NV_VMWARE) || \
  defined(NV_XEN_SUPPORT_FULLY_VIRTUALIZED_KERNEL) || \
  defined(NV_CONFIG_PREEMPT_RT)
    return;
#else
    nv_execute_on_all_cpus(nv_flush_cache, NULL);
#if (defined(NVCPU_X86) || defined(NVCPU_X86_64)) && \
  defined(NV_CHANGE_PAGE_ATTR_PRESENT)
    global_flush_tlb();
#endif
#endif
}

static unsigned int nv_compute_gfp_mask(
    nv_alloc_t *at
)
{
    unsigned int gfp_mask = NV_GFP_KERNEL;
    struct pci_dev *dev = at->dev;
#if !(defined(CONFIG_X86_UV) && defined(NV_CONFIG_X86_UV))
    NvU64 system_memory_size;

    system_memory_size = (os_get_num_phys_pages() * PAGE_SIZE);
    if (system_memory_size != 0)
    {
#if !defined(NV_GET_NUM_PHYSPAGES_PRESENT)
        if (dev->dma_mask < (system_memory_size - 1))
            gfp_mask = NV_GFP_DMA32;
#else
        if (dev->dma_mask <= (system_memory_size - 1))
            gfp_mask = NV_GFP_DMA32;
#endif
    }
    else if (dev->dma_mask < 0xffffffffffULL)
    {
        gfp_mask = NV_GFP_DMA32;
    }
#endif
#if defined(__GFP_NORETRY)
    gfp_mask |= __GFP_NORETRY;
#endif
#if defined(__GFP_ZERO)
    if (at->flags & NV_ALLOC_TYPE_ZEROED)
        gfp_mask |= __GFP_ZERO;
#endif

    return gfp_mask;
}

RM_STATUS nv_alloc_contig_pages(
    nv_state_t *nv,
    nv_alloc_t *at
)
{
    RM_STATUS status;
    nv_pte_t *page_ptr;
    NvU32 i, j;
    unsigned int gfp_mask;
    unsigned long virt_addr = 0;
    NvU64 phys_addr;
    struct pci_dev *dev = at->dev;
#if defined(NV_SG_MAP_BUFFERS)
    int ret;
#endif

    nv_printf(NV_DBG_MEMINFO,
            "NVRM: VM: %s: %u pages\n", __FUNCTION__, at->num_pages);

    if (IS_VGX_HYPER() && (at->num_pages > 1))
        return RM_ERR_NOT_SUPPORTED;

    at->order = nv_calc_order(at->num_pages * PAGE_SIZE);
    gfp_mask = nv_compute_gfp_mask(at);

    NV_GET_FREE_PAGES(virt_addr, at->order, (gfp_mask | __GFP_COMP));
    if (virt_addr == 0)
    {
        nv_printf(NV_DBG_MEMINFO,
            "NVRM: VM: %s: failed to allocate memory\n", __FUNCTION__);
        return RM_ERR_NO_MEMORY;
    }
#if !defined(__GFP_ZERO) || defined(NV_VMWARE)
    if (at->flags & NV_ALLOC_TYPE_ZEROED)
        memset((void *)virt_addr, 0, (at->num_pages * PAGE_SIZE));
#endif

#if defined(NV_SG_MAP_BUFFERS)
    ret = nv_sg_map_buffer(dev, at->page_table, (void *)virt_addr,
            at->num_pages);
    if (ret != 0)
    {
        if (ret < 0)
        {
            nv_printf(NV_DBG_ERRORS,
                "NVRM: VM: %s: failed to DMA-map memory", __FUNCTION__);
        }
        NV_FREE_PAGES(virt_addr, at->order);
        return RM_ERR_INSUFFICIENT_RESOURCES;
    }
#endif

    for (i = 0; i < at->num_pages; i++, virt_addr += PAGE_SIZE)
    {
        phys_addr = nv_get_kern_phys_address(virt_addr);
        if (phys_addr == 0)
        {
            nv_printf(NV_DBG_ERRORS,
                "NVRM: VM: %s: failed to look up physical address\n",
                __FUNCTION__);
            status = RM_ERR_OPERATING_SYSTEM;
            goto failed;
        }

        page_ptr = at->page_table[i];
        page_ptr->phys_addr = phys_addr;
        page_ptr->page_count = NV_GET_PAGE_COUNT(page_ptr);
        page_ptr->virt_addr = virt_addr;
        page_ptr->dma_addr = NV_GET_DMA_ADDRESS(page_ptr->phys_addr);

        NV_LOCK_PAGE(page_ptr);

#if defined(NV_SG_MAP_BUFFERS)
        nv_sg_load(&page_ptr->sg_list, page_ptr);
#endif

        if (!IS_DMA_ADDRESSABLE(nv, page_ptr->dma_addr))
        {
            nv_printf(NV_DBG_ERRORS,
                "NVRM: VM: %s: DMA address not in addressable range of device "
                "%04x:%02x:%02x (0x%llx, 0x%llx-0x%llx)\n", __FUNCTION__,
                NV_PCI_DOMAIN_NUMBER(dev), NV_PCI_BUS_NUMBER(dev),
                NV_PCI_SLOT_NUMBER(dev), page_ptr->dma_addr,
                nv->dma_addressable_start, nv->dma_addressable_limit);
            /* Make sure we unlock this page as well */
            i++;
            status = RM_ERR_INVALID_ADDRESS;
            goto failed;
        }
    }

    if (!NV_ALLOC_MAPPING_CACHED(at->flags))
    {
        nv_set_contig_memory_type(at->page_table[0],
                                  at->num_pages,
                                  NV_MEMORY_UNCACHED);
    }

    if (!NV_ALLOC_MAPPING_CACHED(at->flags))
        nv_flush_caches();

    return RM_OK;

failed:
    if (i > 0)
    {
        for (j = 0; j < i; j++)
            NV_UNLOCK_PAGE(at->page_table[j]);
    }

    page_ptr = at->page_table[0];
#if defined(NV_SG_MAP_BUFFERS)
    nv_sg_unmap_buffer(dev, &page_ptr->sg_list, page_ptr);
#endif
    NV_FREE_PAGES(page_ptr->virt_addr, at->order);

    return status;
}

void nv_free_contig_pages(
    nv_alloc_t *at
)
{
    nv_pte_t *page_ptr;
    unsigned int i;
#if defined(NV_SG_MAP_BUFFERS)
    struct pci_dev *dev = at->dev;
#endif

    nv_printf(NV_DBG_MEMINFO,
            "NVRM: VM: %s: %u pages\n", __FUNCTION__, at->num_pages);

    if (!NV_ALLOC_MAPPING_CACHED(at->flags))
    {
        nv_set_contig_memory_type(at->page_table[0],
                                  at->num_pages,
                                  NV_MEMORY_WRITEBACK);
    }

    for (i = 0; i < at->num_pages; i++)
    {
        page_ptr = at->page_table[i];

        if (NV_GET_PAGE_COUNT(page_ptr) != page_ptr->page_count)
        {
            static int count = 0;
            if (count++ < NV_MAX_RECURRING_WARNING_MESSAGES)
            {
                nv_printf(NV_DBG_ERRORS,
                    "NVRM: VM: %s: page count != initial page count (%u,%u)\n",
                    __FUNCTION__, NV_GET_PAGE_COUNT(page_ptr),
                    page_ptr->page_count);
            }
        }
        NV_UNLOCK_PAGE(page_ptr);
    }

    if (!NV_ALLOC_MAPPING_CACHED(at->flags))
        nv_flush_caches();

    page_ptr = at->page_table[0];

#if defined(NV_SG_MAP_BUFFERS)
    nv_sg_unmap_buffer(dev, &at->page_table[0]->sg_list, page_ptr);
#endif
    NV_FREE_PAGES(page_ptr->virt_addr, at->order);
}

RM_STATUS nv_alloc_system_pages(
    nv_state_t *nv,
    nv_alloc_t *at
)
{
    RM_STATUS status;
    nv_pte_t *page_ptr;
    NvU32 i, j;
    unsigned int gfp_mask;
    unsigned long virt_addr = 0;
    NvU64 phys_addr;
    struct pci_dev *dev = at->dev;
#if defined(NV_SG_MAP_BUFFERS)
    int ret;
#endif

    nv_printf(NV_DBG_MEMINFO,
            "NVRM: VM: %u: %u pages\n", __FUNCTION__, at->num_pages);

    gfp_mask = nv_compute_gfp_mask(at);

    for (i = 0; i < at->num_pages; i++)
    {
        NV_GET_FREE_PAGES(virt_addr, 0, gfp_mask);
        if (virt_addr == 0)
        {
            nv_printf(NV_DBG_MEMINFO,
                "NVRM: VM: %s: failed to allocate memory\n", __FUNCTION__);
            status = RM_ERR_NO_MEMORY;
            goto failed;
        }
#if !defined(__GFP_ZERO) || defined(NV_VMWARE)
        if (at->flags & NV_ALLOC_TYPE_ZEROED)
            memset((void *)virt_addr, 0, PAGE_SIZE);
#endif

        phys_addr = nv_get_kern_phys_address(virt_addr);
        if (phys_addr == 0)
        {
            nv_printf(NV_DBG_ERRORS,
                "NVRM: VM: %s: failed to look up physical address\n",
                __FUNCTION__);
            NV_FREE_PAGES(virt_addr, 0);
            status = RM_ERR_OPERATING_SYSTEM;
            goto failed;
        }

#if defined(_PAGE_NX)
        if (((_PAGE_NX & pgprot_val(PAGE_KERNEL)) != 0) &&
                (phys_addr < 0x400000))
        {
            nv_printf(NV_DBG_SETUP,
                "NVRM: VM: %s: discarding page @ 0x%llx\n",
                __FUNCTION__, phys_addr);
            --i;
            continue;
        }
#endif

        page_ptr = at->page_table[i];
        page_ptr->phys_addr = phys_addr;
        page_ptr->page_count = NV_GET_PAGE_COUNT(page_ptr);
        page_ptr->virt_addr = virt_addr;
        page_ptr->dma_addr = NV_GET_DMA_ADDRESS(page_ptr->phys_addr);

        NV_LOCK_PAGE(page_ptr);

#if defined(NV_SG_MAP_BUFFERS)
        ret = nv_sg_map_buffer(dev, &at->page_table[i],
                __va(page_ptr->phys_addr), 1);
        if (ret != 0)
        {
            if (ret < 0)
            {
                nv_printf(NV_DBG_ERRORS,
                    "NVRM: VM: %s: failed to DMA-map memory", __FUNCTION__);
            }
            NV_UNLOCK_PAGE(page_ptr);
            NV_FREE_PAGES(virt_addr, 0);
            status = RM_ERR_INSUFFICIENT_RESOURCES;
            goto failed;
        }
        nv_sg_load(&page_ptr->sg_list, page_ptr);
#endif

        if (!IS_DMA_ADDRESSABLE(nv, page_ptr->dma_addr))
        {
            nv_printf(NV_DBG_ERRORS,
                "NVRM: VM: %s: DMA address not in addressable range of device "
                "%04x:%02x:%02x (0x%llx, 0x%llx-0x%llx)\n", __FUNCTION__,
                NV_PCI_DOMAIN_NUMBER(dev), NV_PCI_BUS_NUMBER(dev),
                NV_PCI_SLOT_NUMBER(dev), page_ptr->dma_addr,
                nv->dma_addressable_start, nv->dma_addressable_limit);
            /* Make sure we unmap/unlock/free this page as well */
            i++;
            status = RM_ERR_INVALID_ADDRESS;
            goto failed;
        }
    }

    if (!NV_ALLOC_MAPPING_CACHED(at->flags))
        nv_set_memory_type(at, NV_MEMORY_UNCACHED);

    if (!NV_ALLOC_MAPPING_CACHED(at->flags))
        nv_flush_caches();

    return RM_OK;

failed:
    if (i > 0)
    {
        for (j = 0; j < i; j++)
        {
            page_ptr = at->page_table[j];
#if defined(NV_SG_MAP_BUFFERS)
            nv_sg_unmap_buffer(dev, &page_ptr->sg_list, page_ptr);
#endif
            NV_UNLOCK_PAGE(page_ptr);
            NV_FREE_PAGES(page_ptr->virt_addr, 0);
        }
    }

    return status;
}

void nv_free_system_pages(
    nv_alloc_t *at
)
{
    nv_pte_t *page_ptr;
    unsigned int i;
#if defined(NV_SG_MAP_BUFFERS)
    struct pci_dev *dev = at->dev;
#endif

    nv_printf(NV_DBG_MEMINFO,
            "NVRM: VM: %s: %u pages\n", __FUNCTION__, at->num_pages);

    if (!NV_ALLOC_MAPPING_CACHED(at->flags))
        nv_set_memory_type(at, NV_MEMORY_WRITEBACK);

    for (i = 0; i < at->num_pages; i++)
    {
        page_ptr = at->page_table[i];

#if defined(NV_SG_MAP_BUFFERS)
        nv_sg_unmap_buffer(dev, &page_ptr->sg_list, page_ptr);
#endif
        if (NV_GET_PAGE_COUNT(page_ptr) != page_ptr->page_count)
        {
            static int count = 0;
            if (count++ < NV_MAX_RECURRING_WARNING_MESSAGES)
            {
                nv_printf(NV_DBG_ERRORS,
                    "NVRM: VM: %s: page count != initial page count (%u,%u)\n",
                    __FUNCTION__, NV_GET_PAGE_COUNT(page_ptr),
                    page_ptr->page_count);
            }
        }
        NV_UNLOCK_PAGE(page_ptr);
        NV_FREE_PAGES(page_ptr->virt_addr, 0);
    }

    if (!NV_ALLOC_MAPPING_CACHED(at->flags))
        nv_flush_caches();
}

void *nv_vmap(
    struct page **pages,
    int count,
    pgprot_t prot
)
{
    unsigned long virt_addr = 0;
#if defined(NV_VMAP_PRESENT)
    if (!NV_MAY_SLEEP())
    {
        nv_printf(NV_DBG_ERRORS,
                  "NVRM: %s: can't map %d pages, invalid context!\n",
                  __FUNCTION__, count);
        os_dbg_breakpoint();
        return NULL;
    }

    NV_VMAP_KERNEL(virt_addr, pages, count, prot);
#endif
    return (void *)virt_addr;
}

void nv_vunmap(
    void *address,
    int count
)
{
#if defined(NV_VMAP_PRESENT)
    if (!NV_MAY_SLEEP())
    {
        nv_printf(NV_DBG_ERRORS,
                  "NVRM: %s: can't unmap %d pages at 0x%0llx, "
                  "invalid context!\n", __FUNCTION__, count, address);
        os_dbg_breakpoint();
        return;
    }

    NV_VUNMAP_KERNEL(address, count);
#endif
}
