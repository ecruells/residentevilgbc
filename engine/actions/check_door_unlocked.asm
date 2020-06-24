; check if a door is unlocked. Returns true ($FF) if is unlocked, if not, return false ($00)
;
; hl: door struct pointer
checkDoorUnlocked: ;C5:674A
    push bc
    push de
    push hl
    ld e, l
    ld d, h ; de: door struct pointer
    ld hl, doorsIdsTable
findDoorLoop
    ld c, [hl]
    inc hl
    ld b, [hl] ; get door pointer
    inc hl
    ld a, c
    or a, b
    jp z, invalidDoorPointer ; if it's an invalid pointer, the game gets stuck in an infinite loop
    ld a, e
    cp a, c
    jr nz, checkNextDoorPointer ; door pointer is not equal
    ld a, d
    cp a, b
    jr nz, checkNextDoorPointer ; door pointer is not equal
; door pointer found, now get its flag value
    ld a, [hl] ; get door flag id
    ld [wDoorLockFlagId], a
    ld e, a
    ld d, 0
    ld hl, wDoorsLocksFlags
    add hl, de
    ld a, [hl] ; get dock lock flag value
    or a
    jr z, tryToUnlockDoor ; if door is locked
; return dook lock value
    pop hl
    pop de
    pop bc
    ret
checkNextDoorPointer ;C5:6776
    inc hl
    inc hl
    jr findDoorLoop

; try to unlock a locked door by checking keys in inventory, events or conditions
;
; a: door id
tryToUnlockDoor:
    ld a, [wRoomId]
    or a ; MAIN_HALL_1F
    jp z, checkMainHall1FLockedDoor
    cp a, F_SHAPED_CORRIDOR
    jp z, checkFShapedCorridorLockedDoors
    cp a, EXHIBITION_ROOM
    jp z, checkExhibitionRoomLockedDoors
    cp a, REST_STOP_CORRIDOR
    jp z, checkRestStopCorridorLockedDoors
    cp a, WEST_STAIRCASE_1F
    jp z, checkWestStaircase1FLockedDoors
    cp a, NORTH_EAST_CORRIDOR_1F
    jp z, checkNorthEastCorridor1FLockedDoors
    cp a, BACK_ENTRANCE_CORRIDOR
    jp z, checkBackEntranceCorridorLockedDoors
    cp a, ELEVATOR_STAIRWAY
    jp z, checkElevatorStairwayLockedDoors
    cp a, OUTDOOR_AREA
    jp z, checkOutdoorAreaLockedDoors
    cp a, PILLAR_CORRIDOR
    jp z, checkPillarCorridorLockedDoors
    cp a, LOUNGE_ROOM
    jp z, checkLoungeRoomLockedDoors
    cp a, EAST_STAIRCASE_2F
    jp z, checkEastStaircase2FLockedDoors
    cp a, U_SHAPED_CORRIDOR
    jp z, checkUShapedCorridorLockedDoors
    cp a, TREVORS_TOMB
    jp z, checkTrevorsTombLockedDoors
    cp a, ATTIC_ENTRY
    jp z, checkAtticEntryLockedDoors
    cp a, HELIPAD_LOOKOUT_ROOM
    jp z, checkHelipadLookoutRoomLockedDoors
    cp a, WEST_STAIRCASE_2F
    jp z, checkWestStaircase2FLockedDoors
    cp a, AQUA_TANK_ROOM
    jp z, checkAquaTankRoomLockedDoors
    cp a, DORMITORY_CORRIDOR
    jp z, checkDormitoryCorridorLockedDoors
    cp a, BEEHIVE_PASSAGE
    jp z, checkBeehivePassageLockedDoors
    cp a, LAB_CENTRAL_CLOISTER
    jp z, checkLabCentralCloisterLockedDoors
    cp a, OPERATING_MORGE_ROOM
    jp z, checkOperatingMorgeRoomLockedDoors
doorCouldNotBeOpened:
    xor a
    pop hl
    pop de
    pop bc
    ret
doorUnlocked: ;C5:67EF
    ld a, $FF
    pop hl
    pop de
    pop bc
    ret
;67F5

invalidDoorPointer: ;C5:67F5
    jr invalidDoorPointer

checkMainHall1FLockedDoor:
    ld a, e
    cp a, DOOR_02
    jr z, .Label3167FF
    jp doorCouldNotBeOpened
.Label3167FF
    ld c, ARMOR_KEY
    call searchKeyInInventory
    or a
    jp z, doorCouldNotBeOpened
    ld [hl], $FF
    jp doorUnlocked

checkFShapedCorridorLockedDoors: ;C5:680D
    ld a, e
    cp a, DOOR_06 ; door to first zombie corridor
    jr z, Label316819
    cp a, DOOR_07 ; door to zombie closet bedroom
    jr z, Label316823
    jp doorCouldNotBeOpened
Label316819
    ld [hl], $FF
    ld a, $FF
    ld [wFShapedCorridorOneWayLockedDoorFlag], a
    jp doorUnlocked
Label316823
    ld a, [wEntityId]
    cp a, JILL
    jr z, Label316838 ; skip if jill, because she has the lockpick
; if chris, search sword key
    ld c, SWORD_KEY
    call searchKeyInInventory
    or a
    jp z, doorCouldNotBeOpened
    ld [hl], $FF
    jp doorUnlocked
Label316838
    ld a, [wBackToMainHallAsJillEventFlag]
    or a
    jp z, doorCouldNotBeOpened ; avoid open sword key doors before get the lockpick
    ld [hl], $FF
    jp doorUnlocked

checkExhibitionRoomLockedDoors:
    ld a, e
    cp a, DOOR_0B ; door to first cerberus corridor
    jr z, Label31684C
    jp doorCouldNotBeOpened
Label31684C
    ld a, [wEntityId]
    cp a, JILL
    jr z, Label316861 ; check lockpick
; if chris
    ld c, SWORD_KEY
    call searchKeyInInventory
    or a
    jp z, doorCouldNotBeOpened
    ld [hl], $FF
    jp doorUnlocked
Label316861
    ld a, [wBackToMainHallAsJillEventFlag]
    or a
    jp z, doorCouldNotBeOpened ; avoid open sword key doors before get the lockpick
    ld [hl], $FF
    jp doorUnlocked

checkRestStopCorridorLockedDoors:
    ld a, e
    cp a, DOOR_0C ; door to piano room
    jr z, Label316875
    jp doorCouldNotBeOpened
Label316875
    ld a, [wEntityId]
    cp a, JILL
    jr z, Label31688A ; check lockpick
; if chris
    ld c, SWORD_KEY
    call searchKeyInInventory
    or a
    jp z, doorCouldNotBeOpened
    ld [hl], $FF
    jp doorUnlocked
Label31688A
    ld a, [wBackToMainHallAsJillEventFlag]
    or a
    jp z, doorCouldNotBeOpened ; avoid open sword key doors before get the lockpick
    ld [hl], $FF
    jp doorUnlocked

checkWestStaircase1FLockedDoors:
    ld a, e
    cp a, DOOR_0E ; door to broken shotgun room
    jr z, Label31689E
    jp doorCouldNotBeOpened
Label31689E
    ld c, ARMOR_KEY
    call searchKeyInInventory
    or a
    jp z, doorCouldNotBeOpened
    ld [hl], $FF
    jp doorUnlocked

checkNorthEastCorridor1FLockedDoors:
    ld a, e
    cp a, DOOR_11 ; bathroom corridor exterior door
    jr z, Label3168B4
    jp doorCouldNotBeOpened
Label3168B4
    ld c, ARMOR_KEY
    call searchKeyInInventory
    or a
    jp z, doorCouldNotBeOpened
    ld [hl], $FF
    jp doorUnlocked

checkBackEntranceCorridorLockedDoors:
    ld a, e
    cp a, DOOR_16 ; eagle medal room door
    jr z, Label3168CA
    jp doorCouldNotBeOpened
Label3168CA
    ld c, HELMET_KEY
    call searchKeyInInventory
    or a
    jp z, doorCouldNotBeOpened
    ld [hl], $FF
    jp doorUnlocked

checkElevatorStairwayLockedDoors:
    ld a, e
    cp a, DOOR_0D ; one way locked door to first zombie corridor
    jr z, Label3168E0
    jp doorCouldNotBeOpened
Label3168E0
    ld [hl], $FF
    jp doorUnlocked

checkOutdoorAreaLockedDoors:
    ld a, e
    cp a, DOOR_11 ; door to corrdior 0A
    jr z, Label3168ED
    jp doorCouldNotBeOpened
Label3168ED
    ld c, ARMOR_KEY
    call searchKeyInInventory
    or a
    jp z, doorCouldNotBeOpened
    ld [hl], $FF
    jp doorUnlocked

checkPillarCorridorLockedDoors:
    ld a, e
    cp a, DOOR_28 ; door to corridor 2D
    jr z, Label316903
    jp doorCouldNotBeOpened
Label316903
    ld [hl], $FF
    ld a, $FF
    ld [wDoorsLocksFlags+DOOR_7B], a ; unlock door
    jp doorUnlocked

checkLoungeRoomLockedDoors:
    ld a, e
    cp a, DOOR_2A ;door to yawn 2 room
    jr z, Label316915
    jp doorCouldNotBeOpened
Label316915
    ld c, HELMET_KEY ;$2F
    call searchKeyInInventory
    or a
    jp z, doorCouldNotBeOpened
    ld [hl], $FF
    ld a, $FF
    ld [wDoorsLocksFlags+DOOR_7B], a ; unlock door
    jp doorUnlocked

checkEastStaircase2FLockedDoors:
    ld a, e
    cp a, DOOR_33 ; locked door to room 2E
    jr z, Label316934
    cp a, DOOR_32 ; one way locked door to corridor 27
    jr z, Label316942
    jp doorCouldNotBeOpened
Label316934
    ld c, ARMOR_KEY
    call searchKeyInInventory
    or a
    jp z, doorCouldNotBeOpened
    ld [hl], $FF
    jp doorUnlocked
Label316942
    ld [hl], $FF
    ld a, $FF
    ld [wDoorsLocksFlags+DOOR_7D], a ; unlock door
    jp doorUnlocked

checkUShapedCorridorLockedDoors:
    ld a, e
    cp a, DOOR_79 ; door to richard room
    jr z, Label316958
    cp a, DOOR_31 ; door to armors room
    jr z, Label316966
    jp doorCouldNotBeOpened
Label316958
    ld c, ARMOR_KEY
    call searchKeyInInventory
    or a
    jp z, doorCouldNotBeOpened
    ld [hl], $FF
    jp doorUnlocked
Label316966
    ld c, ARMOR_KEY
    call searchKeyInInventory
    or a
    jp z, doorCouldNotBeOpened
    ld [hl], $FF
    jp doorUnlocked

checkTrevorsTombLockedDoors:
    ld a, e
    cp a, DOOR_33 ; locked door to room 2E?
    jr z, Label31697C
    jp doorCouldNotBeOpened
Label31697C
    ld c, ARMOR_KEY
    call searchKeyInInventory
    or a
    jp z, doorCouldNotBeOpened
    ld [hl], $FF
    jp doorUnlocked

checkAtticEntryLockedDoors:
    ld a, e
    cp a, DOOR_3A ; door to yawn 1 room
    jr z, Label316992
    jp doorCouldNotBeOpened
Label316992
    ld c, SHIELD_KEY
    call searchKeyInInventory
    or a
    jp z, doorCouldNotBeOpened


Label31699B: ; unused
    ld a, 0
    ld [de], a ; reset door id
    ld [hl], $FF
    jp doorUnlocked

checkHelipadLookoutRoomLockedDoors:
    jp doorCouldNotBeOpened
; this point is never reached, but this door is unlocked by default
    ld c, ARMOR_KEY
    call searchKeyInInventory
    or a
    jp z, doorCouldNotBeOpened
    ld [hl], $FF
    jp doorUnlocked

checkWestStaircase2FLockedDoors:
    ld a, e
    cp a, DOOR_3B ; door to red jewel room
    jr z, Label3169BC
    jp doorCouldNotBeOpened
Label3169BC
    ld c, HELMET_KEY
    call searchKeyInInventory
    or a
    jp z, doorCouldNotBeOpened
    ld [hl], $FF
    jp doorUnlocked

checkAquaTankRoomLockedDoors:
    ld a, e
    cp a, DOOR_59 ; door to aquarium control room
    jr z, Label3169D2
    jp doorCouldNotBeOpened
Label3169D2
    ld c, C_ROOM_KEY
    call searchKeyInInventory
    or a
    jp z, doorCouldNotBeOpened
    ld c, C_ROOM_KEY
    call searchAndRemoveItem
    ld [hl], $FF
    jp doorUnlocked

checkDormitoryCorridorLockedDoors:
    ld a, e
    cp a, DOOR_5C ; door to guardhouse dorm 002
    jr z, Label3169ED
    jp doorCouldNotBeOpened
Label3169ED
    ld a, [wSelectedCharacter]
    or a
    jr z, Label3169FA ; if chris
; if jill
    ld a, [wDorm002EventSceneFlag]
    or a
    jp z, doorCouldNotBeOpened
Label3169FA
    ld c, DORMITORY_2_KEY
    call searchKeyInInventory
    or a
    jp z, doorCouldNotBeOpened
    ld c, DORMITORY_2_KEY
    call searchAndRemoveItem
    ld [hl], $FF
    jp doorUnlocked

checkBeehivePassageLockedDoors:
    ld a, e
    cp a, DOOR_5E ; door to dorm 003
    jr z, Label316A15
    jp doorCouldNotBeOpened
Label316A15
    ld c, DORMITORY_3_KEY
    call searchKeyInInventory
    or a
    jp z, doorCouldNotBeOpened
    ld c, DORMITORY_3_KEY
    call searchAndRemoveItem
    ld [hl], $FF
    jp doorUnlocked

checkLabCentralCloisterLockedDoors:
    ld a, e
    cp a, DOOR_6B ; door to corridor 65
    jr z, Label316A30
    jp doorCouldNotBeOpened
Label316A30
    ld c, LAB_KEY
    call searchKeyInInventory
    or a
    jp z, doorCouldNotBeOpened
    ld c, LAB_KEY
    call searchAndRemoveItem
    ld [hl], $FF
    jp doorUnlocked

checkOperatingMorgeRoomLockedDoors:
    ld a, e
    cp a, DOOR_6A ; morgue room locked door
    jr z, Label316A4B
    jp doorCouldNotBeOpened
Label316A4B
    ld [hl], $FF
    jp doorUnlocked
