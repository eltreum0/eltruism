local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local IsAddOnLoaded = _G.IsAddOnLoaded
local valuecolors = E:ClassColor(E.myclass, true)
local C_CVar = _G.C_CVar
local myclass = E.myclass

function ElvUI_EltreumUI:SetupGeneralLayout()
	if not E.db.movers then E.db.movers = {} end

		-- Setup UI Scale
		ElvUI_EltreumUI:SetupScale()

		-- Setup Global DB
		ElvUI_EltreumUI:SetupGlobal()

		-- Setup Private DB
		ElvUI_EltreumUI:SetupPrivate()

		--Setup CVars
		ElvUI_EltreumUI:SetupCVars()

		--SetupShadowAndLight
		if IsAddOnLoaded("ElvUI_SLE") then
			ElvUI_EltreumUI:GetSLEProfile()
		end

		-- AddOnSkins Profile
		if IsAddOnLoaded('AddOnSkins') then
			ElvUI_EltreumUI:GetASProfile()
		end

		if IsAddOnLoaded("ProjectAzilroka") then
			E.db["movers"]["SquareMinimapButtonBarMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-5,-226"
		end

		if IsAddOnLoaded("ElvUI_WindTools") then
			ElvUI_EltreumUI:GetWindToolsProfile()
		end

		--disable the quest hide by default on classic/tbc
		if ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
			E.db.ElvUI_EltreumUI.questsettings.enable = false
			E.db.ElvUI_EltreumUI.questsettings.arena = false
		end

		-- AB Conversion
		E.db["convertPages"] = true

		--mark as dark mode
		E.db.ElvUI_EltreumUI.lightmode = false

		-- General
		E.db["general"]["altPowerBar"]["font"] = "Kimberley"
		E.db["general"]["altPowerBar"]["fontOutline"] = "THICKOUTLINE"
		E.db["general"]["altPowerBar"]["smoothbars"] = true
		E.db["general"]["altPowerBar"]["statusBarColorGradient"] = true
		E.db["general"]["autoRepair"] = "GUILD"
		E.db["general"]["autoTrackReputation"] = true
		E.db["general"]["backdropcolor"]["b"] = 0
		E.db["general"]["backdropcolor"]["g"] = 0
		E.db["general"]["backdropcolor"]["r"] = 0
		E.db["general"]["bordercolor"]["b"] = 0
		E.db["general"]["bordercolor"]["g"] = 0
		E.db["general"]["bordercolor"]["r"] = 0
		E.db["general"]["backdropfadecolor"]["a"] = 0.70000001788139
		E.db["general"]["backdropfadecolor"]["b"] = 0
		E.db["general"]["backdropfadecolor"]["g"] = 0
		E.db["general"]["backdropfadecolor"]["r"] = 0
		E.db["general"]["bonusObjectivePosition"] = "RIGHT"
		E.db["general"]["bottomPanel"] = false
		E.db["general"]["font"] = "Kimberley"
		E.db["general"]["fontStyle"] = "THICKOUTLINE"
		E.db["general"]["interruptAnnounce"] = "RAID"
		E.db["general"]["itemLevel"]["itemLevelFont"] = "Kimberley"
		E.db["general"]["loginmessage"] = false
		E.db["general"]["minimap"]["icons"]["calendar"]["position"] = "TOPLEFT"  --not in classic??
		E.db["general"]["minimap"]["icons"]["calendar"]["xOffset"] = 3  --not in classic?
		E.db["general"]["minimap"]["icons"]["calendar"]["yOffset"] = -38  --not in classic?
		E.db["general"]["minimap"]["icons"]["classHall"]["position"] = "BOTTOM"  --not in classic
		E.db["general"]["minimap"]["icons"]["classHall"]["scale"] = 1  --not in classic
		E.db["general"]["minimap"]["icons"]["difficulty"]["position"] = "BOTTOM"  --not in classic
		E.db["general"]["minimap"]["icons"]["difficulty"]["scale"] = 1.2  --not in classic
		E.db["general"]["minimap"]["icons"]["mail"]["position"] = "BOTTOM"
		E.db["general"]["minimap"]["icons"]["mail"]["scale"] = 1.2
		E.db["general"]["minimap"]["icons"]["mail"]["texture"] = "Mail1"  --not in classic
		E.db["general"]["minimap"]["icons"]["mail"]["xOffset"] = 0
		E.db["general"]["minimap"]["icons"]["mail"]["yOffset"] = -27
		E.db["general"]["minimap"]["locationFont"] = "Kimberley"
		E.db["general"]["minimap"]["locationFontOutline"] = "THICKOUTLINE"
		E.db["general"]["minimap"]["locationFontSize"] = 14
		E.db["general"]["minimap"]["locationText"] = "SHOW"
		E.db["general"]["minimap"]["resetZoom"]["enable"] = true
		E.db["general"]["minimap"]["resetZoom"]["time"] = 10
		E.db["general"]["minimap"]["size"] = 200
		E.db["general"]["minimap"]["icons"]["queueStatus"]["font"] = "Kimberley"
		E.db["general"]["minimap"]["icons"]["queueStatus"]["fontOutline"] = "OUTLINE"
		E.db["general"]["minimap"]["icons"]["queueStatus"]["fontSize"] = 20
		E.db["general"]["minimap"]["icons"]["queueStatus"]["xOffset"] = 0
		E.db["general"]["minimap"]["icons"]["queueStatus"]["yOffset"] = 0
		E.db["general"]["objectiveFrameAutoHideInKeystone"] = false
		E.db["general"]["objectiveFrameHeight"] = 550
		E.db["general"]["resurrectSound"] = true
		E.db["general"]["talkingHeadFrameScale"] = 0.5
		E.db["general"]["totems"]["growthDirection"] = "HORIZONTAL"
		E.db["general"]["totems"]["size"] = 30
		E.db["general"]["totems"]["sortDirection"] = "DESCENDING"
		E.db["general"]["totems"]["spacing"] = 3
		E.db["general"]["valuecolor"]["b"] = valuecolors.b
		E.db["general"]["valuecolor"]["g"] = valuecolors.g
		E.db["general"]["valuecolor"]["r"] = valuecolors.r
		E.db["general"]["vehicleSeatIndicatorSize"] = 76
		E.db["general"]["taintLog"] = false

		E.db["unitframe"]["units"]["player"]["forcehealthreaction"] = false

		-- Bags
		E.db["bags"]["bagSize"] = 35
		E.db["bags"]["bagWidth"] = 412
		E.db["bags"]["bankSize"] = 35
		E.db["bags"]["bankWidth"] = 412
		E.db["bags"]["clearSearchOnClose"] = true
		E.db["bags"]["countFont"] = "Kimberley"
		E.db["bags"]["countFontOutline"] = "OUTLINE"
		E.db["bags"]["countFontSize"] = 12
		E.db["bags"]["itemInfoFont"] = "Kimberley"
		E.db["bags"]["itemInfoFontOutline"] = "OUTLINE"
		E.db["bags"]["itemLevelFontSize"] = 12
		E.db["bags"]["itemLevelFont"] = "Kimberley"
		E.db["bags"]["itemLevelFontOutline"] = "OUTLINE"
		E.db["bags"]["junkDesaturate"] = true
		E.db["bags"]["junkIcon"] = true
		E.db["bags"]["scrapIcon"] = true --not in classic
		E.db["bags"]["showBindType"] = true
		E.db["bags"]["split"]["bagSpacing"] = 7
		E.db["bags"]["transparent"] = true
		E.db["bags"]["vendorGrays"]["enable"] = true

		-- Chat
		E.db["chat"]["chatHistory"] = false
		E.db["chat"]["hideCopyButton"] = true
		E.db["chat"]["hideVoiceButtons"] = true
		E.db["chat"]["fadeTabsNoBackdrop"] = true
		E.db["chat"]["fadeUndockedTabs"] = true
		E.db["chat"]["panelBackdrop"] = "HIDEBOTH"
		E.db["chat"]["font"] = "Kimberley"
		E.db["chat"]["fontOutline"] = "OUTLINE"
		E.db["chat"]["fontSize"] = 12
		E.db["chat"]["inactivityTimer"] = 20
		E.db["chat"]["panelColor"]["a"] = 0.70000001788139
		E.db["chat"]["panelColor"]["b"] = 0
		E.db["chat"]["panelColor"]["g"] = 0
		E.db["chat"]["panelColor"]["r"] = 0
		E.db["chat"]["panelTabTransparency"] = false
		E.db["chat"]["panelHeight"] = 180
		E.db["chat"]["panelWidthRight"] = 400
		E.db["chat"]["tabFont"] = "Kimberley"
		E.db["chat"]["tabFontSize"] = 14
		E.db["chat"]["tabFontOutline"] = "OUTLINE"
		E.db["chat"]["tabSelectorColor"]["b"] = valuecolors.b
		E.db["chat"]["tabSelectorColor"]["g"] = valuecolors.g
		E.db["chat"]["tabSelectorColor"]["r"] = valuecolors.r
		E.db["chat"]["throttleInterval"] = 20

		-- Cooldown Text
		E.db["cooldown"]["fonts"]["enable"] = true
		E.db["cooldown"]["fonts"]["font"] = "Kimberley"
		E.db["cooldown"]["fonts"]["fontOutline"] = "THICKOUTLINE"

		-- DataBars
		if ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
			E.db["databars"]["threat"]["enable"] = true
			E.db["databars"]["threat"]["font"] = "Kimberley"
			E.db["databars"]["threat"]["fontOutline"] = "OUTLINE"
			E.db["databars"]["threat"]["fontSize"] = 12
			E.db["databars"]["threat"]["height"] = 22
			E.db["databars"]["threat"]["orientation"] = "HORIZONTAL"
			E.db["databars"]["threat"]["width"] = 412
		end
		if ElvUI_EltreumUI.Retail then
			E.db["databars"]["azerite"]["font"] = "Kimberley"
			E.db["databars"]["azerite"]["fontOutline"] = "THICKOUTLINE"
			E.db["databars"]["azerite"]["fontSize"] = 12
			E.db["databars"]["azerite"]["height"] = 203
			E.db["databars"]["azerite"]["hideInCombat"] = true
			E.db["databars"]["azerite"]["mouseover"] = true
			E.db["databars"]["azerite"]["width"] = 10
			E.db["databars"]["azerite"]["enable"] = false
		end
		E.db["databars"]["colors"]["azerite"]["a"] = 0.5
		E.db["databars"]["colors"]["azerite"]["b"] = 0.6
		E.db["databars"]["colors"]["azerite"]["r"] = 0.90196078431373
		E.db["databars"]["colors"]["experience"]["a"] = 0.5
		E.db["databars"]["colors"]["honor"]["a"] = 0.5
		E.db["databars"]["colors"]["honor"]["b"] = 0.25098039215686
		E.db["databars"]["colors"]["honor"]["g"] = 0.45098039215686
		E.db["databars"]["colors"]["honor"]["r"] = 0.94117647058824
		E.db["databars"]["colors"]["rested"]["a"] = 0.20000004768372
		E.db["databars"]["customTexture"] = true

		--new experience
		E.db["databars"]["experience"]["font"] = "Kimberley"
		E.db["databars"]["experience"]["fontOutline"] = "OUTLINE"
		E.db["databars"]["experience"]["fontSize"] = 10
		E.db["databars"]["experience"]["height"] = 12
		E.db["databars"]["experience"]["mouseover"] = true
		E.db["databars"]["experience"]["questCompletedOnly"] = true
		E.db["databars"]["experience"]["questCurrentZoneOnly"] = true
		E.db["databars"]["experience"]["questTrackedOnly"] = true
		E.db["databars"]["experience"]["showBubbles"] = true
		E.db["databars"]["experience"]["showLevel"] = true
		E.db["databars"]["experience"]["textFormat"] = "CUR"
		E.db["databars"]["experience"]["width"] = 500
		--new pet experience
		E.db["databars"]["petExperience"]["enable"] = false
		--new reputation
		E.db["databars"]["reputation"]["enable"] = true
		E.db["databars"]["reputation"]["font"] = "Kimberley"
		E.db["databars"]["reputation"]["fontOutline"] = "OUTLINE"
		E.db["databars"]["reputation"]["fontSize"] = 10
		E.db["databars"]["reputation"]["height"] = 12
		E.db["databars"]["reputation"]["mouseover"] = true
		E.db["databars"]["reputation"]["showBubbles"] = true
		E.db["databars"]["reputation"]["textFormat"] = "REM"
		E.db["databars"]["reputation"]["width"] = 500
		E.db["databars"]["honor"]["enable"] = false
		E.db["databars"]["honor"]["font"] = "Kimberley"
		E.db["databars"]["honor"]["height"] = 203
		E.db["databars"]["honor"]["hideBelowMaxLevel"] = true
		E.db["databars"]["honor"]["hideInCombat"] = true
		E.db["databars"]["honor"]["hideOutsidePvP"] = true
		E.db["databars"]["honor"]["mouseover"] = true
		E.db["databars"]["honor"]["orientation"] = "VERTICAL"
		E.db["databars"]["honor"]["width"] = 10
		E.db["databars"]["threat"]["enable"] = false
		E.db["databars"]["threat"]["font"] = "Kimberley"
		E.db["databars"]["threat"]["fontOutline"] = "OUTLINE"
		E.db["databars"]["threat"]["fontSize"] = 12
		E.db["databars"]["threat"]["height"] = 22
		E.db["databars"]["threat"]["orientation"] = "HORIZONTAL"
		E.db["databars"]["threat"]["width"] = 412

		-- DataTexts
		E.db["datatexts"]["font"] = "Kimberley"
		E.db["datatexts"]["fontOutline"] = "THICKOUTLINE"
		E.db["datatexts"]["noCombatClick"] = true
		E.db["datatexts"]["noCombatHover"] = true
		E.db["datatexts"]["panels"]["MinimapPanel"][1] = "Time"
		E.db["datatexts"]["panels"]["MinimapPanel"]["border"] = false
		if ElvUI_EltreumUI.Retail then
			E.db["datatexts"]["panels"]["LeftChatDataPanel"][3] = "Missions"
			E.db["datatexts"]["panels"]["LeftChatDataPanel"]["border"] = false
			E.db["datatexts"]["panels"]["LeftChatDataPanel"]["panelTransparency"] = true
			E.db["datatexts"]["panels"]["LeftChatDataPanel"]["backdrop"] = false
			E.db["datatexts"]["panels"]["LeftChatDataPanel"]["right"] = "System"
			E.db["datatexts"]["panels"]["RightChatDataPanel"][2] = "Combat"
			E.db["datatexts"]["panels"]["RightChatDataPanel"]["border"] = false
			E.db["datatexts"]["panels"]["RightChatDataPanel"]["left"] = "Orderhall"
			E.db["datatexts"]["panels"]["RightChatDataPanel"]["middle"] = "BfA Missions"
			E.db["datatexts"]["panels"]["RightChatDataPanel"]["panelTransparency"] = true
			E.db["datatexts"]["panels"]["RightChatDataPanel"]["backdrop"] = false
			if IsAddOnLoaded("ElvUI_SLE") then
				E.db["datatexts"]["panels"]["MinimapPanel"][2] = "S&L Friends"
			else
				E.db["datatexts"]["panels"]["MinimapPanel"][2] = "Friends"
			end
		elseif ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
			E.db["datatexts"]["panels"]["LeftChatDataPanel"][1] = "ElvUI"
			E.db["datatexts"]["panels"]["LeftChatDataPanel"]["left"] = "ElvUI Config"
			E.db["datatexts"]["panels"]["LeftChatDataPanel"][2] = "Durability"
			E.db["datatexts"]["panels"]["LeftChatDataPanel"]["middle"] = "Durability"
			E.db["datatexts"]["panels"]["LeftChatDataPanel"][1] = "ElvUI"
			E.db["datatexts"]["panels"]["LeftChatDataPanel"]["left"] = "ElvUI Config"
			E.db["datatexts"]["panels"]["LeftChatDataPanel"][2] = "Durability"
			E.db["datatexts"]["panels"]["LeftChatDataPanel"]["middle"] = "Durability"
			if myclass == 'HUNTER' or myclass == 'WARLOCK' then
				E.db["datatexts"]["panels"]["LeftChatDataPanel"][3] = "Ammo"
			else
				E.db["datatexts"]["panels"]["LeftChatDataPanel"][3] = "Friends"
			end
			E.db["datatexts"]["panels"]["LeftChatDataPanel"]["border"] = false
			E.db["datatexts"]["panels"]["LeftChatDataPanel"]["panelTransparency"] = true
			E.db["datatexts"]["panels"]["LeftChatDataPanel"]["backdrop"] = false
			E.db["datatexts"]["panels"]["LeftChatDataPanel"]["right"] = "Guild"
			E.db["datatexts"]["panels"]["MinimapPanel"][2] = "Coords"
			E.db["datatexts"]["panels"]["RightChatDataPanel"][2] = "Combat"
			E.db["datatexts"]["panels"]["RightChatDataPanel"]["border"] = false
			E.db["datatexts"]["panels"]["RightChatDataPanel"]["left"] = "System"
			E.db["datatexts"]["panels"]["RightChatDataPanel"]["middle"] = "Combat Time"
			E.db["datatexts"]["panels"]["RightChatDataPanel"]["panelTransparency"] = true
			E.db["datatexts"]["panels"]["RightChatDataPanel"]["backdrop"] = false
		end

		-- Tooltip
		E.db["tooltip"]["alwaysShowRealm"] = true
		E.db["tooltip"]["colorAlpha"] = 0.7
		E.db["tooltip"]["cursorAnchor"] = true
		E.db["tooltip"]["font"] = "Kimberley"
		E.db["tooltip"]["healthBar"]["font"] = "Kimberley"
		E.db["tooltip"]["healthBar"]["fontOutline"] = "OUTLINE"
		E.db["tooltip"]["healthBar"]["height"] = 15
		E.db["tooltip"]["healthBar"]["statusPosition"] = "TOP"
		E.db["tooltip"]["itemCount"] = "NONE"
		E.db["tooltip"]["modifierID"] = "SHIFT"
		E.db["tooltip"]["showElvUIUsers"] = true
		E.db["tooltip"]["visibility"]["combatOverride"] = "CTRL"

		-- ActionBars general
		E.db["actionbar"]["bar1"]["inheritGlobalFade"] = true
		E.db["actionbar"]["bar2"]["inheritGlobalFade"] = true
		E.db["actionbar"]["bar3"]["inheritGlobalFade"] = true
		E.db["actionbar"]["bar4"]["inheritGlobalFade"] = true
		E.db["actionbar"]["bar5"]["inheritGlobalFade"] = true
		E.db["actionbar"]["barPet"]["inheritGlobalFade"] = true
		E.db["actionbar"]["bar6"]["inheritGlobalFade"] = false
		E.db["actionbar"]["bar7"]["inheritGlobalFade"] = false
		E.db["actionbar"]["bar8"]["inheritGlobalFade"] = false
		E.db["actionbar"]["bar9"]["inheritGlobalFade"] = false
		E.db["actionbar"]["bar10"]["inheritGlobalFade"] = false
		E.db["actionbar"]["extraActionButton"]["inheritGlobalFade"] = false --retail only
		E.db["actionbar"]["zoneActionButton"]["inheritGlobalFade"] = false --retail only
		E.db["actionbar"]["stanceBar"]["inheritGlobalFade"] = true

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
			["enable"] = false,
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
		if ElvUI_EltreumUI.Retail then
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
		elseif ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
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
		E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPlayerAbsorb"] = {
			["attachTextTo"] = "Health",
			["enable"] = false,
			["font"] = "Kimberley",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 12,
			["text_format"] = "||cffFFFF00[absorbs]||r ",
			["xOffset"] = 0,
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
			["enable"] = false,
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
			["enable"] = false,
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
			["enable"] = false,
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
		if ElvUI_EltreumUI.Retail then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"] = {
				["attachTextTo"] = "Health",
				["enable"] = true,
				["font"] = "Kimberley",
				["fontOutline"] = "THICKOUTLINE",
				["justifyH"] = "RIGHT",
				["size"] = 16,
				["text_format"] = "[eltruism:raidmarker] [eltruism:class:player] [namecolor][name:eltruism:abbreviate]",
				["xOffset"] = -2,
				["yOffset"] = 0
			}
		elseif ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
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
		end
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

	E:StaggeredUpdateAll(nil, true)
	ElvUI_EltreumUI:Print(L["General Layout has been set."])
end
