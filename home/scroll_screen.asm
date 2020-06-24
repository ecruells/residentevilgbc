scrollDownScreen: ;00:0C4C
    ld c, -1 ; pixel offset
    jr setScrollPixels
scrollUpScreen: ;00:0C50
    ld c, 1 ; pixel offset
setScrollPixels:
    ld b, 16 ; scroll screen 16px
.scrollScreenLoop
    push bc
    call haltCPU
    call haltCPU
    ld a, [wScreenYPos]
    sub a, c
    ld [wScreenYPos], a
    call syncSpritesYPositionWithScroll
    pop bc
    dec b
    jr nz, .scrollScreenLoop
    ret
;C6A

; c: y-offset
syncSpritesYPositionWithScroll: ;00:0C6A
    ld hl, wOAMBufferC9
    call syncSpritesYPosInOAMBuffer
    ld hl, wOAMBufferCA
syncSpritesYPosInOAMBuffer:
    ld de, 4
    ld b, 40
.updateYPosLoop
    ld a, [hl]
    add a, c
    ld [hl], a
    add hl, de
    dec b
    jr nz, .updateYPosLoop
    ret
;0C80