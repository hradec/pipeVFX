#!/bin/bash

export CLOUDSDK_COMPUTE_ZONE="us-central1-a"
# export CLOUDSDK_COMPUTE_ZONE="us-east1-b"
project="orbital-ego-170117"
cpus=64
num=001

#gcloud config set project $project 2>&1 > /dev/null

export SERVER="10.128.0.3"
export EDIT_MODE=ro
export REFRESH=0
export CACHE_PREFIX=""
export __CLOUDSDK_COMPUTE_ZONE=$CLOUDSDK_COMPUTE_ZONE
for i in "$@" ; do
case $i in
    --branch)
	    export BRANCH="-branch-$(git branch | grep '*' | awk '{print $(NF)}')"
        # export SERVER="10.142.0.2"
    ;;
    --zone=*|-z=*)
	    export CLOUDSDK_COMPUTE_ZONE="${i#*=}"
        # export SERVER="10.142.0.2"
    ;;
    --edit|-e)
	    export EDIT_MODE=rw
    ;;
    --suffix=*|-s=*)
	    export SUFFIX="${i#*=}"
        export SUFFIX="-branch-$SUFFIX"
    ;;
    --serverip=*|-ip=*)
	    export SERVER="${i#*=}"
    ;;
    --refresh|-r)
        export REFRESH=1
    ;;
    --cachePrefix=*)
        export CACHE_PREFIX="${i#*=}"
    ;;
esac
done
if [ "$(echo $CLOUDSDK_COMPUTE_ZONE | grep us-east1)" != "" ] ; then
    export SERVER="10.142.0.3"
    # export SUFFIX="-us-east1"
fi

#echo -e "CLOUDSDK_COMPUTE_ZONE=$CLOUDSDK_COMPUTE_ZONE\n\n"
#echo . $@

createDiskFromSnapshot(){
	name=$1
	snap=$2
	size=$3
    snapshot=""
    if [ "$snap" != "" ] ; then
        snapshot=" --source-snapshot $snap "
    fi
	echo gcloud compute --project "$project" disks create "$name" --size "$size" $snapshot --type "pd-standard" --zone="$CLOUDSDK_COMPUTE_ZONE"
	gcloud compute --project "$project" disks create "$name" --size "$size" $snapshot --type "pd-standard" --zone="$CLOUDSDK_COMPUTE_ZONE"
}


__cache_list(){
    cache="$CACHE_PREFIX_$2"
    if [ ! -f $cache ] || [ "$REFRESH" == "1" ]; then
        $1 | sort -V > $cache
    fi
    let cacheTime=$(date +%s)-$(stat -c %Y $cache)
    echo $cacheTime
    if [ $cacheTime -gt 15 ] ; then
        $1  | sort -V > $cache
    fi
    cat $cache
}

list(){
    __cache_list "gcloud compute --project $project  instances list $1" /tmp/.googleList.txt
}
list_ig(){
    __cache_list "gcloud compute --project $project  instance-groups list $1" /tmp/.googleList_ig.txt
}
list_template(){
    __cache_list "gcloud compute --project $project  instance-templates list $1" /tmp/.googleList_templates.txt
}
list_zones(){
	__cache_list "gcloud compute zones list $1"  /tmp/.googleListZones.txt
}
disks(){
	__cache_list "gcloud compute disks list $1"  /tmp/.googleListDisks.txt
}
snapshots(){
	__cache_list "gcloud compute snapshots list  $1"   /tmp/.googleListSnaps.txt
}


rmdisk(){
    l=$(disks)
    # echo "$l"
    d=$(echo "$l" | grep $1)
    zone=$(echo $d | awk '{print $2}')
    if [ "$d" != "" ] ; then
        echo $d
        echo gcloud compute disks delete $1 --zone=$zone --quiet
    	gcloud compute disks delete $1 --zone=$zone --quiet
    fi
}
tail(){
	hostname=$1
	gcloud compute --project "$project"  instances  tail-serial-port-output $hostname
}

create(){
#	if [ "$($disks | grep $CLOUDSDK_COMPUTE_ZONE | grep zraid )" == "" ] ; then
#		snap=$(snapshots | grep 'zraid2-snapshot' | sort -V | /bin/tail -n 1 | awk '{print $1}')
#		createDiskFromSnapshot zraid2 $snap 200
#	fi

    prefix="$CLOUDSDK_COMPUTE_ZONE"

    minPlatform="Automatic"
	mem=32768
	if [ $cpus -gt 32 ] ; then
        if [ $cpus -gt 64 ] ; then
		  mem=88320
          minPlatform="skylake"
        else
          mem=65536
        fi
		mtype="n1-highcpu-$cpus"
	else
		mtype="custom-${cpus}-${mem}"
	fi

	# createDiskFromSnapshot "googlefarm-${prefix}-${cpus}cpus-${num}-disk" "arch-kexec" 10
    # list | grep "googlefarm-${prefix}-${cpus}cpus-${num}"

    if [ "$(echo \"$_l\" | egrep "googlefarm-${num}" )" == "" ] ; then
        # hostname="googlefarm-${num}-${prefix}-${cpus}cpus"
        hostname="googlefarm-${num}-cpus"
        echo "creating $hostname..."
        [ "$SERVER" != "" ] && server=",SERVER=$SERVER"

        if [ "$(disks | grep $CLOUDSDK_COMPUTE_ZONE | grep googlefarm-001)" == "" ] ; then
    		snap=$(snapshots | grep 'googlefarm-001-snapshot-6' | sort -V | /bin/tail -n 1 | awk '{print $1}')
    		createDiskFromSnapshot googlefarm-001 $snap 10
    	fi
    	# if [ "$(disks | grep $CLOUDSDK_COMPUTE_ZONE | grep arch)" == "" ] ; then
    	# 	snap=$(snapshots | grep 'arch-kexec' | sort -V | /bin/tail -n 1 | awk '{print $1}')
    	# 	createDiskFromSnapshot "arch-${num}" $snap 10
    	# fi

        snap=$(snapshots | grep 'arch-kexec' | sort -V | /bin/tail -n 1 | awk '{print $1}')
        createDiskFromSnapshot "arch-${num}" $snap 10

        if [ $cpus -gt 63 ] ; then
        	echo 'y' | gcloud beta compute --project "$project" instances create "$hostname"  --zone="$CLOUDSDK_COMPUTE_ZONE"\
        	--machine-type "$mtype"  \
            --min-cpu-platform "$minPlatform" \
            --subnet "default" \
            --can-ip-forward \
            --metadata "OS_LABEL=FARM,OS_BOOT=1,serial-port-enable=1$server" \
        	--no-restart-on-failure \
        	--maintenance-policy "TERMINATE" \
            --preemptible --service-account "831087961927-compute@developer.gserviceaccount.com" \
        	--scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring.write","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" \
            --no-address \
            --disk "name=googlefarm-001,device-name=googlefarm-001,mode=$EDIT_MODE,boot=no,auto-delete=no" \
            --disk "name=arch-${num},device-name=arch-${num},mode=rw,boot=yes,auto-delete=no"
        fi
        # --no-address \
        # --disk "name=googlefarm-${prefix}-${cpus}cpus-${num}-disk,device-name=googlefarm-${prefix}-${cpus}cpus-${num}-disk,mode=rw,boot=yes,auto-delete=yes" \
    #	--disk "name=zraid2,device-name=zraid2,mode=ro,boot=no"

    	if [ $? -ne 0 ] || [ $cpus -lt 64 ]  ; then
    		echo 'y' | gcloud compute --project "$project" instances create  "$hostname"   --zone="$CLOUDSDK_COMPUTE_ZONE"\
    		--machine-type "custom-${cpus}-${mem}" \
            --subnet "default" \
            --metadata "OS_LABEL=FARM,OS_BOOT=1,serial-port-enable=1$server" \
    		--no-restart-on-failure \
    		--maintenance-policy "TERMINATE" \
            --preemptible --service-account "831087961927-compute@developer.gserviceaccount.com" \
    		--scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring.write","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" \
            --disk "name=googlefarm-001,device-name=googlefarm-001,mode=$EDIT_MODE,boot=no,auto-delete=no" \
            --disk "name=arch-${num},device-name=arch-${num},mode=rw,boot=yes,auto-delete=no"
    	fi

    	if [ $? -ne 0 ] ; then
    		# gcloud compute --project "$project" disks delete  "arch-${num}"
    		echo "Error creating machine $hostname"
    	fi
    fi
}

gserver(){
    if [ "$(disks | grep $CLOUDSDK_COMPUTE_ZONE | grep 'gserver ')" == "" ] ; then
		snap=$(snapshots | grep 'gserver-us-central' | sort -V | /bin/tail -n 1 | awk '{print $1}')
		snap=$(snapshots | grep 'gserver-snap' | sort -V | /bin/tail -n 1 | awk '{print $1}')
		createDiskFromSnapshot gserver $snap 10
	fi
    if [ "$(disks | grep $CLOUDSDK_COMPUTE_ZONE | grep zraid )" == "" ] ; then
		snap=$(snapshots | grep 'zraid2-us-central' | sort -V | /bin/tail -n 1 | awk '{print $1}')
		createDiskFromSnapshot zraid2 $snap 500
    fi
    if [ "$(disks | grep $CLOUDSDK_COMPUTE_ZONE | grep gserver-cache )" == "" ] ; then
		#snap=$(snapshots | grep 'gserver-cache' | sort -V | /bin/tail -n 1 | awk '{print $1}')
		createDiskFromSnapshot gserver-cache "" 1000
    fi

    ip="10.128.0.3"
    [ "$SERVER" != "" ] && ip=$SERVER

	type="n1-standard-4"
	[ "$1" != "" ] && type=$1 || \
	[ "$1" == "f" ] && type="f1-micro" || \
	[ "$1" == "h" ] && type="n1-highcpu-16"

    echo $type
    [ "$type" == "" ] && type="n1-standard-4"

	#gcloud compute --project "$project" disks create "gserver$1" \
	#	--size "10"  --source-snapshot "arch-kexec" --type "pd-standard"

    echo gcloud compute --project "$project" instances create "gserver$SUFFIX" \
	--machine-type "$type" \
	--subnet "default" \
	--metadata "OS_LABEL=SERVER,OS_BOOT=1,serial-port-enable=1" \
	--maintenance-policy "MIGRATE" \
	--disk "name=gserver,device-name=gserver,mode=rw,boot=yes,auto-delete=no" \
	--disk "name=gserver-cache,device-name=gserver-cache,mode=rw,boot=no,auto-delete=no" \
	--disk "name=zraid2,device-name=zraid2,mode=rw,boot=no,auto-delete=no" \
    --private-network-ip "$ip" \
    --can-ip-forward



	gcloud compute --project "$project" instances create "gserver$SUFFIX" \
	--machine-type "$type" \
	--subnet "default" \
	--metadata "OS_LABEL=SERVER,OS_BOOT=1,serial-port-enable=1" \
	--maintenance-policy "MIGRATE" \
	--disk "name=gserver,device-name=gserver,mode=rw,boot=yes,auto-delete=no" \
	--disk "name=gserver-cache,device-name=gserver-cache,mode=rw,boot=no,auto-delete=no" \
	--disk "name=zraid2,device-name=zraid2,mode=rw,boot=no,auto-delete=no" \
    --private-network-ip "$ip" \
    --can-ip-forward

#	--service-account "831087961927-compute@developer.gserviceaccount.com" \
#	--scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring.write","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" \
#	--disk "name=gserver$1,device-name=gserver4,mode=rw,boot=yes,auto-delete=yes"
}



_serial(){
rm /dev/shm/serial.sh
cat > /dev/shm/serial.sh <<\EOF
#!/bin/sh
    h="$1"
    echo $1
    #if [ "$(let h=-5+$1+1 ; echo $h)" != "-4" ] ; then
    #    h=$(echo $1 | awk '{printf("%03d", $1)}')
    #fi
    for v in $(googlefarm.sh list | grep "$h" | awk '{print $1"@"$2}') ; do
        echo $v
        hostname=$(echo $v | awk -F'@' '{print $1}')
        zone=$(echo $v | awk -F'@' '{print $2}')
        echo "serial: |$hostname|$zone|"
        export hostname
        #xterm -geometry 180x40 -bg "#222" -fg "white" -e "while true ; do gcloud beta compute --project $project connect-to-serial-port $hostname --extra-args replay-lines=2000 --zone $zone ; sleep 1; done" &
        echo gcloud compute --project $project connect-to-serial-port $hostname --extra-args replay-lines=2000 --zone $zone
        gcloud compute --project $project connect-to-serial-port $hostname --extra-args replay-lines=2000 --zone $zone
    done
EOF
chmod a+x /dev/shm/serial.sh
}
serial(){
    export project
    _serial
    xterm -geometry 180x40 -bg "#222" -fg "white" -e "/dev/shm/serial.sh $1 || bash -i -l" &
    #tilix -e "/dev/shm/serial.sh $1" &
}


ssh(){
    port=22000
    h="$1"
    if [ "$(let h=-5+$1+1 ; echo $h)" != "-4" ] ; then
        h=$(echo $1 | awk '{printf("%03d", $1)}')
    else
        echo ""
    fi
    if [ "$(echo $h | grep gmonitor)" != "" ] ; then
	port=22002
    fi
    googlefarm.sh list
    for each in $($0 list | grep "$h" | awk '{print $(NF-1)"@"$(NF)}') ; do
        export hostname=$(echo $each  | awk -F'@' '{print $(NF-1)}')
        export state=$(echo $each  | awk -F'@' '{print $(NF)}')
        echo $hostname
        echo $state
        if [ "$hostname" != "" ] && [ "$state" == "RUNNING" ]; then
        	#echo gcloud compute --project "$project"  connect-to-serial-port  $hostname
        	#gcloud compute --project "$project"  connect-to-serial-port  $hostname --extra-args replay-lines=800,on-dtr-low=disconnect
            #xterm -geometry 180x40 -bg "#222" -fg "white" -e 'gcloud beta compute --project "$project" connect-to-serial-port "$hostname" --zone "$CLOUDSDK_COMPUTE_ZONE"' &
            if [ "$(echo $hostname | grep gmonitor)" != "" ] ; then
                 port=22002
            fi

            cmd="/bin/ssh  -p $port root@$hostname"
            echo $cmd
            $cmd
        else
            echo "$h is offline..."
        fi
    done
}
# deleteOld(){
# 	for host in $hostname ; do
# 		nohup gcloud compute --project "$project" instances delete "$host" --delete-disks="boot" --quiet &
# 	done
# 	#[--zone=ZONE]
# 	# --delete-disks=<all|boot|data>
# 	# --keep-disks=<all|boot|data>
# }
startStopReset(){
    echo '=================================================='
    echo 'startStopReset'
    echo '=================================================='
    l=$(list)
    # echo -e "$l\n\n"
	action=$1
    grep=$(echo "$l" |  grep "$2" | awk '{print $1}')
	h=$2
    if [ "$grep" != "" ] ; then
        h=$grep
        # h=$2
    fi
    if [ "$action" == "delete" ]  ; then
        extra=' --delete-disks=boot '
        extra=''
    fi
    zone=$(echo "$l" | grep "$h" |  awk '{print $2}')
    # echo  "...$h....$zone..."
	cmd="gcloud compute --project $project  instances $action  $h  $extra --zone $zone" # --quiet"
    echo $cmd
    $cmd | tee /tmp/.$h.startStopReset.log 2>&1
}
start(){
    CACHE_PREFIX="start"
	startStopReset start $1
}
stop(){
    CACHE_PREFIX="stop"
	startStopReset stop  $1
}
reset(){
    CACHE_PREFIX="reset"
	startStopReset reset $1
}
delete(){
    CACHE_PREFIX="delete"
    startStopReset delete $1

    # rmdisk arch-$(echo $1 | grep -o -E '[0-9][0-9][0-9]')
}
all(){
  if [ "$(pgrep -fa gcloud | grep $1)" == "" ] ; then
        action=$1
        # list
        export grep=$2
        for each in $(list | egrep 'rnode.*core.*' | grep "$2"  | awk '{print $1}') ; do
                echo  "$0 $action $each &"
                $0 $action $each &
                #&& echo "[ OK ]" || echo "[ ERROR ]" &
        done
  fi
#       /bin/tail -f nohup.out
}
keepAlive(){
    gcloud compute --project $project instances start $(gcloud compute instances list --uri --filter="name~'(rnode.*core.*)'")
}
shutdownAll(){
    gcloud compute --project $project  instances stop $(gcloud compute instances list --uri --filter="name~'(rnode.*core.*)'")
}
resetAll(){
	gcloud compute --project $project instances reset $(gcloud compute instances list --uri --filter="name~'(rnode.*core.*)'")
}
deleteAll(){
	gcloud compute --project $project instances delete $(gcloud compute instances list --uri --filter="name~'(rnode.*core.*)'")
}

shutdownIfNoServer(){
	[ "$($0 list | egrep 'gserver|storage' | grep RUNNING)" == "" ] && echo $0 shutdownAll
}

current_zone(){
    /bin/python2 -c "import os;x=eval(''.join(os.popen('''curl 'http://metadata.google.internal/computeMetadata/v1/instance/?recursive=true' -H 'Metadata-Flavor: Google' ''').readlines()));print x['zone'].split('/')[-1]"
}

current_hostname(){
    echo $(curl "http://metadata.google.internal/computeMetadata/v1/instance/name" -H "Metadata-Flavor: Google" 2>/dev/null)
}

create_storage(){
    # create the network
    region=$(echo $CLOUDSDK_COMPUTE_ZONE | awk -F'-' '{print $1"-"$2}')
    network=custom-$region
    gcloud compute --project=$project networks create \
        $network --subnet-mode=custom
    gcloud compute --project=$project networks subnets create sub1-$network \
        --network=$network --region=$region\
        --range=10.0.0.0/16 --secondary-range=r2-$network=192.168.0.0/16

    # create the firewall rules (in background, since we don't need then to create the vm)
    gcloud compute firewall-rules create http-$network \
        --network $network \
        --action allow \
        --direction ingress \
        --rules tcp:80 \
        --source-ranges 0.0.0.0/0 \
        --priority 10 &
    gcloud compute firewall-rules create https-$network \
        --network $network \
        --action allow \
        --direction ingress \
        --rules tcp:443 \
        --source-ranges 0.0.0.0/0 \
        --priority 10 &
    gcloud compute firewall-rules create proxmox-$network \
        --network $network \
        --action allow \
        --direction ingress \
        --rules tcp:8006,tcp:3128 \
        --source-ranges 0.0.0.0/0 \
        --priority 10 &
    gcloud compute firewall-rules create ssh-$network \
        --network $network \
        --action allow \
        --direction ingress \
        --rules tcp:22000 \
        --source-ranges 0.0.0.0/0 \
        --priority 10 &
    gcloud compute firewall-rules create all-$network \
        --network $network \
        --action allow \
        --direction ingress \
        --source-ranges 10.0.0.0/16,192.168.0.0/16 \
        --rules all \
        --priority 10 &

    # create the storage vm!
    vm_type="n1-standard-4"
    vm_type="n1-highmem-4"
    vm_type="n1-highcpu-8"
    vm_type="n2d-highcpu-16"
    vm_type="n1-highcpu-16"
	name="storage-${region}$SUFFIX$BRANCH"
	gcloud beta compute --project=$project instances create $name\
		--machine-type=$vm_type \
		--network-interface "subnet=sub1-$network,aliases=r2-$network:192.168.0.0/16" \
		--network-tier=PREMIUM \
		--can-ip-forward \
		--maintenance-policy=MIGRATE \
		--service-account=831087961927-compute@developer.gserviceaccount.com \
        --scopes=https://www.googleapis.com/auth/cloud-platform \
		--tags=proxmox,http-server,https-server \
		--image=nested-vm-proxmox \
		--image-project=$project \
		--boot-disk-size=50GB \
		--boot-disk-type=pd-ssd \
		--boot-disk-device-name=$name \
		--create-disk=mode=rw,size=1000,type=projects/$project/zones/$CLOUDSDK_COMPUTE_ZONE/diskTypes/pd-ssd,device-name=persistent-disk-1,name=$name-cache
#		--create-disk=mode=rw,size=1000,type=projects/$project/zones/$CLOUDSDK_COMPUTE_ZONE/diskTypes/pd-standard,device-name=persistent-disk-1,name=$name-cache

    echo "last command result: $?"
}

create_render_node(){
    [ "$2" == "" ] && cores=8 || cores=$2
    type="n1-highcpu-$cores"
    name="render-node$SUFFIX$BRANCH"
    region=$(echo $CLOUDSDK_COMPUTE_ZONE | awk -F'-' '{print $1"-"$2}')
    network=custom-$region
    gcloud compute --project=$project instances create $name \
        --zone=$CLOUDSDK_COMPUTE_ZONE \
        --machine-type=$type \
        --subnet=sub1-$network \
        --network-tier=PREMIUM \
        --can-ip-forward \
        --no-restart-on-failure \
        --maintenance-policy=TERMINATE \
        --preemptible \
        --service-account=831087961927-compute@developer.gserviceaccount.com \
        --scopes=https://www.googleapis.com/auth/cloud-platform \
        --min-cpu-platform="Intel Skylake" \
        --tags=proxmox,http-server,https-server \
        --image=nested-vm-proxmox \
        --image-project=$project \
        --boot-disk-size=50GB \
        --boot-disk-type=pd-ssd \
        --boot-disk-device-name=$name

    echo "last command result: $?"
}

create_render_node_instance(){
    #echo $0
    cores=$1
    # if [ "$2" != "" ] ; then
        # noaddress="-$2"
        # extra="--no-address"
    # fi

    region=$(echo $CLOUDSDK_COMPUTE_ZONE | awk -F'-' '{print $1"-"$2}')
    network=custom-$region

    type="n1-highcpu"
    [ $cores -lt 30 ] && type="standard"
    # gcloud compute zones list  | awk '{print $1}' | grep $region
    type=$(/usr/sbin/gcloud compute machine-types list --zones ${region}-a | awk '{print $1}' | grep $type | grep $cores | /bin/tail -n 1)
    #echo "type: $type"

    name="render-node-$type-$region$noaddress"
    echo "$name"

    # echo "$(list_template | grep $name)"
    if [ "$(list_template | egrep $(echo $name | sed 's/-/./g') )" == "" ] ; then
        gcloud compute --project=$project instance-templates \
            create $name \
            $extra \
            --machine-type=$type \
            --subnet=projects/$project/regions/$region/subnetworks/sub1-$network \
            --network-tier=PREMIUM \
            --can-ip-forward \
            --no-restart-on-failure \
            --maintenance-policy=TERMINATE \
            --preemptible \
            --service-account=831087961927-compute@developer.gserviceaccount.com \
            --scopes=https://www.googleapis.com/auth/cloud-platform \
            --region=$region \
            --min-cpu-platform="Intel Skylake" \
            --tags=http-server,https-server \
            --image=nested-vm-proxmox \
            --image-project=$project \
            --boot-disk-size=50GB \
            --boot-disk-type=pd-ssd \
            --boot-disk-device-name=$name

            [ $? != 0 ] && exit 1
    fi

}
create_instance_group(){
    echo $0
    cores=$1
    max_vms=$2
    mode=$3
    cpuLimit=$4
    [ "$cpuLimit" == "" ] && cpuLimit="0.05"
    [ "$mode" == "" ] && mode="only-up"
    [ "$cores" == "" ] && cores=64
    [ "$max_vms" == "" ] && max_vms=20
    [ "$(echo $max_vms | grep '-')" != "" ] && max_vms=20
    region=$(echo $CLOUDSDK_COMPUTE_ZONE | awk -F'-' '{print $1"-"$2}')

    zones="$(echo $(list_zones | grep $region | awk '{print $1}' | sort) | sed 's/ /,/g')"
    [ $cores -lt 30 ] && zones=$CLOUDSDK_COMPUTE_ZONE

    # create the template
    template=$(create_render_node_instance $cores $region)
    echo "$template"

    name="ig-$template"
    grep_name=$(echo $name | sed 's/-/./g')

    while [ "$(list_ig | egrep $grep_name)" == "" ] ; do
        list_ig
        list_template
        echo $grep_name
        echo "It may take a while for the instance template be available... "
        sleep 5
        gcloud beta compute --project $project instance-groups managed \
            create $name \
            --base-instance-name=rnode-$cores-cores \
            --template=$template \
            --size=1 \
            --zones=$zones
            #--health-check=check --initial-delay=300
    done


    while true ; do
        gcloud beta compute --project "$project" instance-groups managed \
            set-autoscaling "$name" \
            --region "$region" \
            --cool-down-period "120" \
            --max-num-replicas "$max_vms" \
            --min-num-replicas "1" \
            --target-cpu-utilization "$cpuLimit" \
            --mode "$mode" \
#            --scale-in-control max-scaled-in-replicas=95%,time-window=120

        if [ $? != 0 ] ; then
            echo "It may take a while for the instance group be available to set autoscaling, after creating it... "
            sleep 5
        else
            break
        fi
    done
}

delete_instance_group()
{
    region=$(echo $CLOUDSDK_COMPUTE_ZONE | awk -F'-' '{print $1"-"$2}')
    gcloud compute --project "$project" instance-groups managed delete $1 --region "$region"
    #--zone=$(list_ig | grep $1 | awk '{print $2}')
}

if [ "$1" == "create" ] ; then
    export _l=$(list)
	if [ "$2" != "" ] ; then
		cpus=$2
	fi
	if [ "$3" != "" ] ; then
		if [[ $3 == *-* ]] ; then
			s=$(echo $3 | cut -d'-' -f1)
			e=$(echo $3 | cut -d'-' -f2)
			range=$(x=$(echo \"$_l\" | egrep 'googlefarm.*cpu.*' | awk -F "-| " '{print $4}') ; for (( c=$s; c<=$e; c++ )) ; do n=$(echo $c | awk '{printf("%03d", $1)}') ;  [[ $x != *$n* ]] && echo $n ; done)

			for num in $range ; do
                # echo "$0 create $cpus $num -z="$CLOUDSDK_COMPUTE_ZONE" &"
				nohup $0 create $cpus $num -z="$CLOUDSDK_COMPUTE_ZONE" &
			done
			#/bin/tail -f nohup.out
		else
			num=$(echo $3 | awk '{printf("%03d", $1)}')
			# echo create $cpus $num
			create
		fi
	fi

elif  [ "$1" == "delete" ] ; then
	hostname=$2
	delete $2

elif  [ "$1" == "list" ] ; then
	hostname=$2
	list

elif  [ "$1" == "hostname" ] ; then
    current_hostname

elif  [ "$1" == "zone" ] ; then
    current_zone

elif  [ "$1" != "" ] ; then
	"$1" $2 $3 $4 $5 $6 $7 $8 $9
else
cat << EOF
$0
_______________________________________________________________________________________________________________________
	to delete a google farm machine:
	 	$0 delete <machine name>

	ex: $0 delete googlefarm-64cpus-001

________________________________________________________________________________________________________________________
	to list stuff:
		$0 list
		$0 list_ig
		$0 list_template
		$0 list_zones
		$0 disks
		$0 snapshots

	to start/stop/reset a vm:
		$0 start|stop|reset|delete <hostname>

	to display the serial console:
		$0 tail <hostname>

	to connect to the serial console:
		$0 serial <hostname>

	to connect via ssh:
		$0 ssh <hostname>

	shutdown all machines if server is off (farm 1.0 - not working)
		$0 shutdownIfNoServer

	create a storage server (farm 2.0)
		$0 create_storage  < --suffix="-suffix-to-vm-name" > < -z="us-east1-b" >

	create a render node (farm 2.0)
		$0 create_render_node <number of cores - 4, 8(default), 16, 32, 64 or 96> <--suffix="-suffix-to-vm-name"(default="")> <-z="us-central1-a"(default)>

    create an managed instance group of render-nodes (farm 2.0)
		$0 create_instance_group <number of cores of each vm in the group - 32, 64(default), 96>  <max number of vms in the group - default=20>

    delete an managed instance group (farm 2.0)
		$0 delete_instance_group <instance group name>
________________________________________________________________________________________________________________________
EOF

fi
