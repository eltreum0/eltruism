local E, L = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local classcolor = E:ClassColor(E.myclass, true)
local CreateFrame = _G.CreateFrame
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded
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

local classcolorsescape = {
	["DEATHKNIGHT"]	= "C41E3A",
	["DEMONHUNTER"]	= "A330C9",
	["DRUID"] = "FF7C0A",
	["HUNTER"] = "AAD372",
	["MAGE"] = "3FC7EB",
	["MONK"] = "00FF98",
	["PALADIN"]	= "F48CBA",
	["PRIEST"] = "FFFFFF",
	["ROGUE"] = "FFF468",
	["SHAMAN"] = "0070DD",
	["WARLOCK"] = "8788EE",
	["WARRIOR"] = "C69B6D",
	["EVOKER"] = "33937F",
}

--skin objective frame depending on verison
function ElvUI_EltreumUI:SkinQuests()

	--[[if E.private.skins.parchmentRemoverEnable then
		if _G["QuestDetailScrollFrame"] then
			_G["QuestDetailScrollFrame"]:SetBackdrop()
		end
	end]]

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
		elseif E.Wrath then
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
		elseif E.Wrath and not E.Cata then
			if E.locale == "deDE" then
				wowheadregion = "wowhead.com/wotlk/de"
			elseif E.locale == "enUS" or E.locale == "enCN" or E.locale == "enGB" or E.locale == "enTW" then
				wowheadregion = "wowhead.com/wotlk"
			elseif E.locale == "esMX" or E.locale == "esES" then
				wowheadregion = "wowhead.com/wotlk/es"
			elseif E.locale == "frFR" then
				wowheadregion = "wowhead.com/wotlk/fr"
			elseif E.locale == "itIT" then
				wowheadregion = "wowhead.com/wotlk/it"
			elseif E.locale == "koKR" then
				wowheadregion = "wowhead.com/wotlk/ko"
			elseif E.locale == "ptBR" or E.locale == "ptPT" then
				wowheadregion = "wowhead.com/wotlk/pt"
			elseif E.locale == "ruRU" then
				wowheadregion = "wowhead.com/wotlk/ru"
			elseif E.locale == "zhCN" or E.locale == "zhTW" then
				wowheadregion = "wowhead.com/wotlk/cn"
			end
		elseif E.Cata then
			if E.locale == "deDE" then
				wowheadregion = "wowhead.com/cata/de"
			elseif E.locale == "enUS" or E.locale == "enCN" or E.locale == "enGB" or E.locale == "enTW" then
				wowheadregion = "wowhead.com/cata"
			elseif E.locale == "esMX" or E.locale == "esES" then
				wowheadregion = "wowhead.com/cata/es"
			elseif E.locale == "frFR" then
				wowheadregion = "wowhead.com/cata/fr"
			elseif E.locale == "itIT" then
				wowheadregion = "wowhead.com/cata/it"
			elseif E.locale == "koKR" then
				wowheadregion = "wowhead.com/cata/ko"
			elseif E.locale == "ptBR" or E.locale == "ptPT" then
				wowheadregion = "wowhead.com/cata/pt"
			elseif E.locale == "ruRU" then
				wowheadregion = "wowhead.com/cata/ru"
			elseif E.locale == "zhCN" or E.locale == "zhTW" then
				wowheadregion = "wowhead.com/cata/cn"
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
				if questID ~= 0 then
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
		elseif E.Wrath or E.Cata then
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
				local ObjectiveTrackerBonusBannerFrame = _G.ObjectiveTrackerBonusBannerFrame
				if ObjectiveTrackerBonusBannerFrame then
					--textcoords from https://www.townlong-yak.com/framexml/39229/Helix/AtlasInfo.lua
					ObjectiveTrackerBonusBannerFrame.Title:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
					ObjectiveTrackerBonusBannerFrame.Title:SetShadowOffset(2,-2)
					ObjectiveTrackerBonusBannerFrame.Title:SetText("") --so that the text doesn't show up when it shouldnt
					ObjectiveTrackerBonusBannerFrame.BG1:SetDesaturated(true)
					ObjectiveTrackerBonusBannerFrame.BG2:SetDesaturated(true)
					ObjectiveTrackerBonusBannerFrame.Icon:SetDesaturated(true)
					ObjectiveTrackerBonusBannerFrame.Icon2:SetDesaturated(true)
					ObjectiveTrackerBonusBannerFrame.Icon3:SetDesaturated(true)
					ObjectiveTrackerBonusBannerFrame.BG1:SetVertexColor(classcolor.r, classcolor.g, classcolor.b) --bonusobjectives-title-bg
					ObjectiveTrackerBonusBannerFrame.BG2:SetVertexColor(classcolor.r, classcolor.g, classcolor.b) --bonusobjectives-title-bg
					ObjectiveTrackerBonusBannerFrame.Icon:SetVertexColor(classcolor.r, classcolor.g, classcolor.b) --bonusobjectives-title-icon
					ObjectiveTrackerBonusBannerFrame.Icon2:SetVertexColor(classcolor.r, classcolor.g, classcolor.b) --bonusobjectives-title-icon
					ObjectiveTrackerBonusBannerFrame.Icon3:SetVertexColor(classcolor.r, classcolor.g, classcolor.b) --bonusobjectives-title-icon
				end

				local questside
				if _G.ObjectiveFrameMover then
					questside = _G.ObjectiveFrameMover:GetPoint()
				else
					questside = "RIGHT"
				end

				--Interface/AddOns/Blizzard_ObjectiveTracker/Blizzard_ObjectiveTracker.lua
				local questmodules = {
					_G.QUEST_TRACKER_MODULE,
					_G.ACHIEVEMENT_TRACKER_MODULE,
					_G.BONUS_OBJECTIVE_TRACKER_MODULE,
					_G.WORLD_QUEST_TRACKER_MODULE,
					_G.UI_WIDGET_TRACKER_MODULE,
					_G.CAMPAIGN_QUEST_TRACKER_MODULE,
					_G.PROFESSION_RECIPE_TRACKER_MODULE,
					_G.MONTHLY_ACTIVITIES_TRACKER_MODULE,
					_G.ADVENTURE_TRACKER_MODULE,
				}
				local mult = 0.85
				for _, k in pairs(questmodules) do
					hooksecurefunc(k, "AddObjective", function(_, block,objectiveKey,_,lineType)
						if not block then
							return
						end
						if E.db.ElvUI_EltreumUI.skins.shadow.enable then --minimize shadows
							if k.Header.MinimizeButton and not k.Header.MinimizeButton.shadow then
								k.Header.MinimizeButton:CreateShadow()
								k.Header.MinimizeButton.shadow:ClearAllPoints()
								k.Header.MinimizeButton.shadow:SetPoint("TOPLEFT", k.Header.MinimizeButton.tex, "TOPLEFT", -2,2)
								k.Header.MinimizeButton.shadow:SetPoint("BOTTOMRIGHT", k.Header.MinimizeButton.tex, "BOTTOMRIGHT", 2,-2)
								ElvUI_EltreumUI:ShadowColor(k.Header.MinimizeButton.shadow)
							end
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
						if block.currentLine then --quest text
							if block.currentLine.objectiveKey == 0 then --also quest title
								block.currentLine.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
								if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
									block.currentLine.Text:SetTextColor(mult * E.db.ElvUI_EltreumUI.skins.questsettings.customr, mult * E.db.ElvUI_EltreumUI.skins.questsettings.customg, mult * E.db.ElvUI_EltreumUI.skins.questsettings.customb)
								else
									block.currentLine.Text:SetTextColor(mult * classcolor.r, mult * classcolor.g, mult * classcolor.b)
								end
								block.currentLine.Text:SetWordWrap(true)
							else --step/description of the quest
								block.currentLine.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
								block.currentLine.Text:SetTextColor(mult, mult, mult)
								block.currentLine.Text:SetWordWrap(true)

								--inspired by blinkii's skin, color
								local text = block.currentLine.Text:GetText()
								if block.currentLine.Check then
									if E.db.ElvUI_EltreumUI.skins.questsettings.hideCheck then
										block.currentLine.Check:Hide()
									else
										block.currentLine.Check:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\checkmark.tga")
										local _,frame = block.currentLine.Check:GetPoint()
										block.currentLine.Check:ClearAllPoints()
										block.currentLine.Check:SetPoint("RIGHT", frame,"LEFT", 2,0)
									end
								end

								if text ~= nil then
									local left, right, questtext = string.match(text, "^(%d-)/(%d-) (.+)")
									local questtext2,left2, right2 = string.match(text, "(.+): (%d-)/(%d-)$")
									local left3, right3, questtext3 = strmatch(text, "^- (%d-)/(%d-) (.+)")
									if left then
										local percentagedone = (tonumber(left) / tonumber(right)) * 100 or 0
										local r, g, b = E:ColorGradient(percentagedone * 0.01, 1, 0, 0, 1, 1, 0, 0, 1, 0)
										local hexstring = E:RGBToHex(r, g, b)
										block.currentLine.Text:SetText(format("%s%s/%s|r %s|r%s",hexstring,left,right,hexstring,questtext))
										if percentagedone >= 100 or (block.currentLine.Check and block.currentLine.Check:IsShown()) then
											block.currentLine.Text:SetTextColor(0.12, 1, 0.12)
										else
											block.currentLine.Text:SetTextColor(0.85, 0.85, 0.85)
										end
									elseif left2 then
										local percentagedone = (tonumber(left2) / tonumber(right2)) * 100 or 0
										local r, g, b = E:ColorGradient(percentagedone * 0.01, 1, 0, 0, 1, 1, 0, 0, 1, 0)
										local hexstring = E:RGBToHex(r, g, b)
										block.currentLine.Text:SetText(format("%s|r %s%s/%s|r",questtext2,hexstring,left2,right2))
										if percentagedone >= 100 or (block.currentLine.Check and block.currentLine.Check:IsShown()) then
											block.currentLine.Text:SetTextColor(0.12, 1, 0.12)
										else
											block.currentLine.Text:SetTextColor(0.85, 0.85, 0.85)
										end
									elseif left3 then
										local percentagedone = (tonumber(left3) / tonumber(right3)) * 100 or 0
										local r, g, b = E:ColorGradient(percentagedone * 0.01, 1, 0, 0, 1, 1, 0, 0, 1, 0)
										local hexstring = E:RGBToHex(r, g, b)
										block.currentLine.Text:SetText(format("- %s%s/%s|r %s|r%s",hexstring,left3,right3,hexstring,questtext3))
										if percentagedone >= 100 or (block.currentLine.Check and block.currentLine.Check:IsShown()) then
											block.currentLine.Text:SetTextColor(0.12, 1, 0.12)
										else
											block.currentLine.Text:SetTextColor(0.85, 0.85, 0.85)
										end
									else
										if text == _G.QUEST_WATCH_QUEST_READY or (block.currentLine.Check and block.currentLine.Check:IsShown()) then
											block.currentLine.Text:SetTextColor(0.12, 1, 0.12)
										else
											block.currentLine.Text:SetTextColor(0.85, 0.85, 0.85)
										end
									end
								end
							end
						end
						if block.itemButton then
							if E.db.ElvUI_EltreumUI.skins.shadow.enable and not block.itemButton.shadow then
								block.itemButton:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(block.itemButton.shadow)
							end
							if _G.ObjectiveFrameMover then
								questside = _G.ObjectiveFrameMover:GetPoint()
							else
								questside = "RIGHT"
							end
							if questside:match("RIGHT") then
								block.itemButton:ClearAllPoints()
								block.itemButton:SetPoint("TOPLEFT", block.HeaderText, "TOPLEFT", -60, -3)
							else
								block.itemButton:ClearAllPoints()
								block.itemButton:SetPoint("TOPRIGHT", block.HeaderText, "TOPRIGHT", 80, -3)
							end
						end
						if block.groupFinderButton and E.db.ElvUI_EltreumUI.skins.shadow.enable and not block.groupFinderButton.shadow then
							block.groupFinderButton:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(block.groupFinderButton.shadow)
						end
						local line = DEFAULT_OBJECTIVE_TRACKER_MODULE:GetLine(block, objectiveKey, lineType)
						if ( line.Dash ) then
							if E.db.ElvUI_EltreumUI.skins.questsettings.hideDash then
								line.Dash:SetText("")
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
							if E.db.ElvUI_EltreumUI.skins.questsettings.hideDash then
								local nodash = gsub(line.Text:GetText(),"- ","")
								line.Text:SetText(nodash)
							else
								local coloreddash = gsub(line.Text:GetText(),"- ","|cff"..classcolorsescape[E.myclass].."-  |r")
								line.Text:SetText(coloreddash)
							end
						end
					end)
				end

				if _G.ObjectiveTrackerFrame.HeaderMenu.Title then --fix when collapsed
					_G.ObjectiveTrackerFrame.HeaderMenu.Title:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSizeHeader, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
					_G.ObjectiveTrackerFrame.HeaderMenu.Title:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
				end

				hooksecurefunc('ObjectiveTracker_Update', function ()
					local modules = ObjectiveTrackerFrame.MODULES
					if not modules then
						return
					end
					for i = 1, #modules do
						local module = modules[i]
						if module and module.Header and module.Header.Text then --the big type of quest
							if not ElvUI_EltreumUI:SLCheck('quest') then
								module.Header.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSizeHeader, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
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
									module.Header.EltruismStatusLine = CreateFrame("StatusBar", "Eltruism"..module.Header.Text:GetText().."Line", module.Header)
								else
									module.Header.EltruismStatusLine = CreateFrame("StatusBar", "EltruismLine", module.Header)
								end
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
								if E.db.ElvUI_EltreumUI.skins.questsettings.lineshadow and not module.Header.EltruismStatusLine.shadow then
									module.Header.EltruismStatusLine:CreateBackdrop('Transparent')
									module.Header.EltruismStatusLine:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
									ElvUI_EltreumUI:ShadowColor(module.Header.EltruismStatusLine.shadow)
								end
							end
						end
					end

					--add quest count
					if _G.ObjectiveTrackerBlocksFrame and _G.ObjectiveTrackerBlocksFrame.QuestHeader and _G.ObjectiveTrackerBlocksFrame.QuestHeader.Text then
						local NumQuests = select(2, _G.C_QuestLog.GetNumQuestLogEntries())
						--if (NumQuests >= (MAX_QUESTS - 5)) then --global still returning 25
						if (NumQuests >= 30) then
							--_G.ObjectiveTrackerBlocksFrame.QuestHeader.Text:SetText(format("|CFFFF0000%d/%d|r - %s", NumQuests, MAX_QUESTS, QUESTS_LABEL))
							_G.ObjectiveTrackerBlocksFrame.QuestHeader.Text:SetText(format("|CFFFF0000%d/%d|r - %s", NumQuests, 35, QUESTS_LABEL))
						--else
						--	_G.ObjectiveTrackerBlocksFrame.QuestHeader.Text:SetText(QUESTS_LABEL)
						end
					end
				end)

				--skin the progress bars
				local function EltreumSkinProgressBars(_, _, line)
					local progressBar = line and line.ProgressBar
					local bar = progressBar and progressBar.Bar
					if not bar then return end
					if not progressBar.EltruismSkin then
						if E.db.ElvUI_EltreumUI.skins.questsettings.lineshadow then
							bar:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(bar.shadow)
							if progressBar.block and progressBar.Bar.Icon then
								if progressBar.backdrop and not progressBar.backdrop.shadow then
									progressBar.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
									ElvUI_EltreumUI:ShadowColor(progressBar.backdrop.shadow)
								end
							end
						end

						--E:Delay(0, function()
						progressBar.Bar.backdrop:SetAlpha(E.db.general.backdropfadecolor.a)
						progressBar.Bar.backdrop:SetBackdropColor(0,0,0)
						progressBar.Bar.backdrop.SetBackdropColor = E.noop
						--end)
						progressBar.Bar:GetStatusBarTexture():SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.skins.queststatusbartexture))
						hooksecurefunc(progressBar.Bar, "SetStatusBarColor", function(_, r, g, b)
							progressBar.Bar:GetStatusBarTexture():SetGradient("HORIZONTAL", {r=r - 0.4,g= g - 0.4,b= b - 0.4,a= E.db.general.backdropfadecolor.a}, {r=r + 0.2,g= g + 0.2,b= b + 0.2,a= E.db.general.backdropfadecolor.a})
							progressBar.Bar.backdrop:SetAlpha(E.db.general.backdropfadecolor.a)
							progressBar.Bar.backdrop:SetBackdropColor(0,0,0)
						end)
						progressBar.EltruismSkin = true
					end
				end
				hooksecurefunc(_G.QUEST_TRACKER_MODULE, "AddProgressBar", EltreumSkinProgressBars)
				hooksecurefunc(_G.BONUS_OBJECTIVE_TRACKER_MODULE, "AddProgressBar", EltreumSkinProgressBars)
				hooksecurefunc(_G.WORLD_QUEST_TRACKER_MODULE, "AddProgressBar", EltreumSkinProgressBars)
				hooksecurefunc(_G.CAMPAIGN_QUEST_TRACKER_MODULE, "AddProgressBar", EltreumSkinProgressBars)
				hooksecurefunc(_G.SCENARIO_TRACKER_MODULE, "AddProgressBar", EltreumSkinProgressBars)
				hooksecurefunc(_G.DEFAULT_OBJECTIVE_TRACKER_MODULE, "AddProgressBar", EltreumSkinProgressBars)
				hooksecurefunc(_G.UI_WIDGET_TRACKER_MODULE,"AddProgressBar", EltreumSkinProgressBars)
				hooksecurefunc(_G.MONTHLY_ACTIVITIES_TRACKER_MODULE,"AddProgressBar", EltreumSkinProgressBars)

				hooksecurefunc(_G.SCENARIO_CONTENT_TRACKER_MODULE, 'UpdateCriteria', function ()
					if _G.ScenarioObjectiveBlock then
						local frames = {_G.ScenarioObjectiveBlock:GetChildren()}
						for _, frame in pairs(frames) do
							if frame.Text then
								frame.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle)) --this is the objective like boss 1/1
								frame.Text:SetTextColor(1, 1, 1) --dungeon obj text
								frame.Text:SetWordWrap(true)
							end
							if frame.Icon and frame.Icon:GetAtlas() then
								if E.db.ElvUI_EltreumUI.skins.questsettings.hideCheck then
									frame.Icon:Hide()
								else
									if frame.Icon:GetAtlas() == "Objective-Nub" then
										frame.Icon:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\questnub.tga")
									elseif frame.Icon:GetAtlas() == "Tracker-Check" then
										frame.Icon:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\checkmark.tga")
									end
								end
							end
						end
					end
				end)

				if _G.ScenarioObjectiveBlock then
					local frames = {_G.ScenarioObjectiveBlock:GetChildren()}
					for _, frame in pairs(frames) do
						if frame.Text then
							frame.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize+2, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
							if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
								frame.Text:SetTextColor(mult * E.db.ElvUI_EltreumUI.skins.questsettings.customr, mult * E.db.ElvUI_EltreumUI.skins.questsettings.customg, mult * E.db.ElvUI_EltreumUI.skins.questsettings.customb)
							else
								frame.Text:SetTextColor(mult * classcolor.r, mult * classcolor.g, mult * classcolor.b)
							end
							frame.Text:SetWordWrap(true)
						end
					end
				end

				--skin the dungeon/raid/scenario bg
				hooksecurefunc(_G["SCENARIO_CONTENT_TRACKER_MODULE"], "Update", function ()
					ScenarioObjectiveBlockBackground:SetParent(_G.ScenarioStageBlock)
					ScenarioObjectiveBlockBackground:ClearAllPoints()
					if _G.EltruismDungeonLine then
						ScenarioObjectiveBlockBackground:SetPoint("CENTER", _G.EltruismDungeonLine, "CENTER", -3, -47)
					elseif _G.EltruismScenarioLine then
						ScenarioObjectiveBlockBackground:SetPoint("CENTER", _G.EltruismScenarioLine, "CENTER", -3, -47)
					elseif _G.ObjectiveTrackerBlocksFrame and _G.ObjectiveTrackerBlocksFrame.ScenarioHeader and _G.ObjectiveTrackerBlocksFrame.ScenarioHeader.EltruismStatusLine then
						ScenarioObjectiveBlockBackground:SetPoint("CENTER", _G.ObjectiveTrackerBlocksFrame.ScenarioHeader.EltruismStatusLine, "CENTER", -3, -47)
					end
					if E.db.ElvUI_EltreumUI.skins.shadow.enable then --minimize shadows
						if _G.ObjectiveTrackerBlocksFrame.ScenarioHeader.MinimizeButton and not _G.ObjectiveTrackerBlocksFrame.ScenarioHeader.MinimizeButton.shadow then
							_G.ObjectiveTrackerBlocksFrame.ScenarioHeader.MinimizeButton:CreateShadow()
							_G.ObjectiveTrackerBlocksFrame.ScenarioHeader.MinimizeButton.shadow:ClearAllPoints()
							_G.ObjectiveTrackerBlocksFrame.ScenarioHeader.MinimizeButton.shadow:SetPoint("TOPLEFT", _G.ObjectiveTrackerBlocksFrame.ScenarioHeader.MinimizeButton.tex, "TOPLEFT", -2,2)
							_G.ObjectiveTrackerBlocksFrame.ScenarioHeader.MinimizeButton.shadow:SetPoint("BOTTOMRIGHT", _G.ObjectiveTrackerBlocksFrame.ScenarioHeader.MinimizeButton.tex, "BOTTOMRIGHT", 2,-2)
							ElvUI_EltreumUI:ShadowColor(_G.ObjectiveTrackerBlocksFrame.ScenarioHeader.MinimizeButton.shadow)
						end
					end

					ScenarioObjectiveBlockBackground:SetSize(243, 80)
					ScenarioObjectiveBlockBackground:SetFrameLevel(3)
					ScenarioObjectiveBlockBackground:Show()
					if E.db.ElvUI_EltreumUI.skins.questsettings.lineshadow and not ScenarioObjectiveBlockBackground.shadow then
						ScenarioObjectiveBlockBackground:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(ScenarioObjectiveBlockBackground.shadow.shadow)
					end
					_G.ScenarioStageBlock.NormalBG:Hide()
					_G.ScenarioStageBlock.FinalBG:Hide()

					--dungeon/raid/scenario name text
					if _G.ScenarioStageBlock.Stage then
						if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
							_G.ScenarioStageBlock.Stage:SetTextColor(mult * E.db.ElvUI_EltreumUI.skins.questsettings.customr, mult * E.db.ElvUI_EltreumUI.skins.questsettings.customg, mult * E.db.ElvUI_EltreumUI.skins.questsettings.customb)
						else
							_G.ScenarioStageBlock.Stage:SetTextColor(mult * classcolor.r, mult * classcolor.g, mult * classcolor.b)
						end
						_G.ScenarioStageBlock.Stage:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize+6, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
						_G.ScenarioStageBlock.Stage:SetShadowColor(0, 0, 0, 0.8)
						_G.ScenarioStageBlock.Stage:SetShadowOffset(2, -1)
					end

					--tuskarr feast special case
					if _G.ScenarioStageBlock.WidgetContainer and _G.ScenarioStageBlock.WidgetContainer:IsVisible() then
						for i = 1, _G.ScenarioStageBlock.WidgetContainer:GetNumChildren() do
							local v = select(i, _G.ScenarioStageBlock.WidgetContainer:GetChildren())
							if v:GetName() ~= "BackModelScene" and v:GetName() ~= "FrontModelScene" then
								for number =1, v:GetNumChildren() do
									local k = select(number, v:GetChildren())
									if k and k.Frame then
										k.Frame:SetAlpha(0)
									end
								end
							end
						end
					end

					--m+ key block
					if _G.ScenarioChallengeModeBlock:IsVisible() and not self.EltruismKeySkin then
						S:HandleStatusBar(_G.ScenarioChallengeModeBlock.StatusBar)
						S:HandleFrame(_G.ScenarioChallengeModeBlock)
						--the block frame has a limit and because of that the shadow gets cropped out
						-- so move the frame and increase the limit
						_G.ScenarioBlocksFrame:SetWidth(270)
						local point, relativeTo, relativePoint, _, yOfs = _G.ScenarioChallengeModeBlock:GetPoint()
						E:Delay(0, function()
							_G.ScenarioChallengeModeBlock:ClearAllPoints()
							_G.ScenarioChallengeModeBlock:SetPoint(point, relativeTo, relativePoint, 5, yOfs-5)
						end)

						if E.db.ElvUI_EltreumUI.skins.shadow.enable then
							if not _G.ScenarioChallengeModeBlock.shadow then
								_G.ScenarioChallengeModeBlock:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.ScenarioChallengeModeBlock.shadow)
							end
						end
						self.EltruismKeySkin = true
					end
				end)

				local function blockenter(block)
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
									line.Dash:SetText("")
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
				end

				local function blockexit(block)
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
						for objectiveKey, line in pairs(block.lines) do --Blizzard_ObjectiveTracker.lua#L458
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
									line.Dash:SetText("")
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
				end

				--on mouse enter and leave
				hooksecurefunc(_G.DEFAULT_OBJECTIVE_TRACKER_MODULE, "OnBlockHeaderEnter", function(_, block)
					blockenter(block)
				end)

				hooksecurefunc(_G.DEFAULT_OBJECTIVE_TRACKER_MODULE, "OnBlockHeaderLeave", function(_, block)
					blockexit(block)
				end)

				hooksecurefunc(_G.WORLD_QUEST_TRACKER_MODULE, "OnBlockHeaderEnter", function(_, block)
					blockenter(block)
				end)

				hooksecurefunc(_G.WORLD_QUEST_TRACKER_MODULE, "OnBlockHeaderLeave", function(_, block)
					blockexit(block)
				end)

				hooksecurefunc(_G.ACHIEVEMENT_TRACKER_MODULE, "OnBlockHeaderEnter", function(_, block)
					blockenter(block)
				end)

				hooksecurefunc(_G.ACHIEVEMENT_TRACKER_MODULE, "OnBlockHeaderLeave", function(_, block)
					blockexit(block)
				end)

				hooksecurefunc(_G.BONUS_OBJECTIVE_TRACKER_MODULE, "OnBlockHeaderEnter", function(_, block)
					blockenter(block)
				end)

				hooksecurefunc(_G.BONUS_OBJECTIVE_TRACKER_MODULE, "OnBlockHeaderLeave", function(_, block)
					blockexit(block)
				end)

				hooksecurefunc(_G.PROFESSION_RECIPE_TRACKER_MODULE, "OnBlockHeaderEnter", function(_, block)
					blockenter(block)
				end)

				hooksecurefunc(_G.PROFESSION_RECIPE_TRACKER_MODULE, "OnBlockHeaderLeave", function(_, block)
					blockexit(block)
				end)

				hooksecurefunc(_G.MONTHLY_ACTIVITIES_TRACKER_MODULE, "OnBlockHeaderEnter", function(_, block)
					blockenter(block)
				end)

				hooksecurefunc(_G.MONTHLY_ACTIVITIES_TRACKER_MODULE, "OnBlockHeaderLeave", function(_, block)
					blockexit(block)
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

			--add quest header like retail/wrath
			if not _G["EltruismQuestLine"] then
				_G.QuestWatchFrame.HeaderBar = CreateFrame("StatusBar", "EltruismQuestLine", _G.QuestWatchFrame)
				_G.QuestWatchFrame.HeaderBar:SetMinMaxValues(0, 100)
				_G.QuestWatchFrame.HeaderBar:SetValue(100)
			else
				_G.QuestWatchFrame.HeaderBar = _G["EltruismQuestLine"]
			end

			--add a minimize button
			if not _G["EltruismMinimizeQuests"] then
				_G.QuestWatchFrame.Minimize = CreateFrame("BUTTON", "EltruismMinimizeQuests", _G.ElvUIParent, "MaximizeMinimizeButtonFrameTemplate")
				S:HandleMaxMinFrame(_G["EltruismMinimizeQuests"])
				_G["EltruismMinimizeQuests"]:SetTemplate("Backdrop")
				if E.db.ElvUI_EltreumUI.skins.questsettings.lineshadow and not _G.QuestWatchFrame.Minimize.shadow then
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
			_G.QuestWatchFrame.HeaderBar:SetPoint("TOP", _G.QuestWatchFrameMover, "TOP", 40, 0)
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
			if E.db.ElvUI_EltreumUI.skins.questsettings.lineshadow and not _G["EltruismQuestLine"].shadow then
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
				if (NumQuests >= (MAX_QUESTS - 5)) then
					QuestWatchFrameTitle:SetText(format("|CFFFF0000%d/%d|r - %s", NumQuests, MAX_QUESTS, QUESTS_LABEL))
				else
					QuestWatchFrameTitle:SetText(QUESTS_LABEL)
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
				for i=watchTextIndex, MAX_QUESTWATCH_LINES do
					_G["QuestWatchLine"..i]:Hide()
				end

				if _G.QuestWatchFrame.isHidden then
					_G.QuestWatchFrame:Hide()
				end

				UIParent_ManageFramePositions()
			end)
		elseif E.Wrath or E.Cata then

			--from blizzard's FrameXML/WatchFrame.lua
			local questside
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
						line.text:SetWidth(250)
					elseif isComplete then
						line.text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
						line.text:SetTextColor(0, 1, 0)
						line.text:SetWidth(250)
					else
						line.text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
						line.text:SetTextColor(0.8, 0.8, 0.8)
						line.text:SetWidth(250)

						--inspired by blinkii's skin, color
						local textwrath = line.text:GetText()
						if textwrath ~= nil then
							local left, right, questtext = strmatch(textwrath, "^(%d-)/(%d-) (.+)")
							local questtext2,left2, right2 = strmatch(textwrath, "(.+): (%d-)/(%d-)$")
							local left3, right3, questtext3 = strmatch(textwrath, "^- (%d-)/(%d-) (.+)")
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

				if E.db.ElvUI_EltreumUI.skins.questsettings.lineshadow and not _G["EltruismQuestLine"].shadow then
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

				if (NumQuests >= (MAX_QUESTS - 5)) then
					WatchFrameTitle:SetText(format("|CFFFF0000%d/%d|r - %s", NumQuests, MAX_QUESTS, QUESTS_LABEL))
				else
					WatchFrameTitle:SetText(QUESTS_LABEL)
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
							Button:SetPoint("LEFT", Anchor, "LEFT", -60, -10)
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
						if E.db.ElvUI_EltreumUI.skins.questsettings.lineshadow and not Button.shadow then
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
							Button:SetPoint("LEFT", Anchor, "LEFT", -40, -10)
						else
							Button:SetPoint("RIGHT", Anchor, "RIGHT", 120, -10)
						end
					elseif Anchor == nil then
						if questside:match("RIGHT") then
							Button:SetPoint("LEFT", _G["WatchFrameLine"..i.."Text"], "LEFT", -40, -10)
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

			--highlight
			hooksecurefunc("WatchFrameLinkButtonTemplate_Highlight", function(quest, onEnter)
				local line
				_G.WatchFrame_Update()
				for index = quest.startLine, quest.lastLine do
					line = quest.lines[index]
					if ( line ) then
						if line.text:GetTextColor() == 0 and 0.99999779462814 and 0 and 0.99999779462814 then
							line.text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
							line.text:SetWidth(250)
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
									line.text:SetWidth(250)
								else
									line.text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
									if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
										line.text:SetTextColor(E.db.ElvUI_EltreumUI.skins.questsettings.customr, E.db.ElvUI_EltreumUI.skins.questsettings.customg, E.db.ElvUI_EltreumUI.skins.questsettings.customb)
									else
										line.text:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
									end
									line.text:SetWidth(250)
								end
							else
								if ( onEnter ) then
									line.text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
									line.text:SetTextColor(1, 1, 1)
									--line.dash:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
									--line.dash:SetTextColor(1, 1, 1)
									line.text:SetWidth(250)
								else
									line.text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
									line.text:SetTextColor(0.8, 0.8, 0.8)
									--line.dash:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
									--line.dash:SetTextColor(0.8, 0.8, 0.8)
									line.text:SetWidth(250)
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
	local isScenarioBlockShowing = _G.ScenarioBlocksFrame and _G.ScenarioBlocksFrame:IsShown()
	local scenarioBlockHeight = isScenarioBlockShowing and (_G.ScenarioBlocksFrame:GetHeight() + _G.ObjectiveTrackerBlocksFrame.ScenarioHeader:GetHeight() + 10) or 0

	local newHeight = math.max(E.db.ElvUI_EltreumUI.skins.questsettings.objectiveFrameHeight, scenarioBlockHeight)
	ObjectiveTrackerFrame:SetHeight(newHeight)
end

--add objective frame anchor back in
function ElvUI_EltreumUI:ObjectiveTrackerAnchor()
	if E.db.ElvUI_EltreumUI.quests.anchor then
		if not _G["ObjectiveFrameHolder"] then
			local holder = CreateFrame("FRAME", "ObjectiveFrameHolder", E.UIParent)
			holder:SetPoint("TOPRIGHT", E.UIParent, "TOPRIGHT", -135, -300)
			holder:SetSize(130, 22)
			holder:SetClampedToScreen(true)

			ObjectiveTrackerFrame:BreakFromFrameManager()
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
			E:CreateMover(holder, "ObjectiveFrameMover", L["Objective Frame"], nil, nil, nil, "ALL,GENERAL", nil, 'ElvUI_EltreumUI,quests')

			ElvUI_EltreumUI:UpdateObjectiveTrackerHeight()
		else
			ObjectiveTrackerFrame:BreakFromFrameManager()
			_G.ObjectiveTrackerFrame:ClearAllPoints()
			_G.ObjectiveTrackerFrame:SetPoint("TOP", _G["ObjectiveFrameHolder"], "TOP")
			ElvUI_EltreumUI:UpdateObjectiveTrackerHeight()
		end
	end
end

--because the objective is removed from frame manager, when swapping to another layout that isnt it can error when trying to export it, so break it from manager again
if E.Retail then
	local editmodecheck = CreateFrame("FRAME")
	editmodecheck:RegisterEvent("EDIT_MODE_LAYOUTS_UPDATED")
	editmodecheck:SetScript("OnEvent",function()
		if not E.private.ElvUI_EltreumUI then return end
		if not E.private.ElvUI_EltreumUI.install_version then return end
		if not E.db.ElvUI_EltreumUI then return end
		if not E.db.ElvUI_EltreumUI.quests then return end
		if E.db.ElvUI_EltreumUI.quests.anchor then
			ElvUI_EltreumUI:ObjectiveTrackerAnchor()
		end
	end)
end
