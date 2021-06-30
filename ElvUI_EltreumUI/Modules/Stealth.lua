local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

local _G = _G
local CreateFrame = _G.CreateFrame
local UIParent = _G.UIParent
local IsStealthed = _G.IsStealthed
local UIFrameFadeIn = _G.UIFrameFadeIn
local UIFrameFadeOut = _G.UIFrameFadeOut

-- Create Stealth Overlay Frame
local StealthOptionsFrame = CreateFrame("Frame", "StealthOverlay", E.UIParent)
StealthOptionsFrame:Point("TOPLEFT")
StealthOptionsFrame:Point("BOTTOMRIGHT")
StealthOptionsFrame:SetFrameLevel(0)
StealthOptionsFrame:SetFrameStrata("BACKGROUND")
StealthOptionsFrame.tex = StealthOptionsFrame:CreateTexture()
StealthOptionsFrame.tex:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\StealthOverlay.tga")
StealthOptionsFrame.tex:SetAllPoints(UIParent)
StealthOptionsFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
StealthOptionsFrame:RegisterEvent("UPDATE_STEALTH")
-- set to hide so it doesnt show on characters that dont have stealth
StealthOptionsFrame:Hide()

-- Setup the Stealth Overlay Options
function ElvUI_EltreumUI:StealthOptions()
	if E.db.ElvUI_EltreumUI.stealthOptions.stealtheffect then
		--Script the frame, ty wowpedia for examples
		StealthOptionsFrame:HookScript("OnEvent", function(__, event)
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
	end
end
