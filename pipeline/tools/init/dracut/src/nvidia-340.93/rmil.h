/* _NVRM_COPYRIGHT_BEGIN_
 *
 * Copyright 2009 by NVIDIA Corporation.  All rights reserved.  All
 * information contained herein is proprietary and confidential to NVIDIA
 * Corporation.  Any use, reproduction, or disclosure without the written
 * permission of NVIDIA Corporation is prohibited.
 *
 * _NVRM_COPYRIGHT_END_
 */


#ifndef _RMIL_H_
#define _RMIL_H_

int        NV_API_CALL  rm_gvi_isr                  (nv_stack_t *, nv_state_t *, NvU32 *);
void       NV_API_CALL  rm_gvi_bh                   (nv_stack_t *, nv_state_t *);
RM_STATUS  NV_API_CALL  rm_gvi_attach_device        (nv_stack_t *, nv_state_t *);
RM_STATUS  NV_API_CALL  rm_gvi_detach_device        (nv_stack_t *, nv_state_t *);
BOOL       NV_API_CALL  rm_gvi_init_private_state   (nv_stack_t *, nv_state_t *);
BOOL       NV_API_CALL  rm_init_gvi_device          (nv_stack_t *, nv_state_t *);
NvU32      NV_API_CALL  rm_shutdown_gvi_device      (nv_stack_t *, nv_state_t *);
NvU32      NV_API_CALL  rm_gvi_suspend              (nv_stack_t *, nv_state_t *);
NvU32      NV_API_CALL  rm_gvi_resume               (nv_stack_t *, nv_state_t *);
BOOL       NV_API_CALL  rm_gvi_free_private_state   (nv_stack_t *, nv_state_t *);
RM_STATUS  NV_API_CALL  rm_gvi_get_device_name      (nv_stack_t *, nv_state_t *, NvU32, NvU32, NvU8 *);
RM_STATUS  NV_API_CALL  rm_gvi_get_firmware_version (nv_stack_t *, nv_state_t *, NvU32 *, NvU32 *, NvU32 *);

#endif // _RMIL_H_
