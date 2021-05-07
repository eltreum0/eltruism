local _G = _G
local unpack = _G.unpack
local select = _G.select
local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local pairs = _G.pairs
local SetCVar = _G.SetCVar
local IsAddOnLoaded = _G.IsAddOnLoaded
local CreateFrame = _G.CreateFrame
local UIParent = _G.UIParent
local math = _G.math
local string = _G.string
local GetUnitSpeed = _G.GetUnitSpeed
local C_Navigation = _G.C_Navigation

--Conversion of Time to Arrive weakaura

--Create the frame to display the text
local WaypointTimeToArriveFrame = CreateFrame("Frame", "WaypointTimeToArriveText", UIParent)
WaypointTimeToArriveFrame.TimeText = WaypointTimeToArriveFrame:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
WaypointTimeToArriveFrame.TimeText:SetJustifyV("TOP")
WaypointTimeToArriveFrame.TimeText:SetSize(0, 26)
WaypointTimeToArriveFrame.TimeText:SetPoint("TOP", "SuperTrackedFrame", "BOTTOM", 0, -40)
WaypointTimeToArriveFrame.TimeText:SetTextColor(1, 1, 1)
--WaypointTimeToArriveFrame.TimeText:SetFont(E.LSM:Fetch('font', db.font), db.size, db.outline)
--WaypointTimeToArriveFrame.TimeText:SetFont("Interface\\addons\\ElvUI_EltreumUI\\Media\\Fonts\\Kimberley.otf", 12)
WaypointTimeToArriveFrame.TimeText:SetParent("SuperTrackedFrame")

--Create the function which calculates the time
function ElvUI_EltreumUI:WaypointTimeToArrive()
	if E.private.ElvUI_EltreumUI.waypointetasetting.enable then
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

