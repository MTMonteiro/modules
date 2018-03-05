#!/bin/sh
#
#
#Matheus Monteiro
#matheusmonteiroalves@id.uff.br
#
#uncoment for debug
#set -xv


#test ip
ip=`ifconfig br-wan | grep "inet addr" | awk -F "addr:" '{print $2}' | awk '{print $1}'`

if [ -z "$ip" ]; then                                               
    
    uci set wireless.default_radio0.disabled=1            
    uci set wireless.@wifi-iface[1].disabled=1    
    uci set wireless.@wifi-iface[2].disabled=1                                        
    uci set wireless.@wifi-iface[3].ssid='#REDE#NO IP'                       
    uci set wireless.@wifi-iface[3].disabled=0                        
    uci commit wireless; wifi                                         
    exit                                                                  
fi  


#internet test
nslookup www.uol.com.br 8.8.8.8 &>null

if [ "$?" -ne 0 ]; then

    uci set wireless.default_radio0.disabled=1            
    uci set wireless.@wifi-iface[1].disabled=1    
    uci set wireless.@wifi-iface[2].disabled=1 
    uci set wireless.@wifi-iface[3].ssid='#REDE#NO INTERNET'
    uci set wireless.@wifi-iface[3].disabled=0                        
    uci commit wireless; wifi
    exit

fi    



#everything is OK
ssid_info=`uci get wireless.@wifi-iface[3].ssid`

if [ "$ssid_info" != "INFO" ];then 
    
    uci set wireless.@wifi-iface[3].ssid='INFO'
    uci set wireless.default_radio0.disabled=0
    uci set wireless.@wifi-iface[1].disabled=0
    uci set wireless.@wifi-iface[2].disabled=0
    uci set wireless.@wifi-iface[3].disabled=1
    uci commit wireless; wifi
    exit

fi

