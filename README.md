# voron 2.4

Klipper configuration backups.

## Description

Backups for Voron 2.4 300mm build with Fysetc Spider 1.1 MCU, Fly-SHT36 Toolhead MCU, ERCF v2 with Fly Easy Brd CAN 1.1 MCU.

## MCU PIN Assignments

# voron 2.4

Klipper configuration backups.

## Description

Backups for Voron 2.4 300mm build with Fysetc Spider 1.1 MCU, Fly-SHT36 Toolhead MCU, ERCF v2 with Fly Easy Brd CAN 1.1 MCU.

## MCU PIN Assignments

|**Component**|**PIN**
|-|-
|Hotend Fan|SHT:PB10/FAN0
|Part Fan|SHT:PB11/FAN1
|Component Fan|MCU:PB2
|Chamber Fan|MCU:PC8
|Chamber LEDS|MCU:PB3
|Endstop - X|SHT:PA1/LIMIT_0
|Endstop - Y|MCU:PA2
|Endstop - Z|MCU:PA0
|Probe - PCB Klicky|SHT:PC15/PROBE_1
|Toolhead sensor|SHT:PA2/LIMIT_1
|Chamber Thermistor|MCU:PC1
|Bed Thermister|MCU:PC3
|Print Head Neopixels|MCU:PD3
|Nevermore|MCU:PB7 (LED-B 24V)
|**Spare Pins (Spider 1.1)**|
|FAN0|MCU:PB0
|FAN1|MCU:PB1
|End Stop|MCU:PA1
|Probe|MCU:PA3
|Limit Switch/End stop|MCU:PB13
|Limit Switch/End stop|MCU:PB14
|Thermister|MCU:PC0
|Thermister|MCU:PC2
|12864 Beeeper|MCU:PC9


## Slicer start print gcode

* Orca
  ```
SET_PRINT_STATS_INFO TOTAL_LAYER=[total_layer_count]
;
MMU_START_SETUP INITIAL_TOOL={initial_tool} REFERENCED_TOOLS=!referenced_tools! TOOL_COLORS=!colors! TOOL_TEMPS=!temperatures! TOOL_MATERIALS=!materials! FILAMENT_NAMES=!filament_names! PURGE_VOLUMES=!purge_volumes!
;
MMU_START_CHECK
;
PRINT_START EXTRUDER=[first_layer_temperature[initial_extruder]] BED=[first_layer_bed_temperature] CHAMBER=[chamber_temperature] FILAMENT=[filament_type] NOZZLE=[nozzle_diameter] TOOL=[initial_extruder] SIZE={first_layer_print_min[0]}_{first_layer_print_min[1]}_{first_layer_print_max[0]}_{first_layer_print_max[1]}
  ```

[mygithub](https://github.com/ningpj)
