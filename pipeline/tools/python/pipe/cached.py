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

import pickle, os, pwd, sys
import glob as _glob

def __get_username():
    ''' return the username + the python version, so pickle files are saved
    for their correct python version '''
    return pwd.getpwuid( os.getuid() )[ 0 ] + '_' + sys.version.split(' ')[0]

def __cached_name__(path):
    ''' construct the cache filename - use /dev/shm which is
    a ramdisk for speed '''
    dir = '/dev/shm/cached__'+__get_username()
    ret = dir+'/___'
    if not os.path.exists(dir):
        os.system('mkdir -p %s' % dir)
    for each in [os.path.sep,'"',"'"]:
        path = path.replace(each,'_')
    return ret+path

def __save__(data, cache):
    ''' save result into cache memory '''
    pickle.dump(data,open(cache,'wb'))
    os.chmod(cache,0o777)

def __load__(cache):
    ''' load result from cache '''
    ret = None
    if __exists__( cache ):
        with open(cache,'rb') as file:
            try:
                ret = pickle.loads(file.read())
            except:
                os.system('rm -rf "%s"' % cache)
    return ret

def __exists__(cache):
    ''' just check if file exists '''
    if os.path.exists( cache ):
        return True
    return False

def cache_func(func, force=False, cache_name=None):
    ''' run any python function and cache the return result '''
    import traceback
    if not cache_name:
        cache_name = traceback.extract_stack(None, 2)[0][2]
    cache = __cached_name__(cache_name)
    data = __load__(cache)
    if not data or force:
        data = func()
        __save__(data, cache)
    return data

def glob(path):
    ''' cache the return result of glob '''
    cache = __cached_name__(path)
    data = __load__(cache)
    if not data:
        data = _glob.glob(path)
        __save__(data, cache)
    return data

def exists(path):
    ''' cache the return result if files exist '''
    cache = __cached_name__(path+"_exists_")
    data = __load__(cache)
    if not data:
        data = os.path.exists(path)
        __save__(data, cache)
    return data

class popen:
    ''' run popen and cache the return result
    perfect to cache results from shell commands '''
    def __init__(self, cmd, cache_name=None):
        if not cache_name:
            cache_name = cmd
        self.cache = __cached_name__(cache_name)
        self.cmd = cmd
    def readlines(self):
        data = __load__(self.cache)
        if not data:
            data = os.popen(self.cmd).readlines()
            __save__(data, self.cache)
        return data

class copen:
    ''' run python open and cache the result.
    this essentiall caches file content in memory '''
    def __init__(self, file, mode='r'):
        self.cache = __cached_name__(file)
        self.file = file
        self.mode = mode
    def readlines(self):
        data = __load__(self.cache)
        if not data:
            f = open(self.file, self.mode)
            data = f.readlines()
            f.close()
            __save__(data, self.cache)
        return data
