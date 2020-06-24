updateItemboxMenuInputs:
    ld a, [wMainMenuSelectedCursorId]
    cp a, ITEMBOX_CURSOR
    jr nc, .itemboxListCursorInputs
.itemSlotsCursorInputs
    call itemboxItemSlotsCursorLeftInput
    call itemboxItemSlotsCursorRightInput
    call itemboxItemSlotsCursorUpInput
    call itemboxItemSlotsCursorDownInput
    call itemboxItemSlotsCursorCancelInput
    call itemboxItemSlotsCursorConfirmInput
    ret
.itemboxListCursorInputs
    call itemboxListCursorUpInput
    call itemboxListCursorDownInput
    call itemboxListCursorCancelInput
    call itemboxListCursorConfirmInput ; swap items
    ret
;4175

itemboxItemSlotsCursorConfirmInput: ;01:4175
    ld a, [wButtonPressId]
    and a, A_INPUT
    ret z
    ld a, [wMainMenuSelectedCursorId]
    ld [wSelectedSlotId], a ; store selected item slot
    ld a, ITEMBOX_CURSOR
    ld [wMainMenuSelectedCursorId], a ; set itembox list cursor mode
; play confirm sfx
    ld a, CONFIRM_SFX
    call playSFX
    call displayItemboxItemsList
    ld b, $10
    jp routineDelay

; swap selected item from item slot to itembox slot
itemboxListCursorConfirmInput: ;01:4193
    ld a, [wButtonPressId]
    and a, A_INPUT
    ret z
    ld a, [wSelectedSlotId]
    sub a, ITEM_SLOT_1 ; get slot id offset
    ld e, a
    ld d, 0
    ld hl, wItemIdSlot1
    add hl, de
    ld e, l
    ld d, h ; de: item id pointer
    ld a, [wSelectedItemBoxSlotId]
    ld c, a
    ld b, $00
    ld hl, wItemBoxSlot01
    add hl, bc
; swap items
    ld a, [de] ; get item id from selected item slot
    push af ; store item id
    ld a, [hl] ; get item id from selected itembox slot
    ld [de], a ; set item from itembox slot
    pop af
    ld [hl], a ; set item from item slot
    ld a, [wSelectedSlotId]
    ld [wMainMenuSelectedCursorId], a ; return to item slot mode
    call displayItemboxItemsList
    call displaySelectedItemName
    ld a, CONFIRM_SFX
    call playSFX
    ld b, $10
    jp routineDelay

itemboxItemSlotsCursorCancelInput: ;41CD
    ld a, [wButtonPressId]
    and a, B_INPUT
    ret z
; exit from itembox menu
    ld a, CHANGE_SCREEN_FADE_OUT
    ld [wPaletteFadeCounter], a
    ret
;41D9

itemboxListCursorCancelInput: ;01:41D9
    ld a, [wButtonPressId]
    and a, B_INPUT
    ret z
    ld a, [wSelectedSlotId]
    ld [wMainMenuSelectedCursorId], a ; back to item slot cursor mode
    ld a, CANCEL_SFX
    call playSFX
    call displayItemboxItemsList
    ld b, $10
    jp routineDelay

itemboxItemSlotsCursorLeftInput: ;01:41F2
    ld a, [wButtonPressId]
    and a, LEFT_INPUT
    ret z
    ld a, [wMainMenuSelectedCursorId]
    and a, %00000001
    ret z ; return if is already in left column
    ld a, [wMainMenuSelectedCursorId]
    and a, %11111110 ; move cursor to left
    ld [wMainMenuSelectedCursorId], a
    call displaySelectedItemName
    ld a, CURSOR_SFX
    jp playSFX

itemboxItemSlotsCursorRightInput: ;01:420E
    ld a, [wButtonPressId]
    and a, RIGHT_INPUT
    ret z
    ld a, [wMainMenuSelectedCursorId]
    and a, %00000001
    ret nz ; return if is already in right column
    ld a, [wMainMenuSelectedCursorId]
    or a, %00000001  ;move cursor to right
    ld [wMainMenuSelectedCursorId], a
    call displaySelectedItemName
    ld a, CURSOR_SFX
    jp playSFX

itemboxItemSlotsCursorUpInput: ;01:422A
    ld a, [wButtonPressId]
    and a, UP_INPUT
    jr z, Label424E
    ld a, [wPressingUpKey]
    or a
    ret nz
    ld a, $FF
    ld [wPressingUpKey], a
    ld a, [wMainMenuSelectedCursorId]
    cp a, ITEM_SLOT_3
    ret c ; return if is already in slots top row
    sub a, 2 ; move cursor up
    ld [wMainMenuSelectedCursorId], a
    call displaySelectedItemName
    ld a, CURSOR_SFX
    jp playSFX
Label424E
    xor a
    ld [wPressingUpKey], a
    ret
;4253

itemboxItemSlotsCursorDownInput: ;01:4253
    ld a, [wButtonPressId]
    and a, DOWN_INPUT
    jr z, Label4280
    ld a, [wPressingDownKey]
    or a
    ret nz
    ld a, $FF
    ld [wPressingDownKey], a
    ld c, ITEM_SLOT_5 ; chris bottom row
    ld a, [wSelectedCharacter]
    or a
    jr z, Label426E ; if chris
; if jill
    ld c, ITEM_SLOT_7 ; jill bottom row
Label426E
    ld a, [wMainMenuSelectedCursorId]
    cp a, c
    ret nc ; return if is already in bottom row
    add a, 2 ; move cursor down
    ld [wMainMenuSelectedCursorId], a
    call displaySelectedItemName
    ld a, CURSOR_SFX
    jp playSFX
Label4280
    xor a
    ld [wPressingDownKey], a
    ret
;4285


itemboxListCursorUpInput: ;01:4285
    ld a, [wButtonPressId]
    and a, UP_INPUT
    jr z, Label42A7
    ld a, [wPressingUpKey]
    or a
    ret nz
    ld a, $FF
    ld [wPressingUpKey], a
    ld a, [wSelectedItemBoxSlotId]
    dec a ; move cursor up
    and a, MAX_ITEMBOX_ITEMS-1 ; rotate list if overflow
    ld [wSelectedItemBoxSlotId], a
    call displayItemboxItemsList
    ld a, ITEM_BOX_CURSOR_SFX
    jp playSFX
Label42A7
    xor a
    ld [wPressingUpKey], a
    ret
;42AC

itemboxListCursorDownInput: ;01:42AC
    ld a, [wButtonPressId]
    and a, DOWN_INPUT
    jr z, Label42CE
    ld a, [wPressingDownKey]
    or a
    ret nz
    ld a, $FF
    ld [wPressingDownKey], a
    ld a, [wSelectedItemBoxSlotId]
    inc a ; move cursor down
    and a, MAX_ITEMBOX_ITEMS-1 ; rotate list if overflow
    ld [wSelectedItemBoxSlotId], a
    call displayItemboxItemsList
    ld a, ITEM_BOX_CURSOR_SFX
    jp playSFX
Label42CE
    xor a
    ld [wPressingDownKey], a
    ret
;42D3