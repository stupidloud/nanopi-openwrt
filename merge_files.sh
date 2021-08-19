mv $GITHUB_WORKSPACE/files ./
if [ $DEVICE = 'r2s' -o $DEVICE = 'r2c' ]; then
    mkdir -p files/usr/bin files/etc/init.d files/etc/rc.d
    wget https://github.com/friendlyarm/friendlywrt/raw/master-v19.07.1/target/linux/rockchip-rk3328/base-files/usr/bin/start-rk3328-pwm-fan.sh -qNP files/usr/bin
    chmod +x files/usr/bin/start-rk3328-pwm-fan.sh
    wget https://github.com/friendlyarm/friendlywrt/raw/master-v19.07.1/target/linux/rockchip-rk3328/base-files/etc/init.d/fa-rk3328-pwmfan -qNP files/etc/init.d
    chmod +x files/etc/init.d/fa-rk3328-pwmfan
    ln -sf ../init.d/fa-rk3328-pwmfan files/etc/rc.d/S96fa-rk3328-pwmfan
fi
if [ $DEVICE = 'r4s' ]; then
    mkdir -p files/usr/bin files/etc/init.d files/etc/rc.d
    wget https://raw.githubusercontent.com/btyh17mxy/friendlywrt/fix/rk3399-fan-ctl/target/linux/rockchip-rk3399/base-files/usr/bin/start-rk3399-pwm-fan.sh -qNP files/usr/bin
    chmod +x files/usr/bin/start-rk3399-pwm-fan.sh
    wget https://raw.githubusercontent.com/friendlyarm/friendlywrt/master-v19.07.1/target/linux/rockchip-rk3399/base-files/etc/init.d/fa-rk3399-pwmfan -qNP files/etc/init.d
    chmod +x files/etc/init.d/fa-rk3399-pwmfan
    ln -sf ../init.d/fa-rk3399-pwmfan files/etc/rc.d/S96fa-rk3399-pwmfan
fi
chmod 600 files/etc/dropbear/*
eval `cat .config | grep \" | head -n 10`
. files/etc/opkg/distfeeds.conf | tee files/etc/opkg/distfeeds.conf

echo "iptables -t nat -A PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 53" >> files/etc/firewall.user
echo "iptables -t nat -A PREROUTING -p tcp --dport 53 -j REDIRECT --to-ports 53" >> files/etc/firewall.user
