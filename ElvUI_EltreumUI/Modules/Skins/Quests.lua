local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local IsAddOnLoaded = _G.IsAddOnLoaded
local CreateFrame = _G.CreateFrame
local unpack = _G.unpack
local classcolor = E:ClassColor(E.myclass, true)

function ElvUI_EltreumUI:SkinQuests()
	--print("skin quests spam")
	local fontsize = E.db.general.fontSize
	if E.db.ElvUI_EltreumUI.skins.quests then
		if ElvUI_EltreumUI.Retail then
			if (not IsAddOnLoaded("ElvUI_SLE")) and (not IsAddOnLoaded("ElvUI_WindTools")) then
				local ObjectiveTrackerBlocksFrame = _G.ObjectiveTrackerBlocksFrame
				if ObjectiveTrackerBlocksFrame then
					ObjectiveTrackerBlocksFrame.ScenarioHeader.StatusLine = CreateFrame("StatusBar", "EltruismScenarioLine", ObjectiveTrackerBlocksFrame.ScenarioHeader)
					ObjectiveTrackerBlocksFrame.ScenarioHeader.StatusLine:SetSize(250, 2)
					ObjectiveTrackerBlocksFrame.ScenarioHeader.StatusLine:SetPoint("BOTTOM", ObjectiveTrackerBlocksFrame.ScenarioHeader, 0, -1)
					ObjectiveTrackerBlocksFrame.ScenarioHeader.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
					ObjectiveTrackerBlocksFrame.ScenarioHeader.StatusLine:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)

					ObjectiveTrackerBlocksFrame.CampaignQuestHeader.StatusLine = CreateFrame("StatusBar", "EltruismCampaignLine", ObjectiveTrackerBlocksFrame.CampaignQuestHeader)
					ObjectiveTrackerBlocksFrame.CampaignQuestHeader.StatusLine:SetSize(250, 2)
					ObjectiveTrackerBlocksFrame.CampaignQuestHeader.StatusLine:SetPoint("BOTTOM", ObjectiveTrackerBlocksFrame.CampaignQuestHeader, 0, -1)
					ObjectiveTrackerBlocksFrame.CampaignQuestHeader.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
					ObjectiveTrackerBlocksFrame.CampaignQuestHeader.StatusLine:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)

					ObjectiveTrackerBlocksFrame.QuestHeader.StatusLine = CreateFrame("StatusBar", "EltruismQuestLine", ObjectiveTrackerBlocksFrame.QuestHeader)
					ObjectiveTrackerBlocksFrame.QuestHeader.StatusLine:SetSize(250, 2)
					ObjectiveTrackerBlocksFrame.QuestHeader.StatusLine:SetPoint("BOTTOM", ObjectiveTrackerBlocksFrame.QuestHeader, 0, -1)
					ObjectiveTrackerBlocksFrame.QuestHeader.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
					ObjectiveTrackerBlocksFrame.QuestHeader.StatusLine:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)

					ObjectiveTrackerBlocksFrame.AchievementHeader.StatusLine = CreateFrame("StatusBar", "EltruismAchievementLine", ObjectiveTrackerBlocksFrame.AchievementHeader)
					ObjectiveTrackerBlocksFrame.AchievementHeader.StatusLine:SetSize(250, 2)
					ObjectiveTrackerBlocksFrame.AchievementHeader.StatusLine:SetPoint("BOTTOM", ObjectiveTrackerBlocksFrame.AchievementHeader, 0, -1)
					ObjectiveTrackerBlocksFrame.AchievementHeader.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
					ObjectiveTrackerBlocksFrame.AchievementHeader.StatusLine:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)
				end
				_G.ObjectiveTrackerFrame.HeaderMenu.Title:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize, "OUTLINE")
				_G.ObjectiveTrackerFrame.HeaderMenu.Title:SetTextColor(classcolor.r, classcolor.g, classcolor.b)

				_G.ObjectiveTrackerBlocksFrame.CampaignQuestHeader.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize*2, "OUTLINE")
				_G.ObjectiveTrackerBlocksFrame.CampaignQuestHeader.Text:SetTextColor(classcolor.r, classcolor.g, classcolor.b)

				_G.ObjectiveTrackerBlocksFrame.QuestHeader.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize*2, "OUTLINE")
				_G.ObjectiveTrackerBlocksFrame.QuestHeader.Text:SetTextColor(classcolor.r, classcolor.g, classcolor.b)

				_G.ObjectiveTrackerBlocksFrame.AchievementHeader.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize*2, "OUTLINE")
				_G.ObjectiveTrackerBlocksFrame.AchievementHeader.Text:SetTextColor(classcolor.r, classcolor.g, classcolor.b)

				_G.ObjectiveTrackerBlocksFrame.ScenarioHeader.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize*2, "OUTLINE")
				_G.ObjectiveTrackerBlocksFrame.ScenarioHeader.Text:SetTextColor(classcolor.r, classcolor.g, classcolor.b)

				_G.WORLD_QUEST_TRACKER_MODULE.Header.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize, "OUTLINE")
				_G.WORLD_QUEST_TRACKER_MODULE.Header.Text:SetTextColor(classcolor.r, classcolor.g, classcolor.b)

				_G.BONUS_OBJECTIVE_TRACKER_MODULE.Header.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize, "OUTLINE")
				_G.BONUS_OBJECTIVE_TRACKER_MODULE.Header.Text:SetTextColor(classcolor.r, classcolor.g, classcolor.b)

				_G.ObjectiveFont:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize, "OUTLINE")
				_G.ObjectiveFont:SetTextColor(classcolor.r, classcolor.g, classcolor.b)

				_G.QuestFont:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize)
				_G.QuestFont:SetTextColor(classcolor.r, classcolor.g, classcolor.b)

				_G.QuestFont_Large:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize)
				_G.QuestFont_Super_Huge:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize, "OUTLINE")
				_G.QuestFont_Enormous:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize, "OUTLINE")

				--Interface/AddOns/Blizzard_ObjectiveTracker/Blizzard_ObjectiveTracker.lua
				local questmodules = {
					_G.QUEST_TRACKER_MODULE,
					_G.ACHIEVEMENT_TRACKER_MODULE,
					_G.BONUS_OBJECTIVE_TRACKER_MODULE,
					_G.WORLD_QUEST_TRACKER_MODULE,
					_G.UI_WIDGET_TRACKER_MODULE,
					_G.CAMPAIGN_QUEST_TRACKER_MODULE,
				}

				local mult = 0.85
				for _, k in pairs(questmodules) do
					hooksecurefunc(k, "AddObjective", function(_, block)
						if block.HeaderText then --quest title
							block.HeaderText:SetFont(E.LSM:Fetch('font', E.db.general.font), 14, "OUTLINE")
							block.HeaderText:SetTextColor(mult * classcolor.r, mult * classcolor.g, mult * classcolor.b)
							block.HeaderText:SetWordWrap(true)
						end
						if block.currentLine then
							if block.currentLine.objectiveKey == 0 then --also quest title
								block.currentLine.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), 14, "OUTLINE")
								block.currentLine.Text:SetTextColor(mult * classcolor.r, mult * classcolor.g, mult * classcolor.b)
								block.currentLine.Text:SetWordWrap(true)
							else  --step/description of the quest
								block.currentLine.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), 12, "OUTLINE")
								block.currentLine.Text:SetTextColor(mult, mult, mult)
								block.currentLine.Text:SetWordWrap(true)
							end
						end
					end)
				end

				hooksecurefunc(_G.DEFAULT_OBJECTIVE_TRACKER_MODULE, "OnBlockHeaderEnter", function(_, block)
					block.isHighlighted = true
					if ( block.HeaderText ) then
						local customheaderColorStyle = {r = classcolor.r, g = classcolor.g, b = classcolor.b}
						block.HeaderText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
						block.HeaderText.colorStyle = customheaderColorStyle
						--print("entered default obj tracker module")
					end
					if block.currentLine then --this is the text
						for objectiveKey, line in pairs(block.lines) do
							line.Text:SetTextColor(1, 1, 1);
							line.Text.colorStyle = {r = mult * 1, g = mult * 1, b = mult * 1}
							if ( line.Dash ) then
								line.Dash:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
						end
					end
				end)

				hooksecurefunc(_G.DEFAULT_OBJECTIVE_TRACKER_MODULE, "OnBlockHeaderLeave", function(_, block)
					block.isHighlighted = nil
					if ( block.HeaderText ) then
						local customheaderColorStyle = { r = mult * classcolor.r, g = mult * classcolor.g, b = mult * classcolor.b }
						block.HeaderText:SetTextColor(mult * classcolor.r, mult * classcolor.g, mult * classcolor.b)
						block.HeaderText.colorStyle = customheaderColorStyle
					end
					if block.currentLine then
						for objectiveKey, line in pairs(block.lines) do
							line.Text:SetTextColor(mult, mult, mult);
							line.Text.colorStyle = {r = mult, g = mult, b = mult}
							if ( line.Dash ) then
								line.Dash:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
						end
					end
				end)


				local titletable = {
					_G.ObjectiveTrackerBlocksFrame.CampaignQuestHeader.Text,
					_G.ObjectiveTrackerBlocksFrame.QuestHeader.Text,
					_G.ObjectiveTrackerBlocksFrame.AchievementHeader.Text,
					_G.ObjectiveTrackerBlocksFrame.ScenarioHeader.Text,
				}
				local mainttilestable = {
					_G.ObjectiveTrackerFrame.HeaderMenu.Title,
					_G.WORLD_QUEST_TRACKER_MODULE.Header.Text,
					_G.BONUS_OBJECTIVE_TRACKER_MODULE.Header.Text,
				}
				hooksecurefunc("ObjectiveTracker_Update", function()
					for _, k in pairs(titletable) do
						k:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize*1.5, "OUTLINE")
						k:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
						k:SetShadowColor(0, 0, 0, 0.8)
						k:SetShadowOffset(2, -1)
					end
					for _, k in pairs(mainttilestable) do
						k:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize, "OUTLINE")
						k:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
						k:SetShadowColor(0, 0, 0, 0.8)
						k:SetShadowOffset(2, -1)
					end
				end)
			end
		end
		if ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
			--from blizzard's QuestLogFrame.lua
			hooksecurefunc("QuestWatch_Update",function()
				local questIndex
				local watchTextIndex = 1
				local numObjectives
				local watchText
				local questWatchMaxWidth = 0
				local tempWidth
				local text, _, finished
				--local questTitle --currently unused, confirm if needed
				local objectivesCompleted
				for i=1, GetNumQuestWatches() do
					questIndex = GetQuestIndexForWatch(i)
					if (questIndex) then
						numObjectives = GetNumQuestLeaderBoards(questIndex)
						--If there are objectives set the title
						if ( numObjectives > 0 ) then
							-- Set title
							watchText = _G["QuestWatchLine"..watchTextIndex]
							watchText:SetText(GetQuestLogTitle(questIndex))
							watchText:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize, "OUTLINE")
							watchText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							tempWidth = watchText:GetWidth()
							if ( watchTextIndex > 1 ) then
								watchText:SetPoint("TOPLEFT", "QuestWatchLine"..(watchTextIndex - 1), "BOTTOMLEFT", 0, -10)
							end
							watchText:Show()
							if ( tempWidth > questWatchMaxWidth ) then
								questWatchMaxWidth = tempWidth
							end
							watchTextIndex = watchTextIndex + 1
							objectivesCompleted = 0
							for j=1, numObjectives do
								text, _, finished = GetQuestLogLeaderBoard(j, questIndex)
								watchText = _G["QuestWatchLine"..watchTextIndex]
								-- Set Objective text
								watchText:SetText("  "..text)
								watchText:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize, "OUTLINE")
								-- Color the objectives
								if ( finished ) then
									watchText:SetTextColor(0, 1, 0)
									objectivesCompleted = objectivesCompleted + 1
								else
									watchText:SetTextColor(1, 1, 1)
								end
								tempWidth = watchText:GetWidth()
								if ( tempWidth > questWatchMaxWidth ) then
									questWatchMaxWidth = tempWidth
								end
								watchText:SetPoint("TOPLEFT", "QuestWatchLine"..(watchTextIndex - 1), "BOTTOMLEFT", 0, -5)
								watchText:Show()
								watchTextIndex = watchTextIndex + 1
							end
						end
					end
				end
			end)
		end
	end
end

function ElvUI_EltreumUI:SkinMailZone()
	local fontsize = E.db.general.fontSize
	if E.db.ElvUI_EltreumUI.skins.zones then
		if not IsAddOnLoaded("ElvUI_SLE") then
			hooksecurefunc("SetZoneText", function()
				_G.ZoneTextString:SetFont(E.LSM:Fetch('font', E.db.general.font), 42, "OUTLINE")
				_G.SubZoneTextString:SetFont(E.LSM:Fetch('font', E.db.general.font), 28, "OUTLINE")
				_G.PVPInfoTextString:SetFont(E.LSM:Fetch('font', E.db.general.font), 20, "OUTLINE")
				_G.PVPArenaTextString:SetFont(E.LSM:Fetch('font', E.db.general.font), 20, "OUTLINE")
			end)
			_G.OpenMailBodyText:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize, "OUTLINE")
			_G.SendMailBodyEditBox:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize, "OUTLINE")
		end
	end
end
