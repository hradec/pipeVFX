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
import samDB
import Asset
reload(Asset)
try:
    import IECoreMaya
except:
    IECoreMaya=None

import genericAsset


try:
    j = pipe.admin.job()
except:
    j=None



class publish( Op ) :

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

        self.assetParameter = Asset.AssetParameter()
        self.parameters().addParameters([
                self.assetParameter
            ])

    def parameterChanged(self, parameter):
        if hasattr( parameter, 'parameterChanged' ):
            parameter.parameterChanged( parameter )
        # if parameter.name == 'type':
        #     print "publish parameter changed!!", parameter.getClass().path
        #
        # print self.parameters()['Asset']['type'].getClass().path
        # sys.stdout.flush()
        # return self.assetParameter.parameterChanged(parameter)


    def doOperation( self, operands ) :

        result = None

        #find the assetPath parameter
        # we look into userData section of every parameter from type
        # the parameter which has assetPath userdata, is the asset path parameter
        # and we use it's value as the asset path origin
        assetPathParameter, assetPath = self.assetParameter.getAssetPathParameter()

        # we indeed found a assetPath parameter, so we can proceed with the publishing
        if assetPath:

            # load the type op so we can run it
            opNames = self.assetParameter.classLoader.classNames( "*" + str(self.parameters()['Asset']['type'].getClass().path) )
            op = self.assetParameter.classLoader.load(opNames[0])()

#            IECore.ParameterParser().parse( list( operands ), op.parameters() )
            for each in operands['Asset']['type'].keys():
                op.parameters()[each].setValue( operands['Asset']['type'][each] )

            # generate asset Data
            assetName    = str(operands['Asset']['info']['name'])
            assetVersion = map(lambda x: '%02d' % int(x), str(operands['Asset']['info']['version']).split())
            assetType    = self.assetParameter.getAssetType()[0]
            publishPath  = self.assetParameter.job.path( 'sam/%s/%s/%s/' % (assetType, assetName, '.'.join(assetVersion),) )
            assetDependencyPath = assetPath
            # base file name of published file
            publishFile = "%s/%s%s" % ( publishPath, assetName, os.path.splitext(assetPath)[-1] )

            # operands['Asset']['info']['description'].value =  '%s - %s' % (
            #     pipe.admin.username(),
            #     str(operands['Asset']['info']['description']),
            # )

            # run the type op prePublish method to prepare the asset, if needed!
            if hasattr( op, 'prePublish' ):
                op.prePublish(operands)

            # run the type op assetExt method to retrieve the asset file extension
            if hasattr( op, 'publishFile' ):
                publishFile = op.publishFile(publishFile, operands)
                #"%s%s" % (os.path.splitext(publishFile)[0], op.assetExt())

            # publish using admin rights
            if os.path.exists(publishPath):
                raise Exception("ERROR: Versao %s ja existe e nao pode ser re-publicado!!" % '.'.join(assetVersion))
            sudo = pipe.admin.sudo()
            sudo.mkdir( publishPath )
            sudo.chown( 'root:artists', publishPath )

            job=''
            if j:
                job = j.shot().path().split('jobs/')[-1]

            data_txt = {
                'path':publishPath,
                'assetUser':pipe.admin.username(),
                'assetType':assetType,
                'assetName':assetName,
                'assetVersion': '.'.join(assetVersion),
                'assetDescription':str(operands['Asset']['info']['description']),
                'assetDependencyPath':assetDependencyPath,
                'assetPath':assetPath,
                'publishPath':publishPath,
                'publishFile':publishFile,
                'assetClass': operands['Asset']['type'],
                'assetInfo': operands['Asset']['info'],
                'multipleFiles': False,
                'job' : job
            }


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

            # store the assetData info as an data attribute in the op,
            # so we can access it from inside the op!
            op.data = data_txt

            # now that we've published our asset,
            # run the type op!
            result = op()
            errorCheck(result)

            # do the data file here after op so op() can modify it!
            data_txt = op.data
            # print data_txt['multipleFiles']
            if data_txt['multipleFiles']:
                assert( type( data_txt['multipleFiles'] ) == list )
                data_txt['multiplePublishedFiles'] = []
                for f in data_txt['multipleFiles']:
                    data_txt['multiplePublishedFiles'].append( data_txt['publishFile'] % f )
                    print '===>',data_txt['assetPath'] % f, data_txt['multiplePublishedFiles'][-1]
                    sudo.cp( data_txt['assetPath'] % f, data_txt['multiplePublishedFiles'][-1] )
                    sudo.chown( 'root:artists', data_txt['multiplePublishedFiles'][-1] )
                    sudo.chmod( 'a+r', data_txt['multiplePublishedFiles'][-1] )
            else:
                if os.path.exists(data_txt['assetPath']):
                    sudo.cp( data_txt['assetPath'], data_txt['publishFile'] )
                    sudo.chown( 'root:artists', data_txt['publishFile'] )
                    sudo.chmod( 'a+r', data_txt['publishFile'] )
            sudo.toFile( str(data_txt), '%s/data.txt' % publishPath )
            if operands['Asset']['info']['current']==BoolData(True):
                sudo.toFile(publishPath, '%s/../current' % publishPath)

            sudo.cp( assetDependencyPath, publishPath)
            if 'extraFiles' in data_txt:
                assert( type( data_txt['extraFiles'] ) == list )
                for each in data_txt['extraFiles']:
                    print 'cp ', each, "%s/%s" % (publishPath, os.path.basename(each))
                    sudo.cp( each, "%s/%s" % (publishPath, os.path.basename(each)) )


            # only publish if the type op execution returns correctly!
            ret = sudo.run()
            print ret
            errorCheck(ret)

            # after running the op, we call submission method to do farm stuff, if any!
            if hasattr( op, 'submission' ):
                result = op.submission(operands['Asset']['type'])
                print result
                errorCheck(result)

            # run the type op postPublish method to finish
            if hasattr( op, 'postPublish' ):
                op.postPublish(operands, True)

            # refresh samDB cache to speed up sam panel
#            samDB.populateAssets()

        return result

registerRunTimeTyped( publish )
