[ -f configs/config_rk3328 ] && sed -i '/=m/d;/CONFIG_IB/d;/CONFIG_SDK/d;/CONFIG_BUILDBOT/d;/CONFIG_ALL_KMODS/d;/CONFIG_ALL_NONSHARED/d;/docker/d;/DOCKER/d;/CONFIG_DISPLAY_SUPPORT/d;/CONFIG_AUDIO_SUPPORT/d;/CONFIG_OPENSSL_PREFER_CHACHA_OVER_GCM/d;/CONFIG_VERSION/d;/SAMBA/Id;/modemmanager/d;/CGROUPS/d;/PACKAGE_lib/d;/luci-lib/d;/luci-app/d' configs/config_rk3328
[ -f configs/config_h5 ] &&     sed -i '/=m/d;/CONFIG_IB/d;/CONFIG_SDK/d;/CONFIG_BUILDBOT/d;/CONFIG_ALL_KMODS/d;/CONFIG_ALL_NONSHARED/d;/docker/d;/DOCKER/d;/CONFIG_DISPLAY_SUPPORT/d;/CONFIG_AUDIO_SUPPORT/d;/CONFIG_OPENSSL_PREFER_CHACHA_OVER_GCM/d;/CONFIG_VERSION/d;/SAMBA/Id;/modemmanager/d;/CGROUPS/d;/PACKAGE_lib/d;/luci-lib/d;/luci-app/d' configs/config_h5
[ -f configs/config_h3 ] &&     sed -i '/=m/d;/CONFIG_IB/d;/CONFIG_SDK/d;/CONFIG_BUILDBOT/d;/CONFIG_ALL_KMODS/d;/CONFIG_ALL_NONSHARED/d;/docker/d;/DOCKER/d;/CONFIG_DISPLAY_SUPPORT/d;/CONFIG_AUDIO_SUPPORT/d;/CONFIG_OPENSSL_PREFER_CHACHA_OVER_GCM/d;/CONFIG_VERSION/d;/SAMBA/Id;/modemmanager/d;/CGROUPS/d;/PACKAGE_lib/d;/luci-lib/d;/luci-app/d' configs/config_h3

[ -f configs/config_rk3328 ] && echo -e '\nCONFIG_KERNEL_BUILD_USER="Dayong Chen"\nCONFIG_GRUB_TITLE="OpenWrt on Nanopi devices compiled by DayongChen"' >> configs/config_rk3328
[ -f configs/config_h5 ]     && echo -e '\nCONFIG_KERNEL_BUILD_USER="Dayong Chen"\nCONFIG_GRUB_TITLE="OpenWrt on Nanopi devices compiled by DayongChen"' >> configs/config_h5
[ -f configs/config_h3 ]     && echo -e '\nCONFIG_KERNEL_BUILD_USER="Dayong Chen"\nCONFIG_GRUB_TITLE="OpenWrt on Nanopi devices compiled by DayongChen"' >> configs/config_h3

sed -i -r 's/# (CONFIG_.*_ERRATUM_.*?) is.*/\1=y/g' kernel/arch/arm64/configs/*
echo "\nCONFIG_ZRAM=m\n" >> kernel/arch/arm64/configs/sunxi_arm64_defconfig
