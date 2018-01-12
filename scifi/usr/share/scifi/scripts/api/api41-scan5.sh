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


iw phy1 interface add wlan8 type station
        ifconfig wlan8 hw ether 00:11:22:33:45:57
        ifconfig wlan8 up
        iwlist wlan8 scan | awk -f /usr/share/scifi/scripts/scan.awk | sed "s/Channel\://g" | sed "s/Quality\=//g" | sed "s/\/70 ESSID:/ /g" > /tmp/scan5.mcqe
        ifconfig wlan8 down
        iw dev wlan8 del
        if [ -e "/tmp/scan.mcqe" ]; then  cat /tmp/scan5.mcqe | wc -l; else echo "-1"; fi
        echo 0 > /tmp/scan5.cnt

