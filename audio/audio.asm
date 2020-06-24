
clearSoundCaller:: ;06:4000
	jp clearSound

updateSoundEffectCaller:: ;06:4003
	jp updateSoundEffect

playMusicCaller:: ;06:4006
	jp playMusicRoutine

updateMusicAndSfxCaller:: ;06:4009
	jp updateMusicAndSfx

Label1800C: ;400C
    jp updateMusicRoutine

Label1800F: ;400F
    jp updateChannelsSfx

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

playSfxRoutineCaller:: ;06:4024
	jp playSFXRoutine

setMusicTempo:: ;06:4027
	ld [wSoundTempo], a
	ret

updateMusicAndSfx::
	call updateMusicRoutine
	call updateChannelsSfx
	ret
;06:4032

decreaseAudioVolume: ;06:4032
    ld a, [rAUDVOL]  ;NR50 channel control
    and a, %00000111
    jr z, Label1803F ; if SO1 vol is max
    dec a ; decrease volume
    or a, %00001000 ; Vin->SO1 ON
    ld b, a
    jp Label18041
Label1803F
    ld b, $00
Label18041:
    ld a, [rAUDVOL]  ;NR50 channel control
    and a, %01110000
    jr z, Label1804C ; if SO2 vol is max
    sub a, %00010000 ; decrease volume
    jp Label1804E
Label1804C
    ld a, $00
Label1804E:
    or a, b
    cp a, $00
    jr nz, Label18056
    call muteAllChannels
Label18056
    ld [rAUDVOL], a ; NR50 channel control
    ret
;4059

disableSoundOutput: ;06:4059
    xor a
    ld [rAUDTERM], a ; disable NR51 sound output
    ld [wNR51SoundOutput], a
    ld [rAUDVOL], a ; mute vol NR50 channel control
    ld [wNR50ChannelControl], a
    ret
;4065

muteAllChannels: ;06:4065
    ld a, 0
    ld [rAUD1ENV], a ; NR12 envelope channel #1
    ld [rAUD2ENV], a ; NR22 envelope channel #2
    ld [rAUD3LEVEL], a ; NR32 volume #3
    ld [rAUD4ENV], a ; NR42 envelope channel #4
    ld [wNR50ChannelControl], a
    ret
;4073

enableChannelControlMax: ;06:4073
    ld a, %11111111
    ld [wNR50ChannelControl], a ; enable outputs level at max
    ret
;4079

increaseAudioVolume: ;06:4079
    call enableChannelControlMax
    ld a, [rAUDVOL]  ;NR50 channel control
    cp a, 0
    jr nz, increaseSO1Volume ; if audio is enabled
; audio is muted
    ld a, %10001000 ;enable VINs, 0 volumen
    ld [rAUDVOL], a ;NR50 channel control
    ret
increaseSO1Volume ;06:4087
    and a, %00000111 ;SO1 max volume
    cp a, %00000111
    jr z, increaseSO2Volume ; SO1 volume is at max
    add a, 1
    ld b, a ; increse SO1 volume
increaseSO2Volume
    ld a, [rAUDVOL]  ;NR50 channel control
    and a, %01110000 ; SO2 max volume
    srl a
    srl a
    srl a
    srl a
    cp a, %00000111
    ret z ; if SO2 volume is at max
    add a, 1 ; increse SO2 volume
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
    ld hl, SfxLookupTable
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

; a: sfx index
; hl: channel sfx address
callUpdateSoundEffect:: ;06:40DD
	push hl
	call updateSoundEffect
	pop hl
	ret

; clear and disable all sound (mute audio)
clearSound:: ;06:40E3
    ld a, 0
    ld [rAUDENA], a ; disable sound NR52
    nop
    ld [rAUDENA], a ; disable sound NR52
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
    ld de, _AUD3WAVERAM
    ld hl, cleanedWaveRam
    ld b, 16
.cleanWaveRamLoop
    ld a, [hl]
    ld [de], a
    inc hl
    inc de
    dec b
    jr nz, .cleanWaveRamLoop
    call initSound
    ret

; a: music id
playMusicRoutine:: ;06:412B
    ld l, a
    ld h, $00
    add hl, hl
    ld d, h
    ld e, l
    add hl, hl
    add hl, hl
    add hl, de
    ld de, musicTable
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
    ld a, CHANNEL_PLAYING | CHANNEL_ACTIVE
    ld [wChannel1State], a
    ld [wChannel2State], a
    ld [wChannel3State], a
    ld [wChannel4State], a
    ld [wNR50ChannelControl], a
    ld a, $FF
    ld [wSoundTempo], a
    ld a, $01
    ld [wSoundTempoCounter], a
initSound:: ;06:418B
    ld a, %10001111
    ld [rAUDENA], a ; enable NR52 sound
    nop
    nop
	ld [rAUDENA], a ; enable NR52 sound
    ld a, %00001000
    ld [rAUD1SWEEP], a ; sweep decrease (NR10)
    ld a, %11111111
    ld [rAUDTERM], a ; output all channel to all sound output
    ld [wNR51SoundOutput], a
    ld a, %01110111
    ld [rAUDVOL], a ; max volume
    ld a, %10000000
    ld [rAUD3ENA], a ; set audio channel #3 ON NR30
    xor a
    ld [rAUD1ENV], a ; NR12 stop envelope channel #1
    ld [rAUD2ENV], a ; NR22 stop envelope channel #2
    ld [rAUD3LEVEL], a ; NR32 mute volume #3
    ld [rAUD4ENV], a ; NR42 stop envelope channel #4
    ld [wChl1ActionId], a
    ld [wChl2ActionId], a
    ld [wChl3ActionId], a
    ld [wChl4ActionId], a
    ld [wCh1CheckBranchPlayCounterFlag], a
    ld [wCh2CheckBranchPlayCounterFlag], a
    ld [wCh3CheckBranchPlayCounterFlag], a
    ld [wCh4CheckBranchPlayCounterFlag], a
    ld [wCh4PolyCounterTableTicks], a
    ret

updateMusicRoutine:: ;06:41CB
    ld a, [wNR50ChannelControl]
    and a
    ret z ; return if sound is disabled
    ld a, [wSoundTempo] ; get tempo
    ld b, a
    ld a, [wSoundTempoCounter] ; get tempo counter
    add a, b
    ld [wSoundTempoCounter], a
    ret nc
updateChannel1: ;41DC
    xor a
    ld [wChannelId], a ; set channel id
    ld hl, wChlUpdateFunctionAddrLow
    ld de, updateChannel1
    ld [hl], e
    inc hl
    ld [hl], d
    ld a, [wChl1ActionId] ; get channel action id
    ld [wChannelActionId], a
    ld hl, wChannel1State
    ld de, rAUD1LEN
    call getChannelNoteOrCheckChannelAction
    ld a, [wChannel1State]
    and a, CHANNEL_ACTIVE
    jp z, updateChannel2 ; to next channel if chl1 is active
    ld a, [wChannel1SfxAddrHigh]
    and a
    jp nz, updateChannel2 ; if channel is playing sfx
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
    ld de, frequencyHighBitsTable
    add a, e
    ld e, a
    jr nc, .Label1826F
    inc d
.Label1826F
    ld a, [de]
    ld [wCh1FreqHigh], a
    pop af
    ld de, frequencyLowBitsTable
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
    ld a, SOUND_CHANNEL_2
    ld [wChannelId], a
    ld hl, wChlUpdateFunctionAddrLow
    ld de, updateChannel2
    ld [hl], e
    inc hl
    ld [hl], d
    ld a, [wChl2ActionId]
    ld [wChannelActionId], a
    ld hl, wChannel2State
    ld de, rAUD2LEN
    call getChannelNoteOrCheckChannelAction
    ld a, [wChannel2State]
    and a, CHANNEL_ACTIVE
    jp z, updateChannel3 ; to next channel if chl2 is active
    ld a, [wChannel2SfxAddrHigh]
    and a
    jp nz, updateChannel3 ; skip if channel is playing sfx
    ld hl, wCh2EnvelopeTableTicks ; envelope table counter var
    ld de, wCh2EnvelopeTableAddrLow ; envelope table addr low
; store envelope table address into bc
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    ld de, rAUD2ENV
    call checkChannelEnvelopeEffect
; store next env effect address
    ld de, wCh2EnvelopeTableAddrLow
    ld a, c
    ld [de], a
    ld a, b
    inc de
    ld [de], a
    ld hl, wChannel2State
    ld de, rAUD2LOW
    call updateChannelNote
    ld hl, wCh2PitchBendTableTicks ; pitch bend ticks counter var
    ld de, wCh2PitchBendTableAddrLow ; pitch bend table addr low
; store pitch bend table addr into bc
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    ld de, wCh2FreqLow
    call checkPitchBendEffect
    ld de, wCh2PitchBendTableAddrLow
    ld a, c
    ld [de], a
    ld a, b
    inc de
    ld [de], a
; checkVibratoEffect
    ld a, [wCh2VibratoTableTicks]
    and a
    jr z, updateChannel3 ; skip if ticks is zero
    dec a ;decrese tick counter
    ld [wCh2VibratoTableTicks], a
    and a
    jr nz, updateChannel3 ; skip if effect is not over
; store vibrato effect addr into bc
    ld a, [wCh2VibratoTableAddrLow]
    ld c, a
    ld a, [wCh2VibratoTableAddrHigh]
    ld b, a
    ld a, [bc] ; get vibrato ticks
    cp a, $FF
    jr z, .channel2VibratoLoop
    ld [wCh2VibratoTableTicks], a ; update ticks
    inc bc
    ld a, [bc] ;get vibrato value
    ld e, a
    ld a, [wChl2CurrentNoteId] ; chl2 current note id
    add a, e ;add vibrato pitch offset
; get new note frequency
    push af
    ld de, frequencyHighBitsTable
    add a, e
    ld e, a
    jr nc, .Label1832F
    inc d
.Label1832F
    ld a, [de]
    ld [wCh2FreqHigh], a
    pop af
    ld de, frequencyLowBitsTable
    add a, e
    ld e, a
    jr nc, .Label1833C
    inc d
.Label1833C
    ld a, [de]
    ld [wCh2FreqLow], a ; set freq high bits
; set next effect address
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
    ld a, SOUND_CHANNEL_3
    ld [wChannelId], a
    ld hl, wChlUpdateFunctionAddrLow
    ld de, updateChannel3
    ld [hl], e
    inc hl
    ld [hl], d
    ld a, [wChl3ActionId]
    ld [wChannelActionId], a
    ld hl, wChannel3State
    ld de, rAUD3LEN
    call getChannelNoteOrCheckChannelAction
    ld a, [wChannel3State]
    and a, CHANNEL_ACTIVE
    jp z, updateChannel4 ; skip if chl3 is active
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
; checkVibratoEffect
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
    ld de, frequencyHighBitsTable
    add a, e
    ld e, a
    jr nc, .Label183EF
    inc d
.Label183EF
    ld a, [de]
    ld [wCh3FreqHigh], a
    pop af
    ld de, frequencyLowBitsTable
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
    ld a, SOUND_CHANNEL_4
    ld [wChannelId], a
; store chl update addr in vars
    ld hl, wChlUpdateFunctionAddrLow
    ld de, updateChannel4
    ld [hl], e
    inc hl
    ld [hl], d
    ld a, [wChl4ActionId]
    ld [wChannelActionId], a
    ld hl, wChannel4State
    ld de, rAUD4LEN
    call getChannelNoteOrCheckChannelAction
    ld a, [wChannel4State]
    and a, CHANNEL_ACTIVE ; skip if channel is active
    jr z, .updatePolyCounter
    ld a, [wChannel4SfxAddrHigh]
    and a ; skip if channel is sfx
    jp nz, .updatePolyCounter
    ld hl, wCh4EnvelopeTableTicks
    ld de, wCh4EnvelopeTableAddrLow
; envelope table addr into bc
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    ld de, rAUD4ENV
    call checkChannelEnvelopeEffect
; update next env. effect addr.
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

; hl: envelope ticks counter
; de: channel hardware envelope address
; bc: table counter address
checkChannelEnvelopeEffect:: ;06:446C
    ld a, [hl]
    and a
    ret z ; if end counter
    dec [hl] ; decrease env. counter
    ret nz ; if there're ticks yet
; if effect ticks finish, apply next envelope effect
    ld a, [bc] ; get envelope value
    cp a, $FF
    jr nz, applyEnvelopeEffect
    ld a, 0
    ld [hl], a ; set counter to zero
    ret

; a: volume envelope value
; de: NR12
applyEnvelopeEffect:: ;06:447A
    ld [de], a
    inc bc
    ld a, [bc] ; get effect ticks
    ld [hl], a
    ld a, l
    sub a, 6 ; back to frequency high var
    ld l, a
    jr nc, .Label18485
    dec h
.Label18485
    ld a, [hl]
    or a, %10000000 ; restart channel
    ld [hl], a
    ld a, l
    add a, 4 ; go to channel envelope var
    ld l, a
    jr nc, .Label18490
    inc h
.Label18490
    ld a, [de]
    ld [hl], a ; store envelope into channel var
    inc bc ; next effect
    ret

; hl: pitch bend ticks counter
; bc: pitch bend table addr
; de: channel freq low
checkPitchBendEffect:: ;06:4494
    ld a, [hl]
    and a
    ret z ; if no ticks left
    dec [hl] ; decrease effect ticks
    ret nz ; if effect is not over yet
    inc bc
    ld a, [bc] ; get ticks value
    push hl ; store ticks counter
    ld [hl], a ; store ticks value
    dec bc ; set pitch bend value pointer
    ld a, [de] ; get freq low value
    ld l, a
    dec de
    ld a, [de] ; get freq high value
    ld h, a
    ld a, [bc] ; get pitch bend value
    cp a, $7E ; check if effect table end
    jr nz, applyPitchBendEffect
    pop hl ; restore ticks counter
    ret

; a: pitch bend value
; hl: channel frequency value
applyPitchBendEffect:: ;06:44AA
    cp a, $7D ; check if effect table loop
    jr z, setPitchBendTableLoop
    cp a, $7F
    jr nc, .pitchBendDown
; pitchBendUp
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
    ld [de], a ; update note frequency high
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
    ld [hl], a ; restart ticks value
    ret

; get note value, if is a valid note value or execute a channel action.
; it gets its frequency and instruments effects values
;
; hl: channel ram
getChannelNoteOrCheckChannelAction:: ;06:44D4
    ld a, [hl] ; get channel state
    and a, CHANNEL_PLAYING
    ret z
; channel is not playing
    inc hl
    dec [hl] ; note length
    ret nz ; return if prev note is still playing
; get branch next action address
    inc hl
    ld c, [hl] ; channel action id addr low
    inc hl
    ld b, [hl] ; channel action id addr high
    ld a, [bc] ; channel action id or note id
    ld [wChannelNoteId], a
    and a, %01111111 ; mask action id
    cp a, $5F ; channel actions
    jp nc, checkAndExecuteChannelAction ; is channel action
; is note id
    push de ; store channel length register
    ld de, wChannelActionId
    ld a, [de] ; get semitone transpose value
    ld d, a
    ld a, [bc] ; get note id
    and a, %01111111
    add a, d ; transpose note
    ld d, a
    push af
    ld a, [wChannelId] ; get channel id
;
; store the note id in channel ram
    cp a, SOUND_CHANNEL_1
    jr nz, .Label18501
    ld a, d
    ld [wChl1CurrentNoteId], a
.Label18501
    cp a, SOUND_CHANNEL_2
    jr nz, .Label18509
    ld a, d
    ld [wChl2CurrentNoteId], a
.Label18509
    cp a, SOUND_CHANNEL_3
    jr nz, .Label18511
    ld a, d
    ld [wChl3CurrentNoteId], a
.Label18511
    pop af ; get note id
; get note frequency high bits
    ld de, frequencyHighBitsTable
    add a, e
    ld e, a
    jp nc, .Label1851B
    inc d
.Label1851B
    ld a, [de]
    inc hl
    ld [hl], a
; get frequency low bits
    ld de, wChannelActionId
    ld a, [de]
    ld d, a
    ld a, [bc]
    and a, %01111111
    add a, d ; get note
    ld de, frequencyLowBitsTable
    add a, e
    ld e, a
    jr nc, .Label1852F
    inc d
.Label1852F
    ld a, [de]
    inc hl
    ld [hl], a ; get note frequency low bits
    inc bc
    ld a, [bc] ; get instrument & note length byte
    and a, $0F ; mask length id
    push hl ; store freq var
    ld hl, wNoteLengthTableAddrHigh
    ld d, [hl]
    dec hl
    ld e, [hl]
    pop hl
    add a, e ; add note length offset
    ld e, a
    jr nc, .Label18543
    inc d
.Label18543
    ld a, [de] ; get note length
    ld de, -4 ; offset back to channel note length var
    add hl, de
    ld [hl], a ; store channel note length
    ld a, [wChannelNoteId] ; get raw note id
    and a, %10000000 ; get instrument table bit
    srl a
    srl a
    ld d, a
    ld a, [bc] ; get instrument & note length byte
    and a, $F0 ; get instrument id
    srl a
    srl a
    srl a
    add a, d ; add instrument id offset to table id
    push hl
    ld hl, instrumentsTables
    add a, l
    ld l, a
    jr nc, .getInstrumentAddress
    inc h
.getInstrumentAddress
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    inc bc ; next music note addr
    inc hl ; next music note addr vars
    ld [hl], c
    inc hl
    ld [hl], b
; read and set intrument values
    ld b, d ; store instrument address into bc
    ld c, e
    pop de ; restore chl init & sound length register high
    inc hl ; get note freq high var
    ld a, [bc]
    or a, [hl] ; add restart channel bit (80)
    ld [hl], a
    inc hl
    inc hl
    inc hl ; offset to chl wave pattern var
    inc bc ; offset to next intrument byte (wave pattern value)
    ld a, [bc]
    ld [hl], a ; store wave pattern byte
    inc bc ; inst chl envelope byte
    inc de ; get chl envelope register
    inc hl ; chl envelope var
    ld a, [bc]
    ld [hl], a ; store envelope
    inc hl
    inc hl ; envelope table counter var
    inc bc
    ld a, [bc]
    ld [hl], a ; store envelope table counter
    inc hl
    inc bc
    ld a, [bc]
    ld [hl], a ; store envelope table addr low
    inc hl
    inc bc
    ld a, [bc]
    ld [hl], a ; store envelope table addr high
    inc hl
    inc bc
    ld a, [bc]
    ld [hl], a ; store pitch bend table counter
    inc hl
    inc bc
    ld a, [bc]
    ld [hl], a ; store pitch bend table addr low
    inc hl
    inc bc
    ld a, [bc]
    ld [hl], a ; store pitch bend table addr high
    inc bc
    inc hl
    ld a, [bc]
    ld [hl], a ; store tsp table counter
    inc bc
    inc hl
    ld a, [bc]
    ld [hl], a ; store tsp table addr low
    inc bc
    inc hl
    ld a, [bc]
    ld [hl], a ; store tsp table addr high
    ret

; hl: channel state
; de: channel freq low
updateChannelNote:: ;06:45A7
    ld a, [hl]
    and a, CHANNEL_ACTIVE
    ret z ; if channel is active
    ld bc, 5
    add hl, bc ; go to channel freq low var
    ld a, e
    cp a, $22 ; check if ch4 poly counter
    jp z, setNoisePolyCounter
    ld a, [hl]
    ld [de], a ; set chl freq low
Label185B7:
    dec hl ; get freq high var
    inc de ; get chl freq high register (or Noise Counter/consecutive)
    push de ; store register
    push hl ; store freq high var
    ld a, [hl]
    and a, $80
    jr z, .Label185CD ; jump if channel is not initialized
    ld bc, 3
    add hl, bc ; get wave pattern var
    dec de
    dec de
    dec de ; get wave pattern register (or sound length)
    ld a, [hl]
    ld [de], a ; set wave pattern value
    inc hl ; get envelope var
    inc de ; get env. register (or wave sound levels)
    ld a, [hl]
    ld [de], a ; set chl envelope
.Label185CD
    pop hl ; get freq high var
    pop de ; get freq register
    ld a, [hl]
    ld [de], a ; set frequency high
    and a, $7F
    ld [hl], a ; store freq high value
    ret

setNoisePolyCounter:: ;06:45D5
    ld a, [wNoisePolyCounterValue] ; get poly counter
    ld [wCh4PolyCounter], a ; store noise poly counter var
    ld [de], a ; set noise poly counter
    jr Label185B7

checkPolynomialCounterEffect:: ;06:45DE
    ld a, [wCh4PolyCounterTableTicks] ; poly counter ticks
    and a
    ret z
    dec a ; decrease ticks
    ld [wCh4PolyCounterTableTicks], a
    and a
    ret nz ; if effect is not over yet
    ld a, [wCh4PolyCounterTableAddrLow]
    ld l, a
    ld a, [wCh4PolyCounterTableAddrHigh]
    ld h, a
    ld a, [hl] ; get value
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
	dw setNoteLength
	dw disableChannel
	dw setChannelLoop
	dw setPolyCounterValue
	dw setBranchAddress
	dw setBranchEnd
	dw chlAction18719
	dw setGlobalSoundOutput
	dw setChannelLengthTableAddr
	dw setSoundTempo
	dw setSoundOutput1
	dw setSoundOutput2
	dw setSoundOutput3
	dw setSoundOutput4

; a: channel action id
; bc: channel action pointer
checkAndExecuteChannelAction:: ;06:4637
    sub a, $60
    add a ; get action offset
    push hl ; store action id addr high
    dec hl
    dec hl ; go to length counter
    inc [hl] ; inc length
    ld hl, channelActionsTable+1
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
    ld h, a ; length table addr into hl
    inc bc
    ld a, [bc] ; get length id
    and a, $0F
    add a, l
    ld l, a
    jr .Label1865B
    inc h
.Label1865B
    ld a, [hl] ;get length value
    pop hl
    ld de, -2
    add hl, de ; go to channel note length var
    ld [hl], a ; set length
    inc bc ; next action
    inc hl
    jp storeChannelNextActionAddr

disableChannel:: ;06:4667
    pop hl ; action id addr high
    ld bc, -3
    add hl, bc ; get channel state
    ld a, 0
    ld [hl], a ; disable channel
    ret
;4670

setChannelLoop: ;06:4670
    pop hl
    ld de, -2
    add hl, de ; get channel note length
    ld a, 1
    ld [hli], a ; reset channel ticks
    inc bc
    ld a, [bc] ; get loop chl addr low
    ld [hli], a
    inc bc
    ld a, [bc] ; get loop chl addr high
    ld [hl], a
    jp goToNextChannelUpdateAddr
;4681

setPolyCounterValue: ;4681
    pop hl ; action/note id addr high
    inc bc
    ld a, [bc] ; get action parameter
    ld [wNoisePolyCounterValue], a
    ld de, -2
    add hl, de ; go to chl length
    ld a, 1
    ld [hli], a ; reset length
    inc bc
    call storeChannelNextActionAddr
    jp goToNextChannelUpdateAddr
;4695

setBranchAddress: ;4695
    pop hl ; action/note id addr high
    ld de, -2
    add hl, de
    ld a, 1
    ld [hli], a ; reset length
    inc bc
    ld a, [bc] ; get branch id
    sla a
    jr nc, .Label186A9
    ld de, music_branches_table
    inc d
    jr .Label186AC
.Label186A9
    ld de, music_branches_table
.Label186AC
; add branch id offset
    add a, e
    ld e, a
    jr nc, .getBranchAddress
    inc d
.getBranchAddress ; and update next action address
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    ld d, h
    ld e, l ; action id addr high to de
    ld a, $10
    add a, e ; go to channel action id var
    ld e, a
    jr nc, .getSemitoneTransposeValue
    inc d
.getSemitoneTransposeValue
    inc bc
    ld a, [bc] ; get branch tsp value
    ld [de], a
    inc de
    ld a, [de] ; check branch play counter
    and a
    jr z, .Label186CA
    inc bc
    jr .backupNextActionAddress
.Label186CA
    ld a, $01
    ld [de], a ; set check branch play counter flag
    dec de
    dec de
    inc bc
    ld a, [bc] ; get branch counter
    sub a, $01
    ld [de], a
    inc de
    inc de
.backupNextActionAddress
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
    inc bc ; action parameter
    pop hl ; action/note id addr high
    ld de, -2
    add hl, de
    ld a, $01
    ld [hli], a ; reset length
    ld d, h ; note address into de
    ld e, l
    ld a, $11 ; go to branch counter
    add a, e
    ld e, a
    jr nc, Label186F2
    inc d
Label186F2
    ld a, [de] ; get branch counter
    and a
    jr z, .endBranchPlay
; decrease branch play counter and repeat branch play
    sub a, $01
    ld [de], a ; decrease counter
    inc de
    inc de
    inc de
    ld a, [de] ; get next channel action addr
; repeat branch action address
    sub a, $04 ; back to current branch address
    ld [hli], a
    inc de
    ld a, [de]
    jr nc, .Label18706
    sub a, $01
.Label18706
    ld [hl], a
    jp goToNextChannelUpdateAddr
.endBranchPlay
    inc de
    ld a, 0
    ld [de], a ; reset action id
    inc de
    ld [de], a ; reset branch play counter check
    inc de
; restore next channel action
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hl], a
    jp goToNextChannelUpdateAddr
;4719

chlAction18719: ;4719
    inc bc ; action parameter
    ld a, [bc]
    ld [wDD67], a ; value aparently never used
    pop hl ;action id addr high
    ld de, -2
    add hl, de ; back to note length counter
    ld a, 1
    ld [hli], a ; set length of 1
    inc bc ; next channel instruccion
    call storeChannelNextActionAddr
    jp goToNextChannelUpdateAddr
;472D


setGlobalSoundOutput: ;472D
    inc bc
    ld a, [bc] ; get sound enabler value
    ld [rAUDTERM], a ; set sound output
    ld [wNR51SoundOutput], a
goToNextChannelAction:
    inc bc ; next action
    pop hl ; action id addr high
    ld de, -2
    add hl, de
    ld a, $01
    ld [hli], a ; set length
    call storeChannelNextActionAddr
    jr goToNextChannelUpdateAddr

setSoundOutput1: ;4742
    inc bc
    ld a, [wNR51SoundOutput]
    and a, %11101110 ; disable SO1
    ld h, a
    ld a, [bc]
    or a, h
    ld [wNR51SoundOutput], a
    ld [rAUDTERM], a ; NR51 sound output
    jr goToNextChannelAction

setSoundOutput2: ;4752
    inc bc
    ld a, [wNR51SoundOutput]
    and a, %11011101 ;  disable SO2
    ld h, a
    ld a, [bc]
    or a, h
    ld [wNR51SoundOutput], a
    ld [rAUDTERM], a ; NR51 sound output
    jr goToNextChannelAction

setSoundOutput3: ;4762
    inc bc
    ld a, [wNR51SoundOutput]
    and a, %10111011 ;  disable SO2
    ld h, a
    ld a, [bc]
    or a, h
    ld [wNR51SoundOutput], a
    ld [rAUDTERM], a ; NR51 sound output
    jr goToNextChannelAction

setSoundOutput4: ;4772
    inc bc
    ld a, [wNR51SoundOutput]
    and a, %01110111 ;  disable SO2
    ld h, a
    ld a, [bc]
    or a, h
    ld [wNR51SoundOutput], a
    ld [rAUDTERM], a ; NR51 sound output
    jr goToNextChannelAction
;4782

setChannelLengthTableAddr: ;4782
    inc bc
    ld a, [bc] ; get length table addr low
    ld [wNoteLengthTableAddrLow], a
    inc bc
    ld a, [bc] ; get length table addr high
    ld [wNoteLengthTableAddrHigh], a
    pop hl
    ld de, -2
    add hl, de
    ld a, $01
    ld [hli], a ; set length
    inc bc
    call storeChannelNextActionAddr
    jr goToNextChannelUpdateAddr

setSoundTempo: ;479A
    inc bc
    ld a, [bc] ; get tempo value
    ld [wSoundTempo], a
    pop hl
    ld de, -2
    add hl, de
    ld a, $01
    ld [hli], a ; set length
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
    pop hl ; delete next channel update address from stack
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

INCLUDE "audio/sfx/sound_affect_routines.asm" ;06:487B

cleanedWaveRam:	;49DD
	db $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $00, $00, $00, $00, $00, $00, $00, $00
;49ED

INCLUDE "audio/music_table.asm" ;49ED

noteLengthTableA: ;4A6F note length table
	db $03, $04, $06, $09, $0C, $12, $18, $24, $30, $48, $60, $90, $C0, $08, $10, $2A
noteLengthTableB: ;4A7F
	db $04, $06, $08, $0C, $10, $18, $20, $30, $40, $60, $80, $C0, $FC, $05, $0A, $14

INCLUDE "audio/instruments_tables.asm" ;4A8F

INCLUDE "audio/instruments_effects_table.asm" ;4C4F

; music themes
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

; sound effects
INCLUDE "audio/sfx/base_sfx_table.asm" ;6E9E
INCLUDE "audio/sfx/sfx_table.asm" ;6F1C
INCLUDE "audio/sfx/base_sound_effects.asm" ;6FC4

;06:7A57 rest of bank is empty
