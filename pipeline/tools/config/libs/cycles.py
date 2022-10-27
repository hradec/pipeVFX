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


class cycles(baseLib):
    def versions(self):
        ''' set the pipe python version according to houdinis python version '''
        if self.parent() in ['cycles']:
            cv = float('.'.join(pipe.libs.version.get( 'cycles' ).split('.')[:2]))
            if cv >= 3.2:
                pipe.version.set( python = '3.9' )
                pipe.libs.version.set( python = '3.9' )
                pipe.libs.version.set( openexr = '2.4.1' )
                pipe.libs.version.set( usd = '21.11.1' )
                pipe.libs.version.set( usd_non_monolithic = '21.11.1' )

    def environ(self):
        # fix for: symbol lookup error: /usr/lib/libfontconfig.so.1: undefined symbol: FT_Done_MM_Var
        self.ignorePipeLib( "freetype" )
        self.update(pipe.libs.cuda())
        self.update(pipe.libs.optix())
        self.update(pipe.libs.usd())
        self.update(pipe.libs.embree())

    def bins(self):
        subversions = cached.glob(self.path("*"))
        subversions.sort()
        return [
            ['cycles',  '%s/bin/cycles' % os.path.basename(subversions[-1])],
        ]
