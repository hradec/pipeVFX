#!/usr/bin/python
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


import os
import subprocess, threading


groups = {
    'Multiple - Atomo  WIFI' : 'DL-04',
    'Multiple - Atomo2 WIFI' : 'DR-11',
    'Multiple - Castelinho'  : 'UL-11',
#    '192.168.0.2 3DServer' : '192.168.0.2\t',

}

links = {
    'LINK - DownLeft'   : 'UL-28',
    'LINK - DownRight'  : 'DL-13',
    'LINK - UpLeft'     : 'DL-46',
    'LINK - DownLeft'   : 'DR-01',         
}


switchMap = {
    'switchDownLeft':'DL-',
    'switchDownRight':'DR-',
    'switchUpLeft':'UL-',
    'switchDL':'DL-',
    'switchDR':'DR-',
    'switchUL':'UL-',
}

scanned = os.popen( '/atomo/pipeline/tools/scripts/scanMacAlive' ).readlines()
#scanned = os.popen( '/atomo/pipeline/tools/python/tcptools/__init__.py' ).readlines()


grabGraphs = '''mysql cacti -e "select title_cache from graph_templates_graph where title_cache like '%switch%'" '''
storeGraph = '''mysql cacti -e "update graph_templates_graph set title_cache='%s' where title_cache='%s'"'''
for each in os.popen(grabGraphs ).readlines():
    if 'switch' in each:
        each = each.replace('|','').replace('|','').strip()
        fields = map( lambda x: x.strip(), each.split(' ') )
        port = '%02d' % int(fields[0].split('-')[-1])
        switch = switchMap[fields[0].split('-')[0]].replace('-','')
        
        try:
            hostLine = filter( lambda x: '%s-%s' % (switch, port) in x, scanned )[0]
            host = "%s %s" % (
                hostLine.split('|')[0].strip(),
                hostLine.split('|')[5].strip(),
            )
            for g in groups:
                if groups[g] in hostLine:
                    host = g
                    break
            print host, hostLine
            
                
            
        except:
            host = ''
            
        for l in links:
            if links[l] in "%s-%s" % (switch, port):
                host = l
                break                
    
        title = "switch%s-%s %s" % (switch, port, host) 
        

        mysql = storeGraph % (title, each)
#        print mysql
        os.system(mysql)
