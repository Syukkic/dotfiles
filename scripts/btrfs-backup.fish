#!/usr/bin/env fish

function start
    cryptsetup open /dev/disk/by-partuuid/4489ce12-4d22-6e46-a134-af86edd402ca silence
    mount -o compress=zstd,noatime /dev/mapper/silence /mnt/backup
end

function stop
    umount -R /mnt/backup
    cryptsetup close silence
end

function external-backup
    echo "Mounting external drive"
    start

    set dt $(date +'%Y-%m-%d_%H:%M')

    btrfs subvol snapshot -r /home /.snapshots/home/snapshot-$dt && sync
    echo "Backing up snapshot-$dt ..."
    btrfs send --compressed-data -p /.snapshots/home/latest /.snapshots/home/snapshot-$dt | pv | btrfs receive /mnt/backup

    btrfs subvolume delete /.snapshots/home/latest
    mv /.snapshots/home/snapshot-$dt /.snapshots/home/latest

    btrfs subvolume delete /mnt/backup/latest
    mv /mnt/backup/snapshot-$dt /mnt/backup/latest

    stop

    echo "Backing up done~~ 😸"
end

external-backup
