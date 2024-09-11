local E, L = unpack(ElvUI)
local _G = _G
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded

function ElvUI_EltreumUI:SetupFont(fontvalue, custom)

	-- General
	E.db["general"]["altPowerBar"]["font"] = fontvalue
	E.db["general"]["itemLevel"]["itemLevelFont"] = fontvalue
	E.db["general"]["font"] = fontvalue
	E.db["general"]["minimap"]["locationFont"] = fontvalue
	E.db["general"]["minimap"]["timeFont"] = fontvalue
	E.db["general"]["queueStatus"]["font"] = fontvalue
	E.db["general"]["totems"]["font"] = fontvalue
	E.db["general"]["addonCompartment"]["font"] = fontvalue
	E.db["general"]["guildBank"]["countFont"] = fontvalue
	E.db["general"]["guildBank"]["itemLevelFontOutline"] = fontvalue
	E.db["general"]["fonts"]["worldsubzone"]["font"] = fontvalue
	E.db["general"]["fonts"]["worldzone"]["font"] = fontvalue
	E.db["general"]["fonts"]["pvpsubzone"]["font"] = fontvalue
	E.db["general"]["fonts"]["pvpzone"]["font"] = fontvalue
	E.db["general"]["fonts"]["objective"]["font"] = fontvalue
	E.db["general"]["fonts"]["questtitle"]["font"] = fontvalue
	E.db["general"]["fonts"]["questtext"]["font"] = fontvalue
	E.db["general"]["fonts"]["questsmall"]["font"] = fontvalue
	E.db["general"]["fonts"]["cooldown"]["font"] = fontvalue
	E.db["general"]["fonts"]["errortext"]["font"] = fontvalue
	E.db["general"]["fonts"]["mailbody"]["font"] = fontvalue
	E.db["general"]["fonts"]["talkingtext"]["font"] = fontvalue
	E.db["general"]["fonts"]["talkingtitle"]["font"] = fontvalue
	E.db["general"]["itemLevel"]["totalLevelFont"] = fontvalue

	-- Private
	E.private["general"]["chatBubbleFont"] = fontvalue
	E.private["general"]["dmgfont"] = fontvalue
	E.private["general"]["namefont"] = fontvalue
	E.private["general"]["nameplateFont"] = fontvalue
	E.private["general"]["nameplateLargeFont"] = fontvalue

	-- Auras
	E.db["auras"]["buffs"]["countFont"] = fontvalue
	E.db["auras"]["buffs"]["timeFont"] = fontvalue
	E.db["auras"]["debuffs"]["countFont"] = fontvalue
	E.db["auras"]["debuffs"]["timeFont"] = fontvalue

	-- Bags
	E.db["bags"]["countFont"] = fontvalue
	E.db["bags"]["itemInfoFont"] = fontvalue
	E.db["bags"]["itemLevelFont"] = fontvalue
	E.db["bags"]["cooldown"]["fonts"]["font"] = fontvalue

	-- Chat
	E.db["chat"]["font"] = fontvalue
	E.db["chat"]["tabFont"] = fontvalue

	-- Cooldown
	E.db["cooldown"]["fonts"]["font"] = fontvalue
	E.db["WeakAuras"]["cooldown"]["fonts"]["font"] = fontvalue

	-- Databars
	E.db["databars"]["honor"]["font"] = fontvalue
	E.db["databars"]["azerite"]["font"] = fontvalue
	E.db["databars"]["experience"]["font"] = fontvalue
	E.db["databars"]["reputation"]["font"] = fontvalue
	E.db["databars"]["threat"]["font"] = fontvalue

	-- Datatexts
	E.db["datatexts"]["font"] = fontvalue

	--Tooltip
	E.db["tooltip"]["font"] = fontvalue
	E.db["tooltip"]["healthBar"]["font"] = fontvalue
	E.db["tooltip"]["headerFont"] = fontvalue

	--ActionBars
	E.db["actionbar"]["cooldown"]["fonts"]["font"] = fontvalue
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
	E.db["actionbar"]["extraActionButton"]["hotkeyFont"] = fontvalue
	E.db["actionbar"]["font"] = fontvalue
	E.db["actionbar"]["stanceBar"]["hotkeyFont"] = fontvalue
	E.db["actionbar"]["vehicleExitButton"]["hotkeyFont"] = fontvalue

	--Nameplates
	E.db["nameplates"]["cooldown"]["fonts"]["font"] = fontvalue
	E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["countFont"] = fontvalue
	E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["font"] = fontvalue
	E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["countFont"] = fontvalue
	E.db["nameplates"]["units"]["ENEMY_NPC"]["health"]["text"]["font"] = fontvalue
	E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["font"] = fontvalue
	E.db["nameplates"]["units"]["ENEMY_NPC"]["name"]["font"] = fontvalue
	E.db["nameplates"]["units"]["ENEMY_NPC"]["power"]["text"]["font"] = fontvalue
	E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["font"] = fontvalue
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
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["font"] = fontvalue
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

	-- Unitframes
	E.db["unitframe"]["font"] = fontvalue
	E.db["unitframe"]["cooldown"]["fonts"]["font"] = fontvalue
	E.db["unitframe"]["units"]["arena"]["buffs"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["arena"]["debuffs"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["arena"]["castbar"]["customTimeFont"]["font"] = fontvalue
	E.db["unitframe"]["units"]["arena"]["castbar"]["customTextFont"]["font"] = fontvalue
	E.db["unitframe"]["units"]["assist"]["buffs"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["assist"]["debuffs"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["assist"]["rdebuffs"]["font"] = fontvalue
	E.db["unitframe"]["units"]["assist"]["buffIndicator"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["boss"]["buffs"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["boss"]["debuffs"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["boss"]["castbar"]["customTimeFont"]["font"] = fontvalue
	E.db["unitframe"]["units"]["boss"]["castbar"]["customTextFont"]["font"] = fontvalue
	E.db["unitframe"]["units"]["focus"]["buffs"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["focus"]["debuffs"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["focus"]["castbar"]["customTimeFont"]["font"] = fontvalue
	E.db["unitframe"]["units"]["focus"]["castbar"]["customTextFont"]["font"] = fontvalue
	E.db["unitframe"]["units"]["focus"]["buffIndicator"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["focustarget"]["buffs"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["focustarget"]["debuffs"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["party"]["buffs"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["party"]["debuffs"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["font"] = fontvalue
	E.db["unitframe"]["units"]["party"]["castbar"]["customTextFont"]["font"] = fontvalue
	E.db["unitframe"]["units"]["party"]["castbar"]["customTimeFont"]["font"] = fontvalue
	E.db["unitframe"]["units"]["party"]["buffIndicator"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["party"]["petsGroup"]["buffIndicator"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["player"]["buffs"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["player"]["debuffs"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["player"]["castbar"]["customTimeFont"]["font"] = fontvalue
	E.db["unitframe"]["units"]["player"]["castbar"]["customTextFont"]["font"] = fontvalue
	E.db["unitframe"]["units"]["player"]["buffIndicator"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["raid1"]["buffs"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["raid1"]["debuffs"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["raid1"]["rdebuffs"]["font"] = fontvalue
	E.db["unitframe"]["units"]["raid1"]["buffIndicator"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["raid2"]["buffs"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["raid2"]["debuffs"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["raid2"]["rdebuffs"]["font"] = fontvalue
	E.db["unitframe"]["units"]["raid2"]["buffIndicator"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["raid3"]["buffs"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["raid3"]["debuffs"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["raid3"]["rdebuffs"]["font"] = fontvalue
	E.db["unitframe"]["units"]["raid3"]["buffIndicator"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["tank"]["buffs"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["tank"]["debuffs"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["tank"]["rdebuffs"]["font"] = fontvalue
	E.db["unitframe"]["units"]["tank"]["buffIndicator"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["target"]["buffs"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["target"]["debuffs"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["target"]["castbar"]["customTimeFont"]["font"] = fontvalue
	E.db["unitframe"]["units"]["target"]["castbar"]["customTextFont"]["font"] = fontvalue
	E.db["unitframe"]["units"]["target"]["buffIndicator"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["targettarget"]["buffs"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["targettarget"]["debuffs"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["targettargettarget"]["buffs"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["targettargettarget"]["debuffs"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["pet"]["buffs"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["pet"]["debuffs"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["pet"]["castbar"]["customTimeFont"]["font"] = fontvalue
	E.db["unitframe"]["units"]["pet"]["castbar"]["customTextFont"]["font"] = fontvalue
	E.db["unitframe"]["units"]["pet"]["buffIndicator"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["pettarget"]["buffs"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["pettarget"]["debuffs"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["raidpet"]["buffIndicator"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["raidpet"]["buffs"]["countFont"] = fontvalue
	E.db["unitframe"]["units"]["raidpet"]["debuffs"]["countFont"] = fontvalue

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
										customText["font"] = fontvalue
									end
								end
							end
						end
						if data.unitframe.units.target then
							if data.unitframe.units.target.customTexts then
								for _, customText in next, data.unitframe.units.target.customTexts do
									if customText then
										customText["font"] = fontvalue
									end
								end
							end
						end
						if data.unitframe.units.targettarget then
							if data.unitframe.units.targettarget.customTexts then
								for _, customText in next, data.unitframe.units.targettarget.customTexts do
									if customText then
										customText["font"] = fontvalue
									end
								end
							end
						end
						if data.unitframe.units.targettargettarget then
							if data.unitframe.units.targettargettarget.customTexts then
								for _, customText in next, data.unitframe.units.targettargettarget.customTexts do
									if customText then
										customText["font"] = fontvalue
									end
								end
							end
						end
						if data.unitframe.units.pet then
							if data.unitframe.units.pet.customTexts then
								for _, customText in next, data.unitframe.units.pet.customTexts do
									if customText then
										customText["font"] = fontvalue
									end
								end
							end
						end
						if data.unitframe.units.pettarget then
							if data.unitframe.units.pettarget.customTexts then
								for _, customText in next, data.unitframe.units.pettarget.customTexts do
									if customText then
										customText["font"] = fontvalue
									end
								end
							end
						end
						if data.unitframe.units.focus then
							if data.unitframe.units.focus.customTexts then
								for _, customText in next, data.unitframe.units.focus.customTexts do
									if customText then
										customText["font"] = fontvalue
									end
								end
							end
						end
						if data.unitframe.units.focustarget then
							if data.unitframe.units.focustarget.customTexts then
								for _, customText in next, data.unitframe.units.focustarget.customTexts do
									if customText then
										customText["font"] = fontvalue
									end
								end
							end
						end
						if data.unitframe.units.arena then
							if data.unitframe.units.arena.customTexts then
								for _, customText in next, data.unitframe.units.arena.customTexts do
									if customText then
										customText["font"] = fontvalue
									end
								end
							end
						end
						if data.unitframe.units.boss then
							if data.unitframe.units.boss.customTexts then
								for _, customText in next, data.unitframe.units.boss.customTexts do
									if customText then
										customText["font"] = fontvalue
									end
								end
							end
						end
						if data.unitframe.units.party then
							if data.unitframe.units.party.customTexts then
								for _, customText in next, data.unitframe.units.party.customTexts do
									if customText then
										customText["font"] = fontvalue
									end
								end
							end
						end
						if data.unitframe.units.raid1 then
							if data.unitframe.units.raid1.customTexts then
								for _, customText in next, data.unitframe.units.raid1.customTexts do
									if customText then
										customText["font"] = fontvalue
									end
								end
							end
						end
						if data.unitframe.units.raid2 then
							if data.unitframe.units.raid2.customTexts then
								for _, customText in next, data.unitframe.units.raid2.customTexts do
									if customText then
										customText["font"] = fontvalue
									end
								end
							end
						end
						if data.unitframe.units.raid3 then
							if data.unitframe.units.raid3.customTexts then
								for _, customText in next, data.unitframe.units.raid3.customTexts do
									if customText then
										customText["font"] = fontvalue
									end
								end
							end
						end
						if data.unitframe.units.raidpet then
							if data.unitframe.units.raidpet.customTexts then
								for _, customText in next, data.unitframe.units.raidpet.customTexts do
									if customText then
										customText["font"] = fontvalue
									end
								end
							end
						end
						if data.unitframe.units.tank then
							if data.unitframe.units.tank.customTexts then
								for _, customText in next, data.unitframe.units.tank.customTexts do
									if customText then
										customText["font"] = fontvalue
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
						customPanel["fonts"]["font"] = fontvalue
					end
				end
			end
		end
	end

	--FCT font
	if IsAddOnLoaded("ElvUI_FCT") then
		_G.ElvFCT["nameplates"]["frames"]["Player"]["font"] = fontvalue
		_G.ElvFCT["nameplates"]["frames"]["Player"]["critFont"] = fontvalue
		_G.ElvFCT["nameplates"]["frames"]["FriendlyPlayer"]["font"] = fontvalue
		_G.ElvFCT["nameplates"]["frames"]["FriendlyPlayer"]["critFont"] = fontvalue
		_G.ElvFCT["nameplates"]["frames"]["FriendlyNPC"]["font"] = fontvalue
		_G.ElvFCT["nameplates"]["frames"]["FriendlyNPC"]["critFont"] = fontvalue
		_G.ElvFCT["nameplates"]["frames"]["EnemyNPC"]["font"] = fontvalue
		_G.ElvFCT["nameplates"]["frames"]["EnemyNPC"]["critFont"] = fontvalue
		_G.ElvFCT["nameplates"]["frames"]["EnemyPlayer"]["font"] = fontvalue
		_G.ElvFCT["nameplates"]["frames"]["EnemyPlayer"]["critFont"] = fontvalue
		_G.ElvFCT["unitframes"]["frames"]["Player"]["font"] = fontvalue
		_G.ElvFCT["unitframes"]["frames"]["Player"]["critFont"] = fontvalue
		_G.ElvFCT["unitframes"]["frames"]["Target"]["font"] = fontvalue
		_G.ElvFCT["unitframes"]["frames"]["Target"]["critFont"] = fontvalue
		_G.ElvFCT["unitframes"]["frames"]["TargetTarget"]["font"] = fontvalue
		_G.ElvFCT["unitframes"]["frames"]["TargetTarget"]["critFont"] = fontvalue
		_G.ElvFCT["unitframes"]["frames"]["TargetTargetTarget"]["font"] = fontvalue
		_G.ElvFCT["unitframes"]["frames"]["TargetTargetTarget"]["critFont"] = fontvalue
		_G.ElvFCT["unitframes"]["frames"]["Focus"]["font"] = fontvalue
		_G.ElvFCT["unitframes"]["frames"]["Focus"]["critFont"] = fontvalue
		_G.ElvFCT["unitframes"]["frames"]["FocusTarget"]["font"] = fontvalue
		_G.ElvFCT["unitframes"]["frames"]["FocusTarget"]["critFont"] = fontvalue
		_G.ElvFCT["unitframes"]["frames"]["Pet"]["font"] = fontvalue
		_G.ElvFCT["unitframes"]["frames"]["Pet"]["critFont"] = fontvalue
		_G.ElvFCT["unitframes"]["frames"]["PetTarget"]["font"] = fontvalue
		_G.ElvFCT["unitframes"]["frames"]["PetTarget"]["critFont"] = fontvalue
		_G.ElvFCT["unitframes"]["frames"]["Tank"]["font"] = fontvalue
		_G.ElvFCT["unitframes"]["frames"]["Tank"]["critFont"] = fontvalue
		_G.ElvFCT["unitframes"]["frames"]["Assist"]["font"] = fontvalue
		_G.ElvFCT["unitframes"]["frames"]["Assist"]["critFont"] = fontvalue
		_G.ElvFCT["unitframes"]["frames"]["Boss"]["font"] = fontvalue
		_G.ElvFCT["unitframes"]["frames"]["Boss"]["critFont"] = fontvalue
		_G.ElvFCT["unitframes"]["frames"]["Raid1"]["font"] = fontvalue
		_G.ElvFCT["unitframes"]["frames"]["Raid1"]["critFont"] = fontvalue
		_G.ElvFCT["unitframes"]["frames"]["Raid2"]["font"] = fontvalue
		_G.ElvFCT["unitframes"]["frames"]["Raid2"]["critFont"] = fontvalue
		_G.ElvFCT["unitframes"]["frames"]["Raid3"]["font"] = fontvalue
		_G.ElvFCT["unitframes"]["frames"]["Raid3"]["critFont"] = fontvalue
		_G.ElvFCT["unitframes"]["frames"]["RaidPet"]["font"] = fontvalue
		_G.ElvFCT["unitframes"]["frames"]["RaidPet"]["critFont"] = fontvalue
		_G.ElvFCT["unitframes"]["frames"]["Party"]["font"] = fontvalue
		_G.ElvFCT["unitframes"]["frames"]["Party"]["critFont"] = fontvalue
		_G.ElvFCT["unitframes"]["frames"]["Arena"]["font"] = fontvalue
		_G.ElvFCT["unitframes"]["frames"]["Arena"]["critFont"] = fontvalue
	end

	if IsAddOnLoaded('NameplateSCT') then
		_G.NameplateSCTDB["global"]["font"] = fontvalue
	end

	if IsAddOnLoaded('ProjectAzilroka') then
		local PAprofile = ProjectAzilrokaDB["profileKeys"][E.mynameRealm]
		ProjectAzilrokaDB["profiles"][PAprofile]["stAddonManager"]["Font"] = fontvalue
		if ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["Enable"] then
			ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["Enhancements"]["StackCountFont"] = fontvalue
			ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["Enhancements"]["StatusBarFont"] = fontvalue
			ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["FocusDebuffs"]["StackCountFont"] = fontvalue
			ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["FocusDebuffs"]["StatusBarFont"] = fontvalue
			ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["RaidDebuffs"]["StackCountFont"] = fontvalue
			ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["RaidDebuffs"]["StatusBarFont"] = fontvalue
			ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["TargetDebuffs"]["StackCountFont"] = fontvalue
			ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["TargetDebuffs"]["StatusBarFont"] = fontvalue
			ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["FocusBuffs"]["StackCountFont"] = fontvalue
			ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["FocusBuffs"]["StatusBarFont"] = fontvalue
			ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["Procs"]["StackCountFont"] = fontvalue
			ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["Procs"]["StatusBarFont"] = fontvalue
			ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["Cooldowns"]["StackCountFont"] = fontvalue
			ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["Cooldowns"]["StatusBarFont"] = fontvalue
			ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["Buffs"]["StackCountFont"] = fontvalue
			ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["Buffs"]["StatusBarFont"] = fontvalue
			ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["ItemCooldowns"]["StackCountFont"] = fontvalue
			ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["ItemCooldowns"]["StatusBarFont"] = fontvalue
		end
		if ProjectAzilrokaDB["profiles"][PAprofile]["BrokerLDB"] then
			ProjectAzilrokaDB["profiles"][PAprofile]["BrokerLDB"]["Font"] = fontvalue
		end
		if ProjectAzilrokaDB["profiles"][PAprofile]["MasterExperience"] then
			ProjectAzilrokaDB["profiles"][PAprofile]["MasterExperience"]["Font"] = fontvalue
		end
	end

	if IsAddOnLoaded('AddOnSkins') then
		local AS = unpack(AddOnSkins)
		AS.db["DBMFont"] = fontvalue
		AS.db["Font"] = fontvalue
	end

	if IsAddOnLoaded("Questie") then
		local profile = _G.QuestieConfig["profileKeys"][E.mynameRealm]
		_G.QuestieConfig["profiles"][profile]["trackerFontObjective"] = fontvalue
		_G.QuestieConfig["profiles"][profile]["trackerFontZone"] = fontvalue
		_G.QuestieConfig["profiles"][profile]["trackerFontHeader"] = fontvalue
		_G.QuestieConfig["profiles"][profile]["trackerFontQuest"] = fontvalue
	end

	if IsAddOnLoaded("ElvUI_SLE") then
		E.db["sle"]["armory"]["character"]["durability"]["font"] = fontvalue
		E.db["sle"]["armory"]["character"]["enchant"]["font"] = fontvalue
		E.db["sle"]["armory"]["character"]["ilvl"]["font"] = fontvalue
		E.db["sle"]["armory"]["inspect"]["enchant"]["font"] = fontvalue
		E.db["sle"]["armory"]["inspect"]["ilvl"]["font"] = fontvalue
		E.db["sle"]["armory"]["stats"]["statLabels"]["font"] = fontvalue
		E.db["sle"]["armory"]["stats"]["itemLevel"]["font"] = fontvalue
		E.db["sle"]["armory"]["stats"]["statHeaders"]["font"] = fontvalue
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
		E.db["sle"]["actionbar"]["vehicle"]["hotkeyFont"] = fontvalue
		E.db["sle"]["actionbar"]["vehicle"]["macroFont"] = fontvalue
		E.db["sle"]["nameplates"]["targetcount"]["font"] = fontvalue
		E.db["sle"]["nameplates"]["threat"]["font"] = fontvalue
	end

	if IsAddOnLoaded("ElvUI_WindTools") then
		E.private["WT"]["skins"]["ime"]["label"]["name"] = fontvalue
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["bindFont"]["name"] = fontvalue
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["countFont"]["name"] = fontvalue
		E.db["WT"]["item"]["inspect"]["levelText"]["name"] = fontvalue
		E.db["WT"]["misc"]["gameBar"]["additionalText"]["font"]["name"] = fontvalue
		E.db["WT"]["misc"]["gameBar"]["time"]["font"]["name"] = fontvalue
		E.db["WT"]["item"]["itemLevel"]["flyout"]["font"]["name"] = fontvalue
		E.db["WT"]["item"]["itemLevel"]["scrappingMachine"]["font"]["name"] = fontvalue
		E.private["WT"]["skins"]["bigWigsSkin"]["queueTimer"]["countDown"]["name"] = fontvalue
		E.private["WT"]["skins"]["rollResult"]["name"] = fontvalue
	end

	if IsAddOnLoaded("ElvUI_mMediaTag") then
		E.db["mMT"]["dockdatatext"]["font"] = fontvalue
		E.db["mMT"]["objectivetracker"]["font"]["font"] = fontvalue
	end

	E:StaggeredUpdateAll()

	if custom then
		ElvUI_EltreumUI:Print(L["Your custom font has been set."])
	else
		ElvUI_EltreumUI:Print(fontvalue.." "..L["Font has been set."])
	end

	ElvUI_EltreumUI:ResolutionOutline()
end
