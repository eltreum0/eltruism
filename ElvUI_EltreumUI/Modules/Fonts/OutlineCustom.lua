local E, L, V, P, G = unpack(ElvUI)
local _G = _G
local IsAddOnLoaded = _G.IsAddOnLoaded

function ElvUI_EltreumUI:SetupFontsOutlineCustom(fontStyle)

	if E.Retail and fontStyle == "NONE" then
		fontStyle = ""
	end

	if IsAddOnLoaded('ProjectAzilroka') then
		_G.ProjectAzilroka.db["stAddonManager"]["FontFlag"] = fontStyle
	end
	if IsAddOnLoaded("ElvUI_SLE") then
		E.db["sle"]["armory"]["stats"]["statLabels"]["outline"] = fontStyle
		E.db["sle"]["armory"]["stats"]["itemLevel"]["outline"] = fontStyle
		E.db["sle"]["armory"]["stats"]["statHeaders"]["outline"] = fontStyle
		E.db["sle"]["media"]["fonts"]["mail"]["outline"] = fontStyle
		E.db["sle"]["media"]["fonts"]["objective"]["outline"] = fontStyle
		E.db["sle"]["media"]["fonts"]["objectiveHeader"]["outline"] = fontStyle
		E.db["sle"]["media"]["fonts"]["pvp"]["outline"] = fontStyle
		E.db["sle"]["media"]["fonts"]["questFontSuperHuge"]["outline"] = fontStyle
		E.db["sle"]["media"]["fonts"]["subzone"]["outline"] = fontStyle
		E.db["sle"]["media"]["fonts"]["zone"]["outline"] = fontStyle
		E.db["sle"]["minimap"]["coords"]["fontOutline"] = fontStyle
		E.db["sle"]["minimap"]["instance"]["fontOutline"] = fontStyle
		E.db["sle"]["minimap"]["locPanel"]["fontOutline"] = fontStyle
		E.db["sle"]["nameplates"]["targetcount"]["fontOutline"] = fontStyle
		E.db["sle"]["skins"]["merchant"]["list"]["subOutline"] = fontStyle
	end
	if IsAddOnLoaded("ElvUI_WindTools") then
		E.private["WT"]["quest"]["objectiveTracker"]["header"]["style"] = fontStyle
		E.private["WT"]["quest"]["objectiveTracker"]["info"]["style"] = fontStyle
		E.private["WT"]["quest"]["objectiveTracker"]["title"]["style"] = fontStyle
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["bindFont"]["style"] = fontStyle
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["countFont"]["style"] = fontStyle
		E.db["WT"]["misc"]["gameBar"]["additionalText"]["font"]["style"] = fontStyle
		E.db["WT"]["misc"]["gameBar"]["time"]["font"]["style"] = fontStyle
	end
	E.db["general"]["altPowerBar"]["fontOutline"] = fontStyle
	E.db["databars"]["azerite"]["fontOutline"] = fontStyle
	E.db["actionbar"]["extraActionButton"]["hotkeyFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["player"]["castbar"]["customTimeFont"]["fontStyle"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["fontOutline"] = fontStyle
	E.db["general"]["fontStyle"] = fontStyle
	E.db["general"]["minimap"]["locationFontOutline"] = fontStyle
	if E.Retail then
		E.db["general"]["minimap"]["icons"]["queueStatus"]["fontOutline"] = fontStyle
	end
	if E.Wrath then
		E.db["general"]["totems"]["fontOutline"] = fontStyle
	end
	E.db["bags"]["countFontOutline"] = fontStyle
	E.db["bags"]["itemInfoFontOutline"] = fontStyle
	E.db["bags"]["itemLevelFontOutline"] = fontStyle
	E.db["chat"]["fontOutline"] = fontStyle
	E.db["chat"]["tabFontOutline"] = fontStyle
	E.db["cooldown"]["fonts"]["fontOutline"] = fontStyle
	E.db["databars"]["experience"]["fontOutline"] = fontStyle
	E.db["databars"]["reputation"]["fontOutline"] = fontStyle
	E.db["databars"]["threat"]["fontOutline"] = fontStyle
	E.db["datatexts"]["fontOutline"] = fontStyle
	E.db["tooltip"]["healthBar"]["fontOutline"] = fontStyle
	E.db["tooltip"]["headerFontOutline"] = fontStyle
	E.db["actionbar"]["bar1"]["countFontOutline"] = fontStyle
	E.db["actionbar"]["bar1"]["hotkeyFontOutline"] = fontStyle
	E.db["actionbar"]["bar1"]["macroFontOutline"] = fontStyle
	E.db["actionbar"]["bar10"]["countFontOutline"] = fontStyle
	E.db["actionbar"]["bar10"]["hotkeyFontOutline"] = fontStyle
	E.db["actionbar"]["bar10"]["macroFontOutline"] = fontStyle
	E.db["actionbar"]["bar2"]["countFontOutline"] = fontStyle
	E.db["actionbar"]["bar2"]["hotkeyFontOutline"] = fontStyle
	E.db["actionbar"]["bar2"]["macroFontOutline"] = fontStyle
	E.db["actionbar"]["bar3"]["countFontOutline"] = fontStyle
	E.db["actionbar"]["bar3"]["hotkeyFontOutline"] = fontStyle
	E.db["actionbar"]["bar3"]["macroFontOutline"] = fontStyle
	E.db["actionbar"]["bar4"]["countFontOutline"] = fontStyle
	E.db["actionbar"]["bar4"]["hotkeyFontOutline"] = fontStyle
	E.db["actionbar"]["bar4"]["macroFontOutline"] = fontStyle
	E.db["actionbar"]["bar5"]["countFontOutline"] = fontStyle
	E.db["actionbar"]["bar5"]["hotkeyFontOutline"] = fontStyle
	E.db["actionbar"]["bar5"]["macroFontOutline"] = fontStyle
	E.db["actionbar"]["bar6"]["countFontOutline"] = fontStyle
	E.db["actionbar"]["bar6"]["hotkeyFontOutline"] = fontStyle
	E.db["actionbar"]["bar6"]["macroFontOutline"] = fontStyle
	E.db["actionbar"]["bar7"]["countFontOutline"] = fontStyle
	E.db["actionbar"]["bar7"]["hotkeyFontOutline"] = fontStyle
	E.db["actionbar"]["bar7"]["macroFontOutline"] = fontStyle
	E.db["actionbar"]["bar8"]["countFontOutline"] = fontStyle
	E.db["actionbar"]["bar8"]["hotkeyFontOutline"] = fontStyle
	E.db["actionbar"]["bar8"]["macroFontOutline"] = fontStyle
	E.db["actionbar"]["bar9"]["countFontOutline"] = fontStyle
	E.db["actionbar"]["bar9"]["hotkeyFontOutline"] = fontStyle
	E.db["actionbar"]["bar9"]["macroFontOutline"] = fontStyle
	E.db["actionbar"]["barPet"]["countFontOutline"] = fontStyle
	E.db["actionbar"]["barPet"]["hotkeyFontOutline"] = fontStyle
	E.db["actionbar"]["fontOutline"] = fontStyle
	E.db["actionbar"]["stanceBar"]["hotkeyFontOutline"] = fontStyle
	E.db["actionbar"]["vehicleExitButton"]["hotkeyFontOutline"] = fontStyle
	E.db["auras"]["buffs"]["countFontOutline"] = fontStyle
	E.db["auras"]["buffs"]["timeFontOutline"] = fontStyle
	E.db["auras"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["auras"]["debuffs"]["timeFontOutline"] = fontStyle
	E.db["unitframe"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["assist"]["rdebuffs"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["party"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["party"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid1"]["rdebuffs"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid2"]["rdebuffs"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid3"]["rdebuffs"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["tank"]["rdebuffs"]["fontOutline"] = fontStyle
	E.db["nameplates"]["cooldown"]["fonts"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_NPC"]["health"]["text"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_NPC"]["name"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["name"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["title"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_NPC"]["power"]["text"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["health"]["text"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["name"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["power"]["text"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["buffs"]["countFontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["castbar"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["health"]["text"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["level"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["name"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["title"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["power"]["text"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["PLAYER"]["buffs"]["countFontOutline"] = fontStyle
	E.db["nameplates"]["units"]["PLAYER"]["castbar"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["nameplates"]["units"]["PLAYER"]["health"]["text"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["PLAYER"]["level"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["PLAYER"]["name"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["PLAYER"]["power"]["text"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["PLAYER"]["title"]["fontOutline"] = fontStyle

		-- Custom Texts
	if E.db["unitframe"]["units"]["player"]["customTexts"] then
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumHealth"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumHealth"]["fontOutline"] = fontStyle
		end
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumName"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumName"]["fontOutline"] = fontStyle
		end
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"]["fontOutline"] = fontStyle
		end
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPvP"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPvP"]["fontOutline"] = fontStyle
		end
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPlayerAbsorb"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPlayerAbsorb"]["fontOutline"] = fontStyle
		end
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumStatus"]["fontOutline"] = fontStyle
		end
	end
	if E.db["unitframe"]["units"]["target"]["customTexts"] then
		if E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetHealth"] then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetHealth"]["fontOutline"] = fontStyle
		end
		if E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"] then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"]["fontOutline"] = fontStyle
		end
		if E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetPower"] then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetPower"]["fontOutline"] = fontStyle
		end
		if E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetofTarget"] then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetofTarget"]["fontOutline"] = fontStyle
		end
		if E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetAbsorb"] then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetAbsorb"]["fontOutline"] = fontStyle
		end
		if E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumStatus"]["fontOutline"] = fontStyle
		end
	end
	if E.db["unitframe"]["units"]["targettarget"]["customTexts"] then
		if E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetHealth"] then
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetHealth"]["fontOutline"] = fontStyle
		end
		if E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetName"] then
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetName"]["fontOutline"] = fontStyle
		end
		if E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumPower"] then
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumPower"]["fontOutline"] = fontStyle
		end
		if E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumStatus"]["fontOutline"] = fontStyle
		end
	end
	if E.db["unitframe"]["units"]["pet"]["customTexts"] then
		if E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"] then
			E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["fontOutline"] = fontStyle
		end
	end
	if E.db["unitframe"]["units"]["party"]["customTexts"] then
		if E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyAbsorb"] then
			E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyAbsorb"]["fontOutline"] = fontStyle
		end
		if E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyHealth"] then
			E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyHealth"]["fontOutline"] = fontStyle
		end
		if E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyName"] then
			E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyName"]["fontOutline"] = fontStyle
		end
		if E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyPower"] then
			E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyPower"]["fontOutline"] = fontStyle
		end
		if E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumStatus"]["fontOutline"] = fontStyle
		end
	end
	if E.db["unitframe"]["units"]["arena"]["customTexts"] then
		if E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaHealth"] then
			E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaHealth"]["fontOutline"] = fontStyle
		end
		if E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaName"] then
			E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaName"]["fontOutline"] = fontStyle
		end
		if E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaPower"] then
			E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaPower"]["fontOutline"] = fontStyle
		end
		if E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumStatus"]["fontOutline"] = fontStyle
		end
	end
	if E.db["unitframe"]["units"]["raid1"]["customTexts"] then
		if E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Health"] then
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Health"]["fontOutline"] = fontStyle
		end
		if E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Name"] then
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Name"]["fontOutline"] = fontStyle
		end
		if E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Absorb"] then
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Absorb"]["fontOutline"] = fontStyle
		end
		if E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumGroup"] then
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumGroup"]["fontOutline"] = fontStyle
		end
		if E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumStatus"]["fontOutline"] = fontStyle
		end
	end
	if E.db["unitframe"]["units"]["raid2"]["customTexts"] then
		if E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumGroup"] then
			E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumGroup"]["fontOutline"] = fontStyle
		end
		if E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Health"] then
			E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Health"]["fontOutline"] = fontStyle
		end
		if E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Name"] then
			E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Name"]["fontOutline"] = fontStyle
		end
		if E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Absorb"] then
			E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Absorb"]["fontOutline"] = fontStyle
		end
		if E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumStatus"]["fontOutline"] = fontStyle
		end
	end
	if E.db["unitframe"]["units"]["raid3"]["customTexts"] then
		if E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Absorb"] then
			E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Absorb"]["fontOutline"] = fontStyle
		end
		if E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumGroup"] then
			E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumGroup"]["fontOutline"] = fontStyle
		end
		if E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Health"] then
			E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Health"]["fontOutline"] = fontStyle
		end
		if E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Name"] then
			E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Name"]["fontOutline"] = fontStyle
		end
		if E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumStatus"]["fontOutline"] = fontStyle
		end
	end

	if E.db["datatexts"]["panels"]["EltruismTime"] and E.db["datatexts"]["panels"]["EltruismTime"]["enable"] then
		E.global["datatexts"]["customPanels"]["EltruismTime"]["fonts"]["fontOutline"] = fontStyle
	end
end
