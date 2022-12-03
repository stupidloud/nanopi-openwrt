#!/bin/sh
set -e $1

opkg update || true
function proceed_command () {
	if ! command -v $1 &> /dev/null; then opkg install --force-overwrite $1; fi
	if ! command -v $1 &> /dev/null; then echo -e '\e[91m'$1'命令不可用，升级中止！\e[0m' && exit 1; fi
}
proceed_command pv
proceed_command fdisk
proceed_command sfdisk
proceed_command losetup
proceed_command resize2fs
opkg install coreutils-truncate || true
wget -NP /tmp https://ghproxy.com/https://raw.githubusercontent.com/stupidloud/nanopi-openwrt/zstd-bin/truncate
wget -NP /tmp https://ghproxy.com/https://raw.githubusercontent.com/stupidloud/nanopi-openwrt/zstd-bin/ddnz
chmod +x /tmp/truncate /tmp/ddnz

board_id=$(cat /etc/board.json | jsonfilter -e '@["model"].id' | sed 's/friendly.*,nanopi-//;s/xunlong,orangepi-//;s/^r1s-h5$/r1s/;s/^r1$/r1s-h3/;s/^r1-plus$/r1p/;s/^r1-plus-lts$/r1p-lts/;s/default-string-default-string/x86/;s/vmware-inc-vmware7-1/x86/')
arch=`uname -m`
[ $arch == 'x86_64' ] && board_id='x86';
mount -t tmpfs -o remount,size=850m tmpfs /tmp
rm -rf /tmp/upg && mkdir /tmp/upg && cd /tmp/upg
set +e
wget https://ghproxy.com/https://github.com/stupidloud/nanopi-openwrt/releases/download/$(date +%Y-%m-%d)/$board_id$ver.img.gz -O- | gzip -dc > $board_id.img
if [ $? -eq 0 ]; then
	wget https://ghproxy.com/https://github.com/stupidloud/nanopi-openwrt/releases/download/$(date +%Y-%m-%d)/$board_id$ver.img.md5 -O md5sum.txt
	echo -e '\e[92m今天固件已下载，准备解压\e[0m'
else
	echo -e '\e[91m今天的固件还没更新，尝试下载昨天的固件\e[0m'
	wget https://ghproxy.com/https://github.com/stupidloud/nanopi-openwrt/releases/download/$(date -d "@$(( $(busybox date +%s) - 86400))" +%Y-%m-%d)/$board_id$ver.img.gz -O- | gzip -dc > $board_id.img
	if [ $? -eq 0 ]; then
		wget https://ghproxy.com/https://github.com/stupidloud/nanopi-openwrt/releases/download/$(date -d "@$(( $(busybox date +%s) - 86400))" +%Y-%m-%d)/$board_id$ver.img.md5 -O md5sum.txt
		echo -e '\e[92m昨天的固件已下载，准备解压\e[0m'
	else
		echo -e '\e[91m没找到最新的固件，脚本退出\e[0m'
		exit 1
	fi
fi
set -e

sed -i 's/-slim//;s/-with-docker//' md5sum.txt
if [ `md5sum -c md5sum.txt|grep -c "OK"` -eq 0 ]; then
	echo -e '\e[91m固件HASH值匹配失败，脚本退出\e[0m'
	exit 1
fi

mv $board_id.img FriendlyWrt.img
block_device='mmcblk0'
[ ! -d /sys/block/$block_device ] && block_device='mmcblk1'
[ $board_id = 'x86' ] && block_device='sda'
bs=`expr $(cat /sys/block/$block_device/size) \* 512`
truncate -s $bs FriendlyWrt.img || ../truncate -s $bs FriendlyWrt.img
echo ", +" | sfdisk -N 2 FriendlyWrt.img

lodev=$(losetup -f)
losetup -P $lodev FriendlyWrt.img
mkdir -p /mnt/img
mount -t ext4 ${lodev}p2 /mnt/img
echo -e '\e[92m解压已完成，准备编辑镜像文件，写入备份信息\e[0m'
sleep 10
cd /mnt/img
sysupgrade -b back.tar.gz
tar zxf back.tar.gz
if ! grep -q macaddr /etc/config/network; then
	echo -e '\e[91m注意：由于已知的问题，“网络接口”配置无法继承，重启后需要重新设置WAN拨号和LAN网段信息\e[0m'
	rm etc/config/network;
fi
echo -e '\e[92m备份文件已经写入，移除挂载\e[0m'
#rm back.tar.gz
cd /tmp/upg
umount /mnt/img

sleep 5
if cat /proc/mounts | grep -q ${lodev}p1; then umount ${lodev}p1; fi
if cat /proc/mounts | grep -q ${lodev}p2; then umount ${lodev}p2; fi
e2fsck -yf ${lodev}p2 || true
resize2fs ${lodev}p2

losetup -d $lodev
echo -e '\e[92m正在打包...\e[0m'
echo -e '\e[92m开始写入，请勿中断...\e[0m'
if [ -f FriendlyWrt.img ]; then
	echo 1 > /proc/sys/kernel/sysrq
	echo u > /proc/sysrq-trigger && umount / || true
	#pv FriendlyWrt.img | dd of=/dev/$block_device conv=fsync
	../ddnz FriendlyWrt.img /dev/$block_device
	echo -e '\e[92m刷机完毕，正在重启...\e[0m'
	echo b > /proc/sysrq-trigger
fi
