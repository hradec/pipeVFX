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

#include "uvmtypes.h"
#include "nvgputypes.h"
#include "nvidia_page_migration.h"
#include "nvidia_page_migration_kepler.h"

#include "nvmisc.h"
#include "cla06f.h"
#include "cla06fsubch.h"
#include "cla0b5.h"

#define NV_METHOD(SubCh, Method, Num)                                          \
    (REF_DEF(NVA06F_DMA_INCR_OPCODE,      _VALUE)  |                           \
     REF_NUM(NVA06F_DMA_INCR_COUNT,       Num)     |                           \
     REF_NUM(NVA06F_DMA_INCR_SUBCHANNEL,  SubCh)   |                           \
     REF_NUM(NVA06F_DMA_INCR_ADDRESS,     (Method) >> 2) )

#define PUSH_PAIR(SubCh, Method, Data)                                         \
    do {                                                                       \
        **pbPut = (NV_METHOD((SubCh),(Method),1));                             \
        (*pbPut)++;                                                            \
        **pbPut = ((Data));                                                    \
        (*pbPut)++;                                                            \
    } while (0)

void NvUvmChannelWriteGpEntryA06F
    (unsigned long long *gpFifoEntries, unsigned index,
     unsigned long long bufferBase,
     NvLength bufferLength)
{
    gpFifoEntries[index] =
            DRF_NUM(A06F, _GP_ENTRY0, _GET, (NvU64_LO32(bufferBase) >> 2) ) |
            (
                ((unsigned long long)
                DRF_NUM(A06F, _GP_ENTRY1, _GET_HI, NvU64_HI32(bufferBase)) |
                DRF_NUM(A06F, _GP_ENTRY1, _LENGTH, bufferLength >> 2) |
                DRF_DEF(A06F, _GP_ENTRY1, _PRIV, _KERNEL) |
                DRF_DEF(A06F, _GP_ENTRY1, _LEVEL, _MAIN))
                << 32
            );
}

NvLength NvUvmCopyEngineMemSetA0B5
    (unsigned **pbPut, unsigned *pbEnd, NvUPtr base,
     NvLength size, unsigned payload, unsigned flags)
{
    // what are the alignment requirements for the base? 4k?
    unsigned launch = 0;
    NvLength methodSize = 0;
    
    //
    // The amount of space needed to push the methods necessary for a
    // semaphore acquire on Kepler is:
    // 32 Bits per method * 2 methods per push * 9 pushes
    //
    methodSize = 9 * 2 * sizeof(unsigned);
   
    // set the channel object
    PUSH_PAIR(NVA06F_SUBCHANNEL_COPY_ENGINE,NVA06F_SET_OBJECT,
              KEPLER_DMA_COPY_A);
     
    PUSH_PAIR(NVA06F_SUBCHANNEL_COPY_ENGINE, 
              NVA0B5_SET_REMAP_COMPONENTS, 
              DRF_DEF(A0B5, _SET_REMAP_COMPONENTS, _DST_X, _CONST_A)          |
              DRF_DEF(A0B5, _SET_REMAP_COMPONENTS, _COMPONENT_SIZE, _FOUR)    |
              DRF_DEF(A0B5, _SET_REMAP_COMPONENTS, _NUM_SRC_COMPONENTS, _ONE) |
              DRF_DEF(A0B5, _SET_REMAP_COMPONENTS, _NUM_DST_COMPONENTS, _ONE));

    PUSH_PAIR(NVA06F_SUBCHANNEL_COPY_ENGINE, NVA0B5_SET_REMAP_CONST_A, payload);

    PUSH_PAIR(NVA06F_SUBCHANNEL_COPY_ENGINE, NVA0B5_LINE_LENGTH_IN, 
              NvU64_LO32(size >> 2));
    PUSH_PAIR(NVA06F_SUBCHANNEL_COPY_ENGINE, NVA0B5_LINE_COUNT, 1);
    
    if (flags & NV_UVM_MEMSET_DST_LOCATION_FB)
    {
        PUSH_PAIR(NVA06F_SUBCHANNEL_COPY_ENGINE, NVA0B5_SET_DST_PHYS_MODE, 
                  DRF_DEF(A0B5, _SET_DST_PHYS_MODE, _TARGET, _LOCAL_FB));
    }
    else
    {
        PUSH_PAIR(NVA06F_SUBCHANNEL_COPY_ENGINE, NVA0B5_SET_DST_PHYS_MODE, 
                  DRF_DEF(A0B5, _SET_DST_PHYS_MODE, _TARGET, _COHERENT_SYSMEM)); 
    }
    
    PUSH_PAIR(NVA06F_SUBCHANNEL_COPY_ENGINE, NVA0B5_OFFSET_OUT_UPPER, 
              DRF_NUM(A0B5, _OFFSET_OUT_UPPER, _UPPER, NvU64_HI32(base)));
    PUSH_PAIR(NVA06F_SUBCHANNEL_COPY_ENGINE, NVA0B5_OFFSET_OUT_LOWER, 
              DRF_NUM(A0B5, _OFFSET_OUT_LOWER, _VALUE, NvU64_LO32(base)));
    launch |= DRF_DEF(A0B5, _LAUNCH_DMA, _FLUSH_ENABLE, _TRUE);
    launch |= DRF_DEF(A0B5, _LAUNCH_DMA, _REMAP_ENABLE, _TRUE);
    launch |= DRF_DEF(A0B5, _LAUNCH_DMA, _SRC_MEMORY_LAYOUT, _PITCH);
    launch |= DRF_DEF(A0B5, _LAUNCH_DMA, _DST_MEMORY_LAYOUT, _PITCH);
    
    if (flags & NV_UVM_MEMSET_TRANSER_PIPELINED)
    {
        launch |= DRF_DEF(A0B5, _LAUNCH_DMA, _DATA_TRANSFER_TYPE, _PIPELINED);
    }
    if (flags & NV_UVM_MEMSET_DST_TYPE_PHYSICAL)
    {
        launch |= DRF_DEF(A0B5, _LAUNCH_DMA, _DST_TYPE, _PHYSICAL);
    }
    else 
    {
        launch |= DRF_DEF(A0B5, _LAUNCH_DMA, _DST_TYPE, _VIRTUAL);
    }
    PUSH_PAIR(NVA06F_SUBCHANNEL_COPY_ENGINE, NVA0B5_LAUNCH_DMA, launch);
    
    return methodSize;
}

NvLength NvUvmCopyEngineLaunchDmaA0B5
    (unsigned **pbPut, unsigned *pbEnd, NvUPtr source, unsigned srcFlags,
     NvUPtr destination, unsigned dstFlags, NvLength size, unsigned launchFlags)
{
    unsigned launch = 0;
    NvLength methodSize = 0;

    //
    // the amount of space needed to push the methods necessary for a
    // semaphore acquire on Kepler is:
    // 32 bytes per method * 2 methods per push * 10 pushes
    //
    methodSize = 10 * 2 * sizeof(unsigned);

    if (*pbPut + methodSize > pbEnd)
        return 0;

    // set the channel object
    PUSH_PAIR(NVA06F_SUBCHANNEL_COPY_ENGINE,NVA06F_SET_OBJECT,
              KEPLER_DMA_COPY_A);

    // setup the source
    PUSH_PAIR(NVA06F_SUBCHANNEL_COPY_ENGINE, NVA0B5_OFFSET_IN_LOWER,
              DRF_NUM(A0B5, _OFFSET_IN_LOWER, _VALUE, NvU64_LO32(source)));
    PUSH_PAIR(NVA06F_SUBCHANNEL_COPY_ENGINE, NVA0B5_OFFSET_IN_UPPER,
              DRF_NUM(A0B5, _OFFSET_IN_UPPER, _UPPER, NvU64_HI32(source)));

    if(srcFlags == NV_UVM_COPY_SRC_LOCATION_SYSMEM)
        PUSH_PAIR(NVA06F_SUBCHANNEL_COPY_ENGINE, NVA0B5_SET_SRC_PHYS_MODE,
                  DRF_DEF(A0B5, _SET_SRC_PHYS_MODE,
                      _TARGET, _COHERENT_SYSMEM));
    else 
        PUSH_PAIR(NVA06F_SUBCHANNEL_COPY_ENGINE, NVA0B5_SET_SRC_PHYS_MODE,
                  DRF_DEF(A0B5, _SET_SRC_PHYS_MODE,
                      _TARGET, _LOCAL_FB));

    if(launchFlags & NV_UVM_COPY_SRC_TYPE_PHYSICAL)
        launch |= DRF_DEF(A0B5, _LAUNCH_DMA, _SRC_TYPE, _PHYSICAL);
    else
        launch |= DRF_DEF(A0B5, _LAUNCH_DMA, _SRC_TYPE, _VIRTUAL);

    // setup the destination
    PUSH_PAIR(NVA06F_SUBCHANNEL_COPY_ENGINE, NVA0B5_OFFSET_OUT_LOWER,
              DRF_NUM(A0B5,_OFFSET_OUT_LOWER,_VALUE,
                      NvU64_LO32(destination)));
    PUSH_PAIR(NVA06F_SUBCHANNEL_COPY_ENGINE, NVA0B5_OFFSET_OUT_UPPER,
              DRF_NUM(A0B5, _OFFSET_OUT_UPPER, _UPPER,
                      NvU64_HI32(destination)));

    if(dstFlags == NV_UVM_COPY_DST_LOCATION_SYSMEM)
        PUSH_PAIR(NVA06F_SUBCHANNEL_COPY_ENGINE, NVA0B5_SET_DST_PHYS_MODE,
                  DRF_DEF(A0B5, _SET_DST_PHYS_MODE,
                         _TARGET, _COHERENT_SYSMEM));
    else
        PUSH_PAIR(NVA06F_SUBCHANNEL_COPY_ENGINE, NVA0B5_SET_DST_PHYS_MODE,
                  DRF_DEF(A0B5, _SET_DST_PHYS_MODE,
                         _TARGET, _LOCAL_FB));

    if(launchFlags & NV_UVM_COPY_DST_TYPE_PHYSICAL)
        launch |= DRF_DEF(A0B5, _LAUNCH_DMA, _DST_TYPE, _PHYSICAL);
    else
        launch |= DRF_DEF(A0B5, _LAUNCH_DMA, _DST_TYPE, _VIRTUAL);

    // setup the format
    PUSH_PAIR(NVA06F_SUBCHANNEL_COPY_ENGINE, NVA0B5_LINE_COUNT, 1);
    PUSH_PAIR(NVA06F_SUBCHANNEL_COPY_ENGINE, NVA0B5_LINE_LENGTH_IN,
              NvU64_LO32(size));

    launch |= DRF_DEF(A0B5, _LAUNCH_DMA, _FLUSH_ENABLE, _TRUE);
    launch |= DRF_DEF(A0B5, _LAUNCH_DMA, _SRC_MEMORY_LAYOUT, _PITCH);
    launch |= DRF_DEF(A0B5, _LAUNCH_DMA, _DST_MEMORY_LAYOUT, _PITCH);
    launch |= DRF_DEF(A0B5, _LAUNCH_DMA, _DATA_TRANSFER_TYPE, _PIPELINED);
    PUSH_PAIR(NVA06F_SUBCHANNEL_COPY_ENGINE, NVA0B5_LAUNCH_DMA, launch);

    return methodSize;
}

NvLength NvUvmCopyEngineInsertSemaphoreAcquireA06F
    (unsigned **pbPut, unsigned *pbEnd, UvmGpuPointer semaphoreGpuPointer,
     unsigned payload)
{
    NvLength methodSize  = 0;

    //
    // the amount of space needed to push the methods necessary for a
    // semaphore acquire on Kepler is:
    // 32 bytes per method * 2 methods per push * 4 pushes
    //
    methodSize = 4 * 2 * sizeof(unsigned);

    if (*pbPut + methodSize > pbEnd)
        return 0;

    PUSH_PAIR(NVA06F_SUBCHANNEL_COPY_ENGINE, NVA06F_SEMAPHOREA,
              DRF_NUM(A06F, _SEMAPHOREA, _OFFSET_UPPER,
                      NvU64_HI32(semaphoreGpuPointer)));
    PUSH_PAIR(NVA06F_SUBCHANNEL_COPY_ENGINE, NVA06F_SEMAPHOREB,
              DRF_NUM(A06F, _SEMAPHOREB, _OFFSET_LOWER,
                      NvU64_LO32(semaphoreGpuPointer)>>2));
    PUSH_PAIR(NVA06F_SUBCHANNEL_COPY_ENGINE, NVA06F_SEMAPHOREC,
              DRF_NUM(A06F, _SEMAPHOREC, _PAYLOAD, payload));
    PUSH_PAIR(NVA06F_SUBCHANNEL_COPY_ENGINE, NVA06F_SEMAPHORED,
              DRF_DEF(A06F, _SEMAPHORED, _OPERATION, _ACQUIRE)| 
              DRF_DEF(A06F, _SEMAPHORED, _ACQUIRE_SWITCH, _ENABLED));

    return methodSize;
}

NvLength NvUvmCopyEngineInsertSemaphoreReleaseA0B5
    (unsigned **pbPut, unsigned *pbEnd, UvmGpuPointer semaphoreGpuPointer,
     unsigned payload)
{
    unsigned methodSize  = 0;
    unsigned launch = 0;

    //
    // the amount of space needed to push the methods necessary for a
    // semaphore release on Kepler is:
    // 32 bytes per method * 2  methods per push * 4 pushes
    //
    methodSize = 4 * 2 * sizeof(unsigned);

    if (*pbPut + methodSize > pbEnd)
        return 0;

    PUSH_PAIR(NVA06F_SUBCHANNEL_COPY_ENGINE, NVA0B5_SET_SEMAPHORE_A,
              DRF_NUM(A0B5, _SET_SEMAPHORE_A, _UPPER,
                      NvU64_HI32(semaphoreGpuPointer)));
    PUSH_PAIR(NVA06F_SUBCHANNEL_COPY_ENGINE, NVA0B5_SET_SEMAPHORE_B,
              DRF_NUM(A0B5, _SET_SEMAPHORE_B, _LOWER,
                      NvU64_LO32(semaphoreGpuPointer)));
    PUSH_PAIR(NVA06F_SUBCHANNEL_COPY_ENGINE, NVA0B5_SET_SEMAPHORE_PAYLOAD,
              payload);

    launch |= DRF_DEF(A0B5, _LAUNCH_DMA, _FLUSH_ENABLE, _TRUE);
    launch |= DRF_DEF(A0B5, _LAUNCH_DMA, _SEMAPHORE_TYPE, _RELEASE_ONE_WORD_SEMAPHORE);
    PUSH_PAIR(NVA06F_SUBCHANNEL_COPY_ENGINE, NVA0B5_LAUNCH_DMA, launch);
    return methodSize;
}
