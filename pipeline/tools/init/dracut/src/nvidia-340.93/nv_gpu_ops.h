/* _NVRM_COPYRIGHT_BEGIN_
 *
 * Copyright 2013 by NVIDIA Corporation.  All rights reserved.  All
 * information contained herein is proprietary and confidential to NVIDIA
 * Corporation.  Any use, reproduction, or disclosure without the written
 * permission of NVIDIA Corporation is prohibited.
 *
 * _NVRM_COPYRIGHT_END_
 */


/*
 * nv_gpu_ops.h
 *
 * This file defines the interface between the common RM layer
 * and the OS specific platform layers. (Currently supported 
 * are Linux and KMD)
 *
 */

#ifndef _NV_GPU_OPS_H_
#define _NV_GPU_OPS_H_
#include "nvgputypes.h"

typedef struct gpuSession      *gpuSessionHandle;
typedef struct gpuAddressSpace *gpuAddressSpaceHandle;
typedef struct gpuChannel      *gpuChannelHandle;
typedef struct gpuObject       *gpuObjectHandle;

struct gpuChannelInfo 
{
   volatile unsigned * GPGet;
   volatile unsigned * GPPut;
   NvU64*   gpFifoEntries;
   unsigned numGpFifoEntries;   
   unsigned channelClassNum;
   NvNotification * errorNotifier;
   NvBool *eccErrorNotifier;
} ;

struct gpuCaps {
    unsigned largePageSize;
    unsigned smallPageSize;
    unsigned eccMask;
    unsigned eccOffset;
    void   * eccReadLocation;
    unsigned pcieSpeed;
    unsigned pcieWidth;
    NvBool   bEccEnabled;
};

RM_STATUS nvGpuOpsCreateSession(gpuSessionHandle *session);

void nvGpuOpsDestroySession(gpuSessionHandle session);

RM_STATUS nvGpuOpsAddressSpaceCreate(gpuSessionHandle session,
                                     unsigned long long uuidMsb, 
                                     unsigned long long uuidLsb, 
                                     gpuAddressSpaceHandle *vaSpace);

RM_STATUS nvGpuOpsAddressSpaceCreateMirrored(gpuSessionHandle session,
                                     unsigned long long uuidMsb, 
                                     unsigned long long uuidLsb, 
                                     gpuAddressSpaceHandle *vaSpace);

RM_STATUS nvGpuOpsAddressSpaceDestroy(gpuAddressSpaceHandle vaSpace);

RM_STATUS nvGpuOpsMemoryAllocFb (gpuAddressSpaceHandle vaSpace,
    NvLength length, NvU64 *gpuOffset);

RM_STATUS nvGpuOpsMemoryAllocSys (gpuAddressSpaceHandle vaSpace,
    NvLength length, NvU64 *gpuOffset);

RM_STATUS nvGpuOpsChannelAllocate(gpuAddressSpaceHandle vaSpace,
    gpuChannelHandle  *channelHandle, struct gpuChannelInfo *channelInfo);

void nvGpuOpsChannelDestroy(struct gpuChannel *channel);

void nvGpuOpsMemoryFree(gpuAddressSpaceHandle vaSpace,
     NvU64 pointer);

RM_STATUS  nvGpuOpsMemoryCpuMap(gpuAddressSpaceHandle vaSpace,
                      NvU64 memory, NvLength length,  void **cpuPtr);

void nvGpuOpsMemoryCpuUnMap(gpuAddressSpaceHandle vaSpace,
     void* cpuPtr);

RM_STATUS nvGpuOpsCopyEngineAllocate(gpuChannelHandle channel,
          unsigned ceIndex, unsigned *class, gpuObjectHandle *copyEngineHandle);

RM_STATUS nvGpuOpsQueryCaps(struct gpuAddressSpace *vaSpace,
                            struct gpuCaps *caps);

const char  *nvGpuOpsChannelTranslateError(unsigned info32);


RM_STATUS nvGpuOpsGetHandles(unsigned hClient, unsigned hDevice, unsigned hSubDevice,
                                    struct gpuSession **session, 
                                    struct gpuAddressSpace **vaSpace);

void nvGpuOpsDestroyHandles(struct gpuSession *session,
                            struct gpuAddressSpace *vaSpace);

RM_STATUS nvGpuOpsDupAllocation(unsigned hPhysHandle, 
                                struct gpuAddressSpace *sourceVaspace, 
                                NvU64 sourceAddress,
                                struct gpuAddressSpace *destVaspace,
                                NvU64 *destAddress);
                                
RM_STATUS nvGpuOpsGetGuid(unsigned hClient, unsigned hDevice, 
                          unsigned hSubDevice, NvU8 *gpuGuid, 
                          unsigned guidLength);
                          
RM_STATUS nvGpuOpsGetClientInfoFromPid(unsigned pid, NvU8 *gpuUuid, 
                                       unsigned *hClient, 
                                       unsigned *hDevice,
                                       unsigned *hSubDevice);      

RM_STATUS nvGpuOpsFreeDupedHandle(struct gpuAddressSpace *sourceVaspace,
                                  unsigned hPhysHandle);

RM_STATUS nvGpuOpsFreeOpsHandle(struct gpuSession *session,
                                struct gpuAddressSpace *vaSpace);

RM_STATUS nvGpuOpsGpuMallocWithHandles(struct gpuAddressSpace * vaSpace, unsigned physHandle, 
                                       NvLength length, NvU64 *gpuOffset, void **cpuPtr);

RM_STATUS nvGpuOpsGetAttachedGpus(NvU8 *guidList, unsigned *numGpus);

RM_STATUS nvGpuOpsGetGpuArch(NvU8 *pUuid, unsigned uuidLength, NvU32 *pGpuArch);

RM_STATUS nvGpuOpsServiceDeviceInterruptsRM(struct gpuChannel *channel);

RM_STATUS nvGpuOpsCheckEccErrorSlowpath(struct gpuChannel * channel, NvBool *bEccDbeSet);

RM_STATUS nvGpuOpsKillChannel(struct gpuChannel * channel);

#endif /* _NV_GPU_OPS_H_*/
