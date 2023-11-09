local E, L = unpack(ElvUI)
local _G = _G
local IsAddOnLoaded = _G.IsAddOnLoaded --TODO 10.2, might need C_AddOns.

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
			if IsAddOnLoaded("ElvUI_SLE") then --TODO 10.2, might need C_AddOns.
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
			if IsAddOnLoaded("ElvUI_WindTools") then --TODO 10.2, might need C_AddOns.
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
			E.db["general"]["queueStatus"]["font"] = fontvalue
		end
		if E.Wrath then
			E.db["general"]["totems"]["font"] = fontvalue
		end
		E.db["general"]["addonCompartment"]["font"] = fontvalue
		E.db["general"]["guildBank"]["countFont"] = fontvalue
		E.db["general"]["guildBank"]["itemLevelFontOutline"] = fontvalue
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
		E.db["unitframe"]["units"]["pet"]["buffs"]["countFont"] = fontvalue
		E.db["unitframe"]["units"]["pet"]["debuffs"]["countFont"] = fontvalue

		E.private["general"]["nameplateFont"] = fontvalue
		E.private["general"]["nameplateLargeFont"] = fontvalue
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

		-- Custom Texts
		local currentprofile
		for character, charprofile in pairs (ElvDB.profileKeys) do
			if character:match(E.myname) then
				currentprofile = charprofile
			end
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

		if E.db["datatexts"]["panels"]["EltruismTime"] and E.db["datatexts"]["panels"]["EltruismTime"]["enable"] then
			E.global["datatexts"]["customPanels"]["EltruismTime"]["fonts"]["font"] = fontvalue
		end

	--FCT font
	if IsAddOnLoaded("ElvUI_FCT") then --TODO 10.2, might need C_AddOns.
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
	if IsAddOnLoaded('NameplateSCT') then --TODO 10.2, might need C_AddOns.
		_G.NameplateSCTDB["global"]["font"] = fontvalue
	end

	if IsAddOnLoaded('ProjectAzilroka') then --TODO 10.2, might need C_AddOns.
		_G.ProjectAzilroka.db["stAddonManager"]["Font"] = fontvalue
	end

	if IsAddOnLoaded("Questie") then --TODO 10.2, might need C_AddOns.
		_G.QuestieConfig["global"]["trackerFontObjective"] = E.db.general.font
		_G.QuestieConfig["global"]["trackerFontZone"] = E.db.general.font
		_G.QuestieConfig["global"]["trackerFontHeader"] = E.db.general.font
		_G.QuestieConfig["global"]["trackerFontQuest"] = E.db.general.font
	end

	E:StaggeredUpdateAll()

	if custom then
		ElvUI_EltreumUI:Print(L["Your custom font has been set."])
	else
		ElvUI_EltreumUI:Print(fontvalue.." "..L["Font has been set."])
	end

	ElvUI_EltreumUI:ResolutionOutline()
end
