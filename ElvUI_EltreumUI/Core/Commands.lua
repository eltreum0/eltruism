local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

-- Register on init
function ElvUI_EltreumUI:LoadCommands()
	self:RegisterChatCommand('eltruism', 'RunCommands')
	if E.Retail then
		if E.db.ElvUI_EltreumUI.waytext.enable then
			self:RegisterChatCommand('way', 'WaypointTexttoCoordinate')
			self:RegisterChatCommand('waypoint', 'WaypointTexttoCoordinate')
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
				if E.Retail then
					CombatText_AddMessage("|T ".. aImage ..":22:22:0:0:64:64:5:59:5:59|t ".."9.999.999 Gold", CombatText_StandardScroll, 255, 255, 255)
				elseif E.Classic or E.TBC then
					CombatText_AddMessage("|T ".. aImage ..":22:22:0:0:64:64:5:59:5:59|t ".."214.748 Gold ".."|T ".. aSilver ..":22:22:0:0:64:64:5:59:5:59|t ".."36 Silver ".."|T ".. aCopper ..":22:22:0:0:64:64:5:59:5:59|t ".."47 Copper", CombatText_StandardScroll, 255, 255, 255)
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
			ElvUI_EltreumUI:DarkMode()
		elseif E.db.ElvUI_EltreumUI.lightmode == false then
			ElvUI_EltreumUI:LightMode()
		else
			ElvUI_EltreumUI:DarkMode()
		end
	elseif message == 'background' then
		if E.db.ElvUI_EltreumUI.greybackground == true then
			ElvUI_EltreumUI:BlackBg()
		elseif E.db.ElvUI_EltreumUI.greybackground == false then
			ElvUI_EltreumUI:GreyBg()
		else
			ElvUI_EltreumUI:BlackBg()
		end
	else
		ElvUI_EltreumUI:Print("|cff82B4ffYou have entered an unknown command, here's a list of commands you can use:|r")
		print("|cff82B4ff/eltruism|r - Opens the Eltruism Installer")
		print("|cff82B4ff/eltruism install|r - Opens the Eltruism Installer")
		print("|cff82B4ff/eltruism setup|r - Opens the Eltruism Installer")
		print("|cff82B4ff/eltruism options|r - Opens the Eltruism settings")
		print("|cff82B4ff/eltruism config|r - Opens the Eltruism settings")
		print("|cff82B4ff/eltruism loot|r - Demonstrates the LootText")
		if E.Retail then
			print("|cff82B4ff/way|r - Sets a map waypoint with the supplied coordinates")
			print("|cff82B4ff/waypoint|r - In retail sets a map waypoint with the supplied coordinates")
		end
		print("|cff82B4ff/eltruism background|r - Toggles chat between grey and black background colors for ElvUI")
		print("|cff82B4ff/eltruism color|r - Toggles unitframe between light and dark modes")
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
	if IsInGroup() == false then
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
	local channel = (event == 'CHAT_MSG_GUILD' and 'GUILD') or 'PARTY'

	local function link()
		  update()
		-- Add covenant data
		local covenantID = C_Covenants.GetActiveCovenantID()
		local covenantData = covenantID and C_Covenants.GetCovenantData(covenantID)
		local covenantName = ''
		if covenantData then
		  covenantName = covenantData.name
		end
		for _, link in next, keys do
			message = ""..link
			SendChatMessage(message..(covenantName and (' ('..covenantName..')') or ''), channel)
		end
	end

	if event == 'BAG_UPDATE_DELAYED' then
		update()
	elseif message and ( strlower(message) == '!keys' or strlower(message) == '!key') then
		local channel = (event == 'CHAT_MSG_GUILD' and 'GUILD') or 'PARTY'
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
	ElvUI_EltreumUI:Keys(event, message)
end)
