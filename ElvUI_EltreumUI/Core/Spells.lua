local E = unpack(ElvUI)
local _G = _G
local select = _G.select
local tonumber = _G.tonumber
local type = _G.type
local strmatch = _G.string.match
local C_Spell = _G.C_Spell
local GetSpellInfo = C_Spell.GetSpellInfo
local GetShapeshiftFormInfo = _G.GetShapeshiftFormInfo
local GetOverrideSpell = C_Spell.GetOverrideSpell
local GetSpellBaseCooldown = C_Spell.GetSpellBaseCooldown or _G.GetSpellBaseCooldown
local GetSpellCooldown = C_Spell.GetSpellCooldown
local GetSpellCooldownDuration = C_Spell.GetSpellCooldownDuration
local GetSpellChargeDuration = C_Spell.GetSpellChargeDuration
local GetActionCooldownDuration = _G.C_ActionBar.GetActionCooldownDuration
local GetItemCooldown = _G.C_Container.GetItemCooldown
local C_Item = _G.C_Item
local GetItemInfo = C_Item.GetItemInfo
local GetItemInfoInstant = C_Item.GetItemInfoInstant
local GetItemSpell = C_Item.GetItemSpell
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

--resolve spell override safely
function ElvUI_EltreumUI:EltruismOverrideSpell(spellID)
	if GetOverrideSpell then
		local override = GetOverrideSpell(spellID)
		if override and E:NotSecretValue(override) and override ~= 0 then
			return override
		end
	end
	return spellID
end

function ElvUI_EltreumUI:EltruismSpellInfo(spellID)
	if not spellID or not E:NotSecretValue(spellID) then return end
	spellID = self:EltruismOverrideSpell(spellID)
	local spellData = GetSpellInfo(spellID)
	if spellData then
		local resolvedID = (spellData.spellID and E:NotSecretValue(spellData.spellID)) and spellData.spellID or spellID
		local resolvedName = (spellData.name and E:NotSecretValue(spellData.name)) and spellData.name or nil
		return resolvedName, resolvedID, spellData.iconID
	end
	return
end

--resolve item info (name, itemID, texture) from item ID, link, or name
function ElvUI_EltreumUI:EltruismItemInfo(item, needName)
	if not item or not E:NotSecretValue(item) then return end
	local itemID = tonumber(item)
	if not itemID and type(item) == "string" then
		itemID = tonumber(strmatch(item, "item:(%d+)"))
	end
	local instantID, _, _, _, instantTex = GetItemInfoInstant(itemID or item)
	itemID = itemID or instantID
	local texture = instantTex
	local name
	if needName or not itemID or not texture then
		local infoName, itemLink, _, _, _, _, _, _, _, infoTex = GetItemInfo(itemID or item)
		name = infoName
		if not itemID and type(itemLink) == "string" then
			itemID = tonumber(strmatch(itemLink, "item:(%d+)"))
		end
		texture = texture or infoTex
	end
	return name, itemID, texture
end

--resolve base cooldown in seconds
function ElvUI_EltreumUI:EltruismSpellBaseCooldown(spellID)
	if not spellID or not E:NotSecretValue(spellID) then return 0 end
	local baseMS = GetSpellBaseCooldown(spellID)
	if baseMS and E:NotSecretValue(baseMS) and baseMS > 0 then
		return baseMS / 1000
	end
	return 0
end

--find pet action bar slot matching spell name
function ElvUI_EltreumUI:EltruismPetActionIndex(name)
	if not name or not E:NotSecretValue(name) then return nil end
	for i = 1, _G.NUM_PET_ACTION_SLOTS do
		local petName, _, _, isToken = GetPetActionInfo(i)
		if petName and E:NotSecretValue(petName) then
			if isToken then
				petName = _G[petName]
			end
			if petName == name then
				return i
			end
		end
	end
	return nil
end

--resolve spell cooldown safely across secret and non-secret values
--returns state ("READY", "GCD", "DISABLED", "EXACT", "SECRET"), start, duration, durationObj
function ElvUI_EltreumUI:EltruismSpellCooldown(spellID, actionSlot, minDuration, wantDurationObj, skipOverride)
	if not spellID or not E:NotSecretValue(spellID) then
		return "READY", 0, 0, nil
	end
	if not skipOverride then
		spellID = self:EltruismOverrideSpell(spellID)
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
		return self:EltruismSpellCooldown(itemSpellID, actionSlot, minimumDuration, wantDurationObj, true)
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
		return self:EltruismSpellCooldown(petSpellID, actionSlot, minimumDuration, wantDurationObj)
	end
	return "READY", 0, 0, nil
end

--dispatch cooldown lookup by type
function ElvUI_EltreumUI:EltruismCooldownQuery(cooldownType, id, petSpellID, actionSlot, minDuration, wantDurationObj, skipOverride)
	if not id then return "READY", 0, 0, nil end
	if cooldownType == "spell" then
		return self:EltruismSpellCooldown(id, actionSlot, minDuration, wantDurationObj, skipOverride)
	elseif cooldownType == "item" then
		return self:EltruismItemCooldown(id, actionSlot, minDuration, wantDurationObj)
	elseif cooldownType == "pet" then
		return self:EltruismPetCooldown(id, petSpellID, actionSlot, minDuration, wantDurationObj)
	end
	return "READY", 0, 0, nil
end
