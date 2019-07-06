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
 * This file sets up the communication between the UVM driver and RM. RM will
 * call the UVM driver providing to it the set of OPS it supports.  UVM will
 * then return by filling out the structure with the callbacks it supports.
 */

#define  __NO_VERSION__

#include "nv-misc.h"
#include "os-interface.h"
#include "nv-linux.h"

#if defined(NV_UVM_ENABLE) || defined(NV_UVM_NEXT_ENABLE)

#include "nv_uvm_interface.h"
#include "nv_gpu_ops.h"

struct UvmOpsUvmEvents   *g_pNvUvmEvents = NULL;

//
// TODO: (Bug 1349097) move these UVM_* definitions out to UVM. UVM should do
// its own translation of RM error codes. It makes no sense to make RM translate
// error codes, because it shouldn't have to know the error code system of
// whatever system is calling it.
//

RM_STATUS nvUvmInterfaceSessionCreate(uvmGpuSessionHandle *session)
{
    nv_stack_t *sp = NULL;
    RM_STATUS status;

    NV_KMEM_CACHE_ALLOC_STACK(sp);
    if (sp == NULL)
        return RM_ERR_INVALID_ARGUMENT;

    status = rm_gpu_ops_create_session(sp, (gpuSessionHandle *)session);

    NV_KMEM_CACHE_FREE_STACK(sp);
    return status;
}
EXPORT_SYMBOL(nvUvmInterfaceSessionCreate);

RM_STATUS nvUvmInterfaceSessionDestroy(uvmGpuSessionHandle session)
{
    nv_stack_t *sp = NULL;
    RM_STATUS status;

    NV_KMEM_CACHE_ALLOC_STACK(sp);
    if (sp == NULL)
        return RM_ERROR;

    status = rm_gpu_ops_destroy_session(sp, (gpuSessionHandle)session);

    NV_KMEM_CACHE_FREE_STACK(sp);
    return status;
}
EXPORT_SYMBOL(nvUvmInterfaceSessionDestroy);

RM_STATUS nvUvmInterfaceAddressSpaceCreateMirrored(uvmGpuSessionHandle session,
                                             unsigned long long uuidMsb,
                                             unsigned long long uuidLsb,
                                             uvmGpuAddressSpaceHandle *vaSpace)
{
    nv_stack_t *sp = NULL;
    RM_STATUS status;

    NV_KMEM_CACHE_ALLOC_STACK(sp);
    if (sp == NULL)
        return RM_ERROR;

    status = rm_gpu_ops_address_space_create_mirrored(
             sp, (gpuSessionHandle)session,
             uuidMsb, uuidLsb, (gpuAddressSpaceHandle *)vaSpace);

    NV_KMEM_CACHE_FREE_STACK(sp);
    return status;
}
EXPORT_SYMBOL(nvUvmInterfaceAddressSpaceCreateMirrored);

RM_STATUS nvUvmInterfaceAddressSpaceCreate(uvmGpuSessionHandle session,
                                            unsigned long long uuidMsb,
                                            unsigned long long uuidLsb,
                                            uvmGpuAddressSpaceHandle *vaSpace)
{
    nv_stack_t *sp = NULL;
    RM_STATUS status;

    NV_KMEM_CACHE_ALLOC_STACK(sp);
    if (sp == NULL)
        return RM_ERROR;

    status = rm_gpu_ops_address_space_create(
             sp, (gpuSessionHandle)session,
             uuidMsb, uuidLsb, (gpuAddressSpaceHandle *)vaSpace);

    NV_KMEM_CACHE_FREE_STACK(sp);
    return status;
}
EXPORT_SYMBOL(nvUvmInterfaceAddressSpaceCreate);

void nvUvmInterfaceAddressSpaceDestroy(uvmGpuAddressSpaceHandle vaSpace)
{
    nv_stack_t *sp = NULL;

    NV_KMEM_CACHE_ALLOC_STACK(sp);
    if (sp == NULL)
        return;

    rm_gpu_ops_address_space_destroy(
        sp, (gpuAddressSpaceHandle)vaSpace);

    NV_KMEM_CACHE_FREE_STACK(sp);
    return;
}
EXPORT_SYMBOL(nvUvmInterfaceAddressSpaceDestroy);

RM_STATUS nvUvmInterfaceMemoryAllocFB(uvmGpuAddressSpaceHandle vaSpace,
                    NvLength length, UvmGpuPointer * gpuPointer)
{
    nv_stack_t *sp = NULL;
    RM_STATUS status;

    NV_KMEM_CACHE_ALLOC_STACK(sp);
    if (sp == NULL)
        return RM_ERROR;

    status = rm_gpu_ops_memory_alloc_fb(
             sp, (gpuAddressSpaceHandle)vaSpace,
             (NvLength)length, (NvU64 *) gpuPointer);

    NV_KMEM_CACHE_FREE_STACK(sp);
    return status;
}
EXPORT_SYMBOL(nvUvmInterfaceMemoryAllocFB);

RM_STATUS nvUvmInterfaceMemoryAllocSys(uvmGpuAddressSpaceHandle vaSpace,
                    NvLength length, UvmGpuPointer * gpuPointer)
{
    nv_stack_t *sp = NULL;
    RM_STATUS status;

    NV_KMEM_CACHE_ALLOC_STACK(sp);
    if (sp == NULL)
        return RM_ERROR;

    status = rm_gpu_ops_memory_alloc_sys(
             sp, (gpuAddressSpaceHandle)vaSpace,
             (NvLength)length, (NvU64 *) gpuPointer);

    NV_KMEM_CACHE_FREE_STACK(sp);
    return status;
}
EXPORT_SYMBOL(nvUvmInterfaceMemoryAllocSys);

void nvUvmInterfaceMemoryFree(uvmGpuAddressSpaceHandle vaSpace,
                    UvmGpuPointer gpuPointer)
{
    nv_stack_t *sp = NULL;
    RM_STATUS status;

    NV_KMEM_CACHE_ALLOC_STACK(sp);
    if (sp == NULL)
        return;

    status = rm_gpu_ops_memory_free(
             sp, (gpuAddressSpaceHandle)vaSpace,
             (NvU64) gpuPointer);

    NV_KMEM_CACHE_FREE_STACK(sp);
    return;
}
EXPORT_SYMBOL(nvUvmInterfaceMemoryFree);

RM_STATUS nvUvmInterfaceMemoryCpuMap(uvmGpuAddressSpaceHandle vaSpace,
           UvmGpuPointer gpuPointer, NvLength length, void **cpuPtr)
{
    nv_stack_t *sp = NULL;
    RM_STATUS status;

    NV_KMEM_CACHE_ALLOC_STACK(sp);
    if (sp == NULL)
        return RM_ERROR;

    status = rm_gpu_ops_memory_cpu_map(
             sp, (gpuAddressSpaceHandle)vaSpace,
             (NvU64) gpuPointer, (NvLength) length, cpuPtr);

    NV_KMEM_CACHE_FREE_STACK(sp);
    return status;
}
EXPORT_SYMBOL(nvUvmInterfaceMemoryCpuMap);

void nvUvmInterfaceMemoryCpuUnMap(uvmGpuAddressSpaceHandle vaSpace,
                                  void *cpuPtr)
{
    nv_stack_t *sp = NULL;
    RM_STATUS status;

    NV_KMEM_CACHE_ALLOC_STACK(sp);
    if (sp == NULL)
        return;

    status = rm_gpu_ops_memory_cpu_ummap(
             sp, (gpuAddressSpaceHandle)vaSpace,
             cpuPtr);

    NV_KMEM_CACHE_FREE_STACK(sp);
    return;
}
EXPORT_SYMBOL(nvUvmInterfaceMemoryCpuUnMap);

RM_STATUS nvUvmInterfaceChannelAllocate(uvmGpuAddressSpaceHandle  vaSpace,
                     uvmGpuChannelHandle *channel,
                     UvmGpuChannelPointers * pointers)
{
    nv_stack_t *sp = NULL;
    RM_STATUS status;
    struct gpuChannelInfo *channelInfo = NULL;

    NV_KMEM_CACHE_ALLOC_STACK(sp);
    if (sp == NULL)
        return RM_ERROR;

    status = os_alloc_mem((void **)&channelInfo, sizeof(*channelInfo));
    if (status != RM_OK)
        goto cleanup_stack;

    status = rm_gpu_ops_channel_allocate(
             sp, (gpuAddressSpaceHandle)vaSpace, (gpuChannelHandle *)channel,
             channelInfo);

    if(status != RM_OK)
        goto cleanup_chInfo;

    pointers->GPGet = channelInfo->GPGet;
    pointers->GPPut = channelInfo->GPPut;
    pointers->gpFifoEntries = channelInfo->gpFifoEntries;
    pointers->channelClassNum = channelInfo->channelClassNum;
    pointers->numGpFifoEntries = channelInfo->numGpFifoEntries;
    pointers->errorNotifier = channelInfo->errorNotifier;
    pointers->eccErrorNotifier = channelInfo->eccErrorNotifier; 

cleanup_chInfo:
    os_free_mem(channelInfo);
cleanup_stack:
    NV_KMEM_CACHE_FREE_STACK(sp);

    return status;
}
EXPORT_SYMBOL(nvUvmInterfaceChannelAllocate);

void nvUvmInterfaceChannelDestroy(uvmGpuChannelHandle channel)
{
    nv_stack_t *sp = NULL;
    RM_STATUS status;

    NV_KMEM_CACHE_ALLOC_STACK(sp);
    if (sp == NULL)
        return;

    status = rm_gpu_ops_channel_destroy(
                    sp, (gpuChannelHandle)channel);
    if(status != RM_OK)
        goto cleanup;

cleanup:
    NV_KMEM_CACHE_FREE_STACK(sp);
    return;

}
EXPORT_SYMBOL(nvUvmInterfaceChannelDestroy);

const char* nvUvmInterfaceChannelTranslateError(unsigned info32)
{
    nv_stack_t *sp = NULL;
    const char *errorString;

    NV_KMEM_CACHE_ALLOC_STACK(sp);
    if (sp == NULL)
        return 0;

    errorString = rm_gpu_ops_channel_translate_error(
                  sp, info32);

    NV_KMEM_CACHE_FREE_STACK(sp);
    return errorString;
}
EXPORT_SYMBOL(nvUvmInterfaceChannelTranslateError);

RM_STATUS nvUvmInterfaceCopyEngineAllocate(
                     uvmGpuChannelHandle channel,
                     unsigned indexStartingAtOne,
                     unsigned * copyEngineClassNumber,
                     uvmGpuCopyEngineHandle *copyEngine)
{
    nv_stack_t *sp = NULL;
    RM_STATUS status;

    NV_KMEM_CACHE_ALLOC_STACK(sp);
    if (sp == NULL)
        return RM_ERROR;

    status = rm_gpu_ops_copy_engine_allocate(
             sp, (gpuChannelHandle) channel, indexStartingAtOne,
             copyEngineClassNumber, (gpuObjectHandle *) copyEngine);


    NV_KMEM_CACHE_FREE_STACK(sp);
    return status;
}
EXPORT_SYMBOL(nvUvmInterfaceCopyEngineAllocate);

RM_STATUS nvUvmInterfaceQueryCaps(uvmGpuAddressSpaceHandle vaSpace,
                                  UvmGpuCaps * caps)
{
    nv_stack_t *sp = NULL;
    struct gpuCaps * pGpuCaps = NULL;
    RM_STATUS status;

    NV_KMEM_CACHE_ALLOC_STACK(sp);
    if (sp == NULL)
        return RM_ERROR;

    status = os_alloc_mem((void **)&pGpuCaps, sizeof(*pGpuCaps));
    if (status != RM_OK)
        goto cleanup_stack;

    status = rm_gpu_ops_query_caps(sp, (gpuAddressSpaceHandle)vaSpace,
                                   pGpuCaps);

    if (status == RM_OK)
    {
        caps->largePageSize = pGpuCaps->largePageSize;
        caps->smallPageSize = pGpuCaps->smallPageSize;
        caps->eccMask = pGpuCaps->eccMask;
        caps->eccOffset = pGpuCaps->eccOffset;
        caps->eccReadLocation = pGpuCaps->eccReadLocation;
        caps->bEccEnabled   = pGpuCaps->bEccEnabled;
        caps->pcieSpeed = pGpuCaps->pcieSpeed;
        caps->pcieWidth = pGpuCaps->pcieWidth;
    }

    os_free_mem(pGpuCaps);

    NV_KMEM_CACHE_FREE_STACK(sp);
    return status;

cleanup_stack:
    NV_KMEM_CACHE_FREE_STACK(sp);
    return status;
}
EXPORT_SYMBOL(nvUvmInterfaceQueryCaps);

RM_STATUS nvUvmInterfaceGetAttachedUuids(NvU8 *pUuidList, unsigned *numGpus)
{
    nv_stack_t *sp = NULL;
    RM_STATUS status;

    NV_KMEM_CACHE_ALLOC_STACK(sp);
    if (sp == NULL)
        return RM_ERROR;

    status = rm_gpu_ops_get_attached_uuids(sp, pUuidList, numGpus);

    NV_KMEM_CACHE_FREE_STACK(sp);
    return status;
}
EXPORT_SYMBOL(nvUvmInterfaceGetAttachedUuids);

RM_STATUS nvUvmInterfaceGetGpuArch(NvU8 *pUuid, unsigned uuidLength,
                                   NvU32 *pGpuArch)
{
    nv_stack_t *sp = NULL;
    RM_STATUS status;

    NV_KMEM_CACHE_ALLOC_STACK(sp);
    if (sp == NULL)
        return RM_ERROR;

    status = rm_gpu_ops_get_gpu_arch(sp, pUuid,
                                     uuidLength,
                                     pGpuArch);

    NV_KMEM_CACHE_FREE_STACK(sp);
    return status;
}
EXPORT_SYMBOL(nvUvmInterfaceGetGpuArch);

RM_STATUS nvUvmInterfaceGetUvmPrivRegion(NvU64 *pUvmPrivRegionStart,
                                         NvU64 *pUvmPrivRegionLength)
{
    return rm_gpu_ops_get_uvm_priv_region(pUvmPrivRegionStart,
                                          pUvmPrivRegionLength);
}
EXPORT_SYMBOL(nvUvmInterfaceGetUvmPrivRegion);

RM_STATUS nvUvmInterfaceServiceDeviceInterruptsRM(uvmGpuChannelHandle channel)
{
    nv_stack_t *sp = NULL;
    RM_STATUS status;

    NV_KMEM_CACHE_ALLOC_STACK(sp);
    if (sp == NULL)
        return RM_ERROR;

    status = rm_gpu_ops_service_device_interrupts_rm(sp,
                                                    (gpuChannelHandle) channel);

    NV_KMEM_CACHE_FREE_STACK(sp);
    return status;
}
EXPORT_SYMBOL(nvUvmInterfaceServiceDeviceInterruptsRM);

RM_STATUS nvUvmInterfaceCheckEccErrorSlowpath(uvmGpuChannelHandle channel,
                                              NvBool *bEccDbeSet)
{
    nv_stack_t *sp = NULL;
    RM_STATUS status;

    NV_KMEM_CACHE_ALLOC_STACK(sp);
    if (sp == NULL)
        return RM_ERROR;

    status = rm_gpu_ops_check_ecc_error_slowpath(sp, (gpuChannelHandle) channel,
                                                 bEccDbeSet);

    NV_KMEM_CACHE_FREE_STACK(sp);
    return status;
}
EXPORT_SYMBOL(nvUvmInterfaceCheckEccErrorSlowpath);

RM_STATUS nvUvmInterfaceKillChannel(uvmGpuChannelHandle channel)
{
    nv_stack_t *sp = NULL;
    RM_STATUS status;

    NV_KMEM_CACHE_ALLOC_STACK(sp);
    if (sp == NULL)
        return RM_ERROR;

    status = rm_gpu_ops_kill_channel(sp, (gpuChannelHandle) channel);

    NV_KMEM_CACHE_FREE_STACK(sp);
    return status;
}
EXPORT_SYMBOL(nvUvmInterfaceKillChannel);

// this function is called by the UVM driver to register the ops
RM_STATUS nvUvmInterfaceRegisterUvmCallbacks(
                                         struct UvmOpsUvmEvents *importedUvmOps)
{
    if (!importedUvmOps)
    {
        return RM_ERR_INVALID_ARGUMENT;
    }

    g_pNvUvmEvents = importedUvmOps;

    return RM_OK;
}
EXPORT_SYMBOL(nvUvmInterfaceRegisterUvmCallbacks);

RM_STATUS nvUvmInterfaceDeRegisterUvmOps(void)
{
    g_pNvUvmEvents = NULL;

    return RM_OK;
}
EXPORT_SYMBOL(nvUvmInterfaceDeRegisterUvmOps);


void nv_uvm_notify_start_device(NvU8 *pUuid)
{
    UvmGpuUuid uvmUuid;

    memcpy(uvmUuid.uuid, pUuid, UVM_UUID_LEN);

    if(g_pNvUvmEvents && g_pNvUvmEvents->startDevice)
    {
        g_pNvUvmEvents->startDevice(&uvmUuid);
    }
    return;
}

void nv_uvm_notify_stop_device(NvU8 *pUuid)
{
    UvmGpuUuid uvmUuid;

    memcpy(uvmUuid.uuid, pUuid, UVM_UUID_LEN);

    if(g_pNvUvmEvents && g_pNvUvmEvents->stopDevice)
    {
        g_pNvUvmEvents->stopDevice(&uvmUuid);
    }
    return;
}

RM_STATUS nv_uvm_event_interrupt(void)
{
    //
    // Since there is no API to de-register/modify the callback,
    // we can safely compare and invoke if it is non-null.
    //
    if (g_pNvUvmEvents && g_pNvUvmEvents->isrTopHalf)
        return g_pNvUvmEvents->isrTopHalf();

    //
    // RM_OK means that the interrupt was for the UVM driver, so use
    // RM_ERR_NO_INTR_PENDING to tell the caller that we didn't do anything.
    //
    return RM_ERR_NO_INTR_PENDING;
}

#endif // NV_UVM_ENABLE || NV_UVM_NEXT_ENABLE
