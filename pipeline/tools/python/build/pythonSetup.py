
from  SCons.Environment import *
from  SCons.Builder import *
from  SCons.Defaults import *
from devRoot import *
from genericBuilders import *
import os,sys
import pipe


class pythonSetup(generic):
    src = 'setup.py'
    cmd = [
        'python setup.py install --prefix=$TARGET_FOLDER',
    ]

    def fixCMD(self, cmd):
        mkdir = 'mkdir -p $TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/site-packages/'
        if mkdir.replace(' ','').lower() not in cmd.replace(' ','').lower():
            cmd = "%s && %s" % (mkdir,cmd)
        return cmd
