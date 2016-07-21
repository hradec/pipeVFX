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



from base import roots
import pipe
import pwd, os

try:
    import admin
except:
    admin=None

    
def current(job=None):
    import os
    if not job:
        if os.environ.has_key('PIPE_JOB'):
            job = os.environ['PIPE_JOB']
    if not job:
        return ''
    return "%s/%s" % (roots.jobs(), job)
    

def currentShot(job=None, values=None):
    import os
    if not values:
        values='shot@'
        if os.environ.has_key('PIPE_SHOT'):
            values = os.environ['PIPE_SHOT']
    values = values.split('@')
    return '%s/%ss/%s' % ( current(job), values[0], values[1] )


class user():
    @staticmethod
    def create(app):
        ignore = [ 'python' ]
        if current() and app not in ignore:
            if os.environ.has_key('PIPE_JOB'):
                if os.environ.has_key('PIPE_SHOT'):
                    v = os.environ['PIPE_SHOT'].split('@')
                    j = pipe.admin.job()
                    j.mkuser('%ss/%s' % (v[0].lower(), v[1]), username(), app)
                    j.create()
                    os.chdir( j.shot.user().path(app) )
                    
