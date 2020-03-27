#!/bin/sh

while true; do
    wan=`/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'`
    r=`ping -c1 $wan 2>&1`
    case $r in
        *permitted* ) /etc/init.d/firewall reload ;;
    esac
    sleep 2
done
