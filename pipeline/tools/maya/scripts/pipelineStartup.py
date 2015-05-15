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

import maya
import maya.cmds as m
import pipe, os

# if we're in a job/shot, set workspace current to the 
# current user maya folder
j = pipe.admin.job.current()
if j:
    import maya.cmds as m
    user = j.shot.user()
    m.workspace( user.path('maya'), o=1 )

# if user is 3d, add qube ui! 
if os.environ['USER'] == '3d':
    from maya.mel import eval as meval
    meval('qube_addUI();')
    
    
# pipeline startup!
def pipeIdleStartup():
    # force auto-load of these plugins at startup!
    plugs=[
        'slumMayaPlugin.py', 
        'ieCore.so', 
        '3delight_for_maya%s' % os.environ['MAYA_VERSION_MAJOR'],
    ]
    if plugs:
        for each in plugs:
            print '='*80
            print 'PIPE: auto-loading %s plugin...\n' % each
            try:
                m.loadPlugin( each )
            except:
                pass
        print '='*80
    
    
    # re-initialize cortex menu to filter out admin ops!
    try:
        import IECore, IECoreMaya
    except: 
        IECore=None
        IECoreMaya=None
    
    if IECore:
        def __createOp( className ) :
            fnOH = IECoreMaya.FnOpHolder.create( os.path.basename( className ), className )
            maya.cmds.select( fnOH.fullPathName() )
                
        def filteredOpCreationMenuDefinition() :
            menu = IECore.MenuDefinition()
            loader = IECore.ClassLoader.defaultOpLoader()
            for className in loader.classNames() :
                if not filter( lambda x: x in className, ['admin/'] ):
                    menu.append(
                        "/" + className,	
                        {
                            "command" : IECore.curry( __createOp, className ),
                        }
                    )
            return menu

        menu = IECore.MenuDefinition()
        menu.append(
            "/Create Procedural",
            {
                "subMenu" : IECoreMaya.Menus.proceduralCreationMenuDefinition,
            }
        )
        
        menu.append(
            "/Create Op",
            {
                "subMenu" : filteredOpCreationMenuDefinition,
            }
        )
        
        #delete default cortex menu!
        for each in filter( lambda x: m.menu( x, q=1, l=1)=='Cortex', m.window( "MayaWindow", query=True, menuArray=True ) ):
            m.deleteUI( each, menu=True )
            
        #create our custom one!
        global __cortexMenu
        __cortexMenu = IECoreMaya.createMenu( menu, "MayaWindow", "Cortex" )
    
    
    # force unload of Alembic plugins!!
    m.unloadPlugin('AbcExport')
    m.unloadPlugin('AbcImport')
    
    


# asset manager
sam_window = None
def loadAssetManager():
    import IECore, IECoreMaya
            
    def __publishRender() :
        import maya.cmds as m
        #m.file()
        
        import IECore
        import Gaffer
        import GafferUI
        import os, pipe
        os.environ['PIPE_PUBLISH_FILTER'] = 'render/maya'
        appLoader = IECore.ClassLoader.defaultLoader( "GAFFER_APP_PATHS" )
        appLoader.classNames() 
        app=appLoader.load( 'opa' )()
        app.parameters()['arguments'] = IECore.StringVectorData(['-Asset.type','render/maya','1','IECORE_ASSET_OP_PATHS'])
        app.parameters()['op'] = 'publish'
        app.parameters()['gui'] = 1
        app.run()


    def __publish(f='particle', t='nParticles') :
        import maya.cmds as m
        import IECore
        import Gaffer
        import PySide
        import os, pipe
        os.environ['PIPE_PUBLISH_FILTER'] = f
        appLoader = IECore.ClassLoader.defaultLoader( "GAFFER_APP_PATHS" )
        appLoader.classNames() 
        app=appLoader.load( 'opa' )()
        app.parameters()['arguments'] = IECore.StringVectorData(['-Asset.type','%s/%s' % (f,t),'1','IECORE_ASSET_OP_PATHS'])
        app.parameters()['op'] = 'publish'
        app.parameters()['gui'] = 1
        app.run()


        
    def __gather() :
        global sam_window 
        import IECore
        import Gaffer
        import GafferUI
        import assetBrowser
        import os, pipe
        scriptNode = Gaffer.ScriptNode()
        with GafferUI.Window( "Gaffer Browser" ) as sam_window  :
                browser = GafferUI.BrowserEditor( scriptNode )   
        browser.pathChooser().getPath().setFromString( '/' )                
        sam_window.setVisible( True )
        GafferUI.EventLoop.mainEventLoop().start()



    menu = IECore.MenuDefinition()
    menu.append("/Publish/Render",               {"command" : __publishRender,"active" : True})
    menu.append("/Publish/Particle/nParticle",   {"command" : lambda: __publish('particle', 'nParticles'), "active" : True})
    menu.append("/Publish/Model",                {"command" : lambda: __publish('model', 'cortex'), "active" : True})
    menu.append("/Publish/Rig/skeleton",         {"command" : __gather, "active" : False})
    menu.append("/Publish/Rig/light",            {"command" : __gather, "active" : False})
    menu.append("/Publish/Animation/camera",     {"command" : __gather, "active" : False})
    menu.append("/Publish/Animation/vertex",     {"command" : __gather, "active" : False})
    menu.append("/Publish/Animation/skeleton",   {"command" : __gather, "active" : False})
    menu.append("/Publish/Animation/particles",  {"command" : __gather, "active" : False})
    menu.append("/Publish/Texture",              {"command" : __gather, "active" : False})
    
    menu.append("/Gather",                {"command" : __gather, "active" : True})
    
    
    #create our custom one!
    global __cortexMenu
    __cortexMenu = IECoreMaya.createMenu( menu, "MayaWindow", "SAM" )
    
m.scriptJob( runOnce=True,  idleEvent=pipeIdleStartup )
m.scriptJob( runOnce=True,  idleEvent=loadAssetManager )
