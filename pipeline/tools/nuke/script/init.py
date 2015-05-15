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

import os
from glob import glob

#we check all subfolders inside the current folder
#and automatically add then to nuke path
for each in glob('%s/*' % os.path.dirname(__file__)):
	if os.path.isdir(each):
		nuke.pluginAddPath(each)

def createWriteDir():
  import nuke, os, errno
  file = nuke.filename(nuke.thisNode())
  dir = os.path.dirname( file )
  osdir = nuke.callbacks.filenameFilter( dir )
  # cope with the directory existing already by ignoring that exception
  try:
    os.makedirs( osdir )
  except OSError, e:
    if e.errno != errno.EEXIST:
      raise
nuke.addBeforeRender(createWriteDir)




def sam_publish():
    import IECore
    import Gaffer
    import PySide
    import os, pipe

    os.environ['PIPE_PUBLISH_FILTER'] = 'render/nuke'
    appLoader = IECore.ClassLoader.defaultLoader( "GAFFER_APP_PATHS" )
    appLoader.classNames() 
    app=appLoader.load( 'opa' )()
    app.parameters()['arguments'] = IECore.StringVectorData(['-Asset.type','render/nuke','1','IECORE_ASSET_OP_PATHS'])
    app.parameters()['op'] = 'publish'
    app.parameters()['gui'] = 1
    app.run()

#sam_publish()

def sam_gather():
    import IECore
    import Gaffer
    import PySide
    import os, pipe

    os.environ['PIPE_PUBLISH_FILTER'] = 'render/nuke'
#    appLoader = IECore.ClassLoader.defaultLoader( "GAFFER_APP_PATHS" )
#    appLoader.classNames() 
#    app=appLoader.load( 'browser' )()
##    app.parameters()['arguments'] = IECore.StringVectorData(['-assetClass','render/nuke','1','IECORE_ASSET_OP_PATHS'])
##    app.parameters()['op'] = 'publish'
##    app.parameters()['gui'] = 1
#    app.run()


    import Gaffer
    import GafferUI
    import assetBrowser
    #import jobManager



    scriptNode = Gaffer.ScriptNode()

    with GafferUI.Window( "Gaffer Browser" ) as window :
        try:
            browser = GafferUI.BrowserEditor( scriptNode )    
        except:
            pass
    #    browser.pathChooser().pathListingWidget().setDisplayMode( 'SAM' )
    window.setVisible( True )
    GafferUI.EventLoop.mainEventLoop().start()




try:
    menubar = nuke.menu ('Nuke')
    menubar.addCommand ('SAM/Publish/nuke asset', 'sam_publish()', icon="") 
    menubar.addCommand ('SAM/Gather/nuke asset', 'sam_gather()', icon="") 
    menubar.addCommand ('SAM/Gather/sequence asset', '', icon="") 
except:
    pass


