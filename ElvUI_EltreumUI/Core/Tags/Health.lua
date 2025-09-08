local E, L = unpack(ElvUI)
local _G = _G
local UnitExists = _G.UnitExists
local UnitArmor = _G.UnitArmor
local UnitLevel = _G.UnitLevel
local UnitHealthMax = _G.UnitHealthMax
local math = _G.math
local tostring = _G.tostring
local UnitIsPlayer = _G.UnitIsPlayer
local UnitIsDead = _G.UnitIsDead
local UnitIsGhost = _G.UnitIsGhost
local UnitHealth = _G.UnitHealth
local UnitIsConnected = _G.UnitIsConnected
local UnitIsUnit = _G.UnitIsUnit
local UnitClass = _G.UnitClass
local gsub = _G.gsub
local format = _G.format
local UnitReaction = _G.UnitReaction
local string = _G.string
local UnitInPartyIsAI = _G.UnitInPartyIsAI
local UnitIsFeignDeath = _G.UnitIsFeignDeath
local UnitIsDeadOrGhost = _G.UnitIsDeadOrGhost

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
	if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then --npc
		if not UnitIsDead(unit) or UnitIsFeignDeath(unit) then
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
		if not UnitIsDeadOrGhost(unit) or UnitIsFeignDeath(unit) then --players
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
				return ElvUI_EltreumUI:SpellInfoShapeshift(8326)
			end
		end
	end
end)
E:AddTagInfo("eltruism:hpstatus", ElvUI_EltreumUI.Name.." "..L["Health"], L["Displays HP - % and a status symbol. Can be customized in Eltruism > Media"])

--same as previous tag but with | instead of -
E:AddTag("eltruism:hpstatus:line", "UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION PLAYER_FLAGS_CHANGED", function(unit)
	local deadtexture = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Dead\\dead"..tostring(E.db.ElvUI_EltreumUI.otherstuff.hpstatusdeadicon)..".tga:0:0:0:0|t"
	local dctexture = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Disconnect\\dc"..tostring(E.db.ElvUI_EltreumUI.otherstuff.hpstatusdcicon)..".tga:0:0:0:0|t"
	if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then --npc
		if not UnitIsDead(unit) or UnitIsFeignDeath(unit) then
			local min, max = UnitHealth(unit), UnitHealthMax(unit)
			local perc = min / max * 100
			return format('%s | %.1f%%', E:ShortValue(min, 0), perc)
		else
			if E.db.ElvUI_EltreumUI.otherstuff.hpstatusdeadicon ~= "NONE" then
				return deadtexture
			else
				return L["Dead"]
			end
		end
	else
		if not UnitIsDeadOrGhost(unit) or UnitIsFeignDeath(unit) then --players
			local min, max = UnitHealth(unit), UnitHealthMax(unit)
			local perc = min / max * 100
			return format('%s | %.1f%%', E:ShortValue(min, 0), perc)
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
				return ElvUI_EltreumUI:SpellInfoShapeshift(8326)
			end
		end
	end
end)
E:AddTagInfo("eltruism:hpstatus:line", ElvUI_EltreumUI.Name.." "..L["Health"], L["Displays HP | % and a status symbol. Can be customized in Eltruism > Media"])

--reverse of the hpstatus, uses modified elvui tag code
E:AddTag("eltruism:hpstatus:reverse", "UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION PLAYER_FLAGS_CHANGED", function(unit)
	local deadtexture = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Dead\\dead"..tostring(E.db.ElvUI_EltreumUI.otherstuff.hpstatusdeadicon)..".tga:0:0:0:0|t"
	local dctexture = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Disconnect\\dc"..tostring(E.db.ElvUI_EltreumUI.otherstuff.hpstatusdcicon)..".tga:0:0:0:0|t"
	if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then --npc
		if not UnitIsDead(unit) or UnitIsFeignDeath(unit) then
			local min1, max1 = UnitHealth(unit), UnitHealthMax(unit)
			if max1 == 0 then max1 = 1 end
			local perc = min1 / max1 * 100
			if min1 == max1 then
				return E:ShortValue(min1, nil)
			else
				return format('%.1f%% - %s', perc, E:ShortValue(min1, nil))
			end
		else
			if E.db.ElvUI_EltreumUI.otherstuff.hpstatusdeadicon ~= "NONE" then
				return deadtexture
			else
				return L["Dead"]
			end
		end
	else
		if not UnitIsDeadOrGhost(unit) or UnitIsFeignDeath(unit) then --players
			local min1, max1 = UnitHealth(unit), UnitHealthMax(unit)
			if not max1 then max1 = 1 end
			if max1 == 0 then max1 = 1 end
			local perc = min1 / max1 * 100
			if min1 == max1 then
				return E:ShortValue(min1, nil)
			else
				return format('%.1f%% - %s', perc, E:ShortValue(min1, nil))
			end
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
				return ElvUI_EltreumUI:SpellInfoShapeshift(8326)
			end
		end
	end
end)
E:AddTagInfo("eltruism:hpstatus:reverse", ElvUI_EltreumUI.Name.." "..L["Health"], L["Displays % - HP and a status symbol. Can be customized in Eltruism > Media"])

--no percentage value of other HP tag that switches to a dead symbol or dc symbol depending on the unit status, based on elvui
E:AddTag("eltruism:hpstatusnopc", "UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION PLAYER_FLAGS_CHANGED", function(unit)
	local deadtexture = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Dead\\dead"..tostring(E.db.ElvUI_EltreumUI.otherstuff.hpstatusdeadicon)..".tga:0:0:0:0|t"
	local dctexture = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Disconnect\\dc"..tostring(E.db.ElvUI_EltreumUI.otherstuff.hpstatusdcicon)..".tga:0:0:0:0|t"
	if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then --npc
		if not UnitIsDead(unit) or UnitIsFeignDeath(unit) then
			return E:ShortValue(UnitHealth(unit), tostring(E.db.general.decimalLength or 1))
		else
			if E.db.ElvUI_EltreumUI.otherstuff.hpstatusdeadicon ~= "NONE" then
				return deadtexture
			else
				return L["Dead"]
			end
		end
	else
		if not UnitIsDeadOrGhost(unit) or UnitIsFeignDeath(unit) then --players
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
				return ElvUI_EltreumUI:SpellInfoShapeshift(8326)
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
		if not UnitIsDeadOrGhost(unit) or UnitIsFeignDeath(unit) then
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
				return ElvUI_EltreumUI:SpellInfoShapeshift(8326)
			end
		end
	end
end)
E:AddTagInfo("eltruism:perhpstatus", ElvUI_EltreumUI.Name.." "..L["Health"], L["Displays percentage health with status icons"])

--gradient versions

--HP tag that switches to a dead symbol or dc symbol depending on the unit status, based on elvui
E:AddTag("eltruism:hpstatus:gradient", "UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION PLAYER_FLAGS_CHANGED", function(unit)
	local deadtexture = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Dead\\dead"..tostring(E.db.ElvUI_EltreumUI.otherstuff.hpstatusdeadicon)..".tga:0:0:0:0|t"
	local dctexture = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Disconnect\\dc"..tostring(E.db.ElvUI_EltreumUI.otherstuff.hpstatusdcicon)..".tga:0:0:0:0|t"
	local isTarget = UnitIsUnit(unit,"target") and not UnitIsUnit(unit,"player") and not unit:match("party")
	local min, max = UnitHealth(unit), UnitHealthMax(unit)
	local value = E:GetFormattedText('CURRENT_PERCENT', min, max, nil, true)
	local lengthOK = string.len(value) > 2 and true or false
	if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then --npc
		if not UnitIsDead(unit) or UnitIsFeignDeath(unit) then
			local reaction = UnitReaction(unit, "player")
			if reaction then
				if reaction >= 5 then
					if lengthOK then
						return ElvUI_EltreumUI:GradientName(value, "NPCFRIENDLY", isTarget)
					else
						return value
					end
				elseif reaction == 4 then
					if lengthOK then
						return ElvUI_EltreumUI:GradientName(value, "NPCNEUTRAL", isTarget)
					else
						return value
					end
				elseif reaction == 3 then
					if lengthOK then
						return ElvUI_EltreumUI:GradientName(value, "NPCUNFRIENDLY", isTarget)
					else
						return value
					end
				elseif reaction == 2 or reaction == 1 then
					if lengthOK then
						return ElvUI_EltreumUI:GradientName(value, "NPCHOSTILE", isTarget)
					else
						return value
					end
				end
			end
		else
			if E.db.ElvUI_EltreumUI.otherstuff.hpstatusdeadicon ~= "NONE" then
				return deadtexture
			else
				return L["Dead"]
			end
		end
	else
		local _, unitClass = UnitClass(unit)
		if not unitClass then return end
		if not UnitIsDeadOrGhost(unit) or UnitIsFeignDeath(unit) then --players
			if lengthOK then
				return ElvUI_EltreumUI:GradientName(value, unitClass,isTarget)
			else
				return value
			end
			--return gsub(ElvUI_EltreumUI:GradientName(E:GetFormattedText('CURRENT_PERCENT', min, max, nil, true), unitClass,isTarget),"-","||")
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
				return ElvUI_EltreumUI:SpellInfoShapeshift(8326)
			end
		end
	end
end)
E:AddTagInfo("eltruism:hpstatus:gradient", ElvUI_EltreumUI.Name.." "..L["Health"], L["Displays HP - % and a status symbol. Can be customized in Eltruism > Media"])

--no percentage value of other HP tag that switches to a dead symbol or dc symbol depending on the unit status, based on elvui
E:AddTag("eltruism:hpstatusnopc:gradient", "UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION PLAYER_FLAGS_CHANGED", function(unit)
	local deadtexture = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Dead\\dead"..tostring(E.db.ElvUI_EltreumUI.otherstuff.hpstatusdeadicon)..".tga:0:0:0:0|t"
	local dctexture = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Disconnect\\dc"..tostring(E.db.ElvUI_EltreumUI.otherstuff.hpstatusdcicon)..".tga:0:0:0:0|t"
	local isTarget = UnitIsUnit(unit,"target") and not UnitIsUnit(unit,"player") and not unit:match("party")
	local value = E:ShortValue(UnitHealth(unit), tostring(E.db.general.decimalLength or 1))
	local lengthOK = string.len(value) > 2 and true or false
	if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then --npc
		if not UnitIsDead(unit) or UnitIsFeignDeath(unit) then
			local reaction = UnitReaction(unit, "player")
			if reaction then
				if reaction >= 5 then
					if lengthOK then
						return ElvUI_EltreumUI:GradientName(value, "NPCFRIENDLY", isTarget)
					else
						return value
					end
				elseif reaction == 4 then
					if lengthOK then
						return ElvUI_EltreumUI:GradientName(value, "NPCNEUTRAL", isTarget)
					else
						return value
					end
				elseif reaction == 3 then
					if lengthOK then
						return ElvUI_EltreumUI:GradientName(value, "NPCUNFRIENDLY", isTarget)
					else
						return value
					end
				elseif reaction == 2 or reaction == 1 then
					if lengthOK then
						return ElvUI_EltreumUI:GradientName(value, "NPCHOSTILE", isTarget)
					else
						return value
					end
				end
			end
		else
			if E.db.ElvUI_EltreumUI.otherstuff.hpstatusdeadicon ~= "NONE" then
				return deadtexture
			else
				return L["Dead"]
			end
		end
	else
		local _, unitClass = UnitClass(unit)
		if not unitClass then return end
		if not UnitIsDeadOrGhost(unit) or UnitIsFeignDeath(unit) then --players
			if lengthOK then
				return ElvUI_EltreumUI:GradientName(value, unitClass,isTarget)
			else
				return value
			end
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
				return ElvUI_EltreumUI:SpellInfoShapeshift(8326)
			end
		end
	end
end)
E:AddTagInfo("eltruism:hpstatusnopc:gradient", ElvUI_EltreumUI.Name.." "..L["Health"], L["Displays shortvalue HP and a status symbol from Releaf for players. Usage: [eltruism:hpstatusnopc{number,number}]"])

--no percentage value of other HP tag that switches to a dead symbol or dc symbol depending on the unit status, based on elvui
E:AddTag("eltruism:longhpstatusnopc:gradient", "UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION PLAYER_FLAGS_CHANGED", function(unit)
	local deadtexture = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Dead\\dead"..tostring(E.db.ElvUI_EltreumUI.otherstuff.hpstatusdeadicon)..".tga:0:0:0:0|t"
	local dctexture = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Disconnect\\dc"..tostring(E.db.ElvUI_EltreumUI.otherstuff.hpstatusdcicon)..".tga:0:0:0:0|t"
	local isTarget = UnitIsUnit(unit,"target") and not UnitIsUnit(unit,"player") and not unit:match("party")
	local value = tostring(UnitHealth(unit))
	local lengthOK = string.len(value) > 2 and true or false
	if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then --npc
		if not UnitIsDead(unit) or UnitIsFeignDeath(unit) then
			local reaction = UnitReaction(unit, "player")
			if reaction then
				if reaction >= 5 then
					if lengthOK then
						return ElvUI_EltreumUI:GradientName(value, "NPCFRIENDLY", isTarget)
					else
						return value
					end
				elseif reaction == 4 then
					if lengthOK then
						return ElvUI_EltreumUI:GradientName(value, "NPCNEUTRAL", isTarget)
					else
						return value
					end
				elseif reaction == 3 then
					if lengthOK then
						return ElvUI_EltreumUI:GradientName(value, "NPCUNFRIENDLY", isTarget)
					else
						return value
					end
				elseif reaction == 2 or reaction == 1 then
					if lengthOK then
						return ElvUI_EltreumUI:GradientName(value, "NPCHOSTILE", isTarget)
					else
						return value
					end
				end
			end
		else
			if E.db.ElvUI_EltreumUI.otherstuff.hpstatusdeadicon ~= "NONE" then
				return deadtexture
			else
				return L["Dead"]
			end
		end
	else
		local _, unitClass = UnitClass(unit)
		if not unitClass then return end
		if not UnitIsDeadOrGhost(unit) or UnitIsFeignDeath(unit) then --players
			if lengthOK then
				return ElvUI_EltreumUI:GradientName(value, unitClass,isTarget)
			else
				return value
			end
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
				return ElvUI_EltreumUI:SpellInfoShapeshift(8326)
			end
		end
	end
end)
E:AddTagInfo("eltruism:longhpstatusnopc:gradient", ElvUI_EltreumUI.Name.." "..L["Health"], L["Displays HP and a status symbol from Releaf for players"])

--health deficit + perhp
E:AddTag("eltruism:hpdeficitpc:gradient", "UNIT_HEALTH UNIT_MAXHEALTH UNIT_NAME_UPDATE", function(unit)
	local cur, maxhp = UnitHealth(unit), UnitHealthMax(unit)
	local deficit = maxhp - cur
	local isTarget = UnitIsUnit(unit,"target") and not UnitIsUnit(unit,"player") and not unit:match("party")
	local value = "-"..E:ShortValue(deficit).." _ "..E:GetFormattedText('PERCENT', UnitHealth(unit), UnitHealthMax(unit))
	if deficit > 0 and cur > 0 then
		if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then --npc
			local reaction = UnitReaction(unit, "player")
			if reaction then
				if reaction >= 5 then
					return gsub(ElvUI_EltreumUI:GradientName(value, "NPCFRIENDLY", isTarget),"_","||")
				elseif reaction == 4 then
					return gsub(ElvUI_EltreumUI:GradientName(value, "NPCNEUTRAL", isTarget),"_","||")
				elseif reaction == 3 then
					return gsub(ElvUI_EltreumUI:GradientName(value, "NPCUNFRIENDLY", isTarget),"_","||")
				elseif reaction == 2 or reaction == 1 then
					return gsub(ElvUI_EltreumUI:GradientName(value, "NPCHOSTILE", isTarget),"_","||")
				end
			end
		else
			local _, unitClass = UnitClass(unit)
			if not unitClass then return end
			return gsub(ElvUI_EltreumUI:GradientName(value, unitClass, isTarget),"_","||")
		end
	end
end)
E:AddTagInfo("eltruism:hpdeficitpc:gradient", ElvUI_EltreumUI.Name.." "..L["Health"], L["Displays health lost in shortvalue and current health percentage"])

--health deficit + perhp
E:AddTag("eltruism:pchpdeficit:gradient", "UNIT_HEALTH UNIT_MAXHEALTH UNIT_NAME_UPDATE", function(unit)
	local cur, maxhp = UnitHealth(unit), UnitHealthMax(unit)
	local deficit = maxhp - cur
	local isTarget = UnitIsUnit(unit,"target") and not UnitIsUnit(unit,"player") and not unit:match("party")
	if deficit > 0 and cur > 0 then
		local value = E:GetFormattedText('PERCENT', UnitHealth(unit), UnitHealthMax(unit))
		if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then --npc
			local reaction = UnitReaction(unit, "player")
			if reaction then
				if reaction >= 5 then
					return gsub(ElvUI_EltreumUI:GradientName(value.." _ "..E:ShortValue(deficit), "NPCFRIENDLY", isTarget),"_","||")
				elseif reaction == 4 then
					return gsub(ElvUI_EltreumUI:GradientName(value.." _ "..E:ShortValue(deficit), "NPCNEUTRAL", isTarget),"_","||")
				elseif reaction == 3 then
					return gsub(ElvUI_EltreumUI:GradientName(value.." _ "..E:ShortValue(deficit), "NPCUNFRIENDLY", isTarget),"_","||")
				elseif reaction == 2 or reaction == 1 then
					return gsub(ElvUI_EltreumUI:GradientName(value.." _ "..E:ShortValue(deficit), "NPCHOSTILE", isTarget),"_","||")
				end
			end
		else
			local _, unitClass = UnitClass(unit)
			if not unitClass then return end
			return gsub(ElvUI_EltreumUI:GradientName(value.." _ "..E:ShortValue(deficit), unitClass, isTarget),"_","||")
		end
	end
end)
E:AddTagInfo("eltruism:pchpdeficit:gradient", ElvUI_EltreumUI.Name.." "..L["Health"], L["Displays current health percentage and health lost in shortvalue"])


--health:current-max-percent:shortvalue but gradient
E:AddTag("eltruism:healthcurrentmaxpercentshort:gradient", 'UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION PLAYER_FLAGS_CHANGED', function(unit)
	local status = not UnitIsFeignDeath(unit) and UnitIsDead(unit) and L["Dead"] or UnitIsGhost(unit) and L["Ghost"] or not UnitIsConnected(unit) and L["Offline"]
	local isTarget = UnitIsUnit(unit,"target") and not UnitIsUnit(unit,"player") and not unit:match("party")
	if status then
		return status
	else
		local _, unitClass = UnitClass(unit)
		local value,perctext,perc
		local min = UnitHealth(unit)
		local max = UnitHealthMax(unit)
		if min == max then
			value = E:ShortValue(min, 0)
			perctext = ""
			perc = " "
		else
			value = E:ShortValue(min, 0).." - "..E:ShortValue(max, 0)
			perctext = "|c"..ElvUI_EltreumUI:classcolorcast(unitClass).." a |r"
			perctext = gsub(perctext,"a","||")
			perc = tostring(format("%.1f%%",min / max * 100))
		end
		if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then --npc
			local reaction = UnitReaction(unit, "player")
			if reaction then
				if reaction >= 5 then
					return ElvUI_EltreumUI:GradientName(value, "NPCFRIENDLY", isTarget)..perctext..ElvUI_EltreumUI:GradientName(perc, "NPCFRIENDLY", isTarget)
				elseif reaction == 4 then
					return ElvUI_EltreumUI:GradientName(value, "NPCNEUTRAL", isTarget)..perctext..ElvUI_EltreumUI:GradientName(perc, "NPCNEUTRAL", isTarget)
				elseif reaction == 3 then
					return ElvUI_EltreumUI:GradientName(value, "NPCUNFRIENDLY", isTarget)..perctext..ElvUI_EltreumUI:GradientName(perc, "NPCUNFRIENDLY", isTarget)
				elseif reaction == 2 or reaction == 1 then
					return ElvUI_EltreumUI:GradientName(value, "NPCHOSTILE", isTarget)..perctext..ElvUI_EltreumUI:GradientName(perc, "NPCHOSTILE", isTarget)
				end
			end
		else
			if not unitClass then return end
			return ElvUI_EltreumUI:GradientName(value, unitClass, isTarget)..perctext..ElvUI_EltreumUI:GradientName(perc, unitClass, isTarget)
		end
	end
end)
E:AddTagInfo("eltruism:healthcurrentmaxpercentshort:gradient", ElvUI_EltreumUI.Name.." "..L["Health"], L["Displays current health, max health and percentage of health in shortvalue"])
