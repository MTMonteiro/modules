#!/bin/sh
#20180206
# matheus monteiro
#
#
wlan0m=$(cat /sys/class/ieee80211/phy0/macaddress | awk '{print toupper($0)}')

time=`date +"%Y-%m-%d_%H-%M-%S"`

mac=`ifconfig -a | grep eth0.1 | awk '{print $5}' | tr -d :`


userst=0;for i in `ifconfig | grep wlan0 | awk '{print $1}'`; do let users1=$users1+`iw $i station dump | grep -c Station`;done
users1=0;for i in `ifconfig | grep "$wlan0m" | awk '{print $1}'`; do let users1=$users1+`iw $i station dump | grep -c Station`;done
users2=0;for i in `ifconfig | grep wlan0-1 | awk '{print $1}'`; do let users2=$users2+`iw $i station dump | grep -c Station`;done
users3=0;for i in `ifconfig | grep wlan0-2 | awk '{print $1}'`; do let users3=$users3+`iw $i station dump | grep -c Station`;done

up=`echo $((`cut -d'.' -f1 /proc/uptime`/60))`

ch=`uci get wireless.radio0.channel`

Rrx=`ifconfig wlan0 | grep "RX bytes" | awk -F ":" '{print $2}' | awk '{print $1}'`

Rtx=`ifconfig wlan0 | grep "TX bytes" | awk -F ":" '{print $3}' | awk '{print $1}'`

Drx=`ifconfig wlan0-1 | grep "RX bytes" | awk -F ":" '{print $2}' | awk '{print $1}'`

Dtx=`ifconfig wlan0-1 | grep "TX bytes" | awk -F ":" '{print $3}' | awk '{print $1}'`

local=`cat /tmp/location`

ssidd=`uci get wireless.@wifi-iface[1].ssid`
stt=`uci get wireless.@wifi-iface[1].disabled`
ssidi=`uci get wireless.@wifi-iface[3].ssid`
stti=`uci get wireless.@wifi-iface[3].disabled`

disk=`df -h`
memory=`free -m`

echo "mac=$mac
userst=$userst
users1=$users1
users2=$users2
users3=$users3
uptime=$up
channel=$ch
rede_rx=$Rrx
rede_tx=$Rtx
ssid_dominio=$ssidd
disabled_dominio=$stt
dominio_rx=$Drx
dominio_tx=$Dtx
ssid_info=$ssidi
location=$local
memory=$memory
disk=$disk" > /tmp/$mac-$time.txt

curl -F "fileToUpload=@/tmp/$mac-$time.txt" -X POST https://rede.zone/upload.php

rm -rf /tmp/$mac-$time.txt
