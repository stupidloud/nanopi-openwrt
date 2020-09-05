[ -f configs/config_rk3328 ] && sed -i '/=m/d;/CONFIG_IB/d;/CONFIG_SDK/d;/CONFIG_BUILDBOT/d;/CONFIG_ALL_KMODS/d;/CONFIG_PACKAGE_kmod/d;/CONFIG_ALL_NONSHARED/d;/docker/d;/DOCKER/d;/CONFIG_DISPLAY_SUPPORT/d;/CONFIG_AUDIO_SUPPORT/d;/CONFIG_OPENSSL_PREFER_CHACHA_OVER_GCM/d;/CONFIG_VERSION/d;/SAMBA/Id;/modemmanager/d;/CGROUPS/d;/PACKAGE_lib/d;/luci-lib/d' configs/config_rk3328
[ -f configs/config_h5 ] &&     sed -i '/=m/d;/CONFIG_IB/d;/CONFIG_SDK/d;/CONFIG_BUILDBOT/d;/CONFIG_ALL_KMODS/d;/CONFIG_PACKAGE_kmod/d;/CONFIG_ALL_NONSHARED/d;/docker/d;/DOCKER/d;/CONFIG_DISPLAY_SUPPORT/d;/CONFIG_AUDIO_SUPPORT/d;/CONFIG_OPENSSL_PREFER_CHACHA_OVER_GCM/d;/CONFIG_VERSION/d;/SAMBA/Id;/modemmanager/d;/CGROUPS/d;/PACKAGE_lib/d;/luci-lib/d' configs/config_h5
[ -f configs/config_h3 ] &&     sed -i '/=m/d;/CONFIG_IB/d;/CONFIG_SDK/d;/CONFIG_BUILDBOT/d;/CONFIG_ALL_KMODS/d;/CONFIG_PACKAGE_kmod/d;/CONFIG_ALL_NONSHARED/d;/docker/d;/DOCKER/d;/CONFIG_DISPLAY_SUPPORT/d;/CONFIG_AUDIO_SUPPORT/d;/CONFIG_OPENSSL_PREFER_CHACHA_OVER_GCM/d;/CONFIG_VERSION/d;/SAMBA/Id;/modemmanager/d;/CGROUPS/d;/PACKAGE_lib/d;/luci-lib/d' configs/config_h3
[ -f friendlywrt/target/linux/rockchip-rk3328/config-4.14 ] && sed -i '/CONFIG_CGROUPS/a\CONFIG_CGROUP_PERF=y' friendlywrt/target/linux/rockchip-rk3328/config-4.14
[ -f friendlywrt/target/linux/allwinner-h5/config-4.14 ] &&    sed -i '/CONFIG_CGROUPS/a\CONFIG_CGROUP_PERF=y' friendlywrt/target/linux/allwinner-h5/config-4.14
cd friendlywrt/ && git add . && git commit -m 'reset' && cd ../

find device/ -name distfeeds.conf -delete

[ -f configs/config_rk3328 ] && echo -e '\nCONFIG_KERNEL_BUILD_USER="Dayong Chen"\nCONFIG_GRUB_TITLE="OpenWrt on Nanopi devices compiled by DayongChen"' >> configs/config_rk3328
[ -f configs/config_h5 ]     && echo -e '\nCONFIG_KERNEL_BUILD_USER="Dayong Chen"\nCONFIG_GRUB_TITLE="OpenWrt on Nanopi devices compiled by DayongChen"' >> configs/config_h5
[ -f configs/config_h3 ]     && echo -e '\nCONFIG_KERNEL_BUILD_USER="Dayong Chen"\nCONFIG_GRUB_TITLE="OpenWrt on Nanopi devices compiled by DayongChen"' >> configs/config_h3
