local E, L, _, P = unpack(ElvUI)
local _G = _G
local select = _G.select
local classcolor = E:ClassColor(E.myclass, true)
local CreateFrame = _G.CreateFrame
local max = _G.max
local tonumber = _G.tonumber
local math = _G.math
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded
local hooksecurefunc = _G.hooksecurefunc
local CharacterStatsPane = _G.CharacterStatsPane
local GetItemQualityColor = _G.C_Item and _G.C_Item.GetItemQualityColor or _G.GetItemQualityColor
local PaperDollFrame = _G.PaperDollFrame
local SkillFrame = _G.SkillFrame
local CharacterModelFrame = _G.CharacterModelFrame
local SetCVar = _G.C_CVar and _G.C_CVar.SetCVar or _G.SetCVar
local PaperDollItemsFrame = _G.PaperDollItemsFrame
local CharacterNameText = _G.CharacterNameText
local CharacterTitleText = _G.CharacterTitleText
local CharacterLevelText = _G.CharacterLevelText
local NORMAL_FONT_COLOR = _G.NORMAL_FONT_COLOR
local MANA_REGEN = _G.MANA_REGEN
local total, maxlevel = 0, 0
local level, mainhand, offhand, ranged
local linkloop, mainlevel, mainlink
local offhandlink, offhandlevel, rangedlevel, rangedlink
local spec, points
local _, name, spent
local linewidth1, linewidth2, linewidth3, linewidth4
local texturefile, linewidthsle1, linewidthsle2
local id, currentSpec, speed, combatText, combat, regenRate, regenRateText
local qualityAnchor,qualityAnchorInspect
local CharacterModelScene = _G.CharacterModelScene
local pairs = _G.pairs
local string = _G.string
local InCombatLockdown = _G.InCombatLockdown
local format = _G.format
local GetItemInfo = _G.C_Item and _G.C_Item.GetItemInfo or _G.GetItemInfo

--improving character panel
local CharacterFrame = _G.CharacterFrame
local CharacterFrameBackgroundTexture = CharacterFrame:CreateTexture("EltruismCharacterBG")
local ClassCrestFrame = CreateFrame("Frame")
local ClassCrestFrameTexture = ClassCrestFrame:CreateTexture("EltruismClassCrest")
local CharacterFrameBackgroundTextureFader = ClassCrestFrame:CreateTexture("EltruismCharacterBGVignette")
CharacterFrameBackgroundTextureFader:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Vignette.tga")

if E.Retail then
	CharacterFrame.EltruismClassResource = CharacterFrame:CreateFontString(nil,"ARTWORK")
	CharacterFrame.EltruismClassResourceDesc = CharacterFrame:CreateFontString(nil,"ARTWORK")
	CharacterFrame.EltruismClassResourceDescTooltip = CreateFrame("Frame", "EltruismClassResourceDesc")
	CharacterFrame.EltruismClassResource2 = CharacterFrame:CreateFontString(nil,"ARTWORK")
	CharacterFrame.EltruismClassResourceDesc2 = CharacterFrame:CreateFontString(nil,"ARTWORK")
	CharacterFrame.EltruismClassResourceDescTooltip2 = CreateFrame("Frame", "EltruismClassResourceDesc2")
	--CharacterFrame.EltruismExtraStatsBlock = CharacterFrame:CreateTexture(nil, 'BORDER')
	CharacterFrame.EltruismExtraStats = CreateFrame("StatusBar", nil, CharacterStatsPane)
	CharacterFrame.EltruismExtraStats:SetMinMaxValues(0,100)
	CharacterFrame.EltruismExtraStats:SetValue(100)
	CharacterFrame.EltruismExtraStats2 = CreateFrame("StatusBar", nil, CharacterStatsPane)
	CharacterFrame.EltruismExtraStats2:SetMinMaxValues(0,100)
	CharacterFrame.EltruismExtraStats2:SetValue(100)
	CharacterFrame.EltruismExtraStatsFont = CharacterFrame:CreateFontString(nil,"ARTWORK")
	CharacterFrame.EltruismSpeed = CharacterFrame:CreateFontString(nil,"ARTWORK")
	CharacterFrame.EltruismSpeedDesc = CharacterFrame:CreateFontString(nil,"ARTWORK")
	CharacterFrame.EltruismSpeedDescTooltip = CreateFrame("Frame", "EltruismSpeedDesc")
end

if E.Wrath or E.Classic then
	CharacterFrame.Text = CharacterFrame:CreateFontString("EltruismIlvlBanner", "OVERLAY", "GameFontNormal")
	CharacterFrame.Text2 = CharacterFrame:CreateFontString("EltruismIlvlText", "OVERLAY", "GameFontNormal")
	CharacterFrame.Text3 = CharacterFrame:CreateFontString("EltruismAttributes", "OVERLAY", "GameFontNormal")
	CharacterFrame.Text4 = CharacterFrame:CreateFontString("EltruismSpecBanner", "OVERLAY", "GameFontNormal")
	CharacterFrame.Text5 = CharacterFrame:CreateFontString("EltruismSpec", "OVERLAY", "GameFontNormal")
	CharacterFrame.Text6 = CharacterFrame:CreateFontString("CombatWarningText", "OVERLAY", "GameFontNormal")
	CharacterFrame.StatusLine = CreateFrame("StatusBar", "EltruismCharacterBar1", PaperDollItemsFrame)
	CharacterFrame.StatusLine:SetMinMaxValues(0,100)
	CharacterFrame.StatusLine:SetValue(100)
	CharacterFrame.StatusLine2 = CreateFrame("StatusBar", "EltruismCharacterBar2", PaperDollItemsFrame)
	CharacterFrame.StatusLine2:SetMinMaxValues(0,100)
	CharacterFrame.StatusLine2:SetValue(100)
	CharacterFrame.StatusLine3 = CreateFrame("StatusBar", "EltruismCharacterBar3", PaperDollItemsFrame)
	CharacterFrame.StatusLine3:SetMinMaxValues(0,100)
	CharacterFrame.StatusLine3:SetValue(100)
	CharacterFrame.StatusLine4 = CreateFrame("StatusBar", "EltruismCharacterBar4", PaperDollItemsFrame)
	CharacterFrame.StatusLine4:SetMinMaxValues(0,100)
	CharacterFrame.StatusLine4:SetValue(100)
end

if E.Wrath then
	_G.PlayerStatFrameLeft2.StatusLine = CreateFrame("StatusBar", "EltruismStatLine12", PaperDollItemsFrame)
	_G.PlayerStatFrameLeft2.StatusLine:SetMinMaxValues(0,100)
	_G.PlayerStatFrameLeft2.StatusLine:SetValue(100)
	_G.PlayerStatFrameLeft4.StatusLine = CreateFrame("StatusBar", "EltruismStatLine22", PaperDollItemsFrame)
	_G.PlayerStatFrameLeft4.StatusLine:SetMinMaxValues(0,100)
	_G.PlayerStatFrameLeft4.StatusLine:SetValue(100)
	_G.PlayerStatFrameLeft6.StatusLine = CreateFrame("StatusBar", "EltruismStatLine32", PaperDollItemsFrame)
	_G.PlayerStatFrameLeft6.StatusLine:SetMinMaxValues(0,100)
	_G.PlayerStatFrameLeft6.StatusLine:SetValue(100)
	_G.PlayerStatFrameRight2.StatusLine = CreateFrame("StatusBar", "EltruismStatLine52", PaperDollItemsFrame)
	_G.PlayerStatFrameRight2.StatusLine:SetMinMaxValues(0,100)
	_G.PlayerStatFrameRight2.StatusLine:SetValue(100)
	_G.PlayerStatFrameRight4.StatusLine = CreateFrame("StatusBar", "EltruismStatLine62", PaperDollItemsFrame)
	_G.PlayerStatFrameRight4.StatusLine:SetMinMaxValues(0,100)
	_G.PlayerStatFrameRight4.StatusLine:SetValue(100)
	_G.PlayerStatFrameRight6.StatusLine = CreateFrame("StatusBar", "EltruismStatLine7", PaperDollItemsFrame)
	_G.PlayerStatFrameRight6.StatusLine:SetMinMaxValues(0,100)
	_G.PlayerStatFrameRight6.StatusLine:SetValue(100)
end

if E.Classic then
	_G.CharacterArmorFrame.StatusLine = CreateFrame("StatusBar", "EltruismStatLine3", PaperDollItemsFrame)
	_G.CharacterArmorFrame.StatusLine:SetMinMaxValues(0,100)
	_G.CharacterArmorFrame.StatusLine:SetValue(100)
	_G.CharacterAttackPowerFrame.StatusLine = CreateFrame("StatusBar", "EltruismStatLine4", PaperDollItemsFrame)
	_G.CharacterAttackPowerFrame.StatusLine:SetMinMaxValues(0,100)
	_G.CharacterAttackPowerFrame.StatusLine:SetValue(100)
	_G.CharacterRangedAttackFrame.StatusLine = CreateFrame("StatusBar", "EltruismStatLine5", PaperDollItemsFrame)
	_G.CharacterRangedAttackFrame.StatusLine:SetMinMaxValues(0,100)
	_G.CharacterRangedAttackFrame.StatusLine:SetValue(100)
	_G.CharacterRangedDamageFrame.StatusLine = CreateFrame("StatusBar", "EltruismStatLine6", PaperDollItemsFrame)
	_G.CharacterRangedDamageFrame.StatusLine:SetMinMaxValues(0,100)
	_G.CharacterRangedDamageFrame.StatusLine:SetValue(100)
	_G.CharacterStatFrame2.StatusLine = CreateFrame("StatusBar", "EltruismStatLine1", PaperDollItemsFrame)
	_G.CharacterStatFrame2.StatusLine:SetMinMaxValues(0,100)
	_G.CharacterStatFrame2.StatusLine:SetValue(100)
	_G.CharacterStatFrame4.StatusLine = CreateFrame("StatusBar", "EltruismStatLine2", PaperDollItemsFrame)
	_G.CharacterStatFrame4.StatusLine:SetMinMaxValues(0,100)
	_G.CharacterStatFrame4.StatusLine:SetValue(100)
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
	["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Evoker\\artifactuievoker",
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
	["Dracthyr"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Backgrounds\\Dracthyr",
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
	["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Evoker\\evokercrest",
}

local classCrests2 = {
	["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\Warrior.tga",
	["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\Paladin.tga",
	["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\Hunter.tga",
	["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\Rogue.tga",
	["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\Priest.tga",
	["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\DeathKnight.tga",
	["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\Shaman.tga",
	["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\MageArcane.tga",
	["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\Warlock.tga",
	["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\Monk.tga",
	["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\Druid.tga",
	["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\DemonHunter.tga",
	["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\Evoker.tga",
}

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
		total = 0
	elseif (mainhand > 0 and offhand > 0) then
		total = total + mainhand + offhand
	elseif (offhand > 0 and ranged > 0) then
		total = total + offhand + ranged
	else
		total = total + max(mainhand,offhand,ranged) * 2
	end
	return total/16
end

--wrath to detect dual spec
--GetNumTalentGroups() --gets if they actually have dual spec in the first place
--GetActiveTalentGroup() --gets which of the dual is being used

--turns out classic has the functions to get number of points on talent trees
function ElvUI_EltreumUI:GetPlayerSpec()
	--reset variables
	name = ""
	spent = 0
	points = 0
	spec = ""

	local spent1 = select(3,_G.GetTalentTabInfo(1))
	local spent2 = select(3,_G.GetTalentTabInfo(2))
	local spent3 = select(3,_G.GetTalentTabInfo(3))
	for i=1, _G.GetNumTalentTabs() do
		if not E.Cata then
			name, _, spent = _G.GetTalentTabInfo(i)
		else
			_, name, _, _, spent = _G.GetTalentTabInfo(i)
		end
		if spent > 0 and (not points or spent > points) then
			spec, points = name, spent
		end
	end
	if spec ~= nil and not ( (spent1 == spent2) or (spent2 == spent3) or (spent1 == spent3) ) then
		return spec
	elseif spent1 == spent2 or spent2 == spent3 or spent1 == spent3 then
		if spent1 == spent3 and spent1 == spent2 then
			return NONE
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
		return NONE
	end
end

--return the proper class crest/icon/symbol for the player class
function ElvUI_EltreumUI:GetClassCrest(install)
	if install then
		return classCrests2[E.myclass]
	else
		if E.db.ElvUI_EltreumUI.skins.expandarmorycrest then
			if E.db.ElvUI_EltreumUI.skins.armorycrestversion == 1 then
				return classCrests[E.myclass]
			else
				return classCrests2[E.myclass]
			end
		else
			return classCrests2[E.myclass]
		end
	end
end

if not E.Retail then
	local avgilvl = CreateFrame("FRAME")
	avgilvl:RegisterEvent("PLAYER_ENTERING_WORLD")
	avgilvl:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
	avgilvl:SetScript("OnEvent", function()
		CharacterFrame.Text2:SetText((math.floor(ElvUI_EltreumUI:GetUnitItemLevel("player")*100))/100)
	end)

	if E.Wrath then
		local wrathdualspec = CreateFrame("FRAME")
		wrathdualspec:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
		wrathdualspec:RegisterEvent("PLAYER_TALENT_UPDATE")
		--wrathdualspec:RegisterEvent("CHARACTER_POINTS_CHANGED")
		wrathdualspec:SetScript("OnEvent", function()
			E:Delay(2, function()
				if CharacterFrame.Text5 and CharacterFrame.Text5:GetText() ~= nil then
					CharacterFrame.Text5:SetText(ElvUI_EltreumUI:GetPlayerSpec())
				end
			end)
		end)
	end
end

--expanded armory
function ElvUI_EltreumUI:ExpandedCharacterStats()
	-- SLArmoryCheck()
	if not E.private.skins.blizzard.enable then return end
	if not E.private.skins.blizzard.character then return end

	if not InCombatLockdown() then
		_G["CharacterFrame"]:SetScale(E.db.ElvUI_EltreumUI.skins.characterpanelscale)
		if _G["CharacterModelFrame"] then
			_G["CharacterModelFrame"]:SetIgnoreParentScale(false)
		end
		if _G["CharacterModelScene"] then
			_G["CharacterModelScene"]:SetIgnoreParentScale(false)
		end
	end

	if IsAddOnLoaded("Pawn") then
		if _G["PawnUI_InventoryPawnButton"] then
			_G["PawnUI_InventoryPawnButton"]:SetFrameStrata("DIALOG")
		end
	end

	if E.Retail then

		--expand and skin the panel
		if E.db.ElvUI_EltreumUI.skins.classicarmory then

			--color the avg item level

			CharacterStatsPane.ItemLevelFrame.leftGrad:SetGradient('Horizontal', {r=classcolor.r,g= classcolor.g,b= classcolor.b,a= 0.4}, {r=classcolor.r,g= classcolor.g,b= classcolor.b,a= 0})
			CharacterStatsPane.ItemLevelFrame.rightGrad:SetGradient('Horizontal', {r=classcolor.r,g= classcolor.g,b= classcolor.b,a= 0}, {r=classcolor.r,g= classcolor.g,b= classcolor.b,a= 0.4})
			--[[CharacterStatsPane.ItemLevelFrame.leftGrad:SetTexture(E.LSM:Fetch("statusbar", 'Eltreum-Fade'))
			CharacterStatsPane.ItemLevelFrame.rightGrad:SetTexture(E.LSM:Fetch("statusbar", 'Eltreum-Fade'))
			CharacterStatsPane.ItemLevelFrame.rightGrad:SetTexCoord(1, 0, 0, 1)
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
				CharacterStatsPane.ItemLevelFrame.leftGrad:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass,true,false))
				CharacterStatsPane.ItemLevelFrame.rightGrad:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass,true,false))
			else
				CharacterStatsPane.ItemLevelFrame.leftGrad:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass,true,false))
				CharacterStatsPane.ItemLevelFrame.rightGrad:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass,true,false))
			end]]

			--CharacterFrame:SetHeight(505)
			CharacterFrame:SetHeight(455)
			-- Move Right Side since left side is already ok
			_G.CharacterFrameInsetRight:SetPoint('TOPLEFT', _G.CharacterFrameInset, 'TOPRIGHT', 130, 0)
			_G.CharacterHandsSlot:SetPoint('TOPRIGHT', _G.CharacterFrameInsetRight, 'TOPLEFT', 0, -3)
			-- Move bottom equipment slots
			_G.CharacterMainHandSlot:SetPoint('BOTTOMLEFT', PaperDollItemsFrame, 'BOTTOMLEFT', 195, 20)
			--strech it a bit
			if CharacterModelScene then
				CharacterModelScene:ClearAllPoints()
				CharacterModelScene:SetPoint('TOPLEFT', _G.CharacterHeadSlot, -5, 5)
				CharacterModelScene:SetPoint('RIGHT', _G.CharacterHandsSlot, 5, 5)
				CharacterModelScene:SetPoint('BOTTOM', _G.CharacterMainHandSlot, 0, -5)
				local actor = CharacterModelScene:GetPlayerActor()
				if actor then
					actor:SetPosition(0, 0, 0)
					actor:SetPosition(E.db.ElvUI_EltreumUI.skins.charactermodelcam.zoomretail, E.db.ElvUI_EltreumUI.skins.charactermodelcam.xretail, E.db.ElvUI_EltreumUI.skins.charactermodelcam.yretail)
				end
			end

			--move the equipment manager to a nice position
			if _G.PaperDollFrame.EquipmentManagerPane then
				_G.PaperDollFrame.EquipmentManagerPane:ClearAllPoints()
				_G.PaperDollFrame.EquipmentManagerPane:SetPoint("RIGHT", CharacterFrame, "RIGHT", -30, -20)
				_G.PaperDollFrame.EquipmentManagerPane.ScrollBox:ClearAllPoints()
				_G.PaperDollFrame.EquipmentManagerPane.ScrollBox:SetPoint("TOP", _G.PaperDollFrame.EquipmentManagerPane, "TOP", 0, -30)
			end

			--move the titles panel to a nice position
			if _G.PaperDollFrame.TitleManagerPane then
				_G.PaperDollFrame.TitleManagerPane:ClearAllPoints()
				_G.PaperDollFrame.TitleManagerPane:SetPoint("RIGHT", CharacterFrame, "RIGHT", -40, -20)
				_G.PaperDollFrame.TitleManagerPane.ScrollBox:ClearAllPoints()
				_G.PaperDollFrame.TitleManagerPane.ScrollBox:SetPoint("RIGHT", CharacterFrame, "RIGHT", -40, -20)
			end

			if not ElvUI_EltreumUI:SLCheck("stats") and (not IsAddOnLoaded('DejaCharacterStats')) then
				CharacterStatsPane.ItemLevelCategory.backdrop:Hide()
				CharacterStatsPane.ItemLevelCategory.Title:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize + 6, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))

				CharacterStatsPane.AttributesCategory.backdrop:Hide()
				CharacterStatsPane.AttributesCategory.Title:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize + 6, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))

				CharacterStatsPane.EnhancementsCategory.backdrop:Hide()
				CharacterStatsPane.EnhancementsCategory.Title:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize + 6, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			end

			if E.db.ElvUI_EltreumUI.skins.classicarmoryeltruismstats then
				CharacterFrame.EltruismExtraStatsFont:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize + 6, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				CharacterFrame.EltruismExtraStatsFont:SetPoint("TOP", CharacterStatsPane, "BOTTOM", 0, -85) --adjusts the eltruism stats portion
				CharacterFrame.EltruismExtraStatsFont:SetParent(CharacterStatsPane)
			end

			if ElvUI_EltreumUI:SLCheck("stats") and not IsAddOnLoaded('DejaCharacterStats') then

				--item level
				CharacterStatsPane.ItemLevelCategory.backdrop:Hide()

				--offense
				CharacterStatsPane.OffenseCategory.backdrop:Hide()
				if not CharacterStatsPane.OffenseCategory.Title:GetText():match("|r") then
					if E.db.ElvUI_EltreumUI.skins.characterskingradients then
						CharacterStatsPane.OffenseCategory.Title:SetText(ElvUI_EltreumUI:GradientName(CharacterStatsPane.OffenseCategory.Title:GetText(), E.myclass))
					else --if E.db.ElvUI_EltreumUI.skins.statcolors then
						--CharacterStatsPane.OffenseCategory.Title:SetText(CharacterStatsPane.OffenseCategory.Title:GetText())
						CharacterStatsPane.OffenseCategory.Title:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
					end
				end
				--CharacterStatsPane.OffenseCategory.Title:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize + 6, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))

				--statusbars
				linewidthsle1 = (( 300 - CharacterStatsPane.OffenseCategory.Title:GetStringWidth())/2)
				CharacterStatsPane.OffenseCategory.Title.StatusLine = CreateFrame("StatusBar", "EltruismOffenseCategory", CharacterStatsPane)
				CharacterStatsPane.OffenseCategory.Title.StatusLine:SetMinMaxValues(0,100)
				CharacterStatsPane.OffenseCategory.Title.StatusLine:SetValue(100)
				CharacterStatsPane.OffenseCategory.Title.StatusLine:SetSize(linewidthsle1, 4)
				CharacterStatsPane.OffenseCategory.Title.StatusLine:SetPoint("RIGHT", CharacterStatsPane.OffenseCategory.Title, "LEFT", 0, -1)
				CharacterStatsPane.OffenseCategory.Title.StatusLine:SetStatusBarTexture(E.LSM:Fetch("statusbar", "ElvUI Norm1"))
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
					CharacterStatsPane.OffenseCategory.Title.StatusLine:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass,true,false))
				else
					CharacterStatsPane.OffenseCategory.Title.StatusLine:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass,true,false))
				end
				CharacterStatsPane.OffenseCategory.Title.StatusLine2 = CreateFrame("StatusBar", "EltruismOffenseCategoryLine2", CharacterStatsPane)
				CharacterStatsPane.OffenseCategory.Title.StatusLine2:SetMinMaxValues(0,100)
				CharacterStatsPane.OffenseCategory.Title.StatusLine2:SetValue(100)
				CharacterStatsPane.OffenseCategory.Title.StatusLine2:SetSize(linewidthsle1, 4)
				CharacterStatsPane.OffenseCategory.Title.StatusLine2:SetPoint("LEFT", CharacterStatsPane.OffenseCategory.Title, "RIGHT", -1, -1)
				CharacterStatsPane.OffenseCategory.Title.StatusLine2:SetStatusBarTexture(E.LSM:Fetch("statusbar", "ElvUI Norm1"))
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
					CharacterStatsPane.OffenseCategory.Title.StatusLine2:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass,true,false))
				else
					CharacterStatsPane.OffenseCategory.Title.StatusLine2:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass,true,false))
				end

				--defense
				CharacterStatsPane.DefenseCategory.backdrop:Hide()
				if not CharacterStatsPane.DefenseCategory.Title:GetText():match("|r") then
					if E.db.ElvUI_EltreumUI.skins.characterskingradients then
						CharacterStatsPane.DefenseCategory.Title:SetText(ElvUI_EltreumUI:GradientName(CharacterStatsPane.DefenseCategory.Title:GetText(), E.myclass))
					else --if E.db.ElvUI_EltreumUI.skins.statcolors then
						--CharacterStatsPane.DefenseCategory.Title:SetText(CharacterStatsPane.DefenseCategory.Title:GetText())
						CharacterStatsPane.DefenseCategory.Title:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
					end
				end
				--CharacterStatsPane.DefenseCategory.Title:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize + 6, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))

				--statusbars
				linewidthsle2 = (( 300 - CharacterStatsPane.DefenseCategory.Title:GetStringWidth())/2)
				CharacterStatsPane.DefenseCategory.Title.StatusLine = CreateFrame("StatusBar", "EltruismDefenseCategory", CharacterStatsPane)
				CharacterStatsPane.DefenseCategory.Title.StatusLine:SetMinMaxValues(0,100)
				CharacterStatsPane.DefenseCategory.Title.StatusLine:SetValue(100)
				CharacterStatsPane.DefenseCategory.Title.StatusLine:SetSize(linewidthsle2, 4)
				CharacterStatsPane.DefenseCategory.Title.StatusLine:SetPoint("RIGHT", CharacterStatsPane.DefenseCategory.Title, "LEFT", 0, -1)
				CharacterStatsPane.DefenseCategory.Title.StatusLine:SetStatusBarTexture(E.LSM:Fetch("statusbar", "ElvUI Norm1"))
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
					CharacterStatsPane.DefenseCategory.Title.StatusLine:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass,true,false))
				else
					CharacterStatsPane.DefenseCategory.Title.StatusLine:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass,true,false))
				end
				CharacterStatsPane.DefenseCategory.Title.StatusLine2 = CreateFrame("StatusBar", "EltruismDefenseCategoryLine2", CharacterStatsPane)
				CharacterStatsPane.DefenseCategory.Title.StatusLine2:SetMinMaxValues(0,100)
				CharacterStatsPane.DefenseCategory.Title.StatusLine2:SetValue(100)
				CharacterStatsPane.DefenseCategory.Title.StatusLine2:SetSize(linewidthsle2, 4)
				CharacterStatsPane.DefenseCategory.Title.StatusLine2:SetPoint("LEFT", CharacterStatsPane.DefenseCategory.Title, "RIGHT", -1, -1)
				CharacterStatsPane.DefenseCategory.Title.StatusLine2:SetStatusBarTexture(E.LSM:Fetch("statusbar", "ElvUI Norm1"))
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
					CharacterStatsPane.DefenseCategory.Title.StatusLine2:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass,true,false))
				else
					CharacterStatsPane.DefenseCategory.Title.StatusLine2:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass,true,false))
				end

				--fix enhancement
				if CharacterStatsPane.EnhancementsCategory.Title.StatusLine then
					CharacterStatsPane.EnhancementsCategory.Title.StatusLine:SetSize(linewidth3 + 8, 4)
				end
				if CharacterStatsPane.EnhancementsCategory.Title.StatusLine2 then
					CharacterStatsPane.EnhancementsCategory.Title.StatusLine2:SetSize(linewidth3 + 8, 4)
				end
			end

			--extra stats
			if E.db.ElvUI_EltreumUI.skins.classicarmoryeltruismstats then

				--movement speed
				CharacterFrame.EltruismSpeed:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				CharacterFrame.EltruismSpeed:SetTextColor(1, 1, 1)
				CharacterFrame.EltruismSpeed:SetText("PLACEHOLDER	")
				CharacterFrame.EltruismSpeed:SetPoint("CENTER", CharacterStatsPane , 70, -163)
				CharacterFrame.EltruismSpeed:SetParent(CharacterStatsPane)
				CharacterFrame.EltruismSpeed:SetJustifyH("RIGHT")
				CharacterFrame.EltruismSpeed:SetShadowColor(0, 0, 0, 1)
				CharacterFrame.EltruismSpeed:SetShadowOffset(1, 0)
				CharacterFrame.EltruismSpeedDesc:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				CharacterFrame.EltruismSpeedDesc:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
				CharacterFrame.EltruismSpeedDesc:SetPoint("CENTER", CharacterStatsPane , "CENTER", -29, -163)
				CharacterFrame.EltruismSpeedDesc:SetParent(CharacterStatsPane)
				CharacterFrame.EltruismSpeedDesc:SetJustifyH("LEFT")
				CharacterFrame.EltruismSpeedDesc:SetShadowColor(0, 0, 0, 1)
				CharacterFrame.EltruismSpeedDesc:SetShadowOffset(1, 0)
				if CharacterFrame.EltruismSpeedDesc:GetText() ~= nil and not CharacterFrame.EltruismSpeedDesc:GetText():match("|r") then
					if E.db.ElvUI_EltreumUI.skins.characterskingradients then
						CharacterFrame.EltruismSpeedDesc:SetText(ElvUI_EltreumUI:GradientName(STAT_MOVEMENT_SPEED, E.myclass))
					else --if E.db.ElvUI_EltreumUI.skins.statcolors then
						CharacterFrame.EltruismSpeedDesc:SetText(STAT_MOVEMENT_SPEED)
						CharacterFrame.EltruismSpeedDesc:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
					end
				end
				CharacterFrame.EltruismSpeedDescTooltip:SetSize(190, 15)
				CharacterFrame.EltruismSpeedDescTooltip:SetPoint("TOP", CharacterStatsPane, "BOTTOM", 0, -163)
				CharacterFrame.EltruismSpeedDescTooltip:SetParent(CharacterStatsPane)
				CharacterFrame.EltruismSpeedDescTooltip:Show()
				CharacterFrame.EltruismSpeedDescTooltip:SetScript("OnEnter", function()
					_G["GameTooltip"]:SetOwner(CharacterFrame.EltruismSpeedDescTooltip, 'ANCHOR_RIGHT')
					_G["GameTooltip"]:AddLine(format(CR_SPEED_TOOLTIP, string.format('%.2f', (_G.GetUnitSpeed("player"))), ((_G.GetUnitSpeed("player")/7) *100)))
					_G["GameTooltip"]:Show()
				end)
				CharacterFrame.EltruismSpeedDescTooltip:SetScript("OnLeave", function()
					_G["GameTooltip"]:Hide()
				end)

				--class resource
				CharacterFrame.EltruismClassResource:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				CharacterFrame.EltruismClassResource:SetTextColor(1, 1, 1)
				CharacterFrame.EltruismClassResource:SetText("PLACEHOLDER")
				CharacterFrame.EltruismClassResource:SetPoint("CENTER", CharacterStatsPane , 72, -176)
				CharacterFrame.EltruismClassResource:SetParent(CharacterStatsPane)
				CharacterFrame.EltruismClassResource:SetJustifyH("RIGHT")
				CharacterFrame.EltruismClassResource:SetShadowColor(0, 0, 0, 1)
				CharacterFrame.EltruismClassResource:SetShadowOffset(1, 0)
				CharacterFrame.EltruismClassResourceDesc:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				CharacterFrame.EltruismClassResourceDesc:SetText("PLACEHOLDER")
				CharacterFrame.EltruismClassResourceDesc:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
				CharacterFrame.EltruismClassResourceDesc:SetPoint("CENTER", CharacterStatsPane , -46, -176)
				CharacterFrame.EltruismClassResourceDesc:SetParent(CharacterStatsPane)
				CharacterFrame.EltruismClassResourceDesc:SetJustifyH("LEFT")
				CharacterFrame.EltruismClassResourceDesc:SetShadowColor(0, 0, 0, 1)
				CharacterFrame.EltruismClassResourceDesc:SetShadowOffset(1, 0)
				CharacterFrame.EltruismClassResourceDescTooltip:SetSize(190, 15)
				CharacterFrame.EltruismClassResourceDescTooltip:SetPoint("TOP", CharacterStatsPane, "BOTTOM", 0, -176)
				CharacterFrame.EltruismClassResourceDescTooltip:SetParent(CharacterStatsPane)
				if E.myclass == 'HUNTER' or E.myclass == 'ROGUE' or E.myclass == 'DRUID' or E.myclass == 'MONK' or E.myclass == 'DEATHKNIGHT' or E.myclass == 'MAGE' or E.myclass == 'SHAMAN' or E.myclass == 'WARLOCK' or E.myclass == 'PALADIN' or E.myclass == 'PRIEST' then
					CharacterFrame.EltruismClassResource:Show()
					CharacterFrame.EltruismClassResourceDesc:Show()
					CharacterFrame.EltruismClassResourceDescTooltip:Show()
					currentSpec = _G.GetSpecialization()
					if currentSpec then
						id, _ = _G.GetSpecializationInfo(currentSpec)
					end
					if id == 264 or id == 257 or id == 256 or id == 65 or id == 270 or id == 105 then
						CharacterFrame.EltruismClassResource:Hide()
						CharacterFrame.EltruismClassResourceDesc:Hide()
						CharacterFrame.EltruismClassResourceDescTooltip:Hide()
					end
				else
					CharacterFrame.EltruismClassResource:Hide()
					CharacterFrame.EltruismClassResourceDesc:Hide()
					CharacterFrame.EltruismClassResourceDescTooltip:Hide()
				end
				CharacterFrame.EltruismClassResourceDescTooltip:SetScript("OnEnter", function()
					_G["GameTooltip"]:SetOwner(CharacterFrame.EltruismClassResourceDescTooltip, 'ANCHOR_RIGHT')
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
				CharacterFrame.EltruismClassResourceDescTooltip:SetScript("OnLeave", function()
					_G["GameTooltip"]:Hide()
				end)

				--class resource 2, because druids and monks are not nice
				CharacterFrame.EltruismClassResource2:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				CharacterFrame.EltruismClassResource2:SetTextColor(1, 1, 1)
				CharacterFrame.EltruismClassResource2:SetPoint("CENTER", CharacterStatsPane , 72, -189)
				CharacterFrame.EltruismClassResource2:SetParent(CharacterStatsPane)
				CharacterFrame.EltruismClassResource2:SetJustifyH("RIGHT")
				CharacterFrame.EltruismClassResource2:SetShadowColor(0, 0, 0, 1)
				CharacterFrame.EltruismClassResource2:SetShadowOffset(1, 0)
				CharacterFrame.EltruismClassResourceDesc2:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				CharacterFrame.EltruismClassResourceDesc2:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
				CharacterFrame.EltruismClassResourceDesc2:SetPoint("CENTER", CharacterStatsPane , -44, -189)
				CharacterFrame.EltruismClassResourceDesc2:SetParent(CharacterStatsPane)
				CharacterFrame.EltruismClassResourceDesc2:SetJustifyH("LEFT")
				CharacterFrame.EltruismClassResourceDesc2:SetShadowColor(0, 0, 0, 1)
				CharacterFrame.EltruismClassResourceDesc2:SetShadowOffset(1, 0)
				CharacterFrame.EltruismClassResourceDesc2:SetText(MANA_REGEN)
				CharacterFrame.EltruismClassResourceDescTooltip2:SetSize(190, 15)
				CharacterFrame.EltruismClassResourceDescTooltip2:SetPoint("TOP", CharacterStatsPane, "BOTTOM", 0, -189)
				CharacterFrame.EltruismClassResourceDescTooltip2:SetParent(CharacterStatsPane)
				if E.myclass == 'HUNTER' or E.myclass == 'ROGUE' or E.myclass == 'DEATHKNIGHT' or E.myclass == 'MAGE' or E.myclass == 'SHAMAN' or E.myclass == 'WARLOCK' or E.myclass == 'PALADIN' or E.myclass == 'PRIEST' then
					CharacterFrame.EltruismClassResource2:Hide()
					CharacterFrame.EltruismClassResourceDesc2:Hide()
					CharacterFrame.EltruismClassResourceDescTooltip2:Hide()
				elseif E.myclass == 'DRUID' or E.myclass == 'MONK' then
					CharacterFrame.EltruismClassResource2:Show()
					CharacterFrame.EltruismClassResourceDesc2:Show()
					CharacterFrame.EltruismClassResourceDescTooltip2:Show()
				end
				CharacterFrame.EltruismClassResourceDescTooltip2:SetScript("OnEnter", function()
					_G["GameTooltip"]:SetOwner(CharacterFrame.EltruismClassResourceDescTooltip2, 'ANCHOR_RIGHT')
					if E.myclass == 'DRUID' or E.myclass == 'MONK' then
						_G["GameTooltip"]:AddLine(MANA_REGEN_TOOLTIP)
					end
					_G["GameTooltip"]:Show()
				end)
				CharacterFrame.EltruismClassResourceDescTooltip2:SetScript("OnLeave", function()
					_G["GameTooltip"]:Hide()
				end)

				--conditional stat text
				if E.myclass == 'HUNTER' then
					if E.db.ElvUI_EltreumUI.skins.characterskingradients then
						if CharacterFrame.EltruismClassResourceDesc:GetText() ~= nil and not CharacterFrame.EltruismClassResourceDesc:GetText():match("|r") then
							CharacterFrame.EltruismClassResourceDesc:SetText(ElvUI_EltreumUI:GradientName(STAT_FOCUS_REGEN, E.myclass))
						end
					else --if E.db.ElvUI_EltreumUI.skins.statcolors then
						CharacterFrame.EltruismClassResourceDesc:SetText(STAT_FOCUS_REGEN)
						CharacterFrame.EltruismClassResourceDesc:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
					end
				elseif E.myclass == 'ROGUE' then
					if E.db.ElvUI_EltreumUI.skins.characterskingradients then
						if CharacterFrame.EltruismClassResourceDesc:GetText() ~= nil and not CharacterFrame.EltruismClassResourceDesc:GetText():match("|r") then
							CharacterFrame.EltruismClassResourceDesc:SetText(ElvUI_EltreumUI:GradientName(STAT_ENERGY_REGEN, E.myclass))
						end
					else --if E.db.ElvUI_EltreumUI.skins.statcolors then
						CharacterFrame.EltruismClassResourceDesc:SetText(STAT_ENERGY_REGEN)
						CharacterFrame.EltruismClassResourceDesc:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
					end
				elseif E.myclass == 'DRUID' or E.myclass == 'MONK' then
					if E.db.ElvUI_EltreumUI.skins.characterskingradients then
						if CharacterFrame.EltruismClassResourceDesc:GetText() ~=nil and not CharacterFrame.EltruismClassResourceDesc:GetText():match("|r") then
							CharacterFrame.EltruismClassResourceDesc:SetText(ElvUI_EltreumUI:GradientName(STAT_ENERGY_REGEN, E.myclass))
						end
						if CharacterFrame.EltruismClassResourceDesc2:GetText() ~=nil and not CharacterFrame.EltruismClassResourceDesc2:GetText():match("|r") then
							CharacterFrame.EltruismClassResourceDesc2:SetText(ElvUI_EltreumUI:GradientName(MANA_REGEN, E.myclass))
						end
					else --if E.db.ElvUI_EltreumUI.skins.statcolors then
						CharacterFrame.EltruismClassResourceDesc:SetText(STAT_ENERGY_REGEN)
						CharacterFrame.EltruismClassResourceDesc:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
						CharacterFrame.EltruismClassResourceDesc2:SetText(MANA_REGEN)
						CharacterFrame.EltruismClassResourceDesc2:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
					end
				elseif E.myclass == 'DEATHKNIGHT' then
					if E.db.ElvUI_EltreumUI.skins.characterskingradients then
						if CharacterFrame.EltruismClassResourceDesc:GetText() ~= nil and not CharacterFrame.EltruismClassResourceDesc:GetText():match("|r") then
							CharacterFrame.EltruismClassResourceDesc:SetText(ElvUI_EltreumUI:GradientName(STAT_RUNE_REGEN, E.myclass))
						end
					else --if E.db.ElvUI_EltreumUI.skins.statcolors then
						CharacterFrame.EltruismClassResourceDesc:SetText(STAT_RUNE_REGEN)
						CharacterFrame.EltruismClassResourceDesc:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
					end
				elseif E.myclass == 'MAGE' or E.myclass == 'SHAMAN' or E.myclass == 'WARLOCK' or E.myclass == 'PALADIN' or E.myclass == 'PRIEST' then
					if E.db.ElvUI_EltreumUI.skins.characterskingradients then
						if not CharacterFrame.EltruismClassResourceDesc:GetText():match("|r") then
							CharacterFrame.EltruismClassResourceDesc:SetText(ElvUI_EltreumUI:GradientName(MANA_REGEN, E.myclass))
						end
					else --if E.db.ElvUI_EltreumUI.skins.statcolors then
						CharacterFrame.EltruismClassResourceDesc:SetText(MANA_REGEN)
						CharacterFrame.EltruismClassResourceDesc:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
					end
				else
					CharacterFrame.EltruismClassResourceDesc2:SetText('')
				end
			end

			CharacterFrame:HookScript("OnShow", function()
				if E.db.ElvUI_EltreumUI.skins.ilvltextcolordifferenceenable then
					if not ElvUI_EltreumUI:SLCheck("stats") then
						local bagilvl, equippedilvl = GetAverageItemLevel()
						if bagilvl ~= equippedilvl then --as suggested by dlarge, inspired by SLE
							local r, g, b
							if E.db.ElvUI_EltreumUI.skins.ilvltextcolordifferencecustom then
								r, g, b = E:ColorGradient((equippedilvl / bagilvl), E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.badR, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.badG, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.badB, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.mediumR, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.mediumG, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.mediumB, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.goodR, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.goodG, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.goodB)
							else
								r, g, b = E:ColorGradient((equippedilvl / bagilvl), P.ElvUI_EltreumUI.skins.ilvltextcolordifference.badR, P.ElvUI_EltreumUI.skins.ilvltextcolordifference.badG, P.ElvUI_EltreumUI.skins.ilvltextcolordifference.badB, P.ElvUI_EltreumUI.skins.ilvltextcolordifference.mediumR, P.ElvUI_EltreumUI.skins.ilvltextcolordifference.mediumG, P.ElvUI_EltreumUI.skins.ilvltextcolordifference.mediumB, P.ElvUI_EltreumUI.skins.ilvltextcolordifference.goodR, P.ElvUI_EltreumUI.skins.ilvltextcolordifference.goodG, P.ElvUI_EltreumUI.skins.ilvltextcolordifference.goodB)
							end
							CharacterFrame.ItemLevelText:SetText(E:RGBToHex(r, g, b)..((math.floor(equippedilvl*100))/100).."|r ("..((math.floor(bagilvl*100))/100)..")|r")
						end
					end
				end

				E:Delay(0, function()
					local actor = CharacterModelScene:GetPlayerActor()
					if actor then
						actor:SetPosition(0, 0, 0)
						actor:SetPosition(E.db.ElvUI_EltreumUI.skins.charactermodelcam.zoomretail, E.db.ElvUI_EltreumUI.skins.charactermodelcam.xretail, E.db.ElvUI_EltreumUI.skins.charactermodelcam.yretail)
					end
				end)

			end)

			--update stats and stats position
			hooksecurefunc("PaperDollFrame_UpdateStats", function()
				if ElvUI_EltreumUI:SLCheck("stats") then

					--offense
					if CharacterStatsPane.OffenseCategory and CharacterStatsPane.OffenseCategory.backdrop and CharacterStatsPane.OffenseCategory.backdrop:IsShown() then
						CharacterStatsPane.OffenseCategory.backdrop:Hide()
					end
					if CharacterStatsPane.AttributesCategory and CharacterStatsPane.AttributesCategory.backdrop and CharacterStatsPane.AttributesCategory.backdrop:IsShown() then
						CharacterStatsPane.AttributesCategory.backdrop:Hide()
					end
					if CharacterStatsPane.EnhancementsCategory and CharacterStatsPane.EnhancementsCategory.backdrop and CharacterStatsPane.EnhancementsCategory.backdrop:IsShown() then
						CharacterStatsPane.EnhancementsCategory.backdrop:Hide()
					end
				else
					if E.db.ElvUI_EltreumUI.skins.ilvltextcolordifferenceenable then
						local bagilvl, equippedilvl = GetAverageItemLevel()
						if bagilvl ~= equippedilvl then --as suggested by dlarge, inspired by SLE
							local r, g, b
							if E.db.ElvUI_EltreumUI.skins.ilvltextcolordifferencecustom then
								r, g, b = E:ColorGradient((equippedilvl / bagilvl), E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.badR, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.badG, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.badB, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.mediumR, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.mediumG, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.mediumB, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.goodR, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.goodG, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.goodB)
							else
								r, g, b = E:ColorGradient((equippedilvl / bagilvl), P.ElvUI_EltreumUI.skins.ilvltextcolordifference.badR, P.ElvUI_EltreumUI.skins.ilvltextcolordifference.badG, P.ElvUI_EltreumUI.skins.ilvltextcolordifference.badB, P.ElvUI_EltreumUI.skins.ilvltextcolordifference.mediumR, P.ElvUI_EltreumUI.skins.ilvltextcolordifference.mediumG, P.ElvUI_EltreumUI.skins.ilvltextcolordifference.mediumB, P.ElvUI_EltreumUI.skins.ilvltextcolordifference.goodR, P.ElvUI_EltreumUI.skins.ilvltextcolordifference.goodG, P.ElvUI_EltreumUI.skins.ilvltextcolordifference.goodB)
							end
							CharacterFrame.ItemLevelText:SetText(E:RGBToHex(r, g, b)..((math.floor(equippedilvl*100))/100).."|r ("..((math.floor(bagilvl*100))/100)..")|r")
						end
					end

					--extra stats
					if E.db.ElvUI_EltreumUI.skins.classicarmoryeltruismstats then
						speed = ((_G.GetUnitSpeed("player")/7) *100)
						CharacterFrame.EltruismSpeed:SetText(math.ceil(speed).."%")
						_, combat = GetManaRegen()
						combat = math.floor(combat * 5.0)
						combatText = BreakUpLargeNumbers(combat)
						if E.myclass == 'HUNTER' or E.myclass == 'ROGUE' or E.myclass == 'DRUID' or E.myclass == 'MONK' then
							CharacterFrame.EltruismClassResource:SetText(BreakUpLargeNumbers(GetPowerRegen()))
						elseif E.myclass == 'MAGE' or E.myclass == 'SHAMAN' or E.myclass == 'WARLOCK' or E.myclass == 'PALADIN' or E.myclass == 'PRIEST' then
							CharacterFrame.EltruismClassResource:SetText(combatText)
						elseif E.myclass == 'DEATHKNIGHT' then
							_, regenRate = _G.GetRuneCooldown(1)
							regenRateText = (format(STAT_RUNE_REGEN_FORMAT, regenRate))
							CharacterFrame.EltruismClassResource:SetText(regenRateText)
						end

						if E.myclass == 'DRUID' or E.myclass == 'MONK' then
							CharacterFrame.EltruismClassResource2:SetText(combatText)
						end

						local number = CharacterStatsPane.statsFramePool:GetNumActive()
						--local number = 13
						if E.db.ElvUI_EltreumUI.dev then
							ElvUI_EltreumUI:Print("Number of stats: "..number)
						end

						--CharacterFrame.EltruismSpeedDesc:SetText("Bewegungsgeschwindigkeit")
						--CharacterFrame.EltruismClassResourceDesc:SetText("Energieregeneration")
						--CharacterFrame.EltruismClassResourceDesc2:SetText("Regeneration")
						CharacterFrame.EltruismExtraStatsFont:ClearAllPoints()
						if number <= 7 then
							CharacterFrame.EltruismExtraStatsFont:SetPoint("TOP", CharacterStatsPane.EnhancementsCategory.Title, "BOTTOM", 0, -90)
						elseif number == 8 then
							CharacterFrame.EltruismExtraStatsFont:SetPoint("TOP", CharacterStatsPane.EnhancementsCategory.Title, "BOTTOM", 0, -100)
						elseif number == 9 then
							CharacterFrame.EltruismExtraStatsFont:SetPoint("TOP", CharacterStatsPane.EnhancementsCategory.Title, "BOTTOM", 0, -110)
						elseif number == 10 then
							CharacterFrame.EltruismExtraStatsFont:SetPoint("TOP", CharacterStatsPane.EnhancementsCategory.Title, "BOTTOM", 0, -120)
						elseif number == 11 then
							CharacterFrame.EltruismExtraStatsFont:SetPoint("TOP", CharacterStatsPane.EnhancementsCategory.Title, "BOTTOM", 0, -130)
						elseif number == 12 then
							CharacterFrame.EltruismExtraStatsFont:SetPoint("TOP", CharacterStatsPane.EnhancementsCategory.Title, "BOTTOM", 0, -140)
						end
						--[[elseif number >= 13 then
							CharacterFrame.EltruismExtraStatsFont:SetPoint("TOP", CharacterStatsPane.EnhancementsCategory.Title, "BOTTOM", 0, -150)
						elseif number == 14 then
							CharacterFrame.EltruismExtraStatsFont:SetPoint("TOP", CharacterStatsPane.EnhancementsCategory.Title, "BOTTOM", 0, -160)
						elseif number > 15 and number < 20 then
							CharacterFrame.EltruismExtraStatsFont:SetPoint("TOP", CharacterStatsPane.EnhancementsCategory.Title, "BOTTOM", 0, -170)
						elseif number >= 20 then
							CharacterFrame.EltruismExtraStatsFont:SetPoint("TOP", CharacterStatsPane.EnhancementsCategory.Title, "BOTTOM", 0, -180)
						end]]

						--numbers
						if number < 13 then
							CharacterFrame.EltruismSpeed:SetAlpha(1)
							CharacterFrame.EltruismClassResource:SetAlpha(1)
							CharacterFrame.EltruismClassResource2:SetAlpha(1)
							CharacterFrame.EltruismSpeedDesc:SetAlpha(1)
							CharacterFrame.EltruismClassResourceDesc:SetAlpha(1)
							CharacterFrame.EltruismClassResourceDesc2:SetAlpha(1)

							CharacterFrame.EltruismSpeed:SetPoint("TOP", CharacterFrame.EltruismExtraStatsFont, "BOTTOM", 60, -10)
							CharacterFrame.EltruismSpeed:SetSize(50,5)
							CharacterFrame.EltruismSpeed:SetJustifyH("RIGHT")
							CharacterFrame.EltruismClassResource:SetPoint("TOP", CharacterFrame.EltruismSpeed, "BOTTOM", 0, -10)
							CharacterFrame.EltruismClassResource:SetSize(50,5)
							CharacterFrame.EltruismClassResource:SetJustifyH("RIGHT")
							CharacterFrame.EltruismClassResource2:SetPoint("TOP", CharacterFrame.EltruismClassResource, "BOTTOM", 0, -10)
							CharacterFrame.EltruismClassResource2:SetJustifyH("RIGHT")
							CharacterFrame.EltruismClassResource2:SetSize(50,5)

							--text
							CharacterFrame.EltruismSpeedDesc:SetPoint("TOP", CharacterFrame.EltruismExtraStatsFont, "BOTTOM", -7, -10)
							CharacterFrame.EltruismSpeedDesc:SetJustifyH("LEFT")
							CharacterFrame.EltruismSpeedDesc:SetSize(150,5)
							CharacterFrame.EltruismClassResourceDesc:SetPoint("TOP", CharacterFrame.EltruismSpeedDesc, "BOTTOM", 0, -10)
							CharacterFrame.EltruismClassResourceDesc:SetJustifyH("LEFT")
							CharacterFrame.EltruismClassResourceDesc:SetSize(150,5)
							CharacterFrame.EltruismClassResourceDesc2:SetPoint("TOP", CharacterFrame.EltruismClassResourceDesc, "BOTTOM", 0, -10)
							CharacterFrame.EltruismClassResourceDesc2:SetJustifyH("LEFT")
							CharacterFrame.EltruismClassResourceDesc2:SetSize(150,5)

							--tooltip
							CharacterFrame.EltruismSpeedDescTooltip:SetPoint("TOP", CharacterFrame.EltruismExtraStatsFont, "BOTTOM", 42, -10)
							CharacterFrame.EltruismClassResourceDescTooltip:SetPoint("TOP", CharacterFrame.EltruismSpeedDesc, "BOTTOM", 0, -10)
							CharacterFrame.EltruismClassResourceDescTooltip2:SetPoint("TOP", CharacterFrame.EltruismClassResourceDesc, "BOTTOM", 0, -10)
						else
							CharacterFrame.EltruismSpeed:SetAlpha(0)
							CharacterFrame.EltruismClassResource:SetAlpha(0)
							CharacterFrame.EltruismClassResource2:SetAlpha(0)
							CharacterFrame.EltruismSpeedDesc:SetAlpha(0)
							CharacterFrame.EltruismClassResourceDesc:SetAlpha(0)
							CharacterFrame.EltruismClassResourceDesc2:SetAlpha(0)
						end
					end
				end
			end)

			--extra stats
			if E.db.ElvUI_EltreumUI.skins.classicarmoryeltruismstats then
				CharacterFrame.EltruismExtraStatsFont:SetText(L["Other"])
				CharacterFrame.EltruismSpeedDesc:SetText(STAT_MOVEMENT_SPEED)
				if not E.db.ElvUI_EltreumUI.skins.statcolors and not E.db.ElvUI_EltreumUI.skins.characterskingradients then
					CharacterFrame.EltruismExtraStatsFont:SetTextColor(1, 1, 1)
				end
			end
			CharacterStatsPane.ItemLevelCategory.Title:SetText(L["Item Level"])
			CharacterStatsPane.AttributesCategory.Title:SetText(STAT_CATEGORY_ATTRIBUTES)
			CharacterStatsPane.EnhancementsCategory.Title:SetText(STAT_CATEGORY_ENHANCEMENTS)

			if not E.db.ElvUI_EltreumUI.skins.characterskingradients then
				CharacterStatsPane.ItemLevelCategory.Title:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
				if E.db.ElvUI_EltreumUI.skins.classicarmoryeltruismstats then
					CharacterFrame.EltruismExtraStatsFont:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
				end
				CharacterStatsPane.AttributesCategory.Title:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
				CharacterStatsPane.EnhancementsCategory.Title:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
			end

			--statusbars
			if ElvUI_EltreumUI:SLCheck("stats") then
				linewidth1 = (( 300 - CharacterStatsPane.ItemLevelCategory.Title:GetStringWidth())/2)
			else
				linewidth1 = (( 193 - CharacterStatsPane.ItemLevelCategory.Title:GetStringWidth())/2)
			end
			CharacterStatsPane.ItemLevelCategory.Title.StatusLine = CreateFrame("StatusBar", "EltruismItemLevelCategoryLine", CharacterStatsPane)
			CharacterStatsPane.ItemLevelCategory.Title.StatusLine:SetMinMaxValues(0,100)
			CharacterStatsPane.ItemLevelCategory.Title.StatusLine:SetValue(100)
			CharacterStatsPane.ItemLevelCategory.Title.StatusLine:SetSize(linewidth1, 4)
			CharacterStatsPane.ItemLevelCategory.Title.StatusLine:SetPoint("RIGHT", CharacterStatsPane.ItemLevelCategory.Title, "LEFT", 0, -1)
			CharacterStatsPane.ItemLevelCategory.Title.StatusLine:SetStatusBarTexture(E.LSM:Fetch("statusbar", "ElvUI Norm1"))
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
				CharacterStatsPane.ItemLevelCategory.Title.StatusLine:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass,true,false))
			else
				CharacterStatsPane.ItemLevelCategory.Title.StatusLine:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass,true,false))
			end
			CharacterStatsPane.ItemLevelCategory.Title.StatusLine2 = CreateFrame("StatusBar", "EltruismItemLevelCategoryLine2", CharacterStatsPane)
			CharacterStatsPane.ItemLevelCategory.Title.StatusLine2:SetMinMaxValues(0,100)
			CharacterStatsPane.ItemLevelCategory.Title.StatusLine2:SetValue(100)
			CharacterStatsPane.ItemLevelCategory.Title.StatusLine2:SetSize(linewidth1, 4)
			CharacterStatsPane.ItemLevelCategory.Title.StatusLine2:SetPoint("LEFT", CharacterStatsPane.ItemLevelCategory.Title, "RIGHT", -1, -1)
			CharacterStatsPane.ItemLevelCategory.Title.StatusLine2:SetStatusBarTexture(E.LSM:Fetch("statusbar", "ElvUI Norm1"))
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
				CharacterStatsPane.ItemLevelCategory.Title.StatusLine2:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass,true,false))
			else
				CharacterStatsPane.ItemLevelCategory.Title.StatusLine2:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass,true,false))
			end

			if ElvUI_EltreumUI:SLCheck("stats") then
				linewidth2 = (( 300 - CharacterStatsPane.AttributesCategory.Title:GetStringWidth())/2)
			else
				linewidth2 = (( 194 - CharacterStatsPane.AttributesCategory.Title:GetStringWidth())/2)
			end
			CharacterStatsPane.AttributesCategory.Title.StatusLine = CreateFrame("StatusBar", "EltruismAttributesCategoryLine", CharacterStatsPane)
			CharacterStatsPane.AttributesCategory.Title.StatusLine:SetMinMaxValues(0,100)
			CharacterStatsPane.AttributesCategory.Title.StatusLine:SetValue(100)
			CharacterStatsPane.AttributesCategory.Title.StatusLine:SetSize(linewidth2, 4)
			CharacterStatsPane.AttributesCategory.Title.StatusLine:SetPoint("RIGHT", CharacterStatsPane.AttributesCategory.Title, "LEFT", 0, -1)
			CharacterStatsPane.AttributesCategory.Title.StatusLine:SetStatusBarTexture(E.LSM:Fetch("statusbar", "ElvUI Norm1"))
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
				CharacterStatsPane.AttributesCategory.Title.StatusLine:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass,true,false))
			else
				CharacterStatsPane.AttributesCategory.Title.StatusLine:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass,true,false))
			end
			CharacterStatsPane.AttributesCategory.Title.StatusLine2 = CreateFrame("StatusBar", "EltruismAttributesCategoryLine2", CharacterStatsPane)
			CharacterStatsPane.AttributesCategory.Title.StatusLine2:SetMinMaxValues(0,100)
			CharacterStatsPane.AttributesCategory.Title.StatusLine2:SetValue(100)
			CharacterStatsPane.AttributesCategory.Title.StatusLine2:SetSize(linewidth2, 4)
			CharacterStatsPane.AttributesCategory.Title.StatusLine2:SetPoint("LEFT", CharacterStatsPane.AttributesCategory.Title, "RIGHT", -1, -1)
			CharacterStatsPane.AttributesCategory.Title.StatusLine2:SetStatusBarTexture(E.LSM:Fetch("statusbar", "ElvUI Norm1"))
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
				CharacterStatsPane.AttributesCategory.Title.StatusLine2:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass,true,false))
			else
				CharacterStatsPane.AttributesCategory.Title.StatusLine2:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass,true,false))
			end

			if ElvUI_EltreumUI:SLCheck("stats") then
				linewidth3 = (( 300 - CharacterStatsPane.EnhancementsCategory.Title:GetStringWidth())/2)
			else
				linewidth3 = (( 193 - CharacterStatsPane.EnhancementsCategory.Title:GetStringWidth())/2)
			end
			CharacterStatsPane.EnhancementsCategory.Title.StatusLine = CreateFrame("StatusBar", "EltruismEnhancementsCategoryLine", CharacterStatsPane)
			CharacterStatsPane.EnhancementsCategory.Title.StatusLine:SetMinMaxValues(0,100)
			CharacterStatsPane.EnhancementsCategory.Title.StatusLine:SetValue(100)
			CharacterStatsPane.EnhancementsCategory.Title.StatusLine:SetSize(linewidth3, 4)
			CharacterStatsPane.EnhancementsCategory.Title.StatusLine:SetPoint("RIGHT", CharacterStatsPane.EnhancementsCategory.Title, "LEFT", 0, -1)
			CharacterStatsPane.EnhancementsCategory.Title.StatusLine:SetStatusBarTexture(E.LSM:Fetch("statusbar", "ElvUI Norm1"))
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
				CharacterStatsPane.EnhancementsCategory.Title.StatusLine:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass,true,false))
			else
				CharacterStatsPane.EnhancementsCategory.Title.StatusLine:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass,true,false))
			end
			CharacterStatsPane.EnhancementsCategory.Title.StatusLine2 = CreateFrame("StatusBar", "EltruismEnhancementsCategoryLine2", CharacterStatsPane)
			CharacterStatsPane.EnhancementsCategory.Title.StatusLine2:SetMinMaxValues(0,100)
			CharacterStatsPane.EnhancementsCategory.Title.StatusLine2:SetValue(100)
			CharacterStatsPane.EnhancementsCategory.Title.StatusLine2:SetSize(linewidth3, 4)
			CharacterStatsPane.EnhancementsCategory.Title.StatusLine2:SetPoint("LEFT", CharacterStatsPane.EnhancementsCategory.Title, "RIGHT", -1, -1)
			CharacterStatsPane.EnhancementsCategory.Title.StatusLine2:SetStatusBarTexture(E.LSM:Fetch("statusbar", "ElvUI Norm1"))
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
				CharacterStatsPane.EnhancementsCategory.Title.StatusLine2:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass,true,false))
			else
				CharacterStatsPane.EnhancementsCategory.Title.StatusLine2:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass,true,false))
			end

			if E.db.ElvUI_EltreumUI.skins.classicarmoryeltruismstats then
				linewidth4 = (( 193 - CharacterFrame.EltruismExtraStatsFont:GetStringWidth())/2)
				CharacterFrame.EltruismExtraStats:SetSize(linewidth4, 4)
				CharacterFrame.EltruismExtraStats:SetPoint("RIGHT", CharacterFrame.EltruismExtraStatsFont, "LEFT", 0, -1)
				CharacterFrame.EltruismExtraStats:SetStatusBarTexture(E.LSM:Fetch("statusbar", "ElvUI Norm1"))
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
					CharacterFrame.EltruismExtraStats:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass,true,false))
				else
					CharacterFrame.EltruismExtraStats:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass,true,false))
				end
				CharacterFrame.EltruismExtraStats2:SetSize(linewidth4, 4)
				CharacterFrame.EltruismExtraStats2:SetPoint("LEFT", CharacterFrame.EltruismExtraStatsFont, "RIGHT", 0, -1)
				CharacterFrame.EltruismExtraStats2:SetStatusBarTexture(E.LSM:Fetch("statusbar", "ElvUI Norm1"))
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
					CharacterFrame.EltruismExtraStats2:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass,true,false))
				else
					CharacterFrame.EltruismExtraStats2:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass,true,false))
				end
			end

			if ElvUI_EltreumUI:SLCheck("stats") then
				if E.db.ElvUI_EltreumUI.skins.classicarmoryeltruismstats then
					CharacterFrame.EltruismExtraStatsFont:Hide()
					CharacterFrame.EltruismExtraStats:Hide()
					CharacterFrame.EltruismExtraStats2:Hide()

					CharacterFrame.EltruismSpeed:Hide()
					CharacterFrame.EltruismSpeedDesc:Hide()
					CharacterFrame.EltruismSpeedDescTooltip:Hide()

					CharacterFrame.EltruismClassResource:Hide()
					CharacterFrame.EltruismClassResourceDesc:Hide()
					CharacterFrame.EltruismClassResourceDescTooltip:Hide()

					CharacterFrame.EltruismClassResource2:Hide()
					CharacterFrame.EltruismClassResourceDesc2:Hide()
					CharacterFrame.EltruismClassResourceDescTooltip2:Hide()
				end

				CharacterStatsPane.OffenseCategory.Title.StatusLine = CreateFrame("StatusBar", "EltruismEnhancementsCategoryLine", CharacterStatsPane)
				CharacterStatsPane.OffenseCategory.Title.StatusLine:SetMinMaxValues(0,100)
				CharacterStatsPane.OffenseCategory.Title.StatusLine:SetValue(100)
				CharacterStatsPane.OffenseCategory.Title.StatusLine:SetSize((( 300 - CharacterStatsPane.OffenseCategory.Title:GetStringWidth())/2), 4)
				CharacterStatsPane.OffenseCategory.Title.StatusLine:SetPoint("RIGHT", CharacterStatsPane.OffenseCategory.Title, "LEFT", 0, -1)
				CharacterStatsPane.OffenseCategory.Title.StatusLine:SetStatusBarTexture(E.LSM:Fetch("statusbar", "ElvUI Norm1"))
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
					CharacterStatsPane.OffenseCategory.Title.StatusLine:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass,true,false))
				else
					CharacterStatsPane.OffenseCategory.Title.StatusLine:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass,true,false))
				end
				CharacterStatsPane.OffenseCategory.Title.StatusLine2 = CreateFrame("StatusBar", "EltruismEnhancementsCategoryLine2", CharacterStatsPane)
				CharacterStatsPane.OffenseCategory.Title.StatusLine2:SetMinMaxValues(0,100)
				CharacterStatsPane.OffenseCategory.Title.StatusLine2:SetValue(100)
				CharacterStatsPane.OffenseCategory.Title.StatusLine2:SetSize((( 300 - CharacterStatsPane.OffenseCategory.Title:GetStringWidth())/2), 4)
				CharacterStatsPane.OffenseCategory.Title.StatusLine2:SetPoint("LEFT", CharacterStatsPane.OffenseCategory.Title, "RIGHT", -1, -1)
				CharacterStatsPane.OffenseCategory.Title.StatusLine2:SetStatusBarTexture(E.LSM:Fetch("statusbar", "ElvUI Norm1"))
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
					CharacterStatsPane.OffenseCategory.Title.StatusLine2:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass,true,false))
				else
					CharacterStatsPane.OffenseCategory.Title.StatusLine2:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass,true,false))
				end
			end
		end

		--add gradient text to some texts
		if E.db.ElvUI_EltreumUI.skins.characterskingradients then
			if E.db.ElvUI_EltreumUI.skins.classicarmory and E.db.ElvUI_EltreumUI.skins.classicarmoryeltruismstats then
				CharacterFrame.EltruismExtraStatsFont:SetText(ElvUI_EltreumUI:GradientName(L["Other"], E.myclass))
			end
			--CharacterStatsPane.ItemLevelCategory.Title:SetText("Gegenstandsstufe")
			CharacterStatsPane.ItemLevelCategory.Title:SetText(ElvUI_EltreumUI:GradientName(L["Item Level"], E.myclass))
			CharacterStatsPane.AttributesCategory.Title:SetText(ElvUI_EltreumUI:GradientName(STAT_CATEGORY_ATTRIBUTES, E.myclass))
			CharacterStatsPane.EnhancementsCategory.Title:SetText(ElvUI_EltreumUI:GradientName(STAT_CATEGORY_ENHANCEMENTS, E.myclass))
		end

		--add gradient text to stats
		if E.db.ElvUI_EltreumUI.skins.statcolors then
			hooksecurefunc('PaperDollFrame_SetLabelAndText', function(statFrame)
				if ( statFrame.Label ) then
					local text = statFrame.Label:GetText()
					if not ElvUI_EltreumUI:SLCheck("stats") then
						statFrame.Label:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
					end
					if not statFrame.Label:GetText():match("|r") then
						statFrame.Label:SetText(ElvUI_EltreumUI:GradientName(text, E.myclass))
					end
					if not ElvUI_EltreumUI:SLCheck("stats") and statFrame.Value then
						statFrame.Value:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
					end
				end
				if E.db.ElvUI_EltreumUI.skins.classicarmory and E.db.ElvUI_EltreumUI.skins.classicarmoryeltruismstats then
					if not ElvUI_EltreumUI:SLCheck("stats") then
						CharacterFrame.EltruismSpeedDesc:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
						if CharacterFrame.EltruismClassResourceDesc:GetText() ~= nil and not CharacterFrame.EltruismClassResourceDesc:GetText():match("|r") then
							CharacterFrame.EltruismClassResourceDesc:SetText(ElvUI_EltreumUI:GradientName(CharacterFrame.EltruismClassResourceDesc:GetText(), E.myclass))
						end
						if CharacterFrame.EltruismClassResourceDesc2:GetText() ~= nil and not CharacterFrame.EltruismClassResourceDesc2:GetText():match("|r") then
							CharacterFrame.EltruismClassResourceDesc2:SetText(ElvUI_EltreumUI:GradientName(CharacterFrame.EltruismClassResourceDesc2:GetText(), E.myclass))
						end
					end
					if not CharacterFrame.EltruismSpeedDesc:GetText():match("|r") then
						CharacterFrame.EltruismSpeedDesc:SetText(ElvUI_EltreumUI:GradientName(STAT_MOVEMENT_SPEED, E.myclass))
					end
				end
				if ElvUI_EltreumUI:SLCheck("stats") then
					if not CharacterStatsPane.OffenseCategory.Title:GetText():match("|r") then
						CharacterStatsPane.OffenseCategory.Title:SetText(ElvUI_EltreumUI:GradientName(CharacterStatsPane.OffenseCategory.Title:GetText(), E.myclass))
					end
					if not CharacterStatsPane.DefenseCategory.Title:GetText():match("|r") then
						CharacterStatsPane.DefenseCategory.Title:SetText(ElvUI_EltreumUI:GradientName(CharacterStatsPane.DefenseCategory.Title:GetText(), E.myclass))
					end
				end
			end)
		end

		-- add and expand art
		if E.db.ElvUI_EltreumUI.skins.expandarmorybg then
			if ElvUI_EltreumUI:SLCheck('char') then
				if _G.PaperDollFrame.SLE_Armory_BG then
					if _G.PaperDollFrame.SLE_Armory_BG:IsVisible() then
						_G.PaperDollFrame.SLE_Armory_BG:Hide()
					end
				end
			end

			--hide other bgs so one can be streched like the talents for tbc/classic
			CharacterModelScene.BackgroundTopRight:Hide()
			CharacterModelScene.BackgroundBotLeft:Hide()
			CharacterModelScene.BackgroundBotRight:Hide()
			CharacterModelScene.BackgroundTopLeft:SetAllPoints(CharacterModelScene)
			_G.CharacterModelFrameBackgroundOverlay:SetAllPoints(CharacterModelScene)

			--add bg texture
			CharacterFrameBackgroundTextureFader:SetAllPoints(CharacterFrame)
			CharacterFrameBackgroundTextureFader:SetParent(CharacterFrame)
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
			CharacterFrameBackgroundTexture:SetAllPoints(CharacterFrame)
			CharacterFrameBackgroundTexture:SetParent(CharacterFrame)
			CharacterFrameBackgroundTexture:SetDrawLayer("ARTWORK",6)

			if _G.CharacterModelScene then
				_G.CharacterModelScene.backdrop:Hide()
				_G.CharacterModelFrameBackgroundTopLeft:Hide()
				_G.CharacterModelFrameBackgroundOverlay:Hide()
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
		end

		--fixing the background with expanded panel but no expanded art
		if E.db.ElvUI_EltreumUI.skins.classicarmory and not E.db.ElvUI_EltreumUI.skins.expandarmorybg then
			_G.CharacterModelFrameBackgroundTopLeft:ClearAllPoints()
			_G.CharacterModelFrameBackgroundTopRight:ClearAllPoints()
			_G.CharacterModelFrameBackgroundBotLeft:ClearAllPoints()
			_G.CharacterModelFrameBackgroundBotRight:ClearAllPoints()
			_G.CharacterModelFrameBackgroundTopLeft:SetPoint("TOPLEFT", _G.CharacterModelScene, "TOPLEFT",0,0)
			_G.CharacterModelFrameBackgroundTopLeft:SetWidth(404)
			_G.CharacterModelFrameBackgroundTopLeft:SetHeight(309)
			_G.CharacterModelFrameBackgroundBotLeft:SetPoint("BOTTOMLEFT", _G.CharacterModelScene, "BOTTOMLEFT", 0, -54)
			_G.CharacterModelFrameBackgroundBotLeft:SetWidth(404)
			_G.CharacterModelFrameBackgroundTopRight:SetPoint("TOPRIGHT", _G.CharacterModelScene, "TOPRIGHT",0,0)
			_G.CharacterModelFrameBackgroundTopRight:SetWidth(60)
			_G.CharacterModelFrameBackgroundTopRight:SetHeight(309)
			_G.CharacterModelFrameBackgroundBotRight:SetPoint("BOTTOMRIGHT", _G.CharacterModelScene, "BOTTOMRIGHT",0,-54)
			_G.CharacterModelFrameBackgroundBotRight:SetWidth(60)
		end

		--add class crest
		if E.db.ElvUI_EltreumUI.skins.expandarmorycrest then
			ClassCrestFrame:SetSize(256, 256)
			ClassCrestFrame:SetPoint("CENTER", CharacterModelScene, 0, 50)
			ClassCrestFrame:SetParent(CharacterFrame)

			if E.db.ElvUI_EltreumUI.skins.armorycrestversion == 1 then
				if E.myclass == "EVOKER" then
					ClassCrestFrameTexture:SetTexture(ElvUI_EltreumUI:GetClassCrest())
				else
					ClassCrestFrameTexture:SetAtlas(ElvUI_EltreumUI:GetClassCrest(), true)
				end
			else
				ClassCrestFrameTexture:SetTexture(ElvUI_EltreumUI:GetClassCrest())
			end
			ClassCrestFrameTexture:SetAllPoints(ClassCrestFrame)
			ClassCrestFrameTexture:SetDrawLayer("BACKGROUND")
		end

		hooksecurefunc("CharacterFrame_Collapse", function()
			if PaperDollFrame:IsVisible() then
				_G.CharacterFrameTitleText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armorynamefontsize - 6, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				if E.db.ElvUI_EltreumUI.skins.classicarmory then
					CharacterFrame:SetWidth(505)
					E:Delay(0, function()
						local actor = CharacterModelScene:GetPlayerActor()
						if actor then
							actor:SetPosition(0, 0, 0)
							actor:SetPosition(E.db.ElvUI_EltreumUI.skins.charactermodelcam.zoomretail, E.db.ElvUI_EltreumUI.skins.charactermodelcam.xretail, E.db.ElvUI_EltreumUI.skins.charactermodelcam.yretail)
						end
					end)
					if E.db.ElvUI_EltreumUI.skins.ilvltextcolordifferenceenable then
						if not ElvUI_EltreumUI:SLCheck("stats") then
							local bagilvl, equippedilvl = GetAverageItemLevel()
							if bagilvl ~= equippedilvl then --as suggested by dlarge, inspired by SLE
								local r, g, b
								if E.db.ElvUI_EltreumUI.skins.ilvltextcolordifferencecustom then
									r, g, b = E:ColorGradient((equippedilvl / bagilvl), E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.badR, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.badG, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.badB, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.mediumR, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.mediumG, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.mediumB, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.goodR, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.goodG, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.goodB)
								else
									r, g, b = E:ColorGradient((equippedilvl / bagilvl), P.ElvUI_EltreumUI.skins.ilvltextcolordifference.badR, P.ElvUI_EltreumUI.skins.ilvltextcolordifference.badG, P.ElvUI_EltreumUI.skins.ilvltextcolordifference.badB, P.ElvUI_EltreumUI.skins.ilvltextcolordifference.mediumR, P.ElvUI_EltreumUI.skins.ilvltextcolordifference.mediumG, P.ElvUI_EltreumUI.skins.ilvltextcolordifference.mediumB, P.ElvUI_EltreumUI.skins.ilvltextcolordifference.goodR, P.ElvUI_EltreumUI.skins.ilvltextcolordifference.goodG, P.ElvUI_EltreumUI.skins.ilvltextcolordifference.goodB)
								end
								CharacterFrame.ItemLevelText:SetText(E:RGBToHex(r, g, b)..((math.floor(equippedilvl*100))/100).."|r ("..((math.floor(bagilvl*100))/100)..")|r")
							end
						end
					end
				end
				if E.db.ElvUI_EltreumUI.skins.expandarmorybg then
					if E.db.ElvUI_EltreumUI.skins.armorybgtype == "CUSTOM" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RACE" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RAGNAROS" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "SPACECLOUD" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RAVNYR" then
						CharacterFrameBackgroundTexture:SetTexCoord(0, 0.716, 0, 1)
					elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "CLASS" then
						CharacterFrameBackgroundTexture:SetTexCoord(0, 0.87, 0, 0.60)
					end
					if ElvUI_EltreumUI:SLCheck('char') then
						if _G.PaperDollFrame.SLE_Armory_BG then
							if _G.PaperDollFrame.SLE_Armory_BG:IsVisible() then
								_G.PaperDollFrame.SLE_Armory_BG:Hide()
							end
						end
					end
					_G.CharacterModelFrameBackgroundOverlay:Hide()
				end
			else
				if E.db.ElvUI_EltreumUI.skins.expandarmorybg then
					if E.db.ElvUI_EltreumUI.skins.armorybgtype == "CUSTOM" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RACE" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RAGNAROS" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "SPACECLOUD" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RAVNYR" then
						CharacterFrameBackgroundTexture:SetTexCoord(0, 0.346, 0, 1)
					elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "CLASS" then
						CharacterFrameBackgroundTexture:SetTexCoord(0, 0.87, 0, 0.60)
					end
				end
			end
		end)

		hooksecurefunc("CharacterFrame_Expand", function()
			if PaperDollFrame:IsVisible() then
				_G.CharacterFrameTitleText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armorynamefontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				if E.db.ElvUI_EltreumUI.skins.classicarmory then
					if E.db.ElvUI_EltreumUI.skins.ilvltextcolordifferenceenable then
						if not ElvUI_EltreumUI:SLCheck("stats") then
							local bagilvl, equippedilvl = GetAverageItemLevel()
							if bagilvl ~= equippedilvl then --as suggested by dlarge, inspired by SLE
								local r, g, b
								if E.db.ElvUI_EltreumUI.skins.ilvltextcolordifferencecustom then
									r, g, b = E:ColorGradient((equippedilvl / bagilvl), E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.badR, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.badG, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.badB, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.mediumR, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.mediumG, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.mediumB, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.goodR, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.goodG, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.goodB)
								else
									r, g, b = E:ColorGradient((equippedilvl / bagilvl), P.ElvUI_EltreumUI.skins.ilvltextcolordifference.badR, P.ElvUI_EltreumUI.skins.ilvltextcolordifference.badG, P.ElvUI_EltreumUI.skins.ilvltextcolordifference.badB, P.ElvUI_EltreumUI.skins.ilvltextcolordifference.mediumR, P.ElvUI_EltreumUI.skins.ilvltextcolordifference.mediumG, P.ElvUI_EltreumUI.skins.ilvltextcolordifference.mediumB, P.ElvUI_EltreumUI.skins.ilvltextcolordifference.goodR, P.ElvUI_EltreumUI.skins.ilvltextcolordifference.goodG, P.ElvUI_EltreumUI.skins.ilvltextcolordifference.goodB)
								end
								CharacterFrame.ItemLevelText:SetText(E:RGBToHex(r, g, b)..((math.floor(equippedilvl*100))/100).."|r ("..((math.floor(bagilvl*100))/100)..")|r")
							end
						end
					end
					CharacterFrame:SetWidth(700)
					E:Delay(0, function()
						local actor = CharacterModelScene:GetPlayerActor()
						if actor then
							actor:SetPosition(0, 0, 0)
							actor:SetPosition(E.db.ElvUI_EltreumUI.skins.charactermodelcam.zoomretail, E.db.ElvUI_EltreumUI.skins.charactermodelcam.xretail, E.db.ElvUI_EltreumUI.skins.charactermodelcam.yretail)
						end
					end)
				end
				if E.db.ElvUI_EltreumUI.skins.expandarmorybg then
					if E.db.ElvUI_EltreumUI.skins.armorybgtype == "CUSTOM" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RACE" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RAGNAROS" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "SPACECLOUD" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RAVNYR" then
						CharacterFrameBackgroundTexture:SetTexCoord(0, 0.716, 0, 1)
					elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "CLASS" then
						CharacterFrameBackgroundTexture:SetTexCoord(0, 0.87, 0, 0.60)
					end
					_G.CharacterModelFrameBackgroundOverlay:Hide()
					if ElvUI_EltreumUI:SLCheck('char') then
						if _G.PaperDollFrame.SLE_Armory_BG then
							if _G.PaperDollFrame.SLE_Armory_BG:IsVisible() then
								_G.PaperDollFrame.SLE_Armory_BG:Hide()
							end
						end
					end
				end
			else
				if E.db.ElvUI_EltreumUI.skins.expandarmorybg then
					if E.db.ElvUI_EltreumUI.skins.armorybgtype == "CUSTOM" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RACE" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RAGNAROS" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "SPACECLOUD" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RAVNYR" then
						CharacterFrameBackgroundTexture:SetTexCoord(0, 0.346, 0, 1)
					elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "CLASS" then
						CharacterFrameBackgroundTexture:SetTexCoord(0, 0.87, 0, 0.60)
					end
				end
			end
		end)
	else

		--gradient colors to categories other
		if E.db.ElvUI_EltreumUI.skins.characterskingradients then
			CharacterFrame.Text:SetText(ElvUI_EltreumUI:GradientName(L["Item Level"], E.myclass)) ---ilvl
			CharacterFrame.Text3:SetText(ElvUI_EltreumUI:GradientName(L["Attributes"], E.myclass)) ---attributes
			CharacterFrame.Text4:SetText(ElvUI_EltreumUI:GradientName(L["Specialization"], E.myclass)) ---specialization
		end

		--color stats with a class gradient
		local function SetStatGradient()
			if E.Wrath then
				for i = 1, 6 do
					if _G["PlayerStatFrameLeft"..i.."Label"] then
						_G["PlayerStatFrameLeft"..i.."Label"]:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
						if _G["PlayerStatFrameLeft"..i.."Label"]:GetText() ~= nil and not _G["PlayerStatFrameLeft"..i.."Label"]:GetText():match("|r") then
							if E.db.ElvUI_EltreumUI.skins.characterskingradients then
								_G["PlayerStatFrameLeft"..i.."Label"]:SetText(ElvUI_EltreumUI:GradientName(_G["PlayerStatFrameLeft"..i.."Label"]:GetText(), E.myclass))
							else
								_G["PlayerStatFrameLeft"..i.."Label"]:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
						end
					end
					if _G["PlayerStatFrameRight"..i.."Label"] then
						_G["PlayerStatFrameRight"..i.."Label"]:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
						if _G["PlayerStatFrameRight"..i.."Label"]:GetText() ~= nil and not _G["PlayerStatFrameRight"..i.."Label"]:GetText():match("|r") then
							if E.db.ElvUI_EltreumUI.skins.characterskingradients then
								_G["PlayerStatFrameRight"..i.."Label"]:SetText(ElvUI_EltreumUI:GradientName(_G["PlayerStatFrameRight"..i.."Label"]:GetText(), E.myclass))
							else
								_G["PlayerStatFrameRight"..i.."Label"]:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
						end
					end
				end
			elseif E.Classic then
				for i = 1, 5 do
					if _G["CharacterStatFrame"..i.."Label"] then
						_G["CharacterStatFrame"..i.."Label"]:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
						if _G["CharacterStatFrame"..i.."Label"]:GetText() ~= nil and not _G["CharacterStatFrame"..i.."Label"]:GetText():match("|r") then
							if E.db.ElvUI_EltreumUI.skins.characterskingradients then
								_G["CharacterStatFrame"..i.."Label"]:SetText(ElvUI_EltreumUI:GradientName(_G["CharacterStatFrame"..i.."Label"]:GetText(), E.myclass))
							else
								_G["CharacterStatFrame"..i.."Label"]:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
						end
					end
				end
				_G.CharacterArmorFrameLabel:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				if not _G.CharacterArmorFrameLabel:GetText():match("|r") then
					if E.db.ElvUI_EltreumUI.skins.characterskingradients then
						_G.CharacterArmorFrameLabel:SetText(ElvUI_EltreumUI:GradientName(_G.CharacterArmorFrameLabel:GetText(), E.myclass))
					else
						_G.CharacterArmorFrameLabel:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
					end
				end
				_G.CharacterAttackFrameLabel:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				if not _G.CharacterAttackFrameLabel:GetText():match("|r") then
					if E.db.ElvUI_EltreumUI.skins.characterskingradients then
						_G.CharacterAttackFrameLabel:SetText(ElvUI_EltreumUI:GradientName(_G.CharacterAttackFrameLabel:GetText(), E.myclass))
					else
						_G.CharacterAttackFrameLabel:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
					end
				end
				_G.CharacterAttackPowerFrameLabel:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				if not _G.CharacterAttackPowerFrameLabel:GetText():match("|r") then
					if E.db.ElvUI_EltreumUI.skins.characterskingradients then
						_G.CharacterAttackPowerFrameLabel:SetText(ElvUI_EltreumUI:GradientName(_G.CharacterAttackPowerFrameLabel:GetText(), E.myclass))
					else
						_G.CharacterAttackPowerFrameLabel:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
					end
				end
				_G.CharacterDamageFrameLabel:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				if not _G.CharacterDamageFrameLabel:GetText():match("|r") then
					if E.db.ElvUI_EltreumUI.skins.characterskingradients then
						_G.CharacterDamageFrameLabel:SetText(ElvUI_EltreumUI:GradientName(_G.CharacterDamageFrameLabel:GetText(), E.myclass))
					else
						_G.CharacterDamageFrameLabel:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
					end
				end
				_G.CharacterRangedAttackFrameLabel:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				if not _G.CharacterRangedAttackFrameLabel:GetText():match("|r") then
					if E.db.ElvUI_EltreumUI.skins.characterskingradients then
						_G.CharacterRangedAttackFrameLabel:SetText(ElvUI_EltreumUI:GradientName(_G.CharacterRangedAttackFrameLabel:GetText(), E.myclass))
					else
						_G.CharacterRangedAttackFrameLabel:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
					end
				end
				_G.CharacterRangedAttackPowerFrameLabel:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				if not _G.CharacterRangedAttackPowerFrameLabel:GetText():match("|r") then
					if E.db.ElvUI_EltreumUI.skins.characterskingradients then
						_G.CharacterRangedAttackPowerFrameLabel:SetText(ElvUI_EltreumUI:GradientName(_G.CharacterRangedAttackPowerFrameLabel:GetText(), E.myclass))
					else
						_G.CharacterRangedAttackPowerFrameLabel:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
					end
				end
				_G.CharacterRangedDamageFrameLabel:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				if not _G.CharacterRangedDamageFrameLabel:GetText():match("|r") then
					if E.db.ElvUI_EltreumUI.skins.characterskingradients then
						_G.CharacterRangedDamageFrameLabel:SetText(ElvUI_EltreumUI:GradientName(_G.CharacterRangedDamageFrameLabel:GetText(), E.myclass))
					else
						_G.CharacterRangedDamageFrameLabel:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
					end
				end
			end
		end

		--or just set font size
		local function SetFontSize()
			if E.Wrath then
				for i = 1, 6 do
					if _G["PlayerStatFrameLeft"..i.."Label"] then
						_G["PlayerStatFrameLeft"..i.."Label"]:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
					end
					if _G["PlayerStatFrameRight"..i.."Label"] then
						_G["PlayerStatFrameRight"..i.."Label"]:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
					end
				end
			elseif E.Classic then
				for i = 1, 5 do
					if _G["CharacterStatFrame"..i.."Label"] then
						_G["CharacterStatFrame"..i.."Label"]:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
					end
				end
				_G.CharacterArmorFrameLabel:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				_G.CharacterAttackFrameLabel:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				_G.CharacterAttackPowerFrameLabel:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				_G.CharacterDamageFrameLabel:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				_G.CharacterRangedAttackFrameLabel:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				_G.CharacterRangedAttackPowerFrameLabel:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				_G.CharacterRangedDamageFrameLabel:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			end
		end

		if E.db.ElvUI_EltreumUI.skins.statcolors or E.db.ElvUI_EltreumUI.skins.characterskingradients then
			--set hooks
			if E.Wrath then
				hooksecurefunc('PlayerStatFrameLeftDropDown_OnClick', SetStatGradient)
				hooksecurefunc('PlayerStatFrameRightDropDown_OnClick', SetStatGradient)
			end
			hooksecurefunc("PaperDollFrame_UpdateStats", SetStatGradient)
		else
			if E.Wrath then
				hooksecurefunc('PlayerStatFrameLeftDropDown_OnClick', SetFontSize)
				hooksecurefunc('PlayerStatFrameRightDropDown_OnClick', SetFontSize)
			end
			hooksecurefunc("PaperDollFrame_UpdateStats", SetFontSize)
		end

		--add class crest
		if E.db.ElvUI_EltreumUI.skins.expandarmorycrest then
			ClassCrestFrame:SetSize(150, 150)
			ClassCrestFrame:SetPoint("CENTER", CharacterModelFrame, 0 , 50)
			ClassCrestFrame:SetParent(CharacterFrame)
			ClassCrestFrame:SetFrameLevel(1)
			if E.db.ElvUI_EltreumUI.skins.armorycrestversion == 1 then
				ClassCrestFrameTexture:SetAtlas(ElvUI_EltreumUI:GetClassCrest(), true)
			else
				ClassCrestFrameTexture:SetTexture(ElvUI_EltreumUI:GetClassCrest())
			end
			ClassCrestFrameTexture:SetAllPoints(ClassCrestFrame)
			ClassCrestFrameTexture:SetDrawLayer("BACKGROUND", -4)
		end

		--fix buttons
		if _G.PetPaperDollCloseButton then
			_G.PetPaperDollCloseButton:Hide()
		end
		if _G.SkillFrameCancelButton then
			_G.SkillFrameCancelButton:Hide()
		end

		if _G.CompanionModelFrame then
			--_G.CompanionModelFrame:SetPosition(0, 0, 0)
			_G.CompanionModelFrame:ClearAllPoints()
			_G.CompanionModelFrame:SetPoint("CENTER", _G.PetPaperDollFrame, "CENTER", 0, 90)
		end

		--add background from artifact weapon
		if E.db.ElvUI_EltreumUI.skins.expandarmorybg then
			--add bg texture
			CharacterFrameBackgroundTextureFader:SetAllPoints(CharacterFrame.backdrop)
			CharacterFrameBackgroundTextureFader:SetParent(CharacterFrame)
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
			CharacterFrameBackgroundTexture:SetAllPoints(CharacterFrame.backdrop)
			--CharacterFrameBackgroundTexture:SetDrawLayer("ARTWORK",1)
			CharacterFrameBackgroundTexture:SetDrawLayer("BACKGROUND",-5)
		end

		--expand classic armory
		if E.db.ElvUI_EltreumUI.skins.classicarmory then

			if E.Wrath then --skin the gear manager button
				if _G["GearManagerToggleButton"] then
					_G["GearManagerToggleButton"]:GetNormalTexture():SetTexCoord(0.20, 0.80, 0.16, 0.85)
					_G["GearManagerToggleButton"]:GetPushedTexture():SetTexCoord(0.20, 0.80, 0.16, 0.85)
					_G["GearManagerToggleButton"]:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
				end
			end

			if not E.db.ElvUI_EltreumUI.skins.characterskingradients then
				CharacterFrame.Text:SetText(L["Item Level"]) ---ilvl
				CharacterFrame.Text:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
				CharacterFrame.Text3:SetText(L["Attributes"]) ---attributes
				CharacterFrame.Text3:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
				CharacterFrame.Text4:SetText(L["Specialization"]) ---specialization
				CharacterFrame.Text4:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
			end

			--set ilvl on char panel
			hooksecurefunc("ToggleCharacter", function()
				CharacterFrame.Text2:SetText((math.floor(ElvUI_EltreumUI:GetUnitItemLevel("player")*100))/100)
			end)

			--set the tabs
			if E.db.ElvUI_EltreumUI.skins.classicarmoryautostats then
				local _, _, spent1 = _G.GetTalentTabInfo(1)
				local _, _, spent2 = _G.GetTalentTabInfo(2)
				local _, _, spent3 = _G.GetTalentTabInfo(3)
				SetCVar("playerStatLeftDropdown", "PLAYERSTAT_BASE_STATS")
				if E.myclass == 'WARLOCK' or E.myclass == 'MAGE' or E.myclass == 'PRIEST' then
					SetCVar("playerStatRightDropdown", "PLAYERSTAT_SPELL_COMBAT")
				elseif E.myclass == 'SHAMAN' then
					if spent2 > spent1 and spent2 > spent3 then
						SetCVar("playerStatRightDropdown", "PLAYERSTAT_MELEE_COMBAT")
					else
						SetCVar("playerStatRightDropdown", "PLAYERSTAT_SPELL_COMBAT")
					end
				elseif E.myclass == 'HUNTER' then
					SetCVar("playerStatRightDropdown", "PLAYERSTAT_RANGED_COMBAT")
				elseif E.myclass == 'DRUID' then
					if spent2 > spent3 and spent2 > spent1 then
						SetCVar("playerStatRightDropdown", "PLAYERSTAT_MELEE_COMBAT")
					else
						SetCVar("playerStatRightDropdown", "PLAYERSTAT_SPELL_COMBAT")
					end
				elseif E.myclass == 'WARRIOR' or E.myclass == 'ROGUE' then
					SetCVar("playerStatRightDropdown", "PLAYERSTAT_MELEE_COMBAT")
				elseif E.myclass == 'PALADIN' then
					if spent1 > spent3 and spent1 > spent2 then
						SetCVar("playerStatRightDropdown", "PLAYERSTAT_SPELL_COMBAT")
					else
						SetCVar("playerStatRightDropdown", "PLAYERSTAT_MELEE_COMBAT")
					end
				elseif E.myclass == 'DEATHKNIGHT' then
					SetCVar("playerStatRightDropdown", "PLAYERSTAT_MELEE_COMBAT")
				end
			end

			if E.Wrath then
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
				local point, relativeTo, relativePoint, xOfs = _G.ReputationListScrollFrameScrollBar:GetPoint()
				_G.ReputationListScrollFrameScrollBarScrollDownButton:SetPoint(point, relativeTo, relativePoint, xOfs-1, -330)
			end

			--change the size based on if paperdoll is hidden
			--CharacterFrame:SetSize(700, 505)

			--pre set the zoom
			CharacterModelFrame:SetPosition(0, 0, 0) -- zoom, x, y
			CharacterModelFrame:SetPosition(E.db.ElvUI_EltreumUI.skins.charactermodelcam.zoomclassic, E.db.ElvUI_EltreumUI.skins.charactermodelcam.xclassic, E.db.ElvUI_EltreumUI.skins.charactermodelcam.yclassic)

			CharacterFrame.Text6:SetSize(418, 72)
			CharacterFrame.Text6:SetPoint("TOP", CharacterFrame, "TOP", 0, -50)
			CharacterFrame.Text6:SetParent(CharacterFrame)
			CharacterFrame.Text6:SetTextColor(1, 0, 0, 1)
			CharacterFrame.Text6:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize + 6, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			CharacterFrame.Text6:SetText("|cffFF0000"..ERR_NOT_IN_COMBAT.."|r")

			--fix frame size depending on tab
			local function ResizeCharacterFrame()
				if InCombatLockdown() then
					UIErrorsFrame:AddMessage(ERR_NOT_IN_COMBAT, 1.0, 0.2, 0.2, 1.0)
					local width = CharacterFrame:GetWidth()
					if math.floor(width) ~= 700 then
						CharacterFrame.Text6:Show()
						CharacterFrame.Text4:Hide()
						CharacterFrame.StatusLine4:Hide()
						CharacterFrame.StatusLine2:Hide()

						--hide quality texture
						for _, InvSlotName in pairs(InvSlotIdTable) do
							if _G["EltruismItemQuality"..InvSlotName] then
								_G["EltruismItemQuality"..InvSlotName]:Hide()
							end
						end
						CharacterNameText:ClearAllPoints()
						CharacterNameText:SetPoint('TOP', CharacterModelFrame, 0, 40)

						if _G.PlayerTitleDropDown then
							_G.PlayerTitleDropDown:SetPoint('TOP', CharacterNameText, 0, -40)
						end
						--better zoom
						CharacterModelFrame:SetSize(220,350)
						CharacterModelFrame:ClearAllPoints()
						CharacterModelFrame:SetPoint("CENTER", CharacterFrame,"CENTER", 0, 15)
						CharacterModelFrame:SetPosition(0, 0, 0)
						CharacterModelFrame:SetPosition(E.db.ElvUI_EltreumUI.skins.charactermodelcam.zoomclassic, E.db.ElvUI_EltreumUI.skins.charactermodelcam.xclassic, E.db.ElvUI_EltreumUI.skins.charactermodelcam.yclassic)

						if E.db.ElvUI_EltreumUI.skins.armorybgtype == "CUSTOM" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RACE" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RAGNAROS" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "SPACECLOUD" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RAVNYR" then
							CharacterFrameBackgroundTexture:SetTexCoord(0, 0.39, 0, 1)
						elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "CLASS" then
							CharacterFrameBackgroundTexture:SetTexCoord(0, 0.87, 0, 0.60)
						end
					else
						CharacterFrame.Text6:Hide()
						CharacterFrame.Text4:Show()
						CharacterFrame.StatusLine4:Show()
						CharacterFrame.StatusLine2:Show()
						if E.db.ElvUI_EltreumUI.skins.armorybgtype == "CUSTOM" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RACE" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RAGNAROS" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "SPACECLOUD" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RAVNYR" then
							CharacterFrameBackgroundTexture:SetTexCoord(0, 0.716, 0, 1)
						elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "CLASS" then
							CharacterFrameBackgroundTexture:SetTexCoord(0, 0.87, 0, 0.60)
						end
					end
					if PaperDollFrame:IsVisible() then
						ClassCrestFrame:SetPoint("CENTER", CharacterModelFrame, 0 , 50)
					end
				else
					CharacterFrame.Text4:Show()
					CharacterFrame.StatusLine4:Show()
					CharacterFrame.StatusLine2:Show()
					CharacterFrame.Text6:Hide()
					--show quality texture
					for _, InvSlotName in pairs(InvSlotIdTable) do
						if _G["EltruismItemQuality"..InvSlotName] then
							_G["EltruismItemQuality"..InvSlotName]:Show()
						end
					end
					if PaperDollFrame:IsVisible() then

						CharacterFrame:SetSize(700, 505)
						CharacterNameText:ClearAllPoints()
						CharacterNameText:SetPoint('TOP', CharacterModelFrame, 0, 40)

						if _G.PlayerTitleDropDown then
							_G.PlayerTitleDropDown:SetPoint('TOP', CharacterNameText, 0, -40)
						end

						--better zoom
						CharacterModelFrame:SetSize(320,350)
						CharacterModelFrame:ClearAllPoints()
						CharacterModelFrame:SetPoint("CENTER", CharacterFrame,"CENTER", -126, 15)
						CharacterModelFrame:SetPosition(0, 0, 0)
						CharacterModelFrame:SetPosition(E.db.ElvUI_EltreumUI.skins.charactermodelcam.zoomclassic, E.db.ElvUI_EltreumUI.skins.charactermodelcam.xclassic, E.db.ElvUI_EltreumUI.skins.charactermodelcam.yclassic)
						ClassCrestFrame:SetPoint("CENTER", CharacterModelFrame, 0 , 50)
						if E.db.ElvUI_EltreumUI.skins.armorybgtype == "CUSTOM" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RACE" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RAGNAROS" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "SPACECLOUD" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RAVNYR" then
							CharacterFrameBackgroundTexture:SetTexCoord(0, 0.716, 0, 1)
						elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "CLASS" then
							CharacterFrameBackgroundTexture:SetTexCoord(0, 0.87, 0, 0.60)
						end
					else
						CharacterNameText:ClearAllPoints()
						CharacterNameText:SetPoint('TOP', CharacterFrame, 0, -25)
						CharacterFrame:SetSize(400, 505)
						if E.db.ElvUI_EltreumUI.skins.armorybgtype == "CUSTOM" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RACE" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RAGNAROS" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "SPACECLOUD" or E.db.ElvUI_EltreumUI.skins.armorybgtype == "RAVNYR" then
							CharacterFrameBackgroundTexture:SetTexCoord(0, 0.39, 0, 1)
						elseif E.db.ElvUI_EltreumUI.skins.armorybgtype == "CLASS" then
							CharacterFrameBackgroundTexture:SetTexCoord(0, 0.87, 0, 0.60)
						end
					end
				end
			end

			CharacterFrame:HookScript("OnShow", ResizeCharacterFrame)
			hooksecurefunc("CharacterFrameTab_OnClick", ResizeCharacterFrame)

			_G.PaperDollItemsFrame:HookScript("OnShow", ResizeCharacterFrame)
			_G.PaperDollItemsFrame:HookScript("OnHide", function()
				ClassCrestFrame:SetPoint("CENTER", CharacterFrame, 0 , 50)
			end)

			--adjust the items
			_G.CharacterHeadSlot:ClearAllPoints()
			_G.CharacterHeadSlot:SetPoint('TOPLEFT', CharacterFrame, 'TOPLEFT', 20, -47)

			_G.CharacterHandsSlot:ClearAllPoints()
			_G.CharacterHandsSlot:SetPoint('CENTER', _G.CharacterHeadSlot, 'CENTER', 370, 0)

			_G.CharacterMainHandSlot:ClearAllPoints()
			_G.CharacterMainHandSlot:SetPoint('CENTER', _G.CharacterModelFrame, 'CENTER', -42, -155)

			if _G.CharacterAmmoSlot then
				_G.CharacterAmmoSlot:ClearAllPoints()
				_G.CharacterAmmoSlot:SetPoint('CENTER', _G.CharacterModelFrame, 'CENTER', 130, -155)
			end

			if _G.PlayerTitleDropDown then
				_G.PlayerTitleDropDown:SetAlpha(0)
				_G.PlayerTitleDropDown:SetScript('OnEnter', function() _G.PlayerTitleDropDown:SetAlpha(1) end)
				_G.PlayerTitleDropDown:SetScript('OnLeave', function() _G.PlayerTitleDropDown:SetAlpha(0) end)
			end

			CharacterNameText:ClearAllPoints()
			CharacterNameText:SetPoint('TOP', CharacterModelFrame, 0, 80)
			--CharacterNameText:SetParent(CharacterModelFrame)
			CharacterNameText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armorynamefontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			CharacterNameText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
			CharacterNameText:SetShadowColor(0, 0, 0, 0.8)
			CharacterNameText:SetShadowOffset(2, -1)

			CharacterLevelText:ClearAllPoints()
			CharacterLevelText:SetPoint('TOP', CharacterNameText, 'BOTTOM', 0, -15)
			CharacterLevelText:SetParent(CharacterModelFrame)

			--start of the stats
			CharacterFrame.Text4:SetSize(418, 72)
			CharacterFrame.Text4:SetPoint("TOPRIGHT", CharacterFrame, "TOPRIGHT", 50, 0) ---anchored
			CharacterFrame.Text4:SetParent(_G["PaperDollItemsFrame"]) --Main Parent1
			CharacterFrame.Text4:SetTextColor(1, 1, 1)
			CharacterFrame.Text4:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize + 6, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			if E.db.ElvUI_EltreumUI.skins.characterskingradients then
				CharacterFrame.Text4:SetText(ElvUI_EltreumUI:GradientName(L["Specialization"], E.myclass)) ---specialization
			elseif not E.db.ElvUI_EltreumUI.skins.characterskingradients then
				CharacterFrame.Text4:SetText(L["Specialization"])
				CharacterFrame.Text4:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
			end
			CharacterFrame.StatusLine4:SetSize(170, 3)
			CharacterFrame.StatusLine4:SetPoint("CENTER", CharacterFrame.Text4, "CENTER", 0, -15)
			CharacterFrame.StatusLine4:SetParent(_G["PaperDollItemsFrame"]) --Main Parent2
			CharacterFrame.StatusLine4:SetStatusBarTexture(E.Media.Textures.Highlight)
			CharacterFrame.StatusLine4:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)

			CharacterFrame.Text5:SetSize(418, 72)
			CharacterFrame.Text5:SetPoint("BOTTOM", CharacterFrame.StatusLine4, "BOTTOM", 0, -50)
			CharacterFrame.Text5:SetParent(CharacterFrame.StatusLine4)
			--CharacterFrame.Text5:SetTextColor(classcolor.r, classcolor.g, classcolor.b, 1)
			CharacterFrame.Text5:SetTextColor(1, 1, 1, 1)
			CharacterFrame.Text5:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize + 6, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			CharacterFrame.Text5:SetText(ElvUI_EltreumUI:GetPlayerSpec())

			CharacterFrame.Text:SetSize(418, 72)
			CharacterFrame.Text:SetPoint("BOTTOM", CharacterFrame.Text5, "BOTTOM", 0, -25)
			CharacterFrame.Text:SetParent(CharacterFrame.StatusLine4)
			CharacterFrame.Text:SetTextColor(1, 1, 1)
			CharacterFrame.Text:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize + 6, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			if E.db.ElvUI_EltreumUI.skins.characterskingradients then
				CharacterFrame.Text:SetText(ElvUI_EltreumUI:GradientName(L["Item Level"], E.myclass)) ---ilvl
			else
				CharacterFrame.Text:SetText(L["Item Level"])
				CharacterFrame.Text:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
			end
			CharacterFrame.StatusLine:SetSize(170, 3)
			CharacterFrame.StatusLine:SetPoint("CENTER", CharacterFrame.Text, "CENTER", 0, -15)
			CharacterFrame.StatusLine:SetParent(CharacterFrame.StatusLine4)
			CharacterFrame.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
			CharacterFrame.StatusLine:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)

			CharacterFrame.Text2:SetSize(418, 72)
			CharacterFrame.Text2:SetPoint("BOTTOM", CharacterFrame.Text, "BOTTOM", 0, -35) --ilvl number
			CharacterFrame.Text2:SetParent(CharacterFrame.StatusLine4)
			CharacterFrame.Text2:SetTextColor(classcolor.r, classcolor.g, classcolor.b, 1)
			CharacterFrame.Text2:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize + 6, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			CharacterFrame.StatusLine2:SetFrameStrata("MEDIUM")
			CharacterFrame.StatusLine2:SetFrameLevel(1)
			CharacterFrame.StatusLine2:SetSize(170, 25)
			CharacterFrame.StatusLine2:SetPoint("CENTER", CharacterFrame.Text2, "CENTER", 0, 0)
			CharacterFrame.StatusLine2:SetParent(_G["PaperDollItemsFrame"]) --Main Parent3
			CharacterFrame.StatusLine2:SetStatusBarTexture(E.Media.Textures.Highlight)
			CharacterFrame.StatusLine2:SetStatusBarColor(1, 1, 1, 0.5)

			CharacterFrame.Text3:SetSize(418, 72)
			CharacterFrame.Text3:SetPoint("TOP", CharacterFrame.Text2, "TOP", 0, -27)
			CharacterFrame.Text3:SetParent(CharacterFrame.StatusLine4)
			CharacterFrame.Text3:SetTextColor(1, 1, 1)
			CharacterFrame.Text3:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize + 6, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			if E.db.ElvUI_EltreumUI.skins.characterskingradients then
				CharacterFrame.Text3:SetText(ElvUI_EltreumUI:GradientName(L["Attributes"], E.myclass)) ---attributes
			else
				CharacterFrame.Text3:SetText(L["Attributes"])
				CharacterFrame.Text3:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
			end
			CharacterFrame.StatusLine3:SetSize(170, 3)
			CharacterFrame.StatusLine3:SetPoint("CENTER", CharacterFrame.Text3, "CENTER", 0, -15)
			CharacterFrame.StatusLine3:SetParent(CharacterFrame.StatusLine4)
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
			if E.Wrath then
				_G.MagicResFrame1:SetParent(_G.PlayerStatFrameLeft1)
				_G.MagicResFrame1:SetPoint("TOPLEFT", _G.PlayerStatFrameLeftDropDown, "TOPLEFT", 13, 25)
			elseif E.Classic then
				_G.MagicResFrame1:SetParent(_G.CharacterStatFrame1)
				_G.MagicResFrame1:SetPoint("BOTTOM", CharacterFrame.StatusLine3, "BOTTOM", -55, -50)
			end
			_G.MagicResFrame2:ClearAllPoints()
			_G.MagicResFrame2:SetParent(_G.MagicResFrame1)
			_G.MagicResFrame2:SetPoint("RIGHT", _G.MagicResFrame1, "RIGHT", 27, 0)
			_G.MagicResFrame2:SetParent(CharacterFrame.StatusLine4)
			_G.MagicResFrame3:ClearAllPoints()
			_G.MagicResFrame3:SetParent(_G.MagicResFrame2)
			_G.MagicResFrame3:SetPoint("RIGHT", _G.MagicResFrame2, "RIGHT", 27, 0)
			_G.MagicResFrame3:SetParent(CharacterFrame.StatusLine4)
			_G.MagicResFrame4:ClearAllPoints()
			_G.MagicResFrame4:SetParent(_G.MagicResFrame3)
			_G.MagicResFrame4:SetPoint("RIGHT", _G.MagicResFrame3, "RIGHT", 27, 0)
			_G.MagicResFrame4:SetParent(CharacterFrame.StatusLine4)
			_G.MagicResFrame5:ClearAllPoints()
			_G.MagicResFrame5:SetParent(_G.MagicResFrame4)
			_G.MagicResFrame5:SetPoint("RIGHT", _G.MagicResFrame4, "RIGHT", 27, 0)
			_G.MagicResFrame5:SetParent(CharacterFrame.StatusLine4)

			if E.Wrath then
				--"left side" or in this case the top side
				_G.PlayerStatFrameLeftDropDown:ClearAllPoints()
				_G.PlayerStatFrameLeftDropDown:SetPoint("CENTER", CharacterFrame.StatusLine3, "CENTER", 0, -45)
				_G.PlayerStatFrameLeftDropDown:SetParent(CharacterFrame.StatusLine4)

				_G.PlayerStatFrameLeft1:ClearAllPoints()
				_G.PlayerStatFrameLeft1:SetPoint("BOTTOM", _G.PlayerStatFrameLeftDropDown, "BOTTOM", -22, -15)
				_G.PlayerStatFrameLeft1:SetParent(CharacterFrame.StatusLine4)

				_G.PlayerStatFrameLeft2:ClearAllPoints()
				_G.PlayerStatFrameLeft2:SetPoint("BOTTOM", _G.PlayerStatFrameLeft1, "BOTTOM", 0, -13)
				_G.PlayerStatFrameLeft2:SetParent(CharacterFrame.StatusLine4)
				_G.PlayerStatFrameLeft2.StatusLine:SetSize(170, 12)
				_G.PlayerStatFrameLeft2.StatusLine:SetPoint("CENTER", _G.PlayerStatFrameLeft2, "CENTER", 25, 0)
				_G.PlayerStatFrameLeft2.StatusLine:SetParent(CharacterFrame.StatusLine4)
				_G.PlayerStatFrameLeft2.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				_G.PlayerStatFrameLeft2.StatusLine:SetStatusBarColor(1, 1, 1, 0.3)
				_G.PlayerStatFrameLeft2.StatusLine:SetFrameLevel(2)

				_G.PlayerStatFrameLeft3:ClearAllPoints()
				_G.PlayerStatFrameLeft3:SetPoint("BOTTOM", _G.PlayerStatFrameLeft2, "BOTTOM", 0, -13)
				_G.PlayerStatFrameLeft3:SetParent(CharacterFrame.StatusLine4)

				_G.PlayerStatFrameLeft4:ClearAllPoints()
				_G.PlayerStatFrameLeft4:SetPoint("BOTTOM", _G.PlayerStatFrameLeft3, "BOTTOM", 0, -13)
				_G.PlayerStatFrameLeft4:SetParent(CharacterFrame.StatusLine4)
				_G.PlayerStatFrameLeft4.StatusLine:SetSize(170, 12)
				_G.PlayerStatFrameLeft4.StatusLine:SetPoint("CENTER", _G.PlayerStatFrameLeft4, "CENTER", 25, 0)
				_G.PlayerStatFrameLeft4.StatusLine:SetParent(CharacterFrame.StatusLine4)
				_G.PlayerStatFrameLeft4.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				_G.PlayerStatFrameLeft4.StatusLine:SetStatusBarColor(1, 1, 1, 0.3)
				_G.PlayerStatFrameLeft4.StatusLine:SetFrameLevel(2)

				_G.PlayerStatFrameLeft5:ClearAllPoints()
				_G.PlayerStatFrameLeft5:SetPoint("BOTTOM", _G.PlayerStatFrameLeft4, "BOTTOM", 0, -13)
				_G.PlayerStatFrameLeft5:SetParent(CharacterFrame.StatusLine4)

				_G.PlayerStatFrameLeft6:ClearAllPoints()
				_G.PlayerStatFrameLeft6:SetPoint("BOTTOM", _G.PlayerStatFrameLeft5, "BOTTOM", 0, -13)
				_G.PlayerStatFrameLeft6:SetParent(CharacterFrame.StatusLine4)
				_G.PlayerStatFrameLeft6.StatusLine:SetSize(170, 12)
				_G.PlayerStatFrameLeft6.StatusLine:SetPoint("CENTER", _G.PlayerStatFrameLeft6, "CENTER", 25, 0)
				_G.PlayerStatFrameLeft6.StatusLine:SetParent(_G["PlayerStatFrameLeft6"])
				_G.PlayerStatFrameLeft6.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				_G.PlayerStatFrameLeft6.StatusLine:SetStatusBarColor(1, 1, 1, 0.3)
				_G.PlayerStatFrameLeft6.StatusLine:SetFrameLevel(2)

				_G.PlayerStatFrameLeft1Stat:ClearAllPoints()
				_G.PlayerStatFrameLeft1Stat:SetPoint("CENTER", _G.PlayerStatFrameLeft1, "CENTER", 95, 0)
				_G.PlayerStatFrameLeft1StatText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				_G.PlayerStatFrameLeft1Stat:SetParent(CharacterFrame.StatusLine4)
				_G.PlayerStatFrameLeft2Stat:ClearAllPoints()
				_G.PlayerStatFrameLeft2Stat:SetPoint("BOTTOM", _G.PlayerStatFrameLeft1Stat, "BOTTOM", 0, -13)
				_G.PlayerStatFrameLeft2StatText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				_G.PlayerStatFrameLeft2Stat:SetParent(CharacterFrame.StatusLine4)
				_G.PlayerStatFrameLeft3Stat:ClearAllPoints()
				_G.PlayerStatFrameLeft3Stat:SetPoint("BOTTOM", _G.PlayerStatFrameLeft2Stat, "BOTTOM", 0, -13)
				_G.PlayerStatFrameLeft3StatText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				_G.PlayerStatFrameLeft3Stat:SetParent(CharacterFrame.StatusLine4)
				_G.PlayerStatFrameLeft4Stat:ClearAllPoints()
				_G.PlayerStatFrameLeft4Stat:SetPoint("BOTTOM", _G.PlayerStatFrameLeft3Stat, "BOTTOM", 0, -13)
				_G.PlayerStatFrameLeft4StatText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				_G.PlayerStatFrameLeft4Stat:SetParent(CharacterFrame.StatusLine4)
				_G.PlayerStatFrameLeft5Stat:ClearAllPoints()
				_G.PlayerStatFrameLeft5Stat:SetPoint("BOTTOM", _G.PlayerStatFrameLeft4Stat, "BOTTOM", 0, -13)
				_G.PlayerStatFrameLeft5StatText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				_G.PlayerStatFrameLeft5Stat:SetParent(CharacterFrame.StatusLine4)
				_G.PlayerStatFrameLeft6Stat:ClearAllPoints()
				_G.PlayerStatFrameLeft6Stat:SetPoint("BOTTOM", _G.PlayerStatFrameLeft5Stat, "BOTTOM", 0, -13)
				_G.PlayerStatFrameLeft6StatText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				_G.PlayerStatFrameLeft6Stat:SetParent(CharacterFrame.StatusLine4)

				--"right side", on this case its the bottom
				_G.PlayerStatFrameRightDropDown:ClearAllPoints()
				_G.PlayerStatFrameRightDropDown:SetPoint("CENTER", _G.PlayerStatFrameLeftDropDown, "CENTER", 0, -115)
				_G.PlayerStatFrameRightDropDown:SetParent(CharacterFrame.StatusLine4)

				_G.PlayerStatFrameRight1:ClearAllPoints()
				_G.PlayerStatFrameRight1:SetPoint("BOTTOM", _G.PlayerStatFrameRightDropDown, "BOTTOM", -22, -15)
				_G.PlayerStatFrameRight1:SetParent(CharacterFrame.StatusLine4)

				_G.PlayerStatFrameRight2:ClearAllPoints()
				_G.PlayerStatFrameRight2:SetPoint("BOTTOM", _G.PlayerStatFrameRight1, "BOTTOM", 0, -13)
				_G.PlayerStatFrameRight2:SetParent(CharacterFrame.StatusLine4)
				_G.PlayerStatFrameRight2.StatusLine:SetSize(170, 12)
				_G.PlayerStatFrameRight2.StatusLine:SetPoint("CENTER", _G.PlayerStatFrameRight2, "CENTER", 25, 0)
				_G.PlayerStatFrameRight2.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				_G.PlayerStatFrameRight2.StatusLine:SetStatusBarColor(1, 1, 1, 0.3)
				_G.PlayerStatFrameRight2.StatusLine:SetFrameLevel(2)
				_G.PlayerStatFrameRight2.StatusLine:SetParent(CharacterFrame.StatusLine4)

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
				_G.PlayerStatFrameRight4.StatusLine:SetParent(_G.PlayerStatFrameRight1)

				_G.PlayerStatFrameRight5:ClearAllPoints()
				_G.PlayerStatFrameRight5:SetPoint("BOTTOM", _G.PlayerStatFrameRight4, "BOTTOM", 0, -13)
				_G.PlayerStatFrameRight5:SetParent(_G.PlayerStatFrameRight1)

				_G.PlayerStatFrameRight6:ClearAllPoints()
				_G.PlayerStatFrameRight6:SetPoint("BOTTOM", _G.PlayerStatFrameRight5, "BOTTOM", 0, -13)
				_G.PlayerStatFrameRight6:SetParent(CharacterFrame.StatusLine4)
				_G.PlayerStatFrameRight6.StatusLine:SetSize(170, 12)
				_G.PlayerStatFrameRight6.StatusLine:SetPoint("CENTER", _G.PlayerStatFrameRight6, "CENTER", 25, 0)
				_G.PlayerStatFrameRight6.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				_G.PlayerStatFrameRight6.StatusLine:SetStatusBarColor(1, 1, 1, 0.3)
				_G.PlayerStatFrameRight6.StatusLine:SetParent(_G["PlayerStatFrameRight6"])
				_G.PlayerStatFrameRight6.StatusLine:SetFrameLevel(2)

				_G.PlayerStatFrameRight1Stat:ClearAllPoints()
				_G.PlayerStatFrameRight1Stat:SetPoint("CENTER", _G.PlayerStatFrameRight1, "CENTER", 95, 0)
				_G.PlayerStatFrameRight1StatText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				_G.PlayerStatFrameRight1Stat:SetParent(_G.PlayerStatFrameRight1)
				_G.PlayerStatFrameRight2Stat:ClearAllPoints()
				_G.PlayerStatFrameRight2Stat:SetPoint("BOTTOM", _G.PlayerStatFrameRight1Stat, "BOTTOM", 0, -13)
				_G.PlayerStatFrameRight2StatText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				_G.PlayerStatFrameRight2Stat:SetParent(_G.PlayerStatFrameRight1)
				_G.PlayerStatFrameRight3Stat:ClearAllPoints()
				_G.PlayerStatFrameRight3Stat:SetPoint("BOTTOM", _G.PlayerStatFrameRight2Stat, "BOTTOM", 0, -13)
				_G.PlayerStatFrameRight3StatText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				_G.PlayerStatFrameRight3Stat:SetParent(_G.PlayerStatFrameRight1)
				_G.PlayerStatFrameRight4Stat:ClearAllPoints()
				_G.PlayerStatFrameRight4Stat:SetPoint("BOTTOM", _G.PlayerStatFrameRight3Stat, "BOTTOM", 0, -13)
				_G.PlayerStatFrameRight4StatText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				_G.PlayerStatFrameRight4Stat:SetParent(_G.PlayerStatFrameRight1)
				_G.PlayerStatFrameRight5Stat:ClearAllPoints()
				_G.PlayerStatFrameRight5Stat:SetPoint("BOTTOM", _G.PlayerStatFrameRight4Stat, "BOTTOM", 0, -13)
				_G.PlayerStatFrameRight5StatText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				_G.PlayerStatFrameRight5Stat:SetParent(_G.PlayerStatFrameRight1)
				_G.PlayerStatFrameRight6Stat:ClearAllPoints()
				_G.PlayerStatFrameRight6Stat:SetPoint("BOTTOM", _G.PlayerStatFrameRight5Stat, "BOTTOM", 0, -13)
				_G.PlayerStatFrameRight6StatText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
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
				_G.CharacterStatFrame1StatText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				_G.CharacterStatFrame1Stat:SetParent(_G.CharacterStatFrame1)

				_G.CharacterStatFrame2Stat:ClearAllPoints()
				_G.CharacterStatFrame2Stat:SetPoint("BOTTOM", _G.CharacterStatFrame1Stat, "BOTTOM", 0, -13)
				_G.CharacterStatFrame2StatText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				_G.CharacterStatFrame2Stat:SetParent(_G.CharacterStatFrame1)
				_G.CharacterStatFrame3Stat:ClearAllPoints()
				_G.CharacterStatFrame3Stat:SetPoint("BOTTOM", _G.CharacterStatFrame2Stat, "BOTTOM", 0, -13)
				_G.CharacterStatFrame3StatText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				_G.CharacterStatFrame3Stat:SetParent(_G.CharacterStatFrame1)
				_G.CharacterStatFrame4Stat:ClearAllPoints()
				_G.CharacterStatFrame4Stat:SetPoint("BOTTOM", _G.CharacterStatFrame3Stat, "BOTTOM", 0, -13)
				_G.CharacterStatFrame4StatText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				_G.CharacterStatFrame4Stat:SetParent(_G.CharacterStatFrame1)
				_G.CharacterStatFrame5Stat:ClearAllPoints()
				_G.CharacterStatFrame5Stat:SetPoint("BOTTOM", _G.CharacterStatFrame4Stat, "BOTTOM", 0, -13)
				_G.CharacterStatFrame5StatText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				_G.CharacterStatFrame5Stat:SetParent(_G.CharacterStatFrame1)

				_G.CharacterArmorFrameStat:ClearAllPoints()
				_G.CharacterArmorFrameStat:SetPoint("BOTTOM", _G.CharacterStatFrame5Stat, "BOTTOM", 0, -13)
				_G.CharacterArmorFrameStatText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				_G.CharacterArmorFrameStat:SetParent(_G.CharacterStatFrame1)

				_G.CharacterAttackFrameStat:ClearAllPoints()
				_G.CharacterAttackFrameStat:SetPoint("BOTTOM", _G.CharacterArmorFrameStat, "BOTTOM", 0, -13)
				_G.CharacterAttackFrameStatText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				_G.CharacterAttackFrameStat:SetParent(_G.CharacterStatFrame1)

				_G.CharacterAttackPowerFrameStat:ClearAllPoints()
				_G.CharacterAttackPowerFrameStat:SetPoint("BOTTOM", _G.CharacterAttackFrameStat, "BOTTOM", 0, -13)
				_G.CharacterAttackPowerFrameStatText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				_G.CharacterAttackPowerFrameStat:SetParent(_G.CharacterStatFrame1)

				_G.CharacterDamageFrameStat:ClearAllPoints()
				_G.CharacterDamageFrameStat:SetPoint("BOTTOM", _G.CharacterAttackPowerFrameStat, "BOTTOM", 0, -13)
				_G.CharacterDamageFrameStatText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				_G.CharacterDamageFrameStat:SetParent(_G.CharacterStatFrame1)

				_G.CharacterRangedAttackFrameStat:ClearAllPoints()
				_G.CharacterRangedAttackFrameStat:SetPoint("BOTTOM", _G.CharacterDamageFrameStat, "BOTTOM", 0, -13)
				_G.CharacterRangedAttackFrameStatText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				_G.CharacterRangedAttackFrameStat:SetParent(_G.CharacterStatFrame1)

				_G.CharacterRangedAttackPowerFrameStat:ClearAllPoints()
				_G.CharacterRangedAttackPowerFrameStat:SetPoint("BOTTOM", _G.CharacterRangedAttackFrameStat, "BOTTOM", 0, -13)
				_G.CharacterRangedAttackPowerFrameStatText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				_G.CharacterRangedAttackPowerFrameStat:SetParent(_G.CharacterStatFrame1)

				_G.CharacterRangedDamageFrameStat:ClearAllPoints()
				_G.CharacterRangedDamageFrameStat:SetPoint("BOTTOM", _G.CharacterRangedAttackPowerFrameStat, "BOTTOM", 0, -13)
				_G.CharacterRangedDamageFrameStatText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
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

--Player Item Quality Texture
function ElvUI_EltreumUI:PlayerItemQuality(unit)
	if not E.private.skins.blizzard.enable then return end
	if not E.private.skins.blizzard.character then return end
	if ElvUI_EltreumUI:SLCheck('char') then return end
	if E.db.ElvUI_EltreumUI.skins.itemquality and E.private.skins.blizzard.enable and E.private.skins.blizzard.character then
		E:Delay(0, function()
			for InvSlotId, InvSlotName in pairs(InvSlotIdTable) do
				qualityAnchor = _G["Character"..InvSlotIdTable[InvSlotId]]
				if not qualityAnchor then return end
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
					if E.db.ElvUI_EltreumUI.skins.classicarmory then
						qualityAnchor.Frame:SetSize(200, _G["Character"..InvSlotName]:GetHeight() + 2)
					else
						qualityAnchor.Frame:SetSize(135, _G["Character"..InvSlotName]:GetHeight() + 2)
					end
				else
					qualityAnchor.Frame:SetFrameLevel(_G["CharacterModelFrame"]:GetFrameLevel()) --needs to be changed to not overlap the sockets/enchants
					if E.db.ElvUI_EltreumUI.skins.classicarmory then
						qualityAnchor.Frame:SetSize(200, _G["Character"..InvSlotName]:GetHeight() + 2)
					else
						qualityAnchor.Frame:SetSize(115, _G["Character"..InvSlotName]:GetHeight() + 2)
					end
				end
				qualityAnchor.Frame.Quality:SetInside() --if not then the frame will not anchor correctly
				qualityAnchor.Frame.Quality:SetTexture('Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Statusbar\\EltreumFade') --temp for testing

				--get item (actual) quality
				local itemLink = _G.GetInventoryItemLink(unit, InvSlotId)
				if itemLink ~= nil then
					local quality = select(3, _G.GetItemInfo(itemLink))
					local isSetItem = select(16, _G.GetItemInfo(itemLink))
					if quality ~= nil then
						local r,g,b
						if E.db.ElvUI_EltreumUI.skins.itemsetenable then
							if isSetItem then
								if E.db.ElvUI_EltreumUI.skins.itemsetcustomcolor then
									r,g,b = E.db.ElvUI_EltreumUI.skins.itemsetcolor.r, E.db.ElvUI_EltreumUI.skins.itemsetcolor.g, E.db.ElvUI_EltreumUI.skins.itemsetcolor.b
								else
									r,g,b = P.ElvUI_EltreumUI.skins.itemsetcolor.r, P.ElvUI_EltreumUI.skins.itemsetcolor.g, P.ElvUI_EltreumUI.skins.itemsetcolor.b
								end
							else
								r,g,b = _G.GetItemQualityColor(quality)
							end
						else
							r,g,b = _G.GetItemQualityColor(quality)
						end
						qualityAnchor.Frame.Quality:SetVertexColor(r, g, b)
						qualityAnchor.Frame.Quality:SetAlpha(1)
						if E.Retail then
							local borderfix = _G["Character"..InvSlotName]
							if borderfix.IconBorder then
								--borderfix.IconBorder:SetVertexColor(r, g, b)
								borderfix.IconBorder.SetVertexColor = nil
								_G["Character"..InvSlotName].BottomEdge:SetVertexColor(r, g, b)
								_G["Character"..InvSlotName].TopEdge:SetVertexColor(r, g, b)
								_G["Character"..InvSlotName].RightEdge:SetVertexColor(r, g, b)
								_G["Character"..InvSlotName].LeftEdge:SetVertexColor(r, g, b)
								_G["Character"..InvSlotName].BottomLeftCorner:SetVertexColor(r, g, b)
								_G["Character"..InvSlotName].BottomRightCorner:SetVertexColor(r, g, b)
								_G["Character"..InvSlotName].TopLeftCorner:SetVertexColor(r, g, b)
								_G["Character"..InvSlotName].TopRightCorner:SetVertexColor(r, g, b)
							end
						else
							if _G["Character"..InvSlotName] then
								--_G["Inspect"..InvSlotName].backdrop.BottomEdge:SetColorTexture(r,g,b,1)
								_G["Character"..InvSlotName].BottomEdge:Hide()
								_G["Character"..InvSlotName].TopEdge:Hide()
								_G["Character"..InvSlotName].RightEdge:Hide()
								_G["Character"..InvSlotName].LeftEdge:Hide()
								_G["Character"..InvSlotName].BottomLeftCorner:Hide()
								_G["Character"..InvSlotName].BottomRightCorner:Hide()
								_G["Character"..InvSlotName].TopLeftCorner:Hide()
								_G["Character"..InvSlotName].TopRightCorner:Hide()
							end
						end

						if not E.Retail then
							--coloring ilvl based on the items they have
							local qualitytable = {
								[0] = 0,
								[1] = 0,
								[2] = 0,
								[3] = 0,
								[4] = 0,
							}
							local maxquality = 0
							local numberquality = 0
							if quality == 0 then
								qualitytable[0] = qualitytable[0] +1
							elseif quality == 1 then
								qualitytable[1] = qualitytable[1] +1
							elseif quality == 2 then
								qualitytable[2] = qualitytable[2] + 1
							elseif quality == 3 then
								qualitytable[3] = qualitytable[3] + 1
							elseif quality == 4 then
								qualitytable[4] = qualitytable[4] + 1
							end
							for k, v in pairs(qualitytable) do
								if qualitytable[k] > numberquality then
									maxquality, numberquality = k, v
								end
							end
							if _G.CharacterFrame.Text2 and _G.CharacterFrame.Text2:GetText() ~= nil then
								local rc,gc,bc = _G.GetItemQualityColor(maxquality)
								_G.CharacterFrame.Text2:SetTextColor(rc,gc,bc)
							end
						end
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
						if E.db.ElvUI_EltreumUI.skins.classicarmory then
							qualityAnchor.Frame:SetSize(120, _G["CharacterSecondaryHandSlot"]:GetHeight() + 2)
							qualityAnchor.Frame:SetPoint("BOTTOM", _G["Character"..InvSlotName], "BOTTOM", 0, 35)
							qualityAnchor.Frame.Quality:SetPoint("BOTTOM", _G["Character"..InvSlotName], "BOTTOM", 0, 35)
						else
							qualityAnchor.Frame:SetSize(115, _G["CharacterSecondaryHandSlot"]:GetHeight() + 2)
							qualityAnchor.Frame:SetPoint("BOTTOM", _G["Character"..InvSlotName], "BOTTOM", 0, 51)
							qualityAnchor.Frame.Quality:SetPoint("BOTTOM", _G["Character"..InvSlotName], "BOTTOM", 0, 51)
						end
						qualityAnchor.Frame.Quality:SetRotation(1.57079633)
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
refreshplayer:RegisterUnitEvent("UNIT_FLAGS", "player")
refreshplayer:RegisterEvent("SPELL_UPDATE_COOLDOWN") --only out of combat
--refreshplayer:RegisterEvent("UNIT_INVENTORY_CHANGED", "target") --need to test to see if too much cpu/memory (specially for pvp)
refreshplayer:SetScript("OnEvent", function(_,event)
	if _G.CharacterFrame:IsShown() then
		if event == "SPELL_UPDATE_COOLDOWN" then
			if not InCombatLockdown() then
				ElvUI_EltreumUI:PlayerItemQuality("player")
			end
		else
			ElvUI_EltreumUI:PlayerItemQuality("player")
		end
	end
end)
_G.CharacterFrame:HookScript("OnShow", function()
	ElvUI_EltreumUI:PlayerItemQuality("player")
end)

local classsymbolonframe
local classIcons = {
	["WARRIOR"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/Warrior",
	["PALADIN"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/Paladin",
	["HUNTER"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/Hunter",
	["ROGUE"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/Rogue",
	["PRIEST"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/Priest",
	["DEATHKNIGHT"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/DeathKnight",
	["SHAMAN"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/Shaman",
	["MAGE"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/Mage",
	["WARLOCK"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/Warlock",
	["MONK"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/Monk",
	["DRUID"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/Druid",
	["DEMONHUNTER"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/DemonHunter",
	["EVOKER"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/Evoker",
}

-- Alternate Class Icons by Releaf with borders
local classIconsReleafborder = {
	["WARRIOR"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/WarriorIconReleaf",
	["PALADIN"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/PaladinIconReleaf",
	["HUNTER"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/HunterIconReleaf",
	["ROGUE"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/RogueIconReleaf",
	["PRIEST"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/PriestIconReleaf",
	["DEATHKNIGHT"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/DeathKnightIconReleaf",
	["SHAMAN"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/ShamanIconReleaf",
	["MAGE"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/MageIconReleaf",
	["WARLOCK"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/WarlockIconReleaf",
	["MONK"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/MonkIconReleaf",
	["DRUID"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/DruidIconReleaf",
	["DEMONHUNTER"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/DemonHunterIconReleaf",
	["EVOKER"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/EvokerIconReleaf",
}

--inspect bg/item quality texture
local EltruismInspectBg = CreateFrame("Frame")
local EltruismInspectBgTexture = EltruismInspectBg:CreateTexture("EltruismInspectBG")
local EltruismInspectBgTextureFader = EltruismInspectBg:CreateTexture("EltruismInspectVignette")
EltruismInspectBgTextureFader:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Vignette.tga")

function ElvUI_EltreumUI:InspectBg(unit)
	if not E.private.skins.blizzard.enable then return end
	if not E.private.skins.blizzard.character then return end

	--inspect frame bg
	if IsAddOnLoaded("Blizzard_InspectUI") then
		EltruismInspectBg:SetParent(_G.InspectFrame)

		if E.db.ElvUI_EltreumUI.skins.expandarmorybg then
			local _, englishClass, _, englishRace = _G.GetPlayerInfoByGUID(unit)
			if englishClass or englishRace then
				if _G.InspectFrame then
					local classcolorinspect = E:ClassColor(englishClass, true)

					--inspect frame expand skin
					if not E.Retail then
						E:Delay(0, function()
							if InCombatLockdown() then
								UIErrorsFrame:AddMessage(ERR_NOT_IN_COMBAT, 1.0, 0.2, 0.2, 1.0)
							else
								_G.InspectNameText:ClearAllPoints()
								_G.InspectNameText:SetPoint("TOP", _G.InspectFrame, "TOP", 0, -20)
								_G.InspectFrame:SetWidth(450)
								_G.InspectPaperDollItemsFrame:SetWidth(450)
								_G.InspectHandsSlot:ClearAllPoints()
								_G.InspectHandsSlot:SetPoint("TOPRIGHT", _G.InspectFrame, "TOPRIGHT", -45, -74)
								_G.InspectModelFrame:ClearAllPoints()
								_G.InspectModelFrame:SetPoint("CENTER", _G.InspectFrame, "CENTER", 0, 0)
								_G.InspectMainHandSlot:ClearAllPoints()
								_G.InspectMainHandSlot:SetPoint("CENTER", _G.InspectFrame, "CENTER", -52, -150)
								if not self.EltruismInspectHook then
									_G.InspectModelFrame:HookScript("OnShow", function()
										_G.InspectFrame:SetWidth(450)
									end)
									_G.InspectModelFrame:HookScript("OnHide", function()
										_G.InspectFrame:SetWidth(384)
									end)
									self.EltruismInspectHook = true
								end

								if E.Wrath then
									if not self.EltruismInspectHookWrath then
										_G.InspectTalentFrame:HookScript("OnShow", function()
											if InCombatLockdown() then
												UIErrorsFrame:AddMessage(ERR_NOT_IN_COMBAT, 1.0, 0.2, 0.2, 1.0)
											else
												_G.InspectFrame:SetWidth(376)
												if E.Wrath then
													_G.InspectFrame:SetHeight(780)
												else
													_G.InspectFrame:SetHeight(650)
												end
												_G.InspectTalentFrameTab2:ClearAllPoints()
												_G.InspectTalentFrameTab2:SetPoint("TOP", _G.InspectTalentFrame, "TOP", 0, -50)
												_G.InspectTalentFrameTab1:ClearAllPoints()
												_G.InspectTalentFrameTab1:SetPoint("RIGHT", _G.InspectTalentFrameTab2, "LEFT", 0, 0)

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
													_G.InspectTalentFramePointsBar:SetPoint("BOTTOM", _G.InspectTalentFrame.backdrop, "BOTTOM", 0, 0)
													_G.InspectTalentFrameSpentPointsText:SetJustifyH("LEFT")
													_G.InspectTalentFrameTalentPointsText:SetJustifyH("RIGHT")
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
													if E.Wrath then
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
											end
										end)

										_G.InspectTalentFrame:HookScript("OnHide", function()
											if InCombatLockdown() then
												UIErrorsFrame:AddMessage(ERR_NOT_IN_COMBAT, 1.0, 0.2, 0.2, 1.0)
											else
												_G.InspectFrame:SetHeight(512)
												_G.InspectFrame:SetWidth(384)
											end
										end)
										self.EltruismInspectHookWrath = true
									end
								end
							end
						end)
					else
						_G.InspectFrame:SetWidth(450)
						_G.InspectPaperDollItemsFrame:SetWidth(450)
						_G.InspectHandsSlot:ClearAllPoints()
						_G.InspectHandsSlot:SetPoint("TOPRIGHT", _G.InspectFrame, "TOPRIGHT", -8, -62)
						_G.InspectModelFrame:ClearAllPoints()
						_G.InspectModelFrame:SetPoint("CENTER", _G.InspectFrame, "CENTER", 0, -20)
						_G.InspectMainHandSlot:ClearAllPoints()
						_G.InspectMainHandSlot:SetPoint("CENTER", _G.InspectFrame, "CENTER", -24, -187)

						_G.InspectFrame.ItemLevelText:ClearAllPoints()
						_G.InspectFrame.ItemLevelText:SetPoint("CENTER", _G.InspectFrame, "CENTER", 0, 165)
						_G.InspectFrame.ItemLevelText:SetTextColor(classcolorinspect.r, classcolorinspect.g, classcolorinspect.b)
						_G.InspectFrame.ItemLevelText:SetParent(_G["InspectModelFrame"])

						if _G.InspectPaperDollFrame.ViewButton then
							_G.InspectPaperDollFrame.ViewButton:ClearAllPoints()
							_G.InspectPaperDollFrame.ViewButton:SetPoint("CENTER", _G.InspectFrame, "CENTER", 0, 145)
							--make it mouseover
							_G.InspectPaperDollFrame.ViewButton:SetAlpha(0)
							_G.InspectPaperDollFrame.ViewButton:SetScript('OnEnter', function() _G.InspectPaperDollFrame.ViewButton:SetAlpha(1) end)
							_G.InspectPaperDollFrame.ViewButton:SetScript('OnLeave', function() _G.InspectPaperDollFrame.ViewButton:SetAlpha(0) end)
							_G.InspectModelFrame:SetScript('OnEnter', function() _G.InspectPaperDollFrame.ViewButton:SetAlpha(1) end)
							_G.InspectModelFrame:SetScript('OnLeave', function() _G.InspectPaperDollFrame.ViewButton:SetAlpha(0) end)
						end

						--_G.InspectFrame.ItemLevelText:SetText(ElvUI_EltreumUI:GradientName(_G.InspectFrame.ItemLevelText:GetText(), englishClass))
						--_G.InspectFrame.ItemLevelText:SetText("|cffFFCE00"..L["Item Level"]..":|r "..(math.floor(ElvUI_EltreumUI:GetUnitItemLevel("target")*100))/100)

						if not self.EltruismInspectHookModel then
							_G.InspectModelFrame:HookScript("OnShow", function()
								_G.InspectFrame:SetWidth(450)
							end)
							_G.InspectModelFrame:HookScript("OnHide", function()
								_G.InspectFrame:SetWidth(338)
							end)
							self.EltruismInspectHookmodel = true
						end

						if _G.InspectPaperDollItemsFrame.InspectTalents then
							_G.InspectPaperDollItemsFrame.InspectTalents:ClearAllPoints()
							_G.InspectPaperDollItemsFrame.InspectTalents:SetPoint("RIGHT", _G.InspectFrame, "BOTTOMRIGHT", -5, 15)
						end
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
								if _G.InspectNameText then
									_G.InspectNameText:ClearAllPoints()
									_G.InspectNameText:SetPoint("TOP",_G.InspectFrame,"TOP",0,-15)
									if _G.InspectNameText:GetText() and not _G.InspectNameText:GetText():match("|T") then
										_G.InspectNameText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armorynamefontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
										if string.len(_G.InspectNameText:GetText()) >= 6 then
											if E.db.ElvUI_EltreumUI.skins.characterskingradients and not _G.InspectNameText:GetText():match("|r") then
												_G.InspectNameText:SetText(classsymbolonframe.." "..ElvUI_EltreumUI:GradientName(_G.InspectNameText:GetText(), englishClass))
											else
												_G.InspectNameText:SetText(classsymbolonframe.." ".._G.InspectNameText:GetText())
												_G.InspectNameText:SetTextColor(classcolorinspect.r, classcolorinspect.g, classcolorinspect.b)
											end
										else
											_G.InspectNameText:SetText(classsymbolonframe.." ".._G.InspectNameText:GetText())
											_G.InspectNameText:SetTextColor(classcolorinspect.r, classcolorinspect.g, classcolorinspect.b)
										end
										_G.InspectNameText:SetShadowColor(0, 0, 0, 0.8)
										_G.InspectNameText:SetShadowOffset(2, -1)
										_G.InspectNameText:SetWidth(200)
										_G.InspectNameText:SetDrawLayer("OVERLAY")
									end
								end
							else
								if _G.InspectFrameTitleText then
									_G.InspectFrameTitleText:ClearAllPoints()
									_G.InspectFrameTitleText:SetPoint("TOP",_G.InspectFrame,"TOP",0,-5)
									if _G.InspectFrameTitleText:GetText() and not _G.InspectFrameTitleText:GetText():match("|T") then
										_G.InspectFrameTitleText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armorynamefontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
										if string.len(_G.InspectFrameTitleText:GetText()) >= 6 then
											if E.db.ElvUI_EltreumUI.skins.characterskingradients and not _G.InspectFrameTitleText:GetText():match("|r") then
												_G.InspectFrameTitleText:SetText(classsymbolonframe.." "..ElvUI_EltreumUI:GradientName(_G.InspectFrameTitleText:GetText(), englishClass))
											else
												_G.InspectFrameTitleText:SetText(classsymbolonframe.." ".._G.InspectFrameTitleText:GetText())
												_G.InspectFrameTitleText:SetTextColor(classcolorinspect.r, classcolorinspect.g, classcolorinspect.b)
											end
										else
											_G.InspectFrameTitleText:SetText(classsymbolonframe.." ".._G.InspectFrameTitleText:GetText())
											_G.InspectFrameTitleText:SetTextColor(classcolorinspect.r, classcolorinspect.g, classcolorinspect.b)
										end
										_G.InspectFrameTitleText:SetShadowColor(0, 0, 0, 0.8)
										_G.InspectFrameTitleText:SetShadowOffset(2, -1)
										_G.InspectFrameTitleText:SetWidth(200)
										_G.InspectFrameTitleText:SetDrawLayer("OVERLAY")
									end
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
							_G.InspectFrame.Ilvl:SetTextColor(classcolorinspect.r, classcolorinspect.g, classcolorinspect.b, 1)
							_G.InspectLevelText:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
							_G.InspectFrame.Ilvl:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.skins.armoryfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
							if _G.InspectFrame and _G.InspectFrame.unit then
								E:Delay(0.1, function() _G.InspectFrame.Ilvl:SetText("|cffFFCE00"..L["Item Level"]..":|r "..(math.floor(ElvUI_EltreumUI:GetUnitItemLevel(_G.InspectFrame.unit)*100))/100) end)
							else
								E:Delay(0.1, function() _G.InspectFrame.Ilvl:SetText("|cffFFCE00"..L["Item Level"]..":|r "..(math.floor(ElvUI_EltreumUI:GetUnitItemLevel("target")*100))/100) end)
							end
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
						EltruismInspectBgTexture:SetTexCoord(0.1, 0.55, 0, 1)
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
						EltruismInspectBgTexture:SetTexCoord(0.1, 0.50, 0, 1)
					end

					EltruismInspectBgTexture:SetAlpha(E.db.ElvUI_EltreumUI.skins.expandarmorybgalpha)
					if E.Wrath or E.Classic then
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
			if ElvUI_EltreumUI:SLCheck('inspect') then return end
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
						qualityAnchorInspect.Frame:SetSize(140, _G["Inspect"..InvSlotName]:GetHeight() + 2)
					else
						qualityAnchorInspect.Frame:SetFrameLevel(_G["InspectModelFrame"]:GetFrameLevel() - 1)
						qualityAnchorInspect.Frame:SetSize(140, _G["Inspect"..InvSlotName]:GetHeight() + 2)
					end

					qualityAnchorInspect.Frame.Quality:SetTexture('Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Statusbar\\EltreumFade')
					qualityAnchorInspect.Frame.Quality:SetInside() --if not then the frame will not anchor correctly

					--get item (actual) quality
					local itemLink
					if _G.InspectFrame and _G.InspectFrame.unit then
						itemLink = _G.GetInventoryItemLink(_G.InspectFrame.unit, InvSlotId)
					else
						itemLink = _G.GetInventoryItemLink("target", InvSlotId)
					end
					if itemLink ~= nil then
						local quality = select(3,_G.GetItemInfo(itemLink))
						local isSetItem = select(16, _G.GetItemInfo(itemLink))
						if quality then
							local r,g,b
							if E.db.ElvUI_EltreumUI.skins.itemsetenable then
								if isSetItem then
									if E.db.ElvUI_EltreumUI.skins.itemsetcustomcolor then
										r,g,b = E.db.ElvUI_EltreumUI.skins.itemsetcolor.r, E.db.ElvUI_EltreumUI.skins.itemsetcolor.g, E.db.ElvUI_EltreumUI.skins.itemsetcolor.b
									else
										r,g,b = P.ElvUI_EltreumUI.skins.itemsetcolor.r, P.ElvUI_EltreumUI.skins.itemsetcolor.g, P.ElvUI_EltreumUI.skins.itemsetcolor.b
									end
								else
									r,g,b = _G.GetItemQualityColor(quality)
								end
							else
								r,g,b = _G.GetItemQualityColor(quality)
							end
							qualityAnchorInspect.Frame.Quality:SetVertexColor(r, g, b)
							qualityAnchorInspect.Frame.Quality:SetAlpha(1)
							if E.Retail then
								local borderfix = _G["Inspect"..InvSlotName]
								if borderfix.IconBorder then
									borderfix.IconBorder:SetVertexColor(r, g, b)
								end
							else
								if _G["Inspect"..InvSlotName].backdrop then
									--_G["Inspect"..InvSlotName].backdrop.BottomEdge:SetColorTexture(r,g,b,1)
									_G["Inspect"..InvSlotName].backdrop.BottomEdge:Hide()
									_G["Inspect"..InvSlotName].backdrop.TopEdge:Hide()
									_G["Inspect"..InvSlotName].backdrop.RightEdge:Hide()
									_G["Inspect"..InvSlotName].backdrop.LeftEdge:Hide()
									_G["Inspect"..InvSlotName].backdrop.BottomLeftCorner:Hide()
									_G["Inspect"..InvSlotName].backdrop.BottomRightCorner:Hide()
									_G["Inspect"..InvSlotName].backdrop.TopLeftCorner:Hide()
									_G["Inspect"..InvSlotName].backdrop.TopRightCorner:Hide()
								end
							end

							if not E.Retail and E.db.ElvUI_EltreumUI.skins.ilvlsinspect then
								--coloring ilvl based on the items they have
								local qualitytable = {
									[0] = 0,
									[1] = 0,
									[2] = 0,
									[3] = 0,
									[4] = 0,
								}
								local maxquality = 0
								local numberquality = 0
								if quality == 0 then
									qualitytable[0] = qualitytable[0] +1
								elseif quality == 1 then
									qualitytable[1] = qualitytable[1] +1
								elseif quality == 2 then
									qualitytable[2] = qualitytable[2] + 1
								elseif quality == 3 then
									qualitytable[3] = qualitytable[3] + 1
								elseif quality == 4 then
									qualitytable[4] = qualitytable[4] + 1
								end
								for k, v in pairs(qualitytable) do
									if qualitytable[k] > numberquality then
										maxquality, numberquality = k, v
									end
								end
								if _G.InspectFrame.Ilvl then
									if _G.InspectFrame.Ilvl:GetText() == nil then
										_G.InspectFrame.Ilvl:SetText("PLACEHOLDER")
									end
									if _G.InspectFrame.Ilvl:GetText() ~= nil and not _G.InspectFrame.Ilvl:GetText():match("|r") then
										local _, _, _, hex = GetItemQualityColor(maxquality)
										if _G.InspectFrame and _G.InspectFrame.unit then
											_G.InspectFrame.Ilvl:SetText("|cffFFCE00"..L["Item Level"]..":|r ".."|c"..hex..((math.floor(ElvUI_EltreumUI:GetUnitItemLevel(_G.InspectFrame.unit)*100))/100).."|r")
										else
											_G.InspectFrame.Ilvl:SetText("|cffFFCE00"..L["Item Level"]..":|r ".."|c"..hex..((math.floor(ElvUI_EltreumUI:GetUnitItemLevel("target")*100))/100).."|r")
										end
									end
								end
							end
						end
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
							qualityAnchorInspect.Frame:SetSize(120, _G["Inspect"..InvSlotName]:GetHeight() + 2)
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
