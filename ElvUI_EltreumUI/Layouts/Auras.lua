local E, L, V, P, G = unpack(ElvUI)

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

local EltruismAuraTarget = 'Blacklist,blockNoDuration,Personal,Boss,RaidDebuffs,Dispellable,PlayerBuffs,RaidBuffsElvUI,TurtleBuffs'
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
local Alternative = 'Blacklist,Dispellable,RaidBuffsElvUI'

--aura filter setup based on Luckyone's credits to him!
function ElvUI_EltreumUI:SetupBuffs(frame, type)
	if frame == 'player' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["player"]["buffs"]["priority"] = EltruismEverything
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["player"]["buffs"]["priority"] = EltruismPlayerBuffs
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["player"]["buffs"]["priority"] = Alternative
		end
	elseif frame == 'target' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["target"]["buffs"]["priority"] = EltruismEverything
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["target"]["buffs"]["priority"] = EltruismTargetBuffs
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["target"]["buffs"]["priority"] = Alternative
		end
	elseif frame == 'focus' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["focus"]["buffs"]["priority"] = EltruismEverything
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["focus"]["buffs"]["priority"] = EltruismFocusBuffs
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["focus"]["buffs"]["priority"] = Alternative
		end
	elseif frame == 'boss' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["boss"]["buffs"]["priority"] = EltruismEverything
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["boss"]["buffs"]["priority"] = EltruismBossBuffs
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["boss"]["buffs"]["priority"] = Alternative
		end
	elseif frame == 'nameplate' then
		if type == 'Everything' then
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["priority"] = EltruismEverything
			E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["priority"] = EltruismEverything
		elseif type == 'Eltruism' then
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["priority"] = EltruismNameplateEnemyPlayerBuffs
			E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["priority"] = EltruismNameplateEnemyNPCBuffs
		elseif type == 'Minimal' then
			E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["priority"] = Alternative
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["priority"] = 'Blacklist,Dispellable,TurtleBuffs'
		end
	elseif frame == 'party' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["party"]["buffs"]["priority"] = EltruismEverything
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["party"]["buffs"]["priority"] = EltruismGroupBuffs
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["party"]["buffs"]["priority"] = Alternative
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
			E.db["unitframe"]["units"]["raid1"]["buffs"]["priority"] = Alternative
			E.db["unitframe"]["units"]["raid2"]["buffs"]["priority"] = Alternative
			E.db["unitframe"]["units"]["raid3"]["buffs"]["priority"] = Alternative
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
			E.db["unitframe"]["units"]["player"]["debuffs"]["priority"] = Alternative
		end
	elseif frame == 'target' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["target"]["debuffs"]["priority"] = EltruismEverything
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["target"]["debuffs"]["priority"] = EltruismTargetDebuffs
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["target"]["debuffs"]["priority"] = Alternative
		end
	elseif frame == 'focus' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["focus"]["debuffs"]["priority"] = EltruismEverything
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["focus"]["debuffs"]["priority"] = EltruismFocusDebuffs
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["focus"]["debuffs"]["priority"] = Alternative
		end
	elseif frame == 'boss' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["boss"]["debuffs"]["priority"] = EltruismEverything
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["boss"]["debuffs"]["priority"] = EltruismBossDebuffs
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["boss"]["debuffs"]["priority"] = Alternative
		end
	elseif frame == 'nameplate' then
		if type == 'Everything' then
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["priority"] = EltruismEverything
			E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["priority"] = EltruismEverything
		elseif type == 'Eltruism' then
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["priority"] = EltruismNameplateEnemyPlayerDebuffs
			E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["priority"] = EltruismNameplateEnemyNPCDebuffs
		elseif type == 'Minimal' then
			E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["priority"] = Alternative
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["priority"] = "Blacklist,Personal,CCDebuffs"
		end
	elseif frame == 'party' then
		if type == 'Everything' then
			E.db["unitframe"]["units"]["party"]["debuffs"]["priority"] = EltruismEverything
		elseif type == 'Eltruism' then
			E.db["unitframe"]["units"]["party"]["debuffs"]["priority"] = EltruismGroupDebuffs
		elseif type == 'Minimal' then
			E.db["unitframe"]["units"]["party"]["debuffs"]["priority"] = Alternative
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
			E.db["unitframe"]["units"]["raid1"]["debuffs"]["priority"] = Alternative
			E.db["unitframe"]["units"]["raid2"]["debuffs"]["priority"] = Alternative
			E.db["unitframe"]["units"]["raid3"]["debuffs"]["priority"] = Alternative
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
