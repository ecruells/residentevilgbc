; display the welcome message when start a new game or when a saved game is loaded
displayStartGameWelcomeMessage:: ;01:439A
    call resetPalettes
    call hideSprites
    call loadFontTiles
    ld a, UPDATE_BG_PALETTE
    ld [wPaletteFadeCounter], a
    ld hl, _NewGameWelcomeMsgPointer
    ld a, [wCursorIdBuffer]
    or a
    jr z, .Label43B4 ; if cursorId == 0 then is new game
; else a saved game was loaded
    ld hl, _LoadGameWelcomeMsgPointer
.Label43B4
    ld b, 3
.loop43B6
    push bc
    push hl
    ld hl, 0
    ld b, 7
.loop43BD ; clear screen loop with debug messages at top
    push bc
    push hl
    ld bc, ClearTextboxText
    ld a, BANK(ClearTextboxText)
    call printTextString
; debug start
    ld hl, _SCRN0
    ld de, $3F92 ; print debug word "3F92"
    call printDebugWord
    ld hl, _SCRN0+$20
    ld de, $7BE6 ; print debug word "7BE6"
    call printDebugWord
; debug end
    pop hl
    inc h
    inc h
    inc h
    pop bc
    dec b
    jp nz, .loop43BD
    call haltCPU
    ld a, BANK(greyPalette)
    ld hl, greyPalette
    call loadBgPalette
    pop hl
    push hl
    call printIntroMessages
    ld b, $80
; text delay
.loop43F4
    push bc
    call haltCPU
    pop bc
    dec b
    jr nz, .loop43F4
    pop hl
    inc hl
    inc hl
    pop bc
    dec b
    jp nz, .loop43B6
    call resetPalettes
    ret
