local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local CreateFrame = _G.CreateFrame
local UIPanelWindows = _G.UIPanelWindows
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

				--WardrobeTransmogFrame.ItemsCollectionFrame.TopLeftCorner:Hide()
				--WardrobeTransmogFrame.ItemsCollectionFrame.BottomRightCorner:Hide()
				--WardrobeTransmogFrame.ItemsCollectionFrame.Center:Hide()
				--WardrobeTransmogFrame.ItemsCollectionFrame.TopEdge:Hide()
				--WardrobeTransmogFrame.ItemsCollectionFrame.BottomEdge:Hide()
				--WardrobeTransmogFrame.ItemsCollectionFrame.RightEdge:Hide()
				--WardrobeTransmogFrame.ItemsCollectionFrame.LeftEdge:Hide()
			end
		end)
	end
end)
