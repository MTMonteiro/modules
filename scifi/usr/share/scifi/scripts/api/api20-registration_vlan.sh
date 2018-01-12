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



if [ "`awk  '{if ($1=="SEGMENT") print $2;}' /etc/scifi/scifi.conf`" == "SC" ]; then
        if [ -e "/tmp/wifi1_status.txt" ]; then cat /tmp/wifi1_status.txt; else echo "-1"; fi
else
        if [ -e "/tmp/statuswlan0-1" ]; then cat /tmp/statuswlan0-1; else echo "-1"; fi
fi

