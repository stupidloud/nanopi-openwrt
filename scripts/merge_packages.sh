function merge_package(){
    pn=`echo $1 | rev | cut -d'/' -f 1 | rev`
    find package/ -follow -name $pn -not -path "package/custom/*" | xargs -rt rm -r
    if [ ! -z "$2" ]; then
        find package/ -follow -name $2 -not -path "package/custom/*" | xargs -rt rm -r
    fi

    if [[ $1 == *'/trunk/'* || $1 == *'/branches/'* ]]; then
        svn export $1
    else
        git clone --depth=1 --single-branch $3 $1
        rm -rf $pn/.git
    fi
    mv $pn package/custom/
}
function drop_package(){
    find package/ -follow -name $1 -not -path "package/custom/*" | xargs -rt rm -r
}
function merge_feed(){
    if [ ! -d "feed/$1" ]; then
        echo >> feeds.conf.default
        echo "src-git $1 $2" >> feeds.conf.default
    fi
    ./scripts/feeds update $1
    ./scripts/feeds install -a -p $1
}

rm -rf package/custom; mkdir package/custom
merge_feed nas "https://github.com/linkease/nas-packages;master"
merge_feed nas_luci "https://github.com/linkease/nas-packages-luci;main"
merge_feed helloworld "https://github.com/fw876/helloworld;master"
merge_package https://github.com/klever1988/helloworld/branches/lean/luci-app-ssr-plus
merge_package https://github.com/klever1988/helloworld/branches/lean/mosdns
#merge_package https://github.com/klever1988/openwrt-mos/trunk/luci-app-mosdns
merge_package https://github.com/project-lede/luci-app-godproxy
merge_package https://github.com/sundaqiang/openwrt-packages/trunk/luci-app-wolplus
merge_package https://github.com/kuoruan/openwrt-frp frp
merge_package https://github.com/kuoruan/luci-app-frpc
merge_package https://github.com/messense/aliyundrive-webdav/trunk/openwrt/aliyundrive-webdav
merge_package https://github.com/messense/aliyundrive-webdav/trunk/openwrt/luci-app-aliyundrive-webdav
merge_package https://github.com/jerrykuku/luci-app-jd-dailybonus
merge_package "-b 18.06 https://github.com/jerrykuku/luci-theme-argon"
merge_package https://github.com/vernesong/OpenClash/trunk/luci-app-openclash
merge_package https://github.com/NateLol/luci-app-oled
drop_package luci-app-cd8021x
drop_package luci-app-cifs
drop_package verysync
drop_package luci-app-verysync