
goToDisableSound:: ;06:4000
	jp clearSound

jumpToupdateSoundEffect:: ;06:4003
	jp updateSoundEffect

goToPlayMusicRoutine:: ;06:4006
	jp playMusicRoutine

updateMusic:: ;06:4009
	jp goToUpdateMusic

Label1800C: ;400C
    jp updateMusicRoutine
Label1800F: ;400F
    jp checkChannelsSfxUpdate
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
goToSetMusicTempo: ;4021
    jp setMusicTempo

goToPlaySFXRoutine:: ;06:4024
	jp playSFXRoutine

setMusicTempo:: ;06:4027
	ld [wSoundTempo], a
	ret

goToUpdateMusic::
	call updateMusicRoutine
	call checkChannelsSfxUpdate
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
    jr nc, .updateChannel1SFX
    inc h
.updateChannel1SFX
    ld a, [hl]
    cp a, $FF
    jr z, .updateChannel2SFX
    call callUpdateSoundEffect
.updateChannel2SFX
    inc hl
    ld a, [hl]
    cp a, $FF
    jr z, .updateChannel3SFX
    call callUpdateSoundEffect
.updateChannel3SFX
    inc hl
    ld a, [hl]
    cp a, $FF
    jr z, .updateChannel4SFX
    call callUpdateSoundEffect
.updateChannel4SFX
    inc hl
    ld a, [hl]
    cp a, $FF
    jr z, .endSfxUpdate
    call callUpdateSoundEffect
.endSfxUpdate
    ret

callUpdateSoundEffect:: ;06:40DD
	push hl ;store chl sfx addr
	call updateSoundEffect
	pop hl ;restore chl sfx addr
	ret

clearSound:: ;06:40E3
    ld a, %00000000
    ld [rAUDENA], a ;disable sound NR52
    nop
    ld [rAUDENA], a ;disable sound NR52
    ld [wChannel1SfxAddrLow], a
    ld [wChannel1SfxAddrHigh], a
    ld [wChannel2SfxAddrLow], a
    ld [wChannel2SfxAddrHigh], a
    ld [wChannel3SfxAddrLow], a
    ld [wChannel3SfxAddrHigh], a
    ld [wChannel4SfxAddrLow], a
    ld [wChannel4SfxAddrHigh], a
    ld [wChannel1State], a
    ld [wChannel2State], a
    ld [wChannel3State], a
    ld [wChannel4State], a
    ld a, $FF
    ld [wSoundTempo], a
    ld a, $01
    ld [wSoundTempoCounter], a
    ld de, _AUD3WAVERAM ;$FF30
    ld hl, cleanedWaveRam ;$49DD
    ld b, $10
.cleanWaveRamLoop
    ld a, [hl]
    ld [de], a
    inc hl
    inc de
    dec b
    jr nz, .cleanWaveRamLoop
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
    ld [wCh1NextActionAddrLow], a ;ch1 note addr low
    ld a, [hli]
    ld [wCh1NextActionAddrHigh], a ;ch1 note addr high
    ld a, [hli]
    ld [wCh2NextActionAddrLow], a ;ch2 note addr low
    ld a, [hli]
    ld [wCh2NextActionAddrHigh], a ;ch2 note addr high
    ld a, [hli]
    ld [wCh3NextActionAddrLow], a ;ch3 note addr low
    ld a, [hli]
    ld [wCh3NextActionAddrHigh], a ;ch3 note addr high
    ld a, [hli]
    ld [wCh4NextActionAddrLow], a ;ch4 note addr low
    ld a, [hli]
    ld [wCh4NextActionAddrHigh], a ;ch4 note addr high
    ld a, [hli]
    ld [wNoteLengthTableAddrLow], a ;note length table addr low
    ld a, [hli]
    ld [wNoteLengthTableAddrHigh], a ;note length table addr high
    ld a, $01
    ld [wCh1NoteLength], a ;ch1 note length counter
    ld [wCh2NoteLength], a ;ch2 note length counter
    ld a, $02
    ld [wCh3NoteLength], a
    ld [wCh4NoteLength], a
    ld a, $03
    ld [wChannel1State], a
    ld [wChannel2State], a
    ld [wChannel3State], a
    ld [wChannel4State], a
    ld [wNR50ChannelControl], a
    ld a, $FF
    ld [wSoundTempo], a ;tempo
    ld a, $01
    ld [wSoundTempoCounter], a ;tempo counter
initSound:: ;06:418B
    ld a, %10001111
    ld [rAUDENA], a ;enable NR52 sound
    nop
    nop
	ld [rAUDENA], a ;enable NR52 sound
    ld a, %00001000
    ld [rAUD1SWEEP], a ;sweep decrease (NR10)
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
    ld [wChl1ActionId], a
    ld [wChl2ActionId], a
    ld [wChl3ActionId], a
    ld [wChl4ActionId], a
    ld [wCh1DD15], a
    ld [wCh2DD2D], a
    ld [wCh3DD45], a
    ld [wCh4DD5D], a
    ld [wCh4PolyCounterTableTicks], a
    ret

updateMusicRoutine:: ;06:41CB
    ld a, [wNR50ChannelControl]
    and a
    ret z ;return if sound is disabled
    ld a, [wSoundTempo] ;get tempo
    ld b, a
    ld a, [wSoundTempoCounter] ;get tempo counter
    add a, b
    ld [wSoundTempoCounter], a
    ret nc
updateChannel1: ;41DC
    xor a
    ld [wChannelId], a ;set channel id
    ld hl, wChlUpdateFunctionAddrLow
    ld de, updateChannel1 ;$41DC
    ld [hl], e
    inc hl
    ld [hl], d
    ld a, [wChl1ActionId] ;get channel action id
    ld [wChannelActionId], a
    ld hl, wChannel1State
    ld de, rAUD1LEN
    call getChannelNoteData
    ld a, [wChannel1State]
    and a, $01
    jp z, updateChannel2 ;jump to next channel if chl1 is disabled
    ld a, [wChannel1SfxAddrHigh]
    and a
    jp nz, updateChannel2 ;jump if channel is playing sfx
    ld hl, wCh1EnvelopeTableTicks
    ld de, wCh1EnvelopeTableAddrLow
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    ld de, rAUD1ENV
    call checkChannelEnvelopeEffect
    ld de, wCh1EnvelopeTableAddrLow
    ld a, c
    ld [de], a
    ld a, b
    inc de
    ld [de], a
    ld hl, wChannel1State
    ld de, rAUD1LOW
    call updateChannelNote
    ld hl, wCh1PitchBendTableTicks
    ld de, wCh1PitchBendTableAddrLow
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    ld de, wCh1FreqLow
    call checkPitchBendEffect
    ld de, wCh1PitchBendTableAddrLow
    ld a, c
    ld [de], a
    ld a, b
    inc de
    ld [de], a
    ld a, [wCh1VibratoTableTicks]
    and a
    jr z, updateChannel2
    dec a
    ld [wCh1VibratoTableTicks], a
    and a
    jr nz, updateChannel2
    ld a, [wCh1VibratoTableAddrLow]
    ld c, a
    ld a, [wCh1VibratoTableAddrHigh]
    ld b, a
    ld a, [bc]
    cp a, $FF
    jr z, .channel1VibratoLoop
    ld [wCh1VibratoTableTicks], a
    inc bc
    ld a, [bc]
    ld e, a
    ld a, [wChl1CurrentNoteId]
    add a, e
    push af
    ld de, frequencyHighBitsTable ;$481B
    add a, e
    ld e, a
    jr nc, .Label1826F
    inc d
.Label1826F
    ld a, [de]
    ld [wCh1FreqHigh], a
    pop af
    ld de, frequencyLowBitsTable ;$47BB
    add a, e
    ld e, a
    jr nc, .Label1827C
    inc d
.Label1827C
    ld a, [de]
    ld [wCh1FreqLow], a
    inc bc
    ld a, c
    ld [wCh1VibratoTableAddrLow], a
    ld a, b
    ld [wCh1VibratoTableAddrHigh], a
    jp updateChannel2

.channel1VibratoLoop
    ld a, $01
    ld [wCh1VibratoTableTicks], a
    inc bc
    ld a, [bc]
    ld [wCh1VibratoTableAddrLow], a
    inc bc
    ld a, [bc]
    ld [wCh1VibratoTableAddrHigh], a
;429B

updateChannel2:: ;06:429B
    ld a, $01
    ld [wChannelId], a
    ld hl, wChlUpdateFunctionAddrLow
    ld de, updateChannel2 ;$429B
    ld [hl], e
    inc hl
    ld [hl], d
    ld a, [wChl2ActionId]
    ld [wChannelActionId], a
    ld hl, wChannel2State
    ld de, rAUD2LEN
    call getChannelNoteData
    ld a, [wChannel2State]
    and a, $01
    jp z, updateChannel3 ;jump to next channel if chl2 is disabled
    ld a, [wChannel2SfxAddrHigh]
    and a
    jp nz, updateChannel3 ;skip if channel is playing sfx
    ld hl, wCh2EnvelopeTableTicks ;envelope table counter var
    ld de, wCh2EnvelopeTableAddrLow ;envelope table addr low
;store envelope table address into bc
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    ld de, rAUD2ENV
    call checkChannelEnvelopeEffect
;store next env effect address
    ld de, wCh2EnvelopeTableAddrLow
    ld a, c
    ld [de], a
    ld a, b
    inc de
    ld [de], a
    ld hl, wChannel2State
    ld de, rAUD2LOW
    call updateChannelNote
    ld hl, wCh2PitchBendTableTicks ;pitch bend ticks counter var
    ld de, wCh2PitchBendTableAddrLow ;pitch bend table addr low
;store pitch bend table addr into bc
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    ld de, wCh2FreqLow ;chl freq low
    call checkPitchBendEffect
    ld de, wCh2PitchBendTableAddrLow
    ld a, c
    ld [de], a
    ld a, b
    inc de
    ld [de], a
;checkVibratoEffect
    ld a, [wCh2VibratoTableTicks] ;get vibrato effect ticks
    and a
    jr z, updateChannel3 ;skip if ticks is zero
    dec a ;decrese tick counter
    ld [wCh2VibratoTableTicks], a
    and a
    jr nz, updateChannel3 ;skip if effect is not over
;store vibrato effect addr into bc
    ld a, [wCh2VibratoTableAddrLow]
    ld c, a
    ld a, [wCh2VibratoTableAddrHigh]
    ld b, a
    ld a, [bc] ;get vibrato ticks
    cp a, $FF
    jr z, .channel2VibratoLoop
    ld [wCh2VibratoTableTicks], a ;update ticks
    inc bc
    ld a, [bc] ;get vibrato value
    ld e, a
    ld a, [wChl2CurrentNoteId] ;chl2 current note id
    add a, e ;add vibrato pitch offset
;get new note frequency
    push af
    ld de, frequencyHighBitsTable ;$481B
    add a, e
    ld e, a
    jr nc, .Label1832F
    inc d
.Label1832F
    ld a, [de]
    ld [wCh2FreqHigh], a ;set freq low bits
    pop af
    ld de, frequencyLowBitsTable ;$47BB
    add a, e
    ld e, a
    jr nc, .Label1833C
    inc d
.Label1833C
    ld a, [de]
    ld [wCh2FreqLow], a ;set freq high bits
;set next effect address
    inc bc
    ld a, c
    ld [wCh2VibratoTableAddrLow], a
    ld a, b
    ld [wCh2VibratoTableAddrHigh], a
    jp updateChannel3

.channel2VibratoLoop ;06:434C
    ld a, $01
    ld [wCh2VibratoTableTicks], a
    inc bc
    ld a, [bc]
    ld [wCh2VibratoTableAddrLow], a
    inc bc
    ld a, [bc]
    ld [wCh2VibratoTableAddrHigh], a


updateChannel3:: ;06:435B
    ld a, $02
    ld [wChannelId], a
    ld hl, wChlUpdateFunctionAddrLow
    ld de, updateChannel3 ;$435B
    ld [hl], e
    inc hl
    ld [hl], d
    ld a, [wChl3ActionId]
    ld [wChannelActionId], a
    ld hl, wChannel3State
    ld de, rAUD3LEN
    call getChannelNoteData
    ld a, [wChannel3State]
    and a, $01
    jp z, updateChannel4 ;437D
    ld a, [wChannel3SfxAddrHigh]
    and a
    jp nz, updateChannel4
    ld hl, wChannel3State
    ld de, rAUD3LOW
    call updateChannelNote
    ld hl, wCh3EnvelopeTableTicks
    ld de, wCh3EnvelopeTableAddrLow
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    ld de, rAUD3LEVEL
    call checkChannelEnvelopeEffect
    ld de, wCh3EnvelopeTableAddrLow
    ld a, c
    ld [de], a
    ld a, b
    inc de
    ld [de], a
    ld hl, wCh3PitchBendTableTicks
    ld de, wCh3PitchBendTableAddrLow
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    ld de, wCh3FreqLow
    call checkPitchBendEffect
    ld de, wCh3PitchBendTableAddrLow
    ld a, c
    ld [de], a
    ld a, b
    inc de
    ld [de], a
;checkVibratoEffect
    ld a, [wCh3VibratoTableTicks]
    and a
    jr z, updateChannel4
    dec a
    ld [wCh3VibratoTableTicks], a
    and a
    jr nz, updateChannel4
    ld a, [wCh3VibratoTableAddrLow]
    ld c, a
    ld a, [wCh3VibratoTableAddrHigh]
    ld b, a
    ld a, [bc]
    cp a, $FF
    jr z, .channel3VibratoLoop
    ld [wCh3VibratoTableTicks], a
    inc bc
    ld a, [bc]
    ld e, a
    ld a, [wChl3CurrentNoteId]
    add a, e
    push af
    ld de, frequencyHighBitsTable ;$481B
    add a, e
    ld e, a
    jr nc, .Label183EF
    inc d
.Label183EF
    ld a, [de]
    ld [wCh3FreqHigh], a
    pop af
    ld de, frequencyLowBitsTable ;$47BB
    add a, e
    ld e, a
    jr nc, .Label183FC
    inc d
.Label183FC
    ld a, [de]
    ld [wCh3FreqLow], a
    inc bc
    ld a, c
    ld [wCh3VibratoTableAddrLow], a
    ld a, b
    ld [wCh3VibratoTableAddrHigh], a
    jp updateChannel4

.channel3VibratoLoop ;06:440C
    ld a, $01
    ld [wCh3VibratoTableTicks], a
    inc bc
    ld a, [bc]
    ld [wCh3VibratoTableAddrLow], a
    inc bc
    ld a, [bc]
    ld [wCh3VibratoTableAddrHigh], a


updateChannel4: ;441B
    ld a, $03
    ld [wChannelId], a
;store chl update addr in vars
    ld hl, wChlUpdateFunctionAddrLow
    ld de, updateChannel4 ;$441B
    ld [hl], e
    inc hl
    ld [hl], d
    ld a, [wChl4ActionId]
    ld [wChannelActionId], a
    ld hl, wChannel4State
    ld de, rAUD4LEN
    call getChannelNoteData
    ld a, [wChannel4State]
    and a, $01 ;skip if channel is disabled
    jr z, .updatePolyCounter
    ld a, [wChannel4SfxAddrHigh]
    and a ;skip if channel is sfx
    jp nz, .updatePolyCounter
    ld hl, wCh4EnvelopeTableTicks
    ld de, wCh4EnvelopeTableAddrLow
;envelope table addr into bc
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    ld de, rAUD4ENV
    call checkChannelEnvelopeEffect
;update next env. effect addr.
    ld de, wCh4EnvelopeTableAddrLow
    ld a, c
    ld [de], a
    ld a, b
    inc de
    ld [de], a
    call checkPolynomialCounterEffect
.updatePolyCounter
    ld hl, wChannel4State
    ld de, rAUD4POLY
    call updateChannelNote
    ret

checkChannelEnvelopeEffect:: ;06:446C
;hl: envelope ticks counter
;de: channel hardware envelope address
;bc: table counter addr
    ld a, [hl]
    and a
    ret z ;return if end counter
    dec [hl] ;decrease env. counter
    ret nz ;return if there're ticks yet
;if effect ticks finish, apply next envelope effect
    ld a, [bc] ;get envelope value
    cp a, $FF
    jr nz, applyEnvelopeEffect
    ld a, $00
    ld [hl], a ;set counter to zero
    ret

applyEnvelopeEffect:: ;06:447A
    ld [de], a
    inc bc
    ld a, [bc] ;get effect ticks
    ld [hl], a
    ld a, l
    sub a, $06 ;back to frequency high var
    ld l, a
    jr nc, .Label18485
    dec h
.Label18485
    ld a, [hl]
    or a, %10000000 ;$80 restart channel
    ld [hl], a
    ld a, l
    add a, $04 ;go to channel envelope var
    ld l, a
    jr nc, .Label18490
    inc h
.Label18490
    ld a, [de]
    ld [hl], a ;store envelope into channel var
    inc bc ;next effect
    ret

checkPitchBendEffect:: ;06:4494
;hl: pitch bend ticks counter
;bc: pitch bend table addr
;de: channel freq low
    ld a, [hl]
    and a
    ret z ;return if no ticks left
    dec [hl] ;decrease effect ticks
    ret nz ;return if effect is not over yet
    inc bc
    ld a, [bc] ;get ticks value
    push hl ;store ticks counter
    ld [hl], a ;store ticks value
    dec bc ;set pitch bend value pointer
    ld a, [de] ;get freq low value
    ld l, a
    dec de
    ld a, [de] ;get freq high value
    ld h, a
    ld a, [bc] ;get pitch bend value
    cp a, $7E ;check if effect table end
    jr nz, applyPitchBendEffect
    pop hl ;restore ticks counter
    ret

applyPitchBendEffect:: ;06:44AA
;a: pitch bend value
;hl: channel frequency value
    cp a, $7D ;check if effect table loop
    jr z, setPitchBendTableLoop
    cp a, $7F
    jr nc, .pitchBendDown
;pitchBendUp
    add a, l
    ld l, a
    jr nc, .Label184B7
    inc h
.Label184B7
    jr .updateFreqVars
.pitchBendDown
    add a, l
    ld l, a
    jr c, .updateFreqVars
    dec h
.updateFreqVars
    ld a, h
    ld [de], a ;update note frequency high
    inc de
    ld a, l
    ld [de], a ;update note frequency low
    inc bc
    inc bc
    pop hl
    ret

setPitchBendTableLoop:: ;06:44C7
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
    ld [hl], a ;restart ticks value
    ret

getChannelNoteData:: ;06:44D4
;get note value, if is a valid note value,
;gets its frequency and instruments effects values
    ld a, [hl] ;channel state
    and a, %00000010
    ret z
    inc hl
    dec [hl]
    ret nz
    inc hl
    ld c, [hl] ;reads channel action id addr low
    inc hl
    ld b, [hl] ;reads channel action id addr high
    ld a, [bc] ;read channel action id
    ld [wDD66], a
    and a, %01111111 ;$7F mask action id
    cp a, $5F ;channel actions
    jp nc, checkChannelAction
	;if note id
    push de ;store channel length register
    ld de, wChannelActionId
    ld a, [de] ;get branch tsp value
    ld d, a
    ld a, [bc]
    and a, %01111111 ;$7F get note id
    add a, d ;add tsp to note id
    ld d, a
    push af
    ld a, [wChannelId] ;get channel id
;store channel current played note
;if channel 1
    cp a, $00
    jr nz, .Label18501
    ld a, d
    ld [wChl1CurrentNoteId], a
;if channel 2
.Label18501
    cp a, $01
    jr nz, .Label18509
    ld a, d
    ld [wChl2CurrentNoteId], a
;if channel 3
.Label18509
    cp a, $02
    jr nz, .Label18511
    ld a, d
    ld [wChl3CurrentNoteId], a
.Label18511
    pop af ;restore note id
;get note frequency high bits
    ld de, frequencyHighBitsTable ;$481B
    add a, e
    ld e, a
    jp nc, .Label1851B
    inc d
.Label1851B
    ld a, [de]
    inc hl
    ld [hl], a ;store freq high bits
;get frequency low bits
    ld de, wChannelActionId
    ld a, [de]
    ld d, a
    ld a, [bc]
    and a, %01111111 ;$7F
    add a, d
    ld de, frequencyLowBitsTable ;$47BB
    add a, e
    ld e, a
    jr nc, .Label1852F
    inc d
.Label1852F
    ld a, [de]
    inc hl
    ld [hl], a ;store freq low bits
    inc bc
    ld a, [bc] ;get instrument & note length byte
    and a, $0F ;mask note length id
    push hl ;store freq var
    ld hl, wNoteLengthTableAddrHigh
    ld d, [hl]
    dec hl
    ld e, [hl]
    pop hl
    add a, e ;add note length offset
    ld e, a
    jr nc, .Label18543
    inc d
.Label18543
    ld a, [de] ;get note length
    ld de, $FFFC ;-4
    add hl, de
    ld [hl], a ;store note length
    ld a, [wDD66] ;get raw note id
    and a, %10000000 ;$80 get instrument table bit
    srl a
    srl a
    ld d, a
    ld a, [bc] ;get instrument & note length byte
    and a, $F0 ;get instrument id
    srl a
    srl a
    srl a
    add a, d ;add instrumnet id offset to table id
    push hl
    ld hl, instrumentsTables ;$4A8F
    add a, l
    ld l, a
    jr nc, .getInstrumentAddress
    inc h
.getInstrumentAddress
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    inc bc ;next music note addr
    inc hl ;next music note addr vars
    ld [hl], c
    inc hl
    ld [hl], b
;read and set intrument values
    ld b, d ;store inst addr into bc
    ld c, e
    pop de ;restore chl init & sound length register high
    inc hl ;get note freq high var
    ld a, [bc]
    or a, [hl] ;add restart chl bit (80)
    ld [hl], a
    inc hl
    inc hl
    inc hl ;offset to chl wave pattern var
    inc bc ;offset to next intrument byte (wave pattern value)
    ld a, [bc]
    ld [hl], a ;store wave pattern byte
    inc bc ;inst chl envelope byte
    inc de ;get chl envelope register
    inc hl ;chl envelope var
    ld a, [bc]
    ld [hl], a ;store envelope
    inc hl
    inc hl ;envelope table counter var
    inc bc
    ld a, [bc]
    ld [hl], a ;store envelope table counter
    inc hl
    inc bc
    ld a, [bc]
    ld [hl], a ;store envelope table addr low
    inc hl
    inc bc
    ld a, [bc]
    ld [hl], a ;store envelope table addr high
    inc hl
    inc bc
    ld a, [bc]
    ld [hl], a ;store pitch bend table counter
    inc hl
    inc bc
    ld a, [bc]
    ld [hl], a ;store pitch bend table addr low
    inc hl
    inc bc
    ld a, [bc]
    ld [hl], a ;store pitch bend table addr high
    inc bc
    inc hl
    ld a, [bc]
    ld [hl], a ;store tsp table counter
    inc bc
    inc hl
    ld a, [bc]
    ld [hl], a ;store tsp table addr low
    inc bc
    inc hl
    ld a, [bc]
    ld [hl], a ;store tsp table addr high
    ret

updateChannelNote:: ;06:45A7
;hl: channel state
;de: channel freq low
    ld a, [hl]
    and a, $01
    ret z ;return if channel is disabled
    ld bc, $5
    add hl, bc ;go to channel freq low var
    ld a, e
    cp a, $22 ;check if ch4 poly counter
    jp z, setNoisePolyCounter
    ld a, [hl]
    ld [de], a ;set chl freq low
Label185B7:
    dec hl ;get freq high var
    inc de ;get chl freq high register (or Noise Counter/consecutive)
    push de ;store register
    push hl ;store freq high var
    ld a, [hl]
    and a, $80
    jr z, .Label185CD ;jump if channel is not initialized
    ld bc, $3
    add hl, bc ;get wave pattern var
    dec de
    dec de
    dec de ;get wave pattern register (or sound length)
    ld a, [hl]
    ld [de], a ;set wave pattern value
    inc hl ;get envelope var
    inc de ;get env. register (or wave sound levels)
    ld a, [hl]
    ld [de], a ;set chl envelope
.Label185CD
    pop hl ;get freq high var
    pop de ;get freq register
    ld a, [hl]
    ld [de], a ;set frequency high
    and a, $7F
    ld [hl], a ;store freq high value
    ret

setNoisePolyCounter:: ;06:45D5
    ld a, [wNoisePolyCounterValue] ;get poly counter
    ld [wCh4PolyCounter], a ;store noise poly counter var
    ld [de], a ;set noise poly counter
    jr Label185B7

checkPolynomialCounterEffect:: ;06:45DE
    ld a, [wCh4PolyCounterTableTicks] ;poly counter ticks
    and a
    ret z
    dec a ;decrease ticks
    ld [wCh4PolyCounterTableTicks], a
    and a
    ret nz ;return if effect is not over yet
    ld a, [wCh4PolyCounterTableAddrLow]
    ld l, a
    ld a, [wCh4PolyCounterTableAddrHigh]
    ld h, a
    ld a, [hl] ;get value
    cp a, $7E
    ret z
    cp a, $7D
    jr z, setPolyCounterEffectLoop
    ld [wNoisePolyCounterValue], a
    inc hl
    ld a, [hl]
    ld [wCh4PolyCounterTableTicks], a
    inc hl
    ld a, l
    ld [wCh4PolyCounterTableAddrLow], a
    ld a, h
    ld [wCh4PolyCounterTableAddrHigh], a
    ret

setPolyCounterEffectLoop:: ;06:460B
    ld a, $01
    ld [wCh4PolyCounterTableTicks], a
    inc hl
    ld a, [hl]
    ld [wCh4PolyCounterTableAddrLow], a
    inc hl
    ld a, [hl]
    ld [wCh4PolyCounterTableAddrHigh], a
    ret

channelActionsTable: ;06:461B channel actions table
	dw setNoteLength ;461C
	dw disableChannel ;461E
	dw setChannelLoop ;4620
	dw setPolyCounterValue ;4622
	dw setBranchAdress ;4624
	dw setBranchEnd ;4626
	dw chlAction18719 ;4628
	dw setGlobalSoundOutput ;462A
	dw setChannelLengthTableAddr ;462C
	dw setSoundTempo ;462E
	dw setSoundOutput1 ;4630
	dw setSoundOutput2 ;4632
	dw setSoundOutput3 ;4634
	dw setSoundOutput4 ;4636

checkChannelAction:: ;06:4637
;a: action id
;bc: action addr
    sub a, $60
    add a
    push hl ;store action id addr high
    dec hl
    dec hl ;go to length counter
    inc [hl] ;inc length
    ld hl, channelActionsTable+1 ;$461C
    add a, l
    ld l, a
    jr nc, .Label18646
    inc h
.Label18646
    ld a, [hl]
    dec hl
    ld l, [hl]
    ld h, a
    jp hl

setNoteLength:
    ld hl, wNoteLengthTableAddrHigh
    ld a, [hl]
    dec hl
    ld l, [hl]
    ld h, a ;length table addr into hl
    inc bc
    ld a, [bc] ;get length id
    and a, $0F
    add a, l
    ld l, a
    jr .Label1865B
    inc h
.Label1865B
    ld a, [hl] ;get length value
    pop hl
    ld de, $FFFE ;-2
    add hl, de ;go to channel note length var
    ld [hl], a ;set length
    inc bc ;next action
    inc hl
    jp storeChannelNextActionAddr

disableChannel:: ;06:4667
    pop hl ;action id addr high
    ld bc, $FFFD ;-3
    add hl, bc ;get channel state
    ld a, $00
    ld [hl], a ;disable channel
    ret
;4670

setChannelLoop: ;06:4670
    pop hl
    ld de, $FFFE ;-2
    add hl, de ;get chl note length
    ld a, $01
    ld [hli], a ;reset channel ticks
    inc bc
    ld a, [bc] ;get loop chl addr low
    ld [hli], a
    inc bc
    ld a, [bc] ;get loop chl addr high
    ld [hl], a
    jp goToNextChannelUpdateAddr
;4681

setPolyCounterValue: ;4681
    pop hl ;action/note id addr high
    inc bc
    ld a, [bc] ;get action parameter
    ld [wNoisePolyCounterValue], a
    ld de, $FFFE ;-2
    add hl, de ;go to chl length
    ld a, $01
    ld [hli], a ;reset length
    inc bc
    call storeChannelNextActionAddr
    jp goToNextChannelUpdateAddr
;4695

setBranchAdress: ;4695
    pop hl ;action/note id addr high
    ld de, $FFFE ;-2
    add hl, de
    ld a, $01
    ld [hli], a ;reset length
    inc bc
    ld a, [bc] ;get branch id
    sla a
    jr nc, Label186A9
    ld de, music_branches_table ;$6D7C
    inc d
    jr Label186AC
Label186A9
    ld de, music_branches_table ;$6D7C
Label186AC
;add branch id offset
    add a, e
    ld e, a
    jr nc, getBranchAddress
    inc d
getBranchAddress ;and update next action address
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    ld d, h
    ld e, l ;action id addr high to de
    ld a, $10
    add a, e ;go to channel action id var
    ld e, a
    jr nc, Label186BF
    inc d
Label186BF
    inc bc
    ld a, [bc] ;get branch tsp value
    ld [de], a
    inc de
    ld a, [de]
    and a
    jr z, Label186CA
    inc bc
    jr backupNextActionAddress
Label186CA
    ld a, $01
    ld [de], a
    dec de
    dec de
    inc bc
    ld a, [bc] ;get branch counter
    sub a, $01
    ld [de], a
    inc de
    inc de
backupNextActionAddress
    inc bc
    inc de
    ld a, c
    ld [de], a
    inc de
    ld a, b
    ld [de], a
    jp goToNextChannelUpdateAddr
;46E0

setBranchEnd: ;46E0
    inc bc ;action parameter
    pop hl ;action/note id addr high
    ld de, $FFFE ;-2
    add hl, de
    ld a, $01
    ld [hli], a ;reset length
    ld d, h ;note address into de
    ld e, l
    ld a, $11 ;go to branch counter
    add a, e
    ld e, a
    jr nc, Label186F2
    inc d
Label186F2
    ld a, [de] ;get branch counter
    and a
    jr z, Label1870A
    sub a, $01
    ld [de], a ;decrease counter
    inc de
    inc de
    inc de
    ld a, [de] ;get next channel action addr
;repeat branch action address
    sub a, $04 ;back to current branch address
    ld [hli], a
    inc de
    ld a, [de]
    jr nc, Label18706
    sub a, $01
Label18706
    ld [hl], a
    jp goToNextChannelUpdateAddr
Label1870A
    inc de
    ld a, $00
    ld [de], a ;reset action id
    inc de
    ld [de], a ;reset DD2D
    inc de
;restore next channel action
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hl], a
    jp goToNextChannelUpdateAddr
;4719

chlAction18719: ;4719
    inc bc ;action parameter
    ld a, [bc]
    ld [wDD67], a ;value aparently never used
    pop hl ;action id addr high
    ld de, $FFFE ;-2
    add hl, de ;back to note length counter
    ld a, $01
    ld [hli], a ;set length
    inc bc ;next channel instruccion
    call storeChannelNextActionAddr
    jp goToNextChannelUpdateAddr
;472D


setGlobalSoundOutput: ;472D
    inc bc
    ld a, [bc] ;get sound enabler value
    ld [rAUDTERM], a ;set sound output
    ld [wNR51SoundOutput], a
goToNextChannelAction:
    inc bc ;next action
    pop hl ;;action id addr high
    ld de, $FFFE ;-2
    add hl, de
    ld a, $01
    ld [hli], a ;set length
    call storeChannelNextActionAddr
    jr goToNextChannelUpdateAddr

setSoundOutput1: ;4742
    inc bc
    ld a, [wNR51SoundOutput]
    and a, %11101110 ;$EE disable SO1
    ld h, a
    ld a, [bc]
    or a, h
    ld [wNR51SoundOutput], a
    ld [rAUDTERM], a ;NR51 sound output
    jr goToNextChannelAction

setSoundOutput2: ;4752
    inc bc
    ld a, [wNR51SoundOutput]
    and a, %11011101 ;$DD disable SO2
    ld h, a
    ld a, [bc]
    or a, h
    ld [wNR51SoundOutput], a
    ld [rAUDTERM], a ;NR51 sound output
    jr goToNextChannelAction

setSoundOutput3: ;4762
    inc bc
    ld a, [wNR51SoundOutput]
    and a, %10111011 ;$BB disable SO2
    ld h, a
    ld a, [bc]
    or a, h
    ld [wNR51SoundOutput], a
    ld [rAUDTERM], a ;NR51 sound output
    jr goToNextChannelAction

setSoundOutput4: ;4772
    inc bc
    ld a, [wNR51SoundOutput]
    and a, %01110111 ;$77 disable SO2
    ld h, a
    ld a, [bc]
    or a, h
    ld [wNR51SoundOutput], a
    ld [rAUDTERM], a ;NR51 sound output
    jr goToNextChannelAction
;4782

setChannelLengthTableAddr: ;4782
    inc bc
    ld a, [bc] ;get length table addr low
    ld [wNoteLengthTableAddrLow], a
    inc bc
    ld a, [bc] ;get length table addr high
    ld [wNoteLengthTableAddrHigh], a
    pop hl
    ld de, $FFFE ;-2
    add hl, de
    ld a, $01
    ld [hli], a ;set length
    inc bc
    call storeChannelNextActionAddr
    jr goToNextChannelUpdateAddr

setSoundTempo: ;479A
    inc bc
    ld a, [bc] ;get tempo value
    ld [wSoundTempo], a
    pop hl
    ld de, $FFFE ;-2
    add hl, de
    ld a, $01
    ld [hli], a ;set length
    inc bc
    call storeChannelNextActionAddr
    jr goToNextChannelUpdateAddr
;47AD

storeChannelNextActionAddr: ;06:47AD
	ld [hl], c
	inc hl
	ld [hl], b
	ret
;47B1

goToNextChannelUpdateAddr: ;06:47B1
    pop hl ;delete next channel update addr from stack
    ld de, wChlUpdateFunctionAddrLow
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    jp hl
;47BB

frequencyLowBitsTable: ;47BB sound frequency low bits table (64bytes)
	db $9D, $07, $6B, $CA, $23, $78, $C7, $12, $59, $9C, $DB, $17, $4F, $84, $B6, $E5
	db $12, $3C, $64, $89, $AD, $CE, $EE, $0C, $28, $42, $5B, $73, $89, $9E, $B2, $C5
	db $D7, $E7, $F7, $06, $14, $21, $2E, $3A, $45, $4F, $59, $63, $6C, $74, $7C, $83
	db $8A, $91, $97, $9D, $A3, $A8, $AD, $B1, $B6, $BA, $BE, $C2, $C5, $C9, $CC, $CF
	db $D2, $D4, $D7, $D9, $DB, $DD, $DF, $E1, $E3, $E5, $E6, $E8, $E9, $EA, $EC, $ED
	db $EE, $EF, $F0, $F1, $F2, $F3, $F3, $F4, $F5, $F5, $F7, $F7, $F8, $F8, $FA, $FA
;481B

frequencyHighBitsTable: ;481B sound frequency high bits table(channels 1,2,3)
	db $00, $01, $01, $01, $02, $02, $02, $03, $03, $03, $03, $04, $04, $04, $04, $04
	db $05, $05, $05, $05, $05, $05, $05, $06, $06, $06, $06, $06, $06, $06, $06, $06
	db $06, $06, $06, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07
	db $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07
	db $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07
	db $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07
;487B



updateSoundEffect:: ;06:487B
    ld hl, BaseSfxLookupTable ;$6E9E
;get sound effect address
    sla a
    add a, l
    ld l, a
    jr nc, .Label18885
    inc h
.Label18885
    ld a, [hl]
    ld c, a
    inc hl
    ld a, [hl] ;store sfx addr in bc
    ld b, a
    ld a, %10001111 ;$8F
    ld [rAUDENA], a ;enable all sound
    ld a, [bc] ;get sfx channel id
    inc bc
    cp a, $01
    jr z, .updatePulse2Sfx
    cp a, $02
    jr z, .updateWaveSfx
    cp a, $03
    jr z, .updateNoiseSfx
;updatePulse1Sfx
    ld a, [wNR51SoundOutput]
    ld d, a
    ld a, %00010001 ;$11
    or a, d
    ld [wLRSoundEnabler], a  ;enable sound 1
    ld a, [wChannel1State]
    and a, %11111110 ;$FE
    ld [wChannel1State], a
;store sfx value address
    ld a, c
    ld [wChannel1SfxAddrLow], a
    ld a, b
    ld [wChannel1SfxAddrHigh], a
    ld a, $02
    ld [wChannel1SfxCounter], a
    jr checkChannelsSfxUpdate
.updatePulse2Sfx
    ld a, [wNR51SoundOutput]
    ld d, a
    ld a, %00100010 ;$22
    or a, d
    ld [wLRSoundEnabler], a
    ld a, [wChannel2State]
    and a, %11111110 ;$FE
    ld [wChannel2State], a
    ld a, c
    ld [wChannel2SfxAddrLow], a
    ld a, b
    ld [wChannel2SfxAddrHigh], a
    ld a, $02
    ld [wChannel2SfxCounter], a
    jr checkChannelsSfxUpdate
.updateWaveSfx
    ld a, [wNR51SoundOutput]
    ld d, a
    ld a, %01000100 ;$44
    or a, d
    ld [wLRSoundEnabler], a
    ld a, [wChannel3State]
    and a, %11111110 ;$FE
    ld [wChannel3State], a
    ld a, c
    ld [wChannel3SfxAddrLow], a
    ld a, b
    ld [wChannel3SfxAddrHigh], a
    ld a, $02
    ld [wChannel3SfxCounter], a
    jr checkChannelsSfxUpdate
.updateNoiseSfx
    ld a, [wNR51SoundOutput]
    ld d, a
    ld a, %10001000 ;$88
    or a, d
    ld [wLRSoundEnabler], a
    ld a, [wChannel4State]
    and a, %11111110 ;$FE
    ld [wChannel4State], a
    ld a, c
    ld [wChannel4SfxAddrLow], a
    ld a, b
    ld [wChannel4SfxAddrHigh], a
    ld a, $02
    ld [wChannel4SfxCounter], a

checkChannelsSfxUpdate::
    ld hl, wChannel1State
    ld a, l
    ld [wChannelStateVarAddrLow], a
    ld a, h
    ld [wChannelStateVarAddrHigh], a
    ld hl, wChannel1SfxAddrLow
;get channel sfx addr
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, b
    or a, c
    jr z, .Label18939 ;skip if no sfx addr
    ld de, rAUD1LEN
    call checkSfxUpdate
.Label18939
    ld hl, wChannel2State
    ld a, l
    ld [wChannelStateVarAddrLow], a
    ld a, h
    ld [wChannelStateVarAddrHigh], a
    ld hl, wChannel2SfxAddrLow
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, b
    or a, c
    jr z, .Label18954
    ld de, rAUD2LEN
    call checkSfxUpdate
.Label18954
    ld hl, wChannel3State
    ld a, l
    ld [wChannelStateVarAddrLow], a
    ld a, h
    ld [wChannelStateVarAddrHigh], a
    ld hl, wChannel3SfxAddrLow
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, b
    or a, c
    jr z, .Label1896F
    ld de, rAUD3LEN
    call checkSfxUpdate
.Label1896F
    ld hl, wChannel4State
    ld a, l
    ld [wChannelStateVarAddrLow], a
    ld a, h
    ld [wChannelStateVarAddrHigh], a
    ld hl, wChannel4SfxAddrLow
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, b
    or a, c
    jr z, .Label1898A
    ld de, rAUD4LEN
    call checkSfxUpdate
.Label1898A
    ret

checkSfxUpdate:: ;06:498B
	ld a, [wLRSoundEnabler]
	ld [rAUDTERM], a ;NR51
	inc hl
	dec [hl] ;decrease sfx counter
	jr z, updateSfxValues
	ret

updateSfxValues:: ;06:4995
    ld a, [bc] ;get sfx value
    cp a, $FF
    jr z, finishChannelSfxPlay
    cp a, $FE
    jr z, setSoundEffectBranch
    ld [hl], a ;set sfx counter
    inc bc
    ld a, [bc]
    ld [de], a ;set rAUDXLEN
    inc bc
    inc de
    ld a, [bc]
    ld [de], a ;set rAUDXENV
    inc bc
    inc de
    inc de
    ld a, [bc]
    ld [de], a ;set rAUDXHIGH or rAUD4GO
    inc bc
    dec de
    ld a, [bc]
    ld [de], a ;set rAUDXLOW or rAUD4POLY
    inc bc
setNextSfxAddress:
    dec hl
    ld [hl], b
    dec hl
    ld [hl], c
    ret

finishChannelSfxPlay:: ;06:49B5
    ld a, $00
    dec hl
    ld [hl], a ;set sfx address to zero
    dec hl
    ld [hl], a
    ld hl, wChannelStateVarAddrLow
    ld c, [hl] ;get channel state var pointer in bc
    inc hl
    ld b, [hl]
    ld a, [bc]
    and a, $02
    jp z, .Label189CB ;if channel is not busy
    ld a, [bc]
    or a, $01
    ld [bc], a ;enable channel
.Label189CB
    ld a, [wNR51SoundOutput]
    ld [rAUDTERM], a ;NR51 sound output
    ret

setSoundEffectBranch:: ;06:49D1
    inc bc
    ld a, [bc] ;store sfx branch address in bc
    ld e, a
    inc bc
    ld a, [bc]
    ld b, a
    ld c, e
    ld a, $01
    ld [hl], a ;set sfx counter
    jr setNextSfxAddress
;49DD

cleanedWaveRam:	;49DD
	db $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $00, $00, $00, $00, $00, $00, $00, $00
;49ED

INCLUDE "audio/musicChannelsTable.asm" ;49ED
;4A6F

noteLengthTableA: ;4A6F note lenght table
	db $03, $04, $06, $09, $0C, $12, $18, $24, $30, $48, $60, $90, $C0, $08, $10, $2A
noteLengthTableB: ;4A7F
	db $04, $06, $08, $0C, $10, $18, $20, $30, $40, $60, $80, $C0, $FC, $05, $0A, $14
	;db $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F, $10
;4A8F

instrumentsTables: ;4A8F instruments table 1
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
;instruments table 2
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
	db $80
	db $00
	db $02
	dbw $00, $0000
	dbw $00, $0000
	dbw $00, $0000
Label18ADB: ;noise instrument
	db $C0 ;11000000 ;restart sound & enable lenght counter
	db $BD ;sound length
	db $00 ;envelope
	dbw $01, Label18C4F ;4C4F
	dbw $01, Label18D56 ;4D56
	dbw $00, $0000
Label18AE7:
	db $80
	db $80
	db $00
	dbw $01, Label18C58
	dbw $01, Label18D59
	dbw $00, $0000
Label18AF3:
	db $C0
	db $BB
	db $31
	dbw $00, $0000
	dbw $01, Label18D7A
	dbw $00, $0000
Label18AFF:
	db $C0
	db $BB
	db $41
	dbw $00, $0000
	dbw $01, Label18D7A
	dbw $00, $0000
Label18B0B:
	db $80
	db $80
	db $00
	dbw $01, Label18C63
	dbw $01, Label18D59
	dbw $00, $0000
Label18B17:
	db $80
	db $80
	db $00
	dbw $01, Label18CD1
	dbw $02, Label18DD1
	dbw $00, $0000
Label18B23:
	db $80
	db $80
	db $00
	dbw $01, Label18C8C
	dbw $01, Label18DBE
	dbw $00, $0000
Label18B2F:
	dbw $80, $2700
	dbw $00, $0000
	dbw $00, $0000
	dbw $01, Label18E55
Label18B3B:
	db $80
	db $80
	db $00
	dbw $01, Label18CA8
	dbw $00, $0000
	dbw $01, Label18E60
Label18B47: ;4B47
	db $80 ;init
	db $80 ;wave pattern 50%
	db $37 ;envelope
	dbw $00, $0000
	dbw $01, Label18DBE
	dbw $00, $0000
Label18B53:
	db $80
	db $80
	db $97
	dbw $00, $0000
	dbw $01, Label18DBE
	dbw $00, $0000
Label18B5F:
	db $80
	db $80
	db $00
	dbw $01, Label18CB5
	dbw $01, Label18DBE
	dbw $00, $0000
Label18B6B:
	db $80
	db $80
	db $62
	dbw $00, $0000
	dbw $01, Label18DD1
	dbw $00, $0000
Label18B77:
	db $80
	db $80
	db $80
	dbw $01, Label18CC4
	dbw $02, Label18DE4
	dbw $00, $0000
Label18B83:
	db $80
	db $80
	db $80
	dbw $01, Label18CD1
	dbw $02, Label18DE4
	dbw $00, $0000

Label18B8F:
	db $C0
	db $00
	db $00
	dbw $01, Label18D05
	dbw $00, $0000
	dbw $00, $0000
Label18B9B:
	db $C0 ;;trigger channel start (init) | Consecutive select/length counter enable
	db $00
	db $00
	dbw $01, Label18D10
	dbw $00, $0000
	dbw $00, $0000
Label18BA7:
	db $80
	db $00
	db $00
	dbw $01, Label18D19
	dbw $01, Label18E0A
	dbw $00, $0000
Label18BB3:
	db $80
	db $80
	db $00
	dbw $01, Label18CE4
	dbw $00, $0000
	dbw $01, Label18E90
Label18BBF:
	db $80
	db $80
	db $64
	dbw $00, $0000
	dbw $00, $0000
	dbw $01, Label18E9F
Label18BCB:
	db $80
	db $80
	db $64
	dbw $00, $0000
	dbw $00, $0000
	dbw $01, Label18EAE
Label18BD7:
	db $80
	db $80
	db $00
	dbw $01, Label18CE4
	dbw $00, $0000
	dbw $02, Label18EBD
Label18BE3:
	db $80
	db $80
	db $56
	dbw $00, $0000
	dbw $00, $0000
	dbw $01, Label18ECC
Label18BEF:
	db $80
	db $00
	db $00
	dbw $01, Label18D26
	dbw $01, Label18E0A
	dbw $00, $0000
Label18BFB:
	db $80
	db $00
	db $00
	dbw $01, Label18D26
	dbw $00, $0000
	dbw $00, $0000
Label18C07: ;4c07
	db $80 ;trigger channel start (init)
	db $40
	db $00
	dbw $01, Label18CFC
	dbw $01, Label18DBE
	dbw $00, $0000
Label18C13:
	db $80
	db $80
	db $00
	dbw $01, Label18CD1
	dbw $00, $0000
	dbw $01, Label18E6D
Label18C1F:
	db $80
	db $80
	db $00
	dbw $01, Label18D3B
	dbw $00, $0000
	dbw $01, Label18EE6
Label18C2B:
	db $80
	db $80
	db $00
	dbw $01, Label18D44
	dbw $01, Label18E20
	dbw $00, $0000
Label18C37:
	db $80
	db $80
	db $00
	dbw $01, Label18D4D
	dbw $01, Label18E20
	dbw $00, $0000
Label18C43:
	db $80
	db $80
	db $00
	dbw $01, Label18CD1
	dbw $02, Label18DF7
	dbw $00, $0000
;4C4F

INCLUDE "audio/instrumentsEffectsTables.asm" ;4C4F
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

INCLUDE "audio/music_branches_table.asm" ;6D7C
;6E9E

INCLUDE "audio/baseSfxLookupTable.asm" ;6E9E
INCLUDE "audio/sfxLookupTable.asm" ;6F1C
INCLUDE "audio/baseSoundEffects.asm" ;6FC4

;06:7A57 rest of bank is empty
