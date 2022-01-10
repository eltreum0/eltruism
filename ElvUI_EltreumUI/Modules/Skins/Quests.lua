local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local IsAddOnLoaded = _G.IsAddOnLoaded
local CreateFrame = _G.CreateFrame
local unpack = _G.unpack
local r, g, b = unpack(E.media.rgbvaluecolor)

function ElvUI_EltreumUI:SkinQuests()
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
					ObjectiveTrackerBlocksFrame.ScenarioHeader.StatusLine:SetStatusBarColor(r, g, b, 1)

					ObjectiveTrackerBlocksFrame.CampaignQuestHeader.StatusLine = CreateFrame("StatusBar", "EltruismCampaignLine", ObjectiveTrackerBlocksFrame.CampaignQuestHeader)
					ObjectiveTrackerBlocksFrame.CampaignQuestHeader.StatusLine:SetSize(250, 2)
					ObjectiveTrackerBlocksFrame.CampaignQuestHeader.StatusLine:SetPoint("BOTTOM", ObjectiveTrackerBlocksFrame.CampaignQuestHeader, 0, -1)
					ObjectiveTrackerBlocksFrame.CampaignQuestHeader.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
					ObjectiveTrackerBlocksFrame.CampaignQuestHeader.StatusLine:SetStatusBarColor(r, g, b, 1)

					ObjectiveTrackerBlocksFrame.QuestHeader.StatusLine = CreateFrame("StatusBar", "EltruismQuestLine", ObjectiveTrackerBlocksFrame.QuestHeader)
					ObjectiveTrackerBlocksFrame.QuestHeader.StatusLine:SetSize(250, 2)
					ObjectiveTrackerBlocksFrame.QuestHeader.StatusLine:SetPoint("BOTTOM", ObjectiveTrackerBlocksFrame.QuestHeader, 0, -1)
					ObjectiveTrackerBlocksFrame.QuestHeader.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
					ObjectiveTrackerBlocksFrame.QuestHeader.StatusLine:SetStatusBarColor(r, g, b, 1)

					ObjectiveTrackerBlocksFrame.AchievementHeader.StatusLine = CreateFrame("StatusBar", "EltruismAchievementLine", ObjectiveTrackerBlocksFrame.AchievementHeader)
					ObjectiveTrackerBlocksFrame.AchievementHeader.StatusLine:SetSize(250, 2)
					ObjectiveTrackerBlocksFrame.AchievementHeader.StatusLine:SetPoint("BOTTOM", ObjectiveTrackerBlocksFrame.AchievementHeader, 0, -1)
					ObjectiveTrackerBlocksFrame.AchievementHeader.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
					ObjectiveTrackerBlocksFrame.AchievementHeader.StatusLine:SetStatusBarColor(r, g, b, 1)
				end
					_G.ObjectiveTrackerFrame.HeaderMenu.Title:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize, "OUTLINE")
					_G.ObjectiveTrackerFrame.HeaderMenu.Title:SetTextColor(r, g, b)

					_G.ObjectiveTrackerBlocksFrame.CampaignQuestHeader.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize*2, "OUTLINE")
					_G.ObjectiveTrackerBlocksFrame.CampaignQuestHeader.Text:SetTextColor(r, g, b)

					_G.ObjectiveTrackerBlocksFrame.QuestHeader.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize*2, "OUTLINE")
					_G.ObjectiveTrackerBlocksFrame.QuestHeader.Text:SetTextColor(r, g, b)

					_G.ObjectiveTrackerBlocksFrame.AchievementHeader.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize*2, "OUTLINE")
					_G.ObjectiveTrackerBlocksFrame.AchievementHeader.Text:SetTextColor(r, g, b)

					_G.ObjectiveTrackerBlocksFrame.ScenarioHeader.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize*2, "OUTLINE")
					_G.ObjectiveTrackerBlocksFrame.ScenarioHeader.Text:SetTextColor(r, g, b)

					_G.WORLD_QUEST_TRACKER_MODULE.Header.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize, "OUTLINE")
					_G.WORLD_QUEST_TRACKER_MODULE.Header.Text:SetTextColor(r, g, b)

					_G.BONUS_OBJECTIVE_TRACKER_MODULE.Header.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize, "OUTLINE")
					_G.BONUS_OBJECTIVE_TRACKER_MODULE.Header.Text:SetTextColor(r, g, b)

					_G.OBJECTIVE_TRACKER_COLOR["Header"].r = r
					_G.OBJECTIVE_TRACKER_COLOR["Header"].g = g
					_G.OBJECTIVE_TRACKER_COLOR["Header"].b = b

					_G.ObjectiveFont:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize, "OUTLINE")
					_G.ObjectiveFont:SetTextColor(r, g, b)

					_G.QuestFont:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize)
					_G.QuestFont:SetTextColor(r, g, b)

					_G.QuestFont_Large:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize)
					_G.QuestFont_Super_Huge:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize, "OUTLINE")
					_G.QuestFont_Enormous:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize, "OUTLINE")
				hooksecurefunc("ObjectiveTracker_Update", function()
					_G.ObjectiveTrackerFrame.HeaderMenu.Title:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize, "OUTLINE")
					_G.ObjectiveTrackerFrame.HeaderMenu.Title:SetTextColor(r, g, b)
					_G.ObjectiveTrackerFrame.HeaderMenu.Title:SetShadowColor(0, 0, 0, 0.8)
					_G.ObjectiveTrackerFrame.HeaderMenu.Title:SetShadowOffset(2, -1)

					_G.ObjectiveTrackerBlocksFrame.CampaignQuestHeader.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize*1.5, "OUTLINE")
					_G.ObjectiveTrackerBlocksFrame.CampaignQuestHeader.Text:SetTextColor(r, g, b)
					_G.ObjectiveTrackerBlocksFrame.CampaignQuestHeader.Text:SetShadowColor(0, 0, 0, 0.8)
					_G.ObjectiveTrackerBlocksFrame.CampaignQuestHeader.Text:SetShadowOffset(2, -1)

					_G.ObjectiveTrackerBlocksFrame.QuestHeader.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize*1.5, "OUTLINE")
					_G.ObjectiveTrackerBlocksFrame.QuestHeader.Text:SetTextColor(r, g, b)
					_G.ObjectiveTrackerBlocksFrame.QuestHeader.Text:SetShadowColor(0, 0, 0, 0.8)
					_G.ObjectiveTrackerBlocksFrame.QuestHeader.Text:SetShadowOffset(2, -1)

					_G.ObjectiveTrackerBlocksFrame.AchievementHeader.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize*1.5, "OUTLINE")
					_G.ObjectiveTrackerBlocksFrame.AchievementHeader.Text:SetTextColor(r, g, b)
					_G.ObjectiveTrackerBlocksFrame.AchievementHeader.Text:SetShadowColor(0, 0, 0, 0.8)
					_G.ObjectiveTrackerBlocksFrame.AchievementHeader.Text:SetShadowOffset(2, -1)

					_G.ObjectiveTrackerBlocksFrame.ScenarioHeader.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize*1.5, "OUTLINE")
					_G.ObjectiveTrackerBlocksFrame.ScenarioHeader.Text:SetTextColor(r, g, b)
					_G.ObjectiveTrackerBlocksFrame.ScenarioHeader.Text:SetShadowColor(0, 0, 0, 0.8)
					_G.ObjectiveTrackerBlocksFrame.ScenarioHeader.Text:SetShadowOffset(2, -1)

					_G.WORLD_QUEST_TRACKER_MODULE.Header.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize, "OUTLINE")
					_G.WORLD_QUEST_TRACKER_MODULE.Header.Text:SetTextColor(r, g, b)
					_G.WORLD_QUEST_TRACKER_MODULE.Header.Text:SetShadowColor(0, 0, 0, 0.8)
					_G.WORLD_QUEST_TRACKER_MODULE.Header.Text:SetShadowOffset(2, -1)

					_G.BONUS_OBJECTIVE_TRACKER_MODULE.Header.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize, "OUTLINE")
					_G.BONUS_OBJECTIVE_TRACKER_MODULE.Header.Text:SetTextColor(r, g, b)
					_G.BONUS_OBJECTIVE_TRACKER_MODULE.Header.Text:SetShadowColor(0, 0, 0, 0.8)
					_G.BONUS_OBJECTIVE_TRACKER_MODULE.Header.Text:SetShadowOffset(2, -1)

					_G.OBJECTIVE_TRACKER_COLOR["Header"].r = r
					_G.OBJECTIVE_TRACKER_COLOR["Header"].g = g
					_G.OBJECTIVE_TRACKER_COLOR["Header"].b = b

					_G.ObjectiveFont:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize, "OUTLINE")
					_G.ObjectiveFont:SetTextColor(r, g, b)

					_G.QuestFont:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize)
					_G.QuestFont:SetTextColor(r, g, b)

					_G.QuestFont_Large:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize)
					_G.QuestFont_Super_Huge:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize, "OUTLINE")
					_G.QuestFont_Enormous:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize, "OUTLINE")
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
							watchText:SetTextColor(r, g, b)
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
