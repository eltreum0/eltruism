local E = unpack(ElvUI)
local _G = _G
local UIFrameFadeOut = _G.UIFrameFadeOut
local UIFrameFadeIn = _G. UIFrameFadeIn
local InCombatLockdown = _G.InCombatLockdown

--chat fading/mouseover/combathide
local leftfaderbutton = 1 -- when 1 it can fade, when 0 it cannot
local rightfaderbutton = 1 -- same as above

function ElvUI_EltreumUI:DynamicChatFade()
	if not E.private.chat.enable then return end
	if E.db.ElvUI_EltreumUI.chat.invertclick then
		leftfaderbutton = 0
		rightfaderbutton = 0
	end
	if E.db.ElvUI_EltreumUI.chat.enable then

		--hide at the start if the fade is enabled
		if E.db.ElvUI_EltreumUI.chat.rightfader then
			_G["RightChatPanel"]:SetAlpha(0)
		end
		if E.db.ElvUI_EltreumUI.chat.leftfader then
			_G["LeftChatPanel"]:SetAlpha(0)
		end

		--timer things
		local hidetime = E.db.chat.inactivityTimer+2
		local timeractiveleft = false
		local timeractiveright = false
		local lalpha, ralpha

		--function to time the fading
		local function FadeChat(chat, alpha, side)
			if side == "left" then
				ElvUI_EltreumUI:CancelTimer(timeractiveleft)
				if not InCombatLockdown() then
					timeractiveleft = ElvUI_EltreumUI:ScheduleTimer(function() UIFrameFadeOut(chat, 0.5, 1, 0) end, hidetime)
				end
				if alpha ~= 1 then
					chat:SetAlpha(1)
				end
			else
				ElvUI_EltreumUI:CancelTimer(timeractiveright)
				if not InCombatLockdown() then
					timeractiveright = ElvUI_EltreumUI:ScheduleTimer(function() UIFrameFadeOut(chat, 0.5, 1, 0) end, hidetime)
				end
				if alpha ~= 1 then
					chat:SetAlpha(1)
				end
			end
		end

		--hook the chat to fade it, similar to elvui
		for _, chattab in ipairs(_G.CHAT_FRAMES) do
			local parent = _G[chattab]:GetParent()
			local parentname = parent and _G[chattab]:GetParent():GetName() or false
			if parentname and not _G[chattab].EltruismHook then
				if chattab ~= _G.COMBATLOG:GetName() then
					if parentname == "LeftChatPanel" then
						if _G[chattab].AddMessage and E.db.ElvUI_EltreumUI.chat.leftfader then
							hooksecurefunc(_G[chattab], "AddMessage", function()
								lalpha = _G["LeftChatPanel"]:GetAlpha()
								FadeChat(_G["LeftChatPanel"],lalpha,"left")
							end)
						end
					elseif parentname == "RightChatPanel" then
						if _G[chattab].AddMessage and E.db.ElvUI_EltreumUI.chat.rightfader then
							hooksecurefunc(_G[chattab], "AddMessage", function()
								ralpha = _G["RightChatPanel"]:GetAlpha()
								FadeChat(_G["RightChatPanel"],ralpha, "right")
							end)
						end
					end
					_G[chattab].EltruismHook = true
				end
			end
		end

		--Left Chat Panel Mouse Over
		if E.db.ElvUI_EltreumUI.chat.leftmouseover then

			--left chat toggle the fade on and off
			_G["ChatFrame1"]:HookScript('OnMouseDown', function(_, button)
				if button=='LeftButton' then
					if leftfaderbutton == 1 then
						leftfaderbutton = 0
					elseif leftfaderbutton == 0 then
						leftfaderbutton = 1
					end
				end
			end)

			_G["ChatFrame1"]:SetScript('OnEnter', function()
				if not InCombatLockdown() then
					if leftfaderbutton == 1 then
						UIFrameFadeIn(_G["LeftChatPanel"], 0.5, 0, 1)
					end
				end
			end)
			_G["ChatFrame1"]:SetScript('OnLeave', function()
				if not InCombatLockdown() then
					if leftfaderbutton == 1 then
						UIFrameFadeOut(_G["LeftChatPanel"], 0.5, 1, 0)
					end
				end
			end)
		end

		--Right Chat Panel Mouse Over
		if E.db.ElvUI_EltreumUI.chat.rightmouseover then

			--right chat toggle the fade on and off
			_G["ChatFrame4"]:HookScript('OnMouseDown', function(_, button)
				if button=='LeftButton' then
					if rightfaderbutton == 1 then
						rightfaderbutton = 0
					elseif rightfaderbutton == 0 then
						rightfaderbutton = 1
					end
				end
			end)

			_G["ChatFrame4"]:SetScript('OnEnter', function()
				if not InCombatLockdown() then
					if rightfaderbutton == 1 then
						UIFrameFadeIn(_G["RightChatPanel"], 0.5, 0, 1)
					end
				end
			end)
			_G["ChatFrame4"]:SetScript('OnLeave', function()
				if not InCombatLockdown() then
					if rightfaderbutton == 1 then
						UIFrameFadeOut(_G["RightChatPanel"], 0.5, 1, 0)
					end
				end
			end)
		end

		--Left chat combat/boss hide
		if E.db.ElvUI_EltreumUI.chat.leftcombathide or E.db.ElvUI_EltreumUI.chat.leftbosshide then
			if E.db.ElvUI_EltreumUI.chat.leftcombathide then
				_G["LeftChatPanel"]:RegisterEvent("PLAYER_REGEN_DISABLED")
				_G["LeftChatPanel"]:RegisterEvent("PLAYER_REGEN_ENABLED")
			elseif E.db.ElvUI_EltreumUI.chat.leftbosshide then
				_G["LeftChatPanel"]:RegisterEvent("ENCOUNTER_END")
				_G["LeftChatPanel"]:RegisterEvent("ENCOUNTER_START")
			end
			_G["LeftChatPanel"]:SetScript("OnEvent", function(_, event)
				lalpha = _G["LeftChatPanel"]:GetAlpha()
				if E.db.ElvUI_EltreumUI.chat.leftcombathide then
					if event == "PLAYER_REGEN_DISABLED" then
						if E.db.ElvUI_EltreumUI.chat.leftcombathide then
							if lalpha == 1 then
								UIFrameFadeOut(_G["LeftChatPanel"], 0.5, 1, 0)
							end
						end
					elseif event == "PLAYER_REGEN_ENABLED" then
						if E.db.ElvUI_EltreumUI.chat.leftcombathide then
							if lalpha == 0 then
								UIFrameFadeIn(_G["LeftChatPanel"], 0.5, 0, 1)
							end
						end
					end
				elseif E.db.ElvUI_EltreumUI.chat.leftbosshide then
					if event == "ENCOUNTER_START" then
						if E.db.ElvUI_EltreumUI.chat.leftcombathide then
							if lalpha == 1 then
								UIFrameFadeOut(_G["LeftChatPanel"], 0.5, 1, 0)
							end
						end
					elseif event == "ENCOUNTER_END" then
						if E.db.ElvUI_EltreumUI.chat.leftcombathide then
							if lalpha == 0 then
								UIFrameFadeIn(_G["LeftChatPanel"], 0.5, 0, 1)
							end
						end
					end
				end
			end)
		end

		--Right chat combat/boss hide
		if E.db.ElvUI_EltreumUI.chat.rightcombathide or E.db.ElvUI_EltreumUI.chat.rightbosshide then
			if E.db.ElvUI_EltreumUI.chat.rightcombathide then
				_G["RightChatPanel"]:RegisterEvent("PLAYER_REGEN_DISABLED")
				_G["RightChatPanel"]:RegisterEvent("PLAYER_REGEN_ENABLED")
			elseif E.db.ElvUI_EltreumUI.chat.rightbosshide then
				_G["RightChatPanel"]:RegisterEvent("ENCOUNTER_END")
				_G["RightChatPanel"]:RegisterEvent("ENCOUNTER_START")
			end
			_G["RightChatPanel"]:SetScript("OnEvent", function(_, event)
				ralpha = _G["RightChatPanel"]:GetAlpha()
				if E.db.ElvUI_EltreumUI.chat.rightcombathide then
					if event == "PLAYER_REGEN_DISABLED" then
						if E.db.ElvUI_EltreumUI.chat.rightcombathide then
							if ralpha == 1 then
								UIFrameFadeOut(_G["RightChatPanel"], 0.5, 1, 0)
							end
						end
					elseif event == "PLAYER_REGEN_ENABLED" then
						if E.db.ElvUI_EltreumUI.chat.rightcombathide then
							if ralpha == 0 then
								UIFrameFadeIn(_G["RightChatPanel"], 0.5, 0, 1)
							end
						end
					end
				elseif E.db.ElvUI_EltreumUI.chat.rightbosshide then
					if event == "ENCOUNTER_START" then
						if E.db.ElvUI_EltreumUI.chat.rightcombathide then
							if ralpha == 1 then
								UIFrameFadeOut(_G["RightChatPanel"], 0.5, 1, 0)
							end
						end
					elseif event == "ENCOUNTER_END" then
						if E.db.ElvUI_EltreumUI.chat.rightcombathide then
							if ralpha == 0 then
								UIFrameFadeIn(_G["RightChatPanel"], 0.5, 0, 1)
							end
						end
					end
				end
			end)
		end
	end
end
