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

import sys, os, glob
if os.environ.has_key('HOME'):
    mayaPath = os.path.abspath( '%s/tools/maya/plugins' % os.environ['HOME'] )
    sys.path.append( mayaPath )
    print mayaPath
    for a in glob.glob(mayaPath+'/*'):
        print a

try:
    import hradecCustomization 

    msocket=hradecCustomization.msocket()
    mel = msocket.mel
    connect = msocket.connect 
    save = msocket.save
    load = msocket.load

    try:
        msocket.connect()
    except Exception, msg: 
        print "can't connect to server %s\n\t%s" % ( str(msocket.url) , str(msg))
        print "starting server instead..."
        msocket.bind()
        print "m module running as server."

    del a, mayaPath, sys, os, glob, hradecCustomization
    
except:
    print >>sys.stderr, "Can't find hradecCustomization module!!"