local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local NP = E:GetModule('NamePlates')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local UnitAffectingCombat = _G.UnitAffectingCombat
local UnitIsUnit = _G.UnitIsUnit
local CreateFrame = _G.CreateFrame
local UnitThreatSituation = _G.UnitThreatSituation

--np custom health height conditions
local heighttable = {
	["FRIENDLY_NPC"] = 30,
	["ENEMY_NPC"] = 30,
	["ENEMY_PLAYER"] = 30,
	["FRIENDLY_PLAYER"] = 30,
	["PLAYER"] = 30,
}
local tableupdate = CreateFrame("FRAME")
tableupdate:RegisterEvent("PLAYER_ENTERING_WORLD")
tableupdate:RegisterEvent("PLAYER_STARTED_MOVING")
tableupdate:SetScript("OnEvent",function()
	tableupdate:UnregisterAllEvents()
	heighttable = {
		["FRIENDLY_NPC"] = E.db.nameplates.units.FRIENDLY_NPC.health.height or P.nameplates.units.FRIENDLY_NPC.health.height,
		["ENEMY_NPC"] = E.db.nameplates.units.ENEMY_NPC.health.height or P.nameplates.units.ENEMY_NPC.health.height,
		["ENEMY_PLAYER"] = E.db.nameplates.units.ENEMY_PLAYER.health.height or P.nameplates.units.ENEMY_PLAYER.health.height,
		["FRIENDLY_PLAYER"] = E.db.nameplates.units.FRIENDLY_PLAYER.health.height or P.nameplates.units.FRIENDLY_NPC.health.height,
		["PLAYER"] = E.db.nameplates.units.PLAYER.health.height or P.nameplates.units.PLAYER.health.height,
	}
end)
function ElvUI_EltreumUI:NameplateCustomOptions(unit)
	if (E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.enableHealthHeight) and unit and unit.unit and unit.unit:match("nameplate") then

		--check if its not explosive
		if (unit.unitGUID and unit.unitGUID:match("-120651-")) or UnitIsUnit(unit.unit,"player") then
			return
		end

		if (not UnitAffectingCombat(unit.unit)) and (UnitThreatSituation("player", unit.unit) == nil) then
			if UnitIsUnit(unit.unit, "target") then
				if E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.useelvuinpheight then
					unit.Health:SetHeight(heighttable[unit.frameType])
				else
					unit.Health:SetHeight(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.incombatHeight)
				end
			else
				unit.Health:SetHeight(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.outofcombatHeight)
			end
		elseif UnitAffectingCombat(unit.unit) or (UnitThreatSituation("player", unit.unit) ~= nil) then
			if E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.useelvuinpheight then
				unit.Health:SetHeight(heighttable[unit.frameType])
			else
				unit.Health:SetHeight(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.incombatHeight)
			end
		end
	end
end
hooksecurefunc(NP, "StyleFilterUpdate", ElvUI_EltreumUI.NameplateCustomOptions)
--UNIT_FLAGS might work, as might "UNIT_THREAT_LIST_UPDATE", but linking to the function is the issue
