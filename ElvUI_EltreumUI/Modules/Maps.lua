local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local GetUnitSpeed = _G.GetUnitSpeed
local C_Navigation = _G.C_Navigation
local math = _G.math
local string = _G.string
local CreateFrame = _G.CreateFrame
local UIParent = _G.UIParent

--Conversion of Time to Arrive weakaura (new version)
if ElvUI_EltreumUI.Retail then
	local EltruismTimeToArrive = CreateFrame("Frame", "EltruismTimeToArrive", UIParent)
	local autopin = CreateFrame("Frame")
	autopin:RegisterEvent("USER_WAYPOINT_UPDATED")
	EltruismTimeToArrive.TimeText = EltruismTimeToArrive:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
	function ElvUI_EltreumUI:WaypointTimeToArrive()
		if E.db.ElvUI_EltreumUI.waypointetasetting.enable then
			--set the throttle
			local ONUPDATE_INTERVAL = 1
			local TimeSinceLastUpdate = 0
			_G.SuperTrackedFrame.DistanceText:SetTextColor(1,1,1)

			EltruismTimeToArrive.TimeText:SetJustifyV("TOP")
			EltruismTimeToArrive.TimeText:SetSize(0, 26)
			EltruismTimeToArrive.TimeText:SetPoint("TOP", "SuperTrackedFrame", "BOTTOM", 0, -40)
			EltruismTimeToArrive.TimeText:SetTextColor(1, 1, 1)
			--set font to be elvui's
			_G.SuperTrackedFrame.DistanceText:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, "OUTLINE")
			EltruismTimeToArrive.TimeText:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, "OUTLINE")
			EltruismTimeToArrive.TimeText:SetParent("SuperTrackedFrame")
			EltruismTimeToArrive:SetParent("SuperTrackedFrame")

			autopin:SetScript("OnEvent", function(self, event, ...)
				if event == "USER_WAYPOINT_UPDATED" and C_Map.HasUserWaypoint() == true then
					C_Timer.After(0, function() C_SuperTrack.SetSuperTrackedUserWaypoint(true) end)
				end
			end)

			--use throttled onupdate to udpate the text (once per second)
			EltruismTimeToArrive:SetScript("OnUpdate", function(self, elapsed)
				TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
				if TimeSinceLastUpdate >= ONUPDATE_INTERVAL then
					TimeSinceLastUpdate = 0

					--remove max distance
					do
						function SuperTrackedFrame:GetTargetAlphaBaseValue()
							local d = C_Navigation.GetDistance()
							if (d >= 40 ) then
								return 1
							else
								return 0
							end
						end
					end

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

					if minutes == 0 and seconds == 0 then
						EltruismTimeToArrive.TimeText:SetText("***")
					elseif minutes < "01" and seconds > "0" then
						EltruismTimeToArrive.TimeText:SetText(seconds.."s")
					else
						EltruismTimeToArrive.TimeText:SetText(minutes.."m"..":"..seconds.."s")
					end
				end
			end)
		end
	end
end
