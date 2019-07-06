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
// This file contains supporting functions to get proper process/ gpu 
// information required for incrementing/ enabling/ mapping counters.
//
#include "nvidia_uvm_common.h"
#include "nvidia_uvm_lite_counters.h"
#include "nvidia_uvm_lite.h"
#include "uvm_ioctl.h"

// Session index is initialized to an invalid value.
static const int UVM_SESSION_INDEX_INIT_VALUE   = -1;

void uvm_init_session_info_array(UvmProcessRecord *pCurrentProcessRecord)
{
    init_rwsem(&pCurrentProcessRecord->sessionInfoLock);
    memset(pCurrentProcessRecord->sessionInfoArray, 0, 
           sizeof (pCurrentProcessRecord->sessionInfoArray));
}

//
// Locking: you must hold SessionInfoLock for read before calling this routine.
//
RM_STATUS uvm_get_session_info
(
    int sessionIndex, 
    UvmProcessRecord *pCurrentProcessRecord,
    UvmSessionInfo **ppSessionInfo
)
{
    // check if session index is valid
    if((sessionIndex > UVM_SESSION_INDEX_INIT_VALUE) &&
      (sessionIndex < UVM_MAX_SESSIONS_PER_PROCESS))
    {
        unsigned pidCurrent = uvm_get_stale_process_id();

        // check if the current process id is the session owner
        if (pCurrentProcessRecord->sessionInfoArray[sessionIndex].
            pidSessionOwner != pidCurrent)
        {
            return RM_ERR_INSUFFICIENT_PERMISSIONS;
        }

        *ppSessionInfo = &pCurrentProcessRecord->sessionInfoArray[sessionIndex];

        return RM_OK;
    }

    return RM_ERR_INVALID_ARGUMENT;
}


// Locking: this function uses sessionInfoLock
RM_STATUS uvm_add_session_info
(
    unsigned pidTarget,
    uid_t euidTarget,
    int *pSessionIndex,
    UvmProcessCounterInfo *pProcessCounterInfo,
    unsigned long mappedUserBaseAddress,
    UvmProcessRecord *pCurrentProcessRecord
)
{
    int sessionArrayIndex;
    UvmSessionInfo *pSessionInfo = NULL;

    down_write(&pCurrentProcessRecord->sessionInfoLock);

    for(sessionArrayIndex = 0; sessionArrayIndex < UVM_MAX_SESSIONS_PER_PROCESS;
        sessionArrayIndex++)
    {
        if (pCurrentProcessRecord->sessionInfoArray[sessionArrayIndex].
            pidSessionOwner ==  UVM_PID_INIT_VALUE)
        {
            pSessionInfo = 
                &pCurrentProcessRecord->sessionInfoArray[sessionArrayIndex];

            // save a pointer to the counter information of the target process
            pSessionInfo->pTargetCounterInfo = pProcessCounterInfo;
            // save the owner pid (used later for validating the session owner)
            pSessionInfo->pidSessionOwner = uvm_get_stale_process_id();
            pSessionInfo->pidTarget = pidTarget;
            pSessionInfo->euidTarget = euidTarget;
            pSessionInfo->mappedUserBaseAddress = mappedUserBaseAddress;

            *pSessionIndex = sessionArrayIndex;
            break;
        }
    }
    up_write(&pCurrentProcessRecord->sessionInfoLock);

    if (pSessionInfo == NULL)
        return RM_ERR_INSUFFICIENT_RESOURCES;
    
    return RM_OK;
}

void uvm_init_session_info(UvmSessionInfo *pSessionInfo)
{
    pSessionInfo->pTargetCounterInfo = NULL;
    pSessionInfo->pidSessionOwner = UVM_PID_INIT_VALUE;
    pSessionInfo->euidTarget = UVM_ROOT_UID;
}

//
// Locking: this function uses sessionInfoLock
// 
RM_STATUS uvm_remove_session_info
(
    int sessionIndex,
    UvmProcessRecord *pCurrentProcessRecord
)
{
    UvmSessionInfo *pSessionInfo;
    RM_STATUS status;

    down_write(&pCurrentProcessRecord->sessionInfoLock);

    status = uvm_get_session_info(sessionIndex,
                                  pCurrentProcessRecord,
                                  &pSessionInfo);
    if ( status == RM_OK)
    {
        //
        // Free counter information if this is the only process using it.
        // This would happen if the target process has exited.
        //
        uvmlite_put_and_unrefcount_process_counter_info(
            pSessionInfo->pTargetCounterInfo);

        uvm_init_session_info(pSessionInfo);
    }
    up_write(&pCurrentProcessRecord->sessionInfoLock);

    return status;
}

//
// Locking: Need to acquire process lock before incrementing process counters
//
void uvm_increment_process_counters
(
    UvmCounterInfo *procSingleGpuCounter, 
    UvmProcessRecord* pProcessRecord,
    UvmCounterName counterName,
    unsigned incrementVal
)
{
    unsigned long long *counterArray;
    // The value of the counter name is used as its index in the counter array
    unsigned counterIndex = counterName;

    // Increment process all gpu counters if any session has enabled them.
    
    if (NV_ATOMIC_READ(pProcessRecord->pProcessCounterInfo->
        procAllGpuCounter.sessionCount[counterIndex]) != 0)
    {
        counterArray = 
               pProcessRecord->pProcessCounterInfo->procAllGpuCounter.sysAddr;
        counterArray[counterIndex] = counterArray[counterIndex] + incrementVal;
    }
    

    // Process Single Gpu counters are enabled by default:
      
    counterArray = procSingleGpuCounter->sysAddr;
    counterArray[counterIndex] = counterArray[counterIndex] + incrementVal;
}

//
// This function returns the offset at which the counter value is present
//
static RM_STATUS NvUvmGetCounterOffset
(
    unsigned long pUserMappedCounterPage,
    UvmCounterName counterName,
    NvUPtr* pAddr
)
{
    RM_STATUS status;
    unsigned counterIndex;

    // Check if the counter name is valid and get its index
    status = uvm_get_counter_index(counterName, &counterIndex);

    if(status == RM_OK)
        *pAddr = pUserMappedCounterPage + counterIndex * UVM_COUNTER_SIZE;
    return status;
}

//
// Picks user VA for a given counter and returns offset of that counter
//
// Locking: you must hold SessionInfoLock for read before calling this routine.
//
RM_STATUS uvm_map_counter
(
    UvmSessionInfo *pSessionInfo,
    UvmCounterScope scope,
    UvmCounterName counterName,
    UvmGpuUuid *pGpuUuid,
    NvUPtr* pAddr
)
{
    unsigned long pUserMappedCounterPage;
    unsigned gpuIndex;

    switch (scope)
    {
        case UvmCounterScopeProcessSingleGpu:
            if(uvmlite_find_gpu_index(pGpuUuid, &gpuIndex) != RM_OK)
                return RM_ERR_INVALID_ARGUMENT;
 
            pUserMappedCounterPage = pSessionInfo->mappedUserBaseAddress + 
                                     gpuIndex * UVM_PER_RESOURCE_COUNTERS_SIZE +
                                     UVM_PER_PROCESS_PER_GPU_COUNTERS_SHIFT;
            break;

        case UvmCounterScopeProcessAllGpu:
            pUserMappedCounterPage = pSessionInfo->mappedUserBaseAddress;
            break;

        case UvmCounterScopeGlobalSingleGpu:
            return RM_ERR_NOT_SUPPORTED;
        default:
            return RM_ERR_INVALID_ARGUMENT;
    }

    return NvUvmGetCounterOffset(pUserMappedCounterPage, counterName, pAddr);
}

//
// Enables counters specified by the processId and config structure.
//
// Locking: you must hold SessionInfoLock for read before calling this routine.
//
RM_STATUS uvm_counter_state_atomic_update
(
    UvmSessionInfo *pSessionInfo,
    const UvmCounterConfig *config,
    unsigned count
)
{
    const UvmCounterConfig *currConfig;
    unsigned counterNum;
    RM_STATUS status = RM_OK;
    UvmProcessCounterInfo *pProcessCounterInfo;

    if (count > UVM_MAX_COUNTERS_PER_IOCTL_CALL)
        return RM_ERR_INVALID_ARGUMENT;

    pProcessCounterInfo = pSessionInfo->pTargetCounterInfo;

    for (counterNum = 0; counterNum < count; counterNum++)
    {
        currConfig = &config[counterNum];

        switch (currConfig->scope)
        {
            case UvmCounterScopeProcessSingleGpu:
                // These are enabled by default and cannot be disabled
                break;

            case UvmCounterScopeProcessAllGpu:
                if(currConfig->state == 
                UVM_COUNTER_CONFIG_STATE_ENABLE_REQUESTED)
                    status = uvm_increment_session_count(
                        &pProcessCounterInfo->procAllGpuCounter,
                        currConfig->name);
                else
                    status = uvm_decrement_session_count(
                        &pProcessCounterInfo->procAllGpuCounter,
                        currConfig->name);
                break;

            case UvmCounterScopeGlobalSingleGpu:
                return RM_ERR_NOT_SUPPORTED;
            default:
                return RM_ERR_INVALID_ARGUMENT;
        }
    }

    return status;
}

RM_STATUS uvm_increment_session_count
(
    UvmCounterInfo *pCtrInfo,
    UvmCounterName counterName
)
{
    unsigned counterIndex;
    RM_STATUS status;

    status = uvm_get_counter_index(counterName, &counterIndex);
    if(status == RM_OK)
        NV_ATOMIC_INC(pCtrInfo->sessionCount[counterIndex]);

    return status;
}

RM_STATUS uvm_decrement_session_count
(
    UvmCounterInfo *pCtrInfo,
    UvmCounterName counterName
)
{
    unsigned counterIndex;
    RM_STATUS status;

    status = uvm_get_counter_index(counterName, &counterIndex);
    if(status == RM_OK)
        NV_ATOMIC_DEC(pCtrInfo->sessionCount[counterIndex]);

    return status;
}

//
// this function checks if the countername is valid and returns its index
//
RM_STATUS uvm_get_counter_index
(
    UvmCounterName counterName,
    unsigned *counterIndex
)
{
    if(counterName >= 0 && counterName < UVM_TOTAL_COUNTERS) 
    {
        *counterIndex = counterName;
        return RM_OK;
    }
    return RM_ERR_INVALID_ARGUMENT;
}
