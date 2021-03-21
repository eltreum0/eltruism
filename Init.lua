local E, L, V, P, G = unpack(ElvUI)
local EP = LibStub('LibElvUIPlugin-1.0')
local addon, Engine = ...

local _G = _G

local ElvUI_EltreumUI = E:NewModule(addon, 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0');

-- This whole plugin uses LuckyoneUI as a base, full credits to him for it!

Engine[1] = ElvUI_EltreumUI
Engine[2] = E
Engine[3] = L
Engine[4] = V
Engine[5] = P
Engine[6] = G
_G[addon] = Engine;

ElvUI_EltreumUI.Version = GetAddOnMetadata(addon, 'Version')
ElvUI_EltreumUI.CreditsList = {}
ElvUI_EltreumUI.Config = {}
ElvUI_EltreumUI.Name = '|c4682B4ffEltruism|r'

function ElvUI_EltreumUI:PLAYER_ENTERING_WORLD()
	ElvUI_EltreumUI:NamePlateOptions()
	ElvUI_EltreumUI:LoadCommands()
end


function ElvUI_EltreumUI:Initialize()
	if E.private.install_complete and E.private.ElvUI_EltreumUI.install_version == nil then
		E:GetModule('PluginInstaller'):Queue(ElvUI_EltreumUI.InstallerData)
	end
		
	EP:RegisterPlugin(addon, ElvUI_EltreumUI.Configtable)
	ElvUI_EltreumUI:RegisterEvent('PLAYER_ENTERING_WORLD', 'UPDATE_STEALTH') 
end


function ElvUI_EltreumUI:UPDATE_STEALTH()
    ElvUI_EltreumUI:StealthOptions()
end

--function ElvUI_EltreumUI:UNIT_DIED()
--    ElvUI_EltreumUI:Bruh()
--end






local function CallbackInitialize()
	ElvUI_EltreumUI:Initialize()
end

E:RegisterModule(addon, CallbackInitialize)
