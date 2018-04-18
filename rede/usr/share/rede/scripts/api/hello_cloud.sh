#!/bin/sh
#20180414
# matheus monteiro
# matheusmonteiroalves@id.uff.br
#
#set -xv

mac=`ifconfig -a | grep eth0.3 | awk '{print $5}' | tr -d :`

#add to site 0 in firstcontact
site=`grep site= /etc/rede/rede.conf | awk -F\= '{print $2 ; }'`
if [ "$site" == "None" ]; then 
     rfirstcontact=`curl -u 1:Quetzalcoatl -d "ac=firstcontact&mac=$mac" -X POST https://rede.zone/transf/analyzer.php`
     [ $? = 0 ] && sed -i 's/site=None/site=1/'  /etc/rede/rede.conf 
     date=`echo $rfirstcontact | awk '{print$1" "$2}'`
     passwd=`echo $rfirstcontact | awk '{print$3}'`
     sed -i 's/passwd=None/passwd='$passwd'/'  /etc/rede/rede.conf
     #date -s "YYYY-MM-DD hh:mm:ss"
     date -s "$date"

fi


################
# missing data #
################

owner=`grep owner= /etc/rede/rede.conf | awk -F\= '{print $2 ; }'`     
ssid2=`grep ssid2= /etc/rede/rede.conf | awk -F\= '{print $2 ; }'`   
site=`grep site= /etc/rede/rede.conf | awk -F\= '{print $2 ; }'`

contact=`curl -u 1:Quetzalcoatl -d "ac=missing&owner=$owner&ssid2=$ssid2&site=$site" -X POST https://rede.zone/transf/analyzer.php`
#answer
contact2=`echo $contact | awk '{print$3}'`
#date
contact1=`echo $contact | awk '{print$1" "$2}'` 

#date verification
DateAp=`date +"%Y-%m-%d %H:%M"`
DateServer=`echo $contact1 | awk -F\: '{print $1":"$2 ; }'`
[ "$DateAp" -ne "$DateServer" ] && date -s "$contact1"


##############
# send data #
#############

if [ "$contact2" == "SENDDATA" ]; then 
	
	/usr/share/rede/scripts/collect_data.sh
	
fi

