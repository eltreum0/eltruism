local E, L, _, P = unpack(ElvUI)
local _G = _G
local pairs = _G.pairs

--apply textured icon on profile import, ty Repooc
local function doApplyToAll(db, dbEntry, dbValue)
	if not db then return end
	for _, spell in pairs(db) do
		if dbValue ~= nil then
			spell[dbEntry] = dbValue
		else
			return spell[dbEntry]
		end
	end
end

local function BuffIndicator_ApplyToAll(dbEntry, dbValue, profile, pet)
	if profile then
		return doApplyToAll(E.db.unitframe.filters.aurawatch, dbEntry, dbValue)
	elseif pet then
		return doApplyToAll(E.global.unitframe.aurawatch.PET, dbEntry, dbValue)
	else
		return doApplyToAll(E.global.unitframe.aurawatch[E.myclass], dbEntry, dbValue)
	end
end

function ElvUI_EltreumUI:AuraFiltersUpdate()
	BuffIndicator_ApplyToAll('style', 'texturedIcon', E.db.unitframe.units['party'].buffIndicator.profileSpecific, false)
	BuffIndicator_ApplyToAll('style', 'texturedIcon', E.db.unitframe.units['raid1'].buffIndicator.profileSpecific, false)
	BuffIndicator_ApplyToAll('style', 'texturedIcon', E.db.unitframe.units['raid2'].buffIndicator.profileSpecific, false)
	BuffIndicator_ApplyToAll('style', 'texturedIcon', E.db.unitframe.units['raid3'].buffIndicator.profileSpecific, false)
	BuffIndicator_ApplyToAll('style', 'texturedIcon', E.db.unitframe.units['raidpet'].buffIndicator.profileSpecific, true)
	BuffIndicator_ApplyToAll('style', 'texturedIcon', E.db.unitframe.units['tank'].buffIndicator.profileSpecific, false)
	BuffIndicator_ApplyToAll('style', 'texturedIcon', E.db.unitframe.units['assist'].buffIndicator.profileSpecific, false)
	BuffIndicator_ApplyToAll('style', 'texturedIcon', E.db.unitframe.units['boss'].buffIndicator.profileSpecific, false)
	BuffIndicator_ApplyToAll('style', 'texturedIcon', E.db.unitframe.units['player'].buffIndicator.profileSpecific, false)
	BuffIndicator_ApplyToAll('style', 'texturedIcon', E.db.unitframe.units['target'].buffIndicator.profileSpecific, false)
	BuffIndicator_ApplyToAll('style', 'texturedIcon', E.db.unitframe.units['focus'].buffIndicator.profileSpecific, false)
	BuffIndicator_ApplyToAll('style', 'texturedIcon', nil, false) --class
	BuffIndicator_ApplyToAll('style', 'texturedIcon', nil, true) --pet
end

--Eltruism/Default ElvUI filters

--Unitframes
local EltruismTargetBuffs = "Blacklist,Dispellable,blockNoDuration,PlayerBuffs,NonPersonal,RaidBuffsElvUI,TurtleBuffs"
local EltruismTargetDebuffs = "Blacklist,Personal,CCDebuffs"
local EltruismPlayerDebuffs = "Blacklist,blockNoDuration,Personal,NonPersonal"
local EltruismPlayerBuffs = "Blacklist,Personal,NonPersonal"
local EltruismBossBuffs = "Blacklist,Dispellable,RaidBuffsElvUI,TurtleBuffs"
local EltruismBossDebuffs = "Blacklist,CCDebuffs,RaidDebuffs"
local EltruismFocusBuffs = "Blacklist,Dispellable,RaidBuffsElvUI,TurtleBuffs"
local EltruismFocusDebuffs = "Blacklist,Personal,CCDebuffs"
local EltruismArenaBuffs = "Blacklist,Whitelist,Dispellable,TurtleBuffs"
local EltruismArenaDebuffs = "Blacklist,Personal,CCDebuffs"
local EltruismGroupBuffs = 'Blacklist,TurtleBuffs'
local EltruismGroupDebuffs = 'Blacklist,Boss,RaidDebuffs,CCDebuffs,Dispellable,Whitelist'

local EltruismAuraTarget = 'Blacklist,blockNoDuration,Personal,Boss,RaidDebuffs,PlayerBuffs,RaidBuffsElvUI,TurtleBuffs'
local EltruismAuraPlayer = 'Blacklist,blockNoDuration,Personal,Boss,RaidDebuffs,PlayerBuffs'

--nameplates
local EltruismNameplateEnemyPlayerBuffs = "Blacklist,Dispellable,PlayerBuffs,TurtleBuffs"
local EltruismNameplateEnemyPlayerDebuffs = "Blacklist,Personal,Boss,CCDebuffs,RaidDebuffs,NonPersonal"
local EltruismNameplateEnemyNPCBuffs = "Blacklist,RaidBuffsElvUI,Dispellable,blockNoDuration,CastByUnit"
local EltruismNameplateEnemyNPCDebuffs = "Blacklist,Personal,CCDebuffs,CastByNPC"

--All filter mainly for cata/classic
local EltruismEverything = "Blacklist,Personal,NonPersonal"

--based on luckyone
local minimalBuffs = 'Blacklist,Whitelist,Dispellable,RaidBuffsElvUI'
local minimalDebuffs = 'Blacklist,Whitelist,Personal,CCDebuffs'
local minimalAura = 'Blacklist,blockNoDuration,Personal,RaidDebuffs'

--modern filters
local EltruismModernEverythingBuffs = "HELPFUL"
local EltruismModernEverythingDebuffs = "HARMFUL"
local EltruismModernEverythingEnemyDebuffs = "HARMFUL||INCLUDE_NAME_PLATE_ONLY"
local EltruismModernDebuff = "HARMFUL||PLAYER||INCLUDE_NAME_PLATE_ONLY||!CROWD_CONTROL"
local EltruismModernCC = "HARMFUL||CROWD_CONTROL"

--reset a single filter group to clean defaults
local function ResetFilterGroup(group, defaultFilter)
	for key, value in pairs(E.AuraDefaults) do
		group[key] = value
	end
	group.filter = defaultFilter
	for candidate, value in pairs(E.AuraCandidates) do
		group.candidates[candidate] = value
	end
end

--reset all filter groups in a filter list
local function ResetFilterLists(filterLists, defaultFilter)
	for index = 1, E.filterMax do
		ResetFilterGroup(filterLists['group'..index], defaultFilter)
	end
end

--copy elvui default filter lists
local function CopyFilterLists(filterLists, defaultFilterLists)
	for index = 1, E.filterMax do
		local key = 'group'..index
		local targetGroup = filterLists[key]
		local sourceGroup = defaultFilterLists[key]
		for option in pairs(E.AuraDefaults) do
			targetGroup[option] = sourceGroup[option]
		end
		for candidate in pairs(E.AuraCandidates) do
			targetGroup.candidates[candidate] = sourceGroup.candidates[candidate]
		end
	end
end

--reset a single aura table back to elvui defaults
local function ResetAuraType(dbAura, defaultAura, resetEnable)
	if not dbAura or not defaultAura then return end
	if resetEnable then
		dbAura.enable = defaultAura.enable
	end
	dbAura.priority = defaultAura.priority
	CopyFilterLists(dbAura.filterLists, defaultAura.filterLists)
end

--reset a single aurabar table back to elvui defaults
local function ResetAuraBar(dbAuraBar, defaultAuraBar)
	if not dbAuraBar or not defaultAuraBar then return end
	dbAuraBar.priority = defaultAuraBar.priority
	CopyFilterLists(dbAuraBar.friendlyFilter.filterLists, defaultAuraBar.friendlyFilter.filterLists)
	CopyFilterLists(dbAuraBar.enemyFilter.filterLists, defaultAuraBar.enemyFilter.filterLists)
end

--reset all unitframe and nameplate aura filters to elvui defaults
local function ResetAllElvUIFilters()
	for unitName, content in pairs(E.db["unitframe"]["units"]) do
		local default = P.unitframe.units[unitName]
		if default then
			ResetAuraType(content.buffs, default.buffs)
			ResetAuraType(content.debuffs, default.debuffs)
			ResetAuraType(content.auras, default.auras, true)
			ResetAuraBar(content.aurabar, default.aurabar)
		end
	end
	for unitType, content in pairs(E.db["nameplates"]["units"]) do
		local default = P.nameplates.units[unitType]
		if default then
			ResetAuraType(content.buffs, default.buffs)
			ResetAuraType(content.debuffs, default.debuffs)
			ResetAuraType(content.auras, default.auras, true)
		end
	end
end

local nameplateUnits = { 'ENEMY_PLAYER', 'ENEMY_NPC', 'FRIENDLY_PLAYER', 'FRIENDLY_NPC', 'PLAYER' }
local raidUnits = { 'raid1', 'raid2', 'raid3' }

--apply modern filter groups
local function ApplyFilterGroups(filterLists, groups, defaultFilter)
	ResetFilterLists(filterLists, defaultFilter)
	for index, data in pairs(groups) do
		local group = filterLists['group'..index]
		group.enable = true
		group.filter = data.filter
		group.maxDuration = data.maxDuration or 0
		group.useAllowlist = data.useAllowlist or false
		group.useBlocklist = data.useBlocklist or false
		if data.candidates then
			for candidate, value in pairs(data.candidates) do
				group.candidates[candidate] = value
			end
		end
	end
end

--modern filter presets
local EltruismModernEverythingBuffGroups = {
	{ filter = EltruismModernEverythingBuffs, useBlocklist = true },
}

local EltruismModernEverythingDebuffGroups = {
	{ filter = EltruismModernEverythingDebuffs, useBlocklist = true },
}

local EltruismModernEverythingEnemyDebuffGroups = {
	{ filter = EltruismModernEverythingEnemyDebuffs, useBlocklist = true },
}

local EltruismModernPlayerBuffs = {
	{ filter = 'HELPFUL||EXTERNAL_DEFENSIVE' },
	{ filter = 'HELPFUL||BIG_DEFENSIVE||PLAYER||!EXTERNAL_DEFENSIVE' },
	{ filter = 'HELPFUL||RAID_IN_COMBAT||PLAYER||!BIG_DEFENSIVE||!EXTERNAL_DEFENSIVE', useBlocklist = true },
}

local minimalModernTargetBossBuffs = {
	{ filter = 'HELPFUL', candidates = { isBossOrRoleAura = true }, useBlocklist = true },
	{ filter = 'HELPFUL||!IMPORTANT', candidates = { isStealable = true, isBossOrRoleAura = 1 }, useBlocklist = true },
	{ filter = 'HELPFUL||IMPORTANT', candidates = { isBossOrRoleAura = 1 }, useBlocklist = true },
}

local minimalModernFocusBuffs = {
	{ filter = 'HELPFUL||!BIG_DEFENSIVE||!EXTERNAL_DEFENSIVE', candidates = { isBossOrRoleAura = true } },
	{ filter = 'HELPFUL||!IMPORTANT||!BIG_DEFENSIVE||!EXTERNAL_DEFENSIVE', candidates = { isStealable = true, isBossOrRoleAura = 1 }, useBlocklist = true },
	{ filter = 'HELPFUL||IMPORTANT||!BIG_DEFENSIVE||!EXTERNAL_DEFENSIVE', candidates = { isBossOrRoleAura = 1 } },
	{ filter = 'HELPFUL||BIG_DEFENSIVE||!EXTERNAL_DEFENSIVE' },
	{ filter = 'HELPFUL||EXTERNAL_DEFENSIVE' },
}

local minimalModernNameplatePlayerBuffs = {
	{ filter = 'HELPFUL||BIG_DEFENSIVE' },
	{ filter = 'HELPFUL||RAID_PLAYER_DISPELLABLE||!BIG_DEFENSIVE' },
	{ filter = 'HELPFUL||!BIG_DEFENSIVE||!RAID_PLAYER_DISPELLABLE', candidates = { isStealable = true }, useBlocklist = true },
}

local minimalModernNameplateNPCBuffs = {
	{ filter = 'HELPFUL||!IMPORTANT', candidates = { isStealable = true }, useBlocklist = true },
	{ filter = 'HELPFUL||IMPORTANT', useBlocklist = true },
}

local EltruismModernNameplateNPCBuffs = {
	{ filter = 'HELPFUL', candidates = { isBossOrRoleAura = true } },
	{ filter = 'HELPFUL||!IMPORTANT', candidates = { isStealable = true, isBossOrRoleAura = 1 }, useBlocklist = true },
	{ filter = 'HELPFUL||IMPORTANT', candidates = { isBossOrRoleAura = 1 } },
	{ filter = 'HELPFUL||!IMPORTANT', maxDuration = 300, candidates = { isBossOrRoleAura = 1, isStealable = 1 }, useBlocklist = true },
}

local EltruismModernGroupBuffs = {
	{ filter = 'HELPFUL||BIG_DEFENSIVE||!EXTERNAL_DEFENSIVE' },
	{ filter = 'HELPFUL||EXTERNAL_DEFENSIVE' },
	{ filter = 'HELPFUL||RAID_IN_COMBAT||PLAYER||!BIG_DEFENSIVE||!EXTERNAL_DEFENSIVE', useBlocklist = true },
}

local minimalModernPlayerDebuffs = {
	{ filter = 'HARMFUL||RAID||!CROWD_CONTROL', useBlocklist = true },
	{ filter = EltruismModernCC, useBlocklist = true },
	{ filter = 'HARMFUL||IMPORTANT||!RAID||!CROWD_CONTROL', useBlocklist = true },
	{ filter = 'HARMFUL||DISPELLABLE||!RAID||!IMPORTANT||!CROWD_CONTROL', useBlocklist = true },
}

local EltruismModernEnemyDebuffs = {
	{ filter = EltruismModernDebuff, maxDuration = 300, useBlocklist = true },
	{ filter = EltruismModernCC, maxDuration = 300, useBlocklist = true },
}

local minimalModernEnemyDebuffs = {
	{ filter = EltruismModernDebuff, candidates = { nameplateShowPersonal = true }, useBlocklist = true },
	{ filter = EltruismModernCC, useBlocklist = true },
}

local minimalModernGroupDebuffs = {
	{ filter = 'HARMFUL||RAID||!CROWD_CONTROL', useBlocklist = true },
	{ filter = EltruismModernCC, useBlocklist = true },
	{ filter = 'HARMFUL||RAID_PLAYER_DISPELLABLE||!RAID||!CROWD_CONTROL', useBlocklist = true },
}

local EltruismModernAuraBarPlayerFriendly = {
	{ filter = 'HELPFUL', maxDuration = 300, useBlocklist = true },
}

local EltruismModernAuraBarPlayerEnemy = {
	{ filter = 'HARMFUL||PLAYER', maxDuration = 300, useBlocklist = true },
}

local EltruismModernAuraBarTargetFriendly = {
	{ filter = 'HELPFUL||PLAYER', maxDuration = 300, useBlocklist = true },
}

local minimalModernAuraBarPlayerFriendly = {
	{ filter = 'HELPFUL||PLAYER', maxDuration = 300, useBlocklist = true },
}

local minimalModernAuraBarTargetEnemy = {
	{ filter = EltruismModernDebuff, maxDuration = 300, candidates = { nameplateShowPersonal = true }, useBlocklist = true },
	{ filter = EltruismModernCC, maxDuration = 300, useBlocklist = true },
}

--aurabar filters
local function ApplyAuraBarFilters(filterType)
	if filterType == 'Everything' then
		E.db["unitframe"]["units"]["target"]["aurabar"]["priority"] = EltruismEverything
		E.db["unitframe"]["units"]["player"]["aurabar"]["priority"] = EltruismEverything
		ApplyFilterGroups(E.db["unitframe"]["units"]["player"]["aurabar"]["friendlyFilter"]["filterLists"], EltruismModernEverythingBuffGroups, 'HELPFUL')
		ApplyFilterGroups(E.db["unitframe"]["units"]["player"]["aurabar"]["enemyFilter"]["filterLists"], EltruismModernEverythingDebuffGroups, 'HARMFUL')
		ApplyFilterGroups(E.db["unitframe"]["units"]["target"]["aurabar"]["friendlyFilter"]["filterLists"], EltruismModernEverythingBuffGroups, 'HELPFUL')
		ApplyFilterGroups(E.db["unitframe"]["units"]["target"]["aurabar"]["enemyFilter"]["filterLists"], EltruismModernEverythingEnemyDebuffGroups, 'HARMFUL')
	elseif filterType == 'Eltruism' then
		E.db["unitframe"]["units"]["target"]["aurabar"]["priority"] = EltruismAuraTarget
		E.db["unitframe"]["units"]["player"]["aurabar"]["priority"] = EltruismAuraPlayer
		ApplyFilterGroups(E.db["unitframe"]["units"]["player"]["aurabar"]["friendlyFilter"]["filterLists"], EltruismModernAuraBarPlayerFriendly, 'HELPFUL')
		ApplyFilterGroups(E.db["unitframe"]["units"]["player"]["aurabar"]["enemyFilter"]["filterLists"], EltruismModernAuraBarPlayerEnemy, 'HARMFUL')
		ApplyFilterGroups(E.db["unitframe"]["units"]["target"]["aurabar"]["friendlyFilter"]["filterLists"], EltruismModernAuraBarTargetFriendly, 'HELPFUL')
		ApplyFilterGroups(E.db["unitframe"]["units"]["target"]["aurabar"]["enemyFilter"]["filterLists"], EltruismModernEnemyDebuffs, 'HARMFUL')
	elseif filterType == 'Minimal' then
		E.db["unitframe"]["units"]["target"]["aurabar"]["priority"] = minimalAura
		E.db["unitframe"]["units"]["player"]["aurabar"]["priority"] = minimalAura
		ApplyFilterGroups(E.db["unitframe"]["units"]["player"]["aurabar"]["friendlyFilter"]["filterLists"], minimalModernAuraBarPlayerFriendly, 'HELPFUL')
		ApplyFilterGroups(E.db["unitframe"]["units"]["player"]["aurabar"]["enemyFilter"]["filterLists"], EltruismModernAuraBarPlayerEnemy, 'HARMFUL')
		ApplyFilterGroups(E.db["unitframe"]["units"]["target"]["aurabar"]["friendlyFilter"]["filterLists"], EltruismModernAuraBarTargetFriendly, 'HELPFUL')
		ApplyFilterGroups(E.db["unitframe"]["units"]["target"]["aurabar"]["enemyFilter"]["filterLists"], minimalModernAuraBarTargetEnemy, 'HARMFUL')
	elseif filterType == 'ElvUI' then
		ResetAuraBar(E.db["unitframe"]["units"]["player"]["aurabar"], P.unitframe.units.player.aurabar)
		ResetAuraBar(E.db["unitframe"]["units"]["target"]["aurabar"], P.unitframe.units.target.aurabar)
	end
end

--buff filters
local function ApplyBuffFilters(frame, filterType)
	if frame == 'player' then
		if filterType == 'Everything' then
			E.db["unitframe"]["units"]["player"]["buffs"]["priority"] = EltruismEverything
			ApplyFilterGroups(E.db["unitframe"]["units"]["player"]["buffs"]["filterLists"], EltruismModernEverythingBuffGroups, 'HELPFUL')
		elseif filterType == 'Eltruism' then
			E.db["unitframe"]["units"]["player"]["buffs"]["priority"] = EltruismPlayerBuffs
			ApplyFilterGroups(E.db["unitframe"]["units"]["player"]["buffs"]["filterLists"], EltruismModernPlayerBuffs, 'HELPFUL')
		elseif filterType == 'Minimal' then
			E.db["unitframe"]["units"]["player"]["buffs"]["priority"] = minimalBuffs
			CopyFilterLists(E.db["unitframe"]["units"]["player"]["buffs"]["filterLists"], P.unitframe.units.player.buffs.filterLists)
		elseif filterType == 'ElvUI' then
			ResetAuraType(E.db["unitframe"]["units"]["player"]["buffs"], P.unitframe.units.player.buffs)
		end
	elseif frame == 'target' then
		if filterType == 'Everything' then
			E.db["unitframe"]["units"]["target"]["buffs"]["priority"] = EltruismEverything
			ApplyFilterGroups(E.db["unitframe"]["units"]["target"]["buffs"]["filterLists"], EltruismModernEverythingBuffGroups, 'HELPFUL')
		elseif filterType == 'Eltruism' then
			E.db["unitframe"]["units"]["target"]["buffs"]["priority"] = EltruismTargetBuffs
			CopyFilterLists(E.db["unitframe"]["units"]["target"]["buffs"]["filterLists"], P.unitframe.units.target.buffs.filterLists)
		elseif filterType == 'Minimal' then
			E.db["unitframe"]["units"]["target"]["buffs"]["priority"] = minimalBuffs
			ApplyFilterGroups(E.db["unitframe"]["units"]["target"]["buffs"]["filterLists"], minimalModernTargetBossBuffs, 'HELPFUL')
		elseif filterType == 'ElvUI' then
			ResetAuraType(E.db["unitframe"]["units"]["target"]["buffs"], P.unitframe.units.target.buffs)
		end
	elseif frame == 'focus' then
		if filterType == 'Everything' then
			E.db["unitframe"]["units"]["focus"]["buffs"]["priority"] = EltruismEverything
			ApplyFilterGroups(E.db["unitframe"]["units"]["focus"]["buffs"]["filterLists"], EltruismModernEverythingBuffGroups, 'HELPFUL')
		elseif filterType == 'Eltruism' then
			E.db["unitframe"]["units"]["focus"]["buffs"]["priority"] = EltruismFocusBuffs
			CopyFilterLists(E.db["unitframe"]["units"]["focus"]["buffs"]["filterLists"], P.unitframe.units.focus.buffs.filterLists)
		elseif filterType == 'Minimal' then
			E.db["unitframe"]["units"]["focus"]["buffs"]["priority"] = minimalBuffs
			ApplyFilterGroups(E.db["unitframe"]["units"]["focus"]["buffs"]["filterLists"], minimalModernFocusBuffs, 'HELPFUL')
		elseif filterType == 'ElvUI' then
			ResetAuraType(E.db["unitframe"]["units"]["focus"]["buffs"], P.unitframe.units.focus.buffs)
		end
	elseif frame == 'boss' then
		if filterType == 'Everything' then
			E.db["unitframe"]["units"]["boss"]["buffs"]["priority"] = EltruismEverything
			ApplyFilterGroups(E.db["unitframe"]["units"]["boss"]["buffs"]["filterLists"], EltruismModernEverythingBuffGroups, 'HELPFUL')
		elseif filterType == 'Eltruism' then
			E.db["unitframe"]["units"]["boss"]["buffs"]["priority"] = EltruismBossBuffs
			CopyFilterLists(E.db["unitframe"]["units"]["boss"]["buffs"]["filterLists"], P.unitframe.units.boss.buffs.filterLists)
		elseif filterType == 'Minimal' then
			E.db["unitframe"]["units"]["boss"]["buffs"]["priority"] = minimalBuffs
			ApplyFilterGroups(E.db["unitframe"]["units"]["boss"]["buffs"]["filterLists"], minimalModernTargetBossBuffs, 'HELPFUL')
		elseif filterType == 'ElvUI' then
			ResetAuraType(E.db["unitframe"]["units"]["boss"]["buffs"], P.unitframe.units.boss.buffs)
		end
	elseif frame == 'arena' then
		if filterType == 'Everything' then
			E.db["unitframe"]["units"]["arena"]["buffs"]["priority"] = EltruismEverything
			ApplyFilterGroups(E.db["unitframe"]["units"]["arena"]["buffs"]["filterLists"], EltruismModernEverythingBuffGroups, 'HELPFUL')
		elseif filterType == 'Eltruism' then
			E.db["unitframe"]["units"]["arena"]["buffs"]["priority"] = EltruismArenaBuffs
			CopyFilterLists(E.db["unitframe"]["units"]["arena"]["buffs"]["filterLists"], P.unitframe.units.arena.buffs.filterLists)
		elseif filterType == 'Minimal' then
			E.db["unitframe"]["units"]["arena"]["buffs"]["priority"] = minimalBuffs
			ApplyFilterGroups(E.db["unitframe"]["units"]["arena"]["buffs"]["filterLists"], minimalModernNameplatePlayerBuffs, 'HELPFUL')
		elseif filterType == 'ElvUI' then
			ResetAuraType(E.db["unitframe"]["units"]["arena"]["buffs"], P.unitframe.units.arena.buffs)
		end
	elseif frame == 'nameplate' then
		if filterType == 'Everything' then
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["priority"] = EltruismEverything
			E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["priority"] = EltruismEverything
			ApplyFilterGroups(E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["filterLists"], EltruismModernEverythingBuffGroups, 'HELPFUL')
			ApplyFilterGroups(E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["filterLists"], EltruismModernEverythingBuffGroups, 'HELPFUL')
		elseif filterType == 'Eltruism' then
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["priority"] = EltruismNameplateEnemyPlayerBuffs
			E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["priority"] = EltruismNameplateEnemyNPCBuffs
			CopyFilterLists(E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["filterLists"], P.nameplates.units.ENEMY_PLAYER.buffs.filterLists)
			ApplyFilterGroups(E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["filterLists"], EltruismModernNameplateNPCBuffs, 'HELPFUL')
		elseif filterType == 'Minimal' then
			E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["priority"] = minimalBuffs
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["priority"] = 'Blacklist,Dispellable,TurtleBuffs'
			ApplyFilterGroups(E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["filterLists"], minimalModernNameplatePlayerBuffs, 'HELPFUL')
			ApplyFilterGroups(E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["filterLists"], minimalModernNameplateNPCBuffs, 'HELPFUL')
		elseif filterType == 'ElvUI' then
			for i = 1, #nameplateUnits do
				local unit = nameplateUnits[i]
				ResetAuraType(E.db["nameplates"]["units"][unit]["buffs"], P.nameplates.units[unit].buffs)
			end
		end
	elseif frame == 'party' then
		if filterType == 'Everything' then
			E.db["unitframe"]["units"]["party"]["buffs"]["priority"] = EltruismEverything
			ApplyFilterGroups(E.db["unitframe"]["units"]["party"]["buffs"]["filterLists"], EltruismModernEverythingBuffGroups, 'HELPFUL')
		elseif filterType == 'Eltruism' then
			E.db["unitframe"]["units"]["party"]["buffs"]["priority"] = EltruismGroupBuffs
			ApplyFilterGroups(E.db["unitframe"]["units"]["party"]["buffs"]["filterLists"], EltruismModernGroupBuffs, 'HELPFUL')
		elseif filterType == 'Minimal' then
			E.db["unitframe"]["units"]["party"]["buffs"]["priority"] = minimalBuffs
			CopyFilterLists(E.db["unitframe"]["units"]["party"]["buffs"]["filterLists"], P.unitframe.units.party.buffs.filterLists)
		elseif filterType == 'ElvUI' then
			ResetAuraType(E.db["unitframe"]["units"]["party"]["buffs"], P.unitframe.units.party.buffs)
		end
	elseif frame == 'raid' then
		if filterType == 'Everything' then
			E.db["unitframe"]["units"]["raid1"]["buffs"]["priority"] = EltruismEverything
			E.db["unitframe"]["units"]["raid2"]["buffs"]["priority"] = EltruismEverything
			E.db["unitframe"]["units"]["raid3"]["buffs"]["priority"] = EltruismEverything
			ApplyFilterGroups(E.db["unitframe"]["units"]["raid1"]["buffs"]["filterLists"], EltruismModernEverythingBuffGroups, 'HELPFUL')
			ApplyFilterGroups(E.db["unitframe"]["units"]["raid2"]["buffs"]["filterLists"], EltruismModernEverythingBuffGroups, 'HELPFUL')
			ApplyFilterGroups(E.db["unitframe"]["units"]["raid3"]["buffs"]["filterLists"], EltruismModernEverythingBuffGroups, 'HELPFUL')
		elseif filterType == 'Eltruism' then
			E.db["unitframe"]["units"]["raid1"]["buffs"]["priority"] = EltruismGroupBuffs
			E.db["unitframe"]["units"]["raid2"]["buffs"]["priority"] = EltruismGroupBuffs
			E.db["unitframe"]["units"]["raid3"]["buffs"]["priority"] = EltruismGroupBuffs
			ApplyFilterGroups(E.db["unitframe"]["units"]["raid1"]["buffs"]["filterLists"], EltruismModernGroupBuffs, 'HELPFUL')
			ApplyFilterGroups(E.db["unitframe"]["units"]["raid2"]["buffs"]["filterLists"], EltruismModernGroupBuffs, 'HELPFUL')
			ApplyFilterGroups(E.db["unitframe"]["units"]["raid3"]["buffs"]["filterLists"], EltruismModernGroupBuffs, 'HELPFUL')
		elseif filterType == 'Minimal' then
			E.db["unitframe"]["units"]["raid1"]["buffs"]["priority"] = minimalBuffs
			E.db["unitframe"]["units"]["raid2"]["buffs"]["priority"] = minimalBuffs
			E.db["unitframe"]["units"]["raid3"]["buffs"]["priority"] = minimalBuffs
			CopyFilterLists(E.db["unitframe"]["units"]["raid1"]["buffs"]["filterLists"], P.unitframe.units.raid1.buffs.filterLists)
			CopyFilterLists(E.db["unitframe"]["units"]["raid2"]["buffs"]["filterLists"], P.unitframe.units.raid2.buffs.filterLists)
			CopyFilterLists(E.db["unitframe"]["units"]["raid3"]["buffs"]["filterLists"], P.unitframe.units.raid3.buffs.filterLists)
		elseif filterType == 'ElvUI' then
			for i = 1, #raidUnits do
				local unit = raidUnits[i]
				ResetAuraType(E.db["unitframe"]["units"][unit]["buffs"], P.unitframe.units[unit].buffs)
			end
		end
	elseif frame == 'aurabar' then
		ApplyAuraBarFilters(filterType)
	end
end

--debuff filters
local function ApplyDebuffFilters(frame, filterType)
	if frame == 'player' then
		if filterType == 'Everything' then
			E.db["unitframe"]["units"]["player"]["debuffs"]["priority"] = EltruismEverything
			ApplyFilterGroups(E.db["unitframe"]["units"]["player"]["debuffs"]["filterLists"], EltruismModernEverythingDebuffGroups, 'HARMFUL')
		elseif filterType == 'Eltruism' then
			E.db["unitframe"]["units"]["player"]["debuffs"]["priority"] = EltruismPlayerDebuffs
			CopyFilterLists(E.db["unitframe"]["units"]["player"]["debuffs"]["filterLists"], P.unitframe.units.player.debuffs.filterLists)
		elseif filterType == 'Minimal' then
			E.db["unitframe"]["units"]["player"]["debuffs"]["priority"] = minimalDebuffs
			ApplyFilterGroups(E.db["unitframe"]["units"]["player"]["debuffs"]["filterLists"], minimalModernPlayerDebuffs, 'HARMFUL')
		elseif filterType == 'ElvUI' then
			ResetAuraType(E.db["unitframe"]["units"]["player"]["debuffs"], P.unitframe.units.player.debuffs)
		end
	elseif frame == 'target' then
		if filterType == 'Everything' then
			E.db["unitframe"]["units"]["target"]["debuffs"]["priority"] = EltruismEverything
			ApplyFilterGroups(E.db["unitframe"]["units"]["target"]["debuffs"]["filterLists"], EltruismModernEverythingEnemyDebuffGroups, 'HARMFUL')
		elseif filterType == 'Eltruism' then
			E.db["unitframe"]["units"]["target"]["debuffs"]["priority"] = EltruismTargetDebuffs
			ApplyFilterGroups(E.db["unitframe"]["units"]["target"]["debuffs"]["filterLists"], EltruismModernEnemyDebuffs, 'HARMFUL')
		elseif filterType == 'Minimal' then
			E.db["unitframe"]["units"]["target"]["debuffs"]["priority"] = minimalDebuffs
			ApplyFilterGroups(E.db["unitframe"]["units"]["target"]["debuffs"]["filterLists"], minimalModernEnemyDebuffs, 'HARMFUL')
		elseif filterType == 'ElvUI' then
			ResetAuraType(E.db["unitframe"]["units"]["target"]["debuffs"], P.unitframe.units.target.debuffs)
			ResetAuraType(E.db["unitframe"]["units"]["target"]["auras"], P.unitframe.units.target.auras, true)
		end
		if filterType == 'Everything' or filterType == 'Eltruism' or filterType == 'Minimal' then
			E.db["unitframe"]["units"]["target"]["auras"]["enable"] = false
		end
	elseif frame == 'focus' then
		if filterType == 'Everything' then
			E.db["unitframe"]["units"]["focus"]["debuffs"]["priority"] = EltruismEverything
			ApplyFilterGroups(E.db["unitframe"]["units"]["focus"]["debuffs"]["filterLists"], EltruismModernEverythingEnemyDebuffGroups, 'HARMFUL')
		elseif filterType == 'Eltruism' then
			E.db["unitframe"]["units"]["focus"]["debuffs"]["priority"] = EltruismFocusDebuffs
			CopyFilterLists(E.db["unitframe"]["units"]["focus"]["debuffs"]["filterLists"], P.unitframe.units.focus.debuffs.filterLists)
		elseif filterType == 'Minimal' then
			E.db["unitframe"]["units"]["focus"]["debuffs"]["priority"] = minimalDebuffs
			ApplyFilterGroups(E.db["unitframe"]["units"]["focus"]["debuffs"]["filterLists"], minimalModernEnemyDebuffs, 'HARMFUL')
		elseif filterType == 'ElvUI' then
			ResetAuraType(E.db["unitframe"]["units"]["focus"]["debuffs"], P.unitframe.units.focus.debuffs)
		end
	elseif frame == 'boss' then
		if filterType == 'Everything' then
			E.db["unitframe"]["units"]["boss"]["debuffs"]["priority"] = EltruismEverything
			ApplyFilterGroups(E.db["unitframe"]["units"]["boss"]["debuffs"]["filterLists"], EltruismModernEverythingEnemyDebuffGroups, 'HARMFUL')
		elseif filterType == 'Eltruism' then
			E.db["unitframe"]["units"]["boss"]["debuffs"]["priority"] = EltruismBossDebuffs
			ApplyFilterGroups(E.db["unitframe"]["units"]["boss"]["debuffs"]["filterLists"], EltruismModernEnemyDebuffs, 'HARMFUL')
		elseif filterType == 'Minimal' then
			E.db["unitframe"]["units"]["boss"]["debuffs"]["priority"] = minimalDebuffs
			ApplyFilterGroups(E.db["unitframe"]["units"]["boss"]["debuffs"]["filterLists"], minimalModernEnemyDebuffs, 'HARMFUL')
		elseif filterType == 'ElvUI' then
			ResetAuraType(E.db["unitframe"]["units"]["boss"]["debuffs"], P.unitframe.units.boss.debuffs)
		end
	elseif frame == 'arena' then
		if filterType == 'Everything' then
			E.db["unitframe"]["units"]["arena"]["debuffs"]["priority"] = EltruismEverything
			ApplyFilterGroups(E.db["unitframe"]["units"]["arena"]["debuffs"]["filterLists"], EltruismModernEverythingEnemyDebuffGroups, 'HARMFUL')
		elseif filterType == 'Eltruism' then
			E.db["unitframe"]["units"]["arena"]["debuffs"]["priority"] = EltruismArenaDebuffs
			ApplyFilterGroups(E.db["unitframe"]["units"]["arena"]["debuffs"]["filterLists"], EltruismModernEnemyDebuffs, 'HARMFUL')
		elseif filterType == 'Minimal' then
			E.db["unitframe"]["units"]["arena"]["debuffs"]["priority"] = minimalDebuffs
			ApplyFilterGroups(E.db["unitframe"]["units"]["arena"]["debuffs"]["filterLists"], minimalModernEnemyDebuffs, 'HARMFUL')
		elseif filterType == 'ElvUI' then
			ResetAuraType(E.db["unitframe"]["units"]["arena"]["debuffs"], P.unitframe.units.arena.debuffs)
		end
	elseif frame == 'nameplate' then
		if filterType == 'Everything' then
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["priority"] = EltruismEverything
			E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["priority"] = EltruismEverything
			ApplyFilterGroups(E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["filterLists"], EltruismModernEverythingEnemyDebuffGroups, 'HARMFUL')
			ApplyFilterGroups(E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["filterLists"], EltruismModernEverythingEnemyDebuffGroups, 'HARMFUL')
		elseif filterType == 'Eltruism' then
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["priority"] = EltruismNameplateEnemyPlayerDebuffs
			E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["priority"] = EltruismNameplateEnemyNPCDebuffs
			ApplyFilterGroups(E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["filterLists"], EltruismModernEnemyDebuffs, 'HARMFUL')
			ApplyFilterGroups(E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["filterLists"], EltruismModernEnemyDebuffs, 'HARMFUL')
		elseif filterType == 'Minimal' then
			E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["priority"] = minimalDebuffs
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["priority"] = "Blacklist,Personal,CCDebuffs"
			ApplyFilterGroups(E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["filterLists"], minimalModernEnemyDebuffs, 'HARMFUL')
			ApplyFilterGroups(E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["filterLists"], minimalModernEnemyDebuffs, 'HARMFUL')
		elseif filterType == 'ElvUI' then
			for i = 1, #nameplateUnits do
				local unit = nameplateUnits[i]
				ResetAuraType(E.db["nameplates"]["units"][unit]["debuffs"], P.nameplates.units[unit].debuffs)
				ResetAuraType(E.db["nameplates"]["units"][unit]["auras"], P.nameplates.units[unit].auras, true)
			end
		end
		if filterType == 'Everything' or filterType == 'Eltruism' or filterType == 'Minimal' then
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["auras"]["enable"] = false
			E.db["nameplates"]["units"]["ENEMY_NPC"]["auras"]["enable"] = false
			E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["auras"]["enable"] = false
		end
	elseif frame == 'party' then
		if filterType == 'Everything' then
			E.db["unitframe"]["units"]["party"]["debuffs"]["priority"] = EltruismEverything
			ApplyFilterGroups(E.db["unitframe"]["units"]["party"]["debuffs"]["filterLists"], EltruismModernEverythingDebuffGroups, 'HARMFUL')
		elseif filterType == 'Eltruism' then
			E.db["unitframe"]["units"]["party"]["debuffs"]["priority"] = EltruismGroupDebuffs
			CopyFilterLists(E.db["unitframe"]["units"]["party"]["debuffs"]["filterLists"], P.unitframe.units.party.debuffs.filterLists)
		elseif filterType == 'Minimal' then
			E.db["unitframe"]["units"]["party"]["debuffs"]["priority"] = minimalDebuffs
			ApplyFilterGroups(E.db["unitframe"]["units"]["party"]["debuffs"]["filterLists"], minimalModernGroupDebuffs, 'HARMFUL')
		elseif filterType == 'ElvUI' then
			ResetAuraType(E.db["unitframe"]["units"]["party"]["debuffs"], P.unitframe.units.party.debuffs)
		end
	elseif frame == 'raid' then
		if filterType == 'Everything' then
			E.db["unitframe"]["units"]["raid1"]["debuffs"]["priority"] = EltruismEverything
			E.db["unitframe"]["units"]["raid2"]["debuffs"]["priority"] = EltruismEverything
			E.db["unitframe"]["units"]["raid3"]["debuffs"]["priority"] = EltruismEverything
			ApplyFilterGroups(E.db["unitframe"]["units"]["raid1"]["debuffs"]["filterLists"], EltruismModernEverythingDebuffGroups, 'HARMFUL')
			ApplyFilterGroups(E.db["unitframe"]["units"]["raid2"]["debuffs"]["filterLists"], EltruismModernEverythingDebuffGroups, 'HARMFUL')
			ApplyFilterGroups(E.db["unitframe"]["units"]["raid3"]["debuffs"]["filterLists"], EltruismModernEverythingDebuffGroups, 'HARMFUL')
		elseif filterType == 'Eltruism' then
			E.db["unitframe"]["units"]["raid1"]["debuffs"]["priority"] = EltruismGroupDebuffs
			E.db["unitframe"]["units"]["raid2"]["debuffs"]["priority"] = EltruismGroupDebuffs
			E.db["unitframe"]["units"]["raid3"]["debuffs"]["priority"] = EltruismGroupDebuffs
			CopyFilterLists(E.db["unitframe"]["units"]["raid1"]["debuffs"]["filterLists"], P.unitframe.units.raid1.debuffs.filterLists)
			CopyFilterLists(E.db["unitframe"]["units"]["raid2"]["debuffs"]["filterLists"], P.unitframe.units.raid2.debuffs.filterLists)
			CopyFilterLists(E.db["unitframe"]["units"]["raid3"]["debuffs"]["filterLists"], P.unitframe.units.raid3.debuffs.filterLists)
		elseif filterType == 'Minimal' then
			E.db["unitframe"]["units"]["raid1"]["debuffs"]["priority"] = minimalDebuffs
			E.db["unitframe"]["units"]["raid2"]["debuffs"]["priority"] = minimalDebuffs
			E.db["unitframe"]["units"]["raid3"]["debuffs"]["priority"] = minimalDebuffs
			ApplyFilterGroups(E.db["unitframe"]["units"]["raid1"]["debuffs"]["filterLists"], minimalModernGroupDebuffs, 'HARMFUL')
			ApplyFilterGroups(E.db["unitframe"]["units"]["raid2"]["debuffs"]["filterLists"], minimalModernGroupDebuffs, 'HARMFUL')
			ApplyFilterGroups(E.db["unitframe"]["units"]["raid3"]["debuffs"]["filterLists"], minimalModernGroupDebuffs, 'HARMFUL')
		elseif filterType == 'ElvUI' then
			for i = 1, #raidUnits do
				local unit = raidUnits[i]
				ResetAuraType(E.db["unitframe"]["units"][unit]["debuffs"], P.unitframe.units[unit].debuffs)
			end
		end
	elseif frame == 'aurabar' then
		ApplyAuraBarFilters(filterType)
	end
end

--aura filter setup based on Luckyone's credits to him!
function ElvUI_EltreumUI:SetupBuffs(frame, filterType, skipUpdate)
	ApplyBuffFilters(frame, filterType)
	if not skipUpdate then
		E:UpdateAll()
		ElvUI_EltreumUI:Print(L["Buff filters were setup"])
	end
end

function ElvUI_EltreumUI:SetupDebuffs(frame, filterType, skipUpdate)
	ApplyDebuffFilters(frame, filterType)
	if not skipUpdate then
		E:UpdateAll()
		ElvUI_EltreumUI:Print(L["Debuff filters were setup"])
	end
end

local auraFrames = { 'player', 'target', 'focus', 'boss', 'arena', 'nameplate', 'party', 'raid' }

--setup all aura filters at once
function ElvUI_EltreumUI:SetupAllAuras(filterType, skipUpdate)
	if filterType == 'ElvUI' then
		ResetAllElvUIFilters()
	else
		for i = 1, #auraFrames do
			local frame = auraFrames[i]
			ApplyBuffFilters(frame, filterType)
			ApplyDebuffFilters(frame, filterType)
		end
		ApplyAuraBarFilters(filterType)
	end
	if not skipUpdate then
		E:UpdateAll()
		ElvUI_EltreumUI:Print(L["Aura filters were setup"])
	end
end
