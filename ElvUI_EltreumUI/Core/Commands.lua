local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local IsAddOnLoaded = _G.IsAddOnLoaded
local CreateFrame = _G.CreateFrame
local GetCoinIcon = _G.GetCoinIcon
local CombatText_AddMessage = _G.CombatText_AddMessage
local CombatText_StandardScroll = _G.CombatText_StandardScroll
local print = _G.print
local strlower = strlower
local GetContainerNumSlots = GetContainerNumSlots
local select = select
local GetContainerItemInfo = GetContainerItemInfo
local C_Covenants = _G.C_Covenants
local next = next
local SendChatMessage = SendChatMessage
local UseContainerItem = UseContainerItem

-- Register on init
function ElvUI_EltreumUI:LoadCommands()
	self:RegisterChatCommand('eltruism', 'RunCommands')
	if E.Retail then
		if E.db.ElvUI_EltreumUI.waytext.enable then
			if not IsAddOnLoaded("TomTom") then
				self:RegisterChatCommand('way', 'WaypointTexttoCoordinate')
				self:RegisterChatCommand('waypoint', 'WaypointTexttoCoordinate')
			else
				self:RegisterChatCommand('eway', 'WaypointTexttoCoordinate')
				self:RegisterChatCommand('ewaypoint', 'WaypointTexttoCoordinate')
				ElvUI_EltreumUI:Print("TomTom detected, commands moved to /eway and /ewaypoint")
			end
		end
		if E.db.ElvUI_EltreumUI.otherstuff.mpluskeys then
			self:RegisterChatCommand('!key', 'Keys')
			self:RegisterChatCommand('!keys', 'Keys')
		end
	end
end

function ElvUI_EltreumUI:RunCommands(message)
	if message == '' or message == 'install' or message == 'setup' then
		E:GetModule('PluginInstaller'):Queue(ElvUI_EltreumUI.InstallerData)
	elseif message == 'loot' then
		if E.db.ElvUI_EltreumUI.loottext.enable then
			local aImage = GetCoinIcon(9999999999)
			local aSilver = GetCoinIcon(100)
			local aCopper = GetCoinIcon(1)
			--RaidNotice_AddMessage(RaidWarningFrame, "Raid Boss Emote Frame Raid Warning Test Message", ChatTypeInfo["RAID_WARNING"], 10)
			if E.Retail then
				CombatText_AddMessage("|T ".. aImage ..":22:22:0:0:64:64:5:59:5:59|t ".."9.999.999 Gold", CombatText_StandardScroll, 255, 255, 255)
			elseif E.Classic or E.Wrath or E.TBC then
				CombatText_AddMessage("|T ".. aImage ..":22:22:0:0:64:64:5:59:5:59|t ".."214.748 Gold |T ".. aSilver ..":22:22:0:0:64:64:5:59:5:59|t ".."36 Silver |T ".. aCopper ..":22:22:0:0:64:64:5:59:5:59|t ".."47 Copper", CombatText_StandardScroll, 255, 255, 255)
			end
		else
			CombatText_AddMessage("|T ".. 136176 ..":22:22:-11:-11:64:64:5:59:5:59|t|t  ".."Eltruism Loot is currently disabled!", CombatText_StandardScroll, 255, 255, 255)
		end
	elseif message == 'config' or message == 'options' then
		E:ToggleOptionsUI()
		E.Libs.AceConfigDialog:SelectGroup('ElvUI', 'ElvUI_EltreumUI')
	elseif message == 'dev' then
		if E.db.ElvUI_EltreumUI.dev == false then
			E.db.ElvUI_EltreumUI.dev = true
			ElvUI_EltreumUI:Print("Development Tools Enabled, please reload")
			E:StaticPopup_Show('CONFIG_RL')
		elseif E.db.ElvUI_EltreumUI.dev == true then
			E.db.ElvUI_EltreumUI.dev = false
			ElvUI_EltreumUI:Print("Development Tools Disabled, please reload")
			E:StaticPopup_Show('CONFIG_RL')
		end
	elseif message == 'chat' then
		if E.db.chat.panelBackdrop == "HIDEBOTH" then
			ElvUI_EltreumUI:DarkChat()
		elseif E.db.chat.panelBackdrop == "SHOWBOTH" then
			ElvUI_EltreumUI:TransparentChat()
		else
			ElvUI_EltreumUI:TransparentChat()
		end
	elseif message == 'color' then
		if E.db.ElvUI_EltreumUI.lightmode == true then
			ElvUI_EltreumUI:DarkMode() E:StaticPopup_Show('CONFIG_RL')
		elseif E.db.ElvUI_EltreumUI.lightmode == false then
			ElvUI_EltreumUI:LightMode() E:StaticPopup_Show('CONFIG_RL')
		else
			ElvUI_EltreumUI:DarkMode() E:StaticPopup_Show('CONFIG_RL')
		end
	elseif message == 'gradient' then
		if E.db.ElvUI_EltreumUI.gradientmode.enable == false then
			ElvUI_EltreumUI:GradientMode() E:StaticPopup_Show('CONFIG_RL')
		else
			E.db.ElvUI_EltreumUI.gradientmode.enable = true E:StaticPopup_Show('CONFIG_RL')
			ElvUI_EltreumUI:Print("Gradient Disabled, please reload")
		end
	elseif message == 'background' then
		if E.db.ElvUI_EltreumUI.greybackground == true then
			ElvUI_EltreumUI:BlackBg()
		elseif E.db.ElvUI_EltreumUI.greybackground == false then
			ElvUI_EltreumUI:GreyBg()
		else
			ElvUI_EltreumUI:GreyBg()
		end
	else
		ElvUI_EltreumUI:Print("|cff82B4ffYou have entered an unknown command, here's a list of commands you can use:|r")
		print("|cff82B4ff/eltruism|r - Opens the Eltruism Installer")
		print("|cff82B4ff/eltruism install|r - Opens the Eltruism Installer")
		print("|cff82B4ff/eltruism setup/options/config|r - Opens the Eltruism Installer")
		print("|cff82B4ff/eltruism loot|r - Demonstrates the LootText")
		if E.Retail then
			if not IsAddOnLoaded("TomTom") then
				print("|cff82B4ff/way and /waypoint|r - Sets a map waypoint with the supplied coordinates")
			else
				print("|cff82B4ff/eway and /ewaypoint|r - Sets a map waypoint with the supplied coordinates")
			end
			print("|cff82B4ff/!key and /!keys|r - Links your keystone and covenant in chat")
		end
		print("|cff82B4ff/eltruism background|r - Toggles chat between grey and black background colors for ElvUI")
		print("|cff82B4ff/eltruism color|r - Toggles unitframe between light and dark modes")
		print("|cff82B4ff/eltruism gradient|r - Activates gradient mode")
		print("|cff82B4ff/eltruism chat|r - Toggles chat between dark and transparent modes")
	end
end

--Adapted from Luckyone's +keys as requested by khornan

-- keystone id tables and keys table with stored keys
local ids = {
	[138019] = true, -- Legion
	[158923] = true, -- BfA
	[180653] = true, -- Shadowlands
	[151086] = true, -- Tournament
	[187786] = true, -- Legion Timewalking
}
local keys = {
}

function ElvUI_EltreumUI:Keys(event,message)
	if E.Wrath or E.TBC or E.Classic then
		return
	elseif message == nil then
		return
	elseif message:match("!keys") == false or message:match("!key") == false then
		return
	end

	local function update()
		for bag = 0, NUM_BAG_SLOTS do
			local bagSlots = GetContainerNumSlots(bag)
			for slot = 1, bagSlots do
				local itemLink, _, _, itemID = select(7, GetContainerItemInfo(bag, slot))
				if ids[itemID] then
					keys[itemID] = itemLink
				end
			end
		end
	end
	local channel = (event == 'CHAT_MSG_GUILD' and 'GUILD') or (event == 'CHAT_MSG_PARTY_LEADER' and 'PARTY') or (event == 'CHAT_MSG_PARTY' and 'PARTY')

	local function link()
		update()
		-- Add covenant data
		local covenantID = C_Covenants.GetActiveCovenantID()
		local covenantData = covenantID and C_Covenants.GetCovenantData(covenantID)
		local covenantName = ''
		if covenantData then
		covenantName = covenantData.name
		end
		if E.db.ElvUI_EltreumUI.otherstuff.mpluskeys then
			for _, link in next, keys do
				message = ""..link
				SendChatMessage(message..(covenantName and (' ('..covenantName..')') or ''), channel)
			end
		end
	end

	if event == 'BAG_UPDATE_DELAYED' then
		update()
	elseif message and ( strlower(message) == '!keys' or strlower(message) == '!key') then
		local channel = (event == 'CHAT_MSG_GUILD' and 'GUILD') or (event == 'CHAT_MSG_PARTY_LEADER' and 'PARTY') or (event == 'CHAT_MSG_PARTY' and 'PARTY')
		link(channel)
	end

end

--frame to update using events
local keyframe = CreateFrame("FRAME")
keyframe:RegisterEvent("BAG_UPDATE_DELAYED")
keyframe:RegisterEvent("CHAT_MSG_GUILD")
keyframe:RegisterEvent("CHAT_MSG_PARTY_LEADER")
keyframe:RegisterEvent("CHAT_MSG_PARTY")
keyframe:SetScript("OnEvent", function(_,event, message)
	if E.Retail and E.db.ElvUI_EltreumUI.otherstuff.mpluskeys then
		ElvUI_EltreumUI:Keys(event, message)
	else
		keyframe:UnregisterAllEvents()
	end
end)

local keystone = CreateFrame("FRAME")
keystone:RegisterEvent("ADDON_LOADED")
keystone:SetScript("OnEvent", function(_,_,addon)
	if addon == "Blizzard_ChallengesUI" and E.db.ElvUI_EltreumUI.otherstuff.mpluskeys then
		keystone:UnregisterAllEvents()
		if _G.ChallengesKeystoneFrame then
			_G.ChallengesKeystoneFrame:SetScript("OnShow", function()
				for bag = 0, NUM_BAG_SLOTS do
					local bagSlots = GetContainerNumSlots(bag)
					for slot = 1, bagSlots do
						local _, _, _, itemID = select(7, GetContainerItemInfo(bag, slot))
						if ids[itemID] then
							UseContainerItem(bag, slot)
						end
					end
				end
			end)
		end
	end
end)
