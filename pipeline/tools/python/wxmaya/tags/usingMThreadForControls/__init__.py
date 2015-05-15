#!/usr/bin/env python2.5
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
if 'darwin' in sys.platform:
    sys.path.append('/System/Library/Frameworks/Python.framework/Versions/2.6/Extras/lib/python/wx-2.8-mac-unicode/')
    sys.path.append('/Library/Python/2.6/site-packages/')
del sys

import wx

import pyshell
reload(pyshell)
from pyshell import pyshell

import app
reload(app)
from app import wxmayaApps as appList, app

import mthread
reload(mthread)
from mthread import mthread


import m
reload(m)

import platform
reload(platform)

import log
reload(log)
import log

import demos
reload(demos)

import checkbox
reload(checkbox)
from checkbox import checkbox

import button
reload(button)
from button import button



