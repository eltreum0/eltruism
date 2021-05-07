local _G = _G
local unpack = _G.unpack
local select = _G.select
local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local LoadAddOn = _G.LoadAddOn
local GetCoinIcon = _G.GetCoinIcon
local CombatText_AddMessage = _G.CombatText_AddMessage
local CombatText_StandardScroll = _G.CombatText_StandardScroll

-- Register on init
function ElvUI_EltreumUI:LoadCommands()
	self:RegisterChatCommand('eltruism', 'RunCommands')
end

function ElvUI_EltreumUI:RunCommands(message)
	if message == '' or message == 'install' then
		E:GetModule('PluginInstaller'):Queue(ElvUI_EltreumUI.InstallerData)
	elseif message == 'loot' then
		if E.private.ElvUI_EltreumUI.loottext.enable then
				local aImage = GetCoinIcon(9999999999);
				CombatText_AddMessage("|T ".. aImage ..":22:22:-11:-11|t  ".."9.999.999 Gold", CombatText_StandardScroll, 255, 255, 255)
		else
				CombatText_AddMessage("|T ".. 237555 ..":22:22:-11:-11|t  ".."Eltruism Loot is currently disabled!", CombatText_StandardScroll, 255, 255, 255)
		end
	elseif message == 'config' or message == 'setup' then
		E:ToggleOptionsUI()
		E.Libs.AceConfigDialog:SelectGroup('ElvUI', 'ElvUI_EltreumUI')
	end
end





