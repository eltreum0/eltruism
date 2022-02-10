local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

-- yet another fast loot thing
local EltruismInstantLoot = CreateFrame("Frame", "EltruismInstantLoot")
EltruismInstantLoot:RegisterEvent("LOOT_READY")
local function InstantLoot()
	if _G["TSMDestroyBtn"] and _G["TSMDestroyBtn"]:IsShown() then
		return
	elseif E.db.ElvUI_EltreumUI.otherstuff.fastloot then
		if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
			for i = GetNumLootItems(), 1, -1 do
				LootSlot(i)
			end
		end
	elseif E.db.ElvUI_EltreumUI.otherstuff.fastlootfilter then
		if C_CVar.GetCVar('autoLootDefault') == 1 then
			ElvUI_EltreumUI:Print("Autoloot is enabled, please disable it to use Loot Filtering")
		end
		for i = GetNumLootItems(), 1, -1 do
			local _, _, _, _, lootQuality, _, isQuestItem = GetLootSlotInfo(i)
			--lootIcon, lootName, lootQuantity, currencyID, lootQuality, locked, isQuestItem, questID, isActive = GetLootSlotInfo(slot)
			if isQuestItem == true then
				LootSlot(i)
			elseif lootQuality >= tonumber(E.db.ElvUI_EltreumUI.otherstuff.fastlootquality) then
				LootSlot(i)
			elseif GetLootSlotType(i) == 2 then
				LootSlot(i)
			else
				CloseLoot()
			end
		end
	end
end
EltruismInstantLoot:SetScript("OnEvent", InstantLoot)

--attempt at checking for stacks and not looting if not enough slots, but was slower
--[[
	local function InstantLoot()
		if E.db.ElvUI_EltreumUI.otherstuff.fastloot then
			local openslots = 0
			for i=0, 4 do
				openslots = openslots + GetContainerNumFreeSlots(i)
			end
			if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
				for i = GetNumLootItems(), 1, -1 do
					local itemLink = GetLootSlotLink(i)
					local _, _, _, _, _, _, _, itemStackCount = GetItemInfo(itemLink)
					local itemCount = GetItemCount(itemLink)
					print(itemStackCount,itemCount,openslots)
					if openslots > 0 and itemCount > 0 and itemStackCount > 0 then
						if (itemStackCount - itemCount) > 0 then
							LootSlot(i)
						end
					else
						LootSlot(i)
					end
				end
			end
		end
	end
]]
