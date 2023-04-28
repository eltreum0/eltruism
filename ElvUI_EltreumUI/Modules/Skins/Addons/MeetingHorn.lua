local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local select = _G.select

--skin IME input
local function SkinLocale()
	if E.locale == "koKR" or E.locale == "ruRU" or E.locale == "zhCN" or E.locale == "zhTW" then
		local ime = _G['IMECandidatesFrame']
		S:HandleFrame(ime)
		S:HandleFrame(_G['GeneralDockManagerOverflowButtonList'])
	end
end
SkinLocale()

--SkinMeeting horn as asked by Neo
function ElvUI_EltreumUI:EltruismMeetingHorn()
	if E.db.ElvUI_EltreumUI.skins.meetinghorn then

		local f = E.Libs.AceAddon:GetAddon("MeetingHorn")
		S:HandleFrame(f.MainPanel)
		f.MainPanel:SetTemplate('Transparent', nil, true)

		if E.db.ElvUI_EltreumUI.skins.shadow.enable then
			if not f.MainPanel.shadow then
				f.MainPanel:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				ElvUI_EltreumUI:ShadowColor(f.MainPanel.shadow)
			end
		end

		if f.MainPanel.PortraitFrame then
			f.MainPanel.PortraitFrame:Hide()
		end

		--search
		S:HandleFrame(f.MainPanel.Browser)
		S:HandleFrame(f.MainPanel.Browser.Activity)
		S:HandleFrame(f.MainPanel.Browser.Mode)
		S:HandleFrame(f.MainPanel.Browser.ActivityList.ScrollChild)
		S:HandleFrame(f.MainPanel.Browser.Header1)
		S:HandleFrame(f.MainPanel.Browser.Header2)
		S:HandleFrame(f.MainPanel.Browser.Header3)
		S:HandleFrame(f.MainPanel.Browser.Header4)
		S:HandleFrame(f.MainPanel.Browser.Header5)
		S:HandleFrame(f.MainPanel.Browser.Header6)
		S:HandleFrame(f.MainPanel.Browser.Header7)
		S:HandleFrame(f.MainPanel.Browser.Header8)
		S:HandleEditBox(f.MainPanel.Browser.Input)
		S:HandleButton(f.MainPanel.Browser.Refresh)
		S:HandleButton(f.MainPanel.Browser.Reset)
		S:HandleScrollBar(f.MainPanel.Browser.ActivityList.scrollBar)

		--challenge
		S:HandleFrame(f.MainPanel.Challenge)
		S:HandleButton(f.MainPanel.Challenge.Body.Reward.Exchange)

		--create
		S:HandleFrame(f.MainPanel.Manage)
		S:HandleFrame(f.MainPanel.Manage.Creator)
		S:HandleFrame(f.MainPanel.Manage.Creator.Activity)
		S:HandleFrame(f.MainPanel.Manage.Creator.Mode)
		S:HandleScrollBar(f.MainPanel.Manage.Chat.ChatFrame.scrollBar)
		S:HandleFrame(f.MainPanel.Manage.Creator.Comment)
		S:HandleButton(f.MainPanel.Manage.Creator.CreateButton)
		S:HandleButton(f.MainPanel.Manage.Creator.RecruitButton)
		S:HandleButton(f.MainPanel.Manage.Creator.CloseButton)
		f.MainPanel.Manage.Creator.CloseButton.Texture:SetPoint("RIGHT", f.MainPanel.Manage.Creator.CloseButton, "RIGHT")
		S:HandleFrame(f.MainPanel.Manage.Chat)
		S:HandleFrame(f.MainPanel.Manage.Chat.ChatFrame)
		f.MainPanel.Manage.Chat.ChatBg:Hide()
		f.MainPanel.Manage.Creator.RecruitButton.RightSeparator:Hide()
		f.MainPanel.Manage.Creator.CreateButton.RightSeparator:Hide()
		f.MainPanel.Browser.RechargeBtn.RightSeparator:Hide()
		f.MainPanel.Browser.RechargeBtn.LeftSeparator:Hide()
		f.MainPanel.Manage.Creator.CloseButton.Texture:Hide()

		--leader
		S:HandleFrame(f.MainPanel.GoodLeader)
		S:HandleFrame(f.MainPanel.GoodLeader.First)
		S:HandleFrame(f.MainPanel.GoodLeader.First.Footer)
		S:HandleFrame(f.MainPanel.GoodLeader.First.Header)
		S:HandleButton(f.MainPanel.GoodLeader.First.Header.ApplyLeaderBtn)

		--announcement
		S:HandleFrame(f.MainPanel.Announcement)
		S:HandleFrame(f.MainPanel.Announcement.loading)

		--mission guidance
		S:HandleFrame(f.MainPanel.MissionGuidance)

		--recent
		S:HandleFrame(f.MainPanel.Recent)
		S:HandleFrame(f.MainPanel.Recent.Left)
		S:HandleFrame(f.MainPanel.Recent.Right)
		S:HandleFrame(f.MainPanel.Recent.Members)
		S:HandleFrame(f.MainPanel.Recent.Instance)
		S:HandleButton(f.MainPanel.Recent.Invite)
		f.MainPanel.Recent.Invite.RightSeparator:Hide()
		f.MainPanel.Recent.Invite.LeftSeparator:Hide()

		--quest
		S:HandleFrame(f.MainPanel.Loading)
		S:HandleFrame(f.MainPanel.Quest)
		S:HandleFrame(f.MainPanel.Quest.Body)
		S:HandleFrame(f.MainPanel.Quest.Body.Quests)
		S:HandleButton(f.MainPanel.Quest.Body.Refresh)
		S:HandleScrollBar(f.MainPanel.Quest.Body.Quests.scrollBar)
		S:HandleFrame(f.MainPanel.Quest.Summary)

		--options
		S:HandleFrame(f.MainPanel.Options)
		S:HandleFrame(f.MainPanel.Options.Options)
		S:HandleFrame(f.MainPanel.Options.Filters)
		S:HandleFrame(f.MainPanel.Options.Filters.FilterList)
		S:HandleScrollBar(f.MainPanel.Options.Filters.FilterList.scrollBar)

		S:HandleButton(f.MainPanel.Options.Filters.Add)
		S:HandleButton(f.MainPanel.Options.Filters.Import)
		S:HandleButton(f.MainPanel.Options.Filters.Export)

		--main buttons
		S:HandleButton(f.MainPanel.Browser.RechargeBtn)
		S:HandleButton(f.MainPanel.Browser.ApplyLeaderBtn)
		--S:HandleDropDownBox(f.MainPanel.Browser.Activity) --issue due to Button being MenuButton instead
		--S:HandleDropDownBox(f.MainPanel.Browser.Mode) --same

		S:HandleScrollBar(f.MainPanel.Manage.Creator.Comment.ScrollFrame.ScrollBar)
		S:HandleScrollBar(f.MainPanel.MissionGuidance.MissionGuidanceScrollFrame.ScrollBar)

		--feedback
		S:HandleFrame(f.MainPanel.FeedBack.EditBox)
		S:HandleButton(f.MainPanel.FeedBack.AcceptButton)
		S:HandleButton(f.MainPanel.FeedBack.CancelButton)

		--help
		S:HandleFrame(f.MainPanel.Help)

		--bc the tab names are nil, gotta try to detect it
		local header = f.MainPanel
		for i = 1, header:GetNumChildren() do
			local group = select(i, header:GetChildren())
			if group and group:GetName() == nil then
				if group.HighlightTexture then
					S:HandleTab(group)
					if not group.backdrop.shadow then
						group.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(group.backdrop.shadow)
					end
				end
			end
		end
	end
end
S:AddCallbackForAddon('MeetingHorn', 'EltruismMeetingHorn', ElvUI_EltreumUI.EltruismMeetingHorn)
