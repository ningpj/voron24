[ -z $BASH ] && { exec /bin/bash "$0" "$@" || exit; }
#!/bin/bash
set +x

# NOTE: The gcode_shell_command executes scripts using /bin/sh. The first line above forces the script to
# be executed using bash. While I could make the script POSX compliant, this is simple and quick.

# File containing our github secret token held outside all git repos containing mygittoken=<token> 
export $(grep -v '^#' ~/printer_data/.mygittoken | xargs -0)

# GIT local repos installed on your printer. This is only to add version numbers references as messages for the commit 
gitrepos=(~/klipper ~/moonraker ~/mainsail ~/fluidd ~/ERCF-Software-V3 ~/KlipperScreen ~/klipper_z_calibration)

# Location of klipper configuration
printer_config=~/printer_data/config

# Directory within your klipper configuration to hold a backup of the moonraker database 
moonraker_backup=${printer_config}/.moonraker_database_backup/database.backup

# switch to the klipper config directory
cd ${printer_config}
echo -e "\nKlipper git repositories..."

# loop through local repos looking to grab version information for backup
# if the repo contains a .version file, grab the first line otherwise 
# execute git commands to grab the last tag (version) & git revision number 

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

# trigger moonraker backup
~/moonraker/scripts/backup-database.sh -o ${moonraker_backup}

# push updates to remote git repo
echo Pushing GIT updates
git pull -v "https://nigelpjames:$mygittoken@github.com/nigelpjames/voronred300.git"
git add . -v
current_date=$(date +"%Y-%m-%d %T")
git commit -m "Backup triggered on $current_date" "${gitrevs[@]}"
git push "https://nigelpjames:$mygittoken@github.com/nigelpjames/voronred300.git"
