local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G

local EltruismExpandedTalents = CreateFrame("Frame")

function ElvUI_EltreumUI:ExpandedTalents()
	--Reskin Blizzard Talent frame for TBC
	if E.TBC or E.Classic then
		if E.db.ElvUI_EltreumUI.tbctalents.enable and not E.private.skins.blizzard.enable == false then
			EltruismExpandedTalents:RegisterEvent("ADDON_LOADED")
			EltruismExpandedTalents:RegisterEvent("PLAYER_ENTERING_WORLD")
			EltruismExpandedTalents:SetScript("OnEvent", function(_,_,arg)
				if arg == "Blizzard_TalentUI" or IsAddOnLoaded("Blizzard_TalentUI") then
					EltruismExpandedTalents:UnregisterAllEvents()
					--hide the scroll
					if _G.PlayerTalentFrameScrollFrameScrollBar then
						_G.PlayerTalentFrameScrollFrameScrollBar:Hide()
					end
					--increase the size of the whole frame
					if _G.PlayerTalentFrame then
						--_G.PlayerTalentFrame:SetScale(0.8,0.8) --should be around this scale for wrath
						if E.TBC then
							_G.PlayerTalentFrame:SetSize(376, 780)
						elseif E.Classic then
							_G.PlayerTalentFrame:SetSize(376, 670)
						end
					end
					if _G.PlayerTalentFrameScrollFrame then
						--increase the size of the actual frame that has the talent buttons
						if E.TBC then
							_G.PlayerTalentFrameScrollFrame:SetSize( 280 , 580)
						elseif E.Classic then
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
						if E.TBC then
							_G.PlayerTalentFrameBackgroundTopLeft:SetSize(310 , 600)
						elseif E.Classic then
							_G.PlayerTalentFrameBackgroundTopLeft:SetSize(310 , 490)
						end
					end
					--hide the close button (only shows up for some people?)
					if _G.PlayerTalentFrameCancelButton then
						_G.PlayerTalentFrameCancelButton:Hide()
					end
				end
			end)
		end
	end
end
