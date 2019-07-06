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
 * nvidia_uvm_common.c
 *
 * This file contains code that is common to all variants of the (Linux) UVM
 * kernel module.
 *
 * Initially, UVM-Lite and Uvm-Next work is proceeding somewhat
 * independently, but the long- and short-term plan is for them to share the
 * same kernel module (this one). That's why, at least initially, you'll find
 * files for UVM-Lite, for Uvm-Next, and for common code. We'll refactor as
 * necessary, to achieve the right balance of sharing code and decoupling the
 * features.
 *
 * --jhubbard
 *
 */

#include "nvidia_uvm_common.h"
#include "nvidia_uvm_linux.h"

// TODO: Remove this when the GPU event stubs are no longer needed
#include "nv_uvm_interface.h"

#if defined(NVIDIA_UVM_LITE_ENABLED)
#include "nvidia_uvm_lite.h"
#else
static int uvmlite_init(dev_t uvmBaseDev)
{
    return 0;
}
static void uvmlite_exit(void)
{

}
static RM_STATUS uvmlite_gpu_event_start_device(UvmGpuUuid *gpuUuidStruct)
{
    return RM_OK;
}
static RM_STATUS uvmlite_gpu_event_stop_device(UvmGpuUuid *gpuUuidStruct)
{
    return RM_OK;
}
static int uvmlite_setup_gpu_list(void)
{
    return 0;
}
#endif // NVIDIA_UVM_LITE_ENABLED

#if defined(NVIDIA_UVM_NEXT_ENABLED)
#include "nvidia_uvm_next.h"
#else
static int uvmnext_init(dev_t uvmBaseDev)
{
    return 0;
}
static void uvmnext_exit(void)
{

}
static RM_STATUS uvmnext_isr_top_half(void)
{
    return RM_ERR_NO_INTR_PENDING;
}
static RM_STATUS uvmnext_gpu_event_start_device(UvmGpuUuid *gpuUuidStruct)
{
    return RM_OK;
}
static RM_STATUS uvmnext_gpu_event_stop_device(UvmGpuUuid *gpuUuidStruct)
{
    return RM_OK;
}
#endif // NVIDIA_UVM_NEXT_ENABLED

static dev_t g_uvmBaseDev;
struct UvmOpsUvmEvents g_exportedUvmOps;

// TODO: This would be easier if RM allowed for multiple registrations, since we
//       could register UVM-Lite and UVM-Next separately (bug 1372835).
static RM_STATUS uvm_gpu_event_start_device(UvmGpuUuid *gpuUuidStruct)
{
    RM_STATUS rmStatus;

    if (uvmlite_enabled())
    {
        rmStatus = uvmlite_gpu_event_start_device(gpuUuidStruct);
        if (rmStatus != RM_OK)
            return rmStatus;
    }

    if (uvmnext_enabled())
    {
        rmStatus = uvmnext_gpu_event_start_device(gpuUuidStruct);
        if (rmStatus != RM_OK)
        {
            // Take UVM-Lite back down if UVM-Next failed to start
            if (uvmlite_enabled())
                uvmlite_gpu_event_stop_device(gpuUuidStruct);
            return rmStatus;
        }
    }

    return RM_OK;
}

static RM_STATUS uvm_gpu_event_stop_device(UvmGpuUuid *gpuUuidStruct)
{
    RM_STATUS uvmliteStatus = RM_OK, uvmnextStatus = RM_OK;

    // Stop both of them even when one returns an error
    if (uvmlite_enabled())
        uvmliteStatus = uvmlite_gpu_event_stop_device(gpuUuidStruct);

    if (uvmnext_enabled())
        uvmnextStatus = uvmnext_gpu_event_stop_device(gpuUuidStruct);

    if (uvmliteStatus != RM_OK)
        return uvmliteStatus;

    return uvmnextStatus;
}

static RM_STATUS uvmSetupGpuProvider(void)
{
    RM_STATUS status = RM_OK;

#ifdef NVIDIA_UVM_RM_ENABLED
    g_exportedUvmOps.startDevice = uvm_gpu_event_start_device;
    g_exportedUvmOps.stopDevice  = uvm_gpu_event_stop_device;
    g_exportedUvmOps.isrTopHalf  = uvmnext_isr_top_half;

    // call RM to exchange the function pointers.
    status = nvUvmInterfaceRegisterUvmCallbacks(&g_exportedUvmOps);
#endif
    return status;
}

static int __init uvm_init(void)
{
    int ret = 0;
    int devAlloced = 0;
    int uvmliteInitialized = 0;
    int uvmnextInitialized = 0;
    int registered = 0;
    RM_STATUS rmStatus;

    // The various helper init routines will create their own minor devices, so
    // we only need to create space for them here.
    ret = alloc_chrdev_region(&g_uvmBaseDev,
                              0,
                              NVIDIA_UVM_NUM_MINOR_DEVICES,
                              NVIDIA_UVM_DEVICE_NAME);
    if (ret)
    {
        UVM_ERR_PRINT("alloc_chrdev_region failed: %d\n", ret);
        goto error;
    }
    devAlloced = 1;

    if (uvmlite_enabled())
    {
        ret = uvmlite_init(g_uvmBaseDev);
        if (ret)
            goto error;
        uvmliteInitialized = 1;
    }

    if (uvmnext_enabled())
    {
        ret = uvmnext_init(g_uvmBaseDev);
        if (ret)
            goto error;
        uvmnextInitialized = 1;
    }

    // Register with RM
    //
    // TODO: This should probably happen before calling uvmlite_init and
    //       uvmnext_init, so those routines can make RM calls as part of their
    //       setup. But doing that means we could get event callbacks before
    //       those init routines are called, which is scary. Ideally this could
    //       be solved by having RM handle multiple registrations (bug 1372835).
    if (rm_enabled())
    {
        rmStatus = uvmSetupGpuProvider();
        if (rmStatus != RM_OK)
        {
            UVM_ERR_PRINT("Cannot register ops with NVIDIA driver. UVM error: 0x%x\n",
                          rmStatus);
            // TODO: Need a helper function to convert from RM_STATUS to errno
            ret = -EINVAL;
            goto error;
        }
        registered = 1;
    }

    // Query GPU list from RM
    //
    // TODO: This should be called within uvmlite_init but the RM calls aren't
    //       enabled until after the uvmSetupGpuProvider call above. This can be
    //       moved once multiple RM registrations are allowed (bug 1372835).
    //       Until then we need a dummy symbol.
    if(uvmliteInitialized && registered)
    {
        ret = uvmlite_setup_gpu_list();
        if (ret)
        {
            UVM_ERR_PRINT("uvm_lite_setup_gpu_list failed\n");
            goto error;
        }
    }

    pr_info("Loaded the UVM driver, major device number %d\n",
            MAJOR(g_uvmBaseDev));

    return 0;

error:
#ifdef NVIDIA_UVM_RM_ENABLED
    if (registered)
        nvUvmInterfaceDeRegisterUvmOps();
#endif

    if (uvmliteInitialized)
        uvmlite_exit();

    if (uvmnextInitialized)
        uvmnext_exit();

    if (devAlloced)
        unregister_chrdev_region(g_uvmBaseDev, NVIDIA_UVM_NUM_MINOR_DEVICES);

    return ret;
}

static void __exit uvm_exit(void)
{
#ifdef NVIDIA_UVM_RM_ENABLED
    // this will cleanup registered interfaces
    nvUvmInterfaceDeRegisterUvmOps();
#endif

    if (uvmlite_enabled())
        uvmlite_exit();

    if (uvmnext_enabled())
        uvmnext_exit();

    unregister_chrdev_region(g_uvmBaseDev, NVIDIA_UVM_NUM_MINOR_DEVICES);

    pr_info("Unregistered the UVM driver\n");
}

//
// Convert kernel errno codes to corresponding RM_STATUS
//
RM_STATUS errno_to_rm_status(int errnoCode)
{
    if (errnoCode < 0)
        errnoCode = -errnoCode;

    switch (errnoCode)
    {
        case 0:
            return RM_OK;

        case E2BIG:
        case EINVAL:
            return RM_ERR_INVALID_ARGUMENT;

        case EACCES:
            return RM_ERR_INSUFFICIENT_PERMISSIONS;

        case EADDRINUSE:
        case EADDRNOTAVAIL:
            return RM_ERR_UVM_ADDRESS_IN_USE;

        case EFAULT:
            return RM_ERR_INVALID_ADDRESS;

        case EINTR:
            return RM_ERR_BUSY_RETRY;

        case ENODEV:
            return RM_ERR_MODULE_LOAD_FAILED;

        case ENOMEM:
            return RM_ERR_NO_MEMORY;

        case EPERM:
            return RM_ERR_INSUFFICIENT_PERMISSIONS;

        default:
            return RM_ERROR;
    };
}

//
// This routine retrieves the process ID of current, but makes no attempt to
// refcount or lock the pid in place, because that capability is only available
// to GPL-licenses device drivers.
//
// TODO: use the GPL-protected routines if and when we are able to change over
// to a dual MIT/GPL license (bug 1483843).
//
unsigned uvm_get_stale_process_id(void)
{
    return (unsigned) current->tgid;
}

//
// A simple security rule for allowing access to UVM user space memory: if you
// are the same user as the owner of the memory, or if you are root, then you
// are granted access. The idea is to allow debuggers and profilers to work, but
// without opening up any security holes.
//
NvBool uvm_user_id_security_check(uid_t euidTarget)
{
    return (NV_CURRENT_EUID() == euidTarget) ||
           (UVM_ROOT_UID == euidTarget);
}

// Locking: you must hold mm->mmap_sem write lock before calling this function
RM_STATUS uvm_map_page(struct vm_area_struct *vma, struct page *page,
                       unsigned long addr)
{
    if (vm_insert_page(vma, addr, page) == 0)
        return RM_OK;

    return RM_ERR_INVALID_ARGUMENT;
}


module_init(uvm_init);
module_exit(uvm_exit);
MODULE_LICENSE("MIT");
MODULE_INFO(supported, "external");
