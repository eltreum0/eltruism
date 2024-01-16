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
	if not UnitExists("target") then return end
	if E.db.ElvUI_EltreumUI.unitframes.classcombaticons then
		if E.db.unitframe.units.target.CombatIcon.enable then
			if _G["ElvUF_Target"] and _G["ElvUF_Target"].CombatIndicator then
				if UnitExists("target") then
					if UnitIsPlayer("target") or (E.Retail and UnitInPartyIsAI("target")) then
						local _,targetclass = UnitClass("target")
						local texturetarget = targeticons[targetclass]
						_G["ElvUF_Target"].CombatIndicator:SetTexture(E.Media.CombatIcons[texturetarget])
						_G["ElvUF_Target"].CombatIndicator:SetVertexColor(1, 1, 1, 1)
					else
						local classification = UnitClassification("target")
						if not classification then return end
						local guid = UnitGUID("target")
						if not guid then return end
						local bossID = select(6, strsplit('-', guid))
						if not bossID then return end
						local isBoss = ElvUI_EltreumUI:GetBossIconTextureAndID(false,true,bossID)
						if isBoss then
							classification = 'worldboss'
						end
						if(classification == 'rare') then
							if E.db.ElvUI_EltreumUI.nameplates.classification.icontyperareelite == "CUSTOM" then
								_G["ElvUF_Target"].CombatIndicator:SetTexture([[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.nameplates.classification.customrare)
							else
								_G["ElvUF_Target"].CombatIndicator:SetTexture(ElvUI_EltreumUI:GetBossIconTextureAndID(E.db.ElvUI_EltreumUI.nameplates.classification.icontyperare,false,nil,true))
							end
							_G["ElvUF_Target"].CombatIndicator:SetVertexColor(E.db.ElvUI_EltreumUI.nameplates.classification.rareR, E.db.ElvUI_EltreumUI.nameplates.classification.rareG, E.db.ElvUI_EltreumUI.nameplates.classification.rareB, 1)
						elseif(classification == 'rareelite') then
							if E.db.ElvUI_EltreumUI.nameplates.classification.icontyperareelite == "CUSTOM" then
								_G["ElvUF_Target"].CombatIndicator:SetTexture([[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.nameplates.classification.customrareelite)
							else
								_G["ElvUF_Target"].CombatIndicator:SetTexture(ElvUI_EltreumUI:GetBossIconTextureAndID(E.db.ElvUI_EltreumUI.nameplates.classification.icontyperareelite,false,nil,true))
							end
							_G["ElvUF_Target"].CombatIndicator:SetVertexColor(E.db.ElvUI_EltreumUI.nameplates.classification.rareeliteR, E.db.ElvUI_EltreumUI.nameplates.classification.rareeliteG, E.db.ElvUI_EltreumUI.nameplates.classification.rareeliteB, 1)
						elseif(classification == 'elite') then
							if E.db.ElvUI_EltreumUI.nameplates.classification.icontyperareelite == "CUSTOM" then
								_G["ElvUF_Target"].CombatIndicator:SetTexture([[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.nameplates.classification.customelite)
							else
								_G["ElvUF_Target"].CombatIndicator:SetTexture(ElvUI_EltreumUI:GetBossIconTextureAndID(E.db.ElvUI_EltreumUI.nameplates.classification.icontypeelite,false,nil,true))
							end
							_G["ElvUF_Target"].CombatIndicator:SetVertexColor(E.db.ElvUI_EltreumUI.nameplates.classification.eliteR, E.db.ElvUI_EltreumUI.nameplates.classification.eliteG, E.db.ElvUI_EltreumUI.nameplates.classification.eliteB, 1)
						elseif(classification == 'worldboss') then
							if E.db.ElvUI_EltreumUI.nameplates.classification.icontyperareelite == "CUSTOM" then
								_G["ElvUF_Target"].CombatIndicator:SetTexture([[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.nameplates.classification.customboss)
							else
								_G["ElvUF_Target"].CombatIndicator:SetTexture(ElvUI_EltreumUI:GetBossIconTextureAndID(E.db.ElvUI_EltreumUI.nameplates.classification.icontypeboss,false,nil,true))
							end
							_G["ElvUF_Target"].CombatIndicator:SetVertexColor(E.db.ElvUI_EltreumUI.nameplates.classification.bossR, E.db.ElvUI_EltreumUI.nameplates.classification.bossG, E.db.ElvUI_EltreumUI.nameplates.classification.bossB, 1)
						else
							_G["ElvUF_Target"].CombatIndicator:SetTexture(E.Media.CombatIcons[E.db.unitframe.units.target.CombatIcon.texture])
							_G["ElvUF_Target"].CombatIndicator:SetVertexColor(1, 1, 1, 1)
						end
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
