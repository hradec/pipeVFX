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
#include "uvm_linux_ioctl.h"
#include "nvidia_uvm_common.h"
#include "nvidia_page_migration.h"
#include "nvidia_uvm_utils.h"
#include "nvidia_uvm_lite.h"
#include "nvidia_uvm_lite_counters.h"
#include "ctrl2080mc.h"

//
// nvidia_uvm_lite.c
// This file contains code that is specific to the UVM-Lite mode of operation.
//

#ifndef NVIDIA_UVM_LITE_ENABLED
#error "Building uvmlite code without NVIDIA_UVM_LITE_ENABLED!"
#endif
#ifndef NVIDIA_UVM_RM_ENABLED
#error "Building uvmlite code without RM enabled!"
#endif


static struct cdev g_uvmlite_cdev;

// table of attached GUIDS
static UvmGpuState g_attached_uuid_list[UVM_MAX_GPUS];
static unsigned g_attached_uuid_num;
static struct rw_semaphore g_attached_uuid_lock;

//
// Locking acquisition order (only take the locks you need, but always follow
// this order):
//
//      1. mm->mmap_sem
//
//      2. g_uvmDriverPrivateTableLock
//
//      3. DriverPrivate.uvmPrivLock
//
//      4. sessionInfoLock
//
//      5. g_attached_uuid_lock
//
static struct kmem_cache * g_uvmPrivateCache              __read_mostly = NULL;
static struct kmem_cache * g_uvmCommitRecordCache         __read_mostly = NULL;
static struct kmem_cache * g_uvmMigTrackerCache           __read_mostly = NULL;
static struct kmem_cache * g_uvmProcessCounterInfoCache   __read_mostly = NULL;
static struct kmem_cache * g_uvmStreamRecordCache         __read_mostly = NULL;
static struct kmem_cache * g_uvmMappingCache              __read_mostly = NULL;

static struct rw_semaphore g_uvmDriverPrivateTableLock;
//
// Root of global driver private list
// This list contains DriverPrivate pointers,
// which are valid as long, as you are holding
// r/w g_uvmDriverPrivateTableLock
//
static LIST_HEAD(g_uvmDriverPrivateTable);

// uvm kernel privileged region
static NvU64 g_uvmKernelPrivRegionStart;
static NvU64 g_uvmKernelPrivRegionLength;

static void _mmap_close(struct vm_area_struct *vma);
static void _mmap_open(struct vm_area_struct *vma);
static void _destroy_migration_resources(UvmGpuMigrationTracking *pMigTracking);
static RM_STATUS _create_migration_resources(UvmGpuUuid * pGpuUuidStruct,
                                        UvmGpuMigrationTracking *pMigTracking);
static void _set_vma_inaccessible(struct vm_area_struct * vma);
static void _set_vma_accessible(struct vm_area_struct * vma);
static void _destroy_record(UvmCommitRecord *pRecord);
static void _set_record_accessible(UvmCommitRecord *pRecord);
static void _set_record_inaccessible(UvmCommitRecord *pRecord);
static int _is_record_matching_vma(UvmCommitRecord *pRecord);
static void _record_detach_from_stream(UvmCommitRecord *pRecord);
static RM_STATUS _record_attach_to_stream(UvmCommitRecord *pRecord,
    UvmStreamRecord *pNewStream);

static UvmStreamRecord * _stream_alloc(UvmProcessRecord *processRecord,
    UvmStream streamId);
static UvmStreamRecord * _stream_find_in_cache(UvmProcessRecord *processRecord,
    UvmStream streamId);
static UvmStreamRecord * _stream_find_in_list(UvmProcessRecord *processRecord,
    UvmStream streamId);
static UvmStreamRecord * _stream_find(UvmProcessRecord *processRecord,
    UvmStream streamId);
static UvmStreamRecord * _stream_find_or_alloc(UvmProcessRecord *processRecord,
    UvmStream streamId);
static RM_STATUS _find_or_add_gpu_index(UvmGpuUuid *gpuUuidStruct, 
                                         unsigned *pIndex);
static unsigned _find_gpu_index(UvmGpuUuid *gpuUuidStruct);
static void _stream_destroy(UvmStreamRecord *pStream);
static void _stream_destroy_if_empty(UvmStreamRecord *pStream);
static void _stream_remove_from_cache(UvmStreamRecord *pStream);
static void _stream_save_in_cache(UvmStreamRecord *pStream);
static RM_STATUS _wait_for_migration_completion(UvmGpuMigrationTracking *pMigTracker,
                                                 UvmCommitRecord *pRecord,
                                                 UvmGpuPointer pageVirtualAddr,
                                                 UvmGpuPointer cpuPhysAddr,
                                                 char ** cpuPbPointer,
                                                 char * cpuPbEnd,
                                                 NvLength * numMethods);
static RM_STATUS _clear_cache_update_counters(UvmCommitRecord *pRecord,
                                              unsigned long long migratedPages);
static
RM_STATUS _preexisting_error_on_channel(UvmGpuMigrationTracking *pMigTracker,
                                         UvmCommitRecord *pRecord);

static void _set_timeout_in_usec(struct timeval *src,
                                 struct timeval *result,
                                 unsigned long timeoutInUsec)
{
    if (!src || !result)
        return;

    result->tv_sec = src->tv_sec;
    result->tv_usec = src->tv_usec + timeoutInUsec;
    if (result->tv_usec >= 1000000)
    {
        ++result->tv_sec;
        result->tv_usec -= 1000000;
    }
}

//
// Currently the driver refuses to work with vmas that have been modified
// since the original mmap() call. Mark them as inaccessible.
//
// Locking: this is called with mmap_sem for write
//
static void _mmap_open(struct vm_area_struct *vma)
{
    UvmCommitRecord *pRecord = (UvmCommitRecord*)vma->vm_private_data;

    UVM_DBG_PRINT_RL("vma 0x%p [0x%p, 0x%p) record %p\n",
                     vma, (void*)vma->vm_start, (void*)vma->vm_end, pRecord);

    //
    // The vma that was originally created is being modified.
    // Mark the cloned vma as inaccessible and reset its private data to make
    // sure the same commit record is not referenced by multiple vmas.
    //
    _set_vma_inaccessible(vma);
    vma->vm_private_data = NULL;

    if (pRecord)
    {
        DriverPrivate *pDriverPriv = pRecord->osPrivate;

        // mmap_open should never be called for the original vma
        UVM_PANIC_ON(pRecord->vma == vma);

        // Set the original vma as inaccessible
        _set_vma_inaccessible(pRecord->vma);

        // Destroy the commit record attached to the original vma
        down_write(&pDriverPriv->uvmPrivLock);
        _destroy_record(pRecord);
        up_write(&pDriverPriv->uvmPrivLock);
    }
}

static void _stream_destroy(UvmStreamRecord *pStream)
{
    if (pStream == NULL)
        return;

    UVM_DBG_PRINT_RL("stream %lld\n", pStream->streamId);

    // Stream should be stopped
    UVM_PANIC_ON(pStream->isRunning);

    // Stream should be empty
    UVM_PANIC_ON(!list_empty(&pStream->commitRecordsList));

    list_del(&pStream->allStreamListNode);
    _stream_remove_from_cache(pStream);

    kmem_cache_free(g_uvmStreamRecordCache, pStream);
}

void _stop_and_destroy_leftover_streams(UvmProcessRecord *processRecord)
{
    struct list_head *pos;
    struct list_head *safepos;
    UvmStreamRecord *pStream = NULL;

    list_for_each_safe(pos, safepos, &processRecord->allStreamList)
    {
        pStream = list_entry(pos, UvmStreamRecord, allStreamListNode);
        pStream->isRunning = NV_FALSE;
        _stream_destroy(pStream);
    }
}

//
// Locking: you must hold a write lock on the DriverPrivate.uvmPrivLock
// and mmap_sem, before calling this routine.
//
static void _destroy_record(UvmCommitRecord *pRecord)
{
    NvLength pageIdx;
    NvLength nPages;

    if (NULL == pRecord)
        return;

    nPages = (PAGE_ALIGN(pRecord->length)) >> PAGE_SHIFT;
    UVM_DBG_PRINT_RL("nPages: %llu\n", nPages);

    for (pageIdx = 0; pageIdx < nPages; ++pageIdx)
    {
        uvm_page_cache_free_page(pRecord->commitRecordPages[pageIdx],
                                 __FUNCTION__);
    }

    vfree(pRecord->commitRecordPages);
    pRecord->commitRecordPages = NULL;

    _record_detach_from_stream(pRecord);

    if (pRecord->vma)
    {
        // Detach the record from the vma
        pRecord->vma->vm_private_data = NULL;
        pRecord->vma = NULL;
    }

    kmem_cache_free(g_uvmCommitRecordCache, pRecord);
}

static void _mmap_close(struct vm_area_struct *vma)
{
    UvmCommitRecord *pRecord = (UvmCommitRecord*)vma->vm_private_data;

    UVM_DBG_PRINT_RL("vma 0x%p [0x%p, 0x%p) record 0x%p\n",
                     vma, (void*)vma->vm_start, (void*)vma->vm_end, pRecord);

    if (pRecord)
    {
        DriverPrivate *pDriverPriv = pRecord->osPrivate;

        //
        // This should never happen as the vm_private_data is reset
        // in mmap_open().
        //
        UVM_PANIC_ON(pRecord->vma != vma);

        down_write(&pDriverPriv->uvmPrivLock);
        _destroy_record(pRecord);
        up_write(&pDriverPriv->uvmPrivLock);
    }
}

//
// Locking: you must hold a write lock on the DriverPrivate.uvmPrivLock, before
// calling this routine.
//
static void _disconnect_mig_completely(UvmPerProcessGpuMigs * pMig,
                                       UvmCommitRecord * pRecord)
{
    memset(pMig, 0, sizeof(*pMig));

    if (pRecord != NULL)
        pRecord->cachedHomeGpuPerProcessIndex = UVM_INVALID_HOME_GPU_INDEX;
}

static void
_delete_all_session_info_table_entries(UvmProcessRecord *pProcessRecord)
{
    int i;

    down_write(&pProcessRecord->sessionInfoLock);

    for (i = 0; i < UVM_MAX_SESSIONS_PER_PROCESS; ++i)
    {
        if (pProcessRecord->sessionInfoArray[i].pidSessionOwner != 
            UVM_PID_INIT_VALUE)
        {
            UvmSessionInfo *pSessionInfo = &pProcessRecord->sessionInfoArray[i];
            //
            // Free counter information if this is the only process using it.
            // This would happen if the target process has exited.
            //
            uvmlite_put_and_unrefcount_process_counter_info(
                pSessionInfo->pTargetCounterInfo);

            uvm_init_session_info(pSessionInfo);
        }
    }

    up_write(&pProcessRecord->sessionInfoLock);
}

//
// Locking: you must hold a write lock on the DriverPrivate.uvmPrivLock, before
// calling this routine.
//
static void
_delete_all_migration_resources(DriverPrivate* pPriv)
{
    int index;
    UvmPerProcessGpuMigs * pMig;
    char uuidBuffer[UVM_GPU_UUID_TEXT_BUFFER_LENGTH];

    for (index = 0; index < UVM_MAX_GPUS; ++index)
    {
        pMig = &pPriv->processRecord.gpuMigs[index];
        if (pMig->migTracker != NULL)
        {
            down_read(&g_attached_uuid_lock);
            format_uuid_to_buffer(uuidBuffer, sizeof(uuidBuffer),
                                  &g_attached_uuid_list[index].gpuUuid);
            up_read(&g_attached_uuid_lock);

            UVM_DBG_PRINT_RL("%s: (channelClass: 0x%0x, ceClass: 0x%0x)\n",
                uuidBuffer, pMig->migTracker->channelInfo.channelClassNum,
                pMig->migTracker->ceClassNumber);

            _destroy_migration_resources(pMig->migTracker);
            kmem_cache_free(g_uvmMigTrackerCache, pMig->migTracker);
            _disconnect_mig_completely(pMig, NULL);
        }
    }
}

//
// Locking: you must hold a write lock on the DriverPrivate.uvmPrivLock, before
// calling this routine.
//
static RM_STATUS _create_or_check_channel(UvmCommitRecord * pRecord)
{
    UvmPerProcessGpuMigs *pMig;
    unsigned index;
    RM_STATUS rmStatus;
    
    if (uvmlite_find_gpu_index(&pRecord->homeGpuUuid, &index) != RM_OK)
    {
        rmStatus = RM_ERR_OBJECT_NOT_FOUND;
        goto fail;
    }

    pRecord->cachedHomeGpuPerProcessIndex = index;

    pMig = &pRecord->osPrivate->processRecord.gpuMigs[index];
    if (pMig->migTracker != NULL)
    {
        // Re-using an already created mig tracker
        return RM_OK;
    }

    // Got a free slot, need to create the first mig tracker for this gpu
    pMig->migTracker = kmem_cache_zalloc(g_uvmMigTrackerCache,
                                         NV_UVM_GFP_FLAGS);
    if (pMig->migTracker == NULL)
    {
        rmStatus = RM_ERR_NO_MEMORY;
        goto fail;
    }

    rmStatus = _create_migration_resources(&pRecord->homeGpuUuid,
                                           pMig->migTracker);
    if (RM_OK != rmStatus)
        goto fail_and_cleanup_mig;

    return rmStatus;

fail_and_cleanup_mig:
    kmem_cache_free(g_uvmMigTrackerCache, pMig->migTracker);
    _disconnect_mig_completely(pMig, pRecord);
fail:
    pRecord->cachedHomeGpuPerProcessIndex = UVM_INVALID_HOME_GPU_INDEX;
    return rmStatus;
}

static UvmStreamRecord * _stream_find_in_cache(UvmProcessRecord *processRecord,
    UvmStream streamId)
{
    UvmStreamRecord *stream;
    int cacheIndex = streamId % UVM_STREAMS_CACHE_SIZE;

    stream = processRecord->streamsCache[cacheIndex];

    if (stream && stream->streamId == streamId)
        return stream;

    return NULL;
}

static void _stream_remove_from_cache(UvmStreamRecord *pStream)
{
    int cacheIndex = pStream->streamId % UVM_STREAMS_CACHE_SIZE;
    if (pStream->processRecord->streamsCache[cacheIndex] == pStream)
        pStream->processRecord->streamsCache[cacheIndex] = NULL;
}

static void _stream_save_in_cache(UvmStreamRecord *pStream)
{
    int cacheIndex;

    if (!pStream)
        return;

    cacheIndex = pStream->streamId % UVM_STREAMS_CACHE_SIZE;
    pStream->processRecord->streamsCache[cacheIndex] = pStream;
}

static UvmStreamRecord * _stream_find_in_list(UvmProcessRecord *processRecord,
    UvmStream streamId)
{
    struct list_head *pos;
    UvmStreamRecord *pStream = NULL;

    list_for_each(pos, &processRecord->allStreamList)
    {
        pStream = list_entry(pos, UvmStreamRecord, allStreamListNode);
        if (pStream->streamId == streamId)
            return pStream;
    }

    return NULL;
}

static UvmStreamRecord * _stream_alloc(UvmProcessRecord *processRecord,
    UvmStream streamId)
{
    UvmStreamRecord *pStream = NULL;

    UVM_DBG_PRINT_RL("stream %lld\n", streamId);

    pStream = (UvmStreamRecord*)kmem_cache_zalloc(g_uvmStreamRecordCache,
                                                  NV_UVM_GFP_FLAGS);
    if (pStream == NULL)
        return NULL;

    INIT_LIST_HEAD(&pStream->allStreamListNode);
    INIT_LIST_HEAD(&pStream->commitRecordsList);

    pStream->processRecord = processRecord;
    pStream->streamId       = streamId;
    pStream->isRunning      = NV_FALSE;

    list_add_tail(&pStream->allStreamListNode, &processRecord->allStreamList);

    return pStream;
}

static UvmStreamRecord * _stream_find(UvmProcessRecord *processRecord,
    UvmStream streamId)
{
    UvmStreamRecord *pStream = _stream_find_in_cache(processRecord, streamId);

    if (pStream == NULL)
        pStream = _stream_find_in_list(processRecord, streamId);

    return pStream;
}

static UvmStreamRecord * _stream_find_or_alloc(UvmProcessRecord *processRecord,
    UvmStream streamId)
{
    UvmStreamRecord *pStream = _stream_find(processRecord, streamId);

    if (pStream == NULL)
        pStream = _stream_alloc(processRecord, streamId);

    if (pStream == NULL)
        return NULL;

    _stream_save_in_cache(pStream);

    return pStream;
}

static void _record_detach_from_stream(UvmCommitRecord *pRecord)
{
    list_del(&pRecord->streamRegionsListNode);
    _stream_destroy_if_empty(pRecord->pStream);
    pRecord->pStream = NULL;
}

static RM_STATUS _record_attach_to_stream(UvmCommitRecord *pRecord,
    UvmStreamRecord *pNewStream)
{
    RM_STATUS status = RM_OK;
    UvmStreamRecord *pOldStream = pRecord->pStream;
    NvBool runningStateChanged = NV_TRUE;

    if (pOldStream && (pOldStream->isRunning == pNewStream->isRunning))
    {
        // No need to change the state if the record's old stream is in
        // the same state as the new stream.
        runningStateChanged = NV_FALSE;
    }

    if (runningStateChanged)
    {
        if (pNewStream->isRunning)
        {
            _set_record_inaccessible(pRecord);
            //
            // Attaching to a running stream from a stopped stream needs
            // to trigger migration to the gpu.
            //
            status = uvmlite_migrate_to_gpu(pRecord->baseAddress,
                                               pRecord->length,
                                               0, // flags
                                               pRecord->vma,
                                               pRecord);
        }
        else
            _set_record_accessible(pRecord);
    }

    list_del(&pRecord->streamRegionsListNode);
    list_add_tail(&pRecord->streamRegionsListNode,
        &pNewStream->commitRecordsList);
    pRecord->pStream = pNewStream;

    _stream_destroy_if_empty(pOldStream);

    return status;
}

//
// Locking: you must hold a write lock on the DriverPrivate.uvmPrivLock
// and mmap_sem, before calling this routine.
//
UvmCommitRecord *
uvmlite_create_commit_record(unsigned long long  requestedBase,
                             unsigned long long  length,
                             DriverPrivate *pPriv,
                             struct vm_area_struct *vma)

{
    UvmCommitRecord *pRecord = NULL;
    // The commitRecordPages array stores one pointer to each page:
    NvLength arrayByteLen = sizeof(pRecord->commitRecordPages[0])
                                    * (PAGE_ALIGN(length) / PAGE_SIZE);

    pRecord = (UvmCommitRecord*)kmem_cache_zalloc(g_uvmCommitRecordCache,
                                                  NV_UVM_GFP_FLAGS);
    if (NULL == pRecord)
    {
        UVM_ERR_PRINT("kmem_cache_zalloc(g_uvmCommitRecordCache) failed.\n");
        goto fail;
    }

    // Be sure to initialize the list, so that _destroy_record always works:
    INIT_LIST_HEAD(&pRecord->streamRegionsListNode);
    pRecord->baseAddress = requestedBase;
    pRecord->length      = length;
    pRecord->osPrivate   = pPriv;
    pRecord->vma         = vma;
    pRecord->cachedHomeGpuPerProcessIndex = UVM_INVALID_HOME_GPU_INDEX;

    pRecord->commitRecordPages = vmalloc(arrayByteLen);
    if (!pRecord->commitRecordPages)
    {
        UVM_ERR_PRINT("vmalloc(%llu) for commitRecordPages failed.\n",
                      (unsigned long long)arrayByteLen);
        goto fail;
    }

    memset(pRecord->commitRecordPages, 0, arrayByteLen);

    UVM_DBG_PRINT_RL("pPriv: 0x%p: Created pRecord: 0x%p, length: %llu\n",
                     pPriv, pRecord, length);
    return pRecord;

fail:
    _destroy_record(pRecord);
    return NULL;
}

//
// This routine assigns streamID and GPU UUID to the pRecord, and sets up a Copy
// Engine channel as well. (The Copy Engine is what actually does the memory
// migration to and from CPU and GPU.)
//
// Locking: you must already have acquired a write lock on these:
//      mmap_sem
//      DriverPrivate.uvmPrivLock
//
RM_STATUS uvmlite_update_commit_record(UvmCommitRecord *pRecord,
                                       UvmStream streamId,
                                       UvmGpuUuid *pUuid,
                                       DriverPrivate *pPriv)
{
    UvmStreamRecord *pStream = NULL;
    RM_STATUS rmStatus;

    UVM_PANIC_ON(!pRecord);
    pRecord->cachedHomeGpuPerProcessIndex = UVM_INVALID_HOME_GPU_INDEX;

    memcpy(pRecord->homeGpuUuid.uuid, pUuid, sizeof(pRecord->homeGpuUuid.uuid));
    //
    // The resulting resources from this call are cleaned up at process exit, as
    // part of the _destroy_migration_resources() call:
    //
    rmStatus = _create_or_check_channel(pRecord);
    if (RM_OK != rmStatus)
        goto fail;

    pStream = _stream_find_or_alloc(&pPriv->processRecord, streamId);
    if (!pStream)
    {
        rmStatus = RM_ERR_NO_MEMORY;
        goto fail;
    }

    UVM_DBG_PRINT_RL("pPriv: 0x%p updated pRecord: 0x%p, stream: %llu\n",
                     pPriv, pRecord, streamId);

    _record_attach_to_stream(pRecord, pStream);
    return rmStatus;

fail:
    _destroy_record(pRecord);
    return rmStatus;
}

//
// Locking: you must hold a write lock on the DriverPrivate.uvmPrivLock, before
// calling this routine.
//
// CAUTION: returns NULL upon failure. This failure can occur if:
//
//     a) there is no valid migration tracking resource available.
//
//     b) The UvmCommitRecord argument is corrupt (NULL osPrivate pointer).
//
static UvmGpuMigrationTracking * _get_mig_tracker(UvmCommitRecord * pRecord)
{
    unsigned migIndex;

    UVM_PANIC_ON((pRecord == NULL) || (pRecord->osPrivate == NULL));

    if ((pRecord == NULL) || (pRecord->osPrivate == NULL))
        return NULL;

    migIndex = pRecord->cachedHomeGpuPerProcessIndex;
    if (migIndex == UVM_INVALID_HOME_GPU_INDEX)
        return NULL;

    return pRecord->osPrivate->processRecord.gpuMigs[migIndex].migTracker;
}

//
// Page fault handler for UVM-Lite
//
// Locking:
//     1. the kernel calls into this routine with the mmap_sem lock taken.
//     2. this routine acquires a write lock on the DriverPrivate.uvmPrivLock.
//
// Write fault algorithm:
//
//      1. Lookup address in page tracking
//      2. If page exists, mark as dirty, and we are done.
//      3. else, do "read fault" (below), then mark the page as dirty.
//
// Read fault algorithm:
//
//      1. Lookup which stream owns the address
//      2. See if that stream is active: if so, UVM-Lite rules are violated, so
//         return SIGBUS.
//      3. Otherwise, map in a page from the cache, and allow access.
//
int _fault_common(struct vm_area_struct *vma, unsigned long vaddr,
                  struct page **ppage, unsigned vmfFlags)
{
    int retValue = VM_FAULT_SIGBUS;
    UvmCommitRecord *pRecord;
    DriverPrivate *pPriv;
    RM_STATUS rmStatus;
    UvmGpuMigrationTracking *pMigTracker;
    NvUPtr cpuPhysAddr;
    unsigned long pageIndex = (vaddr - vma->vm_start) >> PAGE_SHIFT;
    UvmCounterInfo *procPerGpuCounter;
    UvmPageTracking *pTracking = NULL;

    pRecord = (UvmCommitRecord*)vma->vm_private_data;
    if (!pRecord)
        goto done;

    pPriv = pRecord->osPrivate;
    UVM_PANIC_ON(!pPriv);
    if (!pPriv)
        goto done;

    down_write(&pPriv->uvmPrivLock);

    if (_is_record_matching_vma(pRecord) == NV_FALSE)
    {
        //
        // The VMA has been modified since the record was created, skip it.
        // This should never be possible as we destroy the records with
        // modified vmas in mmap_open().
        //
        UVM_PANIC();
        goto fail;
    }

    pTracking = pRecord->commitRecordPages[pageIndex];

    UVM_DBG_PRINT_RL("FAULT_ENTRY: vaddr: 0x%p, pPriv: 0x%p, vma: 0x%p, "
                     "pRecord: 0x%p\n",
                     (void*)vaddr, pPriv, vma, pRecord);

    procPerGpuCounter =
        &pPriv->processRecord.pProcessCounterInfo->procSingleGpuCounterArray
                  [pRecord->cachedHomeGpuPerProcessIndex];

    if (!pTracking)
    {
        pTracking = uvm_page_cache_alloc_page(pPriv);
        if (!pTracking)
        {
            retValue = VM_FAULT_OOM;
            goto fail;
        }

        UVM_DBG_PRINT_RL("FAULT_ALLOC: vaddr: 0x%p, page: 0x%p, "
                         "pPriv: 0x%p, vma: 0x%p, pRecord: 0x%p\n",
                         (void*)vaddr, pTracking->uvmPage, pPriv, vma,
                         pRecord);

        pRecord->commitRecordPages[pageIndex] = pTracking;

        cpuPhysAddr = page_to_phys(pTracking->uvmPage);

        pMigTracker = _get_mig_tracker(pRecord);
        UVM_PANIC_ON(!pMigTracker);
        if (!pMigTracker)
            goto fail;

        rmStatus = migrate_gpu_to_cpu(pMigTracker, pRecord, 
                                       (UvmGpuPointer) vaddr, 
                                       cpuPhysAddr,PAGE_SIZE);
        if (rmStatus != RM_OK)
        {
            UVM_ERR_PRINT("FAULT: failed to copy from cpu to gpu:"
                          " vaddr:0x%p, page: 0x%p, physAddr:0x%p, vma: 0x%p, "
                          "rmStatus: 0x%0x\n",
                          (void*)vaddr, pTracking->uvmPage, (void*)cpuPhysAddr,
                          vma, rmStatus);
            goto fail;
        }

        retValue = VM_FAULT_MAJOR;

        uvm_increment_process_counters(procPerGpuCounter, &pPriv->processRecord,
            UvmCounterNameCpuPageFaultCount, 1);
        uvm_increment_process_counters(procPerGpuCounter, &pPriv->processRecord,
            UvmCounterNameBytesXferDtH, PAGE_SIZE);
    }
    else
    {
        //
        // If we already have the page, then we must have earlier copied in the
        // data from the GPU. Therefore, avoid migrating, and instead just take
        // a reference so that the fault handling logic is correct:
        //
        get_page(pTracking->uvmPage);
        retValue = VM_FAULT_MINOR;
    }

    pRecord->isMapped = NV_TRUE;

    UVM_DBG_PRINT_RL("FAULT HANDLED: vaddr: 0x%p, vma: 0x%p, "
                     "page: 0x%p (pfn:0x%lx, refcount: %d)\n",
                     (void*)vaddr, vma, pTracking->uvmPage,
                     page_to_pfn(pTracking->uvmPage),
                     page_count(pTracking->uvmPage));

    *ppage = pTracking->uvmPage;
    up_write(&pPriv->uvmPrivLock);
    return retValue;

fail:
    if (pTracking)
    {
        uvm_page_cache_free_page(pTracking, __FUNCTION__);
        pRecord->commitRecordPages[pageIndex] = NULL;
    }

    up_write(&pPriv->uvmPrivLock);
done:
    return retValue;
}

#if defined(NV_VM_OPERATIONS_STRUCT_HAS_FAULT)
int _fault(struct vm_area_struct *vma, struct vm_fault *vmf)
{
    unsigned long vaddr = (unsigned long)vmf->virtual_address;
    struct page *page = NULL;
    int retval;

    retval = _fault_common(vma, vaddr, &page, vmf->flags);

    vmf->page = page;

    return retval;
}

#else
struct page * _fault_old_style(struct vm_area_struct *vma,
                               unsigned long address, int *type)
{
    unsigned long vaddr = address;
    struct page *page = NULL;

    *type = _fault_common(vma, vaddr, &page, FAULT_FLAG_FROM_OLD_KERNEL);

    return page;
}
#endif

static struct vm_operations_struct uvmlite_vma_ops =
{
    .open = _mmap_open,
    .close = _mmap_close,

#if defined(NV_VM_OPERATIONS_STRUCT_HAS_FAULT)
    .fault = _fault,
#else
    .nopage = _fault_old_style,
#endif
};

//
// Counters feature doesn't support fault handler. However,
// without setting vma_ops and fault handler, Linux kernel assumes
// it's dealing with anonymous mapping (see handle_pte_fault).
//
#if defined(NV_VM_OPERATIONS_STRUCT_HAS_FAULT)
int _sigbus_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
{
    vmf->page = NULL;
    return VM_FAULT_SIGBUS;
}

#else
struct page * _sigbus_fault_old_style(struct vm_area_struct *vma,
                               unsigned long address, int *type)
{
    *type = VM_FAULT_SIGBUS;
    return NULL;
}
#endif

static struct vm_operations_struct counters_vma_ops =
{
#if defined(NV_VM_OPERATIONS_STRUCT_HAS_FAULT)
    .fault = _sigbus_fault,
#else
    .nopage = _sigbus_fault_old_style,
#endif
};

//
// Locking: you must hold a write lock on the DriverPrivate.uvmPrivLock, before
// calling this routine.
//
RM_STATUS uvmlite_migrate_to_gpu(unsigned long long baseAddress,
                                  NvLength length,
                                  unsigned migrateFlags,
                                  struct vm_area_struct *vma,
                                  UvmCommitRecord * pRecord)
{
    RM_STATUS rmStatus = RM_OK;
    UvmGpuMigrationTracking *pMigTracker;

    if (!pRecord || !vma)
        return RM_ERR_INVALID_ARGUMENT;

    UVM_PANIC_ON(pRecord->vma != vma); // Serious object model corruption occurred.
    UVM_PANIC_ON(pRecord->baseAddress != baseAddress);
    UVM_PANIC_ON(PAGE_ALIGN(pRecord->length) != PAGE_ALIGN(length));
    UVM_PANIC_ON(vma->vm_pgoff << PAGE_SHIFT != pRecord->baseAddress);

    pMigTracker = _get_mig_tracker(pRecord);
    if (pMigTracker == NULL)
    {
        return RM_ERR_GPU_DMA_NOT_INITIALIZED;
    }

    UVM_PANIC_ON(NULL == pRecord->osPrivate);
    UVM_PANIC_ON(NULL == pRecord->osPrivate->privFile);
    UVM_PANIC_ON(NULL == pRecord->osPrivate->privFile->f_mapping);

    // If this record has no pages mapped, then we can early out
    if (!pRecord->isMapped)
    {
        return RM_OK;
    }

    if (pRecord->length > 0)
    {
        unmap_mapping_range(pRecord->osPrivate->privFile->f_mapping,
                            pRecord->baseAddress, pRecord->length, 1);
        pRecord->isMapped = NV_FALSE;
    }
    //
    // Copy required pages from CPU to GPU. We try to pipeline these copies
    // to get maximum performance from copy engine.
    //
    rmStatus = migrate_cpu_to_gpu(pMigTracker, pRecord, PAGE_SIZE);

    return rmStatus;
}

//
// SetStreamRunning (cuda kernel launch) steps:
//
//    For each region attached to the stream ID, or to the all-stream:
//
//        1. unmap page range from user space
//
//        2. copy cpu to gpu, for dirty pages only (lots of room for
//        optimization here)
//
//        3. Free pages from page cache
//
// Locking: you must hold a write lock on the DriverPrivate.uvmPrivLock
// and mmap_sem, before calling this routine.
//
static RM_STATUS _set_stream_running(DriverPrivate* pPriv, UvmStream streamId)
{
    struct list_head * pos;
    UvmCommitRecord * pRecord;
    UvmStreamRecord * pStream;
    RM_STATUS rmStatus = RM_OK;
    UvmProcessRecord *processRecord = &pPriv->processRecord;

    UVM_DBG_PRINT_RL("stream %lld\n", streamId);

    // This might be the first time we see this streamId
    pStream = _stream_find_or_alloc(processRecord, streamId);

    if (pStream->isRunning)
    {
        // Stream is in running state already
        return RM_OK;
    }

    list_for_each(pos, &pStream->commitRecordsList)
    {
        pRecord = list_entry(pos, UvmCommitRecord, streamRegionsListNode);
        UVM_DBG_PRINT_RL("committed region baseAddr: 0x%p, len: 0x%llx\n",
                         (void*)pRecord->baseAddress, pRecord->length);

        if (_is_record_matching_vma(pRecord) == NV_FALSE)
        {
            //
            // The VMA has been modified since the record was created, skip it.
            // This should never be possible as we destroy the records with
            // modified vmas in mmap_open().
            //
            UVM_PANIC();
            continue;
        }

        // Mark the record as inaccessible.
        _set_record_inaccessible(pRecord);

        rmStatus = uvmlite_migrate_to_gpu(pRecord->baseAddress,
                                           pRecord->length,
                                           0, // flags
                                           pRecord->vma,
                                           pRecord);
        if (rmStatus != RM_OK)
            goto done;
    }

    if (streamId != UVM_STREAM_ALL)
    {
        // Increment the running streams count
        ++processRecord->runningStreams;
        if (processRecord->runningStreams == 1)
        {
            // First stream to be started needs to also start the all stream
            rmStatus = _set_stream_running(pPriv, UVM_STREAM_ALL);
            if (rmStatus != RM_OK)
                goto done;
        }
    }

    pStream->isRunning = NV_TRUE;

done:
    return rmStatus;
}

static NvBool _is_special_stream(UvmStream streamId)
{
    return streamId == UVM_STREAM_INVALID ||
           streamId == UVM_STREAM_ALL     ||
           streamId == UVM_STREAM_NONE;
}

//
// Locking: you must hold a write lock on the DriverPrivate.uvmPrivLock
// and mmap_sem, before calling this routine.
//
RM_STATUS uvmlite_set_stream_running(DriverPrivate* pPriv, UvmStream streamId)
{
    if (_is_special_stream(streamId))
        return RM_ERR_INVALID_ARGUMENT;

    return _set_stream_running(pPriv, streamId);
}

static RM_STATUS _set_stream_stopped(DriverPrivate *pPriv,
    UvmStream streamId)
{
    struct list_head * pos;
    UvmCommitRecord * pRecord;
    UvmStreamRecord * pStream;
    RM_STATUS rmStatus = RM_OK;
    UvmProcessRecord *processRecord = &pPriv->processRecord;

    UVM_DBG_PRINT_RL("stream %lld\n", streamId);

    pStream = _stream_find(processRecord, streamId);
    if (!pStream)
    {
        // The stream has never been started
        return RM_ERR_INVALID_ARGUMENT;
    }

    _stream_save_in_cache(pStream);

    if (!pStream->isRunning)
    {
        // Stream is in stopped state already
        return RM_OK;
    }

    list_for_each(pos, &pStream->commitRecordsList)
    {
        pRecord = list_entry(pos, UvmCommitRecord, streamRegionsListNode);
        UVM_DBG_PRINT_RL("committed region baseAddr: 0x%p, len: 0x%llx\n",
                         (void*)pRecord->baseAddress, pRecord->length);

        if (_is_record_matching_vma(pRecord) == NV_FALSE)
        {
            //
            // The VMA has been modified since the record was created, skip it.
            // This should never be possible as we destroy the records with
            // modified vmas in mmap_open().
            //
            UVM_PANIC();
            continue;
        }

        // Mark the record as inaccessible.
        _set_record_accessible(pRecord);
    }

    if (streamId != UVM_STREAM_ALL)
    {
        // Decrement the running stream count
        --processRecord->runningStreams;
        if (processRecord->runningStreams == 0)
        {
            // Last stream to be stopped needs to also stop the all stream
            rmStatus = _set_stream_stopped(pPriv, UVM_STREAM_ALL);
            if (rmStatus != RM_OK)
                goto done;
        }
    }

    pStream->isRunning = NV_FALSE;

    _stream_destroy_if_empty(pStream);

done:
    return rmStatus;
}

//
// Locking: you must hold a write lock on the DriverPrivate.uvmPrivLock
// and mmap_sem, before calling this routine.
//
RM_STATUS uvmlite_set_streams_stopped(DriverPrivate* pPriv,
                                      UvmStream * streamIdArray,
                                      NvLength nStreams)
{
    NvLength i;
    RM_STATUS rmStatus = RM_OK;

    for (i = 0; i < nStreams; ++i)
    {
        if (_is_special_stream(streamIdArray[i]))
            return RM_ERR_INVALID_ARGUMENT;
    }

    for (i = 0; i < nStreams; ++i)
    {
        rmStatus = _set_stream_stopped(pPriv, streamIdArray[i]);
        if (rmStatus != RM_OK)
            break;
    }

    return rmStatus;
}

static void _stream_destroy_if_empty(UvmStreamRecord *pStream)
{
    if (!pStream)
        return;

    if (pStream->isRunning)
    {
        //
        // Don't destroy running streams even if they are empty as a record
        // might be attached before they are stopped.
        //
        return;
    }

    if (!list_empty(&pStream->commitRecordsList))
    {
        // Don't destroy streams with attached records
        return;
    }

    _stream_destroy(pStream);
}

RM_STATUS uvmlite_region_set_stream(UvmCommitRecord *pRecord,
    UvmStream newStreamId)
{
    UvmStreamRecord *pNewStream;
    RM_STATUS status;

    if (pRecord == NULL)
        return RM_ERR_INVALID_ARGUMENT;

    if (pRecord->pStream->streamId == newStreamId)
        return RM_OK;

    pNewStream = _stream_find_or_alloc(&pRecord->osPrivate->processRecord,
                                       newStreamId);
    if (!pNewStream)
        return RM_ERR_INSUFFICIENT_RESOURCES;

    status = _record_attach_to_stream(pRecord, pNewStream);

    return status;
}

void uvmlite_free_process_counters(UvmProcessCounterInfo *pProcCounterInfo)
{
    unsigned gpu;
    UvmCounterInfo *pCurrCounter;

    for (gpu = 0; gpu < UVM_MAX_GPUS; gpu++)
    {
        pCurrCounter = &pProcCounterInfo->procSingleGpuCounterArray[gpu];

        if (pCurrCounter->pCounterPage != NULL)
        {
            kunmap(pCurrCounter->pCounterPage);
            __free_page(pCurrCounter->pCounterPage);
        }
    }

    pCurrCounter = &pProcCounterInfo->procAllGpuCounter;

    if (pCurrCounter->pCounterPage != NULL)
    {
        kunmap(pCurrCounter->pCounterPage);
        __free_page(pCurrCounter->pCounterPage);
    }
    kmem_cache_free(g_uvmProcessCounterInfoCache, pProcCounterInfo);
}

//
// This function initializes the counter information structure pCtrInfo.
//
static RM_STATUS _create_counter
(
    UvmCounterInfo *pCtrInfo
)
{
    memset(pCtrInfo, 0, sizeof(*pCtrInfo));
    pCtrInfo->pCounterPage = alloc_page(NV_UVM_GFP_FLAGS | GFP_HIGHUSER);

    if (!pCtrInfo->pCounterPage)
        return RM_ERR_INSUFFICIENT_RESOURCES;

    pCtrInfo->sysAddr = kmap(pCtrInfo->pCounterPage);
    memset(pCtrInfo->sysAddr, 0, PAGE_SIZE);

    return RM_OK;
}

RM_STATUS uvmlite_init_process_counters
(
    UvmProcessRecord *pRecord
)
{
    int gpu;
    UvmProcessCounterInfo* pProcessCounterInfo;

    RM_STATUS status;

    pProcessCounterInfo = (UvmProcessCounterInfo *)
        kmem_cache_zalloc(g_uvmProcessCounterInfoCache, NV_UVM_GFP_FLAGS);

    if (pProcessCounterInfo == NULL)
        return RM_ERR_INSUFFICIENT_RESOURCES;

    NV_ATOMIC_SET(pProcessCounterInfo->refcountUsers, 1);

    for (gpu = 0; gpu < UVM_MAX_GPUS; gpu++)
    {
        status = _create_counter(&pProcessCounterInfo->
                    procSingleGpuCounterArray[gpu]);
        if (status != RM_OK)
            goto fail;
    }

    status = _create_counter(&pProcessCounterInfo->procAllGpuCounter);
    if (status != RM_OK)
        goto fail;

    pRecord->pProcessCounterInfo = pProcessCounterInfo;

    return RM_OK;

fail:
    // free all the resources that got allocated before failure
    uvmlite_free_process_counters(pProcessCounterInfo);
    return status;

}


//
// Locking: this routine initializes the DriverPrivate.uvmPrivLock.
// thread safety: uvmlite_open has to be used by a single thread,
//
static int uvmlite_open(struct inode *inode, struct file *filp)
{
    DriverPrivate * pUvmPrivate = NULL;
    int retval = -ENOMEM;

    struct address_space *pMapping =
        kmem_cache_alloc(g_uvmMappingCache, NV_UVM_GFP_FLAGS);

    if (!pMapping)
        goto fail;

    pUvmPrivate = (DriverPrivate*)
                  kmem_cache_zalloc(g_uvmPrivateCache, NV_UVM_GFP_FLAGS);

    if (!pUvmPrivate)
        goto fail;
    //
    // UVM-Lite calls unmap_mapping_range, but UVM-Lite has only a single device
    // node, through which all user-space processes do their mmap() calls. In
    // order to avoid interference among unrelated processes, we must set up a
    // separate mapping object for each struct file.
    //
    address_space_init_once(pMapping);
    pMapping->host = inode;

    INIT_LIST_HEAD(&pUvmPrivate->pageList);
    INIT_LIST_HEAD(&pUvmPrivate->processRecord.allStreamList);
    INIT_LIST_HEAD(&pUvmPrivate->driverPrivateNode);
    init_rwsem(&pUvmPrivate->uvmPrivLock);
    pUvmPrivate->privFile = filp;
    pUvmPrivate->processRecord.euid = NV_CURRENT_EUID();

    if (RM_OK != uvmlite_init_process_counters(&pUvmPrivate->processRecord))
       goto fail;

    uvm_init_session_info_array(&pUvmPrivate->processRecord);

    filp->private_data = pUvmPrivate;
    filp->f_mapping = pMapping;

    pUvmPrivate->processRecord.pid = uvm_get_stale_process_id();
    // register to global process record table after initialization
    down_write(&g_uvmDriverPrivateTableLock);
    list_add(&pUvmPrivate->driverPrivateNode, 
             &g_uvmDriverPrivateTable); 
    up_write(&g_uvmDriverPrivateTableLock);

    UVM_DBG_PRINT("pPriv: 0x%p, f_mapping: 0x%p\n",
                  filp->private_data, filp->f_mapping);

    return 0;

fail:
    if (pMapping)
        kmem_cache_free(g_uvmMappingCache, pMapping);

    if (pUvmPrivate)
        kmem_cache_free(g_uvmPrivateCache, pUvmPrivate);

    return retval;
}

UvmProcessCounterInfo *
uvmlite_get_and_refcount_process_counter_info(UvmProcessRecord *pProcessRecord)
{
    UvmProcessCounterInfo *pProcessCounterInfo = 
                                pProcessRecord->pProcessCounterInfo;

    NV_ATOMIC_INC(pProcessCounterInfo->refcountUsers);

    return pProcessCounterInfo;
}


void uvmlite_put_and_unrefcount_process_counter_info
(
    UvmProcessCounterInfo *pProcessCounterInfo
)
{
    // Free counter information if this is the only process using it.
    if (NV_ATOMIC_DEC_AND_TEST(pProcessCounterInfo->refcountUsers))
        uvmlite_free_process_counters(pProcessCounterInfo);
}

//
// Locking: you must hold processRecordTableLock read lock 
// when you access UvmProcessRecord.
// 
static UvmProcessRecord* _find_process_record(unsigned pid)
{
    struct list_head * pos;
    UvmProcessRecord *pProcessRecord;

    list_for_each(pos, &g_uvmDriverPrivateTable)
    {
        pProcessRecord = &list_entry(pos, DriverPrivate, 
                                    driverPrivateNode)->processRecord;
        if (pid == pProcessRecord->pid)
            return pProcessRecord;
    }
    return NULL;
}


//
// On success, this routine increments refcount on UmvProcessCouterInfo
// and returns pEuid and UvmProcessCounterInfo.
// Locking:
//     1. This routine acquires the read g_uvmDriverPrivateTableLock.
//
RM_STATUS uvmlite_secure_get_process_counter_info
(
    unsigned pidTarget,
    UvmProcessCounterInfo **ppProcessCounterInfo,
    uid_t *pEuid
)
{
    UvmProcessRecord *pProcRec;


    //
    // uvmlite_close can't decrement refcount / remove ProcessCounterInfo
    // structure before grabbing g_uvmDriverPrivateTableLock and removing itself
    // from g_uvmDriverPrivateTable.
    //
    down_read(&g_uvmDriverPrivateTableLock);

    pProcRec = _find_process_record(pidTarget);

    if (pProcRec == NULL)
    {
        up_read(&g_uvmDriverPrivateTableLock);
        return RM_ERR_PID_NOT_FOUND;
    }

    *pEuid = pProcRec->euid;

    if (!uvm_user_id_security_check(*pEuid))
    {
        up_read(&g_uvmDriverPrivateTableLock);
        return RM_ERR_INSUFFICIENT_PERMISSIONS;
    }

    *ppProcessCounterInfo = 
        uvmlite_get_and_refcount_process_counter_info(pProcRec);

    up_read(&g_uvmDriverPrivateTableLock);

    return RM_OK;
}

//
// Locking:
//     1. This routine acquires the g_uvmDriverPrivateTableLock.
//
static int uvmlite_close(struct inode *inode, struct file *filp)
{
    DriverPrivate* pPriv = (DriverPrivate*)filp->private_data;

    // unregister from global process record table before cleanup
    down_write(&g_uvmDriverPrivateTableLock);
    list_del(&pPriv->driverPrivateNode);
    _delete_all_migration_resources(pPriv);
    up_write(&g_uvmDriverPrivateTableLock);

    uvmlite_put_and_unrefcount_process_counter_info(
        pPriv->processRecord.pProcessCounterInfo);
    //
    // At this point all the regions have been removed, but there might be some
    // leftover streams in running state.
    //
    _stop_and_destroy_leftover_streams(&pPriv->processRecord);
    UVM_PANIC_ON(!list_empty(&pPriv->processRecord.allStreamList));
    //
    // Pages are freed when each commit record is destroyed, and those in turn
    // are destroyed when their vmas go away. All that happens during process
    // teardown, in the kernel core, before the fd's are closed. That all means
    // that there should not be any pages remaining by the time we get here.
    //
    uvm_page_cache_verify_page_list_empty(pPriv, __FUNCTION__);
    _delete_all_session_info_table_entries(&pPriv->processRecord);

    kmem_cache_free(g_uvmMappingCache, filp->f_mapping);
    kmem_cache_free(g_uvmPrivateCache, pPriv);
    UVM_DBG_PRINT("done\n");

    return 0;
}

static int uvmlite_mmap(struct file * filp, struct vm_area_struct * vma)
{
    // vm_end and vm_start are already aligned to page boundary
    unsigned long nPages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
    unsigned long counterLowestPage = UVM_COUNTERS_OFFSET_BASE >> PAGE_SHIFT;
    int ret = -EINVAL;
    UvmCommitRecord *pRecord = NULL;
    DriverPrivate *pPriv = (DriverPrivate*)filp->private_data;

    UVM_PANIC_ON(!pPriv);

    // verify mapping is not within UVM privileged region
    if ((unsigned long)vma->vm_start >= g_uvmKernelPrivRegionStart &&
        (unsigned long)vma->vm_start < g_uvmKernelPrivRegionStart +
                                       g_uvmKernelPrivRegionLength)
    {
        return -EINVAL;
    }

    if (vma->vm_pgoff + nPages < counterLowestPage)
    {  
        //
        // UVM mappings must set the offset to the virtual address of the 
        // mapping. Also check VA alignment
        //
        if (vma->vm_start != (vma->vm_pgoff << PAGE_SHIFT))
            return -EINVAL;

        down_write(&pPriv->uvmPrivLock);
        pRecord = uvmlite_create_commit_record(vma->vm_start,
                                               vma->vm_end - vma->vm_start,
                                               pPriv, vma);
        up_write(&pPriv->uvmPrivLock);

        if (NULL == pRecord)
            return -ENOMEM;

        vma->vm_ops   = &uvmlite_vma_ops;

        // Prohibit copying the vma on fork().
        vma->vm_flags |= VM_DONTCOPY;
        // Prohibt mremap() that would expand the vma.
        vma->vm_flags |= VM_DONTEXPAND;

        // Other cases of vma modification are detected in _mmap_open().

        vma->vm_private_data  = pRecord;
        //
        // No access until we know which stream the vma (region) is attached to.
        // This will be done in the REGION_COMMIT ioctl.
        //
        _set_vma_inaccessible(vma);
        ret = 0;
    } 
    else if (vma->vm_pgoff >= counterLowestPage)
    {
        // mapping for counters (read only)
        if (vma->vm_flags & VM_WRITE)
            return -EINVAL;

        vma->vm_ops = &counters_vma_ops;
        vma->vm_flags &= ~VM_MAYWRITE;
        // prevent vm_insert_page from modifying the vma's flags:
        vma->vm_flags |= VM_MIXEDMAP;
        ret = 0;
    }
    UVM_DBG_PRINT_RL("vma 0x%p [0x%p, 0x%p) ret %d pgoff"
                     " %lu nPages %lu\n",
                     vma, (void*)vma->vm_start, (void*)vma->vm_end, ret,
                     vma->vm_pgoff, nPages);

    return ret;
}

static long uvmlite_unlocked_ioctl(struct file *filp,
                                   unsigned int cmd,
                                   unsigned long arg)
{
    //
    // The following macro is only intended for use in this routine. That's why
    // it is declared inside the function (even though, of course, the
    // preprocessor ignores such scoping).
    //
    #define UVM_ROUTE_CMD(cmd,functionName)                                 \
        case cmd:                                                           \
        {                                                                   \
            cmd##_PARAMS params;                                            \
            if (copy_from_user(&params, (void __user*)arg, sizeof(params))) \
                return -EFAULT;                                             \
                                                                            \
            params.rmStatus = functionName(&params, filp);                 \
            if (copy_to_user((void __user*)arg, &params, sizeof(params)))   \
                return -EFAULT;                                             \
                                                                            \
            break;                                                          \
        }

    switch (cmd)
    {
        case UVM_INITIALIZE:
            UVM_DBG_PRINT("cmd: UVM_INITIALIZE\n");
            break;
        case UVM_DEINITIALIZE:
            UVM_DBG_PRINT("cmd: UVM_DEINITIALIZE\n");
            break;
        UVM_ROUTE_CMD(UVM_RESERVE_VA,             uvm_api_reserve_va);
        UVM_ROUTE_CMD(UVM_RELEASE_VA,             uvm_api_release_va);
        UVM_ROUTE_CMD(UVM_REGION_COMMIT,          uvm_api_region_commit);
        UVM_ROUTE_CMD(UVM_REGION_DECOMMIT,        uvm_api_region_decommit);
        UVM_ROUTE_CMD(UVM_REGION_SET_STREAM,      uvm_api_region_set_stream);
        UVM_ROUTE_CMD(UVM_SET_STREAM_RUNNING,     uvm_api_region_set_stream_running);
        UVM_ROUTE_CMD(UVM_SET_STREAM_STOPPED,     uvm_api_region_set_stream_stopped);
        UVM_ROUTE_CMD(UVM_MIGRATE_TO_GPU,         uvm_api_migrate_to_gpu);
#if defined(DEBUG)
        UVM_ROUTE_CMD(UVM_RUN_TEST,               uvm_api_run_test);
#endif
        UVM_ROUTE_CMD(UVM_ADD_SESSION,            uvm_api_add_session);
        UVM_ROUTE_CMD(UVM_REMOVE_SESSION,         uvm_api_remove_session);
        UVM_ROUTE_CMD(UVM_MAP_COUNTER,            uvm_api_map_counter);
        UVM_ROUTE_CMD(UVM_ENABLE_COUNTERS,        uvm_api_enable_counters);
        default:
            UVM_ERR_PRINT("Unknown: cmd: 0x%0x\n", cmd);
            return -EINVAL;
            break;
    }

    #undef UVM_ROUTE_CMD

    return 0;
}

static const struct file_operations uvmlite_fops = {
    .open            = uvmlite_open,
    .release         = uvmlite_close,
    .mmap            = uvmlite_mmap,
    .unlocked_ioctl  = uvmlite_unlocked_ioctl,
#if NVCPU_IS_X86_64 && defined(NV_FILE_OPERATIONS_HAS_COMPAT_IOCTL)
    .compat_ioctl    = uvmlite_unlocked_ioctl,
#endif
    .owner           = THIS_MODULE,
};


//
// Locking: this initializes the g_uvmDriverPrivateTableLock, and doesn't take 
// or acquire any other locks.
//
int uvmlite_init(dev_t uvmBaseDev)
{
    dev_t uvmliteDev = MKDEV(MAJOR(uvmBaseDev), NVIDIA_UVM_LITE_MINOR_NUMBER);
    int ret = 0;

    // TODO: call register_shrinker()
    init_rwsem(&g_uvmDriverPrivateTableLock);

    init_rwsem(&g_attached_uuid_lock);
    memset(g_attached_uuid_list, 0, sizeof (g_attached_uuid_list));
    g_attached_uuid_num = 0;

    // Debugging hint: kmem_cache_create objects are visible in /proc/slabinfo:
    ret = -ENOMEM;
    NV_KMEM_CACHE_CREATE(g_uvmPrivateCache, "uvm_private_t",
                         struct DriverPrivate_tag);
    if (!g_uvmPrivateCache)
        goto fail;

    NV_KMEM_CACHE_CREATE(g_uvmCommitRecordCache, "uvm_commit_record_t",
                         struct UvmCommitRecord_tag);
    if (!g_uvmCommitRecordCache)
        goto fail;

    NV_KMEM_CACHE_CREATE(g_uvmProcessCounterInfoCache,
        "uvm_process_counter_info_t", struct UvmProcessCounterInfo_tag);

    if (!g_uvmProcessCounterInfoCache)
        goto fail;

    NV_KMEM_CACHE_CREATE(g_uvmMigTrackerCache, "uvm_mig_tracker_t",
                         struct UvmGpuMigrationTracking_tag);

    if (!g_uvmMigTrackerCache)
        goto fail;

    NV_KMEM_CACHE_CREATE(g_uvmStreamRecordCache, "uvm_stream_record_t",
                         struct UvmStreamRecord_tag);
    if (!g_uvmStreamRecordCache)
        goto fail;

    NV_KMEM_CACHE_CREATE(g_uvmMappingCache, "uvm_mapping_t",
                         struct address_space);
    if (!g_uvmMappingCache)
        goto fail;

    if (0 != uvm_page_cache_init())
        goto fail;

    if (RM_OK != nvUvmInterfaceGetUvmPrivRegion(&g_uvmKernelPrivRegionStart,
                                                &g_uvmKernelPrivRegionLength))
        goto fail;

    // Add the device to the system as a last step to avoid any race condition.
    cdev_init(&g_uvmlite_cdev, &uvmlite_fops);
    g_uvmlite_cdev.owner = THIS_MODULE;

    ret = cdev_add(&g_uvmlite_cdev, uvmliteDev, 1);
    if (ret)
    {
        UVM_ERR_PRINT("cdev_add (major %u, minor %u) failed: %d\n",
                      MAJOR(uvmliteDev), MINOR(uvmliteDev), ret);
        goto fail;
    }

    return 0;

fail:
    kmem_cache_destroy_safe(g_uvmMappingCache);
    kmem_cache_destroy_safe(g_uvmStreamRecordCache);
    kmem_cache_destroy_safe(g_uvmMigTrackerCache);
    kmem_cache_destroy_safe(g_uvmProcessCounterInfoCache);
    kmem_cache_destroy_safe(g_uvmCommitRecordCache);
    kmem_cache_destroy_safe(g_uvmPrivateCache);

    UVM_ERR_PRINT("Failed\n");
    return ret;

}

int uvmlite_setup_gpu_list()
{
    NvU8 *pUuidList;
    RM_STATUS status;
    unsigned i = 0;
    unsigned numAttachedGpus = 0;
    int result = 0;
  
    // get the list of gpus
    pUuidList = vmalloc(sizeof(NvU8) * UVM_MAX_GPUS * UVM_UUID_LEN);
    if (!pUuidList)
        return -ENOMEM;

    down_write(&g_attached_uuid_lock);

    status = nvUvmInterfaceGetAttachedUuids(pUuidList, &numAttachedGpus);
    if (status != RM_OK || (numAttachedGpus > UVM_MAX_GPUS))
    {
        UVM_ERR_PRINT("ERROR: Error in finding GPUs\n");
        result = -ENODEV;
        goto cleanup;
    }

    UVM_DBG_PRINT("Attached GPUs number = %u\n", numAttachedGpus);
    // construct the uuid list 
    for (i = 0; i < numAttachedGpus; i++)
    {
        UvmGpuUuid *gpuUuid = (UvmGpuUuid *) (pUuidList + (i * UVM_UUID_LEN));
        RM_STATUS status;
        unsigned index;
        
        UVM_DBG_PRINT_UUID("Found attached GPU", gpuUuid);
        status = _find_or_add_gpu_index(gpuUuid, &index);
        if (status != RM_OK)
        {
            result = -ENOMEM;
            goto cleanup;
        }

        g_attached_uuid_list[index].isEnabled = NV_TRUE;

    }

cleanup: 
    up_write(&g_attached_uuid_lock);

    vfree(pUuidList);
    return result;
}

void uvmlite_exit(void)
{
    //
    // No extra cleanup of regions or data structures is necessary here, because
    // that is done by the file release routine, and the kernel won't allow the
    // module to be unloaded while it's device file open count remains >0.
    //
    // However, this is still a good place for:
    //
    //     TODO: check for resource leaks here, just in case.
    //

    // TODO: call unregister_shrinker()
    cdev_del(&g_uvmlite_cdev);

    kmem_cache_destroy(g_uvmMappingCache);
    kmem_cache_destroy(g_uvmStreamRecordCache);
    kmem_cache_destroy(g_uvmMigTrackerCache);
    kmem_cache_destroy(g_uvmCommitRecordCache);
    kmem_cache_destroy(g_uvmPrivateCache);
    kmem_cache_destroy(g_uvmProcessCounterInfoCache);

    uvm_page_cache_destroy();
}

//
// This function sets up the CopyEngine and its channel.
//
// Locking: you must hold a write lock on the DriverPrivate.uvmPrivLock, before
// calling this routine.
//
static RM_STATUS
_create_migration_resources(UvmGpuUuid * pGpuUuidStruct,
                            UvmGpuMigrationTracking *pMigTracking)
{
    RM_STATUS rmStatus;
    unsigned ceInstance = 1;
    unsigned long long uuidMsb = 0;
    unsigned long long uuidLsb = 0;

    if (!pMigTracking)
        return RM_ERR_INVALID_ARGUMENT;

    UVM_DBG_PRINT_UUID("Entering", pGpuUuidStruct);

    rmStatus = nvUvmInterfaceSessionCreate(&pMigTracking->hSession);
    if (rmStatus != RM_OK)
    {
        UVM_ERR_PRINT("ERROR: could not create a session\n");
        goto cleanup;
    }

    memcpy(&uuidMsb, &pGpuUuidStruct->uuid[0], (UVM_UUID_LEN >> 1));
    memcpy(&uuidLsb, &pGpuUuidStruct->uuid[8], (UVM_UUID_LEN >> 1));
    rmStatus = nvUvmInterfaceAddressSpaceCreateMirrored(
                               pMigTracking->hSession,
                               uuidMsb,
                               uuidLsb,
                               &pMigTracking->hVaSpace);
    if (rmStatus != RM_OK)
    {
        UVM_ERR_PRINT("ERROR: could not create an address space\n");
        goto cleanup_session;
    }

    // Get GPU caps like ECC support on GPU, big page size, small page size etc
    rmStatus = nvUvmInterfaceQueryCaps(pMigTracking->hVaSpace,
                                       &pMigTracking->gpuCaps);

    if (rmStatus != RM_OK)
    {
        UVM_ERR_PRINT("ERROR: could not lookup GPU capabilities\n");
        goto cleanup_address_space;
    }

    rmStatus = nvUvmInterfaceChannelAllocate(pMigTracking->hVaSpace,
                                             &pMigTracking->hChannel,
                                             &pMigTracking->channelInfo);
    if (rmStatus != RM_OK)
    {
        UVM_ERR_PRINT("ERROR: could not allocate a channel\n");
        goto cleanup_address_space;
    }

    // Reset rmStatus, in case there are no loop iterations to set it:
    rmStatus = RM_ERROR;

    for (ceInstance = 1; ceInstance <= MAX_NUM_COPY_ENGINES; ++ceInstance)
    {
        rmStatus = nvUvmInterfaceCopyEngineAllocate(
                                                  pMigTracking->hChannel,
                                                  ceInstance,
                                                  &pMigTracking->ceClassNumber,
                                                  &pMigTracking->hCopyEngine);

        if ((rmStatus == RM_ERR_INVALID_INDEX) || (rmStatus == RM_OK))
            break;
    }

    if (rmStatus != RM_OK)
    {
        UVM_ERR_PRINT("ERROR: could not allocate OBJCE\n");
        goto cleanup_address_space;
    }

    // allocate a semaphore page
    rmStatus = nvUvmInterfaceMemoryAllocSys(pMigTracking->hVaSpace,
                                            SEMAPHORE_SIZE,
                                            &pMigTracking->gpuSemaPtr);
    if (RM_OK != rmStatus)
    {
        UVM_ERR_PRINT("ERROR: could not allocate GPU memory for PB\n");
        goto cleanup_address_space;
    }
    rmStatus = nvUvmInterfaceMemoryCpuMap(pMigTracking->hVaSpace,
                                          pMigTracking->gpuSemaPtr,
                                          SEMAPHORE_SIZE,
                                          &pMigTracking->cpuSemaPtr);
    if (RM_OK != rmStatus)
    {
        UVM_ERR_PRINT("ERROR: could not map PB to CPU VA\n");
        goto cleanup_address_space;
    }

    // allocate a Push Buffer segment
    rmStatus = nvUvmInterfaceMemoryAllocSys(pMigTracking->hVaSpace,
                                            PUSHBUFFER_SIZE,
                                            &pMigTracking->gpuPushBufferPtr);
    if (RM_OK != rmStatus)
    {
        UVM_ERR_PRINT("ERROR: could not allocate GPU memory for PB\n");
        goto cleanup_address_space;
    }
    // Map Push Buffer
    rmStatus = nvUvmInterfaceMemoryCpuMap(pMigTracking->hVaSpace,
                                          pMigTracking->gpuPushBufferPtr,
                                          PUSHBUFFER_SIZE,
                                          &pMigTracking->cpuPushBufferPtr);
    if (RM_OK != rmStatus)
    {
        UVM_ERR_PRINT("ERROR: could not map PB to CPU VA\n");
        goto cleanup_address_space;
    }

    // setup CE Ops
    rmStatus = NvUvmHalInit(pMigTracking->ceClassNumber,
                            pMigTracking->channelInfo.channelClassNum,
                            &pMigTracking->ceOps);

    if (RM_OK != rmStatus)
    {
        UVM_ERR_PRINT("ERROR: could not find a CE HAL to use\n");
        goto cleanup_address_space;
    }

    UVM_DBG_PRINT("Done. channelClassNum: 0x%0x, ceClassNum: 0x%0x\n",
                  pMigTracking->channelInfo.channelClassNum,
                  pMigTracking->ceClassNumber);

    return 0;

cleanup_address_space:
    nvUvmInterfaceAddressSpaceDestroy(pMigTracking->hVaSpace);
cleanup_session:
    nvUvmInterfaceSessionDestroy(pMigTracking->hSession);
cleanup:
    return rmStatus;
}

//
// Locking: you must hold a write lock on the DriverPrivate.uvmPrivLock, before
// calling this routine.
//
static void _destroy_migration_resources(UvmGpuMigrationTracking *pMigTracking)
{
    if (!pMigTracking)
        return;

    UVM_DBG_PRINT("Entering\n");

    // destroy the channel and the engines under it
    if (pMigTracking->hChannel != 0)
        nvUvmInterfaceChannelDestroy(pMigTracking->hChannel);

    if (pMigTracking->hVaSpace != 0)
    {
        nvUvmInterfaceAddressSpaceDestroy(pMigTracking->hVaSpace);
        //
        // TODO: Fix the RM bug where it thinks allocating a bogus session
        // is ok when there is no valid device.
        //
        nvUvmInterfaceSessionDestroy(pMigTracking->hSession);
    }

    UVM_DBG_PRINT("Done\n");

    return;
}

// 
// Locking:
//     1. This routine acquires the g_uvmDriverPrivateTableLock.
//
//     2. This routine acquires the processRecord.uvmPrivLock.
//
void umvlite_destroy_per_process_gpu_resources(UvmGpuUuid *gpuUuidStruct)
{
    struct list_head *pos;
    unsigned index;

    down_read(&g_attached_uuid_lock);
    index = _find_gpu_index(gpuUuidStruct);
    up_read(&g_attached_uuid_lock);

    if (index == UVM_INVALID_HOME_GPU_INDEX)
        return;
     
    down_write(&g_uvmDriverPrivateTableLock);
    list_for_each(pos, &g_uvmDriverPrivateTable)
    {
        
        UvmPerProcessGpuMigs * pMig;
        DriverPrivate *pPriv = list_entry(pos, DriverPrivate, 
                                          driverPrivateNode);
        
        down_write(&pPriv->uvmPrivLock);

        pMig = &pPriv->processRecord.gpuMigs[index];

        if (pMig->migTracker != NULL)
        {

            _destroy_migration_resources(pMig->migTracker);
            kmem_cache_free(g_uvmMigTrackerCache, pMig->migTracker);
            _disconnect_mig_completely(pMig, NULL);
        }

        up_write(&pPriv->uvmPrivLock);
    }
    up_write(&g_uvmDriverPrivateTableLock);
}

//
// Function to check for ECC errors and returns true if an ECC DBE error
// has happened.
//
static RM_STATUS _check_ecc_errors(UvmGpuMigrationTracking *pMigTracker,
                                    NvBool *pIsEccErrorSet)
{
    struct timeval eccErrorStartTime = {0};
    struct timeval eccErrorCurrentTime = {0};
    struct timeval eccTimeout = {0};
    NvBool bEccErrorTimeout = NV_FALSE;
    NvBool bEccIncomingError = NV_FALSE;
    unsigned rmInterruptSet = 0;

    if (!pIsEccErrorSet || !pMigTracker ||
        !(pMigTracker->channelInfo.eccErrorNotifier))
        return RM_ERR_INVALID_ARGUMENT;

    *pIsEccErrorSet = NV_FALSE;

    // Checking for ECC error after semaphore has been released.
    do
    {
        if (!!(rmInterruptSet) && !bEccIncomingError)
        {
            do_gettimeofday(&eccErrorStartTime);
            _set_timeout_in_usec(&eccErrorStartTime, &eccTimeout,
                                 UVM_ECC_ERR_TIMEOUT_USEC);

            //
            // Call RM to service interrupts to make sure we don't loop too much
            // for upcoming ECC interrupt to get reset before checking the 
            // notifier.
            //
            if (RM_OK == nvUvmInterfaceServiceDeviceInterruptsRM(
                    pMigTracker->hChannel))
                bEccIncomingError = NV_TRUE;
        }
        //
        // Read any incoming ECC interrupt. If true, then we need to wait for it
        // to get  reset before we read notifier to make sure it was an ECC
        // interrupt only.
        //
        if (pMigTracker->gpuCaps.eccReadLocation)
        {
            rmInterruptSet = MEM_RD32((NvU8*)pMigTracker->gpuCaps.eccReadLocation +
                                       pMigTracker->gpuCaps.eccOffset);
            rmInterruptSet = rmInterruptSet & pMigTracker->gpuCaps.eccMask;
        }

        //
        // Make sure you have an ECC Interrupt pending and you have taken the
        // current time before checking for timeout else you will end up always
        // getting a timeout.
        //
        if (!!(rmInterruptSet) && (eccErrorStartTime.tv_usec != 0))
        {
            do_gettimeofday(&eccErrorCurrentTime);
            if ((eccErrorCurrentTime.tv_sec > eccTimeout.tv_sec) ||
                ((eccErrorCurrentTime.tv_sec == eccTimeout.tv_sec) &&
                (eccErrorCurrentTime.tv_usec >= eccTimeout.tv_usec)))
            {
                bEccErrorTimeout = NV_TRUE;
            }
        }

    } while (!!(rmInterruptSet) && pMigTracker->channelInfo.eccErrorNotifier &&
             !*(pMigTracker->channelInfo.eccErrorNotifier) &&
             !bEccErrorTimeout);

    // Check if an interrupt is still set and notifier has not been reset.
    if (!!(rmInterruptSet) && pMigTracker->channelInfo.eccErrorNotifier &&
        !*(pMigTracker->channelInfo.eccErrorNotifier))
    {
        // Read interrupt one more and then call slow path check.
        if (pMigTracker->gpuCaps.eccReadLocation)
        {
            rmInterruptSet = MEM_RD32((NvU8*)pMigTracker->gpuCaps.eccReadLocation +
                                      pMigTracker->gpuCaps.eccOffset);
            rmInterruptSet = rmInterruptSet & pMigTracker->gpuCaps.eccMask;
        }

        if (!!(rmInterruptSet))
        {
            nvUvmInterfaceCheckEccErrorSlowpath(pMigTracker->hChannel,
                                                (NvBool *)&bEccIncomingError);

            if (bEccIncomingError)
            {
                *pIsEccErrorSet = NV_TRUE;
                bEccIncomingError = NV_FALSE;
            }

            return RM_OK;
        }
    }

    //
    // If we are here this means interrupt is reset. Just return notifier value
    // as ECC error.
    //
    if (pMigTracker->channelInfo.eccErrorNotifier)
    {
        *pIsEccErrorSet = *(pMigTracker->channelInfo.eccErrorNotifier);
    }

    return RM_OK;
}

//
// This function will enqueue semaphore release and wait for the 
// previously enqueued copies to complete. This will be called
// in both CPU->GPU and GPU->CPU copies.
// 
// Locking: you must hold a write lock on the DriverPrivate.uvmPrivLock, before
// calling this routine.
//
static
RM_STATUS _wait_for_migration_completion(UvmGpuMigrationTracking *pMigTracker,
                                          UvmCommitRecord *pRecord,
                                          UvmGpuPointer pageVirtualAddr,
                                          UvmGpuPointer cpuPhysAddr,
                                          char ** cpuPbPointer,
                                          char * cpuPbEnd,
                                          NvLength * numMethods)
{
    UvmCopyOps *pCopyOps;
    unsigned semaVal = 0;
    NvBool bEccError = NV_FALSE;

    if (!pMigTracker || !pRecord || (pMigTracker->ceOps.launchDma == NULL) ||
       (pMigTracker->ceOps.writeGpEntry == NULL))
        return -EINVAL;

    pCopyOps  = &pMigTracker->ceOps;

    // reset the semaphore payload.
    *(unsigned *)pMigTracker->cpuSemaPtr = 0;

    // push methods to release the semaphore.
    *numMethods += pCopyOps->semaphoreRelease((unsigned **)cpuPbPointer,
                                              (unsigned*)cpuPbEnd,
                                              pMigTracker->gpuSemaPtr,
                                              0xFACEFEED);

    // wrap around gpFifoOffset if needed.
    if (pMigTracker->channelInfo.numGpFifoEntries ==
            pMigTracker->currentGpFifoOffset + 1)
    {
        pMigTracker->currentGpFifoOffset = 0;
    }

    // write the GP entry.
    pCopyOps->writeGpEntry(pMigTracker->channelInfo.gpFifoEntries,
                           pMigTracker->currentGpFifoOffset,
                           pMigTracker->gpuPushBufferPtr,
                           *numMethods);
    // launch the copy.
    NvUvmChannelWriteGpPut(pMigTracker->channelInfo.GPPut,
                           pMigTracker->currentGpFifoOffset+1);
    pMigTracker->currentGpFifoOffset++;

    //
    // spin on the semaphore before returning
    // TODO: consider busy-waiting vs. sleeping, probably depending on copy
    // size.
    //
    UVM_DBG_PRINT_RL("Polling for page migration completion for CPU "
                     "physical-GPU Virtual address: 0x%p - 0x%p\n",
                     (void*)cpuPhysAddr, (void *)pageVirtualAddr);

    semaVal = 0;
    while (semaVal != 0xFACEFEED)
    {
        semaVal = MEM_RD32(pMigTracker->cpuSemaPtr);

        if (fatal_signal_pending(current))
        {
            UVM_ERR_PRINT("Caught a fatal signal, so killing the channel and "
                          "bailing out early\n");
            nvUvmInterfaceKillChannel(pMigTracker->hChannel);
            pRecord->cachedHomeGpuPerProcessIndex = UVM_INVALID_HOME_GPU_INDEX;
            return RM_ERR_SIGNAL_PENDING;
        }

        //
        // If we hit RC error we simply bail out else we will keep looping
        // till we hit copy timeout.
        //
        if (MEM_RD16(&(pMigTracker->channelInfo.errorNotifier->status)) != 0)
        {
            UVM_ERR_PRINT("RC Error detected during page migration for CPU "
                          "physical-GPU Virtual address: 0x%p - 0x%p\n",
                          (void*)cpuPhysAddr, (void *)pageVirtualAddr);

            pRecord->cachedHomeGpuPerProcessIndex = UVM_INVALID_HOME_GPU_INDEX;
            return RM_ERR_RC_ERROR;
        }
        cpu_relax();
    }

    // Handle any ECC error if  ECC is enabled.
    if (pMigTracker->gpuCaps.bEccEnabled)
    {
        _check_ecc_errors(pMigTracker, &bEccError);
        if (bEccError)
        {
            // In case of an ECC error we can't use this GPU for any other work.
            UVM_ERR_PRINT("ECC Error detected during page migration for"
                          " CPU physical-GPU Virtual address: 0x%p - 0x%p\n",
                          (void*)cpuPhysAddr, (void *)pageVirtualAddr);

            pRecord->cachedHomeGpuPerProcessIndex = UVM_INVALID_HOME_GPU_INDEX;
            return RM_ERR_ECC_ERROR;
        }
    }

    return RM_OK;
}

//
// Locking: you must hold a write lock on the DriverPrivate.uvmPrivLock, before
// calling this routine.
//
RM_STATUS migrate_gpu_to_cpu(UvmGpuMigrationTracking *pMigTracker,
                              UvmCommitRecord *pRecord,
                              UvmGpuPointer srcGpuPtr,
                              UvmGpuPointer destCpuPtr,
                              NvLength length)
{
    RM_STATUS rmStatus = RM_OK;
    NvLength numMethods = 0;
    UvmCopyOps *pCopyOps;
    char *cpuPbPointer = NULL;
    char * cpuPbEnd = NULL;
    unsigned srcFlags = NV_UVM_COPY_SRC_LOCATION_FB;
    unsigned destFlags = NV_UVM_COPY_DST_LOCATION_SYSMEM;
    unsigned launchFlags = NV_UVM_COPY_DST_TYPE_PHYSICAL |
                           NV_UVM_COPY_SRC_TYPE_VIRTUAL;

    if (!pMigTracker || !pRecord || (pMigTracker->ceOps.launchDma == NULL))
        return -EINVAL;

    // If any RC or ECC error has happened check it before starting any copy.
    rmStatus = _preexisting_error_on_channel(pMigTracker, pRecord);
    if (rmStatus != RM_OK)
        return rmStatus;

    //
    // Since it's a synchronous copy we can keep reusing the same PB region. We
    // don't need to worry about overlap, etc.
    //
    pCopyOps     = &pMigTracker->ceOps;
    cpuPbPointer = pMigTracker->cpuPushBufferPtr;
    cpuPbEnd     = pMigTracker->cpuPushBufferPtr + PUSHBUFFER_SIZE;

    UVM_DBG_PRINT_RL("Starting. CPU physical address: 0x%p, len: 0x%x\n",
                     (void*)destCpuPtr, (unsigned) length);

    // Push the methods to do the copy.
    numMethods += pCopyOps->launchDma((unsigned **)&cpuPbPointer,
                                      (unsigned *) cpuPbEnd,
                                      srcGpuPtr, srcFlags,
                                      destCpuPtr, destFlags,
                                      length,
                                      launchFlags);

    rmStatus = _wait_for_migration_completion(pMigTracker, pRecord, srcGpuPtr,
                               destCpuPtr, &cpuPbPointer, cpuPbEnd, &numMethods);

    if (rmStatus == RM_OK)
    {
        UVM_DBG_PRINT_RL("done. CPU physical address: 0x%p, len: 0x%x\n",
                         (void*)destCpuPtr, (unsigned) length);
    }

    return rmStatus;
}

//
// Locking: you must hold a write lock on the DriverPrivate.uvmPrivLock, before
// calling this routine.
//
static
RM_STATUS _clear_cache_update_counters(UvmCommitRecord *pRecord,
                                        unsigned long long migratedPages)
{
    UvmPageTracking * pTracking = NULL;
    NvUPtr end;
    NvUPtr pageVirtualAddr;
    unsigned long pageIndex = 0;
    UvmCounterInfo *procPerGpuCounter;

    if (!pRecord)
        return RM_ERR_INVALID_ARGUMENT;

    end = pRecord->baseAddress + pRecord->length;
    //
    // Mark the pages as no longer resident on CPU, by removing their pointer
    // from the array. We do this for all pages irrespective of copy being
    // succeeded.
    //
    for (pageVirtualAddr = pRecord->baseAddress, pageIndex = 0; 
         pageVirtualAddr < end; pageVirtualAddr += PAGE_SIZE, ++pageIndex) 
    {
        pTracking = pRecord->commitRecordPages[pageIndex];
        if (!pTracking)
        {
            // The page is not resident on the CPU, so it doesn't get migrated.
            continue;
        }
        pRecord->commitRecordPages[pageIndex] = NULL;
        uvm_page_cache_free_page(pTracking, __FUNCTION__);
    }

    procPerGpuCounter =
            &pRecord->osPrivate->processRecord.pProcessCounterInfo->
                  procSingleGpuCounterArray[
                            pRecord->cachedHomeGpuPerProcessIndex];
    
    uvm_increment_process_counters(procPerGpuCounter,
        &pRecord->osPrivate->processRecord, UvmCounterNameBytesXferHtD,
        migratedPages * PAGE_SIZE);

    return RM_OK;
}

//
// Locking: you must hold a write lock on the DriverPrivate.uvmPrivLock, before
// calling this routine.
//
static
RM_STATUS _preexisting_error_on_channel(UvmGpuMigrationTracking *pMigTracker,
                                         UvmCommitRecord *pRecord)
{
    if (!pMigTracker || !pRecord)
        return -EINVAL;

    if (pMigTracker->gpuCaps.bEccEnabled &&
        (pMigTracker->channelInfo.eccErrorNotifier) &&
        *(pMigTracker->channelInfo.eccErrorNotifier))
    {
        UVM_ERR_PRINT("ECC Error while starting migration from CPU->GPU\n");

        pRecord->cachedHomeGpuPerProcessIndex = UVM_INVALID_HOME_GPU_INDEX;
        return RM_ERR_ECC_ERROR;
    }

    // Check for a RC notifier before starting any transaction.
    if (pMigTracker->channelInfo.errorNotifier->status != 0)
    {
        UVM_ERR_PRINT("RC Error while starting migration from CPU->GPU\n");

        pRecord->cachedHomeGpuPerProcessIndex = UVM_INVALID_HOME_GPU_INDEX;
        return RM_ERR_RC_ERROR;
    }

    return RM_OK;
}

//
// This function will migrate pages from CPU sysmem to GPU video memory in
// pipelined manner. The CPU pointer is physical and the GPU pointer is virtual.
//
// Locking: you must hold a write lock on the DriverPrivate.uvmPrivLock, before
// calling this routine.
//
// Notes:
//
// 1. Enqueue copying of as many pages as possible(limited by push-buffer size)
// as copy engine supports pipelining and we want to get maximum performance
// from HW.
//
// 2. TODO: handle vma splitting, mismatches between what the vma and pRecord
// have for baseAddress and length.
//
RM_STATUS migrate_cpu_to_gpu(UvmGpuMigrationTracking *pMigTracker,
                              UvmCommitRecord *pRecord,
                              NvLength length)
{
    RM_STATUS rmStatus = RM_OK;
    UvmPageTracking *pTracking = NULL;
    UvmCopyOps *pCopyOps;
    char *cpuPbPointer = NULL;
    char *cpuPbCopyEnd = NULL;
    char *cpuPbEnd = NULL;
    NvUPtr cpuPhysAddr = 0;
    NvUPtr pageVirtualAddr;
    NvUPtr end;
    unsigned long pageIndex = 0;
    unsigned long long migratedPages = 0;
    NvBool bCopyPbFull = NV_FALSE;
    NvLength methods = 0;
    NvLength numMethods = 0;
    unsigned srcFlags = NV_UVM_COPY_SRC_LOCATION_SYSMEM;
    unsigned destFlags = NV_UVM_COPY_DST_LOCATION_FB;
    unsigned launchFlags = NV_UVM_COPY_DST_TYPE_VIRTUAL |
                           NV_UVM_COPY_SRC_TYPE_PHYSICAL;

    if (!pMigTracker || !pRecord || (pMigTracker->ceOps.launchDma == NULL))
        return -EINVAL;

    pCopyOps = &pMigTracker->ceOps;
    cpuPbPointer = pMigTracker->cpuPushBufferPtr;
    cpuPbEnd     = pMigTracker->cpuPushBufferPtr + PUSHBUFFER_SIZE;
    end = pRecord->baseAddress + pRecord->length;

    //
    // Send a dummy Semaphore release to get the size of pushBuffer required
    // for release method. We need to reserve this while pushing copies to make
    // sure we have enough space remaining for pushing semaphore release.
    //
    methods = pCopyOps->semaphoreRelease((unsigned **)&cpuPbPointer,
                                         (unsigned*)cpuPbEnd,
                                         pMigTracker->gpuSemaPtr,
                                         0xFACEFEED);

    // Copy pushBuffer limit should take care of release methods.
    cpuPbPointer = pMigTracker->cpuPushBufferPtr;
    cpuPbCopyEnd = (char *) cpuPbEnd - methods;
    methods = 0;

    for (pageVirtualAddr = pRecord->baseAddress; pageVirtualAddr < end;
         ++pageIndex)
    {
        bCopyPbFull = NV_FALSE;
        pTracking = pRecord->commitRecordPages[pageIndex];
        if (!pTracking)
        {
            // The page is not resident on the CPU, so it doesn't get migrated.
            pageVirtualAddr += PAGE_SIZE;
            continue;
        }

        cpuPhysAddr = page_to_phys(pTracking->uvmPage);

        if (PageDirty(pTracking->uvmPage))
        {
            methods = pCopyOps->launchDma((unsigned **)&cpuPbPointer,
                                          (unsigned *) cpuPbCopyEnd,
                                          (UvmGpuPointer)cpuPhysAddr, srcFlags,
                                          (UvmGpuPointer)pageVirtualAddr,
                                          destFlags, length,
                                          launchFlags);

            numMethods += methods;

            //
            // We didn't enqueue the current page as PB was full, so do not 
            // increment the pageIndex.
            //  
            if (methods == 0)
            {
                bCopyPbFull = NV_TRUE;
                --pageIndex;
            }
            else
                ++migratedPages;

            //
            // If it's not possible to complete all copies with single
            // pushbuffer, then release the semaphore and wait for copy to
            // complete. We will restart if we have more copies left.
            //
            if (bCopyPbFull)
            {
                rmStatus = _wait_for_migration_completion(pMigTracker, pRecord,
                                                (UvmGpuPointer)pageVirtualAddr,
                                                (UvmGpuPointer)cpuPhysAddr,
                                                &cpuPbPointer, cpuPbEnd,
                                                &numMethods);
                if (rmStatus != RM_OK)
                {
                    UVM_DBG_PRINT_RL("Failed to copy from cpu to gpu - vma: "
                                     "0x%p, rmStatus: 0x%0x\n",
                                     pRecord->vma, rmStatus);    
                    break;
                }

                // Reset push buffer pointer to start again from top.
                cpuPbPointer = pMigTracker->cpuPushBufferPtr;
                numMethods = 0;
            }
        }

        // We have enqueued this page, let's move on to next.
        if (!bCopyPbFull)
            pageVirtualAddr += PAGE_SIZE;
    }

    // Trigger completion of all copies which didn't completely fill PB.
    if ((numMethods != 0) && (rmStatus == RM_OK))
    {
        UVM_PANIC_ON(0 == cpuPhysAddr);

        // Change address to current page as we have incremented it above
        pageVirtualAddr -= PAGE_SIZE;
        rmStatus = _wait_for_migration_completion(pMigTracker, pRecord,
                                        (UvmGpuPointer)pageVirtualAddr,
                                        (UvmGpuPointer)cpuPhysAddr,
                                        &cpuPbPointer, cpuPbEnd,
                                        &numMethods);

        if (rmStatus != RM_OK)
            UVM_DBG_PRINT_RL("Failed to copy from cpu to gpu - vma: "
                             "0x%p, rmStatus: 0x%0x\n",
                             pRecord->vma, rmStatus);
    }

    rmStatus = _clear_cache_update_counters(pRecord, migratedPages);
    return rmStatus;
}

//
// Locking: you must hold a write lock on the mmap_sem.
//
static void _set_vma_inaccessible(struct vm_area_struct * vma)
{
    //
    // Disable VM_MAY* to disallow mprotect() from changing the perms.
    // Subsequent access from userspace after the pages are unmapped will cause
    // a SIGSEGV.
    //
    vma->vm_flags &= ~(VM_READ|VM_MAYREAD);
    vma->vm_flags &= ~(VM_WRITE|VM_MAYWRITE);
}

//
// Locking: you must hold a write lock on the mmap_sem.
//
static void _set_vma_accessible(struct vm_area_struct * vma)
{
    vma->vm_flags |= (VM_READ|VM_MAYREAD);
    vma->vm_flags |= (VM_WRITE|VM_MAYWRITE);
}

//
// Locking: you must hold a write lock on the mmap_sem.
//
static void _set_record_accessible(UvmCommitRecord *pRecord)
{
    _set_vma_accessible(pRecord->vma);
}

//
// Locking: you must hold a write lock on the mmap_sem.
//
static void _set_record_inaccessible(UvmCommitRecord *pRecord)
{
    _set_vma_inaccessible(pRecord->vma);
}

//
// Locking: you must hold a read lock on the mmap_sem
// and DriverPrivate.uvmPrivLock.
//
static int _is_record_matching_vma(UvmCommitRecord *pRecord)
{
    if (pRecord->baseAddress != pRecord->vma->vm_start
        || PAGE_ALIGN(pRecord->length) != 
        (pRecord->vma->vm_end - pRecord->vma->vm_start))
    {
        return NV_FALSE;
    }
    return NV_TRUE;
}

//
// returns GPU index of matching record, otherwise a first free index
//
// Locking: you must hold g_attached_uuid_lock before calling this routine 
//
static unsigned _find_gpu_index(UvmGpuUuid *gpuUuidStruct)
{
    unsigned index;
    for (index = 0; index < g_attached_uuid_num; ++index)
    {
        if (memcmp(gpuUuidStruct, &g_attached_uuid_list[index].gpuUuid,
                   sizeof(UvmGpuUuid)) == 0)
        {
            return index;
        }
    }

    return UVM_INVALID_HOME_GPU_INDEX;
}

//
// Locking: you must hold g_attached_uuid_lock before calling this routine 
//
static RM_STATUS _find_or_add_gpu_index(UvmGpuUuid *gpuUuidStruct, 
                                         unsigned *pIndex)
{
    RM_STATUS status;
    NvU32 gpuArch;
    unsigned index = _find_gpu_index(gpuUuidStruct);

    if (index == UVM_INVALID_HOME_GPU_INDEX)
    {
        UVM_PANIC_ON(g_attached_uuid_num >= UVM_MAX_GPUS);
        if (g_attached_uuid_num >= UVM_MAX_GPUS)
            return RM_ERR_INSUFFICIENT_RESOURCES;

        // Fetch this GPU's architecture
        status = nvUvmInterfaceGetGpuArch(gpuUuidStruct->uuid,
                                          UVM_UUID_LEN,
                                          &gpuArch);
        if (status != RM_OK)
            return status;

        index = g_attached_uuid_num;

        memcpy(&g_attached_uuid_list[index].gpuUuid, 
               gpuUuidStruct, sizeof(UvmGpuUuid));

        g_attached_uuid_list[index].gpuArch = gpuArch;

        ++g_attached_uuid_num;
    }
    
    *pIndex = index;
    return RM_OK;

}

RM_STATUS uvmlite_enable_gpu_uuid(UvmGpuUuid *gpuUuidStruct)
{
    RM_STATUS status;
    unsigned index;

    down_write(&g_attached_uuid_lock);
    status = _find_or_add_gpu_index(gpuUuidStruct, &index);
    if (status == RM_OK)
        g_attached_uuid_list[index].isEnabled = NV_TRUE;

    up_write(&g_attached_uuid_lock);

    return status;
}

RM_STATUS uvmlite_disable_gpu_uuid(UvmGpuUuid *gpuUuidStruct)
{
    RM_STATUS status;
    unsigned index;

    down_write(&g_attached_uuid_lock);
    status = _find_or_add_gpu_index(gpuUuidStruct, &index);
    if (status == RM_OK)
        g_attached_uuid_list[index].isEnabled = NV_FALSE;

    up_write(&g_attached_uuid_lock);

    return status;
}

RM_STATUS uvmlite_find_gpu_index(UvmGpuUuid *gpuUuidStruct, unsigned *pIndex)
{
    RM_STATUS status = RM_OK;
    unsigned index;
    down_read(&g_attached_uuid_lock);

    index = _find_gpu_index(gpuUuidStruct);
    if (index == UVM_INVALID_HOME_GPU_INDEX || 
        !g_attached_uuid_list[index].isEnabled)
    {
        index = UVM_INVALID_HOME_GPU_INDEX;
        status = RM_ERR_INVALID_ARGUMENT;
    }

    up_read(&g_attached_uuid_lock);

    *pIndex = index;
    return status;
}

NvBool uvmlite_is_gpu_kepler_and_above(UvmGpuUuid *gpuUuidStruct)
{
    NvU32 gpuIndex;
    NvU32 dGpuArch;

    if (RM_OK == uvmlite_find_gpu_index(gpuUuidStruct, &gpuIndex))
    {
        //
        // Make sure the arch number is kepler or above and smaller
        // than Tegra arch numbers.
        //
        dGpuArch = g_attached_uuid_list[gpuIndex].gpuArch;

        if (dGpuArch >= NV2080_CTRL_MC_ARCH_INFO_ARCHITECTURE_GK100 &&
            dGpuArch < NV2080_CTRL_MC_ARCH_INFO_ARCHITECTURE_T13X)
            return NV_TRUE;
    }

    return NV_FALSE;
}
