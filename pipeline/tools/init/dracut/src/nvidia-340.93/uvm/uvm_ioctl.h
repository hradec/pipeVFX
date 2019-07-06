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

#ifndef _UVM_IOCTL_H
#define _UVM_IOCTL_H

#include "uvm.h"
#include "uvmtypes.h"
#include "uvm-debug.h"

#ifdef __cplusplus
extern "C" {
#endif

//
// Please see the header file (uvm.h) for detailed documentation on each of the
// associated API calls.
//

#if defined(WIN32) || defined(WIN64)
#   define UVM_IOCTL_BASE(i)       CTL_CODE(FILE_DEVICE_UNKNOWN, 0x800+i, METHOD_BUFFERED, FILE_READ_DATA | FILE_WRITE_DATA)
#else
#   define UVM_IOCTL_BASE(i) i
#endif

//
// UvmReserveVA
//
#define UVM_RESERVE_VA                                                UVM_IOCTL_BASE(1)

typedef struct
{
    unsigned long long  requestedBase; // IN
    unsigned long long  length;        // IN
    RM_STATUS          rmStatus;     // OUT
} UVM_RESERVE_VA_PARAMS;

//
// UvmReleaseVA
//
#define UVM_RELEASE_VA                                                UVM_IOCTL_BASE(2)

typedef struct
{
    unsigned long long  requestedBase; // IN
    unsigned long long  length;        // IN
    RM_STATUS          rmStatus;     // OUT
} UVM_RELEASE_VA_PARAMS;

//
// UvmRegionCommit
//
#define UVM_REGION_COMMIT                                             UVM_IOCTL_BASE(3)

typedef struct
{
    unsigned long long  requestedBase; // IN
    unsigned long long  length;        // IN
    UvmStream           streamId;      // IN
    UvmGpuUuid          gpuUuid;       // IN
    RM_STATUS          rmStatus;     // OUT
} UVM_REGION_COMMIT_PARAMS;

//
// UvmRegionDecommit
//
#define UVM_REGION_DECOMMIT                                           UVM_IOCTL_BASE(4)

typedef struct
{
    unsigned long long  requestedBase; // IN
    unsigned long long  length;        // IN
    RM_STATUS          rmStatus;     // OUT
} UVM_REGION_DECOMMIT_PARAMS;

//
// UvmRegionSetStream
//
#define UVM_REGION_SET_STREAM                                         UVM_IOCTL_BASE(5)

typedef struct
{
    unsigned long long  requestedBase; // IN
    unsigned long long  length;        // IN
    UvmStream           newStreamId;   // IN
    UvmGpuUuid          gpuUuid;       // IN
    RM_STATUS          rmStatus;     // OUT
} UVM_REGION_SET_STREAM_PARAMS;

//
// UvmSetStreamRunning
//
#define UVM_SET_STREAM_RUNNING                                        UVM_IOCTL_BASE(6)

typedef struct
{
    UvmStream          streamId;  // IN
    RM_STATUS         rmStatus; // OUT
} UVM_SET_STREAM_RUNNING_PARAMS;


//
// Due to limitations in how much we want to send per ioctl call, the nStreams
// member must be less than or equal to about 250. That's an upper limit.
//
// However, from a typical user-space driver's point of view (for example, the
// CUDA driver), a vast majority of the time, we expect there to be only one
// stream passed in. The second most common case is something like atmost 32
// streams being passed in. The cases where there are more than 32 streams are
// the most rare. So we might want to optimize the ioctls accordingly so that we
// don't always copy a 250 * sizeof(streamID) sized array when there's only one
// or a few streams.
//
// For that reason, UVM_MAX_STREAMS_PER_IOCTL_CALL is set to 32.
//
// If the higher-level (uvm.h) call requires more streams to be stopped than
// this value, then multiple ioctl calls should be made.
//
#define UVM_MAX_STREAMS_PER_IOCTL_CALL 32

//
// UvmSetStreamStopped
//
#define UVM_SET_STREAM_STOPPED                                        UVM_IOCTL_BASE(7)

typedef struct
{
    UvmStream    streamIdArray[UVM_MAX_STREAMS_PER_IOCTL_CALL];  // IN
    NvLength     nStreams;  // IN
    RM_STATUS   rmStatus; // OUT
} UVM_SET_STREAM_STOPPED_PARAMS;

//
// UvmMigrateToGpu
//
#define UVM_MIGRATE_TO_GPU                                            UVM_IOCTL_BASE(8)

typedef struct
{
    unsigned long long  requestedBase; // IN
    unsigned long long  length;        // IN
    UvmGpuUuid          gpuUuid;       // IN
    unsigned            flags;         // IN
    RM_STATUS          rmStatus;     // OUT
} UVM_MIGRATE_TO_GPU_PARAMS;

//
// UvmCallTestFunction
//
#define UVM_RUN_TEST                                                  UVM_IOCTL_BASE(9)

typedef struct
{
    UvmGpuUuid         gpuUuid;    // IN
    unsigned           testNumber; // IN
    RM_STATUS         rmStatus;  // OUT
} UVM_RUN_TEST_PARAMS;

//
// This is a magic offset for mmap. Any mapping of an offset above this 
// threshold will be treated as a counters mapping, not as an allocation 
// mapping. Since allocation offsets must be identical to the virtual address 
// of the mapping, this threshold has to be an offset that cannot be 
// a valid virtual address.
//
#if defined(__linux__)
    #if defined(NV_64_BITS)
        #define UVM_COUNTERS_OFFSET_BASE (1UL << 62)
    #else
        #define UVM_COUNTERS_OFFSET_BASE (1UL << 30)
    #endif
#endif // defined(__linux___)

//
// UvmAddSession
//
#define UVM_ADD_SESSION                                               UVM_IOCTL_BASE(10)

typedef struct
{
    unsigned            pidTarget;           // IN
#ifdef __linux__
    NvP64               countersBaseAddress NV_ALIGN_BYTES(8); // IN
#endif
    int                 sessionIndex;        // OUT (session index that got added)
    RM_STATUS          rmStatus;           // OUT
} UVM_ADD_SESSION_PARAMS;

//
// UvmRemoveSession
//
#define UVM_REMOVE_SESSION                                             UVM_IOCTL_BASE(11)

typedef struct
{
    int                 sessionIndex;   // IN (session index to be removed)
    RM_STATUS          rmStatus;      // OUT
} UVM_REMOVE_SESSION_PARAMS;


#define UVM_MAX_COUNTERS_PER_IOCTL_CALL 32

//
// UvmEnableCounters
//
#define UVM_ENABLE_COUNTERS                                           UVM_IOCTL_BASE(12)

typedef struct
{

    int                 sessionIndex;                               // IN
    UvmCounterConfig    config[UVM_MAX_COUNTERS_PER_IOCTL_CALL];    // IN
    unsigned            count;                                      // IN
    RM_STATUS          rmStatus;                                  // OUT
} UVM_ENABLE_COUNTERS_PARAMS;

//
// UvmMapCounter
//
#define UVM_MAP_COUNTER                                               UVM_IOCTL_BASE(13)

typedef struct
{
    int                 sessionIndex;   // IN
    UvmCounterScope     scope;          // IN
    UvmCounterName      counterName;    // IN
    UvmGpuUuid          gpuUuid;        // IN
    NvP64               addr    NV_ALIGN_BYTES(8); // OUT
    RM_STATUS          rmStatus;      // OUT
} UVM_MAP_COUNTER_PARAMS;

#ifdef __cplusplus
}
#endif

#endif // _UVM_IOCTL_H
