local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local CreateFrame = _G.CreateFrame
local unpack = _G.unpack
local LibItemInfo
if ElvUI_EltreumUI. TBC or ElvUI_EltreumUI.Classic then
	LibItemInfo = LibStub:GetLibrary("LibItemInfo.1000")
end

--Calculate ilvl and average ilvl of player items/inspect unit
function ElvUI_EltreumUI:UpdateAvgIlvl()
	--print("ilvl spam")
	if ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
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
				--button.eltruismilvl:SetPoint('CENTER', 0, 0)
				button.eltruismilvl:SetPoint(E.db.ElvUI_EltreumUI.skins.ilvlanchor, 0, 0)
				--button.eltruismilvl:SetFont(E.LSM:Fetch("font", E.db.general.font), 16, "THICKOUTLINE")
				button.eltruismilvl:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.skins.ilvlfontsize, E.db.ElvUI_EltreumUI.skins.ilvlfontweight)
				button.eltruismilvl:SetJustifyH('LEFT')
				button.eltruismilvl:Hide()
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
				--local itemLink = GetInventoryItemLink(unit, slotID)
				local itemLink = LibItemInfo:GetUnitItemIndexLink(unit, slotID)
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

			local ilevel, _, _ = LibItemInfo:GetUnitItemLevel("player")
			--main way of clearing memory
			hooksecurefunc("ToggleCharacter", function()
				ElvUI_EltreumUI:ClearMemory()
				_G.CharacterFrame.Text2:SetText((math.floor(ilevel*100))/100)
			end)

			if not IsAddOnLoaded("Blizzard_InspectUI") then
				LoadAddOn("Blizzard_InspectUI")
			end
			hooksecurefunc("InspectPaperDollItemSlotButton_Update", function(button)
				UpdateItemSlotButton(button, "target")
			end)


			--this loop might come in handy in the future
			--[[local ilvltable ={}
			for i=1, 20 do
				local _, i = GetItemQualityAndLevel("player", i)
				table.insert(ilvltable, i)
			end]]


			local ilevel, _, _ = LibItemInfo:GetUnitItemLevel("player")
			_G.CharacterFrame.Text2:SetText((math.floor(ilevel*100))/100)

			--local ilevel, a, maxLevel = LibItemInfo:GetUnitItemLevel("player")
			--local link = LibItemInfo:GetUnitItemIndexLink("player", 1)
			--print(ilevel.."      "..link.."     "..maxLevel)

		end
	end
end
