local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local CreateFrame = _G.CreateFrame
local IsAddOnLoaded = _G.IsAddOnLoaded
local EltruismExpandedTalents = CreateFrame("Frame")

function ElvUI_EltreumUI:ExpandedTalents()
	--Reskin Blizzard Talent frame for TBC
	if E.Wrath or E.TBC or E.Classic then
		if E.db.ElvUI_EltreumUI.skins.tbctalents and not E.private.skins.blizzard.enable == false then
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

					--fix rank size
					for i =1, MAX_NUM_TALENTS do
						if _G["PlayerTalentFrameTalent"..i.."Rank"] then
							_G["PlayerTalentFrameTalent"..i.."Rank"]:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize+4, E.db.general.fontStyle)
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

					--increase the size of the background
					if PlayerTalentFrameBackgroundTopLeft then
						if E.TBC then
							--PlayerTalentFrameBackgroundTopLeft:SetSize(310 , 600)
							if PlayerTalentFrameScrollFrame.backdrop then
								PlayerTalentFrameScrollFrame.backdrop:Kill()
							end
							PlayerTalentFrameBackgroundTopLeft:ClearAllPoints()
							PlayerTalentFrameBackgroundTopLeft:SetParent(PlayerTalentFrame)
							PlayerTalentFrameBackgroundTopLeft:SetPoint("TOPLEFT", PlayerTalentFrameScrollFrame, "TOPLEFT", -8, 1)
							PlayerTalentFrameBackgroundTopLeft:SetSize(243, 431)

							PlayerTalentFrameBackgroundBottomLeft:ClearAllPoints()
							PlayerTalentFrameBackgroundBottomLeft:SetParent(PlayerTalentFrame)
							PlayerTalentFrameBackgroundBottomLeft:SetPoint("BOTTOMLEFT", PlayerTalentFrameScrollFrame, "BOTTOMLEFT", -8, -100)
							PlayerTalentFrameBackgroundBottomLeft:SetSize(243, 250)

							PlayerTalentFrameBackgroundTopRight:ClearAllPoints()
							PlayerTalentFrameBackgroundTopRight:SetParent(PlayerTalentFrame)
							PlayerTalentFrameBackgroundTopRight:SetPoint("TOPRIGHT", PlayerTalentFrameScrollFrame, "TOPRIGHT", 12, 1)
							PlayerTalentFrameBackgroundTopRight:SetSize(57, 431)

							PlayerTalentFrameBackgroundBottomRight:ClearAllPoints()
							PlayerTalentFrameBackgroundBottomRight:SetParent(PlayerTalentFrame)
							PlayerTalentFrameBackgroundBottomRight:SetPoint("BOTTOMRIGHT", PlayerTalentFrameScrollFrame, "BOTTOMRIGHT", 12, -100)
							PlayerTalentFrameBackgroundBottomRight:SetSize(57, 250)
						elseif E.Wrath then
							if PlayerTalentFrameScrollFrame.backdrop then
								PlayerTalentFrameScrollFrame.backdrop:Kill()
							end

							PlayerTalentFrameScrollFrame:SetScale(0.85)

							PlayerTalentFrameBackgroundTopLeft:ClearAllPoints()
							PlayerTalentFrameBackgroundTopLeft:SetParent(PlayerTalentFrame)
							PlayerTalentFrameBackgroundTopLeft:SetPoint("TOPLEFT", PlayerTalentFrameScrollFrame, "TOPLEFT", -15, -2)
							PlayerTalentFrameBackgroundTopLeft:SetSize(203, 467)

							PlayerTalentFrameBackgroundBottomLeft:ClearAllPoints()
							PlayerTalentFrameBackgroundBottomLeft:SetParent(PlayerTalentFrame)
							PlayerTalentFrameBackgroundBottomLeft:SetPoint("BOTTOMLEFT", PlayerTalentFrameScrollFrame, "BOTTOMLEFT", -15, 23)
							PlayerTalentFrameBackgroundBottomLeft:SetSize(203, 120)

							PlayerTalentFrameBackgroundTopRight:ClearAllPoints()
							PlayerTalentFrameBackgroundTopRight:SetParent(PlayerTalentFrame)
							PlayerTalentFrameBackgroundTopRight:SetPoint("TOPRIGHT", PlayerTalentFrameScrollFrame, "TOPRIGHT", 0, -2)
							PlayerTalentFrameBackgroundTopRight:SetSize(50 , 467)

							PlayerTalentFrameBackgroundBottomRight:ClearAllPoints()
							PlayerTalentFrameBackgroundBottomRight:SetParent(PlayerTalentFrame)
							PlayerTalentFrameBackgroundBottomRight:SetPoint("BOTTOMRIGHT", PlayerTalentFrameScrollFrame, "BOTTOMRIGHT", 0, 23)
							PlayerTalentFrameBackgroundBottomRight:SetSize(50 , 120)

						elseif E.Classic then
							--PlayerTalentFrameBackgroundTopLeft:SetSize(310 , 490)
							if PlayerTalentFrameScrollFrame.backdrop then
								PlayerTalentFrameScrollFrame.backdrop:Kill()
							end
							PlayerTalentFrameBackgroundTopLeft:ClearAllPoints()
							PlayerTalentFrameBackgroundTopLeft:SetParent(PlayerTalentFrame)
							PlayerTalentFrameBackgroundTopLeft:SetPoint("TOPLEFT", PlayerTalentFrameScrollFrame, "TOPLEFT", 0, 0)
							PlayerTalentFrameBackgroundTopLeft:SetSize(204, 374)

							PlayerTalentFrameBackgroundBottomLeft:ClearAllPoints()
							PlayerTalentFrameBackgroundBottomLeft:SetParent(PlayerTalentFrame)
							PlayerTalentFrameBackgroundBottomLeft:SetPoint("BOTTOMLEFT", PlayerTalentFrameScrollFrame, "BOTTOMLEFT", 0, -54)
							PlayerTalentFrameBackgroundBottomLeft:SetSize(204, 150)

							PlayerTalentFrameBackgroundTopRight:ClearAllPoints()
							PlayerTalentFrameBackgroundTopRight:SetParent(PlayerTalentFrame)
							PlayerTalentFrameBackgroundTopRight:SetPoint("TOPRIGHT", PlayerTalentFrameScrollFrame, "TOPRIGHT", 24, 0)
							PlayerTalentFrameBackgroundTopRight:SetSize(100, 374)

							PlayerTalentFrameBackgroundBottomRight:ClearAllPoints()
							PlayerTalentFrameBackgroundBottomRight:SetParent(PlayerTalentFrame)
							PlayerTalentFrameBackgroundBottomRight:SetPoint("BOTTOMRIGHT", PlayerTalentFrameScrollFrame, "BOTTOMRIGHT", 24, -54)
							PlayerTalentFrameBackgroundBottomRight:SetSize(100, 150)
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

							--fix the button being behind the frame
							if _G.PlayerTalentFrameCloseButton then
								_G.PlayerTalentFrameCloseButton:SetFrameStrata("HIGH")
							end

							PlayerTalentFrame:SetSize(384, 512)
							_G.GlyphFrame:Show()
							PlayerTalentFrameBackgroundTopLeft:Hide()
							PlayerTalentFrameBackgroundBottomLeft:Hide()
							PlayerTalentFrameBackgroundTopRight:Hide()
							PlayerTalentFrameBackgroundBottomRight:Hide()
							_G.PlayerTalentFrameStatusFrame:Hide()
							_G.GlyphFrame:ClearAllPoints()
							_G.GlyphFrame:SetPoint("CENTER", _G.PlayerTalentFrame, "CENTER", 0, 4)
							_G.GlyphFrame:SetFrameStrata("HIGH")
						end)
						_G.GlyphFrame:HookScript("OnHide", function()
							PlayerTalentFrame:SetSize(376, 780)
							_G.GlyphFrame:Hide()
							_G.PlayerTalentFrameStatusFrame:Show()
							PlayerTalentFrameBackgroundTopLeft:Show()
							PlayerTalentFrameBackgroundBottomLeft:Show()
							PlayerTalentFrameBackgroundTopRight:Show()
							PlayerTalentFrameBackgroundBottomRight:Show()
						end)

						--fix role button on glyph frame
						if _G.PlayerTalentFrameRoleButton then
							_G.PlayerTalentFrameRoleButton:ClearAllPoints()
							_G.PlayerTalentFrameRoleButton:SetPoint("TOPLEFT", _G.PlayerTalentFrame, "TOPLEFT", 20,-20)
							_G.PlayerTalentFrameRoleButton:SetParent(_G.PlayerTalentFrameScrollFrame)
						end
					end

					-- fix talent frame position due to expanded character bg
					_G.PlayerTalentFrame:HookScript("OnShow", function()
						if E.db.ElvUI_EltreumUI.skins.classicarmory then
							if _G.CharacterModelFrame:IsVisible() then
								_G.PlayerTalentFrame:ClearAllPoints()
								_G.PlayerTalentFrame:SetPoint("TOPLEFT", _G.CharacterFrame, "TOPRIGHT", -30, 0)
								_G.PlayerTalentFrame:SetScale(E.db.ElvUI_EltreumUI.skins.expandedtalentscale)
							end
						end
					end)

				end
			end)
		end
	end
end
