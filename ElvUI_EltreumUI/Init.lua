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
local IsAddOnLoaded =  _G.IsAddOnLoaded
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
	if not E.private.ElvUI_EltreumUI.install_version then return end
	ElvUI_EltreumUI:LoadCommands()
	ElvUI_EltreumUI:Borders()
	ElvUI_EltreumUI:ClassIconsOnCharacterPanel()
	ElvUI_EltreumUI:AFKmusic()
	ElvUI_EltreumUI:LootText()
	ElvUI_EltreumUI:VersionCheckInit()
	ElvUI_EltreumUI:CursorInit()
	ElvUI_EltreumUI:CastCursor()
	ElvUI_EltreumUI:SkinMailZone()
	ElvUI_EltreumUI:Shadows()
	ElvUI_EltreumUI:AuraShadows()
	ElvUI_EltreumUI:SkinQuests()
	ElvUI_EltreumUI:FriendlyNameplates()
	ElvUI_EltreumUI:TextureMode()
	ElvUI_EltreumUI:WAAnchor()
	ElvUI_EltreumUI:ChatRoleSwapIcons()
	ElvUI_EltreumUI:DynamicChatFade()
	ElvUI_EltreumUI:StealthOptions()
	ElvUI_EltreumUI:DynamicSpellStealStyleFilter()
	if ElvUI_EltreumUI.Retail then
		ElvUI_EltreumUI:WaypointTimeToArrive()
		ElvUI_EltreumUI:SkillGlow()
		ElvUI_EltreumUI:GetSpec()
		ElvUI_EltreumUI:SkinLevelUp()
		ElvUI_EltreumUI:ArenaQuest()
		ElvUI_EltreumUI:ArenaUnitframes()
		ElvUI_EltreumUI:BattlegroundGroupUnitframes()
		ElvUI_EltreumUI:DynamicBuffs()
		if myclass == 'HUNTER' then
			ElvUI_EltreumUI:ExpandedStable()
		end
	end
	if ElvUI_EltreumUI.Classic then
		ElvUI_EltreumUI:DynamicClassicDatatext()
		ElvUI_EltreumUI:ExpandedTalents()
	end
	if ElvUI_EltreumUI.TBC then
		ElvUI_EltreumUI:DynamicClassicDatatext()
		ElvUI_EltreumUI:ExpandedTalents()
		ElvUI_EltreumUI:ArenaUnitframes()
		ElvUI_EltreumUI:BattlegroundGroupUnitframes()
		ElvUI_EltreumUI:DynamicBuffs()
	end
	if E.private["nameplates"]["enable"] == true then
		ElvUI_EltreumUI:NamePlateOptions()
		ElvUI_EltreumUI:DynamicLevelStyleFilter()
		ElvUI_EltreumUI:UpdateNPwithoutBar()
	end
	if not IsAddOnLoaded('NameplateSCT') and not IsAddOnLoaded('ElvUI_FCT') then
		SetCVar("floatingCombatTextCombatDamage", 1)
	elseif IsAddOnLoaded('NameplateSCT') or IsAddOnLoaded('ElvUI_FCT') then
		SetCVar("floatingCombatTextCombatDamage", 0)
	end
end

function ElvUI_EltreumUI:HidePopups()
	E:StaticPopup_Hide("INCOMPATIBLE_ADDON")
	E:StaticPopup_Hide('DISABLE_INCOMPATIBLE_ADDON')
	if E:IsAddOnEnabled("ElvUI_WindTools") then
		local W = unpack(WindTools)
		local function WindtoolsCompatHideWhileInstall()
			WTCompatibiltyFrame:Kill()
		end
		hooksecurefunc(W, "ConstructCompatibiltyFrame", WindtoolsCompatHideWhileInstall)
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
	ElvUI_EltreumUI:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
	ElvUI_EltreumUI:RegisterEvent('ENCOUNTER_START')
	ElvUI_EltreumUI:RegisterEvent('ENCOUNTER_END')
	ElvUI_EltreumUI:RegisterEvent('GROUP_ROSTER_UPDATE')
	ElvUI_EltreumUI:RegisterEvent('PLAYER_ENTERING_WORLD')
	ElvUI_EltreumUI:RegisterEvent('PLAYER_FLAGS_CHANGED')
	ElvUI_EltreumUI:RegisterEvent('PLAYER_LEVEL_UP')
	ElvUI_EltreumUI:RegisterEvent('PLAYER_REGEN_ENABLED')
	ElvUI_EltreumUI:RegisterEvent('PLAYER_REGEN_DISABLED')
	ElvUI_EltreumUI:RegisterEvent('UPDATE_STEALTH')
	ElvUI_EltreumUI:RegisterEvent('ZONE_CHANGED_INDOORS')
	ElvUI_EltreumUI:RegisterEvent('ZONE_CHANGED')
	ElvUI_EltreumUI:RegisterEvent('ZONE_CHANGED_NEW_AREA')

	ElvUI_EltreumUI:RegisterEvent('UNIT_AURA')
	--power bar
	ElvUI_EltreumUI:RegisterEvent('PLAYER_TARGET_CHANGED')
	ElvUI_EltreumUI:RegisterEvent('UNIT_POWER_FREQUENT') --power update real time
	ElvUI_EltreumUI:RegisterEvent('UNIT_POWER_UPDATE')  --power type changes
	ElvUI_EltreumUI:RegisterEvent("UNIT_MODEL_CHANGED")  --druid things
	--LootText things
	ElvUI_EltreumUI:RegisterEvent("CHAT_MSG_LOOT")
	ElvUI_EltreumUI:RegisterEvent("CHAT_MSG_MONEY")
	ElvUI_EltreumUI:RegisterEvent("CHAT_MSG_CURRENCY")
	ElvUI_EltreumUI:RegisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN")
	ElvUI_EltreumUI:RegisterEvent("LOOT_OPENED")
	ElvUI_EltreumUI:RegisterEvent('UI_ERROR_MESSAGE')
	--SetCVars at start
	SetCVar('nameplateOtherBottomInset', 0.02)
	SetCVar('nameplateOtherTopInset', 0.1)
	SetCVar('cameraDistanceMaxZoomFactor', 2.6)
	SetCVar('nameplateTargetRadialPosition', 1)
	--depending on game version sets cvars or register events
	if ElvUI_EltreumUI.Retail then
		ElvUI_EltreumUI:RegisterEvent('PLAYER_SPECIALIZATION_CHANGED')
		ElvUI_EltreumUI:RegisterEvent('GOSSIP_SHOW')
		SetCVar('showInGameNavigation', 1)
	end
	if ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
		SetCVar('clampTargetNameplateToScreen', 1)
	end
end

function ElvUI_EltreumUI:PLAYER_TARGET_CHANGED()
	if E.private["nameplates"]["enable"] == true then
		ElvUI_EltreumUI:NamePlateOptions()
		ElvUI_EltreumUI:NameplatePower()
	end
end

function ElvUI_EltreumUI:UNIT_MODEL_CHANGED(event,unit)
	if unit and unit ~= 'player' then
		return
	elseif unit and unit == 'player' then
		--print(event,unit)
		ElvUI_EltreumUI:NameplatePowerTextUpdate()
		ElvUI_EltreumUI:NameplatePower()
	end
end

function ElvUI_EltreumUI:UNIT_AURA(event,unit)
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
		ElvUI_EltreumUI:NameplatePowerTextUpdate()
		ElvUI_EltreumUI:NameplatePower()
	end
end

function ElvUI_EltreumUI:UNIT_POWER_UPDATE(event,unit)
	if unit and unit ~= 'player' then
		return
	elseif unit and unit == 'player' then
		--print(event,unit)
		ElvUI_EltreumUI:NameplatePowerTextUpdate()
	end
end

function ElvUI_EltreumUI:PLAYER_SPECIALIZATION_CHANGED()
	ElvUI_EltreumUI:ClassIconsOnCharacterPanel()
	if ElvUI_EltreumUI.Retail then
		ElvUI_EltreumUI:GetSpec()
		if E.private["nameplates"]["enable"] == true then
			ElvUI_EltreumUI:UpdateNPwithoutBar()
		end
	end
end

function ElvUI_EltreumUI:PLAYER_REGEN_ENABLED(event)
	ElvUI_EltreumUI:StopCombatMusic()
	ElvUI_EltreumUI:DynamicChatFade()
	--ElvUI_EltreumUI:ArenaUnitframes()
end

function ElvUI_EltreumUI:PLAYER_REGEN_DISABLED(event)
	ElvUI_EltreumUI:CombatMusic()
	ElvUI_EltreumUI:DynamicChatFade()
	ElvUI_EltreumUI:ArenaUnitframes()
end

function ElvUI_EltreumUI:PLAYER_LEVEL_UP()
	ElvUI_EltreumUI:DynamicLevelStyleFilter()
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

function ElvUI_EltreumUI:COMBAT_LOG_EVENT_UNFILTERED()
	ElvUI_EltreumUI:RaidDeath()
end

function ElvUI_EltreumUI:PLAYER_FLAGS_CHANGED()
	ElvUI_EltreumUI:AFKmusic()
end

function ElvUI_EltreumUI:GOSSIP_SHOW()
	if myclass == 'ROGUE' then
		ElvUI_EltreumUI:RogueAutoOpen()
	end
end

local function CallbackInitialize()
	ElvUI_EltreumUI:Initialize()
end
E:RegisterModule(addon, CallbackInitialize)
