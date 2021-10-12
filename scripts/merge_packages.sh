function merge_package(){
    pn=`echo $1 | rev | cut -d'/' -f 1 | rev`
    find package/ feeds/ \( -type l -o -type d \) -name $pn -not -path "package/custom/*" | xargs -r rm -r
    if [ ! -z "$2" ]; then
        find package/ feeds/ \( -type l -o -type d \) -name $2 | xargs -r rm -r
    fi

    if [[ $1 == *'/trunk/'* ]]; then
        svn export $1
    else
        git clone $3 --depth=1 $1
        rm -rf $pn/.git
    fi
    mv $pn package/custom/
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
merge_package https://github.com/klever1988/openwrt-mos/trunk/luci-app-mosdns
merge_package https://github.com/klever1988/openwrt-mos/trunk/mosdns
merge_package https://github.com/project-lede/luci-app-godproxy
merge_package https://github.com/Beginner-Go/luci-app-tencentddns
merge_package https://github.com/sundaqiang/openwrt-packages/trunk/luci-app-services-wolplus
merge_package https://github.com/coolsnowwolf/lede/trunk/package/lean/ntfs3-mount
merge_package https://github.com/coolsnowwolf/lede/trunk/package/lean/ntfs3
merge_package https://github.com/coolsnowwolf/lede/trunk/package/lean/uugamebooster
merge_package https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-uugamebooster
merge_package https://github.com/kuoruan/luci-app-frpc
merge_package https://github.com/small-5/luci-app-adblock-plus
merge_package https://github.com/zxlhhyccc/luci-app-v2raya
