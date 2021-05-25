local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local IsAddOnLoaded = IsAddOnLoaded
local sleversioncheck = GetAddOnMetadata('ElvUI_SLE', 'Version')
local _G = _G
local PA = _G.ProjectAzilroka


function ElvUI_EltreumUI:SetupCustomFont(fontvalue)
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
		if ElvUI_EltreumUI.Retail then
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
		if ElvUI_EltreumUI.Retail then
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
	if ElvUI_EltreumUI.Retail then
		PA.db["stAddonManager"]["Font"] = fontvalue
		E.db["sle"]["armory"]["character"]["durability"]["font"] = fontvalue
		E.db["sle"]["armory"]["character"]["enchant"]["font"] = fontvalue
		E.db["sle"]["armory"]["character"]["ilvl"]["font"] = fontvalue
		E.db["sle"]["armory"]["inspect"]["enchant"]["font"] = fontvalue
		E.db["sle"]["armory"]["inspect"]["ilvl"]["font"] = fontvalue
		E.db["sle"]["armory"]["stats"]["catFonts"]["font"] = fontvalue
		E.db["sle"]["armory"]["stats"]["itemLevel"]["font"] = fontvalue
		E.db["sle"]["armory"]["stats"]["statFonts"]["font"] = fontvalue
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
			E.db["sle"]["afk"]["defaultTexts"]["SL_AFKMessage"]["font"] = fontvalue
			E.db["sle"]["afk"]["defaultTexts"]["SL_AFKMessage"]["size"] = 20
			E.db["sle"]["afk"]["defaultTexts"]["SL_AFKMessage"]["xOffset"] = 127
			E.db["sle"]["afk"]["defaultTexts"]["SL_AFKMessage"]["yOffset"] = 0
			E.db["sle"]["afk"]["defaultTexts"]["SL_AFKTimePassed"]["font"] = fontvalue
			E.db["sle"]["afk"]["defaultTexts"]["SL_AFKTimePassed"]["size"] = 20
			E.db["sle"]["afk"]["defaultTexts"]["SL_AFKTimePassed"]["xOffset"] = 4
			E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["anchorPoint"] = "TOPRIGHT"
			E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["attachTo"] = "SL_BottomPanel"
			E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["enable"] = false
			E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["font"] = fontvalue
			E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["xOffset"] = 20
			E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["yOffset"] = 50
			E.db["sle"]["afk"]["defaultTexts"]["SL_GuildName"]["anchorPoint"] = "BOTTOMLEFT"
			E.db["sle"]["afk"]["defaultTexts"]["SL_GuildName"]["attachTo"] = "SL_PlayerName"
			E.db["sle"]["afk"]["defaultTexts"]["SL_GuildName"]["font"] = fontvalue
			E.db["sle"]["afk"]["defaultTexts"]["SL_GuildName"]["size"] = 20
			E.db["sle"]["afk"]["defaultTexts"]["SL_GuildRank"]["anchorPoint"] = "RIGHT"
			E.db["sle"]["afk"]["defaultTexts"]["SL_GuildRank"]["attachTo"] = "SL_GuildName"
			E.db["sle"]["afk"]["defaultTexts"]["SL_GuildRank"]["font"] = fontvalue
			E.db["sle"]["afk"]["defaultTexts"]["SL_GuildRank"]["size"] = 20
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerClass"]["anchorPoint"] = "TOPRIGHT"
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerClass"]["attachTo"] = "SL_TopPanel"
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerClass"]["enable"] = false
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerClass"]["font"] = fontvalue
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerLevel"]["enable"] = false
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["anchorPoint"] = "TOPLEFT"
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["attachTo"] = "SL_BottomPanel"
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["font"] = fontvalue
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["size"] = 20
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["xOffset"] = 128
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["yOffset"] = -30
			E.db["sle"]["afk"]["defaultTexts"]["SL_SubText"]["enable"] = false
			E.db["sle"]["afk"]["defaultTexts"]["SL_SubText"]["size"] = 16
			E.db["sle"]["afk"]["defaultTexts"]["SL_SubText"]["xOffset"] = 0
			E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["anchorPoint"] = "CENTER"
			E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["attachTo"] = "SL_BottomPanel"
			E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["font"] = fontvalue
			E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["size"] = 32
			E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["yOffset"] = 40
			E.db["sle"]["afk"]["enable"] = true
			E.db["sle"]["afk"]["panels"]["bottom"]["height"] = 120
			E.db["sle"]["afk"]["panels"]["top"]["height"] = 120
			E.db["sle"]["afk"]["playermodel"]["anim"] = 47
		else
			E.db["sle"]["screensaver"]["date"]["font"] = fontvalue
			E.db["sle"]["screensaver"]["player"]["font"] = fontvalue
			E.db["sle"]["screensaver"]["subtitle"]["font"] = fontvalue
			E.db["sle"]["screensaver"]["tips"]["font"] = fontvalue
			E.db["sle"]["screensaver"]["title"]["font"] = fontvalue
		end

		E.db["sle"]["skins"]["merchant"]["list"]["nameFont"] = fontvalue
		E.db["sle"]["skins"]["merchant"]["list"]["subFont"] = fontvalue
		E.private["WT"]["skins"]["ime"]["label"]["name"] = fontvalue
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["bindFont"]["name"] = fontvalue
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["countFont"]["name"] = fontvalue
		E.db["WT"]["item"]["inspect"]["levelText"]["name"] = fontvalue
		E.db["WT"]["misc"]["gameBar"]["additionalText"]["font"]["name"] = fontvalue
		E.db["WT"]["misc"]["gameBar"]["time"]["font"]["name"] = fontvalue
		E.db["general"]["altPowerBar"]["font"] = fontvalue
		E.db["general"]["itemLevel"]["itemLevelFont"] = fontvalue
	end
		E.db["general"]["font"] = fontvalue
		E.db["general"]["minimap"]["locationFont"] = fontvalue
		E.db["bags"]["countFont"] = fontvalue
		E.db["bags"]["itemInfoFont"] = fontvalue
		E.db["bags"]["itemLevelFont"] = fontvalue
		E.db["chat"]["font"] = fontvalue
		E.db["chat"]["tabFont"] = fontvalue
		E.db["cooldown"]["fonts"]["font"] = fontvalue
		if ElvUI_EltreumUI.Retail then
			E.db["databars"]["honor"]["font"] = fontvalue
			E.db["databars"]["azerite"]["font"] = fontvalue
		end
		E.db["databars"]["experience"]["font"] = fontvalue
		E.db["databars"]["reputation"]["font"] = fontvalue
		E.db["databars"]["threat"]["font"] = fontvalue
		E.db["datatexts"]["font"] = fontvalue
		E.db["tooltip"]["font"] = fontvalue
		E.db["tooltip"]["healthBar"]["font"] = fontvalue

		-- Custom Text: Party
		E.db["unitframe"]["units"]["party"]["customTexts"] = E.db["unitframe"]["units"]["party"]["customTexts"] or {}
		E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyHealth"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = fontvalue,
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
			["font"] = fontvalue,
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
			["font"] = fontvalue,
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 11,
			["text_format"] = "[powercolor][power:current:shortvalue]",
			["xOffset"] = 0,
			["yOffset"] = 0
		}
		if ElvUI_EltreumUI.Retail then
			E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyAbsorb"] = {
			["attachTextTo"] = "Health",
			["enable"] = false,
			["font"] = fontvalue,
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 11,
			["text_format"] = "||cffFFFF00[absorbs]||r ",
			["xOffset"] = 6,
			["yOffset"] = 0
			}
		end
		-- Custom Text: Pet
		E.db["unitframe"]["units"]["pet"]["customTexts"] = E.db["unitframe"]["units"]["pet"]["customTexts"] or {}
		E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = fontvalue,
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "CENTER",
			["size"] = 12,
			["text_format"] = "[namecolor][name]",
			["xOffset"] = 0,
			["yOffset"] = 0
		}
		-- Custom Text: Player
		E.db["unitframe"]["units"]["player"]["customTexts"] = E.db["unitframe"]["units"]["player"]["customTexts"] or {}
		if ElvUI_EltreumUI.Retail then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPlayerAbsorb"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = fontvalue,
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 12,
			["text_format"] = "||cffFFFF00[absorbs]||r ",
			["xOffset"] = 6,
			["yOffset"] = 15
			}
		end
		E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumHealth"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = fontvalue,
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
			["font"] = fontvalue,
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
			["font"] = fontvalue,
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
			["font"] = fontvalue,
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
			["font"] = fontvalue,
			["fontOutline"] = "NONE",
			["justifyH"] = "LEFT",
			["size"] = 8,
			["text_format"] = " Group [group]",
			["xOffset"] = 37,
			["yOffset"] = 10
		}
		if ElvUI_EltreumUI.Retail then
			E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumRaidAbsorb"] = {
			["attachTextTo"] = "Health",
			["enable"] = false,
			["font"] = fontvalue,
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "CENTER",
			["size"] = 10,
			["text_format"] = "||cffFFFF00[absorbs]||r",
			["xOffset"] = 45,
			["yOffset"] = 0
			}
		end
		E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumRaidHealth"]= {
		["attachTextTo"] = "InfoPanel",
		["enable"] = true,
		["font"] = fontvalue,
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
		["font"] = fontvalue,
		["fontOutline"] = "OUTLINE",
		["justifyH"] = "LEFT",
		["size"] = 10,
		["text_format"] = "[namecolor][name:medium] [difficultycolor][smartlevel]",
		["xOffset"] = 0,
		["yOffset"] = 0
		}
		-- Custom Text: Raid 40
		E.db["unitframe"]["units"]["raid40"]["customTexts"] = E.db["unitframe"]["units"]["raid40"]["customTexts"] or {}
		if ElvUI_EltreumUI.Retail then
			E.db["unitframe"]["units"]["raid40"]["customTexts"]["EltreumRaid40Absorb"] = {
			["attachTextTo"] = "Health",
			["enable"] = false,
			["font"] = fontvalue,
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "CENTER",
			["size"] = 10,
			["text_format"] = "||cffFFFF00[absorbs]||r",
			["xOffset"] = 37,
			["yOffset"] = 12
			}
		end
		E.db["unitframe"]["units"]["raid40"]["customTexts"]["EltreumRaid40Group"] = {
			["attachTextTo"] = "Health",
			["enable"] = false,
			["font"] = fontvalue,
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
			["font"] = fontvalue,
			["fontOutline"] = "OUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 10,
			["text_format"] = "[health:current:shortvalue]",
			["xOffset"] = 0,
			["yOffset"] = 0
		}
		-- Custom Text: Target
		E.db["unitframe"]["units"]["target"]["customTexts"] = E.db["unitframe"]["units"]["target"]["customTexts"] or {}
		if ElvUI_EltreumUI.Retail then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetAbsorb"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = fontvalue,
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
			["font"] = fontvalue,
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
			["font"] = fontvalue,
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 16,
			["text_format"] = "[namecolor][name:eltruism:abbreviate]",
			["xOffset"] = -2,
			["yOffset"] = 0
		}
		E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetPower"] = {
		["attachTextTo"] = "Power",
		["enable"] = true,
		["font"] = fontvalue,
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
		["font"] = fontvalue,
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
			["font"] = fontvalue,
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
			["font"] = fontvalue,
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
		["font"] = fontvalue,
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "RIGHT",
		["size"] = 9,
		["text_format"] = "[powercolor][power:current:shortvalue]",
		["xOffset"] = 0,
		["yOffset"] = -1
		}

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
		if ElvUI_EltreumUI.Retail then
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
		if ElvUI_EltreumUI.Retail then
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
		E.db["unitframe"]["units"]["raid"]["buffs"]["countFont"] = fontvalue
		E.db["unitframe"]["units"]["raid"]["debuffs"]["countFont"] = fontvalue
		E.db["unitframe"]["units"]["raid"]["rdebuffs"]["font"] = fontvalue
		E.db["unitframe"]["units"]["raid40"]["rdebuffs"]["font"] = fontvalue
		E.db["unitframe"]["units"]["tank"]["buffs"]["countFont"] = fontvalue
		E.db["unitframe"]["units"]["tank"]["debuffs"]["countFont"] = fontvalue
		E.db["unitframe"]["units"]["tank"]["rdebuffs"]["font"] = fontvalue
		E.db["unitframe"]["units"]["target"]["buffs"]["countFont"] = fontvalue
		E.db["unitframe"]["units"]["target"]["debuffs"]["countFont"] = fontvalue
		E.db["unitframe"]["units"]["targettargettarget"]["buffs"]["countFont"] = fontvalue
		E.db["unitframe"]["units"]["targettargettarget"]["debuffs"]["countFont"] = fontvalue

	E:StaggeredUpdateAll(nil, true)
	ElvUI_EltreumUI:Print('Your custom font has been set.')
end

function ElvUI_EltreumUI:SetupFontsKimberley(addon)
	if not E.db.movers then E.db.movers = {} end
		E.db["nameplates"]["cooldown"]["fonts"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["countFont"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["countFont"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["health"]["text"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["name"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["power"]["text"]["font"] = "Kimberley"
		if ElvUI_EltreumUI.Retail then
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
		if ElvUI_EltreumUI.Retail then
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
	if ElvUI_EltreumUI.Retail then
		PA.db["stAddonManager"]["Font"] = "Kimberley"
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
		else
			E.db["sle"]["screensaver"]["date"]["font"] = "Kimberley"
			E.db["sle"]["screensaver"]["player"]["font"] = "Kimberley"
			E.db["sle"]["screensaver"]["subtitle"]["font"] = "Kimberley"
			E.db["sle"]["screensaver"]["tips"]["font"] = "Kimberley"
			E.db["sle"]["screensaver"]["title"]["font"] = "Kimberley"
		end
		E.db["sle"]["skins"]["merchant"]["list"]["nameFont"] = "Kimberley"
		E.db["sle"]["skins"]["merchant"]["list"]["subFont"] = "Kimberley"
		E.private["WT"]["skins"]["ime"]["label"]["name"] = "Kimberley"
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["bindFont"]["name"] = "Kimberley"
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["countFont"]["name"] = "Kimberley"
		E.db["WT"]["item"]["inspect"]["levelText"]["name"] = "Kimberley"
		E.db["WT"]["misc"]["gameBar"]["additionalText"]["font"]["name"] = "Kimberley"
		E.db["WT"]["misc"]["gameBar"]["time"]["font"]["name"] = "Kimberley"
		E.db["general"]["altPowerBar"]["font"] = "Kimberley"
		E.db["general"]["itemLevel"]["itemLevelFont"] = "Kimberley"
	end
		E.db["general"]["font"] = "Kimberley"
		E.db["general"]["minimap"]["locationFont"] = "Kimberley"
		E.db["bags"]["countFont"] = "Kimberley"
		E.db["bags"]["itemInfoFont"] = "Kimberley"
		E.db["bags"]["itemLevelFont"] = "Kimberley"
		E.db["chat"]["font"] = "Kimberley"
		E.db["chat"]["tabFont"] = "Kimberley"
		E.db["cooldown"]["fonts"]["font"] = "Kimberley"
		if ElvUI_EltreumUI.Retail then
			E.db["databars"]["azerite"]["font"] = "Kimberley"
			E.db["databars"]["honor"]["font"] = "Kimberley"
		end
		E.db["databars"]["experience"]["font"] = "Kimberley"
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
		if ElvUI_EltreumUI.Retail then
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
		if ElvUI_EltreumUI.Retail then
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
		if ElvUI_EltreumUI.Retail then
			E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumRaidAbsorb"] = {
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
		if ElvUI_EltreumUI.Retail then
			E.db["unitframe"]["units"]["raid40"]["customTexts"]["EltreumRaid40Absorb"] = {
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
		if ElvUI_EltreumUI.Retail then
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
			["text_format"] = "[namecolor][name:eltruism:abbreviate]",
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
		if ElvUI_EltreumUI.Retail then
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
		if ElvUI_EltreumUI.Retail then
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
		ElvUI_EltreumUI:Print('Kimberley Font has been set.')
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
		if ElvUI_EltreumUI.Retail then
			E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["font"] = "Exo2 Extra Bold"
		end
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
		if ElvUI_EltreumUI.Retail then
			E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["font"] = "Exo2 Extra Bold"
		end
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
	if ElvUI_EltreumUI.Retail then
		PA.db["stAddonManager"]["Font"] = "Exo2 Extra Bold"
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
			E.db["sle"]["afk"]["defaultTexts"]["SL_AFKMessage"]["font"] = "Exo2 Extra Bold"
			E.db["sle"]["afk"]["defaultTexts"]["SL_AFKMessage"]["size"] = 20
			E.db["sle"]["afk"]["defaultTexts"]["SL_AFKMessage"]["xOffset"] = 127
			E.db["sle"]["afk"]["defaultTexts"]["SL_AFKMessage"]["yOffset"] = 0
			E.db["sle"]["afk"]["defaultTexts"]["SL_AFKTimePassed"]["font"] = "Exo2 Extra Bold"
			E.db["sle"]["afk"]["defaultTexts"]["SL_AFKTimePassed"]["size"] = 20
			E.db["sle"]["afk"]["defaultTexts"]["SL_AFKTimePassed"]["xOffset"] = 4
			E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["anchorPoint"] = "TOPRIGHT"
			E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["attachTo"] = "SL_BottomPanel"
			E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["enable"] = false
			E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["font"] = "Exo2 Extra Bold"
			E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["xOffset"] = 20
			E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["yOffset"] = 50
			E.db["sle"]["afk"]["defaultTexts"]["SL_GuildName"]["anchorPoint"] = "BOTTOMLEFT"
			E.db["sle"]["afk"]["defaultTexts"]["SL_GuildName"]["attachTo"] = "SL_PlayerName"
			E.db["sle"]["afk"]["defaultTexts"]["SL_GuildName"]["font"] = "Exo2 Extra Bold"
			E.db["sle"]["afk"]["defaultTexts"]["SL_GuildName"]["size"] = 20
			E.db["sle"]["afk"]["defaultTexts"]["SL_GuildRank"]["anchorPoint"] = "RIGHT"
			E.db["sle"]["afk"]["defaultTexts"]["SL_GuildRank"]["attachTo"] = "SL_GuildName"
			E.db["sle"]["afk"]["defaultTexts"]["SL_GuildRank"]["font"] = "Exo2 Extra Bold"
			E.db["sle"]["afk"]["defaultTexts"]["SL_GuildRank"]["size"] = 20
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerClass"]["anchorPoint"] = "TOPRIGHT"
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerClass"]["attachTo"] = "SL_TopPanel"
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerClass"]["enable"] = false
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerClass"]["font"] = "Exo2 Extra Bold"
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerLevel"]["enable"] = false
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["anchorPoint"] = "TOPLEFT"
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["attachTo"] = "SL_BottomPanel"
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["font"] = "Exo2 Extra Bold"
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["size"] = 20
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["xOffset"] = 128
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["yOffset"] = -30
			E.db["sle"]["afk"]["defaultTexts"]["SL_SubText"]["enable"] = false
			E.db["sle"]["afk"]["defaultTexts"]["SL_SubText"]["size"] = 16
			E.db["sle"]["afk"]["defaultTexts"]["SL_SubText"]["xOffset"] = 0
			E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["anchorPoint"] = "CENTER"
			E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["attachTo"] = "SL_BottomPanel"
			E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["font"] = "Exo2 Extra Bold"
			E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["size"] = 32
			E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["yOffset"] = 40
			E.db["sle"]["afk"]["enable"] = true
			E.db["sle"]["afk"]["panels"]["bottom"]["height"] = 120
			E.db["sle"]["afk"]["panels"]["top"]["height"] = 120
			E.db["sle"]["afk"]["playermodel"]["anim"] = 47
		else
			E.db["sle"]["screensaver"]["date"]["font"] = "Exo2 Extra Bold"
			E.db["sle"]["screensaver"]["player"]["font"] = "Exo2 Extra Bold"
			E.db["sle"]["screensaver"]["subtitle"]["font"] = "Exo2 Extra Bold"
			E.db["sle"]["screensaver"]["tips"]["font"] = "Exo2 Extra Bold"
			E.db["sle"]["screensaver"]["title"]["font"] = "Exo2 Extra Bold"
		end

		E.db["sle"]["skins"]["merchant"]["list"]["nameFont"] = "Exo2 Extra Bold"
		E.db["sle"]["skins"]["merchant"]["list"]["subFont"] = "Exo2 Extra Bold"
		E.private["WT"]["skins"]["ime"]["label"]["name"] = "Exo2 Extra Bold"
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["bindFont"]["name"] = "Exo2 Extra Bold"
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["countFont"]["name"] = "Exo2 Extra Bold"
		E.db["WT"]["item"]["inspect"]["levelText"]["name"] = "Exo2 Extra Bold"
		E.db["WT"]["misc"]["gameBar"]["additionalText"]["font"]["name"] = "Exo2 Extra Bold"
		E.db["WT"]["misc"]["gameBar"]["time"]["font"]["name"] = "Exo2 Extra Bold"
		E.db["general"]["altPowerBar"]["font"] = "Exo2 Extra Bold"
		E.db["general"]["itemLevel"]["itemLevelFont"] = "Exo2 Extra Bold"
	end
		E.db["general"]["font"] = "Exo2 Extra Bold"
		E.db["general"]["minimap"]["locationFont"] = "Exo2 Extra Bold"
		E.db["bags"]["countFont"] = "Exo2 Extra Bold"
		E.db["bags"]["itemInfoFont"] = "Exo2 Extra Bold"
		E.db["bags"]["itemLevelFont"] = "Exo2 Extra Bold"
		E.db["chat"]["font"] = "Exo2 Extra Bold"
		E.db["chat"]["tabFont"] = "Exo2 Extra Bold"
		E.db["cooldown"]["fonts"]["font"] = "Exo2 Extra Bold"
		if ElvUI_EltreumUI.Retail then
			E.db["databars"]["honor"]["font"] = "Exo2 Extra Bold"
			E.db["databars"]["azerite"]["font"] = "Exo2 Extra Bold"
		end
		E.db["databars"]["experience"]["font"] = "Exo2 Extra Bold"
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
		if ElvUI_EltreumUI.Retail then
			E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyAbsorb"] = {
			["attachTextTo"] = "Health",
			["enable"] = false,
			["font"] = "Exo2 Extra Bold",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 11,
			["text_format"] = "||cffFFFF00[absorbs]||r ",
			["xOffset"] = 6,
			["yOffset"] = 0
			}
		end
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
		if ElvUI_EltreumUI.Retail then
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
		end
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
		if ElvUI_EltreumUI.Retail then
			E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumRaidAbsorb"] = {
			["attachTextTo"] = "Health",
			["enable"] = false,
			["font"] = "Exo2 Extra Bold",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "CENTER",
			["size"] = 10,
			["text_format"] = "||cffFFFF00[absorbs]||r",
			["xOffset"] = 45,
			["yOffset"] = 0
			}
		end
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
		if ElvUI_EltreumUI.Retail then
			E.db["unitframe"]["units"]["raid40"]["customTexts"]["EltreumRaid40Absorb"] = {
			["attachTextTo"] = "Health",
			["enable"] = false,
			["font"] = "Exo2 Extra Bold",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "CENTER",
			["size"] = 10,
			["text_format"] = "||cffFFFF00[absorbs]||r",
			["xOffset"] = 37,
			["yOffset"] = 12
			}
		end
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
		if ElvUI_EltreumUI.Retail then
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
		end
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
			["text_format"] = "[namecolor][name:eltruism:abbreviate]",
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
		if ElvUI_EltreumUI.Retail then
			E.db["actionbar"]["extraActionButton"]["hotkeyFont"] = "Exo2 Extra Bold"
		end
		E.db["actionbar"]["font"] = "Exo2 Extra Bold"
		E.db["actionbar"]["stanceBar"]["hotkeyFont"] = "Exo2 Extra Bold"
		E.db["actionbar"]["vehicleExitButton"]["hotkeyFont"] = "Exo2 Extra Bold"
		E.db["auras"]["buffs"]["countFont"] = "Exo2 Extra Bold"
		E.db["auras"]["buffs"]["timeFont"] = "Exo2 Extra Bold"
		E.db["auras"]["debuffs"]["countFont"] = "Exo2 Extra Bold"
		E.db["auras"]["debuffs"]["timeFont"] = "Exo2 Extra Bold"
		E.db["unitframe"]["font"] = "Exo2 Extra Bold"
		if ElvUI_EltreumUI.Retail then
			E.db["unitframe"]["units"]["arena"]["buffs"]["countFont"] = "Exo2 Extra Bold"
			E.db["unitframe"]["units"]["arena"]["debuffs"]["countFont"] = "Exo2 Extra Bold"
			E.db["unitframe"]["units"]["assist"]["buffs"]["countFont"] = "Exo2 Extra Bold"
			E.db["unitframe"]["units"]["assist"]["debuffs"]["countFont"] = "Exo2 Extra Bold"
			E.db["unitframe"]["units"]["assist"]["rdebuffs"]["font"] = "Exo2 Extra Bold"
			E.db["unitframe"]["units"]["boss"]["buffs"]["countFont"] = "Exo2 Extra Bold"
			E.db["unitframe"]["units"]["boss"]["debuffs"]["countFont"] = "Exo2 Extra Bold"
			E.db["unitframe"]["units"]["focus"]["debuffs"]["countFont"] = "Exo2 Extra Bold"
			E.db["unitframe"]["units"]["party"]["castbar"]["customTextFont"]["font"] = "Exo2 Extra Bold"
			E.db["unitframe"]["units"]["player"]["castbar"]["customTimeFont"]["font"] = "Exo2 Extra Bold"
		end
		E.db["unitframe"]["units"]["party"]["buffs"]["countFont"] = "Exo2 Extra Bold"
		E.db["unitframe"]["units"]["party"]["debuffs"]["countFont"] = "Exo2 Extra Bold"
		E.db["unitframe"]["units"]["party"]["rdebuffs"]["font"] = "Exo2 Extra Bold"
		E.db["unitframe"]["units"]["player"]["buffs"]["countFont"] = "Exo2 Extra Bold"
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
	ElvUI_EltreumUI:Print('Exo2 Font has been set.')
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
		if ElvUI_EltreumUI.Retail then
			E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["font"] = "GothamNarrow Black"
		end
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
		if ElvUI_EltreumUI.Retail then
			E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["font"] = "GothamNarrow Black"
		end
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
	if ElvUI_EltreumUI.Retail then
		PA.db["stAddonManager"]["Font"] = "GothamNarrow Black"
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
			E.db["sle"]["afk"]["defaultTexts"]["SL_AFKMessage"]["font"] = "GothamNarrow Black"
			E.db["sle"]["afk"]["defaultTexts"]["SL_AFKMessage"]["size"] = 20
			E.db["sle"]["afk"]["defaultTexts"]["SL_AFKMessage"]["xOffset"] = 127
			E.db["sle"]["afk"]["defaultTexts"]["SL_AFKMessage"]["yOffset"] = 0
			E.db["sle"]["afk"]["defaultTexts"]["SL_AFKTimePassed"]["font"] = "GothamNarrow Black"
			E.db["sle"]["afk"]["defaultTexts"]["SL_AFKTimePassed"]["size"] = 20
			E.db["sle"]["afk"]["defaultTexts"]["SL_AFKTimePassed"]["xOffset"] = 4
			E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["anchorPoint"] = "TOPRIGHT"
			E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["attachTo"] = "SL_BottomPanel"
			E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["enable"] = false
			E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["font"] = "GothamNarrow Black"
			E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["xOffset"] = 20
			E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["yOffset"] = 50
			E.db["sle"]["afk"]["defaultTexts"]["SL_GuildName"]["anchorPoint"] = "BOTTOMLEFT"
			E.db["sle"]["afk"]["defaultTexts"]["SL_GuildName"]["attachTo"] = "SL_PlayerName"
			E.db["sle"]["afk"]["defaultTexts"]["SL_GuildName"]["font"] = "GothamNarrow Black"
			E.db["sle"]["afk"]["defaultTexts"]["SL_GuildName"]["size"] = 20
			E.db["sle"]["afk"]["defaultTexts"]["SL_GuildRank"]["anchorPoint"] = "RIGHT"
			E.db["sle"]["afk"]["defaultTexts"]["SL_GuildRank"]["attachTo"] = "SL_GuildName"
			E.db["sle"]["afk"]["defaultTexts"]["SL_GuildRank"]["font"] = "GothamNarrow Black"
			E.db["sle"]["afk"]["defaultTexts"]["SL_GuildRank"]["size"] = 20
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerClass"]["anchorPoint"] = "TOPRIGHT"
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerClass"]["attachTo"] = "SL_TopPanel"
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerClass"]["enable"] = false
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerClass"]["font"] = "GothamNarrow Black"
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerLevel"]["enable"] = false
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["anchorPoint"] = "TOPLEFT"
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["attachTo"] = "SL_BottomPanel"
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["font"] = "GothamNarrow Black"
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["size"] = 20
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["xOffset"] = 128
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["yOffset"] = -30
			E.db["sle"]["afk"]["defaultTexts"]["SL_SubText"]["enable"] = false
			E.db["sle"]["afk"]["defaultTexts"]["SL_SubText"]["size"] = 16
			E.db["sle"]["afk"]["defaultTexts"]["SL_SubText"]["xOffset"] = 0
			E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["anchorPoint"] = "CENTER"
			E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["attachTo"] = "SL_BottomPanel"
			E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["font"] = "GothamNarrow Black"
			E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["size"] = 32
			E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["yOffset"] = 40
			E.db["sle"]["afk"]["enable"] = true
			E.db["sle"]["afk"]["panels"]["bottom"]["height"] = 120
			E.db["sle"]["afk"]["panels"]["top"]["height"] = 120
			E.db["sle"]["afk"]["playermodel"]["anim"] = 47
		else
			E.db["sle"]["screensaver"]["date"]["font"] = "GothamNarrow Black"
			E.db["sle"]["screensaver"]["player"]["font"] = "GothamNarrow Black"
			E.db["sle"]["screensaver"]["subtitle"]["font"] = "GothamNarrow Black"
			E.db["sle"]["screensaver"]["tips"]["font"] = "GothamNarrow Black"
			E.db["sle"]["screensaver"]["title"]["font"] = "GothamNarrow Black"
		end
		E.db["sle"]["skins"]["merchant"]["list"]["nameFont"] = "GothamNarrow Black"
		E.db["sle"]["skins"]["merchant"]["list"]["subFont"] = "GothamNarrow Black"
		E.private["WT"]["skins"]["ime"]["label"]["name"] = "GothamNarrow Black"
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["bindFont"]["name"] = "GothamNarrow Black"
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["countFont"]["name"] = "GothamNarrow Black"
		E.db["WT"]["item"]["inspect"]["levelText"]["name"] = "GothamNarrow Black"
		E.db["WT"]["misc"]["gameBar"]["additionalText"]["font"]["name"] = "GothamNarrow Black"
		E.db["WT"]["misc"]["gameBar"]["time"]["font"]["name"] = "GothamNarrow Black"
		E.db["general"]["altPowerBar"]["font"] = "GothamNarrow Black"
		E.db["general"]["itemLevel"]["itemLevelFont"] = "GothamNarrow Black"
	end
		E.db["general"]["font"] = "GothamNarrow Black"
		E.db["general"]["minimap"]["locationFont"] = "GothamNarrow Black"
		E.db["bags"]["countFont"] = "GothamNarrow Black"
		E.db["bags"]["itemInfoFont"] = "GothamNarrow Black"
		E.db["bags"]["itemLevelFont"] = "GothamNarrow Black"
		E.db["chat"]["font"] = "GothamNarrow Black"
		E.db["chat"]["tabFont"] = "GothamNarrow Black"
		E.db["cooldown"]["fonts"]["font"] = "GothamNarrow Black"
		if ElvUI_EltreumUI.Retail then
			E.db["databars"]["honor"]["font"] = "GothamNarrow Black"
			E.db["databars"]["azerite"]["font"] = "GothamNarrow Black"
		end
		E.db["databars"]["experience"]["font"] = "GothamNarrow Black"
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
		if ElvUI_EltreumUI.Retail then
			E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyAbsorb"] = {
			["attachTextTo"] = "Health",
			["enable"] = false,
			["font"] = "GothamNarrow Black",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 11,
			["text_format"] = "||cffFFFF00[absorbs]||r ",
			["xOffset"] = 6,
			["yOffset"] = 0
			}
		end
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
		if ElvUI_EltreumUI.Retail then
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
		end
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
		if ElvUI_EltreumUI.Retail then
			E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumRaidAbsorb"] = {
			["attachTextTo"] = "Health",
			["enable"] = false,
			["font"] = "GothamNarrow Black",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "CENTER",
			["size"] = 10,
			["text_format"] = "||cffFFFF00[absorbs]||r",
			["xOffset"] = 45,
			["yOffset"] = 0
			}
		end
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
		if ElvUI_EltreumUI.Retail then
			E.db["unitframe"]["units"]["raid40"]["customTexts"]["EltreumRaid40Absorb"] = {
			["attachTextTo"] = "Health",
			["enable"] = false,
			["font"] = "GothamNarrow Black",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "CENTER",
			["size"] = 10,
			["text_format"] = "||cffFFFF00[absorbs]||r",
			["xOffset"] = 37,
			["yOffset"] = 12
			}
		end
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
		if ElvUI_EltreumUI.Retail then
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
		end
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
			["text_format"] = "[namecolor][name:eltruism:abbreviate]",
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
		if ElvUI_EltreumUI.Retail then
			E.db["actionbar"]["extraActionButton"]["hotkeyFont"] = "GothamNarrow Black"
		end
		E.db["actionbar"]["font"] = "GothamNarrow Black"
		E.db["actionbar"]["stanceBar"]["hotkeyFont"] = "GothamNarrow Black"
		E.db["actionbar"]["vehicleExitButton"]["hotkeyFont"] = "GothamNarrow Black"
		E.db["auras"]["buffs"]["countFont"] = "GothamNarrow Black"
		E.db["auras"]["buffs"]["timeFont"] = "GothamNarrow Black"
		E.db["auras"]["debuffs"]["countFont"] = "GothamNarrow Black"
		E.db["auras"]["debuffs"]["timeFont"] = "GothamNarrow Black"
		E.db["unitframe"]["font"] = "GothamNarrow Black"
		if ElvUI_EltreumUI.Retail then
			E.db["unitframe"]["units"]["arena"]["buffs"]["countFont"] = "GothamNarrow Black"
			E.db["unitframe"]["units"]["arena"]["debuffs"]["countFont"] = "GothamNarrow Black"
			E.db["unitframe"]["units"]["assist"]["buffs"]["countFont"] = "GothamNarrow Black"
			E.db["unitframe"]["units"]["assist"]["debuffs"]["countFont"] = "GothamNarrow Black"
			E.db["unitframe"]["units"]["assist"]["rdebuffs"]["font"] = "GothamNarrow Black"
			E.db["unitframe"]["units"]["boss"]["buffs"]["countFont"] = "GothamNarrow Black"
			E.db["unitframe"]["units"]["boss"]["debuffs"]["countFont"] = "GothamNarrow Black"
			E.db["unitframe"]["units"]["focus"]["debuffs"]["countFont"] = "GothamNarrow Black"
			E.db["unitframe"]["units"]["party"]["castbar"]["customTextFont"]["font"] = "GothamNarrow Black"
			E.db["unitframe"]["units"]["player"]["castbar"]["customTimeFont"]["font"] = "GothamNarrow Black"
		end
		E.db["unitframe"]["units"]["party"]["buffs"]["countFont"] = "GothamNarrow Black"
		E.db["unitframe"]["units"]["party"]["debuffs"]["countFont"] = "GothamNarrow Black"
		E.db["unitframe"]["units"]["party"]["rdebuffs"]["font"] = "GothamNarrow Black"
		E.db["unitframe"]["units"]["player"]["buffs"]["countFont"] = "GothamNarrow Black"
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
		ElvUI_EltreumUI:Print('GothamNarrow Black Font has been set.')
end

function ElvUI_EltreumUI:SetupFontsRoboto(addon)
	if not E.db.movers then E.db.movers = {} end
		--nameplates
		E.db["nameplates"]["cooldown"]["fonts"]["font"] = "Roboto"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["countFont"] = "Roboto"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["font"] = "Roboto"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["countFont"] = "Roboto"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["health"]["text"]["font"] = "Roboto"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["font"] = "Roboto"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["name"]["font"] = "Roboto"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["power"]["text"]["font"] = "Roboto"
		if ElvUI_EltreumUI.Retail then
			E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["font"] = "Roboto"
		end
		E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["font"] = "Roboto"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["countFont"] = "Roboto"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["font"] = "Roboto"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["countFont"] = "Roboto"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["health"]["text"]["font"] = "Roboto"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["font"] = "Roboto"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["name"]["font"] = "Roboto"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["power"]["text"]["font"] = "Roboto"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["title"]["font"] = "Roboto"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["buffs"]["countFont"] = "Roboto"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["castbar"]["font"] = "Roboto"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["debuffs"]["countFont"] = "Roboto"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["health"]["text"]["font"] = "Roboto"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["level"]["font"] = "Roboto"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["name"]["font"] = "Roboto"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["power"]["text"]["font"] = "Roboto"
		if ElvUI_EltreumUI.Retail then
			E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["font"] = "Roboto"
		end
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["title"]["font"] = "Roboto"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["buffs"]["countFont"] = "Roboto"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["castbar"]["font"] = "Roboto"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["debuffs"]["countFont"] = "Roboto"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["health"]["text"]["font"] = "Roboto"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["level"]["font"] = "Roboto"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["name"]["font"] = "Roboto"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["power"]["text"]["font"] = "Roboto"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["title"]["font"] = "Roboto"
		E.db["nameplates"]["units"]["PLAYER"]["buffs"]["countFont"] = "Roboto"
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["font"] = "Roboto"
		E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["countFont"] = "Roboto"
		E.db["nameplates"]["units"]["PLAYER"]["health"]["text"]["font"] = "Roboto"
		E.db["nameplates"]["units"]["PLAYER"]["level"]["font"] = "Roboto"
		E.db["nameplates"]["units"]["PLAYER"]["name"]["font"] = "Roboto"
		E.db["nameplates"]["units"]["PLAYER"]["power"]["text"]["font"] = "Roboto"
		E.db["nameplates"]["units"]["PLAYER"]["title"]["font"] = "Roboto"
		E.private["general"]["chatBubbleFont"] = "Roboto"
		E.private["general"]["dmgfont"] = "Roboto"
		E.private["general"]["namefont"] = "Roboto"
	if ElvUI_EltreumUI.Retail then
		PA.db["stAddonManager"]["Font"] = "Roboto"
		E.db["sle"]["armory"]["character"]["durability"]["font"] = "Roboto"
		E.db["sle"]["armory"]["character"]["enchant"]["font"] = "Roboto"
		E.db["sle"]["armory"]["character"]["ilvl"]["font"] = "Roboto"
		E.db["sle"]["armory"]["inspect"]["enchant"]["font"] = "Roboto"
		E.db["sle"]["armory"]["inspect"]["ilvl"]["font"] = "Roboto"
		E.db["sle"]["armory"]["stats"]["catFonts"]["font"] = "Roboto"
		E.db["sle"]["armory"]["stats"]["itemLevel"]["font"] = "Roboto"
		E.db["sle"]["armory"]["stats"]["statFonts"]["font"] = "Roboto"
		E.db["sle"]["media"]["fonts"]["gossip"]["font"] = "Roboto"
		E.db["sle"]["media"]["fonts"]["mail"]["font"] = "Roboto"
		E.db["sle"]["media"]["fonts"]["objective"]["font"] = "Roboto"
		E.db["sle"]["media"]["fonts"]["objectiveHeader"]["font"] = "Roboto"
		E.db["sle"]["media"]["fonts"]["pvp"]["font"] = "Roboto"
		E.db["sle"]["media"]["fonts"]["questFontSuperHuge"]["font"] = "Roboto"
		E.db["sle"]["media"]["fonts"]["subzone"]["font"] = "Roboto"
		E.db["sle"]["media"]["fonts"]["zone"]["font"] = "Roboto"
		E.db["sle"]["minimap"]["coords"]["font"] = "Roboto"
		E.db["sle"]["minimap"]["instance"]["font"] = "Roboto"
		E.db["sle"]["minimap"]["locPanel"]["font"] = "Roboto"
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
			E.db["sle"]["afk"]["defaultTexts"]["SL_AFKMessage"]["font"] = "Roboto"
			E.db["sle"]["afk"]["defaultTexts"]["SL_AFKMessage"]["size"] = 20
			E.db["sle"]["afk"]["defaultTexts"]["SL_AFKMessage"]["xOffset"] = 127
			E.db["sle"]["afk"]["defaultTexts"]["SL_AFKMessage"]["yOffset"] = 0
			E.db["sle"]["afk"]["defaultTexts"]["SL_AFKTimePassed"]["font"] = "Roboto"
			E.db["sle"]["afk"]["defaultTexts"]["SL_AFKTimePassed"]["size"] = 20
			E.db["sle"]["afk"]["defaultTexts"]["SL_AFKTimePassed"]["xOffset"] = 4
			E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["anchorPoint"] = "TOPRIGHT"
			E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["attachTo"] = "SL_BottomPanel"
			E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["enable"] = false
			E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["font"] = "Roboto"
			E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["xOffset"] = 20
			E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["yOffset"] = 50
			E.db["sle"]["afk"]["defaultTexts"]["SL_GuildName"]["anchorPoint"] = "BOTTOMLEFT"
			E.db["sle"]["afk"]["defaultTexts"]["SL_GuildName"]["attachTo"] = "SL_PlayerName"
			E.db["sle"]["afk"]["defaultTexts"]["SL_GuildName"]["font"] = "Roboto"
			E.db["sle"]["afk"]["defaultTexts"]["SL_GuildName"]["size"] = 20
			E.db["sle"]["afk"]["defaultTexts"]["SL_GuildRank"]["anchorPoint"] = "RIGHT"
			E.db["sle"]["afk"]["defaultTexts"]["SL_GuildRank"]["attachTo"] = "SL_GuildName"
			E.db["sle"]["afk"]["defaultTexts"]["SL_GuildRank"]["font"] = "Roboto"
			E.db["sle"]["afk"]["defaultTexts"]["SL_GuildRank"]["size"] = 20
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerClass"]["anchorPoint"] = "TOPRIGHT"
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerClass"]["attachTo"] = "SL_TopPanel"
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerClass"]["enable"] = false
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerClass"]["font"] = "Roboto"
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerLevel"]["enable"] = false
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["anchorPoint"] = "TOPLEFT"
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["attachTo"] = "SL_BottomPanel"
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["font"] = "Roboto"
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["size"] = 20
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["xOffset"] = 128
			E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["yOffset"] = -30
			E.db["sle"]["afk"]["defaultTexts"]["SL_SubText"]["enable"] = false
			E.db["sle"]["afk"]["defaultTexts"]["SL_SubText"]["size"] = 16
			E.db["sle"]["afk"]["defaultTexts"]["SL_SubText"]["xOffset"] = 0
			E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["anchorPoint"] = "CENTER"
			E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["attachTo"] = "SL_BottomPanel"
			E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["font"] = "Roboto"
			E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["size"] = 32
			E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["yOffset"] = 40
			E.db["sle"]["afk"]["enable"] = true
			E.db["sle"]["afk"]["panels"]["bottom"]["height"] = 120
			E.db["sle"]["afk"]["panels"]["top"]["height"] = 120
			E.db["sle"]["afk"]["playermodel"]["anim"] = 47
		else
			E.db["sle"]["screensaver"]["date"]["font"] = "Roboto"
			E.db["sle"]["screensaver"]["player"]["font"] = "Roboto"
			E.db["sle"]["screensaver"]["subtitle"]["font"] = "Roboto"
			E.db["sle"]["screensaver"]["tips"]["font"] = "Roboto"
			E.db["sle"]["screensaver"]["title"]["font"] = "Roboto"
		end
		E.db["sle"]["skins"]["merchant"]["list"]["nameFont"] = "Roboto"
		E.db["sle"]["skins"]["merchant"]["list"]["subFont"] = "Roboto"
		E.private["WT"]["skins"]["ime"]["label"]["name"] = "Roboto"
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["bindFont"]["name"] = "Roboto"
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["countFont"]["name"] = "Roboto"
		E.db["WT"]["item"]["inspect"]["levelText"]["name"] = "Roboto"
		E.db["WT"]["misc"]["gameBar"]["additionalText"]["font"]["name"] = "Roboto"
		E.db["WT"]["misc"]["gameBar"]["time"]["font"]["name"] = "Roboto"
		E.db["general"]["altPowerBar"]["font"] = "Roboto"
		E.db["general"]["itemLevel"]["itemLevelFont"] = "Roboto"
	end
		E.db["general"]["font"] = "Roboto"
		E.db["general"]["minimap"]["locationFont"] = "Roboto"
		E.db["bags"]["countFont"] = "Roboto"
		E.db["bags"]["itemInfoFont"] = "Roboto"
		E.db["bags"]["itemLevelFont"] = "Roboto"
		E.db["chat"]["font"] = "Roboto"
		E.db["chat"]["tabFont"] = "Roboto"
		E.db["cooldown"]["fonts"]["font"] = "Roboto"
		if ElvUI_EltreumUI.Retail then
			E.db["databars"]["azerite"]["font"] = "Roboto"
			E.db["databars"]["honor"]["font"] = "Roboto"
		end
		E.db["databars"]["experience"]["font"] = "Roboto"
		E.db["databars"]["reputation"]["font"] = "Roboto"
		E.db["databars"]["threat"]["font"] = "Roboto"
		E.db["datatexts"]["font"] = "Roboto"
		E.db["tooltip"]["font"] = "Roboto"
		E.db["tooltip"]["healthBar"]["font"] = "Roboto"


		-- Custom Text: Party
		E.db["unitframe"]["units"]["party"]["customTexts"] = E.db["unitframe"]["units"]["party"]["customTexts"] or {}
		E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyHealth"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "Roboto",
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
			["font"] = "Roboto",
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
			["font"] = "Roboto",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 11,
			["text_format"] = "[powercolor][power:current:shortvalue]",
			["xOffset"] = 0,
			["yOffset"] = 0
		}
		if ElvUI_EltreumUI.Retail then
			E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyAbsorb"] = {
			["attachTextTo"] = "Health",
			["enable"] = false,
			["font"] = "Roboto",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 11,
			["text_format"] = "||cffFFFF00[absorbs]||r ",
			["xOffset"] = 6,
			["yOffset"] = 0
			}
		end
		-- Custom Text: Pet
		E.db["unitframe"]["units"]["pet"]["customTexts"] = E.db["unitframe"]["units"]["pet"]["customTexts"] or {}
		E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "Roboto",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "CENTER",
			["size"] = 12,
			["text_format"] = "[namecolor][name]",
			["xOffset"] = 0,
			["yOffset"] = 0
		}
		-- Custom Text: Player
		E.db["unitframe"]["units"]["player"]["customTexts"] = E.db["unitframe"]["units"]["player"]["customTexts"] or {}
		if ElvUI_EltreumUI.Retail then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPlayerAbsorb"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "Roboto",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 12,
			["text_format"] = "||cffFFFF00[absorbs]||r ",
			["xOffset"] = 6,
			["yOffset"] = 15
			}
		end
		E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumHealth"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "Roboto",
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
			["font"] = "Roboto",
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
			["font"] = "Roboto",
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
			["font"] = "Roboto",
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
			["font"] = "Roboto",
			["fontOutline"] = "NONE",
			["justifyH"] = "LEFT",
			["size"] = 8,
			["text_format"] = " Group [group]",
			["xOffset"] = 37,
			["yOffset"] = 10
		}
		if ElvUI_EltreumUI.Retail then
			E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumRaidAbsorb"] = {
			["attachTextTo"] = "Health",
			["enable"] = false,
			["font"] = "Roboto",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "CENTER",
			["size"] = 10,
			["text_format"] = "||cffFFFF00[absorbs]||r",
			["xOffset"] = 45,
			["yOffset"] = 0
			}
		end
		E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumRaidHealth"]= {
		["attachTextTo"] = "InfoPanel",
		["enable"] = true,
		["font"] = "Roboto",
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
		["font"] = "Roboto",
		["fontOutline"] = "OUTLINE",
		["justifyH"] = "LEFT",
		["size"] = 10,
		["text_format"] = "[namecolor][name:medium] [difficultycolor][smartlevel]",
		["xOffset"] = 0,
		["yOffset"] = 0
		}
		-- Custom Text: Raid 40
		E.db["unitframe"]["units"]["raid40"]["customTexts"] = E.db["unitframe"]["units"]["raid40"]["customTexts"] or {}
		if ElvUI_EltreumUI.Retail then
			E.db["unitframe"]["units"]["raid40"]["customTexts"]["EltreumRaid40Absorb"] = {
			["attachTextTo"] = "Health",
			["enable"] = false,
			["font"] = "Roboto",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "CENTER",
			["size"] = 10,
			["text_format"] = "||cffFFFF00[absorbs]||r",
			["xOffset"] = 37,
			["yOffset"] = 12
			}
		end
		E.db["unitframe"]["units"]["raid40"]["customTexts"]["EltreumRaid40Group"] = {
			["attachTextTo"] = "Health",
			["enable"] = false,
			["font"] = "Roboto",
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
			["font"] = "Roboto",
			["fontOutline"] = "OUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 10,
			["text_format"] = "[health:current:shortvalue]",
			["xOffset"] = 0,
			["yOffset"] = 0
		}
		-- Custom Text: Target
		E.db["unitframe"]["units"]["target"]["customTexts"] = E.db["unitframe"]["units"]["target"]["customTexts"] or {}
		if ElvUI_EltreumUI.Retail then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetAbsorb"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "Roboto",
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
			["font"] = "Roboto",
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
			["font"] = "Roboto",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 16,
			["text_format"] = "[namecolor][name:eltruism:abbreviate]",
			["xOffset"] = -2,
			["yOffset"] = 0
		}
		E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetPower"] = {
		["attachTextTo"] = "Power",
		["enable"] = true,
		["font"] = "Roboto",
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
		["font"] = "Roboto",
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
			["font"] = "Roboto",
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
			["font"] = "Roboto",
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
		["font"] = "Roboto",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "RIGHT",
		["size"] = 9,
		["text_format"] = "[powercolor][power:current:shortvalue]",
		["xOffset"] = 0,
		["yOffset"] = -1
		}

		--ActionBars
		E.db["actionbar"]["bar1"]["countFont"] = "Roboto"
		E.db["actionbar"]["bar1"]["hotkeyFont"] = "Roboto"
		E.db["actionbar"]["bar1"]["macroFont"] = "Roboto"
		E.db["actionbar"]["bar10"]["countFont"] = "Roboto"
		E.db["actionbar"]["bar10"]["hotkeyFont"] = "Roboto"
		E.db["actionbar"]["bar10"]["macroFont"] = "Roboto"
		E.db["actionbar"]["bar2"]["countFont"] = "Roboto"
		E.db["actionbar"]["bar2"]["hotkeyFont"] = "Roboto"
		E.db["actionbar"]["bar2"]["macroFont"] = "Roboto"
		E.db["actionbar"]["bar3"]["countFont"] = "Roboto"
		E.db["actionbar"]["bar3"]["hotkeyFont"] = "Roboto"
		E.db["actionbar"]["bar3"]["macroFont"] = "Roboto"
		E.db["actionbar"]["bar4"]["countFont"] = "Roboto"
		E.db["actionbar"]["bar4"]["hotkeyFont"] = "Roboto"
		E.db["actionbar"]["bar4"]["macroFont"] = "Roboto"
		E.db["actionbar"]["bar5"]["countFont"] = "Roboto"
		E.db["actionbar"]["bar5"]["hotkeyFont"] = "Roboto"
		E.db["actionbar"]["bar5"]["macroFont"] = "Roboto"
		E.db["actionbar"]["bar6"]["countFont"] = "Roboto"
		E.db["actionbar"]["bar6"]["hotkeyFont"] = "Roboto"
		E.db["actionbar"]["bar6"]["macroFont"] = "Roboto"
		E.db["actionbar"]["bar7"]["countFont"] = "Roboto"
		E.db["actionbar"]["bar7"]["hotkeyFont"] = "Roboto"
		E.db["actionbar"]["bar7"]["macroFont"] = "Roboto"
		E.db["actionbar"]["bar8"]["countFont"] = "Roboto"
		E.db["actionbar"]["bar8"]["hotkeyFont"] = "Roboto"
		E.db["actionbar"]["bar8"]["macroFont"] = "Roboto"
		E.db["actionbar"]["bar9"]["countFont"] = "Roboto"
		E.db["actionbar"]["bar9"]["hotkeyFont"] = "Roboto"
		E.db["actionbar"]["bar9"]["macroFont"] = "Roboto"
		E.db["actionbar"]["barPet"]["countFont"] = "Roboto"
		E.db["actionbar"]["barPet"]["hotkeyFont"] = "Roboto"
		if ElvUI_EltreumUI.Retail then
			E.db["actionbar"]["extraActionButton"]["hotkeyFont"] = "Roboto"
		end
		E.db["actionbar"]["font"] = "Roboto"
		E.db["actionbar"]["stanceBar"]["hotkeyFont"] = "Roboto"
		E.db["actionbar"]["vehicleExitButton"]["hotkeyFont"] = "Roboto"
		E.db["auras"]["buffs"]["countFont"] = "Roboto"
		E.db["auras"]["buffs"]["timeFont"] = "Roboto"
		E.db["auras"]["debuffs"]["countFont"] = "Roboto"
		E.db["auras"]["debuffs"]["timeFont"] = "Roboto"
		E.db["unitframe"]["font"] = "Roboto"
		if ElvUI_EltreumUI.Retail then
			E.db["unitframe"]["units"]["arena"]["buffs"]["countFont"] = "Roboto"
			E.db["unitframe"]["units"]["arena"]["debuffs"]["countFont"] = "Roboto"
			E.db["unitframe"]["units"]["assist"]["buffs"]["countFont"] = "Roboto"
			E.db["unitframe"]["units"]["assist"]["debuffs"]["countFont"] = "Roboto"
			E.db["unitframe"]["units"]["assist"]["rdebuffs"]["font"] = "Roboto"
			E.db["unitframe"]["units"]["boss"]["buffs"]["countFont"] = "Roboto"
			E.db["unitframe"]["units"]["boss"]["debuffs"]["countFont"] = "Roboto"
			E.db["unitframe"]["units"]["focus"]["debuffs"]["countFont"] = "Roboto"
			E.db["unitframe"]["units"]["party"]["castbar"]["customTextFont"]["font"] = "Roboto"
			E.db["unitframe"]["units"]["player"]["castbar"]["customTimeFont"]["font"] = "Roboto"
		end
		E.db["unitframe"]["units"]["party"]["buffs"]["countFont"] = "Roboto"
		E.db["unitframe"]["units"]["party"]["debuffs"]["countFont"] = "Roboto"
		E.db["unitframe"]["units"]["party"]["rdebuffs"]["font"] = "Roboto"
		E.db["unitframe"]["units"]["player"]["buffs"]["countFont"] = "Roboto"
		E.db["unitframe"]["units"]["player"]["debuffs"]["countFont"] = "Roboto"
		E.db["unitframe"]["units"]["raid"]["buffs"]["countFont"] = "Roboto"
		E.db["unitframe"]["units"]["raid"]["debuffs"]["countFont"] = "Roboto"
		E.db["unitframe"]["units"]["raid"]["rdebuffs"]["font"] = "Roboto"
		E.db["unitframe"]["units"]["raid40"]["rdebuffs"]["font"] = "Roboto"
		E.db["unitframe"]["units"]["tank"]["buffs"]["countFont"] = "Roboto"
		E.db["unitframe"]["units"]["tank"]["debuffs"]["countFont"] = "Roboto"
		E.db["unitframe"]["units"]["tank"]["rdebuffs"]["font"] = "Roboto"
		E.db["unitframe"]["units"]["target"]["buffs"]["countFont"] = "Roboto"
		E.db["unitframe"]["units"]["target"]["debuffs"]["countFont"] = "Roboto"
		E.db["unitframe"]["units"]["targettargettarget"]["buffs"]["countFont"] = "Roboto"
		E.db["unitframe"]["units"]["targettargettarget"]["debuffs"]["countFont"] = "Roboto"

		E:StaggeredUpdateAll(nil, true)

	ElvUI_EltreumUI:Print('Roboto Font has been set.')
end

function ElvUI_EltreumUI:SetupFontsOutlineDefault(addon)
	if ElvUI_EltreumUI.Retail then
		PA.db["stAddonManager"]["FontFlag"] = "THICKOUTLINE"
		E.db["sle"]["armory"]["stats"]["catFonts"]["outline"] = "THICKOUTLINE"
		E.db["sle"]["armory"]["stats"]["itemLevel"]["outline"] = "THICKOUTLINE"
		E.db["sle"]["armory"]["stats"]["statFonts"]["outline"] = "THICKOUTLINE"
		E.db["sle"]["media"]["fonts"]["mail"]["outline"] = "THICKOUTLINE"
		E.db["sle"]["media"]["fonts"]["objective"]["outline"] = "THICKOUTLINE"
		E.db["sle"]["media"]["fonts"]["objectiveHeader"]["outline"] = "THICKOUTLINE"
		E.db["sle"]["media"]["fonts"]["pvp"]["outline"] = "THICKOUTLINE"
		E.db["sle"]["media"]["fonts"]["questFontSuperHuge"]["outline"] = "THICKOUTLINE"
		E.db["sle"]["media"]["fonts"]["subzone"]["outline"] = "THICKOUTLINE"
		E.db["sle"]["media"]["fonts"]["zone"]["outline"] = "THICKOUTLINE"
		E.db["sle"]["minimap"]["coords"]["fontOutline"] = "THICKOUTLINE"
		E.db["sle"]["minimap"]["instance"]["fontOutline"] = "THICKOUTLINE"
		E.db["sle"]["minimap"]["locPanel"]["fontOutline"] = "THICKOUTLINE"
		E.db["sle"]["nameplates"]["targetcount"]["fontOutline"] = "THICKOUTLINE"
		if sleversioncheck <= "4.21" then
			E.db["sle"]["screensaver"]["subtitle"]["outline"] = "THICKOUTLINE"
			E.db["sle"]["screensaver"]["title"]["outline"] = "THICKOUTLINE"
		end
		E.db["sle"]["skins"]["merchant"]["list"]["subOutline"] = "THICKOUTLINE"
		E.private["WT"]["quest"]["objectiveTracker"]["header"]["style"] = "THICKOUTLINE"
		E.private["WT"]["quest"]["objectiveTracker"]["info"]["style"] = "THICKOUTLINE"
		E.private["WT"]["quest"]["objectiveTracker"]["title"]["style"] = "THICKOUTLINE"
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["bindFont"]["style"] = "THICKOUTLINE"
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["countFont"]["style"] = "THICKOUTLINE"
		E.db["WT"]["misc"]["gameBar"]["additionalText"]["font"]["style"] = "THICKOUTLINE"
		E.db["WT"]["misc"]["gameBar"]["time"]["font"]["style"] = "THICKOUTLINE"
		E.db["general"]["altPowerBar"]["fontOutline"] = "THICKOUTLINE"
		E.db["databars"]["azerite"]["fontOutline"] = "THICKOUTLINE"
		E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyAbsorb"]["fontOutline"] = "THICKOUTLINE"
		E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPlayerAbsorb"]["fontOutline"] = "THICKOUTLINE"
		E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumRaidAbsorb"]["fontOutline"] = "THICKOUTLINE"
		E.db["unitframe"]["units"]["raid40"]["customTexts"]["EltreumRaid40Absorb"]["fontOutline"] = "THICKOUTLINE"
		E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetAbsorb"]["fontOutline"] = "THICKOUTLINE"
		E.db["actionbar"]["extraActionButton"]["hotkeyFontOutline"] = "THICKOUTLINE"
		E.db["unitframe"]["units"]["player"]["castbar"]["customTimeFont"]["fontStyle"] = "MONOCHROMEOUTLINE"
	end
	E.db["general"]["fontStyle"] = "THICKOUTLINE"
	E.db["general"]["minimap"]["locationFontOutline"] = "THICKOUTLINE"
	E.db["bags"]["countFontOutline"] = "OUTLINE"
	E.db["bags"]["itemInfoFontOutline"] = "OUTLINE"
	E.db["bags"]["itemLevelFontOutline"] = "OUTLINE"
	E.db["chat"]["fontOutline"] = "OUTLINE"
	E.db["cooldown"]["fonts"]["fontOutline"] = "THICKOUTLINE"
	E.db["databars"]["experience"]["fontOutline"] = "THICKOUTLINE"
	E.db["databars"]["reputation"]["fontOutline"] = "THICKOUTLINE"
	E.db["databars"]["threat"]["fontOutline"] = "THICKOUTLINE"
	E.db["datatexts"]["fontOutline"] = "THICKOUTLINE"
	E.db["tooltip"]["healthBar"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyHealth"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyName"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyPower"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumHealth"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumName"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPvP"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumGroup"]["fontOutline"] = "NONE"
	E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumRaidHealth"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumRaidName"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["raid40"]["customTexts"]["EltreumRaid40Group"]["fontOutline"] = "NONE"
	E.db["unitframe"]["units"]["raid40"]["customTexts"]["EltreumRaid40Health"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetHealth"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetPower"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetofTarget"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetHealth"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetName"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["targettarget"]["customTexts"]["Powercustom"]["fontOutline"] = "THICKOUTLINE"
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
	E.db["unitframe"]["units"]["party"]["debuffs"]["countFontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["raid"]["rdebuffs"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["raid40"]["rdebuffs"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["tank"]["rdebuffs"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["cooldown"]["fonts"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["health"]["text"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["name"]["fontOutline"] = "THICKOUTLINE"
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
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["power"]["text"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["PLAYER"]["buffs"]["countFontOutline"] = "NONE"
	E.db["nameplates"]["units"]["PLAYER"]["castbar"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["countFontOutline"] = "NONE"
	E.db["nameplates"]["units"]["PLAYER"]["health"]["text"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["level"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["PLAYER"]["name"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["power"]["text"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["title"]["fontOutline"] = "NONE"
end

function ElvUI_EltreumUI:SetupFontsOutlineNone(addon)
	if ElvUI_EltreumUI.Retail then
		PA.db["stAddonManager"]["FontFlag"] = "NONE"
		E.db["sle"]["armory"]["stats"]["catFonts"]["outline"] = "NONE"
		E.db["sle"]["armory"]["stats"]["itemLevel"]["outline"] = "NONE"
		E.db["sle"]["armory"]["stats"]["statFonts"]["outline"] = "NONE"
		E.db["sle"]["media"]["fonts"]["mail"]["outline"] = "NONE"
		E.db["sle"]["media"]["fonts"]["objective"]["outline"] = "NONE"
		E.db["sle"]["media"]["fonts"]["objectiveHeader"]["outline"] = "NONE"
		E.db["sle"]["media"]["fonts"]["pvp"]["outline"] = "NONE"
		E.db["sle"]["media"]["fonts"]["questFontSuperHuge"]["outline"] = "NONE"
		E.db["sle"]["media"]["fonts"]["subzone"]["outline"] = "NONE"
		E.db["sle"]["media"]["fonts"]["zone"]["outline"] = "NONE"
		E.db["sle"]["minimap"]["coords"]["fontOutline"] = "NONE"
		E.db["sle"]["minimap"]["instance"]["fontOutline"] = "NONE"
		E.db["sle"]["minimap"]["locPanel"]["fontOutline"] = "NONE"
		E.db["sle"]["nameplates"]["targetcount"]["fontOutline"] = "NONE"
		if sleversioncheck <= "4.21" then
			E.db["sle"]["screensaver"]["subtitle"]["outline"] = "NONE"
			E.db["sle"]["screensaver"]["title"]["outline"] = "NONE"
		end
		E.db["sle"]["skins"]["merchant"]["list"]["subOutline"] = "NONE"
		E.private["WT"]["quest"]["objectiveTracker"]["header"]["style"] = "NONE"
		E.private["WT"]["quest"]["objectiveTracker"]["info"]["style"] = "NONE"
		E.private["WT"]["quest"]["objectiveTracker"]["title"]["style"] = "NONE"
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["bindFont"]["style"] = "NONE"
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["countFont"]["style"] = "NONE"
		E.db["WT"]["misc"]["gameBar"]["additionalText"]["font"]["style"] = "NONE"
		E.db["WT"]["misc"]["gameBar"]["time"]["font"]["style"] = "NONE"
		E.db["general"]["altPowerBar"]["fontOutline"] = "NONE"
		E.db["databars"]["azerite"]["fontOutline"] = "NONE"
		E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyAbsorb"]["fontOutline"] = "NONE"
		E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPlayerAbsorb"]["fontOutline"] = "NONE"
		E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumRaidAbsorb"]["fontOutline"] = "NONE"
		E.db["unitframe"]["units"]["raid40"]["customTexts"]["EltreumRaid40Absorb"]["fontOutline"] = "NONE"
		E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetAbsorb"]["fontOutline"] = "NONE"
		E.db["actionbar"]["extraActionButton"]["hotkeyFontOutline"] = "NONE"
		E.db["unitframe"]["units"]["player"]["castbar"]["customTimeFont"]["fontStyle"] = "NONE"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["fontOutline"] = "NONE"
	end
	E.db["general"]["fontStyle"] = "NONE"
	E.db["general"]["minimap"]["locationFontOutline"] = "NONE"
	E.db["bags"]["countFontOutline"] = "NONE"
	E.db["bags"]["itemInfoFontOutline"] = "NONE"
	E.db["bags"]["itemLevelFontOutline"] = "NONE"
	E.db["chat"]["fontOutline"] = "NONE"
	E.db["cooldown"]["fonts"]["fontOutline"] = "NONE"
	E.db["databars"]["experience"]["fontOutline"] = "NONE"
	E.db["databars"]["reputation"]["fontOutline"] = "NONE"
	E.db["databars"]["threat"]["fontOutline"] = "NONE"
	E.db["datatexts"]["fontOutline"] = "NONE"
	E.db["tooltip"]["healthBar"]["fontOutline"] = "NONE"
	E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyHealth"]["fontOutline"] = "NONE"
	E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyName"]["fontOutline"] = "NONE"
	E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyPower"]["fontOutline"] = "NONE"
	E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["fontOutline"] = "NONE"
	E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumHealth"]["fontOutline"] = "NONE"
	E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumName"]["fontOutline"] = "NONE"
	E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"]["fontOutline"] = "NONE"
	E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPvP"]["fontOutline"] = "NONE"
	E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumGroup"]["fontOutline"] = "NONE"
	E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumRaidHealth"]["fontOutline"] = "NONE"
	E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumRaidName"]["fontOutline"] = "NONE"
	E.db["unitframe"]["units"]["raid40"]["customTexts"]["EltreumRaid40Group"]["fontOutline"] = "NONE"
	E.db["unitframe"]["units"]["raid40"]["customTexts"]["EltreumRaid40Health"]["fontOutline"] = "NONE"
	E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetHealth"]["fontOutline"] = "NONE"
	E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"]["fontOutline"] = "NONE"
	E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetPower"]["fontOutline"] = "NONE"
	E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetofTarget"]["fontOutline"] = "NONE"
	E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetHealth"]["fontOutline"] = "NONE"
	E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetName"]["fontOutline"] = "NONE"
	E.db["unitframe"]["units"]["targettarget"]["customTexts"]["Powercustom"]["fontOutline"] = "NONE"
	E.db["actionbar"]["bar1"]["countFontOutline"] = "NONE"
	E.db["actionbar"]["bar1"]["hotkeyFontOutline"] = "NONE"
	E.db["actionbar"]["bar1"]["macroFontOutline"] = "NONE"
	E.db["actionbar"]["bar10"]["countFontOutline"] = "NONE"
	E.db["actionbar"]["bar10"]["hotkeyFontOutline"] = "NONE"
	E.db["actionbar"]["bar10"]["macroFontOutline"] = "NONE"
	E.db["actionbar"]["bar2"]["countFontOutline"] = "NONE"
	E.db["actionbar"]["bar2"]["hotkeyFontOutline"] = "NONE"
	E.db["actionbar"]["bar2"]["macroFontOutline"] = "NONE"
	E.db["actionbar"]["bar3"]["countFontOutline"] = "NONE"
	E.db["actionbar"]["bar3"]["hotkeyFontOutline"] = "NONE"
	E.db["actionbar"]["bar3"]["macroFontOutline"] = "NONE"
	E.db["actionbar"]["bar4"]["countFontOutline"] = "NONE"
	E.db["actionbar"]["bar4"]["hotkeyFontOutline"] = "NONE"
	E.db["actionbar"]["bar4"]["macroFontOutline"] = "NONE"
	E.db["actionbar"]["bar5"]["countFontOutline"] = "NONE"
	E.db["actionbar"]["bar5"]["hotkeyFontOutline"] = "NONE"
	E.db["actionbar"]["bar5"]["macroFontOutline"] = "NONE"
	E.db["actionbar"]["bar6"]["countFontOutline"] = "NONE"
	E.db["actionbar"]["bar6"]["hotkeyFontOutline"] = "NONE"
	E.db["actionbar"]["bar6"]["macroFontOutline"] = "NONE"
	E.db["actionbar"]["bar7"]["countFontOutline"] = "NONE"
	E.db["actionbar"]["bar7"]["hotkeyFontOutline"] = "NONE"
	E.db["actionbar"]["bar7"]["macroFontOutline"] = "NONE"
	E.db["actionbar"]["bar8"]["countFontOutline"] = "NONE"
	E.db["actionbar"]["bar8"]["hotkeyFontOutline"] = "NONE"
	E.db["actionbar"]["bar8"]["macroFontOutline"] = "NONE"
	E.db["actionbar"]["bar9"]["countFontOutline"] = "NONE"
	E.db["actionbar"]["bar9"]["hotkeyFontOutline"] = "NONE"
	E.db["actionbar"]["bar9"]["macroFontOutline"] = "NONE"
	E.db["actionbar"]["barPet"]["countFontOutline"] = "NONE"
	E.db["actionbar"]["barPet"]["hotkeyFontOutline"] = "NONE"
	E.db["actionbar"]["fontOutline"] = "NONE"
	E.db["actionbar"]["stanceBar"]["hotkeyFontOutline"] = "NONE"
	E.db["actionbar"]["vehicleExitButton"]["hotkeyFontOutline"] = "NONE"
	E.db["auras"]["buffs"]["countFontOutline"] = "NONE"
	E.db["auras"]["buffs"]["timeFontOutline"] = "NONE"
	E.db["auras"]["debuffs"]["countFontOutline"] = "NONE"
	E.db["auras"]["debuffs"]["timeFontOutline"] = "NONE"
	E.db["unitframe"]["fontOutline"] = "NONE"
	E.db["unitframe"]["units"]["assist"]["rdebuffs"]["fontOutline"] = "NONE"
	E.db["unitframe"]["units"]["party"]["debuffs"]["countFontOutline"] = "NONE"
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["fontOutline"] = "NONE"
	E.db["unitframe"]["units"]["raid"]["rdebuffs"]["fontOutline"] = "NONE"
	E.db["unitframe"]["units"]["raid40"]["rdebuffs"]["fontOutline"] = "NONE"
	E.db["unitframe"]["units"]["tank"]["rdebuffs"]["fontOutline"] = "NONE"
	E.db["nameplates"]["cooldown"]["fonts"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["health"]["text"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["name"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["power"]["text"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["health"]["text"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["name"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["power"]["text"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["buffs"]["countFontOutline"] = "NONE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["castbar"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["debuffs"]["countFontOutline"] = "NONE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["health"]["text"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["level"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["power"]["text"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["PLAYER"]["buffs"]["countFontOutline"] = "NONE"
	E.db["nameplates"]["units"]["PLAYER"]["castbar"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["countFontOutline"] = "NONE"
	E.db["nameplates"]["units"]["PLAYER"]["health"]["text"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["PLAYER"]["level"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["PLAYER"]["name"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["PLAYER"]["power"]["text"]["fontOutline"] = "NONE"
	E.db["nameplates"]["units"]["PLAYER"]["title"]["fontOutline"] = "NONE"
end

function ElvUI_EltreumUI:SetupFontsOutlineThick(addon)
	if ElvUI_EltreumUI.Retail then
		PA.db["stAddonManager"]["FontFlag"] = "THICKOUTLINE"
		E.db["sle"]["armory"]["stats"]["catFonts"]["outline"] = "THICKOUTLINE"
		E.db["sle"]["armory"]["stats"]["itemLevel"]["outline"] = "THICKOUTLINE"
		E.db["sle"]["armory"]["stats"]["statFonts"]["outline"] = "THICKOUTLINE"
		E.db["sle"]["media"]["fonts"]["mail"]["outline"] = "THICKOUTLINE"
		E.db["sle"]["media"]["fonts"]["objective"]["outline"] = "THICKOUTLINE"
		E.db["sle"]["media"]["fonts"]["objectiveHeader"]["outline"] = "THICKOUTLINE"
		E.db["sle"]["media"]["fonts"]["pvp"]["outline"] = "THICKOUTLINE"
		E.db["sle"]["media"]["fonts"]["questFontSuperHuge"]["outline"] = "THICKOUTLINE"
		E.db["sle"]["media"]["fonts"]["subzone"]["outline"] = "THICKOUTLINE"
		E.db["sle"]["media"]["fonts"]["zone"]["outline"] = "THICKOUTLINE"
		E.db["sle"]["minimap"]["coords"]["fontOutline"] = "THICKOUTLINE"
		E.db["sle"]["minimap"]["instance"]["fontOutline"] = "THICKOUTLINE"
		E.db["sle"]["minimap"]["locPanel"]["fontOutline"] = "THICKOUTLINE"
		E.db["sle"]["nameplates"]["targetcount"]["fontOutline"] = "THICKOUTLINE"
		if sleversioncheck <= "4.21" then
			E.db["sle"]["screensaver"]["subtitle"]["outline"] = "THICKOUTLINE"
			E.db["sle"]["screensaver"]["title"]["outline"] = "THICKOUTLINE"
		end
		E.db["sle"]["skins"]["merchant"]["list"]["subOutline"] = "THICKOUTLINE"
		E.private["WT"]["quest"]["objectiveTracker"]["header"]["style"] = "THICKOUTLINE"
		E.private["WT"]["quest"]["objectiveTracker"]["info"]["style"] = "THICKOUTLINE"
		E.private["WT"]["quest"]["objectiveTracker"]["title"]["style"] = "THICKOUTLINE"
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["bindFont"]["style"] = "THICKOUTLINE"
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["countFont"]["style"] = "THICKOUTLINE"
		E.db["WT"]["misc"]["gameBar"]["additionalText"]["font"]["style"] = "THICKOUTLINE"
		E.db["WT"]["misc"]["gameBar"]["time"]["font"]["style"] = "THICKOUTLINE"
		E.db["general"]["altPowerBar"]["fontOutline"] = "THICKOUTLINE"
		E.db["databars"]["azerite"]["fontOutline"] = "THICKOUTLINE"
		E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyAbsorb"]["fontOutline"] = "THICKOUTLINE"
		E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPlayerAbsorb"]["fontOutline"] = "THICKOUTLINE"
		E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetAbsorb"]["fontOutline"] = "THICKOUTLINE"
		E.db["unitframe"]["units"]["raid40"]["customTexts"]["EltreumRaid40Absorb"]["fontOutline"] = "THICKOUTLINE"
		E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumRaidAbsorb"]["fontOutline"] = "THICKOUTLINE"
		E.db["actionbar"]["extraActionButton"]["hotkeyFontOutline"] = "THICKOUTLINE"
		E.db["unitframe"]["units"]["player"]["castbar"]["customTimeFont"]["fontStyle"] = "THICKOUTLINE"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["fontOutline"] = "THICKOUTLINE"
	end
	E.db["general"]["fontStyle"] = "THICKOUTLINE"
	E.db["general"]["minimap"]["locationFontOutline"] = "THICKOUTLINE"
	E.db["bags"]["countFontOutline"] = "THICKOUTLINE"
	E.db["bags"]["itemInfoFontOutline"] = "THICKOUTLINE"
	E.db["bags"]["itemLevelFontOutline"] = "THICKOUTLINE"
	E.db["chat"]["fontOutline"] = "THICKOUTLINE"
	E.db["cooldown"]["fonts"]["fontOutline"] = "THICKOUTLINE"
	E.db["databars"]["experience"]["fontOutline"] = "THICKOUTLINE"
	E.db["databars"]["reputation"]["fontOutline"] = "THICKOUTLINE"
	E.db["databars"]["threat"]["fontOutline"] = "THICKOUTLINE"
	E.db["datatexts"]["fontOutline"] = "THICKOUTLINE"
	E.db["tooltip"]["healthBar"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyHealth"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyName"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyPower"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumHealth"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumName"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPvP"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumGroup"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumRaidHealth"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumRaidName"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["raid40"]["customTexts"]["EltreumRaid40Group"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["raid40"]["customTexts"]["EltreumRaid40Health"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetHealth"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetPower"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetofTarget"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetHealth"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetName"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["targettarget"]["customTexts"]["Powercustom"]["fontOutline"] = "THICKOUTLINE"
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
	E.db["unitframe"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["assist"]["rdebuffs"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["party"]["debuffs"]["countFontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["raid"]["rdebuffs"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["raid40"]["rdebuffs"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["tank"]["rdebuffs"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["cooldown"]["fonts"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["health"]["text"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["name"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["power"]["text"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["health"]["text"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["name"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["power"]["text"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["buffs"]["countFontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["castbar"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["debuffs"]["countFontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["health"]["text"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["level"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["power"]["text"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["buffs"]["countFontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["castbar"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["countFontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["health"]["text"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["level"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["name"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["power"]["text"]["fontOutline"] = "THICKOUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["title"]["fontOutline"] = "THICKOUTLINE"
end

function ElvUI_EltreumUI:SetupFontsOutlineOutline(addon)
	if ElvUI_EltreumUI.Retail then
		PA.db["stAddonManager"]["FontFlag"] = "OUTLINE"
		E.db["sle"]["armory"]["stats"]["catFonts"]["outline"] = "OUTLINE"
		E.db["sle"]["armory"]["stats"]["itemLevel"]["outline"] = "OUTLINE"
		E.db["sle"]["armory"]["stats"]["statFonts"]["outline"] = "OUTLINE"
		E.db["sle"]["media"]["fonts"]["mail"]["outline"] = "OUTLINE"
		E.db["sle"]["media"]["fonts"]["objective"]["outline"] = "OUTLINE"
		E.db["sle"]["media"]["fonts"]["objectiveHeader"]["outline"] = "OUTLINE"
		E.db["sle"]["media"]["fonts"]["pvp"]["outline"] = "OUTLINE"
		E.db["sle"]["media"]["fonts"]["questFontSuperHuge"]["outline"] = "OUTLINE"
		E.db["sle"]["media"]["fonts"]["subzone"]["outline"] = "OUTLINE"
		E.db["sle"]["media"]["fonts"]["zone"]["outline"] = "OUTLINE"
		E.db["sle"]["minimap"]["coords"]["fontOutline"] = "OUTLINE"
		E.db["sle"]["minimap"]["instance"]["fontOutline"] = "OUTLINE"
		E.db["sle"]["minimap"]["locPanel"]["fontOutline"] = "OUTLINE"
		E.db["sle"]["nameplates"]["targetcount"]["fontOutline"] = "OUTLINE"
		if sleversioncheck <= "4.21" then
			E.db["sle"]["screensaver"]["subtitle"]["outline"] = "OUTLINE"
			E.db["sle"]["screensaver"]["title"]["outline"] = "OUTLINE"
		end
		E.db["sle"]["skins"]["merchant"]["list"]["subOutline"] = "OUTLINE"
		E.private["WT"]["quest"]["objectiveTracker"]["header"]["style"] = "OUTLINE"
		E.private["WT"]["quest"]["objectiveTracker"]["info"]["style"] = "OUTLINE"
		E.private["WT"]["quest"]["objectiveTracker"]["title"]["style"] = "OUTLINE"
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["bindFont"]["style"] = "OUTLINE"
		E.db["WT"]["item"]["extraItemsBar"]["bar1"]["countFont"]["style"] = "OUTLINE"
		E.db["WT"]["misc"]["gameBar"]["additionalText"]["font"]["style"] = "OUTLINE"
		E.db["WT"]["misc"]["gameBar"]["time"]["font"]["style"] = "OUTLINE"
		E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPlayerAbsorb"]["fontOutline"] = "OUTLINE"
		E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyAbsorb"]["fontOutline"] = "OUTLINE"
		E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetAbsorb"]["fontOutline"] = "OUTLINE"
		E.db["unitframe"]["units"]["raid40"]["customTexts"]["EltreumRaid40Absorb"]["fontOutline"] = "OUTLINE"
		E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumRaidAbsorb"]["fontOutline"] = "OUTLINE"
		E.db["actionbar"]["extraActionButton"]["hotkeyFontOutline"] = "OUTLINE"
		E.db["unitframe"]["units"]["player"]["castbar"]["customTimeFont"]["fontStyle"] = "OUTLINE"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["fontOutline"] = "OUTLINE"
		E.db["databars"]["azerite"]["fontOutline"] = "OUTLINE"
		E.db["general"]["altPowerBar"]["fontOutline"] = "OUTLINE"
	end
	E.db["general"]["fontStyle"] = "OUTLINE"
	E.db["general"]["minimap"]["locationFontOutline"] = "OUTLINE"
	E.db["bags"]["countFontOutline"] = "OUTLINE"
	E.db["bags"]["itemInfoFontOutline"] = "OUTLINE"
	E.db["bags"]["itemLevelFontOutline"] = "OUTLINE"
	E.db["chat"]["fontOutline"] = "OUTLINE"
	E.db["cooldown"]["fonts"]["fontOutline"] = "OUTLINE"
	E.db["databars"]["experience"]["fontOutline"] = "OUTLINE"
	E.db["databars"]["reputation"]["fontOutline"] = "OUTLINE"
	E.db["databars"]["threat"]["fontOutline"] = "OUTLINE"
	E.db["datatexts"]["fontOutline"] = "OUTLINE"
	E.db["tooltip"]["healthBar"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyHealth"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyName"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyPower"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumHealth"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumName"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPvP"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumGroup"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumRaidHealth"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumRaidName"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["raid40"]["customTexts"]["EltreumRaid40Group"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["raid40"]["customTexts"]["EltreumRaid40Health"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetHealth"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetPower"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetofTarget"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetHealth"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetName"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["targettarget"]["customTexts"]["Powercustom"]["fontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar1"]["countFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar1"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar1"]["macroFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar10"]["countFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar10"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar10"]["macroFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar2"]["countFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar2"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar2"]["macroFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar3"]["countFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar3"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar3"]["macroFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar4"]["countFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar4"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar4"]["macroFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar5"]["countFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar5"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar5"]["macroFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar6"]["countFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar6"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar6"]["macroFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar7"]["countFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar7"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar7"]["macroFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar8"]["countFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar8"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar8"]["macroFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar9"]["countFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar9"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar9"]["macroFontOutline"] = "OUTLINE"
	E.db["actionbar"]["barPet"]["countFontOutline"] = "OUTLINE"
	E.db["actionbar"]["barPet"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["actionbar"]["fontOutline"] = "OUTLINE"
	E.db["actionbar"]["stanceBar"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["actionbar"]["vehicleExitButton"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["auras"]["buffs"]["countFontOutline"] = "OUTLINE"
	E.db["auras"]["buffs"]["timeFontOutline"] = "OUTLINE"
	E.db["auras"]["debuffs"]["countFontOutline"] = "OUTLINE"
	E.db["auras"]["debuffs"]["timeFontOutline"] = "OUTLINE"
	E.db["unitframe"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["assist"]["rdebuffs"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["party"]["debuffs"]["countFontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["raid"]["rdebuffs"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["raid40"]["rdebuffs"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["tank"]["rdebuffs"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["cooldown"]["fonts"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["health"]["text"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["name"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["power"]["text"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["health"]["text"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["name"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["power"]["text"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["buffs"]["countFontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["castbar"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["debuffs"]["countFontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["health"]["text"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["level"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["power"]["text"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["buffs"]["countFontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["castbar"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["countFontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["health"]["text"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["level"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["name"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["power"]["text"]["fontOutline"] = "OUTLINE"
	E.db["nameplates"]["units"]["PLAYER"]["title"]["fontOutline"] = "OUTLINE"
end
