#!/bin/sh
# set -xv

listaAPs=$1
listaChannel=$2

echo Lista APs $listaAPs lista canais $listaChannel


x=1
y=1

date

for d in `cat $listaAPs`; do

	for j in `cat $listaChannel`; do

		if [ $x = $y ]; then
			echo O canal do $d é $j
#			canal=`snmpget -v 2c -c public $d .1.3.6.1.4.1.2021.8.1.101.30 2> keep_channel.err | awk '{print $4;}'`

			grep "Channel:$j " scanpos.5/$d.cpc	> scanpos.5/$d.int




		#	err=`cat keep_channel.err`
#			if [ $err="" ]; then
#				echo "O canal atual é " $canal
#				if [ $canal -ne $j ]; then
#					echo canais diferentes, mudando para $j
#					ssh -i /usr/share/scifi/core/controller_key $d /usr/share/scifi/scripts/set_channel.sh $j 2> /dev/null
#				fi
#			else echo $err			fi
		fi


		let "y=y+1"
	done

	y=1
	let "x=x+1"
done
