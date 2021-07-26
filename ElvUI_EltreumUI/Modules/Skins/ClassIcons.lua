local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local CreateFrame = _G.CreateFrame

local classIcons = {
	['WARRIOR'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Warrior",
	['PALADIN'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Paladin",
	['HUNTER'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Hunter",
	['ROGUE'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Rogue",
	['PRIEST'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Priest",
	['DEATHKNIGHT'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/DeathKnight",
	['SHAMAN'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Shaman",
	['MAGE'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Mage",
	['WARLOCK'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Warlock",
	['MONK'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Monk",
	['DRUID'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Druid",
	['DEMONHUNTER'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/DemonHunter",
}

-- Alternate Class Icons by Releaf with borders
local classIconsReleafborder = {
	['WARRIOR'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/WarriorIconReleaf",
	['PALADIN'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/PaladinIconReleaf",
	['HUNTER'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/HunterIconReleaf",
	['ROGUE'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/RogueIconReleaf",
	['PRIEST'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/PriestIconReleaf",
	['DEATHKNIGHT'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/DeathKnightIconReleaf",
	['SHAMAN'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/ShamanIconReleaf",
	['MAGE'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/MageIconReleaf",
	['WARLOCK'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/WarlockIconReleaf",
	['MONK'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/MonkIconReleaf",
	['DRUID'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/DruidIconReleaf",
	['DEMONHUNTER'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/DemonHunterIconReleaf",
}

--add class icon to class in character panel
local classFrame = CreateFrame("Frame", "EltruismClassIcon", UIParent)
classFrame:SetSize(20, 20)
classFrame:SetParent("PaperDollFrame")
local classTexture = classFrame:CreateTexture()
classTexture:SetAllPoints(classFrame)
local CharacterLevelText = _G.CharacterLevelText
if ElvUI_EltreumUI.Retail then
	CharacterLevelText:SetWidth(300) --new
elseif ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
	CharacterLevelText:SetWidth(280) --new
end

function ElvUI_EltreumUI:ClassIconsOnCharacterPanel()
	if E.db.ElvUI_EltreumUI.skins.classiconsoncharacterpanel then
		classFrame:ClearAllPoints()
		--type of icon
		if E.db.ElvUI_EltreumUI.skins.classiconsblizz then
			classTexture:SetTexture(classIcons[E.myclass])
		elseif E.db.ElvUI_EltreumUI.skins.classiconsreleaf then
			classTexture:SetTexture(classIconsReleafborder[E.myclass])
		else
			classTexture:SetTexture(classIcons[E.myclass])
		end
		local textwidth = CharacterLevelText:GetUnboundedStringWidth()
		local levelwidth = CharacterLevelText:GetWidth()
		local totalgap = levelwidth - textwidth
		local gapclassic = totalgap/4
		local gapretail = totalgap/4
		if ElvUI_EltreumUI.Retail then
			--print(gapretail)
			if not IsAddOnLoaded("ElvUI_SLE") then
				CharacterLevelText:SetPoint("TOPLEFT", "PaperDollFrame", 0 , - 30)
			end
			if gapretail <= 20 then
				classFrame:SetPoint("RIGHT", "CharacterLevelText", -15, 0)
			elseif gapretail > 20 and gapretail <=30 then
				classFrame:SetPoint("RIGHT", "CharacterLevelText", -15, 0)
			elseif gapretail > 30 and gapretail < 40 then
				classFrame:SetPoint("RIGHT", "CharacterLevelText", (0-gapretail)/2, 0)
			elseif gapretail >= 40 then
				classFrame:SetPoint("RIGHT", "CharacterLevelText", (0-gapretail), 0)
			end
		end
		if ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
			classFrame:SetPoint("RIGHT", "CharacterLevelText", -gapclassic, 0)
		end
	end
end
