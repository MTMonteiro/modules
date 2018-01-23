#!/bin/bash
#20171004
#
#SCIFI@O-MATIC
#Matheus Monteiro
#
#script de instalaçao scifi o-matic
#set -xv

############################################### 
# 1-ADICIONANDO ARQUIVOS E PACOTES ESSENCIAIS #
###############################################  
#apt-get install subversion build-essential libncurses5-dev zlib1g-dev gawk git ccache gettext libssl-dev xsltproc wget #1> /dev/null 2> /dev/stdout

#yum install subversion git gawk gettext ncurses-devel zlib-devel openssl-devel libxslt wget perl-Thread-Queue zlib-static libstdc++-devel gcc-c++ 

#criando diretorios 
if [ -d "/opt/scifi-o-matic/" ]; then
    echo "modules find" 
 else
  mkdir /opt/scifi-o-matic/
  
 fi

cd /opt/scifi-o-matic

#ADICIONANDO API E CONFIGURAÇÕES
 if [ -d "/opt/scifi-o-matic/modules" ]; then
    rm -rf /opt/scifi-o-matic/modules
    echo "modules econtrado e excluido"
    git clone https://github.com/MTMonteiro/modules.git
 else
  
   git clone https://github.com/MTMonteiro/modules.git
 fi


#verificação da existência do image builder 
#ar71xx
  if [ -d "/opt/scifi-o-matic/OpenWrt-ImageBuilder-15.05.1-ar71xx-generic.Linux-x86_64" ];
  then
     echo "image builder ar71xx encontrado"

  else
     cd /opt/scifi-o-matic
     wget https://downloads.openwrt.org/chaos_calmer/15.05.1/ar71xx/generic/OpenWrt-ImageBuilder-15.05.1-ar71xx-generic.Linux-x86_64.tar.bz2
     tar xjf OpenWrt-ImageBuilder-15.05.1-ar71xx-generic.Linux-x86_64.tar.bz2 
     rm -rf OpenWrt-ImageBuilder-15.05.1-ar71xx-generic.Linux-x86_64.tar.bz2

    fi

#ramips/mt7620
 if [ -d "/opt/scifi-o-matic/lede-imagebuilder-17.01.4-ramips-mt7620.Linux-x86_64" ];
  then
     echo "image builder ramips/mt7620 encontrado"
  else
     cd /opt/scifi-o-matic
     wget https://downloads.openwrt.org/releases/17.01.4/targets/ramips/mt7620/lede-imagebuilder-17.01.4-ramips-mt7620.Linux-x86_64.tar.xz
     tar -xvf lede-imagebuilder-17.01.4-ramips-mt7620.Linux-x86_64.tar.xz 
     rm -rf lede-imagebuilder-17.01.4-ramips-mt7620.Linux-x86_64.tar.xz

 fi

#retirando o pacote wpad-mini

########
#ar71xx#
########

sed "s/wpad-mini//g" /opt/scifi-o-matic/OpenWrt-ImageBuilder-15.05.1-ar71xx-generic.Linux-x86_64/target/linux/ar71xx/Makefile 1> /dev/null 2> /dev/stdout


########
#ramips#
########

sed "s/wpad-mini//g" /opt/scifi-o-matic/lede-imagebuilder-17.01.4-ramips-mt7620.Linux-x86_64/target/linux/ramips/Makefile 1> /dev/null 2> /dev/stdout


#
chmod a+x /opt/scifi-o-matic/modules/make_image.sh
chmod a+x /opt/scifi-o-matic/modules/set_platform.sh

