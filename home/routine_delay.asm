; delay a routine execution by halting the cpu n times.
; as haltCPU is disabled only in vblank, to delay a routine
; for 1 second, the delay loop has to iterate 60 times. 
routineDelay:: ;02B2
	push bc
	call haltCPU
	pop bc
	dec b
	jr nz, routineDelay
	ret
