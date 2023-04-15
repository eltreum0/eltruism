local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
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
function ElvUI_EltreumUI:EltruismHardcore()
	local HardcoreMonitor = CreateFrame("Frame")
	HardcoreMonitor:RegisterEvent("PLAYER_DEAD")
	HardcoreMonitor:SetScript("OnEvent", function()
		PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\overconfidence.ogg" , "Master")
	end)
end
S:AddCallbackForAddon('Hardcore', "EltruismHardcore", ElvUI_EltreumUI.EltruismHardcore)
