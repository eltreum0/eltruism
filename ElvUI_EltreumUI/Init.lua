-- This whole plugin uses LuckyoneUI as a base, full credits to him for it and allowing its use!
local E, _, V, P, G = unpack(ElvUI)
local EP = LibStub('LibElvUIPlugin-1.0')
local addon, Engine = ...
local _G = _G
local ElvUI_EltreumUI = E:NewModule(addon, 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0', 'AceConsole-3.0')
local myclass = E.myclass
local L = E.Libs.ACL:GetLocale("ElvUI", E.global.general.locale)
local SetCVar = _G.SetCVar
local GetAddOnMetadata = _G.GetAddOnMetadata
local hooksecurefunc = _G.hooksecurefunc

Engine[1] = ElvUI_EltreumUI
Engine[2] = E --ElvUI Engine
Engine[3] = L --ElvUI Locales
Engine[4] = V --ElvUI PrivateDB
Engine[5] = P --ElvUI ProfileDB
Engine[6] = G --ElvUI GlobalDB
_G[addon] = Engine

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
	ElvUI_EltreumUI:LoadCommands() --loads chat commands
	ElvUI_EltreumUI:Borders() --creates borders if option is enabled
	ElvUI_EltreumUI:ClassIconsOnCharacterPanel()  --adds class icons to character panel
	ElvUI_EltreumUI:AFKmusic() --plays music while afk
	ElvUI_EltreumUI:LootText() --shows LooTText and combat entering/leaving messages
	ElvUI_EltreumUI:VersionCheckInit() --checks for old versions
	ElvUI_EltreumUI:CursorInit() --starts cursor modules
	ElvUI_EltreumUI:SkinMailZone() --skins zone change messages and mail font
	ElvUI_EltreumUI:Shadows() --adds shadows to frames
	ElvUI_EltreumUI:AuraShadows() -- adds shadows to elvui auras
	ElvUI_EltreumUI:AutoScreenshot() --takes screenshots when certain events are fired
	ElvUI_EltreumUI:SkinQuests() --skins quest objective frame to be class colored
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
	if ElvUI_EltreumUI.Retail then
		ElvUI_EltreumUI:WaypointTimeToArrive() --adds an ETA below waypoints
		ElvUI_EltreumUI:SkillGlow() --makes skill glow using libcustomglow
		ElvUI_EltreumUI:EltruismHideTalkingHead() --hides talking head from world quests
		ElvUI_EltreumUI:GetSpec() --checks player spec
		ElvUI_EltreumUI:SkinLevelUp() --skins level up toast
		ElvUI_EltreumUI:ArenaQuest() --hides quests when in arena/bgs
		if myclass == 'HUNTER' then
			ElvUI_EltreumUI:ExpandedStable() --expands pet stable for hunters
		end
	elseif ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
		ElvUI_EltreumUI:DynamicClassicDatatext() --toggles datatext for warlocks/hunters to show soulshards/ammo
		ElvUI_EltreumUI:ExpandedTalents() --makes talents fit in one window without scroll
	end
	if E.private["nameplates"]["enable"] == true then
		ElvUI_EltreumUI:NamePlateOptions() --adds dynamic class based color filters to elvui nameplates
		ElvUI_EltreumUI:DynamicLevelStyleFilter() --shows or hides level filter on np based on player level
		ElvUI_EltreumUI:UpdateNPwithoutBar() --updates buffs/debuffs positions on np based on powerbar settings
	end
	--Better EventTrace CLEU logging thanks to ;Meorawr.wtf.lua;
	if E.db.ElvUI_EltreumUI.dev then
		LoadAddOn("Blizzard_EventTrace");
		local LogEvent = EventTrace.LogEvent;
		function EventTrace:LogEvent(event, ...)
			if event == "COMBAT_LOG_EVENT_UNFILTERED" then
				LogEvent(self, event, CombatLogGetCurrentEventInfo());
			else
				LogEvent(self, event, ...);
			end
		end
		ElvUI_EltreumUI:Print("|cFFFF0000WARNING:|r You are using Development Tools which increase CPU Usage. Use |cFFFF0000/eltruism dev|r to disable them")
	end
end

function ElvUI_EltreumUI:HidePopups()
	--E:StaticPopup_Hide('INCOMPATIBLE_ADDON') --915 error to be tested
	--E:StaticPopup_Hide('DISABLE_INCOMPATIBLE_ADDON') --915 error to be tested
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
	ElvUI_EltreumUI:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED') --for party/raid death
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
	ElvUI_EltreumUI:RegisterEvent('UNIT_AURA') --for aura shadows
	ElvUI_EltreumUI:RegisterEvent("UNIT_NAME_UPDATE") --for class icons in the character frame
	ElvUI_EltreumUI:RegisterEvent('PLAYER_TARGET_CHANGED') --for power bar
	ElvUI_EltreumUI:RegisterEvent('UNIT_POWER_FREQUENT') --power update real time
	ElvUI_EltreumUI:RegisterEvent('UNIT_POWER_UPDATE') --power type changes
	ElvUI_EltreumUI:RegisterEvent("UNIT_MODEL_CHANGED") --druid things
	ElvUI_EltreumUI:RegisterEvent('UNIT_SPELLCAST_START') --for power prediction
	ElvUI_EltreumUI:RegisterEvent('UNIT_SPELLCAST_STOP') --for power prediction
	ElvUI_EltreumUI:RegisterEvent("CHAT_MSG_LOOT") --LootText things
	ElvUI_EltreumUI:RegisterEvent("CHAT_MSG_MONEY") --LootText things
	ElvUI_EltreumUI:RegisterEvent("CHAT_MSG_CURRENCY") --LootText things
	ElvUI_EltreumUI:RegisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN") --LootText things
	ElvUI_EltreumUI:RegisterEvent("LOOT_OPENED") --LootText things
	ElvUI_EltreumUI:RegisterEvent('UI_ERROR_MESSAGE') --LootText things
	--SetCVars at start
	SetCVar('nameplateOtherBottomInset', 0.02)
	SetCVar('nameplateOtherTopInset', 0.1)
	SetCVar('cameraDistanceMaxZoomFactor', 2.6)
	SetCVar('nameplateTargetRadialPosition', 1)
	--depending on game version sets cvars or register events
	if ElvUI_EltreumUI.Retail then
		ElvUI_EltreumUI:RegisterEvent('PLAYER_SPECIALIZATION_CHANGED') --for class icons, power bar and shadows
		ElvUI_EltreumUI:RegisterEvent('GOSSIP_SHOW') --for rogue order hall
		SetCVar('showInGameNavigation', 1)
	end
	if ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
		SetCVar('clampTargetNameplateToScreen', 1)
	end
end

function ElvUI_EltreumUI:PLAYER_TARGET_CHANGED()
	--if E.private["nameplates"]["enable"] == true then --this causes problems for plater
		ElvUI_EltreumUI:NamePlateOptions()
		ElvUI_EltreumUI:NameplatePower()
	--end
end

function ElvUI_EltreumUI:UNIT_MODEL_CHANGED(event,unit)
	if unit and unit ~= 'player' then
		return
	elseif unit and unit == 'player' then
		--print(event,unit)
		ElvUI_EltreumUI:NameplatePowerTextUpdate(event,unit)
		ElvUI_EltreumUI:NameplatePower(event)
	end
end

function ElvUI_EltreumUI:UNIT_AURA(unit)
	if unit and unit ~= 'player' then
		return
	elseif unit and unit == 'player' then
		--print(event,unit)
		ElvUI_EltreumUI:AuraShadows()
	end
end

function ElvUI_EltreumUI:UNIT_POWER_FREQUENT(event,unit)
	if unit and unit ~= 'player' then
		return
	elseif unit and unit == 'player' then
		--print(event,unit)
		ElvUI_EltreumUI:NameplatePowerTextUpdate(event,unit)
		ElvUI_EltreumUI:NameplatePower(event)
		ElvUI_EltreumUI:PowerPrediction(event)
	end
end

function ElvUI_EltreumUI:UNIT_POWER_UPDATE(event,unit)
	if unit and unit ~= 'player' then
		return
	elseif unit and unit == 'player' then
		--print(event,unit)
		ElvUI_EltreumUI:NameplatePowerTextUpdate(event,unit)
		ElvUI_EltreumUI:PowerPrediction(event)
	end
end

function ElvUI_EltreumUI:UNIT_SPELLCAST_START(event,unit)
	if unit and unit ~= 'player' then
		return
	elseif unit and unit == 'player' then
		ElvUI_EltreumUI:PowerPrediction(event)
	end
end

function ElvUI_EltreumUI:UNIT_SPELLCAST_STOP(event,unit)
	if unit and unit ~= 'player' then
		return
	elseif unit and unit == 'player' then
		ElvUI_EltreumUI:PowerPrediction(event)
	end
end

function ElvUI_EltreumUI:COMBAT_LOG_EVENT_UNFILTERED()
	local _, eventType, _, _, _, _, _, _, _, _, _ = CombatLogGetCurrentEventInfo()
	--local _, eventType, _, _, sourceName, _, _, _, _, _, _, _, _, _, amount = CombatLogGetCurrentEventInfo()
	--if eventType ~= "UNIT_DIED" and eventType ~= "SPELL_ENERGIZE" then
	if eventType ~= "UNIT_DIED" then
		return
	elseif eventType == "UNIT_DIED" then
		ElvUI_EltreumUI:RaidDeath()
	end
	--elseif (eventType == "SPELL_ENERGIZE") and (sourceName == E.myname) then
		--print(sourceName.." amount: "..amount)
		--ElvUI_EltreumUI:PowerPrediction()
	--end
end

function ElvUI_EltreumUI:UNIT_NAME_UPDATE(event,unit)
	if unit and unit ~= 'player' then
		return
	elseif unit and unit == 'player' then
		--print(event,unit)
		ElvUI_EltreumUI:PlayerNamepaperdoll()
		--ElvUI_EltreumUI:ClassIconsOnCharacterPanel()
	end
end

function ElvUI_EltreumUI:PLAYER_SPECIALIZATION_CHANGED()
	ElvUI_EltreumUI:ClassIconsOnCharacterPanel()
	if ElvUI_EltreumUI.Retail then
		ElvUI_EltreumUI:GetSpec()
		ElvUI_EltreumUI:NamePlateOptions()
		ElvUI_EltreumUI:Shadows()
		if E.private["nameplates"]["enable"] == true then
			ElvUI_EltreumUI:UpdateNPwithoutBar()
		end
	end
end

--[[
-- ID then name, use id to work on any locale, name changes with locale
--classes that dont have a class bar at all
Demon Hunter	577	Havoc			581	Vengeance
Hunter			253	Beast Mastery	254	Marksmanship	255	Survival
Priest			256	Discipline		257	Holy			258	Shadow
Shaman			262	Elemental		263	Enhancement		264	Restoration
Warrior			71	Arms			72	Fury			73	Protection

--classes that have a classbar depending on spec or druid form
Druid			102	Balance			103	Feral			104	Guardian	105	Restoration
Mage			62	Arcane			63	Fire			64	Frost
Monk			268	Brewmaster		270	Mistweaver		269	Windwalker
Paladin			65	Holy			66	Protection		70	Retribution

--classes that always have a classbar
Rogue			259	Assassination	260	Outlaw			261	Subtlety
Warlock			265	Affliction		266	Demonology		267	Destruction
]]--

function ElvUI_EltreumUI:PLAYER_REGEN_ENABLED()
	ElvUI_EltreumUI:StopCombatMusic()
	ElvUI_EltreumUI:DynamicChatFade()
	ElvUI_EltreumUI:BlizzCombatText()
	--ElvUI_EltreumUI:ArenaUnitframes()
end

function ElvUI_EltreumUI:PLAYER_REGEN_DISABLED()
	ElvUI_EltreumUI:CombatMusic()
	ElvUI_EltreumUI:DynamicChatFade()
	ElvUI_EltreumUI:ArenaUnitframes()
end

function ElvUI_EltreumUI:PLAYER_LEVEL_UP()
	ElvUI_EltreumUI:DynamicLevelStyleFilter()
	ElvUI_EltreumUI:DynamicExperienceDatabar()
	ElvUI_EltreumUI:DynamicSpellStealStyleFilter()
end

function ElvUI_EltreumUI:ZONE_CHANGED()
	ElvUI_EltreumUI:FriendlyNameplates()
end

function ElvUI_EltreumUI:ZONE_CHANGED_INDOORS()
	ElvUI_EltreumUI:FriendlyNameplates()
end

function ElvUI_EltreumUI:ZONE_CHANGED_NEW_AREA()
	ElvUI_EltreumUI:FriendlyNameplates()
end

function ElvUI_EltreumUI:ENCOUNTER_START()
	if ElvUI_EltreumUI.Retail then
		ElvUI_EltreumUI:QuestEncounter()
	end
	ElvUI_EltreumUI:CombatMusic()
end

function ElvUI_EltreumUI:ENCOUNTER_END()
	if ElvUI_EltreumUI.Retail then
		ElvUI_EltreumUI:QuestEncounterEnd()
	end
end

function ElvUI_EltreumUI:UPDATE_STEALTH()
	ElvUI_EltreumUI:StealthOptions()
end

function ElvUI_EltreumUI:GROUP_ROSTER_UPDATE()
	ElvUI_EltreumUI:GroupRoster()
end

function ElvUI_EltreumUI:UI_ERROR_MESSAGE()
	ElvUI_EltreumUI:LootText()
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

function ElvUI_EltreumUI:PLAYER_FLAGS_CHANGED()
	ElvUI_EltreumUI:AFKmusic()
end

function ElvUI_EltreumUI:GOSSIP_SHOW()
	if ElvUI_EltreumUI.Retail then
		if myclass == 'ROGUE' then
			--ElvUI_EltreumUI:Print('youre a rogue')
			ElvUI_EltreumUI:RogueAutoOpen()
		end
	end
end

local function CallbackInitialize()
	ElvUI_EltreumUI:Initialize()
end
E:RegisterModule(addon, CallbackInitialize)
