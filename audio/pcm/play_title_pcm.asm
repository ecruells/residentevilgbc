
; hl: pcm data address
; bc: pcm data length
; de: audio tempo
playTitlePCM:: ;FF:4000
    push bc
    push hl
    ld a, e
    ld [wPcmTempoLo], a
    ld a, d
    ld [wPcmTempoHi], a
    ld a, %10000100 ; enable sound channels
    ld [rAUDENA], a ; NR52 sound on/off
    xor a
    ld [rAUD3ENA], a ; NR30 audio channel #3
    ld [rAUDTERM], a ; NR51 sound output
    ld a, %01110111
    ld [rAUDVOL], a ; set max volume
    ld a, %01000100
    ld [rAUDTERM], a ; enable only wave channel
    ld a, %10000000
    ld [rAUD3LEN], a ; set ch3 sound length
    ld a, %00100000
    ld [rAUD3LEVEL], a ; set ch3 max volume
    xor a
    ld [rAUD3LOW], a ; NR33 sound frequency #3
    ld hl, _AUD3WAVERAM
    ld b, 16
.clearWaveRam
    ld [hl], 0
    inc hl
    dec b
    jr nz, .clearWaveRam
    pop hl ; restore pcm address
    pop bc ; restore pcm length
.updateWaveramLoop
    push bc ; store pcm length
    ld bc, $8780 ; wave pitch
    ld de, _AUD3WAVERAM
    xor a
    ld [rAUDVOL], a ; mute wave channel
    xor a
    ld [rAUD3ENA], a ; disable wave chl
; update wave ram
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
; activate channel
    ld a, c
    ld [rAUD3ENA], a ; set low pitch bits
    ld a, b
    ld [rAUD3HIGH], a ; restart & set high pitch bits
    ld a, %01110111
    ld [rAUDVOL], a ; set max volume
; set tempo in bc
    ld a, [wPcmTempoLo]
    ld c, a
    ld a, [wPcmTempoHi]
    ld b, a
.pcmDelayLoop
    dec bc
    ld a, b
    or a, c
    jr nz, .pcmDelayLoop
    pop bc
    dec bc ; decrease length
    ld a, b
    or a, c
    jp z, .pcmUpdateEnd
    jp .updateWaveramLoop
.pcmUpdateEnd
    xor a
    ld [rAUD3ENA], a ; disable ch3
    ld a, %10111011
    ld [rAUDTERM], a
    ret

