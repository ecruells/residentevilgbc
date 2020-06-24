checkRoomsActions: ;C5:62C5
    xor a
    ld [wActionButtonEventId], a ; reset button A event
    ld a, [wPaletteFadeCounter]
    or a
    ret nz ; return if fading palette
    ld a, [wRoomId]
    ld l, a
    ld a, [wRoomIdHigh]
    ld h, a
    add hl, hl
    ld de, roomsActionsDatatable
    add hl, de
    ld a, [hl]
    inc hl
    ld h, [hl]
    ld l, a
checkNextRoomAction:
    ld a, [hl] ; get action type id
    cp a, END_ROOM_ACTIONS
    jr z, .finishRoomActionCheck
    cp a, DOOR_ACTION
    jp c, checkRoomDoorsAction
    cp a, ITEMBOX_ACTION
    jp z, checkRoomItemBoxAction
    cp a, TYPEWRITER_ACTION
    jp z, checkRoomTypewriterAction
    cp a, ZOMBIE
    jp z, skipRoomCharactersSprites
    cp a, YAWN
    jp z, skipRoomCharactersSprites
    cp a, REBECCA
    jp z, skipRoomCharactersSprites
    cp a, DROPPED_ITEM
    jp z, checkRoomDroppedItem
    cp a, CHECK_ACTION
    jp z, checkRoomCheckAction
    cp a, OBJECTS
    jp nc, skipRoomObjectsSprites
    jr checkNextRoomAction
.finishRoomActionCheck
    ret

skipRoomObjectsSprites: ;C5:6314
    ld de, 11
    add hl, de
    jp checkNextRoomAction

checkRoomDroppedItem:
    ld a, [wEntityAnimationId]
    cp a, PICK_ITEM_ANIM
    jr z, alreadyPickingItem
    ld de, 5
    add hl, de ; offset to item position
    call detectPickUpDroppedItem
    or a
    jr z, .Label316333 ; no picked item
    ld de, 6
    add hl, de
    jp checkNextRoomAction
.Label316333
    ld de, 6
    add hl, de
    jp checkNextRoomAction
alreadyPickingItem
    ld de, 11
    add hl, de
    jp checkNextRoomAction

checkRoomCheckAction:
    ld de, 5
    add hl, de ; offset to acction position
    call detectRoomIteractionByActionButtonPress
    or a
    jr z, .Label316352
    ld de, 6
    add hl, de
    jp checkNextRoomAction
.Label316352
    ld de, 6
    add hl, de
    jp checkNextRoomAction

skipRoomCharactersSprites:
    ld de, 11
    add hl, de
    jp checkNextRoomAction

checkRoomDoorsAction:
    ld de, 5
    add hl, de ; offset to door interaction position
    call detectDoorInteraction
    or a
    jr z, .Label316371
    ld de, 6
    add hl, de
    jp checkNextRoomAction
.Label316371
    ld de, 6
    add hl, de
    jp checkNextRoomAction

checkRoomTypewriterAction:
    ld de, 5
    add hl, de ; offset to typewriter position values
    call detectTypewriterInteraction
    or a
    jr z, .Label316389
    ld de, 6
    add hl, de
    jp checkNextRoomAction
.Label316389
    ld de, 6
    add hl, de
    jp checkNextRoomAction

checkRoomItemBoxAction:
    ld de, $5
    add hl, de ; offset to itembox position values
    call detectItemboxInteraction
    or a
    jr z, .Label3163A1
    ld de, 6
    add hl, de
    jp checkNextRoomAction
.Label3163A1
    ld de, 6
    add hl, de
    jp checkNextRoomAction
