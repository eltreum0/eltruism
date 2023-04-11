local E, L, V, P, G = unpack(ElvUI)
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

local LCG = E.Libs.CustomGlow
local classcolor = E:ClassColor(E.myclass, true)
local glowcolor


function ElvUI_EltreumUI:NameplateCustomOptions(unit)
	if (E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.enableHealthHeight) and unit and unit.unit and unit.unit:match("nameplate") then

		--test np glow
		if E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.npglow then
			if (unit.unitGUID and unit.unitGUID:match("-120651-")) then
				if E.db.ElvUI_EltreumUI.glow.colorclassnp then
					glowcolor = {classcolor.r, classcolor.g, classcolor.b, 1}
				else
					glowcolor = {E.db.ElvUI_EltreumUI.glow.glowcustomcolornp.r, E.db.ElvUI_EltreumUI.glow.glowcustomcolornp.g, E.db.ElvUI_EltreumUI.glow.glowcustomcolornp.b, 1}
				end
				if E.db.ElvUI_EltreumUI.glow.pixel then
					LCG.PixelGlow_Start(unit.Health, glowcolor, E.db.ElvUI_EltreumUI.glow.numberpixel, E.db.ElvUI_EltreumUI.glow.frequencypixel, E.db.ElvUI_EltreumUI.glow.lengthpixel, E.db.ElvUI_EltreumUI.glow.thicknesspixel, E.db.ElvUI_EltreumUI.glow.pixelxOffset, E.db.ElvUI_EltreumUI.glow.pixelyOffset, E.db.ElvUI_EltreumUI.glow.borderpixel, nil, 6)
				elseif E.db.ElvUI_EltreumUI.glow.autocast then
					LCG.AutoCastGlow_Start(unit.Health, glowcolor, E.db.ElvUI_EltreumUI.glow.numberauto, E.db.ElvUI_EltreumUI.glow.frequencyauto, E.db.ElvUI_EltreumUI.glow.autoscale, E.db.ElvUI_EltreumUI.glow.autoxOffset, E.db.ElvUI_EltreumUI.glow.autoyOffset)
				elseif E.db.ElvUI_EltreumUI.glow.blizzard then
					LCG.ButtonGlow_Start(unit.Health, glowcolor, E.db.ElvUI_EltreumUI.glow.frequencyblizz)
				end
			else
				if E.db.ElvUI_EltreumUI.glow.pixel then
					LCG.PixelGlow_Stop(unit.Health)
				elseif E.db.ElvUI_EltreumUI.glow.autocast then
					LCG.AutoCastGlow_Stop(unit.Health)
				elseif E.db.ElvUI_EltreumUI.glow.blizzard then
					LCG.ButtonGlow_Stop(unit.Health)
				end
			end
		end

		--check if its not explosive
		if (unit.unitGUID and unit.unitGUID:match("-120651-")) or UnitIsUnit(unit.unit,"player") then
			return
		end

		if UnitIsUnit(unit.unit, "target") then
			if E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.useelvuinpheight then
				unit.Health:SetHeight(heighttable[unit.frameType])
			else
				unit.Health:SetHeight(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.incombatHeight)
			end
		else
			if UnitAffectingCombat(unit.unit) or UnitThreatSituation("player", unit.unit) ~= nil or UnitIsUnit(unit.unit.."target","player") then
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
