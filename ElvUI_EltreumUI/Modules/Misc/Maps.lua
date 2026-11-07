local E, L, _, P = unpack(ElvUI)
local M = E:GetModule('Minimap')
local S = E:GetModule('Skins')
local valuecolors = E.myClassColor
local _G = _G
local CreateFrame = _G.CreateFrame
local SetCVar = _G.C_CVar and _G.C_CVar.SetCVar or _G.SetCVar
local Minimap = _G.Minimap
local GetPlayerFacing = _G.GetPlayerFacing
local IsPlayerMoving = _G.IsPlayerMoving
local gsub = _G.gsub
local Enum = _G.Enum
local InCombatLockdown = _G.InCombatLockdown
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded
local pairs = _G.pairs
local hooksecurefunc = _G.hooksecurefunc
local MAP_PIN = _G.MAP_PIN
local math = _G.math
local string = _G.string

--Conversion of Time to Arrive weakaura (new version)
if E.Modern then
	local C_Map = _G.C_Map
	local C_SuperTrack = _G.C_SuperTrack
	local GetUnitSpeed = _G.GetUnitSpeed
	local C_Navigation = _G.C_Navigation
	local math = _G.math
	local mathfloor = math.floor
	local mathabs = math.abs
	local string = _G.string
	local stringlen = string.len
	local stringformat = string.format
	local stringmatch = string.match
	local tonumber = _G.tonumber
	local table = _G.table
	local tinsert = table.insert
	local wipe = _G.wipe
	local UiMapPoint = _G.UiMapPoint
	local SuperTrackedFrame = _G.SuperTrackedFrame
	local EltruismAutopin = CreateFrame("Frame", "EltruismAutoPin")
	local EltruismTimeToArriveParent = CreateFrame("Frame", "EltruismTimeToArriveParent")
	EltruismTimeToArriveParent:RegisterEvent("PLAYER_ENTERING_WORLD")
	local EltruismTimeToArrive = CreateFrame("Frame", "EltruismTimeToArrive", E.UIParent)
	EltruismTimeToArrive.TimeText = EltruismTimeToArrive:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
	EltruismTimeToArrive.TimeText:SetJustifyV("TOP")
	EltruismTimeToArrive.TimeText:SetSize(0, 26)
	EltruismTimeToArrive.TimeText:SetPoint("TOP", "SuperTrackedFrame", "BOTTOM", 0, 7)
	EltruismTimeToArrive.TimeText:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.general.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
	EltruismTimeToArrive.TimeText:SetParent(_G["SuperTrackedFrame"])
	EltruismTimeToArrive.WaypointText = EltruismTimeToArrive:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
	EltruismTimeToArrive.WaypointText:SetJustifyV("TOP")
	EltruismTimeToArrive.WaypointText:SetSize(0, 26)
	EltruismTimeToArrive.WaypointText:SetPoint("TOP", "SuperTrackedFrame", "BOTTOM", 0, -9)
	EltruismTimeToArrive.WaypointText:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.general.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
	EltruismTimeToArrive.WaypointText:SetParent(_G["SuperTrackedFrame"])
	EltruismTimeToArrive:SetParent(_G["SuperTrackedFrame"])
	SuperTrackedFrame.DistanceText:SetTextColor(1,1,1)
	SuperTrackedFrame.DistanceText:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.general.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))

	--set the throttle
	local ONUPDATE_INTERVAL = 1
	local TimeSinceLastUpdate = 0

	function ElvUI_EltreumUI:SpeedCheckDelayed()
		local previousdistance = C_Navigation.GetDistance()
		local speed = mathabs(EltruismTimeToArrive.SavedDistance - previousdistance)
		local seconds = 0
		local minutes = 0
		if speed and speed > 0 then
			local eta= mathabs(EltruismTimeToArrive.SavedDistance / speed)
			if eta > 600 then
				minutes = stringformat("%02.f", mathfloor(eta/60 ))
				seconds = stringformat("%02.f", mathfloor(eta - minutes *60))
			elseif eta < 600 and eta > 10 then
				minutes = stringformat("%01.f", mathfloor(eta/60))
				seconds = stringformat("%02.f", mathfloor(eta - minutes *60))
			elseif eta < 10 then
				minutes = stringformat("%01.f", mathfloor(eta/60))
				seconds = stringformat("%1.d", mathfloor(eta - minutes *60))
			else
				minutes = stringformat("%02.f", mathfloor(eta/60))
				seconds = stringformat("%02.f", mathfloor(eta - minutes *60))
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

	--use throttled onupdate to udpate the text (once per second)
	function ElvUI_EltreumUI:TimeToArriveOnUpdate(elapsed)
		TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
		if TimeSinceLastUpdate >= ONUPDATE_INTERVAL then
			TimeSinceLastUpdate = 0

			local notsafe
			local speed = 0

			--player speed can be secret, so protect in case there is a waypoint when it is
			if ElvUI_EltreumUI:IsThisASafeSecret(GetUnitSpeed("player"),true) then
				notsafe = false
				speed = GetUnitSpeed("player") or GetUnitSpeed("vehicle")
				if not speed or speed == 0 then
					local _,_,flyspeed = GetUnitSpeed('player')
					speed = flyspeed
				end
			else
				notsafe = true
			end

			--add objective text
			--name, description = C_SuperTrack.GetSuperTrackedItemName()
			--questID = C_SuperTrack.GetSuperTrackedQuestID()
			if E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.waypointname then
				local name = C_SuperTrack.GetSuperTrackedItemName()
				if name == MAP_PIN then
					EltruismTimeToArrive.WaypointText:SetText("")
				elseif (name ~= EltruismTimeToArrive.WaypointText:GetText()) then
					EltruismTimeToArrive.WaypointText:SetText(name)
				end
			end

			--calculate time to arrive
			local distance = C_Navigation.GetDistance()
			EltruismTimeToArrive.SavedDistance = distance
			local seconds = 0
			local minutes = 0
			if IsPlayerMoving() or _G.UnitOnTaxi("player") then
				if (not speed or speed == 0) or notsafe then --might be dragonflying or secret, calculate based on delta distance
					E:Delay(1, ElvUI_EltreumUI.SpeedCheckDelayed)
				else
					if speed and speed > 0 then
						local eta= mathabs(distance / speed)
						if eta > 600 then
							minutes = stringformat("%02.f", mathfloor(eta/60 ))
							seconds = stringformat("%02.f", mathfloor(eta - minutes *60))
						elseif eta < 600 and eta > 10 then
							minutes = stringformat("%01.f", mathfloor(eta/60))
							seconds = stringformat("%02.f", mathfloor(eta - minutes *60))
						elseif eta < 10 then
							minutes = stringformat("%01.f", mathfloor(eta/60))
							seconds = stringformat("%1.d", mathfloor(eta - minutes *60))
						else
							minutes = stringformat("%02.f", mathfloor(eta/60))
							seconds = stringformat("%02.f", mathfloor(eta - minutes *60))
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
			else --not moving at all
				EltruismTimeToArrive.TimeText:SetText("***")
			end
		end
	end

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
					if InCombatLockdown() then return end --check for combat due to taint
					local instanceType = ElvUI_EltreumUI:IsInInstance(nil,nil,nil,true)
					--print(instanceType,event,"autopin")
					if instanceType ~= "none" then --clears waypoints inside instances
						C_Map.ClearUserWaypoint()
					elseif instanceType == "none" then --is in the open world
						--if event == "USER_WAYPOINT_UPDATED" and C_Map.HasUserWaypoint() then
						if C_Map.HasUserWaypoint()then
							E:Delay(0, function()
								if not InCombatLockdown() then --check for combat again due to taint
									C_SuperTrack.SetSuperTrackedUserWaypoint(true)
								end
							end)
						end
					end
				end)
			end

			--try to fix issue where the MapCanvasPinMixin:SetPassThroughButtons() will throw a taint

			--[[WorldMapMixin.SetPassThroughButtons = E.noop
			WorldMapMixin.CheckMouseButtonPassthrough = E.noop
			WorldMapMixin.ShouldMouseButtonBePassthrough = E.noop
			_G.WorldMapFrame.SetPassThroughButtons = E.noop
			_G.WorldMapFrame.CheckMouseButtonPassthrough = E.noop
			_G.WorldMapFrame.ShouldMouseButtonBePassthrough = E.noop]]

			_G.SuperTrackablePinMixin.SetPropagateMouseClicks = E.noop --this is new [TOGGLEWORLDMAP]:1: in function <[string "TOGGLEWORLDMAP"]:1>
			_G.SuperTrackablePinMixin.UpdateMousePropagation = E.noop --this is new [TOGGLEWORLDMAP]:1: in function <[string "TOGGLEWORLDMAP"]:1>
			_G.SuperTrackablePinMixin.SetPassThroughButtons = E.noop --this is new [TOGGLEWORLDMAP]:1: in function <[string "TOGGLEWORLDMAP"]:1>
			_G.SuperTrackablePinMixin.ShouldMouseButtonBePassthrough = E.noop
			_G.WorldQuestPinMixin.SetPassThroughButtons = E.noop
			_G.WorldQuestPinMixin.CheckMouseButtonPassthrough = E.noop
			_G.WorldQuestPinMixin.ShouldMouseButtonBePassthrough = E.noop
			_G.MapCanvasPinMixin.SetPassThroughButtons = E.noop
			_G.MapCanvasPinMixin.CheckMouseButtonPassthrough = E.noop
			_G.MapCanvasPinMixin.ShouldMouseButtonBePassthrough = E.noop
			_G.WaypointLocationPinMixin.SetPassThroughButtons = E.noop
			_G.WaypointLocationPinMixin.CheckMouseButtonPassthrough = E.noop
			_G.WaypointLocationPinMixin.ShouldMouseButtonBePassthrough = E.noop

			--remove max distance
			if not SuperTrackedFrame.EltruismHook then

				--blizzard restricts waypoints, unrestrict them again
				hooksecurefunc(_G.C_Navigation, "HasValidScreenPosition", function()
					return true
				end)

				--swap to hook instead of global replace
				hooksecurefunc(SuperTrackedFrame, "GetTargetAlphaBaseValue", function()
					local d = C_Navigation.GetDistance()
					if (d >= 10 ) then
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
						C_Map.ClearUserWaypoint()
						return 0
					end
				end)

				SuperTrackedFrame.EltruismHook = true
			end

			SuperTrackedFrame.DistanceText:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.general.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			EltruismTimeToArrive.TimeText:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.general.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			EltruismTimeToArrive.WaypointText:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.general.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			if E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.classcolortext then
				SuperTrackedFrame.DistanceText:SetTextColor(valuecolors.r,valuecolors.g,valuecolors.b)
				EltruismTimeToArrive.TimeText:SetTextColor(valuecolors.r,valuecolors.g,valuecolors.b)
				EltruismTimeToArrive.WaypointText:SetTextColor(valuecolors.r,valuecolors.g,valuecolors.b)
			else
				SuperTrackedFrame.DistanceText:SetTextColor(E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorR, E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorG, E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorB)
				EltruismTimeToArrive.TimeText:SetTextColor(E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorR, E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorG, E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorB)
				EltruismTimeToArrive.WaypointText:SetTextColor(E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorR, E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorG, E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorB)
			end

			--color icon
			if E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.color.enable then
				SuperTrackedFrame.Icon:SetDesaturated(true)
				SuperTrackedFrame.Arrow:SetDesaturated(true)
				if not E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.color.classcolor then
					SuperTrackedFrame.Icon:SetVertexColor(E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.color.r, E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.color.g, E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.color.b)
					SuperTrackedFrame.Arrow:SetVertexColor(E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.color.r, E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.color.g, E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.color.b)
				else
					SuperTrackedFrame.Arrow:SetVertexColor(valuecolors.r,valuecolors.g,valuecolors.b)
					SuperTrackedFrame.Icon:SetVertexColor(valuecolors.r,valuecolors.g,valuecolors.b)
				end
			end

			EltruismTimeToArriveParent:RegisterEvent("USER_WAYPOINT_UPDATED")
			EltruismTimeToArriveParent:RegisterEvent("WAYPOINT_UPDATE")
			EltruismTimeToArriveParent:RegisterEvent("SUPER_TRACKING_CHANGED")
			--EltruismTimeToArriveParent:SetScript("OnEvent", function(_, event)
			EltruismTimeToArriveParent:SetScript("OnEvent", function()
				local instanceType = ElvUI_EltreumUI:IsInInstance(nil,nil,nil,true)
				--print(instanceType,event,"waypoint")
				if (C_Map.HasUserWaypoint() or C_SuperTrack.IsSuperTrackingAnything()) and (instanceType == "none" or instanceType == "neighborhood") then
					EltruismTimeToArrive:SetScript("OnUpdate", ElvUI_EltreumUI.TimeToArriveOnUpdate)
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
		if E.Modern then
			if E.db.ElvUI_EltreumUI.waypoints.waytext.enable then
				-- translate the message into numbers
				local translatemsg = message:gsub("(%d)[%.,] (%d)", "%1 %2"):gsub("(%d)"..(tonumber("1.1") and "," or ".").."(%d)", "%1"..(tonumber("1.1") and "." or ",").."%2")

				--wipe table just in case
				wipe(coords)

				--put the numbers into the table
				for pattern in translatemsg:gmatch("%S+") do
					if pattern:gmatch("#") then --add support for setting waypoints on other maps, plus compatibility with tomtom commands since its just the map and coordinates
						pattern = gsub(pattern,"#","") --just remove the #
					end
					tinsert(coords, pattern)
				end
				local canSet = C_Map.CanSetUserWaypointOnMap(C_Map.GetBestMapForUnit("player"))

				--neighborhoods dont let you set waypoints
				local instanceType = ElvUI_EltreumUI:IsInInstance(nil,nil,nil,true)
				if instanceType == "neighborhood" then
					canSet = false
				end

				if not canSet then
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

						if coords[3] then --coord[3] then its likely a tomtom command
							if tonumber(coords[1]) then
								local info = C_Map.GetMapInfo(coords[1]) --check for map info
								if info then --if there is one, then its all good
									-- setup x coordinate
									if coords[2] and stringmatch(coords[2], "%d+") then
										if stringlen(coords[2]) == 3 then
											x = (tonumber(coords[2])*0.001)
										elseif stringlen(coords[2]) == 2 then
											x = (tonumber(coords[2])*0.01)
										elseif stringlen(coords[2]) == 4 then
											x = (tonumber(coords[2])*0.01)
										elseif stringlen(coords[2]) == 5 then
											x = (tonumber(coords[2])*0.01)
										elseif stringlen(coords[2]) > 5 then
											coords[2] = "a"
										end
									end
									-- setup y coordinate
									if coords[3] and stringmatch(coords[3], "%d+") then
										if stringlen(coords[3]) == 3 then
											y = (tonumber(coords[3])*0.001)
										elseif stringlen(coords[3]) == 2 then
											y = (tonumber(coords[3])*0.01)
										elseif stringlen(coords[3]) == 4 then
											y = (tonumber(coords[3])*0.01)
										elseif stringlen(coords[3]) == 5 then
											y = (tonumber(coords[3])*0.01)
										elseif stringlen(coords[3]) > 5 then
											coords[1] = "a"
										end
									end
									-- check if its numbers set the waypoint and print it otherwise error message
									if (coords[2] and stringmatch(coords[2], "%a+")) or (coords[3] and stringmatch(coords[3], "%a+")) then
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
										if not xlength or not ylength then
											ElvUI_EltreumUI:Print(L["Unsupported format or Area does not support waypoints"])
											wipe(coords)
										else
											C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(coords[1],x,y)) --use the map since it exists
											if C_Map.GetBestMapForUnit('player') == nil then
												ElvUI_EltreumUI:Print(L["Area does not support waypoints"])
												wipe(coords)
											else
												ElvUI_EltreumUI:Print(C_Map.GetUserWaypointHyperlink())
											end
										end
									end
								else
									ElvUI_EltreumUI:Print(L["Map not found"])
								end
							else
								ElvUI_EltreumUI:Print(L["Map not found"])
							end
						else
							-- setup x coordinate
							if coords[1] and stringmatch(coords[1], "%d+") then
								if stringlen(coords[1]) == 3 then
									x = (tonumber(coords[1])*0.001)
								elseif stringlen(coords[1]) == 2 then
									x = (tonumber(coords[1])*0.01)
								elseif stringlen(coords[1]) == 4 then
									x = (tonumber(coords[1])*0.01)
								elseif stringlen(coords[1]) == 5 then
									x = (tonumber(coords[1])*0.01)
								elseif stringlen(coords[1]) > 5 then
									coords[1] = "a"
								end
							end
							-- setup y coordinate
							if coords[2] and stringmatch(coords[2], "%d+") then
								if stringlen(coords[2]) == 3 then
									y = (tonumber(coords[2])*0.001)
								elseif stringlen(coords[2]) == 2 then
									y = (tonumber(coords[2])*0.01)
								elseif stringlen(coords[2]) == 4 then
									y = (tonumber(coords[2])*0.01)
								elseif stringlen(coords[2]) == 5 then
									y = (tonumber(coords[2])*0.01)
								elseif stringlen(coords[2]) > 5 then
									coords[1] = "a"
								end
							end
							-- check if its numbers set the waypoint and print it otherwise error message
							if (coords[1] and stringmatch(coords[1], "%a+")) or (coords[2] and stringmatch(coords[2], "%a+")) then
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
								if not xlength or not ylength then
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
	end

	--update color for options
	function ElvUI_EltreumUI:UpdateSuperTrackedColor()
		if E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.color.enable then
			SuperTrackedFrame.Icon:SetDesaturated(true)
			SuperTrackedFrame.Arrow:SetDesaturated(true)
			if not E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.color.classcolor then
				SuperTrackedFrame.Icon:SetVertexColor(E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.color.r, E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.color.g, E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.color.b)
				SuperTrackedFrame.Arrow:SetVertexColor(E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.color.r, E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.color.g, E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.color.b)
			else
				SuperTrackedFrame.Arrow:SetVertexColor(valuecolors.r,valuecolors.g,valuecolors.b)
				SuperTrackedFrame.Icon:SetVertexColor(valuecolors.r,valuecolors.g,valuecolors.b)
			end
		else
			SuperTrackedFrame.Icon:SetDesaturated(false)
			SuperTrackedFrame.Arrow:SetDesaturated(false)
			SuperTrackedFrame.Arrow:SetVertexColor(1,1,1)
			SuperTrackedFrame.Icon:SetVertexColor(1,1,1)
		end
	end
end

--scale the world map in retail
function ElvUI_EltreumUI:WorldMapScale()
	if E.db.ElvUI_EltreumUI.otherstuff.worldmapscale then
		if _G["WorldMapFrame"] then
			_G["WorldMapFrame"]:HookScript("OnShow", function()
				if not E.Modern then
					if not InCombatLockdown then
						if not IsAddOnLoaded("Leatrix_Maps") then
							_G["WorldMapFrame"]:SetScale(E.db.ElvUI_EltreumUI.otherstuff.worldmapscalevalue)
						end
						if not _G["WorldMapFrame"]:HasScript("OnDragStart") then
							_G["WorldMapFrame"]:SetMovable(true)
							_G["WorldMapFrame"]:EnableMouse(true)
							_G["WorldMapFrame"]:RegisterForDrag("LeftButton")
							_G["WorldMapFrame"]:SetScript("OnDragStart", _G["WorldMapFrame"].StartMoving)
							_G["WorldMapFrame"]:SetScript("OnDragStop", _G["WorldMapFrame"].StopMovingOrSizing)
							_G["WorldMapFrame"]:SetClampedToScreen(true)
						end
					end
				else
					if ElvUI_EltreumUI:IsThisASafeSecret(_G["WorldMapFrame"],true) then
						_G["WorldMapFrame"]:SetScale(E.db.ElvUI_EltreumUI.otherstuff.worldmapscalevalue)
					end
				end
			end)

			--make the bounty select mouseover
			if E.Modern then
				for _, v in pairs({_G["WorldMapFrame"]:GetChildren()}) do
					if v then
						if v.BountyDropDown and v.BountyDropdownButton then
							v:SetAlpha(0)
							v:SetScript('OnEnter', function() v:SetAlpha(1) v.BountyDropdownButton:SetAlpha(1) end)
							v:SetScript('OnLeave', function() v:SetAlpha(0) v.BountyDropdownButton:SetAlpha(0) end)
							v.BountyDropdownButton:SetScript('OnEnter', function() v:SetAlpha(1) v.BountyDropdownButton:SetAlpha(1) end)
							v.BountyDropdownButton:SetScript('OnLeave', function() v:SetAlpha(0) v.BountyDropdownButton:SetAlpha(0) end)

							--skin the bounty button
							S:HandleButton(v.BountyDropdownButton)
							v.BountyDropdownButton:SetNormalTexture(E.Media.Textures.ArrowUp)
							v.BountyDropdownButton:SetPushedTexture(E.Media.Textures.ArrowUp)
							v.BountyDropdownButton:SetDisabledTexture(E.Media.Textures.ArrowUp)
							v.BountyDropdownButton:GetNormalTexture():SetRotation(-1.57)
							v.BountyDropdownButton:GetPushedTexture():SetRotation(-1.57)
							v.BountyDropdownButton:GetDisabledTexture():SetRotation(-1.57)
						elseif v.BountyDropdown then
							v:SetAlpha(0)
							v:SetScript('OnEnter', function() v:SetAlpha(1) v.BountyDropdown:SetAlpha(1) end)
							v:SetScript('OnLeave', function() v:SetAlpha(0) v.BountyDropdown:SetAlpha(0) end)
							v.BountyDropdown:SetScript('OnEnter', function() v:SetAlpha(1) v.BountyDropdown:SetAlpha(1) end)
							v.BountyDropdown:SetScript('OnLeave', function() v:SetAlpha(0) v.BountyDropdown:SetAlpha(0) end)

							--skin the bounty button
							S:HandleButton(v.BountyDropdown)
							v.BountyDropdown:SetNormalTexture(E.Media.Textures.ArrowUp)
							v.BountyDropdown:SetPushedTexture(E.Media.Textures.ArrowUp)
							v.BountyDropdown:SetDisabledTexture(E.Media.Textures.ArrowUp)
							v.BountyDropdown:GetNormalTexture():SetRotation(-1.57)
							v.BountyDropdown:GetPushedTexture():SetRotation(-1.57)
							v.BountyDropdown:GetDisabledTexture():SetRotation(-1.57)
						end
					end
				end
			end
		end
	end
end

local onupdatesetup = false
local TimeSinceLastUpdate2 = 0
local ONUPDATE_INTERVAL2 = 0.016 --smooth for 60fps

--add cardinal directions to minimap
local Cardinals = CreateFrame("FRAME", "Eltruism Cardinal Directions")
Cardinals:SetParent(Minimap)
local function UpdateCardinalsRotation(_, elapsed)
	TimeSinceLastUpdate2 = TimeSinceLastUpdate2 + elapsed
	if TimeSinceLastUpdate2 >= ONUPDATE_INTERVAL2 then
		TimeSinceLastUpdate2 = 0
		local facing = GetPlayerFacing()
		if facing and E:NotSecretValue(facing) then
			Minimap.EltruismRotate:SetRotation(-facing)
		end
	end
end

local function RotateMinimap()
	if E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.rotate then
		if E.Modern then
			Enum.EditModeMinimapSetting.RotateMinimap = 1
		end
		SetCVar("rotateMinimap",1)
		E.db["general"]["minimap"]["rotate"] = true
	else
		if E.Modern then
			Enum.EditModeMinimapSetting.RotateMinimap = 0
		end
		SetCVar("rotateMinimap",0)
		E.db["general"]["minimap"]["rotate"] = false
	end
end

--hide the backdrop here due to elvui function showing it
local function FixElvUIMinimapBorder()
	if E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.circle then
		if _G.MinimapBackdrop then
			_G.MinimapBackdrop:Hide()
		end
		if _G.Minimap.backdrop then
			_G.Minimap.backdrop:Hide()
		end

		--show icons that could be hidden by hiding the backdrop
		local minimapTrackingIcons = {
			_G.MinimapCluster.Tracking,
			_G.MinimapCluster.TrackingFrame,
			_G.MiniMapTrackingFrame,
			_G.MiniMapTracking,
			_G.ExpansionLandingPageMinimapButton,
			_G.MiniMapLFGFrame,
			_G.LFGMinimapFrame,
		}
		for _, frame in pairs(minimapTrackingIcons) do
			if frame then
				frame:SetParent(_G.Minimap)
			end
		end
	else
		if _G.MinimapBackdrop then
			_G.MinimapBackdrop:Show()
		end
		if _G.Minimap.backdrop then
			_G.Minimap.backdrop:Show()
		end
	end
end

function ElvUI_EltreumUI:MinimapCardinalDirections()
	if E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.circle then

		RotateMinimap()
		FixElvUIMinimapBorder()

		if Minimap.backdrop then
			Minimap.backdrop:Hide()
		end
		if _G["EltruismMiniMapShadowFrame"] then
			_G["EltruismMiniMapShadowFrame"]:Hide()
		end
		Minimap:SetMaskTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\map_circle")

		--add a shadow texture
		if E.db.ElvUI_EltreumUI.skins.shadow.enable and not Minimap.EltruismRotateShadow then
			Minimap.EltruismRotateShadow = Minimap:CreateTexture(nil, "BACKGROUND", nil, -3)
			Minimap.EltruismRotateShadow:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\map_circle_shadow")
			Minimap.EltruismRotateShadow:SetSize(Minimap:GetWidth(),Minimap:GetHeight())
			Minimap.EltruismRotateShadow:SetPoint("CENTER", Minimap, "CENTER", 0, 0)
		end

		--elvui forces square, force round in this case
		_G.GetMinimapShape = function()
			return 'ROUND'
		end

		if E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.enable and E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.rotate then
			if not Minimap.EltruismRotate then
				Minimap.EltruismRotate = Minimap:CreateTexture()
				Minimap.EltruismRotate:SetTexture("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\cardinals.tga")
				Minimap.EltruismRotate:SetPoint("CENTER", Minimap, "CENTER", 0, 0)
			end
			Minimap.EltruismRotate:SetSize(Minimap:GetWidth()+E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.offset,Minimap:GetHeight()+E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.offset)
			if E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.classcolor then
				Minimap.EltruismRotate:SetVertexColor(valuecolors.r,valuecolors.g,valuecolors.b,1)
			else
				Minimap.EltruismRotate:SetVertexColor(E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.r,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.g,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.b,1)
			end

			ElvUI_EltreumUI:MinimapCardinalDirectionsRotateInstance()
		else
			if Minimap.EltruismRotate then
				Minimap.EltruismRotate:Hide()
			end
			Cardinals:SetScript("OnUpdate",nil)
			onupdatesetup = false

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

				Cardinals.N:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.fontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				Cardinals.E:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.fontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				Cardinals.S:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.fontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				Cardinals.W:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.fontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))

				if E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.classcolor then
					Cardinals.N:SetTextColor(valuecolors.r,valuecolors.g,valuecolors.b)
					Cardinals.E:SetTextColor(valuecolors.r,valuecolors.g,valuecolors.b)
					Cardinals.S:SetTextColor(valuecolors.r,valuecolors.g,valuecolors.b)
					Cardinals.W:SetTextColor(valuecolors.r,valuecolors.g,valuecolors.b)
				else
					Cardinals.N:SetTextColor(E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.r,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.g,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.b)
					Cardinals.E:SetTextColor(E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.r,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.g,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.b)
					Cardinals.S:SetTextColor(E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.r,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.g,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.b)
					Cardinals.W:SetTextColor(E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.r,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.g,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.b)
				end
			end
		end
	else

		if E.Modern then
			Enum.EditModeMinimapSetting.RotateMinimap = 0
		end
		SetCVar("rotateMinimap",0)
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

			local verticalInset = (ElvUI_EltreumUI.rectangleMinimapInset or 0) * (E.db.general.minimap.scale or 1)
			Cardinals.N:ClearAllPoints()
			Cardinals.E:ClearAllPoints()
			Cardinals.S:ClearAllPoints()
			Cardinals.W:ClearAllPoints()
			Cardinals.N:SetPoint("BOTTOM", Minimap, "TOP", 0, -E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.offset - verticalInset)
			Cardinals.E:SetPoint("LEFT", Minimap, "RIGHT", -E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.offset, 0)
			Cardinals.S:SetPoint("TOP", Minimap, "BOTTOM", 0, E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.offset + verticalInset)
			Cardinals.W:SetPoint("RIGHT", Minimap, "LEFT", E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.offset, 0)

			Cardinals.N:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.fontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			Cardinals.E:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.fontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			Cardinals.S:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.fontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			Cardinals.W:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.fontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))

			if E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.classcolor then
				Cardinals.N:SetTextColor(valuecolors.r,valuecolors.g,valuecolors.b)
				Cardinals.E:SetTextColor(valuecolors.r,valuecolors.g,valuecolors.b)
				Cardinals.S:SetTextColor(valuecolors.r,valuecolors.g,valuecolors.b)
				Cardinals.W:SetTextColor(valuecolors.r,valuecolors.g,valuecolors.b)
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
end

-- Eltruism Rectangle Minimap
local rectangleMaskPresets = {
	["16:9"] = { heightFactor = 9 / 16, mask = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\map_rectangle_16_9" },
	["4:3"] = { heightFactor = 3 / 4, mask = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\map_rectangle_4_3" },
	["2:1"] = { heightFactor = 1 / 2, mask = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\map_rectangle_2_1" },
}
local function GetMinimapVerticalCrop()
	if not E.db.ElvUI_EltreumUI.otherstuff.rectangleMinimap.enable or E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.circle then
		return 0, nil
	end
	local preset = rectangleMaskPresets[E.db.ElvUI_EltreumUI.otherstuff.rectangleMinimap.preset] or rectangleMaskPresets["16:9"]
	local mapSize = E.MinimapSize or Minimap:GetWidth()
	local crop = math.floor((mapSize * (1 - preset.heightFactor)) * 0.5 + 0.5)
	return crop, preset.mask
end

function ElvUI_EltreumUI:GetIconSettings(button)
	local defaults = P.general.minimap.icons[button]
	local profile = E.db.general.minimap.icons[button]
	local scale = profile.scale or defaults.scale
	local position = profile.position or defaults.position
	local xOffset = profile.xOffset or defaults.xOffset
	local yOffset = profile.yOffset or defaults.yOffset

	local crop = GetMinimapVerticalCrop()
	if crop > 0 and position then
		local shift = crop * (E.db.general.minimap.scale or 1)
		if string.find(position, "TOP") then
			yOffset = (yOffset or 0) - shift
		elseif string.find(position, "BOTTOM") then
			yOffset = (yOffset or 0) + shift
		end
	end

	return scale, position, xOffset, yOffset
end

local GetIconSettingsHook = false
function ElvUI_EltreumUI:UpdateRectangleMinimap()
	if InCombatLockdown() or not M.MapHolder then
		return
	end

	if not GetIconSettingsHook and E.db.ElvUI_EltreumUI.otherstuff.rectangleMinimap.enable and M.GetIconSettings ~= ElvUI_EltreumUI.GetIconSettings then
		M.GetIconSettings = ElvUI_EltreumUI.GetIconSettings
		GetIconSettingsHook = true
		M:UpdateSettings()
		return
	end

	local crop, maskPath = GetMinimapVerticalCrop()
	local borderOffset = E.PixelMode and 1 or 3

	if crop <= 0 then
		if self.rectangleMinimapInset then
			self.rectangleMinimapInset = nil
			Minimap:SetHitRectInsets(0, 0, 0, 0)

			local isCircle = E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.circle
			if not isCircle then
				if M.SetMinimapMask then
					M:SetMinimapMask(true)
				else
					Minimap:SetMaskTexture(E.Modern and 130937 or [[interface\chatframe\chatframebackground]])
				end
			end

			if Minimap.backdrop then
				Minimap.backdrop:ClearAllPoints()
				Minimap.backdrop:SetOutside(Minimap, borderOffset, borderOffset)
			end
			if Minimap.location then
				Minimap.location:ClearAllPoints()
				Minimap.location:Point("TOP", Minimap, "TOP", 0, -4)
			end
			local shadowFrame = _G["EltruismMiniMapShadowFrame"]
			if shadowFrame and not isCircle then
				if E.db.ElvUI_EltreumUI.skins.shadow.enable and E.db.ElvUI_EltreumUI.skins.shadow.minimap and not (E.db.ElvUI_EltreumUI.borders.borders and E.db.ElvUI_EltreumUI.borders.minimapborder) then
					shadowFrame:ClearAllPoints()
					shadowFrame:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 0, 0)
					if E.db.datatexts.panels.MinimapPanel.backdrop and E.db.datatexts.panels.MinimapPanel.enable and _G.MinimapPanel and _G.MinimapPanel:IsShown() then
						shadowFrame:SetPoint("BOTTOMLEFT", _G.MinimapPanel, "BOTTOMLEFT", 0, 0)
					else
						shadowFrame:SetPoint("BOTTOMLEFT", Minimap, "BOTTOMLEFT", 0, 0)
					end
					shadowFrame:Show()
				else
					shadowFrame:Hide()
				end
			end
		end
		return
	end

	self.rectangleMinimapInset = crop

	local scale = E.db.general.minimap.scale or 1
	local scaledCrop = crop * scale

	Minimap:SetMaskTexture(maskPath)
	Minimap:SetHitRectInsets(0, 0, crop, crop)
	Minimap:SetClampedToScreen(true)
	Minimap:SetClampRectInsets(0, 0, 0, 0)
	Minimap:ClearAllPoints()
	Minimap:Point("TOPRIGHT", M.MapHolder, "TOPRIGHT", -borderOffset / scale, (-borderOffset / scale) + crop)

	if Minimap.backdrop then
		Minimap.backdrop:ClearAllPoints()
		Minimap.backdrop:SetOutside(Minimap, borderOffset, borderOffset - scaledCrop)
	end

	if Minimap.location then
		Minimap.location:ClearAllPoints()
		Minimap.location:Point("TOP", Minimap, "TOP", 0, -4 - scaledCrop)
	end

	local panel = _G.MinimapPanel
	if panel and panel:IsShown() then
		panel:ClearAllPoints()
		panel:Point("TOPLEFT", Minimap, "BOTTOMLEFT", -E.Border, (E.PixelMode and 0 or -3) + scaledCrop)
		panel:Point("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", E.Border, -23 + scaledCrop)
	end

	local visibleHeight = ((E.MinimapSize or Minimap:GetWidth()) - (crop * 2)) * scale
	local panelHeight = (panel and panel:IsShown() and panel:GetHeight()) or 0
	local croppedHeight = visibleHeight + panelHeight + (borderOffset * 2)
	M.MapHolder:SetHeight(croppedHeight)
	if _G.MinimapMover then
		_G.MinimapMover:SetHeight(croppedHeight)
	end

	local shadowFrame = _G["EltruismMiniMapShadowFrame"]
	if shadowFrame then
		if E.db.ElvUI_EltreumUI.skins.shadow.enable and E.db.ElvUI_EltreumUI.skins.shadow.minimap and not (E.db.ElvUI_EltreumUI.borders.borders and E.db.ElvUI_EltreumUI.borders.minimapborder) then
			local targetBackdrop = Minimap.backdrop or Minimap
			shadowFrame:ClearAllPoints()
			shadowFrame:SetPoint("TOPRIGHT", targetBackdrop, "TOPRIGHT", 0, 0)
			if E.db.datatexts.panels.MinimapPanel.backdrop and E.db.datatexts.panels.MinimapPanel.enable and panel and panel:IsShown() then
				shadowFrame:SetPoint("BOTTOMLEFT", panel, "BOTTOMLEFT", 0, 0)
			else
				shadowFrame:SetPoint("BOTTOMLEFT", targetBackdrop, "BOTTOMLEFT", 0, 0)
			end
			shadowFrame:Show()
		else
			shadowFrame:Hide()
		end
	end
	if Minimap.EltruismRotateShadow then
		Minimap.EltruismRotateShadow:Hide()
	end

	if _G.HybridMinimap and _G.HybridMinimap.MapCanvas then
		if not _G.HybridMinimap.EltruismMask then
			_G.HybridMinimap.EltruismMask = _G.HybridMinimap:CreateMaskTexture()
			_G.HybridMinimap.EltruismMask:SetAllPoints(_G.HybridMinimap)
		end
		_G.HybridMinimap.EltruismMask:SetTexture(maskPath)
		_G.HybridMinimap.MapCanvas:SetMaskTexture(_G.HybridMinimap.EltruismMask)
		_G.HybridMinimap.MapCanvas:SetUseMaskTexture(true)
	end
end

function ElvUI_EltreumUI:M_UpdateSettings()
	ElvUI_EltreumUI:UpdateRectangleMinimap()
	ElvUI_EltreumUI:MinimapCardinalDirections()
	ElvUI_EltreumUI:ElvUIMailTexture()
	ElvUI_EltreumUI:HandleBlizzardButtons()
	ElvUI_EltreumUI:UpdateMinimapButtonBar()
end
ElvUI_EltreumUI:SecureHook(M, "UpdateSettings", "M_UpdateSettings")

--setup onupdate and also get rid of it
function ElvUI_EltreumUI:MinimapCardinalDirectionsRotateInstance()
	RotateMinimap()
	if E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.enable and E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.rotate then
		local instanceType = ElvUI_EltreumUI:IsInInstance(nil,nil,nil,true)
		if instanceType == "none" then
			if Minimap.EltruismRotate then
				Minimap.EltruismRotate:Show()
				if not onupdatesetup then
					TimeSinceLastUpdate2 = 0
					Cardinals:SetScript("OnUpdate", UpdateCardinalsRotation)
					onupdatesetup = true
				end
			end
		else
			if Minimap.EltruismRotate then
				Minimap.EltruismRotate:Hide()
			end
			if onupdatesetup then
				Cardinals:SetScript("OnUpdate", nil)
				onupdatesetup = false
			end
		end
	else
		if Minimap.EltruismRotate then
			Minimap.EltruismRotate:Hide()
		end
		if onupdatesetup then
			Cardinals:SetScript("OnUpdate", nil)
			onupdatesetup = false
		end
	end
end
