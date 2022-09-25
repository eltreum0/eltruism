local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local CreateFrame = _G.CreateFrame
local UIParent = _G.UIParent
local IsInInstance = _G.IsInInstance
local C_Map = _G.C_Map
local C_Timer = _G.C_Timer
local C_SuperTrack = _G.C_SuperTrack
local SuperTrackedFrame = _G.SuperTrackedFrame
local GetUnitSpeed = _G.GetUnitSpeed
local C_Navigation = _G.C_Navigation
local math = _G.math
local string = _G.string
local tonumber = _G.tonumber
local table = _G.table
local wipe = _G.wipe
local UiMapPoint = _G.UiMapPoint
local classcolor = E:ClassColor(E.myclass, true)

--Conversion of Time to Arrive weakaura (new version)
local EltruismAutopin = CreateFrame("Frame", "EltruismAutoPin")
local EltruismTimeToArriveParent = CreateFrame("Frame", "EltruismTimeToArriveParent")
EltruismTimeToArriveParent:RegisterEvent("PLAYER_ENTERING_WORLD")
local EltruismTimeToArrive = CreateFrame("Frame", "EltruismTimeToArrive", UIParent)
EltruismTimeToArrive.TimeText = EltruismTimeToArrive:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
EltruismTimeToArrive.TimeText:SetJustifyV("TOP")
EltruismTimeToArrive.TimeText:SetSize(0, 26)
EltruismTimeToArrive.TimeText:SetPoint("TOP", "SuperTrackedFrame", "BOTTOM", 0, -40)
EltruismTimeToArrive.TimeText:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.general.fontSize, E.db.general.fontStyle)
EltruismTimeToArrive.TimeText:SetParent("SuperTrackedFrame")
EltruismTimeToArrive:SetParent("SuperTrackedFrame")

SuperTrackedFrame.DistanceText:SetTextColor(1,1,1)
SuperTrackedFrame.DistanceText:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.general.fontSize, E.db.general.fontStyle)

--set the throttle
local ONUPDATE_INTERVAL = 1
local TimeSinceLastUpdate = 0
function ElvUI_EltreumUI:WaypointTimeToArrive()
	if E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.enable then
		if E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.autopin then
			EltruismAutopin:RegisterEvent("USER_WAYPOINT_UPDATED")
			EltruismAutopin:RegisterEvent("PLAYER_ENTERING_WORLD") --doesnt seem to fire
			EltruismAutopin:RegisterEvent("PLAYER_STARTED_MOVING")
			EltruismAutopin:RegisterEvent("ZONE_CHANGED")
			--EltruismAutopin:SetScript("OnEvent", function(_, event)
			EltruismAutopin:SetScript("OnEvent", function()
				EltruismAutopin:UnregisterEvent("PLAYER_STARTED_MOVING")
				local _, instanceType = IsInInstance()
				if instanceType ~= "none" then
					C_Map.ClearUserWaypoint()
				elseif instanceType == "none" then
					--if event == "USER_WAYPOINT_UPDATED" and C_Map.HasUserWaypoint() == true then
					if C_Map.HasUserWaypoint() == true then
						C_Timer.After(0, function() C_SuperTrack.SetSuperTrackedUserWaypoint(true) end)
					end
				end
			end)
		end

		SuperTrackedFrame.DistanceText:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.general.fontSize, E.db.general.fontStyle)
		SuperTrackedFrame.DistanceText:SetTextColor(E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorR, E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorG, E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorB)
		EltruismTimeToArrive.TimeText:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.general.fontSize, E.db.general.fontStyle)
		EltruismTimeToArrive.TimeText:SetTextColor(E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorR, E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorG, E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorB)

		EltruismTimeToArriveParent:RegisterEvent("USER_WAYPOINT_UPDATED")
		EltruismTimeToArriveParent:RegisterEvent("WAYPOINT_UPDATE")
		EltruismTimeToArriveParent:RegisterEvent("SUPER_TRACKING_CHANGED")
		--EltruismTimeToArriveParent:SetScript("OnEvent", function(_, event)
			EltruismTimeToArriveParent:SetScript("OnEvent", function()
			--print(event.."waypoint")
			if C_Map.HasUserWaypoint() == true or C_SuperTrack.IsSuperTrackingAnything() == true then
				--use throttled onupdate to udpate the text (once per second)
				EltruismTimeToArrive:SetScript("OnUpdate", function(self, elapsed)
					--print("onupdate spam"..math.random(1,99))
					TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
					if TimeSinceLastUpdate >= ONUPDATE_INTERVAL then
						TimeSinceLastUpdate = 0

						--remove max distance
						do
							function SuperTrackedFrame:GetTargetAlphaBaseValue()
								local d = C_Navigation.GetDistance()
								if (d >= 40 ) then
									if E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.limitmaxdistance then
										if d <= E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.distance then
											return 1
										elseif d > E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.distance then
											return 0
										end
									else
										return 1
									end
								else
									return 0
								end
							end
						end

						--calculate time to arrive
						local speed = GetUnitSpeed("player")
						local distance = C_Navigation.GetDistance()
						local seconds = 0
						local minutes = 0
						if speed > 0 then
							local eta= math.abs(distance / speed)
							if eta > 600 then
								minutes = string.format("%02.f", math.floor(eta/60 ))
								seconds = string.format("%02.f", math.floor(eta - minutes *60))
							elseif eta < 600 and eta > 10 then
								minutes = string.format("%01.f", math.floor(eta/60))
								seconds = string.format("%02.f", math.floor(eta - minutes *60))
							elseif eta < 10 then
								minutes = string.format("%01.f", math.floor(eta/60))
								seconds = string.format("%1.d", math.floor(eta - minutes *60))
							else
								minutes = string.format("%02.f", math.floor(eta/60))
								seconds = string.format("%02.f", math.floor(eta - minutes *60))
							end
						end
						--set the time to arrive to the frame's text
						if minutes == 0 and seconds == 0 then
							EltruismTimeToArrive.TimeText:SetText("***")
						elseif minutes < "01" and seconds > "0" then
							EltruismTimeToArrive.TimeText:SetText(seconds.."s")
						else
							EltruismTimeToArrive.TimeText:SetText(minutes.."m"..":"..seconds.."s")
						end
					end
				end)
			else
				EltruismTimeToArrive:SetScript("OnUpdate", nil)
			end
		end)
	end
end

local coords = {}

-- translate text to coordinates that are then put into the Waypoint system, inspired by the Wayfinder weakaura by Khanibrawl
function ElvUI_EltreumUI:WaypointTexttoCoordinate(message)
	-- most of this was done with the help of posts on stack overflow and lua-users.org
	if E.Retail then
		if E.db.ElvUI_EltreumUI.waypoints.waytext.enable then
			-- translate the message into numbers
			local translatemsg = message:gsub("(%d)[%.,] (%d)", "%1 %2"):gsub("(%d)"..(tonumber("1.1") and "," or ".").."(%d)", "%1"..(tonumber("1.1") and "." or ",").."%2")


			--put the numbers into the table
			for pattern in translatemsg:gmatch("%S+") do
				table.insert(coords, pattern)
			end
			local canSet = C_Map.CanSetUserWaypointOnMap(C_Map.GetBestMapForUnit("player"))
			if canSet == false then
				ElvUI_EltreumUI:Print(L["Area does not support waypoints"])
				wipe(coords)
			else
				--core of the function
				if #coords < 2 then
					ElvUI_EltreumUI:Print(L["Unsupported format"])
					wipe(coords)
				end
				if #coords >=2 then
					local x, y = 0,0
					-- setup x coordinate
					if string.match(coords[1], "%d+") then
						if string.len(coords[1]) == 3 then
							x = (tonumber(coords[1])*0.001)
						elseif string.len(coords[1]) == 2 then
							x = (tonumber(coords[1])*0.01)
						elseif string.len(coords[1]) == 4 then
							x = (tonumber(coords[1])*0.01)
						elseif string.len(coords[1]) == 5 then
							x = (tonumber(coords[1])*0.01)
						elseif string.len(coords[1]) > 5 then
							coords[1] = "a"
						end
					end
					-- setup y coordinate
					if string.match(coords[2], "%d+") then
						if string.len(coords[2]) == 3 then
							y = (tonumber(coords[2])*0.001)
						elseif string.len(coords[2]) == 2 then
							y = (tonumber(coords[2])*0.01)
						elseif string.len(coords[2]) == 4 then
							y = (tonumber(coords[2])*0.01)
						elseif string.len(coords[2]) == 5 then
							y = (tonumber(coords[2])*0.01)
						elseif string.len(coords[2]) > 5 then
							coords[1] = "a"
						end
					end
					-- check if its numbers set the waypoint and print it otherwise error message
					if string.match(coords[1], "%a+") or string.match(coords[2], "%a+") then
						ElvUI_EltreumUI:Print(L["Unsupported format or Area does not support waypoints"])
						wipe(coords)
					elseif x == nil or y == nil then
						ElvUI_EltreumUI:Print(L["Area does not support waypoints"])
						wipe(coords)
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
							wipe(coords)
						else
							C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(C_Map.GetBestMapForUnit('player'),x,y))
							if C_Map.GetBestMapForUnit('player') == nil then
								ElvUI_EltreumUI:Print(L["Area does not support waypoints"])
								wipe(coords)
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

--add cardinal directions to minimap
local Cardinals = CreateFrame("FRAME", "Eltruism Cardinal Directions")
Cardinals:SetParent(Minimap)
function ElvUI_EltreumUI:MinimapCardinalDirections()
	if C_CVar.GetCVar("rotateMinimap") == "1" then return end
	if E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.enable then
		if not Cardinals.N then
			Cardinals.N = Cardinals:CreateFontString("EltruismNorth", "ARTWORK", "GameFontNormal")
		end
		Cardinals.N:SetText("N")
		if not Cardinals.E then
			Cardinals.E = Cardinals:CreateFontString("EltruismEast", "ARTWORK", "GameFontNormal")
		end
		Cardinals.E:SetText("E")
		if not Cardinals.S then
			Cardinals.S = Cardinals:CreateFontString("EltruismSouth", "ARTWORK", "GameFontNormal")
		end
		Cardinals.S:SetText("S")
		if not Cardinals.W then
			Cardinals.W = Cardinals:CreateFontString("EltruismWest", "ARTWORK", "GameFontNormal")
		end
		Cardinals.W:SetText("W")

		Cardinals.N:SetPoint("BOTTOM", Minimap, "TOP", 0, -E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.offset)
		Cardinals.E:SetPoint("LEFT", Minimap, "RIGHT", -E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.offset, 0)
		Cardinals.S:SetPoint("TOP", Minimap, "BOTTOM", 0, E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.offset)
		Cardinals.W:SetPoint("RIGHT", Minimap, "LEFT", E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.offset, 0)

		Cardinals.N:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.fontsize, E.db.general.fontStyle)
		Cardinals.E:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.fontsize, E.db.general.fontStyle)
		Cardinals.S:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.fontsize, E.db.general.fontStyle)
		Cardinals.W:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.fontsize, E.db.general.fontStyle)

		if E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.classcolor then
			Cardinals.N:SetTextColor(classcolor.r,classcolor.g,classcolor.b)
			Cardinals.E:SetTextColor(classcolor.r,classcolor.g,classcolor.b)
			Cardinals.S:SetTextColor(classcolor.r,classcolor.g,classcolor.b)
			Cardinals.W:SetTextColor(classcolor.r,classcolor.g,classcolor.b)
		else
			Cardinals.N:SetTextColor(E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.r,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.g,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.b)
			Cardinals.E:SetTextColor(E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.r,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.g,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.b)
			Cardinals.S:SetTextColor(E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.r,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.g,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.b)
			Cardinals.W:SetTextColor(E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.r,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.g,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.b)
		end
	else
		if Cardinals.N then
			Cardinals.N:SetText("")
		end
		if Cardinals.E then
			Cardinals.E:SetText("")
		end
		if Cardinals.S then
			Cardinals.S:SetText("")
		end
		if Cardinals.W then
			Cardinals.W:SetText("")
		end
	end
end
