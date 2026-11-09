local E, L = unpack(ElvUI)
local _G = _G
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded
local GetPhysicalScreenSize = _G.GetPhysicalScreenSize

function ElvUI_EltreumUI:SetupLayoutDPS(silent)
	if not E.db.movers then E.db.movers = {} end
	if E.Modern then
		E.db["unitframe"]["units"]["player"]["customTexts"] = E.db["unitframe"]["units"]["player"]["customTexts"] or {}
		E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPlayerAbsorb"] = {
		["enable"] = false
		}
		E.db["unitframe"]["units"]["party"]["customTexts"] = E.db["unitframe"]["units"]["party"]["customTexts"] or {}
		E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyAbsorb"] = {
		["enable"] = false
		}
		E.db["unitframe"]["units"]["raid1"]["customTexts"] = E.db["unitframe"]["units"]["raid1"]["customTexts"] or {}
		E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Absorb"] = {
		["enable"] = false
		}
		E.db["unitframe"]["units"]["raid2"]["customTexts"] = E.db["unitframe"]["units"]["raid2"]["customTexts"] or {}
		E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Absorb"] = {
		["enable"] = false
		}
		E.db["unitframe"]["units"]["raid3"]["customTexts"] = E.db["unitframe"]["units"]["raid3"]["customTexts"] or {}
		E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Absorb"] = {
		["enable"] = false
		}
		E.db["unitframe"]["units"]["target"]["customTexts"] = E.db["unitframe"]["units"]["target"]["customTexts"] or {}
		E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetAbsorb"] = {
		["enable"] = false
		}
	end
	local width = GetPhysicalScreenSize()

	--healprediction
	E.db["unitframe"]["units"]["raid1"]["healPrediction"]["enable"] = false
	E.db["unitframe"]["units"]["raid2"]["healPrediction"]["enable"] = false
	E.db["unitframe"]["units"]["raid3"]["healPrediction"]["enable"] = false
	E.db["unitframe"]["units"]["raidpet"]["healPrediction"]["enable"] = false
	E.db["unitframe"]["units"]["tank"]["healPrediction"]["enable"] = false

	-- set Dynamic Status Icons
	if IsAddOnLoaded("ElvUI_DynamicStatusIcons") then
		E.db["unitframe"]["units"]["player"]["DynamicStatusIcons"]["xOffset"] = -75
		E.db["unitframe"]["units"]["player"]["DynamicStatusIcons"]["yOffset"] = -83
		E.db["unitframe"]["units"]["target"]["DynamicStatusIcons"]["xOffset"] = 75
		E.db["unitframe"]["units"]["target"]["DynamicStatusIcons"]["yOffset"] = -83
	end

	-- ActionBars
	-- Bar 1
	E.db["actionbar"]["bar1"]["alpha"] = 1
	E.db["actionbar"]["bar1"]["backdropSpacing"] = 0
	E.db["actionbar"]["bar1"]["buttonHeight"] = 35
	E.db["actionbar"]["bar1"]["buttonSize"] = 45
	E.db["actionbar"]["bar1"]["countFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar1"]["flyoutDirection"] = "UP"
	E.db["actionbar"]["bar1"]["hotkeyFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar1"]["macroFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar1"]["macroTextPosition"] = "BOTTOM"
	E.db["actionbar"]["bar1"]["macroTextYOffset"] = 2
	E.db["actionbar"]["bar1"]["macrotext"] = true

	-- Bar 2
	E.db["actionbar"]["bar2"]["alpha"] = 1
	E.db["actionbar"]["bar2"]["buttonHeight"] = 30
	E.db["actionbar"]["bar2"]["buttonSize"] = 35
	E.db["actionbar"]["bar2"]["countFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar2"]["hotkeyFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar2"]["macroFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar2"]["macroTextPosition"] = "BOTTOM"
	E.db["actionbar"]["bar2"]["macroTextYOffset"] = 2
	E.db["actionbar"]["bar2"]["macrotext"] = true
	E.db["actionbar"]["bar2"]["paging"]["DRUID"] = ""

	-- Bar 3
	E.db["actionbar"]["bar3"]["alpha"] = 1
	E.db["actionbar"]["bar3"]["buttonHeight"] = 30
	E.db["actionbar"]["bar3"]["buttonSize"] = 35
	E.db["actionbar"]["bar3"]["buttonsPerRow"] = 12
	E.db["actionbar"]["bar3"]["countFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar3"]["hotkeyFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar3"]["macroFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar3"]["macroTextPosition"] = "BOTTOM"
	E.db["actionbar"]["bar3"]["macroTextYOffset"] = 2
	E.db["actionbar"]["bar3"]["macrotext"] = true
	E.db["actionbar"]["bar3"]["paging"]["DRUID"] = ""

	-- Bar 4
	E.db["actionbar"]["bar4"]["alpha"] = 1
	E.db["actionbar"]["bar4"]["buttonHeight"] = 30
	E.db["actionbar"]["bar4"]["buttonSize"] = 35
	E.db["actionbar"]["bar4"]["countFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar4"]["hotkeyFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar4"]["macroFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar4"]["macroTextPosition"] = "BOTTOM"
	E.db["actionbar"]["bar4"]["macroTextYOffset"] = 2
	E.db["actionbar"]["bar4"]["macrotext"] = true
	E.db["actionbar"]["bar4"]["point"] = "BOTTOMLEFT"

	-- Bar 5
	E.db["actionbar"]["bar5"]["alpha"] = 1
	E.db["actionbar"]["bar5"]["buttonHeight"] = 30
	E.db["actionbar"]["bar5"]["buttonSize"] = 35
	E.db["actionbar"]["bar5"]["buttonsPerRow"] = 12
	E.db["actionbar"]["bar5"]["countFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar5"]["enabled"] = false
	E.db["actionbar"]["bar5"]["hotkeyFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar5"]["macroFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar5"]["macroTextPosition"] = "BOTTOM"
	E.db["actionbar"]["bar5"]["macroTextYOffset"] = 2
	E.db["actionbar"]["bar5"]["macrotext"] = true

	-- Bar 6
	E.db["actionbar"]["bar6"]["buttonSpacing"] = 3
	E.db["actionbar"]["bar6"]["buttonSize"] = 32

	-- Bar 7
	E.db["actionbar"]["bar7"]["alpha"] = 1
	E.db["actionbar"]["bar7"]["buttonHeight"] = 30
	E.db["actionbar"]["bar7"]["buttonSize"] = 35
	E.db["actionbar"]["bar7"]["countFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar7"]["hotkeyFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar7"]["keepSizeRatio"] = false
	E.db["actionbar"]["bar7"]["macroFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar7"]["macroTextPosition"] = "BOTTOM"
	E.db["actionbar"]["bar7"]["macroTextYOffset"] = 2
	E.db["actionbar"]["bar7"]["macrotext"] = true

	-- Bar 8
	E.db["actionbar"]["bar8"]["alpha"] = 1
	E.db["actionbar"]["bar8"]["buttonHeight"] = 30
	E.db["actionbar"]["bar8"]["buttonSize"] = 35
	E.db["actionbar"]["bar8"]["countFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar8"]["hotkeyFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar8"]["keepSizeRatio"] = false
	E.db["actionbar"]["bar8"]["macroFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar8"]["macroTextPosition"] = "BOTTOM"
	E.db["actionbar"]["bar8"]["macroTextYOffset"] = 2
	E.db["actionbar"]["bar8"]["macrotext"] = true

	-- Bar 9
	E.db["actionbar"]["bar9"]["alpha"] = 1
	E.db["actionbar"]["bar9"]["countFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar9"]["hotkeyFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar9"]["macroFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar9"]["macroTextPosition"] = "BOTTOM"
	E.db["actionbar"]["bar9"]["macroTextYOffset"] = 2
	E.db["actionbar"]["bar9"]["macrotext"] = true

	-- Bar 10
	E.db["actionbar"]["bar10"]["alpha"] = 1
	E.db["actionbar"]["bar10"]["buttons"] = 12
	E.db["actionbar"]["bar10"]["countFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar10"]["hotkeyFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar10"]["macroFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar10"]["macroTextPosition"] = "BOTTOM"
	E.db["actionbar"]["bar10"]["macroTextYOffset"] = 2
	E.db["actionbar"]["bar10"]["macrotext"] = true
	E.db["actionbar"]["bar10"]["visibility"] = "[vehicleui] hide; [overridebar] hide; [petbattle] hide; show[combat][@target, exists]show;hide"

	-- Pet Bar
	E.db["actionbar"]["barPet"]["backdrop"] = false
	E.db["actionbar"]["barPet"]["backdropSpacing"] = 0
	E.db["actionbar"]["barPet"]["buttonHeight"] = 24
	E.db["actionbar"]["barPet"]["buttonSize"] = 30
	E.db["actionbar"]["barPet"]["buttonSpacing"] = 3
	E.db["actionbar"]["barPet"]["buttonsPerRow"] = 5
	E.db["actionbar"]["barPet"]["countFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["barPet"]["hotkeyFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["barPet"]["visibility"] = "[vehicleui] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; [@pet,exists] show; hide"

	-- Stance Bar
	E.db["actionbar"]["stanceBar"]["backdropSpacing"] = 0
	E.db["actionbar"]["stanceBar"]["buttonSize"] = 27
	E.db["actionbar"]["stanceBar"]["buttons"] = 8
	E.db["actionbar"]["stanceBar"]["buttonsPerRow"] = 8
	if E.Retail then
		E.db["actionbar"]["stanceBar"]["mouseover"] = true
	elseif E.Mists or E.TBC or E.Wrath or E.Classic then
		E.db["actionbar"]["stanceBar"]["mouseover"] = false
	end

	-- Colors
	--E.db["actionbar"]["colorSwipeNormal"]["a"] = 1
	E.db["actionbar"]["noPowerColor"]["b"] = 0.29019607843137
	E.db["actionbar"]["noPowerColor"]["g"] = 0.14509803921569
	E.db["actionbar"]["noPowerColor"]["r"] = 0.14509803921569
	E.db["actionbar"]["notUsableColor"]["b"] = 0.1921568627451
	E.db["actionbar"]["notUsableColor"]["g"] = 0.1921568627451
	E.db["actionbar"]["notUsableColor"]["r"] = 0.1921568627451

	-- Vehicle Exit Button
	E.db["actionbar"]["vehicleExitButton"]["hotkeyFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["vehicleExitButton"]["size"] = 24

	-- Auras
	--E.db["auras"]["buffs"]["seperateOwn"] = -1
	E.db["auras"]["debuffs"]["fadeThreshold"] = 10

	-- Growth Directions DPS/TANK
	E.db["unitframe"]["units"]["party"]["growthDirection"] = "DOWN_RIGHT"

	-- Movers DPS/TANK
	E.db["movers"]["ArenaHeaderMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-120,-354"
	E.db["movers"]["AzeriteBarMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,430,-1"
	E.db["movers"]["BNETMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-6,-254"
	E.db["movers"]["BelowMinimapContainerMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-516,157"
	E.db["movers"]["BigButtonsSeedBarMover"] = "TOP,ElvUIParent,TOP,0,-476"
	E.db["movers"]["BossButton"] = "BOTTOM,ElvUIParent,BOTTOM,0,72"
	E.db["movers"]["BossHeaderMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-4,-306"
	E.db["movers"]["DurabilityFrameMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,486,278"
	E.db["movers"]["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,223"
	E.db["movers"]["ElvAB_10"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-4,264"
	E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,191"
	E.db["movers"]["ElvAB_3"] = "BOTTOM,ElvUIParent,BOTTOM,0,159"
	E.db["movers"]["ElvAB_4"] = "BOTTOM,ElvUIParent,BOTTOM,0,127"
	E.db["movers"]["ShiftAB"] = "BOTTOM,ElvUIParent,BOTTOM,0,106"
	if width == 1920 then
		E.db["movers"]["ElvAB_3"] = "BOTTOM,ElvUIParent,BOTTOM,0,158"
		E.db["movers"]["ElvAB_4"] = "BOTTOM,ElvUIParent,BOTTOM,0,125"
		E.db["actionbar"]["bar2"]["buttonSpacing"] = 2
		E.db["actionbar"]["bar3"]["buttonSpacing"] = 2
		E.db["actionbar"]["bar4"]["buttonSpacing"] = 2
		E.db["actionbar"]["bar5"]["buttonSpacing"] = 2
		E.db["movers"]["ShiftAB"] = "BOTTOM,ElvUIParent,BOTTOM,0,103"
	end
	E.db["movers"]["ElvAB_5"] = "BOTTOM,ElvUIParent,BOTTOM,0,97"
	E.db["movers"]["ElvAB_7"] = "BOTTOM,ElvUIParent,BOTTOM,0,66"
	E.db["movers"]["ElvAB_8"] = "BOTTOM,ElvUIParent,BOTTOM,0,35"
	E.db["movers"]["ElvAB_9"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-4,230"
	E.db["movers"]["ElvNP_PlayerMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,334"
	E.db["movers"]["ElvUF_AssistMover"] = "BOTTOM,ElvUIParent,BOTTOM,155,43"
	E.db["movers"]["ElvUF_BodyGuardMover"] = "TOP,ElvUIParent,TOP,0,-440"
	--E.db["movers"]["ElvUF_PartyMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-247" --original
	E.db["movers"]["ElvUF_PartyMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,199,-258" --alternate
	E.db["movers"]["ElvUF_PetCastbarMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,563,283"
	E.db["movers"]["ElvUF_PetMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,560,183"
	E.db["movers"]["ElvUF_PlayerAuraMover"] = "BOTTOM,ElvUIParent,BOTTOM,-276,239"
	E.db["movers"]["ElvUF_PlayerCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,-266,268"
	E.db["movers"]["ElvUF_TargetCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,294,268"
	E.db["movers"]["ElvUF_PlayerMover"] = "BOTTOM,ElvUIParent,BOTTOM,-280,299"
	E.db["movers"]["ElvUF_Raid1Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,1,-1"
	E.db["movers"]["ElvUF_Raid2Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,1,-1"
	E.db["movers"]["ElvUF_Raid3Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,1,-1"
	E.db["movers"]["ElvUF_RaidpetMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,736"
	E.db["movers"]["ElvUF_TankMover"] = "BOTTOM,ElvUIParent,BOTTOM,-155,39"
	E.db["movers"]["ElvUF_TargetMover"] = "BOTTOM,ElvUIParent,BOTTOM,280,299"
	E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-438,299"
	E.db["movers"]["ElvUIBagMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,0,23"
	E.db["movers"]["ElvUIBankMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,0,23"
	E.db["movers"]["MoverEltruismWA"] = "BOTTOM,ElvUIParent,BOTTOM,0,271"
	E.db["movers"]["MoverEltruismWA2"] = "BOTTOM,ElvUIParent,BOTTOM,0,345"
	E.db["movers"]["MoverEltruismWAConsumables"] = "BOTTOM,ElvUIParent,BOTTOM,-279,353"
	E.db["movers"]["GhostFrameMover"] = "TOP,ElvUIParent,TOP,0,-280"
	E.db["movers"]["LocationMover"] = "TOP,ElvUIParent,TOP,0,-2"
	E.db["movers"]["LootFrameMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,329,-156"
	E.db["movers"]["MasterExperienceMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,515,-79"
	--E.db["movers"]["MicrobarMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-412,23" --moved since it was overlapping with datatext
	E.db["movers"]["PetAB"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,560,129"
	if IsAddOnLoaded("ElvUI_SLE") then
		E.db["movers"]["SLE_DataPanel_1_Mover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-4,199"
	end
	E.db["movers"]["SocialMenuMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-411"
	E.db["movers"]["SquareMinimapBar"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,0,-198"
	E.db["movers"]["TalkingHeadFrameMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,329,-154"
	E.db["movers"]["TooltipMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,329,-154"
	E.db["movers"]["TorghastBuffsMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-4,-346"
	E.db["movers"]["TotemBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,100" --shaman
	E.db["movers"]["TotemTrackerMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,258" --class totem like consecration
	E.db["movers"]["AdditionalPowerMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,260"
	--[[if E.Cata then
		--Shaman things
		E.db["actionbar"]["totemBar"]["buttonSize"] = 24
		E.db["actionbar"]["totemBar"]["flyoutSize"] = 24
		E.db["actionbar"]["totemBar"]["flyoutSpacing"] = 3
		E.db["actionbar"]["totemBar"]["font"] = "Kimberley"
		E.db["actionbar"]["totemBar"]["spacing"] = 5
		E.db["actionbar"]["totemBar"]["flyoutDirection"] = "DOWN"
		E.db["actionbar"]["totemBar"]["visibility"] = "[combat] show;[@target, noexists] hide; [vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
	end]]
	E.db["movers"]["VOICECHAT"] = "TOPLEFT,ElvUIParent,TOPLEFT,329,-154"
	if IsAddOnLoaded("ElvUI_WindTools") then
		E.db["movers"]["WTCustomEmoteFrameMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,272,-448"
		E.db["movers"]["WTExtraItemsBar1Mover"] = "BOTTOM,ElvUIParent,BOTTOM,0,1"
		E.db["movers"]["WTExtraItemsBar2Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,333,-176"
		E.db["movers"]["WTExtraItemsBar3Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,331,-176"
		E.db["movers"]["WTExtraItemsBar4Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,329,-176"
		E.db["movers"]["WTExtraItemsBar5Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,329,-176"
		E.db["movers"]["WTMinimapButtonBarAnchor"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,0,-222"
		E.db["movers"]["WTParagonReputationToastFrameMover"] = "TOP,ElvUIParent,TOP,0,-204"
		E.db["movers"]["WTRaidMarkersBarAnchor"] = "TOPLEFT,ElvUIParent,TOPLEFT,398,1"
		E.db["movers"]["WTSwitchButtonBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,266,390"
	end
	E.db["movers"]["ZoneAbility"] = "BOTTOM,ElvUIParent,BOTTOM,0,34"
	E.db["movers"]["iFilger_CooldownsMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,575,428"
	E.db["movers"]["iFilger_FocusBuffsMover"] = "BOTTOM,ElvUIParent,BOTTOM,-233,401"
	E.db["movers"]["iFilger_FocusDebuffsMover"] = "BOTTOM,ElvUIParent,BOTTOM,-217,461"
	E.db["movers"]["iFilger_ItemCooldownsMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,526,450"

	-- UnitFrames DPS/TANK
	-- Assist
	E.db["unitframe"]["units"]["assist"]["rdebuffs"]["fontOutline"] = "THICKOUTLINE"

	-- Focus
	E.db["unitframe"]["units"]["focus"]["castbar"]["customColor"]["colorBackdrop"]["b"] = 0.50196078431373
	E.db["unitframe"]["units"]["focus"]["castbar"]["customColor"]["colorBackdrop"]["g"] = 0.50196078431373
	E.db["unitframe"]["units"]["focus"]["castbar"]["customColor"]["colorBackdrop"]["r"] = 0.50196078431373
	--E.db["unitframe"]["units"]["focus"]["castbar"]["customColor"]["enable"] = true
	E.db["unitframe"]["units"]["focus"]["castbar"]["customColor"]["enable"] = false

	-- FocusTarget
	E.db["unitframe"]["units"]["focustarget"]["power"]["enable"] = false
	E.db["unitframe"]["units"]["focustarget"]["power"]["text_format"] = "[power:current:shortvalue]"

	-- Party
	E.db["unitframe"]["units"]["party"]["buffIndicator"]["size"] = 20
	E.db["unitframe"]["units"]["party"]["buffs"]["countFontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["party"]["buffs"]["enable"] = false
	E.db["unitframe"]["units"]["party"]["buffs"]["sizeOverride"] = 30
	E.db["unitframe"]["units"]["party"]["debuffs"]["countFontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["party"]["debuffs"]["xOffset"] = 5
	E.db["unitframe"]["units"]["party"]["debuffs"]["yOffset"] = 11
	E.db["unitframe"]["units"]["party"]["debuffs"]["anchorPoint"] = "RIGHT"
	E.db["unitframe"]["units"]["party"]["debuffs"]["perrow"] = 4
	E.db["unitframe"]["units"]["party"]["debuffs"]["sizeOverride"] = 30
	E.db["unitframe"]["units"]["party"]["debuffs"]["spacing"] = 2
	E.db["unitframe"]["units"]["party"]["disableMouseoverGlow"] = true
	E.db["unitframe"]["units"]["party"]["fader"]["minAlpha"] = 0.2
	E.db["unitframe"]["units"]["party"]["name"]["xOffset"] = 2
	E.db["unitframe"]["units"]["party"]["orientation"] = "MIDDLE"
	E.db["unitframe"]["units"]["party"]["power"]["height"] = 14
	E.db["unitframe"]["units"]["party"]["power"]["yOffset"] = 1
	E.db["unitframe"]["units"]["party"]["raidRoleIcons"]["yOffset"] = -3
	E.db["unitframe"]["units"]["party"]["raidicon"]["attachTo"] = "CENTER"
	E.db["unitframe"]["units"]["party"]["raidicon"]["attachToObject"] = "Health"
	E.db["unitframe"]["units"]["party"]["raidicon"]["size"] = 20
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["enable"] = true
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["xOffset"] = -75
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["yOffset"] = 38
	E.db["unitframe"]["units"]["party"]["readycheckIcon"]["position"] = "CENTER"
	E.db["unitframe"]["units"]["party"]["readycheckIcon"]["yOffset"] = 0
	E.db["unitframe"]["units"]["party"]["resurrectIcon"]["attachTo"] = "RIGHT"
	E.db["unitframe"]["units"]["party"]["resurrectIcon"]["xOffset"] = 5
	E.db["unitframe"]["units"]["party"]["roleIcon"]["attachTo"] = "Frame"
	E.db["unitframe"]["units"]["party"]["roleIcon"]["position"] = "TOPRIGHT"
	E.db["unitframe"]["units"]["party"]["roleIcon"]["size"] = 12
	E.db["unitframe"]["units"]["party"]["roleIcon"]["xOffset"] = -1
	E.db["unitframe"]["units"]["party"]["roleIcon"]["yOffset"] = -1
	E.db["unitframe"]["units"]["party"]["summonIcon"]["size"] = 40
	E.db["unitframe"]["units"]["party"]["verticalSpacing"] = 20
	E.db["unitframe"]["units"]["party"]["width"] = 200
	E.db["unitframe"]["units"]["party"]["petsGroup"]["height"] = 75
	if E.Retail or E.Mists or E.TBC or E.Wrath then
		E.db["unitframe"]["units"]["party"]["petsGroup"]["name"]["text_format"] = "[name]"
	else
		E.db["unitframe"]["units"]["party"]["petsGroup"]["name"]["text_format"] = "[name][happiness:discord]"
	end
	E.db["unitframe"]["units"]["party"]["petsGroup"]["width"] = 100
	E.db["unitframe"]["units"]["party"]["petsGroup"]["xOffset"] = 4

	-- Pet
	E.db["unitframe"]["units"]["pet"]["debuffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["pet"]["smartAuraPosition"] = "FLUID_DEBUFFS_ON_BUFFS"
	E.db["unitframe"]["units"]["pet"]["power"]["enable"] = not E.Retail
	E.db["unitframe"]["units"]["pet"]["castbar"]["width"] = 159
	E.db["unitframe"]["units"]["pet"]["width"] = 159
	if width == 1920 then
		E.db["unitframe"]["units"]["pet"]["castbar"]["width"] = 162
		E.db["unitframe"]["units"]["pet"]["width"] = 162
	elseif width == 2560 then
		E.db["unitframe"]["units"]["pet"]["castbar"]["width"] = 157
		E.db["unitframe"]["units"]["pet"]["width"] = 157
	end

	-- PetTarget
	E.db["unitframe"]["units"]["pettarget"]["buffs"]["countFontOutline"] = "NONE"
	E.db["unitframe"]["units"]["pettarget"]["debuffs"]["countFontOutline"] = "NONE"
	E.db["unitframe"]["units"]["pettarget"]["power"]["enable"] = false
	E.db["unitframe"]["units"]["pettarget"]["power"]["text_format"] = "[power:current:shortvalue]"

	-- Player
	E.db["unitframe"]["units"]["player"]["aurabar"]["detachedWidth"] = 266
	E.db["unitframe"]["units"]["player"]["aurabar"]["maxDuration"] = 60
	E.db["unitframe"]["units"]["player"]["buffs"]["yOffset"] = 22
	E.db["unitframe"]["units"]["player"]["castbar"]["customColor"]["colorBackdrop"]["b"] = 0
	E.db["unitframe"]["units"]["player"]["castbar"]["customColor"]["colorBackdrop"]["g"] = 0
	E.db["unitframe"]["units"]["player"]["castbar"]["customColor"]["colorBackdrop"]["r"] = 0
	E.db["unitframe"]["units"]["player"]["castbar"]["customColor"]["enable"] = false
	E.db["unitframe"]["units"]["player"]["castbar"]["customColor"]["invertColors"] = false
	E.db["unitframe"]["units"]["player"]["castbar"]["customTimeFont"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["player"]["castbar"]["customTimeFont"]["fontSize"] = 11
	E.db["unitframe"]["units"]["player"]["castbar"]["customTimeFont"]["fontStyle"] = "OUTLINE"
	E.db["unitframe"]["units"]["player"]["castbar"]["height"] = 30
	E.db["unitframe"]["units"]["player"]["castbar"]["iconSize"] = 29
	E.db["unitframe"]["units"]["player"]["castbar"]["width"] = 242
	if width == 1920 then
		E.db["unitframe"]["units"]["player"]["castbar"]["width"] = 240
	end
	E.db["unitframe"]["units"]["player"]["castbar"]["textColor"]["b"] = 1
	E.db["unitframe"]["units"]["player"]["castbar"]["textColor"]["g"] = 1
	E.db["unitframe"]["units"]["player"]["castbar"]["textColor"]["r"] = 1
	E.db["unitframe"]["units"]["player"]["castbar"]["tickColor"]["a"] = 0.80000001192093
	E.db["unitframe"]["units"]["player"]["classbar"]["detachedWidth"] = 136
	E.db["unitframe"]["units"]["player"]["debuffs"]["countYOffset"] = -4
	E.db["unitframe"]["units"]["player"]["debuffs"]["yOffset"] = -53
	E.db["unitframe"]["units"]["player"]["debuffs"]["xOffset"] = -15
	E.db["unitframe"]["units"]["player"]["debuffs"]["numrows"] = 1
	E.db["unitframe"]["units"]["player"]["debuffs"]["perrow"] = 4
	E.db["unitframe"]["units"]["player"]["debuffs"]["spacing"] = 2
	E.db["unitframe"]["units"]["player"]["name"]["xOffset"] = 2
	E.db["unitframe"]["units"]["player"]["partyIndicator"]["anchorPoint"] = "TOPLEFT"
	E.db["unitframe"]["units"]["player"]["partyIndicator"]["xOffset"] = 0
	E.db["unitframe"]["units"]["player"]["partyIndicator"]["yOffset"] = 5
	E.db["unitframe"]["units"]["player"]["power"]["height"] = 15
	E.db["unitframe"]["units"]["player"]["raidRoleIcons"]["xOffset"] = -1
	E.db["unitframe"]["units"]["player"]["raidRoleIcons"]["yOffset"] = -2
	E.db["unitframe"]["units"]["player"]["raidicon"]["attachTo"] = "RIGHT"
	E.db["unitframe"]["units"]["player"]["raidicon"]["size"] = 20
	E.db["unitframe"]["units"]["player"]["raidicon"]["xOffset"] = 30
	E.db["unitframe"]["units"]["player"]["raidicon"]["yOffset"] = 2

	-- Raid 1
	E.db["unitframe"]["units"]["raid1"]["buffIndicator"]["size"] = 20
	E.db["unitframe"]["units"]["raid1"]["buffs"]["anchorPoint"] = "BOTTOMRIGHT"
	E.db["unitframe"]["units"]["raid1"]["buffs"]["attachTo"] = "DEBUFFS"
	E.db["unitframe"]["units"]["raid1"]["buffs"]["countXOffset"] = 2
	E.db["unitframe"]["units"]["raid1"]["buffs"]["yOffset"] = -5
	E.db["unitframe"]["units"]["raid1"]["debuffs"]["anchorPoint"] = "TOPRIGHT"
	E.db["unitframe"]["units"]["raid1"]["debuffs"]["countXOffset"] = 2
	E.db["unitframe"]["units"]["raid1"]["debuffs"]["sizeOverride"] = 20
	E.db["unitframe"]["units"]["raid1"]["debuffs"]["xOffset"] = 25
	E.db["unitframe"]["units"]["raid1"]["debuffs"]["yOffset"] = -16
	E.db["unitframe"]["units"]["raid1"]["disableMouseoverGlow"] = true
	E.db["unitframe"]["units"]["raid1"]["fader"]["minAlpha"] = 0.5
	E.db["unitframe"]["units"]["raid1"]["groupBy"] = "ROLE"
	E.db["unitframe"]["units"]["raid1"]["groupsPerRowCol"] = 4
	E.db["unitframe"]["units"]["raid1"]["health"]["attachTextTo"] = "InfoPanel"
	E.db["unitframe"]["units"]["raid1"]["health"]["position"] = "TOPRIGHT"
	E.db["unitframe"]["units"]["raid1"]["health"]["xOffset"] = 0
	E.db["unitframe"]["units"]["raid1"]["health"]["yOffset"] = 0
	E.db["unitframe"]["units"]["raid1"]["height"] = 28
	E.db["unitframe"]["units"]["raid1"]["width"] = 120
	E.db["unitframe"]["units"]["raid1"]["groupSpacing"] = 6
	E.db["unitframe"]["units"]["raid1"]["name"]["xOffset"] = 2
	E.db["unitframe"]["units"]["raid1"]["power"]["text_format"] = ""
	E.db["unitframe"]["units"]["raid1"]["raidRoleIcons"]["yOffset"] = -3
	E.db["unitframe"]["units"]["raid1"]["raidicon"]["attachTo"] = "CENTER"
	E.db["unitframe"]["units"]["raid1"]["raidicon"]["yOffset"] = -5
	E.db["unitframe"]["units"]["raid1"]["rdebuffs"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["raid1"]["rdebuffs"]["size"] = 25
	E.db["unitframe"]["units"]["raid1"]["rdebuffs"]["stack"]["xOffset"] = 2
	E.db["unitframe"]["units"]["raid1"]["rdebuffs"]["xOffset"] = 0
	E.db["unitframe"]["units"]["raid1"]["rdebuffs"]["yOffset"] = 14
	E.db["unitframe"]["units"]["raid1"]["readycheckIcon"]["position"] = "CENTER"
	E.db["unitframe"]["units"]["raid1"]["readycheckIcon"]["yOffset"] = 0
	E.db["unitframe"]["units"]["raid1"]["resurrectIcon"]["yOffset"] = 2
	E.db["unitframe"]["units"]["raid1"]["roleIcon"]["xOffset"] = -1
	E.db["unitframe"]["units"]["raid1"]["summonIcon"]["yOffset"] = -5
	E.db["unitframe"]["units"]["raid1"]["verticalSpacing"] = 3

	-- Raid Pets
	E.db["unitframe"]["units"]["raidpet"]["horizontalSpacing"] = 0
	E.db["unitframe"]["units"]["raidpet"]["numGroups"] = 3
	E.db["unitframe"]["units"]["raidpet"]["rdebuffs"]["duration"]["position"] = "TOP"
	E.db["unitframe"]["units"]["raidpet"]["rdebuffs"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["raidpet"]["rdebuffs"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["raidpet"]["rdebuffs"]["stack"]["xOffset"] = 2
	E.db["unitframe"]["units"]["raidpet"]["rdebuffs"]["stack"]["yOffset"] = -3
	E.db["unitframe"]["units"]["raidpet"]["rdebuffs"]["yOffset"] = 3
	E.db["unitframe"]["units"]["raidpet"]["verticalSpacing"] = 0
	E.db["unitframe"]["units"]["raidpet"]["visibility"] = "[@raid6,exists] show; hide"

	-- Raid 2
	E.db["unitframe"]["units"]["raid2"]["buffIndicator"]["size"] = 20
	E.db["unitframe"]["units"]["raid2"]["buffs"]["anchorPoint"] = "BOTTOMRIGHT"
	E.db["unitframe"]["units"]["raid2"]["buffs"]["attachTo"] = "DEBUFFS"
	E.db["unitframe"]["units"]["raid2"]["buffs"]["countXOffset"] = 2
	E.db["unitframe"]["units"]["raid2"]["buffs"]["yOffset"] = -5
	E.db["unitframe"]["units"]["raid2"]["debuffs"]["anchorPoint"] = "TOPRIGHT"
	E.db["unitframe"]["units"]["raid2"]["debuffs"]["countXOffset"] = 2
	E.db["unitframe"]["units"]["raid2"]["debuffs"]["sizeOverride"] = 20
	E.db["unitframe"]["units"]["raid2"]["debuffs"]["xOffset"] = 25
	E.db["unitframe"]["units"]["raid2"]["debuffs"]["yOffset"] = -16
	E.db["unitframe"]["units"]["raid2"]["disableMouseoverGlow"] = true
	E.db["unitframe"]["units"]["raid2"]["groupBy"] = "ROLE"
	E.db["unitframe"]["units"]["raid2"]["groupSpacing"] = 6
	E.db["unitframe"]["units"]["raid2"]["groupsPerRowCol"] = 4
	E.db["unitframe"]["units"]["raid2"]["health"]["attachTextTo"] = "InfoPanel"
	E.db["unitframe"]["units"]["raid2"]["health"]["position"] = "TOPRIGHT"
	E.db["unitframe"]["units"]["raid2"]["health"]["xOffset"] = 0
	E.db["unitframe"]["units"]["raid2"]["health"]["yOffset"] = 0
	E.db["unitframe"]["units"]["raid2"]["height"] = 28
	E.db["unitframe"]["units"]["raid2"]["horizontalSpacing"] = 0
	E.db["unitframe"]["units"]["raid2"]["name"]["xOffset"] = 2
	E.db["unitframe"]["units"]["raid2"]["raidRoleIcons"]["yOffset"] = -3
	E.db["unitframe"]["units"]["raid2"]["raidicon"]["attachTo"] = "CENTER"
	E.db["unitframe"]["units"]["raid2"]["raidicon"]["yOffset"] = -5
	E.db["unitframe"]["units"]["raid2"]["rdebuffs"]["size"] = 25
	E.db["unitframe"]["units"]["raid2"]["rdebuffs"]["stack"]["xOffset"] = 2
	E.db["unitframe"]["units"]["raid2"]["readycheckIcon"]["position"] = "CENTER"
	E.db["unitframe"]["units"]["raid2"]["readycheckIcon"]["yOffset"] = 0
	E.db["unitframe"]["units"]["raid2"]["resurrectIcon"]["yOffset"] = 2
	E.db["unitframe"]["units"]["raid2"]["summonIcon"]["yOffset"] = -5
	E.db["unitframe"]["units"]["raid2"]["width"] = 120

	-- Raid 3
	E.db["unitframe"]["units"]["raid3"]["height"] = 28
	E.db["unitframe"]["units"]["raid3"]["width"] = 120
	E.db["unitframe"]["units"]["raid3"]["groupSpacing"] = 6
	E.db["unitframe"]["units"]["raid3"]["buffIndicator"]["size"] = 10
	E.db["unitframe"]["units"]["raid3"]["disableMouseoverGlow"] = true
	E.db["unitframe"]["units"]["raid3"]["fader"]["minAlpha"] = 0.5
	E.db["unitframe"]["units"]["raid3"]["groupsPerRowCol"] = 4
	E.db["unitframe"]["units"]["raid3"]["health"]["position"] = "BOTTOMRIGHT"
	E.db["unitframe"]["units"]["raid3"]["horizontalSpacing"] = 2
	E.db["unitframe"]["units"]["raid3"]["name"]["position"] = "LEFT"
	E.db["unitframe"]["units"]["raid3"]["name"]["xOffset"] = 2
	E.db["unitframe"]["units"]["raid3"]["power"]["text_format"] = "[power:current:shortvalue]"
	E.db["unitframe"]["units"]["raid3"]["raidRoleIcons"]["yOffset"] = -3
	E.db["unitframe"]["units"]["raid3"]["raidicon"]["attachTo"] = "CENTER"
	E.db["unitframe"]["units"]["raid3"]["raidicon"]["yOffset"] = -5
	E.db["unitframe"]["units"]["raid3"]["rdebuffs"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["raid3"]["rdebuffs"]["yOffset"] = 16
	E.db["unitframe"]["units"]["raid3"]["roleIcon"]["attachTo"] = "Frame"
	E.db["unitframe"]["units"]["raid3"]["roleIcon"]["xOffset"] = -1
	E.db["unitframe"]["units"]["raid3"]["roleIcon"]["yOffset"] = -1
	E.db["unitframe"]["units"]["raid3"]["verticalSpacing"] = 3

	-- Tank
	E.db["unitframe"]["units"]["tank"]["debuffs"]["sizeOverride"] = 20
	E.db["unitframe"]["units"]["tank"]["fader"]["minAlpha"] = 0.5
	E.db["unitframe"]["units"]["tank"]["name"]["text_format"] = "[name:eltruism:gradientshort]"
	E.db["unitframe"]["units"]["tank"]["targetsGroup"]["enable"] = false
	E.db["unitframe"]["units"]["tank"]["targetsGroup"]["name"]["text_format"] = "[name:eltruism:gradientshort]"
	E.db["unitframe"]["units"]["tank"]["targetsGroup"]["raidicon"]["attachTo"] = "RIGHT"
	E.db["unitframe"]["units"]["tank"]["targetsGroup"]["raidicon"]["size"] = 8
	E.db["unitframe"]["units"]["tank"]["targetsGroup"]["raidicon"]["yOffset"] = 0
	E.db["unitframe"]["units"]["tank"]["targetsGroup"]["xOffset"] = 2

	-- Target
	E.db["unitframe"]["units"]["target"]["aurabar"]["maxBars"] = 15
	E.db["unitframe"]["units"]["target"]["buffs"]["numrows"] = 4
	E.db["unitframe"]["units"]["target"]["buffs"]["perrow"] = 4
	E.db["unitframe"]["units"]["target"]["buffs"]["anchorPoint"] = "BOTTOM"
	E.db["unitframe"]["units"]["target"]["buffs"]["xOffset"] = 15
	E.db["unitframe"]["units"]["target"]["buffs"]["yOffset"] = -65
	E.db["unitframe"]["units"]["target"]["buffs"]["enable"] = true
	E.db["unitframe"]["units"]["target"]["castbar"]["customColor"]["enable"] = false
	E.db["unitframe"]["units"]["target"]["castbar"]["customColor"]["invertColors"] = false
	E.db["unitframe"]["units"]["target"]["castbar"]["customColor"]["transparent"] = true
	E.db["unitframe"]["units"]["target"]["castbar"]["customTimeFont"]["fontSize"] = 11
	E.db["unitframe"]["units"]["target"]["castbar"]["customTimeFont"]["fontStyle"] = "NONE"
	E.db["unitframe"]["units"]["target"]["castbar"]["height"] = 30
	E.db["unitframe"]["units"]["target"]["castbar"]["iconAttached"] = false
	E.db["unitframe"]["units"]["target"]["castbar"]["iconSize"] = 29
	E.db["unitframe"]["units"]["target"]["castbar"]["width"] = 242
	if width == 1920 then
		E.db["unitframe"]["units"]["target"]["castbar"]["width"] = 240
	end
	E.db["unitframe"]["units"]["target"]["debuffs"]["anchorPoint"] = "TOPLEFT"
	E.db["unitframe"]["units"]["target"]["debuffs"]["enable"] = false
	E.db["unitframe"]["units"]["target"]["fader"]["minAlpha"] = 0.25
	E.db["unitframe"]["units"]["target"]["infoPanel"]["height"] = 2
	E.db["unitframe"]["units"]["target"]["name"]["xOffset"] = 2
	E.db["unitframe"]["units"]["target"]["power"]["height"] = 15
	E.db["unitframe"]["units"]["target"]["power"]["position"] = "BOTTOMRIGHT"
	E.db["unitframe"]["units"]["target"]["power"]["yOffset"] = 1
	E.db["unitframe"]["units"]["target"]["raidRoleIcons"]["yOffset"] = -2
	E.db["unitframe"]["units"]["target"]["raidicon"]["attachTo"] = "LEFT"
	E.db["unitframe"]["units"]["target"]["raidicon"]["size"] = 20
	E.db["unitframe"]["units"]["target"]["raidicon"]["xOffset"] = -25
	E.db["unitframe"]["units"]["target"]["smartAuraPosition"] = "DEBUFFS_ON_BUFFS"

	-- TargetTarget
	E.db["unitframe"]["units"]["targettarget"]["health"]["position"] = "LEFT"
	E.db["unitframe"]["units"]["targettarget"]["health"]["xOffset"] = 2
	E.db["unitframe"]["units"]["targettarget"]["health"]["yOffset"] = 3
	E.db["unitframe"]["units"]["targettarget"]["name"]["position"] = "TOPLEFT"
	E.db["unitframe"]["units"]["targettarget"]["portrait"]["paused"] = true
	E.db["unitframe"]["units"]["targettarget"]["power"]["height"] = 15
	E.db["unitframe"]["units"]["targettarget"]["raidicon"]["size"] = 20
	E.db["unitframe"]["units"]["targettarget"]["raidicon"]["yOffset"] = 25
	E.db["unitframe"]["units"]["targettarget"]["width"] = 100

	-- TargetTargetTarget
	E.db["unitframe"]["units"]["targettargettarget"]["buffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["targettargettarget"]["power"]["enable"] = false
	E.db["unitframe"]["units"]["targettargettarget"]["power"]["text_format"] = "[power:current:shortvalue]"

	E:UpdateAll()
	if not silent then
		ElvUI_EltreumUI:Print(L["DPS/Tank Layout has been set."])
	end
end
