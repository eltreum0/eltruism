local E, L = unpack(ElvUI)
local _G = _G
local DT = E:GetModule("DataTexts")
local RANGED_ATTACK_POWER = _G.RANGED_ATTACK_POWER
local HIT = _G.HIT
local ITEM_MOD_HIT_RANGED_RATING_SHORT = _G.ITEM_MOD_HIT_RANGED_RATING_SHORT
local STAT_HASTE = _G.STAT_HASTE
local ATTACK_POWER = _G.ATTACK_POWER
local SPEC_FRAME_PRIMARY_STAT_STRENGTH = _G.SPEC_FRAME_PRIMARY_STAT_STRENGTH
local SPEC_FRAME_PRIMARY_STAT_AGILITY = _G.SPEC_FRAME_PRIMARY_STAT_AGILITY
local SPEC_FRAME_PRIMARY_STAT_INTELLECT = _G.SPEC_FRAME_PRIMARY_STAT_INTELLECT
local MELEE_ATTACK_POWER = _G.MELEE_ATTACK_POWER
local ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT = _G.ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT
local ITEM_MOD_SPIRIT_SHORT = _G.ITEM_MOD_SPIRIT_SHORT
local STAT_EXPERTISE = _G.STAT_EXPERTISE
local CRIT_ABBR = _G.CRIT_ABBR
local STAT_MASTERY = _G.STAT_MASTERY
local STAT_VERSATILITY = _G.STAT_VERSATILITY
local STAT_RESILIENCE = _G.STAT_RESILIENCE
local STAT_CRITICAL_STRIKE = _G.STAT_CRITICAL_STRIKE
local ITEM_MOD_HIT_SPELL_RATING_SHORT = _G.ITEM_MOD_HIT_SPELL_RATING_SHORT
local STAT_SPEED = _G.STAT_SPEED
local STAT_LIFESTEAL = _G.STAT_LIFESTEAL
local STAT_AVOIDANCE = _G.STAT_AVOIDANCE
local string = _G.string
local LE_UNIT_STAT_STRENGTH = _G.LE_UNIT_STAT_STRENGTH
local LE_UNIT_STAT_AGILITY = _G.LE_UNIT_STAT_AGILITY
local LE_UNIT_STAT_INTELLECT = _G.LE_UNIT_STAT_INTELLECT
local ITEM_MOD_SPELL_POWER_SHORT = _G.ITEM_MOD_SPELL_POWER_SHORT
local ITEM_MOD_HIT_MELEE_RATING_SHORT = _G.ITEM_MOD_HIT_MELEE_RATING_SHORT
local STAT_CATEGORY_ENHANCEMENTS = _G.STAT_CATEGORY_ENHANCEMENTS
local ITEM_MOD_SPELL_PENETRATION_SHORT = _G.ITEM_MOD_SPELL_PENETRATION_SHORT
local CR_RESILIENCE_CRIT_TAKEN = _G.CR_RESILIENCE_CRIT_TAKEN
local GetCombatRatingBonus = _G.GetCombatRatingBonus
local GetSpellBonusDamage = _G.GetSpellBonusDamage
local GetVersatilityBonus = _G.GetVersatilityBonus
local GetMasteryEffect = _G.GetMasteryEffect
local GetSpellBonusHealing = _G.GetSpellBonusHealing
local UnitAttackPower = _G.UnitAttackPower
local UnitRangedAttackPower = _G.UnitRangedAttackPower
local math = _G.math
local UnitStat = _G.UnitStat
local GetHaste = _G.GetHaste
local GetCritChance = _G.GetCritChance
local GetAvoidance = _G.GetAvoidance
local GetLifesteal = _G.GetLifesteal
local GetSpeed = _G.GetSpeed
local GetSpellCritChance = _G.GetSpellCritChance
local GetRangedCritChance = _G.GetRangedCritChance
local GetExpertise = _G.GetExpertise
local GetArmorPenetration = _G.GetArmorPenetration
local GetMeleeHaste= _G.GetMeleeHaste
local GetRangedHaste = _G.GetRangedHaste
local UnitLevel = _G.UnitLevel
local tostring = _G.tostring
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------stats datatext
local function EltruismStatsDatatextOnEnter()
	local basestat1, currentstat1, statbuff1, statnerf1 = UnitStat('player', LE_UNIT_STAT_STRENGTH)
	local basestat2, currentstat2, statbuff2, statnerf2 = UnitStat('player', LE_UNIT_STAT_AGILITY)
	local basestat3, currentstat3, statbuff3, statnerf3 = UnitStat('player', LE_UNIT_STAT_INTELLECT)
	local basestatlabel, basestat, currentstat,statbuff,statnerf

	if currentstat1 > currentstat2 and currentstat1 > currentstat3 then
		basestatlabel = SPEC_FRAME_PRIMARY_STAT_STRENGTH
		basestat = basestat1
		currentstat = currentstat1
		statbuff = statbuff1
		statnerf = statnerf1
	elseif currentstat2 > currentstat1 and currentstat2 > currentstat3 then
		basestatlabel = SPEC_FRAME_PRIMARY_STAT_AGILITY
		basestat = basestat2
		currentstat = currentstat2
		statbuff = statbuff2
		statnerf = statnerf2
	elseif currentstat3 > currentstat2 and currentstat3 > currentstat1 then
		basestatlabel = SPEC_FRAME_PRIMARY_STAT_INTELLECT
		basestat = basestat3
		currentstat = currentstat3
		statbuff = statbuff3
		statnerf = statnerf3
	else
		basestatlabel = SPEC_FRAME_PRIMARY_STAT_STRENGTH
		basestat = basestat1
		currentstat = currentstat1
		statbuff = statbuff1
		statnerf = statnerf1
	end

	if E.Retail then
		local retailhaste = GetHaste()
		local retailcrit = GetCritChance()
		local versdmg = GetCombatRatingBonus(29) + GetVersatilityBonus(29)
		local versdef = GetCombatRatingBonus(31) + GetVersatilityBonus(31)
		local avoidance = GetAvoidance()
		local leech = GetLifesteal()
		local speed = GetSpeed()

		DT.tooltip:ClearLines()
		DT.tooltip:AddDoubleLine(basestatlabel..":", ElvUI[1].media.hexvaluecolor..currentstat.."|r",1,1,1)

		--add line here
		DT.tooltip:AddLine(' ')

		DT.tooltip:AddDoubleLine(STAT_CRITICAL_STRIKE..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", retailcrit).."|r",1,1,1)
		DT.tooltip:AddDoubleLine(STAT_HASTE..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", retailhaste).."|r",1,1,1)
		DT.tooltip:AddDoubleLine(STAT_MASTERY..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetMasteryEffect()).."|r",1,1,1)
		DT.tooltip:AddDoubleLine(STAT_VERSATILITY..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", math.max(versdef,versdmg)).."|r",1,1,1)

		--add line here
		DT.tooltip:AddLine(' ')

		DT.tooltip:AddDoubleLine(STAT_AVOIDANCE..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", avoidance).."|r",1,1,1)
		DT.tooltip:AddDoubleLine(STAT_LIFESTEAL..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", leech).."|r",1,1,1)
		DT.tooltip:AddDoubleLine(STAT_SPEED..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", speed).."|r",1,1,1)
		DT.tooltip:Show()
	else

		--power
		local rangedbasepower, rangedbuff, rangednerf = UnitRangedAttackPower('player')
		local totalranged = rangedbasepower+rangedbuff+rangednerf

		local meleebasepower, meleebuff, meleenerf = UnitAttackPower('player')
		local totalmelee = meleebasepower+meleebuff+meleenerf

		local spellpower = math.max(GetSpellBonusDamage(2),GetSpellBonusDamage(3),GetSpellBonusDamage(4),GetSpellBonusDamage(5),GetSpellBonusDamage(6),GetSpellBonusDamage(7),GetSpellBonusHealing())
		local spellcrit = math.max(GetSpellCritChance(2),GetSpellCritChance(3),GetSpellCritChance(4),GetSpellCritChance(5),GetSpellCritChance(6),GetSpellCritChance(7))

		DT.tooltip:ClearLines()
		DT.tooltip:AddDoubleLine(basestatlabel..":", ElvUI[1].media.hexvaluecolor..currentstat.."|r ".."(|cffFFFFFF"..(basestat-statbuff+statnerf).."|r + |cff09ff00"..statbuff.."|r - |cfff44336"..statnerf.."|r)",1,1,1)

		--add line here
		DT.tooltip:AddLine(' ')
		if E.myclass == "HUNTER" then
			DT.tooltip:AddDoubleLine(RANGED_ATTACK_POWER..":", ElvUI[1].media.hexvaluecolor..totalranged.."|r", 1, 1, 1)
			if not E.Classic then
				DT.tooltip:AddDoubleLine(ITEM_MOD_HIT_RANGED_RATING_SHORT..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetCombatRatingBonus(7)).."|r",1,1,1) --GetCombatRatingBonus(CR_HIT_RANGED)
			else
				DT.tooltip:AddDoubleLine(ITEM_MOD_HIT_RANGED_RATING_SHORT..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetHitModifier()).."|r",1,1,1) --GetCombatRatingBonus(CR_HIT_RANGED)
			end
			DT.tooltip:AddDoubleLine(STAT_HASTE..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetRangedHaste()).."|r",1,1,1)
			DT.tooltip:AddDoubleLine(STAT_CRITICAL_STRIKE..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetRangedCritChance()).."|r",1,1,1)
			DT.tooltip:AddLine(' ')
			DT.tooltip:AddDoubleLine(ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetArmorPenetration()).."|r",1,1,1)
		elseif E.myclass == "WARLOCK" or E.myclass == "MAGE" or E.myclass == "PRIEST" then
			DT.tooltip:AddDoubleLine(ITEM_MOD_SPELL_POWER_SHORT..":", ElvUI[1].media.hexvaluecolor..spellpower.."|r", 1, 1, 1)
			if E.Wrath then
				DT.tooltip:AddDoubleLine(ITEM_MOD_HIT_SPELL_RATING_SHORT..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetCombatRatingBonus(8)).."|r",1,1,1) --GetCombatRatingBonus(CR_HIT_SPELL)
				DT.tooltip:AddDoubleLine(STAT_HASTE..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetCombatRatingBonus(20)).."|r",1,1,1) --GetCombatRatingBonus(CR_HASTE_SPELL)
				DT.tooltip:AddDoubleLine(STAT_CRITICAL_STRIKE..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetSpellCritChance(2)).."|r",1,1,1)
			else
				DT.tooltip:AddDoubleLine(ITEM_MOD_HIT_SPELL_RATING_SHORT..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", (GetSpellHitModifier()/7)).."|r",1,1,1) --GetCombatRatingBonus(CR_HIT_SPELL)
				DT.tooltip:AddDoubleLine(STAT_HASTE..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetHaste()).."|r",1,1,1) --GetCombatRatingBonus(CR_HASTE_SPELL)
				DT.tooltip:AddDoubleLine(STAT_CRITICAL_STRIKE..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", spellcrit).."|r",1,1,1)
			end
			DT.tooltip:AddLine(' ')
			DT.tooltip:AddDoubleLine(ITEM_MOD_SPELL_PENETRATION_SHORT..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetSpellPenetration()).."|r",1,1,1)
			DT.tooltip:AddDoubleLine(ITEM_MOD_SPIRIT_SHORT..":", ElvUI[1].media.hexvaluecolor..UnitStat("player", 5).."|r",1,1,1)
		elseif E.myclass == "SHAMAN" or E.myclass == "DRUID" or E.myclass == "PALADIN" then
			local _, _, spent1 = _G.GetTalentTabInfo(1)
			local _, _, spent2 = _G.GetTalentTabInfo(2)
			local _, _, spent3 = _G.GetTalentTabInfo(3)
			if E.myclass == "SHAMAN" or E.myclass == "DRUID" then
				if spent2 > spent3 and spent2 > spent1 then
					DT.tooltip:AddDoubleLine(MELEE_ATTACK_POWER..":", ElvUI[1].media.hexvaluecolor..totalmelee.."|r", 1, 1, 1)
					DT.tooltip:AddDoubleLine(ITEM_MOD_HIT_MELEE_RATING_SHORT..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetCombatRatingBonus(6)).."|r",1,1,1) --GetCombatRatingBonus(CR_HIT_MELEE)
					DT.tooltip:AddDoubleLine(STAT_HASTE..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetMeleeHaste()).."|r",1,1,1)
					DT.tooltip:AddDoubleLine(STAT_CRITICAL_STRIKE..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetCritChance()).."|r",1,1,1)
					DT.tooltip:AddLine(' ')
					DT.tooltip:AddDoubleLine(ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetArmorPenetration()).."|r",1,1,1)
					DT.tooltip:AddDoubleLine(STAT_EXPERTISE..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetExpertise()*0.25).."|r", 1, 1, 1)
				else
					DT.tooltip:AddDoubleLine(ITEM_MOD_SPELL_POWER_SHORT..":", ElvUI[1].media.hexvaluecolor..spellpower.."|r", 1, 1, 1)
					if E.Wrath then
						DT.tooltip:AddDoubleLine(ITEM_MOD_HIT_SPELL_RATING_SHORT..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetCombatRatingBonus(8)).."|r",1,1,1) --GetCombatRatingBonus(CR_HIT_SPELL)
						DT.tooltip:AddDoubleLine(STAT_HASTE..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetCombatRatingBonus(20)).."|r",1,1,1) --GetCombatRatingBonus(CR_HASTE_SPELL)
						DT.tooltip:AddDoubleLine(STAT_CRITICAL_STRIKE..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetSpellCritChance(2)).."|r",1,1,1)
					else
						DT.tooltip:AddDoubleLine(ITEM_MOD_HIT_SPELL_RATING_SHORT..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", (GetSpellHitModifier()/7)).."|r",1,1,1) --GetCombatRatingBonus(CR_HIT_SPELL)
						DT.tooltip:AddDoubleLine(STAT_HASTE..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetHaste()).."|r",1,1,1) --GetCombatRatingBonus(CR_HASTE_SPELL)
						DT.tooltip:AddDoubleLine(STAT_CRITICAL_STRIKE..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", spellcrit).."|r",1,1,1)
					end
					DT.tooltip:AddLine(' ')
					DT.tooltip:AddDoubleLine(ITEM_MOD_SPELL_PENETRATION_SHORT..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetSpellPenetration()).."|r",1,1,1)
					DT.tooltip:AddDoubleLine(ITEM_MOD_SPIRIT_SHORT..":", ElvUI[1].media.hexvaluecolor..UnitStat("player", 5).."|r",1,1,1)
				end
			elseif E.myclass == "PALADIN" then
				if spent1 > spent3 and spent1 > spent2 then
					DT.tooltip:AddDoubleLine(ITEM_MOD_SPELL_POWER_SHORT..":", ElvUI[1].media.hexvaluecolor..spellpower.."|r", 1, 1, 1)
					if E.Wrath then
						DT.tooltip:AddDoubleLine(ITEM_MOD_HIT_SPELL_RATING_SHORT..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetCombatRatingBonus(8)).."|r",1,1,1) --GetCombatRatingBonus(CR_HIT_SPELL)
						DT.tooltip:AddDoubleLine(STAT_HASTE..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetCombatRatingBonus(20)).."|r",1,1,1) --GetCombatRatingBonus(CR_HASTE_SPELL)
						DT.tooltip:AddDoubleLine(STAT_CRITICAL_STRIKE..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetSpellCritChance(2)).."|r",1,1,1)
					else
						DT.tooltip:AddDoubleLine(ITEM_MOD_HIT_SPELL_RATING_SHORT..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", (GetSpellHitModifier()/7)).."|r",1,1,1) --GetCombatRatingBonus(CR_HIT_SPELL)
						DT.tooltip:AddDoubleLine(STAT_HASTE..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetHaste()).."|r",1,1,1) --GetCombatRatingBonus(CR_HASTE_SPELL)
						DT.tooltip:AddDoubleLine(STAT_CRITICAL_STRIKE..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", spellcrit).."|r",1,1,1)
					end
					DT.tooltip:AddLine(' ')
					DT.tooltip:AddDoubleLine(ITEM_MOD_SPELL_PENETRATION_SHORT..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetSpellPenetration()).."|r",1,1,1)
					DT.tooltip:AddDoubleLine(ITEM_MOD_SPIRIT_SHORT..":", ElvUI[1].media.hexvaluecolor..UnitStat("player", 5).."|r",1,1,1)
				else
					DT.tooltip:AddDoubleLine(MELEE_ATTACK_POWER..":", ElvUI[1].media.hexvaluecolor..totalmelee.."|r", 1, 1, 1)
					DT.tooltip:AddDoubleLine(ITEM_MOD_HIT_MELEE_RATING_SHORT..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetCombatRatingBonus(6)).."|r",1,1,1) --GetCombatRatingBonus(CR_HIT_MELEE)
					DT.tooltip:AddDoubleLine(STAT_HASTE..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetMeleeHaste()).."|r",1,1,1)
					DT.tooltip:AddDoubleLine(STAT_CRITICAL_STRIKE..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetCritChance()).."|r",1,1,1)
					DT.tooltip:AddLine(' ')
					DT.tooltip:AddDoubleLine(ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetArmorPenetration()).."|r",1,1,1)
					DT.tooltip:AddDoubleLine(STAT_EXPERTISE..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetExpertise()*0.25).."|r", 1, 1, 1)
				end
			end
		else
			DT.tooltip:AddDoubleLine(MELEE_ATTACK_POWER..":", ElvUI[1].media.hexvaluecolor..totalmelee.."|r", 1, 1, 1)
			DT.tooltip:AddDoubleLine(ITEM_MOD_HIT_MELEE_RATING_SHORT..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetCombatRatingBonus(6)).."|r",1,1,1) --GetCombatRatingBonus(CR_HIT_MELEE)
			DT.tooltip:AddDoubleLine(STAT_HASTE..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetMeleeHaste()).."|r",1,1,1)
			DT.tooltip:AddDoubleLine(STAT_CRITICAL_STRIKE..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetCritChance()).."|r",1,1,1)
			DT.tooltip:AddLine(' ')
			DT.tooltip:AddDoubleLine(ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetArmorPenetration()).."|r",1,1,1)
			DT.tooltip:AddDoubleLine(STAT_EXPERTISE..":", ElvUI[1].media.hexvaluecolor..string.format("%.2f%%", GetExpertise()*0.25).."|r", 1, 1, 1)
		end
		if not E.Classic then
			DT.tooltip:AddDoubleLine(STAT_RESILIENCE..":", ElvUI[1].media.hexvaluecolor..GetCombatRating(CR_RESILIENCE_CRIT_TAKEN).."|r", 1, 1, 1)
		end
		DT.tooltip:Show()
	end
end

--haste and crit datatext
local function EltruismStatsDatatext1(dt)
	if E.Retail then
		local retailhaste = GetHaste()
		local retailcrit = GetCritChance()
		local haste = STAT_HASTE..": "..ElvUI[1].media.hexvaluecolor..string.format("%.1f%%", retailhaste).."|r"
		local crit = CRIT_ABBR..": "..ElvUI[1].media.hexvaluecolor..string.format("%.1f%%", retailcrit).."|r"

		dt.text:SetFormattedText('%s %s|r',crit,haste)
	else
		local haste
		local crit
		local spellcrit = math.max(GetSpellCritChance(2),GetSpellCritChance(3),GetSpellCritChance(4),GetSpellCritChance(5),GetSpellCritChance(6),GetSpellCritChance(7))

		if E.myclass == "HUNTER" then
			haste = STAT_HASTE..": "..ElvUI[1].media.hexvaluecolor..string.format("%.1f%%", GetHaste()).."|r"
			crit = CRIT_ABBR..": "..ElvUI[1].media.hexvaluecolor..string.format("%.1f%%", GetRangedCritChance()).."|r"
		elseif E.myclass == "WARLOCK" or E.myclass == "MAGE" or E.myclass == "PRIEST" then
			if E.Wrath then
				haste = STAT_HASTE..": "..ElvUI[1].media.hexvaluecolor..string.format("%.1f%%", GetCombatRatingBonus(20)).."|r" --GetCombatRatingBonus(CR_HASTE_SPELL)
				crit = CRIT_ABBR..": "..ElvUI[1].media.hexvaluecolor..string.format("%.1f%%", GetSpellCritChance(2)).."|r"
			else
				haste = STAT_HASTE..": "..ElvUI[1].media.hexvaluecolor..string.format("%.1f%%", GetHaste()).."|r" --GetCombatRatingBonus(CR_HASTE_SPELL)
				crit = CRIT_ABBR..": "..ElvUI[1].media.hexvaluecolor..string.format("%.1f%%", spellcrit).."|r"
			end
		elseif E.myclass == "SHAMAN" or E.myclass == "DRUID" or E.myclass == "PALADIN" then
			local _, _, spent1 = _G.GetTalentTabInfo(1)
			local _, _, spent2 = _G.GetTalentTabInfo(2)
			local _, _, spent3 = _G.GetTalentTabInfo(3)
			if E.myclass == "SHAMAN" or E.myclass == "DRUID" then
				if spent2 > spent3 and spent2 > spent1 then
					haste = STAT_HASTE..": "..ElvUI[1].media.hexvaluecolor..string.format("%.1f%%", GetHaste()).."|r"
					crit = CRIT_ABBR..": "..ElvUI[1].media.hexvaluecolor..string.format("%.1f%%", GetCritChance()).."|r"
				else
					if E.Wrath then
						haste = STAT_HASTE..": "..ElvUI[1].media.hexvaluecolor..string.format("%.1f%%", GetCombatRatingBonus(20)).."|r" --GetCombatRatingBonus(CR_HASTE_SPELL)
						crit = CRIT_ABBR..": "..ElvUI[1].media.hexvaluecolor..string.format("%.1f%%", GetSpellCritChance(2)).."|r"
					else
						haste = STAT_HASTE..": "..ElvUI[1].media.hexvaluecolor..string.format("%.1f%%", GetHaste()).."|r" --GetCombatRatingBonus(CR_HASTE_SPELL)
						crit = CRIT_ABBR..": "..ElvUI[1].media.hexvaluecolor..string.format("%.1f%%", spellcrit).."|r"
					end
				end
			elseif E.myclass == "PALADIN" then
				if spent1 > spent3 and spent1 > spent2 then
					if E.Wrath then
						haste = STAT_HASTE..": "..ElvUI[1].media.hexvaluecolor..string.format("%.1f%%", GetCombatRatingBonus(20)).."|r" --GetCombatRatingBonus(CR_HASTE_SPELL)
						crit = CRIT_ABBR..": "..ElvUI[1].media.hexvaluecolor..string.format("%.1f%%", GetSpellCritChance(2)).."|r"
					else
						haste = STAT_HASTE..": "..ElvUI[1].media.hexvaluecolor..string.format("%.1f%%", GetHaste()).."|r" --GetCombatRatingBonus(CR_HASTE_SPELL)
						crit = CRIT_ABBR..": "..ElvUI[1].media.hexvaluecolor..string.format("%.1f%%", spellcrit).."|r"
					end
				else
					haste = STAT_HASTE..": "..ElvUI[1].media.hexvaluecolor..string.format("%.1f%%", GetHaste()).."|r"
					crit = CRIT_ABBR..": "..ElvUI[1].media.hexvaluecolor..string.format("%.1f%%", GetCritChance()).."|r"
				end
			end
		else
			haste = STAT_HASTE..": "..ElvUI[1].media.hexvaluecolor..string.format("%.1f%%", GetHaste()).."|r"
			crit = CRIT_ABBR..": "..ElvUI[1].media.hexvaluecolor..string.format("%.1f%%", GetCritChance()).."|r"
		end
		dt.text:SetFormattedText('%s %s|r',crit,haste)
	end
end
DT:RegisterDatatext('Eltruism Stats 1', STAT_CATEGORY_ENHANCEMENTS, {'COMBAT_RATING_UPDATE',"UNIT_STATS","UNIT_SPELL_HASTE","UNIT_DAMAGE","UNIT_ATTACK_SPEED","SPELL_POWER_CHANGED"}, EltruismStatsDatatext1, nil, nil, EltruismStatsDatatextOnEnter, nil, L["Eltruism Stats 1"])

--mastery/vers or power/hit
local function EltruismStatsDatatext2(dt)
	if E.Retail then
		--mastery
		local mastery = STAT_MASTERY..": "..ElvUI[1].media.hexvaluecolor..string.format("%.1f%%", GetMasteryEffect()).."|r"
		--versatility
		local versdmg = GetCombatRatingBonus(29) + GetVersatilityBonus(29)
		local versdef = GetCombatRatingBonus(31) + GetVersatilityBonus(31)
		local versatilitylabel = E:ShortenString(STAT_VERSATILITY, 4)
		local versatility = versatilitylabel..": "..ElvUI[1].media.hexvaluecolor..string.format("%.1f%%", math.max(versdef,versdmg)).."|r"
		dt.text:SetFormattedText('%s %s|r',mastery,versatility)
	else
		--power
		local rangedbasepower, rangedbuff, rangednerf = UnitRangedAttackPower('player')
		local totalranged = rangedbasepower+rangedbuff+rangednerf

		local meleebasepower, meleebuff, meleenerf = UnitAttackPower('player')
		local totalmelee = meleebasepower+meleebuff+meleenerf

		local spellpower = math.max(GetSpellBonusDamage(2),GetSpellBonusDamage(3),GetSpellBonusDamage(4),GetSpellBonusDamage(5),GetSpellBonusDamage(6),GetSpellBonusDamage(7),GetSpellBonusHealing())

		local tmeleepower = ATTACK_POWER..": "..ElvUI[1].media.hexvaluecolor..totalmelee.."|r"
		local trangedpower = ATTACK_POWER..": "..ElvUI[1].media.hexvaluecolor..totalranged.."|r"
		local tspellpower = ATTACK_POWER..": "..ElvUI[1].media.hexvaluecolor..spellpower.."|r"

		--hit rating
		local tspellhit = HIT..": "..ElvUI[1].media.hexvaluecolor..string.format("%.1f%%", GetCombatRatingBonus(8)).."|r" --GetCombatRatingBonus(CR_HIT_SPELL)
		local tmeleehit = HIT..": "..ElvUI[1].media.hexvaluecolor..string.format("%.1f%%", GetCombatRatingBonus(6)).."|r" --GetCombatRatingBonus(CR_HIT_MELEE)
		local trangedhit = HIT..": "..ElvUI[1].media.hexvaluecolor..string.format("%.1f%%", GetCombatRatingBonus(7)).."|r" --GetCombatRatingBonus(CR_HIT_RANGED)
		if E.Classic then
			tspellhit = HIT..": "..ElvUI[1].media.hexvaluecolor..string.format("%.1f%%", (GetSpellHitModifier()/7)).."|r" --GetCombatRatingBonus(CR_HIT_SPELL)
			tmeleehit = HIT..": "..ElvUI[1].media.hexvaluecolor..string.format("%.1f%%", GetHitModifier()).."|r" --GetCombatRatingBonus(CR_HIT_MELEE)
			trangedhit = tmeleehit
		end

		if E.myclass == "HUNTER" then
			dt.text:SetFormattedText('%s %s|r',trangedpower,trangedhit)
		elseif E.myclass == "WARLOCK" or E.myclass == "MAGE" or E.myclass == "PRIEST" then
			dt.text:SetFormattedText('%s %s|r',tspellpower,tspellhit)
		elseif E.myclass == "SHAMAN" or E.myclass == "DRUID" or E.myclass == "PALADIN" then
			local _, _, spent1 = _G.GetTalentTabInfo(1)
			local _, _, spent2 = _G.GetTalentTabInfo(2)
			local _, _, spent3 = _G.GetTalentTabInfo(3)
			if E.myclass == "SHAMAN" or E.myclass == "DRUID" then
				if spent2 > spent3 and spent2 > spent1 then
					dt.text:SetFormattedText('%s %s|r',tmeleepower,tmeleehit)
				else
					dt.text:SetFormattedText('%s %s|r',tspellpower,tspellhit)
				end
			elseif E.myclass == "PALADIN" then
				if spent1 > spent3 and spent1 > spent2 then
					dt.text:SetFormattedText('%s %s|r',tspellpower,tspellhit)
				else
					dt.text:SetFormattedText('%s %s|r',tmeleepower,tmeleehit)
				end
			end
		else
			dt.text:SetFormattedText('%s %s|r',tmeleepower,tmeleehit)
		end
	end
end
DT:RegisterDatatext('Eltruism Stats 2', STAT_CATEGORY_ENHANCEMENTS, {'COMBAT_RATING_UPDATE',"UNIT_STATS","UNIT_RANGEDDAMAGE","UNIT_ATTACK_POWER","UNIT_RANGED_ATTACK_POWER","UNIT_ATTACK","MASTERY_UPDATE","UNIT_DAMAGE","SPELL_POWER_CHANGED","PLAYER_DAMAGE_DONE_MODS"}, EltruismStatsDatatext2, nil, nil, EltruismStatsDatatextOnEnter, nil, L["Eltruism Stats 2"])

--wrath avoidance and defense,based on https://wago.io/qYKsfPe_W
if not E.Retail then
	local UnitDefense = _G.UnitDefense
	local DEFENSE = _G.DEFENSE
	local function EltruismStatsDatatext3(dt)
		--defense
		local defense = E:ShortenString(DEFENSE, 3)..": "..ElvUI[1].media.hexvaluecolor..(select(1, UnitDefense("player"))) + (select(2, UnitDefense("player"))).."|r"
		--avoidance
		local miss = 5 + (((select(1, UnitDefense("player"))) + (select(2, UnitDefense("player"))) - (UnitLevel("player") * 5)) * 0.04)
		local avoid = miss+GetBlockChance()+GetParryChance()+GetDodgeChance()
		local avoidance = E:ShortenString(STAT_AVOIDANCE, 5)..": "..ElvUI[1].media.hexvaluecolor..tostring(math.floor(avoid*100)/100).."%".."|r"

		dt.text:SetFormattedText('%s %s|r',avoidance,defense)
	end
	DT:RegisterDatatext('Eltruism Stats 3', STAT_CATEGORY_ENHANCEMENTS, {'COMBAT_RATING_UPDATE',"UNIT_STATS","PLAYER_DAMAGE_DONE_MODS"}, EltruismStatsDatatext3, nil, nil, EltruismStatsDatatextOnEnter, nil, L["Eltruism Stats 3"])
end
