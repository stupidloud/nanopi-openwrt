function merge_package(){
    repo=`echo $1 | rev | cut -d'/' -f 1 | rev`
    pkg=`echo $2 | rev | cut -d'/' -f 1 | rev`
    find package/ -follow -name $pkg -not -path "package/custom/*" | xargs -rt rm -rf
    git clone --depth=1 --single-branch $1
    mv $2 package/custom/
    rm -rf $repo
}
function drop_package(){
    find package/ -follow -name $1 -not -path "package/custom/*" | xargs -rt rm -rf
}
function merge_feed(){
    if [ ! -d "feed/$1" ]; then
        echo >> feeds.conf.default
        echo "src-git $1 $2" >> feeds.conf.default
    fi
    ./scripts/feeds update $1
    ./scripts/feeds install -a -p $1
}

rm -rf feeds/packages/net/mosdns package/feeds/packages/mosdns
rm -rf package/custom; mkdir package/custom
merge_feed nas "https://github.com/linkease/nas-packages;master"
merge_feed nas_luci "https://github.com/linkease/nas-packages-luci;main"
rm -r package/feeds/nas_luci/luci-app-ddnsto
merge_feed helloworld "https://github.com/stupidloud/helloworld;tmp"
merge_package https://github.com/ilxp/luci-app-ikoolproxy luci-app-ikoolproxy
merge_package https://github.com/sundaqiang/openwrt-packages openwrt-packages/luci-app-wolplus
merge_package https://github.com/messense/aliyundrive-webdav aliyundrive-webdav/openwrt/aliyundrive-webdav
merge_package https://github.com/messense/aliyundrive-webdav aliyundrive-webdav/openwrt/luci-app-aliyundrive-webdav
merge_package "-b 18.06 https://github.com/jerrykuku/luci-theme-argon" luci-theme-argon
merge_package https://github.com/vernesong/OpenClash OpenClash/luci-app-openclash
merge_package https://github.com/NateLol/luci-app-oled luci-app-oled
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/brook
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/chinadns-ng
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/trojan-go
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/trojan-plus
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/sing-box
merge_package "-b main https://github.com/xiaorouji/openwrt-passwall" openwrt-passwall
merge_package https://github.com/jerrykuku/lua-maxminddb lua-maxminddb
merge_package https://github.com/kongfl888/luci-app-adguardhome luci-app-adguardhome
drop_package luci-app-cd8021x
drop_package luci-app-cifs
drop_package verysync
drop_package luci-app-verysync
drop_package luci-app-mosdns