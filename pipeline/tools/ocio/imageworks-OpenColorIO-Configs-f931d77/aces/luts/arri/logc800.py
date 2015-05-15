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


import math

"""

// ARRI ALEXA IDT for ALEXA logC files
//  with camera EI set to 800
// Written by v3_IDT_maker.py v0.06 on Thursday 01 March 2012 by alex

float
normalizedLogCToRelativeExposure(float x) {
	if (x > 0.149659)
		return (pow(10,(x - 0.385537) / 0.247189) - 0.052272) / 5.555556;
	else
		return (x - 0.092809) / 5.367650;
}

"""

def logCToLinear(x):
	if (x > 0.149659):
		return (math.pow(10.0,(x - 0.385537) / 0.247189) - 0.052272) / 5.555556
	else:
		return (x - 0.092809) / 5.367650

def WriteSPI1D(filename, fromMin, fromMax, data):
    f = file(filename,'w')
    f.write("Version 1\n")
    f.write("From %s %s\n" % (fromMin, fromMax))
    f.write("Length %d\n" % len(data))
    f.write("Components 1\n")
    f.write("{\n")
    for value in data:
        f.write("        %s\n" % value)
    f.write("}\n")
    f.close()

def Fit(value, fromMin, fromMax, toMin, toMax):
    if fromMin == fromMax:
        raise ValueError("fromMin == fromMax")
    return (value - fromMin) / (fromMax - fromMin) * (toMax - toMin) + toMin

NUM_SAMPLES = 2**14
RANGE = (-0.125, 1.125)
data = []
for i in xrange(NUM_SAMPLES):
    x = i/(NUM_SAMPLES-1.0)
    x = Fit(x, 0.0, 1.0, RANGE[0], RANGE[1])
    data.append(logCToLinear(x))
WriteSPI1D('logc800.spi1d', RANGE[0], RANGE[1], data)
