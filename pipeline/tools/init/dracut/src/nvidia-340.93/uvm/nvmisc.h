 /***************************************************************************\
|*                                                                           *|
|*       Copyright 1993-2013 NVIDIA, Corporation.  All rights reserved.      *|
|*                                                                           *|
|*     NOTICE TO USER:   The source code  is copyrighted under  U.S. and     *|
|*     international laws.  NVIDIA, Corp. of Sunnyvale,  California owns     *|
|*     copyrights, patents, and has design patents pending on the design     *|
|*     and  interface  of the NV chips.   Users and  possessors  of this     *|
|*     source code are hereby granted a nonexclusive, royalty-free copy-     *|
|*     right  and design patent license  to use this code  in individual     *|
|*     and commercial software.                                              *|
|*                                                                           *|
|*     Any use of this source code must include,  in the user documenta-     *|
|*     tion and  internal comments to the code,  notices to the end user     *|
|*     as follows:                                                           *|
|*                                                                           *|
|*     Copyright  1993-2013  NVIDIA,  Corporation.   NVIDIA  has  design     *|
|*     patents and patents pending in the U.S. and foreign countries.        *|
|*                                                                           *|
|*     NVIDIA, CORPORATION MAKES NO REPRESENTATION ABOUT THE SUITABILITY     *|
|*     OF THIS SOURCE CODE FOR ANY PURPOSE. IT IS PROVIDED "AS IS" WITH-     *|
|*     OUT EXPRESS OR IMPLIED WARRANTY OF ANY KIND.  NVIDIA, CORPORATION     *|
|*     DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOURCE CODE, INCLUD-     *|
|*     ING ALL IMPLIED WARRANTIES  OF MERCHANTABILITY  AND FITNESS FOR A     *|
|*     PARTICULAR  PURPOSE.  IN NO EVENT  SHALL NVIDIA,  CORPORATION  BE     *|
|*     LIABLE FOR ANY SPECIAL,  INDIRECT,  INCIDENTAL,  OR CONSEQUENTIAL     *|
|*     DAMAGES, OR ANY DAMAGES  WHATSOEVER  RESULTING  FROM LOSS OF USE,     *|
|*     DATA OR PROFITS,  WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR     *|
|*     OTHER TORTIOUS ACTION,  ARISING OUT OF OR IN CONNECTION  WITH THE     *|
|*     USE OR PERFORMANCE OF THIS SOURCE CODE.                               *|
|*                                                                           *|
|*     RESTRICTED RIGHTS LEGEND:  Use, duplication, or disclosure by the     *|
|*     Government is subject  to restrictions  as set forth  in subpara-     *|
|*     graph (c) (1) (ii) of the Rights  in Technical Data  and Computer     *|
|*     Software  clause  at DFARS  52.227-7013 and in similar clauses in     *|
|*     the FAR and NASA FAR Supplement.                                      *|
|*                                                                           *|
 \***************************************************************************/

/*
 * nvmisc.h
 */
#ifndef __NV_MISC_H
#define __NV_MISC_H

#ifdef __cplusplus
extern "C" {
#endif //__cplusplus

#include "nvtypes.h"

//
// Miscellaneous macros useful for bit field manipulations
//
#define BIT(b)                  (1<<(b))
#define BIT32(b)                ((NvU32)1<<(b))
#define BIT64(b)                ((NvU64)1<<(b))

// Index of the 'on' bit (assuming that there is only one).
// Even if multiple bits are 'on', result is in range of 0-31.
#define BIT_IDX_32(n)                   \
   ((((n) & 0xFFFF0000)? 0x10: 0) |     \
    (((n) & 0xFF00FF00)? 0x08: 0) |     \
    (((n) & 0xF0F0F0F0)? 0x04: 0) |     \
    (((n) & 0xCCCCCCCC)? 0x02: 0) |     \
    (((n) & 0xAAAAAAAA)? 0x01: 0) )

// Index of the 'on' bit (assuming that there is only one).
// Even if multiple bits are 'on', result is in range of 0-63.
#define BIT_IDX_64(n)                              \
   ((((n) & 0xFFFFFFFF00000000ULL)? 0x20: 0) |     \
    (((n) & 0xFFFF0000FFFF0000ULL)? 0x10: 0) |     \
    (((n) & 0xFF00FF00FF00FF00ULL)? 0x08: 0) |     \
    (((n) & 0xF0F0F0F0F0F0F0F0ULL)? 0x04: 0) |     \
    (((n) & 0xCCCCCCCCCCCCCCCCULL)? 0x02: 0) |     \
    (((n) & 0xAAAAAAAAAAAAAAAAULL)? 0x01: 0) )

// Desctructive, assumes only one bit set in n32
// Deprecated in favor of BIT_IDX_32.
#define IDX_32(n32)                     \
{                                       \
    NvU32 idx = 0;                      \
    if ((n32) & 0xFFFF0000) idx += 16;  \
    if ((n32) & 0xFF00FF00) idx += 8;   \
    if ((n32) & 0xF0F0F0F0) idx += 4;   \
    if ((n32) & 0xCCCCCCCC) idx += 2;   \
    if ((n32) & 0xAAAAAAAA) idx += 1;   \
    (n32) = idx;                        \
}

#define DEVICE_BASE(d)          (0?d)  // what's up with this name? totally non-parallel to the macros below
#define DEVICE_EXTENT(d)        (1?d)  // what's up with this name? totally non-parallel to the macros below
#define DRF_BASE(drf)           (0?drf)  // much better
#define DRF_EXTENT(drf)         (1?drf)  // much better
#define DRF_SHIFT(drf)          ((0?drf) % 32)
#define DRF_MASK(drf)           (0xFFFFFFFF>>(31-((1?drf) % 32)+((0?drf) % 32)))
#define DRF_SHIFTMASK(drf)      (DRF_MASK(drf)<<(DRF_SHIFT(drf)))
#define DRF_SIZE(drf)           (DRF_EXTENT(drf)-DRF_BASE(drf)+1)

#define DRF_DEF(d,r,f,c)        ((NV ## d ## r ## f ## c)<<DRF_SHIFT(NV ## d ## r ## f))
#define DRF_NUM(d,r,f,n)        (((n)&DRF_MASK(NV ## d ## r ## f))<<DRF_SHIFT(NV ## d ## r ## f))
#define DRF_VAL(d,r,f,v)        (((v)>>DRF_SHIFT(NV ## d ## r ## f))&DRF_MASK(NV ## d ## r ## f))
// Signed version of DRF_VAL, which takes care of extending sign bit.
#define DRF_VAL_SIGNED(d,r,f,v) (((DRF_VAL(d,r,f,v) ^ (BIT(DRF_SIZE(NV ## d ## r ## f)-1)))) - (BIT(DRF_SIZE(NV ## d ## r ## f)-1)))
#define DRF_IDX_DEF(d,r,f,i,c)  ((NV ## d ## r ## f ## c)<<DRF_SHIFT(NV##d##r##f(i)))
#define DRF_IDX_OFFSET_DEF(d,r,f,i,o,c)  ((NV ## d ## r ## f ## c)<<DRF_SHIFT(NV##d##r##f(i,o)))
#define DRF_IDX_NUM(d,r,f,i,n)  (((n)&DRF_MASK(NV##d##r##f(i)))<<DRF_SHIFT(NV##d##r##f(i)))
#define DRF_IDX_VAL(d,r,f,i,v)  (((v)>>DRF_SHIFT(NV##d##r##f(i)))&DRF_MASK(NV##d##r##f(i)))
#define DRF_IDX_OFFSET_VAL(d,r,f,i,o,v)  (((v)>>DRF_SHIFT(NV##d##r##f(i,o)))&DRF_MASK(NV##d##r##f(i,o)))
// Fractional version of DRF_VAL which reads Fx.y fixed point number (x.y)*z
#define DRF_VAL_FRAC(d,r,x,y,v,z) ((DRF_VAL(d,r,x,v)*z) + ((DRF_VAL(d,r,y,v)*z) / (1<<DRF_SIZE(NV##d##r##y))))

//
// 64 Bit Versions
//
#define DRF_SHIFT64(drf)          ((0?drf) % 64)
#define DRF_MASK64(drf)           (NV_U64_MAX>>(63-((1?drf) % 64)+((0?drf) % 64)))
#define DRF_SHIFTMASK64(drf)      (DRF_MASK64(drf)<<(DRF_SHIFT64(drf)))

#define DRF_DEF64(d,r,f,c)        ((NV ## d ## r ## f ## c)<<DRF_SHIFT64(NV ## d ## r ## f))
#define DRF_NUM64(d,r,f,n)        (((n)&DRF_MASK64(NV ## d ## r ## f))<<DRF_SHIFT64(NV ## d ## r ## f))
#define DRF_VAL64(d,r,f,v)        (((v)>>DRF_SHIFT64(NV ## d ## r ## f))&DRF_MASK64(NV ## d ## r ## f))
#define DRF_IDX_DEF64(d,r,f,i,c)  ((NV ## d ## r ## f ## c)<<DRF_SHIFT64(NV##d##r##f(i)))
#define DRF_IDX_NUM64(d,r,f,i,n)  (((n)&DRF_MASK64(NV##d##r##f(i)))<<DRF_SHIFT64(NV##d##r##f(i)))
#define DRF_IDX_VAL64(d,r,f,i,v)  (((v)>>DRF_SHIFT64(NV##d##r##f(i)))&DRF_MASK64(NV##d##r##f(i)))

#define FLD_SET_DRF_NUM64(d,r,f,n,v)        ((v & ~DRF_SHIFTMASK64(NV##d##r##f)) | DRF_NUM64(d,r,f,n))


#define FLD_SET_DRF(d,r,f,c,v)            ((v & ~DRF_SHIFTMASK(NV##d##r##f)) | DRF_DEF(d,r,f,c))
#define FLD_SET_DRF_NUM(d,r,f,n,v)        ((v & ~DRF_SHIFTMASK(NV##d##r##f)) | DRF_NUM(d,r,f,n))
// FLD_SET_DRF_DEF is deprecated! Use an explicit assignment with FLD_SET_DRF instead.
#define FLD_SET_DRF_DEF(d,r,f,c,v)        (v = (v & ~DRF_SHIFTMASK(NV##d##r##f)) | DRF_DEF(d,r,f,c))
#define FLD_IDX_SET_DRF(d,r,f,i,c,v)      ((v & ~DRF_SHIFTMASK(NV##d##r##f(i))) | DRF_IDX_DEF(d,r,f,i,c))
#define FLD_IDX_OFFSET_SET_DRF(d,r,f,i,o,c,v)      ((v & ~DRF_SHIFTMASK(NV##d##r##f(i,o))) | DRF_IDX_OFFSET_DEF(d,r,f,i,o,c))
#define FLD_IDX_SET_DRF_DEF(d,r,f,i,c,v)  ((v & ~DRF_SHIFTMASK(NV##d##r##f(i))) | DRF_IDX_DEF(d,r,f,i,c))
#define FLD_IDX_SET_DRF_NUM(d,r,f,i,n,v)  ((v & ~DRF_SHIFTMASK(NV##d##r##f(i))) | DRF_IDX_NUM(d,r,f,i,n))
#define FLD_SET_DRF_IDX(d,r,f,c,i,v)      ((v & ~DRF_SHIFTMASK(NV##d##r##f)) | DRF_DEF(d,r,f,c(i)))

#define FLD_TEST_DRF(d,r,f,c,v)       ((DRF_VAL(d, r, f, v) == NV##d##r##f##c))
#define FLD_TEST_DRF_AND(d,r,f,c,v)   ((DRF_VAL(d, r, f, v) & NV##d##r##f##c))
#define FLD_TEST_DRF_NUM(d,r,f,n,v)   ((DRF_VAL(d, r, f, v) == n))
#define FLD_IDX_TEST_DRF(d,r,f,i,c,v) ((DRF_IDX_VAL(d, r, f, i, v) == NV##d##r##f##c))
#define FLD_IDX_OFFSET_TEST_DRF(d,r,f,i,o,c,v) ((DRF_IDX_OFFSET_VAL(d, r, f, i, o, v) == NV##d##r##f##c))

#define REF_DEF(drf,d)            (((drf ## d)&DRF_MASK(drf))<<DRF_SHIFT(drf))
#define REF_VAL(drf,v)            (((v)>>DRF_SHIFT(drf))&DRF_MASK(drf))
#define REF_NUM(drf,n)            (((n)&DRF_MASK(drf))<<DRF_SHIFT(drf))
#define FLD_TEST_REF(drf,c,v)     (REF_VAL(drf, v) == drf##c)
#define FLD_TEST_REF_AND(drf,c,v) (REF_VAL(drf, v) & drf##c)
#define FLD_SET_REF_NUM(drf,n,v)  (((v) & ~DRF_SHIFTMASK(drf)) | REF_NUM(drf,n))

#define CR_DRF_DEF(d,r,f,c)     ((CR ## d ## r ## f ## c)<<DRF_SHIFT(CR ## d ## r ## f))
#define CR_DRF_NUM(d,r,f,n)     (((n)&DRF_MASK(CR ## d ## r ## f))<<DRF_SHIFT(CR ## d ## r ## f))
#define CR_DRF_VAL(d,r,f,v)     (((v)>>DRF_SHIFT(CR ## d ## r ## f))&DRF_MASK(CR ## d ## r ## f))

// Multi-word (MW) field manipulations.  For multi-word structures (e.g., Fermi SPH),
// fields may have bit numbers beyond 32.  To avoid errors using "classic" multi-word macros,
// all the field extents are defined as "MW(X)".  For example, MW(127:96) means
// the field is in bits 0-31 of word number 3 of the structure.
//
// DRF_VAL_MW() macro is meant to be used for native endian 32-bit aligned 32-bit word data,
// not for byte stream data.
//
// DRF_VAL_BS() macro is for byte stream data used in fbQueryBIOS_XXX().
//
#define DRF_EXPAND_MW(drf)         drf                          // used to turn "MW(a:b)" into "a:b"
#define DRF_PICK_MW(drf,v)         (v?DRF_EXPAND_##drf)         // picks low or high bits
#define DRF_WORD_MW(drf)           (DRF_PICK_MW(drf,0)/32)      // which word in a multi-word array
#define DRF_BASE_MW(drf)           (DRF_PICK_MW(drf,0)%32)      // which start bit in the selected word?
#define DRF_EXTENT_MW(drf)         (DRF_PICK_MW(drf,1)%32)      // which end bit in the selected word
#define DRF_SHIFT_MW(drf)          (DRF_PICK_MW(drf,0)%32)
#define DRF_MASK_MW(drf)           (0xFFFFFFFF>>((31-(DRF_EXTENT_MW(drf))+(DRF_BASE_MW(drf)))%32))
#define DRF_SHIFTMASK_MW(drf)      ((DRF_MASK_MW(drf))<<(DRF_SHIFT_MW(drf)))
#define DRF_SIZE_MW(drf)           (DRF_EXTENT_MW(drf)-DRF_BASE_MW(drf)+1)

#define DRF_DEF_MW(d,r,f,c)        ((NV##d##r##f##c) << DRF_SHIFT_MW(NV##d##r##f))
#define DRF_NUM_MW(d,r,f,n)        (((n)&DRF_MASK_MW(NV##d##r##f))<<DRF_SHIFT_MW(NV##d##r##f))
//
// DRF_VAL_MW is the ONLY multi-word macro which supports spanning. No other MW macro supports spanning currently
//
#define DRF_VAL_MW_1WORD(d,r,f,v)       ((((v)[DRF_WORD_MW(NV##d##r##f)])>>DRF_SHIFT_MW(NV##d##r##f))&DRF_MASK_MW(NV##d##r##f))
#define DRF_SPANS(drf)                  ((DRF_PICK_MW(drf,0)/32) != (DRF_PICK_MW(drf,1)/32))
#define DRF_WORD_MW_LOW(drf)            (DRF_PICK_MW(drf,0)/32)
#define DRF_WORD_MW_HIGH(drf)           (DRF_PICK_MW(drf,1)/32)
#define DRF_MASK_MW_LOW(drf)            (0xFFFFFFFF)
#define DRF_MASK_MW_HIGH(drf)           (0xFFFFFFFF>>(31-(DRF_EXTENT_MW(drf))))
#define DRF_SHIFT_MW_LOW(drf)           (DRF_PICK_MW(drf,0)%32)
#define DRF_SHIFT_MW_HIGH(drf)          (0)
#define DRF_MERGE_SHIFT(drf)            ((32-((DRF_PICK_MW(drf,0)%32)))%32)
#define DRF_VAL_MW_2WORD(d,r,f,v)       (((((v)[DRF_WORD_MW_LOW(NV##d##r##f)])>>DRF_SHIFT_MW_LOW(NV##d##r##f))&DRF_MASK_MW_LOW(NV##d##r##f)) | \
    (((((v)[DRF_WORD_MW_HIGH(NV##d##r##f)])>>DRF_SHIFT_MW_HIGH(NV##d##r##f))&DRF_MASK_MW_HIGH(NV##d##r##f)) << DRF_MERGE_SHIFT(NV##d##r##f)))
#define DRF_VAL_MW(d,r,f,v)             ( DRF_SPANS(NV##d##r##f) ? DRF_VAL_MW_2WORD(d,r,f,v) : DRF_VAL_MW_1WORD(d,r,f,v) )

#define DRF_IDX_DEF_MW(d,r,f,i,c)  ((NV##d##r##f##c)<<DRF_SHIFT_MW(NV##d##r##f(i)))
#define DRF_IDX_NUM_MW(d,r,f,i,n)  (((n)&DRF_MASK_MW(NV##d##r##f(i)))<<DRF_SHIFT_MW(NV##d##r##f(i)))
#define DRF_IDX_VAL_MW(d,r,f,i,v)  ((((v)[DRF_WORD_MW(NV##d##r##f(i))])>>DRF_SHIFT_MW(NV##d##r##f(i)))&DRF_MASK_MW(NV##d##r##f(i)))

//
// Logically OR all DRF_DEF constants indexed from zero to s (semiinclusive).
// Caution: Target variable v must be pre-initialized.
//
#define FLD_IDX_OR_DRF_DEF(d,r,f,c,s,v)                 \
do                                                      \
{   NvU32 idx;                                          \
    for (idx = 0; idx < (NV ## d ## r ## f ## s); ++idx)\
    {                                                   \
        v |= DRF_IDX_DEF(d,r,f,idx,c);                  \
    }                                                   \
} while(0)


#define FLD_MERGE_MW(drf,n,v)               (((v)[DRF_WORD_MW(drf)] & ~DRF_SHIFTMASK_MW(drf)) | n)
#define FLD_ASSIGN_MW(drf,n,v)              ((v)[DRF_WORD_MW(drf)] = FLD_MERGE_MW(drf, n, v))
#define FLD_IDX_MERGE_MW(drf,i,n,v)         (((v)[DRF_WORD_MW(drf(i))] & ~DRF_SHIFTMASK_MW(drf(i))) | n)
#define FLD_IDX_ASSIGN_MW(drf,i,n,v)        ((v)[DRF_WORD_MW(drf(i))] = FLD_MERGE_MW(drf(i), n, v))

#define FLD_SET_DRF_MW(d,r,f,c,v)               FLD_MERGE_MW(NV##d##r##f, DRF_DEF_MW(d,r,f,c), v)
#define FLD_SET_DRF_NUM_MW(d,r,f,n,v)           FLD_ASSIGN_MW(NV##d##r##f, DRF_NUM_MW(d,r,f,n), v)
#define FLD_SET_DRF_DEF_MW(d,r,f,c,v)           FLD_ASSIGN_MW(NV##d##r##f, DRF_DEF_MW(d,r,f,c), v)
#define FLD_IDX_SET_DRF_MW(d,r,f,i,c,v)         FLD_IDX_MERGE_MW(NV##d##r##f, i, DRF_IDX_DEF_MW(d,r,f,i,c), v)
#define FLD_IDX_SET_DRF_DEF_MW(d,r,f,i,c,v)    FLD_IDX_MERGE_MW(NV##d##r##f, i, DRF_IDX_DEF_MW(d,r,f,i,c), v)
#define FLD_IDX_SET_DRF_NUM_MW(d,r,f,i,n,v)     FLD_IDX_ASSIGN_MW(NV##d##r##f, i, DRF_IDX_NUM_MW(d,r,f,i,n), v)

#define FLD_TEST_DRF_MW(d,r,f,c,v)          ((DRF_VAL_MW(d, r, f, v) == NV##d##r##f##c))
#define FLD_TEST_DRF_NUM_MW(d,r,f,n,v)      ((DRF_VAL_MW(d, r, f, v) == n))
#define FLD_IDX_TEST_DRF_MW(d,r,f,i,c,v)    ((DRF_IDX_VAL_MW(d, r, f, i, v) == NV##d##r##f##c))

#define DRF_VAL_BS(d,r,f,v)                 ( DRF_SPANS(NV##d##r##f) ? DRF_VAL_BS_2WORD(d,r,f,v) : DRF_VAL_BS_1WORD(d,r,f,v) )

//
// DRF_READ_1WORD_BS() and DRF_READ_1WORD_BS_HIGH() do not read beyond the bytes that contain
// the requested value. Reading beyond the actual data causes a page fault panic when the
// immediately following page happened to be protected or not mapped.
//
#define DRF_VAL_BS_1WORD(d,r,f,v)           ((DRF_READ_1WORD_BS(d,r,f,v)>>DRF_SHIFT_MW(NV##d##r##f))&DRF_MASK_MW(NV##d##r##f))
#define DRF_VAL_BS_2WORD(d,r,f,v)           (((DRF_READ_4BYTE_BS(NV##d##r##f,v)>>DRF_SHIFT_MW_LOW(NV##d##r##f))&DRF_MASK_MW_LOW(NV##d##r##f)) | \
    (((DRF_READ_1WORD_BS_HIGH(d,r,f,v)>>DRF_SHIFT_MW_HIGH(NV##d##r##f))&DRF_MASK_MW_HIGH(NV##d##r##f)) << DRF_MERGE_SHIFT(NV##d##r##f)))

#define DRF_READ_1BYTE_BS(drf,v)            ((NvU32)(((const NvU8*)(v))[DRF_WORD_MW(drf)*4]))
#define DRF_READ_2BYTE_BS(drf,v)            (DRF_READ_1BYTE_BS(drf,v)| \
    ((NvU32)(((const NvU8*)(v))[DRF_WORD_MW(drf)*4+1])<<8))
#define DRF_READ_3BYTE_BS(drf,v)            (DRF_READ_2BYTE_BS(drf,v)| \
    ((NvU32)(((const NvU8*)(v))[DRF_WORD_MW(drf)*4+2])<<16))
#define DRF_READ_4BYTE_BS(drf,v)            (DRF_READ_3BYTE_BS(drf,v)| \
    ((NvU32)(((const NvU8*)(v))[DRF_WORD_MW(drf)*4+3])<<24))

#define DRF_READ_1BYTE_BS_HIGH(drf,v)       ((NvU32)(((const NvU8*)(v))[DRF_WORD_MW_HIGH(drf)*4]))
#define DRF_READ_2BYTE_BS_HIGH(drf,v)       (DRF_READ_1BYTE_BS_HIGH(drf,v)| \
    ((NvU32)(((const NvU8*)(v))[DRF_WORD_MW_HIGH(drf)*4+1])<<8))
#define DRF_READ_3BYTE_BS_HIGH(drf,v)       (DRF_READ_2BYTE_BS_HIGH(drf,v)| \
    ((NvU32)(((const NvU8*)(v))[DRF_WORD_MW_HIGH(drf)*4+2])<<16))
#define DRF_READ_4BYTE_BS_HIGH(drf,v)       (DRF_READ_3BYTE_BS_HIGH(drf,v)| \
    ((NvU32)(((const NvU8*)(v))[DRF_WORD_MW_HIGH(drf)*4+3])<<24))

// Calculate 2^n - 1 and avoid shift counter overflow
//
// On Windows amd64, 64 << 64 => 1
//
#define NV_TWO_N_MINUS_ONE(n) (((1ULL<<(n/2))<<((n+1)/2))-1)

#define DRF_READ_1WORD_BS(d,r,f,v) \
    ((DRF_EXTENT_MW(NV##d##r##f)<8)?DRF_READ_1BYTE_BS(NV##d##r##f,(v)): \
    ((DRF_EXTENT_MW(NV##d##r##f)<16)?DRF_READ_2BYTE_BS(NV##d##r##f,(v)): \
    ((DRF_EXTENT_MW(NV##d##r##f)<24)?DRF_READ_3BYTE_BS(NV##d##r##f,(v)): \
    DRF_READ_4BYTE_BS(NV##d##r##f,(v)))))

#define DRF_READ_1WORD_BS_HIGH(d,r,f,v) \
    ((DRF_EXTENT_MW(NV##d##r##f)<8)?DRF_READ_1BYTE_BS_HIGH(NV##d##r##f,(v)): \
    ((DRF_EXTENT_MW(NV##d##r##f)<16)?DRF_READ_2BYTE_BS_HIGH(NV##d##r##f,(v)): \
    ((DRF_EXTENT_MW(NV##d##r##f)<24)?DRF_READ_3BYTE_BS_HIGH(NV##d##r##f,(v)): \
    DRF_READ_4BYTE_BS_HIGH(NV##d##r##f,(v)))))

#define BIN_2_GRAY(n)           ((n)^((n)>>1))
// operates on a 64-bit data type
#define GRAY_2_BIN_64b(n)       (n)^=(n)>>1; (n)^=(n)>>2; (n)^=(n)>>4; (n)^=(n)>>8; (n)^=(n)>>16; (n)^=(n)>>32;

#define LOWESTBIT(x)            ( (x) &  (((x)-1) ^ (x)) )
// Destructive operation on n32
#define HIGHESTBIT(n32)     \
{                           \
    HIGHESTBITIDX_32(n32);  \
    n32 = BIT(n32);         \
}
#define ONEBITSET(x)            ( (x) && (((x) & ((x)-1)) == 0) )

// Destructive operation on n32
#define NUMSETBITS_32(n32)                                         \
{                                                                  \
    n32 = n32 - ((n32 >> 1) & 0x55555555);                         \
    n32 = (n32 & 0x33333333) + ((n32 >> 2) & 0x33333333);          \
    n32 = (((n32 + (n32 >> 4)) & 0x0F0F0F0F) * 0x01010101) >> 24;  \
}

// Destructive operation on n32
#define LOWESTBITIDX_32(n32)  \
{                             \
    n32 = LOWESTBIT(n32);     \
    IDX_32(n32);              \
}

// Destructive operation on n32
#define HIGHESTBITIDX_32(n32)   \
{                               \
    NvU32 count = 0;            \
    while (n32 >>= 1)           \
    {                           \
        count++;                \
    }                           \
    n32 = count;                \
}

// Destructive operation on n32
#define ROUNDUP_POW2(n32) \
{                         \
    n32--;                \
    n32 |= n32 >> 1;      \
    n32 |= n32 >> 2;      \
    n32 |= n32 >> 4;      \
    n32 |= n32 >> 8;      \
    n32 |= n32 >> 16;     \
    n32++;                \
}

// Destructive operation on n64
#define ROUNDUP_POW2_U64(n64) \
{                         \
    n64--;                \
    n64 |= n64 >> 1;      \
    n64 |= n64 >> 2;      \
    n64 |= n64 >> 4;      \
    n64 |= n64 >> 8;      \
    n64 |= n64 >> 16;     \
    n64 |= n64 >> 32;     \
    n64++;                \
}

#define NV_SWAP_U8(a,b) \
{                       \
    NvU8 temp;          \
    temp = a;           \
    a = b;              \
    b = temp;           \
}

/*!
 * @brief   Macros allowing simple iteration over bits set in a given mask.
 *
 * @param[in]       maskWidth   bit-width of the mask (allowed: 8, 16, 32, 64)
 *
 * @param[in,out]   index       lvalue that is used as a bit index in the loop
 *                              (can be declared as any NvU* or NvS* variable)
 * @param[in]       mask        expression, loop will iterate over set bits only
 */
#define FOR_EACH_INDEX_IN_MASK(maskWidth,index,mask)        \
{                                                           \
    NvU##maskWidth lclMsk = (NvU##maskWidth)(mask);         \
    for (index = 0; lclMsk != 0; index++, lclMsk >>= 1)     \
    {                                                       \
        if (((NvU##maskWidth)BIT64(0) & lclMsk) == 0)       \
        {                                                   \
            continue;                                       \
        }
#define FOR_EACH_INDEX_IN_MASK_END                          \
    }                                                       \
}

//
// Size to use when declaring variable-sized arrays
//
#define NV_ANYSIZE_ARRAY                                                      1

//
// Returns absolute value of provided integer expression
//
#define NV_ABS(a) ((a)>=0?(a):(-(a)))

//
// Returns 1 if input number is positive, 0 if 0 and -1 if negative. Avoid
// macro parameter as function call which will have side effects.
//
#define NV_SIGN(s) ((NvS8)(((s) > 0) - ((s) < 0)))

//
// Returns 1 if input number is >= 0 or -1 otherwise. This assumes 0 has a
// positive sign.
//
#define NV_ZERO_SIGN(s) ((NvS8)((((s) >= 0) * 2) - 1))

// Returns the offset (in bytes) of 'member' in struct 'type'.
#ifndef NV_OFFSETOF
    #if defined(__GNUC__) && __GNUC__ > 3
        #define NV_OFFSETOF(type, member)   ((NvU32)__builtin_offsetof(type, member))
    #else
        #define NV_OFFSETOF(type, member)    ((NvU32)&(((type *)0)->member))
    #endif
#endif

//
// Performs a rounded division of b into a (unsigned). For SIGNED version of
// NV_ROUNDED_DIV() macro check the comments in http://nvbugs/769777.
//
#define NV_UNSIGNED_ROUNDED_DIV(a,b)    (((a) + ((b) / 2)) / (b))

/*!
 * Performs a rounded right-shift of 32-bit unsigned value "a" by "shift" bits.
 * Will round result away from zero.
 *
 * @param[in] a      32-bit unsigned value to shift.
 * @param[in] shift  Number of bits by which to shift.
 *
 * @return  Resulting shifted value rounded away from zero.
 */
#define NV_RIGHT_SHIFT_ROUNDED(a, shift)                                       \
    (((a) >> (shift)) + !!((BIT((shift) - 1) & (a)) == BIT((shift) - 1)))

//
// Power of 2 alignment.
//    (Will give unexpected results if 'gran' is not a power of 2.)
//
#ifndef NV_ALIGN_DOWN
#define NV_ALIGN_DOWN(v, gran)      ((v) & ~((gran) - 1))
#endif

#ifndef NV_ALIGN_UP
#define NV_ALIGN_UP(v, gran)        (((v) + ((gran) - 1)) & ~((gran)-1))
#endif

#ifdef __cplusplus
}
#endif //__cplusplus

#endif // __NV_MISC_H

