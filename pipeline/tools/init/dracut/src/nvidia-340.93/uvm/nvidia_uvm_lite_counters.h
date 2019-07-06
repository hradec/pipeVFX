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
#ifndef _NVIDIA_UVM_LITE_COUNTERS_H_
#define _NVIDIA_UVM_LITE_COUNTERS_H_

#include "nvidia_uvm_lite.h"
#include "uvm-debug.h"

//
// pid = 0 is not a valid value for either the session owner nor the target.
// Therefore it is safe to use 0 for initialization.
//
static const unsigned UVM_PID_INIT_VALUE = 0;

void uvm_increment_process_counters(UvmCounterInfo *procSingleGpuCounter,
                                    UvmProcessRecord *pProcessRecord,
                                    UvmCounterName name,
                                    unsigned incrementVal);

RM_STATUS uvm_map_counter(UvmSessionInfo *pSessionInfo,
                          UvmCounterScope scope,
                          UvmCounterName counterName,
                          UvmGpuUuid *pGpuUuid,
                          NvUPtr *pAddr);

void uvm_init_session_info_array(UvmProcessRecord *pCurrentProcessRecord);

void uvm_init_session_info(UvmSessionInfo *pSessionInfo);

RM_STATUS uvm_add_session_info(unsigned pidTarget, uid_t euidTarget,
                               int *pSessionIndex,
                               UvmProcessCounterInfo *pProcessCounterInfo,
                               unsigned long mappedUserBaseAddress,
                               UvmProcessRecord *pCurrentProcessRecord);

RM_STATUS uvm_remove_session_info(int sessionIndex,
                                  UvmProcessRecord *pCurrentProcessRecord);

RM_STATUS uvm_counter_state_atomic_update(UvmSessionInfo *pSessionInfo,
                                          const UvmCounterConfig *config,
                                          unsigned count);

RM_STATUS uvm_increment_session_count(UvmCounterInfo *pCtrInfo,
                                      UvmCounterName counterName);

RM_STATUS uvm_decrement_session_count(UvmCounterInfo *pCtrInfo,
                                      UvmCounterName counterName);

RM_STATUS uvm_get_counter_index(UvmCounterName counterName,
                                unsigned *counterIndex);

RM_STATUS uvm_get_session_info(int sessionIndex,
                               UvmProcessRecord *pCurrentProcessRecord,
                               UvmSessionInfo **ppSessionInfo);

#endif // _NVIDIA_UVM_LITE_COUNTERS_H_
