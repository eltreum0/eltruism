local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G

--Wider Transmog Window
local EltruismWiderTransmog = CreateFrame("Frame", "EltruismWiderTransmog")
EltruismWiderTransmog:RegisterEvent("ADDON_LOADED")
EltruismWiderTransmog:SetScript("OnEvent", function(_, _, arg)
	--print("widetransmog spam")
	if (arg == "Blizzard_Collections") then
		EltruismWiderTransmog:UnregisterAllEvents()
		WardrobeTransmogFrame:HookScript("OnShow", function()
			if E.db.ElvUI_EltreumUI.skins.widertransmog then
				--whole window
				_G.WardrobeFrame:SetWidth(1200)
				--player model frame
				_G.WardrobeTransmogFrame:SetWidth(530)
				_G.WardrobeTransmogFrame:SetHeight(_G.WardrobeFrame:GetHeight() -130)
				_G.WardrobeTransmogFrame:SetPoint("TOP", _G.WardrobeFrame, 0, 0)
				_G.WardrobeTransmogFrame.ModelScene:ClearAllPoints()
				_G.WardrobeTransmogFrame.ModelScene:SetPoint("TOP", _G.WardrobeTransmogFrame, "TOP", 20, 10)
				_G.WardrobeTransmogFrame.ModelScene:SetAllPoints(_G.WardrobeTransmogFrame)
				--_G.WardrobeTransmogFrame.ModelScene:SetWidth(500)
				--_G.WardrobeTransmogFrame.ModelScene:SetHeight(450)
				_G.WardrobeOutfitDropDown:ClearAllPoints()
				_G.WardrobeOutfitDropDown:SetPoint("TOPLEFT", _G.WardrobeTransmogFrame, "TOPLEFT", 0, 50)

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
				_G.WardrobeTransmogFrame.MainHandEnchantButton:ClearAllPoints()
				_G.WardrobeTransmogFrame.MainHandEnchantButton:SetPoint("BOTTOM", _G.WardrobeTransmogFrame.MainHandButton, "BOTTOM", 0, -28)
				_G.WardrobeTransmogFrame.SecondaryHandEnchantButton:ClearAllPoints()
				_G.WardrobeTransmogFrame.SecondaryHandEnchantButton:SetPoint("BOTTOM", _G.WardrobeTransmogFrame.SecondaryHandButton, "BOTTOM", 0, -28)
				_G.UIPanelWindows["WardrobeFrame"].width = 1200

				--_G.WardrobeTransmogFrame.ItemsCollectionFrame.TopLeftCorner:Hide()
				--_G.WardrobeTransmogFrame.ItemsCollectionFrame.BottomRightCorner:Hide()
				--_G.WardrobeTransmogFrame.ItemsCollectionFrame.Center:Hide()
				--_G.WardrobeTransmogFrame.ItemsCollectionFrame.TopEdge:Hide()
				--_G.WardrobeTransmogFrame.ItemsCollectionFrame.BottomEdge:Hide()
				--_G.WardrobeTransmogFrame.ItemsCollectionFrame.RightEdge:Hide()
				--_G.WardrobeTransmogFrame.ItemsCollectionFrame.LeftEdge:Hide()
			end
		end)
	end
end)
