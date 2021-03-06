if [ `awk  '{if ($1=="PING_ENABLE") print $2;}' /etc/scifi/scifi.conf` -eq "1" ]; then
   DG=`route -n | grep UG | cut -c15-30`
        ping -q -w 200 -c $DG > /tmp/ping.txt
        grep transmitted /tmp/ping.txt |  awk '{a=$1;b=$4; c=a-b; print c;}' > /tmp/loss.txt
        grep avg /tmp/ping.txt | awk -F "/" '{print $4}' > /tmp/delay.txt
else
        echo "-1" > /tmp/loss.txt
        echo "-1" > /tmp/delay.txt
fi
