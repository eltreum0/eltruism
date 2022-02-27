local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local DT = E:GetModule("DataTexts")

--modified elvui config datatext for opening eltruism
local InCombatLockdown = InCombatLockdown
local displayString = ''
local configText = 'Eltruism'
local lastPanel

local function OnEvent(self)
	lastPanel = self
	self.text:SetFormattedText(displayString, E.global.datatexts.settings.ElvUI.Label ~= '' and E.global.datatexts.settings.ElvUI.Label or configText)
end

local function OnEnter()
	DT.tooltip:ClearLines()
	DT.tooltip:AddDoubleLine(L["Click:"], L["Open Eltruism Configuration Panel"], 1, 1, 1)
	DT.tooltip:Show()
end

local function OnClick(_, button)
	if InCombatLockdown() then _G.UIErrorsFrame:AddMessage(E.InfoColor.._G.ERR_NOT_IN_COMBAT) return end

	if button == 'LeftButton' then
		E:ToggleOptionsUI()
		E.Libs.AceConfigDialog:SelectGroup('ElvUI', 'ElvUI_EltreumUI')
	elseif button == 'RightButton' then
		E:ToggleOptionsUI()
		E.Libs.AceConfigDialog:SelectGroup('ElvUI', 'ElvUI_EltreumUI')
	end
end

local function ValueColorUpdate(hex)
	displayString = strjoin('', hex, '%s|r')

	if lastPanel then
		OnEvent(lastPanel, 'ELVUI_COLOR_UPDATE')
	end
end
E.valueColorUpdateFuncs[ValueColorUpdate] = true
DT:RegisterDatatext('Eltruism', nil, nil, OnEvent, nil, OnClick, OnEnter, nil, L["Eltruism Config"], nil, ValueColorUpdate)


--just a modified ammo datatext from ElvUI to reduce the name of the ammo and add icon
if E.Classic or E.TBC then


	local function EltruismHonorDatatext(dt)
		local honorCurrencyInfo = C_CurrencyInfo.GetCurrencyInfo(Constants.CurrencyConsts.CLASSIC_HONOR_CURRENCY_ID)
		local arenaCurrencyInfo = C_CurrencyInfo.GetCurrencyInfo(Constants.CurrencyConsts.CLASSIC_ARENA_POINTS_CURRENCY_ID)

		dt.text:SetFormattedText('%s: %s%s|r  %s: %s%s|r ', HONOR, ElvUI[1].media.hexvaluecolor, honorCurrencyInfo.quantity,ARENA, ElvUI[1].media.hexvaluecolor,arenaCurrencyInfo.quantity)
	end
	DT:RegisterDatatext('Eltruism Honor/Arena Points', _G.CURRENCY, {'CHAT_MSG_CURRENCY', 'CURRENCY_DISPLAY_UPDATE'}, EltruismHonorDatatext, nil, nil, nil, nil, L["Eltruism Honor/Arena Points"])






	if E.myclass ~= 'HUNTER' and E.myclass ~= 'ROGUE' and E.myclass ~= 'WARLOCK' and E.myclass ~= 'WARRIOR' then return end
	local _G = _G
	local select, wipe = _G.select, _G.wipe
	local format, strjoin = _G.format, _G.strjoin
	local GetItemInfo = _G.GetItemInfo
	local GetItemInfoInstant = _G.GetItemInfoInstant
	local GetItemCount = _G.GetItemCount
	local GetContainerItemID = _G.GetContainerItemID
	local GetInventoryItemCount = _G.GetInventoryItemCount
	local GetInventoryItemID = _G.GetInventoryItemID
	local ContainerIDToInventoryID = _G.ContainerIDToInventoryID
	local GetContainerNumSlots = _G.GetContainerNumSlots
	local GetContainerNumFreeSlots = _G.GetContainerNumFreeSlots
	local GetItemQualityColor = _G.GetItemQualityColor
	local NUM_BAG_SLOTS = NUM_BAG_SLOTS
	local NUM_BAG_FRAMES = NUM_BAG_FRAMES
	local INVTYPE_AMMO = INVTYPE_AMMO
	local INVSLOT_RANGED = INVSLOT_RANGED
	local INVSLOT_AMMO = INVSLOT_AMMO
	local LE_ITEM_CLASS_QUIVER = LE_ITEM_CLASS_QUIVER
	local LE_ITEM_CLASS_CONTAINER = LE_ITEM_CLASS_CONTAINER
	local iconString = '|T%s:16:16:0:0:64:64:4:55:4:55|t'
	local displayString = ''
	local lastPanel
	local itemName = {}
	local waitingItemID
	local function OnEvent(self, event, ...)
		local name, count, itemID, itemEquipLoc
		if event == 'GET_ITEM_INFO_RECEIVED' then
			itemID = ...
			if itemID ~= waitingItemID then return end
			waitingItemID = nil
			if not itemName[itemID] then
				itemName[itemID] = GetItemInfo(itemID)
			end
			self:UnregisterEvent('GET_ITEM_INFO_RECEIVED')
		end
		if E.myclass == 'WARLOCK' then
			local namewarlock
			local name, _, _, _, _, _, _, _, _, texture = GetItemInfo(6265)
			count = GetItemCount(6265)
			if texture == nil then
				namewarlock = itemName[6265]
			else
				namewarlock = (strjoin('', format(iconString, texture), ' ', name))
			end
			--name, count = itemName[6265] or GetItemInfo(6265), GetItemCount(6265)
			--if name and not itemName[6265] then
			--	itemName[6265] = name
			--end
			self.text:SetFormattedText(displayString, namewarlock or 'Soul Shard', count or 0) -- Does not need localized. It gets updated.
		else
			local RangeItemID = GetInventoryItemID('player', INVSLOT_RANGED)
			if RangeItemID then
				itemEquipLoc = select(4, GetItemInfoInstant(RangeItemID))
			end
			if itemEquipLoc == 'INVTYPE_THROWN' then
				itemID, count = RangeItemID, GetInventoryItemCount('player', INVSLOT_RANGED)
			else
				itemID, count = GetInventoryItemID('player', INVSLOT_AMMO), GetInventoryItemCount('player', INVSLOT_AMMO)
			end
			if (itemID and itemID > 0) and (count > 0) then
				if itemID then
					--name = itemName[itemID] or GetItemInfo(itemID)
					local _, _, _, _, _, _, _, _, _, texture = GetItemInfo(itemID)
					if texture == nil then
						name = itemName[itemID] or GetItemInfo(itemID)
					else
						name = (strjoin('', format(iconString, texture), '', ' '))
					end
				end
				if name and not itemName[itemID] then
					itemName[itemID] = name
				end
				self.text:SetFormattedText(displayString, name or INVTYPE_AMMO, count or 0) -- Does not need localized. It gets updated.
			else
				self.text:SetFormattedText(displayString, INVTYPE_AMMO, 0)
			end
		end
		if not name then
			waitingItemID = itemID
			self:RegisterEvent('GET_ITEM_INFO_RECEIVED')
		end
		lastPanel = self
	end
	local itemCount = {}
	local function OnEnter()
		DT.tooltip:ClearLines()
		if E.myclass == 'HUNTER' or E.myclass == 'ROGUE' or E.myclass == 'WARRIOR' then
			wipe(itemCount)
			DT.tooltip:AddLine(INVTYPE_AMMO)
			for i = 0, NUM_BAG_FRAMES do
				for j = 1, GetContainerNumSlots(i) do
					local itemID = GetContainerItemID(i, j)
					if itemID and not itemCount[itemID] then
						local name, _, quality, _, _, _, _, _, equipLoc, texture = GetItemInfo(itemID)
						local count = GetItemCount(itemID)
						if equipLoc == 'INVTYPE_AMMO' or equipLoc == 'INVTYPE_THROWN' then
							DT.tooltip:AddDoubleLine(strjoin('', format(iconString, texture), ' ', name), count, GetItemQualityColor(quality))
							itemCount[itemID] = count
						end
					end
				end
			end
			DT.tooltip:AddLine(' ')
		end
		for i = 1, NUM_BAG_SLOTS do
			local itemID = GetInventoryItemID('player', ContainerIDToInventoryID(i))
			if itemID then
				local name, _, quality, _, _, _, itemSubType, _, _, texture, itemClassID, itemSubClassID = GetItemInfo(itemID)
				if itemSubClassID == LE_ITEM_CLASS_QUIVER or itemClassID == LE_ITEM_CLASS_CONTAINER and itemSubClassID == 1 then
					local free, total = GetContainerNumFreeSlots(i), GetContainerNumSlots(i)
					local used = total - free
					DT.tooltip:AddLine(itemSubType)
					DT.tooltip:AddDoubleLine(strjoin('', format(iconString, texture), '  ', name), format('%d / %d', used, total), GetItemQualityColor(quality))
				end
			end
		end
		DT.tooltip:Show()
	end
	local function OnClick(_, btn)
		if btn == 'LeftButton' then
			if not E.private.bags.enable then
				for i = 1, NUM_BAG_SLOTS do
					local itemID = GetInventoryItemID('player', ContainerIDToInventoryID(i))
					if itemID then
						local itemClassID, itemSubClassID = select(11, GetItemInfo(itemID))
						if itemSubClassID == LE_ITEM_CLASS_QUIVER or itemClassID == LE_ITEM_CLASS_CONTAINER and itemSubClassID == 1 then
							_G.ToggleBag(i)
						end
					end
				end
			else
				_G.ToggleAllBags()
			end
		end
	end
	local function ValueColorUpdate(hex)
		displayString = strjoin('', '%s: ', hex, '%d|r')
		if lastPanel ~= nil then
			OnEvent(lastPanel)
		end
	end
	E.valueColorUpdateFuncs[ValueColorUpdate] = true
	DT:RegisterDatatext("Eltruism Ammo", nil, {'BAG_UPDATE', 'UNIT_INVENTORY_CHANGED'}, OnEvent, nil, OnClick, OnEnter, nil, L["Eltruism Ammo"])
end
