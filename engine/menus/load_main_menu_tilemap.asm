; a: menu mode (00: main menu, FF: itembox)
loadMainMenuTileMap: ;00:3728
    or a
    jr z, .mainMenuMode
.itemboxMode
    ld hl, itemBoxMenuTilemapStruct
    ld a, 32 ; tiles width
    call loadTileMapImage
    jr .Label3743
.mainMenuMode
    ld hl, mainMenuTilemapStruct
    ld a, 32 ; tiles width
    call loadTileMapImage
    call clearItemDetailWindowBgMap
    call clearItemDetailWindowTiles
.Label3743
; load main character face sprite
    ld a, BANK(mainMenuCharsFaces)
    call bankSwitch
    ld de, mainMenuCharsFaces
    ld hl, wSpriteTilesBuffer
    ld bc, 128
    call copyDataIntoVram
; load fonts tiles
    ld a, $01
    call bankSwitch
    call loadFontTiles
    ld a, [wSelectedCharacter]
    or a
    jr z, Label37B1 ; if chris
; if jill, copy two extra slots tiles (default tilemap has only 6 item slots)
    ld de, _SCRN0+$EC
    ld hl, _SCRN0+$AC
    ld bc, 8
    call copyDataIntoVram
    ld de, _SCRN0+$10C
    ld hl, _SCRN0+$CC
    ld bc, 8
    call copyDataIntoVram
    ld de, _SCRN0+$12C
    ld hl, _SCRN0+$EC
    ld bc, 8
    call copyDataIntoVram
; copy tiles attributes
    ld a, $01
    ld [rVBK], a ;vram bank select
    ld de, _SCRN0+$EC
    ld hl, _SCRN0+$AC
    ld bc, 8
    call copyDataIntoVram
    ld de, _SCRN0+$10C
    ld hl, _SCRN0+$CC
    ld bc, 8
    call copyDataIntoVram
    ld de, _SCRN0+$12C
    ld hl, _SCRN0+$EC
    ld bc, 8
    call copyDataIntoVram
    xor a
    ld [rVBK], a ;vram bank select
Label37B1
    call enableHDMA
    call hideSprites
    ret
;37B8
