local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

local EltruismScreenShot = CreateFrame("Frame", "EltruismScreenShot")
function ElvUI_EltreumUI:AutoScreenshot()
	if E.db.ElvUI_EltreumUI.otherstuff.screenshot then

		if ElvUI_EltreumUI.Retail then
			EltruismScreenShot:RegisterEvent("ACHIEVEMENT_EARNED")
			EltruismScreenShot:RegisterEvent("CHALLENGE_MODE_COMPLETED")
			--EltruismScreenShot:RegisterEvent("PLAYER_STARTED_MOVING")
		end

		EltruismScreenShot:RegisterEvent("PLAYER_LEVEL_UP")

		EltruismScreenShot:SetScript("OnEvent", function()
			Screenshot()
		end)

	end
end

--fix master loot?
if ElvUI_EltreumUI.TBC then
	hooksecurefunc(_G.MasterLooterFrame, 'Hide', function(self)
		self:ClearAllPoints()
	end)
end
