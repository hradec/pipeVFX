/* _NVRM_COPYRIGHT_BEGIN_
 *
 * Copyright 2000-2001 by NVIDIA Corporation.  All rights reserved.  All
 * information contained herein is proprietary and confidential to NVIDIA
 * Corporation.  Any use, reproduction, or disclosure without the written
 * permission of NVIDIA Corporation is prohibited.
 *
 * _NVRM_COPYRIGHT_END_
 */

#define  __NO_VERSION__
#define NV_DEFINE_REGISTRY_KEY_TABLE
#include "nv-misc.h"
#include "os-interface.h"
#include "nv-linux.h"
#include "nv-reg.h"

static char *remove_spaces(const char *in)
{
    unsigned int len = strlen(in) + 1;
    const char *in_ptr;
    char *out, *out_ptr;

    if (os_alloc_mem((void **)&out, len) != RM_OK)
        return NULL;

    in_ptr = in;
    out_ptr = out;

    while (*in_ptr != '\0')
    {
        if (!isspace(*in_ptr)) *out_ptr++ = *in_ptr;
        in_ptr++;
    }
    *out_ptr = '\0';

    return out;
}

static void parse_option_string(nv_stack_t *sp)
{
    unsigned int i;
    nv_parm_t *entry;
    char *option_string = NULL;
    char *ptr, *token;
    char *name, *value;
    NvU32 data;

    if (NVreg_RegistryDwords != NULL)
    {
        if ((option_string = remove_spaces(NVreg_RegistryDwords)) == NULL)
        {
            return;
        }

        ptr = option_string;

        while ((token = strsep(&ptr, ";")) != NULL)
        {
            if (!(name = strsep(&token, "=")) || !strlen(name))
            {
                continue;
            }

            if (!(value = strsep(&token, "=")) || !strlen(value))
            {
                continue;
            }

            if (strsep(&token, "=") != NULL)
            {
                continue;
            }

            data = (NvU32)simple_strtoul(value, NULL, 0);

            for (i = 0; (entry = &nv_parms[i])->name != NULL; i++)
            {
                if (strcmp(entry->name, name) == 0)
                    break;
            }

            if (!entry->name)
                rm_write_registry_dword(sp, NULL, "NVreg", name, data);
            else
                *entry->data = data;
        }

        os_free_mem(option_string);
    }
}

#if !defined(NV_VMWARE)
static NvBool parse_assign_gpus_string(void)
{
    char *option_string = NULL;
    char *ptr, *token;

    if (NVreg_AssignGpus == NULL)
    {
        return NV_FALSE;
    }

    if ((option_string = remove_spaces(NVreg_AssignGpus)) == NULL)
    {
        return NV_FALSE;
    }

    ptr = option_string;

    // token string should be in formats:
    //   bus:slot
    //   domain:bus:slot
    //   domain:bus:slot.func

    while ((token = strsep(&ptr, ",")) != NULL)
    {
        char *pci_info, *p, *q, *r, *func = token;
        NvU32 domain, bus, slot;

        if (!strlen(token))
        {
            continue;
        }

        if ((pci_info = strsep(&func, ".")) != NULL)
        {
            // PCI device can have maximum 8 functions and for GPUs, function
            // field is always 0
            if ((func != NULL) && ((*func != '0') || (strlen(func) > 1)))
            {
                nv_printf(NV_DBG_ERRORS,
                          "NVRM: NVreg_AssignGpus: Invalid PCI function in token %s\n",
                          token);
                continue;
            }

            domain = simple_strtoul(pci_info, &p, 16);

            if ((p == NULL) || (*p != ':') || (*(p + 1) == '\0'))
            {
                nv_printf(NV_DBG_ERRORS,
                          "NVRM: NVreg_AssignGpus: Invalid PCI domain/bus in token %s\n",
                          token);
                continue;
            }

            bus = simple_strtoul((p + 1), &q, 16);

            if (q == NULL)
            {
                nv_printf(NV_DBG_ERRORS,
                          "NVRM: NVreg_AssignGpus: Invalid PCI bus/slot in token %s\n",
                          token);
                continue;
            }

            if (*q != '\0')
            {
                if ((*q != ':') || (*(q + 1) == '\0'))
                {
                    nv_printf(NV_DBG_ERRORS,
                              "NVRM: NVreg_AssignGpus: Invalid PCI slot in token %s\n",
                              token);
                    continue;
                }

                slot = (NvU32)simple_strtoul(q + 1, &r, 16);
                if ((slot == 0) && ((q + 1) == r))
                {
                    nv_printf(NV_DBG_ERRORS,
                              "NVRM: NVreg_AssignGpus: Invalid PCI slot in token %s\n",
                              token);
                    continue;
                }

                nv_assign_gpu_pci_info[nv_assign_gpu_count].domain = domain;
                nv_assign_gpu_pci_info[nv_assign_gpu_count].bus = bus;
                nv_assign_gpu_pci_info[nv_assign_gpu_count].slot = slot;
            }
            else
            {
                nv_assign_gpu_pci_info[nv_assign_gpu_count].domain = 0;
                nv_assign_gpu_pci_info[nv_assign_gpu_count].bus = domain;
                nv_assign_gpu_pci_info[nv_assign_gpu_count].slot = bus;
            }

            nv_assign_gpu_count++;

            if (nv_assign_gpu_count == NV_MAX_DEVICES)
                break;
        }
    }

    os_free_mem(option_string);

    return (nv_assign_gpu_count ? NV_TRUE : NV_FALSE);
}
#endif

static void test_and_modify_registry_value(char* name, NvU32 default_data, NvU32 data)
{
    unsigned int i;
    nv_parm_t* entry;
    for (i = 0; (entry = &nv_parms[i])->name != NULL; i++)
    {
        if (strcmp(entry->name, name) == 0)
        {
            if (*(entry->data) == default_data)
                *(entry->data) = data;
            return;
        }
    }
}

static void detect_virtualization_and_apply_defaults(nv_stack_t *sp)
{
#if defined(NVCPU_X86) || defined(NVCPU_X86_64)
    if (nv_is_virtualized_system(sp))
    {
        test_and_modify_registry_value(NV_REG_STRING(__NV_CHECK_PCI_CONFIG_SPACE),
                                           NV_CHECK_PCI_CONFIG_SPACE_INIT,
                                           NV_CHECK_PCI_CONFIG_SPACE_DISABLED);
        return;
    }
#endif
    test_and_modify_registry_value(NV_REG_STRING(__NV_CHECK_PCI_CONFIG_SPACE),
                                       NV_CHECK_PCI_CONFIG_SPACE_INIT,
                                       NV_CHECK_PCI_CONFIG_SPACE_ENABLED);
}

RM_STATUS NV_API_CALL os_registry_init(void)
{
    nv_parm_t *entry;
    unsigned int i;
    nv_stack_t *sp = NULL;

    NV_KMEM_CACHE_ALLOC_STACK(sp);
    if (sp == NULL)
    {
        nv_printf(NV_DBG_ERRORS, "NVRM: failed to allocate stack!\n");
        return RM_ERR_NO_MEMORY;
    }

    if (NVreg_RmMsg != NULL)
    {
        rm_write_registry_string(sp, NULL, "NVreg",
                "RmMsg", NVreg_RmMsg, strlen(NVreg_RmMsg));
    }

    memset(&nv_assign_gpu_pci_info, 0, sizeof(nv_assign_gpu_pci_info));

#if !defined(NV_VMWARE)
    if (parse_assign_gpus_string())
    {
        rm_write_registry_string(sp, NULL, "NVreg", NV_REG_ASSIGN_GPUS,
                                 NVreg_AssignGpus, strlen(NVreg_AssignGpus));
    }

#endif

    parse_option_string(sp);

    detect_virtualization_and_apply_defaults(sp);

    for (i = 0; (entry = &nv_parms[i])->name != NULL; i++)
    {
        rm_write_registry_dword(sp, NULL, entry->node, entry->name, *entry->data);
    }

    NV_KMEM_CACHE_FREE_STACK(sp);

    return RM_OK;
}
