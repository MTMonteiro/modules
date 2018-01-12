#!/bin/sh
# version 20160312
#
# Script for getting channel informatio via http and setting the channel
#
# Luiz Magalhaes
# schara (at) telecom.uff.br
# uncomment for debug
#set -xv

cd /tmp

nome=`cat /etc/config/network |grep hostname|awk -F "'" '{print $2}'`

if [ -e /tmp/canal.txt ]; then rm /tmp/canal.txt; fi

wget http://www.wifi.uff.br/scifi/aps/$nome/canal.txt

canal=`cat /tmp/canal.txt`

canalatual=`uci get wireless.radio0.channel`

if [ $canal -ne $canalatual ]; then

        case "$canal" in

        1) /usr/share/scifi/scripts/set_channel.sh 1
        ;;

        6) /usr/share/scifi/scripts/set_channel.sh 6
        ;;

        11) /usr/share/scifi/scripts/set_channel.sh 11
        ;;

        *) echo "invalid channel $canal"
        logger "invalid channel $canal"
        ;;

        esac

fi

