#!/bin/sh
# version 20171106
# Central script for SCIFI-API
#
# Luiz Magalhaes
# schara (at) telecom.uff.br
# Cosme Correa
# cosmefc@gmail.com
# Helio Cunha
# helioncneto@gmail.com
# uncomment for debug
#set -xv

awk -v search=ID '{if ($1==search) print $2;}' /etc/scifi/scifi.conf
