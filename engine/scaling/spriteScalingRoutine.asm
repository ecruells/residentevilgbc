loadAndScaleSpriteTileData:: ;00:299F
;hl: spriteTilesbuffer
;de: sprite frame pointer
    push hl ;store spriteTilesBuffer
    ld hl, _verticalScalingLookupTable ;$1397
    ld a, [wSprtPriorHeight]
    dec a
    add a
    add a, l ;VScaleLookupTable + ((height - 1) * 2)
    ld l, a
    ld a, $00
    adc a, h
    ld h, a
    ld c, [hl]
    inc hl
    ld b, [hl] ;load v-scale pointer to bc
    pop hl ;restore spriteTilesBuffer
loadAndScaleTileLoop:
    push bc ;store v-scale pointer
;get tile line bytes
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a ;store odd tile line in bc
    inc de
    push de ;store tile next line pointer
    push hl ; store spriteTilesBuffer
    ld a, [wCurrentRomBank]
    push af
    ld a, BANK(_horizontalScalingTable) ;$0A
    call BankSwitch
    ld hl, _horizontalScalingTable ;$4000
    ld a, [wSprtPriorWidth] ;base width
    and a, $0F ;mask width
    add a, h ;add h-scale offset to high byte
    ld h, a
    ld l, c ; add tile line subpixels low bits offset
    ld c, [hl] ;get h-scale value
    ld l, b ; add tile line subpixels high bits offset
    ld b, [hl] ;get h-scale value
    pop af ;back to sprite frames bank
    call BankSwitch
    ld a, h
    add a, $0D ;move to even line h-scale table
    ld h, a
    push bc ;store odd lines h-scale values
;get even line bytes
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    ld a, [wCurrentRomBank]
    push af
    ld a, BANK(_horizontalScalingTable) ;$0A
    call BankSwitch
    ld l, c
    ld c, [hl]
    ld l, b
    ld b, [hl]
    pop af
    call BankSwitch ;back to sprite frame bank
    pop de ;restore odd line scale values
    ld hl, Label2A07 ;$2A07 set return address
    push hl
    ld hl, _scalingFuncionTable ;$270B
    ld a, [wSprtPriorWidth]
    add a
    add a, l
    ld l, a
    ld a, $00
    adc a, h
    ld h, a ;scaling function pointer offset hl + (base width * 2)
    ld a, [hli]
    ld h, [hl]
    ld l, a ;set scaling funtion pointer to HL
    jp [hl]
Label2A07:
;de: odd line bytes
;bc: even line bytes
    pop hl ;restore sprite tiles buffer
;load sprite odd line tile data into buffer
    ld [hl], e ;store odd line low byte in buffer
    inc hl
    ld [hl], d ;store odd line high byte in buffer
    dec hl
    ld a, [wSpriteHalfBufferSize]
    add a, l ;add next half buffer offset
    ld l, a
    ld a, $00
    adc a, h
    ld h, a
;load even sprite tile data into buffer
    ld [hl], c
    inc hl
    ld [hl], b
    inc hl
    ld a, [wSpriteHalfBufferSize]
    ld e, a
    ld a, l
    sub a, e
    ld l, a
    ld a, h
	sbc a, $00 ;back to left sprite half buffer
	ld h, a
	pop de ;restore sprite frame pointer
	dec de ;back to line origin
	dec de
	pop bc ;restore v-scale pointer
	ld a, [bc] ;get v-scale value
	cp a, $FF
	ret z ;return if v-scale terminator
	add a
	add a, e ;add vscale value to sprite tile pointer
	ld e, a
	ld a, $00
	adc a, d
	ld d, a
	inc bc ;next vscale value
	jp loadAndScaleTileLoop

;00:2A37
