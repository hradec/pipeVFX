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

#ifndef _NVIDIA_PAGE_MIGRATION_H_
#define _NVIDIA_PAGE_MIGRATION_H_

#include "uvmtypes.h"

#if defined(__windows__)

// TODO: move these various items into a Windows-specific header file:
#include <mmintrin.h>
#include <assert.h>

// ARM doesn't support the following intrinsics, so assert
#if defined(_ARM_)
#define _mm_sfence()  assert(!"_mm_sfence() not supported on ARM!")
#define _mm_pause()   assert(!"_mm_pause() not supported on ARM!")
#endif

#define NV_UVM_FENCE()  _mm_sfence()
#endif

typedef struct UvmCopyOps_s UvmCopyOps;

/*******************************************************************************
    NvUvmChannelWriteGpPut

    Setup all the function pointers for the copy API.

    Argument:
        ceClass: (INPUT)
            Class of the copy engine.

        fifoClass: (INPUT)
            Class of the host engine.

*/
RM_STATUS NvUvmHalInit(unsigned ceClass, unsigned fifoClass,
                        UvmCopyOps *copyOps);

/*******************************************************************************
    NvUvmChannelWriteGpPut

    Update the passed in GPFIFO Put pointer to the passed in index. The user is
    responsible for sanity checking.

    Argument:
        gpPut: (INPUT)
            Pointer to the put index of the GPFIFO.

        index: (INPUT)
            Index of the GPFIFO entry that the put pointer should be updated to

*/
void NvUvmChannelWriteGpPut(volatile unsigned *gpPut, unsigned index);

/*******************************************************************************
    NvUvmChannelWriteGpEntry

    Write a GPFIFO entry to point to the passed in push buffer.

    Arguments:
        fifoType: (INPUT)
            Class of the GPFIFO that should be written to.

        gpFifoEntries: (INPUT)
            Base pointer of the GPFIFO that should be populated.

        index: (INPUT)
            Index of the GPFIFO entry that should be populated.

        bufferBase: (INPUT)
            Base pointer of the PB that should be written to the GPFIFO.

        bufferLength: (INPUT)
            Length of the PB that should be written to the GPFIFO in bytes.
*/
typedef void (*NvUvmChannelWriteGpEntry_t)(unsigned long long *gpFifoEntries,
                                         unsigned index, unsigned long long bufferBase,
                                         NvLength bufferLength);

/*******************************************************************************
    NvUvmCopyEngineLaunchDma

    Push the necessary methods to use the copy engine to copy data from one
    memory location to another. Source and destination memory can be any
    combination of coherent system memory, non-coherent system memory, or
    frame buffer.

    Arguments:
        ceType: (INPUT)
            Class of the copy engine.

        pbPut: (INPUT / OUPTUT)
            Pointer to the base pointer of where in the PB methods should be
            written to.

        pbEnd: (INPUT)
            Address of the end (largest address) of the push buffer.

        source: (INPUT)
            Address that the copy engine should copy from.

        destination: (INPUT)
            Address that the copy engine should copy to.

        size: (INPUT)
            Size of the region that the copy engine should copy.

        Flags: (INPUT)
            Flags denoting the location and type of source and destination
            addresses passed in.

     Returns:
        Number of bytes written to the passed in push buffer. Returns 0 if there
        was not enough room in the push buffer.
*/
typedef NvLength (*NvUvmCopyEngineLaunchDma_t)(unsigned **pbPut, unsigned *pbEnd,
                                            NvUPtr source, unsigned srcFlags,
                                            NvUPtr destination,
                                            unsigned dstFlags,
                                            NvLength size, unsigned launchFlags);

#define NV_UVM_COPY_SRC_LOCATION_SYSMEM     (0x00000001)
#define NV_UVM_COPY_SRC_LOCATION_FB         (0x00000000)

#define NV_UVM_COPY_DST_LOCATION_SYSMEM     (0x00000001)
#define NV_UVM_COPY_DST_LOCATION_FB         (0x00000000)

#define NV_UVM_COPY_DST_TYPE_VIRTUAL        (0x00000000)
#define NV_UVM_COPY_DST_TYPE_PHYSICAL       (0x00002000)

#define NV_UVM_COPY_SRC_TYPE_VIRTUAL        (0x00000000)
#define NV_UVM_COPY_SRC_TYPE_PHYSICAL       (0x00001000)

/*******************************************************************************
    NvUvmCopyEngineInsertSemaphoreAcquire

    Push the necessary methods to acquire the copy engine semaphore

    Arguments:
        ceType: (INPUT)
            Class of the copy engine.

        pbPut: (INPUT / OUPTUT)
            Pointer to the base pointer of where in the PB methods should be
            written to.

        pbEnd: (INPUT)
            Address of the end (largest address) of the push buffer.

        hostSemaphore: (INPUT)
            Structure holding metadata of the semaphore to be .

     Returns:
        Number of bytes written to the passed in push buffer. Returns 0 if there
        was not enough room in the push buffer.
*/
typedef NvLength (*NvUvmCopyEngineInsertSemaphoreAcquire_t)
    (unsigned **pbPut,
     unsigned *pbEnd,
     UvmGpuPointer semaphoreGpuPointer,
     unsigned semaphorePayload);

/*******************************************************************************
    NvUvmCopyEngineInsertSemaphoreRelease

    Push the necessary methods to release the copy engine semaphore

    Arguments:
        ceType: (INPUT)
            Class of the copy engine.

        pbPut: (INPUT / OUPTUT)
            Pointer to the base pointer of where in the PB methods should be
            written to.

        pbEnd: (INPUT)
            Address of the end (largest address) of the push buffer.

        hostSemaphore: (INPUT)
            Structure holding metadate of the semaphore to be released.

     Returns:
        Number of bytes written to the passed in push buffer. Returns 0 if there
        was not enough room in the push buffer.
*/
typedef NvLength (*NvUvmCopyEngineInsertSemaphoreRelease_t)
    (unsigned **pbPut,
     unsigned *pbEnd,
     UvmGpuPointer semaphoreGpuPointer,
     unsigned semaphorePayload);

/*******************************************************************************
    NvUvmCopyEngineMemSet

    Insert methods to perform a memset operation

    Arguments:
        pbPut: (INPUT / OUPTUT)
            Pointer to the base pointer of where in the PB methods should be
            written to.

        pbEnd: (INPUT)
            Address of the end (largest address) of the push buffer.

        base: (INPUT)
            The destination base pointer. This pointer needs to be 4k aligned.
            This pointer can point to
            Coherrent physical sysmem
            Coherrent physical vidmem
            Gpu virtual pointer to sysmem
            Gpu virtual pointer to vidmem
            
        size: (INPUT)
            Size of the block that needs to be memset. 
            It should be aligned to 4k
            
        payload: (INPUT)
            32 bit Value that the memory should be set to.
            
        flags: (INPUT)
            Determines whether the memset pointer is 
            Physical/Gpu Virtual
            Aperture is Sysmem/Vidmem
            
     Returns:
        Number of bytes written to the passed in push buffer. Returns 0 if there
        was not enough room in the push buffer.
*/
typedef NvLength (*NvUvmCopyEngineMemSet_t)
    (unsigned **pbPut, unsigned *pbEnd, NvUPtr base,
     NvLength size, unsigned payload, unsigned flags);

#define NV_UVM_MEMSET_DST_LOCATION_SYSMEM     (0x00000000)
#define NV_UVM_MEMSET_DST_LOCATION_FB         (0x00000001)

#define NV_UVM_MEMSET_DST_TYPE_VIRTUAL        (0x00000002)
#define NV_UVM_MEMSET_DST_TYPE_PHYSICAL       (0x00000004)
#define NV_UVM_MEMSET_TRANSER_PIPELINED       (0x00000008)
     
     
struct UvmCopyOps_s
{
    NvUvmChannelWriteGpEntry_t              writeGpEntry;
    NvUvmCopyEngineLaunchDma_t              launchDma;
    NvUvmCopyEngineInsertSemaphoreAcquire_t semaphoreAcquire;
    NvUvmCopyEngineInsertSemaphoreRelease_t semaphoreRelease;
    NvUvmCopyEngineMemSet_t                 memset;
};

#endif // _NVIDIA_PAGE_MIGRATION_H_
