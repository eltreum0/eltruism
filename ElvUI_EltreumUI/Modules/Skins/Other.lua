local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local S = E:GetModule('Skins')
local _G = _G
local CreateFrame = _G.CreateFrame
local WideTradeSkill = CreateFrame("Frame")
WideTradeSkill:RegisterEvent("PLAYER_ENTERING_WORLD")
local WideTradeSkillEnchant = CreateFrame("Frame")
WideTradeSkillEnchant:RegisterEvent("PLAYER_ENTERING_WORLD")
local dontexpandanymoreEnchant = 0
local dontexpandanymore = 0
local skillbutton
local skillTitle
local classcolor = E:ClassColor(E.myclass, true)

--test elvui backdrop transparency, can also replace the backdrop texture
--[[
--E.media.blankTex = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Stripes.tga"
function E:UpdateBackdropColors()
	local r, g, b = unpack(E.media.backdropcolor)
	local r2, g2, b2, a2 = unpack(E.media.backdropfadecolor)

	for frame in pairs(E.frames) do
		if frame and frame.template and not frame:IsForbidden() then
			if not frame.ignoreUpdates then
				if frame.callbackBackdropColor then
					local edgeSize = E.twoPixelsPlease and 2 or 1
					frame:SetBackdrop({
						edgeFile = E.media.blankTex,
						bgFile = E.media.glossTex,
						edgeSize = edgeSize
					})
					frame:callbackBackdropColor()

				elseif frame.template == 'Default' then
					local edgeSize = E.twoPixelsPlease and 2 or 1
					frame:SetBackdrop({
						edgeFile = E.media.blankTex,
						bgFile = E.media.glossTex,
						edgeSize = edgeSize
					})
					frame:SetBackdropColor(r, g, b, a2)


				elseif frame.template == 'Transparent' then
					local edgeSize = E.twoPixelsPlease and 2 or 1
					frame:SetBackdrop({
						edgeFile = E.media.blankTex,
						bgFile = E.media.glossTex,
						edgeSize = edgeSize
					})
					frame:SetBackdropColor(r2, g2, b2, frame.customBackdropAlpha or a2)

				end
			end
		else
			E.frames[frame] = nil
		end
	end

	for frame in pairs(E.unitFrameElements) do
		if frame and frame.template and not frame:IsForbidden() then
			if not frame.ignoreUpdates then
				if frame.callbackBackdropColor then
					frame:callbackBackdropColor()
				elseif frame.template == 'Default' then
					frame:SetBackdropColor(r, g, b)
				elseif frame.template == 'Transparent' then
					frame:SetBackdropColor(r2, g2, b2, frame.customBackdropAlpha or a2)
				end
			end
		else
			E.unitFrameElements[frame] = nil
		end
	end
end]]

--add item level to tooltip
if not E.Retail then
	local _,itemLink,itemLevel, classID
	GameTooltip:HookScript("OnTooltipSetItem", function(tooltip)
		_, itemLink = tooltip:GetItem()
		if (itemLink ~= nil) then
			_, _, _, itemLevel, _, _, _, _, _, _, _, classID = GetItemInfo(itemLink)
			if itemLevel and (classID == 2 or classID == 4)then
				tooltip:AddLine(string.format(ITEM_LEVEL, itemLevel))
			end
		end
	end)
end

--gradient misc
function ElvUI_EltreumUI:GradientMirrorLoot()
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then

		--breath/mirror
		for i = 1, _G.MIRRORTIMER_NUMTIMERS do
			local statusBar = _G['MirrorTimer'..i..'StatusBar']
			if statusBar then
				statusBar:HookScript("OnShow", function()
					local r,g,b,a = statusBar:GetStatusBarColor()
					statusBar:GetStatusBarTexture():SetGradientAlpha("HORIZONTAL", r - 0.3, g - 0.3, b - 0.3, a, r + 0.2, g + 0.2, b + 0.2, a)
				end)
			end
		end

		--loot roll
		for i = 1, NUM_GROUP_LOOT_FRAMES do
			local frame = _G["ElvUI_LootRollFrame"..i]
			if frame then
				if E.db.ElvUI_EltreumUI.skins.shadow.enable then
					if not frame.status.shadow then
						frame.status:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					end
				end
				if not frame.GradientHook then
					frame:HookScript("OnShow", function()
						local r,g,b = frame.status:GetStatusBarColor()
						frame.status:GetStatusBarTexture():SetGradientAlpha("HORIZONTAL", r - 0.5, g - 0.5, b - 0.5, 1, r + 0.3, g + 0.3, b + 0.3, 1)
					end)
					frame.GradientHook = true
				end
			end
		end

	end
end

function ElvUI_EltreumUI:SkinProfessions()
	if E.db.ElvUI_EltreumUI.skins.professions and E.private.skins.blizzard.enable then

		--skin and expand the tradeskills
		WideTradeSkill:RegisterEvent("ADDON_LOADED")
		WideTradeSkill:SetScript("OnEvent", function(_, _, arg)
			if IsAddOnLoaded("Blizzard_TradeSkillUI") or IsAddOnLoaded("Blizzard_RuneforgeUI") or (arg == "Blizzard_TradeSkillUI") or (arg == "Blizzard_RuneforgeUI") then
				WideTradeSkill:UnregisterAllEvents()
				local TradeSkillFrame = _G.TradeSkillFrame
				local TradeSkillDetailScrollFrame = _G.TradeSkillDetailScrollFrame
				local TradeSkillDetailScrollChildFrame = _G.TradeSkillDetailScrollChildFrame
				local TradeSkillListScrollFrameScrollBar = _G.TradeSkillListScrollFrameScrollBar
				local TradeSkillCreateAllButton = _G.TradeSkillCreateAllButton
				local TradeSkillCreateButton = _G.TradeSkillCreateButton
				local TradeSkillCancelButton = _G.TradeSkillCancelButton

				if dontexpandanymore == 0 then
					-- Create the additional rows
					--local numSkills = _G.TRADE_SKILLS_DISPLAYED
					--local numSkills = 8
					_G.TRADE_SKILLS_DISPLAYED = 22

					--_G.TRADE_SKILLS_DISPLAYED = _G.TRADE_SKILLS_DISPLAYED + 14
					--for i = numSkills + 1, 22 do
					for i = 9, 22 do
						skillbutton = CreateFrame("Button", "TradeSkillSkill" .. i, TradeSkillFrame, "TradeSkillSkillButtonTemplate")
						skillbutton:SetID(i)
						skillbutton:Hide()
						skillbutton:ClearAllPoints()
						skillbutton:SetPoint("TOPLEFT", _G["TradeSkillSkill" .. (i - 1)], "BOTTOMLEFT", 0, 1)
					end
					--increase the width of the rows so the title fits
					for i = 1, 22 do
						skillTitle = _G["TradeSkillSkill"..i]
						skillTitle:SetWidth(335)
					end
					dontexpandanymore = 1
				end

				TradeSkillFrame:HookScript("OnShow", function()
					TradeSkillFrame:SetWidth(765)
					TradeSkillFrame:SetHeight(550)

					TradeSkillDetailScrollFrame:SetHeight(390)
					TradeSkillDetailScrollFrame:SetWidth(350)

					TradeSkillDetailScrollFrame:ClearAllPoints()
					TradeSkillDetailScrollFrame:SetPoint("RIGHT", TradeSkillFrame, 0, -35)
					TradeSkillDetailScrollFrame:SetHeight(390)

					--mouse wheel scroll frame
					_G.TradeSkillListScrollFrame:ClearAllPoints()
					_G.TradeSkillListScrollFrame:SetPoint("LEFT", TradeSkillFrame, "LEFT", 40, 0)
					_G.TradeSkillListScrollFrame:SetHeight(350)
					_G.TradeSkillListScrollFrame:SetWidth(330)

					_G.TradeSkillSkillName:ClearAllPoints()
					_G.TradeSkillSkillName:SetPoint("CENTER", TradeSkillFrame, 200, 150) --main
					_G.TradeSkillSkillName:SetParent(_G.TradeSkillFrame)
					_G.TradeSkillSkillIcon:ClearAllPoints()
					_G.TradeSkillSkillIcon:SetPoint("RIGHT", _G.TradeSkillSkillName, "LEFT", -5, -10)
					_G.TradeSkillSkillIcon:SetParent(_G.TradeSkillFrame)

					_G.TradeSkillRequirementLabel:ClearAllPoints()
					_G.TradeSkillRequirementLabel:SetPoint("BOTTOMLEFT", _G.TradeSkillSkillName, "TOPLEFT", 0, -25)
					_G.TradeSkillRequirementLabel:SetParent(_G.TradeSkillFrame)
					_G.TradeSkillRequirementText:ClearAllPoints()
					_G.TradeSkillRequirementText:SetPoint("LEFT", _G.TradeSkillRequirementLabel,"RIGHT", 5, 0)
					_G.TradeSkillRequirementText:SetParent(_G.TradeSkillFrame)

					if _G.TradeSkillDescription then
						_G.TradeSkillDescription:ClearAllPoints()
						_G.TradeSkillDescription:SetPoint("BOTTOM", _G.TradeSkillRequirementLabel, "TOP", 74, -74)
						_G.TradeSkillDescription:SetParent(_G.TradeSkillFrame)

						_G.TradeSkillReagentLabel:ClearAllPoints()
						_G.TradeSkillReagentLabel:SetPoint("BOTTOM", _G.TradeSkillRequirementLabel, "TOP", -35, -100)
						_G.TradeSkillReagentLabel:SetParent(_G.TradeSkillFrame)
					else
						_G.TradeSkillReagentLabel:ClearAllPoints()
						_G.TradeSkillReagentLabel:SetPoint("BOTTOM", _G.TradeSkillRequirementLabel, "TOP", -35, -45)
						_G.TradeSkillReagentLabel:SetParent(_G.TradeSkillFrame)
					end

					TradeSkillListScrollFrameScrollBar:ClearAllPoints()
					TradeSkillListScrollFrameScrollBar:SetPoint("LEFT", TradeSkillDetailScrollChildFrame, -30, -70)
					TradeSkillListScrollFrameScrollBar:SetHeight(320)

					for i =1, 15 do
						if _G["TradeSkillReagent"..i] then
							_G["TradeSkillReagent"..i]:SetParent(_G.TradeSkillFrame)
						else
							break
						end
					end

					if _G.TradeSkillDetailScrollFrameScrollBar then
						_G.TradeSkillDetailScrollFrameScrollBar:Hide()
					end

					TradeSkillCreateAllButton:ClearAllPoints()
					TradeSkillCreateAllButton:SetPoint("LEFT", TradeSkillFrame, "BOTTOMLEFT", 15, 95)

					TradeSkillCreateButton:ClearAllPoints()
					TradeSkillCreateButton:SetPoint("LEFT", TradeSkillFrame, "BOTTOMLEFT", 180, 95)

					TradeSkillCancelButton:ClearAllPoints()
					TradeSkillCancelButton:SetPoint("RIGHT", TradeSkillFrame, "BOTTOMRIGHT", -50, 95)
				end)
			end
		end)

		--and enchanting which uses a different system apparently
		WideTradeSkillEnchant:RegisterEvent("ADDON_LOADED")
		WideTradeSkillEnchant:SetScript("OnEvent", function(_, _, arg)
			if IsAddOnLoaded("Blizzard_CraftUI") or (arg == "Blizzard_CraftUI") then
				WideTradeSkillEnchant:UnregisterAllEvents()
				local CraftFrame = _G.CraftFrame
				local CraftFrameAvailableFilterCheckButton = _G.CraftFrameAvailableFilterCheckButton
				local CraftFrameFilterDropDown = _G.CraftFrameFilterDropDown
				local CraftCreateButton = _G.CraftCreateButton
				local CraftCancelButton = _G.CraftCancelButton
				local CraftListScrollFrameScrollChildFrame = _G.CraftListScrollFrameScrollChildFrame
				local CraftListScrollFrameScrollBar = _G.CraftListScrollFrameScrollBar
				local CraftDetailScrollFrame = _G.CraftDetailScrollFrame
				local CraftDetailScrollChildFrame = _G.CraftDetailScrollChildFrame
				local CraftDetailScrollFrameScrollBar = _G.CraftDetailScrollFrameScrollBar

				CraftFrame:HookScript("OnShow", function()
					if not CraftFrame.backdrop.shadow then
						CraftFrame.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					end
					CraftFrame:SetWidth(765)
					CraftFrame:SetHeight(550)

					_G.CraftListScrollFrame:ClearAllPoints()
					_G.CraftListScrollFrame:SetPoint("LEFT", CraftFrame, "LEFT", 20, 10)
					_G.CraftListScrollFrame:SetHeight(340)
					_G.CraftListScrollFrame:SetWidth(330)

					CraftListScrollFrameScrollChildFrame:SetHeight(390)
					CraftListScrollFrameScrollChildFrame:SetWidth(350)

					CraftListScrollFrameScrollBar:ClearAllPoints()
					CraftListScrollFrameScrollBar:SetPoint("CENTER", CraftFrame, "CENTER", 10, 12)
					CraftListScrollFrameScrollBar:SetHeight(320)

					CraftDetailScrollChildFrame:ClearAllPoints()
					CraftDetailScrollChildFrame:SetParent(CraftFrame)
					CraftDetailScrollChildFrame:SetPoint("LEFT", CraftListScrollFrameScrollBar, 30, -46)
					CraftDetailScrollChildFrame:SetHeight(390)

					CraftDetailScrollFrame:Hide()
					CraftDetailScrollFrameScrollBar:Hide()
					if E.Wrath or E.TBC then
						CraftFrameFilterDropDown:ClearAllPoints()
						CraftFrameFilterDropDown:SetPoint("TOPRIGHT", CraftDetailScrollChildFrame, 0, 50)
						CraftFrameAvailableFilterCheckButton:ClearAllPoints()
						CraftFrameAvailableFilterCheckButton:SetPoint("TOPLEFT", CraftFrame, 64,-48)
					end

					_G.CraftFramePointsLabel:ClearAllPoints()
					_G.CraftFramePointsLabel:SetPoint("LEFT", _G["CraftCreateButton"], "RIGHT", 5, 0)
					_G.CraftFramePointsText:ClearAllPoints()
					_G.CraftFramePointsText:SetPoint("LEFT", _G.CraftFramePointsLabel, "RIGHT", 5, 0)

					CraftCancelButton:ClearAllPoints()
					CraftCancelButton:SetPoint("RIGHT", CraftFrame, "BOTTOMRIGHT", -50, 95)

					if dontexpandanymoreEnchant == 0 then
						-- Create the additional rows
						--local numCrafts = CRAFTS_DISPLAYED
						local numCrafts = 8
						--CRAFTS_DISPLAYED = CRAFTS_DISPLAYED + 14
						_G.CRAFTS_DISPLAYED = 22
						for i = numCrafts + 1, 22 do
							local craftbutton = CreateFrame("Button", "Craft" .. i, CraftFrame, "CraftButtonTemplate")
							craftbutton:SetID(i)
							craftbutton:Hide()
							craftbutton:ClearAllPoints()
							craftbutton:SetPoint("TOPLEFT", _G["Craft" .. (i - 1)], "BOTTOMLEFT", 0, 1)
						end
						--increase the width of the rows so the title fits
						for i = 1, 8 do
							local craftTitle = _G["Craft"..i]
							craftTitle:Width(335)
						end
						dontexpandanymoreEnchant = 1
					end

					CraftCreateButton:ClearAllPoints()
					CraftCreateButton:SetPoint("LEFT", CraftFrame, "BOTTOMLEFT", 25, 95)
					CraftCancelButton:ClearAllPoints()
					CraftCancelButton:SetPoint("RIGHT", CraftFrame, "BOTTOMRIGHT", -50, 95)
				end)
			end
		end)
	end
end

function ElvUI_EltreumUI:SkinMailZone()
	if E.db.ElvUI_EltreumUI.skins.zones then
		if not IsAddOnLoaded("ElvUI_SLE") then
			--[[hooksecurefunc("SetZoneText", function()
				ZoneTextString:SetFont(E.LSM:Fetch('font', E.db.general.font), 42, E.db.general.fontStyle)
				SubZoneTextString:SetFont(E.LSM:Fetch('font', E.db.general.font), 28, E.db.general.fontStyle)
				PVPInfoTextString:SetFont(E.LSM:Fetch('font', E.db.general.font), 20, E.db.general.fontStyle)
				PVPArenaTextString:SetFont(E.LSM:Fetch('font', E.db.general.font), 20, E.db.general.fontStyle)
			end)]]
			_G.ZoneTextString:SetFont(E.LSM:Fetch('font', E.db.general.font), 42, E.db.general.fontStyle)
			_G.SubZoneTextString:SetFont(E.LSM:Fetch('font', E.db.general.font), 28, E.db.general.fontStyle)
			_G.PVPInfoTextString:SetFont(E.LSM:Fetch('font', E.db.general.font), 20, E.db.general.fontStyle)
			_G.PVPArenaTextString:SetFont(E.LSM:Fetch('font', E.db.general.font), 20, E.db.general.fontStyle)
			_G.OpenMailBodyText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize, E.db.general.fontStyle)
			if E.Retail then
				_G.SendMailBodyEditBox:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize, E.db.general.fontStyle)
			--elseif E.TBC or E.Classic then
				--MailEditBox:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize, E.db.general.fontStyle)
			end
		end
	end
end

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
		S:HandleFrame(_G.MeetingHornMainPanel)
		_G.MeetingHornMainPanel:SetTemplate('Transparent', nil, true)

		if not _G.MeetingHornMainPanel.shadow then
			_G.MeetingHornMainPanel:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
		end

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

		S:HandleScrollBar(_G.MeetingHornMainPanel.Browser.ActivityList.scrollBar)

		--challenge
		S:HandleFrame(_G.MeetingHornMainPanel.Challenge)
		S:HandleButton(_G.MeetingHornMainPanel.Challenge.Body.Reward.Exchange)
		S:HandleButton(_G.MeetingHornMainPanel.Browser.Refresh)

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
		--_G.MeetingHornMainPanel.Manage.Creator.CloseButton.Texture:SetPoint("RIGHT", _G.MeetingHornMainPanel.Manage.Creator.CloseButton, "RIGHT")
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
		--S:HandleFrame(_G.MeetingHornMainPanel.Announcement)
		--S:HandleFrame(_G.MeetingHornMainPanel.Announcement.loading)

		--mission guidance
		S:HandleFrame(_G.MeetingHornMainPanel.MissionGuidance)

		--recent
		S:HandleFrame(_G.MeetingHornMainPanel.Recent)
		S:HandleFrame(_G.MeetingHornMainPanel.Recent.Left)
		S:HandleFrame(_G.MeetingHornMainPanel.Recent.Right)
		S:HandleFrame(_G.MeetingHornMainPanel.Recent.Members)
		S:HandleFrame(_G.MeetingHornMainPanel.Recent.Instance)
		S:HandleButton(_G.MeetingHornMainPanel.Recent.Invite)
		_G.MeetingHornMainPanel.Recent.Invite.RightSeparator:Hide()
		_G.MeetingHornMainPanel.Recent.Invite.LeftSeparator:Hide()

		--quest
		S:HandleFrame(_G.MeetingHornMainPanel.Loading)
		S:HandleFrame(_G.MeetingHornMainPanel.Quest)
		S:HandleFrame(_G.MeetingHornMainPanel.Quest.Body)
		--S:HandleFrame(_G.MeetingHornMainPanel.Quest.Body.Quests)
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

		--main buttons
		S:HandleButton(_G.MeetingHornMainPanel.Browser.RechargeBtn)
		S:HandleButton(_G.MeetingHornMainPanel.Browser.ApplyLeaderBtn)
		--S:HandleDropDownBox(_G.MeetingHornMainPanel.Browser.Activity)
		--S:HandleDropDownBox(_G.MeetingHornMainPanel.Browser.Mode)

		--feedback
		S:HandleFrame(_G.MeetingHornMainPanel.FeedBack.EditBox)
		S:HandleButton(_G.MeetingHornMainPanel.FeedBack.AcceptButton)
		S:HandleButton(_G.MeetingHornMainPanel.FeedBack.CancelButton)

		--portrait
		_G.MeetingHornMainPanelPortraitFrame:Hide()

		--help
		S:HandleFrame(_G.MeetingHornMainPanel.Help)

		--bc the tab names are nil, gotta try to detect it
		local header = _G["MeetingHornMainPanel"]
		for i = 1, header:GetNumChildren() do
			local group = select(i, header:GetChildren())
			if group and group:GetName() == nil then
				if group.HighlightTexture then
					S:HandleTab(group)
					if not group.backdrop.shadow then
						group.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					end
				end
			end
		end

		--idk why but it doesnt seem to skin
		S:HandleScrollBar(_G.MeetingHornMainPanelScrollBar)
	end
end
S:AddCallbackForAddon('MeetingHorn', 'EltruismMeetingHorn', ElvUI_EltreumUI.EltruismMeetingHorn)

--based on old addonskins skin
function ElvUI_EltreumUI:EltruismPallyPower()
	if E.db.ElvUI_EltreumUI.skins.pallypower then
		if InCombatLockdown() then return end

		--from old addonskins
		local PallyPowerBlessingsFrame = _G.PallyPowerBlessingsFrame
		PallyPowerBlessingsFrame:StripTextures()
		PallyPowerBlessingsFrame:SetTemplate('Transparent', nil, true)
		S:HandleCloseButton(_G.PallyPowerBlessingsFrameCloseButton)
		S:HandleButton(_G.PallyPowerBlessingsFrameAutoAssign)
		S:HandleButton(_G.PallyPowerBlessingsFrameClear)
		S:HandleButton(_G.PallyPowerBlessingsFrameRefresh)
		S:HandleButton(_G.PallyPowerBlessingsFrameOptions)
		S:HandleButton(_G.PallyPowerBlessingsFrameReport)
		S:HandleButton(_G.PallyPowerBlessingsFramePreset)
		S:HandleCheckBox(_G.PallyPowerBlessingsFrameFreeAssign)

		--[[_G.L_DropDownList1:StripTextures()
		_G.L_DropDownList1:SetTemplate('Default')
		_G.L_DropDownList2:StripTextures()
		_G.L_DropDownList2:SetTemplate('Default')]]

		_G.PallyPowerAura:SetTemplate("Transparent", nil, true)
		_G.PallyPowerAuraIcon:SetTexCoord(unpack(E.TexCoords))
		if not _G.PallyPowerAura.shadow then
			_G.PallyPowerAura:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
			if _G.PallyPowerAura.shadow then
				_G.PallyPowerAura.shadow:ClearAllPoints()
				_G.PallyPowerAura.shadow:SetPoint("BOTTOMLEFT", _G.PallyPowerAuraIcon,"BOTTOMLEFT", -3, -3)
				_G.PallyPowerAura.shadow:SetPoint("TOPLEFT", _G.PallyPowerAuraIcon,"TOPLEFT", -3, 3)
				_G.PallyPowerAura.shadow:SetPoint("BOTTOMRIGHT", _G.PallyPowerAuraIcon,"BOTTOMRIGHT", 3, -3)
				_G.PallyPowerAura.shadow:SetPoint("TOPRIGHT", _G.PallyPowerAuraIcon,"TOPRIGHT", 3, 3)
				_G.PallyPowerAura.shadow:SetParent(_G.PallyPowerAura)
			end
			E:Delay(0, function()
				if _G.PallyPowerAuraIcon:GetTexture() ~= nil then
					_G.PallyPowerAura.shadow:Show()
				else
					_G.PallyPowerAura.shadow:Hide()
				end
			end)
		end

		_G.PallyPowerAuto:SetTemplate("Transparent", nil, true)
		if not _G.PallyPowerAuto.shadow then
			_G.PallyPowerAuto:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
			if _G.PallyPowerAuto.shadow then
				_G.PallyPowerAuto.shadow:ClearAllPoints()
				_G.PallyPowerAuto.shadow:SetPoint("BOTTOMLEFT", _G.PallyPowerAutoIcon,"BOTTOMLEFT", -3, -3)
				_G.PallyPowerAuto.shadow:SetPoint("TOPLEFT", _G.PallyPowerAutoIcon,"TOPLEFT", -3, 3)
				_G.PallyPowerAuto.shadow:SetPoint("BOTTOMRIGHT", _G.PallyPowerAutoIcon,"BOTTOMRIGHT", 3, -3)
				_G.PallyPowerAuto.shadow:SetPoint("TOPRIGHT", _G.PallyPowerAutoIcon,"TOPRIGHT", 3, 3)
				_G.PallyPowerAuto.shadow:SetParent(_G.PallyPowerAuto)
			end
		end

		_G.PallyPowerRF:SetTemplate("Transparent", nil, true)
		_G.PallyPowerRFIcon:SetTexCoord(unpack(E.TexCoords))
		_G.PallyPowerRFIconSeal:SetTexCoord(unpack(E.TexCoords))

		if not _G.PallyPowerRF.shadow then
			_G.PallyPowerRF:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
			if _G.PallyPowerRF.shadow then
				_G.PallyPowerRF.shadow:ClearAllPoints()
				_G.PallyPowerRF.shadow:SetPoint("BOTTOMLEFT", _G.PallyPowerRFIconSeal,"BOTTOMLEFT", -3, -3)
				_G.PallyPowerRF.shadow:SetPoint("TOPLEFT", _G.PallyPowerRFIconSeal,"TOPLEFT", -3, 3)
				_G.PallyPowerRF.shadow:SetPoint("BOTTOMRIGHT", _G.PallyPowerRFIconSeal,"BOTTOMRIGHT", 3, -3)
				_G.PallyPowerRF.shadow:SetPoint("TOPRIGHT", _G.PallyPowerRFIconSeal,"TOPRIGHT", 3, 3)
				_G.PallyPowerRF.shadow:SetParent(_G.PallyPowerRF)
			end
		end
		--because we need 2 shadows
		if not _G.PallyPowerAnchor.shadow and _G.PallyPowerRFIcon:GetTexture() ~= nil then
			_G.PallyPowerAnchor:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
			if _G.PallyPowerAnchor.shadow then
				_G.PallyPowerAnchor.shadow:ClearAllPoints()
				_G.PallyPowerAnchor.shadow:SetPoint("BOTTOMLEFT", _G.PallyPowerRFIcon,"BOTTOMLEFT", -3, -3)
				_G.PallyPowerAnchor.shadow:SetPoint("TOPLEFT", _G.PallyPowerRFIcon,"TOPLEFT", -3, 3)
				_G.PallyPowerAnchor.shadow:SetPoint("BOTTOMRIGHT", _G.PallyPowerRFIcon,"BOTTOMRIGHT", 3, -3)
				_G.PallyPowerAnchor.shadow:SetPoint("TOPRIGHT", _G.PallyPowerRFIcon,"TOPRIGHT", 3, 3)
				_G.PallyPowerAnchor.shadow:SetParent(_G.PallyPowerRF)
			end
		end

		--hide the double lines
		_G.PallyPowerRF.TopEdge:Kill()
		_G.PallyPowerRF.BottomEdge:Kill()

		--update for new pallypower
		for i = 1, PALLYPOWER_MAXCLASSES do
			local button = PallyPower.classButtons[i]
			button:SetTemplate("Transparent", nil, true)

			--_G[button:GetName().."ClassIcon"]:SetTexCoord(unpack(E.TexCoords))
			_G[button:GetName().."BuffIcon"]:SetTexCoord(unpack(E.TexCoords))
			if not button.shadow then
				button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				button.shadow:ClearAllPoints()
				button.shadow:SetPoint("BOTTOMLEFT", _G[button:GetName().."BuffIcon"],"BOTTOMLEFT", -3, -3)
				button.shadow:SetPoint("TOPLEFT", _G[button:GetName().."BuffIcon"],"TOPLEFT", -3, 3)
				button.shadow:SetPoint("BOTTOMRIGHT", _G[button:GetName().."BuffIcon"],"BOTTOMRIGHT", 3, -3)
				button.shadow:SetPoint("TOPRIGHT", _G[button:GetName().."BuffIcon"],"TOPRIGHT", 3, 3)
				button.shadow:SetParent(button)
			end

			for j = 1, PALLYPOWER_MAXPERCLASS do
				PallyPower.playerButtons[i][j]:SetTemplate("Transparent", nil, true)
			end
		end

		for i = 1, PALLYPOWER_MAXCLASSES do
			for j = 1, 8 do
				if _G["PallyPowerBlessingsFramePlayer"..j.."Class"..i.."Icon"] then
					_G["PallyPowerBlessingsFramePlayer"..j.."Class"..i.."Icon"]:SetTexCoord(unpack(E.TexCoords))
					if not _G["PallyPowerBlessingsFramePlayer"..j.."Class"..i].shadow then
						_G["PallyPowerBlessingsFramePlayer"..j.."Class"..i]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						_G["PallyPowerBlessingsFramePlayer"..j.."Class"..i].shadow:ClearAllPoints()
						_G["PallyPowerBlessingsFramePlayer"..j.."Class"..i].shadow:SetPoint("BOTTOMLEFT", _G["PallyPowerBlessingsFramePlayer"..j.."Class"..i.."Icon"],"BOTTOMLEFT", -3, -3)
						_G["PallyPowerBlessingsFramePlayer"..j.."Class"..i].shadow:SetPoint("BOTTOMRIGHT", _G["PallyPowerBlessingsFramePlayer"..j.."Class"..i.."Icon"],"BOTTOMRIGHT", 3, -3)
						_G["PallyPowerBlessingsFramePlayer"..j.."Class"..i].shadow:SetPoint("TOPLEFT", _G["PallyPowerBlessingsFramePlayer"..j.."Class"..i.."Icon"],"TOPLEFT", -3, 3)
						_G["PallyPowerBlessingsFramePlayer"..j.."Class"..i].shadow:SetPoint("TOPRIGHT", _G["PallyPowerBlessingsFramePlayer"..j.."Class"..i.."Icon"],"TOPRIGHT", 3, 3)
						if _G["PallyPowerBlessingsFramePlayer"..j.."Class"..i.."Icon"]:GetTexture() ~= nil then
							_G["PallyPowerBlessingsFramePlayer"..j.."Class"..i].shadow:Show()
						else
							_G["PallyPowerBlessingsFramePlayer"..j.."Class"..i].shadow:Hide()
						end
					end
					_G["PallyPowerBlessingsFramePlayer"..j.."Class"..i]:HookScript("OnClick", function()
						E:Delay(0, function()
							if _G["PallyPowerBlessingsFramePlayer"..j.."Class"..i.."Icon"]:GetTexture() ~= nil then
								_G["PallyPowerBlessingsFramePlayer"..j.."Class"..i].shadow:Show()
							else
								_G["PallyPowerBlessingsFramePlayer"..j.."Class"..i].shadow:Hide()
							end
						end)
					end)
				end
				if _G["PallyPowerBlessingsFramePlayer"..j.."Icon"..i] then
					_G["PallyPowerBlessingsFramePlayer"..j.."Icon"..i]:SetTexCoord(unpack(E.TexCoords))
				end
				if _G["PallyPowerBlessingsFramePlayer"..j.."AIcon"..i] then
					_G["PallyPowerBlessingsFramePlayer"..j.."AIcon"..i]:SetTexCoord(unpack(E.TexCoords))
				end
				if _G["PallyPowerBlessingsFramePlayer"..j.."CIcon"..i] then
					_G["PallyPowerBlessingsFramePlayer"..j.."CIcon"..i]:SetTexCoord(unpack(E.TexCoords))
				end
			end
		end

		for i = 1, PALLYPOWER_MAXCLASSES do
			if _G["PallyPowerBlessingsFrameAuraGroup"..i.."AuraHeaderIcon"] then
				_G["PallyPowerBlessingsFrameAuraGroup"..i.."AuraHeaderIcon"]:SetTexCoord(unpack(E.TexCoords))
				if not _G["PallyPowerBlessingsFrameAuraGroup"..i.."AuraHeader"].shadow then
					_G["PallyPowerBlessingsFrameAuraGroup"..i.."AuraHeader"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					_G["PallyPowerBlessingsFrameAuraGroup"..i.."AuraHeader"].shadow:ClearAllPoints()
					_G["PallyPowerBlessingsFrameAuraGroup"..i.."AuraHeader"].shadow:SetPoint("BOTTOMLEFT", _G["PallyPowerBlessingsFrameAuraGroup"..i.."AuraHeaderIcon"],"BOTTOMLEFT", -3, -3)
					_G["PallyPowerBlessingsFrameAuraGroup"..i.."AuraHeader"].shadow:SetPoint("TOPLEFT", _G["PallyPowerBlessingsFrameAuraGroup"..i.."AuraHeaderIcon"],"TOPLEFT", -3, 3)
					_G["PallyPowerBlessingsFrameAuraGroup"..i.."AuraHeader"].shadow:SetPoint("BOTTOMRIGHT", _G["PallyPowerBlessingsFrameAuraGroup"..i.."AuraHeaderIcon"],"BOTTOMRIGHT", 3, -3)
					_G["PallyPowerBlessingsFrameAuraGroup"..i.."AuraHeader"].shadow:SetPoint("TOPRIGHT", _G["PallyPowerBlessingsFrameAuraGroup"..i.."AuraHeaderIcon"],"TOPRIGHT", 3, 3)
					_G["PallyPowerBlessingsFrameAuraGroup"..i.."AuraHeader"].shadow:SetParent(_G["PallyPowerBlessingsFrameAuraGroup"..i.."AuraHeader"])
				end
			end

			for j = 1, 8 do
				if _G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i.."Icon"] then
					_G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i.."Icon"]:SetTexCoord(unpack(E.TexCoords))
					if not _G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i].shadow then
						if _G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i.."Icon"]:GetTexture() ~= nil then
							_G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i].shadow:ClearAllPoints()
							_G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i].shadow:SetPoint("BOTTOMLEFT", _G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i.."Icon"],"BOTTOMLEFT", -3, -3)
							_G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i].shadow:SetPoint("TOPLEFT", _G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i.."Icon"],"TOPLEFT", -3, 3)
							_G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i].shadow:SetPoint("BOTTOMRIGHT", _G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i.."Icon"],"BOTTOMRIGHT", 3, -3)
							_G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i].shadow:SetPoint("TOPRIGHT", _G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i.."Icon"],"TOPRIGHT", 3, 3)
							_G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i].shadow:SetParent(_G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i])
						end
					end
					_G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i]:HookScript("OnClick", function()
						E:Delay(0, function()
							if _G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i.."Icon"]:GetTexture() ~= nil then
								_G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i].shadow:Show()
								if _G.PallyPowerAura.shadow then
									_G.PallyPowerAura.shadow:Show()
								end
							else
								_G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i].shadow:Hide()
								if _G.PallyPowerAura.shadow then
									_G.PallyPowerAura.shadow:Hide()
								end
							end
						end)
					end)
				end
			end
		end

		--add shadow
		if not PallyPowerBlessingsFrame.shadow then
			PallyPowerBlessingsFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
		end

		--better point
		_G.PallyPowerAnchor:ClearAllPoints()
		_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerAura, "TOPLEFT",-10,10)
		_G.PallyPowerAnchor:SetFrameLevel(10)

		--shadow update function
		local function UpdateShadows()
			if InCombatLockdown() then return end
			if not _G.PallyPowerFrame.shadow then
				_G.PallyPowerFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				_G.PallyPowerFrame.shadow:SetParent(_G.PallyPowerC1)
			end
			if _G.PallyPowerFrame.shadow then
				if _G.PallyPowerC1 and _G.PallyPowerC1:IsShown() then
					_G.PallyPowerFrame.shadow:ClearAllPoints()
					if _G.PallyPowerAura and _G.PallyPowerAura:IsShown() then
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAura, "TOPLEFT",-3,3)
					elseif _G.PallyPowerRF and _G.PallyPowerRF:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-3,3)
					elseif _G.PallyPowerAuto and _G.PallyPowerAuto:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-3,3)
					else
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-3,3)
					end
					_G.PallyPowerFrame.shadow:SetPoint("BOTTOMRIGHT", _G.PallyPowerC1, "BOTTOMRIGHT",3,-3)
				end
				if _G.PallyPowerC2 and _G.PallyPowerC2:IsShown() then
					_G.PallyPowerFrame.shadow:ClearAllPoints()
					if _G.PallyPowerAura and _G.PallyPowerAura:IsShown() then
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAura, "TOPLEFT",-3,3)
					elseif _G.PallyPowerRF and _G.PallyPowerRF:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-3,3)
					elseif _G.PallyPowerAuto and _G.PallyPowerAuto:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-3,3)
					else
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-3,3)
					end
					_G.PallyPowerFrame.shadow:SetPoint("BOTTOMRIGHT", _G.PallyPowerC2, "BOTTOMRIGHT",3,-3)
				end
				if _G.PallyPowerC3 and _G.PallyPowerC3:IsShown() then
					_G.PallyPowerFrame.shadow:ClearAllPoints()
					if _G.PallyPowerAura and _G.PallyPowerAura:IsShown() then
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAura, "TOPLEFT",-3,3)
					elseif _G.PallyPowerRF and _G.PallyPowerRF:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-3,3)
					elseif _G.PallyPowerAuto and _G.PallyPowerAuto:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-3,3)
					else
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-3,3)
					end
					_G.PallyPowerFrame.shadow:SetPoint("BOTTOMRIGHT", _G.PallyPowerC3, "BOTTOMRIGHT",3,-3)
				end
				if _G.PallyPowerC4 and _G.PallyPowerC4:IsShown() then
					_G.PallyPowerFrame.shadow:ClearAllPoints()
					if _G.PallyPowerAura and _G.PallyPowerAura:IsShown() then
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAura, "TOPLEFT",-3,3)
					elseif _G.PallyPowerRF and _G.PallyPowerRF:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-3,3)
					elseif _G.PallyPowerAuto and _G.PallyPowerAuto:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-3,3)
					else
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-3,3)
					end
					_G.PallyPowerFrame.shadow:SetPoint("BOTTOMRIGHT", _G.PallyPowerC4, "BOTTOMRIGHT",3,-3)
				end
				if _G.PallyPowerC5 and _G.PallyPowerC5:IsShown() then
					_G.PallyPowerFrame.shadow:ClearAllPoints()
					if _G.PallyPowerAura and _G.PallyPowerAura:IsShown() then
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAura, "TOPLEFT",-3,3)
					elseif _G.PallyPowerRF and _G.PallyPowerRF:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-3,3)
					elseif _G.PallyPowerAuto and _G.PallyPowerAuto:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-3,3)
					else
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-3,3)
					end
					_G.PallyPowerFrame.shadow:SetPoint("BOTTOMRIGHT", _G.PallyPowerC5, "BOTTOMRIGHT",3,-3)
				end
				if _G.PallyPowerC6 and _G.PallyPowerC6:IsShown() then
					_G.PallyPowerFrame.shadow:ClearAllPoints()
					if _G.PallyPowerAura and _G.PallyPowerAura:IsShown() then
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAura, "TOPLEFT",-3,3)
					elseif _G.PallyPowerRF and _G.PallyPowerRF:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-3,3)
					elseif _G.PallyPowerAuto and _G.PallyPowerAuto:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-3,3)
					else
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-3,3)
					end
					_G.PallyPowerFrame.shadow:SetPoint("BOTTOMRIGHT", _G.PallyPowerC6, "BOTTOMRIGHT",3,-3)
				end
				if _G.PallyPowerC7 and _G.PallyPowerC7:IsShown() then
					_G.PallyPowerFrame.shadow:ClearAllPoints()
					if _G.PallyPowerAura and _G.PallyPowerAura:IsShown() then
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAura, "TOPLEFT",-3,3)
					elseif _G.PallyPowerRF and _G.PallyPowerRF:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-3,3)
					elseif _G.PallyPowerAuto and _G.PallyPowerAuto:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-3,3)
					else
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-3,3)
					end
					_G.PallyPowerFrame.shadow:SetPoint("BOTTOMRIGHT", _G.PallyPowerC7, "BOTTOMRIGHT",3,-3)
				end
				if _G.PallyPowerC8 and _G.PallyPowerC8:IsShown() then
					_G.PallyPowerFrame.shadow:ClearAllPoints()
					if _G.PallyPowerAura and _G.PallyPowerAura:IsShown() then
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAura, "TOPLEFT",-3,3)
					elseif _G.PallyPowerRF and _G.PallyPowerRF:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-3,3)
					elseif _G.PallyPowerAuto and _G.PallyPowerAuto:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-3,3)
					else
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-3,3)
					end
					_G.PallyPowerFrame.shadow:SetPoint("BOTTOMRIGHT", _G.PallyPowerC8, "BOTTOMRIGHT",3,-3)
				end
				if _G.PallyPowerC9 and _G.PallyPowerC9:IsShown() then
					_G.PallyPowerFrame.shadow:ClearAllPoints()
					if _G.PallyPowerAura and _G.PallyPowerAura:IsShown() then
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAura, "TOPLEFT",-3,3)
					elseif _G.PallyPowerRF and _G.PallyPowerRF:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-3,3)
					elseif _G.PallyPowerAuto and _G.PallyPowerAuto:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-3,3)
					else
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-3,3)
					end
					_G.PallyPowerFrame.shadow:SetPoint("BOTTOMRIGHT", _G.PallyPowerC9, "BOTTOMRIGHT",3,-3)
				end
				if _G.PallyPowerC10 and _G.PallyPowerC10:IsShown() then
					_G.PallyPowerFrame.shadow:ClearAllPoints()
					if _G.PallyPowerAura and _G.PallyPowerAura:IsShown() then
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAura, "TOPLEFT",-3,3)
					elseif _G.PallyPowerRF and _G.PallyPowerRF:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-3,3)
					elseif _G.PallyPowerAuto and _G.PallyPowerAuto:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-3,3)
					else
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-3,3)
					end
					_G.PallyPowerFrame.shadow:SetPoint("BOTTOMRIGHT", _G.PallyPowerC10, "BOTTOMRIGHT",3,-3)
				end
			end
		end

		--main shadow
		local shadowupdate = CreateFrame("FRAME")
		shadowupdate:RegisterEvent("GROUP_ROSTER_UPDATE")
		shadowupdate:RegisterEvent("GROUP_JOINED")
		shadowupdate:RegisterEvent("PLAYER_ENTERING_WORLD")
		shadowupdate:RegisterEvent("ZONE_CHANGED")
		shadowupdate:RegisterEvent("ZONE_CHANGED_INDOORS")
		shadowupdate:RegisterEvent("ZONE_CHANGED_NEW_AREA")
		shadowupdate:SetScript("OnEvent",function()
			UpdateShadows()
		end)

		if _G.PallyPowerC10 then
			_G.PallyPowerC10:HookScript("OnShow", function()
				UpdateShadows()
			end)
		end

		local function toggle()
			for i = 1, PALLYPOWER_MAXCLASSES do
				for j = 1, 8 do
					if _G["PallyPowerBlessingsFramePlayer"..j.."Class"..i].shadow then
						E:Delay(0, function()
							if _G["PallyPowerBlessingsFramePlayer"..j.."Class"..i.."Icon"]:GetTexture() ~= nil then
								_G["PallyPowerBlessingsFramePlayer"..j.."Class"..i].shadow:Show()
							else
								_G["PallyPowerBlessingsFramePlayer"..j.."Class"..i].shadow:Hide()
							end
						end)
					end
					if _G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i] and _G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i].shadow then
						E:Delay(0, function()
							if _G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i.."Icon"]:GetTexture() ~= nil then
								_G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i].shadow:Show()
							else
								_G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i].shadow:Hide()
							end
						end)
					end
				end
			end
		end

		_G.PallyPowerBlessingsFrame:HookScript("OnShow", function()
			toggle()
		end)

		_G.PallyPowerBlessingsFrameClear:HookScript("OnClick", function()
			toggle()
		end)

		_G.PallyPowerBlessingsFrameAutoAssign:HookScript("OnClick", function()
			toggle()
		end)

		--crop icon
		if _G["PallyPowerAutoIcon"] then
			_G["PallyPowerAutoIcon"]:SetTexCoord(unpack(E.TexCoords))
		end



		--change toggle texture
		_G.PallyPowerAnchor:GetNormalTexture():SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\circle_mask")
		_G.PallyPowerAnchor:GetNormalTexture():SetVertexColor(0,1,0)
		_G.PallyPowerAnchor:GetCheckedTexture():SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\circle_mask")
		_G.PallyPowerAnchor:GetCheckedTexture():SetVertexColor(1,0,0)

		--use new icons
		if E.db.ElvUI_EltreumUI.skins.classiconsreleaf then
			PallyPower.ClassIcons = PallyPower.isWrath and {
				[1] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Warrior1.tga",
				[2] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Rogue1.tga",
				[3] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Priest1.tga",
				[4] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Druid1.tga",
				[5] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Paladin1.tga",
				[6] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Hunter1.tga",
				[7] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Mage1.tga",
				[8] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Warlock1.tga",
				[9] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Shaman1.tga",
				[10] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DeathKnight1.tga",
			} or PallyPower.isBCC and {
				[1] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Warrior1.tga",
				[2] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Rogue1.tga",
				[3] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Priest1.tga",
				[4] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Druid1.tga",
				[5] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Paladin1.tga",
				[6] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Hunter1.tga",
				[7] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Mage1.tga",
				[8] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Warlock1.tga",
				[9] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Shaman1.tga",
			} or {
				[1] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Warrior1.tga",
				[2] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Rogue1.tga",
				[3] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Priest1.tga",
				[4] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Druid1.tga",
				[5] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Paladin1.tga",
				[6] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Hunter1.tga",
				[7] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Mage1.tga",
				[8] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Warlock1.tga",
				[9] = "Interface\\Icons\\Ability_Mount_JungleTiger"
			}
		else
			PallyPower.ClassIcons = PallyPower.isWrath and {
				[1] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarriorShadow.tga",
				[2] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\RogueShadow.tga",
				[3] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PriestShadow.tga",
				[4] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DruidShadow.tga",
				[5] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PaladinShadow.tga",
				[6] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\HunterShadow.tga",
				[7] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MageShadow.tga",
				[8] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarlockShadow.tga",
				[9] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\ShamanShadow.tga",
				[10] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DeathKnightShadow.tga",
			} or PallyPower.isBCC and {
				[1] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarriorShadow.tga",
				[2] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\RogueShadow.tga",
				[3] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PriestShadow.tga",
				[4] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DruidShadow.tga",
				[5] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PaladinShadow.tga",
				[6] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\HunterShadow.tga",
				[7] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MageShadow.tga",
				[8] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarlockShadow.tga",
				[9] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\ShamanShadow.tga",
			} or {
				[1] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarriorShadow.tga",
				[2] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\RogueShadow.tga",
				[3] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PriestShadow.tga",
				[4] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DruidShadow.tga",
				[5] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PaladinShadow.tga",
				[6] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\HunterShadow.tga",
				[7] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MageShadow.tga",
				[8] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarlockShadow.tga",
				[9] = "Interface\\Icons\\Ability_Mount_JungleTiger"
			}
		end
	end
end
S:AddCallbackForAddon('PallyPower', 'EltruismPallyPower', ElvUI_EltreumUI.EltruismPallyPower)

--gradient bigwigs bars
function ElvUI_EltreumUI:EltruismBigWigs()
	if E.db.ElvUI_EltreumUI.skins.bigwigs then
		local candy = _G.LibStub("LibCandyBar-3.0")
		function candy.barPrototype:SetColor(...)
			self.candyBarBar:SetStatusBarColor(...)
			local r,g,b = self.candyBarBar:GetStatusBarColor()
			self.candyBarBar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, r-0.4, g-0.4, b-0.4, 0.7, r, g, b, 0.7)
			if not self.candyBarBar.shadow then
				self.candyBarBar:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
			end
		end
	end
end
S:AddCallbackForAddon('BigWigs_Plugins', "EltruismBigWigs", ElvUI_EltreumUI.EltruismBigWigs)

local classes = {
	["WARRIOR"] = true,
	["PALADIN"] = true,
	["HUNTER"] = true,
	["MONK"] = true,
	["ROGUE"] = true,
	["PRIEST"] = true,
	["DEATHKNIGHT"] = true,
	["SHAMAN"] = true,
	["MAGE"] = true,
	["WARLOCK"] = true,
	["DRUID"] = true,
	["DEMONHUNTER"] = true,
	["EVOKER"] = true
}

--Details gradient, inspired by aftermathh's edit but had to delve deeper into it, too many things going on there
function ElvUI_EltreumUI:EltruismDetails()
	if E.db.ElvUI_EltreumUI.skins.details then
		local Details = _G.Details
		local unitclass
		hooksecurefunc(Details, "InstanceRefreshRows", function(instancia, test,test2,test3,test4)
			if instancia.barras and instancia.barras[1] then
				for _, row in next, instancia.barras do
					if row and row.textura then
						hooksecurefunc(row.textura, "SetVertexColor", function(_, r, g, b) --managed to hook the global to set vertex color on this only, might be useful later
							if E.db.ElvUI_EltreumUI.skins.detailstextureoverwrite then
								row.textura:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum7pixelB")
							end
							if row.minha_tabela and row.minha_tabela.name then
								unitclass = row.minha_tabela:class() --from details api returns class of that row
								if unitclass ~='UNKNOW' and classes[unitclass] then
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
										row.textura:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsDetailsCustom(unitclass))
									else
										row.textura:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsDetails(unitclass))
									end
								else
									row.textura:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, r-0.5, g-0.5, b-0.5, 0.9, r+0.2, g+0.2, b+0.2, 0.9)
								end
							else
								row.textura:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, r-0.5, g-0.5, b-0.5, 0.9, r+0.2, g+0.2, b+0.2, 0.9)
							end
						end)
					end
				end
			end
		end)
	end
end
S:AddCallbackForAddon('Details', "EltruismDetails", ElvUI_EltreumUI.EltruismDetails)

--add cardinal directions to minimap
local Cardinals = CreateFrame("FRAME", "Eltruism Cardinal Directions")
Cardinals:SetParent(Minimap)
function ElvUI_EltreumUI:MinimapCardinalDirections()
	if C_CVar.GetCVar("rotateMinimap") == "1" then return end
	if E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.enable then
		if not Cardinals.N then
			Cardinals.N = Cardinals:CreateFontString("EltruismNorth", "ARTWORK", "GameFontNormal")
		end
		Cardinals.N:SetText("N")
		if not Cardinals.E then
			Cardinals.E = Cardinals:CreateFontString("EltruismEast", "ARTWORK", "GameFontNormal")
		end
		Cardinals.E:SetText("E")
		if not Cardinals.S then
			Cardinals.S = Cardinals:CreateFontString("EltruismSouth", "ARTWORK", "GameFontNormal")
		end
		Cardinals.S:SetText("S")
		if not Cardinals.W then
			Cardinals.W = Cardinals:CreateFontString("EltruismWest", "ARTWORK", "GameFontNormal")
		end
		Cardinals.W:SetText("W")

		Cardinals.N:SetPoint("BOTTOM", Minimap, "TOP", 0, -E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.offset)
		Cardinals.E:SetPoint("LEFT", Minimap, "RIGHT", -E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.offset, 0)
		Cardinals.S:SetPoint("TOP", Minimap, "BOTTOM", 0, E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.offset)
		Cardinals.W:SetPoint("RIGHT", Minimap, "LEFT", E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.offset, 0)

		Cardinals.N:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.fontsize, E.db.general.fontStyle)
		Cardinals.E:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.fontsize, E.db.general.fontStyle)
		Cardinals.S:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.fontsize, E.db.general.fontStyle)
		Cardinals.W:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.fontsize, E.db.general.fontStyle)

		if E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.classcolor then
			Cardinals.N:SetTextColor(classcolor.r,classcolor.g,classcolor.b)
			Cardinals.E:SetTextColor(classcolor.r,classcolor.g,classcolor.b)
			Cardinals.S:SetTextColor(classcolor.r,classcolor.g,classcolor.b)
			Cardinals.W:SetTextColor(classcolor.r,classcolor.g,classcolor.b)
		else
			Cardinals.N:SetTextColor(E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.r,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.g,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.b)
			Cardinals.E:SetTextColor(E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.r,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.g,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.b)
			Cardinals.S:SetTextColor(E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.r,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.g,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.b)
			Cardinals.W:SetTextColor(E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.r,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.g,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.b)
		end
	else
		if Cardinals.N then
			Cardinals.N:SetText("")
		end
		if Cardinals.E then
			Cardinals.E:SetText("")
		end
		if Cardinals.S then
			Cardinals.S:SetText("")
		end
		if Cardinals.W then
			Cardinals.W:SetText("")
		end
	end
end
