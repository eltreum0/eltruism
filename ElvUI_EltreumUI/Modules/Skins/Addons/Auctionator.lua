local addon, Engine = ...
local E, L, V, P, G = unpack(ElvUI)
local ElvUI_EltreumUI = E:GetModule(addon)
local S = E:GetModule('Skins')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local next = _G.next
--local LibAHTab = LibStub("LibAHTab-1-0")
local EnhancedShadows = nil
local IsAddOnLoaded = _G.IsAddOnLoaded
if IsAddOnLoaded("ProjectAzilroka") then
	EnhancedShadows = _G.ProjectAzilroka:GetModule('EnhancedShadows')
end
local tabSkinned = false

--simple tab skin
function ElvUI_EltreumUI:EltruismAuctionator()
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
												if EnhancedShadows then EnhancedShadows:RegisterShadow(v.backdrop.shadow) end
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
									if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["AuctionFrameTab"..i].backdrop.shadow) end
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
--S:AddCallbackForAddon('Auctionator', "EltruismAuctionator", ElvUI_EltreumUI.EltruismAuctionator)
--S:AddCallbackForAddon('TradeSkillMaster', "EltruismAuctionator", ElvUI_EltreumUI.EltruismAuctionator)
S:AddCallbackForAddon('Blizzard_AuctionHouseUI', "EltruismAuctionator", ElvUI_EltreumUI.EltruismAuctionator)
S:AddCallbackForAddon('Blizzard_AuctionUI', "EltruismAuctionator", ElvUI_EltreumUI.EltruismAuctionator)
