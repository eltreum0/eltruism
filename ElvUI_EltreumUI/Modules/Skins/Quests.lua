local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local IsAddOnLoaded = _G.IsAddOnLoaded
local CreateFrame = _G.CreateFrame
local unpack = _G.unpack
local classcolor = E:ClassColor(E.myclass, true)

local ObjectiveTrackerBlocksFrame, ScenarioObjectiveBlockBackground, ScenarioObjectiveBlockBackgroundTexture

if ElvUI_EltreumUI.Retail then
	ScenarioObjectiveBlockBackground = CreateFrame("Frame", "EltruismScenarioBlockBg")
	ScenarioObjectiveBlockBackgroundTexture = ScenarioObjectiveBlockBackground:CreateTexture()
	ObjectiveTrackerBlocksFrame = _G.ObjectiveTrackerBlocksFrame
	ObjectiveTrackerBlocksFrame.ScenarioHeader.StatusLine = CreateFrame("StatusBar", "EltruismScenarioLine", ObjectiveTrackerBlocksFrame.ScenarioHeader)
	ObjectiveTrackerBlocksFrame.CampaignQuestHeader.StatusLine = CreateFrame("StatusBar", "EltruismCampaignLine", ObjectiveTrackerBlocksFrame.CampaignQuestHeader)
	ObjectiveTrackerBlocksFrame.QuestHeader.StatusLine = CreateFrame("StatusBar", "EltruismQuestLine", ObjectiveTrackerBlocksFrame.QuestHeader)
	ObjectiveTrackerBlocksFrame.AchievementHeader.StatusLine = CreateFrame("StatusBar", "EltruismAchievementLine", ObjectiveTrackerBlocksFrame.AchievementHeader)
end

function ElvUI_EltreumUI:SkinQuests()
	--print("skin quests spam")
	local fontsize = E.db.general.fontSize
	if E.db.ElvUI_EltreumUI.skins.quests then
		if ElvUI_EltreumUI.Retail then
			if (not IsAddOnLoaded("ElvUI_SLE")) and (not IsAddOnLoaded("ElvUI_WindTools")) and (not IsAddOnLoaded('!KalielsTracker')) and (not IsAddOnLoaded('SorhaQuestLog')) and (not IsAddOnLoaded('ClassicQuestLog')) and (not IsAddOnLoaded('Who Framed Watcher Wabbit?')) then

				--create the lines
				if ObjectiveTrackerBlocksFrame then

					ObjectiveTrackerBlocksFrame.ScenarioHeader.StatusLine:SetSize(250, 2)
					ObjectiveTrackerBlocksFrame.ScenarioHeader.StatusLine:SetPoint("BOTTOM", ObjectiveTrackerBlocksFrame.ScenarioHeader, 0, -1)
					ObjectiveTrackerBlocksFrame.ScenarioHeader.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
					ObjectiveTrackerBlocksFrame.ScenarioHeader.StatusLine:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)

					ObjectiveTrackerBlocksFrame.CampaignQuestHeader.StatusLine:SetSize(250, 2)
					ObjectiveTrackerBlocksFrame.CampaignQuestHeader.StatusLine:SetPoint("BOTTOM", ObjectiveTrackerBlocksFrame.CampaignQuestHeader, 0, -1)
					ObjectiveTrackerBlocksFrame.CampaignQuestHeader.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
					ObjectiveTrackerBlocksFrame.CampaignQuestHeader.StatusLine:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)

					ObjectiveTrackerBlocksFrame.QuestHeader.StatusLine:SetSize(250, 2)
					ObjectiveTrackerBlocksFrame.QuestHeader.StatusLine:SetPoint("BOTTOM", ObjectiveTrackerBlocksFrame.QuestHeader, 0, -1)
					ObjectiveTrackerBlocksFrame.QuestHeader.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
					ObjectiveTrackerBlocksFrame.QuestHeader.StatusLine:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)

					ObjectiveTrackerBlocksFrame.AchievementHeader.StatusLine:SetSize(250, 2)
					ObjectiveTrackerBlocksFrame.AchievementHeader.StatusLine:SetPoint("BOTTOM", ObjectiveTrackerBlocksFrame.AchievementHeader, 0, -1)
					ObjectiveTrackerBlocksFrame.AchievementHeader.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
					ObjectiveTrackerBlocksFrame.AchievementHeader.StatusLine:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)
				end

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
						if not block then
							return
						end
						if block.HeaderText then  --quest title
							block.HeaderText:SetFont(E.LSM:Fetch('font', E.db.general.font), 13, "OUTLINE")
							block.HeaderText:SetTextColor(mult * classcolor.r, mult * classcolor.g, mult * classcolor.b)
							block.HeaderText:SetWordWrap(true)
						end
						if block.currentLine then --quest text
							if block.currentLine.objectiveKey == 0 then --also quest title
								block.currentLine.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), 12, "OUTLINE")
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

				hooksecurefunc('ObjectiveTracker_Update', function ()
					local modules = _G.ObjectiveTrackerFrame.MODULES
					if not modules then
						return
					end
					for i = 1, #modules do
						local module = modules[i]
						if module and module.Header and module.Header.Text then --the big type of quest
							module.Header.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize*1.5, "OUTLINE")
							module.Header.Text:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							module.Header.Text:SetShadowColor(0, 0, 0, 0.8)
							module.Header.Text:SetShadowOffset(2, -1)
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
						--local a = progressBar.Bar.backdrop:GetObjectType()  --results in frame
						--progressBar.Bar.backdrop:SetBackdropColor(0, 1, 0, 0.2)
						--progressBar.Bar.backdrop:SetColorTexture(0,1,0,1)
						--progressBar.Bar.backdrop:SetStatusBarColor(0,1,0)
						--progressBar.Bar.backdrop:SetVertexColor(0,1,0,1)
						progressBar.EltruismSkin = true
					end
				end
				hooksecurefunc(_G.QUEST_TRACKER_MODULE, "AddProgressBar", EltreumSkinProgressBars)
				hooksecurefunc(_G.BONUS_OBJECTIVE_TRACKER_MODULE, "AddProgressBar", EltreumSkinProgressBars)
				hooksecurefunc(_G.WORLD_QUEST_TRACKER_MODULE, "AddProgressBar", EltreumSkinProgressBars)
				hooksecurefunc(_G.CAMPAIGN_QUEST_TRACKER_MODULE, "AddProgressBar", EltreumSkinProgressBars)
				hooksecurefunc(_G.SCENARIO_TRACKER_MODULE, "AddProgressBar", EltreumSkinProgressBars)
				hooksecurefunc(_G.DEFAULT_OBJECTIVE_TRACKER_MODULE, "AddProgressBar", EltreumSkinProgressBars)

				hooksecurefunc(_G.SCENARIO_CONTENT_TRACKER_MODULE, 'UpdateCriteria', function ()
					if _G.ScenarioObjectiveBlock then
						local frames = {_G.ScenarioObjectiveBlock:GetChildren()}
						for _, frame in pairs(frames) do
							if frame.Text then
								frame.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), 14, "OUTLINE")
								frame.Text:SetTextColor(1, 1, 1)  --dungeon obj text
								frame.Text:SetWordWrap(true)
							end
						end
					end
				end)

				if _G.ScenarioObjectiveBlock then
					local frames = {_G.ScenarioObjectiveBlock:GetChildren()}
					for _, frame in pairs(frames) do
						if frame.Text then
							frame.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), 14, "OUTLINE")
							frame.Text:SetTextColor(mult * classcolor.r, mult * classcolor.g, mult * classcolor.b)
							frame.Text:SetWordWrap(true)
						end
					end
				end

				--skin the dungeon/raid/scenario bg
				hooksecurefunc(_G["SCENARIO_CONTENT_TRACKER_MODULE"], "Update", function ()
					ScenarioObjectiveBlockBackground:SetParent(_G.ScenarioStageBlock)
					ScenarioObjectiveBlockBackground:ClearAllPoints()
					ScenarioObjectiveBlockBackground:SetAllPoints(_G.ScenarioStageBlock.NormalBG)
					ScenarioObjectiveBlockBackground:CreateBackdrop('Transparent')
					ScenarioObjectiveBlockBackgroundTexture:SetTexture("Interface\\Addons\\ElvUI\\Code\\Media\\Textures\\White8x8.tga")
					ScenarioObjectiveBlockBackgroundTexture:SetColorTexture(0, 0, 0, 0.01)
					ScenarioObjectiveBlockBackgroundTexture:SetAlpha(0.01)
					ScenarioObjectiveBlockBackgroundTexture:SetAllPoints(_G.ScenarioStageBlock.NormalBG)
					ScenarioObjectiveBlockBackground:Show()
					ScenarioObjectiveBlockBackgroundTexture:Show()
					_G.ScenarioStageBlock.NormalBG:Hide()
					_G.ScenarioStageBlock.FinalBG:Hide()
					--dungeon/raid/scenario name text
					if _G.ScenarioStageBlock.Stage then
						_G.ScenarioStageBlock.Stage:SetTextColor(mult * classcolor.r, mult * classcolor.g, mult * classcolor.b)
						_G.ScenarioStageBlock.Stage:SetFont(E.LSM:Fetch('font', E.db.general.font), 18, "OUTLINE")
						_G.ScenarioStageBlock.Stage:SetShadowColor(0, 0, 0, 0.8)
						_G.ScenarioStageBlock.Stage:SetShadowOffset(2, -1)
					end
				end)

				--turns out this is using too much memory, maybe because it was hooking?
				--[[
					hooksecurefunc(_G.DEFAULT_OBJECTIVE_TRACKER_MODULE, "OnBlockHeaderEnter", function(_, block)
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

					hooksecurefunc(_G.DEFAULT_OBJECTIVE_TRACKER_MODULE, "OnBlockHeaderLeave", function(_, block)
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
				]]
			end
		end
		if ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
			if not IsAddOnLoaded('Questie') then
				--from blizzard's FrameXML/QuestLogFrame.lua
				hooksecurefunc("QuestWatch_Update",function()
					local numObjectives
					local questWatchMaxWidth = 0
					local tempWidth
					local watchText
					--local text, type, finished --type is unused
					local text, _, finished
					--local questTitle  --unused
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
								watchText:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize, "OUTLINE")
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
									watchText:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize, "OUTLINE")
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
						QuestWatchFrame:Hide()
						return
					else
						QuestWatchFrame:Show()
						QuestWatchFrame:SetHeight(watchTextIndex * 13)
						QuestWatchFrame:SetWidth(questWatchMaxWidth + 10)
					end

					-- Hide unused watch lines
					for i=watchTextIndex, MAX_QUESTWATCH_LINES do
						_G["QuestWatchLine"..i]:Hide()
					end

					UIParent_ManageFramePositions()
				end)
			end
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
