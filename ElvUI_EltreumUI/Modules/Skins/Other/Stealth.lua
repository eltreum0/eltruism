local E = unpack(ElvUI)
local _G = _G
local UIFrameFadeIn = _G.UIFrameFadeIn
local UIFrameFadeOut = _G.UIFrameFadeOut
local UIParent = _G.UIParent
local IsStealthed = _G.IsStealthed
local CreateFrame = _G.CreateFrame

-- Create Stealth Overlay Frame
local StealthOptionsFrame = CreateFrame("Frame", "EltruismStealthOverlay", E.UIParent)
StealthOptionsFrame:SetPoint("TOPLEFT")
StealthOptionsFrame:SetPoint("BOTTOMRIGHT")
StealthOptionsFrame:SetFrameLevel(0)
StealthOptionsFrame:SetFrameStrata("BACKGROUND")
StealthOptionsFrame.tex = StealthOptionsFrame:CreateTexture()
StealthOptionsFrame.tex:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\StealthOverlay.tga")
StealthOptionsFrame.tex:SetAllPoints(UIParent)
StealthOptionsFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
StealthOptionsFrame:RegisterEvent("UPDATE_STEALTH")
StealthOptionsFrame:Hide()

-- Setup the Stealth Overlay Options
function ElvUI_EltreumUI:StealthOptions()
	if E.db.ElvUI_EltreumUI.skins.stealtheffect then
		StealthOptionsFrame:SetScript("OnEvent", function(_, event)
			if (event == "PLAYER_ENTERING_WORLD") then
				if IsStealthed() then
					StealthOptionsFrame:Show()
					UIFrameFadeIn(StealthOptionsFrame, 0.125, 0, 1)
				else
					StealthOptionsFrame:Hide()
				end
			elseif (event == "UPDATE_STEALTH") then
				if IsStealthed() then
					StealthOptionsFrame:Show()
					UIFrameFadeIn(StealthOptionsFrame, 0.125, 0, 1)
				else
					UIFrameFadeOut(StealthOptionsFrame, 0.1, 1, 0)
				end
			end
		end)
	elseif E.db.ElvUI_EltreumUI.skins.screenvignette then
		StealthOptionsFrame:Show()
		StealthOptionsFrame:SetAlpha(E.db.ElvUI_EltreumUI.skins.screenvignettealpha)
		StealthOptionsFrame:UnregisterAllEvents()
		ElvUI_EltreumUI:UnregisterEvent('UPDATE_STEALTH')
	else
		StealthOptionsFrame:Hide()
	end
end
