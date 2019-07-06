/*******************************************************************************
    Copyright (c) 2013, 2014 NVidia Corporation

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
#include "nvidia_uvm_lite_counters.h"

#if defined (DEBUG)
#include "uvm_gpu_ops_tests.h"
#endif

//
// nvidia_uvm_lite_api.c
//
// This file contains code for UVM API calls that are issued via ioctl()
// call.
//

//
// Locking: you must hold a read / write lock on the mmap_sem.
//
static struct vm_area_struct *
find_common_vma(unsigned long long requestedBase,
                unsigned long long length,
                struct file * filp)
{
    struct vm_area_struct *vma = find_vma(current->mm, requestedBase);
    if (vma == NULL)
        return NULL;
    if (vma->vm_file != filp)
        return NULL;
    if (vma->vm_start != requestedBase)
        return NULL;
    if (vma->vm_end - vma->vm_start != PAGE_ALIGN(length))
        return NULL;

    return vma;
}

//
// Locking: you must hold a read / write lock on the mmap_sem.
//
static struct vm_area_struct *
find_uvmlite_vma(unsigned long long requestedBase,
    unsigned long long length,
    struct file *filp)
{
    unsigned long long counterLowestPage =
        UVM_COUNTERS_OFFSET_BASE >> PAGE_SHIFT;
    unsigned long long pageNr = PAGE_ALIGN(length) >> PAGE_SHIFT;
    struct vm_area_struct *vma = find_common_vma(requestedBase, length, filp);

    if (vma == NULL)
        return NULL;
    if ((vma->vm_pgoff << PAGE_SHIFT) != requestedBase)
        return NULL;
    if (vma->vm_pgoff >= counterLowestPage)
        return NULL;
    if (vma->vm_pgoff + pageNr >= counterLowestPage)
        return NULL;

    return vma;
}

//
// Locking: you must hold a read / write lock on the mmap_sem.
//
struct vm_area_struct *
find_counters_vma(unsigned long long requestedBase,
    unsigned long long length,
    struct file *filp)
{
    unsigned long long counterLowestPage =
        UVM_COUNTERS_OFFSET_BASE >> PAGE_SHIFT;
    unsigned long long pageNr = PAGE_ALIGN(length) >> PAGE_SHIFT;
    struct vm_area_struct *vma = find_common_vma(requestedBase, length, filp);

    if (vma == NULL)
        return NULL;
    if (vma->vm_pgoff < counterLowestPage)
        return NULL;
    if (vma->vm_pgoff + pageNr < counterLowestPage)
        return NULL;

    UVM_PANIC_ON(vma->vm_flags & (VM_WRITE|VM_MAYWRITE));

    return vma;
}

RM_STATUS
uvm_api_reserve_va(UVM_RESERVE_VA_PARAMS *pParams, struct file *filp)
{
    UVM_DBG_PRINT_RL("requestedBase: 0x%llx, length: 0x%llx\n",
                     pParams->requestedBase, pParams->length);
    //
    // There is nothing required here yet. The mmap() call in user space handles
    // everything.
    //
    return RM_OK;
}

RM_STATUS
uvm_api_release_va(UVM_RELEASE_VA_PARAMS *pParams, struct file *filp)
{
    UVM_DBG_PRINT_RL("requestedBase: 0x%llx, length: 0x%llx\n",
                     pParams->requestedBase, pParams->length);
    //
    // There is nothing required here yet. The mmap() call in user space handles
    // everything.
    //
    return RM_OK;
}

RM_STATUS
uvm_api_region_commit(UVM_REGION_COMMIT_PARAMS *pParams, struct file *filp)
{
    UvmCommitRecord *pRecord;
    DriverPrivate *pPriv = (DriverPrivate*)filp->private_data;
    struct vm_area_struct *vma;
    RM_STATUS rmStatus = RM_OK;
    //
    // Most of the region commit actions are done in the uvmlite_mmap()
    // callback. This makes UvmRegionCommit look mostly atomic, from user space.
    //
    // However, the following items can only be done here:
    //     1) Check that the GPU is modern enough to be used for UVM-Lite.
    //     2) Assign the streamID that the user requested, to the pRecord.
    //     3) Assign the GPU UUID to the pRecord.
    //     4) Set up a Copy Engine channel.
    //
    UVM_DBG_PRINT_RL("requestedBase: 0x%llx, length: 0x%llx, "
                     "streamId: 0x%llx\n",
                     pParams->requestedBase, pParams->length,
                     pParams->streamId);

    // Item (1): Check that the GPU is modern enough to be used for UVM-Lite:
    if (!uvmlite_is_gpu_kepler_and_above(&pParams->gpuUuid))
    {
        UVM_ERR_PRINT("uvmlite_is_gpu_kepler_and_above reported: false\n");
        return RM_ERR_NOT_SUPPORTED;
    }

    down_write(&current->mm->mmap_sem);

    vma = find_uvmlite_vma(pParams->requestedBase, pParams->length, filp);

    if (!vma)
    {
        up_write(&current->mm->mmap_sem);
        UVM_ERR_PRINT("Failed to find the vma (base: 0x%llx, length: %llu\n",
                      pParams->requestedBase, pParams->length);
        return RM_ERR_UVM_ADDRESS_IN_USE;
    }

    // Items 2, 3 and 4 are done by the uvmlite_update_commit_record routine:
    pRecord = (UvmCommitRecord*)vma->vm_private_data;

    if (!pRecord)
    {
        up_write(&current->mm->mmap_sem);
        UVM_ERR_PRINT("attempted to commit region without a preceding mmap() "
                      "call\n");
        return RM_ERR_OBJECT_NOT_FOUND;
    }

    if ((pRecord->baseAddress != pParams->requestedBase) ||
        (PAGE_ALIGN(pRecord->length) != PAGE_ALIGN(pParams->length)))
    {
        up_write(&current->mm->mmap_sem);
        UVM_ERR_PRINT("attempted to commit region with different VA or length"
                      " than used by preceding mmap\n");
        return RM_ERR_UVM_ADDRESS_IN_USE;
    }

    down_write(&pPriv->uvmPrivLock);
    rmStatus = uvmlite_update_commit_record(pRecord, pParams->streamId,
                                            &pParams->gpuUuid, pPriv);
    if (RM_OK != rmStatus)
    {
        // If update failed, then the pRecord has been deleted, so don't have
        // the vma point to pRecord anymore:
        vma->vm_private_data  = NULL;
        UVM_ERR_PRINT("uvmlite_update_commit_record failed: 0x%0x.\n",
                      rmStatus);
    }

    up_write(&pPriv->uvmPrivLock);
    up_write(&current->mm->mmap_sem);

    return rmStatus;
}

RM_STATUS
uvm_api_region_decommit(UVM_REGION_DECOMMIT_PARAMS *pParams, struct file *filp)
{
    //
    // There is nothing required here yet. The vma.close callback handles
    // everything.
    //
    return RM_OK;
}

RM_STATUS
uvm_api_region_set_stream(UVM_REGION_SET_STREAM_PARAMS *pParams,
                          struct file *filp)
{
    DriverPrivate* pPriv = (DriverPrivate*)filp->private_data;
    RM_STATUS rmStatus;
    struct vm_area_struct * vma;
    UvmCommitRecord * pRecord;

    UVM_DBG_PRINT_RL("requestedBase: 0x%llx, length: 0x%llx, "
                     "newStreamId: 0x%llx\n",
                     pParams->requestedBase, pParams->length,
                     pParams->newStreamId);

    down_write(&current->mm->mmap_sem);

    vma = find_uvmlite_vma(pParams->requestedBase, pParams->length, filp);
    if (vma == NULL)
    {
        up_write(&current->mm->mmap_sem);
        return RM_ERR_UVM_ADDRESS_IN_USE;
    }

    down_write(&pPriv->uvmPrivLock);
    pRecord = (UvmCommitRecord*)vma->vm_private_data;

    rmStatus = uvmlite_region_set_stream(pRecord, pParams->newStreamId);

    up_write(&pPriv->uvmPrivLock);
    up_write(&current->mm->mmap_sem);

    return rmStatus;
}

RM_STATUS
uvm_api_region_set_stream_running(UVM_SET_STREAM_RUNNING_PARAMS *pParams,
                                  struct file *filp)
{
    DriverPrivate* pPriv = (DriverPrivate*)filp->private_data;
    RM_STATUS rmStatus;

    UVM_DBG_PRINT_RL("streamID: 0x%llx\n", pParams->streamId);

    down_write(&current->mm->mmap_sem);
    down_write(&pPriv->uvmPrivLock);
    rmStatus = uvmlite_set_stream_running(pPriv, pParams->streamId);
    up_write(&pPriv->uvmPrivLock);
    up_write(&current->mm->mmap_sem);

    return rmStatus;
}

RM_STATUS
uvm_api_region_set_stream_stopped(UVM_SET_STREAM_STOPPED_PARAMS *pParams,
                                  struct file *filp)
{
    DriverPrivate *pPriv = (DriverPrivate*)filp->private_data;
    RM_STATUS rmStatus;

    if (pParams->nStreams > UVM_MAX_STREAMS_PER_IOCTL_CALL)
        return RM_ERR_INVALID_ARGUMENT;

    if (pParams->nStreams > 0)
    {
        UVM_DBG_PRINT_RL("streamIDs 0x%llx - 0x%llx\n",
                         pParams->streamIdArray[0],
                         pParams->streamIdArray[pParams->nStreams - 1]);
    }

    down_write(&current->mm->mmap_sem);
    down_write(&pPriv->uvmPrivLock);
    rmStatus = uvmlite_set_streams_stopped(pPriv, pParams->streamIdArray,
                                           pParams->nStreams);
    up_write(&pPriv->uvmPrivLock);
    up_write(&current->mm->mmap_sem);
    return rmStatus;
}

RM_STATUS
uvm_api_migrate_to_gpu(UVM_MIGRATE_TO_GPU_PARAMS *pParams, struct file *filp)
{
    DriverPrivate *pPriv = (DriverPrivate*)filp->private_data;
    RM_STATUS rmStatus;
    struct vm_area_struct *vma;
    UvmCommitRecord *pRecord;

    UVM_DBG_PRINT_RL("requestedBase: 0x%llx, length: 0x%llx, "
                     "flags: 0x%x\n",
                     pParams->requestedBase, pParams->length, pParams->flags);

    down_write(&current->mm->mmap_sem);

    vma = find_uvmlite_vma(pParams->requestedBase, pParams->length, filp);
    if (vma == NULL)
    {
        up_write(&current->mm->mmap_sem);
        return RM_ERR_UVM_ADDRESS_IN_USE;
    }

    down_write(&pPriv->uvmPrivLock);
    pRecord = (UvmCommitRecord*)vma->vm_private_data;

    rmStatus = uvmlite_migrate_to_gpu(pParams->requestedBase,
                                       pParams->length,
                                       pParams->flags,
                                       vma,
                                       pRecord);
    up_write(&pPriv->uvmPrivLock);
    up_write(&current->mm->mmap_sem);

    return rmStatus;
}

#if defined(DEBUG)
RM_STATUS
uvm_api_run_test(UVM_RUN_TEST_PARAMS *pParams, struct file *filp)
{
    switch (pParams->testNumber)
    {
        case UVM_GPU_OPS_SAMPLE_TEST:
            gpuOpsSampleTest(&pParams->gpuUuid);
            break;
        case UVM_PAGE_MIGRATION_TEST:
            pageMigrationTest(&pParams->gpuUuid);
            UVM_DBG_PRINT_UUID("Entering", &pParams->gpuUuid);
            break;
        default:
            UVM_INFO_PRINT("bad test number: 0x%x\n", pParams->testNumber);
            return RM_ERR_INVALID_ARGUMENT;
    }

    return RM_OK;
}
#endif

RM_STATUS
uvm_api_add_session(UVM_ADD_SESSION_PARAMS *pParams, struct file *filp)
{
    RM_STATUS rmStatus;
    DriverPrivate *pPriv = (DriverPrivate*)filp->private_data;
    UvmProcessCounterInfo *pProcessCounterInfo = NULL;
    uid_t euid = UVM_ROOT_UID;
    struct vm_area_struct *vma;
    unsigned long countersBaseAddress = 
        (unsigned long) pParams->countersBaseAddress;

    rmStatus = uvmlite_secure_get_process_counter_info(pParams->pidTarget,
                                                       &pProcessCounterInfo,
                                                       &euid);
    if (rmStatus != RM_OK)
        return rmStatus;

    rmStatus = uvm_add_session_info(pParams->pidTarget, euid,
                                    &pParams->sessionIndex,
                                    pProcessCounterInfo,
                                    countersBaseAddress,
                                    &pPriv->processRecord);

    if (rmStatus != RM_OK)
    {
        uvmlite_put_and_unrefcount_process_counter_info(pProcessCounterInfo);
        return rmStatus;
    }

    down_write(&current->mm->mmap_sem);
    rmStatus = RM_ERR_INVALID_ARGUMENT; 
    vma = find_counters_vma((unsigned long long) countersBaseAddress, 
                            UVM_MAX_GPUS * UVM_PER_RESOURCE_COUNTERS_SIZE +
                            UVM_PER_PROCESS_PER_GPU_COUNTERS_SHIFT, filp);

    if (vma != NULL)
    {
        unsigned long currentUserBaseAddress;
        struct page *pPage;

        currentUserBaseAddress = countersBaseAddress;
        pPage = pProcessCounterInfo->procAllGpuCounter.pCounterPage;
        rmStatus = uvm_map_page(vma, pPage, currentUserBaseAddress);
        currentUserBaseAddress += UVM_PER_PROCESS_PER_GPU_COUNTERS_SHIFT;
        if (rmStatus == RM_OK)
        {
            unsigned i;

            for (i = 0; i < UVM_MAX_GPUS; ++i)
            {
                pPage = pProcessCounterInfo->procSingleGpuCounterArray[i].
                                                                pCounterPage;
                rmStatus = uvm_map_page(vma, pPage, currentUserBaseAddress);
                currentUserBaseAddress += UVM_PER_RESOURCE_COUNTERS_SIZE;
                if (rmStatus != RM_OK)
                    break;
            }
        }
    }

    up_write(&current->mm->mmap_sem);

    // 
    // We can not reverse uvm_map_page, so inserted pages will stay
    // until vma teardown. This means that if we  call mmap (success) 
    // and AddSession (fail), we need to unmap previous address and 
    // call mmap again.
    //
    if (rmStatus != RM_OK)
        uvm_remove_session_info(pParams->sessionIndex, &pPriv->processRecord);

    return rmStatus;
}

RM_STATUS
uvm_api_remove_session(UVM_REMOVE_SESSION_PARAMS *pParams, struct file *filp)
{
    RM_STATUS rmStatus;
    DriverPrivate *pPriv = (DriverPrivate*)filp->private_data;

    rmStatus = uvm_remove_session_info(pParams->sessionIndex,
                                       &pPriv->processRecord);
    return rmStatus;
}

RM_STATUS
uvm_api_enable_counters(UVM_ENABLE_COUNTERS_PARAMS *pParams, struct file *filp)
{
    RM_STATUS rmStatus;
    DriverPrivate *pPriv = (DriverPrivate*)filp->private_data;
    UvmProcessRecord *pProcessRecord;
    UvmSessionInfo *pSessionInfo;
    pProcessRecord = &pPriv->processRecord;

    down_read(&pProcessRecord->sessionInfoLock);

    rmStatus = uvm_get_session_info(pParams->sessionIndex, pProcessRecord,
                                    &pSessionInfo);

    if (rmStatus == RM_OK)
    {
        rmStatus = uvm_counter_state_atomic_update(pSessionInfo,
                                                   pParams->config,
                                                   pParams->count);
    }

    up_read(&pProcessRecord->sessionInfoLock);
    return rmStatus;
}

RM_STATUS
uvm_api_map_counter(UVM_MAP_COUNTER_PARAMS *pParams, struct file *filp)
{
    RM_STATUS rmStatus;
    DriverPrivate *pPriv = (DriverPrivate*)filp->private_data;
    UvmProcessRecord *pProcessRecord;
    UvmSessionInfo *pSessionInfo;
    pProcessRecord = &pPriv->processRecord;

    down_read(&pProcessRecord->sessionInfoLock);

    rmStatus = uvm_get_session_info(pParams->sessionIndex, pProcessRecord,
                                    &pSessionInfo);
    if (rmStatus == RM_OK)
    {
        rmStatus = uvm_map_counter(pSessionInfo,
                                   pParams->scope,
                                   pParams->counterName,
                                   &pParams->gpuUuid,
                                   (NvUPtr*)&pParams->addr);
    }

    up_read(&pProcessRecord->sessionInfoLock);
    return rmStatus;
}
