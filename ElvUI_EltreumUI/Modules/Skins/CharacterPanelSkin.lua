local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local select = _G.select
local classcolor = E:ClassColor(E.myclass, true)
local CreateFrame = _G.CreateFrame
local GetInventoryItemLink = _G.GetInventoryItemLink
local GetItemInfo = _G.GetItemInfo
local max = _G.max
local tonumber = _G.tonumber
local math = _G.math
local IsAddOnLoaded = _G.IsAddOnLoaded
local hooksecurefunc = _G.hooksecurefunc
local CharacterStatsPane = _G.CharacterStatsPane
local PaperDollFrame = _G.PaperDollFrame
local SkillFrame = _G.SkillFrame
local CharacterModelFrame = _G.CharacterModelFrame
local SetCVar = _G.SetCVar
local PaperDollItemsFrame = _G.PaperDollItemsFrame
local CharacterNameText = _G.CharacterNameText
local CharacterTitleText = _G.CharacterTitleText
local CharacterLevelText = _G.CharacterLevelText
local NORMAL_FONT_COLOR = _G.NORMAL_FONT_COLOR
local GetSpecialization = _G.GetSpecialization
local GetSpecializationInfo = _G.GetSpecializationInfo
local MANA_REGEN = _G.MANA_REGEN
local GetTalentTabInfo = _G.GetTalentTabInfo
local GetNumTalentTabs = _G.GetNumTalentTabs
local GetPlayerInfoByGUID = _G.GetPlayerInfoByGUID

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
	_G.CharacterFrame.EltruismExtraStatsBlock = _G.CharacterFrame:CreateTexture(nil, 'BORDER')
	_G.CharacterFrame.EltruismExtraStats = 	CreateFrame("StatusBar", nil, CharacterStatsPane)
	_G.CharacterFrame.EltruismExtraStats2 = CreateFrame("StatusBar", nil, CharacterStatsPane)
	_G.CharacterFrame.EltruismExtraStatsFont = _G.CharacterFrame:CreateFontString(nil,"ARTWORK")
	_G.CharacterFrame.EltruismSpeed = _G.CharacterFrame:CreateFontString(nil,"ARTWORK")
	_G.CharacterFrame.EltruismSpeedDesc = _G.CharacterFrame:CreateFontString(nil,"ARTWORK")
	_G.CharacterFrame.EltruismSpeedDescTooltip = CreateFrame("Frame", "EltruismSpeedDesc")
end

if E.Wrath or E.TBC or E.Classic then
	CharacterFrame.Text = CharacterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	CharacterFrame.Text2 = CharacterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	CharacterFrame.Text3 = CharacterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	CharacterFrame.Text4 = CharacterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	CharacterFrame.Text5 = CharacterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	CharacterFrame.StatusLine = CreateFrame("StatusBar", "EltruismCharacterBar1", PaperDollItemsFrame)
	CharacterFrame.StatusLine2 = CreateFrame("StatusBar", "EltruismCharacterBar2", PaperDollItemsFrame)
	CharacterFrame.StatusLine3 = CreateFrame("StatusBar", "EltruismCharacterBar3", PaperDollItemsFrame)
	CharacterFrame.StatusLine4 = CreateFrame("StatusBar", "EltruismCharacterBar4", PaperDollItemsFrame)
end

if E.Wrath or E.TBC then
	_G.PlayerStatFrameLeft2.StatusLine = CreateFrame("StatusBar", "EltruismStatLine12", PaperDollItemsFrame)
	_G.PlayerStatFrameLeft4.StatusLine = CreateFrame("StatusBar", "EltruismStatLine22", PaperDollItemsFrame)
	_G.PlayerStatFrameLeft6.StatusLine = CreateFrame("StatusBar", "EltruismStatLine32", PaperDollItemsFrame)
	_G.PlayerStatFrameRight2.StatusLine = CreateFrame("StatusBar", "EltruismStatLine52", PaperDollItemsFrame)
	_G.PlayerStatFrameRight4.StatusLine = CreateFrame("StatusBar", "EltruismStatLine62", PaperDollItemsFrame)
	_G.PlayerStatFrameRight6.StatusLine = CreateFrame("StatusBar", "EltruismStatLine7", PaperDollItemsFrame)
end

if E.Classic then
	_G.CharacterArmorFrame.StatusLine = CreateFrame("StatusBar", "EltruismStatLine3", PaperDollItemsFrame)
	_G.CharacterAttackPowerFrame.StatusLine = CreateFrame("StatusBar", "EltruismStatLine4", PaperDollItemsFrame)
	_G.CharacterRangedAttackFrame.StatusLine = CreateFrame("StatusBar", "EltruismStatLine5", PaperDollItemsFrame)
	_G.CharacterRangedDamageFrame.StatusLine = CreateFrame("StatusBar", "EltruismStatLine6", PaperDollItemsFrame)
	_G.CharacterStatFrame2.StatusLine = CreateFrame("StatusBar", "EltruismStatLine1", PaperDollItemsFrame)
	_G.CharacterStatFrame4.StatusLine = CreateFrame("StatusBar", "EltruismStatLine2", PaperDollItemsFrame)
end

local classBgs = {
	["WARRIOR"] = "Interface\\Artifacts\\ArtifactUIWarrior",
	["PALADIN"] = "Interface\\Artifacts\\ArtifactUIPaladin",
	["HUNTER"] = "Interface\\Artifacts\\ArtifactUIHunter",
	["ROGUE"] = "Interface\\Artifacts\\ArtifactUIRogue",
	["PRIEST"] = "Interface\\Artifacts\\ArtifactUIPriest",
	["DEATHKNIGHT"] = "Interface\\Artifacts\\ArtifactUIDeathKnightFrost",
	["SHAMAN"] = "Interface\\Artifacts\\ArtifactUIShaman",
	["MAGE"] = "Interface\\Artifacts\\ArtifactUIMageArcane",
	["WARLOCK"] = "Interface\\Artifacts\\ArtifactUIWarlock",
	["MONK"] = "Interface\\Artifacts\\ArtifactUIMonk",
	["DRUID"] = "Interface\\Artifacts\\ArtifactUIDruid",
	["DEMONHUNTER"] = "Interface\\Artifacts\\ArtifactUIDemonHunter",
}

local raceBgs = {
	["BloodElf"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Races\\BloodElf",
	["HighmountainTauren"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Races\\Highmountain",
	["Goblin"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Races\\Goblin",
	["Vulpera"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Races\\Vulpera",
	["Nightborne"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Races\\Nightborne",
	["MagharOrc"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Races\\MagharOrc",
	["Orc"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Races\\Orc2",
	["Scourge"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Races\\Undead",
	["Tauren"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Races\\Tauren",
	["Troll"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Races\\Troll",
	["ZandalariTroll"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Races\\Zandalari",
	["DarkIronDwarf"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Races\\DarkIron",
	["Draenei"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Races\\Draenei",
	["Gnome"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Races\\Gnome",
	["Dwarf"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Races\\Dwarf",
	["Human"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Races\\Human",
	["KulTiran"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Races\\KulTiran",
	["LightforgedDraenei"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Races\\Lightforged",
	["NightElf"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Races\\NightElf",
	["Mechagnome"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Races\\Mechagnome",
	["VoidElf"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Races\\VoidElf",
	["Pandaren"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Races\\Pandaren",
	["Worgen"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Races\\Worgen",
}

local classCrests = {
	["WARRIOR"] = "Artifacts-Warrior-BG-rune",
	["PALADIN"] = "Artifacts-Paladin-BG-rune",
	["HUNTER"] = "Artifacts-Hunter-BG-rune",
	["ROGUE"] = "Artifacts-Rogue-BG-rune",
	["PRIEST"] = "Artifacts-Priest-BG-rune",
	["DEATHKNIGHT"] = "Artifacts-DeathKnightFrost-BG-Rune",
	["SHAMAN"] = "Artifacts-Shaman-BG-rune",
	["MAGE"] = "Artifacts-MageArcane-BG-rune",
	["WARLOCK"] = "Artifacts-Warlock-BG-rune",
	["MONK"] = "Artifacts-Monk-BG-rune",
	["DRUID"] = "Artifacts-Druid-BG-rune",
	["DEMONHUNTER"] = "Artifacts-DemonHunter-BG-rune",
}

local statgradients = {
	["WARRIOR"] = {r1 = 0.60, g1 = 0.40, b1 = 0.20, r2 = 0.66470588235294, g2 = 0.53137254901961, b2 = 0.34705882352941},
	["PALADIN"] = {r1 = 0.9, g1 = 0.46666666666667, b1 = 0.63725490196078, r2 = 0.95686274509804, g2 = 0.64901960784314, b2 = 0.82941176470588},
	["HUNTER"] = {r1 = 0.58235294117647, g1 = 0.69607843137255, b1 = 0.29411764705882, r2 = 0.78823529411765, g2 = 1, b2 = 0.38823529411765},
	["ROGUE"] = {r1 = 1, g1 = 0.68627450980392, b1 = 0, r2 = 1, g2 = 0.83137254901961, b2 = 0.25490196078431},
	["PRIEST"] = {r1 = 0.6568627450980392, g1 = 0.6568627450980392, b1 = 0.6568627450980392, r2 = 0.98823529411765, g2 = 0.98823529411765, b2 = 0.98823529411765},
	["DEATHKNIGHT"] = {r1 = 0.79803921568627, g1 = 0.074509803921569, b1 = 0.14901960784314, r2 = 1, g2 = 0.1843137254902, b2 = 0.23921568627451},
	["SHAMAN"] = {r1 = 0, g1 = 0.25882352941176, b1 = 0.50980392156863, r2 = 0, g2 = 0.43921568627451, b2 = 0.87058823529412},
	["MAGE"] = {r1 = 0, g1 = 0.73333333333333, b1 = 0.83725490196078, r2 = 0.49019607843137, g2 = 0.87058823529412, b2 = 1},
	["WARLOCK"] = {r1 = 0.50, g1 = 0.30, b1 = 0.70, r2 = 0.7, g2= 0.53, b2 = 0.83},
	["MONK"] = {r1 = 0, g1 = 0.77254901960784, b1 = 0.45882352941176, r2 = 0.22352941176471, g2 = 0.90980392156863, b2 = 1},
	["DRUID"] = {r1 = 1, g1 = 0.23921568627451, b1 = 0.007843137254902, r2 = 1, g2 = 0.48627450980392, b2 = 0.03921568627451},
	["DEMONHUNTER"] = {r1 = 0.36470588235294, g1 = 0.13725490196078, b1 = 0.57254901960784, r2 = 0.74509803921569, g2 = 0.1921568627451, b2 = 1},
	["NPCFRIENDLY"] = {r1 = 0.30980392156863, g1 = 0.85098039215686, b1 = 0.2, r2 = 0.34117647058824, g2 = 0.62745098039216, b2 = 0.4078431372549},
	["NPCNEUTRAL"] = {r1 = 0.712358744169101, g1 = 0.63137254901961, b1 = 0.15490196078431, r2 = 1, g2 = 0.85686274509804, b2 = 0.2078431372549},
	["NPCUNFRIENDLY"] = {r1 = 0.84313725490196, g1 = 0.30196078431373, b1 = 0, r2 = 0.83137254901961, g2 = 0.45882352941176, b2 = 0},
	["NPCHOSTILE"] = {r1 = 0.31764705882353, g1 = 0.066666666666667, b1 = 0.07843137254902, r2 = 1, g2 = 0.15686274509804, b2 = 0.15686274509804},
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
				ClassCrestFrame:SetPoint("CENTER", CharacterModelFrame, 0, 50)
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
				_G.CharacterMainHandSlot:SetPoint('BOTTOMLEFT', PaperDollItemsFrame, 'BOTTOMLEFT', 195, 20)
				--strech it a bit
				CharacterModelFrame:ClearAllPoints()
				CharacterModelFrame:SetPoint('TOPLEFT', _G.CharacterHeadSlot, -5, 5)
				CharacterModelFrame:SetPoint('RIGHT', _G.CharacterHandsSlot, 5, 5)
				CharacterModelFrame:SetPoint('BOTTOM', _G.CharacterMainHandSlot, 0, -5)
				CharacterModelFrame:SetPosition(-0.25, 0, -0.10) -- zoom, x, y
				--CharacterModelFrame:SetPosition(-0.55, 0, -0.10) -- zoom, x, y

				--hide other bgs so one can be streched like the talents for tbc/classic
				CharacterModelFrame.BackgroundTopRight:Hide()
				CharacterModelFrame.BackgroundBotLeft:Hide()
				CharacterModelFrame.BackgroundBotRight:Hide()
				CharacterModelFrame.BackgroundTopLeft:SetAllPoints(CharacterModelFrame)
				_G.CharacterModelFrameBackgroundOverlay:SetAllPoints(CharacterModelFrame)


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

				--add bg texture
				if E.db.ElvUI_EltreumUI.skins.armorybgtype == "CLASS" then
					CharacterFrameBackgroundTexture:SetTexture(classBgs[E.myclass])
					CharacterFrameBackgroundTexture:SetTexCoord(0, 0.87, 0, 0.60)
				elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "RACE" then
					CharacterFrameBackgroundTexture:SetTexture(raceBgs[E.myrace])
				elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "CUSTOM" then
					local texturefile = [[Interface\AddOns\]]..E.private.ElvUI_EltreumUI.skins.armorybgtexture
					CharacterFrameBackgroundTexture:SetTexture(texturefile)
				end
				CharacterFrameBackgroundTexture:SetAlpha(alphabg)
				CharacterFrameBackgroundTexture:SetAllPoints(_G.CharacterFrame)
				CharacterFrameBackgroundTexture:SetParent(_G.CharacterFrame)
				CharacterFrameBackgroundTexture:SetDrawLayer("ARTWORK")

				_G.CharacterModelFrame.backdrop:Hide()
				_G.CharacterModelFrameBackgroundTopLeft:Hide()
				_G.CharacterModelFrameBackgroundOverlay:Hide()

				--color the avg item level
				CharacterStatsPane.ItemLevelFrame.leftGrad:SetGradientAlpha('Horizontal', classcolor.r, classcolor.g, classcolor.b, 0.4, classcolor.r, classcolor.g, classcolor.b, 0)
				CharacterStatsPane.ItemLevelFrame.rightGrad:SetGradientAlpha('Horizontal', classcolor.r, classcolor.g, classcolor.b, 0, classcolor.r, classcolor.g, classcolor.b, 0.4)

				if E.db.ElvUI_EltreumUI.skins.statcolors and (not IsAddOnLoaded('DejaCharacterStats')) then
					--ItemLevelCategory
					--remove backgrounds and make font nice
					CharacterStatsPane.ItemLevelCategory.backdrop:Hide()
					CharacterStatsPane.ItemLevelCategory.backdrop:Hide()
					if not CharacterStatsPane.ItemLevelCategory.Title:GetText():match("|r") then
						CharacterStatsPane.ItemLevelCategory.Title:SetText(E:TextGradient(CharacterStatsPane.ItemLevelCategory.Title:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
					end
					CharacterStatsPane.ItemLevelCategory.Title:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, E.db.general.fontStyle)

					--statusbars
					--CharacterStatsPane.ItemLevelCategory.Title:SetText("Gegenstandsstufe")

					local linewidth1
					if IsAddOnLoaded("ElvUI_SLE") then
						if E.locale == "enUS" then
							linewidth1 = (( 193 - CharacterStatsPane.ItemLevelCategory.Title:GetStringWidth())/2)
						else
							linewidth1 = (( 204 - CharacterStatsPane.ItemLevelCategory.Title:GetStringWidth())/2)
						end
					else
						linewidth1 = (( 193 - CharacterStatsPane.ItemLevelCategory.Title:GetStringWidth())/2)
					end
					CharacterStatsPane.ItemLevelCategory.Title.StatusLine = CreateFrame("StatusBar", "EltruismItemLevelCategoryLine", CharacterStatsPane)
					CharacterStatsPane.ItemLevelCategory.Title.StatusLine:SetSize(linewidth1, 4)
					--CharacterStatsPane.ItemLevelCategory.Title.StatusLine:SetSize(50, 4)
					CharacterStatsPane.ItemLevelCategory.Title.StatusLine:SetPoint("RIGHT", CharacterStatsPane.ItemLevelCategory.Title, "LEFT", 0, -1)
					--CharacterStatsPane.ItemLevelCategory.Title.StatusLine:SetPoint("CENTER", CharacterStatsPane.ItemLevelCategory.Title)
					CharacterStatsPane.ItemLevelCategory.Title.StatusLine:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga")
					CharacterStatsPane.ItemLevelCategory.Title.StatusLine:GetStatusBarTexture():SetGradient("HORIZONTAL", statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"])
					CharacterStatsPane.ItemLevelCategory.Title.StatusLine2 = CreateFrame("StatusBar", "EltruismItemLevelCategoryLine2", CharacterStatsPane)
					--CharacterStatsPane.ItemLevelCategory.Title.StatusLine2:SetSize(50, 4)
					CharacterStatsPane.ItemLevelCategory.Title.StatusLine2:SetSize(linewidth1, 4)
					CharacterStatsPane.ItemLevelCategory.Title.StatusLine2:SetPoint("LEFT", CharacterStatsPane.ItemLevelCategory.Title, "RIGHT", -1, -1)
					CharacterStatsPane.ItemLevelCategory.Title.StatusLine2:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga")
					CharacterStatsPane.ItemLevelCategory.Title.StatusLine2:GetStatusBarTexture():SetGradient("HORIZONTAL", statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"], statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"])

					--attributes
					--remove backgrounds and make font nice
					CharacterStatsPane.AttributesCategory.backdrop:Hide()
					CharacterStatsPane.AttributesCategory.backdrop:Hide()
					if not CharacterStatsPane.AttributesCategory.Title:GetText():match("|r") then
						CharacterStatsPane.AttributesCategory.Title:SetText(E:TextGradient(CharacterStatsPane.AttributesCategory.Title:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
					end
					CharacterStatsPane.AttributesCategory.Title:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, E.db.general.fontStyle)
					--statusbars
					local linewidth2 = (( 194 - CharacterStatsPane.AttributesCategory.Title:GetStringWidth())/2)
					CharacterStatsPane.AttributesCategory.Title.StatusLine = CreateFrame("StatusBar", "EltruismAttributesCategoryLine", CharacterStatsPane)
					CharacterStatsPane.AttributesCategory.Title.StatusLine:SetSize(linewidth2, 4)
					CharacterStatsPane.AttributesCategory.Title.StatusLine:SetPoint("RIGHT", CharacterStatsPane.AttributesCategory.Title, "LEFT", 0, -1)
					CharacterStatsPane.AttributesCategory.Title.StatusLine:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga")
					CharacterStatsPane.AttributesCategory.Title.StatusLine:GetStatusBarTexture():SetGradient("HORIZONTAL", statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"])
					CharacterStatsPane.AttributesCategory.Title.StatusLine2 = CreateFrame("StatusBar", "EltruismAttributesCategoryLine2", CharacterStatsPane)
					CharacterStatsPane.AttributesCategory.Title.StatusLine2:SetSize(linewidth2, 4)
					CharacterStatsPane.AttributesCategory.Title.StatusLine2:SetPoint("LEFT", CharacterStatsPane.AttributesCategory.Title, "RIGHT", -1, -1)
					CharacterStatsPane.AttributesCategory.Title.StatusLine2:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga")
					CharacterStatsPane.AttributesCategory.Title.StatusLine2:GetStatusBarTexture():SetGradient("HORIZONTAL", statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"], statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"])

					--Enhancements
					--remove backgrounds and make font nice
					CharacterStatsPane.EnhancementsCategory.backdrop:Hide()
					CharacterStatsPane.EnhancementsCategory.backdrop:Hide()
					if not CharacterStatsPane.EnhancementsCategory.Title:GetText():match("|r") then
						CharacterStatsPane.EnhancementsCategory.Title:SetText(E:TextGradient(CharacterStatsPane.EnhancementsCategory.Title:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
					end
					CharacterStatsPane.EnhancementsCategory.Title:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, E.db.general.fontStyle)
					--statusbars
					local linewidth3
					if IsAddOnLoaded("ElvUI_SLE") then
						if E.locale == "enUS" then
							linewidth3 = (( 193 - CharacterStatsPane.EnhancementsCategory.Title:GetStringWidth())/2)
						else
							linewidth3 = (( 204 - CharacterStatsPane.EnhancementsCategory.Title:GetStringWidth())/2)
						end
					else
						linewidth3 = (( 193 - CharacterStatsPane.EnhancementsCategory.Title:GetStringWidth())/2)
					end
					CharacterStatsPane.EnhancementsCategory.Title.StatusLine = CreateFrame("StatusBar", "EltruismEnhancementsCategoryLine", CharacterStatsPane)
					CharacterStatsPane.EnhancementsCategory.Title.StatusLine:SetSize(linewidth3, 4)
					CharacterStatsPane.EnhancementsCategory.Title.StatusLine:SetPoint("RIGHT", CharacterStatsPane.EnhancementsCategory.Title, "LEFT", 0, -1)
					CharacterStatsPane.EnhancementsCategory.Title.StatusLine:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga")
					CharacterStatsPane.EnhancementsCategory.Title.StatusLine:GetStatusBarTexture():SetGradient("HORIZONTAL", statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"])
					CharacterStatsPane.EnhancementsCategory.Title.StatusLine2 = CreateFrame("StatusBar", "EltruismEnhancementsCategoryLine2", CharacterStatsPane)
					CharacterStatsPane.EnhancementsCategory.Title.StatusLine2:SetSize(linewidth3, 4)
					CharacterStatsPane.EnhancementsCategory.Title.StatusLine2:SetPoint("LEFT", CharacterStatsPane.EnhancementsCategory.Title, "RIGHT", -1, -1)
					CharacterStatsPane.EnhancementsCategory.Title.StatusLine2:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga")
					CharacterStatsPane.EnhancementsCategory.Title.StatusLine2:GetStatusBarTexture():SetGradient("HORIZONTAL", statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"], statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"])

					if IsAddOnLoaded('ElvUI_SLE') then
						--offense
						CharacterStatsPane.OffenseCategory.backdrop:Hide()
						if not CharacterStatsPane.OffenseCategory.Title:GetText():match("|r") then
							CharacterStatsPane.OffenseCategory.Title:SetText(E:TextGradient(CharacterStatsPane.OffenseCategory.Title:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						end
						--statusbars
						local linewidthsle1 = (( 168 - CharacterStatsPane.OffenseCategory.Title:GetStringWidth())/2)
						CharacterStatsPane.OffenseCategory.Title.StatusLine = CreateFrame("StatusBar", "EltruismOffenseCategory", CharacterStatsPane)
						CharacterStatsPane.OffenseCategory.Title.StatusLine:SetSize(linewidthsle1, 4)
						CharacterStatsPane.OffenseCategory.Title.StatusLine:SetPoint("RIGHT", CharacterStatsPane.OffenseCategory.Title, "LEFT", 0, -1)
						CharacterStatsPane.OffenseCategory.Title.StatusLine:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga")
						CharacterStatsPane.OffenseCategory.Title.StatusLine:GetStatusBarTexture():SetGradient("HORIZONTAL", statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"])
						CharacterStatsPane.OffenseCategory.Title.StatusLine2 = CreateFrame("StatusBar", "EltruismOffenseCategoryLine2", CharacterStatsPane)
						CharacterStatsPane.OffenseCategory.Title.StatusLine2:SetSize(linewidthsle1, 4)
						CharacterStatsPane.OffenseCategory.Title.StatusLine2:SetPoint("LEFT", CharacterStatsPane.OffenseCategory.Title, "RIGHT", -1, -1)
						CharacterStatsPane.OffenseCategory.Title.StatusLine2:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga")
						CharacterStatsPane.OffenseCategory.Title.StatusLine2:GetStatusBarTexture():SetGradient("HORIZONTAL", statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"], statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"])

						--defense
						CharacterStatsPane.DefenceCategory.backdrop:Hide()
						if not CharacterStatsPane.DefenceCategory.Title:GetText():match("|r") then
							CharacterStatsPane.DefenceCategory.Title:SetText(E:TextGradient(CharacterStatsPane.DefenceCategory.Title:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						end
						--statusbars
						local linewidthsle2 = (( 168 - CharacterStatsPane.DefenceCategory.Title:GetStringWidth())/2)
						CharacterStatsPane.DefenceCategory.Title.StatusLine = CreateFrame("StatusBar", "EltruismDefenceCategory", CharacterStatsPane)
						CharacterStatsPane.DefenceCategory.Title.StatusLine:SetSize(linewidthsle2, 4)
						CharacterStatsPane.DefenceCategory.Title.StatusLine:SetPoint("RIGHT", CharacterStatsPane.DefenceCategory.Title, "LEFT", 0, -1)
						CharacterStatsPane.DefenceCategory.Title.StatusLine:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga")
						CharacterStatsPane.DefenceCategory.Title.StatusLine:GetStatusBarTexture():SetGradient("HORIZONTAL", statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"])
						CharacterStatsPane.DefenceCategory.Title.StatusLine2 = CreateFrame("StatusBar", "EltruismDefenceCategoryLine2", CharacterStatsPane)
						CharacterStatsPane.DefenceCategory.Title.StatusLine2:SetSize(linewidthsle2, 4)
						CharacterStatsPane.DefenceCategory.Title.StatusLine2:SetPoint("LEFT", CharacterStatsPane.DefenceCategory.Title, "RIGHT", -1, -1)
						CharacterStatsPane.DefenceCategory.Title.StatusLine2:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga")
						CharacterStatsPane.DefenceCategory.Title.StatusLine2:GetStatusBarTexture():SetGradient("HORIZONTAL", statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"], statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"])

						--fix enhancement
						CharacterStatsPane.EnhancementsCategory.Title.StatusLine:SetSize(linewidth3 + 8, 4)
						CharacterStatsPane.EnhancementsCategory.Title.StatusLine2:SetSize(linewidth3 + 8, 4)
					end
				end

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
					if PaperDollFrame:IsShown() then
						_G.CharacterFrame:SetWidth(500)
						_G.CharacterModelFrameBackgroundOverlay:Hide()
						if PaperDollFrame.SLE_Armory_BG then
							if PaperDollFrame.SLE_Armory_BG:IsShown() then
								PaperDollFrame.SLE_Armory_BG:Hide()
							end
						end
					end
				end)

				hooksecurefunc("CharacterFrame_Expand", function()
					if PaperDollFrame:IsShown() then
						_G.CharacterFrame:SetWidth(700)
						_G.CharacterModelFrameBackgroundOverlay:Hide()
						if PaperDollFrame.SLE_Armory_BG then
							if PaperDollFrame.SLE_Armory_BG:IsShown() then
								PaperDollFrame.SLE_Armory_BG:Hide()
							end
						end
					end
				end)

				hooksecurefunc('PaperDollFrame_SetLabelAndText', function(statFrame, label)
					if ( statFrame.Label ) then
						--statFrame.Label:SetText(format(STAT_FORMAT, label))
						if not statFrame.Label:GetText():match("|r") and E.db.ElvUI_EltreumUI.skins.statcolors and (not IsAddOnLoaded('DejaCharacterStats')) then
							statFrame.Label:SetText(E:TextGradient(format(STAT_FORMAT, label), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						end
					end
				end)

				if (not IsAddOnLoaded('DejaCharacterStats')) and (not IsAddOnLoaded("ElvUI_SLE")) then

					--banner other stats
					if E.db.ElvUI_EltreumUI.skins.statcolors then
						_G.CharacterFrame.EltruismExtraStatsFont:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, E.db.general.fontStyle)
						_G.CharacterFrame.EltruismExtraStatsFont:SetPoint("CENTER", CharacterStatsPane, "CENTER", 0, -80)
						--_G.CharacterFrame.EltruismExtraStatsFont:SetPoint("CENTER", CharacterStatsPane.EnhancementsCategory, "CENTER", 0, -80)
						_G.CharacterFrame.EltruismExtraStatsFont:SetParent(CharacterStatsPane)
						--if not _G.CharacterFrame.EltruismExtraStatsFont:GetText():match("|r") then
							_G.CharacterFrame.EltruismExtraStatsFont:SetText(E:TextGradient(L["Other"], statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						--end
						local linewidth5 = (( 193 - _G.CharacterFrame.EltruismExtraStatsFont:GetStringWidth())/2)
						_G.CharacterFrame.EltruismExtraStats:SetSize(linewidth5, 4)
						_G.CharacterFrame.EltruismExtraStats:SetPoint("RIGHT", _G.CharacterFrame.EltruismExtraStatsFont, "LEFT", 0, -1)
						_G.CharacterFrame.EltruismExtraStats:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga")
						_G.CharacterFrame.EltruismExtraStats:GetStatusBarTexture():SetGradient("HORIZONTAL", statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"])
						_G.CharacterFrame.EltruismExtraStats2:SetSize(linewidth5, 4)
						_G.CharacterFrame.EltruismExtraStats2:SetPoint("LEFT", _G.CharacterFrame.EltruismExtraStatsFont, "RIGHT", 0, -1)
						_G.CharacterFrame.EltruismExtraStats2:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga")
						_G.CharacterFrame.EltruismExtraStats2:GetStatusBarTexture():SetGradient("HORIZONTAL", statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"], statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"])
					else
						_G.CharacterFrame.EltruismExtraStatsBlock:SetSize(150, 18)
						--_G.CharacterFrame.EltruismExtraStatsBlock:SetPoint("CENTER", _G.CharacterFrame.EltruismExtraStatsFont, "CENTER", 0, 0)
						_G.CharacterFrame.EltruismExtraStatsBlock:SetTexture(E.Media.Textures.Black8x8)
						_G.CharacterFrame.EltruismExtraStatsBlock:SetParent(CharacterStatsPane)
						_G.CharacterFrame.EltruismExtraStatsFont:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize)
						_G.CharacterFrame.EltruismExtraStatsFont:SetPoint("CENTER", CharacterStatsPane, "CENTER", 0, -80)
						_G.CharacterFrame.EltruismExtraStatsFont:SetParent(CharacterStatsPane)
						_G.CharacterFrame.EltruismExtraStatsFont:SetTextColor(1, 1, 1)
						_G.CharacterFrame.EltruismExtraStatsFont:SetText(L["Other"])
					end

					--movement speed
					_G.CharacterFrame.EltruismSpeed:SetFont(E.LSM:Fetch('font', E.db.general.font), 10)
					_G.CharacterFrame.EltruismSpeed:SetTextColor(1, 1, 1)
					_G.CharacterFrame.EltruismSpeed:SetPoint("CENTER", CharacterStatsPane , 70, -163)
					_G.CharacterFrame.EltruismSpeed:SetParent(CharacterStatsPane)
					_G.CharacterFrame.EltruismSpeed:SetJustifyH("RIGHT")
					_G.CharacterFrame.EltruismSpeed:SetShadowColor(0, 0, 0, 1)
					_G.CharacterFrame.EltruismSpeed:SetShadowOffset(1, 0)

					_G.CharacterFrame.EltruismSpeedDesc:SetFont(E.LSM:Fetch('font', E.db.general.font), 10)
					_G.CharacterFrame.EltruismSpeedDesc:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
					_G.CharacterFrame.EltruismSpeedDesc:SetPoint("CENTER", CharacterStatsPane , -36, -163)
					_G.CharacterFrame.EltruismSpeedDesc:SetParent(CharacterStatsPane)
					_G.CharacterFrame.EltruismSpeedDesc:SetJustifyH("LEFT")
					_G.CharacterFrame.EltruismSpeedDesc:SetShadowColor(0, 0, 0, 1)
					_G.CharacterFrame.EltruismSpeedDesc:SetShadowOffset(1, 0)

					if E.db.ElvUI_EltreumUI.skins.statcolors then
						--if not _G.CharacterFrame.EltruismSpeedDesc:GetText():match("|r") then
							_G.CharacterFrame.EltruismSpeedDesc:SetText(E:TextGradient(STAT_MOVEMENT_SPEED, statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						--end
					else
						_G.CharacterFrame.EltruismSpeedDesc:SetText(STAT_MOVEMENT_SPEED)
					end

					_G.CharacterFrame.EltruismSpeedDescTooltip:SetSize(190, 15)
					_G.CharacterFrame.EltruismSpeedDescTooltip:SetPoint("CENTER", CharacterStatsPane, "CENTER", 0, -163)
					_G.CharacterFrame.EltruismSpeedDescTooltip:SetParent(CharacterStatsPane)
					_G.CharacterFrame.EltruismSpeedDescTooltip:Show()
					_G.CharacterFrame.EltruismSpeedDescTooltip:SetScript("OnEnter", function()
						_G["GameTooltip"]:SetOwner(_G.CharacterFrame.EltruismSpeedDescTooltip, 'ANCHOR_RIGHT')
						_G["GameTooltip"]:AddLine(format(CR_SPEED_TOOLTIP, string.format('%.2f', (GetUnitSpeed("player"))), ((GetUnitSpeed("player")/7) *100)))
						_G["GameTooltip"]:Show()
					end)
					_G.CharacterFrame.EltruismSpeedDescTooltip:SetScript("OnLeave", function()
						_G["GameTooltip"]:Hide()
					end)

					--class resource
					_G.CharacterFrame.EltruismClassResource:SetFont(E.LSM:Fetch('font', E.db.general.font), 10)
					_G.CharacterFrame.EltruismClassResource:SetTextColor(1, 1, 1)
					_G.CharacterFrame.EltruismClassResource:SetPoint("CENTER", CharacterStatsPane , 72, -176)
					_G.CharacterFrame.EltruismClassResource:SetParent(CharacterStatsPane)
					_G.CharacterFrame.EltruismClassResource:SetJustifyH("RIGHT")
					_G.CharacterFrame.EltruismClassResource:SetShadowColor(0, 0, 0, 1)
					_G.CharacterFrame.EltruismClassResource:SetShadowOffset(1, 0)
					_G.CharacterFrame.EltruismClassResourceDesc:SetFont(E.LSM:Fetch('font', E.db.general.font), 10)
					_G.CharacterFrame.EltruismClassResourceDesc:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
					_G.CharacterFrame.EltruismClassResourceDesc:SetPoint("CENTER", CharacterStatsPane , -46, -176)
					_G.CharacterFrame.EltruismClassResourceDesc:SetParent(CharacterStatsPane)
					if E.myclass == 'HUNTER' then
						if E.db.ElvUI_EltreumUI.skins.statcolors then
						--if not _G.CharacterFrame.EltruismClassResourceDesc:GetText():match("|r") then
							_G.CharacterFrame.EltruismClassResourceDesc:SetText(E:TextGradient(STAT_FOCUS_REGEN, statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						--end
						else
							_G.CharacterFrame.EltruismClassResourceDesc:SetText(STAT_FOCUS_REGEN)
						end
					elseif E.myclass == 'ROGUE' or E.myclass == 'DRUID' or E.myclass == 'MONK' then
						if E.db.ElvUI_EltreumUI.skins.statcolors then
							--if not _G.CharacterFrame.EltruismClassResourceDesc:GetText():match("|r") then
								_G.CharacterFrame.EltruismClassResourceDesc:SetText(E:TextGradient(STAT_ENERGY_REGEN, statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
							--end
						else
							_G.CharacterFrame.EltruismClassResourceDesc:SetText(STAT_ENERGY_REGEN)
						end
					elseif E.myclass == 'DEATHKNIGHT' then
						if E.db.ElvUI_EltreumUI.skins.statcolors then
							--if not _G.CharacterFrame.EltruismClassResourceDesc:GetText():match("|r") then
								_G.CharacterFrame.EltruismClassResourceDesc:SetText(E:TextGradient(STAT_RUNE_REGEN, statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
							--end
						else
							_G.CharacterFrame.EltruismClassResourceDesc:SetText(STAT_RUNE_REGEN)
						end
					elseif E.myclass == 'MAGE' or E.myclass == 'SHAMAN' or E.myclass == 'WARLOCK' or E.myclass == 'PALADIN' or E.myclass == 'PRIEST' then
						if E.db.ElvUI_EltreumUI.skins.statcolors then
							--if not _G.CharacterFrame.EltruismClassResourceDesc:GetText():match("|r") then
								_G.CharacterFrame.EltruismClassResourceDesc:SetText(E:TextGradient(MANA_REGEN, statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
							--end
						else
							_G.CharacterFrame.EltruismClassResourceDesc:SetText(MANA_REGEN)
						end
					end
					_G.CharacterFrame.EltruismClassResourceDesc:SetJustifyH("LEFT")
					_G.CharacterFrame.EltruismClassResourceDesc:SetShadowColor(0, 0, 0, 1)
					_G.CharacterFrame.EltruismClassResourceDesc:SetShadowOffset(1, 0)

					--class resource tooltip
					_G.CharacterFrame.EltruismClassResourceDescTooltip:SetSize(190, 15)
					_G.CharacterFrame.EltruismClassResourceDescTooltip:SetPoint("CENTER", CharacterStatsPane, "CENTER", 0, -176)
					_G.CharacterFrame.EltruismClassResourceDescTooltip:SetParent(CharacterStatsPane)
					if E.myclass == 'HUNTER' or E.myclass == 'ROGUE' or E.myclass == 'DRUID' or E.myclass == 'MONK' or E.myclass == 'DEATHKNIGHT' or E.myclass == 'MAGE' or E.myclass == 'SHAMAN' or E.myclass == 'WARLOCK' or E.myclass == 'PALADIN' or E.myclass == 'PRIEST' then
						_G.CharacterFrame.EltruismClassResource:Show()
						_G.CharacterFrame.EltruismClassResourceDesc:Show()
						_G.CharacterFrame.EltruismClassResourceDescTooltip:Show()
						local id, _
						local currentSpec = GetSpecialization()
						if currentSpec then
							id, _ = GetSpecializationInfo(currentSpec)
						end
						if id == 264 or id == 257 or id == 256 or id == 65 or id == 270 or id == 105 then
							_G.CharacterFrame.EltruismClassResource:Hide()
							_G.CharacterFrame.EltruismClassResourceDesc:Hide()
							_G.CharacterFrame.EltruismClassResourceDescTooltip:Hide()
						end
					else
						_G.CharacterFrame.EltruismClassResource:Hide()
						_G.CharacterFrame.EltruismClassResourceDesc:Hide()
						_G.CharacterFrame.EltruismClassResourceDescTooltip:Hide()
					end
					_G.CharacterFrame.EltruismClassResourceDescTooltip:SetScript("OnEnter", function()
						_G["GameTooltip"]:SetOwner(_G.CharacterFrame.EltruismClassResourceDescTooltip, 'ANCHOR_RIGHT')
						if E.myclass == 'HUNTER' then
							_G["GameTooltip"]:AddLine(STAT_FOCUS_REGEN_TOOLTIP)
						elseif E.myclass == 'ROGUE' or E.myclass == 'DRUID' or E.myclass == 'MONK' then
							_G["GameTooltip"]:AddLine(STAT_ENERGY_REGEN_TOOLTIP)
						elseif E.myclass == 'DEATHKNIGHT' then
							_G["GameTooltip"]:AddLine(STAT_RUNE_REGEN_TOOLTIP)
						elseif E.myclass == 'MAGE' or E.myclass == 'SHAMAN' or E.myclass == 'WARLOCK' or E.myclass == 'PALADIN' or E.myclass == 'PRIEST' then
							_G["GameTooltip"]:AddLine(MANA_REGEN_TOOLTIP)
						end
						_G["GameTooltip"]:Show()
					end)
					_G.CharacterFrame.EltruismClassResourceDescTooltip:SetScript("OnLeave", function()
						_G["GameTooltip"]:Hide()
					end)

					--class resource 2, because druids and monks are not nice
					_G.CharacterFrame.EltruismClassResource2:SetFont(E.LSM:Fetch('font', E.db.general.font), 10)
					_G.CharacterFrame.EltruismClassResource2:SetTextColor(1, 1, 1)
					_G.CharacterFrame.EltruismClassResource2:SetPoint("CENTER", CharacterStatsPane , 72, -189)
					_G.CharacterFrame.EltruismClassResource2:SetParent(CharacterStatsPane)
					_G.CharacterFrame.EltruismClassResource2:SetJustifyH("RIGHT")
					_G.CharacterFrame.EltruismClassResource2:SetShadowColor(0, 0, 0, 1)
					_G.CharacterFrame.EltruismClassResource2:SetShadowOffset(1, 0)

					_G.CharacterFrame.EltruismClassResourceDesc2:SetFont(E.LSM:Fetch('font', E.db.general.font), 10)
					_G.CharacterFrame.EltruismClassResourceDesc2:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
					_G.CharacterFrame.EltruismClassResourceDesc2:SetPoint("CENTER", CharacterStatsPane , -48, -189)
					_G.CharacterFrame.EltruismClassResourceDesc2:SetParent(CharacterStatsPane)
					if E.myclass == 'DRUID' or E.myclass == 'MONK' then
						if E.db.ElvUI_EltreumUI.skins.statcolors then
							--if not _G.CharacterFrame.EltruismClassResourceDesc:GetText():match("|r") then
								_G.CharacterFrame.EltruismClassResourceDesc2:SetText(E:TextGradient(MANA_REGEN, statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
							--end
						else
							_G.CharacterFrame.EltruismClassResourceDesc2:SetText(MANA_REGEN)
						end
					end
					_G.CharacterFrame.EltruismClassResourceDesc2:SetJustifyH("LEFT")
					_G.CharacterFrame.EltruismClassResourceDesc2:SetShadowColor(0, 0, 0, 1)
					_G.CharacterFrame.EltruismClassResourceDesc2:SetShadowOffset(1, 0)

					_G.CharacterFrame.EltruismClassResourceDescTooltip2:SetSize(190, 15)
					_G.CharacterFrame.EltruismClassResourceDescTooltip2:SetPoint("CENTER", CharacterStatsPane, "CENTER", 0, -189)
					_G.CharacterFrame.EltruismClassResourceDescTooltip2:SetParent(CharacterStatsPane)
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
						_G["GameTooltip"]:SetOwner(_G.CharacterFrame.EltruismClassResourceDescTooltip2, 'ANCHOR_RIGHT')
						if E.myclass == 'DRUID' or E.myclass == 'MONK' then
							_G["GameTooltip"]:AddLine(MANA_REGEN_TOOLTIP)
						end
						_G["GameTooltip"]:Show()
					end)
					_G.CharacterFrame.EltruismClassResourceDescTooltip2:SetScript("OnLeave", function()
						_G["GameTooltip"]:Hide()
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

						local stats = {CharacterStatsPane:GetChildren()}
						local number = (#stats)
						if E.db.ElvUI_EltreumUI.dev then
							ElvUI_EltreumUI:Print("Number of stats: "..number)
						end
						--15 seems like the minimum now with the added stats
						if number == 15 then
							_G.CharacterFrame.EltruismExtraStats:SetPoint("CENTER", CharacterStatsPane, "CENTER", 0, -90)
							_G.CharacterFrame.EltruismExtraStatsFont:SetPoint("CENTER", CharacterStatsPane, "CENTER", 0, -90)
						elseif number == 16 then
							_G.CharacterFrame.EltruismExtraStats:SetPoint("CENTER", CharacterStatsPane, "CENTER", 0, -100)
							_G.CharacterFrame.EltruismExtraStatsFont:SetPoint("CENTER", CharacterStatsPane, "CENTER", 0, -100)
						elseif number == 17 then
							_G.CharacterFrame.EltruismExtraStats:SetPoint("CENTER", CharacterStatsPane, "CENTER", 0, -110)
							_G.CharacterFrame.EltruismExtraStatsFont:SetPoint("CENTER", CharacterStatsPane, "CENTER", 0, -110)
						elseif number == 18 then
							_G.CharacterFrame.EltruismExtraStats:SetPoint("CENTER", CharacterStatsPane, "CENTER", 0, -120)
							_G.CharacterFrame.EltruismExtraStatsFont:SetPoint("CENTER", CharacterStatsPane, "CENTER", 0, -120)
						elseif number == 19 then
							_G.CharacterFrame.EltruismExtraStats:SetPoint("CENTER", CharacterStatsPane, "CENTER", 0, -140)
							_G.CharacterFrame.EltruismExtraStatsFont:SetPoint("CENTER", CharacterStatsPane, "CENTER", 0, -140)
						elseif number == 20 then
							_G.CharacterFrame.EltruismExtraStats:SetPoint("CENTER", CharacterStatsPane, "CENTER", 0, -150)
							_G.CharacterFrame.EltruismExtraStatsFont:SetPoint("CENTER", CharacterStatsPane, "CENTER", 0, -150)
						elseif number == 21 then
							_G.CharacterFrame.EltruismExtraStats:SetPoint("CENTER", CharacterStatsPane, "CENTER", 0, -170)
							_G.CharacterFrame.EltruismExtraStatsFont:SetPoint("CENTER", CharacterStatsPane, "CENTER", 0, -170)
						elseif number > 21 and number < 26 then
							_G.CharacterFrame.EltruismExtraStats:SetPoint("CENTER", CharacterStatsPane, "CENTER", 0, -100)
							_G.CharacterFrame.EltruismExtraStatsFont:SetPoint("CENTER", CharacterStatsPane, "CENTER", 0, -100)
						elseif number >= 26 then
							_G.CharacterFrame.EltruismExtraStats:SetPoint("CENTER", CharacterStatsPane, "CENTER", 0, -120)
							_G.CharacterFrame.EltruismExtraStatsFont:SetPoint("CENTER", CharacterStatsPane, "CENTER", 0, -120)
						end

						_G.CharacterFrame.EltruismSpeed:SetPoint("CENTER", _G.CharacterFrame.EltruismExtraStatsFont , 72, -20)
						if E.locale == "enUS" then
							_G.CharacterFrame.EltruismSpeedDesc:SetPoint("CENTER", _G.CharacterFrame.EltruismExtraStatsFont , -36, -20)
						else
							_G.CharacterFrame.EltruismSpeedDesc:SetPoint("CENTER", _G.CharacterFrame.EltruismExtraStatsFont , -30, -20)
						end
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

						_G.CharacterFrame.EltruismExtraStatsBlock:SetPoint("CENTER", _G.CharacterFrame.EltruismExtraStatsFont, "CENTER", 0, 0)
					end)

					_G.CharacterFrame.EltruismExtraStatsBlock:SetPoint("CENTER", _G.CharacterFrame.EltruismExtraStatsFont, "CENTER", 0, 0)
				end
			end
		elseif E.Wrath or E.TBC or E.Classic then

			--color stats with a class gradient
			if E.db.ElvUI_EltreumUI.skins.statcolors then
				if E.Wrath or E.TBC then
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
						if _G.PlayerStatFrameRight6Label:GetText() ~= nil and not _G.PlayerStatFrameRight6Label:GetText():match("|r") then
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
						if _G.PlayerStatFrameRight6Label:GetText() ~= nil and not _G.PlayerStatFrameRight6Label:GetText():match("|r") then
							_G.PlayerStatFrameRight6Label:SetText(E:TextGradient(_G.PlayerStatFrameRight6Label:GetText(), statgradients[E.myclass]["r1"],statgradients[E.myclass]["g1"],statgradients[E.myclass]["b1"], statgradients[E.myclass]["r2"],statgradients[E.myclass]["g2"],statgradients[E.myclass]["b2"]))
						end
					end)
				end

				hooksecurefunc("PaperDollFrame_UpdateStats", function()
					if E.Wrath or E.TBC then
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
						if _G.PlayerStatFrameLeft6Label and not _G.PlayerStatFrameLeft6Label:GetText():match("|r") then
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
						if _G.PlayerStatFrameRight6Label:GetText() ~= nil and not _G.PlayerStatFrameRight6Label:GetText():match("|r") then
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
				ClassCrestFrame:SetPoint("CENTER", CharacterModelFrame, 0 , 50)
				ClassCrestFrame:SetParent(_G.CharacterFrame)
				ClassCrestFrameTexture:SetAtlas(classCrests[E.myclass], true)
				ClassCrestFrameTexture:SetAllPoints(ClassCrestFrame)
				ClassCrestFrameTexture:SetDrawLayer("BACKGROUND")
			end

			--add background from artifact weapon
			if E.db.ElvUI_EltreumUI.skins.expandarmorybg then

				--sometimes it returns nil for no known reason so have a check just in case
				local alpha
				if E.db.ElvUI_EltreumUI.skins.expandarmorybgalpha ~= nil then
					alpha = E.db.ElvUI_EltreumUI.skins.expandarmorybgalpha
				elseif E.db.ElvUI_EltreumUI.skins.expandarmorybgalpha == nil then
					alpha = 0.3
				end

				--add bg texture
				if E.db.ElvUI_EltreumUI.skins.armorybgtype == "CLASS" then
					CharacterFrameBackgroundTexture:SetTexture(classBgs[E.myclass])
					CharacterFrameBackgroundTexture:SetTexCoord(0, 0.87, 0, 0.60)
				elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "RACE" then
					CharacterFrameBackgroundTexture:SetTexture(raceBgs[E.myrace])
				elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "CUSTOM" then
					local texturefile = [[Interface\AddOns\]]..E.private.ElvUI_EltreumUI.skins.armorybgtexture
					CharacterFrameBackgroundTexture:SetTexture(texturefile)
				end
				if alpha == nil then
					CharacterFrameBackgroundTexture:SetAlpha(0.3)
				else
					CharacterFrameBackgroundTexture:SetAlpha(alpha)
				end
				CharacterFrameBackgroundTexture:SetAllPoints(_G.CharacterFrame.backdrop)
				CharacterFrameBackgroundTexture:SetDrawLayer("ARTWORK")
			end

			-- expand classic armory
			if E.db.ElvUI_EltreumUI.skins.classicarmory then

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

				if E.Wrath or E.TBC then
					_G.PlayerTitleDropDown:ClearAllPoints()
					_G.PlayerTitleDropDown:SetParent(CharacterModelFrame)
					_G.PlayerTitleDropDown:SetPoint('TOP', CharacterModelFrame, -6, 40)
					_G.PVPFrameToggleButton:ClearAllPoints()
					_G.PVPFrameToggleButton:SetPoint('TOP', _G.PVPHonor, 'TOP', 52, 42)
					_G.PVPFrameToggleButton:SetParent(_G.PVPFrameHonor)
				elseif E.Classic then
					CharacterTitleText:ClearAllPoints()
					CharacterTitleText:SetPoint('TOP', CharacterModelFrame, 0, 40)
					CharacterTitleText:SetParent(CharacterModelFrame)
				end

				CharacterNameText:ClearAllPoints()
				CharacterNameText:SetPoint('TOP', CharacterModelFrame, 0, 80)
				CharacterNameText:SetParent(CharacterModelFrame)
				CharacterNameText:SetFont(E.LSM:Fetch('font', E.db.general.font), 18, E.db.general.fontStyle)
				CharacterNameText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
				CharacterNameText:SetShadowColor(0, 0, 0, 0.8)
				CharacterNameText:SetShadowOffset(2, -1)

				CharacterLevelText:ClearAllPoints()
				--CharacterLevelText:SetPoint('TOP', CharacterModelFrame, 0, 60)
				CharacterLevelText:SetPoint('TOP', CharacterNameText, 'BOTTOM', 0, -10)
				CharacterLevelText:SetParent(CharacterModelFrame)

				CharacterFrame.Text4:SetSize(418, 72)
				CharacterFrame.Text4:SetPoint("TOP", CharacterFrame, "TOP", 150, 10)
				CharacterFrame.Text4:SetParent(_G["PaperDollItemsFrame"])
				CharacterFrame.Text4:SetTextColor(1, 1, 1)
				CharacterFrame.Text4:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, E.db.general.fontStyle)
				CharacterFrame.Text4:SetText(L["Specialization"])

				CharacterFrame.StatusLine4:SetSize(170, 3)
				CharacterFrame.StatusLine4:SetPoint("CENTER", CharacterFrame.Text4, "CENTER", 0, -15)
				CharacterFrame.StatusLine4:SetParent(_G["PaperDollItemsFrame"])
				CharacterFrame.StatusLine4:SetStatusBarTexture(E.Media.Textures.Highlight)
				CharacterFrame.StatusLine4:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)

				CharacterFrame.Text5:SetSize(418, 72)
				CharacterFrame.Text5:SetPoint("TOP", CharacterFrame, "TOP", 150, -20)
				CharacterFrame.Text5:SetParent(_G["PaperDollItemsFrame"])
				CharacterFrame.Text5:SetTextColor(classcolor.r, classcolor.g, classcolor.b, 1)
				CharacterFrame.Text5:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, E.db.general.fontStyle)
				CharacterFrame.Text5:SetText(PlayerSpec())

				--change the size based on if paperdoll is hidden
				CharacterFrame:SetSize(600, 505)
				hooksecurefunc("CharacterFrameTab_OnClick", function()
					if not InCombatLockdown() then
						if PaperDollFrame:IsShown() then
							CharacterFrame:SetSize(600, 505)
						else
							CharacterFrame:SetSize(400, 505)
						end
					end
				end)

				_G.PaperDollItemsFrame:SetScript("OnShow", function()
					if not InCombatLockdown() then
						if PaperDollFrame:IsShown() then
							CharacterFrame:SetSize(600, 505)
						else
							CharacterFrame:SetSize(400, 505)
						end
					end
				end)

				CharacterFrame.Text:SetSize(418, 72)
				CharacterFrame.Text:SetPoint("TOP", CharacterFrame, "TOP", 150, -45)
				CharacterFrame.Text:SetParent(_G["PaperDollItemsFrame"])
				CharacterFrame.Text:SetTextColor(1, 1, 1)
				CharacterFrame.Text:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, E.db.general.fontStyle)
				CharacterFrame.Text:SetText(L["Item Level"])

				CharacterFrame.StatusLine:SetSize(170, 3)
				CharacterFrame.StatusLine:SetPoint("CENTER", CharacterFrame.Text, "CENTER", 0, -15)
				CharacterFrame.StatusLine:SetParent(_G["PaperDollItemsFrame"])
				CharacterFrame.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				CharacterFrame.StatusLine:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)

				CharacterFrame.Text2:SetSize(418, 72)
				CharacterFrame.Text2:SetPoint("TOP", CharacterFrame, "TOP", 150, -80)
				CharacterFrame.Text2:SetParent(_G["PaperDollItemsFrame"])
				CharacterFrame.Text2:SetTextColor(classcolor.r, classcolor.g, classcolor.b, 1)
				CharacterFrame.Text2:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, E.db.general.fontStyle)

				CharacterFrame.StatusLine2:SetFrameStrata("LOW")
				CharacterFrame.StatusLine2:SetSize(170, 25)
				CharacterFrame.StatusLine2:SetPoint("CENTER", CharacterFrame.Text2, "CENTER", 0, 0)
				CharacterFrame.StatusLine2:SetParent(_G["PaperDollItemsFrame"])
				CharacterFrame.StatusLine2:SetStatusBarTexture(E.Media.Textures.Highlight)
				CharacterFrame.StatusLine2:SetStatusBarColor(1, 1, 1, 0.8)

				CharacterFrame.Text3:SetSize(418, 72)
				CharacterFrame.Text3:SetPoint("TOP", CharacterFrame, "TOP", 150, -105)
				CharacterFrame.Text3:SetParent(_G["PaperDollItemsFrame"])
				CharacterFrame.Text3:SetTextColor(1, 1, 1)
				CharacterFrame.Text3:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, E.db.general.fontStyle)
				CharacterFrame.Text3:SetText(L["Attributes"])

				CharacterFrame.StatusLine3:SetSize(170, 3)
				CharacterFrame.StatusLine3:SetPoint("CENTER", CharacterFrame.Text3, "CENTER", 0, -15)
				CharacterFrame.StatusLine3:SetParent(_G["PaperDollItemsFrame"])
				CharacterFrame.StatusLine3:SetStatusBarTexture(E.Media.Textures.Highlight)
				CharacterFrame.StatusLine3:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)

				--move the model
				CharacterModelFrame:ClearAllPoints()
				CharacterModelFrame:SetPoint("RIGHT", CharacterFrame, "CENTER", -20, 0)
				CharacterModelFrame:SetSize(200, 300)

				_G.CharacterModelFrameRotateRightButton:Hide()
				_G.CharacterModelFrameRotateLeftButton:Hide()

				--magic resistance stuff, maybe make it a loop in the future
				_G.MagicResFrame1:ClearAllPoints()
				if E.Wrath or E.TBC then
					_G.MagicResFrame1:SetParent(_G.PlayerStatFrameLeft1)
					_G.MagicResFrame1:SetPoint("TOPLEFT", _G.PlayerStatFrameLeftDropDown, "TOPLEFT", 14, 27)
				elseif E.Classic then
					_G.MagicResFrame1:SetParent(_G.CharacterStatFrame1)
					_G.MagicResFrame1:SetPoint("BOTTOM", CharacterFrame.StatusLine3, "BOTTOM", -55, -50)
				end
				_G.MagicResFrame2:ClearAllPoints()
				_G.MagicResFrame2:SetParent(_G.MagicResFrame1)
				_G.MagicResFrame2:SetPoint("RIGHT", _G.MagicResFrame1, "RIGHT", 27, 0)
				_G.MagicResFrame2:SetParent(_G["PaperDollItemsFrame"])
				_G.MagicResFrame3:ClearAllPoints()
				_G.MagicResFrame3:SetParent(_G.MagicResFrame2)
				_G.MagicResFrame3:SetPoint("RIGHT", _G.MagicResFrame2, "RIGHT", 27, 0)
				_G.MagicResFrame3:SetParent(_G["PaperDollItemsFrame"])
				_G.MagicResFrame4:ClearAllPoints()
				_G.MagicResFrame4:SetParent(_G.MagicResFrame3)
				_G.MagicResFrame4:SetPoint("RIGHT", _G.MagicResFrame3, "RIGHT", 27, 0)
				_G.MagicResFrame4:SetParent(_G["PaperDollItemsFrame"])
				_G.MagicResFrame5:ClearAllPoints()
				_G.MagicResFrame5:SetParent(_G.MagicResFrame4)
				_G.MagicResFrame5:SetPoint("RIGHT", _G.MagicResFrame4, "RIGHT", 27, 0)
				_G.MagicResFrame5:SetParent(_G["PaperDollItemsFrame"])

				if E.Wrath or E.TBC then
					--"left side" or in this case the top side
					_G.PlayerStatFrameLeftDropDown:ClearAllPoints()
					_G.PlayerStatFrameLeftDropDown:SetPoint("TOP", CharacterFrame, "TOP", 143, -200)
					_G.PlayerStatFrameLeftDropDown:SetParent(_G["PaperDollItemsFrame"])

					_G.PlayerStatFrameLeft1:ClearAllPoints()
					_G.PlayerStatFrameLeft1:SetPoint("TOP", CharacterFrame, "TOP", 124, -225)
					_G.PlayerStatFrameLeft1:SetParent(_G["PaperDollItemsFrame"])

					_G.PlayerStatFrameLeft2:ClearAllPoints()
					_G.PlayerStatFrameLeft2:SetPoint("BOTTOM", _G.PlayerStatFrameLeft1, "BOTTOM", 0, -13)
					_G.PlayerStatFrameLeft2:SetParent(_G["PaperDollItemsFrame"])

					_G.PlayerStatFrameLeft2.StatusLine:SetSize(170, 12)
					_G.PlayerStatFrameLeft2.StatusLine:SetPoint("CENTER", _G.PlayerStatFrameLeft2, "CENTER", 25, 0)
					_G.PlayerStatFrameLeft2.StatusLine:SetParent(_G["PaperDollItemsFrame"])
					_G.PlayerStatFrameLeft2.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
					_G.PlayerStatFrameLeft2.StatusLine:SetStatusBarColor(1, 1, 1, 0.3)

					_G.PlayerStatFrameLeft3:ClearAllPoints()
					_G.PlayerStatFrameLeft3:SetPoint("BOTTOM", _G.PlayerStatFrameLeft2, "BOTTOM", 0, -13)
					_G.PlayerStatFrameLeft3:SetParent(_G["PaperDollItemsFrame"])

					_G.PlayerStatFrameLeft4:ClearAllPoints()
					_G.PlayerStatFrameLeft4:SetPoint("BOTTOM", _G.PlayerStatFrameLeft3, "BOTTOM", 0, -13)
					_G.PlayerStatFrameLeft4:SetParent(_G["PaperDollItemsFrame"])

					_G.PlayerStatFrameLeft4.StatusLine:SetSize(170, 12)
					_G.PlayerStatFrameLeft4.StatusLine:SetPoint("CENTER", _G.PlayerStatFrameLeft4, "CENTER", 25, 0)
					_G.PlayerStatFrameLeft4.StatusLine:SetParent(_G["PaperDollItemsFrame"])
					_G.PlayerStatFrameLeft4.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
					_G.PlayerStatFrameLeft4.StatusLine:SetStatusBarColor(1, 1, 1, 0.3)

					_G.PlayerStatFrameLeft5:ClearAllPoints()
					_G.PlayerStatFrameLeft5:SetPoint("BOTTOM", _G.PlayerStatFrameLeft4, "BOTTOM", 0, -13)
					_G.PlayerStatFrameLeft5:SetParent(_G["PaperDollItemsFrame"])

					_G.PlayerStatFrameLeft6:ClearAllPoints()
					_G.PlayerStatFrameLeft6:SetPoint("BOTTOM", _G.PlayerStatFrameLeft5, "BOTTOM", 0, -13)
					_G.PlayerStatFrameLeft6:SetParent(_G["PaperDollItemsFrame"])

					_G.PlayerStatFrameLeft6.StatusLine:SetSize(170, 12)
					_G.PlayerStatFrameLeft6.StatusLine:SetPoint("CENTER", _G.PlayerStatFrameLeft6, "CENTER", 25, 0)
					_G.PlayerStatFrameLeft6.StatusLine:SetParent(_G["PaperDollItemsFrame"])
					_G.PlayerStatFrameLeft6.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
					_G.PlayerStatFrameLeft6.StatusLine:SetStatusBarColor(1, 1, 1, 0.3)

					_G.PlayerStatFrameLeft1Stat:ClearAllPoints()
					_G.PlayerStatFrameLeft1Stat:SetPoint("TOP", CharacterFrame, "TOP", 211, -225)
					_G.PlayerStatFrameLeft1Stat:SetParent(_G["PaperDollItemsFrame"])
					_G.PlayerStatFrameLeft2Stat:ClearAllPoints()
					_G.PlayerStatFrameLeft2Stat:SetPoint("BOTTOM", _G.PlayerStatFrameLeft1Stat, "BOTTOM", 0, -13)
					_G.PlayerStatFrameLeft2Stat:SetParent(_G["PaperDollItemsFrame"])
					_G.PlayerStatFrameLeft3Stat:ClearAllPoints()
					_G.PlayerStatFrameLeft3Stat:SetPoint("BOTTOM", _G.PlayerStatFrameLeft2Stat, "BOTTOM", 0, -13)
					_G.PlayerStatFrameLeft3Stat:SetParent(_G["PaperDollItemsFrame"])
					_G.PlayerStatFrameLeft4Stat:ClearAllPoints()
					_G.PlayerStatFrameLeft4Stat:SetPoint("BOTTOM", _G.PlayerStatFrameLeft3Stat, "BOTTOM", 0, -13)
					_G.PlayerStatFrameLeft4Stat:SetParent(_G["PaperDollItemsFrame"])
					_G.PlayerStatFrameLeft5Stat:ClearAllPoints()
					_G.PlayerStatFrameLeft5Stat:SetPoint("BOTTOM", _G.PlayerStatFrameLeft4Stat, "BOTTOM", 0, -13)
					_G.PlayerStatFrameLeft5Stat:SetParent(_G["PaperDollItemsFrame"])
					_G.PlayerStatFrameLeft6Stat:ClearAllPoints()
					_G.PlayerStatFrameLeft6Stat:SetPoint("BOTTOM", _G.PlayerStatFrameLeft5Stat, "BOTTOM", 0, -13)
					_G.PlayerStatFrameLeft6Stat:SetParent(_G["PaperDollItemsFrame"])

					--"right side", on this case its the bottom
					_G.PlayerStatFrameRightDropDown:ClearAllPoints()
					_G.PlayerStatFrameRightDropDown:SetPoint("TOP", CharacterFrame, "TOP", 143, -310)
					_G.PlayerStatFrameRightDropDown:SetParent(_G["PaperDollItemsFrame"])

					_G.PlayerStatFrameRight1:ClearAllPoints()
					_G.PlayerStatFrameRight1:SetPoint("TOP", CharacterFrame, "TOP", 124, -335)
					_G.PlayerStatFrameRight1:SetParent(_G["PaperDollItemsFrame"])
					_G.PlayerStatFrameRight2:ClearAllPoints()
					_G.PlayerStatFrameRight2:SetPoint("BOTTOM", _G.PlayerStatFrameRight1, "BOTTOM", 0, -13)
					_G.PlayerStatFrameRight2:SetParent(_G["PaperDollItemsFrame"])

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

					SkillFrame:SetHeight(400)
					_G.SkillDetailScrollChildFrame:ClearAllPoints()
					_G.SkillDetailScrollChildFrame:SetPoint("BOTTOMLEFT", CharacterFrame, "BOTTOMLEFT", 30, 150)
					_G.SkillDetailScrollChildFrame:SetParent(SkillFrame)
					_G.SkillFrameCancelButton:Hide()
				end
			end
		end
	end
end

--https://wowpedia.fandom.com/wiki/InventorySlotId
local InvSlotIdTable = {
	[1] = "HeadSlot", --left
	[2] = "NeckSlot", --left
	[3] = "ShoulderSlot", --left
	[4] = "ShirtSlot", --left
	[5] = "ChestSlot", --left
	[6] = "WaistSlot", --right
	[7] = "LegsSlot", --right
	[8] = "FeetSlot",--right
	[9] = "WristSlot", --left
	[10] = "HandsSlot", --right
	[11] = "Finger0Slot", --right
	[12] = "Finger1Slot",--right
	[13] = "Trinket0Slot",--right
	[14] = "Trinket1Slot",--right
	[15] = "BackSlot", --left
	[16] = "MainHandSlot", --left
	[17] = "SecondaryHandSlot",--right
	[18] = "RangedSlot", --classic only
	[19] = "TabardSlot", --left
}

if E.Retail then
	InvSlotIdTable = {
		[1] = "HeadSlot", --left
		[2] = "NeckSlot", --left
		[3] = "ShoulderSlot", --left
		[4] = "ShirtSlot", --left
		[5] = "ChestSlot", --left
		[6] = "WaistSlot", --right
		[7] = "LegsSlot", --right
		[8] = "FeetSlot",--right
		[9] = "WristSlot", --left
		[10] = "HandsSlot", --right
		[11] = "Finger0Slot", --right
		[12] = "Finger1Slot",--right
		[13] = "Trinket0Slot",--right
		[14] = "Trinket1Slot",--right
		[15] = "BackSlot", --left
		[16] = "MainHandSlot", --left
		[17] = "SecondaryHandSlot",--right
	}
end

local qualityAnchor
local qualityAnchorInspect

--Player Item Quality Texture
function ElvUI_EltreumUI:PlayerItemQuality(unit)
	if E.db.ElvUI_EltreumUI.skins.itemquality and not E.private.skins.blizzard.enable == false then
		E:Delay(0, function()
			for InvSlotId, InvSlotName in pairs(InvSlotIdTable) do
				qualityAnchor = _G["Character"..InvSlotIdTable[InvSlotId]]
				if qualityAnchor == nil then return end

				if _G["EltruismItemQuality"..InvSlotName] then
					qualityAnchor.Frame = _G["EltruismItemQuality"..InvSlotName]
				else
					qualityAnchor.Frame = CreateFrame('Frame', "EltruismItemQuality"..InvSlotName, qualityAnchor)
				end
				if _G["EltruismItemQualityTexture"..InvSlotName] then
					qualityAnchor.Frame.Quality = _G["EltruismItemQualityTexture"..InvSlotName]
				else
					qualityAnchor.Frame.Quality = qualityAnchor.Frame:CreateTexture("EltruismItemQualityTexture"..InvSlotName, "OVERLAY")
				end

				local slotlevel = _G["CharacterModelFrame"]:GetFrameLevel()
				qualityAnchor.Frame:SetFrameLevel(slotlevel-1) --needs to be changed to not overlap the sockets/enchants
				local slotsize = _G["Character"..InvSlotName]:GetHeight()
				if not E.Retail then
					qualityAnchor.Frame:SetSize(120, slotsize+2)
				else
					qualityAnchor.Frame:SetSize(250, slotsize+2)
				end

				qualityAnchor.Frame.Quality:SetInside() --if not then the frame will not anchor correctly
				qualityAnchor.Frame.Quality:SetTexture('Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Statusbar\\EltreumFade') --temp for testing

				--get item (actual) quality
				local itemLink = GetInventoryItemLink(unit, InvSlotId)
				if itemLink ~= nil then
					local quality = select(3,GetItemInfo(itemLink))
					if quality ~= nil then
						local r,g,b = GetItemQualityColor(quality)
						qualityAnchor.Frame.Quality:SetVertexColor(r, g, b)
						qualityAnchor.Frame.Quality:SetAlpha(1)
					end
				elseif itemLink == nil then
					qualityAnchor.Frame.Quality:SetAlpha(0)
				end

				--align them left or right based on id since its known where they go (unless another addon changes their side...)
				if InvSlotId == 1 or InvSlotId == 2 or InvSlotId == 3 or InvSlotId == 5 or InvSlotId == 9 or InvSlotId == 15 or InvSlotId == 18 then
					qualityAnchor.Frame:SetPoint("LEFT", _G["Character"..InvSlotName], "RIGHT", -_G["Character"..InvSlotName]:GetWidth()-4, 0)
					qualityAnchor.Frame.Quality:SetPoint("LEFT", _G["Character"..InvSlotName], "RIGHT", -_G["Character"..InvSlotName]:GetWidth()-4, 0)
				elseif InvSlotId == 6 or InvSlotId == 7 or InvSlotId == 8 or InvSlotId == 10 or InvSlotId == 11 or InvSlotId == 12 or InvSlotId == 13 or InvSlotId == 14 or InvSlotId == 16 then
					qualityAnchor.Frame:SetPoint("RIGHT", _G["Character"..InvSlotName], "LEFT", _G["Character"..InvSlotName]:GetWidth()+4, 0)
					qualityAnchor.Frame.Quality:SetPoint("RIGHT", _G["Character"..InvSlotName], "LEFT", _G["Character"..InvSlotName]:GetWidth()+4, 0)
					--flip the texture since its on the other side
					qualityAnchor.Frame.Quality:SetTexCoord(1, 0, 0, 1)
				elseif InvSlotId == 17 then --rotate for the off hand slot that is in the middle in classic/tbc/wrath
					if not E.Retail then
						qualityAnchor.Frame.Quality:SetRotation(1.57079633)
						qualityAnchor.Frame:SetPoint("BOTTOM", _G["Character"..InvSlotName], "BOTTOM", 0, 37)
						qualityAnchor.Frame.Quality:SetPoint("BOTTOM", _G["Character"..InvSlotName], "BOTTOM", 0, 37)
					else
						qualityAnchor.Frame:SetPoint("LEFT", _G["Character"..InvSlotName], "RIGHT", -_G["Character"..InvSlotName]:GetWidth()-4, 0)
						qualityAnchor.Frame.Quality:SetPoint("LEFT", _G["Character"..InvSlotName], "RIGHT", -_G["Character"..InvSlotName]:GetWidth()-4, 0)
					end
				end
			end
		end)
	end
end
local refreshplayer = CreateFrame("FRAME")
refreshplayer:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
--refreshplayer:RegisterEvent("UNIT_INVENTORY_CHANGED", "target") --need to test to see if too much cpu/memory (specially for pvp)
refreshplayer:SetScript("OnEvent", function()
	ElvUI_EltreumUI:PlayerItemQuality("player")
end)

--inspect bg/item quality texture
local EltruismInspectBg = CreateFrame("Frame", "EltruismInspectBg")
local EltruismInspectBgTexture = EltruismInspectBg:CreateTexture()
function ElvUI_EltreumUI:InspectBg(unit)
	if not E.private.skins.blizzard.enable == false then
		local alpha
		if E.db.ElvUI_EltreumUI.skins.expandarmorybgalpha ~= nil then
			alpha = E.db.ElvUI_EltreumUI.skins.expandarmorybgalpha
		elseif E.db.ElvUI_EltreumUI.skins.expandarmorybgalpha == nil then
			alpha = 0.3
		end

		--inspect frame bg
		if IsAddOnLoaded("Blizzard_InspectUI") then
			EltruismInspectBg:SetParent(_G.InspectFrame)

			if E.db.ElvUI_EltreumUI.skins.expandarmorybg then
				local _, englishClass, _, englishRace = GetPlayerInfoByGUID(unit)
				if englishClass or englishRace then
					if _G.InspectFrame then
						--add bg texture
						if E.db.ElvUI_EltreumUI.skins.armorybgtype == "CLASS" then
							EltruismInspectBgTexture:SetTexture(classBgs[englishClass])
							EltruismInspectBgTexture:SetTexCoord(0, 0.87, 0, 0.60)
						elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "RACE" then
							EltruismInspectBgTexture:SetTexture(raceBgs[englishRace]) --(left, right, top, bottom)
							if not E.myrace == 'NightElf' then
								EltruismInspectBgTexture:SetTexCoord(0, 0.80, 0, 1)
							else
								EltruismInspectBgTexture:SetTexCoord(0, 0.60, 0, 1)
							end
						elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "CUSTOM" then
							local texturefile = [[Interface\AddOns\]]..E.private.ElvUI_EltreumUI.skins.armorybgtexture
							EltruismInspectBgTexture:SetTexture(texturefile)
						end

						if alpha ~= nil then
							EltruismInspectBgTexture:SetAlpha(alpha)
						else
							EltruismInspectBgTexture:SetAlpha(0.3)
						end
						if E.Wrath or E.TBC or E.Classic then
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
							--InspectModelFrame.backdrop:Hide()
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

			--add a texture based on quality too, tbc needed a timer
			if E.db.ElvUI_EltreumUI.skins.itemquality then
				E:Delay(0, function()
					for InvSlotId, InvSlotName in pairs(InvSlotIdTable) do
						qualityAnchorInspect = _G["Inspect"..InvSlotIdTable[InvSlotId]]
						if qualityAnchorInspect == nil then return end

						if _G["EltruismInspectItemQuality"..InvSlotName] then
							qualityAnchorInspect.Frame = _G["EltruismInspectItemQuality"..InvSlotName]
						else
							qualityAnchorInspect.Frame = CreateFrame('FRAME', "EltruismInspectItemQuality"..InvSlotName, qualityAnchorInspect)
						end
						if _G["EltruismInspectItemQualityTexture"..InvSlotName] then
							qualityAnchorInspect.Frame.Quality = _G["EltruismInspectItemQualityTexture"..InvSlotName]
						else
							qualityAnchorInspect.Frame.Quality = qualityAnchorInspect.Frame:CreateTexture("EltruismInspectItemQualityTexture"..InvSlotName, "OVERLAY")
						end

						local slotlevel = _G["InspectModelFrame"]:GetFrameLevel()
						qualityAnchorInspect.Frame:SetFrameLevel(slotlevel-1)
						local slotsize = _G["Inspect"..InvSlotName]:GetHeight()
						if not E.Retail then
							qualityAnchorInspect.Frame:SetSize(120, slotsize+2)
						else
							qualityAnchorInspect.Frame:SetSize(140, slotsize+2)
						end

						qualityAnchorInspect.Frame.Quality:SetTexture('Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Statusbar\\EltreumFade') --temp for testing
						qualityAnchorInspect.Frame.Quality:SetInside() --if not then the frame will not anchor correctly

						--get item (actual) quality
						local itemLink = GetInventoryItemLink("target", InvSlotId)
						if itemLink ~= nil then
							local quality = select(3,GetItemInfo(itemLink))
							local r,g,b = GetItemQualityColor(quality)
							qualityAnchorInspect.Frame.Quality:SetVertexColor(r, g, b)
							qualityAnchorInspect.Frame.Quality:SetAlpha(1)
						else
							qualityAnchorInspect.Frame.Quality:SetAlpha(0)
						end

						--align them left or right based on id since its known where they go (unless another addon changes their side...)
						if InvSlotId == 1 or InvSlotId == 2 or InvSlotId == 3 or InvSlotId == 5 or InvSlotId == 9 or InvSlotId == 15 or InvSlotId == 18 then
							qualityAnchorInspect.Frame:SetPoint("LEFT", _G["Inspect"..InvSlotName], "RIGHT", -_G["Inspect"..InvSlotName]:GetWidth()-4, 0)
							qualityAnchorInspect.Frame.Quality:SetPoint("LEFT", _G["Inspect"..InvSlotName], "RIGHT", -_G["Inspect"..InvSlotName]:GetWidth()-4, 0)
						elseif InvSlotId == 6 or InvSlotId == 7 or InvSlotId == 8 or InvSlotId == 10 or InvSlotId == 11 or InvSlotId == 12 or InvSlotId == 13 or InvSlotId == 14 or InvSlotId == 16 then
							qualityAnchorInspect.Frame:SetPoint("RIGHT", _G["Inspect"..InvSlotName], "LEFT", _G["Inspect"..InvSlotName]:GetWidth()+4, 0)
							qualityAnchorInspect.Frame.Quality:SetPoint("RIGHT", _G["Inspect"..InvSlotName], "LEFT", _G["Inspect"..InvSlotName]:GetWidth()+4, 0)
							--flip the texture since its on the other side
							qualityAnchorInspect.Frame.Quality:SetTexCoord(1, 0, 0, 1)
						elseif InvSlotId == 17 then --rotate for the off hand slot that is in the middle in classic/tbc/wrath
							if not E.Retail then
								qualityAnchorInspect.Frame.Quality:SetRotation(1.57079633)
								qualityAnchorInspect.Frame:SetPoint("BOTTOM", _G["Inspect"..InvSlotName], "BOTTOM", 0, 37)
								qualityAnchorInspect.Frame.Quality:SetPoint("BOTTOM", _G["Inspect"..InvSlotName], "BOTTOM", 0, 37)
							else
								qualityAnchorInspect.Frame:SetPoint("LEFT", _G["Inspect"..InvSlotName], "RIGHT", -_G["Inspect"..InvSlotName]:GetWidth()-4, 0)
								qualityAnchorInspect.Frame.Quality:SetPoint("LEFT", _G["Inspect"..InvSlotName], "RIGHT", -_G["Inspect"..InvSlotName]:GetWidth()-4, 0)
							end
						end
					end
				end)
			end


		end
	end
end
