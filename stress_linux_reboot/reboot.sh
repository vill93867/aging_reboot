#!/bin/bash

#get the folder path
cur_dir=$(cd `dirname $0`;pwd)
cd $cur_dir

#get rows of count.txt(it stand for loops of reboot)
line=$(cat count.txt  | wc -l)

#get devicesinfo
sleep 5
#lsblk | grep disk > after.txt
lsblk | grep disk | wc -l  > after.txt
lspci >> after.txt
#lsusb >> after.txt
lsusb |sed 's/....................//' >> after.txt

file=`diff before.txt after.txt`
if [ $file=" " ]
then echo "`date` Devices check PASS  Reboot loop:$line" >> count.txt
else
echo "`date` Devices check FAIL  Reboot loop:$line" >> count.txt
echo "Device check Fail         $file   " >> fail.txt
fi
#record reboot time & loop information
#echo "`date`          Reboot loop:$line" >> count.txt

#show reboot time & loop information
tail -n 1 count.txt
echo Please wait 60s to reboot
sleep 60
reboot
