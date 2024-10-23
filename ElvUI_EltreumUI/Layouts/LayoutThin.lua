local E = unpack(ElvUI)

-- Experimental Thin Layout
function ElvUI_EltreumUI:SetupLayoutThin()
	if (E.Cata or E.Retail or E.ClassicSOD) and E.data:IsDualSpecEnabled() then
		E.data:SetDualSpecProfile('Eltreum Thin ('..E.mynameRealm..')', E.Libs.DualSpec.currentSpec)
	else
		E.data:SetProfile('Eltreum Thin ('..E.mynameRealm..')')
	end
	ElvUI_EltreumUI:SetupLayoutDPS(true)
	ElvUI_EltreumUI:SetupNamePlates()
	ElvUI_EltreumUI:ResolutionOutline()
	ElvUI_EltreumUI:UpdateEltruismSettings()

	E.db.ElvUI_EltreumUI.unitframes.thinmodeaurabars = true

	E.db["ElvUI_EltreumUI"]["borders"]["borderautoadjust"] = false
	E.db.ElvUI_EltreumUI.skins.elvui.texture = "Eltreum-Tile03"

	E.db["actionbar"]["bar1"]["buttonHeight"] = 20
	E.db["actionbar"]["bar1"]["countTextPosition"] = "BOTTOMLEFT"
	E.db["actionbar"]["bar2"]["buttonHeight"] = 17
	E.db["actionbar"]["bar2"]["countTextPosition"] = "BOTTOMLEFT"
	E.db["actionbar"]["bar3"]["buttonHeight"] = 17
	E.db["actionbar"]["bar3"]["countTextPosition"] = "BOTTOMLEFT"
	E.db["actionbar"]["bar4"]["buttonHeight"] = 17
	E.db["actionbar"]["bar4"]["countTextPosition"] = "BOTTOMLEFT"
	E.db["actionbar"]["stanceBar"]["buttonHeight"] = 17

	E.db["actionbar"]["barPet"]["backdrop"] = false
	E.db["actionbar"]["barPet"]["backdropSpacing"] = 0
	E.db["actionbar"]["barPet"]["buttonHeight"] = 15
	E.db["actionbar"]["barPet"]["buttonSize"] = 30
	E.db["actionbar"]["barPet"]["buttonSpacing"] = 3
	E.db["actionbar"]["barPet"]["buttonsPerRow"] = 5
	E.db["actionbar"]["barPet"]["inheritGlobalFade"] = true
	E.db["actionbar"]["barPet"]["keepSizeRatio"] = false

	E.db["databars"]["experience"]["height"] = 5
	E.db["databars"]["reputation"]["height"] = 5
	E.db["databars"]["threat"]["height"] = 5

	E.db["movers"]["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,233"
	E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,214"
	E.db["movers"]["ElvAB_3"] = "BOTTOM,ElvUIParent,BOTTOM,0,194"
	E.db["movers"]["ElvAB_4"] = "BOTTOM,ElvUIParent,BOTTOM,0,175"
	E.db["movers"]["PetAB"] = "BOTTOM,ElvUIParent,BOTTOM,-319,146"
	E.db["movers"]["ElvUF_PetCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,-318,223"
	E.db["movers"]["ElvUF_PlayerCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,-280,265"
	E.db["movers"]["ElvUF_TargetCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,280,265"
	E.db["movers"]["ShiftAB"] = "BOTTOM,ElvUIParent,BOTTOM,0,157"
	E.db["movers"]["TotemTrackerMover"] = "BOTTOM,UIParent,BOTTOM,0,301"
	E.db["movers"]["BossHeaderMover"] = "TOPRIGHT,UIParent,TOPRIGHT,-4,-372"
	E.db["movers"]["ReputationBarMover"] = "TOP,ElvUIParent,TOP,0,-5"
	E.db["movers"]["ExperienceBarMover"] = "TOP,ElvUIParent,TOP,0,-13"
	E.db["movers"]["ThreatBarMover"] = "TOP,ElvUIParent,TOP,0,-43"

	E.db["unitframe"]["units"]["focus"]["castbar"]["customTextFont"]["enable"] = true
	E.db["unitframe"]["units"]["focus"]["castbar"]["customTextFont"]["fontSize"] = 14
	E.db["unitframe"]["units"]["focus"]["castbar"]["customTimeFont"]["enable"] = true
	E.db["unitframe"]["units"]["focus"]["castbar"]["height"] = 10
	E.db["unitframe"]["units"]["focus"]["castbar"]["iconAttached"] = false
	E.db["unitframe"]["units"]["focus"]["castbar"]["iconAttachedTo"] = "Castbar"
	E.db["unitframe"]["units"]["focus"]["castbar"]["iconSize"] = 30
	E.db["unitframe"]["units"]["focus"]["castbar"]["iconXOffset"] = -4
	E.db["unitframe"]["units"]["focus"]["castbar"]["iconYOffset"] = 10
	E.db["unitframe"]["units"]["focus"]["castbar"]["textColor"]["b"] = 1
	E.db["unitframe"]["units"]["focus"]["castbar"]["textColor"]["g"] = 1
	E.db["unitframe"]["units"]["focus"]["castbar"]["textColor"]["r"] = 1
	E.db["unitframe"]["units"]["focus"]["castbar"]["xOffsetText"] = 0
	E.db["unitframe"]["units"]["focus"]["castbar"]["yOffsetText"] = 7
	E.db["unitframe"]["units"]["focus"]["castbar"]["yOffsetTime"] = 7
	E.db["unitframe"]["units"]["focus"]["height"] = 10
	E.db["unitframe"]["units"]["focus"]["name"]["attachTextTo"] = "Frame"
	E.db["unitframe"]["units"]["focus"]["infoPanel"]["enable"] = false
	E.db["unitframe"]["units"]["focus"]["power"]["strataAndLevel"]["useCustomLevel"] = false
	E.db["unitframe"]["units"]["focus"]["power"]["strataAndLevel"]["useCustomStrata"] = false
	E.db["unitframe"]["units"]["focus"]["name"]["yOffset"] = 12
	E.db["unitframe"]["units"]["focus"]["power"]["height"] = 7
	E.db["unitframe"]["units"]["focus"]["power"]["position"] = "CENTER"
	E.db["unitframe"]["units"]["focus"]["power"]["xOffset"] = 0
	E.db["unitframe"]["units"]["focus"]["power"]["yOffset"] = -10
	E.db["unitframe"]["units"]["focus"]["name"]["text_format"] = "[name:eltruism:gradientshort] [eltruism:ReleafIconOutline:player] [eltruism:raidmarker]"

	E.db["unitframe"]["units"]["party"]["height"] = 35
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["yOffset"] = 20
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["xOffset"] = 0
	E.db["unitframe"]["units"]["party"]["roleIcon"]["position"] = "TOPLEFT"
	E.db["unitframe"]["units"]["party"]["roleIcon"]["xOffset"] = 1
	E.db["unitframe"]["units"]["party"]["debuffs"]["yOffset"] = 0

	E.db["unitframe"]["units"]["player"]["CombatIcon"]["xOffset"] = 20
	E.db["unitframe"]["units"]["player"]["RestIcon"]["anchorPoint"] = "LEFT"
	E.db["unitframe"]["units"]["player"]["RestIcon"]["xOffset"] = 11
	E.db["unitframe"]["units"]["player"]["RestIcon"]["yOffset"] = 16
	E.db["unitframe"]["units"]["player"]["aurabar"]["height"] = 15
	E.db["unitframe"]["units"]["player"]["aurabar"]["yOffset"] = 15
	E.db["unitframe"]["units"]["player"]["castbar"]["customTextFont"]["enable"] = true
	E.db["unitframe"]["units"]["player"]["castbar"]["customTimeFont"]["enable"] = true
	E.db["unitframe"]["units"]["player"]["castbar"]["height"] = 10
	E.db["unitframe"]["units"]["player"]["castbar"]["iconSize"] = 20
	E.db["unitframe"]["units"]["player"]["castbar"]["iconXOffset"] = -2
	E.db["unitframe"]["units"]["player"]["castbar"]["iconYOffset"] = 5
	E.db["unitframe"]["units"]["player"]["castbar"]["yOffsetText"] = 4
	E.db["unitframe"]["units"]["player"]["castbar"]["yOffsetTime"] = 4
	E.db["unitframe"]["units"]["player"]["classbar"]["enable"] = false
	if E.db["unitframe"]["units"]["player"]["customTexts"] then
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumHealth"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumHealth"]["attachTextTo"] = "Frame"
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumHealth"]["yOffset"] = 12
		end
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumName"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumName"]["attachTextTo"] = "Frame"
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumName"]["enable"] = false
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumName"]["xOffset"] = 0
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumName"]["yOffset"] = 12
		end
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"]["attachTextTo"] = "Frame"
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"]["yOffset"] = -13
		end
	end
	E.db["unitframe"]["units"]["player"]["height"] = 10
	E.db["unitframe"]["units"]["player"]["portrait"]["enable"] = false
	E.db["unitframe"]["units"]["player"]["infoPanel"]["enable"] = false
	E.db["unitframe"]["units"]["player"]["power"]["strataAndLevel"]["useCustomLevel"] = false
	E.db["unitframe"]["units"]["player"]["power"]["strataAndLevel"]["useCustomStrata"] = false
	E.db["unitframe"]["units"]["player"]["power"]["height"] = 7

	E.db["unitframe"]["units"]["target"]["CombatIcon"]["xOffset"] = -20
	E.db["unitframe"]["units"]["target"]["aurabar"]["yOffset"] = 20
	E.db["unitframe"]["units"]["target"]["buffs"]["spacing"] = 7
	E.db["unitframe"]["units"]["target"]["castbar"]["customTextFont"]["enable"] = true
	E.db["unitframe"]["units"]["target"]["castbar"]["customTimeFont"]["enable"] = true
	E.db["unitframe"]["units"]["target"]["castbar"]["height"] = 10
	E.db["unitframe"]["units"]["target"]["castbar"]["iconSize"] = 20
	E.db["unitframe"]["units"]["target"]["castbar"]["iconXOffset"] = 2
	E.db["unitframe"]["units"]["target"]["castbar"]["iconYOffset"] = 5
	E.db["unitframe"]["units"]["target"]["castbar"]["yOffsetText"] = 4
	E.db["unitframe"]["units"]["target"]["castbar"]["yOffsetTime"] = 4
	E.db["unitframe"]["units"]["target"]["castbar"]["iconPosition"] = "RIGHT"
	if E.db["unitframe"]["units"]["target"]["customTexts"] then
		if E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetHealth"] then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetHealth"]["attachTextTo"] = "Frame"
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetHealth"]["xOffset"] = 0
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetHealth"]["yOffset"] = 12
		end
		if E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"] then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"]["attachTextTo"] = "Frame"
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"]["size"] = 14
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"]["xOffset"] = 0
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"]["yOffset"] = 12
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"]["text_format"] = "[eltruism:raidmarker] [eltruism:ReleafIconOutline:player] [eltruism:difficulty][name:eltruism:gradientshort]"
		end
		if E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetPower"] then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetPower"]["attachTextTo"] = "Frame"
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetPower"]["xOffset"] = 0
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetPower"]["yOffset"] = -13
		end
	end
	E.db["unitframe"]["units"]["target"]["height"] = 10
	E.db["unitframe"]["units"]["target"]["portrait"]["enable"] = false
	E.db["unitframe"]["units"]["target"]["power"]["height"] = 7
	E.db["unitframe"]["units"]["target"]["infoPanel"]["enable"] = false
	E.db["unitframe"]["units"]["target"]["power"]["strataAndLevel"]["useCustomLevel"] = false
	E.db["unitframe"]["units"]["target"]["power"]["strataAndLevel"]["useCustomStrata"] = false

	if E.db["unitframe"]["units"]["targettarget"]["customTexts"] then
		 if E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetHealth"] then
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetHealth"]["justifyH"] = "CENTER"
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetHealth"]["xOffset"] = 0
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetHealth"]["yOffset"] = 10
		end
		if E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetName"] then
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetName"]["attachTextTo"] = "Frame"
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetName"]["yOffset"] = 12
		end
		if E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumPower"] then
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumPower"]["attachTextTo"] = "Frame"
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumPower"]["size"] = 10
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumPower"]["yOffset"] = -12
		end
	end
	E.db["unitframe"]["units"]["targettarget"]["height"] = 10
	E.db["unitframe"]["units"]["targettarget"]["power"]["attachTextTo"] = "Frame"
	E.db["unitframe"]["units"]["targettarget"]["power"]["height"] = 7
	E.db["unitframe"]["units"]["targettarget"]["power"]["yOffset"] = -1
	E.db["unitframe"]["units"]["targettarget"]["infoPanel"]["enable"] = false
	E.db["unitframe"]["units"]["targettarget"]["power"]["strataAndLevel"]["useCustomLevel"] = false
	E.db["unitframe"]["units"]["targettarget"]["power"]["strataAndLevel"]["useCustomStrata"] = false

	E.db["unitframe"]["units"]["pet"]["buffIndicator"]["size"] = 15
	E.db["unitframe"]["units"]["pet"]["buffs"]["anchorPoint"] = "TOP"
	E.db["unitframe"]["units"]["pet"]["buffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["pet"]["buffs"]["enable"] = true
	E.db["unitframe"]["units"]["pet"]["buffs"]["growthX"] = "LEFT"
	E.db["unitframe"]["units"]["pet"]["buffs"]["height"] = 25
	E.db["unitframe"]["units"]["pet"]["buffs"]["keepSizeRatio"] = false
	E.db["unitframe"]["units"]["pet"]["buffs"]["sizeOverride"] = 30
	E.db["unitframe"]["units"]["pet"]["buffs"]["yOffset"] = 2
	E.db["unitframe"]["units"]["pet"]["castbar"]["customColor"]["color"]["b"] = 0
	E.db["unitframe"]["units"]["pet"]["castbar"]["customColor"]["color"]["g"] = 0.50588235294118
	E.db["unitframe"]["units"]["pet"]["castbar"]["customColor"]["color"]["r"] = 0.86274509803922
	E.db["unitframe"]["units"]["pet"]["castbar"]["customColor"]["colorBackdrop"]["a"] = 0
	E.db["unitframe"]["units"]["pet"]["castbar"]["customColor"]["colorBackdrop"]["b"] = 0.50196078431373
	E.db["unitframe"]["units"]["pet"]["castbar"]["customColor"]["colorBackdrop"]["g"] = 0.50196078431373
	E.db["unitframe"]["units"]["pet"]["castbar"]["customColor"]["colorBackdrop"]["r"] = 0.50196078431373
	E.db["unitframe"]["units"]["pet"]["castbar"]["customColor"]["useClassColor"] = true
	E.db["unitframe"]["units"]["pet"]["castbar"]["customColor"]["useCustomBackdrop"] = true
	E.db["unitframe"]["units"]["pet"]["castbar"]["format"] = "REMAININGMAX"
	E.db["unitframe"]["units"]["pet"]["castbar"]["height"] = 15
	E.db["unitframe"]["units"]["pet"]["castbar"]["overlayOnFrame"] = "Health"
	E.db["unitframe"]["units"]["pet"]["castbar"]["strataAndLevel"]["frameStrata"] = "HIGH"
	E.db["unitframe"]["units"]["pet"]["castbar"]["timeToHold"] = 0.6
	E.db["unitframe"]["units"]["pet"]["castbar"]["width"] = 162
	E.db["unitframe"]["units"]["pet"]["colorOverride"] = "FORCE_OFF"
	if E.db["unitframe"]["units"]["pet"]["customTexts"] and E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"] then
		E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["attachTextTo"] = "Health"
		E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["enable"] = true
		E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["font"] = "Kimberley"
		E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["fontOutline"] = "OUTLINE"
		E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["justifyH"] = "CENTER"
		E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["size"] = 12
		E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["xOffset"] = 0
		E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["yOffset"] = 13
	end
	E.db["unitframe"]["units"]["pet"]["debuffs"]["anchorPoint"] = "TOP"
	E.db["unitframe"]["units"]["pet"]["debuffs"]["attachTo"] = "BUFFS"
	E.db["unitframe"]["units"]["pet"]["debuffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["pet"]["debuffs"]["enable"] = true
	E.db["unitframe"]["units"]["pet"]["debuffs"]["height"] = 25
	E.db["unitframe"]["units"]["pet"]["debuffs"]["keepSizeRatio"] = false
	E.db["unitframe"]["units"]["pet"]["debuffs"]["sizeOverride"] = 30
	E.db["unitframe"]["units"]["pet"]["debuffs"]["yOffset"] = 1
	E.db["unitframe"]["units"]["pet"]["disableTargetGlow"] = false
	E.db["unitframe"]["units"]["pet"]["fader"]["casting"] = true
	E.db["unitframe"]["units"]["pet"]["fader"]["combat"] = true
	E.db["unitframe"]["units"]["pet"]["fader"]["health"] = true
	E.db["unitframe"]["units"]["pet"]["fader"]["hover"] = true
	E.db["unitframe"]["units"]["pet"]["fader"]["minAlpha"] = 0
	E.db["unitframe"]["units"]["pet"]["fader"]["playertarget"] = true
	E.db["unitframe"]["units"]["pet"]["fader"]["power"] = true
	E.db["unitframe"]["units"]["pet"]["fader"]["range"] = false
	E.db["unitframe"]["units"]["pet"]["fader"]["smooth"] = 0
	E.db["unitframe"]["units"]["pet"]["fader"]["unittarget"] = true
	E.db["unitframe"]["units"]["pet"]["fader"]["vehicle"] = true
	E.db["unitframe"]["units"]["pet"]["health"]["colorHappiness"] = false
	E.db["unitframe"]["units"]["pet"]["height"] = 10
	E.db["unitframe"]["units"]["pet"]["name"]["text_format"] = ""
	E.db["unitframe"]["units"]["pet"]["power"]["height"] = 7
	E.db["unitframe"]["units"]["pet"]["power"]["width"] = "spaced"
	E.db["unitframe"]["units"]["pet"]["smartAuraPosition"] = "FLUID_DEBUFFS_ON_BUFFS"
	E.db["unitframe"]["units"]["pet"]["width"] = 162

	E.db["unitframe"]["units"]["boss"]["buffIndicator"]["size"] = 15
	E.db["unitframe"]["units"]["boss"]["buffs"]["anchorPoint"] = "TOPRIGHT"
	E.db["unitframe"]["units"]["boss"]["buffs"]["attachTo"] = "DEBUFFS"
	E.db["unitframe"]["units"]["boss"]["buffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["boss"]["buffs"]["countXOffset"] = 2
	E.db["unitframe"]["units"]["boss"]["buffs"]["countYOffset"] = -3
	E.db["unitframe"]["units"]["boss"]["buffs"]["durationPosition"] = "TOP"
	E.db["unitframe"]["units"]["boss"]["buffs"]["growthX"] = "LEFT"
	E.db["unitframe"]["units"]["boss"]["buffs"]["height"] = 15
	E.db["unitframe"]["units"]["boss"]["buffs"]["keepSizeRatio"] = false
	E.db["unitframe"]["units"]["boss"]["buffs"]["perrow"] = 7
	E.db["unitframe"]["units"]["boss"]["buffs"]["sizeOverride"] = 25
	E.db["unitframe"]["units"]["boss"]["buffs"]["spacing"] = 2
	E.db["unitframe"]["units"]["boss"]["buffs"]["xOffset"] = 0
	E.db["unitframe"]["units"]["boss"]["buffs"]["yOffset"] = 5
	E.db["unitframe"]["units"]["boss"]["castbar"]["overlayOnFrame"] = "Health"
	E.db["unitframe"]["units"]["boss"]["debuffs"]["countXOffset"] = 2
	E.db["unitframe"]["units"]["boss"]["debuffs"]["countYOffset"] = -3
	E.db["unitframe"]["units"]["boss"]["debuffs"]["durationPosition"] = "TOP"
	E.db["unitframe"]["units"]["boss"]["debuffs"]["growthX"] = "LEFT"
	E.db["unitframe"]["units"]["boss"]["debuffs"]["height"] = 15
	E.db["unitframe"]["units"]["boss"]["debuffs"]["keepSizeRatio"] = false
	E.db["unitframe"]["units"]["boss"]["debuffs"]["perrow"] = 7
	E.db["unitframe"]["units"]["boss"]["debuffs"]["sizeOverride"] = 25
	E.db["unitframe"]["units"]["boss"]["debuffs"]["spacing"] = 2
	E.db["unitframe"]["units"]["boss"]["debuffs"]["xOffset"] = -3
	E.db["unitframe"]["units"]["boss"]["debuffs"]["yOffset"] = -16
	E.db["unitframe"]["units"]["boss"]["health"]["attachTextTo"] = "InfoPanel"
	E.db["unitframe"]["units"]["boss"]["health"]["position"] = "RIGHT"
	E.db["unitframe"]["units"]["boss"]["health"]["text_format"] = "[healthcolor][eltruism:hpstatusnopc:gradient]"
	E.db["unitframe"]["units"]["boss"]["health"]["xOffset"] = 0
	E.db["unitframe"]["units"]["boss"]["health"]["yOffset"] = 12
	E.db["unitframe"]["units"]["boss"]["height"] = 15
	E.db["unitframe"]["units"]["boss"]["infoPanel"]["enable"] = false
	E.db["unitframe"]["units"]["boss"]["infoPanel"]["height"] = 12
	E.db["unitframe"]["units"]["boss"]["name"]["attachTextTo"] = "Frame"
	E.db["unitframe"]["units"]["boss"]["name"]["position"] = "LEFT"
	E.db["unitframe"]["units"]["boss"]["name"]["text_format"] = "[name:eltruism:gradient]"
	E.db["unitframe"]["units"]["boss"]["name"]["yOffset"] = 12
	E.db["unitframe"]["units"]["boss"]["portrait"]["fullOverlay"] = true
	E.db["unitframe"]["units"]["boss"]["portrait"]["overlay"] = true
	E.db["unitframe"]["units"]["boss"]["portrait"]["overlayAlpha"] = 0.2
	E.db["unitframe"]["units"]["boss"]["portrait"]["enable"] = false
	E.db["unitframe"]["units"]["boss"]["power"]["attachTextTo"] = "Power"
	E.db["unitframe"]["units"]["boss"]["power"]["height"] = 7
	E.db["unitframe"]["units"]["boss"]["power"]["width"] = "spaced"
	E.db["unitframe"]["units"]["boss"]["power"]["xOffset"] = 0
	E.db["unitframe"]["units"]["boss"]["power"]["yOffset"] = 1
	E.db["unitframe"]["units"]["boss"]["smartAuraPosition"] = "FLUID_BUFFS_ON_DEBUFFS"
	E.db["unitframe"]["units"]["boss"]["spacing"] = 30

	ElvUI_EltreumUI:SetupFont(E.db.general.font)

	--fix borders
	E.db["ElvUI_EltreumUI"]["borders"]["bar1yborder"] = 40
	E.db["ElvUI_EltreumUI"]["borders"]["bar2xborder"] = 55
	E.db["ElvUI_EltreumUI"]["borders"]["bar2yborder"] = 35
	E.db["ElvUI_EltreumUI"]["borders"]["bar3xborder"] = 55
	E.db["ElvUI_EltreumUI"]["borders"]["bar3yborder"] = 35
	E.db["ElvUI_EltreumUI"]["borders"]["bar4xborder"] = 55
	E.db["ElvUI_EltreumUI"]["borders"]["bar4yborder"] = 35
	E.db["ElvUI_EltreumUI"]["borders"]["bosslevel"] = 5
	E.db["ElvUI_EltreumUI"]["borders"]["bossstrata"] = "LOW"
	E.db["ElvUI_EltreumUI"]["borders"]["experiencebarlevel"] = 2
	E.db["ElvUI_EltreumUI"]["borders"]["experiencebarsizey"] = 30
	E.db["ElvUI_EltreumUI"]["borders"]["experiencebarstrata"] = "LOW"
	E.db["ElvUI_EltreumUI"]["borders"]["focuscastlevel"] = 136
	E.db["ElvUI_EltreumUI"]["borders"]["focuscaststrata"] = "LOW"
	E.db["ElvUI_EltreumUI"]["borders"]["focuspowerborder"] = false
	E.db["ElvUI_EltreumUI"]["borders"]["minimapsizey"] = 225
	E.db["ElvUI_EltreumUI"]["borders"]["partylevel"] = 7
	E.db["ElvUI_EltreumUI"]["borders"]["partysizey"] = 70
	E.db["ElvUI_EltreumUI"]["borders"]["playercastlevel"] = 136
	E.db["ElvUI_EltreumUI"]["borders"]["playercaststrata"] = "LOW"
	E.db["ElvUI_EltreumUI"]["borders"]["playerpower"] = false
	E.db["ElvUI_EltreumUI"]["borders"]["playerpowersizey"] = 39
	E.db["ElvUI_EltreumUI"]["borders"]["reputationbarlevel"] = 2
	E.db["ElvUI_EltreumUI"]["borders"]["reputationbarsizey"] = 30
	E.db["ElvUI_EltreumUI"]["borders"]["reputationbarstrata"] = "LOW"
	E.db["ElvUI_EltreumUI"]["borders"]["stancestrata"] = "MEDIUM"
	E.db["ElvUI_EltreumUI"]["borders"]["stanceyborder"] = 38
	E.db["ElvUI_EltreumUI"]["borders"]["targetcastlevel"] = 136
	E.db["ElvUI_EltreumUI"]["borders"]["targetcaststrata"] = "LOW"
	E.db["ElvUI_EltreumUI"]["borders"]["targetpower"] = false
	E.db["ElvUI_EltreumUI"]["borders"]["targettargetpower"] = false
	E.db["ElvUI_EltreumUI"]["borders"]["threatbarlevel"] = 2
	E.db["ElvUI_EltreumUI"]["borders"]["threatbarsizey"] = 30
	E.db["ElvUI_EltreumUI"]["borders"]["threatbarstrata"] = "LOW"
	E.db["ElvUI_EltreumUI"]["borders"]["xboss"] = 249
	E.db["ElvUI_EltreumUI"]["borders"]["xcastfocus"] = 334
	E.db["ElvUI_EltreumUI"]["borders"]["xcasttarget"] = 251
	E.db["ElvUI_EltreumUI"]["borders"]["xplayercast"] = 251
	E.db["ElvUI_EltreumUI"]["borders"]["yboss"] = 45
	E.db["ElvUI_EltreumUI"]["borders"]["ycastfocus"] = 40
	E.db["ElvUI_EltreumUI"]["borders"]["ycasttarget"] = 40
	E.db["ElvUI_EltreumUI"]["borders"]["yfocus"] = 40
	E.db["ElvUI_EltreumUI"]["borders"]["yfocuspower"] = 37
	E.db["ElvUI_EltreumUI"]["borders"]["yplayer"] = 39
	E.db["ElvUI_EltreumUI"]["borders"]["yplayercast"] = 40
	E.db["ElvUI_EltreumUI"]["borders"]["ytarget"] = 39
	E.db["ElvUI_EltreumUI"]["borders"]["ytargettarget"] = 39

	E:UpdateLayout()
	E:UpdateUnitFrames()
	E:UpdateActionBars()
	E:UpdateMoverPositions()
	E:StaticPopup_Show('CONFIG_RL')

	ElvUI_EltreumUI:Print("Thin Layout applied")
end
