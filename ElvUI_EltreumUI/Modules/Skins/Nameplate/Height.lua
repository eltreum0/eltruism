local E, _, _, P = unpack(ElvUI)
local NP = E:GetModule('NamePlates')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local UnitAffectingCombat = _G.UnitAffectingCombat
local UnitIsUnit = _G.UnitIsUnit
local CreateFrame = _G.CreateFrame
local UnitThreatSituation = _G.UnitThreatSituation
local UnitCastingInfo = _G.UnitCastingInfo

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
	if not unit then return end
	if not unit.unit then return end
	if not unit.Health then return end
	if not unit.Health:IsShown() then return end
	if not E.private.nameplates.enable then return end
	if E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.enableHealthHeight then --and unit.unit:match("nameplate") then --unit is always nameplate

		--check if its not explosive
		--[[if (unit.unitGUID and unit.unitGUID:match("-120651-")) or UnitIsUnit(unit.unit,"player") then
			return
		end]]

		if UnitIsUnit(unit.unit, "target") then
			if E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.useelvuinpheight then
				unit.Health:SetHeight(heighttable[unit.frameType])
			else
				unit.Health:SetHeight(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.incombatHeight)
			end
		else
			if UnitAffectingCombat(unit.unit) or UnitThreatSituation("player", unit.unit) ~= nil or UnitIsUnit(unit.unit.."target","player") or UnitCastingInfo(unit.unit) then
				if E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.useelvuinpheight then
					unit.Health:SetHeight(heighttable[unit.frameType])
				else
					unit.Health:SetHeight(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.incombatHeight)
				end
			else
				unit.Health:SetHeight(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.outofcombatHeight)
			end
		end
	end
end
hooksecurefunc(NP, "StyleFilterUpdate", ElvUI_EltreumUI.NameplateCustomOptions)
--UNIT_FLAGS might work, as might "UNIT_THREAT_LIST_UPDATE", but linking to the function is the issue
