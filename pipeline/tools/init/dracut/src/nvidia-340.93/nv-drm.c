/* _NVRM_COPYRIGHT_BEGIN_
 *
 * Copyright 2013 by NVIDIA Corporation.  All rights reserved.  All
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

#if defined(NV_DRM_AVAILABLE)

#include <drm/drmP.h>

#if defined(NV_DRM_DRM_GEM_H_PRESENT)
#include <drm/drm_gem.h>
#endif

extern nv_linux_state_t *nv_linux_devices;

struct nv_gem_object {
    struct drm_gem_object base;
    struct page **pages;
};

static int nv_drm_load(
    struct drm_device *dev,
    unsigned long flags
)
{
    nv_linux_state_t *nvl;

    for (nvl = nv_linux_devices; nvl != NULL; nvl = nvl->next)
    {
        if (nvl->dev == dev->pdev)
        {
            nvl->drm = dev;
            return 0;
        }
    }

    return -ENODEV;
}

static int nv_drm_unload(
    struct drm_device *dev
)
{
    nv_linux_state_t *nvl;

    for (nvl = nv_linux_devices; nvl != NULL; nvl = nvl->next)
    {
        if (nvl->dev == dev->pdev)
        {
            BUG_ON(nvl->drm != dev);
            nvl->drm = NULL;
            return 0;
        }
    }

    return -ENODEV;
}

static void nv_gem_free(
    struct drm_gem_object *obj
)
{
    struct nv_gem_object *nv_obj = container_of(obj, struct nv_gem_object, base);
    NV_KFREE(nv_obj, sizeof(*nv_obj));
}

static struct sg_table* nv_gem_prime_get_sg_table(
    struct drm_gem_object *obj
)
{
    struct nv_gem_object *nv_obj = container_of(obj, struct nv_gem_object, base);
    int page_count = obj->size >> PAGE_SHIFT;

    return drm_prime_pages_to_sg(nv_obj->pages, page_count);
}

static void* nv_gem_prime_vmap(
    struct drm_gem_object *obj
)
{
    struct nv_gem_object *nv_obj = container_of(obj, struct nv_gem_object, base);
    int page_count = obj->size >> PAGE_SHIFT;

    return vmap(nv_obj->pages, page_count, VM_USERMAP, PAGE_KERNEL);
}

static void nv_gem_prime_vunmap(
    struct drm_gem_object *obj,
    void *virtual
)
{
    vunmap(virtual);
}

static const struct file_operations nv_drm_fops = {
    .owner = THIS_MODULE,
    .open = drm_open,
    .release = drm_release,
    .unlocked_ioctl = drm_ioctl,
    .mmap = drm_gem_mmap,
    .poll = drm_poll,
    .read = drm_read,
    .llseek = noop_llseek,
};

static struct drm_driver nv_drm_driver = {
    .driver_features = DRIVER_GEM | DRIVER_PRIME,
    .load = nv_drm_load,
    .unload = nv_drm_unload,
    .fops = &nv_drm_fops,
#if defined(NV_DRM_PCI_SET_BUSID_PRESENT)
    .set_busid = drm_pci_set_busid,
#endif

    .gem_free_object = nv_gem_free,

    .prime_handle_to_fd = drm_gem_prime_handle_to_fd,
    .gem_prime_export = drm_gem_prime_export,
    .gem_prime_get_sg_table = nv_gem_prime_get_sg_table,
    .gem_prime_vmap = nv_gem_prime_vmap,
    .gem_prime_vunmap = nv_gem_prime_vunmap,

    .name = "nvidia-drm",
    .desc = "NVIDIA DRM driver",
    .date = "20150116",
    .major = 0,
    .minor = 0,
    .patchlevel = 0,
};
#endif /* defined(NV_DRM_AVAILABLE) */

int __init nv_drm_init(
    struct pci_driver *pci_driver
)
{
    int ret = 0;
#if defined(NV_DRM_AVAILABLE)
    ret = drm_pci_init(&nv_drm_driver, pci_driver);
#endif
    return ret;
}

void nv_drm_exit(
    struct pci_driver *pci_driver
)
{
#if defined(NV_DRM_AVAILABLE)
    drm_pci_exit(&nv_drm_driver, pci_driver);
#endif
}

RM_STATUS NV_API_CALL nv_alloc_os_descriptor_handle(
    nv_state_t *nv,
    NvS32 drm_fd,
    void *private,
    NvU64 page_count,
    NvU32 *handle
)
{
    RM_STATUS status = RM_ERR_NOT_SUPPORTED;

#if defined(NV_DRM_AVAILABLE)
    nv_linux_state_t *nvl = NV_GET_NVL_FROM_NV_STATE(nv);
    nv_dma_map_t *dma_map = private;
    struct file *drmf;
    struct drm_file *file_priv;
    struct nv_gem_object *nv_obj = NULL;
    size_t size = page_count << PAGE_SHIFT;
    int ret;

    if (drm_fd < 0)
    {
        return RM_ERR_INVALID_ARGUMENT;
    }

    drmf = fget((unsigned int)drm_fd);
    if (drmf == NULL)
    {
        return RM_ERR_INVALID_ARGUMENT;
    }

    if (drmf->f_op != &nv_drm_fops)
    {
        status = RM_ERR_INVALID_ARGUMENT;
        goto done;
    }

    file_priv = drmf->private_data;

    NV_KMALLOC(nv_obj, sizeof(*nv_obj));
    if (!nv_obj)
    {
        status = RM_ERR_INSUFFICIENT_RESOURCES;
        goto done;
    }

    memset(&nv_obj->base, 0, sizeof(nv_obj->base));
    nv_obj->pages = dma_map->user_pages;

    drm_gem_private_object_init(nvl->drm, &nv_obj->base, size);

    ret = drm_gem_handle_create(file_priv, &nv_obj->base, handle);
    if (ret)
    {
        status = RM_ERR_OPERATING_SYSTEM;
        goto done;
    }

    drm_gem_object_unreference_unlocked(&nv_obj->base);

    status = RM_OK;

done:
    if (status != RM_OK)
    {
        NV_KFREE(nv_obj, sizeof(*nv_obj));
    }

    fput(drmf);
#endif

    return status;
}
