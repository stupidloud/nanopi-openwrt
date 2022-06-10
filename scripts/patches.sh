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
sed -i '/DEPENDS/ s/$/ +frpc/' `find package/ -follow -type f -path '*/luci-app-frpc/Makefile'`

sed -i 's/ +ntfs-3g/ +ntfs3-mount/' `find package/ -follow -type f -path '*/automount/Makefile'`
sed -i '/skip\=/ a skip=`mount | grep -q /dev/$device; echo $?`' `find package/ -follow -type f -path */automount/files/15-automount`

sed -i 's/START=95/START=99/' `find package/ -follow -type f -path */ddns-scripts/files/ddns.init`

sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=master/' package/kernel/rtl8821cu/Makefile
sed -i 's/PKG_MIRROR_HASH:=.*/PKG_MIRROR_HASH:=skip/' package/kernel/rtl8821cu/Makefile

mkdir -p `find package/ -follow -type d -path '*/pdnsd-alt'`/patches
mv $GITHUB_WORKSPACE/patches/99-disallow-aaaa.patch `find package/ -follow -type d -path '*/pdnsd-alt'`/patches

sed -i 's/5.0/1.0/' .ccache/ccache.conf || true

line_number_INCLUDE_V2ray=$[`grep -m1 -n 'Include V2ray' package/custom/openwrt-passwall/luci-app-passwall/Makefile`-1]
sed -i $line_number_INCLUDE_V2ray'd' package/custom/openwrt-passwall/luci-app-passwall/Makefile
sed -i $line_number_INCLUDE_V2ray'd' package/custom/openwrt-passwall/luci-app-passwall/Makefile
sed -i $line_number_INCLUDE_V2ray'd' package/custom/openwrt-passwall/luci-app-passwall/Makefile

if [ $BRANCH == 'master' ]; then

  # fix po path for snapshot
  #find package/ -follow -type d -path '*/po/zh-cn' | xargs dirname | xargs -n1 -i sh -c "rm -f {}/zh_Hans; ln -sf zh-cn {}/zh_Hans"

  # remove non-exist package from x86 profile
  sed -i 's/kmod-i40evf//;s/kmod-iavf//' target/linux/x86/Makefile

  # kernel:fix bios boot partition is under 1 MiB
  # https://github.com/WYC-2020/lede/commit/fe628c4680115b27f1b39ccb27d73ff0dfeecdc2
  sed -i 's/256/1024/' target/linux/x86/image/Makefile

  # enable r2s oled plugin by default
  sed -i "s/enable '0'/enable '1'/" `find package/ -follow -type f -path '*/luci-app-oled/root/etc/config/oled'`

  # swap the network adapter driver to r8168 to gain better performance for r4s
  #sed -i 's/r8169/r8168/' target/linux/rockchip/image/armv8.mk

  # change the voltage value for over-clock stablization
  config_file_cpufreq=`find package/ -follow -type f -path '*/luci-app-cpufreq/root/etc/config/cpufreq'`
  truncate -s-1 $config_file_cpufreq
  echo -e "\toption governor0 'schedutil'" >> $config_file_cpufreq
  echo -e "\toption minfreq0 '816000'" >> $config_file_cpufreq
  echo -e "\toption maxfreq0 '1512000'\n" >> $config_file_cpufreq

  # enable fan control
  wget https://github.com/friendlyarm/friendlywrt/commit/cebdc1f94dcd6363da3a5d7e1e69fd741b8b718e.patch
  git apply cebdc1f94dcd6363da3a5d7e1e69fd741b8b718e.patch
  rm cebdc1f94dcd6363da3a5d7e1e69fd741b8b718e.patch
  sed -i 's/pwmchip1/pwmchip0/' target/linux/rockchip/armv8/base-files/usr/bin/fa-fancontrol.sh target/linux/rockchip/armv8/base-files/usr/bin/fa-fancontrol-direct.sh

fi

# inject the firmware version
strDate=`TZ=UTC-8 date +%Y-%m-%d`
status_pages=`find package/ -follow -type f \( -path '*/autocore/files/arm/index.htm' -o -path '*/autocore/files/x86/index.htm' -o -path '*/autocore/files/arm/rpcd_10_system.js' -o -path '*/autocore/files/x86/rpcd_10_system.js' \)`
for status_page in $status_pages; do
case $status_page in
  *htm)
    line_number_FV=`grep -n 'Firmware Version' $status_page | cut -d: -f 1`
    sed -i '/ver\./d' $status_page
    sed -i $line_number_FV' a <a href="https://github.com/klever1988/nanopi-openwrt" target="_blank">klever1988/nanopi-openwrt</a> '$strDate $status_page
    ;;
  *js)
    line_number_FV=`grep -m1 -n 'var fields' $status_page | cut -d: -f1`
    sed -i $line_number_FV' i var pfv = document.createElement('\''placeholder'\'');pfv.innerHTML = '\''<a href="https://github.com/klever1988/nanopi-openwrt" target="_blank">klever1988/nanopi-openwrt</a> '$strDate"';" $status_page
    line_number_FV=`grep -n 'Firmware Version' $status_page | cut -d : -f 1`
    sed -i '/Firmware Version/d' $status_page
    sed -i $line_number_FV' a _('\''Firmware Version'\''), pfv,' $status_page
    ;;
esac
done

# set default theme to argon
sed -i '/uci commit luci/i\uci set luci.main.mediaurlbase="/luci-static/argon"' `find package -type f -path '*/default-settings/files/*-default-settings'`

# remove the mirros from cn
sed -i '/182.140.223.146/d;/\.cn\//d;/tencent/d' scripts/download.pl

# add r1s support to Lean's repo
if [[ $DEVICE == 'r1s' ]]; then
  cd ~ && git clone -b openwrt-21.02 https://github.com/immortalwrt/immortalwrt && cd immortalwrt
  git log --grep r1s -i | grep '^commit ' | head -n -2 | cut -d' ' -f2 | tac | xargs git show | sed '0,/UENV/s//ATF/' > r1s.diff
  git show 124116564e8a6081e79cb2e87b0d87b2af99c583 632c4c91e7640a354dc421fa324fd705b734252d 7fb1b00f5f6214bf7a29d3781d260a7e7c8547c9 >> r1s.diff
  cd ~/lede && chmod +x target/linux/sunxi/base-files/etc/board.d/* && git apply ~/immortalwrt/r1s.diff
  merge_package https://github.com/immortalwrt/immortalwrt/branches/openwrt-18.06-k5.4/package/emortal/autocore
fi

if [[ $DEVICE == 'r4s' || $DEVICE == 'r2s' || $DEVICE == 'r2c' || $DEVICE == 'r1p' || $DEVICE == 'r1p-lts' ]]; then
  sed -i 's/5.10/5.4/g' target/linux/rockchip/Makefile
  line_number_CONFIG_CRYPTO_LIB_BLAKE2S=$[`grep -n 'CONFIG_CRYPTO_LIB_BLAKE2S' package/kernel/linux/modules/crypto.mk | cut -d: -f 1`+1]
  sed -i $line_number_CONFIG_CRYPTO_LIB_BLAKE2S' s/HIDDEN:=1/DEPENDS:=@(LINUX_5_4||LINUX_5_10)/' package/kernel/linux/modules/crypto.mk
  echo 'kmod-wireguard' >> `ls staging_dir/target-*/pkginfo/linux.default.install`
fi

# ...
git revert d15af9ff7c534853695a52bb94f07beb4ffec02a
sed -i 's/kmod-usb-net-rtl8152/kmod-usb-net-rtl8152-vendor/' target/linux/rockchip/image/armv8.mk target/linux/sunxi/image/cortexa53.mk target/linux/sunxi/image/cortexa7.mk