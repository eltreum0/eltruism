local E, L = unpack(ElvUI)
local valuecolors = E:ClassColor(E.myclass, true)

--profile updates, so that whole profile doesnt need to be reimported
function ElvUI_EltreumUI:UpdateElvUISettings(update)
	if not E.db.movers then E.db.movers = {} end

	if update then
		if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") then
			E.db["movers"]["ElvUF_PartyMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,199,-258"
			local width = GetPhysicalScreenSize()
			if width == 1920 then
				E.db["movers"]["ElvUF_PlayerCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,-266,268"
				E.db["movers"]["ElvUF_TargetCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,294,268"
				E.db["unitframe"]["units"]["player"]["castbar"]["width"] = 240
				E.db["unitframe"]["units"]["target"]["castbar"]["width"] = 240
			end
		end
		if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") or ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer") then
			E.db["movers"]["AddonCompartmentMover"] = "TOPRIGHT,UIParent,TOPRIGHT,-8,-5"
			E.db["unitframe"]["units"]["target"]["aurabar"]["priority"] = "Blacklist,blockNoDuration,Personal,Boss,RaidDebuffs,PlayerBuffs,RaidBuffsElvUI,TurtleBuffs"

			E.private["general"]["nameplateFont"] = "Kimberley"
			E.private["general"]["nameplateFontOutline"] = "OUTLINE"
			E.private["general"]["nameplateLargeFont"] = "Kimberley"
			E.private["general"]["nameplateLargeFontOutline"] = "OUTLINE"
			E.private["general"]["nameplateLargeFontSize"] = 11
			E.db["general"]["objectiveFrameAutoHide"] = false
			E.db["general"]["fonts"]["worldsubzone"]["enable"] = true
			E.db["general"]["fonts"]["worldsubzone"]["font"] = "Kimberley"
			E.db["general"]["fonts"]["worldsubzone"]["outline"] = "OUTLINE"
			E.db["general"]["fonts"]["worldsubzone"]["size"] = 28
			E.db["general"]["fonts"]["worldzone"]["enable"] = true
			E.db["general"]["fonts"]["worldzone"]["font"] = "Kimberley"
			E.db["general"]["fonts"]["worldzone"]["outline"] = "OUTLINE"
			E.db["general"]["fonts"]["worldzone"]["size"] = 42
			E.db["general"]["fonts"]["pvpsubzone"]["enable"] = true
			E.db["general"]["fonts"]["pvpsubzone"]["font"] = "Kimberley"
			E.db["general"]["fonts"]["pvpsubzone"]["outline"] = "OUTLINE"
			E.db["general"]["fonts"]["pvpsubzone"]["size"] = 20
			E.db["general"]["fonts"]["pvpzone"]["enable"] = true
			E.db["general"]["fonts"]["pvpzone"]["font"] = "Kimberley"
			E.db["general"]["fonts"]["pvpzone"]["outline"] = "OUTLINE"
			E.db["general"]["fonts"]["pvpzone"]["size"] = 22
			E.db["general"]["fonts"]["objective"]["enable"] = false
			E.db["general"]["fonts"]["objective"]["font"] = "Kimberley"
			E.db["general"]["fonts"]["objective"]["outline"] = "OUTLINE"
			E.db["general"]["fonts"]["objective"]["size"] = 12
			E.db["general"]["fonts"]["questtitle"]["enable"] = true
			E.db["general"]["fonts"]["questtitle"]["font"] = "Kimberley"
			E.db["general"]["fonts"]["questtitle"]["outline"] = "OUTLINE"
			E.db["general"]["fonts"]["questtitle"]["size"] = 18
			E.db["general"]["fonts"]["questtext"]["enable"] = true
			E.db["general"]["fonts"]["questtext"]["font"] = "Kimberley"
			E.db["general"]["fonts"]["questtext"]["outline"] = "OUTLINE"
			E.db["general"]["fonts"]["questtext"]["size"] = 14
			E.db["general"]["fonts"]["questsmall"]["enable"] = true
			E.db["general"]["fonts"]["questsmall"]["font"] = "Kimberley"
			E.db["general"]["fonts"]["questsmall"]["outline"] = "OUTLINE"
			E.db["general"]["fonts"]["questsmall"]["size"] = 13
			E.db["general"]["fonts"]["cooldown"]["enable"] = true
			E.db["general"]["fonts"]["cooldown"]["font"] = "Kimberley"
			E.db["general"]["fonts"]["cooldown"]["outline"] = "OUTLINE"
			E.db["general"]["fonts"]["cooldown"]["size"] = 20
			E.db["general"]["fonts"]["errortext"]["enable"] = true
			E.db["general"]["fonts"]["errortext"]["font"] = "Kimberley"
			E.db["general"]["fonts"]["errortext"]["outline"] = "OUTLINE"
			E.db["general"]["fonts"]["errortext"]["size"] = 14
			E.db["general"]["fonts"]["mailbody"]["enable"] = true
			E.db["general"]["fonts"]["mailbody"]["font"] = "Kimberley"
			E.db["general"]["fonts"]["mailbody"]["outline"] = "OUTLINE"
			E.db["general"]["fonts"]["mailbody"]["size"] = 14
			E.db["general"]["fonts"]["talkingtext"]["enable"] = true
			E.db["general"]["fonts"]["talkingtext"]["font"] = "Kimberley"
			E.db["general"]["fonts"]["talkingtext"]["outline"] = "OUTLINE"
			E.db["general"]["fonts"]["talkingtext"]["size"] = 18
			E.db["general"]["fonts"]["talkingtitle"]["enable"] = true
			E.db["general"]["fonts"]["talkingtitle"]["font"] = "Kimberley"
			E.db["general"]["fonts"]["talkingtitle"]["outline"] = "OUTLINE"
			E.db["general"]["fonts"]["talkingtitle"]["size"] = 20
			E.db["general"]["itemLevel"]["totalLevelFont"] = "Kimberley"
			E.db["general"]["itemLevel"]["totalLevelFontOutline"] = "OUTLINE"
			E.db["general"]["itemLevel"]["totalLevelFontSize"] = E.Retail and 22 or 12
			E.db["general"]["itemLevel"]["enchantAbbrev"] = true
			E.db["general"]["itemLevel"]["showItemLevel"] = true
			E.db["general"]["itemLevel"]["showEnchants"] = true
			E.db["general"]["itemLevel"]["showGems"] = true
			E.db["unitframe"]["units"]["pet"]["buffs"]["countFont"] = "Kimberley"
			E.db["unitframe"]["units"]["pet"]["buffs"]["countFontOutline"] = "OUTLINE"
			E.db["unitframe"]["units"]["pet"]["debuffs"]["countFont"] = "Kimberley"
			E.db["unitframe"]["units"]["pet"]["debuffs"]["countFontOutline"] = "OUTLINE"
			E.db["unitframe"]["units"]["focus"]["CombatIcon"]["xOffset"] = -87
			E.db["unitframe"]["units"]["focus"]["CombatIcon"]["yOffset"] = 10
			E.db["unitframe"]["units"]["focus"]["CombatIcon"]["enable"] = false
			E.db["unitframe"]["units"]["party"]["CombatIcon"]["color"]["b"] = 1
			E.db["unitframe"]["units"]["party"]["CombatIcon"]["color"]["g"] = 1
			E.db["unitframe"]["units"]["party"]["CombatIcon"]["defaultColor"] = true
			E.db["unitframe"]["units"]["party"]["CombatIcon"]["enable"] = false
			E.db["unitframe"]["units"]["party"]["CombatIcon"]["texture"] = "Eltruism16"
			E.db["unitframe"]["units"]["player"]["CombatIcon"]["anchorPoint"] = "RIGHT"
			E.db["unitframe"]["units"]["player"]["CombatIcon"]["defaultColor"] = true
			E.db["unitframe"]["units"]["player"]["CombatIcon"]["texture"] = "Eltruism15"
			E.db["unitframe"]["units"]["player"]["CombatIcon"]["size"] = 30
			E.db["unitframe"]["units"]["player"]["CombatIcon"]["xOffset"] = 15
			E.db["unitframe"]["units"]["player"]["CombatIcon"]["yOffset"] = 0
			E.db["unitframe"]["units"]["player"]["CombatIcon"]["enable"] = true
			E.db["unitframe"]["units"]["target"]["CombatIcon"]["anchorPoint"] = "LEFT"
			E.db["unitframe"]["units"]["target"]["CombatIcon"]["defaultColor"] = true
			E.db["unitframe"]["units"]["target"]["CombatIcon"]["xOffset"] = -15
			E.db["unitframe"]["units"]["target"]["CombatIcon"]["yOffset"] = 0
			E.db["unitframe"]["units"]["target"]["CombatIcon"]["texture"] = "Eltruism29"
			E.db["unitframe"]["units"]["target"]["CombatIcon"]["size"] = 30
			E.db["unitframe"]["units"]["target"]["CombatIcon"]["enable"] = true

			E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["font"] = "Kimberley"
			E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["fontSize"] = 15
			E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["size"] = 25
			E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["spacing"] = 12
			E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["textPosition"] = "RIGHT"
			E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["textXOffset"] = 9
			E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["textYOffset"] = 0
			E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["xOffset"] = 15
			E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["font"] = "Kimberley"
			E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["fontSize"] = 15
			E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["size"] = 25
			E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["spacing"] = 12
			E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["textPosition"] = "RIGHT"
			E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["textXOffset"] = 9
			E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["textYOffset"] = 0
			E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["xOffset"] = 15

			E.db["actionbar"]["targetReticleColor"]["b"] = valuecolors.b
			E.db["actionbar"]["targetReticleColor"]["g"] = valuecolors.g
			E.db["actionbar"]["targetReticleColor"]["r"] = valuecolors.r

			if not E.Classic then
				E.db["unitframe"]["units"]["party"]["petsGroup"]["name"]["text_format"] = "[name]"
				if E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"] then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then
						E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["text_format"] = "[name:eltruism:gradient]"
					else
						E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["text_format"] = "[namecolor][name:eltruism:abbreviate]"
					end
				end
			end

			if E.Retail then
				ElvUI_EltreumUI:ModelsToggle(true) --disable models after layout for now due to the 3D model bug
			end

			ElvUI_EltreumUI:Print(L["Settings for ElvUI were updated."])
		end
	else
		E.private["general"]["nameplateFont"] = "Kimberley"
		E.private["general"]["nameplateFontOutline"] = "OUTLINE"
		E.private["general"]["nameplateLargeFont"] = "Kimberley"
		E.private["general"]["nameplateLargeFontOutline"] = "OUTLINE"
		E.private["general"]["nameplateLargeFontSize"] = 11
		E.db["general"]["objectiveFrameAutoHide"] = false
		E.db["general"]["fonts"]["worldsubzone"]["enable"] = true
		E.db["general"]["fonts"]["worldsubzone"]["font"] = "Kimberley"
		E.db["general"]["fonts"]["worldsubzone"]["outline"] = "OUTLINE"
		E.db["general"]["fonts"]["worldsubzone"]["size"] = 28
		E.db["general"]["fonts"]["worldzone"]["enable"] = true
		E.db["general"]["fonts"]["worldzone"]["font"] = "Kimberley"
		E.db["general"]["fonts"]["worldzone"]["outline"] = "OUTLINE"
		E.db["general"]["fonts"]["worldzone"]["size"] = 42
		E.db["general"]["fonts"]["pvpsubzone"]["enable"] = true
		E.db["general"]["fonts"]["pvpsubzone"]["font"] = "Kimberley"
		E.db["general"]["fonts"]["pvpsubzone"]["outline"] = "OUTLINE"
		E.db["general"]["fonts"]["pvpsubzone"]["size"] = 20
		E.db["general"]["fonts"]["pvpzone"]["enable"] = true
		E.db["general"]["fonts"]["pvpzone"]["font"] = "Kimberley"
		E.db["general"]["fonts"]["pvpzone"]["outline"] = "OUTLINE"
		E.db["general"]["fonts"]["pvpzone"]["size"] = 22
		E.db["general"]["fonts"]["objective"]["enable"] = false
		E.db["general"]["fonts"]["objective"]["font"] = "Kimberley"
		E.db["general"]["fonts"]["objective"]["outline"] = "OUTLINE"
		E.db["general"]["fonts"]["objective"]["size"] = 12
		E.db["general"]["fonts"]["questtitle"]["enable"] = true
		E.db["general"]["fonts"]["questtitle"]["font"] = "Kimberley"
		E.db["general"]["fonts"]["questtitle"]["outline"] = "OUTLINE"
		E.db["general"]["fonts"]["questtitle"]["size"] = 18
		E.db["general"]["fonts"]["questtext"]["enable"] = true
		E.db["general"]["fonts"]["questtext"]["font"] = "Kimberley"
		E.db["general"]["fonts"]["questtext"]["outline"] = "OUTLINE"
		E.db["general"]["fonts"]["questtext"]["size"] = 14
		E.db["general"]["fonts"]["questsmall"]["enable"] = true
		E.db["general"]["fonts"]["questsmall"]["font"] = "Kimberley"
		E.db["general"]["fonts"]["questsmall"]["outline"] = "OUTLINE"
		E.db["general"]["fonts"]["questsmall"]["size"] = 13
		E.db["general"]["fonts"]["cooldown"]["enable"] = true
		E.db["general"]["fonts"]["cooldown"]["font"] = "Kimberley"
		E.db["general"]["fonts"]["cooldown"]["outline"] = "OUTLINE"
		E.db["general"]["fonts"]["cooldown"]["size"] = 20
		E.db["general"]["fonts"]["errortext"]["enable"] = true
		E.db["general"]["fonts"]["errortext"]["font"] = "Kimberley"
		E.db["general"]["fonts"]["errortext"]["outline"] = "OUTLINE"
		E.db["general"]["fonts"]["errortext"]["size"] = 14
		E.db["general"]["fonts"]["mailbody"]["enable"] = true
		E.db["general"]["fonts"]["mailbody"]["font"] = "Kimberley"
		E.db["general"]["fonts"]["mailbody"]["outline"] = "OUTLINE"
		E.db["general"]["fonts"]["mailbody"]["size"] = 14
		E.db["general"]["fonts"]["talkingtext"]["enable"] = true
		E.db["general"]["fonts"]["talkingtext"]["font"] = "Kimberley"
		E.db["general"]["fonts"]["talkingtext"]["outline"] = "OUTLINE"
		E.db["general"]["fonts"]["talkingtext"]["size"] = 18
		E.db["general"]["fonts"]["talkingtitle"]["enable"] = true
		E.db["general"]["fonts"]["talkingtitle"]["font"] = "Kimberley"
		E.db["general"]["fonts"]["talkingtitle"]["outline"] = "OUTLINE"
		E.db["general"]["fonts"]["talkingtitle"]["size"] = 20
		E.db["general"]["itemLevel"]["totalLevelFont"] = "Kimberley"
		E.db["general"]["itemLevel"]["totalLevelFontOutline"] = "OUTLINE"
		E.db["general"]["itemLevel"]["totalLevelFontSize"] = E.Retail and 22 or 12
		E.db["unitframe"]["units"]["pet"]["buffs"]["countFont"] = "Kimberley"
		E.db["unitframe"]["units"]["pet"]["buffs"]["countFontOutline"] = "OUTLINE"
		E.db["unitframe"]["units"]["pet"]["debuffs"]["countFont"] = "Kimberley"
		E.db["unitframe"]["units"]["pet"]["debuffs"]["countFontOutline"] = "OUTLINE"

		E.db["general"]["guildBank"]["countFont"] = "Kimberley"

		if E.Retail then
			E.db["bags"]["split"]["bag5"] = true
			E.db["bags"]["split"]["bagSpacing"] = 7
			E.db["bags"]["split"]["player"] = true
		end

		E.db["movers"]["TopCenterContainerMover"] = "TOP,ElvUIParent,TOP,0,-100"

		E.db["unitframe"]["colors"]["classResources"]["MONK"][1]["b"] = 0.57254904508591
		E.db["unitframe"]["colors"]["classResources"]["MONK"][1]["g"] = 1
		E.db["unitframe"]["colors"]["classResources"]["MONK"][1]["r"] = 0.078431375324726
		E.db["unitframe"]["colors"]["classResources"]["MONK"][2]["b"] = 0.61568629741669
		E.db["unitframe"]["colors"]["classResources"]["MONK"][2]["g"] = 1
		E.db["unitframe"]["colors"]["classResources"]["MONK"][2]["r"] = 0.082352943718433
		E.db["unitframe"]["colors"]["classResources"]["MONK"][3]["b"] = 0.7294117808342
		E.db["unitframe"]["colors"]["classResources"]["MONK"][3]["g"] = 1
		E.db["unitframe"]["colors"]["classResources"]["MONK"][3]["r"] = 0.098039224743843
		E.db["unitframe"]["colors"]["classResources"]["MONK"][4]["b"] = 0.78039222955704
		E.db["unitframe"]["colors"]["classResources"]["MONK"][4]["g"] = 1
		E.db["unitframe"]["colors"]["classResources"]["MONK"][4]["r"] = 0.094117656350136
		E.db["unitframe"]["colors"]["classResources"]["MONK"][5]["b"] = 0.85490202903748
		E.db["unitframe"]["colors"]["classResources"]["MONK"][5]["g"] = 1
		E.db["unitframe"]["colors"]["classResources"]["MONK"][5]["r"] = 0.10588236153126
		E.db["unitframe"]["colors"]["classResources"]["MONK"][6]["b"] = 0.93333339691162
		E.db["unitframe"]["colors"]["classResources"]["MONK"][6]["g"] = 1
		E.db["unitframe"]["colors"]["classResources"]["MONK"][6]["r"] = 0.11372549831867
		E.db["unitframe"]["colors"]["classResources"]["chargedComboPoint"]["g"] = 0.63921570777893
		E.db["unitframe"]["colors"]["classResources"]["chargedComboPoint"]["r"] = 0.16078431904316
		E.db["unitframe"]["colors"]["classResources"]["comboPoints"][1]["b"] = 0.05882353335619
		E.db["unitframe"]["colors"]["classResources"]["comboPoints"][1]["g"] = 0.41960787773132
		E.db["unitframe"]["colors"]["classResources"]["comboPoints"][1]["r"] = 1
		E.db["unitframe"]["colors"]["classResources"]["comboPoints"][2]["b"] = 0.10196079313755
		E.db["unitframe"]["colors"]["classResources"]["comboPoints"][2]["g"] = 0.33725491166115
		E.db["unitframe"]["colors"]["classResources"]["comboPoints"][2]["r"] = 1
		E.db["unitframe"]["colors"]["classResources"]["comboPoints"][3]["b"] = 0.15294118225574
		E.db["unitframe"]["colors"]["classResources"]["comboPoints"][3]["g"] = 0.25098040699959
		E.db["unitframe"]["colors"]["classResources"]["comboPoints"][3]["r"] = 1
		E.db["unitframe"]["colors"]["classResources"]["comboPoints"][4]["b"] = 0.20784315466881
		E.db["unitframe"]["colors"]["classResources"]["comboPoints"][4]["g"] = 0.16078431904316
		E.db["unitframe"]["colors"]["classResources"]["comboPoints"][4]["r"] = 1
		E.db["unitframe"]["colors"]["classResources"]["comboPoints"][5]["b"] = 0.3137255012989
		E.db["unitframe"]["colors"]["classResources"]["comboPoints"][5]["g"] = 0.13333334028721
		E.db["unitframe"]["colors"]["classResources"]["comboPoints"][5]["r"] = 1
		E.db["unitframe"]["colors"]["classResources"]["comboPoints"][6]["b"] = 0.49019610881805
		E.db["unitframe"]["colors"]["classResources"]["comboPoints"][6]["g"] = 0.16078431904316
		E.db["unitframe"]["colors"]["classResources"]["comboPoints"][6]["r"] = 1
		E.db["unitframe"]["colors"]["classResources"]["comboPoints"][7]["b"] = 0.98039221763611
		E.db["unitframe"]["colors"]["classResources"]["comboPoints"][7]["g"] = 0.2549019753933
		E.db["unitframe"]["colors"]["classResources"]["comboPoints"][7]["r"] = 1

		E.db["unitframe"]["units"]["focus"]["CombatIcon"]["xOffset"] = -87
		E.db["unitframe"]["units"]["focus"]["CombatIcon"]["yOffset"] = 10
		E.db["unitframe"]["units"]["focus"]["CombatIcon"]["enable"] = false
		E.db["unitframe"]["units"]["party"]["CombatIcon"]["color"]["b"] = 1
		E.db["unitframe"]["units"]["party"]["CombatIcon"]["color"]["g"] = 1
		E.db["unitframe"]["units"]["party"]["CombatIcon"]["defaultColor"] = true
		E.db["unitframe"]["units"]["party"]["CombatIcon"]["enable"] = false
		E.db["unitframe"]["units"]["party"]["CombatIcon"]["texture"] = "Eltruism16"
		E.db["unitframe"]["units"]["player"]["CombatIcon"]["anchorPoint"] = "RIGHT"
		E.db["unitframe"]["units"]["player"]["CombatIcon"]["defaultColor"] = true
		E.db["unitframe"]["units"]["player"]["CombatIcon"]["texture"] = "Eltruism15"
		E.db["unitframe"]["units"]["player"]["CombatIcon"]["size"] = 30
		E.db["unitframe"]["units"]["player"]["CombatIcon"]["xOffset"] = 15
		E.db["unitframe"]["units"]["player"]["CombatIcon"]["yOffset"] = 0
		E.db["unitframe"]["units"]["player"]["CombatIcon"]["enable"] = true
		E.db["unitframe"]["units"]["target"]["CombatIcon"]["anchorPoint"] = "LEFT"
		E.db["unitframe"]["units"]["target"]["CombatIcon"]["defaultColor"] = true
		E.db["unitframe"]["units"]["target"]["CombatIcon"]["xOffset"] = -15
		E.db["unitframe"]["units"]["target"]["CombatIcon"]["yOffset"] = 0
		E.db["unitframe"]["units"]["target"]["CombatIcon"]["texture"] = "Eltruism29"
		E.db["unitframe"]["units"]["target"]["CombatIcon"]["size"] = 30
		E.db["unitframe"]["units"]["target"]["CombatIcon"]["enable"] = true

		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["fontSize"] = 15
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["size"] = 25
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["spacing"] = 12
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["textPosition"] = "RIGHT"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["textXOffset"] = 9
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["textYOffset"] = 0
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["xOffset"] = 15
		E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["fontSize"] = 15
		E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["size"] = 25
		E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["spacing"] = 12
		E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["textPosition"] = "RIGHT"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["textXOffset"] = 9
		E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["textYOffset"] = 0
		E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["xOffset"] = 15

		E.db["unitframe"]["units"]["target"]["aurabar"]["priority"] = "Blacklist,blockNoDuration,Personal,Boss,RaidDebuffs,PlayerBuffs,RaidBuffsElvUI,TurtleBuffs"

		E.db["nameplates"]["units"]["ENEMY_NPC"]["name"]["format"] = "[eltruism:classification][name]"

		E.db["nameplates"]["units"]["TARGET"]["glowStyle"] = "style4" --arrow

		--luckyone based optimizations
		E.db["auras"]["buffs"]["seperateOwn"] = 0 -- do not sort auras
		E.db["auras"]["debuffs"]["seperateOwn"] = 0 -- do not sort auras
		E.db["chat"]["fade"] = true -- fade text again
		E.db["unitframe"]["units"]["assist"]["enable"] = false --disable assist/tank frames
		E.db["unitframe"]["units"]["tank"]["enable"] = false --disable assist/tank frames
		E.db["unitframe"]["units"]["boss"]["fader"]["smooth"] = 0 --used to be 0.25
		E.db["unitframe"]["units"]["player"]["fader"]["smooth"] = 0 --used to be 0.25
		E.db["unitframe"]["units"]["target"]["fader"]["smooth"] = 0 --used to be 0.25
		E.db["unitframe"]["units"]["targettarget"]["fader"]["smooth"] = 0
		E.db["unitframe"]["units"]["focus"]["fader"]["smooth"] = 0 --used to be 0.25
		E.db["unitframe"]["units"]["pet"]["fader"]["smooth"] = 0 --used to be 0.25
		E.db["unitframe"]["units"]["arena"]["fader"]["smooth"] = 0
		E.db["unitframe"]["units"]["boss"]["fader"]["smooth"] = 0
		E.db["unitframe"]["units"]["party"]["fader"]["smooth"] = 0
		E.db["unitframe"]["units"]["raid1"]["fader"]["smooth"] = 0
		E.db["unitframe"]["units"]["raid2"]["fader"]["smooth"] = 0
		E.db["unitframe"]["units"]["raid3"]["fader"]["smooth"] = 0
		E.db["general"]["altPowerBar"]["smoothbars"] = false --was true
		E.db["nameplates"]["smoothbars"] = false --was true
		E.db["unitframe"]["smoothbars"] = false --was true
		E.db["tooltip"]["inspectDataEnable"] = false --was true
		E.db["tooltip"]["mythicDataEnable"] = false --was true
		E.db["tooltip"]["role"] = false --was true
		E.db["tooltip"]["targetInfo"] = false --was true
		E.db["tooltip"]["showMount"] = false --was true

		E.db["actionbar"]["targetReticleColor"]["b"] = valuecolors.b
		E.db["actionbar"]["targetReticleColor"]["g"] = valuecolors.g
		E.db["actionbar"]["targetReticleColor"]["r"] = valuecolors.r

		if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") then
			E.db["movers"]["ElvUF_PartyMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,199,-258"
		end
		if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") or ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer") then
			E.db["movers"]["AddonCompartmentMover"] = "TOPRIGHT,UIParent,TOPRIGHT,-8,-5"
		end

		--rest icon
		E.db["unitframe"]["units"]["player"]["RestIcon"]["color"]["a"] = 1.00
		E.db["unitframe"]["units"]["player"]["RestIcon"]["color"]["r"] = valuecolors.r
		E.db["unitframe"]["units"]["player"]["RestIcon"]["color"]["g"] = valuecolors.g
		E.db["unitframe"]["units"]["player"]["RestIcon"]["color"]["b"] = valuecolors.b
		E.db["unitframe"]["units"]["player"]["RestIcon"]["defaultColor"] = false
		E.db["unitframe"]["units"]["player"]["RestIcon"]["size"] = 15
		E.db["unitframe"]["units"]["player"]["RestIcon"]["texture"] = "Eltruism01"
		E.db["unitframe"]["units"]["player"]["RestIcon"]["xOffset"] = 13
		E.db["unitframe"]["units"]["player"]["RestIcon"]["yOffset"] = 1

		--private auras
		E.db["movers"]["PrivateAurasMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-287,-150"
		E.db["unitframe"]["units"]["party"]["privateAuras"]["parent"]["offsetY"] = 12
		E.db["unitframe"]["units"]["raid1"]["privateAuras"]["parent"]["offsetY"] = 5
		E.db["unitframe"]["units"]["raid2"]["privateAuras"]["parent"]["offsetY"] = 5
		E.db["unitframe"]["units"]["raid3"]["privateAuras"]["parent"]["offsetY"] = 5

		--disable rairity color, so that items color by lowest ilvl > highest
		E.db["general"]["itemLevel"]["itemLevelRarity"] = false
		E.db["general"]["itemLevel"]["enchantAbbrev"] = true
		E.db["general"]["itemLevel"]["showItemLevel"] = true
		E.db["general"]["itemLevel"]["showEnchants"] = true
		E.db["general"]["itemLevel"]["showGems"] = true

		ElvUI_EltreumUI:Print(L["Settings for ElvUI were updated."])
	end
end
