#!/usr/bin/env python
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


import sys
import subprocess as sp
import os
def main(flags):
	linux = '/atomo/apps/linux/x86_64/maya/2014/bin/Render'
	mac = '/atomo/apps/darwin/x86_64/maya/2014/Maya.app/Contents/bin/Render'
	if sys.platform == 'linux2':
		arglist = []
		for x in sys.argv:
			arglist.append(x)
		exec_linux = linux + ' ' + ' '.join(arglist[1:])
		#sp.Popen([execute],stdout=sp.PIPE)
		os.popen(exec_linux)
		print 'Executed on %s' % sys.platform[:-1]
	else:
		arglist = []
                for x in sys.argv:
                        arglist.append(x)
                exec_mac = mac + ' ' + ' '.join(arglist[1:])
                #sp.Popen([execute],stdout=sp.PIPE)
                os.popen(exec_mac)
		print 'Executed on %s' % sys.platform
if __name__ == '__main__':
	main(sys.argv[1:])
