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


wlist txpower 2> /dev/null | grep -m 1 wlan0 -A2 | grep Current | awk '{print $2}' | sed 's/Tx-Power=//g'

