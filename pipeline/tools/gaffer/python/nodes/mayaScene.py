##########################################################################
#
#  Copyright (c) 2015, John Haddon. All rights reserved.
#
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions are
#  met:
#
#      * Redistributions of source code must retain the above
#        copyright notice, this list of conditions and the following
#        disclaimer.
#
#      * Redistributions in binary form must reproduce the above
#        copyright notice, this list of conditions and the following
#        disclaimer in the documentation and/or other materials provided with
#        the distribution.
#
#      * Neither the name of John Haddon nor the names of
#        any other contributors to this software may be used to endorse or
#        promote products derived from this software without specific prior
#        written permission.
#
#  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
#  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
#  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
#  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
#  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
#  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
#  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
#  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
#  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
##########################################################################

import ast
import os
import sys

import IECore

import Gaffer
import GafferDispatch
import GafferScene
import GafferUI
import GafferSceneUI

import utils

import subprocess, psutil, select

import pipe
from pipe.bcolors import bcolors as colors

QtCore, QtGui = pipe.importQt()

sys._stdout = sys.stdout


class _StatePlugValueWidget( GafferUI.PlugValueWidget ) :

    def __init__( self, plug, *args, **kwargs) :

        row = GafferUI.ListContainer( GafferUI.ListContainer.Orientation.Vertical )
        GafferUI.PlugValueWidget.__init__( self, row, plug )

        with row:
            # self.__startPauseButton = GafferUI.Button( image = 'timelinePlay.png' )

            with GafferUI.ListContainer( GafferUI.ListContainer.Orientation.Horizontal ):
                self.__render = GafferUI.Button( image = 'timelinePlay.png', toolTip="Start/Pause/Refresh an IPR Render of the graph" )
                self.__stopButton = GafferUI.Button( image = 'timelineStop.png', toolTip="Stop IPR Render"  )
                self.__open = GafferUI.Button( image = 'Autodesk-maya-icon-edit_20.png', toolTip="Open the graph as a scene in Maya"   )
                self.__open._qtWidget().setMaximumSize( 30, 30 )

            # self.__startPauseClickedConnection = self.__startPauseButton.clickedSignal().connect( Gaffer.WeakMethod( self.__startPauseClicked ) )
            self.__openClickedConnection = self.__open.clickedSignal().connect( Gaffer.WeakMethod( self.__openClicked ) )
            self.__renderClickedConnection = self.__render.clickedSignal().connect( Gaffer.WeakMethod( self.__renderClicked ) )
            self.__stopClickedConnection = self.__stopButton.clickedSignal().connect( Gaffer.WeakMethod( self.__stopClicked ) )

        self.mayaRunning = None
        self._updateFromPlug()
        self.timer = QtCore.QTimer()


    def _updateFromPlug( self ) :

        with self.getContext() :
            state = self.getPlug().getValue()

        if state == GafferScene.InteractiveRender.State.Running :
            self.__render.setImage( 'timelinePause.png' )
            self.__stopButton.setEnabled( True )
        elif state == GafferScene.InteractiveRender.State.Paused :
            self.__render.setImage( 'timelinePlay.png' )
            self.__stopButton.setEnabled( True )
        elif state == GafferScene.InteractiveRender.State.Stopped :
            self.__render.setImage( 'timelinePlay.png' )
            self.__stopButton.setEnabled( False )

        self.__open.setEnabled( True )

    def __openClicked( self, button ) :

        scriptName = '/tmp/xx.mel'

        node = self.getPlug().parent()
        mayaCode = [
            'import maya.cmds as m',
            'def _gafferBundle_():',
            '   import assetUtils,genericAsset',
            '   import nodes',
            '   genericAsset.hostApp("maya")',
            '   nodes.mayaScene.bundleLoad(\''+node.networkAssets().replace('@app@','maya')+'\')',
            'm.scriptJob( runOnce=1, idleEvent=_gafferBundle_ )',
        ]
        f=open('%s.py' % os.path.splitext(scriptName)[0],'w')
        f.write('\n'.join(mayaCode)+'\n'*2)
        f.close()

        f=open(scriptName,'w')
        f.write('''python("exec(''.join(open('/tmp/xx.py').readlines()))");\n\n''')
        f.close()

        self.mayaRunning = subprocess.Popen("bash -l -c 'source %s/scripts/go && run maya -script \"%s\"     '" % (pipe.roots().tools(), os.path.abspath(scriptName)), shell=True )

        # os.system( 'run maya -script "%s" & ' %  scriptName )

    def __renderClicked( self, button ) :
        with self.getContext() :
            state = self.getPlug().getValue()

        # When setting the plug value here, we deliberately don't use an UndoContext.
        # Not enabling undo here is done so that users won't accidentally restart/stop their renderings.
        node = self.getPlug().parent()
        if state != GafferScene.InteractiveRender.State.Running:
            # self.getPlug().setValue( GafferScene.InteractiveRender.State.Running )
            node.startMayapy()
        else:
            # self.getPlug().setValue( GafferScene.InteractiveRender.State.Paused )
            node.mp_renderIPRStop()


    def __stopClicked( self, button ) :
        # self.getPlug().setValue( GafferScene.InteractiveRender.State.Stopped )

        node = self.getPlug().parent()
        node.stopMayapy()

GafferSceneUI.SAM_StatePlugValueWidget =_StatePlugValueWidget



class _ProgressWidget( GafferUI.PlugValueWidget ) :
    def __init__( self, plug, *args, **kwargs) :

        self.row = GafferUI.ListContainer( GafferUI.ListContainer.Orientation.Vertical )
        GafferUI.PlugValueWidget.__init__( self, self.row, plug )

        # row[0].setVisible(False)
        with self.row:
            self.__progress = GafferUI.ProgressBar( 0, (0, plug.getValue().y) )
            # self.__progress._qtWidget().setMaximumSize( 1000, 30 )

        self.__progress._qtWidget().setFormat('')
        self._updateFromPlug()


    def _updateFromPlug( self ) :
        with self.getContext() :
            value = self.getPlug().getValue()

        # if value.x==0:
        #     self.row.setVisible(False)
        # else:
        #     self.row.setVisible(True)
        #
        self.__progress.setRange([0,value.y])
        self.__progress.setProgress(value.x)


GafferSceneUI.SAM_ProgressPlugValueWidget =_ProgressWidget



class mayaScene( GafferScene.SceneNode ) :

    def __init__( self, name = "maya" ) :
        from mergeNode import Merge

        super(mayaScene,self).__init__( name )

        self['RendermanIPR'] = Gaffer.IntPlug( defaultValue = GafferScene.InteractiveRender.State.Stopped, flags =  Gaffer.Plug.Flags.Default & ~Gaffer.Plug.Flags.Serialisable )


        # self.addChild( GafferScene.ScenePlug( "out", Gaffer.Plug.Direction.Out ) )
        self.addChild( Gaffer.ArrayPlug( "in", Gaffer.Plug.Direction.In, element = GafferScene.ScenePlug( "in0" ) ) )
        # self.addChild( GafferScene.ScenePlug( "sceneIn", Gaffer.Plug.Direction.In ) )


        self['progressBar'          ] = Gaffer.V2iPlug( defaultValue = IECore.V2i(0,1), flags =  Gaffer.Plug.Flags.Default & ~Gaffer.Plug.Flags.Serialisable )
        self['progressBarMayaPY'    ] = Gaffer.V2iPlug( defaultValue = IECore.V2i(0,1), flags =  Gaffer.Plug.Flags.Default & ~Gaffer.Plug.Flags.Serialisable )
        self['progressBarSceneLoad' ] = Gaffer.V2iPlug( defaultValue = IECore.V2i(0,1), flags =  Gaffer.Plug.Flags.Default & ~Gaffer.Plug.Flags.Serialisable )
        self['progressBarIPR'       ] = Gaffer.V2iPlug( defaultValue = IECore.V2i(0,1), flags =  Gaffer.Plug.Flags.Default & ~Gaffer.Plug.Flags.Serialisable )

        self['AutomaticallyUpdateGeometry'] = Gaffer.BoolPlug( defaultValue = True )

        self.stopMayapy()
        self.timer = QtCore.QTimer()
        # self.addChild( Gaffer.StringPlug( "fileName" ) )
        # self.addChild( Gaffer.ObjectPlug( "out", Gaffer.Plug.Direction.Out, IECore.NullObject.defaultNullObject() ) )
        # self.addChild( Gaffer.ScenePlug( "scene", Gaffer.Plug.Direction.Out, IECore.NullScene.defaultNullScene() ) )

        self.currentFrame = 10

        self['__merge'] = Merge()
        self['__merge']['in'].setInput( self['in'] )

        self["out"].setInput( self["__merge"]["out"] )

        self.stopMayapy()

        self.__last_c_transfrom = None

    # def affects( self, input ) :
    #     outputs = Gaffer.ComputeNode.affects( self, input )
    #     if input.isSame( self['in'][0] ) :
    #         outputs.append( self["out"] )
    #
    #     return outputs
    #
    # def hash( self, output, context, h ) :
    #     assert( output.isSame( self["out"] ) )
    #     for plug in self['in']:
    #         plug.hash( h )
    #
    #     self['progressBar'].hash( h )

    def networkAssets( self ):
        ret = []
        for node in utils.setToAssetList( self ):
            ret += [ '[ { "op" : assetUtils.assetOP("%s","@app@"), "node":"%s", "enable": %s, "frame" : %s} ]' % ( node, node, True, self.scriptNode().context().getFrame() ) ]
        return '+'.join( ret )

    def execute(self):
        print 'bum'

    def compute( self, plug, context ) :
        assert( plug.isSame( self["out"] ) )

        with context:
            print self['sceneIn']['childNames'].getValue()

        ret = [ '%s' % p.getValue() for p in self['in'] if p.getValue().strip() ]
        plug.setValue( '+'.join(ret) )

    def _idx(self, stdout):
        idx = []
        if '__mayapy__' in stdout:
            idx += ['progressBarMayaPY']
        if '__load__' in stdout:
            idx += ['progressBarSceneLoad']
        if '__IPR__' in stdout:
            idx += ['progressBarIPR']
        return idx

    def progressMax(self, value=None, stdout=''):
        idxz = self._idx(stdout)
        ret = {}
        if value:
            for idx in idxz:
                self[idx].setValue( IECore.V2i(0,value) )
                ret[idx] = self[idx].getValue().y
            self.__prman_running = False
        return ret

    def progressStep(self, stdout):
        idxz = self._idx(stdout)
        for idx in idxz:
            self[idx].setValue( self[idx].getValue() + IECore.V2i(1,0) )

    def progressDone(self, stdout):
        idxz = self._idx(stdout)
        for idx in idxz:
            y = self[idx].getValue().y
            self[idx].setValue( IECore.V2i(y,y) )
            if idx is 'progressBarIPR':
                self.__prman_running = True

    def progressClose(self, stdout):
        idxz = self._idx(stdout)
        for idx in idxz:
            self[idx].setValue( IECore.V2i(0,10) )

    def doImport(self):
        import assetUtils
        reload(assetUtils)
        nodes = eval( self.networkAssets() )
        for node in nodes:
            node.doImport()
        return nodes

    def do( self ) :
        f = open("/tmp/xx.py",'w')
        f.write('''
        import assetUtils, sys
        import maya.standalone
        maya.standalone.initialize()
        import maya.cmds as m
        m.file(rename="/tmp/xx.ma")
        nodes = []
        %s
        for node in nodes:
            if node.path:
                node.doImport()
        m.file( save=True, type='mayaAscii' )
        ''' % ''.join([ '\nnodes += '+x for x in self.networkAssets().split('+') ]))
        f.close()



    def updateMayapy(self):
        if hasattr(self, 'mayapy') and self.mayapy.poll() is None:
            if self.__lastFrame != self.scriptNode().context().getFrame():
                if self['AutomaticallyUpdateGeometry'] .getValue():
                    self.mp_renderIPRStop()
                    self.mp_renderIPR()
                else:
                    mcmd = 'm.currentTime(%s, e=1)' % self.scriptNode().context().getFrame()
                    print mcmd
                    self.mp( mcmd )
                return

            self.mp_syncronizeViewerWithMayaPersp()
            # nodes = self.networkAssets().replace('@app@','gaffer')
            # # print nodes
            # if nodes.strip():
            #     import assetUtils
            #     for node in eval(nodes):
            #         mcmd = '[ m.setAttr( x+".visibility" , int(%s) ) for x in m.ls("|%s*") ]' % (node['enable'], '_'.join(node['op'].nodeName().split('_')[:-4]) )
            #         print mcmd
            #         self.mp( mcmd )



    def stopMayapy(self):
        if hasattr(self, 'mayapy') and self.mayapy.poll() is None:
            process = psutil.Process( self.mayapy.pid )
            for p in process.children(recursive=True):
                try: p.send_signal(9)
                except: pass
            self.mayapy.kill()

        self.mp_renderIPRStop()
        if hasattr(self, 'thread'):
            del self.thread

        self.progressClose( '__IPR__ __mayapy__ __load__' )
        # self['progressBar'].setValue(  IECore.V2i(0,0) )
        self['RendermanIPR'].setValue( GafferScene.InteractiveRender.State.Stopped )

    def startMayapy(self):
        # Create subprocess with pipes for stdin and stdout


        # switch the button
        self['RendermanIPR'].setValue( GafferScene.InteractiveRender.State.Running )

        self.__lastGraph = self.networkAssets()

        if not hasattr(self, 'mayapy') or self.mayapy.poll()!=None:
            self.progressMax( 3, '__progressStep__mayapy__' )

            self.__lastFrame = self.scriptNode().context().getFrame()
            self.mayapy = subprocess.Popen("echo '%s' ; bash -l -c 'echo __progressStep__mayapy__ ; source /atomo/pipeline/tools/scripts/go && run mayapy -i ;'" % ("="*80), stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True )#, bufsize=128)
            # self.mayapy = subprocess.Popen('''/usr/bin/python2 -c "import pipe;pipe.apps.maya().run('mayapy')" -i ;''', stdin=subprocess.PIPE,  shell=True, bufsize=128)
            # node.mayapy.communicate("exec(open('%s'))" % scriptName)
            # node.mayapy.communicate(node.mayaCode)

            # we need to init maya before anything or else IECore and Gaffer won't work
            self.mp("print '__progressStep__mayapy__'")
            self.mp("import os,sys")
            self.mp("from time import time")

            self.mp("t=time()")
            self.mp("import pymel.core")
            self.mp("print '__progressStep__mayapy__'")
            self.mp("import maya.cmds as m")
            self.mp("from maya.mel import eval as meval")

            self.mp("sys.tmaya = time()-t")
            self.mp("print '='*100")
            self.mp("print 'Maya initialization:', sys.tmaya")
            self.mp("print '='*100")
            self.mp("print '__progressDone__mayapy__'")

            # we use this so the button doesn't turn to pause before prman starts!
            self.__prman_running = False

            def monitorMayaPy():
                '''
                this is the thread core that monitors maya python
                it returns True to keep the thread running.
                returning False terminates the thread!
                '''
                # safeguard in case something crashes when starting a render!
                if not hasattr(self, 'mayapy') or self.mayapy.poll()!=None:
                    self.pool.append( ( self['RendermanIPR'].setValue, GafferScene.InteractiveRender.State.Stopped ) )
                    self.pool.append( self.stopMayapy )
                    return False


                # check if the graph changed, and trigger an update!
                if self.__lastGraph != self.networkAssets():
                    if 'update' not in str(self.pool):
                        self.pool.append( self.updateMayapy )
                    self.__lastGraph = self.networkAssets()
                    return True

                # check if the current time changed and trigger an update
                if self.__lastFrame != self.scriptNode().context().getFrame():
                    if 'update' not in str(self.pool):
                        self.pool.append( self.updateMayapy )
                    self.__lastFrame = self.scriptNode().context().getFrame()
                    return True

                _stderr = self.mpReadErr()
                _stdout = self.mpRead()
                if _stdout:
                    for stdout in  _stdout.split('\n'):
                        if stdout.strip() and 'OK' not in stdout:
                            if '__progressStep__' in stdout:
                                self.pool.append( ( self.progressStep, stdout) )
                            elif '__progressDone__' in stdout:
                                self.pool.append( ( self.progressDone, stdout) )
                            else:
                                sys._stdout.write(colors.GREEN + 'MAYA: ' + colors.BLUE + stdout + colors.END + '\n')
                                sys._stdout.flush()

                if _stderr:
                    if _stderr.strip():
                        hideErrors = [
                            'creating shelf directory:',
                            '.tcl',
                            'not supported in batch mode',
                            'rfm Notice: Found: ',
                            'was not found on MAYA_PLUG_IN_PATH',
                            'Warning:',
                            ' is already connected to',
                            'Error: line 1: ',
                            'Error: Non-deletable node',
                        ]
                        for stderr in  _stderr.split('\n'):
                            if stderr.strip() and stderr[:3] != '>>>' and not [ x for x in hideErrors if x in stderr ]:
                                sys._stdout.write(colors.GREEN + 'MAYA: ' + colors.FAIL +  stderr + colors.END + '\n' )
                        sys._stdout.flush()

                        fatal_errors = [
                            'Stack trace',
                            'Fatal Error. Attempting to save in',
                            'Broken pipe detected',
                        ]
                        if [x for x in fatal_errors if x in _stderr]:
                            self.pool.append( self.stopMayapy )
                            raise Exception("Maya Python crashed with the following error: \n\n"+_stderr)

                        if 'Broken pipe detected' in _stderr:
                            self.pool.append( self.stopMayapy )
                            raise Exception("Maya Python crashed with the following error: \n\n"+_stderr)




                self.mp()
                # if os.popen('pgrep -fa "bin/prman"').readlines():
                prman_processes = utils.ps('bin/prman')
                if prman_processes:
                    if not self.__prman_running:
                        self.pool.append( ( self['RendermanIPR'].setValue, GafferScene.InteractiveRender.State.Running ) )
                        self.__prman_running = True
                    else:
                        self.mp_syncronizeViewerWithMayaPersp()

                elif self.__prman_running:
                    self.pool.append( self.mp_renderIPRStop )
                    self.pool.append( ( self['RendermanIPR'].setValue, GafferScene.InteractiveRender.State.Paused ) )
                    self.pool.append( ( self.progressMax,  1, '__IPR__ __load__' ) )
                    self.__prman_running = False



                return True

            # we use threading to talk to maya python
            # so we don't block Gaffer
            import threading
            def thread():
                import time
                while monitorMayaPy():
                    time.sleep(1)
            self.thread = threading.Thread( target = thread )
            self.thread.start()

            # as we can't execute anything gaffer in a thread,
            # we use this pool list to pool functions to be executed in
            # an Gaffer idle event!
            self.pool = []
            def runInMainThread():
                import traceback
                update=[]
                while len(self.pool):
                    f = self.pool[0]

                    # if we already ran an update function, don't run another!
                    if 'update' in str(f):
                        functionName = str(f).split(' ')[2]
                        if functionName in update:
                            del self.pool[0]
                            continue
                        update += [functionName]

                    try:
                        if type(f) == type(()):
                            if len(f)>1:
                                f[0]( *f[1:] )
                            else:
                                f[0]()
                        else:
                            f()
                    except:
                        traceback.print_stack()

                    sys._stdout.write( str(f)+'\n' );sys._stdout.flush()
                    del self.pool[0]

                return True
            GafferUI.EventLoop.addIdleCallback( runInMainThread )

        self.mp()
        self.mp_bundleLoad()
        self.mp_syncronizeViewerWithMayaPersp()
        self.mp_renderIPR()
        # self.mp_renderIPRStop()
        # self.mp_renderIPR()


    def mpRead(self, retVal=''):
        ''' a function to read stdout from mayapy without blocking python execution '''
        if hasattr(self, 'mayapy') and self.mayapy.poll() is None:
            while (select.select([self.mayapy.stdout],[],[],0)[0]!=[]):
                retVal+=self.mayapy.stdout.read(1)
            return retVal

    def mpReadErr(self, retVal=''):
        ''' a function to read stdout from mayapy without blocking python execution '''
        if hasattr(self, 'mayapy') and self.mayapy.poll() is None:
            while (select.select([self.mayapy.stderr],[],[],0)[0]!=[]):
                retVal+=self.mayapy.stderr.read(1)
            return retVal

    def mp(self, cmd=None):
        if hasattr(self, 'mayapy') and self.mayapy.poll() is None:
            if cmd:
        	    self.mayapy.stdin.write(cmd+'\n')
        	    self.mayapy.stdin.flush()
            self.mayapy.stdin.write('print "OK"\n')
            self.mayapy.stdin.flush()

    def mp_bundleLoad(self, sceneName='bundle'):
            nodes =  self.networkAssets().replace('@app@','maya')

            self.progressMax( len( nodes.split('+') )+3, '__load__' )

            self.mp( "import  nodes" )
            self.mp( "reload(nodes)" )
            self.mp( "nodes.mayaScene.bundleLoad('%s', '%s')"  % (nodes,sceneName) )

    def mp_renderIPR(self, camera='perspShape'):
            cameras = utils.setToList( self, '__cameras')
            if cameras:
                camera = cameras[0]
            self.mp( "nodes.mayaScene.bundleRender(%s, camera='%s')" % (self.scriptNode().context().getFrame(), camera) )
            self.progressMax( 3, '__IPR__' )

    def mp_renderIPRStop(self):
            self.mp( "nodes.mayaScene.bundleRenderStop()" )
            self.progressClose( '__IPR__' )
            # kill any bin/prman processes found, just in case
            for p in utils.ps('bin/prman'):
                try: p.send_signal(9)
                except: pass


    def mp_syncronizeViewerWithMayaPersp(self):
            c=utils.viewerCameraParameters(self)
            if c and self.__last_c_transfrom != c[0]['camera'].getTransform().matrix:
                # c[0]['camera'].parameters().keys()
                # ['projection', 'clippingPlanes', 'resolution', 'pixelAspectRatio', 'screenWindow', 'cropWindow', 'shutter', 'projection:fov']
                mcmd = [
                    "m.setAttr('persp.translateX', %s)" % c[0]['translate'].x,
                    "m.setAttr('persp.translateY', %s)" % c[0]['translate'].y,
                    "m.setAttr('persp.translateZ', %s)" % c[0]['translate'].z,
                    "m.setAttr('persp.rotateX', %s)" % c[0]['rotate'].x,
                    "m.setAttr('persp.rotateY', %s)" % c[0]['rotate'].y,
                    "m.setAttr('persp.rotateZ', %s)" % c[0]['rotate'].z,
                    "m.setAttr('persp.scaleX', %s)" % c[0]['scale'].x,
                    "m.setAttr('persp.scaleY', %s)" % c[0]['scale'].y,
                    "m.setAttr('persp.scaleZ', %s)" % c[0]['scale'].z,
                ]
                if 'projection:fov' in c[0]['camera'].parameters().keys():
                    mcmd += [ "m.setAttr('persp.focalLength', %s)" % c[0]['camera'].parameters()['projection:fov'] ]

                self.__last_c_transfrom = c[0]['camera'].getTransform().matrix
                print ';'.join(mcmd)
                self.mp( ';'.join(mcmd) )




    @staticmethod
    def bundleLoad(gafferNodes, sceneName='bundle'):
        print "__progressStep__load__"
        import os,sys
        from time import time
        import maya.cmds as m
        from maya.mel import eval as meval

        t=time()

        meval('setCurrentRenderer("renderManRIS");')
        # meval('renderManExecCmdlineRender("", 1, 1, 0);')

        def _gafferBundle_():
            import traceback
            import genericAsset
            genericAsset.hostApp("maya")
            import assetUtils
            print gafferNodes
            nodes = eval( gafferNodes )
            print nodes[0]['op'].path
            print nodes[0]['op'].data
            for node in m.ls("|SAM_*"):
                m.setAttr( "%s.visibility" % node, 0)
            for node in nodes:
                print "="*80
                print node['op'].path
                print "-"*80
                try:
                    node['op'].hostApp('maya')
                    ns = node['op'].doesAssetExists()
                except:
                    from pprint import pprint
                    pprint( node['op'].data )
                    sys.stdout.flush()
                    traceback.print_exc(file=sys.stderr)
                    raise( Exception('') )
                if not ns and node['enable']:
                    node['op'].doImport()
                    print "#"*80

                for n in ns:
                    m.setAttr( "%s.visibility" % n, int(node['enable']) )

                print "__progressStep__load__"


        m.file(rename="%s.ma" % sceneName)
        #    m.file( force=True, type='mayaAscii', save=True )

        _gafferBundle_()
        tbundle=time()-t


        print "="*80
        print "Time to initialize maya:", sys.tmaya
        print "Time to construct bundle scene:", tbundle
        print "Total time before render:", tbundle+sys.tmaya
        print "="*80
        print "__progressDone__load__"

    @staticmethod
    def bundleRib(frame):
        from time import time
        import maya.cmds as m
        from maya.mel import eval as meval

        print "="*80
        trib=time()

        m.currentTime(frame,e=1)

        m.setAttr("defaultRenderGlobals.animation",l=0)
        m.setAttr("defaultRenderGlobals.animation", 1)

        meval("rmanDisconnectDstAttrs defaultRenderGlobals.startFrame;")
        m.setAttr('defaultRenderGlobals.startFrame',l=0)
        m.setAttr('defaultRenderGlobals.startFrame', frame)

        meval("rmanDisconnectDstAttrs defaultRenderGlobals.endFrame;")
        m.setAttr('defaultRenderGlobals.endFrame',l=0)
        m.setAttr('defaultRenderGlobals.endFrame', frame)

        m.setAttr("renderManRISGlobals.rman__riopt__Hider_incremental", 1)

        meval('optionVar -intValue "rmanPreviewDisplayStyle" 2;')
        # meval('renderManRender(640,480,1,1,"camera")')
        meval('setCurrentRenderer("renderManRIS");')
        meval('renderManExecCmdlineRender("", 1, 1, 0)')

        trib = time()-trib
        print "="*80
        print "Time to export rib:", trib

    @staticmethod
    def bundleRenderStop():
        from maya.mel import eval as meval
        meval('rmanRerenderStop()')

    @staticmethod
    def bundleRender(frame, camera='camera'):
        print "__progressStep__IPR__"
        import os
        from time import time
        import maya.cmds as m
        from maya.mel import eval as meval
        import pymel.core as pm

        trender =time()
        name = os.path.basename(os.path.splitext(m.file(q=1,sn=1))[0])
        if not name:
            name='untitled'

        m.currentTime(frame,e=1)

        camera = 'perspShape'

        # os.system('prman -progress -incremental 1 -d it %s/renderman/%s/rib/%04d/%04d.rib &' % ( m.workspace(q=1, rd=1), name, int(frame), int(frame)) )
        meval('setCurrentRenderer("renderManRIS");')
        meval('rmanSetRenderViewCamera("%s")' % camera)

        m.setAttr("defaultRenderGlobals.animation",l=0)
        m.setAttr("defaultRenderGlobals.animation", 1)

        meval("rmanDisconnectDstAttrs defaultRenderGlobals.startFrame;")
        m.setAttr('defaultRenderGlobals.startFrame',l=0)
        m.setAttr('defaultRenderGlobals.startFrame', frame)

        meval("rmanDisconnectDstAttrs defaultRenderGlobals.endFrame;")
        m.setAttr('defaultRenderGlobals.endFrame',l=0)
        m.setAttr('defaultRenderGlobals.endFrame', frame)

        m.setAttr("renderManRISGlobals.rman__riopt__Hider_incremental", 1)


        # check if we have a camera:
        # if not m.ls('|SAM_camera*'):
            # m.select( [ x for x in m.ls('|SAM_*') if 'lighting' not in x ] )
            # pm.viewFit( 'perspShape' )
            # meval('rmanSetRenderViewCamera("persp");')

        meval('rmanRerenderStart(0)')

        trender = time()-trender
        print "__progressStep__IPR__"

        print "="*80
        # print "Time to initialize maya:", tmaya
        # print "Time to construct bundle scene:", tbundle
        print "Time to start render:", trender
        print "="*80

        print '__progressDone__IPR__'



IECore.registerRunTimeTyped( mayaScene, typeName = "Gaffer::mayaScene" )
# Gaffer.ArrayPlug.enableInputGeneratorCompatibility( mayaScene )


Gaffer.Metadata.registerNode(

    mayaScene,

    "description",
    """
    The base type for all nodes which take an input scene and process it in some way.
    """,

    plugs = {
        "RendermanIPR" : [
            'label', '', # makes the progress bar fill up the parameter space!
            "description", "Action buttons to execute different functions.",
            "nodule:type", "",
            "plugValueWidget:type", "GafferSceneUI.SAM_StatePlugValueWidget",
            "plugValueWidget:divider", "1",
        ],
        "progressBar" : [
            'label', '', # makes the progress bar fill up the parameter space!
            "nodule:type", "",
            "plugValueWidget:type", "",
        ],
        "progressBarMayaPY" : [
            'label', 'maya startup', # makes the progress bar fill up the parameter space!
            "nodule:type", "",
            "plugValueWidget:type", "GafferSceneUI.SAM_ProgressPlugValueWidget",
        ],
        "progressBarSceneLoad" : [
            'label', 'scene load', # makes the progress bar fill up the parameter space!
            "nodule:type", "",
            "plugValueWidget:type", "GafferSceneUI.SAM_ProgressPlugValueWidget",
        ],
        "progressBarIPR" : [
            'label', 'IPR startup', # makes the progress bar fill up the parameter space!
            "nodule:type", "",
            "plugValueWidget:type", "GafferSceneUI.SAM_ProgressPlugValueWidget",
        ],

        "AutomaticallyUpdateGeometry" : [
            "label", 'Auto-Restart IPR',
            "nodule:type", "",
        ],

        "in" : [

            "description", lambda plug : "The input scene" + ( "s" if isinstance( plug, Gaffer.ArrayPlug ) else "" ),
            # "nodeGadget:nodulePosition", None,
            # "compoundNodule:orientation", "y",
            "nodule:type", "GafferUI::CompoundNodule",
            "plugValueWidget:type", "",
            "noduleLayout:spacing", 1.5,
        ],

        "out" : [

            "description","The processed output scene.",
            "nodule:type", "GafferUI::StandardNodule",
            "plugValueWidget:type", "",
            # "nodeGadget:nodulePosition", "right",

        ],
    },

)
Gaffer.Metadata.registerNodeValue( mayaScene, "nodeGadget:color", IECore.Color3f( 0.6, 0.1, 0.1 ) )
# Gaffer.Metadata.registerPlugValue( mayaScene, "in*", "nodule:color", IECore.Color3f( 0.45, 0.6, 0.3 ) )
# Gaffer.Metadata.registerPlugValue( mayaScene, "out", "nodule:color", IECore.Color3f( 0.45, 0.6, 0.3 ) )
Gaffer.Metadata.registerPlugValue( mayaScene, "in*", "nodule:color", IECore.Color3f( 0.2401, 0.3394, 0.485 ) )
Gaffer.Metadata.registerPlugValue( mayaScene, "out", "nodule:color", IECore.Color3f( 0.2401, 0.3394, 0.485 ) )

#
# import Gaffer
# import GafferScene
# import IECore
#
# Gaffer.Metadata.registerNodeValue( parent, "serialiser:milestoneVersion", 0, persistent=False )
# Gaffer.Metadata.registerNodeValue( parent, "serialiser:majorVersion", 31, persistent=False )
# Gaffer.Metadata.registerNodeValue( parent, "serialiser:minorVersion", 0, persistent=False )
# Gaffer.Metadata.registerNodeValue( parent, "serialiser:patchVersion", 0, persistent=False )
#
# __children = {}
#
# __children["AlembicSource"] = GafferScene.AlembicSource( "AlembicSource" )
# parent.addChild( __children["AlembicSource"] )
# __children["AlembicSource"].addChild( Gaffer.V2fPlug( "__uiPosition", defaultValue = IECore.V2f( 0, 0 ), flags = Gaffer.Plug.Flags.Default | Gaffer.Plug.Flags.Dynamic, ) )
# __children["AlembicSource"]["__uiPosition"].setValue( IECore.V2f( 4.11427307, 25.2008152 ) )
#
#
# del __children
#
