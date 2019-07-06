#!/bin/python2

import socket, sys, time

MESSAGE = "reboot now!"
def unicast():
    UDP_IP = sys.argv[1]
    UDP_PORT = 5005

    print "UDP target IP:", UDP_IP
    print "UDP target port:", UDP_PORT
    print "message:", MESSAGE

    sock = socket.socket(socket.AF_INET, # Internet
                         socket.SOCK_DGRAM) # UDP

    for n in range(4):
        sock.sendto(MESSAGE, (UDP_IP, UDP_PORT))
        time.sleep(0.075)


def multicast():
    import socket

    MCAST_GRP = '224.1.1.1'
    MCAST_PORT = 5007

    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM, socket.IPPROTO_UDP)
    sock.setsockopt(socket.IPPROTO_IP, socket.IP_MULTICAST_TTL, 2)

    for n in range(20):
        sock.sendto(MESSAGE, (MCAST_GRP, MCAST_PORT))
        time.sleep(0.075)


if len(sys.argv) > 1:
    unicast()
else:
    multicast()
