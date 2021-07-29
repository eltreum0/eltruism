local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

local EltruismScreenShot = CreateFrame("Frame", "EltruismScreenShot")
if ElvUI_EltreumUI.Retail then
	EltruismScreenShot:RegisterEvent("ACHIEVEMENT_EARNED")
	EltruismScreenShot:RegisterEvent("CHALLENGE_MODE_COMPLETED")
end
EltruismScreenShot:RegisterEvent("PLAYER_LEVEL_UP")
EltruismScreenShot:SetScript("OnEvent", function()
	Screenshot()	
end)
