printChoiceArrow: ;01:4975
    ld hl, wChoiceId
    ld a, [wButtonPressId]
    and a, LEFT_INPUT
    jr nz, choiceLeftInputPressed
    ld a, [wButtonPressId]
    and a, RIGHT_INPUT
    jr nz, choiceRightInputPressed
    jr Label498E
choiceLeftInputPressed
    ld [hl], 0 ; Yes
    jr Label498E
choiceRightInputPressed
    ld [hl], 1 ; No
Label498E:
    ld a, [wTextCharTileXPos]
    push af
    ld a, [wTextCharTileYPos]
    push af
    ld a, [hl]
    or a
    jr z, yesChoice
.noChoice
    ld a, [wTextCharTileYPos]
    ld h, a
    ld a, [wTextCharTileXPos]
    sub a, 8
    ld l, a
    ld a, BANK(emptySpaceChar)
    ld bc, emptySpaceChar
    call printTextString
    ld a, [wTextCharTileYPos]
    ld h, a
    ld a, [wTextCharTileXPos]
    add a, 3
    ld l, a
    ld a, BANK(choiceArrowChar)
    ld bc, choiceArrowChar
    call printTextString
    jr Label49E4
yesChoice
    ld a, [wTextCharTileYPos]
    ld h, a
    ld a, [wTextCharTileXPos]
    sub a, 8
    ld l, a
    ld a, BANK(choiceArrowChar)
    ld bc, choiceArrowChar
    call printTextString
    ld a, [wTextCharTileYPos]
    ld h, a
    ld a, [wTextCharTileXPos]
    add a, 3
    ld l, a
    ld a, BANK(emptySpaceChar)
    ld bc, emptySpaceChar
    call printTextString
Label49E4
    pop af
    ld [wTextCharTileYPos], a
    pop af
    ld [wTextCharTileXPos], a
    ret
;49ED