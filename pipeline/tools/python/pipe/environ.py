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
    ''' base class for apps and libraries, which handle environment setup '''
    # set what envs cannot have more than one value!
    # if a value is assigned to a _SINGLE_ env that already has a value,
    # it will replace the old value.
    _SINGLE_=[]
    # set what envs cannot be updated after being set for the first time.
    # we need this for envs that should only be updated by the main app class
    _CANT_UPDATE_=[]
    _PARENT_ONLY_=[]
    def __init__(self, anotherEnviron={}, **args):
        dict.__init__(self)
        self.clear()
        args.update(anotherEnviron)
        environ.update(self, args )

    def parent(self):
        ''' return the top wrapper class called by the user '''
        return os.environ['PARENT_BASE_CLASS']

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
        # get the real name of the class
        if hasattr(self, 'className'):
            className = self.className
        else:
            className = str(self.__class__).split('.')[-1].strip("'>")

        # only the main parent can set the variable!!
        if key in self._PARENT_ONLY_ and self.parent() != className:
            log.debug( bcolors.WARNING+"WARNING: key [%s] can only be set in the main [%s] class (and currently has value [%s]), and it's being set by class [%s] with value [%s]!" % (key, self.parent(), self[key], className, v) + bcolors.END )
            return

        # if the key doesn't exist, or the key is in the _SINGLE_ list
        # (only one value) make sure to create the key with and empty list!
        if not key in self or key in self._SINGLE_:
            dict.__setitem__(self,key,[])

        # if the env already has a value, and can't be updated,
        # don't do anything!
        if dict.__getitem__(self,key) and key in self._CANT_UPDATE_:
            log.debug( bcolors.WARNING+"key %s already has a value %s and can't be updated with value %s" % (key, dict.__getitem__(self,key), v) + bcolors.END)
            return

        if not type(v)==list:
            v = [v]
        for each in v:
            if each and each not in dict.__getitem__(self,key):
                # only add non-paths or paths that exists!
                # if each[0]!='/' or '$' in each or os.path.exists(each):
                dict.__getitem__(self,key).append(each)

    def insert(self, key, index, v):
        if not key in self:
            dict.__setitem__(self,key,[])
        if not type(v)==list:
            v = [v]
        for each in v:
            if each in dict.__getitem__(self,key):
                dict.__getitem__(self,key).remove(each)
            # print key, index, type(dict.__getitem__(self,key)) ;sys.stdout.flush()
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
                self.__setitem__(each, e[each])

    def replace(self, environClass={}, **e):
        '''
            replace itself from a dict or from a bunch of parameters
            If another environ class (or any dict derivated class) is passed, it will go into environClass.
            if parameters are specified (like PATH=/tmp), the parameter name will be used as a key on self.
        '''
        e.update(environClass)
        for each in e:
            if each in self:
                del self[each]
            self[each] = e[each]


    def evaluate(self):
        '''
            evaluates all keys as environment variables.
        '''
        global initialized
        # if we're running inside another app, don't reset os.environ
        if not '__DB_LATEST' in initialized:
            os.environ.update( initialized )
        paths = {}

        # # cleanup LD_LIBRARY_PATH from inexistent paths
        # for VAR in ['LD_LIBRARY_PATH', 'PYTHONPATH']:
        #     tmp = {}
        #     for each in os.pathsep.join(self[VAR]).split(os.pathsep):
        #         if os.path.exists(expandvars(each)):
        #             tmp[each] = 1
        #     dict.__setitem__( self, VAR, tmp.keys() )

        for each in list(self.keys()):
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

                    if not each in os.environ:
                        os.environ[each]=''

                    p = value
                    if p[0] in ['/'] and each not in ['HOME']:
                        p = expandvars(p)
                        if os.path.abspath(p) not in os.environ[each].split(os.pathsep):
                            os.environ[each] = os.pathsep.join([ os.environ[each], os.path.abspath( p ) ])
                    else:
                        os.environ[each] = p
                    os.environ[each] = os.environ[each].strip(os.pathsep)


        keys = list(self.keys())
        keys.sort()
        log.debug( bcolors.WARNING+"="*200 )
        for each in keys:
            if each == 'LD_LIBRARY_PATH':
                each = LD_LIBRARY_PATH
            os.environ[each] = expandvars( os.environ[each] )
            # remove empty entries
            os.environ[each] = os.environ[each].replace(os.pathsep+os.pathsep,os.pathsep)
            # remove paths that don't exist
            if each in [LD_LIBRARY_PATH, 'PYTHONPATH', 'LIB', 'INCLUDE', 'PATH']:
                os.environ[each] = os.pathsep.join([ v for v in os.environ[each].split(os.pathsep) if os.path.exists(v) ])

            log.debug( "%20s = %s "  % ( each,
                (os.pathsep+'\n'+' '*23).join(os.environ[each].split(os.pathsep)),
#                (os.pathsep+'\n'+' '*23).join(self[each].split(os.pathsep))
            ) )

            if each=='PYTHONPATH':
                sys.path.extend( os.environ[each].split(os.pathsep) )

        # cleanup LD_LIBRARY_PATH from inexistent paths
        for VAR in [LD_LIBRARY_PATH, 'PYTHONPATH']:
            tmp = []
            if VAR in os.environ:
                for each in os.environ[VAR].split(os.pathsep):
                    if os.path.exists(each):
                        tmp.append(each)
                os.environ[VAR] = os.pathsep.join(tmp)


        log.debug( bcolors.WARNING+"="*200+bcolors.END )

        # set opengl over ssh just in case
        #os.environ['LIBGL_ALWAYS_INDIRECT'] = '1'
