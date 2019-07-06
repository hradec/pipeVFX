/* _NVRM_COPYRIGHT_BEGIN_
 *
 * Copyright 2001 by NVIDIA Corporation.  All rights reserved.  All
 * information contained herein is proprietary and confidential to NVIDIA
 * Corporation.  Any use, reproduction, or disclosure without the written
 * permission of NVIDIA Corporation is prohibited.
 *
 * _NVRM_COPYRIGHT_END_
 */

#ifndef _NVMEMDBG_H_
#define _NVMEMDBG_H_

// this code is intended to be self-sufficient and easily added in anywhere
// originally, it was in core resman and used os_alloc_mem for some experiments
// at tracking memory usage at a higher level. I then switched to adding it to
// the open source code and tracking memory at a lower level. It could also
// be included and used again at the higher level, but would need to use the
// abtracted memory allocation interfaces (such as osAllocMem & osFreeMem).

struct mem_track_t {
    void *addr;
    NvU32 size;
    NvU8 *file;
    NvU32 line;
    struct mem_track_t *next;
};


static inline void
nv_add_mem(
    struct mem_track_t **mem_list,
    void *addr,
    NvU32 size,
    NvU8 *file,
    NvU32 line
)
{
    struct mem_track_t *tmp = NULL;

    MEMDBG_ALLOC(tmp, sizeof(struct mem_track_t));
    if (tmp == NULL)
        return;

    tmp->addr = addr;
    tmp->size = size;
    tmp->file = file;
    tmp->line = line;

    tmp->next = *mem_list;
    *mem_list = tmp;
}

static inline void
nv_free_mem(
    struct mem_track_t **mem_list,
    void *addr,
    NvU32 size,
    NvU8 *file,
    NvU32 line
)
{
    struct mem_track_t *tmp, *prev;

    tmp = prev = *mem_list;
    while (tmp)
    {
        if (tmp->addr == addr)
        {
            if (tmp == prev)
                *mem_list = tmp->next;
            else
                prev->next = tmp->next;

            if (tmp->size != size)
            {
                nv_printf(NV_DBG_ERRORS,
                    "NVRM: size mismatch on free: 0x%x != 0x%x\n", size, tmp->size);
                nv_printf(NV_DBG_ERRORS,
                    "NVRM:     allocation: 0x%p @ %s:%d\n", tmp->addr, tmp->file,
                    tmp->line);
                os_dbg_breakpoint();
            }

            MEMDBG_FREE(tmp);
            return;
        }
        prev = tmp;
        tmp = tmp->next;
    }
}

static inline void
nv_list_mem(
    const NvU8 *type,
    struct mem_track_t *mem_list
)
{
    struct mem_track_t *tmp;
    BOOL print_summary = FALSE;
    NvU32 count = 0;

    if (mem_list != NULL)
    {
        nv_printf(NV_DBG_ERRORS,
            "NVRM: list of %s memory allocations:\n", type);
        print_summary = TRUE;
    }
    tmp = mem_list;
    while (tmp)
    {
        nv_printf(NV_DBG_ERRORS,
            "NVRM:    0x%x bytes, 0x%p @ %s:%d\n", tmp->size, tmp->addr,
            tmp->file, tmp->line);
        count += tmp->size;
        tmp = tmp->next;
    }
    if (print_summary)
    {
        nv_printf(NV_DBG_ERRORS,
            "NVRM:  total amount allocated: 0x%x bytes\n", count);
    }
}

#endif /* _NVMEMDBG_H_ */
