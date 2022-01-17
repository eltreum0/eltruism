local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local CreateFrame = _G.CreateFrame
local unpack = _G.unpack
local R, G, B = unpack(E.media.rgbvaluecolor)
local LibItemInfo = LibStub:GetLibrary("LibItemInfo.1000")

--attempt at recreating a similar character panel to retail
local CharacterFrame = _G.CharacterFrame
CharacterFrame.Text2 = CharacterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
function ElvUI_EltreumUI:ExpandedCharacterStats()
	if ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
		if E.db.ElvUI_EltreumUI.skins.expandarmorybg then
			local classBgs = {
				['WARRIOR'] = "Interface\\Artifacts\\ArtifactUIWarrior",
				['PALADIN'] = "Interface\\Artifacts\\ArtifactUIPaladin",
				['HUNTER'] = "Interface\\Artifacts\\ArtifactUIHunter",
				['ROGUE'] = "Interface\\Artifacts\\ArtifactUIRogue",
				['PRIEST'] = "Interface\\Artifacts\\ArtifactUIPriest",
				['DEATHKNIGHT'] = "Interface\\Artifacts\\ArtifactUIDeathKnightFrost",
				['SHAMAN'] = "Interface\\Artifacts\\ArtifactUIShaman",
				['MAGE'] = "Interface\\Artifacts\\ArtifactUIMageArcane",
				['WARLOCK'] = "Interface\\Artifacts\\ArtifactUIWarlock",
				['MONK'] = "Interface\\Artifacts\\ArtifactUIMonk",
				['DRUID'] = "Interface\\Artifacts\\ArtifactUIDruid",
				['DEMONHUNTER'] = "Interface\\Artifacts\\ArtifactUIDemonHunter",
			}

			local CharacterFrameBackgroundTexture = CharacterFrame:CreateTexture()
			CharacterFrameBackgroundTexture:SetTexture(classBgs[E.myclass])
			CharacterFrameBackgroundTexture:SetTexCoord(0, 0.87, 0, 0.60)
			if E.db.ElvUI_EltreumUI.skins.expandarmorybgalpha then
				CharacterFrameBackgroundTexture:SetAlpha(E.db.ElvUI_EltreumUI.skins.expandarmorybgalpha)
			else
				CharacterFrameBackgroundTexture:SetAlpha(0.3)
			end
			CharacterFrameBackgroundTexture:SetAllPoints(_G.CharacterFrame.backdrop)
			CharacterFrameBackgroundTexture:SetDrawLayer("ARTWORK")
		end

		if E.db.ElvUI_EltreumUI.skins.classicarmory then
			if CharacterFrame then
				--turns out classic has the functions to get number of points on talent trees
				--need to figure out how to print when all trees have spent the same amount
				local function PlayerSpec()
					local spec, points
					for i=1, GetNumTalentTabs() do
						local name, _, spent = GetTalentTabInfo(i)
						--print(spent..name.." 1")
						if spent > 0 and (not points or spent > points) then
							--print(spec..points.." 2")
							spec, points = name, spent
						end
					end
					if spec ~= nil then
						return spec
					else
						return L["None"]
					end
				end

				CharacterFrame.Text4 = CharacterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
				CharacterFrame.Text4:SetSize(418, 72)
				CharacterFrame.Text4:SetPoint("TOP", CharacterFrame, "TOP", 150, 10)
				CharacterFrame.Text4:SetTextColor(1, 1, 1)
				CharacterFrame.Text4:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, "OUTLINE")
				CharacterFrame.Text4:SetText("Specialization")
				CharacterFrame.StatusLine4 = CreateFrame("StatusBar", "EltruismCharacterBar2", CharacterFrame)
				CharacterFrame.StatusLine4:SetSize(150, 3)
				CharacterFrame.StatusLine4:SetPoint("CENTER", CharacterFrame.Text4, "CENTER", 0, -15)
				CharacterFrame.StatusLine4:SetStatusBarTexture(E.Media.Textures.Highlight)
				CharacterFrame.StatusLine4:SetStatusBarColor(R, G, B, 1)

				CharacterFrame.Text5 = CharacterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
				CharacterFrame.Text5:SetSize(418, 72)
				CharacterFrame.Text5:SetPoint("TOP", CharacterFrame, "TOP", 150, -20)
				CharacterFrame.Text5:SetTextColor(R, G, B)
				CharacterFrame.Text5:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, "OUTLINE")
				CharacterFrame.Text5:SetText(PlayerSpec())


				local ilevel, _, _ = LibItemInfo:GetUnitItemLevel("player")
				_G.CharacterFrame.Text2:SetText((math.floor(ilevel*100))/100)

				CharacterFrame:SetSize(600, 505)
				CharacterFrame.Text = CharacterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
				CharacterFrame.Text:SetSize(418, 72)
				CharacterFrame.Text:SetPoint("TOP", CharacterFrame, "TOP", 150, -45)
				CharacterFrame.Text:SetTextColor(1, 1, 1)
				CharacterFrame.Text:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, "OUTLINE")
				CharacterFrame.Text:SetText("Item Level")
				CharacterFrame.StatusLine = CreateFrame("StatusBar", "EltruismCharacterBar2", CharacterFrame)
				CharacterFrame.StatusLine:SetSize(150, 3)
				CharacterFrame.StatusLine:SetPoint("CENTER", CharacterFrame.Text, "CENTER", 0, -15)
				CharacterFrame.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				CharacterFrame.StatusLine:SetStatusBarColor(R, G, B, 1)

				CharacterFrame.Text2:SetSize(418, 72)
				CharacterFrame.Text2:SetPoint("TOP", CharacterFrame, "TOP", 150, -80)
				CharacterFrame.Text2:SetTextColor(R, G, B)
				CharacterFrame.Text2:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, "OUTLINE")
				CharacterFrame.StatusLine2 = CreateFrame("StatusBar", "EltruismCharacterBar1", CharacterFrame)
				CharacterFrame.StatusLine2:SetFrameStrata("LOW")
				CharacterFrame.StatusLine2:SetSize(200, 30)
				CharacterFrame.StatusLine2:SetPoint("CENTER", CharacterFrame.Text2, "CENTER", 0, 0)
				CharacterFrame.StatusLine2:SetStatusBarTexture(E.Media.Textures.Highlight)
				CharacterFrame.StatusLine2:SetStatusBarColor(1, 1, 1, 1)

				CharacterFrame.Text3 = CharacterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
				CharacterFrame.Text3:SetSize(418, 72)
				CharacterFrame.Text3:SetPoint("TOP", CharacterFrame, "TOP", 150, -105)
				CharacterFrame.Text3:SetTextColor(1, 1, 1)
				CharacterFrame.Text3:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, "OUTLINE")
				CharacterFrame.Text3:SetText("Attributes")
				CharacterFrame.StatusLine3 = CreateFrame("StatusBar", "EltruismCharacterBar2", CharacterFrame)
				CharacterFrame.StatusLine3:SetSize(150, 3)
				CharacterFrame.StatusLine3:SetPoint("CENTER", CharacterFrame.Text3, "CENTER", 0, -15)
				CharacterFrame.StatusLine3:SetStatusBarTexture(E.Media.Textures.Highlight)
				CharacterFrame.StatusLine3:SetStatusBarColor(R, G, B, 1)

				_G.CharacterModelFrame:ClearAllPoints()
				_G.CharacterModelFrame:SetPoint("RIGHT", CharacterFrame, "CENTER", -20, 0)
				_G.CharacterModelFrame:SetSize(200, 300)
				_G.CharacterModelFrameRotateRightButton:Hide()
				_G.CharacterModelFrameRotateLeftButton:Hide()
				_G.MagicResFrame1:ClearAllPoints()
				if ElvUI_EltreumUI.TBC then
					_G.MagicResFrame1:SetParent(_G.PlayerStatFrameLeft1)
					_G.MagicResFrame1:SetPoint("TOPLEFT", _G.PlayerStatFrameLeftDropDown, "TOPLEFT", 14, 27)
				elseif ElvUI_EltreumUI.Classic then
					_G.MagicResFrame1:SetParent(_G.CharacterStatFrame1)
					_G.MagicResFrame1:SetPoint("TOPLEFT", _G.CharacterStatFrame1, "TOPLEFT", -15, 35)
				end

				_G.MagicResFrame2:ClearAllPoints()
				_G.MagicResFrame2:SetParent(_G.MagicResFrame1)
				_G.MagicResFrame2:SetPoint("RIGHT", _G.MagicResFrame1, "RIGHT", 27, 0)
				_G.MagicResFrame3:ClearAllPoints()
				_G.MagicResFrame3:SetParent(_G.MagicResFrame2)
				_G.MagicResFrame3:SetPoint("RIGHT", _G.MagicResFrame2, "RIGHT", 27, 0)
				_G.MagicResFrame4:ClearAllPoints()
				_G.MagicResFrame4:SetParent(_G.MagicResFrame3)
				_G.MagicResFrame4:SetPoint("RIGHT", _G.MagicResFrame3, "RIGHT", 27, 0)
				_G.MagicResFrame5:ClearAllPoints()
				_G.MagicResFrame5:SetParent(_G.MagicResFrame4)
				_G.MagicResFrame5:SetPoint("RIGHT", _G.MagicResFrame4, "RIGHT", 27, 0)

				if ElvUI_EltreumUI.TBC then

					--"left side" or in this case the top side
					_G.PlayerStatFrameLeftDropDown:ClearAllPoints()
					_G.PlayerStatFrameLeftDropDown:SetPoint("TOP", CharacterFrame, "TOP", 143, -200)
					_G.PlayerStatFrameLeftDropDown:SetParent(CharacterFrame)

					_G.PlayerStatFrameLeft1:ClearAllPoints()
					_G.PlayerStatFrameLeft1:SetPoint("TOP", CharacterFrame, "TOP", 124, -225)
					_G.PlayerStatFrameLeft1:SetParent(CharacterFrame)
					_G.PlayerStatFrameLeft2:ClearAllPoints()
					_G.PlayerStatFrameLeft2:SetPoint("BOTTOM", _G.PlayerStatFrameLeft1, "BOTTOM", 0, -13)
					_G.PlayerStatFrameLeft2:SetParent(_G.PlayerStatFrameLeft1)
					_G.PlayerStatFrameLeft3:ClearAllPoints()
					_G.PlayerStatFrameLeft3:SetPoint("BOTTOM", _G.PlayerStatFrameLeft2, "BOTTOM", 0, -13)
					_G.PlayerStatFrameLeft3:SetParent(_G.PlayerStatFrameLeft1)
					_G.PlayerStatFrameLeft4:ClearAllPoints()
					_G.PlayerStatFrameLeft4:SetPoint("BOTTOM", _G.PlayerStatFrameLeft3, "BOTTOM", 0, -13)
					_G.PlayerStatFrameLeft4:SetParent(_G.PlayerStatFrameLeft1)
					_G.PlayerStatFrameLeft5:ClearAllPoints()
					_G.PlayerStatFrameLeft5:SetPoint("BOTTOM", _G.PlayerStatFrameLeft4, "BOTTOM", 0, -13)
					_G.PlayerStatFrameLeft5:SetParent(_G.PlayerStatFrameLeft1)
					_G.PlayerStatFrameLeft6:ClearAllPoints()
					_G.PlayerStatFrameLeft6:SetPoint("BOTTOM", _G.PlayerStatFrameLeft5, "BOTTOM", 0, -13)
					_G.PlayerStatFrameLeft6:SetParent(_G.PlayerStatFrameLeft1)

					_G.PlayerStatFrameLeft1Stat:ClearAllPoints()
					_G.PlayerStatFrameLeft1Stat:SetPoint("TOP", CharacterFrame, "TOP", 211, -225)
					_G.PlayerStatFrameLeft1Stat:SetParent(_G.PlayerStatFrameLeft1)
					_G.PlayerStatFrameLeft2Stat:ClearAllPoints()
					_G.PlayerStatFrameLeft2Stat:SetPoint("BOTTOM", _G.PlayerStatFrameLeft1Stat, "BOTTOM", 0, -13)
					_G.PlayerStatFrameLeft2Stat:SetParent(_G.PlayerStatFrameLeft1)
					_G.PlayerStatFrameLeft3Stat:ClearAllPoints()
					_G.PlayerStatFrameLeft3Stat:SetPoint("BOTTOM", _G.PlayerStatFrameLeft2Stat, "BOTTOM", 0, -13)
					_G.PlayerStatFrameLeft3Stat:SetParent(_G.PlayerStatFrameLeft1)
					_G.PlayerStatFrameLeft4Stat:ClearAllPoints()
					_G.PlayerStatFrameLeft4Stat:SetPoint("BOTTOM", _G.PlayerStatFrameLeft3Stat, "BOTTOM", 0, -13)
					_G.PlayerStatFrameLeft4Stat:SetParent(_G.PlayerStatFrameLeft1)
					_G.PlayerStatFrameLeft5Stat:ClearAllPoints()
					_G.PlayerStatFrameLeft5Stat:SetPoint("BOTTOM", _G.PlayerStatFrameLeft4Stat, "BOTTOM", 0, -13)
					_G.PlayerStatFrameLeft5Stat:SetParent(_G.PlayerStatFrameLeft1)
					_G.PlayerStatFrameLeft6Stat:ClearAllPoints()
					_G.PlayerStatFrameLeft6Stat:SetPoint("BOTTOM", _G.PlayerStatFrameLeft5Stat, "BOTTOM", 0, -13)
					_G.PlayerStatFrameLeft6Stat:SetParent(_G.PlayerStatFrameLeft1)

					--"right side", on this case its the bottom
					_G.PlayerStatFrameRightDropDown:ClearAllPoints()
					_G.PlayerStatFrameRightDropDown:SetPoint("TOP", CharacterFrame, "TOP", 143, -310)
					_G.PlayerStatFrameRightDropDown:SetParent(CharacterFrame)

					_G.PlayerStatFrameRight1:ClearAllPoints()
					_G.PlayerStatFrameRight1:SetPoint("TOP", CharacterFrame, "TOP", 124, -335)
					_G.PlayerStatFrameRight1:SetParent(CharacterFrame)
					_G.PlayerStatFrameRight2:ClearAllPoints()
					_G.PlayerStatFrameRight2:SetPoint("BOTTOM", _G.PlayerStatFrameRight1, "BOTTOM", 0, -13)
					_G.PlayerStatFrameRight2:SetParent(_G.PlayerStatFrameRight1)
					_G.PlayerStatFrameRight3:ClearAllPoints()
					_G.PlayerStatFrameRight3:SetPoint("BOTTOM", _G.PlayerStatFrameRight2, "BOTTOM", 0, -13)
					_G.PlayerStatFrameRight3:SetParent(_G.PlayerStatFrameRight1)
					_G.PlayerStatFrameRight4:ClearAllPoints()
					_G.PlayerStatFrameRight4:SetPoint("BOTTOM", _G.PlayerStatFrameRight3, "BOTTOM", 0, -13)
					_G.PlayerStatFrameRight4:SetParent(_G.PlayerStatFrameRight1)
					_G.PlayerStatFrameRight5:ClearAllPoints()
					_G.PlayerStatFrameRight5:SetPoint("BOTTOM", _G.PlayerStatFrameRight4, "BOTTOM", 0, -13)
					_G.PlayerStatFrameRight5:SetParent(_G.PlayerStatFrameRight1)
					_G.PlayerStatFrameRight6:ClearAllPoints()
					_G.PlayerStatFrameRight6:SetPoint("BOTTOM", _G.PlayerStatFrameRight5, "BOTTOM", 0, -13)
					_G.PlayerStatFrameRight6:SetParent(_G.PlayerStatFrameRight1)

					_G.PlayerStatFrameRight1Stat:ClearAllPoints()
					_G.PlayerStatFrameRight1Stat:SetPoint("TOP", CharacterFrame, "TOP", 211, -335)
					_G.PlayerStatFrameRight1Stat:SetParent(_G.PlayerStatFrameRight1)
					_G.PlayerStatFrameRight2Stat:ClearAllPoints()
					_G.PlayerStatFrameRight2Stat:SetPoint("BOTTOM", _G.PlayerStatFrameRight1Stat, "BOTTOM", 0, -13)
					_G.PlayerStatFrameRight2Stat:SetParent(_G.PlayerStatFrameRight1)
					_G.PlayerStatFrameRight3Stat:ClearAllPoints()
					_G.PlayerStatFrameRight3Stat:SetPoint("BOTTOM", _G.PlayerStatFrameRight2Stat, "BOTTOM", 0, -13)
					_G.PlayerStatFrameRight3Stat:SetParent(_G.PlayerStatFrameRight1)
					_G.PlayerStatFrameRight4Stat:ClearAllPoints()
					_G.PlayerStatFrameRight4Stat:SetPoint("BOTTOM", _G.PlayerStatFrameRight3Stat, "BOTTOM", 0, -13)
					_G.PlayerStatFrameRight4Stat:SetParent(_G.PlayerStatFrameRight1)
					_G.PlayerStatFrameRight5Stat:ClearAllPoints()
					_G.PlayerStatFrameRight5Stat:SetPoint("BOTTOM", _G.PlayerStatFrameRight4Stat, "BOTTOM", 0, -13)
					_G.PlayerStatFrameRight5Stat:SetParent(_G.PlayerStatFrameRight1)
					_G.PlayerStatFrameRight6Stat:ClearAllPoints()
					_G.PlayerStatFrameRight6Stat:SetPoint("BOTTOM", _G.PlayerStatFrameRight5Stat, "BOTTOM", 0, -13)
					_G.PlayerStatFrameRight6Stat:SetParent(_G.PlayerStatFrameRight1)

					--set the tabs
						SetCVar("playerStatLeftDropdown", "PLAYERSTAT_BASE_STATS")
					if E.myclass == "MAGE" or E.myclass == "PRIEST" or E.myclass == "WARLOCK" or E.myclass == "DRUID" then
						SetCVar("playerStatRightDropdown", "PLAYERSTAT_SPELL_COMBAT")
					elseif ( E.myclass == "HUNTER" ) then
						SetCVar("playerStatRightDropdown", "PLAYERSTAT_RANGED_COMBAT")
					else
						SetCVar("playerStatRightDropdown", "PLAYERSTAT_MELEE_COMBAT")
					end
				elseif ElvUI_EltreumUI.Classic then
					_G.CharacterStatFrame1:ClearAllPoints()
					_G.CharacterStatFrame1:SetPoint("TOP", CharacterFrame, "TOP", 150, -215)
					_G.CharacterStatFrame1:SetParent(CharacterFrame)
					_G.CharacterStatFrame2:SetParent(_G._G.CharacterStatFrame1)
					_G.CharacterStatFrame3:SetParent(_G._G.CharacterStatFrame1)
					_G.CharacterStatFrame4:SetParent(_G._G.CharacterStatFrame1)
					_G.CharacterStatFrame5:SetParent(_G._G.CharacterStatFrame1)
					_G.CharacterArmorFrame:SetParent(_G._G.CharacterStatFrame1)
					_G.CharacterAttackFrame:ClearAllPoints()
					_G.CharacterAttackFrame:SetPoint("TOP", CharacterFrame, "TOP", 150, -325)
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
