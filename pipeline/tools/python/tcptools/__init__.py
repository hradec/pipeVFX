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

from multiprocessing import Pool
from pprint import pprint
import subprocess
import shlex
import os, sys



dns={
    '192.168.0.12'  : '__HRADEC_GARAGEM_SWITCH__',
    '192.168.0.18'  : '__HRADEC_GARAGEM_ROUTER__',
    '192.168.0.19'  : '__WIFI_ROUTER__',
    '192.168.0.253' : '__VSPHERE__',
    '192.168.0.5'   : '__3DSERVER__',
    '192.168.0.3'   : '__NEXENTA__',
    '192.168.0.4'   : '__NEXENTA__',
}

switches_failsafe={
    'switchDownLeft.local' : '192.168.0.203',	
    'switchDownRight.local': '192.168.0.217',
    'switchUpLeft.local'   : '192.168.0.6',
}


os._subnet ='10.0.0'
def switches():
    ''' find all switches on the network, by using avahi-browse searching for switch* '''
    ret = {}
    for switch in os.popen( 'avahi-browse -at | grep switch' ).readlines():
        if 'switch' in switch:
            name = "%s.local" % switch.split()[3]
            ret[name] = os.popen( 'avahi-resolve -n %s' % name).readlines()[0].split()[-1].strip()
            
    if not ret:
        ret = switches_failsafe
    return ret

def getLocalMacIP(host=None):
    ''' uses route to get the main subnet, and then ifconfig to grab the local ip and mac address '''
    data = []
#    cmd = '''echo $( /sbin/ifconfig | grep -B1 $(echo $(/sbin/route -n | grep UG) | cut -d" " -f2 | cut -d"." -f1))''' 
    cmd = '''echo $( /sbin/ifconfig | grep -B1 %s )'''  % os._subnet 
    if host:
        cmd = "ssh %s '%s'" % (host, cmd)
    for each in os.popen( cmd ).readlines()[0].split('--'):
        ret = each.strip().split()
        if 'HWaddr' in each:
            #print ret, each.split('HWaddr')[1].strip().split()[0]
            mac = ret[ ret.index('HWaddr')+1 ]
            ip  = filter( lambda x: 'addr:' in x, ret )[0].split(':')[-1]
            data.append( (ip, mac) )
    return data
        
def ping(host):
    ''' a simple python wrapper for system ping '''
    command_line = "ping -r -w 3 -c 1 %s" % host
    args = shlex.split(command_line)
    try:
      subprocess.check_call(args,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
      return True
    except subprocess.CalledProcessError:
        command_line = "arping -c 1 %s" % host
        args = shlex.split(command_line)
        try:
          subprocess.check_call(args,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
          return True
        except subprocess.CalledProcessError:
          return False
  

def reverseDNS( ip ):
    ret = ''
    mac = ip[0]
    ip = ip[1]
    if not hasattr(os, 'avahi'):
        adns = {}
        for each in os.popen( 'avahi-browse -at' ).readlines():
            each = each.split()
            adns[each[4].strip('[').strip(']').upper()] = "%s.local" % each[3]
        os.avahi = adns
    adns = os.avahi 
    if adns.has_key(mac):
        ret = adns[mac]
    else:
        l = os.popen("avahi-resolve -4 -a %s 2>/dev/null" % ip).readlines()
        if l:
            ret = l[0].split()[-1].strip()
    if not ret.strip():
        if dns.has_key(ip):
            ret = dns[ip]
    return (ip,ret)

def hostnames( hosts, processes=32 ):
    ''' uses snmpwalk to find in what switch ports each host in the hosts dict is connected to '''
    p = Pool(processes)
    return p.map(reverseDNS, hosts)

 
def switchPort( hosts ):
    ''' uses snmpwalk to find in what switch ports each host in the hosts dict is connected to '''
    cmd = "snmpwalk -v1 -c public -O x  %s mib-2.17.7.1.2.2.1.2"
    ret = {}
    linkPorts = {}
    switchs = switches()
    snmp = {}
    for switch in switchs:
        snmp[switch] = os.popen( cmd % switchs[switch] ).readlines()
    
#    dnsList = hostnames( hosts.keys() )
    dnsList = hostnames( map( lambda x: (hosts[x],x), hosts ) )

    #print hosts
    for host in hosts:
        mac = hosts[host]
        if mac:
            dmac = '.'.join( map( lambda x: "%d" % int("0x%s" % x, 0), mac.split(':') ) )
            ret[ host ] = {
                "mac" : mac,
                "name" : filter( lambda x: host==x[0], dnsList)[0][1],
                "switch" : {},
            }
            for switch in switchs:
                ports = filter( lambda y: dmac in y, map( lambda x: x.strip(), snmp[switch] ) )
                if 'ports' not in ret[ host ]['switch']:
                    ret[ host ]['switch'] = {'ports':{}}
                ret[ host ]['switch']['ports'][switch] = map( lambda x: x.split()[-1], ports )
            
                if switchs[switch] == host:
                    ret[ host ]['name']=switch
                    ret[ host ]['switch']['isIt']=True

    # find link ports!
    for h in ret:
        if ret[h]['switch'].has_key('isIt'):
            for port in ret[h]['switch']['ports']:
                if port not in linkPorts:
                    linkPorts[port] = []
                linkPorts[port].extend( ret[h]['switch']['ports'][port] )
                
#    # clean link ports so host ports reflect the real connected port
    for h in ret:
        if not ret[h]['switch'].has_key('isIt'):
            if ret[h]['switch'].has_key('ports'):
                for port in ret[h]['switch']['ports']:
                    for l in linkPorts:
                        for n in range(len(ret[h]['switch']['ports'][l])):
                            if ret[h]['switch']['ports'][l][n] in linkPorts[l]:
                                del ret[h]['switch']['ports'][l][n]
        
    return ret

  
def pingSubnet(subnet='192.168.0', processes=128, r=255):
    ''' uses multi-thread pool to ping a bunch of ips at once.
    this function can ping a whole subnet an return alive hosts 
    in about 2-3 secs. Much faster than nmap!
    It also retrieves the arp cache and try to fill up each ip with it's 
    mac address. '''
    os._subnet = subnet
    ret = {}
    p = Pool(processes)
    hosts = map( lambda x: "%s.%d" % (subnet, x), range(1,r+1) )
    pingList = p.map(ping, hosts)
    arpList = map( lambda x: x.strip(), os.popen( 'arp -n' ).readlines() )
    count = 0
    for each in pingList:
        if each:
            ret[hosts[count]] = None
            arpLine = filter( lambda x: "%s " % hosts[count] in x, arpList )
            if arpLine:
                arp = arpLine[0].split()
                if len(arp)>3:
                    ret[hosts[count]] = arp[2].upper()
                else:
                    ret[hosts[count]] = arp[1]
        count += 1

    for each in getLocalMacIP():
        ret[each[0]] = each[1]
    return ret


switchMap = {
    'switchdownleft':'DL-',
    'switchdownright':'DR-',
    'switchupleft':'UL-',
    'switchDL':'DL-',
    'switchDR':'DR-',
    'switchUL':'UL-',
}
if __name__=='__main__':
    subnet='192.168.0'
    if len(sys.argv) > 1:
        subnet=sys.argv[1]
        
        
#    hosts = hostnames( pingSubnet('192.168.0') )
#    hosts = hostnames( map( lambda x: '192.168.0.%d' % (x+1), range(255) ) )
    hosts = switchPort( pingSubnet(subnet) )
#    pprint( hosts )
    
    ips = {}
    for each in hosts.keys():
        ips[int(each.split('.')[-1])] = each
    
    index = ips.keys()
    index.sort()
    for h in index:
        h = ips[h]
        print "%-16s | %-17s" % (h, hosts[h]['mac']), 
        ret = '|'
        for p in hosts[h]['switch']['ports']:
            if hosts[h]['switch']['ports'][p]:
                ret += "%s%02d|" % (switchMap[p.split('.')[0].lower()], int(hosts[h]['switch']['ports'][p][0]))
            else:
                ret += "%-5s|" % ' '
        print "%s %s" % (ret, hosts[h]['name'])
        
    print "Total: %d hosts" % len(hosts)
    
    
    