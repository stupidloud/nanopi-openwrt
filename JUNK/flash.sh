#!/bin/ash

if ! type "pv" > /dev/null; then
	opkg update ; opkg install pv
	if ! type "pv" > /dev/null; then
		echo 'pv安装失败，退出...'
		exit 1
	fi
fi

if [ -f /tmp/upload/rom.img.gz ]; then
	pv /tmp/upload/rom.img.gz | gunzip -dc > /dev/mmcblk0
	echo 1 > /proc/sys/kernel/sysrq
	echo b > /proc/sysrq-trigger
fi

