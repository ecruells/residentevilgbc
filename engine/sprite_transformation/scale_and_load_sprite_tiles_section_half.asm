; this routine scale one half of an entity sprite based on its width and height
;
; This iterate by the corresponding vertical scale array length. By each
; iteration, a sprite frame tile data line is read, shrank, shifted and stored
; into the tile buffer. At the end of the loop, the vscale value is evaluated
; to determine if the loop is break or continued, scaling down or up the tile data.
;
; 
; hl: spriteTilesbuffer
; de: sprite frame pointer
;
scaleAndLoadSpriteSectionData:: ;00:299F
    push hl  ; store spriteTilesBuffer
    ld hl, verticalScaleLookupTable ;$1397
    ld a, [wCurrentSpriteHeight]
    dec a
    add a
    add a, l ; verticalScaleLookupTable + ((height - 1) * 2)
    ld l, a
    ld a, 0
    adc a, h
    ld h, a
    ld c, [hl]
    inc hl
    ld b, [hl] ; load vscale pointer to bc
    pop hl ; restore spriteTilesBuffer
loadAndScaleTileLoop:
    push bc ; store vscale pointer
;
; get odd line bytes into bc
;
    ld a, [de]
    ld c, a ; top subpixels
    inc de
    ld a, [de]
    ld b, a ; bottom subpixels
    inc de
    push de ; store tile next line pointer
    push hl ; store spriteTilesBuffer
;
; shrink odd line, getting the shink pattern table based in current sprite width, then get the subpixels
; shrank byte value using the original subpixel value as index (0-FF)
;
    ld a, [wCurrentRomBank]
    push af
    ld a, BANK(horizontalShinkingLookupTable)
    call bankSwitch
    ld hl, horizontalShinkingLookupTable
;
; get pattern table ID based on current width ID masking its lower nibble. Remember that before, the width id was 
; validated to not be greater than 12, because there's only 12 shrinking pattern tables by line.
;
    ld a, [wCurrentSpriteWidthId]
    and a, $0F  ; mask ID
    add a, h ; add pattern id with shrink LUT address high byte to offset tables ($40 + ID)
    ld h, a
    ld l, c ; add subpixel value with shrink LUT address low byte to offset shrink value ($00 + value)
    ld c, [hl] ; get top subpixels shrinked value
; the same as above, but with lower subpixels
    ld l, b
    ld b, [hl] ; get bottom subpixels shrinked value
;
    pop af ; back to sprite frames bank
    call bankSwitch
    ld a, h
    add a, 13 ; offset to the even line shrinking pattern table ($40 + ID + 13)
    ld h, a
; 
; store odd lines shrank values
    push bc 
;
; get the even line shrank values the same way as the odd line
;
    ld a, [de]
    ld c, a ; top subpixels
    inc de
    ld a, [de]
    ld b, a ; bottom subpixels
    ld a, [wCurrentRomBank]
    push af
    ld a, BANK(horizontalShinkingLookupTable) ;$0A
    call bankSwitch
; 
; we are already positioned in the correct table, so we only need to offset by the subpixel value
    ld l, c
    ld c, [hl] ; get top subpixels shrinked value
    ld l, b
    ld b, [hl] ; get bottom subpixels shrinked value
;
; back to sprite frame bank
    pop af
    call bankSwitch
    pop de ; restore odd line scaled values
; de: shrank odd line  value
; bc: shrank even line value
;
; now, we must shift the shrank values to join them.
; there're 12 different shifting routines by shrank pattern by sprite section, so we offset by width ID to 
; get the routing address
;
    ld hl, shiftingRoutineReturnAddress ; set the return address of the shifting routine
    push hl
    ld hl, shrankLinesShiftingRoutines
    ld a, [wCurrentSpriteWidthId]
    add a
    add a, l
    ld l, a
    ld a, 0
    adc a, h
    ld h, a ; shrankLinesShiftingRoutines offset hl + (widthId * 2)
    ld a, [hli]
    ld h, [hl]
    ld l, a
; shift the shrank horizontal line with its corresponding shifting routine
;
    jp hl ; jp shrankLinesShiftingRoutines + routine offset
;
shiftingRoutineReturnAddress:
; DE-BC shank and shifted lines
; 
; now, we store the shrank and joined line into the tiles buffer memory
;
    pop hl ; restore sprite tiles buffer address
;
; load sprite odd line tile data into buffer
    ld [hl], e ; load odd line top subpixel into buffer
    inc hl
    ld [hl], d ; load odd line bottom subpixels into buffer
    dec hl
    ld a, [wSpriteHalfBufferSize]
    add a, l ; offset to the right 8px half section by the half buffer size
    ld l, a
    ld a, 0
    adc a, h
    ld h, a
;
; load even sprite tile data into buffer
    ld [hl], c ; load even line top subpixel into buffer
    inc hl
    ld [hl], b ; load even line bototm subpixel into buffer
    inc hl
    ld a, [wSpriteHalfBufferSize]
    ld e, a
    ld a, l
    sub a, e
    ld l, a
    ld a, h
	sbc a, 0 ; back to left sprite half buffer
	ld h, a
; 
; now, we check the vertical scale value to determine if we must keep looping (scaling down or up)
; or terminate the scaling loop
;
	pop de ; restore sprite frame pointer
	dec de ; back to line origin
	dec de
	pop bc ; restore vscale pointer
	ld a, [bc] ; get vscale value
	cp a, $FF
	ret z ; if vscaleValue == $FF then break the loop and return
;
; To vertically scale, we need to either skip lines (scale down) or duplicate lines (scale up).
;
; A sprite half section line is 4bytes long (16px), so to skip a line, we need to offset the sprite
; frame pointer at least 4Bytes for the next loop.
; To duplicate a line, we need to keep in the same sprite frame pointer in the next loop, so we
; need a vscale value of 0.
;
	add a ; vscale value x 2 (min vscale value in LUT is 2, and we need at least 4 to skip a line)
	add a, e ; add vscale value offset to sprite frame pointer
	ld e, a
	ld a, 0
	adc a, d
	ld d, a
	inc bc ; next vscale value
	jp loadAndScaleTileLoop

;00:2A37
