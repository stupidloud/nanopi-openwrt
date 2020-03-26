[ -f configs/config_rk3328 ] && sed -i '/=m/d;/CONFIG_IB/d;/CONFIG_SDK/d;/CONFIG_BUILDBOT/d;/CONFIG_ALL_KMODS/d;/CONFIG_ALL_NONSHARED/d;/docker/d;/DOCKER/d;/CONFIG_DISPLAY_SUPPORT/d;/CONFIG_AUDIO_SUPPORT/d;/CONFIG_OPENSSL_PREFER_CHACHA_OVER_GCM/d;/CONFIG_VERSION/d;/SAMBA/d;/samba/d;/modemmanager/d;' configs/config_rk3328
[ -f configs/config_rk3328 ] && sed -i '/CONFIG_KERNEL_CGROUP_PERF/i\CONFIG_KERNEL_CGROUPS=y' configs/config_rk3328
[ -f configs/config_h5 ] &&     sed -i '/=m/d;/CONFIG_IB/d;/CONFIG_SDK/d;/CONFIG_BUILDBOT/d;/CONFIG_ALL_KMODS/d;/CONFIG_ALL_NONSHARED/d;/docker/d;/DOCKER/d;/CONFIG_DISPLAY_SUPPORT/d;/CONFIG_AUDIO_SUPPORT/d;/CONFIG_OPENSSL_PREFER_CHACHA_OVER_GCM/d;/CONFIG_VERSION/d;/SAMBA/d;/samba/d;/modemmanager/d;' configs/config_h5
[ -f configs/config_h5 ] &&     sed -i '/CONFIG_KERNEL_CGROUP_PERF/i\CONFIG_KERNEL_CGROUPS=y' configs/config_h5
[ -f configs/config_h3 ] &&     sed -i '/=m/d;/CONFIG_IB/d;/CONFIG_SDK/d;/CONFIG_BUILDBOT/d;/CONFIG_ALL_KMODS/d;/CONFIG_ALL_NONSHARED/d;/docker/d;/DOCKER/d;/CONFIG_DISPLAY_SUPPORT/d;/CONFIG_AUDIO_SUPPORT/d;/CONFIG_OPENSSL_PREFER_CHACHA_OVER_GCM/d;/CONFIG_VERSION/d;/SAMBA/d;/samba/d;/modemmanager/d;' configs/config_h3
[ -f configs/config_h3 ] &&     sed -i '/CONFIG_KERNEL_CGROUP_PERF/i\CONFIG_KERNEL_CGROUPS=y' configs/config_h3

find device/ -name distfeeds.conf -delete

#[ -f kernel/arch/arm64/configs/nanopi-r2_linux_defconfig ] && sed -i 's/CONFIG_BPFILTER=y/CONFIG_BPFILTER=n/' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
#[ -f kernel/arch/arm64/configs/nanopi-r2_linux_defconfig ] && sed -i 's/CONFIG_NFT_FLOW_OFFLOAD=m/CONFIG_NFT_FLOW_OFFLOAD=y/' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig

[ -f configs/config_rk3328 ] && echo -e '\nCONFIG_KERNEL_BUILD_USER="Dayong Chen"\nCONFIG_GRUB_TITLE="OpenWrt on Nanopi devices compiled by DayongChen"' >> configs/config_rk3328
[ -f configs/config_h5 ]     && echo -e '\nCONFIG_KERNEL_BUILD_USER="Dayong Chen"\nCONFIG_GRUB_TITLE="OpenWrt on Nanopi devices compiled by DayongChen"' >> configs/config_h5
[ -f configs/config_h3 ]     && echo -e '\nCONFIG_KERNEL_BUILD_USER="Dayong Chen"\nCONFIG_GRUB_TITLE="OpenWrt on Nanopi devices compiled by DayongChen"' >> configs/config_h3
