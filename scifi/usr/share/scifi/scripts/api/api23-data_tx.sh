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


ifconfig wlan0 | grep "TX bytes" | awk -F ":" '{print $3}' | awk '{print $1}'

