local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local GetAddOnMetadata = _G.GetAddOnMetadata
local IsAddOnLoaded = _G.IsAddOnLoaded
local sleversioncheck = GetAddOnMetadata('ElvUI_SLE', 'Version')

function ElvUI_EltreumUI:SetupFontsKimberley()
	if not E.db.movers then E.db.movers = {} end
	E.db["nameplates"]["cooldown"]["fonts"]["font"] = "Kimberley"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["countFont"] = "Kimberley"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["font"] = "Kimberley"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["countFont"] = "Kimberley"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["health"]["text"]["font"] = "Kimberley"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["font"] = "Kimberley"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["name"]["font"] = "Kimberley"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["power"]["text"]["font"] = "Kimberley"
	if E.Retail then
		E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["font"] = "Kimberley"
	end
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
	if E.Retail then
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["font"] = "Kimberley"
	end
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

	if E.Retail then
		if IsAddOnLoaded('ProjectAzilroka') then
			_G.ProjectAzilroka.db["stAddonManager"]["Font"] = "Kimberley"
		end
		if IsAddOnLoaded("ElvUI_SLE") then
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
			if sleversioncheck >= "4.22" then
				E.db["sle"]["afk"]["animTime"] = 2
				E.db["sle"]["afk"]["animType"] = "FadeIn"
				E.db["sle"]["afk"]["defaultGraphics"]["classCrest"]["anchorPoint"] = "CENTER"
				E.db["sle"]["afk"]["defaultGraphics"]["classCrest"]["attachTo"] = "SL_TopPanel"
				E.db["sle"]["afk"]["defaultGraphics"]["classCrest"]["styleOptions"] = "benikui"
				E.db["sle"]["afk"]["defaultGraphics"]["classCrest"]["xOffset"] = 184
				E.db["sle"]["afk"]["defaultGraphics"]["elvuiLogo"]["anchorPoint"] = "LEFT"
				E.db["sle"]["afk"]["defaultGraphics"]["elvuiLogo"]["attachTo"] = "SL_TopPanel"
				E.db["sle"]["afk"]["defaultGraphics"]["elvuiLogo"]["height"] = 128
				E.db["sle"]["afk"]["defaultGraphics"]["elvuiLogo"]["styleOptions"] = "releaf-flat"
				E.db["sle"]["afk"]["defaultGraphics"]["elvuiLogo"]["width"] = 256
				E.db["sle"]["afk"]["defaultGraphics"]["elvuiLogo"]["xOffset"] = 0
				E.db["sle"]["afk"]["defaultGraphics"]["elvuiLogo"]["yOffset"] = 0
				E.db["sle"]["afk"]["defaultGraphics"]["exPack"]["anchorPoint"] = "BOTTOM"
				E.db["sle"]["afk"]["defaultGraphics"]["exPack"]["inversePoint"] = true
				E.db["sle"]["afk"]["defaultGraphics"]["exPack"]["styleOptions"] = "blizzard"
				E.db["sle"]["afk"]["defaultGraphics"]["exPack"]["yOffset"] = 196
				E.db["sle"]["afk"]["defaultGraphics"]["factionCrest"]["anchorPoint"] = "TOPLEFT"
				E.db["sle"]["afk"]["defaultGraphics"]["factionCrest"]["attachTo"] = "SL_BottomPanel"
				E.db["sle"]["afk"]["defaultGraphics"]["factionCrest"]["styleOptions"] = "releaf-flat"
				E.db["sle"]["afk"]["defaultGraphics"]["factionCrest"]["xOffset"] = 0
				E.db["sle"]["afk"]["defaultGraphics"]["factionCrest"]["yOffset"] = 0
				E.db["sle"]["afk"]["defaultGraphics"]["factionLogo"]["enable"] = false
				E.db["sle"]["afk"]["defaultGraphics"]["raceCrest"]["anchorPoint"] = "CENTER"
				E.db["sle"]["afk"]["defaultGraphics"]["raceCrest"]["styleOptions"] = "releaf-flat"
				E.db["sle"]["afk"]["defaultGraphics"]["raceCrest"]["xOffset"] = -184
				E.db["sle"]["afk"]["defaultGraphics"]["raceCrest"]["yOffset"] = 0
				E.db["sle"]["afk"]["defaultGraphics"]["slLogo"]["anchorPoint"] = "RIGHT"
				E.db["sle"]["afk"]["defaultGraphics"]["slLogo"]["attachTo"] = "SL_TopPanel"
				E.db["sle"]["afk"]["defaultGraphics"]["slLogo"]["height"] = 128
				E.db["sle"]["afk"]["defaultGraphics"]["slLogo"]["width"] = 256
				E.db["sle"]["afk"]["defaultGraphics"]["slLogo"]["xOffset"] = 0
				E.db["sle"]["afk"]["defaultGraphics"]["slLogo"]["yOffset"] = 0
				E.db["sle"]["afk"]["defaultTexts"]["SL_AFKMessage"]["anchorPoint"] = "LEFT"
				E.db["sle"]["afk"]["defaultTexts"]["SL_AFKMessage"]["attachTo"] = "SL_BottomPanel"
				E.db["sle"]["afk"]["defaultTexts"]["SL_AFKMessage"]["font"] = "Kimberley"
				E.db["sle"]["afk"]["defaultTexts"]["SL_AFKMessage"]["size"] = 20
				E.db["sle"]["afk"]["defaultTexts"]["SL_AFKMessage"]["xOffset"] = 127
				E.db["sle"]["afk"]["defaultTexts"]["SL_AFKMessage"]["yOffset"] = 0
				E.db["sle"]["afk"]["defaultTexts"]["SL_AFKTimePassed"]["font"] = "Kimberley"
				E.db["sle"]["afk"]["defaultTexts"]["SL_AFKTimePassed"]["size"] = 20
				E.db["sle"]["afk"]["defaultTexts"]["SL_AFKTimePassed"]["xOffset"] = 4
				E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["anchorPoint"] = "TOPRIGHT"
				E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["attachTo"] = "SL_BottomPanel"
				E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["enable"] = false
				E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["font"] = "Kimberley"
				E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["xOffset"] = 20
				E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["yOffset"] = 50
				E.db["sle"]["afk"]["defaultTexts"]["SL_GuildName"]["anchorPoint"] = "BOTTOMLEFT"
				E.db["sle"]["afk"]["defaultTexts"]["SL_GuildName"]["attachTo"] = "SL_PlayerName"
				E.db["sle"]["afk"]["defaultTexts"]["SL_GuildName"]["font"] = "Kimberley"
				E.db["sle"]["afk"]["defaultTexts"]["SL_GuildName"]["size"] = 20
				E.db["sle"]["afk"]["defaultTexts"]["SL_GuildRank"]["anchorPoint"] = "RIGHT"
				E.db["sle"]["afk"]["defaultTexts"]["SL_GuildRank"]["attachTo"] = "SL_GuildName"
				E.db["sle"]["afk"]["defaultTexts"]["SL_GuildRank"]["font"] = "Kimberley"
				E.db["sle"]["afk"]["defaultTexts"]["SL_GuildRank"]["size"] = 20
				E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerClass"]["anchorPoint"] = "TOPRIGHT"
				E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerClass"]["attachTo"] = "SL_TopPanel"
				E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerClass"]["enable"] = false
				E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerClass"]["font"] = "Kimberley"
				E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerLevel"]["enable"] = false
				E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["anchorPoint"] = "TOPLEFT"
				E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["attachTo"] = "SL_BottomPanel"
				E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["font"] = "Kimberley"
				E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["size"] = 20
				E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["xOffset"] = 128
				E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["yOffset"] = -30
				E.db["sle"]["afk"]["defaultTexts"]["SL_SubText"]["enable"] = false
				E.db["sle"]["afk"]["defaultTexts"]["SL_SubText"]["size"] = 16
				E.db["sle"]["afk"]["defaultTexts"]["SL_SubText"]["xOffset"] = 0
				E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["anchorPoint"] = "CENTER"
				E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["attachTo"] = "SL_BottomPanel"
				E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["font"] = "Kimberley"
				E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["size"] = 32
				E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["yOffset"] = 40
				E.db["sle"]["afk"]["enable"] = true
				E.db["sle"]["afk"]["panels"]["bottom"]["height"] = 120
				E.db["sle"]["afk"]["panels"]["top"]["height"] = 120
				E.db["sle"]["afk"]["playermodel"]["anim"] = 47
			end
			E.db["sle"]["skins"]["merchant"]["list"]["nameFont"] = "Kimberley"
			E.db["sle"]["skins"]["merchant"]["list"]["subFont"] = "Kimberley"
		end
		if IsAddOnLoaded("ElvUI_WindTools") then
			E.private["WT"]["skins"]["ime"]["label"]["name"] = "Kimberley"
			E.db["WT"]["item"]["extraItemsBar"]["bar1"]["bindFont"]["name"] = "Kimberley"
			E.db["WT"]["item"]["extraItemsBar"]["bar1"]["countFont"]["name"] = "Kimberley"
			E.db["WT"]["item"]["inspect"]["levelText"]["name"] = "Kimberley"
			E.db["WT"]["misc"]["gameBar"]["additionalText"]["font"]["name"] = "Kimberley"
			E.db["WT"]["misc"]["gameBar"]["time"]["font"]["name"] = "Kimberley"
			E.db["general"]["altPowerBar"]["font"] = "Kimberley"
			E.db["general"]["itemLevel"]["itemLevelFont"] = "Kimberley"
		end
	end
	E.db["general"]["font"] = "Kimberley"
	E.db["general"]["minimap"]["locationFont"] = "Kimberley"
	if E.Retail then
		E.db["general"]["minimap"]["icons"]["queueStatus"]["font"] = "Kimberley"
	end
	if E.Wrath then
		E.db["general"]["totems"]["font"] = "Kimberley"
	end
	E.db["bags"]["countFont"] = "Kimberley"
	E.db["bags"]["itemInfoFont"] = "Kimberley"
	E.db["bags"]["itemLevelFont"] = "Kimberley"
	E.db["chat"]["font"] = "Kimberley"
	E.db["chat"]["tabFont"] = "Kimberley"
	E.db["cooldown"]["fonts"]["font"] = "Kimberley"
	if E.Retail then
		E.db["databars"]["azerite"]["font"] = "Kimberley"
		E.db["databars"]["honor"]["font"] = "Kimberley"
	end
	E.db["databars"]["experience"]["font"] = "Kimberley"
	E.db["databars"]["reputation"]["font"] = "Kimberley"
	E.db["databars"]["threat"]["font"] = "Kimberley"
	E.db["datatexts"]["font"] = "Kimberley"
	E.db["tooltip"]["font"] = "Kimberley"
	E.db["tooltip"]["healthBar"]["font"] = "Kimberley"
	E.db["tooltip"]["headerFont"] = "Kimberley"

	-- Custom Text: Party
	E.db["unitframe"]["units"]["party"]["customTexts"] = E.db["unitframe"]["units"]["party"]["customTexts"] or {}
	E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyHealth"] = {
		["attachTextTo"] = "Health",
		["enable"] = true,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "RIGHT",
		["size"] = 16,
		["text_format"] = "[eltruism:raidmarker] [health:current:shortvalue]",
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
		["yOffset"] = -2,
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
		["yOffset"] = -1,
	}
	E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumStatus"] = {
		["attachTextTo"] = "Health",
		["enable"] = false,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "CENTER",
		["size"] = 40,
		["text_format"] = "[eltruism:dead{5}][eltruism:dc{2}]",
		["xOffset"] = 0,
		["yOffset"] = 0
	}
	if E.Retail then
		E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyAbsorb"] = {
		["attachTextTo"] = "Health",
		["enable"] = false,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "RIGHT",
		["size"] = 11,
		["text_format"] = "||cffFFFF00[absorbs]||r ",
		["xOffset"] = 6,
		["yOffset"] = 0
		}
	end

	-- Custom Text: Arena
	E.db["unitframe"]["units"]["arena"]["customTexts"] = E.db["unitframe"]["units"]["arena"]["customTexts"] or {}
	if E.Retail or E.Wrath then
		E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaHealth"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "Kimberley",
			["fontOutline"] = "OUTLINE",
			["justifyH"] = "LEFT",
			["size"] = 16,
			["text_format"] = "[health:current:shortvalue]",
			["xOffset"] = 0,
			["yOffset"] = 0
		}
		E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaName"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "Kimberley",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 12,
			["text_format"] = "[namecolor][name:medium] [difficultycolor][smartlevel]",
			["xOffset"] = 2,
			["yOffset"] = 0
		}
		E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaPower"] = {
			["attachTextTo"] = "Power",
			["enable"] = true,
			["font"] = "Kimberley",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "LEFT",
			["size"] = 11,
			["text_format"] = "[powercolor][power:current:shortvalue]",
			["xOffset"] = 1,
			["yOffset"] = -1
		}
	elseif E.Classic then
		E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaHealth"] = {
			["attachTextTo"] = "Health",
			["enable"] = false,
			["font"] = "Kimberley",
			["fontOutline"] = "OUTLINE",
			["justifyH"] = "LEFT",
			["size"] = 16,
			["text_format"] = "[health:current:shortvalue]",
			["xOffset"] = 0,
			["yOffset"] = 0
		}
		E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaName"] = {
			["attachTextTo"] = "Health",
			["enable"] = false,
			["font"] = "Kimberley",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 12,
			["text_format"] = "[namecolor][name:medium] [difficultycolor][smartlevel]",
			["xOffset"] = 2,
			["yOffset"] = 0
		}
		E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaPower"] = {
			["attachTextTo"] = "Power",
			["enable"] = false,
			["font"] = "Kimberley",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "LEFT",
			["size"] = 11,
			["text_format"] = "[powercolor][power:current:shortvalue]",
			["xOffset"] = 1,
			["yOffset"] = -1
		}
	end
	E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumStatus"] = {
		["attachTextTo"] = "Health",
		["enable"] = false,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "CENTER",
		["size"] = 40,
		["text_format"] = "[eltruism:dead{5}][eltruism:dc{2}]",
		["xOffset"] = -50,
		["yOffset"] = 0
	}

	-- Custom Text: Pet
	if E.Retail then
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
	elseif E.Wrath or E.Classic then
		E.db["unitframe"]["units"]["pet"]["customTexts"] = E.db["unitframe"]["units"]["pet"]["customTexts"] or {}
		E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "Kimberley",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "CENTER",
			["size"] = 12,
			["text_format"] = "[namecolor][name][happiness:discord]",
			["xOffset"] = 0,
			["yOffset"] = 0
		}
	end

	-- Custom Text: Player
	E.db["unitframe"]["units"]["player"]["customTexts"] = E.db["unitframe"]["units"]["player"]["customTexts"] or {}
	if E.Retail then
		E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPlayerAbsorb"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "Kimberley",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 12,
			["text_format"] = "||cffFFFF00[absorbs]||r ",
			["xOffset"] = 0,
			["yOffset"] = 15
		}
	end
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
		["text_format"] = "[namecolor][name] [eltruism:class:player] [eltruism:raidmarker]",
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
	E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumStatus"] = {
		["attachTextTo"] = "Health",
		["enable"] = false,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "CENTER",
		["size"] = 27,
		["text_format"] = "[eltruism:dead{5}][eltruism:dc{2}]",
		["xOffset"] = 50,
		["yOffset"] = 0
	}

	-- Custom Text: Raid1
	E.db["unitframe"]["units"]["raid1"]["customTexts"] = E.db["unitframe"]["units"]["raid1"]["customTexts"] or {}
	E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumGroup"] = {
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
	if E.Retail then
		E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Absorb"] = {
		["attachTextTo"] = "Health",
		["enable"] = false,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "CENTER",
		["size"] = 10,
		["text_format"] = "||cffFFFF00[absorbs]||r",
		["xOffset"] = 45,
		["yOffset"] = 0
		}
	end
	E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Health"]= {
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
	E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Name"] = {
		["attachTextTo"] = "InfoPanel",
		["enable"] = true,
		["font"] = "Kimberley",
		["fontOutline"] = "OUTLINE",
		["justifyH"] = "LEFT",
		["size"] = 10,
		["text_format"] = "[namecolor][name:eltruism:abbreviate]",
		["xOffset"] = 0,
		["yOffset"] = 0
	}
	E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumStatus"] = {
		["attachTextTo"] = "Health",
		["enable"] = false,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "CENTER",
		["size"] = 25,
		["text_format"] = "[eltruism:dead{5}][eltruism:dc{2}]",
		["xOffset"] = 0,
		["yOffset"] = 0
	}

	-- Custom Text: Raid2
	E.db["unitframe"]["units"]["raid2"]["customTexts"] = E.db["unitframe"]["units"]["raid2"]["customTexts"] or {}
	E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumGroup"] = {
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
	if E.Retail then
		E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Absorb"] = {
		["attachTextTo"] = "Health",
		["enable"] = false,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "CENTER",
		["size"] = 10,
		["text_format"] = "||cffFFFF00[absorbs]||r",
		["xOffset"] = 45,
		["yOffset"] = 0
		}
	end
	E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Health"]= {
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
	E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Name"] = {
		["attachTextTo"] = "InfoPanel",
		["enable"] = true,
		["font"] = "Kimberley",
		["fontOutline"] = "OUTLINE",
		["justifyH"] = "LEFT",
		["size"] = 10,
		["text_format"] = "[namecolor][name:eltruism:abbreviate]",
		["xOffset"] = 0,
		["yOffset"] = 0
	}
	E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumStatus"] = {
		["attachTextTo"] = "Health",
		["enable"] = false,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "CENTER",
		["size"] = 25,
		["text_format"] = "[eltruism:dead{5}][eltruism:dc{2}]",
		["xOffset"] = 0,
		["yOffset"] = 0
	}

	-- Custom Text: Raid3
	E.db["unitframe"]["units"]["raid3"]["customTexts"] = E.db["unitframe"]["units"]["raid3"]["customTexts"] or {}
	if E.Retail then
		E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Absorb"] = {
			["attachTextTo"] = "Health",
			["enable"] = false,
			["font"] = "Kimberley",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "CENTER",
			["size"] = 10,
			["text_format"] = "||cffFFFF00[absorbs]||r",
			["xOffset"] = 37,
			["yOffset"] = 12
		}
	end
	E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumGroup"] = {
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
	E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Health"] = {
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
	E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Name"] = {
		["attachTextTo"] = "InfoPanel",
		["enable"] = true,
		["font"] = "Kimberley",
		["fontOutline"] = "OUTLINE",
		["justifyH"] = "LEFT",
		["size"] = 10,
		["text_format"] = "[namecolor][name:eltruism:abbreviateshort]",
		["xOffset"] = 0,
		["yOffset"] = 0
	}
	E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumStatus"] = {
		["attachTextTo"] = "Health",
		["enable"] = false,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "CENTER",
		["size"] = 20,
		["text_format"] = "[eltruism:dead{5}][eltruism:dc{2}]",
		["xOffset"] = 0,
		["yOffset"] = 0
	}

	-- Custom Text: Target
	E.db["unitframe"]["units"]["target"]["customTexts"] = E.db["unitframe"]["units"]["target"]["customTexts"] or {}
	if E.Retail then
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
	end
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
		["text_format"] = "[eltruism:raidmarker] [eltruism:class:player] [namecolor][eltruism:difficulty][name:eltruism:abbreviate]",
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
		["text_format"] = "Target: [eltruism:targetcast]",
		["xOffset"] = -5,
		["yOffset"] = -14
	}
	E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumStatus"] = {
		["attachTextTo"] = "Health",
		["enable"] = false,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "CENTER",
		["size"] = 27,
		["text_format"] = "[eltruism:dead{5}][eltruism:dc{2}]",
		["xOffset"] = -50,
		["yOffset"] = 0
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
	E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumPower"] = {
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
	E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumStatus"] = {
		["attachTextTo"] = "Health",
		["enable"] = true,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "CENTER",
		["size"] = 15,
		["text_format"] = "[eltruism:dead{5}][eltruism:dc{2}]",
		["xOffset"] = 0,
		["yOffset"] = 22
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
	if E.Retail then
		E.db["actionbar"]["extraActionButton"]["hotkeyFont"] = "Kimberley"
	end
	E.db["actionbar"]["font"] = "Kimberley"
	E.db["actionbar"]["stanceBar"]["hotkeyFont"] = "Kimberley"
	E.db["actionbar"]["vehicleExitButton"]["hotkeyFont"] = "Kimberley"
	E.db["auras"]["buffs"]["countFont"] = "Kimberley"
	E.db["auras"]["buffs"]["timeFont"] = "Kimberley"
	E.db["auras"]["debuffs"]["countFont"] = "Kimberley"
	E.db["auras"]["debuffs"]["timeFont"] = "Kimberley"
	E.db["unitframe"]["font"] = "Kimberley"
	if E.Retail then
		E.db["unitframe"]["units"]["arena"]["buffs"]["countFont"] = "Kimberley"
		E.db["unitframe"]["units"]["arena"]["debuffs"]["countFont"] = "Kimberley"
		E.db["unitframe"]["units"]["assist"]["buffs"]["countFont"] = "Kimberley"
		E.db["unitframe"]["units"]["assist"]["debuffs"]["countFont"] = "Kimberley"
		E.db["unitframe"]["units"]["assist"]["rdebuffs"]["font"] = "Kimberley"
		E.db["unitframe"]["units"]["boss"]["buffs"]["countFont"] = "Kimberley"
		E.db["unitframe"]["units"]["boss"]["debuffs"]["countFont"] = "Kimberley"
		E.db["unitframe"]["units"]["focus"]["debuffs"]["countFont"] = "Kimberley"
		E.db["unitframe"]["units"]["party"]["castbar"]["customTextFont"]["font"] = "Kimberley"
		E.db["unitframe"]["units"]["player"]["castbar"]["customTimeFont"]["font"] = "Kimberley"
	end
	E.db["unitframe"]["units"]["party"]["buffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["party"]["debuffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["player"]["buffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["player"]["debuffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["raid1"]["buffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["raid1"]["debuffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["raid1"]["rdebuffs"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["raid2"]["buffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["raid2"]["debuffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["raid2"]["rdebuffs"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["raid3"]["buffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["raid3"]["debuffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["raid3"]["rdebuffs"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["tank"]["buffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["tank"]["debuffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["tank"]["rdebuffs"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["target"]["buffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["target"]["debuffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["targettargettarget"]["buffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["targettargettarget"]["debuffs"]["countFont"] = "Kimberley"

	--fix for dark/light mode
	if E.db.ElvUI_EltreumUI.unitframes.lightmode == false then
		if E.Classic or E.Wrath then
			E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["text_format"] = "[namecolor][name][happiness:discord]"
		elseif E.Retail then
			E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["text_format"] = "[namecolor][name]"
		end
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumName"]["text_format"] = "[namecolor][name] [eltruism:class:player] [eltruism:raidmarker]"
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"]["text_format"] = "[eltruism:raidmarker] [eltruism:class:player] [namecolor][eltruism:difficulty][name:eltruism:abbreviate]"
			E.db["unitframe"]["units"]["tank"]["name"]["text_format"] = "[namecolor][name:long:status]"
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetName"]["text_format"] = "[namecolor][name:abbrev]"
		if E.Retail or E.Wrath then
			E.db["unitframe"]["units"]["focus"]["name"]["text_format"] = "[namecolor][name:eltruism:abbreviate] [eltruism:class:player] [eltruism:raidmarker]"
		end
	elseif E.db.ElvUI_EltreumUI.unitframes.lightmode == true then
		if E.Classic or E.Wrath then
			E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["text_format"] = "[name][happiness:discord]"
		elseif E.Retail then
			E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["text_format"] = "[name]"
		end
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetName"]["text_format"] = "[name:abbrev]"
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumName"]["text_format"] = "[name] [eltruism:IconOutline:player] [eltruism:raidmarker]"
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"]["text_format"] = "[eltruism:raidmarker] [eltruism:IconOutline:player] [eltruism:difficulty][name:eltruism:abbreviate]"
			E.db["unitframe"]["units"]["tank"]["name"]["text_format"] = "[name:long:status]"
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetName"]["text_format"] = "[name:abbrev]"
		if E.Retail or E.Wrath then
			E.db["unitframe"]["units"]["focus"]["name"]["text_format"] = "[namecolor][name:eltruism:abbreviate] [eltruism:IconOutline:player] [eltruism:raidmarker]"
		end
	end

	if E.db["datatexts"]["panels"]["EltruismTime"] and E.db["datatexts"]["panels"]["EltruismTime"]["enable"] then
		E.global["datatexts"]["customPanels"]["EltruismTime"]["fonts"]["font"] = "Kimberley"
	end

	if IsAddOnLoaded("ElvUI_FCT") then
		ElvFCT["nameplates"]["frames"]["Player"]["font"] = "Kimberley"
		ElvFCT["nameplates"]["frames"]["Player"]["critFont"] = "Kimberley"
		ElvFCT["nameplates"]["frames"]["FriendlyPlayer"]["font"] = "Kimberley"
		ElvFCT["nameplates"]["frames"]["FriendlyPlayer"]["critFont"] = "Kimberley"
		ElvFCT["nameplates"]["frames"]["FriendlyNPC"]["font"] = "Kimberley"
		ElvFCT["nameplates"]["frames"]["FriendlyNPC"]["critFont"] = "Kimberley"
		ElvFCT["nameplates"]["frames"]["EnemyNPC"]["font"] = "Kimberley"
		ElvFCT["nameplates"]["frames"]["EnemyNPC"]["critFont"] = "Kimberley"
		ElvFCT["nameplates"]["frames"]["EnemyPlayer"]["font"] = "Kimberley"
		ElvFCT["nameplates"]["frames"]["EnemyPlayer"]["critFont"] = "Kimberley"
		ElvFCT["unitframes"]["frames"]["Player"]["font"] = "Kimberley"
		ElvFCT["unitframes"]["frames"]["Player"]["critFont"] = "Kimberley"
		ElvFCT["unitframes"]["frames"]["Target"]["font"] = "Kimberley"
		ElvFCT["unitframes"]["frames"]["Target"]["critFont"] = "Kimberley"
		ElvFCT["unitframes"]["frames"]["TargetTarget"]["font"] = "Kimberley"
		ElvFCT["unitframes"]["frames"]["TargetTarget"]["critFont"] = "Kimberley"
		ElvFCT["unitframes"]["frames"]["TargetTargetTarget"]["font"] = "Kimberley"
		ElvFCT["unitframes"]["frames"]["TargetTargetTarget"]["critFont"] = "Kimberley"
		ElvFCT["unitframes"]["frames"]["Focus"]["font"] = "Kimberley"
		ElvFCT["unitframes"]["frames"]["Focus"]["critFont"] = "Kimberley"
		ElvFCT["unitframes"]["frames"]["FocusTarget"]["font"] = "Kimberley"
		ElvFCT["unitframes"]["frames"]["FocusTarget"]["critFont"] = "Kimberley"
		ElvFCT["unitframes"]["frames"]["Pet"]["font"] = "Kimberley"
		ElvFCT["unitframes"]["frames"]["Pet"]["critFont"] = "Kimberley"
		ElvFCT["unitframes"]["frames"]["PetTarget"]["font"] = "Kimberley"
		ElvFCT["unitframes"]["frames"]["PetTarget"]["critFont"] = "Kimberley"
		ElvFCT["unitframes"]["frames"]["Tank"]["font"] = "Kimberley"
		ElvFCT["unitframes"]["frames"]["Tank"]["critFont"] = "Kimberley"
		ElvFCT["unitframes"]["frames"]["Assist"]["font"] = "Kimberley"
		ElvFCT["unitframes"]["frames"]["Assist"]["critFont"] = "Kimberley"
		ElvFCT["unitframes"]["frames"]["Boss"]["font"] = "Kimberley"
		ElvFCT["unitframes"]["frames"]["Boss"]["critFont"] = "Kimberley"
		ElvFCT["unitframes"]["frames"]["Raid1"]["font"] = "Kimberley"
		ElvFCT["unitframes"]["frames"]["Raid1"]["critFont"] = "Kimberley"
		ElvFCT["unitframes"]["frames"]["Raid2"]["font"] = "Kimberley"
		ElvFCT["unitframes"]["frames"]["Raid2"]["critFont"] = "Kimberley"
		ElvFCT["unitframes"]["frames"]["Raid3"]["font"] = "Kimberley"
		ElvFCT["unitframes"]["frames"]["Raid3"]["critFont"] = "Kimberley"
		ElvFCT["unitframes"]["frames"]["RaidPet"]["font"] = "Kimberley"
		ElvFCT["unitframes"]["frames"]["RaidPet"]["critFont"] = "Kimberley"
		ElvFCT["unitframes"]["frames"]["Party"]["font"] = "Kimberley"
		ElvFCT["unitframes"]["frames"]["Party"]["critFont"] = "Kimberley"
		ElvFCT["unitframes"]["frames"]["Arena"]["font"] = "Kimberley"
		ElvFCT["unitframes"]["frames"]["Arena"]["critFont"] = "Kimberley"
	end

	E:StaggeredUpdateAll(nil, true)
	ElvUI_EltreumUI:Print(L["Kimberley Font has been set."])

	ElvUI_EltreumUI:ResolutionOutline()
end
