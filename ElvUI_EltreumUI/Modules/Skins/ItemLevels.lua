local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local CreateFrame = _G.CreateFrame
local overlayFrame
local _, hex
local itemLink
local quality
local levelGetDetailedItemLevelInfo
local slotID
local itemQuality, itemLevel
local math = _G.math
local GetItemQualityColor = _G.GetItemQualityColor
local GetInventoryItemLink = _G.GetInventoryItemLink
local GetInventoryItemQuality = _G.GetInventoryItemQuality
local GetDetailedItemLevelInfo = _G.GetDetailedItemLevelInfo
local level
local hooksecurefunc = _G.hooksecurefunc
local C_Timer = _G.C_Timer

--Calculate ilvl and average ilvl of player items/inspect unit
local EltruismInspectilvls = CreateFrame("Frame")
function ElvUI_EltreumUI:UpdateAvgIlvl()
	if E.db.ElvUI_EltreumUI.skins.ilvls then
		local leftside = {
			["CharacterHeadSlot"] = true,
			["CharacterNeckSlot"] = true,
			["CharacterShoulderSlot"] = true,
			["CharacterBackSlot"] = true,
			["CharacterChestSlot"] = true,
			["CharacterWristSlot"] = true,
			["CharacterRangedSlot"] = true,
			["InspectHeadSlot"] = true,
			["InspectNeckSlot"] = true,
			["InspectShoulderSlot"] = true,
			["InspectBackSlot"] = true,
			["InspectChestSlot"] = true,
			["InspectWristSlot"] = true,
			["InspectRangedSlot"] = true,
		}
		local rightside = {
			["CharacterHandsSlot"] = true,
			["CharacterWaistSlot"] = true,
			["CharacterLegsSlot"] = true,
			["CharacterFeetSlot"] = true,
			["CharacterFinger0Slot"] = true,
			["CharacterFinger1Slot"] = true,
			["CharacterTrinket0Slot"] = true,
			["CharacterTrinket1Slot"] = true,
			["CharacterMainHandSlot"] = true,
			["InspectHandsSlot"] = true,
			["InspectWaistSlot"] = true,
			["InspectLegsSlot"] = true,
			["InspectFeetSlot"] = true,
			["InspectFinger0Slot"] = true,
			["InspectFinger1Slot"] = true,
			["InspectTrinket0Slot"] = true,
			["InspectTrinket1Slot"] = true,
			["InspectMainHandSlot"] = true,
		}
		local centereditem = {
			["CharacterSecondaryHandSlot"] = true,
			["InspectSecondaryHandSlot"] = true,
		}

		--from Simple Item Levels by Kemayo (BSD License) with some edits by Eltreum
		local function PrepareItemButton(button)
			if button.eltruismilvl then
				return
			end
			overlayFrame = CreateFrame("FRAME", nil, button)
			--overlayFrame:SetFrameLevel(9999) -- this was bugging out inspect
			overlayFrame:SetAllPoints()
			button.eltruismilvl = overlayFrame:CreateFontString('$parentItemLevel', 'OVERLAY')
			local buttonname = button:GetName()
			if leftside[buttonname] then
				button.eltruismilvl:SetPoint(E.db.ElvUI_EltreumUI.skins.ilvlanchor, -E.db.ElvUI_EltreumUI.skins.ilvlanchorx, E.db.ElvUI_EltreumUI.skins.ilvlanchory)
			elseif rightside[buttonname] then
				button.eltruismilvl:SetPoint(E.db.ElvUI_EltreumUI.skins.ilvlanchor, E.db.ElvUI_EltreumUI.skins.ilvlanchorx, E.db.ElvUI_EltreumUI.skins.ilvlanchory)
			elseif centereditem[buttonname] then
				button.eltruismilvl:SetPoint(E.db.ElvUI_EltreumUI.skins.ilvlanchor, 0, 0) --E.db.ElvUI_EltreumUI.skins.ilvlanchory * 2.3)  --ends up overlapping with sockets/enchants
			end
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
			_, _, _, hex = GetItemQualityColor(itemQuality)
			--if hex == "ffffffff" then
				--return
			--end
			button.eltruismilvl:SetFormattedText('|c%s%s|r', hex, itemLevel or '?')
			button.eltruismilvl:Show()
		end

		local function GetItemQualityAndLevel(unit, slotID)
			-- link is more reliably fetched than ID, for whatever reason
			--local itemLink = GetInventoryItemLink(unit, slotID)
			itemLink = GetInventoryItemLink(unit, slotID)
			--local itemLink = LibItemInfo:GetUnitItemIndexLink(unit, slotID)
			if itemLink ~= nil then
				quality = GetInventoryItemQuality(unit, slotID)
				level = GetDetailedItemLevelInfo(itemLink)
				---local level LibItemInfo:GetItemLevel(itemLink)
				--print(level) --level is the item level of each item
				return quality, level
			end
		end

		local function UpdateItemSlotButton(button, unit)
			if button.eltruismilvl then button.eltruismilvl:Hide() end
			slotID = button:GetID()
			if (slotID >= _G.INVSLOT_FIRST_EQUIPPED and slotID <= _G.INVSLOT_LAST_EQUIPPED) then
				itemQuality, itemLevel = GetItemQualityAndLevel(unit, slotID)
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
						if _G.InspectFrame and _G.InspectFrame.unit then
							UpdateItemSlotButton(button, _G.InspectFrame.unit)
						else
							UpdateItemSlotButton(button, "target")
						end
					end
				end)
			end
			if event == "INSPECT_READY" then
				C_Timer.After(0.1, function()
					if _G.InspectFrame and _G.InspectFrame:IsVisible() then
						_G.InspectPaperDollFrame_UpdateButtons()
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
		_G.CharacterFrame.Text2:SetText((math.floor(ElvUI_EltreumUI:GetUnitItemLevel("player")*100))/100)
	end
end
