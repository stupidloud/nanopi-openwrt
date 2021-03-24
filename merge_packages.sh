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

if [ $DEVICE = 'r2s' ]; then
    mkdir -p files/usr/bin files/etc/init.d files/etc/rc.d
    wget https://github.com/friendlyarm/friendlywrt/raw/master-v19.07.1/target/linux/rockchip-rk3328/base-files/usr/bin/start-rk3328-pwm-fan.sh -qNP files/usr/bin
    chmod +x files/usr/bin/start-rk3328-pwm-fan.sh
    wget https://github.com/friendlyarm/friendlywrt/raw/master-v19.07.1/target/linux/rockchip-rk3328/base-files/etc/init.d/fa-rk3328-pwmfan -qNP files/etc/init.d
    chmod +x files/etc/init.d/fa-rk3328-pwmfan
    ln -sf ../init.d/fa-rk3328-pwmfan files/etc/rc.d/S96fa-rk3328-pwmfan
    merge_package https://github.com/NateLol/luci-app-oled
    sed -i "s/enable '0'/enable '1'/" package/luci-app-oled/root/etc/config/oled
fi
