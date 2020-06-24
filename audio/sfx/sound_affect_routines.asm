; a: sfx index
updateSoundEffect:: ;06:487B
    ld hl, BaseSfxLookupTable
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
    ld a, [hl]
    ld b, a ; bc: sfx pointer
    ld a, %10001111
    ld [rAUDENA], a ; enable all sound
    ld a, [bc] ; get channel id
    inc bc
    cp a, SOUND_CHANNEL_2
    jr z, .updateChannel2Sfx
    cp a, SOUND_CHANNEL_3
    jr z, .updateChannel3Sfx
    cp a, SOUND_CHANNEL_4
    jr z, .updateChannel4Sfx
; update channel 1 sfx
    ld a, [wNR51SoundOutput]
    ld d, a
    ld a, %00010001
    or a, d
    ld [wLRSoundEnabler], a  ; enable sound 1
    ld a, [wChannel1State]
    and a, %11111110 ; set channel inactive
    ld [wChannel1State], a
; store sfx value address
    ld a, c
    ld [wChannel1SfxAddrLow], a
    ld a, b
    ld [wChannel1SfxAddrHigh], a
    ld a, $02
    ld [wChannel1SfxCounter], a
    jr updateChannelsSfx
.updateChannel2Sfx
    ld a, [wNR51SoundOutput]
    ld d, a
    ld a, %00100010 ; output chl2 sound
    or a, d
    ld [wLRSoundEnabler], a
    ld a, [wChannel2State]
    and a, %11111110 ; set channel inactive
    ld [wChannel2State], a
    ld a, c
    ld [wChannel2SfxAddrLow], a
    ld a, b
    ld [wChannel2SfxAddrHigh], a
    ld a, $02
    ld [wChannel2SfxCounter], a
    jr updateChannelsSfx
.updateChannel3Sfx
    ld a, [wNR51SoundOutput]
    ld d, a
    ld a, %01000100
    or a, d
    ld [wLRSoundEnabler], a
    ld a, [wChannel3State]
    and a, %11111110 ; set channel inactive
    ld [wChannel3State], a
    ld a, c
    ld [wChannel3SfxAddrLow], a
    ld a, b
    ld [wChannel3SfxAddrHigh], a
    ld a, $02
    ld [wChannel3SfxCounter], a
    jr updateChannelsSfx
.updateChannel4Sfx
    ld a, [wNR51SoundOutput]
    ld d, a
    ld a, %10001000
    or a, d
    ld [wLRSoundEnabler], a
    ld a, [wChannel4State]
    and a, %11111110 ; set channel inactive
    ld [wChannel4State], a
    ld a, c
    ld [wChannel4SfxAddrLow], a
    ld a, b
    ld [wChannel4SfxAddrHigh], a
    ld a, $02
    ld [wChannel4SfxCounter], a

updateChannelsSfx::
    ld hl, wChannel1State
    ld a, l
    ld [wChannelStateVarAddrLow], a
    ld a, h
    ld [wChannelStateVarAddrHigh], a
    ld hl, wChannel1SfxAddrLow
; get channel sfx addr
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, b
    or a, c
    jr z, .Label18939 ; skip if no sfx addr
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

; 
checkSfxUpdate:: ;06:498B
	ld a, [wLRSoundEnabler]
	ld [rAUDTERM], a ; NR51
	inc hl
	dec [hl] ; decrease sfx counter
	jr z, updateSfxValues
	ret

; de: rAUDxLEN
updateSfxValues:: ;06:4995
    ld a, [bc] ; get sfx value
    cp a, $FF
    jr z, finishChannelSfxPlay
    cp a, $FE
    jr z, setSoundEffectBranch
    ld [hl], a ; set sfx counter
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
