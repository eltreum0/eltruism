local E = unpack(ElvUI)
local _G = _G
local UIFrameFadeOut = _G.UIFrameFadeOut
local UIFrameFadeIn = _G. UIFrameFadeIn
local InCombatLockdown = _G.InCombatLockdown

--chat fading/mouseover/combathide
local leftfaderbutton = 1 -- when 1 it can fade, when 0 it cannot
local rightfaderbutton = 1 -- same as above
local LeftChatPanel
local RightChatPanel
local hidetime
local timeractiveleft
local timeractiveright
local lalpha, ralpha
--hides the background on the chat panel toggle arrows
--/run RightChatToggleButton.Center:Hide()

function ElvUI_EltreumUI:DynamicChatFade()
	if E.db.ElvUI_EltreumUI.chat.invertclick then
		leftfaderbutton = 0
		rightfaderbutton = 0
	end
	if E.db.ElvUI_EltreumUI.chat.enable then
		LeftChatPanel = _G.LeftChatPanel
		RightChatPanel = _G.RightChatPanel
		--register events left chat panel
		--[[if E.db.ElvUI_EltreumUI.chat.leftfader then
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
		end]]

		--hide at the start if the fade is enabled
		if E.db.ElvUI_EltreumUI.chat.rightfader then
			RightChatPanel:SetAlpha(0)
		end
		if E.db.ElvUI_EltreumUI.chat.leftfader then
			LeftChatPanel:SetAlpha(0)
		end

		--timer things
		hidetime = E.db.chat.inactivityTimer+2

		--function to time the fading
		local function FadeChat(chat, alpha, side)
			if side == "left" then
				if timeractiveleft then
					ElvUI_EltreumUI:CancelTimer(timeractiveleft)
				end
			else
				if timeractiveright then
					ElvUI_EltreumUI:CancelTimer(timeractiveright)
				end
			end
			if alpha == 1 and not InCombatLockdown() then
				if side == "left" then
					timeractiveleft = ElvUI_EltreumUI:ScheduleTimer(function() UIFrameFadeOut(chat, 0.5, 1, 0)end, hidetime)
				else
					timeractiveright = ElvUI_EltreumUI:ScheduleTimer(function() UIFrameFadeOut(chat, 0.5, 1, 0)end, hidetime)
				end
			else
				chat:SetAlpha(1)
			end
		end

		--hook the chat to fade it, similar to elvui
		for _, chattab in ipairs(_G.CHAT_FRAMES) do
			local parent = _G[chattab]:GetParent()
			local parentname
			if parent then
				parentname = _G[chattab]:GetParent():GetName()
			end
			if parentname and not _G[chattab].EltruismHook then
				if parentname == "LeftChatPanel" then
					if _G[chattab].AddMessage and E.db.ElvUI_EltreumUI.chat.leftfader then
						hooksecurefunc(_G[chattab], "AddMessage", function()
							lalpha = LeftChatPanel:GetAlpha()
							FadeChat(LeftChatPanel,lalpha, "left")
						end)
					end
				elseif parentname == "RightChatPanel" then
					if _G[chattab].AddMessage and E.db.ElvUI_EltreumUI.chat.rightfader then
						hooksecurefunc(_G[chattab], "AddMessage", function()
							ralpha = RightChatPanel:GetAlpha()
							FadeChat(RightChatPanel,ralpha, "right")
						end)
					end
				end
				_G[chattab].EltruismHook = true
			end
		end

		--Left Chat Panel Mouse Over
		if E.db.ElvUI_EltreumUI.chat.leftmouseover then

			--left chat toggle the fade on and off
			_G.LeftChatPanel:SetScript('OnMouseDown', function(_, button)
				if button=='LeftButton' then
					if leftfaderbutton == 1 then
						leftfaderbutton = 0
					elseif leftfaderbutton == 0 then
						leftfaderbutton = 1
					end
				end
			end)

			_G.LeftChatPanel:SetScript('OnEnter', function()
				if not InCombatLockdown() then
					if leftfaderbutton == 1 then
						UIFrameFadeIn(LeftChatPanel, 0.5, 0, 1)
					end
				end
			end)
			_G.LeftChatPanel:SetScript('OnLeave', function()
				if not InCombatLockdown() then
					if leftfaderbutton == 1 then
						UIFrameFadeOut(LeftChatPanel, 0.5, 1, 0)
					end
				end
			end)
		end

		--Right Chat Panel Mouse Over
		if E.db.ElvUI_EltreumUI.chat.rightmouseover then

			--right chat toggle the fade on and off
			_G.RightChatPanel:SetScript('OnMouseDown', function(_, button)
				if button=='LeftButton' then
					if rightfaderbutton == 1 then
						rightfaderbutton = 0
					elseif rightfaderbutton == 0 then
						rightfaderbutton = 1
					end
				end
			end)

			_G.RightChatPanel:SetScript('OnEnter', function()
				if not InCombatLockdown() then
					if rightfaderbutton == 1 then
						UIFrameFadeIn(RightChatPanel, 0.5, 0, 1)
					end
				end
			end)
			_G.RightChatPanel:SetScript('OnLeave', function()
				if not InCombatLockdown() then
					if rightfaderbutton == 1 then
						UIFrameFadeOut(RightChatPanel, 0.5, 1, 0)
					end
				end
			end)
		end

		--Left chat combat/boss hide
		if E.db.ElvUI_EltreumUI.chat.leftcombathide or E.db.ElvUI_EltreumUI.chat.leftbosshide then
			if E.db.ElvUI_EltreumUI.chat.leftcombathide then
				LeftChatPanel:RegisterEvent("PLAYER_REGEN_DISABLED")
				LeftChatPanel:RegisterEvent("PLAYER_REGEN_ENABLED")
			elseif E.db.ElvUI_EltreumUI.chat.leftbosshide then
				LeftChatPanel:RegisterEvent("ENCOUNTER_END")
				LeftChatPanel:RegisterEvent("ENCOUNTER_START")
			end
			LeftChatPanel:SetScript("OnEvent", function(_, event)
				lalpha = LeftChatPanel:GetAlpha()
				if E.db.ElvUI_EltreumUI.chat.leftcombathide then
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
					end
				elseif E.db.ElvUI_EltreumUI.chat.leftbosshide then
					if event == "ENCOUNTER_START" then
						if E.db.ElvUI_EltreumUI.chat.leftcombathide then
							if lalpha == 1 then
								UIFrameFadeOut(LeftChatPanel, 0.5, 1, 0)
							end
						end
					elseif event == "ENCOUNTER_END" then
						if E.db.ElvUI_EltreumUI.chat.leftcombathide then
							if lalpha == 0 then
								UIFrameFadeIn(LeftChatPanel, 0.5, 0, 1)
							end
						end
					end
				end
			end)
		end

		--Right chat combat/boss hide
		if E.db.ElvUI_EltreumUI.chat.rightcombathide or E.db.ElvUI_EltreumUI.chat.rightfader or E.db.ElvUI_EltreumUI.chat.rightbosshide then
			if E.db.ElvUI_EltreumUI.chat.rightcombathide then
				RightChatPanel:RegisterEvent("PLAYER_REGEN_DISABLED")
				RightChatPanel:RegisterEvent("PLAYER_REGEN_ENABLED")
			elseif E.db.ElvUI_EltreumUI.chat.rightbosshide then
				RightChatPanel:RegisterEvent("ENCOUNTER_END")
				RightChatPanel:RegisterEvent("ENCOUNTER_START")
			end
			RightChatPanel:SetScript("OnEvent", function(_, event)
				ralpha = RightChatPanel:GetAlpha()
				if E.db.ElvUI_EltreumUI.chat.rightcombathide then
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
					end
				elseif E.db.ElvUI_EltreumUI.chat.rightbosshide then
					if event == "ENCOUNTER_START" then
						if E.db.ElvUI_EltreumUI.chat.rightcombathide then
							if ralpha == 1 then
								UIFrameFadeOut(RightChatPanel, 0.5, 1, 0)
							end
						end
					elseif event == "ENCOUNTER_END" then
						if E.db.ElvUI_EltreumUI.chat.rightcombathide then
							if ralpha == 0 then
								UIFrameFadeIn(RightChatPanel, 0.5, 0, 1)
							end
						end
					end
				end
			end)
		end
	end
end
