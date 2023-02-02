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


class gaffer_haven(baseLib):

    def environ(self):
        ''' as this is a python application, we don't have to setup anything
            since python is already setting it for us! '''

        if self.parent() in ['gaffer']:
            self['ftp_proxy'  ] = os.environ['PIPE_PROXY_SERVER']
            self['http_proxy' ] = os.environ['PIPE_PROXY_SERVER']
            self['https_proxy'] = os.environ['PIPE_PROXY_SERVER']

        gaffer.addon( self, extensions = self.path() )
        for each in self.toolsPaths():
            self['HAVENLIBRARY' ] = "%s/gaffer/gaffer_heaven/" % each
        self['SSL_CERT_FILE'] = "/etc/ssl/certs/ca-bundle.crt"
