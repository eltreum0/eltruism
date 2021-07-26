local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local GetCVarBool = GetCVarBool
local GetNumLootItems = GetNumLootItems
local IsModifiedClick = IsModifiedClick
local LootSlot = LootSlot

-- yet another fast loot thing
local EltruismInstantLoot = CreateFrame("Frame")
EltruismInstantLoot:RegisterEvent("LOOT_READY")
local function InstantLoot()
	if E.db.ElvUI_EltreumUI.otherstuff.fastloot then
		if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
			for i = GetNumLootItems(), 1, -1 do
				LootSlot(i)
			end
		end
	end
end
EltruismInstantLoot:SetScript("OnEvent", InstantLoot)

