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

# import maya.app
# maya.app.general.fileTexturePathResolver.findAllFilesForPattern("/BTRFS10TB/atomo/jobs/0704.hi_chew/assets/sala/users/iinaja/maya/sourceimages/personagem_maca/textura/corpo/Base_maca_Color_<UDIM>.png",0)

# python3 workaround for reload
from __future__ import print_function
try: from importlib import reload
except: pass

import IECore, Gaffer, GafferUI, pipe, tempfile
import Asset
from glob import glob
import os, datetime, sys, math
import assetUtils
import traceback
from functools import wraps

import nodeMD5
reload(nodeMD5)

import samXgen
reload(samXgen)

DEBUG = 'SAM_DEBUG' in os.environ

m = None
try:
    from pymel import core as pm
    import maya.cmds as m
    _m = m
    from maya.mel import eval as meval
    reload(assetUtils)
    import IECoreMaya
    # hostApp('maya')
    import maya.utils as mu
    import maya.app as ma
except:
    if m:
        print( traceback.print_exc() )

try:
    import maya.cmds as m
    _m = m
except:
    # print( traceback.print_exc() )
    m = None

if m:
    try:
        from maya.app.general import fileTexturePathResolver
        import IECoreMaya
        reload(assetUtils)
    except:
        print( traceback.print_exc() )


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
            print( "Exception in user code (from inside viewportOff(%s)):" % func )
            print( '-'*60 )
            traceback.print_exc(file=sys.stdout)
            print( '-'*60 )
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
        # print( each )

def push(nodes):
    import re
    attrPOP={}
    if m:
        for node in nodes:
            versionPosition = re.search(r'_\d\d_\d\d_\d\d', node).start()
            _node = '|%s_??_??_??_*' % ( node[:versionPosition] )
            # print(['|'.join(x.split('|')[2:]) for x in m.ls(node, dag=1, v=1,l=1) if x[1:] not in nodes],_node)
            attrPOP[_node]={}
            for each in ['|'.join(x.split('|')[2:]) for x in m.ls(node, dag=1, v=1,l=1) if x[1:] not in nodes]:
                attrPOP[_node][each]={}
                try:
                    for attr in m.listAttr('|'+'|'.join([node,each]).rstrip('|'), w=1, o=1, se=1,m=0):
                        attrPOP[_node][each][attr] = m.getAttr('|'+'|'.join([node,each]).rstrip('|')+'.'+attr)
                except: pass
    return attrPOP

def pop(attrPOP):
    if m:
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
                            if DEBUG:
                                print( "pop(attrPOP) Exception: "+str(attrName) )

def hostApp(app=None):
    return os.environ['PIPE_PARENT']
    # if '_hostApp_' not in globals():
    #     globals()['_hostApp_'] = 'gaffer'
    # if app:
    #     globals()['_hostApp_'] = app
    #
    # try:
    #     if globals()['_hostApp_']=='maya':
    #         globals()['m']=globals()['_m']
    #     else:
    #         raise
    # except:
    #     globals()['m']=None
    # # print( app, globals()['m'], globals().keys() )
    # return globals()['_hostApp_']

def _fixJobPrefix( file ):
    ret = file
    if '/sam/' in file:
        ret = pipe.admin.job().path('sam/')+file.split('/sam/')[1]
    return ret

def _nameCleanup( name ):
    ret = name
    d = {
        '/' : '_',
        '.' : '_',
        '-' : '_',
    }
    for each in d:
        ret = ret.replace(each, d[each])
    return ret

def _nodeNameTemplate(prefix=False):
    ret = "SAM_%s_%s_%02d_%02d_%02d_%s"
    if prefix:
        ret = '_'.join( ret.split('_')[:3] )+'_'
    return ret

def _nodeName(data=None):
    ret = 'SAM_none_none_none_none'
    ret =  _nodeNameTemplate() % (
        _nameCleanup(data['assetType']),
        _nameCleanup(data['assetName']),
        data['assetInfo']['version'].value.x,
        data['assetInfo']['version'].value.y,
        data['assetInfo']['version'].value.z,
        ''
    )


    try:
        ret =  _nodeNameTemplate() % (
            _nameCleanup(data['assetType']),
            _nameCleanup(data['assetName']),
            data['assetInfo']['version'].value.x,
            data['assetInfo']['version'].value.y,
            data['assetInfo']['version'].value.z,
            ''
        )
    except:
        pass
    return ret

# @viewportOff
def updateCurrentLoadedAssets(forceRefresh=False):
    # if forceRefresh or '_updateCurrentLoadedAssets__' not in globals():
    #     globals()['_updateCurrentLoadedAssets__'] = {}
    # _updateCurrentLoadedAssets__ = globals()['_updateCurrentLoadedAssets__']

    # make sure evaluation mode is set to DG, or else
    if m:
        if 'off' not in ''.join(m.evaluationManager( q=1, mode=1 )):
            m.evaluationManager( mode="off" )

        maya.shaveCleanup()
        maya.applyCustomRules()

        # fix alembicNode starting on negative frames, since it can break rendering in the farm!
        if m:
            for each in pm.ls(type="AlembicNode"):
                start = float(each.getAttr('startFrame'))
                # print( start )
                if start < 0:
                    if not each.hasAttr('originalStart'):
                        # print( each.name() )
                        each.addAttr('originalStart', at='double')
                    each.setAttr('originalStart', start)
                    each.setAttr('startFrame', 0)



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
            # print( op, hasattr(op.op, 'typeOP'), hasattr(op.op.typeOP, 'onRefreshCallback'), nodeNamePrefix )
            if hasattr(op.op, 'typeOP') and hasattr(op.op.typeOP, 'onRefreshCallback'):
                canRefresh = True
                if m and not m.ls('|%s*_??_??_??_*' % nodeNamePrefix):
                    canRefresh = False

                if canRefresh:
                    # print( 'SAM REFRESH =>',t, nodeNamePrefix )
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
            if m:
                mu.processIdleEvents()
    def close(self):
        if self.w:
            del self.w

class _genericAssetClass( IECore.Op ) :
    _whoCanImport = ["gaffer"]
    _whoCanPublish = ["gaffer"]
    _whoCanOpen = ["gaffer"]
    _importAsReference = None

    def hostApp(self, app=None):
        if app:
            hostApp(app)
        # print( '_genericAssetClass:', hostApp() )
        return hostApp()

    def __init__( self, prefix, animation=True, nameGroup='Group', nameDependency='Dependency', mayaNodeTypes='transform' ) :

        disabled={"UI":{ "invertEnabled" : IECore.BoolData(True) }}

        # print( '_genericAssetClass:',hostApp() )

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
                            "defaultPath": IECore.StringData( pipe.roots().jobs() ),
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
                    defaultValue = self.animation,
                    userData = { "UI": {
                        "collapsed" : IECore.BoolData(False),
                        "visible" : IECore.BoolData(animation),
                    }},
                ),
                IECore.CompoundParameter("FrameRange","",[
                    IECore.V3fParameter("range","Inicio, fim e 'step' da sequencia a ser rendida.",IECore.V3f(0, 10, 1), userData=disabled),
                ],userData = { "UI": {
                    "collapsed" : IECore.BoolData(False),
                    "visible" : IECore.BoolData(self.animation),
                }}),
        ])

        self.canPublish = True
        # if hasattr(self, 'updateFromHost'):
        self.updateFromHost()

    def updateFromHost(self):
        '''update UI from host data'''
        self._host = []
        # print( 'updateFromHost:',hostApp() )
        if hostApp()=='maya':
            self._host += ["maya"]
        if  m:
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

        # elif hostApp()=='gaffer' and hasattr(GafferUI, 'root'):
        #     self.root = GafferUI.root
        #     scene = self.root()['scripts'][0]["fileName"].getValue()
        #
        #     self.parameters()["%s%s" % (self.prefix, self.nameDependency)].setValue(  IECore.StringData(scene) )


    def parameterChanged(self, parameter):
        '''validate UI parameters'''
        if hasattr( parameter, 'parameterChanged' ):
            parameter.parameterChanged( parameter )

        if parameter.name == 'enableAnimation':
            # print( dir(parameter) )
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
        _genericAssetClass.removeNamespaces()
        #     for each in { ':%s' % ':'.join(x.split(':')[:-1]) : x.split(':')[-1] for x in  m.ls("*:*")}:
        #         # print( each )
        #         m.namespace( removeNamespace = each, mergeNamespaceWithRoot = True)


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
            if not m.about(batch=1):
                import pipe
                import maya.OpenMaya as api
                import maya.OpenMayaUI as apiUI
                data['extraFiles'] += [ '%s/data/preview.jpg' % m.workspace(q=1, rd=1) ]

                sl = m.ls(sl=1)
                m.select(cl=1)

                #Grab the last active 3d viewport
                view = apiUI.M3dView.active3dView()

                # disable highlight selection
                state = m.displayPref(q=True, wsa=True)
                m.displayPref(wsa="none")

                #read the color buffer from the view, and save the MImage to disk
                image = api.MImage()
                view.readColorBuffer(image, True)
                image.writeToFile("/dev/shm/maya-preview.png", 'png')
                os.system( "%s /dev/shm/maya-preview.png %s" % ( pipe.libs.cgru().path("bin/convert"), data['extraFiles'][-1] ) )
                m.select(sl)

                m.displayPref(wsa=state)

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
        ''' returns a padronized filename for the publish file'''
        path = os.path.dirname(publishFile)
        name = os.path.splitext(os.path.basename(publishFile))[0]
        file = "%s/%s.%%s%s" % (path, name, os.path.splitext(parameters['Asset']['type']['%sDependency' % self.prefix].value)[-1])
        return file


    @staticmethod
    def cleanupOldVersions( self, nodeName ):
        ''' virtual function to delete any other version - called before importing/update an asset '''
        return

    def doesAssetExists( self, nodeName, anyVersion=True, allOtherVersionsOnly=False):
        ''' find the asset in the scene, no matter what version it is! '''
        nodes=[]
        if m:
            nodeName = nodeName.replace('-','_')
            if anyVersion or allOtherVersionsOnly:
                import re
                versionPosition = re.search(r'_\d\d_\d\d_\d\d', nodeName).start()
                mask = '|%s_??_??_??_*' % ( nodeName[:versionPosition] )
                # print( mask, m.ls(mask) )
                nodes += m.ls(mask)

                for level in range(2):
                    # check for n levels as weel.
                    # animation/maya are maya scenes with referenced maya/rig, so
                    # we can trigger version check and updating of the rig in an
                    # animation asset
                    mask = '|*' + mask
                    nodes += m.ls(mask)

                # check for assets imported as references inside
                # a imported asset
                mask = '|*|*:%s_??_??_??_*' % ( nodeName[:versionPosition] )
                # print(mask)
                nodes += m.ls(mask)
            else:
                nodes = m.ls('|' + nodeName + '*')

        if allOtherVersionsOnly:
            nodes = [ x for x in nodes if nodeName not in x ]
        return nodes

    # def doesAssetSourceExists( self, nodeName, anyVersion=True):
    #     ''' find the asset in the scene, no matter what version it is! '''
    #     nodes=[]
    #     if m:
    #         self.__data()
    #         if self.hostApp()=='maya' and m:
    #             if len(self.pathPar.split('/'))>2 and self.data:
    #                 if 'meshPrimitives' in self.data:
    #                     selection = m.ls(self.data['mayaNodesLsMask'], l=1)
    #
    #                     if 'renderSettings/maya' in self.pathPar:
    #                         return selection
    #
    #                     return selection # if self.data['mayaNodesLsMask']==selection else []
    #                 if  'render/' in self.data['assetType']:
    #                     if m.objExists( 'defaultRenderGlobals.pipe_asset_name' ):
    #                         assetName = m.getAttr( 'defaultRenderGlobals.pipe_asset_name' )
    #                         if '%s/%s/' % (self.data['assetType'], assetName) in self.pathPar:
    #                             return [assetName]
    #     return nodes


    def getAssetDataHistory(self, parameters):
        ''' get data from asset based on some history in the host app, if any'''
        meshs = [ x.strip() for x in str(parameters['Asset']['type']['%s%s' % (self.prefix,  self.nameGroup)].value).split(',') ]
        if meshs:
            for mesh in meshs:
                if m:
                    if m.objExists( '%s.pipe_asset' % mesh ):
                        return parameters.getAssetData(m.getAttr( '%s.pipe_asset' % mesh ))

    def doOperation( self, operands ):
        ''' run the op '''
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

        # generates the preview image
        self.doPublishPreview(self.data)

        return IECore.StringData( 'done' )


    def doPublish(self, operands):
        ''' use to implement extra publish stuff '''
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
        '''return the nodename based on the asset data '''
        return _nodeName(data)

    def doImport(self, asset, data=None, update=True, **kargs):
        ''' method called by host to import asset into host scene '''
        self.kargs = kargs
        self.asset = Asset.AssetParameter(asset)
        if not data:
            data = self.asset.getData()
        self.data = data

        # print( self.data, self.asset, asset )
        if 'multipleFiles' not in self.data:
            return
        for n in range(len(self.data['multipleFiles'])):
            each = os.path.splitext(self.data['multipleFiles'][n])[0]
            filename = ''
            if 'multiplePublishedFiles' in self.data:
                filename = self.data['multiplePublishedFiles'][n]
                # print( filename )

            filename = _fixJobPrefix(filename)
            nodeName = self.nodeName(self.data) + each

            stack = []
            if update:
                # allways import the asset, if the current version is different than the one
                # to be imported!
                if self.doesAssetExists(nodeName, anyVersion=False):
                    if not self.doesAssetExists(nodeName, allOtherVersionsOnly=True):
                        continue

                # push attributes values of to be deleted nodes so we can restore after update
                stack = push(self.doesAssetExists(nodeName, allOtherVersionsOnly=True))
                self.cleanupOldVersions(self, nodeName)
            # else:
            #     # if the scene already has a version of the node,
            #     # don't import another!
            #     if self.doesAssetExists(nodeName, anyVersion=True):
            #         continue

            canPublish = 0
            if filename:
                canPublish += self.doImportToHost(filename, nodeName, update=update)

            if canPublish == 0:
                raise Exception("Can't import asset!!")

            updateCurrentLoadedAssets()

            pop(stack)

    def doImportToHost(self, filename, nodeName, **kargs):
        '''virtual function to be implement by type specific asset classes'''
        return 0

    @staticmethod
    def removeNamespaces():
        if m:
            defaults = ['UI', 'shared']
            namespaces = 1
            while namespaces:
                namespaces = [ns for ns in pm.namespaceInfo(lon=True) if ns not in defaults]
                for ns in namespaces:
                    # print( ns )
                    m.namespace( removeNamespace = ns, mergeNamespaceWithRoot = True)

__maya__attach__shaders__lazyCount = 0
class maya( _genericAssetClass ) :
    _whoCanImport = ['maya', 'gaffer']
    _whoCanPublish = ['maya']
    _whoCanOpen = ["maya"]
    _importAsReference = False

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
    def shaveCleanup():
        if m:
            # print( "Shave Cleanup!" )
            # shave cleanup
            attrs_to_clean = [
                "renderManRISGlobals.rman__torattr___preRenderScript",
                "renderManRISGlobals.rman__torattr___postRenderScript",
                "renderManRISGlobals.rman__torattr___postTransformScript",
                "renderManRISGlobals.rman__torattr___renderBeginScript",
                "defaultRenderGlobals.preRenderMel",
            ]
            for attr in attrs_to_clean:
                if m.objExists(attr):
                    tmp = m.getAttr( attr );
                    if tmp:
                        tmp = ';'.join([ x for x in tmp.split(';') if  x.strip() and 'shave' not in x.lower() ])
                        # print( attr, tmp )
                        m.setAttr( attr , tmp, type="string" );

    @staticmethod
    class prmanDinamicRules():
        ''' a simple class to handle prman dinamic rules in a simple way!'''
        def __init__(self):
            self.rlf2maya = self.rlf = None
            if pipe.isEnable('prman'):
                try:
                    import rfm.rlf2maya as rlf2maya
                    import rfm.rlf as rlf
                    self.s  = rlf.RLFScope()
                    self.ps = self.s.GetInjectionPayloads()
                    self.rlf2maya = rlf2maya
                    self.rlf = rlf
                    self.cache = {}
                except:
                    print( "WARNING: No prman python module to set dynamic rules for shaders." )

        def fromScene(self):
            if self.rlf2maya:
                self.s = self.rlf2maya.GetActiveScope()

        def isEmpty(self):
            if self.rlf2maya:
                return self.s.GetRules() == []
            return True

        def payload(self, sg):
            if self.rlf2maya:
                label = m.listConnections('%s.surfaceShader' % sg, s=1, d=0)
                p=None
                if not label:
                    print( "WARNING: Shading group %s have no surface shader!" % sg )
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
                        # print( self.cache.keys() )
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
        maya._attachShaders(True)
        # if lazyRefresh:
        #     def __attachShaders():
        #         maya._attachShaders(True)
        #     assetUtils.mayaLazyScriptJob( runOnce=True,  idleEvent=__attachShaders )
        # else:
        #     assetUtils.mayaLazyScriptJob( runOnce=True,  idleEvent=maya._attachShaders )

    @staticmethod
    def node2rule(nodeName):
        # if 'SAM_' in nodeName:
        #     return ''
        #*[starts-with(name(),'paperclip')]
        # print( nodeName )
        paths = []
        # for path in nodeName.split('|'):
        nodeNames = [ x for x in nodeName.split('|') if x.strip() and 'SAM' not in x and 'group' not in x ]
        if len(nodeNames) > 1:
            for path in [nodeNames[0],nodeNames[-1]]:
                if path.strip():
                    path = path.split(':')[-1]
                    # remove Shape from name
                    l = 0
                    for x in path.split('Shape'):
                        if len(x) > l:
                            path = x
                            l = len(path)

                    for n in range(10):
                        # path = path.replace(str(n),'')
                        # split node name by number and gather the longest string!
                        l = 0
                        for x in path.split(str(n)):
                            if len(x) > l:
                                path = x
                                l = len(path)

                    paths += [path]

            # print( paths )
            rule = "//%s//*[contains(name(),'%s')]" % (paths[0], paths[-1])
        else:
            paths = nodeName.split('|')[-1]
            rule = '/'.join( [ "*[contains(name(),'%s')]" % ps for ps in paths ] ).strip('|').replace('|','/')

        # if paths:
        #     p = ''
        #     # paths.reverse()
        #     for ps in paths:
        #         if not p:
        #             # p = "*[starts-with(name(),'%s')]" % ps
        #         else:
        #             p = "*[starts-with(name(),'%s') and parent::%s]" % (ps, p)
        #     rule = p
        # else:

        # not sure we need this now...
        if not paths:
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
        try:
            import maya.cmds as m
        except:
            m = None
        if m:
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
                            # print( nodes, connections )
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

                        # print( each, notInUse )

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
        maya._cleanUnusedShadingNodes(True)
        # if force:
        #     def __cleanUnusedShadingNodesForce():
        #         maya._cleanUnusedShadingNodes(True)
        #         assetUtils.mayaLazyScriptJob( runOnce=True,  idleEvent=__cleanUnusedShadingNodesForce )
        # else:
        #     assetUtils.mayaLazyScriptJob( runOnce=True,  idleEvent=maya._cleanUnusedShadingNodes )

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

        tmp = ma.general.fileTexturePathResolver.findAllFilesForPattern(textureNode,0)
        for each in range(1001,1020):
            tmp += ma.general.fileTexturePathResolver.findAllFilesForPattern(textureNode.replace(str(each),'<UDIM>'),0)

        tmp.sort()
        textureNode = list(set(tmp))

        return textureNode

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
                print( "Node %s doesnt have a shading group!" % shape )
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
                # print( ntype, node )
                for n in pm.listHistory(node, type=ntype):
                    each = n.nodeName()
                    # print( "\t\t", each )
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

    @staticmethod
    def setOneNucleus(start=None):
        ''' make sure all ncloth/nrigid are using just one solver! '''
        nObjs = m.ls(type='nCloth', dag=1, l=1)+m.ls(type='nRigid', dag=1, l=1)
        if nObjs:
            n = m.ls(type='nucleus', dag=1, l=1)
            if not n:
                # if no nucleus, create one!
                m.select(nObjs)
                n += [m.createNode('nucleus')]
                # set a high colision interactions just to be on the safe side!
                m.setAttr("%s.subSteps" % n[0], 4)
                m.setAttr("%s.maxCollisionIterations" % n[0], 100)

            # set the initial frame on the simulation to the timeslider start range frame!
            startFrame = start
            if startFrame:
                m.playbackOptions( e=1, minTime=startFrame )
            else:
                startFrame = float(m.playbackOptions( q=1, minTime=1 ))
            for _n in n:
                m.setAttr("%s.startFrame" % _n, startFrame)
            m.select(nObjs)
            try:
                meval('assignNSolver "%s"' % n[0])
            except:
                pass
            # if len(n)>1:
            #     m.delete(n[1:])

    @staticmethod
    def getAnimLength(node):
        '''return the minimum and maximum keyframe of the animation in a node'''
        # A set is like a list but can't hold duplicates (Pyhton set, not Maya set)
        keyframeSet=set()
        # Loop through all keyframe time values from control points on anim curves
        k = m.keyframe(node, query=True, controlPoints=True)
        if k:
            for keyTimeValue in k:
                keyframeSet.add(keyTimeValue)

            # Return result
            return min(keyframeSet), max(keyframeSet)
        return None

    @staticmethod
    def getAllNodesMinMax( fatherNodes, filter='' ):
        ''' check animation on all nodes children of fatherNode that match the
        filter and return then min/max keyframes.'''
        _min=[]
        _max=[]
        if type(fatherNodes) != type([]):
            fatherNode = [fatherNodes]
        for fatherNode in fatherNodes:
            for each in m.ls(fatherNode+'*', dag=1, l=1):
                # if filter in each:
                    animLength =  maya.getAnimLength(each)
                    # print( each, animLength )
                    if animLength:
                        _min += [animLength[0]]
                        _max += [animLength[1]]

        if len(_min)<1:
            # print( fatherNodes, _min, _max )
            # print( m.ls(fatherNode[:-2]+'*', dag=1, l=1) )
            # print( m.ls(fatherNode+'*',  l=1) )
            return None
        return min(_min), max(_max)

    @staticmethod
    def setTimeSliderRangeToAvailableAnim(node=""):
        # set the time slider to the range in the alembic nodes!!
        start=[]
        end=[]
        se = maya.getAllNodesMinMax(node)
        if se:
            start += [se[0]]
            end += [se[1]]
        for c in m.ls(dag=1,l=1,type='AlembicNode'):
            if 'AlembicNode' in m.nodeType(c):
                s = float(m.getAttr(c+'.startFrame'))
                e = float(m.getAttr(c+'.endFrame'))
                if s+e != 0:
                    start += [s]
                    end += [e]

        if start:
            print( "playbackOptions", min(start), max(end) )
            m.playbackOptions( e=1, minTime=min(start), maxTime=max(end) )

        # set nucleus after correcting time range, so we can pick up the start from from the range!
        maya.setOneNucleus()

    @staticmethod
    def frameRange(V3f=False, V3fData=False):
        range = (0,0,0)
        if m:
            startFrame = math.floor(float(m.playbackOptions( q=1, minTime=1 )))
            endFrame = math.ceil(float(m.playbackOptions( q=1, maxTime=1 )))+1
            by = float(m.playbackOptions(by=1))
            range = (startFrame, endFrame, by)

        elif Gaffer:
            range = (0,0,0)

        if V3fData or V3f:
            range = IECore.V3f( range[0], range[1], range[2] )
            if V3fData:
                range = IECore.V3fData( range )

        return range

    @staticmethod
    def setupCryptomatte():
        for each in pm.ls(type="PxrCryptomatte"):
            pm.delete(each)
        node = pm.shadingNode("PxrCryptomatte",asTexture=1)
        m.connectAttr(node.name()+".message", "renderManRISGlobals.rman__samplefilters[0]", f=1)
        node.setAttr('filename', 'cryptomatte.${F4}.exr')

    @staticmethod
    def extraFiles( data, filename='' ):
        if 'extraFiles' not in data:
            data['extraFiles'] = []
        for node in data['meshPrimitives']:
            for n in m.ls(node, dag=1):
                # find all extra filenames that needed to be published with the maya asset
                for attr in [ (n+'.'+a, str(m.getAttr(n+'.'+a)).strip()) for a in  m.listAttr(n, w=1, se=1, usedAsFilename=1) if m.getAttr(n+'.'+a) ]:
                    if attr[1]:
                        data['extraFiles'] += [attr[1]]
                        m.setAttr( attr[0],  "%s/%s" % ( data['publishPath'], os.path.basename( attr[1] ) ), type='string' )

        maya.exportXgen(data, filename)

    def _extraFiles( self, filename='' ):
        maya.extraFiles( self.data, filename )

        # backup the shading groups orignal names, so we can put then back if
        # they are tracesets in renderman
        for n in pm.ls(type='shadingEngine'):
            if n.hasAttr("rman__torattr___traceSet"):
                if not n.hasAttr("SAM_ORIGINAL_NODE_NAME"):
                    n.addAttr( "SAM_ORIGINAL_NODE_NAME",dt="string")
                if not n.getAttr("SAM_ORIGINAL_NODE_NAME"):
                    n.setAttr( "SAM_ORIGINAL_NODE_NAME", str(n.name()), type="string" )

    def doPublishMayaExport(self, fileName, operands):
        '''
        This function is called by doPublishMaya() after the basic generic export setup has being done.
        In a simple geometry publish, this function only selects the geometry and file->export it!
        '''
        if not self.__mayaScenePublishType:
            mayaExt = os.path.splitext( operands['%sDependency' % self.prefix].value )[-1].lower()
        else:
            mayaExt = ".%s" % self.__mayaScenePublishType

        # print( mayaExt, fileName )
        m.select(self.data['meshPrimitives'])

        # print( "mayaBinary" if mayaExt=='.mb'else 'mayaAscii' )
        m.file(fileName, force=1, preserveReferences=1, exportSelected=1, typ=("mayaBinary" if mayaExt=='.mb'else 'mayaAscii'))

    def doPublishMaya(self, operands):
        ''' called by SAM when exporintg an asset in maya '''
        if m:
            if not self.__mayaScenePublishType:
                mayaExt = os.path.splitext( operands['%sDependency' % self.prefix].value )[-1].lower()
            else:
                mayaExt = ".%s" % self.__mayaScenePublishType

            self.data['assetPath'] = "%s/data/%%s" % m.workspace(q=1, rd=1) + mayaExt
            self.data['multipleFiles'] = ['asset']


            for each in self.data['multipleFiles']:
                scene = self.data['assetPath'] % each

                self._extraFiles(scene)
                self.doPublishMayaExport(scene, operands)

            m.file(s=1)

            return True
        return False

    @staticmethod
    def exportXgen(data, filename=''):
        for node in data['meshPrimitives']:
            # XGEN
            # find all extra xgen files to publish
            data['xgenNodes'] = {}
            for n in m.ls(node, type='xgmPalette', dag=1, l=0):
                xgen_file_base = "%s__%s.xgen" % (os.path.splitext(os.path.basename(m.file(q=1,sn=1)))[0], n)
                xgen_file_node = str(m.workspace(q=True, dir=True, rd=True )+'/scenes/'+m.getAttr(n+'.xgFileName')).strip()
                xgen_file = str(m.workspace(q=True, dir=True, rd=True )+'/scenes/'+xgen_file_base)
                if not os.path.exists( xgen_file_node ):
                    print( "XGEN PUBLISH ERROR: Can't find xgen collention file %s for node %s! Can't publish xgen." % (xgen_file_node, n) )
                else:
                    if xgen_file_node != xgen_file:
                        os.system( 'cp -rf "%s" "%s"' % (xgen_file_node, xgen_file) )
                    m.setAttr(n+'.xgFileName', xgen_file_base, type='string')
                    new_xgen_file = ''
                    xgProjectPath = ''
                    xgDataPath = []
                    for line in open(xgen_file,'r'):
                        if 'xgDataPath' in line:
                            xgDataPath += [line.split('xgDataPath')[-1].strip()]

                        if 'xgProjectPath' in line:
                            xgProjectPath = line.split('xgProjectPath')[-1].strip()
                            new_xgen_file += "\txgProjectPath\t<SAM_PROJECT>\n"
                        else:
                            new_xgen_file += line

                    if not xgProjectPath:
                        print( "XGEN PUBLISH ERROR: Can't find project path in xgen file %s!" % xgen_file )
                    else:
                        # expand xgDataPath paths and add to extraFiles to be published!
                        for each in xgDataPath:
                                data['extraFiles'] += [each.replace('${PROJECT}', '%s/' % xgProjectPath)]

                    data['xgenNodes'][n]  = (filename+'.xgen', xgen_file)
                    f = open(data['xgenNodes'][n][0],'w')
                    f.write(new_xgen_file)
                    f.close()

                    data['extraFiles'] += data['xgenNodes'][n]

                # now we need to find all extra data that needs to be published as well.

    @staticmethod
    def importXgen(data):
        ''' copy the xgen files from the publish directory to the user project '''
        if 'extraFiles' in data:
            for each in data['extraFiles']:
                if 'xgen' in each:
                    samFile  = os.path.dirname(data['publishFile'])+'/'+os.path.basename(each)
                    # fix samFile for the current job
                    samFile = _fixJobPrefix(samFile)
                    userFile = m.workspace(q=True, dir=True, rd=True)+'/'.join(each.split('maya')[1:])
                    # xgen files need to be copied to the user maya folder and adjusted before importing the scene
                    if os.path.splitext(each)[-1] in ['.xgen']:
                        for node in [ x for x in data['xgenNodes'] if os.path.basename(each) in data['xgenNodes'][x][1] ]:
                            xgen_metadata = str(m.workspace(q=True, dir=True, rd=True)+'/scenes/'+os.path.basename(data['xgenNodes'][node][1]))
                            # print( xgen_metadata )
                            w=open(xgen_metadata,'w')
                            r=open(samFile,'r')
                            for line in r:
                                if 'xgProjectPath' in line:
                                    line = '\txgProjectPath\t%s\n' % str(m.workspace(q=True, dir=True, rd=True)+'/')
                                w.write(line)
                            w.close()
                    else:
                        cmd = 'mkdir -p "%s" ; cp -rvf "%s" "%s"' % ( os.path.dirname(userFile), samFile, userFile )
                        if os.path.isdir(samFile):
                            cmd = 'mkdir -p "%s" ; cp -rvf %s/* "%s"' % ( os.path.dirname(userFile), samFile, userFile )
                        # print( each, cmd )
                        os.system( cmd  )

    def doImportToHost( self, filename, nodeName, **kargs ):
        ret = 0
        if self.hostApp() in ['maya'] and m:
            ret = self.doImportMaya( filename, nodeName, **kargs )
            if ret:
                self.fixRIGMeshCTRLS()
        elif self.hostApp() in ['gaffer']:
            pass
        return ret

    def doImportMaya( self, filename, nodeName, **kargs ):
        # maya import code!
        if m:
            update=True
            if 'update' in kargs:
                update = kargs['update']

            self.importXgen(self.data)
            # print(")))))))))))",nodeName)
            old_groups = m.ls('|*', type='transform')
            self._mayaFileIn(filename, nodeName, update)
            for groups in [ g for g in m.ls('|*', type='transform') if g not in old_groups ]:
                if m.objExists(groups):
                    newNodeName = m.rename( groups, nodeName)
                    # m.lockNode(newNodeName, l=1)

            # restore shadingGroup names if they are tracesets!
            for n in pm.ls(type='shadingEngine'):
                if n.hasAttr("rman__torattr___traceSet"):
                    if n.hasAttr("SAM_ORIGINAL_NODE_NAME"):
                        name = n.getAttr("SAM_ORIGINAL_NODE_NAME")
                        if name:
                            n.rename( name )

            maya.attachShaders()
            # assetUtils.mayaLazyScriptJob( runOnce=True,  idleEvent=maya.attachShaders )

            # set the timeslider range to the start/end of available keyframes and alembic range.
            maya.setTimeSliderRangeToAvailableAnim()

            return True
        return False


    def _mayaFileIn( self, filename, nodeName, update=True ):
        if m:
            if self._importAsReference:
                # file -r -type "mayaBinary" -gr  -ignoreVersion -gn "SAM" -gl -mergeNamespacesOnClash false -namespace "eric_animation_test"
                #  -options "v=0;" "/frankbarton/jobs/9990.rnd/assets/sophia/users/rhradec/maya/scenes/eric-animation-test.mb";
                nodes = self.doesAssetExists(nodeName, allOtherVersionsOnly=True)
                namespace = nodeName #'_'.join(nodeName.split('_')[:-4])
                # namespace = nodeName.split(':')[-1].split('_asset')[0][:-8] #'_'.join(nodeName.split('_')[:-4])
                if update:
                    # UPDATE ONLY - replace reference with the requested updates
                    group = None
                    error = []
                    for sam in nodes:
                        # find loaded references
                        for reference in [x for x in m.ls(type='reference', dag=0) if 'sharedReferenceNode' != x]:
                            if not m.objExists(reference):
                                continue

                            if not m.referenceQuery(reference, dp=1,n=1):
                                continue

                            _resolved_filename = m.referenceQuery(reference, f=1)
                            if filename in _resolved_filename:
                                continue

                            sam_reference = sam.split(':')[-1].split('_asset')[0][:-8]
                            # print('=>',sam_reference)

                            # now only act on the references of the select sam nodes
                            if sam_reference in reference.split(':')[-1] and 'RN' in reference[-4:]:
                                # if the reference is a reference imported inside another reference
                                if len(reference.split(':'))>1:
                                    path=[]
                                    for n in [-1, -2]:
                                        p = reference.split(':')[n].replace('SAM_','').split('_asset')[0]
                                        p = p[:-9]
                                        p = p.split('_')
                                        p = '/'.join([ p[0], p[1], '_'.join(p[2:]) ])
                                        path += [p]
                                    error += ["\n\nSAM: Can't update %s because it's a reference embeded in %s.\nPlease update it in the the original file for %s and publish a new version to be updated in this scene!" % (path[0], path[1], path[1])]
                                    error += ["\nIf %s is green now, it's probably because %s was just updated and %s was already up to date in it!" % (path[0], path[1], path[0])]
                                # it's a top level reference, so update it!
                                else:
                                    m.file(filename, loadReference=reference)
                                    _resolved_filename = m.referenceQuery(reference, f=1)
                                    m.file(_resolved_filename, e=1, ns=namespace)
                                    if m.objExists(sam):
                                        m.rename( sam, nodeName)

                    # cleanup trash that maya leaves behind!!
                    if m.objExists('sharedReferenceNode'):
                        m.delete('sharedReferenceNode')
                    if error:
                        def __warning__():
                            print('='*80)
                            m.warning(''.join(error)+'\n\n'+'='*80)
                        assetUtils.mayaLazyScriptJob( runOnce=True,  idleEvent=__warning__ )
                    else:
                        # fix sam names according to namespaces, so sam
                        # node names match whats loaded!
                        for sam in self.doesAssetExists(nodeName, allOtherVersionsOnly=True):
                            if m.objExists(sam):
                                print("-->", sam)
                                for r in m.listRelatives(sam, c=1):
                                    ns=m.referenceQuery(r, namespace=1).split(':')[1]
                                    if ns.split('_asset')[0] != sam.split('_asset')[0]:
                                        try: m.rename( sam, ns)
                                        except: pass
                else:
                    # IMPORT ONLY
                    # import as reference
                    # m.file(filename, r=1, gr=1)

                    # namespace or reference kills animation for some reason!!
                    m.file(filename, r=1, preserveReferences=1, gr=1, ns=namespace )
            else:
                m.file(filename, i=1, preserveReferences=1, gr=1 )

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

    @staticmethod
    def cleanupOldVersions( self, nodeName ):
        ''' delete any other version! '''
        if m and not self._importAsReference:
            nodes = self.doesAssetExists(nodeName, anyVersion=True)
            maya.cleanNodes( self.doesAssetExists(nodeName, anyVersion=True) )
            # cleanup shader leftovers
            # maya.cleanUnusedShadingNodes()
            maya.cleanNodes( m.ls("SAMIMPORT*") )

class alembic(  _genericAssetClass ) :
    _whoCanImport = ['gaffer','maya', 'houdini']
    _whoCanPublish = ['gaffer','houdini','maya']
    _whoCanOpen = ['gaffer','houdini','maya']

    def __init__( self, prefix, animation=True, nameGroup='Group', nameDependency='Dependency' ) :
        _genericAssetClass.__init__( self, prefix, animation, nameGroup, nameDependency )
        self.meshOnly()
        self.setSubDivMeshesMask(None)
        self.__setImportAsGPU = False

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
    def shaveRibExport( frame=1, outRIB = '/tmp/shave.%04d.rib', selection=[], END=False ):
        ''' per frame callback to export shave as cob files'''
        import time
        if not END:
            # if we don't have shave loaded, don't do anything!
            if 'shaveHair' not in m.ls(nodeTypes=1):
                return

            selectedShave  = m.ls(selection,dag=1,type='shaveHair')
            connectedShaveNodes = m.listConnections(m.ls(selection, dag=1, type='mesh'), type='shaveHair', sh=1)
            selectedShave += list(set(connectedShaveNodes if connectedShaveNodes!=None else []))
            selectedShave  = list(set(selectedShave))
            # selectedShave = [ str(x) for x in selectedShave ]
            globals()['self'].pb.step()
            print( '*'*200 )
            print( 'Shave exporting', selectedShave )
            print( '*'*200 )
            if not hasattr(globals()['self'], 'conection'):
                globals()['self'].conection = {}
                if not m.pluginInfo('shaveCortexWriter', q=1, l=1):
                    m.loadPlugin('shaveCortexWriter')

                for each in m.ls(dag=1,type='shaveHair'):
                    if m.getAttr( each + '.active', l=1 ):
                        m.setAttr( each + '.active', l=0 )
                    globals()['self'].conection[each] = m.listConnections( "%s.active" % each , p=1, c=1 )
                    if globals()['self'].conection[each]:
                        m.disconnectAttr(globals()['self'].conection[each][1],globals()['self'].conection[each][0])
                    else:
                        del globals()['self'].conection[each]
                    # print( '='*200 )
                    # print( each + '.active', each in selectedShave )
                    # print( '='*200 )
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
                #     print( 'filtered rib in %d seconds...' % (time.time()-t) )
                #     f.close()
                print( 'shaveCortexWriter -e "%s" "%s"' % (outCOB, each) )
                # m.shaveCortexWriter(outCOB, each, e=1)
                meval('shaveCortexWriter -e "%s" "%s"' % (outCOB, each) )
                print( pipe.bcolors.bcolors.GREEN+'shave rib gen took %d seconds to export...' % (time.time()-t) +pipe.bcolors.bcolors.END )

                if os.path.exists(outCOB):
                    if 'extraFiles' not in globals()['self'].data:
                        globals()['self'].data['extraFiles'] = []
                    globals()['self'].data['extraFiles'] += [outCOB]

                    if 'extraFilesDelete' not in globals()['self'].data:
                        globals()['self'].data['extraFilesDelete'] = []
                    globals()['self'].data['extraFilesDelete'] += [outCOB]

                    if 'shaveNodes' not in globals()['self'].data:
                        globals()['self'].data['shaveNodes'] = {}
                    if each not in globals()['self'].data['shaveNodes']:
                         globals()['self'].data['shaveNodes'][each] = []
                    if outCOB not in globals()['self'].data['shaveNodes'][each]:
                        globals()['self'].data['shaveNodes'][each] += [outCOB]
                else:
                    print( pipe.bcolors.bcolors.RED+'%s (%s) failed to export!!!' % (outCOB,each) +pipe.bcolors.bcolors.END )

            else:
                for each in globals()['self'].conection:
                    m.setAttr( each + '.active', 0 )
                    try:
                        m.connectAttr(globals()['self'].conection[each][1],globals()['self'].conection[each][0])
                    except:
                        print( pipe.bcolors.bcolors.WARNING, 'WARNING (SAM SHAVE EXPORT): Cant restore connection from %s to %s!' % (globals()['self'].conection[each][1],globals()['self'].conection[each][0]), pipe.bcolors.bcolors.END )

        print( '*'*200 )

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
            # print( "BUMM",sl, len(curves), len(meshes) )
            if curves and not meshes:
                extra = ''
            else:
                if not self.__anyNode:
                    meshes = m.ls( sl=1, dag=1, visible=1, ni=1, type='mesh' )
                    # convert rman attributos to a cleaner version
                    attrs  = [ a for a in attributesToExport if 'rman__torattr___' in a ]
                    pb = progressBar(len(attrs)*len(meshes)+1, 'setting up geometry for export...')
                    pb.step()
                    for n in meshes:
                        pb.step()
                        for attr in attrs:
                            pb.step()
                            if m.objExists( '%s.%s' % (n, attr) ):
                                cleanAttr = attr.replace('rman__torattr___','')
                                if not m.objExists( '%s.%s' % (n, cleanAttr) ):
                                    m.addAttr( n, ln=cleanAttr, at="long" )
                                m.setAttr( '%s.%s' % (n, cleanAttr), m.getAttr( '%s.%s' % (n, attr) ) )
                                if cleanAttr not in attributesToExport:
                                    attributesToExport.append(cleanAttr)

                        for attr in [ a for a in m.listAttr(n) if 'rman_' in a ]:
                            if attr not in attributesToExport:
                                attributesToExport += [attr]

                    pb.close()

                    m.select( meshes )
                else:
                    m.select( m.ls( sl, dag=1) )

                if attributesToExport:
                    extra += ' -attr '+' -attr '.join(attributesToExport)

                extra += ' -noNormals  -sl '


            className = str(self.__class__).split('.')[-1]
            root = ' '.join([ '-root '+x for x in sl ])

            # just make sure we have the extra keys we need.
            if 'frameCallback' not in self.data:
                self.data['frameCallback'] = {}
            if 'extraFiles' not in self.data:
                self.data['extraFiles'] = []

            # create a temp file so frameCallback can generate data to input
            # into asset data file. The temp file will contain a str(dict) so
            # we can just read it and eval() the content of the file.
            ftmp = tempfile.mkstemp()
            os.close( ftmp[0] )
            ftmp = ftmp[1]

            abcJob = "%s %s  -step %s -wv -fr %s %s %s -file %s" % (
                extra,
                '''-pythonPerFrameCallback "import genericAsset;genericAsset.alembic._perFrameCallback(#FRAME#, '%s', %s, '%s' )"''' % (shaveTmp,sl,ftmp),
                1.0,
                start,
                end,
                root,
                mfile,
            )
            # we have to call the callback here since it seems it won't call if just one frame is being exported
            if start==end:
                alembic._perFrameCallback(start, shaveTmp, sl, ftmp )
            print( "m.AbcExport( j=abcJob) : ", abcJob ) ; sys.stdout.flush()
            m.AbcExport( j=abcJob)

            # retrieve temp file data and pipe into asset data file.
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

            alembic.shaveRibExport(END=True)

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

            tmp = '%s/data/sam_tmp/'  % m.workspace(q=1, rd=1)
            os.system('mkdir -p %s/%s_cob/' % (tmp, os.environ['USER']))
            shaveTmp = '%s/%s_cob/shave.%%04d.cob'  % (tmp, os.environ['USER'])

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


            maya.extraFiles(self.data, self.data['assetPath'] % "asset")
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
                    # print( each, uvsets )
                    m.polyUVSet( each, currentUVSet=1, uvSet=uvsets[1] )
                    if '[0:1]' in m.ls(  "%s.map[0:1]" % each )[0]:
                        m.polyUVSet( each, currentUVSet=1, uvSet=uvsets[0] )
                        m.polyUVSet( each, copy=True, nuv=uvsets[0], uvSet=uvsets[1] )
                    else:
                        nodesWithNoUV += ["Node %s have NO UV in any of the %s uvsets" % (each, ' '.join(uvsets))]
                else:
                    nodesWithNoUV += ["Node %s have NO UV in %s uvset" % (each, ' '.join(uvsets))]

        if nodesWithNoUV:
            print( '='*80 )
            for line in nodesWithNoUV:
                print( line )
            print( '='*80 )
        pb.close()

    def doImportToHost( self, filename, nodeName, **kargs ):
        ret = 0

        if self.hostApp() in ['maya']:
            ret = self.doImportMaya( filename, nodeName )
            print('====>',self.hostApp(),ret, self.hostApp() in ['maya'],'<====')
            if ret:
                self.fixRIGMeshCTRLS()
        elif self.hostApp() in ['gaffer']:
            import nodes
            # print( self.kargs['root'].keys() )
            print( filename )
            assetPath = os.path.dirname(filename.split('/sam/')[1])
            assetPathParts = assetPath.split('/')
            gafferNodeName = 'SAM_%s' % _nameCleanup( os.path.dirname(assetPath) )
            self.kargs['root'][gafferNodeName] = eval( 'nodes.SAM%s%s()' % (assetPathParts[0], assetPathParts[1].capitalize()) )
            self.kargs['root'][gafferNodeName]['asset'].setValue( assetPath )
            ret = True
        return ret

    def doImportMaya(self, filename, nodeName, gpucache=False ):
        if m:
            # print( self.__setImportAsGPU )
            # print( gpucache )
            # print( filename )
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
                        pb.step()
                        if m.objExists( '%s.subdivScheme' % n ):
                            if not m.objExists(n + '.rman__torattr___subdivScheme'):
                                m.addAttr( n, ln="rman__torattr___subdivScheme", at="long" )
                            m.setAttr( n + '.rman__torattr___subdivScheme', m.getAttr( '%s.subdivScheme' % n ) )

                        if m.objExists( '%s.subdivFacevaryingInterp' % n ):
                            if not m.objExists(n + '.rman__torattr___subdivFacevaryingInterp'):
                                m.addAttr( n, ln="rman__torattr___subdivFacevaryingInterp", at="long" )
                            m.setAttr( n + '.rman__torattr___subdivFacevaryingInterp',  m.getAttr( '%s.subdivFacevaryingInterp' % n )  )

                    pb.close()


            # m.scriptJob( runOnce=True,  idleEvent=idleSetup )
            # assetUtils.mayaLazyScriptJob( runOnce=True,  idleEvent=alembic.fixDefaultUVSet() )
            maya.attachShadersLazy()
            alembic.fixDefaultUVSet()
            maya.setTimeSliderRangeToAvailableAnim()

            idleSetup()
            return True

        return False

    @staticmethod
    def fixRIGMeshCTRLS(grp='|CTRLS|'):
        if m:
            maya.fixRIGMeshCTRLS(grp)
            # we delete whatever is in the RibControl group, since alembic doesn't need it!
            for n in [ x for x in m.ls(dag=1,long=1,type='mesh')  if grp in x and '|SAM' in x and '_alembic_' in x ]:
                m.delete(n)

    @staticmethod
    def importAlembic(filename, nodeName, gpuCache=False, data=None):
        if m:
            if not gpuCache:
                node = m.createNode( "transform", n=nodeName)
                m.AbcImport( filename, rpr=node )
                if data:
                    # gather all shave caches in this asset, if any!
                    cobs = {}
                    has_shaveNodes = 'shaveNodes' in data
                    if not has_shaveNodes:
                        if 'extraFiles' in data:
                            for each in data['extraFiles']:
                                if 'shave.' in each:
                                    nodeName = '.'.join( each.split('.')[:-2] )
                                    if nodeName not in cobs:
                                        cobs[ nodeName ] = []
                                    cobs[ nodeName ] += [each]
                    else:
                        cobs = data['shaveNodes']

                    if cobs:
                        nodeHair = m.createNode( "transform", n='HAIR')
                        nodeHair = m.parent( nodeHair, node )
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


                            shaveCache = os.path.splitext( os.path.splitext( cobs[shave][0] )[0] )[0]+'.####.cob'
                            shaveCache = '%s/%s' % (data['publishPath'], os.path.basename(shaveCache))
                            m.setAttr( fileAttr, shaveCache, type='string' )

                            m.setAttr("%s.visibleInReflections" % fnPH.name(), 1)
                            m.setAttr("%s.visibleInRefractions" % fnPH.name(), 1)

                            if has_shaveNodes:
                                name = shave
                                new_transform = shave.replace("Shape", "")
                                idpassName = shave.split("Shape")[0]
                            else:
                                name = 'shaveShape'
                                new_transform = data['assetName']+'_shave'
                                idpassName = shaveCache.split('/shave.')[1].split('.')[0]
                            count=1
                            while m.objExists('|%s|%s' % (transform, name)):
                                name = name.split('_')[0]+'_'+str(count)
                                count+=1

                            m.rename( '|%s|%s' % (transform, fnPH.name()), name)
                            transform = m.rename( transform, new_transform)
                            m.parent( transform, nodeHair )

                            # set the IDPrimvarName to the shaveNode name used in the cob sequence name
                            try:
                                attrName = fnPH.parameterPlugPath( fnPH.getProcedural()["shaveName"] )
                                m.setAttr( attrName, idpassName, type='string' )

                                attrName = fnPH.parameterPlugPath( fnPH.getProcedural()["IDPrimvarName"] )
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
                                            # print( data['shave'][cobIndex][attr], type(data['shave'][cobIndex][attr]) )
                                            if type(data['shave'][cobIndex][attr]) in [str, unicode]:
                                                m.setAttr( attrPar, data['shave'][cobIndex][attr], type="string" )
                                            else:
                                                m.setAttr( attrPar, data['shave'][cobIndex][attr] )

                    # print( data )
                    if 'frameCallback' in data:
                        frames = list(data['frameCallback'].keys())
                        if frames and 'xgen' in data['frameCallback'][frames[0]]:
                            for c in data['frameCallback'][frames[0]]['xgen']:
                                abc = filename
                                xgen_path = data['publishPath']
                                collection = c[1]
                                description = c[2]
                                patch_name = c[3]
                                samXgen.xgen_create_ribbox(collection, description, abc, patch_name, xgen_path)
                                # print( "11111111111111111" )
                                # print( collection, description, patch_name )
                                # print( "11111111111111111" )



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

    @staticmethod
    def cleanupOldVersions( self, nodeName ):
        maya.cleanupOldVersions( self, nodeName )

class gaffer( _genericAssetClass ):
    _whoCanImport = ['maya', 'houdini','gaffer']
    _whoCanPublish = ['gaffer']
    _whoCanOpen = ['gaffer']

    def __init__( self, prefix="bundle" ) :
        _genericAssetClass.__init__( self, prefix, animation=False )


    def doPublish(self, operands):
        ''' called by SAM when publishing an asset '''
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

    def doImportToHost( self, filename, nodeName, **kargs ):
        ret = 0
        if m:
            ret = self.doImportMaya( filename, nodeName )
        return ret

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
        # print( "xx", m )
        if m:
            n = '+'.join([ m.getAttr( node + '.SAM_BUNDLE' ) for node in gafferNodes ])
            # print( n )
            if n.strip():
                for node in eval(n):
                    if node['op'].path:
                        node['op'].hostApp('maya')
                        nodes += node['op'].nodes()
        return nodes

    @staticmethod
    def cleanupOldVersions( self, nodeName ):
        ''' delete any other version! '''
        if m:
            nodes = self.doesAssetExists(nodeName, anyVersion=True)

            maya.cleanNodes( nodes+self.childrenNodes(nodes) )

            # cleanup shader leftovers
            # maya.cleanUnusedShadingNodes()

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

class usd(  alembic ) :
    _whoCanImport = ['gaffer','maya', 'houdini']
    _whoCanPublish = ['gaffer','houdini','maya']
    _whoCanOpen = ['gaffer','houdini','maya']

    def __init__( self, prefix, animation=True, nameGroup='Group', nameDependency='Dependency' ) :
        _genericAssetClass.__init__( self, prefix, animation, nameGroup, nameDependency )
        self.meshOnly()
        self.setSubDivMeshesMask(None)
        self.__setImportAsGPU = False

    def publishFile(self, publishFile, parameters):
        path = os.path.dirname(publishFile)
        name = os.path.splitext(os.path.basename(publishFile))[0]
        file = "%s/%s.%%s.usd" % (path, name)
        return file

    @staticmethod
    def _perFrameCallback(frame, outRIB, selection, tmpfile=None):
        ''' wrapper function just to take care of passing data back to asset '''
        pass
        # data = self.perFrameCallback(frame, outRIB, selection)

        # # write the collected data to tempfile
        # if tmpfile:
        #     f = open(tmpfile,'a')
        #     f.write( "%d %s\n" % (frame, str(data)) )
        #     f.close()

    @staticmethod
    def perFrameCallback(frame, outRIB, selection):
        ''' a frame callback function to execute extra exporting
        during alembic export '''
        data = {}
        #
        # # xgen ribarchive!
        # data['shave'] = alembic.shaveRibExport( frame, outRIB, selection )
        #
        # # xgen export!
        # data['xgen'] = samXgen.xgen_export_for_ribbox( selection, frame )
        #
        # data['extraFiles'] = [ x[0] for x in data['xgen'] ]
        #
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
    def USDExport(self, mfile, start, end, sl, extra='-renderableOnly -uvWrite -writeUVSets', shaveTmp='/tmp/shave.%04d.cob'):
        if m:
            import tempfile
            m.select( sl )
            slall = m.ls(sl=1,dag=1)
            cleanup = []
            m.file("/frankbarton/jobs/0403.teste/assets/rnd/users/rhradec/maya/scenes/stich.usd",
                force=1,
                options="-boundingBox;-mask 6399;-lightLinks 1;-shadowLinks 1;-fullPath",
                typ="Arnold-USD",
                pr=1,
                es=1,
            )


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
            # print( "BUMM",sl, len(curves), len(meshes) )
            if curves and not meshes:
                extra = ''
            else:
                if not self.__anyNode:
                    meshes = m.ls( sl=1, dag=1, visible=1, ni=1, type='mesh' )
                    # convert rman attributos to a cleaner version
                    attrs  = [ a for a in attributesToExport if 'rman__torattr___' in a ]
                    pb = progressBar(len(attrs)*len(meshes)+1, 'setting up geometry for export...')
                    pb.step()
                    for n in meshes:
                        pb.step()
                        for attr in attrs:
                            pb.step()
                            if m.objExists( '%s.%s' % (n, attr) ):
                                cleanAttr = attr.replace('rman__torattr___','')
                                if not m.objExists( '%s.%s' % (n, cleanAttr) ):
                                    m.addAttr( n, ln=cleanAttr, at="long" )
                                m.setAttr( '%s.%s' % (n, cleanAttr), m.getAttr( '%s.%s' % (n, attr) ) )
                                if cleanAttr not in attributesToExport:
                                    attributesToExport.append(cleanAttr)

                        for attr in [ a for a in m.listAttr(n) if 'rman_' in a ]:
                            if attr not in attributesToExport:
                                attributesToExport += [attr]

                    pb.close()

                    m.select( meshes )
                else:
                    m.select( m.ls( sl, dag=1) )

                if attributesToExport:
                    extra += ' -attr '+' -attr '.join(attributesToExport)

                extra += ' -noNormals  -sl '


            className = str(self.__class__).split('.')[-1]
            root = ' '.join([ '-root '+x for x in sl ])

            # just make sure we have the extra keys we need.
            if 'frameCallback' not in self.data:
                self.data['frameCallback'] = {}
            if 'extraFiles' not in self.data:
                self.data['extraFiles'] = []

            # create a temp file so frameCallback can generate data to input
            # into asset data file. The temp file will contain a str(dict) so
            # we can just read it and eval() the content of the file.
            ftmp = tempfile.mkstemp()
            os.close( ftmp[0] )
            ftmp = ftmp[1]

            abcJob = "%s %s  -step %s -wv -fr %s %s %s -file %s" % (
                extra,
                '''-pythonPerFrameCallback "import genericAsset;genericAsset.alembic._perFrameCallback(#FRAME#, '%s', %s, '%s' )"''' % (shaveTmp,sl,ftmp),
                1.0,
                start,
                end,
                root,
                mfile,
            )
            # we have to call the callback here since it seems it won't call if just one frame is being exported
            if start==end:
                alembic._perFrameCallback(start, shaveTmp, sl, ftmp )
            print( "m.AbcExport( j=abcJob) : ", abcJob ) ; sys.stdout.flush()
            m.AbcExport( j=abcJob)

            # retrieve temp file data and pipe into asset data file.
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

            alembic.shaveRibExport(END=True)

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

            tmp = '%s/data/sam_tmp/'  % m.workspace(q=1, rd=1)
            os.system('mkdir -p %s/%s_cob/' % (tmp, os.environ['USER']))
            shaveTmp = '%s/%s_cob/shave.%%04d.cob'  % (tmp, os.environ['USER'])

            self.data['assetPath'] = "%s/data/%%s.abc" % m.workspace(q=1, rd=1)
            self.USDExport(
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


            maya.extraFiles(self.data, self.data['assetPath'] % "asset")
            m.file(s=1)
            self.pb.close()


            return True
        return False

    def setSubDivMeshesMask(self, mask):
        self.__subDivMeshesMask = mask

    def setImportAsGPU(self, b):
        self.__setImportAsGPU = b

    def doImportToHost( self, filename, nodeName, **kargs ):
        ret = 0
        if self.hostApp() in ['maya'] and m:
            ret = self.doImportMaya( filename, nodeName )
            if ret:
                alembic.fixRIGMeshCTRLS()
        elif self.hostApp() in ['gaffer']:
            import nodes
            # print( self.kargs['root'].keys() )
            print( filename )
            assetPath = os.path.dirname(filename.split('/sam/')[1])
            assetPathParts = assetPath.split('/')
            gafferNodeName = 'SAM_%s' % _nameCleanup( os.path.dirname(assetPath) )
            self.kargs['root'][gafferNodeName] = eval( 'nodes.SAM%s%s()' % (assetPathParts[0], assetPathParts[1].capitalize()) )
            self.kargs['root'][gafferNodeName]['asset'].setValue( assetPath )
            ret = True
        return ret

    def doImportMaya(self, filename, nodeName, gpucache=False ):
        if m:
            # print( self.__setImportAsGPU )
            # print( gpucache )
            # print( filename )
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
                        pb.step()
                        if m.objExists( '%s.subdivScheme' % n ):
                            if not m.objExists(n + '.rman__torattr___subdivScheme'):
                                m.addAttr( n, ln="rman__torattr___subdivScheme", at="long" )
                            m.setAttr( n + '.rman__torattr___subdivScheme', m.getAttr( '%s.subdivScheme' % n ) )

                        if m.objExists( '%s.subdivFacevaryingInterp' % n ):
                            if not m.objExists(n + '.rman__torattr___subdivFacevaryingInterp'):
                                m.addAttr( n, ln="rman__torattr___subdivFacevaryingInterp", at="long" )
                            m.setAttr( n + '.rman__torattr___subdivFacevaryingInterp',  m.getAttr( '%s.subdivFacevaryingInterp' % n )  )

                    pb.close()


            # m.scriptJob( runOnce=True,  idleEvent=idleSetup )
            # assetUtils.mayaLazyScriptJob( runOnce=True,  idleEvent=alembic.fixDefaultUVSet() )
            maya.attachShadersLazy()
            alembic.fixDefaultUVSet()
            maya.setTimeSliderRangeToAvailableAnim()

            idleSetup()
            return True

        return False


    @staticmethod
    def cleanupOldVersions( self, nodeName ):
        maya.cleanupOldVersions( self, nodeName )

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
