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
#include "nvidia_uvm_common.h"
#include "nvidia_uvm_lite.h"

RM_STATUS uvmlite_gpu_event_start_device(UvmGpuUuid *gpuUuidStruct)
{
    UVM_DBG_PRINT_UUID("Start", gpuUuidStruct);

    if (uvmlite_enable_gpu_uuid(gpuUuidStruct) != RM_OK)
        return RM_ERROR;
    return RM_OK;
}

RM_STATUS uvmlite_gpu_event_stop_device(UvmGpuUuid *gpuUuidStruct)
{

    //
    // TODO: implement
    //
    // Grab the global lock
    // Grab the per process lock
    // Clean up all the migration resources for this UUID
    // and other relevant data structures
    // Also:
    // Other related fixes that need to be added
    // need to take this global lock when UVM is being rmmodded
    // The copy/mig loop needs to now follow this
    // 1) Take per process lock
    // 2) Check if migration resources exist(channel is valid)
    // 3) migrate pages()
    // 4) Unlock per process lock
    // 5) is_schedule()
    //

    UVM_DBG_PRINT_UUID("Stop", gpuUuidStruct);
    if (uvmlite_disable_gpu_uuid(gpuUuidStruct) != RM_OK)
        return RM_ERROR;

    umvlite_destroy_per_process_gpu_resources(gpuUuidStruct);
    return RM_OK;
}
