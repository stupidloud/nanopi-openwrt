#!/bin/sh

if ! command -v pv &> /dev/null
then
	opkg update
	opkg install pv
	if ! command -v pv &> /dev/null; then echo '\e[91mpv命令无效，升级中止！\e[0m'； exit 1; fi
fi
if ! command -v fdisk &> /dev/null
then
	opkg update
	opkg install fdisk
	if ! command -v fdisk &> /dev/null; then echo '\e[91mfdisk命令无效，升级中止！\e[0m'； exit 1; fi
fi

board_id=$(cat /etc/board.json | jsonfilter -e '@["model"].name' | tail -c 4 | tr -d "\n" | awk '{print tolower($0)}')
mount -t tmpfs -o remount,size=650m tmpfs /tmp
rm -rf /tmp/upg && mkdir /tmp/upg && cd /tmp/upg
rm -rf artifact R2S*.zip FriendlyWrt*img* *.img.gz
wget https://ghproxy.com/https://github.com/klever1988/nanopi-openwrt/releases/download/$board_id-$(date +%Y-%m-%d)/$board_id.img.gz
if [ -f $board_id.img.gz ]; then
	wget https://ghproxy.com/https://github.com/klever1988/nanopi-openwrt/releases/download/$board_id-$(date +%Y-%m-%d)/md5sum.txt
	echo -e '\e[92m今天固件已下载，准备解压\e[0m'
else
	echo -e '\e[91m今天的固件还没更新，尝试下载昨天的固件\e[0m'
	wget https://ghproxy.com/https://github.com/klever1988/nanopi-openwrt/releases/download/$board_id-$(date -d "@$(( $(busybox date +%s) - 86400))" +%Y-%m-%d)/$board_id.img.gz
	if [ -f $board_id.img.gz ]; then
		wget https://ghproxy.com/https://github.com/klever1988/nanopi-openwrt/releases/download/$board_id-$(date -d "@$(( $(busybox date +%s) - 86400))" +%Y-%m-%d)/md5sum.txt
		echo -e '\e[92m昨天的固件已下载，准备解压\e[0m'
	else
		echo -e '\e[91m没找到最新的固件，脚本退出\e[0m'
		exit 1
	fi
fi

#if [ -f /mnt/mmcblk0p2/artifact/FriendlyWrt*.img.gz ]; then
    #cd /mnt/mmcblk0p2/artifact/
    if [ `md5sum -c md5sum.txt|grep -c "OK"` -eq 0 ]; then
        echo -e '\e[91m固件HASH值匹配失败，脚本退出\e[0m'
		exit 1
    fi
    #cd /mnt/mmcblk0p2
	echo -e '\e[92m准备解压镜像文件\e[0m'
	pv $board_id.img.gz | gunzip -dc > FriendlyWrt.img && rm $board_id.img.gz

#fi
offset=`expr $(fdisk -l -u FriendlyWrt.img | tail -n1 | awk '{print $2}') \* 512`
mkdir /mnt/img
mount -o loop,offset=$offset FriendlyWrt.img /mnt/img
echo -e '\e[92m解压已完成，准备编辑镜像文件，写入备份信息\e[0m'
cd /mnt/img
sysupgrade -b back.tar.gz
tar zxf back.tar.gz
echo -e '\e[92m备份文件已经写入，移除挂载\e[0m'
#rm back.tar.gz
cd /tmp/upg
umount /mnt/img
echo -e '\e[92m准备重新打包\e[0m'
#zstdmt /mnt/mmcblk0p2/FriendlyWrt.img -o /tmp/FriendlyWrtupdate.img.zst
echo -e '\e[92m打包完毕，准备刷机\e[0m'
if [ -f FriendlyWrt.img ]; then
	echo 1 > /proc/sys/kernel/sysrq
	echo u > /proc/sysrq-trigger || umount /
	pv FriendlyWrt.img | dd of=/dev/mmcblk0 conv=fsync
	echo -e '\e[92m刷机完毕，正在重启...\e[0m'	
	echo b > /proc/sysrq-trigger
fi
