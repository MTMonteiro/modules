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


 if [ -e "/tmp/scan5.cnt" ]; then
                inicio=`cat /tmp/scan5.cnt`
                fim=0
                let "fim=inicio+16"
                max=`cat /tmp/scan5.mcqe | wc -l`
                if [ $max -gt $fim ]; then
                        head -n $fim /tmp/scan5.mcqe | tail -n 16
                        echo $fim > /tmp/scan5.cnt
                        else
                        resto=0
                        let "resto=max+16-fim"
                        tail -n $resto /tmp/scan5.mcqe
                        echo 0 > /tmp/scan5.cnt
                        fi
        fi

