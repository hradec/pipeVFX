#!/usr/bin/env python
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
import pipe

try:
    from IECore import *
    import IECore
except:
    CompoundParameter = object
    CompoundObject = {}
    IECore = None
try:
    import maya.cmds as m
    from maya.mel import eval as meval
    m.ls()
except:
    m = None


def types():
    from glob import glob
    ret = {}
    root = "%s/config/assets" % pipe.roots.tools()
    def recursiveTree(path, d={}):
            for each in glob( "%s/*" % path ):
                id = each.replace(root,"")[1:]
                if os.path.isdir(each):
                    recursiveTree(each, d)
                elif os.path.isfile(each):
                    basename = os.path.basename(id).split('-')[0]
                    dirname  = os.path.basename(os.path.dirname(id))
                    if basename == dirname:
                        d[os.path.dirname(id)] = True
            return d                    
                
    ret = recursiveTree(root, ret)
    return ret.keys()


class AssetParameter( CompoundParameter ):
    def __init__(self, path=None, publish=True):
        if IECore:
            CompoundParameter.__init__(self, 'Asset',"", userData = { "UI": {"collapsed" : BoolData(False),}},)
        
        filter = '*'
        if os.environ.has_key('PIPE_PUBLISH_FILTER'): 
            filter = os.environ['PIPE_PUBLISH_FILTER'] 

        if IECore:
            self.classLoader = ClassLoader.defaultLoader( "IECORE_ASSET_OP_PATHS" )

        self.job = j = pipe.admin.job.current()
        if not self.job:
            return
        self.jobData = j.getData()
        self.shot = pipe.admin.job.shot()
        self.user = pipe.admin.job.shot.user()
        self.path = path
        self.publish = publish
        
        if self.path:
            # be smart and figure if the path represents an valid asset by looking for a data.txt file
            p = self.path
            while( len(p)>2 ):
                if os.path.exists('%s/data.txt' % p):
                    self.path = p
                    break
                p = os.path.dirname(p)
                
            # another little of smartness... if path has job/shot in it, update our internal job shot 
            # with it. This way we can access assets in different job/shots!
            if '/jobs/' in self.path:
                jopPath = self.path.split('/jobs/')[1].split('/')[0].split('.')
                self.job = j =  pipe.admin.job(jopPath[0], jopPath[1])
                

            # store the path relative to the project
            if 'sam' in self.path:
                self.path = self.path.split('sam/')[-1]
            
        
        current = {}
        def recursiveGatherAllAssets(path=self.job.path('sam/*')):
            ret = {}
            for each in glob('%s/*' % path):
                assetName = os.path.basename(each)
                if assetName[0].isdigit():
                    id = each.replace(self.job.path('sam/'),'')
                    # check if version is current!
                    cur = os.path.dirname(each)
                    if os.path.exists('%s/current' % cur):
                        if not current.has_key(cur):
                            current[cur] = open('%s/current' % cur,'r').readlines()[0].strip()
                        # and add a '(current)' suffix to show to the user!
                        if each == current[cur][:-1]:
                            id += ' (current)'
                    ret[id]=''
                else:
                    ret.update(recursiveGatherAllAssets(each))
            return ret
        
        allAssets = []
        #if publish:
        allAssets = recursiveGatherAllAssets().keys()
        allAssets.sort()
        AssetsPublicados = map( lambda x: (x,x), allAssets )
        
        assetName = ""
        assetVersion = "1.-1.0"
        assetDesc  = ""

        # app specific asset info
        # maya
        if m:
            if m.objExists( "defaultRenderGlobals.pipe_asset_name" ):
                assetName    = m.getAttr( "defaultRenderGlobals.pipe_asset_name" )
            if m.objExists( "defaultRenderGlobals.pipe_asset_version" ):
                assetVersion = m.getAttr( "defaultRenderGlobals.pipe_asset_version" )
            if m.objExists( "defaultRenderGlobals.pipe_asset_description" ):
                desc = m.getAttr( "defaultRenderGlobals.pipe_asset_description" )
                if assetVersion != "1.-1.0":
                    assetDesc = "\n(desc versao: %s) - %s " % (assetVersion,desc)

                
                
        if IECore:
            assetVersion = map( lambda x: int(x), assetVersion.split('.') )
            assetVersion = V3i(assetVersion[0], assetVersion[1]+1, assetVersion[2])
            
            if publish:
                type = ClassParameter(
                    "type",
                    "Asset Type",
                    "IECORE_ASSET_OP_PATHS",
                    userData = { "UI": {
                        "collapsed" : BoolData(False),
                        "classNameFilter" : StringData(filter),
                    }},
                )
                self.addParameter(type)
                par = [
                            ValidatedStringParameter(
                                name="name",
                                description = "Asset name, without spaces or weird characters. Right-click shows all published assets!",
                                defaultValue = assetName,
                                regex = "^\S+$",
                                regexDescription = "no spaces allowed.",
                                allowEmptyString = False,
                                presets = AssetsPublicados,
                                presetsOnly = False,
                            ),
                            StringParameter(
                                name="description",
                                description = "quick description of the asset.",
                                defaultValue = assetDesc ,
                                userData = { "UI": { "multiLine" : BoolData(True) } },  
                            ),
                            V3iParameter(
                                name="version",
                                description = "Version corresponde a versao do asset a ser publicada."
                                              "<br><br>O 1o. numero (major version) deve somente ser incrementada caso a asset "
                                              "a ser publicado quebre compatibilidade com outros etapas do pipeline. "
                                              "<p style='margin-left: 16'>ex: modelo tem numero de vertices diferente da versao anterior, quebrando "
                                              "assim a compatibilidade com o rigging. Nesse caso, incrementamos "
                                              "a 1o. numero (major version) para sinalizar que e necessario revisao de rigging e animacao!</p>"
                                              "<br>O 2o. numero (minor version) deve ser incrementada quando as alteracoes no asset nao quebram compatibilidade. "
                                              "Essa e provavelmente a versao que sera mais incrementada apos o asset entrar em producao! "
                                              "<p style='margin-left: 16'>ex: Mudancas em um modelo sem alterar o numero total de vertices, o que permite manter o rigging "
                                              "atual!</p>"
                                              "<br>O 3o. numero (patch version) deve ser incrementada quando houver "
                                              "pequenas correcoes que nao alterem o asset em visual e funcionalidade, principalmente sem"
                                              "quebrar compatibilidade com outras etapas do pipeline!"
                                              "<p style='margin-left: 16'>Ex: correcao de UV de um modelo</p>",
                                defaultValue = assetVersion,
                            ),
                            BoolParameter(
                                name="current",
                                description = "Sets the version to current.",
                                defaultValue = True,
                            ),
                ]
                
            else:
                par = [
                    StringParameter(
                        name="name",
                        description = "Asset name, without spaces or weird characters. Right-click shows all published assets!",
                        defaultValue = assetName,
                        #regex = "^\S+$",
                        #regexDescription = "no spaces allowed.",
                        #allowEmptyString = True,
                        presets = AssetsPublicados,
                        presetsOnly = False,
                        userData = { "UI": {"collapsed" : BoolData(False),}},
                    ),
                ]
                
                    
            self.addParameters([
                    CompoundParameter(
                        "info",
                        "",
                        par,
                        userData = { "UI": {"collapsed" : BoolData(False),}},
                    )
            ])
        
#    @staticmethod
#    def pathToAsset(path):
#        /atomo/jobs/0345.minuano/assets/camisa/users/rhradec/maya/3delight/shot03_02.06.00/rib/shot03_02.06.00_renderPass_QB_FRAME_NUMBER.rib
        
    
    def frameRangeParameter(self):
        ''' returns a default frame range parameter to all assets! '''
        if IECore:
            if self.publish:
                return IECore.CompoundParameter("FrameRange","",[   
                        IECore.V3fParameter("range","Inicio, fim e 'step' da sequencia a ser rendida.",IECore.V3f(start, end, byFrameStep), userData=disabled),
                    ],userData = { "UI": {"collapsed" : IECore.BoolData(False)}})
            else:
                return None
            
    def isValid(self):
        return os.path.exists( "%s/data.txt" % self.getFilePath() )
            

    def getData(self):
        if self.path:
            p = self.getFilePath()
            f = open("%s/data.txt" % p)
            l = f.readlines()
            print l
            d = eval(''.join(l).strip('\n').replace("\n","\\n"))
            f.close()
            return d
        return {}
    
    def getFilePath(self):
        if self.job and self.path:
            return self.job.path("sam/%s" % self.path)
        return ""
    
    def getAssetType(self):
        # get current select class type
        if IECore:
            if self.publish:
                if self['type'].keys():
                    tmp = self['type']['assetType'].getValue()
                    return self.classLoader.classNames( "*" + str(tmp) )
        return ""

    def gatherAssets(self, assetType):
        assets = {}
        for each in glob(self.job.path('sam/%s/*' % assetType)):
            assetName = os.path.basename(each)
            assets[assetName] = filter( lambda x: os.path.basename(x)[0].isdigit(), glob('%s/*' % each) )
        return assets

    def getAssetPathParameter(self):
        '''#find the assetPath parameter
        # we look into userData section of every parameter from assetClass 
        # the parameter which has assetPath userdata, is the asset path parameter
        # and we use it's value as the asset path origin        assetPathParameter = None'''
        assetPath = None
        assetPathParameter = None
        for each in self['type'].keys():            
            if self['type'][each].userData().has_key('assetPath'):
                assetPathParameter = str(each)
                assetPath = str(self['type'][each].getValue())
                break
        return (assetPathParameter, assetPath)

    def getDataName(self, parameter):
        ''' we can add a dataName user data to parameters to specify an alternative
        name for that parameter to be used inside the data file for an asset!'''
        ud = parameter.userData()
        if ud.has_key('dataName'):
            return str( ud['dataName'] )
        return str( parameter.name )

    def getAssetData(self, relativeAssetPath):
        ''' loads the asset data file for a given asset path and returns the data as a dict ''' 
        fullpath = self.job.path( 'sam/%s/data.txt' % relativeAssetPath.split('/sam/')[-1] )
        
        ret = None
        if os.path.exists( fullpath ):
            ret =  eval(''.join(open(fullpath,'r').readlines()).strip().replace('\n','\\n'))
        return ret
    
    def getDataDict(self):
        ''' load data file based on current set name parameters '''
        assetData = {}
        assetName = str(self['info']['name'].getValue())
        if '/' in assetName:
            assetName = assetName.split()[0].strip()
            # we used the pop up menu to select an existing asset
            assetData = self.getAssetData(assetName)
        return assetData
        
    def parameterChanged(self, parameter):
        forceVersionCheck = False
#        print parameter.name,'=',parameter.getValue()
           
        #if self.publish:
        if IECore:
            if parameter.name == 'name' or forceVersionCheck:
                assetName = str(self['info']['name'].getValue())
                if '/' in assetName:
                    assetName = assetName.split()[0].strip()
                    # we used the pop up menu to select an existing asset
                    assetData = self.getAssetData(assetName)
                    assetOldVersion = os.path.basename(assetName)
                    assetName = os.path.dirname(assetName) # remove version
                    assetType = os.path.dirname(assetName)
                    assetName = os.path.basename(assetName)
                    self['info']['name'].smartSetValue( assetName )
                    if 'type' in self.keys():
                        self['type'].setClass( assetType, 1 )

                    # get assetData from data.txt and fill up ui!
                    if assetData:
                        if hasattr( assetData, 'has_key' ):
                            if not self.publish:
                                if 'type' in self.keys():   
                                    for par in self['type'].keys():
                                        dataName = self.getDataName(self['type'][par])
                                        if assetData.has_key(dataName):
                                            data = assetData[dataName]
                                            if type(data)==type([]):
                                                data = ','.join(data)
                                            self['type'][par].smartSetValue( data )

                            if assetData.has_key('assetInfo'):
                                for each in assetData['assetInfo'].keys():
                                    if each in self['info'].keys():
                                        self['info'][each].smartSetValue( assetData['assetInfo'][each] )
                                
                                if assetData['assetInfo'].has_key('description'):
                                    if 'description' in self['info'].keys():
                                        self['info']['description'].smartSetValue( "\n%s (desc versao: %s)" % (assetData['assetInfo']['description'], assetOldVersion) )

                # validate asset name and check for existing versions
                assetType = self.getAssetType()
                if assetType:
                    published = self.gatherAssets( assetType[0] )
                    if published.has_key(assetName):
                        versions = published[assetName]
                        versions.sort()
                        version = map(lambda x: int(x), os.path.basename(versions[-1]).split('.'))
                        self['info']['version'].smartSetValue(V3i(version[0],version[1]+1,version[2]))
                    else:
                        self['info']['version'].smartSetValue(V3i(1,0,0))    


