/*
# ------------------------------------------------------------------------------
#
# Copyright (c) 1986-2016 Pixar. All rights reserved.
#
# The information in this file (the "Software") is provided for the exclusive
# use of the software licensees of Pixar ("Licensees").  Licensees have the
# right to incorporate the Software into other products for use by other
# authorized software licensees of Pixar, without fee. Except as expressly
# permitted herein, the Software may not be disclosed to third parties, copied
# or duplicated in any form, in whole or in part, without the prior written
# permission of Pixar.
#
# The copyright notices in the Software and this entire statement, including the
# above license grant, this restriction and the following disclaimer, must be
# included in all copies of the Software, in whole or in part, and all permitted
# derivative works of the Software, unless such copies or derivative works are
# solely in the form of machine-executable object code generated by a source
# language processor.
#
# PIXAR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING ALL
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL PIXAR BE
# LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
# OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
# CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.  IN NO CASE WILL
# PIXAR'S TOTAL LIABILITY FOR ALL DAMAGES ARISING OUT OF OR IN CONNECTION WITH
# THE USE OR PERFORMANCE OF THIS SOFTWARE EXCEED $50.
#
# Pixar
# 1200 Park Ave
# Emeryville CA 94608
#
# ------------------------------------------------------------------------------
*/

/* $Revision: #11 $ */

#ifndef pxrgeoaovs_h
#define pxrgeoaovs_h

#include "RixShading.h"

namespace PxrGeoAOV
{

//  NOTE: The order of PxrGeoAovIds and s_aovNames MUST match.
//        Moreover, __Pworld must be listed BEFORE __depth, so we may
//        be able to reuse __Pworld's Y component in __depth.

enum PxrGeoAovIds
{
    k_Pworld = RixShadingContext::k_numBuiltinVars, // the ones before are defined in 
                                                    // RixShadingContext::BuiltinVar
    k_Nworld,
    k_depth,
    k_st,
    k_Pref,
    k_WPref,
    k_Nref,
    k_WNref,
    k_rawId,
    k_numGeoAovs
};

// The order of the built in vars "P" to "curvature_v" must match the order and content of 
// RixShadingContext::BuiltinVar
                                 
static const char* const s_aovNames[k_numGeoAovs] = { "P", "PRadius",
                                                      "Po", "Nn",
                                                      "Ngn", "Non",
                                                      "Tn", "Vn",
                                                      "VLen", "curvature",
                                                      "incidentRaySpread", "incidentRayRadius",
                                                      "incidentLobeSampled", "mpSize",
                                                      "biasR", "biasT",
                                                      "u", "v",
                                                      "w", "du",
                                                      "dv", "dw",
                                                      "dPdu", "dPdv",
                                                      "dPdw", "dPdtime",
                                                      "time", "id",
                                                      "outsideIOR", "Oi",
                                                      "lpeState", "launchShadingCtxId",
                                                      "motionFore", "motionBack",
                                                      "curvature_u", "curvature_v",
                                                      "wavelength",
                                                      "__Pworld","__Nworld",
                                                      "__depth", "__st",
                                                      "__Pref",  "__WPref",
                                                      "__Nref",  "__WNref",
                                                      "rawId"
                                                    };


//  Geometric AOV output can be entirely disabled by emitting:
//  Option "user" "int disableIntegratorAOVs" [1]
//  
//  If you want your integrator to support this option, you need to explicitely 
//  use that function to check its value.
//
inline bool disableIntegratorAOVs(RixContext &ctx, RtInt * &aovIdList)
{
    RixRenderState *rstate = (RixRenderState*)ctx.GetRixInterface(k_RixRenderState);
    RtInt count = 0, value = 0;
    RixRenderState::Type type;
    RtInt ret = rstate->GetOption("user:disableIntegratorAOVs", &value,
                                  sizeof(RtInt), &type, &count);
    if (ret == 0 && count == 1 && value == 1)
    {
        aovIdList = NULL;
        return true;
    }
    return false;
}


//  This method should be called in RenderBegin as this is a one-time operation.
//  If our AOVs have been requested, their channel ids will be stored in
//  aovIdList. If not, aovIdList will be NULL to signal the fact that there is
//  nothing to output.
//
inline void GetChannelIds(RixIntegratorEnvironment &env,
                          RtInt * &aovIdList)
{
    if (!aovIdList)
    {
        aovIdList = new RtInt[k_numGeoAovs];
    }

    //  set all channels to un-requested
    for (int i=0; i<k_numGeoAovs; i++)
        aovIdList[i] = -1;

    //  Get displays
    RtInt numDisplays = env.numDisplays;
    RixDisplayChannel const* displayChannels = env.displays;

    //  parse the channels
    int numRequestedAOVs = 0;
    for (int dc=0; dc<numDisplays; ++dc)
    {
        for (int n=0; n<k_numGeoAovs; n++)
        {
            if (!strcmp(displayChannels[dc].channel, s_aovNames[n]))
            {
                // store the channel id in the correct aov slot
                aovIdList[n] = displayChannels[dc].id;
                ++numRequestedAOVs;
                break;
            }
        }
    }

    //  no requested AOVs : de-allocate and set to NULL.
    //  This is an early out signal.
    if (!numRequestedAOVs)
    {
        delete[] aovIdList;
        aovIdList = NULL;
    }
}


//  Returns true if we need temp float memory.
//
inline bool NeedTempFloat( RtInt *aovIdList )
{
    assert(aovIdList != NULL);
    return ( aovIdList[k_Pworld] > -1 && aovIdList[k_depth] > -1 );
}


//
inline void Splat(RtInt numShadingContexts,
                  RixShadingContext const **sctxs,
                  RixDisplayServices *dspsvc,
                  RtFloat3 *aovValue,
                  RtFloat *savedFloat,
                  RtInt *aovIdList,
                  RixBXLobeTraits const *lobesWanted = NULL)
{
    // we are NEVER expecting aovIdList == NULL
    // as it is our signal to skip this function.
    assert(aovIdList != NULL);
    assert(aovValue != NULL);

    // we get multiple shading contexts : go through them one by one.
    for (int g=0; g<numShadingContexts; g++)
    {
        RixShadingContext const &sctx = *sctxs[g];

        // no geometry hit : move along
        if (!sctx.HasHits())
            continue;

        //  Should only write for 'camera hits' during integration.
        //  Camera hits are normally the first hits, or for volumes, 
        //  the first scattering event.
        int* rayDepths = new int[sctx.numPts];
        bool write = false;
        if (sctx.GetProperty(k_RayDepth, rayDepths))
        {
            if (rayDepths[0] == 0)
            {
                RixBxdf &bxdf = *(sctx.GetBxdf());
                if (!bxdf.GetAllLobeTraits().GetContinuation())
                {
                    write = true;
                }
            }
        }
        else
        {
            write = true;
        }
        delete[] rayDepths;
        
        if (!write) continue;

        for (RtInt d=0; d<k_numGeoAovs; d++)
        {
            if (aovIdList[d] > -1)
            {
                if (d < RixShadingContext::k_numBuiltinVars)
                {
                    switch (d)
                    {                       
                        case RixShadingContext::k_P:
                        case RixShadingContext::k_Po:
                        case RixShadingContext::k_Nn:
                        case RixShadingContext::k_Ngn:
                        case RixShadingContext::k_Non:
                        case RixShadingContext::k_Tn:
                        case RixShadingContext::k_Vn:
                        case RixShadingContext::k_dPdu:
                        case RixShadingContext::k_dPdv:
                        case RixShadingContext::k_dPdw:
                        case RixShadingContext::k_dPdtime:
                        case RixShadingContext::k_Oi:
                        case RixShadingContext::k_motionFore:
                        case RixShadingContext::k_motionBack:
                        {
                            RtFloat3 const* p;
                            sctx.GetBuiltinVar((RixShadingContext::BuiltinVar)d, &p);
                            for (int i = 0; i < sctx.numPts; i++)
                            {
                                if (lobesWanted && !lobesWanted[i].GetValid())
                                {
                                    // Currently only single scattered volumes would 
                                    // have a non-NULL lobesWanted sent into this call, where 
                                    // lobesWanted set to none suggests no scattering event
                                    // occurred and we do not want to splat.
                                    continue;
                                }
                                dspsvc->Write(aovIdList[d],
                                    sctx.integratorCtxIndex[i],
                                    (RtColorRGB)p[i]);
                            }
                            break;
                        }                    
                        case RixShadingContext::k_PRadius:
                        case RixShadingContext::k_VLen:
                        case RixShadingContext::k_curvature:
                        case RixShadingContext::k_incidentRaySpread:
                        case RixShadingContext::k_incidentRayRadius:
                        case RixShadingContext::k_mpSize:
                        case RixShadingContext::k_biasR:
                        case RixShadingContext::k_biasT:
                        case RixShadingContext::k_u:
                        case RixShadingContext::k_v:
                        case RixShadingContext::k_w:
                        case RixShadingContext::k_du:
                        case RixShadingContext::k_dv:
                        case RixShadingContext::k_dw:
                        case RixShadingContext::k_time:
                        case RixShadingContext::k_outsideIOR:
                        case RixShadingContext::k_curvatureU:
                        case RixShadingContext::k_curvatureV:
                        {
                            RtFloat const* p;
                            sctx.GetBuiltinVar((RixShadingContext::BuiltinVar)d, &p);
                            for (int i = 0; i < sctx.numPts; i++)
                            {
                                dspsvc->Write(aovIdList[d],
                                    sctx.integratorCtxIndex[i],
                                    p[i]);
                            }
                            break;
                        }
                        case RixShadingContext::k_incidentLobeSampled: 
                        case RixShadingContext::k_Id:
                        case RixShadingContext::k_launchShadingCtxId:
                        {
                            int numDisplays;
                            RixDisplayChannel const *displays;
                            dspsvc->GetDisplayChannels(&numDisplays, &displays);
                            bool asInt = false;
                            for (int i = 0; i < numDisplays; i++)
                                if (displays[i].id == aovIdList[d])
                                {
                                    asInt = (displays[i].type ==
                                        RixDisplayChannel::k_IntegerChannel);
                                    break;
                                }
                            RtInt const* p;
                            sctx.GetBuiltinVar((RixShadingContext::BuiltinVar)d, &p);
                            if (asInt)
                                for (int i = 0; i < sctx.numPts; i++)
                                    dspsvc->Write(aovIdList[d],
                                                  sctx.integratorCtxIndex[i],
                                                  p[i]);
                            else
                                for (int i = 0; i < sctx.numPts; i++)
                                    dspsvc->Write(aovIdList[d],
                                                  sctx.integratorCtxIndex[i],
                                                  static_cast<float>(p[i]));
                            break;
                        }
                        case RixShadingContext::k_lpeState:
                        {
                            // Undefined to write a pointer to an AOV.
                            assert(true == false);
                            break;
                        }
                        default:
                            break;
                    }
                }
                else
                {
                    switch (d)
                    {
                        case k_Pworld:
                        {
                            // Get P in current space
                            RtFloat3 const *tmpP;
                            sctx.GetBuiltinVar(RixShadingContext::k_P, &tmpP);

                            // we can not transform the original P : we must operate
                            // on a copy.
                            memcpy(aovValue, tmpP, sctx.numPts * sizeof(RtFloat3));

                            // transform copy to world space
                            sctx.Transform(RixShadingContext::k_AsPoints,
                                "current", "world",
                                const_cast<RtFloat3*>(aovValue));

                            // if __depth has also been requested, save Y position
                            // in world space
                            for (int i = 0; i < sctx.numPts; i++)
                            {
                                dspsvc->Write(aovIdList[d],
                                    sctx.integratorCtxIndex[i],
                                    (RtColorRGB)aovValue[i]);
                                if (aovIdList[k_depth] > -1)
                                    savedFloat[i] = aovValue[i][1];
                            }
                            break;
                        }
                        case k_Nworld:
                        {
                            // Get Nn in current space
                            RtFloat3 const *tmpN;
                            sctx.GetBuiltinVar(RixShadingContext::k_Nn, &tmpN);

                            // we can not transform the original N : we must operate
                            // on a copy.
                            memcpy(aovValue, tmpN, sctx.numPts * sizeof(RtFloat3));

                            sctx.Transform(RixShadingContext::k_AsNormals,
                                "current", "world",
                                const_cast<RtFloat3*>(aovValue));

                            for (int i = 0; i < sctx.numPts; i++)
                            {
                                dspsvc->Write(aovIdList[d],
                                    sctx.integratorCtxIndex[i],
                                    (RtColorRGB)(aovValue[i]));
                            }
                            break;
                        }
                        case k_depth:
                        {
                            // depth from camera
                            RtFloat const *tmpf;
                            sctx.GetBuiltinVar(RixShadingContext::k_VLen, &tmpf);
                            RtFloat3 const *Nn;
                            sctx.GetBuiltinVar(RixShadingContext::k_Nn, &Nn);
                            RtFloat3 const *Vn;
                            sctx.GetBuiltinVar(RixShadingContext::k_Vn, &Vn);

                            // Y position in world space
                            bool PworldNotComputed = (aovIdList[k_Pworld] < 0);
                            if (PworldNotComputed)
                            {
                                RtFloat3 const *tmpP;
                                sctx.GetBuiltinVar(RixShadingContext::k_P, &tmpP);

                                // we can not transform the original P : we must
                                // operate on a copy.
                                memcpy(aovValue, tmpP, sctx.numPts * sizeof(RtFloat3));


                                // transform copy to world space
                                sctx.Transform(RixShadingContext::k_AsPoints,
                                    "current", "world",
                                    const_cast<RtFloat3*>(aovValue));
                            }
                            RtColorRGB depth;
                            for (int i = 0; i < sctx.numPts; i++)
                            {
                                if (PworldNotComputed)
                                {
                                    depth = RtColorRGB(tmpf[i],
                                        aovValue[i][1],
                                        AbsDot(Nn[i], Vn[i]));
                                }
                                else
                                {
                                    depth = RtColorRGB(tmpf[i],
                                        savedFloat[i],
                                        AbsDot(Nn[i], Vn[i]));
                                }
                                dspsvc->Write(aovIdList[d],
                                    sctx.integratorCtxIndex[i],
                                    depth);
                            }
                            break;
                        }
                        case k_st:
                        {
                            RtFloat2 const* st;
                            RtFloat2 defaultST(0.0f, 0.0f);
                            sctx.GetPrimVar("st", defaultST, &st);
                            for (int i = 0; i < sctx.numPts; i++)
                            {
                                RtFloat2 const* st;
                                RtFloat2 defaultST(0.0f, 0.0f);
                                sctx.GetPrimVar("st", defaultST, &st);
                                for (int i = 0; i < sctx.numPts; i++)
                                {
                                    dspsvc->Write(aovIdList[d],
                                        sctx.integratorCtxIndex[i],
                                        RtColorRGB(st[i].x, st[i].y, 0.f));
                                }
                                break;
                            }
                        }
                        case k_Pref:
                        case k_WPref:
                        case k_Nref:
                        case k_WNref:
                        {
                            RtFloat3 const *tmpP;
                            RixSCDetail pDetail = sctx.GetPrimVar(s_aovNames[d],
                                RtFloat3(0.0f),
                                &tmpP);
                            if (pDetail == k_RixSCVarying)
                            {
                                /**
                                 * @note The primvars are provided in "current"
                                 * space, so we have to undo that transformation to
                                 * output the expected values.
                                 */
                                RixShadingContext::TransformInterpretation interp;
                                if (d == k_Pref || d == k_WPref)
                                    interp = RixShadingContext::k_AsPoints;
                                else
                                    interp = RixShadingContext::k_AsNormals;

                                sctx.Transform(interp,
                                           "current", "object",
                                           const_cast<RtFloat3*>(tmpP),
                                           NULL);

                                for (int i = 0; i < sctx.numPts; i++)
                                {
                                    dspsvc->Write(aovIdList[d],
                                        sctx.integratorCtxIndex[i],
                                        (RtColorRGB)tmpP[i]);
                                }
                            }
                            break;
                        }
                        case k_rawId:
                        {
                            RtInt const* p;
                            sctx.GetBuiltinVar(RixShadingContext::k_Id, &p);
                            for (int i = 0; i < sctx.numPts; i++)
                                dspsvc->Write(aovIdList[d],
                                              sctx.integratorCtxIndex[i],
                                              p[i]);
                            break;
                        }
                    } // switch
                } // else
            }   // if requested aov
        }   // iterate over aov list
    }   // iterate over shading contexts
}

} // namespace

#endif

