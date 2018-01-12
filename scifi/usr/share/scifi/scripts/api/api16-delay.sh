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


if [ -e "/tmp/delay.txt" ]; then cat /tmp/delay.txt; else echo "0"; fi

