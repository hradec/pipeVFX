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


import IECore, pipe
exec( pipe.include( __file__ ) )


import Asset
import tempfile, os

if m:
    import IECoreMaya




class cortex( model ) :
    
    def __init__( self ) :
        model.__init__(self, 'cortex')
        
        disabled={"UI":{ "invertEnabled" : IECore.BoolData(True) }}
        start = 0
        end = 10
        byFrameStep = 1
        override = 0
        if m:
            override = 1
            start = m.getAttr('defaultRenderGlobals.startFrame')
            end = m.getAttr('defaultRenderGlobals.endFrame')
            byFrameStep = m.getAttr('defaultRenderGlobals.byFrameStep')        
        
        self.parameters().addParameters([
            IECore.CompoundParameter("FrameRange","",[   
                IECore.V3fParameter("range","Inicio, fim e 'step' da sequencia a ser rendida.",IECore.V3f(start, end, byFrameStep), userData=disabled),
            ],userData = { "UI": {"collapsed" : IECore.BoolData(False)}}),
        ])
            
    def publishFile(self, publishFile, parameters):
        frameRange = parameters['Asset']['type']['FrameRange']['range'].value
        path = os.path.dirname(publishFile)
        name = os.path.splitext(os.path.basename(publishFile))[0]
        file = "%s/%s.%%04d.cob" % (path, name)
        files = map(lambda x: file % x, range(frameRange[0],frameRange[1],frameRange[2]))
        return file
    
    
    def getAssetDataHistory(self, parameters):
        ''' get data from asset based on some history in the host app, if any'''
        meshs = parameters['Asset']['type']['cortexMesh'].value.split(',')
        if meshs:
            for mesh in meshs:
                if m:
                    if m.objExists( '%s.pipe_asset' % mesh ):
                        return parameters.getAssetData(m.getAttr( '%s.pipe_asset' % mesh ))

    def doOperation( self, operands ):
        frameRange   = operands['FrameRange']['range'].value
        meshPrimitives = operands['cortexMesh'].value.split(',')
        self.data['assetPath'] = "%s.%%04d.cob" % tempfile.mkstemp()[1]
        self.data['multipleFiles'] = range(frameRange[0],frameRange[1],frameRange[2])
        self.data['meshPrimitives'] = meshPrimitives
        
        if m:
            m.cycleCheck(e=0)      
            for f in self.data['multipleFiles']:
                for each in meshPrimitives:
                    m.currentTime(f)
                    converter = IECoreMaya.FromMayaConverter.create(each)
                    converted = converter.convert()
                    writer = IECore.ObjectWriter( converted, self.data['assetPath'] % f )
                    writer.write()
        
        return IECore.StringData( 'done' )

      
    def postPublish(self, operands, finishedSuscessfuly=False):
        # cleanup 
        sudo = pipe.admin.sudo()
        for f in self.data['multipleFiles']:
            sudo.rm( self.data['assetPath'] % f )
        sudo.run()
        
        if finishedSuscessfuly:
            if m:
                for each in self.data['meshPrimitives']:
                    if not m.objExists( "%s.pipe_asset" % each):
                        m.addAttr( each, ln="pipe_asset", dt="string" )
                    m.setAttr( "%s.pipe_asset" % each, self.data['publishPath'], type='string' )
        
            
    def gather(self, operands):
        ''' gather op calls this method to gather the asset!'''
        assetVersion = '.'.join(map(lambda x: '%02d' % int(x), str(operands['Asset']['info']['version']).split()))
        path = "%s/%s/%s" % ( operands["Asset"]["type"], operands["Asset"]["info"]["name"], assetVersion )
        data = Asset.AssetParameter(path).getData()
        
        if m:
            x=IECoreMaya.FnProceduralHolder.create( "modelAsset", "read",1 )
            m.setAttr("%s.parm_files_name" % x.fullPathName(), (data['publishFile'] % 0).replace('0000','####'), type='string')
        
        return IECore.StringData( 'done' )

                    

IECore.registerRunTimeTyped( cortex )
