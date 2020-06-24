displayLabComputerStartupBgMask: ;01:4C42
    ld a, 2
    ld [wRoomBgTileTopY], a
    ld a, 8
    ld [wRoomBgTileBottomY], a
    ld a, 7
    ld [wRoomBgTileLeftX], a
    ld a, 13
    ld [wRoomBgTileRightX], a
    ld hl, labComputerStartupBgMask ;$7BC5
    jp loadRoomBackgroundArea

showAndUpdateLabComputerKeyboard: ;01:4C5C
    ld a, 0
    ld [wRoomBgTileTopY], a
    ld a, 16
    ld [wRoomBgTileBottomY], a
    ld a, 0
    ld [wRoomBgTileLeftX], a
    ld a, 20
    ld [wRoomBgTileRightX], a
    ld hl, labComputerKeyboardBg ;$7BBF
    call loadRoomBackgroundArea
updateSelectedKeyboardKey:
    ld a, [wComputerKeyboardKeyId]
    ld c, a
    ld a, [wCompKeyboardKeyIdUpdated]
    cp a, c
    jr z, loadSelectedKeyTile
    ld bc, labComputerKeyboardBg ;$7BBF
    call loadKeyTileMask
loadSelectedKeyTile
    ld a, [wComputerKeyboardKeyId]
    ld bc, highlightedKeyboardKeysBg ;$7BC2
    jp loadKeyTileMask

loadKeyTileMask: ;01:4C8F
;a: key id
;bc: tile data address
    add a
    add a
    ld e, a
    ld d, 0
    ld hl, keyboardKeyPositionsList ;$4CAD
    add hl, de
    ld a, [hli]
    ld [wRoomBgTileLeftX], a
    ld a, [hli]
    ld [wRoomBgTileRightX], a
    ld a, [hli]
    ld [wRoomBgTileTopY], a
    ld a, [hli]
    ld [wRoomBgTileBottomY], a
    ld l, c
    ld h, b
    jp loadRoomBackgroundArea

keyboardKeyPositionsList: ;4CAD
; right | left | bottom | top
	db $02, $04, $07, $09 ; ESC
	db $04, $06, $07, $09 ; A
	db $06, $08, $07, $09 ; B
	db $08, $0A, $07, $09 ; C
	db $0A, $0C, $07, $09 ; D
	db $0C, $0E, $07, $09 ; E
	db $0E, $10, $07, $09 ; F
	db $10, $12, $07, $09 ; G
	db $02, $04, $09, $0B ; H
	db $04, $06, $09, $0B ; I
	db $06, $08, $09, $0B ; J
	db $08, $0A, $09, $0B ; K
	db $0A, $0C, $09, $0B ; L
	db $0C, $0E, $09, $0B ; M
	db $0E, $10, $09, $0B ; N
	db $10, $12, $09, $0F ; ENTER
	db $02, $04, $0B, $0D ; O
	db $04, $06, $0B, $0D ; P
	db $06, $08, $0B, $0D ; Q
	db $08, $0A, $0B, $0D ; R
	db $0A, $0C, $0B, $0D ; S
	db $0C, $0E, $0B, $0D ; T
	db $0E, $10, $0B, $0D ; U
	db $10, $12, $09, $0F ; ENTER
	db $02, $04, $0D, $0F ; V
	db $04, $06, $0D, $0F ; W
	db $06, $08, $0D, $0F ; X
	db $08, $0A, $0D, $0F ; Y
	db $0A, $0C, $0D, $0F ; Z
	db $0C, $10, $0D, $0F ; BACKSPACE
	db $0C, $10, $0D, $0F ; BACKSPACE
	db $10, $12, $09, $0F ; ENTER
;4D2D