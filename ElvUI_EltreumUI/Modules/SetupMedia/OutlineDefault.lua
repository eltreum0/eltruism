local E = unpack(ElvUI)
local _G = _G
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded

function ElvUI_EltreumUI:SetupFontsOutlineDefault()
	if IsAddOnLoaded("ElvUI_SLE") then
		E.db["sle"]["armory"]["stats"]["statLabels"]["outline"] = "THICKOUTLINE"
		E.db["sle"]["armory"]["stats"]["itemLevel"]["outline"] = "THICKOUTLINE"
		E.db["sle"]["armory"]["stats"]["statHeaders"]["outline"] = "THICKOUTLINE"
		E.db["sle"]["minimap"]["coords"]["fontOutline"] = "THICKOUTLINE"
		E.db["sle"]["minimap"]["instance"]["fontOutline"] = "THICKOUTLINE"
		E.db["sle"]["minimap"]["locPanel"]["fontOutline"] = "THICKOUTLINE"
		E.db["sle"]["nameplates"]["targetcount"]["fontOutline"] = "THICKOUTLINE"
		E.db["sle"]["skins"]["merchant"]["list"]["subOutline"] = "THICKOUTLINE"
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
	E.db["general"]["altPowerBar"]["fontOutline"] = "THICKOUTLINE"
	E.db["databars"]["azerite"]["fontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["extraActionButton"]["hotkeyFontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["player"]["castbar"]["customTimeFont"]["fontStyle"] = "THICKOUTLINE"
	if IsAddOnLoaded('ProjectAzilroka') then
		local PAprofile = ProjectAzilrokaDB["profileKeys"][E.mynameRealm]
		if ProjectAzilrokaDB["profiles"][PAprofile]["stAddonManager"] then
			ProjectAzilrokaDB["profiles"][PAprofile]["stAddonManager"]["FontFlag"] = fontStyle
		end
	end
	E.db["general"]["fontStyle"] = "OUTLINE"
	E.db["general"]["minimap"]["locationFontOutline"] = "THICKOUTLINE"
	if E.Retail then
		E.db["general"]["queueStatus"]["fontOutline"] = "OUTLINE"
	end
	if E.Cata then
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
	E.db["general"]["itemLevel"]["totalLevelFontOutline"] = "OUTLINE"

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
										customText["fontOutline"] = "THICKOUTLINE"
									end
								end
							end
						end
						if data.unitframe.units.target then
							if data.unitframe.units.target.customTexts then
								for _, customText in next, data.unitframe.units.target.customTexts do
									if customText then
										customText["fontOutline"] = "THICKOUTLINE"
									end
								end
							end
						end
						if data.unitframe.units.targettarget then
							if data.unitframe.units.targettarget.customTexts then
								for _, customText in next, data.unitframe.units.targettarget.customTexts do
									if customText then
										customText["fontOutline"] = "THICKOUTLINE"
									end
								end
							end
						end
						if data.unitframe.units.targettargettarget then
							if data.unitframe.units.targettargettarget.customTexts then
								for _, customText in next, data.unitframe.units.targettargettarget.customTexts do
									if customText then
										customText["fontOutline"] = "THICKOUTLINE"
									end
								end
							end
						end
						if data.unitframe.units.pet then
							if data.unitframe.units.pet.customTexts then
								for _, customText in next, data.unitframe.units.pet.customTexts do
									if customText then
										customText["fontOutline"] = "THICKOUTLINE"
									end
								end
							end
						end
						if data.unitframe.units.pettarget then
							if data.unitframe.units.pettarget.customTexts then
								for _, customText in next, data.unitframe.units.pettarget.customTexts do
									if customText then
										customText["fontOutline"] = "THICKOUTLINE"
									end
								end
							end
						end
						if data.unitframe.units.focus then
							if data.unitframe.units.focus.customTexts then
								for _, customText in next, data.unitframe.units.focus.customTexts do
									if customText then
										customText["fontOutline"] = "THICKOUTLINE"
									end
								end
							end
						end
						if data.unitframe.units.focustarget then
							if data.unitframe.units.focustarget.customTexts then
								for _, customText in next, data.unitframe.units.focustarget.customTexts do
									if customText then
										customText["fontOutline"] = "THICKOUTLINE"
									end
								end
							end
						end
						if data.unitframe.units.arena then
							if data.unitframe.units.arena.customTexts then
								for _, customText in next, data.unitframe.units.arena.customTexts do
									if customText then
										customText["fontOutline"] = "THICKOUTLINE"
									end
								end
							end
						end
						if data.unitframe.units.boss then
							if data.unitframe.units.boss.customTexts then
								for _, customText in next, data.unitframe.units.boss.customTexts do
									if customText then
										customText["fontOutline"] = "THICKOUTLINE"
									end
								end
							end
						end
						if data.unitframe.units.party then
							if data.unitframe.units.party.customTexts then
								for _, customText in next, data.unitframe.units.party.customTexts do
									if customText then
										customText["fontOutline"] = "THICKOUTLINE"
									end
								end
							end
						end
						if data.unitframe.units.raid1 then
							if data.unitframe.units.raid1.customTexts then
								for _, customText in next, data.unitframe.units.raid1.customTexts do
									if customText then
										customText["fontOutline"] = "THICKOUTLINE"
									end
								end
							end
						end
						if data.unitframe.units.raid2 then
							if data.unitframe.units.raid2.customTexts then
								for _, customText in next, data.unitframe.units.raid2.customTexts do
									if customText then
										customText["fontOutline"] = "THICKOUTLINE"
									end
								end
							end
						end
						if data.unitframe.units.raid3 then
							if data.unitframe.units.raid3.customTexts then
								for _, customText in next, data.unitframe.units.raid3.customTexts do
									if customText then
										customText["fontOutline"] = "THICKOUTLINE"
									end
								end
							end
						end
						if data.unitframe.units.raidpet then
							if data.unitframe.units.raidpet.customTexts then
								for _, customText in next, data.unitframe.units.raidpet.customTexts do
									if customText then
										customText["fontOutline"] = "THICKOUTLINE"
									end
								end
							end
						end
						if data.unitframe.units.tank then
							if data.unitframe.units.tank.customTexts then
								for _, customText in next, data.unitframe.units.tank.customTexts do
									if customText then
										customText["fontOutline"] = "THICKOUTLINE"
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
						customPanel["fonts"]["fontOutline"] = "THICKOUTLINE"
					end
				end
			end
		end
	end
end
