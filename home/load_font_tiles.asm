loadFontTiles:: ;00:37B8
    ld de, mainFont
    jr Label37C0
loadMainFontsBold: ;37BD
    ld de, mainFontBold
Label37C0:
    ld a, $01
    ld [rVBK], a ;vram bank select
    ld a, BANK(mainFontBold)
    call bankSwitch
    ld hl, _VRAM+$800
    ld bc, 2048
    call copyDataIntoVram
    ld a, $01
    call bankSwitch
    xor a
    ld [rVBK], a ;vram bank select
    ret
