
playSample:: ;FF:4000
    push bc
    push hl
    ld a, e
    ld [wc1c8], a
    ld a, d
    ld [wc1c9], a
    ld a, $84 ;enable sound channels
    ld [rAUDENA], a ;NR52 sound on/off
    xor a
    ld [rAUD3ENA], a ;NR30 audio channel #3
    ld [rAUDTERM], a ;NR51 sound output
    ld a, $77
    ld [rAUDVOL], a ;NR50 channel control
    ld a, $44
    ld [rAUDTERM], a ;NR51 sound output
    ld a, $80
    ld [rAUD3LEN], a ;NR31 sound length #2
    ld a, $20
    ld [rAUD3LEVEL], a ;NR32 volume #3
    xor a
    ld [rAUD3LOW], a ;NR33 sound frequency #3
    ld hl, _AUD3WAVERAM ;$FF30
    ld b, $10
.loop3FC02B
    ld [hl], $00
    inc hl
    dec b
    jr nz, .loop3FC02B
    pop hl
    pop bc
.loop3FC033
    push bc
    ld bc, $8780 ;loop counter
    ld de, _AUD3WAVERAM ;$FF30
    xor a
    ld [rAUDVOL], a ;NR50 channel control
    xor a
    ld [rAUD3ENA], a ;NR30 audio channel #3
    ld a, [hli]
    ld [de], a
    inc e
    ld a, [hli]
    ld [de], a
    inc e
    ld a, [hli]
    ld [de], a
    inc e
    ld a, [hli]
    ld [de], a
    inc e
    ld a, [hli]
    ld [de], a
    inc e
    ld a, [hli]
    ld [de], a
    inc e
    ld a, [hli]
    ld [de], a
    inc e
    ld a, [hli]
    ld [de], a
    inc e
    ld a, [hli]
    ld [de], a
    inc e
    ld a, [hli]
    ld [de], a
    inc e
    ld a, [hli]
    ld [de], a
    inc e
    ld a, [hli]
    ld [de], a
    inc e
    ld a, [hli]
    ld [de], a
    inc e
    ld a, [hli]
    ld [de], a
    inc e
    ld a, [hli]
    ld [de], a
    inc e
    ld a, [hli]
    ld [de], a
    ld a, c
    ld [rAUD3ENA], a ;NR30 audio channel #3
    ld a, b
    ld [rAUD3HIGH], a ;NR34 sound frequency #3
    ld a, $77
    ld [rAUDVOL], a ;NR50 channel control
    ld a, [wc1c8]
    ld c, a
    ld a, [wc1c9]
    ld b, a
.loop3FC081
    dec bc
    ld a, b
    or a, c
    jr nz, .loop3FC081
    pop bc
    dec bc
    ld a, b
    or a, c
    jp z, .Label3FC090
    jp .loop3FC033
.Label3FC090
    xor a
    ld [rAUD3ENA], a ;NR30 audio channel #3
    ld a, $BB
    ld [rAUDTERM], a ;NR51 sound output
    ret

	;some unused instruction or ramdom data
	dec [hl]
	inc c
	nop
	nop
