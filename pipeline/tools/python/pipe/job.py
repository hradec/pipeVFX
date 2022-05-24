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
    if not job and 'PIPE_JOB' in os.environ:
        job = os.environ['PIPE_JOB']

    if job:
        jobs = [ os.path.basename(x) for x in pipe.cached.glob( "%s/*.*" % pipe.roots.jobs() ) if job in x.split('/')[3] ]
        if not jobs:
            available = [os.path.basename(x) for x in pipe.cached.glob( "%s/????.*" % pipe.roots.jobs() )]
            available.sort()
            raise Exception("\n\nRequested job '%s' doesn't exist! The options are:\n\t%s" % (job, '\n\t'.join(available)) )
        if len(jobs)>1:
            raise Exception("\n\nRequested job '%s' is part of the name of more than one job. The options are:\n\t%s" % (job, '\n\t'.join(jobs)) )
        job = jobs[0]

    if not job:
        return ''
    ret = "%s/%s" % (roots.jobs(), job)
    if not os.path.exists(ret):
        raise Exception("Job '%s' current set doesn't exist on disk! Please check your jobs folder!!" % (job))
    return ret

def currentShot(job=None, values=None):
    import os
    if not values:
        values='shot@'
        if 'PIPE_SHOT' in os.environ:
            values = os.environ['PIPE_SHOT']
    values = values.split('@')
    return '%s/%ss/%s' % ( current(job), values[0], values[1] )


class user():
    @staticmethod
    def create(app):
        ignore = [ 'python' ]
        if current() and app not in ignore:
            if 'PIPE_JOB' in os.environ:
                if 'PIPE_SHOT' in os.environ:
                    v = os.environ['PIPE_SHOT'].split('@')
                    j = pipe.admin.job()
                    j.mkuser('%ss/%s' % (v[0].lower(), v[1]), username(), app)
                    j.create()
                    os.chdir( j.shot.user().path(app) )
