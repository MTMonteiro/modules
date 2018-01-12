export PATH=/bin:/sbin:/usr/bin:/usr/sbin;
logger 'SCIFI - getting channel 2.4ghz number'
uci show wireless |grep radio0 |grep channel | awk -F= '{print $2}'| sed "s/'//"| sed "s/'//"
