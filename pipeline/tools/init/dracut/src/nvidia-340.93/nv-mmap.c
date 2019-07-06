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

extern nv_cpu_type_t nv_cpu_type;

/*
 * The 'struct vm_operations' open() callback is called by the Linux
 * kernel when the parent VMA is split or copied, close() when the
 * current VMA is about to be deleted.
 *
 * We implement these callbacks to keep track of the number of user
 * mappings of system memory allocations. This was motivated by a
 * subtle interaction problem between the driver and the kernel with
 * respect to the bookkeeping of pages marked reserved and later
 * mapped with mmap().
 *
 * Traditionally, the Linux kernel ignored reserved pages, such that
 * when they were mapped via mmap(), the integrity of their usage
 * counts depended on the reserved bit being set for as long as user
 * mappings existed.
 *
 * Since we mark system memory pages allocated for DMA reserved and
 * typically map them with mmap(), we need to ensure they remain
 * reserved until the last mapping has been torn down. This worked
 * correctly in most cases, but in a few, the RM API called into the
 * RM to free memory before calling munmap() to unmap it.
 *
 * In the past, we allowed nv_free_pages() to remove the 'at' from
 * the parent device's allocation list in this case, but didn't
 * release the underlying pages until the last user mapping had been
 * destroyed:
 *
 * In nvidia_vma_release(), we freed any resources associated with
 * the allocation (IOMMU mappings, etc.) and cleared the
 * underlying pages' reserved bits, but didn't free them. The kernel
 * was expected to do this.
 *
 * This worked in practise, but made dangerous assumptions about the
 * kernel's behavior and could fail in some cases. We now handle
 * this case differently (see below).
 */
static void
nvidia_vma_open(struct vm_area_struct *vma)
{
    nv_alloc_t *at = NV_VMA_PRIVATE(vma);

    NV_PRINT_VMA(NV_DBG_MEMINFO, vma);

    if (at != NULL)
    {
        NV_ATOMIC_INC(at->usage_count);

        NV_PRINT_AT(NV_DBG_MEMINFO, at);
    }
}

/*
 * (see above for additional information)
 *
 * If the 'at' usage count drops to zero with the updated logic, the
 * the allocation is recorded in the free list of the private
 * data associated with the file pointer; nvidia_close() uses this
 * list to perform deferred free operations when the parent file
 * descriptor is closed. This will typically happen when the process
 * exits.
 *
 * Since this is technically a workaround to handle possible fallout
 * from misbehaving clients, we addtionally print a warning.
 */
static void
nvidia_vma_release(struct vm_area_struct *vma)
{
    nv_alloc_t *at = NV_VMA_PRIVATE(vma);
    static int count = 0;
    nv_file_private_t *nvfp;

    NV_PRINT_VMA(NV_DBG_MEMINFO, vma);

    if (at != NULL)
    {
        NV_PRINT_AT(NV_DBG_MEMINFO, at);

        if (NV_ATOMIC_DEC_AND_TEST(at->usage_count))
        {
            if ((at->pid == os_get_current_process()) &&
                (count++ < NV_MAX_RECURRING_WARNING_MESSAGES))
            {
                nv_printf(NV_DBG_MEMINFO,
                    "NVRM: VM: %s: late unmap, comm: %s, 0x%p\n",
                    __FUNCTION__, current->comm, at);
            }

            NV_ATOMIC_INC(at->usage_count);

            nvfp = NV_GET_FILE_PRIVATE(NV_VMA_FILE(vma));
            at->next = nvfp->free_list;
            nvfp->free_list = at;
        }
    }
}

#if !defined(NV_VM_INSERT_PAGE_PRESENT)
static
struct page *nvidia_vma_nopage(
    struct vm_area_struct *vma,
    unsigned long address,
    int *type
)
{
    struct page *page;

    page = pfn_to_page(vma->vm_pgoff);
    get_page(page);

    return page;
}
#endif

struct vm_operations_struct nv_vm_ops = {
    .open   = nvidia_vma_open,
    .close  = nvidia_vma_release,
#if !defined(NV_VM_INSERT_PAGE_PRESENT)
    .nopage = nvidia_vma_nopage,
#endif
};

int nv_encode_caching(
    pgprot_t *prot,
    NvU32     cache_type,
    NvU32     memory_type
)
{
    pgprot_t tmp;

    if (prot == NULL)
    {
        tmp = __pgprot(0);
        prot = &tmp;
    }

    switch (cache_type)
    {
        case NV_MEMORY_UNCACHED_WEAK:
#if defined(NV_PGPROT_UNCACHED_WEAK)
            *prot = NV_PGPROT_UNCACHED_WEAK(*prot);
            break;
#endif
        case NV_MEMORY_UNCACHED:
            /*!
             * On Tegra 3 (A9), we cannot have the device type bits set on
             * any BAR mappings.
             */
            *prot = ((memory_type == NV_MEMORY_TYPE_SYSTEM) ||
                (nv_cpu_type == NV_CPU_TYPE_ARM_A9)) ?
                    NV_PGPROT_UNCACHED(*prot) :
                    NV_PGPROT_UNCACHED_DEVICE(*prot);
            break;
#if defined(NV_PGPROT_WRITE_COMBINED) && \
    defined(NV_PGPROT_WRITE_COMBINED_DEVICE)
        case NV_MEMORY_WRITECOMBINED:
            if (NV_ALLOW_WRITE_COMBINING(memory_type))
            {
                /*!
                 * On Tegra 3 (A9), we cannot have the device type bits set on
                 * any BAR mappings.
                 */
                *prot = ((memory_type == NV_MEMORY_TYPE_FRAMEBUFFER) &&
                    (nv_cpu_type != NV_CPU_TYPE_ARM_A9)) ?
                        NV_PGPROT_WRITE_COMBINED_DEVICE(*prot) :
                        NV_PGPROT_WRITE_COMBINED(*prot);
                break;
            }

            /*
             * If WC support is unavailable, we need to return an error
             * code to the caller, but need not print a warning.
             *
             * For frame buffer memory, callers are expected to use the
             * UC- memory type if we report WC as unsupported, which
             * translates to the effective memory type WC if a WC MTRR
             * exists or else UC.
             */
            return 1;
#endif
        case NV_MEMORY_CACHED:
            if (NV_ALLOW_CACHING(memory_type))
                break;
        default:
            nv_printf(NV_DBG_ERRORS,
                "NVRM: VM: cache type %d not supported for memory type %d!\n",
                cache_type, memory_type);
            return 1;
    }
    return 0;
}

int nvidia_mmap(
    struct file *file,
    struct vm_area_struct *vma
)
{
    unsigned int pages;
    nv_alloc_t *at;
    nv_linux_state_t *nvl = NV_GET_NVL_FROM_FILEP(file);
    nv_state_t *nv = NV_STATE_PTR(nvl);
    nv_file_private_t *nvfp = NV_GET_FILE_PRIVATE(file);
    RM_STATUS rmStatus;
    int status = 0;
    nv_stack_t *sp = NULL;
    unsigned long start = 0;
    NvU64 j, pageIndex;
    NvU32 prot;
    NvU64 access_start = NV_VMA_OFFSET(vma);
    NvU64 access_len = NV_VMA_SIZE(vma);
    NvU64 mmap_start = access_start;
    NvU64 mmap_len = access_len;

    NV_PRINT_VMA(NV_DBG_MEMINFO, vma);

    down(&nvfp->fops_sp_lock[NV_FOPS_STACK_INDEX_MMAP]);
    sp = nvfp->fops_sp[NV_FOPS_STACK_INDEX_MMAP];

    NV_CHECK_PCI_CONFIG_SPACE(sp, nv, TRUE, TRUE, NV_MAY_SLEEP());

    pages = NV_VMA_SIZE(vma) >> PAGE_SHIFT;
    NV_VMA_PRIVATE(vma) = NULL;

    if ((nv->flags & NV_FLAG_CONTROL) == 0)
    {
        NvU32 remap_prot_extra = 0;

#if defined(NV_4K_PAGE_ISOLATION_PRESENT)
        nv_mmap_isolation_t *nvmi = NULL;
        rmStatus = rm_extract_mmap_context(sp, nv, (NvP64)((void *)mmap_start),
                mmap_len, (void **)&nvmi);
        if (rmStatus == RM_OK && nvmi != NULL)
        {
            /*
             * Do verification and cache encoding based on the original
             * (ostensibly smaller) mmap request, since accesses should be
             * restricted to that range.
             */
            access_start = (NvU64)nvmi->access_start;
            access_len = nvmi->access_len;
            mmap_start = (NvU64)nvmi->mmap_start;
            mmap_len = nvmi->mmap_len;
            remap_prot_extra = NV_PROT_4K_PAGE_ISOLATION;
            os_free_mem((void *)nvmi);
        }
#endif

        rmStatus = rm_validate_mmap_request(sp, nv, nvfp,
                access_start, access_len, &prot, NULL, NULL);
        if (rmStatus != RM_OK)
        {
            status = -EINVAL;
            goto done;
        }

        if (IS_REG_OFFSET(nv, access_start, access_len))
        {
            if (nv_encode_caching(&vma->vm_page_prot, NV_MEMORY_UNCACHED,
                        NV_MEMORY_TYPE_REGISTERS))
            {
                status = -ENXIO;
                goto done;
            }
        }
        else if (IS_FB_OFFSET(nv, access_start, access_len))
        {
            if (IS_UD_OFFSET(nv, access_start, access_len))
            {
                if (nv_encode_caching(&vma->vm_page_prot, NV_MEMORY_UNCACHED,
                            NV_MEMORY_TYPE_FRAMEBUFFER))
                {
                    status = -ENXIO;
                    goto done;
                }
            }
            else
            {
                if (nv_encode_caching(&vma->vm_page_prot,
                        NV_MEMORY_WRITECOMBINED, NV_MEMORY_TYPE_FRAMEBUFFER))
                {
                    if (nv_encode_caching(&vma->vm_page_prot,
                            NV_MEMORY_UNCACHED_WEAK, NV_MEMORY_TYPE_FRAMEBUFFER))
                    {
                        status = -ENXIO;
                        goto done;
                    }
                }
            }
        }

        if (nv_io_remap_page_range(vma, mmap_start, mmap_len,
                remap_prot_extra) != 0)
        {
            status = -EAGAIN;
            goto done;
        }

        vma->vm_flags |= VM_IO;
    }
    else
    {
        rmStatus = rm_acquire_api_lock(sp);
        if (rmStatus != RM_OK)
        {
            status = -EAGAIN;
            goto done;
        }

        rmStatus = rm_validate_mmap_request(sp, nv, nvfp,
                access_start, access_len, &prot, (void **)&at,
                &pageIndex);
        if (rmStatus != RM_OK)
        {
            status = -EINVAL;
            goto unlock;
        }

        if (nv_encode_caching(&vma->vm_page_prot,
                              NV_ALLOC_MAPPING(at->flags),
                              NV_MEMORY_TYPE_SYSTEM))
        {
            status = -ENXIO;
            goto unlock;
        }

        NV_VMA_PRIVATE(vma) = at;
        NV_ATOMIC_INC(at->usage_count);

        start = vma->vm_start;
        for (j = pageIndex; j < (pageIndex + pages); j++)
        {
#if defined(NV_VM_INSERT_PAGE_PRESENT)
            if (NV_VM_INSERT_PAGE(vma, start,
                    NV_GET_PAGE_STRUCT(at->page_table[j]->phys_addr)))
#else
            if (nv_remap_page_range(vma, start, at->page_table[j]->phys_addr,
                    PAGE_SIZE, vma->vm_page_prot) != 0)
#endif
            {
                NV_ATOMIC_DEC(at->usage_count);
                status = -EAGAIN;
                goto unlock;
            }
            start += PAGE_SIZE;
        }

        NV_PRINT_AT(NV_DBG_MEMINFO, at);

        vma->vm_flags |= (VM_IO | VM_LOCKED | VM_RESERVED);
        vma->vm_flags |= (VM_DONTEXPAND | VM_DONTDUMP);
    }

    if (status == 0)
    {
        NV_VMA_FILE(vma) = file;

        if ((prot & NV_PROTECT_WRITEABLE) == 0)
        {
            vma->vm_page_prot = NV_PGPROT_READ_ONLY(vma->vm_page_prot);
            vma->vm_flags &= ~VM_WRITE;
            vma->vm_flags &= ~VM_MAYWRITE;
        }

        vma->vm_ops = &nv_vm_ops;
    }

unlock:
    if ((nv->flags & NV_FLAG_CONTROL) != 0)
        rm_release_api_lock(sp);

done:
    up(&nvfp->fops_sp_lock[NV_FOPS_STACK_INDEX_MMAP]);
    return status;
}
