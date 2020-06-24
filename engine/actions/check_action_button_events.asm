; check normal actions events, like pick items, check and interact with objects, etc.
checkButtonActionEvents: ;01:59FD
    ld a, [wRoomInteractionID]
    cp a, $FF
    jp z, checkDoorsInteractions
; check events triggered after items usage
    ld a, [wRoomInteractionID]
    cp a, ROOM01_WOODEN_EMBLEM
    jp z, dinningRoomEmblemScreenMessage
    cp a, ROOM02_SERUM
    jp z, westStoreRoomShelfMessage
    cp a, ROOM05_CLIP1
    jp z, kennetCorpseMessage
    cp a, ROOM05_CLIP2
    jp z, kennetCorpseMessage
    cp a, ROOM11_SMALL_KEY_1
    jp z, MansionBathtubUnplugChoicesMessage
    cp a, ROOM18_SHOTGUN
    jp z, PutShotgunBackChoicesMessage
    cp a, ROOM1F_GREEN_HERB ; but it should be ROOM1F_MAP_2 (2f map). TODO: fix this
    jp z, showLoungeFireplaceMessage
    cp a, ROOM49_C_ROOM_KEY
    jp z, showDorm001BathroomTubChoice
    cp a, ROOM_INTERACTION_ID
    jp nc, checkRoomNormalInteraction
    ret
;5A36
showLoungeFireplaceMessage: ;01:5A36
    ld a, [wLoungeFireplaceLittedFlag]
    or a
    ret nz
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4090 ; Firewood.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld hl, text_pointer_4093 ; There's a map above it.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    jp scrollUpScreen

MansionBathtubUnplugChoicesMessage:
    ld a, [wMansionBathtubUnpluggedFlag]
    or a
    ret nz
    ld a, MANSION_BATHROOM_TUB_SCREEN
    ld [wRoomCameraId], a
    call loadEventRoomScreen
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_417D ; The bathtub is filled with muddy water.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld hl, text_pointer_4180 ; Will you unplug it?  Yes No
    call displayMessage
Label5A81
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, Label5A81
    call clearMessageBox
    ld a, [wChoiceId]
    or a
    jp nz, scrollUpScreen ; no unplug bathtub
	; unplug bathtub
    ld a, $FF
    ld [wMansionBathtubUnpluggedFlag], a
    ld [wRoomsItemsFlags+ROOM11_SMALL_KEY_1], a
    call loadRoomScreenCameraAndBgData
    jp scrollUpScreen

showDorm001BathroomTubChoice:
    ld a, [wDorm001BathroomTubUnplug]
    or a
    ret nz
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_417D ; The bathtub is filled with muddy water.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld hl, text_pointer_4180 ; Will you unplug it?  Yes No
    call displayMessage
Label5AC0
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, Label5AC0
    call clearMessageBox
    ld a, [wChoiceId]
    or a
    jp nz, scrollUpScreen ; no unplug bathtub
	; unplug bathtub
    ld a, $FF
    ld [wDorm001BathroomTubUnplug], a
    ld [wRoomsItemsFlags+ROOM49_C_ROOM_KEY], a
    call loadRoomScreenCameraAndBgData
    jp scrollUpScreen

PutShotgunBackChoicesMessage:
    ld a, [wRoomsItemsFlags+ROOM18_BROKEN_SHOTGUN]
    or a
    ret nz
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4051 ; Will you put the shotgun back?  Yes No
    call displayMessage
Label5AF3
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, Label5AF3
    call clearMessageBox
    ld a, [wChoiceId]
    or a
    jp nz, scrollUpScreen ; return if shotgun isn't putted back
	; remove shotgun from inventory if it's putted back
    ld hl, wItemIdSlot1
    ld b, CHRIS_MAX_SLOTS
    ld a, [wSelectedCharacter]
    or a
    jr z, Loop5B14 ; if chris
; if jill
    ld b, JILL_MAX_SLOTS
Loop5B14
    ld a, [hl]
    cp a, SHOTGUN
    jr z, shotgunFound
    inc hl
    dec b
    jr nz, Loop5B14
; return if shotgun not found
    jp scrollUpScreen
shotgunFound
    ld [hl], EMPTY
    ld a, $FF
    ld [wRoomsItemsFlags+ROOM18_SHOTGUN], a
    ld a, [wSelectedCharacter]
    or a
    jr z, Label5B35 ; if chris
; if jill
    ld a, $FF
    ld [wBrokenShotgunPlacedByJillFlag], a
    jp scrollUpScreen
Label5B35
    ld a, $FF
    ld [wBrokenShotgunPlacedByChrisFlag], a
    jp scrollUpScreen

kennetCorpseMessage:
    ld a, KENNETH_CORPSE_SCREEN
    ld [wRoomCameraId], a
    call loadEventRoomScreen
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4009 ; He's Kenneth from the S.T.A.R.S. Bravo team...!
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld hl, text_pointer_400C ; Now he's become a mere shadow of his former self.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    jp scrollUpScreen

westStoreRoomShelfMessage:
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4006 ; Vitamins and serums.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    jp scrollUpScreen

dinningRoomEmblemScreenMessage:
    ld a, [wRoomsItemsFlags+ROOM01_GOLD_EMBLEM]
    or a
    jr nz, dinningRoomGoldEmblemPlaced
; load dinning room wood emblem chinmey screen
    ld a, EMBLEM_CHINMEY_SCREEN
    ld [wRoomCameraId], a
    call loadEventRoomScreen
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4024 ; It looks like a hollow to put something in.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    jp scrollUpScreen
dinningRoomGoldEmblemPlaced
    ld a, EMBLEM_CHINMEY_SCREEN
    ld [wRoomCameraId], a
    call loadEventRoomScreen
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4027 ; An emblem is in place.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    jp scrollUpScreen

