# voron 2.4

Klipper configuration backups.

## Description

Backups for Voron 2.4 300mm build with Fysetc Spider 1.1 MCU, Fly-SHT36 Toolhead MCU, ERCF v2 with Fly Easy Brd CAN 1.1 MCU.
12 Lane Tradrack with EREC cutter and Binky encoder.

<img width="600" height="600" alt="voron24" src="https://github.com/user-attachments/assets/f9b218f5-d06e-45f1-a554-127916537c42" />


## MCU PIN Assignments

|**Component**|**PIN**
|-|-
|Hotend Fan|SHT:PB10/FAN0
|Part Fan|SHT:PB11/FAN1
|Component Fan|MCU:PB2
|Toolhead PCB cooler|SHT:PROBE_2
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
|Blobifier tray/bucket|MCU:PB13
|Blobifier servo|MCU:PA3
||
|**Spare Pins (Spider 1.1)**|
|FAN0|MCU:PB0
|FAN1|MCU:PB1
|End Stop|MCU:PA1
|Limit Switch/End stop|MCU:PB14
|Thermister|MCU:PC0
|Thermister|MCU:PC2
|12864 Beeper|MCU:PC9


## Slicer (Orca)

**PRINT_START gcode**
```
SET_PRINT_STATS_INFO TOTAL_LAYER=[total_layer_count]
;
MMU_START_SETUP INITIAL_TOOL={initial_tool} REFERENCED_TOOLS=!referenced_tools! TOOL_COLORS=!colors! TOOL_TEMPS=!temperatures! TOOL_MATERIALS=!materials! FILAMENT_NAMES=!filament_names! PURGE_VOLUMES=!purge_volumes!
;
MMU_START_CHECK
;
PRINT_START EXTRUDER=[first_layer_temperature[initial_extruder]] BED=[first_layer_bed_temperature] CHAMBER=[chamber_temperature] FILAMENT=[filament_type] NOZZLE=[nozzle_diameter] TOOL=[initial_extruder] SIZE={first_layer_print_min[0]}_{first_layer_print_min[1]}_{first_layer_print_max[0]}_{first_layer_print_max[1]}
```

**LAYER_CHANGE gcode**
```
SET_PRINT_STATS_INFO CURRENT_LAYER={layer_num + 1}
```

**FILAMENT_CHANGE gcode**
```
T[next_extruder] ; MMU tool change
```

**PRINT_END gcode**
```
MMU_END
PRINT_END
```

[mygithub](https://github.com/ningpj)
