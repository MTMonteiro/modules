#!/bin/sh
# version 20160303
# Central script for SCIFI-API
#
# Luiz Magalhaes
# schara (at) telecom.uff.br
# Cosme Corr..a
# cosmefc@id.uff.br
# uncomment for debug
#set -xv

case "$1" in

# Calls # 1,2,3,4,5,6 , 7, 11, 12, 14,17 and 18
ID | VERSION | SUBVERSION | DEVICE | COORDINATES | TAGS | CONNECTED2 | SEGMENT | FIRMWARE | PING_ENABLE | CAMPUS | DEPARTMENT)
awk -v search=$1 '{if ($1==search) print $2;}' /etc/scifi/scifi.conf
        ;;

# Call #8
USERS) 
# this version for APs only
	nsta=0;for i in `ifconfig | grep wlan0 | awk '{print $1}'`; do let nsta=$nsta+`iw $i station dump | grep -c Station`;done; echo $nsta > /tmp/nsta.txt; echo $nsta;	
        ;;

# Call #9
NEIGHBORHOOD) if [ -f "/tmp/scifi-neighborhood.txt" ];
                then
                 cat /tmp/scifi-neighborhood.txt
                else
                 echo "0"
                fi
        ;;

# Call #10
UPTIME) echo $((`cut -d'.' -f1 /proc/uptime`/60))
        ;;

# Call #13
LEASES) echo "0"
	;;

# Call #15
LOSS) if [ -e "/tmp/loss.txt" ]; then cat /tmp/loss.txt; else echo "0"; fi
	;;

# Call #16
DELAY) if [ -e "/tmp/delay.txt" ]; then cat /tmp/delay.txt; else echo "0"; fi
	;;

# Call #19
DATA_VLAN) 
if [ "`awk  '{if ($1=="SEGMENT") print $2;}' /etc/scifi/scifi.conf`" == "SC" ]; then
        if [ -e "/tmp/wifi0_status.txt" ]; then cat /tmp/wifi0_status.txt; else echo "-1"; fi
else
        if [ -e "/tmp/statuswlan0" ]; then cat /tmp/statuswlan0; else echo "-1"; fi
fi
        ;;
                        
# Call #20
REGISTRATION_VLAN)
if [ "`awk  '{if ($1=="SEGMENT") print $2;}' /etc/scifi/scifi.conf`" == "SC" ]; then
        if [ -e "/tmp/wifi1_status.txt" ]; then cat /tmp/wifi1_status.txt; else echo "-1"; fi
else
        if [ -e "/tmp/statuswlan0-1" ]; then cat /tmp/statuswlan0-1; else echo "-1"; fi
fi
        ;;
                                                
# Call #21
VISITORS_VLAN) 
if [ "`awk  '{if ($1=="SEGMENT") print $2;}' /etc/scifi/scifi.conf`" == "SC" ]; then
        if [ -e "/tmp/wifi2_status.txt" ]; then cat /tmp/wifi2_status.txt; else echo "-1"; fi
else
        if [ -e "/tmp/statuswlan0-2" ]; then cat /tmp/statuswlan0-2; else echo "-1"; fi
fi
        ;;

# Call #22
DATA_RX)  ifconfig wlan0 | grep "RX bytes" | awk -F ":" '{print $2}' | awk '{print $1}'
        ;;

# Call #23
DATA_TX)  ifconfig wlan0 | grep "TX bytes" | awk -F ":" '{print $3}' | awk '{print $1}'
        ;;

# Call #24
REGISTRATION_RX) ifconfig wlan0-1 | grep "RX bytes" | awk -F ":" '{print $2}' | awk '{print $1}'
        ;;

# Call #25
REGISTRATION_TX) ifconfig wlan0-1 | grep "TX bytes" | awk -F ":" '{print $3}' | awk '{print $1}'
        ;;

# Call #26
VISITORS_RX) ifconfig wlan0-2 | grep "RX bytes" | awk -F ":" '{print $2}' | awk '{print $1}'
        ;;

# Call #27
VISITORS_TX) ifconfig wlan0-2 | grep "TX bytes" | awk -F ":" '{print $3}' | awk '{print $1}'
        ;;

# Call #28
WLOCAL_RX) ifconfig wlan0-3 | grep "RX bytes" | awk -F ":" '{print $2}' | awk '{print $1}'
        ;;

# Call #29
WLOCAL_TX) ifconfig wlan0-3 | grep "TX bytes" | awk -F ":" '{print $3}' | awk '{print $1}'
	;;

# Call #30
CHANNEL) uci get wireless.radio0.channel 
	;;

# Call #31
POWER) iwlist txpower 2> /dev/null | grep -m 1 wlan0 -A2 | grep Current | awk '{print $2}' | sed 's/Tx-Power=//g'
	;;

# Call #32
CHANNEL5) uci get wireless.radio1.channel 
        ;;

# Call #33
POWER5) iwlist txpower 2> /dev/null | grep -m 1 wlan1 -A2 | grep Current | awk '{print $2}' | sed 's/Tx-Power=//g'
        ;;

#Call #34                                   
NMACS) ifconfig | grep wlan0 | wc -l
        ;;

# Call #35
MACS) ifconfig | grep wlan0 | awk '{print $5}'
	;;

# Call #36                                     
NMACS5) ifconfig | grep wlan1 | wc -l
        ;;  

# Call #37
MACS5) ifconfig | grep wlan1 | awk '{print $5}'
        ;;

# Call #38
SCAN)

        iw phy0 interface add wlan7 type station
	ifconfig wlan7 hw ether 00:11:22:33:45:56
	ifconfig wlan7 up
	iwlist wlan7 scan | awk -f /usr/share/scifi/scripts/scan.awk | sed "s/Channel\://g" | sed "s/Quality\=//g" | sed "s/\/70 ESSID\:/ /g" > /tmp/scan.mcqe
	ifconfig wlan7 down
	iw dev wlan7 del
	if [ -e "/tmp/scan.mcqe" ]; then  cat /tmp/scan.mcqe | wc -l; else echo "-1"; fi
	echo 0 > /tmp/scan.cnt
		;;

# Call #39

SIZESCAN) if [ -e "/tmp/scan.mcqe" ]; then
	     cat /tmp/scan.mcqe | wc -l
	     else echo "-1"
	     fi
	     ;;

# Call #40
GETSCAN) if [ -e "/tmp/scan.cnt" ]; then 
		inicio=`cat /tmp/scan.cnt`
		fim=0
		let "fim=inicio+16"
		max=`cat /tmp/scan.mcqe | wc -l`
       		if [ $max -gt $fim ]; then
                       head -n $fim /tmp/scan.mcqe | tail -n 16
		       echo $fim > /tmp/scan.cnt
		       else
		            resto=0
			    let "resto=max+16-fim"
			    tail -n $resto /tmp/scan.mcqe
			    echo 0 > /tmp/scan.cnt
		       fi
	fi
	;;



# Call #41
SCAN5)
	iw phy1 interface add wlan8 type station
	ifconfig wlan8 hw ether 00:11:22:33:45:57
	ifconfig wlan8 up
	iwlist wlan8 scan | awk -f /usr/share/scifi/scripts/scan.awk | sed "s/Channel\://g" | sed "s/Quality\=//g" | sed "s/\/70 ESSID:/ /g" > /tmp/scan5.mcqe
	ifconfig wlan8 down
	iw dev wlan8 del
	if [ -e "/tmp/scan.mcqe" ]; then  cat /tmp/scan5.mcqe | wc -l; else echo "-1"; fi
	echo 0 > /tmp/scan5.cnt
	;;

# Call #42
SIZESCAN5) if [ -e "/tmp/scan5.mcqe" ]; then
	  	cat /tmp/scan5.mcqe | wc -l
		else echo "-1"
		fi
	;;

# Call #43
GETSCAN5) if [ -e "/tmp/scan5.cnt" ]; then
		inicio=`cat /tmp/scan5.cnt`
		fim=0
		let "fim=inicio+16"
		max=`cat /tmp/scan5.mcqe | wc -l`
		if [ $max -gt $fim ]; then
			head -n $fim /tmp/scan5.mcqe | tail -n 16
			echo $fim > /tmp/scan5.cnt
			else
			resto=0
			let "resto=max+16-fim"
			tail -n $resto /tmp/scan5.mcqe
			echo 0 > /tmp/scan5.cnt
			fi
	fi
	;;

# Call #44
SETCHANNEL) /usr/share/scifi/scripts/current_channel.sh
	;;

# Call #45
SETCHANNEL5) /usr/share/scifi/scritps/current_channel5.sh
	;;


*) echo "not found"
   ;;

esac
