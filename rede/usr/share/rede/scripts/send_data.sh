#!/bin/sh
# 20180414
# matheus monteiro
# matheusmonteiroalves@id.uff.br
#
#set -xv
#number of archives
lines=`ls /tmp/ | grep dt | wc -l`

line=0
while [ "$line" -lt "$lines" ]; do
        archive=`ls /tmp/ | grep dt | awk -v line=$line 'NR == line {print$0}'`

        time=`grep time= /tmp/$archive | awk -F\= '{print $2 ; }'`
        mac=`grep mac= /tmp/$archive | awk -F\= '{print $2 ; }'`
        userst=`grep userst= /tmp/$archive | awk -F\= '{print $2 ; }'`
        site=`grep site= /tmp/$archive | awk -F\= '{print $2 ; }'`
        ip=`grep ip= /tmp/$archive | awk -F\= '{print $2 ; }'`
        wanrx=`grep wanrx= /tmp/$archive | awk -F\= '{print $2 ; }'`
        wantx=`grep wantx= /tmp/$archive | awk -F\= '{print $2 ; }'`

        senddata=`curl -u 1:Quetzalcoatl -d "ac=data&time=$time&mac=$mac&userst=$userst&site=$site&ip=$ip&wanrx=$Wrx&wantx=$Wtx" -X POST https://rede.zone/transf/analyzer.php
        echo $?
        if [ $? -eq 0 ];then
                rm /tmp/$archive
        fi
        line=$(( line + 1 ))

done

#senddata=`curl -u 1:Quetzalcoatl -d "ac=data&time=$time&mac=$mac&userst=$userst&users1=$users1&users2=$users2&users3=$users3&site=$site&ip=$ip&uptime=$up&channel=$ch&rede_rx=$Rrx&rede_tx=$Rtx&ssid_dominio=$ssidd&disabled_dominio=$stt&ssid2_rx=$Drx&ssid2_tx=$Dtx&ssid_info=$ssidi&location=$local&ip_ex=$ip_ex&memory=$memory&disk=$disk" -X POST http://rede.zone/transf/analyzer.php`

