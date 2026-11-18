local E = unpack(ElvUI)
local _G = _G
local select = _G.select
local type = _G.type
local C_Spell = _G.C_Spell
local LegacyGetSpellInfo = _G.GetSpellInfo
local C_Spell_GetSpellInfo = C_Spell and C_Spell.GetSpellInfo
local GetSpellInfo = C_Spell_GetSpellInfo or LegacyGetSpellInfo
local GetShapeshiftFormInfo = _G.GetShapeshiftFormInfo
local GetOverrideSpell = C_Spell and C_Spell.GetOverrideSpell
local C_Spell_GetSpellCooldown = C_Spell and C_Spell.GetSpellCooldown
local LegacyGetSpellCooldown = _G.GetSpellCooldown
local GetSpellCooldownDuration = C_Spell and C_Spell.GetSpellCooldownDuration
local GetSpellChargeDuration = C_Spell and C_Spell.GetSpellChargeDuration
local C_ActionBar = _G.C_ActionBar
local GetActionCooldownDuration = C_ActionBar and C_ActionBar.GetActionCooldownDuration
local C_Container = _G.C_Container
local C_Item = _G.C_Item
local GetItemCooldownAPI = (C_Container and C_Container.GetItemCooldown) or (C_Item and C_Item.GetItemCooldown) or _G.GetItemCooldown
local GetItemSpellAPI = C_Item and C_Item.GetItemSpell or _G.GetItemSpell
local GetPetActionCooldownAPI = _G.GetPetActionCooldown
local GetPetActionInfoAPI = _G.GetPetActionInfo

function ElvUI_EltreumUI:SpellInfoShapeshift(spellID,ShapeshiftFormID)
	if ShapeshiftFormID then
		if GetShapeshiftFormInfo(1) then
			spellID = select(4,GetShapeshiftFormInfo(ShapeshiftFormID))
			if spellID then
				local spellData = GetSpellInfo(spellID)
				if spellData.name then
					return spellData.name
				else
					return ""
				end
			else
				return ""
			end
		else
			return ""
		end
	elseif spellID then
		local spellData = GetSpellInfo(spellID)
		return spellData.name
	end
end

function ElvUI_EltreumUI:EltruismSpellInfo(spellID)
	if not spellID then return end
	if GetOverrideSpell then
		local override = GetOverrideSpell(spellID)
		if override and override ~= 0 then
			spellID = override
		end
	end
	if C_Spell_GetSpellInfo then
		local spellData = C_Spell_GetSpellInfo(spellID)
		if spellData then
			if type(spellData) == "table" then
				return spellData.name, spellData.spellID, spellData.iconID
			else
				return "UNKNOWN", 187874, 136244--fallback value
			end
		end
		return
	end
	if type(LegacyGetSpellInfo) == "function" then
		local name, _, icon = LegacyGetSpellInfo(spellID)
		if type(name) == "table" then
			return name.name, name.spellID, name.iconID
		elseif type(name) == "string" then
			return name, spellID, icon
		end
	end
	return
end

--resolve spell cooldown safely across secret and non-secret values
--returns state ("READY", "GCD", "DISABLED", "EXACT", "SECRET"), start, duration, durationObj
function ElvUI_EltreumUI:EltruismSpellCooldown(spellID, actionSlot, minDuration, wantDurationObj, skipOverride)
	if not spellID or not E:NotSecretValue(spellID) then
		return "READY", 0, 0, nil
	end
	if not skipOverride and GetOverrideSpell then
		local override = GetOverrideSpell(spellID)
		if override and E:NotSecretValue(override) and override ~= 0 then
			spellID = override
		end
	end
	local minimumDuration = minDuration or 0
	if C_Spell_GetSpellCooldown then
		local info = C_Spell_GetSpellCooldown(spellID)
		if type(info) == "table" then
			if E:NotSecretValue(info.isEnabled) and (info.isEnabled == false or info.isEnabled == 0) then
				return "DISABLED", 0, 0, nil
			end
			if E:NotSecretValue(info.startTime) and E:NotSecretValue(info.duration) then
				if E:NotSecretValue(info.isOnGCD) and info.isOnGCD then
					return "GCD", 0, 0, nil
				end
				if not info.startTime or info.startTime == 0 or not info.duration or info.duration <= minimumDuration then
					return "READY", 0, 0, nil
				end
				return "EXACT", info.startTime, info.duration, nil
			end
			--secret numbers in combat/instances, read NeverSecret flags and optional DurationObject
			if E:NotSecretValue(info.isOnGCD) and info.isOnGCD then
				return "GCD", nil, nil, nil
			end
			if E:NotSecretValue(info.isActive) and info.isActive then
				local durationObj
				if wantDurationObj then
					durationObj = GetSpellCooldownDuration and GetSpellCooldownDuration(spellID)
					if not durationObj and GetSpellChargeDuration then
						durationObj = GetSpellChargeDuration(spellID)
					end
					if not durationObj and actionSlot and GetActionCooldownDuration then
						durationObj = GetActionCooldownDuration(actionSlot)
					end
				end
				return "SECRET", nil, nil, durationObj
			end
			return "READY", 0, 0, nil
		end
		return "READY", 0, 0, nil
	end
	if type(LegacyGetSpellCooldown) == "function" then
		local start, duration, enabled = LegacyGetSpellCooldown(spellID)
		if type(start) == "table" then
			local cooldownInfo = start
			if E:NotSecretValue(cooldownInfo.isEnabled) and (cooldownInfo.isEnabled == false or cooldownInfo.isEnabled == 0) then
				return "DISABLED", 0, 0, nil
			end
			if E:NotSecretValue(cooldownInfo.startTime) and E:NotSecretValue(cooldownInfo.duration) then
				if not cooldownInfo.startTime or cooldownInfo.startTime == 0 or not cooldownInfo.duration or cooldownInfo.duration <= minimumDuration then
					return "READY", 0, 0, nil
				end
				return "EXACT", cooldownInfo.startTime, cooldownInfo.duration, nil
			end
			if E:NotSecretValue(cooldownInfo.isOnGCD) and cooldownInfo.isOnGCD then
				return "GCD", nil, nil, nil
			end
			if E:NotSecretValue(cooldownInfo.isActive) and cooldownInfo.isActive then
				local durationObj = wantDurationObj and GetSpellCooldownDuration and GetSpellCooldownDuration(spellID)
				return "SECRET", nil, nil, durationObj
			end
			return "READY", 0, 0, nil
		elseif start and duration and E:NotSecretValue(start) and E:NotSecretValue(duration) then
			local isEnabled = (not E:NotSecretValue(enabled) or enabled == 1 or enabled == true) and 1 or 0
			if isEnabled == 0 then
				return "DISABLED", 0, 0, nil
			end
			if start == 0 or duration <= minimumDuration then
				return "READY", 0, 0, nil
			end
			return "EXACT", start, duration, nil
		end
	end
	return "READY", 0, 0, nil
end

--resolve item cooldown safely, falling back to item spell when item cooldown is secret
function ElvUI_EltreumUI:EltruismItemCooldown(itemID, actionSlot, minDuration, wantDurationObj)
	if not itemID or not E:NotSecretValue(itemID) then
		return "READY", 0, 0, nil
	end
	local minimumDuration = minDuration or 0
	if type(GetItemCooldownAPI) == "function" then
		local start, duration, enabled = GetItemCooldownAPI(itemID)
		if start and duration and E:NotSecretValue(start) and E:NotSecretValue(duration) then
			local isEnabled = (not E:NotSecretValue(enabled) or enabled == 1 or enabled == true) and 1 or 0
			if isEnabled == 0 then
				return "DISABLED", 0, 0, nil
			end
			if start == 0 or duration <= minimumDuration then
				return "READY", 0, 0, nil
			end
			return "EXACT", start, duration, nil
		end
	end
	if GetItemSpellAPI then
		local _, itemSpellID = GetItemSpellAPI(itemID)
		if itemSpellID and E:NotSecretValue(itemSpellID) then
			return ElvUI_EltreumUI:EltruismSpellCooldown(itemSpellID, actionSlot, minimumDuration, wantDurationObj, true)
		end
	end
	return "READY", 0, 0, nil
end

--resolve pet action cooldown safely, falling back to pet spell when pet cooldown is secret
function ElvUI_EltreumUI:EltruismPetCooldown(index, spellID, actionSlot, minDuration, wantDurationObj)
	local minimumDuration = minDuration or 0
	if index and type(GetPetActionCooldownAPI) == "function" then
		local start, duration, enabled = GetPetActionCooldownAPI(index)
		if start and duration and E:NotSecretValue(start) and E:NotSecretValue(duration) then
			local isEnabled = (not E:NotSecretValue(enabled) or enabled == 1 or enabled == true) and 1 or 0
			if isEnabled == 0 then
				return "DISABLED", 0, 0, nil
			end
			if start == 0 or duration <= minimumDuration then
				return "READY", 0, 0, nil
			end
			return "EXACT", start, duration, nil
		end
	end
	local petSpellID = spellID
	if not petSpellID and index and GetPetActionInfoAPI then
		petSpellID = select(7, GetPetActionInfoAPI(index))
	end
	if petSpellID and E:NotSecretValue(petSpellID) then
		return ElvUI_EltreumUI:EltruismSpellCooldown(petSpellID, actionSlot, minimumDuration, wantDurationObj)
	end
	return "READY", 0, 0, nil
end
