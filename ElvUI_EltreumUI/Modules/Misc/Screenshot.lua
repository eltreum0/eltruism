local E = unpack(ElvUI)
local _G = _G
local CreateFrame = _G.CreateFrame
local Screenshot = _G.Screenshot

local EltruismScreenShot = CreateFrame("Frame", "EltruismScreenShot")
function ElvUI_EltreumUI:AutoScreenshot()
	if E.db.ElvUI_EltreumUI.otherstuff.screenshot then
		if E.Retail then
			EltruismScreenShot:RegisterEvent("CHALLENGE_MODE_COMPLETED")
		end
		if E.Retail or E.Cata then
			EltruismScreenShot:RegisterEvent("ACHIEVEMENT_EARNED")
		end
		EltruismScreenShot:RegisterEvent("PLAYER_LEVEL_UP")
		EltruismScreenShot:SetScript("OnEvent", function(_,event)
			if event == "PLAYER_LEVEL_UP" then
				E:Delay(2, function() Screenshot() end)
			else
				E:Delay(1, function() Screenshot() end)
			end
		end)
	end
end
