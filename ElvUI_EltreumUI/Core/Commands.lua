local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local string = _G.string
local tonumber = _G.tonumber
local C_Map = _G.C_Map
local table = _G.table
local UiMapPoint = _G.UiMapPoint
local GetCoinIcon = _G.GetCoinIcon
--local CombatText_AddMessage = _G.CombatText_AddMessage
local CombatText_StandardScroll = _G.CombatText_StandardScroll

-- Register on init
function ElvUI_EltreumUI:LoadCommands()
	self:RegisterChatCommand('eltruism', 'RunCommands')
	if ElvUI_EltreumUI.Retail then
		if E.db.ElvUI_EltreumUI.waytext.enable then
			self:RegisterChatCommand('way', 'WaypointTexttoCoordinate')
			self:RegisterChatCommand('waypoint', 'WaypointTexttoCoordinate')
		end
	end
end

function ElvUI_EltreumUI:RunCommands(message)
	if message == '' or message == 'install' or message == 'setup' then
		E:GetModule('PluginInstaller'):Queue(ElvUI_EltreumUI.InstallerData)
	elseif message == 'loot' then
		if E.db.ElvUI_EltreumUI.loottext.enable then
				local aImage = GetCoinIcon(9999999999)
				if ElvUI_EltreumUI.Retail then
					CombatText_AddMessage("|T ".. aImage ..":22:22:-11:-11:64:64:5:59:5:59|t  ".."9.999.999 Gold", CombatText_StandardScroll, 255, 255, 255)
				elseif ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
					CombatText_AddMessage("|T ".. aImage ..":22:22:-11:-11:64:64:5:59:5:59|t|t  ".."999.999 Gold", CombatText_StandardScroll, 255, 255, 255)
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
			ElvUI_EltreumUI:Print("Chat set to dark mode, please reload")
			E:StaticPopup_Show('CONFIG_RL')
		elseif E.db.chat.panelBackdrop == "SHOWBOTH" then
			ElvUI_EltreumUI:TransparentChat()
			ElvUI_EltreumUI:Print("Chat set to transparent mode, please reload")
			E:StaticPopup_Show('CONFIG_RL')
		else
			ElvUI_EltreumUI:TransparentChat()
			ElvUI_EltreumUI:Print("Chat set to transparent mode, please reload")
			E:StaticPopup_Show('CONFIG_RL')
		end
	elseif message == 'color' then
		if E.db.ElvUI_EltreumUI.lightmode == true then
			ElvUI_EltreumUI:DarkMode()
			ElvUI_EltreumUI:Print("Unitframes set to dark mode, please reload")
			E:StaticPopup_Show('CONFIG_RL')
		elseif E.db.ElvUI_EltreumUI.lightmode == false then
			ElvUI_EltreumUI:LightMode()
			ElvUI_EltreumUI:Print("Unitframes set to light mode, please reload")
			E:StaticPopup_Show('CONFIG_RL')
		else
			ElvUI_EltreumUI:DarkMode()
			ElvUI_EltreumUI:Print("Unitframes set to dark mode, please reload")
			E:StaticPopup_Show('CONFIG_RL')
		end
	else
		ElvUI_EltreumUI:Print("|cff82B4ffYou have entered an unknown command, here's a list of commands you can use:|r")
		print("|cff82B4ff/eltruism|r - Opens the Eltruism Installer")
		print("|cff82B4ff/eltruism install|r - Opens the Eltruism Installer")
		print("|cff82B4ff/eltruism setup|r - Opens the Eltruism Installer")
		print("|cff82B4ff/eltruism options|r - Opens the Eltruism settings")
		print("|cff82B4ff/eltruism config|r - Opens the Eltruism settings")
		print("|cff82B4ff/eltruism loot|r - Demonstrates the LootText")
		if ElvUI_EltreumUI.Retail then
			print("|cff82B4ff/way|r - Sets a map waypoint with the supplied coordinates")
			print("|cff82B4ff/waypoint|r - In retail sets a map waypoint with the supplied coordinates")
		end
		print("|cff82B4ff/eltruism color|r - Toggles unitframe between light and dark modes")
		print("|cff82B4ff/eltruism chat|r - Toggles chat between dark and transparent modes")
	end
end

-- translate text to coordinates that are then put into the Waypoint system, inspired by the Wayfinder weakaura by Khanibrawl
function ElvUI_EltreumUI:WaypointTexttoCoordinate(message)
	-- most of this was done with the help of posts on stack overflow and lua-users.org
	if ElvUI_EltreumUI.Retail then
		if E.db.ElvUI_EltreumUI.waytext.enable then
			-- translate the message into numbers
			local translatemsg = message:gsub("(%d)[%.,] (%d)", "%1 %2"):gsub("(%d)"..(tonumber("1.1") and "," or ".").."(%d)", "%1"..(tonumber("1.1") and "." or ",").."%2")
			local coords = {}
			--put the numbers into the table
			for pattern in translatemsg:gmatch("%S+") do
				table.insert(coords, pattern)
			end
			local canSet = C_Map.CanSetUserWaypointOnMap(C_Map.GetBestMapForUnit("player"))
			if canSet == false then
				ElvUI_EltreumUI:Print(L["Area does not support waypoints"])
			else
				--core of the function
				if #coords < 2 then
					ElvUI_EltreumUI:Print(L["Unsupported format"])
				end
				if #coords >=2 then
					local x, y = 0,0
					-- setup x coordinate
					if string.match(coords[1], "%d+") then
						if string.len(coords[1]) == 3 then
							x = (tonumber(coords[1])/1000)
						elseif string.len(coords[1]) == 2 then
							x = (tonumber(coords[1])/100)
						elseif string.len(coords[1]) == 4 then
							x = (tonumber(coords[1])/100)
						elseif string.len(coords[1]) == 5 then
							x = (tonumber(coords[1])/100)
						elseif string.len(coords[1]) > 5 then
							coords[1] = "a"
						end
					end
					-- setup y coordinate
					if string.match(coords[2], "%d+") then
						if string.len(coords[2]) == 3 then
							y = (tonumber(coords[2])/1000)
						elseif string.len(coords[2]) == 2 then
							y = (tonumber(coords[2])/100)
						elseif string.len(coords[2]) == 4 then
							y = (tonumber(coords[2])/100)
						elseif string.len(coords[2]) == 5 then
							y = (tonumber(coords[2])/100)
						elseif string.len(coords[2]) > 5 then
							coords[1] = "a"
						end
					end
					-- check if its numbers set the waypoint and print it otherwise error message
					if string.match(coords[1], "%a+") or string.match(coords[2], "%a+") then
						ElvUI_EltreumUI:Print(L["Unsupported format or Area does not support waypoints"])
					elseif x == nil or y == nil then
						ElvUI_EltreumUI:Print(L["Area does not support waypoints"])
					else
						--print ("X: "..x.." and Y: "..y)
						local xlength, ylength
						if x > 0 and x < 1 then
							xlength = true
						else
							xlength = false
						end
						if y > 0 and y < 1 then
							ylength = true
						else
							ylength = false
						end
						if xlength == false or ylength == false then
							ElvUI_EltreumUI:Print(L["Unsupported format or Area does not support waypoints"])
						else
							C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(C_Map.GetBestMapForUnit('player'),x,y))
							if C_Map.GetBestMapForUnit('player') == nil then
								ElvUI_EltreumUI:Print(L["Area does not support waypoints"])
							else
								ElvUI_EltreumUI:Print(C_Map.GetUserWaypointHyperlink())
							end
						end
					end
				end
			end
		end
	end
end
