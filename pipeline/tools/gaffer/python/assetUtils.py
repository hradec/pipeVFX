


import IECore
import Gaffer
import GafferCortex
import GafferUI
import Asset
import pipe
import os

if 'OCIO' in os.environ and not os.path.exists(os.environ['OCIO']):
    del os.environ['OCIO']

try:
    import maya.cmds as m
    from maya.mel import eval as meval
    reload(Asset)
    # m.ls()
except:
    m = None

try:
    j = pipe.admin.job()
except:
    j=None



class types(object):
    def __init__(self, refresh=None):
        import genericAsset
        if '_types' not in globals() or refresh:
            globals()['_types'] = {}
            # print 'bum'
            for t in Asset.types(refresh=True):
                globals()['_types'][t] =  None

    def __loadOP(self, t):
        if not globals()['_types'][t]:
            import genericAsset
            globals()['_types'][t] = assetOP( t )
            globals()['_types'][t].hostApp = genericAsset.hostApp
            globals()['_types'][t].loadOP()

    def op(self, assetType):
        self.__loadOP(assetType)
        return globals()['_types'][assetType]

    def whoCanPublish(self, assetType):
        self.__loadOP(assetType)
        return globals()['_types'][assetType].whoCanPublish()

    def whoCanImport(self, assetType):
        self.__loadOP(assetType)
        return globals()['_types'][assetType].whoCanImport()

    def keys(self):
        k = globals()['_types'].keys()
        k.sort()
        return k

    def color(self, assetType):
        self.__loadOP(assetType)
        return globals()['_types'][assetType].color()


class shelf(object):
    def __init__(self, name='SAM'):
        self.name = name
        self.buttons = []

    def create(self):
        self.addShelf()
        for button in self.buttons:
            button()
        self.selectShelf()
        shelf._fixOptionVars()

    @staticmethod
    def _fixOptionVars():
        # fix optionVars
        import pymel.core as pm
        import maya.mel as mel
        import maya.cmds as m

        ids = [x for x in m.optionVar(l=1) if 'shelfName' in x or 'shelfVers' in x or 'shelfFile' in x or 'shelfLoad' in x or 'shelfAlign' in x]
        ids.sort()
        for n in ids:
            print n, m.optionVar(q=n)
            m.optionVar(rm=n)

        topLevelShelf = mel.eval('string $m = $gShelfTopLevel')
        shelves = pm.shelfTabLayout(topLevelShelf, query=True, tabLabelIndex=True)
        for index, shelf in enumerate(shelves):
            pm.optionVar(stringValue=('shelfName%d' % (index+1), str(shelf)))
            pm.optionVar(stringValue=('shelfLoad%d' % (index+1), 1))
            pm.optionVar(stringValue=('shelfFile%d' % (index+1), 'shelf_'+str(shelf)))
            pm.optionVar(stringValue=('shelfAlign%d' % (index+1), 'left'))
            print index+1,shelf

        ids = [x for x in m.optionVar(l=1) if 'shelfName' in x or 'shelfVers' in x or 'shelfFile' in x or 'shelfLoad' in x or 'shelfAlign' in x]
        ids.sort()
        for n in ids:
            print n, m.optionVar(q=n)


    def addShelf(self):
        if m:
            meval('if (`shelfLayout -exists %s `) deleteUI %s;' % (self.name,self.name))
            # shelfTab = meval('global string $gShelfTopLevel;$tempMelVar=$gShelfTopLevel')
            # m.shelfLayout( self.name, cellWidth=33, cellHeight=33, p=shelfTab,preventOverride=1 )
            meval('global string $scriptsShelf;')
            meval('$scriptsShelf = `shelfLayout -cellWidth 33 -cellHeight 33 -p $gShelfTopLevel %s`;' % self.name)

    def selectShelf(self):
        if m:
            shelfTab = meval('global string $gShelfTopLevel;$tempMelVar=$gShelfTopLevel')
            m.shelfTabLayout(shelfTab,selectTab=self.name,e=1)

    def addShelfButton(self, button_name, help, icon="menuIconWindow.png", cmd="", python=True, menu=(), extra={}, enable=1):
        if m:
            if not python:
                sourceType = "mel"
            else:
                sourceType = "python"
            self.buttons.append(
                lambda: m.shelfButton(
                        enableCommandRepeat=1,
                        enable=enable,
                        width=35,
                        height=35,
                        manage=1,
                        visible=1,
                        preventOverride=1,
                        annotation=help,
                        command=cmd,
                        enableBackground=0,
                        align="center",
                        label=button_name,
                        labelOffset=0,
                        font="plainLabelFont",
                        imageOverlayLabel=button_name,
                        image=icon,
                        image1=icon,
                        style="iconOnly",
                        marginWidth=1,
                        marginHeight=1,
                        sourceType=sourceType,
                        commandRepeatable=1,
                        flat=1,
                        mip=range(len(menu)),
                        mi=menu,
                        overlayLabelColor=(0.854,0.950917,1),
                        overlayLabelBackColor=(0,0,0,0.3),
                )
            )



def __scriptJob( **kk ):
    if m.about(batch=1):
        if 'idleEvent' in kk:
            print "====>",kk['idleEvent']
            kk['idleEvent']()
    else:
        m.scriptJob( **kk )

def mayaLazyScriptJob( runOnce=True,  idleEvent=None, deleteEvent=None, allowOnlyOne=True, event=None):
    if m:
        _jobs=[]
        if allowOnlyOne:
            _jobs = m.scriptJob(listJobs=True)
        if deleteEvent:
            if _jobs:
                jobs =  [ str(x).strip().split(':') for x in _jobs if deleteEvent.func_name in x ]
                for job in jobs:
                    m.scriptJob( kill=int(job[0]), force=True )
            __scriptJob( runOnce=runOnce,  ct=["delete", deleteEvent ] )
            # print [ str(x).strip().split(':') for x in m.scriptJob(listJobs=True) if deleteEvent.func_name in x ]
        if idleEvent:
            # print '====>',idleEvent.func_name
            if _jobs:
                jobs =  [ str(x).strip().split(':') for x in _jobs if idleEvent.func_name in x ]
                for job in jobs:
                    m.scriptJob( kill=int(job[0]), force=True )
            __scriptJob( runOnce=runOnce,  idleEvent=idleEvent )
            # print [ str(x).strip().split(':') for x in m.scriptJob(listJobs=True) if idleEvent.func_name in x ]

        if event:
            # print '====>',idleEvent.func_name
            if _jobs:
                jobs =  [ str(x).strip().split(':') for x in _jobs if event[1].func_name in x and "'%s'" % event[0] in x ]
                for job in jobs:
                    m.scriptJob( kill=int(job[0]), force=True )
            __scriptJob( runOnce=runOnce,  event=event )
            # print [ str(x).strip().split(':') for x in m.scriptJob(listJobs=True) if event[1].func_name in x ]



__publishOP__ = GafferCortex.ClassLoaderPath( IECore.ClassLoader.defaultOpLoader(), "/asset/publish" ).load()
def loadAssetOP( path, newVersion=1, data=None ) :
    classType = '/'.join(path.split('/')[0:2])

    app = __publishOP__()

    # load the type op so we can run it
    opNames = Asset.AssetParameter().classLoader.classNames( "*%s" % '/'.join(path.split('/')[:2]) )
    app.parameters()['Asset']['type'].setClass(opNames[0],0)

    if j:
        if not data:
            data = Asset.AssetParameter(path).getData()
        if data:
            app.parameters()['Asset']['info'].setValue( data['assetInfo'] )
            app.parameters()['Asset']['type'].setValue( data['assetClass'] )
        else:
            data['assetType'] = '/'.join( path.strip('/').split('/')[:2] )

    # we get the subClass direct from the classParameter, so it comes with all the data!
    app.typeOP = app.parameters()['Asset']['type'].getClass()
    return app



class assetOP(object):
    @staticmethod
    def _fixShotPath(path):
        if j and '/assets/' not in j.shot().path():
            # fix a shot relative path, if needed!
            shot = j.shot().shot
            if [ p for p in path.split('/') if shot in p[0:(len(shot)+1)] ]:
                path = path.replace(shot+'_', shot+'.')
            path = j.path('sam/')+str(path).split('sam/')[-1]
        return path


    def __init__( self, path, hostApp='gaffer', data=None ) :
        ''' load an asset op class, fills up with the asset data, and returns the object ready to run methods '''
        self.asset = Asset.AssetParameter( assetOP._fixShotPath(path) )
        try:
            self.data = data
            self.__data()
            self.path = str(self.data['publishPath'])
        except:
            self.data = None
            self.path = None
        self.pathPar = path
        self.__maya_ls = None
        self.op = None
        self.subOP = None
        self.__hostApp = hostApp
        self.types = types()

    def hostApp(self, app=None):
        if app:
            self.__hostApp = app
        return self.__hostApp

    def __data(self):
        if not self.data:
            # import samDB
            # db=samDB.asset2()
            # self.data = db[self.pathPar]
            self.data =  self.asset.getData()

    def color(self):
        ret =  IECore.Color3f( 0.2, 0.25, 0.30 )  #IECore.Color3f( 0.2401, 0.3394, 0.485 )
        if self.loadOP():
            if hasattr(self.subOP, '_color'):
                ret = self.subOP._color
        return ret


    def newPublish(self):
        import os
        if m:
            import samPrman
            samPrman.stopIPR()

        os.environ['PIPE_PUBLISH_FILTER'] = self.pathPar
        appLoader = IECore.ClassLoader.defaultLoader( "GAFFER_APP_PATHS" )
        appLoader.refresh()
        appLoader.classNames()
        app = appLoader.load( 'opa' )()
        app.hostApp( self.hostApp() )
        app.parameters()['arguments'] = IECore.StringVectorData(['-Asset.type',self.pathPar,'0','IECORE_ASSET_OP_PATHS'])
        app.parameters()['op'] = 'publish'
        app.parameters()['gui'] = 1
        print 'newPublish:',app.hostApp(),self.hostApp()
        app.run()

        # self.ancestor( GafferUI.Window ).close()

    def updatePublish(self):
        self.__data()
        if self.data:
            if m:
                import samPrman
                reload(samPrman)
                samPrman.stopIPR()

            import IECore
            c = IECore.ClassLoader.defaultLoader( "GAFFER_APP_PATHS" )
            c.refresh()
            a = c.load( "sam" )()
            a.hostApp( self.hostApp() )
            a.parameters()['type'] = self.pathPar.split('/')[0]
            a.parameters()['buttons'] = '/'.join(self.pathPar.split('/')[:2])
            a.parameters()['action'] = 'publish'
            a.parameters()['asset'] = self.pathPar
            a.hostApp(self.hostApp())
            a.run()


    def loadOP( self ):
        self.__data()
        if not self.subOP:
            import genericAsset
            genericAsset.hostApp(self.hostApp())
            self.op     = loadAssetOP( self.pathPar, newVersion=0, data=self.data )
            self.subOP  = self.op.typeOP

        return True if self.subOP else False


    def mayaLastLs( self ):
        return self.__maya_ls


    def assetSourceExistsInHost( self ):
        self.__data()

        if self.hostApp()=='maya' and m:
            if len(self.pathPar.split('/'))>2 and self.data and 'meshPrimitives' in self.data:
                selection = m.ls(self.data['meshPrimitives'], l=1)
                if 'renderSettings/maya' in self.pathPar:
                    return selection

                return selection if self.data['meshPrimitives']==selection else []

        elif self.hostApp()=='gaffer' and hasattr(GafferUI, 'root'):
            ret = []
            if GafferUI.root().asset :
                ret = os.path.dirname(self.pathPar) in GafferUI.root().asset
            else:
                ret = 'gaffer/' in self.pathPar
            return ret

        return False


    def nodes( self ):
        import re
        if self.path and self.hostApp()=='maya' and m and len(self.pathPar.split('/'))>2:
            self.__maya_ls = m.ls('|SAM*',l=1)
            nodeName = '_'.join(self.path.split('sam/')[-1].split('/')[:-1]).replace('.','_')
            versionPosition = re.search('_\d\d_\d\d_\d\d', nodeName).start()
            # mask = '^\|SAM_%s_\d\d_\d\d_\d\d_' % ( nodeName[:versionPosition] )
            return m.ls( '|SAM_%s*_??_??_??_*' % nodeName[:versionPosition], l=1 )
        return []


    def selectNodes( self ):
        import re
        if self.hostApp()=='maya' and m and len(self.pathPar.split('/'))>2:
            assetLS = self.nodes()
            if hasattr(self.types.op('/'.join(self.pathPar.split('/')[:2])), 'childrenNodes'):
                if self.loadOP():
                    assetLS += self.subOP.childrenNodes(assetLS)
            if assetLS:
                m.select(assetLS, add=1)


    def canImport( self ):
        if self.loadOP():
            if self.hostApp()=='maya' and m and 'maya' in self.subOP._whoCanImport:
                return True
            elif self.hostApp()=='gaffer' and hasattr(GafferUI, 'root') and 'gaffer' in self.subOP._whoCanImport:
                return True

        return False


    def whoCanImport( self ):
        if self.loadOP():
            return self.subOP._whoCanImport
        return []

    def whoCanOpen( self ):
        if self.loadOP():
            return self.subOP._whoCanOpen
        return []

    def whoCanPublish( self ):
        if self.loadOP():
            return self.subOP._whoCanPublish
        return []

    def assetDependencyFilename( self ):
        self.__data()
        return self.data['assetDependencyPath']

    def canPublish( self ):
        if self.loadOP():
            if self.hostApp()=='maya' and m and 'maya' in self.whoCanPublish():
                return True
            elif self.hostApp()=='gaffer' and hasattr(GafferUI, 'root') and 'gaffer' in self.whoCanPublish():
                return True

        return False

    def nodeName(self):
        self.__data()
        if self.loadOP():
            return self.subOP.nodeName(self.data)
        return ''

    def doesAssetExists(self, anyVersion=True):
        self.__data()
        if self.loadOP():
            return self.subOP.doesAssetExists( self.subOP.nodeName(self.data), anyVersion)
        return []

    def doImport( self ):
        ''' do a checkout of the asset into the current application '''
        self.__data()
        if self.loadOP():
            print self.pathPar
            print self.data.keys()
            self.subOP.doImport( self.path, self.data )
            if self.hostApp()=='maya' and m:
                self.__maya_ls = m.ls('|SAM*')


    def getJobShot(self):
        if self.data:
            assetJobPath = self.data['assetPath'].split('users')[0]
            job  = assetJobPath.split('jobs/')[1].split('/')[0]
            typ  = assetJobPath.split(job)[1].strip('/').split('/')[0]
            shot = assetJobPath.split(typ)[1].strip('/').split('/')[0]
            return {
                'path' : assetJobPath,
                'job'  : job,
                'type' : typ.rstrip('s'),
                'shot' : shot,
            }
        return {}

    def go(self):
        assetJobShot = self.getJobShot()
        if assetJobShot:
            if not hasattr(self, '_original_PIPE_JOB'):
                self._original_PIPE_JOB = os.environ['PIPE_JOB']
                self._original_PIPE_SHOT = os.environ['PIPE_SHOT']

            os.environ['PIPE_JOB']  = assetJobShot['job']
            os.environ['PIPE_SHOT'] = '%s@%s' % (assetJobShot['type'], assetJobShot['shot'])

    def goBack(self):
        if hasattr(self, '_original_PIPE_JOB'):
            os.environ['PIPE_JOB']  = self._original_PIPE_JOB
            os.environ['PIPE_SHOT'] = self._original_PIPE_SHOT

    @staticmethod
    def openScene(file, newFile=False):
        if not file.strip():
            return
        def __openScene():
            import maya.cmds as m
            import samPrman
            # if newFile:
            m.file(f=1, new=1)
            m.file('%s' % file, f=1, o=1)
            samPrman.setupRISGlobals()
        mayaLazyScriptJob( runOnce=True,  idleEvent=__openScene)

    def mayaImportDependency(self):
        self.__data()
        if self.hostApp()=='maya' and m:
            if self.data:
                self._openDependency( cmd=lambda x: assetOP.openScene(x, newFile=True) )
            else:
                raise Exception( "You first need to select an asset!" )

    def mayaOpenDependency(self):
        self._openDependency( cmd = '''run maya -command "python(\\\\\\"import assetUtils;assetUtils.assetOP.openScene\('%s'\)\\\\\\")" ''', app=pipe.apps.maya )

    def gafferOpenDependency(self):
        if self.hostApp()=='maya':
            def __runGaffer(scene):
                cmd = cmd='run gaffer test'
                if scene.strip():
                    cmd += ' -scripts "%s" -asset %s' % (scene, self.pathPar)
                print '===>',cmd
                os.system( cmd + ' &')

            def __runGafferInHost(scene):
                import IECore
                c = IECore.ClassLoader.defaultLoader( "GAFFER_APP_PATHS" )
                c.refresh()
                a = c.load( "test" )()
                if scene.strip():
                    a.parameters()['scripts'] = IECore.StringVectorData([scene])
                    a.parameters()['asset'] = IECore.StringVectorData([self.pathPar])
                a.hostApp('gaffer')
                a.run()
                a.setSize(6,6)

            __runGaffer = __runGafferInHost

        elif self.hostApp()=='gaffer':
            def __runGaffer(scene):
                s = GafferUI.root()['scripts'].keys()
                script = GafferUI.root()['scripts'][s[0]]
                script['fileName'].setValue( scene )
                script.load()
                ng = GafferUI.NodeGraph.acquire(script)
                ng.frame( script.selection() )

        self._openDependency( __runGaffer, copyToFolder=pipe.admin.job.shot.user().path('gaffer/'), app=pipe.apps.gaffer )


    def _openDependency( self, cmd = '''run maya -command "python(\\\\\\"import assetUtils;assetUtils.assetOP.openScene\('%s'\)\\\\\\")" ''', copyToFolder=pipe.admin.job.shot.user().path('maya/scenes/'), app=pipe.apps.maya ):
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
        # other assets
        from pprint import pprint
        import os
        # pprint(self.data)
        currentUserPath = pipe.admin.job.shot.user().path()

        jobData = self.getJobShot()

        # change the job/shot to the one in the asset
        self.go()

        scene = ''
        self.__data()
        if self.data:

            if jobData['path'] not in copyToFolder:
                lastBit = copyToFolder.replace( currentUserPath,'' ).strip('/')
                copyToFolder = '%s/%s/' % ( pipe.admin.job.shot.user().path(), lastBit )

            scene = "%s/%s" % (self.data['path'], os.path.basename(self.data['assetDependencyPath']))
            if not os.path.exists( scene ):
                scene = self.data['assetDependencyPath']

            # render assets
            if os.path.exists( self.data['publishFile'] ):
                scene = self.data['publishFile']

            # copy the dependency to the user folder, with a standard name that identifies the
            # asset and version
            if copyToFolder:
                sceneUser = "%s/%s%s%s" % (copyToFolder, self.data['assetName'], self.data['assetVersion'].replace('.','_'), os.path.splitext(scene)[1])
                if sceneUser != scene:
                    if app:
                        app()._userSetup()
                    os.system('cp "%s" "%s"' % (scene, sceneUser) )
                scene = sceneUser

        if type( cmd ) != str:
            cmd(scene)
        else:
            cmd = cmd.replace('"','\"') % scene +' &'
            print  '===>',cmd
            os.system( cmd  )

        # restore the job/shot to the original one
        self.goBack()

    def submission( self ):
        ''' publish calls submission to send to farm'''
        self.__data()
        if self.loadOP():
            self.subOP.data = self.data
            self.subOP.ribs = []
            self.subOP.renderPasses = []
            operands = {
                'mayaOutput' : self.subOP.data['assetClass']['mayaOutput'].value,
                'RenderEngine' : self.subOP.data['assetClass']['RenderEngine'].value,
                'FrameRange' : { 'range' :  self.subOP.data['assetClass']['FrameRange']['range'] },
            }
            self.subOP.submission( operands )
        #
        # data = self.data
        # assetPath           = str(data['assetPath'])
        # publishFile         = str(data['publishFile'])
        # publishPath         = str(data['publishPath'])
        # mayaOutput          = str(operands['mayaOutput'])
        # render              = str(operands['RenderEngine'])
        # frameRange          = operands['FrameRange']['range'].value
        #
        # if render != '3delight':
        #     render = m.getAttr( "defaultRenderGlobals.currentRenderer" )
        #
        # if not hasattr( self, 'files' ):
        #     self.files = [publishFile]
        #
        #
        # jobids = []
        # # interact over rib files
        # for each in self.files:
        #     while '##' in each:
        #         each.replace('##','#')
        #     jobid = pipe.farm.maya(
        #         scene       = each.replace( '#', pipe.farm.maya.frameNumber() ),
        #         ribs        = map(lambda x: x.replace( '#', pipe.farm.maya.frameNumber() ), self.ribs),
        #         asset       = publishPath,
        #         project     = self.projectRoot(assetPath),
        #         extra       = self.renderPasses,
        #         renderer    = render,
        #         name        = 'RENDER: %s_%s' % (data['assetName'],data['assetVersion']) ,
        #         CPUS        = 9999,
        #         priority    = 9999,
        #         range       = range(int(frameRange.x), int(frameRange.y+frameRange.z), int(frameRange.z)),
        #         group       = 'pipe'
        #     ).submit()
        #     print 'job id: %s' % str(jobid)
        #     jobids.append(str(jobid))


        '''
            TODO:
            We need to first generate rib, running maya with a script to generate then at the given
            framerange and renderpass, OR generate rib inside prePublish, and publish the whole 3dfm
            folder together with maya scene (then farm will actually just be run renderdl)!!!

        '''
