; compare player position against room boundaries 
; and avoid player to move beyond room's limits
checkRoomBoundaries:: ;FD:43A0
    ld a, [wRoomId]
    ld l, a
    ld a, [wRoomIdHigh]
    ld h, a
    add hl, hl
    add hl, hl
    add hl, hl
    ld de, roomsBoundaries
    add hl, de
; check left border
    ld a, [wEntityPositionX]
    ld e, a
    ld a, [wEntityPositionX+1]
    ld d, a
    call div8WordFD
    push hl
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld a, d
    cp a, b
    jr nz, .checkRightBorder ; jump to next check if coordinates not match
; if match
    ld a, e
    cp a, c
    jr nc, checkTopBorder ; if inside left border
; else, set player x-pos to left limit
    ld e, c
    call multiply8SignedWordFD
    ld a, e
    ld [wEntityPositionX], a
    ld a, d
    ld [wEntityPositionX+1], a
    jr checkTopBorder ; jump to check y-axis
.checkRightBorder
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld a, d
    cp a, b
    jr nz, checkTopBorder ; jump to next check if coordinates not match
    ld a, e
    cp a, c
    jr c, checkTopBorder ; if inside right border
; else, set player x-pos to right limit
    ld e, c
    call multiply8SignedWordFD
    ld a, e
    ld [wEntityPositionX], a
    ld a, d
    ld [wEntityPositionX+1], a
checkTopBorder:
    pop hl
    ld bc, 4 ; offset to top border
    add hl, bc
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld a, [wEntityPositionZ]
    ld e, a
    ld a, [wEntityPositionZ+1]
    ld d, a
    call div8WordFD
    ld a, d
    cp a, b
    jr nz, .checkBottomBorder ; jump to next check if coordinates not match
    ld a, e
    cp a, c
    jr nc, finishBoundaryCheck ; finish if inside boundary
;else, limit player z-pos
    ld e, c
    call multiply8SignedWordFD
    ld a, e
    ld [wEntityPositionZ], a
    ld a, d
    ld [wEntityPositionZ+1], a
    jr finishBoundaryCheck
.checkBottomBorder
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld a, d
    cp a, b
    jr nz, finishBoundaryCheck ; finish if coordinates not match
    ld a, e
    cp a, c
    jr c, finishBoundaryCheck ; finish if inside boundary
;else, limit player z-pos
    ld e, c
    call multiply8SignedWordFD
    ld a, e
    ld [wEntityPositionZ], a
    ld a, d
    ld [wEntityPositionZ+1], a
finishBoundaryCheck:
    ret
;4430