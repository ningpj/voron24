#!/bin/bash

delay=100
log=~/printer_data/logs/klippy.log
tasmota_device=192.168.2.25

echo Issuing ${delay}ds delayed Tasmota power off for `hostname` | tee -a ${log}
/usr/bin/curl --netrc-file /home/pi/printer_data/.myIOTpwd "http://${tasmota_device}/cm?cmnd=Backlog%3BDelay%20$delay%3BPower%20Off" &>> ${log}
