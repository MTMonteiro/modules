#!/bin/sh
#
#
# Matheus Monteiro
# matheusmonteiroalves@id.uff.br
#
#uncoment for debug
#set -xv 

#internet test
nslookup www.uol.com.br 8.8.8.8 &> /dev/null 

if [ "$?" -ne 0 ]; then
            
    uci set wireless.rede.disabled=1     
    uci set wireless.open.ssid='#REDE#NO#INTERNET'
    uci commit wireless; wifi
    exit

fi    



#everything is OK
ssid_info=`uci get wireless.open.ssid`

if [ "$ssid_info" != "OPEN ZONE" ];then 
    
    uci set wireless.open.ssid='OPEN ZONE'
    uci set wireless.rede.disabled=0
    uci commit wireless; wifi
    exit

fi

