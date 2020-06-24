; hl: tilemap address
; de: 16bit value to print
printDebugWord:: ;01:4408
    ld a, d
    srl a
    srl a
    srl a
    srl a
    ld c, a
    call printDebugChar
    ld a, d
    and a, $0F
    ld c, a
    call printDebugChar
    ld a, e
    srl a
    srl a
    srl a
    srl a
    ld c, a
    call printDebugChar
    ld a, e
    and a, $0F
    ld c, a
    call printDebugChar
    ret

printDebugChar:: ;01:4431
    ld a, c
    cp a, $0A
    jr c, .Label4440
    sub a, $0A
    ld c, a
    add a
    add a, c
    add a, $E3
    ld c, a
    jr .Label4445
.Label4440
    add a
    add a, c
    add a, $B0
    ld c, a
.Label4445
    call vblankWait
    ld [hl], c
    ld a, $01
    ld [rVBK], a ;vram bank select
    call vblankWait
    ld [hl], $09
    inc hl
    xor a
    ld [rVBK], a ;vram bank select
    ret