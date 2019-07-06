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

//
//     uvm.h
//
//     This file contains the UVM API declarations, for the userspace-to-kernel
//     calls.
//

#ifndef _UVM_H_
#define _UVM_H_

#include "uvmtypes.h"

#ifdef __cplusplus
extern "C" {
#endif

/*******************************************************************************
    UvmInitialize

    This must be called before any other UVM functions. Repeated calls to
    UvmInitialize are harmless.

    Error codes:
      UVM_FAILED
      UVM_OUT_OF_MEMORY
*/
RM_STATUS UvmInitialize(void);

/*******************************************************************************
    UvmDeinitialize

    Cleans up all UVM resources.
*/
RM_STATUS UvmDeinitialize(void);

/*******************************************************************************
    UvmReserveVA

    Reserves VA space for future use (by UvmRegionCommit). Access to this region
    will cause page faults.

    Alignment: Please note that the reservations may aligned on a larger value
    than the native page size. This means you cannot rely on back-to-back
    non-overlapping reservations to succeed (as both may be rounded up).

    Reservations will always be aligned to boundaries that are at least the
    native page size of the operating system.

    Multiple, non-contiguous VA's (reservations made via this function) are
    allowed.

    Arguments:
        requestedBase: (INPUT)
            Requested base address.

        length: (INPUT)
            Length in bytes of the region.

    Error codes:
      UVM_FAILED
      UVM_INVALID_ARGUMENT
      UVM_OUT_OF_MEMORY
      UVM_INSUFFICIENT_RESOURCES
*/
RM_STATUS UvmReserveVA(void * requestedBase,
                        NvLength length);

/*******************************************************************************
    UvmReleaseVA

    Releases all pages within the VA range. If any of the pages were committed,
    they are automatically decomitted as well.

    The release may encompass more than a single reserve VA or commit call, but
    must not partially release any regions that were either reserved or
    committed previously.

    Arguments:
        requestedBase: (INPUT)
            Requested base address.

        length: (INPUT)
            Length in bytes of the region.

    Error codes:
      UVM_FAILED
      UVM_INVALID_ARGUMENT
      UVM_OUT_OF_MEMORY
      UVM_INSUFFICIENT_RESOURCES
*/
RM_STATUS UvmReleaseVA(void * requestedBase,
                        NvLength length);

/*******************************************************************************
    UvmRegionCommit

    This operation sets up a region of pages for UVM faulting.  The region, as
    described by requestedBase and length, must fall within an address range
    that has previously been reserved via UvmReserveVA.

    The gpuUuid argument determines the "home GPU." The "home GPU" is just a
    term used here to capture the idea that when you call UvmRegionCommit, the
    GPU that you specify at that time is the one that will be used to do
    CPU-to-GPU copies, for example, when UvmSetStreamRunning is called.

    The streamId sets the initial stream.You may use any stream ID, including
    the all-stream or the no-stream. This may be changed later, via the
    UvmRegionSetStream call.

    Assumption: You must have already allocated this memory on the GPU. This is
    also known as "mapping this (GPU) memory into a (GPU) channel".

    The requestedBase must be on a page boundary, otherwise this routine will
    return UVM_INVALID_ARGUMENT.

    Arguments:
        requestedBase: (INPUT)
            Requested base address.

        length: (INPUT)
            Length in bytes of the region.

        streamId: (INPUT)
            Identifier of the stream owner. A streamId is unique for the
            lifetime of a process.

        gpuUuid: (INPUT)
            GPU unique identifier. This is a 16-byte globally unique ID. It is
            available from a variety of API calls and standalone utilities, such
            as the nvidia-smi(.exe) utility.

    Error codes:
      UVM_FAILED
      UVM_INVALID_ARGUMENT
      UVM_OUT_OF_MEMORY
      UVM_INSUFFICIENT_RESOURCES
*/
RM_STATUS UvmRegionCommit(void * requestedBase,
                           NvLength length,
                           UvmStream streamId,
                           UvmGpuUuid *pGpuUuidStruct);

/*******************************************************************************
    UvmRegionDecommit

    Mark the region of memory as no longer participating in UVM.  The virtual
    address space occupied by these pages will remain reserved regardless of
    whether you reserved the pages beforehand.  If you wish to decommit and
    release the reservation of VA, please use UvmReleaseVA instead.

    A decommit may span multiple commit operations, but it must not partially
    decommit any single commit.  This will be relaxed later.  It is a limitation
    of RM's memory management.

    Arguments:
        requestedBase: (INPUT)
            Requested base address.

        length: (INPUT)
            Length in bytes of the region.

    Error codes:
      UVM_FAILED
      UVM_INVALID_ARGUMENT
*/
RM_STATUS UvmRegionDecommit(void * requestedBase,
                             NvLength length);

/*******************************************************************************
    UvmRegionSetStream

    For the GPU that is identified by gpuUuid, set the stream owner to the
    stream specified by newStreamId. Another way of saying that is that it sets
    visibility of the memory region to that of the newStreamId.

    You may also use this to specify the special streams ("no-stream" or
    "all-stream").

    No change is made to the physical backing.

    This ownership is managed at a byte-level granularity, (not page-level).
    That means the different variables on the same memory page may be owned by
    different streams.

    Arguments:
        requestedBase: (INPUT)
            Requested base address.

        length: (INPUT)
            Length in bytes of the region.

        newStreamId: (INPUT)
            The stream ID that will be the new owning stream. A streamId is
            unique for the lifetime of a process.

        gpuUuid: (INPUT)
            GPU unique identifier. This is a 16-byte globally unique ID. It is
            available from a variety of API calls and standalone utilities, such
            as the nvidia-smi(.exe) utility.

    Error codes:
      UVM_FAILED
      UVM_INVALID_ARGUMENT
*/
RM_STATUS UvmRegionSetStream(void * requestedBase,
                              NvLength length,
                              UvmStream newStreamId,
                              UvmGpuUuid *pGpuUuidStruct);

/*******************************************************************************
    UvmSetStreamRunning

    For all memory visible to the specified stream, CPU-resident dirty pages
    will be migrated back to their home GPU (as previously specified via
    UvmRegionCommit) and marked invalid on the CPU.

    Visibility is defined as memory associated with either all-streams or with
    the specified stream. Memory associated with other streams will not be
    migrated. Sets the stream state to "running".

    After this call returns, CPU accesses to memory associated with streamId
    will fail with undefined behavior.

    Arguments:
        streamId: (INPUT)
            Identifier of the stream that will be set to the "running" state. A
            streamId is unique for the lifetime of a process.

            You may pass in any "normal" stream ID here. The "no-stream" and the
            "all-stream" are not allowed for this argument.

    Error codes:
      UVM_FAILED
      UVM_INVALID_ARGUMENT
      UVM_OUT_OF_MEMORY
      UVM_INSUFFICIENT_RESOURCES
*/
RM_STATUS UvmSetStreamRunning(UvmStream streamId);

/*******************************************************************************
    UvmSetStreamStopped

    Sets the stream state to "stopped". This means that the CPU is allowed to
    access any memory exclusively associated with streamId, and to access memory
    associated with all-streams if no other streams are running. Accesses from
    the CPU will cause GPU-to-CPU memory migrations to occur.

    Arguments:
        streamIdArray: (INPUT)
            An array of identifiers of the streams that will be set to the
            "stopped" state.

            You may pass in any individual stream ID here. The "no-stream" and the
            "all-stream" are not allowed for this argument.

        nStreams: (INPUT)
            Number of streams in the streamIdArray. Must be at least 1.

    Error codes:
      UVM_FAILED
      UVM_INVALID_ARGUMENT
      UVM_OUT_OF_MEMORY
      UVM_INSUFFICIENT_RESOURCES
*/
RM_STATUS UvmSetStreamStopped(UvmStream * streamIdArray, NvLength nStreams);

/*******************************************************************************
    UvmMigrateToGPU

    Forcibly copy data from CPU to GPU memory in preparation for launching the
    associated CUDA kernel. The CPU memory need not be page aligned.

    In addition, pages are also invalidated on the CPU side, unless you pass in
    UVM_MIGRATE_TO_GPU_MIGRATION_FLAGS_DONT_INVALIDATE in the flags argument.

    Arguments:
        requestedBase: (INPUT)
            Requested base address.

        length: (INPUT)
            Length in bytes of the region.

        pUuidStruct: (INPUT)
            A pointer to a GPU UUID struct, that identifies the GPU to which the
            requested region of memory should be migrated.

            GPU unique identifier. This is a 16-byte globally unique ID. It is
            available from a variety of API calls and standalone utilities, such
            as the nvidia-smi(.exe) utility.

        flags: (INPUT)
            Flags to specify modes and hints for migration of data from CPU to
            GPU memory. Only synchronous (i.e. blocking) migration of dirty
            pages is supported for now.

     Error codes:
        UVM_FAILED
        UVM_INVALID_ARGUMENT
        UVM_OUT_OF_MEMORY
*/
RM_STATUS UvmMigrateToGpu(void * requestedBase,
                           NvLength length,
                           UvmGpuUuid * pUuidStruct,
                           unsigned flags);

// default is synchronous (i.e. blocking) migration
#define UVM_MIGRATE_TO_GPU_MIGRATION_FLAGS_ASYNCHRONOUS                      0x1
#define UVM_MIGRATE_TO_GPU_MIGRATION_FLAGS_DONT_INVALIDATE                   0x2

/*******************************************************************************
    UvmRunTest

    Runs a test function denoted by a 32-bit integer. Error messages will be in
    the kernel logs.

    Arguments:
        gpuUuid: (INPUT)
            GPU unique identifier. This is a 16-byte globally unique ID. It is
            available from a variety of API calls and standalone utilities, such
            as the nvidia-smi(.exe) utility.

        testNumber: (INPUT)
            32-bit integer that uniquely identifies a test to be run.

    Error codes:
        UVM_FAILED
        UVM_INVALID_ARGUMENT
*/
RM_STATUS UvmRunTest(UvmGpuUuid *pGpuUuidStruct, unsigned testNumber);

/*******************************************************************************
    UvmGetFileDescriptor

    Intrusive tests benefit from being able to make ioctl calls directly into
    the kernel driver. This routine provides the file descriptor that makes that
    possible.

    For security, this is only available in DEBUG builds.

    Arguments:
        returnedFd: (OUTPUT)
            File descriptor (of the type returned by open(2)) that refers to the
            UVM character device (Unix) or Windows file handle (Windows). (The
            initial implementation is only on Linux.)

            The file descriptor may be uninitialized, if the caller calls this
            routine before UvmInitialize. In that case, *returnedFd will be -1.

    Error codes:
        UVM_INVALID_ARGUMENT
*/
#if defined(DEBUG)
RM_STATUS UvmGetFileDescriptor(int *returnedFd);
#endif

#ifdef __cplusplus
}
#endif

#endif // _UVM_H_
