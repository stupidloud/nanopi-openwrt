cd $1
cd friendlywrt
cd ..

sed -i '/feeds/d' scripts/mk-friendlywrt.sh
./build.sh $2

LOOP_DEVICE=$(losetup -f)
sudo losetup -o 100663296 ${LOOP_DEVICE} out/*.img
sudo rm -rf /mnt/friendlywrt-tmp && sudo mkdir -p /mnt/friendlywrt-tmp
sudo mount ${LOOP_DEVICE} /mnt/friendlywrt-tmp && sudo chown -R root:root /mnt/friendlywrt-tmp && sudo umount /mnt/friendlywrt-tmp
sudo losetup -d ${LOOP_DEVICE}
 