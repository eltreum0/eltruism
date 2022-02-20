local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local classcolor = E:ClassColor(E.myclass, true)

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

--create the frame that holds the icon
local classFrame = CreateFrame("Frame", "EltruismClassIcon", UIParent)
classFrame:SetSize(20, 20)
classFrame:SetParent("PaperDollFrame")
local classTexture = classFrame:CreateTexture()
classTexture:SetAllPoints(classFrame)
local CharacterLevelText = _G.CharacterLevelText
if E.Retail then
	CharacterLevelText:SetWidth(300) --new
elseif E.Classic or E.TBC then
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
	elseif E.db.ElvUI_EltreumUI.skins.classiconsoncharacterpanel then
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
				if _G.CharacterFrameTitleText then
					_G.CharacterFrameTitleText:SetText(classsymbolonframe.." ".._G.CharacterFrameTitleText:GetText())
				end
			else
				if _G.CharacterFrameTitleText then
					_G.CharacterNameText:SetText(classsymbolonframe.." ".._G.CharacterFrameTitleText:GetText())
				end
			end
		end
	end
end

function ElvUI_EltreumUI:ClassIconsOnCharacterPanel()
	if E.db.ElvUI_EltreumUI.skins.classiconsoncharacterpanel then
		if E.Classic or E.TBC then
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
		elseif E.Retail then

			hooksecurefunc('PaperDollFrame_SetLevel', function()
				_G.CharacterFrameTitleText:ClearAllPoints()
				_G.CharacterFrameTitleText:SetPoint('TOP', _G.CharacterModelFrame, 0, 50)
				_G.CharacterFrameTitleText:SetParent(_G.CharacterFrame)
				_G.CharacterFrameTitleText:SetFont(E.LSM:Fetch('font', E.db.general.font), 14, "OUTLINE")
				_G.CharacterFrameTitleText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
				_G.CharacterFrameTitleText:SetShadowColor(0, 0, 0, 0.8)
				_G.CharacterFrameTitleText:SetShadowOffset(2, -1)
				_G.CharacterLevelText:ClearAllPoints()
				_G.CharacterLevelText:SetPoint('TOP', _G.CharacterFrameTitleText, 'BOTTOM', 0, 0)
				_G.CharacterLevelText:SetDrawLayer("OVERLAY")
			end)

			hooksecurefunc("CharacterFrame_Collapse", function()
				if _G.PaperDollFrame:IsShown() then
					if E.Retail then
						charactertext = _G.CharacterFrameTitleText:GetText()
						if not charactertext:match("|T") then
							_G.CharacterFrameTitleText:SetText(classsymbolonframe.." ".._G.CharacterFrameTitleText:GetText())
						end
					elseif E.TBC or E.Classic then
						charactertext = _G.CharacterFrameTitleText:GetText()
						if not charactertext:match("|T") then
							_G.CharacterNameText:SetText(classsymbolonframe.." ".._G.CharacterNameText:GetText())
						end
					end
				end
			end)

			hooksecurefunc("CharacterFrame_Expand", function()
				if _G.PaperDollFrame:IsShown() then
					if E.Retail then
						charactertext = _G.CharacterFrameTitleText:GetText()
						if not charactertext:match("|T") then
							_G.CharacterFrameTitleText:SetText(classsymbolonframe.." ".._G.CharacterFrameTitleText:GetText())
						end
					elseif E.TBC or E.Classic then
						charactertext = _G.CharacterFrameTitleText:GetText()
						if not charactertext:match("|T") then
							_G.CharacterNameText:SetText(classsymbolonframe.." ".._G.CharacterNameText:GetText())
						end
					end
				end
			end)

			hooksecurefunc("ReputationFrame_Update", function()
				if _G.ReputationFrame:IsShown() then
					if E.Retail then
						charactertext = _G.CharacterFrameTitleText:GetText()
						if not charactertext:match("|T") then
							_G.CharacterFrameTitleText:SetText(classsymbolonframe.." ".._G.CharacterFrameTitleText:GetText())
						end
					elseif E.TBC or E.Classic then
						charactertext = _G.CharacterFrameTitleText:GetText()
						if not charactertext:match("|T") then
							_G.CharacterNameText:SetText(classsymbolonframe.." ".._G.CharacterNameText:GetText())
						end
					end
				end
			end)

			hooksecurefunc("TokenFrame_Update", function()
				if _G.TokenFrame:IsShown() then
					if E.Retail then
						charactertext = _G.CharacterFrameTitleText:GetText()
						if not charactertext:match("|T") then
							_G.CharacterFrameTitleText:SetText(classsymbolonframe.." ".._G.CharacterFrameTitleText:GetText())
						end
					elseif E.TBC or E.Classic then
						charactertext = _G.CharacterFrameTitleText:GetText()
						if not charactertext:match("|T") then
							_G.CharacterNameText:SetText(classsymbolonframe.." ".._G.CharacterNameText:GetText())
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
