local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local LoadAddOn = LoadAddOn


-- Register on init
function ElvUI_EltreumUI:LoadCommands()
	self:RegisterChatCommand('eltruism', 'RunCommands')
end

function ElvUI_EltreumUI:RunCommands(message)
	if message == '' then
		E:GetModule('PluginInstaller'):Queue(ElvUI_EltreumUI.InstallerData)
	elseif message == 'loot' then
		if E.private.ElvUI_EltreumUI.loottext.enable then
				local aImage = GetCoinIcon(9999999999);
				CombatText_AddMessage("|T ".. aImage ..":22:22:-11:-11|t  ".."9.999.999 Gold", CombatText_StandardScroll, 255, 255, 255)
		else
				CombatText_AddMessage("|T ".. 237555 ..":22:22:-11:-11|t  ".."Eltruism Loot is currently disabled!", CombatText_StandardScroll, 255, 255, 255)
		end
	end
end





