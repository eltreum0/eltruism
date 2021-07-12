local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local UIFrameFadeOut = _G.UIFrameFadeOut
local UIFrameFadeIn = _G. UIFrameFadeIn
local InCombatLockdown = _G.InCombatLockdown
local CH = E:GetModule('Chat')
local ipairs = _G.ipairs
local ChatFrame_AddMessageGroup = _G.ChatFrame_AddMessageGroup
local ChatFrame_RemoveAllMessageGroups = _G.ChatFrame_RemoveAllMessageGroups
local FCF_OpenNewWindow = _G.FCF_OpenNewWindow
local FCF_ResetChatWindows = _G.FCF_ResetChatWindows
local FCF_SetChatWindowFontSize = _G.FCF_SetChatWindowFontSize
local FCF_SetWindowName = _G.FCF_SetWindowName
local FCFTab_UpdateColors = _G.FCFTab_UpdateColors
local ChatFrame_AddChannel = _G.ChatFrame_AddChannel
local ChatFrame_RemoveChannel = _G.ChatFrame_RemoveChannel
local VoiceTranscriptionFrame_UpdateEditBox = _G.VoiceTranscriptionFrame_UpdateEditBox
local VoiceTranscriptionFrame_UpdateVisibility = _G.VoiceTranscriptionFrame_UpdateVisibility
local VoiceTranscriptionFrame_UpdateVoiceTab = _G.VoiceTranscriptionFrame_UpdateVoiceTab
local ChangeChatColor = _G.ChangeChatColor
local ToggleChatColorNamesByClassGroup = _G.ToggleChatColorNamesByClassGroup
local FCF_UnDockFrame = _G.FCF_UnDockFrame
local FCF_SavePositionAndDimensions = _G.FCF_SavePositionAndDimensions
local FCF_StopDragging = _G.FCF_StopDragging
local LOOT, GENERAL, TRADE = LOOT, GENERAL, TRADE
local GUILD_EVENT_LOG = GUILD_EVENT_LOG
local IsAddOnLoaded = _G.IsAddOnLoaded
local tinsert = _G.tinsert

--chat fading/mouseover/combathide
local leftfaderbutton = 0  -- when 1 it can fade, when 0 it cannot
local rightfaderbutton = 0 -- same as above
function ElvUI_EltreumUI:DynamicChatFade(event)
	if not IsAddOnLoaded("ElvUI_EltreumUI") then
		return
	elseif not E.db.ElvUI_EltreumUI then
		return
	elseif not E.db.ElvUI_EltreumUI.chat then
		return
	end
	if E.db.ElvUI_EltreumUI.chat.invertclick then
		leftfaderbutton = 1
		rightfaderbutton = 1
	end
	if E.db.ElvUI_EltreumUI.chat.enable then
		--register events left chat panel
		LeftChatPanel:RegisterEvent("PLAYER_REGEN_DISABLED")
		LeftChatPanel:RegisterEvent("PLAYER_REGEN_ENABLED")
		LeftChatPanel:RegisterEvent("CHAT_MSG_ACHIEVEMENT")
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
		LeftChatPanel:RegisterEvent("CHAT_MSG_SYSTEM")
		LeftChatPanel:RegisterEvent("CHAT_MSG_WHISPER")
		LeftChatPanel:RegisterEvent("CHAT_MSG_YELL")
		--register events right chat panel
		RightChatPanel:RegisterEvent("PLAYER_REGEN_DISABLED")
		RightChatPanel:RegisterEvent("PLAYER_REGEN_ENABLED")
		RightChatPanel:RegisterEvent("CHAT_MSG_ACHIEVEMENT")
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
		RightChatPanel:RegisterEvent("CHAT_MSG_SYSTEM")
		RightChatPanel:RegisterEvent("CHAT_MSG_WHISPER")
		RightChatPanel:RegisterEvent("CHAT_MSG_YELL")

		--timer things
		local hidetime = E.db.chat.inactivityTimer+2
		local timeractiveleft
		local timeractiveright

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

		--Left Chat Panel Mouse Over
		if E.db.ElvUI_EltreumUI.chat.leftmouseover then
			LeftChatPanel:SetScript('OnEnter', function(self)
				if not InCombatLockdown() then
					if leftfaderbutton == 1 then
						UIFrameFadeIn(LeftChatPanel, 0.5, 0, 1)
					end
				end
			end)
			LeftChatPanel:SetScript('OnLeave', function(self)
				if not InCombatLockdown() then
					if leftfaderbutton == 1 then
						UIFrameFadeOut(LeftChatPanel, 0.5, 1, 0)
					end
				end
			end)
		end

		--Right Chat Panel Mouse Over
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

		--Left chat and activity hide
		LeftChatPanel:SetScript("OnEvent", function(_, event)
			--print(E.db.ElvUI_EltreumUI.chat.leftcombathide)
			--print(E.db.ElvUI_EltreumUI.chat.leftfader)
			--print(E.db.ElvUI_EltreumUI.chat.rightcombathide)
			--print(E.db.ElvUI_EltreumUI.chat.rightfader)
			local lalpha = LeftChatPanel:GetAlpha()
			if event == "PLAYER_REGEN_DISABLED" then
				--print("combat startl")
				if E.db.ElvUI_EltreumUI.chat.leftcombathide then
					if lalpha == 1 then
						UIFrameFadeOut(LeftChatPanel, 0.5, 1, 0)
					end
				end
			elseif event == "PLAYER_REGEN_ENABLED" then
				--print("combat endsl")
				if E.db.ElvUI_EltreumUI.chat.leftcombathide then
					if lalpha == 0 then
						UIFrameFadeIn(LeftChatPanel, 0.5, 0, 1)
					end
				end
			elseif event ~= "PLAYER_REGEN_ENABLED" and event ~= "PLAYER_REGEN_DISABLED" then
				if E.db.ElvUI_EltreumUI.chat.leftfader then
					self:CancelTimer(timeractiveleft)
					if not InCombatLockdown() then
						if leftfaderbutton == 1 then
							timeractiveleft = self:ScheduleTimer(function() UIFrameFadeOut(LeftChatPanel, 0.5, 1, 0)end, hidetime)
							if lalpha == 0 then
								LeftChatPanel:SetAlpha(1)
							end
						end
					end
					if InCombatLockdown() then
						if not E.db.ElvUI_EltreumUI.chat.leftcombathide then
							if leftfaderbutton == 1 then
								self:CancelTimer(timeractiveleft)
								if lalpha == 0 then
									LeftChatPanel:SetAlpha(1)
								end
							end
						end
					end
				end
			end
		end)

		--Right chat activity hide
		RightChatPanel:SetScript("OnEvent", function(_, event)
			local ralpha = RightChatPanel:GetAlpha()
			if event == "PLAYER_REGEN_DISABLED" then
				--print("combat startR")
				if E.db.ElvUI_EltreumUI.chat.rightcombathide then
					if ralpha == 1 then
						UIFrameFadeOut(RightChatPanel, 0.5, 1, 0)
					end
				end
			elseif event == "PLAYER_REGEN_ENABLED" then
				--print("combat endsR")
				if E.db.ElvUI_EltreumUI.chat.rightcombathide then
					if ralpha == 0 then
						UIFrameFadeIn(RightChatPanel, 0.5, 0, 1)
					end
				end
			elseif event ~= "PLAYER_REGEN_ENABLED" and event ~= "PLAYER_REGEN_DISABLED" then
				if E.db.ElvUI_EltreumUI.chat.rightfader then
					self:CancelTimer(timeractiveright)
					if not InCombatLockdown() then
						if rightfaderbutton == 1 then
							timeractiveright = self:ScheduleTimer(function() UIFrameFadeOut(RightChatPanel, 0.5, 1, 0)end, hidetime)
							if ralpha == 0 then
								RightChatPanel:SetAlpha(1)
							end
						end
					end
					if InCombatLockdown() then
						if not E.db.ElvUI_EltreumUI.chat.rightcombathide then
							if rightfaderbutton == 1 then
								self:CancelTimer(timeractiveright)
								if ralpha == 0 then
									RightChatPanel:SetAlpha(1)
								end
							end
						end
					end
				end
			end
		end)
	end
end

--color chat rolls
local classcolorsescape = {
	['DEATHKNIGHT']	= "C41E3A",
	['DEMONHUNTER']	= "A330C9",
	['DRUID'] = "FF7C0A",
	['HUNTER'] = "AAD372",
	['MAGE'] = "3FC7EB",
	['MONK'] = "00FF98",
	['PALADIN']	= "F48CBA",
	['PRIEST'] = "FFFFFF",
	['ROGUE'] = "FFF468",
	['SHAMAN'] = "0070DD",
	['WARLOCK'] = "8788EE",
	['WARRIOR'] = "C69B6D",
}
local function ColorSysMsgs(self, event, message, ...)
	if message:find("rolls") or message:find("tira") or message:find("掷出") or message:find("würfelt. Ergebnis:") or message:find("obtient un") or message:find("님이 주사위를 굴려") or message:find("tira los dados y obtiene") or message:find("выбрасывает") or message:find("擲出") then
		local msg = (string.format("|cff"..classcolorsescape[E.myclass]..message.."|r"))
		return false, msg, ...
	end
	if message:find("online") then
		return false, gsub(message, "online", "|cff00FF00online|r"), ...
	end
	if message:find("offline") then
		return false, gsub(message, "offline", "|cffFF0000offline|r"), ...
	end
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", ColorSysMsgs)
--ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", ColorSysMsgs) --this is for testing purposes

-- ElvUI Chat Setup pretty much
function ElvUI_EltreumUI:SetupChat()

	--Reset chat
	FCF_ResetChatWindows()
	FCF_OpenNewWindow(LOOT)
	FCF_UnDockFrame(_G.ChatFrame4)

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
			VoiceTranscriptionFrame_UpdateVisibility(frame)
			VoiceTranscriptionFrame_UpdateVoiceTab(frame)
			VoiceTranscriptionFrame_UpdateEditBox(frame)
		elseif id == 4 then
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
		elseif id == 4 then
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
	ChatFrame_RemoveAllMessageGroups(_G.ChatFrame4)
	for _, v in ipairs(chatGroup) do
		ChatFrame_AddMessageGroup(_G.ChatFrame4, v)
	end

	ChatFrame_AddChannel(_G.ChatFrame1, GENERAL)
	ChatFrame_RemoveChannel(_G.ChatFrame1, TRADE)
	ChatFrame_AddChannel(_G.ChatFrame4, TRADE)

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

	ElvUI_EltreumUI:Print(L["ElvUI Chat has been Set"])
end

-- ElvUI Chat Setup pretty much
function ElvUI_EltreumUI:SetupChatClassic()

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

	ElvUI_EltreumUI:Print(L["ElvUI Chat has been Set"])
end
