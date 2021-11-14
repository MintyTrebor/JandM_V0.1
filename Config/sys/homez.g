if !move.axes[0].homed || !move.axes[1].homed     ; If the printer hasn't been homed, home it
   G28 XY  

M561                                            ; clear any bed transform
M290 S0 R0                                      ; clear baby steps per Wes C
M400

; echo "Call deployprobe.g macro" 
M401 P0                                         ; This runs macro file deployprobe

; echo "Return"
G1 X60 Y60 F9000                            ; go to first probe point
M400

G30

; echo "Call retractprobe.g macro"
M402 P0                                         ; retract probe
; echo "Return"

G90                                             ; absolute positioning
; G1 X150 Y0 F9000                              ; move carraige to center front