local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local LoadAddOn = _G.LoadAddOn
local GetCoinIcon = _G.GetCoinIcon
local CombatText_AddMessage = _G.CombatText_AddMessage
local CombatText_StandardScroll = _G.CombatText_StandardScroll


-- Register on init
function ElvUI_EltreumUI:LoadCommands()
	self:RegisterChatCommand('eltruism', 'RunCommands')
	self:RegisterChatCommand('way', 'WaypointTexttoCoordinate')
    self:RegisterChatCommand('waypoint', 'WaypointTexttoCoordinate')
end

function ElvUI_EltreumUI:RunCommands(message)
	if message == '' or message == 'install' or message == 'setup' then
		E:GetModule('PluginInstaller'):Queue(ElvUI_EltreumUI.InstallerData)
	elseif message == 'loot' then
		if E.private.ElvUI_EltreumUI.loottext.enable then
				local aImage = GetCoinIcon(9999999999);
				CombatText_AddMessage("|T ".. aImage ..":22:22:-11:-11|t  ".."9.999.999 Gold", CombatText_StandardScroll, 255, 255, 255)
		else
				CombatText_AddMessage("|T ".. 237555 ..":22:22:-11:-11|t  ".."Eltruism Loot is currently disabled!", CombatText_StandardScroll, 255, 255, 255)
		end
	elseif message == 'config' or message == 'options' then
		E:ToggleOptionsUI()
		E.Libs.AceConfigDialog:SelectGroup('ElvUI', 'ElvUI_EltreumUI')
	end
end

-- translate text to coordinates that are then put into the Waypoint system, inspired by the Wayfinder weakaura
function ElvUI_EltreumUI:WaypointTexttoCoordinate(message)
	-- add the separators ty stack overflow users
  	local separator1 = "(%d)" .. (tonumber("1.1") and "," or ".") .. "(%d)"
	local separator2 =   "%1" .. (tonumber("1.1") and "." or ",") .. "%2"
	-- translate the message numbers
  	local translatemsg = message:gsub("(%d)[%.,] (%d)", "%1 %2"):gsub(separator1, separator2)
    local coords = {}
    --put the numbers into the table
    for numbers in translatemsg:gmatch("%S+") do
        table.insert(coords, numbers)
    end

    --core of the function
    if #coords >=2 then
        local x, y = 0,0
        -- setup x coordinate
        if string.len(coords[1]) == 3 then
        	x = (tonumber(coords[1])/1000)
        elseif string.len(coords[1]) == 2 then
        	x = (tonumber(coords[1])/100)
        elseif string.len(coords[1]) == 4 then
        	x = (tonumber(coords[1])/100)
        elseif string.len(coords[1]) == 5 then
        	x = (tonumber(coords[1])/100)
        end
        -- setup y coordinate
        if string.len(coords[2]) == 3 then
        	y = (tonumber(coords[2])/1000)
        elseif string.len(coords[2]) == 2 then
        	y = (tonumber(coords[2])/100)
        elseif string.len(coords[2]) == 4 then
        	y = (tonumber(coords[2])/100)
        elseif string.len(coords[2]) == 5 then
        	y = (tonumber(coords[2])/100)
        end
        -- set the waypoint and print it
        C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(C_Map.GetBestMapForUnit('player'),x,y))
        print('|cff82B4ffEltruism|r: '..C_Map.GetUserWaypointHyperlink())
    end
end
