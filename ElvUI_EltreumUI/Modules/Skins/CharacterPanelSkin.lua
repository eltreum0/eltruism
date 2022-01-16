local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local CreateFrame = _G.CreateFrame
local unpack = _G.unpack
--local UnitClass = _G.UnitClass --currently unused
local R, G, B = unpack(E.media.rgbvaluecolor)

--attempt at recreating a similar character panel to retail
local CharacterFrame = _G.CharacterFrame
CharacterFrame.Text2 = CharacterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
function ElvUI_EltreumUI:ExpandedCharacterStats()
	if ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
		if E.db.ElvUI_EltreumUI.skins.classicarmory then
			if CharacterFrame then
				CharacterFrame:SetSize(600, 505)

				CharacterFrame.Text = CharacterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
				CharacterFrame.StatusLine = CreateFrame("StatusBar", "EltruismCharacterBar2", CharacterFrame)

				CharacterFrame.StatusLine2 = CreateFrame("StatusBar", "EltruismCharacterBar1", CharacterFrame)
				CharacterFrame.Text3 = CharacterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
				CharacterFrame.StatusLine3 = CreateFrame("StatusBar", "EltruismCharacterBar2", CharacterFrame)


				CharacterFrame.Text:SetSize(418, 72)
				CharacterFrame.Text:SetPoint("TOP", CharacterFrame, "TOP", 150, 0)
				CharacterFrame.Text:SetTextColor(1, 1, 1)
				CharacterFrame.Text:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, "OUTLINE")
				CharacterFrame.Text:SetText("Item Level")


				CharacterFrame.StatusLine:SetSize(150, 3)
				CharacterFrame.StatusLine:SetPoint("CENTER", CharacterFrame.Text, "CENTER", 0, -15)
				CharacterFrame.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				CharacterFrame.StatusLine:SetStatusBarColor(R, G, B, 1)

				CharacterFrame.Text2:SetSize(418, 72)
				CharacterFrame.Text2:SetPoint("TOP", CharacterFrame, "TOP", 150, -45)
				CharacterFrame.Text2:SetTextColor(R, G, B)
				CharacterFrame.Text2:SetFont(E.LSM:Fetch("font", E.db.general.font), 28, "OUTLINE")

				CharacterFrame.StatusLine2:SetFrameStrata("LOW")
				CharacterFrame.StatusLine2:SetSize(200, 30)
				CharacterFrame.StatusLine2:SetPoint("CENTER", CharacterFrame.Text2, "CENTER", 0, 0)
				CharacterFrame.StatusLine2:SetStatusBarTexture(E.Media.Textures.Highlight)
				CharacterFrame.StatusLine2:SetStatusBarColor(1, 1, 1, 1)

				CharacterFrame.Text3:SetSize(418, 72)
				CharacterFrame.Text3:SetPoint("TOP", CharacterFrame, "TOP", 150, -80)
				CharacterFrame.Text3:SetTextColor(1, 1, 1)
				CharacterFrame.Text3:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, "OUTLINE")
				CharacterFrame.Text3:SetText("Attributes")


				CharacterFrame.StatusLine3:SetSize(150, 3)
				CharacterFrame.StatusLine3:SetPoint("CENTER", CharacterFrame.Text3, "CENTER", 0, -15)
				CharacterFrame.StatusLine3:SetStatusBarTexture(E.Media.Textures.Highlight)
				CharacterFrame.StatusLine3:SetStatusBarColor(R, G, B, 1)

				_G.CharacterModelFrame:ClearAllPoints()
				_G.CharacterModelFrame:SetPoint("RIGHT", CharacterFrame, "CENTER", -20, 0)
				_G.CharacterModelFrame:SetSize(200, 300)

				_G.CharacterModelFrameRotateRightButton:Hide()
				_G.CharacterModelFrameRotateLeftButton:Hide()

				if ElvUI_EltreumUI.TBC then
					_G.PlayerStatFrameLeftDropDown:ClearAllPoints()
					_G.PlayerStatFrameLeftDropDown:SetPoint("TOP", CharacterFrame, "TOP", 150, -160)
					_G.PlayerStatFrameLeftDropDown:SetParent(CharacterFrame)
					_G.MagicResFrame1:ClearAllPoints()
					_G.MagicResFrame1:SetPoint("LEFT", _G.PlayerStatFrameLeftDropDown, "LEFT", -10, 0)
					_G.MagicResFrame1:SetParent(_G.PlayerStatFrameLeft1)
					_G.MagicResFrame2:SetParent(_G.PlayerStatFrameLeft1)
					_G.MagicResFrame3:SetParent(_G.PlayerStatFrameLeft1)
					_G.MagicResFrame4:SetParent(_G.PlayerStatFrameLeft1)
					_G.MagicResFrame5:SetParent(_G.PlayerStatFrameLeft1)
				elseif ElvUI_EltreumUI.Classic then
					_G.MagicResFrame1:ClearAllPoints()
					_G.MagicResFrame1:SetPoint("LEFT", _G.CharacterStatFrame1, "LEFT", -30, -8)
					_G.MagicResFrame1:SetParent(_G.CharacterStatFrame1)
					_G.MagicResFrame2:SetParent(_G.CharacterStatFrame1)
					_G.MagicResFrame3:SetParent(_G.CharacterStatFrame1)
					_G.MagicResFrame4:SetParent(_G.CharacterStatFrame1)
					_G.MagicResFrame5:SetParent(_G.CharacterStatFrame1)
				end

				if ElvUI_EltreumUI.TBC then
					_G.PlayerStatFrameLeft1:ClearAllPoints()
					_G.PlayerStatFrameLeft1:SetPoint("TOP", CharacterFrame, "TOP", 150, -185)
					_G.PlayerStatFrameLeft1:SetParent(CharacterFrame)
					_G.PlayerStatFrameLeft2:SetParent(_G.PlayerStatFrameLeft1)
					_G.PlayerStatFrameLeft3:SetParent(_G.PlayerStatFrameLeft1)
					_G.PlayerStatFrameLeft4:SetParent(_G.PlayerStatFrameLeft1)
					_G.PlayerStatFrameLeft5:SetParent(_G.PlayerStatFrameLeft1)
					_G.PlayerStatFrameLeft6:SetParent(_G.PlayerStatFrameLeft1)
				elseif ElvUI_EltreumUI.Classic then
					_G.CharacterStatFrame1:ClearAllPoints()
					_G.CharacterStatFrame1:SetPoint("TOP", CharacterFrame, "TOP", 150, -185)
					_G.CharacterStatFrame1:SetParent(CharacterFrame)
					_G.CharacterStatFrame2:SetParent(_G._G.CharacterStatFrame1)
					_G.CharacterStatFrame3:SetParent(_G._G.CharacterStatFrame1)
					_G.CharacterStatFrame4:SetParent(_G._G.CharacterStatFrame1)
					_G.CharacterStatFrame5:SetParent(_G._G.CharacterStatFrame1)
					_G.CharacterArmorFrame:SetParent(_G._G.CharacterStatFrame1)
				end

				if ElvUI_EltreumUI.TBC then
					_G.PlayerStatFrameRightDropDown:ClearAllPoints()
					_G.PlayerStatFrameRightDropDown:SetPoint("TOP", CharacterFrame, "TOP", 150, -270)
					_G.PlayerStatFrameRightDropDown:SetParent(CharacterFrame)
					_G.PlayerStatFrameRight1:ClearAllPoints()
					_G.PlayerStatFrameRight1:SetPoint("TOP", CharacterFrame, "TOP", 150, -295)
					_G.PlayerStatFrameRight1:SetParent(CharacterFrame)
					_G.PlayerStatFrameRight2:SetParent(_G.PlayerStatFrameRight1)
					_G.PlayerStatFrameRight3:SetParent(_G.PlayerStatFrameRight1)
					_G.PlayerStatFrameRight4:SetParent(_G.PlayerStatFrameRight1)
					_G.PlayerStatFrameRight5:SetParent(_G.PlayerStatFrameRight1)
					_G.PlayerStatFrameRight6:SetParent(_G.PlayerStatFrameRight1)
				elseif ElvUI_EltreumUI.Classic then
					_G.CharacterAttackFrame:ClearAllPoints()
					_G.CharacterAttackFrame:SetPoint("TOP", CharacterFrame, "TOP", 150, -295)
					_G.CharacterAttackFrame:SetParent(CharacterFrame)
					_G.CharacterAttackPowerFrame:SetParent(_G._G.CharacterStatFrame1)
					_G.CharacterDamageFrame:SetParent(_G._G.CharacterStatFrame1)
					_G.CharacterRangedAttackFrame:SetParent(_G._G.CharacterStatFrame1)
					_G.CharacterRangedAttackPowerFrame:SetParent(_G._G.CharacterStatFrame1)
					_G.CharacterRangedDamageFrame:SetParent(_G._G.CharacterStatFrame1)
				end
				_G.SkillFrame:SetHeight(400)
				_G.SkillDetailScrollChildFrame:ClearAllPoints()
				_G.SkillDetailScrollChildFrame:SetPoint("BOTTOMLEFT", CharacterFrame, "BOTTOMLEFT", 30, 150)
				_G.SkillDetailScrollChildFrame:SetParent(_G.SkillFrame)
				_G.SkillFrameCancelButton:Hide()
			end
		end
	end
end
