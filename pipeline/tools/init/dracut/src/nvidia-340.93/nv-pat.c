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
#include "nv-reg.h"

int nv_pat_mode = NV_PAT_MODE_DISABLED;

#if defined(NV_ENABLE_PAT_SUPPORT)
/*
 * Private PAT support for use by the NVIDIA driver. This is used on
 * kernels that do not modify the PAT to include a write-combining
 * entry.
 */
static unsigned long orig_pat1, orig_pat2;

#define NV_READ_PAT_ENTRIES(pat1, pat2)   rdmsr(0x277, (pat1), (pat2))
#define NV_WRITE_PAT_ENTRIES(pat1, pat2)  wrmsr(0x277, (pat1), (pat2))
#define NV_PAT_ENTRY(pat, index) \
    (((pat) & (0xff << ((index)*8))) >> ((index)*8))

static inline void nv_disable_caches(unsigned long *cr4)
{
    unsigned long cr0 = read_cr0();
    write_cr0(((cr0 & (0xdfffffff)) | 0x40000000));
    wbinvd();
    *cr4 = NV_READ_CR4();
    if (*cr4 & 0x80) NV_WRITE_CR4(*cr4 & ~0x80);
    __flush_tlb();
}

static inline void nv_enable_caches(unsigned long cr4)
{
    unsigned long cr0 = read_cr0();
    wbinvd();
    __flush_tlb();
    write_cr0((cr0 & 0x9fffffff));
    if (cr4 & 0x80) NV_WRITE_CR4(cr4);
}

static int nv_determine_pat_mode(void)
{
    unsigned int pat1, pat2, i;
    NvU8 PAT_WC_index;

    if (!test_bit(X86_FEATURE_PAT,
            (volatile unsigned long *)&boot_cpu_data.x86_capability))
    {
        if ((boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) ||
                (boot_cpu_data.cpuid_level < 1) ||
                ((cpuid_edx(1) & (1 << 16)) == 0) ||
                (boot_cpu_data.x86 != 6) || (boot_cpu_data.x86_model >= 15))
        {
            nv_printf(NV_DBG_ERRORS,
                "NVRM: CPU does not support the PAT.\n");
            return NV_PAT_MODE_DISABLED;
        }
    }

    NV_READ_PAT_ENTRIES(pat1, pat2);
    PAT_WC_index = 0xf;

    for (i = 0; i < 4; i++)
    {
        if (NV_PAT_ENTRY(pat1, i) == 0x01)
        {
            PAT_WC_index = i;
            break;
        }

        if (NV_PAT_ENTRY(pat2, i) == 0x01)
        {
            PAT_WC_index = (i + 4);
            break;
        }
    }

    if (PAT_WC_index == 1)
        return NV_PAT_MODE_KERNEL;
    else if (PAT_WC_index != 0xf)
    {
        nv_printf(NV_DBG_ERRORS,
            "NVRM: PAT configuration unsupported.\n");
        return NV_PAT_MODE_DISABLED;
    }
    else
        return NV_PAT_MODE_BUILTIN;
}

static void nv_setup_pat_entries(void *info)
{
    unsigned long pat1, pat2, cr4;
    unsigned long eflags;

#if defined(NV_ENABLE_HOTPLUG_CPU)
    int cpu = (NvUPtr)info;
    if ((cpu != 0) && (cpu != (int)smp_processor_id()))
        return;
#endif

    NV_SAVE_FLAGS(eflags);
    NV_CLI();
    nv_disable_caches(&cr4);

    NV_READ_PAT_ENTRIES(pat1, pat2);

    pat1 &= 0xffff00ff;
    pat1 |= 0x00000100;

    NV_WRITE_PAT_ENTRIES(pat1, pat2);

    nv_enable_caches(cr4);
    NV_RESTORE_FLAGS(eflags);
}

static void nv_restore_pat_entries(void *info)
{
    unsigned long cr4;
    unsigned long eflags;

#if defined(NV_ENABLE_HOTPLUG_CPU)
    int cpu = (NvUPtr)info;
    if ((cpu != 0) && (cpu != (int)smp_processor_id()))
        return;
#endif

    NV_SAVE_FLAGS(eflags);
    NV_CLI();
    nv_disable_caches(&cr4);

    NV_WRITE_PAT_ENTRIES(orig_pat1, orig_pat2);

    nv_enable_caches(cr4);
    NV_RESTORE_FLAGS(eflags);
}
#endif

int nv_enable_pat_support(void)
{
#if defined(NV_ENABLE_PAT_SUPPORT)
    unsigned long pat1, pat2;

    if (nv_pat_mode != NV_PAT_MODE_DISABLED)
        return 1;

    nv_pat_mode = nv_determine_pat_mode();

    switch (nv_pat_mode)
    {
        case NV_PAT_MODE_DISABLED:
            /* avoid the PAT if unavailable/unusable */
            return 0;
        case NV_PAT_MODE_KERNEL:
            /* inherit the kernel's PAT layout */
            return 1;
        case NV_PAT_MODE_BUILTIN:
            /* use builtin code to modify the PAT layout */
            break;
    }

    NV_READ_PAT_ENTRIES(orig_pat1, orig_pat2);
    nv_printf(NV_DBG_SETUP, "saved orig pats as 0x%lx 0x%lx\n", orig_pat1, orig_pat2);

    if (nv_execute_on_all_cpus(nv_setup_pat_entries, NULL) != 0)
    {
        nv_execute_on_all_cpus(nv_restore_pat_entries, NULL);
        return 0;
    }

    NV_READ_PAT_ENTRIES(pat1, pat2);
    nv_printf(NV_DBG_SETUP, "changed pats to 0x%lx 0x%lx\n", pat1, pat2);
#endif
    return 1;
}

void nv_disable_pat_support(void)
{
#if defined(NV_ENABLE_PAT_SUPPORT)
    unsigned long pat1, pat2;

    if (nv_pat_mode != NV_PAT_MODE_BUILTIN)
        return;

    if (nv_execute_on_all_cpus(nv_restore_pat_entries, NULL) != 0)
        return;

    nv_pat_mode = NV_PAT_MODE_DISABLED;

    NV_READ_PAT_ENTRIES(pat1, pat2);
    nv_printf(NV_DBG_SETUP, "restored orig pats as 0x%lx 0x%lx\n", pat1, pat2);
#endif
}

#if defined(NV_ENABLE_PAT_SUPPORT) && defined(NV_ENABLE_HOTPLUG_CPU)
static int
nvidia_cpu_callback(struct notifier_block *nfb, unsigned long action, void *hcpu)
{
    unsigned int cpu = get_cpu();

    switch (action)
    {
        case CPU_DOWN_FAILED:
        case CPU_ONLINE:
            if (cpu == (NvUPtr)hcpu)
                nv_setup_pat_entries(NULL);
            else
                NV_SMP_CALL_FUNCTION(nv_setup_pat_entries, hcpu, 1);
            break;
        case CPU_DOWN_PREPARE:
            if (cpu == (NvUPtr)hcpu)
                nv_restore_pat_entries(NULL);
            else
                NV_SMP_CALL_FUNCTION(nv_restore_pat_entries, hcpu, 1);
            break;
    }

    put_cpu();

    return NOTIFY_OK;
}

static struct notifier_block nv_hotcpu_nfb = {
    .notifier_call = nvidia_cpu_callback,
    .priority = 0
};
#endif

int nv_init_pat_support(nv_stack_t *sp)
{
    RM_STATUS status;
    NvU32 data;
    int disable_pat = 0;

    status = rm_read_registry_dword(sp, NULL,
            "NVreg", NV_USE_PAGE_ATTRIBUTE_TABLE, &data);
    if ((status == RM_OK) && ((int)data != ~0))
    {
        disable_pat = (data == 0);
    }

    if (!disable_pat)
    {
        nv_enable_pat_support();
#if defined(NV_ENABLE_PAT_SUPPORT) && defined(NV_ENABLE_HOTPLUG_CPU)
        if (nv_pat_mode == NV_PAT_MODE_BUILTIN)
        {
            if (register_hotcpu_notifier(&nv_hotcpu_nfb) != 0)
            {
                nv_disable_pat_support();
                nv_printf(NV_DBG_ERRORS,
                    "NVRM: CPU hotplug notifier registration failed!\n");
                return -EIO;
            }
        }
#endif
    }
    else
    {
        nv_printf(NV_DBG_ERRORS,
            "NVRM: builtin PAT support disabled.\n");
    }

    return 0;
}

void nv_teardown_pat_support(void)
{
    if (nv_pat_mode == NV_PAT_MODE_BUILTIN)
    {
        nv_disable_pat_support();
#if defined(NV_ENABLE_PAT_SUPPORT) && defined(NV_ENABLE_HOTPLUG_CPU)
        unregister_hotcpu_notifier(&nv_hotcpu_nfb);
#endif
    }
}
