#!/bin/bash
# bash <(curl -s https://truth1984.github.io/testSites/s/info.sh)
printf "\n\n========================================= HOST INFO ==========================================\n" 
printf "\tHostname:\t"`hostname` 
 
printf "\n\n========================================== OS INFO ===========================================\n" 
printf "\tOS Info:\t"`cat /etc/system-release` 
 
printf "\n\n======================================== KERNEL INFO =========================================\n" 
printf "\tKernel Version:\t"`uname -r` 
 
printf "\n\n========================================= CPU INFO ===========================================\n" 
printf "\tTotal Processor:\t"`grep -c 'processor' /proc/cpuinfo` 
printf "\tCPU Processor Model:\t"`awk -F':' '/^model name/ { print $2 }' /proc/cpuinfo` 
printf "\tCPU Processor Speed:\t"`awk -F':' '/^cpu MHz/ { print $2 }' /proc/cpuinfo` 
printf "\tCPU Cache Size:\t"`awk -F':' '/^cache size/ { print $2 }' /proc/cpuinfo`  
 
printf "\n\n========================================== RAM INFO ==========================================\n" 
printf "\tMemory(RAM) Info:\t"`free -mht| awk '/Mem/{print " \tTotal: " $2 "\tUsed: " $3 "\tFree: " $4}'`  
printf "\tSwap Memory Info:\t"`free -mht| awk '/Swap/{print " \t\tTotal: " $2 "\tUsed: " $3 "\tFree: " $4}'` 
 
printf "\n\n========================================== IP INFO ===========================================\n" 
ifconfig 
 
printf "\n\n====================================== ROUTE TABLE INFO ======================================\n" 
route -n 
 
printf "\n\n====================================== MOUNT POINT INFO ======================================\n" 
cat /etc/fstab|grep -v "#" 
 
printf "\n\n==================================== DISK PARTATION INFO =====================================\n" 
df -h 
 
printf "\n\n==================================== PHYSICAL VOLUME INFO ====================================\n" 
pvs 
 
printf "\n\n===================================== VOLUME GROUP INFO ======================================\n" 
vgs 
 
printf "\n\n===================================== LOGICAL VOLUME INFO ====================================\n" 
lvs 
 
printf "\n\n==================================== RUNNING SERVICE INFO ====================================\n" 
systemctl list-units | grep running|sort 
 
printf "\n\n==================================== TOTAL RUNNING SERVICE ===================================\n" 
printf "\tTotal Running service:\t"`systemctl list-units | grep running|sort| wc -l` 
 
printf "\n\n========================================= GRUB INFO ==========================================\n" 
cat /etc/default/grub 
 
printf "\n\n========================================= BOOT INFO ==========================================\n" 
ls -l /boot|grep -v total 
 
printf "\n\n====================================== ACTIVE USER INFO ======================================\n" 
printf "\tCurrent Active User:\t"`w | cut -d ' ' -f 1 | grep -v USER | sort -u` 

printf "\n\n======================================= DOCKER INFO ==========================================\n" 
if [ -x "$(command -v docker)" ]; then printf "`docker ps`"; fi;