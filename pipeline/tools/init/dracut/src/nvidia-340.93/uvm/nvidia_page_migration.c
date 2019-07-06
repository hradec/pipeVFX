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
#include "nvidia_page_migration.h"
#include "nvidia_page_migration_kepler.h"

#if defined(__linux__)
#include "nvidia_uvm_linux.h"             // For NV_UVM_FENCE()
#endif
//
// Instead of including cla06f.h and cla0b5.h, copy the (immutable) two items
// that are required here. This is in order to avoid a conflict between the
// Linux kernel's definition of "BIT", and the same definition from NVIDIA's
// nvmisc.h.
//
#define KEPLER_DMA_COPY_A              (0x0000A0B5)
#define KEPLER_CHANNEL_GPFIFO_A        (0x0000A06F)
#define MAXWELL_DMA_COPY_A             (0x0000B0B5)

void NvUvmChannelWriteGpPut(volatile unsigned *gpPut, unsigned index)
{
    NV_UVM_FENCE();
    *gpPut = index;
}

RM_STATUS NvUvmHalInit
    (unsigned ceClass, unsigned fifoClass, UvmCopyOps *copyOps)
{
    // setup CE HALs
    switch (ceClass)
    {
        case KEPLER_DMA_COPY_A:
        case MAXWELL_DMA_COPY_A:  
            copyOps->launchDma = NvUvmCopyEngineLaunchDmaA0B5;
            copyOps->semaphoreRelease =
                NvUvmCopyEngineInsertSemaphoreReleaseA0B5;
            copyOps->memset = NvUvmCopyEngineMemSetA0B5;    
            break;
        default:
            return RM_ERR_NOT_SUPPORTED;
    }

    // setup FIFO HALs
    switch (fifoClass)
    {
        case KEPLER_CHANNEL_GPFIFO_A:
            copyOps->writeGpEntry = NvUvmChannelWriteGpEntryA06F;
            copyOps->semaphoreAcquire =
                       NvUvmCopyEngineInsertSemaphoreAcquireA06F;
            break;
        default:
            return RM_ERR_NOT_SUPPORTED;
    }

    return RM_OK;
}
