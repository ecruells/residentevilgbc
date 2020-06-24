; check if the items choosed can be combined, if so, the items are combined
combineSelectedItems: ;00:3F92
    ld a, [wSelectedSlotId]
    sub a, ITEM_SLOT_1 ; get selected item slot index
    ld e, a
    ld d, 0
    ld hl, wItemIdSlot1
    add hl, de
    push hl ; store selected item id
    ld a, [wMainMenuSelectedCursorId]
    sub a, COMBINE_SLOT_1 ; get target item slot index
    ld e, a
    ld d, 0
    ld hl, wItemIdSlot1
    add hl, de ; get target item id
    pop de ; restore selected item id
; check if item can be combined
    ld a, [de]
    cp a, WATER_BOTTLE
    jp z, checkWaterBottleCombine
    cp a, UMB_NO2
    jp z, checkUMBNo2Combine
    cp a, NP_003
    jp z, checkNP003Combine
    cp a, UMB_NO4
    jp z, checkUMBNo4Combine
    cp a, YELLOW_6
    jp z, checkYellow6Combine
    cp a, UMB_NO7
    jp z, checkUMBNo7Combine
    cp a, UMB_NO13
    jp z, checkUMBNo13Combine
    ret
;3FD1

checkWaterBottleCombine: ;00:3FD1
    ld a, [hl]
    cp a, UMB_NO2
    jp z, waterAndUMBNo2Combine
    jp combineNotMatch

checkUMBNo2Combine:
    ld a, [hl]
    cp a, WATER_BOTTLE
    jp z, waterAndUMBNo2Combine
    cp a, UMB_NO4
    jp z, UMBNo2AndUMBNo4Combine
    jp combineNotMatch

checkNP003Combine:
    ld a, [hl]
    cp a, UMB_NO4
    jp z, NP003AndUMBNo4Combine
    cp a, UMB_NO13
    jp z, NP003AndUMBNo13Combine
    jp combineNotMatch

checkUMBNo4Combine:
    ld a, [hl]
    cp a, NP_003
    jp z, NP003AndUMBNo4Combine
    cp a, UMB_NO2
    db $CA, $27 ;end of home bank, but routine continue to bank 1
   ;jp z, UMBNo2AndUMBNo4Combine next instruccion between bank0 & bank1
