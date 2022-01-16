local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local CreateFrame = _G.CreateFrame
local unpack = _G.unpack
--local UnitClass = _G.UnitClass --currently unused
local R, G, B = unpack(E.media.rgbvaluecolor)

--average item level calculation, this is the highest memory table i've seen
--need to figure out how to decrease usage if possible, but for now we collect garbage if not in combat
--should be fine since the event to update is only called when player ilvl changes, which should not be often
--except i spammed equip changes and it goes up drastically, thus the function
--will need to see how it will end up in the future with more usage
function ElvUI_EltreumUI:UpdateAvgIlvl()
	if ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
		if E.db.ElvUI_EltreumUI.skins.classicarmory then

			--from Simple Item Levels by Kemayo (BSD License) with some edits by Eltreum
			local function PrepareItemButton(button)
				if button.eltruismilvl then
					return
				end
				local overlayFrame = CreateFrame("FRAME", nil, button)
				--overlayFrame:SetFrameLevel(9999) -- this was bugging out inspect
				overlayFrame:SetAllPoints()
				button.eltruismilvl = overlayFrame:CreateFontString('$parentItemLevel', 'OVERLAY')
				button.eltruismilvl:SetPoint('CENTER', 0, 0)
				button.eltruismilvl:SetFont(E.LSM:Fetch("font", E.db.general.font), 16, "THICKOUTLINE")
				button.eltruismilvl:SetJustifyH('LEFT')
				--button.eltruismilvl:Hide()
			end


			local function AddLevelToButton(button, itemLevel, itemQuality)
				if not itemLevel then
					return button.eltruismilvl and button.eltruismilvl:Hide()
				end
				PrepareItemButton(button)
				local _, _, _, hex = GetItemQualityColor(itemQuality)
				button.eltruismilvl:SetFormattedText('|c%s%s|r', hex, itemLevel or '?')
				button.eltruismilvl:Show()
			end

			local function GetItemQualityAndLevel(unit, slotID)
				-- link is more reliably fetched than ID, for whatever reason
				local itemLink = GetInventoryItemLink(unit, slotID)
				if itemLink ~= nil then
					local quality = GetInventoryItemQuality(unit, slotID)
					local level = GetDetailedItemLevelInfo(itemLink)
					return quality, level
				end
			end



			-- this is the taxing part of the function, since the GetItemQualityAndLevel is getting called multiple times and updating for every single slot when one changes
			local ilvltable ={}
			for i=1, 20 do
				local _, i = GetItemQualityAndLevel("player", i)
				table.insert(ilvltable, i)
			end

			--[[

				local _, ilvl1 = GetItemQualityAndLevel("player", 1)
				local _, ilvl2 = GetItemQualityAndLevel("player", 2)
				local _, ilvl3 = GetItemQualityAndLevel("player", 3)
				local _, ilvl4 = GetItemQualityAndLevel("player", 4)
				local _, ilvl5 = GetItemQualityAndLevel("player", 5)
				local _, ilvl6 = GetItemQualityAndLevel("player", 6)
				local _, ilvl7 = GetItemQualityAndLevel("player", 7)
				local _, ilvl8 = GetItemQualityAndLevel("player", 8)
				local _, ilvl9 = GetItemQualityAndLevel("player", 9)
				local _, ilvl10 = GetItemQualityAndLevel("player", 10)
				local _, ilvl11 = GetItemQualityAndLevel("player", 11)
				local _, ilvl12 = GetItemQualityAndLevel("player", 12)
				local _, ilvl13 = GetItemQualityAndLevel("player", 13)
				local _, ilvl14 = GetItemQualityAndLevel("player", 14)
				local _, ilvl15 = GetItemQualityAndLevel("player", 15)
				local _, ilvl16 = GetItemQualityAndLevel("player", 16)
				local _, ilvl17 = GetItemQualityAndLevel("player", 17)
				local _, ilvl18 = GetItemQualityAndLevel("player", 18)
				local _, ilvl19 = GetItemQualityAndLevel("player", 19)
				local _, ilvl20 = GetItemQualityAndLevel("player", 20)

				table.insert(ilvltable, ilvl1)
				table.insert(ilvltable, ilvl2)
				table.insert(ilvltable, ilvl3)
				table.insert(ilvltable, ilvl4)
				table.insert(ilvltable, ilvl5)
				table.insert(ilvltable, ilvl6)
				table.insert(ilvltable, ilvl7)
				table.insert(ilvltable, ilvl8)
				table.insert(ilvltable, ilvl9)
				table.insert(ilvltable, ilvl10)
				table.insert(ilvltable, ilvl11)
				table.insert(ilvltable, ilvl12)
				table.insert(ilvltable, ilvl13)
				table.insert(ilvltable, ilvl14)
				table.insert(ilvltable, ilvl15)
				table.insert(ilvltable, ilvl16)
				table.insert(ilvltable, ilvl17)
				table.insert(ilvltable, ilvl18)
				table.insert(ilvltable, ilvl19)
				table.insert(ilvltable, ilvl20)
			]]--

			local totalilvl = 0
			local numslots = 0
			for index, data in pairs(ilvltable) do
				--print(index.." slot "..data.." ilvl")
				totalilvl = totalilvl + data
				numslots = index
			end

			if numslots <= 15 then
				numslots = 15
			elseif numslots >= 17 then
				numslots = 17
			end
			--print(totalilvl)
			CharacterFrame.Text2:SetText((math.floor((totalilvl/numslots)*100))/100)
			--local ilvltable ={}

			local function UpdateItemSlotButton(button, unit)
				if button.eltruismilvl then button.eltruismilvl:Hide() end
				local slotID = button:GetID()
				if (slotID >= INVSLOT_FIRST_EQUIPPED and slotID <= INVSLOT_LAST_EQUIPPED) then
					if unit == "player" then
						local item = Item:CreateFromEquipmentSlot(slotID)
						if item:IsItemEmpty() then
							return
						end
						return item:ContinueOnItemLoad(function()
							AddLevelToButton(button, item:GetCurrentItemLevel(), item:GetItemQuality())
						end)
					else
						local itemQuality, itemLevel = GetItemQualityAndLevel(unit, slotID)
						if itemLevel then
							return AddLevelToButton(button, itemLevel, itemQuality)
						end
					end
				end
				return button.eltruismilvl and button.eltruismilvl:Hide()
			end
			hooksecurefunc("PaperDollItemSlotButton_Update", function(button)
				UpdateItemSlotButton(button, "player")
			end)

			--main way of clearing memory
			hooksecurefunc("ToggleCharacter", function()
				ElvUI_EltreumUI:ClearMemory()
			end)

			if not IsAddOnLoaded("Blizzard_InspectUI") then
				LoadAddOn("Blizzard_InspectUI")
			end
			hooksecurefunc("InspectPaperDollItemSlotButton_Update", function(button)
				UpdateItemSlotButton(button, "target")
			end)
		end
	end
end
