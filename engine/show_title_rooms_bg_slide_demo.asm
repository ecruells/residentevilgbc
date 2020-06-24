showTitleRoomsBgsSlideDemo: ;01:478F
    call resetPalettes
    call hideSprites
    ld hl, $7FF ; set slide demo frame counter & timer
    ld a, l
    ld [wTicksCounter], a
    ld a, h
    ld [wTicksCounterHigh], a
    ld a, SET_FADE_IN
    ld [wPaletteFadeCounter], a
.loop47A5
    call haltCPU
    ld a, [wTicksCounterHigh]
    add a
    ld l, a
    ld h, 0
    ld de, slideRoomsList
    add hl, de
    ld a, [hli]
    ld [wRoomId], a
    ld a, [hli]
    ld [wRoomCameraId], a
    xor a
    ld [wRoomIdHigh], a
    ld a, [wTicksCounterHigh]
    push af
    ld a, [wTicksCounter]
    push af
    ld a, [wTicksCounter]
    cp a, $FF
    call z, loadRoomScreenCameraAndBgData
    pop af
    ld [wTicksCounter], a
    pop af
    ld [wTicksCounterHigh], a
    ld a, [wButtonPressId]
    and a, START_INPUT
    jr z, .Label47FA
; if start button is pressed
    ld a, [wTicksCounterHigh]
    or a
    jr nz, .Label47F1
    ld a, [wTicksCounter]
    cp a, $20
    jr nc, .Label47F1
    call resetPalettes
    jp initGame
.Label47F1
    xor a
    ld [wTicksCounterHigh], a
    ld a, $1F
    ld [wTicksCounter], a
.Label47FA
    ld a, [wTicksCounter]
    dec a
    ld [wTicksCounter], a
    cp a, $FF
    jr nz, .Label4813
    ld a, [wTicksCounterHigh]
    dec a
    ld [wTicksCounterHigh], a
    cp a, $FF
    jr nz, .Label4813
    jp initGame
.Label4813
	ld a, [wTicksCounter]
    cp a, $E0
    jr nc, .Label4820
    cp a, $20
    jr c, .Label4827
    jr .Label4830
.Label4820
    sub a, $E0 ; revert fade effect
    ld [wPaletteFadeCounter], a
    jr .Label4830
.Label4827
    ld c, a
    ld a, MAX_FADE_STEPS
    sub a, c
    add a, SET_FADE_OUT
    ld [wPaletteFadeCounter], a
.Label4830
    call updateRoomPalette
    jp .loop47A5

slideRoomsList::
	;  roomId,                  cameraId
	db UNDERGROUND_PASSAGE_2,   4
	db HALLWAY_TO_EAST_TERRACE, 2
	db EAST_STAIRCASE_2F,       1
	db TREVORS_TOMB,            2
	db COURTYARD_FLOODGATE,     3
	db AQUA_TANK_STOREROOM,     0
	db VISUAL_DATA_ROOM,        1
	db EAST_STOREROOM,          0
;4846