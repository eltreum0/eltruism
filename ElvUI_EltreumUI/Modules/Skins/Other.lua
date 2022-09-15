local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local S = E:GetModule('Skins')
local _G = _G
local CreateFrame = _G.CreateFrame
local WideTradeSkill = CreateFrame("Frame")
local WideTradeSkillEnchant = CreateFrame("Frame")
local dontexpandanymoreEnchant = 0
local dontexpandanymore = 0
local skillbutton
local skillTitle


--test elvui backdrop transparency
--[[function E:UpdateBackdropColors()
	local r, g, b = unpack(E.media.backdropcolor)
	local r2, g2, b2, a2 = unpack(E.media.backdropfadecolor)

	for frame in pairs(E.frames) do
		if frame and frame.template and not frame:IsForbidden() then
			if not frame.ignoreUpdates then
				if frame.callbackBackdropColor then
					frame:callbackBackdropColor()
				elseif frame.template == 'Default' then
					frame:SetBackdropColor(r, g, b, a2)
				elseif frame.template == 'Transparent' then
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

function ElvUI_EltreumUI:SkinProfessions()
	if E.db.ElvUI_EltreumUI.skins.professions and not E.private.skins.blizzard.enable == false then
		--skin and expand the tradeskills

		WideTradeSkill:RegisterEvent("ADDON_LOADED")
		WideTradeSkill:SetScript("OnEvent", function(_, _, arg)
			if (arg == "Blizzard_TradeSkillUI") or (arg == "Blizzard_RuneforgeUI") then
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

					if not TradeSkillFrame.backdrop.shadow then
						TradeSkillFrame.backdrop:CreateShadow()
					end
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
		if IsAddOnLoaded("TradeSkillMaster") then
			local CraftFrame = _G.CraftFrame
			_G.CraftFrame:HookScript("OnShow", function()
				local CraftFrameAvailableFilterCheckButton = _G.CraftFrameAvailableFilterCheckButton
				local CraftFrameFilterDropDown = _G.CraftFrameFilterDropDown
				local CraftCreateButton = _G.CraftCreateButton
				local CraftCancelButton = _G.CraftCancelButton
				local CraftListScrollFrameScrollChildFrame = _G.CraftListScrollFrameScrollChildFrame
				local CraftListScrollFrameScrollBar = _G.CraftListScrollFrameScrollBar
				local CraftDetailScrollFrame = _G.CraftDetailScrollFrame
				local CraftDetailScrollChildFrame = _G.CraftDetailScrollChildFrame
				local CraftDetailScrollFrameScrollBar = _G.CraftDetailScrollFrameScrollBar

				if not CraftFrame.backdrop.shadow then
					CraftFrame.backdrop:CreateShadow()
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
				E:Delay(0, function()
					CraftCreateButton:ClearAllPoints()
					CraftCreateButton:SetPoint("LEFT", CraftFrame, "BOTTOMLEFT", 25, 95)
				end)
				CraftCancelButton:ClearAllPoints()
				CraftCancelButton:SetPoint("RIGHT", CraftFrame, "BOTTOMRIGHT", -50, 95)

			end)
		else
			WideTradeSkillEnchant:RegisterEvent("ADDON_LOADED")
			WideTradeSkillEnchant:SetScript("OnEvent", function(_, _, arg)
				if (arg == "Blizzard_CraftUI") then
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
							CraftFrame.backdrop:CreateShadow()
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

--skin meeting horn addon
local function SkinMeetingHorn()
	if E.db.ElvUI_EltreumUI.skins.meetinghorn then
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
		--S:HandleFrame(_G.MeetingHornMainPanel.Browser.Header7)
		--S:HandleFrame(_G.MeetingHornMainPanel.Browser.Header8)
		S:HandleEditBox(_G.MeetingHornMainPanel.Browser.Input)
		S:HandleButton(_G.MeetingHornMainPanel.Browser.Refresh)
		S:HandleButton(_G.MeetingHornMainPanel.Browser.Reset)
		--S:HandleButton(_G.MeetingHornMainPanel.Browser.RechargeBtn)
		--S:HandleButton(_G.MeetingHornMainPanel.Browser.ApplyLeaderBtn)
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
		--S:HandleButton(_G.MeetingHornMainPanel.Manage.Creator.RecruitButton)
		S:HandleButton(_G.MeetingHornMainPanel.Manage.Creator.CloseButton)
		--_G.MeetingHornMainPanel.Manage.Creator.CloseButton.Texture:SetPoint("RIGHT", _G.MeetingHornMainPanel.Manage.Creator.CloseButton, "RIGHT")
		S:HandleFrame(_G.MeetingHornMainPanel.Manage.Chat)
		S:HandleFrame(_G.MeetingHornMainPanel.Manage.Chat.ChatFrame)
		_G.MeetingHornMainPanel.Manage.Chat.ChatBg:Hide()
		--_G.MeetingHornMainPanel.Manage.Creator.RecruitButton.RightSeparator:Hide()
		--_G.MeetingHornMainPanel.Manage.Creator.CreateButton.RightSeparator:Hide()
		_G.MeetingHornMainPanel.Manage.Creator.CloseButton.Texture:Hide()

		--leader
		S:HandleFrame(_G.MeetingHornMainPanel.GoodLeader)
		S:HandleFrame(_G.MeetingHornMainPanel.GoodLeader.First)
		S:HandleFrame(_G.MeetingHornMainPanel.GoodLeader.First.Footer)
		S:HandleFrame(_G.MeetingHornMainPanel.GoodLeader.First.Header)
		--S:HandleButton(_G.MeetingHornMainPanel.GoodLeader.First.Header.ApplyLeaderBtn)

		--announcement
		--S:HandleFrame(_G.MeetingHornMainPanel.Announcement)
		--S:HandleFrame(_G.MeetingHornMainPanel.Announcement.loading)

		--mission guidance
		--S:HandleFrame(_G.MeetingHornMainPanel.MissionGuidance)

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
		--S:HandleFrame(_G.MeetingHornMainPanel.Quest)
		--S:HandleFrame(_G.MeetingHornMainPanel.Quest.Body)
		--S:HandleFrame(_G.MeetingHornMainPanel.Quest.Body.Quests)
		--S:HandleButton(_G.MeetingHornMainPanel.Quest.Body.Refresh)
		--S:HandleScrollBar(_G.MeetingHornMainPanel.Quest.Body.Quests.scrollBar)
		--S:HandleFrame(_G.MeetingHornMainPanel.Quest.Summary)

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
end

local handlemeetinghorn = CreateFrame("FRAME")
handlemeetinghorn:RegisterEvent("ADDON_LOADED")
handlemeetinghorn:SetScript("OnEvent", function(_, _, arg)
	if GetAddOnEnableState(nil, "MeetingHorn") == 0 then
		handlemeetinghorn:UnregisterAllEvents()
	end
	if (arg == "MeetingHorn") or IsAddOnLoaded("MeetingHorn") then
		_G['MeetingHornMainPanel']:HookScript("OnShow", function(self)
			if not self.meetskinnedonshow then
				self.meetskinnedonshow = true
				SkinMeetingHorn()
				handlemeetinghorn:UnregisterAllEvents()
			end
		end)
	end
end)

local meetinghornmightalreadybeloaded = CreateFrame("FRAME")
meetinghornmightalreadybeloaded:RegisterEvent("PLAYER_STARTED_MOVING")
meetinghornmightalreadybeloaded:SetScript("OnEvent", function()
	meetinghornmightalreadybeloaded:UnregisterAllEvents()
	if IsAddOnLoaded('MeetingHorn') then
		SkinMeetingHorn()
	end
end)

--[[
-- EXAMPLE:
--- S:AddCallbackForAddon('Details', 'MyAddon_Details', MyAddon.SkinDetails)
---- arg1: Addon name (same as the toc): MyAddon.toc (without extension)
---- arg2: Given name (try to use something that won't be used by someone else)
---- arg3: load function (preferably not-local)
-- this is used for loading skins that should be executed when the addon loads (including blizzard addons that load later).
-- please add a given name, non-given-name is specific for elvui core addon.
function S:AddCallbackForAddon(addonName, name, func, forceLoad, bypass, position) -- arg2: name is 'given name' see example above.
	local load = (type(name) == 'function' and name) or (not func and (S[name] or S[addonName]))
	S:RegisterSkin(addonName, load or func, forceLoad, bypass, position)
end

]]

--based on old addonskins skin
function S:PallyPower()
	--if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.taxi) then return end

	--from old addonskins
	local PallyPowerBlessingsFrame = _G.PallyPowerBlessingsFrame
	PallyPowerBlessingsFrame:StripTextures()
	PallyPowerBlessingsFrame:SetTemplate('Transparent', nil, true)
	S:HandleCloseButton(_G.PallyPowerBlessingsFrameCloseButton)
	S:HandleButton(_G.PallyPowerBlessingsFrameAutoAssign)
	S:HandleButton(_G.PallyPowerBlessingsFrameClear)
	S:HandleButton(_G.PallyPowerBlessingsFrameRefresh)
	S:HandleCheckBox(_G.PallyPowerBlessingsFrameFreeAssign)

	_G.PallyPowerAura:SetTemplate("Transparent", nil, true)
	_G.PallyPowerAuto:SetTemplate("Transparent", nil, true)
	_G.PallyPowerRF:SetTemplate("Transparent", nil, true)

	--update for new pallypower
	for i = 1, PALLYPOWER_MAXCLASSES do
		local button = PallyPower.classButtons[i]
		button:SetTemplate("Transparent", nil, true)

		_G[button:GetName().."ClassIcon"]:SetTexCoord(unpack(E.TexCoords))
		_G[button:GetName().."BuffIcon"]:SetTexCoord(unpack(E.TexCoords))

		for j = 1, PALLYPOWER_MAXPERCLASS do
			PallyPower.playerButtons[i][j]:SetTemplate("Transparent", nil, true)
		end
	end

	for i = 1, PALLYPOWER_MAXCLASSES do
		for j = 1, 8 do
			if _G["PallyPowerBlessingsFramePlayer"..j.."Class"..i.."Icon"] then
				_G["PallyPowerBlessingsFramePlayer"..j.."Class"..i.."Icon"]:SetTexCoord(unpack(E.TexCoords))
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
		end

		for j = 1, 8 do
			if _G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i.."Icon"] then
				_G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i.."Icon"]:SetTexCoord(unpack(E.TexCoords))
			end
		end
	end

	--add shadow
	if not PallyPowerBlessingsFrame.shadow then
		PallyPowerBlessingsFrame:CreateShadow()
	end

	--crop icon
	if _G["PallyPowerAutoIcon"] then
		_G["PallyPowerAutoIcon"]:SetTexCoord(unpack(E.TexCoords))
	end

	--better point
	_G.PallyPowerAnchor:ClearAllPoints()
	_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerAura, "TOPLEFT",-10,10)

	--change toggle texture
	_G.PallyPowerAnchor:GetNormalTexture():SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\circle_mask")
	_G.PallyPowerAnchor:GetNormalTexture():SetVertexColor(0,1,0)
	_G.PallyPowerAnchor:GetCheckedTexture():SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\circle_mask")
	_G.PallyPowerAnchor:GetCheckedTexture():SetVertexColor(1,0,0)

	--use new icons
	PallyPower.ClassIcons = PallyPower.isWrath and {
		[1] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Warrior.tga",
		[2] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Rogue.tga",
		[3] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Priest.tga",
		[4] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Druid.tga",
		[5] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Paladin.tga",
		[6] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Hunter.tga",
		[7] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Mage.tga",
		[8] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Warlock.tga",
		[9] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Shaman.tga",
		[10] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DeathKnight.tga",
	} or PallyPower.isBCC and {
		[1] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Warrior.tga",
		[2] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Rogue.tga",
		[3] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Priest.tga",
		[4] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Druid.tga",
		[5] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Paladin.tga",
		[6] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Hunter.tga",
		[7] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Mage.tga",
		[8] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Warlock.tga",
		[9] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Shaman.tga",
	} or {
		[1] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Warrior.tga",
		[2] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Rogue.tga",
		[3] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Priest.tga",
		[4] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Druid.tga",
		[5] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Paladin.tga",
		[6] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Hunter.tga",
		[7] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Mage.tga",
		[8] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Warlock.tga",
		[9] = "Interface\\Icons\\Ability_Mount_JungleTiger"
	}

end
S:AddCallbackForAddon('PallyPower')
