#!/bin/bash

export $(grep -v '^#' ~/printer_data/.mygittoken | xargs -0)

#####################################################################
### Please set the paths accordingly. In case you don't have all  ###
### the listed folders, just keep that line commented out.        ###
#####################################################################
### Path to config folder you want to backup
config_folder=~/printer_data/config

### Path to Klipper folder, by default that is '~/klipper'
klipper_folder=~/klipper

### Path to Moonraker folder, by default that is '~/moonraker'
moonraker_folder=~/moonraker

### Path to Mainsail folder, by default that is '~/mainsail'
#mainsail_folder=~/mainsail

### Path to Fluidd folder, by default that is '~/fluidd'
fluidd_folder=~/fluidd

#####################################################################
#####################################################################


grab_version(){
  if [ ! -z "$klipper_folder" ]; then
    echo -n "Getting klipper version="
    cd "$klipper_folder"
    klipper_commit=$(git rev-parse --short=7 HEAD)
    m1="Klipper on commit: $klipper_commit"
    echo $klipper_commit
    cd ..
  fi
  if [ ! -z "$moonraker_folder" ]; then
    echo -n "Getting moonraker version="
    cd "$moonraker_folder"
    moonraker_commit=$(git rev-parse --short=7 HEAD)
    m2="Moonraker on commit: $moonraker_commit"
    echo $moonraker_commit
    cd ..
  fi
  if [ ! -z "$mainsail_folder" ]; then
    echo -n "Getting mainsail version="
    mainsail_ver=$(head -n 1 $mainsail_folder/.version)
    m3="Mainsail version: $mainsail_ver"
    echo $mainsail_ver
  fi
  if [ ! -z "$fluidd_folder" ]; then
    echo -n "Getting fluidd version="
    fluidd_ver=$(head -n 1 $fluidd_folder/.version)
    m4="Fluidd version: $fluidd_ver"
    echo $fluidd_ver
  fi
}

push_config(){
  cd $config_folder

  echo Creating backup copy of moonraker database
  ~/moonraker/scripts/backup-database.sh -o ~/printer_data/config/.moonraker_database_backup/moonraker_db_backup
  #cp ~/.moonraker_database/data.mdb .moonraker_database_backup

  echo Pushing updates
  git pull -v "https://nigelpjames:$mygittoken@github.com/nigelpjames/voronred300.git"
  git add . -v
  current_date=$(date +"%Y-%m-%d %T")
  git commit -m "Backup triggered on $current_date" -m "$m1" -m "$m2" -m "$m2a" -m "$m3" -m "$m4"
  git push "https://nigelpjames:$mygittoken@github.com/nigelpjames/voronred300.git"
}

grab_version
push_config
