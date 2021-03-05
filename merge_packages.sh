git clone --depth=1 https://github.com/project-lede/luci-app-godproxy && mv luci-app-godproxy package/
git clone --depth=1 https://github.com/destan19/OpenAppFilter.git && rm -r package/OpenAppFilter && mv OpenAppFilter package/
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git && rm -r package/lean/luci-theme-argon && mv luci-theme-argon package/lean/

svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-cifsd && rm -r package/lean/luci-app-ksmbd && mv luci-app-cifsd package/lean/
svn co https://github.com/coolsnowwolf/packages/trunk/kernel/ksmbd && rm -r package/feeds/packages/ksmbd && mv ksmbd package/feeds/packages/
svn co https://github.com/coolsnowwolf/packages/trunk/net/ksmbd-tools && rm -r package/feeds/packages/ksmbd-tools && mv ksmbd-tools package/feeds/packages/

if [ $DEVICE = 'r2s' ]; then
mkdir -p target/linux/rockchip/armv8/base-files/usr/bin &&\
wget https://github.com/friendlyarm/friendlywrt/raw/master-v19.07.1/target/linux/rockchip-rk3328/base-files/usr/bin/start-rk3328-pwm-fan.sh -qNP target/linux/rockchip/armv8/base-files/usr/bin &&\
chmod +x target/linux/rockchip/armv8/base-files/usr/bin/start-rk3328-pwm-fan.sh
mkdir -p target/linux/rockchip/armv8/base-files/etc/init.d &&\
wget https://github.com/friendlyarm/friendlywrt/raw/master-v19.07.1/target/linux/rockchip-rk3328/base-files/etc/init.d/fa-rk3328-pwmfan -qNP target/linux/rockchip/armv8/base-files/etc/init.d &&\
chmod +x target/linux/rockchip/armv8/base-files/etc/init.d/fa-rk3328-pwmfan
mkdir -p target/linux/rockchip/armv8/base-files/etc/rc.d &&\
ln -sf ../init.d/fa-rk3328-pwmfan target/linux/rockchip/armv8/base-files/etc/rc.d/S96fa-rk3328-pwmfan

git clone --depth=1 https://github.com/NateLol/luci-app-oled && mv luci-app-oled package/
fi
