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


class mocha(baseApp):

    def environ(self):
        # fix for: symbol lookup error: /usr/lib/libfontconfig.so.1: undefined symbol: FT_Done_MM_Var
        self.ignorePipeLib( "freetype" )
        self.ignorePipeLib( "libpng" )

        self['MOCHAPRO_INSTALL_DIR'] = self.path()

    def bins(self):
        return [
            ('mocha',  'opt/isl/mochaproV5/bin/mochapro'),
            ('mochapro',  'opt/isl/mochaproV5/bin/mochapro'),
        ]


    def userSetup(self, jobuser):
        ''' this method is implemented when we want to do especial folder structure creation and setup
        for a user in a shot'''
        self['MOCHA_PROJECT'] = jobuser.path('mocha')
        jobuser.mkdir( 'mocha' )
        jobuser.create()
