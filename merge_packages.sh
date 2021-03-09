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

merge_package https://github.com/project-lede/luci-app-godproxy
merge_package https://github.com/jerrykuku/luci-theme-argon luci-theme-argon "-b 18.06"
merge_package https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-cifsd luci-app-ksmbd
merge_package https://github.com/coolsnowwolf/packages/trunk/kernel/ksmbd
merge_package https://github.com/coolsnowwolf/packages/trunk/net/ksmbd-tools

if [ $DEVICE = 'r2s' ]; then
mkdir -p target/linux/rockchip/armv8/base-files/usr/bin &&\
wget https://github.com/friendlyarm/friendlywrt/raw/master-v19.07.1/target/linux/rockchip-rk3328/base-files/usr/bin/start-rk3328-pwm-fan.sh -qNP target/linux/rockchip/armv8/base-files/usr/bin &&\
chmod +x target/linux/rockchip/armv8/base-files/usr/bin/start-rk3328-pwm-fan.sh
mkdir -p target/linux/rockchip/armv8/base-files/etc/init.d &&\
wget https://github.com/friendlyarm/friendlywrt/raw/master-v19.07.1/target/linux/rockchip-rk3328/base-files/etc/init.d/fa-rk3328-pwmfan -qNP target/linux/rockchip/armv8/base-files/etc/init.d &&\
chmod +x target/linux/rockchip/armv8/base-files/etc/init.d/fa-rk3328-pwmfan
mkdir -p target/linux/rockchip/armv8/base-files/etc/rc.d &&\
ln -sf ../init.d/fa-rk3328-pwmfan target/linux/rockchip/armv8/base-files/etc/rc.d/S96fa-rk3328-pwmfan
sed -i "s/enable\ \'0\'/enable \'1\'/" package/ctcgfw/luci-app-oled/root/etc/config/oled
fi

sed -i 's/192.168.1.1/192.168.2.1/' package/base-files/files/bin/config_generate

mkdir -p package/base-files/files/etc/dropbear
mv $GITHUB_WORKSPACE/host_keys/* package/base-files/files/etc/dropbear/
chmod 600 package/base-files/files/etc/dropbear/*
