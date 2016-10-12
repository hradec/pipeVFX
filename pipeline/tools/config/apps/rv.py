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


class rv(baseApp):
    def environ(self):
        ''' as this is a python application, we don't have to setup anything
            since python is already setting it for us! '''


        self['RV_LUT_PATH']='/atomo/pipeline/tools/ocio/imageworks-OpenColorIO-Configs-f931d77/nuke-default/luts/'
        self['RV_LICENSE_DEBUG']='1'
#        RV_PREFS_OVERRIDE_PATH
#        RV_PREFS_CLOBBER_PATH
#        RV_SUPPORT_PATH

    def dotAppName(self):
        return "RV64.app"

    def bins(self):
        if self.osx:
            return [('rv','RV  -noaudio')]
        return [('rv','rv.bin -noaudio')]

    def license(self):
        self['RV_LICENSE_FILE'] = "/tmp/rv_license_%s.txt" % os.environ['USER']

    def userSetup(self, jobuser):
        os.chdir( jobuser.pwd )
