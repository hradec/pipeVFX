


import maya.cmds as m
from maya.mel import eval as meval
import os
import pipe


prman=pipe.isEnable('prman')
try:
    if prman:
        meval('source "renderManNodes";rmanCreateGlobals')
except:
    prman=False


def stopIPR():
    if prman:
        try:
            meval('source "renderManNodes";stopIprRendering (`rmanGetRenderWindowPanel`);')
        except:
            pass

def setupRISGlobals():
    if prman:
        meval('source "renderManNodes";rmanCreateGlobals')
        m.setAttr("renderManRISGlobals.rman__toropt___lazyRibGen",0)
        # prevent crash in the farm if using Render -batchcontext
        if m.objExists( 'renderManRISGlobals.spoolingBatchContext' ):
            m.deleteAttr('renderManRISGlobals.spoolingBatchContext')
        if m.objExists( 'renderManRISGlobals.spoolingBatchContext' ):
            m.deleteAttr('renderManRISGlobals.spoolingBatchContext')


def setRenderScripts():
    if prman:
        if not m.objExists("renderManRISGlobals.rman__torattr___postWorldBeginScript"):
            meval('source "renderManNodes";rmanCreateGlobals')
            m.addAttr( "renderManRISGlobals", ln="rman__torattr___postWorldBeginScript", dt="string" )
        m.setAttr( "renderManRISGlobals.rman__torattr___postWorldBeginScript", '''python("import samPrman;reload(samPrman);samPrman.rlf2rib()")''', type="string" )


def rlf2rib():
    if prman:
        frame = m.currentTime(q=1)
        for n in m.ls("|SAM_shaders_*"):
            attr = '%s.SAM_RLF_FILE' % n
            if m.objExists(attr):
                rlfs = eval(m.getAttr(attr))
                if frame not in rlfs:
                    ids = rlfs.keys()
                    ids.sort()
                    print( "SAM WARNING: No frame %s found in RLF files list from asset %s/(%s-%s)" % ( frame, os.path.dirname(rlfs[ids[0]]).split('sam/')[-1], ids[0], ids[-1] ) )
                    frame = ids[0]
                attachRLF( rlfs[frame] )

def attachRLF(rlfFile):
    if prman:
        # meval('RiArchiveRecord("comment", "#RLF ScopeEnd\\n##RLF ScopeBegin -rlffilename %s -namespace")' % rlfFile)
        mel = 'RiArchiveRecord("comment", "\\n##RLF ScopeBegin -rlffilename %s -namespace")' % rlfFile
        print( mel )
        meval(mel)

def getRibFolder(frame=m.currentTime(q=1)):
    return "%s/%s/%04d/" % ( m.workspace(q=1,rd=1), meval("rman subst `rman getvar rfmRIBs`"), frame )

def getRLF(frame=m.currentTime(q=1)):
    ret = []
    if prman:
        from glob import glob
        ribFolder = getRibFolder(frame)
        for f in glob("%s/*.rlf" % ribFolder):
            if [ x for x in open(f,'r').readlines() if 'RIB' in x ]:
                ret += [f]
    return ret

def exportRLF(frame=m.currentTime(q=1), animation=None, range=None):
    rlf = {}
    if prman:
        import genericAsset, os

        minFrame = frame
        maxFrame = frame
        by       = 1
        if animation:
            if not range:
                minFrame = m.playbackOptions(q=1, minTime=1)
                maxFrame = m.playbackOptions(q=1, maxTime=1)
                by       = m.playbackOptions(q=1, by=1)
            else:
                minFrame = range[0]
                maxFrame = range[1]
                by       = range[2]


        # progress bar
        pb = genericAsset.progressBar( (maxFrame-minFrame)+3, "Exporting Renderman Look Files for each frame in the frame range...")


        # generate dynamic rules for the current shading attachments
        genericAsset.maya.createDinamicRules( m.ls(geometry=1,l=1), 'Creating shader dinamic rules...' )

        # hide all geometry so we only export RLF
        for dl in m.ls('__SAM__SHADER__EXPORT__*', type="displayLayer"):
            m.delete(dl)

        m.select(m.ls('|*'))
        layer = m.createDisplayLayer(name="__SAM__SHADER__EXPORT__", nr=1)
        m.setAttr("%s.visibility" % layer, 0)


        # cleanup folder just in case
        os.system( 'rm -rf %s' % os.path.dirname(getRibFolder(frame)) )
        pb.step()

        # only use perspShape!
        cameras = {}
        for c in m.ls(type='camera'):
            cameras[c] = {'renderable' : m.getAttr('%s.renderable' % c)}
            m.setAttr('%s.renderable' % c, 0)
        m.setAttr('%s.renderable' % c, 0)
        m.setAttr('perspShape.renderable', 1)
        pb.step()

        # generate rib
        frame = minFrame
        while frame <= maxFrame:
            meval( ''' rman genrib -s %s -e %s ''' % (frame, frame) )
            rlf[frame] = getRLF(frame)
            frame += by
            pb.step()

        # restore cameras
        for c in cameras:
            m.setAttr('%s.renderable' % c, cameras[c]['renderable'])

        # restore geometry renderable state
        for dl in m.ls('__SAM__SHADER__EXPORT__*', type="displayLayer"):
            m.delete(dl)

        # cleanup dinamic rules!
        dr = genericAsset.maya.prmanDinamicRules()
        dr.toScene()

        pb.step()
        pb.close()

    return rlf
