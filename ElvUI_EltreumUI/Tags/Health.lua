local E, L = unpack(ElvUI)
local _G = _G
local UnitExists = _G.UnitExists
local UnitArmor = _G.UnitArmor
local UnitLevel = _G.UnitLevel
local UnitHealthMax = _G.UnitHealthMax
local math = _G.math
local mathfloor = math.floor
local tostring = _G.tostring
local UnitIsPlayer = _G.UnitIsPlayer
local UnitIsDead = _G.UnitIsDead
local UnitIsGhost = _G.UnitIsGhost
local UnitHealth = _G.UnitHealth
local UnitIsConnected = _G.UnitIsConnected
local UnitClass = _G.UnitClass
local format = _G.format
local UnitReaction = _G.UnitReaction
local string = _G.string
local UnitInPartyIsAI = _G.UnitInPartyIsAI
local UnitIsFeignDeath = _G.UnitIsFeignDeath
local UnitIsDeadOrGhost = _G.UnitIsDeadOrGhost
local ScaleTo100 = _G.CurveConstants and _G.CurveConstants.ScaleTo100
local UnitHealthPercent = _G.UnitHealthPercent
local AbbreviateNumbers = _G.AbbreviateNumbers
local BreakUpLargeNumbers = _G.BreakUpLargeNumbers
local escapeSequence = ":0:0:0:0"
local stringlen = string.len
local GetClassColor = _G.C_ClassColor and _G.C_ClassColor.GetClassColor or _G.GetClassColor

local deadtexture, dctexture, ghosttexture

local reactionToGradient = {
	[1] = "NPCHOSTILE",
	[2] = "NPCHOSTILE",
	[3] = "NPCUNFRIENDLY",
	[4] = "NPCNEUTRAL",
	[5] = "NPCFRIENDLY",
	[6] = "NPCFRIENDLY",
	[7] = "NPCFRIENDLY",
	[8] = "NPCFRIENDLY",
}

local function IsUnitDeadHelper(unit)
	if not unit or not UnitExists(unit) then return false end
	local feign = UnitIsFeignDeath(unit)
	if E:NotSecretValue(feign) and feign then return false end
	local dead = UnitIsDead(unit)
	if E:NotSecretValue(dead) and dead then return true end
	local ghost = UnitIsGhost(unit)
	if E:NotSecretValue(ghost) and ghost then return true end
	local deadOrGhost = UnitIsDeadOrGhost(unit)
	if E:NotSecretValue(deadOrGhost) and deadOrGhost then return true end
	local health = UnitHealth(unit)
	if health and E:NotSecretValue(health) and health <= 0 then return true end
	return false
end
ElvUI_EltreumUI.IsUnitDeadHelper = IsUnitDeadHelper

function ElvUI_EltreumUI:UpdateCachedHealthTagTextures()
	if E.db and E.db.ElvUI_EltreumUI and E.db.ElvUI_EltreumUI.otherstuff then
		local hpicons = E.db.ElvUI_EltreumUI.otherstuff
		deadtexture = format([[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Dead\dead%s%s|t]], tostring(hpicons.hpstatusdeadicon), escapeSequence)
		dctexture = format([[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Disconnect\dc%s%s|t]], tostring(hpicons.hpstatusdcicon), escapeSequence)
		ghosttexture = format([[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Ghost\ghost%s%s|t]], tostring(hpicons.ghosttagicon), escapeSequence)
	end
end

function ElvUI_EltreumUI:LoadHealthTags()
	ElvUI_EltreumUI:UpdateCachedHealthTagTextures()

	--tag that only shows the icon, due to secrets
	E:AddTag("eltruism:status", "UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION PLAYER_FLAGS_CHANGED UNIT_NAME_UPDATE UNIT_TARGET UNIT_FLAGS PARTY_MEMBER_ENABLE PARTY_MEMBER_DISABLE", function(unit)
		local isConnected = UnitIsConnected(unit)
		if E:NotSecretValue(isConnected) and not isConnected then
			if E.db.ElvUI_EltreumUI.otherstuff.hpstatusdcicon ~= "NONE" then
				return dctexture
			else
				return L["Offline"]
			end
		else
			local feign = UnitIsFeignDeath(unit)
			if not (E:NotSecretValue(feign) and feign) then
				local ghost = UnitIsGhost(unit)
				if E:NotSecretValue(ghost) and ghost then
					if E.db.ElvUI_EltreumUI.otherstuff.ghosttagicon ~= "NONE" then
						return ghosttexture
					else
						return ElvUI_EltreumUI:SpellInfoShapeshift(8326)
					end
				elseif IsUnitDeadHelper(unit) then
					if E.db.ElvUI_EltreumUI.otherstuff.hpstatusdeadicon ~= "NONE" then
						return deadtexture
					else
						return L["Dead"]
					end
				end
			end
		end
	end)
	E:AddTagInfo("eltruism:status", ElvUI_EltreumUI.Name.." "..L["Health"], L["Displays a status symbol. Can be customized in Eltruism > Media"])

	--HP tag that switches to a dead symbol or dc symbol depending on the unit status, based on elvui
	E:AddTag("eltruism:hpstatus", "UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION PLAYER_FLAGS_CHANGED UNIT_NAME_UPDATE UNIT_TARGET UNIT_FLAGS PARTY_MEMBER_ENABLE PARTY_MEMBER_DISABLE", function(unit)
		local isConnected = UnitIsConnected(unit)
		if E:NotSecretValue(isConnected) and not isConnected then
			if E.db.ElvUI_EltreumUI.otherstuff.hpstatusdcicon ~= "NONE" then
				return dctexture
			else
				return L["Offline"]
			end
		else
			local feign = UnitIsFeignDeath(unit)
			if not (E:NotSecretValue(feign) and feign) then
				local ghost = UnitIsGhost(unit)
				if E:NotSecretValue(ghost) and ghost then
					if E.db.ElvUI_EltreumUI.otherstuff.ghosttagicon ~= "NONE" then
						return ghosttexture
					else
						return ElvUI_EltreumUI:SpellInfoShapeshift(8326)
					end
				elseif IsUnitDeadHelper(unit) then
					if E.db.ElvUI_EltreumUI.otherstuff.hpstatusdeadicon ~= "NONE" then
						return deadtexture
					else
						return L["Dead"]
					end
				end
			end
		end

		local cur, maxhp = UnitHealth(unit), UnitHealthMax(unit)
		if E.Modern then
			if E:NotSecretValue(cur) then
				return format('%s - %.1f%%', AbbreviateNumbers(cur, E.Abbreviate.short), UnitHealthPercent(unit, true, ScaleTo100))
			else
				return AbbreviateNumbers(cur, E.Abbreviate.short)
			end
		else
			return E:GetFormattedText('CURRENT_PERCENT', cur, maxhp, nil, true)
		end
	end)
	E:AddTagInfo("eltruism:hpstatus", ElvUI_EltreumUI.Name.." "..L["Health"], L["Displays HP - % and a status symbol. Can be customized in Eltruism > Media"])

	--same as previous tag but with | instead of -
	E:AddTag("eltruism:hpstatus:line", "UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION PLAYER_FLAGS_CHANGED UNIT_NAME_UPDATE UNIT_TARGET UNIT_FLAGS PARTY_MEMBER_ENABLE PARTY_MEMBER_DISABLE", function(unit)
		local isConnected = UnitIsConnected(unit)
		if E:NotSecretValue(isConnected) and not isConnected then
			if E.db.ElvUI_EltreumUI.otherstuff.hpstatusdcicon ~= "NONE" then
				return dctexture
			else
				return L["Offline"]
			end
		else
			local feign = UnitIsFeignDeath(unit)
			if not (E:NotSecretValue(feign) and feign) then
				local ghost = UnitIsGhost(unit)
				if E:NotSecretValue(ghost) and ghost then
					if E.db.ElvUI_EltreumUI.otherstuff.ghosttagicon ~= "NONE" then
						return ghosttexture
					else
						return ElvUI_EltreumUI:SpellInfoShapeshift(8326)
					end
				elseif IsUnitDeadHelper(unit) then
					if E.db.ElvUI_EltreumUI.otherstuff.hpstatusdeadicon ~= "NONE" then
						return deadtexture
					else
						return L["Dead"]
					end
				end
			end
		end

		local cur, maxhp = UnitHealth(unit), UnitHealthMax(unit)
		if E.Modern then
			if E:NotSecretValue(cur) then
				return format('%s | %.1f%%', AbbreviateNumbers(cur, E.Abbreviate.short), UnitHealthPercent(unit, true, ScaleTo100))
			else
				return AbbreviateNumbers(cur, E.Abbreviate.short)
			end
		else
			local perc = cur / maxhp * 100
			return format('%s | %.1f%%', E:ShortValue(cur, 0), perc)
		end
	end)
	E:AddTagInfo("eltruism:hpstatus:line", ElvUI_EltreumUI.Name.." "..L["Health"], L["Displays HP | % and a status symbol. Can be customized in Eltruism > Media"])

	--reverse of the hpstatus, uses modified elvui tag code
	E:AddTag("eltruism:hpstatus:reverse", "UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION PLAYER_FLAGS_CHANGED UNIT_NAME_UPDATE UNIT_TARGET UNIT_FLAGS PARTY_MEMBER_ENABLE PARTY_MEMBER_DISABLE", function(unit)
		local isConnected = UnitIsConnected(unit)
		if E:NotSecretValue(isConnected) and not isConnected then
			if E.db.ElvUI_EltreumUI.otherstuff.hpstatusdcicon ~= "NONE" then
				return dctexture
			else
				return L["Offline"]
			end
		else
			local feign = UnitIsFeignDeath(unit)
			if not (E:NotSecretValue(feign) and feign) then
				local ghost = UnitIsGhost(unit)
				if E:NotSecretValue(ghost) and ghost then
					if E.db.ElvUI_EltreumUI.otherstuff.ghosttagicon ~= "NONE" then
						return ghosttexture
					else
						return ElvUI_EltreumUI:SpellInfoShapeshift(8326)
					end
				elseif IsUnitDeadHelper(unit) then
					if E.db.ElvUI_EltreumUI.otherstuff.hpstatusdeadicon ~= "NONE" then
						return deadtexture
					else
						return L["Dead"]
					end
				end
			end
		end

		local cur, maxhp = UnitHealth(unit), UnitHealthMax(unit)
		if E.Modern then
			if E:NotSecretValue(cur) then
				return format('%.1f%% - %s', UnitHealthPercent(unit, true, ScaleTo100), AbbreviateNumbers(cur, E.Abbreviate.short))
			else
				return AbbreviateNumbers(cur, E.Abbreviate.short)
			end
		else
			if not maxhp or maxhp == 0 then maxhp = 1 end
			if cur == maxhp then
				return E:ShortValue(cur, nil)
			else
				return E:GetFormattedText('CURRENT_PERCENT', maxhp, cur, nil, true)
			end
		end
	end)
	E:AddTagInfo("eltruism:hpstatus:reverse", ElvUI_EltreumUI.Name.." "..L["Health"], L["Displays % - HP and a status symbol. Can be customized in Eltruism > Media"])

	--no percentage value of other HP tag that switches to a dead symbol or dc symbol depending on the unit status, based on elvui
	E:AddTag("eltruism:hpstatusnopc", "UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION PLAYER_FLAGS_CHANGED UNIT_NAME_UPDATE UNIT_TARGET UNIT_FLAGS PARTY_MEMBER_ENABLE PARTY_MEMBER_DISABLE", function(unit)
		local isConnected = UnitIsConnected(unit)
		if E:NotSecretValue(isConnected) and not isConnected then
			if E.db.ElvUI_EltreumUI.otherstuff.hpstatusdcicon ~= "NONE" then
				return dctexture
			else
				return L["Offline"]
			end
		else
			local feign = UnitIsFeignDeath(unit)
			if not (E:NotSecretValue(feign) and feign) then
				local ghost = UnitIsGhost(unit)
				if E:NotSecretValue(ghost) and ghost then
					if E.db.ElvUI_EltreumUI.otherstuff.ghosttagicon ~= "NONE" then
						return ghosttexture
					else
						return ElvUI_EltreumUI:SpellInfoShapeshift(8326)
					end
				elseif IsUnitDeadHelper(unit) then
					if E.db.ElvUI_EltreumUI.otherstuff.hpstatusdeadicon ~= "NONE" then
						return deadtexture
					else
						return L["Dead"]
					end
				end
			end
		end

		if E.Modern then
			return AbbreviateNumbers(UnitHealth(unit), E.Abbreviate.short)
		else
			return E:ShortValue(UnitHealth(unit), tostring(E.db.general.decimalLength or 1))
		end
	end)
	E:AddTagInfo("eltruism:hpstatusnopc", ElvUI_EltreumUI.Name.." "..L["Health"], L["Displays shortvalue HP and a status symbol from Releaf for players. Usage: [eltruism:hpstatusnopc{number,number}]"])

	--perhp with status icons
	E:AddTag("eltruism:perhpstatus", "UNIT_HEALTH UNIT_MAXHEALTH UNIT_NAME_UPDATE UNIT_CONNECTION PLAYER_FLAGS_CHANGED UNIT_FLAGS PARTY_MEMBER_ENABLE PARTY_MEMBER_DISABLE", function(unit)
		local isConnected = UnitIsConnected(unit)
		if E:NotSecretValue(isConnected) and not isConnected then
			if E.db.ElvUI_EltreumUI.otherstuff.hpstatusdcicon ~= "NONE" then
				return dctexture
			else
				return L["Offline"]
			end
		else
			local feign = UnitIsFeignDeath(unit)
			if not (E:NotSecretValue(feign) and feign) then
				local ghost = UnitIsGhost(unit)
				if E:NotSecretValue(ghost) and ghost then
					if E.db.ElvUI_EltreumUI.otherstuff.ghosttagicon ~= "NONE" then
						return ghosttexture
					else
						return ElvUI_EltreumUI:SpellInfoShapeshift(8326)
					end
				elseif IsUnitDeadHelper(unit) then
					if E.db.ElvUI_EltreumUI.otherstuff.hpstatusdeadicon ~= "NONE" then
						return deadtexture
					else
						return L["Dead"]
					end
				end
			end
		end

		local cur, maxhp = UnitHealth(unit), UnitHealthMax(unit)
		if E.Modern then
			return format('%d%%', UnitHealthPercent(unit, true, ScaleTo100))
		else
			if maxhp == 0 then
				return 0
			else
				return mathfloor(((cur / maxhp) * 100) + 0.5)
			end
		end
	end)
	E:AddTagInfo("eltruism:perhpstatus", ElvUI_EltreumUI.Name.." "..L["Health"], L["Displays percentage health with status icons"])

	--HP tag that switches to a dead symbol or dc symbol depending on the unit status, based on elvui
	E:AddTag("eltruism:hpstatus:gradient", "UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION PLAYER_FLAGS_CHANGED UNIT_NAME_UPDATE UNIT_TARGET UNIT_FLAGS PARTY_MEMBER_ENABLE PARTY_MEMBER_DISABLE", function(unit)
		local isConnected = UnitIsConnected(unit)
		if E:NotSecretValue(isConnected) and not isConnected then
			if E.db.ElvUI_EltreumUI.otherstuff.hpstatusdcicon ~= "NONE" then
				return dctexture
			else
				return L["Offline"]
			end
		else
			local feign = UnitIsFeignDeath(unit)
			if not (E:NotSecretValue(feign) and feign) then
				local ghost = UnitIsGhost(unit)
				if E:NotSecretValue(ghost) and ghost then
					if E.db.ElvUI_EltreumUI.otherstuff.ghosttagicon ~= "NONE" then
						return ghosttexture
					else
						return ElvUI_EltreumUI:SpellInfoShapeshift(8326)
					end
				elseif IsUnitDeadHelper(unit) then
					if E.db.ElvUI_EltreumUI.otherstuff.hpstatusdeadicon ~= "NONE" then
						return deadtexture
					else
						return L["Dead"]
					end
				end
			end
		end

		local isTarget
		if not E.Modern then
			isTarget = E:UnitIsUnit(unit,"target") and not unit:match("nameplate") and not unit:match("party")
		else
			isTarget = false
		end
		local value
		if E.Modern then
			if E:NotSecretValue(UnitHealth(unit)) then
				value = format('%s - %.1f%%', AbbreviateNumbers(UnitHealth(unit), E.Abbreviate.short), UnitHealthPercent(unit, true, ScaleTo100))
			else
				value = AbbreviateNumbers(UnitHealth(unit), E.Abbreviate.short)
			end
		else
			local min, max = UnitHealth(unit), UnitHealthMax(unit)
			value = E:GetFormattedText('CURRENT_PERCENT', min, max, nil, true)
		end
		local lengthOK = false
		if not E.Modern then
			lengthOK = stringlen(value) > 2 and true or false
		end
		if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then --npc
			local reaction = UnitReaction(unit, "player")
			local reactionClass = reaction and reactionToGradient[reaction]
			if reactionClass then
				if not E.Modern and lengthOK then
					return ElvUI_EltreumUI:GradientName(value, reactionClass, isTarget)
				else
					return value
				end
			end
			return value
		else
			local _, unitClass = UnitClass(unit)
			if not unitClass or not E:NotSecretValue(unitClass) then
				return value
			end
			if not E.Modern and lengthOK then
				return ElvUI_EltreumUI:GradientName(value, unitClass, isTarget)
			else
				return value
			end
		end
	end)
	E:AddTagInfo("eltruism:hpstatus:gradient", ElvUI_EltreumUI.Name.." "..L["Health"], L["Displays HP - % and a status symbol. Can be customized in Eltruism > Media"])

	--no percentage value of other HP tag that switches to a dead symbol or dc symbol depending on the unit status, based on elvui
	E:AddTag("eltruism:hpstatusnopc:gradient", "UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION PLAYER_FLAGS_CHANGED UNIT_NAME_UPDATE UNIT_TARGET UNIT_FLAGS PARTY_MEMBER_ENABLE PARTY_MEMBER_DISABLE", function(unit)
		local isConnected = UnitIsConnected(unit)
		if E:NotSecretValue(isConnected) and not isConnected then
			if E.db.ElvUI_EltreumUI.otherstuff.hpstatusdcicon ~= "NONE" then
				return dctexture
			else
				return L["Offline"]
			end
		else
			local feign = UnitIsFeignDeath(unit)
			if not (E:NotSecretValue(feign) and feign) then
				local ghost = UnitIsGhost(unit)
				if E:NotSecretValue(ghost) and ghost then
					if E.db.ElvUI_EltreumUI.otherstuff.ghosttagicon ~= "NONE" then
						return ghosttexture
					else
						return ElvUI_EltreumUI:SpellInfoShapeshift(8326)
					end
				elseif IsUnitDeadHelper(unit) then
					if E.db.ElvUI_EltreumUI.otherstuff.hpstatusdeadicon ~= "NONE" then
						return deadtexture
					else
						return L["Dead"]
					end
				end
			end
		end

		local isTarget
		if not E.Modern then
			isTarget = E:UnitIsUnit(unit,"target") and not unit:match("nameplate") and not unit:match("party")
		else
			isTarget = false
		end
		local value
		if E.Modern then
			value = AbbreviateNumbers(UnitHealth(unit), E.Abbreviate.short)
		else
			value = E:ShortValue(UnitHealth(unit), tostring(E.db.general.decimalLength or 1))
		end
		local lengthOK = false
		if not E.Modern then
			lengthOK = stringlen(value) > 2 and true or false
		end
		if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then --npc
			local reaction = UnitReaction(unit, "player")
			local reactionClass = reaction and reactionToGradient[reaction]
			if reactionClass then
				if not E.Modern and lengthOK then
					return ElvUI_EltreumUI:GradientName(value, reactionClass, isTarget)
				else
					return value
				end
			end
			return value
		else
			local _, unitClass = UnitClass(unit)
			if not unitClass or not E:NotSecretValue(unitClass) then
				return value
			end
			if not E.Modern and lengthOK then
				return ElvUI_EltreumUI:GradientName(value, unitClass, isTarget)
			else
				return value
			end
		end
	end)
	E:AddTagInfo("eltruism:hpstatusnopc:gradient", ElvUI_EltreumUI.Name.." "..L["Health"], L["Displays shortvalue HP and a status symbol from Releaf for players. Usage: [eltruism:hpstatusnopc{number,number}]"])

	--no percentage value of other HP tag that switches to a dead symbol or dc symbol depending on the unit status, based on elvui
	E:AddTag("eltruism:longhpstatusnopc:gradient", "UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION PLAYER_FLAGS_CHANGED UNIT_NAME_UPDATE UNIT_TARGET UNIT_FLAGS PARTY_MEMBER_ENABLE PARTY_MEMBER_DISABLE", function(unit)
		local isConnected = UnitIsConnected(unit)
		if E:NotSecretValue(isConnected) and not isConnected then
			if E.db.ElvUI_EltreumUI.otherstuff.hpstatusdcicon ~= "NONE" then
				return dctexture
			else
				return L["Offline"]
			end
		else
			local feign = UnitIsFeignDeath(unit)
			if not (E:NotSecretValue(feign) and feign) then
				local ghost = UnitIsGhost(unit)
				if E:NotSecretValue(ghost) and ghost then
					if E.db.ElvUI_EltreumUI.otherstuff.ghosttagicon ~= "NONE" then
						return ghosttexture
					else
						return ElvUI_EltreumUI:SpellInfoShapeshift(8326)
					end
				elseif IsUnitDeadHelper(unit) then
					if E.db.ElvUI_EltreumUI.otherstuff.hpstatusdeadicon ~= "NONE" then
						return deadtexture
					else
						return L["Dead"]
					end
				end
			end
		end

		local isTarget
		if not E.Modern then
			isTarget = E:UnitIsUnit(unit,"target") and not unit:match("nameplate") and not unit:match("party")
		else
			isTarget = false
		end
		local value
		if E.Modern then
			value = BreakUpLargeNumbers(UnitHealth(unit))
		else
			value = tostring(UnitHealth(unit))
		end
		local lengthOK = false
		if not E.Modern then
			lengthOK = stringlen(value) > 2 and true or false
		end
		if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then --npc
			local reaction = UnitReaction(unit, "player")
			local reactionClass = reaction and reactionToGradient[reaction]
			if reactionClass then
				if not E.Modern and lengthOK then
					return ElvUI_EltreumUI:GradientName(value, reactionClass, isTarget)
				else
					return value
				end
			end
			return value
		else
			local _, unitClass = UnitClass(unit)
			if not unitClass or not E:NotSecretValue(unitClass) then
				return value
			end
			if not E.Modern and lengthOK then
				return ElvUI_EltreumUI:GradientName(value, unitClass, isTarget)
			else
				return value
			end
		end
	end)
	E:AddTagInfo("eltruism:longhpstatusnopc:gradient", ElvUI_EltreumUI.Name.." "..L["Health"], L["Displays HP and a status symbol from Releaf for players"])

	if not E.Modern then
		--health deficit + perhp
		E:AddTag("eltruism:hpdeficitpc:gradient", "UNIT_HEALTH UNIT_MAXHEALTH UNIT_NAME_UPDATE", function(unit)
			local cur, maxhp = UnitHealth(unit), UnitHealthMax(unit)
			local deficit = maxhp - cur
			local isTarget
			if not E.Modern then --ElvUI_EltreumUI:IsThisASafeSecret(unit,true) then
				isTarget = E:UnitIsUnit(unit,"target") and not unit:match("nameplate") and not unit:match("party")
			else
				isTarget = false
			end
			if deficit > 0 and cur > 0 then
				if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then --npc
					local reaction = UnitReaction(unit, "player")
					local reactionClass = reaction and reactionToGradient[reaction]
					if reactionClass then
						local color1 = ElvUI_EltreumUI:GradientName(format("-%s", E:ShortValue(deficit)), reactionClass, isTarget)
						local color2 = ElvUI_EltreumUI:GradientName(E:GetFormattedText('PERCENT', cur, maxhp), reactionClass, isTarget)
						return format("%s || %s", color1, color2)
					end
				else
					local _, unitClass = UnitClass(unit)
					if not unitClass then return end
					if not E:NotSecretValue(unitClass) then --secret class so do something else
						return format("-%s || %s", E:ShortValue(deficit), E:GetFormattedText('PERCENT', cur, maxhp))
					end
					local color1 = ElvUI_EltreumUI:GradientName(format("-%s", E:ShortValue(deficit)), unitClass, isTarget)
					local color2 = ElvUI_EltreumUI:GradientName(E:GetFormattedText('PERCENT', cur, maxhp), unitClass, isTarget)
					return format("%s || %s", color1, color2)
				end
			end
		end)
		E:AddTagInfo("eltruism:hpdeficitpc:gradient", ElvUI_EltreumUI.Name.." "..L["Health"], L["Displays health lost in shortvalue and current health percentage"])

		--health deficit + perhp
		E:AddTag("eltruism:pchpdeficit:gradient", "UNIT_HEALTH UNIT_MAXHEALTH UNIT_NAME_UPDATE", function(unit)
			local cur, maxhp = UnitHealth(unit), UnitHealthMax(unit)
			local deficit = maxhp - cur
			local isTarget
			if not E.Modern then --ElvUI_EltreumUI:IsThisASafeSecret(unit,true) then
				isTarget = E:UnitIsUnit(unit,"target") and not unit:match("nameplate") and not unit:match("party")
			else
				isTarget = false
			end
			if deficit > 0 and cur > 0 then
				if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then --npc
					local reaction = UnitReaction(unit, "player")
					local reactionClass = reaction and reactionToGradient[reaction]
					if reactionClass then
						local color1 = ElvUI_EltreumUI:GradientName(E:GetFormattedText('PERCENT', cur, maxhp), reactionClass, isTarget)
						local color2 = ElvUI_EltreumUI:GradientName(format("-%s", E:ShortValue(deficit)), reactionClass, isTarget)
						return format("%s || %s", color1, color2)
					end
				else
					local _, unitClass = UnitClass(unit)
					if not unitClass then return end
					if not E:NotSecretValue(unitClass) then --secret class so do something else
						return format("%s || -%s", E:GetFormattedText('PERCENT', cur, maxhp), E:ShortValue(deficit))
					end
					local color1 = ElvUI_EltreumUI:GradientName(E:GetFormattedText('PERCENT', cur, maxhp), unitClass, isTarget)
					local color2 = ElvUI_EltreumUI:GradientName(format("-%s", E:ShortValue(deficit)), unitClass, isTarget)
					return format("%s || %s", color1, color2)
				end
			end
		end)
		E:AddTagInfo("eltruism:pchpdeficit:gradient", ElvUI_EltreumUI.Name.." "..L["Health"], L["Displays current health percentage and health lost in shortvalue"])

		--health:current-max-percent:shortvalue but gradient
		E:AddTag("eltruism:healthcurrentmaxpercentshort:gradient", 'UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION PLAYER_FLAGS_CHANGED UNIT_NAME_UPDATE UNIT_TARGET UNIT_FLAGS PARTY_MEMBER_ENABLE PARTY_MEMBER_DISABLE', function(unit)
			local status = not UnitIsConnected(unit) and L["Offline"] or (not UnitIsFeignDeath(unit) and (UnitIsGhost(unit) and L["Ghost"] or IsUnitDeadHelper(unit) and L["Dead"]))
			local isTarget
			if not E.Modern then --ElvUI_EltreumUI:IsThisASafeSecret(unit,true) then
				isTarget = E:UnitIsUnit(unit,"target") and not unit:match("nameplate") and not unit:match("party")
			else
				isTarget = false
			end
			if status then
				return status
			else
				local _, unitClass = UnitClass(unit)
				local value, perctext, perc
				local min = UnitHealth(unit)
				local max = UnitHealthMax(unit)
				if min == max then
					value = E:ShortValue(min, 0)
					perctext = ""
					perc = " "
				else
					value = format("%s - %s", E:ShortValue(min, 0), E:ShortValue(max, 0))
					if E:NotSecretValue(unitClass) then --secret class so do something else
						perctext = format("|c%s || |r", ElvUI_EltreumUI:classcolorcast(unitClass))
					else
						local classColor = GetClassColor(unitClass)
						local hex = classColor and ElvUI_EltreumUI:Hex(classColor) or '|cFFcccccc'
						perctext = format("|c%s || |r", hex)
					end
					perc = format("%.1f%%", min / max * 100)
				end
				if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then --npc
					local reaction = UnitReaction(unit, "player")
					local reactionClass = reaction and reactionToGradient[reaction]
					if reactionClass then
						local vColor = ElvUI_EltreumUI:GradientName(value, reactionClass, isTarget)
						local pColor = ElvUI_EltreumUI:GradientName(perc, reactionClass, isTarget)
						return format("%s%s%s", vColor, perctext, pColor)
					end
					return value
				else
					if not unitClass then return value end
					if not E:NotSecretValue(unitClass) then --secret class so do something else
						return format("%s%s", value, perctext)
					end
					local vColor = ElvUI_EltreumUI:GradientName(value, unitClass, isTarget)
					local pColor = ElvUI_EltreumUI:GradientName(perc, unitClass, isTarget)
					return format("%s%s%s", vColor, perctext, pColor)
				end
			end
		end)
		E:AddTagInfo("eltruism:healthcurrentmaxpercentshort:gradient", ElvUI_EltreumUI.Name.." "..L["Health"], L["Displays current health, max health and percentage of health in shortvalue"])

		--health deficit + perhp
		E:AddTag("eltruism:pchpdeficit", "UNIT_HEALTH UNIT_MAXHEALTH UNIT_NAME_UPDATE", function(unit)
			local cur, maxhp = UnitHealth(unit), UnitHealthMax(unit)
			local deficit = maxhp - cur

			if deficit > 0 and cur > 0 then
				return format("%s | -%s", E:GetFormattedText('PERCENT', cur, maxhp), E:ShortValue(deficit))
			end
		end)
		E:AddTagInfo("eltruism:pchpdeficit", ElvUI_EltreumUI.Name.." "..L["Health"], L["Displays current health percentage and health lost in shortvalue"])

		--health deficit + perhp
		E:AddTag("eltruism:hpdeficitpc", "UNIT_HEALTH UNIT_MAXHEALTH UNIT_NAME_UPDATE", function(unit)
			local cur, maxhp = UnitHealth(unit), UnitHealthMax(unit)
			local deficit = maxhp - cur

			if deficit > 0 and cur > 0 then
				return format("-%s | %s", E:ShortValue(deficit), E:GetFormattedText('PERCENT', cur, maxhp))
			end
		end)
		E:AddTagInfo("eltruism:hpdeficitpc", ElvUI_EltreumUI.Name.." "..L["Health"], L["Displays health lost in shortvalue and current health percentage"])

		E:AddTag("eltruism:effectivehp", "UNIT_HEALTH UNIT_TARGET", function()
			local dr
			if UnitExists("target") then
				dr = (UnitArmor("player") / ((UnitLevel("target") * 467.5) + UnitArmor("player") - 22167.5))
				--dr = (UnitArmor("player")/((UnitLevel('target')*467.5)+UnitHealthMax("player")-22167.5))
			else
				dr = (UnitArmor("player") / ((UnitLevel("player") * 467.5) + UnitArmor("player") - 22167.5))
				--dr = (UnitArmor("player")/((UnitLevel('player')*467.5)+UnitHealthMax("player")-22167.5))
			end
			local ehp = UnitHealthMax("player") / (1 - dr)
			local effective = mathfloor(ehp)
			return effective
		end)
		E:AddTagInfo("eltruism:effectivehp", ElvUI_EltreumUI.Name.." "..L["Health"], L["Shows Effective Health"])

		--shortvalue at max health, percent when lost
		E:AddTag("eltruism:shortmaxlostpc", "UNIT_HEALTH UNIT_MAXHEALTH UNIT_NAME_UPDATE", function(unit)
			local cur, maxhp = UnitHealth(unit), UnitHealthMax(unit)
			local deficit = maxhp - cur
			if cur > 0 then
				if deficit > 0 then
					return E:GetFormattedText('PERCENT', cur, maxhp)
				else
					return E:ShortValue(cur)
				end
			end
		end)
		E:AddTagInfo("eltruism:shortmaxlostpc", ElvUI_EltreumUI.Name.." "..L["Health"], L["Displays short value at max health, percentage at health lost"])

		--full value at max health, percent when lost
		E:AddTag("eltruism:hpmaxlostpc", "UNIT_HEALTH UNIT_MAXHEALTH UNIT_NAME_UPDATE", function(unit)
			local cur, maxhp = UnitHealth(unit), UnitHealthMax(unit)
			local deficit = maxhp - cur
			if cur > 0 then
				if deficit > 0 then
					return E:GetFormattedText('PERCENT', cur, maxhp)
				else
					return cur
				end
			end
		end)
		E:AddTagInfo("eltruism:hpmaxlostpc", ElvUI_EltreumUI.Name.." "..L["Health"], L["Displays full value at max health, percentage at health lost"])
	end
end
