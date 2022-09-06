local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local IsAddOnLoaded = _G.IsAddOnLoaded

function ElvUI_EltreumUI:SetupFontsOutlineThick()
	if IsAddOnLoaded('ProjectAzilroka') then
		_G.ProjectAzilroka.db["stAddonManager"]["FontFlag"] = "THICKOUTLINE"
	end
	if IsAddOnLoaded("ElvUI_SLE") then
		E.db["sle"]["armory"]["stats"]["catFonts"]["outline"] = "THICKOUTLINE"
		E.db["sle"]["armory"]["stats"]["itemLevel"]["outline"] = "THICKOUTLINE"
		E.db["sle"]["armory"]["stats"]["statFonts"]["outline"] = "THICKOUTLINE"
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
	if IsAddOnLoaded("ElvUI_WindTools") then
		E.private["WT"]["quest"]["objectiveTracker"]["header"]["style"] = "THICKOUTLINE"
		E.private["WT"]["quest"]["objectiveTracker"]["info"]["style"] = "THICKOUTLINE"
		E.private["WT"]["quest"]["objectiveTracker"]["title"]["style"] = "THICKOUTLINE"
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["bindFont"]["style"] = "THICKOUTLINE"
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["countFont"]["style"] = "THICKOUTLINE"
		E.db["WT"]["misc"]["gameBar"]["additionalText"]["font"]["style"] = "THICKOUTLINE"
		E.db["WT"]["misc"]["gameBar"]["time"]["font"]["style"] = "THICKOUTLINE"
	end
	E.db["general"]["altPowerBar"]["fontOutline"] = "THICKOUTLINE"
	E.db["databars"]["azerite"]["fontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["extraActionButton"]["hotkeyFontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["player"]["castbar"]["customTimeFont"]["fontStyle"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["fontOutline"] = "THICKOUTLINE"
	E.db["general"]["fontStyle"] = "THICKOUTLINE"
	E.db["general"]["minimap"]["locationFontOutline"] = "THICKOUTLINE"
	if E.Retail then
		E.db["general"]["minimap"]["icons"]["queueStatus"]["fontOutline"] = "THICKOUTLINE"
	end
	if E.Wrath then
		E.db["general"]["totems"]["fontOutline"] = "THICKOUTLINE"
	end
	E.db["bags"]["countFontOutline"] = "THICKOUTLINE"
	E.db["bags"]["itemInfoFontOutline"] = "THICKOUTLINE"
	E.db["bags"]["itemLevelFontOutline"] = "THICKOUTLINE"
	E.db["chat"]["fontOutline"] = "THICKOUTLINE"
	E.db["chat"]["tabFontOutline"] = "THICKOUTLINE"
	E.db["cooldown"]["fonts"]["fontOutline"] = "THICKOUTLINE"
	E.db["databars"]["experience"]["fontOutline"] = "THICKOUTLINE"
	E.db["databars"]["reputation"]["fontOutline"] = "THICKOUTLINE"
	E.db["databars"]["threat"]["fontOutline"] = "THICKOUTLINE"
	E.db["datatexts"]["fontOutline"] = "THICKOUTLINE"
	E.db["tooltip"]["healthBar"]["fontOutline"] = "THICKOUTLINE"
	E.db["tooltip"]["headerFontOutline"] = "THICKOUTLINE"
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
	E.db["unitframe"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["assist"]["rdebuffs"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["party"]["debuffs"]["countFontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["raid1"]["rdebuffs"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["raid2"]["rdebuffs"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["raid3"]["rdebuffs"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["tank"]["rdebuffs"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["cooldown"]["fonts"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["health"]["text"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["name"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["name"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["title"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["power"]["text"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["health"]["text"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["name"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["power"]["text"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["buffs"]["countFontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["castbar"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["debuffs"]["countFontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["health"]["text"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["level"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["name"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["title"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["power"]["text"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["buffs"]["countFontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["castbar"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["countFontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["health"]["text"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["level"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["name"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["power"]["text"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["title"]["fontOutline"] = "THICKOUTLINE"

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
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetofTarget"]["fontOutline"] = "THICKOUTLINE"
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
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetName"]["fontOutline"] = "THICKOUTLINE"
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
			E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaHealth"]["fontOutline"] = "THICKOUTLINE"
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
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Health"]["fontOutline"] = "THICKOUTLINE"
		end
		if E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Name"] then
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Name"]["fontOutline"] = "THICKOUTLINE"
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
			E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Health"]["fontOutline"] = "THICKOUTLINE"
		end
		if E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Name"] then
			E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Name"]["fontOutline"] = "THICKOUTLINE"
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
			E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Health"]["fontOutline"] = "THICKOUTLINE"
		end
		if E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Name"] then
			E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Name"]["fontOutline"] = "THICKOUTLINE"
		end
		if E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumStatus"]["fontOutline"] = "THICKOUTLINE"
		end
	end
end
