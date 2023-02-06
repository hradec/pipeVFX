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

# python3 workaround for reload
from __future__ import print_function
try: from importlib import reload
except: pass



import os
import sys
import re
import weakref
import threading

import IECore
import Gaffer
import GafferUI

import GafferSceneUI # for alembic previews
import GafferCortexUI # for alembic previews
import GafferCortex

import pipe
import opaClasses
#import pipeBrowser
import Asset
import samEditor
import timelineImage
import genericAsset

from opDialogue import OpDialogue

QtCore, QtGui = pipe.importQt()


try:
    import maya.cmds as m
    from maya.mel import eval as meval
    m.ls()
except:
    m = None

try:
    j = pipe.admin.job()
except:
    j=None


classes = Asset.AssetParameter().classLoader.classNames( "*" )


def populateAssets(filter="", folderName='sam'):
    from glob import glob
    ret = {}
    ret_sem_shot = {}
    zdata={}
    try:
        j = pipe.admin.job()
    except:
        j=None
    if j:
        isAsset = '/asset/' in j.shot().path()
        shot = j.shot().shot
        def recursiveTree(path, d={}, d2={}, f='',l=0):
            if l>=5:
                return d
            for each in glob( "%s/*" % path ):
                if f in each:
                    id = each.replace(path,'')[1:]
                    if os.path.isdir(each):
                        # try:
                        #     data = Asset.AssetParameter(each.replace(j.path('sam/'),'')).getData()
                        #     # id = id+" (%s)" % data['assetUser']
                        #     zdata[each] = data
                        # except:
                        #    pass
                        if l!=2 or len(id.split('.'))==1 or isAsset or shot == id.split('.')[0] :
                            # if l==2:
                            #     print shot ,id
                            # sys.stdout.flush()
                            id2 = ( id if id[0].isdigit() and len(id.split('.'))>2 else id.split('.')[-1] )
                            d[id] = {}
                            d2[id2] = {}
                            recursiveTree(each, d[id], d2[id2],l=l+1)
                            if l<3 and not d2[id2]:
                                del d[id]
                                del d2[id2]

                    #    d[id] = False
            return d

        ret = recursiveTree("%s/sam" % (j.path()), ret, ret_sem_shot, filter)
        # cleanup empty ones
        # for n in ret.keys():
        #     for i in ret[n].keys():
        #         if not ret[n][i]:
        #             del ret[n][i]
        #             del ret_sem_shot[n][i]
        #     if not ret[n]:
        #         del ret[n]
        #         del ret_sem_shot[n]
        # print ret
    return ret, ret_sem_shot, zdata


# gaffer browser preview!!
class assetPreview( GafferUI.DeferredPathPreview ) :
    def __init__( self, path ) :
        self.__column = GafferUI.ListContainer( borderWidth = 8 )
        GafferUI.DeferredPathPreview.__init__( self, self.__column, path )
        self._updateFromPath()
        self.__classLoader = IECore.ClassLoader.defaultOpLoader(  )
#        self.__classLoader = IECore.ClassLoader.defaultLoader( "IECORE_ASSET_OP_PATHS" )
        self.jobs = populateAssets()[0]
        # self.__node = GafferCortex.ParameterisedHolderNode()
        # self.__op = self.__classLoader.load( "asset/gather" )()
        # self.__node.setParameterised( self.__op )
        self.job = None
        if j:
            self.job = j

        self.browser = None

    def type(self, path):
        return os.path.dirname(os.path.dirname(str(path)))
    #
    def name(self, path):
        return os.path.basename(os.path.dirname(str(path)))

    def version(self, path):
        v = map( lambda x: int(x), os.path.basename(str(path)).split(' ')[0].split('.') )
        return IECore.V3i( v[0], v[1], v[2] )

    def isValid( self ) :
        path = str(self.getPath()['fullName'])
        # print( path )
        if not path:
            return False

        # print Asset.AssetParameter().classLoader.classNames( "*" )
        # return True
        # classes = Asset.AssetParameter().classLoader.classNames( "*" )
        # print path, '/'.join(path.strip('/').split('/')[0:2]) in classes, classes
        # sys.stdout.flush()
        # print( '/'.join(path.strip('/').split('/')[0:2]), classes )
        return '/'.join(path.strip('/').split('/')[0:2]) in classes

    def getPath(self):
        i = GafferUI.DeferredPathPreview.getPath(self).info()
        p = i['fullName']
        try:
            if not os.path.exists(self.job.path('sam/')+p):
                pp = p.split('/')
                if len(pp) > 2:
                    pp[2] = '%s.%s' % (self.job.shot().shot, pp[2])
                    p = '/'.join(pp)
        except:
            pass
        i['fullName'] = p
        return i

    def _load( self ) :
        return self.getPath()


    def _deferredUpdate( self, pathInfo ) :
        ''' Main Asset Preview tab '''
        # print "_deferredUpdate", pathInfo
        path = pathInfo['fullName']
        # sys.stdout.flush()
        self.parent().setCurrent(self)
        del self.__column[:]

        if not self.browser:
            self.browser = self.ancestor( GafferUI.SplitContainer ).browser


        # make this preview the default showed when an asset is clicked!
        self.__column.setVisible(False)
        self._previewCollum = GafferUI.SplitContainer( GafferUI.SplitContainer.Orientation.Horizontal )
        self.__column.append(self._previewCollum)
        row = GafferUI.SplitContainer( GafferUI.SplitContainer.Orientation.Vertical )
        self._previewCollum.append(row)

        if j:
            self.job  = j
            self.jobs = populateAssets()[0]

            data = Asset.AssetParameter(j.path('sam/')+str(path)).getData()
            # self.__node["parameters"]["Asset"]["info"]["name"].setValue( self.name(path) )
            if data:
                # self.__node["parameters"]["Asset"]["info"]["description"].setValue( data['assetDescription'] )

                # button = GafferUI.Button( "Publish new version of %s asset" % str(path) ) #, "arrowRight10.png" )
                # self.__column.append(button)

                # =====================================================================================
                # render/* asset
                # =====================================================================================
                if 'render/' in data['assetType']:
                    import glob

                    files = []
                    if os.path.exists("%s/images/.webplayer_montage" % data['path']):
                        files = glob.glob("%s/images/.webplayer_montage/*" % data['path'])
                    elif os.path.exists("%s/images/.webplayer" % data['path']):
                        files = glob.glob("%s/images/.webplayer/*" % data['path'])
                    elif not files:
                        files = glob.glob("%s/images/*" % data['path'])
                    files.sort()

                    self.__labelsAndTabs = []
                    # childTypes = GafferUI.PathPreviewWidget.types()


                    # print '--->', IECore.FileSequence( files[0] )
                    # 			filter = Gaffer.FileSystemPath.createStandardFilter(),

                    size = 600
                    row._qtWidget().setMinimumSize( size, 300 )

                    self.__script = Gaffer.ScriptNode()
                    self.__script["frameRange"]["start"].setValue(0)
                    self.__script["frameRange"]["end"].setValue(len(files)-1)
                    # self.__script.timelineChangedCallback = callback

                    self.oldFrame = -9999
                    def callback(frame):
                        if frame != self.oldFrame:
                            del displayPanel[:]
                            with displayPanel:
                                with GafferUI.SplitContainer( GafferUI.SplitContainer.Orientation.Vertical ) as layout:
                                    if len(files):
                                        if '.jpg' in files[int(frame)].lower():
                                            size = layout.ancestor( GafferUI.TabbedContainer ).size().x
                                            self.display = GafferUI.Label( "<img src='%s' width=%s>" % (files[int(frame)], size) )
                                            # self.display._qtWidget().setMinimumSize(400,300)
                                            # self.display._qtWidget().setMaximumSize(1500,500)
                                        else:
                                            self.display = GafferCortexUI.ImageReaderPathPreview( Gaffer.FileSystemPath( files[int(frame)] )  )
                                            self.display._updateFromPath()

                                    else:
                                        GafferUI.Label( "<img src='%s/gaffer/graphics/samNoFiles.png' width=%s height=%s>" % (pipe.roots.tools(), 800, 600)  )

                            if len(files):
                                txt.setText( "Previewing: %s" % files[int(frame)] )

                        self.oldFrame = frame


                    class Timeline( GafferUI.Timeline ) :
                        def setFrame( self, frame ) :
                            self.getContext().setFrame( frame )
                            callback( self.getContext().getFrame() )
                        def __valueChanged( self, widget, reason ) :
                            GafferUI.Timeline.__valueChanged( self, widget, reason )
                            callback( self.getContext().getFrame() )
                        def __incrementFrame( self, increment = 1 ) :
                            GafferUI.Timeline.__incrementFrame( self, increment )
                            callback( self.getContext().getFrame() )
                        def __startOrEndButtonClicked( self, button ) :
                            GafferUI.Timeline.__startOrEndButtonClicked( self, button )
                            callback( self.getContext().getFrame() )

                    with row:
                        displayPanel = GafferUI.SplitContainer( GafferUI.SplitContainer.Orientation.Horizontal )
                        # timeline = timelineImage.TimelineImage( self.__script )
                        timeline = Timeline( self.__script )
                        txt = GafferUI.Label( )
                        # txt._qtWidget().setMaximumSize( 1100, 10 )

                    timeline.setFrame(0)
                    callback(0)

                # =====================================================================================
                # */alembic asset preview
                # =====================================================================================
                elif 'alembic' in data['assetType'].split('/')[-1]:
                    import glob
                    abc = glob.glob("%s/*.abc" % data['path'])
                    with row :
                        if abc:
                            try:
                                class SceneReaderPathPreview( GafferSceneUI.SceneReaderPathPreview ) :
                                    def frameRange(self, start, end):
                                        start = int(start)
                                        end = int(end)
                                        self.__script.context().setFrame( start )
                                        self.__script["frameRange"]["start"].setValue( start )
                                        self.__script["frameRange"]["end"].setValue( end )
                                        GafferUI.Playback.acquire( self.__script.context() ).setFrameRange( start, end )

                                scene = SceneReaderPathPreview( Gaffer.FileSystemPath( abc[0] ) )
                                fr = data['assetClass']['FrameRange']['range'].value
                                scene.frameRange( fr.x, fr.y )
                                txt=GafferUI.Label(  "Previewing: %s" % abc[0] )
                                txt._qtWidget().setMaximumSize( 1100, 10 )
                            except:
                                GafferUI.Label( "<img src='%s/preview.jpg'>" % str(data['publishPath']) )
                                del row[0]
                        else:
                            GafferUI.Label( "<img src='%s/gaffer/graphics/samNoFiles.png' width=%s height=%s>" % (pipe.roots.tools(), 800, 600)  )

                # =====================================================================================
                # any asset - show the preview.jpg image in the asset folder, if one exists
                # =====================================================================================
                else:
                    with row:
                        size = row.ancestor( GafferUI.TabbedContainer ).size().x
                        self.display = GafferUI.Label( "<img src='%s/preview.jpg' width=%s >" % (str(data['publishPath']), size*0.5) )
                        # self.display = GafferUI.Label( "<img src='%s/preview.jpg' width=100% >" % (str(data['publishPath'])) )
                        # _data = [
                		# 	IECore.FloatVectorData( range( 0, 3 ) ),
                		# 	IECore.Color3fVectorData( [ IECore.Color3f( x ) for x in range( 0, 3 ) ] ),
                		# 	IECore.StringVectorData( [ str( x ) for x in range( 0, 3 ) ] ),
                		# 	IECore.IntVectorData( range( 0, 3 ) ),
                		# 	IECore.V3fVectorData( [ IECore.V3f( x ) for x in range( 0, 3 ) ] ),
                		# ]
                        # self.display = GafferUI.VectorDataWidget(_data)




                # =====================================================================================
                # publish mode - show "opa publish" in a splitview with the preview
                # =====================================================================================
                if hasattr(self.browser(), '_action') and 'publish' in self.browser()._action:
                    # if running in maya
                    if genericAsset.hostApp()=='maya' and m:
                        # and asset has meshPrimitives, select then
                        # print 'renderSettings/' not in data['assetType'],data['assetType']
                        if 'meshPrimitives' in data and 'renderSettings/' not in data['assetType']:
                            import assetUtils
                            with GafferUI.ErrorDialogue.ExceptionHandler( parentWindow=self.ancestor( GafferUI.Window ) ) :
                                # print data['mayaNodesLsMask']
                                try:
                                    m.select( data['mayaNodesLsMask'] )
                                except:
                                    raise Exception('''
                                        The original objects used to publish this asset where not found in the scene.

                                        Are you sure you're publishing to the right asset?

                                        Maybe you should publish a new asset for the selected objects?
                                    ''')
                    self._deferredUpdateOPA(self._loadOPA())
                    self._previewCollum.setSizes( [ 0.7, 0.3 ] )

                # =====================================================================================
                # Import mode - create buttons!
                # =====================================================================================
                elif hasattr(self.browser(), '_action') and 'import' in self.browser()._action:
                    with row:
                        with GafferUI.SplitContainer( GafferUI.SplitContainer.Orientation.Horizontal ) as blayout:
                            self.openButton = GafferUI.Button( "", "nautilus-45.png", toolTip="Open the asset folder with nautilus." )
                            self.openButton._qtWidget().setMaximumSize( 50, 50 )
                            self.openButton.asset = str(data['publishPath'])
                            self.openButton.data = data
                            self.openButton.app = 'nautilus'
                            self.openButton.cmd = 'nautilus %s'
                            self.openButton.path = data['publishPath']
                            self.openButton.event = self.openButton.clickedSignal().connect( self.openButtonFunc )

                            self.shellButton = GafferUI.Button( "", "shell.png", toolTip="Open a new shell in the asset folder." )
                            self.shellButton._qtWidget().setMaximumSize( 50, 50 )
                            self.shellButton.asset = str(data['publishPath'])
                            self.shellButton.data = data
                            self.shellButton.app = 'gnome-terminal'
                            self.shellButton.cmd = 'gnome-terminal --working-directory=%s'
                            self.shellButton.path = data['publishPath']
                            self.shellButton.event = self.shellButton.clickedSignal().connect( self.openButtonFunc )

                            if 'render' in data['assetType'].split('/')[0]:
                                if os.path.exists("%s/images/" % data['publishPath']):
                                    h = pipe.apps.houdini()
                                    self.rvButton = GafferUI.Button( "", "rv-45.png", toolTip="Play the image sequence in rv." )
                                    self.rvButton._qtWidget().setMaximumSize( 50, 50 )
                                    self.rvButton.asset = str(data['publishPath'])
                                    self.rvButton.data = data
                                    self.rvButton.app = 'maya'
                                    # self.rvButton.cmd = lambda x: os.system("run rv %s/images/* &" % data['publishPath'])
                                    # self.rvButton.cmd = lambda x: os.system("run mplay -p -M prev -g %s/images/* & " % data['publishPath'])
                                    self.rvButton.cmd = lambda x: os.system("LD_LIBRARY_PATH=%s %s -p -M prev -g %s/images/* " % (h['LD_LIBRARY_PATH'],h.path('/bin/mplay-bin'), data['publishPath']) )
                                    self.rvButton.copyToUserFolder = True
                                    self.rvButton.event = self.rvButton.clickedSignal().connect( self.openButtonFunc )
                                    self.rvButton.setEnabled(  len(glob.glob("%s/images/*" % data['publishPath'])) > 0 )

                                    self.rvButton = GafferUI.Button( "", "rv-45-montage.png", toolTip="Play the passes montage in rv." )
                                    self.rvButton._qtWidget().setMaximumSize( 50, 50 )
                                    self.rvButton.asset = str(data['publishPath'])
                                    self.rvButton.data = data
                                    self.rvButton.app = 'maya'
                                    self.rvButton.cmd = lambda x: os.system("LD_LIBRARY_PATH=%s %s -p -M prev  %s/images/.webplayer_montage/* " % (h['LD_LIBRARY_PATH'],h.path('/bin/mplay-bin'), data['publishPath']) )
                                    self.rvButton.copyToUserFolder = True
                                    self.rvButton.event = self.rvButton.clickedSignal().connect( self.openButtonFunc )
                                    self.rvButton.setEnabled(  len(glob.glob("%s/images/.webplayer_montage/*" % data['publishPath'])) > 0 )


                            self.importButton = GafferUI.Button( "%s" % str(data['publishPath']).split('sam/')[-1].strip('/'), 'samImport-45.png', toolTip="Import the asset in the current application!" )
                            self.importButton._qtWidget().setMaximumSize( 1100, 50 )
                            self.importButton.asset = str(data['publishPath'])
                            self.importButton.data = data
                            self.importButton.event = self.importButton.clickedSignal().connect( self.importButtonFunc )
                            self.importButton.setEnabled(False)
                            if m:
                                self.importButton.setEnabled(True)

                            # self.openButton = GafferUI.Button( "Open %s dependency file" % str(data['publishPath']).split('sam/')[-1].strip('/') )
                            if os.path.splitext( data['assetDependencyPath'] )[1].lower() in ['.mb', '.ma']:
                                userFolder = pipe.admin.job.shot.user().path('maya/scenes/')
                                self.openButton = GafferUI.Button( "", "Autodesk-maya-icon_48.png", toolTip="Open the maya scene used to create\n this asset in a new maya session!" )
                                self.openButton._qtWidget().setMaximumSize( 50, 50 )
                                self.openButton.asset = str(data['publishPath'])
                                self.openButton.data = data
                                self.openButton.app = 'maya'
                                self.openButton.cmd = 'run maya "%s"'
                                self.openButton.copyToFolder = userFolder
                                self.openButton.timeout = 15
                                self.openButton.event = self.openButton.clickedSignal().connect( self.openButtonFunc )

                                self.openInMayaButton = GafferUI.Button( "", "Autodesk-open-maya-icon_48.png", toolTip="Open the maya scene used to create\n this asset in the current maya seesion!" )
                                self.openInMayaButton._qtWidget().setMaximumSize( 50, 50 )
                                self.openInMayaButton.asset = str(data['publishPath'])
                                self.openInMayaButton.data = data
                                self.openInMayaButton.app = 'maya'
                                self.openInMayaButton.copyToFolder = userFolder
                                self.openInMayaButton.timeout = 15
                                self.openInMayaButton.event = self.openInMayaButton.clickedSignal().connect( self.openButtonFunc )
                                self.openInMayaButton.setEnabled(False)
                                if m:
                                    self.openInMayaButton.cmd = lambda x: m.file('%s' % x, f=1, o=1)
                                    self.openInMayaButton.setEnabled(True)

                        blayout._qtWidget().setMinimumSize( 300, 50 )

        self.__column.setVisible(True)

        # print "_deferredUpdate: Done"; sys.stdout.flush()

    def importButtonFunc( self, button ) :
        ''' Import Button main function - loads the asset class and run the doImport method!
        All import code is held in the asset class doImport method! '''
        with GafferUI.ErrorDialogue.ExceptionHandler( parentWindow=self.ancestor( GafferUI.Window ) ) :
            path = button.asset.split('sam/')[-1]
            op = self.loadOP( path, newVersion=0 )

            # load the type op so we can run it
            opNames = Asset.AssetParameter().classLoader.classNames( "*" + str(op.parameters()['Asset']['type'].getClass().path) )
            subOP = Asset.AssetParameter().classLoader.load(opNames[0])()
#            IECore.ParameterParser().parse( list( operands ), op.parameters() )
            for each in op.parameters()['Asset']['type'].keys():
                subOP.parameters()[each].setValue( op.parameters()['Asset']['type'][each].getValue() )

            subOP.doImport( button.asset, button.data)


    def openButtonFunc( self, button ) :
        '''
        Open Button main function - its actually a generic button which can be configured by button attributes:

            button.cmd          - if a string, it will do a os.system(button.cmd % dependencyScene ). If a function, it will call it as button.cmd(dependencyScene)
            button.path         - if exists, makes dependencyScene = button.path
            button.data         - holds the asset data dict
            button.app          - holds the name of the app this button comunicate to (maya, nuke, houdini, etc)
            button.copyToFolder - if the attribute Exists, it will copy the dependencyScene to the path specified and
                                  call button.cmd( button.copyToFolder / basename( dependencyScene ) )  or
                                  os.system( button.cmd % "button.copyToFolder / basename( dependencyScene )" )
        '''
        import subprocess, pprint
        with GafferUI.ErrorDialogue.ExceptionHandler( parentWindow=self.ancestor( GafferUI.Window ) ) :
            button.setHighlighted(False)
            button.setEnabled(False)

            if hasattr(button, 'path'):
                scene = button.path
            else:
                # other assets
                scene = "%s/%s" % (button.data['path'], os.path.basename(button.data['assetDependencyPath']))
                if not os.path.exists( scene ):
                    scene = button.data['assetDependencyPath']

                # render assets
                if os.path.exists( button.data['publishFile'] ):
                    scene = button.data['publishFile']

                # copy the dependency to the user folder, with a standard name that identifies the
                # asset and version
                if hasattr(button, 'copyToFolder'):
                    sceneUser = "%s/%s%s%s" % (button.copyToFolder, button.data['assetName'], button.data['assetVersion'].replace('.','_'), os.path.splitext(scene)[1])
                    if sceneUser != scene:
                        os.system('cp "%s" "%s"' % (scene, sceneUser) )
                    scene = sceneUser

            if type( button.cmd ) != str:
                button.cmd(scene)
            else:
                cmd = button.cmd.replace('"','\"') % scene +' &'
                print( cmd )
                os.system( cmd  )

            # wait a few seconds before enable the button again!
            def tick():
                button.setEnabled(True)
                pprint.pprint( button.data )
            timer = QtCore.QTimer()
            timer.singleShot( (3 if not hasattr( button, 'timeout') else button.timeout) * 1000,tick)
            sys.stdout.flush()



    def _loadOPA( self ) :
        return self.loadOP( str( self.getPath()['fullName'] ) )

    def loadOP( self, path, newVersion=1 ) :
        self.classType = '/'.join(path.split('/')[0:2])

        app = GafferCortex.ClassLoaderPath( IECore.ClassLoader.defaultOpLoader(), "/asset/publish" ).load()()
        # print app

        # load the type op so we can run it
        opNames = Asset.AssetParameter().classLoader.classNames( "*%s" % '/'.join(path.strip('/').split('/')[:2]) )
        # print app,opNames
        app.parameters()['Asset']['type'].setClass(opNames[0],1)

        try:
            j = pipe.admin.job()
        except:
            j=None

        if j:
            try:
                import maya.cmds as m
                from maya.mel import eval as meval
                # m.ls()
            except:
                m = None


            data = Asset.AssetParameter(j.path('sam/')+str(path)).getData()

            for each in data['assetClass'].keys():
                if each in app.parameters()['Asset']['type'].keys():
                    if app.parameters()['Asset']['type'][each].getValue() == app.parameters()['Asset']['type'][each].defaultValue:
                        app.parameters()['Asset']['type'][each].setValue( data['assetClass'][each] )

            for each in data['assetInfo'].keys():
                if 'version' in each:
                    from glob import glob
                    versions = glob("%s/../??.??.??" % data['path'])
                    versions.sort()
                    # print versions
                    v = [ int(x) for x in versions[-1].split('/')[-1].split('.') ]

                    app.parameters()['Asset']['info'][each].setValue( IECore.V3i(v[0], v[1]+newVersion, v[2]) )
                elif 'description' in each:
                    pass
                #     app.parameters()['Asset']['info'][each].setValue( "\n"+data['assetInfo'][each].value )
                else:
                    app.parameters()['Asset']['info'][each].setValue( data['assetInfo'][each] )


        # print "BUMM"
        app.parameters()['Asset'].parameterChanged()
        return app

    def _deferredUpdateOPA( self, op ) :
        # del self.__column[:]
        self.__node = GafferCortex.ParameterisedHolderNode()
        self.__node.setParameterised( op )
        with GafferUI.ErrorDialogue.ExceptionHandler( parentWindow=self.ancestor( GafferUI.Window ) ) :
            with self._previewCollum :
                with  GafferUI.ListContainer( borderWidth = 0, spacing = 0 ) as frame:
                    # opaClasses.pipeImage(op)
                    self.__nodeUI = GafferUI.NodeUI.create( self.__node )

                    button = GafferUI.Button( "Publish" )
                    self.__executeClickedConnection = button.clickedSignal().connect( self.__executeClicked )
                    frame._qtWidget().setMinimumSize(300,400)
                    frame._qtWidget().setMaximumSize(300,400)
                self._previewCollum._qtWidget().setMinimumSize(300,400)
                self._previewCollum._qtWidget().setMaximumSize(300,400)

    # def __executeClicked( self, button ) :
    #     self.__node.getParameterised()[0]()

    def __executeClicked( self, button ) :
        with GafferUI.ErrorDialogue.ExceptionHandler( parentWindow=self.ancestor( GafferUI.Window ) ) :
            self.__node.getParameterised()[0]()
            if m or hasattr(GafferUI,'root'):
                self.browser().parent().close()


class AssetMode(  samEditor.SamEditor.Mode ) :

    def __init__( self, browser ) :
        samEditor.SamEditor.Mode.__init__( self, browser )
        self.__classLoader = IECore.ClassLoader.defaultOpLoader()
        self.populateAssets()

    def populateAssets(self):
        try:
            self.assets = populateAssets(self.browser().filter())
        except:
            self.assets = populateAssets()

    def connect( self ) :
        self.qtreeView = self.browser().pathChooser().pathListingWidget()._qtWidget()
        # print self.qtreeView
        samEditor.SamEditor.Mode.connect( self )

        # expand the tree view!
        def recursiveExpand(assetsDict, prefix=''):
            if len(prefix.split('/'))<3:
                for each in assetsDict:
                    p="%s/%s" % (prefix, each)
                    self.browser().pathChooser().pathListingWidget().setPathExpanded(Gaffer.Path(p), True)
                    # self.browser().pathChooser().pathListingWidget().setSelectedPaths(Gaffer.Path(p))
                    # selectedRows = self.browser().pathChooser().pathListingWidget()._qtWidget().selectionModel().selectedRows()
                    # for r in  selectedRows:
                    #     print r, r.data()
                    # item.setBackground(0,QBrush(Qt.red,Qt.Dense6Pattern))
                    recursiveExpand(assetsDict[each], p)

        recursiveExpand( self.assets[0] )

        result = QtCore.QModelIndex()
        GafferUI._GafferUI._pathListingWidgetIndexForPath(
            GafferUI._qtAddress( self.qtreeView ),
            Gaffer.Path('/') ,
            GafferUI._qtAddress( result ),
        )

        # GafferUI._GafferUI._pathListingWidgetPropagateExpanded(
        #     GafferUI._qtAddress( self.qtreeView ),
        #     GafferUI._qtAddress( result ),
        #     True,
        #     2
        # )

        if hasattr(self.browser(), "_asset") and self.browser()._asset:
            self.browser().pathChooser().pathListingWidget().setSelectedPaths(Gaffer.Path(self.browser()._asset))
            splitContainer = self.browser().pathChooser().pathListingWidget().ancestor( GafferUI.SplitContainer )
            # self.browser().pathChooser().pathListingWidget()._qtWidget().setMinimumSize( 0, 400 )
            # self.browser().pathChooser().pathListingWidget()._qtWidget().setMaximumSize( 270, 1400 )
            splitContainer.setSizes( ( 0.0, 1.0 ) )
            # print dir(splitContainer)
            # print splitContainer[0].size()

        self.__pathSelectedConnection = self.browser().pathChooser().pathListingWidget().pathSelectedSignal().connect(
            Gaffer.WeakMethod( self.__pathSelected )
        )
        self.__contextMenuConnection  = self.browser().pathChooser().pathListingWidget().contextMenuSignal().connect(
            Gaffer.WeakMethod( self._menu )
        )


    def disconnect( self ) :
        # GafferUI.BrowserEditor.Mode.disconnect( self )
        samEditor.SamEditor.Mode.disconnect( self )
        self.__pathSelectedConnection = None
        self.__contextMenuConnection = None

    def _initialDisplayMode( self ) :
        return GafferUI.PathListingWidget.DisplayMode.Tree

    def _menu(self, pathListing):

        menuDefinition = IECore.MenuDefinition()

        selectedPaths = pathListing.getSelectedPaths()
        if len( selectedPaths ) == 1 :
        	self.parameterValue = selectedPaths[0]
        else :
        	self.parameterValue = selectedPaths

        def createNewInApp(app, value):
            os.system('run %s &' % app)

        def setCurrentVersion(value):
            sudo = pipe.admin.sudo()
            newCurrent = j.path('sam/%s' % value)
            sudo.toFile( str(newCurrent), '%s/current' % os.path.dirname(newCurrent) )
            sudo.run()

        def deleteVersion(value):
            sudo = pipe.admin.sudo()
            source = j.path( 'sam/%s' % value )
            target = j.path( 'sam/.deleted/%s' % value )
            sudo.cmd( "mkdir -p '%s'" % ( os.path.dirname(target) ) )
            sudo.cmd( '''su -c "mv '%s' '%s'" ''' % ( source, target ) )
            sudo.run()
            self.refresh()

        if not len( selectedPaths ):
            for app in ['Maya', 'Nuke', 'Houdini', 'Mudbox', 'ZBrush', 'Realflow', 'Mari']:
            	menuDefinition.append( "/Create new in %s" % app, { "command" : IECore.curry(createNewInApp, app.lower(), self.parameterValue ) } )
        elif len(str(selectedPaths[0]).split('/'))>2:
            menuDefinition.append( "/Set current version to %s" % os.path.basename(str(self.parameterValue)), { "command" : IECore.curry(setCurrentVersion, self.parameterValue ) } )
            menuDefinition.append( "/ " , { } )
            menuDefinition.append( "/Delete version %s" % os.path.basename(str(self.parameterValue)), { "command" : IECore.curry(deleteVersion, self.parameterValue ) } )

        self.__menu = GafferUI.Menu( menuDefinition )
        if len( menuDefinition.items() ) :
        	self.__menu.popup( parent = pathListing.ancestor( GafferUI.Window ) )

        return True

    # def _actionsSubMenu( self, parameterValue ) :
    #
    # 	menuDefinition = IECore.MenuDefinition()
    #
    # 	ops = self.__opMatcher.matches( parameterValue )
    # 	if len( ops ) :
    # 		for op, parameter in ops :
    # 			menuDefinition.append( "/%s (%s)" % ( op.typeName(), parameter.name ), { "command" : self.__opDialogueCommand( op ) } )
    # 	else :
    # 		menuDefinition.append( "/None available", { "active" : False } )
    #
    # 	return menuDefinition



    def __createOpMatcher( self ) :

        self.__opMatcher = None

    def __opDialogueCommand( self, op ) :

        def showDialogue( menu ) :

            dialogue = OpDialogue(
                op,
                postExecuteBehaviour = OpDialogue.PostExecuteBehaviour.Close,
                executeInBackground=True
            )
            dialogue.waitForResult( parentWindow = menu.ancestor( GafferUI.Window ) )

        return showDialogue

    def __pathSelected( self, pathListing ) :
        selectedPaths = pathListing.getSelectedPaths()
        # print( "======>",selectedPaths )
        sys.stdout.flush()
        if not len( selectedPaths ) :
            return

        # print selectedPaths[0]
#        op = selectedPaths[0].classLoader().load( str( selectedPaths[0] )[1:] )()
#        opaDialogue = opaClasses.OpaDialogue( op )
#        pathListing.ancestor( GafferUI.Window ).addChildWindow( opaDialogue )
#        opaDialogue.setVisible( True )


    def _initialPath( self ) :
        return Gaffer.DictPath( self.assets[0], "")

    def _initialColumns( self ) :
        class IconColumn( object ):
            def data(self, path, role = QtCore.Qt.DisplayRole ):
                print( "bum" )
                if  role == QtCore.Qt.DisplayRole:
                    return "status"
                return QtCore.QVariant()

            def headerData(self, role = QtCore.Qt.DisplayRole ):
                print( "bum2" )
                if  role == QtCore.Qt.DisplayRole:
                    return "status"
                return QtCore.QVariant()
        return list((
            GafferUI.PathListingWidget.StandardColumn("Asset Name", 'name'),
            # GafferUI._GafferUI._PathListingWidgetFileIconColumn(),
            # GafferUI.PathListingWidget.StandardColumn("Imported", 'imported'),
        ))

    def refresh(self):
        self.populateAssets()
        self.browser().pathChooser().pathListingWidget().setPath(Gaffer.Path("/"))
        self.browser().pathChooser().pathListingWidget().setPath(self._initialPath())
        result = QtCore.QModelIndex()
        GafferUI._GafferUI._pathListingWidgetPropagateExpanded(
            GafferUI._qtAddress( self.qtreeView ),
            GafferUI._qtAddress( result ),
            True,
            2
        )





# GafferUI.PathPreviewWidget.registerType( "Asset Preview", assetPreview )
GafferUI.BrowserEditor.registerMode( "SAM", AssetMode )
GafferUI.BrowserEditor.AssetMode = AssetMode


GafferUI.PathPreviewWidget.registerType( "Asset Preview", assetPreview )
samEditor.SamEditor.registerMode( "SAM", AssetMode )
samEditor.SamEditor.AssetMode = AssetMode
