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
import re
import weakref
import threading

import IECore
import Gaffer
import GafferUI
import GafferSceneUI # for alembic previews

import pipe
import opaClasses
#import pipeBrowser

def populateJobs(jobFolderName='jobs'):
    from glob import glob
    ret = {}
    for each in glob( "%s/*" % pipe.roots.jobs() ):
        beach = os.path.basename(each)
        if beach[:4] != '0000':
            ret[beach] = {}
            if os.path.exists("%s/shots" % each):
                ret[beach]['shots'] = {}
                for shot in glob("%s/shots/*" % each):
                    ret[beach]['shots'][ os.path.basename(shot) ] = shot
            if os.path.exists("%s/assets" % each):
                ret[beach]['assets'] = {}
                for assets in glob("%s/assets/*" % each):
                    ret[beach]['assets'][ os.path.basename(assets) ] = assets

            if os.path.exists("%s/reference" % each):
                ret[beach]['reference'] = os.path.exists("%s/reference" % each)
            if os.path.exists("%s/archive" % each):
                ret[beach]['archive'] = os.path.exists("%s/archive" % each)
            if os.path.exists("%s/tools" % each):
                ret[beach]['tools'] = os.path.exists("%s/tools" % each)
            if os.path.exists("%s/.cliente" % each):
                ret[beach]['client'] = ''.join(open("%s/.cliente" % each, 'r').readlines()).strip()
    return ret


# gaffer browser preview!!
class jobPreview( GafferUI.DeferredPathPreview ) :
    def __init__( self, path ) :
        self.__column = GafferUI.ListContainer( borderWidth = 8 )
        GafferUI.DeferredPathPreview.__init__( self, self.__column, path )
        self._updateFromPath()
        self.__classLoader = IECore.ClassLoader.defaultOpLoader()
        self.__node = Gaffer.ParameterisedHolderNode()
        self.__op = self.__classLoader.load( 'admin/jobs/mkjob'  )()
        self.__node.setParameterised( self.__op )
        self.jobs = populateJobs()

    def isValid( self ) :
        path = self.getPath()
        if not path:
                return False

        if not os.path.exists(  "%s/%s" % (pipe.roots.jobs(), str(path).split('/')[-1] ) ):
                return False

        return os.path.exists(  "%s/%s" % (pipe.roots.jobs(), path ) ) and path!='/' or \
            os.path.exists(  "%s/%s/shots/%s" % (pipe.roots.jobs(), os.path.dirname(str(path)), os.path.basename(str(path))) )

    def _load( self ) :
        return self.getPath()

    def _deferredUpdate( self, op ) :
        del self.__column[:]

        self.jobs = populateJobs()

        if str(op)=='/':
            return

        job = str(op).split('/')[-1]
        jobIndex = job[:4]
        jobName = job[5:]

        self.__node["parameters"]["jobIndex"].setValue( int(jobIndex) )
        self.__node["parameters"]["jobName"].setValue( jobName )

        self.__node["parameters"]["assets"].setValue( IECore.StringVectorData( [] ) )
        if self.jobs[job].has_key('assets'):
            assets = self.jobs[job]['assets'].keys()
            assets.sort()
            self.__node["parameters"]["assets"].setValue( IECore.StringVectorData( assets ) )

        self.__node["parameters"]["shots"].setValue( IECore.StringVectorData( [] ) )
        if self.jobs[job].has_key('shots'):
            shots = self.jobs[job]['shots'].keys()
            shots.sort()
            self.__node["parameters"]["shots"].setValue( IECore.StringVectorData( shots ) )

        self.__node["parameters"]["client"].setValue( '' )
        if self.jobs[job].has_key('client'):
            self.__node["parameters"]["client"].setValue( self.jobs[job]['client'] )

        self.__node["parameters"]["defaultOutput"].setValue( '' )
        jobData = pipe.admin.job(
            self.__node["parameters"]["jobIndex"].getValue(),
            self.__node["parameters"]["jobName"].getValue(),
        ).getData()
        if jobData.has_key('output'):
            self.__node["parameters"]["defaultOutput"].setValue( jobData['output'] )


        with self.__column :
            GafferUI.Image( "%s/opa.png" % pipe.name() )
            GafferUI.NodeUI.create( self.__node )

            button = GafferUI.Button( "Execute" )
            self.__executeClickedConnection = button.clickedSignal().connect( self.__executeClicked )

    def __executeClicked( self, button ) :
#        with GafferUI.ErrorDialogue.ExceptionHandler( parentWindow=self.ancestor( GafferUI.Window ) ) :

        self.__node.getParameterised()[0](
                jobIndex      = self.__node["parameters"]["jobIndex"].getValue(),
                jobName       = self.__node["parameters"]["jobName"].getValue(),
                assets        = self.__node["parameters"]["assets"].getValue(),
                shots         = self.__node["parameters"]["shots"].getValue(),
                defaultOutput = self.__node["parameters"]["defaultOutput"].getValue(),
            )
#        dialog = GafferUI.Dialogue("all done!")
#        dialog._qtWidget().resize(200,100)
#        column = GafferUI.ListContainer( GafferUI.ListContainer.Orientation.Vertical, spacing = 8 )
#        messageWidget = GafferUI.Label( IECore.StringUtil.wrap( "All Done!!", 60 ) )
#        column.append( messageWidget )
#        dialog._setWidget( column )
#        dialog._addButton("OK")
#        dialog.waitForButton()


class JobMode(  GafferUI.BrowserEditor.Mode ) :

    def __init__( self, browser ) :
        GafferUI.BrowserEditor.Mode.__init__( self, browser )
        self.__classLoader = IECore.ClassLoader.defaultOpLoader()

    def connect( self ) :
        GafferUI.BrowserEditor.Mode.connect( self )
        self.__contextMenuConnection = None
        self.__pathSelectedConnection = self.browser().pathChooser().pathListingWidget().pathSelectedSignal().connect(
            Gaffer.WeakMethod( self.__pathSelected )
        )
        self.__contextMenuConnection  = self.browser().pathChooser().pathListingWidget().contextMenuSignal().connect(
            Gaffer.WeakMethod( self.__menu )
        )

    def disconnect( self ) :
        GafferUI.BrowserEditor.Mode.disconnect( self )
        self.__pathSelectedConnection = None
        self.__contextMenuConnection = None

    def _initialDisplayMode( self ) :
        return GafferUI.PathListingWidget.DisplayMode.Tree

    def _initialColumns( self ) :
        return [ GafferUI.PathListingWidget.defaultNameColumn ]

    def __pathSelected( self, pathListing ) :
        selectedPaths = pathListing.getSelectedPaths()
        if not len( selectedPaths ) :
            return

        print selectedPaths[0]
#        op = selectedPaths[0].classLoader().load( str( selectedPaths[0] )[1:] )()
#        opaDialogue = opaClasses.OpaDialogue( op )
#        pathListing.ancestor( GafferUI.Window ).addChildWindow( opaDialogue )
#        opaDialogue.setVisible( True )

    def __menu( self, pathListing ) :
        print "XXXX:%s" % str(pathListing)
        menuDefinition = IECore.MenuDefinition()
        menuDefinition.append( "/%s " % str(dir(pathListing)), { "active" : True } )
        menuDefinition.append( "/%s " % str(dir(pathListing)), { "active" : True } )
        menuDefinition.append( "/%s " % str(dir(pathListing)), { "active" : True } )

#        if self.__opMatcher is not None :
        selectedPaths = pathListing.getSelectedPaths()
        if len( selectedPaths ) == 1 :
            parameterValue = selectedPaths[0]
        else :
            parameterValue = selectedPaths
        menuDefinition.append( "/Actions", { "subMenu" : IECore.curry( Gaffer.WeakMethod( self.__actionsSubMenu ), parameterValue ) } )

#        else :
#            menuDefinition.append( "/Loading actions...", { "active" : False } )


        self.__menu = GafferUI.Menu( menuDefinition )
        if len( menuDefinition.items() ) :
            self.__menu.popup( parent = pathListing.ancestor( GafferUI.Window ) )
        return True



    def _initialPath( self ) :
        return Gaffer.DictPath( populateJobs(), "" )

#    def _initialColumns( self ) :
#        return ['Job Name']
    def __createOpMatcher( self ) :

        self.__opMatcher = None


GafferUI.PathPreviewWidget.registerType( "Job Editing", jobPreview )
GafferUI.BrowserEditor.registerMode( "Job Management", JobMode )
GafferUI.BrowserEditor.JobMode = JobMode
