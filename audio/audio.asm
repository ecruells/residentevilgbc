
goToDisableSound:: ;06:4000
	jp disableSound

jumpToSoundFunc487B:: ;06:4003
	jp soundFunc487B

goToPlayMusicRoutine:: ;06:4006
	jp playMusicRoutine

updateMusic:: ;06:4009
	jp goToUpdateMusic

Label1800C: ;400C
    jp updateMusicRoutine
Label1800F: ;400F
    jp initSoundChannels
Label18012: ;4012
    jp muteAllChannels
Label18015: ;4015
    jp enableChannelControlMax
Label18018: ;4018
    jp decreaseAudioVolume
Label1801B: ;401B
    jp increaseAudioVolume
Label1801E: ;401E
    jp disableSoundOutput
Label18021: ;4021
    jp function18027

goToPlaySFXRoutine:: ;06:4024
	jp playSFXRoutine

function18027:: ;06:4027
	ld [wSoundDD78], a
	ret

goToUpdateMusic::
	call updateMusicRoutine
	call initSoundChannels
	ret
;06:4032

decreaseAudioVolume: ;06:4032
    ld a, [rAUDVOL]  ;NR50 channel control
    and a, %00000111
    jr z, Label1803F ;jump if SO1 vol is max
    dec a ;decrease volume
    or a, $08
    ld b, a
    jp Label18041
Label1803F
    ld b, $00
Label18041:
    ld a, [rAUDVOL]  ;NR50 channel control
    and a, %01110000
    jr z, Label1804C ;jump if SO2 vol is max
    sub a, %00010000 ;decrease volume
    jp Label1804E
Label1804C
    ld a, $00
Label1804E:
    or a, b
    cp a, $00
    jr nz, Label18056
    call muteAllChannels
Label18056
    ld [rAUDVOL], a ;NR50 channel control
    ret
;4059

disableSoundOutput: ;06:4059
    xor a
    ld [rAUDTERM], a ;disable NR51 sound output
    ld [wNR51SoundOutput], a
    ld [rAUDVOL], a ;mute vol NR50 channel control
    ld [wNR50ChannelControl], a
    ret
;4065

muteAllChannels: ;06:4065
    ld a, $00
    ld [rAUD1ENV], a ;NR12 envelope channel #1
    ld [rAUD2ENV], a ;NR22 envelope channel #2
    ld [rAUD3LEVEL], a ;NR32 volume #3
    ld [rAUD4ENV], a ;NR42 envelope channel #4
    ld [wNR50ChannelControl], a
    ret
;4073

enableChannelControlMax: ;06:4073
    ld a, %11111111
    ld [wNR50ChannelControl], a ;enable outputs level at max
    ret
;4079

increaseAudioVolume: ;06:4079
    call enableChannelControlMax
    ld a, [rAUDVOL]  ;NR50 channel control
    cp a, %00000000
    jr nz, increaseSO1Volume ;if audio is disabled
    ld a, %10001000 ;enable VINs, 0 volumen
    ld [rAUDVOL], a ;NR50 channel control
    ret
increaseSO1Volume ;06:4087
    and a, %00000111 ;SO1 max volume
    cp a, %00000111
    jr z, increaseSO2Volume ;jump if SO1 volume is at max
    add a, $01
    ld b, a ;increse SO1 volume
increaseSO2Volume
    ld a, [rAUDVOL]  ;NR50 channel control
    and a, %01110000 ;SO2 max volume
    srl a
    srl a
    srl a
    srl a
    cp a, %00000111
    ret z; ret if SO2 volume is at max
    add a, $01 ;increse SO2 volume
    sla a
    sla a
    sla a
    sla a
    or a, b
    or a, %10001000
    ld [rAUDVOL], a ;set volume NR50
    ret
;40AF

playSFXRoutine:: ;06:40AF
    add a
    add a
    ld hl, SfxLookupTable ;$6F1C
    add a, l
    ld l, a
    jr nc, .Label180B9
    inc h
.Label180B9
    ld a, [hl]
    cp a, $FF
    jr z, .Label180C1
    call callSoundFunc487B
.Label180C1
    inc hl
    ld a, [hl]
    cp a, $FF
    jr z, .Label180CA
    call callSoundFunc487B
.Label180CA
    inc hl
    ld a, [hl]
    cp a, $FF
    jr z, .Label180D3
    call callSoundFunc487B
.Label180D3
    inc hl
    ld a, [hl]
    cp a, $FF
    jr z, .Label180DC
    call callSoundFunc487B
.Label180DC
    ret

callSoundFunc487B:: ;06:40DD
	push hl
	call soundFunc487B
	pop hl
	ret

disableSound:: ;06:40E3
    ld a, %00000000
    ld [rAUDENA], a ;disable sound NR52
    nop
    ld [rAUDENA], a ;disable sound NR52
    ld [wSoundDD68], a
    ld [wDD69], a
    ld [wDD6B], a
    ld [wDD6C], a
    ld [wDD6E], a
    ld [wDD6F], a
    ld [wDD71], a
    ld [wDD72], a
    ld [wSqr1Channel], a
    ld [wSqr2Channel], a
    ld [wWaveChannel], a
    ld [wNoiseChannel], a
    ld a, $FF
    ld [wSoundDD78], a
    ld a, $01
    ld [wSoundDD77], a
    ld de, _AUD3WAVERAM ;$FF30
    ld hl, soundData49DD ;$49DD
    ld b, $10
.loop18120
    ld a, [hl]
    ld [de], a
    inc hl
    inc de
    dec b
    jr nz, .loop18120
    call initSound
    ret

playMusicRoutine:: ;06:412B
;a: music id
    ld l, a
    ld h, $00
    add hl, hl
    ld d, h
    ld e, l
    add hl, hl
    add hl, hl
    add hl, de
    ld de, musicTable ;$49ED
    add hl, de
    ld a, [hli]
    ld [wDD02], a
    ld a, [hli]
    ld [wDD03], a
    ld a, [hli]
    ld [wDD1A], a
    ld a, [hli]
    ld [wDD1B], a
    ld a, [hli]
    ld [wDD32], a
    ld a, [hli]
    ld [wDD33], a
    ld a, [hli]
    ld [wDD4A], a
    ld a, [hli]
    ld [wDD4B], a
    ld a, [hli]
    ld [wDD60], a
    ld a, [hli]
    ld [wDD61], a
    ld a, $01
    ld [wDD01], a
    ld [wDD19], a
    ld a, $02
    ld [wDD31], a
    ld [wDD49], a
    ld a, $03
    ld [wSqr1Channel], a
    ld [wSqr2Channel], a
    ld [wWaveChannel], a
    ld [wNoiseChannel], a
    ld [wNR50ChannelControl], a
    ld a, $FF
    ld [wSoundDD78], a
    ld a, $01
    ld [wSoundDD77], a
initSound:: ;06:418B
    ld a, %10001111
    ld [rAUDENA], a ;enable NR52 sound
    nop
    nop
	ld [rAUDENA], a ;enable NR52 sound
    ld a, %00001000
    ld [rAUD1SWEEP], a ;sweep decrease NR10
    ld a, %11111111
    ld [rAUDTERM], a ;output all channel to all sound output
    ld [wNR51SoundOutput], a
    ld a, %01110111
    ld [rAUDVOL], a ;max volume
    ld a, %10000000
    ld [rAUD3ENA], a ;set audio channel #3 ON NR30
    xor a
    ld [rAUD1ENV], a ;NR12 stop envelope channel #1
    ld [rAUD2ENV], a ;NR22 stop envelope channel #2
    ld [rAUD3LEVEL], a ;NR32 mute volume #3
    ld [rAUD4ENV], a ;NR42 stop envelope channel #4
    ld [wSndChl1Vol], a
    ld [wSndChl2Vol], a
    ld [wSndChl3Vol], a
    ld [wSndChl4Vol], a
    ld [wDD15], a
    ld [wDD2D], a
    ld [wDD45], a
    ld [wDD5D], a
    ld [wDD55], a
    ret

updateMusicRoutine:: ;06:41CB
    ld a, [wNR50ChannelControl]
    and a
    ret z ;return if sound is disabled
    ld a, [wSoundDD78]
    ld b, a
    ld a, [wSoundDD77]
    add a, b
    ld [wSoundDD77], a
    ret nc
Label181DC: ;41DC
    xor a
    ld [wSoundDD7B], a
    ld hl, wDD62
    ld de, Label181DC ;$41DC
    ld [hl], e
    inc hl
    ld [hl], d
    ld a, [wSndChl1Vol]
    ld [wDD65], a
    ld hl, wSqr1Channel
    ld de, rAUD1LEN
    call soundFunction44D4
    ld a, [wSqr1Channel]
    and a, $01
    jp z, soundFunction429B
    ld a, [wDD69]
    and a
    jp nz, soundFunction429B
    ld hl, wDD0A
    ld de, wDD0B
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    ld de, rAUD1ENV
    call soundFunction446C
    ld de, wDD0B
    ld a, c
    ld [de], a
    ld a, b
    inc de
    ld [de], a
    ld hl, wSqr1Channel
    ld de, rAUD1LOW
    call soundFunction45A7
    ld hl, wDD0D
    ld de, wDD0E
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    ld de, wDD05
    call soundFunction4494
    ld de, wDD0E
    ld a, c
    ld [de], a
    ld a, b
    inc de
    ld [de], a
    ld a, [wDD10]
    and a
    jr z, soundFunction429B
    dec a
    ld [wDD10], a
    and a
    jr nz, soundFunction429B
    ld a, [wDD11]
    ld c, a
    ld a, [wDD12]
    ld b, a
    ld a, [bc]
    cp a, $FF
    jr z, .Label1828C
    ld [wDD10], a
    inc bc
    ld a, [bc]
    ld e, a
    ld a, [wDD7C]
    add a, e
    push af
    ld de, Label1881B ;$481B
    add a, e
    ld e, a
    jr nc, .Label1826F
    inc d
.Label1826F
    ld a, [de]
    ld [wDD04], a
    pop af
    ld de, Label187BB ;$47BB
    add a, e
    ld e, a
    jr nc, .Label1827C
    inc d
.Label1827C
    ld a, [de]
    ld [wDD05], a
    inc bc
    ld a, c
    ld [wDD11], a
    ld a, b
    ld [wDD12], a
    jp soundFunction429B
.Label1828C
    ld a, $01
    ld [wDD10], a
    inc bc
    ld a, [bc]
    ld [wDD11], a
    inc bc
    ld a, [bc]
    ld [wDD12], a
;429B
soundFunction429B:: ;06:429B
    ld a, $01
    ld [wSoundDD7B], a
    ld hl, wDD62
    ld de, soundFunction429B ;$429B
    ld [hl], e
    inc hl
    ld [hl], d
    ld a, [wSndChl2Vol]
    ld [wDD65], a
    ld hl, wSqr2Channel
    ld de, rAUD2LEN
    call soundFunction44D4
    ld a, [wSqr2Channel]
    and a, $01
    jp z, soundFunction435B
    ld a, [wDD6C]
    and a
    jp nz, soundFunction435B
    ld hl, wDD22
    ld de, wDD23
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    ld de, rAUD2ENV
    call soundFunction446C
    ld de, wDD23
    ld a, c
    ld [de], a
    ld a, b
    inc de
    ld [de], a
    ld hl, wSqr2Channel
    ld de, rAUD2LOW
    call soundFunction45A7
    ld hl, wDD25
    ld de, wDD26
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    ld de, wDD1D
    call soundFunction4494
    ld de, wDD26
    ld a, c
    ld [de], a
    ld a, b
    inc de
    ld [de], a
    ld a, [wDD28]
    and a
    jr z, soundFunction435B
    dec a
    ld [wDD28], a
    and a
    jr nz, soundFunction435B
    ld a, [wDD29]
    ld c, a
    ld a, [wDD2A]
    ld b, a
    ld a, [bc]
    cp a, $FF
    jr z, .Label1834C
    ld [wDD28], a
    inc bc
    ld a, [bc]
    ld e, a
    ld a, [wDD7D]
    add a, e
    push af
    ld de, Label1881B ;$481B
    add a, e
    ld e, a
    jr nc, .Label1832F
    inc d
.Label1832F
    ld a, [de]
    ld [wDD1C], a
    pop af
    ld de, Label187BB ;$47BB
    add a, e
    ld e, a
    jr nc, .Label1833C
    inc d
.Label1833C
    ld a, [de]
    ld [wDD1D], a
    inc bc
    ld a, c
    ld [wDD29], a
    ld a, b
    ld [wDD2A], a
    jp soundFunction435B

.Label1834C ;06:434C
    ld a, $01
    ld [wDD28], a
    inc bc
    ld a, [bc]
    ld [wDD29], a
    inc bc
    ld a, [bc]
    ld [wDD2A], a
soundFunction435B:: ;06:435B
    ld a, $02
    ld [wSoundDD7B], a
    ld hl, wDD62
    ld de, soundFunction435B ;$435B
    ld [hl], e
    inc hl
    ld [hl], d
    ld a, [wSndChl3Vol]
    ld [wDD65], a
    ld hl, wWaveChannel
    ld de, rAUD3LEN
    call soundFunction44D4
    ld a, [wWaveChannel]
    and a, $01
    jp z, .Label1841B ;437D
    ld a, [wDD6F]
    and a
    jp nz, .Label1841B
    ld hl, wWaveChannel
    ld de, rAUD3LOW
    call soundFunction45A7
    ld hl, wDD3A
    ld de, wDD3B
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    ld de, rAUD3LEVEL
    call soundFunction446C
    ld de, wDD3B
    ld a, c
    ld [de], a
    ld a, b
    inc de
    ld [de], a
    ld hl, wDD3D
    ld de, wDD3E
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    ld de, wDD35
    call soundFunction4494
    ld de, wDD3E
    ld a, c
    ld [de], a
    ld a, b
    inc de
    ld [de], a
    ld a, [wDD40]
    and a
    jr z, .Label1841B
    dec a
    ld [wDD40], a
    and a
    jr nz, .Label1841B
    ld a, [wDD41]
    ld c, a
    ld a, [wDD42]
    ld b, a
    ld a, [bc]
    cp a, $FF
    jr z, .Label1840C ;43DA
    ld [wDD40], a
    inc bc
    ld a, [bc]
    ld e, a
    ld a, [wDD7E]
    add a, e
    push af
    ld de, Label1881B ;$481B
    add a, e
    ld e, a
    jr nc, .Label183EF
    inc d
.Label183EF
    ld a, [de]
    ld [wDD34], a
    pop af
    ld de, Label187BB ;$47BB
    add a, e
    ld e, a
    jr nc, .Label183FC
    inc d
.Label183FC
    ld a, [de]
    ld [wDD35], a
    inc bc
    ld a, c
    ld [wDD41], a
    ld a, b
    ld [wDD42], a
    jp .Label1841B
.Label1840C ;06:440C
    ld a, $01
    ld [wDD40], a
    inc bc
    ld a, [bc]
    ld [wDD41], a
    inc bc
    ld a, [bc]
    ld [wDD42], a
.Label1841B: ;441B
    ld a, $03
    ld [wSoundDD7B], a
    ld hl, wDD62
    ld de, .Label1841B ;$441B
    ld [hl], e
    inc hl
    ld [hl], d
    ld a, [wSndChl4Vol]
    ld [wDD65], a
    ld hl, wNoiseChannel
    ld de, rAUD4LEN
    call soundFunction44D4
    ld a, [wNoiseChannel]
    and a, $01
    jr z, .Label18462
    ld a, [wDD72]
    and a
    jp nz, .Label18462
    ld hl, wDD52
    ld de, wDD53
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    ld de, rAUD4ENV
    call soundFunction446C
    ld de, wDD53
    ld a, c
    ld [de], a
    ld a, b
    inc de
    ld [de], a
    call soundFunction45DE
.Label18462
    ld hl, wNoiseChannel
    ld de, rAUD4POLY
    call soundFunction45A7
    ret

soundFunction446C:: ;06:446C
    ld a, [hl]
    and a
    ret z
    dec [hl]
    ret nz
    ld a, [bc]
    cp a, $FF
    jr nz, soundFunction447A
    ld a, $00
    ld [hl], a
    ret

soundFunction447A:: ;06:447A
    ld [de], a
    inc bc
    ld a, [bc]
    ld [hl], a
    ld a, l
    sub a, $06
    ld l, a
    jr nc, .Label18485
    dec h
.Label18485
    ld a, [hl]
    or a, $80
    ld [hl], a
    ld a, l
    add a, $04
    ld l, a
    jr nc, .Label18490
    inc h
.Label18490
    ld a, [de]
    ld [hl], a
    inc bc
    ret

soundFunction4494:: ;06:4494
    ld a, [hl]
    and a
    ret z
    dec [hl]
    ret nz
    inc bc
    ld a, [bc]
    push hl
    ld [hl], a
    dec bc
    ld a, [de]
    ld l, a
    dec de
    ld a, [de]
    ld h, a
    ld a, [bc]
    cp a, $7E
    jr nz, soundFunction44AA
    pop hl
    ret

soundFunction44AA:: ;06:44AA
    cp a, $7D
    jr z, soundFunction44C7
    cp a, $7F
    jr nc, .Label184B9
    add a, l
    ld l, a
    jr nc, .Label184B7
    inc h
.Label184B7
    jr .Label184BE
.Label184B9
    add a, l
    ld l, a
    jr c, .Label184BE
    dec h
.Label184BE
    ld a, h
    ld [de], a
    inc de
    ld a, l
    ld [de], a
    inc bc
    inc bc
    pop hl
    ret

soundFunction44C7:: ;06:44C7
    inc bc
    ld a, [bc]
    push af
    inc bc
    ld a, [bc]
    ld b, a
    pop af
    ld c, a
    pop hl
    ld a, $01
    ld [hl], a
    ret

soundFunction44D4:: ;06:44D4
;hl: wram audio X length
;de, hram audio X length
    ld a, [hl]
    and a, %00000010
    ret z
    inc hl
    dec [hl]
    ret nz
    inc hl
    ld c, [hl] ;reads wDD02,wDD1A,wDD32,wDD4A
    inc hl
    ld b, [hl]
    ld a, [bc] ;5B59=24
    ld [wDD66], a
    and a, $7F
    cp a, $5F
    jp nc, Label18637
    push de
    ld de, wDD65
    ld a, [de]
    ld d, a
    ld a, [bc]
    and a, $7F
    add a, d
    ld d, a
    push af
    ld a, [wSoundDD7B]
    cp a, $00
    jr nz, .Label18501
    ld a, d
    ld [wDD7C], a
.Label18501
    cp a, $01
    jr nz, .Label18509
    ld a, d
    ld [wDD7D], a
.Label18509
    cp a, $02
    jr nz, .Label18511
    ld a, d
    ld [wDD7E], a
.Label18511
    pop af
    ld de, Label1881B ;$481B
    add a, e
    ld e, a
    jp nc, .Label1851B
    inc d
.Label1851B
    ld a, [de]
    inc hl
    ld [hl], a
    ld de, wDD65
    ld a, [de]
    ld d, a
    ld a, [bc]
    and a, $7F
    add a, d
    ld de, Label187BB ;$47BB
    add a, e
    ld e, a
    jr nc, .Label1852F
    inc d
.Label1852F
    ld a, [de]
    inc hl
    ld [hl], a
    inc bc
    ld a, [bc] ;5B5A=0A
    and a, $0F
    push hl
    ld hl, wDD61
    ld d, [hl]
    dec hl
    ld e, [hl]
    pop hl
    add a, e
    ld e, a
    jr nc, .Label18543
    inc d
.Label18543
    ld a, [de]
    ld de, $FFFC ;-4
    add hl, de
    ld [hl], a
    ld a, [wDD66]
    and a, $80
    srl a
    srl a
    ld d, a
    ld a, [bc] ;5B5A=0A
    and a, $F0
    srl a
    srl a
    srl a
    add a, d
    push hl
    ld hl, Label18A8F ;$4A8F
    add a, l
    ld l, a
    jr nc, .Label18566
    inc h
.Label18566
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    inc bc
    inc hl
    ld [hl], c
    inc hl
    ld [hl], b
    ld b, d
    ld c, e
    pop de
    inc hl
    ld a, [bc]
    or a, [hl]
    ld [hl], a
    inc hl
    inc hl
    inc hl
    inc bc
    ld a, [bc]
    ld [hl], a
    inc bc
    inc de
    inc hl
    ld a, [bc]
    ld [hl], a
    inc hl
    inc hl
    inc bc
    ld a, [bc]
    ld [hl], a
    inc hl
    inc bc
    ld a, [bc]
    ld [hl], a
    inc hl
    inc bc
    ld a, [bc]
    ld [hl], a
    inc hl
    inc bc
    ld a, [bc]
    ld [hl], a
    inc hl
    inc bc
    ld a, [bc]
    ld [hl], a
    inc hl
    inc bc
    ld a, [bc]
    ld [hl], a
    inc bc
    inc hl
    ld a, [bc]
    ld [hl], a
    inc bc
    inc hl
    ld a, [bc]
    ld [hl], a
    inc bc
    inc hl
    ld a, [bc]
    ld [hl], a
    ret

soundFunction45A7:: ;06:45A7
    ld a, [hl]
    and a, $01
    ret z
    ld bc, $5
    add hl, bc
    ld a, e
    cp a, $22
    jp z, soundFunction45D5
    ld a, [hl]
    ld [de], a
Label185B7::
    dec hl
    inc de
    push de
    push hl
    ld a, [hl]
    and a, $80
    jr z, .Label185CD
    ld bc, $3
    add hl, bc
    dec de
    dec de
    dec de
    ld a, [hl]
    ld [de], a
    inc hl
    inc de
    ld a, [hl]
    ld [de], a
.Label185CD
    pop hl
    pop de
    ld a, [hl]
    ld [de], a
    and a, $7F
    ld [hl], a
    ret

soundFunction45D5:: ;06:45D5
    ld a, [wDD64]
    ld [wDD4D], a
    ld [de], a
    jr Label185B7

soundFunction45DE:: ;06:45DE
    ld a, [wDD55]
    and a
    ret z
    dec a
    ld [wDD55], a
    and a
    ret nz
    ld a, [wDD56]
    ld l, a
    ld a, [wDD57]
    ld h, a
    ld a, [hl]
    cp a, $7E
    ret z
    cp a, $7D
    jr z, soundFunction460B
    ld [wDD64], a
    inc hl
    ld a, [hl]
    ld [wDD55], a
    inc hl
    ld a, l
    ld [wDD56], a
    ld a, h
    ld [wDD57], a
    ret

soundFunction460B:: ;06:460B
    ld a, $01
    ld [wDD55], a
    inc hl
    ld a, [hl]
    ld [wDD56], a
    inc hl
    ld a, [hl]
    ld [wDD57], a
    ret

Label1861B: ;06:461B
	dw Label1864B ;461C
	dw Label18667 ;461E
	dw Label18670 ;4620
	dw Label18681 ;4622
	dw Label18695 ;4624
	dw Label186E0 ;4626
	dw Label18719 ;4628
	dw enableSoundOutput ;462A
	dw Label18782 ;462C
	dw Label1879A ;462E
	dw Label18742 ;4630
	dw Label18752 ;4632
	dw Label18762 ;4634
	dw Label18772 ;4636

Label18637:: ;06:4637
;a: 67
    sub a, $60
    add a ;7+7 : E
    push hl
    dec hl
    dec hl
    inc [hl] ;[DD01]+1
    ld hl, Label1861B+1 ;$461C
    add a, l
    ld l, a
    jr nc, .Label18646
    inc h
.Label18646
    ld a, [hl]
    dec hl
    ld l, [hl]
    ld h, a
    jp [hl]

Label1864B:
    ld hl, wDD61
    ld a, [hl]
    dec hl
    ld l, [hl]
    ld h, a
    inc bc
    ld a, [bc]
    and a, $0F
    add a, l
    ld l, a
    jr .Label1865B
    inc h
.Label1865B
    ld a, [hl]
    pop hl
    ld de, $FFFE ;-2
    add hl, de
    ld [hl], a
    inc bc
    inc hl
    jp Label187AD

Label18667:: ;06:4667
    pop hl
    ld bc, $FFFD ;-3
    add hl, bc
    ld a, $00
    ld [hl], a
    ret
;4670

Label18670: ;06:4670
    pop hl
    ld de, $FFFE ;-2
    add hl, de
    ld a, $01
    ld [hli], a
    inc bc
    ld a, [bc]
    ld [hli], a
    inc bc
    ld a, [bc]
    ld [hl], a
    jp Label187B1
;4681

Label18681: ;4681
    pop hl
    inc bc
    ld a, [bc]
    ld [wDD64], a
    ld de, $FFFE ;-2
    add hl, de
    ld a, $01
    ld [hli], a
    inc bc
    call Label187AD
    jp Label187B1
;4695
Label18695: ;4695
    pop hl
    ld de, $FFFE ;-2
    add hl, de
    ld a, $01
    ld [hli], a
    inc bc
    ld a, [bc]
    sla a
    jr nc, Label186A9
    ld de, no_music ;$6D7C
    inc d
    jr Label186AC
Label186A9
    ld de, no_music ;$6D7C
Label186AC
    add a, e
    ld e, a
    jr nc, Label186B1
    inc d
Label186B1
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    ld d, h
    ld e, l
    ld a, $10
    add a, e
    ld e, a
    jr nc, Label186BF
    inc d
Label186BF
    inc bc
    ld a, [bc]
    ld [de], a
    inc de
    ld a, [de]
    and a
    jr z, Label186CA
    inc bc
    jr Label186D6
Label186CA
    ld a, $01
    ld [de], a
    dec de
    dec de
    inc bc
    ld a, [bc]
    sub a, $01
    ld [de], a
    inc de
    inc de
Label186D6
    inc bc
    inc de
    ld a, c
    ld [de], a
    inc de
    ld a, b
    ld [de], a
    jp Label187B1
;46E0

Label186E0: ;46E0
    inc bc
    pop hl
    ld de, $FFFE ;-2
    add hl, de
    ld a, $01
    ld [hli], a
    ld d, h
    ld e, l
    ld a, $11
    add a, e
    ld e, a
    jr nc, Label186F2
    inc d
Label186F2
    ld a, [de]
    and a
    jr z, Label1870A
    sub a, $01
    ld [de], a
    inc de
    inc de
    inc de
    ld a, [de]
    sub a, $04
    ld [hli], a
    inc de
    ld a, [de]
    jr nc, Label18706
    sub a, $01
Label18706
    ld [hl], a
    jp Label187B1
Label1870A
    inc de
    ld a, $00
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hl], a
    jp Label187B1
;4719

Label18719: ;4719
    inc bc
    ld a, [bc]
    ld [wDD67], a
    pop hl
    ld de, $FFFE ;-2
    add hl, de
    ld a, $01
    ld [hli], a
    inc bc
    call Label187AD
    jp Label187B1
;472D


enableSoundOutput: ;472D
    inc bc
    ld a, [bc] ;read 5B55=FF
    ld [rAUDTERM], a ;NR51 sound output
    ld [wNR51SoundOutput], a
Label18734
    inc bc ;5B57
    pop hl ;DD03
    ld de, $FFFE ;-2
    add hl, de ;DD01
    ld a, $01
    ld [hli], a
    call Label187AD
    jr Label187B1

Label18742: ;4742
    inc bc
    ld a, [wNR51SoundOutput]
    and a, $EE
    ld h, a
    ld a, [bc]
    or a, h
    ld [wNR51SoundOutput], a
    ld [rAUDTERM], a ;NR51 sound output
    jr Label18734

Label18752: ;4752
    inc bc
    ld a, [wNR51SoundOutput]
    and a, $DD
    ld h, a
    ld a, [bc]
    or a, h
    ld [wNR51SoundOutput], a
    ld [rAUDTERM], a ;NR51 sound output
    jr Label18734

Label18762: ;4762
    inc bc
    ld a, [wNR51SoundOutput]
    and a, $BB
    ld h, a
    ld a, [bc]
    or a, h
    ld [wNR51SoundOutput], a
    ld [rAUDTERM], a ;NR51 sound output
    jr Label18734

Label18772: ;4772
    inc bc
    ld a, [wNR51SoundOutput]
    and a, $77
    ld h, a
    ld a, [bc]
    or a, h
    ld [wNR51SoundOutput], a
    ld [rAUDTERM], a ;NR51 sound output
    jr Label18734
;4782

Label18782: ;4782
    inc bc
    ld a, [bc]
    ld [wDD60], a
    inc bc
    ld a, [bc]
    ld [wDD61], a
    pop hl
    ld de, $FFFE ;-2
    add hl, de
    ld a, $01
    ld [hli], a
    inc bc
    call Label187AD
    jr Label187B1

Label1879A: ;479A
    inc bc
    ld a, [bc] ;5B58=B4
    ld [wSoundDD78], a
    pop hl
    ld de, $FFFE ;-2
    add hl, de
    ld a, $01
    ld [hli], a
    inc bc
    call Label187AD
    jr Label187B1
;47AD

Label187AD: ;06:47AD
	ld [hl], c
	inc hl
	ld [hl], b
	ret
;47B1

Label187B1: ;06:47B1
    pop hl
    ld de, wDD62
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    jp [hl]
;47BB

Label187BB: ;47BB
	db $9D, $07, $6B, $CA, $23, $78, $C7, $12, $59, $9C, $DB, $17, $4F, $84, $B6, $E5
	db $12, $3C, $64, $89, $AD, $CE, $EE, $0C, $28, $42, $5B, $73, $89, $9E, $B2, $C5
	db $D7, $E7, $F7, $06, $14, $21, $2E, $3A, $45, $4F, $59, $63, $6C, $74, $7C, $83
	db $8A, $91, $97, $9D, $A3, $A8, $AD, $B1, $B6, $BA, $BE, $C2, $C5, $C9, $CC, $CF
	db $D2, $D4, $D7, $D9, $DB, $DD, $DF, $E1, $E3, $E5, $E6, $E8, $E9, $EA, $EC, $ED
	db $EE, $EF, $F0, $F1, $F2, $F3, $F3, $F4, $F5, $F5, $F7, $F7, $F8, $F8, $FA, $FA
;481B

Label1881B: ;481B
	db $00, $01, $01, $01, $02, $02, $02, $03, $03, $03, $03, $04, $04, $04, $04, $04
	db $05, $05, $05, $05, $05, $05, $05, $06, $06, $06, $06, $06, $06, $06, $06, $06
	db $06, $06, $06, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07
	db $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07
	db $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07
	db $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07
;487B

soundFunc487B:: ;06:487B
    ld hl, BaseSfxLookupTable ;$6E9E
    sla a
    add a, l
    ld l, a
    jr nc, .Label18885
    inc h
.Label18885
    ld a, [hl]
    ld c, a
    inc hl
    ld a, [hl]
    ld b, a
    ld a, $8F
    ld [rAUDENA], a ;NR52 sound on/off
    ld a, [bc]
    inc bc
    cp a, $01
    jr z, .Label188BD
    cp a, $02
    jr z, .Label188DE
    cp a, $03
    jr z, .Label188FF
    ld a, [wNR51SoundOutput]
    ld d, a
    ld a, $11
    or a, d
    ld [wLRSoundEnabler], a
    ld a, [wSqr1Channel]
    and a, $FE
    ld [wSqr1Channel], a
    ld a, c
    ld [wSoundDD68], a
    ld a, b
    ld [wDD69], a
    ld a, $02
    ld [wDD6A], a
    jr initSoundChannels
.Label188BD
    ld a, [wNR51SoundOutput]
    ld d, a
    ld a, $22
    or a, d
    ld [wLRSoundEnabler], a
    ld a, [wSqr2Channel]
    and a, $FE
    ld [wSqr2Channel], a
    ld a, c
    ld [wDD6B], a
    ld a, b
    ld [wDD6C], a
    ld a, $02
    ld [wDD6D], a
    jr initSoundChannels
.Label188DE
    ld a, [wNR51SoundOutput]
    ld d, a
    ld a, $44
    or a, d
    ld [wLRSoundEnabler], a
    ld a, [wWaveChannel]
    and a, $FE
    ld [wWaveChannel], a
    ld a, c
    ld [wDD6E], a
    ld a, b
    ld [wDD6F], a
    ld a, $02
    ld [wDD70], a
    jr initSoundChannels
.Label188FF
    ld a, [wNR51SoundOutput]
    ld d, a
    ld a, $88
    or a, d
    ld [wLRSoundEnabler], a
    ld a, [wNoiseChannel]
    and a, $FE
    ld [wNoiseChannel], a
    ld a, c
    ld [wDD71], a
    ld a, b
    ld [wDD72], a
    ld a, $02
    ld [wDD73], a
initSoundChannels::
    ld hl, wSqr1Channel
    ld a, l
    ld [wSoundDD74], a
    ld a, h
    ld [wSoundDD75], a
    ld hl, wSoundDD68
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, b
    or a, c
    jr z, .Label18939
    ld de, rAUD1LEN
    call soundFunction498B
.Label18939
    ld hl, wSqr2Channel
    ld a, l
    ld [wSoundDD74], a
    ld a, h
    ld [wSoundDD75], a
    ld hl, wDD6B
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, b
    or a, c
    jr z, .Label18954
    ld de, rAUD2LEN
    call soundFunction498B
.Label18954
    ld hl, wWaveChannel
    ld a, l
    ld [wSoundDD74], a
    ld a, h
    ld [wSoundDD75], a
    ld hl, wDD6E
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, b
    or a, c
    jr z, .Label1896F
    ld de, rAUD3LEN
    call soundFunction498B
.Label1896F
    ld hl, wNoiseChannel
    ld a, l
    ld [wSoundDD74], a
    ld a, h
    ld [wSoundDD75], a
    ld hl, wDD71
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, b
    or a, c
    jr z, .Label1898A
    ld de, rAUD4LEN
    call soundFunction498B
.Label1898A
    ret

soundFunction498B:: ;06:498B
	ld a, [wLRSoundEnabler]
	ld [rAUDTERM], a ;NR51
	inc hl
	dec [hl]
	jr z, soundFunction4995
	ret

soundFunction4995:: ;06:4995
    ld a, [bc]
    cp a, $FF
    jr z, soundFunction49B5
    cp a, $FE
    jr z, soundFunction49D1
    ld [hl], a
    inc bc
    ld a, [bc]
    ld [de], a
    inc bc
    inc de
    ld a, [bc]
    ld [de], a
    inc bc
    inc de
    inc de
    ld a, [bc]
    ld [de], a
    inc bc
    dec de
    ld a, [bc]
    ld [de], a
    inc bc

label189B0::
    dec hl
    ld [hl], b
    dec hl
    ld [hl], c
    ret

soundFunction49B5:: ;06:49B5
    ld a, $00
    dec hl
    ld [hl], a
    dec hl
    ld [hl], a
    ld hl, wSoundDD74
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, [bc]
    and a, $02
    jp z, .Label189CB
    ld a, [bc]
    or a, $01
    ld [bc], a
.Label189CB
    ld a, [wNR51SoundOutput]
    ld [rAUDTERM], a ;NR51 sound output
    ret

soundFunction49D1:: ;06:49D1
    inc bc
    ld a, [bc]
    ld e, a
    inc bc
    ld a, [bc]
    ld b, a
    ld c, e
    ld a, $01
    ld [hl], a
    jr label189B0
;49DD

soundData49DD::	;49DD
	db $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $00, $00, $00, $00, $00, $00, $00, $00
;49ED

INCLUDE "audio/musicChannelsTable.asm" ;49ED
;4A6F

Label18A6F: ;4A6F
	db $03, $04, $06, $09, $0C, $12, $18, $24, $30, $48, $60, $90, $C0, $08, $10, $2A
Label18A7F: ;4A7F
	db $04, $06, $08, $0C, $10, $18, $20, $30, $40, $60, $80, $C0, $FC, $05, $0A, $14
;4A8F

Label18A8F: ;4A8F
	dw Label18ACF
	dw Label18ADB
	dw Label18AE7
	dw Label18AF3
	dw Label18AFF
	dw Label18B0B
	dw Label18B17
	dw Label18B23
	dw Label18B2F
	dw Label18B3B
	dw Label18B47
	dw Label18B53
	dw Label18B5F
	dw Label18B6B
	dw Label18B77
	dw Label18B83
	dw Label18B8F
	dw Label18B9B
	dw Label18BA7
	dw Label18BB3
	dw Label18BBF
	dw Label18BCB
	dw Label18BD7
	dw Label18BE3
	dw Label18BEF
	dw Label18BFB
	dw Label18C07
	dw Label18C13
	dw Label18C1F
	dw Label18C2B
	dw Label18C37
	dw Label18C43
;4ACF




Label18ACF: ;06:4ACF
	dbw $80, $0200 ;ch1
	dbw $00, $0000 ;ch2
	dbw $00, $0000 ;ch3
	dbw $00, $0000 ;ch4
Label18ADB:
	dbw $C0, $00BD
	dbw $01, Label18C4F ;4C4F
	dbw $01, Label18D56 ;4D56
	dbw $00, $0000
Label18AE7:
	dbw $80, $0080
	dbw $01, Label18C58
	dbw $01, Label18D59
	dbw $00, $0000
Label18AF3:
	dbw $C0, $31BB
	dbw $00, $0000
	dbw $01, Label18D7A
	dbw $00, $0000
Label18AFF:
	dbw $C0, $41BB
	dbw $00, $0000
	dbw $01, Label18D7A
	dbw $00, $0000
Label18B0B:
	dbw $80, $0080
	dbw $01, Label18C63
	dbw $01, Label18D59
	dbw $00, $0000
Label18B17:
	dbw $80, $0080
	dbw $01, Label18CD1
	dbw $02, Label18DD1
	dbw $00, $0000
Label18B23:
	dbw $80, $0080
	dbw $01, Label18C8C
	dbw $01, Label18DBE
	dbw $00, $0000
Label18B2F:
	dbw $80, $2700
	dbw $00, $0000
	dbw $00, $0000
	dbw $01, Label18E55
Label18B3B:
	dbw $80, $0080
	dbw $01, Label18CA8
	dbw $00, $0000
	dbw $01, Label18E60
Label18B47:
	dbw $80, $3780
	dbw $00, $0000
	dbw $01, Label18DBE
	dbw $00, $0000
Label18B53:
	dbw $80, $9780
	dbw $00, $0000
	dbw $01, Label18DBE
	dbw $00, $0000
Label18B5F:
	dbw $80, $0080
	dbw $01, Label18CB5
	dbw $01, Label18DBE
	dbw $00, $0000
Label18B6B:
	dbw $80, $6280
	dbw $00, $0000
	dbw $01, Label18DD1
	dbw $00, $0000
Label18B77:
	dbw $80, $8080
	dbw $01, Label18CC4
	dbw $02, Label18DE4
	dbw $00, $0000
Label18B83:
	dbw $80, $8080
	dbw $01, Label18CD1
	dbw $02, Label18DE4
	dbw $00, $0000
Label18B8F:
	dbw $C0, $0000
	dbw $01, Label18D05
	dbw $00, $0000
	dbw $00, $0000
Label18B9B:
	dbw $C0, $0000
	dbw $01, Label18D10
	dbw $00, $0000
	dbw $00, $0000
Label18BA7:
	dbw $80, $0000
	dbw $01, Label18D19
	dbw $01, Label18E0A
	dbw $00, $0000
Label18BB3:
	dbw $80, $0080
	dbw $01, Label18CE4
	dbw $00, $0000
	dbw $01, Label18E90
Label18BBF:
	dbw $80, $6480
	dbw $00, $0000
	dbw $00, $0000
	dbw $01, Label18E9F
Label18BCB:
	dbw $80, $6480
	dbw $00, $0000
	dbw $00, $0000
	dbw $01, Label18EAE
Label18BD7:
	dbw $80, $0080
	dbw $01, Label18CE4
	dbw $00, $0000
	dbw $02, Label18EBD
Label18BE3:
	dbw $80, $5680
	dbw $00, $0000
	dbw $00, $0000
	dbw $01, Label18ECC
Label18BEF:
	dbw $80, $0000
	dbw $01, Label18D26
	dbw $01, Label18E0A
	dbw $00, $0000
Label18BFB:
	dbw $80, $0000
	dbw $01, Label18D26
	dbw $00, $0000
	dbw $00, $0000
Label18C07:
	dbw $80, $0040
	dbw $01, Label18CFC
	dbw $01, Label18DBE
	dbw $00, $0000
Label18C13:
	dbw $80, $0080
	dbw $01, Label18CD1
	dbw $00, $0000
	dbw $01, Label18E6D
Label18C1F:
	dbw $80, $0080
	dbw $01, Label18D3B
	dbw $00, $0000
	dbw $01, Label18EE6
Label18C2B:
	dbw $80, $0080
	dbw $01, Label18D44
	dbw $01, Label18E20
	dbw $00, $0000
Label18C37:
	dbw $80, $0080
	dbw $01, Label18D4D
	dbw $01, Label18E20
	dbw $00, $0000
Label18C43:
	dbw $80, $0080
	dbw $01, Label18CD1
	dbw $02, Label18DF7
	dbw $00, $0000
;4C4F

INCLUDE "audio/audio_4c4f.asm" ;4C4F
;4EF5

;music themes
INCLUDE "audio/music/unusedOriginalTheme01.asm" ;4EF5
INCLUDE "audio/music/unusedOriginalTheme02.asm" ;54A3
INCLUDE "audio/music/unusedOriginalTheme03.asm" ;5655
INCLUDE "audio/music/unusedOriginalTheme04.asm" ;5971
INCLUDE "audio/music/defaultMainTheme.asm" ;5B55
INCLUDE "audio/music/wanderingAboutTheme.asm" ;5E51
INCLUDE "audio/music/unusedOriginalTheme05.asm" ;5ECB
INCLUDE "audio/music/unusedOriginalTheme06.asm" ;6263
INCLUDE "audio/music/moonlightSonata.asm" ;65C2
INCLUDE "audio/music/moonlightSonataFail.asm" ;6708
INCLUDE "audio/music/vacantFlatTheme.asm" ;684E
INCLUDE "audio/music/unusedOriginalTheme07.asm" ;6BD6
INCLUDE "audio/music/noMusic.asm" ;6D79
;6E9E

INCLUDE "audio/baseSfxLookupTable.asm" ;6E9E
INCLUDE "audio/sfxLookupTable.asm"
INCLUDE "audio/baseSoundEffects.asm"

;06:7A57 rest of bank is empty

