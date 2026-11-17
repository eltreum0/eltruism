local E, L = unpack(ElvUI)
local _G = _G
local DT = E:GetModule("DataTexts")
local GetCombatRatingBonus = _G.GetCombatRatingBonus
local math = _G.math
local mathceil = math.ceil
local Constants = _G.Constants --maybe should not be
local HONOR = _G.HONOR
local ARENA= _G.ARENA
local COMBAT_HONOR_GAIN = _G.COMBAT_HONOR_GAIN
local PVP_CONQUEST = _G.PVP_CONQUEST
local CURRENCY = _G.CURRENCY
local STAT_CATEGORY_ENHANCEMENTS = _G.STAT_CATEGORY_ENHANCEMENTS
local CR_HASTE_SPELL = _G.CR_HASTE_SPELL
local C_CurrencyInfo_GetCurrencyInfo = _G.C_CurrencyInfo and _G.C_CurrencyInfo.GetCurrencyInfo or ""
local format = _G.format
local select = _G.select
local gsub = _G.gsub
local GetLootMethod = _G.C_PartyInfo and _G.C_PartyInfo.GetLootMethod or _G.GetLootMethod
local IsInGroup = _G.IsInGroup

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------spell haste datatext
local function EltruismSpellHasteDatatext(dt)
	local spellhaste = GetCombatRatingBonus(CR_HASTE_SPELL)
	local spellhastepc = ((mathceil(spellhaste*100)) * 0.01)..'%'
	dt.text:SetFormattedText('%s: %s%s|r', L["Spell Haste"], E.media.hexvaluecolor, spellhastepc)
end
if not E.Retail and not E.Classic then
	DT:RegisterDatatext('Eltruism Spellhaste', STAT_CATEGORY_ENHANCEMENTS, {'COMBAT_RATING_UPDATE',"UNIT_SPELL_HASTE"}, EltruismSpellHasteDatatext, nil, nil, nil, nil, L["Eltruism Spell Haste"])
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------honor datatext
local function EltruismHonorDatatext(dt)
	local arg2 = E.Retail and COMBAT_HONOR_GAIN or HONOR

	local honorCurrencyID = (not E.Modern and Constants.CurrencyConsts.CLASSIC_HONOR_CURRENCY_ID) or (E.Modern and 1792)
	local arg4 = (not E.Classic and C_CurrencyInfo_GetCurrencyInfo(honorCurrencyID).quantity) or select(2, _G.GetPVPThisWeekStats())

	local arg5 = (E.Retail and PVP_CONQUEST) or (not E.Modern and ARENA) or _G.RANK

	local classicRank = E.Classic and _G.UnitPVPRank('player')-4 or E.Forever and _G.UnitHonorLevel("player")
	if classicRank and classicRank < 0 then classicRank = 0 end
	local arenaCurrencyID = (not E.Retail and Constants.CurrencyConsts.CLASSIC_CONQUEST_CURRENCY_ID) or (E.Retail and 1602)
	local arg7 = ((not E.Classic and not E.Forever) and C_CurrencyInfo_GetCurrencyInfo(arenaCurrencyID).quantity) or classicRank

	dt.text:SetFormattedText('%s: %s%s|r %s: %s%s|r', arg2, E.media.hexvaluecolor, arg4, arg5, E.media.hexvaluecolor, arg7)
end
DT:RegisterDatatext(format('Eltruism Honor/%s Points', (E.Retail and 'Conquest') or (E.Classic and _G.RANK) or (E.Forever and _G.RANK) or 'Arena'), CURRENCY, {'CHAT_MSG_CURRENCY', 'CURRENCY_DISPLAY_UPDATE', 'PLAYER_PVP_KILLS_CHANGED'}, EltruismHonorDatatext, nil, nil, nil, nil, E.Retail and L["Eltruism Honor/Conquest Points"] or L["Eltruism Honor/Arena Points"])
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------honor datatext
local function EltruismLootMethod(dt)
	--these locales use different words for the method and for loot in general, so grab their method words
	local lootword = _G.LOOT
	if E.locale == "zhCN" then
		lootword = "分配方式"
	elseif E.locale == "zhTW" then
		lootword = "分配方式"
	elseif E.locale == "itIT" then
		lootword = "Predazione"
	end

	if IsInGroup() then
		local method = GetLootMethod()
		if not method then return end
		if method == "freeforall" then
			dt.text:SetFormattedText('%s %s%s|r', lootword, E.media.hexvaluecolor, gsub(_G.LOOT_FREE_FOR_ALL,lootword,""))
		elseif method == "roundrobin" then
			dt.text:SetFormattedText('%s %s%s|r', lootword, E.media.hexvaluecolor, gsub(_G.LOOT_ROUND_ROBIN,lootword,""))
		elseif method == "group" then
			dt.text:SetFormattedText('%s %s%s|r', lootword, E.media.hexvaluecolor, gsub(_G.LOOT_GROUP_LOOT,lootword,""))
		elseif method == "needbeforegreed" then
			dt.text:SetFormattedText('%s %s%s|r', lootword, E.media.hexvaluecolor, gsub(_G.LOOT_NEED_BEFORE_GREED,lootword,""))
		elseif method == "master" then
			dt.text:SetFormattedText('%s %s%s|r', lootword, E.media.hexvaluecolor, gsub(_G.	LOOT_MASTER_LOOTER,lootword,""))
		elseif method == "personalloot" then
			dt.text:SetFormattedText('%s %s%s|r', lootword, E.media.hexvaluecolor, gsub(_G.LOOT_PERSONAL_LOOT,lootword,""))
		end
	else
		dt.text:SetFormattedText('%s %s%s|r', lootword, E.media.hexvaluecolor, gsub(_G.LOOT_PERSONAL_LOOT,lootword,""))
	end
end
DT:RegisterDatatext('Eltruism Loot Method', nil, {'PARTY_LOOT_METHOD_CHANGED', 'GROUP_ROSTER_UPDATE', 'GROUP_JOINED'}, EltruismLootMethod, nil, nil, nil, nil, L["Eltruism Loot Method"])

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------retail secrets
--written by acidweb, ty, updated to add tooltips and better descriptions/updating
if E.Modern then
	local states = {
		[0] = {["state"] = 0, ["label"] = "Comb", ["name"] = "Combat"},
		[1] = {["state"] = 0, ["label"] = "Enc", ["name"] = "Encounter"},
		[2] = {["state"] = 0, ["label"] = "CM", ["name"] = "Challenge Mode"},
		[3] = {["state"] = 0, ["label"] = "PvP", ["name"] = "PvP Match"},
		[4] = {["state"] = 0, ["label"] = "Map", ["name"] = "Map"}
	}

	local function ParseState(state)
		if state["state"] == 2 then
			return "|cFFFF0000"..state["label"].."|r"
		elseif state["state"] == 1 then
			return "|cFFFFFF00"..state["label"].."|r"
		else
			return "|cFF00FF00"..state["label"].."|r"
		end
	end

	local GetAddOnRestrictionState = _G.C_RestrictedActions and _G.C_RestrictedActions.GetAddOnRestrictionState
	local C_Timer = _G.C_Timer

	local function UpdateSecretText(panel)
		local payload = ""
		for i = 0, 4 do
			payload = payload..(i == 0 and "" or " ")..ParseState(states[i])
		end
		panel.text:SetText(payload)
	end

	local function RefreshActivatingState(panel, restrictionType, attempt)
		if not GetAddOnRestrictionState then return end
		C_Timer.After(attempt == 1 and 0.05 or 0.5, function()
			if states[restrictionType]["state"] ~= 1 then return end
			local currentState = GetAddOnRestrictionState(restrictionType) or 0
			if currentState ~= 1 then
				states[restrictionType]["state"] = currentState
				UpdateSecretText(panel)
			elseif attempt < 3 then
				RefreshActivatingState(panel, restrictionType, attempt + 1)
			end
		end)
	end

	local function SecretOnEnter()
		DT.tooltip:ClearLines()
		DT.tooltip:AddLine("Addon Restrictions")
		DT.tooltip:AddLine(" ")
		for i = 0, 4 do
			local entry = states[i]
			if GetAddOnRestrictionState then
				entry["state"] = GetAddOnRestrictionState(i) or 0
			end
			local status
			if entry["state"] == 2 then
				status = "|cFFFF0000Active|r"
			elseif entry["state"] == 1 then
				status = "|cFFFFFF00Activating|r"
			else
				status = "|cFF00FF00Inactive|r"
			end
			DT.tooltip:AddDoubleLine(format("%s (%s):", entry["name"], entry["label"]), status, 1, 1, 1)
		end
		DT.tooltip:AddLine(" ")
		DT.tooltip:AddLine("|cFF00FF00Green|r: Unrestricted  |cFFFFFF00Yellow|r: Activating  |cFFFF0000Red|r: Restricted", 1, 1, 1)
		DT.tooltip:Show()
	end

	local function SecretOnEvent(self, event, restrictionType, restrictionState)
		if event == "ADDON_RESTRICTION_STATE_CHANGED" then
			if states[restrictionType] then
				states[restrictionType]["state"] = restrictionState
				if restrictionState == 1 then
					RefreshActivatingState(self, restrictionType, 1)
				end
			end
		elseif GetAddOnRestrictionState then
			for i = 0, 4 do
				states[i]["state"] = GetAddOnRestrictionState(i) or 0
			end
		end

		UpdateSecretText(self)
	end
	DT:RegisterDatatext("Secret Tracker", nil, {"ADDON_RESTRICTION_STATE_CHANGED"}, SecretOnEvent, nil, nil, SecretOnEnter,nil,"Secret State Tracker")
end
