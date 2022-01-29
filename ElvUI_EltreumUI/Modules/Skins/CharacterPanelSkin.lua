local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local CreateFrame = _G.CreateFrame
local unpack = _G.unpack
local classcolor = E:ClassColor(E.myclass, true)
local LibItemInfo
if ElvUI_EltreumUI. TBC or ElvUI_EltreumUI.Classic then
	LibItemInfo = LibStub:GetLibrary("LibItemInfo.1000")
end

--attempt at recreating a similar character panel to retail
local CharacterFrame = _G.CharacterFrame
local CharacterFrameBackgroundTexture = CharacterFrame:CreateTexture()
CharacterFrame.Text2 = CharacterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
function ElvUI_EltreumUI:ExpandedCharacterStats()
	if ElvUI_EltreumUI.Retail then
		if E.db.ElvUI_EltreumUI.skins.expandarmorybg then
			_G.CharacterFrame:SetHeight(470)
			-- Move Right Side since left side is already ok
			_G.CharacterFrameInsetRight:SetPoint('TOPLEFT', _G.CharacterFrameInset, 'TOPRIGHT', 130, 0)
			_G.CharacterHandsSlot:SetPoint('TOPRIGHT', _G.CharacterFrameInsetRight, 'TOPLEFT', 0, -3)
			-- Move bottom equipment slots
			_G.CharacterMainHandSlot:SetPoint('BOTTOMLEFT', _G.PaperDollItemsFrame, 'BOTTOMLEFT', 195, 20)
			--strech it a bit
			_G.CharacterModelFrame:ClearAllPoints()
			_G.CharacterModelFrame:SetPoint('TOPLEFT', _G.CharacterHeadSlot, -5, 5)
			_G.CharacterModelFrame:SetPoint('RIGHT', _G.CharacterHandsSlot, 5, 5)
			_G.CharacterModelFrame:SetPoint('BOTTOM', _G.CharacterMainHandSlot, 0, -5)
			--hide other bgs so one can be streched like the talents for tbc/classic
			_G.CharacterModelFrame.BackgroundTopRight:Hide()
			_G.CharacterModelFrame.BackgroundBotLeft:Hide()
			_G.CharacterModelFrame.BackgroundBotRight:Hide()
			_G.CharacterModelFrame.BackgroundTopLeft:SetAllPoints(_G.CharacterModelFrame)
			_G.CharacterModelFrameBackgroundOverlay:SetAllPoints(_G.CharacterModelFrame)
			--move the equipment manager to a nice position
			_G.PaperDollEquipmentManagerPane:ClearAllPoints()
			_G.PaperDollEquipmentManagerPane:SetPoint("RIGHT", _G.CharacterFrame, "RIGHT", -30, -20)
			--move the titles panel to a nice position
			_G.PaperDollTitlesPane:ClearAllPoints()
			_G.PaperDollTitlesPane:SetPoint("RIGHT", _G.CharacterFrame, "RIGHT", -30, -20)

			--move the artwork

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

			local alphabg = E.db.ElvUI_EltreumUI.skins.expandarmorybgalpha
			if alphabg == nil then
				alphabg = 0.3
			end

			CharacterFrameBackgroundTexture:SetTexture(classBgs[E.myclass])
			CharacterFrameBackgroundTexture:SetTexCoord(0, 0.87, 0, 0.60)
			CharacterFrameBackgroundTexture:SetAlpha(alphabg)
			CharacterFrameBackgroundTexture:SetAllPoints(_G.CharacterFrame)
			CharacterFrameBackgroundTexture:SetParent(_G.CharacterFrame)
			CharacterFrameBackgroundTexture:SetDrawLayer("ARTWORK")

			_G.CharacterModelFrame.backdrop:Hide()
			_G.CharacterModelFrameBackgroundTopLeft:Hide()
			_G.CharacterModelFrameBackgroundOverlay:Hide()

			--color the avg item level
			_G.CharacterStatsPane.ItemLevelFrame.leftGrad:SetGradientAlpha('Horizontal', classcolor.r, classcolor.g, classcolor.b, 0.4, classcolor.r, classcolor.g, classcolor.b, 0)
			_G.CharacterStatsPane.ItemLevelFrame.rightGrad:SetGradientAlpha('Horizontal', classcolor.r, classcolor.g, classcolor.b, 0, classcolor.r, classcolor.g, classcolor.b, 0.4)

			--hide the backdrop on reputation/currency tab
			hooksecurefunc("CharacterFrameTab_OnClick", function()
				if _G.CharacterFrameInset.backdrop:IsShown() then
					_G.CharacterFrameInset.backdrop:Hide()
				end
			end)

			hooksecurefunc("CharacterFrame_Collapse", function()
				if _G.PaperDollFrame:IsShown() then
					_G.CharacterFrame:SetWidth(500)
					_G.CharacterModelFrameBackgroundOverlay:Hide()
					if _G.PaperDollFrame.SLE_Armory_BG then
						if _G.PaperDollFrame.SLE_Armory_BG:IsShown() then
							_G.PaperDollFrame.SLE_Armory_BG:Hide()
						end
					end
				end
			end)

			hooksecurefunc("CharacterFrame_Expand", function()
				if _G.PaperDollFrame:IsShown() then
					_G.CharacterFrame:SetWidth(700)
					_G.CharacterModelFrameBackgroundOverlay:Hide()
					if _G.PaperDollFrame.SLE_Armory_BG then
						if _G.PaperDollFrame.SLE_Armory_BG:IsShown() then
							_G.PaperDollFrame.SLE_Armory_BG:Hide()
						end
					end
				end
			end)


			if (not IsAddOnLoaded('DejaCharacterStats')) or (not IsAddOnLoaded("ElvUI_SLE")) then

				_G.CharacterFrame.EltruismExtraStats = _G.CharacterFrame:CreateTexture(nil, 'BORDER')
				_G.CharacterFrame.EltruismExtraStats:SetSize(150, 18)
				_G.CharacterFrame.EltruismExtraStats:SetPoint("CENTER", _G.CharacterStatsPane, "CENTER", 0, -80)
				_G.CharacterFrame.EltruismExtraStats:SetTexture(E.Media.Textures.Black8x8)
				--_G.CharacterFrame.EltruismExtraStats:SetColorTexture(0,0,0,1)
				_G.CharacterFrame.EltruismExtraStats:SetParent(_G.CharacterStatsPane)
				_G.CharacterFrame.EltruismExtraStatsFont = _G.CharacterFrame:CreateFontString(nil,"ARTWORK")
				_G.CharacterFrame.EltruismExtraStatsFont:SetFont(E.LSM:Fetch('font', E.db.general.font), 12)
				_G.CharacterFrame.EltruismExtraStatsFont:SetTextColor(1, 1, 1)
				_G.CharacterFrame.EltruismExtraStatsFont:SetPoint("CENTER", _G.CharacterStatsPane, "CENTER", 0, -80)
				_G.CharacterFrame.EltruismExtraStatsFont:SetParent(_G.CharacterStatsPane)
				_G.CharacterFrame.EltruismExtraStatsFont:SetText("Extra")

				_G.CharacterFrame.EltruismDodge = _G.CharacterFrame:CreateFontString(nil,"ARTWORK")
				_G.CharacterFrame.EltruismDodge:SetFont(E.LSM:Fetch('font', E.db.general.font), 10)
				_G.CharacterFrame.EltruismDodge:SetTextColor(1, 1, 1)
				_G.CharacterFrame.EltruismDodge:SetPoint("CENTER", _G.CharacterStatsPane , 70, -107)
				_G.CharacterFrame.EltruismDodge:SetParent(_G.CharacterStatsPane)
				_G.CharacterFrame.EltruismDodge:SetJustifyH("RIGHT")
				_G.CharacterFrame.EltruismDodge:SetShadowColor(0, 0, 0, 1)
				_G.CharacterFrame.EltruismDodge:SetShadowOffset(1, 0)
				_G.CharacterFrame.EltruismDodgeDesc = _G.CharacterFrame:CreateFontString(nil,"ARTWORK")
				_G.CharacterFrame.EltruismDodgeDesc:SetFont(E.LSM:Fetch('font', E.db.general.font), 10)
				_G.CharacterFrame.EltruismDodgeDesc:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
				_G.CharacterFrame.EltruismDodgeDesc:SetPoint("CENTER", _G.CharacterStatsPane , -66, -107)
				_G.CharacterFrame.EltruismDodgeDesc:SetParent(_G.CharacterStatsPane)
				_G.CharacterFrame.EltruismDodgeDesc:SetText(STAT_DODGE)
				_G.CharacterFrame.EltruismDodgeDesc:SetJustifyH("LEFT")
				_G.CharacterFrame.EltruismDodgeDesc:SetShadowColor(0, 0, 0, 1)
				_G.CharacterFrame.EltruismDodgeDesc:SetShadowOffset(1, 0)

				_G.CharacterFrame.EltruismLeech = _G.CharacterFrame:CreateFontString(nil,"ARTWORK")
				_G.CharacterFrame.EltruismLeech:SetFont(E.LSM:Fetch('font', E.db.general.font), 10)
				_G.CharacterFrame.EltruismLeech:SetTextColor(1, 1, 1)
				_G.CharacterFrame.EltruismLeech:SetPoint("CENTER", _G.CharacterStatsPane , 70, -120)
				_G.CharacterFrame.EltruismLeech:SetParent(_G.CharacterStatsPane)
				_G.CharacterFrame.EltruismLeech:SetJustifyH("RIGHT")
				_G.CharacterFrame.EltruismLeech:SetShadowColor(0, 0, 0, 1)
				_G.CharacterFrame.EltruismLeech:SetShadowOffset(1, 0)
				_G.CharacterFrame.EltruismLeechDesc = _G.CharacterFrame:CreateFontString(nil,"ARTWORK")
				_G.CharacterFrame.EltruismLeechDesc:SetFont(E.LSM:Fetch('font', E.db.general.font), 10)
				_G.CharacterFrame.EltruismLeechDesc:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
				_G.CharacterFrame.EltruismLeechDesc:SetPoint("CENTER", _G.CharacterStatsPane , -67, -120)
				_G.CharacterFrame.EltruismLeechDesc:SetParent(_G.CharacterStatsPane)
				_G.CharacterFrame.EltruismLeechDesc:SetText(STAT_LIFESTEAL)
				_G.CharacterFrame.EltruismLeechDesc:SetJustifyH("LEFT")
				_G.CharacterFrame.EltruismLeechDesc:SetShadowColor(0, 0, 0, 1)
				_G.CharacterFrame.EltruismLeechDesc:SetShadowOffset(1, 0)

				_G.CharacterFrame.EltruismStatusLine1Left = _G.CharacterFrame:CreateTexture(nil, 'BORDER')
				_G.CharacterFrame.EltruismStatusLine1Left:SetSize(80, 14)
				_G.CharacterFrame.EltruismStatusLine1Left:SetPoint("RIGHT", _G.CharacterStatsPane, "CENTER", 0, -120)
				_G.CharacterFrame.EltruismStatusLine1Left:SetTexture(E.Media.Textures.White8x8)
				_G.CharacterFrame.EltruismStatusLine1Left:SetGradientAlpha('Horizontal', 0.8, 0.8, 0.8, 0, 0.8, 0.8, 0.8, 0.25)
				_G.CharacterFrame.EltruismStatusLine1Left:SetParent(_G.CharacterStatsPane)
				_G.CharacterFrame.EltruismStatusLine1Right = _G.CharacterFrame:CreateTexture(nil, 'BORDER')
				_G.CharacterFrame.EltruismStatusLine1Right:SetSize(80, 14)
				_G.CharacterFrame.EltruismStatusLine1Right:SetPoint("LEFT", _G.CharacterStatsPane, "CENTER", 0, -120)
				_G.CharacterFrame.EltruismStatusLine1Right:SetTexture(E.Media.Textures.White8x8)
				_G.CharacterFrame.EltruismStatusLine1Right:SetGradientAlpha('Horizontal', 0.8, 0.8, 0.8, 0.25, 0.8, 0.8, 0.8, 0)
				_G.CharacterFrame.EltruismStatusLine1Right:SetParent(_G.CharacterStatsPane)

				_G.CharacterFrame.EltruismSpeed = _G.CharacterFrame:CreateFontString(nil,"ARTWORK")
				_G.CharacterFrame.EltruismSpeed:SetFont(E.LSM:Fetch('font', E.db.general.font), 10)
				_G.CharacterFrame.EltruismSpeed:SetTextColor(1, 1, 1)
				_G.CharacterFrame.EltruismSpeed:SetPoint("CENTER", _G.CharacterStatsPane , 70, -133)
				_G.CharacterFrame.EltruismSpeed:SetParent(_G.CharacterStatsPane)
				_G.CharacterFrame.EltruismSpeed:SetJustifyH("RIGHT")
				_G.CharacterFrame.EltruismSpeed:SetShadowColor(0, 0, 0, 1)
				_G.CharacterFrame.EltruismSpeed:SetShadowOffset(1, 0)
				_G.CharacterFrame.EltruismSpeedDesc = _G.CharacterFrame:CreateFontString(nil,"ARTWORK")
				_G.CharacterFrame.EltruismSpeedDesc:SetFont(E.LSM:Fetch('font', E.db.general.font), 10)
				_G.CharacterFrame.EltruismSpeedDesc:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
				_G.CharacterFrame.EltruismSpeedDesc:SetPoint("CENTER", _G.CharacterStatsPane , -66, -133)
				_G.CharacterFrame.EltruismSpeedDesc:SetParent(_G.CharacterStatsPane)
				_G.CharacterFrame.EltruismSpeedDesc:SetText(STAT_SPEED)
				_G.CharacterFrame.EltruismSpeedDesc:SetJustifyH("LEFT")
				_G.CharacterFrame.EltruismSpeedDesc:SetShadowColor(0, 0, 0, 1)
				_G.CharacterFrame.EltruismSpeedDesc:SetShadowOffset(1, 0)

				_G.CharacterFrame.EltruismBlock = _G.CharacterFrame:CreateFontString(nil,"ARTWORK")
				_G.CharacterFrame.EltruismBlock:SetFont(E.LSM:Fetch('font', E.db.general.font), 10)
				_G.CharacterFrame.EltruismBlock:SetTextColor(1, 1, 1)
				_G.CharacterFrame.EltruismBlock:SetPoint("CENTER", _G.CharacterStatsPane , 70, -146)
				_G.CharacterFrame.EltruismBlock:SetParent(_G.CharacterStatsPane)
				_G.CharacterFrame.EltruismBlock:SetJustifyH("RIGHT")
				_G.CharacterFrame.EltruismBlock:SetShadowColor(0, 0, 0, 1)
				_G.CharacterFrame.EltruismBlock:SetShadowOffset(1, 0)
				_G.CharacterFrame.EltruismBlockDesc = _G.CharacterFrame:CreateFontString(nil,"ARTWORK")
				_G.CharacterFrame.EltruismBlockDesc:SetFont(E.LSM:Fetch('font', E.db.general.font), 10)
				_G.CharacterFrame.EltruismBlockDesc:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
				_G.CharacterFrame.EltruismBlockDesc:SetPoint("CENTER", _G.CharacterStatsPane , -69, -146)
				_G.CharacterFrame.EltruismBlockDesc:SetParent(_G.CharacterStatsPane)
				_G.CharacterFrame.EltruismBlockDesc:SetText(STAT_BLOCK)
				_G.CharacterFrame.EltruismBlockDesc:SetJustifyH("LEFT")
				_G.CharacterFrame.EltruismBlockDesc:SetShadowColor(0, 0, 0, 1)
				_G.CharacterFrame.EltruismBlockDesc:SetShadowOffset(1, 0)

				_G.CharacterFrame.EltruismStatusLine2Left = _G.CharacterFrame:CreateTexture(nil, 'BORDER')
				_G.CharacterFrame.EltruismStatusLine2Left:SetSize(80, 14)
				_G.CharacterFrame.EltruismStatusLine2Left:SetPoint("RIGHT", _G.CharacterStatsPane, "CENTER", 0, -146)
				_G.CharacterFrame.EltruismStatusLine2Left:SetTexture(E.Media.Textures.White8x8)
				_G.CharacterFrame.EltruismStatusLine2Left:SetGradientAlpha('Horizontal', 0.8, 0.8, 0.8, 0, 0.8, 0.8, 0.8, 0.25)
				_G.CharacterFrame.EltruismStatusLine2Left:SetParent(_G.CharacterStatsPane)
				_G.CharacterFrame.EltruismStatusLine2Right = _G.CharacterFrame:CreateTexture(nil, 'BORDER')
				_G.CharacterFrame.EltruismStatusLine2Right:SetSize(80, 14)
				_G.CharacterFrame.EltruismStatusLine2Right:SetPoint("LEFT", _G.CharacterStatsPane, "CENTER", 0, -146)
				_G.CharacterFrame.EltruismStatusLine2Right:SetTexture(E.Media.Textures.White8x8)
				_G.CharacterFrame.EltruismStatusLine2Right:SetGradientAlpha('Horizontal', 0.8, 0.8, 0.8, 0.25, 0.8, 0.8, 0.8, 0)
				_G.CharacterFrame.EltruismStatusLine2Right:SetParent(_G.CharacterStatsPane)

				_G.CharacterFrame.EltruismAvoidance = _G.CharacterFrame:CreateFontString(nil,"ARTWORK")
				_G.CharacterFrame.EltruismAvoidance:SetFont(E.LSM:Fetch('font', E.db.general.font), 10)
				_G.CharacterFrame.EltruismAvoidance:SetTextColor(1, 1, 1)
				_G.CharacterFrame.EltruismAvoidance:SetPoint("CENTER", _G.CharacterStatsPane , 70, -159)
				_G.CharacterFrame.EltruismAvoidance:SetParent(_G.CharacterStatsPane)
				_G.CharacterFrame.EltruismAvoidance:SetJustifyH("RIGHT")
				_G.CharacterFrame.EltruismAvoidance:SetShadowColor(0, 0, 0, 1)
				_G.CharacterFrame.EltruismAvoidance:SetShadowOffset(1, 0)
				_G.CharacterFrame.EltruismAvoidanceDesc = _G.CharacterFrame:CreateFontString(nil,"ARTWORK")
				_G.CharacterFrame.EltruismAvoidanceDesc:SetFont(E.LSM:Fetch('font', E.db.general.font), 10)
				_G.CharacterFrame.EltruismAvoidanceDesc:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
				_G.CharacterFrame.EltruismAvoidanceDesc:SetPoint("CENTER", _G.CharacterStatsPane , -56, -159)
				_G.CharacterFrame.EltruismAvoidanceDesc:SetParent(_G.CharacterStatsPane)
				_G.CharacterFrame.EltruismAvoidanceDesc:SetText(STAT_AVOIDANCE)
				_G.CharacterFrame.EltruismAvoidanceDesc:SetJustifyH("LEFT")
				_G.CharacterFrame.EltruismAvoidanceDesc:SetShadowColor(0, 0, 0, 1)
				_G.CharacterFrame.EltruismAvoidanceDesc:SetShadowOffset(1, 0)

				_G.CharacterFrame.EltruismParry = _G.CharacterFrame:CreateFontString(nil,"ARTWORK")
				_G.CharacterFrame.EltruismParry:SetFont(E.LSM:Fetch('font', E.db.general.font), 10)
				_G.CharacterFrame.EltruismParry:SetTextColor(1, 1, 1)
				_G.CharacterFrame.EltruismParry:SetPoint("CENTER", _G.CharacterStatsPane , 70, -172)
				_G.CharacterFrame.EltruismParry:SetParent(_G.CharacterStatsPane)
				_G.CharacterFrame.EltruismParry:SetJustifyH("RIGHT")
				_G.CharacterFrame.EltruismParry:SetShadowColor(0, 0, 0, 1)
				_G.CharacterFrame.EltruismParry:SetShadowOffset(1, 0)
				_G.CharacterFrame.EltruismParryDesc = _G.CharacterFrame:CreateFontString(nil,"ARTWORK")
				_G.CharacterFrame.EltruismParryDesc:SetFont(E.LSM:Fetch('font', E.db.general.font), 10)
				_G.CharacterFrame.EltruismParryDesc:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
				_G.CharacterFrame.EltruismParryDesc:SetPoint("CENTER", _G.CharacterStatsPane , -69, -172)
				_G.CharacterFrame.EltruismParryDesc:SetParent(_G.CharacterStatsPane)
				_G.CharacterFrame.EltruismParryDesc:SetText(STAT_PARRY)
				_G.CharacterFrame.EltruismParryDesc:SetJustifyH("LEFT")
				_G.CharacterFrame.EltruismParryDesc:SetShadowColor(0, 0, 0, 1)
				_G.CharacterFrame.EltruismParryDesc:SetShadowOffset(1, 0)

				_G.CharacterFrame.EltruismStatusLine3Left = _G.CharacterFrame:CreateTexture(nil, 'BORDER')
				_G.CharacterFrame.EltruismStatusLine3Left:SetSize(80, 14)
				_G.CharacterFrame.EltruismStatusLine3Left:SetPoint("RIGHT", _G.CharacterStatsPane, "CENTER", 0, -172)
				_G.CharacterFrame.EltruismStatusLine3Left:SetTexture(E.Media.Textures.White8x8)
				_G.CharacterFrame.EltruismStatusLine3Left:SetGradientAlpha('Horizontal', 0.8, 0.8, 0.8, 0, 0.8, 0.8, 0.8, 0.25)
				_G.CharacterFrame.EltruismStatusLine3Left:SetParent(_G.CharacterStatsPane)
				_G.CharacterFrame.EltruismStatusLine3Right = _G.CharacterFrame:CreateTexture(nil, 'BORDER')
				_G.CharacterFrame.EltruismStatusLine3Right:SetSize(80, 14)
				_G.CharacterFrame.EltruismStatusLine3Right:SetPoint("LEFT", _G.CharacterStatsPane, "CENTER", 0, -172)
				_G.CharacterFrame.EltruismStatusLine3Right:SetTexture(E.Media.Textures.White8x8)
				_G.CharacterFrame.EltruismStatusLine3Right:SetGradientAlpha('Horizontal', 0.8, 0.8, 0.8, 0.25, 0.8, 0.8, 0.8, 0)
				_G.CharacterFrame.EltruismStatusLine3Right:SetParent(_G.CharacterStatsPane)

		  		hooksecurefunc("PaperDollFrame_UpdateStats", function()
					local dodge = GetDodgeChance();
					_G.CharacterFrame.EltruismDodge:SetText(string.format('%.2f', dodge).."%")

					local leech = GetLifesteal()
					_G.CharacterFrame.EltruismLeech:SetText(string.format('%.2f', leech).."%")

					local speed = ((GetUnitSpeed("player")/7) *100)
					_G.CharacterFrame.EltruismSpeed:SetText(math.ceil(speed).."%")

					local block = GetBlockChance()
					_G.CharacterFrame.EltruismBlock:SetText(string.format('%.2f', block).."%")

					local avoidance = GetCombatRatingBonus(CR_AVOIDANCE)
					_G.CharacterFrame.EltruismAvoidance:SetText(string.format('%.2f', avoidance).."%")

					local parry = GetParryChance()
					_G.CharacterFrame.EltruismParry:SetText(string.format('%.2f', parry).."%")
				end)
			end
		end
	elseif ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
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

			--character frame bg
			CharacterFrameBackgroundTexture:SetTexCoord(0, 0.87, 0, 0.60)
			if alpha == nil then
				CharacterFrameBackgroundTexture:SetAlpha(0.3)
			else
				CharacterFrameBackgroundTexture:SetAlpha(alpha)
			end
			CharacterFrameBackgroundTexture:SetTexture(classBgs[E.myclass])
			CharacterFrameBackgroundTexture:SetAllPoints(_G.CharacterFrame.backdrop)
			CharacterFrameBackgroundTexture:SetDrawLayer("ARTWORK")
		end
		if E.db.ElvUI_EltreumUI.skins.classicarmory then -- this is expand classic armory
			--turns out classic has the functions to get number of points on talent trees
			local function PlayerSpec()
				local spec, points
				local _, _, spent1 = GetTalentTabInfo(1)
				local _, _, spent2 = GetTalentTabInfo(2)
				local _, _, spent3 = GetTalentTabInfo(3)

				for i=1, GetNumTalentTabs() do
					local name, _, spent = GetTalentTabInfo(i)
					--print(spent..name.." 1")
					if spent > 0 and (not points or spent > points) then
						--print(spec..points.." 2")
						spec, points = name, spent
					end
				end
				if spec ~= nil and not ( (spent1 == spent2) or (spent2 == spent3) or (spent1 == spent3) ) then
					return spec
				elseif spent1 == spent2 or spent2 == spent3 or spent1 == spent3 then
					if spent1 == spent3 and spent1 == spent2 then
						return L["None"]
					elseif (spent1 == spent2) and (spent1 > spent3 or spent3 > spent1) then
						if spent1 > spent3 then
							return L["Hybrid"]
						elseif spent3 > spent1 then
							return spec
						end
					elseif (spent2 == spent3) and (spent1 > spent3 or spent3 > spent1) then
						if spent1 > spent3 then
							return spec
						elseif spent3 > spent1 then
							return L["Hybrid"]
						end
					elseif (spent1 == spent3) and (spent1 > spent3 or spent3 > spent1) then
						if spent1 > spent2 then
							return L["Hybrid"]
						elseif spent2 > spent1 then
							return spec
						end
					elseif (spent1 == spent3 and spent1 == spent2) or (spent2 == spent3 and spent2 == spent1) then
						return L["Hybrid"]
					else
						return spec
					end
				else
					return L["None"]
				end
			end

			--set the tabs
			if E.db.ElvUI_EltreumUI.skins.classicarmoryautostats then
					SetCVar("playerStatLeftDropdown", "PLAYERSTAT_BASE_STATS")
				if E.myclass == "MAGE" or E.myclass == "PRIEST" or E.myclass == "WARLOCK" or E.myclass == "DRUID" or E.myclass == "SHAMAN" then
					SetCVar("playerStatRightDropdown", "PLAYERSTAT_SPELL_COMBAT")
				elseif ( E.myclass == "HUNTER" ) then
					SetCVar("playerStatRightDropdown", "PLAYERSTAT_RANGED_COMBAT")
				else
					SetCVar("playerStatRightDropdown", "PLAYERSTAT_MELEE_COMBAT")
				end
			end

			if ElvUI_EltreumUI.TBC then
				--_G.PlayerTitleDropDown:Show()
				_G.PlayerTitleDropDown:ClearAllPoints()
				_G.PlayerTitleDropDown:SetParent(_G.CharacterModelFrame)
				_G.PVPFrameToggleButton:ClearAllPoints()
				_G.PVPFrameToggleButton:SetPoint('TOP', _G.PVPHonor, 'TOP', 52, 42)
				_G.PVPFrameToggleButton:SetParent(_G.PVPFrameHonor)
			elseif ElvUI_EltreumUI.Classic then
				--_G.CharacterTitleText:Show()
				_G.CharacterTitleText:ClearAllPoints()
				_G.CharacterTitleText:SetParent(_G.CharacterModelFrame)
			end
			_G.CharacterNameText:ClearAllPoints()
			_G.CharacterLevelText:ClearAllPoints()
			_G.CharacterNameText:SetPoint('TOP', _G.CharacterModelFrame, 0, 80)
			_G.CharacterNameText:SetParent(_G.CharacterModelFrame)
			_G.CharacterLevelText:SetPoint('TOP', _G.CharacterModelFrame, 0, 60)
			_G.CharacterLevelText:SetParent(_G.CharacterModelFrame)
			if ElvUI_EltreumUI.TBC then
				_G.PlayerTitleDropDown:SetPoint('TOP', _G.CharacterModelFrame, -6, 40)
			elseif ElvUI_EltreumUI.Classic then
				_G.CharacterTitleText:SetPoint('TOP', _G.CharacterModelFrame, 0, 40)
			end

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

--inspect bg
local EltruismInspectBg = CreateFrame("Frame", "EltruismInspectBg")
EltruismInspectBg:SetParent(_G.InspectFrame)
local EltruismInspectBgTexture = EltruismInspectBg:CreateTexture()
function ElvUI_EltreumUI:InspectBg(unit)
	--local a = IsAddOnLoaded("Blizzard_InspectUI")
	--if a == false and UnitExists("target") then
		--LoadAddOn("Blizzard_InspectUI")
		--a = IsAddOnLoaded("Blizzard_InspectUI")
	--end
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
		--inspect frame bg
		--print(unit)
		if IsAddOnLoaded("Blizzard_InspectUI") then
			--local localizedClass, englishClass, localizedRace, englishRace, sex, name, realm = GetPlayerInfoByGUID(unit)
			local _, englishClass, _, _, _, _, _ = GetPlayerInfoByGUID(unit)
			--print(englishClass)
			--local _, targetclass = UnitClass("target")
			if englishClass then
				if _G.InspectFrame then
					--EltruismInspectBgTexture:SetTexture(classBgs[targetclass])
					EltruismInspectBgTexture:SetTexture(classBgs[englishClass])
					EltruismInspectBgTexture:SetTexCoord(0, 0.87, 0, 0.60)
					if alpha ~= nil then
						EltruismInspectBgTexture:SetAlpha(alpha)
					else
						EltruismInspectBgTexture:SetAlpha(0.3)
					end
					if ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
						EltruismInspectBgTexture:SetAllPoints(_G.InspectFrame.backdrop)
						EltruismInspectBgTexture:SetParent(_G.InspectFrame)
					elseif ElvUI_EltreumUI.Retail then
						_G.InspectModelFrameBackgroundBotLeft:Hide()
						_G.InspectModelFrameBackgroundBotRight:Hide()
						_G.InspectModelFrameBackgroundTopLeft:Hide()
						_G.InspectModelFrameBackgroundTopRight:Hide()
						_G.InspectModelFrameBackgroundOverlay:Hide()
						--_G.InspectModelFrame.backdrop:Hide()
						_G.InspectModelFrame.backdrop:SetParent(_G.InspectFrame)
						_G.InspectModelFrame.backdrop:SetAllPoints(_G.InspectFrame)
						_G.InspectModelFrame.backdrop:SetAlpha(0.2)
						EltruismInspectBgTexture:SetParent(_G.InspectFrame)
						EltruismInspectBgTexture:SetAllPoints(_G.InspectFrame)
					end
					EltruismInspectBgTexture:SetDrawLayer("ARTWORK")
				end
			end
		end
	end
end

