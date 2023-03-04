#/bin/bash

bold='\e[1;'
strnd='\e[0;'
red='31m'
green='32m'
yell='33m'
tyblue='36m'
NC='\e[0m'
clear
echo -e "${strnd}${red}a"
cd /home
if [ -d "rdp_file" ]; then
 cd rdp_file
else
 echo -e "${strnd}${red}[${bold}${tyblue}*${strnd}${red]]${bold}${red} Can't find any image installed, please install software installer to download image!${NC}"
 exit 1
fi

 purple() { echo -e "\\033[35;1m${*}\\033[0m"; }
 tyblue() { echo -e "\\033[36;1m${*}\\033[0m"; }
 yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
 green() { echo -e "\\033[32;1m${*}\\033[0m"; }
 red() { echo -e "\\033[31;1m${*}\\033[0m"; }
 dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
 realtime=`date +"%d-%m-%Y-%T" -d "$dateFromServer"`

 if [ -f "freetrialdate.txt" ]; then
  freetrialdate=$(cat freetrialdate.txt)
 else
  freetrialdate="none"
 fi
 
 if [ "${realtime}" == "${freetrialdate}" ]; then
  echo -e "[ ${strnd}${red}License${strnd}${NC} ] ${strnd}${red}You're free trial has ended, please buy a license!${NC}" 
  exit 1
 fi
 if [ ! -f "dontasksavedconf" ]; then
  ./ngroksetup.sh
  sleep 2
 fi
 clear

 ngrokregion=$(cat ngrokregiontxt)

 if [ -f "freetrialdate.txt" ]; then
  echo -e "[ ${strnd}${red}License${NC} ] ${strnd}${yell}You're using trial version${NC},${strnd}${red} Please buy a license to use a full version${NC}"
 fi

 #echo $ngrokregion
 if [ -f "win2012.vhd" ]; then
  echo -e "[ ${strnd}${green}System${NC} ] Starting up your windows 2012..."
  qemu-system-x86_64 -hda win2012.vhd -m 58G -smp cores=2 -net user,hostfwd=tcp::3388-:3389 -net nic -object rng-random,id=rng0,filename=/dev/urandom -device virtio-rng-pci,rng=rng0 -vga vmware -nographic &>/dev/null &
 fi
