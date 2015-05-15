#!/bin/bash 

distro=debian_7_wheezy_aug_1_2014
kernel=3.12.17

folder=$(readlink -f $(dirname $BASH_SOURCE))

sudo rm -rf $folder/work
mkdir -p $folder/work/initramfs/{bin,sbin,etc,proc,sys,newroot,pipe,var,boot,lib,dev}
cd $folder/work
touch initramfs/etc/mdev.conf

#if [ ! -f initramfs/bin/busybox ] ; then 
#    wget http://jootamam.net/initramfs-files/busybox-1.10.1-static.bz2 -O - | bunzip2 > initramfs/bin/busybox 
#    cat ../src/busybox-1.10.1-static.bz2  | bunzip2 > initramfs/bin/busybox 
    cp ../src/busybox-1.21.0-static initramfs/bin/busybox
    chmod +x initramfs/bin/busybox 
    for each in $(initramfs/bin/busybox  --list)
    do
        ln -s busybox initramfs/bin/$each
        ln -s /bin/busybox initramfs/sbin/$each
    done
    


#fi
cat > initramfs/etc/fstab <<EOF
#$pipe     /atomo      nfs     ro,rsize=16384,wsize=16384,vers=3,intr,hard,timeo=4,retrans=10,udp
EOF


libs="
    libc.so.6
    ld-linux-x86-64.so.2
    libacl.so.1
    libpopt.so.0 
    libc.so.6
    libattr.so.1 
    linux-vdso.so.1
    libselinux.so.1
    librt.so.1
    libc.so.6
    libdl.so.2
    ld-linux-x86-64.so.2
    libpthread.so.0
"


for l in $libs
do
    for p in $(ldconfig -p | grep $l | grep x86_64 | cut -d'>' -f2)
    do
        echo "$p -> initramfs/lib/"
        cp -f $p initramfs/lib/
    done
done


sudo cp -rf /dev/console initramfs/dev/
cp -rf /sbin/v86d        initramfs/sbin/v86d
cp -f /usr/bin/rsync     initramfs/bin/rsync
cp -rf /sbin/udevd       initramfs/bin/udevd
cp -rf /etc/udev         initramfs/etc/



cat > initramfs/bin/hotplug << EOF
#!/bin/sh
test -n "$MODALIAS" && modprobe "$MODALIAS";
exec /bin/mdev
EOF

chmod a+x initramfs/bin/hotplug 

# farm ethernet board driver
mkdir -p initramfs/lib/modules/$kernel.AtomoLinux/kernel/drivers/net/ethernet/realtek
cp -rf ../src/r8168.ko.$kernel initramfs/lib/modules/$kernel.AtomoLinux/kernel/drivers/net/ethernet/realtek
cp -rf /atomo/netboot/distros/$distro/lib/modules/$kernel.AtomoLinux/kernel/drivers/net/ethernet/realtek/* initramfs/lib/modules/$kernel.AtomoLinux/kernel/drivers/net/ethernet/realtek



distro="/atomo/netboot/distros/$distro/"
kernels="
    $kernel.AtomoLinux
"
for k in $kernels
do
    mkdir -p initramfs/lib/modules/$k/kernel/fs/
    mkdir -p initramfs/lib/modules/$k/kernel/net/
    mkdir -p initramfs/lib/modules/$k/kernel/drivers/net/
    mkdir -p initramfs/lib/modules/$k/kernel/drivers/usb/host/
    mkdir -p initramfs/lib/modules/$k/kernel/drivers/hid/
    if [ -f $distro/lib/modules/$k/kernel/drivers/net/ethernet/realtek/r8169.ko ] ; then
        mkdir -p initramfs/lib/modules/$k/kernel/drivers/net/ethernet/realtek/
        cp -rf $distro/lib/modules/$k/kernel/drivers/net/ethernet/realtek/r8169.ko   initramfs/lib/modules/$k/kernel/drivers/net/ethernet/realtek/
    fi
    if [ -f $distro/lib/modules/$k/kernel/drivers/net/r8169.ko ] ; then
        cp -rf $distro/lib/modules/$k/kernel/drivers/net/r8169.ko   initramfs/lib/modules/$k/kernel/drivers/net/
    fi
#    cp -rf $distro/lib/modules/$k/kernel/drivers/net/mii.ko     initramfs/lib/modules/$k/kernel/drivers/net/
    cp -rf $distro/lib/modules/$k/kernel/fs/nfs*                initramfs/lib/modules/$k/kernel/fs/
    cp -rf $distro/lib/modules/$k/kernel/fs/fscache             initramfs/lib/modules/$k/kernel/fs/
#    cp -rf $distro/lib/modules/$k/kernel/fs/lockd               initramfs/lib/modules/$k/kernel/fs/
    cp -rf $distro/lib/modules/$k/kernel/net/sunrpc             initramfs/lib/modules/$k/kernel/net
    
    cp -rf $distro/lib/modules/$k/kernel/drivers/usb/host/* initramfs/lib/modules/$k/kernel/drivers/usb/host/
    cp -rf $distro/lib/modules/$k/kernel/drivers/hid/* initramfs/lib/modules/$k/kernel/drivers/hid/

    cp -f $distro/lib/modules/$k/* initramfs/lib/modules/$k/

done
cp -rf $distro/lib/firmware  initramfs/lib




mkdir -p initramfs/usr/share/udhcpc/
cat > initramfs/usr/share/udhcpc/default.script <<EOF
#!/bin/sh
echo \$ip > /var/dhcpfile
echo \$subnet >> /var/dhcpfile
echo \$router >> /var/dhcpfile
[ -n "\$broadcast" ] && BROADCAST="broadcast \$broadcast"
[ -n "\$subnet" ] && NETMASK="netmask \$subnet"
[ "\$interface" != "" ] && [ "\$ip" != "" ] && ifconfig \$interface \$ip \$BROADCAST \$NETMASK

if [ -n "\$router" ] ; then
    echo "deleting routers"
    route del default gw 0.0.0.0 dev \$interface
    for i in \$router ; do
            route add default gw \$i dev \$interface 1>&2 2>/dev/null
    done
fi
EOF
chmod a+rwx initramfs/usr/share/udhcpc/default.script


cat > initramfs/init <<EOF
#!/bin/sh

#Clear the screen
clear

getarg(){
    for each in \$(echo \$(cat /proc/cmdline)) ; do 
        [ "\$(echo \$each | cut -d'=' -f1)" == "\$1" ] && echo \$(echo \$each | cut -d'=' -f2)
    done
}

export LD_LIBRARY_PATH=/lib

#Mount things needed by this script
mount -t proc proc /proc
mount -t sysfs sysfs /sys
mount -t tmpfs tmpfs /var
#mount -t tmpfs mdev /dev
#mkdir /dev/pts
#mount -t devpts devpts /dev/pts

#touch /dev/mdev.seq
#touch /dev/mdev.log

depmod -a

ether=\$(cat /proc/net/dev | grep eth  | cut -d':' -f1)
if [ "\$ether" == "" ] ; then 
    modprobe r8168 # gigabit farm boards!!
fi
ether=\$(cat /proc/net/dev | grep eth  | cut -d':' -f1)
if [ "\$ether" == "" ] ; then 
    modprobe r8169 # gigabit farm boards!!
fi

modprobe ehci_pci
modprobe ehci_hcd
modprobe xhci_hcd

#/bin/udevd --daemon
#modprobe nfs

#echo /bin/hotplug > /proc/sys/kernel/hotplug
#mdev -s


#insmod /lib/modules/\$(uname -r)/e1000e.ko

#Disable kernel messages from popping onto the screen
echo 0 > /proc/sys/kernel/printk

#Create device nodes
mknod /dev/null c 1 3
mknod /dev/tty c 5 0
#mknod /dev/console c 5 0
mkdir -p /dev/shm
mount -t tmpfs tmpfs /dev/shm
#mdev -s

ether=\$(cat /proc/net/dev | grep eth  | cut -d':' -f1)
if [ "\$ether" == "" ] ; then 
    echo "====================================="
    echo "No Network Board Detected!!!"
    echo "====================================="
    echo "Starting a shell... "
    sh
fi

echo waiting network to show up
ip=\$(getarg pipe | cut -d':' -f1)
count=0
while [ "\$(ping  -c 1 \$ip 2>&1 | grep ' 0% packet loss')" == "" ]
do 
    for each in \$ether
    do
        echo trying to get IP from \$each
        ifconfig \$each 0.0.0.0
        echo -n '       '
        udhcpc -i \$each -p /tmp/udhcpc.\$each.pid -T 5 -A 1 -q -n -t 1
        count=\$(expr \$count + 1)
        if [ "\$count" == "20" ] ; then 
            echo "Cant find DHCP Server... going to a shell!!"
            busybox sh
        fi
    done
    sleep 1
    clear
done
echo

# Mount the the pipe device and grab the liveInit script
pipe=\$(echo \$(for each in \$(cat /proc/cmdline) ; do [ "\$(echo \$each | cut -d'=' -f1)" == "pipe" ] && echo \$each ; done) | cut -d'=' -f2)
echo \$pipe
mount -r -o nolock \$pipe /pipe

killall udevd

liveInit=\$(getarg liveInit)
if [ -f /pipe/\$liveInit ] ; then 
    cp /pipe/\$liveInit /var
    umount /pipe

    # run the liveInit script to mount the rootfs and switch to it!
    if [ "\$( cat /proc/version | grep 2.6.35 )" != "" ] ; then
        cp /var/liveInit /var/liveInit2
        cat /var/liveInit2 | sed 's/aufs/unionfs/g' > /var/liveInit
    fi
    . /var/liveInit
fi

#Check if $init exists and is executable
#if [[ -x "/newroot/${init}" ]] ; then
#	#Unmount all other mounts so that the ram used by
#	#the initramfs can be cleared after switch_root
#	umount /sys /proc
#	#Switch to the new root and execute init
#    echo "/newroot/${init}" 
#	exec switch_root /newroot "${init}"
#fi

#This will only be run if the exec above failed
echo "Failed to run liveInit, dropping to a shell"
echo "Failed to run liveInit, dropping to a shell"
exec sh

EOF
chmod +x initramfs/init

cd initramfs
find . | cpio -H newc -o > ../initramfs.cpio
cd ..
cat initramfs.cpio | gzip > $folder/initrd_dev.img


sudo cp $folder/initrd_dev.img         /atomo/netboot/tftp/networkBootWorkstation/initrd_dev.img 
sudo cp $folder/pxelinux.cfg/default   /atomo/netboot/tftp/pxelinux.cfg/default 
sudo cp $folder/pxelinux.cfg/menu.png  /atomo/netboot/tftp/networkBootWorkstation/menu.png 


sudo cp $distro/boot/vmlinuz-$kernel.AtomoLinux \
        /atomo/netboot/tftp/networkBootWorkstation/vmlinuz_dev





