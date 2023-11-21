local E = unpack(ElvUI)
local _G = _G
local CreateFrame = _G.CreateFrame
local UIPanelWindows = _G.UIPanelWindows
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded
local WardrobeFrame
local WardrobeTransmogFrame
local WardrobeOutfitDropDown
local WardrobeCollectionFrame

--Wider Transmog Window
local EltruismWiderTransmog = CreateFrame("Frame", "EltruismWiderTransmog")
EltruismWiderTransmog:RegisterEvent("ADDON_LOADED")
EltruismWiderTransmog:SetScript("OnEvent", function(_, _, arg)
	--print("widetransmog spam")
	if (arg == "Blizzard_Collections") or IsAddOnLoaded("Blizzard_Collections") then
		EltruismWiderTransmog:UnregisterAllEvents()
		WardrobeFrame = _G.WardrobeFrame
		WardrobeTransmogFrame = _G.WardrobeTransmogFrame
		WardrobeOutfitDropDown = _G.WardrobeOutfitDropDown
		WardrobeCollectionFrame = _G.WardrobeCollectionFrame
		WardrobeTransmogFrame:HookScript("OnShow", function()
			if E.db.ElvUI_EltreumUI.skins.widertransmog then
				--whole window
				WardrobeFrame:SetWidth(1200)
				--player model frame
				WardrobeTransmogFrame:SetWidth(530)
				WardrobeTransmogFrame:SetHeight(WardrobeFrame:GetHeight() -130)
				WardrobeTransmogFrame:SetPoint("TOP", WardrobeFrame, 0, 0)
				WardrobeTransmogFrame.ModelScene:ClearAllPoints()
				WardrobeTransmogFrame.ModelScene:SetPoint("TOP", WardrobeTransmogFrame, "TOP", 20, 10)
				WardrobeTransmogFrame.ModelScene:SetAllPoints(WardrobeTransmogFrame)
				--WardrobeTransmogFrame.ModelScene:SetWidth(500)
				--WardrobeTransmogFrame.ModelScene:SetHeight(450)
				WardrobeOutfitDropDown:ClearAllPoints()
				WardrobeOutfitDropDown:SetPoint("TOPLEFT", WardrobeTransmogFrame, "TOPLEFT", 0, 50)

				--head button (with the help of gregory)
				WardrobeTransmogFrame.HeadButton:ClearAllPoints()
				WardrobeTransmogFrame.HeadButton:SetPoint("TOPLEFT", WardrobeTransmogFrame, "TOPLEFT", 20, 0)

				---shoulder button
				WardrobeTransmogFrame.ShoulderButton:ClearAllPoints()
				WardrobeTransmogFrame.ShoulderButton:SetPoint("TOP", WardrobeTransmogFrame.HeadButton, "TOP", 0, -55)

				--shoulder toggle for offshoulder
				WardrobeTransmogFrame.ToggleSecondaryAppearanceCheckbox:ClearAllPoints()
				WardrobeTransmogFrame.ToggleSecondaryAppearanceCheckbox:SetPoint("BOTTOM", WardrobeCollectionFrame, "BOTTOM", -240, 40)

				--background
				WardrobeTransmogFrame.Inset.BG:SetAllPoints(WardrobeTransmogFrame)

				--hands button
				WardrobeTransmogFrame.HandsButton:ClearAllPoints()
				WardrobeTransmogFrame.HandsButton:SetPoint("TOP", WardrobeTransmogFrame, "TOP", 240, -120)
				--main weapon
				WardrobeTransmogFrame.MainHandButton:ClearAllPoints()
				WardrobeTransmogFrame.MainHandButton:SetPoint("TOP", WardrobeTransmogFrame, "BOTTOM", -50, 50)
				--offhand
				WardrobeTransmogFrame.SecondaryHandButton:ClearAllPoints()
				WardrobeTransmogFrame.SecondaryHandButton:SetPoint("TOP", WardrobeTransmogFrame, "BOTTOM", 50, 50)
				--and their enchants
				WardrobeTransmogFrame.MainHandEnchantButton:ClearAllPoints()
				WardrobeTransmogFrame.MainHandEnchantButton:SetPoint("BOTTOM", WardrobeTransmogFrame.MainHandButton, "BOTTOM", 0, -28)
				WardrobeTransmogFrame.SecondaryHandEnchantButton:ClearAllPoints()
				WardrobeTransmogFrame.SecondaryHandEnchantButton:SetPoint("BOTTOM", WardrobeTransmogFrame.SecondaryHandButton, "BOTTOM", 0, -28)
				UIPanelWindows["WardrobeFrame"].width = 1200

				if E.private.skins.blizzard.enable then
					WardrobeCollectionFrame.ItemsCollectionFrame.TopLeftCorner:Hide()
					WardrobeCollectionFrame.ItemsCollectionFrame.BottomRightCorner:Hide()
					WardrobeCollectionFrame.ItemsCollectionFrame.Center:Hide()
					WardrobeCollectionFrame.ItemsCollectionFrame.TopEdge:Hide()
					WardrobeCollectionFrame.ItemsCollectionFrame.BottomEdge:Hide()
					WardrobeCollectionFrame.ItemsCollectionFrame.RightEdge:Hide()
					WardrobeCollectionFrame.ItemsCollectionFrame.LeftEdge:Hide()

					--in case of thick borders/2pixels
					WardrobeCollectionFrame.ItemsCollectionFrame.NineSlice.BottomEdge:Hide()
					WardrobeCollectionFrame.ItemsCollectionFrame.NineSlice.BottomLeftCorner:Hide()
					WardrobeCollectionFrame.ItemsCollectionFrame.NineSlice.BottomRightCorner:Hide()
					WardrobeCollectionFrame.ItemsCollectionFrame.NineSlice.LeftEdge:Hide()
					WardrobeCollectionFrame.ItemsCollectionFrame.NineSlice.RightEdge:Hide()
					WardrobeCollectionFrame.ItemsCollectionFrame.NineSlice.TopEdge:Hide()
					WardrobeCollectionFrame.ItemsCollectionFrame.NineSlice.TopLeftCorner:Hide()
					WardrobeCollectionFrame.ItemsCollectionFrame.NineSlice.TopRightCorner:Hide()
					if WardrobeCollectionFrame.ItemsCollectionFrame.oborder then
						WardrobeCollectionFrame.ItemsCollectionFrame.oborder:Hide()
					end
					if WardrobeCollectionFrame.ItemsCollectionFrame.iborder then
						WardrobeCollectionFrame.ItemsCollectionFrame.iborder:Hide()
					end

					WardrobeCollectionFrame.SetsTransmogFrame.TopLeftCorner:Hide()
					WardrobeCollectionFrame.SetsTransmogFrame.BottomRightCorner:Hide()
					WardrobeCollectionFrame.SetsTransmogFrame.Center:Hide()
					WardrobeCollectionFrame.SetsTransmogFrame.TopEdge:Hide()
					WardrobeCollectionFrame.SetsTransmogFrame.BottomEdge:Hide()
					WardrobeCollectionFrame.SetsTransmogFrame.RightEdge:Hide()
					WardrobeCollectionFrame.SetsTransmogFrame.LeftEdge:Hide()

					--in case of thick borders/2pixels
					WardrobeCollectionFrame.SetsTransmogFrame.NineSlice.BottomEdge:Hide()
					WardrobeCollectionFrame.SetsTransmogFrame.NineSlice.BottomLeftCorner:Hide()
					WardrobeCollectionFrame.SetsTransmogFrame.NineSlice.BottomRightCorner:Hide()
					WardrobeCollectionFrame.SetsTransmogFrame.NineSlice.LeftEdge:Hide()
					WardrobeCollectionFrame.SetsTransmogFrame.NineSlice.RightEdge:Hide()
					WardrobeCollectionFrame.SetsTransmogFrame.NineSlice.TopEdge:Hide()
					WardrobeCollectionFrame.SetsTransmogFrame.NineSlice.TopLeftCorner:Hide()
					WardrobeCollectionFrame.SetsTransmogFrame.NineSlice.TopRightCorner:Hide()
					if WardrobeCollectionFrame.SetsTransmogFrame.oborder then
						WardrobeCollectionFrame.SetsTransmogFrame.oborder:Hide()
					end
					if WardrobeCollectionFrame.SetsTransmogFrame.iborder then
						WardrobeCollectionFrame.SetsTransmogFrame.iborder:Hide()
					end
				end
			end
		end)
	end
end)
