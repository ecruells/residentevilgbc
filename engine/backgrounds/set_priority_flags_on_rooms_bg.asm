; check for special rooms screens and set the priority flag on some BG MAP tiles, maybe, for another
; planned solution for rooms bgs overlaps, but only the Main Lab Entry room, screen 05 is checked,
; which screen is not present in this build, so the purpose of this routine is useless.
setPriorityFlagsOnSpecialRoomScreenTiles: ;FD:5297
    ld a, [wRoomId]
    cp a, MAIN_LAB_ENTRY ; corridor to tyrant's room
    jp z, setMainLabEntryPriorityTiles
    ret

setMainLabEntryPriorityTiles:: ;FD:52A0
    ld a, [wRoomCameraId]
    cp a, 5 ; non existent screen in this build
    jr z, .Label3F52A8
    ret
; checking the original screen, the following tiles correspond to a corner
.Label3F52A8: ;FD:52A8
    ld hl, _SCRN0+$131 ; tile 17,09
    ld b, 2
    call setPriorityFlags
    ld hl, _SCRN0+$151 ; tile 17,10
    ld b, 2
    call setPriorityFlags
    ld hl, _SCRN0+$171 ; tile 17,11
    ld b, 2
    call setPriorityFlags
    ld hl, _SCRN0+$191 ; tile 17,12
    ld b, 2
    call setPriorityFlags
    ld hl, _SCRN0+$1B1 ; tile 17,13
    ld b, 2
    call setPriorityFlags
    ld hl, _SCRN0+$1D1 ; tile 17,14
    ld b, 2
    call setPriorityFlags
    ret

setPriorityFlags:: ;FD:52D9
    ld a, $01
    ld [rVBK], a ;vram bank select
.loop3F52DD
    call vblankWait
    ld a, [hl]
    or a, OAMF_PRI ; set tile priority flag
    ld [hli], a
    dec b
    jr nz, .loop3F52DD
    xor a
    ld [rVBK], a ;vram bank select
    ret
    