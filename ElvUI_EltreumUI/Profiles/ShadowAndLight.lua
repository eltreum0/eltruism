local E, L, V, P, G = unpack(ElvUI)
local _G = _G
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded

--Setup Shadow & Light
function ElvUI_EltreumUI:GetSLEProfile()
	if IsAddOnLoaded("ElvUI_SLE") then
		-- Load Shadow & Light profile
		E.global["sle"]["advanced"]["confirmed"] = true
		E.global["sle"]["advanced"]["gameMenu"]["enable"] = true
		E.global["sle"]["advanced"]["general"] = true
		E.global["sle"]["advanced"]["optionsLimits"] = true
		E.private["sle"]["install_complete"] = "4.41"
		-- Private DB
		E.private["sle"]["media"]["enable"] = false --disabling for testing
		--E.private["sle"]["module"]["blizzmove"]["enable"] = false
		E.private["sle"]["module"]["screensaver"] = true
		E.private["sle"]["professions"]["deconButton"]["enable"] = true
		E.private["sle"]["professions"]["deconButton"]["style"] = "PIXEL"
		E.db["sle"]["professions"]["fishing"]["easyCast"] = true
		E.db["sle"]["professions"]["fishing"]["fromMount"] = true
		E.private["sle"]["skins"]["merchant"]["enable"] = true
		E.private["sle"]["skins"]["merchant"]["style"] = "List"
		E.private["sle"]["skins"]["objectiveTracker"]["class"] = false
		E.private["sle"]["skins"]["objectiveTracker"]["color"]["b"] = 0
		E.private["sle"]["skins"]["objectiveTracker"]["color"]["g"] = 0.41960784313725
		E.private["sle"]["skins"]["objectiveTracker"]["color"]["r"] = 0.25882352941176
		E.private["sle"]["skins"]["objectiveTracker"]["keyTimers"]["enable"] = true
		E.private["sle"]["skins"]["objectiveTracker"]["keyTimers"]["showBothTimers"] = true
		E.private["sle"]["skins"]["objectiveTracker"]["skinnedTextureLogo"] = "CUSTOM"
		E.private["sle"]["skins"]["objectiveTracker"]["texture"] = "Minimalist"
		E.private["sle"]["skins"]["objectiveTracker"]["underlineHeight"] = 2
		E.private["sle"]["skins"]["objectiveTracker"]["enable"] = false
		E.private["sle"]["skins"]["petbattles"]["enable"] = false
		E.private["sle"]["pvp"]["KBbanner"]["enable"] = true
		E.private["sle"]["uibuttons"]["style"] = "dropdown"
		E.private["sle"]["module"]["shadows"]["enable"] = false
		E.private["sle"]["skins"]["objectiveTracker"]["torghastPowers"]["enable"] = true

		-- Armory
		E.db["sle"]["armory"]["character"]["background"]["overlay"] = false
		E.db["sle"]["armory"]["character"]["background"]["selectedBG"] = "HIDE"
		E.db["sle"]["armory"]["character"]["durability"]["display"] = "DamagedOnly"
		E.db["sle"]["armory"]["character"]["durability"]["font"] = E.db.general.font
		E.db["sle"]["armory"]["character"]["durability"]["fontSize"] = 11
		E.db["sle"]["armory"]["character"]["enable"] = true
		E.db["sle"]["armory"]["character"]["enchant"]["font"] = E.db.general.font
		E.db["sle"]["armory"]["character"]["enchant"]["fontSize"] = 10
		E.db["sle"]["armory"]["character"]["enchant"]["yOffset"] = -1
		E.db["sle"]["armory"]["character"]["gem"]["size"] = 11
		E.db["sle"]["armory"]["character"]["gem"]["xOffset"] = 4
		E.db["sle"]["armory"]["character"]["gradient"]["quality"] = true
		E.db["sle"]["armory"]["character"]["gradient"]["setArmor"] = true
		E.db["sle"]["armory"]["character"]["ilvl"]["colorType"] = "GRADIENT"
		E.db["sle"]["armory"]["character"]["ilvl"]["font"] = E.db.general.font
		E.db["sle"]["armory"]["character"]["ilvl"]["fontSize"] = 11
		E.db["sle"]["armory"]["inspect"]["background"]["overlay"] = false
		E.db["sle"]["armory"]["inspect"]["background"]["selectedBG"] = "HIDE"
		E.db["sle"]["armory"]["inspect"]["enable"] = true
		E.db["sle"]["armory"]["inspect"]["enchant"]["font"] = E.db.general.font
		E.db["sle"]["armory"]["inspect"]["enchant"]["fontSize"] = 10
		E.db["sle"]["armory"]["inspect"]["enchant"]["yOffset"] = -1
		E.db["sle"]["armory"]["inspect"]["gem"]["size"] = 11
		E.db["sle"]["armory"]["inspect"]["gem"]["xOffset"] = 4
		E.db["sle"]["armory"]["inspect"]["gradient"]["quality"] = true
		E.db["sle"]["armory"]["inspect"]["gradient"]["setArmor"] = true
		E.db["sle"]["armory"]["inspect"]["ilvl"]["colorType"] = "GRADIENT"
		E.db["sle"]["armory"]["inspect"]["ilvl"]["font"] = E.db.general.font
		E.db["sle"]["armory"]["inspect"]["ilvl"]["fontSize"] = 11
		E.db["sle"]["armory"]["stats"]["AverageColor"]["b"] = 1
		E.db["sle"]["armory"]["stats"]["AverageColor"]["g"] = 0
		E.db["sle"]["armory"]["stats"]["AverageColor"]["r"] = 0.66666666666667
		E.db["sle"]["armory"]["stats"]["IlvlColor"] = true
		E.db["sle"]["armory"]["stats"]["List"]["ALTERNATEMANA"] = true
		E.db["sle"]["armory"]["stats"]["List"]["ATTACK_AP"] = true
		E.db["sle"]["armory"]["stats"]["List"]["ATTACK_ATTACKSPEED"] = true
		E.db["sle"]["armory"]["stats"]["List"]["ATTACK_DAMAGE"] = false
		E.db["sle"]["armory"]["stats"]["List"]["ENERGY_REGEN"] = true
		E.db["sle"]["armory"]["stats"]["List"]["FOCUS_REGEN"] = true
		E.db["sle"]["armory"]["stats"]["List"]["HEALTH"] = true
		E.db["sle"]["armory"]["stats"]["List"]["MANAREGEN"] = true
		E.db["sle"]["armory"]["stats"]["List"]["POWER"] = true
		E.db["sle"]["armory"]["stats"]["List"]["RUNE_REGEN"] = true
		E.db["sle"]["armory"]["stats"]["statLabels"]["font"] = E.db.general.font
		E.db["sle"]["armory"]["stats"]["statLabels"]["outline"] = ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle)
		E.db["sle"]["armory"]["stats"]["decimals"] = false
		E.db["sle"]["armory"]["stats"]["itemLevel"]["font"] = E.db.general.font
		E.db["sle"]["armory"]["stats"]["itemLevel"]["outline"] = ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle)
		E.db["sle"]["armory"]["stats"]["itemLevel"]["size"] = 20
		E.db["sle"]["armory"]["stats"]["statHeaders"]["font"] = E.db.general.font
		E.db["sle"]["armory"]["stats"]["statHeaders"]["outline"] = ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle)
		E.db["sle"]["armory"]["stats"]["statHeaders"]["size"] = 10

		--bags
		E.db["sle"]["bags"]["equipmentmanager"]["enable"] = true

		--- Media
		E.db["sle"]["media"]["fonts"]["mail"]["font"] = E.db.general.font
		E.db["sle"]["media"]["fonts"]["mail"]["fontOutline"] = ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle)
		E.db["sle"]["media"]["fonts"]["mail"]["fontSize"] = 11
		E.db["sle"]["media"]["fonts"]["objective"]["font"] = E.db.general.font
		E.db["sle"]["media"]["fonts"]["objective"]["fontOutline"] = ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle)
		E.db["sle"]["media"]["fonts"]["objective"]["fontSize"] = 13
		E.db["sle"]["media"]["fonts"]["objectiveHeader"]["font"] = E.db.general.font
		E.db["sle"]["media"]["fonts"]["objectiveHeader"]["fontOutline"] = ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle)
		E.db["sle"]["media"]["fonts"]["objectiveHeader"]["fontSize"] = 15
		E.db["sle"]["media"]["fonts"]["questFontSuperHuge"]["font"] = E.db.general.font
		E.db["sle"]["media"]["fonts"]["questFontSuperHuge"]["fontOutline"] = ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle)
		E.db["sle"]["media"]["fonts"]["questFontSuperHuge"]["fontSize"] = 22
		E.db["sle"]["media"]["fonts"]["scenarioStage"]["HeaderText"]["font"] = E.db.general.font
		E.db["sle"]["media"]["fonts"]["scenarioStage"]["HeaderText"]["fontSize"] = 16
		E.db["sle"]["media"]["fonts"]["scenarioStage"]["HeaderText"]["fontOutline"] = ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle)
		E.db["sle"]["media"]["fonts"]["scenarioStage"]["TimerText"]["font"] = E.db.general.font
		E.db["sle"]["media"]["fonts"]["scenarioStage"]["TimerText"]["fontSize"] = 22
		E.db["sle"]["media"]["fonts"]["scenarioStage"]["TimerText"]["fontOutline"] = ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle)
		-- Minimap
		E.db["sle"]["minimap"]["coords"]["enable"] = true
		E.db["sle"]["minimap"]["coords"]["font"] = E.db.general.font
		E.db["sle"]["minimap"]["coords"]["fontOutline"] = ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle)
		E.db["sle"]["minimap"]["coords"]["fontSize"] = 13
		E.db["sle"]["minimap"]["coords"]["format"] = "%.2f"
		E.db["sle"]["minimap"]["coords"]["mouseover"] = true
		E.db["sle"]["minimap"]["coords"]["yOffset"] = -70
		E.db["sle"]["minimap"]["instance"]["enable"] = false
		E.db["sle"]["minimap"]["instance"]["font"] = E.db.general.font
		E.db["sle"]["minimap"]["instance"]["fontOutline"] = ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle)
		E.db["sle"]["minimap"]["instance"]["fontSize"] = 13
		E.db["sle"]["minimap"]["instance"]["xoffset"] = -5
		E.db["sle"]["minimap"]["instance"]["yoffset"] = -20
		E.db["sle"]["minimap"]["locPanel"]["combathide"] = true
		E.db["sle"]["minimap"]["locPanel"]["enable"] = false
		E.db["sle"]["minimap"]["locPanel"]["font"] = E.db.general.font
		E.db["sle"]["minimap"]["locPanel"]["fontOutline"] = ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle)
		E.db["sle"]["minimap"]["locPanel"]["fontSize"] = 14
		E.db["sle"]["minimap"]["locPanel"]["format"] = "%.2f"
		E.db["sle"]["minimap"]["locPanel"]["height"] = 28
		E.db["sle"]["minimap"]["locPanel"]["portals"]["cdFormat"] = "DEFAULT_ICONFIRST"
		E.db["sle"]["minimap"]["locPanel"]["portals"]["customWidthValue"] = 270
		E.db["sle"]["minimap"]["locPanel"]["portals"]["ignoreMissingInfo"] = true
		E.db["sle"]["minimap"]["locPanel"]["width"] = 425
		-- Nameplates
		--E.db["sle"]["nameplates"]["targetcount"]["font"] = E.db.general.font
		--E.db["sle"]["nameplates"]["targetcount"]["fontOutline"] = ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle)
		--E.db["sle"]["nameplates"]["targetcount"]["size"] = 10
		--E.db["sle"]["nameplates"]["targetcount"]["xoffset"] = 0
		--E.db["sle"]["nameplates"]["targetcount"]["yoffset"] = 1
		--E.db["sle"]["nameplates"]["threat"]["enable"] = false
		--E.db["sle"]["nameplates"]["targetcount"]["enable"] = false

		-- PvP
		E.db["sle"]["pvp"]["autorelease"] = true
		E.db["sle"]["pvp"]["duels"]["announce"] = true

		-- Quests
		E.db["sle"]["quests"]["autoReward"] = true

		-- Raidmanager
		E.db["sle"]["raidmanager"]["roles"] = true
		E.db["sle"]["raidmarkers"]["backdrop"] = true
		E.db["sle"]["raidmarkers"]["enable"] = false
		E.db["sle"]["raidmarkers"]["mouseover"] = true
		E.db["sle"]["raidmarkers"]["spacing"] = 3
		E.db["sle"]["raidmarkers"]["visibility"] = "ALWAYS"

		-- Chat
		--E.db["sle"]["chat"]["combathide"] = "LEFT"
		E.db["sle"]["chat"]["dpsSpam"] = true
		E.db["sle"]["chat"]["guildmaster"] = true
		E.db["sle"]["chat"]["invite"]["altInv"] = true
		E.db["sle"]["chat"]["textureAlpha"]["alpha"] = 0.47

		-- Databars
		E.db["sle"]["databars"]["experience"]["chatfilter"]["enable"] = true
		E.db["sle"]["databars"]["experience"]["chatfilter"]["style"] = "STYLE2"
		E.db["sle"]["databars"]["honor"]["chatfilter"]["awardStyle"] = "STYLE2"
		E.db["sle"]["databars"]["honor"]["chatfilter"]["enable"] = true
		E.db["sle"]["databars"]["honor"]["chatfilter"]["style"] = "STYLE2"
		E.db["sle"]["databars"]["reputation"]["chatfilter"]["enable"] = true
		E.db["sle"]["databars"]["reputation"]["chatfilter"]["showAll"] = true
		E.db["sle"]["databars"]["reputation"]["chatfilter"]["style"] = "STYLE2"
		E.db["sle"]["databars"]["reputation"]["chatfilter"]["styleDec"] = "STYLE2"
		-- Datatexts
		E.db["sle"]["dt"]["friends"]["combat"] = true
		E.db["sle"]["dt"]["friends"]["hideAFK"] = true
		E.db["sle"]["dt"]["friends"]["hideDND"] = true
		E.db["sle"]["dt"]["friends"]["hide_hintline"] = true
		E.db["sle"]["dt"]["friends"]["hide_titleline"] = true
		E.db["sle"]["dt"]["friends"]["tooltipAutohide"] = 0.1
		E.db["sle"]["dt"]["guild"]["combat"] = true
		E.db["sle"]["dt"]["guild"]["hide_hintline"] = true
		E.db["sle"]["dt"]["guild"]["hide_titleline"] = true
		E.db["sle"]["dt"]["guild"]["tooltipAutohide"] = 0.1

		--Loot
		E.db["sle"]["loot"]["enable"] = false

		--AFK Screensaver
		E.db["sle"]["afk"]["animTime"] = 2
		E.db["sle"]["afk"]["animType"] = "FadeIn"
		E.db["sle"]["afk"]["customGraphics"] = {}
		E.db["sle"]["afk"]["customGraphics"]["EltruismLogo"] = {}
		E.db["sle"]["afk"]["customGraphics"]["EltruismLogo"]["alpha"] = 1
		E.db["sle"]["afk"]["customGraphics"]["EltruismLogo"]["anchorPoint"] = "CENTER"
		E.db["sle"]["afk"]["customGraphics"]["EltruismLogo"]["attachTo"] = "SL_TopPanel"
		E.db["sle"]["afk"]["customGraphics"]["EltruismLogo"]["drawLayer"] = "ARTWORK"
		E.db["sle"]["afk"]["customGraphics"]["EltruismLogo"]["drawLevel"] = 1
		E.db["sle"]["afk"]["customGraphics"]["EltruismLogo"]["enable"] = true
		E.db["sle"]["afk"]["customGraphics"]["EltruismLogo"]["height"] = 80
		E.db["sle"]["afk"]["customGraphics"]["EltruismLogo"]["inversePoint"] = false
		E.db["sle"]["afk"]["customGraphics"]["EltruismLogo"]["name"] = "EltruismLogo"
		E.db["sle"]["afk"]["customGraphics"]["EltruismLogo"]["path"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\logohq"
		E.db["sle"]["afk"]["customGraphics"]["EltruismLogo"]["width"] = 320
		E.db["sle"]["afk"]["customGraphics"]["EltruismLogo"]["xOffset"] = 0
		E.db["sle"]["afk"]["customGraphics"]["EltruismLogo"]["yOffset"] = 0
		E.db["sle"]["afk"]["defaultGraphics"]["classCrest"]["anchorPoint"] = "TOPLEFT"
		E.db["sle"]["afk"]["defaultGraphics"]["classCrest"]["attachTo"] = "SL_BottomPanel"
		E.db["sle"]["afk"]["defaultGraphics"]["classCrest"]["styleOptions"] = "benikui"
		E.db["sle"]["afk"]["defaultGraphics"]["classCrest"]["height"] = 128
		E.db["sle"]["afk"]["defaultGraphics"]["classCrest"]["width"] = 128
		E.db["sle"]["afk"]["defaultGraphics"]["classCrest"]["xOffset"] = 0
		E.db["sle"]["afk"]["defaultGraphics"]["classCrest"]["yOffset"] = 5
		E.db["sle"]["afk"]["defaultGraphics"]["elvuiLogo"]["anchorPoint"] = "LEFT"
		E.db["sle"]["afk"]["defaultGraphics"]["elvuiLogo"]["attachTo"] = "SL_TopPanel"
		E.db["sle"]["afk"]["defaultGraphics"]["elvuiLogo"]["height"] = 128
		E.db["sle"]["afk"]["defaultGraphics"]["elvuiLogo"]["styleOptions"] = "sltheme"
		E.db["sle"]["afk"]["defaultGraphics"]["elvuiLogo"]["width"] = 256
		E.db["sle"]["afk"]["defaultGraphics"]["elvuiLogo"]["xOffset"] = 0
		E.db["sle"]["afk"]["defaultGraphics"]["elvuiLogo"]["yOffset"] = 0
		E.db["sle"]["afk"]["defaultGraphics"]["exPack"]["anchorPoint"] = "CENTER"
		E.db["sle"]["afk"]["defaultGraphics"]["exPack"]["attachTo"] = "SL_BottomPanel"
		E.db["sle"]["afk"]["defaultGraphics"]["exPack"]["height"] = 75
		E.db["sle"]["afk"]["defaultGraphics"]["exPack"]["inversePoint"] = true
		E.db["sle"]["afk"]["defaultGraphics"]["exPack"]["styleOptions"] = "blizzard"
		E.db["sle"]["afk"]["defaultGraphics"]["exPack"]["width"] = 150
		E.db["sle"]["afk"]["defaultGraphics"]["exPack"]["yOffset"] = -15
		E.db["sle"]["afk"]["defaultGraphics"]["factionCrest"]["anchorPoint"] = "CENTER"
		E.db["sle"]["afk"]["defaultGraphics"]["factionCrest"]["attachTo"] = "SL_TopPanel"
		E.db["sle"]["afk"]["defaultGraphics"]["factionCrest"]["styleOptions"] = "sltheme"
		E.db["sle"]["afk"]["defaultGraphics"]["factionCrest"]["xOffset"] = 220
		E.db["sle"]["afk"]["defaultGraphics"]["factionCrest"]["yOffset"] = 0
		E.db["sle"]["afk"]["defaultGraphics"]["factionLogo"]["enable"] = false
		E.db["sle"]["afk"]["defaultGraphics"]["raceCrest"]["anchorPoint"] = "CENTER"
		E.db["sle"]["afk"]["defaultGraphics"]["raceCrest"]["styleOptions"] = "sltheme"
		E.db["sle"]["afk"]["defaultGraphics"]["raceCrest"]["xOffset"] = -220
		E.db["sle"]["afk"]["defaultGraphics"]["raceCrest"]["yOffset"] = 0
		E.db["sle"]["afk"]["defaultGraphics"]["slLogo"]["anchorPoint"] = "RIGHT"
		E.db["sle"]["afk"]["defaultGraphics"]["slLogo"]["attachTo"] = "SL_TopPanel"
		E.db["sle"]["afk"]["defaultGraphics"]["slLogo"]["height"] = 128
		E.db["sle"]["afk"]["defaultGraphics"]["slLogo"]["width"] = 256
		E.db["sle"]["afk"]["defaultGraphics"]["slLogo"]["xOffset"] = 0
		E.db["sle"]["afk"]["defaultGraphics"]["slLogo"]["yOffset"] = 0
		E.db["sle"]["afk"]["defaultTexts"]["SL_AFKMessage"]["anchorPoint"] = "LEFT"
		E.db["sle"]["afk"]["defaultTexts"]["SL_AFKMessage"]["attachTo"] = "SL_BottomPanel"
		E.db["sle"]["afk"]["defaultTexts"]["SL_AFKMessage"]["font"] = E.db.general.font
		E.db["sle"]["afk"]["defaultTexts"]["SL_AFKMessage"]["size"] = 20
		E.db["sle"]["afk"]["defaultTexts"]["SL_AFKMessage"]["xOffset"] = 127
		E.db["sle"]["afk"]["defaultTexts"]["SL_AFKMessage"]["yOffset"] = 0
		E.db["sle"]["afk"]["defaultTexts"]["SL_AFKTimePassed"]["countdown"] = true
		E.db["sle"]["afk"]["defaultTexts"]["SL_AFKTimePassed"]["font"] = E.db.general.font
		E.db["sle"]["afk"]["defaultTexts"]["SL_AFKTimePassed"]["size"] = 20
		E.db["sle"]["afk"]["defaultTexts"]["SL_AFKTimePassed"]["xOffset"] = 2
		E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["anchorPoint"] = "TOPRIGHT"
		E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["attachTo"] = "SL_BottomPanel"
		E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["enable"] = false
		E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["font"] = E.db.general.font
		E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["xOffset"] = 20
		E.db["sle"]["afk"]["defaultTexts"]["SL_Date"]["yOffset"] = 50
		E.db["sle"]["afk"]["defaultTexts"]["SL_GuildName"]["anchorPoint"] = "BOTTOMLEFT"
		E.db["sle"]["afk"]["defaultTexts"]["SL_GuildName"]["attachTo"] = "SL_PlayerName"
		E.db["sle"]["afk"]["defaultTexts"]["SL_GuildName"]["enable"] = false
		E.db["sle"]["afk"]["defaultTexts"]["SL_GuildName"]["font"] = E.db.general.font
		E.db["sle"]["afk"]["defaultTexts"]["SL_GuildName"]["size"] = 20
		E.db["sle"]["afk"]["defaultTexts"]["SL_GuildRank"]["anchorPoint"] = "RIGHT"
		E.db["sle"]["afk"]["defaultTexts"]["SL_GuildRank"]["attachTo"] = "SL_GuildName"
		E.db["sle"]["afk"]["defaultTexts"]["SL_GuildRank"]["enable"] = false
		E.db["sle"]["afk"]["defaultTexts"]["SL_GuildRank"]["font"] = E.db.general.font
		E.db["sle"]["afk"]["defaultTexts"]["SL_GuildRank"]["size"] = 20
		E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerClass"]["anchorPoint"] = "TOPRIGHT"
		E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerClass"]["attachTo"] = "SL_TopPanel"
		E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerClass"]["enable"] = false
		E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerClass"]["font"] = E.db.general.font
		E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerLevel"]["enable"] = false
		E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["anchorPoint"] = "TOPLEFT"
		E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["attachTo"] = "SL_BottomPanel"
		E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["font"] = E.db.general.font
		E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["size"] = 20
		E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["xOffset"] = 128
		E.db["sle"]["afk"]["defaultTexts"]["SL_PlayerName"]["yOffset"] = -30
		E.db["sle"]["afk"]["defaultTexts"]["SL_ScrollFrame"]["enable"] = false
		E.db["sle"]["afk"]["defaultTexts"]["SL_ScrollFrame"]["font"] = E.db.general.font
		E.db["sle"]["afk"]["defaultTexts"]["SL_ScrollFrame"]["yOffset"] = -40
		E.db["sle"]["afk"]["defaultTexts"]["SL_SubText"]["enable"] = false
		E.db["sle"]["afk"]["defaultTexts"]["SL_SubText"]["font"] = E.db.general.font
		E.db["sle"]["afk"]["defaultTexts"]["SL_SubText"]["size"] = 16
		E.db["sle"]["afk"]["defaultTexts"]["SL_SubText"]["xOffset"] = 0
		E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["anchorPoint"] = "CENTER"
		E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["attachTo"] = "SL_BottomPanel"
		E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["font"] = E.db.general.font
		E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["size"] = 32
		E.db["sle"]["afk"]["defaultTexts"]["SL_Time"]["yOffset"] = 40
		E.db["sle"]["afk"]["enable"] = true
		E.db["sle"]["afk"]["panels"]["bottom"]["height"] = 120
		E.db["sle"]["afk"]["panels"]["top"]["height"] = 120
		E.db["sle"]["afk"]["playermodel"]["anim"] = 47

		-- Shadows
		E.db["sle"]["shadows"]["actionbars"]["bar1"]["buttons"] = false
		E.db["sle"]["shadows"]["actionbars"]["bar1"]["size"] = 2
		E.db["sle"]["shadows"]["actionbars"]["bar10"]["buttons"] = false
		E.db["sle"]["shadows"]["actionbars"]["bar10"]["size"] = 2
		E.db["sle"]["shadows"]["actionbars"]["bar2"]["buttons"] = false
		E.db["sle"]["shadows"]["actionbars"]["bar2"]["size"] = 2
		E.db["sle"]["shadows"]["actionbars"]["bar3"]["buttons"] = false
		E.db["sle"]["shadows"]["actionbars"]["bar3"]["size"] = 2
		E.db["sle"]["shadows"]["actionbars"]["bar4"]["buttons"] = false
		E.db["sle"]["shadows"]["actionbars"]["bar4"]["size"] = 2
		E.db["sle"]["shadows"]["actionbars"]["bar5"]["buttons"] = false
		E.db["sle"]["shadows"]["actionbars"]["bar5"]["size"] = 2
		E.db["sle"]["shadows"]["actionbars"]["bar6"]["buttons"] = false
		E.db["sle"]["shadows"]["actionbars"]["bar6"]["size"] = 2
		E.db["sle"]["shadows"]["actionbars"]["bar7"]["buttons"] = false
		E.db["sle"]["shadows"]["actionbars"]["bar7"]["size"] = 2
		E.db["sle"]["shadows"]["actionbars"]["bar8"]["buttons"] = false
		E.db["sle"]["shadows"]["actionbars"]["bar8"]["size"] = 2
		E.db["sle"]["shadows"]["actionbars"]["bar9"]["buttons"] = false
		E.db["sle"]["shadows"]["actionbars"]["bar9"]["size"] = 2
		E.db["sle"]["shadows"]["actionbars"]["microbar"]["buttons"] = false
		E.db["sle"]["shadows"]["actionbars"]["microbar"]["size"] = 2
		E.db["sle"]["shadows"]["actionbars"]["petbar"]["backdrop"] = false
		E.db["sle"]["shadows"]["actionbars"]["petbar"]["buttons"] = false
		E.db["sle"]["shadows"]["actionbars"]["petbar"]["size"] = 2
		E.db["sle"]["shadows"]["actionbars"]["stancebar"]["buttons"] = false
		E.db["sle"]["shadows"]["actionbars"]["stancebar"]["size"] = 2

		E.db["sle"]["shadows"]["chat"]["LeftChatPanel"]["backdrop"] = false
		E.db["sle"]["shadows"]["chat"]["LeftChatPanel"]["size"] = 2
		E.db["sle"]["shadows"]["chat"]["RightChatPanel"]["backdrop"] = false
		E.db["sle"]["shadows"]["chat"]["RightChatPanel"]["size"] = 2

		E.db["sle"]["shadows"]["databars"]["azerite"]["size"] = 2
		E.db["sle"]["shadows"]["databars"]["experience"]["size"] = 2
		E.db["sle"]["shadows"]["databars"]["honor"]["size"] = 2
		E.db["sle"]["shadows"]["databars"]["reputation"]["size"] = 2

		E.db["sle"]["shadows"]["datatexts"]["panels"]["LeftChatDataPanel"]["backdrop"] = false
		E.db["sle"]["shadows"]["datatexts"]["panels"]["LeftChatDataPanel"]["size"] = 2
		E.db["sle"]["shadows"]["datatexts"]["panels"]["MinimapPanel"]["size"] = 2
		E.db["sle"]["shadows"]["datatexts"]["panels"]["RightChatDataPanel"]["backdrop"] = false
		E.db["sle"]["shadows"]["datatexts"]["panels"]["RightChatDataPanel"]["size"] = 2

		E.db["sle"]["shadows"]["minimap"]["backdrop"] = false
		E.db["sle"]["shadows"]["minimap"]["size"] = 2

		E.db["sle"]["shadows"]["unitframes"]["arena"]["health"] = false
		E.db["sle"]["shadows"]["unitframes"]["arena"]["power"] = false
		E.db["sle"]["shadows"]["unitframes"]["boss"]["health"] = false
		E.db["sle"]["shadows"]["unitframes"]["boss"]["power"] = false
		E.db["sle"]["shadows"]["unitframes"]["focus"]["health"] = false
		E.db["sle"]["shadows"]["unitframes"]["focus"]["power"] = false
		E.db["sle"]["shadows"]["unitframes"]["party"]["health"] = false
		E.db["sle"]["shadows"]["unitframes"]["party"]["power"] = false
		E.db["sle"]["shadows"]["unitframes"]["pet"]["health"] = false
		E.db["sle"]["shadows"]["unitframes"]["pet"]["power"] = false
		E.db["sle"]["shadows"]["unitframes"]["player"]["classbar"] = false
		E.db["sle"]["shadows"]["unitframes"]["player"]["health"] = false
		E.db["sle"]["shadows"]["unitframes"]["player"]["power"] = false
		E.db["sle"]["shadows"]["unitframes"]["size"] = 2
		E.db["sle"]["shadows"]["unitframes"]["target"]["health"] = false
		E.db["sle"]["shadows"]["unitframes"]["target"]["power"] = false
		E.db["sle"]["shadows"]["unitframes"]["targettarget"]["health"] = false
		E.db["sle"]["shadows"]["unitframes"]["targettarget"]["power"] = false

		-- Skins
		E.db["sle"]["skins"]["merchant"]["list"]["nameFont"] = E.db.general.font
		E.db["sle"]["skins"]["merchant"]["list"]["nameSize"] = 12
		E.db["sle"]["skins"]["merchant"]["list"]["subFont"] = E.db.general.font
		E.db["sle"]["skins"]["merchant"]["list"]["subOutline"] = ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle)
		E.db["sle"]["skins"]["merchant"]["list"]["subSize"] = 8
		E.db["sle"]["skins"]["objectiveTracker"]["underline"] = false
		E.db["sle"]["skins"]["objectiveTracker"]["classHeader"] = false
		E.db["sle"]["skins"]["objectiveTracker"]["colorHeader"]["b"] = 1
		E.db["sle"]["skins"]["objectiveTracker"]["colorHeader"]["g"] = 0
		E.db["sle"]["skins"]["objectiveTracker"]["colorHeader"]["r"] = 0.81960784313725
		E.db["sle"]["skins"]["objectiveTracker"]["underlineClass"] = false
		E.db["sle"]["skins"]["talkinghead"]["hide"] = true

		--Unitframes this was erroring in 915 due to internal sle change months back that i didnt realize
		E.db["sle"]["unitframes"]["roleIcons"]["icons"] = "Eltruism"

		--E.private["sle"]["unitframe"]["statusbarTextures"]["aura"] = true --old
		E.db["sle"]["unitframe"]["statusbarTextures"]["aurabar"]["enable"] = false
		E.db["sle"]["unitframe"]["statusbarTextures"]["aurabar"]["texture"] = "ElvUI Norm1"
		E.db["sle"]["unitframe"]["statusbarTextures"]["castbar"]["enable"] = false
		E.db["sle"]["unitframe"]["statusbarTextures"]["castbar"]["texture"] = "ElvUI Norm1"

		E.db["sle"]["unitframe"]["units"]["arena"]["deathIndicator"]["custom"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Dead\\dead5.tga"
		E.db["sle"]["unitframe"]["units"]["arena"]["deathIndicator"]["enable"] = true
		E.db["sle"]["unitframe"]["units"]["arena"]["deathIndicator"]["size"] = 15
		E.db["sle"]["unitframe"]["units"]["arena"]["deathIndicator"]["texture"] = "CUSTOM"
		E.db["sle"]["unitframe"]["units"]["arena"]["offlineIndicator"]["custom"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Disconnect\\dc2.tga"
		E.db["sle"]["unitframe"]["units"]["arena"]["offlineIndicator"]["enable"] = true
		E.db["sle"]["unitframe"]["units"]["arena"]["offlineIndicator"]["size"] = 15
		E.db["sle"]["unitframe"]["units"]["arena"]["offlineIndicator"]["texture"] = "CUSTOM"
		E.db["sle"]["unitframe"]["units"]["assist"]["deathIndicator"]["custom"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Dead\\dead5.tga"
		E.db["sle"]["unitframe"]["units"]["assist"]["deathIndicator"]["enable"] = true
		E.db["sle"]["unitframe"]["units"]["assist"]["deathIndicator"]["size"] = 15
		E.db["sle"]["unitframe"]["units"]["assist"]["deathIndicator"]["texture"] = "CUSTOM"
		E.db["sle"]["unitframe"]["units"]["assist"]["offlineIndicator"]["custom"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Disconnect\\dc2.tga"
		E.db["sle"]["unitframe"]["units"]["assist"]["offlineIndicator"]["enable"] = true
		E.db["sle"]["unitframe"]["units"]["assist"]["offlineIndicator"]["size"] = 15
		E.db["sle"]["unitframe"]["units"]["assist"]["offlineIndicator"]["texture"] = "CUSTOM"
		E.db["sle"]["unitframe"]["units"]["party"]["deathIndicator"]["custom"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Dead\\dead5.tga"
		E.db["sle"]["unitframe"]["units"]["party"]["deathIndicator"]["size"] = 25
		E.db["sle"]["unitframe"]["units"]["party"]["deathIndicator"]["texture"] = "CUSTOM"
		E.db["sle"]["unitframe"]["units"]["party"]["deathIndicator"]["yOffset"] = 10
		E.db["sle"]["unitframe"]["units"]["party"]["offlineIndicator"]["custom"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Disconnect\\dc2.tga"
		E.db["sle"]["unitframe"]["units"]["party"]["offlineIndicator"]["size"] = 25
		E.db["sle"]["unitframe"]["units"]["party"]["offlineIndicator"]["texture"] = "CUSTOM"
		E.db["sle"]["unitframe"]["units"]["party"]["offlineIndicator"]["yOffset"] = 10
		E.db["sle"]["unitframe"]["units"]["raid1"]["deathIndicator"]["custom"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Dead\\dead5.tga"
		E.db["sle"]["unitframe"]["units"]["raid1"]["deathIndicator"]["enable"] = true
		E.db["sle"]["unitframe"]["units"]["raid1"]["deathIndicator"]["size"] = 15
		E.db["sle"]["unitframe"]["units"]["raid1"]["deathIndicator"]["texture"] = "CUSTOM"
		E.db["sle"]["unitframe"]["units"]["raid1"]["offlineIndicator"]["custom"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Disconnect\\dc2.tga"
		E.db["sle"]["unitframe"]["units"]["raid1"]["offlineIndicator"]["enable"] = true
		E.db["sle"]["unitframe"]["units"]["raid1"]["offlineIndicator"]["size"] = 15
		E.db["sle"]["unitframe"]["units"]["raid1"]["offlineIndicator"]["texture"] = "CUSTOM"
		E.db["sle"]["unitframe"]["units"]["raid2"]["deathIndicator"]["custom"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Dead\\dead5.tga"
		E.db["sle"]["unitframe"]["units"]["raid2"]["deathIndicator"]["enable"] = true
		E.db["sle"]["unitframe"]["units"]["raid2"]["deathIndicator"]["size"] = 15
		E.db["sle"]["unitframe"]["units"]["raid2"]["deathIndicator"]["texture"] = "CUSTOM"
		E.db["sle"]["unitframe"]["units"]["raid2"]["offlineIndicator"]["custom"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Disconnect\\dc2.tga"
		E.db["sle"]["unitframe"]["units"]["raid2"]["offlineIndicator"]["enable"] = true
		E.db["sle"]["unitframe"]["units"]["raid2"]["offlineIndicator"]["size"] = 15
		E.db["sle"]["unitframe"]["units"]["raid2"]["offlineIndicator"]["texture"] = "CUSTOM"
		E.db["sle"]["unitframe"]["units"]["raid3"]["deathIndicator"]["custom"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Dead\\dead5.tga"
		E.db["sle"]["unitframe"]["units"]["raid3"]["deathIndicator"]["enable"] = true
		E.db["sle"]["unitframe"]["units"]["raid3"]["deathIndicator"]["size"] = 15
		E.db["sle"]["unitframe"]["units"]["raid3"]["deathIndicator"]["texture"] = "CUSTOM"
		E.db["sle"]["unitframe"]["units"]["raid3"]["offlineIndicator"]["custom"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Disconnect\\dc2.tga"
		E.db["sle"]["unitframe"]["units"]["raid3"]["offlineIndicator"]["enable"] = true
		E.db["sle"]["unitframe"]["units"]["raid3"]["offlineIndicator"]["size"] = 15
		E.db["sle"]["unitframe"]["units"]["raid3"]["offlineIndicator"]["texture"] = "CUSTOM"
		E.db["sle"]["unitframe"]["units"]["tank"]["deathIndicator"]["custom"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Dead\\dead5.tga"
		E.db["sle"]["unitframe"]["units"]["tank"]["deathIndicator"]["enable"] = true
		E.db["sle"]["unitframe"]["units"]["tank"]["deathIndicator"]["size"] = 15
		E.db["sle"]["unitframe"]["units"]["tank"]["deathIndicator"]["texture"] = "CUSTOM"
		E.db["sle"]["unitframe"]["units"]["tank"]["offlineIndicator"]["custom"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Disconnect\\dc2.tga"
		E.db["sle"]["unitframe"]["units"]["tank"]["offlineIndicator"]["enable"] = true
		E.db["sle"]["unitframe"]["units"]["tank"]["offlineIndicator"]["size"] = 15
		E.db["sle"]["unitframe"]["units"]["tank"]["offlineIndicator"]["texture"] = "CUSTOM"

		ElvUI_EltreumUI:Print("Shadow and Light profile has been set")

		E.private.ElvUI_EltreumUI.isInstalled.sle = true
	else
		ElvUI_EltreumUI:Print("Shadow and Light is not loaded")
	end
end
