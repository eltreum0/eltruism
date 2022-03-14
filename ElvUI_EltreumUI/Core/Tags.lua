local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local utf8sub = string.utf8sub

-- Name custom abbreviation by Azilroka
E:AddTag("name:eltruism:abbreviate", "UNIT_NAME_UPDATE", function(unit)
	local name = UnitName(unit)
	--local name = 'Ецхо оф а Пандарен' --cyrillic name test
	if name and string.len(name) > 16 then
		name = name:gsub('(%S+) ', function(t) return t:utf8sub(1,1)..'. ' end)
	end
	return name
end)
E:AddTagInfo('name:eltruism:abbreviate', ElvUI_EltreumUI.Name, L["Abbreviates the unit name once it goes over 16 characters, made by Azilroka"])

-- Alternate Class Icons by Releaf
local classIcons = {
	['WARRIOR'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarriorReleaf.tga:0:0:0:0|t",
	['PALADIN'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PaladinReleaf.tga:0:0:0:0|t",
	['HUNTER'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\HunterReleaf.tga:0:0:0:0|t",
	['ROGUE'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\RogueReleaf.tga:0:0:0:0|t",
	['PRIEST'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PriestReleaf.tga:0:0:0:0|t",
	['DEATHKNIGHT'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DeathKnightReleaf.tga:0:0:0:0|t",
	['SHAMAN'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\ShamanReleaf.tga:0:0:0:0|t",
	['MAGE'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MageReleaf.tga:0:0:0:0|t",
	['WARLOCK'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarlockReleaf.tga:0:0:0:0|t",
	['MONK'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MonkReleaf.tga:0:0:0:0|t",
	['DRUID'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DruidReleaf.tga:0:0:0:0|t",
	['DEMONHUNTER'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DemonHunterReleaf.tga:0:0:0:0|t",
}

--show class icons on all targets
E:AddTag("eltruism:class:all", "UNIT_NAME_UPDATE", function(unit)
	local icon
	local _ , classes = UnitClass(unit)
	icon = classIcons[classes]
	return icon
end)
E:AddTagInfo('eltruism:class:all', ElvUI_EltreumUI.Name, L["Shows Class Icons recolored by Releaf on all targets"])

--show class icons only on players, ty repooc!
E:AddTag("eltruism:class:player", "UNIT_NAME_UPDATE", function(unit)
	if not UnitIsPlayer(unit) then return end
	local icon
	local _ , classes = UnitClass(unit)
	icon = classIcons[classes]
	return icon
end)
E:AddTagInfo('eltruism:class:player', ElvUI_EltreumUI.Name, L["Shows Class Icons recolored by Releaf on Player targets"])

-- Class Icons
local classIconsBlizzard = {
	['WARRIOR'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Warrior.tga:0:0:0:0|t",
	['PALADIN'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Paladin.tga:0:0:0:0|t",
	['HUNTER'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Hunter.tga:0:0:0:0|t",
	['ROGUE'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Rogue.tga:0:0:0:0|t",
	['PRIEST'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Priest.tga:0:0:0:0|t",
	['DEATHKNIGHT'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DeathKnight.tga:0:0:0:0|t",
	['SHAMAN'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Shaman.tga:0:0:0:0|t",
	['MAGE'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Mage.tga:0:0:0:0|t",
	['WARLOCK'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Warlock.tga:0:0:0:0|t",
	['MONK'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Monk.tga:0:0:0:0|t",
	['DRUID'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Druid.tga:0:0:0:0|t",
	['DEMONHUNTER'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DemonHunter.tga:0:0:0:0|t",
}

--alternate class icons on all targets
E:AddTag("eltruism:blizz:all", "UNIT_NAME_UPDATE", function(unit)
	local icon
	local _ , classes = UnitClass(unit)
	icon = classIconsBlizzard[classes]
	return icon
end)
E:AddTagInfo('eltruism:blizz:all', ElvUI_EltreumUI.Name, L["Shows Class Icons by Blizzard on all targets"])

--alternate class icons on players
E:AddTag("eltruism:blizz:player", "UNIT_NAME_UPDATE", function(unit)
	if not UnitIsPlayer(unit) then return end
	local icon
	local _ , classes = UnitClass(unit)
	icon = classIconsBlizzard[classes]
	return icon
end)
E:AddTagInfo('eltruism:blizz:player', ElvUI_EltreumUI.Name, L["Shows Class Icons by Blizzard only on Player targets"])

-- Alternate Class Icons by Releaf with borders
local classIconsReleafborder = {
	['WARRIOR'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarriorIconReleaf.tga:0:0:0:0|t",
	['PALADIN'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PaladinIconReleaf.tga:0:0:0:0|t",
	['HUNTER'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\HunterIconReleaf.tga:0:0:0:0|t",
	['ROGUE'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\RogueIconReleaf.tga:0:0:0:0|t",
	['PRIEST'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PriestIconReleaf.tga:0:0:0:0|t",
	['DEATHKNIGHT'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DeathKnightIconReleaf.tga:0:0:0:0|t",
	['SHAMAN'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\ShamanIconReleaf.tga:0:0:0:0|t",
	['MAGE'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MageIconReleaf.tga:0:0:0:0|t",
	['WARLOCK'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarlockIconReleaf.tga:0:0:0:0|t",
	['MONK'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MonkIconReleaf.tga:0:0:0:0|t",
	['DRUID'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DruidIconReleaf.tga:0:0:0:0|t",
	['DEMONHUNTER'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DemonHunterIconReleaf.tga:0:0:0:0|t",
}

--alternate class icons on all targets
E:AddTag("eltruism:ReleafBorder:all", "UNIT_NAME_UPDATE", function(unit)
	local icon
	local _ , classes = UnitClass(unit)
	icon = classIconsReleafborder[classes]
	return icon
end)
E:AddTagInfo('eltruism:ReleafBorder:all', ElvUI_EltreumUI.Name, L["Shows Class Icons with borders recolored by Releaf on all targets"])

--alternate class icons on players
E:AddTag("eltruism:ReleafBorder:player", "UNIT_NAME_UPDATE", function(unit)
	if not UnitIsPlayer(unit) then return end
	local icon
	local _ , classes = UnitClass(unit)
	icon = classIconsReleafborder[classes]
	return icon
end)
E:AddTagInfo('eltruism:ReleafBorder:player', ElvUI_EltreumUI.Name, L["Shows Class Icons with borders recolored by Releaf on Player targets"])

-- Class Icons by Blizz with borders
local classIconsOutline = {
	['WARRIOR'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarriorShadow.tga:0:0:0:0|t",
	['PALADIN'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PaladinShadow.tga:0:0:0:0|t",
	['HUNTER'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\HunterShadow.tga:0:0:0:0|t",
	['ROGUE'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\RogueShadow.tga:0:0:0:0|t",
	['PRIEST'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PriestShadow.tga:0:0:0:0|t",
	['DEATHKNIGHT'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DeathKnightShadow.tga:0:0:0:0|t",
	['SHAMAN'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\ShamanShadow.tga:0:0:0:0|t",
	['MAGE'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MageShadow.tga:0:0:0:0|t",
	['WARLOCK'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarlockShadow.tga:0:0:0:0|t",
	['MONK'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MonkShadow.tga:0:0:0:0|t",
	['DRUID'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DruidShadow.tga:0:0:0:0|t",
	['DEMONHUNTER'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DemonHunterShadow.tga:0:0:0:0|t",
}

--class icons with outlines on all targets
E:AddTag("eltruism:IconOutline:all", "UNIT_NAME_UPDATE", function(unit)
	local icon
	local _ , classes = UnitClass(unit)
	icon = classIconsOutline[classes]
	return icon
end)
E:AddTagInfo('eltruism:IconOutline:all', ElvUI_EltreumUI.Name, "Shows Class Icons with Outlines all targets")

--class icons with otlines on players
E:AddTag("eltruism:IconOutline:player", "UNIT_NAME_UPDATE", function(unit)
	if not UnitIsPlayer(unit) then return end
	local icon
	local _ , classes = UnitClass(unit)
	icon = classIconsOutline[classes]
	return icon
end)
E:AddTagInfo('eltruism:IconOutline:player', ElvUI_EltreumUI.Name, "Shows Class Icons with Outlines on Player targets")

-- Class Icons by Releaf with borders
local classIconsOutlineReleaf = {
	['WARRIOR'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Warrior1.tga:0:0:0:0|t",
	['PALADIN'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Paladin1.tga:0:0:0:0|t",
	['HUNTER'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Hunter1.tga:0:0:0:0|t",
	['ROGUE'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Rogue1.tga:0:0:0:0|t",
	['PRIEST'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Priest1.tga:0:0:0:0|t",
	['DEATHKNIGHT'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DeathKnight1.tga:0:0:0:0|t",
	['SHAMAN'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Shaman1.tga:0:0:0:0|t",
	['MAGE'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Mage1.tga:0:0:0:0|t",
	['WARLOCK'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Warlock1.tga:0:0:0:0|t",
	['MONK'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Monk1.tga:0:0:0:0|t",
	['DRUID'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Druid1.tga:0:0:0:0|t",
	['DEMONHUNTER'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DemonHunter1.tga:0:0:0:0|t",
}

--class icons with outlines on all targets
E:AddTag("eltruism:ReleafIconOutline:all", "UNIT_NAME_UPDATE", function(unit)
	local icon
	local _ , classes = UnitClass(unit)
	icon = classIconsOutlineReleaf[classes]
	return icon
end)
E:AddTagInfo('eltruism:ReleafIconOutline:all', ElvUI_EltreumUI.Name, "Shows Class Icons with Outlines by Releaf all targets")

--class icons with otlines on players
E:AddTag("eltruism:ReleafIconOutline:player", "UNIT_NAME_UPDATE", function(unit)
	if not UnitIsPlayer(unit) then return end
	local icon
	local _ , classes = UnitClass(unit)
	icon = classIconsOutlineReleaf[classes]
	return icon
end)
E:AddTagInfo('eltruism:ReleafIconOutline:player', ElvUI_EltreumUI.Name, "Shows Class Icons with Outlines by Releaf on Player targets")

-- Releaf Logo
E:AddTag("releaf", "UNIT_NAME_UPDATE", function()
	local color = E:ClassColor(E.myclass, true)
	local red = math.floor(color.r*255)
	local blue = math.floor(color.b*255)
	local green = math.floor(color.g*255)
	local releaf = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\releaftag.tga:0:0:0:3:128:128:0:128:0:128:" .. red .. ":" .. green .. ":" .. blue .. "|t"
	--local releaf = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Releaf-Orange.tga:0:0:0:0|t"
	return releaf
end)
E:AddTagInfo('releaf', ElvUI_EltreumUI.Name, "Shows Releaf's Icon")

-- Target Marker tag
E:AddTag("eltruism:raidmarker", 'RAID_TARGET_UPDATE', function(unit)
	local index = GetRaidTargetIndex(unit)
	local mark
	if index then
		mark = "|TINTERFACE\\TARGETINGFRAME\\UI-RaidTargetingIcon_"..index..".blp:0:0:0:0|t"
	end
	return mark
end)
E:AddTagInfo('eltruism:raidmarker', ElvUI_EltreumUI.Name, L["Shows raid target marker"])

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
	local difference = (targetlevel - playerlevel)
	local printdifference
	local classification = UnitClassification(unit)
	-- "worldboss", "rareelite", "elite", "rare", "normal", "trivial", or "minus"
	if difference > 5 then
		printdifference = "5"
	elseif difference < -9 then
		printdifference = "-9"
	else
		printdifference = tostring(difference)
	end
	--level difference table based on blizzard's
	local eltruismdif = {
		["-9"] = "|cFF808080",
		["-8"] = "|cFF008000",
		["-7"] = "|cFF008000",
		["-6"] = "|cFF008000",
		["-5"] = "|cFF008000",
		["-4"] = "|cFF008000",
		["-3"] = "|cFF008000",
		["-2"] = "|cFFFFFF00",
		["-1"] = "|cFFFFFF00",
		["0"] = "|cFFFFFF00",
		["1"] = "|cFFFFFF00",
		["2"] = "|cFFFFFF00",
		["3"] = "|cFFA50000",
		["4"] = "|cFFFFA500",
		["5"] = "|cFFFF0000",
	}
	--make sure its not a player as to not overwrite class colors
	if not UnitIsPlayer(unit) and UnitCanAttack("player", unit) then
		if UnitIsEnemy("player", unit) == true then
			if classification ~= "worldboss" then
				if E.TBC or E.Classic then
					return (eltruismdif[printdifference])
				else
					return
				end
			elseif classification == "worldboss" then
				if E.TBC or E.Classic then
					return ("|cFFFF0000")
				else
					return
				end
			end
		end
	end
end)
E:AddTagInfo('eltruism:difficulty', ElvUI_EltreumUI.Name, L["Colors NPC name according to their difficulty compared to the player"])

local classcolorcast = {
	['DEATHKNIGHT']	= "FFC41E3A",
	['DEMONHUNTER']	= "FFA330C9",
	['DRUID'] = "FFFF7C0A",
	['HUNTER'] = "FFAAD372",
	['MAGE'] = "FF3FC7EB",
	['MONK'] = "FF00FF98",
	['PALADIN']	= "FFF48CBA",
	['PRIEST'] = "FFFFFFFF",
	['ROGUE'] = "FFFFF468",
	['SHAMAN'] = "FF0070DD",
	['WARLOCK'] = "FF8788EE",
	['WARRIOR'] = "FFC69B6D",
}
E:AddTag('eltruism:targetcast', 'UNIT_NAME_UPDATE UNIT_SPELLCAST_START UNIT_TARGET UNIT_SPELLCAST_STOP', function(unit)
	local targetname = UnitName(unit.."target")
	local _ , classes = UnitClass(unit.."target")
	local color = classcolorcast[classes]
	if UnitCastingInfo(unit) and targetname then
		if UnitIsPlayer(unit.."target") then
			return ("|c"..color..targetname.."|r")
		else
			return targetname
		end
	end
end)
E:AddTagInfo('eltruism:targetcast', ElvUI_EltreumUI.Name, L["Shows Target of Spellcast, does not work for Mouseover casts"])

E:AddTag('eltruism:targetcast:indicator', 'UNIT_NAME_UPDATE UNIT_SPELLCAST_START UNIT_TARGET UNIT_SPELLCAST_STOP', function(unit)
	local targetname = UnitName(unit.."target")
	local _ , classes = UnitClass(unit.."target")
	local color = classcolorcast[classes]
	if UnitCastingInfo(unit) and targetname then
		if UnitIsPlayer(unit.."target") then
			return ("Target > |c"..color..targetname.."|r")
		else
			return ("Target > "..targetname)
		end
	end
end)
E:AddTagInfo('eltruism:targetcast:indicator', ElvUI_EltreumUI.Name, L["Shows Target of Spellcast, does not work for Mouseover casts. Includes a Target > indicator"])

E:AddTag("eltruism:effectivehp", "UNIT_HEALTH UNIT_TARGET", function()
	local dr
	if UnitExists("target") then
		dr = (UnitArmor("player")/((UnitLevel("target")*467.5)+UnitArmor("player")-22167.5))
		--dr = (UnitArmor("player")/((UnitLevel('target')*467.5)+UnitHealthMax("player")-22167.5))
	else
		dr = (UnitArmor("player")/((UnitLevel("player")*467.5)+UnitArmor("player")-22167.5))
		--dr = (UnitArmor("player")/((UnitLevel('player')*467.5)+UnitHealthMax("player")-22167.5))
	end
	local ehp = UnitHealthMax("player")/(1-dr)
	local effective = math.floor((ehp*100)/100)
	return effective
end)
E:AddTagInfo('eltruism:effectivehp', ElvUI_EltreumUI.Name, L["Shows Effective Health"])

E:AddTag("eltruism:levelskull", "UNIT_TARGET UNIT_NAME_UPDATE", function(unit)
	local level
	if E.Retail then
		level = UnitEffectiveLevel(unit)
	else
		level = UnitLevel(unit)
	end
	local diff = level - UnitLevel("player")
	local classification = UnitClassification(unit)
	if diff > 8 or classification == "worldboss" then
		return "|TInterface\\TARGETINGFRAME\\UI-TARGETINGFRAME-SKULL.BLP:0:0:0:0|t"
	else
		return level
	end
end)
E:AddTagInfo('eltruism:levelskull', ElvUI_EltreumUI.Name, L["Shows the Unit Level, or a skull if the level is too high"])

E:AddTag("eltruism:leader", "GROUP_ROSTER_UPDATE", function(unit)
	local leader = UnitIsGroupLeader(unit)
	local assist = UnitIsGroupAssistant(unit)
	if leader then
		return "|TInterface\\GROUPFRAME\\UI-GROUP-LEADERICON.BLP:0:0:0:0|t"
	elseif assist then
		return "|TInterface\\GROUPFRAME\\UI-GROUP-ASSISTANTICON.BLP:0:0:0:0|t"
	end
end)
E:AddTagInfo("eltruism:leader", ElvUI_EltreumUI.Name, L["Shows the Leader Icon or Assist icon if the unit is Leader or Assist"])

-- Abbreviate in 20 chars for Nekator
E:AddTag("name:eltruism:abbreviate20", "UNIT_NAME_UPDATE", function(unit)
	local name = UnitName(unit)
	--local name = 'Ецхо оф а Пандарен' --cyrillic name test
	if name and string.len(name) > 20 then
		name = name:gsub('(%S+) ', function(t) return t:utf8sub(1,1)..'. ' end)
	end
	return name
end)
E:AddTagInfo("name:eltruism:abbreviate20", ElvUI_EltreumUI.Name, L["Abbreviates the unit name once it goes over 20 characters, made by Azilroka"])

E:AddTag("eltruism:newline", "UNIT_NAME_UPDATE", function()
	return "\n"
end)
E:AddTagInfo("eltruism:newline", ElvUI_EltreumUI.Name, L["Adds a line break"])



--future tag idea: group number only for first member of group
