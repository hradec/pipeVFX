#!/usr/bin/python
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

import os,sys


try:
        import qb
except:
    if 'QBDIR' in os.environ:
        QBDIR = os.environ['QBDIR']
    else:
        if os.name == 'posix':
            if os.uname()[0] == 'Darwin':
                QBDIR = '/Applications/pfx/qube'
            else:
                QBDIR = '/atomo/apps/linux/x86_64/qube/current/qube-core/local/pfx/qube'

    sys.path.append('%s/api/python' % QBDIR)
    import qb

print qb.getresources()

'''
For updating resources, this is example from qube documentation (http://pipelinefx.com/docs/qube_python_html/)
qb.updateresources(resourceDict)

Update used/total counts for a dynamic global license resource
Parameters:
resourceDict (dict {name:(used, total)}) -name : of the resource to update
used : number of resources currently in use
total : total number of resources that can be used.

Example: qb.updateresource({'license.maya': (0, 100)})

'''
