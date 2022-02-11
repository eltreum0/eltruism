local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local classcolor = E:ClassColor(E.myclass, true)

--wishlist popup
local WishlistItemFrame = CreateFrame("Frame", "EltruismWishlistItem", UIParent)
WishlistItemFrame:SetPoint("TOP", UIParent, 0, -100)
WishlistItemFrame:SetSize(418, 72)

WishlistItemFrame.Text = WishlistItemFrame:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
WishlistItemFrame.Text:SetSize(800, 72)
WishlistItemFrame.Text:SetPoint("CENTER", "EltruismWishlistItem", "CENTER", 0, 16)
WishlistItemFrame.Text:SetTextColor(1, 1, 1)
WishlistItemFrame.Text:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, "OUTLINE")
WishlistItemFrame.Text:SetText("You have looted")

WishlistItemFrame.Text2 = WishlistItemFrame:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
WishlistItemFrame.Text2:SetSize(418, 72)
WishlistItemFrame.Text2:SetPoint("CENTER", "EltruismWishlistItem", "CENTER", 0, -14)
WishlistItemFrame.Text2:SetFont(E.LSM:Fetch("font", E.db.general.font), 24, "OUTLINE")

WishlistItemFrame.StatusLine = CreateFrame("StatusBar", "EltruismWishlistItem", WishlistItemFrame)
WishlistItemFrame.StatusLine:SetSize(418, 3)
WishlistItemFrame.StatusLine:SetPoint("TOP", WishlistItemFrame, 0, -5)
WishlistItemFrame.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
WishlistItemFrame.StatusLine:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)
WishlistItemFrame.StatusLine2 = CreateFrame("StatusBar", "EltruismWishlistItem", WishlistItemFrame)
WishlistItemFrame.StatusLine2:SetSize(418, 3)
WishlistItemFrame.StatusLine2:SetPoint("BOTTOM", WishlistItemFrame, 0, 0)
WishlistItemFrame.StatusLine2:SetStatusBarTexture(E.Media.Textures.Highlight)
WishlistItemFrame.StatusLine2:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)

WishlistItemFrame:Hide()

-- yet another fast loot thing
local EltruismInstantLoot = CreateFrame("Frame", "EltruismInstantLoot")
EltruismInstantLoot:RegisterEvent("LOOT_READY")
EltruismInstantLoot:RegisterEvent("LOOT_OPENED")
EltruismInstantLoot:RegisterEvent("LOOT_BIND_CONFIRM")
local function InstantLoot(_, event)
	--ElvUI_EltreumUI:Print("Event: "..event)
	if E.db.ElvUI_EltreumUI.otherstuff.lootwishlistwarning then
		for i = GetNumLootItems(), 1, -1 do
			local itemLink = GetLootSlotLink(i)
			if itemLink == nil then
				itemLink = "|cffe6cc80|Hitem:158075::::::::53:257::11:4:4932:4933:6316:1554::::::|h[Heart of Azeroth]|h|r"
			end
			local itemName, _, quality = GetItemInfo(itemLink)
			local r,g,b
			if quality then
				r,g,b = GetItemQualityColor(quality)
			end
			local id = itemLink:match("item:(%d+)")
			local itemID = tonumber(id)
			for k=1, #E.private.ElvUI_EltreumUI.wishlistID do
				if itemID == tonumber(E.private.ElvUI_EltreumUI.wishlistID[k]) then
					WishlistItemFrame.Text2:SetText("")
					if quality then
						WishlistItemFrame.Text2:SetTextColor(r, g, b)
					else
						WishlistItemFrame.Text2:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
					end
					WishlistItemFrame.Text2:SetText(itemName.."!")
					UIFrameFadeIn(WishlistItemFrame, 1, 0, 1)
					if E.db.ElvUI_EltreumUI.otherstuff.lootwishlistscreenshot then
						C_Timer.After(1, function() Screenshot() end)
					end
					C_Timer.After(5, function() UIFrameFadeOut(WishlistItemFrame, 1, 1, 0) end)
				end
			end
		end
	end
	if _G["TSMDestroyBtn"] and _G["TSMDestroyBtn"]:IsShown() then
		return
	elseif E.db.ElvUI_EltreumUI.otherstuff.fastloot then
		if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
			for i = GetNumLootItems(), 1, -1 do
				LootSlot(i)
			end
		end
	elseif E.db.ElvUI_EltreumUI.otherstuff.fastlootfilter then
		if event == 'LOOT_BIND_CONFIRM' then
			return
		else
			--print("fastlootfilter")
			if C_CVar.GetCVar('autoLootDefault') == 1 then
				ElvUI_EltreumUI:Print("Autoloot is enabled, please disable it to use Loot Filtering")
			end
			for i = GetNumLootItems(), 1, -1 do
				local _, _, _, _, lootQuality, _, isQuestItem = GetLootSlotInfo(i)
				if isQuestItem == true then
					LootSlot(i)
				elseif lootQuality >= tonumber(E.db.ElvUI_EltreumUI.otherstuff.fastlootquality) then
					LootSlot(i)
				elseif GetLootSlotType(i) == 2 then
					LootSlot(i)
				else
					if E.db.ElvUI_EltreumUI.otherstuff.lootautoclose then
						CloseLoot()
					end
				end
			end
		end
	elseif E.db.ElvUI_EltreumUI.otherstuff.lootwishlistfilter then
		if C_CVar.GetCVar('autoLootDefault') == 1 then
			ElvUI_EltreumUI:Print("Autoloot is enabled, please disable it to use Wishlist Loot Filtering")
		end
		if event == 'LOOT_BIND_CONFIRM' then
			return
		else
			for i = GetNumLootItems(), 1, -1 do
				local itemLink = GetLootSlotLink(i)
				if itemLink == nil then
					itemLink = "|cffe6cc80|Hitem:158075::::::::53:257::11:4:4932:4933:6316:1554::::::|h[Heart of Azeroth]|h|r"
				end
				local id = itemLink:match("item:(%d+)")
				local itemID = tonumber(id)
				if GetLootSlotType(i) == 2 then
					LootSlot(i)
				end
				--print(id, itemID, E.private.ElvUI_EltreumUI.wishlistID[i])
				for k=1, #E.private.ElvUI_EltreumUI.wishlistID do
					if itemID == tonumber(E.private.ElvUI_EltreumUI.wishlistID[k]) then
						LootSlot(i)
					else
						if E.db.ElvUI_EltreumUI.otherstuff.lootautoclose then
							CloseLoot()
						end
					end
				end
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
