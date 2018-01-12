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


if [ -f "/tmp/scifi-neighborhood.txt" ];
                then
                 cat /tmp/scifi-neighborhood.txt
                else
                 echo "0"
                fi

