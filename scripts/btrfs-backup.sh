#!/usr/bin/env bash

set -e

# 檢查是否以 root 身份運行
if [[ $(id -u) -ne 0 ]]; then
    echo "Please run as root"
    exit 1
fi

# 設置日誌記錄
function log {
    echo "$(date +'%Y-%m-%d %H:%M:%S') $*" | tee -a /var/log/btrfs-backup.log
}

log "Starting backup script"

# 打開 LUKS 設備
password=$(systemd-ask-password "Enter LUKS password:")
if ! echo -n "$password" | sudo cryptsetup open /dev/disk/by-partuuid/04967bc3-d329-47f0-bf6c-3e1baf067a31 silence; then
    log "Failed to open LUKS device"
    exit 1
fi

# 掛載文件系統
if ! sudo mount -o compress=zstd,noatime /dev/mapper/silence /mnt/backup; then
    log "Failed to mount backup device"
    sudo cryptsetup close silence
    exit 1
fi

# 設置時間戳
dt=$(date +'%Y-%m-%d_%H:%M')

# 創建只讀快照
if ! sudo btrfs subvol snapshot -r /home /.snapshots/home/snapshot-$dt; then
    log "Failed to create snapshot"
    sudo umount -R /mnt/backup
    sudo cryptsetup close silence
    exit 1
fi

# 同步數據
sync

# 發送快照到備份設備
if ! sudo btrfs send --compressed-data -p /.snapshots/home/latest /.snapshots/home/snapshot-$dt | pv | sudo btrfs receive /mnt/backup; then
    log "Failed to send/receive snapshot"
    sudo umount -R /mnt/backup
    sudo cryptsetup close silence
    exit 1
fi

# 刪除舊的快照
if [[ -d /.snapshots/home/latest ]]; then
    sudo btrfs subvolume delete /.snapshots/home/latest
fi

# 更新最新快照
sudo mv /.snapshots/home/snapshot-$dt /.snapshots/home/latest

# 刪除備份設備上的舊快照
if [[ -d /mnt/backup/latest ]]; then
    sudo btrfs subvolume delete /mnt/backup/latest
fi

# 更新備份設備上的最新快照
sudo mv /mnt/backup/snapshot-$dt /mnt/backup/latest

# 卸載並關閉 LUKS 設備
sudo umount -R /mnt/backup
sudo cryptsetup close silence

log "Backup completed successfully"
