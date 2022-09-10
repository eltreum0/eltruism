local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local IsAddOnLoaded = _G.IsAddOnLoaded

function ElvUI_EltreumUI:SetupFontsOutlineOutline()
	if IsAddOnLoaded('ProjectAzilroka') then
		_G.ProjectAzilroka.db["stAddonManager"]["FontFlag"] = "OUTLINE"
	end
	if IsAddOnLoaded("ElvUI_SLE") then
		E.db["sle"]["armory"]["stats"]["catFonts"]["outline"] = "OUTLINE"
		E.db["sle"]["armory"]["stats"]["itemLevel"]["outline"] = "OUTLINE"
		E.db["sle"]["armory"]["stats"]["statFonts"]["outline"] = "OUTLINE"
		E.db["sle"]["media"]["fonts"]["mail"]["outline"] = "OUTLINE"
		E.db["sle"]["media"]["fonts"]["objective"]["outline"] = "OUTLINE"
		E.db["sle"]["media"]["fonts"]["objectiveHeader"]["outline"] = "OUTLINE"
		E.db["sle"]["media"]["fonts"]["pvp"]["outline"] = "OUTLINE"
		E.db["sle"]["media"]["fonts"]["questFontSuperHuge"]["outline"] = "OUTLINE"
		E.db["sle"]["media"]["fonts"]["subzone"]["outline"] = "OUTLINE"
		E.db["sle"]["media"]["fonts"]["zone"]["outline"] = "OUTLINE"
		E.db["sle"]["minimap"]["coords"]["fontOutline"] = "OUTLINE"
		E.db["sle"]["minimap"]["instance"]["fontOutline"] = "OUTLINE"
		E.db["sle"]["minimap"]["locPanel"]["fontOutline"] = "OUTLINE"
		E.db["sle"]["nameplates"]["targetcount"]["fontOutline"] = "OUTLINE"
		E.db["sle"]["skins"]["merchant"]["list"]["subOutline"] = "OUTLINE"
	end
	if IsAddOnLoaded("ElvUI_WindTools") then
		E.private["WT"]["quest"]["objectiveTracker"]["header"]["style"] = "OUTLINE"
		E.private["WT"]["quest"]["objectiveTracker"]["info"]["style"] = "OUTLINE"
		E.private["WT"]["quest"]["objectiveTracker"]["title"]["style"] = "OUTLINE"
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["bindFont"]["style"] = "OUTLINE"
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["countFont"]["style"] = "OUTLINE"
		E.db["WT"]["misc"]["gameBar"]["additionalText"]["font"]["style"] = "OUTLINE"
		E.db["WT"]["misc"]["gameBar"]["time"]["font"]["style"] = "OUTLINE"
	end

	E.db["actionbar"]["extraActionButton"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["player"]["castbar"]["customTimeFont"]["fontStyle"] = "OUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["fontOutline"] = "OUTLINE"
	E.db["databars"]["azerite"]["fontOutline"] = "OUTLINE"
	E.db["general"]["altPowerBar"]["fontOutline"] = "OUTLINE"
	E.db["general"]["fontStyle"] = "OUTLINE"
	E.db["general"]["minimap"]["locationFontOutline"] = "OUTLINE"
	if E.Retail then
		E.db["general"]["minimap"]["icons"]["queueStatus"]["fontOutline"] = "OUTLINE"
	end
	if E.Wrath then
		E.db["general"]["totems"]["fontOutline"] = "OUTLINE"
	end
	E.db["bags"]["countFontOutline"] = "OUTLINE"
	E.db["bags"]["itemInfoFontOutline"] = "OUTLINE"
	E.db["bags"]["itemLevelFontOutline"] = "OUTLINE"
	E.db["chat"]["fontOutline"] = "OUTLINE"
	E.db["chat"]["tabFontOutline"] = "OUTLINE"
	E.db["cooldown"]["fonts"]["fontOutline"] = "OUTLINE"
	E.db["databars"]["experience"]["fontOutline"] = "OUTLINE"
	E.db["databars"]["reputation"]["fontOutline"] = "OUTLINE"
	E.db["databars"]["threat"]["fontOutline"] = "OUTLINE"
	E.db["datatexts"]["fontOutline"] = "OUTLINE"
	E.db["tooltip"]["healthBar"]["fontOutline"] = "OUTLINE"
	E.db["tooltip"]["headerFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar1"]["countFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar1"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar1"]["macroFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar10"]["countFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar10"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar10"]["macroFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar2"]["countFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar2"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar2"]["macroFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar3"]["countFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar3"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar3"]["macroFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar4"]["countFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar4"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar4"]["macroFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar5"]["countFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar5"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar5"]["macroFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar6"]["countFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar6"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar6"]["macroFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar7"]["countFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar7"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar7"]["macroFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar8"]["countFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar8"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar8"]["macroFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar9"]["countFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar9"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar9"]["macroFontOutline"] = "OUTLINE"
	E.db["actionbar"]["barPet"]["countFontOutline"] = "OUTLINE"
	E.db["actionbar"]["barPet"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["actionbar"]["fontOutline"] = "OUTLINE"
	E.db["actionbar"]["stanceBar"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["actionbar"]["vehicleExitButton"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["auras"]["buffs"]["countFontOutline"] = "OUTLINE"
	E.db["auras"]["buffs"]["timeFontOutline"] = "OUTLINE"
	E.db["auras"]["debuffs"]["countFontOutline"] = "OUTLINE"
	E.db["auras"]["debuffs"]["timeFontOutline"] = "OUTLINE"
	E.db["unitframe"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["assist"]["rdebuffs"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["party"]["buffs"]["countFontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["party"]["debuffs"]["countFontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["raid1"]["rdebuffs"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["raid2"]["rdebuffs"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["raid3"]["rdebuffs"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["tank"]["rdebuffs"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["cooldown"]["fonts"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["health"]["text"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["name"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["name"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["title"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["power"]["text"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["health"]["text"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["name"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["power"]["text"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["buffs"]["countFontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["castbar"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["debuffs"]["countFontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["health"]["text"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["level"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["name"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["title"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["power"]["text"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["buffs"]["countFontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["castbar"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["countFontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["health"]["text"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["level"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["name"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["power"]["text"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["title"]["fontOutline"] = "OUTLINE"

	-- Custom Texts
	if E.db["unitframe"]["units"]["player"]["customTexts"] then
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumHealth"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumHealth"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumName"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumName"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPvP"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPvP"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPlayerAbsorb"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPlayerAbsorb"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumStatus"]["fontOutline"] = "OUTLINE"
		end
	end
	if E.db["unitframe"]["units"]["target"]["customTexts"] then
		if E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetHealth"] then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetHealth"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"] then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetPower"] then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetPower"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetofTarget"] then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetofTarget"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetAbsorb"] then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetAbsorb"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumStatus"]["fontOutline"] = "OUTLINE"
		end
	end
	if E.db["unitframe"]["units"]["targettarget"]["customTexts"] then
		if E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetHealth"] then
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetHealth"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetName"] then
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetName"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumPower"] then
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumPower"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumStatus"]["fontOutline"] = "OUTLINE"
		end
	end
	if E.db["unitframe"]["units"]["pet"]["customTexts"] then
		if E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"] then
			E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["fontOutline"] = "OUTLINE"
		end
	end
	if E.db["unitframe"]["units"]["party"]["customTexts"] then
		if E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyAbsorb"] then
			E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyAbsorb"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyHealth"] then
			E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyHealth"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyName"] then
			E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyName"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyPower"] then
			E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyPower"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumStatus"]["fontOutline"] = "OUTLINE"
		end
	end
	if E.db["unitframe"]["units"]["arena"]["customTexts"] then
		if E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaHealth"] then
			E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaHealth"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaName"] then
			E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaName"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaPower"] then
			E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaPower"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumStatus"]["fontOutline"] = "OUTLINE"
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
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Absorb"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumGroup"] then
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumGroup"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumStatus"]["fontOutline"] = "OUTLINE"
		end
	end
	if E.db["unitframe"]["units"]["raid2"]["customTexts"] then
		if E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumGroup"] then
			E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumGroup"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Health"] then
			E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Health"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Name"] then
			E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Name"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Absorb"] then
			E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Absorb"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumStatus"]["fontOutline"] = "OUTLINE"
		end
	end
	if E.db["unitframe"]["units"]["raid3"]["customTexts"] then
		if E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Absorb"] then
			E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Absorb"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumGroup"] then
			E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumGroup"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Health"] then
			E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Health"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Name"] then
			E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Name"]["fontOutline"] = "OUTLINE"
		end
		if E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumStatus"]["fontOutline"] = "OUTLINE"
		end
	end

	if E.db["datatexts"]["panels"]["EltruismTime"] and E.db["datatexts"]["panels"]["EltruismTime"]["enable"] then
		E.global["datatexts"]["customPanels"]["EltruismTime"]["fonts"]["fontOutline"] = "OUTLINE"
	end
end
