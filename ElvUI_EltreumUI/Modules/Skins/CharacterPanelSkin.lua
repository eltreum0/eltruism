local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local CreateFrame = _G.CreateFrame
local unpack = _G.unpack
local classcolor = E:ClassColor(E.myclass, true)
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

			local alpha
			if E.db.ElvUI_EltreumUI.skins.expandarmorybgalpha ~= nil then
				alpha = E.db.ElvUI_EltreumUI.skins.expandarmorybgalpha
			elseif E.db.ElvUI_EltreumUI.skins.expandarmorybgalpha == nil then
				alpha = 0.3
			end


			local CharacterFrameBackgroundTexture = CharacterFrame:CreateTexture()
			CharacterFrameBackgroundTexture:SetTexture(classBgs[E.myclass])
			CharacterFrameBackgroundTexture:SetTexCoord(0, 0.87, 0, 0.60)
			if alpha ~= nil then
				CharacterFrameBackgroundTexture:SetAlpha(alpha)
			else
				CharacterFrameBackgroundTexture:SetAlpha(0.3)
			end
			CharacterFrameBackgroundTexture:SetAllPoints(_G.CharacterFrame.backdrop)
			CharacterFrameBackgroundTexture:SetDrawLayer("ARTWORK")
		end
		if E.db.ElvUI_EltreumUI.skins.classicarmory then -- this is expand classic armory
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


			_G.PlayerTitleDropDown:Show()
			_G.PlayerTitleDropDown:ClearAllPoints()
			_G.PlayerTitleDropDown:SetParent(_G.CharacterModelFrame)
			_G.CharacterNameText:ClearAllPoints()
			_G.CharacterLevelText:ClearAllPoints()
			_G.CharacterNameText:SetPoint('TOP', _G.CharacterModelFrame, 0, 80)
			_G.CharacterNameText:SetParent(_G.CharacterModelFrame)
			_G.CharacterLevelText:SetPoint('TOP', _G.CharacterModelFrame, 0, 60)
			_G.CharacterLevelText:SetParent(_G.CharacterModelFrame)
			_G.PlayerTitleDropDown:SetPoint('TOP', _G.CharacterModelFrame, 0, 40)

			_G.CharacterLevelText:SetPoint('TOP', _G.CharacterNameText, 'BOTTOM', 0, -10)
			_G.PetNameText:SetPoint('TOP', _G.PetModelFrame, 0, 60)
			_G.PetLevelText:SetPoint('BOTTOM', _G.PetNameText, 0, -10)
			_G.PetLoyaltyText:SetPoint('BOTTOM', _G.PetLevelText, 0, -20)
			_G.PetPaperDollCloseButton:Hide()

			_G.CharacterNameText:SetParent(_G.CharacterModelFrame)
			_G.CharacterNameText:SetFont(E.LSM:Fetch('font', E.db.general.font), 18, "OUTLINE")
			_G.CharacterNameText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
			_G.CharacterNameText:SetShadowColor(0, 0, 0, 0.8)
			_G.CharacterNameText:SetShadowOffset(2, -1)

			_G.SkillFrame:SetHeight(400)
			_G.SkillDetailScrollChildFrame:ClearAllPoints()
			_G.SkillDetailScrollChildFrame:SetPoint("BOTTOMLEFT", CharacterFrame, "BOTTOMLEFT", 30, 150)
			_G.SkillDetailScrollChildFrame:SetParent(_G.SkillFrame)
			_G.SkillFrameCancelButton:Hide()




			--_G.ReputationDefailFrame:SetPoint('TOPRIGHT', _G.CharacterFrame)

			CharacterFrame.Text4 = CharacterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
			CharacterFrame.Text4:SetSize(418, 72)
			CharacterFrame.Text4:SetPoint("TOP", CharacterFrame, "TOP", 150, 10)
			CharacterFrame.Text4:SetTextColor(1, 1, 1)
			CharacterFrame.Text4:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, "OUTLINE")
			CharacterFrame.Text4:SetText("Specialization")
			CharacterFrame.StatusLine4 = CreateFrame("StatusBar", "EltruismCharacterBar2", CharacterFrame)
			CharacterFrame.StatusLine4:SetSize(170, 3)
			CharacterFrame.StatusLine4:SetPoint("CENTER", CharacterFrame.Text4, "CENTER", 0, -15)
			CharacterFrame.StatusLine4:SetStatusBarTexture(E.Media.Textures.Highlight)
			CharacterFrame.StatusLine4:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)

			CharacterFrame.Text5 = CharacterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
			CharacterFrame.Text5:SetSize(418, 72)
			CharacterFrame.Text5:SetPoint("TOP", CharacterFrame, "TOP", 150, -20)
			CharacterFrame.Text5:SetTextColor(classcolor.r, classcolor.g, classcolor.b, 1)
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
			CharacterFrame.StatusLine:SetSize(170, 3)
			CharacterFrame.StatusLine:SetPoint("CENTER", CharacterFrame.Text, "CENTER", 0, -15)
			CharacterFrame.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
			CharacterFrame.StatusLine:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)

			CharacterFrame.Text2:SetSize(418, 72)
			CharacterFrame.Text2:SetPoint("TOP", CharacterFrame, "TOP", 150, -80)
			CharacterFrame.Text2:SetTextColor(classcolor.r, classcolor.g, classcolor.b, 1)
			CharacterFrame.Text2:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, "OUTLINE")
			CharacterFrame.StatusLine2 = CreateFrame("StatusBar", "EltruismCharacterBar1", CharacterFrame)
			CharacterFrame.StatusLine2:SetFrameStrata("LOW")
			CharacterFrame.StatusLine2:SetSize(170, 25)
			CharacterFrame.StatusLine2:SetPoint("CENTER", CharacterFrame.Text2, "CENTER", 0, 0)
			CharacterFrame.StatusLine2:SetStatusBarTexture(E.Media.Textures.Highlight)
			CharacterFrame.StatusLine2:SetStatusBarColor(1, 1, 1, 0.8)

			CharacterFrame.Text3 = CharacterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
			CharacterFrame.Text3:SetSize(418, 72)
			CharacterFrame.Text3:SetPoint("TOP", CharacterFrame, "TOP", 150, -105)
			CharacterFrame.Text3:SetTextColor(1, 1, 1)
			CharacterFrame.Text3:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, "OUTLINE")
			CharacterFrame.Text3:SetText("Attributes")
			CharacterFrame.StatusLine3 = CreateFrame("StatusBar", "EltruismCharacterBar2", CharacterFrame)
			CharacterFrame.StatusLine3:SetSize(170, 3)
			CharacterFrame.StatusLine3:SetPoint("CENTER", CharacterFrame.Text3, "CENTER", 0, -15)
			CharacterFrame.StatusLine3:SetStatusBarTexture(E.Media.Textures.Highlight)
			CharacterFrame.StatusLine3:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)

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
				_G.MagicResFrame1:SetPoint("BOTTOM", "EltruismCharacterBar2", "BOTTOM", -55, -155)
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
				_G.PlayerStatFrameLeft2.StatusLine = CreateFrame("StatusBar", "EltruismStatLine1", CharacterFrame)
				_G.PlayerStatFrameLeft2.StatusLine:SetSize(170, 12)
				_G.PlayerStatFrameLeft2.StatusLine:SetPoint("CENTER", _G.PlayerStatFrameLeft2, "CENTER", 25, 0)
				_G.PlayerStatFrameLeft2.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				_G.PlayerStatFrameLeft2.StatusLine:SetStatusBarColor(1, 1, 1, 0.3)

				_G.PlayerStatFrameLeft3:ClearAllPoints()
				_G.PlayerStatFrameLeft3:SetPoint("BOTTOM", _G.PlayerStatFrameLeft2, "BOTTOM", 0, -13)
				_G.PlayerStatFrameLeft3:SetParent(_G.PlayerStatFrameLeft1)

				_G.PlayerStatFrameLeft4:ClearAllPoints()
				_G.PlayerStatFrameLeft4:SetPoint("BOTTOM", _G.PlayerStatFrameLeft3, "BOTTOM", 0, -13)
				_G.PlayerStatFrameLeft4:SetParent(_G.PlayerStatFrameLeft1)
				_G.PlayerStatFrameLeft4.StatusLine = CreateFrame("StatusBar", "EltruismStatLine2", CharacterFrame)
				_G.PlayerStatFrameLeft4.StatusLine:SetSize(170, 12)
				_G.PlayerStatFrameLeft4.StatusLine:SetPoint("CENTER", _G.PlayerStatFrameLeft4, "CENTER", 25, 0)
				_G.PlayerStatFrameLeft4.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				_G.PlayerStatFrameLeft4.StatusLine:SetStatusBarColor(1, 1, 1, 0.3)

				_G.PlayerStatFrameLeft5:ClearAllPoints()
				_G.PlayerStatFrameLeft5:SetPoint("BOTTOM", _G.PlayerStatFrameLeft4, "BOTTOM", 0, -13)
				_G.PlayerStatFrameLeft5:SetParent(_G.PlayerStatFrameLeft1)

				_G.PlayerStatFrameLeft6:ClearAllPoints()
				_G.PlayerStatFrameLeft6:SetPoint("BOTTOM", _G.PlayerStatFrameLeft5, "BOTTOM", 0, -13)
				_G.PlayerStatFrameLeft6:SetParent(_G.PlayerStatFrameLeft1)
				_G.PlayerStatFrameLeft6.StatusLine = CreateFrame("StatusBar", "EltruismStatLine3", CharacterFrame)
				_G.PlayerStatFrameLeft6.StatusLine:SetSize(170, 12)
				_G.PlayerStatFrameLeft6.StatusLine:SetPoint("CENTER", _G.PlayerStatFrameLeft6, "CENTER", 25, 0)
				_G.PlayerStatFrameLeft6.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				_G.PlayerStatFrameLeft6.StatusLine:SetStatusBarColor(1, 1, 1, 0.3)

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
				_G.PlayerStatFrameRight2.StatusLine = CreateFrame("StatusBar", "EltruismStatLine5", CharacterFrame)
				_G.PlayerStatFrameRight2.StatusLine:SetSize(170, 12)
				_G.PlayerStatFrameRight2.StatusLine:SetPoint("CENTER", _G.PlayerStatFrameRight2, "CENTER", 25, 0)
				_G.PlayerStatFrameRight2.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				_G.PlayerStatFrameRight2.StatusLine:SetStatusBarColor(1, 1, 1, 0.3)

				_G.PlayerStatFrameRight3:ClearAllPoints()
				_G.PlayerStatFrameRight3:SetPoint("BOTTOM", _G.PlayerStatFrameRight2, "BOTTOM", 0, -13)
				_G.PlayerStatFrameRight3:SetParent(_G.PlayerStatFrameRight1)
				_G.PlayerStatFrameRight4:ClearAllPoints()
				_G.PlayerStatFrameRight4:SetPoint("BOTTOM", _G.PlayerStatFrameRight3, "BOTTOM", 0, -13)
				_G.PlayerStatFrameRight4:SetParent(_G.PlayerStatFrameRight1)
				_G.PlayerStatFrameRight4.StatusLine = CreateFrame("StatusBar", "EltruismStatLine6", CharacterFrame)
				_G.PlayerStatFrameRight4.StatusLine:SetSize(170, 12)
				_G.PlayerStatFrameRight4.StatusLine:SetPoint("CENTER", _G.PlayerStatFrameRight4, "CENTER", 25, 0)
				_G.PlayerStatFrameRight4.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				_G.PlayerStatFrameRight4.StatusLine:SetStatusBarColor(1, 1, 1, 0.3)

				_G.PlayerStatFrameRight5:ClearAllPoints()
				_G.PlayerStatFrameRight5:SetPoint("BOTTOM", _G.PlayerStatFrameRight4, "BOTTOM", 0, -13)
				_G.PlayerStatFrameRight5:SetParent(_G.PlayerStatFrameRight1)
				_G.PlayerStatFrameRight6:ClearAllPoints()
				_G.PlayerStatFrameRight6:SetPoint("BOTTOM", _G.PlayerStatFrameRight5, "BOTTOM", 0, -13)
				_G.PlayerStatFrameRight6:SetParent(_G.PlayerStatFrameRight1)
				_G.PlayerStatFrameRight6.StatusLine = CreateFrame("StatusBar", "EltruismStatLine7", CharacterFrame)
				_G.PlayerStatFrameRight6.StatusLine:SetSize(170, 12)
				_G.PlayerStatFrameRight6.StatusLine:SetPoint("CENTER", _G.PlayerStatFrameRight6, "CENTER", 25, 0)
				_G.PlayerStatFrameRight6.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				_G.PlayerStatFrameRight6.StatusLine:SetStatusBarColor(1, 1, 1, 0.3)

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
				_G.CharacterStatFrame1:SetPoint("TOP", CharacterFrame, "TOP", 124, -225)
				_G.CharacterStatFrame1:SetParent(CharacterFrame)

				_G.CharacterStatFrame2:ClearAllPoints()
				_G.CharacterStatFrame2:SetParent(_G.CharacterStatFrame1)
				_G.CharacterStatFrame2:SetPoint("BOTTOM", _G.CharacterStatFrame1, "BOTTOM", 0, -13)
				_G.CharacterStatFrame2.StatusLine = CreateFrame("StatusBar", "EltruismStatLine1", CharacterFrame)
				_G.CharacterStatFrame2.StatusLine:SetSize(170, 12)
				_G.CharacterStatFrame2.StatusLine:SetPoint("CENTER", _G.CharacterStatFrame2, "CENTER", 25, 0)
				_G.CharacterStatFrame2.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				_G.CharacterStatFrame2.StatusLine:SetStatusBarColor(1, 1, 1, 0.3)

				_G.CharacterStatFrame3:ClearAllPoints()
				_G.CharacterStatFrame3:SetParent(_G.CharacterStatFrame1)
				_G.CharacterStatFrame3:SetPoint("BOTTOM", _G.CharacterStatFrame2, "BOTTOM", 0, -13)

				_G.CharacterStatFrame4:ClearAllPoints()
				_G.CharacterStatFrame4:SetParent(_G.CharacterStatFrame1)
				_G.CharacterStatFrame4:SetPoint("BOTTOM", _G.CharacterStatFrame3, "BOTTOM", 0, -13)
				_G.CharacterStatFrame4.StatusLine = CreateFrame("StatusBar", "EltruismStatLine2", CharacterFrame)
				_G.CharacterStatFrame4.StatusLine:SetSize(170, 12)
				_G.CharacterStatFrame4.StatusLine:SetPoint("CENTER", _G.CharacterStatFrame4, "CENTER", 25, 0)
				_G.CharacterStatFrame4.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				_G.CharacterStatFrame4.StatusLine:SetStatusBarColor(1, 1, 1, 0.3)

				_G.CharacterStatFrame5:ClearAllPoints()
				_G.CharacterStatFrame5:SetParent(_G.CharacterStatFrame1)
				_G.CharacterStatFrame5:SetPoint("BOTTOM", _G.CharacterStatFrame4, "BOTTOM", 0, -13)


				_G.CharacterArmorFrame:ClearAllPoints()
				_G.CharacterArmorFrame:SetParent(_G.CharacterStatFrame1)
				_G.CharacterArmorFrame:SetPoint("BOTTOM", _G.CharacterStatFrame5, "BOTTOM", 0, -13)
				_G.CharacterArmorFrame.StatusLine = CreateFrame("StatusBar", "EltruismStatLine3", CharacterFrame)
				_G.CharacterArmorFrame.StatusLine:SetSize(170, 12)
				_G.CharacterArmorFrame.StatusLine:SetPoint("CENTER", _G.CharacterArmorFrame, "CENTER", 25, 0)
				_G.CharacterArmorFrame.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				_G.CharacterArmorFrame.StatusLine:SetStatusBarColor(1, 1, 1, 0.3)

				_G.CharacterAttackFrame:ClearAllPoints()
				_G.CharacterAttackFrame:SetParent(_G.CharacterStatFrame1)
				_G.CharacterAttackFrame:SetPoint("BOTTOM", _G.CharacterArmorFrame, "BOTTOM", 0, -13)

				_G.CharacterAttackPowerFrame:ClearAllPoints()
				_G.CharacterAttackPowerFrame:SetParent(_G.CharacterStatFrame1)
				_G.CharacterAttackPowerFrame:SetPoint("BOTTOM", _G.CharacterAttackFrame, "BOTTOM", 0, -13)
				_G.CharacterAttackPowerFrame.StatusLine = CreateFrame("StatusBar", "EltruismStatLine4", CharacterFrame)
				_G.CharacterAttackPowerFrame.StatusLine:SetSize(170, 12)
				_G.CharacterAttackPowerFrame.StatusLine:SetPoint("CENTER", _G.CharacterAttackPowerFrame, "CENTER", 25, 0)
				_G.CharacterAttackPowerFrame.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				_G.CharacterAttackPowerFrame.StatusLine:SetStatusBarColor(1, 1, 1, 0.3)

				_G.CharacterDamageFrame:ClearAllPoints()
				_G.CharacterDamageFrame:SetParent(_G.CharacterStatFrame1)
				_G.CharacterDamageFrame:SetPoint("BOTTOM", _G.CharacterAttackPowerFrame, "BOTTOM", 0, -13)

				_G.CharacterRangedAttackFrame:ClearAllPoints()
				_G.CharacterRangedAttackFrame:SetParent(_G.CharacterStatFrame1)
				_G.CharacterRangedAttackFrame:SetPoint("BOTTOM", _G.CharacterDamageFrame, "BOTTOM", 0, -13)
				_G.CharacterRangedAttackFrame.StatusLine = CreateFrame("StatusBar", "EltruismStatLine5", CharacterFrame)
				_G.CharacterRangedAttackFrame.StatusLine:SetSize(170, 12)
				_G.CharacterRangedAttackFrame.StatusLine:SetPoint("CENTER", _G.CharacterRangedAttackFrame, "CENTER", 25, 0)
				_G.CharacterRangedAttackFrame.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				_G.CharacterRangedAttackFrame.StatusLine:SetStatusBarColor(1, 1, 1, 0.3)

				_G.CharacterRangedAttackPowerFrame:ClearAllPoints()
				_G.CharacterRangedAttackPowerFrame:SetParent(_G.CharacterStatFrame1)
				_G.CharacterRangedAttackPowerFrame:SetPoint("BOTTOM", _G.CharacterRangedAttackFrame, "BOTTOM", 0, -13)

				_G.CharacterRangedDamageFrame:ClearAllPoints()
				_G.CharacterRangedDamageFrame:SetParent(_G.CharacterStatFrame1)
				_G.CharacterRangedDamageFrame:SetPoint("BOTTOM", _G.CharacterRangedAttackPowerFrame, "BOTTOM", 0, -13)
				_G.CharacterRangedDamageFrame.StatusLine = CreateFrame("StatusBar", "EltruismStatLine6", CharacterFrame)
				_G.CharacterRangedDamageFrame.StatusLine:SetSize(170, 12)
				_G.CharacterRangedDamageFrame.StatusLine:SetPoint("CENTER", _G.CharacterRangedDamageFrame, "CENTER", 25, 0)
				_G.CharacterRangedDamageFrame.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				_G.CharacterRangedDamageFrame.StatusLine:SetStatusBarColor(1, 1, 1, 0.3)


				_G.CharacterStatFrame1Stat:ClearAllPoints()
				_G.CharacterStatFrame1Stat:SetPoint("TOP", CharacterFrame, "TOP", 211, -225)
				_G.CharacterStatFrame1Stat:SetParent(_G.CharacterStatFrame1)

				_G.CharacterStatFrame2Stat:ClearAllPoints()
				_G.CharacterStatFrame2Stat:SetPoint("BOTTOM", _G.CharacterStatFrame1Stat, "BOTTOM", 0, -13)
				_G.CharacterStatFrame2Stat:SetParent(_G.CharacterStatFrame1)
				_G.CharacterStatFrame3Stat:ClearAllPoints()
				_G.CharacterStatFrame3Stat:SetPoint("BOTTOM", _G.CharacterStatFrame2Stat, "BOTTOM", 0, -13)
				_G.CharacterStatFrame3Stat:SetParent(_G.CharacterStatFrame1)
				_G.CharacterStatFrame4Stat:ClearAllPoints()
				_G.CharacterStatFrame4Stat:SetPoint("BOTTOM", _G.CharacterStatFrame3Stat, "BOTTOM", 0, -13)
				_G.CharacterStatFrame4Stat:SetParent(_G.CharacterStatFrame1)
				_G.CharacterStatFrame5Stat:ClearAllPoints()
				_G.CharacterStatFrame5Stat:SetPoint("BOTTOM", _G.CharacterStatFrame4Stat, "BOTTOM", 0, -13)
				_G.CharacterStatFrame5Stat:SetParent(_G.CharacterStatFrame1)

				_G.CharacterArmorFrameStat:ClearAllPoints()
				_G.CharacterArmorFrameStat:SetPoint("BOTTOM", _G.CharacterStatFrame5Stat, "BOTTOM", 0, -13)
				_G.CharacterArmorFrameStat:SetParent(_G.CharacterStatFrame1)

				_G.CharacterAttackFrameStat:ClearAllPoints()
				_G.CharacterAttackFrameStat:SetPoint("BOTTOM", _G.CharacterArmorFrameStat, "BOTTOM", 0, -13)
				_G.CharacterAttackFrameStat:SetParent(_G.CharacterStatFrame1)

				_G.CharacterAttackPowerFrameStat:ClearAllPoints()
				_G.CharacterAttackPowerFrameStat:SetPoint("BOTTOM", _G.CharacterAttackFrameStat, "BOTTOM", 0, -13)
				_G.CharacterAttackPowerFrameStat:SetParent(_G.CharacterStatFrame1)

				_G.CharacterDamageFrameStat:ClearAllPoints()
				_G.CharacterDamageFrameStat:SetPoint("BOTTOM", _G.CharacterAttackPowerFrameStat, "BOTTOM", 0, -13)
				_G.CharacterDamageFrameStat:SetParent(_G.CharacterStatFrame1)

				_G.CharacterRangedAttackFrameStat:ClearAllPoints()
				_G.CharacterRangedAttackFrameStat:SetPoint("BOTTOM", _G.CharacterDamageFrameStat, "BOTTOM", 0, -13)
				_G.CharacterRangedAttackFrameStat:SetParent(_G.CharacterStatFrame1)

				_G.CharacterRangedAttackPowerFrameStat:ClearAllPoints()
				_G.CharacterRangedAttackPowerFrameStat:SetPoint("BOTTOM", _G.CharacterRangedAttackFrameStat, "BOTTOM", 0, -13)
				_G.CharacterRangedAttackPowerFrameStat:SetParent(_G.CharacterStatFrame1)

				_G.CharacterRangedDamageFrameStat:ClearAllPoints()
				_G.CharacterRangedDamageFrameStat:SetPoint("BOTTOM", _G.CharacterRangedAttackPowerFrameStat, "BOTTOM", 0, -13)
				_G.CharacterRangedDamageFrameStat:SetParent(_G.CharacterStatFrame1)



				_G.SkillFrame:SetHeight(400)
				_G.SkillDetailScrollChildFrame:ClearAllPoints()
				_G.SkillDetailScrollChildFrame:SetPoint("BOTTOMLEFT", CharacterFrame, "BOTTOMLEFT", 30, 150)
				_G.SkillDetailScrollChildFrame:SetParent(_G.SkillFrame)
				_G.SkillFrameCancelButton:Hide()
			end
		end
	end
end
