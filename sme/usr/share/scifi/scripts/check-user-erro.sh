# 1 - 3 medições de zero usuários 
# 2 - memória acima de 80% 
# 3 - CPU abaixo de 10% 
# 4 - não rodou o wifi na última hora 

if [ ` iw wlan0 station dump | wc -l ` -eq 0 ]; 
        then 
        case `cat /tmp/zero_users.txt` in 
                0) echo "1" > /tmp/zero_users.txt 
                ;; 
                1) echo "2" > /tmp/zero_users.txt 
                ;; 
                2) 
                echo "0" > /tmp/zero_users.txt 
                idle=`top -b -n 2 | grep idle | awk -F"%" '{ print $4}' | awk '{print $2}'| tail -n 2 | head -n 1` 
                if [ $idle -gt 89 ]; 
                        then 
                        memTotal=`grep "MemTotal" /proc/meminfo | awk '{print $2}' ` 
                        memFree=`grep "MemFree" /proc/meminfo | awk '{print $2}' ` 
                        let memTotal=memTotal/6 
                        if [ $memFree -lt $memTotal ]; 
                                then 
                                wifi 
                                echo "3" > /tmp/zero_users.txt 
                                sleep 3 
                                logread > /tmp/logread.txt 
                                logger 'SCIFI - watchdog reset wlan interfaces...' 
                        fi 
                fi 
                ;; 
                3) echo "4" > /tmp/zero_users.txt 
                ;; 
                4) echo "5" > /tmp/zero_users.txt 
                ;; 
                *) echo "0" > /tmp/zero_users.txt 
                ;; 
        esac 
        else 
        echo "0" > /tmp/zero_users.txt 
fi 

exit 0
