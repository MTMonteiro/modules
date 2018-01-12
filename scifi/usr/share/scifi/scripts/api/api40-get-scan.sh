#!/bin/sh
# version 20160303
# Central script for SCIFI-API
#
# Luiz Magalhaes
# schara (at) telecom.uff.br
# Cosme Corr..a
# cosmefc@id.uff.br
# Helio Cunha
# helioncneto@gmail.com
# uncomment for debug
#set -xv


if [ -e "/tmp/scan.cnt" ]; then
                inicio=`cat /tmp/scan.cnt`
                fim=0
                let "fim=inicio+16"
                max=`cat /tmp/scan.mcqe | wc -l`
                if [ $max -gt $fim ]; then
                       head -n $fim /tmp/scan.mcqe | tail -n 16
                       echo $fim > /tmp/scan.cnt
                       else
                            resto=0
                            let "resto=max+16-fim"
                            tail -n $resto /tmp/scan.mcqe
                            echo 0 > /tmp/scan.cnt
                       fi
        fi

