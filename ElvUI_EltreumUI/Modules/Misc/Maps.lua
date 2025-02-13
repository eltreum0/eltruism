local E, L = unpack(ElvUI)
local _G = _G
local CreateFrame = _G.CreateFrame
local UIParent = _G.UIParent
local IsInInstance = _G.IsInInstance
local S = E:GetModule('Skins')
local valuecolors = E:ClassColor(E.myclass, true)
local SetCVar = _G.C_CVar and _G.C_CVar.SetCVar or _G.SetCVar
local Minimap = _G.Minimap
local GetPlayerFacing = _G.GetPlayerFacing
local IsPlayerMoving = _G.IsPlayerMoving
local gsub = _G.gsub
local Enum = _G.Enum
local InCombatLockdown = _G.InCombatLockdown
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded
local pairs = _G.pairs
local hooksecurefunc = _G.hooksecurefunc

--Conversion of Time to Arrive weakaura (new version)
if E.Retail then
	local C_Map = _G.C_Map
	local C_SuperTrack = _G.C_SuperTrack
	local GetUnitSpeed = _G.GetUnitSpeed
	local C_Navigation = _G.C_Navigation
	local math = _G.math
	local string = _G.string
	local tonumber = _G.tonumber
	local table = _G.table
	local wipe = _G.wipe
	local UiMapPoint = _G.UiMapPoint
	local SuperTrackedFrame = _G.SuperTrackedFrame
	local EltruismAutopin = CreateFrame("Frame", "EltruismAutoPin")
	local EltruismTimeToArriveParent = CreateFrame("Frame", "EltruismTimeToArriveParent")
	EltruismTimeToArriveParent:RegisterEvent("PLAYER_ENTERING_WORLD")
	local EltruismTimeToArrive = CreateFrame("Frame", "EltruismTimeToArrive", UIParent)
	EltruismTimeToArrive.TimeText = EltruismTimeToArrive:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
	EltruismTimeToArrive.TimeText:SetJustifyV("TOP")
	EltruismTimeToArrive.TimeText:SetSize(0, 26)
	EltruismTimeToArrive.TimeText:SetPoint("TOP", "SuperTrackedFrame", "BOTTOM", 0, 7)
	EltruismTimeToArrive.TimeText:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.general.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
	EltruismTimeToArrive.TimeText:SetParent(_G["SuperTrackedFrame"])
	EltruismTimeToArrive:SetParent(_G["SuperTrackedFrame"])
	SuperTrackedFrame.DistanceText:SetTextColor(1,1,1)
	SuperTrackedFrame.DistanceText:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.general.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))

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
					--print(instanceType,event,"autopin")
					if instanceType ~= "none" then --clears waypoints inside instances
						C_Map.ClearUserWaypoint()
					elseif instanceType == "none" then --is in the open world
						--if event == "USER_WAYPOINT_UPDATED" and C_Map.HasUserWaypoint() then
						if C_Map.HasUserWaypoint() then
							E:Delay(0, function() C_SuperTrack.SetSuperTrackedUserWaypoint(true) end)
						end
					end
				end)
			end

			--remove max distance
			if not SuperTrackedFrame.EltruismHook then

				--in 10.1.7 blizzard restricts waypoints, unrestrict them again
				hooksecurefunc(_G.C_Navigation, "HasValidScreenPosition", function()
					return true
				end)

				function SuperTrackedFrame:GetTargetAlphaBaseValue()
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
				end
				SuperTrackedFrame.EltruismHook = true
			end

			SuperTrackedFrame.DistanceText:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.general.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			EltruismTimeToArrive.TimeText:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.general.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			if E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.classcolortext then
				SuperTrackedFrame.DistanceText:SetTextColor(valuecolors.r,valuecolors.g,valuecolors.b)
				EltruismTimeToArrive.TimeText:SetTextColor(valuecolors.r,valuecolors.g,valuecolors.b)
			else
				SuperTrackedFrame.DistanceText:SetTextColor(E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorR, E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorG, E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorB)
				EltruismTimeToArrive.TimeText:SetTextColor(E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorR, E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorG, E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorB)
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
				local _, instanceType = IsInInstance()
				--print(instanceType,event,"waypoint")
				if (C_Map.HasUserWaypoint() or C_SuperTrack.IsSuperTrackingAnything()) and (instanceType == "none") then
					--use throttled onupdate to udpate the text (once per second)
					EltruismTimeToArrive:SetScript("OnUpdate", function(_, elapsed)
						--print("onupdate spam"..math.random(1,99))
						TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
						if TimeSinceLastUpdate >= ONUPDATE_INTERVAL then
							TimeSinceLastUpdate = 0

							--calculate time to arrive
							local speed = GetUnitSpeed("player") or GetUnitSpeed("vehicle")
							local distance = C_Navigation.GetDistance()
							local seconds = 0
							local minutes = 0
							if not speed or speed == 0 then
								local _,_,flyspeed = GetUnitSpeed('player')
								speed = flyspeed
							end
							if IsPlayerMoving() then
								if (not speed or speed == 0) then --might be dragonflying, calculate based on delta distance
									E:Delay(1, function()
										local previousdistance = C_Navigation.GetDistance()
										speed = math.abs(distance - previousdistance)
										--print(distance,previousdistance, speed)
										if speed and speed > 0 then
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
									end)
								else
									if speed and speed > 0 then
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
							else --not moving at all
								EltruismTimeToArrive.TimeText:SetText("***")
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

				--wipe table just in case
				wipe(coords)

				--put the numbers into the table
				for pattern in translatemsg:gmatch("%S+") do
					if pattern:gmatch("#") then --add support for setting waypoints on other maps, plus compatibility with tomtom commands since its just the map and coordinates
						pattern = gsub(pattern,"#","") --just remove the #
					end
					table.insert(coords, pattern)
				end
				local canSet = C_Map.CanSetUserWaypointOnMap(C_Map.GetBestMapForUnit("player"))
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
									if coords[2] and string.match(coords[2], "%d+") then
										if string.len(coords[2]) == 3 then
											x = (tonumber(coords[2])*0.001)
										elseif string.len(coords[2]) == 2 then
											x = (tonumber(coords[2])*0.01)
										elseif string.len(coords[2]) == 4 then
											x = (tonumber(coords[2])*0.01)
										elseif string.len(coords[2]) == 5 then
											x = (tonumber(coords[2])*0.01)
										elseif string.len(coords[2]) > 5 then
											coords[2] = "a"
										end
									end
									-- setup y coordinate
									if coords[3] and string.match(coords[3], "%d+") then
										if string.len(coords[3]) == 3 then
											y = (tonumber(coords[3])*0.001)
										elseif string.len(coords[3]) == 2 then
											y = (tonumber(coords[3])*0.01)
										elseif string.len(coords[3]) == 4 then
											y = (tonumber(coords[3])*0.01)
										elseif string.len(coords[3]) == 5 then
											y = (tonumber(coords[3])*0.01)
										elseif string.len(coords[3]) > 5 then
											coords[1] = "a"
										end
									end
									-- check if its numbers set the waypoint and print it otherwise error message
									if (coords[2] and string.match(coords[2], "%a+")) or (coords[3] and string.match(coords[3], "%a+")) then
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
							if coords[1] and string.match(coords[1], "%d+") then
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
							if coords[2] and string.match(coords[2], "%d+") then
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
							if (coords[1] and string.match(coords[1], "%a+")) or (coords[2] and string.match(coords[2], "%a+")) then
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
				if not E.Retail then
					if not InCombatLockdown then
						if not IsAddOnLoaded("Leatrix_Maps") then
							_G["WorldMapFrame"]:SetScale(E.db.ElvUI_EltreumUI.otherstuff.worldmapscalevalue)
						end
						if not _G["WorldMapFrame"].EltruismMoveable then
							_G["WorldMapFrame"]:SetMovable(true)
							_G["WorldMapFrame"]:EnableMouse(true)
							_G["WorldMapFrame"]:RegisterForDrag("LeftButton")
							_G["WorldMapFrame"]:SetScript("OnDragStart", _G["WorldMapFrame"].StartMoving)
							_G["WorldMapFrame"]:SetScript("OnDragStop", _G["WorldMapFrame"].StopMovingOrSizing)
							_G["WorldMapFrame"]:SetClampedToScreen(true)
							_G["WorldMapFrame"].EltruismMoveable = true
						end
					end
				else
					_G["WorldMapFrame"]:SetScale(E.db.ElvUI_EltreumUI.otherstuff.worldmapscalevalue)
				end
			end)

			--make the bounty select mouseover
			if E.Retail then
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
local ONUPDATE_INTERVAL2 = 0.01 --smooth for 60fps

--add cardinal directions to minimap
local Cardinals = CreateFrame("FRAME", "Eltruism Cardinal Directions")
Cardinals:SetParent(Minimap)

local function RotateMinimap()
	if E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.rotate then
		if E.Retail then
			Enum.EditModeMinimapSetting.RotateMinimap = 1
		end
		SetCVar("rotateMinimap",1)
	else
		if E.Retail then
			Enum.EditModeMinimapSetting.RotateMinimap = 0
		end
		SetCVar("rotateMinimap",0)
	end
end

function ElvUI_EltreumUI:MinimapCardinalDirections()
	if E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.circle then
		RotateMinimap()

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
				Minimap.EltruismRotate:SetSize(Minimap:GetWidth(),Minimap:GetHeight())
				Minimap.EltruismRotate:SetPoint("CENTER", Minimap, "CENTER", 0, 0)

				if E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.classcolor then
					Minimap.EltruismRotate:SetVertexColor(valuecolors.r,valuecolors.g,valuecolors.b,1)
				else
					Minimap.EltruismRotate:SetVertexColor(E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.r,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.g,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.b,1)
				end

				--i really dont like onupdate here, but since events dont fire all the time this is the best case use of it
				if not onupdatesetup then
					Cardinals:SetScript("OnUpdate",function(_, elapsed)
						TimeSinceLastUpdate2 = TimeSinceLastUpdate2 + elapsed
						if TimeSinceLastUpdate2 >= ONUPDATE_INTERVAL2 then
							TimeSinceLastUpdate2 = 0
							local _, instanceType = IsInInstance()
							if instanceType == "none" then
								local facing = GetPlayerFacing()
								if facing then
									Minimap.EltruismRotate:SetRotation(-facing)
								end
								if not Minimap.EltruismRotate:IsShown() then
									Minimap.EltruismRotate:Show()
								end
							else
								if Minimap.EltruismRotate:IsShown() then
									Minimap.EltruismRotate:Hide()
								end
							end
						end
					end)
					onupdatesetup = true
				end
			else
				Minimap.EltruismRotate:SetSize(Minimap:GetWidth()+E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.offset,Minimap:GetHeight()+E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.offset)
				if E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.classcolor then
					Minimap.EltruismRotate:SetVertexColor(valuecolors.r,valuecolors.g,valuecolors.b,1)
				else
					Minimap.EltruismRotate:SetVertexColor(E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.r,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.g,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.b,1)
				end

				if Minimap.EltruismRotate then
					Minimap.EltruismRotate:Show()
				end
				onupdatesetup = false
				ElvUI_EltreumUI:MinimapCardinalDirectionsRotateInstance()
			end
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
		if E.Retail then
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

--setup onupdate and also get rid of it
function ElvUI_EltreumUI:MinimapCardinalDirectionsRotateInstance()
	RotateMinimap()
	if E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.enable and E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.rotate then
		local _, instanceType = IsInInstance()
		if instanceType == "none" then
			if Minimap.EltruismRotate and not onupdatesetup then
				Minimap.EltruismRotate:Show()
				Cardinals:SetScript("OnUpdate",function(_, elapsed)
					TimeSinceLastUpdate2 = TimeSinceLastUpdate2 + elapsed
					if TimeSinceLastUpdate2 >= ONUPDATE_INTERVAL2 then
						TimeSinceLastUpdate2 = 0
						_, instanceType = IsInInstance()
						if instanceType == "none" then
							local facing = GetPlayerFacing()
							if facing then
								Minimap.EltruismRotate:SetRotation(-facing)
							end
							if not Minimap.EltruismRotate:IsShown() then
								Minimap.EltruismRotate:Show()
							end
						else
							if Minimap.EltruismRotate:IsShown() then
								Minimap.EltruismRotate:Hide()
							end
						end
					end
				end)
				onupdatesetup = true
			end
		else
			if Minimap.EltruismRotate then
				Minimap.EltruismRotate:Hide()
			end
			onupdatesetup = false
			Cardinals:SetScript("OnUpdate",nil)
		end
	else
		if Minimap.EltruismRotate then
			Minimap.EltruismRotate:Hide()
			Cardinals:SetScript("OnUpdate",nil)
			onupdatesetup = false
		end
	end
end
