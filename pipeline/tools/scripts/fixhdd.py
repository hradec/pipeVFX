#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
This script automatically re-writes sectors where
ATA read errors occur. By re-writing the sectors
(using hdparm), the HDD/SSD will be used to re-allocate
the sectors.

**EXTREMELY DANGEROUS**
This script will NOT ask before overwriting data
and might DESTROY all your data. Use it under your
own responsibility and only if you know EXACTLY
what you're doing (or if you don't care).
Expect fixhdd.py to contain critical bugs.

Runs on linux only. hdparm must be installed.

fixhdd.py must be run as root. It will only write to sectors
if reading them using hdparm yields an error.

Use fixhdd.py --loop to watch the syslog for read errors
and rewrite all sectors where errors occur. The script will
check the log every five seconds and won't exit.

Use fixhdd.py -a -o <offset> to scan for bad blocks starting at
LBA <offset>. Use this mode if a SMART selftest indicates an error
at a specific LBA and select an offset smaller than the given LBA.
Scanning a large number of LBAs takes a significant amount of time,
especially if many LBAs yield errors.

Use fixhdd -s <sector> to rewrite a specific LBA, but only
if reading it . Use this for correcting errors indicated by SMART
if you don't see the need for actively scanning a significant number
of blocks.

Use Ctrl+C to stop fixhdd.py.

Changelog:
    Revision 1.1: Fix --loop causing unary function to be called without arguments
    Revision 1.2: Fix hardcoded /dev/sda, various small improvements & fixes ; fix active scan
    Revision 1.3: Python3 ready
    Revision 1.4: Python3 fixes, fix bad/missing sense data & unusable logging
"""
import subprocess
import time
import os
import stat
import sys

__author__ = "Uli Köhler"
__copyright__ = "Copyright 2015-2016 Uli Koehler"
__license__ = "Apache License v2.0"
__version__ = "1.4"
__maintainer__ = "Uli Köhler"
__email__ = "ukoehler@techoverflow.net"
__status__ = "Development"

#Get list of recent bad sectors via dmesg
def getBadSectors(device):
    "Parse a list of recently read bad sectors from the syslog"
    #TODO this gets ALL bad sectors from ALL devices, not only the selected device
    try:
        out = subprocess.check_output('grep "end_request: I/O error" /var/log/syslog', shell=True)
        for line in out.split("\n"):
            line = line.strip()
            if not line: continue
            sector = int(line.rpartition(" ")[2])
            yield sector
    except subprocess.CalledProcessError:
        #usually this indicates grep has not found anything
        return


def isSectorBad(device, sector):
    try:
        output = subprocess.check_output('hdparm --read-sector %d %s' % (sector, device), shell=True, stderr=subprocess.STDOUT)
        output = output.decode("utf-8")
        # Special case: process succeeds but with error message:
        # SG_IO: bad/missing sense data
        if "bad/missing sense data" in output:
            return True
        # Else: Success => sector is not bad
        return False
    except:
        return True


def resetSectorHDParm(device, sector):
    """Write to a sector using hdparm only if reading it yields a HDD error"""
    #Will throw exception on non-zero exit code
    if isSectorBad(device, sector):
        print(("Sector %d is damaged, rewriting..." % sector))
        #Maaan, this is VERY DANGEROUS!
        #Really, no kidding. Might even make things worse.
        #It could work, but it probably doesn't. Ever.
        #Don't use if your data is worth a single dime to you.
        out = subprocess.check_output('hdparm --write-sector  %d --yes-i-know-what-i-am-doing %s' % (sector, device), shell=True)
        out = out.decode("utf-8")
        if "succeeded" not in out:
            print (red(out.decode("utf-8").replace("\n")))
    else:
        print(("Sector %d is OK, ignoring" % sector))
  
def fixBadSectors(device, badSectors):
    "One-shot fixing of bad sectors"
    print(("Checking/Fixing %d sectors" % len(badSectors)))
    [resetSectorHDParm(device, sector) for sector in badSectors]
      
def checkDmesgBadSectors(device, knownGoodSectors):
    #Grab sector list from dmesg
    dmesgBadSectors = set(getBadSectors(device))
    dmesgBadSectors.difference_update(knownGoodSectors)
    if len(dmesgBadSectors) == 0:
        print ("No new sector errors found in syslog :-)")
        #Update set of sectors which are known to be good
    else:
        fixBadSectors(device, dmesgBadSectors)
        knownGoodSectors.update(dmesgBadSectors)

def loopCheckForBadSectors(device):
    knownGoodSectors = set()
    while True:
        print("Waiting 5 seconds (hit Ctrl+C to interrupt)...")
        time.sleep(5)
        #Try again after timeout
        checkDmesgBadSectors(device, knownGoodSectors)

def isBlockDevice(filename):
    "Return if the given filename represents a valid block device"
    return stat.S_ISBLK(os.stat(filename).st_mode)

def getNumberOfSectors(device):
    "Get the physical number of LBAs for the given device"
    #Line like: 255 heads, 63 sectors/track, 60801 cylinders, total 976773168 sectors
    sectorsLine = subprocess.check_output("LANG=C fdisk -l {0} 2>/dev/null | grep ^Disk | grep sectors".format(device), shell=True)
    print(sectorsLine)
    return int(sectorsLine.strip().split(b" ")[-2])

def performActiveSectorScan(device, offset=0, n=1000):
    "Check all sectors on the hard drive for errors and fix them."
    print(("Performing active sector scan of {0} starting at {1}").format(device, offset))
    print((getNumberOfSectors(device)))
    for i in range(offset, min(getNumberOfSectors(device), offset + n)):
        #Reset sector (only if it is damaged)
        resetSectorHDParm(device, i)

if __name__ == "__main__":
    # Parse arguments
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument("-s", "--sector", nargs="*", default=[], type=int, help="A list of sectors to scan (beyond those listed in ")
    parser.add_argument("--loop", action="store_true", help="Loop and scan for bad sectors every few seconds")
    parser.add_argument("-a", "--active-scan", action="store_true", help="Actively scan all blocks for errors. Use --offset to start at a specific block.")
    parser.add_argument("-o", "--offset", default=0, type=int, help="For active scan, the block to start at")
    parser.add_argument("-n", default=1000, type=int, help="For active scan, the number of blocks to scan")
    parser.add_argument("device", default="/dev/sda", help="The device to use")
    args = parser.parse_args()
    #Check if the given device is a block device after all
    if not isBlockDevice(args.device):
        print("Error: device argument must be a block device")
        sys.exit(1)
    print(("Trying to fix bad sectors on %s" % args.device))
    # Always perform one-shot test
    checkDmesgBadSectors(args.device, set())
    # Fix manually added bad sector list
    fixBadSectors(args.device, args.sector)
    # Active sector scan
    if args.active_scan:
        performActiveSectorScan(args.device, args.offset, args.n)
    # If enabled, loop-check
    if args.loop: loopCheckForBadSectors(args.device)




