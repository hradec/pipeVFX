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


import IECore
import Gaffer

import opaClasses
import genericAsset



# our opa application!
class opa( Gaffer.Application ) :

    def __init__( self ) :

        Gaffer.Application.__init__( self )

        self.hostApp = genericAsset.hostApp

        self.parameters().addParameters([
                IECore.StringParameter(
                    name = "op",
                    description = "The name of the op to run.",
                    defaultValue = ""
                ),

                IECore.IntParameter(
                    name = "version",
                    description = "The version of the op to run.",
                    defaultValue = -1,
                ),

                IECore.BoolParameter(
                    name = "gui",
                    description = "If this is true, then a gui is presented for the op. Otherwise "
                        "the op is run directly.",
                    defaultValue = False,
                ),

                IECore.StringParameter(
                    name = "preset",
                    description = "The name of a preset to load.",
                    defaultValue = "",
                ),

                IECore.StringVectorParameter(
                    name = "arguments",
                    description = "The arguments to be passed to the op. This should be the last "
                        "command line argument passed.",
                    defaultValue = IECore.StringVectorData( [] ),
                    userData = {
                        "parser" : {
                            "acceptFlags" : IECore.BoolData( True ),
                        },
                    },
                ),
            ])

        self.parameters().userData()["parser"] = IECore.CompoundObject(
            {
                "flagless" : IECore.StringVectorData( [ "op", "version" ] )
            }
        )

        self.__classLoader = None

    def setClassLoader( self, loader ) :

        self.__classLoader = loader

    def getClassLoader( self ) :
        # if self.__classLoader is None :
        #     self.__classLoader = IECore.ClassLoader.defaultLoader( "IECORE_OP_PATHS" )# IECore.ClassLoader.defaultOpLoader()

        if self.__classLoader is None :
            self.__classLoader = IECore.ClassLoader.defaultOpLoader()


        return self.__classLoader

    def _run( self, args ) :

        classLoader = self.getClassLoader()
        classLoader.refresh()

        matchingOpNames = classLoader.classNames( "*" + args["op"].value )
        if not len( matchingOpNames ) :
            IECore.msg( IECore.Msg.Level.Error, "op", "Op \"%s\" does not exist" % args["op"].value )
            return 1
        elif len( matchingOpNames ) > 1 :
            IECore.msg(
                IECore.Msg.Level.Error, "op",
                "Op name \"%s\" is ambiguous - could be any of the following : \n\n\t%s" % (
                    args["op"].value,
                    "\n\t".join( matchingOpNames ),
                )
            )
            return 1
        else :
            opName = matchingOpNames[0]

        opVersion = args["version"].value
        if opVersion >= 0 :
            if opVersion not in classLoader.versions( opName ) :
                IECore.msg( IECore.Msg.Level.Error, "op", "Version %d of op \"%s\" does not exist" % ( opVersion, args["op"].value ) )
                return 1
        else :
            opVersion = None # let loader choose default

        op = classLoader.load( opName, opVersion )()


        if args["preset"].value :

            presetLoader = IECore.ClassLoader.defaultLoader( "IECORE_OP_PRESET_PATHS" )

            preset = None
            if op.typeName() + "/" + args["preset"].value in presetLoader.classNames() :
                preset = presetLoader.load( op.typeName() + "/" + args["preset"].value )()
            elif args["preset"].value in presetLoader.classNames() :
                preset = presetLoader.load( args["preset"].value )()

            if preset is None :
                IECore.msg( IECore.Msg.Level.Error, "op", "Preset \"%s\" does not exist" % args["preset"].value )
                return 1

            if not preset.applicableTo( op, op.parameters() ) :
                IECore.msg( IECore.Msg.Level.Error, "op", "Preset \"%s\" is not applicable to op \"%s\"" % ( args["preset"].value, opName ) )
                return 1

            preset( op, op.parameters() )

#        print args["arguments"]
        IECore.ParameterParser().parse( list( args["arguments"] ), op.parameters() )

        if args["gui"].value :
            import GafferUI
            import GafferCortex
            import GafferCortexUI

            # build a script to host the op.

            self.root()["scripts"]["script1"] = Gaffer.ScriptNode()
            self.root()["scripts"]["script1"]["op"] = GafferCortex.ParameterisedHolderNode()
            self.root()["scripts"]["script1"]["op"].setParameterised( op )

            # apply the autoload preset, if and only if no preset and no parameter
            # values were specified via the command line.

            if not args["preset"].value and not args["arguments"] :
                GafferCortexUI.ParameterPresets.autoLoad( self.root()["scripts"]["script1"]["op"] )

            # create a ui to display everything.
            self.__dialogue = opaClasses.OpaDialogue( op, opName=opName )
            self.__dialogueClosedConnection = self.__dialogue.closedSignal().connect( Gaffer.WeakMethod( self.__dialogueClosed ) )
            self.__dialogue.setVisible( True )
            # if not GafferUI.EventLoop.mainEventLoop().running():
            try:
                GafferUI.EventLoop.mainEventLoop().start()
            except: pass
        else :
            op()

        return 0

    def __dialogueClosed( self, dialogue ) :
        try:
            import maya.cmds as m
            from maya.mel import eval as meval
            reload(Asset)
        except:
            m = None

        import GafferUI # delay import to improve startup times for non-gui case
        GafferUI.EventLoop.mainEventLoop().stop()

IECore.registerRunTimeTyped( opa )
