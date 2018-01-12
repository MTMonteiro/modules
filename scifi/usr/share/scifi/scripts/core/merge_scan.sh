#!/bin/sh
 set -xv


if [ $# -lt 2 ]; then
        echo USAGE: ./marge.sh scan_directory AP_list
        echo
        echo example: ./marge.sh scan blocod.txt
        echo
        exit 0
fi




scan=$1
lista=$2

mkdir $scan.g5 
for d in `cat $lista `; do 
	echo $d
	cat $scan.1/scan-$d.txt $scan.2/scan-$d.txt $scan.3/scan-$d.txt $scan.4/scan-$d.txt $scan.5/scan-$d.txt| awk -f scan.awk | sort -r --key=3| sort -u --key=1,1 > $scan.g5/$d.cpc
 done

