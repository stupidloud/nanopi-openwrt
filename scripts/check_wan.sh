#!/bin/sh

source /lib/functions/network.sh
network_find_wan NET_IF
network_get_gateway NET_GW "${NET_IF}"

r=`ping -c1 "${NET_GW}"`
r=`echo $r | grep Permitted`
while true; do
    if [[ "$r" != "" ]] ;then
        /etc/init.d/firewall restart
    fi
    sleep 2
done
