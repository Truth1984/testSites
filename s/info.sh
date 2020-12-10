#!/bin/bash

echo -e "\n\n========================================= HOST INFO ==========================================\n" 
echo -e "\tHostname:\t"`hostname` 
 
echo -e "\n\n========================================== OS INFO ===========================================\n" 
echo -e "\tOS Info:\t"`cat /etc/system-release` 
 
echo -e "\n\n======================================== KERNEL INFO =========================================\n" 
echo -e "\tKernel Version:\t"`uname -r` 
 
echo -e "\n\n========================================= CPU INFO ===========================================\n" 
echo -e "\tTotal Processor:\t"`grep -c 'processor' /proc/cpuinfo` 
echo -e "\tCPU Processor Model:\t"`awk -F':' '/^model name/ { print $2 }' /proc/cpuinfo` 
echo -e "\tCPU Processor Speed:\t"`awk -F':' '/^cpu MHz/ { print $2 }' /proc/cpuinfo` 
echo -e "\tCPU Cache Size:\t"`awk -F':' '/^cache size/ { print $2 }' /proc/cpuinfo`  
 
echo -e "\n\n========================================== RAM INFO ==========================================\n" 
echo -e "\tMemory(RAM) Info:\t"`free -mht| awk '/Mem/{print " \tTotal: " $2 "\tUsed: " $3 "\tFree: " $4}'`  
echo -e "\tSwap Memory Info:\t"`free -mht| awk '/Swap/{print " \t\tTotal: " $2 "\tUsed: " $3 "\tFree: " $4}'` 
 
echo -e "\n\n========================================== IP INFO ===========================================\n" 
ifconfig 
 
echo -e "\n\n====================================== ROUTE TABLE INFO ======================================\n" 
route -n 
 
echo -e "\n\n====================================== MOUNT POINT INFO ======================================\n" 
cat /etc/fstab|grep -v "#" 
 
echo -e "\n\n==================================== DISK PARTATION INFO =====================================\n" 
df -h 
 
echo -e "\n\n==================================== PHYSICAL VOLUME INFO ====================================\n" 
pvs 
 
echo -e "\n\n===================================== VOLUME GROUP INFO ======================================\n" 
vgs 
 
echo -e "\n\n===================================== LOGICAL VOLUME INFO ====================================\n" 
lvs 
 
echo -e "\n\n==================================== RUNNING SERVICE INFO ====================================\n" 
systemctl list-units | grep running|sort 
 
echo -e "\n\n==================================== TOTAL RUNNING SERVICE ===================================\n" 
echo -e "\tTotal Running service:\t"`systemctl list-units | grep running|sort| wc -l` 
 
echo -e "\n\n========================================= GRUB INFO ==========================================\n" 
cat /etc/default/grub 
 
echo -e "\n\n========================================= BOOT INFO ==========================================\n" 
ls -l /boot|grep -v total 
 
echo -e "\n\n====================================== ACTIVE USER INFO ======================================\n" 
echo -e "\tCurrent Active User:\t"`w | cut -d ' ' -f 1 | grep -v USER | sort -u` 

echo -e "\n\n======================================= DOCKER INFO ==========================================\n" 
if [ -x "$(command -v docker)" ]; then echo -e "`docker ps`"; fi;