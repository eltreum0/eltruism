local E = unpack(ElvUI)
local _G = _G
local select = _G.select
local C_Spell = _G.C_Spell
local GetSpellInfo = C_Spell.GetSpellInfo
local GetShapeshiftFormInfo = _G.GetShapeshiftFormInfo
local GetOverrideSpell = C_Spell.GetOverrideSpell
local GetSpellCooldown = C_Spell.GetSpellCooldown
local GetSpellCooldownDuration = C_Spell.GetSpellCooldownDuration
local GetSpellChargeDuration = C_Spell.GetSpellChargeDuration
local GetActionCooldownDuration = _G.C_ActionBar.GetActionCooldownDuration
local GetItemCooldown = _G.C_Container.GetItemCooldown
local GetItemSpell = _G.C_Item.GetItemSpell
local GetPetActionCooldown = _G.GetPetActionCooldown
local GetPetActionInfo = _G.GetPetActionInfo

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
	if not spellID or not E:NotSecretValue(spellID) then return end
	if GetOverrideSpell then
		local override = GetOverrideSpell(spellID)
		if override and E:NotSecretValue(override) and override ~= 0 then
			spellID = override
		end
	end
	local spellData = GetSpellInfo(spellID)
	if spellData then
		local resolvedID = (spellData.spellID and E:NotSecretValue(spellData.spellID)) and spellData.spellID or spellID
		local resolvedName = (spellData.name and E:NotSecretValue(spellData.name)) and spellData.name or nil
		return resolvedName, resolvedID, spellData.iconID
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
	local info = GetSpellCooldown(spellID)
	if info then
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
				durationObj = GetSpellCooldownDuration(spellID)
				if not durationObj then
					durationObj = GetSpellChargeDuration(spellID)
				end
				if not durationObj and actionSlot then
					durationObj = GetActionCooldownDuration(actionSlot)
				end
			end
			return "SECRET", nil, nil, durationObj
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
	local start, duration, enabled = GetItemCooldown(itemID)
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
	local _, itemSpellID = GetItemSpell(itemID)
	if itemSpellID and E:NotSecretValue(itemSpellID) then
		return ElvUI_EltreumUI:EltruismSpellCooldown(itemSpellID, actionSlot, minimumDuration, wantDurationObj, true)
	end
	return "READY", 0, 0, nil
end

--resolve pet action cooldown safely, falling back to pet spell when pet cooldown is secret
function ElvUI_EltreumUI:EltruismPetCooldown(index, spellID, actionSlot, minDuration, wantDurationObj)
	local minimumDuration = minDuration or 0
	if index then
		local start, duration, enabled = GetPetActionCooldown(index)
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
	if not petSpellID and index then
		petSpellID = select(7, GetPetActionInfo(index))
	end
	if petSpellID and E:NotSecretValue(petSpellID) then
		return ElvUI_EltreumUI:EltruismSpellCooldown(petSpellID, actionSlot, minimumDuration, wantDurationObj)
	end
	return "READY", 0, 0, nil
end
