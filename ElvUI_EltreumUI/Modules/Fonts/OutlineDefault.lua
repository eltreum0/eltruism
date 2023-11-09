local E = unpack(ElvUI)
local _G = _G
local IsAddOnLoaded = _G.IsAddOnLoaded --TODO 10.2, might need C_AddOns.

function ElvUI_EltreumUI:SetupFontsOutlineDefault()
	if IsAddOnLoaded("ElvUI_SLE") then --TODO 10.2, might need C_AddOns.
		E.db["sle"]["armory"]["stats"]["statLabels"]["outline"] = "THICKOUTLINE"
		E.db["sle"]["armory"]["stats"]["itemLevel"]["outline"] = "THICKOUTLINE"
		E.db["sle"]["armory"]["stats"]["statHeaders"]["outline"] = "THICKOUTLINE"
		E.db["sle"]["media"]["fonts"]["mail"]["outline"] = "THICKOUTLINE"
		E.db["sle"]["media"]["fonts"]["objective"]["outline"] = "THICKOUTLINE"
		E.db["sle"]["media"]["fonts"]["objectiveHeader"]["outline"] = "THICKOUTLINE"
		E.db["sle"]["media"]["fonts"]["pvp"]["outline"] = "THICKOUTLINE"
		E.db["sle"]["media"]["fonts"]["questFontSuperHuge"]["outline"] = "THICKOUTLINE"
		E.db["sle"]["media"]["fonts"]["subzone"]["outline"] = "THICKOUTLINE"
		E.db["sle"]["media"]["fonts"]["zone"]["outline"] = "THICKOUTLINE"
		E.db["sle"]["minimap"]["coords"]["fontOutline"] = "THICKOUTLINE"
		E.db["sle"]["minimap"]["instance"]["fontOutline"] = "THICKOUTLINE"
		E.db["sle"]["minimap"]["locPanel"]["fontOutline"] = "THICKOUTLINE"
		E.db["sle"]["nameplates"]["targetcount"]["fontOutline"] = "THICKOUTLINE"
		E.db["sle"]["skins"]["merchant"]["list"]["subOutline"] = "THICKOUTLINE"
	end
	if IsAddOnLoaded("ElvUI_WindTools") then --TODO 10.2, might need C_AddOns.
		E.private["WT"]["quest"]["objectiveTracker"]["header"]["style"] = "OUTLINE"
		E.private["WT"]["quest"]["objectiveTracker"]["info"]["style"] = "OUTLINE"
		E.private["WT"]["quest"]["objectiveTracker"]["title"]["style"] = "OUTLINE"
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["bindFont"]["style"] = "OUTLINE"
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["countFont"]["style"] = "OUTLINE"
		E.db["WT"]["misc"]["gameBar"]["additionalText"]["font"]["style"] = "OUTLINE"
		E.db["WT"]["misc"]["gameBar"]["time"]["font"]["style"] = "OUTLINE"
	end
	E.db["general"]["altPowerBar"]["fontOutline"] = "THICKOUTLINE"
	E.db["databars"]["azerite"]["fontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["extraActionButton"]["hotkeyFontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["player"]["castbar"]["customTimeFont"]["fontStyle"] = "THICKOUTLINE"
	if IsAddOnLoaded('ProjectAzilroka') then --TODO 10.2, might need C_AddOns.
		_G.ProjectAzilroka.db["stAddonManager"]["FontFlag"] = "THICKOUTLINE"
	end
	E.db["general"]["fontStyle"] = "OUTLINE"
	E.db["general"]["minimap"]["locationFontOutline"] = "THICKOUTLINE"
	if E.Retail then
		E.db["general"]["queueStatus"]["fontOutline"] = "OUTLINE"
	end
	if E.Wrath then
		E.db["general"]["totems"]["fontOutline"] = "OUTLINE"
	end
	E.db["general"]["addonCompartment"]["fontOutline"] = "OUTLINE"
	E.db["bags"]["countFontOutline"] = "OUTLINE"
	E.db["bags"]["itemInfoFontOutline"] = "OUTLINE"
	E.db["bags"]["itemLevelFontOutline"] = "OUTLINE"
	E.db["chat"]["fontOutline"] = "OUTLINE"
	E.db["chat"]["tabFontOutline"] = "OUTLINE"
	E.db["cooldown"]["fonts"]["fontOutline"] = "THICKOUTLINE"
	E.db["databars"]["experience"]["fontOutline"] = "THICKOUTLINE"
	E.db["databars"]["reputation"]["fontOutline"] = "THICKOUTLINE"
	E.db["databars"]["threat"]["fontOutline"] = "THICKOUTLINE"
	E.db["datatexts"]["fontOutline"] = "THICKOUTLINE"
	E.db["tooltip"]["healthBar"]["fontOutline"] = "OUTLINE"
	E.db["tooltip"]["headerFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar1"]["countFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar1"]["hotkeyFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar1"]["macroFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar10"]["countFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar10"]["hotkeyFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar10"]["macroFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar2"]["countFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar2"]["hotkeyFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar2"]["macroFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar3"]["countFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar3"]["hotkeyFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar3"]["macroFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar4"]["countFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar4"]["hotkeyFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar4"]["macroFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar5"]["countFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar5"]["hotkeyFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar5"]["macroFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar6"]["countFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar6"]["hotkeyFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar6"]["macroFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar7"]["countFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar7"]["hotkeyFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar7"]["macroFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar8"]["countFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar8"]["hotkeyFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar8"]["macroFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar9"]["countFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar9"]["hotkeyFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar9"]["macroFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["barPet"]["countFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["barPet"]["hotkeyFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["fontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["stanceBar"]["hotkeyFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["vehicleExitButton"]["hotkeyFontOutline"] = "THICKOUTLINE"
	E.db["auras"]["buffs"]["countFontOutline"] = "THICKOUTLINE"
	E.db["auras"]["buffs"]["timeFontOutline"] = "THICKOUTLINE"
	E.db["auras"]["debuffs"]["countFontOutline"] = "THICKOUTLINE"
	E.db["auras"]["debuffs"]["timeFontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["assist"]["rdebuffs"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["party"]["buffs"]["countFontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["party"]["debuffs"]["countFontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["raid1"]["rdebuffs"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["raid2"]["rdebuffs"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["raid3"]["rdebuffs"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["tank"]["rdebuffs"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["pet"]["buffs"]["countFontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["pet"]["debuffs"]["countFontOutline"] = "OUTLINE"
	E.db["nameplates"]["cooldown"]["fonts"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["health"]["text"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["name"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["name"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["title"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["power"]["text"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["health"]["text"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["name"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["power"]["text"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["buffs"]["countFontOutline"] = "NONE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["castbar"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["debuffs"]["countFontOutline"] = "NONE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["health"]["text"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["level"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["name"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["title"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["power"]["text"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["PLAYER"]["buffs"]["countFontOutline"] = "NONE"
	E.db["nameplates"]["units"]["PLAYER"]["castbar"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["countFontOutline"] = "NONE"
	E.db["nameplates"]["units"]["PLAYER"]["health"]["text"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["level"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["PLAYER"]["name"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["power"]["text"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["title"]["fontOutline"] = "NONE"

	E.private["general"]["nameplateFontOutline"] = "OUTLINE"
	E.private["general"]["nameplateLargeFontOutline"] = "OUTLINE"
	E.db["general"]["fonts"]["cooldown"]["outline"] = "THICKOUTLINE"
	E.db["general"]["fonts"]["errortext"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["mailbody"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["objective"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["pvpsubzone"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["pvpzone"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["questsmall"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["questtext"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["talkingtext"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["talkingtitle"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["worldsubzone"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["worldzone"]["outline"] = "OUTLINE"

	-- Custom Texts
	if E.db["unitframe"]["units"]["player"]["customTexts"] then
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumHealth"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumHealth"]["fontOutline"] = "THICKOUTLINE"
		end
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumName"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumName"]["fontOutline"] = "THICKOUTLINE"
		end
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"]["fontOutline"] = "THICKOUTLINE"
		end
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPvP"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPvP"]["fontOutline"] = "THICKOUTLINE"
		end
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPlayerAbsorb"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPlayerAbsorb"]["fontOutline"] = "THICKOUTLINE"
		end
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumStatus"]["fontOutline"] = "THICKOUTLINE"
		end
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumStance"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumStance"]["fontOutline"] = "OUTLINE"
		end
	end
	if E.db["unitframe"]["units"]["target"]["customTexts"] then
		if E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetHealth"] then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetHealth"]["fontOutline"] = "THICKOUTLINE"
		end
		if E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"] then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"]["fontOutline"] = "THICKOUTLINE"
		end
		if E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetPower"] then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetPower"]["fontOutline"] = "THICKOUTLINE"
		end
		if E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetofTarget"] then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetofTarget"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetAbsorb"] then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetAbsorb"]["fontOutline"] = "THICKOUTLINE"
		end
		if E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumStatus"]["fontOutline"] = "THICKOUTLINE"
		end
	end
	if E.db["unitframe"]["units"]["targettarget"]["customTexts"] then
		if E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetHealth"] then
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetHealth"]["fontOutline"] = "THICKOUTLINE"
		end
		if E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetName"] then
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetName"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumPower"] then
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumPower"]["fontOutline"] = "THICKOUTLINE"
		end
		if E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumStatus"]["fontOutline"] = "THICKOUTLINE"
		end
	end
	if E.db["unitframe"]["units"]["pet"]["customTexts"] then
		if E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"] then
			E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["fontOutline"] = "THICKOUTLINE"
		end
	end
	if E.db["unitframe"]["units"]["party"]["customTexts"] then
		if E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyAbsorb"] then
			E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyAbsorb"]["fontOutline"] = "THICKOUTLINE"
		end
		if E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyHealth"] then
			E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyHealth"]["fontOutline"] = "THICKOUTLINE"
		end
		if E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyName"] then
			E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyName"]["fontOutline"] = "THICKOUTLINE"
		end
		if E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyPower"] then
			E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyPower"]["fontOutline"] = "THICKOUTLINE"
		end
		if E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumStatus"]["fontOutline"] = "THICKOUTLINE"
		end
	end
	if E.db["unitframe"]["units"]["arena"]["customTexts"] then
		if E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaHealth"] then
			E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaHealth"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaName"] then
			E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaName"]["fontOutline"] = "THICKOUTLINE"
		end
		if E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaPower"] then
			E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaPower"]["fontOutline"] = "THICKOUTLINE"
		end
		if E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumStatus"]["fontOutline"] = "THICKOUTLINE"
		end
	end
	if E.db["unitframe"]["units"]["raid1"]["customTexts"] then
		if E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Health"] then
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Health"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Name"] then
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Name"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Absorb"] then
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Absorb"]["fontOutline"] = "THICKOUTLINE"
		end
		if E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumGroup"] then
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumGroup"]["fontOutline"] = "THICKOUTLINE"
		end
		if E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumStatus"]["fontOutline"] = "THICKOUTLINE"
		end
	end
	if E.db["unitframe"]["units"]["raid2"]["customTexts"] then
		if E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumGroup"] then
			E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumGroup"]["fontOutline"] = "THICKOUTLINE"
		end
		if E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Health"] then
			E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Health"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Name"] then
			E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Name"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Absorb"] then
			E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Absorb"]["fontOutline"] = "THICKOUTLINE"
		end
		if E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumStatus"]["fontOutline"] = "THICKOUTLINE"
		end
	end
	if E.db["unitframe"]["units"]["raid3"]["customTexts"] then
		if E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Absorb"] then
			E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Absorb"]["fontOutline"] = "THICKOUTLINE"
		end
		if E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumGroup"] then
			E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumGroup"]["fontOutline"] = "THICKOUTLINE"
		end
		if E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Health"] then
			E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Health"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Name"] then
			E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Name"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumStatus"]["fontOutline"] = "THICKOUTLINE"
		end
	end

	if E.db["datatexts"]["panels"]["EltruismTime"] and E.db["datatexts"]["panels"]["EltruismTime"]["enable"] then
		E.global["datatexts"]["customPanels"]["EltruismTime"]["fonts"]["fontOutline"] = "THICKOUTLINE"
	end
end
