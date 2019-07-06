#!/usr/bin/env ppython


import sys, os
from assetUtils import assetOP
import pipe
import IECore
from pprint import pprint

pipe.apps.cgru().expand()
import af

del os.environ['DISPLAY']

a=assetOP(sys.argv[1])
a.loadOP()
a.data['assetClass']['RenderEngine']= IECore.StringData('renderManRIS')

if len(sys.argv) > 2:
    fi=sys.argv[2]
    fe=sys.argv[3]
#    pprint (a.data['assetClass'])
    a.data['assetClass']['FrameRange']['range'] = IECore.V3fData( IECore.V3f( float(fi), float(fe), 1.0 ) )
#    pprint (a.data['assetClass'])

pprint(a.data)
result=a.submission()
pprint(result)



#r = [ x for x in af.Cmd().getJobList(False) if x.has_key('folders') and a.data['publishPath'] in x['folders']['output'] ] 

#print dir(af)
#print '-'*80
##print af.Cmd().data(r[0]['id'])
#print '-'*80
#print type(r[0])
#for n in r[0].keys():
#	print '-'*80
#	print n
#	print r[0][n]

#af.Cmd().action('jobs', [r[0]['id']], 'S', [3])
