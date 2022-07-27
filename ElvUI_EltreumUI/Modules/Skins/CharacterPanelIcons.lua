local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local classcolor = E:ClassColor(E.myclass, true)
local CreateFrame = _G.CreateFrame
local UIParent = _G.UIParent
local IsAddOnLoaded = _G.IsAddOnLoaded
local hooksecurefunc = _G.hooksecurefunc
local CharacterLevelText = _G.CharacterLevelText
local CharacterFrameTitleText = _G.CharacterFrameTitleText
local CharacterNameText = _G.CharacterNameText
local CharacterModelFrame = _G.CharacterModelFrame
local CharacterFrame = _G.CharacterFrame
local PaperDollFrame = _G.PaperDollFrame
local ReputationFrame = _G.ReputationFrame
local TokenFrame = _G.TokenFrame

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

--create the frame that holds the icon
local classFrame = CreateFrame("Frame", "EltruismClassIcon", UIParent)
classFrame:SetSize(20, 20)
classFrame:SetParent("PaperDollFrame")
local classTexture = classFrame:CreateTexture()
classTexture:SetAllPoints(classFrame)
if E.Retail then
	CharacterLevelText:SetWidth(300) --new
elseif E.Classic or E.Wrath or E.TBC then
	CharacterLevelText:SetWidth(280) --new
end
local classsymbolonframe
local charactertext --check character text

--put the icon on the papeldoll frame, modify it a bit if SLE is not loaded
function ElvUI_EltreumUI:PlayerNamepaperdoll()
	if not IsAddOnLoaded("ElvUI_EltreumUI") then
		return
	elseif not E.private.ElvUI_EltreumUI then
		return
	elseif E.db.ElvUI_EltreumUI.skins.classiconsoncharacterpanel and not E.private.skins.blizzard.enable == false then
		if E.db.ElvUI_EltreumUI.skins.classiconsblizz then
			classsymbolonframe = ("|T"..(classIcons[E.myclass]..".tga:0:0:0:0|t"))
		elseif E.db.ElvUI_EltreumUI.skins.classiconsreleaf then
			classsymbolonframe = ("|T"..(classIconsReleafborder[E.myclass]..".tga:0:0:0:0|t"))
		else
			classsymbolonframe = ("|T"..(classIcons[E.myclass]..".tga:0:0:0:0|t"))
		end
		if charactertext == nil then
			return
		elseif not charactertext:match("|T") then
			if E.Retail then
				if CharacterFrameTitleText then
					CharacterFrameTitleText:SetText(classsymbolonframe.." "..CharacterFrameTitleText:GetText())
				end
			else
				if CharacterFrameTitleText then
					CharacterNameText:SetText(classsymbolonframe.." "..CharacterFrameTitleText:GetText())
					CharacterNameText:SetParent(_G["PaperDollItemsFrame"])
				end
			end
		end
	end
end

function ElvUI_EltreumUI:ClassIconsOnCharacterPanel()
	if E.db.ElvUI_EltreumUI.skins.classiconsoncharacterpanel and not E.private.skins.blizzard.enable == false then
		if E.Classic or E.Wrath or E.TBC then
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
			classFrame:SetPoint("RIGHT", "CharacterLevelText", 8-gapclassic, 0)
			classFrame:SetParent(_G["PaperDollItemsFrame"])
		elseif E.Retail then

			hooksecurefunc('PaperDollFrame_SetLevel', function()
				CharacterFrameTitleText:ClearAllPoints()
				CharacterFrameTitleText:SetPoint('TOP', CharacterModelFrame, 0, 50)
				CharacterFrameTitleText:SetParent(CharacterFrame)
				CharacterFrameTitleText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize+2, E.db.general.fontStyle)
				CharacterFrameTitleText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
				CharacterFrameTitleText:SetShadowColor(0, 0, 0, 0.8)
				CharacterFrameTitleText:SetShadowOffset(2, -1)
				CharacterLevelText:ClearAllPoints()
				CharacterLevelText:SetPoint('TOP', CharacterFrameTitleText, 'BOTTOM', 0, 0)
				CharacterLevelText:SetDrawLayer("OVERLAY")
			end)

			hooksecurefunc("CharacterFrame_Collapse", function()
				if PaperDollFrame:IsShown() then
					if E.Retail then
						charactertext = CharacterFrameTitleText:GetText()
						if not charactertext:match("|T") then
							CharacterFrameTitleText:SetText(classsymbolonframe.." "..CharacterFrameTitleText:GetText())
						end
					elseif E.Wrath or E.TBC or E.Classic then
						charactertext = CharacterFrameTitleText:GetText()
						if not charactertext:match("|T") then
							CharacterNameText:SetText(classsymbolonframe.." "..CharacterNameText:GetText())
						end
					end
				end
			end)

			hooksecurefunc("CharacterFrame_Expand", function()
				if PaperDollFrame:IsShown() then
					if E.Retail then
						charactertext = CharacterFrameTitleText:GetText()
						if not charactertext:match("|T") then
							CharacterFrameTitleText:SetText(classsymbolonframe.." "..CharacterFrameTitleText:GetText())
						end
					elseif E.Wrath or E.TBC or E.Classic then
						charactertext = CharacterFrameTitleText:GetText()
						if not charactertext:match("|T") then
							CharacterNameText:SetText(classsymbolonframe.." "..CharacterNameText:GetText())
						end
					end
				end
			end)

			hooksecurefunc("ReputationFrame_Update", function()
				if ReputationFrame:IsShown() then
					if E.Retail then
						charactertext = CharacterFrameTitleText:GetText()
						if not charactertext:match("|T") then
							CharacterFrameTitleText:SetText(classsymbolonframe.." "..CharacterFrameTitleText:GetText())
						end
					elseif E.Wrath or E.TBC or E.Classic then
						charactertext = CharacterFrameTitleText:GetText()
						if not charactertext:match("|T") then
							CharacterNameText:SetText(classsymbolonframe.." "..CharacterNameText:GetText())
						end
					end
				end
			end)

			hooksecurefunc("TokenFrame_Update", function()
				if TokenFrame:IsShown() then
					if E.Retail then
						charactertext = CharacterFrameTitleText:GetText()
						if not charactertext:match("|T") then
							CharacterFrameTitleText:SetText(classsymbolonframe.." "..CharacterFrameTitleText:GetText())
						end
					elseif E.Wrath or E.TBC or E.Classic then
						charactertext = CharacterFrameTitleText:GetText()
						if not charactertext:match("|T") then
							CharacterNameText:SetText(classsymbolonframe.." "..CharacterNameText:GetText())
						end
					end
				end
			end)

		end
	end
end

local EltruismCharacterPanelEventFrame = CreateFrame("FRAME")
EltruismCharacterPanelEventFrame:RegisterUnitEvent("UNIT_NAME_UPDATE", "player")
EltruismCharacterPanelEventFrame:SetScript("OnEvent", function()
	ElvUI_EltreumUI:ClassIconsOnCharacterPanel()
	ElvUI_EltreumUI:PlayerNamepaperdoll()
end)
