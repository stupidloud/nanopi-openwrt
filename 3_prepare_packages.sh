if [[ `pwd` == *"r2s"* ]]; then
  git clone https://github.com/NateLol/luci-app-oled
fi
git clone https://github.com/destan19/OpenAppFilter
git clone https://github.com/rufengsuixing/luci-app-adguardhome
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon
git clone -b 18.06 https://github.com/garypang13/luci-theme-edge 
git clone https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom
git clone https://github.com/pexcn/openwrt-chinadns-ng chinadns-ng
git clone https://github.com/WuSiYu/luci-app-chinadns-ng

#git clone https://github.com/jerrykuku/lua-maxminddb.git
#git clone https://github.com/jerrykuku/luci-app-vssr.git
#cd luci-app-vssr/root/etc/
#echo 'china_ssr.txt
#config/black.list
#config/white.list
#dnsmasq.oversea/oversea_list.conf
#dnsmasq.ssr/ad.conf
#dnsmasq.ssr/gfw_base.conf
#dnsmasq.ssr/gfw_list.conf' | xargs rm
#cd ../../../
