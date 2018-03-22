#!/bin/sh
#
#
# Matheus Monteiro
# matheusmonteiroalves@id.uff.br
#
#uncoment for debug
#set -xv


#test ip
ip=`ifconfig eth0.2 | grep "inet addr" | awk -F "addr:" '{print $2}' | awk '{print $1}'`

if [ -z "$ip" ]; then                                               
    
    uci set wireless.rede.disabled=1            
    uci set wireless.open.ssid='#REDE#NO#IP'                       
    uci commit wireless; wifi                                         
    exit                                                                  
fi  


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

