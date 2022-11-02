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
import IECoreAlembic

try: from importlib import reload
except: pass

class alembic( IECore.Op ):

    def __init__( self ) :

        IECore.Op.__init__( self )

        self.parameters().addParameters(

            [

                IECore.FileNameParameter(
                    name = "fileName",
                    description = "The filename of an Alembic cache.",
                    defaultValue = "",
                    allowEmptyString = True,
                    check = IECore.PathParameter.CheckType.MustExist,
                    extensions = "abc",
                ),

                IECore.BoolParameter( "subdiv", "Subdiv", False  ),

                IECore.FloatParameter(
                    name = "time",
                    description = "The time at which to load from the Alembic cache",
                    defaultValue = 0,
                    userData = {
                        "maya" : {
                            "defaultExpression" : IECore.StringData( " = time" ),
                        },
                    },
                ),

            ],

        )

        self.__input = None
        self.__inputFileName = None

    def doBound( self, args ) :

        a = self.__alembicInput( args )
        if a is None :
            return IECore.Box3f()

        return _ChildProcedural( a, args["time"].value, args ).bound()

    def doRenderState( self, renderer, args ) :

        pass

    def doRender( self, renderer, args ) :

        a = self.__alembicInput( args )
        if a is None :
            return

        renderer.procedural( _ChildProcedural( a, args["time"].value, args ) )

    def __alembicInput( self, args ) :

        if self.__input is not None and self.__inputFileName == args["fileName"].value :
            return self.__input

        self.__input = None
        self.__inputFileName = args["fileName"].value
        if args["fileName"].value :
            try :
                self.__input = IECoreAlembic.AlembicInput( args["fileName"].value )
            except :
                IECore.msg( IECore.Msg.Level.Error, "AlembicProcedural", "Unable to open file \"%s\"" % args["fileName"].value )

        return self.__input

class _ChildProcedural( IECore.Renderer.Procedural ) :

    def __init__( self, alembicInput, time, args ) :

        IECore.Renderer.Procedural.__init__( self )

        self.__alembicInput = alembicInput
        self.__time = time
        self.__args = args

    def bound( self ) :

        b = self.__alembicInput.boundAtTime( self.__time )
        b = b.transform( self.__alembicInput.transformAtTime( self.__time ) )
        return IECore.Box3f( IECore.V3f( b.min ), IECore.V3f( b.max ) )

    def render( self, renderer ) :

        with IECore.AttributeBlock( renderer ) :

            renderer.setAttribute( "name", self.__alembicInput.fullName() )

            transform = self.__alembicInput.transformAtTime( self.__time )
            if transform is not None :
                transform = IECore.M44f(
                    transform[0,0], transform[0,1], transform[0,2], transform[0,3],
                    transform[1,0], transform[1,1], transform[1,2], transform[1,3],
                    transform[2,0], transform[2,1], transform[2,2], transform[2,3],
                    transform[3,0], transform[3,1], transform[3,2], transform[3,3]
                )
                renderer.concatTransform( transform )

            # print self.__alembicInput.fullName(), dir(self.__alembicInput)
            # if self.__alembicInput.objectAtTime( self.__time):
            #     try:
            #         print type(self.__alembicInput.objectAtTime( self.__time))
            #         print self.__alembicInput.objectAtTime( self.__time).keys()
            #     except: pass
            primitive = self.__alembicInput.objectAtTime( self.__time, IECore.Primitive.staticTypeId() )
            if primitive is not None :
                with IECore.AttributeBlock( renderer ) :
                    if renderer.typeName() != "IECoreGL::Renderer":
                        # print self.__alembicInput.fullName()
                        renderer.setAttribute( "name", self.__alembicInput.fullName() )
                        renderer.setAttribute( "ri:identifier:name", IECore.StringData( self.__alembicInput.fullName() ) )

                        if 'primaryVisibility' in primitive.keys():
                            traceset =  'reflection' if primitive['visibleInReflections'].data[0] else ''
                            traceset += 'refraction' if primitive['visibleInRefractions'].data[0] else ''
                            traceset += 'shadow'     if primitive['receiveShadows'].data[0] else ''

                            renderer.setAttribute( "ri:visibility:camera",          IECore.IntData( primitive['primaryVisibility'].data[0] ) )
                            renderer.setAttribute( "ri:visibility:indirect",        IECore.IntData( primitive['visibleInReflections'].data[0] or primitive['visibleInRefractions'].data[0] ) )
                            renderer.setAttribute( "ri:visibility:transmission",    IECore.IntData( primitive['castsShadows'].data[0] ) )
                            renderer.setAttribute( "ri:user:receivesShadows",       IECore.IntData( primitive['receiveShadows'].data[0] ) )
                            renderer.setAttribute( "ri:matte",                      IECore.BoolData( primitive['holdOut'].data[0] ) )
                            renderer.setAttribute( "ri:shade:transmissionhitmode",  IECore.StringData( 'shader' ) )
                            # renderer.setAttribute( "ri:sides",                      IECore.IntData( primitive['doubleSided'].data[0]+1 ) )
                            # renderer.setAttribute( "doubleSided",                   IECore.BoolData( primitive['doubleSided'].data[0] ) )

                            # renderer.setAttribute( "ri:reverseOrientation",         IECore.BoolData( primitive['opposite'].data[0] ) )
                            # renderer.setAttribute( "reverseOrientation",            IECore.BoolData( primitive['opposite'].data[0] ) )


                            if traceset.strip():
                                renderer.setAttribute( "ri:grouping:membership", IECore.StringData( traceset ) )

                            del primitive['primaryVisibility']
                            del primitive['visibleInReflections']
                            del primitive['visibleInRefractions']
                            del primitive['castsShadows']
                            del primitive['receiveShadows']
                            del primitive['doubleSided']
                            del primitive['motionBlur']
                            del primitive['opposite']
                            del primitive['smoothShading']
                            del primitive['holdOut']

                        if self.__args['subdiv'].value:
                            primitive.interpolation = "catmullClark"

                        if 'N' not in primitive.keys():
                            primitive = IECore.MeshNormalsOp()( input=primitive )
                            # MeshNormalsOp returns inverted normals for some reason.
                            for n in range(len(primitive['N'].data)):
                                primitive['N'].data[n] = -primitive['N'].data[n]

                    primitive.render( renderer )

            # else:
            #     primitive = self.__alembicInput.objectAtTime( self.__time, IECore.Primitive.staticTypeId() )
            #     print dir(primitive)
            #     print primitive.keys()


            for childIndex in range( 0, self.__alembicInput.numChildren() ) :
                child = self.__alembicInput.child( childIndex )
                childProcedural = _ChildProcedural( child, self.__time, self.__args )
                if child.hasStoredBound() :
                    renderer.procedural( childProcedural )
                else :
                    childProcedural.render( renderer )



IECore.registerRunTimeTyped( alembic )
