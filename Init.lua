local E, L, V, P, G = unpack(ElvUI)
local EP = LibStub('LibElvUIPlugin-1.0')
local addon, Engine = ...
local _G = _G
local ElvUI_EltreumUI = E:NewModule(addon, 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0', 'AceConsole-3.0')

-- This whole plugin uses LuckyoneUI as a base, full credits to him for it and allowing its use!
Engine[1] = ElvUI_EltreumUI
Engine[2] = E -- ElvUI Engine
Engine[3] = L -- ElvUI Locales
Engine[4] = V -- ElvUI PrivateDB
Engine[5] = P -- ElvUI ProfileDB
Engine[6] = G -- ElvUI GlobalDB
_G[addon] = Engine

-- Constants
ElvUI_EltreumUI.Version = GetAddOnMetadata(addon, 'Version')
ElvUI_EltreumUI.CreditsList = {}
ElvUI_EltreumUI.Config = {}
ElvUI_EltreumUI.Name = '|cff82B4ffEltruism|r'

-- Check WoW Project ID
ElvUI_EltreumUI.Retail = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
ElvUI_EltreumUI.Classic = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC
ElvUI_EltreumUI.TBC = WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC

function ElvUI_EltreumUI:PLAYER_ENTERING_WORLD()
	ElvUI_EltreumUI:NamePlateOptions()
	ElvUI_EltreumUI:LoadCommands()
	ElvUI_EltreumUI:FriendlyNameplates()
	ElvUI_EltreumUI:AFKmusic()
	if ElvUI_EltreumUI.Retail then
		ElvUI_EltreumUI:WaypointTimeToArrive()
		ElvUI_EltreumUI:SkillGlow()
	end
	ElvUI_EltreumUI:LootText()
	ElvUI_EltreumUI:OldVersionCheck()
	ElvUI_EltreumUI:NewVersionCheck()
	ElvUI_EltreumUI:CastCursor()
	ElvUI_EltreumUI:CurrentTypeofCursor()
end

function ElvUI_EltreumUI:Initialize()
	if E.private.install_complete and E.private.ElvUI_EltreumUI.install_version == nil then
		E:GetModule('PluginInstaller'):Queue(ElvUI_EltreumUI.InstallerData)
	end
	EP:RegisterPlugin(addon, ElvUI_EltreumUI.Configtable)
	--Register Events
	ElvUI_EltreumUI:RegisterEvent('PLAYER_ENTERING_WORLD')
	ElvUI_EltreumUI:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
	ElvUI_EltreumUI:RegisterEvent('UPDATE_STEALTH')
	ElvUI_EltreumUI:RegisterEvent('PLAYER_FLAGS_CHANGED')
	ElvUI_EltreumUI:RegisterEvent('GROUP_ROSTER_UPDATE')
	ElvUI_EltreumUI:RegisterEvent('ENCOUNTER_START')
	ElvUI_EltreumUI:RegisterEvent('PLAYER_REGEN_ENABLED')
    ElvUI_EltreumUI:RegisterEvent('PLAYER_REGEN_DISABLED')
	if ElvUI_EltreumUI.Retail then
		ElvUI_EltreumUI:RegisterEvent('SUPER_TRACKING_CHANGED')
		ElvUI_EltreumUI:RegisterEvent('NAVIGATION_FRAME_CREATED')
		ElvUI_EltreumUI:RegisterEvent('NAVIGATION_FRAME_DESTROYED')
	end
	ElvUI_EltreumUI:RegisterEvent('ZONE_CHANGED_INDOORS')
	ElvUI_EltreumUI:RegisterEvent('ZONE_CHANGED')
	ElvUI_EltreumUI:RegisterEvent('ZONE_CHANGED_NEW_AREA')
	ElvUI_EltreumUI:RegisterEvent('PLAYER_TARGET_CHANGED')
	ElvUI_EltreumUI:RegisterEvent('GROUP_ROSTER_UPDATE')
	--SetCVars at start
	SetCVar('nameplateOtherBottomInset', 0.02)
	SetCVar('nameplateOtherTopInset', 0.1)
	SetCVar('cameraDistanceMaxZoomFactor', 2.6)
	SetCVar('nameplateTargetRadialPosition', 1)

	if ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
		SetCVar("clampTargetNameplateToScreen", 1)
		SetCVar("nameplateOtherBottomInset", 0.01)
	end

	-- Color level up display and boss banner by Aftermathh
	if ElvUI_EltreumUI.Retail then
		local R, G, B = unpack(E.media.rgbvaluecolor)
		local LevelUpDisplay = _G.LevelUpDisplay
		local BossBanner = _G.BossBanner
		if LevelUpDisplay then
			_G.LevelUpDisplayGLine:Kill()
			_G.LevelUpDisplayGLine2:Kill()
			LevelUpDisplay.StatusLine = CreateFrame("StatusBar", nil, LevelUpDisplay)
			LevelUpDisplay.StatusLine:SetSize(418, 2)
			LevelUpDisplay.StatusLine:SetPoint("TOP", LevelUpDisplay, 0, -5)
			LevelUpDisplay.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
			LevelUpDisplay.StatusLine:SetStatusBarColor(R, G, B, 0.7)
			LevelUpDisplay.StatusLine2 = CreateFrame("StatusBar", nil, LevelUpDisplay)
			LevelUpDisplay.StatusLine2:SetSize(418, 2)
			LevelUpDisplay.StatusLine2:SetPoint("BOTTOM", LevelUpDisplay, 0, -3)
			LevelUpDisplay.StatusLine2:SetStatusBarTexture(E.Media.Textures.Highlight)
			LevelUpDisplay.StatusLine2:SetStatusBarColor(R, G, B, 0.7)
			_G.LevelUpDisplay.challengeModeBits:Kill()
    		_G.LevelUpDisplay.scenarioBits:Kill()
    		_G.LevelUpDisplay.scenarioFiligree:Kill()
    		_G.LevelUpDisplay.SpellBucketFrame:Kill()
			--/script LevelUpDisplay:Show()
		end
		if BossBanner then
			local StatusLineTop = CreateFrame("StatusBar", nil, _G.BossBanner)
			StatusLineTop:SetSize(418, 2)
			--(point, relativeTo, relativePoint, offset_x, offset_y)
			StatusLineTop:SetPoint("TOP", _G.BossBanner, 0, -80)
			StatusLineTop:SetStatusBarTexture(E.Media.Textures.Highlight)
			StatusLineTop:SetStatusBarColor(R, G, B, 0.7)
			local StatusLineBottom = CreateFrame("StatusBar", nil, _G.BossBanner)
			StatusLineBottom:SetSize(418, 2)
			StatusLineBottom:SetPoint("BOTTOM", _G.BossBanner, 0, -20)
			StatusLineBottom:SetStatusBarTexture(E.Media.Textures.Highlight)
			StatusLineBottom:SetStatusBarColor(R, G, B, 0.7)
			_G.BossBanner.BannerTop:Kill()
			_G.BossBanner.BannerTopGlow:Kill()
			_G.BossBanner.BannerBottom:Kill()
			_G.BossBanner.BannerBottomGlow:Kill()
			_G.BossBanner.BannerMiddle:Kill()
			--_G.BossBanner.BannerMiddle:SetTexture(E.Media.Textures.Highlight)
			--_G.BossBanner.BannerMiddle:SetColorTexture(0, 0, 0, 0.20)
			_G.BossBanner.BannerMiddleGlow:Kill()
			_G.BossBanner.LootCircle:Kill()
			_G.BossBanner.SkullCircle:Kill()
			_G.BossBanner.RightFillagree:Kill()
			_G.BossBanner.LeftFillagree:Kill()
			_G.BossBanner.BottomFillagree:Kill()
			_G.BossBanner.SkullSpikes:Kill()
			--/script BossBanner:Show()
		end
	end
end

function ElvUI_EltreumUI:PLAYER_REGEN_ENABLED()
	ElvUI_EltreumUI:StopCombatMusic()
end

function ElvUI_EltreumUI:PLAYER_REGEN_DISABLED()
	ElvUI_EltreumUI:CombatMusic()
end

function ElvUI_EltreumUI:ZONE_CHANGED()
	ElvUI_EltreumUI:FriendlyNameplates()
	if ElvUI_EltreumUI.Retail then
		ElvUI_EltreumUI:ArenaQuest()
	end
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
	ElvUI_EltreumUI:GroupRoster()
end


function ElvUI_EltreumUI:PLAYER_FLAGS_CHANGED()
	ElvUI_EltreumUI:AFKmusic()
end

function ElvUI_EltreumUI:PLAYER_TARGET_CHANGED()
	ElvUI_EltreumUI:NamePlateOptions()
end

local function CallbackInitialize()
	ElvUI_EltreumUI:Initialize()
end
E:RegisterModule(addon, CallbackInitialize)
