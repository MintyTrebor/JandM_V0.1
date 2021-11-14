echo "running retractprobe.g macro"
; uncomment next line to echo the probe deploy state 
; echo "Object Model Deployuser token =" ^sensors.probes[0].deployedByUser

; Dock side position is at X99 Y38

G90	                          ; absolute positioning

if sensors.probes[0].value[0]!= 0
    echo "Probe Value =" ^sensors.probes[0].value[0]
    echo "Object Model Deployuser token =" ^sensors.probes[0].deployedByUser
    abort "retractprobe: Probe not currently picked up!"

; echo "pass first logic loop"

; uncomment next line to echo the probe value and probe deploy state 
; echo "Probe Value =" ^sensors.probes[0].value[0]
; echo "Object Model Deployuser token =" ^sensors.probes[0].deployedByUser

G1 X60 Y60 F3000             ; move to ready position 
M280 P0 S96
G1 X60 Y38  F3000              ; move to the entry position for the dock
G1 X115 Y38  F3000                ; move into the dock position
M400
G1 Y115 F3000

M280 P0 S0

; echo "complete movement commands"

if sensors.probes[0].value[0]!= 1000
    ; echo "Probe Value =" ^sensors.probes[0].value[0]
    ; echo "Object Model Deployuser token =" ^sensors.probes[0].deployedByUser
    abort "retractprobe.g Probe not correctly dropped off in dock!"

echo "Macro retractprobe.g complete"