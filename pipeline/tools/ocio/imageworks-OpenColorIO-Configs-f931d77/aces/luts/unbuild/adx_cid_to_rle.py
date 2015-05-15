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


import math, numpy

"""

const float REF_PT = (7120.0 - 1520.0) / 8000.0 * (100.0 / 55.0) - log10(0.18);

const float LUT_1D[11][2] = {
	{-0.190000000000000, -6.000000000000000},
	{ 0.010000000000000, -2.721718645000000},
	{ 0.028000000000000, -2.521718645000000},
	{ 0.054000000000000, -2.321718645000000},
	{ 0.095000000000000, -2.121718645000000},
	{ 0.145000000000000, -1.921718645000000},
	{ 0.220000000000000, -1.721718645000000},
	{ 0.300000000000000, -1.521718645000000},
	{ 0.400000000000000, -1.321718645000000},
	{ 0.500000000000000, -1.121718645000000},
	{ 0.600000000000000, -0.926545676714876}
};

	// Convert Channel Independent Density values to Relative Log Exposure values
	float logE[3];
	if ( cid[0] <= 0.6) logE[0] = interpolate1D( LUT_1D, cid[0]);
	if ( cid[1] <= 0.6) logE[1] = interpolate1D( LUT_1D, cid[1]);
	if ( cid[2] <= 0.6) logE[2] = interpolate1D( LUT_1D, cid[2]);

	if ( cid[0] > 0.6) logE[0] = ( 100.0 / 55.0) * cid[0] - REF_PT;
	if ( cid[1] > 0.6) logE[1] = ( 100.0 / 55.0) * cid[1] - REF_PT;
	if ( cid[2] > 0.6) logE[2] = ( 100.0 / 55.0) * cid[2] - REF_PT;
"""


def interpolate1D(x, xp, fp):
    return numpy.interp(x, xp, fp)

LUT_1D_xp = [-0.190000000000000, 
              0.010000000000000,
              0.028000000000000,
              0.054000000000000,
              0.095000000000000,
              0.145000000000000,
              0.220000000000000,
              0.300000000000000,
              0.400000000000000,
              0.500000000000000,
              0.600000000000000]

LUT_1D_fp = [-6.000000000000000, 
             -2.721718645000000,
             -2.521718645000000,
             -2.321718645000000,
             -2.121718645000000,
             -1.921718645000000,
             -1.721718645000000,
             -1.521718645000000,
             -1.321718645000000,
             -1.121718645000000,
             -0.926545676714876]

REF_PT = (7120.0 - 1520.0) / 8000.0 * (100.0 / 55.0) - math.log(0.18, 10.0)

def cid_to_rle(x):
    if x <= 0.6:
        return interpolate1D(x, LUT_1D_xp, LUT_1D_fp)
    return (100.0 / 55.0) * x - REF_PT

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

NUM_SAMPLES = 2**12
RANGE = (-0.19, 3.0)
data = []
for i in xrange(NUM_SAMPLES):
    x = i/(NUM_SAMPLES-1.0)
    x = Fit(x, 0.0, 1.0, RANGE[0], RANGE[1])
    data.append(cid_to_rle(x))

WriteSPI1D('adx_cid_to_rle.spi1d', RANGE[0], RANGE[1], data)

