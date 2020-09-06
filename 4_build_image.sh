cd $1
cd friendlywrt
./scripts/feeds update -a && ./scripts/feeds install -a
sed -i '/STAMP_BUILT/d' feeds/packages/utils/runc/Makefile feeds/packages/utils/containerd/Makefile #fix compile error
cd ..

echo -e '\nCONFIG_TCP_CONG_ADVANCED=y' >> kernel/arch/arm/configs/sunxi_defconfig
echo -e '\nCONFIG_TCP_CONG_BBR=m' >> kernel/arch/arm/configs/sunxi_defconfig
sed -i 's/set -eu/set -u/' scripts/mk-friendlywrt.sh
sed -i 's/640/1000/' scripts/sd-fuse/mk-sd-image.sh
./build.sh $2

LOOP_DEVICE=$(losetup -f)
sudo losetup -o 100663296 ${LOOP_DEVICE} out/*.img
sudo rm -rf /mnt/friendlywrt-tmp && sudo mkdir -p /mnt/friendlywrt-tmp
sudo mount ${LOOP_DEVICE} /mnt/friendlywrt-tmp && chown -R root:root /mnt/friendlywrt-tmp && sudo umount /mnt/friendlywrt-tmp
sudo losetup -d ${LOOP_DEVICE}
