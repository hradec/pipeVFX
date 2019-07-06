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

//
// nvidia_uvm_lite.h
//
// This file contains declarations for UVM-Lite code.
//
//

#ifndef _NVIDIA_UVM_LITE_H
#define _NVIDIA_UVM_LITE_H

#include "uvmtypes.h"
#include "uvm_ioctl.h"
#include "nvidia_uvm_linux.h"
#include "rmretval.h"
#include "nvidia_page_migration.h"
#include "nv_uvm_interface.h"

#define NVIDIA_UVM_LITE_MINOR_NUMBER 0

#define UVM_INVALID_HOME_GPU_INDEX     0xDEADBEEF

// Forward declarations:
struct UvmCommitRecord_tag;
struct UvmPerProcessGpuMigs_tag;
struct UvmGpuMigrationTracking_tag;

#define UVM_MAX_STREAMS 256
#define UVM_STREAMS_CACHE_SIZE 1024
#define UVM_MAX_SESSIONS_PER_PROCESS 64

#define UVM_ECC_ERR_TIMEOUT_USEC 100

#define SEMAPHORE_SIZE    4*1024
#define PUSHBUFFER_SIZE   0x4000

#define MEM_RD32(a) (*(const volatile NvU32 *)(a))
#define MEM_RD16(a) (*(const volatile NvU16 *)(a))

// size of counters per gpu / aggregate in bytes
static const unsigned UVM_PER_RESOURCE_COUNTERS_SIZE = PAGE_SIZE;
// size of a single counter in bytes
static const unsigned UVM_COUNTER_SIZE = sizeof (unsigned long long *);
// shift for per process per gpu counters in user mapping.
static const int UVM_PER_PROCESS_PER_GPU_COUNTERS_SHIFT = PAGE_SIZE;

static const uid_t UVM_ROOT_UID = 0;
//
// UVM Counter memory descriptors and users information
//
typedef struct UvmCounterInfo_tag
{
    // physical page *
    struct page *pCounterPage;

    // kernel mapping of above page
    unsigned long long *sysAddr;

    // Number of enabled sessions for each counter
    atomic_t sessionCount[UVM_TOTAL_COUNTERS];

} UvmCounterInfo;

typedef struct UvmProcessCounterInfo_tag
{
    // indexed according to g_attached_uuid_list
    UvmCounterInfo procSingleGpuCounterArray[UVM_MAX_GPUS];
    UvmCounterInfo procAllGpuCounter;
    atomic_t refcountUsers;
} UvmProcessCounterInfo;

//
// This structure saves per session information.
//
typedef struct UvmSessionInfo_tag
{
    unsigned pidSessionOwner;
    unsigned pidTarget;
    //
    // effective user id of referenced processRecord
    // stored for checking privilages
    //
    uid_t euidTarget;
    //
    // user base address for mapping counter pages.
    // First page length address contains per process all gpu counters,
    // others (per process per gpu counters page) are shifted by 1.
    //
    unsigned long mappedUserBaseAddress;
    UvmProcessCounterInfo *pTargetCounterInfo;
} UvmSessionInfo;

//
// UvmPerProcessGpuMigs struct: there is a one-to-one relationship between
// processes that call into the UVM-Lite kernel driver, and this data structure.
//
//
typedef struct UvmPerProcessGpuMigs_tag
{
    struct UvmGpuMigrationTracking_tag * migTracker;
}UvmPerProcessGpuMigs;

typedef struct UvmStreamRecord_tag UvmStreamRecord;

typedef struct UvmProcessRecord_tag
{
    //
    //  TODO:
    //      1. "Non-idle" stream list should be stored here.
    //          This in turns allows all "Regions" associated with this process
    //          to be enumerated. Probably going to be useful for the (shared)
    //          bits of the debug/profiler infrastructure
    //      2. Complete list of all GpuRecords for this process
    //

    // indexed according to g_attached_uuid_list
    UvmPerProcessGpuMigs gpuMigs[UVM_MAX_GPUS];
    UvmProcessCounterInfo *pProcessCounterInfo;
    // effective user id of this process, for security check
    uid_t euid;

    // List of all streams TODO: should probably be moved to a hashmap
    struct list_head allStreamList;
    // Trivial cache storing recently used streams at streamId mod cache size
    UvmStreamRecord *streamsCache[UVM_STREAMS_CACHE_SIZE];

    //
    // Number of streams (other than NO and ALL streams) in the running state
    // Used for tracking when to start/stop the ALL stream
    //
    NvLength runningStreams;
    // Per Process Session array.
    UvmSessionInfo sessionInfoArray[UVM_MAX_SESSIONS_PER_PROCESS];
    // This lock is used to protect sessionInfoArray
    struct rw_semaphore sessionInfoLock;

    unsigned pid;
}UvmProcessRecord;

struct UvmStreamRecord_tag
{
    UvmProcessRecord *processRecord;
    UvmStream streamId;
    NvBool isRunning;
    struct list_head allStreamListNode;
    struct list_head commitRecordsList;
};

typedef struct UvmGpuState_tag
{
    UvmGpuUuid gpuUuid;
    NvBool isEnabled;
    NvU32 gpuArch;
}UvmGpuState;

//
//  Tracks committed regions of memory
//
typedef struct UvmCommitRecord_tag
{
    //
    // Invariant: The home GPU might stop running, or get an RC recovery that
    // kills the channel that this commit record uses. However, the home GPU's
    // identity will not change.
    //
    // As it turns out, all we actually need is the UUID of this home GPU.
    //
    UvmGpuUuid homeGpuUuid; // GPU that owns the allocation

    //
    // This is used to index into UvmProcessRecord.gpuMigs[].  Allowed values
    // are:
    //
    //     1. Zero through (UVM_MAX_GPUS-1)
    //
    //     2. UVM_INVALID_HOME_GPU_INDEX
    //
    // If it is UVM_INVALID_HOME_GPU_INDEX, then it must not be used.
    //
    unsigned         cachedHomeGpuPerProcessIndex;

    NvUPtr           baseAddress;   // immutable, must be page aligned
    NvLength         length;        // immutable, must be page aligned

    // This flag is used to indicate that at least one page in the record
    // is mapped for CPU access
    NvBool isMapped;

    struct DriverPrivate_tag * osPrivate;
    struct vm_area_struct * vma;
    struct UvmPageTracking_tag ** commitRecordPages;

    UvmStreamRecord * pStream;
    struct list_head streamRegionsListNode;
}UvmCommitRecord;

typedef struct DriverPrivate_tag
{
    struct list_head       pageList;
    UvmProcessRecord  processRecord;
    struct rw_semaphore    uvmPrivLock;
    struct file            *privFile;
    // Entry in g_uvmDriverPrivateTable
    struct list_head       driverPrivateNode;
}DriverPrivate;

//
// These are the UVM datastructures that we need. This should be allocated
// per-process, per-GPU, when setting up a new channel for a process during the
// first call to UvmRegionCommit.
//
typedef struct UvmGpuMigrationTracking_tag
{
    uvmGpuSessionHandle      hSession;
    uvmGpuAddressSpaceHandle hVaSpace;
    uvmGpuChannelHandle      hChannel;
    uvmGpuCopyEngineHandle   hCopyEngine;
    unsigned                 ceClassNumber;
    UvmGpuChannelPointers    channelInfo;
    UvmCopyOps               ceOps;
    UvmGpuCaps               gpuCaps;

    // per channel allocations
    // pushbuffer
    UvmGpuPointer            gpuPushBufferPtr;
    void                    *cpuPushBufferPtr;
    unsigned                 currentPbOffset;
    unsigned                 currentGpFifoOffset;
    // semaphore
    UvmGpuPointer            gpuSemaPtr;
    void                    *cpuSemaPtr;
    // need to add a lock per push buffer
}UvmGpuMigrationTracking;

RM_STATUS migrate_gpu_to_cpu(UvmGpuMigrationTracking *pMigTracker,
                              UvmCommitRecord *pRecord,
                              UvmGpuPointer srcGpuPtr,
                              UvmGpuPointer destCpuPtr,
                              NvLength length);

RM_STATUS migrate_cpu_to_gpu(UvmGpuMigrationTracking *pMigTracker,
                              UvmCommitRecord *pRecord,
                              NvLength length);

struct file;

//
//
// UVM-Lite char driver entry points:
//
int uvmlite_init(dev_t uvmBaseDev);
void uvmlite_exit(void);
int uvmlite_setup_gpu_list(void);

RM_STATUS uvmlite_set_stream_running(DriverPrivate* pPriv, UvmStream streamId);
RM_STATUS uvmlite_set_streams_stopped(DriverPrivate* pPriv,
                                      UvmStream * streamIdArray,
                                      NvLength nStreams);
RM_STATUS uvmlite_region_set_stream(UvmCommitRecord *pRecord,
    UvmStream streamId);
RM_STATUS uvmlite_migrate_to_gpu(unsigned long long baseAddress,
                                  NvLength length,
                                  unsigned migrateFlags,
                                  struct vm_area_struct *vma,
                                  UvmCommitRecord * pRecord);
//
// UVM-Lite core functionality:
//
UvmCommitRecord *
uvmlite_create_commit_record(unsigned long long  requestedBase,
                             unsigned long long  length,
                             DriverPrivate *pPriv,
                             struct vm_area_struct *vma);

RM_STATUS uvmlite_update_commit_record(UvmCommitRecord *pRecord,
                                       UvmStream streamId,
                                       UvmGpuUuid *pUuid,
                                       DriverPrivate *pPriv);
//
// UVM-Lite page cache:
//
typedef struct UvmPageTracking_tag
{
    struct page *uvmPage;
    struct list_head pageListNode;
}UvmPageTracking;

int uvm_page_cache_init(void);
void uvm_page_cache_destroy(void);

UvmPageTracking * uvm_page_cache_alloc_page(DriverPrivate* pPriv);
void uvm_page_cache_free_page(UvmPageTracking *pTracking, const char *caller);
void uvm_page_cache_verify_page_list_empty(DriverPrivate* pPriv,
                                           const char * caller);
//
// UVM-Lite outer layer: UVM API calls that are issued via ioctl() call:
//
RM_STATUS uvm_api_reserve_va(UVM_RESERVE_VA_PARAMS *pParams, struct file *filp);
RM_STATUS uvm_api_release_va(UVM_RELEASE_VA_PARAMS *pParams, struct file *filp);
RM_STATUS uvm_api_region_commit(UVM_REGION_COMMIT_PARAMS *pParams,
                               struct file *filp);
RM_STATUS uvm_api_region_decommit(UVM_REGION_DECOMMIT_PARAMS *pParams,
                                 struct file *filp);
RM_STATUS uvm_api_region_set_stream(UVM_REGION_SET_STREAM_PARAMS *pParams,
                                  struct file *filp);
RM_STATUS uvm_api_region_set_stream_running(UVM_SET_STREAM_RUNNING_PARAMS *pParams,
                                   struct file *filp);
RM_STATUS uvm_api_region_set_stream_stopped(UVM_SET_STREAM_STOPPED_PARAMS *pParams,
                                   struct file *filp);
RM_STATUS uvm_api_migrate_to_gpu(UVM_MIGRATE_TO_GPU_PARAMS *pParams,
                               struct file *filp);
#if defined (DEBUG)
RM_STATUS uvm_api_run_test(UVM_RUN_TEST_PARAMS *pParams, struct file *filp);
#endif
RM_STATUS uvm_api_add_session(UVM_ADD_SESSION_PARAMS *pParams,
                             struct file *filp);
RM_STATUS uvm_api_remove_session(UVM_REMOVE_SESSION_PARAMS *pParams,
                                struct file *filp);
RM_STATUS uvm_api_enable_counters(UVM_ENABLE_COUNTERS_PARAMS *pParams,
                                 struct file *filp);
RM_STATUS uvm_api_map_counter(UVM_MAP_COUNTER_PARAMS *pParams,
                             struct file *filp);
//
// UVM-Lite counters routines
//
UvmProcessCounterInfo *
uvmlite_get_and_refcount_process_counter_info(UvmProcessRecord *pProcessRecord);

void uvmlite_put_and_unrefcount_process_counter_info
(
    UvmProcessCounterInfo *pProcessCounterInfo
);

RM_STATUS uvmlite_init_process_counters(UvmProcessRecord *pRecord);

void uvmlite_free_process_counters(UvmProcessCounterInfo *pProcCounterInfo);

RM_STATUS uvmlite_secure_get_process_counter_info(unsigned pidTarget,
     UvmProcessCounterInfo **ppProcessCounterInfo, uid_t *pEuid);

void umvlite_destroy_per_process_gpu_resources(UvmGpuUuid *gpuUuidStruct);

RM_STATUS uvmlite_gpu_event_start_device(UvmGpuUuid *gpuUuidStruct);
RM_STATUS uvmlite_gpu_event_stop_device(UvmGpuUuid *gpuUuidStruct);

RM_STATUS uvmlite_find_gpu_index(UvmGpuUuid *gpuUuidStruct, unsigned *pIndex);

RM_STATUS uvmlite_enable_gpu_uuid(UvmGpuUuid *gpuUuidStruct);

RM_STATUS uvmlite_disable_gpu_uuid(UvmGpuUuid *gpuUuidStruct);

NvBool uvmlite_is_gpu_kepler_and_above(UvmGpuUuid *gpuUuidStruct);

#endif // _NVIDIA_UVM_LITE_H
