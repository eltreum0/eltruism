local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local S = E:GetModule('Skins')
local _G = _G
local classcolor = E:ClassColor(E.myclass, true)
local CreateFrame = _G.CreateFrame
local IsAddOnLoaded = _G.IsAddOnLoaded
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
local ScenarioObjectiveBlockBackgroundTexture
local wowheadbutton = CreateFrame("Button", nil)
local dontexpandanymorequests = 0
if E.Retail then
	ScenarioObjectiveBlockBackground = CreateFrame("Frame", "EltruismScenarioBlockBg")
	ScenarioObjectiveBlockBackgroundTexture = ScenarioObjectiveBlockBackground:CreateTexture()
end

function ElvUI_EltreumUI:SkinQuests()
	if E.db.ElvUI_EltreumUI.skins.quests and E.private.skins.blizzard.objectiveTracker and E.private.skins.blizzard.enable then

		--create the button for wowhead
		if E.Retail then
			wowheadbutton:SetWidth(80)
			wowheadbutton:SetHeight(20)
			wowheadbutton:SetParent(_G.WorldMapFrame)
			wowheadbutton:SetPoint("TOPRIGHT", _G.WorldMapFrame, "TOPRIGHT", -80, 0)
		elseif E.TBC or E.Classic then
			local x, y = _G.QuestFramePushQuestButton:GetSize()
			wowheadbutton:SetWidth(x)
			wowheadbutton:SetHeight(y)
			wowheadbutton:SetParent(_G.QuestLogFrame)
			wowheadbutton:SetPoint("LEFT", _G.QuestFramePushQuestButton, "LEFT", -x-2, 0)
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
		--register the button for clicks
		wowheadbutton:RegisterForClicks("AnyUp")
		if not E.db.ElvUI_EltreumUI.skins.questswowhead then
			wowheadbutton:Hide()
		end

		if E.Retail then
			--get questid
			local questID
			local getquestid = CreateFrame("FRAME")
			getquestid:RegisterEvent("QUEST_DATA_LOAD_RESULT")
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

			-- and (not IsAddOnLoaded("ElvUI_WindTools"))
			if (not IsAddOnLoaded('!KalielsTracker')) and (not IsAddOnLoaded('SorhaQuestLog')) and (not IsAddOnLoaded('ClassicQuestLog')) and (not IsAddOnLoaded('Who Framed Watcher Wabbit?')) then
				--WQs banner
				local ObjectiveTrackerBonusBannerFrame = _G.ObjectiveTrackerBonusBannerFrame
				if ObjectiveTrackerBonusBannerFrame then
					--textcoords from https://www.townlong-yak.com/framexml/39229/Helix/AtlasInfo.lua
					ObjectiveTrackerBonusBannerFrame.Title:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
					ObjectiveTrackerBonusBannerFrame.Title:SetText("") --so that the text doesn't show up when it shouldnt
					ObjectiveTrackerBonusBannerFrame.Icon:SetTexture("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\bonusobjectives")
					ObjectiveTrackerBonusBannerFrame.Icon:SetTexCoord(0.482422, 0.785156, 0.00195312, 0.294922)
					ObjectiveTrackerBonusBannerFrame.Icon2:SetTexture("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\bonusobjectives")
					ObjectiveTrackerBonusBannerFrame.Icon2:SetTexCoord(0.482422, 0.785156, 0.00195312, 0.294922)
					ObjectiveTrackerBonusBannerFrame.Icon3:SetTexture("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\bonusobjectives")
					ObjectiveTrackerBonusBannerFrame.Icon3:SetTexCoord(0.482422, 0.785156, 0.00195312, 0.294922)
					ObjectiveTrackerBonusBannerFrame.BG1:SetTexture("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\bonusobjectives")
					ObjectiveTrackerBonusBannerFrame.BG1:SetTexCoord(0.00195312, 0.818359, 0.359375, 0.507812)
					ObjectiveTrackerBonusBannerFrame.BG2:SetTexture("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\bonusobjectives")
					ObjectiveTrackerBonusBannerFrame.BG2:SetTexCoord(0.00195312, 0.818359, 0.359375, 0.507812)
					ObjectiveTrackerBonusBannerFrame.BG1:SetVertexColor(classcolor.r, classcolor.g, classcolor.b) --bonusobjectives-title-bg
					ObjectiveTrackerBonusBannerFrame.BG2:SetVertexColor(classcolor.r, classcolor.g, classcolor.b) --bonusobjectives-title-bg
					ObjectiveTrackerBonusBannerFrame.Icon:SetVertexColor(classcolor.r, classcolor.g, classcolor.b) --bonusobjectives-title-icon
					ObjectiveTrackerBonusBannerFrame.Icon2:SetVertexColor(classcolor.r, classcolor.g, classcolor.b) --bonusobjectives-title-icon
					ObjectiveTrackerBonusBannerFrame.Icon3:SetVertexColor(classcolor.r, classcolor.g, classcolor.b) --bonusobjectives-title-icon
				end

				--Interface/AddOns/Blizzard_ObjectiveTracker/Blizzard_ObjectiveTracker.lua
				local questmodules = {
					QUEST_TRACKER_MODULE,
					ACHIEVEMENT_TRACKER_MODULE,
					BONUS_OBJECTIVE_TRACKER_MODULE,
					WORLD_QUEST_TRACKER_MODULE,
					UI_WIDGET_TRACKER_MODULE,
					CAMPAIGN_QUEST_TRACKER_MODULE,
				}
				local mult = 0.85
				for _, k in pairs(questmodules) do
					hooksecurefunc(k, "AddObjective", function(_, block)
						if not block then
							return
						end
						if block.HeaderText then --quest title
							block.HeaderText:SetFont(E.LSM:Fetch('font', E.db.general.font), 13, E.db.general.fontStyle)
							block.HeaderText:SetTextColor(mult * classcolor.r, mult * classcolor.g, mult * classcolor.b)
							block.HeaderText:SetWordWrap(true)
						end
						if block.currentLine then --quest text
							if block.currentLine.objectiveKey == 0 then --also quest title
								block.currentLine.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), 12, E.db.general.fontStyle)
								block.currentLine.Text:SetTextColor(mult * classcolor.r, mult * classcolor.g, mult * classcolor.b)
								block.currentLine.Text:SetWordWrap(true)
							else --step/description of the quest
								block.currentLine.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), 12, E.db.general.fontStyle)
								block.currentLine.Text:SetTextColor(mult, mult, mult)
								block.currentLine.Text:SetWordWrap(true)
							end
						end
					end)
				end

				hooksecurefunc('ObjectiveTracker_Update', function ()
					local modules = ObjectiveTrackerFrame.MODULES
					if not modules then
						return
					end
					for i = 1, #modules do
						local module = modules[i]
						if module and module.Header and module.Header.Text then --the big type of quest
							if not IsAddOnLoaded("ElvUI_SLE") then
								module.Header.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize*1.5, E.db.general.fontStyle)
							end
							module.Header.Text:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							module.Header.Text:SetShadowColor(0, 0, 0, 0.8)
							module.Header.Text:SetShadowOffset(2, -1)

							--create the lines
							if not module.Header.EltruismStatusLine then
								if IsAddOnLoaded("ElvUI_SLE") then
									if E.private["sle"]["skins"]["objectiveTracker"]["enable"] then
										return
									end
								end
								if module.Header.Text and module.Header.Text:GetText() ~= nil then
									module.Header.EltruismStatusLine = CreateFrame("StatusBar", "Eltruism"..module.Header.Text:GetText().."Line", module.Header)
								else
									module.Header.EltruismStatusLine = CreateFrame("StatusBar", "EltruismLine", module.Header)
								end
								module.Header.EltruismStatusLine:SetSize(250, 3)
								module.Header.EltruismStatusLine:SetPoint("BOTTOM", module.Header, 0, 0)
								module.Header.EltruismStatusLine:SetStatusBarTexture('Interface\\addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga')
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
									module.Header.EltruismStatusLine:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass))
								else
									module.Header.EltruismStatusLine:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass))
								end
								module.Header.EltruismStatusLine:SetFrameLevel(1)
								if not module.Header.EltruismStatusLine.shadow then
									module.Header.EltruismStatusLine:CreateShadow()
								end
							end
						end
					end
				end)

				--skin the progress bars
				local function EltreumSkinProgressBars(_, _, line)
					local progressBar = line and line.ProgressBar
					local bar = progressBar and progressBar.Bar
					if not bar or progressBar.EltruismSkin then
						return
					else
						bar:CreateShadow()
						progressBar.Bar.backdrop:SetAlpha(0.7)
						--progressBar:SetBackdropColor(0, 0, 0, 1)
						--progressBar.Bar.backdrop:SetBackdropBorderColor(0, 0, 0, 1)
						progressBar.Bar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.skins.queststatusbartexture))
						progressBar.EltruismSkin = true
					end
				end
				hooksecurefunc(QUEST_TRACKER_MODULE, "AddProgressBar", EltreumSkinProgressBars)
				hooksecurefunc(BONUS_OBJECTIVE_TRACKER_MODULE, "AddProgressBar", EltreumSkinProgressBars)
				hooksecurefunc(WORLD_QUEST_TRACKER_MODULE, "AddProgressBar", EltreumSkinProgressBars)
				hooksecurefunc(CAMPAIGN_QUEST_TRACKER_MODULE, "AddProgressBar", EltreumSkinProgressBars)
				hooksecurefunc(SCENARIO_TRACKER_MODULE, "AddProgressBar", EltreumSkinProgressBars)
				hooksecurefunc(DEFAULT_OBJECTIVE_TRACKER_MODULE, "AddProgressBar", EltreumSkinProgressBars)

				hooksecurefunc(SCENARIO_CONTENT_TRACKER_MODULE, 'UpdateCriteria', function ()
					if ScenarioObjectiveBlock then
						local frames = {ScenarioObjectiveBlock:GetChildren()}
						for _, frame in pairs(frames) do
							if frame.Text then
								frame.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), 12, E.db.general.fontStyle) --this is the objective like boss 1/1
								frame.Text:SetTextColor(1, 1, 1) --dungeon obj text
								frame.Text:SetWordWrap(true)
							end
						end
					end
				end)

				if _G.ScenarioObjectiveBlock then
					local frames = {_G.ScenarioObjectiveBlock:GetChildren()}
					for _, frame in pairs(frames) do
						if frame.Text then
							frame.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), 14, E.db.general.fontStyle)
							frame.Text:SetTextColor(mult * classcolor.r, mult * classcolor.g, mult * classcolor.b)
							frame.Text:SetWordWrap(true)
						end
					end
				end

				--skin the dungeon/raid/scenario bg
				hooksecurefunc(_G["SCENARIO_CONTENT_TRACKER_MODULE"], "Update", function ()
					ScenarioObjectiveBlockBackground:SetParent(_G.ScenarioStageBlock)
					ScenarioObjectiveBlockBackground:ClearAllPoints()
					--ScenarioObjectiveBlockBackground:SetAllPoints(_G.ScenarioStageBlock.NormalBG)
					ScenarioObjectiveBlockBackground:SetPoint("CENTER", _G.EltruismScenarioLine, "CENTER", 5, -47)
					ScenarioObjectiveBlockBackground:SetSize(250, 80)
					ScenarioObjectiveBlockBackground:CreateBackdrop('Transparent')
					ScenarioObjectiveBlockBackgroundTexture:SetTexture("Interface\\Addons\\ElvUI\\Code\\Media\\Textures\\White8x8.tga")
					ScenarioObjectiveBlockBackgroundTexture:SetColorTexture(0, 0, 0, 0.01)
					ScenarioObjectiveBlockBackgroundTexture:SetAlpha(0.01)
					ScenarioObjectiveBlockBackgroundTexture:SetAllPoints(_G.ScenarioStageBlock.NormalBG)
					ScenarioObjectiveBlockBackground:Show()
					ScenarioObjectiveBlockBackgroundTexture:Show()
					if not ScenarioObjectiveBlockBackground.shadow then
						ScenarioObjectiveBlockBackground:CreateShadow()
					end
					_G.ScenarioStageBlock.NormalBG:Hide()
					_G.ScenarioStageBlock.FinalBG:Hide()
					--dungeon/raid/scenario name text
					if _G.ScenarioStageBlock.Stage then
						_G.ScenarioStageBlock.Stage:SetTextColor(mult * classcolor.r, mult * classcolor.g, mult * classcolor.b)
						_G.ScenarioStageBlock.Stage:SetFont(E.LSM:Fetch('font', E.db.general.font), 18, E.db.general.fontStyle)
						_G.ScenarioStageBlock.Stage:SetShadowColor(0, 0, 0, 0.8)
						_G.ScenarioStageBlock.Stage:SetShadowOffset(2, -1)
					end
				end)

				--on mouse enter and leave
				hooksecurefunc(DEFAULT_OBJECTIVE_TRACKER_MODULE, "OnBlockHeaderEnter", function(_, block)
					if ( block.HeaderText ) then
						block.HeaderText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
						block.HeaderText.colorStyle = {r = classcolor.r, g = classcolor.g, b = classcolor.b}
					end
					if block.currentLine then --this is the text
						for _, line in pairs(block.lines) do
							line.Text:SetTextColor(1, 1, 1)
							line.Text.colorStyle = {r = mult * 1, g = mult * 1, b = mult * 1}
							if ( line.Dash ) then
								line.Dash:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
						end
					end
				end)

				hooksecurefunc(DEFAULT_OBJECTIVE_TRACKER_MODULE, "OnBlockHeaderLeave", function(_, block)
					if ( block.HeaderText ) then
						block.HeaderText:SetTextColor(mult * classcolor.r, mult * classcolor.g, mult * classcolor.b)
						block.HeaderText.colorStyle = { r = mult * classcolor.r, g = mult * classcolor.g, b = mult * classcolor.b }
					end
					if block.currentLine then
						for _, line in pairs(block.lines) do
							line.Text:SetTextColor(mult, mult, mult)
							line.Text.colorStyle = {r = mult, g = mult, b = mult}
							if ( line.Dash ) then
								line.Dash:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
						end
					end
				end)

				hooksecurefunc(WORLD_QUEST_TRACKER_MODULE, "OnBlockHeaderEnter", function(_, block)
					if block.currentLine then --this is the text
						for objectiveKey, line in pairs(block.lines) do --Blizzard_ObjectiveTracker.lua#L458
							if objectiveKey == 0 then --its the title
								line.Text:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							else -- its the subtext
								line.Text:SetTextColor(1, 1, 1)
							end
							if ( line.Dash ) then
								line.Dash:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
						end
					end
				end)

				hooksecurefunc(WORLD_QUEST_TRACKER_MODULE, "OnBlockHeaderLeave", function(_, block)
					if block.currentLine then
						for objectiveKey, line in pairs(block.lines) do --Blizzard_ObjectiveTracker.lua#L458
							if objectiveKey == 0 then --its the title
								line.Text:SetTextColor(mult * classcolor.r, mult * classcolor.g, mult * classcolor.b)
							else -- its the subtext
								line.Text:SetTextColor(mult, mult, mult)
							end
							if ( line.Dash ) then
								line.Dash:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
						end
					end
				end)
			end
		elseif E.Classic or E.TBC then
			local questID
			--hook the function that sets the quest detail to get the questID from the quest title
			hooksecurefunc("QuestLog_SetSelection", function(questTitle) --questlogframe.lua 311
				questID = select(8, GetQuestLogTitle(questTitle))
			end)
			--set the link to show when the button is clicked
			wowheadbutton:SetScript('OnClick', function()
				E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, "https://"..wowheadregion.."/quest="..questID)
			end)

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

			if not IsAddOnLoaded('Questie') then

				--add quest header like retail/wrath
				if not _G["EltruismQuestLine"] then
					_G.QuestWatchFrame.HeaderBar = CreateFrame("StatusBar", "EltruismQuestLine", _G.QuestWatchFrame)
				else
					_G.QuestWatchFrame.HeaderBar = _G["EltruismQuestLine"]
				end
				_G.QuestWatchFrame.HeaderBar:SetSize(200, 3)
				_G.QuestWatchFrame.HeaderBar:SetPoint("TOP", _G.QuestWatchFrameMover, "TOP", 40, 0)
				_G.QuestWatchFrame.HeaderBar:SetStatusBarTexture(E.Media.Textures.White8x8)
				--_G.QuestWatchFrame.HeaderBar:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b)
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
					_G.QuestWatchFrame.HeaderBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass))
				else
					_G.QuestWatchFrame.HeaderBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass))
				end
				if not _G["EltruismQuestLine"].shadow then
					_G["EltruismQuestLine"]:CreateShadow()
				end
				local InvisFrameHeaderBar = CreateFrame("Frame", nil, _G.QuestWatchFrame.HeaderBar)
				InvisFrameHeaderBar:SetFrameLevel(_G.QuestWatchFrame.HeaderBar:GetFrameLevel() + 10)
				InvisFrameHeaderBar:SetInside()
				local QuestWatchFrameTitle = _G.QuestWatchFrame:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
				QuestWatchFrameTitle:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize+3, E.db.general.fontStyle)
				QuestWatchFrameTitle:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
				QuestWatchFrameTitle:SetParent(InvisFrameHeaderBar)
				QuestWatchFrameTitle:ClearAllPoints()
				QuestWatchFrameTitle:SetPoint("LEFT", InvisFrameHeaderBar, 6, 8)

				--from blizzard's FrameXML/_G.QuestLogFrame.lua
				--skin the classic objective frame
				hooksecurefunc("QuestWatch_Update",function()

					local NumQuests = select(2, GetNumQuestLogEntries())
					if (NumQuests >= (MAX_QUESTS - 5)) then
						QuestWatchFrameTitle:SetText(format("|CFFFF0000%d/%d|r - %s", NumQuests, MAX_QUESTS, "Quests"))
					else
						QuestWatchFrameTitle:SetText(format("%d/%d - %s", NumQuests, MAX_QUESTS, "Quests"))
					end
					if (GetNumQuestWatches() == 0) then
						_G.QuestWatchFrame.HeaderBar:SetAlpha(0)
					else
						_G.QuestWatchFrame.HeaderBar:SetAlpha(1)
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
								watchText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize, E.db.general.fontStyle)
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
									watchText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize, E.db.general.fontStyle)
									--watchText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
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
									watchText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
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

					UIParent_ManageFramePositions()
				end)
			end
		elseif E.Wrath then
			local questID
			--hook the function that sets the quest detail to get the questID from the quest title
			hooksecurefunc("QuestLog_SetSelection", function(questTitle) --_G.QuestLogFrame.lua 311
				questID = select(8, GetQuestLogTitle(questTitle))
			end)
			--set the link to show when the button is clicked
			wowheadbutton:SetScript('OnClick', function()
				E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, "https://"..wowheadregion.."/quest="..questID)
			end)

			if not IsAddOnLoaded('Questie') then --questie overwrites the default tracker sadly instead of hooking into it
				--from blizzard's FrameXML/WatchFrame.lua

				--skin the classic objective frame, based on aftermathh's
				local function colorquests(line, _, _, isHeader, text, _, _, isComplete) --(line, anchor, verticalOffset, isHeader, text, dash, hasItem, isComplete)
					if line and line.text then
						if ( isHeader ) then
							--line.text:SetTextColor(0.75, 0.61, 0)
							line.text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize+2, E.db.general.fontStyle)
							line.text:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							line.text:SetWidth(250)
						elseif isComplete then
							line.text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize, E.db.general.fontStyle)
							line.text:SetTextColor(0, 1, 0)
							line.text:SetWidth(250)
						else
							line.text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize, E.db.general.fontStyle)
							line.text:SetTextColor(0.8, 0.8, 0.8)
							line.text:SetWidth(250)
						end
						if line.dash then
							line.dash:Hide()
						end
					end

					local WatchFrame = _G.WatchFrame
					local WatchFrameLines = _G.WatchFrameLines

					if not _G["EltruismQuestLine"] then
						WatchFrame.HeaderBar = CreateFrame("StatusBar", "EltruismQuestLine", WatchFrameLines)
					else
						WatchFrame.HeaderBar = _G["EltruismQuestLine"]
					end
					WatchFrame.HeaderBar:SetSize(200, 3)
					WatchFrame.HeaderBar:SetPoint("TOP", WatchFrame, "TOP", 0, -23)
					WatchFrame.HeaderBar:SetStatusBarTexture(E.Media.Textures.White8x8)
					--WatchFrame.HeaderBar:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b)
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
						WatchFrame.HeaderBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass))
					else
						WatchFrame.HeaderBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass))
					end
					if not _G["EltruismQuestLine"].shadow then
						_G["EltruismQuestLine"]:CreateShadow()
					end

					local InvisFrameHeaderBar = CreateFrame("Frame", nil, WatchFrame.HeaderBar)
					InvisFrameHeaderBar:SetFrameLevel(WatchFrame.HeaderBar:GetFrameLevel() + 10)
					InvisFrameHeaderBar:SetInside()

					local WatchFrameTitle = _G.WatchFrameTitle
					WatchFrameTitle:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize+3, E.db.general.fontStyle)
					WatchFrameTitle:SetTextColor(classcolor.r, classcolor.g, classcolor.b)

					WatchFrameTitle:SetParent(InvisFrameHeaderBar)
					WatchFrameTitle:ClearAllPoints()
					WatchFrameTitle:SetPoint("LEFT", InvisFrameHeaderBar, 6, 8)

					local NumQuests = select(2, GetNumQuestLogEntries())

					if (NumQuests >= (MAX_QUESTS - 5)) then
						WatchFrameTitle:SetText(format("|CFFFF0000%d/%d|r - %s", NumQuests, MAX_QUESTS, "Quests"))
					else
						WatchFrameTitle:SetText(format("%d/%d - %s", NumQuests, MAX_QUESTS, "Quests"))
					end

					if (GetNumQuestWatches() == 0) then
						WatchFrame.HeaderBar:SetAlpha(0)
					else
						WatchFrame.HeaderBar:SetAlpha(1)
					end

					if InCombatLockdown() then
						return
					else
						for i = 1, _G.WATCHFRAME_NUM_ITEMS do
							local Button = _G["WatchFrameItem"..i]
							if not (Button) then
								return
							end
							local _, Anchor = Button:GetPoint()
							Button:ClearAllPoints()
							if Anchor ~= nil then
								Button:SetPoint("LEFT", Anchor, "LEFT", -40, -10)
							elseif Anchor == nil then
								Button:SetPoint("LEFT", _G["WatchFrameLine"..i.."Text"], "LEFT", -40, -10)
							end
							Button:SetSize(28, 28)

							if not Button.shadow then
								Button:CreateShadow()
							end

							if not (Button.QuestTexture) then
								if _G["EltruismQuestTexture"] then
									Button.QuestTexture = _G["EltruismQuestTexture"]
								else
									Button.QuestTexture = Button:CreateTexture("EltruismQuestTexture")
								end
								Button.QuestTexture:SetSize(24, 24)
								Button.QuestTexture:SetPoint("LEFT", Button, "LEFT", -12, 0)
								Button.QuestTexture:SetTexture(E.Media.Textures.BagQuestIcon)
							end

							S:HandleButton(Button)
							local texture = _G["WatchFrameItem"..i.."IconTexture"]
							texture:SetTexCoord(0.08,0.92,0.08,0.92)
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
						if Anchor ~= nil then
							Button:SetPoint("LEFT", Anchor, "LEFT", -40, -10)
						elseif Anchor == nil then
							Button:SetPoint("LEFT", _G["WatchFrameLine"..i.."Text"], "LEFT", -40, -10)
						end
					end
				end)

				--[[hooksecurefunc("WatchFrame_QuestTimerUpdateFunction",function(...) --too much cpu/memory

						local numTimers = select("#", ...);

						if ( numTimers ~= WATCHFRAME_NUM_TIMERS ) then
							-- We need to update the entire watch frame, the number of displayed timers has changed.
							return true;
						end

						local line1 = WATCHFRAME_TIMERLINES[1];
						line1.text:SetText(tostring(line1.text:GetText()))
						line1.text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize+2, E.db.general.fontStyle)
						line1.text:SetTextColor(classcolor.r, classcolor.g, classcolor.b)

						for i = 1, numTimers do
							local line2 = WATCHFRAME_TIMERLINES[i+1]; -- The first timer line is always the "Quest Timers" line, so skip it.
							line2.text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize+2, E.db.general.fontStyle)
							line2.text:SetTextColor(1, 1, 1)
							local seconds = select(i, ...);
							line2.text:SetText(" - " .. SecondsToTime(seconds));
						end
				end)]]
				--hooksecurefunc("WatchFrameItem_OnEvent",colorquests) --screws up position

				--highlight
				hooksecurefunc("WatchFrameLinkButtonTemplate_Highlight", function(self, onEnter)
					local line
					_G.WatchFrame_Update()
					for index = self.startLine, self.lastLine do
						line = self.lines[index]
						if ( line ) then
							if line.text:GetTextColor() == 0 and 0.99999779462814 and 0 and 0.99999779462814 then
								line.text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize, E.db.general.fontStyle)
								line.text:SetWidth(250)
							else
								if ( index == self.startLine ) then
									-- header
									if ( onEnter ) then
										line.text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize+2, E.db.general.fontStyle)
										line.text:SetTextColor(classcolor.r+0.2, classcolor.g+0.2, classcolor.b+0.2)
										line.text:SetWidth(250)
									else
										line.text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize+2, E.db.general.fontStyle)
										line.text:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
										line.text:SetWidth(250)
									end
								else
									if ( onEnter ) then
										line.text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize, E.db.general.fontStyle)
										line.text:SetTextColor(1, 1, 1)
										--line.dash:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize, E.db.general.fontStyle)
										--line.dash:SetTextColor(1, 1, 1)
										line.text:SetWidth(250)
									else
										line.text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize, E.db.general.fontStyle)
										line.text:SetTextColor(0.8, 0.8, 0.8)
										--line.dash:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize, E.db.general.fontStyle)
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

				--nope, colors achievements wrong
				--[[local function loopwatch()
					_G["WatchFrameTitle"]:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize+2, E.db.general.fontStyle)
					_G["WatchFrameTitle"]:SetTextColor(classcolor.r, classcolor.g, classcolor.b)

					for i = 1, 80 do
						repeat
							if i % 2 == 0 then
								if _G["WatchFrameLine"..i.."Text"] then
									_G["WatchFrameLine"..i.."Text"]:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize, E.db.general.fontStyle)
									_G["WatchFrameLine"..i.."Text"]:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
								else
									do break end
								end
							else
								if _G["WatchFrameLine"..i.."Text"] then
									_G["WatchFrameLine"..i.."Text"]:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize, E.db.general.fontStyle)
									_G["WatchFrameLine"..i.."Text"]:SetTextColor(1, 1, 1)
								else
									do break end
								end
							end
						until true
					end
				end]]

			end
		end
	end
end
