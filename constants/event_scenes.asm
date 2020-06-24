
NO_SCENE                                EQU $00
MAIN_HALL_OPENING_SCENE                 EQU $01

; chris scenes
CHRIS_MHALL_OPENING_SCENE               EQU $01
CHRIS_RETURNS_EARLY_TO_MHALL_SCENE      EQU $02 ; returning to main hall before first zombie
CHRIS_RETURNS_TO_MHALL_SCENE            EQU $03 ; returning to main hall after first zombie
CHRIS_MEETS_REBECCA_SCENE               EQU $04
CHRIS_REBECCA_TALK_SAFEROOM_1_SCENE     EQU $05 ; rebecca conversation in secure room 1
CHRIS_REBECCA_TALK_SAFEROOM_2_SCENE	    EQU $06 ; rebecca conversation in secure room 2
CHRIS_REBECCA_TALK_SAFEROOM_3_SCENE 	EQU $07 ; same as 06 but shorter
CHRIS_REBECCA_PIANO_1_SCENE             EQU $08 ; rebecca learning to play the piano
CHRIS_REBECCA_PIANO_2_SCENE             EQU $09 ; piano room secret door opening
CHRIS_POISONED_SCENE	                EQU $0A ; scene after yawn fight 1 (if poisoned)
CHRIS_POISONED_SAVED_BY_REBECCA_SCENE	EQU $0B ; scene after yawn fight 1 when poisoned, rebecca saves chris in safe room
CHRIS_WESKER_TALK_IN_WAREHOUSE_SCENE	EQU $0C ; wesker conversation before leave werehouse
CHRIS_FIND_RADIO_SCENE	                EQU $0D ; getting the radio scene (returning to mansion)
CHRIS_KILLS_FIRST_HUNTER_SCENE	        EQU $0E ; scene after first hunter
CHRIS_SAVES_REBECCA_SCENE	            EQU $0F ; saving rebecca from hunter scene (below stairs)
CHRIS_MEETS_ENRICO_SCENE	            EQU $10
CHRIS_FINDS_JILL_IN_JAIL_SCENE	        EQU $11
CHRIS_FIRST_TYRANT_BATTLE_SCENE         EQU $12 ; lab elevator energy restoration and first tyrant battle
CHRIS_FIRST_TYRANT_BATTLE2_SCENE        EQU $13 ; same as 12 but shorter (no elevator part)
CHRIS_AFTER_FIRST_TYRANT_SCENE          EQU $14 ; scene after first tyrant battle and finds rebecca is alive
CHRIS_AFTER_FIRST_TYRANT2_SCENE         EQU $15 ; same as 14, but shorter (after taking elevator)
CHRIS_LAB_SELF_DESTRUC_ALERT_SCENE      EQU $16 ; lab self-destruction activation alert scene
CHRIS_SAVE_JILL_FROM_JAIL_SCENE         EQU $17
CHRIS_AFTER_SAVE_JILL_SCENE             EQU $18 ; scene after saving jill from jail
CHRIS_JILL_ESCAPING_LAB_SCENE	        EQU $19 ; escaping with jill from lab (first lab box room)
BRAD_RADIO_MESSAGE_IN_LAB_SCENE	        EQU $1A ; brad radio messege before heliport
CHRIS_BEFORE_HELIPORT_ELEVATOR_SCENE    EQU $1B ; scene before taking elevator to heliport
CHRIS_IN_HELIPORT_SCENE                 EQU $1C ; test scene with chris in heliport from different camera angles
JILL_START_GAME_SCENE_DUP               EQU $1D ; jill start scene


; jill scenes
JILL_MHALL_OPENING_SCENE	            EQU $01
JILL_BARRY_DINING_ROOM_SCENE_1          EQU $02 ; jill and barry enter in dining room
JILL_BARRY_DINING_ROOM_SCENE_2          EQU $03 ; barry examinatiing blood
JILL_DINING_ROOM_ZOMBIE_SCENE           EQU $04 ; zombie attack in dining room
JILL_BARRY_RETURN_MHALL_SCENE	        EQU $05 ; main hall scene after first zombie
JILL_NULL_EVENT 	                    EQU $06 ; no event pointer, the game is restarted (maybe piano scene was here)
JILL_SANDWISH_SCENE_1	                EQU $07 ; falling cieling and jill rescued by barry
JILL_BARRY_FIND_FOREST_CORPSE_SCENE	    EQU $08 ; forest corpse scene
JILL_SANDWISH_SCENE_2	                EQU $09 ; jill sandwish scene
JILL_BARRY_TALK_IN_MHALL_1F_SCENE	    EQU $0A ; barry and jill conversation in main hall 1f (get flame rounds)
JILL_BARRY_TALK_IN_RESEARCHERS_SCENE	EQU $0B ; barry and jill conversation in researcher private room
JILL_FINDS_RICHARD_SCENE	            EQU $0C ; jill finds richard then go to get serum
JILL_RICHARDS_DEATH_SCENE               EQU $0D ; richard's death scene after giving serum
JILL_POISONED_AFTER_JAWN_SCENE	        EQU $0E ; after jawn battle if poisoned. get clip after scene
JILL_BRAD_RADIO_MESSAGE_1_SCENE	        EQU $0F ; brad radio message in courtyard garden
JILL_HEARS_BARRY_CONVERSATION_SCENE	    EQU $10 ; jill hearing barry and wesker conversation in warehouse room
JILL_BARRY_TALK_IN_WAREHOUSE_SCENE	    EQU $11 ; barry and jill conversation in werehouse room
JILL_WESKER_TALK_IN_WAREHOUSE_SCENE	    EQU $12 ; jill and werker conversation before leave werehouse
JILL_BRAD_RADIO_MESSAGE_2_SCENE	        EQU $13 ; brad radio message after leave werehouse
JILL_AFTER_YAWNS_DEATH_SCENE	        EQU $14 ; scene after snake death (barry drop rope in trevors tomb)
JILL_BARRY_RETURNS_TO_TOMB_SCENE	    EQU $15 ; barry returns to help jill in trevor's tomb
JILL_BARRY_TALK_IN_UNDERGROUND_SCENE	EQU $16 ; barry and jill conversation in underground
JILL_MEETS_ENRICO_SCENE	                EQU $17
JILL_FINDS_CHRIS_IN_JAIL_SCENE	        EQU $18
JILL_BEFORE_TYRANT_1ST_BATTLE_SCENE	    EQU $19 ; scene before first tyrant battle (barry KOs wesker)
JILL_BEFORE_TYRANT_1ST_BATTLE_SCENE2	EQU $1A ; same as before, but shorter (after taking elevator)
JILL_TYRANT_1ST_BATTLE_SCENE	        EQU $1B ; first tyrant battle
JILL_AFTER_1ST_TYRANT_BATTLE_SCENE	    EQU $1C ; scene after first tyrant battle 
JILL_LAB_SELF_DESTRUCT_ALERT_SCENE	    EQU $1D ; lab self-destruct message scene after tyrant battle
JILL_SAVES_CHRIS_FROM_JAIL_SCENE	    EQU $1E
JILL_AFTER_SAVE_CHRIS_SCENE	            EQU $1F ; scene after saving chris
JILL_CHRIS_ESCAPING_LAB_SCENE	        EQU $20 ; scene after saving before escaping lab
JILL_BARRY_BEFORE_HELIPORT_SCENE	    EQU $21 ; barry helping to escape
JILL_BRAD_RADIO_MESSAGE_3_SCENE	        EQU $22 ; brad radio message before heliport
JILL_IN_HELIPORT_SCENE	                EQU $23 ; test scene with jill in heliport from different camera angles
JILL_BRAD_THROWS_RLAUNCHER_SCENE        EQU $24 ; brad throws rocket launcher scene. No message and no r.launcher sprite


; commons events scenes

; all elevator scenes show chris sprite even if playing as jill
TAKING_ELEVATOR_TO_MAIN_LAB_SCENE	    EQU $80 ; elevator to main lab (1st tyrant room). Mansion elevator is shown
TAKING_ELEVATOR_FROM_MAIN_LAB_SCENE	    EQU $81 ; elevator from main lab. Mansion elevator is shown
TAKING_ELEVATOR_TO_KITCHEN_SCENE    	EQU $82 ; elevator to mansion kitchen
TAKING_ELEVATOR_TO_LIBRARY_SCENE    	EQU $83 ; elevator to mansion library entry corridor
TAKING_ELEVATOR_TO_HELIPORT_SCENE	    EQU $84
TAKING_ELEVATOR_FROM_HELIPORT_SCENE     EQU $85
TAKING_ELEVATOR_FROM_MAIN_LAB_SCENE2	EQU $86 ; correct lab elevator background is shown
TAKING_ELEVATOR_FROM_MAIN_LAB_SCENE3	EQU $87 ; same as 86

FIRST_ZOMBIE_SCENE	                    EQU $88
TIGER_STATUE_BLUE_JEWEL_OPEN_SCENE	    EQU $89
TIGER_STATUE_BLUE_JEWEL_CLOSE_SCENE	    EQU $8A
FALLING_STATUE_SCENE	                EQU $8B