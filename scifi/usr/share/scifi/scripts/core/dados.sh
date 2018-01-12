#!/bin/sh
 set -xv


if [ $# -lt 2 ]; then
	echo USAGE: ./dados.sh scan_directory AP_list
	echo 
	echo example: ./dados.sh scan blocod.txt
	echo
	exit 0
fi

macdir='mac_list/'
dt=$1'.g5'
listaaps=$2

# Contando o numero de APs e botando dentro de um aquivo.
cat $listaaps | wc -l  > $dt/numero-nome-APs.txt
cat $listaaps >> $dt/numero-nome-APs.txt


# criando matrix de interferencias

for d in `cat $listaaps`; do
	echo $d
	rm $dt/$d.aps
# o merge ja gerou o compactado (cpc)
#	awk -f scan.awk  $dt/scan_$d.txt   > $dt/$d.cpc
	for j in  `cat $listaaps`; do
		#rm $dt/$d$j.tmp
  		for i in `cat $macdir$j.mac`; do 
			echo $i
			grep $i $dt/$d.cpc >> $dt/$d$j.tmp
		done
		sed "y/:=\//   /" $dt/$d$j.tmp | awk -f condensa.awk >> $dt/$d.aps
		echo $j " 0">> $dt/$d.aps
		#rm $dt/$d$j.tmp
	done
done

rm $dt/matrix

for j in `cat $listaaps`; do
        for d in `cat $listaaps`; do
                grep -i $d $dt/$j.aps | awk '{printf ("%2d ", $2)}'  >> $dt/matrix
        done
        echo >> $dt/matrix
done

# criando lista de aps não eduroam

for d in `cat $listaaps`; do
	echo $d
	grep -v eduroam $dt/$d.cpc | grep -v VisitantesUFF | grep -v CadastroWifiUFF | grep -v ClubWifi | grep -v -i ap0 | awk '{print $2 " " $3 " " $4;}' | sed "y/:=\//   /" | awk -f normaliza.awk > $dt/$d.ext
	done


cp -rf $dt scan
