sed -i 's/1400000/1450000/' target/linux/rockchip/patches-5.4/991-arm64-dts-rockchip-add-more-cpu-operating-points-for.patch
truncate -s-1 package/lean/luci-app-cpufreq/root/etc/config/cpufreq
echo -e "\toption governor0 'schedutil'" >> package/lean/luci-app-cpufreq/root/etc/config/cpufreq
echo -e "\toption minfreq0 '816000'" >> package/lean/luci-app-cpufreq/root/etc/config/cpufreq
echo -e "\toption maxfreq0 '1512000'\n" >> package/lean/luci-app-cpufreq/root/etc/config/cpufreq

sed -i "s/option hw_flow '1'/option hw_flow '0'/" package/ctcgfw/luci-app-turboacc/root/etc/config/turboacc
sed -i "s/option sfe_flow '1'/option sfe_flow '0'/" package/ctcgfw/luci-app-turboacc/root/etc/config/turboacc
sed -i "s/option sfe_bridge '1'/option sfe_bridge '0'/" package/ctcgfw/luci-app-turboacc/root/etc/config/turboacc
sed -i "/INCLUDE_shortcut-fe=n/d" package/ctcgfw/luci-app-turboacc/Makefile
