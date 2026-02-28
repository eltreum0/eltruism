local E, _, _, P = unpack(ElvUI)
local NP = E:GetModule('NamePlates')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local UnitAffectingCombat = _G.UnitAffectingCombat
local UnitIsUnit = _G.UnitIsUnit
local CreateFrame = _G.CreateFrame
local UnitThreatSituation = _G.UnitThreatSituation
local UnitCastingInfo = _G.UnitCastingInfo or _G.CastingInfo

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
	if not unit or not unit.unit or not unit.Health or not unit.Health:IsShown() then
		return
	end
	if not E.db.ElvUI_EltreumUI then return end
	if not E.db.ElvUI_EltreumUI.nameplates then return end

	if E.db.ElvUI_EltreumUI.nameplates.backdrop and E.db.ElvUI_EltreumUI.nameplates.backdrop.BDmodifications then
		if unit.Health.backdrop then
			unit.Health.backdrop.Center:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.nameplates.backdrop.backdroptexture))
			if E.db.ElvUI_EltreumUI.nameplates.backdrop.backdroptexturestaticsize then
				unit.Health.backdrop.Center:SetAllPoints(unit.Health)
			end
			if E.db.ElvUI_EltreumUI.nameplates.backdrop.backdrophidden then
				unit.Health.backdrop.LeftEdge:Hide()
				unit.Health.backdrop.BottomLeftCorner:Hide()
				unit.Health.backdrop.TopLeftCorner:Hide()
				unit.Health.backdrop.RightEdge:Hide()
				unit.Health.backdrop.BottomRightCorner:Hide()
				unit.Health.backdrop.TopRightCorner:Hide()
				unit.Health.backdrop.TopEdge:Hide()
				unit.Health.backdrop.BottomEdge:Hide()
			end
		end
	end

	--works for name, but then there's the tags issue
	--[[if not UnitCanAttack("player", unit.unit) and UnitIsEnemy("player", unit.unit) then
		unit.Health:Hide()
	else
		unit.Health:Show()
	end]]

	--[[if not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions then return end
	if E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.enableHealthHeight then --and unit.unit:match("nameplate") then --unit is always nameplate
		if E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.disableCombatConditions then
			if UnitIsUnit(unit.unit, "target") then
				if E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.useelvuinpheight and unit.frameType then
					unit.Health:SetHeight(heighttable[unit.frameType])
				else
					unit.Health:SetHeight(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.incombatHeight)
				end
			else
				unit.Health:SetHeight(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.outofcombatHeight)
			end
		else
			if UnitIsUnit(unit.unit, "target") then
				if E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.useelvuinpheight and unit.frameType then
					unit.Health:SetHeight(heighttable[unit.frameType])
				else
					unit.Health:SetHeight(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.incombatHeight)
				end
			else
				if UnitAffectingCombat(unit.unit) or (UnitThreatSituation("player", unit.unit) ~= nil) or UnitIsUnit(unit.unit.."target","player") or UnitCastingInfo(unit.unit) then
					if E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.useelvuinpheight and unit.frameType then
						unit.Health:SetHeight(heighttable[unit.frameType])
					else
						unit.Health:SetHeight(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.incombatHeight or 14)
					end
				else
					unit.Health:SetHeight(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.outofcombatHeight or 4)
				end
			end
		end
	end]]
end
--hooksecurefunc(NP, "StyleFilterUpdate", ElvUI_EltreumUI.NameplateCustomOptions)
hooksecurefunc(NP, "NamePlateCallBack", ElvUI_EltreumUI.NameplateCustomOptions) --when they appear after the stylefilter changes in elvui
hooksecurefunc(NP, "Update_TargetIndicator", ElvUI_EltreumUI.NameplateCustomOptions)
hooksecurefunc(NP, "Construct_Highlight", ElvUI_EltreumUI.NameplateCustomOptions)
hooksecurefunc(NP, "ScalePlate", ElvUI_EltreumUI.NameplateCustomOptions)
hooksecurefunc(NP, "UpdatePlate", ElvUI_EltreumUI.NameplateCustomOptions)
--hooksecurefunc(NP, "StylePlate", ElvUI_EltreumUI.NameplateCustomOptions)
--hooksecurefunc(NP, "Health_SetColors", ElvUI_EltreumUI.NameplateCustomOptions)
--UNIT_FLAGS might work, as might "UNIT_THREAT_LIST_UPDATE", but linking to the function is the issue
