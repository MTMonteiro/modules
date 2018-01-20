#!/bin/ash
#
# Central script for SCIFI-API
#
# Matheus Monteiro
# matheusmonteiroalves@id.uff.br
#
# uncomment for debug
#set -xv



MAC1=$(ifconfig -a | grep eth0.1 | awk '{print $5}');

IP_EX=$(curl -s checkip.dyndns.org | sed -e 's/.Current IP Address: //' -e 's/<.$//' | awk -F "body" '{print $2 }' | awk -F "</" '{print $1}')

echo "$IP_EX-$MAC1"

