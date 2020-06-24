healthMeterTilesPointers: ;4846
	dw badHealthMeterTilesAddr
	dw badHealthMeterTilesAddr
	dw poorHealthMeterTilesAddr
	dw fineHealthMeterTilesAddr
	dw goodHealthMeterTilesAddr

badHealthMeterTilesAddr: ;4850
	dw _SCRN0+$14
	dw _SCRN0+$16
	dw _SCRN0+$54
	dw _SCRN0+$56
poorHealthMeterTilesAddr: ;4858
	dw _SCRN0+$18
	dw _SCRN0+$1A
	dw _SCRN0+$58
	dw _SCRN0+$5A
fineHealthMeterTilesAddr: ;4860
	dw _SCRN0+$1C
	dw _SCRN0+$1E
	dw _SCRN0+$5C
	dw _SCRN0+$5E
goodHealthMeterTilesAddr: ;4868
	dw _SCRN0+$94
	dw _SCRN0+$96
	dw _SCRN0+$D4
	dw _SCRN0+$D6
;4870

updateHealthMeter: ;01:4870
    ld a, [wEntityHealth]
    srl a
    srl a
    srl a
    cp a, 5
    jr c, .Label487F
;set limit if greater than 4
    ld a, 4
.Label487F
    add a
    ld e, a
    ld d, 0
    ld hl, healthMeterTilesPointers
    add hl, de ; get health meter tile address
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld a, [wFrameRateCounter] ; get framerate
    srl a
    srl a
    srl a
    and a, 6
    ld e, a
    ld d, 0
    add hl, de ; get health meter frame
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld de, _SCRN0+$165 ; health meter position
    ld c, 2 ; tile rows
.updateTilesLoop
    call vblankWait
    ld a, [hli]
    ld [de], a
    inc e
    ld a, [hl]
    ld [de], a
    ld a, l
    add a, $1F
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, e
    add a, $1F
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    dec c
    jr nz, .updateTilesLoop
    ret
;48BD