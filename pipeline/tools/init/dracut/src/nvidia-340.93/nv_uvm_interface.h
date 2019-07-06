/* _NVRM_COPYRIGHT_BEGIN_
 *
 * Copyright 2013 by NVIDIA Corporation.  All rights reserved.  All
 * information contained herein is proprietary and confidential to NVIDIA
 * Corporation.  Any use, reproduction, or disclosure without the written
 * permission of NVIDIA Corporation is prohibited.
 *
 * _NVRM_COPYRIGHT_END_
 */

//
// This file provides the interface that RM exposes to UVM.
//

#ifndef _NV_UVM_INTERFACE_H_
#define _NV_UVM_INTERFACE_H_

// Forward references, to break circular header file dependencies:
struct UvmOpsUvmEvents;

//
// TODO (bug 1359805): This should all be greatly simplified. It is still
// carrying along a lot of baggage from when RM depended on UVM. Now that
// direction is reversed: RM is independent, and UVM depends on RM.
//
#if defined(NVIDIA_UVM_LITE_ENABLED) || defined (NVIDIA_UVM_NEXT_ENABLED)

// We are in the UVM build system, for a Linux target.
#include "uvmtypes.h"
#include "nvidia_uvm_linux.h"

#else

// We are in the RM build system, for a Linux target:
#include "nv-linux.h"
//
// This is excerpted from uvmtypes.h, in order to allow RM to provide an
// interface that UVM can use. These very few (two, so far) declarations should
// never need to change. If they do need to change, the both this file here, and
// uvmtypes.h must also be changed, to match.
//
#define UVM_UUID_LEN 16
typedef struct {
    NvU8 uuid[UVM_UUID_LEN];
}UvmGpuUuid;

typedef unsigned long long UvmGpuPointer;
// end of excerpted-from-uvmtypes.h section

#endif // NVIDIA_UVM_LITE_ENABLED || NVIDIA_UVM_NEXT_ENABLED

#include "nvgputypes.h"
#include "rmretval.h"

typedef struct uvmGpuSession            *uvmGpuSessionHandle;
typedef struct uvmGpuAddressSpace       *uvmGpuAddressSpaceHandle;
typedef struct uvmGpuChannel            *uvmGpuChannelHandle;
typedef struct uvmGpuObject             *uvmGpuCopyEngineHandle;

/*******************************************************************************
    nvUvmInterfaceSessionCreate

    TODO: Creates session object.  All allocations are tied to the session.

    Error codes:
      RM_ERROR
      RM_ERR_NO_MEMORY
*/
RM_STATUS nvUvmInterfaceSessionCreate(uvmGpuSessionHandle *session);

/*******************************************************************************
    nvUvmInterfaceSessionDestroy

    Destroys a session object.  All allocations are tied to the session will
    be destroyed.

    Error codes:
      RM_ERROR
      RM_ERR_NO_MEMORY
*/
RM_STATUS nvUvmInterfaceSessionDestroy(uvmGpuSessionHandle session);

/*******************************************************************************
    nvUvmInterfaceAddressSpaceCreate

    This function creates an address space.
    This virtual address space is created on the GPU specified
    by the gpuUuid.


    Error codes:
      RM_ERROR
      RM_ERR_NO_MEMORY
*/
RM_STATUS nvUvmInterfaceAddressSpaceCreate(uvmGpuSessionHandle session,
                                            unsigned long long uuidMsb,
                                            unsigned long long uuidLsb,
                                            uvmGpuAddressSpaceHandle *vaSpace);

/*******************************************************************************
    nvUvmInterfaceAddressSpaceCreateMirrored

    This function will associate a privileged address space which mirrors the
    address space associated to the provided PID.

    This address space will have a 128MB carveout. All allocations will
    automatically be limited to this carve out.

    This function will be meaningful and needed only for Kepler.

    Error codes:
      RM_ERROR
      RM_ERR_NO_MEMORY
*/
RM_STATUS nvUvmInterfaceAddressSpaceCreateMirrored(uvmGpuSessionHandle session,
                                             unsigned long long uuidMsb,
                                             unsigned long long uuidLsb,
                                             uvmGpuAddressSpaceHandle *vaSpace);

/*******************************************************************************
    nvUvmInterfaceAddressSpaceDestroy

    Destroys an address space that was previously created via
    nvUvmInterfaceAddressSpaceCreate or
    nvUvmInterfaceAddressSpaceCreateMirrored.
*/

void nvUvmInterfaceAddressSpaceDestroy(uvmGpuAddressSpaceHandle vaSpace);

/*******************************************************************************
    nvUvmInterfaceMemoryAllocFB

    This function will allocate video memory and provide a mapped Gpu
    virtual address to this allocation.

    This function will allocate a minimum page size if the length provided is 0
    and will return a unique GPU virtual address.

    The default page size will be the small page size (as returned by query
    caps). The Alignment will also be enforced to small page size.
*/

RM_STATUS nvUvmInterfaceMemoryAllocFB(uvmGpuAddressSpaceHandle vaSpace,
                                      NvLength length,
                                      UvmGpuPointer * gpuPointer);

/*******************************************************************************
    nvUvmInterfaceMemoryAllocSys

    This function will allocate system memory and provide a mapped Gpu
    virtual address to this allocation.

    This function will allocate a minimum page size if the length provided is 0
    and will return a unique GPU virtual address.

    The default page size will be the small page size (as returned by query caps)
    The Alignment will also be enforced to small page size.
*/
RM_STATUS nvUvmInterfaceMemoryAllocSys(uvmGpuAddressSpaceHandle vaSpace,
                    NvLength length, UvmGpuPointer * gpuPointer);

/*******************************************************************************
    nvUvmInterfaceMemoryFree

    Free up a GPU allocation
*/

void nvUvmInterfaceMemoryFree(uvmGpuAddressSpaceHandle vaSpace,
                              UvmGpuPointer gpuPointer);

/*******************************************************************************
    uvmGpuMemonvUvmInterfaceMemoryCpuMapryCpuMap

    This function creates a CPU mapping to the provided GPU address.
    If the address is not the same as what is returned by the Alloc
    function, then the function will map it from the address provided.
    This offset will be relative to the gpu offset obtained from the
    memory alloc functions.

    Error codes:
      RM_ERROR
      RM_ERR_NO_MEMORY
*/
RM_STATUS nvUvmInterfaceMemoryCpuMap(uvmGpuAddressSpaceHandle vaSpace,
                                     UvmGpuPointer gpuPointer,
                                     NvLength length, void **cpuPtr);

/*******************************************************************************
    uvmGpuMemoryCpuUnmap

    Unmaps the cpuPtr provided from the process virtual address space.
*/
void nvUvmInterfaceMemoryCpuUnMap(uvmGpuAddressSpaceHandle vaSpace,
                                  void *cpuPtr);

/*******************************************************************************
    nvUvmInterfaceChannelAllocate

    This function will allocate a channel

    UvmGpuChannelPointers: this structure will be filled out with channel
    get/put. The errorNotifier is filled out when the channel hits an RC error.

    Error codes:
      RM_ERROR
      RM_ERR_NO_MEMORY
*/

typedef struct
{
    volatile unsigned * GPGet;
    volatile unsigned * GPPut;
    UvmGpuPointer *gpFifoEntries;
    unsigned numGpFifoEntries;
    unsigned channelClassNum;
    NvNotification *errorNotifier;
    NvBool *eccErrorNotifier;
} UvmGpuChannelPointers;


RM_STATUS nvUvmInterfaceChannelAllocate(uvmGpuAddressSpaceHandle  vaSpace,
                                        uvmGpuChannelHandle *channel,
                                        UvmGpuChannelPointers * pointers);

void nvUvmInterfaceChannelDestroy(uvmGpuChannelHandle channel);



/*******************************************************************************
    nvUvmInterfaceChannelTranslateError

    Translates NvNotification::info32 to string
*/

const char* nvUvmInterfaceChannelTranslateError(unsigned info32);

/*******************************************************************************
    nvUvmInterfaceCopyEngineAllocate

    ceIndex should correspond to three possible indexes. 1,2 or N and
    this corresponds to the copy engines available on the gpu.
    ceIndex equal to 0 will return UVM_INVALID_ARGUMENTS.
    If a non existant CE index is used, then this API will fail.

    The copyEngineClassNumber is returned so that the user can
    find the right methods to use on his engine.

    Error codes:
      RM_ERROR
      RM_ERR_NO_MEMORY
      UVM_INVALID_ARGUMENTS
*/
RM_STATUS nvUvmInterfaceCopyEngineAllocate(uvmGpuChannelHandle channel,
                                           unsigned indexStartingAtOne,
                                           unsigned * copyEngineClassNumber,
                                           uvmGpuCopyEngineHandle *copyEngine);

/*******************************************************************************
    nvUvmInterfaceQueryCaps

    Return capabilities for the provided GPU.
    If GPU does not exist, an error will be returned.

    Error codes:
      RM_ERROR
      RM_ERR_NO_MEMORY
*/
typedef struct
{
    unsigned largePageSize;
    unsigned smallPageSize;
    unsigned eccMask;
    unsigned eccOffset;
    void   * eccReadLocation;
    unsigned pcieSpeed;
    unsigned pcieWidth;
    NvBool   bEccEnabled;
}UvmGpuCaps;
RM_STATUS nvUvmInterfaceQueryCaps(uvmGpuAddressSpaceHandle vaSpace,
                                  UvmGpuCaps * caps);
/*******************************************************************************
    nvUvmInterfaceGetAttachedUuids

    Return 1. a list of UUIDS for all GPUs found.
           2. number of GPUs found.

    Error codes:
      RM_ERROR
 */
RM_STATUS nvUvmInterfaceGetAttachedUuids(NvU8 *pUuidList, unsigned *numGpus);

/*******************************************************************************
    nvUvmInterfaceGetGpuArch

    Return gpu architecture number for the provided GPU uuid.
    If no gpu matching the uuid is found, an error will be returned.

    Error codes:
      RM_ERROR
      RM_ERR_INSUFFICIENT_RESOURCES
 */
RM_STATUS nvUvmInterfaceGetGpuArch(NvU8 *pUuid, unsigned uuidLength,
                                   NvU32 *pGpuArch);

/*******************************************************************************
    nvUvmInterfaceGetUvmPrivRegion

    Return UVM privilege region start and length
 */
RM_STATUS nvUvmInterfaceGetUvmPrivRegion(NvU64 *pUvmPrivRegionStart,
                                         NvU64 *pUvmPrivRegionLength);

/*******************************************************************************
    nvUvmInterfaceServiceDeviceInterruptsRM

    Tells RM to service all pending interrupts. This is helpful in ECC error
    conditions when ECC error interrupt is set & error can be determined only
    after ECC notifier will be set or reset.

    Error codes:
      RM_ERROR
      UVM_INVALID_ARGUMENTS
*/
RM_STATUS nvUvmInterfaceServiceDeviceInterruptsRM(uvmGpuChannelHandle channel);


/*******************************************************************************
    nvUvmInterfaceCheckEccErrorSlowpath

    Checks Double-Bit-Error counts thru RM using slow path(Priv-Read) If DBE is
    set in any unit bEccDbeSet will be set to NV_TRUE else NV_FALSE.

    Error codes:
      RM_ERROR
      UVM_INVALID_ARGUMENTS
*/
RM_STATUS nvUvmInterfaceCheckEccErrorSlowpath(uvmGpuChannelHandle channel,
                                              NvBool *bEccDbeSet);

/*******************************************************************************
    nvUvmInterfaceKillChannel

    Stops a GPU channel from running, by invoking RC recovery on the channel.

    Error codes:
      RM_ERROR
      UVM_INVALID_ARGUMENTS
*/
RM_STATUS nvUvmInterfaceKillChannel(uvmGpuChannelHandle channel);

/*******************************************************************************
    uvmEventStartDevice
    This function will be called by the GPU driver once it has finished its
    initialization to tell the UVM driver that this GPU has come up.
*/

typedef RM_STATUS (*uvmEventStartDevice_t) (UvmGpuUuid *pGpuUuidStruct);

/*******************************************************************************
    uvmEventStopDevice
    This function will be called by the GPU driver to let UVM know that a GPU
    is going down.
*/
typedef RM_STATUS (*uvmEventStopDevice_t) (UvmGpuUuid *pGpuUuidStruct);

/*******************************************************************************
    uvmEventIsrTopHalf_t
    This function will be called by the GPU driver to let UVM know
    that an interrupt has occurred.

    Returns:
        RM_OK if the UVM driver handled the interrupt
        RM_ERR_NO_INTR_PENDING if the interrupt is not for the UVM driver
*/
typedef RM_STATUS (*uvmEventIsrTopHalf_t) (void);

struct UvmOpsUvmEvents
{
    uvmEventStartDevice_t startDevice;
    uvmEventStopDevice_t  stopDevice;
    uvmEventIsrTopHalf_t  isrTopHalf;
};

//
// Called by the UVM driver to register operations with RM
//
RM_STATUS nvUvmInterfaceRegisterUvmCallbacks(
                                         struct UvmOpsUvmEvents *importedUvmOps);

RM_STATUS nvUvmInterfaceDeRegisterUvmOps(void);

//
// TODO: Find out if there is an RM call that returns this information.
// Meanwhile we will set this to 2 which is the case for the biggest GPUs:
//
#define MAX_NUM_COPY_ENGINES  2

#endif // _NV_UVM_INTERFACE_H_
