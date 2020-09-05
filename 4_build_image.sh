cd $1
cd friendlywrt
./scripts/feeds update -a && ./scripts/feeds install -a
sed -i '/STAMP_BUILT/d' feeds/packages/utils/runc/Makefile feeds/packages/utils/containerd/Makefile #fix compile error
cd ..
echo -e '\nCONFIG_TCP_CONG_ADVANCED=y' >> kernel/arch/arm/configs/sunxi_defconfig
echo -e '\nCONFIG_TCP_CONG_BBR=m' >> kernel/arch/arm/configs/sunxi_defconfig
sed -i 's/set -eu/set -u/' scripts/mk-friendlywrt.sh
./build.sh $2
LOOP_DEVICE=$(losetup -f)
losetup -o 100663296 ${LOOP_DEVICE} friendlywrt-*/out/*.img
rm -rf /mnt/friendlywrt-tmp && mkdir -p /mnt/friendlywrt-tmp
mount ${LOOP_DEVICE} /mnt/friendlywrt-tmp && chown -R root:root /mnt/friendlywrt-tmp && umount /mnt/friendlywrt-tmp
losetup -d ${LOOP_DEVICE}
