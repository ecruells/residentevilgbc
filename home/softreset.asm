softReset:: ;00:0391
	di
	ld a, $01
	call bankSwitch
	call resetPalettes
	jp initGame
