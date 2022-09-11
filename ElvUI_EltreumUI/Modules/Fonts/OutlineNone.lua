local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local IsAddOnLoaded = _G.IsAddOnLoaded

function ElvUI_EltreumUI:SetupFontsOutlineNone()
	if IsAddOnLoaded('ProjectAzilroka') then
		_G.ProjectAzilroka.db["stAddonManager"]["FontFlag"] = "NONE"
	end
	if IsAddOnLoaded("ElvUI_SLE") then
		E.db["sle"]["armory"]["stats"]["catFonts"]["outline"] = "NONE"
		E.db["sle"]["armory"]["stats"]["itemLevel"]["outline"] = "NONE"
		E.db["sle"]["armory"]["stats"]["statFonts"]["outline"] = "NONE"
		E.db["sle"]["media"]["fonts"]["mail"]["outline"] = "NONE"
		E.db["sle"]["media"]["fonts"]["objective"]["outline"] = "NONE"
		E.db["sle"]["media"]["fonts"]["objectiveHeader"]["outline"] = "NONE"
		E.db["sle"]["media"]["fonts"]["pvp"]["outline"] = "NONE"
		E.db["sle"]["media"]["fonts"]["questFontSuperHuge"]["outline"] = "NONE"
		E.db["sle"]["media"]["fonts"]["subzone"]["outline"] = "NONE"
		E.db["sle"]["media"]["fonts"]["zone"]["outline"] = "NONE"
		E.db["sle"]["minimap"]["coords"]["fontOutline"] = "NONE"
		E.db["sle"]["minimap"]["instance"]["fontOutline"] = "NONE"
		E.db["sle"]["minimap"]["locPanel"]["fontOutline"] = "NONE"
		E.db["sle"]["nameplates"]["targetcount"]["fontOutline"] = "NONE"
		E.db["sle"]["skins"]["merchant"]["list"]["subOutline"] = "NONE"
	end
	if IsAddOnLoaded("ElvUI_WindTools") then
		E.private["WT"]["quest"]["objectiveTracker"]["header"]["style"] = "NONE"
		E.private["WT"]["quest"]["objectiveTracker"]["info"]["style"] = "NONE"
		E.private["WT"]["quest"]["objectiveTracker"]["title"]["style"] = "NONE"
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["bindFont"]["style"] = "NONE"
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["countFont"]["style"] = "NONE"
		E.db["WT"]["misc"]["gameBar"]["additionalText"]["font"]["style"] = "NONE"
		E.db["WT"]["misc"]["gameBar"]["time"]["font"]["style"] = "NONE"
	end
	E.db["general"]["altPowerBar"]["fontOutline"] = "NONE"
	E.db["databars"]["azerite"]["fontOutline"] = "NONE"
	E.db["actionbar"]["extraActionButton"]["hotkeyFontOutline"] = "NONE"
	E.db["unitframe"]["units"]["player"]["castbar"]["customTimeFont"]["fontStyle"] = "NONE"
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["fontOutline"] = "NONE"
	E.db["general"]["fontStyle"] = "NONE"
	E.db["general"]["minimap"]["locationFontOutline"] = "NONE"
	if E.Retail then
		E.db["general"]["minimap"]["icons"]["queueStatus"]["fontOutline"] = "NONE"
	end
	if E.Wrath then
		E.db["general"]["totems"]["fontOutline"] = "NONE"
	end
	E.db["bags"]["countFontOutline"] = "NONE"
	E.db["bags"]["itemInfoFontOutline"] = "NONE"
	E.db["bags"]["itemLevelFontOutline"] = "NONE"
	E.db["chat"]["fontOutline"] = "NONE"
	E.db["chat"]["tabFontOutline"] = "NONE"
	E.db["cooldown"]["fonts"]["fontOutline"] = "NONE"
	E.db["databars"]["experience"]["fontOutline"] = "NONE"
	E.db["databars"]["reputation"]["fontOutline"] = "NONE"
	E.db["databars"]["threat"]["fontOutline"] = "NONE"
	E.db["datatexts"]["fontOutline"] = "NONE"
	E.db["tooltip"]["healthBar"]["fontOutline"] = "NONE"
	E.db["tooltip"]["headerFontOutline"] = "NONE"
	E.db["actionbar"]["bar1"]["countFontOutline"] = "NONE"
	E.db["actionbar"]["bar1"]["hotkeyFontOutline"] = "NONE"
	E.db["actionbar"]["bar1"]["macroFontOutline"] = "NONE"
	E.db["actionbar"]["bar10"]["countFontOutline"] = "NONE"
	E.db["actionbar"]["bar10"]["hotkeyFontOutline"] = "NONE"
	E.db["actionbar"]["bar10"]["macroFontOutline"] = "NONE"
	E.db["actionbar"]["bar2"]["countFontOutline"] = "NONE"
	E.db["actionbar"]["bar2"]["hotkeyFontOutline"] = "NONE"
	E.db["actionbar"]["bar2"]["macroFontOutline"] = "NONE"
	E.db["actionbar"]["bar3"]["countFontOutline"] = "NONE"
	E.db["actionbar"]["bar3"]["hotkeyFontOutline"] = "NONE"
	E.db["actionbar"]["bar3"]["macroFontOutline"] = "NONE"
	E.db["actionbar"]["bar4"]["countFontOutline"] = "NONE"
	E.db["actionbar"]["bar4"]["hotkeyFontOutline"] = "NONE"
	E.db["actionbar"]["bar4"]["macroFontOutline"] = "NONE"
	E.db["actionbar"]["bar5"]["countFontOutline"] = "NONE"
	E.db["actionbar"]["bar5"]["hotkeyFontOutline"] = "NONE"
	E.db["actionbar"]["bar5"]["macroFontOutline"] = "NONE"
	E.db["actionbar"]["bar6"]["countFontOutline"] = "NONE"
	E.db["actionbar"]["bar6"]["hotkeyFontOutline"] = "NONE"
	E.db["actionbar"]["bar6"]["macroFontOutline"] = "NONE"
	E.db["actionbar"]["bar7"]["countFontOutline"] = "NONE"
	E.db["actionbar"]["bar7"]["hotkeyFontOutline"] = "NONE"
	E.db["actionbar"]["bar7"]["macroFontOutline"] = "NONE"
	E.db["actionbar"]["bar8"]["countFontOutline"] = "NONE"
	E.db["actionbar"]["bar8"]["hotkeyFontOutline"] = "NONE"
	E.db["actionbar"]["bar8"]["macroFontOutline"] = "NONE"
	E.db["actionbar"]["bar9"]["countFontOutline"] = "NONE"
	E.db["actionbar"]["bar9"]["hotkeyFontOutline"] = "NONE"
	E.db["actionbar"]["bar9"]["macroFontOutline"] = "NONE"
	E.db["actionbar"]["barPet"]["countFontOutline"] = "NONE"
	E.db["actionbar"]["barPet"]["hotkeyFontOutline"] = "NONE"
	E.db["actionbar"]["fontOutline"] = "NONE"
	E.db["actionbar"]["stanceBar"]["hotkeyFontOutline"] = "NONE"
	E.db["actionbar"]["vehicleExitButton"]["hotkeyFontOutline"] = "NONE"
	E.db["auras"]["buffs"]["countFontOutline"] = "NONE"
	E.db["auras"]["buffs"]["timeFontOutline"] = "NONE"
	E.db["auras"]["debuffs"]["countFontOutline"] = "NONE"
	E.db["auras"]["debuffs"]["timeFontOutline"] = "NONE"
	E.db["unitframe"]["fontOutline"] = "NONE"
	E.db["unitframe"]["units"]["assist"]["rdebuffs"]["fontOutline"] = "NONE"
	E.db["unitframe"]["units"]["party"]["buffs"]["countFontOutline"] = "NONE"
	E.db["unitframe"]["units"]["party"]["debuffs"]["countFontOutline"] = "NONE"
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["fontOutline"] = "NONE"
	E.db["unitframe"]["units"]["raid1"]["rdebuffs"]["fontOutline"] = "NONE"
	E.db["unitframe"]["units"]["raid2"]["rdebuffs"]["fontOutline"] = "NONE"
	E.db["unitframe"]["units"]["raid3"]["rdebuffs"]["fontOutline"] = "NONE"
	E.db["unitframe"]["units"]["tank"]["rdebuffs"]["fontOutline"] = "NONE"
	E.db["nameplates"]["cooldown"]["fonts"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["health"]["text"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["name"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["name"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["title"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["power"]["text"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["health"]["text"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["name"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["power"]["text"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["buffs"]["countFontOutline"] = "NONE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["castbar"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["debuffs"]["countFontOutline"] = "NONE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["health"]["text"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["level"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["name"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["title"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["power"]["text"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["PLAYER"]["buffs"]["countFontOutline"] = "NONE"
	E.db["nameplates"]["units"]["PLAYER"]["castbar"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["countFontOutline"] = "NONE"
	E.db["nameplates"]["units"]["PLAYER"]["health"]["text"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["PLAYER"]["level"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["PLAYER"]["name"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["PLAYER"]["power"]["text"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["PLAYER"]["title"]["fontOutline"] = "NONE"

		-- Custom Texts
	if E.db["unitframe"]["units"]["player"]["customTexts"] then
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumHealth"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumHealth"]["fontOutline"] = "NONE"
		end
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumName"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumName"]["fontOutline"] = "NONE"
		end
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"]["fontOutline"] = "NONE"
		end
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPvP"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPvP"]["fontOutline"] = "NONE"
		end
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPlayerAbsorb"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPlayerAbsorb"]["fontOutline"] = "NONE"
		end
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumStatus"]["fontOutline"] = "NONE"
		end
	end
	if E.db["unitframe"]["units"]["target"]["customTexts"] then
		if E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetHealth"] then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetHealth"]["fontOutline"] = "NONE"
		end
		if E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"] then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"]["fontOutline"] = "NONE"
		end
		if E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetPower"] then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetPower"]["fontOutline"] = "NONE"
		end
		if E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetofTarget"] then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetofTarget"]["fontOutline"] = "NONE"
		end
		if E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetAbsorb"] then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetAbsorb"]["fontOutline"] = "NONE"
		end
		if E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumStatus"]["fontOutline"] = "NONE"
		end
	end
	if E.db["unitframe"]["units"]["targettarget"]["customTexts"] then
		if E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetHealth"] then
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetHealth"]["fontOutline"] = "NONE"
		end
		if E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetName"] then
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetName"]["fontOutline"] = "NONE"
		end
		if E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumPower"] then
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumPower"]["fontOutline"] = "NONE"
		end
		if E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumStatus"]["fontOutline"] = "NONE"
		end
	end
	if E.db["unitframe"]["units"]["pet"]["customTexts"] then
		if E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"] then
			E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["fontOutline"] = "NONE"
		end
	end
	if E.db["unitframe"]["units"]["party"]["customTexts"] then
		if E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyAbsorb"] then
			E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyAbsorb"]["fontOutline"] = "NONE"
		end
		if E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyHealth"] then
			E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyHealth"]["fontOutline"] = "NONE"
		end
		if E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyName"] then
			E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyName"]["fontOutline"] = "NONE"
		end
		if E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyPower"] then
			E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyPower"]["fontOutline"] = "NONE"
		end
		if E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumStatus"]["fontOutline"] = "NONE"
		end
	end
	if E.db["unitframe"]["units"]["arena"]["customTexts"] then
		if E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaHealth"] then
			E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaHealth"]["fontOutline"] = "NONE"
		end
		if E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaName"] then
			E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaName"]["fontOutline"] = "NONE"
		end
		if E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaPower"] then
			E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaPower"]["fontOutline"] = "NONE"
		end
		if E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumStatus"]["fontOutline"] = "NONE"
		end
	end
	if E.db["unitframe"]["units"]["raid1"]["customTexts"] then
		if E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Health"] then
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Health"]["fontOutline"] = "NONE"
		end
		if E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Name"] then
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Name"]["fontOutline"] = "NONE"
		end
		if E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Absorb"] then
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Absorb"]["fontOutline"] = "NONE"
		end
		if E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumGroup"] then
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumGroup"]["fontOutline"] = "NONE"
		end
		if E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumStatus"]["fontOutline"] = "NONE"
		end
	end
	if E.db["unitframe"]["units"]["raid2"]["customTexts"] then
		if E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumGroup"] then
			E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumGroup"]["fontOutline"] = "NONE"
		end
		if E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Health"] then
			E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Health"]["fontOutline"] = "NONE"
		end
		if E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Name"] then
			E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Name"]["fontOutline"] = "NONE"
		end
		if E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Absorb"] then
			E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Absorb"]["fontOutline"] = "NONE"
		end
		if E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumStatus"]["fontOutline"] = "NONE"
		end
	end
	if E.db["unitframe"]["units"]["raid3"]["customTexts"] then
		if E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Absorb"] then
			E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Absorb"]["fontOutline"] = "NONE"
		end
		if E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumGroup"] then
			E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumGroup"]["fontOutline"] = "NONE"
		end
		if E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Health"] then
			E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Health"]["fontOutline"] = "NONE"
		end
		if E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Name"] then
			E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Name"]["fontOutline"] = "NONE"
		end
		if E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumStatus"]["fontOutline"] = "NONE"
		end
	end

	if E.db["datatexts"]["panels"]["EltruismTime"] and E.db["datatexts"]["panels"]["EltruismTime"]["enable"] then
		E.global["datatexts"]["customPanels"]["EltruismTime"]["fonts"]["fontOutline"] = "NONE"
	end
end
