displayFile: ;6E35
    call resetPalettes
    call hideSprites
    call loadFontTiles
    ld a, UPDATE_BG_PALETTE
    ld [wPaletteFadeCounter], a
    ld hl, 0
    ld b, 7
.clearScreenLoop
    push bc
    push hl
    ld bc, ClearTextboxText
    ld a, BANK(ClearTextboxText)
    call printTextString
    pop hl
    inc h
    inc h
    inc h
    pop bc
    dec b
    jp nz, .clearScreenLoop
    call haltCPU
    ld a, BANK(greyPalette)
    ld hl, greyPalette
    call loadBgPalette
    ld hl, FileTextsPointers
    ld a, [wFileBookId]
    ld c, a
    add a
    add a
    ld b, a
    add a
    add a, b
    add a, c
    ld c, a
    ld a, [wFileBookmarkCursorPos]
    add a, c
    ld b, a
    add a
    add a, b
    ld c, a
    ld b, $0
    add hl, bc ; get file text pointer
    call printFileText
    call waitMessageForPlayerInput
; exit file
    call resetPalettes
    ret
;6E89

printFileText: ;01:6E89
    ldde 0, 0
    call printTextAtPosition
    ret
;6E90
