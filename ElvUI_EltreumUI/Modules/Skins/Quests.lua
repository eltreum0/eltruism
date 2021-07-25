local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local IsAddOnLoaded = _G.IsAddOnLoaded
local DIM_RED_FONT_COLOR = _G.DIM_RED_FONT_COLOR
local RED_FONT_COLOR = _G.RED_FONT_COLOR
local OBJECTIVE_TRACKER_COLOR = _G.OBJECTIVE_TRACKER_COLOR
local CreateFrame = _G.CreateFrame
local unpack = _G.unpack

function ElvUI_EltreumUI:SkinQuests()
	if ElvUI_EltreumUI.Retail then
		if (not IsAddOnLoaded("ElvUI_SLE")) and (not IsAddOnLoaded("ElvUI_WindTools")) then
			local r, g, b = unpack(E.media.rgbvaluecolor)
			OBJECTIVE_TRACKER_COLOR = {
				["Normal"] = { r = 1, g = 1, b = 1 },
				["NormalHighlight"] = { r = r, g = g, b = b },
				--["NormalHighlight"] = { r = HIGHLIGHT_FONT_COLOR.r, g = HIGHLIGHT_FONT_COLOR.g, b = HIGHLIGHT_FONT_COLOR.b },
				["Failed"] = { r = DIM_RED_FONT_COLOR.r, g = DIM_RED_FONT_COLOR.g, b = DIM_RED_FONT_COLOR.b },
				["FailedHighlight"] = { r = RED_FONT_COLOR.r, g = RED_FONT_COLOR.g, b = RED_FONT_COLOR.b },
				["Header"] = { r = r, g = g, b = b },
				["HeaderHighlight"] = { r = r, g = g, b = b },
				--["HeaderHighlight"] = { r = NORMAL_FONT_COLOR.r, g = NORMAL_FONT_COLOR.g, b = NORMAL_FONT_COLOR.b },
				["Complete"] = { r = 0, g = 1, b = 0 },
				["TimeLeft"] = { r = DIM_RED_FONT_COLOR.r, g = DIM_RED_FONT_COLOR.g, b = DIM_RED_FONT_COLOR.b },
				["TimeLeftHighlight"] = { r = RED_FONT_COLOR.r, g = RED_FONT_COLOR.g, b = RED_FONT_COLOR.b },
			}


			local fontsize = E.db.chat.fontSize
			local ObjectiveTrackerBlocksFrame = _G.ObjectiveTrackerBlocksFrame

			if ObjectiveTrackerBlocksFrame then
				ObjectiveTrackerBlocksFrame.ScenarioHeader.Text:SetTextColor(r, g, b)
				ObjectiveTrackerBlocksFrame.ScenarioHeader.Text:SetFont(E.LSM:Fetch("font", E.db.general.font), fontsize, "OUTLINE")

				ObjectiveTrackerBlocksFrame.ScenarioHeader.StatusLine = CreateFrame("StatusBar", nil, ObjectiveTrackerBlocksFrame.ScenarioHeader)
				ObjectiveTrackerBlocksFrame.ScenarioHeader.StatusLine:SetSize(250, 2)
				ObjectiveTrackerBlocksFrame.ScenarioHeader.StatusLine:SetPoint("BOTTOM", ObjectiveTrackerBlocksFrame.ScenarioHeader, 0, 0)
				ObjectiveTrackerBlocksFrame.ScenarioHeader.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				ObjectiveTrackerBlocksFrame.ScenarioHeader.StatusLine:SetStatusBarColor(r, g, b, 1)

				ObjectiveTrackerBlocksFrame.CampaignQuestHeader.Text:SetTextColor(r, g, b)
				ObjectiveTrackerBlocksFrame.CampaignQuestHeader.Text:SetFont(E.LSM:Fetch("font", E.db.general.font), fontsize, "OUTLINE")

				ObjectiveTrackerBlocksFrame.CampaignQuestHeader.StatusLine = CreateFrame("StatusBar", nil, ObjectiveTrackerBlocksFrame.CampaignQuestHeader)
				ObjectiveTrackerBlocksFrame.CampaignQuestHeader.StatusLine:SetSize(250, 2)
				ObjectiveTrackerBlocksFrame.CampaignQuestHeader.StatusLine:SetPoint("BOTTOM", ObjectiveTrackerBlocksFrame.CampaignQuestHeader, 0, 0)
				ObjectiveTrackerBlocksFrame.CampaignQuestHeader.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				ObjectiveTrackerBlocksFrame.CampaignQuestHeader.StatusLine:SetStatusBarColor(r, g, b, 1)

				ObjectiveTrackerBlocksFrame.QuestHeader.Text:SetTextColor(r, g, b)
				ObjectiveTrackerBlocksFrame.QuestHeader.Text:SetFont(E.LSM:Fetch("font", E.db.general.font), fontsize, "OUTLINE")

				ObjectiveTrackerBlocksFrame.QuestHeader.StatusLine = CreateFrame("StatusBar", nil, ObjectiveTrackerBlocksFrame.QuestHeader)
				ObjectiveTrackerBlocksFrame.QuestHeader.StatusLine:SetSize(250, 2)
				ObjectiveTrackerBlocksFrame.QuestHeader.StatusLine:SetPoint("BOTTOM", ObjectiveTrackerBlocksFrame.QuestHeader, 0, 0)
				ObjectiveTrackerBlocksFrame.QuestHeader.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				ObjectiveTrackerBlocksFrame.QuestHeader.StatusLine:SetStatusBarColor(r, g, b, 1)

				ObjectiveTrackerBlocksFrame.AchievementHeader.Text:SetTextColor(r, g, b)
				ObjectiveTrackerBlocksFrame.AchievementHeader.Text:SetFont(E.LSM:Fetch("font", E.db.general.font), fontsize, "OUTLINE")

				ObjectiveTrackerBlocksFrame.AchievementHeader.StatusLine = CreateFrame("StatusBar", nil, ObjectiveTrackerBlocksFrame.AchievementHeader)
				ObjectiveTrackerBlocksFrame.AchievementHeader.StatusLine:SetSize(250, 2)
				ObjectiveTrackerBlocksFrame.AchievementHeader.StatusLine:SetPoint("BOTTOM", ObjectiveTrackerBlocksFrame.AchievementHeader, 0, 0)
				ObjectiveTrackerBlocksFrame.AchievementHeader.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				ObjectiveTrackerBlocksFrame.AchievementHeader.StatusLine:SetStatusBarColor(r, g, b, 1)
			end
		end
	end
end
