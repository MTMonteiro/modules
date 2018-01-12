#!/bin/sh
 set -xv


if [ $# -lt 2 ]; then
        echo USAGE: ./dados.sh scan_directory AP_list
        echo
        echo example: ./dados.sh scan blocod.txt
        echo
        exit 0
fi


scandir=$1
aplist=$2


date

for i in 1 2 3 4 5; do

	mkdir $scandir.$i
	mv expect.sh $scandir.$i
	cd $scandir.$i

	for d in `cat ../$aplist`; do
        
		echo scanning $d
		./expect.sh root@$d
        	ssh -i /usr/share/scifi/core/controller_key root@$d "
		export PATH=/bin:/sbin:/usr/bin:/usr/sbin;
  		iw phy0 interface add wlan8 type station
       		ifconfig wlan8 hw ether 00:11:22:33:45:57
       		ifconfig wlan8 up
       		iwlist wlan8 scan 
		ifconfig wlan8 down
        	iw dev wlan8 del" > scan-$d.txt
		sleep 5
	done
	mv -rf expect.sh ../
	cd ..
	date
done
