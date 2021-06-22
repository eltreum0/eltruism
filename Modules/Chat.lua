local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local UIFrameFadeOut = _G.UIFrameFadeOut
local UIFrameFadeIn = _G. UIFrameFadeIn
local InCombatLockdown = _G.InCombatLockdown
local CH = E:GetModule('Chat')
local ipairs = ipairs
local ChatFrame_AddMessageGroup = ChatFrame_AddMessageGroup
local ChatFrame_RemoveAllMessageGroups = ChatFrame_RemoveAllMessageGroups
local FCF_OpenNewWindow = FCF_OpenNewWindow
local FCF_ResetChatWindows = FCF_ResetChatWindows
local FCF_SetChatWindowFontSize = FCF_SetChatWindowFontSize
local FCF_SetWindowName = FCF_SetWindowName
local FCFTab_UpdateColors = FCFTab_UpdateColors
local ChatFrame_AddChannel = ChatFrame_AddChannel
local ChatFrame_RemoveChannel = ChatFrame_RemoveChannel
local ChangeChatColor = ChangeChatColor
local ToggleChatColorNamesByClassGroup = ToggleChatColorNamesByClassGroup
local FCF_UnDockFrame = FCF_UnDockFrame
local FCF_SavePositionAndDimensions = FCF_SavePositionAndDimensions
local FCF_StopDragging = FCF_StopDragging
local LOOT, GENERAL, TRADE = LOOT, GENERAL, TRADE
local GUILD_EVENT_LOG = GUILD_EVENT_LOG


--chat fading/mouseover/combathide
local leftfaderbutton = 0  -- when 1 it can fade, when 0 it cannot
local rightfaderbutton = 0 -- same as above
function ElvUI_EltreumUI:DynamicChatFade(event)
	if E.db.ElvUI_EltreumUI.chat.enable then
		--register events left chat panel
		LeftChatPanel:RegisterEvent("PLAYER_REGEN_DISABLED")
		LeftChatPanel:RegisterEvent("PLAYER_REGEN_ENABLED")
		LeftChatPanel:RegisterEvent("CHAT_MSG_ACHIEVEMENT")
		LeftChatPanel:RegisterEvent("CHAT_MSG_ADDON")
		LeftChatPanel:RegisterEvent("CHAT_MSG_AFK")
		LeftChatPanel:RegisterEvent("CHAT_MSG_BG_SYSTEM_ALLIANCE")
		LeftChatPanel:RegisterEvent("CHAT_MSG_BG_SYSTEM_HORDE")
		LeftChatPanel:RegisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL")
		LeftChatPanel:RegisterEvent("CHAT_MSG_BN_WHISPER")
		LeftChatPanel:RegisterEvent("CHAT_MSG_CHANNEL")
		LeftChatPanel:RegisterEvent("CHAT_MSG_EMOTE")
		LeftChatPanel:RegisterEvent("CHAT_MSG_GUILD")
		LeftChatPanel:RegisterEvent("CHAT_MSG_GUILD_ACHIEVEMENT")
		LeftChatPanel:RegisterEvent("CHAT_MSG_INSTANCE_CHAT")
		LeftChatPanel:RegisterEvent("CHAT_MSG_INSTANCE_CHAT_LEADER")
		LeftChatPanel:RegisterEvent("CHAT_MSG_OFFICER")
		LeftChatPanel:RegisterEvent("CHAT_MSG_PARTY")
		LeftChatPanel:RegisterEvent("CHAT_MSG_PARTY_LEADER")
		LeftChatPanel:RegisterEvent("CHAT_MSG_RAID")
		LeftChatPanel:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
		LeftChatPanel:RegisterEvent("CHAT_MSG_RAID_BOSS_WHISPER")
		LeftChatPanel:RegisterEvent("CHAT_MSG_RAID_LEADER")
		LeftChatPanel:RegisterEvent("CHAT_MSG_RAID_WARNING")
		LeftChatPanel:RegisterEvent("CHAT_MSG_SAY")
		LeftChatPanel:RegisterEvent("CHAT_MSG_SKILL")
		LeftChatPanel:RegisterEvent("CHAT_MSG_SYSTEM")
		LeftChatPanel:RegisterEvent("CHAT_MSG_WHISPER")
		LeftChatPanel:RegisterEvent("CHAT_MSG_YELL")
		--register events right chat panel
		RightChatPanel:RegisterEvent("PLAYER_REGEN_DISABLED")
		RightChatPanel:RegisterEvent("PLAYER_REGEN_ENABLED")
		RightChatPanel:RegisterEvent("CHAT_MSG_ACHIEVEMENT")
		RightChatPanel:RegisterEvent("CHAT_MSG_ADDON")
		RightChatPanel:RegisterEvent("CHAT_MSG_AFK")
		RightChatPanel:RegisterEvent("CHAT_MSG_BG_SYSTEM_ALLIANCE")
		RightChatPanel:RegisterEvent("CHAT_MSG_BG_SYSTEM_HORDE")
		RightChatPanel:RegisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL")
		RightChatPanel:RegisterEvent("CHAT_MSG_BN_WHISPER")
		RightChatPanel:RegisterEvent("CHAT_MSG_CHANNEL")
		RightChatPanel:RegisterEvent("CHAT_MSG_EMOTE")
		RightChatPanel:RegisterEvent("CHAT_MSG_GUILD")
		RightChatPanel:RegisterEvent("CHAT_MSG_GUILD_ACHIEVEMENT")
		RightChatPanel:RegisterEvent("CHAT_MSG_INSTANCE_CHAT")
		RightChatPanel:RegisterEvent("CHAT_MSG_INSTANCE_CHAT_LEADER")
		RightChatPanel:RegisterEvent("CHAT_MSG_OFFICER")
		RightChatPanel:RegisterEvent("CHAT_MSG_PARTY")
		RightChatPanel:RegisterEvent("CHAT_MSG_PARTY_LEADER")
		RightChatPanel:RegisterEvent("CHAT_MSG_RAID")
		RightChatPanel:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
		RightChatPanel:RegisterEvent("CHAT_MSG_RAID_BOSS_WHISPER")
		RightChatPanel:RegisterEvent("CHAT_MSG_RAID_LEADER")
		RightChatPanel:RegisterEvent("CHAT_MSG_RAID_WARNING")
		RightChatPanel:RegisterEvent("CHAT_MSG_SAY")
		RightChatPanel:RegisterEvent("CHAT_MSG_SKILL")
		RightChatPanel:RegisterEvent("CHAT_MSG_SYSTEM")
		RightChatPanel:RegisterEvent("CHAT_MSG_WHISPER")
		RightChatPanel:RegisterEvent("CHAT_MSG_YELL")

		--timer things
		local hidetime = E.db.chat.inactivityTimer
		local timeractive

		function ElvUI_EltreumUI:TimerHide()
			if E.db.ElvUI_EltreumUI.chat.leftfader then
				if leftfaderbutton == 1 then
					UIFrameFadeOut(LeftChatPanel, 0.5, 1, 0)
				end
			end
			if E.db.ElvUI_EltreumUI.chat.rightfader then
				if rightfaderbutton == 1 then
					UIFrameFadeOut(RightChatPanel, 0.5, 1, 0)
				end
			end
		end

		--left chat toggle the fade on and off
		LeftChatPanel:SetScript('OnMouseDown', function(self, button)
			 if button=='LeftButton' then
		        if leftfaderbutton == 1 then
		        	leftfaderbutton = 0
		        elseif leftfaderbutton == 0 then
		        	leftfaderbutton = 1
		        end
		    end
		end)
		--right chat toggle the fade on and off
		RightChatPanel:SetScript('OnMouseDown', function(self, button)
			 if button=='LeftButton' then
			 	if rightfaderbutton == 1 then
		        	rightfaderbutton = 0
		        elseif rightfaderbutton == 0 then
		        	rightfaderbutton = 1
		        end
		    end
		end)

		--Left Chat Panel
		if E.db.ElvUI_EltreumUI.chat.leftmouseover then
			LeftChatPanel:SetScript('OnEnter', function(self)
				if not InCombatLockdown() then
					if leftfaderbutton == 1 then
						UIFrameFadeIn(LeftChatPanel, 0.5, 0, 1)
					end
				end
			end)
			LeftChatPanel:SetScript('OnLeave', function(self)
				--local function hideleft() self.ScheduleTimer("TimerHideInstantLeft", 0.5) end
				if leftfaderbutton == 1 then
					UIFrameFadeOut(LeftChatPanel, 0.5, 1, 0)
				end
			end)
		end
		if E.db.ElvUI_EltreumUI.chat.leftfader then
			LeftChatPanel:HookScript("OnEvent", function(__, event)
				if (event == 'PLAYER_REGEN_DISABLED') then
					if E.db.ElvUI_EltreumUI.chat.leftcombathide then
						if leftfaderbutton == 1 then
							UIFrameFadeOut(LeftChatPanel, 0.5, 1, 0)
						end
					end
				elseif (event == 'PLAYER_REGEN_ENABLED') then
					if E.db.ElvUI_EltreumUI.chat.leftcombathide then
						if leftfaderbutton == 1 then
							UIFrameFadeIn(LeftChatPanel, 0.5, 0, 1)
						end
					end
				else
					self:CancelTimer(timeractive)
					if not InCombatLockdown() then
						if leftfaderbutton == 1 then
							timeractive = self:ScheduleTimer("TimerHide", hidetime)
							LeftChatPanel:SetAlpha(1)
						end
					end
				end
			end)
		end
		--Right Chat Panel
		if E.db.ElvUI_EltreumUI.chat.rightmouseover then
			RightChatPanel:SetScript('OnEnter', function(self)
				if not InCombatLockdown() then
					if rightfaderbutton == 1 then
						UIFrameFadeIn(RightChatPanel, 0.5, 0, 1)
					end
				end
			end)
			RightChatPanel:SetScript('OnLeave', function(self)
				if not InCombatLockdown() then
					if rightfaderbutton == 1 then
						UIFrameFadeOut(RightChatPanel, 0.5, 1, 0)
					end
				end
			end)
		end
		if E.db.ElvUI_EltreumUI.chat.rightfader then
			RightChatPanel:HookScript("OnEvent", function(__, event)
				if E.db.ElvUI_EltreumUI.chat.rightcombathide then
					if (event == 'PLAYER_REGEN_DISABLED') then
						if rightfaderbutton == 1 then
							UIFrameFadeOut(RightChatPanel, 0.5, 1, 0)
						end
					elseif (event == 'PLAYER_REGEN_ENABLED') then
						if rightfaderbutton == 1 then
							UIFrameFadeIn(RightChatPanel, 0.5, 0, 1)
						end
					end
				else
					if (event == 'PLAYER_REGEN_DISABLED') then
						if rightfaderbutton == 1 then
							RightChatPanel:SetAlpha(1)
						end
					end
				end
				self:CancelTimer(timeractive)
				if not InCombatLockdown() then
					if rightfaderbutton == 1 then
						timeractive = self:ScheduleTimer("TimerHide", hidetime)
						RightChatPanel:SetAlpha(1)
					end
				end
				if InCombatLockdown() then
					if not E.db.ElvUI_EltreumUI.chat.rightcombathide then
						if rightfaderbutton == 1 then
							self:CancelTimer(timeractive)
							RightChatPanel:SetAlpha(1)
						end
					end
				end
			end)
		end
	end
end


-- ElvUI Chat Setup pretty much
function ElvUI_EltreumUI:SetupChat()

	--Reset chat
	FCF_ResetChatWindows()
	FCF_OpenNewWindow(LOOT)
	FCF_UnDockFrame(_G.ChatFrame3)

	--Do ElvUI setup thing
	for _, name in ipairs(_G.CHAT_FRAMES) do
		local frame = _G[name]
		local id = frame:GetID()

		if E.private.chat.enable then
			CH:FCFTab_UpdateColors(CH:GetTab(_G[name]))
		end

		-- move general bottom left
		if id == 1 then
			frame:ClearAllPoints()
			frame:Point('BOTTOMLEFT', _G.LeftChatToggleButton, 'TOPLEFT', 1, 3)
		elseif id == 3 then
			frame:ClearAllPoints()
			frame:Point('BOTTOMLEFT', _G.RightChatDataPanel, 'TOPLEFT', 1, 3)
		end

		FCF_SavePositionAndDimensions(frame)
		FCF_StopDragging(frame)
		--Set Font size 12 for all tabs
		FCF_SetChatWindowFontSize(nil, frame, 12)

		-- rename windows general because moved to chat #3
		if id == 1 then
			FCF_SetWindowName(frame, GENERAL)
		elseif id == 2 then
			FCF_SetWindowName(frame, GUILD_EVENT_LOG)
		elseif id == 3 then
			FCF_SetWindowName(frame, LOOT..' / '..TRADE)
		end
	end

	-- keys taken from `ChatTypeGroup` but doesnt add: 'OPENING', 'TRADESKILLS', 'PET_INFO', 'COMBAT_MISC_INFO', 'COMMUNITIES_CHANNEL', 'PET_BATTLE_COMBAT_LOG', 'PET_BATTLE_INFO', 'TARGETICONS'
	local chatGroup = { 'SYSTEM', 'CHANNEL', 'SAY', 'EMOTE', 'YELL', 'WHISPER', 'PARTY', 'PARTY_LEADER', 'RAID', 'RAID_LEADER', 'RAID_WARNING', 'INSTANCE_CHAT', 'INSTANCE_CHAT_LEADER', 'GUILD', 'OFFICER', 'MONSTER_SAY', 'MONSTER_YELL', 'MONSTER_EMOTE', 'MONSTER_WHISPER', 'MONSTER_BOSS_EMOTE', 'MONSTER_BOSS_WHISPER', 'ERRORS', 'AFK', 'DND', 'IGNORED', 'BG_HORDE', 'BG_ALLIANCE', 'BG_NEUTRAL', 'ACHIEVEMENT', 'GUILD_ACHIEVEMENT', 'BN_WHISPER', 'BN_INLINE_TOAST_ALERT' }
	ChatFrame_RemoveAllMessageGroups(_G.ChatFrame1)
	for _, v in ipairs(chatGroup) do
		ChatFrame_AddMessageGroup(_G.ChatFrame1, v)
	end

	-- keys taken from `ChatTypeGroup` which weren't added above to ChatFrame1
	chatGroup = { 'COMBAT_XP_GAIN', 'COMBAT_HONOR_GAIN', 'COMBAT_FACTION_CHANGE', 'SKILL', 'LOOT', 'CURRENCY', 'MONEY' }
	ChatFrame_RemoveAllMessageGroups(_G.ChatFrame3)
	for _, v in ipairs(chatGroup) do
		ChatFrame_AddMessageGroup(_G.ChatFrame3, v)
	end

	ChatFrame_AddChannel(_G.ChatFrame1, GENERAL)
	ChatFrame_RemoveChannel(_G.ChatFrame1, TRADE)
	ChatFrame_AddChannel(_G.ChatFrame3, TRADE)

	-- set the chat groups names in class color to enabled for all chat groups which players names appear
	chatGroup = { 'SAY', 'EMOTE', 'YELL', 'WHISPER', 'PARTY', 'PARTY_LEADER', 'RAID', 'RAID_LEADER', 'RAID_WARNING', 'INSTANCE_CHAT', 'INSTANCE_CHAT_LEADER', 'GUILD', 'OFFICER', 'ACHIEVEMENT', 'GUILD_ACHIEVEMENT', 'COMMUNITIES_CHANNEL' }
	for i = 1, _G.MAX_WOW_CHAT_CHANNELS do
		tinsert(chatGroup, 'CHANNEL'..i)
	end
	for _, v in ipairs(chatGroup) do
		ToggleChatColorNamesByClassGroup(true, v)
	end

	-- Adjust Chat Colors
	ChangeChatColor('CHANNEL1', 195/255, 230/255, 232/255) -- General
	ChangeChatColor('CHANNEL2', 232/255, 158/255, 121/255) -- Trade
	ChangeChatColor('CHANNEL3', 232/255, 228/255, 121/255) -- Local Defense

	if E.private.chat.enable then
		CH:PositionChats()
	end

	if E.db.RightChatPanelFaded then
		_G.RightChatToggleButton:Click()
	end

	if E.db.LeftChatPanelFaded then
		_G.LeftChatToggleButton:Click()
	end

	ElvUI_EltreumUI:Print('ElvUI Chat has been Set')
end
