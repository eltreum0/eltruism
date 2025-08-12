local E, L = unpack(ElvUI)
local _G = _G
local GetSpecialization = _G.C_SpecializationInfo and _G.C_SpecializationInfo.GetSpecialization or _G.GetSpecialization
local UnitGroupRolesAssigned = _G.UnitGroupRolesAssigned
local stanceBackup = 0 --store previous stance to force refresh it
local UnitInPartyIsAI = _G.UnitInPartyIsAI
local GetTime = _G.GetTime
local UnitHealthMax = _G.UnitHealthMax
local UnitHealth = _G.UnitHealth
local tonumber = _G.tonumber
local UnitIsDead = _G.UnitIsDead
local UnitPower = _G.UnitPower
local Enum = _G.Enum
local UnitPowerMax = _G.UnitPowerMax
local math = _G.math
local DoEmote = _G.DoEmote
local GetSpecializationRole = _G.GetSpecializationRole
local UnitIsUnit = _G.UnitIsUnit
local strsplit = _G.strsplit
local UnitClass = _G.UnitClass
local UnitIsPlayer = _G.UnitIsPlayer
local IsInRaid = _G.IsInRaid
local GetShapeshiftForm = _G.GetShapeshiftForm
local tostring = _G.tostring
local UnitBattlePetLevel = _G.UnitBattlePetLevel
local UnitIsBattlePetCompanion = _G.UnitIsBattlePetCompanion
local UnitIsWildBattlePet = _G.UnitIsWildBattlePet
local UnitLevel = _G.UnitLevel
local UnitEffectiveLevel = _G.UnitEffectiveLevel
local UnitCastingInfo = _G.UnitCastingInfo or _G.CastingInfo
local UnitChannelInfo = _G.UnitChannelInfo or _G.ChannelInfo
local UnitReaction = _G.UnitReaction
local UnitName = _G.UnitName
local UnitClassification = _G.UnitClassification
local UnitCanAttack = _G.UnitCanAttack
local UnitIsEnemy = _G.UnitIsEnemy
local GROUP = _G.GROUP
local TARGET = _G.TARGET

--ty a lot azilroka
local stanceID = {
	DEATHKNIGHT = {
		[1] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,1),
		[2] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,2),
		[3] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,3),
	},
	PALADIN = {
		[1] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,1),
		[2] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,2),
		[3] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,3),
		[4] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,4),
		[5] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,5),
		[6] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,6),
		[7] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,7),
	},
	WARRIOR = {
		[1] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,1),
		[2] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,2),
		[3] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,3),
		[4] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,4), --gladiator?
	},
	HUNTER = {
		[1] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,1),
		[2] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,2),
		[3] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,3),
		[4] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,4),
		[5] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,5),
	},
}

--because in retail talent changes can occur more freely and change known stances, refresh table
local function refreshstance()
	stanceBackup = 0
	stanceID = {
		DEATHKNIGHT = {
			[1] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,1),
			[2] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,2),
			[3] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,3),
		},
		PALADIN = {
			[1] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,1),
			[2] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,2),
			[3] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,3),
			[4] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,4),
			[5] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,5),
			[6] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,6),
			[7] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,7),
		},
		WARRIOR = {
			[1] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,1),
			[2] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,2),
			[3] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,3),
			[4] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,4), --gladiator?
		},
		HUNTER = {
			[1] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,1),
			[2] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,2),
			[3] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,3),
			[4] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,4),
			[5] = ElvUI_EltreumUI:SpellInfoShapeshift(nil,5),
		},
	}
end

--Difficulty color for npcs in classic/tbc
E:AddTag('eltruism:difficulty', 'UNIT_NAME_UPDATE', function(unit)

	--obtain the levels
	local targetlevel
	if E.Retail then
		targetlevel = UnitEffectiveLevel(unit)
	else
		targetlevel = UnitLevel(unit)
	end
	local playerlevel = UnitLevel("player")

	--calculate the difference
	local classification = UnitClassification(unit) -- "worldboss", "rareelite", "elite", "rare", "normal", "trivial", or "minus"
	if targetlevel < 1 then
		classification = "worldboss"
	end

	--obtain the difference between target and player and fix in case its out of bounds
	local difference = (targetlevel - playerlevel)
	local printdifference
	if difference > 5 then
		printdifference = "5"
	elseif difference < -9 then
		printdifference = "-9"
	else
		printdifference = tostring(difference)
	end

	--make sure its not a player as to not overwrite class colors
	if not UnitIsPlayer(unit) and UnitCanAttack("player", unit) then
		if UnitIsEnemy("player", unit) then
			if classification ~= "worldboss" then
				if E.Mists or E.Classic then
					return (ElvUI_EltreumUI:eltruismdif(printdifference))
				else
					return
				end
			elseif classification == "worldboss" then
				if E.Mists or E.Classic then
					return ("|cFFFF0000")
				else
					return
				end
			end
		end
	end
end)
E:AddTagInfo('eltruism:difficulty', ElvUI_EltreumUI.Name.." "..L["Miscellaneous"], L["Colors NPC name according to their difficulty compared to the player"])

--Difficulty color for npcs in classic/tbc
E:AddTag('eltruism:difficulty:all', 'UNIT_NAME_UPDATE', function(unit)

	--obtain the levels
	local targetlevel
	if E.Retail then
		targetlevel = UnitEffectiveLevel(unit)
	else
		targetlevel = UnitLevel(unit)
	end
	local playerlevel = UnitLevel("player")

	--calculate the difference
	local classification = UnitClassification(unit) -- "worldboss", "rareelite", "elite", "rare", "normal", "trivial", or "minus"
	if targetlevel < 1 then
		classification = "worldboss"
	end

	--obtain the difference between target and player and fix in case its out of bounds
	local difference = (targetlevel - playerlevel)
	local printdifference
	if difference > 5 then
		printdifference = "5"
	elseif difference < -9 then
		printdifference = "-9"
	else
		printdifference = tostring(difference)
	end

	if classification ~= "worldboss" then
		return (ElvUI_EltreumUI:eltruismdif(printdifference))
	elseif classification == "worldboss" then
		return ("|cFFFF0000")
	end
end)
E:AddTagInfo('eltruism:difficulty:all', ElvUI_EltreumUI.Name.." "..L["Miscellaneous"], L["Colors NPC name according to their difficulty compared to the player"])

E:AddTag('eltruism:targetcast', 'UNIT_NAME_UPDATE UNIT_SPELLCAST_START UNIT_TARGET UNIT_SPELLCAST_STOP', function(unit)
	local targetname = UnitName(unit.."target")
	local _ , classes = UnitClass(unit.."target")
	if not classes then return end
	local color = ElvUI_EltreumUI:classcolorcast(classes)
	local name, _, _, startTime, endTime, _, _, spellID = UnitChannelInfo(unit)
	if not name then
		_, _, _, startTime, endTime, _, _, _, spellID = UnitCastingInfo(unit)
	end
	--local spellID = (select(9, UnitCastingInfo(unit))) or (select(8, UnitChannelInfo(unit)))
	--local startTime = (select(4, UnitCastingInfo(unit))) or (select(4, UnitChannelInfo(unit)))
	--local endTime = (select(5, UnitCastingInfo(unit))) or (select(5, UnitChannelInfo(unit)))
	local reaction = UnitReaction(unit.."target", "player")

	if spellID and targetname and endTime > startTime then
		if UnitIsPlayer(unit.."target") then
			return ("|c"..color..targetname.."|r")
		elseif not UnitIsPlayer(unit.."target") then
			if reaction then
				if reaction >= 5 then
					return ("|c"..ElvUI_EltreumUI:classcolorcast("FRIENDLY")..targetname.."|r")
				elseif reaction == 4 then
					return ("|c"..ElvUI_EltreumUI:classcolorcast("NEUTRAL")..targetname.."|r")
				elseif reaction == 3 then
					return ("|c"..ElvUI_EltreumUI:classcolorcast("UNFRIENDLY")..targetname.."|r")
				elseif reaction == 2 or reaction == 1 then
					return ("|c"..ElvUI_EltreumUI:classcolorcast("HOSTILE")..targetname.."|r")
				end
			end
		end
	end
end)
E:AddTagInfo('eltruism:targetcast', ElvUI_EltreumUI.Name.." "..L["Miscellaneous"], L["Shows Target of Spellcast, does not work for Mouseover casts"])

E:AddTag('eltruism:targetcast:indicator', 'UNIT_NAME_UPDATE UNIT_SPELLCAST_START UNIT_TARGET UNIT_SPELLCAST_STOP', function(unit)
	local targetname = UnitName(unit.."target")
	local _ , classes = UnitClass(unit.."target")
	if not classes then return end
	local color = ElvUI_EltreumUI:classcolorcast(classes)

	local name, _, _, startTime, endTime, _, _, spellID = UnitChannelInfo(unit)
	if not name then
		_, _, _, startTime, endTime, _, _, _, spellID = UnitCastingInfo(unit)
	end
	--local spellID = (select(9, UnitCastingInfo(unit))) or (select(8, UnitChannelInfo(unit)))
	--local startTime = (select(4, UnitCastingInfo(unit))) or (select(4, UnitChannelInfo(unit)))
	--local endTime = (select(5, UnitCastingInfo(unit))) or (select(5, UnitChannelInfo(unit)))
	local reaction = UnitReaction(unit.."target", "player")

	if spellID and targetname and endTime > startTime then
		if UnitIsPlayer(unit.."target") then
			return (TARGET.." > |c"..color..targetname.."|r")
		elseif not UnitIsPlayer(unit.."target") then
			if reaction then
				if reaction >= 5 then
					return (TARGET.." > |c"..ElvUI_EltreumUI:classcolorcast("FRIENDLY")..targetname.."|r")
				elseif reaction == 4 then
					return (TARGET.." > |c"..ElvUI_EltreumUI:classcolorcast("NEUTRAL")..targetname.."|r")
				elseif reaction == 3 then
					return (TARGET.." > |c"..ElvUI_EltreumUI:classcolorcast("UNFRIENDLY")..targetname.."|r")
				elseif reaction == 2 or reaction == 1 then
					return (TARGET.." > |c"..ElvUI_EltreumUI:classcolorcast("HOSTILE")..targetname.."|r")
				end
			end
		end
	end
end)
E:AddTagInfo('eltruism:targetcast:indicator', ElvUI_EltreumUI.Name.." "..L["Miscellaneous"], L["Shows Target of Spellcast, does not work for Mouseover casts. Includes a Target > indicator"])

-- Line Break
E:AddTag("eltruism:newline", "PLAYER_LOGOUT", function()
	return "\n"
end)
E:AddTagInfo("eltruism:newline", ElvUI_EltreumUI.Name.." "..L["Miscellaneous"], L["Adds a line break"])

E:AddTag("eltruism:smartlevel", 'UNIT_LEVEL PLAYER_LEVEL_UP', function(unit)
	local level
	local playerlevel
	if E.Retail then
		level = UnitEffectiveLevel(unit)
		playerlevel = UnitEffectiveLevel('player')
	else
		level = UnitLevel(unit)
		playerlevel = UnitLevel('player')
	end

	if E.Retail and (UnitIsWildBattlePet(unit) or UnitIsBattlePetCompanion(unit)) then
		return UnitBattlePetLevel(unit)
	elseif level == playerlevel then
		if UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit)) then
			return nil
		else
			return level
		end
	elseif level > 0 then
		return level
	else
		return '??'
	end
end)
E:AddTagInfo("eltruism:smartlevel", ElvUI_EltreumUI.Name.." "..L["Miscellaneous"], L["Shows level difference when it exists for NPCs and players, hides for players if same level"])

E:AddTag("eltruism:stance", 1, function()
	local stance = GetShapeshiftForm()
	local stanceInfo = stanceID[E.myclass] and stanceID[E.myclass][stance]
	if stanceBackup ~= stance then
		refreshstance()
	end
	if stanceInfo then
		return stanceInfo, tostring(stance)
	end
end)
E:AddTagInfo("eltruism:stance", ElvUI_EltreumUI.Name.." "..L["Miscellaneous"], L["Shows the current stance of the player"])

if E.Mists then
	E:AddTag("eltruism:presencecolor", 1, function()
		local stance = GetShapeshiftForm()
		if stance == 1 then
			return "|cFFff4040"..ElvUI_EltreumUI:EltruismSpellInfo(48266).."|r"
		elseif stance == 2 then
			return "|cFF40ffff"..ElvUI_EltreumUI:EltruismSpellInfo(48263).."|r"
		elseif stance == 3 then
			return "|cFF40ff40"..ElvUI_EltreumUI:EltruismSpellInfo(48265).."|r"
		end
	end)
	E:AddTagInfo("eltruism:presencecolor", ElvUI_EltreumUI.Name.." "..L["Miscellaneous"], L["Shows the current presence with color"])
end

--group number only for first member of group (can break if players get moved tho)
E:AddTag("eltruism:groupnumber", "GROUP_ROSTER_UPDATE UNIT_NAME_UPDATE", function(unit)
	if IsInRaid() then
		if unit == "raid1" then
			return GROUP.." 1"
		elseif unit == "raid6" then
			return GROUP.." 2"
		elseif unit == "raid11" then
			return GROUP.." 3"
		elseif unit == "raid16" then
			return GROUP.." 4"
		elseif unit == "raid21" then
			return GROUP.." 5"
		elseif unit == "raid26" then
			return GROUP.." 6"
		elseif unit == "raid31" then
			return GROUP.." 7"
		elseif unit == "raid36" then
			return GROUP.." 8"
		end
	else
		return ""
	end
end)
E:AddTagInfo("eltruism:groupnumber", ElvUI_EltreumUI.Name.." "..L["Miscellaneous"], L["Displays the number of the group for the first member of that group, \nraid sorting can break this tag making it show up on other members."])

--Class color but only for players, from elvui but without the npc stuff
E:AddTag("eltruism:classcolor", 'UNIT_NAME_UPDATE', function(unit)
	if UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit)) then
		local _, unitClass = UnitClass(unit)
		if not unitClass then return end
		local cs = _G.ElvUF.colors.class[unitClass]
		return (cs and E:RGBToHex(cs[1], cs[2], cs[3])) or '|cFFcccccc'
	end
end)
E:AddTagInfo("eltruism:classcolor", ElvUI_EltreumUI.Name.." "..L["Miscellaneous"], L["Returns class color only for players"])

--plays a sound for healers when they have low mana, has anti spam
local manaspam = false
E:AddTag("eltruism:lowmana", 'UNIT_POWER_FREQUENT', function(unit,_,args)
	local percentage = strsplit(':', args or '')
	if percentage == nil then
		percentage = 1
	end
	if UnitIsUnit("player", unit) then
		local role
		if E.Retail then
			local currentSpec = GetSpecialization()
			if currentSpec ~= nil then
				role = GetSpecializationRole(currentSpec)
			end
		elseif E.Mists then
			role = UnitGroupRolesAssigned("player")
		end
		if role == 'HEALER' or E.Classic then
			if (UnitPower("player")/UnitPowerMax("player")) < (tonumber(percentage) * 0.01) then
				if not manaspam then
					DoEmote("OOM")
					manaspam = true
				end
				return ""
			elseif (UnitPower("player")/UnitPowerMax("player")) > (tonumber(percentage) * 0.01) then
				manaspam = false
				return ""
			end
		end
	end
end)
E:AddTagInfo("eltruism:lowmana", ElvUI_EltreumUI.Name.." "..L["Miscellaneous"], L["Plays a voiced emote when you have low mana as a healer. Usage: [eltruism:lowmana{5}] as an example of 5%"])

--emote when low on health
local hpspam = false
E:AddTag("eltruism:lowhealth", "UNIT_HEALTH UNIT_MAXHEALTH", function(unit,_,args)
	local percentage = strsplit(':', args or '')
	if percentage == nil then
		percentage = 1
	end
	if UnitIsUnit("player", unit) then --player
		if not UnitIsDead("player") then
			if (UnitHealth("player")/UnitHealthMax("player")) < (tonumber(percentage) * 0.01) then
				if not hpspam then
					DoEmote("HEALME")
					hpspam = true
				end
			elseif (UnitHealth("player")/UnitHealthMax("player")) > (tonumber(percentage) * 0.01) then
				hpspam = false
			end
		end
	end
end)
E:AddTagInfo("eltruism:lowhealth", ElvUI_EltreumUI.Name.." "..L["Miscellaneous"], L["Plays a voiced emote when you have low health. Usage: [eltruism:lowhealth{1}] as an example of 1%"])

E:AddTag("eltruism:healermana", 'UNIT_NAME_UPDATE UNIT_POWER_FREQUENT UNIT_MAXPOWER', function(unit)
	local role = UnitGroupRolesAssigned(unit)
	if role and role == 'HEALER' then
		if UnitPower(unit, Enum.PowerType.Mana) ~= 0 then
			return math.floor((UnitPower(unit, Enum.PowerType.Mana)/UnitPowerMax(unit, Enum.PowerType.Mana))*100).."%"
		else
			return "0%"
		end
	end
end)
E:AddTagInfo("eltruism:healermana", ElvUI_EltreumUI.Name.." "..L["Miscellaneous"], L["Shows mana if the unit is a healer"])

--experimental dps on unit tag
local lastHp = 0
local lastTime = GetTime()
E:AddTag("eltruism:unitdps", "UNIT_HEALTH", function(unit)
	local cur, maxhp = UnitHealth(unit), UnitHealthMax(unit)
	local now = GetTime()
	if lastHp == 0 or lastHp > maxhp then
		lastHp = cur
		lastTime = now
		return ""
	end
	if UnitIsDead(unit) then
		return ""
	end
	local timediff = now - lastTime
	local hpdiff = lastHp - cur
	lastHp = cur
	lastTime = now
	if hpdiff > 0 and timediff > 0 then
		local dps = math.floor(hpdiff / timediff)
		if dps > 0 then
			return E:GetFormattedText("CURRENT", math.floor(hpdiff / timediff))
		else
			return "|cFF00FF00"..E:GetFormattedText("CURRENT", math.floor(hpdiff / timediff)).."|r"
		end

	else
		return ""
	end
end)
E:AddTagInfo("eltruism:unitdps", ElvUI_EltreumUI.Name.." "..L["Miscellaneous"], L["Displays DPS on the unit"])
