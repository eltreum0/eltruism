local _G = _G
local unpack = _G.unpack
local select = _G.select
local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local pairs = _G.pairs
local SetCVar = _G.SetCVar
local IsAddOnLoaded = _G.IsAddOnLoaded
local CreateFrame = _G.CreateFrame
local frame = _G.frame
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
StealthOptionsFrame.tex:SetAllPoints(frame)
-- set to hide so it doesnt show on characters that dont have stealth
StealthOptionsFrame:Hide()

-- Setup the Stealth Overlay Options
function ElvUI_EltreumUI:StealthOptions()
	if E.private.ElvUI_EltreumUI.stealthOptions.stealtheffect then
		--Script the frame, ty wowpedia for examples
		StealthOptionsFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
		StealthOptionsFrame:RegisterEvent("UPDATE_STEALTH")
		StealthOptionsFrame:HookScript("OnEvent", function(__, event)
		  if (event == "PLAYER_ENTERING_WORLD") then
			if IsStealthed() then
				StealthOptionsFrame:Show()
			end
		  elseif (event == "UPDATE_STEALTH") then
			if IsStealthed() then
				UIFrameFadeIn(StealthOptionsFrame, 0.125, 0, 1)
			else
				UIFrameFadeOut(StealthOptionsFrame, 0.1, 1, 0)
			end
		  end
		end)
	end
end
