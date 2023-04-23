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
	end
	E:StaggeredUpdateAll()
	ElvUI_EltreumUI:Print(L["Debuff filters were setup"])
end
