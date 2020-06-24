updateFilebookSubmenuTilemap: ;00:35BF
    ld hl, fileBook01TilemapStruct
    ld a, [wFileBookId]
    or a ; 0
    jr z, .Label35D5
    ld hl, fileBook02TilemapStruct
    ld a, [wFileBookId]
    cp a, 1
    jr z, .Label35D5
	; else 2
    ld hl, fileBook03TilemapStruct
.Label35D5
    jr loadSubmenuTilemap
;35D7


updateItemSubmenuTilemap: ;35D7
    ld hl, itemUseOptionTilemapStruct
    ld a, [wMainMenuSelectedCursorId]
    cp a, USE_EQUIP_CURSOR
    jr z, .Label35EB
    ld hl, itemCheckOptionTilemapStruct
    cp a, CHECK_ITEM_CURSOR
    jr z, .Label35EB
	; COMBINE_CURSOR
    ld hl, itemCombineOptionTilemapStruct
.Label35EB
    jr loadSubmenuTilemap

updateMapSubmenuTilemap: ;35ED
    ld hl, mapMenuTilemapStruct
    jr loadSubmenuTilemap

; hl: submenu tilemap struct pointer
loadSubmenuTilemap:
    ld c, [hl] ; get tilemap bank
    inc hl
    inc hl
    ld e, [hl]
    inc hl
    ld d, [hl] ; get tilemap pointer
    inc hl
    ld a, [hli]
    ld [wRoomBgTilesDataPointerLo], a
    ld a, [hli]
    ld [wRoomBgTilesDataPointerHi], a ; get tiles data pointer
    push bc
    push hl
    ld a, c
    call bankSwitch
    ld a, $01
    ld [rVBK], a ; vram bank select
    ld hl, _VRAM+$1000 ; menu detail window address
    ld b, 11 * 8 ; menu detail windows tiles count
.loadSubmenuTilesLoop
    push bc
    push hl
    ld a, [de] ; get tile id
    ld l, a
    ld h, 0
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, [wRoomBgTilesDataPointerLo]
    ld c, a
    ld a, [wRoomBgTilesDataPointerHi]
    ld b, a
    add hl, bc ; get tile data pointer
    ld c, l
    ld b, h ; bc: tile data pinter
    pop hl ; restore vram tile address
    ld a, 4 ; * 4 bytes per tile
.loadTileBytesLoop
    push af
    call vblankWait
    ld a, [bc]
    ld [hli], a
    inc bc
    ld a, [bc]
    ld [hli], a
    inc bc
    ld a, [bc]
    ld [hli], a
    inc bc
    ld a, [bc]
    ld [hli], a
    inc bc
    pop af
    dec a
    jr nz, .loadTileBytesLoop
    inc de ; next tile id
    pop bc
    dec b
    jr nz, .loadSubmenuTilesLoop
;
; load tilemap attrubutes
    xor a
    ld [rVBK], a ;vram bank select
    pop hl ; restore tilemap attributes pointer
    pop bc ; restore bank
    ld a, $01
    call bankSwitch
    ld e, [hl]
    inc hl
    ld d, [hl] ; get tile attributes pointer
    inc hl
    push hl
    ld a, c
    call bankSwitch
    call loadDetailWindowTilemapAttributes
;
; load tilemap palette
    pop hl
    ld a, $01
    call bankSwitch
    ld c, [hl] ; get palette bank
    inc hl
    inc hl
    ld a, [hli]
    ld h, [hl]
    ld l, a ; get palette pointer
    ld a, c
    jp loadBgPalette
;3667

loadMainMenuPalette: ;3667
    ld a, BANK(mainMenuPalette)
    ld hl, mainMenuPalette
    jp loadBgPalette
;366F
