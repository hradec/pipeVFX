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


class davinci(baseApp):

    def environ(self):
        # fix for: symbol lookup error: /usr/lib/libfontconfig.so.1: undefined symbol: FT_Done_MM_Var
        self.ignorePipeLib( "freetype" )
        #/var/BlackmagicDesign
        sudo = pipe.admin.sudo()
        sudo.cmd("mkdir -p '/var/BlackmagicDesign'")
        sudo.cmd("chmod a+rwx '/var/BlackmagicDesign'")
        sudo.run()


    def bg(self, cmd, bin):
        ''' return True if a cmd or binary should run in background '''
        return True

    def bins(self):
        # we want to limit houdini wrappers to just houdini!
        return [
            ('resolve'  ,'resolve'),
        ]
