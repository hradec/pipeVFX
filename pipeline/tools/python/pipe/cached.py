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

import pickle, os, pwd
import glob as _glob

def __get_username():
    return pwd.getpwuid( os.getuid() )[ 0 ]

def __cached_name__(path):
    ret = '/dev/shm/cached__'+__get_username()+'_'
    for each in [os.path.sep,'"',"'"]:
        path = path.replace(each,'_')
    return ret+path

def __save__(data, cache):
    pickle.dump(data,open(cache,'w'))
    os.chmod(cache,0777)

def __load__(cache):
    return pickle.load(open(cache,'rb'))

def __exists__(cache):
    return os.path.exists( cache )


def cache_func(func, force=False):
    import traceback
    cache = __cached_name__(traceback.extract_stack(None, 2)[0][2])
    if __exists__( cache ) and not force:
        data = __load__(cache)
    else:
        data = func()
        __save__(data, cache)
    return data

def glob(path):
    cache = __cached_name__(path)
    if __exists__( cache ):
        data = __load__(cache)
    else:
        data = _glob.glob(path)
        __save__(data, cache)
    return data

class popen:
    def __init__(self, cmd):
        self.cache = __cached_name__(cmd)
        self.cmd = cmd
    def readlines(self):
        if __exists__( self.cache ):
            data = __load__(self.cache)
        else:
            data = os.popen(self.cmd).readlines()
            __save__(data, self.cache)
        return data

class copen:
    def __init__(self, file, mode='r'):
        self.cache = __cached_name__(file)
        self.file = file
        self.mode = mode
    def readlines(self):
        if __exists__( self.cache ):
            data = __load__(self.cache)
        else:
            f = open(self.file, self.mode)
            data = f.readlines()
            f.close()
            __save__(data, self.cache)
        return data
