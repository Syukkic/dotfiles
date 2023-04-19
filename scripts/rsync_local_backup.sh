#!/usr/bin/env bash
set -e

decrypted="driver"
decrypted_point="/dev/mapper/driver"
mounted_point="/mnt"
need_to_backup="/home/yuki/"

today=`date +%Y%m%d`

echo "================================"
echo "|   lsblk display partitions   |"
echo "================================"

lsblk
read -p "Choose the partition to being decrypted: " partition

encrypted_partition="/dev/${partition}"

cryptsetup open ${$encrypted_partition} ${decrypted}
echo "Found external driver --> $encrypted_partition"

mount ${decrypted_point} ${mounted_point}
echo "External hard drive is mounted"

if [[ -d "${mounted_point}/Backup" ]]; then
    let n=1 
    for dir in ${mounted_point}/Backup/*
    do echo $n: ${dir}
        n=$((n+1))
    done
else
    echo "Could not find external driver. It may not be mounted"
fi

echo "=============================================="
echo "|   Please delele the last one backup data   |"
echo "|   Please delele the last one backup data   |"
echo "|   Please delele the last one backup data   |"
echo "=============================================="


read -p "You will delete the directory is: " to_delete
echo "rm -rv /mnt/Backup"/${to_delete}
rm -rv "/mnt/Backup"/${to_delete}

rsync -aAXHv --exclude-from=exclusive.txt ${need_to_backup} "${mounted_point}/Backup/${today}/"
