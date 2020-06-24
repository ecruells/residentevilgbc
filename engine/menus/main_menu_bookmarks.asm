updateFileBookmarksCursors: ;01:42D3
    ld c, 192 ; bookmarks x position (hidden by default)
    ld a, [wMainMenuSelectedCursorId]
    cp a, FILE_MENU
    jr nz, .Label42DE ; not in file menu
; if in filebook submenu, show the bookmarks
    ld c, 73
.Label42DE
    ld hl, wOAMBufferC9+$50
    call getOamBufferAddress
    call updateFileBookmarksOam
    ld a, [wFileBookId]
    ld l, a
    ld h, 0 ; get filebook offset (3 filebook with 13 files per book)
    push hl
    add hl, hl
    add hl, hl
    push hl
    add hl, hl
    pop de
    add hl, de
    pop de
    add hl, de
    ld de, wFilesFlags
    add hl, de ; get filebook start file address
    ld e, l
    ld d, h
    ld hl, wSpriteTilesBufferCF
    ld b, MAX_FILES_PER_BOOK
loadFileBookmarkLoop:
    ld a, [wFileBookmarkCursorPos]
    ld c, a
    ld a, MAX_FILES_PER_BOOK
    sub a, c
    cp a, b
    jr z, .checkSelectedBookmark
    ld a, [de] ; get bookmark flag
    or a
    jr z, .loadEmptyBookmark
; load bookmark pixels data
    ld [hl], $00
    inc hl
    ld [hl], $1C
    inc hl
    ld [hl], $00
    inc hl
    ld [hl], $1C
    inc hl
    ld [hl], $FC
    inc hl
    ld [hl], $FC
    inc hl
    jr loadNextBookmarkSprite
.loadEmptyBookmark
    ld [hl], $00
    inc hl
    ld [hl], $00
    inc hl
    ld [hl], $00
    inc hl
    ld [hl], $00
    inc hl
    ld [hl], $00
    inc hl
    ld [hl], $00
    inc hl
    jr loadNextBookmarkSprite
.checkSelectedBookmark
    ld a, [de] ; get file flag
    or a
    jr nz, .loadSelectedBookmark ; if file is enabled
; load selected empty bookmark
    ld [hl], $04
    inc hl
    ld [hl], $00
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $00
    inc hl
    ld [hl], $FC
    inc hl
    ld [hl], $FC
    inc hl
    jr loadNextBookmarkSprite
.loadSelectedBookmark
    ld [hl], $1C
    inc hl
    ld [hl], $00
    inc hl
    ld [hl], $1C
    inc hl
    ld [hl], $00
    inc hl
    ld [hl], $FC
    inc hl
    ld [hl], $FC
    inc hl
loadNextBookmarkSprite:
    inc de ;next bookmark
    dec b
    jr nz, loadFileBookmarkLoop
    jp enableHDMA
;4368

; total bookmarks are composed of 3 sprites vertically
; c: x position
updateFileBookmarksOam: ;01:4368
; bookmarks part 1
    ld [hl], 44 ; y pos
    inc l
    ld [hl], c ; x pos
    inc l
    ld [hl], $40 ; tile id
    inc l
    ld [hl], 7 ; attributes
    inc l
; bookmarks part 2
    ld [hl], 60
    inc l
    ld [hl], c
    inc l
    ld [hl], $42
    inc l
    ld [hl], 7
    inc l
; bookmarks part 3
    ld [hl], 76
    inc l
    ld [hl], c
    inc l
    ld [hl], $44
    inc l
    ld [hl], 7
    ret
;4389