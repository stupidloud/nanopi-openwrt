#!/bin/sh

while true; do
    source /lib/functions/network.sh
    network_find_wan NET_IF
    network_get_gateway NET_GW "${NET_IF}"

    r=`ping -c1 "${NET_GW}" 2>&1`
    case $r in
        *permitted* ) /etc/init.d/firewall restart ;;
    esac
    sleep 2
done
