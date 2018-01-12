#!/bin/sh
 set -xv


if [ $# -ne 1 ]; then
        echo USAGE: ./dados.sh AP_list
        echo
        echo example: ./dados.sh blocod.txt
        echo
        exit 0
fi



aplist=$1
dir='mac_list'

date

for i in 1 2 3 4 5; do

	mkdir $dir
	cp expect.sh $dir
	cd $dir

	for d in `cat ../$aplist`; do
        
		echo scanning $d
		./expect.sh root@$d
        	ssh -i /usr/share/scifi/core/controller_key root@$d "
		export PATH=/bin:/sbin:/usr/bin:/usr/sbin;
       		ifconfig | awk '/wlan/ && /HWaddr/{print $5}'" > $d.t
		awk '{print $5}' $d.t > $d.mac
		rm -rf $d.t
		cp expect.sh ../
		sleep 5
	done
	cd ..
	date
done
