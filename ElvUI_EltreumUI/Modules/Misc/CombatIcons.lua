local E = unpack(ElvUI)
local _G = _G
local UnitExists = _G.UnitExists
local UnitIsPlayer = _G.UnitIsPlayer
local UnitClass = _G.UnitClass

local playericons = {
	["MAGE"] = "Eltruism21",
	["MONK"] = "Eltruism23",
	["WARLOCK"] = "Eltruism25",
	["HUNTER"] = "Eltruism27",
	["PALADIN"]	= "Eltruism30",
	["ROGUE"] = "Eltruism32",
	["PRIEST"] = "Eltruism34",
	["DEATHKNIGHT"]	= "Eltruism36",
	["DEMONHUNTER"]	= "Eltruism38",
	["DRUID"] = "Eltruism40",
	["SHAMAN"] = "Eltruism42",
	["WARRIOR"] = "Eltruism44",
	["EVOKER"] = "Eltruism46",
}
local targeticons = {
	["DEATHKNIGHT"]	= "Eltruism37",
	["DEMONHUNTER"]	= "Eltruism39",
	["DRUID"] = "Eltruism41",
	["HUNTER"] = "Eltruism28",
	["MAGE"] = "Eltruism22",
	["MONK"] = "Eltruism24",
	["PALADIN"]	= "Eltruism31",
	["ROGUE"] = "Eltruism33",
	["PRIEST"] = "Eltruism35",
	["SHAMAN"] = "Eltruism43",
	["WARLOCK"] = "Eltruism26",
	["WARRIOR"] = "Eltruism45",
	["EVOKER"] = "Eltruism47",
}

--change target combat icon based on its class
function ElvUI_EltreumUI:TargetCombatIconClass()
	if E.db.ElvUI_EltreumUI.unitframes.classcombaticons then
		if E.db.unitframe.units.target.CombatIcon.enable then
			if _G["ElvUF_Target"] and _G["ElvUF_Target"].CombatIndicator then
				if UnitExists("target") then
					if UnitIsPlayer("target") then
						local _,targetclass = UnitClass("target")
						local texturetarget = targeticons[targetclass]
						_G["ElvUF_Target"].CombatIndicator:SetTexture(E.Media.CombatIcons[texturetarget])
					else
						_G["ElvUF_Target"].CombatIndicator:SetTexture(E.Media.CombatIcons[E.db.unitframe.units.target.CombatIcon.texture])
					end
				end
			end
		end
		if E.db.unitframe.units.player.CombatIcon.enable then
			if _G["ElvUF_Player"] and _G["ElvUF_Player"].CombatIndicator then
				local textureplayer = playericons[E.myclass]
				_G["ElvUF_Player"].CombatIndicator:SetTexture(E.Media.CombatIcons[textureplayer])
			end
		end
	end
end
