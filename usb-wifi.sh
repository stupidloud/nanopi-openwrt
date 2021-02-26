#!/bin/sh

uci delete wireless.radio0
uci delete wireless.default_radio0
uci commit wireless

echo "package wireless

config wifi-device 'radio0'
	option type 'mac80211'
	option hwmode '11a'
	option path 'platform/ff5c0000.usb/usb1/1-1/1-1:1.0'
	option country 'US'
	option channel '40'
	option legacy_rates '1'
	option mu_beamformer '1'
	option htmode 'HT40'

config wifi-iface 'default_radio0'
	option device 'radio0'
	option network 'lan'
	option mode 'ap'
	option ssid 'Owrt'
	option disassoc_low_ack '0'
	option encryption 'psk2+tkip+ccmp'
	option key 'password'
	option wps_pushbutton '0'

" | uci import
uci commit wireless

read -r -p "Reboot now? [Y/n] " response
case "$response" in
	[yY][eE][sS]|[yY]) 
		reboot
		;;
	*)
		exit
		;;
esac
