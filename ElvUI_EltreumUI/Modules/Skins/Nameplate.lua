local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local NP = E:GetModule('NamePlates')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc

--gradient nameplates
local function GradientNameplates(unit)
	if E.db.ElvUI_EltreumUI.gradientmode.npenable then
		if unit and unit.Health then
			local _, className = UnitClass(unit.unit)
			local name, realm = UnitName(unit.unit)
			local player = UnitIsPlayer(unit.unit)
			local reaction =  UnitReaction(unit.unit, "player")
			if className and player then
				if E.db.ElvUI_EltreumUI.gradientmode.npcustomcolor then
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom(className))
				else
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors(className))
				end
			elseif reaction >= 5 then
				if E.db.ElvUI_EltreumUI.gradientmode.npcustomcolor then
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, false))
				else
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, false))
				end
			elseif reaction == 4 then
				if E.db.ElvUI_EltreumUI.gradientmode.npcustomcolor then
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, false))
				else
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, false))
				end
			elseif reaction == 3 then
				if E.db.ElvUI_EltreumUI.gradientmode.npcustomcolor then
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, false))
				else
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, false))
				end
			elseif reaction <= 2 then
				if E.db.ElvUI_EltreumUI.gradientmode.npcustomcolor then
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, false))
				else
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, false))
				end
			end
		end
	end
end
hooksecurefunc(NP, "Health_UpdateColor", GradientNameplates)
