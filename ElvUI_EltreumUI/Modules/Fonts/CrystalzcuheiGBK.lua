local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local GetAddOnMetadata = _G.GetAddOnMetadata
local IsAddOnLoaded = _G.IsAddOnLoaded
local sleversioncheck = GetAddOnMetadata('ElvUI_SLE', 'Version')

function ElvUI_EltreumUI:SetupFontsCrystalzcuhei()
	if not E.db.movers then E.db.movers = {} end

		--nameplates
		E.db["nameplates"]["cooldown"]["fonts"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["health"]["text"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["name"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["power"]["text"]["font"] = "AR CrystalzcuheiGBK Demibold"
		if E.Retail then
			E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["font"] = "AR CrystalzcuheiGBK Demibold"
		end
		E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["health"]["text"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["name"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["power"]["text"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["title"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["buffs"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["castbar"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["debuffs"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["health"]["text"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["level"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["name"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["power"]["text"]["font"] = "AR CrystalzcuheiGBK Demibold"
		if E.Retail then
			E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["font"] = "AR CrystalzcuheiGBK Demibold"
		end
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["title"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["buffs"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["castbar"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["debuffs"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["health"]["text"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["level"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["name"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["power"]["text"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["title"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["PLAYER"]["buffs"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["PLAYER"]["health"]["text"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["PLAYER"]["level"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["PLAYER"]["name"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["PLAYER"]["power"]["text"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["nameplates"]["units"]["PLAYER"]["title"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.private["general"]["chatBubbleFont"] = "AR CrystalzcuheiGBK Demibold"
		E.private["general"]["dmgfont"] = "AR CrystalzcuheiGBK Demibold"
		E.private["general"]["namefont"] = "AR CrystalzcuheiGBK Demibold"
		if E.Retail then
			if IsAddOnLoaded('ProjectAzilroka') then
				_G.ProjectAzilroka.db["stAddonManager"]["Font"] = "AR CrystalzcuheiGBK Demibold"
			end
			if IsAddOnLoaded("ElvUI_SLE") then
				E.db["sle"]["armory"]["character"]["durability"]["font"] = "AR CrystalzcuheiGBK Demibold"
				E.db["sle"]["armory"]["character"]["enchant"]["font"] = "AR CrystalzcuheiGBK Demibold"
				E.db["sle"]["armory"]["character"]["ilvl"]["font"] = "AR CrystalzcuheiGBK Demibold"
				E.db["sle"]["armory"]["inspect"]["enchant"]["font"] = "AR CrystalzcuheiGBK Demibold"
				E.db["sle"]["armory"]["inspect"]["ilvl"]["font"] = "AR CrystalzcuheiGBK Demibold"
				E.db["sle"]["armory"]["stats"]["catFonts"]["font"] = "AR CrystalzcuheiGBK Demibold"
				E.db["sle"]["armory"]["stats"]["itemLevel"]["font"] = "AR CrystalzcuheiGBK Demibold"
				E.db["sle"]["armory"]["stats"]["statFonts"]["font"] = "AR CrystalzcuheiGBK Demibold"
				E.db["sle"]["media"]["fonts"]["gossip"]["font"] = "AR CrystalzcuheiGBK Demibold"
				E.db["sle"]["media"]["fonts"]["mail"]["font"] = "AR CrystalzcuheiGBK Demibold"
				E.db["sle"]["media"]["fonts"]["objective"]["font"] = "AR CrystalzcuheiGBK Demibold"
				E.db["sle"]["media"]["fonts"]["objectiveHeader"]["font"] = "AR CrystalzcuheiGBK Demibold"
				E.db["sle"]["media"]["fonts"]["pvp"]["font"] = "AR CrystalzcuheiGBK Demibold"
				E.db["sle"]["media"]["fonts"]["questFontSuperHuge"]["font"] = "AR CrystalzcuheiGBK Demibold"
				E.db["sle"]["media"]["fonts"]["subzone"]["font"] = "AR CrystalzcuheiGBK Demibold"
				E.db["sle"]["media"]["fonts"]["zone"]["font"] = "AR CrystalzcuheiGBK Demibold"
				E.db["sle"]["minimap"]["coords"]["font"] = "AR CrystalzcuheiGBK Demibold"
				E.db["sle"]["minimap"]["instance"]["font"] = "AR CrystalzcuheiGBK Demibold"
				E.db["sle"]["minimap"]["locPanel"]["font"] = "AR CrystalzcuheiGBK Demibold"
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
					E.db["sle"]["afk"]["defaultTexts"]["SL_AFKMessage"]["font"] = "AR CrystalzcuheiGBK Demibold"
					E.db["sle"]["afk"]["defaultTexts"]["SL_AFKMessage"]["size"] = 20
					E.db["sle"]["afk"]["defaultTexts"]["SL_AFKMessage"]["xOffset"] = 127
					E.db["sle"]["afk"]["defaultTexts"]["SL_AFKMessage"]["yOffset"] = 0
					E.db["sle"]["afk"]["defaultTexts"]["SL_AFKTimePassed"]["font"] = "AR CrystalzcuheiGBK Demibold"
					E.db["sle"]["afk"]["defaultTexts"]["SL_AFKTimePassed"]["size"] = 20
					E.db["sle"]["afk"]["defaultTexts"]["SL_AFKTimePassed"]["xOffset"] = 4
					E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["anchorPoint"] = "TOPRIGHT"
					E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["attachTo"] = "SL_BottomPanel"
					E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["enable"] = false
					E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["font"] = "AR CrystalzcuheiGBK Demibold"
					E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["xOffset"] = 20
					E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["yOffset"] = 50
					E.db["sle"]["afk"]["defaultTexts"]["SL_GuildName"]["anchorPoint"] = "BOTTOMLEFT"
					E.db["sle"]["afk"]["defaultTexts"]["SL_GuildName"]["attachTo"] = "SL_PlayerName"
					E.db["sle"]["afk"]["defaultTexts"]["SL_GuildName"]["font"] = "AR CrystalzcuheiGBK Demibold"
					E.db["sle"]["afk"]["defaultTexts"]["SL_GuildName"]["size"] = 20
					E.db["sle"]["afk"]["defaultTexts"]["SL_GuildRank"]["anchorPoint"] = "RIGHT"
					E.db["sle"]["afk"]["defaultTexts"]["SL_GuildRank"]["attachTo"] = "SL_GuildName"
					E.db["sle"]["afk"]["defaultTexts"]["SL_GuildRank"]["font"] = "AR CrystalzcuheiGBK Demibold"
					E.db["sle"]["afk"]["defaultTexts"]["SL_GuildRank"]["size"] = 20
					E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerClass"]["anchorPoint"] = "TOPRIGHT"
					E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerClass"]["attachTo"] = "SL_TopPanel"
					E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerClass"]["enable"] = false
					E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerClass"]["font"] = "AR CrystalzcuheiGBK Demibold"
					E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerLevel"]["enable"] = false
					E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["anchorPoint"] = "TOPLEFT"
					E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["attachTo"] = "SL_BottomPanel"
					E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["font"] = "AR CrystalzcuheiGBK Demibold"
					E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["size"] = 20
					E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["xOffset"] = 128
					E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["yOffset"] = -30
					E.db["sle"]["afk"]["defaultTexts"]["SL_SubText"]["enable"] = false
					E.db["sle"]["afk"]["defaultTexts"]["SL_SubText"]["size"] = 16
					E.db["sle"]["afk"]["defaultTexts"]["SL_SubText"]["xOffset"] = 0
					E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["anchorPoint"] = "CENTER"
					E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["attachTo"] = "SL_BottomPanel"
					E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["font"] = "AR CrystalzcuheiGBK Demibold"
					E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["size"] = 32
					E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["yOffset"] = 40
					E.db["sle"]["afk"]["enable"] = true
					E.db["sle"]["afk"]["panels"]["bottom"]["height"] = 120
					E.db["sle"]["afk"]["panels"]["top"]["height"] = 120
					E.db["sle"]["afk"]["playermodel"]["anim"] = 47
				end

				E.db["sle"]["skins"]["merchant"]["list"]["nameFont"] = "AR CrystalzcuheiGBK Demibold"
				E.db["sle"]["skins"]["merchant"]["list"]["subFont"] = "AR CrystalzcuheiGBK Demibold"
			end
			if IsAddOnLoaded("ElvUI_WindTools") then
				E.private["WT"]["skins"]["ime"]["label"]["name"] = "AR CrystalzcuheiGBK Demibold"
				E.db["WT"]["item"]["extraItemsBar"]["bar1"]["bindFont"]["name"] = "AR CrystalzcuheiGBK Demibold"
				E.db["WT"]["item"]["extraItemsBar"]["bar1"]["countFont"]["name"] = "AR CrystalzcuheiGBK Demibold"
				E.db["WT"]["item"]["inspect"]["levelText"]["name"] = "AR CrystalzcuheiGBK Demibold"
				E.db["WT"]["misc"]["gameBar"]["additionalText"]["font"]["name"] = "AR CrystalzcuheiGBK Demibold"
				E.db["WT"]["misc"]["gameBar"]["time"]["font"]["name"] = "AR CrystalzcuheiGBK Demibold"
			end
			E.db["general"]["altPowerBar"]["font"] = "AR CrystalzcuheiGBK Demibold"
			E.db["general"]["itemLevel"]["itemLevelFont"] = "AR CrystalzcuheiGBK Demibold"
		end
		E.db["general"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["general"]["minimap"]["locationFont"] = "AR CrystalzcuheiGBK Demibold"
		if E.Retail then
			E.db["general"]["minimap"]["icons"]["queueStatus"]["font"] = "AR CrystalzcuheiGBK Demibold"
		end
		if E.Wrath then
			E.db["general"]["totems"]["font"] = "AR CrystalzcuheiGBK Demibold"
		end
		E.db["bags"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["bags"]["itemInfoFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["bags"]["itemLevelFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["chat"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["chat"]["tabFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["cooldown"]["fonts"]["font"] = "AR CrystalzcuheiGBK Demibold"
		if E.Retail then
			E.db["databars"]["honor"]["font"] = "AR CrystalzcuheiGBK Demibold"
			E.db["databars"]["azerite"]["font"] = "AR CrystalzcuheiGBK Demibold"
		end
		E.db["databars"]["experience"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["databars"]["reputation"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["databars"]["threat"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["datatexts"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["tooltip"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["tooltip"]["healthBar"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["tooltip"]["headerFont"] = "AR CrystalzcuheiGBK Demibold"

		-- Custom Text: Party
		E.db["unitframe"]["units"]["party"]["customTexts"] = E.db["unitframe"]["units"]["party"]["customTexts"] or {}
		E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyHealth"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "AR CrystalzcuheiGBK Demibold",
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
			["font"] = "AR CrystalzcuheiGBK Demibold",
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
			["font"] = "AR CrystalzcuheiGBK Demibold",
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
			["font"] = "AR CrystalzcuheiGBK Demibold",
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
			["font"] = "AR CrystalzcuheiGBK Demibold",
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
				["font"] = "AR CrystalzcuheiGBK Demibold",
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
				["font"] = "AR CrystalzcuheiGBK Demibold",
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
				["font"] = "AR CrystalzcuheiGBK Demibold",
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
				["font"] = "AR CrystalzcuheiGBK Demibold",
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
				["font"] = "AR CrystalzcuheiGBK Demibold",
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
				["font"] = "AR CrystalzcuheiGBK Demibold",
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
			["font"] = "AR CrystalzcuheiGBK Demibold",
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
				["font"] = "AR CrystalzcuheiGBK Demibold",
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
				["font"] = "AR CrystalzcuheiGBK Demibold",
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
			["font"] = "AR CrystalzcuheiGBK Demibold",
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
			["font"] = "AR CrystalzcuheiGBK Demibold",
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
			["font"] = "AR CrystalzcuheiGBK Demibold",
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
			["font"] = "AR CrystalzcuheiGBK Demibold",
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
			["font"] = "AR CrystalzcuheiGBK Demibold",
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
			["font"] = "AR CrystalzcuheiGBK Demibold",
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
			["font"] = "AR CrystalzcuheiGBK Demibold",
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
				["font"] = "AR CrystalzcuheiGBK Demibold",
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
			["font"] = "AR CrystalzcuheiGBK Demibold",
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
			["font"] = "AR CrystalzcuheiGBK Demibold",
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
			["font"] = "AR CrystalzcuheiGBK Demibold",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "CENTER",
			["size"] = 25,
			["text_format"] = "[eltruism:dead{5}][eltruism:dc{2}]",
			["xOffset"] = 0,
			["yOffset"] = 0
		}

		-- Custom Text: Raid 2
		E.db["unitframe"]["units"]["raid2"]["customTexts"] = E.db["unitframe"]["units"]["raid2"]["customTexts"] or {}
		if E.Retail then
			E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Absorb"] = {
			["attachTextTo"] = "Health",
			["enable"] = false,
			["font"] = "AR CrystalzcuheiGBK Demibold",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "CENTER",
			["size"] = 10,
			["text_format"] = "||cffFFFF00[absorbs]||r",
			["xOffset"] = 37,
			["yOffset"] = 12
			}
		end
		E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumGroup"] = {
			["attachTextTo"] = "Health",
			["enable"] = false,
			["font"] = "AR CrystalzcuheiGBK Demibold",
			["fontOutline"] = "NONE",
			["justifyH"] = "LEFT",
			["size"] = 8,
			["text_format"] = " Group [group]",
			["xOffset"] = 40,
			["yOffset"] = 12
		}
		E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Health"] = {
			["attachTextTo"] = "InfoPanel",
			["enable"] = true,
			["font"] = "AR CrystalzcuheiGBK Demibold",
			["fontOutline"] = "OUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 10,
			["text_format"] = "[health:current:shortvalue]",
			["xOffset"] = 0,
			["yOffset"] = 0
		}
		E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Name"] = {
			["attachTextTo"] = "InfoPanel",
			["enable"] = true,
			["font"] = "AR CrystalzcuheiGBK Demibold",
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
			["font"] = "AR CrystalzcuheiGBK Demibold",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "CENTER",
			["size"] = 20,
			["text_format"] = "[eltruism:dead{5}][eltruism:dc{2}]",
			["xOffset"] = 0,
			["yOffset"] = 0
		}

		-- Custom Text: Raid 3
		E.db["unitframe"]["units"]["raid3"]["customTexts"] = E.db["unitframe"]["units"]["raid3"]["customTexts"] or {}
		if E.Retail then
			E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Absorb"] = {
			["attachTextTo"] = "Health",
			["enable"] = false,
			["font"] = "AR CrystalzcuheiGBK Demibold",
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
			["font"] = "AR CrystalzcuheiGBK Demibold",
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
			["font"] = "AR CrystalzcuheiGBK Demibold",
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
			["font"] = "AR CrystalzcuheiGBK Demibold",
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
			["font"] = "AR CrystalzcuheiGBK Demibold",
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
			["font"] = "AR CrystalzcuheiGBK Demibold",
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
			["font"] = "AR CrystalzcuheiGBK Demibold",
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
			["font"] = "AR CrystalzcuheiGBK Demibold",
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
			["font"] = "AR CrystalzcuheiGBK Demibold",
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
			["font"] = "AR CrystalzcuheiGBK Demibold",
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
			["font"] = "AR CrystalzcuheiGBK Demibold",
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
			["font"] = "AR CrystalzcuheiGBK Demibold",
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
			["font"] = "AR CrystalzcuheiGBK Demibold",
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
			["font"] = "AR CrystalzcuheiGBK Demibold",
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
			["font"] = "AR CrystalzcuheiGBK Demibold",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "CENTER",
			["size"] = 15,
			["text_format"] = "[eltruism:dead{5}][eltruism:dc{2}]",
			["xOffset"] = 0,
			["yOffset"] = 22
		}

		--ActionBars
		E.db["actionbar"]["bar1"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["actionbar"]["bar1"]["hotkeyFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["actionbar"]["bar1"]["macroFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["actionbar"]["bar10"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["actionbar"]["bar10"]["hotkeyFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["actionbar"]["bar10"]["macroFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["actionbar"]["bar2"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["actionbar"]["bar2"]["hotkeyFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["actionbar"]["bar2"]["macroFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["actionbar"]["bar3"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["actionbar"]["bar3"]["hotkeyFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["actionbar"]["bar3"]["macroFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["actionbar"]["bar4"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["actionbar"]["bar4"]["hotkeyFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["actionbar"]["bar4"]["macroFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["actionbar"]["bar5"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["actionbar"]["bar5"]["hotkeyFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["actionbar"]["bar5"]["macroFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["actionbar"]["bar6"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["actionbar"]["bar6"]["hotkeyFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["actionbar"]["bar6"]["macroFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["actionbar"]["bar7"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["actionbar"]["bar7"]["hotkeyFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["actionbar"]["bar7"]["macroFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["actionbar"]["bar8"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["actionbar"]["bar8"]["hotkeyFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["actionbar"]["bar8"]["macroFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["actionbar"]["bar9"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["actionbar"]["bar9"]["hotkeyFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["actionbar"]["bar9"]["macroFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["actionbar"]["barPet"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["actionbar"]["barPet"]["hotkeyFont"] = "AR CrystalzcuheiGBK Demibold"
		if E.Retail then
			E.db["actionbar"]["extraActionButton"]["hotkeyFont"] = "AR CrystalzcuheiGBK Demibold"
		end
		E.db["actionbar"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["actionbar"]["stanceBar"]["hotkeyFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["actionbar"]["vehicleExitButton"]["hotkeyFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["auras"]["buffs"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["auras"]["buffs"]["timeFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["auras"]["debuffs"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["auras"]["debuffs"]["timeFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["unitframe"]["font"] = "AR CrystalzcuheiGBK Demibold"
		if E.Retail then
			E.db["unitframe"]["units"]["arena"]["buffs"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
			E.db["unitframe"]["units"]["arena"]["debuffs"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
			E.db["unitframe"]["units"]["assist"]["buffs"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
			E.db["unitframe"]["units"]["assist"]["debuffs"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
			E.db["unitframe"]["units"]["assist"]["rdebuffs"]["font"] = "AR CrystalzcuheiGBK Demibold"
			E.db["unitframe"]["units"]["boss"]["buffs"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
			E.db["unitframe"]["units"]["boss"]["debuffs"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
			E.db["unitframe"]["units"]["focus"]["debuffs"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
			E.db["unitframe"]["units"]["party"]["castbar"]["customTextFont"]["font"] = "AR CrystalzcuheiGBK Demibold"
			E.db["unitframe"]["units"]["player"]["castbar"]["customTimeFont"]["font"] = "AR CrystalzcuheiGBK Demibold"
		end
		E.db["unitframe"]["units"]["party"]["buffs"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["unitframe"]["units"]["party"]["debuffs"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["unitframe"]["units"]["party"]["rdebuffs"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["unitframe"]["units"]["player"]["buffs"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["unitframe"]["units"]["player"]["debuffs"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["unitframe"]["units"]["raid1"]["buffs"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["unitframe"]["units"]["raid1"]["rdebuffs"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["unitframe"]["units"]["raid2"]["buffs"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["unitframe"]["units"]["raid2"]["debuffs"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["unitframe"]["units"]["raid2"]["rdebuffs"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["unitframe"]["units"]["raid3"]["buffs"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["unitframe"]["units"]["raid3"]["debuffs"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["unitframe"]["units"]["raid3"]["rdebuffs"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["unitframe"]["units"]["tank"]["buffs"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["unitframe"]["units"]["tank"]["debuffs"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["unitframe"]["units"]["tank"]["rdebuffs"]["font"] = "AR CrystalzcuheiGBK Demibold"
		E.db["unitframe"]["units"]["target"]["buffs"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["unitframe"]["units"]["target"]["debuffs"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["unitframe"]["units"]["targettargettarget"]["buffs"]["countFont"] = "AR CrystalzcuheiGBK Demibold"
		E.db["unitframe"]["units"]["targettargettarget"]["debuffs"]["countFont"] = "AR CrystalzcuheiGBK Demibold"

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
		E.global["datatexts"]["customPanels"]["EltruismTime"]["fonts"]["font"] = "AR CrystalzcuheiGBK Demibold"
	end

	--FCT font
	if IsAddOnLoaded("ElvUI_FCT") then
		ElvFCT["nameplates"]["frames"]["Player"]["font"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["nameplates"]["frames"]["Player"]["critFont"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["nameplates"]["frames"]["FriendlyPlayer"]["font"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["nameplates"]["frames"]["FriendlyPlayer"]["critFont"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["nameplates"]["frames"]["FriendlyNPC"]["font"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["nameplates"]["frames"]["FriendlyNPC"]["critFont"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["nameplates"]["frames"]["EnemyNPC"]["font"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["nameplates"]["frames"]["EnemyNPC"]["critFont"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["nameplates"]["frames"]["EnemyPlayer"]["font"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["nameplates"]["frames"]["EnemyPlayer"]["critFont"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["unitframes"]["frames"]["Player"]["font"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["unitframes"]["frames"]["Player"]["critFont"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["unitframes"]["frames"]["Target"]["font"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["unitframes"]["frames"]["Target"]["critFont"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["unitframes"]["frames"]["TargetTarget"]["font"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["unitframes"]["frames"]["TargetTarget"]["critFont"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["unitframes"]["frames"]["TargetTargetTarget"]["font"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["unitframes"]["frames"]["TargetTargetTarget"]["critFont"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["unitframes"]["frames"]["Focus"]["font"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["unitframes"]["frames"]["Focus"]["critFont"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["unitframes"]["frames"]["FocusTarget"]["font"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["unitframes"]["frames"]["FocusTarget"]["critFont"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["unitframes"]["frames"]["Pet"]["font"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["unitframes"]["frames"]["Pet"]["critFont"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["unitframes"]["frames"]["PetTarget"]["font"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["unitframes"]["frames"]["PetTarget"]["critFont"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["unitframes"]["frames"]["Tank"]["font"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["unitframes"]["frames"]["Tank"]["critFont"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["unitframes"]["frames"]["Assist"]["font"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["unitframes"]["frames"]["Assist"]["critFont"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["unitframes"]["frames"]["Boss"]["font"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["unitframes"]["frames"]["Boss"]["critFont"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["unitframes"]["frames"]["Raid1"]["font"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["unitframes"]["frames"]["Raid1"]["critFont"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["unitframes"]["frames"]["Raid2"]["font"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["unitframes"]["frames"]["Raid2"]["critFont"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["unitframes"]["frames"]["Raid3"]["font"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["unitframes"]["frames"]["Raid3"]["critFont"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["unitframes"]["frames"]["RaidPet"]["font"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["unitframes"]["frames"]["RaidPet"]["critFont"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["unitframes"]["frames"]["Party"]["font"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["unitframes"]["frames"]["Party"]["critFont"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["unitframes"]["frames"]["Arena"]["font"] = "AR CrystalzcuheiGBK Demibold"
		ElvFCT["unitframes"]["frames"]["Arena"]["critFont"] = "AR CrystalzcuheiGBK Demibold"
	end

	E:StaggeredUpdateAll(nil, true)
	ElvUI_EltreumUI:Print(L["Crystalzcuhei Font has been set."])

	ElvUI_EltreumUI:ResolutionOutline()
end
