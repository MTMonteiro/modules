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
# matheus monteiro
# uncomment for debug
#set -xv

# this version for APs only
        nsta=0;for i in `ifconfig | grep wlan0 | awk '{print $1}'`; do let nsta=$nsta+`iw $i station dump | grep -c Station`;done; echo $nsta > /tmp/nsta.txt; echo $nsta;

