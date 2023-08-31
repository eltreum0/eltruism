local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local tabSkinned = false

--simple tab skin
function ElvUI_EltreumUI:EltruismAuction()
	if E.private.skins.blizzard.enable then
		if E.Retail then
			_G["AuctionHouseFrame"]:HookScript("OnShow",function()
				if not tabSkinned then
					E:Delay(0, function()
						for _, j in pairs{_G["AuctionHouseFrame"]:GetChildren()} do
							if j:GetNumChildren() >= 3 then
								for _, v in pairs{j:GetChildren()} do
									if v:IsObjectType('Button') then
										if v.tabHeader then
											S:HandleTab(v)
											if E.db.ElvUI_EltreumUI.skins.shadow.enable and v.backdrop and not v.backdrop.shadow then
												v.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
												ElvUI_EltreumUI:ShadowColor(v.backdrop.shadow)
											end
											tabSkinned = true
										end
									end
								end
							end
						end
					end)
				end
			end)
		else
			_G["AuctionFrame"]:HookScript("OnShow",function()
				if not tabSkinned then
					E:Delay(0, function()
						for i = 4, 8 do
							if _G["AuctionFrameTab"..i] then
								S:HandleTab(_G["AuctionFrameTab"..i])
								if E.db.ElvUI_EltreumUI.skins.shadow.enable and _G["AuctionFrameTab"..i].backdrop and not _G["AuctionFrameTab"..i].backdrop.shadow then
									_G["AuctionFrameTab"..i].backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
									ElvUI_EltreumUI:ShadowColor(_G["AuctionFrameTab"..i].backdrop.shadow)
								end
								tabSkinned = true
							end
						end
					end)
				end
			end)
		end
	end
end
S:AddCallbackForAddon('Blizzard_AuctionHouseUI', "EltruismAuctionator", ElvUI_EltreumUI.EltruismAuction)
S:AddCallbackForAddon('Blizzard_AuctionUI', "EltruismAuctionator", ElvUI_EltreumUI.EltruismAuction)

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

--secret
if E.ClassicHC then
	local HardcoreMonitor = CreateFrame("Frame", "EltruismHardcoreDeathMonitor")
	HardcoreMonitor:SetPoint("CENTER", _G.RaidWarningFrame)
	local x,y = _G.RaidWarningFrame:GetSize()
	HardcoreMonitor:SetSize(x,y)

	HardcoreMonitor.StatusLine = CreateFrame("StatusBar", "EltruismHardcoreDeathLine", HardcoreMonitor)
	HardcoreMonitor.StatusLine:SetSize(418, 3)
	HardcoreMonitor.StatusLine:SetPoint("TOP", _G.RaidWarningFrameSlot1, 0, 5)
	HardcoreMonitor.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)

	HardcoreMonitor.StatusLine2 = CreateFrame("StatusBar", "EltruismHardcoreDeathLine2", HardcoreMonitor)
	HardcoreMonitor.StatusLine2:SetSize(418, 3)
	HardcoreMonitor.StatusLine2:SetPoint("BOTTOM", _G.RaidWarningFrameSlot1, 0, -5)
	HardcoreMonitor.StatusLine2:SetStatusBarTexture(E.Media.Textures.Highlight)

	HardcoreMonitor:SetAlpha(0)

	HardcoreMonitor:RegisterEvent("PLAYER_DEAD")
	HardcoreMonitor:RegisterEvent("GUILD_MEMBER_DIED")
	HardcoreMonitor:RegisterEvent("CHAT_MSG_GUILD_DEATHS")
	--HardcoreMonitor:RegisterEvent("PLAYER_STARTED_MOVING")
	HardcoreMonitor:SetScript("OnEvent", function(_,event,guildmembername)
		if C_GameRules.IsHardcoreActive() then
			if event == "PLAYER_DEAD" then
				E:Delay(4,function() PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\overconfidence.ogg" , "Master") end)
			else
				if not guildmembername then return end
				for i = 1, GetNumGuildMembers() do
					local name, _, _, _, _, _, _, _, _, _, unitclass = GetGuildRosterInfo(i)
					local shortname, _ = strsplit("-", name)
					if shortname == guildmembername and unitclass then
						print(name,unitclass)
						HardcoreMonitor:SetAlpha(1)
						local classcolor = E:ClassColor(unitclass, true)
						HardcoreMonitor.StatusLine:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)
						HardcoreMonitor.StatusLine2:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)
						ChangeChatColor("GUILD_DEATHS", classcolor.r, classcolor.g, classcolor.b) --works for chat frame only
						_G.RaidWarningFrameSlot1:SetTextColor(classcolor.r, classcolor.g, classcolor.b) --fixed raid warning
						E:Delay(7, function()
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

--basic blizzard message dialog
if _G.BasicMessageDialog then
	S:HandleFrame(_G.BasicMessageDialog)
	if _G._G.BasicMessageDialogButton then
		S:HandleButton(_G._G.BasicMessageDialogButton)
	end
end
