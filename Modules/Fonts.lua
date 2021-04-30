local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local IsAddOnLoaded = IsAddOnLoaded


function ElvUI_EltreumUI:SetupFontsKimberley(addon)
	if not E.db.movers then E.db.movers = {} end
		--nameplates
		E.db["nameplates"]["cooldown"]["fonts"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["countFont"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["countFont"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["health"]["text"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["name"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["power"]["text"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["countFont"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["countFont"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["health"]["text"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["name"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["power"]["text"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["title"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["buffs"]["countFont"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["castbar"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["debuffs"]["countFont"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["health"]["text"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["level"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["name"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["power"]["text"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["title"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["buffs"]["countFont"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["castbar"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["debuffs"]["countFont"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["health"]["text"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["level"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["name"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["power"]["text"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["title"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["PLAYER"]["buffs"]["countFont"] = "Kimberley"
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["countFont"] = "Kimberley"
		E.db["nameplates"]["units"]["PLAYER"]["health"]["text"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["PLAYER"]["level"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["PLAYER"]["name"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["PLAYER"]["power"]["text"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["PLAYER"]["title"]["font"] = "Kimberley"
		E.private["general"]["chatBubbleFont"] = "Kimberley"
		E.private["general"]["dmgfont"] = "Kimberley"
		E.private["general"]["namefont"] = "Kimberley"
		E.db["sle"]["armory"]["character"]["durability"]["font"] = "Kimberley"
		E.db["sle"]["armory"]["character"]["enchant"]["font"] = "Kimberley"
		E.db["sle"]["armory"]["character"]["ilvl"]["font"] = "Kimberley"
		E.db["sle"]["armory"]["inspect"]["enchant"]["font"] = "Kimberley"
		E.db["sle"]["armory"]["inspect"]["ilvl"]["font"] = "Kimberley"
		E.db["sle"]["armory"]["stats"]["catFonts"]["font"] = "Kimberley"
		E.db["sle"]["armory"]["stats"]["itemLevel"]["font"] = "Kimberley"
		E.db["sle"]["armory"]["stats"]["statFonts"]["font"] = "Kimberley"
		E.db["sle"]["media"]["fonts"]["gossip"]["font"] = "Kimberley"
		E.db["sle"]["media"]["fonts"]["mail"]["font"] = "Kimberley"
		E.db["sle"]["media"]["fonts"]["objective"]["font"] = "Kimberley"
		E.db["sle"]["media"]["fonts"]["objectiveHeader"]["font"] = "Kimberley"
		E.db["sle"]["media"]["fonts"]["pvp"]["font"] = "Kimberley"
		E.db["sle"]["media"]["fonts"]["questFontSuperHuge"]["font"] = "Kimberley"
		E.db["sle"]["media"]["fonts"]["subzone"]["font"] = "Kimberley"
		E.db["sle"]["media"]["fonts"]["zone"]["font"] = "Kimberley"
		E.db["sle"]["minimap"]["coords"]["font"] = "Kimberley"
		E.db["sle"]["minimap"]["instance"]["font"] = "Kimberley"
		E.db["sle"]["minimap"]["locPanel"]["font"] = "Kimberley"
		E.db["sle"]["nameplates"]["targetcount"]["font"] = "Kimberley"
		E.db["sle"]["nameplates"]["threat"]["font"] = "Kimberley"
		E.db["sle"]["screensaver"]["date"]["font"] = "Kimberley"
		E.db["sle"]["screensaver"]["player"]["font"] = "Kimberley"
		E.db["sle"]["screensaver"]["subtitle"]["font"] = "Kimberley"
		E.db["sle"]["screensaver"]["tips"]["font"] = "Kimberley"
		E.db["sle"]["screensaver"]["title"]["font"] = "Kimberley"
		E.db["sle"]["skins"]["merchant"]["list"]["nameFont"] = "Kimberley"
		E.db["sle"]["skins"]["merchant"]["list"]["subFont"] = "Kimberley"
		E.private["WT"]["skins"]["ime"]["label"]["name"] = "Kimberley"
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["bindFont"]["name"] = "Kimberley"
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["countFont"]["name"] = "Kimberley"
		E.db["WT"]["item"]["inspect"]["levelText"]["name"] = "Kimberley"
		E.db["WT"]["misc"]["gameBar"]["additionalText"]["font"]["name"] = "Kimberley"
		E.db["WT"]["misc"]["gameBar"]["time"]["font"]["name"] = "Kimberley"
		E.db["general"]["altPowerBar"]["font"] = "Kimberley"
		E.db["general"]["font"] = "Kimberley"
		E.db["general"]["itemLevel"]["itemLevelFont"] = "Kimberley"
		E.db["general"]["minimap"]["locationFont"] = "Kimberley"
		E.db["bags"]["countFont"] = "Kimberley"
		E.db["bags"]["itemInfoFont"] = "Kimberley"
		E.db["bags"]["itemLevelFont"] = "Kimberley"
		E.db["chat"]["font"] = "Kimberley"
		E.db["chat"]["tabFont"] = "Kimberley"
		E.db["cooldown"]["fonts"]["font"] = "Kimberley"
		E.db["databars"]["azerite"]["font"] = "Kimberley"
		E.db["databars"]["experience"]["font"] = "Kimberley"
		E.db["databars"]["honor"]["font"] = "Kimberley"
		E.db["databars"]["reputation"]["font"] = "Kimberley"
		E.db["databars"]["threat"]["font"] = "Kimberley"
		E.db["datatexts"]["font"] = "Kimberley"
		E.db["tooltip"]["font"] = "Kimberley"
		E.db["tooltip"]["healthBar"]["font"] = "Kimberley"


		-- Custom Text: Party
		E.db["unitframe"]["units"]["party"]["customTexts"] = E.db["unitframe"]["units"]["party"]["customTexts"] or {}
		E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyHealth"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "Kimberley",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 16,
			["text_format"] = "[health:current:shortvalue]",
			["xOffset"] = 0,
			["yOffset"] = 0
		}
		E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyName"] = {
			["attachTextTo"] = "InfoPanel",
			["enable"] = true,
			["font"] = "Kimberley",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "LEFT",
			["size"] = 12,
			["text_format"] = "[namecolor][name:medium] [difficultycolor][smartlevel]",
			["xOffset"] = 2,
			["yOffset"] = 0
		}
		E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyPower"] = {
			["attachTextTo"] = "Power",
			["enable"] = true,
			["font"] = "Kimberley",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 11,
			["text_format"] = "[powercolor][power:current:shortvalue]",
			["xOffset"] = 0,
			["yOffset"] = 0
		}
		E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyAbsorb"] = {
		["attachTextTo"] = "Health",
		["enable"] = true,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "RIGHT",
		["size"] = 11,
		["text_format"] = "||cffFFFF00[absorbs]||r ",
		["xOffset"] = 6,
		["yOffset"] = 0
		}
		-- Custom Text: Pet
		E.db["unitframe"]["units"]["pet"]["customTexts"] = E.db["unitframe"]["units"]["pet"]["customTexts"] or {}
		E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "Kimberley",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "CENTER",
			["size"] = 12,
			["text_format"] = "[namecolor][name]",
			["xOffset"] = 0,
			["yOffset"] = 0
		}
		-- Custom Text: Player
		E.db["unitframe"]["units"]["player"]["customTexts"] = E.db["unitframe"]["units"]["player"]["customTexts"] or {}
		E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPlayerAbsorb"] = {
		["attachTextTo"] = "Health",
		["enable"] = true,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "RIGHT",
		["size"] = 12,
		["text_format"] = "||cffFFFF00[absorbs]||r ",
		["xOffset"] = 6,
		["yOffset"] = 15
		}
		E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumHealth"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "Kimberley",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 14,
			["text_format"] = "[health:current-percent:shortvalue]",
			["xOffset"] = 0,
			["yOffset"] = 0
		}
		E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumName"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "Kimberley",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "LEFT",
			["size"] = 16,
			["text_format"] = "[namecolor][name]",
			["xOffset"] = 2,
			["yOffset"] = 0
		}
		E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"] = {
			["attachTextTo"] = "Power",
			["enable"] = true,
			["font"] = "Kimberley",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 10,
			["text_format"] = "[powercolor][power:current:shortvalue]",
			["xOffset"] = 0,
			["yOffset"] = -1
		}
		E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPvP"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "Kimberley",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "CENTER",
			["size"] = 15,
			["text_format"] = "[mouseover]||cFFB04F4F[pvptimer]||r",
			["xOffset"] = 0,
			["yOffset"] = 0
		}
		-- Custom Text: Raid
		E.db["unitframe"]["units"]["raid"]["customTexts"] = E.db["unitframe"]["units"]["raid"]["customTexts"] or {}
		E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumGroup"] = {
			["attachTextTo"] = "Health",
			["enable"] = false,
			["font"] = "Kimberley",
			["fontOutline"] = "NONE",
			["justifyH"] = "LEFT",
			["size"] = 8,
			["text_format"] = " Group [group]",
			["xOffset"] = 37,
			["yOffset"] = 10
		}
		E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumRaidAbsorb"] = {
		["attachTextTo"] = "Health",
		["enable"] = true,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "CENTER",
		["size"] = 10,
		["text_format"] = "||cffFFFF00[absorbs]||r",
		["xOffset"] = 45,
		["yOffset"] = 0
		}
		E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumRaidHealth"]= {
		["attachTextTo"] = "InfoPanel",
		["enable"] = true,
		["font"] = "Kimberley",
		["fontOutline"] = "OUTLINE",
		["justifyH"] = "RIGHT",
		["size"] = 10,
		["text_format"] = "[health:current:shortvalue]",
		["xOffset"] = 0,
		["yOffset"] = -1
		}
		E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumRaidName"] = {
		["attachTextTo"] = "InfoPanel",
		["enable"] = true,
		["font"] = "Kimberley",
		["fontOutline"] = "OUTLINE",
		["justifyH"] = "LEFT",
		["size"] = 10,
		["text_format"] = "[namecolor][name:medium] [difficultycolor][smartlevel]",
		["xOffset"] = 0,
		["yOffset"] = 0
		}
		-- Custom Text: Raid 40
		E.db["unitframe"]["units"]["raid40"]["customTexts"] = E.db["unitframe"]["units"]["raid40"]["customTexts"] or {}
		E.db["unitframe"]["units"]["raid40"]["customTexts"]["EltreumRaid40Absorb"] = {
		["attachTextTo"] = "Health",
		["enable"] = true,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "CENTER",
		["size"] = 10,
		["text_format"] = "||cffFFFF00[absorbs]||r",
		["xOffset"] = 37,
		["yOffset"] = 12
		}
		E.db["unitframe"]["units"]["raid40"]["customTexts"]["EltreumRaid40Group"] = {
			["attachTextTo"] = "Health",
			["enable"] = false,
			["font"] = "Kimberley",
			["fontOutline"] = "NONE",
			["justifyH"] = "LEFT",
			["size"] = 8,
			["text_format"] = " Group [group]",
			["xOffset"] = 40,
			["yOffset"] = 12
		}
		E.db["unitframe"]["units"]["raid40"]["customTexts"]["EltreumRaid40Health"] = {
			["attachTextTo"] = "InfoPanel",
			["enable"] = true,
			["font"] = "Kimberley",
			["fontOutline"] = "OUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 10,
			["text_format"] = "[health:current:shortvalue]",
			["xOffset"] = 0,
			["yOffset"] = 0
		}
		-- Custom Text: Target
		E.db["unitframe"]["units"]["target"]["customTexts"] = E.db["unitframe"]["units"]["target"]["customTexts"] or {}
		E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetAbsorb"] = {
		["attachTextTo"] = "Health",
		["enable"] = true,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "RIGHT",
		["size"] = 12,
		["text_format"] = "||cffFFFF00[absorbs]||r",
		["xOffset"] = 0,
		["yOffset"] = 15
		}
		E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetHealth"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "Kimberley",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "LEFT",
			["size"] = 14,
			["text_format"] = "[health:current-percent:shortvalue]",
			["xOffset"] = 2,
			["yOffset"] = 0
		}
		E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "Kimberley",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 16,
			["text_format"] = "[namecolor][name:azilroka:abbreviate]",
			["xOffset"] = -2,
			["yOffset"] = 0
		}
		E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetPower"] = {
		["attachTextTo"] = "Power",
		["enable"] = true,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "LEFT",
		["size"] = 10,
		["text_format"] = "[powercolor][power:current:shortvalue]",
		["xOffset"] = 2,
		["yOffset"] = -1
		}
		E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetofTarget"] = {
		["attachTextTo"] = "Frame",
		["enable"] = false,
		["font"] = "Kimberley",
		["fontOutline"] = "OUTLINE",
		["justifyH"] = "RIGHT",
		["size"] = 10,
		["text_format"] = "Target: [target]",
		["xOffset"] = -5,
		["yOffset"] = -14
		}
		-- Custom Text: TargetTarget
		E.db["unitframe"]["units"]["targettarget"]["customTexts"] = E.db["unitframe"]["units"]["targettarget"]["customTexts"] or {}
		E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetHealth"] = {
			["attachTextTo"] = "Health",
			["enable"] = false,
			["font"] = "Kimberley",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "LEFT",
			["size"] = 11,
			["text_format"] = "[health:current:shortvalue]",
			["xOffset"] = 2,
			["yOffset"] = 3
		}
		E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetName"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "Kimberley",
			["fontOutline"] = "OUTLINE",
			["justifyH"] = "CENTER",
			["size"] = 12,
			["text_format"] = "[namecolor][name:abbrev]",
			["xOffset"] = 0,
			["yOffset"] = 3
		}
		E.db["unitframe"]["units"]["targettarget"]["customTexts"]["Powercustom"] = {
		["attachTextTo"] = "Power",
		["enable"] = true,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "RIGHT",
		["size"] = 9,
		["text_format"] = "[powercolor][power:current:shortvalue]",
		["xOffset"] = 0,
		["yOffset"] = -1
		}


		--ActionBars
		E.db["actionbar"]["bar1"]["countFont"] = "Kimberley"
		E.db["actionbar"]["bar1"]["hotkeyFont"] = "Kimberley"
		E.db["actionbar"]["bar1"]["macroFont"] = "Kimberley"
		E.db["actionbar"]["bar10"]["countFont"] = "Kimberley"
		E.db["actionbar"]["bar10"]["hotkeyFont"] = "Kimberley"
		E.db["actionbar"]["bar10"]["macroFont"] = "Kimberley"
		E.db["actionbar"]["bar2"]["countFont"] = "Kimberley"
		E.db["actionbar"]["bar2"]["hotkeyFont"] = "Kimberley"
		E.db["actionbar"]["bar2"]["macroFont"] = "Kimberley"
		E.db["actionbar"]["bar3"]["countFont"] = "Kimberley"
		E.db["actionbar"]["bar3"]["hotkeyFont"] = "Kimberley"
		E.db["actionbar"]["bar3"]["macroFont"] = "Kimberley"
		E.db["actionbar"]["bar4"]["countFont"] = "Kimberley"
		E.db["actionbar"]["bar4"]["hotkeyFont"] = "Kimberley"
		E.db["actionbar"]["bar4"]["macroFont"] = "Kimberley"
		E.db["actionbar"]["bar5"]["countFont"] = "Kimberley"
		E.db["actionbar"]["bar5"]["hotkeyFont"] = "Kimberley"
		E.db["actionbar"]["bar5"]["macroFont"] = "Kimberley"
		E.db["actionbar"]["bar6"]["countFont"] = "Kimberley"
		E.db["actionbar"]["bar6"]["hotkeyFont"] = "Kimberley"
		E.db["actionbar"]["bar6"]["macroFont"] = "Kimberley"
		E.db["actionbar"]["bar7"]["countFont"] = "Kimberley"
		E.db["actionbar"]["bar7"]["hotkeyFont"] = "Kimberley"
		E.db["actionbar"]["bar7"]["macroFont"] = "Kimberley"
		E.db["actionbar"]["bar8"]["countFont"] = "Kimberley"
		E.db["actionbar"]["bar8"]["hotkeyFont"] = "Kimberley"
		E.db["actionbar"]["bar8"]["macroFont"] = "Kimberley"
		E.db["actionbar"]["bar9"]["countFont"] = "Kimberley"
		E.db["actionbar"]["bar9"]["hotkeyFont"] = "Kimberley"
		E.db["actionbar"]["bar9"]["macroFont"] = "Kimberley"
		E.db["actionbar"]["barPet"]["countFont"] = "Kimberley"
		E.db["actionbar"]["barPet"]["hotkeyFont"] = "Kimberley"
		E.db["actionbar"]["extraActionButton"]["hotkeyFont"] = "Kimberley"
		E.db["actionbar"]["font"] = "Kimberley"
		E.db["actionbar"]["stanceBar"]["hotkeyFont"] = "Kimberley"
		E.db["actionbar"]["vehicleExitButton"]["hotkeyFont"] = "Kimberley"
		E.db["auras"]["buffs"]["countFont"] = "Kimberley"
		E.db["auras"]["buffs"]["timeFont"] = "Kimberley"
		E.db["auras"]["debuffs"]["countFont"] = "Kimberley"
		E.db["auras"]["debuffs"]["timeFont"] = "Kimberley"
		E.db["unitframe"]["font"] = "Kimberley"
		E.db["unitframe"]["units"]["arena"]["buffs"]["countFont"] = "Kimberley"
		E.db["unitframe"]["units"]["arena"]["debuffs"]["countFont"] = "Kimberley"
		E.db["unitframe"]["units"]["assist"]["buffs"]["countFont"] = "Kimberley"
		E.db["unitframe"]["units"]["assist"]["debuffs"]["countFont"] = "Kimberley"
		E.db["unitframe"]["units"]["assist"]["rdebuffs"]["font"] = "Kimberley"
		E.db["unitframe"]["units"]["boss"]["buffs"]["countFont"] = "Kimberley"
		E.db["unitframe"]["units"]["boss"]["debuffs"]["countFont"] = "Kimberley"
		E.db["unitframe"]["units"]["focus"]["debuffs"]["countFont"] = "Kimberley"
		E.db["unitframe"]["units"]["party"]["buffs"]["countFont"] = "Kimberley"
		E.db["unitframe"]["units"]["party"]["castbar"]["customTextFont"]["font"] = "Kimberley"
		E.db["unitframe"]["units"]["party"]["debuffs"]["countFont"] = "Kimberley"
		E.db["unitframe"]["units"]["party"]["rdebuffs"]["font"] = "Kimberley"
		E.db["unitframe"]["units"]["player"]["buffs"]["countFont"] = "Kimberley"
		E.db["unitframe"]["units"]["player"]["castbar"]["customTimeFont"]["font"] = "Kimberley"
		E.db["unitframe"]["units"]["player"]["debuffs"]["countFont"] = "Kimberley"
		E.db["unitframe"]["units"]["raid"]["buffs"]["countFont"] = "Kimberley"
		E.db["unitframe"]["units"]["raid"]["debuffs"]["countFont"] = "Kimberley"
		E.db["unitframe"]["units"]["raid"]["rdebuffs"]["font"] = "Kimberley"
		E.db["unitframe"]["units"]["raid40"]["rdebuffs"]["font"] = "Kimberley"
		E.db["unitframe"]["units"]["tank"]["buffs"]["countFont"] = "Kimberley"
		E.db["unitframe"]["units"]["tank"]["debuffs"]["countFont"] = "Kimberley"
		E.db["unitframe"]["units"]["tank"]["rdebuffs"]["font"] = "Kimberley"
		E.db["unitframe"]["units"]["target"]["buffs"]["countFont"] = "Kimberley"
		E.db["unitframe"]["units"]["target"]["debuffs"]["countFont"] = "Kimberley"
		E.db["unitframe"]["units"]["targettargettarget"]["buffs"]["countFont"] = "Kimberley"
		E.db["unitframe"]["units"]["targettargettarget"]["debuffs"]["countFont"] = "Kimberley"



		E:StaggeredUpdateAll(nil, true)

	ElvUI_EltreumUI:Print('Font has been set.')
end

function ElvUI_EltreumUI:SetupFontsExo2(addon)
	if not E.db.movers then E.db.movers = {} end

		--nameplates
		E.db["nameplates"]["cooldown"]["fonts"]["font"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["countFont"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["font"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["countFont"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["health"]["text"]["font"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["font"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["name"]["font"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["power"]["text"]["font"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["font"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["font"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["countFont"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["font"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["countFont"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["health"]["text"]["font"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["font"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["name"]["font"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["power"]["text"]["font"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["title"]["font"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["buffs"]["countFont"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["castbar"]["font"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["debuffs"]["countFont"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["health"]["text"]["font"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["level"]["font"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["name"]["font"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["power"]["text"]["font"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["font"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["title"]["font"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["buffs"]["countFont"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["castbar"]["font"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["debuffs"]["countFont"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["health"]["text"]["font"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["level"]["font"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["name"]["font"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["power"]["text"]["font"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["title"]["font"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["PLAYER"]["buffs"]["countFont"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["font"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["countFont"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["PLAYER"]["health"]["text"]["font"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["PLAYER"]["level"]["font"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["PLAYER"]["name"]["font"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["PLAYER"]["power"]["text"]["font"] = "Exo2 Extra Bold"
		E.db["nameplates"]["units"]["PLAYER"]["title"]["font"] = "Exo2 Extra Bold"
		E.private["general"]["chatBubbleFont"] = "Exo2 Extra Bold"
		E.private["general"]["dmgfont"] = "Exo2 Extra Bold"
		E.private["general"]["namefont"] = "Exo2 Extra Bold"
		E.db["sle"]["armory"]["character"]["durability"]["font"] = "Exo2 Extra Bold"
		E.db["sle"]["armory"]["character"]["enchant"]["font"] = "Exo2 Extra Bold"
		E.db["sle"]["armory"]["character"]["ilvl"]["font"] = "Exo2 Extra Bold"
		E.db["sle"]["armory"]["inspect"]["enchant"]["font"] = "Exo2 Extra Bold"
		E.db["sle"]["armory"]["inspect"]["ilvl"]["font"] = "Exo2 Extra Bold"
		E.db["sle"]["armory"]["stats"]["catFonts"]["font"] = "Exo2 Extra Bold"
		E.db["sle"]["armory"]["stats"]["itemLevel"]["font"] = "Exo2 Extra Bold"
		E.db["sle"]["armory"]["stats"]["statFonts"]["font"] = "Exo2 Extra Bold"
		E.db["sle"]["media"]["fonts"]["gossip"]["font"] = "Exo2 Extra Bold"
		E.db["sle"]["media"]["fonts"]["mail"]["font"] = "Exo2 Extra Bold"
		E.db["sle"]["media"]["fonts"]["objective"]["font"] = "Exo2 Extra Bold"
		E.db["sle"]["media"]["fonts"]["objectiveHeader"]["font"] = "Exo2 Extra Bold"
		E.db["sle"]["media"]["fonts"]["pvp"]["font"] = "Exo2 Extra Bold"
		E.db["sle"]["media"]["fonts"]["questFontSuperHuge"]["font"] = "Exo2 Extra Bold"
		E.db["sle"]["media"]["fonts"]["subzone"]["font"] = "Exo2 Extra Bold"
		E.db["sle"]["media"]["fonts"]["zone"]["font"] = "Exo2 Extra Bold"
		E.db["sle"]["minimap"]["coords"]["font"] = "Exo2 Extra Bold"
		E.db["sle"]["minimap"]["instance"]["font"] = "Exo2 Extra Bold"
		E.db["sle"]["minimap"]["locPanel"]["font"] = "Exo2 Extra Bold"
		E.db["sle"]["nameplates"]["targetcount"]["font"] = "Exo2 Extra Bold"
		E.db["sle"]["nameplates"]["threat"]["font"] = "Exo2 Extra Bold"
		E.db["sle"]["screensaver"]["date"]["font"] = "Exo2 Extra Bold"
		E.db["sle"]["screensaver"]["player"]["font"] = "Exo2 Extra Bold"
		E.db["sle"]["screensaver"]["subtitle"]["font"] = "Exo2 Extra Bold"
		E.db["sle"]["screensaver"]["tips"]["font"] = "Exo2 Extra Bold"
		E.db["sle"]["screensaver"]["title"]["font"] = "Exo2 Extra Bold"
		E.db["sle"]["skins"]["merchant"]["list"]["nameFont"] = "Exo2 Extra Bold"
		E.db["sle"]["skins"]["merchant"]["list"]["subFont"] = "Exo2 Extra Bold"
		E.private["WT"]["skins"]["ime"]["label"]["name"] = "Exo2 Extra Bold"
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["bindFont"]["name"] = "Exo2 Extra Bold"
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["countFont"]["name"] = "Exo2 Extra Bold"
		E.db["WT"]["item"]["inspect"]["levelText"]["name"] = "Exo2 Extra Bold"
		E.db["WT"]["misc"]["gameBar"]["additionalText"]["font"]["name"] = "Exo2 Extra Bold"
		E.db["WT"]["misc"]["gameBar"]["time"]["font"]["name"] = "Exo2 Extra Bold"
		E.db["general"]["altPowerBar"]["font"] = "Exo2 Extra Bold"
		E.db["general"]["font"] = "Exo2 Extra Bold"
		E.db["general"]["itemLevel"]["itemLevelFont"] = "Exo2 Extra Bold"
		E.db["general"]["minimap"]["locationFont"] = "Exo2 Extra Bold"
		E.db["bags"]["countFont"] = "Exo2 Extra Bold"
		E.db["bags"]["itemInfoFont"] = "Exo2 Extra Bold"
		E.db["bags"]["itemLevelFont"] = "Exo2 Extra Bold"
		E.db["chat"]["font"] = "Exo2 Extra Bold"
		E.db["chat"]["tabFont"] = "Exo2 Extra Bold"
		E.db["cooldown"]["fonts"]["font"] = "Exo2 Extra Bold"
		E.db["databars"]["azerite"]["font"] = "Exo2 Extra Bold"
		E.db["databars"]["experience"]["font"] = "Exo2 Extra Bold"
		E.db["databars"]["honor"]["font"] = "Exo2 Extra Bold"
		E.db["databars"]["reputation"]["font"] = "Exo2 Extra Bold"
		E.db["databars"]["threat"]["font"] = "Exo2 Extra Bold"
		E.db["datatexts"]["font"] = "Exo2 Extra Bold"
		E.db["tooltip"]["font"] = "Exo2 Extra Bold"
		E.db["tooltip"]["healthBar"]["font"] = "Exo2 Extra Bold"


		-- Custom Text: Party
		E.db["unitframe"]["units"]["party"]["customTexts"] = E.db["unitframe"]["units"]["party"]["customTexts"] or {}
		E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyHealth"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "Exo2 Extra Bold",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 16,
			["text_format"] = "[health:current:shortvalue]",
			["xOffset"] = 0,
			["yOffset"] = 0
		}
		E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyName"] = {
			["attachTextTo"] = "InfoPanel",
			["enable"] = true,
			["font"] = "Exo2 Extra Bold",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "LEFT",
			["size"] = 12,
			["text_format"] = "[namecolor][name:medium] [difficultycolor][smartlevel]",
			["xOffset"] = 2,
			["yOffset"] = 0
		}
		E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyPower"] = {
			["attachTextTo"] = "Power",
			["enable"] = true,
			["font"] = "Exo2 Extra Bold",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 11,
			["text_format"] = "[powercolor][power:current:shortvalue]",
			["xOffset"] = 0,
			["yOffset"] = 0
		}
		E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyAbsorb"] = {
		["attachTextTo"] = "Health",
		["enable"] = true,
		["font"] = "Exo2 Extra Bold",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "RIGHT",
		["size"] = 11,
		["text_format"] = "||cffFFFF00[absorbs]||r ",
		["xOffset"] = 6,
		["yOffset"] = 0
		}
		-- Custom Text: Pet
		E.db["unitframe"]["units"]["pet"]["customTexts"] = E.db["unitframe"]["units"]["pet"]["customTexts"] or {}
		E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "Exo2 Extra Bold",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "CENTER",
			["size"] = 12,
			["text_format"] = "[namecolor][name]",
			["xOffset"] = 0,
			["yOffset"] = 0
		}
		-- Custom Text: Player
		E.db["unitframe"]["units"]["player"]["customTexts"] = E.db["unitframe"]["units"]["player"]["customTexts"] or {}
		E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPlayerAbsorb"] = {
		["attachTextTo"] = "Health",
		["enable"] = true,
		["font"] = "Exo2 Extra Bold",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "RIGHT",
		["size"] = 12,
		["text_format"] = "||cffFFFF00[absorbs]||r ",
		["xOffset"] = 6,
		["yOffset"] = 15
		}
		E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumHealth"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "Exo2 Extra Bold",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 14,
			["text_format"] = "[health:current-percent:shortvalue]",
			["xOffset"] = 0,
			["yOffset"] = 0
		}
		E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumName"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "Exo2 Extra Bold",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "LEFT",
			["size"] = 16,
			["text_format"] = "[namecolor][name]",
			["xOffset"] = 2,
			["yOffset"] = 0
		}
		E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"] = {
			["attachTextTo"] = "Power",
			["enable"] = true,
			["font"] = "Exo2 Extra Bold",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 10,
			["text_format"] = "[powercolor][power:current:shortvalue]",
			["xOffset"] = 0,
			["yOffset"] = -1
		}
		E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPvP"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "Exo2 Extra Bold",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "CENTER",
			["size"] = 15,
			["text_format"] = "[mouseover]||cFFB04F4F[pvptimer]||r",
			["xOffset"] = 0,
			["yOffset"] = 0
		}
		-- Custom Text: Raid
		E.db["unitframe"]["units"]["raid"]["customTexts"] = E.db["unitframe"]["units"]["raid"]["customTexts"] or {}
		E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumGroup"] = {
			["attachTextTo"] = "Health",
			["enable"] = false,
			["font"] = "Exo2 Extra Bold",
			["fontOutline"] = "NONE",
			["justifyH"] = "LEFT",
			["size"] = 8,
			["text_format"] = " Group [group]",
			["xOffset"] = 37,
			["yOffset"] = 10
		}
		E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumRaidAbsorb"] = {
		["attachTextTo"] = "Health",
		["enable"] = true,
		["font"] = "Exo2 Extra Bold",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "CENTER",
		["size"] = 10,
		["text_format"] = "||cffFFFF00[absorbs]||r",
		["xOffset"] = 45,
		["yOffset"] = 0
		}
		E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumRaidHealth"]= {
		["attachTextTo"] = "InfoPanel",
		["enable"] = true,
		["font"] = "Exo2 Extra Bold",
		["fontOutline"] = "OUTLINE",
		["justifyH"] = "RIGHT",
		["size"] = 10,
		["text_format"] = "[health:current:shortvalue]",
		["xOffset"] = 0,
		["yOffset"] = -1
		}
		E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumRaidName"] = {
		["attachTextTo"] = "InfoPanel",
		["enable"] = true,
		["font"] = "Exo2 Extra Bold",
		["fontOutline"] = "OUTLINE",
		["justifyH"] = "LEFT",
		["size"] = 10,
		["text_format"] = "[namecolor][name:medium] [difficultycolor][smartlevel]",
		["xOffset"] = 0,
		["yOffset"] = 0
		}
		-- Custom Text: Raid 40
		E.db["unitframe"]["units"]["raid40"]["customTexts"] = E.db["unitframe"]["units"]["raid40"]["customTexts"] or {}
		E.db["unitframe"]["units"]["raid40"]["customTexts"]["EltreumRaid40Absorb"] = {
		["attachTextTo"] = "Health",
		["enable"] = true,
		["font"] = "Exo2 Extra Bold",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "CENTER",
		["size"] = 10,
		["text_format"] = "||cffFFFF00[absorbs]||r",
		["xOffset"] = 37,
		["yOffset"] = 12
		}
		E.db["unitframe"]["units"]["raid40"]["customTexts"]["EltreumRaid40Group"] = {
			["attachTextTo"] = "Health",
			["enable"] = false,
			["font"] = "Exo2 Extra Bold",
			["fontOutline"] = "NONE",
			["justifyH"] = "LEFT",
			["size"] = 8,
			["text_format"] = " Group [group]",
			["xOffset"] = 40,
			["yOffset"] = 12
		}
		E.db["unitframe"]["units"]["raid40"]["customTexts"]["EltreumRaid40Health"] = {
			["attachTextTo"] = "InfoPanel",
			["enable"] = true,
			["font"] = "Exo2 Extra Bold",
			["fontOutline"] = "OUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 10,
			["text_format"] = "[health:current:shortvalue]",
			["xOffset"] = 0,
			["yOffset"] = 0
		}
		-- Custom Text: Target
		E.db["unitframe"]["units"]["target"]["customTexts"] = E.db["unitframe"]["units"]["target"]["customTexts"] or {}
		E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetAbsorb"] = {
		["attachTextTo"] = "Health",
		["enable"] = true,
		["font"] = "Exo2 Extra Bold",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "RIGHT",
		["size"] = 12,
		["text_format"] = "||cffFFFF00[absorbs]||r",
		["xOffset"] = 0,
		["yOffset"] = 15
		}
		E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetHealth"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "Exo2 Extra Bold",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "LEFT",
			["size"] = 14,
			["text_format"] = "[health:current-percent:shortvalue]",
			["xOffset"] = 2,
			["yOffset"] = 0
		}
		E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "Exo2 Extra Bold",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 16,
			["text_format"] = "[namecolor][name:azilroka:abbreviate]",
			["xOffset"] = -2,
			["yOffset"] = 0
		}
		E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetPower"] = {
		["attachTextTo"] = "Power",
		["enable"] = true,
		["font"] = "Exo2 Extra Bold",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "LEFT",
		["size"] = 10,
		["text_format"] = "[powercolor][power:current:shortvalue]",
		["xOffset"] = 2,
		["yOffset"] = -1
		}
		E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetofTarget"] = {
		["attachTextTo"] = "Frame",
		["enable"] = false,
		["font"] = "Exo2 Extra Bold",
		["fontOutline"] = "OUTLINE",
		["justifyH"] = "RIGHT",
		["size"] = 10,
		["text_format"] = "Target: [target]",
		["xOffset"] = -5,
		["yOffset"] = -14
		}
		-- Custom Text: TargetTarget
		E.db["unitframe"]["units"]["targettarget"]["customTexts"] = E.db["unitframe"]["units"]["targettarget"]["customTexts"] or {}
		E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetHealth"] = {
			["attachTextTo"] = "Health",
			["enable"] = false,
			["font"] = "Exo2 Extra Bold",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "LEFT",
			["size"] = 11,
			["text_format"] = "[health:current:shortvalue]",
			["xOffset"] = 2,
			["yOffset"] = 3
		}
		E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetName"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "Exo2 Extra Bold",
			["fontOutline"] = "OUTLINE",
			["justifyH"] = "CENTER",
			["size"] = 12,
			["text_format"] = "[namecolor][name:abbrev]",
			["xOffset"] = 0,
			["yOffset"] = 3
		}
		E.db["unitframe"]["units"]["targettarget"]["customTexts"]["Powercustom"] = {
		["attachTextTo"] = "Power",
		["enable"] = true,
		["font"] = "Exo2 Extra Bold",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "RIGHT",
		["size"] = 9,
		["text_format"] = "[powercolor][power:current:shortvalue]",
		["xOffset"] = 0,
		["yOffset"] = -1
		}

		--ActionBars
		E.db["actionbar"]["bar1"]["countFont"] = "Exo2 Extra Bold"
		E.db["actionbar"]["bar1"]["hotkeyFont"] = "Exo2 Extra Bold"
		E.db["actionbar"]["bar1"]["macroFont"] = "Exo2 Extra Bold"
		E.db["actionbar"]["bar10"]["countFont"] = "Exo2 Extra Bold"
		E.db["actionbar"]["bar10"]["hotkeyFont"] = "Exo2 Extra Bold"
		E.db["actionbar"]["bar10"]["macroFont"] = "Exo2 Extra Bold"
		E.db["actionbar"]["bar2"]["countFont"] = "Exo2 Extra Bold"
		E.db["actionbar"]["bar2"]["hotkeyFont"] = "Exo2 Extra Bold"
		E.db["actionbar"]["bar2"]["macroFont"] = "Exo2 Extra Bold"
		E.db["actionbar"]["bar3"]["countFont"] = "Exo2 Extra Bold"
		E.db["actionbar"]["bar3"]["hotkeyFont"] = "Exo2 Extra Bold"
		E.db["actionbar"]["bar3"]["macroFont"] = "Exo2 Extra Bold"
		E.db["actionbar"]["bar4"]["countFont"] = "Exo2 Extra Bold"
		E.db["actionbar"]["bar4"]["hotkeyFont"] = "Exo2 Extra Bold"
		E.db["actionbar"]["bar4"]["macroFont"] = "Exo2 Extra Bold"
		E.db["actionbar"]["bar5"]["countFont"] = "Exo2 Extra Bold"
		E.db["actionbar"]["bar5"]["hotkeyFont"] = "Exo2 Extra Bold"
		E.db["actionbar"]["bar5"]["macroFont"] = "Exo2 Extra Bold"
		E.db["actionbar"]["bar6"]["countFont"] = "Exo2 Extra Bold"
		E.db["actionbar"]["bar6"]["hotkeyFont"] = "Exo2 Extra Bold"
		E.db["actionbar"]["bar6"]["macroFont"] = "Exo2 Extra Bold"
		E.db["actionbar"]["bar7"]["countFont"] = "Exo2 Extra Bold"
		E.db["actionbar"]["bar7"]["hotkeyFont"] = "Exo2 Extra Bold"
		E.db["actionbar"]["bar7"]["macroFont"] = "Exo2 Extra Bold"
		E.db["actionbar"]["bar8"]["countFont"] = "Exo2 Extra Bold"
		E.db["actionbar"]["bar8"]["hotkeyFont"] = "Exo2 Extra Bold"
		E.db["actionbar"]["bar8"]["macroFont"] = "Exo2 Extra Bold"
		E.db["actionbar"]["bar9"]["countFont"] = "Exo2 Extra Bold"
		E.db["actionbar"]["bar9"]["hotkeyFont"] = "Exo2 Extra Bold"
		E.db["actionbar"]["bar9"]["macroFont"] = "Exo2 Extra Bold"
		E.db["actionbar"]["barPet"]["countFont"] = "Exo2 Extra Bold"
		E.db["actionbar"]["barPet"]["hotkeyFont"] = "Exo2 Extra Bold"
		E.db["actionbar"]["extraActionButton"]["hotkeyFont"] = "Exo2 Extra Bold"
		E.db["actionbar"]["font"] = "Exo2 Extra Bold"
		E.db["actionbar"]["stanceBar"]["hotkeyFont"] = "Exo2 Extra Bold"
		E.db["actionbar"]["vehicleExitButton"]["hotkeyFont"] = "Exo2 Extra Bold"
		E.db["auras"]["buffs"]["countFont"] = "Exo2 Extra Bold"
		E.db["auras"]["buffs"]["timeFont"] = "Exo2 Extra Bold"
		E.db["auras"]["debuffs"]["countFont"] = "Exo2 Extra Bold"
		E.db["auras"]["debuffs"]["timeFont"] = "Exo2 Extra Bold"
		E.db["unitframe"]["font"] = "Exo2 Extra Bold"
		E.db["unitframe"]["units"]["arena"]["buffs"]["countFont"] = "Exo2 Extra Bold"
		E.db["unitframe"]["units"]["arena"]["debuffs"]["countFont"] = "Exo2 Extra Bold"
		E.db["unitframe"]["units"]["assist"]["buffs"]["countFont"] = "Exo2 Extra Bold"
		E.db["unitframe"]["units"]["assist"]["debuffs"]["countFont"] = "Exo2 Extra Bold"
		E.db["unitframe"]["units"]["assist"]["rdebuffs"]["font"] = "Exo2 Extra Bold"
		E.db["unitframe"]["units"]["boss"]["buffs"]["countFont"] = "Exo2 Extra Bold"
		E.db["unitframe"]["units"]["boss"]["debuffs"]["countFont"] = "Exo2 Extra Bold"
		E.db["unitframe"]["units"]["focus"]["debuffs"]["countFont"] = "Exo2 Extra Bold"
		E.db["unitframe"]["units"]["party"]["buffs"]["countFont"] = "Exo2 Extra Bold"
		E.db["unitframe"]["units"]["party"]["castbar"]["customTextFont"]["font"] = "Exo2 Extra Bold"
		E.db["unitframe"]["units"]["party"]["debuffs"]["countFont"] = "Exo2 Extra Bold"
		E.db["unitframe"]["units"]["party"]["rdebuffs"]["font"] = "Exo2 Extra Bold"
		E.db["unitframe"]["units"]["player"]["buffs"]["countFont"] = "Exo2 Extra Bold"
		E.db["unitframe"]["units"]["player"]["castbar"]["customTimeFont"]["font"] = "Exo2 Extra Bold"
		E.db["unitframe"]["units"]["player"]["debuffs"]["countFont"] = "Exo2 Extra Bold"
		E.db["unitframe"]["units"]["raid"]["buffs"]["countFont"] = "Exo2 Extra Bold"
		E.db["unitframe"]["units"]["raid"]["debuffs"]["countFont"] = "Exo2 Extra Bold"
		E.db["unitframe"]["units"]["raid"]["rdebuffs"]["font"] = "Exo2 Extra Bold"
		E.db["unitframe"]["units"]["raid40"]["rdebuffs"]["font"] = "Exo2 Extra Bold"
		E.db["unitframe"]["units"]["tank"]["buffs"]["countFont"] = "Exo2 Extra Bold"
		E.db["unitframe"]["units"]["tank"]["debuffs"]["countFont"] = "Exo2 Extra Bold"
		E.db["unitframe"]["units"]["tank"]["rdebuffs"]["font"] = "Exo2 Extra Bold"
		E.db["unitframe"]["units"]["target"]["buffs"]["countFont"] = "Exo2 Extra Bold"
		E.db["unitframe"]["units"]["target"]["debuffs"]["countFont"] = "Exo2 Extra Bold"
		E.db["unitframe"]["units"]["targettargettarget"]["buffs"]["countFont"] = "Exo2 Extra Bold"
		E.db["unitframe"]["units"]["targettargettarget"]["debuffs"]["countFont"] = "Exo2 Extra Bold"



	E:StaggeredUpdateAll(nil, true)
	ElvUI_EltreumUI:Print('Font has been set.')
end

function ElvUI_EltreumUI:SetupFontsGotham(addon)
	if not E.db.movers then E.db.movers = {} end

		--nameplates
		E.db["nameplates"]["cooldown"]["fonts"]["font"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["countFont"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["font"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["countFont"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["health"]["text"]["font"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["font"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["name"]["font"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["power"]["text"]["font"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["font"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["font"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["countFont"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["font"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["countFont"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["health"]["text"]["font"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["font"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["name"]["font"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["power"]["text"]["font"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["title"]["font"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["buffs"]["countFont"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["castbar"]["font"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["debuffs"]["countFont"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["health"]["text"]["font"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["level"]["font"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["name"]["font"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["power"]["text"]["font"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["font"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["title"]["font"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["buffs"]["countFont"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["castbar"]["font"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["debuffs"]["countFont"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["health"]["text"]["font"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["level"]["font"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["name"]["font"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["power"]["text"]["font"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["title"]["font"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["PLAYER"]["buffs"]["countFont"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["font"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["countFont"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["PLAYER"]["health"]["text"]["font"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["PLAYER"]["level"]["font"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["PLAYER"]["name"]["font"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["PLAYER"]["power"]["text"]["font"] = "GothamNarrow Black"
		E.db["nameplates"]["units"]["PLAYER"]["title"]["font"] = "GothamNarrow Black"
		E.private["general"]["chatBubbleFont"] = "GothamNarrow Black"
		E.private["general"]["dmgfont"] = "GothamNarrow Black"
		E.private["general"]["namefont"] = "GothamNarrow Black"
		E.db["sle"]["armory"]["character"]["durability"]["font"] = "GothamNarrow Black"
		E.db["sle"]["armory"]["character"]["enchant"]["font"] = "GothamNarrow Black"
		E.db["sle"]["armory"]["character"]["ilvl"]["font"] = "GothamNarrow Black"
		E.db["sle"]["armory"]["inspect"]["enchant"]["font"] = "GothamNarrow Black"
		E.db["sle"]["armory"]["inspect"]["ilvl"]["font"] = "GothamNarrow Black"
		E.db["sle"]["armory"]["stats"]["catFonts"]["font"] = "GothamNarrow Black"
		E.db["sle"]["armory"]["stats"]["itemLevel"]["font"] = "GothamNarrow Black"
		E.db["sle"]["armory"]["stats"]["statFonts"]["font"] = "GothamNarrow Black"
		E.db["sle"]["media"]["fonts"]["gossip"]["font"] = "GothamNarrow Black"
		E.db["sle"]["media"]["fonts"]["mail"]["font"] = "GothamNarrow Black"
		E.db["sle"]["media"]["fonts"]["objective"]["font"] = "GothamNarrow Black"
		E.db["sle"]["media"]["fonts"]["objectiveHeader"]["font"] = "GothamNarrow Black"
		E.db["sle"]["media"]["fonts"]["pvp"]["font"] = "GothamNarrow Black"
		E.db["sle"]["media"]["fonts"]["questFontSuperHuge"]["font"] = "GothamNarrow Black"
		E.db["sle"]["media"]["fonts"]["subzone"]["font"] = "GothamNarrow Black"
		E.db["sle"]["media"]["fonts"]["zone"]["font"] = "GothamNarrow Black"
		E.db["sle"]["minimap"]["coords"]["font"] = "GothamNarrow Black"
		E.db["sle"]["minimap"]["instance"]["font"] = "GothamNarrow Black"
		E.db["sle"]["minimap"]["locPanel"]["font"] = "GothamNarrow Black"
		E.db["sle"]["nameplates"]["targetcount"]["font"] = "GothamNarrow Black"
		E.db["sle"]["nameplates"]["threat"]["font"] = "GothamNarrow Black"
		E.db["sle"]["screensaver"]["date"]["font"] = "GothamNarrow Black"
		E.db["sle"]["screensaver"]["player"]["font"] = "GothamNarrow Black"
		E.db["sle"]["screensaver"]["subtitle"]["font"] = "GothamNarrow Black"
		E.db["sle"]["screensaver"]["tips"]["font"] = "GothamNarrow Black"
		E.db["sle"]["screensaver"]["title"]["font"] = "GothamNarrow Black"
		E.db["sle"]["skins"]["merchant"]["list"]["nameFont"] = "GothamNarrow Black"
		E.db["sle"]["skins"]["merchant"]["list"]["subFont"] = "GothamNarrow Black"
		E.private["WT"]["skins"]["ime"]["label"]["name"] = "GothamNarrow Black"
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["bindFont"]["name"] = "GothamNarrow Black"
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["countFont"]["name"] = "GothamNarrow Black"
		E.db["WT"]["item"]["inspect"]["levelText"]["name"] = "GothamNarrow Black"
		E.db["WT"]["misc"]["gameBar"]["additionalText"]["font"]["name"] = "GothamNarrow Black"
		E.db["WT"]["misc"]["gameBar"]["time"]["font"]["name"] = "GothamNarrow Black"
		E.db["general"]["altPowerBar"]["font"] = "GothamNarrow Black"
		E.db["general"]["font"] = "GothamNarrow Black"
		E.db["general"]["itemLevel"]["itemLevelFont"] = "GothamNarrow Black"
		E.db["general"]["minimap"]["locationFont"] = "GothamNarrow Black"
		E.db["bags"]["countFont"] = "GothamNarrow Black"
		E.db["bags"]["itemInfoFont"] = "GothamNarrow Black"
		E.db["bags"]["itemLevelFont"] = "GothamNarrow Black"
		E.db["chat"]["font"] = "GothamNarrow Black"
		E.db["chat"]["tabFont"] = "GothamNarrow Black"
		E.db["cooldown"]["fonts"]["font"] = "GothamNarrow Black"
		E.db["databars"]["azerite"]["font"] = "GothamNarrow Black"
		E.db["databars"]["experience"]["font"] = "GothamNarrow Black"
		E.db["databars"]["honor"]["font"] = "GothamNarrow Black"
		E.db["databars"]["reputation"]["font"] = "GothamNarrow Black"
		E.db["databars"]["threat"]["font"] = "GothamNarrow Black"
		E.db["datatexts"]["font"] = "GothamNarrow Black"
		E.db["tooltip"]["font"] = "GothamNarrow Black"
		E.db["tooltip"]["healthBar"]["font"] = "GothamNarrow Black"



		-- Custom Text: Party
		E.db["unitframe"]["units"]["party"]["customTexts"] = E.db["unitframe"]["units"]["party"]["customTexts"] or {}
		E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyHealth"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "GothamNarrow Black",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 16,
			["text_format"] = "[health:current:shortvalue]",
			["xOffset"] = 0,
			["yOffset"] = 0
		}
		E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyName"] = {
			["attachTextTo"] = "InfoPanel",
			["enable"] = true,
			["font"] = "GothamNarrow Black",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "LEFT",
			["size"] = 12,
			["text_format"] = "[namecolor][name:medium] [difficultycolor][smartlevel]",
			["xOffset"] = 2,
			["yOffset"] = 0
		}
		E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyPower"] = {
			["attachTextTo"] = "Power",
			["enable"] = true,
			["font"] = "GothamNarrow Black",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 11,
			["text_format"] = "[powercolor][power:current:shortvalue]",
			["xOffset"] = 0,
			["yOffset"] = 0
		}
		E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyAbsorb"] = {
		["attachTextTo"] = "Health",
		["enable"] = true,
		["font"] = "GothamNarrow Black",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "RIGHT",
		["size"] = 11,
		["text_format"] = "||cffFFFF00[absorbs]||r ",
		["xOffset"] = 6,
		["yOffset"] = 0
		}
		-- Custom Text: Pet
		E.db["unitframe"]["units"]["pet"]["customTexts"] = E.db["unitframe"]["units"]["pet"]["customTexts"] or {}
		E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "GothamNarrow Black",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "CENTER",
			["size"] = 12,
			["text_format"] = "[namecolor][name]",
			["xOffset"] = 0,
			["yOffset"] = 0
		}
		-- Custom Text: Player
		E.db["unitframe"]["units"]["player"]["customTexts"] = E.db["unitframe"]["units"]["player"]["customTexts"] or {}
		E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPlayerAbsorb"] = {
		["attachTextTo"] = "Health",
		["enable"] = true,
		["font"] = "GothamNarrow Black",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "RIGHT",
		["size"] = 12,
		["text_format"] = "||cffFFFF00[absorbs]||r ",
		["xOffset"] = 6,
		["yOffset"] = 15
		}
		E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumHealth"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "GothamNarrow Black",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 14,
			["text_format"] = "[health:current-percent:shortvalue]",
			["xOffset"] = 0,
			["yOffset"] = 0
		}
		E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumName"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "GothamNarrow Black",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "LEFT",
			["size"] = 16,
			["text_format"] = "[namecolor][name]",
			["xOffset"] = 2,
			["yOffset"] = 0
		}
		E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"] = {
			["attachTextTo"] = "Power",
			["enable"] = true,
			["font"] = "GothamNarrow Black",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 10,
			["text_format"] = "[powercolor][power:current:shortvalue]",
			["xOffset"] = 0,
			["yOffset"] = -1
		}
		E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPvP"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "GothamNarrow Black",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "CENTER",
			["size"] = 15,
			["text_format"] = "[mouseover]||cFFB04F4F[pvptimer]||r",
			["xOffset"] = 0,
			["yOffset"] = 0
		}
		-- Custom Text: Raid
		E.db["unitframe"]["units"]["raid"]["customTexts"] = E.db["unitframe"]["units"]["raid"]["customTexts"] or {}
		E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumGroup"] = {
			["attachTextTo"] = "Health",
			["enable"] = false,
			["font"] = "GothamNarrow Black",
			["fontOutline"] = "NONE",
			["justifyH"] = "LEFT",
			["size"] = 8,
			["text_format"] = " Group [group]",
			["xOffset"] = 37,
			["yOffset"] = 10
		}
		E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumRaidAbsorb"] = {
		["attachTextTo"] = "Health",
		["enable"] = true,
		["font"] = "GothamNarrow Black",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "CENTER",
		["size"] = 10,
		["text_format"] = "||cffFFFF00[absorbs]||r",
		["xOffset"] = 45,
		["yOffset"] = 0
		}
		E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumRaidHealth"]= {
		["attachTextTo"] = "InfoPanel",
		["enable"] = true,
		["font"] = "GothamNarrow Black",
		["fontOutline"] = "OUTLINE",
		["justifyH"] = "RIGHT",
		["size"] = 10,
		["text_format"] = "[health:current:shortvalue]",
		["xOffset"] = 0,
		["yOffset"] = -1
		}
		E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumRaidName"] = {
		["attachTextTo"] = "InfoPanel",
		["enable"] = true,
		["font"] = "GothamNarrow Black",
		["fontOutline"] = "OUTLINE",
		["justifyH"] = "LEFT",
		["size"] = 10,
		["text_format"] = "[namecolor][name:medium] [difficultycolor][smartlevel]",
		["xOffset"] = 0,
		["yOffset"] = 0
		}
		-- Custom Text: Raid 40
		E.db["unitframe"]["units"]["raid40"]["customTexts"] = E.db["unitframe"]["units"]["raid40"]["customTexts"] or {}
		E.db["unitframe"]["units"]["raid40"]["customTexts"]["EltreumRaid40Absorb"] = {
		["attachTextTo"] = "Health",
		["enable"] = true,
		["font"] = "GothamNarrow Black",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "CENTER",
		["size"] = 10,
		["text_format"] = "||cffFFFF00[absorbs]||r",
		["xOffset"] = 37,
		["yOffset"] = 12
		}
		E.db["unitframe"]["units"]["raid40"]["customTexts"]["EltreumRaid40Group"] = {
			["attachTextTo"] = "Health",
			["enable"] = false,
			["font"] = "GothamNarrow Black",
			["fontOutline"] = "NONE",
			["justifyH"] = "LEFT",
			["size"] = 8,
			["text_format"] = " Group [group]",
			["xOffset"] = 40,
			["yOffset"] = 12
		}
		E.db["unitframe"]["units"]["raid40"]["customTexts"]["EltreumRaid40Health"] = {
			["attachTextTo"] = "InfoPanel",
			["enable"] = true,
			["font"] = "GothamNarrow Black",
			["fontOutline"] = "OUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 10,
			["text_format"] = "[health:current:shortvalue]",
			["xOffset"] = 0,
			["yOffset"] = 0
		}
		-- Custom Text: Target
		E.db["unitframe"]["units"]["target"]["customTexts"] = E.db["unitframe"]["units"]["target"]["customTexts"] or {}
		E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetAbsorb"] = {
		["attachTextTo"] = "Health",
		["enable"] = true,
		["font"] = "GothamNarrow Black",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "RIGHT",
		["size"] = 12,
		["text_format"] = "||cffFFFF00[absorbs]||r",
		["xOffset"] = 0,
		["yOffset"] = 15
		}
		E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetHealth"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "GothamNarrow Black",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "LEFT",
			["size"] = 14,
			["text_format"] = "[health:current-percent:shortvalue]",
			["xOffset"] = 2,
			["yOffset"] = 0
		}
		E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "GothamNarrow Black",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 16,
			["text_format"] = "[namecolor][name:azilroka:abbreviate]",
			["xOffset"] = -2,
			["yOffset"] = 0
		}
		E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetPower"] = {
		["attachTextTo"] = "Power",
		["enable"] = true,
		["font"] = "GothamNarrow Black",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "LEFT",
		["size"] = 10,
		["text_format"] = "[powercolor][power:current:shortvalue]",
		["xOffset"] = 2,
		["yOffset"] = -1
		}
		E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetofTarget"] = {
		["attachTextTo"] = "Frame",
		["enable"] = false,
		["font"] = "GothamNarrow Black",
		["fontOutline"] = "OUTLINE",
		["justifyH"] = "RIGHT",
		["size"] = 10,
		["text_format"] = "Target: [target]",
		["xOffset"] = -5,
		["yOffset"] = -14
		}
		-- Custom Text: TargetTarget
		E.db["unitframe"]["units"]["targettarget"]["customTexts"] = E.db["unitframe"]["units"]["targettarget"]["customTexts"] or {}
		E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetHealth"] = {
			["attachTextTo"] = "Health",
			["enable"] = false,
			["font"] = "GothamNarrow Black",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "LEFT",
			["size"] = 11,
			["text_format"] = "[health:current:shortvalue]",
			["xOffset"] = 2,
			["yOffset"] = 3
		}
		E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetName"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "GothamNarrow Black",
			["fontOutline"] = "OUTLINE",
			["justifyH"] = "CENTER",
			["size"] = 12,
			["text_format"] = "[namecolor][name:abbrev]",
			["xOffset"] = 0,
			["yOffset"] = 3
		}
		E.db["unitframe"]["units"]["targettarget"]["customTexts"]["Powercustom"] = {
		["attachTextTo"] = "Power",
		["enable"] = true,
		["font"] = "GothamNarrow Black",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "RIGHT",
		["size"] = 9,
		["text_format"] = "[powercolor][power:current:shortvalue]",
		["xOffset"] = 0,
		["yOffset"] = -1
		}

		--ActionBars
		E.db["actionbar"]["bar1"]["countFont"] = "GothamNarrow Black"
		E.db["actionbar"]["bar1"]["hotkeyFont"] = "GothamNarrow Black"
		E.db["actionbar"]["bar1"]["macroFont"] = "GothamNarrow Black"
		E.db["actionbar"]["bar10"]["countFont"] = "GothamNarrow Black"
		E.db["actionbar"]["bar10"]["hotkeyFont"] = "GothamNarrow Black"
		E.db["actionbar"]["bar10"]["macroFont"] = "GothamNarrow Black"
		E.db["actionbar"]["bar2"]["countFont"] = "GothamNarrow Black"
		E.db["actionbar"]["bar2"]["hotkeyFont"] = "GothamNarrow Black"
		E.db["actionbar"]["bar2"]["macroFont"] = "GothamNarrow Black"
		E.db["actionbar"]["bar3"]["countFont"] = "GothamNarrow Black"
		E.db["actionbar"]["bar3"]["hotkeyFont"] = "GothamNarrow Black"
		E.db["actionbar"]["bar3"]["macroFont"] = "GothamNarrow Black"
		E.db["actionbar"]["bar4"]["countFont"] = "GothamNarrow Black"
		E.db["actionbar"]["bar4"]["hotkeyFont"] = "GothamNarrow Black"
		E.db["actionbar"]["bar4"]["macroFont"] = "GothamNarrow Black"
		E.db["actionbar"]["bar5"]["countFont"] = "GothamNarrow Black"
		E.db["actionbar"]["bar5"]["hotkeyFont"] = "GothamNarrow Black"
		E.db["actionbar"]["bar5"]["macroFont"] = "GothamNarrow Black"
		E.db["actionbar"]["bar6"]["countFont"] = "GothamNarrow Black"
		E.db["actionbar"]["bar6"]["hotkeyFont"] = "GothamNarrow Black"
		E.db["actionbar"]["bar6"]["macroFont"] = "GothamNarrow Black"
		E.db["actionbar"]["bar7"]["countFont"] = "GothamNarrow Black"
		E.db["actionbar"]["bar7"]["hotkeyFont"] = "GothamNarrow Black"
		E.db["actionbar"]["bar7"]["macroFont"] = "GothamNarrow Black"
		E.db["actionbar"]["bar8"]["countFont"] = "GothamNarrow Black"
		E.db["actionbar"]["bar8"]["hotkeyFont"] = "GothamNarrow Black"
		E.db["actionbar"]["bar8"]["macroFont"] = "GothamNarrow Black"
		E.db["actionbar"]["bar9"]["countFont"] = "GothamNarrow Black"
		E.db["actionbar"]["bar9"]["hotkeyFont"] = "GothamNarrow Black"
		E.db["actionbar"]["bar9"]["macroFont"] = "GothamNarrow Black"
		E.db["actionbar"]["barPet"]["countFont"] = "GothamNarrow Black"
		E.db["actionbar"]["barPet"]["hotkeyFont"] = "GothamNarrow Black"
		E.db["actionbar"]["extraActionButton"]["hotkeyFont"] = "GothamNarrow Black"
		E.db["actionbar"]["font"] = "GothamNarrow Black"
		E.db["actionbar"]["stanceBar"]["hotkeyFont"] = "GothamNarrow Black"
		E.db["actionbar"]["vehicleExitButton"]["hotkeyFont"] = "GothamNarrow Black"
		E.db["auras"]["buffs"]["countFont"] = "GothamNarrow Black"
		E.db["auras"]["buffs"]["timeFont"] = "GothamNarrow Black"
		E.db["auras"]["debuffs"]["countFont"] = "GothamNarrow Black"
		E.db["auras"]["debuffs"]["timeFont"] = "GothamNarrow Black"
		E.db["unitframe"]["font"] = "GothamNarrow Black"
		E.db["unitframe"]["units"]["arena"]["buffs"]["countFont"] = "GothamNarrow Black"
		E.db["unitframe"]["units"]["arena"]["debuffs"]["countFont"] = "GothamNarrow Black"
		E.db["unitframe"]["units"]["assist"]["buffs"]["countFont"] = "GothamNarrow Black"
		E.db["unitframe"]["units"]["assist"]["debuffs"]["countFont"] = "GothamNarrow Black"
		E.db["unitframe"]["units"]["assist"]["rdebuffs"]["font"] = "GothamNarrow Black"
		E.db["unitframe"]["units"]["boss"]["buffs"]["countFont"] = "GothamNarrow Black"
		E.db["unitframe"]["units"]["boss"]["debuffs"]["countFont"] = "GothamNarrow Black"
		E.db["unitframe"]["units"]["focus"]["debuffs"]["countFont"] = "GothamNarrow Black"
		E.db["unitframe"]["units"]["party"]["buffs"]["countFont"] = "GothamNarrow Black"
		E.db["unitframe"]["units"]["party"]["castbar"]["customTextFont"]["font"] = "GothamNarrow Black"
		E.db["unitframe"]["units"]["party"]["debuffs"]["countFont"] = "GothamNarrow Black"
		E.db["unitframe"]["units"]["party"]["rdebuffs"]["font"] = "GothamNarrow Black"
		E.db["unitframe"]["units"]["player"]["buffs"]["countFont"] = "GothamNarrow Black"
		E.db["unitframe"]["units"]["player"]["castbar"]["customTimeFont"]["font"] = "GothamNarrow Black"
		E.db["unitframe"]["units"]["player"]["debuffs"]["countFont"] = "GothamNarrow Black"
		E.db["unitframe"]["units"]["raid"]["buffs"]["countFont"] = "GothamNarrow Black"
		E.db["unitframe"]["units"]["raid"]["debuffs"]["countFont"] = "GothamNarrow Black"
		E.db["unitframe"]["units"]["raid"]["rdebuffs"]["font"] = "GothamNarrow Black"
		E.db["unitframe"]["units"]["raid40"]["rdebuffs"]["font"] = "GothamNarrow Black"
		E.db["unitframe"]["units"]["tank"]["buffs"]["countFont"] = "GothamNarrow Black"
		E.db["unitframe"]["units"]["tank"]["debuffs"]["countFont"] = "GothamNarrow Black"
		E.db["unitframe"]["units"]["tank"]["rdebuffs"]["font"] = "GothamNarrow Black"
		E.db["unitframe"]["units"]["target"]["buffs"]["countFont"] = "GothamNarrow Black"
		E.db["unitframe"]["units"]["target"]["debuffs"]["countFont"] = "GothamNarrow Black"
		E.db["unitframe"]["units"]["targettargettarget"]["buffs"]["countFont"] = "GothamNarrow Black"
		E.db["unitframe"]["units"]["targettargettarget"]["debuffs"]["countFont"] = "GothamNarrow Black"



		E:StaggeredUpdateAll(nil, true)

	ElvUI_EltreumUI:Print('Font has been set.')
end
