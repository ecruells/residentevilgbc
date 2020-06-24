SECTION "Saveram", SRAM, BANK[0]

sSRamStart::	;a000
	ds $B9

sQuickSaveFlag01:: ;a0b9
	ds 1

sQuickSaveFlag02:: ;a0ba
	ds 2

sQuickSaveFlag03:: ;a0bc
	ds 1


SECTION "SaveramSlotsMetadata", SRAM[$BF00], BANK[0]

sSaveSlot1Flag:: ;BF00
	ds 4
sSaveSlot2Trigger:: ;BF04
	ds 4
sSaveSlot3Trigger:: ;BF08
	ds 4
sSaveSlot4Trigger:: ;BF0C
	ds 8

sSaveSlot1Info:: ;bf14
	ds $14
sSaveSlot2Info:: ;bf28
	ds $14
sSaveSlot3Info:: ;bf3c
	ds $14
sSaveSlot4Info:: ;bf50
	ds $14


SECTION "SaveramInitFlags", SRAM[$BFFC], BANK[0]

sSRamInitiazedFlag0:: ;BFFC
	ds 1
sSRamInitiazedFlag1:: ;BFFD
	ds 1
sSRamInitiazedFlag2:: ;BFFE
	ds 1
sSRamInitiazedFlag3:: ;BFFF
	ds 1
