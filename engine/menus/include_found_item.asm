; include found item, map or file in inventory if there's an empty slot
includeFoundItem: ;01:49ED
    ld a, [wChoiceId]
    or a
    jp nz, exitTakeItemMenu
; if item is taken, clear text
    ldhl 15, 0 ; text position
    ld bc, ClearTextboxText
    ld a, BANK(ClearTextboxText)
    call printTextString
    ld hl, wItemIdSlot1
; check for empty slots
    ld b, CHRIS_MAX_SLOTS
    ld a, [wEntityId]
    cp a, CHRIS
    jr z, findEmptySlotLoop ; if chris
; if jill
    ld b, JILL_MAX_SLOTS

findEmptySlotLoop:
    ld a, [hl]
    cp a, EMPTY
    jr z, emptySlotFound
    inc hl
    dec b
    jr nz, findEmptySlotLoop
; no empty slot found
    ldhl 15, 0
    ld bc, text_3EA3CE ; You can't carry more items
    ld a, BANK(text_3EA3CE)
    call printTextString
    jp endIncludeItem

; check files and maps items first
emptySlotFound:
    ld a, [wSelectedItemId]
    cp a, NOTHING_ITEM_1 
    jp z, fileFound
    cp a, NOTHING_ITEM_2 
    jp z, fileFound
    cp a, NOTHING_ITEM_3 
    jp z, fileFound
    cp a, NOTHING_ITEM_5 
    jp z, fileFound
    cp a, BOTANY_BOOK 
    jp z, fileFound
    cp a, NOTHING_ITEM_6 
    jp z, fileFound
    cp a, NOTHING_ITEM_7 
    jp z, fileFound
    cp a, NOTHING_ITEM_8 
    jp z, fileFound
    cp a, NOTHING_ITEM_9 
    jp z, fileFound
    cp a, NOTHING_ITEM_10 
    jp z, fileFound
    cp a, MAP_1 
    jp z, mapFound
    cp a, MAP_2 
    jp z, mapFound
    cp a, MAP_3 
    jp z, mapFound
    cp a, MAP_4 
    jp z, mapFound

; check normal item found
    ld [hl], a ; set found item id in empty slot

; check tiger statue event by picking the wind crest before include item
    cp a, WIND_CREST
    jr nz, includeItem
    ld a, TIGER_STATUE_BLUE_JEWEL_CLOSE_SCENE
    ld [wEventSceneId], a
    jr includeItem
    
includeItem:
    ld a, [wRoomItemId]
    ld e, a
    ld d, 0
    ld hl, wRoomsItemsFlags
    add hl, de
    ld [hl], 0 ; unset item flag
    ldhl 15, 0
    ld bc, text_3EA3C0 ; ITEM INCLUDED
    ld a, BANK(text_3EA3C0)
    call printTextString
    call loadMenuItemsSpritesCaller
    call enableHDMA
    call swapCurrentOAMBuffer
endIncludeItem:
    ld b, $80
    call routineDelay
exitTakeItemMenu:
    call resetPalettes
    ret
;4AA2

fileFound: ;01:4AA2
    ld a, [wRoomItemId]
    ld e, a
    ld d, 0
    ld hl, wRoomsItemsFlags
    add hl, de
    ld [hl], 0 ; unset file flag
    ldhl 15, 0
    ld bc, text_3EA3C0 ; ITEM INCLUDED
    ld a, BANK(text_3EA3C0)
    call printTextString
    call loadMenuItemsSpritesCaller
    call enableHDMA
    call swapCurrentOAMBuffer
; set menu file flag
    ld a, $FF
    ld [wMenuFileEnable], a
    ld b, $80
    call routineDelay
    call resetPalettes
    ret
;4AD0

mapFound: ;01:4AD0
    ld a, [wRoomItemId]
    ld e, a
    ld d, 0
    ld hl, wRoomsItemsFlags
    add hl, de
    ld [hl], 0 ; unset map flag
    ldhl 15, 0
    ld bc, text_3EA3C0 ; ITEM INCLUDED
    ld a, BANK(text_3EA3C0)
    call printTextString
    call loadMenuItemsSpritesCaller
    call enableHDMA
    call swapCurrentOAMBuffer
; set map menu flag
    ld a, $FF
    ld [wMenuMapEnable], a
    ld b, $80
    call routineDelay
    call resetPalettes
    ret
;4AFE
