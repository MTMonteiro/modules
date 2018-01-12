#!/bin/bash 
#20171004
#
#SCIFI@O-MATIC
#Matheus Monteiro
#
#SET PLATFORM 
#
#set -xv

#for platform ar71xx
grep "$1" ./modelo_ar71xx.txt &> /dev/null

if [ $? -eq 0 ]; then    
      exit 1
fi

#for platform ramips/mt7620
grep "$1" ./modelo_rampis_7620.txt &> /dev/null
 
if [ $? -eq 0 ]; then
      exit 2 
fi


