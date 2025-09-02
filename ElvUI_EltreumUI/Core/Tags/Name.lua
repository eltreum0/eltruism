local E, L = unpack(ElvUI)
local _G = _G
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded
local Translit = E.Libs.Translit
local UnitInPartyIsAI = _G.UnitInPartyIsAI
local UnitIsPlayer = _G.UnitIsPlayer
local UnitAffectingCombat = _G.UnitAffectingCombat
local IsInInstance = _G.IsInInstance
local GetCVarBool = _G.GetCVarBool
local strlower = _G.strlower
local strfind = _G.strfind
local LEVEL = _G.LEVEL
local UnitReaction = _G.UnitReaction
local format = _G.format
local UnitName = _G.UnitName
local UnitIsUnit = _G.UnitIsUnit
local UnitClass = _G.UnitClass
local UnitPVPName = _G.UnitPVPName
local GetGuildInfo = _G.GetGuildInfo
local UnitExists = _G.UnitExists

--from elvui, modified for gradient
do
	local function EltruismGetTitleNPC(unit, custom)
		if UnitIsPlayer(unit) or (E.Mists and UnitAffectingCombat('player') and IsInInstance()) then return end

		-- similar to TT.GetLevelLine
		local info = E.ScanTooltip:GetUnitInfo(unit)
		local line = info and info.lines[GetCVarBool('colorblindmode') and 3 or 2]
		local ttText = line and line.leftText

		local ttLower = ttText and strlower(ttText)
		if ttLower and not strfind(ttLower, LEVEL) and not strfind(ttText,LEVEL) then
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
		name = E:ShortenString(name, 10)
	end
	return name
end)
E:AddTagInfo("name:eltruism:abbreviateshort", ElvUI_EltreumUI.Name.." "..L["Names"], L["Abbreviates the unit name once it goes over 10 characters"])

--gradient name
E:AddTag("name:eltruism:gradient", "UNIT_NAME_UPDATE", function(unit)
	local name = UnitName(unit)
	local isTarget = UnitIsUnit(unit,"target") and not unit:match("nameplate") and not unit:match("party")

	if UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit)) then
		local _, unitClass = UnitClass(unit)
		if not unitClass then return end
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
	args = tonumber(args)
	if string.len(name) > tonumber(args) then --first for npcs with multiple names/titles
		name = ElvUI_EltreumUI:ShortenString(name, tonumber(args))
	end
	local isTarget = UnitIsUnit(unit,"target") and not unit:match("nameplate") and not unit:match("party")
	if string.len(name) > tonumber(args) then --second for players
		name = E:ShortenString(name, tonumber(args))
	end

	if UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit)) then
		local _, unitClass = UnitClass(unit)
		if not unitClass then return end
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
	if not unit then return end
	local namecheck = UnitName(unit)
	if not namecheck then return end
	local name = string.upper(namecheck)
	local isTarget = UnitIsUnit(unit,"target") and not unit:match("nameplate") and not unit:match("party")

	if UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit)) then
		local _, unitClass = UnitClass(unit)
		if not unitClass then return end
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
	if not unit then return end
	local namecheck = UnitName(unit)
	if not namecheck then return end
	local name = string.upper(namecheck)
	if not args then args = 16 end
	args = tonumber(args)
	if string.len(name) > tonumber(args) then --first for npcs with multiple names/titles
		name = ElvUI_EltreumUI:ShortenString(name, tonumber(args))
	end
	local isTarget = UnitIsUnit(unit,"target") and not unit:match("nameplate") and not unit:match("party")
	if string.len(name) > tonumber(args) then --second for players
		name = E:ShortenString(name, tonumber(args))
	end

	if UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit)) then
		local _, unitClass = UnitClass(unit)
		if not unitClass then return end
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
	local isTarget = UnitIsUnit(unit,"target") and not unit:match("nameplate") and not unit:match("party")
	if args then
		if string.len(name) > tonumber(args) then --first for npcs with multiple names/titles
			name = ElvUI_EltreumUI:ShortenString(name, tonumber(args))
		end
		if string.len(name) > tonumber(args) then --second for players
			name = E:ShortenString(name, tonumber(args))
		end
	end

	if UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit)) then
		local _, unitClass = UnitClass(unit)
		if not unitClass then return end
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
	if name and string.len(name) > 16 then
		name = ElvUI_EltreumUI:ShortenString(name, 16)
	end
	local isTarget = UnitIsUnit(unit,"target") and not unit:match("nameplate") and not unit:match("party")

	if UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit)) then
		local _, unitClass = UnitClass(unit)
		if not unitClass then return end
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
	if UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit)) then
		local _, unitClass = UnitClass(unit)
		if not unitClass then return end
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
		if not unitClass then return end
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
	local isTarget = UnitIsUnit(unit,"target") and not unit:match("nameplate") and not unit:match("party")

	if UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit)) then
		local _, unitClass = UnitClass(unit)
		if not unitClass then return end
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
	if name and string.len(name) > 16 then
		name = ElvUI_EltreumUI:ShortenString(name, 16)
	end
	local isTarget = UnitIsUnit(unit,"target") and not unit:match("nameplate") and not unit:match("party")

	if UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit)) then
		local _, unitClass = UnitClass(unit)
		if not unitClass then return end
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

--class color name abbreviate in caps
E:AddTag("name:eltruism:caps", "UNIT_NAME_UPDATE", function(unit,_,args)
	if not unit then return end
	local namecheck = UnitName(unit)
	if not namecheck then return end
	local name = string.upper(namecheck)
	if not args then args = 16 end
	args = tonumber(args)
	if string.len(name) > tonumber(args) then --first for npcs with multiple names/titles
		name = ElvUI_EltreumUI:ShortenString(name, tonumber(args))
	end

	if string.len(name) > tonumber(args) then --second for players
		name = E:ShortenString(name, tonumber(args))
	end

	if UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit)) then
		local _, unitClass = UnitClass(unit)
		if not unitClass then return end
		return "|c"..ElvUI_EltreumUI:classcolorcast(unitClass)..name.."|r"
	elseif not UnitIsPlayer(unit) then
		local reaction = UnitReaction(unit, "player")
		if reaction then
			if reaction >= 5 then
				return "|c"..ElvUI_EltreumUI:classcolorcast("FRIENDLY")..name.."|r"
			elseif reaction == 4 then
				return "|c"..ElvUI_EltreumUI:classcolorcast("NEUTRAL")..name.."|r"
			elseif reaction == 3 then
				return "|c"..ElvUI_EltreumUI:classcolorcast("UNFRIENDLY")..name.."|r"
			elseif reaction == 2 or reaction == 1 then
				return "|c"..ElvUI_EltreumUI:classcolorcast("HOSTILE")..name.."|r"
			end
		end
	end
end)
E:AddTagInfo("name:eltruism:caps", ElvUI_EltreumUI.Name.." "..L["Names"], L["Displays unit name in caps while being class color or reaction color, shortens over 16 characters but can be changed with {arg}"])

--name in caps
E:AddTag("name:eltruism:capital", "UNIT_NAME_UPDATE", function(unit)
	if not unit then return end
	local namecheck = UnitName(unit)
	if not namecheck then return end
	local name = string.upper(namecheck)
	return name
end)
E:AddTagInfo("name:eltruism:capital", ElvUI_EltreumUI.Name.." "..L["Names"], L["Displays unit name in capital"])

--Details nickname using the nicktag library suggested by VXT
local nicktag
if IsAddOnLoaded("Details") then
	nicktag = LibStub('NickTag-1.0')
end

--Class Color nickname
E:AddTag("eltruism:detailsnickname", "UNIT_NAME_UPDATE", function(unit)
	if not unit then return end
	local name = UnitName(unit)
	local _, unitClass = UnitClass(unit)
	local reaction = UnitReaction(unit, "player")
	if nicktag then
		local nickname = nicktag:GetNickname(UnitName(unit), false, true)
		if nickname then
			if UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit)) then
				if not unitClass then return end
				return "|c"..ElvUI_EltreumUI:classcolorcast(unitClass)..nickname.."|r"
			else
				if reaction then
					if reaction >= 5 then
						return "|c"..ElvUI_EltreumUI:classcolorcast("FRIENDLY")..nickname.."|r"
					elseif reaction == 4 then
						return "|c"..ElvUI_EltreumUI:classcolorcast("NEUTRAL")..nickname.."|r"
					elseif reaction == 3 then
						return "|c"..ElvUI_EltreumUI:classcolorcast("UNFRIENDLY")..nickname.."|r"
					elseif reaction == 2 or reaction == 1 then
						return "|c"..ElvUI_EltreumUI:classcolorcast("HOSTILE")..nickname.."|r"
					end
				end
			end
		else
			if UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit)) then
				if not unitClass then return end
				return "|c"..ElvUI_EltreumUI:classcolorcast(unitClass)..name.."|r"
			else
				if reaction then
					if reaction >= 5 then
						return "|c"..ElvUI_EltreumUI:classcolorcast("FRIENDLY")..name.."|r"
					elseif reaction == 4 then
						return "|c"..ElvUI_EltreumUI:classcolorcast("NEUTRAL")..name.."|r"
					elseif reaction == 3 then
						return "|c"..ElvUI_EltreumUI:classcolorcast("UNFRIENDLY")..name.."|r"
					elseif reaction == 2 or reaction == 1 then
						return "|c"..ElvUI_EltreumUI:classcolorcast("HOSTILE")..name.."|r"
					end
				end
			end
		end
	else
		if UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit)) then
			if not unitClass then return end
			return "|c"..ElvUI_EltreumUI:classcolorcast(unitClass)..name.."|r"
		else
			if reaction then
				if reaction >= 5 then
					return "|c"..ElvUI_EltreumUI:classcolorcast("FRIENDLY")..name.."|r"
				elseif reaction == 4 then
					return "|c"..ElvUI_EltreumUI:classcolorcast("NEUTRAL")..name.."|r"
				elseif reaction == 3 then
					return "|c"..ElvUI_EltreumUI:classcolorcast("UNFRIENDLY")..name.."|r"
				elseif reaction == 2 or reaction == 1 then
					return "|c"..ElvUI_EltreumUI:classcolorcast("HOSTILE")..name.."|r"
				end
			end
		end
	end
end)
E:AddTagInfo("eltruism:detailsnickname", ElvUI_EltreumUI.Name.." "..L["Names"], L["Displays Details nickname in class color or reaction color if Details is loaded"])

--Gradient nickname
E:AddTag("eltruism:detailsnickname:gradient", "UNIT_NAME_UPDATE", function(unit)
	local name = UnitName(unit)
	local isTarget = UnitIsUnit(unit,"target") and not unit:match("nameplate") and not unit:match("party")
	local _, unitClass = UnitClass(unit)
	local reaction = UnitReaction(unit, "player")
	if nicktag then
		local nickname = nicktag:GetNickname(UnitName(unit), false, true)
		if nickname then
			if UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit)) then
				if not unitClass then return end
				return ElvUI_EltreumUI:GradientName(nickname, unitClass,isTarget)
			elseif not UnitIsPlayer(unit) then
				if reaction then
					if reaction >= 5 then
						return ElvUI_EltreumUI:GradientName(nickname, "NPCFRIENDLY", isTarget)
					elseif reaction == 4 then
						return ElvUI_EltreumUI:GradientName(nickname, "NPCNEUTRAL", isTarget)
					elseif reaction == 3 then
						return ElvUI_EltreumUI:GradientName(nickname, "NPCUNFRIENDLY", isTarget)
					elseif reaction == 2 or reaction == 1 then
						return ElvUI_EltreumUI:GradientName(nickname, "NPCHOSTILE", isTarget)
					end
				end
			end
		else
			if UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit)) then
				if not unitClass then return end
				return ElvUI_EltreumUI:GradientName(name, unitClass,isTarget)
			elseif not UnitIsPlayer(unit) then
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
		end
	else
		if UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit)) then
			if not unitClass then return end
			return ElvUI_EltreumUI:GradientName(name, unitClass,isTarget)
		elseif not UnitIsPlayer(unit) then
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
	end
end)
E:AddTagInfo("eltruism:detailsnickname:gradient", ElvUI_EltreumUI.Name.." "..L["Names"], L["Displays Details nickname in class color or reaction color if Details is loaded"])

--gradient short but dont abbreviate first name
E:AddTag("name:eltruism:gradientshortfirst", "UNIT_NAME_UPDATE", function(unit,_,args)
	local name = UnitName(unit)
	if not name then return end
	if not args then args = 16 end
	args = tonumber(args)
	--name = "Mannequin d'entraïnement aux dégäts de zone"
	if string.len(name) > tonumber(args) then --first for npcs with multiple names/titles
		name = ElvUI_EltreumUI:ShortenString(name, tonumber(args),false,true)
	end
	local isTarget = UnitIsUnit(unit,"target") and not unit:match("nameplate") and not unit:match("party")
	--this would end up removing some of the shortened text in this case
	--[[if string.len(name) > tonumber(args) then --second for players
		name = E:ShortenString(name, tonumber(args))
	end]]

	if UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit)) then
		local _, unitClass = UnitClass(unit)
		if not unitClass then return end
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
E:AddTagInfo("name:eltruism:gradientshortfirst", ElvUI_EltreumUI.Name.." "..L["Names"], L["Displays unit name in gradient class color or reaction color, shortens over 16 characters"])

--elvui name abbrev but with args
E:AddTag("name:eltruism:abbrev", "UNIT_NAME_UPDATE", function(unit,_,args)
	local name = UnitName(unit)
	if not name then return end
	if not args then args = 16 end
	args = tonumber(args)
	if string.len(name) > tonumber(args) then --first for npcs with multiple names/titles
		name = ElvUI_EltreumUI:Abbrev(name)
	end
	if name then
		return E:ShortenString(name, args)
	end
end)
E:AddTagInfo("name:eltruism:abbrev", ElvUI_EltreumUI.Name.." "..L["Names"], L["Displays the name of the unit with abbreviation, accepts length args"])

--elvui target name abbrev but with args
E:AddTag("target:eltruism:abbrev", 'UNIT_TARGET', function(unit,_,args)
	local targetName = UnitName(unit..'target')
	if not targetName then return end
	if not args then args = 16 end
	args = tonumber(args)
	if string.len(targetName) > tonumber(args) then --first for npcs with multiple names/titles
		targetName = ElvUI_EltreumUI:Abbrev(targetName)
	end
	if targetName then
		return E:ShortenString(targetName, args)
	end
end)
E:AddTagInfo("target:eltruism:abbrev", ElvUI_EltreumUI.Name.." "..L["Names"], L["Displays the current target of the unit, accepts length args"])

--target of target gradient name
E:AddTag("name:eltruism:gradient:targetoftarget", "UNIT_NAME_UPDATE", function()
	if not UnitExists("targettarget") then return end
	local name = UnitName("targettarget")
	if name then
		if UnitIsPlayer("targettarget") or (E.Retail and UnitInPartyIsAI("targettarget")) then
			local _, unitClass = UnitClass("targettarget")
			if not unitClass then return end
			return ElvUI_EltreumUI:GradientName(name, unitClass)
		elseif not UnitIsPlayer("targettarget") then
			local reaction = UnitReaction("targettarget", "player")
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
	end
end)
E:AddTagInfo("name:eltruism:gradient:targetoftarget", ElvUI_EltreumUI.Name.." "..L["Names"], L["Displays unit name in gradient class color or reaction color"])
