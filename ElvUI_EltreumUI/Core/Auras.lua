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

local EltruismModernEverythingBuffs = "HELPFUL"
local EltruismModernEverythingDebuffs = "HARMFUL"

--aura filter setup based on Luckyone's credits to him!
function ElvUI_EltreumUI:SetupBuffs(frame, type)
	if frame == 'player' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["player"]["buffs"]["priority"] = EltruismEverything
			E.db["unitframe"]["units"]["player"]["buffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingBuffs
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["player"]["buffs"]["priority"] = EltruismPlayerBuffs
			E.db["unitframe"]["units"]["player"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.player.buffs.filterLists.group1.filter
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["player"]["buffs"]["priority"] = minimalBuffs
			E.db["unitframe"]["units"]["player"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.player.buffs.filterLists.group1.filter
		end
	elseif frame == 'target' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["target"]["buffs"]["priority"] = EltruismEverything
			E.db["unitframe"]["units"]["target"]["buffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingBuffs
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["target"]["buffs"]["priority"] = EltruismTargetBuffs
			E.db["unitframe"]["units"]["target"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.target.buffs.filterLists.group1.filter
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["target"]["buffs"]["priority"] = minimalBuffs
			E.db["unitframe"]["units"]["target"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.target.buffs.filterLists.group1.filter
		end
	elseif frame == 'focus' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["focus"]["buffs"]["priority"] = EltruismEverything
			E.db["unitframe"]["units"]["focus"]["buffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingBuffs
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["focus"]["buffs"]["priority"] = EltruismFocusBuffs
			E.db["unitframe"]["units"]["focus"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.focus.buffs.filterLists.group1.filter
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["focus"]["buffs"]["priority"] = minimalBuffs
			E.db["unitframe"]["units"]["focus"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.focus.buffs.filterLists.group1.filter
		end
	elseif frame == 'boss' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["boss"]["buffs"]["priority"] = EltruismEverything
			E.db["unitframe"]["units"]["boss"]["buffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingBuffs
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["boss"]["buffs"]["priority"] = EltruismBossBuffs
			E.db["unitframe"]["units"]["boss"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.focus.buffs.filterLists.group1.filter
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["boss"]["buffs"]["priority"] = minimalBuffs
			E.db["unitframe"]["units"]["boss"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.focus.buffs.filterLists.group1.filter
		end
	elseif frame == 'nameplate' then
		if type == 'Everything' then
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["priority"] = EltruismEverything
			E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["priority"] = EltruismEverything
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingBuffs
			E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingBuffs
		elseif type == 'Eltruism' then
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["priority"] = EltruismNameplateEnemyPlayerBuffs
			E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["priority"] = EltruismNameplateEnemyNPCBuffs
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.ENEMY_PLAYER.buffs.filterLists.group1.filter
			E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.ENEMY_NPC.buffs.filterLists.group1.filter
		elseif type == 'Minimal' then
			E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["priority"] = minimalBuffs
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["priority"] = 'Blacklist,Dispellable,TurtleBuffs'
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.ENEMY_PLAYER.buffs.filterLists.group1.filter
			E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.ENEMY_NPC.buffs.filterLists.group1.filter
		end
	elseif frame == 'party' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["party"]["buffs"]["priority"] = EltruismEverything
			E.db["unitframe"]["units"]["party"]["buffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingBuffs
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["party"]["buffs"]["priority"] = EltruismGroupBuffs
			E.db["unitframe"]["units"]["party"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.party.buffs.filterLists.group1.filter
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["party"]["buffs"]["priority"] = minimalBuffs
			E.db["unitframe"]["units"]["party"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.party.buffs.filterLists.group1.filter
		end
	elseif frame == 'raid' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["raid1"]["buffs"]["priority"] = EltruismEverything
			E.db["unitframe"]["units"]["raid2"]["buffs"]["priority"] = EltruismEverything
			E.db["unitframe"]["units"]["raid3"]["buffs"]["priority"] = EltruismEverything
			E.db["unitframe"]["units"]["raid1"]["buffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingBuffs
			E.db["unitframe"]["units"]["raid2"]["buffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingBuffs
			E.db["unitframe"]["units"]["raid3"]["buffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingBuffs
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["raid1"]["buffs"]["priority"] = EltruismGroupBuffs
			E.db["unitframe"]["units"]["raid2"]["buffs"]["priority"] = EltruismGroupBuffs
			E.db["unitframe"]["units"]["raid3"]["buffs"]["priority"] = EltruismGroupBuffs
			E.db["unitframe"]["units"]["raid1"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.raid1.buffs.filterLists.group1.filter
			E.db["unitframe"]["units"]["raid2"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.raid2.buffs.filterLists.group1.filter
			E.db["unitframe"]["units"]["raid3"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.raid3.buffs.filterLists.group1.filter
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["raid1"]["buffs"]["priority"] = minimalBuffs
			E.db["unitframe"]["units"]["raid2"]["buffs"]["priority"] = minimalBuffs
			E.db["unitframe"]["units"]["raid3"]["buffs"]["priority"] = minimalBuffs
			E.db["unitframe"]["units"]["raid1"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.raid1.buffs.filterLists.group1.filter
			E.db["unitframe"]["units"]["raid2"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.raid2.buffs.filterLists.group1.filter
			E.db["unitframe"]["units"]["raid3"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.raid3.buffs.filterLists.group1.filter
		end
	elseif frame == 'aurabar' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["target"]["aurabar"]["priority"] = EltruismEverything
			E.db["unitframe"]["units"]["player"]["aurabar"]["priority"] = EltruismEverything
			E.db["unitframe"]["units"]["target"]["aurabar"]["friendlyFilter"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingBuffs
			E.db["unitframe"]["units"]["player"]["aurabar"]["friendlyFilter"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingBuffs
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["target"]["aurabar"]["priority"] = EltruismAuraTarget
			E.db["unitframe"]["units"]["player"]["aurabar"]["priority"] = EltruismAuraPlayer
			E.db["unitframe"]["units"]["target"]["aurabar"]["friendlyFilter"]["filterLists"]["group1"]["filter"] = 'HELPFUL||PLAYER'
			E.db["unitframe"]["units"]["player"]["aurabar"]["friendlyFilter"]["filterLists"]["group1"]["filter"] = 'HELPFUL||PLAYER'
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["target"]["aurabar"]["priority"] = minimalAura
			E.db["unitframe"]["units"]["player"]["aurabar"]["priority"] = minimalAura
			E.db["unitframe"]["units"]["target"]["aurabar"]["friendlyFilter"]["filterLists"]["group1"]["filter"] = 'HELPFUL||PLAYER'
			E.db["unitframe"]["units"]["player"]["aurabar"]["friendlyFilter"]["filterLists"]["group1"]["filter"] = 'HELPFUL||PLAYER'
		end
	end
	E:UpdateAll()
	ElvUI_EltreumUI:Print(L["Buff filters were setup"])
end

function ElvUI_EltreumUI:SetupDebuffs(frame, type)
	if frame == 'player' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["player"]["debuffs"]["priority"] = EltruismEverything
			E.db["unitframe"]["units"]["player"]["debuffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingDebuffs
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["player"]["debuffs"]["priority"] = EltruismPlayerDebuffs
			E.db["unitframe"]["units"]["player"]["debuffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.player.debuffs.filterLists.group1.filter
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["player"]["debuffs"]["priority"] = minimalDebuffs
			E.db["unitframe"]["units"]["player"]["debuffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.player.debuffs.filterLists.group1.filter
		end
	elseif frame == 'target' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["target"]["debuffs"]["priority"] = EltruismEverything
			E.db["unitframe"]["units"]["target"]["debuffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingDebuffs
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["target"]["debuffs"]["priority"] = EltruismTargetDebuffs
			E.db["unitframe"]["units"]["target"]["debuffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.target.debuffs.filterLists.group1.filter
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["target"]["debuffs"]["priority"] = minimalDebuffs
			E.db["unitframe"]["units"]["target"]["debuffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.target.debuffs.filterLists.group1.filter
		end
	elseif frame == 'focus' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["focus"]["debuffs"]["priority"] = EltruismEverything
			E.db["unitframe"]["units"]["focus"]["debuffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingDebuffs
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["focus"]["debuffs"]["priority"] = EltruismFocusDebuffs
			E.db["unitframe"]["units"]["focus"]["debuffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.focus.debuffs.filterLists.group1.filter
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["focus"]["debuffs"]["priority"] = minimalDebuffs
			E.db["unitframe"]["units"]["focus"]["debuffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.focus.debuffs.filterLists.group1.filter
		end
	elseif frame == 'boss' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["boss"]["debuffs"]["priority"] = EltruismEverything
			E.db["unitframe"]["units"]["boss"]["debuffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingDebuffs
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["boss"]["debuffs"]["priority"] = EltruismBossDebuffs
			E.db["unitframe"]["units"]["boss"]["debuffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.boss.debuffs.filterLists.group1.filter
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["boss"]["debuffs"]["priority"] = minimalDebuffs
			E.db["unitframe"]["units"]["boss"]["debuffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.boss.debuffs.filterLists.group1.filter
		end
	elseif frame == 'nameplate' then
		if type == 'Everything' then
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["priority"] = EltruismEverything
			E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["priority"] = EltruismEverything
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingDebuffs
			E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingDebuffs
		elseif type == 'Eltruism' then
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["priority"] = EltruismNameplateEnemyPlayerDebuffs
			E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["priority"] = EltruismNameplateEnemyNPCDebuffs
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["filterLists"]["group1"]["filter"] = P.nameplates.units.ENEMY_PLAYER.debuffs.filterLists.group1.filter
			E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["filterLists"]["group1"]["filter"] = P.nameplates.units.ENEMY_NPC.debuffs.filterLists.group1.filter
		elseif type == 'Minimal' then
			E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["priority"] = minimalDebuffs
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["priority"] = "Blacklist,Personal,CCDebuffs"
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["filterLists"]["group1"]["filter"] = P.nameplates.units.ENEMY_PLAYER.debuffs.filterLists.group1.filter
			E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["filterLists"]["group1"]["filter"] = P.nameplates.units.ENEMY_NPC.debuffs.filterLists.group1.filter
		end
	elseif frame == 'party' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["party"]["debuffs"]["priority"] = EltruismEverything
			E.db["unitframe"]["units"]["party"]["debuffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingDebuffs
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["party"]["debuffs"]["priority"] = EltruismGroupDebuffs
			E.db["unitframe"]["units"]["party"]["debuffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.party.debuffs.filterLists.group1.filter
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["party"]["debuffs"]["priority"] = minimalDebuffs
			E.db["unitframe"]["units"]["party"]["debuffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.party.debuffs.filterLists.group1.filter
		end
	elseif frame == 'raid' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["raid1"]["debuffs"]["priority"] = EltruismEverything
			E.db["unitframe"]["units"]["raid2"]["debuffs"]["priority"] = EltruismEverything
			E.db["unitframe"]["units"]["raid3"]["debuffs"]["priority"] = EltruismEverything
			E.db["unitframe"]["units"]["raid1"]["debuffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingDebuffs
			E.db["unitframe"]["units"]["raid2"]["debuffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingDebuffs
			E.db["unitframe"]["units"]["raid3"]["debuffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingDebuffs
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["raid1"]["debuffs"]["priority"] = EltruismGroupDebuffs
			E.db["unitframe"]["units"]["raid2"]["debuffs"]["priority"] = EltruismGroupDebuffs
			E.db["unitframe"]["units"]["raid3"]["debuffs"]["priority"] = EltruismGroupDebuffs
			E.db["unitframe"]["units"]["raid1"]["debuffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.raid1.debuffs.filterLists.group1.filter
			E.db["unitframe"]["units"]["raid2"]["debuffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.raid2.debuffs.filterLists.group1.filter
			E.db["unitframe"]["units"]["raid3"]["debuffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.raid3.debuffs.filterLists.group1.filter
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["raid1"]["debuffs"]["priority"] = minimalDebuffs
			E.db["unitframe"]["units"]["raid2"]["debuffs"]["priority"] = minimalDebuffs
			E.db["unitframe"]["units"]["raid3"]["debuffs"]["priority"] = minimalDebuffs
			E.db["unitframe"]["units"]["raid1"]["debuffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.raid1.debuffs.filterLists.group1.filter
			E.db["unitframe"]["units"]["raid2"]["debuffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.raid2.debuffs.filterLists.group1.filter
			E.db["unitframe"]["units"]["raid3"]["debuffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.raid3.debuffs.filterLists.group1.filter
		end
	elseif frame == 'aurabar' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["target"]["aurabar"]["priority"] = EltruismEverything
			E.db["unitframe"]["units"]["player"]["aurabar"]["priority"] = EltruismEverything
			E.db["unitframe"]["units"]["target"]["aurabar"]["enemyFilter"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingDebuffs
			E.db["unitframe"]["units"]["player"]["aurabar"]["enemyFilter"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingDebuffs
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["target"]["aurabar"]["priority"] = EltruismAuraTarget
			E.db["unitframe"]["units"]["player"]["aurabar"]["priority"] = EltruismAuraPlayer
			E.db["unitframe"]["units"]["target"]["aurabar"]["enemyFilter"]["filterLists"]["group1"]["filter"] = 'HARMFUL||PLAYER'
			E.db["unitframe"]["units"]["player"]["aurabar"]["enemyFilter"]["filterLists"]["group1"]["filter"] = 'HARMFUL||PLAYER'
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["target"]["aurabar"]["priority"] = minimalAura
			E.db["unitframe"]["units"]["player"]["aurabar"]["priority"] = minimalAura
			E.db["unitframe"]["units"]["target"]["aurabar"]["enemyFilter"]["filterLists"]["group1"]["filter"] = 'HARMFUL||PLAYER'
			E.db["unitframe"]["units"]["player"]["aurabar"]["enemyFilter"]["filterLists"]["group1"]["filter"] = 'HARMFUL||PLAYER'
		end
	end
	E:UpdateAll()
	ElvUI_EltreumUI:Print(L["Debuff filters were setup"])
end

function ElvUI_EltreumUI:SetupAllAuras(type)
	if type == 'Everything' then
		E.db["unitframe"]["units"]["player"]["buffs"]["priority"] = EltruismEverything
		E.db["unitframe"]["units"]["target"]["buffs"]["priority"] = EltruismEverything
		E.db["unitframe"]["units"]["focus"]["buffs"]["priority"] = EltruismEverything
		E.db["unitframe"]["units"]["boss"]["buffs"]["priority"] = EltruismEverything
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["priority"] = EltruismEverything
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["priority"] = EltruismEverything
		E.db["unitframe"]["units"]["party"]["buffs"]["priority"] = EltruismEverything
		E.db["unitframe"]["units"]["raid1"]["buffs"]["priority"] = EltruismEverything
		E.db["unitframe"]["units"]["raid2"]["buffs"]["priority"] = EltruismEverything
		E.db["unitframe"]["units"]["raid3"]["buffs"]["priority"] = EltruismEverything
		E.db["unitframe"]["units"]["target"]["aurabar"]["priority"] = EltruismEverything
		E.db["unitframe"]["units"]["player"]["aurabar"]["priority"] = EltruismEverything
		E.db["unitframe"]["units"]["player"]["debuffs"]["priority"] = EltruismEverything
		E.db["unitframe"]["units"]["target"]["debuffs"]["priority"] = EltruismEverything
		E.db["unitframe"]["units"]["focus"]["debuffs"]["priority"] = EltruismEverything
		E.db["unitframe"]["units"]["boss"]["debuffs"]["priority"] = EltruismEverything
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["priority"] = EltruismEverything
		E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["priority"] = EltruismEverything
		E.db["unitframe"]["units"]["party"]["debuffs"]["priority"] = EltruismEverything
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["priority"] = EltruismEverything
		E.db["unitframe"]["units"]["raid2"]["debuffs"]["priority"] = EltruismEverything
		E.db["unitframe"]["units"]["raid3"]["debuffs"]["priority"] = EltruismEverything
		E.db["unitframe"]["units"]["target"]["aurabar"]["priority"] = EltruismEverything
		E.db["unitframe"]["units"]["player"]["aurabar"]["priority"] = EltruismEverything

		E.db["unitframe"]["units"]["player"]["buffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingBuffs
		E.db["unitframe"]["units"]["target"]["buffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingBuffs
		E.db["unitframe"]["units"]["focus"]["buffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingBuffs
		E.db["unitframe"]["units"]["boss"]["buffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingBuffs
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingBuffs
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingBuffs
		E.db["unitframe"]["units"]["party"]["buffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingBuffs
		E.db["unitframe"]["units"]["raid1"]["buffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingBuffs
		E.db["unitframe"]["units"]["raid2"]["buffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingBuffs
		E.db["unitframe"]["units"]["raid3"]["buffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingBuffs
		E.db["unitframe"]["units"]["player"]["aurabar"]["friendlyFilter"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingBuffs
		E.db["unitframe"]["units"]["player"]["aurabar"]["enemyFilter"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingDebuffs
		E.db["unitframe"]["units"]["target"]["aurabar"]["friendlyFilter"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingBuffs
		E.db["unitframe"]["units"]["target"]["aurabar"]["enemyFilter"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingDebuffs
		E.db["unitframe"]["units"]["player"]["debuffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingDebuffs
		E.db["unitframe"]["units"]["target"]["debuffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingDebuffs
		E.db["unitframe"]["units"]["focus"]["debuffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingDebuffs
		E.db["unitframe"]["units"]["boss"]["debuffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingDebuffs
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingDebuffs
		E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingDebuffs
		E.db["unitframe"]["units"]["party"]["buffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingDebuffs
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingDebuffs
		E.db["unitframe"]["units"]["raid2"]["debuffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingDebuffs
		E.db["unitframe"]["units"]["raid3"]["debuffs"]["filterLists"]["group1"]["filter"] = EltruismModernEverythingDebuffs
	elseif type == 'Eltruism' then
		E.db["unitframe"]["units"]["player"]["buffs"]["priority"] = EltruismPlayerBuffs
		E.db["unitframe"]["units"]["target"]["buffs"]["priority"] = EltruismTargetBuffs
		E.db["unitframe"]["units"]["focus"]["buffs"]["priority"] = EltruismFocusBuffs
		E.db["unitframe"]["units"]["boss"]["buffs"]["priority"] = EltruismBossBuffs
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["priority"] = EltruismNameplateEnemyPlayerBuffs
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["priority"] = EltruismNameplateEnemyNPCBuffs
		E.db["unitframe"]["units"]["party"]["buffs"]["priority"] = EltruismGroupBuffs
		E.db["unitframe"]["units"]["raid1"]["buffs"]["priority"] = EltruismGroupBuffs
		E.db["unitframe"]["units"]["raid2"]["buffs"]["priority"] = EltruismGroupBuffs
		E.db["unitframe"]["units"]["raid3"]["buffs"]["priority"] = EltruismGroupBuffs
		E.db["unitframe"]["units"]["target"]["aurabar"]["priority"] = EltruismAuraTarget
		E.db["unitframe"]["units"]["player"]["aurabar"]["priority"] = EltruismAuraPlayer
		E.db["unitframe"]["units"]["player"]["debuffs"]["priority"] = EltruismPlayerDebuffs
		E.db["unitframe"]["units"]["target"]["debuffs"]["priority"] = EltruismTargetDebuffs
		E.db["unitframe"]["units"]["focus"]["debuffs"]["priority"] = EltruismFocusDebuffs
		E.db["unitframe"]["units"]["boss"]["debuffs"]["priority"] = EltruismBossDebuffs
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["priority"] = EltruismNameplateEnemyPlayerDebuffs
		E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["priority"] = EltruismNameplateEnemyNPCDebuffs
		E.db["unitframe"]["units"]["party"]["debuffs"]["priority"] = EltruismGroupDebuffs
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["priority"] = EltruismGroupDebuffs
		E.db["unitframe"]["units"]["raid2"]["debuffs"]["priority"] = EltruismGroupDebuffs
		E.db["unitframe"]["units"]["raid3"]["debuffs"]["priority"] = EltruismGroupDebuffs
		E.db["unitframe"]["units"]["target"]["aurabar"]["priority"] = EltruismAuraTarget
		E.db["unitframe"]["units"]["player"]["aurabar"]["priority"] = EltruismAuraPlayer

		E.db["unitframe"]["units"]["player"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.player.buffs.filterLists.group1.filter
		E.db["unitframe"]["units"]["target"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.target.buffs.filterLists.group1.filter
		E.db["unitframe"]["units"]["focus"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.focus.buffs.filterLists.group1.filter
		E.db["unitframe"]["units"]["boss"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.boss.buffs.filterLists.group1.filter
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["filterLists"]["group1"]["filter"] = P.nameplates.units.ENEMY_PLAYER.buffs.filterLists.group1.filter
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["filterLists"]["group1"]["filter"] = P.nameplates.units.ENEMY_NPC.buffs.filterLists.group1.filter
		E.db["unitframe"]["units"]["party"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.party.buffs.filterLists.group1.filter
		E.db["unitframe"]["units"]["raid1"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.raid1.buffs.filterLists.group1.filter
		E.db["unitframe"]["units"]["raid2"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.raid2.buffs.filterLists.group1.filter
		E.db["unitframe"]["units"]["raid3"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.raid3.buffs.filterLists.group1.filter
		E.db["unitframe"]["units"]["player"]["aurabar"]["friendlyFilter"]["filterLists"]["group1"]["filter"] = 'HELPFUL||PLAYER'
		E.db["unitframe"]["units"]["player"]["aurabar"]["enemyFilter"]["filterLists"]["group1"]["filter"] = 'HARMFUL||PLAYER'
		E.db["unitframe"]["units"]["target"]["aurabar"]["friendlyFilter"]["filterLists"]["group1"]["filter"] = 'HELPFUL||PLAYER'
		E.db["unitframe"]["units"]["target"]["aurabar"]["enemyFilter"]["filterLists"]["group1"]["filter"] = 'HARMFUL||PLAYER'
		E.db["unitframe"]["units"]["player"]["debuffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.player.debuffs.filterLists.group1.filter
		E.db["unitframe"]["units"]["target"]["debuffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.target.debuffs.filterLists.group1.filter
		E.db["unitframe"]["units"]["focus"]["debuffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.focus.debuffs.filterLists.group1.filter
		E.db["unitframe"]["units"]["boss"]["debuffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.boss.debuffs.filterLists.group1.filter
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["filterLists"]["group1"]["filter"] = P.nameplates.units.ENEMY_PLAYER.debuffs.filterLists.group1.filter
		E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["filterLists"]["group1"]["filter"] = P.nameplates.units.ENEMY_NPC.debuffs.filterLists.group1.filter
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.raid1.debuffs.filterLists.group1.filter
		E.db["unitframe"]["units"]["party"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.party.debuffs.filterLists.group1.filter
		E.db["unitframe"]["units"]["raid2"]["debuffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.raid2.debuffs.filterLists.group1.filter
		E.db["unitframe"]["units"]["raid3"]["debuffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.raid3.debuffs.filterLists.group1.filter
	elseif type == 'Minimal' then
		E.db["unitframe"]["units"]["player"]["buffs"]["priority"] = minimalBuffs
		E.db["unitframe"]["units"]["target"]["buffs"]["priority"] = minimalBuffs
		E.db["unitframe"]["units"]["focus"]["buffs"]["priority"] = minimalBuffs
		E.db["unitframe"]["units"]["boss"]["buffs"]["priority"] = minimalBuffs
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["priority"] = minimalBuffs
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["priority"] = 'Blacklist,Dispellable,TurtleBuffs'
		E.db["unitframe"]["units"]["party"]["buffs"]["priority"] = minimalBuffs
		E.db["unitframe"]["units"]["raid1"]["buffs"]["priority"] = minimalBuffs
		E.db["unitframe"]["units"]["raid2"]["buffs"]["priority"] = minimalBuffs
		E.db["unitframe"]["units"]["raid3"]["buffs"]["priority"] = minimalBuffs
		E.db["unitframe"]["units"]["target"]["aurabar"]["priority"] = minimalAura
		E.db["unitframe"]["units"]["player"]["aurabar"]["priority"] = minimalAura
		E.db["unitframe"]["units"]["player"]["debuffs"]["priority"] = minimalDebuffs
		E.db["unitframe"]["units"]["target"]["debuffs"]["priority"] = minimalDebuffs
		E.db["unitframe"]["units"]["focus"]["debuffs"]["priority"] = minimalDebuffs
		E.db["unitframe"]["units"]["boss"]["debuffs"]["priority"] = minimalDebuffs
		E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["priority"] = minimalDebuffs
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["priority"] = "Blacklist,Personal,CCDebuffs"
		E.db["unitframe"]["units"]["party"]["debuffs"]["priority"] = minimalDebuffs
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["priority"] = minimalDebuffs
		E.db["unitframe"]["units"]["raid2"]["debuffs"]["priority"] = minimalDebuffs
		E.db["unitframe"]["units"]["raid3"]["debuffs"]["priority"] = minimalDebuffs
		E.db["unitframe"]["units"]["target"]["aurabar"]["priority"] = minimalAura
		E.db["unitframe"]["units"]["player"]["aurabar"]["priority"] = minimalAura

		E.db["unitframe"]["units"]["player"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.player.buffs.filterLists.group1.filter
		E.db["unitframe"]["units"]["target"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.target.buffs.filterLists.group1.filter
		E.db["unitframe"]["units"]["focus"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.focus.buffs.filterLists.group1.filter
		E.db["unitframe"]["units"]["boss"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.boss.buffs.filterLists.group1.filter
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["filterLists"]["group1"]["filter"] = P.nameplates.units.ENEMY_PLAYER.buffs.filterLists.group1.filter
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["filterLists"]["group1"]["filter"] = P.nameplates.units.ENEMY_NPC.buffs.filterLists.group1.filter
		E.db["unitframe"]["units"]["party"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.party.buffs.filterLists.group1.filter
		E.db["unitframe"]["units"]["raid1"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.raid1.buffs.filterLists.group1.filter
		E.db["unitframe"]["units"]["raid2"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.raid2.buffs.filterLists.group1.filter
		E.db["unitframe"]["units"]["raid3"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.raid3.buffs.filterLists.group1.filter
		E.db["unitframe"]["units"]["player"]["aurabar"]["friendlyFilter"]["filterLists"]["group1"]["filter"] = 'HELPFUL||PLAYER'
		E.db["unitframe"]["units"]["player"]["aurabar"]["enemyFilter"]["filterLists"]["group1"]["filter"] = 'HARMFUL||PLAYER'
		E.db["unitframe"]["units"]["target"]["aurabar"]["friendlyFilter"]["filterLists"]["group1"]["filter"] = 'HELPFUL||PLAYER'
		E.db["unitframe"]["units"]["target"]["aurabar"]["enemyFilter"]["filterLists"]["group1"]["filter"] = 'HARMFUL||PLAYER'
		E.db["unitframe"]["units"]["player"]["debuffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.player.debuffs.filterLists.group1.filter
		E.db["unitframe"]["units"]["target"]["debuffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.target.debuffs.filterLists.group1.filter
		E.db["unitframe"]["units"]["focus"]["debuffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.focus.debuffs.filterLists.group1.filter
		E.db["unitframe"]["units"]["boss"]["debuffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.boss.debuffs.filterLists.group1.filter
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["filterLists"]["group1"]["filter"] = P.nameplates.units.ENEMY_PLAYER.debuffs.filterLists.group1.filter
		E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["filterLists"]["group1"]["filter"] = P.nameplates.units.ENEMY_NPC.debuffs.filterLists.group1.filter
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.raid1.debuffs.filterLists.group1.filter
		E.db["unitframe"]["units"]["party"]["buffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.party.debuffs.filterLists.group1.filter
		E.db["unitframe"]["units"]["raid2"]["debuffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.raid2.debuffs.filterLists.group1.filter
		E.db["unitframe"]["units"]["raid3"]["debuffs"]["filterLists"]["group1"]["filter"] = P.unitframe.units.raid3.debuffs.filterLists.group1.filter
	end
	E:UpdateAll()
	ElvUI_EltreumUI:Print(L["Aura filters were setup"])
end
