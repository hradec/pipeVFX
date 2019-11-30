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

class redshift(baseApp):
    def environ(self):
        maya.addon(self,
            plugin = self.path("redshift4maya/$MAYA_VERSION"),
            script = self.path("redshift4maya/common/scripts"),
            icon = self.path("redshift4maya/common/icons"),
            renderDesc = self.path('redshift4maya/common/rendererDesc'),
            lib = [
                self.path('redshift4maya/$MAYA_VERSION/extensions'),
                self.path('bin'),
            ],
            preset = '',
            module = '',
            shelves = self.path('redshift4maya/common/shelves/$MAYA_VERSION_MAJOR'),
        )
        self['PYTHONPATH'] = self.path("redshift4maya/common/scripts")


    def bins(self):
        ret = [
            ('redshiftCmdLine', 'redshiftCmdLine'),
            ('redshiftTextureProcessor', 'redshiftTextureProcessor'),
        ]
        return ret

    # def license(self):
    #     # install license for the current machine
    #     import os
    #
    #     dir = '%s/.config/Next Limit Technologies' % os.environ['HOME']
    #     if not os.path.exists(dir):
    #         os.makedirs(dir)
    #     file = '%s/RealFlow2012.conf' % dir
    #     if os.path.exists(file):
    #         os.remove(file)
    #
    #     self['nextlimit_LICENSE']=os.environ['PIPE_REALFLOW_LICENSE']
    #     self['NL_LICENSE_MANAGER_ADDRESS']=os.environ['PIPE_REALFLOW_LICENSE'].split('@')[-1]
    #
    #
    # def userSetup(self, jobuser):
    #     self['RFSCENESPATH'] = jobuser.path('realflow/')
    #     self['RFOBJECTSPATH'] = jobuser.path('realflow/alembic/')
    #     # self['RFDEFAULTPROJECT'] = jobuser.path('realflow/default.flw')
    #     os.chdir( jobuser.path('realflow/')  )


#    def bin(self):
#        return "env LD_LIBRARY_PATH=%s:$LD_LIBRARY_PATH  %s" % (self.p.path('lib/python$PYTHON_VERSION_MAJOR/lib-dynload'), self.path('bin') )
