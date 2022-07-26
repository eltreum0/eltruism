local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local CreateFrame = _G.CreateFrame
local IsAddOnLoaded = _G.IsAddOnLoaded

local EltruismExpandedTalents = CreateFrame("Frame")
function ElvUI_EltreumUI:ExpandedTalents()
	--Reskin Blizzard Talent frame for TBC
	if E.Wrath or E.TBC or E.Classic then
		if E.db.ElvUI_EltreumUI.tbctalents.enable and not E.private.skins.blizzard.enable == false then
			EltruismExpandedTalents:RegisterEvent("ADDON_LOADED")
			EltruismExpandedTalents:RegisterEvent("PLAYER_ENTERING_WORLD")
			EltruismExpandedTalents:SetScript("OnEvent", function(_,_,arg)
				if arg == "Blizzard_TalentUI" or IsAddOnLoaded("Blizzard_TalentUI") then
					local PlayerTalentFrame = _G.PlayerTalentFrame
					local PlayerTalentFrameScrollFrameScrollBar = _G.PlayerTalentFrameScrollFrameScrollBar
					local PlayerTalentFrameScrollFrame = _G.PlayerTalentFrameScrollFrame
					local PlayerTalentFrameBackgroundTopRight = _G.PlayerTalentFrameBackgroundTopRight
					local PlayerTalentFrameBackgroundBottomLeft = _G.PlayerTalentFrameBackgroundBottomLeft
					local PlayerTalentFrameBackgroundBottomRight = _G.PlayerTalentFrameBackgroundBottomRight
					local PlayerTalentFrameBackgroundTopLeft = _G.PlayerTalentFrameBackgroundTopLeft
					local PlayerTalentFrameCancelButton = _G.PlayerTalentFrameCancelButton

					EltruismExpandedTalents:UnregisterAllEvents()
					--hide the scroll
					if PlayerTalentFrameScrollFrameScrollBar then
						PlayerTalentFrameScrollFrameScrollBar:ClearAllPoints()
						PlayerTalentFrameScrollFrameScrollBar:Hide()
					end
					--increase the size of the whole frame
					if PlayerTalentFrame then
						--PlayerTalentFrame:SetScale(0.8,0.8) --should be around this scale for wrath
						if E.Wrath or E.TBC then
							PlayerTalentFrame:SetSize(376, 780)
						elseif E.Classic then
							PlayerTalentFrame:SetSize(376, 670)
						end
					end
					if PlayerTalentFrameScrollFrame then
						--increase the size of the actual frame that has the talent buttons
						if E.TBC then
							PlayerTalentFrameScrollFrame:SetSize( 280 , 580)
						elseif E.Wrath then
							PlayerTalentFrameScrollFrame:SetSize( 280 , 720)
						elseif E.Classic then
							PlayerTalentFrameScrollFrame:SetSize( 280 , 470)
						end
						--set the position
						PlayerTalentFrameScrollFrame:ClearAllPoints()
						PlayerTalentFrameScrollFrame:SetPoint("CENTER", PlayerTalentFrame, 0, 20)
					end
					--kill stuff
					if PlayerTalentFrameBackgroundTopRight then
						PlayerTalentFrameBackgroundTopRight:Kill()
					end
					if PlayerTalentFrameBackgroundBottomLeft then
						PlayerTalentFrameBackgroundBottomLeft:Kill()
					end
					if PlayerTalentFrameBackgroundBottomRight then
						PlayerTalentFrameBackgroundBottomRight:Kill()
					end
					--increase the size of the background
					if PlayerTalentFrameBackgroundTopLeft then
						if E.TBC then
							PlayerTalentFrameBackgroundTopLeft:SetSize(310 , 600)
						elseif E.Wrath then
							if PlayerTalentFrameScrollFrame.backdrop then
								PlayerTalentFrameScrollFrame.backdrop:Kill()
							end

							PlayerTalentFrameScrollFrame:SetScale(0.85)

							PlayerTalentFrameBackgroundTopLeft:ClearAllPoints()
							PlayerTalentFrameBackgroundTopLeft:SetParent(PlayerTalentFrame)
							PlayerTalentFrameBackgroundTopLeft:SetSize(310 , 600)
							PlayerTalentFrameBackgroundTopLeft:SetPoint("CENTER", PlayerTalentFrame, "CENTER", -10, 20)
						elseif E.Classic then
							PlayerTalentFrameBackgroundTopLeft:SetSize(310 , 490)
						end
					end
					--hide the close button (only shows up for some people?)
					if PlayerTalentFrameCancelButton then
						PlayerTalentFrameCancelButton:Hide()
					end

					-- fix glyph size
					if E.Wrath then
						LoadAddOn("Blizzard_GlyphUI")
						_G.GlyphFrame:SetParent(_G.PlayerTalentFrame)

						_G.GlyphFrame:HookScript("OnShow", function()
							PlayerTalentFrame:SetSize(384, 512)
							_G.GlyphFrame:Show()
							PlayerTalentFrameBackgroundTopLeft:Hide()
							_G.GlyphFrame:ClearAllPoints()
							_G.GlyphFrame:SetPoint("CENTER", _G.PlayerTalentFrame)
						end)
						_G.GlyphFrame:HookScript("OnHide", function()
							PlayerTalentFrame:SetSize(376, 780)
							_G.GlyphFrame:Hide()
							PlayerTalentFrameBackgroundTopLeft:Show()
						end)
					end
				end
			end)
		end
	end
end
