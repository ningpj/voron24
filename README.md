# voron 2.4

Klipper configuration backups.

## Description

Backups for Voron 2.4 300mm build 
+ Octopus Pro 1.1 MCU
+ Mellow Fly SHT-36 v2
+ Mellow UTOC
+ 12 Lane Tradrack
 + Mellow Fly Easy Brd CAN 1.1 MCU
 + Binky Encoder
 + Blobifier - Stepper tray (custom macros for right hand use)
 + ~~EREC~~ Crossbow filament cutter
+ WWG2 Extruder
+ Yavoth
+ Rapido v1 HF
+ 130° Aliexpress Wideangle Picam


## MCU PIN Assignments

|**Component**|**PIN**|**Port**
|-|-|-
|Hotend Fan                       |SHT:PB10|FAN0
|Hotend Heater                    |SHT:HE0
|Hotend Sensor                    |SHT:TH0
|Part Fan                         |SHT:PB11|FAN1
|Component Fan                    |MCU:PA8|VF0
|Chamber Fan                      |MCU:PE5|VF1
|Chamber LEDS                     |MCU:PA3|HE1
|Endstop - X                      |SHT:PA1|LIMIT_0
|Endstop - Y                      |MCU:PG6|STOP-0
|Endstop - Z                      |MCU:PG9|STOP-1
|Blobifier tray end stop          |MCU:PG10|STOP-2
|Blobifier bucket                 |MCU:PG11|STOP-3
|Probe - PCB Klicky               |SHT:PC15|PROBE_1
|Toolhead sensor                  |SHT:PA2|LIMIT_1
|Chamber Thermistor               |MCU:PF4|T0   
|Bed Thermister                   |MCU:PF3|TB
|Print Head Neopixels             |SHT:PB0|RGBLED


## Slicer (Orca)

**PRINT_START gcode**
```
SET_PRINT_STATS_INFO TOTAL_LAYER=[total_layer_count]
;
MMU_START_SETUP INITIAL_TOOL={initial_tool} REFERENCED_TOOLS=!referenced_tools! TOOL_COLORS=!colors! TOOL_TEMPS=!temperatures! TOOL_MATERIALS=!materials! FILAMENT_NAMES=!filament_names! PURGE_VOLUMES=!purge_volumes!
;
MMU_START_CHECK
;
PRINT_START EXTRUDER=[first_layer_temperature[initial_extruder]] BED=[first_layer_bed_temperature] CHAMBER_MIN=[chamber_minimal_temperature] CHAMBER=[chamber_temperature] FILAMENT=[filament_type] PA=[pressure_advance] NOZZLE=[nozzle_diameter] TOOL=[initial_extruder] SIZE={first_layer_print_min[0]}_{first_layer_print_min[1]}_{first_layer_print_max[0]}_{first_layer_print_max[1]} 
;
```

**LAYER_CHANGE gcode**
```
_MMU_UPDATE_HEIGHT
SET_PRINT_STATS_INFO CURRENT_LAYER={layer_num + 1}
```

**FILAMENT_CHANGE gcode**
```
T[next_extruder] SLICER_PURGE=[flush_length] SLICER_RETRACTION={old_retract_length} SLICER_FW_RETRACTION={use_firmware_retraction}
```

**PRINT_END gcode**
```
MMU_END
PRINT_END
```

[mygithub](https://github.com/ningpj)
