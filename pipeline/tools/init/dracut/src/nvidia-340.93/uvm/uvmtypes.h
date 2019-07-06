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
//     uvmtypes.h
//
//     This file contains basic datatypes that UVM requires.
//

#ifndef _UVMTYPES_H_
#define _UVMTYPES_H_

#include "nvtypes.h"
#include "rmretval.h"

/*******************************************************************************
    UVM stream types
*******************************************************************************/

typedef enum
{
    UvmStreamTypeRegular = 0,
    UvmStreamTypeAll = 1,
    UvmStreamTypeNone = 2
} UvmStreamType;

#define UVM_STREAM_INVALID  ((UvmStream)0ULL)
#define UVM_STREAM_ALL      ((UvmStream)2ULL)
#define UVM_STREAM_NONE     ((UvmStream)3ULL)

#define UVM_UUID_LEN 16
typedef struct {
    NvU8 uuid[UVM_UUID_LEN];
}UvmGpuUuid;

typedef unsigned long long UvmGpuPointer;
typedef unsigned long long UvmStream;

#define UVM_MAX_GPUS    32

#endif // _UVMTYPES_H_
