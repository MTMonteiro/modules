#!/bin/ash
#
# matheus monteiro
#
#

dv=`./api04-device.sh`
echo "device= $dv"

users=`./api08-users.sh`
echo "users= $users"

up=`./api10-uptime.sh`
echo "uptime= $up"

ch=`./api30-channel.sh`
echo "channel= $ch"

rx=`./api22-data_rx.sh`
echo "RX= $rx"

tx=`./api23-data_tx.sh`
echo "TX= $tx"

mac=`./api35-macs.sh`
echo "macs=
$mac"

