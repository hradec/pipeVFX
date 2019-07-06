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


import IECore, pipe, tempfile
from glob import glob
import os, datetime, sys

import genericAsset
from genericAsset import m
if m:
    reload(genericAsset)

class maya( genericAsset.maya ) :
    _color = IECore.Color3f( 0.1, 0.3, 0.2 ) + IECore.Color3f( 0.1 )
    def __init__( self ) :
        genericAsset.maya.__init__(self, 'animation')


    def doPublishMayaExport(self, fileName, operands):
        ''' we override doPublishMaya just to force meshPrimitives to be the default nodes! '''
        vdb = m.listConnections( m.ls(sl=1,dag=1,type='OpenVDBVisualize',l=1), type='OpenVDBRead')
        if vdb:
            self.data['extraFiles']=[]
            self.data['publishedVDB']={}
            for node in vdb:
                p = str(m.getAttr( '%s.VdbFilePath' % node )).strip()
                if p:
                    pattern = p[ p.index('$') : p.index('$')+p[p.index('$'):].index('.') ]
                    # python_pattern = pattern.replace('$','%').replace('F','0')+'d'
                    pp = p.replace(pattern, '*')

                    files = glob( pp )
                    if files and '/sam/animation/' not in p:
                        self.data['extraFiles'] += files
                        self.data['publishedVDB'][node] = [ "%s/%s" % (self.data['publishPath'], os.path.basename(x)) for x in files ]
                        m.setAttr( '%s.VdbFilePath' % node, "%s/%s" % (self.data['publishPath'], os.path.basename(p)), type='string' )

        ret = genericAsset.maya.doPublishMayaExport(self, fileName, operands)
        return ret

    def doImportMaya( self, filename, nodeName ):
        ''' called by SAM when import an asset in maya '''
        ret = genericAsset.maya.doImportMaya( self, filename, nodeName )
        return ret



IECore.registerRunTimeTyped( maya )
