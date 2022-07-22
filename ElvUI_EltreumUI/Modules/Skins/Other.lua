local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local S = E:GetModule('Skins')
local _G = _G
local CreateFrame = _G.CreateFrame

--skin IME input
local function SkinLocale()
	if E.locale == "koKR" or E.locale == "ruRU" or E.locale == "zhCN" or E.locale == "zhTW" then
		local ime = _G['IMECandidatesFrame']
		S:HandleFrame(ime)
		S:HandleFrame(_G['GeneralDockManagerOverflowButtonList'])
	end
end
SkinLocale()

--skin meeting horn addon
local handlemeetinghorn = CreateFrame("FRAME")
local meetskinned
handlemeetinghorn:RegisterEvent("ADDON_LOADED")
handlemeetinghorn:SetScript("OnEvent", function(_, _, arg)
	if (arg == "MeetingHorn") and E.db.ElvUI_EltreumUI.skins.meetinghorn then
		_G['MeetingHornMainPanel']:SetScript("OnShow", function()
			if not meetskinned == true then
				meetskinned = true
				S:HandleFrame(_G['MeetingHornMainPanel'])
				S:HandleScrollBar(_G.MeetingHornMainPanelScrollBar)

				--search
				S:HandleFrame(_G.MeetingHornMainPanel.Browser)
				S:HandleFrame(_G.MeetingHornMainPanel.Browser.Activity)
				S:HandleFrame(_G.MeetingHornMainPanel.Browser.Mode)
				S:HandleFrame(_G.MeetingHornMainPanelScrollChild)
				S:HandleFrame(_G.MeetingHornMainPanel.Browser.Header1)
				S:HandleFrame(_G.MeetingHornMainPanel.Browser.Header2)
				S:HandleFrame(_G.MeetingHornMainPanel.Browser.Header3)
				S:HandleFrame(_G.MeetingHornMainPanel.Browser.Header4)
				S:HandleFrame(_G.MeetingHornMainPanel.Browser.Header5)
				S:HandleFrame(_G.MeetingHornMainPanel.Browser.Header6)
				S:HandleFrame(_G.MeetingHornMainPanel.Browser.Header7)
				S:HandleFrame(_G.MeetingHornMainPanel.Browser.Header8)
				S:HandleEditBox(_G.MeetingHornMainPanel.Browser.Input)
				S:HandleButton(_G.MeetingHornMainPanel.Browser.Refresh)
				S:HandleButton(_G.MeetingHornMainPanel.Browser.Reset)
				S:HandleButton(_G.MeetingHornMainPanel.Browser.RechargeBtn)
				S:HandleButton(_G.MeetingHornMainPanel.Browser.ApplyLeaderBtn)
				S:HandleScrollBar(_G.MeetingHornMainPanel.Browser.ActivityList.scrollBar)

				--create
				S:HandleFrame(_G.MeetingHornMainPanel.Manage)
				S:HandleFrame(_G.MeetingHornMainPanel.Manage.Creator)
				S:HandleFrame(_G.MeetingHornMainPanel.Manage.Creator.Activity)
				S:HandleFrame(_G.MeetingHornMainPanel.Manage.Creator.Mode)
				S:HandleScrollBar(_G.MeetingHornMainPanel.Manage.Chat.ChatFrame.scrollBar)
				S:HandleFrame(_G.MeetingHornMainPanel.Manage.Creator.Comment)
				S:HandleButton(_G.MeetingHornMainPanel.Manage.Creator.CreateButton)
				S:HandleButton(_G.MeetingHornMainPanel.Manage.Creator.RecruitButton)
				S:HandleButton(_G.MeetingHornMainPanel.Manage.Creator.CloseButton)
				S:HandleFrame(_G.MeetingHornMainPanel.Manage.Chat)
				S:HandleFrame(_G.MeetingHornMainPanel.Manage.Chat.ChatFrame)
				_G.MeetingHornMainPanel.Manage.Chat.ChatBg:Hide()
				_G.MeetingHornMainPanel.Manage.Creator.RecruitButton.RightSeparator:Hide()
				_G.MeetingHornMainPanel.Manage.Creator.CreateButton.RightSeparator:Hide()
				_G.MeetingHornMainPanel.Manage.Creator.CloseButton.Texture:Hide()

				--leader
				S:HandleFrame(_G.MeetingHornMainPanel.GoodLeader)
				S:HandleFrame(_G.MeetingHornMainPanel.GoodLeader.First)
				S:HandleFrame(_G.MeetingHornMainPanel.GoodLeader.First.Footer)
				S:HandleFrame(_G.MeetingHornMainPanel.GoodLeader.First.Header)
				S:HandleButton(_G.MeetingHornMainPanel.GoodLeader.First.Header.ApplyLeaderBtn)

				--announcement
				S:HandleFrame(_G.MeetingHornMainPanel.Announcement)
				S:HandleFrame(_G.MeetingHornMainPanel.Announcement.loading)

				--mission guidance
				S:HandleFrame(_G.MeetingHornMainPanel.MissionGuidance)

				--recent
				S:HandleFrame(_G.MeetingHornMainPanel.Recent)
				S:HandleFrame(_G.MeetingHornMainPanel.Recent.Left)
				S:HandleFrame(_G.MeetingHornMainPanel.Recent.Members)
				S:HandleFrame(_G.MeetingHornMainPanel.Recent.Instance)
				S:HandleButton(_G.MeetingHornMainPanel.Recent.Invite)
				_G.MeetingHornMainPanel.Recent.Invite.RightSeparator:Hide()
				_G.MeetingHornMainPanel.Recent.Invite.LeftSeparator:Hide()

				--quest
				S:HandleFrame(_G.MeetingHornMainPanel.Loading)
				S:HandleFrame(_G.MeetingHornMainPanel.Quest)
				S:HandleFrame(_G.MeetingHornMainPanel.Quest.Body)
				S:HandleFrame(_G.MeetingHornMainPanel.Quest.Body.Quests)
				S:HandleButton(_G.MeetingHornMainPanel.Quest.Body.Refresh)
				S:HandleScrollBar(_G.MeetingHornMainPanel.Quest.Body.Quests.scrollBar)
				S:HandleFrame(_G.MeetingHornMainPanel.Quest.Summary)

				--options
				S:HandleFrame(_G.MeetingHornMainPanel.Options)
				S:HandleFrame(_G.MeetingHornMainPanel.Options.Options)
				S:HandleFrame(_G.MeetingHornMainPanel.Options.Filters)
				S:HandleFrame(_G.MeetingHornMainPanel.Options.Filters.FilterList)
				S:HandleScrollBar(_G.MeetingHornMainPanel.Options.Filters.FilterList.scrollBar)

				S:HandleButton(_G.MeetingHornMainPanel.Options.Filters.Add)
				S:HandleButton(_G.MeetingHornMainPanel.Options.Filters.Import)
				S:HandleButton(_G.MeetingHornMainPanel.Options.Filters.Export)

				--help
				S:HandleFrame(_G.MeetingHornMainPanel.Help)
				_G.MeetingHornMainPanelPortraitFrame:Hide()
			end
		end)
	end
end)
