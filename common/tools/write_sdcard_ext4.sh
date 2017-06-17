#!/bin/bash

# android-tools-fsutils should be installed as
# "sudo apt-get install android-tools-fsutils"

# partition size in MB
BOOTLOADER=8
BOOT_SIZE=15
SYSTEM_SIZE=1536
CACHE_SIZE=512
RECOVERY_SIZE=32

help() {

bn=`basename $0`
cat << EOF
usage $bn <option> device_node

options:
  -h				displays this help message
  -s				only get partition size
  -np 				not partition.
  -f soc_name			flash android image.
EOF

}

# parse command line
moreoptions=1
node="na"
soc_name=""
cal_only=0
bootloader_offset=1
flash_images=0
not_partition=0
not_format_fs=0
bootloader_file="u-boot.imx"
bootimage_file="boot.img"
systemimage_file="system.img"
systemimage_raw_file="system_raw.img"
recoveryimage_file="recovery.img"
while [ "$moreoptions" = 1 -a $# -gt 0 ]; do
	case $1 in
	    -h) help; exit ;;
	    -s) cal_only=1 ;;
	    -f) flash_images=1 ; soc_name=$2; shift;;
	    -np) not_partition=1 ;;
	    -nf) not_format_fs=1 ;;
	    *)  moreoptions=0; node=$1 ;;
	esac
	[ "$moreoptions" = 0 ] && [ $# -gt 1 ] && help && exit
	[ "$moreoptions" = 1 ] && shift
done

if [ ! -e ${node} ]; then
	help
	exit
fi

sfdisk_version=`sfdisk -v | awk '{print $4}' | awk -F '.' '{print $2}'`
if [ $sfdisk_version -ge "26" ]; then
    opt_unit=""
    unit_mb="M"
else
    echo "Please update your sfdisk version to 2.26 or later version"
    exit
fi

# call sfdisk to create partition table
# get total card size
total_size=`sfdisk -s ${node}`
total_size=`expr ${total_size} / 1024`
BOOT_SIZEb=`expr ${BOOT_SIZE} + ${BOOTLOADER}`
extend_size=`expr ${SYSTEM_SIZE} + ${CACHE_SIZE}`
data_size=`expr ${total_size} - ${BOOT_SIZEb} - ${RECOVERY_SIZE} - ${extend_size}`

# create partitions
if [ "${cal_only}" -eq "1" ]; then
cat << EOF
BOOT   : ${BOOT_SIZEb}MB
RECOVERY: ${RECOVERY_SIZE}MB
SYSTEM : ${SYSTEM_SIZE}MB
CACHE  : ${CACHE_SIZE}MB
DATA   : ${data_size}MB
EOF
exit
fi

function format_android
{
    echo "formating android images"
    mkfs.ext4 ${node}${part}4 -F -Ldata
    mkfs.ext4 ${node}${part}5 -F -Lsystem
    mkfs.ext4 ${node}${part}6 -F -Lcache
}

function flash_android
{
    bootloader_file="u-boot-${soc_name}.imx"
    bootimage_file="boot-${soc_name}.img"
    recoveryimage_file="recovery-${soc_name}.img"
if [ "${flash_images}" -eq "1" ]; then
    echo "flashing android images..."    
    echo "bootloader: ${bootloader_file} offset: ${bootloader_offset}"
    echo "boot image: ${bootimage_file}"
    echo "recovery image: ${recoveryimage_file}"
    echo "system image: ${systemimage_file}"
    dd if=/dev/zero of=${node} bs=1k seek=${bootloader_offset} conv=fsync count=800
    dd if=${bootloader_file} of=${node} bs=1k seek=${bootloader_offset} conv=fsync
    dd if=${bootimage_file} of=${node}${part}1 conv=fsync
    dd if=${recoveryimage_file} of=${node}${part}2 bs=2M conv=fsync
    simg2img ${systemimage_file} ${systemimage_raw_file}
    dd if=${systemimage_raw_file} of=${node}${part}5 bs=2M conv=fsync status=progress
    rm ${systemimage_raw_file}
fi
}

if [[ "${not_partition}" -eq "1" && "${flash_images}" -eq "1" ]] ; then
    flash_android
    exit
fi

sfdisk --force ${opt_unit}  ${node} << EOF
,${BOOT_SIZEb}${unit_mb},83
,${RECOVERY_SIZE}${unit_mb},83
,${extend_size}${unit_mb},5
,${data_size}${unit_mb},83
,${SYSTEM_SIZE}${unit_mb},83
,${CACHE_SIZE}${unit_mb},83
EOF

# adjust the partition reserve for bootloader.
# if you don't put the uboot on same device, you can remove the BOOTLOADER
# to have 8M space.
# the minimal sylinder for some card is 4M, maybe some was 8M
# just 8M for some big eMMC 's sylinder
sfdisk --force ${opt_unit} ${node} -N1 << EOF
${BOOTLOADER}${unit_mb},${BOOT_SIZE}${unit_mb},83
EOF

# sleep 5s after re-partition
# umount the partition which is mounted automatically.
# sync the mbr table with hdparm
sleep 5
for i in `cat /proc/mounts | grep "${node}" | awk '{print $2}'`; do umount $i; done
hdparm -z ${node}

# format the SDCARD/DATA/CACHE partition
part=""
echo ${node} | grep mmcblk > /dev/null
if [ "$?" -eq "0" ]; then
	part="p"
fi

format_android
flash_android

