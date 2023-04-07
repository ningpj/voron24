#!/bin/bash

# process input shaper calibration files if they exist and publish images to klipper config directory for download
# if multiple files, process the most recent and delete all matching files when done

if ls /tmp/resonances_x_*.csv >/dev/null 2>&1; then
   python3 ~/klipper/scripts/calibrate_shaper.py `ls -at /tmp/resonances_x_*.csv| head -1` -o ~/klipper_config/shaper_calibrate_x.png
   rm -f /tmp/resonances_x_*.csv
else
   echo No ADXL input shaper data file for X axis
   echo Run TEST_RESONANCES AXIS=X FREQ_END=100 to generate
fi

if ls /tmp/resonances_y_*.csv >/dev/null 2>&1; then
   python3 ~/klipper/scripts/calibrate_shaper.py `ls -at /tmp/resonances_y_*.csv| head -1` -o ~/klipper_config/shaper_calibrate_y.png
   rm -f /tmp/resonances_y_*.csv
else
   echo No ADXL input shaper data file for Y axis
   echo Run TEST_RESONANCES AXIS=Y FREQ_END=100 to generate
fi
