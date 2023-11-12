local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local UIFrameFadeOut = _G.UIFrameFadeOut
local PlaySoundFile = _G.PlaySoundFile

function ElvUI_EltreumUI:EltruismScrap()
	E:Delay(0, function()
		if _G["MerchantFrameSecureTab0"] then
			S:HandleTab(_G["MerchantFrameSecureTab0"])
			if E.db.ElvUI_EltreumUI.skins.shadow.enable and _G["MerchantFrameSecureTab0"].backdrop and not _G["MerchantFrameSecureTab0"].backdrop.shadow then
				_G["MerchantFrameSecureTab0"].backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				ElvUI_EltreumUI:ShadowColor(_G["MerchantFrameSecureTab0"].backdrop.shadow)
			end
		end
	end)
end
S:AddCallbackForAddon('Scrap_Merchant', "EltruismScrap", ElvUI_EltreumUI.EltruismScrap)
S:AddCallbackForAddon('Scrap', "EltruismScrap", ElvUI_EltreumUI.EltruismScrap)

--not so secret anymore
function ElvUI_EltreumUI:HardcoreDeath()
	if E.ClassicHC then
		local HardcoreMonitor = _G["EltruismHardcoreDeathMonitor"] or CreateFrame("Frame", "EltruismHardcoreDeathMonitor")
		HardcoreMonitor:SetPoint("CENTER", _G.RaidWarningFrame)
		local x,y = _G.RaidWarningFrame:GetSize()
		HardcoreMonitor:SetSize(x,y)

		HardcoreMonitor.StatusLine = CreateFrame("StatusBar", "EltruismHardcoreDeathLine", HardcoreMonitor)
		HardcoreMonitor.StatusLine:SetMinMaxValues(0,100)
		HardcoreMonitor.StatusLine:SetValue(100)
		HardcoreMonitor.StatusLine:SetSize(418, 3)
		HardcoreMonitor.StatusLine:SetPoint("TOP", _G.RaidWarningFrameSlot1, 0, 5)
		HardcoreMonitor.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)

		HardcoreMonitor.StatusLine2 = CreateFrame("StatusBar", "EltruismHardcoreDeathLine2", HardcoreMonitor)
		HardcoreMonitor.StatusLine2:SetMinMaxValues(0,100)
		HardcoreMonitor.StatusLine2:SetValue(100)
		HardcoreMonitor.StatusLine2:SetSize(418, 3)
		HardcoreMonitor.StatusLine2:SetPoint("BOTTOM", _G.RaidWarningFrameSlot1, 0, -5)
		HardcoreMonitor.StatusLine2:SetStatusBarTexture(E.Media.Textures.Highlight)

		HardcoreMonitor:SetAlpha(0)

		if E.db.ElvUI_EltreumUI.skins.playerdeathhardcore then
			HardcoreMonitor:RegisterEvent("PLAYER_DEAD")
		end
		if E.db.ElvUI_EltreumUI.skins.guildmemberdeathhardcore then
			HardcoreMonitor:RegisterEvent("GUILD_MEMBER_DIED")
			HardcoreMonitor:RegisterEvent("CHAT_MSG_GUILD_DEATHS")
		end
		--HardcoreMonitor:RegisterEvent("PLAYER_STARTED_MOVING")
		HardcoreMonitor:SetScript("OnEvent", function(_,event,guildmembername)
			if C_GameRules.IsHardcoreActive() then
				if event == "PLAYER_DEAD" then
					if not E.db.ElvUI_EltreumUI.skins.playerdeathhardcore then return end
					E:Delay(4,function() PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\overconfidence.ogg" , "Master") end)
				else
					if not E.db.ElvUI_EltreumUI.skins.guildmemberdeathhardcore then return end
					if not guildmembername then return end
					for i = 1, GetNumGuildMembers() do
						local name, _, _, _, _, _, _, _, _, _, unitclass = GetGuildRosterInfo(i)
						local shortname, _ = strsplit("-", name)
						if shortname == guildmembername and unitclass then
							HardcoreMonitor:SetAlpha(1)
							local classcolor = E:ClassColor(unitclass, true)
							HardcoreMonitor.StatusLine:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)
							HardcoreMonitor.StatusLine2:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)
							ChangeChatColor("GUILD_DEATHS", classcolor.r, classcolor.g, classcolor.b) --works for chat frame only
							_G.RaidWarningFrameSlot1:SetTextColor(classcolor.r, classcolor.g, classcolor.b) --fixed raid warning
							E:Delay(5, function()
								local hcalpha = HardcoreMonitor:GetAlpha()
								if hcalpha ~= 0 then
									UIFrameFadeOut(HardcoreMonitor, 1, 1, 0)
								end
							end)
							--PlaySound(8959)
							--PlaySound(8960)
							PlaySoundFile(E.LSM:Fetch("sound", "Warcraft 3 - Night Elf Ally Dies"), "Master")
						end
					end
				end
			end
		end)
	end
end

--basic blizzard message dialog
if _G.BasicMessageDialog then
	S:HandleFrame(_G.BasicMessageDialog)
	if _G._G.BasicMessageDialogButton then
		S:HandleButton(_G._G.BasicMessageDialogButton)
	end
end
