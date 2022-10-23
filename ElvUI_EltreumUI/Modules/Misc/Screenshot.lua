local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local CreateFrame = _G.CreateFrame
local Screenshot = _G.Screenshot

local EltruismScreenShot = CreateFrame("Frame", "EltruismScreenShot")
function ElvUI_EltreumUI:AutoScreenshot()
	if E.db.ElvUI_EltreumUI.otherstuff.screenshot then
		if E.Retail then
			EltruismScreenShot:RegisterEvent("CHALLENGE_MODE_COMPLETED")
		end
		if E.Retail or E.Wrath then
			EltruismScreenShot:RegisterEvent("ACHIEVEMENT_EARNED")
		end
		EltruismScreenShot:RegisterEvent("PLAYER_LEVEL_UP")
		EltruismScreenShot:SetScript("OnEvent", function(_,event)
			C_Timer.After(1, function() Screenshot() end)
		end)
	end
end



local healthbar = CreateFrame("StatusBar")
healthbar:SetValue(0)

healthbar:SetSize(200,20)
healthbar:SetStatusBarTexture(E.media.blankTex)

healthbar:SetPoint("CENTER", UIParent, "CENTER", 0, 100)
healthbar:SetStatusBarColor(0, 0.7, 0)


local healthbarText = CreateFrame("Frame", nil, healthbar)
healthbarText:SetPoint("CENTER", healthbar)
healthbarText:SetWidth(1)
healthbarText:SetHeight(1)
healthbarText:SetFrameStrata('DIALOG')
healthbar.Text = healthbarText:CreateFontString(nil, "ARTWORK", "GameFontNormal")
healthbar.Text:SetTextColor(1, 1, 1)
healthbar.Text:SetPoint("CENTER")
healthbar.Text:SetJustifyH("CENTER")
healthbar.Text:SetJustifyV("CENTER")


local test = CreateFrame("FRAME")
--test:RegisterEvent("UNIT_HEALTH")
--test:RegisterEvent("PLAYER_TARGET_CHANGED")
test:SetScript("OnUpdate", function()
	if UnitExists("target") then
		print(UnitHealth("target"))
		healthbar:SetMinMaxValues(0, UnitHealthMax("Target"))
		healthbar:SetValue(UnitHealth("target"))
		healthbar:Show()
		--healthbar.Text:SetText(UnitHealth("target"))
		healthbar.Text:SetText(E:GetFormattedText('PERCENT', UnitHealth("target"), UnitHealthMax("target")))




		if UnitHealth("target") < 60000 then
			healthbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdroptexture))
		else
			healthbar:SetStatusBarTexture(E.media.blankTex)
		end
	end
end)

