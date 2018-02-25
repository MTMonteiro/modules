#!/bin/ash
#
# Central script for SCIFI-API
#
# Matheus Monteiro
# matheusmonteiroalves@id.uff.br
#
# uncomment for debug
#set -xv



MAC1=$(ifconfig -a | grep eth0.1 | awk '{print $5}' | tr -d :)

IP_EX=$(curl -s checkip.dyndns.org | sed -e 's/.Current IP Address: //' -e 's/<.$//' | awk -F "body" '{print $2 }' | awk -F "</" '{print $1}')

curl http://rede.zone/ap_control/record | grep "$MAC1" 
if [ $? -ne 0 ]; then
	touch /tmp/hi-$MAC1.txt  
	curl -F "fileToUpload=@/tmp/hi-$MAC1.txt" -X POST https://rede.zone/upload.php
	rm /tmp/hi-$MAC1.txt
fi

