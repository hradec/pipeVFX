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

#if defined(DEBUG)

#include "nv_uvm_interface.h"
#include "uvm_gpu_ops_tests.h"
#include "nvidia_page_migration.h"
#include "nvidia_uvm_common.h"
#include "nvidia_uvm_linux.h"

void gpuOpsSampleTest(UvmGpuUuid  * pUuidStruct)
{
    UVM_DBG_PRINT_UUID("Entering", pUuidStruct);
    return;
}

void pageMigrationTest(UvmGpuUuid  * pUuidStruct)
{
    // arbitrarily choose that our region size will be 16KB
    const unsigned REGION_SIZE = 0x4000;
    const unsigned SEMA_SIZE =   4*1024;
    uvmGpuSessionHandle hSession;
    uvmGpuAddressSpaceHandle hVaSpace;
    uvmGpuChannelHandle hChannel;
    UvmGpuChannelPointers channelPointers;
    unsigned copyEngineClassNumber;
    uvmGpuCopyEngineHandle hCopyEngine;
    void * pbCpuPointer;
    UvmGpuPointer pbGpuPointer;
    UvmGpuPointer semaGpuPointer;
    void * semaCpuPointer;
    void * pbPutPointer;

    UvmGpuPointer fbRegionGpuPointer;
    void * fbRegionCpuPointer;
    void *pbEnd;
    UvmGpuPointer sysmemRegionGpuPointer;
    void * sysmemRegionCpuPointer;
    unsigned flags = 0;
    unsigned word;
    UvmCopyOps ceOps = {0};
    NvLength numMethods;
    unsigned semaVal;
    unsigned long long uuidMsb = 0;
    unsigned long long uuidLsb = 0;


    UVM_DBG_PRINT_UUID("Entering", pUuidStruct);

    //
    // allocate all resources necessary to utilize a CE:
    // 1) allocate cli/dev/subdev
    // 2) allocate channel from cli/dev VA space
    // 3) allocate OBJCE
    // 4) allocate PB
    //
    if (RM_OK != nvUvmInterfaceSessionCreate(&hSession))
    {
        UVM_ERR_PRINT("ERROR: could not create a session\n");
        return;
    }

    memcpy(&uuidMsb, &pUuidStruct->uuid[0], (UVM_UUID_LEN >> 1));
    memcpy(&uuidLsb, &pUuidStruct->uuid[8], (UVM_UUID_LEN >> 1));


    if (RM_OK != nvUvmInterfaceAddressSpaceCreateMirrored(hSession,
                                                           uuidMsb,
                                                           uuidLsb,
                                                           &hVaSpace))
    {
        UVM_ERR_PRINT("ERROR: could not create an address space\n");
        return;
    }

    if (RM_OK != nvUvmInterfaceChannelAllocate(hVaSpace, &hChannel,
                                                &channelPointers))
    {
        UVM_ERR_PRINT("ERROR: could not allocate a channel\n");
        return;
    }

    if (RM_OK != nvUvmInterfaceCopyEngineAllocate(hChannel, 1,
                                                   &copyEngineClassNumber,
                                                   &hCopyEngine))
    {
        UVM_ERR_PRINT("ERROR: could not allocate OBJCE\n");
        return;
    }

    // allocate semaphore page
    if (RM_OK != nvUvmInterfaceMemoryAllocSys(hVaSpace, SEMA_SIZE,
                                               &semaGpuPointer))
    {
        UVM_ERR_PRINT("ERROR: could not allocate GPU memory for PB\n");
        return;
    }

    if (RM_OK != nvUvmInterfaceMemoryCpuMap(hVaSpace, semaGpuPointer,
                                             SEMA_SIZE, &semaCpuPointer))
    {
        UVM_ERR_PRINT("ERROR: could not map PB to CPU VA\n");
        return;
    }

    // Push Buffer
    if (RM_OK != nvUvmInterfaceMemoryAllocSys(hVaSpace, REGION_SIZE,
                                               &pbGpuPointer))
    {
        UVM_ERR_PRINT("ERROR: could not allocate GPU memory for PB\n");
        return;
    }
    // Map Push Buffer
    if (RM_OK != nvUvmInterfaceMemoryCpuMap(hVaSpace, pbGpuPointer,
                                             REGION_SIZE, &pbCpuPointer))
    {
        UVM_ERR_PRINT("ERROR: could not map PB to CPU VA\n");
        return;
    }

    // allocate CPU accessible memory on FB that we can copy to/from for testing
    if (RM_OK != nvUvmInterfaceMemoryAllocFB(hVaSpace, REGION_SIZE,
                                              &fbRegionGpuPointer))
    {
        UVM_ERR_PRINT("ERROR: could not allocate FB region for testing\n");
        return;
    }

    if (RM_OK != nvUvmInterfaceMemoryCpuMap(hVaSpace, fbRegionGpuPointer,
                                             REGION_SIZE, &fbRegionCpuPointer))
    {
        UVM_ERR_PRINT("ERROR: could not map GPU memory to CPU VA\n");
        return;
    }

    //
    // allocate CPU accessible memory on SYSMEM that we can copy to/from for
    // testing
    //
    if (RM_OK != nvUvmInterfaceMemoryAllocSys(hVaSpace, REGION_SIZE,
                                               &sysmemRegionGpuPointer))
    {
        UVM_ERR_PRINT("ERROR: could not allocate SYSMEM region for testing\n");
        return;
    }

    if (RM_OK != nvUvmInterfaceMemoryCpuMap(hVaSpace, sysmemRegionGpuPointer,
                                             REGION_SIZE,
                                             &sysmemRegionCpuPointer))
    {
        UVM_ERR_PRINT("ERROR: could not map SYSYMEM to CPU VA\n");
        return;
    }

    // setup CE Ops
    NvUvmHalInit(copyEngineClassNumber, 0x0000A06F, &ceOps);

    //setup to copy from SYSMEM to FB
    memset(fbRegionCpuPointer, 0xdeadbeef, REGION_SIZE);
    memset(sysmemRegionCpuPointer, 0xbad0cafe, REGION_SIZE);
    memset(semaCpuPointer, 0, SEMA_SIZE);


    // lets insert one sema and check for release
    pbPutPointer = pbCpuPointer;
    pbEnd = pbPutPointer + (REGION_SIZE / sizeof(unsigned));
    numMethods = ceOps.semaphoreRelease((unsigned **)&pbPutPointer,
                                        pbEnd,
                                        semaGpuPointer, 0xFACEFEED);

    // write the GP entry
    ceOps.writeGpEntry(channelPointers.gpFifoEntries, 0, pbGpuPointer,
                       numMethods);

    // launch the sema release
    NvUvmChannelWriteGpPut(channelPointers.GPPut, 1);

    // check if we get back the sempahore
    while(1)
        {
        semaVal = 0;
                semaVal = *(unsigned *)semaCpuPointer;
        UVM_DBG_PRINT("SemaVal:= 0x%x\n", semaVal);
        if(semaVal == 0xFACEFEED)
            break;
        }


    pbPutPointer += numMethods;
    pbGpuPointer += numMethods;
    pbEnd = pbPutPointer + (REGION_SIZE / sizeof(unsigned));

    // push methods to do a copy
    numMethods = ceOps.launchDma((unsigned **)&pbPutPointer,
                    pbEnd,
                    sysmemRegionGpuPointer, 2,
                    fbRegionGpuPointer, 0,
                    REGION_SIZE, flags);

    // write the GP entry
    ceOps.writeGpEntry(channelPointers.gpFifoEntries, 1, pbGpuPointer,
                       numMethods);

    // launch the copy
    NvUvmChannelWriteGpPut(channelPointers.GPPut, 2);


    // check that the pattern copied to FB is the same as the pattern in SYSMEM
    for (word = 0; word < REGION_SIZE / sizeof(unsigned); word ++)
    {
        UVM_INFO_PRINT("INFO: checking 0x%X == 0x%X ?\n",
                       ((unsigned*)fbRegionCpuPointer)[word],
                       ((unsigned*)sysmemRegionCpuPointer)[word]);
        if (((unsigned*)fbRegionCpuPointer)[word] !=
            ((unsigned*)sysmemRegionCpuPointer)[word])
        {
            UVM_DBG_PRINT_RL("ERROR: copy failed. FB region = 0x%X,"
                             " SYSMEM region = 0x%X\n",
                             ((unsigned*)fbRegionCpuPointer)[word],
                             ((unsigned*)sysmemRegionCpuPointer)[word]);

            nvUvmInterfaceSessionDestroy(hSession);
            return;
        }
    }
    nvUvmInterfaceChannelDestroy(hChannel);
    nvUvmInterfaceAddressSpaceDestroy(hVaSpace);
    nvUvmInterfaceSessionDestroy(hSession);

    UVM_DBG_PRINT("INFO: Passed\n");
}

#endif
