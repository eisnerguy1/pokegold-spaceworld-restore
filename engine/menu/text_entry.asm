INCLUDE "constants.asm"

SECTION "engine/menu/text_entry.asm@naming", ROMX

NAMINGSCREEN_UNDERSCORE EQU "♀"
NAMINGSCREEN_HYPHEN     EQU "♂"
NAMINGSCREEN_END        EQU $F0

NamingScreen: ; 04:53F4
	ld hl, wNamingScreenDestinationPointer
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, wNamingScreenType
	ld [hl], b
	ld hl, wce5f
	ld a, [hl]
	push af
	set 4, [hl]
	ldh a, [hMapAnims]
	push af
	xor a
	ldh [hMapAnims], a
	ldh a, [hJoyDebounceSrc]
	push af
	ld a, $01
	ldh [hJoyDebounceSrc], a
	call .SetUpNamingScreen
	call DelayFrame
.loop
	call NamingScreenJoypadLoop
	jr nc, .loop

	pop af
	ldh [hJoyDebounceSrc], a
	pop af
	ldh [hMapAnims], a
	pop af
	ld [wce5f], a
	call ClearJoypad
	ret

.SetUpNamingScreen: ; 04:542B
	call ClearBGPalettes
	ld b, SGB_DIPLOMA
	call GetSGBLayout
	call DisableLCD
	call LoadNamingScreenGFX
	call NamingScreen_InitText
	ld a, $E3
	ldh [rLCDC], a
	call GetNamingScreenSetup
	call WaitBGMap
	call WaitForAutoBgMapTransfer
	ld a, $90
	ldh [rBGP], a
	ld a, $D0
	ldh [rOBP0], a
	call NamingScreenInitNameEntry
	ret

GetNamingScreenSetup: ; 04:5455
; wNamingScreenType selects which entry in the table below to jump to
	ld a, [wNamingScreenType]
	and $07
	ld e, a
	ld d, 0
	ld hl, .Jumptable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.Jumptable: ; 04:5466
	dw .Pokemon
	dw .Player
	dw .Rival
	dw .Mom
	dw .Box
	dw .Pokemon
	dw .Pokemon
	dw .Pokemon

.Pokemon: ; 04:5476
	ld hl, Function8f0e3
	ld a, BANK(Function8f0e3)
	ld e, 1
	call FarCall_hl
	call GetPokemonName
	hlcoord 5, 2
	call PlaceString
	ld l, c
	ld h, b
	ld de, .NicknameText
	call PlaceString
	call .StoreSpriteIconParams
	ret

.NicknameText ; 04:5495
	db "のニックネームは？@"

.Player: ; 04:549F
	ld de, GoldSpriteGFX
	call .LoadSprite
	hlcoord 5, 2
	ld de, .NameText
	call PlaceString
	call .StoreSpriteIconParams
	ret

.NameText: ; 04:54B2
	db "あなた　の　なまえは？@"

.Rival: ; 04:54BE
	ld de, SilverSpriteGFX
	call .LoadSprite
	hlcoord 5, 2
	ld de, .RivalText
	call PlaceString
	call .StoreSpriteIconParams
	ret

.RivalText: ; 04:54D1
; the ret just preceeding this would make the first word Rival.
	db "ライバル　の　なまえは？@"

.Mom: ; 04:54DE
	ld de, MomSpriteGFX
	call .LoadSprite
	hlcoord 5, 2
	ld de, .MomText
	call PlaceString
	call .StoreSpriteIconParams
	ret

.MomText: ; 04:54F1
	db "ははおや　の　なまえは？@"

.Box: ; 04:54FE
	ld de, PokeBallSpriteGFX
	ld hl, vChars0
	lb bc, BANK(PokeBallSpriteGFX), $04
	call Request2bpp
	ld a, $08
	ld hl, wTileMapBackup
	ld [hl+], a
	ld [hl], $00
	ld de, $2420
	ld a, $41
	call InitSpriteAnimStruct
	ld hl, $0001
	add hl, bc
	ld [hl], $00
	hlcoord 5, 2
	ld de, .BoxText
	call PlaceString
	call .StoreBoxIconParams
	ret

.BoxText: ; 04:552D
	db "バンク　の　なまえは？@"

.LoadSprite: ; 04:5539
; copies the sprite at de into the top of VRAM, as well as the sprite $C0 after de
	push de
	ld hl, vChars0
	lb bc, BANK(GoldSpriteGFX), $04
	call Request2bpp
	pop de
	ld hl, $00C0
	add hl, de
	ld e, l
	ld d, h
	ld hl, vChars0 tile 4
	lb bc, BANK(GoldSpriteGFX), $04
	call Request2bpp
	ld a, $08
	ld hl, wTileMapBackup
	ld [hli], a
	ld [hl], $00
	ld de, $2420
	ld a, $41
	call InitSpriteAnimStruct
	ret

.StoreSpriteIconParams: ; 04:5564
	ld a, $05
	ld [wNamingScreenMaxNameLength], a
	hlcoord 6, 5
	ld a, l
	ld [wNamingScreenStringEntryCoordY], a
	ld a, h
	ld [wNamingScreenStringEntryCoordX], a
	ret

.StoreBoxIconParams: ; 04:5575
	ld a, $08
	ld [wNamingScreenMaxNameLength], a
	hlcoord 5, 5
	ld a, l
	ld [wNamingScreenStringEntryCoordY], a
	ld a, h
	ld [wNamingScreenStringEntryCoordX], a
	ret

NamingScreen_InitText: ; 04:5586
; fills the tilemap with ■, then clears a 12x17 box at 1,1
; next it places the tiles at 04:58B3 onto the screen at 2,9 (tiles form an 11x8 box)
	call WaitForAutoBgMapTransfer
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, "■"
	call ByteFill
	hlcoord 1, 1
	lb bc, $07, $12
	call ClearBox
	hlcoord 1, 9
	lb bc, $08, $12
	call ClearBox
	hlcoord 2, 9
	ld de, TextEntryChars
	ld b, $08

.outerloop
	ld c, $11

.innerloop
	ld a, [de]
	ld [hl+], a
	inc de
	dec c
	jr nz, .innerloop

	inc hl
	inc hl
	inc hl
	dec b
	jr nz, .outerloop
	ret


NamingScreenJoypadLoop: ; 04:55BD
	call GetJoypadDebounced
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .leap
	call .RunJumpTable
	callba PlaySpriteAnimationsAndDelayFrame
	call .UpdateStringEntry
	call DelayFrame
	and a
	ret

.leap ; 04:55DA
; kills sprites and resets screen position
	callab InitEffectObject
	call ClearSprites
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	scf
	ret

.UpdateStringEntry: ; 04:55EC
; sets BGMapMode to 0, then loads a string and coords out of a buffer and displays it.
; BGMapMode is then set to 1.
	xor a
	ldh [hBGMapMode], a
	hlcoord 1, 3
	lb bc, $05, $12
	call ClearBox
	ld hl, wNamingScreenDestinationPointer
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, wNamingScreenStringEntryCoordY
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PlaceString
	ld a, $01
	ldh [hBGMapMode], a
	ret

.RunJumpTable: ; 04:560C
	ld a, [wJumptableIndex]
	ld e, a
	ld d, $00
	ld hl, .JumpTable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.JumpTable: ; 04:561B
	dw .InitCursor
	dw .ReadButtons

.InitCursor: ; 04:561F
	ld de, $5818
	ld a, $39
	call InitSpriteAnimStruct
	ld a, c
	ld [wNamingScreenCursorObjectPointer], a
	ld a, b
	ld [wNamingScreenCursorObjectPointer + 1], a
	ld hl, wJumptableIndex
	inc [hl]
	ret

.ReadButtons: ; 04:5634
; if A or B were pressed, clear hJoypadSum after calling functions; if start, set 7 in the jumptable??
	ld hl, hJoypadSum
	ld a, [hl]
	and A_BUTTON
	jr nz, .jumpa
	ld a, [hl]
	and B_BUTTON
	jr nz, .jumpb
	ld a, [hl]
	and START
	jr nz, .jumpstart
	ret

.jumpa ; 04:5647
	call NamingScreenGetLastCharacter
	cp NAMINGSCREEN_END
	jr z, .jumpstart
	call NamingScreenTryAddCharacter
	xor a
	ldh [hJoypadSum], a
	ret

.jumpb ; 04:5655
	call NamingScreenDeleteCharacter
	xor a
	ldh [hJoypadSum], a
	ret

.jumpstart ; 04:565C
	call NamingScreenStoreEntry
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

.GetDPad: ; 04:5665
	ld hl, hJoySum
	ld a, [hl]
	and D_UP
	jr nz, .upjump
	ld a, [hl]
	and D_DOWN
	jr nz, .downjump
	ld a, [hl]
	and D_LEFT
	jr nz, .leftjump
	ld a, [hl]
	and D_RIGHT
	jr nz, .rightjump
	ret

.rightjump ; 04:567D
	ld hl, $000C
	add hl, bc
	ld a, [hl]
	cp $0E
	jr nc, .skip1
	inc [hl]
	jr .escape

.skip1
	ld [hl], $00
	jr .escape

.leftjump
	ld hl, $000C
	add hl, bc
	ld a, [hl]
	and a
	jr z, .skip2
	dec [hl]
	jr .escape
.skip2
	ld [hl], $0E
	jr .escape

.downjump
	ld hl, $000D
	add hl, bc
	ld a, [hl]
	cp $07
	jr nc, .skip3
	inc [hl]
	jr .escape
.skip3
	ld [hl], $00
	jr .escape

.upjump ; 04:56AC :24
	ld hl, $000D
	add hl, bc
	ld a, [hl]
	and a
	jr z, .skip4
	dec [hl]
	jr .escape
.skip4
	ld [hl], $07
	jr .escape
.escape
	ld hl, $000C
	add hl, bc
	ld e, [hl]
	ld d, $00
	ld hl, LetterOffsetsTable1
	add hl, de
	ld a, [hl]
	ld hl, $0006
	add hl, bc
	ld [hl], a
	ld hl, $000D
	add hl, bc
	ld e, [hl]
	ld d, $00
	ld hl, LetterOffsetsTable2
	add hl, de
	ld a, [hl]
	ld hl, $0007
	add hl, bc
	ld [hl], a
	ret

LetterOffsetsTable1: ; 04:56DE
	db $00, $08, $10, $18, $20, $30, $38, $40, $48, $50, $60, $68, $70, $78, $80

LetterOffsetsTable2:; 04:56ED
	db $00, $08, $10, $18, $20, $28, $30, $38

NamingScreenTryAddCharacter: ; 04:56F5
	ld a, [wNamingScreenLastCharacter]
	ld hl, Dakutens
	cp "ﾞ"
	jr z, .jump
	ld hl, Handakutens
	cp "ﾟ"
	jr z, .jump
	ld a, [wNamingScreenMaxNameLength]
	ld c, a
	ld a, [wNamingScreenCurNameLength]
	cp c
	ret nc
	ld a, [wNamingScreenLastCharacter]
	call NamingScreenGetTextCursorPosition
	ld [hl], a
	ld hl, wNamingScreenCurNameLength
	inc [hl]
	call NamingScreenGetTextCursorPosition
	ld a, [hl]
	cp "@"
	ret z
	ld [hl], NAMINGSCREEN_UNDERSCORE
	ret

.jump ; 04:5724
	ld a, [wNamingScreenCurNameLength]
	and a
	ret z
	push hl
	ld hl, wNamingScreenCurNameLength
	dec [hl]
	call NamingScreenGetTextCursorPosition
	ld c, [hl]
	pop hl
.loop
	ld a, [hli]
	cp $FF
	jr z, .notherjump
	cp c
	jr z, .skip
	inc hl
	jr .loop
.skip
	ld a, [hl]
	call NamingScreenGetTextCursorPosition
	ld [hl], a
.notherjump
	ld hl, wNamingScreenCurNameLength
	inc [hl]
	ret

Dakutens: ; 04:5748
	db "かがきぎくぐけげこご"
	db "さざしじすずせぜそぞ"
	db "ただちぢつづてでとど"
	db "はばひびふぶへべほぼ"
	db "カガキギクグケゲコゴ"
	db "サザシジスズセゼソゾ"
	db "タダチヂツヅテデトド"
	db "ハバヒビフブへべホボ"
	db $FF

Handakutens: ; 04:5799
	db "はぱひぴふぷへぺほぽ"
	db "ハパヒピフプへぺホポ"
	db $FF

NamingScreenDeleteCharacter: ; 04:57AE
	ld hl, wNamingScreenCurNameLength
	ld a, [hl]
	and a
	ret z
	dec [hl]
	call NamingScreenGetTextCursorPosition
	ld [hl], NAMINGSCREEN_UNDERSCORE
	inc hl
	ld a, [hl]
	cp NAMINGSCREEN_UNDERSCORE
	ret nz
	ld [hl], NAMINGSCREEN_HYPHEN
	ret

NamingScreenGetTextCursorPosition: ; 04:57C2
	push af
	ld hl, wNamingScreenDestinationPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wNamingScreenCurNameLength]
	ld e, a
	ld d, $00
	add hl, de
	pop af
	ret

NamingScreenInitNameEntry: ; 04:57D2
	ld hl, wNamingScreenDestinationPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld [hl], NAMINGSCREEN_UNDERSCORE
	inc hl
	ld a, [wNamingScreenMaxNameLength]
	dec a
	ld c, a
	ld a, NAMINGSCREEN_HYPHEN
.loop
	ld [hli], a
	dec c
	jr nz, .loop
	ld [hl], "@"
	ret

NamingScreenStoreEntry: ; 04:57E9
	ld hl, wNamingScreenDestinationPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wNamingScreenMaxNameLength]
	ld c, a
.loop
	ld a, [hl]
	cp NAMINGSCREEN_HYPHEN
	jr z, .terminator
	cp NAMINGSCREEN_UNDERSCORE
	jr nz, .notterminator
.terminator
	ld [hl], "@"
.notterminator
	inc hl
	dec c
	jr nz, .loop
	ret

NamingScreenGetLastCharacter: ; 04:5803
	ld hl, wNamingScreenCursorObjectPointer
	ld c, [hl]
	inc hl
	ld b, [hl]
	ld hl, $0006
	add hl, bc
	ld a, [hl]
	ld hl, $0004
	add hl, bc
	add a, [hl]
	sub $08
	srl a
	srl a
	srl a
	ld e, a
	ld hl, $0007
	add hl, bc
	ld a, [hl]
	ld hl, $0005
	add hl, bc
	add a, [hl]
	sub $10
	srl a
	srl a
	srl a
	ld d, a
	hlcoord 0, 0
	ld bc, $0014
.loop
	ld a, d
	and a
	jr z, .done
	add hl, bc
	dec d
	jr .loop

.done
	add hl, de
	ld a, [hl]
	ld [wNamingScreenLastCharacter], a
	ret

LoadNamingScreenGFX: ; 04:5843
	call ClearSprites
	callab InitEffectObject
	call LoadFont

	ld de, TextScreenGFX_End
	ld hl, vChars1 tile $70
	lb bc, BANK(TextScreenGFX_End), 1
	call Get1bpp

	ld de, TextScreenGFX_Hyphen
	ld hl, vChars1 tile $6F
	lb bc, BANK(TextScreenGFX_Hyphen), 1
	call Get1bpp

	ld de, TextScreenGFX_Underscore
	ld hl, vChars1 tile $75
	lb bc, BANK(TextScreenGFX_Underscore), 1
	call Get1bpp

	ld de, vChars2 tile $60
	ld hl, TrainerCardGFX
	ld bc, $10
	ld a, BANK(TrainerCardGFX)
	call FarCopyData

	ld de, vChars0 tile $7f
	ld hl, PokedexBorderGFX
	ld bc, $10
	ld a, BANK(PokedexBorderGFX)
	call FarCopyData

	ld a, $26
	ld hl, wc41a
	ld [hli], a
	ld [hl], $7F
	xor a
	ldh [hSCY], a
	ld [wc4c7], a
	ldh [hSCX], a
	ld [wc4c8], a
	ld [wJumptableIndex], a
	ldh [hBGMapMode], a
	ld [wNamingScreenCurNameLength], a
	ldh [hJoypadSum], a
	ld a, $07
	ldh [hWX], a
	ret

SECTION "engine/menu/text_entry.asm@mail", ROMX

ComposeMailMessage: ; 04:59EB
	ld hl, wNamingScreenDestinationPointer
	ld [hl], e
	inc hl
	ld [hl], d
	ldh a, [hMapAnims]
	push af
	xor a
	ldh [hMapAnims], a
	ldh a, [hJoyDebounceSrc]
	push af
	ld a, 1
	ldh [hJoyDebounceSrc], a
	xor a
	ld [wFlyDestination], a
.outerloop
	call .firstruncheck
	call DelayFrame
.innerloop
	call DoMailEntry
	jr nc, .innerloop

	ld a, [wFlyDestination]
	bit 7, a
	jr nz, .outerloop

	pop af
	ldh [hJoyDebounceSrc], a
	pop af
	ldh [hMapAnims], a
	ret

.firstruncheck; 04:5A1B
	ld hl, wFlyDestination
	ld a, [hl]
	and 1
	ld [hl], a
	jr z, .skip
	call SetupMail
	ret
.skip
	call .InitBlankMail
	ret

.InitBlankMail: ; 04:5A2C
	call ClearBGPalettes
	ld b, 8 ;diploma?
	call GetSGBLayout
	call DisableLCD
	call LoadNamingScreenGFX
	ld de, vChars0
	ld hl, MailIconGFX
	ld bc, $0080
	ld a, BANK(MailIconGFX)
	call FarCopyData
	ld a, 8
	ld hl, wTileMapBackup
	ld [hli], a
	ld [hl], 0
	ld de, $2420
	ld a, 8
	call InitSpriteAnimStruct
	ld hl, $0002
	add hl, bc
	ld [hl], 0
	ld de, $5818
	ld a, $39
	call InitSpriteAnimStruct
	ld a, c
	ld [wNamingScreenCursorObjectPointer], a
	ld a, b
	ld [wNamingScreenCursorObjectPointer + 1], a
	call InitCharSet
	ld a, $E3
	ldh [rLCDC], a
	call InitMailText
	call WaitBGMap
	call WaitForAutoBgMapTransfer
	ld a, $90
	ldh [rBGP], a
	ld a, $E4
	ldh [rOBP0], a
	call NamingScreenInitNameEntry
	ld hl, wNamingScreenDestinationPointer
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, $0010
	add hl, de
	ld [hl], "<NEXT>"
	ret

InitMailText: ; 04:5A96
	hlcoord 5, 2
	ld de, MailPromptText
	call PlaceString
	ld a, $21
	ld [wNamingScreenMaxNameLength], a
	ret

MailPromptText: ; 04:5AA5
	db "メールを　かいてね@"

InitCharSet: ; 04:5AAF
	call WaitForAutoBgMapTransfer
	ld hl, wTileMap
	lb bc, $01, $68
	ld a, $60
	call ByteFill
	hlcoord 1, 1
	lb bc, $07, $12
	call ClearBox
	hlcoord 1, 9
	lb bc, $08, $12
	call ClearBox
	hlcoord 2, 9
	ld de, TextEntryChars
	ld b, $8
.outerloop
	ld c, $11
.innerloop
	ld a, [de]
	ld [hli], a
	inc de
	dec c
	jr nz, .innerloop
	inc hl
	inc hl
	inc hl
	dec b
	jr nz, .outerloop
	ret

DoMailEntry: ; 04:5AE6
	call GetJoypadDebounced
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .exit_mail
	ld a, [wFlyDestination]
	bit 7, a
	jr nz, .exit_mail
	call .DoJumpTable
	callba PlaySpriteAnimationsAndDelayFrame
	call .Update
	call DelayFrame
	and a
	ret

.exit_mail ; 04:5B0A
	callab InitEffectObject
	call ClearSprites
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	scf
	ret

.Update: ; 04:5B1C
	xor a
	ldh [hBGMapMode], a
	hlcoord 1, 3
	lb bc, $04, $12
	call ClearBox
	ld hl, wNamingScreenDestinationPointer
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 2, 4
	call PlaceString
	ld a, 1
	ldh [hBGMapMode], a
	ret

.DoJumpTable: ; 04:5B39
	ld a, [wJumptableIndex]
	ld e, a
	ld d, 0
	ld hl, .Jumptable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.Jumptable: ; 04:5B48
	dw .blinkcursor
	dw .processjoypad

.blinkcursor ; 04:5B4C
	ld hl, wJumptableIndex
	inc [hl]
	ret

.processjoypad; 04:5B51
	ld hl, hJoypadSum
	ld a, [hl]
	and A_BUTTON
	jr nz, .ajump
	ld a, [hl]
	and B_BUTTON
	jr nz, .bjump
	ld a, [hl]
	and START
	jr nz, .startjump
	ld a, [hl]
	and SELECT
	jr nz, .selectjump
	ret

.ajump ; 04:5B69
	call NamingScreenGetLastCharacter
	cp "円"
	jr z, .startjump
	call NamingScreenTryAddCharacter
	xor a
	ldh [hJoypadSum], a
	ld hl, wNamingScreenCurNameLength
	ld a, [hl]
	cp $10 ; mail line length?
	ret nz
	inc [hl]
	call NamingScreenGetTextCursorPosition
	ld [hl], "♀"
	dec hl
	ld [hl], "<NEXT>"
	ret
.bjump
	call NamingScreenDeleteCharacter
	xor a
	ldh [hJoypadSum], a
	ld hl, wNamingScreenCurNameLength
	ld a, [hl]
	cp $10
	ret nz
	dec [hl]
	call NamingScreenGetTextCursorPosition
	ld [hl], "♀"
	inc hl
	ld [hl], "<NEXT>"
	ret
.startjump
	call NamingScreenStoreEntry
	ld hl, wJumptableIndex
	set 7, [hl]
	ret
.selectjump
	ld hl, wFlyDestination
	ld a, [hl]
	xor 01
	ld [hl], a
	set 7, [hl]
	ret

SECTION "engine/menu/text_entry.asm@mail2", ROMX

SetupMail: ; 04:5C31
	call ClearBGPalettes
	ld b, 8
	call GetSGBLayout
	call DisableLCD
	call LoadNamingScreenGFX
	ld de, vChars1
	ld hl, BoldAlphabetGFX
	ld bc, $2e tiles
	ld a, BANK(BoldAlphabetGFX)
	call FarCopyDataDouble
	ld de, vChars0
	ld hl, MailIconGFX
	lb bc, $00, $80
	ld a, BANK(MailIconGFX)
	call FarCopyData
	ld a, 8
	ld hl, wTileMapBackup
	ld [hli], a
	ld [hl], 0
	ld de, $2420
	ld a, 8
	call InitSpriteAnimStruct
	ld hl, $0002
	add hl, bc
	ld [hl], 0
	ld de, $6018
	ld a, $40
	call InitSpriteAnimStruct
	ld a, c
	ld [wNamingScreenCursorObjectPointer], a
	ld a, b
	ld [wNamingScreenCursorObjectPointer + 1], a
	call DrawMail
	ld a, $E3
	ldh [rLCDC], a
	call DrawMailLoadedText
	call WaitBGMap
	call WaitForAutoBgMapTransfer
	ld a, $90
	ldh [rBGP], a
	ld a, $E4
	ldh [rOBP0], a
	call NamingScreenInitNameEntry
	ld hl, wNamingScreenDestinationPointer
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, $0010
	add hl, de
	ld [hl], "<NEXT>"
	ret

DrawMailLoadedText: ; 04:5CA9
	hlcoord 5, 2
	ld de, MailLoadedText
	call PlaceString
	ld a, $21
	ld [wNamingScreenMaxNameLength], a
	ret

MailLoadedText: ; 04:5CB8
	db "スアケシ！！！@" ; should be "MAIL!!!" since the bold english font is loaded into vChars1

DrawMail: ; 04:5CC0
	call WaitForAutoBgMapTransfer
	hlcoord 0, 0
	lb bc, $01, $68
	ld a, "■"
	call ByteFill
	hlcoord 1, 1
	lb bc, $07, $12
	call ClearBox
	hlcoord 1, 9
	lb bc, $08, $12
	call ClearBox
	hlcoord 2, 10
	ld a, $80
	call DrawMailRow
	hlcoord 2, 13
	ld a, $A0
	call DrawMailRow
	hlcoord 2, 16
	ld de, MailTextExtra
	ld c, $10
	call DrawMailTextExtra
	ret

DrawMailRow: ; 04:5CFC
	ld c, $07
	call .loop
	inc hl
	inc hl
	ld c, $07
	call .loop
	inc hl
	inc hl
	inc hl
	inc hl
	ld c, $07
	call .loop
	inc hl
	inc hl
	ld c, $05

.loop ; 04:5D15
	ld [hli], a
	inc a
	dec c
	jr nz, .loop
	ret

DrawMailTextExtra: ; 04:5D1B
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, DrawMailTextExtra
	ret

MailTextExtra: ; 04:5D22
	db "？！１２３４５　　６７８９０ー円"
