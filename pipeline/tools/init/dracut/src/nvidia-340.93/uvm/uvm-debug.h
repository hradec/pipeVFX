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

/*
       uvm-debug.h

       This file contains the debug API for UVM
*/

#ifndef _UVM_DEBUG_H_
#define _UVM_DEBUG_H_

#ifdef __cplusplus
extern "C" {
#endif

#include "uvmtypes.h"

#define UVM_DEBUG_V1    0x00000001

/*******************************************************************************
    Debugging API types
*******************************************************************************/

/*******************************************************************************
* Counter scope: It can be one of the following:
    - Single GPU for a process (UvmCounterScopeProcessSingleGpu)
    - Aggregate of all GPUs for a process (UvmCounterScopeProcessAllGpu)
    - Single GPU system-wide (UvmCounterScopeGlobalSingleGpu)
    (UvmCounterScopeGlobalSingleGpu is not supported for CUDA 6.0)

    Note: The user must not assume that the counter values are equal to zero
    at the time of enabling counters.
    Difference between end state counter value and start state counter value 
    should be used to find out the correct value over a given period of time.
*******************************************************************************/

typedef enum 
{
    UvmCounterScopeProcessSingleGpu = 0,
    UvmCounterScopeProcessAllGpu = 1,
    UvmCounterScopeGlobalSingleGpu = 2
} UvmCounterScope;

// These numbers assigned to the counter name are used to index their value in
// the counter array.
//
typedef enum
{
    UvmCounterNameBytesXferHtD = 0,         // host to device
    UvmCounterNameBytesXferDtH = 1,         // device to host
    UvmCounterNameCpuPageFaultCount = 2,
#ifdef __windows__
    UvmCounterNameWddmBytesXferBtH = 3,         // backing store to host
    UvmCounterNameWddmBytesXferHtB = 4,         // host to backing store
    UvmCounterNameWddmBytesXferDtB = 5,         // eviction (device to backing store)
    UvmCounterNameWddmBytesXferBtD = 6,         // restoration (backing store to device)
#endif
    UVM_TOTAL_COUNTERS
} UvmCounterName;

/*******************************************************************************
    UVM counter config structure

     * scope: Please see the UvmCounterScope  enum (above), for details.
     * name: Name of the counter. Please check UvmCounterName for list.
     * gpuid: Identifies the GPU for which the counter will be enabled/disabled
              This parameter is ignored in AllGpu scopes.
     * state: A value of 0 will disable the counter, a value of 1 will enable 
              the counter.
*******************************************************************************/
typedef struct
{
    UvmCounterScope scope;//UVM_DEBUG_V1
    UvmCounterName name;  //UVM_DEBUG_V1
    UvmGpuUuid gpuid;     //UVM_DEBUG_V1
    unsigned state;       //UVM_DEBUG_V1
} UvmCounterConfig;

#define UVM_COUNTER_CONFIG_STATE_DISABLE_REQUESTED  0
#define UVM_COUNTER_CONFIG_STATE_ENABLE_REQUESTED   1

typedef NvUPtr UvmDebugSession;

/*******************************************************************************
    UvmDebugGetVersion
    
    Get the version number of the UVM debug library

    Arguments:
    
    
    Returns:

    Version Number
*******************************************************************************/
unsigned UvmDebugVersion(void);

/*******************************************************************************
    UvmDebugCreateSession
    
    Creates a handle for a debugging session.
    
    When the client initializes, it will pass in a process handle and get a
    session ID for itself. Subsequent calls to the UVM API will take in that 
    session ID.
    
    There are security requirements to this call. 
    One of the following must be true:
    1.  The session owner must be running as an elevated user
    2.  The session owner and target must belong to the same user and the 
        session owner is at least as privileged as the target.
    
    For CUDA 6.0 we can create at most 64 sessions per debugger process.

    Arguments:
    
        pid: (INPUT)
            Process id for which the debugging session will be created
        
        session: (OUTPUT)
            Handle to the debugging session associated to that pid.
    
    Error codes:
        RM_ERR_PID_NOT_FOUND: If pid is invalid/ not associated with UVM.
        RM_ERR_INSUFFICIENT_PERMISSIONS: If it fails the security check.
        RM_ERR_INSUFFICIENT_RESOURCES: If an attempt is made to allocate more
            than 64 sessions per process.
        RM_ERR_BUSY_RETRY: If internal resources are blocked by other threads.
*******************************************************************************/
RM_STATUS UvmDebugCreateSession (unsigned pid, UvmDebugSession * session);

/*******************************************************************************
    UvmDebugDestroySession
    
    Destroys a debugging session.
    
    Arguments:
    
        session: (INPUT)
            Handle to the debugging session associated to that pid.
    
    Error codes:
        RM_ERR_INVALID_ARGUMENT: If the session is invalid.
        RM_ERR_BUSY_RETRY: If the debug session is in use by some other thread.
*******************************************************************************/
RM_STATUS UvmDebugDestroySession(UvmDebugSession session);

/*******************************************************************************
    UvmDebugCountersEnable
    
    Enables the counters following the user specified configuration.
    
    The user must fill a list with the configuration of the counters it needs to
    either enable or disable. It can only enable one counter per line.
    
    The structure (UvmCounterConfig) has several fields:
     * scope: Please see the UvmCounterScope  enum (above), for details.
     * name: Name of the counter. Please check UvmCounterName for list.
     * gpuid: Identifies the GPU for which the counter will be enabled/disabled
              This parameter is ignored in AllGpu scopes.
     * state: A value of 0 will disable the counter, a value of 1 will enable 
              the counter.

     Note: All counters are refcounted, that means that a counter will only be
     disable when its refcount reached zero.
    
    Arguments:
    
        session: (INPUT)
            Handle to the debugging session.
        
        config: (INPUT)
            pointer to configuration list as per above.
        
        count: (INPUT)
            number of entries in the config list.
    
    Error codes:
        RM_ERR_INSUFFICIENT_PERMISSIONS:  if it fails the security check 
        RM_INVALID_ARGUMENT: If debugging session is invalid or if one of the 
            counter lines is invalid. If call returns this value, no action 
            specified by the config list will have taken effect.
        RM_ERR_NOT_SUPPORTED: UvmCounterScopeGlobalSingleGpu is not supported 
            for CUDA 6.0
        RM_ERR_BUSY_RETRY: If the debug session is in use by some other thread.
*******************************************************************************/
RM_STATUS UvmDebugCountersEnable(UvmDebugSession session, 
                                UvmCounterConfig * config,
                                unsigned count);

/*******************************************************************************
    UvmDebugGetCounterHandle

    Returns handle to a particular counter. This is an opaque handle that the 
    implementation uses in order to find your counter, later.
    This handle can be used in subsequent calls to UvmDebugGetCounterVal().

    Arguments:

        session: (INPUT)
            Handle to the debugging session.

        scope: (INPUT)
            Scope that will be mapped.

        counterName: (INPUT)
            Name of the counter in that scope.

        UvmGpuUuid: (INPUT)
            Gpuid of the scoped GPU. This parameter is ignored in AllGpu scopes.

        pCounterHandle: (OUTPUT)
            Handle to the counter address.

    Error codes:
        RM_ERR_INVALID_ARGUMENT: If the specified scope/gpu pair or session id is 
            invalid
        RM_ERR_NOT_SUPPORTED: UvmCounterScopeGlobalSingleGpu is not supported 
            for CUDA 6.0
        RM_ERR_BUSY_RETRY: If the debug session is in use by some other thread. 
*******************************************************************************/
RM_STATUS UvmDebugGetCounterHandle(UvmDebugSession session,
                               UvmCounterScope scope,
                               UvmCounterName counterName,
                               UvmGpuUuid gpu,
                               NvUPtr *pCounterHandle);

/*******************************************************************************
    UvmDebugGetCounterVal

    Returns the counter value specified by the counter name.

    Arguments:

        session: (INPUT)
            Handle to the debugging session.
        
        counterHandleArray: (INPUT)
            Array of counter handles
        
        handleCount: (INPUT)
            Number of handles in the pPCounterHandle array.

        counterValArray: (OUTPUT)
            Array of counter values corresponding to the handles.

    Error codes:
        RM_ERR_INVALID_ARGUMENT: If any of the specified handles is invalid.
*******************************************************************************/
RM_STATUS UvmDebugGetCounterVal(UvmDebugSession session,
                            NvUPtr *counterHandleArray,
                            unsigned handleCount,
                            unsigned long long *counterValArray);
#ifdef __cplusplus
}
#endif

#endif // _UVM_DEBUG_H_

