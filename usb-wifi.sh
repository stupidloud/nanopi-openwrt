#!/bin/sh

display_usage() {
	echo "USB网卡WIFI设置"
	echo -e "\nUsage: $0 AP名称 密码\n"
	echo -e "\n例如: $0 OpenWrt 12345678\n"
}
# if less than two arguments supplied, display usage
if [  $# -le 1 ]
then
	display_usage
	exit 1
fi
# check whether user had supplied -h or --help . If yes display usage
if [[ "$1" == "--help" || "$1" == "-h" ]]
then
	display_usage
	exit 0
fi

rm -f /etc/config/wireless
wifi config

uci batch <<EOF
set wireless.radio0.hwmode='11a'
set wireless.radio0.country='US'
set wireless.radio0.channel='40'
set wireless.radio0.legacy_rates='1'
set wireless.radio0.mu_beamformer='1'
set wireless.radio0.htmode='HT40'
set wireless.default_radio0.device='radio0'
set wireless.default_radio0.network='lan'
set wireless.default_radio0.mode='ap'
set wireless.default_radio0.ssid=$1
set wireless.default_radio0.disassoc_low_ack='0'
set wireless.default_radio0.encryption='psk2+tkip+ccmp'
set wireless.default_radio0.key=$2
set wireless.default_radio0.wps_pushbutton='0'
EOF
uci commit wireless

read -r -p "需要重启，现在执行? [Y/n] " response
case "$response" in
	[yY][eE][sS]|[yY])
		reboot
		;;
	*)
		exit
		;;
esac
