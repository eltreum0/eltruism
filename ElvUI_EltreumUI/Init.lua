-- This whole plugin uses LuckyoneUI as a base, full credits to him for it and allowing its use!
local E, _, V, P, G = unpack(ElvUI)
local EP = LibStub('LibElvUIPlugin-1.0')
local addon, Engine = ...
local _G = _G
local ElvUI_EltreumUI = E:NewModule(addon, 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0', 'AceConsole-3.0')
local myclass = E.myclass
local L = E.Libs.ACL:GetLocale("ElvUI", E.global.general.locale)
local GetAddOnMetadata = _G.GetAddOnMetadata
local hooksecurefunc = _G.hooksecurefunc

Engine[1] = ElvUI_EltreumUI
Engine[2] = E --ElvUI Engine
Engine[3] = L --ElvUI Locales
Engine[4] = V --ElvUI PrivateDB
Engine[5] = P --ElvUI ProfileDB
Engine[6] = G --ElvUI GlobalDB
_G[addon] = Engine

--Binding
_G.BINDING_HEADER_ELTRUISM = GetAddOnMetadata(..., 'Title')
_G["BINDING_NAME_CLICK EltruismQuestItem1:LeftButton"] = "Quest Item 1"
_G["BINDING_NAME_CLICK EltruismQuestItem2:LeftButton"] = "Quest Item 2"
_G["BINDING_NAME_CLICK EltruismQuestItem3:LeftButton"] = "Quest Item 3"
_G["BINDING_NAME_CLICK EltruismQuestItem4:LeftButton"] = "Quest Item 4"
_G["BINDING_NAME_CLICK EltruismQuestItem5:LeftButton"] = "Quest Item 5"
_G["BINDING_NAME_CLICK EltruismQuestItem6:LeftButton"] = "Quest Item 6"
_G["BINDING_NAME_CLICK EltruismQuestItem7:LeftButton"] = "Quest Item 7"
_G["BINDING_NAME_CLICK EltruismQuestItem8:LeftButton"] = "Quest Item 8"
_G["BINDING_NAME_CLICK EltruismQuestItem9:LeftButton"] = "Quest Item 9"
_G["BINDING_NAME_CLICK EltruismQuestItem10:LeftButton"] = "Quest Item 10"
_G["BINDING_NAME_CLICK EltruismQuestItem11:LeftButton"] = "Quest Item 11"
_G["BINDING_NAME_CLICK EltruismQuestItem12:LeftButton"] = "Quest Item 12"

--Constants
ElvUI_EltreumUI.Version = GetAddOnMetadata(addon, 'Version')
ElvUI_EltreumUI.CreditsList = {}
ElvUI_EltreumUI.Config = {}
ElvUI_EltreumUI.Name = '|cff82B4ffEltruism|r'

--Check WoW Project ID
ElvUI_EltreumUI.Retail = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
ElvUI_EltreumUI.Classic = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC
ElvUI_EltreumUI.TBC = WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC

function ElvUI_EltreumUI:PLAYER_ENTERING_WORLD()
	if not E.private.ElvUI_EltreumUI.install_version then
		return
	end
	ElvUI_EltreumUI:VersionCheckInit() --checks for old versions
	ElvUI_EltreumUI:ExtraMedia() -- load extra media if settings enabled
	ElvUI_EltreumUI:LoadCommands() --loads chat commands
	ElvUI_EltreumUI:Borders() --creates borders if option is enabled
	ElvUI_EltreumUI:ClassIconsOnCharacterPanel()  --adds class icons to character panel
	ElvUI_EltreumUI:PlayerNamepaperdoll() --update player name
	ElvUI_EltreumUI:CursorInit() --starts cursor modules
	ElvUI_EltreumUI:SkinMailZone() --skins zone change messages and mail font
	ElvUI_EltreumUI:Shadows() --adds shadows to frames
	ElvUI_EltreumUI:AutoScreenshot() --takes screenshots when certain events are fired
	ElvUI_EltreumUI:FriendlyNameplates() -- controls hiding healthbar from friendly nameplates inside instances
	ElvUI_EltreumUI:TextureMode() -- checks for light mode in order to set texture to be class based, fired only when option is enabled
	ElvUI_EltreumUI:WAAnchor()  --creates a weakaura anchor that can be used to attack weakauras to elvui's unitframe visibility settings
	ElvUI_EltreumUI:ChatRoleSwapIcons() --adds custom role icons in chat when swapping roles
	ElvUI_EltreumUI:DynamicChatFade() --adds chat fade/hide functions
	ElvUI_EltreumUI:StealthOptions() --adds an overlay when in stealth
	ElvUI_EltreumUI:DynamicSpellStealStyleFilter() -- toggles spellsteal filter for mages based on their level
	ElvUI_EltreumUI:DynamicExperienceDatabar() --makes experience bar mouseover or not depending on current player level
	ElvUI_EltreumUI:BlizzCombatText() --enables or disables blizzard's combat text depending on player setting in eltruism
	ElvUI_EltreumUI:ArenaUnitframes() --hides elvui unitframes in arenas
	ElvUI_EltreumUI:BattlegroundGroupUnitframes() --hides elvui unitframes in bgs
	ElvUI_EltreumUI:DynamicBuffs() --shows enemy player buffs on nameplates/unitframes if in arena/bgs, hides otherwise
	ElvUI_EltreumUI:EnteringWorldCVars() --set cvars at the start
	ElvUI_EltreumUI:RaidDeathGroupCheck() -- attempt at prevent CLEU tracking
	ElvUI_EltreumUI:AutoAcceptQuests() -- yet another auto accept quest thing
	ElvUI_EltreumUI:QuestItem() -- quest item bar merged from QBar by Aezay with edits to work in TBC/Classic
	ElvUI_EltreumUI:SkinQuests() --skins quest objective frame to be class colored
	ElvUI_EltreumUI:ExpandedCharacterStats() --attempt at improving the character panel
	ElvUI_EltreumUI:DeathSound() -- set the party/raid death sound
	ElvUI_EltreumUI:ChangePlayerTexture() -- load the player texture
	ElvUI_EltreumUI:DeleteItem() -- automatically type delete
	ElvUI_EltreumUI:SkillGlow() --makes skill glow using libcustomglow
	if ElvUI_EltreumUI.Retail then
		ElvUI_EltreumUI:WaypointTimeToArrive() --adds an ETA below waypoints
		ElvUI_EltreumUI:EltruismHideTalkingHead() --hides talking head from world quests
		ElvUI_EltreumUI:GetSpec() --checks player spec
		ElvUI_EltreumUI:SkinLevelUp() --skins level up toast
		ElvUI_EltreumUI:ArenaQuest() --hides quests when in arena/bgs
		if myclass == 'HUNTER' then
			ElvUI_EltreumUI:ExpandedStable() --expands pet stable for hunters
		end
	elseif ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
		ElvUI_EltreumUI:ClassicSockets()
		ElvUI_EltreumUI:DynamicClassicDatatext() --toggles datatext for warlocks/hunters to show soulshards/ammo
		ElvUI_EltreumUI:ExpandedTalents() --makes talents fit in one window without scroll
		ElvUI_EltreumUI:UpdateAvgIlvl()
	end
	if E.private.nameplates.enable then
		ElvUI_EltreumUI:NamePlateOptions() --adds dynamic class based color filters to elvui nameplates
		ElvUI_EltreumUI:DynamicLevelStyleFilter() --shows or hides level filter on np based on player level
		ElvUI_EltreumUI:UpdateNPwithoutBar() --updates buffs/debuffs positions on np based on powerbar settings
	end
	--all of these are to load extra media if the player enables them
	if E.db.ElvUI_EltreumUI.media.statusbar then
		ElvUI_EltreumUI:ExtraMediaStatusBar()
	end
	if E.db.ElvUI_EltreumUI.media.font then
		ElvUI_EltreumUI:ExtraMediaFonts()
	end
	if E.db.ElvUI_EltreumUI.media.sound then
		ElvUI_EltreumUI:ExtraMediaSounds()
	end
	if E.db.ElvUI_EltreumUI.media.texture then
		ElvUI_EltreumUI:ExtraMediaTextures()
	end
	if E.db.ElvUI_EltreumUI.media.border then
		ElvUI_EltreumUI:ExtraMediaBorders()
	end
	if E.db.ElvUI_EltreumUI.dev then --load dev tools if user enables
		ElvUI_EltreumUI:DevTools()
	end
end

function ElvUI_EltreumUI:HidePopups()
	if E:IsAddOnEnabled("ElvUI_WindTools") then
		local W = unpack(WindTools)
		local function WindtoolsCompatHideWhileInstall()
			WTCompatibilityFrame:Kill()
		end
		hooksecurefunc(W, "ConstructCompatibilityFrame", WindtoolsCompatHideWhileInstall)
	end
end

function ElvUI_EltreumUI:Initialize()
	--since now Eltruism has both ElvUI Cvars and ElvUI Chat setup builtin we can skip elvui setup
	if not E.private.ElvUI_EltreumUI.install_version then
		E.private.install_complete = E.version
		ElvUI_EltreumUI:HidePopups()
		E:GetModule('PluginInstaller'):Queue(ElvUI_EltreumUI.InstallerData)
	end
	--register the plugin config
	EP:RegisterPlugin(addon, ElvUI_EltreumUI.Configtable)
	--Register Events
	ElvUI_EltreumUI:RegisterEvent('ENCOUNTER_START') --for quests and combat music
	ElvUI_EltreumUI:RegisterEvent('ENCOUNTER_END') --for quests and combat music
	ElvUI_EltreumUI:RegisterEvent('GROUP_ROSTER_UPDATE') --to store group roster in order to compare in party/raid death
	ElvUI_EltreumUI:RegisterEvent('PLAYER_ENTERING_WORLD') --for most of the addon
	ElvUI_EltreumUI:RegisterEvent('PLAYER_FLAGS_CHANGED') -- for afk music
	ElvUI_EltreumUI:RegisterEvent('PLAYER_LEVEL_UP') --for the level up skin
	ElvUI_EltreumUI:RegisterEvent('PLAYER_REGEN_ENABLED') --for combat music/chat hide/unitframe hide
	ElvUI_EltreumUI:RegisterEvent('PLAYER_REGEN_DISABLED') --for combat music/chat hide/unitframe hide
	ElvUI_EltreumUI:RegisterEvent('UPDATE_STEALTH') --for stealth overlay
	ElvUI_EltreumUI:RegisterEvent('ZONE_CHANGED_INDOORS') --for hiding healthbar in friendly np
	ElvUI_EltreumUI:RegisterEvent('ZONE_CHANGED') --for hiding healthbar in friendly np
	ElvUI_EltreumUI:RegisterEvent('ZONE_CHANGED_NEW_AREA') --for hiding healthbar in friendly np
	ElvUI_EltreumUI:RegisterEvent('PLAYER_TARGET_CHANGED') --for power bar and light mode texture
	ElvUI_EltreumUI:RegisterEvent("CHAT_MSG_LOOT") --LootText things
	ElvUI_EltreumUI:RegisterEvent("CHAT_MSG_MONEY") --LootText things
	ElvUI_EltreumUI:RegisterEvent("CHAT_MSG_CURRENCY") --LootText things
	ElvUI_EltreumUI:RegisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN") --LootText things
	ElvUI_EltreumUI:RegisterEvent("LOOT_OPENED") --LootText things
	ElvUI_EltreumUI:RegisterEvent('UI_ERROR_MESSAGE') --LootText things
	ElvUI_EltreumUI:RegisterEvent('INSPECT_READY')
	if ElvUI_EltreumUI.Retail then
		ElvUI_EltreumUI:RegisterEvent('PLAYER_SPECIALIZATION_CHANGED') --for class icons, power bar and shadows
		ElvUI_EltreumUI:RegisterEvent('GOSSIP_SHOW') --for rogue order hall
		ElvUI_EltreumUI:RegisterEvent('ACHIEVEMENT_EARNED') --for auto screenshot
		ElvUI_EltreumUI:RegisterEvent('CHALLENGE_MODE_COMPLETED') --for auto screenshot
	end
	if ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
		ElvUI_EltreumUI:RegisterEvent('PLAYER_AVG_ITEM_LEVEL_UPDATE')
	end
end

function ElvUI_EltreumUI:COMBAT_LOG_EVENT_UNFILTERED()
	local _, eventType, _, _, _, _, _, _, _, destFlags = CombatLogGetCurrentEventInfo()
	if eventType == "UNIT_DIED" and E.db.ElvUI_EltreumUI.partyraiddeath.enable then
		ElvUI_EltreumUI:RaidDeath(destFlags)
	end
end

function ElvUI_EltreumUI:ENCOUNTER_START(event)
	local event2 = event
	ElvUI_EltreumUI:QuestEncounter()
	ElvUI_EltreumUI:CombatMusic(event2)
	ElvUI_EltreumUI:BossMusic(event)
end

function ElvUI_EltreumUI:ENCOUNTER_END(event)
	local event2 = event
	ElvUI_EltreumUI:QuestEncounterEnd()
	ElvUI_EltreumUI:StopBossMusic(event)
	ElvUI_EltreumUI:StopCombatMusic(event2)
end

function ElvUI_EltreumUI:GROUP_ROSTER_UPDATE()
	ElvUI_EltreumUI:RaidDeathGroupCheck()
	if E.db.ElvUI_EltreumUI.lightmode and E.db.ElvUI_EltreumUI.modetexture then
		ElvUI_EltreumUI:ChangePartyTexture()
		ElvUI_EltreumUI:ChangeRaid40Texture()
		ElvUI_EltreumUI:ChangeRaidTexture()
	end
end

function ElvUI_EltreumUI:PLAYER_FLAGS_CHANGED()
	ElvUI_EltreumUI:AFKmusic()
	if E.db.general.afk then
		ElvUI_EltreumUI:AFKLogo()
	end
end

function ElvUI_EltreumUI:PLAYER_LEVEL_UP()
	ElvUI_EltreumUI:DynamicLevelStyleFilter()
	ElvUI_EltreumUI:DynamicExperienceDatabar()
	ElvUI_EltreumUI:DynamicSpellStealStyleFilter()
	ElvUI_EltreumUI:AutoScreenshot()
end

function ElvUI_EltreumUI:PLAYER_REGEN_ENABLED(event)
	ElvUI_EltreumUI:StopCombatMusic(event)
	ElvUI_EltreumUI:DynamicChatFade()
	ElvUI_EltreumUI:BlizzCombatText()
	ElvUI_EltreumUI:QuestCombatEnd()
end

function ElvUI_EltreumUI:PLAYER_REGEN_DISABLED(event)
	ElvUI_EltreumUI:CombatMusic(event)
	ElvUI_EltreumUI:DynamicChatFade()
	ElvUI_EltreumUI:ArenaUnitframes()
	ElvUI_EltreumUI:QuestCombat()
end

function ElvUI_EltreumUI:UPDATE_STEALTH()
	ElvUI_EltreumUI:StealthOptions()
end

function ElvUI_EltreumUI:ZONE_CHANGED()
	ElvUI_EltreumUI:FriendlyNameplates()
	ElvUI_EltreumUI:SkinMailZone()
end

function ElvUI_EltreumUI:ZONE_CHANGED_INDOORS()
	ElvUI_EltreumUI:FriendlyNameplates()
end

function ElvUI_EltreumUI:ZONE_CHANGED_NEW_AREA()
	C_Timer.After(5, function() ElvUI_EltreumUI:FriendlyNameplates() end)
	ElvUI_EltreumUI:QuestItem()
end

function ElvUI_EltreumUI:PLAYER_TARGET_CHANGED()
	ElvUI_EltreumUI:NamePlateOptions()
	ElvUI_EltreumUI:NameplatePower()
end

function ElvUI_EltreumUI:CHAT_MSG_LOOT()
	ElvUI_EltreumUI:LootText()
end

function ElvUI_EltreumUI:CHAT_MSG_MONEY()
	ElvUI_EltreumUI:LootText()
end

function ElvUI_EltreumUI:CHAT_MSG_CURRENCY()
	ElvUI_EltreumUI:LootText()
end

function ElvUI_EltreumUI:CHAT_MSG_COMBAT_HONOR_GAIN()
	ElvUI_EltreumUI:LootText()
end

function ElvUI_EltreumUI:LOOT_OPENED()
	ElvUI_EltreumUI:LootText()
end

function ElvUI_EltreumUI:UI_ERROR_MESSAGE()
	ElvUI_EltreumUI:LootText()
end

function ElvUI_EltreumUI:PLAYER_SPECIALIZATION_CHANGED()
	ElvUI_EltreumUI:ClassIconsOnCharacterPanel()
	if ElvUI_EltreumUI.Retail then
		ElvUI_EltreumUI:GetSpec()
		ElvUI_EltreumUI:NamePlateOptions()
		ElvUI_EltreumUI:Shadows()
		if E.private.nameplates.enable then
			ElvUI_EltreumUI:UpdateNPwithoutBar()
		end
	end
end

function ElvUI_EltreumUI:GOSSIP_SHOW()
	if ElvUI_EltreumUI.Retail then
		if myclass == 'ROGUE' then
			ElvUI_EltreumUI:RogueAutoOpen()
		end
	end
end

function ElvUI_EltreumUI:ACHIEVEMENT_EARNED()
	ElvUI_EltreumUI:AutoScreenshot()
end

function ElvUI_EltreumUI:CHALLENGE_MODE_COMPLETED()
	ElvUI_EltreumUI:AutoScreenshot()
end

function ElvUI_EltreumUI:PLAYER_AVG_ITEM_LEVEL_UPDATE()
	ElvUI_EltreumUI:UpdateAvgIlvl()
end

function ElvUI_EltreumUI:INSPECT_READY(event,unit)
	ElvUI_EltreumUI:InspectBg(unit)
end

local function CallbackInitialize()
	ElvUI_EltreumUI:Initialize()
end
E:RegisterModule(addon, CallbackInitialize)

if IsAddOnLoaded("ElvUI_CPU") then
	ElvUI_CPU:RegisterPlugin(ElvUI_EltreumUI)
	--ElvUIDev:RegisterPluginModule("ElvUI_EltreumUI", moduleName, module)
end
