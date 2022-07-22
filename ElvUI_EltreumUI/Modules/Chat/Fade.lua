local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local UIFrameFadeOut = _G.UIFrameFadeOut
local UIFrameFadeIn = _G. UIFrameFadeIn
local IsAddOnLoaded = _G.IsAddOnLoaded
local LeftChatPanel = _G.LeftChatPanel
local RightChatPanel = _G.RightChatPanel
local InCombatLockdown = _G.InCombatLockdown

--chat fading/mouseover/combathide
local leftfaderbutton = 0 -- when 1 it can fade, when 0 it cannot
local rightfaderbutton = 0 -- same as above

--hides the background on the chat panel toggle arrows
--/run RightChatToggleButton.Center:Hide()

function ElvUI_EltreumUI:DynamicChatFade()
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
	if E.db.ElvUI_EltreumUI.chat.enable == true then

		--register events left chat panel
		if E.db.ElvUI_EltreumUI.chat.leftfader then
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
			LeftChatPanel:RegisterEvent("CHAT_MSG_BN_INLINE_TOAST_ALERT") --new
		end
		--register events right chat panel
		if E.db.ElvUI_EltreumUI.chat.rightfader then
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
			RightChatPanel:RegisterEvent("CHAT_MSG_BN_INLINE_TOAST_ALERT") --new
		end

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

		--Left chat inactivity hide
		if E.db.ElvUI_EltreumUI.chat.leftcombathide or E.db.ElvUI_EltreumUI.chat.leftfader then
			LeftChatPanel:RegisterEvent("PLAYER_REGEN_DISABLED")
			LeftChatPanel:RegisterEvent("PLAYER_REGEN_ENABLED")
			LeftChatPanel:SetScript("OnEvent", function(_, event)
				local lalpha = LeftChatPanel:GetAlpha()
				if event == "PLAYER_REGEN_DISABLED" then
					if E.db.ElvUI_EltreumUI.chat.leftcombathide then
						if lalpha == 1 then
							UIFrameFadeOut(LeftChatPanel, 0.5, 1, 0)
						end
					end
				elseif event == "PLAYER_REGEN_ENABLED" then
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
		end

		--Right chat inactivity hide
		if E.db.ElvUI_EltreumUI.chat.rightcombathide or E.db.ElvUI_EltreumUI.chat.rightfader then
			RightChatPanel:RegisterEvent("PLAYER_REGEN_DISABLED")
			RightChatPanel:RegisterEvent("PLAYER_REGEN_ENABLED")
			RightChatPanel:SetScript("OnEvent", function(_, event)
				local ralpha = RightChatPanel:GetAlpha()
				if event == "PLAYER_REGEN_DISABLED" then
					if E.db.ElvUI_EltreumUI.chat.rightcombathide then
						if ralpha == 1 then
							UIFrameFadeOut(RightChatPanel, 0.5, 1, 0)
						end
					end
				elseif event == "PLAYER_REGEN_ENABLED" then
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
end
