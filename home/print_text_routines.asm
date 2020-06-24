printItemBoxSelectedSlot:: ;00:3D8F
    call bankSwitch
    xor a
    ld [wTypingCharactersFlag], a ; normal chars display
    ld a, 8 ; palette index
    jr setTextPalette

printAutoTypingText::
    call bankSwitch
    ld a, $FF ; enable auto typing text
    jr setTextTypingMode

; hl: text pointer
printIntroMessages:: ;00:3DA1
    ld a, BANK(textPointers)
    call bankSwitch
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, $01
    call bankSwitch
    ldhl 15, 0 ; text position
    ld a, BANK(textPointers)
    jr printTextString

; de: text position
; hl: text pointer and bank address
printTextAtPosition:: ;00:3DB5
    ld a, BANK(textPointers)
    call bankSwitch
    ld c, [hl]
    inc hl
    ld b, [hl] ; get text pointer
    inc hl
    ld a, [hl] ; get text bank
    ld l, e
    ld h, d
    jr printTextString

printHighlightedText:: ;00:3DC3
    ld a, BANK(textPointers)
    call bankSwitch
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld a, [hl]
    ld l, e
    ld h, d
    call bankSwitch
    xor a
    ld [wTypingCharactersFlag], a ; disable typing chars mode
    ld a, 8 ; palette index
    jr setTextPalette



; a: text bank
; bc: text pointer
; h: text start y tile position
; l: text start x tile position
printTextString:: ;00:3DDA
    call bankSwitch
    xor a
setTextTypingMode:
    ld [wTypingCharactersFlag], a ; disable/enable typing chars mode
; default text palette
    ld a, 9
setTextPalette:
    ld [wVramTilesCounter], a
; set start position
    ld a, l
    ld [charTileXPosition], a
    ld a, h
    ld [charTileYPosition], a
    call getCharTileMapAddress
printCharLoop:
	; check for special characters
    ld a, [bc]
    cp a, END_OF_STRING
    jp z, endOfString
    cp a, NEW_LINE
    jp z, newTextLine
    cp a, FILE_NEXT_PAGE
    jp z, fileNextPage
    cp a, TYPING_TEXT ; not skipable typing text
    jp z, notSkipableTypingText
    cp a, SCROLL_TYPING_TEXT
    jp z, scrollDownTypingText
	; normal characters
    sub a, $20
    cp a, $28
    jr c, .Label3E29
    cp a, $50
    jr c, .Label3E1F
    sub a, $50
    ld e, a
    add a
    add a, e
    add a, $82
    ld d, a
    jr .Label3E2F
.Label3E1F
    sub a, $28
    ld e, a
    add a
    add a, e
    add a, $81
    ld d, a
    jr .Label3E2F
.Label3E29
    ld e, a
    add a
    add a, e
    add a, $80
    ld d, a
.Label3E2F
    call vblankWait
    ld [hl], d ; set char value in tilemap
    ld a, 1
    ld [rVBK], a
    ld a, [wVramTilesCounter]
    ld [hl], a ; set palette value
    xor a ; 0
    ld [rVBK], a ;vram bank select
    ld a, [wTypingCharactersFlag]
    or a
    jr z, .Label3E50 ;skip type delay
; delay char typing
    push bc
    ld b, 3
.typeDelayLoop
    push bc
    call haltCPU
    pop bc
    dec b
    jr nz, .typeDelayLoop
    pop bc
.Label3E50
    inc bc
    inc hl
    jr printCharLoop
endOfString:
    ld a, [charTileYPosition]
    ld [wTextCharTileYPos], a
    ld a, l
    and a, $1F
    ld [wTextCharTileXPos], a
    ld a, $01
    jp bankSwitch ;return
newTextLine:
    ld hl, charTileYPosition
    inc [hl]
    xor a
    ld [charTileXPosition], a
printNextChar: ;00:3E6D
    inc bc
    call getCharTileMapAddress
    jp printCharLoop

notSkipableTypingText:
	ld a, $FF
    ld [wTypingCharactersFlag], a ; enable typing text
    jr printNextChar

scrollDownTypingText: ;00:3E7B
    push bc ; store current char pos
    call scrolldownTypingMessageCaller
    pop bc
    jr printNextChar

fileNextPage: ;00:3E82
    call waitMessageForPlayerInput
    xor a
    ld [charTileXPosition], a
    ld [charTileYPosition], a
    push bc
    push hl
    ld hl, _SCRN0
    ld bc, $0400
.loop3E94
    call vblankWait
    ld [hl], $80
    inc hl
    dec bc
    ld a, b
    or a, c
    jr nz, .loop3E94
    pop hl
    pop bc
    jr printNextChar

; get char Tile XY position as Map address
getCharTileMapAddress: ;00:3EA3
    ld a, [charTileYPosition]
    add a
    add a
    add a
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, h
    add a, $98
    ld h, a
    ld a, [charTileXPosition]
    add a, l
    ld l, a
    ret