version 20160411
#
# Script for auto update via http
#
# Glauco Quintino
# uncomment for debug
#set -xv

cd /tmp
IP=$(ifconfig br-lan |grep "inet addr:" |awk '{print $2}'| awk -F ":" '{print $2}')
NOME=$(nslookup $IP |grep wifi.uff.br|awk '{print $4}'|awk -F"." '{print $1}')
rm -f update.sh
wget http://www.wifi.uff.br/scifi/aps/$NOME/update.sh
                 
if [ -e /tmp/update.sh  ]
                         
then                     
sh update.sh
logger "atualizando $NOME via update"
fi                                
