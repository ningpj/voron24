# voron 2.4

Klipper configuration backups.

## Description

Backups for Voron 2.4 300mm build with Fysetc Spider 1.1 MCU, Fly-SHT36 Toolhead MCU, ERCF v2 with Fly Easy Brd CAN 1.1 MCU.

## MCU PIN Assignments

|PIN|Component
|-|-
|SHT:PB10/FAN0|                    Hotend Fan
|SHT:PB11/FAN1|                    Part Fan
|MCU:PB2|                          Component Fan
|MCU:PC8|                          Chamber Fan
|MCU:PB3|                          Chamber LEDS
|SHT:PA1/LIMIT_0|                  Endstop - X
|MCU:PA2|                          Endstop - Y
|MCU:PA0|                          Endstop - Z
|HT:PC15/PROBE_1|                  Probe - PCB KlickyS
|SHT:PA2/LIMIT_1|                  Toolhead sensor
|MCU:PC1|                          Chamber Thermistor   
|MCU:PC3|                          Bed Thermister
|MCU:PD3|                          Print Head Neopixels
|CU:PB7 (LED-B 24V)|               Nevermore
|Spare Pins|
|MCU:PB0|                          FAN0
|MCU:PB1|                          FAN1
|MCU:PA1|                          End Stop
|MCU:PA3|                          Probe
|MCU:PB13|                         Limit Switch/End stop
|MCU:PB14|                         Limit Switch/End stop 
|MCU:PC0|                          Thermister
|MCU:PC2|                          Thermister 
|MCU:PC9|                          ~~Fysetc 12864 beeper~~

## Slicer start print gcode

* Super Slicer / Prusa Slicer <br>
  ```
  M109 S0 ; Disabled - PRINT_START controls startup procedure
  M190 S0 ; Disabled - PRINT_START controls startup procedure
  PRESSURE_ADVANCE_SELECT NOZZLE=[nozzle_diameter] FILAMENT=[filament_type]
  PRINT_START ERCF=1 EXTRUDER=[first_layer_temperature[initial_extruder]] BED=[first_layer_bed_temperature] FILAMENT=[filament_type] TOOL=[initial_extruder] SIZE={first_layer_print_min[0]}_{first_layer_print_min[1]}_{first_layer_print_max[0]}_{first_layer_print_max[1]}
  ``` 

[mygithub](https://github.com/nigelpjames)
