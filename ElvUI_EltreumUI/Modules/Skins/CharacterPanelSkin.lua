local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local classcolor = E:ClassColor(E.myclass, true)

--improving character panel
local CharacterFrame = _G.CharacterFrame
local CharacterFrameBackgroundTexture = CharacterFrame:CreateTexture()
local ClassCrestFrame = CreateFrame("Frame")
local ClassCrestFrameTexture = ClassCrestFrame:CreateTexture()

if E.Retail then
	_G.CharacterFrame.EltruismClassResource = _G.CharacterFrame:CreateFontString(nil,"ARTWORK")
	_G.CharacterFrame.EltruismClassResourceDesc = _G.CharacterFrame:CreateFontString(nil,"ARTWORK")
	_G.CharacterFrame.EltruismClassResourceDescTooltip = CreateFrame("Frame", "EltruismClassResourceDesc")
	_G.CharacterFrame.EltruismClassResource2 = _G.CharacterFrame:CreateFontString(nil,"ARTWORK")
	_G.CharacterFrame.EltruismClassResourceDesc2 = _G.CharacterFrame:CreateFontString(nil,"ARTWORK")
	_G.CharacterFrame.EltruismClassResourceDescTooltip2 = CreateFrame("Frame", "EltruismClassResourceDesc2")
	--_G.CharacterFrame.EltruismExtraStats = _G.CharacterFrame:CreateTexture(nil, 'BORDER')
	_G.CharacterFrame.EltruismExtraStats = 	CreateFrame("StatusBar", nil, _G.CharacterStatsPane)
	_G.CharacterFrame.EltruismExtraStats2 = CreateFrame("StatusBar", nil, _G.CharacterStatsPane)
	_G.CharacterFrame.EltruismExtraStatsFont = _G.CharacterFrame:CreateFontString(nil,"ARTWORK")
	_G.CharacterFrame.EltruismSpeed = _G.CharacterFrame:CreateFontString(nil,"ARTWORK")
	_G.CharacterFrame.EltruismSpeedDesc = _G.CharacterFrame:CreateFontString(nil,"ARTWORK")
	_G.CharacterFrame.EltruismSpeedDescTooltip = CreateFrame("Frame", "EltruismSpeedDesc")
end

if E.TBC or E.Classic then
	CharacterFrame.Text = CharacterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	CharacterFrame.Text2 = CharacterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	CharacterFrame.Text3 = CharacterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	CharacterFrame.Text4 = CharacterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	CharacterFrame.Text5 = CharacterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	CharacterFrame.StatusLine = CreateFrame("StatusBar", "EltruismCharacterBar1", CharacterFrame)
	CharacterFrame.StatusLine2 = CreateFrame("StatusBar", "EltruismCharacterBar2", CharacterFrame)
	CharacterFrame.StatusLine3 = CreateFrame("StatusBar", "EltruismCharacterBar3", CharacterFrame)
	CharacterFrame.StatusLine4 = CreateFrame("StatusBar", "EltruismCharacterBar4", CharacterFrame)
end

if E.TBC then
	_G.PlayerStatFrameLeft2.StatusLine = CreateFrame("StatusBar", "EltruismStatLine12", CharacterFrame)
	_G.PlayerStatFrameLeft4.StatusLine = CreateFrame("StatusBar", "EltruismStatLine22", CharacterFrame)
	_G.PlayerStatFrameLeft6.StatusLine = CreateFrame("StatusBar", "EltruismStatLine32", CharacterFrame)
	_G.PlayerStatFrameRight2.StatusLine = CreateFrame("StatusBar", "EltruismStatLine52", CharacterFrame)
	_G.PlayerStatFrameRight4.StatusLine = CreateFrame("StatusBar", "EltruismStatLine62", CharacterFrame)
	_G.PlayerStatFrameRight6.StatusLine = CreateFrame("StatusBar", "EltruismStatLine7", CharacterFrame)
end

if E.Classic then
	_G.CharacterArmorFrame.StatusLine = CreateFrame("StatusBar", "EltruismStatLine3", CharacterFrame)
	_G.CharacterAttackPowerFrame.StatusLine = CreateFrame("StatusBar", "EltruismStatLine4", CharacterFrame)
	_G.CharacterRangedAttackFrame.StatusLine = CreateFrame("StatusBar", "EltruismStatLine5", CharacterFrame)
	_G.CharacterRangedDamageFrame.StatusLine = CreateFrame("StatusBar", "EltruismStatLine6", CharacterFrame)
	_G.CharacterStatFrame2.StatusLine = CreateFrame("StatusBar", "EltruismStatLine1", CharacterFrame)
	_G.CharacterStatFrame4.StatusLine = CreateFrame("StatusBar", "EltruismStatLine2", CharacterFrame)
end

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

local classCrests = {
	['WARRIOR'] = "Artifacts-Warrior-BG-rune",
	['PALADIN'] = "Artifacts-Paladin-BG-rune",
	['HUNTER'] = "Artifacts-Hunter-BG-rune",
	['ROGUE'] = "Artifacts-Rogue-BG-rune",
	['PRIEST'] = "Artifacts-Priest-BG-rune",
	['DEATHKNIGHT'] = "Artifacts-DeathKnightFrost-BG-Rune",
	['SHAMAN'] = "Artifacts-Shaman-BG-rune",
	['MAGE'] = "Artifacts-MageArcane-BG-rune",
	['WARLOCK'] = "Artifacts-Warlock-BG-rune",
	['MONK'] = "Artifacts-Monk-BG-rune",
	['DRUID'] = "Artifacts-Druid-BG-rune",
	['DEMONHUNTER'] = "Artifacts-DemonHunter-BG-rune",
}

local statgradients = {
	['WARRIOR'] = {r1 = 0.42745098039216, g1 = 0.13725490196078, b1 = 0.090196078431373, r2 = 0.56470588235294, g2 = 0.43137254901961, b2 = 0.24705882352941},
	['PALADIN'] = {r1 = 1, g1 = 0.26666666666667, b1 = 0.53725490196078, r2 = 0.95686274509804, g2 = 0.54901960784314, b2 = 0.72941176470588},
	['HUNTER'] = {r1 = 0.28235294117647, g1 = 0.59607843137255, b1 = 0.29411764705882, r2 = 0.78823529411765, g2 = 1, b2 = 0.38823529411765},
	['ROGUE'] = {r1 = 1, g1 = 0.68627450980392, b1 = 0, r2 = 1, g2 = 0.83137254901961, b2 = 0.25490196078431},
	['PRIEST'] = {r1 = 0.3568627450980392, g1 = 0.3568627450980392, b1 = 0.3568627450980392, r2 = 0.98823529411765, g2 = 0.98823529411765, b2 = 0.98823529411765},
	['DEATHKNIGHT'] = {r1 = 0.49803921568627, g1 = 0.074509803921569, b1 = 0.14901960784314, r2 = 1, g2 = 0.1843137254902, b2 = 0.23921568627451},
	['SHAMAN'] = {r1 = 0, g1 = 0.25882352941176, b1 = 0.50980392156863, r2 = 0.3921568627451, g2 = 0.44313725490196, b2 = 1},
	['MAGE'] = {r1 = 0, g1 = 0.33333333333333, b1 = 0.53725490196078, r2 = 0.49019607843137, g2 = 0.87058823529412, b2 = 1},
	['WARLOCK'] = {r1 = 0.26274509803922, g1 = 0.26666666666667, b1 = 0.46666666666667, r2 = 0.66274509803922, g2= 0.3921568627451, b2 = 0.7843137254902},
	['MONK'] = {r1 = 0, g1 = 0.77254901960784, b1 = 0.45882352941176, r2 = 0.42352941176471, g2 = 0.90980392156863, b2 = 1},
	['DRUID'] = {r1 = 1, g1 = 0.23921568627451, b1 = 0.007843137254902, r2 = 1, g2 = 0.48627450980392, b2 = 0.03921568627451},
	['DEMONHUNTER'] = {r1 = 0.36470588235294, g1 = 0.13725490196078, b1 = 0.57254901960784, r2 = 0.74509803921569, g2 = 0.1921568627451, b2 = 1},
	['NPCFRIENDLY'] = {r1 = 0.30980392156863, g1 = 0.85098039215686, b1 = 0.2, r2 = 0.34117647058824, g2 = 0.62745098039216, b2 = 0.4078431372549},
	['NPCNEUTRAL'] = {r1 = 0.712358744169101, g1 = 0.63137254901961, b1 = 0.15490196078431, r2 = 1, g2 = 0.85686274509804, b2 = 0.2078431372549},
	['NPCUNFRIENDLY'] = {r1 = 0.84313725490196, g1 = 0.30196078431373, b1 = 0, r2 = 0.83137254901961, g2 = 0.45882352941176, b2 = 0},
	['NPCHOSTILE'] = {r1 = 0.31764705882353, g1 = 0.066666666666667, b1 = 0.07843137254902, r2 = 1, g2 = 0.15686274509804, b2 = 0.15686274509804},
}

--adapted from libiteminfo to be player only
function ElvUI_EltreumUI:GetPlayerItemLevel()
	local total, maxlevel = 0, 0
	local level, mainhand, offhand, ranged

	for i = 1, 15 do
		if (i ~= 4) then
			local linkloop = GetInventoryItemLink("player", i)
			if linkloop then
				level = select(4, GetItemInfo(linkloop))
			else
				level = -1
			end
			if level == nil then
				level = -1
			end

			if level > 0 then
				total = total + level
				maxlevel = max(maxlevel, level)
			end
		end
	end

	local mainlevel = 0
	local mainlink = GetInventoryItemLink("player", 16)
	if mainlink then
		mainlevel = select(4, GetItemInfo(mainlink))
	end
	mainhand = (tonumber(mainlevel))
	if mainhand == nil then
		mainhand = 0
	end

	local offhandlink = GetInventoryItemLink("player", 17)
	local offhandlevel = 0
	if offhandlink then
		offhandlevel = select(4, GetItemInfo(offhandlink))
	end
	offhand = (tonumber(offhandlevel))
	if offhand == nil then
		offhand = 0
	end

	local rangedlevel = 0
	local rangedlink = GetInventoryItemLink("player", 18)
	if rangedlink then
		rangedlevel = select(4, GetItemInfo(rangedlink))
	end
	ranged = (tonumber(rangedlevel))
	if ranged == nil then
		ranged = 0
	end

	if (mainhand <= 0 and ranged <= 0 and ranged <= 0) then
	elseif (mainhand > 0 and offhand > 0) then
		total = total + mainhand + offhand
	elseif (offhand > 0 and ranged > 0) then
		total = total + offhand + ranged
	else
		total = total + max(mainhand,offhand,ranged) * 2
	end
	return total/16, max(mainhand,offhand), maxlevel
end

if not E.Retail then
	local avgilvl = CreateFrame("FRAME")
	avgilvl:RegisterEvent("PLAYER_ENTERING_WORLD")
	avgilvl:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
	avgilvl:SetScript("OnEvent", function()
		local ilevel = ElvUI_EltreumUI:GetPlayerItemLevel()
		_G.CharacterFrame.Text2:SetText((math.floor(ilevel*100))/100)
		--_G.CharacterFrame.Text2:SetText((math.floor(ElvUI_EltreumUI:GetPlayerItemLevel()*100))/100)
	end)
end


--expanded armory
function ElvUI_EltreumUI:ExpandedCharacterStats()
	if not E.private.skins.blizzard.enable == false then
		if E.Retail then
			--add class crest
			if E.db.ElvUI_EltreumUI.skins.expandarmorycrest then
				ClassCrestFrame:SetSize(256, 256)
				ClassCrestFrame:SetPoint("CENTER", _G.CharacterModelFrame, 0, 50)
				ClassCrestFrame:SetParent(_G.CharacterFrame)
				ClassCrestFrameTexture:SetAtlas(classCrests[E.myclass], true)
				ClassCrestFrameTexture:SetAllPoints(ClassCrestFrame)
				ClassCrestFrameTexture:SetDrawLayer("BACKGROUND")
			end

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
				_G.CharacterModelFrame:SetPosition(-0.25, 0, -0.10) -- zoom, x, y
				--_G.CharacterModelFrame:SetPosition(-0.55, 0, -0.10) -- zoom, x, y

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
				local alphabg = E.db.ElvUI_EltreumUI.skins.expandarmorybgalpha
				if alphabg == nil then
					alphabg = 0.3
				end

				--add class bg texture
				CharacterFrameBackgroundTexture:SetTexture(classBgs[E.myclass])
				CharacterFrameBackgroundTexture:SetTexCoord(0, 0.87, 0, 0.60)
				CharacterFrameBackgroundTexture:SetAlpha(alphabg)
				CharacterFrameBackgroundTexture:SetAllPoints(_G.CharacterFrame)
				CharacterFrameBackgroundTexture:SetParent(_G.CharacterFrame)
				CharacterFrameBackgroundTexture:SetDrawLayer("ARTWORK")

				_G.CharacterModelFrame.backdrop:Hide()
				_G.CharacterModelFrameBackgroundTopLeft:Hide()
				_G.CharacterModelFrameBackgroundOverlay:Hide()

				--ItemLevelCategory
				--color the avg item level
				_G.CharacterStatsPane.ItemLevelFrame.leftGrad:SetGradientAlpha('Horizontal', classcolor.r, classcolor.g, classcolor.b, 0.4, classcolor.r, classcolor.g, classcolor.b, 0)
				_G.CharacterStatsPane.ItemLevelFrame.rightGrad:SetGradientAlpha('Horizontal', classcolor.r, classcolor.g, classcolor.b, 0, classcolor.r, classcolor.g, classcolor.b, 0.4)
				--remove backgrounds and make font nice
				_G.CharacterStatsPane.ItemLevelCategory.backdrop:Hide()
				_G.CharacterStatsPane.ItemLevelCategory.backdrop:Hide()
				if not _G.CharacterStatsPane.ItemLevelCategory.Title:GetText():match("|r") then
					_G.CharacterStatsPane.ItemLevelCategory.Title:SetText(E:TextGradient(_G.CharacterStatsPane.ItemLevelCategory.Title:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
				end
				_G.CharacterStatsPane.ItemLevelCategory.Title:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, E.db.general.fontStyle)
				--statusbars
				_G.CharacterStatsPane.ItemLevelCategory.Title.StatusLine = CreateFrame("StatusBar", "EltruismItemLevelCategoryLine", _G.CharacterStatsPane)
				_G.CharacterStatsPane.ItemLevelCategory.Title.StatusLine:SetSize(50, 4)
				_G.CharacterStatsPane.ItemLevelCategory.Title.StatusLine:SetPoint("RIGHT", _G.CharacterStatsPane.ItemLevelCategory.Title, "LEFT", 0, -1)
				_G.CharacterStatsPane.ItemLevelCategory.Title.StatusLine:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga")
				_G.CharacterStatsPane.ItemLevelCategory.Title.StatusLine:GetStatusBarTexture():SetGradient("HORIZONTAL", statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"])
				_G.CharacterStatsPane.ItemLevelCategory.Title.StatusLine2 = CreateFrame("StatusBar", "EltruismItemLevelCategoryLine2", _G.CharacterStatsPane)
				_G.CharacterStatsPane.ItemLevelCategory.Title.StatusLine2:SetSize(50, 4)
				_G.CharacterStatsPane.ItemLevelCategory.Title.StatusLine2:SetPoint("LEFT", _G.CharacterStatsPane.ItemLevelCategory.Title, "RIGHT", 0, -1)
				_G.CharacterStatsPane.ItemLevelCategory.Title.StatusLine2:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga")
				_G.CharacterStatsPane.ItemLevelCategory.Title.StatusLine2:GetStatusBarTexture():SetGradient("HORIZONTAL", statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"], statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"])

				--attributes
				--remove backgrounds and make font nice
				_G.CharacterStatsPane.AttributesCategory.backdrop:Hide()
				_G.CharacterStatsPane.AttributesCategory.backdrop:Hide()
				if not _G.CharacterStatsPane.AttributesCategory.Title:GetText():match("|r") then
					_G.CharacterStatsPane.AttributesCategory.Title:SetText(E:TextGradient(_G.CharacterStatsPane.AttributesCategory.Title:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
				end
				_G.CharacterStatsPane.AttributesCategory.Title:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, E.db.general.fontStyle)
				--statusbars
				_G.CharacterStatsPane.AttributesCategory.Title.StatusLine = CreateFrame("StatusBar", "EltruismAttributesCategoryLine", _G.CharacterStatsPane)
				_G.CharacterStatsPane.AttributesCategory.Title.StatusLine:SetSize(50, 4)
				_G.CharacterStatsPane.AttributesCategory.Title.StatusLine:SetPoint("RIGHT", _G.CharacterStatsPane.AttributesCategory.Title, "LEFT", 0, -1)
				_G.CharacterStatsPane.AttributesCategory.Title.StatusLine:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga")
				_G.CharacterStatsPane.AttributesCategory.Title.StatusLine:GetStatusBarTexture():SetGradient("HORIZONTAL", statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"])
				_G.CharacterStatsPane.AttributesCategory.Title.StatusLine2 = CreateFrame("StatusBar", "EltruismAttributesCategoryLine2", _G.CharacterStatsPane)
				_G.CharacterStatsPane.AttributesCategory.Title.StatusLine2:SetSize(50, 4)
				_G.CharacterStatsPane.AttributesCategory.Title.StatusLine2:SetPoint("LEFT", _G.CharacterStatsPane.AttributesCategory.Title, "RIGHT", 0, -1)
				_G.CharacterStatsPane.AttributesCategory.Title.StatusLine2:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga")
				_G.CharacterStatsPane.AttributesCategory.Title.StatusLine2:GetStatusBarTexture():SetGradient("HORIZONTAL", statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"], statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"])

				--Enhancements
				--remove backgrounds and make font nice
				_G.CharacterStatsPane.EnhancementsCategory.backdrop:Hide()
				_G.CharacterStatsPane.EnhancementsCategory.backdrop:Hide()
				if not _G.CharacterStatsPane.EnhancementsCategory.Title:GetText():match("|r") then
					_G.CharacterStatsPane.EnhancementsCategory.Title:SetText(E:TextGradient(_G.CharacterStatsPane.EnhancementsCategory.Title:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
				end
				_G.CharacterStatsPane.EnhancementsCategory.Title:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, E.db.general.fontStyle)
				--statusbars
				_G.CharacterStatsPane.EnhancementsCategory.Title.StatusLine = CreateFrame("StatusBar", "EltruismEnhancementsCategoryLine", _G.CharacterStatsPane)
				_G.CharacterStatsPane.EnhancementsCategory.Title.StatusLine:SetSize(30, 4)
				_G.CharacterStatsPane.EnhancementsCategory.Title.StatusLine:SetPoint("RIGHT", _G.CharacterStatsPane.EnhancementsCategory.Title, "LEFT", 0, -1)
				_G.CharacterStatsPane.EnhancementsCategory.Title.StatusLine:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga")
				_G.CharacterStatsPane.EnhancementsCategory.Title.StatusLine:GetStatusBarTexture():SetGradient("HORIZONTAL", statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"])
				_G.CharacterStatsPane.EnhancementsCategory.Title.StatusLine2 = CreateFrame("StatusBar", "EltruismEnhancementsCategoryLine2", _G.CharacterStatsPane)
				_G.CharacterStatsPane.EnhancementsCategory.Title.StatusLine2:SetSize(30, 4)
				_G.CharacterStatsPane.EnhancementsCategory.Title.StatusLine2:SetPoint("LEFT", _G.CharacterStatsPane.EnhancementsCategory.Title, "RIGHT", 0, -1)
				_G.CharacterStatsPane.EnhancementsCategory.Title.StatusLine2:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga")
				_G.CharacterStatsPane.EnhancementsCategory.Title.StatusLine2:GetStatusBarTexture():SetGradient("HORIZONTAL", statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"], statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"])



				--hide the backdrop on reputation/currency tab
				hooksecurefunc("CharacterFrameTab_OnClick", function()
					if _G.CharacterFrameInset.backdrop:IsShown() then
						_G.CharacterFrameInset.backdrop:Hide()
					end
				end)

				hooksecurefunc("ReputationFrame_Update", function()
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

				hooksecurefunc('PaperDollFrame_SetLabelAndText', function(statFrame, label)
					if ( statFrame.Label ) then
						--statFrame.Label:SetText(format(STAT_FORMAT, label))
						if not statFrame.Label:GetText():match("|r") then
							statFrame.Label:SetText(E:TextGradient(format(STAT_FORMAT, label), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						end
					end
				end)

				if (not IsAddOnLoaded('DejaCharacterStats')) and (not IsAddOnLoaded("ElvUI_SLE")) then

					--banner other stats
					--[[_G.CharacterFrame.EltruismExtraStats:SetSize(150, 18)
					_G.CharacterFrame.EltruismExtraStats:SetPoint("CENTER", _G.CharacterStatsPane, "CENTER", 0, -80)
					_G.CharacterFrame.EltruismExtraStats:SetTexture(E.Media.Textures.Black8x8)
					_G.CharacterFrame.EltruismExtraStats:SetParent(_G.CharacterStatsPane)]]

					--_G.CharacterFrame.EltruismExtraStatsFont:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize)
					_G.CharacterFrame.EltruismExtraStatsFont:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, E.db.general.fontStyle)
					--_G.CharacterFrame.EltruismExtraStatsFont:SetTextColor(1, 1, 1)
					_G.CharacterFrame.EltruismExtraStatsFont:SetPoint("CENTER", _G.CharacterStatsPane, "CENTER", 0, -80)
					_G.CharacterFrame.EltruismExtraStatsFont:SetParent(_G.CharacterStatsPane)
					--_G.CharacterFrame.EltruismExtraStatsFont:SetText("Other")
					--if not _G.CharacterFrame.EltruismExtraStatsFont:GetText():match("|r") then
						_G.CharacterFrame.EltruismExtraStatsFont:SetText(E:TextGradient("Other", statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
					--end

					_G.CharacterFrame.EltruismExtraStats:SetSize(72, 4)
					_G.CharacterFrame.EltruismExtraStats:SetPoint("RIGHT", _G.CharacterFrame.EltruismExtraStatsFont, "LEFT", 0, -1)
					_G.CharacterFrame.EltruismExtraStats:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga")
					_G.CharacterFrame.EltruismExtraStats:GetStatusBarTexture():SetGradient("HORIZONTAL", statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"])
					_G.CharacterFrame.EltruismExtraStats2:SetSize(72, 4)
					_G.CharacterFrame.EltruismExtraStats2:SetPoint("LEFT", _G.CharacterFrame.EltruismExtraStatsFont, "RIGHT", 0, -1)
					_G.CharacterFrame.EltruismExtraStats2:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga")
					_G.CharacterFrame.EltruismExtraStats2:GetStatusBarTexture():SetGradient("HORIZONTAL", statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"], statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"])

					--movement speed
					_G.CharacterFrame.EltruismSpeed:SetFont(E.LSM:Fetch('font', E.db.general.font), 10)
					_G.CharacterFrame.EltruismSpeed:SetTextColor(1, 1, 1)
					_G.CharacterFrame.EltruismSpeed:SetPoint("CENTER", _G.CharacterStatsPane , 70, -163)
					_G.CharacterFrame.EltruismSpeed:SetParent(_G.CharacterStatsPane)
					_G.CharacterFrame.EltruismSpeed:SetJustifyH("RIGHT")
					_G.CharacterFrame.EltruismSpeed:SetShadowColor(0, 0, 0, 1)
					_G.CharacterFrame.EltruismSpeed:SetShadowOffset(1, 0)

					_G.CharacterFrame.EltruismSpeedDesc:SetFont(E.LSM:Fetch('font', E.db.general.font), 10)
					_G.CharacterFrame.EltruismSpeedDesc:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
					_G.CharacterFrame.EltruismSpeedDesc:SetPoint("CENTER", _G.CharacterStatsPane , -36, -163)
					_G.CharacterFrame.EltruismSpeedDesc:SetParent(_G.CharacterStatsPane)
					--_G.CharacterFrame.EltruismSpeedDesc:SetText(STAT_MOVEMENT_SPEED)
					--if not _G.CharacterFrame.EltruismSpeedDesc:GetText():match("|r") then
						_G.CharacterFrame.EltruismSpeedDesc:SetText(E:TextGradient(STAT_MOVEMENT_SPEED, statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
					--end
					_G.CharacterFrame.EltruismSpeedDesc:SetJustifyH("LEFT")
					_G.CharacterFrame.EltruismSpeedDesc:SetShadowColor(0, 0, 0, 1)
					_G.CharacterFrame.EltruismSpeedDesc:SetShadowOffset(1, 0)

					_G.CharacterFrame.EltruismSpeedDescTooltip:SetSize(190, 15)
					_G.CharacterFrame.EltruismSpeedDescTooltip:SetPoint("CENTER", _G.CharacterStatsPane, "CENTER", 0, -163)
					_G.CharacterFrame.EltruismSpeedDescTooltip:SetParent(_G.CharacterStatsPane)
					_G.CharacterFrame.EltruismSpeedDescTooltip:Show()
					_G.CharacterFrame.EltruismSpeedDescTooltip:SetScript("OnEnter", function()
						_G['GameTooltip']:SetOwner(_G.CharacterFrame.EltruismSpeedDescTooltip, 'ANCHOR_RIGHT')
						_G['GameTooltip']:AddLine(format(CR_SPEED_TOOLTIP, string.format('%.2f', (GetUnitSpeed("player"))), ((GetUnitSpeed("player")/7) *100)))
						_G['GameTooltip']:Show()
					end)
					_G.CharacterFrame.EltruismSpeedDescTooltip:SetScript("OnLeave", function()
						_G['GameTooltip']:Hide()
					end)

					--class resource
					_G.CharacterFrame.EltruismClassResource:SetFont(E.LSM:Fetch('font', E.db.general.font), 10)
					_G.CharacterFrame.EltruismClassResource:SetTextColor(1, 1, 1)
					_G.CharacterFrame.EltruismClassResource:SetPoint("CENTER", _G.CharacterStatsPane , 72, -176)
					_G.CharacterFrame.EltruismClassResource:SetParent(_G.CharacterStatsPane)
					_G.CharacterFrame.EltruismClassResource:SetJustifyH("RIGHT")
					_G.CharacterFrame.EltruismClassResource:SetShadowColor(0, 0, 0, 1)
					_G.CharacterFrame.EltruismClassResource:SetShadowOffset(1, 0)
					_G.CharacterFrame.EltruismClassResourceDesc:SetFont(E.LSM:Fetch('font', E.db.general.font), 10)
					_G.CharacterFrame.EltruismClassResourceDesc:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
					_G.CharacterFrame.EltruismClassResourceDesc:SetPoint("CENTER", _G.CharacterStatsPane , -46, -176)
					_G.CharacterFrame.EltruismClassResourceDesc:SetParent(_G.CharacterStatsPane)
					if E.myclass == 'HUNTER' then
						--_G.CharacterFrame.EltruismClassResourceDesc:SetText(STAT_FOCUS_REGEN)
						--if not _G.CharacterFrame.EltruismClassResourceDesc:GetText():match("|r") then
							_G.CharacterFrame.EltruismClassResourceDesc:SetText(E:TextGradient(STAT_FOCUS_REGEN, statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						--end
					elseif E.myclass == 'ROGUE' or E.myclass == 'DRUID' or E.myclass == 'MONK' then
						--_G.CharacterFrame.EltruismClassResourceDesc:SetText(STAT_ENERGY_REGEN)
						--if not _G.CharacterFrame.EltruismClassResourceDesc:GetText():match("|r") then
							_G.CharacterFrame.EltruismClassResourceDesc:SetText(E:TextGradient(STAT_ENERGY_REGEN, statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						--end
					elseif E.myclass == 'DEATHKNIGHT' then
						--_G.CharacterFrame.EltruismClassResourceDesc:SetText(STAT_RUNE_REGEN)
						--if not _G.CharacterFrame.EltruismClassResourceDesc:GetText():match("|r") then
							_G.CharacterFrame.EltruismClassResourceDesc:SetText(E:TextGradient(STAT_RUNE_REGEN, statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						--end
					elseif E.myclass == 'MAGE' or E.myclass == 'SHAMAN' or E.myclass == 'WARLOCK' or E.myclass == 'PALADIN' or E.myclass == 'PRIEST' then
						--_G.CharacterFrame.EltruismClassResourceDesc:SetText(MANA_REGEN)
						--if not _G.CharacterFrame.EltruismClassResourceDesc:GetText():match("|r") then
							_G.CharacterFrame.EltruismClassResourceDesc:SetText(E:TextGradient(MANA_REGEN, statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						--end
					end
					_G.CharacterFrame.EltruismClassResourceDesc:SetJustifyH("LEFT")
					_G.CharacterFrame.EltruismClassResourceDesc:SetShadowColor(0, 0, 0, 1)
					_G.CharacterFrame.EltruismClassResourceDesc:SetShadowOffset(1, 0)

					--class resource tooltip
					_G.CharacterFrame.EltruismClassResourceDescTooltip:SetSize(190, 15)
					_G.CharacterFrame.EltruismClassResourceDescTooltip:SetPoint("CENTER", _G.CharacterStatsPane, "CENTER", 0, -176)
					_G.CharacterFrame.EltruismClassResourceDescTooltip:SetParent(_G.CharacterStatsPane)
					if E.myclass == 'HUNTER' or E.myclass == 'ROGUE' or E.myclass == 'DRUID' or E.myclass == 'MONK' or E.myclass == 'DEATHKNIGHT' or E.myclass == 'MAGE' or E.myclass == 'SHAMAN' or E.myclass == 'WARLOCK' or E.myclass == 'PALADIN' or E.myclass == 'PRIEST' then
						_G.CharacterFrame.EltruismClassResource:Show()
						_G.CharacterFrame.EltruismClassResourceDesc:Show()
						_G.CharacterFrame.EltruismClassResourceDescTooltip:Show()
					else
						_G.CharacterFrame.EltruismClassResource:Hide()
						_G.CharacterFrame.EltruismClassResourceDesc:Hide()
						_G.CharacterFrame.EltruismClassResourceDescTooltip:Hide()
					end
					_G.CharacterFrame.EltruismClassResourceDescTooltip:SetScript("OnEnter", function()
						_G['GameTooltip']:SetOwner(_G.CharacterFrame.EltruismClassResourceDescTooltip, 'ANCHOR_RIGHT')
						if E.myclass == 'HUNTER' then
							_G['GameTooltip']:AddLine(STAT_FOCUS_REGEN_TOOLTIP)
						elseif E.myclass == 'ROGUE' or E.myclass == 'DRUID' or E.myclass == 'MONK' then
							_G['GameTooltip']:AddLine(STAT_ENERGY_REGEN_TOOLTIP)
						elseif E.myclass == 'DEATHKNIGHT' then
							_G['GameTooltip']:AddLine(STAT_RUNE_REGEN_TOOLTIP)
						elseif E.myclass == 'MAGE' or E.myclass == 'SHAMAN' or E.myclass == 'WARLOCK' or E.myclass == 'PALADIN' or E.myclass == 'PRIEST' then
							_G['GameTooltip']:AddLine(MANA_REGEN_TOOLTIP)
						end
						_G['GameTooltip']:Show()
					end)
					_G.CharacterFrame.EltruismClassResourceDescTooltip:SetScript("OnLeave", function()
						_G['GameTooltip']:Hide()
					end)

					--class resource 2, because druids and monks are not nice
					_G.CharacterFrame.EltruismClassResource2:SetFont(E.LSM:Fetch('font', E.db.general.font), 10)
					_G.CharacterFrame.EltruismClassResource2:SetTextColor(1, 1, 1)
					_G.CharacterFrame.EltruismClassResource2:SetPoint("CENTER", _G.CharacterStatsPane , 72, -189)
					_G.CharacterFrame.EltruismClassResource2:SetParent(_G.CharacterStatsPane)
					_G.CharacterFrame.EltruismClassResource2:SetJustifyH("RIGHT")
					_G.CharacterFrame.EltruismClassResource2:SetShadowColor(0, 0, 0, 1)
					_G.CharacterFrame.EltruismClassResource2:SetShadowOffset(1, 0)

					_G.CharacterFrame.EltruismClassResourceDesc2:SetFont(E.LSM:Fetch('font', E.db.general.font), 10)
					_G.CharacterFrame.EltruismClassResourceDesc2:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
					_G.CharacterFrame.EltruismClassResourceDesc2:SetPoint("CENTER", _G.CharacterStatsPane , -48, -189)
					_G.CharacterFrame.EltruismClassResourceDesc2:SetParent(_G.CharacterStatsPane)
					if E.myclass == 'DRUID' or E.myclass == 'MONK' then
						--_G.CharacterFrame.EltruismClassResourceDesc2:SetText(MANA_REGEN)
						--if not _G.CharacterFrame.EltruismClassResourceDesc:GetText():match("|r") then
							_G.CharacterFrame.EltruismClassResourceDesc2:SetText(E:TextGradient(MANA_REGEN, statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						--end
					end
					_G.CharacterFrame.EltruismClassResourceDesc2:SetJustifyH("LEFT")
					_G.CharacterFrame.EltruismClassResourceDesc2:SetShadowColor(0, 0, 0, 1)
					_G.CharacterFrame.EltruismClassResourceDesc2:SetShadowOffset(1, 0)

					_G.CharacterFrame.EltruismClassResourceDescTooltip2:SetSize(190, 15)
					_G.CharacterFrame.EltruismClassResourceDescTooltip2:SetPoint("CENTER", _G.CharacterStatsPane, "CENTER", 0, -189)
					_G.CharacterFrame.EltruismClassResourceDescTooltip2:SetParent(_G.CharacterStatsPane)
					if E.myclass == 'HUNTER' or E.myclass == 'ROGUE' or E.myclass == 'DEATHKNIGHT' or E.myclass == 'MAGE' or E.myclass == 'SHAMAN' or E.myclass == 'WARLOCK' or E.myclass == 'PALADIN' or E.myclass == 'PRIEST' then
						_G.CharacterFrame.EltruismClassResource2:Hide()
						_G.CharacterFrame.EltruismClassResourceDesc2:Hide()
						_G.CharacterFrame.EltruismClassResourceDescTooltip2:Hide()
					elseif E.myclass == 'DRUID' or E.myclass == 'MONK' then
						_G.CharacterFrame.EltruismClassResource2:Show()
						_G.CharacterFrame.EltruismClassResourceDesc2:Show()
						_G.CharacterFrame.EltruismClassResourceDescTooltip2:Show()
					end
					_G.CharacterFrame.EltruismClassResourceDescTooltip2:SetScript("OnEnter", function()
						_G['GameTooltip']:SetOwner(_G.CharacterFrame.EltruismClassResourceDescTooltip2, 'ANCHOR_RIGHT')
						if E.myclass == 'DRUID' or E.myclass == 'MONK' then
							_G['GameTooltip']:AddLine(MANA_REGEN_TOOLTIP)
						end
						_G['GameTooltip']:Show()
					end)
					_G.CharacterFrame.EltruismClassResourceDescTooltip2:SetScript("OnLeave", function()
						_G['GameTooltip']:Hide()
					end)

					--update stats and stats position
					hooksecurefunc("PaperDollFrame_UpdateStats", function()
						local speed = ((GetUnitSpeed("player")/7) *100)
						_G.CharacterFrame.EltruismSpeed:SetText(math.ceil(speed).."%")

						local _, combat = GetManaRegen()
						combat = math.floor(combat * 5.0)
						local combatText = BreakUpLargeNumbers(combat)
						if E.myclass == 'HUNTER' or E.myclass == 'ROGUE' or E.myclass == 'DRUID' or E.myclass == 'MONK' then
							_G.CharacterFrame.EltruismClassResource:SetText(BreakUpLargeNumbers(GetPowerRegen()))
						elseif E.myclass == 'MAGE' or E.myclass == 'SHAMAN' or E.myclass == 'WARLOCK' or E.myclass == 'PALADIN' or E.myclass == 'PRIEST' then
							_G.CharacterFrame.EltruismClassResource:SetText(combatText)
						elseif E.myclass == 'DEATHKNIGHT' then
							local _, regenRate = GetRuneCooldown(1)
							local regenRateText = (format(STAT_RUNE_REGEN_FORMAT, regenRate))
							_G.CharacterFrame.EltruismClassResource:SetText(regenRateText)
						end

						if E.myclass == 'DRUID' or E.myclass == 'MONK' then
							_G.CharacterFrame.EltruismClassResource2:SetText(combatText)
						end

						local stats = {_G.CharacterStatsPane:GetChildren()}
						local number = (#stats)
						if E.db.ElvUI_EltreumUI.dev then
							ElvUI_EltreumUI:Print("Number of stats: "..number)
						end
						--15 seems like the minimum now with the added stats
						if number == 15 then
							_G.CharacterFrame.EltruismExtraStats:SetPoint("CENTER", _G.CharacterStatsPane, "CENTER", 0, -90)
							_G.CharacterFrame.EltruismExtraStatsFont:SetPoint("CENTER", _G.CharacterStatsPane, "CENTER", 0, -90)
						elseif number == 16 then
							_G.CharacterFrame.EltruismExtraStats:SetPoint("CENTER", _G.CharacterStatsPane, "CENTER", 0, -100)
							_G.CharacterFrame.EltruismExtraStatsFont:SetPoint("CENTER", _G.CharacterStatsPane, "CENTER", 0, -100)
						elseif number == 17 then
							_G.CharacterFrame.EltruismExtraStats:SetPoint("CENTER", _G.CharacterStatsPane, "CENTER", 0, -110)
							_G.CharacterFrame.EltruismExtraStatsFont:SetPoint("CENTER", _G.CharacterStatsPane, "CENTER", 0, -110)
						elseif number == 18 then
							_G.CharacterFrame.EltruismExtraStats:SetPoint("CENTER", _G.CharacterStatsPane, "CENTER", 0, -120)
							_G.CharacterFrame.EltruismExtraStatsFont:SetPoint("CENTER", _G.CharacterStatsPane, "CENTER", 0, -120)
						elseif number == 19 then
							_G.CharacterFrame.EltruismExtraStats:SetPoint("CENTER", _G.CharacterStatsPane, "CENTER", 0, -140)
							_G.CharacterFrame.EltruismExtraStatsFont:SetPoint("CENTER", _G.CharacterStatsPane, "CENTER", 0, -140)
						elseif number == 20 then
							_G.CharacterFrame.EltruismExtraStats:SetPoint("CENTER", _G.CharacterStatsPane, "CENTER", 0, -150)
							_G.CharacterFrame.EltruismExtraStatsFont:SetPoint("CENTER", _G.CharacterStatsPane, "CENTER", 0, -150)
						elseif number == 21 then
							_G.CharacterFrame.EltruismExtraStats:SetPoint("CENTER", _G.CharacterStatsPane, "CENTER", 0, -170)
							_G.CharacterFrame.EltruismExtraStatsFont:SetPoint("CENTER", _G.CharacterStatsPane, "CENTER", 0, -170)
						end

						_G.CharacterFrame.EltruismSpeed:SetPoint("CENTER", _G.CharacterFrame.EltruismExtraStatsFont , 72, -20)
						_G.CharacterFrame.EltruismSpeedDesc:SetPoint("CENTER", _G.CharacterFrame.EltruismExtraStatsFont , -36, -20)
						_G.CharacterFrame.EltruismSpeedDescTooltip:SetPoint("CENTER", _G.CharacterFrame.EltruismExtraStatsFont, "CENTER", 0, -20)

						if E.myclass == 'DEATHKNIGHT' then
							_G.CharacterFrame.EltruismClassResource:SetPoint("CENTER", _G.CharacterFrame.EltruismExtraStatsFont, 72, -33)
							_G.CharacterFrame.EltruismClassResourceDesc:SetPoint("CENTER", _G.CharacterFrame.EltruismExtraStatsFont, -50, -33)
							_G.CharacterFrame.EltruismClassResourceDescTooltip:SetPoint("CENTER", _G.CharacterFrame.EltruismExtraStatsFont, "CENTER", 0, -33)
						elseif E.myclass == 'DRUID' or E.myclass == 'MONK' then
							_G.CharacterFrame.EltruismClassResource:SetPoint("CENTER", _G.CharacterFrame.EltruismExtraStatsFont, 72, -33)
							_G.CharacterFrame.EltruismClassResourceDesc:SetPoint("CENTER", _G.CharacterFrame.EltruismExtraStatsFont, -45, -33)
							_G.CharacterFrame.EltruismClassResourceDescTooltip:SetPoint("CENTER", _G.CharacterFrame.EltruismExtraStatsFont, "CENTER", 0, -33)
						else
							_G.CharacterFrame.EltruismClassResource:SetPoint("CENTER", _G.CharacterFrame.EltruismExtraStatsFont, 72, -33)
							_G.CharacterFrame.EltruismClassResourceDesc:SetPoint("CENTER", _G.CharacterFrame.EltruismExtraStatsFont, -48, -33)
							_G.CharacterFrame.EltruismClassResourceDescTooltip:SetPoint("CENTER", _G.CharacterFrame.EltruismExtraStatsFont, "CENTER", 0, -33)
						end

						_G.CharacterFrame.EltruismClassResource2:SetPoint("CENTER", _G.CharacterFrame.EltruismExtraStatsFont, 72, -46)
						_G.CharacterFrame.EltruismClassResourceDesc2:SetPoint("CENTER", _G.CharacterFrame.EltruismExtraStatsFont, -49, -46)
						_G.CharacterFrame.EltruismClassResourceDescTooltip2:SetPoint("CENTER", _G.CharacterFrame.EltruismExtraStatsFont, "CENTER", 0, -46)
					end)
				end
			end
		elseif E.TBC or E.Classic then

			if E.db.ElvUI_EltreumUI.skins.statcolors then
				if E.TBC then
					hooksecurefunc('PlayerStatFrameLeftDropDown_OnClick', function()
						if not _G.PlayerStatFrameLeft1Label:GetText():match("|r") then
							_G.PlayerStatFrameLeft1Label:SetText(E:TextGradient(_G.PlayerStatFrameLeft1Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						end
						if not _G.PlayerStatFrameLeft2Label:GetText():match("|r") then
							_G.PlayerStatFrameLeft2Label:SetText(E:TextGradient(_G.PlayerStatFrameLeft2Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						end
						if not _G.PlayerStatFrameLeft3Label:GetText():match("|r") then
							_G.PlayerStatFrameLeft3Label:SetText(E:TextGradient(_G.PlayerStatFrameLeft3Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						end
						if not _G.PlayerStatFrameLeft4Label:GetText():match("|r") then
							_G.PlayerStatFrameLeft4Label:SetText(E:TextGradient(_G.PlayerStatFrameLeft4Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						end
						if not _G.PlayerStatFrameLeft5Label:GetText():match("|r") then
							_G.PlayerStatFrameLeft5Label:SetText(E:TextGradient(_G.PlayerStatFrameLeft5Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						end
						if not _G.PlayerStatFrameLeft6Label:GetText():match("|r") then
							_G.PlayerStatFrameLeft6Label:SetText(E:TextGradient(_G.PlayerStatFrameLeft6Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						end
						if not _G.PlayerStatFrameRight1Label:GetText():match("|r") then
							_G.PlayerStatFrameRight1Label:SetText(E:TextGradient(_G.PlayerStatFrameRight1Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						end
						if not _G.PlayerStatFrameRight2Label:GetText():match("|r") then
							_G.PlayerStatFrameRight2Label:SetText(E:TextGradient(_G.PlayerStatFrameRight2Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						end
						if not _G.PlayerStatFrameRight3Label:GetText():match("|r") then
							_G.PlayerStatFrameRight3Label:SetText(E:TextGradient(_G.PlayerStatFrameRight3Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						end
						if not _G.PlayerStatFrameRight4Label:GetText():match("|r") then
							_G.PlayerStatFrameRight4Label:SetText(E:TextGradient(_G.PlayerStatFrameRight4Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						end
						if not _G.PlayerStatFrameRight5Label:GetText():match("|r") then
							_G.PlayerStatFrameRight5Label:SetText(E:TextGradient(_G.PlayerStatFrameRight5Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						end
						if not _G.PlayerStatFrameRight6Label:GetText():match("|r") then
							_G.PlayerStatFrameRight6Label:SetText(E:TextGradient(_G.PlayerStatFrameRight6Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						end
					end)

					hooksecurefunc('PlayerStatFrameRightDropDown_OnClick', function()
						if not _G.PlayerStatFrameLeft1Label:GetText():match("|r") then
							_G.PlayerStatFrameLeft1Label:SetText(E:TextGradient(_G.PlayerStatFrameLeft1Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						end
						if not _G.PlayerStatFrameLeft2Label:GetText():match("|r") then
							_G.PlayerStatFrameLeft2Label:SetText(E:TextGradient(_G.PlayerStatFrameLeft2Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						end
						if not _G.PlayerStatFrameLeft3Label:GetText():match("|r") then
							_G.PlayerStatFrameLeft3Label:SetText(E:TextGradient(_G.PlayerStatFrameLeft3Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						end
						if not _G.PlayerStatFrameLeft4Label:GetText():match("|r") then
							_G.PlayerStatFrameLeft4Label:SetText(E:TextGradient(_G.PlayerStatFrameLeft4Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						end
						if not _G.PlayerStatFrameLeft5Label:GetText():match("|r") then
							_G.PlayerStatFrameLeft5Label:SetText(E:TextGradient(_G.PlayerStatFrameLeft5Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						end
						if not _G.PlayerStatFrameLeft6Label:GetText():match("|r") then
							_G.PlayerStatFrameLeft6Label:SetText(E:TextGradient(_G.PlayerStatFrameLeft6Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						end
						if not _G.PlayerStatFrameRight1Label:GetText():match("|r") then
							_G.PlayerStatFrameRight1Label:SetText(E:TextGradient(_G.PlayerStatFrameRight1Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						end
						if not _G.PlayerStatFrameRight2Label:GetText():match("|r") then
							_G.PlayerStatFrameRight2Label:SetText(E:TextGradient(_G.PlayerStatFrameRight2Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						end
						if not _G.PlayerStatFrameRight3Label:GetText():match("|r") then
							_G.PlayerStatFrameRight3Label:SetText(E:TextGradient(_G.PlayerStatFrameRight3Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						end
						if not _G.PlayerStatFrameRight4Label:GetText():match("|r") then
							_G.PlayerStatFrameRight4Label:SetText(E:TextGradient(_G.PlayerStatFrameRight4Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						end
						if not _G.PlayerStatFrameRight5Label:GetText():match("|r") then
							_G.PlayerStatFrameRight5Label:SetText(E:TextGradient(_G.PlayerStatFrameRight5Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						end
						if not _G.PlayerStatFrameRight6Label:GetText():match("|r") then
							_G.PlayerStatFrameRight6Label:SetText(E:TextGradient(_G.PlayerStatFrameRight6Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						end
					end)
				end

				hooksecurefunc("PaperDollFrame_UpdateStats", function()
						if E.TBC then
							if not _G.PlayerStatFrameLeft1Label:GetText():match("|r") then
								_G.PlayerStatFrameLeft1Label:SetText(E:TextGradient(_G.PlayerStatFrameLeft1Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
							end
							if not _G.PlayerStatFrameLeft2Label:GetText():match("|r") then
								_G.PlayerStatFrameLeft2Label:SetText(E:TextGradient(_G.PlayerStatFrameLeft2Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
							end
							if not _G.PlayerStatFrameLeft3Label:GetText():match("|r") then
								_G.PlayerStatFrameLeft3Label:SetText(E:TextGradient(_G.PlayerStatFrameLeft3Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
							end
							if not _G.PlayerStatFrameLeft4Label:GetText():match("|r") then
								_G.PlayerStatFrameLeft4Label:SetText(E:TextGradient(_G.PlayerStatFrameLeft4Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
							end
							if not _G.PlayerStatFrameLeft5Label:GetText():match("|r") then
								_G.PlayerStatFrameLeft5Label:SetText(E:TextGradient(_G.PlayerStatFrameLeft5Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
							end
							if not _G.PlayerStatFrameLeft6Label:GetText():match("|r") then
								_G.PlayerStatFrameLeft6Label:SetText(E:TextGradient(_G.PlayerStatFrameLeft6Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
							end
							if not _G.PlayerStatFrameRight1Label:GetText():match("|r") then
								_G.PlayerStatFrameRight1Label:SetText(E:TextGradient(_G.PlayerStatFrameRight1Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
							end
							if not _G.PlayerStatFrameRight2Label:GetText():match("|r") then
								_G.PlayerStatFrameRight2Label:SetText(E:TextGradient(_G.PlayerStatFrameRight2Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
							end
							if not _G.PlayerStatFrameRight3Label:GetText():match("|r") then
								_G.PlayerStatFrameRight3Label:SetText(E:TextGradient(_G.PlayerStatFrameRight3Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
							end
							if not _G.PlayerStatFrameRight4Label:GetText():match("|r") then
								_G.PlayerStatFrameRight4Label:SetText(E:TextGradient(_G.PlayerStatFrameRight4Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
							end
							if not _G.PlayerStatFrameRight5Label:GetText():match("|r") then
								_G.PlayerStatFrameRight5Label:SetText(E:TextGradient(_G.PlayerStatFrameRight5Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
							end
							if not _G.PlayerStatFrameRight6Label:GetText():match("|r") then
								_G.PlayerStatFrameRight6Label:SetText(E:TextGradient(_G.PlayerStatFrameRight6Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
							end
						elseif E.Classic then
							if not _G.CharacterStatFrame1Label:GetText():match("|r") then
								_G.CharacterStatFrame1Label:SetText(E:TextGradient(_G.CharacterStatFrame1Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
							end
							if not _G.CharacterStatFrame2Label:GetText():match("|r") then
								_G.CharacterStatFrame2Label:SetText(E:TextGradient(_G.CharacterStatFrame2Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
							end
							if not _G.CharacterStatFrame3Label:GetText():match("|r") then
								_G.CharacterStatFrame3Label:SetText(E:TextGradient(_G.CharacterStatFrame3Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
							end
							if not _G.CharacterStatFrame4Label:GetText():match("|r") then
								_G.CharacterStatFrame4Label:SetText(E:TextGradient(_G.CharacterStatFrame4Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
							end
							if not _G.CharacterStatFrame5Label:GetText():match("|r") then
								_G.CharacterStatFrame5Label:SetText(E:TextGradient(_G.CharacterStatFrame5Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
							end

							if not _G.CharacterArmorFrameLabel:GetText():match("|r") then
								_G.CharacterArmorFrameLabel:SetText(E:TextGradient(_G.CharacterArmorFrameLabel:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
							end
							if not _G.CharacterAttackFrameLabel:GetText():match("|r") then
								_G.CharacterAttackFrameLabel:SetText(E:TextGradient(_G.CharacterAttackFrameLabel:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
							end
							if not _G.CharacterAttackPowerFrameLabel:GetText():match("|r") then
								_G.CharacterAttackPowerFrameLabel:SetText(E:TextGradient(_G.CharacterAttackPowerFrameLabel:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
							end
							if not _G.CharacterDamageFrameLabel:GetText():match("|r") then
								_G.CharacterDamageFrameLabel:SetText(E:TextGradient(_G.CharacterDamageFrameLabel:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
							end
							if not _G.CharacterRangedAttackFrameLabel:GetText():match("|r") then
								_G.CharacterRangedAttackFrameLabel:SetText(E:TextGradient(_G.CharacterRangedAttackFrameLabel:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
							end
							if not _G.CharacterRangedAttackPowerFrameLabel:GetText():match("|r") then
								_G.CharacterRangedAttackPowerFrameLabel:SetText(E:TextGradient(_G.CharacterRangedAttackPowerFrameLabel:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
							end
							if not _G.CharacterRangedDamageFrameLabel:GetText():match("|r") then
								_G.CharacterRangedDamageFrameLabel:SetText(E:TextGradient(_G.CharacterRangedDamageFrameLabel:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
							end
						end
					end)
			end

			--add class crest
			if E.db.ElvUI_EltreumUI.skins.expandarmorycrest then
				ClassCrestFrame:SetSize(150, 150)
				ClassCrestFrame:SetPoint("CENTER", _G.CharacterModelFrame, 0 , 50)
				ClassCrestFrame:SetParent(_G.CharacterFrame)
				ClassCrestFrameTexture:SetAtlas(classCrests[E.myclass], true)
				ClassCrestFrameTexture:SetAllPoints(ClassCrestFrame)
				ClassCrestFrameTexture:SetDrawLayer("BACKGROUND")
			end
			if E.db.ElvUI_EltreumUI.skins.expandarmorybg then
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

				--set ilvl on char panel
				hooksecurefunc("ToggleCharacter", function()
					local ilevel = ElvUI_EltreumUI:GetPlayerItemLevel()
					_G.CharacterFrame.Text2:SetText((math.floor(ilevel*100))/100)
				end)

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

				if E.TBC then
					--_G.PlayerTitleDropDown:Show()
					_G.PlayerTitleDropDown:ClearAllPoints()
					_G.PlayerTitleDropDown:SetParent(_G.CharacterModelFrame)
					_G.PVPFrameToggleButton:ClearAllPoints()
					_G.PVPFrameToggleButton:SetPoint('TOP', _G.PVPHonor, 'TOP', 52, 42)
					_G.PVPFrameToggleButton:SetParent(_G.PVPFrameHonor)
				elseif E.Classic then
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
				if E.TBC then
					_G.PlayerTitleDropDown:SetPoint('TOP', _G.CharacterModelFrame, -6, 40)
				elseif E.Classic then
					_G.CharacterTitleText:SetPoint('TOP', _G.CharacterModelFrame, 0, 40)
				end

				_G.CharacterLevelText:SetPoint('TOP', _G.CharacterNameText, 'BOTTOM', 0, -10)
				_G.PetNameText:SetPoint('TOP', _G.PetModelFrame, 0, 60)
				_G.PetLevelText:SetPoint('BOTTOM', _G.PetNameText, 0, -10)
				_G.PetLoyaltyText:SetPoint('BOTTOM', _G.PetLevelText, 0, -20)
				_G.PetPaperDollCloseButton:Hide()

				_G.CharacterNameText:SetParent(_G.CharacterModelFrame)
				_G.CharacterNameText:SetFont(E.LSM:Fetch('font', E.db.general.font), 18, E.db.general.fontStyle)
				_G.CharacterNameText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
				_G.CharacterNameText:SetShadowColor(0, 0, 0, 0.8)
				_G.CharacterNameText:SetShadowOffset(2, -1)

				_G.SkillFrame:SetHeight(400)
				_G.SkillDetailScrollChildFrame:ClearAllPoints()
				_G.SkillDetailScrollChildFrame:SetPoint("BOTTOMLEFT", CharacterFrame, "BOTTOMLEFT", 30, 150)
				_G.SkillDetailScrollChildFrame:SetParent(_G.SkillFrame)
				_G.SkillFrameCancelButton:Hide()

				--_G.ReputationDefailFrame:SetPoint('TOPRIGHT', _G.CharacterFrame)

				CharacterFrame.Text4:SetSize(418, 72)
				CharacterFrame.Text4:SetPoint("TOP", CharacterFrame, "TOP", 150, 10)
				CharacterFrame.Text4:SetTextColor(1, 1, 1)
				CharacterFrame.Text4:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, E.db.general.fontStyle)
				CharacterFrame.Text4:SetText("Specialization")

				CharacterFrame.StatusLine4:SetSize(170, 3)
				CharacterFrame.StatusLine4:SetPoint("CENTER", CharacterFrame.Text4, "CENTER", 0, -15)
				CharacterFrame.StatusLine4:SetStatusBarTexture(E.Media.Textures.Highlight)
				CharacterFrame.StatusLine4:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)

				CharacterFrame.Text5:SetSize(418, 72)
				CharacterFrame.Text5:SetPoint("TOP", CharacterFrame, "TOP", 150, -20)
				CharacterFrame.Text5:SetTextColor(classcolor.r, classcolor.g, classcolor.b, 1)
				CharacterFrame.Text5:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, E.db.general.fontStyle)
				CharacterFrame.Text5:SetText(PlayerSpec())

				CharacterFrame:SetSize(600, 505)

				--SkillListScrollFrameScrollBar:ClearAllPoints()
				--SkillListScrollFrameScrollBar:SetPoint("LEFT", CharacterFrame)

				CharacterFrame.Text:SetSize(418, 72)
				CharacterFrame.Text:SetPoint("TOP", CharacterFrame, "TOP", 150, -45)
				CharacterFrame.Text:SetTextColor(1, 1, 1)
				CharacterFrame.Text:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, E.db.general.fontStyle)
				CharacterFrame.Text:SetText("Item Level")

				CharacterFrame.StatusLine:SetSize(170, 3)
				CharacterFrame.StatusLine:SetPoint("CENTER", CharacterFrame.Text, "CENTER", 0, -15)
				CharacterFrame.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				CharacterFrame.StatusLine:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)

				CharacterFrame.Text2:SetSize(418, 72)
				CharacterFrame.Text2:SetPoint("TOP", CharacterFrame, "TOP", 150, -80)
				CharacterFrame.Text2:SetTextColor(classcolor.r, classcolor.g, classcolor.b, 1)
				CharacterFrame.Text2:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, E.db.general.fontStyle)

				CharacterFrame.StatusLine2:SetFrameStrata("LOW")
				CharacterFrame.StatusLine2:SetSize(170, 25)
				CharacterFrame.StatusLine2:SetPoint("CENTER", CharacterFrame.Text2, "CENTER", 0, 0)
				CharacterFrame.StatusLine2:SetStatusBarTexture(E.Media.Textures.Highlight)
				CharacterFrame.StatusLine2:SetStatusBarColor(1, 1, 1, 0.8)


				CharacterFrame.Text3:SetSize(418, 72)
				CharacterFrame.Text3:SetPoint("TOP", CharacterFrame, "TOP", 150, -105)
				CharacterFrame.Text3:SetTextColor(1, 1, 1)
				CharacterFrame.Text3:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, E.db.general.fontStyle)
				CharacterFrame.Text3:SetText("Attributes")

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
				if E.TBC then
					_G.MagicResFrame1:SetParent(_G.PlayerStatFrameLeft1)
					_G.MagicResFrame1:SetPoint("TOPLEFT", _G.PlayerStatFrameLeftDropDown, "TOPLEFT", 14, 27)
				elseif E.Classic then
					_G.MagicResFrame1:SetParent(_G.CharacterStatFrame1)
					_G.MagicResFrame1:SetPoint("BOTTOM", CharacterFrame.StatusLine3, "BOTTOM", -55, -50)
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

				if E.TBC then
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
				elseif E.Classic then
					_G.CharacterStatFrame1:ClearAllPoints()
					_G.CharacterStatFrame1:SetPoint("TOP", CharacterFrame, "TOP", 124, -225)
					_G.CharacterStatFrame1:SetParent(CharacterFrame)

					_G.CharacterStatFrame2:ClearAllPoints()
					_G.CharacterStatFrame2:SetParent(_G.CharacterStatFrame1)
					_G.CharacterStatFrame2:SetPoint("BOTTOM", _G.CharacterStatFrame1, "BOTTOM", 0, -13)

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
end

--inspect bg
local EltruismInspectBg = CreateFrame("Frame", "EltruismInspectBg")
EltruismInspectBg:SetParent(_G.InspectFrame)
local EltruismInspectBgTexture = EltruismInspectBg:CreateTexture()
function ElvUI_EltreumUI:InspectBg(unit)
	if E.db.ElvUI_EltreumUI.skins.expandarmorybg and not E.private.skins.blizzard.enable == false then
		local alpha
		if E.db.ElvUI_EltreumUI.skins.expandarmorybgalpha ~= nil then
			alpha = E.db.ElvUI_EltreumUI.skins.expandarmorybgalpha
		elseif E.db.ElvUI_EltreumUI.skins.expandarmorybgalpha == nil then
			alpha = 0.3
		end
		--inspect frame bg
		if IsAddOnLoaded("Blizzard_InspectUI") then
			--local localizedClass, englishClass, localizedRace, englishRace, sex, name, realm = GetPlayerInfoByGUID(unit)
			local _, englishClass = GetPlayerInfoByGUID(unit)
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
					if E.TBC or E.Classic then
						EltruismInspectBgTexture:SetAllPoints(_G.InspectFrame.backdrop)
						EltruismInspectBgTexture:SetParent(_G.InspectFrame)
						if _G.InspectModelFrameRotateLeftButton:IsShown() then
							_G.InspectModelFrameRotateLeftButton:Hide()
						end
						if _G.InspectModelFrameRotateRightButton:IsShown() then
							_G.InspectModelFrameRotateRightButton:Hide()
						end
					elseif E.Retail then
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

