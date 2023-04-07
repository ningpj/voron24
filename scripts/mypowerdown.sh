#!/bin/bash

/usr/bin/curl --netrc-file /home/pi/printer_data/.myIOTpwd "http://192.168.2.25/cm?cmnd=Backlog%3BDelay%20100%3BPower%20Off"
