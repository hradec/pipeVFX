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


class gitkraken(baseApp):

    def macfix(self, macfixData):
        ''' overrides the root path
        this is called before everything else, including self.environ() '''

    def environ(self):
        ''' sets the environ to run the app '''
        # fix for: symbol lookup error: /usr/lib/libfontconfig.so.1: undefined symbol: FT_Done_MM_Var
        self.ignorePipeLib( "freetype" )

        # prevent from setting pipeVFX python environment
        self.ignorePipeLib( "python" )

        # atom needs internet, so we set the proxy here for it
        self['http_proxy'] = os.environ['PIPE_PROXY_SERVER']
        self['https_proxy'] = os.environ['PIPE_PROXY_SERVER']
        self['ftp_proxy'] = os.environ['PIPE_PROXY_SERVER']

    # def run(self, app):
    #     ''' override the command line
    #     this is called right before running the "app" command line,
    #     when all os.environ variables are set and ready. '''
    #     # os.system( '%s/bin/apm config set http-proxy %s' % (self.path(), os.environ['PIPE_PROXY_SERVER']) )
    #     # os.system( '%s/bin/apm config set https-proxy %s' % (self.path(), os.environ['PIPE_PROXY_SERVER']) )
    #     baseApp.run( self, app+' --no-sandbox --proxy-server="%s"' %  os.environ['PIPE_PROXY_SERVER'] )

    def bg(self, cmd, bin):
        ''' return True if a cmd or binary should run in background '''
        return True
