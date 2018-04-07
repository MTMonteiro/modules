#!/bin/sh
# 20180331
#
# Matheus Monteiro Alves
# matheusmonteiro@rede.zone
#
cp -f /etc/rede/onboot/* /etc/config/     
/etc/init.d/network restart 

sleep 10
route | grep 192.168.7.1

if [ $? -eq 0 ];then 
	#PONTO#
	sed -n '1,10p' /etc/config/network > /tmp/network
	cat /etc/rede/ponto/network >> /tmp/network
	mv -f /tmp/network /etc/config/
	cat /etc/rede/wireless >> /etc/config/wireless
	cat /etc/rede/ponto/uhttpd > /etc/config/uhttpd	
	cat /etc/rede/ponto/dhcp > /etc/config/dhcp
	cat /etc/rede/ponto/firewall > /etc/config/firewall

else
	#MASTER#
	sed -n '1,10p' /etc/config/network > /tmp/network
	cat /etc/rede/master/network >> /tmp/network
	mv -f /tmp/network /etc/config/
	cat /etc/rede/wireless >> /etc/config/wireless
	cat /etc/rede/master/uhttpd > /etc/config/uhttpd
	cat /etc/rede/master/dhcp > /etc/config/dhcp
	cat /etc/rede/master/firewall > /etc/config/firewall

fi
/etc/init.d/uhttpd enable 
/etc/init.d/dnsmasq enable
/etc/init.d/dnsmasq restart                                           
/etc/init.d/uhttpd restart                                
/etc/init.d/network restart 
wifi
