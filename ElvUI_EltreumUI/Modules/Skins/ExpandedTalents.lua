local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local IsAddOnLoaded = _G.IsAddOnLoaded
local LoadAddOn = _G.LoadAddOn

function ElvUI_EltreumUI:ExpandedTalents()
	--Reskin Blizzard Talent frame for TBC
	if ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
		if E.db.ElvUI_EltreumUI.tbctalents.enable then
			if not IsAddOnLoaded("Blizzard_TalentUI") then
				LoadAddOn("Blizzard_TalentUI")
			end
			--assert(IsAddOnLoaded("Blizzard_TalentUI"), "Talent UI not loaded")

			--hide the scroll
			if _G.PlayerTalentFrameScrollFrameScrollBar then
				_G.PlayerTalentFrameScrollFrameScrollBar:Hide()
			end
			--increase the size of the whole frame
			if _G.PlayerTalentFrame then
				_G.PlayerTalentFrame:SetSize(376, 780)
			end
			if _G.PlayerTalentFrameScrollFrame then
				--increase the size of the actual frame that has the talent buttons
				_G.PlayerTalentFrameScrollFrame:SetSize( 280 , 580)
				--set the position
				_G.PlayerTalentFrameScrollFrame:ClearAllPoints()
				_G.PlayerTalentFrameScrollFrame:SetPoint("CENTER", _G.PlayerTalentFrame, 0, 20)
			end
			--kill stuff
			if _G.PlayerTalentFrameBackgroundTopRight then
				_G.PlayerTalentFrameBackgroundTopRight:Kill()
			end
			if _G.PlayerTalentFrameBackgroundBottomLeft then
				_G.PlayerTalentFrameBackgroundBottomLeft:Kill()
			end
			if _G.PlayerTalentFrameBackgroundBottomRight then
				_G.PlayerTalentFrameBackgroundBottomRight:Kill()
			end
			--increase the size of the background
			if _G.PlayerTalentFrameBackgroundTopLeft then
				_G.PlayerTalentFrameBackgroundTopLeft:SetSize(310 , 600)
			end
		end
	end

	--Reskin Blizzard Talent frame for Classic (was for before 1.14.0, after 1.14.0 it seems merged with tbc)
	--[[ if ElvUI_EltreumUI.Classic then
		if E.db.ElvUI_EltreumUI.tbctalents.enable then
			if not IsAddOnLoaded("Blizzard_TalentUI") then
				LoadAddOn("Blizzard_TalentUI")
			end
			assert(IsAddOnLoaded("Blizzard_TalentUI"), "Talent UI not loaded")

			--hide the scroll
			if _G.TalentFrameScrollFrameScrollBar then
				_G.TalentFrameScrollFrameScrollBar:Hide()
			end
			--increase the size of the whole frame
			if _G.TalentFrame then
				_G.TalentFrame:SetSize(376, 670)
			end
			if _G.TalentFrameScrollFrame then
				--increase the size of the actual frame that has the talent buttons
				_G.TalentFrameScrollFrame:SetSize( 280 , 470)
				--set the position
				_G.TalentFrameScrollFrame:ClearAllPoints()
				_G.TalentFrameScrollFrame:SetPoint("CENTER", _G.TalentFrame, 0, 20)
			end
			--kill stuff
			if _G.TalentFrameBackgroundTopRight then
				_G.TalentFrameBackgroundTopRight:Kill()
			end
			if _G.TalentFrameBackgroundBottomLeft then
				_G.TalentFrameBackgroundBottomLeft:Kill()
			end
			if _G.TalentFrameBackgroundBottomRight then
				_G.TalentFrameBackgroundBottomRight:Kill()
			end
			--increase the size of the background
			if _G.TalentFrameBackgroundTopLeft then
				_G.TalentFrameBackgroundTopLeft:SetSize(310 , 490)
			end
		end

	end ]]
end
