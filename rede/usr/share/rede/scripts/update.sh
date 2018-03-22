#!/bin/sh
#
# Matheus Monteiro
# matheusmonteiroalves@id.uff.br
#
#set -xv 
export PATH=/bin:/sbin:/usr/bin:/usr/sbin;

version=`grep version= /etc/rede/rede.conf | awk -F\= '{print $2 ; }'`

current_version=`curl -u 1:Quetzalcoatl -d "ac=update" -X POST https://rede.zone/transf/analyzer.php`


if [[ $current_version > $version ]]; then

#script.sh
        curl -u 1:Quetzalcoatl https://rede.zone/transf/update/$current_version/script.sh > /tmp/script.sh
	chmod 777 /tmp/script.sh
	/tmp/script.sh
        rm -rf /tmp/script.sh
	sed -i "s/$version/$current_version/"  /etc/rede/rede.conf

fi

