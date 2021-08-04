local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local CreateFrame = _G.CreateFrame
local unpack = _G.unpack
local UnitClass = _G.UnitClass
local R, G, B = unpack(E.media.rgbvaluecolor)

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
if ElvUI_EltreumUI.Retail then
	CharacterLevelText:SetWidth(300) --new
	--classFrame:Hide()
elseif ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
	CharacterLevelText:SetWidth(280) --new
end
local classsymbolonframe
local charactertext --check character text

--put the icon on the papeldoll frame, modify it a bit if SLE is not loaded
function ElvUI_EltreumUI:PlayerNamepaperdoll()
	if E.db.ElvUI_EltreumUI.skins.classiconsblizz then
			classsymbolonframe = ("|T"..(classIcons[E.myclass]..".tga:0:0:0:0|t"))
		elseif E.db.ElvUI_EltreumUI.skins.classiconsreleaf then
			classsymbolonframe = ("|T"..(classIconsReleafborder[E.myclass]..".tga:0:0:0:0|t"))
		else
			classsymbolonframe = ("|T"..(classIcons[E.myclass]..".tga:0:0:0:0|t"))
		end
	if not charactertext:match("|T") then
		_G.CharacterFrameTitleText:SetText(classsymbolonframe.." ".._G.CharacterFrameTitleText:GetText())
	end
end

function ElvUI_EltreumUI:ClassIconsOnCharacterPanel()
	if E.db.ElvUI_EltreumUI.skins.classiconsoncharacterpanel then
		if ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
					_G.CharacterNameText:ClearAllPoints()
					_G.CharacterNameText:SetPoint('TOP',  _G.CharacterModelFrame, 0, 50)
					_G.CharacterNameText:SetParent(_G.CharacterFrame)
					_G.CharacterNameText:SetFont(E.LSM:Fetch('font', E.db.general.font), 14, "OUTLINE")
					_G.CharacterNameText:SetTextColor(R, G, B)
					_G.CharacterNameText:SetShadowColor(0, 0, 0, 0.8)
					_G.CharacterNameText:SetShadowOffset(2, -1)

					_G.CharacterLevelText:ClearAllPoints()
					_G.CharacterLevelText:SetPoint('TOP', _G.CharacterNameText, 'BOTTOM', 0, -2)
		end

		if (not IsAddOnLoaded("ElvUI_SLE")) then
			if ElvUI_EltreumUI.Retail then
				hooksecurefunc('PaperDollFrame_SetLevel', function()
					_G.CharacterFrameTitleText:ClearAllPoints()
					_G.CharacterFrameTitleText:SetPoint('TOP',  _G.CharacterModelFrame, 0, 50)
					_G.CharacterFrameTitleText:SetParent(_G.CharacterFrame)
					_G.CharacterFrameTitleText:SetFont(E.LSM:Fetch('font', E.db.general.font), 14, "OUTLINE")
					_G.CharacterFrameTitleText:SetTextColor(R, G, B)
					_G.CharacterFrameTitleText:SetShadowColor(0, 0, 0, 0.8)
					_G.CharacterFrameTitleText:SetShadowOffset(2, -1)
					_G.CharacterLevelText:ClearAllPoints()
					_G.CharacterLevelText:SetPoint('TOP', _G.CharacterFrameTitleText, 'BOTTOM', 0, 0)
				end)

				hooksecurefunc("CharacterFrame_Collapse", function()
					if _G.PaperDollFrame:IsShown() then
						_G.CharacterFrame:SetWidth(500)
						if ElvUI_EltreumUI.Retail then
							charactertext = _G.CharacterFrameTitleText:GetText()
							if not charactertext:match("|T") then
								_G.CharacterFrameTitleText:SetText(classsymbolonframe.." ".._G.CharacterFrameTitleText:GetText())
							end
						elseif ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
							charactertext = _G.CharacterFrameTitleText:GetText()
							if not charactertext:match("|T") then
								_G.CharacterNameText:SetText(classsymbolonframe.." ".._G.CharacterNameText:GetText())
							end
						end
					end
				end)

				hooksecurefunc("CharacterFrame_Expand", function()
					if _G.PaperDollFrame:IsShown() then
						_G.CharacterFrame:SetWidth(700)
						if ElvUI_EltreumUI.Retail then
							charactertext = _G.CharacterFrameTitleText:GetText()
							if not charactertext:match("|T") then
								_G.CharacterFrameTitleText:SetText(classsymbolonframe.." ".._G.CharacterFrameTitleText:GetText())
							end
						elseif ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
							charactertext = _G.CharacterFrameTitleText:GetText()
							if not charactertext:match("|T") then
								_G.CharacterNameText:SetText(classsymbolonframe.." ".._G.CharacterNameText:GetText())
							end
						end
					end
				end)
				_G.CharacterFrame:SetHeight(500)

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
			end
		elseif IsAddOnLoaded("ElvUI_SLE") then

			hooksecurefunc("CharacterFrame_Collapse", function()
				if _G.PaperDollFrame:IsShown() then
					charactertext = _G.CharacterFrameTitleText:GetText()
					if not charactertext:match("|T") then
						_G.CharacterFrameTitleText:SetText(classsymbolonframe.." ".._G.CharacterFrameTitleText:GetText())
					end
					_G.CharacterFrameTitleText:SetFont(E.LSM:Fetch('font', E.db.general.font), 14, "OUTLINE")
					_G.CharacterFrameTitleText:SetTextColor(R, G, B)
					_G.CharacterFrameTitleText:SetShadowColor(0, 0, 0, 0.8)
					_G.CharacterFrameTitleText:SetShadowOffset(2, -1)
				end
			end)

			hooksecurefunc("CharacterFrame_Expand", function()
				if _G.PaperDollFrame:IsShown() then
					charactertext = _G.CharacterFrameTitleText:GetText()
					if not charactertext:match("|T") then
						_G.CharacterFrameTitleText:SetText(classsymbolonframe.." ".._G.CharacterFrameTitleText:GetText())
					end
					_G.CharacterFrameTitleText:SetFont(E.LSM:Fetch('font', E.db.general.font), 14, "OUTLINE")
					_G.CharacterFrameTitleText:SetTextColor(R, G, B)
					_G.CharacterFrameTitleText:SetShadowColor(0, 0, 0, 0.8)
					_G.CharacterFrameTitleText:SetShadowOffset(2, -1)
				end
			end)

		end

		--[[if ElvUI_EltreumUI.Retail then
			--classFrame:Hide()

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
		elseif ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then]]--

		if E.db.ElvUI_EltreumUI.skins.classiconsblizz then
			classsymbolonframe = ("|T"..(classIcons[E.myclass]..".tga:0:0:0:0|t"))
		elseif E.db.ElvUI_EltreumUI.skins.classiconsreleaf then
			classsymbolonframe = ("|T"..(classIconsReleafborder[E.myclass]..".tga:0:0:0:0|t"))
		else
			classsymbolonframe = ("|T"..(classIcons[E.myclass]..".tga:0:0:0:0|t"))
		end

		if ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
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
			--local gapretail = totalgap/4
			classFrame:SetPoint("RIGHT", "CharacterLevelText", -gapclassic, 0)
		end
	end
end
