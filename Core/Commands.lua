local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

local _G = _G
local string = _G.string
local tonumber = _G.tonumber
local C_Map = _G.C_Map
local print = _G.print
local table = _G.table
local UiMapPoint = _G.UiMapPoint

local LoadAddOn = _G.LoadAddOn
local GetCoinIcon = _G.GetCoinIcon
local CombatText_AddMessage = _G.CombatText_AddMessage
local CombatText_StandardScroll = _G.CombatText_StandardScroll

-- Register on init
function ElvUI_EltreumUI:LoadCommands()
	self:RegisterChatCommand('eltruism', 'RunCommands')
	if ElvUI_EltreumUI.Retail then
		if E.private.ElvUI_EltreumUI.waytext.enable then
			self:RegisterChatCommand('way', 'WaypointTexttoCoordinate')
	    	self:RegisterChatCommand('waypoint', 'WaypointTexttoCoordinate')
    	end
    end
end

function ElvUI_EltreumUI:RunCommands(message)
	if message == '' or message == 'install' or message == 'setup' then
		E:GetModule('PluginInstaller'):Queue(ElvUI_EltreumUI.InstallerData)
	elseif message == 'loot' then
		if E.private.ElvUI_EltreumUI.loottext.enable then
				local aImage = GetCoinIcon(9999999999)
				if ElvUI_EltreumUI.Retail then
					CombatText_AddMessage("|T ".. aImage ..":22:22:-11:-11|t  ".."9.999.999 Gold", CombatText_StandardScroll, 255, 255, 255)
				elseif ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
					CombatText_AddMessage("|T ".. aImage ..":22:22:-11:-11|t  ".."999.999 Gold", CombatText_StandardScroll, 255, 255, 255)
				end

		else
				CombatText_AddMessage("|T ".. 237555 ..":22:22:-11:-11|t  ".."Eltruism Loot is currently disabled!", CombatText_StandardScroll, 255, 255, 255)
		end
	elseif message == 'config' or message == 'options' then
		E:ToggleOptionsUI()
		E.Libs.AceConfigDialog:SelectGroup('ElvUI', 'ElvUI_EltreumUI')
	end
end

-- translate text to coordinates that are then put into the Waypoint system, inspired by the Wayfinder weakaura by Khanibrawl
function ElvUI_EltreumUI:WaypointTexttoCoordinate(message)
	-- still learning gsub and string matching, most of this was done with the help of stack overflow and lua-users.org
	-- need to figure out how to prevent errors when not using the patterns
	if ElvUI_EltreumUI.Retail then
		if E.private.ElvUI_EltreumUI.waytext.enable then
			-- translate the message into numbers
		  	local translatemsg = message:gsub("(%d)[%.,] (%d)", "%1 %2"):gsub("(%d)" .. (tonumber("1.1") and "," or ".") .. "(%d)", "%1" .. (tonumber("1.1") and "." or ",") .. "%2")
		    local coords = {}
		    --put the numbers into the table
		    for pattern in translatemsg:gmatch("%S+") do
		        table.insert(coords, pattern)
		    end
		    local canSet = C_Map.CanSetUserWaypointOnMap(C_Map.GetBestMapForUnit("player"))
		    if canSet == false then
				print('|cff82B4ffEltruism|r: '..'Area does not support waypoints')
			else
			    --core of the function
			    if #coords < 2 then
			    	print('|cff82B4ffEltruism|r: '..'Unsupported format')
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
			        	ElvUI_EltreumUI:Print('Unsupported format or Area does not support waypoints')
			        elseif x == nil or y == nil then
			        	ElvUI_EltreumUI:Print('Area does not support waypoints')
			        else
				        C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(C_Map.GetBestMapForUnit('player'),x,y))
				        if C_Map.GetBestMapForUnit('player') == nil then
				        	ElvUI_EltreumUI:Print('Area does not support waypoints')
				        else
				        	ElvUI_EltreumUI:Print(C_Map.GetUserWaypointHyperlink())
				    	end
			   		end
				end
			end
		end
	end
end
