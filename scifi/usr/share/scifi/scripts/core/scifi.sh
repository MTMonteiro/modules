#!/bin/sh
#
# Fernando Silveira
# Version
# 20160903

 set -xv

dirsh='scripts/'
#dirmac='mac_list/'



if [ $# -ne 2 ]; then
        echo USAGE: ./scifi.sh List_of_devices Directory
        echo
        echo example: ./scifi.sh ap_list.txt scan
        echo
        exit 0
fi


sh $dirsh'get_mac.sh' $1

sh $dirsh'get_scan.sh' $2 $1

sh $dirsh'merge_scan.sh' $2 $1

sh $dirsh'dados.sh' $2 $1

#gcc $dirsh'lc.c' -o lc

#./$dirsh'lc'

