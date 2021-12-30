/*
# ------------------------------------------------------------------------------
#
# Copyright (c) 1986-2017 Pixar. All rights reserved.
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

/* $Revision: #10 $ */

#include "RixIntegrator.h"
#include "RixBxdf.h"
#include "RixShadingUtils.h"
#include "RixRNG.h"
#include "PxrGeoAovs.h"
#include <cassert>
#include <cstring>

class PxrDefault : public RixIntegrator
{
public:

    PxrDefault();
    virtual ~PxrDefault();

    virtual int Init(RixContext &, char const *pluginpath);
    virtual RixSCParamInfo const *GetParamTable(); // ???
    virtual void Finalize(RixContext &); // ???

    virtual void RenderBegin(RixContext &ctx, RixIntegratorEnvironment &env,
                             RixParameterList const *);
    virtual void RenderEnd(RixContext &ctx);

    virtual void Integrate(RtInt ngrps, RixShadingContext const *shadeGrps[], 
                           RixIntegratorContext &ictx);
private:
    RixMessages *m_msgs;
    RixChannelId m_ciChan;
    RtInt m_maxShadingCtxSize;
    RixRNG::SampleCtx *m_smpCtx;
    RtInt *m_geoAovIds;
};

PxrDefault::PxrDefault()
    : m_geoAovIds(NULL)
{
}

PxrDefault::~PxrDefault()
{
    delete[] m_geoAovIds;
    m_geoAovIds = NULL;
}

int
PxrDefault::Init(RixContext &ctx, char const *pluginpath)
{
    // Setup any shared resources
    m_msgs = (RixMessages*) ctx.GetRixInterface(k_RixMessages);
    // m_msgs->Info("PxrDefault: Init");
    return 0;
}

RixSCParamInfo const *
PxrDefault::GetParamTable()
{
    static RixSCParamInfo s_ptable[] = 
    {
        // currently no inputs

        RixSCParamInfo() // end of table
    };
    return &s_ptable[0];
}

void
PxrDefault::Finalize(RixContext &ctx)
{ 
    // m_msgs->Info("PxrDefault: Finalize");
}

void
PxrDefault::RenderBegin(RixContext &ctx, RixIntegratorEnvironment &env,
                        RixParameterList const *plist)
{
    
    m_maxShadingCtxSize = env.maxShadingCtxSize;
    // no other parameters expected/supported...
    for (int index = 0; index < env.numDisplays; ++index) 
    {
        if (!strcmp("Ci", env.displays[index].channel))
            m_ciChan = env.displays[index].id;
    }
    m_smpCtx = new RixRNG::SampleCtx[m_maxShadingCtxSize];

    // Get the list of requested geometric AOVs
    PxrGeoAOV::GetChannelIds(env, m_geoAovIds);
}

void
PxrDefault::RenderEnd(RixContext &ctx)
{
    delete[] m_smpCtx;
    // m_msgs->Info("PxrDefault: RenderEnd\n");
}

void
PxrDefault::Integrate(RtInt nGroups, RixShadingContext const *shadeGrps[],
                      RixIntegratorContext &iCtx)
{
    static const unsigned k_rngDomain = 0xf88bce9;

    RixDisplayServices *displaySvc = iCtx.GetDisplayServices();

    // initialize random number generator.
    // Note that the sample context array (m_smpCtx) in rng
    // gets initialized later (by the calls to NewDomain() below).
    RixRNG rng(iCtx.rngCtx, m_smpCtx);

    RtColorRGB diffuse[k_RixBXMaxNumDiffuseLobes];
    RtColorRGB specular[k_RixBXMaxNumSpecularLobes];
    RtColorRGB user[k_RixBXMaxNumUserLobes];
    RtColorRGB *diffusePtrs[k_RixBXMaxNumDiffuseLobes];
    RtColorRGB *specularPtrs[k_RixBXMaxNumSpecularLobes];
    RtColorRGB *userPtrs[k_RixBXMaxNumUserLobes];
    
    for (int i = 0; i < k_RixBXMaxNumDiffuseLobes; i++)
        diffusePtrs[i] = &diffuse[i];
    for (int i = 0; i < k_RixBXMaxNumSpecularLobes; i++)
        specularPtrs[i] = &specular[i];
    for (int i = 0; i < k_RixBXMaxNumUserLobes; i++)
        userPtrs[i] = &user[i];

    RtColorRGB *emitLight = new RtColorRGB[m_maxShadingCtxSize];
    RtColorRGB *emitLocal = new RtColorRGB[m_maxShadingCtxSize];
    
    for(int g = 0; g < nGroups; g++)
    {
        RixShadingContext const &sCtx = *shadeGrps[g];
        RixBxdf &bxdf = *(sCtx.GetBxdf());
        RtVector3 const* Vn;
        sCtx.GetBuiltinVar(RixShadingContext::k_Vn, &Vn);

        bool anyLocalEmission = bxdf.EmitLocal(emitLocal);
        
        if (sCtx.GetLightEmission(emitLight))
        {
            // if there was local emission, we add the light emission
            if (anyLocalEmission)
            {
                for (int i = 0; i < sCtx.numPts; i++)
                {
                    emitLocal[i] += emitLight[i];
                }
            }
            // else we copy light emission into local emission
            else
            {
                memcpy(emitLocal, emitLight, sizeof(RtColorRGB) * sCtx.numPts);
                anyLocalEmission = true;
            }
        }

        // FIXME:
        // Hmm, we have EvaluateSample now. Perhaps we should use that instead?
        for(int i = 0; i < sCtx.numPts; i++) 
        {
            int ctxIdx = sCtx.integratorCtxIndex[i];
            m_smpCtx[i] = iCtx.rngCtx->NewDomain(ctxIdx, k_rngDomain); // no splitting

            // set Ldir to be viewing dir
            RtVector3 const &lDir = Vn[i];

            RixBXLobeWeights lw(1, 
                                k_RixBXMaxNumDiffuseLobes, 
                                k_RixBXMaxNumSpecularLobes,
                                k_RixBXMaxNumUserLobes,
                                diffusePtrs, specularPtrs, userPtrs);
            RixBXLobeTraits valid;
            RtFloat fPdf, rPdf;
            bxdf.EvaluateSamplesAtIndex(k_RixBXDirectLighting, // fake light
                                        k_RixBXTraitsAllReflect, 
                                        &rng,
                                        i, 1, &valid, &lDir,
                                        lw, &fPdf, &rPdf);
            if(valid.GetValid())
            {
                RixBXActiveLobeWeights activeLobes;
                lw.GetActiveLobes(activeLobes);

                RtColorRGB val = activeLobes.SumAtIndex(0);

                // note the warning due to needing to pass in an address
                displaySvc->Splat(m_ciChan, sCtx.integratorCtxIndex[i],
                                  F_PI * val);
            }

            if(anyLocalEmission) {
                RtColorRGB val = emitLocal[i] * sCtx.transmission[i];
                displaySvc->Splat(m_ciChan, sCtx.integratorCtxIndex[i],
                                  val);

            }

            displaySvc->WriteOpacity(m_ciChan, sCtx.integratorCtxIndex[i], 1.0f);

            //run emission on the bxdf

        }
    }
    delete[] emitLight;
    delete[] emitLocal;

    if (m_geoAovIds)
    {
        RtFloat3 *geoAovColor = NULL;
        RtFloat  *geoAovFloat = NULL;
        geoAovColor = new RtFloat3[m_maxShadingCtxSize];
        if (PxrGeoAOV::NeedTempFloat(m_geoAovIds))
            geoAovFloat = new RtFloat[m_maxShadingCtxSize];
        PxrGeoAOV::Splat(nGroups,
            shadeGrps,
            displaySvc, geoAovColor,
            geoAovFloat, m_geoAovIds);
        delete[] geoAovColor;
        delete[] geoAovFloat;
    }
}

RIX_INTEGRATORCREATE
{
    return new PxrDefault();
}

RIX_INTEGRATORDESTROY
{
    delete ((PxrDefault*)integrator);
}