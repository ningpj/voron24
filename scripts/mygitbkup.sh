#!/bin/bash
set -x

export $(grep -v '^#' ~/printer_data/.mygittoken | xargs -0)

gitrepos=(~/klipper ~/moonraker ~/mainsail ~/fluidd ~/ERCF-Software-V3 ~/KlipperScreen)
printer_config=~/printer_data/config
moonraker_backup=${printer_config}/.moonraker_database_backup/moonraker_db_backup

for repo in "${gitrepos[@]}"; do
   trimedRepo="$(basename ${repo})"
   if [ -d ${repo} ]; then
      if [ -e ${repo}/.version ]; then
         rev="${trimedRepo} on commit: $(head -n 1 ${repo}/.version)"
      else
         rev="${trimedRepo} on commit: $(git -C ${repo} tag -l | tail -1) $(git -C ${repo} rev-parse --short=7 HEAD)"
      fi
      gitrevs+=("-m \"${rev}\"")
      echo $rev
   fi
done

cd ${printer_config}

echo Backing moonraker database
~/moonraker/scripts/backup-database.sh -o ${moonraker_backup}

echo Pushing updates
git pull -v "https://nigelpjames:$mygittoken@github.com/nigelpjames/voronred300.git"
git add . -v
current_date=$(date +"%Y-%m-%d %T")
eval echo $gitrevs[@]
git commit -m "Backup triggered on $current_date" "${gitrevs[@]}"
git push "https://nigelpjames:$mygittoken@github.com/nigelpjames/voronred300.git"
