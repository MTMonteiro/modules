#!/bin/sh
#20180206
#
#Matheus Monteiro
#matheusmonteiroalves@id.uff.br
#
#uncoment for debug
set -xv
#
export PATH=/bin:/sbin:/usr/bin:/usr/sbin;
#update directory

MAC1=$(ifconfig -a | grep eth0.1 | awk '{print $5}' | tr -d :)
dir=/tmp/update

curl https://rede.zone/ap_control/record | grep "$MAC1" | awk '{print $2}'
if [ $? -eq 0 ]; then
   dominio=$(curl https://rede.zone/ap_control/record | grep "$MAC1" | awk '{print $2}')
   curl https://rede.zone/ap_control/$dominio/$MAC1.txt > /tmp/update
  
   #channel
   
   canal=`grep channel= $dir | awk '{print$2}'`
   canalatual=`uci get wireless.radio0.channel`
   if [ $canal -ne $canalatual ]; then
      case "$canal" in           

        1) uci set wireless.radio0.channel=1
        ;;
                                                    
        6) uci set wireless.radio0.channel=6
        ;;
                                                    
        11) uci set wireless.radio0.channel=11
        ;;
                                                      
        *) echo "invalid channel $canal"
        logger "invalid channel $canal"
        ;;                              
                                       
       esac
  
   fi


  #ssid domain

   ssid=`grep dominiossid= $dir | awk '{print$2}'`
   ssidatual=`uci get wireless.@wifi-iface[1].ssid`
   if [ -n "$ssid" -a "$ssid"!="$ssidatual" ];then 
      uci set wireless.@wifi-iface[1].ssid=$ssid
      uci commit wireless; wifi
   fi



 #location
 grep location= $dir | awk '{print$2}' > /tmp/location

 #command line
 command=$(grep command= $dir | awk '{print $2}')
 $command 

 #archive
 grep archive= $dir | awk '{print$2}'
 if [ $? -eq 0 ]; then
    grep archive= $dir | awk '{print $2}' > /tmp/arq
    arg=$(grep archive= $dir | awk '{print $3}')
    d=$(grep archive= $dir | awk '{print $4}')
    case "$arg" in                                
                                                      
        execute) chmod 777 /tmp/arq ; /tmp/arq           
        ;;                                            
                                                          
        replace) mv $d /tmp/$d-old ; mv /tmp/arq $d
        ;;                                            
                                                      
        *) echo "invalid argument $arg"              
        logger "invalid argument $arg"               
        ;;                                            
                                                      
       esac                          
     rm -rf /tmp/arq
 fi

rm -rf /tmp/update 
fi

