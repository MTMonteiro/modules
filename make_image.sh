#!/bin/bash
#20171004
#
#SCIFI@O-MATIC
#Matheus Monteiro
#
# script for generate images openwrt 
#set -xv
#
shopt -s extglob

#PARAMETERIZATION
#image_builder_ar71xx
builder1="OpenWrt-ImageBuilder-15.05.1-ar71xx-generic.Linux-x86_64"

#image_builder_rampis_7620
builder2="lede-imagebuilder-17.01.4-ramips-mt7620.Linux-x86_64"

#indicative of error
usage() 
{
cat <<EOF
$0

SET THE PARAMETERS!

    $0 sm  - show modules   
    $0 sp  - show profiles 
    $0 spp - show profiles details

    generate an image:
    $0 profile packages
  
    to generate image with scifi:
    $0 profile "packages" scifi version_ap

    to generate image for wifi-uff:
    $0 profile "packages" uff version_ap

    to generate image config:
    $0 profile config version_ap

Usage:    $0	

Example1: $0 TLWR740 "procd snmp-utils snmpd-static swconfig uboot-envtools ubox ubus ubusd uhttpd usign wireless-tools wpa-cli wpad"	v4
									
Example2: $0 ArcheC20i "openwrt" scifi v1
	
Example3: $0 TLWR740 "minimum" uff v2

Return codes:
	0 - ok
	1 - missing Parameter
	2 - profile does not exist

EOF
exit $1
}



#empty parameter
 [ -z $1 ] && usage 1
  
#checking if the first parameter is expected
 grep "$1" ./modelo_ar71xx.txt || grep "$1" ./modelo_rampis_7620.txt &> /dev/null 

 if [ $? -ne 0 ] && [ "$1" != "sm" ] && [ "$1" != "sp" ] && [ "$1" != "spp" ]; then
   echo "
 profile does not exist"
   echo "
 make_image.sh sp - show profiles
"
   usage 2
 fi


#Exibir modelos disponiveis de ap

  if [ $1 == "spp" ]; then 
        cd ./$builder1
        make info
        cd ..
        cd ./$builder2
        make info
        cd ..
        exit
  fi

 if [ $1 == "sp" ]; then 
        cat ./modelo_ar71xx.txt
        cat ./modelo_rampis_7620.txt 
        exit
 fi

#show modules
   if [ $1 == "sm" ]; then 
       echo " MODULES:
minimum
openwrt"
       exit
   fi 
  

#REPLACEMENT NAME OF THE MODULE BY THE PACKAGES
 MOD=$2   
 
   min="hostapd-common iw jshn jsonfilter kernel kmod-ath kmod-ath9k kmod-ath9k-common kmod-cfg80211 kmod-crypto-aes kmod-crypto-arc4 kmod-crypto-core kmod-dnsresolver kmod-fs-nfs kmod-fs-nfs-common kmod-gpio-button-hotplug kmod-mac80211 libblkid libblobmsg-json libevent libjson-c libjson-script libnetsnmp libnl-tiny libpthread librpc librt libubox libubus libuci libuuid libwrap netcat nfs-utils procd snmp-utils snmpd-static swconfig uboot-envtools ubox ubus ubusd uhttpd usign wireless-tools wpa-cli"
   PACKAGES1=${MOD/minimum/$min}  2> /dev/null

   wrt="base-files busybox dnsmasq dropbear firewall iptables iw jshn kernel kmod-ath kmod-ath9k kmod-ath9k-common kmod-cfg80211 kmod-crypto-aes kmod-crypto-arc4 kmod-crypto-core kmod-gpio-button-hotplug kmod-ipt-conntrack kmod-ipt-core kmod-ipt-nat kmod-leds-gpio kmod-ledtrig-default-on kmod-ledtrig-netdev kmod-ledtrig-timer kmod-ledtrig-usbdev kmod-lib-crc-ccitt kmod-mac80211 kmod-nls-base kmod-ppp kmod-pppoe kmod-pppox kmod-usb-core kmod-usb-ohci kmod-usb2 libblobmsg-json libc libgcc libip4tc libiwinfo libiwinfo-lua liblua libnl-tiny libubox libubus libubus-lua libuci libuci-lua libxtables lua luci luci-app-firewall luci-lib-nixio luci-mod-admin-full luci-proto-ppp luci-theme-openwrt mtd netifd opkg ppp ppp-mod-pppoe swconfig uboot-envtools ubus ubusd uci uhttpd wireless-tools wpad-mini "
   PACKAGES=${PACKAGES1/openwrt/$wrt} 

2> /dev/null
 

#GENERATE IMAGE

time=`date +"%Y-%m-%d_%H-%M-%S"`

#checking the profile platform
chmod a+x set_platform.sh #RETIRAR INTRODUZIDO NA INSTALAÇAO
./set_platform.sh $1
 plt=$?


########
#AR71XX#
########
 if [ $plt -eq 1 ]; then
   
    cp -r ./$builder1 /tmp
   
#case generate image config
  if [ "$2" == "config" ]; then 

    cp -f ./target_config.mk /tmp/$builder1/include/target.mk
    sed s/SPPH/"$PACKAGES"/g ./target_base.mk > /tmp/$builder1/include/target.mk
    cp -r ./config /tmp/$builder1/config2
    cd /tmp/$builder1
    echo "$1-$4" > /tmp/$builder1/config2/www/device.txt

    make image PROFILE=$1 FILES=config2 \
           BIN_DIR=/tmp/openwrt/$time
           echo -e "voce gerou a imagem config para $1, localizada no diretorio: /tmp/openwrt/$time"
           chmod 777 /tmp/openwrt/$time           
           rm -rf /tmp/$builder1
        if [ -z != $4 ]; then
               cd /tmp/openwrt/$time
               ls *.bin | grep -i $4 

            if [ $? == 0 ]; then        
                  rm !(*$4*)
  
               else 
                 echo "versão especificada não encontrada, verifique as versões disponiveis que foram geradas."    
            fi
         fi
           exit
  fi


#uff parameter
     if [ "$3" == "uff" ]; then
           cp -r ./wifi-uff /tmp/$builder1/.
           sed s/SPPH/"$PACKAGES"/g ./target_uff.mk > /tmp/$builder1/include/target.mk
           cd /tmp/$builder1
           make image PROFILE=$1 FILES=wifi-uff \
           BIN_DIR=/tmp/openwrt/$time
           echo -e "voce gerou a imagem para $1, localizada no diretorio: /tmp/openwrt/$time "
           chmod 777 /tmp/openwrt/$time           
           rm -rf /tmp/$builder1
           if [ -z != $4 ]; then
               cd /tmp/openwrt/$time
               ls *.bin | grep -i $4 

               if [ $? == 0 ]; then        
                 rm !(*$4*)
  
              else 
                echo "versão especificada não encontrada, verifique as versões disponiveis que foram geradas."    
               fi
           fi
           exit
     fi

#scifi parameter
      if [ "$3" == "scifi" ]; then          
           cd ./scifi
           chmod a+x install.sh
           ./install.sh /tmp/$builder1
           sed s/SPPH/"$PACKAGES"/g ./target_scifi.mk > /tmp/$builder1/include/target.mk
           cd /tmp/$builder1
           make image PROFILE=$1 FILES=scifi \
           BIN_DIR=/tmp/openwrt/$time
           echo -e "voce gerou a imagem para $1, localizada no diretorio: /tmp/openwrt/$time " 
           chmod 777 /tmp/openwrt/$time
           rm -rf /tmp/$builder1
           if [ -z != $4 ]; then
               cd /tmp/openwrt/$time
               ls *.bin | grep -i $4 

               if [ $? == 0 ]; then        
                 rm !(*$4*)
  
              else 
                echo "versão especificada não encontrada, verifique as versões disponiveis que foram geradas."    
               fi
           fi
           exit
       fi

#empty parameter
     sed s/SPPH/"$PACKAGES"/g ./target_base.mk > /tmp/$builder1/include/target.mk
     cd /tmp/$builder1
     make image PROFILE=$1 BIN_DIR=/tmp/openwrt/$time 
     echo -e "voce gerou a imagem para $1, localizada no diretorio: /tmp/openwrt/$time " 
     chmod 777 /tmp/openwrt/$time
     rm -rf /tmp/$builder1

     if [ -z != $4 ]; then
        cd /tmp/openwrt/$time
        ls *.bin | grep -i $4 

        if [ $? == 0 ]; then        
           rm !(*$4*)
  
        else 
           echo "versão especificada não encontrada, verifique as versões disponiveis que foram geradas."    
        fi
     fi
     exit
 fi


###############
#ramips/mt7620#
###############

if [ $plt -eq 2 ]; then

  cp -r ./$builder2 /tmp

#config parameter 
if [ "$2" == "config" ]; then 
  sed s/SPPH/"$PACKAGES"/g ./target_uff.mk > /tmp/$builder1/include/target.mk
  cp -r ./config /tmp/$builder2/.
  cd /tmp/$builder2

   make image PROFILE=$1 FILES=config \
   BIN_DIR=/tmp/openwrt/$time
   echo -e "voce gerou a imagem config para $1, localizada no diretorio: /tmp/openwrt/$time"
   chmod 777 /tmp/openwrt/$time           
   rm -rf /tmp/$builder2
        if [ -z != $4 ]; then
              cd /tmp/openwrt/$time
              ls *.bin | grep -i $4 

           if [ $? == 0 ]; then        
               rm !(*$4*)
  
  else 
               echo "versão especificada não encontrada, verifique as versões disponiveis que foram geradas."    
           fi
  fi
           exit
fi



#uff parameter
   if [ "$3" == "uff" ]; then   
           sed s/SPPH/"$PACKAGES"/g ./target_uff.mk > /tmp/$builder2/include/target.mk                   
           cp -r ./wifi-uff /tmp/$builder2/.
           cd /tmp/$builder2
           make image PROFILE=$1 FILES=wifi-uff \
           BIN_DIR=/tmp/openwrt/$time
           echo -e "voce gerou a imagem para $1, localizada no diretorio: /tmp/openwrt/$time "
           chmod 777 /tmp/openwrt/$time
           rm -rf /tmp/$builder2
           if [ -z != $4 ]; then
               cd /tmp/openwrt/$time
               ls *.bin | grep -i $4 

               if [ $? == 0 ]; then        
                 rm !(*$4*)
  
               else 
                 echo "versão especificada não encontrada, verifique as versões disponiveis que foram geradas."    
               fi
            fi
           exit
   fi


#scifi parameter 
      if [ "$3" == "scifi" ]; then
           sed s/SPPH/"$PACKAGES"/g ./target_scifi.mk > /tmp/$builder2/include/target.mk
           cp -r ./scifi /tmp/$builder2
           cd /tmp/$builder2
           make image PROFILE=$1 FILES=scifi \
           BIN_DIR=/tmp/openwrt/$time
           echo -e "voce gerou a imagem para $1, localizada no diretorio: /tmp/openwrt/$time "
           chmod 777 /tmp/openwrt/$time
           rm -rf /tmp/$builder2
           if [ -z != $4 ]; then
               cd /tmp/openwrt/$time
               ls *.bin | grep -i $4 

               if [ $? == 0 ]; then        
                 rm !(*$4*)
  
              else 
                echo "versão especificada não encontrada, verifique as versões disponiveis que foram geradas."    
               fi
            fi
           exit
       fi

       

#empty parameter
         sed s/SPPH/"$PACKAGES"/g ./target_base.mk > /tmp/$builder2/include/target.mk
         cd /tmp/$builder2
         make image PROFILE=$1 BIN_DIR=/tmp/openwrt/$time        
         echo -e "voce gerou a imagem para $1, localizada no diretorio: /tmp/openwrt/$time "
         chmod 777 /tmp/openwrt/$time 
         rm -rf /tmp/$builder2 
         if [ -z != $4 ]; then
               cd /tmp/openwrt/$time
               ls *.bin | grep -i $4 

               if [ $? == 0 ]; then        
                 rm !(*$4*)
  
              else 
                echo "versão especificada não encontrada, verifique as versões disponiveis que foram geradas."    
               fi
           fi
      fi
fi
