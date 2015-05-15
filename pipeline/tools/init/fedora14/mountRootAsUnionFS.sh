#!/bin/bash
#
# Sets up a readonly root filesystem to be used as a normal
# writable root filesystem! 
#
# We need to add this to the top of /etc/rc.sysinit
# so it runs before the whole fedora initialization!!!
#
#
getarg(){
    for each in $(echo $(cat /proc/cmdline)) ; do 
        #echo "===>$each" ; 
        [ "$(echo $each | cut -d'=' -f1)" == "$1" ] && \
            echo $each | cut -d'=' -f2 
    done
}


atomo="192.168.0.9:/mnt/STORAGE/ATOMOPIPELINE/"
nfsRoot=$(getarg root)
nfsRoot="$(echo $nfsRoot | cut -d':' -f2):$(echo $nfsRoot | cut -d':' -f3)"
#"$atomo/home/rhradec/$(cat /proc/cmdline | cut -d' ' -f3 | cut -d':' -f3 | rev | cut -d'/' -f2 | rev)/"

echo "=============================================================="

ulimit -n 16384

/sbin/modprobe squashfs
/sbin/modprobe fuse


# mount /atomo and also mount our read only root file system 
# into /boot/rootRO to be unionfs'ed wiht a tmpfs in /boot/rootRW
/bin/mount -t nfs -o nolock,rsize=16384,wsize=16384,hard,intr,timeo=4,retrans=10,vers=3,udp $atomo /atomo

# create folders to hold read-only and read-write filesystems. 
/bin/mount -t tmpfs tmpfs  /boot/
mkdir /boot/rootRO
mkdir /boot/rootRW
mkdir /boot/root


#/bin/mount  -o loop -t squashfs /atomo/home/rhradec/networkBoot_fedora14_20_06_2013.sqsh /boot/rootRO
/bin/mount -t nfs -o ro,nolock,rsize=16384,wsize=16384,hard,intr,timeo=4,retrans=10,vers=3,udp $nfsRoot /boot/rootRO

# unionfs all these folders so they become temporarly writable
list="  /etc \
        /tmp \
        /opt \
        /root \
        /mnt \
        /media \
        /lib \
        /lost+found \
        /home \
        /usr \
        /var \
"

# mount writable folders for booting
#/usr/local/bin/unionfs -o dirs=/boot/rootRW=RW:/boot/rootRO=RO,cow,allow_other,hide_meta_files  /boot/root
mount -t unionfs -o dirs=/boot/rootRW=rw:/boot/rootRO=ro unionfs /boot/root
for P in $list
do
    mount --bind /boot/root$P $P
done

# start ssh server here so we can login during boot, if necessary!
/usr/sbin/sshd
ifconfig

# setup log folder
setupLog(){
    # copy the up2date rc.local from the pipeline template 
    cp /atomo/pipeline/tools/init/fedora14/etc_rc.local.example /etc/rc.local 

    getETH=e`/sbin/route -n | /bin/grep UG | /bin/cut -d'e' -f2`
    macAddres=$(/sbin/ifconfig $getETH | /bin/grep HWaddr | cut -d' ' -f11 | sed 's/\://g')

    mkdir -p "/atomo/home/.networkBoot/$macAddres/log/"
#    rm -rf /var/log/*
#    cp -rf /boot/rootRO/var/log/* "/atomo/home/.networkBoot/$macAddres/log/"
    chown 42:42 "/atomo/home/.networkBoot/$macAddres/log/gdm"
    rm -rf /var/log
    ln -s "/atomo/home/.networkBoot/$macAddres/log" /var
    touch /var/log/lastlog
    chmod a+rw /tmp
    mkdir -p /var/tmp
    chmod a+rw /var/tmp
}
setupLog

# setup disk environment
setupDiskEnvironment(){
    cat >  /etc/fstab <<EOF
tmpfs                   /dev/shm                tmpfs   defaults        0 0
devpts                  /dev/pts                devpts  gid=5,mode=620  0 0
sysfs                   /sys                    sysfs   defaults        0 0
proc                    /proc                   proc    defaults        0 0
EOF
    echo "" > /etc/mtab
}
#setupDiskEnvironment

# setup network environment
setupNetwork(){
    cat >  /etc/resolv.conf <<EOF
domain atomovfx.local
search atomovfx.local local
nameserver 192.168.0.1
nameserver 208.67.222.222
nameserver 208.67.220.220
EOF

    rm /etc/sysconfig/network-scripts/ifcfg-eth0
    rm -rf /etc/rc?.d/*NetworkManager*
    rm -rf /etc/rc?.d/*ware*
    rm -rf /etc/rc?.d/*kdump*

    cat >  /etc/networks <<EOF
default 0.0.0.0
loopback 127.0.0.0 
link-local 169.254.0.0

iface eth0 inet manual
iface eth1 inet manual
iface eth2 inet manual
EOF

    mac=$(echo $(ifconfig | grep -B2 192.168 | grep HWadd) | cut -d' ' -f5)
    echo "mac:$mac"
    cat >  /etc/NetworkManager/NetworkManager.conf  <<EOF
[main]
plugins=ifcfg-rh,keyfile

[ifupdown]
managed=false


[keyfile]
unmanaged-devices=mac:$mac
EOF
}
setupNetwork

# setup dbus environment
setupDbus(){
    # fix dbus service paths!
    sed -i.bak -e 's/<fork\/>/<fork\/>\n\n  <servicedir>\/usr\/share\/dbus-1\/system-services<\/servicedir>\n/g' /etc/dbus-1/system.conf  

    #fix dbus for the current boot!
    rm -rf /var/lib/dbus/machine-id
    /bin/dbus-uuidgen --ensure
}
setupDbus

# setup xorg
setupXorg(){
    # delete xorg if there's no nvidia video board!
    [ "$(/sbin/lspci | grep VGA | grep n.idia)" == "" ] && rm /etc/X11/xorg.conf
}
setupXorg


installDbus140(){
    PWD=$(pwd)
    cd /root/dbus-1.4.0/
    make install
    cd $PWD
}
installDbus160(){
    PWD=$(pwd)
    cd /root/dbus-1.6.10/
    make install
    cd $PWD
}
#installDbus160



#fix reboot
fixReboot(){
    cat > /newroot/etc/rc.d/init.d/halt << EOF
#!/bin/bash
mount -t proc proc /proc
echo 1 > /proc/sys/kernel/sysrq
echo b > /proc/sysrq-trigger
EOF
    cp  /newroot/etc/rc.d/init.d/halt \
        /newroot/etc/rc.d/init.d/reboot
}
fixReboot


# add pipeline rc.local to /etc/rc.local
pipeSetup(){
    # copy the up2date rc.local from the pipeline template 
    #cp -rf /newroot/$studio/pipeline/tools/init/fedora14/etc_rc.local.example /newroot/etc/rc.local 
    rm -rf /newroot/mountRootAsUnionFS.sh
    cat > /newroot/etc/rc.d/rc.local <<EOF
#!/bin/sh
touch /var/lock/subsys/local
source /atomo/pipeline/tools/init/rc.local
EOF
    chmod +x /newroot/etc/rc.d/rc.local
}
pipeSetup


echo "=============================================================="
