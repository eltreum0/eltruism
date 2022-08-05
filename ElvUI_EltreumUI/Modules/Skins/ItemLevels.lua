local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local CreateFrame = _G.CreateFrame

--Calculate ilvl and average ilvl of player items/inspect unit
local EltruismInspectilvls = CreateFrame("Frame")
function ElvUI_EltreumUI:UpdateAvgIlvl()
	if E.db.ElvUI_EltreumUI.skins.ilvls then

		--from Simple Item Levels by Kemayo (BSD License) with some edits by Eltreum
		local function PrepareItemButton(button)
			if button.eltruismilvl then
				return
			end
			local overlayFrame = CreateFrame("FRAME", nil, button)
			--overlayFrame:SetFrameLevel(9999) -- this was bugging out inspect
			overlayFrame:SetAllPoints()
			button.eltruismilvl = overlayFrame:CreateFontString('$parentItemLevel', 'OVERLAY')
			button.eltruismilvl:SetPoint(E.db.ElvUI_EltreumUI.skins.ilvlanchor, 0, 0)
			button.eltruismilvl:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.skins.ilvlfontsize, E.db.ElvUI_EltreumUI.skins.ilvlfontweight)
			button.eltruismilvl:SetJustifyH('LEFT')
			button.eltruismilvl:Hide()
		end

		local function AddLevelToButton(button, itemLevel, itemQuality)
			if not itemLevel then
				return button.eltruismilvl and button.eltruismilvl:Hide()
			elseif itemLevel == 1 then
				return button.eltruismilvl and button.eltruismilvl:Hide()
			end
			PrepareItemButton(button)
			local _, _, _, hex = GetItemQualityColor(itemQuality)
			--if hex == "ffffffff" then
				--return
			--end
			button.eltruismilvl:SetFormattedText('|c%s%s|r', hex, itemLevel or '?')
			button.eltruismilvl:Show()
		end

		local function GetItemQualityAndLevel(unit, slotID)
			-- link is more reliably fetched than ID, for whatever reason
			--local itemLink = GetInventoryItemLink(unit, slotID)
			local itemLink = GetInventoryItemLink(unit, slotID)
			--local itemLink = LibItemInfo:GetUnitItemIndexLink(unit, slotID)
			if itemLink ~= nil then
				local quality = GetInventoryItemQuality(unit, slotID)
				local level = GetDetailedItemLevelInfo(itemLink)
				---local level LibItemInfo:GetItemLevel(itemLink)
				--print(level) --level is the item level of each item
				return quality, level
			end
		end

		local function UpdateItemSlotButton(button, unit)
			if button.eltruismilvl then button.eltruismilvl:Hide() end
			local slotID = button:GetID()
			if (slotID >= _G.INVSLOT_FIRST_EQUIPPED and slotID <= _G.INVSLOT_LAST_EQUIPPED) then
				local itemQuality, itemLevel = GetItemQualityAndLevel(unit, slotID)
				if itemLevel then
					return AddLevelToButton(button, itemLevel, itemQuality)
				end

				--[[if unit == "player" then
					local item = Item:CreateFromEquipmentSlot(slotID)
					if item:IsItemEmpty() == true then
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
				end]]
			end
			return button.eltruismilvl and button.eltruismilvl:Hide()
		end

		hooksecurefunc("PaperDollItemSlotButton_Update", function(button)
			if E.db.ElvUI_EltreumUI.skins.ilvls then
				UpdateItemSlotButton(button, "player")
			end
		end)

		EltruismInspectilvls:RegisterEvent("ADDON_LOADED")
		EltruismInspectilvls:RegisterEvent("INSPECT_READY")
		EltruismInspectilvls:SetScript("OnEvent", function(_,event,arg)
			if arg == "Blizzard_InspectUI" then
				--EltruismInspectilvls:UnregisterAllEvents()
				EltruismInspectilvls:UnregisterEvent("ADDON_LOADED")
				hooksecurefunc("InspectPaperDollItemSlotButton_Update", function(button)
					if E.db.ElvUI_EltreumUI.skins.ilvlsinspect then
						UpdateItemSlotButton(button, "target")
					end
				end)
			end
			if event == "INSPECT_READY" then
				C_Timer.After(1, function()
					if _G.InspectFrame and _G.InspectFrame:IsVisible() then
						InspectPaperDollFrame_UpdateButtons()
					end
				end)
			end
		end)

		--this loop might come in handy in the future
		--[[local ilvltable ={}
		for i=1, 20 do
			local _, i = GetItemQualityAndLevel("player", i)
			table.insert(ilvltable, i)
		end]]
		--local ilevel = E:GetUnitItemLevel() --GetAverageItemLevel() doesnt exist in tbc/classic
		local ilevel = ElvUI_EltreumUI:GetUnitItemLevel("player")
		_G.CharacterFrame.Text2:SetText((math.floor(ilevel*100))/100)
	end
end
