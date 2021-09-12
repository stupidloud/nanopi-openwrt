config_file_turboacc=`find package/ -follow -type f -path '*/luci-app-turboacc/root/etc/config/turboacc'`
sed -i "s/option hw_flow '1'/option hw_flow '0'/" $config_file_turboacc
sed -i "s/option sfe_flow '1'/option sfe_flow '0'/" $config_file_turboacc
sed -i "s/option sfe_bridge '1'/option sfe_bridge '0'/" $config_file_turboacc
sed -i "/dep.*INCLUDE_.*=n/d" `find package/ -follow -type f -path '*/luci-app-turboacc/Makefile'`

sed -i "s/option limit_enable '1'/option limit_enable '0'/" `find package/ -follow -type f -path '*/vsftpd/files/vsftpd.uci'`
sed -i "s/option enabled '1'/option enabled '0'/" `find package/ -follow -type f -path '*/nft-qos/files/nft-qos.config'`
sed -i "/\/etc\/coremark\.sh/d" `find package/ -follow -type f -path '*/coremark/coremark'`
sed -i 's/192.168.1.1/192.168.2.1/' package/base-files/files/bin/config_generate
sed -i 's/=1/=0/g' package/kernel/linux/files/sysctl-br-netfilter.conf

sed -i '/DEPENDS/ s/$/ +libcap-bin/' `find package/ -follow -type f -path '*/luci-app-openclash/Makefile'`
sed -i '/DEPENDS+/ s/$/ +wsdd2/' `find package/ -follow -type f -path '*/ksmbd-tools/Makefile'`

sed -i 's/ +ntfs-3g/ +ntfs3-mount/' `find package/ -follow -type f -path '*/automount/Makefile'`
sed -i '/skip\=/ a skip=`mount | grep -q /dev/$device; echo $?`' `find package/ -follow -type f -path */automount/files/15-automount`

svn export https://github.com/klever1988/helloworld/trunk/luci-app-ssr-plus
dir_ssrp=`find package/ -follow -type d -path '*/luci-app-ssr-plus'`
cp luci-app-ssr-plus/root/etc/config/shadowsocksr ${dir_ssrp}/root/etc/config/shadowsocksr
cp luci-app-ssr-plus/root/etc/ssrplus/black.list ${dir_ssrp}/root/etc/ssrplus/black.list
cp luci-app-ssr-plus/root/etc/ssrplus/white.list ${dir_ssrp}/root/etc/ssrplus/white.list
cp luci-app-ssr-plus/root/etc/ssrplus/blackipv6.sh ${dir_ssrp}/root/etc/ssrplus/blackipv6.sh
cp luci-app-ssr-plus/root/usr/bin/ssr-rules ${dir_ssrp}/root/usr/bin/ssr-rules
rm -rf luci-app-ssr-plus/

mkdir -p `find package/ -follow -type d -path '*/pdnsd-alt'`/patches
mv $GITHUB_WORKSPACE/patches/99-disallow-aaaa.patch `find package/ -follow -type d -path '*/pdnsd-alt'`/patches

if [ $DEVICE != 'r1s' ]; then

  # remove non-exist package from x86 profile
  sed -i 's/kmod-i40evf//' target/linux/x86/Makefile

  # enable r2s oled plugin by default
  sed -i "s/enable '0'/enable '1'/" `find package/ -follow -type f -path '*/luci-app-oled/root/etc/config/oled'`

  # swap the network adapter driver to r8168 to gain better performance for r4s
  sed -i 's/r8169/r8168/' target/linux/rockchip/image/armv8.mk

  # change the voltage value for over-clock stablization
  sed -i 's/1400000/1450000/' target/linux/rockchip/patches-5.4/991-arm64-dts-rockchip-add-more-cpu-operating-points-for.patch
  config_file_cpufreq=`find package/ -follow -type f -path '*/luci-app-cpufreq/root/etc/config/cpufreq'`
  truncate -s-1 $config_file_cpufreq
  echo -e "\toption governor0 'schedutil'" >> $config_file_cpufreq
  echo -e "\toption minfreq0 '816000'" >> $config_file_cpufreq
  echo -e "\toption maxfreq0 '1512000'\n" >> $config_file_cpufreq

  # enable the gpu for device 'r2s'|'r2c'|'r4s'|'r1p'
  wget https://github.com/coolsnowwolf/lede/raw/757e42d70727fe6b937bb31794a9ad4f5ce98081/target/linux/rockchip/config-default -NP target/linux/rockchip/
  wget https://github.com/coolsnowwolf/lede/commit/f341ef96fe4b509a728ba1281281da96bac23673.patch
  git apply f341ef96fe4b509a728ba1281281da96bac23673.patch
  rm f341ef96fe4b509a728ba1281281da96bac23673.patch

  # bring the ethinfo back
  cd package/emortal/autocore/files/x86
  cp rpcd_luci rpcd_10_system.js rpcd_luci-mod-status.json ../arm
  cd -
  mf_autcore=`find package/ -path '*/autocore/Makefile'`
  sed -i '/arm\/cpuinfo/a\\t$(INSTALL_DATA) ./files/x86/rpcd_21_ethinfo.js $(1)/www/luci-static/resources/view/status/include/21_ethinfo.js' $mf_autcore
  sed -i '/arm\/cpuinfo/a\\t$(INSTALL_DIR) $(1)/www/luci-static/resources/view/status/include' $mf_autcore
  sed -i '/arm\/cpuinfo/a\\t$(INSTALL_BIN) ./files/x86/ethinfo $(1)/sbin/ethinfo' $mf_autcore

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
      line_number_FV=`grep -m1 -n 'corelink' $status_page | cut -d: -f1`
      sed -i $line_number_FV' i var pfv = document.createElement('\''placeholder'\'');pfv.innerHTML = '\''<a href="https://github.com/klever1988/nanopi-openwrt" target="_blank">klever1988/nanopi-openwrt</a> '$strDate"';" $status_page
      line_number_FV=`grep -n 'Firmware Version' $status_page | cut -d : -f 1`
      sed -i '/Firmware Version/d' $status_page
      sed -i $line_number_FV' a _('\''Firmware Version'\''), pfv,' $status_page
      ;;
  esac
  done

fi

# little optimization argon css
css_file=`find package/ -follow -type f -path '*/argon/css/cascade.css'`
line_number_h6=`grep -m1 -n 'h6 {' $css_file | cut -d: -f1`
if [[ ! -z "$line_number_h6" ]]; then
sed -i $line_number_h6',+10 s/font-weight: normal/font-weight: bold/' $css_file
fi

# set default theme to openwrt2020
sed -i '/uci commit luci/i\uci set luci.main.mediaurlbase="/luci-static/openwrt2020"' `find package -type f -path '*/default-settings/files/zzz-default-settings'`

# remove the mirros from cn
sed -i '/182.140.223.146/d;/\.cn\//d;/tencent/d' scripts/download.pl