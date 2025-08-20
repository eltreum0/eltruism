local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local PlaySoundFile = _G.PlaySoundFile
local CreateFrame = _G.CreateFrame
local C_GameRules = _G.C_GameRules

function ElvUI_EltreumUI:EltruismScrap()
	E:Delay(0, function()
		if _G["MerchantFrameSecureTab0"] then
			S:HandleTab(_G["MerchantFrameSecureTab0"])
			if E.db.ElvUI_EltreumUI.skins.shadow.enable and _G["MerchantFrameSecureTab0"].backdrop and not _G["MerchantFrameSecureTab0"].backdrop.shadow and not E.db.ElvUI_EltreumUI.borders.universalborders then
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
			HardcoreMonitor:SetScript("OnEvent", function()
				if C_GameRules.IsHardcoreActive() then
					E:Delay(4,function() PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\overconfidence.ogg" , "Master") end)
				end
			end)
		end

		--the new event HARDCORE_DEATHS, does not return name of the unit, so this is gone
		--[[if E.db.ElvUI_EltreumUI.skins.guildmemberdeathhardcore then
			HardcoreMonitor:RegisterEvent("HARDCORE_DEATHS") --GUILD_MEMBER_DIED was removed
			--HardcoreMonitor:RegisterEvent("CHAT_MSG_GUILD_DEATHS") --also removed
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
		end)]]
	end
end

--basic blizzard message dialog
if _G.BasicMessageDialog then
	S:HandleFrame(_G.BasicMessageDialog)
	if _G._G.BasicMessageDialogButton then
		S:HandleButton(_G.BasicMessageDialogButton)
	end
end

--world quest tab... tab
function ElvUI_EltreumUI:EltruismWQT()
	local tab = _G.WQT_QuestMapTab
	if not tab then return end

	--from elvui, skin it the same way as the other tabs on the map frame
	tab:CreateBackdrop()
	tab:Size(30, 40)

	if tab.Background then
		tab.Background:SetAlpha(0)
	end

	if tab.SelectedTexture then
		tab.SelectedTexture:SetDrawLayer('ARTWORK')
		tab.SelectedTexture:SetColorTexture(1, 0.82, 0, 0.3)
		tab.SelectedTexture:SetAllPoints()
	end

	for _, region in next, { tab:GetRegions() } do
		if region:IsObjectType('Texture') and region:GetAtlas() == 'QuestLog-Tab-side-Glow-hover' then
			region:SetColorTexture(1, 1, 1, 0.3)
			region:SetAllPoints()
		end
	end

	if E.db.ElvUI_EltreumUI.skins.shadow.enable then
		if E.db.ElvUI_EltreumUI.skins.shadow.blizzard and E.private.skins.blizzard.enable and not E.db.ElvUI_EltreumUI.borders.universalborders then
			if tab.backdrop and not tab.backdrop.shadow then
					tab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(tab.backdrop.shadow)
			end
		end
	end
end
S:AddCallbackForAddon('WorldQuestTab', "EltruismWQT", ElvUI_EltreumUI.EltruismWQT)
