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


from IECore import *
import IECore
#from IECore import Op, Parameter, StringVectorData, BoolData, StringParameter, ValidatedStringParameter, ClassLoader
#from IECore import BoolParameter, CompoundParameter, registerRunTimeTyped, IntData, StringData, BoolData
#from IECore import CompoundObject, IntParameter, DateTimeParameter, StringVectorParameter, ClassParameter, ClassVectorParameter
from glob import glob
import os, datetime, sys
import pipe
import Asset


class gather( Op ) :
    

    def __init__( self ) :
        Op.__init__( self, "Publish assets.",
            StringParameter(
                name = "result",
                description = "",
                defaultValue = StringData(),
                userData = {"UI" : {	
                    "showResult" : BoolData( True ),
                    "showCompletionMessage" : BoolData( True ),
                    "saveResult" : BoolData( True ),
                    "closeAfterExecution" : BoolData( True ),
                    "farmExecutable": BoolData( True ),
                }},
            )
        )

        self.assetParameter = Asset.AssetParameter(publish=False)
        self.parameters().addParameters([
                self.assetParameter
            ])
        
    def parameterChanged(self, parameter):
        if hasattr( parameter, 'parameterChanged' ):
            parameter.parameterChanged( parameter )
        return self.assetParameter.parameterChanged(parameter)
        

    def doOperation( self, operands ) :
        
        print operands
        result = StringData("")
        
            
        # we indeed found a assetPath parameter, so we can proceed with the publishing
        if 1:
            
            # load the type op so we can run it
            opNames = self.assetParameter.classLoader.classNames( "*" + str(operands['Asset']['type']) )
            op = self.assetParameter.classLoader.load(opNames[0])()

#            # generate asset Data
#            assetName    = str(operands['Asset']['info']['name'])
#            assetVersion = map(lambda x: '%02d' % int(x), str(operands['Asset']['info']['version']).split())
#            assetType    = self.assetParameter.getAssetType()[0]
#            publishPath = self.assetParameter.job.path( 'sam/%s/%s/%s/' % (assetType, assetName, '.'.join(assetVersion),) )
#            publishFile = "%s/%s%s" % ( publishPath, assetName, os.path.splitext(assetPath)[-1] )
            
                
            # we use this errocheck function so we can run postPublish in case of 
            # failure!
            def errorCheck(result):
                result = str(result)
                if "ERROR" in result.upper():
                    # run the type op postPublish method to finish
                    if hasattr( op, 'postPublish' ):
                        op.postPublish(operands)
                    # raise exception!
                    raise Exception(result)
                    
            if hasattr( op, 'preGather' ):
                op.preGather(operands, True)
            
            # run the type op gather method to gather the asset
            if hasattr( op, 'gather' ):
                result = op.gather(operands)
                errorCheck(result)
            
            if hasattr( op, 'postGather' ):
                op.postGather(operands, True)
            
        return result
    
    
registerRunTimeTyped( gather )
