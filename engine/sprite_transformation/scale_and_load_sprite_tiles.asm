; hl: spriteTilesbuffer
; de: sprite frame pointer
;
; read and scale raw an entity sprite frame tiles and load it into tile buffer memory
;
scaleAndLoadSpriteTilesIntoBuffer: ;00:2687
; check height to get the number of tiles needed to store the scaled sprite parts vertically
    ld a, [wCurrentSpriteHeight]
    ld c, a
    and a, $0F ; mask height low nibble
    jr z, .Label2695 ; if height is multiple of 16, there's no need to round it up 
; but if not, the height is rounded up to the next multiple of 16
    ld a, c
    and a, $F0
    add a, 16
    ld c, a
; store the total data tiles needed vertically by sprite half
.Label2695
    ld a, c
    add a ; height x 2 (8x16 sprites require two 8x8 tiles data)
    ld [wSpriteHalfBufferSize], a
;
; now, we iterate by each sprite section and scale them. Each section is 16px width max
;
    ld a, [wCurrentSpriteWidthId]
    push af ; store width id value
    ld b, 2 ; sprite sections
.spriteSectionsLoop
    push bc ; store sections counter
    push hl ; store tiles buffer address

    call scaleAndLoadSpriteSectionData

; mask width Id high byte to offset to the right section shifting routines in the next iteration 
    ld a, [wCurrentSpriteWidthId]
    or a, %00010000
    ld [wCurrentSpriteWidthId], a
;
; check and clean left over buffer space used in previous frames when the height is not multiple of 16
;
    ld a, [wCurrentSpriteHeight]
    and a, $0F
    jr z, .offsetToNextSectionBuffer ; jump if height is multiple of 16, no buffer to clean
    ld c, a
    ld a, 16
; get number of leftover lines in buffer to clean
    sub a, c ; 16 - (height & 0xf)
    jr z, .offsetToNextSectionBuffer ; to jump, (height & 0xf) has to be 16, but that's not possible
;
; set number of leftover lines as loop counter, one for section lines parts (odd and even)
; b = c = (16 - (height & 0xf))
    ld c, a
    ld b, a
    push hl ; store sprite tiles buffer address
.cleanOddLinesBufferLoop
    ld [hl], 0
    inc hl
    ld [hl], 0
    inc hl
    dec c
    jr nz, .cleanOddLinesBufferLoop
    pop hl
; offset to even lines half buffer
    ld a, [wSpriteHalfBufferSize]
    add a, l
    ld l, a
    ld a, 0
    adc a, h
    ld h, a
.cleanEvenLinesBufferLoop
    ld [hl], 0
    inc hl
    ld [hl], 0
    inc hl
    dec b
    jr nz, .cleanEvenLinesBufferLoop

.offsetToNextSectionBuffer
    pop hl ; restore sprite tiles buffer address
    ld a, [wCurrentSpriteHeight]
    ld c, a
    and a, $0F
    jr z, .Label26E8 ; if height is multiple of 16, there's no need to round it up 
; else, "round up" height at multiple of 16, but...
    ld a, c
; ...is this a typo? it'd be $F0 to perfectly round up by 16, with this, the max round up height is 104. But
; it seems to cause any error, because with the later division by 16, has the same result as if with $F0
    and a, $F8
    add a, 16
    ld c, a ; roundedHeight = (height & 0xf8) + 16
.Label26E8
; now, we must offset to the next sprite section tile buffer, we need to offset by the number of tiles
; needed by a section half x 2
; ( roundedHeight / 16 ) * 32
;
; Actually, the method used is very inneficient, because of the "$F8" mask, the rounded up value has to
; be divided by 16, then, multiplied by 32, that's the same as just round up the height by multiple of 16
; and just multiply by 2 (roundedHeight * 2)
;
; TODO: refactor this to be more efficient
;
; roundedHeight / 16
    srl c
    srl c
    srl c
    srl c
; roundedHeight * 32
    sla c
    sla c
    sla c
    sla c
    sla c
    ld b, 0
; offset to the next sprite section tiles buffer address
    add hl, bc
    add hl, bc
    inc de
    inc de
    inc de
    inc de ; sprite frame tiles address + 4
    pop bc
    dec b
    jr nz, .spriteSectionsLoop
    pop af
    ld [wCurrentSpriteWidthId], a
    ret
    