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

import pipe

# default farm engine!
#os.environ['PIPE_FARM_ENGINE'] = 'afanasy'

# setup apps global versions
# ===================================================================
pipe.version.set( wine      = '1.5.29.may3.2013.compholioPatch' )
pipe.version.set( maya      = '2016.5' )
#pipe.version.set( maya      = '2014' )
pipe.version.set( nuke      = '9.0v8' )
pipe.version.set( houdini   = 'hfs14.0.201.13' )
pipe.version.set( houdini   = 'hfs15.5.480' )
pipe.version.set( delight   = '11.0.12' )
pipe.version.set( mari      = '2.0v1' )
pipe.version.set( xpra      = '0.15.svn9672' )
#pipe.version.set( arnold    = '1.4.2.4.1' )
pipe.version.set( arnold    = '4.1.3.3' )
pipe.version.set( realflow  = '2015' )
pipe.version.set( prman     = '20.11' )
pipe.version.set( slic3r    = '1.1.7' )

# set global library versions
# ===================================================================
# pipe.libs.version.set( freetype = '2.3.5' )
#pipe.libs.version.set( qt= '4.7.1' )
pipe.libs.version.set( alembic= '1.5.8' )
pipe.libs.version.set( boost= '1.55.0' )
pipe.libs.version.set( openexr= '2.2.0' )
pipe.libs.version.set( ilmbase= '2.2.0' )


# gaffer and cortex version need to be tested toguether!
# ===================================================================
#pipe.version.set( gaffer    = '0.75.0' )
#pipe.libs.version.set( cortex = '8.0.0.git_Aug_20_2013' )
#pipe.version.set( gaffer    = '0.95.0' )
#pipe.libs.version.set( cortex = '8.4.7' )
#pipe.version.set( gaffer    = '0.95.0' )
pipe.version.set( gaffer    = '2.0.0' )
#pipe.libs.version.set( cortex = '9.0.0' )
# pipe.libs.version.set( cortex = '9.0.0.git_Oct_10_2014' )
# pipe.libs.version.set( cortex = '9.8.0' )
pipe.libs.version.set( cortex = '9.11.3' )



# pipe.version.set( python    = '2.6.8' )
# pipe.libs.version.set( python='2.6.8' )
#
# pipe.version.set( python    = '2.6.9' )
# pipe.libs.version.set( python = pipe.version.get('python') )
