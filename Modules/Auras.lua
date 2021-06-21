local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

--Eltruism/Default ElvUI filters
--dps filters
local Eltruismdpstargetbuffs = "Blacklist,Personal,nonPersonal,Dispellable"
local Eltruismdpstargetdebuffs = "Blacklist,Personal,RaidDebuffs,CCDebuffs,Friendly:Dispellable"
local Eltruismdpsplayerdebuffs = "Blacklist,blockNoDuration,Personal,nonPersonal"
local Eltruismdpsplayerbuffs = "Blacklist,Personal,PlayerBuffs,Whitelist,blockNoDuration,nonPersonal"
local Eltruismdpsbossbuffs = "Blacklist,CastByUnit,Dispellable,Whitelist,RaidBuffsElvUI"
local Eltruismdpsbossdebuffs = "Blacklist,Boss,Personal,RaidDebuffs,CastByUnit,Whitelist"
local Eltruismdpsfocusbuffs = "Blacklist,Personal,PlayerBuffs,CastByUnit,Dispellable,RaidBuffsElvUI"
local Eltruismdpsfocusdebuffs = "Blacklist,Personal,Boss,RaidDebuffs,Dispellable,Whitelist"
--healer filters
local Eltruismhealertargetbuffs = "Blacklist,Personal,nonPersonal,Dispellable"
local Eltruismhealertargetdebuffs = "Blacklist,Personal,RaidDebuffs,CCDebuffs,Friendly:Dispellable"
local Eltruismhealerplayerdebuffs = "Blacklist,blockNoDuration,Personal,nonPersonal"
local Eltruismhealerplayerbuffs = "Blacklist,Personal,PlayerBuffs,Whitelist,blockNoDuration,nonPersonal"
--local Eltruismhealerraid40debuffs = "Blacklist,Boss,RaidDebuffs,CCDebuffs,Dispellable,Whitelist"
--local Eltruismhealerraiddebuffs = "Blacklist,Boss,RaidDebuffs,CCDebuffs,Dispellable,Whitelist"
local Eltruismhealerfocusbuffs = "Blacklist,Personal,PlayerBuffs,CastByUnit,Dispellable,RaidBuffsElvUI"
local Eltruismhealerfocusdebuffs = "Blacklist,Personal,Boss,RaidDebuffs,Dispellable,Whitelist"
local Eltruismhealerbossbuffs =  "Blacklist,CastByUnit,Dispellable,Whitelist,RaidBuffsElvUI"
local Eltruismhealerbossdebuffs = "Blacklist,Boss,Personal,RaidDebuffs,CastByUnit,Whitelist"
--nameplates
local Eltruismnpenemynpcbuffs = "Blacklist,RaidBuffsElvUI,Dispellable,blockNoDuration,PlayerBuffs,TurtleBuffs,CastByUnit"
local Eltruismnpenemyplayerbuffs = "Blacklist,Dispellable,PlayerBuffs,TurtleBuffs"
local Eltruismnpenemynpcdebuffs = "Blacklist,Personal,CCDebuffs"
local Eltruismnpenemyplayerdebuffs = "Blacklist,blockNoDuration,Personal,Boss,CCDebuffs,RaidDebuffs,nonPersonal"

--All filters mainly for tbc/classic
--dps filters
local alldpstargetbuffs = "Blacklist,Personal,nonPersonal,Dispellable"
local alldpstargetdebuffs = "Blacklist,Personal,RaidDebuffs,CCDebuffs,Friendly:Dispellable,nonPersonal"
local alldpsplayerdebuffs = "Blacklist,blockNoDuration,Personal,nonPersonal"
local alldpsplayerbuffs = "Blacklist,Personal,PlayerBuffs,Whitelist,blockNoDuration,nonPersonal"
local alldpsfocusbuffs = "Blacklist,Personal,PlayerBuffs,CastByUnit,Dispellable,RaidBuffsElvUI"
local alldpsfocusdebuffs = "Blacklist,Personal,Boss,RaidDebuffs,Dispellable,Whitelist"
local alldpsbossbuffs = "Blacklist,CastByUnit,Dispellable,Whitelist,RaidBuffsElvUI"
local alldpsbossdebuffs = "Blacklist,Boss,Personal,RaidDebuffs,CastByUnit,Whitelist"
--healer filters
local allhealertargetbuffs = "Blacklist,Personal,nonPersonal,Dispellable"
local allhealertargetdebuffs = "Blacklist,Personal,RaidDebuffs,CCDebuffs,Friendly:Dispellable,nonPersonal"
local allhealerplayerdebuffs = "Blacklist,blockNoDuration,Personal,nonPersonal"
local allhealerplayerbuffs = "Blacklist,Personal,PlayerBuffs,Whitelist,blockNoDuration,nonPersonal"
--local allhealerraid40debuffs = "Blacklist,Boss,RaidDebuffs,CCDebuffs,Dispellable,Whitelist,nonPersonal"
--local allhealerraiddebuffs = "Blacklist,Boss,RaidDebuffs,CCDebuffs,Dispellable,Whitelist,nonPersonal"
local allhealerfocusbuffs = "Blacklist,Personal,PlayerBuffs,CastByUnit,Dispellable,RaidBuffsElvUI"
local allhealerfocusdebuffs = "Blacklist,Personal,Boss,RaidDebuffs,Dispellable,Whitelist"
local allhealerbossbuffs =  "Blacklist,CastByUnit,Dispellable,Whitelist,RaidBuffsElvUI"
local allhealerbossdebuffs = "Blacklist,Boss,Personal,RaidDebuffs,CastByUnit,Whitelist"
--nameplates
local allnpenemynpcbuffs = "Blacklist,RaidBuffsElvUI,Dispellable,blockNoDuration,PlayerBuffs,TurtleBuffs,CastByUnit,nonPersonal"
local allnpenemyplayerbuffs = "Blacklist,Dispellable,PlayerBuffs,TurtleBuffs,nonPersonal"
local allnpenemynpcdebuffs = "Blacklist,Personal,CCDebuffs,nonPersonal"
local allnpenemyplayerdebuffs = "Blacklist,blockNoDuration,Personal,Boss,CCDebuffs,RaidDebuffs,nonPersonal"

--aura filter setup based on Luckyone's credits to him!
function ElvUI_EltreumUI:SetupBuffs(frame, type)
	if frame == 'player' then
		if type == 'Everything' then
			if ElvDB.profileKeys[E.mynameRealm] == "Eltreum DPS/Tank" then
				E.db["unitframe"]["units"]["player"]["buffs"]["priority"] = alldpsplayerbuffs
			elseif ElvDB.profileKeys[E.mynameRealm] == "Eltreum Healer" then
				E.db["unitframe"]["units"]["player"]["buffs"]["priority"] = allhealerplayerbuffs
			else
				ElvUI_EltreumUI:Print('You need to be using an Eltruism profile in order to use this function')
			end
		elseif type == 'Eltruism' then
			if ElvDB.profileKeys[E.mynameRealm] == "Eltreum DPS/Tank" then
				E.db["unitframe"]["units"]["player"]["buffs"]["priority"] = Eltruismdpsplayerbuffs
			elseif ElvDB.profileKeys[E.mynameRealm] == "Eltreum Healer" then
				E.db["unitframe"]["units"]["player"]["buffs"]["priority"] = Eltruismhealerplayerbuffs
			else
				ElvUI_EltreumUI:Print('You need to be using an Eltruism profile in order to use this function')
			end
		end
	elseif frame == 'target' then
		if type == 'Everything' then
			if ElvDB.profileKeys[E.mynameRealm] == "Eltreum DPS/Tank" then
				E.db["unitframe"]["units"]["target"]["buffs"]["priority"] = alldpstargetbuffs
			elseif ElvDB.profileKeys[E.mynameRealm] == "Eltreum Healer" then
				E.db["unitframe"]["units"]["target"]["buffs"]["priority"] = allhealertargetbuffs
			else
				ElvUI_EltreumUI:Print('You need to be using an Eltruism profile in order to use this function')
			end
		elseif type == 'Eltruism' then
			if ElvDB.profileKeys[E.mynameRealm] == "Eltreum DPS/Tank" then
				E.db["unitframe"]["units"]["target"]["buffs"]["priority"] = Eltruismdpstargetbuffs
			elseif ElvDB.profileKeys[E.mynameRealm] == "Eltreum Healer" then
				E.db["unitframe"]["units"]["target"]["buffs"]["priority"] = Eltruismhealertargetbuffs
			else
				ElvUI_EltreumUI:Print('You need to be using an Eltruism profile in order to use this function')
			end
		end
	elseif frame == 'focus' then
		if type == 'Everything' then
			if ElvDB.profileKeys[E.mynameRealm] == "Eltreum DPS/Tank" then
				E.db["unitframe"]["units"]["focus"]["buffs"]["priority"] = alldpsfocusbuffs
			elseif ElvDB.profileKeys[E.mynameRealm] == "Eltreum Healer" then
				E.db["unitframe"]["units"]["focus"]["buffs"]["priority"] = allhealerfocusbuffs
			else
				ElvUI_EltreumUI:Print('You need to be using an Eltruism profile in order to use this function')
			end
		elseif type == 'Eltruism' then
			if ElvDB.profileKeys[E.mynameRealm] == "Eltreum DPS/Tank" then
				E.db["unitframe"]["units"]["focus"]["buffs"]["priority"] = Eltruismdpsfocusbuffs
			elseif ElvDB.profileKeys[E.mynameRealm] == "Eltreum Healer" then
				E.db["unitframe"]["units"]["focus"]["buffs"]["priority"] = Eltruismhealerfocusbuffs
			else
				ElvUI_EltreumUI:Print('You need to be using an Eltruism profile in order to use this function')
			end
		end
	elseif frame == 'boss' then
		if type == 'Everything' then
			if ElvDB.profileKeys[E.mynameRealm] == "Eltreum DPS/Tank" then
				E.db["unitframe"]["units"]["boss"]["buffs"]["priority"] = alldpsbossbuffs
			elseif ElvDB.profileKeys[E.mynameRealm] == "Eltreum Healer" then
				E.db["unitframe"]["units"]["boss"]["buffs"]["priority"] = allhealerbossbuffs
			else
				ElvUI_EltreumUI:Print('You need to be using an Eltruism profile in order to use this function')
			end
		elseif type == 'Eltruism' then
			if ElvDB.profileKeys[E.mynameRealm] == "Eltreum DPS/Tank" then
				E.db["unitframe"]["units"]["boss"]["buffs"]["priority"] = Eltruismdpsbossbuffs
			elseif ElvDB.profileKeys[E.mynameRealm] == "Eltreum Healer" then
				E.db["unitframe"]["units"]["boss"]["buffs"]["priority"] = Eltruismhealerbossbuffs
			else
				ElvUI_EltreumUI:Print('You need to be using an Eltruism profile in order to use this function')
			end
		end
	elseif frame == 'nameplate' then
		if type == 'Everything' then
			if ElvDB.profileKeys[E.mynameRealm] == "Eltreum DPS/Tank" then
				E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["priority"] = allnpenemyplayerbuffs
				E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["priority"] = allnpenemynpcbuffs
			elseif ElvDB.profileKeys[E.mynameRealm] == "Eltreum Healer" then
				E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["priority"] = allnpenemyplayerbuffs
				E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["priority"] = allnpenemynpcbuffs
			else
				ElvUI_EltreumUI:Print('You need to be using an Eltruism profile in order to use this function')
			end
		elseif type == 'Eltruism' then
			if ElvDB.profileKeys[E.mynameRealm] == "Eltreum DPS/Tank" then
				E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["priority"] = Eltruismnpenemyplayerbuffs
				E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["priority"] = Eltruismnpenemynpcbuffs
			elseif ElvDB.profileKeys[E.mynameRealm] == "Eltreum Healer" then
				E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["priority"] = Eltruismnpenemyplayerbuffs
				E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["priority"] = Eltruismnpenemynpcbuffs
			else
				ElvUI_EltreumUI:Print('You need to be using an Eltruism profile in order to use this function')
			end
		end
	end
	E:StaggeredUpdateAll(nil, true)
	ElvUI_EltreumUI:Print('Buff filters were setup')
end

function ElvUI_EltreumUI:SetupDebuffs(frame, type)
	if frame == 'player' then
		if type == 'Everything' then
			if ElvDB.profileKeys[E.mynameRealm] == "Eltreum DPS/Tank" then
				E.db["unitframe"]["units"]["player"]["debuffs"]["priority"] = alldpsplayerdebuffs
			elseif ElvDB.profileKeys[E.mynameRealm] == "Eltreum Healer" then
				E.db["unitframe"]["units"]["player"]["debuffs"]["priority"] = allhealerplayerdebuffs
			else
				ElvUI_EltreumUI:Print('You need to be using an Eltruism profile in order to use this function')
			end
		elseif type == 'Eltruism' then
			if ElvDB.profileKeys[E.mynameRealm] == "Eltreum DPS/Tank" then
				E.db["unitframe"]["units"]["player"]["debuffs"]["priority"] = Eltruismdpsplayerdebuffs
			elseif ElvDB.profileKeys[E.mynameRealm] == "Eltreum Healer" then
				E.db["unitframe"]["units"]["player"]["debuffs"]["priority"] = Eltruismhealerplayerdebuffs
			else
				ElvUI_EltreumUI:Print('You need to be using an Eltruism profile in order to use this function')
			end
		end
	elseif frame == 'target' then
		if type == 'Everything' then
			if ElvDB.profileKeys[E.mynameRealm] == "Eltreum DPS/Tank" then
				E.db["unitframe"]["units"]["target"]["debuffs"]["priority"] = alldpstargetdebuffs
			elseif ElvDB.profileKeys[E.mynameRealm] == "Eltreum Healer" then
				E.db["unitframe"]["units"]["target"]["debuffs"]["priority"] = allhealertargetdebuffs
			else
				ElvUI_EltreumUI:Print('You need to be using an Eltruism profile in order to use this function')
			end
		elseif type == 'Eltruism' then
			if ElvDB.profileKeys[E.mynameRealm] == "Eltreum DPS/Tank" then
				E.db["unitframe"]["units"]["target"]["debuffs"]["priority"] = Eltruismdpstargetdebuffs
			elseif ElvDB.profileKeys[E.mynameRealm] == "Eltreum Healer" then
				E.db["unitframe"]["units"]["target"]["debuffs"]["priority"] = Eltruismhealertargetdebuffs
			else
				ElvUI_EltreumUI:Print('You need to be using an Eltruism profile in order to use this function')
			end
		end
	elseif frame == 'focus' then
		if type == 'Everything' then
			if ElvDB.profileKeys[E.mynameRealm] == "Eltreum DPS/Tank" then
				E.db["unitframe"]["units"]["focus"]["debuffs"]["priority"] = alldpsfocusdebuffs
			elseif ElvDB.profileKeys[E.mynameRealm] == "Eltreum Healer" then
				E.db["unitframe"]["units"]["focus"]["debuffs"]["priority"] = allhealerfocusdebuffs
			else
				ElvUI_EltreumUI:Print('You need to be using an Eltruism profile in order to use this function')
			end
		elseif type == 'Eltruism' then
			if ElvDB.profileKeys[E.mynameRealm] == "Eltreum DPS/Tank" then
				E.db["unitframe"]["units"]["focus"]["debuffs"]["priority"] = Eltruismdpsfocusdebuffs
			elseif ElvDB.profileKeys[E.mynameRealm] == "Eltreum Healer" then
				E.db["unitframe"]["units"]["focus"]["debuffs"]["priority"] = Eltruismhealerfocusdebuffs
			else
				ElvUI_EltreumUI:Print('You need to be using an Eltruism profile in order to use this function')
			end
		end
	elseif frame == 'boss' then
		if type == 'Everything' then
			if ElvDB.profileKeys[E.mynameRealm] == "Eltreum DPS/Tank" then
				E.db["unitframe"]["units"]["boss"]["debuffs"]["priority"] = alldpsbossdebuffs
			elseif ElvDB.profileKeys[E.mynameRealm] == "Eltreum Healer" then
				E.db["unitframe"]["units"]["boss"]["debuffs"]["priority"] = allhealerbossdebuffs
			else
				ElvUI_EltreumUI:Print('You need to be using an Eltruism profile in order to use this function')
			end
		elseif type == 'Eltruism' then
			if ElvDB.profileKeys[E.mynameRealm] == "Eltreum DPS/Tank" then
				E.db["unitframe"]["units"]["boss"]["debuffs"]["priority"] = Eltruismdpsbossdebuffs
			elseif ElvDB.profileKeys[E.mynameRealm] == "Eltreum Healer" then
				E.db["unitframe"]["units"]["boss"]["debuffs"]["priority"] = Eltruismhealerbossdebuffs
			else
				ElvUI_EltreumUI:Print('You need to be using an Eltruism profile in order to use this function')
			end
		end
	elseif frame == 'nameplate' then
		if type == 'Everything' then
			if ElvDB.profileKeys[E.mynameRealm] == "Eltreum DPS/Tank" then
				E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["priority"] = allnpenemyplayerdebuffs
				E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["priority"] = allnpenemynpcdebuffs
			elseif ElvDB.profileKeys[E.mynameRealm] == "Eltreum Healer" then
				E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["priority"] = allnpenemyplayerdebuffs
				E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["priority"] = allnpenemynpcdebuffs
			else
				ElvUI_EltreumUI:Print('You need to be using an Eltruism profile in order to use this function')
			end
		elseif type == 'Eltruism' then
			if ElvDB.profileKeys[E.mynameRealm] == "Eltreum DPS/Tank" then
				E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["priority"] = Eltruismnpenemyplayerdebuffs
				E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["priority"] = Eltruismnpenemynpcdebuffs
			elseif ElvDB.profileKeys[E.mynameRealm] == "Eltreum Healer" then
				E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["priority"] = Eltruismnpenemyplayerdebuffs
				E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["priority"] = Eltruismnpenemynpcdebuffs
			else
				ElvUI_EltreumUI:Print('You need to be using an Eltruism profile in order to use this function')
			end
		end
	end
	E:StaggeredUpdateAll(nil, true)
	ElvUI_EltreumUI:Print('Debuff filters were setup')
end
