# voronred300

Klipper configuration backups.

## Description

Backups for Voron 2.4 300mm build based on Fysetc Spider 1.1 MCU.

## Spider 1.1 MCU PIN Assignments

|PIN|Component
|-|-
|FAN0|     Hotend (PB0)
|FAN1|     Part Fan (PB1)
|FAN2|     Compartment Fan (PB2)
|E1 Out|   Chamber Fan (PC8)
|E2 Out|   Chamber LEDs (PB3)
|PA1|      Endstop - X
|PA2|      Endstop - Y
|PA3|      Klicky / Probe
|PB14|     ~~ERCF Tool Head Filament Sensor~~ (Using "sensorless" homing with CW2 instead)
|PB13|     N/C
|PA0|      Endstop - Z 
|PC0|      Extruder Thermistor
|PC1|      Cabinet Thermistor
|PC2|      N/C
|PC3|      Bed Thermister
|PC9|      ~~Fysetc 12864 beeper~~
|PD3|      Stealth Neopixels - Spider neopixel port

## Slicer start print gcode

* Super Slicer / Prusa Slicer <br>
  ```
  M109 S0 ; Disabled - PRINT_START controls startup procedure
  M190 S0 ; Disabled - PRINT_START controls startup procedure
  PRESSURE_ADVANCE_SELECT NOZZLE=[nozzle_diameter] FILAMENT=[filament_type]
  PRINT_START ERCF=1 EXTRUDER=[first_layer_temperature[initial_extruder]] BED=[first_layer_bed_temperature] FILAMENT=[filament_type] TOOL=[initial_extruder] SIZE={first_layer_print_min[0]}_{first_layer_print_min[1]}_{first_layer_print_max[0]}_{first_layer_print_max[1]}
  ``` 

## Change Log

* Replace 12864 screen with BTT Pi TFT50 v2 & KlipperScreen Happy Hare fork
* * Refine ERCF tip forming settings - Rapido & CW2
* Tidy up poweroff script, direct command output to klippy.log and clean up console/stdout/stderr messages
& log commands to * cleanup GIT backup script, switch to legitimate moonraker backup scripts, repoint printer_home for new RPi build
* Update & parameterise mymakeklipper.sh helper to support individual MCU targets and no flash default. Functional but still a quick hack with hardwired elements. Also added on_error_gcode: cancel_print failsafe to [virtual_sdcard] section to always make sure heaters are disabled
* Rework print start | end | cancel | pause | resume macros to use my_variables for common settings and constants. Also simplified safe homing & parking to use purge bucket location 
* Since reinstating klicky I had another look at improving probing accuracy and reducing errors. In testing I found that increasing probe speed to 10 and sample_retract_distance to 3 improved reliability over my previous setup - YMMV (from 7.5 0.8 respectively)

  ```speed:                      10
  lift_speed:                 50.0  
  samples:                    3
  samples_result:             median
  sample_retract_dist:        3.0
  samples_tolerance:          0.0075
  samples_tolerance_retries:  6
* Rework and optimise print_start to include heat soak and other refinements
* Revert tap and reinstate klicky/auto-z setup. I use Garolite / G10 build plates and found the nozzle was starting to mark the surface when probing at 150c and will need to look for higher temp epoxy options before trying again (3420 epoxy or better). Also lost 5mm on Y due to extra depth of tap carriage (need to extend front doors) and unresolved resonance issue on Y axis.  Like pixel peepers on camera forums the pursuit of better accuracy is admirable but is already pretty damn good :-)
* Implemented Tap.  Auto-Z, Klicky macro's commented out, virtual end stop now in use.  Homes back right at the moment (x=300, y=290)
* Revert to updated adaptive mesh logic from Frix-x (https://github.com/Frix-x/klipper-voron-V2/blob/main/macros/calibration/adaptive_bed_mesh.cfg) as purge tower is excluded from exclude_objects scope which "may" have a material impact.  Frix updated logic to support passed print range with fall back to exclude_object/full mesh if not passed.  Updated auto-z macro to use calculated dynamic reference XY to probe the centre of the adaptive mesh
* Enabled adaptive bed mesh using slick moonraker exclude_objects approach. Minimal code, just need to make sure exclude_objects is enabled in moonraker config and Label Objects set in your slicer. No need to pass print dimensions - https://github.com/kyleisah/Klipper-Adaptive-Meshing-Purging
* Added switch/power meter callout to physically power printer off when shutting down (pushes Power Off command onto Tasmota backlog with 10 sec delay to allow time for Pi to gracefully shutdown). Will call from klipper timeout gcode in future to power off when finished printing overnight. Average power consumption post heat soak for 300mm build (Rapido, 240v 600w bed@60%) is 254W
* ERCF Sensorless filament update & python native macros (WIP)
* Added recovery_velocity=150 to [pause_resume]. 50 too slow when mucking around with ERCF issues
* Fine tune standalone ERCF filament tip forming using skinny dip (need to match this in Super Slicer as this is only used for non print related filament changes)
* Added ERCF support and updated PRINT_START/END/PAUSE/CANCEL macros to suit. Also implemented ERCF=0|1 slicer argument to allow control over ERCF without needing to faff with slicer arguments or split PRINT_START between klipper and slicer. When ERCF=1 (enabled) PRINT_START checks if the default tool is loaded before waiting for the bed to reach temp or QGL/Mesh/auto-Z.      
* Added FCOB 24v 480 LED's/metre PWM chamber LEDs (10W per metre)
* Fixed issue with mymakeklipper.sh mcu config overrides for compiling and installing raspberry pi and Spider MCU's 
* Added myrestoregit.sh helper script to automate restoration of klipper_config repository and moonraker database from GIT backup
* Rebuild and install klipper/fluid on clean buster 32bit image (bullseye still has rPi camera issues with new cameralib setup)
* Klipper build/make script and configurations for updating and flashing RP [Input Shaper] and Spider MCU's (scripts/mymakeklipper.sh)
* New macro and helper script to process input shaper data files and generate X & Y graphs to klippy_config directory for review and download (INPUT_SHAPER & scripts/myinputshaper.sh)

[mygithub](https://github.com/nigelpjames)
