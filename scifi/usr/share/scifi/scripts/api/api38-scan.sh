#!/bin/sh
# version 20160303
# Central script for SCIFI-API
#
# Luiz Magalhaes
# schara (at) telecom.uff.br
# Cosme Corr..a
# cosmefc@id.uff.br
# Helio Cunha
# helioncneto@gmail.com
# uncomment for debug
#set -xv


iw phy0 interface add wlan7 type station
        ifconfig wlan7 hw ether 00:11:22:33:45:56
        ifconfig wlan7 up
        iwlist wlan7 scan | awk -f /usr/share/scifi/scripts/scan.awk | sed "s/Channel\://g" | sed "s/Quality\=//g" | sed "s/\/70 ESSID\:/ /g" > /tmp/scan.mcqe
        ifconfig wlan7 down
        iw dev wlan7 del
        if [ -e "/tmp/scan.mcqe" ]; then  cat /tmp/scan.mcqe | wc -l; else echo "-1"; fi
        echo 0 > /tmp/scan.cnt

