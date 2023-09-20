local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local tabSkinned = false

local function handlechildtab(frame)
	for _, v in pairs{frame:GetChildren()} do
		if v:IsObjectType('Button') then
			if v.Text then
				S:HandleTab(v)
			end
		end
	end
end

local function SkinAuctionator()
	if _G.AuctionatorShoppingFrame and not _G.AuctionatorShoppingFrame.EltruismSkin then

		--shopping
		S:HandleFrame(_G["AuctionatorShoppingFrame"])
		_G["AuctionatorShoppingFrame"]:SetBackdrop()
		_G["AuctionatorShoppingFrame"].eltruismbgtexture:Hide()
		S:HandleFrame(_G["AuctionatorShoppingFrame"].ShoppingResultsInset)
		if not E.Retail then
			_G["AuctionatorShoppingFrame"].ShoppingResultsInset:SetBackdrop()
			_G["AuctionatorShoppingFrame"].ListsContainer:CreateBackdrop()
			for _, v in pairs{_G["AuctionatorShoppingFrame"].ShoppingResultsInset:GetChildren()} do
				if v.BorderBottomLeft then
					v:Kill()
				end
			end
		else
			_G["AuctionatorShoppingFrame"].ShoppingResultsInset:CreateBackdrop()
			_G["AuctionatorShoppingFrame"].ShoppingResultsInset.eltruismbgtexture:Hide()
		end
		S:HandleFrame(_G["AuctionatorShoppingFrame"].SearchOptions)
		_G["AuctionatorShoppingFrame"].SearchOptions:SetBackdrop()
		_G["AuctionatorShoppingFrame"].SearchOptions.eltruismbgtexture:Hide()
		S:HandleFrame(_G["AuctionatorShoppingFrame"].ResultsListing)
		_G["AuctionatorShoppingFrame"].ResultsListing:SetBackdrop()
		_G["AuctionatorShoppingFrame"].ResultsListing.eltruismbgtexture:Hide()
		_G["AuctionatorShoppingFrame"].RecentsContainer.Inset:Hide()
		S:HandleFrame(_G["AuctionatorShoppingFrame"].ListsContainer)
		_G["AuctionatorShoppingFrame"].ListsContainer:SetBackdrop()
		_G["AuctionatorShoppingFrame"].ListsContainer.eltruismbgtexture:Hide()
		if not E.Retail then
			_G["AuctionatorShoppingFrame"].ListsContainer.Inset:Hide()
			_G["AuctionatorShoppingFrame"].ListsContainer:CreateBackdrop()
		else
			_G["AuctionatorShoppingFrame"].ListsContainer.Inset:CreateBackdrop()
		end
		_G["AuctionatorShoppingFrame"].RecentsContainer.ScrollBox:CreateBackdrop()
		handlechildtab(_G["AuctionatorShoppingFrame"].ResultsListing.HeaderContainer)
		S:HandleButton(_G["AuctionatorShoppingFrame"].ExportButton)
		S:HandleButton(_G["AuctionatorShoppingFrame"].ImportButton)
		S:HandleButton(_G["AuctionatorShoppingFrame"].NewListButton)
		S:HandleButton(_G["AuctionatorShoppingFrame"].ExportCSV)
		S:HandleButton(_G["AuctionatorShoppingFrame"].SearchOptions.SearchButton)
		S:HandleButton(_G["AuctionatorShoppingFrame"].SearchOptions.MoreButton)
		S:HandleButton(_G["AuctionatorShoppingFrame"].SearchOptions.AddToListButton)
		--S:HandleCloseButton(_G["AuctionatorShoppingFrame"].SearchOptions.ResetSearchStringButton) --makes button too small and theres too many of them
		S:HandleButton(_G["AuctionatorShoppingFrame"].ContainerTabs.ListsTab)
		S:HandleButton(_G["AuctionatorShoppingFrame"].ContainerTabs.RecentsTab)
		S:HandleEditBox(_G["AuctionatorShoppingFrame"].SearchOptions.SearchString)
		S:HandleTrimScrollBar(_G["AuctionatorShoppingFrame"].ResultsListing.ScrollArea.ScrollBar)
		S:HandleTrimScrollBar(_G["AuctionatorShoppingFrame"].RecentsContainer.ScrollBar)
		S:HandleTrimScrollBar(_G["AuctionatorShoppingFrame"].ListsContainer.ScrollBar)

		--shopping tab frame
		S:HandleFrame(_G["AuctionatorShoppingTabItemFrame"])
		S:HandleButton(_G["AuctionatorShoppingTabItemFrame"].Cancel)
		S:HandleButton(_G["AuctionatorShoppingTabItemFrame"].ResetAllButton)
		S:HandleButton(_G["AuctionatorShoppingTabItemFrame"].Finished)
		S:HandleEditBox(_G["AuctionatorShoppingTabItemFrame"].SearchContainer.SearchString)
		S:HandleCheckBox(_G["AuctionatorShoppingTabItemFrame"].SearchContainer.IsExact)
		S:HandleEditBox(_G["AuctionatorShoppingTabItemFrame"].LevelRange.MinBox)
		S:HandleEditBox(_G["AuctionatorShoppingTabItemFrame"].LevelRange.MaxBox)
		S:HandleEditBox(_G["AuctionatorShoppingTabItemFrame"].ItemLevelRange.MinBox)
		S:HandleEditBox(_G["AuctionatorShoppingTabItemFrame"].ItemLevelRange.MaxBox)
		S:HandleEditBox(_G["AuctionatorShoppingTabItemFrame"].PriceRange.MinBox)
		S:HandleEditBox(_G["AuctionatorShoppingTabItemFrame"].PriceRange.MaxBox)
		S:HandleEditBox(_G["AuctionatorShoppingTabItemFrame"].CraftedLevelRange.MinBox)
		S:HandleEditBox(_G["AuctionatorShoppingTabItemFrame"].CraftedLevelRange.MaxBox)
		S:HandleEditBox(_G["AuctionatorShoppingTabItemFrame"].PurchaseQuantity.InputBox)
		S:HandleDropDownBox(_G["AuctionatorShoppingTabItemFrame_FilterKeySelector"],240)
		S:HandleDropDownBox(_G["AuctionatorShoppingTabItemFrame"].QualityContainer.DropDown.DropDown,200)
		S:HandleDropDownBox(_G["AuctionatorShoppingTabItemFrame"].ExpansionContainer.DropDown.DropDown,200)
		S:HandleDropDownBox(_G["AuctionatorShoppingTabItemFrame"].TierContainer.DropDown.DropDown,200)
		if _G["AuctionatorShoppingTabItemFrame"].Inset then
			_G["AuctionatorShoppingTabItemFrame"].Inset:Hide()
		end

		--selling
		S:HandleFrame(_G["AuctionatorSellingFrame"])
		_G["AuctionatorSellingFrame"]:SetBackdrop()
		_G["AuctionatorSellingFrame"].eltruismbgtexture:Hide()
		S:HandleFrame(_G["AuctionatorSellingFrame"].BagListing)
		_G["AuctionatorSellingFrame"].BagListing:SetBackdrop()
		_G["AuctionatorSellingFrame"].BagListing.eltruismbgtexture:Hide()
		_G["AuctionatorSellingFrame"].BagListing:CreateBackdrop()
		_G["AuctionatorSellingFrame"].BagListing.ScrollBox:SetTemplate()
		_G["AuctionatorSellingFrame"].BagListing.ScrollBox:SetBackdrop()
		_G["AuctionatorSellingFrame"].BagListing.ScrollBox.eltruismbgtexture:Hide()
		S:HandleTrimScrollBar(_G["AuctionatorSellingFrame"].BagListing.ScrollBar)
		if _G["AuctionatorBuyFrame"] then
			if _G["AuctionatorBuyFrame"].CurrentPrices then
				S:HandleTrimScrollBar(_G["AuctionatorBuyFrame"].CurrentPrices.SearchResultsListing.ScrollArea.ScrollBar)
			end
			S:HandleButton(_G["AuctionatorBuyFrame"].ReturnButton)
			S:HandleButton(_G["AuctionatorBuyFrame"].HistoryButton)
			S:HandleButton(_G["AuctionatorBuyFrame"].CurrentPrices.RefreshButton)
			S:HandleButton(_G["AuctionatorBuyFrame"].CurrentPrices.BuyButton)
			S:HandleButton(_G["AuctionatorBuyFrame"].CurrentPrices.CancelButton)
			handlechildtab(_G["AuctionatorBuyFrame"].CurrentPrices.SearchResultsListing.HeaderContainer)
			_G["AuctionatorBuyFrame"].CurrentPrices.Inset:Hide()
			_G["AuctionatorBuyFrame"].CurrentPrices:CreateBackdrop()
		end
		if _G["AuctionatorSellingFrame"].CurrentPricesListing then
			S:HandleFrame(_G["AuctionatorSellingFrame"].CurrentPricesListing.ScrollArea)
			_G["AuctionatorSellingFrame"].CurrentPricesListing.ScrollArea:SetBackdrop()
			_G["AuctionatorSellingFrame"].CurrentPricesListing.ScrollArea.eltruismbgtexture:Hide()
			_G["AuctionatorSellingFrame"].CurrentPricesListing.ScrollArea:CreateBackdrop()
			S:HandleTrimScrollBar(_G["AuctionatorSellingFrame"].CurrentPricesListing.ScrollArea.ScrollBar)
			handlechildtab(_G["AuctionatorSellingFrame"].CurrentPricesListing.HeaderContainer)
		end
		if _G["AuctionatorSellingFrame"].HistoricalPriceListing then
			_G["AuctionatorSellingFrame"].HistoricalPriceListing.ScrollArea:CreateBackdrop()
			S:HandleTrimScrollBar(_G["AuctionatorSellingFrame"].HistoricalPriceListing.ScrollArea.ScrollBar)
			handlechildtab(_G["AuctionatorSellingFrame"].HistoricalPriceListing.HeaderContainer)
		end
		if _G["AuctionatorSellingFrame"].PostingHistoryListing then
			_G["AuctionatorSellingFrame"].PostingHistoryListing.ScrollArea:CreateBackdrop()
			S:HandleTrimScrollBar(_G["AuctionatorSellingFrame"].PostingHistoryListing.ScrollArea.ScrollBar)
			handlechildtab(_G["AuctionatorSellingFrame"].PostingHistoryListing.HeaderContainer)
		end
		if _G["AuctionatorSellingFrame"].AuctionatorSaleItem.Quantity then
			S:HandleEditBox(_G["AuctionatorSellingFrame"].AuctionatorSaleItem.Quantity.InputBox)
		end
		if _G["AuctionatorSellingFrame"].AuctionatorSaleItem.Price then
			S:HandleEditBox(_G["AuctionatorSellingFrame"].AuctionatorSaleItem.Price.MoneyInput.GoldBox)
			S:HandleEditBox(_G["AuctionatorSellingFrame"].AuctionatorSaleItem.Price.MoneyInput.SilverBox)
		end
		S:HandleButton(_G["AuctionatorSellingFrame"].AuctionatorSaleItem.Icon)
		if _G["AuctionatorSellingFrame"].PricesTabsContainer then
			S:HandleTab(_G["AuctionatorSellingFrame"].PricesTabsContainer.CurrentPricesTab)
			S:HandleTab(_G["AuctionatorSellingFrame"].PricesTabsContainer.PriceHistoryTab)
			S:HandleTab(_G["AuctionatorSellingFrame"].PricesTabsContainer.YourHistoryTab)
		end
		if _G["AuctionatorSellingFrame"].SaleItemFrame then
			if _G["AuctionatorSellingFrame"].SaleItemFrame.MaxButton then
				S:HandleButton(_G["AuctionatorSellingFrame"].SaleItemFrame.MaxButton)
			end
			if _G["AuctionatorSellingFrame"].HistoricalPriceInset then
				_G["AuctionatorSellingFrame"].HistoricalPriceInset:Hide()
			end
			_G["AuctionatorSellingFrame"].BagInset:Hide()
			S:HandleButton(_G["AuctionatorPostButton"])
			S:HandleButton(_G["AuctionatorSkipPostingButton"])
		end
		if _G["AuctionatorSellingFrame"].BuyFrame then
			S:HandleButton(_G["AuctionatorSellingFrame"].BuyFrame.HistoryButton)
			S:HandleButton(_G["AuctionatorSellingFrame"].BuyFrame.CurrentPrices.RefreshButton)
			S:HandleButton(_G["AuctionatorSellingFrame"].BuyFrame.CurrentPrices.BuyButton)
			S:HandleButton(_G["AuctionatorSellingFrame"].BuyFrame.CurrentPrices.CancelButton)
			S:HandleButton(_G["AuctionatorSellingFrame"].BuyFrame.HistoryPrices.RealmHistoryButton)
			S:HandleButton(_G["AuctionatorSellingFrame"].BuyFrame.HistoryPrices.PostingHistoryButton)
			S:HandleEditBox(_G["AuctionatorSellingFrame"].AuctionatorSaleItem.UnitPrice.MoneyInput.GoldBox)
			S:HandleEditBox(_G["AuctionatorSellingFrame"].AuctionatorSaleItem.UnitPrice.MoneyInput.SilverBox)
			S:HandleEditBox(_G["AuctionatorSellingFrame"].AuctionatorSaleItem.UnitPrice.MoneyInput.CopperBox)
			S:HandleEditBox(_G["AuctionatorSellingFrame"].AuctionatorSaleItem.StackPrice.MoneyInput.GoldBox)
			S:HandleEditBox(_G["AuctionatorSellingFrame"].AuctionatorSaleItem.StackPrice.MoneyInput.SilverBox)
			S:HandleEditBox(_G["AuctionatorSellingFrame"].AuctionatorSaleItem.StackPrice.MoneyInput.CopperBox)
			S:HandleButton(_G["AuctionatorSellingFrame"].AuctionatorSaleItem.Stacks.NumStacks)
			S:HandleButton(_G["AuctionatorSellingFrame"].AuctionatorSaleItem.Stacks.StackSize)
			S:HandleTrimScrollBar(_G["AuctionatorSellingFrame"].BuyFrame.HistoryPrices.RealmHistoryResultsListing.ScrollArea.ScrollBar)
			S:HandleTrimScrollBar(_G["AuctionatorSellingFrame"].BuyFrame.CurrentPrices.SearchResultsListing.ScrollArea.ScrollBar)
			handlechildtab(_G["AuctionatorSellingFrame"].BuyFrame.HistoryPrices.RealmHistoryResultsListing.HeaderContainer)
			handlechildtab(_G["AuctionatorSellingFrame"].BuyFrame.CurrentPrices.SearchResultsListing.HeaderContainer)
			for _, v in pairs{_G["AuctionatorSellingFrame"].BuyFrame.CurrentPrices.Inset:GetChildren()} do
				if v.BorderBottomLeft then
					v:Kill()
				end
			end
			for _, v in pairs{_G["AuctionatorSellingFrame"].BuyFrame.HistoryPrices.Inset:GetChildren()} do
				if v.BorderBottomLeft then
					v:Kill()
				end
			end
		end

		--buying
		if E.Retail then
			S:HandleButton(_G["AuctionatorBuyCommodityFrame"].BackButton)
			S:HandleButton(_G["AuctionatorBuyCommodityFrame"].DetailsContainer.BuyButton)
			S:HandleEditBox(_G["AuctionatorBuyCommodityFrame"].DetailsContainer.Quantity)
			S:HandleTrimScrollBar(_G["AuctionatorBuyCommodityFrame"].ResultsListing.ScrollArea.ScrollBar)
			_G["AuctionatorBuyCommodityFrame"].Inset:Hide()
			S:HandleFrame(_G["AuctionatorBuyCommodityFrame"].ResultsListing.ScrollArea)
			_G["AuctionatorBuyCommodityFrame"].ResultsListing.ScrollArea:SetBackdrop()
			_G["AuctionatorBuyCommodityFrame"].ResultsListing.ScrollArea.eltruismbgtexture:Hide()
			_G["AuctionatorBuyCommodityFrame"].ResultsListing.ScrollArea:CreateBackdrop()
			handlechildtab(_G["AuctionatorBuyCommodityFrame"].ResultsListing.HeaderContainer)
		end

		--cancelling
		S:HandleFrame(_G["AuctionatorCancellingFrame"])
		_G["AuctionatorCancellingFrame"]:SetBackdrop()
		_G["AuctionatorCancellingFrame"].eltruismbgtexture:Hide()
		S:HandleEditBox(_G["AuctionatorCancellingFrame"].SearchFilter)
		S:HandleFrame(_G["AuctionatorCancellingFrame"].ResultsListing)
		_G["AuctionatorCancellingFrame"].ResultsListing:SetBackdrop()
		_G["AuctionatorCancellingFrame"].ResultsListing.eltruismbgtexture:Hide()
		S:HandleTrimScrollBar(_G["AuctionatorCancellingFrame"].ResultsListing.ScrollArea.ScrollBar)
		_G["AuctionatorCancellingFrame"].HistoricalPriceInset:Hide()
		handlechildtab(_G["AuctionatorCancellingFrame"].ResultsListing.HeaderContainer)

		for _, v in pairs{_G["AuctionatorCancellingFrame"]:GetChildren()} do
			if v.CancelNextButton then
				S:HandleButton(v.CancelNextButton)
				S:HandleButton(v.StartScanButton)
			end
		end

		--config
		S:HandleFrame(_G["AuctionatorConfigFrame"])
		_G["AuctionatorConfigFrame"]:SetBackdrop()
		_G["AuctionatorConfigFrame"].eltruismbgtexture:Hide()
		S:HandleEditBox(_G["AuctionatorConfigFrame"].DiscordLink.InputBox)
		S:HandleEditBox(_G["AuctionatorConfigFrame"].BugReportLink.InputBox)
		S:HandleButton(_G["AuctionatorConfigFrame"].ScanButton)
		S:HandleButton(_G["AuctionatorConfigFrame"].OptionsButton)

		_G.AuctionatorShoppingFrame.EltruismSkin = true
	end
end

--simple tab skin
function ElvUI_EltreumUI:EltruismAuctionator()
	if E.db.ElvUI_EltreumUI.skins.auctionator then
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
					E:Delay(0, function()
						SkinAuctionator()
					end)
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
					E:Delay(0, function()
						SkinAuctionator()
					end)
				end)
			end
		end
	end
end
S:AddCallbackForAddon('Blizzard_AuctionHouseUI', "EltruismAuctionator", ElvUI_EltreumUI.EltruismAuctionator)
S:AddCallbackForAddon('Blizzard_AuctionUI', "EltruismAuctionator", ElvUI_EltreumUI.EltruismAuctionator)
--S:AddCallbackForAddon('Auctionator', "EltruismAuctionator", ElvUI_EltreumUI.EltruismAuction)
