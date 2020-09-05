LOOP_DEVICE=$(losetup -f)
losetup -o 100663296 ${LOOP_DEVICE} friendlywrt-*/out/*.img
rm -rf /mnt/friendlywrt-tmp && mkdir -p /mnt/friendlywrt-tmp
mount ${LOOP_DEVICE} /mnt/friendlywrt-tmp && chown -R root:root /mnt/friendlywrt-tmp && umount /mnt/friendlywrt-tmp
losetup -d ${LOOP_DEVICE}
