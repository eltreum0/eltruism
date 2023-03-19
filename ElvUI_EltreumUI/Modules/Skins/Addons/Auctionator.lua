local E, L, V, P, G = unpack(ElvUI)
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

--simple tab skin
function ElvUI_EltreumUI:EltruismAuctionator()
	if E.private.skins.blizzard.enable then
		hooksecurefunc(_G.AuctionatorTabContainerMixin, "OnLoad", function()
			for _, tab in next, _G.AuctionatorAHTabsContainer.Tabs do
				S:HandleTab(tab)
				if tab.backdrop and not tab.backdrop.shadow then
					tab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(tab.backdrop.shadow) end
				end
			end
		end)
	end
end
S:AddCallbackForAddon('Auctionator', "EltruismAuctionator", ElvUI_EltreumUI.EltruismAuctionator)
