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


class teams(baseApp):

    def environ(self):
        # fix for: symbol lookup error: /usr/lib/libfontconfig.so.1: undefined symbol: FT_Done_MM_Var
        self.ignorePipeLib( "freetype" )

    def bins(self):
        return [
            ('teams',  'opt/teams-for-linux/teams-for-linux'),
        ]
    def run(self, app):
        extraOptions=""
        if os.environ.has_key('PIPE_PROXY_SERVER'):
            extraOptions += ' --proxy-server=%s ' % os.environ['PIPE_PROXY_SERVER']
            # extraOptions += ' --proxy-server=%s  --proxy-bypass-list="*.local;127.0.0.1;localhost"' % os.environ['PIPE_PROXY_SERVER']
        baseApp.run( self, app+extraOptions )

    def bg(self, cmd, bin):
        ''' return True if a cmd or binary should run in background '''
        return True
