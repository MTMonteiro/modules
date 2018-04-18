#!/bin/sh
# 20180414
#
# Matheus Monteiro Alves
# matheusmonteiro@rede.zone
#
# sets between master and point

swconfig dev switch0 show | grep up | awk '{print$2}'| tr -d port:6 | grep '[12345]' &> /dev/null
if [ $? -eq 0 ];then 
	#PONTO#
	sed -n '1,10p' /etc/config/network > /tmp/network
	cat /etc/rede/ponto/network >> /tmp/network
	mv -f /tmp/network /etc/config/
	cat /etc/rede/ponto/uhttpd > /etc/config/uhttpd	
	cat /etc/rede/ponto/dhcp > /etc/config/dhcp
	cat /etc/rede/ponto/firewall > /etc/config/firewall
	echo " " > /etc/crontabs/root
fi

swconfig dev switch0 show | grep up | awk '{print$2}'| tr -d port:6 | grep 0 &> /dev/null
if [ $? -eq 0 ];then 
	#MASTER#
	sed -n '1,10p' /etc/config/network > /tmp/network
	cat /etc/rede/master/network >> /tmp/network
	mv -f /tmp/network /etc/config/
	cat /etc/rede/master/uhttpd > /etc/config/uhttpd
	cat /etc/rede/master/dhcp > /etc/config/dhcp
	cat /etc/rede/master/firewall > /etc/config/firewall
	cat /etc/rede/master/root > /etc/crontabs/root
	echo "5 04 * * * /bin/ash /usr/share/rede/scripts/restart_wifi.sh &> /dev/null
5 04 * * * /bin/ash /usr/share/rede/scripts/update.sh &> /dev/null
00 0 * * * /bin/ash /usr/share/rede/scripts/update.sh &> /dev/null                                                    
*/3 * * * * /usr/share/rede/scripts/startup_error.sh &> /dev/null                             
*/15 * * * * /usr/share/rede/scripts/api/hello_cloud.sh &> /dev/null
*/5 * * * * /usr/share/rede/scripts/collect_data.sh &> /dev/null" > /etc/crontabs/root
fi

/etc/init.d/uhttpd enable 
/etc/init.d/dnsmasq enable
/etc/init.d/dnsmasq restart                                           
/etc/init.d/uhttpd restart                                
/etc/init.d/network restart 
wifi
