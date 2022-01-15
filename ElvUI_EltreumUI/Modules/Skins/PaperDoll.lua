local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local CreateFrame = _G.CreateFrame
local unpack = _G.unpack
--local UnitClass = _G.UnitClass --currently unused
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
elseif ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
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
	else
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
			_G.CharacterFrameTitleText:SetText(classsymbolonframe.." ".._G.CharacterFrameTitleText:GetText())
		end
	end
end

function ElvUI_EltreumUI:ClassIconsOnCharacterPanel()
	if E.db.ElvUI_EltreumUI.skins.classiconsoncharacterpanel then
		if ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
			_G.CharacterNameText:ClearAllPoints()

			if E.db.ElvUI_EltreumUI.skins.classicarmory then
				_G.CharacterNameText:SetPoint('TOP', _G.CharacterModelFrame, 0, 80)
			else
				_G.CharacterNameText:SetPoint('TOP', _G.CharacterModelFrame, 0, 50)
			end
			_G.CharacterNameText:SetParent(_G.CharacterModelFrame)
			_G.CharacterNameText:SetFont(E.LSM:Fetch('font', E.db.general.font), 18, "OUTLINE")
			_G.CharacterNameText:SetTextColor(R, G, B)
			_G.CharacterNameText:SetShadowColor(0, 0, 0, 0.8)
			_G.CharacterNameText:SetShadowOffset(2, -1)

			_G.CharacterLevelText:ClearAllPoints()
			if E.db.ElvUI_EltreumUI.skins.classicarmory then
				_G.CharacterLevelText:SetPoint('TOP', _G.CharacterNameText, 'BOTTOM', 0, -10)
			else
				_G.CharacterLevelText:SetPoint('TOP', _G.CharacterNameText, 'BOTTOM', 0, -7)
			end

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

		elseif ElvUI_EltreumUI.Retail then
			if (not IsAddOnLoaded("ElvUI_SLE")) or not E.db.sle.armory.character.enable then

				hooksecurefunc('PaperDollFrame_SetLevel', function()
					_G.CharacterFrameTitleText:ClearAllPoints()
					_G.CharacterFrameTitleText:SetPoint('TOP', _G.CharacterModelFrame, 0, 50)
					_G.CharacterFrameTitleText:SetParent(_G.CharacterFrame)
					_G.CharacterFrameTitleText:SetFont(E.LSM:Fetch('font', E.db.general.font), 14, "OUTLINE")
					_G.CharacterFrameTitleText:SetTextColor(R, G, B)
					_G.CharacterFrameTitleText:SetShadowColor(0, 0, 0, 0.8)
					_G.CharacterFrameTitleText:SetShadowOffset(2, -1)
					_G.CharacterLevelText:ClearAllPoints()
					_G.CharacterLevelText:SetPoint('TOP', _G.CharacterFrameTitleText, 'BOTTOM', 0, 0)
					_G.CharacterLevelText:SetDrawLayer("OVERLAY")
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
				if E.db.ElvUI_EltreumUI.skins.expandarmorybg then
					_G.CharacterModelFrameBackgroundTopLeft:ClearAllPoints()
					_G.CharacterModelFrameBackgroundTopLeft:SetAllPoints(_G.CharacterFrame)
					_G.CharacterModelFrameBackgroundTopLeft:SetParent(_G.CharacterFrame)
					_G.CharacterModelFrameBackgroundTopLeft:SetDrawLayer("ARTWORK")

					_G.CharacterModelFrameBackgroundOverlay:ClearAllPoints()
					_G.CharacterModelFrameBackgroundOverlay:SetAllPoints(_G.CharacterFrame)
					_G.CharacterModelFrameBackgroundOverlay:SetParent(_G.CharacterFrame)
					_G.CharacterModelFrameBackgroundOverlay:SetDrawLayer("OVERLAY")
				end


			elseif IsAddOnLoaded("ElvUI_SLE") and E.db.sle.armory.character.enable then

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

				_G.CharacterLevelText:SetDrawLayer("OVERLAY")
				_G.CharacterLevelText:SetParent(_G.CharacterFrame)

				--move the artwork
				if E.db.ElvUI_EltreumUI.skins.expandarmorybg then
					_G.PaperDollFrame.SLE_Armory_BG:ClearAllPoints()
					_G.PaperDollFrame.SLE_Armory_BG:SetAllPoints(_G.CharacterFrame)
					_G.PaperDollFrame.SLE_Armory_BG:SetParent(_G.CharacterFrame)
					_G.PaperDollFrame.SLE_Armory_BG:SetDrawLayer("ARTWORK")
					--show the background overlay so its not bright
					_G.CharacterModelFrameBackgroundOverlay:Show()
					_G.CharacterModelFrameBackgroundOverlay:ClearAllPoints()
					_G.CharacterModelFrameBackgroundOverlay:SetAllPoints(_G.CharacterFrame)
					_G.CharacterModelFrameBackgroundOverlay:SetParent(_G.CharacterFrame)
					_G.CharacterModelFrameBackgroundOverlay:SetDrawLayer("OVERLAY")
				end

			end
		end
	end
end

--attempt at recreating a similar character panel to retail
local CharacterFrame = _G.CharacterFrame
CharacterFrame.Text2 = CharacterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
function ElvUI_EltreumUI:ExpandedCharacterStats()
	if ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
		if E.db.ElvUI_EltreumUI.skins.classicarmory then

			if CharacterFrame then
				CharacterFrame:SetSize(600, 505)

				CharacterFrame.Text = CharacterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
				CharacterFrame.StatusLine = CreateFrame("StatusBar", "EltruismCharacterBar2", CharacterFrame)

				CharacterFrame.StatusLine2 = CreateFrame("StatusBar", "EltruismCharacterBar1", CharacterFrame)
				CharacterFrame.Text3 = CharacterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
				CharacterFrame.StatusLine3 = CreateFrame("StatusBar", "EltruismCharacterBar2", CharacterFrame)


				CharacterFrame.Text:SetSize(418, 72)
				CharacterFrame.Text:SetPoint("TOP", CharacterFrame, "TOP", 150, 0)
				CharacterFrame.Text:SetTextColor(1, 1, 1)
				CharacterFrame.Text:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, "OUTLINE")
				CharacterFrame.Text:SetText("Item Level")


				CharacterFrame.StatusLine:SetSize(150, 3)
				CharacterFrame.StatusLine:SetPoint("CENTER", CharacterFrame.Text, "CENTER", 0, -15)
				CharacterFrame.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				CharacterFrame.StatusLine:SetStatusBarColor(R, G, B, 1)


				CharacterFrame.Text2:SetSize(418, 72)
				CharacterFrame.Text2:SetPoint("TOP", CharacterFrame, "TOP", 150, -45)
				CharacterFrame.Text2:SetTextColor(R, G, B)
				CharacterFrame.Text2:SetFont(E.LSM:Fetch("font", E.db.general.font), 28, "OUTLINE")


				CharacterFrame.StatusLine2:SetFrameStrata("LOW")
				CharacterFrame.StatusLine2:SetSize(200, 30)
				CharacterFrame.StatusLine2:SetPoint("CENTER", CharacterFrame.Text2, "CENTER", 0, 0)
				CharacterFrame.StatusLine2:SetStatusBarTexture(E.Media.Textures.Highlight)
				CharacterFrame.StatusLine2:SetStatusBarColor(1, 1, 1, 1)


				CharacterFrame.Text3:SetSize(418, 72)
				CharacterFrame.Text3:SetPoint("TOP", CharacterFrame, "TOP", 150, -80)
				CharacterFrame.Text3:SetTextColor(1, 1, 1)
				CharacterFrame.Text3:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, "OUTLINE")
				CharacterFrame.Text3:SetText("Attributes")


				CharacterFrame.StatusLine3:SetSize(150, 3)
				CharacterFrame.StatusLine3:SetPoint("CENTER", CharacterFrame.Text3, "CENTER", 0, -15)
				CharacterFrame.StatusLine3:SetStatusBarTexture(E.Media.Textures.Highlight)
				CharacterFrame.StatusLine3:SetStatusBarColor(R, G, B, 1)

				_G.CharacterModelFrame:ClearAllPoints()
				_G.CharacterModelFrame:SetPoint("RIGHT", CharacterFrame, "CENTER", -20, 0)
				_G.CharacterModelFrame:SetSize(200, 300)

				_G.CharacterModelFrameRotateRightButton:Hide()
				_G.CharacterModelFrameRotateLeftButton:Hide()

				if ElvUI_EltreumUI.TBC then
					_G.PlayerStatFrameLeftDropDown:ClearAllPoints()
					_G.PlayerStatFrameLeftDropDown:SetPoint("TOP", CharacterFrame, "TOP", 150, -160)
					_G.PlayerStatFrameLeftDropDown:SetParent(CharacterFrame)
					_G.MagicResFrame1:ClearAllPoints()
					_G.MagicResFrame1:SetPoint("LEFT", _G.PlayerStatFrameLeftDropDown, "LEFT", -10, 0)
					_G.MagicResFrame1:SetParent(_G.PlayerStatFrameLeft1)
					_G.MagicResFrame2:SetParent(_G.PlayerStatFrameLeft1)
					_G.MagicResFrame3:SetParent(_G.PlayerStatFrameLeft1)
					_G.MagicResFrame4:SetParent(_G.PlayerStatFrameLeft1)
					_G.MagicResFrame5:SetParent(_G.PlayerStatFrameLeft1)
				elseif ElvUI_EltreumUI.Classic then
					_G.MagicResFrame1:ClearAllPoints()
					_G.MagicResFrame1:SetPoint("LEFT", _G.CharacterStatFrame1, "LEFT", -30, -8)
					_G.MagicResFrame1:SetParent(_G.CharacterStatFrame1)
					_G.MagicResFrame2:SetParent(_G.CharacterStatFrame1)
					_G.MagicResFrame3:SetParent(_G.CharacterStatFrame1)
					_G.MagicResFrame4:SetParent(_G.CharacterStatFrame1)
					_G.MagicResFrame5:SetParent(_G.CharacterStatFrame1)
				end

				if ElvUI_EltreumUI.TBC then
					_G.PlayerStatFrameLeft1:ClearAllPoints()
					_G.PlayerStatFrameLeft1:SetPoint("TOP", CharacterFrame, "TOP", 150, -185)
					_G.PlayerStatFrameLeft1:SetParent(CharacterFrame)
					_G.PlayerStatFrameLeft2:SetParent(_G.PlayerStatFrameLeft1)
					_G.PlayerStatFrameLeft3:SetParent(_G.PlayerStatFrameLeft1)
					_G.PlayerStatFrameLeft4:SetParent(_G.PlayerStatFrameLeft1)
					_G.PlayerStatFrameLeft5:SetParent(_G.PlayerStatFrameLeft1)
					_G.PlayerStatFrameLeft6:SetParent(_G.PlayerStatFrameLeft1)
				elseif ElvUI_EltreumUI.Classic then
					_G.CharacterStatFrame1:ClearAllPoints()
					_G.CharacterStatFrame1:SetPoint("TOP", CharacterFrame, "TOP", 150, -185)
					_G.CharacterStatFrame1:SetParent(CharacterFrame)
					_G.CharacterStatFrame2:SetParent(_G._G.CharacterStatFrame1)
					_G.CharacterStatFrame3:SetParent(_G._G.CharacterStatFrame1)
					_G.CharacterStatFrame4:SetParent(_G._G.CharacterStatFrame1)
					_G.CharacterStatFrame5:SetParent(_G._G.CharacterStatFrame1)
					_G.CharacterArmorFrame:SetParent(_G._G.CharacterStatFrame1)
				end

				if ElvUI_EltreumUI.TBC then
					_G.PlayerStatFrameRightDropDown:ClearAllPoints()
					_G.PlayerStatFrameRightDropDown:SetPoint("TOP", CharacterFrame, "TOP", 150, -270)
					_G.PlayerStatFrameRightDropDown:SetParent(CharacterFrame)
					_G.PlayerStatFrameRight1:ClearAllPoints()
					_G.PlayerStatFrameRight1:SetPoint("TOP", CharacterFrame, "TOP", 150, -295)
					_G.PlayerStatFrameRight1:SetParent(CharacterFrame)
					_G.PlayerStatFrameRight2:SetParent(_G.PlayerStatFrameRight1)
					_G.PlayerStatFrameRight3:SetParent(_G.PlayerStatFrameRight1)
					_G.PlayerStatFrameRight4:SetParent(_G.PlayerStatFrameRight1)
					_G.PlayerStatFrameRight5:SetParent(_G.PlayerStatFrameRight1)
					_G.PlayerStatFrameRight6:SetParent(_G.PlayerStatFrameRight1)
				elseif ElvUI_EltreumUI.Classic then
					_G.CharacterAttackFrame:ClearAllPoints()
					_G.CharacterAttackFrame:SetPoint("TOP", CharacterFrame, "TOP", 150, -295)
					_G.CharacterAttackFrame:SetParent(CharacterFrame)
					_G.CharacterAttackPowerFrame:SetParent(_G._G.CharacterStatFrame1)
					_G.CharacterDamageFrame:SetParent(_G._G.CharacterStatFrame1)
					_G.CharacterRangedAttackFrame:SetParent(_G._G.CharacterStatFrame1)
					_G.CharacterRangedAttackPowerFrame:SetParent(_G._G.CharacterStatFrame1)
					_G.CharacterRangedDamageFrame:SetParent(_G._G.CharacterStatFrame1)
				end

				_G.SkillFrame:SetHeight(400)
				_G.SkillDetailScrollChildFrame:ClearAllPoints()
				_G.SkillDetailScrollChildFrame:SetPoint("BOTTOMLEFT", CharacterFrame, "BOTTOMLEFT", 30, 150)
				_G.SkillDetailScrollChildFrame:SetParent(_G.SkillFrame)

				_G.SkillFrameCancelButton:Hide()
			end


		end
	end
end


--test memory things
--from Simple Item Levels by Kemayo (BSD License) with some edits by Eltreum
local function PrepareItemButton(button)
	if button.eltruismilvl then
		return
	end
	local overlayFrame = CreateFrame("FRAME", nil, button)
	--overlayFrame:SetFrameLevel(9999) -- this was bugging out inspect
	overlayFrame:SetAllPoints()
	button.eltruismilvl = overlayFrame:CreateFontString('$parentItemLevel', 'OVERLAY')
	button.eltruismilvl:SetPoint('CENTER', 0, 0)
	button.eltruismilvl:SetFont(E.LSM:Fetch("font", E.db.general.font), 16, "THICKOUTLINE")
	button.eltruismilvl:SetJustifyH('LEFT')
	--button.eltruismilvl:Hide()
end



--local memorystart = collectgarbage("count")
function ElvUI_EltreumUI:UpdateAvgIlvl()

	--[[if not InCombatLockdown() then
		local aftercombat = collectgarbage("count")
		if aftercombat > memorystart then
			collectgarbage("collect")
			ResetCPUUsage()
			print("Collected " .. (aftercombat-collectgarbage("count")) .. " kB of garbage");
		else
			print("Not enough memory usage to collect garbage yet")
		end
	else
		print("in combat cannot collect without issue")
	end]]

	if ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
		if E.db.ElvUI_EltreumUI.skins.classicarmory then


			local numberofslots = 0


			local function AddLevelToButton(button, itemLevel, itemQuality)
				if not itemLevel then
					return button.eltruismilvl and button.eltruismilvl:Hide()
				end
				PrepareItemButton(button)
				local _, _, _, hex = GetItemQualityColor(itemQuality)
				button.eltruismilvl:SetFormattedText('|c%s%s|r', hex, itemLevel or '?')
				button.eltruismilvl:Show()
			end

			local function GetItemQualityAndLevel(unit, slotID)
				-- link is more reliably fetched than ID, for whatever reason
				local itemLink = GetInventoryItemLink(unit, slotID)
				if itemLink ~= nil then
					local quality = GetInventoryItemQuality(unit, slotID)
					local level = GetDetailedItemLevelInfo(itemLink)
					return quality, level
				end
			end

			local ilvltable ={}

			local _, ilvl1 = GetItemQualityAndLevel("player", 1)
			local _, ilvl2 = GetItemQualityAndLevel("player", 2)
			local _, ilvl3 = GetItemQualityAndLevel("player", 3)
			local _, ilvl4 = GetItemQualityAndLevel("player", 4)
			local _, ilvl5 = GetItemQualityAndLevel("player", 5)
			local _, ilvl6 = GetItemQualityAndLevel("player", 6)
			local _, ilvl7 = GetItemQualityAndLevel("player", 7)
			local _, ilvl8 = GetItemQualityAndLevel("player", 8)
			local _, ilvl9 = GetItemQualityAndLevel("player", 9)
			local _, ilvl10 = GetItemQualityAndLevel("player", 10)
			local _, ilvl11 = GetItemQualityAndLevel("player", 11)
			local _, ilvl12 = GetItemQualityAndLevel("player", 12)
			local _, ilvl13 = GetItemQualityAndLevel("player", 13)
			local _, ilvl14 = GetItemQualityAndLevel("player", 14)
			local _, ilvl15 = GetItemQualityAndLevel("player", 15)
			local _, ilvl16 = GetItemQualityAndLevel("player", 16)
			local _, ilvl17 = GetItemQualityAndLevel("player", 17)
			local _, ilvl18 = GetItemQualityAndLevel("player", 18)
			local _, ilvl19 = GetItemQualityAndLevel("player", 19)
			local _, ilvl20 = GetItemQualityAndLevel("player", 20)

			table.insert(ilvltable, ilvl1)
			table.insert(ilvltable, ilvl2)
			table.insert(ilvltable, ilvl3)
			table.insert(ilvltable, ilvl4)
			table.insert(ilvltable, ilvl5)
			table.insert(ilvltable, ilvl6)
			table.insert(ilvltable, ilvl7)
			table.insert(ilvltable, ilvl8)
			table.insert(ilvltable, ilvl9)
			table.insert(ilvltable, ilvl10)
			table.insert(ilvltable, ilvl11)
			table.insert(ilvltable, ilvl12)
			table.insert(ilvltable, ilvl13)
			table.insert(ilvltable, ilvl14)
			table.insert(ilvltable, ilvl15)
			table.insert(ilvltable, ilvl16)
			table.insert(ilvltable, ilvl17)
			table.insert(ilvltable, ilvl18)
			table.insert(ilvltable, ilvl19)
			table.insert(ilvltable, ilvl20)

			local totalilvl = 0
			local numslots = 0
			for index, data in pairs(ilvltable) do
				--print(index.." slot "..data.." ilvl")
				totalilvl = totalilvl + data
				numslots = index
			end

			if numslots <= 15 then
				numslots = 15
			elseif numslots >= 17 then
				numslots = 17
			end
			print(totalilvl)
			--CharacterFrame.Text2:Hide()
			CharacterFrame.Text2:SetText((math.floor((totalilvl/numslots)*100))/100)
			--CharacterFrame.Text2:Show()
			local ilvltable ={}



			local function UpdateItemSlotButton(button, unit)
				if button.eltruismilvl then button.eltruismilvl:Hide() end
				local slotID = button:GetID()
				--print(slotID)
				if (slotID >= INVSLOT_FIRST_EQUIPPED and slotID <= INVSLOT_LAST_EQUIPPED) then
					if unit == "player" then
						local item = Item:CreateFromEquipmentSlot(slotID)
						if item:IsItemEmpty() then
							return
						end
						return item:ContinueOnItemLoad(function()
							AddLevelToButton(button, item:GetCurrentItemLevel(), item:GetItemQuality())
						end)
					else
						local itemQuality, itemLevel = GetItemQualityAndLevel(unit, slotID)
						if itemLevel then
							return AddLevelToButton(button, itemLevel, itemQuality)
						end
					end
				end
				return button.eltruismilvl and button.eltruismilvl:Hide()
			end
			hooksecurefunc("PaperDollItemSlotButton_Update", function(button)
				UpdateItemSlotButton(button, "player")
			end)

			if not IsAddOnLoaded("Blizzard_InspectUI") then
				LoadAddOn("Blizzard_InspectUI")
			end
			hooksecurefunc("InspectPaperDollItemSlotButton_Update", function(button)
				UpdateItemSlotButton(button, "target")
			end)
		end
	end
end
