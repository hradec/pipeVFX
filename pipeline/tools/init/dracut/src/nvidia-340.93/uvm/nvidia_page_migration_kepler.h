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

#ifndef _NVIDIA_PAGE_MIGRATION_KEPLER_H_
#define _NVIDIA_PAGE_MIGRATION_KEPLER_H_

//
// A06F and A0B5 are respectively the copy engine and FIFO classes belonging to
// NVIDIA's "Kepler" GPU architecture. This interface implements a hardware
// abstraction layer for "Kepler".
//

void NvUvmChannelWriteGpEntryA06F
    (unsigned long long *gpFifoEntries, unsigned index, unsigned long long bufferBase,
     NvLength bufferLength);

NvLength NvUvmCopyEngineLaunchDmaA0B5
    (unsigned **pbPut, unsigned *pbEnd, NvUPtr source, unsigned srcFlags,
     NvUPtr destination, unsigned dstFlags, NvLength size,
     unsigned launchFlags);

NvLength NvUvmCopyEngineInsertSemaphoreAcquireA06F
    (unsigned **pbPut, unsigned *pbEnd, UvmGpuPointer semaphoreGpuPointer,
     unsigned payload);


NvLength NvUvmCopyEngineInsertSemaphoreReleaseA0B5
    (unsigned **pbPut, unsigned *pbEnd, UvmGpuPointer semaphoreGpuPointer,
     unsigned payload);

NvLength NvUvmCopyEngineMemSetA0B5
    (unsigned **pbPut, unsigned *pbEnd, NvUPtr base,
     NvLength size, unsigned payload, unsigned flags);

#endif // _NVIDIA_PAGE_MIGRATION_KEPLER_H_
