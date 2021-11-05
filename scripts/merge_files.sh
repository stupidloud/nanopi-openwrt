mv $GITHUB_WORKSPACE/files ./
chmod 600 files/etc/dropbear/*
eval `cat .config | grep \" | head -n 10`
. files/etc/opkg/distfeeds.conf | tee files/etc/opkg/distfeeds.conf

echo 'iptables -t nat -A PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 53' >> files/etc/firewall.user
echo 'iptables -t nat -A PREROUTING -p tcp --dport 53 -j REDIRECT --to-ports 53' >> files/etc/firewall.user
echo '[ -n "$(command -v ip6tables)" ] && ip6tables -t nat -A PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 53' >> files/etc/firewall.user
echo '[ -n "$(command -v ip6tables)" ] && ip6tables -t nat -A PREROUTING -p tcp --dport 53 -j REDIRECT --to-ports 53' >> files/etc/firewall.user
