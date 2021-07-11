function merge_package(){
    pn=`echo $1 | rev | cut -d'/' -f 1 | rev`
    find package/ \( -type l -o -type d \) -name $pn | xargs -r rm -r
    if [ ! -z "$2" ]; then
        find package/ \( -type l -o -type d \) -name $2 | xargs -r rm -r
    fi

    if [[ $1 == *'/trunk/'* ]]; then
        svn export $1
    else
        git clone $3 --depth=1 $1
        rm -rf $pn/.git
    fi
    mv $pn package/
}

merge_package https://github.com/linkease/ddnsto-openwrt
merge_package https://github.com/project-lede/luci-app-godproxy
merge_package https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-cifsd luci-app-ksmbd
merge_package https://github.com/coolsnowwolf/packages/trunk/kernel/ksmbd
merge_package https://github.com/coolsnowwolf/packages/trunk/net/ksmbd-tools
merge_package https://github.com/Beginner-Go/luci-app-tencentddns
merge_package https://github.com/sundaqiang/openwrt-packages/trunk/luci-app-services-wolplus