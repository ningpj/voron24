#!/bin/bash

# Location of klipper configuration
printer_config=~/printer_data/config

# Directory within your klipper configuration to hold a backup of the moonraker database
moonraker_backup=${printer_config}/.moonraker_database_backup/database.backup

##### WARNING #####
read -p "*** WARNING *** This will reset the local GIT repository and overwrite any uncomitted changes - press [Enter] to continue or Ctrl-C to abort"

# switch to the klipper config directory
cd ${printer_config}

git fetch origin
git reset --hard origin/master

if [ -f ${moonraker_backup} ]; then
  ls -alh $moonraker_backup
  read -p "*** WARNING *** The moonraker database will now be restored - press [Enter] to continue or Ctrl-C to abort"

  sudo systemctl stop moonraker
  cp ${moonraker_backup} ~/printer_data/database/moonraker-sql.db
  sudo systemctl start moonraker
fi
