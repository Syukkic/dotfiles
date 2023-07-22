#!/usr/bin/env bash
set -e

decrypted="driver"
decrypted_point="/dev/mapper/driver"
mounted_point="/mnt"
need_to_backup="/home/yuki/"
today=$(date +%Y%m%d)

start () {
    lsblk
    read -p "Choose the partition to be decrypted: " partition

    encrypted_partition="/dev/${partition}"

    if ! cryptsetup isLuks "${encrypted_partition}"; then
        echo "ERROR: ${encrypted_partition} is not a LUKS partition."
        exit 1
    fi

    cryptsetup open "${encrypted_partition}" "${decrypted}"
    echo "Found external driver --> ${encrypted_partition}"

    mount "${decrypted_point}" "${mounted_point}" || { echo "Failed to mount the external hard drive."; exit 1; }
    echo "External hard drive is mounted"

    if [[ -d "${mounted_point}/Backup" ]]; then
        let n=1 
        for dir in "${mounted_point}/Backup"/*
        do
            echo "$n: ${dir}"
            n=$((n+1))
        done
    else
        echo "Could not find external driver. It may not be mounted."
    fi

    read -p "Do you want to delete backup data? (yes / no) " whether_delete
    if [[ "$whether_delete" == "yes" ]]; then
        read -p "Enter the directory to delete: " to_delete
        echo "rm -rv ${mounted_point}/Backup/${to_delete}"
        rm -rv "${mounted_point}/Backup/${to_delete}"
        rsync -aviHAXKhS --one-file-system --partial --info=progress2 --atimes --open-noatime --exclude-from=exclusive.txt \
            "${need_to_backup}" "${mounted_point}/Backup/${today}/"
    else
        rsync -aviHAXKhS --one-file-system --partial --info=progress2 --atimes --open-noatime --exclude-from=exclusive.txt \
            "${need_to_backup}" "${mounted_point}/Backup/${today}/"
    fi
}
    
stop () {
    umount -R ${mounted_point}
    sudo cryptsetup close driver
}

start
stop

