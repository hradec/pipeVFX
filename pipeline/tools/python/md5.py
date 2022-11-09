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
# This is based on the md5.py file by Gregory P. Smith (greg@krypto.org)
# Copyright (C) 2005, Licensed to PSF under a Contributor Agreement.
#
# It's a simple fix to maintain compatibility with python 2 md5 module!


import hashlib

class md5:
    def __init__(self, name):
        self.__md5 = hashlib.md5(name.encode("utf-8"))
    def hexdigest(self):
        return self.__md5.hexdigest()

new = md5

blocksize = 1        # legacy value (wrong in any useful sense)
digest_size = 16
