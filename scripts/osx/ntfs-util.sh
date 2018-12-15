#!/usr/bin/env bash

# ntfs-utils.sh
# 
# Mac OS X Script to remout all NTFS drives in write mode
# Requires Homebrew, OSX Fuse, and NTFS-3g pre-installed

# Configs & Commands
mount_path_prefix=/Volumes
ntfs_cmd=/usr/local/bin/ntfs-3g

for di in `diskutil list | grep "Windows_NTFS" | grep -o "disk.*"`
do
	dp=/dev/$di
	dvn=`diskutil info $dp | grep "Volume Name" | grep -o ":.*$" | grep -o "\s.*$" | awk '{$1=$1;print}'`
	mount_path="$mount_path_prefix/$dvn"
	echo "Unmounting volume $dvn from path: $dp..."
	umount $dp
	if [ ! -d "$mount_path" ]
	then
		echo "Creating folder: $mount_path"
		mkdir -p "$mount_path"
	fi

	echo "Remounting volume $dvn to $mount_path..."
	$ntfs_cmd $dp "$mount_path" -orw -olocal -oallow_other
done
