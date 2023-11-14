local E, L = unpack(ElvUI)

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
local EltruismTargetBuffs = "Blacklist,Dispellable,blockNoDuration,PlayerBuffs,nonPersonal,RaidBuffsElvUI,TurtleBuffs"
local EltruismTargetDebuffs = "Blacklist,Personal,CCDebuffs"
local EltruismPlayerDebuffs = "Blacklist,blockNoDuration,Personal,nonPersonal"
local EltruismPlayerBuffs = "Blacklist,Personal,nonPersonal"
local EltruismBossBuffs = "Blacklist,Dispellable,RaidBuffsElvUI,TurtleBuffs"
local EltruismBossDebuffs = "Blacklist,CCDebuffs,RaidDebuffs"
local EltruismFocusBuffs = "Blacklist,Dispellable,RaidBuffsElvUI,TurtleBuffs"
local EltruismFocusDebuffs = "Blacklist,Personal,CCDebuffs"
local EltruismGroupBuffs = 'Blacklist,TurtleBuffs'
local EltruismGroupDebuffs = 'Blacklist,Boss,RaidDebuffs,CCDebuffs,Dispellable,Whitelist'

local EltruismAuraTarget = 'Blacklist,blockNoDuration,Personal,Boss,RaidDebuffs,PlayerBuffs,RaidBuffsElvUI,TurtleBuffs'
local EltruismAuraPlayer = 'Blacklist,blockNoDuration,Personal,Boss,RaidDebuffs,PlayerBuffs'
local AlternativeAura = 'Blacklist,blockNoDuration,Personal,Dispellable'

--nameplates
local EltruismNameplateEnemyPlayerBuffs = "Blacklist,Dispellable,PlayerBuffs,TurtleBuffs"
local EltruismNameplateEnemyPlayerDebuffs = "Blacklist,Personal,Boss,CCDebuffs,RaidDebuffs,nonPersonal"
local EltruismNameplateEnemyNPCBuffs = "Blacklist,RaidBuffsElvUI,Dispellable,blockNoDuration,CastByUnit"
local EltruismNameplateEnemyNPCDebuffs = "Blacklist,Personal,CCDebuffs,CastByNPC"

--All filter mainly for wrath/tbc/classic
local EltruismEverything = "Blacklist,Personal,nonPersonal"

--based on luckyone
local AlternativeBuffs = 'Blacklist,Dispellable,RaidBuffsElvUI'
local AlternativeDebuffs = 'Blacklist,Personal,CCDebuffs'

--aura filter setup based on Luckyone's credits to him!
function ElvUI_EltreumUI:SetupBuffs(frame, type)
	if frame == 'player' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["player"]["buffs"]["priority"] = EltruismEverything
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["player"]["buffs"]["priority"] = EltruismPlayerBuffs
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["player"]["buffs"]["priority"] = AlternativeBuffs
		end
	elseif frame == 'target' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["target"]["buffs"]["priority"] = EltruismEverything
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["target"]["buffs"]["priority"] = EltruismTargetBuffs
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["target"]["buffs"]["priority"] = AlternativeBuffs
		end
	elseif frame == 'focus' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["focus"]["buffs"]["priority"] = EltruismEverything
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["focus"]["buffs"]["priority"] = EltruismFocusBuffs
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["focus"]["buffs"]["priority"] = AlternativeBuffs
		end
	elseif frame == 'boss' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["boss"]["buffs"]["priority"] = EltruismEverything
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["boss"]["buffs"]["priority"] = EltruismBossBuffs
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["boss"]["buffs"]["priority"] = AlternativeBuffs
		end
	elseif frame == 'nameplate' then
		if type == 'Everything' then
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["priority"] = EltruismEverything
			E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["priority"] = EltruismEverything
		elseif type == 'Eltruism' then
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["priority"] = EltruismNameplateEnemyPlayerBuffs
			E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["priority"] = EltruismNameplateEnemyNPCBuffs
		elseif type == 'Minimal' then
			E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["priority"] = AlternativeBuffs
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["priority"] = 'Blacklist,Dispellable,TurtleBuffs'
		end
	elseif frame == 'party' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["party"]["buffs"]["priority"] = EltruismEverything
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["party"]["buffs"]["priority"] = EltruismGroupBuffs
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["party"]["buffs"]["priority"] = AlternativeBuffs
		end
	elseif frame == 'raid' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["raid1"]["buffs"]["priority"] = EltruismEverything
			E.db["unitframe"]["units"]["raid2"]["buffs"]["priority"] = EltruismEverything
			E.db["unitframe"]["units"]["raid3"]["buffs"]["priority"] = EltruismEverything
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["raid1"]["buffs"]["priority"] = EltruismGroupBuffs
			E.db["unitframe"]["units"]["raid2"]["buffs"]["priority"] = EltruismGroupBuffs
			E.db["unitframe"]["units"]["raid3"]["buffs"]["priority"] = EltruismGroupBuffs
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["raid1"]["buffs"]["priority"] = AlternativeBuffs
			E.db["unitframe"]["units"]["raid2"]["buffs"]["priority"] = AlternativeBuffs
			E.db["unitframe"]["units"]["raid3"]["buffs"]["priority"] = AlternativeBuffs
		end
	elseif frame == 'aurabar' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["target"]["aurabar"]["priority"] = EltruismEverything
			E.db["unitframe"]["units"]["player"]["aurabar"]["priority"] = EltruismEverything
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["target"]["aurabar"]["priority"] = EltruismAuraTarget
			E.db["unitframe"]["units"]["player"]["aurabar"]["priority"] = EltruismAuraPlayer
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["target"]["aurabar"]["priority"] = AlternativeAura
			E.db["unitframe"]["units"]["player"]["aurabar"]["priority"] = AlternativeAura
		end
	end
	E:StaggeredUpdateAll()
	ElvUI_EltreumUI:Print(L["Buff filters were setup"])
end

function ElvUI_EltreumUI:SetupDebuffs(frame, type)
	if frame == 'player' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["player"]["debuffs"]["priority"] = EltruismEverything
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["player"]["debuffs"]["priority"] = EltruismPlayerDebuffs
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["player"]["debuffs"]["priority"] = AlternativeDebuffs
		end
	elseif frame == 'target' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["target"]["debuffs"]["priority"] = EltruismEverything
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["target"]["debuffs"]["priority"] = EltruismTargetDebuffs
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["target"]["debuffs"]["priority"] = AlternativeDebuffs
		end
	elseif frame == 'focus' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["focus"]["debuffs"]["priority"] = EltruismEverything
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["focus"]["debuffs"]["priority"] = EltruismFocusDebuffs
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["focus"]["debuffs"]["priority"] = AlternativeDebuffs
		end
	elseif frame == 'boss' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["boss"]["debuffs"]["priority"] = EltruismEverything
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["boss"]["debuffs"]["priority"] = EltruismBossDebuffs
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["boss"]["debuffs"]["priority"] = AlternativeDebuffs
		end
	elseif frame == 'nameplate' then
		if type == 'Everything' then
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["priority"] = EltruismEverything
			E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["priority"] = EltruismEverything
		elseif type == 'Eltruism' then
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["priority"] = EltruismNameplateEnemyPlayerDebuffs
			E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["priority"] = EltruismNameplateEnemyNPCDebuffs
		elseif type == 'Minimal' then
			E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["priority"] = AlternativeDebuffs
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["priority"] = "Blacklist,Personal,CCDebuffs"
		end
	elseif frame == 'party' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["party"]["debuffs"]["priority"] = EltruismEverything
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["party"]["debuffs"]["priority"] = EltruismGroupDebuffs
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["party"]["debuffs"]["priority"] = AlternativeDebuffs
		end
	elseif frame == 'raid' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["raid1"]["debuffs"]["priority"] = EltruismEverything
			E.db["unitframe"]["units"]["raid2"]["debuffs"]["priority"] = EltruismEverything
			E.db["unitframe"]["units"]["raid3"]["debuffs"]["priority"] = EltruismEverything
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["raid1"]["debuffs"]["priority"] = EltruismGroupDebuffs
			E.db["unitframe"]["units"]["raid2"]["debuffs"]["priority"] = EltruismGroupDebuffs
			E.db["unitframe"]["units"]["raid3"]["debuffs"]["priority"] = EltruismGroupDebuffs
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["raid1"]["debuffs"]["priority"] = AlternativeDebuffs
			E.db["unitframe"]["units"]["raid2"]["debuffs"]["priority"] = AlternativeDebuffs
			E.db["unitframe"]["units"]["raid3"]["debuffs"]["priority"] = AlternativeDebuffs
		end
	elseif frame == 'aurabar' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["target"]["aurabar"]["priority"] = EltruismEverything
			E.db["unitframe"]["units"]["player"]["aurabar"]["priority"] = EltruismEverything
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["target"]["aurabar"]["priority"] = EltruismAuraTarget
			E.db["unitframe"]["units"]["player"]["aurabar"]["priority"] = EltruismAuraPlayer
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["target"]["aurabar"]["priority"] = AlternativeAura
			E.db["unitframe"]["units"]["player"]["aurabar"]["priority"] = AlternativeAura
		end
	end
	E:StaggeredUpdateAll()
	ElvUI_EltreumUI:Print(L["Debuff filters were setup"])
end
