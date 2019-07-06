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

#ifndef _NV_KERNEL_H_
#define _NV_KERNEL_H_
#include "uvmtypes.h"
#include "nvgputypes.h"
#ifdef __cplusplus
extern "C" {
#endif

typedef unsigned long long GpuPointer;

typedef struct nvKernelSession *nvKernelSessionHandle;
typedef struct nvKernelVASpace *nvKernelVASpaceHandle;
typedef struct nvKernelChannel *nvKernelChannelHandle;
typedef struct nvKernelObject  *nvKernelCopyEngineHandle;

//
// Session Creation
//
typedef RM_STATUS  (*nvKernelSessionCreate_t)(nvKernelSessionHandle *session);

//
// Create Virtual address space on a particular GPU
// VASpace is virtual address space
//
typedef RM_STATUS (*nvKernelVASpaceCreate_t)(nvKernelSessionHandle session,
                    UvmGpuGuid *gpuGuid, nvKernelVASpaceHandle *vaSpace);
typedef void       (*nvKernelVASpaceDestroy_t)(nvKernelVASpaceHandle vaSpace);

//
// VA range mirroring interfaces
//
typedef RM_STATUS (*nvKernelGetVARangeMirroringGranularity_t)(unsigned *mirroringSize);
typedef RM_STATUS (*nvKernelCreateVARangeMirroring_t)(nvKernelVASpaceHandle srcVaspace,
                   unsigned srcBaseOffset, nvKernelVASpaceHandle targetVASpace,
                   unsigned targetBaseOffset);
typedef RM_STATUS (*nvKernelImportHandles_t)(unsigned hClient, unsigned hDevice,
                    unsigned hVaspace, nvKernelVASpaceHandle *vaSpace);


//
// Memory Allocation routines
//
typedef RM_STATUS (*nvKernelMemoryAllocFB_t) (nvKernelVASpaceHandle vaSpace,
                    unsigned long long length, void **mapping, GpuPointer vaOffset);
typedef RM_STATUS (*nvKernelMemoryAllocSys_t)(nvKernelVASpaceHandle vaSpace,
                    unsigned long long length, void **mapping, GpuPointer vaOffset);
typedef void       (*nvKernelMemoryFree_t)(nvKernelVASpaceHandle vaSpace,
                    GpuPointer pointer);
typedef RM_STATUS (*nvKernelMemoryCPUMap_t)(nvKernelVASpaceHandle vaSpace,
                    GpuPointer fromPointer, NvLength length, void *cpuPtr);
typedef void       (*nvKernelMemoryCPUUnmap_t)(nvKernelVASpaceHandle vaSpace,
                    GpuPointer pointer);

//
// Channel encapsulation (GPFIFO)
// Do we want to pass a callback for the error notifier?
//
typedef RM_STATUS  (*nvKernelChannelAllocate_t)(nvKernelVASpaceHandle  vaSpace,
                     nvKernelChannelHandle *channel);

//
//  These methods return the mapped registers for the channel
//
typedef RM_STATUS  (*nvKernelChannelGPGet_t)(nvKernelChannelHandle channel,
                     unsigned *gpGetPtr);
typedef RM_STATUS  (*nvKernelChannelGPPut_t)(nvKernelChannelHandle channel,
                     unsigned *gpPutPtr);
typedef RM_STATUS  (*nvKernelChannelErrorNotifier_t)
                    (nvKernelChannelHandle channel, NvNotification* notifier);
typedef const char* (*nvKernelChannelTranslateError_t)(unsigned info32);

//
// Copy Engine Object
//
typedef RM_STATUS  (*nvKernelCopyEngineAllocate_t)(
                     nvKernelChannelHandle channel,
                     unsigned indexStartingAtOne,
                     nvKernelCopyEngineHandle *copyEngine);

typedef enum
{
    NvKernelMemoryPhysicalGPU,
    NvKernelMemoryPhysicalCPU,
    NvKernelMemoryVirtual
} NvKernelMemoryType;

//
// Table of function pointers exported by the GPU driver
//

struct NvKernelOperations
{
    nvKernelSessionCreate_t                  sessionCreate;
    nvKernelVASpaceCreate_t                  addressSpaceCreate;
    nvKernelVASpaceDestroy_t                 addressSpaceDestroy;
    nvKernelMemoryAllocFB_t                  allocFB;
    nvKernelMemoryAllocSys_t                 allocSys;
    nvKernelMemoryCPUMap_t                   cpuMap;
    nvKernelMemoryCPUUnmap_t                 cpuUnmap;
    nvKernelChannelAllocate_t                channelAllocate;
    nvKernelChannelGPGet_t                   channelGPGet;
    nvKernelChannelGPPut_t                   channelGPPut;
    nvKernelChannelErrorNotifier_t           channelErrorNotififer;
    nvKernelChannelTranslateError_t          channelTranslateError;
    nvKernelGetVARangeMirroringGranularity_t getVARangeMirroringGranularity;
    nvKernelCreateVARangeMirroring_t         createVARangeMirroring;
    nvKernelImportHandles_t                  importHandles;
};

struct nvUvmOperations
{
    void (*dummy)(void);
};

//
// Regsiter the Kernel operations provided
//
RM_STATUS nvRegisterKernelOperations(struct NvKernelOperations *nvKernelOps,
                                      struct nvUvmOperations *nvUvmOps);

#ifdef __cplusplus
}
#endif

#endif // _NV_KERNEL_H_
