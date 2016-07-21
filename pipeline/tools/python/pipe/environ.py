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


import log
from base import apps, LD_LIBRARY_PATH
from bcolors import bcolors
from os.path import expandvars
import os,sys

global initialized
try:
    initialized
except:
    initialized = os.environ.copy()


class environ(dict):
    def __init__(self, anotherEnviron={}, **args):
        dict.__init__(self)
        self.clear()
        args.update(anotherEnviron)
        environ.update(self, args )

    def getList(self, key):
        v = dict.__getitem__(self,key)
        if not v:
            return []
        return v

    def __getitem__(self, key):
        try:
            v = dict.__getitem__(self,key)
        except:
            v = ''
        if len(v)==1:
            return v[0]
        else:
            return v

    def __setitem__(self, key, v):
        '''
            Overrides default [] assignment.
            all keys are lists.
            if a key already exists, the passed value is append to the list.
        '''
        if not self.has_key(key):
            dict.__setitem__(self,key,[])
        if not type(v)==list:
            v = [v]
        for each in v:
            if each not in dict.__getitem__(self,key):
                dict.__getitem__(self,key).append(each)

    def insert(self, key, index, v):
        if not self.has_key(key):
            dict.__setitem__(self,key,[])
        if not type(v)==list:
            v = [v]
        for each in v:
            if each in dict.__getitem__(self,key):
                dict.__getitem__(self,key).remove(each)
            dict.__getitem__(self,key).insert(index, each)


    def update(self, environClass={}, **e):
        '''
            updates itself from a dict or from a bunch of parameters
            If another environ class (or any dict derivated class) is passed, it will go into environClass.
            if parameters are specified (like PATH=/tmp), the parameter name will be used as a key on self.
        '''
        # this is to account for disabled environments
        enable = True
        if hasattr( environClass, 'enable'):
            enable = environClass.enable
        if enable:
            e.update(environClass)
            for each in e.keys():
                self[each] = e[each]

    def replace(self, environClass={}, **e):
        '''
            replace itself from a dict or from a bunch of parameters
            If another environ class (or any dict derivated class) is passed, it will go into environClass.
            if parameters are specified (like PATH=/tmp), the parameter name will be used as a key on self.
        '''
        e.update(environClass)
        for each in e:
            if self.has_key(each):
                del self[each]
            self[each] = e[each]


    def evaluate(self):
        '''
            evaluates all keys as environment variables.
        '''
        global initialized
        # if we're running inside another app, don't reset os.environ
        if not initialized.has_key('__DB_LATEST'):
            os.environ.update( initialized )
        paths = {}
        for each in self.keys():
            l = self[each]
            if not l:
                del self[each]
            else:
                if each == 'LD_LIBRARY_PATH':
                    each = LD_LIBRARY_PATH
                    # reset environment LD_LIBRARY_PATH to avoid
                    # one app affecting the lib path of another
#                    del os.environ[each]
                if type(l) == type(""):
                    l=[l]
#                l.reverse()
                for value in filter(lambda x: x, l):

                    if not os.environ.has_key(each):
                        os.environ[each]=''

                    p = value
                    if p[0] in ['/']:
                        if os.path.abspath(p) not in os.environ[each].split(os.pathsep):
                            os.environ[each] = os.pathsep.join([ os.environ[each], os.path.abspath( p ) ])
                    else:
                        os.environ[each] = p
                    os.environ[each] = os.environ[each].strip(os.pathsep)

        keys = self.keys()
        keys.sort()
        log.debug( bcolors.WARNING+"="*200 )
        for each in keys:
            if each == 'LD_LIBRARY_PATH':
                each = LD_LIBRARY_PATH
            os.environ[each] = expandvars( os.environ[each] )
            # remove empty entries
            os.environ[each] = os.environ[each].replace(os.pathsep+os.pathsep,os.pathsep)
            log.debug( "%20s = %s "  % ( each,
                (os.pathsep+'\n'+' '*23).join(os.environ[each].split(os.pathsep)),
#                (os.pathsep+'\n'+' '*23).join(self[each].split(os.pathsep))
            ) )

            if each=='PYTHONPATH':
                sys.path.extend( os.environ[each].split(os.pathsep) )

        log.debug( bcolors.WARNING+"="*200+bcolors.END )

        # set opengl over ssh just in case
        #os.environ['LIBGL_ALWAYS_INDIRECT'] = '1'
