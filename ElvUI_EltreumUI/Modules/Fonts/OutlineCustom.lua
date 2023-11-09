local E = unpack(ElvUI)
local _G = _G
local IsAddOnLoaded = _G.IsAddOnLoaded --TODO 10.2, might need C_AddOns.

function ElvUI_EltreumUI:SetupFontsOutlineCustom(fontStyle)
	if IsAddOnLoaded("ElvUI_SLE") then --TODO 10.2, might need C_AddOns.
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
	if IsAddOnLoaded("ElvUI_WindTools") then --TODO 10.2, might need C_AddOns.
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
	E.db["general"]["addonCompartment"]["fontOutline"] = fontStyle
	E.db["general"]["guildBank"]["countFontOutline"] = fontStyle
	E.db["general"]["guildBank"]["itemLevelFontOutline"] = fontStyle
	if E.Retail then
		E.db["general"]["queueStatus"]["fontOutline"] = fontStyle
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
	E.db["unitframe"]["units"]["pet"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["pet"]["debuffs"]["countFontOutline"] = fontStyle
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

	E.private["general"]["nameplateFontOutline"] = fontStyle
	E.private["general"]["nameplateLargeFontOutline"] = fontStyle
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

	if E.db["datatexts"]["panels"]["EltruismTime"] and E.db["datatexts"]["panels"]["EltruismTime"]["enable"] then
		E.global["datatexts"]["customPanels"]["EltruismTime"]["fonts"]["fontOutline"] = fontStyle
	end

	fontStyle = ElvUI_EltreumUI:FontFlag(fontStyle)
	if IsAddOnLoaded('NameplateSCT') then --TODO 10.2, might need C_AddOns.
		_G.NameplateSCTDB["global"]["fontFlag"] = fontStyle
	end

	if IsAddOnLoaded('ProjectAzilroka') then --TODO 10.2, might need C_AddOns.
		_G.ProjectAzilroka.db["stAddonManager"]["FontFlag"] = fontStyle
	end

	if IsAddOnLoaded("Questie") then --TODO 10.2, might need C_AddOns.
		QuestieConfig["global"]["trackerFontOutline"] = fontStyle
	end
end
