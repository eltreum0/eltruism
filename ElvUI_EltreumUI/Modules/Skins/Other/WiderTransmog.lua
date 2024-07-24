local E = unpack(ElvUI)
local _G = _G
local UIPanelWindows = _G.UIPanelWindows
local S = E:GetModule('Skins')

--Wider Transmog Window
function ElvUI_EltreumUI:WiderTransmog()
	if not _G.WardrobeTransmogFrame then return end
	_G.WardrobeTransmogFrame:HookScript("OnShow", function()
		if not _G.WardrobeFrame then return end
		if E.db.ElvUI_EltreumUI.skins.widertransmog then

			--whole window
			_G.WardrobeFrame:SetWidth(1200)
			_G.WardrobeTransmogFrame:SetWidth(530)
			_G.WardrobeTransmogFrame:SetHeight(_G.WardrobeFrame:GetHeight() -130)
			_G.WardrobeTransmogFrame:SetPoint("TOP", _G.WardrobeFrame, 0, 0)

			--player model frame
			if E.Retail then
				_G.WardrobeTransmogFrame.ModelScene:ClearAllPoints()
				_G.WardrobeTransmogFrame.ModelScene:SetPoint("TOP", _G.WardrobeTransmogFrame, "TOP", 20, 10)
				_G.WardrobeTransmogFrame.ModelScene:SetAllPoints(_G.WardrobeTransmogFrame)
				--_G.WardrobeTransmogFrame.ModelScene:SetWidth(500)
				--_G.WardrobeTransmogFrame.ModelScene:SetHeight(450)
				if _G.WardrobeTransmogFrame.OutfitDropdown then
					_G.WardrobeTransmogFrame.OutfitDropdown:ClearAllPoints()
					_G.WardrobeTransmogFrame.OutfitDropdown:SetPoint("TOPLEFT", _G.WardrobeTransmogFrame, "TOPLEFT", 0, 50)
				end
			else
				_G.WardrobeTransmogFrame.Model:ClearAllPoints()
				_G.WardrobeTransmogFrame.Model:SetPoint("TOP", _G.WardrobeTransmogFrame, "TOP", 20, 10)
				_G.WardrobeTransmogFrame.Model:SetAllPoints(_G.WardrobeTransmogFrame)
			end

			--head button (with the help of gregory)
			_G.WardrobeTransmogFrame.HeadButton:ClearAllPoints()
			_G.WardrobeTransmogFrame.HeadButton:SetPoint("TOPLEFT", _G.WardrobeTransmogFrame, "TOPLEFT", 20, 0)

			---shoulder button
			_G.WardrobeTransmogFrame.ShoulderButton:ClearAllPoints()
			_G.WardrobeTransmogFrame.ShoulderButton:SetPoint("TOP", _G.WardrobeTransmogFrame.HeadButton, "TOP", 0, -55)

			--shoulder toggle for offshoulder
			_G.WardrobeTransmogFrame.ToggleSecondaryAppearanceCheckbox:ClearAllPoints()
			_G.WardrobeTransmogFrame.ToggleSecondaryAppearanceCheckbox:SetPoint("BOTTOM", _G.WardrobeCollectionFrame, "BOTTOM", -240, 40)

			--background
			_G.WardrobeTransmogFrame.Inset.BG:SetAllPoints(_G.WardrobeTransmogFrame)

			--hands button
			_G.WardrobeTransmogFrame.HandsButton:ClearAllPoints()
			_G.WardrobeTransmogFrame.HandsButton:SetPoint("TOP", _G.WardrobeTransmogFrame, "TOP", 240, -120)
			--main weapon
			_G.WardrobeTransmogFrame.MainHandButton:ClearAllPoints()
			_G.WardrobeTransmogFrame.MainHandButton:SetPoint("TOP", _G.WardrobeTransmogFrame, "BOTTOM", -50, 50)
			--offhand
			_G.WardrobeTransmogFrame.SecondaryHandButton:ClearAllPoints()
			_G.WardrobeTransmogFrame.SecondaryHandButton:SetPoint("TOP", _G.WardrobeTransmogFrame, "BOTTOM", 50, 50)
			--and their enchants
			if E.Retail then
				_G.WardrobeTransmogFrame.MainHandEnchantButton:ClearAllPoints()
				_G.WardrobeTransmogFrame.MainHandEnchantButton:SetPoint("BOTTOM", _G.WardrobeTransmogFrame.MainHandButton, "BOTTOM", 0, -28)
				_G.WardrobeTransmogFrame.SecondaryHandEnchantButton:ClearAllPoints()
				_G.WardrobeTransmogFrame.SecondaryHandEnchantButton:SetPoint("BOTTOM", _G.WardrobeTransmogFrame.SecondaryHandButton, "BOTTOM", 0, -28)
				UIPanelWindows["WardrobeFrame"].width = 1200
			end

			if E.private.skins.blizzard.enable then
				_G.WardrobeCollectionFrame.ItemsCollectionFrame.TopLeftCorner:Hide()
				_G.WardrobeCollectionFrame.ItemsCollectionFrame.BottomRightCorner:Hide()
				_G.WardrobeCollectionFrame.ItemsCollectionFrame.Center:Hide()
				_G.WardrobeCollectionFrame.ItemsCollectionFrame.TopEdge:Hide()
				_G.WardrobeCollectionFrame.ItemsCollectionFrame.BottomEdge:Hide()
				_G.WardrobeCollectionFrame.ItemsCollectionFrame.RightEdge:Hide()
				_G.WardrobeCollectionFrame.ItemsCollectionFrame.LeftEdge:Hide()

				if E.Retail then
					--in case of thick borders/2pixels
					_G.WardrobeCollectionFrame.ItemsCollectionFrame.NineSlice.BottomEdge:Hide()
					_G.WardrobeCollectionFrame.ItemsCollectionFrame.NineSlice.BottomLeftCorner:Hide()
					_G.WardrobeCollectionFrame.ItemsCollectionFrame.NineSlice.BottomRightCorner:Hide()
					_G.WardrobeCollectionFrame.ItemsCollectionFrame.NineSlice.LeftEdge:Hide()
					_G.WardrobeCollectionFrame.ItemsCollectionFrame.NineSlice.RightEdge:Hide()
					_G.WardrobeCollectionFrame.ItemsCollectionFrame.NineSlice.TopEdge:Hide()
					_G.WardrobeCollectionFrame.ItemsCollectionFrame.NineSlice.TopLeftCorner:Hide()
					_G.WardrobeCollectionFrame.ItemsCollectionFrame.NineSlice.TopRightCorner:Hide()
					if _G.WardrobeCollectionFrame.ItemsCollectionFrame.oborder then
						_G.WardrobeCollectionFrame.ItemsCollectionFrame.oborder:Hide()
					end
					if _G.WardrobeCollectionFrame.ItemsCollectionFrame.iborder then
						_G.WardrobeCollectionFrame.ItemsCollectionFrame.iborder:Hide()
					end

					_G.WardrobeCollectionFrame.SetsTransmogFrame.TopLeftCorner:Hide()
					_G.WardrobeCollectionFrame.SetsTransmogFrame.BottomRightCorner:Hide()
					_G.WardrobeCollectionFrame.SetsTransmogFrame.Center:Hide()
					_G.WardrobeCollectionFrame.SetsTransmogFrame.TopEdge:Hide()
					_G.WardrobeCollectionFrame.SetsTransmogFrame.BottomEdge:Hide()
					_G.WardrobeCollectionFrame.SetsTransmogFrame.RightEdge:Hide()
					_G.WardrobeCollectionFrame.SetsTransmogFrame.LeftEdge:Hide()

					--in case of thick borders/2pixels
					_G.WardrobeCollectionFrame.SetsTransmogFrame.NineSlice.BottomEdge:Hide()
					_G.WardrobeCollectionFrame.SetsTransmogFrame.NineSlice.BottomLeftCorner:Hide()
					_G.WardrobeCollectionFrame.SetsTransmogFrame.NineSlice.BottomRightCorner:Hide()
					_G.WardrobeCollectionFrame.SetsTransmogFrame.NineSlice.LeftEdge:Hide()
					_G.WardrobeCollectionFrame.SetsTransmogFrame.NineSlice.RightEdge:Hide()
					_G.WardrobeCollectionFrame.SetsTransmogFrame.NineSlice.TopEdge:Hide()
					_G.WardrobeCollectionFrame.SetsTransmogFrame.NineSlice.TopLeftCorner:Hide()
					_G.WardrobeCollectionFrame.SetsTransmogFrame.NineSlice.TopRightCorner:Hide()
					if _G.WardrobeCollectionFrame.SetsTransmogFrame.oborder then
						_G.WardrobeCollectionFrame.SetsTransmogFrame.oborder:Hide()
					end
					if _G.WardrobeCollectionFrame.SetsTransmogFrame.iborder then
						_G.WardrobeCollectionFrame.SetsTransmogFrame.iborder:Hide()
					end
				end
			end
		end
	end)
end
S:AddCallbackForAddon('Blizzard_Collections', "EltruismWiderTransmog", ElvUI_EltreumUI.WiderTransmog)
