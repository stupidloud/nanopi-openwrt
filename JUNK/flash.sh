#!/bin/ash

if ! type "pv" > /dev/null; then
opkg update ; opkg install pv
fi
if [ -f /tmp/upload/rom.img.gz ]; then
pv /tmp/upload/rom.img.gz | gunzip -dc > /dev/mmcblk0
echo 1 > /proc/sys/kernel/sysrq
echo b > /proc/sysrq-trigger
fi

