local E, L = unpack(ElvUI)
local _G = _G
local DT = E:GetModule("DataTexts")
local GetCombatRatingBonus = _G.GetCombatRatingBonus
local math = _G.math
local C_CurrencyInfo = _G.C_CurrencyInfo
local Constants = _G.Constants --maybe should not be
local HONOR = _G.HONOR
local ARENA= _G.ARENA
local COMBAT_HONOR_GAIN = _G.COMBAT_HONOR_GAIN
local PVP_CONQUEST = _G.PVP_CONQUEST
local CURRENCY = _G.CURRENCY
local STAT_CATEGORY_ENHANCEMENTS = _G.STAT_CATEGORY_ENHANCEMENTS
local CR_HASTE_SPELL = _G.CR_HASTE_SPELL
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------spell haste datatext
local function EltruismSpellHasteDatatext(dt)
	local spellhaste = GetCombatRatingBonus(CR_HASTE_SPELL)
	local spellhastepc = ((math.ceil(spellhaste*100))/100).."%"
	dt.text:SetFormattedText('%s: %s%s|r', L["Spell Haste"], ElvUI[1].media.hexvaluecolor, spellhastepc)
end
if E.Wrath or E.Classic then
	DT:RegisterDatatext('Eltruism Spellhaste', STAT_CATEGORY_ENHANCEMENTS, {'COMBAT_RATING_UPDATE',"UNIT_SPELL_HASTE"}, EltruismSpellHasteDatatext, nil, nil, nil, nil, L["Eltruism Spell Haste"])
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------honor datatext
local function EltruismHonorDatatext(dt)
	local honorCurrencyInfo = C_CurrencyInfo.GetCurrencyInfo(Constants.CurrencyConsts.CLASSIC_HONOR_CURRENCY_ID)
	local arenaCurrencyInfo
	if E.Wrath then
		arenaCurrencyInfo = C_CurrencyInfo.GetCurrencyInfo(Constants.CurrencyConsts.CLASSIC_ARENA_POINTS_CURRENCY_ID)
		dt.text:SetFormattedText('%s: %s%s|r %s: %s%s|r ', HONOR, ElvUI[1].media.hexvaluecolor, honorCurrencyInfo.quantity,ARENA, ElvUI[1].media.hexvaluecolor,arenaCurrencyInfo.quantity)
	elseif E.Classic then
		--local kills, honor = GetPVPThisWeekStats()
		local _, honor = GetPVPThisWeekStats()
		--local lastweekkills, _, lastweekhonor = GetPVPLastWeekStats()
		dt.text:SetFormattedText('%s: %s%s|r', HONOR, ElvUI[1].media.hexvaluecolor, honor)
	elseif E.Retail then
		local retailconquest = C_CurrencyInfo.GetCurrencyInfo(1602)
		local retailhonor = C_CurrencyInfo.GetCurrencyInfo(1792)
		dt.text:SetFormattedText('%s: %s%s|r %s: %s%s|r ', COMBAT_HONOR_GAIN, ElvUI[1].media.hexvaluecolor, retailhonor.quantity,PVP_CONQUEST, ElvUI[1].media.hexvaluecolor,retailconquest.quantity)
	end
end
if E.Wrath or E.Classic then
	DT:RegisterDatatext('Eltruism Honor/Arena Points', CURRENCY, {'CHAT_MSG_CURRENCY', 'CURRENCY_DISPLAY_UPDATE'}, EltruismHonorDatatext, nil, nil, nil, nil, L["Eltruism Honor/Arena Points"])
elseif E.Retail then
	DT:RegisterDatatext('Eltruism Honor/Conquest Points', CURRENCY, {'CHAT_MSG_CURRENCY', 'CURRENCY_DISPLAY_UPDATE'}, EltruismHonorDatatext, nil, nil, nil, nil, L["Eltruism Honor/Conquest Points"])
end
