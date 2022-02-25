#!/usr/bin/sh
PATH=/bin:/sbin

[ -e /proc/self/mounts ] \
    || (mkdir -p /proc && mount -t proc -o nosuid,noexec,nodev proc /proc)

grep -q '^sysfs /sys sysfs' /proc/self/mounts \
    || (mkdir -p /sys && mount -t sysfs -o nosuid,noexec,nodev sysfs /sys)

grep -q '^devtmpfs /dev devtmpfs' /proc/self/mounts \
    || (mkdir -p /dev && mount -t devtmpfs -o mode=755,noexec,nosuid,strictatime devtmpfs /dev)

grep -q '^tmpfs /run tmpfs' /proc/self/mounts \
    || (mkdir -p /run && mount -t tmpfs -o mode=755,noexec,nosuid,strictatime tmpfs /run)

# Load required modules
modprobe loop
modprobe overlay

# Mount the squash image
mount -t ramfs ramfs /squash
mkdir -p /squash/root /squash/overlay/upper /squash/overlay/work
PATH=/usr/sbin:/usr/bin:/sbin:/bin
nbd-client -p -systemd-mark 192.168.1.231 -name disk1 /dev/nbd0 || /bin/bash
nbd-client -p -systemd-mark 192.168.1.231 -name cow /dev/nbd1
mount /dev/nbd0 /squash/root
mount /dev/nbd1 /squash/overlay

# Setup new root overlay
mkdir /newroot
mount -t overlay overlay -o lowerdir=/squash/root,upperdir=/squash/overlay/upper,workdir=/squash/overlay/work/ /newroot/

# Move all mount points to new root to prepare chroot
mount --move /squash /newroot/squash

# Jump to new root and clean setup files
SYSTEMD_IN_INITRD=lenient exec switch_root /newroot /init
