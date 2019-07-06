/* _NVRM_COPYRIGHT_BEGIN_
 *
 * Copyright 1999-2011 by NVIDIA Corporation.  All rights reserved.  All
 * information contained herein is proprietary and confidential to NVIDIA
 * Corporation.  Any use, reproduction, or disclosure without the written
 * permission of NVIDIA Corporation is prohibited.
 *
 * _NVRM_COPYRIGHT_END_
 */

#define  __NO_VERSION__
#include "nv-misc.h"

#include "os-interface.h"
#include "nv-linux.h"

#if defined(CONFIG_SMP) && !defined(NV_CONFIG_PREEMPT_RT)
static atomic_t os_smp_barrier = ATOMIC_INIT(0);

static void ipi_handler(void *info)
{
    while (atomic_read(&os_smp_barrier) != 0)
        NV_CPU_RELAX();
}
#endif

RM_STATUS NV_API_CALL os_raise_smp_barrier(void)
{
#if !defined(NV_CONFIG_PREEMPT_RT)
    int ret = 0;
    if (!NV_MAY_SLEEP())
    {
        os_dbg_breakpoint();
        return RM_ERR_NOT_SUPPORTED;
    }
#if defined(CONFIG_SMP)
    if (atomic_read(&os_smp_barrier) != 0)
        return RM_ERR_INVALID_STATE;
#if defined(preempt_disable)
    preempt_disable();
#endif
    NV_LOCAL_BH_DISABLE();
    atomic_set(&os_smp_barrier, 1);
    ret = NV_SMP_CALL_FUNCTION(ipi_handler, NULL, 0);
#endif
    return (ret == 0) ? RM_OK : RM_ERROR;
#else
    return RM_ERR_NOT_SUPPORTED;
#endif
}

RM_STATUS NV_API_CALL os_clear_smp_barrier(void)
{
#if !defined(NV_CONFIG_PREEMPT_RT)
#if defined(CONFIG_SMP)
    if (atomic_read(&os_smp_barrier) == 0)
        return RM_OK;
    atomic_set(&os_smp_barrier, 0);
    NV_LOCAL_BH_ENABLE();
#if defined(preempt_enable)
    preempt_enable();
#endif
#endif
    return RM_OK;
#else
    return RM_ERR_NOT_SUPPORTED;
#endif
}

RM_STATUS NV_API_CALL os_alloc_smp_barrier(void)
{
    return RM_OK;
}

RM_STATUS NV_API_CALL os_free_smp_barrier(void)
{
    return RM_OK;
}
