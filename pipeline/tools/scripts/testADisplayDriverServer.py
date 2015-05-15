#!/usr/bin/env cpython
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

import unittest
import os
import gc
import glob
import sys
import time
from IECore import *
from pprint import pprint
            
def testTransfer(  ):
    f ="/home/rhradec/pics/Totoro_by_littlemeow.jpg"
    if len(sys.argv) > 1:
        f = sys.argv[1]
    img = Reader.create( f )()
    red = img['R'].data
    green = img['G'].data
    blue = img['B'].data
    width = img.dataWindow.max.x - img.dataWindow.min.x + 1

    params = CompoundData()
    params['displayHost'] = StringData('localhost')
    params['displayPort'] = StringData( '1559' )
    params["remoteDisplayType"] = StringData( "NukeDisplayDriver" )
    params["handle"] = StringData( "test" )
    print img.displayWindow, img.dataWindow, map( lambda x: x.lower(), list( img.channelNames() ) ), params
#    idd = ClientDisplayDriver( img.displayWindow, img.dataWindow, list( img.channelNames() ), params )
    idd = ClientDisplayDriver( img.displayWindow, img.dataWindow, list( img.channelNames() ), params )
#    pprint( dir(idd) )

#    idd.imageData( Box2i( V2i( img.dataWindow.min.x, img.dataWindow.min.y ), V2i( img.dataWindow.max.x, img.dataWindow.max.y) ), buf )

    buf = FloatVectorData( width * 3 )
    def __prepareBuf(  buf, width, offset, red, green, blue ):
            for i in xrange( 0, width ):
                buf[3*i] = blue[i+offset]
                buf[3*i+1] = green[i+offset]
                buf[3*i+2] = red[i+offset]		
    for i in xrange( 0, img.dataWindow.max.y - img.dataWindow.min.y + 1 ):
        __prepareBuf( buf, width, i*width, red, green, blue )
#        print Box2i( V2i( img.dataWindow.min.x, i + img.dataWindow.min.y ), V2i( img.dataWindow.max.x, i + img.dataWindow.min.y) ), len(buf)
        idd.imageData( Box2i( V2i( img.dataWindow.min.x, i + img.dataWindow.min.y ), V2i( img.dataWindow.max.x, i + img.dataWindow.min.y) ), buf )
#    idd.imageClose()
    
#    newImg = ImageDisplayDriver.removeStoredImage( "myHandle" )
    params["clientPID"] = IntData( os.getpid() )
    print params["clientPID"] 
    # remove blindData for comparison
#    newImg.blindData().clear()
#    img.blindData().clear()


testTransfer()
        