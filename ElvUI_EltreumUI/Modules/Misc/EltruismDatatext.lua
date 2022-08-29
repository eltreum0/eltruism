local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local DT = E:GetModule("DataTexts")
local InCombatLockdown = _G.InCombatLockdown
local GetCombatRatingBonus = _G.GetCombatRatingBonus
local math = _G.math
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
local C_CurrencyInfo = _G.C_CurrencyInfo
local Constants = _G.Constants --maybe should not be
local UIErrorsFrame = _G.UIErrorsFrame
local ERR_NOT_IN_COMBAT = _G.ERR_NOT_IN_COMBAT
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------hearthstone/tp item datatext
--based yet again on elvui config
--most from https://www.wowhead.com/item=6948/hearthstone#comments
local TeleportsItems = {
	6948, --hearthstone
	22630, --atiesh-greatstaff-of-the-guardian
	22631, --atiesh-greatstaff-of-the-guardian
	22632, --atiesh-greatstaff-of-the-guardian
	22589, --atiesh-greatstaff-of-the-guardian
	54452, --ethereal-portal
	93672, --dark-portal
	184871, --dark-portal 2?
	110560, --garrison-hearthstone
	140192, --dalaran-hearthstone
	141605, --flight-masters-whistle
	128353,--admirals-compass
	18984, --dimensional-ripper-everlook
	18986, --ultrasafe-transporter-gadgetzan
	30542, --dimensional-ripper-area-52
	30544, --ultrasafe-transporter-toshleys-station
	48933, --wormhole-generator-northrend
	87215, --wormhole-generator-pandaria
	112059, --wormhole-centrifuge
	151652, --wormhole-generator-argus
	168807,--wormhole-generator-kultiras
	168808,--wormhole-generator-zandalar
	172924, --wormhole-generator-shadowlands
	32757, --blessed-medallion-of-karabor
	40585, --signet-of-the-kirin-tor
	40586, --band-of-the-kirin-tor
	48954, --etched-band-of-the-kirin-tor
	48955, --etched-loop-of-the-kirin-tor
	48956, --etched-ring-of-the-kirin-tor
	48957, --etched-signet-of-the-kirin-tor
	45688, --inscribed-band-of-the-kirin-tor
	45689, --inscribed-loop-of-the-kirin-tor
	45690, --inscribed-ring-of-the-kirin-tor
	45691, --inscribed-signet-of-the-kirin-tor
	44934, --loop-of-the-kirin-tor
	44935, --ring-of-the-kirin-tor
	51557, --runed-signet-of-the-kirin-tor
	51558, --runed-loop-of-the-kirin-tor
	51559, --runed-ring-of-the-kirin-tor
	51560, --runed-band-of-the-kirin-tor
	139599, --empowered-ring-of-the-kirin-tor
	63206, --wrap-of-unity
	63207, --wrap-of-unity
	63352, --shroud-of-cooperation
	63353, --shroud-of-cooperation
	65274, --cloak-of-coordination
	65360, --cloak-of-coordination
	46874, --argent-crusaders-tabard
	63378, --hellscreams-reach-tabard
	63379, --baradins-wardens-tabard
	28585, --ruby-slippers
	32757, --blessed-medallion-of-karabor
	37863, --direbrews-remote
	43824,--the-schools-of-arcane-magic-mastery
	50287, --boots-of-the-bay
	52251, --jainas-locket
	64457, --the-last-relic-of-argus
	95050, --the-brassiest-knuckle
	95051, --the-brassiest-knuckle
	103678, --time-lost-artifact
	118663,--relic-of-karabor
	118907, --pit-fighters-punching-ring
	118908, --pit-fighters-punching-ring
	129276,--beginners-guide-to-dimensional-rifting
	128502,--hunters-seeking-crystal
	138448,--emblem-of-margoss
	142298, --astonishingly-scarlet-slippers
	142469, --violet-seal-of-the-grand-magus
	144391, --pugilists-powerful-punching-ring
	151016,--fractured-necrolyte-skull
	29796, --socrethars-teleportation-stone
	61379, --gidwins-hearthstone
	68808, --heros-hearthstone
	68809, --veterans-hearthstone
	92510, --voljins-hearthstone
	35230, --darnarians-scroll-of-teleportation
	119183, --scroll-of-risky-recall
	139590, --scroll-of-teleport-ravenholdt
	141015, --scroll-of-town-portal-kaldelar
	141014, --scroll-of-town-portal-sashjtar
	141017, --scroll-of-town-portal-liantril
	141016, --scroll-of-town-portal-faronaar
	141013, --scroll-of-town-portal-shalanir
	142543, --scroll-of-town-portal
	95567, --kirin-tor-beacon
	95568, --sunreaver-beacon
	37118, --scroll-of-recall
	44314, --scroll-of-recall-ii
	44315, --scroll-of-recall-iii
	58487, --potion-of-deepholm
	17690, --frostwolf-insignia-rank-1
	17691, --stormpike-insignia-rank-1
	17900, --stormpike-insignia-rank-2
	17901, --stormpike-insignia-rank-3
	17902, --stormpike-insignia-rank-4
	17903, --stormpike-insignia-rank-5
	17904, --stormpike-insignia-rank-6
	17905, --frostwolf-insignia-rank-2
	17906, --frostwolf-insignia-rank-3
	17907, --frostwolf-insignia-rank-4
	17908, --frostwolf-insignia-rank-5
	17909, --frostwolf-insignia-rank-6
}
local TeleportsSpells = {
	556,--astral-recall
	131204, --path-of-the-jade-serpent
	131205, --path-of-the-stout-brew
	131206, --path-of-the-shado-pan
	131222, --path-of-the-mogu-king
	131225, --path-of-the-setting-sun
	131228, --path-of-the-black-ox
	131229, --path-of-the-scarlet-mitre
	131231, --path-of-the-scarlet-blade
	131232, --path-of-the-necromancer
	159895, --path-of-the-bloodmaul
	159896, --path-of-the-iron-prow
	159897, --path-of-the-vigilant
	159898, --path-of-the-skies
	159899, --path-of-the-crescent-moon
	159900, --path-of-the-dark-rail
	159901, --path-of-the-verdant
	159902, --path-of-the-burning-mountain
	354462, --path-of-the-courageous
	354463, --path-of-the-plagued
	354464, --path-of-the-misty-forest
	354465, --path-of-the-sinful-soul
	354467, --path-of-the-undefeated
	354468, --path-of-the-scheming-loa
	354469, --path-of-the-stone-warden
	367416, --path-of-the-streetwise-merchant
	373262, --path-of-the-fallen-guardian
	373274, --path-of-the-scrappy-prince
	373190, --path-of-the-sire
	373191, --path-of-the-tormented-soul
	373192, --path-of-the-first-ones
}
local teleportupdate = CreateFrame("FRAME")
local TimeSinceLastUpdate = 0
local ONUPDATE_INTERVAL = 1
local displayStringEltruismTeleports = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Warcraft3Hearthstone.tga:18:18:0:0:64:64:2:62:2:62|t "..GetBindLocation()
local function EltruismTeleportsOnEvent(self)
	local sizeString = "\":"..E.db["chat"]["fontSize"]..":"..E.db["chat"]["fontSize"].."\""
	local start, duration = GetItemCooldown(6948)
	local cooldown = start + duration - GetTime()
	if cooldown >= 2 then
		displayStringEltruismTeleports = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Warcraft3Hearthstone.tga:18:18:0:0:64:64:2:62:2:62|t |cffED7474"..GetBindLocation().."|r"
	elseif cooldown <= 0 then
		displayStringEltruismTeleports = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Warcraft3Hearthstone.tga:18:18:0:0:64:64:2:62:2:62|t "..GetBindLocation()
	end
	self.text:SetText(displayStringEltruismTeleports)
end
local function EltruismTeleportsOnEnter(self)
	teleportupdate:SetScript("OnUpdate", function(self, elapsed)
		--print("onupdate spam"..math.random(1,99))
		TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
		if TimeSinceLastUpdate >= ONUPDATE_INTERVAL then
			TimeSinceLastUpdate = 0
			DT.tooltip:ClearLines()
			local sizeString = "\":"..E.db["chat"]["fontSize"]..":"..E.db["chat"]["fontSize"].."\""
			for i,v in pairs(TeleportsItems) do
				local texture = GetItemIcon(v)
				local name = GetItemInfo(v)
				local hasItem = GetItemCount(v)
				if texture and name and (hasItem > 0 or (E.Retail and PlayerHasToy(v) and C_ToyBox.IsToyUsable(v)) ) then
					local start, duration = GetItemCooldown(v)
					local cooldown = start + duration - GetTime()
					if cooldown >= 2 then
						local hours = math.floor(cooldown /3600)
						local minutes = math.floor(cooldown / 60)
						local seconds = string.format("%02.f", math.floor(cooldown - minutes * 60))
						if hours >= 1 then
							minutes = math.floor(mod(cooldown,3600)/60)
							DT.tooltip:AddDoubleLine("|T"..texture..":14:14:0:0:64:64:5:59:5:59|t |cffdb3030"..name.."|r", ("|cffdb3030"..hours.."h"..minutes.."m"..":"..seconds.."s|r"))
						else
							DT.tooltip:AddDoubleLine("|T"..texture..":14:14:0:0:64:64:5:59:5:59|t |cffdb3030"..name.."|r", ("|cffdb3030"..minutes.."m"..":"..seconds.."s|r"))
						end
					elseif cooldown <= 0 then
						DT.tooltip:AddDoubleLine("|T"..texture..":14:14:0:0:64:64:5:59:5:59|t |cffFFFFFF"..name.."|r", "|cff00FF00"..L["Ready"].."|r")
					end
				end
			end
			for i,v in pairs(TeleportsSpells) do
				local texture = GetSpellTexture(v)
				local name = GetSpellInfo(v)
				local hasSpell = IsSpellKnown(v)
				if texture and name and hasSpell then
					local start, duration = GetSpellCooldown(v)
					local cooldown = start + duration - GetTime()
					if cooldown >= 2 then
						local hours = math.floor(cooldown /3600)
						local minutes = math.floor(cooldown / 60)
						local seconds = string.format("%02.f", math.floor(cooldown - minutes * 60))
						if hours >= 1 then
							minutes = math.floor(mod(cooldown,3600)/60)
							DT.tooltip:AddDoubleLine("|T"..texture..":14:14:0:0:64:64:5:59:5:59|t |cffdb3030"..name.."|r", ("|cffdb3030"..hours.."h"..minutes.."m"..":"..seconds.."s|r"))
						else
							DT.tooltip:AddDoubleLine("|T"..texture..":14:14:0:0:64:64:5:59:5:59|t |cffdb3030"..name.."|r", ("|cffdb3030"..minutes.."m"..":"..seconds.."s|r"))
						end
					elseif cooldown <= 0 then
						DT.tooltip:AddDoubleLine("|T"..texture..":14:14:0:0:64:64:5:59:5:59|t |cffFFFFFF"..name.."|r", "|cff00FF00"..L["Ready"].."|r")
					end
				end
			end
			local start, duration = GetItemCooldown(6948)
			local cooldown = start + duration - GetTime()
			if cooldown >= 2 then
				displayStringEltruismTeleports = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Warcraft3Hearthstone.tga:18:18:0:0:64:64:2:62:2:62|t |cffdb3030"..GetBindLocation().."|r"
			else
				displayStringEltruismTeleports = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Warcraft3Hearthstone.tga:18:18:0:0:64:64:2:62:2:62|t "..GetBindLocation()
			end
			DT.tooltip:Show()
		end
	end)
end
local function EltruismTeleportsOnLeave()
	teleportupdate:SetScript("OnUpdate", nil)
end
DT:RegisterDatatext('EltruismTeleports', nil, { 'SPELL_UPDATE_COOLDOWN', 'BAG_UPDATE_COOLDOWN', "HEARTHSTONE_BOUND", "COMBAT_LOG_EVENT_UNFILTERED"}, EltruismTeleportsOnEvent, nil, nil, EltruismTeleportsOnEnter, EltruismTeleportsOnLeave, L["Eltruism Hearthstones/Teleports"], nil, nil)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------spell haste datatext
local function EltruismSpellHasteDatatext(dt)
	local spellhaste = GetCombatRatingBonus(CR_HASTE_SPELL)
	local spellhastepc = ((math.ceil(spellhaste*100))/100).."%"
	dt.text:SetFormattedText('%s: %s%s|r', L["Spell Haste"], ElvUI[1].media.hexvaluecolor, spellhastepc)
end
if E.Wrath or E.TBC or E.Classic then
	DT:RegisterDatatext('Eltruism Spellhaste', STAT_CATEGORY_ENHANCEMENTS, {'COMBAT_RATING_UPDATE'}, EltruismSpellHasteDatatext, nil, nil, nil, nil, L["Eltruism Spell Haste"])
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------honor datatext
local function EltruismHonorDatatext(dt)
	local honorCurrencyInfo = C_CurrencyInfo.GetCurrencyInfo(Constants.CurrencyConsts.CLASSIC_HONOR_CURRENCY_ID)
	local arenaCurrencyInfo
	if E.Wrath or E.TBC then
		arenaCurrencyInfo = C_CurrencyInfo.GetCurrencyInfo(Constants.CurrencyConsts.CLASSIC_ARENA_POINTS_CURRENCY_ID)
		dt.text:SetFormattedText('%s: %s%s|r %s: %s%s|r ', HONOR, ElvUI[1].media.hexvaluecolor, honorCurrencyInfo.quantity,ARENA, ElvUI[1].media.hexvaluecolor,arenaCurrencyInfo.quantity)
	elseif E.Classic then
		dt.text:SetFormattedText('%s: %s%s|r', HONOR, ElvUI[1].media.hexvaluecolor, honorCurrencyInfo.quantity)
	elseif E.Retail then
		local retailconquest = C_CurrencyInfo.GetCurrencyInfo(1602)
		local retailhonor = C_CurrencyInfo.GetCurrencyInfo(1792)
		dt.text:SetFormattedText('%s: %s%s|r %s: %s%s|r ', COMBAT_HONOR_GAIN, ElvUI[1].media.hexvaluecolor, retailhonor.quantity,PVP_CONQUEST, ElvUI[1].media.hexvaluecolor,retailconquest.quantity)
	end
end
if E.Wrath or E.TBC or E.Classic then
	DT:RegisterDatatext('Eltruism Honor/Arena Points', CURRENCY, {'CHAT_MSG_CURRENCY', 'CURRENCY_DISPLAY_UPDATE'}, EltruismHonorDatatext, nil, nil, nil, nil, L["Eltruism Honor/Arena Points"])
elseif E.Retail then
	DT:RegisterDatatext('Eltruism Honor/Conquest Points', CURRENCY, {'CHAT_MSG_CURRENCY', 'CURRENCY_DISPLAY_UPDATE'}, EltruismHonorDatatext, nil, nil, nil, nil, L["Eltruism Honor/Conquest Points"])
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------modified elvui config panel open
local lastPanelEltruismConfig
local displayStringEltruismconfig = ''
local function EltruismConfigOnEvent(self)
	lastPanelEltruismConfig = self
	self.text:SetFormattedText(displayStringEltruismconfig, E.global.datatexts.settings.ElvUI.Label ~= '' and E.global.datatexts.settings.ElvUI.Label or 'Eltruism')
end

local function EltruismConfigOnEnter()
	DT.tooltip:ClearLines()
	DT.tooltip:AddDoubleLine(L["Left Click:"], L["Open Eltruism Configuration Panel"], 1, 1, 1)
	DT.tooltip:AddDoubleLine(L["Right Click:"], L["Open Eltruism Installation"], 1, 1, 1)
	DT.tooltip:Show()
end

local function EltruismConfigOnClick(_, button)
	if InCombatLockdown() then UIErrorsFrame:AddMessage(E.InfoColor..ERR_NOT_IN_COMBAT) return end

	if button == 'LeftButton' then
		E:ToggleOptionsUI()
		E.Libs.AceConfigDialog:SelectGroup('ElvUI', 'ElvUI_EltreumUI')
	elseif button == 'RightButton' then
		E:GetModule('PluginInstaller'):Queue(ElvUI_EltreumUI.InstallerData)
	end
end

local function EltruismConfigValueColorUpdate(hex)
	displayStringEltruismconfig = strjoin('', hex, '%s|r')

	if lastPanelEltruismConfig then
		EltruismConfigOnEvent(lastPanelEltruismConfig, 'ELVUI_COLOR_UPDATE')
	end
end
E.valueColorUpdateFuncs[EltruismConfigValueColorUpdate] = true
DT:RegisterDatatext('Eltruism', nil, nil, EltruismConfigOnEvent, nil, EltruismConfigOnClick, EltruismConfigOnEnter, nil, L["Eltruism Config"], nil, EltruismConfigValueColorUpdate)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------just a modified ammo datatext from ElvUI to reduce the name of the ammo and add icon
if E.Classic or E.Wrath or E.TBC then
	if E.myclass ~= 'HUNTER' and E.myclass ~= 'ROGUE' and E.myclass ~= 'WARLOCK' and E.myclass ~= 'WARRIOR' then return end
	local iconString = '|T%s:16:16:0:0:64:64:4:55:4:55|t'
	local itemName = {}
	local displayString = ''
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
							ToggleBag(i)
						end
					end
				end
			else
				ToggleAllBags()
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
