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

import pipe,os

# default libraries set
os.environ['GCC_VERSION'] = 'gcc-multi'

# default farm engine!
os.environ['PIPE_FARM_ENGINE'] = 'afanasy'


# setup apps global versions
# ===================================================================
pipe.version.set( wine      = '1.5.29.may3.2013.compholioPatch' )
pipe.version.set( maya      = '2018' )
# pipe.version.set( maya      = '2016.5' )
pipe.version.set( nuke      = '12.0v1' )
pipe.version.set( houdini   = 'hfs16.0.557' )
pipe.version.set( delight   = '11.0.12' )
pipe.version.set( mari      = '2.0v1' )
pipe.version.set( xpra      = '0.15.svn9672' )
pipe.version.set( arnold    = '5.1.0.1' )
pipe.version.set( realflow  = '10.1' )
pipe.version.set( prman     = '23.0' )
pipe.version.set( unreal    = '4.22.0.opengl' )


# version support dropped
# ===================================================================
if float(pipe.version.get('maya')) <= 2014:
    # maximum versions for maya 2014
    pipe.version.set( prman     = '20.11' )

if float(pipe.version.get('maya')) < 2018:
    # maximum versions for maya 2018
    pipe.version.set( prman     = '21.7' )


# set global library versions
# ===================================================================
if 'GCC_VERSION' in os.environ:
    pipe.version.set( python        = '2.7' )
    pipe.libs.version.set( python   = '2.7' )
    pipe.libs.version.set( freetype = '2.4.0' )
    pipe.libs.version.set( boost    = '1.61' )
    pipe.libs.version.set( openexr  = '2.0.0' )
    pipe.libs.version.set( ilmbase  = '2.0.0' )
    pipe.libs.version.set( pyilmbase= '2.0.0' )
    pipe.libs.version.set( oiio     = '1.8' )
    pipe.libs.version.set( tbb      = '4.4.6' )
    pipe.libs.version.set( pyqt     = '4.11.4' )
else:
    pipe.version.set( python        = '2.6.8' )
    pipe.libs.version.set( alembic  = '1.1.1' )
    pipe.libs.version.set( python   = '2.6.8' )
    pipe.libs.version.set( freetype = '2.3.5' )
    pipe.libs.version.set( openexr  = '2.0.0' )
    pipe.libs.version.set( ilmbase  = '2.0.0' )


# gaffer and cortex version need to be tested toguether!
# ===================================================================
if 'GCC_VERSION' in os.environ:
    pipe.version.set( gaffer        = '0.55' )
    pipe.libs.version.set( gaffer   = '0.55' )
    pipe.libs.version.set( cortex   = '10.0' )
    pipe.libs.version.set( appleseed= '2.0.5.beta' )
else:
    pipe.version.set( gaffer      = '2.0.0' )
    pipe.libs.version.set( cortex = '9.0.0.git_Oct_10_2014' )
    pipe.libs.version.set(  tbb   = '2.2.004' )
