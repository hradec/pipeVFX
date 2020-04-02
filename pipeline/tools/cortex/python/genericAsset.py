# =================================================================================
#    This file is part of pipeVFX.
#
#    pipeVFX is a software system initally authored back in 2006 and currently
#    developed by Roberto Hradec - https://bitbucket.org/robertohradec/pipevfx
#
#    pipeVFX is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Lesser General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    pipeVFX is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Lesser General Public License for more details.
#
#    You should have received a copy of the GNU Lesser General Public License
#    along with pipeVFX.  If not, see <http://www.gnu.org/licenses/>.
# =================================================================================


import IECore, Gaffer, GafferUI, pipe, tempfile
import Asset
from glob import glob
import os, datetime, sys
import assetUtils
import traceback
from functools import wraps

import nodeMD5
reload(nodeMD5)

import samXgen
reload(samXgen)

try:
    from pymel import core as pm
    import maya.cmds as m
    from maya.mel import eval as meval
    import IECoreMaya
    reload(assetUtils)
    _m = m
    # hostApp('maya')
    import maya.utils as mu
except:
    m = None


# -----------------------------------------------------------------------------
# Decorators
# -----------------------------------------------------------------------------
def viewportOff( func ):
    """
    Decorator - turn off Maya display while func is running.
    if func will fail, the error will be raised after.
    """
    from functools import wraps

    @wraps(func)
    def wrap( *args, **kwargs ):

        # Turn $gMainPane Off:
        meval("paneLayout -e -manage false $gMainPane")

        # Decorator will try/except running the function.
        # But it will always turn on the viewport at the end.
        # In case the function failed, it will prevent leaving maya viewport off.
        try:
            return func( *args, **kwargs )
        except Exception:
            raise # will raise original error
        finally:
            meval("paneLayout -e -manage true $gMainPane")

    return wrap


def cleanAllShapeName():
    for each in m.ls(sl=1, dag=1, type='mesh', l=1):
        last = each.split('|')[-1]
        # for n in range(10):
        #     last = last.replace(str(n),'')
        #while last[-1].isdigit():
        #    each = each[:-1]
        l = 0
        for n in range(10):
            # path = path.replace(str(n),'')
            # split node name and gather the longest string!
            for x in last.split(str(n)):
                if len(x) > l:
                    last = x
                    l = len(last)

        each = '|'.join(each.split('|')[:-1]+[last])
        # print each



def push(nodes):
    import re
    attrPOP={}
    for node in nodes:
        versionPosition = re.search('_\d\d_\d\d_\d\d', node).start()
        _node = '|%s_??_??_??_*' % ( node[:versionPosition] )
        attrPOP[_node]={}
        for each in ['']+['|'.join(x.split('|')[2:]) for x in m.ls(node, dag=1, v=1,l=1) if x[1:] not in nodes]:
            attrPOP[_node][each]={}
            for attr in m.listAttr('|'+'|'.join([node,each]).rstrip('|'), w=1, o=1, se=1,m=0):
                try: attrPOP[_node][each][attr] = m.getAttr('|'+'|'.join([node,each]).rstrip('|')+'.'+attr)
                except: pass
    return attrPOP

def pop(attrPOP):
    for mask in attrPOP:
        nodes = m.ls(mask)
        for node in nodes:
            for each in attrPOP[mask]:
                for attr in attrPOP[mask][each]:
                    v = attrPOP[mask][each][attr]
                    attrName = '|'+'|'.join([node,each]).rstrip('|')+'.'+attr
                    attrName = attrName.replace('||','|')
                    try:
                        if type(v) in [ float, int ]:
                            m.setAttr( attrName, v)
                        if type(v) in [ str ]:
                            m.setAttr( attrName, v, type='string')
                    except:
                        print "pop(attrPOP) Exception: "+str(attrName)



def hostApp(app=None):
    if '_hostApp_' not in globals():
        globals()['_hostApp_'] = 'gaffer'
    if app:
        globals()['_hostApp_'] = app

    if globals()['_hostApp_']=='maya':
        globals()['m']=globals()['_m']
    else:
        globals()['m']=None
    # print app, globals()['m'], globals().keys()
    return globals()['_hostApp_']


def _nodeNameTemplate(prefix=False):
    ret = "SAM_%s_%s_%02d_%02d_%02d_%s"
    if prefix:
        ret = '_'.join( ret.split('_')[:3] )+'_'
    return ret

def _nodeName(data=None):
    ret = 'SAM_none_none_none_none'
    try:
        ret =  _nodeNameTemplate() % (
            data['assetType'].replace('/','_'),
            data['assetName'].replace('.','_'), #split('.')[-1],
            data['assetInfo']['version'].value.x,
            data['assetInfo']['version'].value.y,
            data['assetInfo']['version'].value.z,
            ''
        )
    except:
        pass
    return ret


def updateCurrentLoadedAssets(forceRefresh=False):
    # if forceRefresh or '_updateCurrentLoadedAssets__' not in globals():
    #     globals()['_updateCurrentLoadedAssets__'] = {}
    # _updateCurrentLoadedAssets__ = globals()['_updateCurrentLoadedAssets__']

    # make sure evaluation mode is set to DG, or else
    if m:
        if 'off' not in ''.join(m.evaluationManager( q=1, mode=1 )):
            m.evaluationManager( mode="off" )

        maya.applyCustomRules()

        types = assetUtils.types(forceRefresh)
        for t in types.keys():
            tt = t.split('/')
            nodeNamePrefix = _nodeNameTemplate(prefix=True) % (tt[0], tt[1])
            # try:
            #     if t not in _updateCurrentLoadedAssets__.keys():
            #         _updateCurrentLoadedAssets__[t] = assetUtils.loadAssetOP(t)
            # except:
            #     _updateCurrentLoadedAssets__[t] = None

            op = types.op(t)
            # print op, hasattr(op.op, 'typeOP'), hasattr(op.op.typeOP, 'onRefreshCallback'), nodeNamePrefix
            if hasattr(op.op, 'typeOP') and hasattr(op.op.typeOP, 'onRefreshCallback'):
                canRefresh = True
                if m and not m.ls('|%s*_??_??_??_*' % nodeNamePrefix):
                    canRefresh = False

                if canRefresh:
                    print 'SAM REFRESH =>',t, nodeNamePrefix
                    op.op.typeOP.onRefreshCallback( t, nodeNamePrefix )


class progressBar():
    def __init__(self, length, msg= "Processing shaders..."):
        qt = True
        if m and m.about(batch=1):
            qt = False
        if qt:
            import GafferUI
            with GafferUI.Window( msg ) as self.w :
              with GafferUI.ListContainer( GafferUI.ListContainer.Orientation.Horizontal, spacing = 6 ):
                with GafferUI.ListContainer( GafferUI.ListContainer.Orientation.Vertical, spacing = 6 ):
                    GafferUI.Label("<br>%s<br>" % msg)
                    self.pb = GafferUI.ProgressBar( 0, (0,length) )

            self.w._qtWidget().resize(600,100)
            self.w.setVisible(True)
        else:
            self.w = None
    def step(self):
        if self.w:
            self.pb.setProgress( self.pb.getProgress()+1 )
            # WARNING: processIdleEvents() crashes maya when called here since
            #          this method can be called when inside a idle event already!
            #          we can only enable it, if we find a way to detect when
            #          inside an idle event!
            # if m:
            #     mu.processIdleEvents()
    def close(self):
        if self.w:
            del self.w



class _genericAssetClass( IECore.Op ) :
    _whoCanImport = ["gaffer"]
    _whoCanPublish = ["gaffer"]
    _whoCanOpen = ["gaffer"]

    def hostApp(self, app=None):
        if app:
            hostApp(app)
        # print '_genericAssetClass:', hostApp()
        return hostApp()

    def __init__( self, prefix, animation=True, nameGroup='Group', nameDependency='Dependency', mayaNodeTypes='transform' ) :

        disabled={"UI":{ "invertEnabled" : IECore.BoolData(True) }}

        # print '_genericAssetClass:',hostApp()

        self._host = ["gaffer"]

        IECore.Op.__init__( self, "Publish model assets.",
            IECore.Parameter(
                name = "result",
                description = "",
                defaultValue = IECore.StringData("Done"),
                userData = {"UI" : {
                    "showResult" : IECore.BoolData( True ),
                    "showCompletionMessage" : IECore.BoolData( True ),
                    "saveResult" : IECore.BoolData( True ),
                }},
            )
        )

        self.mayaNodeTypes = mayaNodeTypes
        self.animation = animation
        self.nameGroup = nameGroup
        self.nameDependency =nameDependency
        self.prefix = prefix
        currentUser = pipe.admin.job.shot.user()


        source = IECore.StringParameter(
            name="%s%s" % (prefix, nameGroup),
            description = "type the path for the %s group"  % self.prefix,
            defaultValue = "",
            # allowEmptyString=False,
            userData = {
                'dataName' : IECore.StringData('meshPrimitives'),
                'updateFromApp':IECore.BoolData( True ),
            }
        )

        self.parameters().addParameters(
            [
                source,
                IECore.FileNameParameter(
                    name="%s%s" % (prefix, nameDependency),
                    description = "Dependency file used to created this asset.",
                    allowEmptyString=False,
                    defaultValue = currentUser.path(),
                    userData = {
                        "UI": {
                            "defaultPath": IECore.StringData( "/atomo/jobs/" ),
                            "obeyDefaultPath" : IECore.BoolData(True),
                        },
                        # this UD flags this parameter to publish use to construct the asset filename
                        'assetPath':IECore.BoolData( True ),
                        'updateFromApp':IECore.BoolData( True ),
                        'dataName' : IECore.StringData('assetDependencyPath'),
                    }
                ),
            ])


        self.parameters().addParameters([
                IECore.BoolParameter(
                    name="enableAnimation",
                    description = "Enable exporting animation.",
                    defaultValue = False,
                    userData = { "UI": {
                        "collapsed" : IECore.BoolData(False),
                        "visible" : IECore.BoolData(animation),
                    }},
                ),
                IECore.CompoundParameter("FrameRange","",[
                    IECore.V3fParameter("range","Inicio, fim e 'step' da sequencia a ser rendida.",IECore.V3f(0, 10, 1), userData=disabled),
                ],userData = { "UI": {
                    "collapsed" : IECore.BoolData(True),
                    "visible" : IECore.BoolData(animation),
                }}),
        ])

        self.canPublish = True
        # if hasattr(self, 'updateFromHost'):
        self.updateFromHost()

    def updateFromHost(self):
        # if we're inside maya!
        self._host = []
        # print 'updateFromHost:',hostApp()
        if hostApp()=='maya' and m:
            self._host += ["maya"]
            if self.animation:
                timeSlider = {
                    'animationStartTime' : m.playbackOptions(q=1,animationStartTime=1),
                    'animationEndTime'   : m.playbackOptions(q=1,animationEndTime=1),
                    'by'                 : m.playbackOptions(q=1,by=1),
                    'minTime'            : m.playbackOptions(q=1,minTime=1),
                    'maxTime'            : m.playbackOptions(q=1,maxTime=1),
                    'playbackSpeed'      : m.playbackOptions(q=1,playbackSpeed=1),
                    'maxPlaybackSpeed'   : m.playbackOptions(q=1,maxPlaybackSpeed=1),
                    'framesPerSecond'    : m.playbackOptions(q=1,framesPerSecond=1),
                    'view'               : m.playbackOptions(q=1,view=1),
                    'loop'               : m.playbackOptions(q=1,loop=1),
                }
                start = timeSlider['animationStartTime']
                end = timeSlider['animationEndTime']
                byFrameStep = timeSlider['by']
                self.parameters()["FrameRange"]['range'].setValue( IECore.V3f(start, end, byFrameStep) )
            else:
                currentFrame = float(m.currentTime(q=1))
                self.parameters()["FrameRange"]['range'].setValue( IECore.V3f(currentFrame, currentFrame, 1.0) )

            selected = m.ls('SAM_PUBLISH*')
            if selected:
                selected = ','.join(m.sets(selected, q=1))
            else:
                if self.mayaNodeTypes=='transform':
                    selected = ','.join(m.ls(sl=1,l=1,tr=1))
                else:
                    selected = ','.join(m.ls(sl=1,l=1))

            scene = m.file(q=1,sn=1)
            if not scene:
                self.canPublish = False

            self.parameters()["%s%s" % (self.prefix, self.nameGroup)].setValue(  IECore.StringData(selected) )
            self.parameters()["%s%s" % (self.prefix, self.nameDependency)].setValue(  IECore.StringData(scene) )

        elif hostApp()=='gaffer' and hasattr(GafferUI, 'root'):
            self.root = GafferUI.root
            scene = self.root()['scripts'][0]["fileName"].getValue()

            self.parameters()["%s%s" % (self.prefix, self.nameDependency)].setValue(  IECore.StringData(scene) )


    def parameterChanged(self, parameter):
        if hasattr( parameter, 'parameterChanged' ):
            parameter.parameterChanged( parameter )

        if parameter.name == 'enableAnimation':
            # print dir(parameter)
            self.animation = bool(parameter.getValue())
            self.parameters()["FrameRange"].userData()["UI"]["visible"] = IECore.BoolData(bool(parameter.getValue()))
            self.updateFromHost()

        if hasattr( self, 'uiCallback' ):
            self.uiCallback(parameter)

    @staticmethod
    def cleanupScene():
        '''
            Delete namespaces in a scene!
        '''
        if hostApp()=='maya' and m:
            for each in { ':%s' % ':'.join(x.split(':')[:-1]) : x.split(':')[-1] for x in  m.ls("*:*")}:
                # print each
                m.namespace( removeNamespace = each, mergeNamespaceWithParent = True)

    @staticmethod
    def doPublishPreview(data={}):
        '''
        Called by ALL generic assets publish, to generate a thumbnail of
        the current viewport to be saved as preview.jpg in the asset.
        In case SAM can't display the asset file type, it will show this preview.jpg!
        '''
        if 'extraFiles' not in data:
            data['extraFiles'] = []

        if hostApp() == 'maya' and m:
            import maya.OpenMaya as api
            import maya.OpenMayaUI as apiUI
            data['extraFiles'] += [ '%s/data/preview.jpg' % m.workspace(q=1, rd=1) ]

            sl = m.ls(sl=1)
            m.select(cl=1)

            #Grab the last active 3d viewport
            view = apiUI.M3dView.active3dView()

            #read the color buffer from the view, and save the MImage to disk
            image = api.MImage()
            view.readColorBuffer(image, True)
            image.writeToFile(data['extraFiles'][-1], 'jpg')
            m.select(sl)

        elif hostApp() == 'gaffer':
            data['extraFiles'] += [ '%s/data/preview.jpg' % m.workspace(q=1, rd=1) ]

            scriptWindow = GafferUI.ScriptWindow.acquire( GafferUI.root() )
            nodeGraph = scriptWindow.getLayout().editors( GafferUI.NodeGraph )
            if not nodeGraph:
                nodeGraph = scriptWindow
            pixmap = QtGui.QPixmap.grabWindow( nodeGraph._qtWidget().winId() )
            IECore.msg( IECore.Msg.Level.Info, "screengrab", "Writing image [ %s ]" % args["image"].value )
            pixmap.save( data['extraFiles'][-1] )

        return data


    def publishFile(self, publishFile, parameters):
        path = os.path.dirname(publishFile)
        name = os.path.splitext(os.path.basename(publishFile))[0]
        file = "%s/%s.%%s%s" % (path, name, os.path.splitext(parameters['Asset']['type']['%sDependency' % self.prefix].value)[-1])
        return file


    def cleanupOldVersions( self, nodeName ):
        ''' delete any other version! '''
        if m:
            nodes = self.doesAssetExists(nodeName)

            maya.cleanNodes( self.doesAssetExists(nodeName) )

            # cleanup shader leftovers
            maya.cleanUnusedShadingNodes()

            maya.cleanNodes( m.ls("SAMIMPORT*") )


    def doesAssetExists( self, nodeName, anyVersion=True):
        ''' find the asset in the scene, no matter what version it is! '''
        nodes=[]
        if m:
            if anyVersion:
                import re
                versionPosition = re.search('_\d\d_\d\d_\d\d', nodeName).start()
                mask = '|%s_??_??_??_*' % ( nodeName[:versionPosition] )
                # print mask, m.ls(mask)
                nodes = m.ls(mask)
            else:
                nodes = m.ls('|%s*' % nodeName)
        return nodes




    def getAssetDataHistory(self, parameters):
        ''' get data from asset based on some history in the host app, if any'''
        meshs = [ x.strip() for x in str(parameters['Asset']['type']['%s%s' % (self.prefix,  self.nameGroup)].value).split(',') ]
        if meshs:
            for mesh in meshs:
                if m:
                    if m.objExists( '%s.pipe_asset' % mesh ):
                        return parameters.getAssetData(m.getAttr( '%s.pipe_asset' % mesh ))

    def doOperation( self, operands ):
        if self.animation:
            self.frameRange = operands['FrameRange']['range'].value
        meshPrimitives = [ x.strip() for x in str(operands['%s%s' % (self.prefix,  self.nameGroup)].value).split(',') ]
        self.data['assetPath'] = "%s%%s"  % tempfile.mkstemp()[1]
        self.data['meshPrimitives'] = meshPrimitives
        self.data['multipleFiles'] = [  x.replace('|','_') for x in self.data['meshPrimitives'] ]

        if not self.canPublish:
            raise Exception("ERROR: You need to save the scene before publishing it, so SAM can keep track of what created the asset!")

        # create a md5 attr with the md5 of the original
        # name, so we can find geometry if the host screw up the
        # original published names.
        nodeMD5.nodeMD5().bakeAllMD5()

        canPublish = 0
        if hasattr(self, 'doPublishMaya') and 'maya' in self._host:
            canPublish += self.doPublishMaya(operands)
        elif hasattr(self, 'doPublishHoudini'):
            canPublish += self.doPublishHoudini(operands)
        elif hasattr(self, 'doPublishNuke'):
            canPublish += self.doPublishNuke(operands)
        elif hasattr(self, 'doPublish'):
            canPublish += self.doPublish(operands)

        if not canPublish:
            raise Exception( "Can't publish this asset type when running from %s!" % '/'.join(self._host) )

        if m:
            maya.doPublishPreview(self.data)

        return IECore.StringData( 'done' )


    def doPublish(self, operands):
        ''' use to  implement extra publish stuff '''
        pass

    def childrenNodes(self, nodes):
        ''' use to implement extra nodes to be returned if needed'''
        return []


    def postPublish(self, operands, finishedSuscessfuly=False):
        ''' use to  implement extra post publish stuff, like cleanup'''

        # cleanup extraFiles
        if 'extraFiles' in self.data:
            for f in self.data['extraFiles']:
                if '/data/preview.jpg' in f:
                    os.system('rm -rf %s' % f)
                elif '/dev/shm/' in f:
                    os.system('rm -rf %s' % f)

        if 'extraFilesDelete' in self.data:
            for f in self.data['extraFilesDelete']:
                os.system('rm -rf %s' % f)


    def nodeName(self, data=None):
        return _nodeName(data)

    def doImport(self, asset, data=None, replace=True):
        # maya import

        self.asset = Asset.AssetParameter(asset)
        if not data:
            data = self.asset.getData()
        self.data = data

        # print self.data['multipleFiles']
        for n in range(len(self.data['multipleFiles'])):
            each = os.path.splitext(self.data['multipleFiles'][n])[0]
            filename = self.data['multiplePublishedFiles'][n]
            # print filename

            nodeName = self.nodeName(self.data) + each

            stack = []
            if replace:
                # allways import the asset, if the current version is different than the one
                # to be imported!
                if self.doesAssetExists(nodeName, anyVersion=False):
                    continue

                # push attributes values of to be deleted nodes so we can restore after update
                stack = push(self.doesAssetExists(nodeName))
                self.cleanupOldVersions(nodeName)
            else:
                # if the scene already has a version of the node,
                # don't import another!
                if self.doesAssetExists(nodeName, anyVersion=True):
                    continue

            canPublish = 0
            if hasattr(self, 'doImportMaya'):
                canPublish += self.doImportMaya(filename, nodeName)
            if hasattr(self, 'doImportHoudini'):
                canPublish += self.doImportHoudini(filename, nodeName)
            if hasattr(self, 'doImportNuke'):
                canPublish += self.doImportNuke(filename, nodeName)

            if not canPublish:
                raise Exception("Can't import asset when running from shell!!")

            self.fixRIGMeshCTRLS()

            updateCurrentLoadedAssets()

            pop(stack)

    @staticmethod
    def fixRIGMeshCTRLS(grp='|CTRLS|'):
        if m:
            attrs=[
                'castsShadows',
                'receiveShadows',
                'holdOut',
                'motionBlur',
                'primaryVisibility',
                'smoothShading',
                'visibleInReflections',
                'visibleInRefractions',
                'doubleSided',
                'opposite',
            ]
            for n in [ x for x in m.ls(dag=1,long=1,type='mesh')  if grp in x ]:
                for a in attrs:
                    m.setAttr( '%s.%s' % (n,a), 0 )

            # for node in m.ls(geometry=1,l=1):
            #     if grp in node:
            #         m.delete(node)



__maya__attach__shaders__lazyCount = 0
class maya( _genericAssetClass ) :
    _whoCanImport = ['maya','gaffer']
    _whoCanPublish = ['maya']
    _whoCanOpen = ["maya"]

    def __init__( self, prefix, mayaNodeTypes='transform', mayaScenePublishType=None, animation=False ) :
        _genericAssetClass.__init__( self, prefix, animation=animation, mayaNodeTypes=mayaNodeTypes )
        self.__mayaScenePublishType = mayaScenePublishType


    def setMayaSceneType(self, st):
        self.__mayaScenePublishType = st



    @staticmethod
    def applyCustomRules():
        '''
            We use this to dinamically create rules on objects that have an string parameter named SAM_DINAMIC_RULE
            this way we can OVERRIDE the rule that gets into a render or into a RLF to be published!
            Perfect to have a single object with a
        '''
        # dr = maya.prmanDinamicRules()
        # dr.fromScene()
        # if not dr.isEmpty():
        #     dr = maya.prmanDinamicRules()
        #     dr.toScene()

        # customRules = [ x for x in m.ls(type='shape') if m.objExists(x+'.SAM_DINAMIC_RULE') ]
        # if customRules:
        #     maya.createDinamicRules(customRules)
        maya.createDinamicRules()

    @staticmethod
    class prmanDinamicRules():
        ''' a simple class to handle prman dinamic rules in a simple way!'''
        def __init__(self):
            try:
                import rfm.rlf2maya as rlf2maya
                import rfm.rlf as rlf
                self.s  = rlf.RLFScope()
                self.ps = self.s.GetInjectionPayloads()
                self.rlf2maya = rlf2maya
                self.rlf = rlf
                self.cache = {}
            except:
                print "WARNING: No prman python module to set dynamic rules for shaders."
                rlf2maya = rlf = None

        def fromScene(self):
            if self.rlf2maya:
                self.s = self.rlf2maya.GetActiveScope()

        def isEmpty(self):
            return self.s.GetRules() == []

        def payload(self, sg):
            if self.rlf2maya:
                label = m.listConnections('%s.surfaceShader' % sg, s=1, d=0)
                p=None
                if not label:
                    print "WARNING: Shading group %s have no surface shader!" %sg
                else:
                 data = {
                    'Content'   : '1',
                    'Label'     : label[0],
                    'Payload'   : '#payload provided at runtime by RFM',
                    'Source'    : '1'
                 }
                 p=self.rlf.RLFPayload()
                 p.SetData(data)
                 p.SetType(0)
                 p.SetID(sg)
                 self.s.CreatePayload( sg, 0, data )
                return p

        def addRule(self, name, sg, node=''):
            if self.rlf2maya:
                if name and name in self.cache.keys():
                    if sg != self.cache[name]:
                        # print self.cache.keys()
                        raise Exception("ERROR: there are 2 shape nodes named \n%s(sg:%s)\n and \n%s(sg:%s) \nwith different shadingGroups! Please rename one!!" % (node, sg, name, self.cache[name]))
                    else:
                        return

                if not node:
                    node=name

                self.cache[node] = sg
                r=self.rlf.RLFRule()
                p=self.payload(sg)
                if p:
                    r.Initialize( 0, 3, "//%s" % name, 0, p )
                    self.s.AddRule(r)

        def toScene(self):
            if self.rlf2maya:
                self.rlf2maya.SetActiveScope(self.s)


    @staticmethod
    def attachShadersLazy():
        maya.attachShaders( lazyRefresh=True )

    @staticmethod
    def attachShaders(lazyRefresh=False):
        if lazyRefresh:
            def __attachShaders():
                maya._attachShaders(True)
            assetUtils.mayaLazyScriptJob( runOnce=True,  idleEvent=__attachShaders )
        else:
            assetUtils.mayaLazyScriptJob( runOnce=True,  idleEvent=maya._attachShaders )



    @staticmethod
    def node2rule(nodeName):
        # if 'SAM_' in nodeName:
        #     return ''
        #*[starts-with(name(),'paperclip')]
        # print nodeName
        paths = []
        # for path in nodeName.split('|'):
        for path in [nodeName.split('|')[-1]]:
            if path:
                path = path.split(':')[-1]
                # remove Shape from name
                l = 0
                for x in path.split('Shape'):
                    if len(x) > l:
                        path = x
                        l = len(path)

                for n in range(10):
                    # path = path.replace(str(n),'')
                    # split node name and gather the longest string!
                    l = 0
                    for x in path.split(str(n)):
                        if len(x) > l:
                            path = x
                            l = len(path)

                paths += [path]

        if paths:
            p = ''
            # paths.reverse()
            for ps in paths:
                if not p:
                    p = "*[starts-with(name(),'%s')]" % ps
                else:
                    p = "*[starts-with(name(),'%s') and parent::%s]" % (ps, p)
            rule = p

            rule = '/'.join( [ "*[contains(name(),'%s')]" % ps for ps in paths ] ).strip('|').replace('|','/')
        else:
            path = nodeName.split('|')[-1]
            path = path.split(':')[-1]
            p = "*[starts-with(name(),'%s')]" % path
            rule = "*[contains(name(),'%s')]" % path
            rule = rule.strip('|').replace('|','/')

        return rule


    @staticmethod
    def rule2node(rule):
        return rule.lstrip('/').replace('/','|')

    @staticmethod
    def createDinamicRules(nodes=[], message='Attaching shaders...'):
        import maya.cmds as m
        dr = maya.prmanDinamicRules()
        # dr.fromScene()
        # pb = progressBar(len(nodes), message)

        # add extra node which have SAM_DR attributes to create dinamic rules
        extra = []
        for each in m.ls("|*", type='transform'):
            attrList = m.listAttr(each, ud=1)
            if attrList and [ a for a in attrList if 'SAM_D' in a ]:
                extra += [each]
            meshs = m.listRelatives(each,c=1,f=1, type='mesh')
            if meshs:
                for mesh in meshs:
                    attrList = m.listAttr(mesh, ud=1)
                    if attrList and [ a for a in attrList if 'SAM_D' in a ]:
                        extra += [mesh]

        # remove duplicates
        nodes = list(set(nodes+extra))
        for shader in nodes:
            # ignore geo that shouldn't be exported
            if '|CTRLS|' in shader:
                continue
            if 'Orig' in shader[-8:]:
                continue

            # atach to nodes matching naming map
            n = m.ls(shader, dag=1, visible=1, ni=1, l=1, type='shape')
            connections = m.listConnections(n,  type="shadingEngine")
            if connections:
                cleanup = {}
                for x in connections:
                    cleanup[x] = 1
                for sg in cleanup.keys():
                    if m.objExists( shader + '.SAM_ORIGINAL_NODE' ):
                        try:
                            nodeToAttach = m.getAttr( shader + '.SAM_ORIGINAL_NODE' ).split('|')[-1]
                            # m.sets( m.ls("*"+nodeToAttach), e=True, forceElement=sg )
                            dr.addRule(nodeToAttach, sg)
                        except:
                            sys.stderr.write( "SAM WARNIG: can't attach shadingGroup %s to node %s\n" % ( sg, nodeToAttach ) )
                            # traceback.print_last()
                    else:
                        # print nodes, connections
                        # dr.addRule(n[0].split('|')[-1], sg)
                        for node in n:
                            rule = node
                            if m.objExists('%s.SAM_DINAMIC_RULE' % node):
                                rule = m.getAttr('%s.SAM_DINAMIC_RULE' % node).strip('/')
                            elif m.objExists('%s.SAM_DYNAMIC_RULE' % node):
                                rule = m.getAttr('%s.SAM_DYNAMIC_RULE' % node).strip('/')
                            elif m.objExists('%s.SAM_DR' % node):
                                rule = m.getAttr('%s.SAM_DR' % node).strip('/')
                            if rule.strip():
                                dr.addRule( maya.node2rule( rule ), sg, node )
        dr.toScene()
        # pb.close()


    @staticmethod
    def _attachShaders(lazyRefresh=False):
        '''
            Very important method - it basically automatically attach shaders to geometry
            It also create prman dinamic rules, so prman attach shaders to geo, even if that geo is
            in an alembic or in a procedual of any kind (golaem, cortex, etc)
        '''
        if m:
            # if lazyRefresh:
            #     dr = maya.prmanDinamicRules()
            #     dr.fromScene()
            #     if not dr.isEmpty():
            #         return

            maya.applyCustomRules()
            nodes = m.ls("SAM_SHADER_*", type='transform')
            maya.createDinamicRules(nodes)



    @staticmethod
    def _cleanUnusedShadingNodes(force=False):
        ''' delete unused nodes in the scene '''
        if m:
            if m.ls("|SAM_shaders_*",l=1) or force:
                nonDeletable = ['initialParticleSE', 'initialShadingGroup']
                nonDeletableTypes = ['fluidShape']
                usedBy = ['fluidShape', 'shape', '']

                sg = m.ls(type='shadingEngine')
                mat = m.ls(materials=1) #+m.ls(type='PxrLMLayer')+m.ls(type='PxrTexture')

                pb = progressBar(len(sg+mat)+1, 'Cleaning up unused shading nodes...')


                for each in sg:
                    pb.step()
                    if m.objExists(each):
                        inUse  = 1 if m.listConnections( each, type='fluidShape' ) else 0
                        inUse += 1 if m.listConnections( each, type='shape' ) else 0
                        inUse += 1 if m.listConnections( each, p=1, type='OpenVDBVisualize' ) else 0
                        inUse += 1 if m.listConnections( each, type='ieProceduralHolder' ) else 0

                        # print each, notInUse

                        if each not in nonDeletable and m.nodeType(each) not in nonDeletableTypes and not inUse:
                            m.delete(each)

                for each in mat:
                    pb.step()
                    if m.objExists(each):
                        if each not in nonDeletable and not m.listConnections( each, type='shadingEngine'):
                            m.delete(each)

                # run maya mel script which delete unused shading nodes
                # try:
                #     meval('MLdeleteUnused')
                # except:
                #     pass

                pb.close()

    @staticmethod
    def cleanUnusedShadingNodes(force=False):
        if force:
            def __cleanUnusedShadingNodesForce():
                maya._cleanUnusedShadingNodes(True)
                assetUtils.mayaLazyScriptJob( runOnce=True,  idleEvent=__cleanUnusedShadingNodesForce )
        else:
            assetUtils.mayaLazyScriptJob( runOnce=True,  idleEvent=maya._cleanUnusedShadingNodes )

    @staticmethod
    def cleanNodes(nodes, msg='Cleaning up nodes...'):
        ''' delete  nodes in the scene '''
        if nodes:
            pb = progressBar(len(nodes), msg)

            for each in nodes:
                pb.step()
                if m.objExists(each):
                    try:
                        m.delete(each)
                    except:
                        pass

            pb.close()



    @staticmethod
    def setFileTexture( node, fileText ):
        ''' set the file texture string from any texture node type '''
        backup = []
        if m.objExists('%s.fileTextureName' % node):
            backup += ["m.setAttr('%s.fileTextureName', '%s', type='string')" % ( node, m.getAttr('%s.fileTextureName' % node) )]
            m.setAttr('%s.fileTextureName' % node, fileText, type='string')
        if m.objExists('%s.filename' % node):
            backup = ["m.setAttr('%s.filename', '%s', type='string')" % ( node, m.getAttr('%s.filename' % node) )]
            m.setAttr('%s.filename' % node, fileText, type='string')
        if m.objExists('%s.file' % node):
            backup = ["m.setAttr('%s.file', '%s', type='string')" % ( node, m.getAttr('%s.file' % node) )]
            m.setAttr('%s.file' % node, fileText, type='string')

        if not m.objExists('%s.SAM_BACKUP_TEXTURE' % node):
            m.addAttr( node, ln="SAM_BACKUP_TEXTURE", dt="string" )
        m.setAttr( node + '.SAM_BACKUP_TEXTURE', ';'.join(backup), type="string"  )


    @staticmethod
    def undoSetFileTexture( node ):
        if m.objExists('%s.SAM_BACKUP_TEXTURE' % node):
            eval( m.getAttr('%s.SAM_BACKUP_TEXTURE' % node) )


    @staticmethod
    def getFileTexture( node ):
        ''' get the file texture string from any texture node type '''
        textureNode = None
        if m.objExists('%s.fileTextureName' % node):
            textureNode = m.getAttr('%s.fileTextureName' % node)
        if m.objExists('%s.filename' % node):
            textureNode = m.getAttr('%s.filename' % node)
        if m.objExists('%s.file' % node):
            textureNode = m.getAttr('%s.file' % node)
        return str(textureNode)


    @staticmethod
    def getShadingMap( nodeList = [] ):
        '''
            Generate a shading map of the nodes specified in nodeList.
            It returns 4 dicts:
                shadingMap - node name/shading group/(surface/displacement)
                shadingGroups - shading group/(surface/displacement)
                shadingNodes - surface/[file texture nodes]
                displacementNodes - displacement/[file texture nodes]
        '''
        shadingMap = {}
        shadingGroups = {}
        shadingNodes = {}
        displacementNodes = {}

        # loop over all meshs and gather shading mapping!
        for shape in m.ls( nodeList, dag=1, visible=1, ni=1, type='shape' ) :
            sgs = m.listConnections(shape,  type="shadingEngine")
            if not sgs:
                print "Node %s doesnt have a shading group!" % shape
            elif 'initialShadingGroup' in sgs:
                pass
            else:
                shadingMap[shape] = {}
                for sg in sgs:
                    if sg not in shadingMap[shape]:
                        shadingMap[shape][sg] = {}
                    surface = m.listConnections( '%s.surfaceShader' % sg, d=False, s=True )
                    displacement = m.listConnections( '%s.displacementShader' % sg, d=False, s=True )  #m.getAttr( '%s.displacementShader' % sg )
                    shadingMap[shape][sg]['surface'] = surface
                    shadingMap[shape][sg]['displacement'] = displacement

                    shadingGroups[sg] = shadingMap[shape][sg]
                    if surface:
                        for s in surface:
                            shadingNodes[s] = ''
                    if displacement:
                        for s in displacement:
                            displacementNodes[s] = ''

        def findAllNodes(node, nodeTypes=['file','PxrTexture','PxrNormalMap','rmanImageFile','rmanTexture3d', 'PxrProjectionLayer']):
            '''# recursively find all texture nodes!'''
            import pymel.core as pm
            __files={}
            for ntype in nodeTypes:
                for node in pm.listHistory(node, type=ntype):
                    each = node.nodeName()
                    __files[each] = maya.getFileTexture(each)
            return __files

        # and store then in each shading node
        textures = {}
        for s in displacementNodes:
            shadingNodes[s] = findAllNodes(s)
            textures.update( shadingNodes[s] )

        # do the same for displcement textures
        for s in shadingNodes:
            shadingNodes[s] = findAllNodes(s)
            textures.update( shadingNodes[s] )

        # store texture dependency
        # for node in textures:
        #     textures[node] = maya.getFileTexture(node)

        # if not os.path.exists(textures[node]):
        #     raise Exception("Can't find texture %s used in node %s!!" % (textures[node], node))


        return shadingMap, shadingGroups, shadingNodes, displacementNodes, textures


    def _extraFiles( self ):
        if 'extraFiles' not in self.data:
            self.data['extraFiles'] = []
        for node in self.data['meshPrimitives']:
            for n in m.ls(node, dag=1):
                for attr in [ (n+'.'+a, str(m.getAttr(n+'.'+a)).strip()) for a in  m.listAttr(n, w=1, se=1, usedAsFilename=1) if m.getAttr(n+'.'+a) ]:
                    if attr[1]:
                        self.data['extraFiles'] += [attr[1]]
                        m.setAttr( attr[0],  "%s/%s" % ( self.data['publishPath'], os.path.basename( attr[1] ) ), type='string' )

    def doPublishMayaExport(self, fileName, operands):
        '''
        This function is called by doPublishMaya() after the basic generic export setup has being done.
        In a simple geometry publish, this function only selects the geometry and file->export it!
        '''
        if not self.__mayaScenePublishType:
            mayaExt = os.path.splitext( operands['%sDependency' % self.prefix].value )[-1].lower()
        else:
            mayaExt = ".%s" % self.__mayaScenePublishType

        # print mayaExt, fileName
        m.select(self.data['meshPrimitives'])

        # print ("mayaBinary" if mayaExt=='.mb'else 'mayaAscii')
        m.file(fileName, force=1, pr=1, es=1, typ=("mayaBinary" if mayaExt=='.mb'else 'mayaAscii'))

    def doPublishMaya(self, operands):
        ''' called by SAM when exporintg an asset in maya '''
        if m:
            if not self.__mayaScenePublishType:
                mayaExt = os.path.splitext( operands['%sDependency' % self.prefix].value )[-1].lower()
            else:
                mayaExt = ".%s" % self.__mayaScenePublishType

            self.data['assetPath'] = "%s/data/%%s" % m.workspace(q=1, rd=1) + mayaExt
            self.data['multipleFiles'] = ['asset']

            self._extraFiles()

            for each in self.data['multipleFiles']:
                scene = self.data['assetPath'] % each

                self.doPublishMayaExport(scene, operands)

            m.file(s=1)

            return True
        return False


    def doImportMaya( self, filename, nodeName ):
        # maya import code!
        if m:
            old_groups = m.ls('|*', type='transform')
            m.file(filename, i=1, gr=1 )
            for groups in [ g for g in m.ls('|*', type='transform') if g not in old_groups ]:
                if m.objExists(groups):
                    newNodeName = m.rename( groups, nodeName)
                    # m.lockNode(newNodeName, l=1)

            maya.attachShaders()
            # assetUtils.mayaLazyScriptJob( runOnce=True,  idleEvent=maya.attachShaders )

            return True
        return False







class alembic(  _genericAssetClass ) :
    _whoCanImport = ['gaffer','maya', 'houdini']
    _whoCanPublish = ['gaffer','houdini','maya']
    _whoCanOpen = ['gaffer','houdini','maya']

    def __init__( self, prefix, animation=True, nameGroup='Group', nameDependency='Dependency' ) :
        _genericAssetClass.__init__( self, prefix, animation, nameGroup, nameDependency )
        self.meshOnly()
        self.setSubDivMeshesMask(None)
        self.__setImportAsGPU = False

    @staticmethod
    def fixRIGMeshCTRLS(grp='|CTRLS|'):
        _genericAssetClass.fixRIGMeshCTRLS(grp)
        # we delete whatever is in the RibControl group, since alembic doesn't need it!
        if m:
            for n in [ x for x in m.ls(dag=1,long=1,type='mesh')  if grp in x ]:
                m.delete(n)

    def meshOnly(self):
        # publish renderable geo only, with UV map
        self.setAbcExtra( '-renderableOnly -uvWrite -writeUVSets' )
        self.__anyNode = False

    def anyNode(self):
        # publish cameras
        self.setAbcExtra( '' )
        self.__anyNode = True

    def setAbcExtra(self, extra):
        self.extra = extra

    def publishFile(self, publishFile, parameters):
        path = os.path.dirname(publishFile)
        name = os.path.splitext(os.path.basename(publishFile))[0]
        file = "%s/%s.%%s.abc" % (path, name)
        return file

    @staticmethod
    def shaveRibExport( frame=1, outRIB = '/tmp/shave.%04d.rib', selection=[] ):
        ''' per frame callback to export shave as cob files'''
        import time
        # if we don't have shave loaded, don't do anything!
        if 'shaveHair' not in m.ls(nodeTypes=1):
            return
        conection = {}
        selectedShave  = m.ls(selection,dag=1,type='shaveHair')
        selectedShave += list(set(m.listConnections(m.ls(selection, dag=1, type='mesh'), type='shaveHair', sh=1)))
        selectedShave  = list(set(selectedShave))
        # selectedShave = [ str(x) for x in selectedShave ]
        globals()['self'].pb.step()
        print '*'*200
        print 'Shave exporting', selectedShave
        print '*'*200
        if not m.pluginInfo('shaveCortexWriter', q=1, l=1):
            m.loadPlugin('shaveCortexWriter')

        for each in m.ls(dag=1,type='shaveHair'):
            if m.getAttr( each + '.active', l=1 ):
                m.setAttr( each + '.active', l=0 )
            conection[each] = m.listConnections( "%s.active" % each , p=1, c=1 )
            if conection[each]:
                m.disconnectAttr(conection[each][1],conection[each][0])
            else:
                del conection[each]
            print '='*200
            print each + '.active', each in selectedShave
            print '='*200
            m.setAttr( each + '.active', each in selectedShave )

            # export all extra attributes in the shavenode, if any exists!
            if each in selectedShave:
                if 'shave' not in globals()['self'].data:
                    globals()['self'].data['shave'] = {}

                cobIndex = each.replace('|','')
                if cobIndex not in globals()['self'].data:
                    globals()['self'].data['shave'][cobIndex] = {}

                listAttrs = m.listAttr(each, ud=1)
                if listAttrs:
                    for attr in listAttrs:
                        if 'SAM_' in attr:
                            globals()['self'].data['shave'][cobIndex][attr.replace('SAM_','')] = m.getAttr("%s.%s" % (each, attr))

        for each in selectedShave:
            each = str(each)
            outCOB = os.path.splitext( os.path.abspath(outRIB % frame) )[0]
            outCOBPrefix = '%s.%s' % ( os.path.splitext(outCOB)[0], each.replace('|','') )
            outCOB = "%s%s.cob" % ( outCOBPrefix, os.path.splitext(outCOB)[1] )
            # outDRA = outRIB.replace('.rib', '.dra')
            tmpRIB = '%s.cob' % tempfile.mkstemp()[1]
            t=time.time()
            #meval('shaveWriteRib("%s")' % tmpRIB )
            # if os.path.exists(tmpRIB):
            #     t=time.time()
            #     f = open(outRIB, 'w')
            #     removeHeader = True
            #     for line in open(tmpRIB, 'r').readlines():
            #         if removeHeader and 'TransformBegin' not in line:
            #             continue
            #         removeHeader = False
            #         f.write(line)
            #     print 'filtered rib in %d seconds...' % (time.time()-t)
            #     f.close()
            print outCOB
            meval('shaveCortexWriter -e "%s" "%s"' % (outCOB, each) )
            print pipe.bcolors.bcolors.GREEN+'shave rib gen took %d seconds to export...' % (time.time()-t) +pipe.bcolors.bcolors.END

            if os.path.exists(outCOB):
                if 'extraFiles' not in globals()['self'].data:
                    globals()['self'].data['extraFiles'] = []
                globals()['self'].data['extraFiles'] += [outCOB]

                if 'extraFilesDelete' not in globals()['self'].data:
                    globals()['self'].data['extraFilesDelete'] = []
                globals()['self'].data['extraFilesDelete'] += [outCOB]

            for each in conection:
                m.setAttr( each + '.active', 0 )
                try:
                    m.connectAttr(conection[each][1],conection[each][0])
                except:
                    print pipe.bcolors.bcolors.WARNING, 'WARNING (SAM SHAVE EXPORT): Cant restore connection from %s to %s!' % (conection[each][1],conection[each][0]), pipe.bcolors.bcolors.END

        print '*'*200


    @staticmethod
    def _perFrameCallback(frame, outRIB, selection, tmpfile=None):
        ''' wrapper function just to take care of passing data back to asset '''
        data = alembic.perFrameCallback(frame, outRIB, selection)

        # write the collected data to tempfile
        if tmpfile:
            f = open(tmpfile,'a')
            f.write( "%d %s\n" % (frame, str(data)) )
            f.close()

    @staticmethod
    def perFrameCallback(frame, outRIB, selection):
        ''' a frame callback function to execute extra exporting
        during alembic export '''
        data = {}

        # xgen ribarchive!
        data['shave'] = alembic.shaveRibExport( frame, outRIB, selection )

        # xgen export!
        data['xgen'] = samXgen.xgen_export_for_ribbox( selection, frame )

        data['extraFiles'] = [ x[0] for x in data['xgen'] ]

        return data
        # Special callback information:
        # On the callbacks, special tokens are replaced with other data, these tokens
        # and what they are replaced with are as follows:
        #
        # #FRAME# replaced with the frame number being evaluated.
        # #FRAME# is ignored in the post callbacks.
        #
        # #BOUNDS# replaced with a string holding bounding box values in minX minY minZ
        # maxX maxY maxZ space seperated order.
        #
        # #BOUNDSARRAY# replaced with the bounding box values as above, but in
        # array form.
        # In Mel: {minX, minY, minZ, maxX, maxY, maxZ}
        # In Python: [minX, minY, minZ, maxX, maxY, maxZ]

    @viewportOff
    def AbcExport(self, mfile, start, end, sl, extra='-renderableOnly -uvWrite -writeUVSets', shaveTmp='/tmp/shave.%04d.cob'):
        if m:
            import tempfile
            m.select( sl )
            slall = m.ls(sl=1,dag=1)
            cleanup = []

            # shave = [ x for x in slall  if m.nodeType(x)=='shaveHair']
            # for s in shave:
            #     m.select(s)
            #     try:
            #         maya.cleanNodes(
            #             [x for x in m.listRelatives(m.listRelatives(s,p=1)[0],c=1) if 'Mesh' in x] +
            #             m.ls("shaveHairMesh*")
            #         )
            #     except:
            #         pass
            #     m.shaveCreatePolysFromHairs()
            #     for n in m.ls("shaveHairMeshShape*", dag=1):
            #         cleanup.append(
            #             m.rename(m.listRelatives(n,p=1)[0], m.listRelatives(s,p=1)[0]+"Mesh")
            #         )
            #         m.parent(
            #             cleanup[-1],
            #             m.listRelatives(s,p=1)[0]
            #         )

            attributesToExport = [
                'rman__torattr___subdivScheme',
                'rman__torattr___subdivFacevaryingInterp',
                'castsShadows',
                'receiveShadows',
                'holdOut',
                'motionBlur',
                'primaryVisibility',
                'smoothShading',
                'visibleInReflections',
                'visibleInRefractions',
                'doubleSided',
                'opposite',
            ]


            curves = m.ls( sl, dag=1, ni=1, type='nurbsCurve' )
            meshes = m.ls( sl, dag=1, visible=1, ni=1, type='mesh' )
            # print "BUMM",sl, len(curves), len(meshes)
            if curves and not meshes:
                extra = ''
            else:
                if not self.__anyNode:
                    meshes = m.ls( sl, dag=1, visible=1, ni=1, type='mesh' )
                    # convert rman attributos to a cleaner version
                    attrs = [ a for a in attributesToExport if 'rman__torattr___' in a ]
                    pb = progressBar(len(attrs)*len(meshes)+1, 'setting up geometry for export...')
                    pb.step()
                    for attr in attrs:
                        pb.step()
                        for n in meshes:
                            pb.step()
                            if m.objExists( '%s.%s' % (n, attr) ):
                                cleanAttr = attr.replace('rman__torattr___','')
                                if not m.objExists( '%s.%s' % (n, cleanAttr) ):
                                    m.addAttr( n, ln=cleanAttr, at="long" )
                                m.setAttr( '%s.%s' % (n, cleanAttr), m.getAttr( '%s.%s' % (n, attr) ) )
                                attributesToExport.append(cleanAttr)

                    pb.close()

                    m.select( meshes )
                else:
                    m.select( m.ls( sl, dag=1) )

                if attributesToExport:
                    extra += ' -attr '+' -attr '.join(attributesToExport)

                extra += ' -noNormals  -sl '


            className = str(self.__class__).split('.')[-1]
            root = ' '.join([ '-root '+x for x in sl ])

            # create a temp file so frameCallback can generate data to input
            # into asset data file. The temp file will contain a str(dict) so
            # we can just read it and eval() the content of the file.
            ftmp = tempfile.mkstemp()
            os.close( ftmp[0] )
            ftmp = ftmp[1]

            abcJob = "%s %s  -step %s -wv -fr %s %s %s -file %s" % (
                extra,
                '''-pythonPerFrameCallback "import genericAsset;reload(genericAsset);genericAsset.alembic._perFrameCallback(#FRAME#, '%s', %s, '%s' )"''' % (shaveTmp,sl,ftmp),
                1.0,
                start,
                end,
                root,
                mfile,
            )
            # print "m.AbcExport( j=abcJob) : ", abcJob ; sys.stdout.flush()
            m.AbcExport( j=abcJob)

            # retrieve temp file data and pipe into asset data file.
            if 'frameCallback' not in self.data:
                self.data['frameCallback'] = {}
            if 'extraFiles' not in self.data:
                self.data['extraFiles'] = []

            f = open(ftmp,'r')
            for line in f.readlines():
                # for each line, theres a frame, and the dict for that frame!
                l = line.split(' ')
                frame = int(l[0])
                data = eval(' '.join(l[1:]))
                # store it in the asset data
                self.data['frameCallback'][frame] = data
                self.data['extraFiles'] += data['extraFiles']

            f.close()
            os.remove(ftmp)

            # finishing touch!
            maya.cleanNodes(cleanup)

    def doPublishMaya( self, operands ):
        if m:
            globals()['self']  = self
            frameRange   = operands['FrameRange']['range'].value
            self.data['assetPath'] = "%s%%s.abc"  % tempfile.mkstemp()[1]
            self.data['multipleFiles'] = [ 'asset' ]
            self.pb = progressBar(3 + (int(frameRange[1])-int(frameRange[0])), 'Publishing alebic geometry...')
            self.pb.step()

            shaveTmp = '%s/data/shave.%%04d.cob'  % m.workspace(q=1, rd=1)

            os.system('mkdir -p /usr/tmp/%s_cob/' % os.environ['USER'])
            shaveTmp = '/usr/tmp/%s_cob/shave.%%04d.cob'  % os.environ['USER']

            self.data['assetPath'] = "%s/data/%%s.abc" % m.workspace(q=1, rd=1)
            self.AbcExport(
                self.data['assetPath'] % self.data['multipleFiles'][0],
                int(frameRange[0]),
                int(frameRange[1]),
                self.data['meshPrimitives'],
                extra=self.extra,
                shaveTmp=shaveTmp,
            )
            self.pb.step()

            # publish ribs with alembic, if any!
            # if 'extraFiles' not in self.data:
            #     self.data['extraFiles'] = []
            # self.data['extraFiles'] += [ shaveTmp % x for x in range(int(frameRange[0]),int(frameRange[2])) if os.path.path.exists(shaveTmp % x) ]
            #
            # # cleanup ribs after publishing
            # if 'extraFilesDelete' not in self.data:
            #     self.data['extraFilesDelete'] = []
            # self.data['extraFilesDelete'] += [ shaveTmp % x for x in range(int(frameRange[0]),int(frameRange[2])) if os.path.path.exists(shaveTmp % x) ]

            # for n in range(len(self.data['multipleFiles'])):
            #     m.AbcExport( j="%s -step %s -frs 0.3 -frs 0.60 -wv -fr %s %s -root %s -file %s" % (
            #         '-pythonPerFrameCallback %s.perFrameCallback()' % className,
            #         str(self.frameRange.z),
            #         str(self.frameRange.y),
            #         str(self.frameRange.x),
            #         self.data['meshPrimitives'][n],
            #         self.data['assetPath'] % self.data['multipleFiles'][n],
            #     ))


            m.file(s=1)
            self.pb.close()

            return True
        return False


    def setSubDivMeshesMask(self, mask):
        self.__subDivMeshesMask = mask

    def setImportAsGPU(self, b):
        self.__setImportAsGPU = b

    @staticmethod
    def fixDefaultUVSet( nodeMasks = [ "|SAM_model_*", "|SAM_animation_*" ] ):
        nodesWithNoUV = []
        nodes = m.ls(nodeMasks, dag=1, type="mesh")
        pb = progressBar(len(nodes)+1, 'Fixing default UV set...')

        for each in nodes:
            pb.step()
            uvsets = m.polyUVSet( each, query=True, allUVSets=True )
            if not uvsets:
                continue
            m.polyUVSet( each, currentUVSet=1, uvSet=uvsets[0] )
            if '[0:1]' not in m.ls(  "%s.map[0:1]" % each )[0]:
                if len(uvsets)>1:
                    # print each, uvsets
                    m.polyUVSet( each, currentUVSet=1, uvSet=uvsets[1] )
                    if '[0:1]' in m.ls(  "%s.map[0:1]" % each )[0]:
                        m.polyUVSet( each, currentUVSet=1, uvSet=uvsets[0] )
                        m.polyUVSet( each, copy=True, nuv=uvsets[0], uvSet=uvsets[1] )
                    else:
                        nodesWithNoUV += ["Node %s have NO UV in any of the %s uvsets" % (each, ' '.join(uvsets))]
                else:
                    nodesWithNoUV += ["Node %s have NO UV in %s uvset" % (each, ' '.join(uvsets))]

        if nodesWithNoUV:
            print '='*80
            for line in nodesWithNoUV:
                print line
            print '='*80
        pb.close()


    def doImportMaya(self, filename, nodeName, gpucache=False ):
        if m:
            print self.__setImportAsGPU
            print gpucache
            node = alembic.importAlembic( filename, nodeName, self.__setImportAsGPU or gpucache, self.data )

            if 'shadingMap' in self.data:
                m.addAttr( node, ln="SAM_SHADINGMAP", dt="string" )
                m.setAttr( node + '.SAM_SHADINGMAP', str(self.data['shadingMap']), type="string"  )

            def idleSetup():
                if self.__subDivMeshesMask:
                    nodes = m.ls(node+self.__subDivMeshesMask,  dag=1, visible=1, ni=1, type='mesh' )
                    pb = progressBar(len(nodes)+1, 'Updating subdiv prman attributes...')
                    for n in nodes:
                        pb.step()
                        if not m.objExists(n + '.rman__torattr___subdivScheme'):
                            m.addAttr( n, ln="rman__torattr___subdivScheme", at="long" )
                        m.setAttr( n + '.rman__torattr___subdivScheme', 0 )

                        if not m.objExists(n + '.rman__torattr___subdivFacevaryingInterp'):
                            m.addAttr( n, ln="rman__torattr___subdivFacevaryingInterp", at="long" )
                        m.setAttr( n + '.rman__torattr___subdivFacevaryingInterp', 3 )
                    pb.close()
                else:
                    nodes = m.ls(node,  dag=1, visible=1, ni=1, type='mesh' )
                    pb = progressBar(len(nodes)+1, 'Updating subdiv prman attributes...')
                    for n in nodes:
                        if m.objExists( '%s.subdivScheme' % n ):
                            if not m.objExists(n + '.rman__torattr___subdivScheme'):
                                m.addAttr( n, ln="rman__torattr___subdivScheme", at="long" )
                            m.setAttr( n + '.rman__torattr___subdivScheme', m.getAttr( '%s.subdivScheme' % n ) )

                        if m.objExists( '%s.subdivFacevaryingInterp' % n ):
                            if not m.objExists(n + '.rman__torattr___subdivFacevaryingInterp'):
                                m.addAttr( n, ln="rman__torattr___subdivFacevaryingInterp", at="long" )
                            m.setAttr( n + '.rman__torattr___subdivFacevaryingInterp',  m.getAttr( '%s.subdivFacevaryingInterp' % n )  )


            # m.scriptJob( runOnce=True,  idleEvent=idleSetup )
            maya.attachShadersLazy()
            alembic.fixDefaultUVSet()
            # assetUtils.mayaLazyScriptJob( runOnce=True,  idleEvent=alembic.fixDefaultUVSet() )

            idleSetup()
            return True

        return False


    @staticmethod
    def importAlembic(filename, nodeName, gpuCache=False, data=None):
        if m:
            if not gpuCache:
                node = m.createNode( "transform", n=nodeName)
                m.AbcImport( filename, rpr=node )
                if data:
                    # gather all shave caches in this asset, if any!
                    cobs = {}
                    for each in data['extraFiles']:
                        if 'shave.' in each:
                            nodeName = '.'.join( each.split('.')[:-2] )
                            if nodeName not in cobs:
                                cobs[ nodeName ] = []
                            cobs[ nodeName ] += [each]

                    for shave in cobs:
                        import IECore, IECoreMaya
                        # c = IECore.ClassLoader.defaultLoader( "IECORE_PROCEDURAL_PATHS" )
                        # c.refresh()
                        # shaveNode = m.createNode( "ieProceduralHolder" )
                        # fnPH = IECoreMaya.FnProceduralHolder( shaveNode )
                        # fnPH.setParameterised( c.load('shave')(), 1 )
                        fnPH = IECoreMaya.FnProceduralHolder.create( "__shave__", "shave" )
                        fileAttr = fnPH.parameterPlugPath( fnPH.getProcedural()["path"] )
                        shaveNode = fnPH.name()
                        transform = m.listRelatives(shaveNode,p=1)[0]

                        m.select(shaveNode)
                        m.sets( e=1, forceElement='initialShadingGroup' )
                        m.select(cl=1)


                        shaveCache = os.path.splitext(os.path.splitext(cobs[shave][0])[0])[0]+'.####.cob'
                        shaveCache = '%s/%s' % (data['publishPath'], os.path.basename(shaveCache))
                        m.setAttr( fileAttr, shaveCache, type='string' )

                        m.setAttr("%s.visibleInReflections" % fnPH.name(), 1)
                        m.setAttr("%s.visibleInRefractions" % fnPH.name(), 1)

                        name = 'shaveShape'
                        count=1
                        while m.objExists('|%s|%s' % (transform, name)):
                            name = name.split('_')[0]+'_'+str(count)
                            count+=1

                        m.rename( '|%s|%s' % (transform, fnPH.name()), name)
                        transform = m.rename( transform, data['assetName']+'_shave')
                        m.parent( transform, node )

                        # set the IDPrimvarName to the shaveNode name used in the cob sequence name
                        try:
                            attrName = fnPH.parameterPlugPath( fnPH.getProcedural()["IDPrimvarName"] )
                            idpassName = shaveCache.split('/shave.')[1].split('.')[0]
                            m.setAttr( attrName, idpassName, type='string' )
                        except:
                            pass

                        # if we have attributes for this cache, apply it
                        if 'shave' in data:
                            cobIndex = shave.split('shave.')[-1].split('.')[0]
                            if cobIndex in data['shave']:
                                for attr in data['shave'][cobIndex]:
                                    try: attrPar = fnPH.parameterPlugPath( fnPH.getProcedural()[attr] )
                                    except: attrPar = None
                                    if attrPar:
                                        print data['shave'][cobIndex][attr], type(data['shave'][cobIndex][attr])
                                        if type(data['shave'][cobIndex][attr]) in [str, unicode]:
                                            m.setAttr( attrPar, data['shave'][cobIndex][attr], type="string" )
                                        else:
                                            m.setAttr( attrPar, data['shave'][cobIndex][attr] )

                    print data
                    if 'frameCallback' in data:
                        frames = data['frameCallback'].keys()
                        if 'xgen' in data['frameCallback'][frames[0]]:
                            for c in data['frameCallback'][frames[0]]['xgen']:
                                abc = filename
                                xgen_path = data['publishPath']
                                collection = c[1]
                                description = c[2]
                                patch_name = c[3]
                                samXgen.xgen_create_ribbox(collection, description, abc, patch_name, xgen_path)
                                print "11111111111111111"
                                print collection, description, patch_name
                                print "11111111111111111"



            else:
                ribNode = m.createNode('RenderManArchive')
                ribNode = m.rename( m.listRelatives(ribNode, p=1), nodeName+'_rib')
                m.rename(m.listRelatives(ribNode, c=1),ribNode+'Shape')

                gpu=m.createNode('gpuCache')
                gpu=m.rename(m.listRelatives(gpu, p=1),nodeName+'_gpu')
                m.rename(m.listRelatives(gpu, c=1),gpu+'Shape')

                m.setAttr( ribNode + '.filename', filename, type="string"  )
                m.setAttr( gpu + '.cacheFileName', filename, type="string"  )
                m.parent( ribNode, gpu )
                node = gpu

            return node



class gaffer( _genericAssetClass ):
    _whoCanImport = ['maya', 'houdini','gaffer']
    _whoCanPublish = ['gaffer']
    _whoCanOpen = ['gaffer']

    def __init__( self, prefix="bundle" ) :
        _genericAssetClass.__init__( self, prefix, animation=False )


    def doPublish(self, operands):
        ''' called by SAM when import an asset '''
        if hasattr(GafferUI, 'root'):
            self.root = GafferUI.root
            script = self.root()['scripts'][0]
            script.save()
            scene = script["fileName"].getValue()

            # self.data['assetPath'] = "%s/%%s.abc"
            self.data['assetPath'] = "%s_%%s.gfr"  % tempfile.mkstemp()[1]
            self.data['multipleFiles'] = [ 'asset' ]

            script.serialiseToFile( self.data['assetPath'] % self.data['multipleFiles'][0] )

            return True
        return False

    def doImportMaya(self, filename, nodeName ):
        import nodes
        reload(nodes)
        script = Gaffer.ScriptNode()
        script["fileName"].setValue(filename)
        script.load()
        nodes = '+'.join([ script[x]['out'].getValue() for x in script.keys() if 'mayaScene' in x])

        # replace the @app@ mask by the current app!
        nodes = nodes.replace( '@app@', hostApp() )

        if m:
            node = m.createNode( "transform", n=nodeName)
            m.addAttr( node, ln="SAM_BUNDLE", dt="string" )
            m.setAttr( node + '.SAM_BUNDLE', str(nodes), type="string"  )
            # for n in nodes:
            #     m.parent( n, node )
            znodes = eval( nodes )
            pb = progressBar(len(znodes)+1, 'Importing assets inside bundle...')
            for node in znodes:
                pb.step()
                if node['op'].path:
                    node['op'].hostApp('maya')
                    node['op'].doImport()
            pb.close()


            return True
        return True

    def childrenNodes(self, gafferNodes):
        ''' return the main node + all children nodes '''
        nodes=[]
        # print "xx", m
        if m:
            n = '+'.join([ m.getAttr( node + '.SAM_BUNDLE' ) for node in gafferNodes ])
            # print n
            if n.strip():
                for node in eval(n):
                    if node['op'].path:
                        node['op'].hostApp('maya')
                        nodes += node['op'].nodes()
        return nodes


    def cleanupOldVersions( self, nodeName ):
        ''' delete any other version! '''
        if m:
            nodes = self.doesAssetExists(nodeName)

            maya.cleanNodes( nodes+self.childrenNodes(nodes) )

            # cleanup shader leftovers
            maya.cleanUnusedShadingNodes()

            maya.cleanNodes( m.ls("SAMIMPORT*") )




    # @staticmethod
    # def onRefreshCallback( assetType, nodeNamePrefix ):
    #     '''
    #         This method is called by SAM to refresh whatever setup needs to be done
    #         when this type of asset is in the scene.
    #     '''
    #     if m:
    #         # shave doesn't like any group named shaveDisplayGroup that doesn't have a proper shave setup,
    #         # so we must remove any group named shaveDisplayGroup that don't belongs to a SAM_shave asset
    #         cleanup = [ x for x in m.ls('shaveDisplayGroup',l=1) if '|SAM_shave' not in x ]
    #         if cleanup:
    #             m.delete(cleanup)
    #
    #         genericAsset.maya.cleanUnusedShadingNodes()
    #
    #         for n in m.ls( '|%s*' % nodeNamePrefix, dag=1, l=1, type='shaveHair' ):
    #             c = m.listConnections( "%s.inputMesh" % n , p=1, c=1 )
    #             if c:
    #                 m.disconnectAttr(c[1],c[0])
    #             c=eval( m.getAttr( "%s.SAM_ORIGINAL_NODE" % n ) )
    #             if m.objExists(c[1]):
    #                 m.connectAttr(c[1],c[0])
    #
    #         m.setAttr( "defaultRenderGlobals.preRenderMel", "shave_rmanFrameStart", type="string" )
    #         m.setAttr( "renderManRISGlobals.rman__torattr___renderBeginScript", "rmanTimeStampScript;shave_rmanRenderStart", type="string" )
    #         m.setAttr( "renderManRISGlobals.rman__torattr___preRenderScript", "shave_rmanSetOptions", type="string" )
    #         m.setAttr( "renderManRISGlobals.rman__torattr___postRenderScript", "shave_rmanInjectCleanup", type="string" )
    #         m.setAttr( "renderManRISGlobals.rman__torattr___postTransformScript", "shave_rmanInsertArchive", type="string" )


# m.AbcExport( j="-step 0.25 -frs 0.3 -frs 0.60 -fr 1 5 -root foo -file test.abc")
#
#
# AbcExport  -h;
# // AbcExport [options]
# Options:
# -h / -help  Print this message.
#
# -prs / -preRollStartFrame double
# The frame to start scene evaluation at.  This is used to set the
# starting frame for time dependent translations and can be used to evaluate
# run-up that isn't actually translated.
#
# -duf / -dontSkipUnwrittenFrames
# When evaluating multiple translate jobs, the presence of this flag decides
# whether to evaluate frames between jobs when there is a gap in their frame
# ranges.
#
# -v / -verbose
# Prints the current frame that is being evaluated.
#
# -j / -jobArg string REQUIRED
# String which contains flags for writing data to a particular file.
# Multiple jobArgs can be specified.
#
# -jobArg flags:
#
# -a / -attr string
# A specific geometric attribute to write out.
# This flag may occur more than once.
#
# -df / -dataFormat string
# The data format to use to write the file.  Can be either HDF or Ogawa.
# The default is Ogawa.
#
# -atp / -attrPrefix string (default ABC_)
# Prefix filter for determining which geometric attributes to write out.
# This flag may occur more than once.
#
# -ef / -eulerFilter
# If this flag is present, apply Euler filter while sampling rotations.
#
# -f / -file string REQUIRED
# File location to write the Alembic data.
#
# -fr / -frameRange double double
# The frame range to write.
# Multiple occurrences of -frameRange are supported within a job. Each
# -frameRange defines a new frame range. -step or -frs will affect the
# current frame range only.
#
# -frs / -frameRelativeSample double
# frame relative sample that will be written out along the frame range.
# This flag may occur more than once.
#
# -nn / -noNormals
# If this flag is present normal data for Alembic poly meshes will not be
# written.
#
# -pr / -preRoll
# If this flag is present, this frame range will not be sampled.
#
# -ro / -renderableOnly
# If this flag is present non-renderable hierarchy (invisible, or templated)
# will not be written out.
#
# -rt / -root
# Maya dag path which will be parented to the root of the Alembic file.
# This flag may occur more than once.  If unspecified, it defaults to '|' which
# means the entire scene will be written out.
#
# -s / -step double (default 1.0)
# The time interval (expressed in frames) at which the frame range is sampled.
# Additional samples around each frame can be specified with -frs.
#
# -sl / -selection
# If this flag is present, write out all all selected nodes from the active
# selection list that are descendents of the roots specified with -root.
#
# -sn / -stripNamespaces (optional int)
# If this flag is present all namespaces will be stripped off of the node before
# being written to Alembic.  If an optional int is specified after the flag
# then that many namespaces will be stripped off of the node name. Be careful
# that the new stripped name does not collide with other sibling node names.
#
# Examples:
# taco:foo:bar would be written as just bar with -sn
# taco:foo:bar would be written as foo:bar with -sn 1
#
# -u / -userAttr string
# A specific user attribute to write out.  This flag may occur more than once.
#
# -uatp / -userAttrPrefix string
# Prefix filter for determining which user attributes to write out.
# This flag may occur more than once.
#
# -uv / -uvWrite
# If this flag is present, uv data for PolyMesh and SubD shapes will be written to
# the Alembic file.  Only the current uv map is used.
#
# -wcs / -writeColorSets
# Write all color sets on MFnMeshes as color 3 or color 4 indexed geometry
# parameters with face varying scope.
#
# -wfs / -writeFaceSets
# Write all Face sets on MFnMeshes.
#
# -wfg / -wholeFrameGeo
# If this flag is present data for geometry will only be written out on whole
# frames.
#
# -ws / -worldSpace
# If this flag is present, any root nodes will be stored in world space.
#
# -wv / -writeVisibility
# If this flag is present, visibility state will be stored in the Alembic
# file.  Otherwise everything written out is treated as visible.
#
# -wuvs / -writeUVSets
# Write all uv sets on MFnMeshes as vector 2 indexed geometry
# parameters with face varying scope.
#
# -mfc / -melPerFrameCallback string
# When each frame (and the static frame) is evaluated the string specified is
# evaluated as a Mel command. See below for special processing rules.
#
# -mpc / -melPostJobCallback string
# When the translation has finished the string specified is evaluated as a Mel
# command. See below for special processing rules.
#
# -pfc / -pythonPerFrameCallback string
# When each frame (and the static frame) is evaluated the string specified is
# evaluated as a python command. See below for special processing rules.
#
# -ppc / -pythonPostJobCallback string
# When the translation has finished the string specified is evaluated as a
# python command. See below for special processing rules.
#
# Special callback information:
# On the callbacks, special tokens are replaced with other data, these tokens
# and what they are replaced with are as follows:
#
# #FRAME# replaced with the frame number being evaluated.
# #FRAME# is ignored in the post callbacks.
#
# #BOUNDS# replaced with a string holding bounding box values in minX minY minZ
# maxX maxY maxZ space seperated order.
#
# #BOUNDSARRAY# replaced with the bounding box values as above, but in
# array form.
# In Mel: {minX, minY, minZ, maxX, maxY, maxZ}
# In Python: [minX, minY, minZ, maxX, maxY, maxZ]
#
# Examples:
#
# AbcExport -j "-root |group|foo -root |test|path|bar -file /tmp/test.abc"
# Writes out everything at foo and below and bar and below to /tmp/test.abc.
# foo and bar are siblings parented to the root of the Alembic scene.
#
# AbcExport -j "-frameRange 1 5 -step 0.5 -root |group|foo -file /tmp/test.abc"
# Writes out everything at foo and below to /tmp/test.abc sampling at frames:
# 1 1.5 2 2.5 3 3.5 4 4.5 5
#
# AbcExport -j "-fr 0 10 -frs -0.1 -frs 0.2 -step 5 -file /tmp/test.abc"
# Writes out everything in the scene to /tmp/test.abc sampling at frames:
# -0.1 0.2 4.9 5.2 9.9 10.2
#
# Note: The difference between your highest and lowest frameRelativeSample can
# not be greater than your step size.
#
# AbcExport -j "-step 0.25 -frs 0.3 -frs 0.60 -fr 1 5 -root foo -file test.abc"
#
# Is illegal because the highest and lowest frameRelativeSamples are 0.3 frames
# apart.
#
# AbcExport -j "-sl -root |group|foo -file /tmp/test.abc"
# Writes out all selected nodes and it's ancestor nodes including up to foo.
# foo will be parented to the root of the Alembic scene.
#
#  //
