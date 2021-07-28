local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

local EltruismScreenShot = CreateFrame("Frame", "EltruismScreenShot")
EltruismScreenShot:RegisterEvent("ACHIEVEMENT_EARNED")
EltruismScreenShot:RegisterEvent("CHALLENGE_MODE_COMPLETED")
EltruismScreenShot:RegisterEvent("PLAYER_LEVEL_UP")
EltruismScreenShot:SetScript("OnEvent", function()
	Screenshot()	
end)
