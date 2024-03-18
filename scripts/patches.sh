config_file_turboacc=`find package/ -follow -type f -path '*/luci-app-turboacc/root/etc/config/turboacc'`
sed -i "s/option hw_flow '1'/option hw_flow '0'/" $config_file_turboacc
sed -i "s/option sfe_flow '1'/option sfe_flow '0'/" $config_file_turboacc
sed -i "s/option sfe_bridge '1'/option sfe_bridge '0'/" $config_file_turboacc
sed -i "/dep.*INCLUDE_.*=n/d" `find package/ -follow -type f -path '*/luci-app-turboacc/Makefile'`

sed -i "s/option limit_enable '1'/option limit_enable '0'/" `find package/ -follow -type f -path '*/nft-qos/files/nft-qos.config'`
sed -i "s/option enabled '1'/option enabled '0'/" `find package/ -follow -type f -path '*/vsftpd-alt/files/vsftpd.uci'`
sed -i "/\/etc\/coremark\.sh/d" `find package/ -follow -type f -path '*/coremark/coremark'`
sed -i 's/192.168.1.1/192.168.2.1/' package/base-files/files/bin/config_generate
sed -i 's/=1/=0/g' package/kernel/linux/files/sysctl-br-netfilter.conf

sed -i '/DEPENDS+/ s/$/ +wsdd2/' `find package/ -follow -type f -path '*/ksmbd-tools/Makefile'`

sed -i 's/ +ntfs-3g/ +ntfs3-mount/' `find package/ -follow -type f -path '*/automount/Makefile'`
sed -i '/skip\=/ a skip=`mount | grep -q /dev/$device; echo $?`' `find package/ -follow -type f -path */automount/files/15-automount`

sed -i 's/START=95/START=99/' `find package/ -follow -type f -path */ddns-scripts/files/ddns.init`

#sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=master/' package/kernel/rtl8821cu/Makefile
#sed -i 's/PKG_MIRROR_HASH:=.*/PKG_MIRROR_HASH:=skip/' package/kernel/rtl8821cu/Makefile

# enable r2s oled plugin by default
sed -i "s/enable '0'/enable '1'/" `find package/ -follow -type f -path '*/luci-app-oled/root/etc/config/oled'`

# set default theme to argon
sed -i '/uci commit luci/i\uci set luci.main.mediaurlbase="/luci-static/argon"' `find package -type f -path '*/default-settings/files/*-default-settings'`

mkdir -p `find package/ -follow -type d -path '*/pdnsd-alt'`/patches
mv $GITHUB_WORKSPACE/patches/99-disallow-aaaa.patch `find package/ -follow -type d -path '*/pdnsd-alt'`/patches


line_number_INCLUDE_Xray=$[`grep -m1 -n 'Include Xray' package/custom/openwrt-passwall/luci-app-passwall/Makefile|cut -d: -f1`-1]
sed -i $line_number_INCLUDE_Xray'd' package/custom/openwrt-passwall/luci-app-passwall/Makefile
sed -i $line_number_INCLUDE_Xray'd' package/custom/openwrt-passwall/luci-app-passwall/Makefile
sed -i $line_number_INCLUDE_Xray'd' package/custom/openwrt-passwall/luci-app-passwall/Makefile
line_number_INCLUDE_V2ray=$[`grep -m1 -n 'Include V2ray' package/custom/openwrt-passwall/luci-app-passwall/Makefile|cut -d: -f1`-1]
sed -i $line_number_INCLUDE_V2ray'd' package/custom/openwrt-passwall/luci-app-passwall/Makefile
sed -i $line_number_INCLUDE_V2ray'd' package/custom/openwrt-passwall/luci-app-passwall/Makefile
sed -i $line_number_INCLUDE_V2ray'd' package/custom/openwrt-passwall/luci-app-passwall/Makefile
sed -i 's/LUCI_DEPENDS:=/LUCI_DEPENDS:=+iptables-mod-iprange +iptables-mod-socket /' package/custom/openwrt-passwall/luci-app-passwall/Makefile

# inject the firmware version
strDate=`TZ=UTC-8 date +%Y-%m-%d`
status_pages=`find package/ -follow -type f \( -path '*/autocore/files/arm/index.htm' -o -path '*/autocore/files/x86/index.htm' -o -path '*/autocore/files/arm/rpcd_10_system.js' -o -path '*/autocore/files/x86/rpcd_10_system.js' \)`
for status_page in $status_pages; do
case $status_page in
  *htm)
    line_number_FV=`grep -n 'Firmware Version' $status_page | cut -d: -f 1`
    sed -i '/ver\./d' $status_page
    sed -i $line_number_FV' a <a href="https://github.com/stupidloud/nanopi-openwrt" target="_blank">stupidloud/nanopi-openwrt</a> '$strDate $status_page
    ;;
  *js)
    line_number_FV=`grep -m1 -n 'var fields' $status_page | cut -d: -f1`
    sed -i $line_number_FV' i var pfv = document.createElement('\''placeholder'\'');pfv.innerHTML = '\''<a href="https://github.com/stupidloud/nanopi-openwrt" target="_blank">stupidloud/nanopi-openwrt</a> '$strDate"';" $status_page
    line_number_FV=`grep -n 'Firmware Version' $status_page | cut -d : -f 1`
    sed -i '/Firmware Version/d' $status_page
    sed -i $line_number_FV' a _('\''Firmware Version'\''), pfv,' $status_page
    ;;
esac
done

# fix po path for snapshot
#find package/ -follow -type d -path '*/po/zh-cn' | xargs dirname | xargs -ri sh -c "rm -f {}/zh_Hans; ln -sf zh-cn {}/zh_Hans"

# remove non-exist package from x86 profile
sed -i 's/kmod-i40evf//;s/kmod-iavf//' target/linux/x86/Makefile

# kernel:fix bios boot partition is under 1 MiB
# https://github.com/WYC-2020/lede/commit/fe628c4680115b27f1b39ccb27d73ff0dfeecdc2
sed -i 's/256/1024/' target/linux/x86/image/Makefile

# swap the network adapter driver to r8168 to gain better performance for r4s
#sed -i 's/r8169/r8168/' target/linux/rockchip/image/armv8.mk

# add pwm fan control service
wget https://github.com/friendlyarm/friendlywrt/commit/cebdc1f94dcd6363da3a5d7e1e69fd741b8b718e.patch
git apply cebdc1f94dcd6363da3a5d7e1e69fd741b8b718e.patch
rm cebdc1f94dcd6363da3a5d7e1e69fd741b8b718e.patch
sed -i 's/pwmchip1/pwmchip0/' target/linux/rockchip/armv8/base-files/usr/bin/fa-fancontrol.sh target/linux/rockchip/armv8/base-files/usr/bin/fa-fancontrol-direct.sh

case $DEVICE in
  r2s|r2c|r1p|r1p-lts)
    # change the voltage value for over-clock stablization
    config_file_cpufreq=`find package/ -follow -type f -path '*/luci-app-cpufreq/root/etc/config/cpufreq'`
    truncate -s-1 $config_file_cpufreq
    echo -e "\toption governor0 'schedutil'" >> $config_file_cpufreq
    echo -e "\toption minfreq0 '816000'" >> $config_file_cpufreq
    echo -e "\toption maxfreq0 '1512000'\n" >> $config_file_cpufreq

    line_number_CONFIG_CRYPTO_LIB_BLAKE2S=$[`grep -n 'CONFIG_CRYPTO_LIB_BLAKE2S' package/kernel/linux/modules/crypto.mk | cut -d: -f 1`+1]
    sed -i $line_number_CONFIG_CRYPTO_LIB_BLAKE2S' s/HIDDEN:=1/DEPENDS:=@(LINUX_5_4||LINUX_5_10)/' package/kernel/linux/modules/crypto.mk
    sed -i 's/libblake2s.ko@lt5.9/libblake2s.ko/;s/libblake2s-generic.ko@lt5.9/libblake2s-generic.ko/' package/kernel/linux/modules/crypto.mk
    ;;
esac

# add r6s support to Lean's repo
if [[ $DEVICE == 'r6s' || $DEVICE == 'r6c' ]]; then
  pip3 install pylibfdt
  cd ~ && rm -rf immortalwrt/ && git clone -b master https://github.com/immortalwrt/immortalwrt && cd immortalwrt
  git revert --no-commit 3bc7cfe0923ea23626a4e8c666c4a4b64a78f195 #cpufreq
  mv include/kernel-6.1 ~/lede/include/
  rsync -a --delete target/linux/rockchip/. ~/lede/target/linux/rockchip/. && rsync -a --delete target/linux/generic/. ~/lede/target/linux/generic/. && rsync -a --delete package/boot/. ~/lede/package/boot/. && cp -a include/u-boot.mk ~/lede/include/u-boot.mk
  cd ~/lede
  wget https://github.com/coolsnowwolf/lede/raw/master/target/linux/generic/hack-6.1/952-add-net-conntrack-events-support-multiple-registrant.patch
  wget https://github.com/coolsnowwolf/lede/raw/master/target/linux/generic/hack-6.1/953-net-patch-linux-kernel-to-support-shortcut-fe.patch
  mv *.patch target/linux/generic/hack-6.1/
  wget https://github.com/coolsnowwolf/lede/raw/master/target/linux/generic/pending-6.1/613-netfilter_optional_tcp_window_check.patch
  mv *.patch target/linux/generic/pending-6.1/
  sed -i "s/ucidef_set_interfaces_lan_wan 'eth0 eth1' 'eth2'/ucidef_set_interfaces_lan_wan 'eth1 eth0' 'eth2'/" target/linux/rockchip/armv8/base-files/etc/board.d/02_network
  sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += autocore-arm/' target/linux/rockchip/Makefile
  git diff --summary
fi

# add r1s support to Lean's repo
if [[ $DEVICE == 'r1s' ]]; then
  cd ~ && rm -rf immortalwrt/ && git clone -b openwrt-18.06-k5.4 --depth=1 https://github.com/immortalwrt/immortalwrt && cd immortalwrt
  rsync -a --delete target/linux/sunxi/. ~/lede/target/linux/sunxi/. && rsync -a --delete package/boot/. ~/lede/package/boot/.
  cd ~/lede
  sed -i 's/kmod-rtl8189es//;s/wpad-basic-openssl/wpad-basic-wolfssl/' target/linux/sunxi/image/cortexa53.mk
  merge_package "-b openwrt-18.06-k5.4 https://github.com/immortalwrt/immortalwrt" immortalwrt/package/emortal/autocore

  sed -i '/luci/d' $GITHUB_WORKSPACE/common.seed $GITHUB_WORKSPACE/extra_packages.seed

  git revert --no-edit f4405a9597eea92622b66f122de2fb738a605d5d 51459ab19ec99ac63090766dff5dbc8ae74ef714 
fi

# fix for r1s-h3
if [[ $DEVICE == 'r1s-h3' ]]; then
  sed -i 's/kmod-leds-gpio//' target/linux/sunxi/image/cortexa7.mk
fi

# ...
sed -i 's/rk3399_bl31_v1.35.elf/rk3399_bl31_v1.36.elf/;s/rk3568_ddr_1560MHz_v1.13.bin/rk3568_ddr_1560MHz_v1.18.bin/;s/rk3568_bl31_v1.34.elf/rk3568_bl31_v1.43.elf/' package/boot/uboot-rockchip/Makefile
sed -i 's/kmod-usb-net-rtl8152/kmod-usb-net-rtl8152-vendor/' target/linux/rockchip/image/armv8.mk target/linux/sunxi/image/cortexa53.mk target/linux/sunxi/image/cortexa7.mk

## ugly fix of the read-only issue
sed -i '3 i sed -i "/^exit.*/i\\/bin\\/mount -o remount,rw /" /etc/rc.local' `find package -type f -path '*/default-settings/files/*-default-settings'`

sed -i 's/\+1017\,12/+1017\,13/;/ifdef CONFIG_MBO/i+NEED_GAS=y' package/network/services/hostapd/patches/200-multicall.patch