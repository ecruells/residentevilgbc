; given a room item id, return the corresponding room item flag value.
; $00: item picked up
; $FF: item not picked up
;
; a: room item id
getRoomItemFlagValue: ;C5:6A80
    push bc
    push de
    push hl
    ld a, [wRoomItemId]
; check conditional pickable items first
    cp a, ROOM04_MAP_1
    jr z, checkDistanceForMap1
    cp a, ROOM16_SQUARE_CRANK
    jr z, checkDistanceForSquareCrank
    cp a, ROOM30_RED_JEWEL
    jr z, checkRoomLightForRedJewel
    cp a, ROOM58_SMALL_KEY_5
    jr z, checkFloodedRoomForSmallKey
    ; else, normal pick items
getItemFlagValue:
    ld e, a
    ld d, 0
    ld hl, wRoomsItemsFlags
    add hl, de
    ld a, [hl] ; get item flag value
returnItemFlagValue:
    pop hl
    pop de
    pop bc
    ret
;6AA2

checkDistanceForSquareCrank: ;C5:6AA2
    ld a, [wEntityPositionY]
    cp a, 16 
    jr nc, .Label316AAC
    xor a ; 0 too far to get the item, return as "picked up"
    jr returnItemFlagValue
.Label316AAC
    ld a, [wRoomItemId]
    jr getItemFlagValue

checkDistanceForMap1:
    ld a, [wEntityPositionY]
    cp a, 16 ; 16 is too far to get the item, 28 is closer. TODO: fix value
    jr nc, .Label316ABB
    xor a ; 0 too far to get the item, return as "picked up"
    jr returnItemFlagValue
.Label316ABB
    ld a, [wRoomItemId]
    jr getItemFlagValue

checkRoomLightForRedJewel:
    ld a, [wTaxidermyRoomLightsFlag]
    or a
    jr nz, .Label316AC9
    xor a ; 0 too much light to get the item, return as "picked up"
    jr returnItemFlagValue
.Label316AC9
    ld a, [wRoomItemId]
    jr getItemFlagValue

checkFloodedRoomForSmallKey:
    ld a, [wFloodedRoomsDrainedWaterFlag]
    or a
    jr nz, .Label316AD7
    xor a ; 0
    jr returnItemFlagValue
.Label316AD7
    ld a, [wRoomItemId]
    jr getItemFlagValue
;6ADC
