local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local IsAddOnLoaded = _G.IsAddOnLoaded
local CreateFrame = _G.CreateFrame
local unpack = _G.unpack
local r, g, b = unpack(E.media.rgbvaluecolor)

function ElvUI_EltreumUI:SkinQuests()
	if ElvUI_EltreumUI.Retail then
		if (not IsAddOnLoaded("ElvUI_SLE")) and (not IsAddOnLoaded("ElvUI_WindTools")) then
			--this thing was causing A LOT OF MEMORY USAGE so i removed it
			--[[
			OBJECTIVE_TRACKER_COLOR = {
				["Normal"] = { r = 1, g = 1, b = 1 },
				["NormalHighlight"] = { r = 0.8, g = 0.8, b = 0.8 },
				--["NormalHighlight"] = { r = r, g = g, b = b },
				--["NormalHighlight"] = { r = HIGHLIGHT_FONT_COLOR.r, g = HIGHLIGHT_FONT_COLOR.g, b = HIGHLIGHT_FONT_COLOR.b },
				["Failed"] = { r = DIM_RED_FONT_COLOR.r, g = DIM_RED_FONT_COLOR.g, b = DIM_RED_FONT_COLOR.b },
				["FailedHighlight"] = { r = RED_FONT_COLOR.r, g = RED_FONT_COLOR.g, b = RED_FONT_COLOR.b },
				["Header"] = { r = r, g = g, b = b },
				["HeaderHighlight"] = { r = 0.8, g = 0.8, b = 0.8 },
				--["HeaderHighlight"] = { r = r, g = g, b = b },
				--["HeaderHighlight"] = { r = NORMAL_FONT_COLOR.r, g = NORMAL_FONT_COLOR.g, b = NORMAL_FONT_COLOR.b },
				["Complete"] = { r = 0, g = 1, b = 0 },
				["TimeLeft"] = { r = DIM_RED_FONT_COLOR.r, g = DIM_RED_FONT_COLOR.g, b = DIM_RED_FONT_COLOR.b },
				["TimeLeftHighlight"] = { r = RED_FONT_COLOR.r, g = RED_FONT_COLOR.g, b = RED_FONT_COLOR.b },
			}
			]]--
			local fontsize = E.db.general.fontSize
			local ObjectiveTrackerBlocksFrame = _G.ObjectiveTrackerBlocksFrame
			if ObjectiveTrackerBlocksFrame then
				ObjectiveTrackerBlocksFrame.ScenarioHeader.StatusLine = CreateFrame("StatusBar", nil, ObjectiveTrackerBlocksFrame.ScenarioHeader)
				ObjectiveTrackerBlocksFrame.ScenarioHeader.StatusLine:SetSize(250, 2)
				ObjectiveTrackerBlocksFrame.ScenarioHeader.StatusLine:SetPoint("BOTTOM", ObjectiveTrackerBlocksFrame.ScenarioHeader, 0, -1)
				ObjectiveTrackerBlocksFrame.ScenarioHeader.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				ObjectiveTrackerBlocksFrame.ScenarioHeader.StatusLine:SetStatusBarColor(r, g, b, 1)

				ObjectiveTrackerBlocksFrame.CampaignQuestHeader.StatusLine = CreateFrame("StatusBar", nil, ObjectiveTrackerBlocksFrame.CampaignQuestHeader)
				ObjectiveTrackerBlocksFrame.CampaignQuestHeader.StatusLine:SetSize(250, 2)
				ObjectiveTrackerBlocksFrame.CampaignQuestHeader.StatusLine:SetPoint("BOTTOM", ObjectiveTrackerBlocksFrame.CampaignQuestHeader, 0, -1)
				ObjectiveTrackerBlocksFrame.CampaignQuestHeader.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				ObjectiveTrackerBlocksFrame.CampaignQuestHeader.StatusLine:SetStatusBarColor(r, g, b, 1)

				ObjectiveTrackerBlocksFrame.QuestHeader.StatusLine = CreateFrame("StatusBar", nil, ObjectiveTrackerBlocksFrame.QuestHeader)
				ObjectiveTrackerBlocksFrame.QuestHeader.StatusLine:SetSize(250, 2)
				ObjectiveTrackerBlocksFrame.QuestHeader.StatusLine:SetPoint("BOTTOM", ObjectiveTrackerBlocksFrame.QuestHeader, 0, -1)
				ObjectiveTrackerBlocksFrame.QuestHeader.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				ObjectiveTrackerBlocksFrame.QuestHeader.StatusLine:SetStatusBarColor(r, g, b, 1)

				ObjectiveTrackerBlocksFrame.AchievementHeader.StatusLine = CreateFrame("StatusBar", nil, ObjectiveTrackerBlocksFrame.AchievementHeader)
				ObjectiveTrackerBlocksFrame.AchievementHeader.StatusLine:SetSize(250, 2)
				ObjectiveTrackerBlocksFrame.AchievementHeader.StatusLine:SetPoint("BOTTOM", ObjectiveTrackerBlocksFrame.AchievementHeader, 0, -1)
				ObjectiveTrackerBlocksFrame.AchievementHeader.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				ObjectiveTrackerBlocksFrame.AchievementHeader.StatusLine:SetStatusBarColor(r, g, b, 1)
			end
			hooksecurefunc("ObjectiveTracker_Update", function()
				_G.ObjectiveTrackerFrame.HeaderMenu.Title:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize, "OUTLINE")
				_G.ObjectiveTrackerFrame.HeaderMenu.Title:SetTextColor(r, g, b)

				_G.ObjectiveTrackerBlocksFrame.CampaignQuestHeader.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize*1.5, "OUTLINE")
				_G.ObjectiveTrackerBlocksFrame.CampaignQuestHeader.Text:SetTextColor(r, g, b)

				_G.ObjectiveTrackerBlocksFrame.QuestHeader.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize*1.5, "OUTLINE")
				_G.ObjectiveTrackerBlocksFrame.QuestHeader.Text:SetTextColor(r, g, b)

				_G.ObjectiveTrackerBlocksFrame.AchievementHeader.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize*1.5, "OUTLINE")
				_G.ObjectiveTrackerBlocksFrame.AchievementHeader.Text:SetTextColor(r, g, b)

				_G.ObjectiveTrackerBlocksFrame.ScenarioHeader.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize*1.5, "OUTLINE")
				_G.ObjectiveTrackerBlocksFrame.ScenarioHeader.Text:SetTextColor(r, g, b)

				_G.WORLD_QUEST_TRACKER_MODULE.Header.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize, "OUTLINE")
				_G.WORLD_QUEST_TRACKER_MODULE.Header.Text:SetTextColor(r, g, b)

				_G.BONUS_OBJECTIVE_TRACKER_MODULE.Header.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize, "OUTLINE")
				_G.BONUS_OBJECTIVE_TRACKER_MODULE.Header.Text:SetTextColor(r, g, b)

				_G.ObjectiveFont:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize, "OUTLINE")
				_G.ObjectiveFont:SetTextColor(r, g, b)
				_G.QuestFont:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize)
				_G.QuestFont:SetTextColor(r, g, b)
			end)
			hooksecurefunc("SetZoneText", function()
				_G.ZoneTextString:SetFont(E.LSM:Fetch('font', E.db.general.font), 36, "OUTLINE")
				_G.SubZoneTextString:SetFont(E.LSM:Fetch('font', E.db.general.font), 28, "OUTLINE")
				_G.PVPInfoTextString:SetFont(E.LSM:Fetch('font', E.db.general.font), 20, "OUTLINE")
				_G.PVPArenaTextString:SetFont(E.LSM:Fetch('font', E.db.general.font), 20, "OUTLINE")
			end)
			_G.OpenMailBodyText:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize, "OUTLINE")
			_G.SendMailBodyEditBox:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize, "OUTLINE")
			_G.QuestFont_Large:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize)
			_G.QuestFont_Super_Huge:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize, "OUTLINE")
			_G.QuestFont_Enormous:SetFont(E.LSM:Fetch('font', E.db.general.font), fontsize, "OUTLINE")
			_G.OBJECTIVE_TRACKER_COLOR["Header"].r = r
            _G.OBJECTIVE_TRACKER_COLOR["Header"].g = g
            _G.OBJECTIVE_TRACKER_COLOR["Header"].b = b
		end
	end
end

