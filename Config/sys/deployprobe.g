; echo "Running deployprobe.g"
; if !move.axes[0].homed || !move.axes[1].homed     ; If the printer hasn't been homed, home it
;    M98 P"0:/sys/homexy.g" 

; uncomment next line to echo the probe deploy state 
echo "Object Model Deployuser token =" ^sensors.probes[0].deployedByUser

G91                          ; relative positioning
echo "Lift Z in advance of deploy" 
G1 H2 Z15 F3000              ; move Z 15 for clearance above dock.
;                            ; need to figure out some safety check on this
G90                          ; absolute positioning

; uncomment next line to echo the probe value 
; echo "Probe Value =" ^sensors.probes[0].value[0]

if sensors.probes[0].value[0]!=1000    ; if sensor is value other than 1000 do this
  ; uncomment next line to echo the probe deploy state 
  ; echo "deployuser token = " ^sensors.probes[0].deployedByUser
  ; echo "Probe State = " ^sensors.probes[0].value[0]
  abort "deployprobe start value Probe already picked up.  Manually return probe to the dock"

; if we're here we know it's becasue the above is true which I assume is because you have an NC switch as a probe.
; echo "Passed first logic test to deploy probe"

; Docked out position X99 Y38

G1 X60 Y100 F6000

M280 P0 S96

G1 X60 Y38 F6000             ; move adjacent to probe dock location
M400                          ; wait for moves to finish

; echo "Probe Pickup macro running"

; uncomment next line to echo the probe deplot state 
; echo "Object Model Deployuser token (before while loop) = " ^sensors.probes[0].deployedByUser

G1 X99 F3000                ; move over dock 
G4 S1                         ; pause 1.0 sec for pickup 

; uncomment next line to echo the probe value 
; echo "Probe Value =" ^sensors.probes[0].value[0]

G1 X60 F1200               ;  slide probe out of dock - slowly
M400
G4 P500                       ; pause 0.5 seconds

echo "Probe Pickup complete"

M280 P0 S0

; uncomment to echo the probe deploy state 
; echo "Object Model Deployuser token (after while loop) = " ^sensors.probes[0].deployedByUser

G90                           ; absolute positioning
G1 X60 Y60 F3000        ; move bed center and to clear probe from build surface 
M400                          ; wait for moves to finish


if sensors.probes[0].value[0]!=0
  ; uncomment to echo the probe deploy state 
  echo "Object Model Deployuser token (in abort if section)= " ^sensors.probes[0].deployedByUser
  abort "Deployprobe endvalue not 0 Probe not picked up!  Deployt cancelled."

echo "Macro deployprobe.g complete"