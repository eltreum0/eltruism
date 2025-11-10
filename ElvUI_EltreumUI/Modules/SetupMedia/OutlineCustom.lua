local E = unpack(ElvUI)
local _G = _G
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded

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
	E.db["general"]["itemLevel"]["totalLevelFontOutline"] = fontStyle

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
	E.db["unitframe"]["units"]["assist"]["auras"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["assist"]["auras"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["assist"]["buffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["assist"]["debuffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["assist"]["rdebuffs"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["assist"]["buffIndicator"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["assist"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["assist"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["party"]["auras"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["party"]["auras"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["party"]["buffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["party"]["debuffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["party"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["party"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["party"]["castbar"]["customTextFont"]["fontStyle"] = fontStyle
	E.db["unitframe"]["units"]["party"]["castbar"]["customTimeFont"]["fontStyle"] = fontStyle
	E.db["unitframe"]["units"]["party"]["buffIndicator"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["party"]["petsGroup"]["buffIndicator"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid1"]["auras"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid1"]["auras"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid1"]["buffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid1"]["debuffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid1"]["rdebuffs"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid1"]["buffIndicator"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid1"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid1"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid2"]["auras"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid2"]["auras"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid2"]["buffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid2"]["debuffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid2"]["rdebuffs"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid2"]["buffIndicator"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid2"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid2"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid3"]["auras"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid3"]["auras"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid3"]["buffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid3"]["debuffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid3"]["rdebuffs"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid3"]["buffIndicator"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid3"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raid3"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["tank"]["auras"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["tank"]["auras"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["tank"]["buffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["tank"]["debuffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["tank"]["rdebuffs"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["tank"]["buffIndicator"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["tank"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["tank"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["pet"]["auras"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["pet"]["auras"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["pet"]["buffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["pet"]["debuffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["pet"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["pet"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["pet"]["castbar"]["customTimeFont"]["fontStyle"] = fontStyle
	E.db["unitframe"]["units"]["pet"]["castbar"]["customTextFont"]["fontStyle"] = fontStyle
	E.db["unitframe"]["units"]["pet"]["buffIndicator"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["player"]["auras"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["player"]["auras"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["player"]["buffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["player"]["debuffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["player"]["castbar"]["customTimeFont"]["fontStyle"] = fontStyle
	E.db["unitframe"]["units"]["player"]["castbar"]["customTextFont"]["fontStyle"] = fontStyle
	E.db["unitframe"]["units"]["player"]["buffIndicator"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["player"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["player"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["target"]["auras"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["target"]["auras"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["target"]["buffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["target"]["debuffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["target"]["castbar"]["customTimeFont"]["fontStyle"] = fontStyle
	E.db["unitframe"]["units"]["target"]["castbar"]["customTextFont"]["fontStyle"] = fontStyle
	E.db["unitframe"]["units"]["target"]["buffIndicator"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["target"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["target"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["focus"]["auras"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["focus"]["auras"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["focus"]["buffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["focus"]["debuffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["focus"]["castbar"]["customTimeFont"]["fontStyle"] = fontStyle
	E.db["unitframe"]["units"]["focus"]["castbar"]["customTextFont"]["fontStyle"] = fontStyle
	E.db["unitframe"]["units"]["focus"]["buffIndicator"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["focus"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["focus"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["arena"]["auras"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["arena"]["auras"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["arena"]["buffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["arena"]["debuffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["arena"]["castbar"]["customTimeFont"]["fontStyle"] = fontStyle
	E.db["unitframe"]["units"]["arena"]["castbar"]["customTextFont"]["fontStyle"] = fontStyle
	E.db["unitframe"]["units"]["arena"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["arena"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["boss"]["auras"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["boss"]["auras"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["boss"]["buffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["boss"]["debuffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["boss"]["castbar"]["customTimeFont"]["fontStyle"] = fontStyle
	E.db["unitframe"]["units"]["boss"]["castbar"]["customTextFont"]["fontStyle"] = fontStyle
	E.db["unitframe"]["units"]["boss"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["boss"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["focustarget"]["auras"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["focustarget"]["auras"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["focustarget"]["buffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["focustarget"]["debuffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["focustarget"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["focustarget"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["pettarget"]["auras"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["pettarget"]["auras"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["pettarget"]["buffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["pettarget"]["debuffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["pettarget"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["pettarget"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raidpet"]["auras"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raidpet"]["auras"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raidpet"]["buffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raidpet"]["debuffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raidpet"]["buffIndicator"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raidpet"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["raidpet"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["targettarget"]["auras"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["targettarget"]["auras"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["targettarget"]["buffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["targettarget"]["debuffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["targettarget"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["targettarget"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["targettargettarget"]["auras"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["targettargettarget"]["auras"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["targettargettarget"]["buffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["targettargettarget"]["debuffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["unitframe"]["units"]["targettargettarget"]["buffs"]["countFontOutline"] = fontStyle
	E.db["unitframe"]["units"]["targettargettarget"]["debuffs"]["countFontOutline"] = fontStyle

	-- Nameplates
	E.db["nameplates"]["cooldown"]["fonts"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["targetFontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_NPC"]["health"]["text"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_NPC"]["name"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["countFontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_NPC"]["power"]["text"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["castbar"]["targetFontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["name"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["title"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["buffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["buffs"]["countFontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["castbar"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["health"]["text"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["level"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["power"]["text"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["health"]["text"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["name"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["power"]["text"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["countFontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["title"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["buffs"]["sourceText"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["buffs"]["countFontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["castbar"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["debuffs"]["countFontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["health"]["text"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["level"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["name"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["title"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["power"]["text"]["fontOutline"] = fontStyle
	E.db["nameplates"]["units"]["PLAYER"]["castbar"]["targetFontOutline"] = fontStyle
	E.db["nameplates"]["units"]["PLAYER"]["buffs"]["sourceText"]["fontOutline"] = fontStyle
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

	if IsAddOnLoaded("ElvUI_SLE") then
		E.db["sle"]["armory"]["stats"]["statLabels"]["outline"] = fontStyle
		E.db["sle"]["armory"]["stats"]["itemLevel"]["outline"] = fontStyle
		E.db["sle"]["armory"]["stats"]["statHeaders"]["outline"] = fontStyle
		E.db["sle"]["armory"]["character"]["durability"]["fontStyle"] = fontStyle
		E.db["sle"]["armory"]["character"]["enchant"]["fontStyle"] = fontStyle
		E.db["sle"]["armory"]["character"]["ilvl"]["fontStyle"] = fontStyle
		E.db["sle"]["armory"]["inspect"]["enchant"]["fontStyle"] = fontStyle
		E.db["sle"]["armory"]["inspect"]["ilvl"]["fontStyle"] = fontStyle
		E.db["sle"]["minimap"]["coords"]["fontOutline"] = fontStyle
		E.db["sle"]["minimap"]["instance"]["fontOutline"] = fontStyle
		E.db["sle"]["minimap"]["locPanel"]["fontOutline"] = fontStyle
		E.db["sle"]["nameplates"]["targetcount"]["fontOutline"] = fontStyle
		E.db["sle"]["skins"]["merchant"]["list"]["subOutline"] = fontStyle
		E.db["sle"]["skins"]["merchant"]["list"]["nameOutline"] = fontStyle
		E.db["sle"]["actionbar"]["vehicle"]["hotkeyFontOutline"] = fontStyle
		E.db["sle"]["actionbar"]["vehicle"]["macroFontOutline"] = fontStyle
		E.db["sle"]["nameplates"]["targetcount"]["fontOutline"] = fontStyle
		E.db["sle"]["nameplates"]["threat"]["fontOutline"] = fontStyle
		E.db["sle"]["afk"]["defaultTexts"]["SL_ScrollFrame"]["outline"] = fontStyle
		E.db["sle"]["afk"]["defaultTexts"]["SL_SubText"]["outline"] = fontStyle
		E.db["sle"]["objectiveTracker"]["achievement"]["entryText"]["text"]["fontOutline"] = fontStyle
		E.db["sle"]["objectiveTracker"]["achievement"]["header"]["text"]["fontOutline"] = fontStyle
		E.db["sle"]["objectiveTracker"]["achievement"]["headerText"]["text"]["fontOutline"] = fontStyle
		E.db["sle"]["objectiveTracker"]["adventure"]["entryText"]["text"]["fontOutline"] = fontStyle
		E.db["sle"]["objectiveTracker"]["adventure"]["header"]["text"]["fontOutline"] = fontStyle
		E.db["sle"]["objectiveTracker"]["adventure"]["headerText"]["text"]["fontOutline"] = fontStyle
		E.db["sle"]["objectiveTracker"]["bonus"]["entryText"]["text"]["fontOutline"] = fontStyle
		E.db["sle"]["objectiveTracker"]["bonus"]["header"]["text"]["fontOutline"] = fontStyle
		E.db["sle"]["objectiveTracker"]["bonus"]["headerText"]["text"]["fontOutline"] = fontStyle
		E.db["sle"]["objectiveTracker"]["campaign"]["entryText"]["text"]["fontOutline"] = fontStyle
		E.db["sle"]["objectiveTracker"]["campaign"]["header"]["text"]["fontOutline"] = fontStyle
		E.db["sle"]["objectiveTracker"]["campaign"]["headerText"]["text"]["fontOutline"] = fontStyle
		E.db["sle"]["objectiveTracker"]["mainHeader"]["header"]["text"]["fontOutline"] = fontStyle
		E.db["sle"]["objectiveTracker"]["monthlyActivities"]["entryText"]["text"]["fontOutline"] = fontStyle
		E.db["sle"]["objectiveTracker"]["monthlyActivities"]["header"]["text"]["fontOutline"] = fontStyle
		E.db["sle"]["objectiveTracker"]["monthlyActivities"]["headerText"]["text"]["fontOutline"] = fontStyle
		E.db["sle"]["objectiveTracker"]["professionsReceipe"]["entryText"]["text"]["fontOutline"] = fontStyle
		E.db["sle"]["objectiveTracker"]["professionsReceipe"]["header"]["text"]["fontOutline"] = fontStyle
		E.db["sle"]["objectiveTracker"]["professionsReceipe"]["headerText"]["text"]["fontOutline"] = fontStyle
		E.db["sle"]["objectiveTracker"]["quest"]["entryText"]["text"]["fontOutline"] = fontStyle
		E.db["sle"]["objectiveTracker"]["quest"]["header"]["text"]["fontOutline"] = fontStyle
		E.db["sle"]["objectiveTracker"]["quest"]["headerText"]["text"]["fontOutline"] = fontStyle
		E.db["sle"]["objectiveTracker"]["quest"]["progressBar"]["text"]["fontOutline"] = fontStyle
		E.db["sle"]["objectiveTracker"]["scenario"]["entryText"]["text"]["fontOutline"] = fontStyle
		E.db["sle"]["objectiveTracker"]["scenario"]["header"]["text"]["fontOutline"] = fontStyle
		E.db["sle"]["objectiveTracker"]["scenario"]["headerText"]["text"]["fontOutline"] = fontStyle
		E.db["sle"]["objectiveTracker"]["uiWidgets"]["entryText"]["text"]["fontOutline"] = fontStyle
		E.db["sle"]["objectiveTracker"]["uiWidgets"]["header"]["text"]["fontOutline"] = fontStyle
		E.db["sle"]["objectiveTracker"]["uiWidgets"]["headerText"]["text"]["fontOutline"] = fontStyle
		E.db["sle"]["objectiveTracker"]["worldQuest"]["entryText"]["text"]["fontOutline"] = fontStyle
		E.db["sle"]["objectiveTracker"]["worldQuest"]["header"]["text"]["fontOutline"] = fontStyle
		E.db["sle"]["objectiveTracker"]["worldQuest"]["headerText"]["text"]["fontOutline"] = fontStyle
	end

	if IsAddOnLoaded("ElvUI_WindTools") then
		E.private["WT"]["quest"]["objectiveTracker"]["header"]["style"] = fontStyle
		E.private["WT"]["quest"]["objectiveTracker"]["info"]["style"] = fontStyle
		E.private["WT"]["quest"]["objectiveTracker"]["title"]["style"] = fontStyle
		E.private["WT"]["skins"]["bigWigsSkin"]["queueTimer"]["countDown"]["style"] = fontStyle
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["bindFont"]["style"] = fontStyle
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["countFont"]["style"] = fontStyle
		E.db["WT"]["item"]["itemLevel"]["flyout"]["font"]["style"] = fontStyle
		E.db["WT"]["item"]["itemLevel"]["scrappingMachine"]["font"]["style"] = fontStyle
		E.db["WT"]["item"]["inspect"]["levelText"]["style"] = fontStyle
		E.db["WT"]["item"]["inspect"]["enchantIcon"]["craftingTier"]["style"] = fontStyle
		E.db["WT"]["item"]["inspect"]["gemIcon"]["craftingTier"]["style"] = fontStyle
		E.db["WT"]["item"]["inspect"]["itemNameText"]["style"] = fontStyle
		E.db["WT"]["item"]["inspect"]["slotText"]["style"] = fontStyle
		E.db["WT"]["item"]["inspect"]["statistics"]["text"]["style"] = fontStyle
		E.db["WT"]["maps"]["eventTracker"]["font"]["outline"] = fontStyle
		E.db["WT"]["maps"]["whoClicked"]["font"]["style"] = fontStyle
		E.db["WT"]["misc"]["gameBar"]["additionalText"]["font"]["style"] = fontStyle
		E.db["WT"]["misc"]["gameBar"]["time"]["font"]["style"] = fontStyle
		E.db["WT"]["quest"]["switchButtons"]["font"]["style"] = fontStyle
		E.db["WT"]["social"]["friendList"]["infoFont"]["style"] = fontStyle
		E.db["WT"]["social"]["friendList"]["nameFont"]["style"] = fontStyle
	end
	if IsAddOnLoaded("ElvUI_mMediaTag") then
		E.db["mMT"]["dockdatatext"]["fontflag"] = fontStyle
		E.db["mMT"]["objectivetracker"]["font"]["fontflag"] = fontStyle
	end

	fontStyle = ElvUI_EltreumUI:FontFlag(fontStyle)
	if IsAddOnLoaded('NameplateSCT') then
		_G.NameplateSCTDB["global"]["fontFlag"] = ElvUI_EltreumUI:FontFlag(fontStyle)
	end

	if IsAddOnLoaded('ProjectAzilroka') then
		local PAprofile = _G.ProjectAzilrokaDB["profileKeys"][E.mynameRealm]
		if _G.ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["Enable"] then
			_G.ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["Enhancements"]["StatusBarFontFlag"] = fontStyle
			_G.ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["Enhancements"]["StackCountFontFlag"] = fontStyle
			_G.ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["FocusDebuffs"]["StatusBarFontFlag"] = fontStyle
			_G.ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["FocusDebuffs"]["StackCountFontFlag"] = fontStyle
			_G.ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["RaidDebuffs"]["StatusBarFontFlag"] = fontStyle
			_G.ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["RaidDebuffs"]["StackCountFontFlag"] = fontStyle
			_G.ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["TargetDebuffs"]["StatusBarFontFlag"] = fontStyle
			_G.ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["TargetDebuffs"]["StackCountFontFlag"] = fontStyle
			_G.ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["FocusBuffs"]["StatusBarFontFlag"] = fontStyle
			_G.ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["FocusBuffs"]["StackCountFontFlag"] = fontStyle
			_G.ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["Procs"]["StatusBarFontFlag"] = fontStyle
			_G.ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["Procs"]["StackCountFontFlag"] = fontStyle
			_G.ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["Cooldowns"]["StatusBarFontFlag"] = fontStyle
			_G.ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["Cooldowns"]["StackCountFontFlag"] = fontStyle
			_G.ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["Buffs"]["StatusBarFontFlag"] = fontStyle
			_G.ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["Buffs"]["StackCountFontFlag"] = fontStyle
			_G.ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["ItemCooldowns"]["StatusBarFontFlag"] = fontStyle
			_G.ProjectAzilrokaDB["profiles"][PAprofile]["iFilger"]["ItemCooldowns"]["StackCountFontFlag"] = fontStyle
		end
		if _G.ProjectAzilrokaDB["profiles"][PAprofile]["BrokerLDB"] then
			_G.ProjectAzilrokaDB["profiles"][PAprofile]["BrokerLDB"]["FontFlag"] = fontStyle
		end
		if _G.ProjectAzilrokaDB["profiles"][PAprofile]["MasterExperience"] then
			_G.ProjectAzilrokaDB["profiles"][PAprofile]["MasterExperience"]["FontFlag"] = fontStyle
		end
		if _G.ProjectAzilrokaDB["profiles"][PAprofile]["stAddonManager"] then
			_G.ProjectAzilrokaDB["profiles"][PAprofile]["stAddonManager"]["FontFlag"] = fontStyle
		end
	end

	if IsAddOnLoaded('AddOnSkins') then
		local AS = unpack(_G.AddOnSkins)
		AS["DBMFontFlag"] = fontStyle
		AS["FontFlag"] = fontStyle
	end

	if IsAddOnLoaded("Questie") then
		local profile = _G.QuestieConfig["profileKeys"][E.mynameRealm]
		_G.QuestieConfig["profiles"][profile]["trackerFontOutline"] = ElvUI_EltreumUI:FontFlag(fontStyle)
	end
end
