#!/bin/ash
uci delete wireless.radio0
uci delete wireless.default_radio0
echo '请重新插拔usb网卡'
