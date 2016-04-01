
playSample:: ;FF:4000
;hl: sample address
;de: sample tempo
;bc: sample length
    push bc
    push hl
    ld a, e
    ld [wSampleTempoLow], a
    ld a, d
    ld [wSampleTempoHigh], a
    ld a, %10000100 ;$84 enable sound channels
    ld [rAUDENA], a ;NR52 sound on/off
    xor a
    ld [rAUD3ENA], a ;NR30 audio channel #3
    ld [rAUDTERM], a ;NR51 sound output
    ld a, %01110111 ;$77
    ld [rAUDVOL], a ;set max volume
    ld a, %01000100 ;$44
    ld [rAUDTERM], a ;enable only wave channel
    ld a, %10000000 ;$80
    ld [rAUD3LEN], a ;set ch3 sound length
    ld a, %00100000 ;$20
    ld [rAUD3LEVEL], a ;set ch3 max volume
    xor a
    ld [rAUD3LOW], a ;NR33 sound frequency #3
    ld hl, _AUD3WAVERAM ;$FF30
    ld b, $10
.clearWaveRam
    ld [hl], $00
    inc hl
    dec b
    jr nz, .clearWaveRam
    pop hl ;restore sample addr
    pop bc ;restore sample length
.sampleUpdateLoop
    push bc ;store sample length
    ld bc, $8780 ;wave pitch
    ld de, _AUD3WAVERAM ;$FF30
    xor a
    ld [rAUDVOL], a ;mute wave channel
    xor a
    ld [rAUD3ENA], a ;disable wave chl
;update wave ram
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
;restart channel
    ld a, c
    ld [rAUD3ENA], a ;set low pitch bits
    ld a, b
    ld [rAUD3HIGH], a ;restart & set high pitch bits
    ld a, %1110111 ;$77
    ld [rAUDVOL], a ;set max volume
;set tempo in bc
    ld a, [wSampleTempoLow]
    ld c, a
    ld a, [wSampleTempoHigh]
    ld b, a
.sampleDelayLoop
    dec bc
    ld a, b
    or a, c
    jr nz, .sampleDelayLoop
    pop bc
    dec bc ;decrease length
    ld a, b
    or a, c
    jp z, .sampleUpdateEnd
    jp .sampleUpdateLoop
.sampleUpdateEnd
    xor a
    ld [rAUD3ENA], a ;disable ch3
    ld a, %10111011 ;$BB
    ld [rAUDTERM], a
    ret

	;some unused instruction or ramdom data
	dec [hl]
	inc c
	nop
	nop
