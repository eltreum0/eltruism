local E, L, V, P, G = unpack(ElvUI)
local EP = LibStub('LibElvUIPlugin-1.0')
local addon, Engine = ...
local _G = _G
local ElvUI_EltreumUI = E:NewModule(addon, 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0')

-- This whole plugin uses LuckyoneUI as a base, full credits to him for it and allowing its use!
Engine[1] = ElvUI_EltreumUI
Engine[2] = E
Engine[3] = L
Engine[4] = V
Engine[5] = P
Engine[6] = G
_G[addon] = Engine

ElvUI_EltreumUI.Version = GetAddOnMetadata(addon, 'Version')
ElvUI_EltreumUI.CreditsList = {}
ElvUI_EltreumUI.Config = {}
ElvUI_EltreumUI.Name = '|cff82B4ffEltruism|r'

function ElvUI_EltreumUI:PLAYER_ENTERING_WORLD()
	ElvUI_EltreumUI:NamePlateOptions()
	ElvUI_EltreumUI:LoadCommands()
	ElvUI_EltreumUI:SkillGlow()
	ElvUI_EltreumUI:FriendlyNameplates()
	ElvUI_EltreumUI:AFKmusic()
	ElvUI_EltreumUI:WaypointTimeToArrive()
end

function ElvUI_EltreumUI:Initialize()
	if E.private.install_complete and E.private.ElvUI_EltreumUI.install_version == nil then
		E:GetModule('PluginInstaller'):Queue(ElvUI_EltreumUI.InstallerData)
	end
	EP:RegisterPlugin(addon, ElvUI_EltreumUI.Configtable)
	ElvUI_EltreumUI:RegisterEvent('PLAYER_ENTERING_WORLD')
	ElvUI_EltreumUI:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
	ElvUI_EltreumUI:RegisterEvent('UPDATE_STEALTH')
	ElvUI_EltreumUI:RegisterEvent('PLAYER_FLAGS_CHANGED')
	ElvUI_EltreumUI:RegisterEvent('GROUP_ROSTER_UPDATE')
	ElvUI_EltreumUI:RegisterEvent('ENCOUNTER_START')
	ElvUI_EltreumUI:RegisterEvent('SUPER_TRACKING_CHANGED')
	ElvUI_EltreumUI:RegisterEvent('NAVIGATION_FRAME_CREATED')
	ElvUI_EltreumUI:RegisterEvent('NAVIGATION_FRAME_DESTROYED')
	--ElvUI_EltreumUI:RegisterEvent('PLAYER_REGEN_DISABLED')
	SetCVar('nameplateOtherBottomInset', 0.02)
	SetCVar('nameplateOtherTopInset', 0.1)
	SetCVar('cameraDistanceMaxZoomFactor', 2.6)
	SetCVar('nameplateTargetRadialPosition', 1)
end

function ElvUI_EltreumUI:ENCOUNTER_START()
	ElvUI_EltreumUI:QuestEncounter()
end

function ElvUI_EltreumUI:PLAYER_REGEN_DISABLED()
	ElvUI_EltreumUI:QuestEncounter()
end

function ElvUI_EltreumUI:SUPER_TRACKING_CHANGED()
	ElvUI_EltreumUI:WaypointTimeToArrive()
end
function ElvUI_EltreumUI:NAVIGATION_FRAME_CREATED()
	ElvUI_EltreumUI:WaypointTimeToArrive()
end
function ElvUI_EltreumUI:NAVIGATION_FRAME_DESTROYED()
	ElvUI_EltreumUI:WaypointTimeToArrive()
end

function ElvUI_EltreumUI:UPDATE_STEALTH()
	ElvUI_EltreumUI:StealthOptions()
end

function ElvUI_EltreumUI:COMBAT_LOG_EVENT_UNFILTERED()
	ElvUI_EltreumUI:RaidDeath()
end

function ElvUI_EltreumUI:GROUP_ROSTER_UPDATE()
	ElvUI_EltreumUI:RaidDeath()
end

function ElvUI_EltreumUI:PLAYER_FLAGS_CHANGED()
	ElvUI_EltreumUI:AFKmusic()
end

local function CallbackInitialize()
	ElvUI_EltreumUI:Initialize()
end
E:RegisterModule(addon, CallbackInitialize)
