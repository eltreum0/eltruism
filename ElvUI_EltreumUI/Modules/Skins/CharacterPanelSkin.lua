local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local select = _G.select
local classcolor = E:ClassColor(E.myclass, true)
local CreateFrame = _G.CreateFrame
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
local MANA_REGEN = _G.MANA_REGEN
local total, maxlevel = 0, 0
local level, mainhand, offhand, ranged
local linkloop
local mainlevel
local mainlink
local offhandlink
local offhandlevel
local rangedlevel
local rangedlink
local spec, points
local _, spent1
local spent2
local spent3
local name, spent
local linewidth1
local texturefile
local linewidth3
local linewidth2
local linewidthsle1
local linewidthsle2
local linewidth5
local id
local currentSpec
local speed
local combatText
local combat
local regenRate
local regenRateText
local stats
local number

--improving character panel
local CharacterFrame = _G.CharacterFrame
local CharacterFrameBackgroundTexture = _G.CharacterFrame:CreateTexture("EltruismCharacterBG")
local ClassCrestFrame = CreateFrame("Frame")
local ClassCrestFrameTexture = ClassCrestFrame:CreateTexture("EltruismClassCrest")
local CharacterFrameBackgroundTextureFader = ClassCrestFrame:CreateTexture("EltruismCharacterBGVignette")
CharacterFrameBackgroundTextureFader:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Vignette.tga")

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

--from 4k: height to 1920, resize to 1024x512, add 20 sharpen, set 30 bright 30 contrast, add vignette 0.35 (dont anymore), compress depending on size
local raceBgs = {
	["BloodElf"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\BloodElf",
	["HighmountainTauren"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\Highmountain",
	["Goblin"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\Goblin",
	["Vulpera"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\Vulpera",
	["Nightborne"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\Nightborne",
	["MagharOrc"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\MagharOrc",
	["Orc"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\Orc",
	["Scourge"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\Undead",
	["Tauren"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\Tauren",
	["Troll"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\Troll",
	["ZandalariTroll"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\Zandalari",
	["DarkIronDwarf"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\DarkIron",
	["Draenei"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\Draenei",
	["Gnome"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\Gnome",
	["Dwarf"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\Dwarf",
	["Human"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\Human",
	["KulTiran"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\KulTiran",
	["LightforgedDraenei"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\Lightforged",
	["NightElf"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\NightElf",
	["Mechagnome"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\Mechagnome",
	["VoidElf"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\VoidElf",
	["Pandaren"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\Pandaren",
	["Worgen"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\Worgen",
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
	["WARRIOR"] = {r1 = 0.60, g1 = 0.40, b1 = 0.20, r2 = 0.66, g2 = 0.53, b2 = 0.34},
	["PALADIN"] = {r1 = 0.9, g1 = 0.46, b1 = 0.64, r2 = 0.95, g2 = 0.65, b2 = 0.83},
	["HUNTER"] = {r1 = 0.58, g1 = 0.69, b1 = 0.29, r2 = 0.79, g2 = 1, b2 = 0.39},
	["ROGUE"] = {r1 = 1, g1 = 0.68, b1 = 0, r2 = 1, g2 = 0.83, b2 = 0.25},
	["PRIEST"] = {r1 = 0.65, g1 = 0.65, b1 = 0.65, r2 = 0.99, g2 = 0.99, b2 = 0.99},
	["DEATHKNIGHT"] = {r1 = 0.79, g1 = 0.074, b1 = 0.15, r2 = 1, g2 = 0.18, b2 = 0.24},
	["SHAMAN"] = {r1 = 0, g1 = 0.56, b1 = 0.90, r2 = 0.35, g2 = 0.74, b2 = 1},
	["MAGE"] = {r1 = 0, g1 = 0.73, b1 = 0.83, r2 = 0.49, g2 = 0.87, b2 = 1},
	["WARLOCK"] = {r1 = 0.50, g1 = 0.30, b1 = 0.70, r2 = 0.7, g2= 0.53, b2 = 0.83},
	["MONK"] = {r1 = 0, g1 = 0.97, b1 = 0.45, r2 = 0.22, g2 = 0.91, b2 = 0.7},
	["DRUID"] = {r1 = 1, g1 = 0.24, b1 = 0, r2 = 1, g2 = 0.48, b2 = 0.04},
	["DEMONHUNTER"] = {r1 = 0.56, g1 = 0.33, b1 = 0.77, r2 = 0.74, g2 = 0.19, b2 = 1},
}

--adapted from libiteminfo to be player only
function ElvUI_EltreumUI:GetUnitItemLevel(unit)
	total, maxlevel = 0, 0

	for i = 1, 15 do
		if (i ~= 4) then
			linkloop = _G.GetInventoryItemLink(unit, i)
			if linkloop then
				level = select(4, _G.GetItemInfo(linkloop))
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

	mainlevel = 0
	mainlink = _G.GetInventoryItemLink(unit, 16)
	if mainlink then
		mainlevel = select(4, _G.GetItemInfo(mainlink))
	end
	mainhand = (tonumber(mainlevel))
	if mainhand == nil then
		mainhand = 0
	end

	offhandlink = _G.GetInventoryItemLink(unit, 17)
	offhandlevel = 0
	if offhandlink then
		offhandlevel = select(4, _G.GetItemInfo(offhandlink))
	end
	offhand = (tonumber(offhandlevel))
	if offhand == nil then
		offhand = 0
	end

	rangedlevel = 0
	rangedlink = _G.GetInventoryItemLink(unit, 18)
	if rangedlink then
		rangedlevel = select(4, _G.GetItemInfo(rangedlink))
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

--wrath to detect dual spec
--GetNumTalentGroups() --gets if they actually have dual spec in the first place
--GetActiveTalentGroup() --gets which of the dual is being used

--turns out classic has the functions to get number of points on talent trees
local function PlayerSpec()
	_, _, spent1 = _G.GetTalentTabInfo(1)
	_, _, spent2 = _G.GetTalentTabInfo(2)
	_, _, spent3 = _G.GetTalentTabInfo(3)

	for i=1, _G.GetNumTalentTabs() do
		name, _, spent = _G.GetTalentTabInfo(i)
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

if not E.Retail then
	local avgilvl = CreateFrame("FRAME")
	avgilvl:RegisterEvent("PLAYER_ENTERING_WORLD")
	avgilvl:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
	avgilvl:SetScript("OnEvent", function()
		_G.CharacterFrame.Text2:SetText((math.floor(ElvUI_EltreumUI:GetUnitItemLevel("player")*100))/100)
	end)

	if E.Wrath then
		local wrathdualspec = CreateFrame("FRAME")
		wrathdualspec:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
		wrathdualspec:RegisterEvent("PLAYER_TALENT_UPDATE")
		--wrathdualspec:RegisterEvent("CHARACTER_POINTS_CHANGED")
		wrathdualspec:SetScript("OnEvent", function()
			if _G.CharacterFrame.Text5 and _G.CharacterFrame.Text5:GetText() ~= nil then
				CharacterFrame.Text5:SetText(PlayerSpec())
			end
		end)
	end
end

--expanded armory
function ElvUI_EltreumUI:ExpandedCharacterStats()
	if not E.private.skins.blizzard.enable then return end

	if not InCombatLockdown() then
		_G["CharacterFrame"]:SetScale(E.db.ElvUI_EltreumUI.skins.characterpanelscale)
	end

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
			--_G.CharacterFrame:SetHeight(505)
			_G.CharacterFrame:SetHeight(455)
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
			--CharacterModelFrame:SetPosition(-1, 0, -0.10) -- zoom, x, y
			--CharacterModelFrame:SetPosition(-0.25, 0, -0.10) -- zoom, x, y
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

			--add bg texture
			CharacterFrameBackgroundTextureFader:SetAllPoints(_G.CharacterFrame)
			CharacterFrameBackgroundTextureFader:SetParent(_G.CharacterFrame)
			CharacterFrameBackgroundTextureFader:SetDrawLayer("ARTWORK",7)
			CharacterFrameBackgroundTextureFader:SetAlpha(E.db.ElvUI_EltreumUI.skins.armoryvignettealpha)
			if not E.db.ElvUI_EltreumUI.skins.armoryvignette then
				CharacterFrameBackgroundTextureFader:Hide()
			else
				CharacterFrameBackgroundTextureFader:Show()
			end
			if E.db.ElvUI_EltreumUI.skins.armorybgtype == "CLASS" then
				CharacterFrameBackgroundTexture:SetTexture(classBgs[E.myclass])
				CharacterFrameBackgroundTexture:SetTexCoord(0, 0.87, 0, 0.60)
			elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "RACE" then
				CharacterFrameBackgroundTexture:SetTexture(raceBgs[E.myrace])
				CharacterFrameBackgroundTexture:SetTexCoord(0, 0.716, 0, 1)
			elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "RAGNAROS" then
				CharacterFrameBackgroundTexture:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\Ragnaros")
				CharacterFrameBackgroundTexture:SetTexCoord(0, 0.716, 0, 1)
			elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "SPACECLOUD" then
				CharacterFrameBackgroundTexture:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\SpaceCloud")
				CharacterFrameBackgroundTexture:SetTexCoord(0, 0.716, 0, 1)
			elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "RAVNYR" then
				CharacterFrameBackgroundTexture:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\Ravnyr")
				CharacterFrameBackgroundTexture:SetTexCoord(0, 0.716, 0, 1)
			elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "BLACK" then
				CharacterFrameBackgroundTexture:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\black")
			elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "CUSTOM" then
				texturefile = [[Interface\AddOns\]]..E.private.ElvUI_EltreumUI.skins.armorybgtexture
				CharacterFrameBackgroundTexture:SetTexture(texturefile)
			end
			CharacterFrameBackgroundTexture:SetAlpha(E.db.ElvUI_EltreumUI.skins.expandarmorybgalpha)
			CharacterFrameBackgroundTexture:SetAllPoints(_G.CharacterFrame)
			CharacterFrameBackgroundTexture:SetParent(_G.CharacterFrame)
			CharacterFrameBackgroundTexture:SetDrawLayer("ARTWORK",6)

			_G.CharacterModelFrame.backdrop:Hide()
			_G.CharacterModelFrameBackgroundTopLeft:Hide()
			_G.CharacterModelFrameBackgroundOverlay:Hide()

			--color the avg item level
			CharacterStatsPane.ItemLevelFrame.leftGrad:SetGradientAlpha('Horizontal', classcolor.r, classcolor.g, classcolor.b, 0.4, classcolor.r, classcolor.g, classcolor.b, 0)
			CharacterStatsPane.ItemLevelFrame.rightGrad:SetGradientAlpha('Horizontal', classcolor.r, classcolor.g, classcolor.b, 0, classcolor.r, classcolor.g, classcolor.b, 0.4)

			if E.db.ElvUI_EltreumUI.skins.statcolors then
				--ItemLevelCategory
				--remove backgrounds and make font nice
				CharacterStatsPane.ItemLevelCategory.backdrop:Hide()
				CharacterStatsPane.ItemLevelCategory.backdrop:Hide()
				if not CharacterStatsPane.ItemLevelCategory.Title:GetText():match("|r") then
					if E.db.ElvUI_EltreumUI.skins.characterskingradients then
						CharacterStatsPane.ItemLevelCategory.Title:SetText(ElvUI_EltreumUI:GradientName(L["Item Level"], E.myclass))
					else
						CharacterStatsPane.ItemLevelCategory.Title:SetText(L["Item Level"])
						CharacterStatsPane.ItemLevelCategory.Title:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
					end
				end
				CharacterStatsPane.ItemLevelCategory.Title:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, E.db.general.fontStyle)

				--statusbars
				--CharacterStatsPane.ItemLevelCategory.Title:SetText("Gegenstandsstufe")

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
				if not CharacterStatsPane.AttributesCategory.Title:GetText():match("|r") then
					if E.db.ElvUI_EltreumUI.skins.characterskingradients then
						CharacterStatsPane.AttributesCategory.Title:SetText(ElvUI_EltreumUI:GradientName(STAT_CATEGORY_ATTRIBUTES, E.myclass))
					else
						CharacterStatsPane.AttributesCategory.Title:SetText(STAT_CATEGORY_ATTRIBUTES)
						CharacterStatsPane.AttributesCategory.Title:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
					end
				end
				CharacterStatsPane.AttributesCategory.Title:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, E.db.general.fontStyle)
				--statusbars
				linewidth2 = (( 194 - CharacterStatsPane.AttributesCategory.Title:GetStringWidth())/2)
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
				if not CharacterStatsPane.EnhancementsCategory.Title:GetText():match("|r") then
					if E.db.ElvUI_EltreumUI.skins.characterskingradients then
						CharacterStatsPane.EnhancementsCategory.Title:SetText(ElvUI_EltreumUI:GradientName(STAT_CATEGORY_ENHANCEMENTS, E.myclass))
					else
						CharacterStatsPane.EnhancementsCategory.Title:SetText(STAT_CATEGORY_ENHANCEMENTS)
						CharacterStatsPane.EnhancementsCategory.Title:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
					end
				end
				CharacterStatsPane.EnhancementsCategory.Title:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, E.db.general.fontStyle)
				--statusbars
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
						if E.db.ElvUI_EltreumUI.skins.characterskingradients then
							CharacterStatsPane.OffenseCategory.Title:SetText(ElvUI_EltreumUI:GradientName(CharacterStatsPane.OffenseCategory.Title:GetText(), E.myclass))
						else
							CharacterStatsPane.OffenseCategory.Title:SetText(CharacterStatsPane.OffenseCategory.Title:GetText())
							CharacterStatsPane.OffenseCategory.Title:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
						end
					end
					--statusbars
					linewidthsle1 = (( 168 - CharacterStatsPane.OffenseCategory.Title:GetStringWidth())/2)
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
						if E.db.ElvUI_EltreumUI.skins.characterskingradients then
							CharacterStatsPane.DefenceCategory.Title:SetText(ElvUI_EltreumUI:GradientName(CharacterStatsPane.DefenceCategory.Title:GetText(), E.myclass))
						else
							CharacterStatsPane.DefenceCategory.Title:SetText(CharacterStatsPane.DefenceCategory.Title:GetText())
							CharacterStatsPane.DefenceCategory.Title:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
						end
					end
					--statusbars
					linewidthsle2 = (( 168 - CharacterStatsPane.DefenceCategory.Title:GetStringWidth())/2)
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
				if _G.CharacterFrameInset.backdrop:IsVisible() then
					_G.CharacterFrameInset.backdrop:Hide()
				end
			end)

			hooksecurefunc("ReputationFrame_Update", function()
				if _G.CharacterFrameInset.backdrop:IsVisible() then
					_G.CharacterFrameInset.backdrop:Hide()
				end
			end)

			hooksecurefunc("CharacterFrame_Collapse", function()
				if PaperDollFrame:IsVisible() then
					_G.CharacterFrame:SetWidth(505)
					if E.db.ElvUI_EltreumUI.skins.armorybgtype == "RACE" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RAGNAROS" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "SPACECLOUD" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RAVNYR" then
						CharacterFrameBackgroundTexture:SetTexCoord(0, 0.716, 0, 1)
					elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "CLASS" then
						CharacterFrameBackgroundTexture:SetTexCoord(0, 0.87, 0, 0.60)
					end
					_G.CharacterFrameTitleText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize, E.db.general.fontStyle)
					_G.CharacterModelFrameBackgroundOverlay:Hide()
					if PaperDollFrame.SLE_Armory_BG then
						if PaperDollFrame.SLE_Armory_BG:IsVisible() then
							PaperDollFrame.SLE_Armory_BG:Hide()
						end
					end
				else
					if E.db.ElvUI_EltreumUI.skins.armorybgtype == "RACE" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RAGNAROS" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "SPACECLOUD" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RAVNYR" then
						CharacterFrameBackgroundTexture:SetTexCoord(0, 0.346, 0, 1)
					elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "CLASS" then
						CharacterFrameBackgroundTexture:SetTexCoord(0, 0.87, 0, 0.60)
					end
				end
			end)

			hooksecurefunc("CharacterFrame_Expand", function()
				if PaperDollFrame:IsVisible() then
					_G.CharacterFrame:SetWidth(700)
					if E.db.ElvUI_EltreumUI.skins.armorybgtype == "RACE" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RAGNAROS" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "SPACECLOUD" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RAVNYR" then
						CharacterFrameBackgroundTexture:SetTexCoord(0, 0.716, 0, 1)
					elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "CLASS" then
						CharacterFrameBackgroundTexture:SetTexCoord(0, 0.87, 0, 0.60)
					end
					_G.CharacterFrameTitleText:SetFont(E.LSM:Fetch('font', E.db.general.font), 18, E.db.general.fontStyle)
					_G.CharacterModelFrameBackgroundOverlay:Hide()
					if PaperDollFrame.SLE_Armory_BG then
						if PaperDollFrame.SLE_Armory_BG:IsVisible() then
							PaperDollFrame.SLE_Armory_BG:Hide()
						end
					end
				else
					if E.db.ElvUI_EltreumUI.skins.armorybgtype == "RACE" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RAGNAROS" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "SPACECLOUD" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RAVNYR" then
						CharacterFrameBackgroundTexture:SetTexCoord(0, 0.346, 0, 1)
					elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "CLASS" then
						CharacterFrameBackgroundTexture:SetTexCoord(0, 0.87, 0, 0.60)
					end
				end
			end)


			if (not IsAddOnLoaded('DejaCharacterStats')) then

				if IsAddOnLoaded("ElvUI_SLE") then
					if E.db["sle"]["armory"]["character"]["enable"] then
						return
					end
				end

				--banner other stats
				if E.db.ElvUI_EltreumUI.skins.statcolors then
					_G.CharacterFrame.EltruismExtraStatsFont:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, E.db.general.fontStyle)
					_G.CharacterFrame.EltruismExtraStatsFont:SetPoint("CENTER", CharacterStatsPane, "CENTER", 0, -80)
					--_G.CharacterFrame.EltruismExtraStatsFont:SetPoint("CENTER", CharacterStatsPane.EnhancementsCategory, "CENTER", 0, -80)
					_G.CharacterFrame.EltruismExtraStatsFont:SetParent(CharacterStatsPane)
					--if not _G.CharacterFrame.EltruismExtraStatsFont:GetText():match("|r") then
						if E.db.ElvUI_EltreumUI.skins.characterskingradients then
							_G.CharacterFrame.EltruismExtraStatsFont:SetText(ElvUI_EltreumUI:GradientName(L["Other"], E.myclass))
						else
							_G.CharacterFrame.EltruismExtraStatsFont:SetText(L["Other"])
							_G.CharacterFrame.EltruismExtraStatsFont:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
						end
					--end
					linewidth5 = (( 193 - _G.CharacterFrame.EltruismExtraStatsFont:GetStringWidth())/2)
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
					_G.CharacterFrame.EltruismExtraStatsFont:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize, E.db.general.fontStyle)
					_G.CharacterFrame.EltruismExtraStatsFont:SetPoint("CENTER", CharacterStatsPane, "CENTER", 0, -80)
					_G.CharacterFrame.EltruismExtraStatsFont:SetParent(CharacterStatsPane)
					_G.CharacterFrame.EltruismExtraStatsFont:SetTextColor(1, 1, 1)
					_G.CharacterFrame.EltruismExtraStatsFont:SetText(L["Other"])
				end

				--movement speed
				_G.CharacterFrame.EltruismSpeed:SetFont(E.LSM:Fetch('font', E.db.general.font), 10, E.db.general.fontStyle)
				_G.CharacterFrame.EltruismSpeed:SetTextColor(1, 1, 1)
				_G.CharacterFrame.EltruismSpeed:SetPoint("CENTER", CharacterStatsPane , 70, -163)
				_G.CharacterFrame.EltruismSpeed:SetParent(CharacterStatsPane)
				_G.CharacterFrame.EltruismSpeed:SetJustifyH("RIGHT")
				_G.CharacterFrame.EltruismSpeed:SetShadowColor(0, 0, 0, 1)
				_G.CharacterFrame.EltruismSpeed:SetShadowOffset(1, 0)

				_G.CharacterFrame.EltruismSpeedDesc:SetFont(E.LSM:Fetch('font', E.db.general.font), 10, E.db.general.fontStyle)
				_G.CharacterFrame.EltruismSpeedDesc:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
				_G.CharacterFrame.EltruismSpeedDesc:SetPoint("CENTER", CharacterStatsPane , -36, -163)
				_G.CharacterFrame.EltruismSpeedDesc:SetParent(CharacterStatsPane)
				_G.CharacterFrame.EltruismSpeedDesc:SetJustifyH("LEFT")
				_G.CharacterFrame.EltruismSpeedDesc:SetShadowColor(0, 0, 0, 1)
				_G.CharacterFrame.EltruismSpeedDesc:SetShadowOffset(1, 0)

				if E.db.ElvUI_EltreumUI.skins.statcolors then
					--if not _G.CharacterFrame.EltruismSpeedDesc:GetText():match("|r") then
					--end
					if E.db.ElvUI_EltreumUI.skins.characterskingradients then
						_G.CharacterFrame.EltruismSpeedDesc:SetText(ElvUI_EltreumUI:GradientName(STAT_MOVEMENT_SPEED, E.myclass))
					else
						_G.CharacterFrame.EltruismSpeedDesc:SetText(STAT_MOVEMENT_SPEED)
						_G.CharacterFrame.EltruismSpeedDesc:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
					end
				else
					_G.CharacterFrame.EltruismSpeedDesc:SetText(STAT_MOVEMENT_SPEED)
				end

				_G.CharacterFrame.EltruismSpeedDescTooltip:SetSize(190, 15)
				_G.CharacterFrame.EltruismSpeedDescTooltip:SetPoint("CENTER", CharacterStatsPane, "CENTER", 0, -163)
				_G.CharacterFrame.EltruismSpeedDescTooltip:SetParent(CharacterStatsPane)
				_G.CharacterFrame.EltruismSpeedDescTooltip:Show()
				_G.CharacterFrame.EltruismSpeedDescTooltip:SetScript("OnEnter", function()
					_G["GameTooltip"]:SetOwner(_G.CharacterFrame.EltruismSpeedDescTooltip, 'ANCHOR_RIGHT')
					_G["GameTooltip"]:AddLine(format(CR_SPEED_TOOLTIP, string.format('%.2f', (_G.GetUnitSpeed("player"))), ((_G.GetUnitSpeed("player")/7) *100)))
					_G["GameTooltip"]:Show()
				end)
				_G.CharacterFrame.EltruismSpeedDescTooltip:SetScript("OnLeave", function()
					_G["GameTooltip"]:Hide()
				end)

				--class resource
				_G.CharacterFrame.EltruismClassResource:SetFont(E.LSM:Fetch('font', E.db.general.font), 10, E.db.general.fontStyle)
				_G.CharacterFrame.EltruismClassResource:SetTextColor(1, 1, 1)
				_G.CharacterFrame.EltruismClassResource:SetPoint("CENTER", CharacterStatsPane , 72, -176)
				_G.CharacterFrame.EltruismClassResource:SetParent(CharacterStatsPane)
				_G.CharacterFrame.EltruismClassResource:SetJustifyH("RIGHT")
				_G.CharacterFrame.EltruismClassResource:SetShadowColor(0, 0, 0, 1)
				_G.CharacterFrame.EltruismClassResource:SetShadowOffset(1, 0)
				_G.CharacterFrame.EltruismClassResourceDesc:SetFont(E.LSM:Fetch('font', E.db.general.font), 10, E.db.general.fontStyle)
				_G.CharacterFrame.EltruismClassResourceDesc:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
				_G.CharacterFrame.EltruismClassResourceDesc:SetPoint("CENTER", CharacterStatsPane , -46, -176)
				_G.CharacterFrame.EltruismClassResourceDesc:SetParent(CharacterStatsPane)
				if E.myclass == 'HUNTER' then
					if E.db.ElvUI_EltreumUI.skins.statcolors then
					--if not _G.CharacterFrame.EltruismClassResourceDesc:GetText():match("|r") then
						if E.db.ElvUI_EltreumUI.skins.characterskingradients then
							_G.CharacterFrame.EltruismClassResourceDesc:SetText(ElvUI_EltreumUI:GradientName(STAT_FOCUS_REGEN, E.myclass))
						else
							_G.CharacterFrame.EltruismClassResourceDesc:SetText(STAT_FOCUS_REGEN)
							_G.CharacterFrame.EltruismClassResourceDesc:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
						end
					--end
					else
						_G.CharacterFrame.EltruismClassResourceDesc:SetText(STAT_FOCUS_REGEN)
					end
				elseif E.myclass == 'ROGUE' or E.myclass == 'DRUID' or E.myclass == 'MONK' then
					if E.db.ElvUI_EltreumUI.skins.statcolors then
						--if not _G.CharacterFrame.EltruismClassResourceDesc:GetText():match("|r") then
							if E.db.ElvUI_EltreumUI.skins.characterskingradients then
								_G.CharacterFrame.EltruismClassResourceDesc:SetText(ElvUI_EltreumUI:GradientName(STAT_ENERGY_REGEN, E.myclass))
							else
								_G.CharacterFrame.EltruismClassResourceDesc:SetText(STAT_ENERGY_REGEN)
								_G.CharacterFrame.EltruismClassResourceDesc:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
						--end
					else
						_G.CharacterFrame.EltruismClassResourceDesc:SetText(STAT_ENERGY_REGEN)
					end
				elseif E.myclass == 'DEATHKNIGHT' then
					if E.db.ElvUI_EltreumUI.skins.statcolors then
						--if not _G.CharacterFrame.EltruismClassResourceDesc:GetText():match("|r") then
							if E.db.ElvUI_EltreumUI.skins.characterskingradients then
								_G.CharacterFrame.EltruismClassResourceDesc:SetText(ElvUI_EltreumUI:GradientName(STAT_RUNE_REGEN, E.myclass))
							else
								_G.CharacterFrame.EltruismClassResourceDesc:SetText(STAT_RUNE_REGEN)
								_G.CharacterFrame.EltruismClassResourceDesc:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
						--end
					else
						_G.CharacterFrame.EltruismClassResourceDesc:SetText(STAT_RUNE_REGEN)
					end
				elseif E.myclass == 'MAGE' or E.myclass == 'SHAMAN' or E.myclass == 'WARLOCK' or E.myclass == 'PALADIN' or E.myclass == 'PRIEST' then
					if E.db.ElvUI_EltreumUI.skins.statcolors then
						--if not _G.CharacterFrame.EltruismClassResourceDesc:GetText():match("|r") then
							if E.db.ElvUI_EltreumUI.skins.characterskingradients then
								_G.CharacterFrame.EltruismClassResourceDesc:SetText(ElvUI_EltreumUI:GradientName(MANA_REGEN, E.myclass))
							else
								_G.CharacterFrame.EltruismClassResourceDesc:SetText(MANA_REGEN)
								_G.CharacterFrame.EltruismClassResourceDesc:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
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
					currentSpec = _G.GetSpecialization()
					if currentSpec then
						id, _ = _G.GetSpecializationInfo(currentSpec)
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
				_G.CharacterFrame.EltruismClassResource2:SetFont(E.LSM:Fetch('font', E.db.general.font), 10, E.db.general.fontStyle)
				_G.CharacterFrame.EltruismClassResource2:SetTextColor(1, 1, 1)
				_G.CharacterFrame.EltruismClassResource2:SetPoint("CENTER", CharacterStatsPane , 72, -189)
				_G.CharacterFrame.EltruismClassResource2:SetParent(CharacterStatsPane)
				_G.CharacterFrame.EltruismClassResource2:SetJustifyH("RIGHT")
				_G.CharacterFrame.EltruismClassResource2:SetShadowColor(0, 0, 0, 1)
				_G.CharacterFrame.EltruismClassResource2:SetShadowOffset(1, 0)

				_G.CharacterFrame.EltruismClassResourceDesc2:SetFont(E.LSM:Fetch('font', E.db.general.font), 10, E.db.general.fontStyle)
				_G.CharacterFrame.EltruismClassResourceDesc2:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
				_G.CharacterFrame.EltruismClassResourceDesc2:SetPoint("CENTER", CharacterStatsPane , -48, -189)
				_G.CharacterFrame.EltruismClassResourceDesc2:SetParent(CharacterStatsPane)
				if E.myclass == 'DRUID' or E.myclass == 'MONK' then
					if E.db.ElvUI_EltreumUI.skins.statcolors then
						--if not _G.CharacterFrame.EltruismClassResourceDesc:GetText():match("|r") then
							if E.db.ElvUI_EltreumUI.skins.characterskingradients then
								_G.CharacterFrame.EltruismClassResourceDesc2:SetText(ElvUI_EltreumUI:GradientName(MANA_REGEN, E.myclass))
							else
								_G.CharacterFrame.EltruismClassResourceDesc2:SetText(MANA_REGEN)
								_G.CharacterFrame.EltruismClassResourceDesc2:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
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
					speed = ((_G.GetUnitSpeed("player")/7) *100)
					_G.CharacterFrame.EltruismSpeed:SetText(math.ceil(speed).."%")
					_, combat = _G.GetManaRegen()
					combat = math.floor(combat * 5.0)
					combatText = _G.BreakUpLargeNumbers(combat)
					if E.myclass == 'HUNTER' or E.myclass == 'ROGUE' or E.myclass == 'DRUID' or E.myclass == 'MONK' then
						_G.CharacterFrame.EltruismClassResource:SetText(_G.BreakUpLargeNumbers(_G.GetPowerRegen()))
					elseif E.myclass == 'MAGE' or E.myclass == 'SHAMAN' or E.myclass == 'WARLOCK' or E.myclass == 'PALADIN' or E.myclass == 'PRIEST' then
						_G.CharacterFrame.EltruismClassResource:SetText(combatText)
					elseif E.myclass == 'DEATHKNIGHT' then
						_, regenRate = _G.GetRuneCooldown(1)
						regenRateText = (format(STAT_RUNE_REGEN_FORMAT, regenRate))
						_G.CharacterFrame.EltruismClassResource:SetText(regenRateText)
					end

					if E.myclass == 'DRUID' or E.myclass == 'MONK' then
						_G.CharacterFrame.EltruismClassResource2:SetText(combatText)
					end

					stats = {CharacterStatsPane:GetChildren()}
					number = (#stats)
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

				hooksecurefunc('PaperDollFrame_SetLabelAndText', function(statFrame, label)
					if ( statFrame.Label ) then
						if not statFrame.Label:GetText():match("|r") and E.db.ElvUI_EltreumUI.skins.statcolors and (not IsAddOnLoaded('DejaCharacterStats')) then
							statFrame.Label:SetFont(E.LSM:Fetch('font', E.db.general.font), 10, E.db.general.fontStyle)
							if E.db.ElvUI_EltreumUI.skins.characterskingradients then
								statFrame.Label:SetText(ElvUI_EltreumUI:GradientName(format(STAT_FORMAT, label), E.myclass))
							else
								statFrame.Label:SetText(format(STAT_FORMAT, label))
								statFrame.Label:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
						end
						if statFrame.Value then
							statFrame.Value:SetFont(E.LSM:Fetch('font', E.db.general.font), 10, E.db.general.fontStyle)
						end
					end

					if E.db.ElvUI_EltreumUI.skins.statcolors then
						if E.db.ElvUI_EltreumUI.skins.characterskingradients then
							_G.CharacterFrame.EltruismSpeedDesc:SetText(ElvUI_EltreumUI:GradientName(STAT_MOVEMENT_SPEED, E.myclass))
						else
							_G.CharacterFrame.EltruismSpeedDesc:SetText(STAT_MOVEMENT_SPEED)
							_G.CharacterFrame.EltruismSpeedDesc:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
						end
						if E.myclass == 'HUNTER' then
							if E.db.ElvUI_EltreumUI.skins.characterskingradients then
								_G.CharacterFrame.EltruismClassResourceDesc:SetText(ElvUI_EltreumUI:GradientName(STAT_FOCUS_REGEN, E.myclass))
							else
								_G.CharacterFrame.EltruismClassResourceDesc:SetText(STAT_FOCUS_REGEN)
								_G.CharacterFrame.EltruismClassResourceDesc:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
						elseif E.myclass == 'ROGUE' or E.myclass == 'DRUID' or E.myclass == 'MONK' then
							if E.db.ElvUI_EltreumUI.skins.characterskingradients then
								_G.CharacterFrame.EltruismClassResourceDesc:SetText(ElvUI_EltreumUI:GradientName(STAT_ENERGY_REGEN, E.myclass))
							else
								_G.CharacterFrame.EltruismClassResourceDesc:SetText(STAT_ENERGY_REGEN)
								_G.CharacterFrame.EltruismClassResourceDesc:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
						elseif E.myclass == 'DEATHKNIGHT' then
							if E.db.ElvUI_EltreumUI.skins.characterskingradients then
								_G.CharacterFrame.EltruismClassResourceDesc:SetText(ElvUI_EltreumUI:GradientName(STAT_RUNE_REGEN, E.myclass))
							else
								_G.CharacterFrame.EltruismClassResourceDesc:SetText(STAT_RUNE_REGEN)
								_G.CharacterFrame.EltruismClassResourceDesc:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
						elseif E.myclass == 'MAGE' or E.myclass == 'SHAMAN' or E.myclass == 'WARLOCK' or E.myclass == 'PALADIN' or E.myclass == 'PRIEST' then
							if E.db.ElvUI_EltreumUI.skins.characterskingradients then
								_G.CharacterFrame.EltruismClassResourceDesc:SetText(ElvUI_EltreumUI:GradientName(MANA_REGEN, E.myclass))
							else
								_G.CharacterFrame.EltruismClassResourceDesc:SetText(MANA_REGEN)
								_G.CharacterFrame.EltruismClassResourceDesc:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
						end
						if E.db.ElvUI_EltreumUI.skins.characterskingradients then
							_G.CharacterFrame.EltruismExtraStatsFont:SetText(ElvUI_EltreumUI:GradientName(L["Other"], E.myclass))
							CharacterStatsPane.ItemLevelCategory.Title:SetText(ElvUI_EltreumUI:GradientName(L["Item Level"], E.myclass))
							CharacterStatsPane.AttributesCategory.Title:SetText(ElvUI_EltreumUI:GradientName(STAT_CATEGORY_ATTRIBUTES, E.myclass))
							CharacterStatsPane.EnhancementsCategory.Title:SetText(ElvUI_EltreumUI:GradientName(STAT_CATEGORY_ENHANCEMENTS, E.myclass))
							if IsAddOnLoaded('ElvUI_SLE') then
								CharacterStatsPane.OffenseCategory.Title:SetText(ElvUI_EltreumUI:GradientName(CharacterStatsPane.OffenseCategory.Title:GetText(), E.myclass))
								CharacterStatsPane.DefenceCategory.Title:SetText(ElvUI_EltreumUI:GradientName(CharacterStatsPane.DefenceCategory.Title:GetText(), E.myclass))
							end
						else
							_G.CharacterFrame.EltruismExtraStatsFont:SetText(L["Other"])
							_G.CharacterFrame.EltruismExtraStatsFont:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							CharacterStatsPane.ItemLevelCategory.Title:SetText(L["Item Level"])
							CharacterStatsPane.ItemLevelCategory.Title:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							CharacterStatsPane.AttributesCategory.Title:SetText(STAT_CATEGORY_ATTRIBUTES)
							CharacterStatsPane.AttributesCategory.Title:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							CharacterStatsPane.EnhancementsCategory.Title:SetText(STAT_CATEGORY_ENHANCEMENTS)
							CharacterStatsPane.EnhancementsCategory.Title:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
						end
					end
				end)

				_G.CharacterFrame.EltruismExtraStatsBlock:SetPoint("CENTER", _G.CharacterFrame.EltruismExtraStatsFont, "CENTER", 0, 0)
			end
		end
	elseif E.Wrath or E.TBC or E.Classic then

		--color stats with a class gradient
		if E.db.ElvUI_EltreumUI.skins.statcolors then
			local function SetStatGradient()
				if E.db.ElvUI_EltreumUI.skins.characterskingradients then
					CharacterFrame.Text:SetText(ElvUI_EltreumUI:GradientName(L["Item Level"], E.myclass)) ---ilvl
					CharacterFrame.Text3:SetText(ElvUI_EltreumUI:GradientName(L["Attributes"], E.myclass)) ---attributes
					CharacterFrame.Text4:SetText(ElvUI_EltreumUI:GradientName(L["Specialization"], E.myclass)) ---specialization
				else
					CharacterFrame.Text:SetText(L["Item Level"]) ---ilvl
					CharacterFrame.Text:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
					CharacterFrame.Text3:SetText(L["Attributes"]) ---attributes
					CharacterFrame.Text3:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
					CharacterFrame.Text4:SetText(L["Specialization"]) ---specialization
					CharacterFrame.Text4:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
				end
				if E.Wrath or E.TBC then
					if not _G.PlayerStatFrameLeft1Label:GetText():match("|r") then
						_G.PlayerStatFrameLeft1Label:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
						if E.db.ElvUI_EltreumUI.skins.characterskingradients then
							_G.PlayerStatFrameLeft1Label:SetText(ElvUI_EltreumUI:GradientName(_G.PlayerStatFrameLeft1Label:GetText(), E.myclass))
						else
							_G.PlayerStatFrameLeft1Label:SetText(_G.PlayerStatFrameLeft1Label:GetText())
							_G.PlayerStatFrameLeft1Label:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
						end
					end
					if not _G.PlayerStatFrameLeft2Label:GetText():match("|r") then
						_G.PlayerStatFrameLeft2Label:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
						if E.db.ElvUI_EltreumUI.skins.characterskingradients then
							_G.PlayerStatFrameLeft2Label:SetText(ElvUI_EltreumUI:GradientName(_G.PlayerStatFrameLeft2Label:GetText(), E.myclass))
						else
							_G.PlayerStatFrameLeft2Label:SetText(_G.PlayerStatFrameLeft2Label:GetText())
							_G.PlayerStatFrameLeft2Label:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
						end
					end
					if not _G.PlayerStatFrameLeft3Label:GetText():match("|r") then
						_G.PlayerStatFrameLeft3Label:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
						if E.db.ElvUI_EltreumUI.skins.characterskingradients then
							_G.PlayerStatFrameLeft3Label:SetText(ElvUI_EltreumUI:GradientName(_G.PlayerStatFrameLeft3Label:GetText(), E.myclass))
						else
							_G.PlayerStatFrameLeft3Label:SetText(_G.PlayerStatFrameLeft3Label:GetText())
							_G.PlayerStatFrameLeft3Label:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
						end
					end
					if not _G.PlayerStatFrameLeft4Label:GetText():match("|r") then
						_G.PlayerStatFrameLeft4Label:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
						if E.db.ElvUI_EltreumUI.skins.characterskingradients then
							_G.PlayerStatFrameLeft4Label:SetText(ElvUI_EltreumUI:GradientName(_G.PlayerStatFrameLeft4Label:GetText(), E.myclass))
						else
							_G.PlayerStatFrameLeft4Label:SetText(_G.PlayerStatFrameLeft4Label:GetText())
							_G.PlayerStatFrameLeft4Label:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
						end
					end
					if not _G.PlayerStatFrameLeft5Label:GetText():match("|r") then
						_G.PlayerStatFrameLeft5Label:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
						if E.db.ElvUI_EltreumUI.skins.characterskingradients then
							_G.PlayerStatFrameLeft5Label:SetText(ElvUI_EltreumUI:GradientName(_G.PlayerStatFrameLeft5Label:GetText(), E.myclass))
						else
							_G.PlayerStatFrameLeft5Label:SetText(_G.PlayerStatFrameLeft5Label:GetText())
							_G.PlayerStatFrameLeft5Label:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
						end
					end
					if not _G.PlayerStatFrameLeft6Label:GetText():match("|r") then
						_G.PlayerStatFrameLeft6Label:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
						if E.db.ElvUI_EltreumUI.skins.characterskingradients then
							_G.PlayerStatFrameLeft6Label:SetText(ElvUI_EltreumUI:GradientName(_G.PlayerStatFrameLeft6Label:GetText(), E.myclass))
						else
							_G.PlayerStatFrameLeft6Label:SetText(_G.PlayerStatFrameLeft6Label:GetText())
							_G.PlayerStatFrameLeft6Label:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
						end
					end
					if not _G.PlayerStatFrameRight1Label:GetText():match("|r") then
						_G.PlayerStatFrameRight1Label:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
						if E.db.ElvUI_EltreumUI.skins.characterskingradients then
							_G.PlayerStatFrameRight1Label:SetText(ElvUI_EltreumUI:GradientName(_G.PlayerStatFrameRight1Label:GetText(), E.myclass))
						else
							_G.PlayerStatFrameRight1Label:SetText(_G.PlayerStatFrameRight1Label:GetText())
							_G.PlayerStatFrameRight1Label:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
						end
					end
					if not _G.PlayerStatFrameRight2Label:GetText():match("|r") then
						_G.PlayerStatFrameRight2Label:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
						if E.db.ElvUI_EltreumUI.skins.characterskingradients then
							_G.PlayerStatFrameRight2Label:SetText(ElvUI_EltreumUI:GradientName(_G.PlayerStatFrameRight2Label:GetText(), E.myclass))
						else
							_G.PlayerStatFrameRight2Label:SetText(_G.PlayerStatFrameRight2Label:GetText())
							_G.PlayerStatFrameRight2Label:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
						end
					end
					if not _G.PlayerStatFrameRight3Label:GetText():match("|r") then
						_G.PlayerStatFrameRight3Label:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
						if E.db.ElvUI_EltreumUI.skins.characterskingradients then
							_G.PlayerStatFrameRight3Label:SetText(ElvUI_EltreumUI:GradientName(_G.PlayerStatFrameRight3Label:GetText(), E.myclass))
						else
							_G.PlayerStatFrameRight3Label:SetText(_G.PlayerStatFrameRight3Label:GetText())
							_G.PlayerStatFrameRight3Label:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
						end
					end
					if not _G.PlayerStatFrameRight4Label:GetText():match("|r") then
						_G.PlayerStatFrameRight4Label:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
						if E.db.ElvUI_EltreumUI.skins.characterskingradients then
							_G.PlayerStatFrameRight4Label:SetText(ElvUI_EltreumUI:GradientName(_G.PlayerStatFrameRight4Label:GetText(), E.myclass))
						else
							_G.PlayerStatFrameRight4Label:SetText(_G.PlayerStatFrameRight4Label:GetText())
							_G.PlayerStatFrameRight4Label:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
						end
					end
					if not _G.PlayerStatFrameRight5Label:GetText():match("|r") then
						_G.PlayerStatFrameRight5Label:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
						if E.db.ElvUI_EltreumUI.skins.characterskingradients then
							_G.PlayerStatFrameRight5Label:SetText(ElvUI_EltreumUI:GradientName(_G.PlayerStatFrameRight5Label:GetText(), E.myclass))
						else
							_G.PlayerStatFrameRight5Label:SetText(_G.PlayerStatFrameRight5Label:GetText())
							_G.PlayerStatFrameRight5Label:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
						end
					end
					if _G.PlayerStatFrameRight6Label:GetText() ~= nil and not _G.PlayerStatFrameRight6Label:GetText():match("|r") then
						_G.PlayerStatFrameRight6Label:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
						if E.db.ElvUI_EltreumUI.skins.characterskingradients then
							_G.PlayerStatFrameRight6Label:SetText(ElvUI_EltreumUI:GradientName(_G.PlayerStatFrameRight6Label:GetText(), E.myclass))
						else
							_G.PlayerStatFrameRight6Label:SetText(_G.PlayerStatFrameRight6Label:GetText())
							_G.PlayerStatFrameRight6Label:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
						end
					end
				elseif E.Classic then
					if not _G.CharacterStatFrame1Label:GetText():match("|r") then
							_G.CharacterStatFrame1Label:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
							if E.db.ElvUI_EltreumUI.skins.characterskingradients then
								_G.CharacterStatFrame1Label:SetText(ElvUI_EltreumUI:GradientName(_G.CharacterStatFrame1Label:GetText(), E.myclass))
							else
								_G.CharacterStatFrame1Label:SetText(_G.CharacterStatFrame1Label:GetText())
								_G.CharacterStatFrame1Label:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
						end
						if not _G.CharacterStatFrame2Label:GetText():match("|r") then
							_G.CharacterStatFrame2Label:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
							if E.db.ElvUI_EltreumUI.skins.characterskingradients then
								_G.CharacterStatFrame2Label:SetText(ElvUI_EltreumUI:GradientName(_G.CharacterStatFrame2Label:GetText(), E.myclass))
							else
								_G.CharacterStatFrame2Label:SetText(_G.CharacterStatFrame2Label:GetText())
								_G.CharacterStatFrame2Label:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
						end
						if not _G.CharacterStatFrame3Label:GetText():match("|r") then
							_G.CharacterStatFrame3Label:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
							if E.db.ElvUI_EltreumUI.skins.characterskingradients then
								_G.CharacterStatFrame3Label:SetText(ElvUI_EltreumUI:GradientName(_G.CharacterStatFrame3Label:GetText(), E.myclass))
							else
								_G.CharacterStatFrame3Label:SetText(_G.CharacterStatFrame3Label:GetText())
								_G.CharacterStatFrame3Label:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
						end
						if not _G.CharacterStatFrame4Label:GetText():match("|r") then
							_G.CharacterStatFrame4Label:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
							if E.db.ElvUI_EltreumUI.skins.characterskingradients then
								_G.CharacterStatFrame4Label:SetText(ElvUI_EltreumUI:GradientName(_G.CharacterStatFrame4Label:GetText(), E.myclass))
							else
								_G.CharacterStatFrame4Label:SetText(_G.CharacterStatFrame4Label:GetText())
								_G.CharacterStatFrame4Label:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
						end
						if not _G.CharacterStatFrame5Label:GetText():match("|r") then
							_G.CharacterStatFrame5Label:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
							if E.db.ElvUI_EltreumUI.skins.characterskingradients then
								_G.CharacterStatFrame5Label:SetText(ElvUI_EltreumUI:GradientName(_G.CharacterStatFrame5Label:GetText(), E.myclass))
							else
								_G.CharacterStatFrame5Label:SetText(_G.CharacterStatFrame5Label:GetText())
								_G.CharacterStatFrame5Label:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
						end
						if not _G.CharacterArmorFrameLabel:GetText():match("|r") then
							_G.CharacterArmorFrameLabel:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
							if E.db.ElvUI_EltreumUI.skins.characterskingradients then
								_G.CharacterArmorFrameLabel:SetText(ElvUI_EltreumUI:GradientName(_G.CharacterArmorFrameLabel:GetText(), E.myclass))
							else
								_G.CharacterArmorFrameLabel:SetText(_G.CharacterArmorFrameLabel:GetText())
								_G.CharacterArmorFrameLabel:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
						end
						if not _G.CharacterAttackFrameLabel:GetText():match("|r") then
							_G.CharacterAttackFrameLabel:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
							if E.db.ElvUI_EltreumUI.skins.characterskingradients then
								_G.CharacterAttackFrameLabel:SetText(ElvUI_EltreumUI:GradientName(_G.CharacterAttackFrameLabel:GetText(), E.myclass))
							else
								_G.CharacterAttackFrameLabel:SetText(_G.CharacterAttackFrameLabel:GetText())
								_G.CharacterAttackFrameLabel:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
						end
						if not _G.CharacterAttackPowerFrameLabel:GetText():match("|r") then
							_G.CharacterAttackPowerFrameLabel:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
							if E.db.ElvUI_EltreumUI.skins.characterskingradients then
								_G.CharacterAttackPowerFrameLabel:SetText(ElvUI_EltreumUI:GradientName(_G.CharacterAttackPowerFrameLabel:GetText(), E.myclass))
							else
								_G.CharacterAttackPowerFrameLabel:SetText(_G.CharacterAttackPowerFrameLabel:GetText())
								_G.CharacterAttackPowerFrameLabel:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
						end
						if not _G.CharacterDamageFrameLabel:GetText():match("|r") then
							_G.CharacterDamageFrameLabel:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
							if E.db.ElvUI_EltreumUI.skins.characterskingradients then
								_G.CharacterDamageFrameLabel:SetText(ElvUI_EltreumUI:GradientName(_G.CharacterDamageFrameLabel:GetText(), E.myclass))
							else
								_G.CharacterDamageFrameLabel:SetText(_G.CharacterDamageFrameLabel:GetText())
								_G.CharacterDamageFrameLabel:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
						end
						if not _G.CharacterRangedAttackFrameLabel:GetText():match("|r") then
							_G.CharacterRangedAttackFrameLabel:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
							if E.db.ElvUI_EltreumUI.skins.characterskingradients then
								_G.CharacterRangedAttackFrameLabel:SetText(ElvUI_EltreumUI:GradientName(_G.CharacterRangedAttackFrameLabel:GetText(), E.myclass))
							else
								_G.CharacterRangedAttackFrameLabel:SetText(_G.CharacterRangedAttackFrameLabel:GetText())
								_G.CharacterRangedAttackFrameLabel:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
						end
						if not _G.CharacterRangedAttackPowerFrameLabel:GetText():match("|r") then
							_G.CharacterRangedAttackPowerFrameLabel:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
							if E.db.ElvUI_EltreumUI.skins.characterskingradients then
								_G.CharacterRangedAttackPowerFrameLabel:SetText(ElvUI_EltreumUI:GradientName(_G.CharacterRangedAttackPowerFrameLabel:GetText(), E.myclass))
							else
								_G.CharacterRangedAttackPowerFrameLabel:SetText(_G.CharacterRangedAttackPowerFrameLabel:GetText())
								_G.CharacterRangedAttackPowerFrameLabel:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
						end
						if not _G.CharacterRangedDamageFrameLabel:GetText():match("|r") then
								_G.CharacterRangedDamageFrameLabel:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
							if E.db.ElvUI_EltreumUI.skins.characterskingradients then
								_G.CharacterRangedDamageFrameLabel:SetText(ElvUI_EltreumUI:GradientName(_G.CharacterRangedDamageFrameLabel:GetText(), E.myclass))
							else
								_G.CharacterRangedDamageFrameLabel:SetText(_G.CharacterRangedDamageFrameLabel:GetText())
								_G.CharacterRangedDamageFrameLabel:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
						end
					end
			end
			--set hooks
			if E.Wrath or E.TBC then
				hooksecurefunc('PlayerStatFrameLeftDropDown_OnClick', SetStatGradient)
				hooksecurefunc('PlayerStatFrameRightDropDown_OnClick', SetStatGradient)
			end
			hooksecurefunc("PaperDollFrame_UpdateStats", SetStatGradient)
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

		--fix buttons
		if _G.PetPaperDollCloseButton then
			_G.PetPaperDollCloseButton:Hide()
		end
		if _G.SkillFrameCancelButton then
			_G.SkillFrameCancelButton:Hide()
		end

		--add background from artifact weapon
		if E.db.ElvUI_EltreumUI.skins.expandarmorybg then

			--add bg texture
			CharacterFrameBackgroundTextureFader:SetAllPoints(_G.CharacterFrame.backdrop)
			CharacterFrameBackgroundTextureFader:SetParent(_G.CharacterFrame)
			CharacterFrameBackgroundTextureFader:SetDrawLayer("BACKGROUND",7)
			CharacterFrameBackgroundTextureFader:SetAlpha(E.db.ElvUI_EltreumUI.skins.armoryvignettealpha)
			if not E.db.ElvUI_EltreumUI.skins.armoryvignette then
				CharacterFrameBackgroundTextureFader:Hide()
			else
				CharacterFrameBackgroundTextureFader:Show()
			end
			if E.db.ElvUI_EltreumUI.skins.armorybgtype == "CLASS" then
				CharacterFrameBackgroundTexture:SetTexture(classBgs[E.myclass])
				CharacterFrameBackgroundTexture:SetTexCoord(0, 0.87, 0, 0.60)
			elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "RACE" then
				CharacterFrameBackgroundTexture:SetTexture(raceBgs[E.myrace])
				CharacterFrameBackgroundTexture:SetTexCoord(0, 0.716, 0, 1)
			elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "RAGNAROS" then
				CharacterFrameBackgroundTexture:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\Ragnaros")
				CharacterFrameBackgroundTexture:SetTexCoord(0, 0.716, 0, 1)
			elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "SPACECLOUD" then
				CharacterFrameBackgroundTexture:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\SpaceCloud")
				CharacterFrameBackgroundTexture:SetTexCoord(0, 0.716, 0, 1)
			elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "RAVNYR" then
				CharacterFrameBackgroundTexture:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\Ravnyr")
				CharacterFrameBackgroundTexture:SetTexCoord(0, 0.716, 0, 1)
			elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "BLACK" then
				CharacterFrameBackgroundTexture:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\black")
			elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "CUSTOM" then
				texturefile = [[Interface\AddOns\]]..E.private.ElvUI_EltreumUI.skins.armorybgtexture
				CharacterFrameBackgroundTexture:SetTexture(texturefile)
			end
			CharacterFrameBackgroundTexture:SetAlpha(E.db.ElvUI_EltreumUI.skins.expandarmorybgalpha)
			CharacterFrameBackgroundTexture:SetAllPoints(_G.CharacterFrame.backdrop)
			CharacterFrameBackgroundTexture:SetDrawLayer("BACKGROUND",6)
		end

		-- expand classic armory
		if E.db.ElvUI_EltreumUI.skins.classicarmory then

			--set ilvl on char panel
			hooksecurefunc("ToggleCharacter", function()
				_G.CharacterFrame.Text2:SetText((math.floor(ElvUI_EltreumUI:GetUnitItemLevel("player")*100))/100)
			end)

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
				_G.PVPFrameToggleButton:SetPoint('CENTER', _G.PVPHonor, 'CENTER', 90, 47)
				_G.PVPFrameToggleButton:SetParent(_G.PVPFrameHonor)
			elseif E.Classic then
				CharacterTitleText:ClearAllPoints()
				CharacterTitleText:SetPoint('TOP', CharacterModelFrame, 0, 40)
				CharacterTitleText:SetParent(CharacterModelFrame)
			end

			if _G.ReputationListScrollFrameScrollBar then
				--_G.ReputationListScrollFrameScrollBar:ClearAllPoints()
				local point, relativeTo, relativePoint, xOfs, yOfs = _G.ReputationListScrollFrameScrollBar:GetPoint()
				_G.ReputationListScrollFrameScrollBarScrollDownButton:SetPoint(point, relativeTo, relativePoint, xOfs-1, -330)
				--_G.ReputationListScrollFrameScrollBar:SetPoint("RIGHT", _G.ReputationFrame, "RIGHT", -30, 20)
				--_G.ReputationListScrollFrameScrollBar:SetPoint("BOTTOMRIGHT", -27, 4)
				--_G.ReputationListScrollFrameScrollBar:SetParent(_G.ReputationFrame)
			end

			--change the size based on if paperdoll is hidden
			CharacterFrame:SetSize(700, 505)
			--CharacterModelFrame:SetPosition(0, 0, 0) --zoom,x,y

			--fix frame size depending on tab
			local function ResizeCharacterFrame()
				if not InCombatLockdown() then
					if PaperDollFrame:IsVisible() then
						CharacterFrame:SetSize(700, 505)
						CharacterNameText:ClearAllPoints()
						CharacterNameText:SetPoint('TOP', CharacterModelFrame, 0, 80)
						if E.db.ElvUI_EltreumUI.skins.armorybgtype == "RACE" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RAGNAROS" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "SPACECLOUD" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RAVNYR" then
							CharacterFrameBackgroundTexture:SetTexCoord(0, 0.716, 0, 1)
						elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "CLASS" then
							CharacterFrameBackgroundTexture:SetTexCoord(0, 0.87, 0, 0.60)
						end
					else
						CharacterNameText:ClearAllPoints()
						CharacterNameText:SetPoint('TOP', CharacterFrame, 0, -25)
						CharacterFrame:SetSize(400, 505)
						if E.db.ElvUI_EltreumUI.skins.armorybgtype == "RACE" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RAGNAROS" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "SPACECLOUD" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RAVNYR" then
							CharacterFrameBackgroundTexture:SetTexCoord(0, 0.39, 0, 1)
						elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "CLASS" then
							CharacterFrameBackgroundTexture:SetTexCoord(0, 0.87, 0, 0.60)
						end
					end
				end
			end
			_G.PaperDollItemsFrame:SetScript("OnShow", ResizeCharacterFrame)
			_G.CharacterFrame:HookScript("OnShow", ResizeCharacterFrame)
			hooksecurefunc("CharacterFrameTab_OnClick", ResizeCharacterFrame)


			--adjust the items
			_G.CharacterHeadSlot:ClearAllPoints()
			_G.CharacterHeadSlot:SetPoint('TOPLEFT', _G.CharacterFrame, 'TOPLEFT', 20, -47)

			_G.CharacterHandsSlot:ClearAllPoints()
			_G.CharacterHandsSlot:SetPoint('CENTER', _G.CharacterHeadSlot, 'CENTER', 370, 0)

			_G.CharacterMainHandSlot:ClearAllPoints()
			_G.CharacterMainHandSlot:SetPoint('CENTER', _G.CharacterModelFrame, 'CENTER', -55, -145)

			if _G.PlayerTitleDropDown then
				_G.PlayerTitleDropDown:SetAlpha(0)
				_G.PlayerTitleDropDown:SetScript('OnEnter', function() _G.PlayerTitleDropDown:SetAlpha(1) end)
				_G.PlayerTitleDropDown:SetScript('OnLeave', function() _G.PlayerTitleDropDown:SetAlpha(0) end)
			end

			CharacterNameText:ClearAllPoints()
			CharacterNameText:SetPoint('TOP', CharacterModelFrame, 0, 80)
			--CharacterNameText:SetParent(CharacterModelFrame)
			CharacterNameText:SetFont(E.LSM:Fetch('font', E.db.general.font), 18, E.db.general.fontStyle)
			CharacterNameText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
			CharacterNameText:SetShadowColor(0, 0, 0, 0.8)
			CharacterNameText:SetShadowOffset(2, -1)

			CharacterLevelText:ClearAllPoints()
			--CharacterLevelText:SetPoint('TOP', CharacterModelFrame, 0, 60)
			CharacterLevelText:SetPoint('TOP', CharacterNameText, 'BOTTOM', 0, -15)
			CharacterLevelText:SetParent(CharacterModelFrame)

			--start of the stats
			CharacterFrame.Text4:SetSize(418, 72)
			CharacterFrame.Text4:SetPoint("TOPRIGHT", CharacterFrame, "TOPRIGHT", 50, 0) ---anchored
			CharacterFrame.Text4:SetParent(_G["PaperDollItemsFrame"])
			CharacterFrame.Text4:SetTextColor(1, 1, 1)
			CharacterFrame.Text4:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, E.db.general.fontStyle)
			if E.db.ElvUI_EltreumUI.skins.characterskingradients then
				CharacterFrame.Text4:SetText(ElvUI_EltreumUI:GradientName(L["Specialization"], E.myclass)) ---specialization
			else
				CharacterFrame.Text4:SetText(L["Specialization"])
				CharacterFrame.Text4:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
			end
			CharacterFrame.StatusLine4:SetSize(170, 3)
			CharacterFrame.StatusLine4:SetPoint("CENTER", CharacterFrame.Text4, "CENTER", 0, -15)
			CharacterFrame.StatusLine4:SetParent(_G["PaperDollItemsFrame"])
			CharacterFrame.StatusLine4:SetStatusBarTexture(E.Media.Textures.Highlight)
			CharacterFrame.StatusLine4:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)

			CharacterFrame.Text5:SetSize(418, 72)
			CharacterFrame.Text5:SetPoint("BOTTOM", CharacterFrame.StatusLine4, "BOTTOM", 0, -50)
			CharacterFrame.Text5:SetParent(_G["PaperDollItemsFrame"])
			CharacterFrame.Text5:SetTextColor(classcolor.r, classcolor.g, classcolor.b, 1)
			CharacterFrame.Text5:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, E.db.general.fontStyle)
			CharacterFrame.Text5:SetText(PlayerSpec())

			CharacterFrame.Text:SetSize(418, 72)
			CharacterFrame.Text:SetPoint("BOTTOM", CharacterFrame.Text5, "BOTTOM", 0, -25)
			CharacterFrame.Text:SetParent(_G["PaperDollItemsFrame"])
			CharacterFrame.Text:SetTextColor(1, 1, 1)
			CharacterFrame.Text:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, E.db.general.fontStyle)
			if E.db.ElvUI_EltreumUI.skins.characterskingradients then
				CharacterFrame.Text:SetText(ElvUI_EltreumUI:GradientName(L["Item Level"], E.myclass)) ---ilvl
			else
				CharacterFrame.Text:SetText(L["Item Level"])
				CharacterFrame.Text:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
			end
			CharacterFrame.StatusLine:SetSize(170, 3)
			CharacterFrame.StatusLine:SetPoint("CENTER", CharacterFrame.Text, "CENTER", 0, -15)
			CharacterFrame.StatusLine:SetParent(_G["PaperDollItemsFrame"])
			CharacterFrame.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
			CharacterFrame.StatusLine:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)

			CharacterFrame.Text2:SetSize(418, 72)
			CharacterFrame.Text2:SetPoint("BOTTOM", CharacterFrame.Text, "BOTTOM", 0, -35) --ilvl number
			CharacterFrame.Text2:SetParent(_G["PaperDollItemsFrame"])
			CharacterFrame.Text2:SetTextColor(classcolor.r, classcolor.g, classcolor.b, 1)
			CharacterFrame.Text2:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, E.db.general.fontStyle)
			CharacterFrame.StatusLine2:SetFrameStrata("MEDIUM")
			CharacterFrame.StatusLine2:SetFrameLevel(1)
			CharacterFrame.StatusLine2:SetSize(170, 25)
			CharacterFrame.StatusLine2:SetPoint("CENTER", CharacterFrame.Text2, "CENTER", 0, 0)
			CharacterFrame.StatusLine2:SetParent(_G["PaperDollItemsFrame"])
			CharacterFrame.StatusLine2:SetStatusBarTexture(E.Media.Textures.Highlight)
			CharacterFrame.StatusLine2:SetStatusBarColor(1, 1, 1, 0.5)

			CharacterFrame.Text3:SetSize(418, 72)
			CharacterFrame.Text3:SetPoint("TOP", CharacterFrame.Text2, "TOP", 0, -27)
			CharacterFrame.Text3:SetParent(_G["PaperDollItemsFrame"])
			CharacterFrame.Text3:SetTextColor(1, 1, 1)
			CharacterFrame.Text3:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, E.db.general.fontStyle)
			if E.db.ElvUI_EltreumUI.skins.characterskingradients then
				CharacterFrame.Text3:SetText(ElvUI_EltreumUI:GradientName(L["Attributes"], E.myclass)) ---attributes
			else
				CharacterFrame.Text3:SetText(L["Attributes"])
				CharacterFrame.Text3:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
			end
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
				_G.MagicResFrame1:SetPoint("TOPLEFT", _G.PlayerStatFrameLeftDropDown, "TOPLEFT", 13, 27)
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
				_G.PlayerStatFrameLeftDropDown:SetPoint("CENTER", CharacterFrame.StatusLine3, "CENTER", 0, -55)
				_G.PlayerStatFrameLeftDropDown:SetParent(_G["PaperDollItemsFrame"])

				_G.PlayerStatFrameLeft1:ClearAllPoints()
				_G.PlayerStatFrameLeft1:SetPoint("BOTTOM", _G.PlayerStatFrameLeftDropDown, "BOTTOM", -22, -5)
				_G.PlayerStatFrameLeft1:SetParent(_G["PaperDollItemsFrame"])

				_G.PlayerStatFrameLeft2:ClearAllPoints()
				_G.PlayerStatFrameLeft2:SetPoint("BOTTOM", _G.PlayerStatFrameLeft1, "BOTTOM", 0, -13)
				_G.PlayerStatFrameLeft2:SetParent(_G["PaperDollItemsFrame"])
				_G.PlayerStatFrameLeft2.StatusLine:SetSize(170, 12)
				_G.PlayerStatFrameLeft2.StatusLine:SetPoint("CENTER", _G.PlayerStatFrameLeft2, "CENTER", 25, 0)
				_G.PlayerStatFrameLeft2.StatusLine:SetParent(_G["PaperDollItemsFrame"])
				_G.PlayerStatFrameLeft2.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				_G.PlayerStatFrameLeft2.StatusLine:SetStatusBarColor(1, 1, 1, 0.3)
				_G.PlayerStatFrameLeft2.StatusLine:SetFrameLevel(2)

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
				_G.PlayerStatFrameLeft4.StatusLine:SetFrameLevel(2)

				_G.PlayerStatFrameLeft5:ClearAllPoints()
				_G.PlayerStatFrameLeft5:SetPoint("BOTTOM", _G.PlayerStatFrameLeft4, "BOTTOM", 0, -13)
				_G.PlayerStatFrameLeft5:SetParent(_G["PaperDollItemsFrame"])

				_G.PlayerStatFrameLeft6:ClearAllPoints()
				_G.PlayerStatFrameLeft6:SetPoint("BOTTOM", _G.PlayerStatFrameLeft5, "BOTTOM", 0, -13)
				_G.PlayerStatFrameLeft6:SetParent(_G["PaperDollItemsFrame"])
				_G.PlayerStatFrameLeft6.StatusLine:SetSize(170, 12)
				_G.PlayerStatFrameLeft6.StatusLine:SetPoint("CENTER", _G.PlayerStatFrameLeft6, "CENTER", 25, 0)
				_G.PlayerStatFrameLeft6.StatusLine:SetParent(_G["PlayerStatFrameLeft6"])
				_G.PlayerStatFrameLeft6.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				_G.PlayerStatFrameLeft6.StatusLine:SetStatusBarColor(1, 1, 1, 0.3)
				_G.PlayerStatFrameLeft6.StatusLine:SetFrameLevel(2)

				_G.PlayerStatFrameLeft1Stat:ClearAllPoints()
				_G.PlayerStatFrameLeft1Stat:SetPoint("CENTER", _G.PlayerStatFrameLeft1, "CENTER", 95, 0)
				_G.PlayerStatFrameLeft1StatText:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
				_G.PlayerStatFrameLeft1Stat:SetParent(_G["PaperDollItemsFrame"])
				_G.PlayerStatFrameLeft2Stat:ClearAllPoints()
				_G.PlayerStatFrameLeft2Stat:SetPoint("BOTTOM", _G.PlayerStatFrameLeft1Stat, "BOTTOM", 0, -13)
				_G.PlayerStatFrameLeft2StatText:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
				_G.PlayerStatFrameLeft2Stat:SetParent(_G["PaperDollItemsFrame"])
				_G.PlayerStatFrameLeft3Stat:ClearAllPoints()
				_G.PlayerStatFrameLeft3Stat:SetPoint("BOTTOM", _G.PlayerStatFrameLeft2Stat, "BOTTOM", 0, -13)
				_G.PlayerStatFrameLeft3StatText:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
				_G.PlayerStatFrameLeft3Stat:SetParent(_G["PaperDollItemsFrame"])
				_G.PlayerStatFrameLeft4Stat:ClearAllPoints()
				_G.PlayerStatFrameLeft4Stat:SetPoint("BOTTOM", _G.PlayerStatFrameLeft3Stat, "BOTTOM", 0, -13)
				_G.PlayerStatFrameLeft4StatText:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
				_G.PlayerStatFrameLeft4Stat:SetParent(_G["PaperDollItemsFrame"])
				_G.PlayerStatFrameLeft5Stat:ClearAllPoints()
				_G.PlayerStatFrameLeft5Stat:SetPoint("BOTTOM", _G.PlayerStatFrameLeft4Stat, "BOTTOM", 0, -13)
				_G.PlayerStatFrameLeft5StatText:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
				_G.PlayerStatFrameLeft5Stat:SetParent(_G["PaperDollItemsFrame"])
				_G.PlayerStatFrameLeft6Stat:ClearAllPoints()
				_G.PlayerStatFrameLeft6Stat:SetPoint("BOTTOM", _G.PlayerStatFrameLeft5Stat, "BOTTOM", 0, -13)
				_G.PlayerStatFrameLeft6StatText:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
				_G.PlayerStatFrameLeft6Stat:SetParent(_G["PlayerStatFrameLeft6"])

				--"right side", on this case its the bottom
				_G.PlayerStatFrameRightDropDown:ClearAllPoints()
				_G.PlayerStatFrameRightDropDown:SetPoint("CENTER", _G.PlayerStatFrameLeftDropDown, "CENTER", 0, -105)
				_G.PlayerStatFrameRightDropDown:SetParent(_G["PaperDollItemsFrame"])

				_G.PlayerStatFrameRight1:ClearAllPoints()
				_G.PlayerStatFrameRight1:SetPoint("BOTTOM", _G.PlayerStatFrameRightDropDown, "BOTTOM", -22, -5)
				_G.PlayerStatFrameRight1:SetParent(_G["PaperDollItemsFrame"])

				_G.PlayerStatFrameRight2:ClearAllPoints()
				_G.PlayerStatFrameRight2:SetPoint("BOTTOM", _G.PlayerStatFrameRight1, "BOTTOM", 0, -13)
				_G.PlayerStatFrameRight2:SetParent(_G["PaperDollItemsFrame"])
				_G.PlayerStatFrameRight2.StatusLine:SetSize(170, 12)
				_G.PlayerStatFrameRight2.StatusLine:SetPoint("CENTER", _G.PlayerStatFrameRight2, "CENTER", 25, 0)
				_G.PlayerStatFrameRight2.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				_G.PlayerStatFrameRight2.StatusLine:SetStatusBarColor(1, 1, 1, 0.3)
				_G.PlayerStatFrameRight2.StatusLine:SetFrameLevel(2)

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
				_G.PlayerStatFrameRight4.StatusLine:SetFrameLevel(2)

				_G.PlayerStatFrameRight5:ClearAllPoints()
				_G.PlayerStatFrameRight5:SetPoint("BOTTOM", _G.PlayerStatFrameRight4, "BOTTOM", 0, -13)
				_G.PlayerStatFrameRight5:SetParent(_G.PlayerStatFrameRight1)

				_G.PlayerStatFrameRight6:ClearAllPoints()
				_G.PlayerStatFrameRight6:SetPoint("BOTTOM", _G.PlayerStatFrameRight5, "BOTTOM", 0, -13)
				_G.PlayerStatFrameRight6:SetParent(_G["PaperDollItemsFrame"])
				_G.PlayerStatFrameRight6.StatusLine:SetSize(170, 12)
				_G.PlayerStatFrameRight6.StatusLine:SetPoint("CENTER", _G.PlayerStatFrameRight6, "CENTER", 25, 0)
				_G.PlayerStatFrameRight6.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				_G.PlayerStatFrameRight6.StatusLine:SetStatusBarColor(1, 1, 1, 0.3)
				_G.PlayerStatFrameRight6.StatusLine:SetParent(_G["PlayerStatFrameRight6"])
				_G.PlayerStatFrameRight6.StatusLine:SetFrameLevel(2)

				_G.PlayerStatFrameRight1Stat:ClearAllPoints()
				_G.PlayerStatFrameRight1Stat:SetPoint("CENTER", _G.PlayerStatFrameRight1, "CENTER", 95, 0)
				_G.PlayerStatFrameRight1StatText:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
				_G.PlayerStatFrameRight1Stat:SetParent(_G.PlayerStatFrameRight1)
				_G.PlayerStatFrameRight2Stat:ClearAllPoints()
				_G.PlayerStatFrameRight2Stat:SetPoint("BOTTOM", _G.PlayerStatFrameRight1Stat, "BOTTOM", 0, -13)
				_G.PlayerStatFrameRight2StatText:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
				_G.PlayerStatFrameRight2Stat:SetParent(_G.PlayerStatFrameRight1)
				_G.PlayerStatFrameRight3Stat:ClearAllPoints()
				_G.PlayerStatFrameRight3Stat:SetPoint("BOTTOM", _G.PlayerStatFrameRight2Stat, "BOTTOM", 0, -13)
				_G.PlayerStatFrameRight3StatText:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
				_G.PlayerStatFrameRight3Stat:SetParent(_G.PlayerStatFrameRight1)
				_G.PlayerStatFrameRight4Stat:ClearAllPoints()
				_G.PlayerStatFrameRight4Stat:SetPoint("BOTTOM", _G.PlayerStatFrameRight3Stat, "BOTTOM", 0, -13)
				_G.PlayerStatFrameRight4StatText:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
				_G.PlayerStatFrameRight4Stat:SetParent(_G.PlayerStatFrameRight1)
				_G.PlayerStatFrameRight5Stat:ClearAllPoints()
				_G.PlayerStatFrameRight5Stat:SetPoint("BOTTOM", _G.PlayerStatFrameRight4Stat, "BOTTOM", 0, -13)
				_G.PlayerStatFrameRight5StatText:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
				_G.PlayerStatFrameRight5Stat:SetParent(_G.PlayerStatFrameRight1)
				_G.PlayerStatFrameRight6Stat:ClearAllPoints()
				_G.PlayerStatFrameRight6Stat:SetPoint("BOTTOM", _G.PlayerStatFrameRight5Stat, "BOTTOM", 0, -13)
				_G.PlayerStatFrameRight6StatText:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
				_G.PlayerStatFrameRight6Stat:SetParent(_G["PlayerStatFrameRight6"])
			elseif E.Classic then


				_G.CharacterStatFrame1:ClearAllPoints()
				_G.CharacterStatFrame1:SetPoint("CENTER", _G.MagicResFrame1, "CENTER", 28, -28) --first stat desc
				_G.CharacterStatFrame1:SetParent(CharacterModelFrame)

				_G.CharacterStatFrame2:ClearAllPoints()
				_G.CharacterStatFrame2:SetParent(_G.CharacterStatFrame1)
				_G.CharacterStatFrame2:SetPoint("BOTTOM", _G.CharacterStatFrame1, "BOTTOM", 0, -13)

				_G.CharacterStatFrame2.StatusLine:SetSize(170, 12)
				_G.CharacterStatFrame2.StatusLine:SetPoint("CENTER", _G.CharacterStatFrame2, "CENTER", 25, 0)
				_G.CharacterStatFrame2.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				_G.CharacterStatFrame2.StatusLine:SetStatusBarColor(1, 1, 1, 0.3)
				_G.CharacterStatFrame2.StatusLine:SetFrameLevel(2)

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
				_G.CharacterStatFrame4.StatusLine:SetFrameLevel(2)

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
				_G.CharacterArmorFrame.StatusLine:SetFrameLevel(2)

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
				_G.CharacterAttackPowerFrame.StatusLine:SetFrameLevel(2)

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
				_G.CharacterRangedAttackFrame.StatusLine:SetFrameLevel(2)

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
				_G.CharacterRangedDamageFrame.StatusLine:SetFrameLevel(2)

				_G.CharacterStatFrame1Stat:ClearAllPoints()
				_G.CharacterStatFrame1Stat:SetPoint("CENTER", _G.CharacterStatFrame1, "CENTER", 90, 0) --first stat number
				_G.CharacterStatFrame1StatText:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
				_G.CharacterStatFrame1Stat:SetParent(_G.CharacterStatFrame1)

				_G.CharacterStatFrame2Stat:ClearAllPoints()
				_G.CharacterStatFrame2Stat:SetPoint("BOTTOM", _G.CharacterStatFrame1Stat, "BOTTOM", 0, -13)
				_G.CharacterStatFrame2StatText:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
				_G.CharacterStatFrame2Stat:SetParent(_G.CharacterStatFrame1)
				_G.CharacterStatFrame3Stat:ClearAllPoints()
				_G.CharacterStatFrame3Stat:SetPoint("BOTTOM", _G.CharacterStatFrame2Stat, "BOTTOM", 0, -13)
				_G.CharacterStatFrame2StatText:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
				_G.CharacterStatFrame3Stat:SetParent(_G.CharacterStatFrame1)
				_G.CharacterStatFrame4Stat:ClearAllPoints()
				_G.CharacterStatFrame4Stat:SetPoint("BOTTOM", _G.CharacterStatFrame3Stat, "BOTTOM", 0, -13)
				_G.CharacterStatFrame4StatText:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
				_G.CharacterStatFrame4Stat:SetParent(_G.CharacterStatFrame1)
				_G.CharacterStatFrame5Stat:ClearAllPoints()
				_G.CharacterStatFrame5Stat:SetPoint("BOTTOM", _G.CharacterStatFrame4Stat, "BOTTOM", 0, -13)
				_G.CharacterStatFrame5StatText:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
				_G.CharacterStatFrame5Stat:SetParent(_G.CharacterStatFrame1)

				_G.CharacterArmorFrameStat:ClearAllPoints()
				_G.CharacterArmorFrameStat:SetPoint("BOTTOM", _G.CharacterStatFrame5Stat, "BOTTOM", 0, -13)
				_G.CharacterArmorFrameStatText:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
				_G.CharacterArmorFrameStat:SetParent(_G.CharacterStatFrame1)

				_G.CharacterAttackFrameStat:ClearAllPoints()
				_G.CharacterAttackFrameStat:SetPoint("BOTTOM", _G.CharacterArmorFrameStat, "BOTTOM", 0, -13)
				_G.CharacterAttackFrameStatText:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
				_G.CharacterAttackFrameStat:SetParent(_G.CharacterStatFrame1)

				_G.CharacterAttackPowerFrameStat:ClearAllPoints()
				_G.CharacterAttackPowerFrameStat:SetPoint("BOTTOM", _G.CharacterAttackFrameStat, "BOTTOM", 0, -13)
				_G.CharacterAttackPowerFrameStatText:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
				_G.CharacterAttackPowerFrameStat:SetParent(_G.CharacterStatFrame1)

				_G.CharacterDamageFrameStat:ClearAllPoints()
				_G.CharacterDamageFrameStat:SetPoint("BOTTOM", _G.CharacterAttackPowerFrameStat, "BOTTOM", 0, -13)
				_G.CharacterDamageFrameStatText:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
				_G.CharacterDamageFrameStat:SetParent(_G.CharacterStatFrame1)

				_G.CharacterRangedAttackFrameStat:ClearAllPoints()
				_G.CharacterRangedAttackFrameStat:SetPoint("BOTTOM", _G.CharacterDamageFrameStat, "BOTTOM", 0, -13)
				_G.CharacterRangedAttackFrameStatText:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
				_G.CharacterRangedAttackFrameStat:SetParent(_G.CharacterStatFrame1)

				_G.CharacterRangedAttackPowerFrameStat:ClearAllPoints()
				_G.CharacterRangedAttackPowerFrameStat:SetPoint("BOTTOM", _G.CharacterRangedAttackFrameStat, "BOTTOM", 0, -13)
				_G.CharacterRangedAttackPowerFrameStatText:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
				_G.CharacterRangedAttackPowerFrameStat:SetParent(_G.CharacterStatFrame1)

				_G.CharacterRangedDamageFrameStat:ClearAllPoints()
				_G.CharacterRangedDamageFrameStat:SetPoint("BOTTOM", _G.CharacterRangedAttackPowerFrameStat, "BOTTOM", 0, -13)
				_G.CharacterRangedDamageFrameStatText:SetFont(E.LSM:Fetch('font', E.db.general.font), 11, E.db.general.fontStyle)
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
				if E.Retail then
					qualityAnchor.Frame:SetFrameLevel(2) --retail works fine
				else
					local slotlevel = _G["CharacterModelFrame"]:GetFrameLevel()
					qualityAnchor.Frame:SetFrameLevel(slotlevel-1) --needs to be changed to not overlap the sockets/enchants
				end
				local slotsize = _G["Character"..InvSlotName]:GetHeight()
				if not E.Retail then
					if E.db.ElvUI_EltreumUI.skins.classicarmory then
						qualityAnchor.Frame:SetSize(150, slotsize+2)
					else
						qualityAnchor.Frame:SetSize(115, slotsize+2)
					end
				else
					if E.db.ElvUI_EltreumUI.skins.expandarmorybg then
						qualityAnchor.Frame:SetSize(250, slotsize+2)
					else
						qualityAnchor.Frame:SetSize(135, slotsize+2)
					end
				end

				qualityAnchor.Frame.Quality:SetInside() --if not then the frame will not anchor correctly
				qualityAnchor.Frame.Quality:SetTexture('Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Statusbar\\EltreumFade') --temp for testing

				--get item (actual) quality
				local itemLink = _G.GetInventoryItemLink(unit, InvSlotId)
				if itemLink ~= nil then
					local quality = select(3, _G.GetItemInfo(itemLink))
					if quality ~= nil then
						local r,g,b = _G.GetItemQualityColor(quality)
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
						qualityAnchor.Frame:SetPoint("BOTTOM", _G["Character"..InvSlotName], "BOTTOM", 0, 51)
						qualityAnchor.Frame.Quality:SetPoint("BOTTOM", _G["Character"..InvSlotName], "BOTTOM", 0, 51)
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

local classsymbolonframe
local classIcons = {
	["WARRIOR"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Warrior",
	["PALADIN"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Paladin",
	["HUNTER"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Hunter",
	["ROGUE"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Rogue",
	["PRIEST"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Priest",
	["DEATHKNIGHT"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/DeathKnight",
	["SHAMAN"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Shaman",
	["MAGE"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Mage",
	["WARLOCK"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Warlock",
	["MONK"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Monk",
	["DRUID"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Druid",
	["DEMONHUNTER"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/DemonHunter",
}

-- Alternate Class Icons by Releaf with borders
local classIconsReleafborder = {
	["WARRIOR"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/WarriorIconReleaf",
	["PALADIN"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/PaladinIconReleaf",
	["HUNTER"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/HunterIconReleaf",
	["ROGUE"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/RogueIconReleaf",
	["PRIEST"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/PriestIconReleaf",
	["DEATHKNIGHT"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/DeathKnightIconReleaf",
	["SHAMAN"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/ShamanIconReleaf",
	["MAGE"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/MageIconReleaf",
	["WARLOCK"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/WarlockIconReleaf",
	["MONK"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/MonkIconReleaf",
	["DRUID"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/DruidIconReleaf",
	["DEMONHUNTER"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/DemonHunterIconReleaf",
}

--inspect bg/item quality texture
local EltruismInspectBg = CreateFrame("Frame")
local EltruismInspectBgTexture = EltruismInspectBg:CreateTexture("EltruismInspectBG")
local EltruismInspectBgTextureFader = EltruismInspectBg:CreateTexture("EltruismInspectVignette")
EltruismInspectBgTextureFader:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Vignette.tga")

function ElvUI_EltreumUI:InspectBg(unit)
	if E.private.skins.blizzard.enable then
		--inspect frame bg
		if IsAddOnLoaded("Blizzard_InspectUI") then
			EltruismInspectBg:SetParent(_G.InspectFrame)

			if E.db.ElvUI_EltreumUI.skins.expandarmorybg then
				local _, englishClass, _, englishRace = _G.GetPlayerInfoByGUID(unit)
				if englishClass or englishRace then
					if _G.InspectFrame then
						local classcolor = E:ClassColor(englishClass, true)

						--inspect frame expand skin
						if not E.Retail then
							E:Delay(0, function()
								_G.InspectNameText:ClearAllPoints()
								_G.InspectNameText:SetPoint("TOP", _G.InspectFrame, "TOP", 0, -15)
								_G.InspectFrame:SetWidth(450)
								_G.InspectPaperDollItemsFrame:SetWidth(450)
								_G.InspectHandsSlot:ClearAllPoints()
								_G.InspectHandsSlot:SetPoint("TOPRIGHT", _G.InspectFrame, "TOPRIGHT", -45, -74)
								_G.InspectModelFrame:ClearAllPoints()
								_G.InspectModelFrame:SetPoint("CENTER", _G.InspectFrame, "CENTER", 0, 0)
								_G.InspectMainHandSlot:ClearAllPoints()
								_G.InspectMainHandSlot:SetPoint("CENTER", _G.InspectFrame, "CENTER", -52, -150)
								_G.InspectModelFrame:HookScript("OnShow", function()
									_G.InspectFrame:SetWidth(450)
								end)
								_G.InspectModelFrame:HookScript("OnHide", function()
									_G.InspectFrame:SetWidth(384)
								end)

								_G.InspectTalentFrame:HookScript("OnShow", function()
									_G.InspectFrame:SetWidth(384)
									if E.Wrath then
										_G.InspectFrame:SetHeight(730)
									else
										_G.InspectFrame:SetHeight(650)
									end
									_G.InspectTalentFrameTab1:ClearAllPoints()
									if not E.Wrath then
										_G.InspectTalentFrameTab1:SetPoint("TOP", _G.InspectTalentFrame, "TOP", -95, -50)
									else
										_G.InspectTalentFrameTab1:SetPoint("TOP", _G.InspectTalentFrame, "TOP", -72, -50)
									end
									_G.InspectTalentFrameScrollFrameScrollBar:SetAlpha(0)
									_G.InspectTalentFrameScrollFrame:ClearAllPoints()
									_G.InspectTalentFrameScrollFrame:SetPoint("CENTER", _G.InspectTalentFrame, "CENTER", -10, 12)
									if E.Wrath then
										_G.InspectTalentFrameScrollFrame:SetSize(300,720)
									else
										_G.InspectTalentFrameScrollFrame:SetSize(300,620)
									end
									E:Delay(0, function() _G.InspectTalentFrameScrollFrame:SetScale(0.75) end) --needs delay, maybe bc server response?

									if E.Wrath then
										_G.InspectTalentFramePointsBar:ClearAllPoints()
										_G.InspectTalentFramePointsBar:SetPoint("BOTTOM", _G.InspectTalentFrame, "BOTTOM", 0, 80)
									end

									--kill stuff
									_G.InspectTalentFrameCloseButton:Hide()
									if _G.InspectTalentFrameBackgroundTopRight then
										_G.InspectTalentFrameBackgroundTopRight:Kill()
									end
									if _G.InspectTalentFrameBackgroundBottomLeft then
										_G.InspectTalentFrameBackgroundBottomLeft:Kill()
									end
									if _G.InspectTalentFrameBackgroundBottomRight then
										_G.InspectTalentFrameBackgroundBottomRight:Kill()
									end
									--increase the size of the background
									if _G.InspectTalentFrameBackgroundTopLeft then
										if E.TBC then
											_G.InspectTalentFrameBackgroundTopLeft:ClearAllPoints()
											_G.InspectTalentFrameBackgroundTopLeft:SetParent(_G.InspectTalentFrame)
											--_G.InspectTalentFrameBackgroundTopLeft:SetSize(310 , 600)
											_G.InspectTalentFrameBackgroundTopLeft:SetAllPoints(_G.InspectTalentFrameScrollFrame)
										elseif E.Wrath then
											if _G.InspectTalentFrameScrollFrame.backdrop then
												_G.InspectTalentFrameScrollFrame.backdrop:Kill()
											end
											_G.InspectTalentFrameScrollFrame:SetScale(0.85)
											_G.InspectTalentFrameBackgroundTopLeft:ClearAllPoints()
											_G.InspectTalentFrameBackgroundTopLeft:SetParent(_G.InspectTalentFrame)
											--_G.InspectTalentFrameBackgroundTopLeft:SetSize(310 , 600)
											_G.InspectTalentFrameBackgroundTopLeft:SetAllPoints(_G.InspectTalentFrameScrollFrame)
											--_G.InspectTalentFrameBackgroundTopLeft:SetPoint("CENTER", _G.InspectTalentFrame, "CENTER", -10, 20)
										elseif E.Classic then
											_G.InspectTalentFrameBackgroundTopLeft:SetSize(310 , 490)
										end
									end
								end)

								_G.InspectTalentFrame:HookScript("OnHide", function()
									_G.InspectFrame:SetHeight(512)
									_G.InspectFrame:SetWidth(384)
								end)
							end)
						else
							_G.InspectFrame:SetWidth(450)
							_G.InspectPaperDollItemsFrame:SetWidth(450)
							_G.InspectHandsSlot:ClearAllPoints()
							_G.InspectHandsSlot:SetPoint("TOPRIGHT", _G.InspectFrame, "TOPRIGHT", -8, -62)
							_G.InspectModelFrame:ClearAllPoints()
							_G.InspectModelFrame:SetPoint("CENTER", _G.InspectFrame, "CENTER", 0, -20)
							_G.InspectMainHandSlot:ClearAllPoints()
							_G.InspectMainHandSlot:SetPoint("CENTER", _G.InspectFrame, "CENTER", -30, -187)

							_G.InspectFrame.ItemLevelText:ClearAllPoints()
							_G.InspectFrame.ItemLevelText:SetPoint("CENTER", _G.InspectFrame, "CENTER", 0, 165)
							_G.InspectFrame.ItemLevelText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							_G.InspectFrame.ItemLevelText:SetParent(_G["InspectModelFrame"])

							if _G.InspectPaperDollFrame.ViewButton then
								_G.InspectPaperDollFrame.ViewButton:ClearAllPoints()
								_G.InspectPaperDollFrame.ViewButton:SetPoint("CENTER", _G.InspectFrame, "CENTER", 0, 145)
								--maybe later
								--_G.InspectPaperDollFrame.ViewButton:SetAlpha(0)
								--_G.InspectPaperDollFrame.ViewButton:SetScript('OnEnter', function() _G.InspectPaperDollFrame.ViewButton:SetAlpha(1) end)
								--_G.InspectPaperDollFrame.ViewButton:SetScript('OnLeave', function() _G.InspectPaperDollFrame.ViewButton:SetAlpha(0) end)
							end
							--_G.InspectFrame.ItemLevelText:SetText(ElvUI_EltreumUI:GradientName(_G.InspectFrame.ItemLevelText:GetText(), englishClass))
							--_G.InspectFrame.ItemLevelText:SetText("|cffFFCE00"..L["Item Level"]..":|r "..(math.floor(ElvUI_EltreumUI:GetUnitItemLevel("target")*100))/100)
							_G.InspectModelFrame:HookScript("OnShow", function()
								_G.InspectFrame:SetWidth(450)
							end)
							_G.InspectModelFrame:HookScript("OnHide", function()
								_G.InspectFrame:SetWidth(338)
							end)
						end


						if E.db.ElvUI_EltreumUI.skins.classiconsblizz then
							classsymbolonframe = ("|T"..(classIcons[englishClass]..".tga:0:0:0:0|t"))
						elseif E.db.ElvUI_EltreumUI.skins.classiconsreleaf then
							classsymbolonframe = ("|T"..(classIconsReleafborder[englishClass]..".tga:0:0:0:0|t"))
						else
							classsymbolonframe = ("|T"..(classIcons[englishClass]..".tga:0:0:0:0|t"))
						end

						--add class icon + colored name
						if E.db.ElvUI_EltreumUI.skins.classiconsoncharacterpanel then
							E:Delay(0, function()
								if not E.Retail then
									if not _G.InspectNameText:GetText():match("|T") then
										_G.InspectNameText:SetFont(E.LSM:Fetch('font', E.db.general.font), 18, E.db.general.fontStyle)
										if string.len(_G.InspectNameText:GetText()) >= 6 then
											if E.db.ElvUI_EltreumUI.skins.characterskingradients then
												_G.InspectNameText:SetText(classsymbolonframe.." "..ElvUI_EltreumUI:GradientName(_G.InspectNameText:GetText(), englishClass))
											else
												_G.InspectNameText:SetText(classsymbolonframe.." ".._G.InspectNameText:GetText())
												_G.InspectNameText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
											end
										else
											_G.InspectNameText:SetText(classsymbolonframe.." ".._G.InspectNameText:GetText())
											_G.InspectNameText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
										end
										_G.InspectNameText:SetShadowColor(0, 0, 0, 0.8)
										_G.InspectNameText:SetShadowOffset(2, -1)
										_G.InspectNameText:SetWidth(200)
										_G.InspectNameText:SetDrawLayer("OVERLAY")
									end
								else
									if not _G.InspectFrameTitleText:GetText():match("|T") then
										_G.InspectFrameTitleText:SetFont(E.LSM:Fetch('font', E.db.general.font), 18, E.db.general.fontStyle)
										if string.len(_G.InspectFrameTitleText:GetText()) >= 6 then
											if E.db.ElvUI_EltreumUI.skins.characterskingradients then
												_G.InspectFrameTitleText:SetText(classsymbolonframe.." "..ElvUI_EltreumUI:GradientName(_G.InspectFrameTitleText:GetText(), englishClass))
											else
												_G.InspectFrameTitleText:SetText(classsymbolonframe.." ".._G.InspectFrameTitleText:GetText())
												_G.InspectFrameTitleText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
											end
										else
											_G.InspectFrameTitleText:SetText(classsymbolonframe.." ".._G.InspectFrameTitleText:GetText())
											_G.InspectFrameTitleText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
										end
										_G.InspectFrameTitleText:SetShadowColor(0, 0, 0, 0.8)
										_G.InspectFrameTitleText:SetShadowOffset(2, -1)
										_G.InspectFrameTitleText:SetWidth(200)
										_G.InspectFrameTitleText:SetDrawLayer("OVERLAY")
									end
								end
							end)
						end

						--calculate inspect ilvl
						if not E.Retail and E.db.ElvUI_EltreumUI.skins.ilvlsinspect then
							E:Delay(0, function()
								if not _G["EltruismInspectIlvl"] then
									_G.InspectFrame.Ilvl = _G.InspectFrame:CreateFontString("EltruismInspectIlvl", "OVERLAY", "GameFontNormal")
								else
									_G.InspectFrame.Ilvl = _G["EltruismInspectIlvl"]
								end
								_G.InspectFrame.Ilvl:SetSize(200, 32)
								_G.InspectFrame.Ilvl:SetPoint("BOTTOM", _G.InspectLevelText, "BOTTOM", 0, -25) --ilvl number
								_G.InspectFrame.Ilvl:SetParent(_G["InspectModelFrame"])
								_G.InspectFrame.Ilvl:SetTextColor(classcolor.r, classcolor.g, classcolor.b, 1)
								_G.InspectLevelText:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, E.db.general.fontStyle)
								_G.InspectFrame.Ilvl:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, E.db.general.fontStyle)
								_G.InspectFrame.Ilvl:SetText("|cffFFCE00"..L["Item Level"]..":|r "..(math.floor(ElvUI_EltreumUI:GetUnitItemLevel("target")*100))/100)
							end)
						end

						--add bg texture
						if E.Retail then
							EltruismInspectBgTextureFader:SetAllPoints(_G.InspectFrame)
						else
							EltruismInspectBgTextureFader:SetAllPoints(_G.InspectFrame.backdrop)
						end
						EltruismInspectBgTextureFader:SetParent(_G.InspectFrame)
						EltruismInspectBgTextureFader:SetDrawLayer("ARTWORK",7)
						EltruismInspectBgTextureFader:SetAlpha(E.db.ElvUI_EltreumUI.skins.armoryvignettealpha)
						if not E.db.ElvUI_EltreumUI.skins.armoryvignette then
							EltruismInspectBgTextureFader:Hide()
						else
							EltruismInspectBgTextureFader:Show()
						end
						if E.db.ElvUI_EltreumUI.skins.armorybgtype == "CLASS" then
							EltruismInspectBgTexture:SetTexture(classBgs[englishClass])
							EltruismInspectBgTexture:SetTexCoord(0, 0.87, 0, 0.60)
						elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "RACE" then
							EltruismInspectBgTexture:SetTexture(raceBgs[englishRace]) --(left, right, top, bottom)
							EltruismInspectBgTexture:SetTexCoord(0.1, 0.50, 0, 1)
						elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "RAGNAROS" then
							EltruismInspectBgTexture:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\Ragnaros")
							EltruismInspectBgTexture:SetTexCoord(0.1, 0.50, 0, 1)
						elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "SPACECLOUD" then
							EltruismInspectBgTexture:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\SpaceCloud")
							EltruismInspectBgTexture:SetTexCoord(0.1, 0.50, 0, 1)
						elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "RAVNYR" then
							EltruismInspectBgTexture:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\Ravnyr")
							EltruismInspectBgTexture:SetTexCoord(0.1, 0.50, 0, 1)
						elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "BLACK" then
							EltruismInspectBgTexture:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\black")
						elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "CUSTOM" then
							texturefile = [[Interface\AddOns\]]..E.private.ElvUI_EltreumUI.skins.armorybgtexture
							EltruismInspectBgTexture:SetTexture(texturefile)
						end

						EltruismInspectBgTexture:SetAlpha(E.db.ElvUI_EltreumUI.skins.expandarmorybgalpha)
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
						EltruismInspectBgTexture:SetDrawLayer("ARTWORK",6)
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

						if E.Retail then
							qualityAnchorInspect.Frame:SetFrameLevel(2)
						else
							local slotlevel = _G["InspectModelFrame"]:GetFrameLevel()
							qualityAnchorInspect.Frame:SetFrameLevel(slotlevel-1)
						end
						local slotsize = _G["Inspect"..InvSlotName]:GetHeight()
						if not E.Retail then
							qualityAnchorInspect.Frame:SetSize(120, slotsize+2)
						else
							qualityAnchorInspect.Frame:SetSize(140, slotsize+2)
						end

						qualityAnchorInspect.Frame.Quality:SetTexture('Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Statusbar\\EltreumFade') --temp for testing
						qualityAnchorInspect.Frame.Quality:SetInside() --if not then the frame will not anchor correctly

						--get item (actual) quality
						local itemLink = _G.GetInventoryItemLink("target", InvSlotId)
						if itemLink ~= nil then
							local quality = select(3,_G.GetItemInfo(itemLink))
							local r,g,b = _G.GetItemQualityColor(quality)
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
