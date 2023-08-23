local E, L = unpack(ElvUI)
local _G = _G
local UnitName = _G.UnitName
local string = _G.string
local UnitClass = _G.UnitClass
local UnitIsPlayer = _G.UnitIsPlayer
local math = _G.math
local GetRaidTargetIndex = _G.GetRaidTargetIndex
local UnitEffectiveLevel = _G.UnitEffectiveLevel
local UnitLevel = _G.UnitLevel
local UnitClassification = _G.UnitClassification
local tostring = _G.tostring
local UnitCanAttack = _G.UnitCanAttack
local UnitIsEnemy = _G.UnitIsEnemy
local UnitChannelInfo = _G.UnitChannelInfo
local UnitCastingInfo = _G.UnitCastingInfo
local UnitReaction = _G.UnitReaction
local UnitExists = _G.UnitExists
local UnitArmor = _G.UnitArmor
local UnitHealthMax = _G.UnitHealthMax
local UnitIsGroupLeader = _G.UnitIsGroupLeader
local UnitIsGroupAssistant = _G.UnitIsGroupAssistant
local GetPartyAssignment = _G.GetPartyAssignment
local Translit = E.Libs.Translit
local UnitHealth = _G.UnitHealth
local UnitIsGhost = _G.UnitIsGhost
local UnitIsDead = _G.UnitIsDead
local UnitIsConnected = _G.UnitIsConnected
local GetSpellInfo = _G.GetSpellInfo
local strsplit = _G.strsplit
local tonumber = _G.tonumber
local DoEmote = _G.DoEmote
local UnitIsUnit = _G.UnitIsUnit
local UnitPowerMax = _G.UnitPowerMax
local UnitPower = _G.UnitPower
local GetSpecialization = _G.GetSpecialization
local GetShapeshiftFormInfo = _G.GetShapeshiftFormInfo
local select = _G.select
local ElvUI_EltreumUI = _G.ElvUI_EltreumUI

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
	["3"] = "|cFFFFA500",
	["4"] = "|cFFA50000",
	["5"] = "|cFFFF0000",
}

--to get the correct name for the files
--https://stackoverflow.com/questions/2421695/first-character-uppercase-lua
local function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end
local fileclass = firstToUpper(string.lower(E.myclass))

--from elvui, modified for gradient
do
	local function EltruismGetTitleNPC(unit, custom)
		if UnitIsPlayer(unit) or (E.Wrath and UnitAffectingCombat('player') and IsInInstance()) then return end

		E.ScanTooltip:SetOwner(_G.UIParent, 'ANCHOR_NONE')
		E.ScanTooltip:SetUnit(unit)
		E.ScanTooltip:Show()

		-- similar to TT.GetLevelLine
		local ttLine = _G[format('ElvUI_ScanTooltipTextLeft%d', GetCVarBool('colorblindmode') and 3 or 2)]
		local ttText = ttLine and ttLine:GetText()
		local ttLower = ttText and strlower(ttText)

		if ttLower and not ttLower:match(LEVEL) and not ttText:match(LEVEL) then
			local reaction = UnitReaction(unit, "player")
			if reaction then
				if not custom then
					if reaction >= 5 then
						ttText = ElvUI_EltreumUI:GradientName(ttText, "NPCFRIENDLY")
					elseif reaction == 4 then
						ttText = ElvUI_EltreumUI:GradientName(ttText, "NPCNEUTRAL")
					elseif reaction == 3 then
						ttText = ElvUI_EltreumUI:GradientName(ttText, "NPCUNFRIENDLY")
					elseif reaction == 2 or reaction == 1 then
						ttText = ElvUI_EltreumUI:GradientName(ttText, "NPCHOSTILE")
					end
					return ttText
				else
					ttText = format(custom, ttText)
					if reaction >= 5 then
						ttText = ElvUI_EltreumUI:GradientName(ttText, "NPCFRIENDLY")
					elseif reaction == 4 then
						ttText = ElvUI_EltreumUI:GradientName(ttText, "NPCNEUTRAL")
					elseif reaction == 3 then
						ttText = ElvUI_EltreumUI:GradientName(ttText, "NPCUNFRIENDLY")
					elseif reaction == 2 or reaction == 1 then
						ttText = ElvUI_EltreumUI:GradientName(ttText, "NPCHOSTILE")
					end
					return ttText
				end
			end
		end
	end

	E:AddTag('eltruismnpctitle', 'UNIT_NAME_UPDATE', function(unit)
		return EltruismGetTitleNPC(unit)
	end)
	E:AddTagInfo("eltruismnpctitle", ElvUI_EltreumUI.Name.." "..L["Names"], L["Displays NPC title in gradient"])

	E:AddTag('eltruismnpctitle:brackets', 'UNIT_NAME_UPDATE', function(unit)
		return EltruismGetTitleNPC(unit, '<%s>')
	end)
	E:AddTagInfo("eltruismnpctitle:brackets", ElvUI_EltreumUI.Name.." "..L["Names"], L["Displays NPC title in gradient with brackets"])
end

local stanceBackup = 0 --store previous stance to force refresh it

--ty a lot azilroka
local stanceID = {
	DEATHKNIGHT = {
		[1] = not E.Retail and GetSpellInfo(48266),
		[2] = not E.Retail and GetSpellInfo(48263),
		[3] = not E.Retail and GetSpellInfo(48265),
	},
	PALADIN = {
		[1] = (E.Retail and GetSpellInfo(select(4,GetShapeshiftFormInfo(1)))) or GetSpellInfo(465),
		[2] = (E.Retail and GetSpellInfo(select(4,GetShapeshiftFormInfo(2)))) or GetSpellInfo(7294),
		[3] = (E.Retail and GetSpellInfo(select(4,GetShapeshiftFormInfo(3)))) or GetSpellInfo(19746),
		[4] = (E.Retail and GetSpellInfo(select(4,GetShapeshiftFormInfo(4)))) or GetSpellInfo(19746),
		[5] = not E.Retail and GetSpellInfo(19888),
		[6] = not E.Retail and GetSpellInfo(19891),
		[7] = not E.Retail and GetSpellInfo(32223),
	},
	WARRIOR = {
		[1] = not E.Retail and GetSpellInfo(2457),
		[2] = not E.Retail and GetSpellInfo(71),
		[3] = not E.Retail and GetSpellInfo(2458),
	}
}

--because in retail talent changes can occur more freely and change known stances, refresh table
local function refreshstance()
	stanceBackup = 0
	stanceID = {
		DEATHKNIGHT = {
			[1] = not E.Retail and GetSpellInfo(48266),
			[2] = not E.Retail and GetSpellInfo(48263),
			[3] = not E.Retail and GetSpellInfo(48265),
		},
		PALADIN = {
			[1] = (E.Retail and GetSpellInfo(select(4,GetShapeshiftFormInfo(1)))) or GetSpellInfo(465),
			[2] = (E.Retail and GetSpellInfo(select(4,GetShapeshiftFormInfo(2)))) or GetSpellInfo(7294),
			[3] = (E.Retail and GetSpellInfo(select(4,GetShapeshiftFormInfo(3)))) or GetSpellInfo(19746),
			[4] = (E.Retail and GetSpellInfo(select(4,GetShapeshiftFormInfo(4)))) or GetSpellInfo(19746),
			[5] = not E.Retail and GetSpellInfo(19888),
			[6] = not E.Retail and GetSpellInfo(19891),
			[7] = not E.Retail and GetSpellInfo(32223),
		},
		WARRIOR = {
			[1] = not E.Retail and GetSpellInfo(2457),
			[2] = not E.Retail and GetSpellInfo(71),
			[3] = not E.Retail and GetSpellInfo(2458),
		}
	}
end

local classcolorcast = {
	["DEATHKNIGHT"]	= "FFC41E3A",
	["DEMONHUNTER"]	= "FFA330C9",
	["DRUID"] = "FFFF7C0A",
	["HUNTER"] = "FFAAD372",
	["MAGE"] = "FF3FC7EB",
	["MONK"] = "FF00FF98",
	["PALADIN"]	= "FFF48CBA",
	["PRIEST"] = "FFFFFFFF",
	["ROGUE"] = "FFFFF468",
	["SHAMAN"] = "FF0070DD",
	["WARLOCK"] = "FF8788EE",
	["WARRIOR"] = "FFC69B6D",
	["HOSTILE"] = "FFFF0000",
	["UNFRIENDLY"] = "FFF26000",
	["NEUTRAL"] = "FFE4E400",
	["FRIENDLY"] = "FF33FF33",
	["EVOKER"] = "FF33937F",
}

--difficulty icon is on the classification file to avoid duplicating tables/info

-------------------------------------------------------------------------- NAME -------------------------------------------------------------------------

-- Name custom abbreviation by Azilroka
E:AddTag("name:eltruism:abbreviate", "UNIT_NAME_UPDATE", function(unit)
	local name = UnitName(unit)
	--local name = 'Ецхо оф а Пандарен' --cyrillic name test
	if name and string.len(name) > 16 then
		name = ElvUI_EltreumUI:ShortenString(name, 16)
	end
	return name
end)
E:AddTagInfo('name:eltruism:abbreviate', ElvUI_EltreumUI.Name.." "..L["Names"], L["Abbreviates the unit name once it goes over 16 characters, made by Azilroka"])

-- Abbreviate in 20 chars for Nekator
E:AddTag("name:eltruism:abbreviate20", "UNIT_NAME_UPDATE", function(unit)
	local name = UnitName(unit)
	--local name = 'Ецхо оф а Пандарен' --cyrillic name test
	if name and string.len(name) > 20 then
		name = ElvUI_EltreumUI:ShortenString(name, 20)
	end
	return name
end)
E:AddTagInfo("name:eltruism:abbreviate20", ElvUI_EltreumUI.Name.." "..L["Names"], L["Abbreviates the unit name once it goes over 20 characters, made by Azilroka"])

-- Abbreviate very short due to small raid frames
E:AddTag("name:eltruism:abbreviateshort", "UNIT_NAME_UPDATE", function(unit)
	local name = UnitName(unit)
	--local name = 'Ецхо оф а Пандарен' --cyrillic name test
	if name and string.len(name) > 10 then
		name = E:ShortenString(name, 11)
	end
	return name
end)
E:AddTagInfo("name:eltruism:abbreviateshort", ElvUI_EltreumUI.Name.." "..L["Names"], L["Abbreviates the unit name once it goes over 10 characters"])

--gradient name
E:AddTag("name:eltruism:gradient", "UNIT_NAME_UPDATE", function(unit)
	local name = UnitName(unit)
	local _, unitClass = UnitClass(unit)
	local isTarget = UnitIsUnit(unit,"target") and not unit:match("nameplate") and not unit:match("party")

	if UnitIsPlayer(unit) then
		return ElvUI_EltreumUI:GradientName(name, unitClass,isTarget)
	elseif not UnitIsPlayer(unit) then
		local reaction = UnitReaction(unit, "player")
		if reaction then
			if reaction >= 5 then
				return ElvUI_EltreumUI:GradientName(name, "NPCFRIENDLY", isTarget)
			elseif reaction == 4 then
				return ElvUI_EltreumUI:GradientName(name, "NPCNEUTRAL", isTarget)
			elseif reaction == 3 then
				return ElvUI_EltreumUI:GradientName(name, "NPCUNFRIENDLY", isTarget)
			elseif reaction == 2 or reaction == 1 then
				return ElvUI_EltreumUI:GradientName(name, "NPCHOSTILE", isTarget)
			end
		end
	end
end)
E:AddTagInfo("name:eltruism:gradient", ElvUI_EltreumUI.Name.." "..L["Names"], L["Displays unit name in gradient class color or reaction color"])

--gradient name abbreviate
E:AddTag("name:eltruism:gradientshort", "UNIT_NAME_UPDATE", function(unit,_,args)
	local name = UnitName(unit)
	if not name then return end
	if not args then args = 16 end
	local _, unitClass = UnitClass(unit)
	if string.len(name) > tonumber(args) then --first for npcs with multiple names/titles
		name = ElvUI_EltreumUI:ShortenString(name, tonumber(args))
	end
	local isTarget = UnitIsUnit(unit,"target") and not unit:match("nameplate") and not unit:match("party")
	if string.len(name) > tonumber(args) then --second for players
		name = E:ShortenString(name, tonumber(args))
	end

	if UnitIsPlayer(unit) then
		return ElvUI_EltreumUI:GradientName(name, unitClass, isTarget)
	elseif not UnitIsPlayer(unit) then
		local reaction = UnitReaction(unit, "player")
		if reaction then
			if reaction >= 5 then
				return ElvUI_EltreumUI:GradientName(name, "NPCFRIENDLY", isTarget)
			elseif reaction == 4 then
				return ElvUI_EltreumUI:GradientName(name, "NPCNEUTRAL", isTarget)
			elseif reaction == 3 then
				return ElvUI_EltreumUI:GradientName(name, "NPCUNFRIENDLY", isTarget)
			elseif reaction == 2 or reaction == 1 then
				return ElvUI_EltreumUI:GradientName(name, "NPCHOSTILE", isTarget)
			end
		end
	end
end)
E:AddTagInfo("name:eltruism:gradientshort", ElvUI_EltreumUI.Name.." "..L["Names"], L["Displays unit name in gradient class color or reaction color, shortens over 16 characters"])

--gradient name in caps
E:AddTag("name:eltruism:gradientcaps", "UNIT_NAME_UPDATE", function(unit)
	local name = string.upper(UnitName(unit))
	local _, unitClass = UnitClass(unit)
	local isTarget = UnitIsUnit(unit,"target") and not unit:match("nameplate") and not unit:match("party")

	if UnitIsPlayer(unit) then
		return ElvUI_EltreumUI:GradientName(name, unitClass,isTarget)
	elseif not UnitIsPlayer(unit) then
		local reaction = UnitReaction(unit, "player")
		if reaction then
			if reaction >= 5 then
				return ElvUI_EltreumUI:GradientName(name, "NPCFRIENDLY", isTarget)
			elseif reaction == 4 then
				return ElvUI_EltreumUI:GradientName(name, "NPCNEUTRAL", isTarget)
			elseif reaction == 3 then
				return ElvUI_EltreumUI:GradientName(name, "NPCUNFRIENDLY", isTarget)
			elseif reaction == 2 or reaction == 1 then
				return ElvUI_EltreumUI:GradientName(name, "NPCHOSTILE", isTarget)
			end
		end
	end
end)
E:AddTagInfo("name:eltruism:gradientcaps", ElvUI_EltreumUI.Name.." "..L["Names"], L["Displays unit name in gradient class color or reaction color"])

--gradient name abbreviate in caps
E:AddTag("name:eltruism:gradientshortcaps", "UNIT_NAME_UPDATE", function(unit,_,args)
	local name = string.upper(UnitName(unit))
	if not name then return end
	if not args then args = 16 end
	local _, unitClass = UnitClass(unit)
	if string.len(name) > tonumber(args) then --first for npcs with multiple names/titles
		name = ElvUI_EltreumUI:ShortenString(name, tonumber(args))
	end
	local isTarget = UnitIsUnit(unit,"target") and not unit:match("nameplate") and not unit:match("party")
	if string.len(name) > tonumber(args) then --second for players
		name = E:ShortenString(name, tonumber(args))
	end

	if UnitIsPlayer(unit) then
		return ElvUI_EltreumUI:GradientName(name, unitClass, isTarget)
	elseif not UnitIsPlayer(unit) then
		local reaction = UnitReaction(unit, "player")
		if reaction then
			if reaction >= 5 then
				return ElvUI_EltreumUI:GradientName(name, "NPCFRIENDLY", isTarget)
			elseif reaction == 4 then
				return ElvUI_EltreumUI:GradientName(name, "NPCNEUTRAL", isTarget)
			elseif reaction == 3 then
				return ElvUI_EltreumUI:GradientName(name, "NPCUNFRIENDLY", isTarget)
			elseif reaction == 2 or reaction == 1 then
				return ElvUI_EltreumUI:GradientName(name, "NPCHOSTILE", isTarget)
			end
		end
	end
end)
E:AddTagInfo("name:eltruism:gradientshortcaps", ElvUI_EltreumUI.Name.." "..L["Names"], L["Displays unit name in gradient class color or reaction color, shortens over 16 characters"])

--gradient name translit
E:AddTag("name:eltruism:gradienttranslit", "UNIT_NAME_UPDATE", function(unit,_,args)
	local targetName = UnitName(unit)
	local name = Translit:Transliterate(targetName)
	if not name then return end
	local _, unitClass = UnitClass(unit)
	local isTarget = UnitIsUnit(unit,"target") and not unit:match("nameplate") and not unit:match("party")
	if args then
		if string.len(name) > tonumber(args) then --first for npcs with multiple names/titles
			name = ElvUI_EltreumUI:ShortenString(name, tonumber(args))
		end
		if string.len(name) > tonumber(args) then --second for players
			name = E:ShortenString(name, tonumber(args))
		end
	end

	if UnitIsPlayer(unit) then
		return ElvUI_EltreumUI:GradientName(name, unitClass, isTarget)
	elseif not UnitIsPlayer(unit) then
		local reaction = UnitReaction(unit, "player")
		if reaction then
			if reaction >= 5 then
				return ElvUI_EltreumUI:GradientName(name, "NPCFRIENDLY", isTarget)
			elseif reaction == 4 then
				return ElvUI_EltreumUI:GradientName(name, "NPCNEUTRAL", isTarget)
			elseif reaction == 3 then
				return ElvUI_EltreumUI:GradientName(name, "NPCUNFRIENDLY", isTarget)
			elseif reaction == 2 or reaction == 1 then
				return ElvUI_EltreumUI:GradientName(name, "NPCHOSTILE", isTarget)
			end
		end
	end
end)
E:AddTagInfo("name:eltruism:gradienttranslit", ElvUI_EltreumUI.Name.." "..L["Names"], L["Displays unit name in gradient class color or reaction color"])

--gradient name abbreviate translit
E:AddTag("name:eltruism:gradientshorttranslit", "UNIT_NAME_UPDATE", function(unit)
	local targetName = UnitName(unit)
	local name = Translit:Transliterate(targetName)
	local _, unitClass = UnitClass(unit)
	if name and string.len(name) > 16 then
		name = ElvUI_EltreumUI:ShortenString(name, 16)
	end
	local isTarget = UnitIsUnit(unit,"target") and not unit:match("nameplate") and not unit:match("party")

	if UnitIsPlayer(unit) then
		return ElvUI_EltreumUI:GradientName(name, unitClass, isTarget)
	elseif not UnitIsPlayer(unit) then
		local reaction = UnitReaction(unit, "player")
		if reaction then
			if reaction >= 5 then
				return ElvUI_EltreumUI:GradientName(name, "NPCFRIENDLY", isTarget)
			elseif reaction == 4 then
				return ElvUI_EltreumUI:GradientName(name, "NPCNEUTRAL", isTarget)
			elseif reaction == 3 then
				return ElvUI_EltreumUI:GradientName(name, "NPCUNFRIENDLY", isTarget)
			elseif reaction == 2 or reaction == 1 then
				return ElvUI_EltreumUI:GradientName(name, "NPCHOSTILE", isTarget)
			end
		end
	end
end)
E:AddTagInfo("name:eltruism:gradientshorttranslit", ElvUI_EltreumUI.Name.." "..L["Names"], L["Displays unit name in gradient class color or reaction color, shortens over 16 characters"])

E:AddTag('eltruismname:title', 'UNIT_NAME_UPDATE INSTANCE_ENCOUNTER_ENGAGE_UNIT', function(unit)
	local name = UnitName(unit)
	local _, unitClass = UnitClass(unit)

	if UnitIsPlayer(unit) then
		return ElvUI_EltreumUI:GradientName(UnitPVPName(unit), unitClass)
	elseif not UnitIsPlayer(unit) then
		local reaction = UnitReaction(unit, "player")
		if reaction then
			if reaction >= 5 then
				return ElvUI_EltreumUI:GradientName(name, "NPCFRIENDLY")
			elseif reaction == 4 then
				return ElvUI_EltreumUI:GradientName(name, "NPCNEUTRAL")
			elseif reaction == 3 then
				return ElvUI_EltreumUI:GradientName(name, "NPCUNFRIENDLY")
			elseif reaction == 2 or reaction == 1 then
				return ElvUI_EltreumUI:GradientName(name, "NPCHOSTILE")
			end
		end
	end
end)
E:AddTagInfo("eltruismname:title", ElvUI_EltreumUI.Name.." "..L["Names"], L["Displays name and title"])

E:AddTag('eltruismguild:brackets', 'PLAYER_GUILD_UPDATE', function(unit)
	local guildName = GetGuildInfo(unit)
	if guildName then
		local _, unitClass = UnitClass(unit)
		guildName = format('<%s>', guildName)
		return ElvUI_EltreumUI:GradientName(guildName, unitClass)
	end
end)
E:AddTagInfo("eltruismguild:brackets", ElvUI_EltreumUI.Name.." "..L["Names"], L["Displays the guild name with brackets in gradient"])

E:AddTag('eltruismrealm:dash', 'UNIT_NAME_UPDATE', function(unit)
	local _, realm = UnitName(unit)
	local _, unitClass = UnitClass(unit)
	if realm and unitClass then
		if realm ~= '' then
			if realm ~= E.myrealm then
				realm = format('-%s', realm)
				return ElvUI_EltreumUI:GradientName(realm, unitClass)
			end
		end
	end
end)
E:AddTagInfo("eltruismrealm:dash", ElvUI_EltreumUI.Name.." "..L["Names"], L["Displays the server name with a dash in gradient"])


--gradient name default colors
E:AddTag("name:eltruism:gradientdefaultcolors", "UNIT_NAME_UPDATE", function(unit)
	local name = UnitName(unit)
	local _, unitClass = UnitClass(unit)
	local isTarget = UnitIsUnit(unit,"target") and not unit:match("nameplate") and not unit:match("party")

	if UnitIsPlayer(unit) then
		return ElvUI_EltreumUI:GradientNameDefaultColors(name, unitClass,isTarget)
	elseif not UnitIsPlayer(unit) then
		local reaction = UnitReaction(unit, "player")
		if reaction then
			if reaction >= 5 then
				return ElvUI_EltreumUI:GradientNameDefaultColors(name, "NPCFRIENDLY", isTarget)
			elseif reaction == 4 then
				return ElvUI_EltreumUI:GradientNameDefaultColors(name, "NPCNEUTRAL", isTarget)
			elseif reaction == 3 then
				return ElvUI_EltreumUI:GradientNameDefaultColors(name, "NPCUNFRIENDLY", isTarget)
			elseif reaction == 2 or reaction == 1 then
				return ElvUI_EltreumUI:GradientNameDefaultColors(name, "NPCHOSTILE", isTarget)
			end
		end
	end
end)
E:AddTagInfo("name:eltruism:gradientdefaultcolors", ElvUI_EltreumUI.Name.." "..L["Names"], L["Displays unit name in gradient class color or reaction color"])

--gradient name abbreviate default colors
E:AddTag("name:eltruism:gradientdefaultcolorsshort", "UNIT_NAME_UPDATE", function(unit)
	local name = UnitName(unit)
	local _, unitClass = UnitClass(unit)
	if name and string.len(name) > 16 then
		name = ElvUI_EltreumUI:ShortenString(name, 16)
	end
	local isTarget = UnitIsUnit(unit,"target") and not unit:match("nameplate") and not unit:match("party")

	if UnitIsPlayer(unit) then
		return ElvUI_EltreumUI:GradientNameDefaultColors(name, unitClass, isTarget)
	elseif not UnitIsPlayer(unit) then
		local reaction = UnitReaction(unit, "player")
		if reaction then
			if reaction >= 5 then
				return ElvUI_EltreumUI:GradientNameDefaultColors(name, "NPCFRIENDLY", isTarget)
			elseif reaction == 4 then
				return ElvUI_EltreumUI:GradientNameDefaultColors(name, "NPCNEUTRAL", isTarget)
			elseif reaction == 3 then
				return ElvUI_EltreumUI:GradientNameDefaultColors(name, "NPCUNFRIENDLY", isTarget)
			elseif reaction == 2 or reaction == 1 then
				return ElvUI_EltreumUI:GradientNameDefaultColors(name, "NPCHOSTILE", isTarget)
			end
		end
	end
end)
E:AddTagInfo("name:eltruism:gradientdefaultcolorsshort", ElvUI_EltreumUI.Name.." "..L["Names"], L["Displays unit name in gradient class color or reaction color, shortens over 16 characters"])

-------------------------------------------------------------------------- ICONS -------------------------------------------------------------------------

--show class icons on all targets
E:AddTag("eltruism:class:all", "UNIT_NAME_UPDATE", function(unit)
	local _ , classes = UnitClass(unit)
	return ElvUI_EltreumUI:GetClassIcons("RELEAF",classes)
end)
E:AddTagInfo('eltruism:class:all', ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\"..tostring(fileclass).."Releaf.tga:0:0:0:0|t "..L["Shows Class Icons recolored by Releaf on all targets"])

--show class icons only on players, ty repooc!
E:AddTag("eltruism:class:player", "UNIT_NAME_UPDATE", function(unit)
	if not UnitIsPlayer(unit) then return end
	local _ , classes = UnitClass(unit)
	return ElvUI_EltreumUI:GetClassIcons("RELEAF",classes)
end)
E:AddTagInfo('eltruism:class:player', ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\"..tostring(fileclass).."Releaf.tga:0:0:0:0|t "..L["Shows Class Icons recolored by Releaf on Player targets"])

--alternate class icons on all targets
E:AddTag("eltruism:blizz:all", "UNIT_NAME_UPDATE", function(unit)
	local _ , classes = UnitClass(unit)
	return ElvUI_EltreumUI:GetClassIcons("BLIZZARD",classes)
end)
E:AddTagInfo('eltruism:blizz:all', ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\"..tostring(fileclass)..".tga:0:0:0:0|t "..L["Shows Class Icons by Blizzard on all targets"])

--alternate class icons on players
E:AddTag("eltruism:blizz:player", "UNIT_NAME_UPDATE", function(unit)
	if not UnitIsPlayer(unit) then return end
	local _ , classes = UnitClass(unit)
	return ElvUI_EltreumUI:GetClassIcons("BLIZZARD",classes)
end)
E:AddTagInfo('eltruism:blizz:player', ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\"..tostring(fileclass)..".tga:0:0:0:0|t "..L["Shows Class Icons by Blizzard only on Player targets"])

--alternate class icons on all targets
E:AddTag("eltruism:ReleafBorder:all", "UNIT_NAME_UPDATE", function(unit)
	local _ , classes = UnitClass(unit)
	return ElvUI_EltreumUI:GetClassIcons("BORDER",classes)
end)
E:AddTagInfo('eltruism:ReleafBorder:all', ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\"..tostring(fileclass).."IconReleaf.tga:0:0:0:0|t "..L["Shows Class Icons with borders recolored by Releaf on all targets"])

--alternate class icons on players
E:AddTag("eltruism:ReleafBorder:player", "UNIT_NAME_UPDATE", function(unit)
	if not UnitIsPlayer(unit) then return end
	local _ , classes = UnitClass(unit)
	return ElvUI_EltreumUI:GetClassIcons("BORDER",classes)
end)
E:AddTagInfo('eltruism:ReleafBorder:player', ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\"..tostring(fileclass).."IconReleaf.tga:0:0:0:0|t "..L["Shows Class Icons with borders recolored by Releaf on Player targets"])

--class icons with outlines on all targets
E:AddTag("eltruism:IconOutline:all", "UNIT_NAME_UPDATE", function(unit)
	local _ , classes = UnitClass(unit)
	return ElvUI_EltreumUI:GetClassIcons("SHADOW",classes)
end)
E:AddTagInfo("eltruism:IconOutline:all", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\"..tostring(fileclass).."Shadow.tga:0:0:0:0|t ".."Shows Class Icons with Outlines all targets")

--class icons with otlines on players
E:AddTag("eltruism:IconOutline:player", "UNIT_NAME_UPDATE", function(unit)
	if not UnitIsPlayer(unit) then return end
	local _ , classes = UnitClass(unit)
	return ElvUI_EltreumUI:GetClassIcons("SHADOW",classes)
end)
E:AddTagInfo("eltruism:IconOutline:player", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\"..tostring(fileclass).."Shadow.tga:0:0:0:0|t ".."Shows Class Icons with Outlines on Player targets")

--class icons with outlines on all targets
E:AddTag("eltruism:ReleafIconOutline:all", "UNIT_NAME_UPDATE", function(unit)
	local _ , classes = UnitClass(unit)
	return ElvUI_EltreumUI:GetClassIcons("OUTLINE",classes)
end)
E:AddTagInfo("eltruism:ReleafIconOutline:all", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\"..tostring(fileclass).."1.tga:0:0:0:0|t ".."Shows Class Icons with Outlines by Releaf all targets")

--class icons with otlines on players
E:AddTag("eltruism:ReleafIconOutline:player", "UNIT_NAME_UPDATE", function(unit)
	if not UnitIsPlayer(unit) then return end
	local _ , classes = UnitClass(unit)
	return ElvUI_EltreumUI:GetClassIcons("OUTLINE",classes)
end)
E:AddTagInfo("eltruism:ReleafIconOutline:player", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\"..tostring(fileclass).."1.tga:0:0:0:0|t ".."Shows Class Icons with Outlines by Releaf on Player targets")

--show class icons on all targets
E:AddTag("eltruism:reverseclass:all", "UNIT_NAME_UPDATE", function(unit)
	local _ , classes = UnitClass(unit)
	return ElvUI_EltreumUI:GetClassIcons("RELEAF",classes,true)
end)
E:AddTagInfo('eltruism:reverseclass:all', ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\"..tostring(fileclass).."Releaf.tga:0:0:0:0:64:64:64:0:0:64|t "..L["Shows Flipped Class Icons recolored by Releaf on all targets"])

--show class icons only on players, ty repooc!
E:AddTag("eltruism:reverseclass:player", "UNIT_NAME_UPDATE", function(unit)
	if not UnitIsPlayer(unit) then return end
	local _ , classes = UnitClass(unit)
	return ElvUI_EltreumUI:GetClassIcons("RELEAF",classes,true)
end)
E:AddTagInfo('eltruism:reverseclass:player', ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\"..tostring(fileclass).."Releaf.tga:0:0:0:0:64:64:64:0:0:64|t "..L["Shows Flipped Class Icons recolored by Releaf on Player targets"])

--alternate class icons on all targets
E:AddTag("eltruism:reverseblizz:all", "UNIT_NAME_UPDATE", function(unit)
	local _ , classes = UnitClass(unit)
	return ElvUI_EltreumUI:GetClassIcons("BLIZZARD",classes,true)
end)
E:AddTagInfo('eltruism:reverseblizz:all', ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\"..tostring(fileclass)..".tga:0:0:0:0:64:64:64:0:0:64|t "..L["Shows Flipped Class Icons by Blizzard on all targets"])

--alternate class icons on players
E:AddTag("eltruism:reverseblizz:player", "UNIT_NAME_UPDATE", function(unit)
	if not UnitIsPlayer(unit) then return end
	local _ , classes = UnitClass(unit)
	return ElvUI_EltreumUI:GetClassIcons("BLIZZARD",classes,true)
end)
E:AddTagInfo('eltruism:reverseblizz:player', ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\"..tostring(fileclass)..".tga:0:0:0:0:64:64:64:0:0:64|t "..L["Shows Flipped Class Icons by Blizzard only on Player targets"])

--alternate class icons on all targets
E:AddTag("eltruism:reverseReleafBorder:all", "UNIT_NAME_UPDATE", function(unit)
	local _ , classes = UnitClass(unit)
	return ElvUI_EltreumUI:GetClassIcons("BORDER",classes,true)
end)
E:AddTagInfo('eltruism:reverseReleafBorder:all', ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\"..tostring(fileclass).."IconReleaf.tga:0:0:0:0:64:64:64:0:0:64|t "..L["Shows Flipped Class Icons with borders recolored by Releaf on all targets"])

--alternate class icons on players
E:AddTag("eltruism:reverseReleafBorder:player", "UNIT_NAME_UPDATE", function(unit)
	if not UnitIsPlayer(unit) then return end
	local _ , classes = UnitClass(unit)
	return ElvUI_EltreumUI:GetClassIcons("BORDER",classes,true)
end)
E:AddTagInfo('eltruism:reverseReleafBorder:player', ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\"..tostring(fileclass).."IconReleaf.tga:0:0:0:0:64:64:64:0:0:64|t "..L["Shows Flipped Class Icons with borders recolored by Releaf on Player targets"])

--class icons with outlines on all targets
E:AddTag("eltruism:reverseIconOutline:all", "UNIT_NAME_UPDATE", function(unit)
	local _ , classes = UnitClass(unit)
	return ElvUI_EltreumUI:GetClassIcons("SHADOW",classes,true)
end)
E:AddTagInfo("eltruism:reverseIconOutline:all", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\"..tostring(fileclass).."Shadow.tga:0:0:0:0:64:64:64:0:0:64|t ".."Shows Flipped Class Icons with Outlines all targets")

--class icons with otlines on players
E:AddTag("eltruism:reverseIconOutline:player", "UNIT_NAME_UPDATE", function(unit)
	if not UnitIsPlayer(unit) then return end
	local _ , classes = UnitClass(unit)
	return ElvUI_EltreumUI:GetClassIcons("SHADOW",classes,true)
end)
E:AddTagInfo("eltruism:reverseIconOutline:player", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\"..tostring(fileclass).."Shadow.tga:0:0:0:0:64:64:64:0:0:64|t ".."Shows Flipped Class Icons with Outlines on Player targets")

--class icons with outlines on all targets
E:AddTag("eltruism:reverseReleafIconOutline:all", "UNIT_NAME_UPDATE", function(unit)
	local _ , classes = UnitClass(unit)
	return ElvUI_EltreumUI:GetClassIcons("OUTLINE",classes,true)
end)
E:AddTagInfo("eltruism:reverseReleafIconOutline:all", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\"..tostring(fileclass).."1.tga:0:0:0:0:64:64:64:0:0:64|t ".."Shows Flipped Class Icons with Outlines by Releaf all targets")

--class icons with outlines on players
E:AddTag("eltruism:reverseReleafIconOutline:player", "UNIT_NAME_UPDATE", function(unit)
	if not UnitIsPlayer(unit) then return end
	local _ , classes = UnitClass(unit)
	return ElvUI_EltreumUI:GetClassIcons("OUTLINE",classes,true)
end)
E:AddTagInfo("eltruism:reverseReleafIconOutline:player", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\"..tostring(fileclass).."1.tga:0:0:0:0:64:64:64:0:0:64|t ".."Shows Flipped Class Icons with Outlines by Releaf on Player targets")

--gradient releaf icons
E:AddTag("eltruism:Releafgradient:player", "UNIT_NAME_UPDATE", function(unit)
	if not UnitIsPlayer(unit) then return end
	local _,englishClass = UnitClass(unit)
	return ElvUI_EltreumUI:GetClassIcons("GRADIENT",englishClass)
end)
E:AddTagInfo("eltruism:Releafgradient:player", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\"..tostring(fileclass).."Gradient.tga:0:0:0:0|t ".."Shows Releaf Icons with Gradient Colors")

--gradient releaf icons reversed
E:AddTag("eltruism:reverseReleafgradient:player", "UNIT_NAME_UPDATE", function(unit)
	if not UnitIsPlayer(unit) then return end
	local _,englishClass = UnitClass(unit)
	return ElvUI_EltreumUI:GetClassIcons("GRADIENT",englishClass,true)
end)
E:AddTagInfo("eltruism:reverseReleafgradient:player", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\"..tostring(fileclass).."Gradient.tga:0:0:0:0:64:64:64:0:0:64|t ".."Shows Reversed Releaf Icons with Gradient Colors")

--new class symbols
E:AddTag("eltruism:classSymbols:player", "UNIT_NAME_UPDATE", function(unit)
	if not UnitIsPlayer(unit) then return end
	local _,englishClass = UnitClass(unit)
	return ElvUI_EltreumUI:GetClassIcons("SYMBOLS",englishClass)
end)
E:AddTagInfo("eltruism:classSymbols:player", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\"..tostring(fileclass)..".tga:0:0:0:0|t ".."Shows Eltruism Class Symbol")

--gradient releaf icons for all
E:AddTag("eltruism:Releafgradient:all", "UNIT_NAME_UPDATE", function(unit)
	local _,englishClass = UnitClass(unit)
	return ElvUI_EltreumUI:GetClassIcons("GRADIENT",englishClass)
end)
E:AddTagInfo("eltruism:Releafgradient:all", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\"..tostring(fileclass)..".tga:0:0:0:0|t ".."Shows Releaf Icons with Gradient Colors for All")

--gradient releaf icons reversed for all
E:AddTag("eltruism:reverseReleafgradient:all", "UNIT_NAME_UPDATE", function(unit)
	local _,englishClass = UnitClass(unit)
	return ElvUI_EltreumUI:GetClassIcons("GRADIENT",englishClass,true)
end)
E:AddTagInfo("eltruism:reverseReleafgradient:all", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\"..tostring(fileclass).."Gradient.tga:0:0:0:0:64:64:64:0:0:64|t ".."Shows Reversed Releaf Icons with Gradient Colors for All")

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
E:AddTagInfo("releaf", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\releaftag.tga:0:0:0:3|t ".."Shows Releaf's Icon")

-- Target Marker tag
E:AddTag("eltruism:raidmarker", 'RAID_TARGET_UPDATE', function(unit)
	local index = GetRaidTargetIndex(unit)
	local mark
	if index then
		mark = "|TINTERFACE\\TARGETINGFRAME\\UI-RaidTargetingIcon_"..index..".blp:0:0:0:0|t"
	end
	return mark
end)
E:AddTagInfo("eltruism:raidmarker", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TINTERFACE\\TARGETINGFRAME\\UI-RaidTargetingIcon_1.blp:0:0:0:0|t".." "..L["Shows raid target marker"])

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
E:AddTagInfo("eltruism:levelskull", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\TARGETINGFRAME\\UI-TARGETINGFRAME-SKULL.BLP:0:0:0:0|t "..L["Shows the Unit Level, or a skull if the level is too high"])

E:AddTag("eltruism:levelskull2", "UNIT_TARGET UNIT_NAME_UPDATE", function(unit)
	local level
	if E.Retail then
		level = UnitEffectiveLevel(unit)
	else
		level = UnitLevel(unit)
	end
	local diff = level - UnitLevel("player")
	local classification = UnitClassification(unit)
	if diff > 8 or classification == "worldboss" then
		return "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\skull10.tga:0:0:0:0|t"
	else
		return level
	end
end)
E:AddTagInfo("eltruism:levelskull2", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\skull10.tga:0:0:0:0|t "..L["Shows the Unit Level, or a skull if the level is too high"])

--Short classification, but with a skull for boss instead of B for Nekator
E:AddTag("eltruism:shortclassification", "UNIT_NAME_UPDATE", function(unit)
	local c = UnitClassification(unit)
		if(c == 'rare') then
			return 'R'
		elseif(c == 'rareelite') then
			return 'R+'
		elseif(c == 'elite') then
			return '+'
		elseif(c == 'worldboss') then
			return "|TInterface\\TARGETINGFRAME\\UI-TARGETINGFRAME-SKULL.BLP:0:0:0:0|t"
		elseif(c == 'minus') then
			return '-'
		end
end)
E:AddTagInfo("eltruism:shortclassification", ElvUI_EltreumUI.Name.." "..L["Icons"], L["Displays the unit's classification in short form (e.g. '+' for ELITE and 'R' for RARE and a Skull for Boss)"])

--Tag for dead based on elvui tag for health with user input
E:AddTag("eltruism:dead", "UNIT_HEALTH", function(unit)
	if UnitIsDead(unit) and UnitIsPlayer(unit) then
		if E.db.ElvUI_EltreumUI.otherstuff.deadtagicon ~= "NONE" then
			return "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Dead\\dead"..tostring(E.db.ElvUI_EltreumUI.otherstuff.deadtagicon)..".tga:0:0:0:0|t"
		else
			return L["Dead"]
		end
	elseif UnitIsGhost(unit) then
		if E.db.ElvUI_EltreumUI.otherstuff.ghosttagicon ~= "NONE" then
			return "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Ghost\\ghost"..tostring(E.db.ElvUI_EltreumUI.otherstuff.ghosttagicon)..".tga:0:0:0:0|t"
		else
			return GetSpellInfo(8326)
		end
	end
end)
E:AddTagInfo("eltruism:dead", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Dead\\dead1.tga:0:0:0:0|t "..L["Displays a dead symbol when unit is dead. Can be customized in Eltruism > Media"])

--Tag for dc based on elvui tag for health
E:AddTag("eltruism:dc", "UNIT_CONNECTION", function(unit)
	if UnitIsConnected(unit) == false and UnitIsPlayer(unit) then
		if E.db.ElvUI_EltreumUI.otherstuff.dctagicon ~= "NONE" then
			return "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Disconnect\\dc"..tostring(E.db.ElvUI_EltreumUI.otherstuff.dctagicon)..".tga:0:0:0:0|t"
		else
			return L["Dead"]
		end
	end
end)
E:AddTagInfo("eltruism:dc", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Disconnect\\dc1.tga:0:0:0:0|t ".. L["Displays a disconnect symbol when unit is disconnected. Can be customized in Eltruism > Media"])

E:AddTag("eltruism:leader", "GROUP_ROSTER_UPDATE", function(unit)
	local leader = UnitIsGroupLeader(unit)
	local assist = UnitIsGroupAssistant(unit)
	local isTank = GetPartyAssignment("MAINTANK", unit)
	local isMainAssist = GetPartyAssignment("MAINASSIST", unit)
	if leader and not assist and not isTank and not isMainAssist then
		return "|TInterface\\GROUPFRAME\\UI-GROUP-LEADERICON.BLP:0:0:0:0|t"
	elseif assist and not leader and not isTank and not isMainAssist then
		return "|TInterface\\GROUPFRAME\\UI-GROUP-ASSISTANTICON.BLP:0:0:0:0|t"
	elseif isTank and isMainAssist and not leader and not assist then
		return "|TInterface\\GROUPFRAME\\UI-GROUP-MAINTANKICON.BLP:0:0:0:0|t".."|TInterface\\GROUPFRAME\\UI-GROUP-MAINASSISTICON.BLP:0:0:0:0|t"
	elseif isTank and not isMainAssist and not leader and not assist then
		return "|TInterface\\GROUPFRAME\\UI-GROUP-MAINTANKICON.BLP:0:0:0:0|t"
	elseif isMainAssist and not isTank and not leader and not assist then
		return "|TInterface\\GROUPFRAME\\UI-GROUP-MAINASSISTICON.BLP:0:0:0:0|t"
	elseif leader and isTank then
		return "|TInterface\\GROUPFRAME\\UI-GROUP-LEADERICON.BLP:0:0:0:0|t".."|TInterface\\GROUPFRAME\\UI-GROUP-MAINTANKICON.BLP:0:0:0:0|t"
	elseif assist and isTank and not isMainAssist and not leader then
		return "|TInterface\\GROUPFRAME\\UI-GROUP-ASSISTANTICON.BLP:0:0:0:0|t".."|TInterface\\GROUPFRAME\\UI-GROUP-MAINTANKICON.BLP:0:0:0:0|t"
	end
end)
E:AddTagInfo("eltruism:leader", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\GROUPFRAME\\UI-GROUP-LEADERICON.BLP:0:0:0:0|t "..L["Shows the Leader Icon or Assist icon if the unit is Leader or Assist"])

E:AddTag("eltruism:leader:emoji", "GROUP_ROSTER_UPDATE", function(unit)
	local leader = UnitIsGroupLeader(unit)
	if leader then
		return "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Leader\\Leader1.tga:0:0:0:0|t"
	end
end)
E:AddTagInfo("eltruism:leader:emoji", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Leader\\Leader1.tga:0:0:0:0|t"..L["Shows the Leader Icon as an Emoji Crown"])

--combat icon idea for other units
E:AddTag("eltruism:combatindicator", 'UNIT_HEALTH', function(unit)
	local texture = E.db["unitframe"]["units"]["player"]["CombatIcon"]["texture"]
	if UnitAffectingCombat(unit) then
		if texture == "DEFAULT" then
			return "|TInterface\\CharacterFrame\\UI-StateIcon:0:0:0:0:64:64:34:59:6:29|t"
		elseif texture == "PLATINUM" then
			return "|TInterface\\Challenges\\ChallengeMode_Medal_Platinum:0:0:0:0|t"
		elseif texture == "ATTACK" then
			return "|TInterface\\CURSOR\\Attack:0:0:0:0|t"
		elseif texture == "ALERT" then
			return "|TInterface\\DialogFrame\\UI-Dialog-Icon-AlertNew:0:0:0:0|t"
		elseif texture == "ALERT2" then
			return "|TInterface\\OptionsFrame\\UI-OptionsFrame-NewFeatureIcon:0:0:0:0|t"
		elseif texture == "ARTHAS" then
			return "|TInterface\\LFGFRAME\\UI-LFR-PORTRAIT:0:0:0:0|t"
		elseif texture == "SKULL" then
			return "|TInterface\\LootFrame\\LootPanel-Icon:0:0:0:0|t"
		elseif texture == "COMBAT" then
			return "|TInterface\\Addons\\ElvUI\\Core\\Media\\Textures\\Combat.tga:0:0:0:0|t"
		else
			return "|TInterface\\CharacterFrame\\UI-StateIcon:0:0:0:0:64:64:34:59:6:29|t"
		end
	end
end)
E:AddTagInfo("eltruism:combatindicator", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\CharacterFrame\\UI-StateIcon:0:0:0:0:64:64:34:59:6:29|t "..L["Displays an icon when the unit is in combat, uses player icon"])

------------------------------------------------------------------------- HEALTH ------------------------------------------------------------------------
if not E.Retail then
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
	E:AddTagInfo("eltruism:effectivehp", ElvUI_EltreumUI.Name.." "..L["Health"], L["Shows Effective Health"])
end

--HP tag that switches to a dead symbol or dc symbol depending on the unit status, based on elvui
E:AddTag("eltruism:hpstatus", "UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION PLAYER_FLAGS_CHANGED", function(unit)
	local deadtexture = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Dead\\dead"..tostring(E.db.ElvUI_EltreumUI.otherstuff.hpstatusdeadicon)..".tga:0:0:0:0|t"
	local dctexture = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Disconnect\\dc"..tostring(E.db.ElvUI_EltreumUI.otherstuff.hpstatusdcicon)..".tga:0:0:0:0|t"
	if not UnitIsPlayer(unit) then --npc
		if not UnitIsDead(unit) then
			local min, max = UnitHealth(unit), UnitHealthMax(unit)
			return E:GetFormattedText('CURRENT_PERCENT', min, max, nil, true)
		else
			if E.db.ElvUI_EltreumUI.otherstuff.hpstatusdeadicon ~= "NONE" then
				return deadtexture
			else
				return L["Dead"]
			end
		end
	else
		if not UnitIsDead(unit) and not UnitIsGhost(unit) then --players
			local min, max = UnitHealth(unit), UnitHealthMax(unit)
			return E:GetFormattedText('CURRENT_PERCENT', min, max, nil, true)
		elseif UnitIsDead(unit) and UnitIsConnected(unit) and not UnitIsGhost(unit) then
			if E.db.ElvUI_EltreumUI.otherstuff.hpstatusdeadicon ~= "NONE" then
				return deadtexture
			else
				return L["Dead"]
			end
		elseif not UnitIsDead(unit) and not UnitIsConnected(unit) then
			if E.db.ElvUI_EltreumUI.otherstuff.hpstatusdcicon ~= "NONE" then
				return dctexture
			else
				return L["Offline"]
			end
		elseif UnitIsDead(unit) and not UnitIsConnected(unit) and not UnitIsGhost(unit) then
			if E.db.ElvUI_EltreumUI.otherstuff.hpstatusdcicon ~= "NONE" then
				return dctexture
			else
				return L["Offline"]
			end
		elseif UnitIsGhost(unit) then
			if E.db.ElvUI_EltreumUI.otherstuff.ghosttagicon ~= "NONE" then
				return "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Ghost\\ghost"..tostring(E.db.ElvUI_EltreumUI.otherstuff.ghosttagicon)..".tga:0:0:0:0|t"
			else
				return GetSpellInfo(8326)
			end
		end
	end
end)
E:AddTagInfo("eltruism:hpstatus", ElvUI_EltreumUI.Name.." "..L["Health"], L["Displays HP - % and a status symbol. Can be customized in Eltruism > Media"])

--no percentage value of other HP tag that switches to a dead symbol or dc symbol depending on the unit status, based on elvui
E:AddTag("eltruism:hpstatusnopc", "UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION PLAYER_FLAGS_CHANGED", function(unit)
	local deadtexture = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Dead\\dead"..tostring(E.db.ElvUI_EltreumUI.otherstuff.hpstatusdeadicon)..".tga:0:0:0:0|t"
	local dctexture = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Disconnect\\dc"..tostring(E.db.ElvUI_EltreumUI.otherstuff.hpstatusdcicon)..".tga:0:0:0:0|t"
	if not UnitIsPlayer(unit) then --npc
		if not UnitIsDead(unit) then
			return E:ShortValue(UnitHealth(unit), tostring(E.db.general.decimalLength or 1))
		else
			if E.db.ElvUI_EltreumUI.otherstuff.hpstatusdeadicon ~= "NONE" then
				return deadtexture
			else
				return L["Dead"]
			end
		end
	else
		if not UnitIsDead(unit) and not UnitIsGhost(unit) then --players
			return E:ShortValue(UnitHealth(unit), tostring(E.db.general.decimalLength or 1))
		elseif UnitIsDead(unit) and UnitIsConnected(unit) and not UnitIsGhost(unit) then
			if E.db.ElvUI_EltreumUI.otherstuff.hpstatusdeadicon ~= "NONE" then
				return deadtexture
			else
				return L["Dead"]
			end
		elseif not UnitIsDead(unit) and not UnitIsConnected(unit) then
			if E.db.ElvUI_EltreumUI.otherstuff.hpstatusdcicon ~= "NONE" then
				return dctexture
			else
				return L["Offline"]
			end
		elseif UnitIsDead(unit) and not UnitIsConnected(unit) and not UnitIsGhost(unit) then
			if E.db.ElvUI_EltreumUI.otherstuff.hpstatusdcicon ~= "NONE" then
				return dctexture
			else
				return L["Offline"]
			end
		elseif UnitIsGhost(unit) then
			if E.db.ElvUI_EltreumUI.otherstuff.ghosttagicon ~= "NONE" then
				return "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Ghost\\ghost"..tostring(E.db.ElvUI_EltreumUI.otherstuff.ghosttagicon)..".tga:0:0:0:0|t"
			else
				return GetSpellInfo(8326)
			end
		end
	end
end)
E:AddTagInfo("eltruism:hpstatusnopc", ElvUI_EltreumUI.Name.." "..L["Health"], L["Displays shortvalue HP and a status symbol from Releaf for players. Usage: [eltruism:hpstatusnopc{number,number}]"])

--health deficit + perhp
E:AddTag("eltruism:hpdeficitpc", "UNIT_HEALTH UNIT_MAXHEALTH UNIT_NAME_UPDATE", function(unit)
	local cur, maxhp = UnitHealth(unit), UnitHealthMax(unit)
	local deficit = maxhp - cur

	if deficit > 0 and cur > 0 then
		return ("-"..E:ShortValue(deficit).." | "..E:GetFormattedText('PERCENT', UnitHealth(unit), UnitHealthMax(unit)))
	end
end)
E:AddTagInfo("eltruism:hpdeficitpc", ElvUI_EltreumUI.Name.." "..L["Health"], L["Displays health lost in shortvalue and current health percentage"])

--health deficit + perhp
E:AddTag("eltruism:pchpdeficit", "UNIT_HEALTH UNIT_MAXHEALTH UNIT_NAME_UPDATE", function(unit)
	local cur, maxhp = UnitHealth(unit), UnitHealthMax(unit)
	local deficit = maxhp - cur

	if deficit > 0 and cur > 0 then
		return (E:GetFormattedText('PERCENT', UnitHealth(unit), UnitHealthMax(unit)).." | ".."-"..E:ShortValue(deficit))
	end
end)
E:AddTagInfo("eltruism:pchpdeficit", ElvUI_EltreumUI.Name.." "..L["Health"], L["Displays current health percentage and health lost in shortvalue"])

--perhp with status icons
E:AddTag("eltruism:perhpstatus", "UNIT_HEALTH UNIT_MAXHEALTH UNIT_NAME_UPDATE UNIT_CONNECTION PLAYER_FLAGS_CHANGED", function(unit)
	local deadtexture = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Dead\\dead"..tostring(E.db.ElvUI_EltreumUI.otherstuff.hpstatusdeadicon)..".tga:0:0:0:0|t"
	local dctexture = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Disconnect\\dc"..tostring(E.db.ElvUI_EltreumUI.otherstuff.hpstatusdcicon)..".tga:0:0:0:0|t"
	local cur, maxhp = UnitHealth(unit), UnitHealthMax(unit)
	if (maxhp == 0) then
		return 0
	else
		if not UnitIsDead(unit) and not UnitIsGhost(unit) then
			return math.floor(((cur / maxhp) * 100) + 0.5)
		elseif UnitIsConnected(unit) and not UnitIsGhost(unit) then
			if E.db.ElvUI_EltreumUI.otherstuff.hpstatusdeadicon ~= "NONE" then
				return deadtexture
			else
				return L["Dead"]
			end
		elseif not UnitIsDead(unit) and not UnitIsConnected(unit) then
			if E.db.ElvUI_EltreumUI.otherstuff.hpstatusdcicon ~= "NONE" then
				return dctexture
			else
				return L["Offline"]
			end
		elseif UnitIsDead(unit) and not UnitIsConnected(unit) and not UnitIsGhost(unit) then
			if E.db.ElvUI_EltreumUI.otherstuff.hpstatusdcicon ~= "NONE" then
				return dctexture
			else
				return L["Offline"]
			end
		elseif UnitIsGhost(unit) then
			if E.db.ElvUI_EltreumUI.otherstuff.ghosttagicon ~= "NONE" then
				return "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Ghost\\ghost"..tostring(E.db.ElvUI_EltreumUI.otherstuff.ghosttagicon)..".tga:0:0:0:0|t"
			else
				return GetSpellInfo(8326)
			end
		end
	end
end)
E:AddTagInfo("eltruism:perhpstatus", ElvUI_EltreumUI.Name.." "..L["Health"], L["Displays percentage health with status icons"])
-------------------------------------------------------------------------- OTHER -------------------------------------------------------------------------

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
		if UnitIsEnemy("player", unit) == true then
			if classification ~= "worldboss" then
				if E.Wrath or E.Classic then
					return (eltruismdif[printdifference])
				else
					return
				end
			elseif classification == "worldboss" then
				if E.Wrath or E.Classic then
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
		return (eltruismdif[printdifference])
	elseif classification == "worldboss" then
		return ("|cFFFF0000")
	end
end)
E:AddTagInfo('eltruism:difficulty:all', ElvUI_EltreumUI.Name.." "..L["Miscellaneous"], L["Colors NPC name according to their difficulty compared to the player"])

E:AddTag('eltruism:targetcast', 'UNIT_NAME_UPDATE UNIT_SPELLCAST_START UNIT_TARGET UNIT_SPELLCAST_STOP', function(unit)
	local targetname = UnitName(unit.."target")
	local _ , classes = UnitClass(unit.."target")
	local color = classcolorcast[classes]
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
			if reaction >= 5 then
				return ("|c"..classcolorcast["FRIENDLY"]..targetname.."|r")
			elseif reaction == 4 then
				return ("|c"..classcolorcast["NEUTRAL"]..targetname.."|r")
			elseif reaction == 3 then
				return ("|c"..classcolorcast["UNFRIENDLY"]..targetname.."|r")
			elseif reaction == 2 or reaction == 1 then
				return ("|c"..classcolorcast["HOSTILE"]..targetname.."|r")
			end
		end
	end
end)
E:AddTagInfo('eltruism:targetcast', ElvUI_EltreumUI.Name.." "..L["Miscellaneous"], L["Shows Target of Spellcast, does not work for Mouseover casts"])

E:AddTag('eltruism:targetcast:indicator', 'UNIT_NAME_UPDATE UNIT_SPELLCAST_START UNIT_TARGET UNIT_SPELLCAST_STOP', function(unit)
	local targetname = UnitName(unit.."target")
	local _ , classes = UnitClass(unit.."target")
	local color = classcolorcast[classes]

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
			if reaction >= 5 then
				return (TARGET.." > |c"..classcolorcast["FRIENDLY"]..targetname.."|r")
			elseif reaction == 4 then
				return (TARGET.." > |c"..classcolorcast["NEUTRAL"]..targetname.."|r")
			elseif reaction == 3 then
				return (TARGET.." > |c"..classcolorcast["UNFRIENDLY"]..targetname.."|r")
			elseif reaction == 2 or reaction == 1 then
				return (TARGET.." > |c"..classcolorcast["HOSTILE"]..targetname.."|r")
			end
		end
	end
end)
E:AddTagInfo('eltruism:targetcast:indicator', ElvUI_EltreumUI.Name.." "..L["Miscellaneous"], L["Shows Target of Spellcast, does not work for Mouseover casts. Includes a Target > indicator"])

-- Line Break
E:AddTag("eltruism:newline", "UNIT_NAME_UPDATE", function()
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
		if UnitIsPlayer(unit) then
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
E:AddTagInfo("eltruism:stance", ElvUI_EltreumUI.Name.." "..L["Miscellaneous"], L["Shows the current stance"])

if E.Wrath then
	E:AddTag("eltruism:presencecolor", 1, function()
		local stance = GetShapeshiftForm()
		if stance == 1 then
			return "|cFFff4040"..GetSpellInfo(48266).."|r"
		elseif stance == 2 then
			return "|cFF40ffff"..GetSpellInfo(48263).."|r"
		elseif stance == 3 then
			return "|cFF40ff40"..GetSpellInfo(48265).."|r"
		end
	end)
	E:AddTagInfo("eltruism:presencecolor", ElvUI_EltreumUI.Name.." "..L["Miscellaneous"], L["Shows the current presence with color"])
end

--group number only for first member of group (can break if players get moved tho)
E:AddTag("eltruism:groupnumber", "GROUP_ROSTER_UPDATE UNIT_NAME_UPDATE", function(unit)
	if IsInRaid() == true then
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
	if UnitIsPlayer(unit) then
		local _, unitClass = UnitClass(unit)
		local cs = ElvUF.colors.class[unitClass]
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
	if (E.Retail or E.Wrath) and UnitIsUnit("player", unit) then
		local role
		if E.Retail then
			local currentSpec = GetSpecialization()
			if currentSpec ~= nil then
				role = GetSpecializationRole(currentSpec)
			end
		elseif E.Wrath then
			role = GetTalentGroupRole(GetActiveTalentGroup())
		end
		if role == 'HEALER' then
			if (UnitPower("player")/UnitPowerMax("player")) < (tonumber(percentage) * 0.01) then
				if manaspam == false then
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
				if hpspam == false then
					DoEmote("HEALME")
					hpspam = true
				end
			elseif (UnitHealth("player")/UnitHealthMax("player")) < (tonumber(percentage) * 0.01) then
				hpspam = false
			end
		end
	end
end)
E:AddTagInfo("eltruism:lowhealth", ElvUI_EltreumUI.Name.." "..L["Miscellaneous"], L["Plays a voiced emote when you have low health. Usage: [eltruism:lowhealth{1}] as an example of 1%"])

E:AddTag("eltruism:healermana", 'UNIT_POWER_FREQUENT UNIT_MAXPOWER', function(unit)
	local role = UnitGroupRolesAssigned(unit)
	if role and role == 'HEALER' then
		return math.floor((UnitPower(unit, Enum.PowerType.Mana)/UnitPowerMax(unit, Enum.PowerType.Mana))*100)
	end
end)
E:AddTagInfo("eltruism:healermana", ElvUI_EltreumUI.Name.." "..L["Miscellaneous"], L["Shows mana if the unit is a healer"])
