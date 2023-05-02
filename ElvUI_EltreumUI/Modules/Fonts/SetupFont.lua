local E, L = unpack(ElvUI)
local _G = _G
local IsAddOnLoaded = _G.IsAddOnLoaded

function ElvUI_EltreumUI:SetupFont(fontvalue, custom)
	if not E.db.movers then E.db.movers = {} end
		--nameplates
		E.db["nameplates"]["cooldown"]["fonts"]["font"] = fontvalue
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["countFont"] = fontvalue
		E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["font"] = fontvalue
		E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["countFont"] = fontvalue
		E.db["nameplates"]["units"]["ENEMY_NPC"]["health"]["text"]["font"] = fontvalue
		E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["font"] = fontvalue
		E.db["nameplates"]["units"]["ENEMY_NPC"]["name"]["font"] = fontvalue
		E.db["nameplates"]["units"]["ENEMY_NPC"]["power"]["text"]["font"] = fontvalue
		if E.Retail then
			E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["font"] = fontvalue
		end
		E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["font"] = fontvalue
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["countFont"] = fontvalue
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["font"] = fontvalue
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["countFont"] = fontvalue
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["health"]["text"]["font"] = fontvalue
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["font"] = fontvalue
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["name"]["font"] = fontvalue
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["power"]["text"]["font"] = fontvalue
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["title"]["font"] = fontvalue
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["buffs"]["countFont"] = fontvalue
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["castbar"]["font"] = fontvalue
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["debuffs"]["countFont"] = fontvalue
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["health"]["text"]["font"] = fontvalue
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["level"]["font"] = fontvalue
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["name"]["font"] = fontvalue
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["power"]["text"]["font"] = fontvalue
		if E.Retail then
			E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["font"] = fontvalue
		end
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["title"]["font"] = fontvalue
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["buffs"]["countFont"] = fontvalue
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["castbar"]["font"] = fontvalue
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["debuffs"]["countFont"] = fontvalue
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["health"]["text"]["font"] = fontvalue
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["level"]["font"] = fontvalue
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["name"]["font"] = fontvalue
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["power"]["text"]["font"] = fontvalue
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["title"]["font"] = fontvalue
		E.db["nameplates"]["units"]["PLAYER"]["buffs"]["countFont"] = fontvalue
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["font"] = fontvalue
		E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["countFont"] = fontvalue
		E.db["nameplates"]["units"]["PLAYER"]["health"]["text"]["font"] = fontvalue
		E.db["nameplates"]["units"]["PLAYER"]["level"]["font"] = fontvalue
		E.db["nameplates"]["units"]["PLAYER"]["name"]["font"] = fontvalue
		E.db["nameplates"]["units"]["PLAYER"]["power"]["text"]["font"] = fontvalue
		E.db["nameplates"]["units"]["PLAYER"]["title"]["font"] = fontvalue
		E.private["general"]["chatBubbleFont"] = fontvalue
		E.private["general"]["dmgfont"] = fontvalue
		E.private["general"]["namefont"] = fontvalue
		if E.Retail then
			if IsAddOnLoaded("ElvUI_SLE") then
				E.db["sle"]["armory"]["character"]["durability"]["font"] = fontvalue
				E.db["sle"]["armory"]["character"]["enchant"]["font"] = fontvalue
				E.db["sle"]["armory"]["character"]["ilvl"]["font"] = fontvalue
				E.db["sle"]["armory"]["inspect"]["enchant"]["font"] = fontvalue
				E.db["sle"]["armory"]["inspect"]["ilvl"]["font"] = fontvalue
				E.db["sle"]["armory"]["stats"]["statLabels"]["font"] = fontvalue
				E.db["sle"]["armory"]["stats"]["itemLevel"]["font"] = fontvalue
				E.db["sle"]["armory"]["stats"]["statHeaders"]["font"] = fontvalue
				E.db["sle"]["media"]["fonts"]["gossip"]["font"] = fontvalue
				E.db["sle"]["media"]["fonts"]["mail"]["font"] = fontvalue
				E.db["sle"]["media"]["fonts"]["objective"]["font"] = fontvalue
				E.db["sle"]["media"]["fonts"]["objectiveHeader"]["font"] = fontvalue
				E.db["sle"]["media"]["fonts"]["pvp"]["font"] = fontvalue
				E.db["sle"]["media"]["fonts"]["questFontSuperHuge"]["font"] = fontvalue
				E.db["sle"]["media"]["fonts"]["subzone"]["font"] = fontvalue
				E.db["sle"]["media"]["fonts"]["zone"]["font"] = fontvalue
				E.db["sle"]["minimap"]["coords"]["font"] = fontvalue
				E.db["sle"]["minimap"]["instance"]["font"] = fontvalue
				E.db["sle"]["minimap"]["locPanel"]["font"] = fontvalue
				E.db["sle"]["afk"]["defaultTexts"]["SL_AFKMessage"]["font"] = fontvalue
				E.db["sle"]["afk"]["defaultTexts"]["SL_AFKTimePassed"]["font"] = fontvalue
				E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["font"] = fontvalue
				E.db["sle"]["afk"]["defaultTexts"]["SL_GuildName"]["font"] = fontvalue
				E.db["sle"]["afk"]["defaultTexts"]["SL_GuildRank"]["font"] = fontvalue
				E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerClass"]["font"] = fontvalue
				E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["font"] = fontvalue
				E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["font"] = fontvalue
				E.db["sle"]["skins"]["merchant"]["list"]["nameFont"] = fontvalue
				E.db["sle"]["skins"]["merchant"]["list"]["subFont"] = fontvalue
			end
			if IsAddOnLoaded("ElvUI_WindTools") then
				E.private["WT"]["skins"]["ime"]["label"]["name"] = fontvalue
				E.db["WT"]["item"]["extraItemsBar"]["bar1"]["bindFont"]["name"] = fontvalue
				E.db["WT"]["item"]["extraItemsBar"]["bar1"]["countFont"]["name"] = fontvalue
				E.db["WT"]["item"]["inspect"]["levelText"]["name"] = fontvalue
				E.db["WT"]["misc"]["gameBar"]["additionalText"]["font"]["name"] = fontvalue
				E.db["WT"]["misc"]["gameBar"]["time"]["font"]["name"] = fontvalue
			end
			E.db["general"]["altPowerBar"]["font"] = fontvalue
			E.db["general"]["itemLevel"]["itemLevelFont"] = fontvalue
		end
		E.db["general"]["font"] = fontvalue
		E.db["general"]["minimap"]["locationFont"] = fontvalue
		E.db["general"]["minimap"]["timeFont"] = fontvalue
		if E.Retail then
			E.db["general"]["minimap"]["icons"]["queueStatus"]["font"] = fontvalue
		end
		if E.Wrath then
			E.db["general"]["totems"]["font"] = fontvalue
		end
		E.db["general"]["addonCompartment"]["font"] = fontvalue
		E.db["bags"]["countFont"] = fontvalue
		E.db["bags"]["itemInfoFont"] = fontvalue
		E.db["bags"]["itemLevelFont"] = fontvalue
		E.db["chat"]["font"] = fontvalue
		E.db["chat"]["tabFont"] = fontvalue
		E.db["cooldown"]["fonts"]["font"] = fontvalue
		if E.Retail then
			E.db["databars"]["honor"]["font"] = fontvalue
			E.db["databars"]["azerite"]["font"] = fontvalue
		end
		E.db["databars"]["experience"]["font"] = fontvalue
		E.db["databars"]["reputation"]["font"] = fontvalue
		E.db["databars"]["threat"]["font"] = fontvalue
		E.db["datatexts"]["font"] = fontvalue
		E.db["tooltip"]["font"] = fontvalue
		E.db["tooltip"]["healthBar"]["font"] = fontvalue
		E.db["tooltip"]["headerFont"] = fontvalue

		--ActionBars
		E.db["actionbar"]["bar1"]["countFont"] = fontvalue
		E.db["actionbar"]["bar1"]["hotkeyFont"] = fontvalue
		E.db["actionbar"]["bar1"]["macroFont"] = fontvalue
		E.db["actionbar"]["bar10"]["countFont"] = fontvalue
		E.db["actionbar"]["bar10"]["hotkeyFont"] = fontvalue
		E.db["actionbar"]["bar10"]["macroFont"] = fontvalue
		E.db["actionbar"]["bar2"]["countFont"] = fontvalue
		E.db["actionbar"]["bar2"]["hotkeyFont"] = fontvalue
		E.db["actionbar"]["bar2"]["macroFont"] = fontvalue
		E.db["actionbar"]["bar3"]["countFont"] = fontvalue
		E.db["actionbar"]["bar3"]["hotkeyFont"] = fontvalue
		E.db["actionbar"]["bar3"]["macroFont"] = fontvalue
		E.db["actionbar"]["bar4"]["countFont"] = fontvalue
		E.db["actionbar"]["bar4"]["hotkeyFont"] = fontvalue
		E.db["actionbar"]["bar4"]["macroFont"] = fontvalue
		E.db["actionbar"]["bar5"]["countFont"] = fontvalue
		E.db["actionbar"]["bar5"]["hotkeyFont"] = fontvalue
		E.db["actionbar"]["bar5"]["macroFont"] = fontvalue
		E.db["actionbar"]["bar6"]["countFont"] = fontvalue
		E.db["actionbar"]["bar6"]["hotkeyFont"] = fontvalue
		E.db["actionbar"]["bar6"]["macroFont"] = fontvalue
		E.db["actionbar"]["bar7"]["countFont"] = fontvalue
		E.db["actionbar"]["bar7"]["hotkeyFont"] = fontvalue
		E.db["actionbar"]["bar7"]["macroFont"] = fontvalue
		E.db["actionbar"]["bar8"]["countFont"] = fontvalue
		E.db["actionbar"]["bar8"]["hotkeyFont"] = fontvalue
		E.db["actionbar"]["bar8"]["macroFont"] = fontvalue
		E.db["actionbar"]["bar9"]["countFont"] = fontvalue
		E.db["actionbar"]["bar9"]["hotkeyFont"] = fontvalue
		E.db["actionbar"]["bar9"]["macroFont"] = fontvalue
		E.db["actionbar"]["barPet"]["countFont"] = fontvalue
		E.db["actionbar"]["barPet"]["hotkeyFont"] = fontvalue
		if E.Retail then
			E.db["actionbar"]["extraActionButton"]["hotkeyFont"] = fontvalue
		end
		E.db["actionbar"]["font"] = fontvalue
		E.db["actionbar"]["stanceBar"]["hotkeyFont"] = fontvalue
		E.db["actionbar"]["vehicleExitButton"]["hotkeyFont"] = fontvalue
		E.db["auras"]["buffs"]["countFont"] = fontvalue
		E.db["auras"]["buffs"]["timeFont"] = fontvalue
		E.db["auras"]["debuffs"]["countFont"] = fontvalue
		E.db["auras"]["debuffs"]["timeFont"] = fontvalue
		E.db["unitframe"]["font"] = fontvalue
		if E.Retail then
			E.db["unitframe"]["units"]["arena"]["buffs"]["countFont"] = fontvalue
			E.db["unitframe"]["units"]["arena"]["debuffs"]["countFont"] = fontvalue
			E.db["unitframe"]["units"]["assist"]["buffs"]["countFont"] = fontvalue
			E.db["unitframe"]["units"]["assist"]["debuffs"]["countFont"] = fontvalue
			E.db["unitframe"]["units"]["assist"]["rdebuffs"]["font"] = fontvalue
			E.db["unitframe"]["units"]["boss"]["buffs"]["countFont"] = fontvalue
			E.db["unitframe"]["units"]["boss"]["debuffs"]["countFont"] = fontvalue
			E.db["unitframe"]["units"]["focus"]["debuffs"]["countFont"] = fontvalue
			E.db["unitframe"]["units"]["party"]["castbar"]["customTextFont"]["font"] = fontvalue
			E.db["unitframe"]["units"]["player"]["castbar"]["customTimeFont"]["font"] = fontvalue
		end
		E.db["unitframe"]["units"]["party"]["buffs"]["countFont"] = fontvalue
		E.db["unitframe"]["units"]["party"]["debuffs"]["countFont"] = fontvalue
		E.db["unitframe"]["units"]["party"]["rdebuffs"]["font"] = fontvalue
		E.db["unitframe"]["units"]["player"]["buffs"]["countFont"] = fontvalue
		E.db["unitframe"]["units"]["player"]["debuffs"]["countFont"] = fontvalue
		E.db["unitframe"]["units"]["raid1"]["buffs"]["countFont"] = fontvalue
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["countFont"] = fontvalue
		E.db["unitframe"]["units"]["raid1"]["rdebuffs"]["font"] = fontvalue
		E.db["unitframe"]["units"]["raid2"]["buffs"]["countFont"] = fontvalue
		E.db["unitframe"]["units"]["raid2"]["debuffs"]["countFont"] = fontvalue
		E.db["unitframe"]["units"]["raid2"]["rdebuffs"]["font"] = fontvalue
		E.db["unitframe"]["units"]["raid3"]["buffs"]["countFont"] = fontvalue
		E.db["unitframe"]["units"]["raid3"]["debuffs"]["countFont"] = fontvalue
		E.db["unitframe"]["units"]["raid3"]["rdebuffs"]["font"] = fontvalue
		E.db["unitframe"]["units"]["tank"]["buffs"]["countFont"] = fontvalue
		E.db["unitframe"]["units"]["tank"]["debuffs"]["countFont"] = fontvalue
		E.db["unitframe"]["units"]["tank"]["rdebuffs"]["font"] = fontvalue
		E.db["unitframe"]["units"]["target"]["buffs"]["countFont"] = fontvalue
		E.db["unitframe"]["units"]["target"]["debuffs"]["countFont"] = fontvalue
		E.db["unitframe"]["units"]["targettargettarget"]["buffs"]["countFont"] = fontvalue
		E.db["unitframe"]["units"]["targettargettarget"]["debuffs"]["countFont"] = fontvalue

		-- Custom Text: Party
		E.db["unitframe"]["units"]["party"]["customTexts"] = E.db["unitframe"]["units"]["party"]["customTexts"] or {}
		if E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyHealth"] then
			E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyHealth"]["font"] = fontvalue
		end
		if E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyName"] then
			E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyName"]["font"] = fontvalue
		end
		if E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyPower"] then
			E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyPower"]["font"] = fontvalue
		end
		if E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumStatus"]["font"] = fontvalue
		end
		if E.Retail then
			if E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyAbsorb"] then
				E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyAbsorb"]["font"] = fontvalue
			end
		end

		-- Custom Text: Arena
		E.db["unitframe"]["units"]["arena"]["customTexts"] = E.db["unitframe"]["units"]["arena"]["customTexts"] or {}
		if E.Retail or E.Wrath then
			if E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaHealth"] then
				E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaHealth"]["font"] = fontvalue
			end
			if E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaName"] then
				E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaName"]["font"] = fontvalue
			end
			if E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaPower"] then
				E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaPower"]["font"] = fontvalue
			end
		elseif E.Classic then
			if E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaHealth"] then
				E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaHealth"]["font"] = fontvalue
			end
			if E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaName"] then
				E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaName"]["font"] = fontvalue
			end
			if E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaPower"] then
				E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaPower"]["font"] = fontvalue
			end
		end
		if E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumStatus"]["font"] = fontvalue
		end

		-- Custom Text: Pet
		E.db["unitframe"]["units"]["pet"]["customTexts"] = E.db["unitframe"]["units"]["pet"]["customTexts"] or {}
		if E.Retail then
			if E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"] then
				E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["font"] = fontvalue
			end
		elseif E.Wrath or E.Classic then
			if E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"] then
				E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["font"] = fontvalue
			end
		end

		-- Custom Text: Player
		E.db["unitframe"]["units"]["player"]["customTexts"] = E.db["unitframe"]["units"]["player"]["customTexts"] or {}
		if E.Retail then
			if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPlayerAbsorb"] then
				E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPlayerAbsorb"]["font"] = fontvalue
			end
		end
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumHealth"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumHealth"]["font"] = fontvalue
		end
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumName"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumName"]["font"] = fontvalue
		end
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"]["font"] = fontvalue
		end
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPvP"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPvP"]["font"] = fontvalue
		end
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumStatus"]["font"] = fontvalue
		end
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumStance"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumStance"]["font"] = fontvalue
		end

		-- Custom Text: Raid1
		E.db["unitframe"]["units"]["raid1"]["customTexts"] = E.db["unitframe"]["units"]["raid1"]["customTexts"] or {}
		if E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumGroup"] then
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumGroup"]["font"] = fontvalue
		end
		if E.Retail then
			if E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Absorb"] then
				E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Absorb"]["font"] = fontvalue
			end
		end
		if E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Health"] then
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Health"]["font"] = fontvalue
		end
		if E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Name"] then
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Name"]["font"] = fontvalue
		end
		if E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumStatus"]["font"] = fontvalue
		end

		-- Custom Text: Raid2
		E.db["unitframe"]["units"]["raid2"]["customTexts"] = E.db["unitframe"]["units"]["raid2"]["customTexts"] or {}
		if E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumGroup"] then
			E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumGroup"]["font"] = fontvalue
		end
		if E.Retail then
			if E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Absorb"] then
				E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Absorb"]["font"] = fontvalue
			end
		end
		if E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Health"] then
			E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Health"]["font"] = fontvalue
		end
		if E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Name"] then
			E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Name"]["font"] = fontvalue
		end
		if E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumStatus"]["font"] = fontvalue
		end

		-- Custom Text: Raid3
		E.db["unitframe"]["units"]["raid3"]["customTexts"] = E.db["unitframe"]["units"]["raid3"]["customTexts"] or {}
		if E.Retail then
			if E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Absorb"] then
				E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Absorb"]["font"] = fontvalue
			end
		end
		if E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumGroup"] then
			E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumGroup"]["font"] = fontvalue
		end
		if E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Health"] then
			E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Health"]["font"] = fontvalue
		end
		if E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Name"] then
			E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Name"]["font"] = fontvalue
		end
		if E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumStatus"]["font"] = fontvalue
		end

		-- Custom Text: Target
		E.db["unitframe"]["units"]["target"]["customTexts"] = E.db["unitframe"]["units"]["target"]["customTexts"] or {}
		if E.Retail then
			if E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetAbsorb"] then
				E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetAbsorb"]["font"] = fontvalue
			end
		end
		if E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetHealth"] then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetHealth"]["font"] = fontvalue
		end
		if E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"] then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"]["font"] = fontvalue
		end
		if E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetPower"] then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetPower"]["font"] = fontvalue
		end
		if E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetofTarget"] then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetofTarget"]["font"] = fontvalue
		end
		if E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumStatus"]["font"] = fontvalue
		end

		-- Custom Text: TargetTarget
		E.db["unitframe"]["units"]["targettarget"]["customTexts"] = E.db["unitframe"]["units"]["targettarget"]["customTexts"] or {}
		if E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetHealth"] then
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetHealth"]["font"] = fontvalue
		end
		if E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetName"] then
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetName"]["font"] = fontvalue
		end
		if E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumPower"] then
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumPower"]["font"] = fontvalue
		end
		if E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumStatus"]["font"] = fontvalue
		end

		if E.db["datatexts"]["panels"]["EltruismTime"] and E.db["datatexts"]["panels"]["EltruismTime"]["enable"] then
			E.global["datatexts"]["customPanels"]["EltruismTime"]["fonts"]["font"] = fontvalue
		end

	--FCT font
	if IsAddOnLoaded("ElvUI_FCT") then
		ElvFCT["nameplates"]["frames"]["Player"]["font"] = fontvalue
		ElvFCT["nameplates"]["frames"]["Player"]["critFont"] = fontvalue
		ElvFCT["nameplates"]["frames"]["FriendlyPlayer"]["font"] = fontvalue
		ElvFCT["nameplates"]["frames"]["FriendlyPlayer"]["critFont"] = fontvalue
		ElvFCT["nameplates"]["frames"]["FriendlyNPC"]["font"] = fontvalue
		ElvFCT["nameplates"]["frames"]["FriendlyNPC"]["critFont"] = fontvalue
		ElvFCT["nameplates"]["frames"]["EnemyNPC"]["font"] = fontvalue
		ElvFCT["nameplates"]["frames"]["EnemyNPC"]["critFont"] = fontvalue
		ElvFCT["nameplates"]["frames"]["EnemyPlayer"]["font"] = fontvalue
		ElvFCT["nameplates"]["frames"]["EnemyPlayer"]["critFont"] = fontvalue
		ElvFCT["unitframes"]["frames"]["Player"]["font"] = fontvalue
		ElvFCT["unitframes"]["frames"]["Player"]["critFont"] = fontvalue
		ElvFCT["unitframes"]["frames"]["Target"]["font"] = fontvalue
		ElvFCT["unitframes"]["frames"]["Target"]["critFont"] = fontvalue
		ElvFCT["unitframes"]["frames"]["TargetTarget"]["font"] = fontvalue
		ElvFCT["unitframes"]["frames"]["TargetTarget"]["critFont"] = fontvalue
		ElvFCT["unitframes"]["frames"]["TargetTargetTarget"]["font"] = fontvalue
		ElvFCT["unitframes"]["frames"]["TargetTargetTarget"]["critFont"] = fontvalue
		ElvFCT["unitframes"]["frames"]["Focus"]["font"] = fontvalue
		ElvFCT["unitframes"]["frames"]["Focus"]["critFont"] = fontvalue
		ElvFCT["unitframes"]["frames"]["FocusTarget"]["font"] = fontvalue
		ElvFCT["unitframes"]["frames"]["FocusTarget"]["critFont"] = fontvalue
		ElvFCT["unitframes"]["frames"]["Pet"]["font"] = fontvalue
		ElvFCT["unitframes"]["frames"]["Pet"]["critFont"] = fontvalue
		ElvFCT["unitframes"]["frames"]["PetTarget"]["font"] = fontvalue
		ElvFCT["unitframes"]["frames"]["PetTarget"]["critFont"] = fontvalue
		ElvFCT["unitframes"]["frames"]["Tank"]["font"] = fontvalue
		ElvFCT["unitframes"]["frames"]["Tank"]["critFont"] = fontvalue
		ElvFCT["unitframes"]["frames"]["Assist"]["font"] = fontvalue
		ElvFCT["unitframes"]["frames"]["Assist"]["critFont"] = fontvalue
		ElvFCT["unitframes"]["frames"]["Boss"]["font"] = fontvalue
		ElvFCT["unitframes"]["frames"]["Boss"]["critFont"] = fontvalue
		ElvFCT["unitframes"]["frames"]["Raid1"]["font"] = fontvalue
		ElvFCT["unitframes"]["frames"]["Raid1"]["critFont"] = fontvalue
		ElvFCT["unitframes"]["frames"]["Raid2"]["font"] = fontvalue
		ElvFCT["unitframes"]["frames"]["Raid2"]["critFont"] = fontvalue
		ElvFCT["unitframes"]["frames"]["Raid3"]["font"] = fontvalue
		ElvFCT["unitframes"]["frames"]["Raid3"]["critFont"] = fontvalue
		ElvFCT["unitframes"]["frames"]["RaidPet"]["font"] = fontvalue
		ElvFCT["unitframes"]["frames"]["RaidPet"]["critFont"] = fontvalue
		ElvFCT["unitframes"]["frames"]["Party"]["font"] = fontvalue
		ElvFCT["unitframes"]["frames"]["Party"]["critFont"] = fontvalue
		ElvFCT["unitframes"]["frames"]["Arena"]["font"] = fontvalue
		ElvFCT["unitframes"]["frames"]["Arena"]["critFont"] = fontvalue
	end
	if IsAddOnLoaded('NameplateSCT') then
		NameplateSCTDB["global"]["font"] = fontvalue
	end

	if IsAddOnLoaded('ProjectAzilroka') then
		_G.ProjectAzilroka.db["stAddonManager"]["Font"] = fontvalue
	end

	if IsAddOnLoaded("Questie") then
		QuestieConfig["global"]["trackerFontObjective"] = E.db.general.font
		QuestieConfig["global"]["trackerFontZone"] = E.db.general.font
		QuestieConfig["global"]["trackerFontHeader"] = E.db.general.font
		QuestieConfig["global"]["trackerFontQuest"] = E.db.general.font
	end

	E:StaggeredUpdateAll()

	if custom then
		ElvUI_EltreumUI:Print(L["Your custom font has been set."])
	else
		ElvUI_EltreumUI:Print(fontvalue.." "..L["Font has been set."])
	end

	ElvUI_EltreumUI:ResolutionOutline()
end
