#!/bin/sh

a=`cat /tmp/dhcp.leases | grep 192.168.8.| awk '{print$2}' | awk '{print toupper ($ 0)}'| tr -s : -` #> devices

for d in $a 
do
	u=`curl -u 1:Quetzalcoatl -d "ac=who&macap=$d" -X POST https://rede.zone/transf/analyzer.php` &> /dev/null
	echo $d $u >> /etc/rede/users.txt
	cat /etc/rede/users.txt | sort -u > /tmp/users.txt
	cat /tmp/users.txt >  /etc/rede/users.txt
 
done

