local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local LoadAddOn = LoadAddOn

function ElvUI_EltreumUI:RerunInstaller()
	local List = _G.SlashCmdList
	if not List.REINSTALLER then
		_G.SLASH_REINSTALLER1 = '/eltruism'
		List.REINSTALLER = function()
			E:GetModule('PluginInstaller'):Queue(ElvUI_EltreumUI.InstallerData)
		end
	end
end

-- Register on init
function ElvUI_EltreumUI:LoadCommands()
	ElvUI_EltreumUI:RerunInstaller()
end
