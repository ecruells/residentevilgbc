; display tilemap or scenes rooms transitions animation (stairs, ladders, ropes, elevators)
displayTilemapRoomsTransitions: ;01:465F
    call resetPalettes
    call hideSprites
    ld a, [wDoorAnimationType]
    cp a, MANSION_ELEVATOR_1
    jr c, loadTilemapAnimation 
; if elevator types
    ld c, TAKING_ELEVATOR_TO_MAIN_LAB_SCENE
    cp a, MANSION_ELEVATOR_1
    jr z, loadElevatorEvent
    ld c, TAKING_ELEVATOR_FROM_MAIN_LAB_SCENE
    cp a, MANSION_ELEVATOR_2
    jr z, loadElevatorEvent
    ld c, TAKING_ELEVATOR_TO_KITCHEN_SCENE
    cp a, MANSION_ELEVATOR_3
    jr z, loadElevatorEvent
    ld c, TAKING_ELEVATOR_TO_LIBRARY_SCENE
    cp a, MANSION_ELEVATOR_4
    jr z, loadElevatorEvent
    ld c, TAKING_ELEVATOR_TO_HELIPORT_SCENE
    cp a, HELIPORT_ELEVATOR_1
    jr z, loadElevatorEvent
    ld c, TAKING_ELEVATOR_FROM_HELIPORT_SCENE
; elevators are displayed as an event scene
loadElevatorEvent:
    ld a, c
    ld [wEventSceneId], a
    pop de
    jp gameLoopWithEventCheck
;
; tilemaps animation
loadTilemapAnimation
    ld a, [wDoorAnimationType]
    ld hl, stairsTypeATilemapStruct
    cp a, STAIRS_2_UPWARD
    jr c, .label46BD
    ld hl, stairsTypeBTilemapStruct
    cp a, STAIRS_3_UPWARD
    jr c, .label46BD
    ld hl, stairsTypeCTilemapStruct
    cp a, LADDER_1_UPWARD
    jr c, .label46BD
    ld hl, ladderTypeATilemapStruct
    cp a, ROPE_UPWARD
    jr c, .label46BD
    ld hl, ropeTilemapStruct
    cp a, LADDER_2_UPWARD
    jr c, .label46BD
    ld hl, ladderTypeBTilemapStruct
.label46BD
    ld a, 20 ; tiles width
    call loadTileMapImage
; duplicate tilemap vertically on vram BG map
    xor a
    ld [rVBK], a ;vram bank select
    ld hl, _SCRN0+$240 ;$9A40
    ld de, _SCRN0
    ld bc, $1C0
    call copyDataIntoVram
; duplicate attributes
    ld a, 1
    ld [rVBK], a ;vram bank select
    ld hl, _SCRN0+$240
    ld de, _SCRN0
    ld bc, $1C0
    call copyDataIntoVram
    xor a
    ld [rVBK], a ;vram bank select
    xor a
    ld [wScreenYPos], a ; 
    ld a, SET_FADE_IN
    ld [wPaletteFadeCounter], a
    ld a, $80
    ld [wBgTransitionDirCounter], a
roomBgTransitionLoop:
    call haltCPU
    call haltCPU
    ld a, [wPaletteFadeCounter]
    cp a, FADE_OUT_FINISHED
    jr z, finishBgTransition
    ld a, [wBgTransitionDirCounter]
    dec a
    ld [wBgTransitionDirCounter], a
    jr nz, .Label470D
    ld a, SET_FADE_OUT
    ld [wPaletteFadeCounter], a
.Label470D
    ld a, [wDoorAnimationType]
    and a, $01 ; mask first bit to get transition direction (00: upward, 01:downward)
    jr z, .upwardTransition
.downwardTransition
    ld a, [wBgTransitionDirCounter]
    and a, $0F
    ld e, a
    ld d, $00
    ld hl, downwardTransitionValues
    add hl, de
    ld a, [wScreenYPos]
    add a, [hl]
    ld [wScreenYPos], a
    jr .loadBgTransitionPalette
.upwardTransition
    ld a, [wBgTransitionDirCounter]
    and a, $0F
    ld e, a
    ld d, $00
    ld hl, upwardTransitionValues
    add hl, de
    ld a, [wScreenYPos]
    add a, [hl]
    ld [wScreenYPos], a
.loadBgTransitionPalette
    ld a, [wDoorAnimationType]
    ld hl, stairsTypeATilemapStruct+8
    cp a, STAIRS_2_UPWARD
    jr c, .label4765
    ld hl, stairsTypeBTilemapStruct+8
    cp a, STAIRS_3_UPWARD
    jr c, .label4765
    ld hl, stairsTypeCTilemapStruct+8
    cp a, LADDER_1_UPWARD
    jr c, .label4765
    ld hl, ladderTypeATilemapStruct+8
    cp a, ROPE_UPWARD
    jr c, .label4765
    ld hl, ropeTilemapStruct+8
    cp a, LADDER_2_UPWARD
    jr c, .label4765
    ld hl, ladderTypeBTilemapStruct+8
.label4765
    call loadBgImagePalette
    jr roomBgTransitionLoop
finishBgTransition:
    xor a
    ld [wScreenYPos], a
    ret
;476F

upwardTransitionValues: ;01:476F
	db 0, 0, 0, 0, 0, 0, 0, -1, -1, -1, -1, -2, -2, -3, -4, -5

downwardTransitionValues: ;01:477F
	db 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 3, 4, 5