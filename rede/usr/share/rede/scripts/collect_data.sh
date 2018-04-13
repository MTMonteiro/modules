#!/bin/sh
#20180309
# matheus monteiro
# matheusmonteiroalves@id.uff.br
#
set -xv

	wlan0m=$(cat /sys/class/ieee80211/phy0/macaddress | awk '{print toupper($0)}')

	#time=`date +"%Y-%m-%d %H:%M:%S"`
	time=`date +%s`

	mac=`ifconfig -a | grep eth0.3 | awk '{print $5}' | tr -d :`
	device=`cat /proc/cpuinfo | grep machine | awk -F\: '{print $2 ; }'`

	userst=0;for i in `ifconfig | grep wlan0 | awk '{print $1}'`; do let userst=$userst+`iw $i station dump | grep -c Station`;done
	users1=0;for i in `ifconfig | grep "$wlan0m" | awk '{print $1}'`; do let users1=$users1+`iw $i station dump | grep -c Station`;done
	users2=0;for i in `ifconfig | grep wlan0-1 | awk '{print $1}'`; do let users2=$users2+`iw $i station dump | grep -c Station`;done
	users3=0;for i in `ifconfig | grep wlan0-2 | awk '{print $1}'`; do let users3=$users3+`iw $i station dump | grep -c Station`;done

	up=$((`cut -d'.' -f1 /proc/uptime`/60))

	ch=`uci get wireless.radio0.channel`

	Wrx=`ifconfig br-wan | grep "RX bytes" | awk -F ":" '{print $2}' | awk '{print $1}'`                                                    
                                                                                                                                               
        Wtx=`ifconfig br-wan | grep "TX bytes" | awk -F ":" '{print $3}' | awk '{print $1}'`
	
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
	
	ip_ex=`curl -s checkip.dyndns.org | sed -e 's/.Current IP Address: //' -e 's/<.$//' | awk -F "body" '{print $2 }' | awk -F "</" '{print $1}'`
	
	A=`echo $ip_ex | awk -F\. '{print $1 ; }'` ; B=`echo $ip_ex | awk -F\. '{print $2 ; }'` ; C=`echo $ip_ex | awk -F\. '{print $3 ; }'` ; D=`echo $ip_ex | awk -F\. '{print $4 ; }'`
        ip=$(($A*256^3+$B*256^2+$C*256+$D))

echo "time=$time
mac=$mac
userst=$userst
site=$site
ip=$ip
wanrx=$Wrx
wantx=$Wtx" > /tmp/$mac-$time.dt

