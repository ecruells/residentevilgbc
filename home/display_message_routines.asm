; hl: message pointer address
displayMessage: ;00:0C0A
    ld a, BANK(textPointers)
    call bankSwitch
    ld c, [hl]
    inc hl
    ld b, [hl] ; get text pointer
    inc hl
    ld e, [hl] ; get text bank
    ld a, $01
    call bankSwitch
    ld a, e
    ldhl 16, 0 ; message position
    jp printTextString

clearMessageBox: ;00:0C20
    push hl
    ld bc, ClearThreeTextLines
    ldhl 16, 0
    ld a, BANK(ClearThreeTextLines)
    call printTextString
    pop hl
    ret
;0C2E

waitMessageForPlayerInput:: ;00:0C2E
    push hl
.loopC2F
    ld hl, wButtonPressId
    call haltCPU
    ld a, [hl]
    and a, AB_INPUT
    jr nz, .loopC2F
.loopC3A
    call haltCPU
    ld a, [hl]
    and a, AB_INPUT
    jr z, .loopC3A
.loopC42
    call haltCPU
    ld a, [hl]
    and a, AB_INPUT
    jr nz, .loopC42
    pop hl
    ret
