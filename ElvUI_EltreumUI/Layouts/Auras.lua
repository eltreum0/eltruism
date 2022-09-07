local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

--Eltruism/Default ElvUI filters
--dps filters
local Eltruismdpstargetbuffs = "Blacklist,Personal,nonPersonal,Dispellable,BlizzardNameplate"
local Eltruismdpstargetdebuffs = "Blacklist,Personal,RaidDebuffs,CCDebuffs,Friendly:Dispellable"
local Eltruismdpsplayerdebuffs = "Blacklist,blockNoDuration,Personal,nonPersonal"
local Eltruismdpsplayerbuffs = "Blacklist,Personal,PlayerBuffs,Whitelist,blockNoDuration,nonPersonal"
local Eltruismdpsbossbuffs = "Blacklist,CastByUnit,Dispellable,Whitelist,RaidBuffsElvUI"
local Eltruismdpsbossdebuffs = "Blacklist,Boss,Personal,RaidDebuffs,CastByUnit,Whitelist"
local Eltruismdpsfocusbuffs = "Blacklist,Personal,PlayerBuffs,CastByUnit,Dispellable,RaidBuffsElvUI"
local Eltruismdpsfocusdebuffs = "Blacklist,Personal,Boss,RaidDebuffs,Dispellable,Whitelist"
--healer filters
local Eltruismhealertargetbuffs = "Blacklist,Personal,PlayerBuffs,Whitelist,blockNoDuration,nonPersonal,Dispellable,BlizzardNameplate"
local Eltruismhealertargetdebuffs = "Blacklist,Personal,RaidDebuffs,CCDebuffs,Friendly:Dispellable"
local Eltruismhealerplayerdebuffs = "Blacklist,blockNoDuration,Personal,nonPersonal"
local Eltruismhealerplayerbuffs = "Blacklist,Personal,PlayerBuffs,Whitelist,blockNoDuration,nonPersonal"
local Eltruismhealerfocusbuffs = "Blacklist,Personal,PlayerBuffs,CastByUnit,Dispellable,RaidBuffsElvUI"
local Eltruismhealerfocusdebuffs = "Blacklist,Personal,Boss,RaidDebuffs,Dispellable,Whitelist"
local Eltruismhealerbossbuffs = "Blacklist,CastByUnit,Dispellable,Whitelist,RaidBuffsElvUI"
local Eltruismhealerbossdebuffs = "Blacklist,Boss,Personal,RaidDebuffs,CastByUnit,Whitelist"
--nameplates
local Eltruismnpenemynpcbuffs = "Blacklist,RaidBuffsElvUI,Dispellable,blockNoDuration,PlayerBuffs,TurtleBuffs,CastByUnit"
local Eltruismnpenemyplayerbuffs = "Blacklist,Dispellable,PlayerBuffs,TurtleBuffs"
local Eltruismnpenemynpcdebuffs = "Blacklist,Personal,CCDebuffs"
local Eltruismnpenemyplayerdebuffs = "Blacklist,blockNoDuration,Personal,Boss,CCDebuffs,RaidDebuffs,nonPersonal"

--All filter mainly for tbc/classic
local allfilter = "Blacklist,Personal,nonPersonal,CastByPlayers,CastByUnit"

--aura filter setup based on Luckyone's credits to him!
function ElvUI_EltreumUI:SetupBuffs(frame, type)
	if frame == 'player' then
		if type == 'Everything' then
			if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS") then
				E.db["unitframe"]["units"]["player"]["buffs"]["priority"] = allfilter
			elseif ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer") then
				E.db["unitframe"]["units"]["player"]["buffs"]["priority"] = allfilter
			else
				ElvUI_EltreumUI:Print(L["You need to be using an Eltruism profile in order to use this function"])
			end
		elseif type == 'Eltruism' then
			if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") then
				E.db["unitframe"]["units"]["player"]["buffs"]["priority"] = Eltruismdpsplayerbuffs
			elseif ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer") then
				E.db["unitframe"]["units"]["player"]["buffs"]["priority"] = Eltruismhealerplayerbuffs
			else
				ElvUI_EltreumUI:Print(L["You need to be using an Eltruism profile in order to use this function"])
			end
		end
	elseif frame == 'target' then
		if type == 'Everything' then
			if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") then
				E.db["unitframe"]["units"]["target"]["buffs"]["priority"] = allfilter
			elseif ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer") then
				E.db["unitframe"]["units"]["target"]["buffs"]["priority"] = allfilter
			else
				ElvUI_EltreumUI:Print(L["You need to be using an Eltruism profile in order to use this function"])
			end
		elseif type == 'Eltruism' then
			if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") then
				E.db["unitframe"]["units"]["target"]["buffs"]["priority"] = Eltruismdpstargetbuffs
			elseif ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer") then
				E.db["unitframe"]["units"]["target"]["buffs"]["priority"] = Eltruismhealertargetbuffs
			else
				ElvUI_EltreumUI:Print(L["You need to be using an Eltruism profile in order to use this function"])
			end
		end
	elseif frame == 'focus' then
		if type == 'Everything' then
			if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") then
				E.db["unitframe"]["units"]["focus"]["buffs"]["priority"] = allfilter
			elseif ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer") then
				E.db["unitframe"]["units"]["focus"]["buffs"]["priority"] = allfilter
			else
				ElvUI_EltreumUI:Print(L["You need to be using an Eltruism profile in order to use this function"])
			end
		elseif type == 'Eltruism' then
			if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") then
				E.db["unitframe"]["units"]["focus"]["buffs"]["priority"] = Eltruismdpsfocusbuffs
			elseif ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer") then
				E.db["unitframe"]["units"]["focus"]["buffs"]["priority"] = Eltruismhealerfocusbuffs
			else
				ElvUI_EltreumUI:Print(L["You need to be using an Eltruism profile in order to use this function"])
			end
		end
	elseif frame == 'boss' then
		if type == 'Everything' then
			if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") then
				E.db["unitframe"]["units"]["boss"]["buffs"]["priority"] = allfilter
			elseif ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer") then
				E.db["unitframe"]["units"]["boss"]["buffs"]["priority"] = allfilter
			else
				ElvUI_EltreumUI:Print(L["You need to be using an Eltruism profile in order to use this function"])
			end
		elseif type == 'Eltruism' then
			if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") then
				E.db["unitframe"]["units"]["boss"]["buffs"]["priority"] = Eltruismdpsbossbuffs
			elseif ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer") then
				E.db["unitframe"]["units"]["boss"]["buffs"]["priority"] = Eltruismhealerbossbuffs
			else
				ElvUI_EltreumUI:Print(L["You need to be using an Eltruism profile in order to use this function"])
			end
		end
	elseif frame == 'nameplate' then
		if type == 'Everything' then
			if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") then
				E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["priority"] = allfilter
				E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["priority"] = allfilter
			elseif ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer") then
				E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["priority"] = allfilter
				E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["priority"] = allfilter
			else
				ElvUI_EltreumUI:Print(L["You need to be using an Eltruism profile in order to use this function"])
			end
		elseif type == 'Eltruism' then
			if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") then
				E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["priority"] = Eltruismnpenemyplayerbuffs
				E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["priority"] = Eltruismnpenemynpcbuffs
			elseif ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer") then
				E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["priority"] = Eltruismnpenemyplayerbuffs
				E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["priority"] = Eltruismnpenemynpcbuffs
			else
				ElvUI_EltreumUI:Print(L["You need to be using an Eltruism profile in order to use this function"])
			end
		end
	end
	E:StaggeredUpdateAll(nil, true)
	ElvUI_EltreumUI:Print(L["Buff filters were setup"])
end

function ElvUI_EltreumUI:SetupDebuffs(frame, type)
	if frame == 'player' then
		if type == 'Everything' then
			if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") then
				E.db["unitframe"]["units"]["player"]["debuffs"]["priority"] = allfilter
			elseif ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer") then
				E.db["unitframe"]["units"]["player"]["debuffs"]["priority"] = allfilter
			else
				ElvUI_EltreumUI:Print(L["You need to be using an Eltruism profile in order to use this function"])
			end
		elseif type == 'Eltruism' then
			if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") then
				E.db["unitframe"]["units"]["player"]["debuffs"]["priority"] = Eltruismdpsplayerdebuffs
			elseif ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer") then
				E.db["unitframe"]["units"]["player"]["debuffs"]["priority"] = Eltruismhealerplayerdebuffs
			else
				ElvUI_EltreumUI:Print(L["You need to be using an Eltruism profile in order to use this function"])
			end
		end
	elseif frame == 'target' then
		if type == 'Everything' then
			if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") then
				E.db["unitframe"]["units"]["target"]["debuffs"]["priority"] = allfilter
			elseif ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer") then
				E.db["unitframe"]["units"]["target"]["debuffs"]["priority"] = allfilter
			else
				ElvUI_EltreumUI:Print(L["You need to be using an Eltruism profile in order to use this function"])
			end
		elseif type == 'Eltruism' then
			if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") then
				E.db["unitframe"]["units"]["target"]["debuffs"]["priority"] = Eltruismdpstargetdebuffs
			elseif ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer") then
				E.db["unitframe"]["units"]["target"]["debuffs"]["priority"] = Eltruismhealertargetdebuffs
			else
				ElvUI_EltreumUI:Print(L["You need to be using an Eltruism profile in order to use this function"])
			end
		end
	elseif frame == 'focus' then
		if type == 'Everything' then
			if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") then
				E.db["unitframe"]["units"]["focus"]["debuffs"]["priority"] = allfilter
			elseif ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer") then
				E.db["unitframe"]["units"]["focus"]["debuffs"]["priority"] = allfilter
			else
				ElvUI_EltreumUI:Print(L["You need to be using an Eltruism profile in order to use this function"])
			end
		elseif type == 'Eltruism' then
			if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") then
				E.db["unitframe"]["units"]["focus"]["debuffs"]["priority"] = Eltruismdpsfocusdebuffs
			elseif ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer") then
				E.db["unitframe"]["units"]["focus"]["debuffs"]["priority"] = Eltruismhealerfocusdebuffs
			else
				ElvUI_EltreumUI:Print(L["You need to be using an Eltruism profile in order to use this function"])
			end
		end
	elseif frame == 'boss' then
		if type == 'Everything' then
			if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") then
				E.db["unitframe"]["units"]["boss"]["debuffs"]["priority"] = allfilter
			elseif ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer") then
				E.db["unitframe"]["units"]["boss"]["debuffs"]["priority"] = allfilter
			else
				ElvUI_EltreumUI:Print(L["You need to be using an Eltruism profile in order to use this function"])
			end
		elseif type == 'Eltruism' then
			if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") then
				E.db["unitframe"]["units"]["boss"]["debuffs"]["priority"] = Eltruismdpsbossdebuffs
			elseif ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer") then
				E.db["unitframe"]["units"]["boss"]["debuffs"]["priority"] = Eltruismhealerbossdebuffs
			else
				ElvUI_EltreumUI:Print(L["You need to be using an Eltruism profile in order to use this function"])
			end
		end
	elseif frame == 'nameplate' then
		if type == 'Everything' then
			if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") then
				E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["priority"] = allfilter
				E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["priority"] = allfilter
			elseif ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer") then
				E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["priority"] = allfilter
				E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["priority"] = allfilter
			else
				ElvUI_EltreumUI:Print(L["You need to be using an Eltruism profile in order to use this function"])
			end
		elseif type == 'Eltruism' then
			if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") then
				E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["priority"] = Eltruismnpenemyplayerdebuffs
				E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["priority"] = Eltruismnpenemynpcdebuffs
			elseif ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer") then
				E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["priority"] = Eltruismnpenemyplayerdebuffs
				E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["priority"] = Eltruismnpenemynpcdebuffs
			else
				ElvUI_EltreumUI:Print(L["You need to be using an Eltruism profile in order to use this function"])
			end
		end
	end
	E:StaggeredUpdateAll(nil, true)
	ElvUI_EltreumUI:Print(L["Debuff filters were setup"])
end
