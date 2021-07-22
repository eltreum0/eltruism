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
	EltruismTimeToArrive.TimeText = EltruismTimeToArrive:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
	function ElvUI_EltreumUI:WaypointTimeToArrive()
		if E.db.ElvUI_EltreumUI.waypointetasetting.enable then
			--set the throttle
			local ONUPDATE_INTERVAL = 1
			local TimeSinceLastUpdate = 0

			EltruismTimeToArrive.TimeText:SetJustifyV("TOP")
			EltruismTimeToArrive.TimeText:SetSize(0, 26)
			EltruismTimeToArrive.TimeText:SetPoint("TOP", "SuperTrackedFrame", "BOTTOM", 0, -40)
			EltruismTimeToArrive.TimeText:SetTextColor(1, 1, 1)
			--set font to be elvui's
			EltruismTimeToArrive.TimeText:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, "OUTLINE")
			EltruismTimeToArrive.TimeText:SetParent("SuperTrackedFrame")
			EltruismTimeToArrive:SetParent("SuperTrackedFrame")

			--use throttled onupdate to udpate the text (once per second)
			EltruismTimeToArrive:SetScript("OnUpdate", function(self, elapsed)
				TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
				if TimeSinceLastUpdate >= ONUPDATE_INTERVAL then
					TimeSinceLastUpdate = 0
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

					if  minutes == 0 and seconds == 0 then
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





--original version
--[[
--Conversion of Time to Arrive weakaura
--Create the frame to display the text
if ElvUI_EltreumUI.Retail then
	local WaypointTimeToArriveFrame = CreateFrame("Frame", "WaypointTimeToArriveText", UIParent)
	WaypointTimeToArriveFrame.TimeText = WaypointTimeToArriveFrame:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
	WaypointTimeToArriveFrame.TimeText:SetJustifyV("TOP")
	WaypointTimeToArriveFrame.TimeText:SetSize(0, 26)
	WaypointTimeToArriveFrame.TimeText:SetPoint("TOP", "SuperTrackedFrame", "BOTTOM", 0, -40)
	WaypointTimeToArriveFrame.TimeText:SetTextColor(1, 1, 1)
	--font test
	WaypointTimeToArriveFrame.TimeText:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, "OUTLINE")
	WaypointTimeToArriveFrame.TimeText:SetParent("SuperTrackedFrame")
	WaypointTimeToArriveFrame:SetParent("SuperTrackedFrame")

	--Create the function which calculates the time
	function ElvUI_EltreumUI:WaypointTimeToArrive()
		if E.db.ElvUI_EltreumUI.waypointetasetting.enable then
		local speed = GetUnitSpeed("player")
		local distance = C_Navigation.GetDistance()
		local seconds = 0
		local minutes = 0
			if speed > 0 then
				local eta= math.abs(distance / speed)
				if eta > 600 then
					minutes = string.format("%02.f", math.floor(eta/60 ))
					seconds = string.format("%02.f", math.floor(eta - minutes *60))
					else if eta < 600 and eta > 10 then
						minutes = string.format("%01.f", math.floor(eta/60))
						seconds = string.format("%02.f", math.floor(eta - minutes *60))
						else if eta < 10 then
							minutes = string.format("%01.f", math.floor(eta/60))
							seconds = string.format("%1.d", math.floor(eta - minutes *60))
							else
							minutes = string.format("%02.f", math.floor(eta/60))
							seconds = string.format("%02.f", math.floor(eta - minutes *60))
						end
					end
				end
			end
			if  minutes == 0 and seconds == 0 then
				WaypointTimeToArriveFrame.TimeText:SetText("***")
			else if minutes < "01" and seconds > "0" then
				WaypointTimeToArriveFrame.TimeText:SetText(seconds.."s")
				else
				WaypointTimeToArriveFrame.TimeText:SetText(minutes.."m"..":"..seconds.."s")
				end
			end
		end
	end
	local function OnUpdateTimer(self, elapsed)
			ElvUI_EltreumUI:WaypointTimeToArrive(self, elapsed)
	end
	WaypointTimeToArriveFrame:SetScript("OnUpdate", OnUpdateTimer)
end
]]--
