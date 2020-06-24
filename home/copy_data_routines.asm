
; de: origin pointer
; hl: target pointer
; bc: bytes to copy
copyBytesData:: ;00:321C
    ld a, [de]
    ld [hli], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, copyBytesData
    ret

; unused copy data into vram routine, that add $80 offset to each copied byte.
; (maybe the target was vram BG Map)
;
; de: origin
; hl: destiny
; bc: data length
function3225: ;00:3225
    ld a, [rSTAT]  ;lcd status
    and a, STATF_LCD
    jr z, function3225
.waitVblankLoop
    ld a, [rSTAT]  ;lcd status
    and a, STATF_LCD
    jr nz, .waitVblankLoop
    ld a, [de]
    add a, $80
    ld [hli], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, function3225
    ret

; copy data into vram
;
; de: origin
; hl: destiny
; bc: data length
copyDataIntoVram: ;00:323C
    ld a, [rSTAT]  ;lcd status
    and a, STATF_LCD
    jr z, copyDataIntoVram
.waitVblankLoop
    ld a, [rSTAT]  ;lcd status
    and a, STATF_LCD
    jr nz, .waitVblankLoop
    ld a, [de]
    ld [hli], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, copyDataIntoVram
    ret

; de: tile data pointer
; hl: vram tile address
; bc: half tile counter (2 for copy a single tile)
copyTileDataInVram:: ;00:3251
; wait exit vblank
    ld a, [rSTAT]  ;lcd status
    and a, STATF_LCD
    jr z, copyTileDataInVram
.waitVblankLoop
    ld a, [rSTAT]  ;lcd status
    and a, STATF_LCD
    jr nz, .waitVblankLoop
; start copy (8 bytes per iteration)
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
; check if data pointer overflow bank
    ld a, d
    cp a, $80
    jr c, .Label3284
    sub a, $40
    ld d, a
    ld a, [wCurrentRomBank]
    inc a
    call bankSwitch
.Label3284
    dec bc
    ld a, b
    or a, c
    jr nz, copyTileDataInVram ; copy loop
    ret

; wait for lcd vblank state, if lcd is already in vblank, 
; wait for the next vblank period
vblankWait:: ;00:328A
    ld a, [rSTAT]  ;lcd status
    and a, STATF_LCD
    jr z, vblankWait
.waitVblankLoop
    ld a, [rSTAT]  ;lcd status
    and a, STATF_LCD
    jr nz, .waitVblankLoop
    ret
