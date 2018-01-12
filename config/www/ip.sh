maceth0=$(ifconfig -a eth0|grep HWaddr|cut -c39-55)
ip=$(ifconfig br-lan| grep "inet addr:" | awk -F":" '{print $2}'| awk '{print $1}')
STATUS=$(awk '{print $1}' status.txt)

if [ $STATUS -lt 2 ];
        then
        STATUS1="3"
        STATUS2="1"
        else
        STATUS1="5"
        STATUS2="4"
fi

if [ `ifconfig br-lan | grep UP | awk '{print $1}'` = "UP" ];
        then echo $STATUS1 " " $ip " " $maceth0 > status.txt
        else echo $STATUS2 " " $ip " " $maceth0 > status.txt
fi

