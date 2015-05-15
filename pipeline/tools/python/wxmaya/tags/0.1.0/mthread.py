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

#
# mthread - a class to create proper python threads in maya.
#
# just derive this class to your own to create a custom threaded class
# that does realtime updates in maya.
#
#

##########################################################################
#
#  Copyright (c) 2010, Roberto Hradec. All rights reserved.
#
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions are
#  met:
#
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#
#     * Neither the name of Image Engine Design nor the names of any
#       other contributors to this software may be used to endorse or
#       promote products derived from this software without specific prior
#       written permission.
#
#  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
#  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
#  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
#  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
#  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
#  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
#  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
#  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
#  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
##########################################################################


import time, threading, sys
import m

global __objects
global __thread

try: 
    __objects
    __objects=[]
    time.sleep(1.1) # wait so all old threads can finish if module has being reloaded!
except:
    __objects=[]    
    

def startPumpThread():
    global __thread
    try: 
        __thread
    except:
        __thread = threading.Thread(target = threadPumpObjects, args = ())
        __thread.start() 

def addObjects(obj):
    global __objects
    if obj not in __objects:
        __objects.append(obj)
    startPumpThread()
    
def removeObjects(obj, all=False):
    global __objects
    if all:
        __objects=[]
    elif obj in __objects:
        del __objects[ __objects.index(obj) ]    

def threadObjects():
    global __objects
    return __objects

def threadPumpObjects():
    global __objects
    global __thread
    while(__objects):
        time.sleep(1)
        for each in __objects:
            def runScriptJob():
                m.scriptJob( runOnce=True,  idleEvent=each.thread )
            m.utils.executeInMainThreadWithResult( runScriptJob )
    del __thread


class mthread():
    def __init__(self):
        self.start()

    def thread(self):
        print '\n'.join( 
            filter(lambda x: str(self.__init__).split('<')[2].strip('>>') in x, m.scriptJob( listJobs=True ))
        ).strip()
        
    @staticmethod
    def threadList():
        return threadObjects()

    @staticmethod
    def stopAll():
        removeObjects(None,True)

    def start(self):
        addObjects(self)

    def stop(self,all=False):
        removeObjects(self,all)

    def __del__(self):
        self.stop()
