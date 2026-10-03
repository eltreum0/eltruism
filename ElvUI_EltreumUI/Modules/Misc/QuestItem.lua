local E = unpack(ElvUI)
local AB = E:GetModule('ActionBars')
local _G = _G
local CreateFrame = _G.CreateFrame
local BackdropTemplateMixin = _G.BackdropTemplateMixin
local GetItemClassInfo = _G.C_Item and _G.C_Item.GetItemClassInfo or _G.GetItemClassInfo
local InCombatLockdown = _G.InCombatLockdown
local GetBindingKey = _G.GetBindingKey
local SetBindingClick = _G.SetBindingClick
local GameTooltip = _G.GameTooltip
local GetItemInfo = _G.C_Item and _G.C_Item.GetItemInfo or _G.GetItemInfo
local ipairs = _G.ipairs
local C_Container = _G.C_Container
local GetContainerNumSlots = C_Container.GetContainerNumSlots
local GetContainerItemLink = C_Container.GetContainerItemLink
local GetContainerItemInfo = C_Container.GetContainerItemInfo
local GetContainerItemCooldown = C_Container.GetContainerItemCooldown
local tonumber = _G.tonumber
--12.1.0 changes
local GetInventorySlotInfo = _G.C_PaperDollInfo and _G.C_PaperDollInfo.GetInventorySlotInfo or _G.GetInventorySlotInfo
local GetInventoryItemLink = _G.GetInventoryItemLink
local GetInventoryItemCooldown = _G.GetInventoryItemCooldown
local CooldownFrame_Set = _G.CooldownFrame_Set
local GetItemSpell = _G.C_Item and _G.C_Item.GetItemSpell or _G.GetItemSpell

--A merge of QBAr by Aezay with a few edits by Eltreum
--This module is GNU GPL v3
local EltruismQuestItemFrame = CreateFrame("Frame", "EltruismQuestItem", E.UIParent, BackdropTemplateMixin and "BackdropTemplate")	-- 9.0.1: Using BackdropTemplate
EltruismQuestItemFrame:SetPoint("BOTTOM", E.UIParent, "BOTTOM", 0, 34)
E:CreateMover(EltruismQuestItemFrame, "MoverEltruismQuestItem", "EltruismQuestItemBar", nil, nil, nil, "ALL,SOLO,ELTREUMUI", nil, 'ElvUI_EltreumUI,quests,item')
EltruismQuestItemFrame.tip = CreateFrame("GameTooltip","EltruismQuestItemTip",nil,"GameTooltipTemplate")
EltruismQuestItemFrame.tip:SetOwner(E.UIParent,"ANCHOR_NONE")
EltruismQuestItemFrame.items = {}
EltruismQuestItemFrame.debug = false

-- Constants
local ITEMID_PATTERN = "item:(%d+)"
local QUEST_TOKEN = (GetItemClassInfo and GetItemClassInfo(_G.LE_ITEM_CLASS_QUESTITEM or 12) or _G.LOOT_JOURNAL_LEGENDARIES_SOURCE_QUEST or "Quest") -- Obtain the localization of the "Quest" type for items -- [7.0.3/Legion] API Removed: GetAuctionItemClasses()

local slots = {
	"HeadSlot", "NeckSlot", "ShoulderSlot", "BackSlot", "ChestSlot", "ShirtSlot", "TabardSlot", "WristSlot",
	"HandsSlot", "WaistSlot", "LegsSlot", "FeetSlot", "Finger0Slot", "Finger1Slot", "Trinket0Slot", "Trinket1Slot",
	"MainHandSlot", "SecondaryHandSlot",
}

-- These items are not marked as being quest items, but we want to include them anyway
local qItems = {
	--[6948] = true, --hearthstone as a test item
	--[127770] = true, --another one as test
	[972] = true,
	[3985] = true,
	[4854] = true,
	[4945] = true,
	[5411] = true,
	[5456] = true,	-- Divining Scroll (item has no Use: text, even though you can use it)
	[5996] = true,
	[6372] = true,
	[6636] = true,
	[7843] = true,
	[8432] = true,
	[8474] = true,
	[8529] = true,
	[10569] = true,
	[10687] = true,
	[10688] = true,
	[10689] = true,
	[10690] = true,
	[10695] = true,
	[11116] = true,
	[11568] = true,
	[11582] = true,	-- Fel Salve
	[11914] = true, -- Cursed Ooze Jar
	[11948] = true,	-- Tainted Ooze Jar
	[11955] = true,
	[12565] = true,
	[12886] = true,
	[12922] = true,	-- Empty Canteen
	[16302] = true,
	[16321] = true,
	[16790] = true,
	[20483] = true,
	[21713] = true,	-- Elune's Candle (Lunar Festival)
	[23361] = true,	-- Cleansing Vial
	[23417] = true,
	[23645] = true,
	[23792] = true,	-- Tree Disguise Kit
	[23818] = true,	-- Stillpine Furbolg Language Primer
	[24084] = true,	-- Draenei Banner
	[24278] = true,	-- Flare Gun
	[24330] = true,
	[24335] = true,
	[24355] = true,	-- Ironvine Seeds
	[24421] = true,
	[24467] = true, -- living fire
	[24474] = true,
	[24501] = true,	-- Gordawg's Boulder
	[24504] = true,
	[24558] = true,
	[24559] = true,
	[25458] = true, -- mag'har battle standard
	[25465] = true,	-- Stormcrow Amulet
	[25539] = true,
	[25552] = true,	-- Warmaul Ogre Banner
	[25555] = true,	-- Kil'sorrow Banner
	[25658] = true,	-- Damp Woolen Blanket
	[25853] = true,	-- Pack of Incendiary Bombs (Old Hillsbrad)
	[28038] = true,	-- Seaforium PU-36 Explosive Nether Modulator
	[28132] = true,	-- Area 52 Special
	[28607] = true, -- Sunfury Disguise
	[29324] = true,
	[29443] = true,
	[29473] = true,
	[29588] = true,
	[29590] = true,
	[29778] = true,
	[30105] = true,
	[30540] = true,
	[30576] = true,
	[30712] = true,
	[30719] = true,
	[30811] = true,
	[31121] = true,
	[31122] = true,
	[31495] = true,
	[31518] = true,
	[31664] = true,
	[31702] = true,
	[31955] = true,
	[32385] = true,
	[32386] = true,
	[32405] = true,
	[32406] = true,
	[32726] = true,
	[32971] = true,	-- Water Bucket (Hallow's End)
	[33096] = true,	-- Complimentary Brewfest Sampler (Brew Fest)
	[33349] = true, --plague vials
	[33614] = true, --empty apothecary's flask
	[33615] = true, --flask of vrykul blood
	[33621] = true, --plague spray
	[33634] = true,	-- Orehammer's Precision Bombs, quest from Howling Fjord
	[34023] = true, --empty apothecary's flask
	[34024] = true, --flask of vrykul blood
	[34076] = true,
	[34475] = true, -- arcane charges
	[34483] = true, --orb of murloc control
	[34871] = true,
	[35233] = true, --multiphase spectographic goggles
	[35704] = true,
	[35792] = true,
	[36770] = true,
	[36771] = true,
	[37173] = true,
	[37265] = true,
	[37445] = true,
	[37661] = true, --gossamer potion
	[37708] = true,
	[37877] = true,
	[38351] = true,
	[38657] = true,
	[38659] = true,
	[38676] = true,
	[38684] = true,
	[38689] = true,
	[38697] = true,
	[38699] = true,
	[38701] = true,
	[38709] = true,
	[38731] = true,
	[39041] = true,
	[39154] = true,
	[39157] = true,
	[39158] = true,
	[39164] = true,
	[39165] = true,
	[39187] = true,
	[39206] = true,
	[39238] = true,
	[39253] = true,
	[39268] = true,
	[39566] = true,
	[39574] = true,
	[39576] = true,
	[39615] = true,
	[39645] = true,
	[39664] = true,
	[39700] = true,
	[39737] = true,
	[40390] = true,
	[40397] = true,
	[40551] = true,
	[40587] = true,
	[40676] = true,
	[40730] = true,
	[40731] = true,
	[40732] = true,
	[40946] = true,
	[41131] = true,
	[41179] = true,
	[41340] = true,
	[41366] = true,
	[41372] = true,
	[41390] = true,
	[41430] = true,
	[41431] = true,
	[41615] = true,
	[41776] = true,
	[41988] = true,
	[42164] = true,
	[42419] = true,
	[42424] = true,
	[42441] = true,
	[42442] = true,
	[42479] = true,
	[42480] = true,
	[42481] = true,
	[42499] = true,
	[42624] = true,
	[42679] = true,
	[42769] = true,
	[42774] = true,
	[42781] = true,
	[42797] = true,
	[42837] = true,
	[42840] = true,
	[42918] = true,
	[42928] = true,
	[43101] = true,
	[43139] = true,
	[43142] = true,
	[43147] = true,
	[43153] = true,
	[43166] = true,
	[43206] = true,
	[43243] = true,
	[43289] = true,
	[43315] = true,
	[43524] = true,
	[43564] = true,
	[43608] = true,
	[43968] = true,
	[44048] = true,
	[44064] = true,
	[44065] = true,
	[44127] = true,
	[44186] = true,
	[44212] = true,
	[44222] = true,
	[44251] = true,
	[44304] = true,
	[44307] = true,
	[44433] = true,
	[44450] = true,
	[44653] = true,
	[44704] = true,
	[44890] = true,
	[44950] = true,
	[45067] = true,	-- Egg Basket -- Az: offhand item, but I wanted it on my bar for a hotkey
	[46861] = true,	-- Bouquet of Orange Marigolds (Day of the Dead)
	[49132] = true, -- fireliminator x-21
	[49278] = true,	-- Goblin Rocket Pack (ICC - Lootship)
	[49368] = true, -- ambassador disquise
	[56909] = true,	-- Earthen Ring Unbinding Totem (Cata event)
	[60501] = true, 	-- Stormstone, Deepholm Quest
	[185956] = true,
	[180008] = true, --resonating anima core
	[45072] = true, --noblegarden egg that has to be opened
}

local blocklist = {
	[176809] = true, -- junk item that for some reason showed up
	[8529] = true, --noggenfogger
	[180536] = true, --broken kyrian flute, can't be used
	[180817] = true, -- cypher of relocation
	[45067] = true, --noblegarden dress transmog
	--[140212] = true, --test item

	--[24468] = true, --burstcap mushroom
	--[24449] = true, --fertile spores
	--[24291] = true, --bog lord tendril
	--[24497] = true, --feralfen protection totem
	--[25448] = true, --blacksting's stinger
	--[25491] = true, --salvaged spore sacs
	--[24238] = true, --mushroom sample
	--[24472] = true, --boss grog'ak's head
}

-- update mover position
function EltruismQuestItemFrame:FixPosition()
	if EltruismQuestItemFrame.debug then
		ElvUI_EltreumUI:Print("Firing FixPosition")
	end
	E:Delay(0, function()
		if not InCombatLockdown() and _G["EltruismQuestItem1"] then
			local point, relativeTo, relativePoint, xOfs, yOfs = EltruismQuestItemFrame:GetPoint()
			_G["EltruismQuestItem1"]:ClearAllPoints()
			if E.db.ElvUI_EltreumUI.quests.questorientation == "HORIZONTAL" then
				if EltruismQuestItemFrame.shownItems ~= 1 then
					if (EltruismQuestItemFrame.shownItems % 2) == 0 then
						if xOfs >= 0 then
							--_G["EltruismQuestItem1"]:SetPoint(point, relativeTo, relativePoint, xOfs-(((EltruismQuestItemFrame.shownItems-1)*E.db.ElvUI_EltreumUI.quests.questitemsize)/2), yOfs)
							_G["EltruismQuestItem1"]:SetPoint(point, relativeTo, relativePoint, xOfs-(((EltruismQuestItemFrame.shownItems-1)*E.db.ElvUI_EltreumUI.quests.questitemsize)/2)-(E.db.ElvUI_EltreumUI.quests.questitemspacing *(EltruismQuestItemFrame.shownItems-1)/2), yOfs)
						elseif xOfs < 0 then
							--_G["EltruismQuestItem1"]:SetPoint(point, relativeTo, relativePoint, xOfs+(((EltruismQuestItemFrame.shownItems-1)*E.db.ElvUI_EltreumUI.quests.questitemsize)/2), yOfs)
							_G["EltruismQuestItem1"]:SetPoint(point, relativeTo, relativePoint, xOfs-(((EltruismQuestItemFrame.shownItems-1)*E.db.ElvUI_EltreumUI.quests.questitemsize)/2)+(E.db.ElvUI_EltreumUI.quests.questitemspacing *(EltruismQuestItemFrame.shownItems-1)/2), yOfs)
						end
					else
						if xOfs >= 0 then
							--_G["EltruismQuestItem1"]:SetPoint(point, relativeTo, relativePoint, xOfs-(((EltruismQuestItemFrame.shownItems-(EltruismQuestItemFrame.shownItems % 2))*(E.db.ElvUI_EltreumUI.quests.questitemsize+1))/2), yOfs)
							_G["EltruismQuestItem1"]:SetPoint(point, relativeTo, relativePoint, xOfs-(E.db.ElvUI_EltreumUI.quests.questitemspacing *(EltruismQuestItemFrame.shownItems-1)/2)-(((EltruismQuestItemFrame.shownItems-(EltruismQuestItemFrame.shownItems % 2))*(E.db.ElvUI_EltreumUI.quests.questitemsize+1))/2), yOfs)
						elseif xOfs < 0 then
							--_G["EltruismQuestItem1"]:SetPoint(point, relativeTo, relativePoint, xOfs+(((EltruismQuestItemFrame.shownItems-(EltruismQuestItemFrame.shownItems % 2))*(E.db.ElvUI_EltreumUI.quests.questitemsize-1))/2), yOfs)
							_G["EltruismQuestItem1"]:SetPoint(point, relativeTo, relativePoint, xOfs+(E.db.ElvUI_EltreumUI.quests.questitemspacing *(EltruismQuestItemFrame.shownItems-1)/2)+(((EltruismQuestItemFrame.shownItems-(EltruismQuestItemFrame.shownItems % 2))*(E.db.ElvUI_EltreumUI.quests.questitemsize-1))/2), yOfs)
						end
					end
				else
					_G["EltruismQuestItem1"]:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs)
				end
			else
				_G["EltruismQuestItem1"]:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs)
			end
		end
	end)
end

-- Make Button
local function CreateItemButton()
	if EltruismQuestItemFrame.debug then
		ElvUI_EltreumUI:Print("Firing CreateItemButton")
	end
	local b = CreateFrame("Button","EltruismQuestItem"..(#EltruismQuestItemFrame.items + 1),EltruismQuestItemFrame,"ActionButtonTemplate, SecureActionButtonTemplate")
	b:CreateBackdrop('Transparent')
	b:SetSize(E.db.ElvUI_EltreumUI.quests.questitemsize,E.db.ElvUI_EltreumUI.quests.questitemsizey)
	if E.db.ElvUI_EltreumUI.skins.shadow.enable and not E.db.ElvUI_EltreumUI.borders.universalborders then
		if not b.shadow then
			b:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
			ElvUI_EltreumUI:ShadowColor(b.shadow)
		end
	end
	b:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
	ElvUI_EltreumUI:MacroClick(b)
	b:SetScript("OnEnter", function (button)
		GameTooltip:SetOwner(E.UIParent, "ANCHOR_CURSOR")
		local bag, slot = button:GetAttribute("bag"), button:GetAttribute("slot")
		if (bag) then
			GameTooltip:SetBagItem(bag,slot)
		else
			GameTooltip:SetInventoryItem("player",slot)
		end
		if E.db.ElvUI_EltreumUI.quests.questitemsfade then
			b:SetAlpha(1)
		end
	end)
	b:SetScript("OnLeave", function()
		if E.db.ElvUI_EltreumUI.quests.questitemsfade then
			b:SetAlpha(0)
		end
		GameTooltip:Hide()
	end)
	--b:HookScript("OnClick",Button_OnClick)

	b:HookScript("OnEnter", function()
		AB:BindUpdate(b)
		AB:FixKeybindText(b)
	end)

	b:SetAttribute("type*","item")

	b.icon = b:CreateTexture(nil,"ARTWORK")
	b.icon:SetAllPoints()

	b.name = "EltruismQuestItem"..(#EltruismQuestItemFrame.items + 1)

	b.count = b:CreateFontString(nil,"ARTWORK")
	b.count:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.actionbar.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
	b.count:SetTextColor(1,1,1)
	b.count:SetPoint("BOTTOMRIGHT",b.icon, 0, 0)

	b.cooldown = CreateFrame("Cooldown",nil,b,"CooldownFrameTemplate")
	b.cooldown:SetAllPoints()
	E:RegisterCooldown(b.cooldown)

	if E.db.ElvUI_EltreumUI.quests.showkeybind then
		b.HotKey = b:CreateFontString(nil,"ARTWORK","NumberFontNormalSmallGray")
		b.HotKey:SetPoint(E.db.actionbar.bar1.hotkeyTextPosition or "CENTER",b.icon,E.db.actionbar.bar1.hotkeyTextPosition or "CENTER",E.db.actionbar.bar1.hotkeyTextXOffset or 0,E.db.actionbar.bar1.hotkeyTextYOffset or 0)
		b.HotKey:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.actionbar.bar1.hotkeyFontSize, ElvUI_EltreumUI:FontFlag(E.db.actionbar.bar1.hotkeyFontOutline))
		--b.HotKey:SetPoint("TOPRIGHT",b.icon,0,0)
		--b.HotKey:SetJustifyH("LEFT")
	end

	b:Enable()
	b:Show()
	--if (#EltruismQuestItemFrame.items == 0) then
	if (EltruismQuestItemFrame.shownItems == 0) then
		if E.db.ElvUI_EltreumUI.quests.questorientation == "HORIZONTAL" then
			b:SetPoint("TOPLEFT",EltruismQuestItemFrame,0,0)
		else
			b:SetPoint("BOTTOM",EltruismQuestItemFrame,0,0)
		end
	end
	EltruismQuestItemFrame.items[#EltruismQuestItemFrame.items + 1] = b
	return b
end

-- Add Button
local function AddButton(index,bag,slot,link,itemID,count)
	if EltruismQuestItemFrame.debug then
		ElvUI_EltreumUI:Print("Firing AddButton")
	end
	local btn = EltruismQuestItemFrame.items[index] or CreateItemButton()
	local _, _, _, _, _, _, _, _, _, itemTexture, _, _ = GetItemInfo(link)
	btn.icon:SetTexture(itemTexture)
	--btn.icon:SetTexCoord(0.08,0.92,0.08,0.92)
	--btn.icon:SetTexCoord(unpack(E.TexCoords))

	--from elvui trim action bar button
	local left, right, top, bottom = 0.08,0.92,0.08,0.92
	local width, height = btn:GetSize()
	local ratio = width / height
	if ratio > 1 then
		local trimAmount = (1 - (1 / ratio)) * 0.5
		top = top + trimAmount
		bottom = bottom - trimAmount
	else
		local trimAmount = (1 - ratio) * 0.5
		left = left + trimAmount
		right = right - trimAmount
	end
	btn.icon:SetTexCoord(left, right, top, bottom)
	btn.count:SetText(count and count > 1 and count or "")

	btn.link = link
	btn.itemID = itemID

	btn:SetAttribute("type*","item")
	btn:SetAttribute("bag",bag)
	btn:SetAttribute("slot",slot)
	ElvUI_EltreumUI:MacroClick(btn)
	btn:Enable()

	if (index > 1) then
		btn:ClearAllPoints()
		if E.db.ElvUI_EltreumUI.quests.questorientation == "HORIZONTAL" then
			btn:SetPoint("LEFT", EltruismQuestItemFrame.items[index - 1], "RIGHT", E.db.ElvUI_EltreumUI.quests.questitemspacing, 0) --CONTROLS SPACING
		else
			btn:SetPoint("TOP", EltruismQuestItemFrame.items[index - 1], "BOTTOM", 0, -E.db.ElvUI_EltreumUI.quests.questitemspacing) --CONTROLS SPACING
		end
	end
	btn:Show()

	-- update mover position
	EltruismQuestItemFrame:FixPosition()
end

-- Check Item -- Az: Some items which starts a quest, are not marked as "Quest" in itemType or itemSubType. Ex: item:17008
local function CheckItemTooltip(link,itemID)
	if EltruismQuestItemFrame.debug then
		ElvUI_EltreumUI:Print("Firing CheckItemTooltip")
	end
	local _, _, _, _, _, itemType, itemSubType, _, itemEquipLoc, _, _, classID = GetItemInfo(link)

	-- Include predefinded items
	if qItems[itemID] and not blocklist[itemID] then
		return 1
	end

	--old, was causing issues
	-- Scan Tip -- Az: any reason we cant just check for more or equal to 4 lines, or would some quest items fail that check?
	--[[EltruismQuestItemFrame.tip:ClearLines()
	EltruismQuestItemFrame.tip:SetHyperlink(link)
	local numLines = EltruismQuestItemFrame.tip:NumLines()
	local line2 = (_G["EltruismQuestItemTipTextLeft2"]:GetText() or "")
	if (numLines >= 3) and (itemType == QUEST_TOKEN or itemSubType == QUEST_TOKEN or classID == 12 or line2 == ITEM_BIND_QUEST or line2 == GetZoneText()) and itemEquipLoc == "" then
		for i = 3, numLines do
			if _G["EltruismQuestItemTipTextLeft"..i] then
				local text = _G["EltruismQuestItemTipTextLeft"..i]:GetText() or ""
				if text and (text:find("^"..ITEM_SPELL_TRIGGER_ONUSE)) then
					return 1
				end
			end
		end
	end]]

	--new
	if (itemType == QUEST_TOKEN or itemSubType == QUEST_TOKEN or classID == 12) and itemEquipLoc == "" and GetItemSpell(itemID) ~= nil then
		if not blocklist[itemID] then
			return 1
		end
	end
end

-- Update Cooldowns
function EltruismQuestItemFrame:UpdateCooldowns()
	if EltruismQuestItemFrame.debug then
		ElvUI_EltreumUI:Print("Firing UpdateCooldowns")
	end
	for i = 1, EltruismQuestItemFrame.shownItems do
		local bag, slot = self.items[i]:GetAttribute("bag"), self.items[i]:GetAttribute("slot")
		if (bag) then
			CooldownFrame_Set(self.items[i].cooldown,GetContainerItemCooldown(bag,slot))
		else
			CooldownFrame_Set(self.items[i].cooldown,GetInventoryItemCooldown("player",slot))
		end
	end
end

--check for other buttons that are the same
local function CheckButtonExistence(itemID)
	for i = 1, #EltruismQuestItemFrame.items do
		if EltruismQuestItemFrame.items[i].itemID and EltruismQuestItemFrame.items[i].itemID == itemID then
			return false
		end
	end
	return true
end

-- Update Buttons
function EltruismQuestItemFrame:UpdateButtons()
	if EltruismQuestItemFrame.debug then
		ElvUI_EltreumUI:Print("Firing UpdateButtons")
	end

	--use dummy item id to avoid taint
	if #EltruismQuestItemFrame.items > 0 then
		for i = 1, #EltruismQuestItemFrame.items do
			EltruismQuestItemFrame.items[i].itemID = 6948
		end
	end

	-- Check if we are locked by combat
	if InCombatLockdown() then
		return
	end

	--reset ids
	if #EltruismQuestItemFrame.items > 0 then
		for i = 1, #EltruismQuestItemFrame.items do
			EltruismQuestItemFrame.items[i].itemID = 6948
			if not InCombatLockdown() then
				EltruismQuestItemFrame.items[i]:SetAttribute("disabled",nil)
				EltruismQuestItemFrame.items[i]:Disable()
			end
		end
	end

	-- locals
	local index = 1

	-- Inventory
	for bag = 0, _G.NUM_BAG_SLOTS do
		for slot = 1, GetContainerNumSlots(bag) do
			local link = GetContainerItemLink(bag,slot)
			local itemID = link and tonumber(link:match(ITEMID_PATTERN))
			if (link) and (itemID) then
				if not blocklist[itemID] then
					local _, _, _, _, _, itemType, itemSubType, _, _, _, _, classID = GetItemInfo(link)
					if CheckButtonExistence(itemID) then
						if E.Modern or E.Mists or E.TBC or E.Wrath then
							local questInfo = C_Container.GetContainerItemQuestInfo(bag,slot)
							if ((questInfo.isQuestItem or (itemType == QUEST_TOKEN or itemSubType == QUEST_TOKEN or classID == 12)) and GetItemSpell(itemID) ~= nil) or (CheckItemTooltip(link,itemID)) then
								local _, count = GetContainerItemInfo(bag,slot)
								AddButton(index,bag,slot,link,itemID,count)
								index = (index + 1)
							end
						elseif E.Classic then
							if ((itemType == QUEST_TOKEN or itemSubType == QUEST_TOKEN or classID == 12) and GetItemSpell(itemID) ~= nil) or (CheckItemTooltip(link,itemID)) then
								local _, count = GetContainerItemInfo(bag,slot)
								AddButton(index,bag,slot,link,itemID,count)
								index = (index + 1)
							end
						end
					end
				end
			end
		end
	end

	-- Equipped Items
	for _, slotName in ipairs(slots) do
		local slotId = GetInventorySlotInfo(slotName)
		local link = GetInventoryItemLink("player",slotId)
		local itemID = link and tonumber(link:match(ITEMID_PATTERN))
		if (link) and (itemID) and (CheckItemTooltip(link,itemID)) and GetItemSpell(itemID) ~= nil then
			if CheckButtonExistence(itemID) then
				if not blocklist[itemID] then
					AddButton(index,nil,slotId,link,itemID)
					index = (index + 1)
				end
			end
		end
	end

	-- Set Shown Items
	EltruismQuestItemFrame.shownItems = (index - 1)
	for i = index, #self.items do
		self.items[i]:Hide()
		self.items[i]:SetAttribute("disabled",nil)
		self.items[i]:Disable()
	end

	--update bind text
	if E.db.ElvUI_EltreumUI.quests.showkeybind and not InCombatLockdown() then
		for i = 1, EltruismQuestItemFrame.shownItems do
			self.items[i].HotKey:SetText(GetBindingKey("CLICK ".."EltruismQuestItem"..i..":LeftButton"))

			--register keybind
			self.items[i].bindstring = "CLICK ".."EltruismQuestItem"..i..":LeftButton"
			self.items[i].commandName = "CLICK ".."EltruismQuestItem"..i..":LeftButton"
			SetBindingClick(self.items[i].bindstring, "EltruismQuestItem1",self.items[i])

			--try to get elvui binding mode to work
			AB:StyleButton(self.items[i])
			AB:FixKeybindText(self.items[i])
		end
	end

	-- Update Misc
	EltruismQuestItemFrame:UpdateCooldowns()
end

-- Update Cooldowns
function EltruismQuestItemFrame:ACTIONBAR_UPDATE_COOLDOWN()
	if EltruismQuestItemFrame.debug then
		ElvUI_EltreumUI:Print("Firing ACTIONBAR_UPDATE_COOLDOWN")
	end
	if not EltruismQuestItemFrame.shownItems then --added this check
		EltruismQuestItemFrame.shownItems = 0
	end
	if (EltruismQuestItemFrame.shownItems > 0) then
		EltruismQuestItemFrame:UpdateCooldowns()
	end
end

-- Inventory Changed
function EltruismQuestItemFrame:UNIT_INVENTORY_CHANGED(_,unit)
	if EltruismQuestItemFrame.debug then
		ElvUI_EltreumUI:Print("Firing UNIT_INVENTORY_CHANGED")
	end
	if (unit == "player") then
		EltruismQuestItemFrame:UpdateButtons()
		-- update mover position
		EltruismQuestItemFrame:FixPosition()
	end
end

-- Inventory might've changed because of mail
function EltruismQuestItemFrame:MAIL_SUCCESS()
	if EltruismQuestItemFrame.debug then
		ElvUI_EltreumUI:Print("Firing MAIL_SUCCESS")
	end
	EltruismQuestItemFrame:UpdateButtons()
	-- update mover position
	EltruismQuestItemFrame:FixPosition()
end

--event things
EltruismQuestItemFrame:SetScript("OnEvent",function(frame,event,...)
	if EltruismQuestItemFrame.debug then
		ElvUI_EltreumUI:Print("Firing OnEvent")
	end
	if (frame[event]) then
		--print("registered",event)
		frame[event](frame,event,...)
	else
		--print("unregisteredevent",event)
		EltruismQuestItemFrame:UpdateButtons()
	end
end)

function ElvUI_EltreumUI:QuestItem()
	if E.db.ElvUI_EltreumUI.quests.questitems then
		local instanceType = ElvUI_EltreumUI:IsInInstance(nil,nil,nil,true)
		if instanceType ~= "none" then
			EltruismQuestItemFrame:Hide()
			EltruismQuestItemFrame:UnregisterAllEvents()
		else
			--Events
			--these events will fire correctly
			--ACTIONBAR_UPDATE_COOLDOWN,UNIT_INVENTORY_CHANGED,MAIL_SUCCESS
			EltruismQuestItemFrame:RegisterUnitEvent("UNIT_INVENTORY_CHANGED", "player")
			EltruismQuestItemFrame:RegisterEvent("MAIL_SUCCESS") -- when mailing quest items UNIT_INVENTORY_CHANGED does not fire

			--these events will simply request an update
			EltruismQuestItemFrame:RegisterEvent("BAG_UPDATE")
			EltruismQuestItemFrame:RegisterEvent("BAG_UPDATE_DELAYED")
			--EltruismQuestItemFrame:RegisterEvent("BAG_UPDATE_COOLDOWN")
			EltruismQuestItemFrame:RegisterEvent("QUEST_WATCH_UPDATE")
			EltruismQuestItemFrame:RegisterEvent("BAG_NEW_ITEMS_UPDATED")
			EltruismQuestItemFrame:RegisterEvent("QUEST_ACCEPTED") -- Needed for items that starts a quest, when we accept it, update to remove the icon
			--EltruismQuestItemFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
			EltruismQuestItemFrame:RegisterEvent("UPDATE_BINDINGS")
			EltruismQuestItemFrame:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
			--these were causing memory issues, exploding whenever a waypoint was set
			--EltruismQuestItemFrame:RegisterEvent("QUEST_LOG_UPDATE") -- For when items get added/removed during quest
			EltruismQuestItemFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")	-- Should work better than PLAYER_ENTERING_WORLD

			if not InCombatLockdown() then
				EltruismQuestItemFrame:Show()
			end

			if E.db.ElvUI_EltreumUI.quests.questitemsbar1 and E.private.actionbar.enable then
				if not InCombatLockdown() then
					EltruismQuestItemFrame:SetParent(_G["ElvUI_Bar1Button1"])
				end
			end
			if not InCombatLockdown() then
				EltruismQuestItemFrame:SetSize(E.db.ElvUI_EltreumUI.quests.questitemsize,E.db.ElvUI_EltreumUI.quests.questitemsize)
				EltruismQuestItemFrame:SetClampedToScreen(true)
				EltruismQuestItemFrame:SetFrameStrata("MEDIUM")
			end

			EltruismQuestItemFrame:UpdateButtons()
		end
	else
		EltruismQuestItemFrame:UnregisterAllEvents()
	end
end
