local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local classcolor = E:ClassColor(E.myclass, true)
local CreateFrame = _G.CreateFrame
local UIParent = _G.UIParent
local ERR_INV_FULL = _G.ERR_INV_FULL
local GetNumLootItems = _G.GetNumLootItems
local GetLootSlotLink = _G.GetLootSlotLink
local GetItemInfo = _G.GetItemInfo
local GetItemIcon = _G.GetItemIcon
local GetItemQualityColor = _G.GetItemQualityColor
local tonumber = _G.tonumber
local UIFrameFadeIn = _G.UIFrameFadeIn
local C_Timer = _G.C_Timer
local GetCVarBool = _G.GetCVarBool
local IsModifiedClick = _G.IsModifiedClick
local LootSlot = _G.LootSlot
local C_CVar = _G.C_CVar
local GetLootSlotInfo = _G.GetLootSlotInfo
local GetLootSlotType = _G.GetLootSlotType
local CloseLoot = _G.CloseLoot
local Screenshot = _G.Screenshot
local UIFrameFadeOut = _G.UIFrameFadeOut
local itemLink
local itemName, _, quality
local itemtexture
local r,g,b
local id
local itemID
local lootQuality, isQuestItem
local lootsoundthrottle = 0

--wishlist popup
local WishlistItemFrame = CreateFrame("Frame", "EltruismWishlistItem", UIParent)
WishlistItemFrame:SetPoint("TOP", UIParent, 0, -100)
WishlistItemFrame:SetSize(418, 72)
E:CreateMover(WishlistItemFrame, "MoverEltruismWishlist", "EltruismWishlist", nil, nil, nil, "ALL,SOLO,ELTREUMUI", nil, 'ElvUI_EltreumUI,loottext')

WishlistItemFrame.Text = WishlistItemFrame:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
WishlistItemFrame.Text:SetSize(800, 72)
WishlistItemFrame.Text:SetPoint("CENTER", "EltruismWishlistItem", "CENTER", 0, 16)
WishlistItemFrame.Text:SetTextColor(1, 1, 1)
WishlistItemFrame.Text:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, E.db.general.fontStyle)
WishlistItemFrame.Text:SetText("You have looted")

WishlistItemFrame.Text2 = WishlistItemFrame:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
WishlistItemFrame.Text2:SetSize(418, 72)
WishlistItemFrame.Text2:SetPoint("CENTER", "EltruismWishlistItem", "CENTER", 0, -14)
WishlistItemFrame.Text2:SetFont(E.LSM:Fetch("font", E.db.general.font), 24, E.db.general.fontStyle)

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
EltruismInstantLoot:RegisterEvent("UI_ERROR_MESSAGE")

local function InstantLoot(_, event,_, arg2)
	if event == "LOOT_BIND_CONFIRM" and (E.Wrath or E.TBC or E.Classic) then
		if E.db.ElvUI_EltreumUI.loot.confirmbop then
			for i = GetNumLootItems(), 1, -1 do
				ConfirmLootSlot(i)
			end
		else
			return
		end
	elseif event == "UI_ERROR_MESSAGE" and arg2 == ERR_INV_FULL then
		return
	elseif event == "LOOT_READY" or event == "LOOT_OPENED" then
		--ElvUI_EltreumUI:Print("Event: "..event)
		if E.db.ElvUI_EltreumUI.loot.lootwishlistwarning then
			for i = GetNumLootItems(), 1, -1 do
				itemLink = GetLootSlotLink(i)
				if itemLink == nil then
					itemLink = "|cffe6cc80|Hitem:158075::::::::53:257::11:4:4932:4933:6316:1554::::::|h[Heart of Azeroth]|h|r"
				end
				itemName, _, quality = GetItemInfo(itemLink)
				itemtexture = GetItemIcon(itemLink)
				if quality then
					r,g,b = GetItemQualityColor(quality)
				end
				id = itemLink:match("item:(%d+)")
				itemID = tonumber(id)
				for k=1, #E.private.ElvUI_EltreumUI.wishlistID do
					if itemID == tonumber(E.private.ElvUI_EltreumUI.wishlistID[k]) then
						WishlistItemFrame.Text2:SetText("")
						if quality then
							WishlistItemFrame.Text2:SetTextColor(r, g, b)
						else
							WishlistItemFrame.Text2:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
						end
						--WishlistItemFrame.Text2:SetText("|T"..itemtexture..":".. 12 .."|t"..itemName.."!")
						WishlistItemFrame.Text2:SetText("|T"..itemtexture..":12:12:0:0:64:64:5:59:5:59|t "..itemName.."!")
						UIFrameFadeIn(WishlistItemFrame, 1, 0, 1)
						if E.db.ElvUI_EltreumUI.loot.lootwishlistscreenshot then
							C_Timer.After(1, function() Screenshot() end)
						end
						if E.db.ElvUI_EltreumUI.loot.lootwishlistsoundenable and lootsoundthrottle == 0 then
							PlaySoundFile(E.LSM:Fetch("sound", E.db.ElvUI_EltreumUI.loot.lootwishlistsound) , "Master")
							lootsoundthrottle = 1
							C_Timer.After(0.5, function()
								lootsoundthrottle = 0
							end)

						end
						C_Timer.After(5, function() UIFrameFadeOut(WishlistItemFrame, 1, 1, 0) end)
					end
				end
			end
		end
		if _G["TSMDestroyBtn"] and _G["TSMDestroyBtn"]:IsShown() then
			return
		end
		if E.db.ElvUI_EltreumUI.loot.fastloot then
			if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
				for i = GetNumLootItems(), 1, -1 do
					LootSlot(i)
				end
			end
		end
		if E.db.ElvUI_EltreumUI.loot.fastlootfilter then
			if event == 'LOOT_BIND_CONFIRM' then
				return
			else
				--print("fastlootfilter")
				if C_CVar.GetCVar('autoLootDefault') == 1 then
					ElvUI_EltreumUI:Print("Autoloot is enabled, please disable it to use Loot Filtering")
				end
				for i = GetNumLootItems(), 1, -1 do
					_, _, _, _, lootQuality, _, isQuestItem = GetLootSlotInfo(i)
					if isQuestItem == true then
						LootSlot(i)
					elseif lootQuality >= tonumber(E.db.ElvUI_EltreumUI.loot.fastlootquality) then
						LootSlot(i)
					elseif GetLootSlotType(i) == 2 then
						LootSlot(i)
					else
						if E.db.ElvUI_EltreumUI.loot.lootautoclose then
							CloseLoot()
						end
					end
				end
			end
		end
		if E.db.ElvUI_EltreumUI.loot.lootwishlistfilter then
			if C_CVar.GetCVar('autoLootDefault') == 1 then
				ElvUI_EltreumUI:Print("Autoloot is enabled, please disable it to use Wishlist Loot Filtering")
			end
			if event == 'LOOT_BIND_CONFIRM' then
				return
			else
				for i = GetNumLootItems(), 1, -1 do
					itemLink = GetLootSlotLink(i)
					if itemLink == nil then
						itemLink = "|cffe6cc80|Hitem:158075::::::::53:257::11:4:4932:4933:6316:1554::::::|h[Heart of Azeroth]|h|r"
					end
					id = itemLink:match("item:(%d+)")
					itemID = tonumber(id)
					if GetLootSlotType(i) == 2 then
						LootSlot(i)
					end
					--print(id, itemID, E.private.ElvUI_EltreumUI.wishlistID[i])
					for k=1, #E.private.ElvUI_EltreumUI.wishlistID do
						if itemID == tonumber(E.private.ElvUI_EltreumUI.wishlistID[k]) then
							LootSlot(i)
						else
							if E.db.ElvUI_EltreumUI.loot.lootautoclose then
								CloseLoot()
							end
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
		if E.db.ElvUI_EltreumUI.loot.fastloot then
			local openslots = 0
			for i=0, 4 do
				openslots = openslots + GetContainerNumFreeSlots(i)
			end
			if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
				for i = GetNumLootItems(), 1, -1 do
					local itemLink = GetLootSlotLink(i)
					local _, _, _, _, _, _, _, itemStackCount = GetItemInfo(itemLink)
					local itemCount = GetItemCount(itemLink)
					--print(itemStackCount,itemCount,openslots)
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
