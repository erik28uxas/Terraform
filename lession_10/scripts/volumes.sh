#!/bin/bash

set -ex

vgchange -ay

DEVICE_FS=`blkid -o value -s TYPE ${DEVICE} || echo ""`
if [ "`echo -n $DEVICE_FS`" == "" ]; then
    # wait for the device to be attached
    DEVICENAME=`echo "${DEVICE}" | awk -F '/' '{print $3}'`
    DEVICEEXISTS=''
    while [[ -z $DEVICEEXISTS ]]
    do
        echo "checking $DEVICENAME"
        DEVICEEXISTS=`lsblk |grep "$DEVICENAME" |wc -l`
        if [[ $DEVICEEXISTS != "1" ]]; then
            sleep 15
        fi
    done
    # make sure the device file in /dev/ exists
    count=0
    until [[ -e ${DEVICE} || "$count" == "60" ]]; do
        sleep 5
        count=$(expr $count + 1)
    done
    pvcreate ${DEVICE}
    pvs
    vgcreate lvmhdds ${DEVICE}
    pvs
    lvcreate -l 100%FREE -n hdd2 lvmhdds
    pvs
    mkfs.ext4 /dev/lvmhdds/hdd2
fi
mkdir -p /exthdd/hdd2
echo "/dev/lvmhdds/hdd2 /exthdd/hdd2 ext4 defaults 0 0" >> /etc/fstab
mount /dev/lvmhdds/hdd2 /exthdd/hdd2

echo "=====End of the code V1====="
