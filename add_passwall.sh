echo -e '\nsrc-git lienol https://github.com/xiaorouji/openwrt-package' >> feeds.conf.default
./scripts/feeds update lienol
rm -rf feeds/lienol/lienol/ipt2socks
rm -rf feeds/lienol/lienol/shadowsocksr-libev
rm -rf feeds/lienol/lienol/pdnsd-alt
rm -rf feeds/lienol/lienol/luci-app-verysync
rm -rf feeds/lienol/package/verysync
rm -rf feeds/lienol/package/chinadns-ng
rm -rf package/lean/luci-app-kodexplorer
rm -rf package/lean/luci-app-pppoe-relay
rm -rf package/lean/luci-app-pptp-server
rm -rf package/lean/luci-app-v2ray-server
./scripts/feeds install -a -p lienol
