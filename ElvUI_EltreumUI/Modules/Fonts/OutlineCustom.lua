local E = unpack(ElvUI)
local _G = _G
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded

function ElvUI_EltreumUI:SetupFontsOutlineCustom(fontStyle)

	-- General
	E.db["general"]["fontStyle"] = fontStyle
	E.db["general"]["altPowerBar"]["fontOutline"] = fontStyle
	E.db["general"]["fonts"]["cooldown"]["outline"] = fontStyle
	E.db["general"]["fonts"]["errortext"]["outline"] = fontStyle
	E.db["general"]["fonts"]["mailbody"]["outline"] = fontStyle
	E.db["general"]["fonts"]["objective"]["outline"] = fontStyle
	E.db["general"]["fonts"]["pvpsubzone"]["outline"] = fontStyle
	E.db["general"]["fonts"]["pvpzone"]["outline"] = fontStyle
	E.db["general"]["fonts"]["questsmall"]["outline"] = fontStyle
	E.db["general"]["fonts"]["questtext"]["outline"] = fontStyle
	E.db["general"]["fonts"]["talkingtext"]["outline"] = fontStyle
	E.db["general"]["fonts"]["talkingtitle"]["outline"] = fontStyle
	E.db["general"]["fonts"]["worldsubzone"]["outline"] = fontStyle
	E.db["general"]["fonts"]["worldzone"]["outline"] = fontStyle
	E.db["general"]["fonts"]["questtitle"]["outline"] = fontStyle
	E.db["general"]["itemLevel"]["itemLevelFontOutline"] = fontStyle
	E.db["general"]["lootRoll"]["nameFontOutline"] = fontStyle
	E.db["general"]["minimap"]["timeFontOutline"] = fontStyle
	E.db["general"]["minimap"]["locationFontOutline"] = fontStyle
	E.db["general"]["addonCompartment"]["fontOutline"] = fontStyle
	E.db["general"]["guildBank"]["countFontOutline"] = fontStyle
	E.db["general"]["guildBank"]["itemLevelFontOutline"] = fontStyle
	E.db["general"]["queueStatus"]["fontOutline"] = fontStyle
	E.db["general"]["totems"]["fontOutline"] = fontStyle

	-- Cooldown
	E.db["cooldown"]["fonts"]["fontOutline"] = fontStyle
	E.db["WeakAuras"]["cooldown"]["fonts"]["fontOutline"] = fontStyle

	-- Private
	E.private["general"]["nameplateFontOutline"] = fontStyle
	E.private["general"]["nameplateLargeFontOutline"] = fontStyle
	E.private["general"]["chatBubbleFontOutline"] = fontStyle

	-- Databars
	E.db["databars"]["honor"]["fontOutline"] = fontStyle
	E.db["databars"]["azerite"]["fontOutline"] = fontStyle
	E.db["databars"]["experience"]["fontOutline"] = fontStyle
	E.db["databars"]["reputation"]["fontOutline"] = fontStyle
	E.db["databars"]["threat"]["fontOutline"] = fontStyle

	-- Bags
	E.db["bags"]["cooldown"]["fonts"]["fontOutline"] = fontStyle
	E.db["bags"]["countFontOutline"] = fontStyle
	E.db["bags"]["itemInfoFontOutline"] = fontStyle
	E.db["bags"]["itemLevelFontOutline"] = fontStyle

	-- Chat
	E.db["chat"]["fontOutline"] = fontStyle
	E.db["chat"]["tabFontOutline"] = fontStyle

	-- Datatexts
	E.db["datatexts"]["fontOutline"] = fontStyle

	-- Tooltip
	E.db["tooltip"]["fontOutline"] = fontStyle
	E.db["tooltip"]["healthBar"]["fontOutline"] = fontStyle
	E.db["tooltip"]["headerFontOutline"] = fontStyle

	-- Auras
	E.db["auras"]["buffs"]["countFontOutline"] = fontStyle
	E.db["auras"]["buffs"]["timeFontOutline"] = fontStyle
	E.db["auras"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["auras"]["debuffs"]["timeFontOutline"] = fontStyle

	-- Actionbars
	E.db["actionbar"]["fontOutline"] = fontStyle
	E.db["actionbar"]["stanceBar"]["hotkeyFontOutline"] = fontStyle
	E.db["actionbar"]["vehicleExitButton"]["hotkeyFontOutline"] = fontStyle
	E.db["actionbar"]["cooldown"]["fonts"]["fontOutline"] = fontStyle
	E.db["actionbar"]["extraActionButton"]["hotkeyFontOutline"] = fontStyle
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

	-- Unitframes
	E.db["unitframe"]["fontOutline"] = fontStyle
	E.db["unitframe"]["cooldown"]["fonts"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["assist"]["rdebuffs"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["assist"]["buffIndicator"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["assist"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["assist"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["party"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["party"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["party"]["castbar"]["customTextFont"]["fontStyle"] = fontStyle
	E.db["unitframe"]["units"]["party"]["castbar"]["customTimeFont"]["fontStyle"] = fontStyle
	E.db["unitframe"]["units"]["party"]["buffIndicator"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["party"]["petsGroup"]["buffIndicator"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid1"]["rdebuffs"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid1"]["buffIndicator"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid1"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid1"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid2"]["rdebuffs"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid2"]["buffIndicator"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid2"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid2"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid3"]["rdebuffs"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid3"]["buffIndicator"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid3"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid3"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["tank"]["rdebuffs"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["tank"]["buffIndicator"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["tank"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["tank"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["pet"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["pet"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["pet"]["castbar"]["customTimeFont"]["fontStyle"] = fontStyle
	E.db["unitframe"]["units"]["pet"]["castbar"]["customTextFont"]["fontStyle"] = fontStyle
	E.db["unitframe"]["units"]["pet"]["buffIndicator"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["player"]["castbar"]["customTimeFont"]["fontStyle"] = fontStyle
	E.db["unitframe"]["units"]["player"]["castbar"]["customTextFont"]["fontStyle"] = fontStyle
	E.db["unitframe"]["units"]["player"]["buffIndicator"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["player"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["player"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["target"]["castbar"]["customTimeFont"]["fontStyle"] = fontStyle
	E.db["unitframe"]["units"]["target"]["castbar"]["customTextFont"]["fontStyle"] = fontStyle
	E.db["unitframe"]["units"]["target"]["buffIndicator"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["target"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["target"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["focus"]["castbar"]["customTimeFont"]["fontStyle"] = fontStyle
	E.db["unitframe"]["units"]["focus"]["castbar"]["customTextFont"]["fontStyle"] = fontStyle
	E.db["unitframe"]["units"]["focus"]["buffIndicator"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["focus"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["focus"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["arena"]["castbar"]["customTimeFont"]["fontStyle"] = fontStyle
	E.db["unitframe"]["units"]["arena"]["castbar"]["customTextFont"]["fontStyle"] = fontStyle
	E.db["unitframe"]["units"]["arena"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["arena"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["boss"]["castbar"]["customTimeFont"]["fontStyle"] = fontStyle
	E.db["unitframe"]["units"]["boss"]["castbar"]["customTextFont"]["fontStyle"] = fontStyle
	E.db["unitframe"]["units"]["boss"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["boss"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["focustarget"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["focustarget"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["pettarget"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["pettarget"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raidpet"]["buffIndicator"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raidpet"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raidpet"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["targettarget"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["targettarget"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["targettargettarget"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["targettargettarget"]["debuffs"]["countFontOutline"] = fontStyle

	-- Nameplates
	E.db["nameplates"]["cooldown"]["fonts"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_NPC"]["health"]["text"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_NPC"]["name"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["countFontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["name"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["title"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["buffs"]["countFontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["castbar"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["health"]["text"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["level"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["power"]["text"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_NPC"]["power"]["text"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["health"]["text"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["name"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["power"]["text"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["countFontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["title"]["fontOutline"] = fontStyle
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
	local currentprofile
	if ElvDB.profileKeys[E.mynameRealm] then
		currentprofile = ElvDB.profileKeys[E.mynameRealm]
	else
		currentprofile = false
	end
	for profile, data in pairs(ElvDB.profiles) do
		if profile == currentprofile then
			if data then
				if data.unitframe then
					if data.unitframe.units then
						if data.unitframe.units.player then
							if data.unitframe.units.player.customTexts then
								for _, customText in next, data.unitframe.units.player.customTexts do
									if customText then
										customText["fontOutline"] = fontStyle
									end
								end
							end
						end
						if data.unitframe.units.target then
							if data.unitframe.units.target.customTexts then
								for _, customText in next, data.unitframe.units.target.customTexts do
									if customText then
										customText["fontOutline"] = fontStyle
									end
								end
							end
						end
						if data.unitframe.units.targettarget then
							if data.unitframe.units.targettarget.customTexts then
								for _, customText in next, data.unitframe.units.targettarget.customTexts do
									if customText then
										customText["fontOutline"] = fontStyle
									end
								end
							end
						end
						if data.unitframe.units.targettargettarget then
							if data.unitframe.units.targettargettarget.customTexts then
								for _, customText in next, data.unitframe.units.targettargettarget.customTexts do
									if customText then
										customText["fontOutline"] = fontStyle
									end
								end
							end
						end
						if data.unitframe.units.pet then
							if data.unitframe.units.pet.customTexts then
								for _, customText in next, data.unitframe.units.pet.customTexts do
									if customText then
										customText["fontOutline"] = fontStyle
									end
								end
							end
						end
						if data.unitframe.units.pettarget then
							if data.unitframe.units.pettarget.customTexts then
								for _, customText in next, data.unitframe.units.pettarget.customTexts do
									if customText then
										customText["fontOutline"] = fontStyle
									end
								end
							end
						end
						if data.unitframe.units.focus then
							if data.unitframe.units.focus.customTexts then
								for _, customText in next, data.unitframe.units.focus.customTexts do
									if customText then
										customText["fontOutline"] = fontStyle
									end
								end
							end
						end
						if data.unitframe.units.focustarget then
							if data.unitframe.units.focustarget.customTexts then
								for _, customText in next, data.unitframe.units.focustarget.customTexts do
									if customText then
										customText["fontOutline"] = fontStyle
									end
								end
							end
						end
						if data.unitframe.units.arena then
							if data.unitframe.units.arena.customTexts then
								for _, customText in next, data.unitframe.units.arena.customTexts do
									if customText then
										customText["fontOutline"] = fontStyle
									end
								end
							end
						end
						if data.unitframe.units.boss then
							if data.unitframe.units.boss.customTexts then
								for _, customText in next, data.unitframe.units.boss.customTexts do
									if customText then
										customText["fontOutline"] = fontStyle
									end
								end
							end
						end
						if data.unitframe.units.party then
							if data.unitframe.units.party.customTexts then
								for _, customText in next, data.unitframe.units.party.customTexts do
									if customText then
										customText["fontOutline"] = fontStyle
									end
								end
							end
						end
						if data.unitframe.units.raid1 then
							if data.unitframe.units.raid1.customTexts then
								for _, customText in next, data.unitframe.units.raid1.customTexts do
									if customText then
										customText["fontOutline"] = fontStyle
									end
								end
							end
						end
						if data.unitframe.units.raid2 then
							if data.unitframe.units.raid2.customTexts then
								for _, customText in next, data.unitframe.units.raid2.customTexts do
									if customText then
										customText["fontOutline"] = fontStyle
									end
								end
							end
						end
						if data.unitframe.units.raid3 then
							if data.unitframe.units.raid3.customTexts then
								for _, customText in next, data.unitframe.units.raid3.customTexts do
									if customText then
										customText["fontOutline"] = fontStyle
									end
								end
							end
						end
						if data.unitframe.units.raidpet then
							if data.unitframe.units.raidpet.customTexts then
								for _, customText in next, data.unitframe.units.raidpet.customTexts do
									if customText then
										customText["fontOutline"] = fontStyle
									end
								end
							end
						end
						if data.unitframe.units.tank then
							if data.unitframe.units.tank.customTexts then
								for _, customText in next, data.unitframe.units.tank.customTexts do
									if customText then
										customText["fontOutline"] = fontStyle
									end
								end
							end
						end
					end
				end
			end
		end
	end

	--Custom Datatext Panels
	for profile,data in pairs(ElvDB.global) do
		if profile == "datatexts" and data then
			if data.customPanels then
				for _, customPanel in next, data.customPanels do
					if customPanel then
						customPanel["fonts"]["fontOutline"] = fontStyle
					end
				end
			end
		end
	end

	fontStyle = ElvUI_EltreumUI:FontFlag(fontStyle)
	if IsAddOnLoaded('NameplateSCT') then
		_G.NameplateSCTDB["global"]["fontFlag"] = ElvUI_EltreumUI:FontFlag(fontStyle)
	end

	if IsAddOnLoaded('ProjectAzilroka') then
		_G.ProjectAzilroka.db["iFilger"]["Enhancements"]["StatusBarFontFlag"] = fontStyle
		_G.ProjectAzilroka.db["iFilger"]["Enhancements"]["StackCountFontFlag"] = fontStyle
		_G.ProjectAzilroka.db["iFilger"]["FocusDebuffs"]["StatusBarFontFlag"] = fontStyle
		_G.ProjectAzilroka.db["iFilger"]["FocusDebuffs"]["StackCountFontFlag"] = fontStyle
		_G.ProjectAzilroka.db["iFilger"]["RaidDebuffs"]["StatusBarFontFlag"] = fontStyle
		_G.ProjectAzilroka.db["iFilger"]["RaidDebuffs"]["StackCountFontFlag"] = fontStyle
		_G.ProjectAzilroka.db["iFilger"]["TargetDebuffs"]["StatusBarFontFlag"] = fontStyle
		_G.ProjectAzilroka.db["iFilger"]["TargetDebuffs"]["StackCountFontFlag"] = fontStyle
		_G.ProjectAzilroka.db["iFilger"]["FocusBuffs"]["StatusBarFontFlag"] = fontStyle
		_G.ProjectAzilroka.db["iFilger"]["FocusBuffs"]["StackCountFontFlag"] = fontStyle
		_G.ProjectAzilroka.db["iFilger"]["Procs"]["StatusBarFontFlag"] = fontStyle
		_G.ProjectAzilroka.db["iFilger"]["Procs"]["StackCountFontFlag"] = fontStyle
		_G.ProjectAzilroka.db["iFilger"]["Cooldowns"]["StatusBarFontFlag"] = fontStyle
		_G.ProjectAzilroka.db["iFilger"]["Cooldowns"]["StackCountFontFlag"] = fontStyle
		_G.ProjectAzilroka.db["iFilger"]["Buffs"]["StatusBarFontFlag"] = fontStyle
		_G.ProjectAzilroka.db["iFilger"]["Buffs"]["StackCountFontFlag"] = fontStyle
		_G.ProjectAzilroka.db["iFilger"]["ItemCooldowns"]["StatusBarFontFlag"] = fontStyle
		_G.ProjectAzilroka.db["iFilger"]["ItemCooldowns"]["StackCountFontFlag"] = fontStyle
		_G.ProjectAzilroka.db["BrokerLDB"]["FontFlag"] = fontStyle
		_G.ProjectAzilroka.db["MasterExperience"]["FontFlag"] = fontStyle

		_G.ProjectAzilroka.db["stAddonManager"]["FontFlag"] = fontStyle
	end

	if IsAddOnLoaded('AddOnSkins') then
		local AS = unpack(AddOnSkins)
		AS["DBMFontFlag"] = fontStyle
		AS["FontFlag"] =  fontStyle
	end

	if IsAddOnLoaded("Questie") then
		local profile = _G.QuestieConfig["profileKeys"][E.mynameRealm]
		_G.QuestieConfig["profiles"][profile]["trackerFontOutline"] = ElvUI_EltreumUI:FontFlag(fontStyle)
	end

	if IsAddOnLoaded("ElvUI_SLE") then
		E.db["sle"]["armory"]["stats"]["statLabels"]["outline"] = fontStyle
		E.db["sle"]["armory"]["stats"]["itemLevel"]["outline"] = fontStyle
		E.db["sle"]["armory"]["stats"]["statHeaders"]["outline"] = fontStyle
		E.db["sle"]["media"]["fonts"]["mail"]["fontOutline"] = fontStyle
		E.db["sle"]["media"]["fonts"]["objective"]["fontOutline"] = fontStyle
		E.db["sle"]["media"]["fonts"]["objectiveHeader"]["fontOutline"] = fontStyle
		E.db["sle"]["media"]["fonts"]["questFontSuperHuge"]["fontOutline"] = fontStyle
		E.db["sle"]["media"]["fonts"]["scenarioStage"]["HeaderText"]["fontOutline"] = fontStyle
		E.db["sle"]["media"]["fonts"]["scenarioStage"]["TimerText"]["fontOutline"] = fontStyle
		E.db["sle"]["minimap"]["coords"]["fontOutline"] = fontStyle
		E.db["sle"]["minimap"]["instance"]["fontOutline"] = fontStyle
		E.db["sle"]["minimap"]["locPanel"]["fontOutline"] = fontStyle
		E.db["sle"]["nameplates"]["targetcount"]["fontOutline"] = fontStyle
		E.db["sle"]["skins"]["merchant"]["list"]["subOutline"] = fontStyle
		E.db["sle"]["actionbar"]["vehicle"]["hotkeyFontOutline"] = fontStyle
		E.db["sle"]["actionbar"]["vehicle"]["macroFontOutline"] = fontStyle
		E.db["sle"]["nameplates"]["targetcount"]["fontOutline"] = fontStyle
		E.db["sle"]["nameplates"]["threat"]["fontOutline"] = fontStyle
	end
	if IsAddOnLoaded("ElvUI_WindTools") then
		E.private["WT"]["quest"]["objectiveTracker"]["header"]["style"] = fontStyle
		E.private["WT"]["quest"]["objectiveTracker"]["info"]["style"] = fontStyle
		E.private["WT"]["quest"]["objectiveTracker"]["title"]["style"] = fontStyle
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["bindFont"]["style"] = fontStyle
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["countFont"]["style"] = fontStyle
		E.db["WT"]["misc"]["gameBar"]["additionalText"]["font"]["style"] = fontStyle
		E.db["WT"]["misc"]["gameBar"]["time"]["font"]["style"] = fontStyle
		E.db["WT"]["item"]["itemLevel"]["flyout"]["font"]["style"] = fontStyle
		E.db["WT"]["item"]["itemLevel"]["scrappingMachine"]["font"]["style"] = fontStyle
		E.private["WT"]["skins"]["bigWigsSkin"]["queueTimer"]["countDown"]["style"] = fontStyle
		E.private["WT"]["skins"]["rollResult"]["style"] = fontStyle
	end
	if IsAddOnLoaded("ElvUI_mMediaTag") then
		E.db["mMT"]["dockdatatext"]["fontflag"] = fontStyle
		E.db["mMT"]["objectivetracker"]["font"]["fontflag"] = fontStyle
	end
end
