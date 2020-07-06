; load a tilemap image in vram 
; tilemap image has the following struct:
; - word: tilemap tiles data address 
; - word: tilemap map address 
; - byte: tilemap bank
; - word: tilemap attributes address 
; 
; params:
; a: tiles width
; hl: tilemap struct pointer
loadTileMapImage:: ;00:2FDC
    push af
    ld a, l
    ld [tilemapImgStructPointerLo], a
    ld a, h
    ld [tilemapImgStructPointerHi], a
    ld e, [hl] ; tilesData pointer in DE
    inc hl
    ld d, [hl]
    inc hl
    ld bc, 2 ; get tilesData bank
    add hl, bc
    ld a, [hl]
    call bankSwitch
    push hl
    ld hl, _VRAM+$800
    ld bc, $1000
    call copyDataIntoVram ; load tilesData into vram bank0
    ld a, $01
    ld [rVBK], a ;vram bank select
    ld hl, _VRAM+$800
    ld bc, $1000
    call copyDataIntoVram ; load tilesData into vram bank1
    xor a ; 0
    ld [rVBK], a ; vram bank select
    pop hl
    ld bc, -2 ; point to tilemapIndexes pointer
    add hl, bc
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld hl, _SCRN0
    pop bc ; get tiles width
.loadBgMapHLoop
    push hl
    ld c, 18 ; tiles height
.loadBgMapVLoop
    call vblankWait
    ld a, [de]
    add a, $80 ; offset tile index (tilemaps tiles in vram starts at $8800)
    ld [hl], a
    call loadBgMapTileAttributeValue
    inc de
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, 0
    ld h, a
    dec c
    jr nz, .loadBgMapVLoop
    pop hl
    inc l
    dec b
    jr nz, .loadBgMapHLoop
    ld a, $01
    jp bankSwitch


loadBgMapTileAttributeValue:: ;00:303A
    push bc
    push hl ; vram bg map address
    push de ; tile index pointer
    ld a, [tilemapImgStructPointerLo]
    ld l, a
    ld a, [tilemapImgStructPointerHi]
    ld h, a
    ld bc, 2 ; offset to tilemapIndexes
    add hl, bc
    ld e, [hl]
    inc hl
    ld d, [hl] ; de: tilemapIndexes pointer
    inc hl
    ld bc, 2 ; offset to paletteIndexes
    add hl, bc
    ld c, [hl]
    inc hl
    ld b, [hl] ; bc: bgMapAttributes pointer
    dec hl
    ld a, c
    sub a, e
    ld c, a
    ld a, b
    sbc a, d
    ld b, a ; get tilemapIndexes and bgMapAttributes pointer diff (bc = bc - de) 
    pop de ; restore current tilemap index pointer
    pop hl ; restore current bg map address
    push de
    ld a, e
    add a, c
    ld e, a
    ld a, d
    adc a, b
    ld d, a ; de: current bgmap tile attribute value
    ld a, 1
    ld [rVBK], a ; select vram bank 1
    call vblankWait
    ld a, [de]
    ld [hl], a
    xor a ; 0
    ld [rVBK], a ; return to vram bank 0
    pop de
    pop bc
    ret
