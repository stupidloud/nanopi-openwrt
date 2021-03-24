sed -i 's/1400000/1450000/' target/linux/rockchip/patches-5.4/991-arm64-dts-rockchip-add-more-cpu-operating-points-for.patch
truncate -s-1 package/lean/luci-app-cpufreq/root/etc/config/cpufreq
echo -e "\toption governor0 'schedutil'" >> package/lean/luci-app-cpufreq/root/etc/config/cpufreq
echo -e "\toption minfreq0 '816000'" >> package/lean/luci-app-cpufreq/root/etc/config/cpufreq
echo -e "\toption maxfreq0 '1512000'\n" >> package/lean/luci-app-cpufreq/root/etc/config/cpufreq

sed -i "s/option hw_flow '1'/option hw_flow '0'/" package/ctcgfw/luci-app-turboacc/root/etc/config/turboacc
sed -i "s/option sfe_flow '1'/option sfe_flow '0'/" package/ctcgfw/luci-app-turboacc/root/etc/config/turboacc
sed -i "s/option sfe_bridge '1'/option sfe_bridge '0'/" package/ctcgfw/luci-app-turboacc/root/etc/config/turboacc
sed -i "/dep.*INCLUDE_.*=n/d" package/ctcgfw/luci-app-turboacc/Makefile

sed -i '/Installed-Time/a\sed -i "s/\\([[:digit:]]\)-[a-z0-9]\{32\}/\1/" $(1)/usr/lib/opkg/status\' include/rootfs.mk
find . -type f -name nft-qos.config | xargs sed -i "s/option limit_enable '1'/option limit_enable '0'/"
sed -i "/\/etc\/coremark\.sh/d" package/feeds/packages/coremark/Makefile
sed -i 's/192.168.1.1/192.168.2.1/' package/base-files/files/bin/config_generate

rm -rf files
mv $GITHUB_WORKSPACE/files ./
chmod 600 files/etc/dropbear/*
