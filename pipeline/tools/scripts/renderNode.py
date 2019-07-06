#!/bin/python2                                                            

import sys                                                                
sys.path.insert(0,'/atomo/pipeline/tools.versions/tools.newSamShave/python/')                                                                       

import pipe, sys, os                                                      

engine=pipe.farm.current.engine()

if len(sys.argv)<2:
	print '''

renderNode tools - version 1.0

A tool to manage and display information at afanasy render nodes.

	-f HOST_NAME_FILTER   - a string to select what nodes to use
	-s parameter value    - set a parameter value
	-l                    - list nodes

'''


host=""
if '-f' in sys.argv:
    id=sys.argv.index('-f')
    host=sys.argv[id+1]

if '-s' in sys.argv:
    if not host:
        print "You need to specify a host name filter to set parameter. Use -f '*' to set on all of then!!"
    else:
        if host=='*':
            host=""
        id=sys.argv.index('-s')
        param=sys.argv[id+1]
        value=sys.argv[id+2]
    
        print engine._renderNodeSet(host, param, value)

elif '-l' in sys.argv:
    lines=[]
    for each in  engine._renderNodes(host):
        lines += ["% 20s %s" % (each['name'],each['state'])]#, each.keys()

    lines.sort()
    for line in lines:
        print line


