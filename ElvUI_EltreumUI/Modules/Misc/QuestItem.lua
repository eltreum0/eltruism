-- Eltruism Quest Item Bar (originally inspired by QBar by Aezay)
local E = unpack(ElvUI)
local AB = E:GetModule('ActionBars', true)
local _G = _G

local tonumber = _G.tonumber
local tostring = _G.tostring
local select = _G.select
local wipe = _G.wipe
local CreateFrame = _G.CreateFrame
local InCombatLockdown = _G.InCombatLockdown
local GetBindingKey = _G.GetBindingKey
local GameTooltip = _G.GameTooltip
local CooldownFrame_Set = _G.CooldownFrame_Set
local C_Container = _G.C_Container
local GetContainerNumSlots = C_Container.GetContainerNumSlots
local GetContainerItemInfo = C_Container.GetContainerItemInfo
local GetContainerItemLink = C_Container.GetContainerItemLink
local GetContainerItemQuestInfo = C_Container.GetContainerItemQuestInfo
local GetContainerItemCooldown = C_Container.GetContainerItemCooldown
local C_Item = _G.C_Item
local GetItemInfoInstant = C_Item.GetItemInfoInstant
local GetItemSpell = C_Item.GetItemSpell
local GetInventoryItemID = _G.GetInventoryItemID
local GetInventoryItemTexture = _G.GetInventoryItemTexture
local GetInventoryItemCooldown = _G.GetInventoryItemCooldown
local C_Timer = _G.C_Timer

local QUEST_ITEM_CLASS_ID = _G.Enum.ItemClass.Questitem
local FIRST_EQUIP_SLOT = _G.INVSLOT_FIRST_EQUIPPED
local LAST_EQUIP_SLOT = _G.INVSLOT_LAST_EQUIPPED
local NUM_BAG_SLOTS = _G.NUM_BAG_SLOTS

local IGNORED_ITEMS = {
	[8529] = true,
	[45067] = true,
	[176809] = true,
	[180536] = true,
	[180817] = true,
}

local EXTRA_QUEST_ITEMS = {
	[972] = true, [3985] = true, [4854] = true, [4945] = true, [5411] = true, [5456] = true,
	[5996] = true, [6372] = true, [6636] = true, [7843] = true, [8432] = true, [8474] = true,
	[10569] = true, [10687] = true, [10688] = true, [10689] = true, [10690] = true, [10695] = true,
	[11116] = true, [11568] = true, [11582] = true, [11914] = true, [11948] = true, [11955] = true,
	[12565] = true, [12886] = true, [12922] = true, [16302] = true, [16321] = true, [16790] = true,
	[20483] = true, [21713] = true, [23361] = true, [23417] = true, [23645] = true, [23792] = true,
	[23818] = true, [24084] = true, [24278] = true, [24330] = true, [24335] = true, [24355] = true,
	[24421] = true, [24467] = true, [24474] = true, [24501] = true, [24504] = true, [24558] = true,
	[24559] = true, [25458] = true, [25465] = true, [25539] = true, [25552] = true, [25555] = true,
	[25658] = true, [25853] = true, [28038] = true, [28132] = true, [28607] = true, [29324] = true,
	[29443] = true, [29473] = true, [29588] = true, [29590] = true, [29778] = true, [30105] = true,
	[30540] = true, [30576] = true, [30712] = true, [30719] = true, [30811] = true, [31121] = true,
	[31122] = true, [31495] = true, [31518] = true, [31664] = true, [31702] = true, [31955] = true,
	[32385] = true, [32386] = true, [32405] = true, [32406] = true, [32726] = true, [32971] = true,
	[33096] = true, [33349] = true, [33614] = true, [33615] = true, [33621] = true, [33634] = true,
	[34023] = true, [34024] = true, [34076] = true, [34475] = true, [34483] = true, [34871] = true,
	[35233] = true, [35704] = true, [35792] = true, [36770] = true, [36771] = true, [37173] = true,
	[37265] = true, [37445] = true, [37661] = true, [37708] = true, [37877] = true, [38351] = true,
	[38657] = true, [38659] = true, [38676] = true, [38684] = true, [38689] = true, [38697] = true,
	[38699] = true, [38701] = true, [38709] = true, [38731] = true, [39041] = true, [39154] = true,
	[39157] = true, [39158] = true, [39164] = true, [39165] = true, [39187] = true, [39206] = true,
	[39238] = true, [39253] = true, [39268] = true, [39566] = true, [39574] = true, [39576] = true,
	[39615] = true, [39645] = true, [39664] = true, [39700] = true, [39737] = true, [40390] = true,
	[40397] = true, [40551] = true, [40587] = true, [40676] = true, [40730] = true, [40731] = true,
	[40732] = true, [40946] = true, [41131] = true, [41179] = true, [41340] = true, [41366] = true,
	[41372] = true, [41390] = true, [41430] = true, [41431] = true, [41615] = true, [41776] = true,
	[41988] = true, [42164] = true, [42419] = true, [42424] = true, [42441] = true, [42442] = true,
	[42479] = true, [42480] = true, [42481] = true, [42499] = true, [42624] = true, [42679] = true,
	[42769] = true, [42774] = true, [42781] = true, [42797] = true, [42837] = true, [42840] = true,
	[42918] = true, [42928] = true, [43101] = true, [43139] = true, [43142] = true, [43147] = true,
	[43153] = true, [43166] = true, [43206] = true, [43243] = true, [43289] = true, [43315] = true,
	[43524] = true, [43564] = true, [43608] = true, [43968] = true, [44048] = true, [44064] = true,
	[44065] = true, [44127] = true, [44186] = true, [44212] = true, [44222] = true, [44251] = true,
	[44304] = true, [44307] = true, [44433] = true, [44450] = true, [44653] = true, [44704] = true,
	[44890] = true, [44950] = true, [45072] = true, [46861] = true, [49132] = true, [49278] = true,
	[49368] = true, [56909] = true, [60501] = true, [180008] = true, [185956] = true, [271629] = true,
}

local barFrame = CreateFrame("Frame", "EltruismQuestItem", E.UIParent)
barFrame:SetPoint("BOTTOM", E.UIParent, "BOTTOM", 0, 34)
barFrame:SetSize(36, 36)
E:CreateMover(barFrame, "MoverEltruismQuestItem", "EltruismQuestItemBar", nil, nil, nil, "ALL,SOLO,ELTREUMUI", nil, 'ElvUI_EltreumUI,quests,item')

local buttonPool = {}
local seenItems = {}
local activeCount = 0
local pendingRefresh = false
local pendingStateUpdate = false
local refreshQueued = false

local function ApplyIconCrop(texture, width, height)
	local left, right, top, bottom = 0.08, 0.92, 0.08, 0.92
	if width and height and width > 0 and height > 0 then
		local ratio = width / height
		if ratio > 1 then
			local trim = (1 - (1 / ratio)) * 0.5
			top = top + trim
			bottom = bottom - trim
		elseif ratio < 1 then
			local trim = (1 - ratio) * 0.5
			left = left + trim
			right = right - trim
		end
	end
	texture:SetTexCoord(left, right, top, bottom)
end

local function ReadBagSlot(bag, slot)
	local info = GetContainerItemInfo(bag, slot)
	if not info then
		return nil
	end
	local link = info.hyperlink or GetContainerItemLink(bag, slot)
	local itemID = info.itemID or (link and tonumber(link:match("item:(%d+)")))
	return itemID, link, info.iconFileID, info.stackCount
end

local function IsBagQuestItem(bag, slot)
	local info = GetContainerItemQuestInfo(bag, slot)
	return info and info.isQuestItem and true or false
end

local function IsEligibleItem(itemID, isQuestFlag, isEquipped)
	if not itemID or IGNORED_ITEMS[itemID] then
		return false
	end
	if isEquipped then
		if GetItemSpell(itemID) == nil then
			return false
		end
		if EXTRA_QUEST_ITEMS[itemID] then
			return true
		end
		local classID = select(6, GetItemInfoInstant(itemID))
		return classID == QUEST_ITEM_CLASS_ID
	end
	if EXTRA_QUEST_ITEMS[itemID] then
		return true
	end
	if GetItemSpell(itemID) == nil then
		return false
	end
	if isQuestFlag then
		return true
	end
	local classID = select(6, GetItemInfoInstant(itemID))
	return classID == QUEST_ITEM_CLASS_ID
end

local function ButtonOnEnter(self)
	GameTooltip:SetOwner(E.UIParent, "ANCHOR_CURSOR")
	if self.bagID ~= nil then
		GameTooltip:SetBagItem(self.bagID, self.slotID)
	elseif self.slotID ~= nil then
		GameTooltip:SetInventoryItem("player", self.slotID)
	end
	if E.db.ElvUI_EltreumUI.quests.questitemsfade then
		self:SetAlpha(1)
	end
	if AB and E.private.actionbar.enable then
		AB:BindUpdate(self)
		AB:FixKeybindText(self)
	end
end

local function ButtonOnLeave(self)
	if E.db.ElvUI_EltreumUI.quests.questitemsfade then
		self:SetAlpha(0)
	end
	GameTooltip:Hide()
end

local function StyleButtonElements(btn, db)
	local width = db.questitemsize or 36
	local height = db.questitemsizey or 36
	btn:SetSize(width, height)
	ApplyIconCrop(btn.icon, width, height)

	btn.Count:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.actionbar.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))

	if E.db.ElvUI_EltreumUI.skins.shadow.enable and not E.db.ElvUI_EltreumUI.borders.universalborders then
		if not btn.shadow then
			ElvUI_EltreumUI:CreateFastShadow(btn, E.db.ElvUI_EltreumUI.skins.shadow.length)
		end
	end

	if db.showkeybind then
		local ab1 = E.db.actionbar and E.db.actionbar.bar1
		local hotkeyPos = (ab1 and ab1.hotkeyTextPosition) or "CENTER"
		local hotkeyX = (ab1 and ab1.hotkeyTextXOffset) or 0
		local hotkeyY = (ab1 and ab1.hotkeyTextYOffset) or 0
		local hotkeySize = (ab1 and ab1.hotkeyFontSize) or E.db.actionbar.fontSize or 12
		local hotkeyOutline = (ab1 and ab1.hotkeyFontOutline) or E.db.general.fontStyle
		btn.HotKey:ClearAllPoints()
		btn.HotKey:SetPoint(hotkeyPos, btn.icon, hotkeyPos, hotkeyX, hotkeyY)
		btn.HotKey:SetFont(E.LSM:Fetch("font", E.db.general.font), hotkeySize, ElvUI_EltreumUI:FontFlag(hotkeyOutline))
		btn.HotKey:Show()
	else
		btn.HotKey:Hide()
	end
end

local function GetOrCreateButton(index, db)
	local existing = buttonPool[index]
	if existing then
		return existing
	end

	local name = "EltruismQuestItem" .. index
	local btn = CreateFrame("Button", name, barFrame, "ActionButtonTemplate, SecureActionButtonTemplate")
	btn:CreateBackdrop('Transparent')
	btn:SetNormalTexture("")
	if btn.Border then btn.Border:Hide() end
	if btn.SlotBackground then btn.SlotBackground:Hide() end
	if btn.SlotArt then btn.SlotArt:Hide() end
	btn:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
	ElvUI_EltreumUI:MacroClick(btn)
	btn:SetAttribute("type*", "item")

	btn.name = name
	btn.bindstring = "CLICK " .. name .. ":LeftButton"
	btn.commandName = btn.bindstring

	btn.icon = btn.icon or btn:CreateTexture(nil, "ARTWORK")
	btn.icon:SetAllPoints()

	btn.Count = btn.Count or btn:CreateFontString(nil, "ARTWORK")
	btn.Count:ClearAllPoints()
	btn.Count:SetPoint("BOTTOMRIGHT", btn.icon, 0, 0)
	btn.Count:SetTextColor(1, 1, 1)

	btn.cooldown = btn.cooldown or CreateFrame("Cooldown", nil, btn, "CooldownFrameTemplate")
	btn.cooldown:SetAllPoints()
	E:RegisterCooldown(btn.cooldown)

	btn.HotKey = btn.HotKey or btn:CreateFontString(nil, "ARTWORK", "NumberFontNormalSmallGray")

	if AB and AB.StyleButton then
		AB:StyleButton(btn)
	end

	btn:SetScript("OnEnter", ButtonOnEnter)
	btn:SetScript("OnLeave", ButtonOnLeave)

	StyleButtonElements(btn, db)
	buttonPool[index] = btn
	return btn
end

local function LayoutButtons(count, db)
	if count == 0 then
		return
	end
	local width = db.questitemsize or 36
	local height = db.questitemsizey or 36
	local spacing = db.questitemspacing or 2

	if db.questorientation == "VERTICAL" then
		local step = height + spacing
		for i = 1, count do
			local btn = buttonPool[i]
			btn:ClearAllPoints()
			btn:SetPoint("CENTER", barFrame, "CENTER", 0, -((i - 1) * step))
		end
	else
		local step = width + spacing
		local startOffset = -((count - 1) * step) * 0.5
		for i = 1, count do
			local btn = buttonPool[i]
			btn:ClearAllPoints()
			btn:SetPoint("CENTER", barFrame, "CENTER", startOffset + ((i - 1) * step), 0)
		end
	end
end

local function RefreshCooldowns()
	for i = 1, activeCount do
		local btn = buttonPool[i]
		local startTime, duration, enable
		if btn.bagID ~= nil then
			startTime, duration, enable = GetContainerItemCooldown(btn.bagID, btn.slotID)
		elseif btn.slotID ~= nil then
			startTime, duration, enable = GetInventoryItemCooldown("player", btn.slotID)
		end
		if startTime and duration then
			CooldownFrame_Set(btn.cooldown, startTime, duration, enable)
		end
	end
end

local function RefreshKeybinds(db)
	for i = 1, activeCount do
		local btn = buttonPool[i]
		if db.showkeybind then
			btn.HotKey:Show()
			btn.HotKey:SetText(GetBindingKey(btn.bindstring) or "")
			if AB and AB.FixKeybindText then
				AB:FixKeybindText(btn)
			end
		else
			btn.HotKey:Hide()
		end
	end
end

local function ConfigureButton(index, bagID, slotID, itemID, icon, stackCount, db)
	local btn = GetOrCreateButton(index, db)
	StyleButtonElements(btn, db)
	btn.bagID = bagID
	btn.slotID = slotID
	btn.itemID = itemID
	btn.icon:SetTexture(icon)
	btn.Count:SetText((stackCount and stackCount > 1) and tostring(stackCount) or "")
	btn:SetAttribute("type*", "item")
	btn:SetAttribute("bag", bagID)
	btn:SetAttribute("slot", slotID)
	ElvUI_EltreumUI:MacroClick(btn)
	btn:SetAlpha((db.questitemsfade and not btn:IsMouseOver()) and 0 or 1)
	btn:Enable()
	btn:Show()
end

local function ScanAndRender()
	if InCombatLockdown() then
		pendingRefresh = true
		return
	end
	pendingRefresh = false

	local db = E.db.ElvUI_EltreumUI.quests
	wipe(seenItems)
	local index = 0

	for bag = 0, NUM_BAG_SLOTS do
		local numSlots = GetContainerNumSlots(bag) or 0
		for slot = 1, numSlots do
			local itemID, _, icon, stackCount = ReadBagSlot(bag, slot)
			if itemID and not seenItems[itemID] then
				local isQuestFlag = IsBagQuestItem(bag, slot)
				if IsEligibleItem(itemID, isQuestFlag, false) then
					seenItems[itemID] = true
					if not icon then
						icon = select(5, GetItemInfoInstant(itemID))
					end
					index = index + 1
					ConfigureButton(index, bag, slot, itemID, icon, stackCount, db)
				end
			end
		end
	end

	for invSlot = FIRST_EQUIP_SLOT, LAST_EQUIP_SLOT do
		local itemID = GetInventoryItemID("player", invSlot)
		if itemID and not seenItems[itemID] and IsEligibleItem(itemID, false, true) then
			seenItems[itemID] = true
			local icon = GetInventoryItemTexture("player", invSlot) or select(5, GetItemInfoInstant(itemID))
			index = index + 1
			ConfigureButton(index, nil, invSlot, itemID, icon, nil, db)
		end
	end

	activeCount = index
	for i = index + 1, #buttonPool do
		local btn = buttonPool[i]
		btn.bagID = nil
		btn.slotID = nil
		btn.itemID = nil
		btn:SetAttribute("bag", nil)
		btn:SetAttribute("slot", nil)
		btn:Disable()
		btn:Hide()
	end

	LayoutButtons(activeCount, db)
	RefreshKeybinds(db)
	RefreshCooldowns()
end

local function RunScheduledRefresh()
	refreshQueued = false
	ScanAndRender()
end

local function ScheduleRefresh()
	if not refreshQueued then
		refreshQueued = true
		C_Timer.After(0, RunScheduledRefresh)
	end
end

barFrame:SetScript("OnEvent", function(_, event)
	if event == "PLAYER_REGEN_ENABLED" then
		if pendingStateUpdate then
			pendingStateUpdate = false
			ElvUI_EltreumUI:QuestItem()
			return
		end
		if pendingRefresh then
			ScanAndRender()
		end
	elseif event == "ACTIONBAR_UPDATE_COOLDOWN" or event == "BAG_UPDATE_COOLDOWN" then
		if activeCount > 0 then
			RefreshCooldowns()
		end
	elseif event == "UPDATE_BINDINGS" then
		if activeCount > 0 then
			RefreshKeybinds(E.db.ElvUI_EltreumUI.quests)
		end
	else
		ScheduleRefresh()
	end
end)

function ElvUI_EltreumUI:QuestItem()
	local db = E.db.ElvUI_EltreumUI.quests
	local shouldRun = db.questitems and (ElvUI_EltreumUI:IsInInstance(nil, nil, nil, true) == "none")

	if not shouldRun then
		barFrame:UnregisterAllEvents()
		if InCombatLockdown() then
			pendingStateUpdate = true
			barFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
		else
			pendingStateUpdate = false
			pendingRefresh = false
			barFrame:Hide()
		end
		return
	end

	barFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
	barFrame:RegisterUnitEvent("UNIT_INVENTORY_CHANGED", "player")
	barFrame:RegisterEvent("BAG_UPDATE_DELAYED")
	barFrame:RegisterEvent("BAG_NEW_ITEMS_UPDATED")
	barFrame:RegisterEvent("MAIL_SUCCESS")
	barFrame:RegisterEvent("QUEST_ACCEPTED")
	barFrame:RegisterEvent("QUEST_WATCH_UPDATE")
	barFrame:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
	barFrame:RegisterEvent("BAG_UPDATE_COOLDOWN")
	barFrame:RegisterEvent("UPDATE_BINDINGS")
	barFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")

	if InCombatLockdown() then
		pendingStateUpdate = true
		return
	end

	pendingStateUpdate = false
	if db.questitemsbar1 and E.private.actionbar.enable and _G.ElvUI_Bar1Button1 then
		barFrame:SetParent(_G.ElvUI_Bar1Button1)
	else
		barFrame:SetParent(E.UIParent)
	end

	barFrame:SetSize(db.questitemsize or 36, db.questitemsizey or 36)
	barFrame:SetClampedToScreen(true)
	barFrame:SetFrameStrata("MEDIUM")
	barFrame:Show()

	ScanAndRender()
end
