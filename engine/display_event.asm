displayEventScene:: ;0E:409A
    xor a
    ld [wLoadEventBgImagePal], a ;reset var
    ld hl, chrisEventScenesLUT
    ld a, [wSelectedCharacter]
    or a
    jr z, .Label380AA ; jump if chris
; if jill
    ld hl, jillEventScenesLUT
.Label380AA
    ld a, [wEventSceneId]
    cp a, $80
    jr c, .Label380B6 ; jump if not common event
; else commons events
    ld hl, commonEventScenesLUT
    sub a, $7F
.Label380B6
; get event pointer ( ((id - 1) * 2) + HL)
    dec a
    add a
    ld e, a
    ld d, $00
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
eventSceneLoop: ;0E:40BF
    ld a, [hli]
    cp a, END_EVENT
    jp z, endEvent
    cp a, RECEIVE_ITEM
    jp z, getItemInEvent
    ld de, continueNext
    push de ;store return address
    cp a, LOAD_ROOM
    jp z, loadEventRoomBgCaller
    cp a, CHRIS_DATA
    jp z, loadChrisEventData
    cp a, JILL_DATA
    jp z, loadJillEventData
    cp a, WESKER_DATA
    jp z, loadWeskerEventData
    cp a, REBECCA_DATA
    jp z, loadRebeccaEventData
    cp a, BARRY_DATA
    jp z, loadBarryEventData
    cp a, ENEMY_9E_DATA
    jp z, loadEnemy9EData
    cp a, ZOMBIE_DATA
    jp z, loadZombieEventData
    cp a, FADEIN_SCREEN
    jp z, eventScreenFadeIn
    cp a, EVENT_WAIT
    jp z, eventFrameDelay
    cp a, CHANGE_ROOM_CAMERA
    jp z, eventChangeScreen
    cp a, PLAYER_ANIM
    jp z, changePlayerSpriteAnimFrame
    cp a, NPC1_ANIM
    jp z, changeNPC1SpriteAnimFrame
    cp a, NPC2_ANIM
    jp z, changeNPC2SpriteAnimFrame
    cp a, NPC3_ANIM
    jp z, changeNPC3SpriteAnimFrame
    cp a, NPC4_ANIM
    jp z, changeNPC4SpriteAnimFrame
    cp a, NPC6_ANIM
    jp z, changeNPC6SpriteAnimFrame
    cp a, CHRIS_MESSAGE
    jp z, showChrisEventMessage
    cp a, JILL_MESSAGE
    jp z, showJillEventMessage
    cp a, WESKER_MESSAGE
    jp z, showWeskerEventMessage
    cp a, REBECCA_MESSAGE
    jp z, showRebeccaEventMessage
    cp a, BARRY_MESSAGE
    jp z, showBarryEventMessage
    cp a, ENRICO_MESSAGE
    jp z, showEnricoEventMessage
    cp a, LAB_ALERT_MESSAGE
    jp z, showLabAlertVoiceEventMessage
    cp a, RICHARD_MESSAGE
    jp z, showRichardEventMessage
    cp a, BRAD_MESSAGE
    jp z, showBradEventMessage
    cp a, MISTERY_MESSAGE
    jp z, showMisteriousVoiceEventMessage
    cp a, PLAYER_FACING
    jp z, changePlayerFacing
    cp a, NPC1_FACING
    jp z, changeNPC1Facing
    cp a, NPC2_FACING
    jp z, changeNPC2Facing
    cp a, NPC3_FACING
    jp z, changeNPC3Facing
    cp a, NPC4_FACING
    jp z, changeNPC4Facing
    cp a, NPC6_FACING
    jp z, changeNPC6Facing
    cp a, PLAY_SFX
    jp z, playEventSFX
    cp a, PLAYER_WALK
    jp z, moveWalkingEventPlayer
    cp a, NPC1_WALK
    jp z, moveWalkingEventNPC1
    cp a, NPC2_WALK
    jp z, moveWalkingEventNPC2
    cp a, NPC3_WALK
    jp z, moveWalkingEventNPC3
    cp a, NPC4_WALK
    jp z, moveWalkingEventNPC4
    cp a, NPC5_WALK
    jp z, moveWalkingEventNPC5
    cp a, NPC6_WALK
    jp z, moveWalkingEventNPC6
    cp a, PLAYER_RUN
    jp z, moveRunningEventPlayer
    cp a, NPC1_RUN
    jp z, moveRunningEventNPC1
    cp a, NPC2_RUN
    jp z, moveRunningEventNPC2
    cp a, NPC3_RUN
    jp z, moveRunningEventNPC3
    cp a, NPC4_RUN
    jp z, moveRunningEventNPC4
    cp a, PLAYER_BACKWARD_WALK
    jp z, moveWalkBackwardPlayer
    cp a, NPC1_BACKWARD_WALK
    jp z, moveWalkBackwardNPC1
    cp a, NPC3_BACKWARD_WALK
    jp z, moveWalkBackwardNPC3
    cp a, NPC2_BACKWARD_WALK
    jp z, moveWalkBackwardNPC2
    cp a, NPC4_BACKWARD_WALK
    jp z, moveWalkBackwardNPC4
    cp a, NPC5_BACKWARD_WALK
    jp z, moveWalkBackwardNPC5
    cp a, SCREEN_PANNING_UP
    jp z, eventScreenPanningUp
    cp a, SCREEN_PANNING_DOWN
    jp z, eventScreenPanningDown
    cp a, FADEOUT_SCREEN
    jp z, eventScreenFadeOut
    cp a, SHOW_DOOR_ANIMATION
    jp z, eventDoorAnimation
    cp a, SHAKE_SCREEN
    jp z, shakeScreen
    cp a, LOAD_SPRITES
    jp z, updateSceneBgAndAllSpritesCaller
    cp a, RESET_ALL_ENTITIES_DATA
    jp z, resetAllCharsData
    cp a, SHOW_BG_IMAGE
    jp z, eventBgImage
    cp a, COPY_NPC1_DATA_TO_PLAYER
    jp z, copyNPC1DataToPlayerData
    cp a, UPDATE_JEWELS_STATUES_STATE
    jp z, updateJewelsStatuesStates
    cp a, UPDATE_ROOM_BG_MASK
    jp z, loadEventRoomBgMaskCaller
; if event action is unknown, restart game
    jp initGame
continueNext:
    jp eventSceneLoop
endEvent:
    ld a, $FF
    ret

getItemInEvent: ;0E:4212
    ld a, [hli]
    ld [wSelectedItemId], a
    ld a, [hli]
    ld [wRoomItemId], a
    ret
;0E:421B
