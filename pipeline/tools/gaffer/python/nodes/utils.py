

import Gaffer
import GafferUI
import GafferScene
import GafferSceneUI
import math, psutil


def setToList(node, setName='assetList'):
    ''' convert a Gaffer Scene set to a normal python list without hierarchy '''
    set = node['out'].set(setName)
    return [ x.split('/')[-1] for x in set.value.paths() ]

def samAssetToGaffer( samAssetName ):
    ''' because sam uses a path for asset names and gaffer uses the same system for objects in the hierarchy
    this function converts a samAsset path to a name that can be used in gaffer as object name'''
    return 'SAM | '+samAssetName.replace( '/', ' | ' )

def gafferToSamAsset( samAssetName ):
    ''' converts a samAsset in gaffer format back to a path'''
    return samAssetName.replace( ' | ', '/' ).split('SAM/')[-1]

def setToAssetList(node, setName='assetList'):
    ''' convert a Gaffer Scene set to a normal python list without hierarchy '''
    set = node['out'].set(setName)
    return [ gafferToSamAsset(x.split('/')[-1]) for x in set.value.paths() ]


def viewerCameraParameters(node):
    ''' get camera values from all viewers showing a 3dScene '''
    ret = []
    layout = GafferUI.ScriptWindow.acquire( node.scriptNode() ).getLayout()
    viewers = [ v for v in layout.editors( GafferUI.Viewer ) if v and isinstance( v.view(), GafferSceneUI.SceneView ) ]
    for v in viewers:
        c = v.view().viewportGadget().getCamera()
        s, h, r, t = c.getTransform().transform().extractSHRT()
    	ret += [{
            'camera' : c,
            'translate' : t,
            'rotate' : r  * 180.0 / math.pi,
            'scale' : s,
            'h' : h,
            'viewer' : v
        }]
    return ret


def ps(grep):
    ret=[]
    for p in psutil.process_iter():
        try:
            if grep in ' '.join(p.cmdline()):
                ret += [p]
        except: pass
    return ret
