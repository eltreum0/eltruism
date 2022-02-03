local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local IsAddOnLoaded = _G.IsAddOnLoaded
local LoadAddOn = _G.LoadAddOn

function ElvUI_EltreumUI:ExpandedTalents()
	--Reskin Blizzard Talent frame for TBC
	if ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
		if E.db.ElvUI_EltreumUI.tbctalents.enable then
			local EltruismExpandedTalents = CreateFrame("Frame")
			EltruismExpandedTalents:RegisterEvent("ADDON_LOADED")
			EltruismExpandedTalents:SetScript("OnEvent", function(_,_,arg)
				if arg == "Blizzard_TalentUI" then
					--hide the scroll
					if _G.PlayerTalentFrameScrollFrameScrollBar then
						_G.PlayerTalentFrameScrollFrameScrollBar:Hide()
					end
					--increase the size of the whole frame
					if _G.PlayerTalentFrame then
						if ElvUI_EltreumUI.TBC then
							_G.PlayerTalentFrame:SetSize(376, 780)
						elseif ElvUI_EltreumUI.Classic then
							_G.PlayerTalentFrame:SetSize(376, 670)
						end
					end
					if _G.PlayerTalentFrameScrollFrame then
						--increase the size of the actual frame that has the talent buttons
						if ElvUI_EltreumUI.TBC then
							_G.PlayerTalentFrameScrollFrame:SetSize( 280 , 580)
						elseif ElvUI_EltreumUI.Classic then
							_G.PlayerTalentFrameScrollFrame:SetSize( 280 , 470)
						end
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
						if ElvUI_EltreumUI.TBC then
							_G.PlayerTalentFrameBackgroundTopLeft:SetSize(310 , 600)
						elseif ElvUI_EltreumUI.Classic then
							_G.PlayerTalentFrameBackgroundTopLeft:SetSize(310 , 490)
						end
					end
				end
			end)
		end
	end
end
