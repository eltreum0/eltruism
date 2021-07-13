local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local UIFrameFadeOut = _G.UIFrameFadeOut
local UIFrameFadeIn = _G. UIFrameFadeIn
local InCombatLockdown = _G.InCombatLockdown
local IsAddOnLoaded = _G.IsAddOnLoaded
local gsub = _G.gsub
local string = _G.string

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
		LeftChatPanel:RegisterEvent("CHAT_MSG_BN_INLINE_TOAST_ALERT")  --new
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
		RightChatPanel:RegisterEvent("CHAT_MSG_BN_INLINE_TOAST_ALERT") --new

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

--Color System messages
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
		if msg:find("1 (1-100)") then
			return false, gsub(msg, "1 (1-100)", "|cffFF00001|r (1-100)"), ...
		elseif msg:find("100 (1-100)") then
			return false, gsub(msg, "100 (1-100)", "|cff0000FF100|r (1-100"), ...
		else
			return false, msg, ...
		end
	end
	if message:find("online") then  --german, english, italian all use the same online/offline
		return false, gsub(message, "online", "|cff00FF00online|r"), ...
	end
	if message:find("offline") then
		return false, gsub(message, "offline", "|cffFF0000offline|r"), ...
	end
	if message:find("joins the") then
		return false, gsub(message, "joins", "|cff82B4ffjoins|r"), ...
	end
	if message:find("join the") then
		return false, gsub(message, "joins", "|cff82B4ffjoin|r"), ...
	end
	if message:find("joined the") then
		return false, gsub(message, "joined", "|cff82B4ffjoined|r"), ...
	end
	if message:find("has left the") then
		return false, gsub(message, "left", "|cffB50909left|r"), ...
	end
	if message:find("leaves the") then
		return false, gsub(message, "leaves", "|cffB50909leaves|r"), ...
	end
	if message:find("leave the") then
		return false, gsub(message, "leave", "|cffB50909leave|r"), ...
	end
	local sizeString = ":12:12"
	local roleIcons = {
		TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\shield.tga', sizeString),
		HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\pharmacy.tga', sizeString),
		DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\sword.tga', sizeString),
	}
	_G.INLINE_TANK_ICON = roleIcons.TANK
	_G.INLINE_HEALER_ICON = roleIcons.HEALER
	_G.INLINE_DAMAGER_ICON = roleIcons.DAMAGER
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", ColorSysMsgs)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_INLINE_TOAST_ALERT", ColorSysMsgs)
ChatFrame_AddMessageEventFilter("ROLE_CHANGED_INFORM", ColorSysMsgs)
--ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", ColorSysMsgs) --this is for testing purposes


--icons in chat when party member swaps roles
function ElvUI_EltreumUI:ChatRoleSwapIcons()
	local sizeString = ":12:12"
	local roleIcons = {
		TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\shield.tga', sizeString),
		HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\pharmacy.tga', sizeString),
		DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\sword.tga', sizeString),
	}
	_G.INLINE_TANK_ICON = roleIcons.TANK
	_G.INLINE_HEALER_ICON = roleIcons.HEALER
	_G.INLINE_DAMAGER_ICON = roleIcons.DAMAGER
end
