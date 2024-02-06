local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local tabSkinned = false

local function handlechildtab(frame)
	for _, v in pairs{frame:GetChildren()} do
		if v:IsObjectType('Button') then
			if v.Text then
				S:HandleTab(v)
				v.Text:ClearAllPoints()
				v.Text:SetPoint("CENTER", v, "CENTER", 0, 0)
			end
		end
	end
end

function ElvUI_EltreumUI:SkinAuctionator()
	if E.db.ElvUI_EltreumUI.skins.auctionator then
		if E.private.skins.blizzard.enable then
			if _G.AuctionatorShoppingFrame and not _G.AuctionatorShoppingFrame.EltruismSkin then

				--scanning thing
				if not E.Retail then
					S:HandleFrame(_G["AuctionatorPageStatusDialogFrame"])
				end

				--shopping
				S:HandleFrame(_G["AuctionatorShoppingFrame"])
				S:HandleFrame(_G["AuctionatorShoppingFrame"].ShoppingResultsInset)
				if not E.Retail then
					_G["AuctionatorShoppingFrame"].ShoppingResultsInset:SetBackdrop()
					_G["AuctionatorShoppingFrame"].ListsContainer:CreateBackdrop()
					S:HandleButton(_G["AuctionatorShoppingFrame"].LoadAllPagesButton)
					for _, v in pairs{_G["AuctionatorShoppingFrame"].ShoppingResultsInset:GetChildren()} do
						if v.BorderBottomLeft then
							v:Kill()
						end
					end
				else
					_G["AuctionatorShoppingFrame"].ShoppingResultsInset:CreateBackdrop()
					if _G["AuctionatorShoppingFrame"].ShoppingResultsInset.eltruismbgtexture then
						_G["AuctionatorShoppingFrame"].ShoppingResultsInset.eltruismbgtexture:Hide()
					end
				end
				S:HandleFrame(_G["AuctionatorShoppingFrame"].SearchOptions)
				_G["AuctionatorShoppingFrame"].SearchOptions:SetBackdrop()
				if _G["AuctionatorShoppingFrame"].SearchOptions.eltruismbgtexture then
					_G["AuctionatorShoppingFrame"].SearchOptions.eltruismbgtexture:Hide()
				end
				S:HandleFrame(_G["AuctionatorShoppingFrame"].ResultsListing)
				_G["AuctionatorShoppingFrame"].ResultsListing:SetBackdrop()
				if _G["AuctionatorShoppingFrame"].ResultsListing.eltruismbgtexture then
					_G["AuctionatorShoppingFrame"].ResultsListing.eltruismbgtexture:Hide()
				end
				_G["AuctionatorShoppingFrame"].RecentsContainer.Inset:Hide()
				S:HandleFrame(_G["AuctionatorShoppingFrame"].ListsContainer)
				_G["AuctionatorShoppingFrame"].ListsContainer:SetBackdrop()
				if _G["AuctionatorShoppingFrame"].ListsContainer.eltruismbgtexture then
					_G["AuctionatorShoppingFrame"].ListsContainer.eltruismbgtexture:Hide()
				end
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
				S:HandleFrame(_G["AuctionatorImportListFrame"])
				S:HandleCloseButton(_G["AuctionatorImportListFrame"].CloseDialog)
				S:HandleButton(_G["AuctionatorImportListFrame"].Import)
				S:HandleTrimScrollBar(_G["AuctionatorImportListFrame"].ScrollBar)
				_G["AuctionatorImportListFrame"].Inset:Hide()
				S:HandleFrame(_G["AuctionatorExportListFrame"])
				S:HandleCloseButton(_G["AuctionatorExportListFrame"].CloseDialog)
				S:HandleButton(_G["AuctionatorExportListFrame"].Export)
				S:HandleButton(_G["AuctionatorExportListFrame"].UnselectAll)
				S:HandleButton(_G["AuctionatorExportListFrame"].SelectAll)
				S:HandleTrimScrollBar(_G["AuctionatorExportListFrame"].ScrollBar)
				_G["AuctionatorExportListFrame"].Inset:Hide()
				--S:HandleCloseButton(_G["AuctionatorShoppingFrame"].SearchOptions.ResetSearchStringButton) --makes button too small and theres too many of them
				S:HandleTab(_G["AuctionatorShoppingFrame"].ContainerTabs.ListsTab)
				_G["AuctionatorShoppingFrame"].ContainerTabs.ListsTab:SetHeight(25)
				_G["AuctionatorShoppingFrame"].ContainerTabs.ListsTab.Text:ClearAllPoints()
				_G["AuctionatorShoppingFrame"].ContainerTabs.ListsTab.Text:SetPoint("CENTER",_G["AuctionatorShoppingFrame"].ContainerTabs.ListsTab)
				_G["AuctionatorShoppingFrame"].ContainerTabs.ListsTab.Text.SetPoint = E.noop
				S:HandleTab(_G["AuctionatorShoppingFrame"].ContainerTabs.RecentsTab)
				_G["AuctionatorShoppingFrame"].ContainerTabs.RecentsTab:SetHeight(25)
				_G["AuctionatorShoppingFrame"].ContainerTabs.RecentsTab.Text:ClearAllPoints()
				_G["AuctionatorShoppingFrame"].ContainerTabs.RecentsTab.Text:SetPoint("CENTER",_G["AuctionatorShoppingFrame"].ContainerTabs.RecentsTab)
				_G["AuctionatorShoppingFrame"].ContainerTabs.RecentsTab.Text.SetPoint = E.noop

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
				if _G["AuctionatorSellingFrame"].eltruismbgtexture then
					_G["AuctionatorSellingFrame"].eltruismbgtexture:Hide()
				end

				local function handlesubframe(frame)
					if frame.eltruismbgtexture then frame.eltruismbgtexture:Hide() end
					if frame.Icon then
						frame.Icon:SetTexCoord(unpack(E.TexCoords))
						frame.IconBorder:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\itemBorder.tga")
						frame.IconSelectedHighlight:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\itemBorder.tga")
						if frame.NormalTexture then
							frame.NormalTexture:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\itemBorder.tga")
						end
						if frame.HighlightTexture then
							frame.HighlightTexture:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\itemBorder.tga")
						end
					else
						if frame.NormalTexture then
							frame.NormalTexture:SetAlpha(0)
							frame.NormalTexture.SetAlpha = E.noop
						end
						if frame.HighlightTexture then
							frame.HighlightTexture:SetAlpha(0)
							frame.HighlightTexture.SetAlpha = E.noop
						end
					end
					if frame.AddButton and not frame.EltruismAddButtonHook then
						hooksecurefunc(frame,"AddButton",function(_,item)
							if item.Icon then
								item.Icon:SetTexCoord(unpack(E.TexCoords))
								item.IconBorder:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\itemBorder.tga")
							end
						end)
						frame.EltruismAddButtonHook = true
					end
					if frame:GetObjectType() ~= "Texture" then
						for i = 1, frame:GetNumChildren() do
							local subframe = select(i, frame:GetChildren())
							if subframe then
								if subframe:GetObjectType() == "Frame" then
									--S:HandleFrame(subframe) --causes erors in non pixel perfect mode (non thin mode)
									--subframe:SetBackdrop()
									if subframe.NormalTexture then
										subframe.NormalTexture:SetAlpha(0)
										subframe.NormalTexture.SetAlpha = E.noop
									end
									if subframe.HighlightTexture then
										subframe.HighlightTexture:SetAlpha(0)
										subframe.HighlightTexture.SetAlpha = E.noop
									end
								elseif subframe:GetObjectType() == "Button" then
									S:HandleButton(subframe)
								elseif subframe:GetObjectType() == "EditBox" then
									S:HandleEditBox(subframe)
									subframe:SetTemplate()
								elseif subframe:GetObjectType() == "CheckButton" then
									S:HandleButton(subframe)
								end
								handlesubframe(subframe)
							end
						end
					end
				end

				local function handlesubregions(frame)
					if frame.eltruismbgtexture then frame.eltruismbgtexture:Hide() end
					if frame.Icon then --doesnt seem to find any
						frame.Icon:SetTexCoord(unpack(E.TexCoords))
						frame.IconBorder:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\itemBorder.tga")
						frame.IconSelectedHighlight:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\itemBorder.tga")
					end
					if frame.NormalTexture then
						frame.NormalTexture:SetAlpha(0)
						frame.NormalTexture.SetAlpha = E.noop
					end
					if frame.HighlightTexture then
						frame.HighlightTexture:SetAlpha(0)
						frame.HighlightTexture.SetAlpha = E.noop
					end
					if frame:GetObjectType() ~= "Texture" then
						for i = 1, frame:GetNumRegions() do
							local subregion = select(i, frame:GetRegions())
							if subregion then
								if subregion:GetObjectType() == "Frame" then
									S:HandleFrame(subregion)
									subregion:SetBackdrop()
									if subregion.NormalTexture then
										subregion.NormalTexture:SetAlpha(0)
										subregion.NormalTexture.SetAlpha = E.noop
									end
									if subregion.HighlightTexture then
										subregion.HighlightTexture:SetAlpha(0)
										subregion.HighlightTexture.SetAlpha = E.noop
									end
								elseif subregion:GetObjectType() == "Button" then
									S:HandleButton(subregion)
								elseif subregion:GetObjectType() == "EditBox" then
									S:HandleEditBox(subregion)
									subregion:SetTemplate()
								elseif subregion:GetObjectType() == "CheckButton" then
									S:HandleButton(subregion)
								end
								handlesubregions(subregion)
							end
						end
					end
				end

				--auctionator removed this frame
				--[[hooksecurefunc(_G.Auctionator.Groups,"OpenCustomiseView",function()
					if not _G["AuctionatorGroupsCustomiseFrame"].EltruismSkin then
						S:HandleFrame(_G["AuctionatorGroupsCustomiseFrame"])
						S:HandleButton(_G["AuctionatorGroupsCustomiseFrame"].NewGroupButton)
						S:HandleButton(_G["AuctionatorGroupsCustomiseFrame"].BackButton)
						S:HandleTrimScrollBar(_G["AuctionatorGroupsCustomiseFrame"].View.ScrollBar)

						handlesubframe(_G["AuctionatorGroupsCustomiseFrame"].View.ScrollBox)
						if _G["AuctionatorGroupsCustomiseFrame"].View.ScrollBox.ScrollTarget then
							handlesubregions(_G["AuctionatorGroupsCustomiseFrame"].View.ScrollBox.ScrollTarget)
						end

						if E.db.ElvUI_EltreumUI.skins.shadow.enable and not _G["AuctionatorGroupsCustomiseFrame"].shadow then
							_G["AuctionatorGroupsCustomiseFrame"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G["AuctionatorGroupsCustomiseFrame"].shadow)
						end

						_G["AuctionatorGroupsCustomiseFrame"].EltruismSkin = true
					end
				end)]]

				hooksecurefunc(_G.Auctionator.Selling,"ShowPopup",function()
					E:Delay(0, function()
						if not _G["AuctionatorSellingPopupFrame"].EltruismSkin then
							S:HandleFrame(_G["AuctionatorSellingPopupFrame"])
							_G["AuctionatorSellingPopupFrame"].EltruismSkin = true
						end
					end)
				end)

				if not _G["AuctionatorSellingFrame"].BagListing.EltruismViewHook then --items update late, and they might also change, so hook view
					_G["AuctionatorSellingFrame"].BagListing:HookScript("OnShow", function()
						E:Delay(0, function()
							handlesubframe(_G["AuctionatorSellingFrame"].BagListing.View.ScrollBox.ItemListingFrame)
						end)
					end)
					_G["AuctionatorSellingFrame"].BagListing.EltruismViewHook = true
				end
				--[[if _G["AuctionatorSellingFrame"].BagListing then
					S:HandleButton(_G["AuctionatorSellingFrame"].BagListing.CustomiseButton) --auctionator removed this frame
				end]]
				S:HandleTrimScrollBar(_G["AuctionatorSellingFrame"].BagListing.View.ScrollBar)

				if _G["AuctionatorItemHistoryFrame"] then
					S:HandleFrame(_G["AuctionatorItemHistoryFrame"])
					S:HandleButton(_G["AuctionatorItemHistoryFrame"].Close)
					S:HandleButton(_G["AuctionatorItemHistoryFrame"].Dock)
					S:HandleTrimScrollBar(_G["AuctionatorItemHistoryFrame"].ResultsListing.ScrollArea.ScrollBar)
					handlechildtab(_G["AuctionatorItemHistoryFrame"].ResultsListing.HeaderContainer)
				end

				if _G["AuctionatorBuyFrame"] then
					if _G["AuctionatorBuyFrame"].CurrentPrices then
						S:HandleTrimScrollBar(_G["AuctionatorBuyFrame"].CurrentPrices.SearchResultsListing.ScrollArea.ScrollBar)
						S:HandleButton(_G["AuctionatorBuyFrame"].CurrentPrices.RefreshButton)
						S:HandleButton(_G["AuctionatorBuyFrame"].CurrentPrices.BuyButton)
						S:HandleButton(_G["AuctionatorBuyFrame"].CurrentPrices.CancelButton)
						handlechildtab(_G["AuctionatorBuyFrame"].CurrentPrices.SearchResultsListing.HeaderContainer)
						_G["AuctionatorBuyFrame"].CurrentPrices.Inset:Hide()
						_G["AuctionatorBuyFrame"].CurrentPrices:CreateBackdrop()
					end
					S:HandleButton(_G["AuctionatorBuyFrame"].ReturnButton)
					S:HandleButton(_G["AuctionatorBuyFrame"].HistoryButton)
					if _G["AuctionatorBuyFrame"].HistoryPrices then
						S:HandleButton(_G["AuctionatorBuyFrame"].HistoryPrices.RealmHistoryButton)
						S:HandleButton(_G["AuctionatorBuyFrame"].HistoryPrices.PostingHistoryButton)
						handlechildtab(_G["AuctionatorBuyFrame"].HistoryPrices.RealmHistoryResultsListing.HeaderContainer)
						handlechildtab(_G["AuctionatorBuyFrame"].HistoryPrices.ResultsListing.HeaderContainer)
						S:HandleTrimScrollBar(_G["AuctionatorBuyFrame"].HistoryPrices.RealmHistoryResultsListing.ScrollArea.ScrollBar)
						S:HandleTrimScrollBar(_G["AuctionatorBuyFrame"].HistoryPrices.ResultsListing.ScrollArea.ScrollBar)
						_G["AuctionatorBuyFrame"].HistoryPrices.Inset:Hide()
						_G["AuctionatorBuyFrame"].HistoryPrices:CreateBackdrop()
					end
				end
				if _G["AuctionatorBuyItemFrame"] then
					S:HandleButton(_G["AuctionatorBuyItemFrame"].BackButton)
					S:HandleButton(_G["AuctionatorBuyItemFrame"].BuyDialog.Buy)
					S:HandleButton(_G["AuctionatorBuyItemFrame"].BuyDialog.Cancel)
					S:HandleFrame(_G["AuctionatorBuyItemFrame"].BuyDialog)
					if _G["AuctionatorBuyItemFrame"].ResultsListing then
						S:HandleFrame(_G["AuctionatorBuyItemFrame"].ResultsListing)
						handlechildtab(_G["AuctionatorBuyItemFrame"].ResultsListing.HeaderContainer)
						S:HandleTrimScrollBar(_G["AuctionatorBuyItemFrame"].ResultsListing.ScrollArea.ScrollBar)
						_G["AuctionatorBuyItemFrame"].Inset:Hide()
					end
				end

				if _G["AuctionatorSellingFrame"].CurrentPricesListing then
					S:HandleFrame(_G["AuctionatorSellingFrame"].CurrentPricesListing.ScrollArea)
					_G["AuctionatorSellingFrame"].CurrentPricesListing.ScrollArea:SetBackdrop()
					if _G["AuctionatorSellingFrame"].CurrentPricesListing.ScrollArea.eltruismbgtexture then
						_G["AuctionatorSellingFrame"].CurrentPricesListing.ScrollArea.eltruismbgtexture:Hide()
					end
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
				if _G["AuctionatorSellingFrame"].SaleItemFrame.Quantity then
					S:HandleEditBox(_G["AuctionatorSellingFrame"].SaleItemFrame.Quantity.InputBox)
				end
				if _G["AuctionatorSellingFrame"].SaleItemFrame.Price then
					S:HandleEditBox(_G["AuctionatorSellingFrame"].SaleItemFrame.Price.MoneyInput.GoldBox)
					S:HandleEditBox(_G["AuctionatorSellingFrame"].SaleItemFrame.Price.MoneyInput.SilverBox)
				end

				--handle radio buttons
				if _G["AuctionatorSellingFrame"].SaleItemFrame.Duration then
					for i = 1, _G["AuctionatorSellingFrame"].SaleItemFrame.Duration:GetNumChildren() do
						local subframe = select(i, _G["AuctionatorSellingFrame"].SaleItemFrame.Duration:GetChildren())
						if subframe and subframe.RadioButton then
							S:HandleRadioButton(subframe.RadioButton)
						end
					end
				end

				--also based on simpy's skin but different
				if _G["AuctionatorSellingFrame"].SaleItemFrame and not _G["AuctionatorSellingFrame"].SaleItemFrame.backdrop then
					_G["AuctionatorSellingFrame"].SaleItemFrame.Icon.Icon:SetTexCoord(unpack(E.TexCoords))
					_G["AuctionatorSellingFrame"].SaleItemFrame:StyleButton()
					_G["AuctionatorSellingFrame"].SaleItemFrame:CreateBackdrop()
					_G["AuctionatorSellingFrame"].SaleItemFrame.Icon.EmptySlot:Hide()
					_G["AuctionatorSellingFrame"].SaleItemFrame.backdrop:SetPoint("TOPLEFT",_G["AuctionatorSellingFrame"].SaleItemFrame.Icon,"TOPLEFT",-1,1)
					_G["AuctionatorSellingFrame"].SaleItemFrame.backdrop:SetPoint("BOTTOMRIGHT",_G["AuctionatorSellingFrame"].SaleItemFrame.Icon,"BOTTOMRIGHT",1,-1)
					--[[
					hooksecurefunc(_G["AuctionatorSellingFrame"].SaleItemFrame.Icon.IconBorder,"SetVertexColor", function(_,r,g,b)
						_G["AuctionatorSellingFrame"].SaleItemFrame.backdrop:SetBackdropBorderColor(r, g, b, 1)
						_G["AuctionatorSellingFrame"].SaleItemFrame.Icon.IconBorder:SetAlpha(0)
					end)]]
					_G["AuctionatorSellingFrame"].SaleItemFrame.Icon.IconBorder:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\itemBorder.tga")
					_G["AuctionatorSellingFrame"].SaleItemFrame.Icon.IconSelectedHighlight:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\itemBorder.tga")
				end

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
					S:HandleEditBox(_G["AuctionatorSellingFrame"].SaleItemFrame.UnitPrice.MoneyInput.GoldBox)
					S:HandleEditBox(_G["AuctionatorSellingFrame"].SaleItemFrame.UnitPrice.MoneyInput.SilverBox)
					S:HandleEditBox(_G["AuctionatorSellingFrame"].SaleItemFrame.UnitPrice.MoneyInput.CopperBox)
					S:HandleEditBox(_G["AuctionatorSellingFrame"].SaleItemFrame.StackPrice.MoneyInput.GoldBox)
					S:HandleEditBox(_G["AuctionatorSellingFrame"].SaleItemFrame.StackPrice.MoneyInput.SilverBox)
					S:HandleEditBox(_G["AuctionatorSellingFrame"].SaleItemFrame.StackPrice.MoneyInput.CopperBox)
					S:HandleEditBox(_G["AuctionatorSellingFrame"].SaleItemFrame.Stacks.NumStacks)
					S:HandleEditBox(_G["AuctionatorSellingFrame"].SaleItemFrame.Stacks.StackSize)
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

					S:HandleFrame(_G["AuctionatorSellingFrame"].BuyFrame.HistoryPrices)
					S:HandleFrame(_G["AuctionatorSellingFrame"].BuyFrame.HistoryPrices.ResultsListing)
					_G["AuctionatorSellingFrame"].BuyFrame.HistoryPrices.ResultsListing.Center:Hide()
					if _G["AuctionatorSellingFrame"].BuyFrame.HistoryPrices.ResultsListing.eltruismbgtexture then
						_G["AuctionatorSellingFrame"].BuyFrame.HistoryPrices.ResultsListing.eltruismbgtexture:Hide()
					end
					S:HandleTrimScrollBar(_G["AuctionatorSellingFrame"].BuyFrame.HistoryPrices.ResultsListing.ScrollArea.ScrollBar)
					handlechildtab(_G["AuctionatorSellingFrame"].BuyFrame.HistoryPrices.ResultsListing.HeaderContainer)
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
					if _G["AuctionatorBuyCommodityFrame"].ResultsListing.ScrollArea.eltruismbgtexture then
						_G["AuctionatorBuyCommodityFrame"].ResultsListing.ScrollArea.eltruismbgtexture:Hide()
					end
					_G["AuctionatorBuyCommodityFrame"].ResultsListing.ScrollArea:CreateBackdrop()
					handlechildtab(_G["AuctionatorBuyCommodityFrame"].ResultsListing.HeaderContainer)

					S:HandleFrame(_G["AuctionatorBuyCommodityFrame"].FinalConfirmationDialog)
					S:HandleButton(_G["AuctionatorBuyCommodityFrame"].FinalConfirmationDialog.AcceptButton)
					S:HandleButton(_G["AuctionatorBuyCommodityFrame"].FinalConfirmationDialog.CancelButton)

					--based on simpy's skin
					if _G["AuctionatorBuyCommodityFrame"].IconAndName and not _G["AuctionatorBuyCommodityFrame"].IconAndName.backdrop then
						_G["AuctionatorBuyCommodityFrame"].IconAndName:CreateBackdrop()
						_G["AuctionatorBuyCommodityFrame"].IconAndName:StyleButton()
						_G["AuctionatorBuyCommodityFrame"].IconAndName.backdrop:SetPoint("TOPLEFT",_G["AuctionatorBuyCommodityFrame"].IconAndName.Icon,"TOPLEFT",-1,1)
						_G["AuctionatorBuyCommodityFrame"].IconAndName.backdrop:SetPoint("BOTTOMRIGHT",_G["AuctionatorBuyCommodityFrame"].IconAndName.Icon,"BOTTOMRIGHT",1,-1)
						_G["AuctionatorBuyCommodityFrame"].IconAndName.Icon:SetTexCoord(unpack(E.TexCoords))
						S:HandleIconBorder(_G["AuctionatorBuyCommodityFrame"].IconAndName.QualityBorder, _G["AuctionatorBuyCommodityFrame"].IconAndName.backdrop)
					end
				end

				--cancelling
				S:HandleFrame(_G["AuctionatorCancellingFrame"])
				_G["AuctionatorCancellingFrame"]:SetBackdrop()
				if _G["AuctionatorCancellingFrame"].eltruismbgtexture then
					_G["AuctionatorCancellingFrame"].eltruismbgtexture:Hide()
				end
				S:HandleEditBox(_G["AuctionatorCancellingFrame"].SearchFilter)
				S:HandleFrame(_G["AuctionatorCancellingFrame"].ResultsListing)
				_G["AuctionatorCancellingFrame"].ResultsListing:SetBackdrop()
				if _G["AuctionatorCancellingFrame"].ResultsListing.eltruismbgtexture then
					_G["AuctionatorCancellingFrame"].ResultsListing.eltruismbgtexture:Hide()
				end
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
				if _G["AuctionatorConfigFrame"].eltruismbgtexture then
					_G["AuctionatorConfigFrame"].eltruismbgtexture:Hide()
				end
				S:HandleEditBox(_G["AuctionatorConfigFrame"].DiscordLink.InputBox)
				S:HandleEditBox(_G["AuctionatorConfigFrame"].BugReportLink.InputBox)
				S:HandleButton(_G["AuctionatorConfigFrame"].ScanButton)
				S:HandleButton(_G["AuctionatorConfigFrame"].OptionsButton)

				for _,v in pairs{_G["AuctionatorConfigFrame"]:GetChildren()} do
					if v.BorderLeftMiddle then
						v:Hide()
					end
				end

				_G["AuctionatorShoppingFrame"]:SetBackdrop()
				if _G["AuctionatorShoppingFrame"].eltruismbgtexture then
					_G["AuctionatorShoppingFrame"].eltruismbgtexture:Hide()
				end

				_G.AuctionatorShoppingFrame.EltruismSkin = true
			end
		end
	end
end

--simple tab skin
function ElvUI_EltreumUI:EltruismAuctionFrame()
	if E.db.ElvUI_EltreumUI.skins.auctionator then
		if E.private.skins.blizzard.enable then
			ElvUI_EltreumUI:SkinAuctionator()
			if E.Retail then
				_G["AuctionHouseFrame"]:HookScript("OnShow",function()
					if not tabSkinned then
						E:Delay(0, function()
							ElvUI_EltreumUI:SkinAuctionator()
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
							ElvUI_EltreumUI:SkinAuctionator()
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
end
S:AddCallbackForAddon('Blizzard_AuctionHouseUI', "EltruismAuctionFrame", ElvUI_EltreumUI.EltruismAuctionFrame)
S:AddCallbackForAddon('Blizzard_AuctionUI', "EltruismAuctionFrame", ElvUI_EltreumUI.EltruismAuctionFrame)
S:AddCallbackForAddon('Auctionator', "EltruismAuctionator", ElvUI_EltreumUI.SkinAuctionator)
