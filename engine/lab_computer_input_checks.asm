checkELocksFloorSelectInput: ;04:4A8E
    ld a, [wButtonPressId]
    and a, UP_INPUT
    jp nz, checkELocksFloorSelectUpInput
    xor a
    ld [wPressingUpKey], a
    ld a, [wButtonPressId]
    and a, DOWN_INPUT
    jp nz, checkELocksFloorSelectDownInput
    xor a
    ld [wPressingDownKey], a
    ret
;4AA7

checkELocksFloorSelectUpInput: ;04:4AA7
    ld hl, wPressingUpKey
    ld a, [hl]
    or a
    ret nz
    ld [hl], $FF
    ld a, [wElectronicUnlockFloorSelectId]
    or a
    ret z ; if top option
    dec a
    ld [wElectronicUnlockFloorSelectId], a
    ld a, SWITCH_SFX
    jp playSFX

checkELocksFloorSelectDownInput:
    ld hl, wPressingDownKey
    ld a, [hl]
    or a
    ret nz
    ld [hl], $FF
    ld a, [wElectronicUnlockFloorSelectId]
    cp a, 2
    ret z ; if bottom option
    inc a
    ld [wElectronicUnlockFloorSelectId], a
    ld a, SWITCH_SFX
    jp playSFX
;4AD4

checkLabPCKeyboardInputs: ;04:4AD4
    ld a, [wButtonPressId]
    and a, LEFT_INPUT
    jp nz, checkKeyboardLeftInput
    xor a
    ld [wPressingLeftKey], a
    ld a, [wButtonPressId]
    and a, RIGHT_INPUT
    jp nz, checkKeyboardRightInput
    xor a
    ld [wPressingRightKey], a
    ld a, [wButtonPressId]
    and a, UP_INPUT
    jp nz, checkKeyboardUpInput
    xor a
    ld [wPressingUpKey], a
    ld a, [wButtonPressId]
    and a, DOWN_INPUT
    jp nz, checkKeyboardDownInput
    xor a
    ld [wPressingDownKey], a
    ret
;4B05

checkKeyboardLeftInput: ;04:4B05
    ld hl, wPressingLeftKey
    ld a, [hl]
    or a
    ret nz
    ld [hl], $FF
    ld hl, wComputerKeyboardKeyId
    ld a, [hl]
    and a, $07
    ret z ; is a left border key
; move selected key left
    dec [hl]
    ld a, [hl]
    cp a, $1D ; is bs key selected
    jr nz, .Label10B1B
    dec [hl] ; go left 1 extra key (bs key is two keys long)
.Label10B1B
    ld a, SWITCH_SFX
    jp playSFX

checkKeyboardRightInput:
    ld hl, wPressingRightKey
    ld a, [hl]
    or a
    ret nz
    ld [hl], $FF
    ld hl, wComputerKeyboardKeyId
    ld a, [hl]
    and a, $07
    cp a, $07 ; is a right border key
    ret z
; move selected key right
    inc [hl]
    ld a, [hl]
    cp a, $1E ; is bs key selected
    jr nz, .Label10B38
    inc [hl] ; go right 1 extra key (bs key is two keys long)
.Label10B38
    ld a, SWITCH_SFX
    jp playSFX

checkKeyboardUpInput:
    ld hl, wPressingUpKey
    ld a, [hl]
    or a
    ret nz
    ld [hl], $FF
    ld hl, wComputerKeyboardKeyId
    ld a, [hl]
    cp a, $08 ; is a top key
    ret c
    ld a, [hl]
    sub a, $08
    ld [hl], a
    cp a, $17 ; check enter key
    jr z, .Label10B58
    cp a, $0F ; check enter key
    jr nz, .Label10B5A
.Label10B58
    ld [hl], $07 ; set enter top key
.Label10B5A
    ld a, SWITCH_SFX
    jp playSFX

checkKeyboardDownInput:
    ld hl, wPressingDownKey
    ld a, [hl]
    or a
    ret nz
    ld [hl], $FF
    ld hl, wComputerKeyboardKeyId
    ld a, [hl]
    cp a, $18 ; is a bottom key
    ret nc
; check enter key
    cp a, $0F
    ret z
    cp a, $17
    ret z
    cp a, $1F
    ret z
; select below key
    ld a, [hl]
    add a, $08
    ld [hl], a
    ld a, SWITCH_SFX
    jp playSFX
;4B80
