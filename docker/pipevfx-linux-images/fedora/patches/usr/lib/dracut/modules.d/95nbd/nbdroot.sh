#!/usr/bin/sh

type getarg > /dev/null 2>&1 || . /lib/dracut-lib.sh

PATH=/usr/sbin:/usr/bin:/sbin:/bin

# Huh? Empty $1?
[ -z "$1" ] && exit 1

# Huh? Empty $2?
[ -z "$2" ] && exit 1

# Huh? Empty $3?
[ -z "$3" ] && exit 1

# root is in the form root=nbd:srv:port[:fstype[:rootflags[:nbdopts]]]
# shellcheck disable=SC2034
netif="$1"
nroot="$2"
NEWROOT="$3"

# If it's not nbd we don't continue
[ "${nroot%%:*}" = "nbd" ] || return

nroot=${nroot#nbd:}
nbdserver=${nroot%%:*}
if [ "${nbdserver%"${nbdserver#?}"}" = "[" ]; then
    nbdserver=${nroot#[}
    nbdserver=${nbdserver%%]:*}
    nroot=${nroot#*]:}
else
    nroot=${nroot#*:}
fi
nbdport=${nroot%%:*}
nroot=${nroot#*:}
nbdfstype=${nroot%%:*}
nroot=${nroot#*:}
nbdflags=${nroot%%:*}
nbdopts=${nroot#*:}

if [ "$nbdopts" = "$nbdflags" ]; then
    unset nbdopts
fi
if [ "$nbdflags" = "$nbdfstype" ]; then
    unset nbdflags
fi
if [ "$nbdfstype" = "$nbdport" ]; then
    unset nbdfstype
fi
if [ -z "$nbdfstype" ]; then
    nbdfstype=auto
fi

# look through the NBD options and pull out the ones that need to
# go before the host etc. Append a ',' so we know we terminate the loop
nbdopts=${nbdopts},
while [ -n "$nbdopts" ]; do
    f=${nbdopts%%,*}
    nbdopts=${nbdopts#*,}
    if [ -z "$f" ]; then
        break
    fi
    if [ -z "${f%bs=*}" -o -z "${f%timeout=*}" ]; then
        preopts="$preopts $f"
        continue
    fi
    opts="$opts $f"
done

# look through the flags and see if any are overridden by the command line
nbdflags=${nbdflags},
while [ -n "$nbdflags" ]; do
    f=${nbdflags%%,*}
    nbdflags=${nbdflags#*,}
    if [ -z "$f" ]; then
        break
    fi
    if [ "$f" = "ro" -o "$f" = "rw" ]; then
        nbdrw=$f
        continue
    fi
    fsopts=${fsopts:+$fsopts,}$f
done

getarg ro && nbdrw=ro
getarg rw && nbdrw=rw
fsopts=${fsopts:+$fsopts,}${nbdrw}

# XXX better way to wait for the device to be made?
i=0
while [ ! -b /dev/nbd0 ]; do
    [ $i -ge 20 ] && exit 1
    udevadm settle --exit-if-exists=/dev/nbd0
    i=$((i + 1))
done

echo -e "\n\n\n$DRACUT_SYSTEMD\n\n\n"
# If we didn't get a root= on the command line, then we need to
# add the udev rules for mounting the nbd0 device
if [ "$root" = "block:/dev/root" -o "$root" = "dhcp" ]; then
    printf 'KERNEL=="nbd0", ENV{DEVTYPE}!="partition", ENV{ID_FS_TYPE}=="?*", SYMLINK+="root"\n' > /etc/udev/rules.d/99-nbd-root.rules
    udevadm control --reload
    wait_for_dev -n /dev/root

    if [ -z "$DRACUT_SYSTEMD" ]; then
        type write_fs_tab > /dev/null 2>&1 || . /lib/fs-lib.sh

        write_fs_tab /dev/root "$nbdfstype" "$fsopts"

        printf '/bin/mount %s\n' \
            "$NEWROOT" \
            > "$hookdir"/mount/01-$$-nbd.sh
    else
        mkdir -p /run/systemd/system/sysroot.mount.d
        cat << EOF > /run/systemd/system/sysroot.mount.d/dhcp.conf
[Mount]
Where=/sysroot
What=/dev/root
Type=$nbdfstype
Options=$fsopts
EOF
        systemctl --no-block daemon-reload
    fi
    # if we're on systemd, use the nbd-generator script
    # to create the /sysroot mount.
fi

if ! [ "$nbdport" -gt 0 ] 2> /dev/null; then
    nbdport="-name $nbdport"
fi

if ! nbd-client -check /dev/nbd0 > /dev/null; then
    nbd-client -persist -swap -systemd-mark -readonly "$nbdserver" $nbdport /dev/nbd0 $opts || exit 1
    mkdir /tmp/cow
    # shellcheck disable=SC2086

    # if the machine has a local disk named CACHE, use it to store a copy of the NBD0 boot drive,
    # and boot from it, using COW with the local disk.
    cache=$(blkid | grep CACHE | awk -F':' '{print $1}')
    if [ "$cache" != "" ] ; then
    	fsck -y -v $cache >&2
    	mkdir -p /tmp/CACHE
    	mount $cache /tmp/CACHE
    	if [ -e /tmp/CACHE/.nbd0 ] ; then
    		labelCACHE=$(blkid -D /tmp/CACHE/.nbd0 | sed 's/ /\n/g' | grep LABEL | awk -F'"' '{print $2}')
    		labelNBD0=$(blkid -D /dev/nbd0 | sed 's/ /\n/g' | grep LABEL | awk -F'"' '{print $2}')
    		warn "NBD0  image md5: $labelNBD0"
    		warn "CACHE image md5: $labelCACHE"
    		if [ "$labelCACHE" != "$labelNBD0" ] ; then
    			UPDATE="1"
    		fi
    		mkdir /tmp/local_cache
    		mount -o ro /tmp/CACHE/.nbd0 /tmp/local_cache
    		if [ $? -ne 0 ] ; then
    			UPDATE="1"
    		fi
    		umount /tmp/local_cache > /dev/null 2>&1
    		rm -rf  /tmp/local_cache
    		if [ "$UPDATE" != "" ] ; then
    			warn "$(printf '\n\n\nUpdating cache with latest network boot drive. Please wait...\n\n')"
    			dd if=/dev/nbd0 of=/tmp/CACHE/.nbd0 bs=10M status=progress >&2
    			if [ $? -ne 0 ] ; then
    				warn "$(printf '\n\nFAILED TO COPY NBD0 TO CACHE DISK!!\n\n')"
    				sleep 15
    			else
    				warn "$(printf '\n\nFinished! Continuing boot...\n\n\n')"
    			fi
    		fi
    		warn "$(printf 'Creating writable area on cache disk...\n')"
    		fallocate -l 32G /tmp/CACHE/.cow
    		echo y | mkfs.ext4 /tmp/CACHE/.cow
    		mount -o rw /tmp/CACHE/.cow /tmp/cow
    		mkdir -p /tmp/cow/lower
    		mkdir -p /tmp/cow/upper
    		mkdir -p /tmp/cow/work
    		warn "$(printf 'Mounting NBD0 cached copy and writable area as root...\n')"
    		mount -o ro /tmp/CACHE/.nbd0 /tmp/cow/lower
    		mount -t overlay overlay -o lowerdir=/tmp/cow/lower,upperdir=/tmp/cow/upper,workdir=/tmp/cow/work /sysroot
    		if [ $? -ne 0 ] ; then
    			warn "$(printf 'FAILED MOUNTING ROOT USING CACHE DISK... Reverting to booting directly from NBD0 netboot disk...\n')"
    		else
    			mkdir -p /sysroot/mnt/CACHE
    			mount --make-private /
    			mount --move /tmp/CACHE /sysroot/mnt/CACHE
    		fi
    	fi
    fi
    # we dont have a local disk named CACHE, so lets just boot over NBD0, using NBD1 as a writable
    # cow disk. NBD standard cow seems to causes crashes when linux uses swap.
    # we replaced NBD standard cow by using overlayfs to mount a writable NBD1 over a read only ND0
    if [ "$(mount | grep overlay)" == "" ] ; then
    	warn "$(printf 'Mounting NBD0 netboot disk as root...\n')"
    	nbd-client -persist -swap -systemd-mark "$nbdserver" -N cow /dev/nbd1 $opts || exit 1
    	nbd-client -persist -swap -systemd-mark "$nbdserver" -N swap /dev/nbd2 $opts || exit 1
    	echo y | mkfs.ext4 /dev/nbd1
    	mount /dev/nbd1 /tmp/cow
    	mkdir -p /tmp/cow/lower
    	mkdir -p /tmp/cow/upper
    	mkdir -p /tmp/cow/work
    	mount /dev/nbd0 /tmp/cow/lower
    	mount -t overlay overlay -o lowerdir=/tmp/cow/lower,upperdir=/tmp/cow/upper,workdir=/tmp/cow/work /sysroot
    	if [ $? -ne 0 ] ; then
    		warn "$(printf 'FAILED MOUNTING ROOT USING NBD0 NETBOOT DISK!!!\n')"
    		sleep 5
    	else
    		mkdir -p /sysroot/mnt/CACHE
    		mount --make-private /
    		mount --move /tmp/CACHE /sysroot/mnt/CACHE
    	fi
    fi
    # this signs dracut that /sysroot is already mounted, so it's ready for chroot!
    # this way, dracut won't try to mount /dev/nbd0 as /sysroot anymore
    if [ -e /sysroot/mnt/CACHE ] ; then
	    echo "" > /tmp/nm.done
    fi
fi

need_shutdown
exit 0
