local E, L = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local classcolor = E.myClassColor
local CreateFrame = _G.CreateFrame
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded
local hooksecurefunc = _G.hooksecurefunc
local pairs = _G.pairs
local GetNumQuestWatches = _G.GetNumQuestWatches
local GetQuestLogLeaderBoard = _G.GetQuestLogLeaderBoard
local GetQuestIndexForWatch = _G.GetQuestIndexForWatch
local QuestLogTrackTracking = _G.QuestLogTrackTracking
local GetQuestLogTitle = _G.GetQuestLogTitle
local UIParent_ManageFramePositions = _G.UIParent_ManageFramePositions
local select = _G.select
local ScenarioObjectiveBlockBackground
local wowheadbutton = CreateFrame("Button", nil)
local dontexpandanymorequests = 0
if E.Retail then
	ScenarioObjectiveBlockBackground = CreateFrame("Frame", "EltruismScenarioBlockBg")
	S:HandleFrame(ScenarioObjectiveBlockBackground)
end
local format = _G.format
local C_QuestLog = _G.C_QuestLog
local ObjectiveTrackerFrame = _G.ObjectiveTrackerFrame
local math = _G.math
local Enum = _G.Enum
local InCombatLockdown = _G.InCombatLockdown
local tonumber = _G.tonumber
local strmatch = _G.strmatch
local string = _G.string
local unpack = _G.unpack
local GetNumQuestLeaderBoards = _G.GetNumQuestLeaderBoards
local GetNumQuestLogEntries = _G.GetNumQuestLogEntries
local UpdateWidgetLayoutHook = _G.UpdateWidgetLayoutHook
local QuestMapFrame_GetDetailQuestID = _G.QuestMapFrame_GetDetailQuestID
local questside

--skin objective frame depending on verison
function ElvUI_EltreumUI:SkinQuests()

	--create the button for wowhead
	if E.db.ElvUI_EltreumUI.skins.questswowhead then
		if E.Retail then
			wowheadbutton:SetWidth(80)
			wowheadbutton:SetHeight(20)
			wowheadbutton:SetParent(_G.WorldMapFrame)
			wowheadbutton:SetPoint("TOPRIGHT", _G.WorldMapFrame, "TOPRIGHT", -80, 0)
		elseif E.Classic then
			local x, y = _G.QuestFramePushQuestButton:GetSize()
			wowheadbutton:SetWidth(x)
			wowheadbutton:SetHeight(y)
			wowheadbutton:SetParent(_G.QuestLogFrame)
			if E.db.ElvUI_EltreumUI.skins.quests then
				wowheadbutton:SetPoint("LEFT", _G.QuestFramePushQuestButton, "LEFT", -x-2, 0)
			else
				wowheadbutton:SetPoint("TOPLEFT", _G.QuestLogFrame, "TOPLEFT", 15, -15)
			end
		elseif E.Mists then
			local x, y = _G.QuestLogFrameTrackButton:GetSize()
			wowheadbutton:SetWidth(x)
			wowheadbutton:SetHeight(y)
			wowheadbutton:SetParent(_G.QuestLogFrame)
			wowheadbutton:SetPoint("LEFT", _G.QuestLogFrameTrackButton, "RIGHT", 2, 0)
		end
		wowheadbutton:SetText("Wowhead")
		wowheadbutton:SetNormalFontObject("GameFontNormal")
		--let elvui handle the button skin
		S:HandleButton(wowheadbutton)
		--get the wowhead region based on game language region
		local wowheadregion
		if E.Retail then
			if E.locale == "deDE" then
				wowheadregion = "de.wowhead.com"
			elseif E.locale == "enUS" or E.locale == "enCN" or E.locale == "enGB" or E.locale == "enTW" then
				wowheadregion = "wowhead.com"
			elseif E.locale == "esMX" or E.locale == "esES" then
				wowheadregion = "es.wowhead.com"
			elseif E.locale == "frFR" then
				wowheadregion = "fr.wowhead.com"
			elseif E.locale == "itIT" then
				wowheadregion = "it.wowhead.com"
			elseif E.locale == "koKR" then
				wowheadregion = "ko.wowhead.com"
			elseif E.locale == "ptBR" or E.locale == "ptPT" then
				wowheadregion = "pt.wowhead.com"
			elseif E.locale == "ruRU" then
				wowheadregion = "ru.wowhead.com"
			elseif E.locale == "zhCN" or E.locale == "zhTW" then
				wowheadregion = "cn.wowhead.com"
			end
		elseif E.Mists then
			if E.locale == "deDE" then
				wowheadregion = "wowhead.com/mop-classic/de"
			elseif E.locale == "enUS" or E.locale == "enCN" or E.locale == "enGB" or E.locale == "enTW" then
				wowheadregion = "wowhead.com/mop-classic"
			elseif E.locale == "esMX" or E.locale == "esES" then
				wowheadregion = "wowhead.com/mop-classic/es"
			elseif E.locale == "frFR" then
				wowheadregion = "wowhead.com/mop-classic/fr"
			elseif E.locale == "itIT" then
				wowheadregion = "wowhead.com/mop-classic/it"
			elseif E.locale == "koKR" then
				wowheadregion = "wowhead.com/mop-classic/ko"
			elseif E.locale == "ptBR" or E.locale == "ptPT" then
				wowheadregion = "wowhead.com/mop-classic/pt"
			elseif E.locale == "ruRU" then
				wowheadregion = "wowhead.com/mop-classic/ru"
			elseif E.locale == "zhCN" or E.locale == "zhTW" then
				wowheadregion = "wowhead.com/mop-classic/cn"
			end
		elseif E.Classic then
			if E.locale == "deDE" then
				wowheadregion = "de.classic.wowhead.com"
			elseif E.locale == "enUS" or E.locale == "enCN" or E.locale == "enGB" or E.locale == "enTW" then
				wowheadregion = "classic.wowhead.com"
			elseif E.locale == "esMX" or E.locale == "esES" then
				wowheadregion = "es.classic.wowhead.com"
			elseif E.locale == "frFR" then
				wowheadregion = "fr.classic.wowhead.com"
			elseif E.locale == "itIT" then
				wowheadregion = "it.classic.wowhead.com"
			elseif E.locale == "koKR" then
				wowheadregion = "ko.classic.wowhead.com"
			elseif E.locale == "ptBR" or E.locale == "ptPT" then
				wowheadregion = "pt.classic.wowhead.com"
			elseif E.locale == "ruRU" then
				wowheadregion = "ru.classic.wowhead.com"
			elseif E.locale == "zhCN" or E.locale == "zhTW" then
				wowheadregion = "cn.classic.wowhead.com"
			end
		end
		--register the button for clicks
		wowheadbutton:RegisterForClicks("AnyUp")

		--get questid
		if E.Retail then
			local questID
			local getquestid = CreateFrame("FRAME")
			getquestid:RegisterEvent("QUEST_DATA_LOAD_RESULT")
			getquestid:RegisterEvent("QUEST_LOG_UPDATE")
			getquestid:SetScript("OnEvent", function()
				questID = QuestMapFrame_GetDetailQuestID()
				if questID ~= nil then
					questID = questID
				elseif questID == nil then
					questID = _G.C_SuperTrack.GetSuperTrackedQuestID()
				end
			end)
			--set the link to show when the button is clicked
			wowheadbutton:SetScript('OnClick', function()
				if questID and questID ~= 0 then
					E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, "https://"..wowheadregion.."/quest="..questID)
				else
					E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, L["No quest selected"])
				end
			end)
		elseif E.Classic then
			local questID
			--hook the function that sets the quest detail to get the questID from the quest title
			hooksecurefunc("QuestLog_SetSelection", function(questTitle) --questlogframe.lua 311
				questID = select(8, GetQuestLogTitle(questTitle))
			end)
			--set the link to show when the button is clicked
			wowheadbutton:SetScript('OnClick', function()
				E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, "https://"..wowheadregion.."/quest="..questID)
			end)
		elseif E.Mists then
			local questID
			--hook the function that sets the quest detail to get the questID from the quest title
			hooksecurefunc("QuestLog_SetSelection", function(questTitle) --_G.QuestLogFrame.lua 311
				questID = select(8, GetQuestLogTitle(questTitle))
			end)
			--set the link to show when the button is clicked
			wowheadbutton:SetScript('OnClick', function()
				E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, "https://"..wowheadregion.."/quest="..questID)
			end)
		end
	else
		wowheadbutton:Hide()
	end

	if E.db.ElvUI_EltreumUI.skins.quests and E.private.skins.blizzard.objectiveTracker and E.private.skins.blizzard.enable then


		--option to change the quest scale
		if _G["QuestFrame"] then
			_G["QuestFrame"]:HookScript("OnShow", function()
				_G["QuestFrame"]:SetScale(E.db.ElvUI_EltreumUI.skins.questsettings.questScale)
			end)
		end
		if _G["QuestLogFrame"] then
			_G["QuestLogFrame"]:HookScript("OnShow", function()
				_G["QuestLogFrame"]:SetScale(E.db.ElvUI_EltreumUI.skins.questsettings.questScale)
			end)
		end
		if _G["QuestLogDetailFrame"] then
			_G["QuestLogDetailFrame"]:HookScript("OnShow", function()
				_G["QuestLogDetailFrame"]:SetScale(E.db.ElvUI_EltreumUI.skins.questsettings.questScale)
			end)
		end
		if _G["GossipFrame"] then
			_G["GossipFrame"]:HookScript("OnShow", function()
				_G["GossipFrame"]:SetScale(E.db.ElvUI_EltreumUI.skins.questsettings.questScale)
			end)
		end

		if E.Retail then
			if (not IsAddOnLoaded('!KalielsTracker')) and (not IsAddOnLoaded('SorhaQuestLog')) and (not IsAddOnLoaded('ClassicQuestLog')) and (not IsAddOnLoaded('Who Framed Watcher Wabbit?')) then
				--WQs banner
				local ObjectiveTrackerBonusBannerFrame = _G.ObjectiveTrackerTopBannerFrame --renamed?
				if ObjectiveTrackerBonusBannerFrame then
					--textcoords from https://www.townlong-yak.com/framexml/39229/Helix/AtlasInfo.lua
					ObjectiveTrackerBonusBannerFrame.Title:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
					ObjectiveTrackerBonusBannerFrame.Title:SetShadowOffset(2,-2)
					ObjectiveTrackerBonusBannerFrame.Title:SetText("") --so that the text doesn't show up when it shouldnt
					ObjectiveTrackerBonusBannerFrame.Subtitle:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
					ObjectiveTrackerBonusBannerFrame.Subtitle:SetShadowOffset(2,-2)
					ObjectiveTrackerBonusBannerFrame.Subtitle:SetText("") --so that the text doesn't show up when it shouldnt
					ObjectiveTrackerBonusBannerFrame.UpLineGlow:SetDesaturated(true)
					ObjectiveTrackerBonusBannerFrame.UpLine:SetDesaturated(true)
					ObjectiveTrackerBonusBannerFrame.DownLineGlow:SetDesaturated(true)
					ObjectiveTrackerBonusBannerFrame.DownLine:SetDesaturated(true)
					ObjectiveTrackerBonusBannerFrame.Filigree:SetDesaturated(true)
					ObjectiveTrackerBonusBannerFrame.FiligreeGlow:SetDesaturated(true)
					ObjectiveTrackerBonusBannerFrame.UpLineGlow:SetVertexColor(classcolor.r, classcolor.g, classcolor.b) --bonusobjectives-title-bg
					ObjectiveTrackerBonusBannerFrame.UpLine:SetVertexColor(classcolor.r, classcolor.g, classcolor.b) --bonusobjectives-title-bg
					ObjectiveTrackerBonusBannerFrame.DownLineGlow:SetVertexColor(classcolor.r, classcolor.g, classcolor.b) --bonusobjectives-title-bg
					ObjectiveTrackerBonusBannerFrame.DownLine:SetVertexColor(classcolor.r, classcolor.g, classcolor.b) --bonusobjectives-title-bg
					ObjectiveTrackerBonusBannerFrame.Filigree:SetVertexColor(classcolor.r, classcolor.g, classcolor.b) --bonusobjectives-title-icon
					ObjectiveTrackerBonusBannerFrame.FiligreeGlow:SetVertexColor(classcolor.r, classcolor.g, classcolor.b) --bonusobjectives-title-icon
				end

				if _G.ObjectiveFrameMover then
					questside = _G.ObjectiveFrameMover:GetPoint()
				else
					questside = _G.ObjectiveTrackerFrame:GetPoint()
				end

				if _G.ObjectiveTrackerFrame and _G.ObjectiveTrackerFrame.HeaderMenu and _G.ObjectiveTrackerFrame.HeaderMenu.Title then --fix when collapsed
					_G.ObjectiveTrackerFrame.HeaderMenu.Title:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSizeHeader, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
					_G.ObjectiveTrackerFrame.HeaderMenu.Title:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
				end
				if _G.ObjectiveTrackerFrame and _G.ObjectiveTrackerFrame.Header and _G.ObjectiveTrackerFrame.Header.Text then --its the all objectives thing
					_G.ObjectiveTrackerFrame.Header.Text:SetText("")
					_G.ObjectiveTrackerFrame.Header.Text.SetText = E.noop
					if _G.ObjectiveTrackerFrame.Header.EltruismStatusLine then
						_G.ObjectiveTrackerFrame.Header.EltruismStatusLine:Kill()
					end
				end

				local mult = 0.85

				--skin the progress bars
				local function EltreumSkinProgressBars(line)
					local bar = line
					if not bar then return end

					if not InCombatLockdown() then
						if bar.Icon and bar.Icon:IsVisible() then
							bar.Icon:ClearAllPoints()
							bar.Icon:Point('LEFT', bar, 'RIGHT', E.PixelMode and 3 or 7, 0)
							bar.Icon:SetMask('')
							bar.Icon:SetTexCoord(unpack(E.TexCoords))

							if not bar.BarFrame.backdrop then
								bar.BarFrame:CreateBackdrop()
								bar.BarFrame.backdrop:SetOutside(bar.Icon)
								if E.db.ElvUI_EltreumUI.skins.shadow.enable and not E.db.ElvUI_EltreumUI.borders.universalborders then
									if not bar.BarFrame.backdrop.shadow then
										bar.BarFrame.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
										ElvUI_EltreumUI:ShadowColor(bar.BarFrame.backdrop.shadow)
									end
								end
								bar.BarFrame.backdrop:SetShown(bar.Icon:IsShown())
							else
								bar.BarFrame.backdrop:SetOutside(bar.Icon)
								if E.db.ElvUI_EltreumUI.skins.shadow.enable and not E.db.ElvUI_EltreumUI.borders.universalborders then
									if not bar.BarFrame.backdrop.shadow then
										bar.BarFrame.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
										ElvUI_EltreumUI:ShadowColor(bar.BarFrame.backdrop.shadow)
									end
								end
								bar.BarFrame.backdrop:SetShown(bar.Icon:IsShown())
							end
						end

						if not bar.EltruismSkin then
							if E.db.ElvUI_EltreumUI.skins.questsettings.lineshadow and E.private.general.pixelPerfect and not E.db.ElvUI_EltreumUI.borders.universalborders then
								bar:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(bar.shadow)
							end

							--E:Delay(0, function()
							bar.backdrop:SetAlpha(E.db.general.backdropfadecolor.a)
							bar.backdrop:SetBackdropColor(0,0,0)
							bar.backdrop.SetBackdropColor = E.noop
							--end)
							bar:GetStatusBarTexture():SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.skins.queststatusbartexture))
							--[[hooksecurefunc(bar, "SetStatusBarColor", function(_, r, g, b)
								bar:GetStatusBarTexture():SetGradient("HORIZONTAL", {r=r - 0.4,g= g - 0.4,b= b - 0.4,a= E.db.general.backdropfadecolor.a}, {r=r + 0.2,g= g + 0.2,b= b + 0.2,a= E.db.general.backdropfadecolor.a})
								bar.backdrop:SetAlpha(E.db.general.backdropfadecolor.a)
								bar.backdrop:SetBackdropColor(0,0,0)
							end)]]

							if bar.SetPercent then
								hooksecurefunc(bar:GetParent(), "SetPercent", function(frame)--,percent)
									local statusbar = frame.Bar
									if not statusbar then return end
									--S:StatusBarColorGradient(statusbar, percent, 100)
									local r,g,b = statusbar:GetStatusBarColor()
									statusbar:GetStatusBarTexture():SetGradient("HORIZONTAL", {r=r - 0.4,g= g - 0.4,b= b - 0.4,a= E.db.general.backdropfadecolor.a}, {r=r + 0.2,g= g + 0.2,b= b + 0.2,a= E.db.general.backdropfadecolor.a})
									statusbar.backdrop:SetAlpha(E.db.general.backdropfadecolor.a)
									statusbar.backdrop:SetBackdropColor(0,0,0)
								end)
							end
							bar.EltruismSkin = true
						end
					end
				end

				local function subLines(line)
					if line then
						if ( line.Dash ) then
							if E.db.ElvUI_EltreumUI.skins.questsettings.hideDash then
								line.Dash:SetText(" ")
							else
								if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
									line.Dash:SetTextColor(E.db.ElvUI_EltreumUI.skins.questsettings.customr, E.db.ElvUI_EltreumUI.skins.questsettings.customg, E.db.ElvUI_EltreumUI.skins.questsettings.customb)
								else
									line.Dash:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
								end
								line.Dash:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
							end
						end
						--traveler's log dash is part of the text and not another element, so color it differently
						if line.Text and line.Text:GetText() then
							line.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
							line.Text:SetTextColor(mult, mult, mult)
							--line.Text:SetWordWrap(true)

							--inspired by blinkii's skin, color
							local text = line.Text:GetText()
							--5320674
							--5320671
							if text ~= nil then
								local left, right, questtext = string.match(text, "^(%d-)/(%d-) (.+)")
								local questtext2,left2, right2 = string.match(text, "(.+): (%d-)/(%d-)$")
								local left3, right3, questtext3 = strmatch(text, "^- (%d-)/(%d-) (.+)")
								if left then
									local percentagedone = (tonumber(left) / tonumber(right)) * 100 or 0
									local r, g, b = E:ColorGradient(percentagedone * 0.01, 1, 0, 0, 1, 1, 0, 0, 1, 0)
									local hexstring = E:RGBToHex(r, g, b)
									line.Text:SetText(format("%s%s/%s|r %s|r%s",hexstring,left,right,hexstring,questtext))
									if percentagedone >= 100 or (line.Check and line.Check:IsShown()) then
										line.Text:SetTextColor(0.12, 1, 0.12)
									else
										line.Text:SetTextColor(1, 1, 1)
									end
								elseif left2 then
									local percentagedone = (tonumber(left2) / tonumber(right2)) * 100 or 0
									local r, g, b = E:ColorGradient(percentagedone * 0.01, 1, 0, 0, 1, 1, 0, 0, 1, 0)
									local hexstring = E:RGBToHex(r, g, b)
									line.Text:SetText(format("%s|r %s%s/%s|r",questtext2,hexstring,left2,right2))
									if percentagedone >= 100 or (line.Check and line.Check:IsShown()) then
										line.Text:SetTextColor(0.12, 1, 0.12)
									else
										line.Text:SetTextColor(1, 1, 1)
									end
								elseif left3 then
									local percentagedone = (tonumber(left3) / tonumber(right3)) * 100 or 0
									local r, g, b = E:ColorGradient(percentagedone * 0.01, 1, 0, 0, 1, 1, 0, 0, 1, 0)
									local hexstring = E:RGBToHex(r, g, b)
									line.Text:SetText(format("- %s%s/%s|r %s|r%s",hexstring,left3,right3,hexstring,questtext3))
									if percentagedone >= 100 or (line.Check and line.Check:IsShown()) then
										line.Text:SetTextColor(0.12, 1, 0.12)
									else
										line.Text:SetTextColor(1, 1, 1)
									end
								else
									if text == _G.QUEST_WATCH_QUEST_READY or (line.Check and line.Check:IsShown()) or (line.objectiveKey == "QuestComplete") then
										line.Text:SetTextColor(0.12, 1, 0.12)
									else
										line.Text:SetTextColor(1, 1, 1)
									end
								end
							end
						end
						if line.Icon then
							if E.db.ElvUI_EltreumUI.skins.questsettings.hideCheck then
								line.Icon:Hide()
							else
								if line.Icon:GetAtlas() == "UI-QuestTracker-Objective-Nub" then
									line.Icon:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\questnub.tga")
								elseif line.Icon:GetAtlas() == "UI-QuestTracker-Tracker-Check" then
									line.Icon:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\checkmark.tga")
								end
							end
						end
						if line.lastRegion then
							if line.lastRegion.Icon and line.lastRegion.Icon:GetAtlas() then
								if E.db.ElvUI_EltreumUI.skins.questsettings.hideCheck then
									line.lastRegion.Icon:Hide()
								else
									if line.lastRegion.Icon:GetAtlas() == "UI-QuestTracker-Objective-Nub" then
										line.lastRegion.Icon:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\questnub.tga")
									elseif line.lastRegion.Icon:GetAtlas() == "UI-QuestTracker-Tracker-Check" then
										line.lastRegion.Icon:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\checkmark.tga")
									end
								end
							end
						end
					end
				end

				local function usedLines(block)
					if block.usedLines then
						if #block.usedLines == 0 then
							for _,v in pairs(block.usedLines) do
								subLines(v)
							end
						else
							for _, line in next, block.usedLines do
								if line then
									subLines(line)
								end
							end
						end
					else
						subLines(block)
					end
				end

				local function lastRegion(block)
					local line = block.lastRegion
					if line then
						if ( line.Dash ) then
							if E.db.ElvUI_EltreumUI.skins.questsettings.hideDash then
								line.Dash:SetText(" ")
							else
								if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
									line.Dash:SetTextColor(E.db.ElvUI_EltreumUI.skins.questsettings.customr, E.db.ElvUI_EltreumUI.skins.questsettings.customg, E.db.ElvUI_EltreumUI.skins.questsettings.customb)
								else
									line.Dash:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
								end
								line.Dash:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
							end
						end
						--traveler's log dash is part of the text and not another element, so color it differently
						if line.Text and line.Text:GetText() then
							line.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
							line.Text:SetTextColor(mult, mult, mult)
							--line.Text:SetWordWrap(true)

							--inspired by blinkii's skin, color
							local text = line.Text:GetText()
							--5320674
							--5320671
							if text ~= nil then
								local left, right, questtext = string.match(text, "^(%d-)/(%d-) (.+)")
								local questtext2,left2, right2 = string.match(text, "(.+): (%d-)/(%d-)$")
								local left3, right3, questtext3 = strmatch(text, "^- (%d-)/(%d-) (.+)")
								if left then
									local percentagedone = (tonumber(left) / tonumber(right)) * 100 or 0
									local r, g, b = E:ColorGradient(percentagedone * 0.01, 1, 0, 0, 1, 1, 0, 0, 1, 0)
									local hexstring = E:RGBToHex(r, g, b)
									line.Text:SetText(format("%s%s/%s|r %s|r%s",hexstring,left,right,hexstring,questtext))
									if percentagedone >= 100 or (line.Check and line.Check:IsShown()) then
										line.Text:SetTextColor(0.12, 1, 0.12)
									else
										line.Text:SetTextColor(1, 1, 1)
									end
								elseif left2 then
									local percentagedone = (tonumber(left2) / tonumber(right2)) * 100 or 0
									local r, g, b = E:ColorGradient(percentagedone * 0.01, 1, 0, 0, 1, 1, 0, 0, 1, 0)
									local hexstring = E:RGBToHex(r, g, b)
									line.Text:SetText(format("%s|r %s%s/%s|r",questtext2,hexstring,left2,right2))
									if percentagedone >= 100 or (line.Check and line.Check:IsShown()) then
										line.Text:SetTextColor(0.12, 1, 0.12)
									else
										line.Text:SetTextColor(1, 1, 1)
									end
								elseif left3 then
									local percentagedone = (tonumber(left3) / tonumber(right3)) * 100 or 0
									local r, g, b = E:ColorGradient(percentagedone * 0.01, 1, 0, 0, 1, 1, 0, 0, 1, 0)
									local hexstring = E:RGBToHex(r, g, b)
									line.Text:SetText(format("- %s%s/%s|r %s|r%s",hexstring,left3,right3,hexstring,questtext3))
									if percentagedone >= 100 or (line.Check and line.Check:IsShown()) then
										line.Text:SetTextColor(0.12, 1, 0.12)
									else
										line.Text:SetTextColor(1, 1, 1)
									end
								else
									if text == _G.QUEST_WATCH_QUEST_READY or (line.Check and line.Check:IsShown()) or (line.objectiveKey == "QuestComplete") then
										line.Text:SetTextColor(0.12, 1, 0.12)
									else
										line.Text:SetTextColor(1, 1, 1)
									end
								end
							end
						end
						if line.Icon then
							if E.db.ElvUI_EltreumUI.skins.questsettings.hideCheck then
								line.Icon:Hide()
							else
								if line.Icon:GetAtlas() == "UI-QuestTracker-Objective-Nub" then
									line.Icon:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\questnub.tga")
								elseif line.Icon:GetAtlas() == "UI-QuestTracker-Tracker-Check" then
									line.Icon:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\checkmark.tga")
								end
							end
						end
					end
				end

				local function blockenter(block)
					if not block then return end
					if ( block.HeaderText ) then
						if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
							block.HeaderText:SetTextColor(E.db.ElvUI_EltreumUI.skins.questsettings.customr, E.db.ElvUI_EltreumUI.skins.questsettings.customg, E.db.ElvUI_EltreumUI.skins.questsettings.customb)
							block.HeaderText.colorStyle = {r = E.db.ElvUI_EltreumUI.skins.questsettings.customr, g = E.db.ElvUI_EltreumUI.skins.questsettings.customg, b = E.db.ElvUI_EltreumUI.skins.questsettings.customb}
						else
							block.HeaderText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							block.HeaderText.colorStyle = {r = classcolor.r, g = classcolor.g, b = classcolor.b}
						end
					end
					if block.currentLine then --this is the text
						for objectiveKey, line in pairs(block.lines) do --Blizzard_ObjectiveTracker.lua#L458
							if objectiveKey == 0 then --its the title
								if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
									line.Text:SetTextColor(E.db.ElvUI_EltreumUI.skins.questsettings.customr, E.db.ElvUI_EltreumUI.skins.questsettings.customg, E.db.ElvUI_EltreumUI.skins.questsettings.customb)
								else
									line.Text:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
								end
							else -- its the subtext
								local text = line.Text:GetText()
								if text == _G.QUEST_WATCH_QUEST_READY then
									block.currentLine.Text:SetTextColor(0, 1, 0)
									if line.Text.colorStyle then
										line.Text.colorStyle = {r = 0, g = 1, b = 0}
									end
								else
									line.Text:SetTextColor(1, 1, 1)
									if line.Text.colorStyle then
										line.Text.colorStyle = {r = mult * 1, g = mult * 1, b = mult * 1}
									end
								end
							end
							if ( line.Dash ) then
								if E.db.ElvUI_EltreumUI.skins.questsettings.hideDash then
									line.Dash:SetText(" ")
								else
									if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
										line.Dash:SetTextColor(E.db.ElvUI_EltreumUI.skins.questsettings.customr, E.db.ElvUI_EltreumUI.skins.questsettings.customg, E.db.ElvUI_EltreumUI.skins.questsettings.customb)
									else
										line.Dash:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
									end
									line.Dash:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
								end
							end
							if line.Check and line.Check:IsShown() then
								line.Text:SetTextColor(0.12, 1, 0.12)
							end
						end
					end
					if block.usedLines then
						usedLines(block)
					end
					if block.lastRegion then
						lastRegion(block)
					end
				end

				local function blockexit(block)
					if not block then return end
					if ( block.HeaderText ) then
						if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
							block.HeaderText:SetTextColor(mult * E.db.ElvUI_EltreumUI.skins.questsettings.customr, mult * E.db.ElvUI_EltreumUI.skins.questsettings.customg, mult * E.db.ElvUI_EltreumUI.skins.questsettings.customb)
							block.HeaderText.colorStyle = {r = mult * E.db.ElvUI_EltreumUI.skins.questsettings.customr, g = mult * E.db.ElvUI_EltreumUI.skins.questsettings.customg, b = mult * E.db.ElvUI_EltreumUI.skins.questsettings.customb}
						else
							block.HeaderText:SetTextColor(mult * classcolor.r, mult * classcolor.g, mult * classcolor.b)
							block.HeaderText.colorStyle = { r = mult * classcolor.r, g = mult * classcolor.g, b = mult * classcolor.b }
						end
					end
					if block.currentLine then
						for objectiveKey, line in pairs(block.usedLines) do --Blizzard_ObjectiveTracker.lua#L458
							if objectiveKey == 0 then --its the title
								if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
									line.Text:SetTextColor(mult * E.db.ElvUI_EltreumUI.skins.questsettings.customr, mult * E.db.ElvUI_EltreumUI.skins.questsettings.customg, mult * E.db.ElvUI_EltreumUI.skins.questsettings.customb)
								else
									line.Text:SetTextColor(mult * classcolor.r, mult * classcolor.g, mult * classcolor.b)
								end
							else -- its the subtext
								local text = line.Text:GetText()
								if text == _G.QUEST_WATCH_QUEST_READY then
									block.currentLine.Text:SetTextColor(0.12, 1, 0.12)
									if line.Text.colorStyle then
										line.Text.colorStyle = {r = 0.12, g = 1, b = 0.12}
									end
								else
									line.Text:SetTextColor(mult, mult, mult)
									if line.Text.colorStyle then
										line.Text.colorStyle = {r = mult, g = mult, b = mult}
									end
								end
							end
							if ( line.Dash ) then
								if E.db.ElvUI_EltreumUI.skins.questsettings.hideDash then
									line.Dash:SetText(" ")
								else
									if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
										line.Dash:SetTextColor(E.db.ElvUI_EltreumUI.skins.questsettings.customr, E.db.ElvUI_EltreumUI.skins.questsettings.customg, E.db.ElvUI_EltreumUI.skins.questsettings.customb)
									else
										line.Dash:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
									end
									line.Dash:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
								end
							end
							if line.Check and line.Check:IsShown() then
								line.Text:SetTextColor(0.12, 1, 0.12)
							end
						end
					end
					if block.usedLines then
						usedLines(block)
					end
					if block.lastRegion then
						lastRegion(block)
					end
				end

				local questmodules = {
					_G.QuestObjectiveTracker,
					_G.ScenarioObjectiveTracker,
					_G.CampaignQuestObjectiveTracker,
					_G.AdventureObjectiveTracker,
					_G.AchievementObjectiveTracker,
					_G.MonthlyActivitiesObjectiveTracker,
					_G.ProfessionsRecipeTracker,
					_G.BonusObjectiveTracker,
					_G.WorldQuestObjectiveTracker,
					_G.ObjectiveTrackerFrame,
					_G.UIWidgetObjectiveTracker,
				}
				for _, module in pairs(questmodules) do
					if module and module.Header then

						--the big type of quest
						if module.Header.Text and not module.Header.EltruismFont then
							if not ElvUI_EltreumUI:SLCheck('quest') then
								if module.Header.Text:GetText() ~= _G.TRACKER_ALL_OBJECTIVES then
									module.Header.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSizeHeader, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
								else
									module.Header.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSizeHeader/1.5, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
								end
							end
							if E.db.ElvUI_EltreumUI.skins.questsettings.customcolortitle then
								module.Header.Text:SetTextColor(E.db.ElvUI_EltreumUI.skins.questsettings.customrtitle, E.db.ElvUI_EltreumUI.skins.questsettings.customgtitle, E.db.ElvUI_EltreumUI.skins.questsettings.custombtitle)
							else
								module.Header.Text:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
							module.Header.Text:SetShadowColor(0, 0, 0, 0.8)
							module.Header.Text:SetShadowOffset(2, -1)
						end

						--create the lines
						if not module.Header.EltruismStatusLine and not ElvUI_EltreumUI:SLCheck('quest') then
							if module.Header.Text and module.Header.Text:GetText() ~= nil then
								if module.Header.Text:GetText() ~= _G.TRACKER_ALL_OBJECTIVES then
									module.Header.EltruismStatusLine = CreateFrame("StatusBar", "Eltruism"..module.Header.Text:GetText().."Line", module.Header)
								end
							end
							if module.Header.EltruismStatusLine then
								module.Header.EltruismStatusLine:SetMinMaxValues(0, 100)
								module.Header.EltruismStatusLine:SetValue(100)
								module.Header.EltruismStatusLine:SetSize(E.db.ElvUI_EltreumUI.skins.questsettings.sizex, E.db.ElvUI_EltreumUI.skins.questsettings.sizey)
								module.Header.EltruismStatusLine:SetPoint("BOTTOM", module.Header, 0, 0)
								module.Header.EltruismStatusLine:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.skins.questsettings.texture))
								if not E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor then
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
										module.Header.EltruismStatusLine:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass))
									else
										module.Header.EltruismStatusLine:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass))
									end
								else
									module.Header.EltruismStatusLine:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor1r,g= E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor1g,b=E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor1b,a= 1}, {r=E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor2r,g=E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor2g,b=E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor2b,a= 1})
								end
								module.Header.EltruismStatusLine:SetFrameLevel(1)
								if E.db.ElvUI_EltreumUI.skins.questsettings.lineshadow and not module.Header.EltruismStatusLine.shadow and E.private.general.pixelPerfect then
									--module.Header.EltruismStatusLine:CreateBackdrop('Transparent')
									module.Header.EltruismStatusLine:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
									module.Header.EltruismStatusLine.shadow:SetFrameStrata("LOW")
									ElvUI_EltreumUI:ShadowColor(module.Header.EltruismStatusLine.shadow)
								end
							end
						end
						module.Header.EltruismFont = true
					end
				end

				local function blockskin(block)
					block:UnregisterEvent("ADDON_ACTION_FORBIDDEN")
					block:UnregisterEvent("ADDON_ACTION_BLOCKED")
					if not block then
						return
					end
					if block.HeaderText then --quest title
						block.HeaderText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize+1, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
						if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
							block.HeaderText:SetTextColor(mult * E.db.ElvUI_EltreumUI.skins.questsettings.customr, mult * E.db.ElvUI_EltreumUI.skins.questsettings.customg, mult * E.db.ElvUI_EltreumUI.skins.questsettings.customb)
						else
							block.HeaderText:SetTextColor(mult * classcolor.r, mult * classcolor.g, mult * classcolor.b)
						end
						block.HeaderText:SetWordWrap(true)
					end
					local itemButton = block.itemButton or block.ItemButton
					if itemButton then
						if E.db.ElvUI_EltreumUI.skins.shadow.enable and not itemButton.shadow then
							itemButton:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(itemButton.shadow)
						end
						if itemButton.HotKey then
							itemButton.HotKey:Kill()
						end

						if _G.ObjectiveFrameMover then
							questside = _G.ObjectiveFrameMover:GetPoint()
						else
							questside = _G.ObjectiveTrackerFrame:GetPoint()
						end
						if questside:match("RIGHT") then
							itemButton:ClearAllPoints()
							itemButton:SetPoint("TOPLEFT", block, "TOPLEFT", -60, -3)
						else
							itemButton:ClearAllPoints()
							itemButton:SetPoint("TOPRIGHT", block, "TOPRIGHT", 80, -3)
						end
						itemButton:UnregisterEvent("ADDON_ACTION_FORBIDDEN")
						itemButton:UnregisterEvent("ADDON_ACTION_BLOCKED")
					end
					if block.groupFinderButton and E.db.ElvUI_EltreumUI.skins.shadow.enable and not block.groupFinderButton.shadow then
						block.groupFinderButton:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(block.groupFinderButton.shadow)
					end
					if block.usedLines then
						if #block.usedLines == 0 then
							for _,v in pairs(block.usedLines) do
								usedLines(v)
							end
						end
						usedLines(block)
					end
					if block.lastRegion then
						lastRegion(block)
					end
				end

				local function hooks(k)
					k:UnregisterEvent("ADDON_ACTION_BLOCKED")
					k:UnregisterEvent("ADDON_ACTION_FORBIDDEN")
					if k.Bar then
						EltreumSkinProgressBars(k.Bar)
					end
					if k.UpdateHighlight and not k.UpdateHighlightHook then
						hooksecurefunc(k, "UpdateHighlight", function(_, block)
							blockenter(block)
						end)
						k.UpdateHighlightHook = true
					end
					if k.OnHeaderEnter and not k.OnHeaderEnterHook then
						hooksecurefunc(k, "OnHeaderEnter", function(block)
							blockenter(block)
						end)
						k.OnHeaderEnterHook = true
					end
					if k.OnHeaderLeave and not k.OnHeaderLeaveHook then
						hooksecurefunc(k, "OnHeaderLeave", function(block)
							blockexit(block)
						end)
						k.OnHeaderLeaveHook = true
					end
					if k.AddObjective and not k.AddObjectiveHook then
						local function updateObjectiveCount()
							--add quest count
								if _G.QuestObjectiveTracker and _G.QuestObjectiveTracker.Header and _G.QuestObjectiveTracker.Header.Text then
									--local NumQuests = select(2, _G.C_QuestLog.GetNumQuestLogEntries())

									--GetNumQuestLogEntries is returning higher numbers so remove 12 from it
									--13 seemed correct but managed to hit 38/35
									--turns out some quests count as more, as finishing a battle pet quest changed the total return by more than 1
									--maybe some quests are returning higher values to reserve slots for following quests
									local NumQuests = select(2, _G.C_QuestLog.GetNumQuestLogEntries()) - 15
									if NumQuests < 0 then NumQuests = 0 end

									--if (NumQuests >= (MAX_QUESTS - 5)) then --global still returning 25
									if (NumQuests >= 30) then
										--_G.ObjectiveTrackerBlocksFrame.QuestHeader.Text:SetText(format("|CFFFF0000%d/%d|r - %s", NumQuests, MAX_QUESTS, QUESTS_LABEL))
										_G.QuestObjectiveTracker.Header.Text:SetText(format("|CFFFF0000%d/%d|r - %s", NumQuests, 35, _G.QUESTS_LABEL))
									else
										_G.QuestObjectiveTracker.Header.Text:SetText(_G.QUESTS_LABEL)
									end
								end
							--C_QuestLog.SortQuestWatches() --fix lines when added
						end

						hooksecurefunc(k, "AddObjective", function()
							blockskin(k)
							updateObjectiveCount()
						end)

						--update quest count on quest removed
						local questnumbermonitor = CreateFrame("frame")
						questnumbermonitor:RegisterEvent("QUEST_REMOVED")
						questnumbermonitor:SetScript("OnEvent",updateObjectiveCount)

						k.AddObjectiveHook = true
					end
					if k.Update and not k.EltruismUpdateHooked then
						hooksecurefunc(k, "Update", function(module)--availableHeight, dirtyUpdate)
							if module and module.Header and module.Header.Text and not module.Header.EltruismFont then --the big type of quest
								if not ElvUI_EltreumUI:SLCheck('quest') then
									if module.Header.Text:GetText() ~= _G.TRACKER_ALL_OBJECTIVES then
										module.Header.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSizeHeader, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
									else
										module.Header.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSizeHeader/1.5, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
									end
								end
								if E.db.ElvUI_EltreumUI.skins.questsettings.customcolortitle then
									module.Header.Text:SetTextColor(E.db.ElvUI_EltreumUI.skins.questsettings.customrtitle, E.db.ElvUI_EltreumUI.skins.questsettings.customgtitle, E.db.ElvUI_EltreumUI.skins.questsettings.custombtitle)
								else
									module.Header.Text:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
								end
								module.Header.Text:SetShadowColor(0, 0, 0, 0.8)
								module.Header.Text:SetShadowOffset(2, -1)

								--create the lines
								if not module.Header.EltruismStatusLine and not ElvUI_EltreumUI:SLCheck('quest') then
									if module.Header.Text and module.Header.Text:GetText() ~= nil then
										if module.Header.Text:GetText() ~= _G.TRACKER_ALL_OBJECTIVES then
											module.Header.EltruismStatusLine = CreateFrame("StatusBar", "Eltruism"..module.Header.Text:GetText().."Line", module.Header)
										end
									end
									if module.Header.EltruismStatusLine then
										module.Header.EltruismStatusLine:SetMinMaxValues(0, 100)
										module.Header.EltruismStatusLine:SetValue(100)
										module.Header.EltruismStatusLine:SetSize(E.db.ElvUI_EltreumUI.skins.questsettings.sizex, E.db.ElvUI_EltreumUI.skins.questsettings.sizey)
										module.Header.EltruismStatusLine:SetPoint("BOTTOM", module.Header, 0, 0)
										module.Header.EltruismStatusLine:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.skins.questsettings.texture))
										if not E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor then
											if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
												module.Header.EltruismStatusLine:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass))
											else
												module.Header.EltruismStatusLine:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass))
											end
										else
											module.Header.EltruismStatusLine:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor1r,g= E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor1g,b=E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor1b,a= 1}, {r=E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor2r,g=E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor2g,b=E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor2b,a= 1})
										end
										module.Header.EltruismStatusLine:SetFrameLevel(1)
										if E.db.ElvUI_EltreumUI.skins.questsettings.lineshadow and not module.Header.EltruismStatusLine.shadow and E.private.general.pixelPerfect then
											--module.Header.EltruismStatusLine:CreateBackdrop('Transparent')
											module.Header.EltruismStatusLine:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
											module.Header.EltruismStatusLine.shadow:SetFrameStrata("LOW")
											ElvUI_EltreumUI:ShadowColor(module.Header.EltruismStatusLine.shadow)
										end
									end
								end
								module.Header.EltruismFont = true
							end

							--add quest count
							if _G.QuestObjectiveTracker and _G.QuestObjectiveTracker.Header and _G.QuestObjectiveTracker.Header.Text then
								local NumQuests = select(2, _G.C_QuestLog.GetNumQuestLogEntries())
								--if (NumQuests >= (MAX_QUESTS - 5)) then --global still returning 25
								if (NumQuests >= 30) then
									--_G.ObjectiveTrackerBlocksFrame.QuestHeader.Text:SetText(format("|CFFFF0000%d/%d|r - %s", NumQuests, MAX_QUESTS, QUESTS_LABEL))
									_G.QuestObjectiveTracker.Header.Text:SetText(format("|CFFFF0000%d/%d|r - %s", NumQuests, 35, _G.QUESTS_LABEL))
								--else
								--	_G.ObjectiveTrackerBlocksFrame.QuestHeader.Text:SetText(QUESTS_LABEL)
								end
							end
						end)
						k.EltruismUpdateHooked = true
					end
					if k.AddAchievement and not k.AddAchievementHook then
						hooksecurefunc(k, "AddAchievement", function(block)
							blockskin(k)
							blockskin(block)
						end)
						k.AddAchievementHook = true
					end
					if k.UpdateStageBlock and not k.UpdateStageBlockHook then
						hooksecurefunc(k, "UpdateStageBlock", function()
							if _G.ScenarioObjectiveTracker then
								local frames = {_G.ScenarioObjectiveTracker.ContentsFrame:GetChildren()}
								for _, frame in pairs(frames) do
									if frame.Stage then
										frame.Stage:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize+2, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
										if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
											frame.Stage:SetTextColor(mult * E.db.ElvUI_EltreumUI.skins.questsettings.customr, mult * E.db.ElvUI_EltreumUI.skins.questsettings.customg, mult * E.db.ElvUI_EltreumUI.skins.questsettings.customb)
										else
											frame.Stage:SetTextColor(mult * classcolor.r, mult * classcolor.g, mult * classcolor.b)
										end
										frame.Stage:SetWordWrap(true)
										ScenarioObjectiveBlockBackground:SetParent(frame)
										ScenarioObjectiveBlockBackground:ClearAllPoints()
										if _G.EltruismDungeonLine and _G.EltruismDungeonLine:IsVisible() then
											ScenarioObjectiveBlockBackground:SetPoint("CENTER", _G.EltruismDungeonLine, "CENTER", -3, -47)
										elseif _G.EltruismScenarioLine and _G.EltruismScenarioLine:IsVisible() then
											ScenarioObjectiveBlockBackground:SetPoint("CENTER", _G.EltruismScenarioLine, "CENTER", -3, -47)
										elseif _G.EltruismDelvesLine and _G.EltruismDelvesLine:IsVisible() then
											ScenarioObjectiveBlockBackground:SetPoint("CENTER", _G.EltruismDelvesLine, "CENTER", -3, -47)
										elseif _G.ObjectiveTrackerBlocksFrame and _G.ObjectiveTrackerBlocksFrame.ScenarioHeader and _G.ObjectiveTratatusckerBlocksFrame.ScenarioHeader.EltruismStatusLine and _G.ObjectiveTratatusckerBlocksFrame.ScenarioHeader.EltruismStatusLine:IsVisible() then
											ScenarioObjectiveBlockBackground:SetPoint("CENTER", _G.ObjectiveTrackerBlocksFrame.ScenarioHeader.EltruismStatusLine, "CENTER", -3, -47)
										else
											ScenarioObjectiveBlockBackground:SetPoint("CENTER", frame, "CENTER", -3, -5)
										end

										ScenarioObjectiveBlockBackground:SetSize(243, 80)
										ScenarioObjectiveBlockBackground:SetFrameLevel(3)
										ScenarioObjectiveBlockBackground:Show()
										if E.db.ElvUI_EltreumUI.skins.questsettings.lineshadow and not ScenarioObjectiveBlockBackground.shadow and E.private.general.pixelPerfect and not E.db.ElvUI_EltreumUI.borders.universalborders then
											ScenarioObjectiveBlockBackground:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
											ElvUI_EltreumUI:ShadowColor(ScenarioObjectiveBlockBackground.shadow.shadow)
										end
									end
									if frame.NormalBG then
										frame.NormalBG:Hide()
										frame.NormalBG:SetTexture()
									end
									if frame.FinalBG then
										frame.FinalBG:Hide()
										frame.FinalBG:SetTexture()
									end
								end
							end
						end)
						k.UpdateStageBlockHook = true
					end
					if k.UpdateWidgetLayout and not UpdateWidgetLayoutHook then
						hooksecurefunc(k, "UpdateWidgetLayout", function()
							if _G.ScenarioObjectiveTracker then
								local frames = {_G.ScenarioObjectiveTracker.ContentsFrame:GetChildren()}
								for _, frame in pairs(frames) do
									if frame.Stage then
										frame.Stage:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize+2, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
										if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
											frame.Stage:SetTextColor(mult * E.db.ElvUI_EltreumUI.skins.questsettings.customr, mult * E.db.ElvUI_EltreumUI.skins.questsettings.customg, mult * E.db.ElvUI_EltreumUI.skins.questsettings.customb)
										else
											frame.Stage:SetTextColor(mult * classcolor.r, mult * classcolor.g, mult * classcolor.b)
										end
										frame.Stage:SetWordWrap(true)
										ScenarioObjectiveBlockBackground:SetParent(frame)
										ScenarioObjectiveBlockBackground:ClearAllPoints()
										if _G.EltruismDungeonLine and _G.EltruismDungeonLine:IsVisible() then
											ScenarioObjectiveBlockBackground:SetPoint("CENTER", _G.EltruismDungeonLine, "CENTER", -3, -47)
										elseif _G.EltruismScenarioLine and _G.EltruismScenarioLine:IsVisible() then
											ScenarioObjectiveBlockBackground:SetPoint("CENTER", _G.EltruismScenarioLine, "CENTER", -3, -47)
										elseif _G.EltruismDelvesLine and _G.EltruismDelvesLine:IsVisible() then
											ScenarioObjectiveBlockBackground:SetPoint("CENTER", _G.EltruismDelvesLine, "CENTER", -3, -47)
										elseif _G.ObjectiveTrackerBlocksFrame and _G.ObjectiveTrackerBlocksFrame.ScenarioHeader and _G.ObjectiveTratatusckerBlocksFrame.ScenarioHeader.EltruismStatusLine and _G.ObjectiveTratatusckerBlocksFrame.ScenarioHeader.EltruismStatusLine:IsVisible() then
											ScenarioObjectiveBlockBackground:SetPoint("CENTER", _G.ObjectiveTrackerBlocksFrame.ScenarioHeader.EltruismStatusLine, "CENTER", -3, -47)
										else
											ScenarioObjectiveBlockBackground:SetPoint("CENTER", frame, "CENTER", -3, -5)
										end

										ScenarioObjectiveBlockBackground:SetSize(243, 80)
										ScenarioObjectiveBlockBackground:SetFrameLevel(3)
										ScenarioObjectiveBlockBackground:Show()
										if E.db.ElvUI_EltreumUI.skins.questsettings.lineshadow and not ScenarioObjectiveBlockBackground.shadow and E.private.general.pixelPerfect then
											ScenarioObjectiveBlockBackground:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
											ElvUI_EltreumUI:ShadowColor(ScenarioObjectiveBlockBackground.shadow.shadow)
										end
									end
									if frame.NormalBG then
										frame.NormalBG:Hide()
										frame.NormalBG:SetTexture()
									end
									if frame.FinalBG then
										frame.FinalBG:Hide()
										frame.FinalBG:SetTexture()
									end
								end
							end
						end)
						k.UpdateWidgetLayoutHook = true
					end
					if k.UpdateTime and not k.UpdateTimeHook then
						hooksecurefunc(k, "UpdateTime", function(frame)
							if frame and not frame.EltruismSkin then
								ScenarioObjectiveBlockBackground:SetParent(frame)
								ScenarioObjectiveBlockBackground:ClearAllPoints()
								if _G.EltruismDungeonLine and _G.EltruismDungeonLine:IsVisible() then
									ScenarioObjectiveBlockBackground:SetPoint("CENTER", _G.EltruismDungeonLine, "CENTER", -3, -47)
								elseif _G.EltruismScenarioLine and _G.EltruismScenarioLine:IsVisible() then
									ScenarioObjectiveBlockBackground:SetPoint("CENTER", _G.EltruismScenarioLine, "CENTER", -3, -47)
								elseif _G.EltruismDelvesLine and _G.EltruismDelvesLine:IsVisible() then
									ScenarioObjectiveBlockBackground:SetPoint("CENTER", _G.EltruismDelvesLine, "CENTER", -3, -47)
								elseif _G.ObjectiveTrackerBlocksFrame and _G.ObjectiveTrackerBlocksFrame.ScenarioHeader and _G.ObjectiveTratatusckerBlocksFrame.ScenarioHeader.EltruismStatusLine and _G.ObjectiveTratatusckerBlocksFrame.ScenarioHeader.EltruismStatusLine:IsVisible() then
									ScenarioObjectiveBlockBackground:SetPoint("CENTER", _G.ObjectiveTrackerBlocksFrame.ScenarioHeader.EltruismStatusLine, "CENTER", -3, -47)
								else
									ScenarioObjectiveBlockBackground:SetPoint("CENTER", frame, "CENTER", -3, -5)
								end
								ScenarioObjectiveBlockBackground:SetSize(243, 80)
								ScenarioObjectiveBlockBackground:SetFrameLevel(3)
								ScenarioObjectiveBlockBackground:Show()
								if E.db.ElvUI_EltreumUI.skins.questsettings.lineshadow and not ScenarioObjectiveBlockBackground.shadow and E.private.general.pixelPerfect and not E.db.ElvUI_EltreumUI.borders.universalborders then
									ScenarioObjectiveBlockBackground:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
									ElvUI_EltreumUI:ShadowColor(ScenarioObjectiveBlockBackground.shadow.shadow)
								end
								frame:StripTextures()
								frame.EltruismSkin = true
							end
						end)
						--UpdateTime
						k.UpdateTimeHook = true
					end
					if k.AddBlock and not k.AddBlockHook then
						hooksecurefunc(k, "AddBlock", function(block)
							blockskin(block)
							blockskin(k)
						end)
						k.AddBlockHook = true
					end
				end
				local function firehooks()
					for _, k in pairs(questmodules) do
						k:UnregisterEvent("ADDON_ACTION_BLOCKED")
						k:UnregisterEvent("ADDON_ACTION_FORBIDDEN")
						if k.ContentsFrame then
							if k.ContentsFrame:GetNumChildren() > 0 then
								for _, v in pairs({k.ContentsFrame:GetChildren()}) do
									if v then
										hooks(v)
										blockskin(v)
									end
								end
							end
						end
						if k.AddAchievement and not k.AddAchievementHook then
							hooksecurefunc(k, "AddAchievement", function(block)
								blockskin(block)
								blockskin(k)
							end)
							k.AddAchievementHook = true
						end
						if k.AddBlock and not k.AddBlockHook then
							hooksecurefunc(k, "AddBlock", function(block)
								blockskin(block)
								blockskin(k)
							end)
							k.AddBlockHook = true
						end
						if k.AddQuest and not k.AddQuestHook then
							hooksecurefunc(k, "AddQuest", function(block)
								blockskin(block)
								blockskin(k)
							end)
							k.AddQuestHook = true
						end
					end
				end
				E:Delay(0,firehooks)

				if _G.ScenarioObjectiveTracker and _G.ScenarioObjectiveTracker.UpdateCriteria then
					hooksecurefunc(_G.ScenarioObjectiveTracker, "UpdateCriteria", function()
						if _G.ScenarioObjectiveTracker and _G.ScenarioObjectiveTracker.ContentsFrame then
							local frames = {_G.ScenarioObjectiveTracker.ContentsFrame:GetChildren()}
							for _, frame in pairs(frames) do
								if frame.Text then
									frame.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle)) --this is the objective like boss 1/1
									frame.Text:SetTextColor(1, 1, 1) --dungeon obj text
									frame.Text:SetWordWrap(true)
								end
								if frame.lastRegion then
									if frame.lastRegion.Icon and frame.lastRegion.Icon:GetAtlas() then
										if E.db.ElvUI_EltreumUI.skins.questsettings.hideCheck then
											frame.lastRegion.Icon:Hide()
										else
											if frame.lastRegion.Icon:GetAtlas() == "UI-QuestTracker-Objective-Nub" then
												frame.lastRegion.Icon:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\questnub.tga")
											elseif frame.lastRegion.Icon:GetAtlas() == "UI-QuestTracker-Tracker-Check" then
												frame.lastRegion.Icon:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\checkmark.tga")
											end
										end
									end
								end
								if frame.Icon and frame.Icon:GetAtlas() then
									if E.db.ElvUI_EltreumUI.skins.questsettings.hideCheck then
										frame.Icon:Hide()
									else
										if frame.Icon:GetAtlas() == "UI-QuestTracker-Objective-Nub" then
											frame.Icon:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\questnub.tga")
										elseif frame.Icon:GetAtlas() == "UI-QuestTracker-Tracker-Check" then
											frame.Icon:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\checkmark.tga")
										end
									end
								end
								if frame.Bar then
									if not frame.Bar.shadow then
										frame.Bar:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
										ElvUI_EltreumUI:ShadowColor(frame.Bar.shadow)
									end
									hooksecurefunc(frame, "SetValue", function(framebar)--,percent)
										local statusbar = framebar.Bar
										if not statusbar then return end
										--S:StatusBarColorGradient(statusbar, percent, 100)
										local r,g,b = statusbar:GetStatusBarColor()
										statusbar:GetStatusBarTexture():SetGradient("HORIZONTAL", {r=r - 0.4,g= g - 0.4,b= b - 0.4,a= E.db.general.backdropfadecolor.a}, {r=r + 0.2,g= g + 0.2,b= b + 0.2,a= E.db.general.backdropfadecolor.a})
										statusbar.backdrop:SetAlpha(E.db.general.backdropfadecolor.a)
										statusbar.backdrop:SetBackdropColor(0,0,0)
									end)
								end
							end

							if _G.ScenarioObjectiveTracker.StageBlock then
								if _G.ScenarioObjectiveTracker.StageBlock.WidgetContainer then
									if _G.ScenarioObjectiveTracker.StageBlock.WidgetContainer.widgetFrames then
										for _,v in pairs(_G.ScenarioObjectiveTracker.StageBlock.WidgetContainer.widgetFrames) do
											if v.Frame then
												v.Frame:SetAlpha(0)
											end
										end
									end
								end
							end
						end
					end)
				end

				local eventtrigger = CreateFrame("frame")
				eventtrigger:RegisterEvent("QUEST_WATCH_LIST_CHANGED")
				eventtrigger:RegisterEvent("QUEST_LOG_UPDATE")
				eventtrigger:RegisterEvent("FIRST_FRAME_RENDERED")
				eventtrigger:RegisterEvent("PLAYER_ENTERING_WORLD")
				eventtrigger:RegisterEvent("CONTENT_TRACKING_LIST_UPDATE")
				eventtrigger:RegisterEvent("CONTENT_TRACKING_UPDATE")
				eventtrigger:SetScript("OnEvent", function()
					firehooks()
					E:Delay(0, firehooks)
					--C_QuestLog.SortQuestWatches()
				end)

				hooksecurefunc(C_QuestLog, "AddQuestWatch", function()
					E:Delay(0, function()
						for _, k in pairs(questmodules) do
							if k.ContentsFrame then
								for _, v in pairs({k.ContentsFrame:GetChildren()}) do
									if v then
										v:UnregisterEvent("ADDON_ACTION_BLOCKED")
										v:UnregisterEvent("ADDON_ACTION_FORBIDDEN")
										blockskin(v)
									end
								end
							end
						end
						--C_QuestLog.SortQuestWatches()
					end)
				end)
			end
		elseif E.Classic then
			if IsAddOnLoaded('!KalielsTracker') or IsAddOnLoaded('SorhaQuestLog') or IsAddOnLoaded('ClassicQuestLog') or IsAddOnLoaded('Who Framed Watcher Wabbit?') then
				return
			end

			--move the text for no quests
			_G.QuestLogNoQuestsText:ClearAllPoints()
			_G.QuestLogNoQuestsText:SetPoint("CENTER", _G.QuestLogFrame, 0, 0)
			--make the whole thing bigger almost like retail
			_G.QuestLogFrame:SetWidth(765)
			_G.QuestLogFrame:SetHeight(550)
			--move the frame title
			_G.QuestLogTitleText:ClearAllPoints()
			_G.QuestLogTitleText:SetPoint("TOP", _G.QuestLogFrame, "TOP", 0, -20)
			--increase the size of the quest title frame
			_G.QuestLogListScrollFrame:SetHeight(390)
			_G.QuestLogListScrollFrame:SetWidth(350)
			--increase the size of the quest description frame and move it
			_G.QuestLogDetailScrollFrame:ClearAllPoints()
			_G.QuestLogDetailScrollFrame:SetPoint("TOPLEFT", _G.QuestLogListScrollFrame, "TOPRIGHT", 35, 0)
			_G.QuestLogDetailScrollFrame:SetHeight(390)

			-- Create the additional rows
			--local numQuests = QUESTS_DISPLAYED
			local numQuests = 6
			--QUESTS_DISPLAYED = QUESTS_DISPLAYED + 18
			_G.QUESTS_DISPLAYED = 24
			if dontexpandanymorequests == 0 then
				for i = numQuests + 1, 24 do
					local questTitlebutton = CreateFrame("Button", "QuestLogTitle" .. i, _G.QuestLogFrame, "QuestLogTitleButtonTemplate")
					questTitlebutton:SetID(i)
					questTitlebutton:Hide()
					questTitlebutton:ClearAllPoints()
					questTitlebutton:SetPoint("TOPLEFT", _G["QuestLogTitle" .. (i - 1)], "BOTTOMLEFT", 0, 1)
				end
				--increase the width of the rows so the title fits
				for i = 1, 24 do
					local questTitle = _G["QuestLogTitle"..i]
					questTitle:Width(335)
				end
				dontexpandanymorequests = 1
			end

			--add quest header like retail/cata
			if not _G["EltruismQuestLine"] then
				_G.QuestWatchFrame.HeaderBar = CreateFrame("StatusBar", "EltruismQuestLine", _G.QuestWatchFrame)
				_G.QuestWatchFrame.HeaderBar:SetMinMaxValues(0, 100)
				_G.QuestWatchFrame.HeaderBar:SetValue(100)
			else
				_G.QuestWatchFrame.HeaderBar = _G["EltruismQuestLine"]
			end

			--add a minimize button
			if not _G["EltruismMinimizeQuests"] then
				_G.QuestWatchFrame.Minimize = CreateFrame("BUTTON", "EltruismMinimizeQuests", E.UIParent, "MaximizeMinimizeButtonFrameTemplate")
				S:HandleMaxMinFrame(_G["EltruismMinimizeQuests"])
				_G["EltruismMinimizeQuests"]:SetTemplate("Backdrop")
				if E.db.ElvUI_EltreumUI.skins.questsettings.lineshadow and not _G.QuestWatchFrame.Minimize.shadow and E.private.general.pixelPerfect then
					_G.QuestWatchFrame.Minimize:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(_G.QuestWatchFrame.Minimize.shadow)
				end
				_G.QuestWatchFrame.Minimize.MaximizeButton:HookScript("OnClick",function()
					_G.QuestWatchFrame:Show()
					_G.QuestWatchFrame.isHidden = false
				end)
				_G.QuestWatchFrame.Minimize.MinimizeButton:HookScript("OnClick",function()
					_G.QuestWatchFrame:Hide()
					_G.QuestWatchFrame.isHidden = true
				end)
			else
				_G.QuestWatchFrame.Minimize = _G["EltruismMinimizeQuests"]
			end

			_G.QuestWatchFrame.HeaderBar:SetSize(E.db.ElvUI_EltreumUI.skins.questsettings.sizex, E.db.ElvUI_EltreumUI.skins.questsettings.sizey)
			if E.db.general.objectiveTracker then
				_G.QuestWatchFrame.HeaderBar:SetPoint("TOP", _G.QuestWatchFrameMover, "TOP", 0, 0)
			else
				_G.QuestWatchFrame.HeaderBar:SetPoint("TOP", _G.QuestWatchFrame, "TOP", 0, 0)
			end
			_G.QuestWatchFrame.HeaderBar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.skins.questsettings.texture))

			_G.QuestWatchFrame.Minimize:SetSize(15,15)
			_G.QuestWatchFrame.Minimize:SetPoint("BOTTOMRIGHT", _G.QuestWatchFrame.HeaderBar, "TOPRIGHT", 0, 10)

			--_G.QuestWatchFrame.HeaderBar:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b)
			if not E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor then
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
					_G.QuestWatchFrame.HeaderBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass))
				else
					_G.QuestWatchFrame.HeaderBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass))
				end
			else
				_G.QuestWatchFrame.HeaderBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r = E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor1r,g = E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor1g, b = E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor1b, a = 1},{r= E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor2r,g= E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor2g,b= E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor2b, a = 1})
			end
			if E.db.ElvUI_EltreumUI.skins.questsettings.lineshadow and not _G["EltruismQuestLine"].shadow and E.private.general.pixelPerfect then
				_G.QuestWatchFrame.HeaderBar:CreateBackdrop('Transparent')
				_G.QuestWatchFrame.HeaderBar:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				ElvUI_EltreumUI:ShadowColor(_G.QuestWatchFrame.HeaderBar.shadow)
			end
			local InvisFrameHeaderBar = CreateFrame("Frame", nil, _G.QuestWatchFrame.HeaderBar)
			InvisFrameHeaderBar:SetFrameLevel(_G.QuestWatchFrame.HeaderBar:GetFrameLevel() + 10)
			InvisFrameHeaderBar:SetInside()
			local QuestWatchFrameTitle = _G.QuestWatchFrame:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
			QuestWatchFrameTitle:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize+3, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			if E.db.ElvUI_EltreumUI.skins.questsettings.customcolortitle then
				QuestWatchFrameTitle:SetTextColor(E.db.ElvUI_EltreumUI.skins.questsettings.customrtitle, E.db.ElvUI_EltreumUI.skins.questsettings.customgtitle, E.db.ElvUI_EltreumUI.skins.questsettings.custombtitle)
			else
				QuestWatchFrameTitle:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
			end
			QuestWatchFrameTitle:SetParent(InvisFrameHeaderBar)
			QuestWatchFrameTitle:ClearAllPoints()
			QuestWatchFrameTitle:SetPoint("LEFT", InvisFrameHeaderBar, 6, 8)

			--from blizzard's FrameXML/_G.QuestLogFrame.lua
			--skin the classic objective frame
			hooksecurefunc("QuestWatch_Update",function()

				local NumQuests = select(2, GetNumQuestLogEntries())
				if (NumQuests >= (_G.MAX_QUESTS - 5)) then
					QuestWatchFrameTitle:SetText(format("|CFFFF0000%d/%d|r - %s", NumQuests, _G.MAX_QUESTS, _G.QUESTS_LABEL))
				else
					QuestWatchFrameTitle:SetText(_G.QUESTS_LABEL)
				end
				if (GetNumQuestWatches() == 0) then
					_G.QuestWatchFrame.HeaderBar:SetAlpha(0)
				else
					_G.QuestWatchFrame.HeaderBar:SetAlpha(1)
				end

				--hide/show minimize depending on having tracked quests
				if GetNumQuestWatches() == 0 then
					_G.QuestWatchFrame.Minimize:Hide()
				else
					_G.QuestWatchFrame.Minimize:Show()
				end

				local numObjectives
				local questWatchMaxWidth = 0
				local tempWidth
				local watchText
				--local text, type, finished --type is unused
				local text, _, finished
				--local questTitle --unused
				local watchTextIndex = 1
				local questIndex
				local objectivesCompleted

				for i=1, GetNumQuestWatches() do
					questIndex = GetQuestIndexForWatch(i)
					if ( questIndex ) then
						numObjectives = GetNumQuestLeaderBoards(questIndex)

						--If there are objectives set the title
						if ( numObjectives > 0 ) then
							-- Set title
							watchText = _G["QuestWatchLine"..watchTextIndex]
							watchText:SetText(GetQuestLogTitle(questIndex))
							watchText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
							--watchText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)

							tempWidth = watchText:GetWidth()
							-- Set the anchor of the title line a little lower
							if ( watchTextIndex > 1 ) then
								--watchText:SetPoint("TOPLEFT", "QuestWatchLine"..(watchTextIndex - 1), "BOTTOMLEFT", 0, -4)
								watchText:SetPoint("TOPLEFT", "QuestWatchLine"..(watchTextIndex - 1), "BOTTOMLEFT", 0, -10)
								--watchText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
							watchText:Show()
							if ( tempWidth > questWatchMaxWidth ) then
								questWatchMaxWidth = tempWidth
							end
							watchTextIndex = watchTextIndex + 1
							objectivesCompleted = 0
							for j=1, numObjectives do
								text, _, finished = GetQuestLogLeaderBoard(j, questIndex)
								if ( text == nil ) then
									text = ""
								end
								if ( finished == nil ) then
									finished = true
								end
								watchText = _G["QuestWatchLine"..watchTextIndex]
								-- Set Objective text
								watchText:SetText(" - "..text)
								watchText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
								--watchText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)

								--inspired by blinkii's skin, color
								local textclassic = watchText:GetText()
								if textclassic ~= nil then
									local left, right, questtext = strmatch(textclassic, "^(%d-)/(%d-) (.+)")
									local questtext2,left2, right2 = strmatch(textclassic, "(.+): (%d-)/(%d-)$")
									local left3, right3, questtext3 = strmatch(textclassic, "^- (%d-)/(%d-) (.+)")
									if left then
										local percentagedone = (tonumber(left) / tonumber(right)) * 100 or 0
										local r, g, b = E:ColorGradient(percentagedone * 0.01, 1, 0, 0, 1, 1, 0, 0, 1, 0)
										local hexstring = E:RGBToHex(r, g, b)
										watchText:SetText(format("%s%s/%s|r %s|r%s",hexstring,left,right,hexstring,questtext))
									elseif left2 then
										local percentagedone = (tonumber(left2) / tonumber(right2)) * 100 or 0
										local r, g, b = E:ColorGradient(percentagedone * 0.01, 1, 0, 0, 1, 1, 0, 0, 1, 0)
										local hexstring = E:RGBToHex(r, g, b)
										watchText:SetText(format("%s|r %s%s/%s|r",questtext2,hexstring,left2,right2))
									elseif left3 then
										local percentagedone = (tonumber(left3) / tonumber(right3)) * 100 or 0
										local r, g, b = E:ColorGradient(percentagedone * 0.01, 1, 0, 0, 1, 1, 0, 0, 1, 0)
										local hexstring = E:RGBToHex(r, g, b)
										watchText:SetText(format("- %s%s/%s|r %s|r%s",hexstring,left3,right3,hexstring,questtext3))
									end
								end

								-- Color the objectives
								if ( finished ) then
									watchText:SetTextColor(0, 1, 0)
									--watchText:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
									objectivesCompleted = objectivesCompleted + 1
								else
									watchText:SetTextColor(0.8, 0.8, 0.8)
								end
								tempWidth = watchText:GetWidth()
								if ( tempWidth > questWatchMaxWidth ) then
									questWatchMaxWidth = tempWidth
								end
								--watchText:SetPoint("TOPLEFT", "QuestWatchLine"..(watchTextIndex - 1), "BOTTOMLEFT", 0, 0)
								watchText:SetPoint("TOPLEFT", "QuestWatchLine"..(watchTextIndex - 1), "BOTTOMLEFT", 0, -5)
								--watchText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
								watchText:Show()
								watchTextIndex = watchTextIndex + 1
							end
							-- Brighten the quest title if all the quest objectives were met
							watchText = _G["QuestWatchLine"..watchTextIndex-numObjectives-1]
							if ( objectivesCompleted == numObjectives ) then
								--watchText:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
								watchText:SetTextColor(0, 1, 0)
							else
								if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
									watchText:SetTextColor(E.db.ElvUI_EltreumUI.skins.questsettings.customr, E.db.ElvUI_EltreumUI.skins.questsettings.customg, E.db.ElvUI_EltreumUI.skins.questsettings.customb)
								else
									watchText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
								end
							end
						end
					end
				end

				-- Set tracking indicator
				if ( GetNumQuestWatches() > 0 ) then
					QuestLogTrackTracking:SetVertexColor(0, 1.0, 0)
				else
					QuestLogTrackTracking:SetVertexColor(1.0, 0, 0)
				end

				-- If no watch lines used then hide the frame and return
				if ( watchTextIndex == 1 ) then
					_G.QuestWatchFrame:Hide()
					return
				else
					_G.QuestWatchFrame:Show()
					_G.QuestWatchFrame:SetHeight(watchTextIndex * 13)
					_G.QuestWatchFrame:SetWidth(questWatchMaxWidth + 10)
				end

				-- Hide unused watch lines
				for i=watchTextIndex, _G.MAX_QUESTWATCH_LINES do
					_G["QuestWatchLine"..i]:Hide()
				end

				if _G.QuestWatchFrame.isHidden then
					_G.QuestWatchFrame:Hide()
				end

				UIParent_ManageFramePositions()
			end)
		elseif E.Mists then

			--from blizzard's FrameXML/WatchFrame.lua
			if _G.ObjectiveFrameMover then
				questside = _G.ObjectiveFrameMover:GetPoint()
			else
				questside = "RIGHT"
			end

			--skin the classic objective frame, based on aftermathh's
			local function colorquests(line, _, _, isHeader, _, _, _, isComplete) --(line, anchor, verticalOffset, isHeader, text, dash, hasItem, isComplete)
				if line and line.text then
					if ( isHeader ) then
						--line.text:SetTextColor(0.75, 0.61, 0)
						line.text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
						if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
							line.text:SetTextColor(E.db.ElvUI_EltreumUI.skins.questsettings.customr, E.db.ElvUI_EltreumUI.skins.questsettings.customg, E.db.ElvUI_EltreumUI.skins.questsettings.customb)
						else
							line.text:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
						end
						--line.text:SetWidth(250)
					elseif isComplete then
						line.text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
						line.text:SetTextColor(0, 1, 0)
						--line.text:SetWidth(250)
					else
						line.text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
						line.text:SetTextColor(0.8, 0.8, 0.8)
						--line.text:SetWidth(250)

						--inspired by blinkii's skin, color
						local textcata = line.text:GetText()
						if textcata ~= nil then
							local left, right, questtext = strmatch(textcata, "^(%d-)/(%d-) (.+)")
							local questtext2,left2, right2 = strmatch(textcata, "(.+): (%d-)/(%d-)$")
							local left3, right3, questtext3 = strmatch(textcata, "^- (%d-)/(%d-) (.+)")
							if left then
								local percentagedone = (tonumber(left) / tonumber(right)) * 100 or 0
								local r, g, b = E:ColorGradient(percentagedone * 0.01, 1, 0, 0, 1, 1, 0, 0, 1, 0)
								local hexstring = E:RGBToHex(r, g, b)
								line.text:SetText(format("%s%s/%s|r %s|r%s",hexstring,left,right,hexstring,questtext))
							elseif left2 then
								local percentagedone = (tonumber(left2) / tonumber(right2)) * 100 or 0
								local r, g, b = E:ColorGradient(percentagedone * 0.01, 1, 0, 0, 1, 1, 0, 0, 1, 0)
								local hexstring = E:RGBToHex(r, g, b)
								line.text:SetText(format("%s|r %s%s/%s|r",questtext2,hexstring,left2,right2))
							elseif left3 then
								local percentagedone = (tonumber(left3) / tonumber(right3)) * 100 or 0
								local r, g, b = E:ColorGradient(percentagedone * 0.01, 1, 0, 0, 1, 1, 0, 0, 1, 0)
								local hexstring = E:RGBToHex(r, g, b)
								line.text:SetText(format("- %s%s/%s|r %s|r%s",hexstring,left3,right3,hexstring,questtext3))
							end
						end

					end
					if line.dash then
						line.dash:Hide()
						--line.dash:ClearAllPoints()
						--line.dash:SetPoint("RIGHT", line,"LEFT",-2,0)
					end
				end

				local WatchFrame = _G.WatchFrame
				local WatchFrameLines = _G.WatchFrameLines

				if not _G["EltruismQuestLine"] then
					WatchFrame.HeaderBar = CreateFrame("StatusBar", "EltruismQuestLine", WatchFrameLines)
					WatchFrame.HeaderBar:SetMinMaxValues(0, 100)
					WatchFrame.HeaderBar:SetValue(100)
				else
					WatchFrame.HeaderBar = _G["EltruismQuestLine"]
				end

				if WatchFrameLines.poiTable and not InCombatLockdown() then --fix new button point
					if WatchFrameLines.poiTable.completed then
						for _,v in pairs(WatchFrameLines.poiTable.completed) do
							if v then
								local point, relativeTo, relativePoint = v:GetPoint()
								if point then
									v:ClearAllPoints()
									v:SetPoint(point, relativeTo, relativePoint, -7, -3)
								end
							end
						end
					end
					if WatchFrameLines.poiTable.numeric then
						for _,v in pairs(WatchFrameLines.poiTable.numeric) do
							if v then
								local point, relativeTo, relativePoint = v:GetPoint()
								if point then
									v:ClearAllPoints()
									v:SetPoint(point, relativeTo, relativePoint, -7, -3)
								end
							end
						end
					end
				end

				WatchFrame.HeaderBar:SetSize(E.db.ElvUI_EltreumUI.skins.questsettings.sizex, E.db.ElvUI_EltreumUI.skins.questsettings.sizey)
				WatchFrame.HeaderBar:SetPoint("TOP", WatchFrame, "TOP", 0, -23)
				WatchFrame.HeaderBar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.skins.questsettings.texture))
				--WatchFrame.HeaderBar:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b)
				if not E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
						WatchFrame.HeaderBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass))
					else
						WatchFrame.HeaderBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass))
					end
				else
					WatchFrame.HeaderBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r = E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor1r,g = E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor1g, b = E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor1b, a = 1},{r= E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor2r,g= E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor2g,b= E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor2b, a = 1})
				end

				if E.db.ElvUI_EltreumUI.skins.questsettings.lineshadow and not _G["EltruismQuestLine"].shadow and E.private.general.pixelPerfect then
					_G["EltruismQuestLine"]:CreateBackdrop('Transparent')
					_G["EltruismQuestLine"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(_G["EltruismQuestLine"].shadow)
				end

				local InvisFrameHeaderBar = CreateFrame("Frame", nil, WatchFrame.HeaderBar)
				InvisFrameHeaderBar:SetFrameLevel(WatchFrame.HeaderBar:GetFrameLevel() + 10)
				InvisFrameHeaderBar:SetInside()

				local WatchFrameTitle = _G.WatchFrameTitle
				WatchFrameTitle:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize+3, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				if E.db.ElvUI_EltreumUI.skins.questsettings.customcolortitle then
					WatchFrameTitle:SetTextColor(E.db.ElvUI_EltreumUI.skins.questsettings.customrtitle, E.db.ElvUI_EltreumUI.skins.questsettings.customgtitle, E.db.ElvUI_EltreumUI.skins.questsettings.custombtitle)
				else
					WatchFrameTitle:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
				end

				WatchFrameTitle:SetParent(InvisFrameHeaderBar)
				WatchFrameTitle:ClearAllPoints()
				WatchFrameTitle:SetPoint("LEFT", InvisFrameHeaderBar, 6, 8)

				local NumQuests = select(2, GetNumQuestLogEntries())

				if (NumQuests >= (_G.MAX_QUESTS - 5)) then
					WatchFrameTitle:SetText(format("|CFFFF0000%d/%d|r - %s", NumQuests, _G.MAX_QUESTS, _G.QUESTS_LABEL))
				else
					WatchFrameTitle:SetText(_G.QUESTS_LABEL)
				end

				if (GetNumQuestWatches() == 0) then
					WatchFrame.HeaderBar:SetAlpha(0)
				else
					WatchFrame.HeaderBar:SetAlpha(1)
				end

				for i = 1, _G.WATCHFRAME_NUM_ITEMS do
					local Button = _G["WatchFrameItem"..i]
					if not (Button) then
						return
					end
					local _, Anchor = Button:GetPoint()
					if Button.eltruismbgtexture then
						Button.eltruismbgtexture:Hide()
					end

					if _G["WatchFrameItem"..i.."HotKey"] then
						_G["WatchFrameItem"..i.."HotKey"]:SetText("")
					end
					if Anchor ~= nil then
						Button:ClearAllPoints()
						if questside:match("RIGHT") then
							Button:SetPoint("LEFT", Anchor, "LEFT", -70, -10)
						else
							Button:SetPoint("RIGHT", Anchor, "RIGHT", 120, -10)
						end
						Button:UnregisterEvent("PLAYER_TARGET_CHANGED")

						if not (Button.QuestTexture) then
							if _G["EltruismQuestTexture"] then
								Button.QuestTexture = _G["EltruismQuestTexture"]
							else
								Button.QuestTexture = Button:CreateTexture("EltruismQuestTexture")
							end
							Button.QuestTexture:SetSize(24, 24)
							if questside:match("RIGHT") then
								Button.QuestTexture:SetPoint("LEFT", Button, "LEFT", -12, 0)
							else
								Button.QuestTexture:SetPoint("RIGHT", Button, "RIGHT", 26, 0)
							end
							Button.QuestTexture:SetTexture(E.Media.Textures.BagQuestIcon)
							Button.QuestTexture:SetParent(Button)
						end
						Button:SetSize(E.db.ElvUI_EltreumUI.skins.questsettings.linebuttonsize, E.db.ElvUI_EltreumUI.skins.questsettings.linebuttonsize)
						if E.db.ElvUI_EltreumUI.skins.questsettings.lineshadow and not Button.shadow and E.private.general.pixelPerfect then
							Button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(Button.shadow)
						end
						S:HandleButton(Button)
						local texture = _G["WatchFrameItem"..i.."IconTexture"]
						texture:SetTexCoord(0.08,0.92,0.08,0.92)
					else
						Button:ClearAllPoints()
						if _G["EltruismQuestTexture"] then
							_G["EltruismQuestTexture"]:ClearAllPoints()
						end
					end
				end
			end
			hooksecurefunc("WatchFrame_SetLine", colorquests)
			hooksecurefunc("WatchFrame_Update",colorquests)

			--fix? item moving to wrong side
			hooksecurefunc("WatchFrameItem_OnEvent", function()
				for i = 1, _G.WATCHFRAME_NUM_ITEMS do
					local Button = _G["WatchFrameItem"..i]
					if not (Button) then
						return
					end
					local _, Anchor = Button:GetPoint()
					Button:ClearAllPoints()
					if _G["WatchFrameItem"..i.."HotKey"] then
						_G["WatchFrameItem"..i.."HotKey"]:SetText("")
					end
					if Anchor ~= nil then
						if questside:match("RIGHT") then
							Button:SetPoint("LEFT", Anchor, "LEFT", -70, -10)
						else
							Button:SetPoint("RIGHT", Anchor, "RIGHT", 120, -10)
						end
					elseif Anchor == nil then
						if questside:match("RIGHT") then
							Button:SetPoint("LEFT", _G["WatchFrameLine"..i.."Text"], "LEFT", -70, -10)
						else
							Button:SetPoint("RIGHT", _G["WatchFrameLine"..i.."Text"], "RIGHT", 120, -10)
						end
					end
				end
			end)

			_G["WatchFrameCollapseExpandButton"]:GetNormalTexture():SetTexture("Interface\\Addons\\ElvUI\\Core\\Media\\Textures\\MinusButton")
			_G["WatchFrameCollapseExpandButton"]:GetNormalTexture():SetTexCoord(0, 1, 0, 1)
			_G["WatchFrameCollapseExpandButton"]:GetPushedTexture():SetTexture("Interface\\Addons\\ElvUI\\Core\\Media\\Textures\\MinusButton")
			_G["WatchFrameCollapseExpandButton"]:GetPushedTexture():SetTexCoord(0, 1, 0, 1)

			if not _G["WatchFrameCollapseExpandButton"].shadow then
				_G["WatchFrameCollapseExpandButton"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				_G["WatchFrameCollapseExpandButton"].shadow:ClearAllPoints()
				_G["WatchFrameCollapseExpandButton"].shadow:SetPoint("TOPLEFT", _G["WatchFrameCollapseExpandButton"], "TOPLEFT", -1, 1)
				_G["WatchFrameCollapseExpandButton"].shadow:SetPoint("TOPRIGHT", _G["WatchFrameCollapseExpandButton"], "TOPRIGHT", 1, 1)
				_G["WatchFrameCollapseExpandButton"].shadow:SetPoint("BOTTOMLEFT", _G["WatchFrameCollapseExpandButton"], "BOTTOMLEFT", -1, -1)
				_G["WatchFrameCollapseExpandButton"].shadow:SetPoint("BOTTOMLEFT", _G["WatchFrameCollapseExpandButton"], "BOTTOMLEFT", 1, -1)
				ElvUI_EltreumUI:ShadowColor(_G["WatchFrameCollapseExpandButton"].shadow)
			end

			hooksecurefunc("WatchFrame_Collapse", function()
				_G["WatchFrameCollapseExpandButton"]:GetNormalTexture():SetTexture("Interface\\Addons\\ElvUI\\Core\\Media\\Textures\\PlusButton")
				_G["WatchFrameCollapseExpandButton"]:GetNormalTexture():SetTexCoord(0, 1, 0, 1)
				_G["WatchFrameCollapseExpandButton"]:GetPushedTexture():SetTexture("Interface\\Addons\\ElvUI\\Core\\Media\\Textures\\PlusButton")
				_G["WatchFrameCollapseExpandButton"]:GetPushedTexture():SetTexCoord(0, 1, 0, 1)

			end)
			hooksecurefunc("WatchFrame_Expand", function()
				_G["WatchFrameCollapseExpandButton"]:GetNormalTexture():SetTexture("Interface\\Addons\\ElvUI\\Core\\Media\\Textures\\MinusButton")
				_G["WatchFrameCollapseExpandButton"]:GetNormalTexture():SetTexCoord(0, 1, 0, 1)
				_G["WatchFrameCollapseExpandButton"]:GetPushedTexture():SetTexture("Interface\\Addons\\ElvUI\\Core\\Media\\Textures\\MinusButton")
				_G["WatchFrameCollapseExpandButton"]:GetPushedTexture():SetTexCoord(0, 1, 0, 1)
			end)

			_G["WatchFrameCollapseExpandButton"]:HookScript("OnShow", function()
				E:Delay(0, function()
					_G["WatchFrameCollapseExpandButton"]:GetNormalTexture():SetTexture("Interface\\Addons\\ElvUI\\Core\\Media\\Textures\\MinusButton")
					_G["WatchFrameCollapseExpandButton"]:GetNormalTexture():SetTexCoord(0, 1, 0, 1)
					_G["WatchFrameCollapseExpandButton"]:GetPushedTexture():SetTexture("Interface\\Addons\\ElvUI\\Core\\Media\\Textures\\MinusButton")
					_G["WatchFrameCollapseExpandButton"]:GetPushedTexture():SetTexCoord(0, 1, 0, 1)
				end)
			end)

			--highlight
			hooksecurefunc("WatchFrameLinkButtonTemplate_Highlight", function(quest, onEnter)
				local line
				_G.WatchFrame_Update()
				for index = quest.startLine, quest.lastLine do
					line = quest.lines[index]
					if ( line ) then
						local testr,testg,testb = line.text:GetTextColor()
						if (testr == 0) and (testg == 0.99999779462814) and (testb == 0) then
							line.text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
							--line.text:SetWidth(250)
						else
							if ( index == quest.startLine ) then
								-- header
								if ( onEnter ) then

									line.text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
									if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
										line.text:SetTextColor(E.db.ElvUI_EltreumUI.skins.questsettings.customr+0.2, E.db.ElvUI_EltreumUI.skins.questsettings.customg+0.2, E.db.ElvUI_EltreumUI.skins.questsettings.customb+0.2)
									else
										line.text:SetTextColor(classcolor.r+0.2, classcolor.g+0.2, classcolor.b+0.2)
									end
									--line.text:SetWidth(250)
								else
									line.text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
									if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
										line.text:SetTextColor(E.db.ElvUI_EltreumUI.skins.questsettings.customr, E.db.ElvUI_EltreumUI.skins.questsettings.customg, E.db.ElvUI_EltreumUI.skins.questsettings.customb)
									else
										line.text:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
									end
									--line.text:SetWidth(250)
								end
							else
								if ( onEnter ) then
									line.text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
									line.text:SetTextColor(1, 1, 1)
									--line.dash:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
									--line.dash:SetTextColor(1, 1, 1)
									--line.text:SetWidth(250)
								else
									line.text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
									line.text:SetTextColor(0.8, 0.8, 0.8)
									--line.dash:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
									--line.dash:SetTextColor(0.8, 0.8, 0.8)
									--line.text:SetWidth(250)
									--line.text:ClearAllPoints()
									--line.text:SetPoint("LEFT", line.dash, "RIGHT")
								end
							end
						end
					end
				end
			end)
			_G.WatchFrame_Update()
		end
	end
end

--adapted from ObjectiveTracker_UpdateHeight()
function ElvUI_EltreumUI:UpdateObjectiveTrackerHeight()
	local isScenarioBlockShowing = _G.ScenarioObjectiveTracker and _G.ScenarioObjectiveTracker:IsShown()
	local scenarioBlockHeight = isScenarioBlockShowing and (_G.ScenarioObjectiveTracker:GetHeight() + _G.ScenarioObjectiveTracker.Header:GetHeight() + 10) or 0

	local newHeight = math.max(E.db.ElvUI_EltreumUI.skins.questsettings.objectiveFrameHeight, scenarioBlockHeight)
	E.db.general.objectiveFrameAutoHide = false --causes taints otherwise

	_G["ObjectiveFrameHolder"]:SetSize(260,newHeight) --due to nil rect set the size on the holder itself
	if not InCombatLockdown() then --just for sanity sake keep trying to set the size
		Enum.EditModeObjectiveTrackerSetting.Height = newHeight
		ObjectiveTrackerFrame:SetHeight(newHeight)
		ObjectiveTrackerFrame:BreakFromFrameManager()
	end
end

--add objective frame anchor back in
function ElvUI_EltreumUI:ObjectiveTrackerAnchor()
	if E.db.ElvUI_EltreumUI.quests.anchor then
		if not _G["ObjectiveFrameHolder"] then
			local holder = CreateFrame("FRAME", "ObjectiveFrameHolder", E.UIParent)
			holder:SetSize(260, 550)
			holder:SetPoint("TOPRIGHT", E.UIParent, "TOPRIGHT", -75,-319)
			holder:SetClampedToScreen(true)

			ObjectiveTrackerFrame:BreakFromFrameManager()
			ObjectiveTrackerFrame.Selection:Kill()
			Enum.EditModeObjectiveTrackerSetting.Opacity = 0 --fix nineslice
			ObjectiveTrackerFrame.editModeOpacity = 0 --fix nineslice
			if ObjectiveTrackerFrame.NineSlice then
				ObjectiveTrackerFrame.NineSlice:SetAlpha(0)
			end

			_G.ObjectiveTrackerFrame:SetClampedToScreen(false)
			_G.ObjectiveTrackerFrame:SetMovable(true)
			_G.ObjectiveTrackerFrame:SetUserPlaced(true) -- UIParent.lua line 3090 stops it from being moved <
			_G.ObjectiveTrackerFrame:ClearAllPoints()
			_G.ObjectiveTrackerFrame:SetPoint("TOP", holder, "TOP")
			_G.ObjectiveTrackerFrame:SetPoint("BOTTOM", holder, "BOTTOM")
			E:CreateMover(holder, "ObjectiveFrameMover", L["Objective Frame"], nil, nil, nil, "ALL,GENERAL", nil, 'ElvUI_EltreumUI,quests')

			ElvUI_EltreumUI:UpdateObjectiveTrackerHeight()
		else
			ObjectiveTrackerFrame:BreakFromFrameManager()
			ObjectiveTrackerFrame.Selection:Kill()
			_G.ObjectiveTrackerFrame:SetClampedToScreen(false)
			_G.ObjectiveTrackerFrame:SetMovable(true)
			_G.ObjectiveTrackerFrame:SetUserPlaced(true) -- UIParent.lua line 3090 stops it from being moved <
			_G.ObjectiveTrackerFrame:ClearAllPoints()
			_G.ObjectiveTrackerFrame:SetPoint("TOP", _G["ObjectiveFrameHolder"], "TOP")
			_G.ObjectiveTrackerFrame:SetPoint("BOTTOM", _G["ObjectiveFrameHolder"], "BOTTOM")
			ElvUI_EltreumUI:UpdateObjectiveTrackerHeight()
		end
	end
end

--because the objective is removed from frame manager, when swapping to another layout that isnt it can error when trying to export it, so break it from manager again
if E.Retail then
	local editmodecheck = CreateFrame("FRAME")
	editmodecheck:RegisterEvent("EDIT_MODE_LAYOUTS_UPDATED")
	editmodecheck:RegisterEvent("FIRST_FRAME_RENDERED")
	editmodecheck:SetScript("OnEvent",function()
		if not E.private.ElvUI_EltreumUI then return end
		if not E.private.ElvUI_EltreumUI.install_version then return end
		if not E.db.ElvUI_EltreumUI then return end
		if not E.db.ElvUI_EltreumUI.quests then return end
		if E.db.ElvUI_EltreumUI.quests.anchor then
			ElvUI_EltreumUI:ObjectiveTrackerAnchor()

			if not _G.EditModeManagerFrame.EltruismExitRL then --call for a reload on blizzard's edit mode changes
				_G.EditModeManagerFrame:HookScript("OnHide", function()
					E:StaticPopup_Show('CONFIG_RL')
				end)
				_G.EditModeManagerFrame.EltruismExitRL = true
			end
		end
	end)
end
