#!/bin/bash

# exit on any error
set -e

# Set these based on your env
rp_mcu=~/printer_data/config/scripts/config.rp_mcu
spider_mcu=~/printer_data/config/scripts/config.spider_mcu
sht36_mcu=~/printer_data/config/scripts/config.sht36v2
#sht36_can=d10a59dcf8cc
sht36_can=333f11f63709
ercf_mcu=~/printer_data/config/scripts/config.ercfcanv1.1
ercf_can=0cf6c395541c
usb_mcu=/dev/serial/by-id/usb-Klipper_stm32f446xx_26001F000B50563046363120-if00


# Targets
mcu=0
rp=0
flash=0
sht36=0
ercf=0

for ARG in $@; do
   case $ARG in

     "--sht36")
       sht36=1
     ;;
     "--ercf")
       ercf=1
     ;;
     "--mcu")
       mcu=1
     ;;
     "--rp")
       rp=1
     ;;
     "--all")
       rp=1
       mcu=1
       ercf=1
       sht36=1
     ;;
     "--flash")
       flash=1
     ;;
     *)
       echo "$0 Error. Invalid argument [$ARG]. Options include --all, --mcu, --rp, --flash, --ercf, --sht36"
       exit 9
     ;;
   esac
done

if [ $mcu = 0 ] && [ $rp = 0 ] && [ $ercf = 0 ] && [ $sht36 = 0 ]; then
  echo Nothing to do, exiting.
  exit 0
fi

if [ $flash = 1 ]; then
  read -p "*** WARNING *** MCU's will be updated and flashed!!! - Press [Enter] to continue, Ctrl-C to abort"
  echo Stopping Klipper ...
  sudo service klipper stop
else
  read -p "NOTE - MCU's will NOT be updated and flashed - Press [Enter] to continue, Ctrl-C to abort"
fi

cd ~/klipper

if [ $sht36 = 1 ]; then
  echo "Compiling Klipper for Fly SHT-36 V2 CAN Board"

  echo Using make override [${sht36_mcu}]
  make clean KCONFIG_CONFIG=${sht36_mcu}
  make menuconfig KCONFIG_CONFIG=${sht36_mcu}
  make KCONFIG_CONFIG=${sht36_mcu} -j4

  read -p "Review errors and press [Enter] to continue, Ctrl-C to abort"

  if [ $flash = 1 ]; then
    echo "Flashing Klipper to Fly SHT-36 V2 CAN Board"
    python3 ~/katapult/scripts/flash_can.py -i can0 -f ~/klipper/out/klipper.bin -u ${sht36_can}
    read -p "Fly SHT-36 V2 Can Board updated. Press [Enter] to continue or Ctrl-C to abort"
  else
    echo --flash not specified, flash step bypassed.
  fi
  echo
fi

if [ $ercf = 1 ]; then
  echo "Compiling Klipper for Fly ERCF V1.1 CAN Board"

  echo Using make override [${ercf_mcu}]
  make clean KCONFIG_CONFIG=${ercf_mcu}
  make menuconfig KCONFIG_CONFIG=${ercf_mcu}
  make KCONFIG_CONFIG=${ercf_mcu} -j4

  read -p "Review errors and press [Enter] to continue, Ctrl-C to abort"

  if [ $flash = 1 ]; then
    echo "Flashing Klipper to Fly ERCF V1.1 CAN Board"
    python3 ~/katapult/scripts/flash_can.py -i can0 -f ~/klipper/out/klipper.bin -u ${ercf_can}
    read -p "Fly ERCF V1.1 CAN Board updated. Press [Enter] to continue or Ctrl-C to abort"
  else
    echo --flash not specified, flash step bypassed.
  fi
  echo
fi

if [ $rp = 1 ]; then
 
  echo "Compiling Klipper for RP MCU [Input Shaper]"

  echo Using make override [${rp_mcu}]
  make clean KCONFIG_CONFIG=${rp_mcu}
  make menuconfig KCONFIG_CONFIG=${rp_mcu}
  make KCONFIG_CONFIG=${rp_mcu}
  read -p "Review errors and press [Enter] to continue, Ctrl-C to abort"

  if [ $flash = 1 ]; then
    echo "Flashing Klipper to RP MCU [Input Shaper]"
    make flash KCONFIG_CONFIG=${rp_mcu}
    read -p "RP MCU [Input Shaper] updated. Press [Enter] to continue or Ctrl-C to abort"
  else
    echo --flash not specified, flash step bypassed.
  fi
  echo 
fi

if [ $mcu = 1 ]; then
  echo "Compiling Klipper for Spider MCU"

  echo Using make override [${spider_mcu}] to flash ${usb_mcu}
  make clean KCONFIG_CONFIG=${spider_mcu}
  make menuconfig KCONFIG_CONFIG=${spider_mcu}
  make KCONFIG_CONFIG=${spider_mcu}

  if [ $flash = 1 ]; then
    read -p "Review errors and press [Enter] to continue or Ctrl-C to abort"
    echo "Flashing Klipper for Spider MCU"
    make flash KCONFIG_CONFIG=${spider_mcu} FLASH_DEVICE=${usb_mcu} 
    read -p "Spider MCU updated. Press [Enter] to continue or Ctrl-C to abort"
  else
    echo --flash not specified, flash step bypassed.
  fi
  echo 
fi

if [ $flash = 1 ]; then
  echo Starting Klipper ...
  sudo service klipper start 
fi
