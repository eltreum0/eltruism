local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local GetCVarBool = GetCVarBool
local GetNumLootItems = GetNumLootItems
local IsModifiedClick = IsModifiedClick
local LootSlot = LootSlot

-- yet another fast loot thing
local EltruismInstantLoot = CreateFrame("Frame", "EltruismInstantLoot")
--EltruismInstantLoot:Hide()
EltruismInstantLoot:RegisterEvent("LOOT_READY")
local function InstantLoot()
	if E.db.ElvUI_EltreumUI.otherstuff.fastloot then
		if _G["TSMDestroyBtn"] and _G["TSMDestroyBtn"]:IsShown() then
			return
		elseif GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
			for i = GetNumLootItems(), 1, -1 do
				LootSlot(i)
			end
		end
	end
end
EltruismInstantLoot:SetScript("OnEvent", InstantLoot)

--attempt at checking for stacks and not looting if not enough slots, but was slower
--[[local function InstantLoot()
	if E.db.ElvUI_EltreumUI.otherstuff.fastloot then
		local backpack = GetContainerNumFreeSlots(0)
		local bag1 = GetContainerNumFreeSlots(1)
		local bag2 = GetContainerNumFreeSlots(2)
		local bag3 = GetContainerNumFreeSlots(3)
		local bag4 = GetContainerNumFreeSlots(4)
		local openslots = backpack+bag1+bag2+bag3+bag4
		if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
			for i = GetNumLootItems(), 1, -1 do
				local itemLink = GetLootSlotLink(i)
				local _, _, _, _, _, _, _, itemStackCount = GetItemInfo(itemLink)
				local itemCount = GetItemCount(itemLink)
				print(itemStackCount,itemCount,openslots)
				if openslots > 0 then
					if itemCount > 0 then
						if itemStackCount > 0 then
							local openstackslots = itemStackCount - itemCount
							if openstackslots > 0 then
								LootSlot(i)
							end
						else
							LootSlot(i)
						end
					end
				end
			end
		end
	end
end]]
