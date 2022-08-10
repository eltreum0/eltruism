local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local NP = E:GetModule('NamePlates')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc

--gradient nameplates
local function GradientNameplates(unit, status)
	if E.db.ElvUI_EltreumUI.gradientmode.npenable then
		if unit and unit.Health then
			local _, className = UnitClass(unit.unit)
			local name, realm = UnitName(unit.unit)
			local player = UnitIsPlayer(unit.unit)
			local reaction =  UnitReaction(unit.unit, "player")
			local targettype
			if reaction ~= nil and reaction >= 5 then
				targettype = "NPCFRIENDLY"
			elseif reaction ~= nil and reaction == 4 then
				targettype = "NPCNEUTRAL"
			elseif reaction ~= nil and reaction == 3 then
				targettype = "NPCUNFRIENDLY"
			elseif reaction ~= nil and reaction <= 2 then
				targettype = "NPCHOSTILE"
			end
			if className and player then
				if E.db.ElvUI_EltreumUI.gradientmode.npcustomcolor then
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom(className))
				else
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors(className))
				end
			elseif reaction ~= nil then
				if UnitIsTapDenied(unit.unit) and not UnitPlayerControlled(unit.unit) then
					if E.db.ElvUI_EltreumUI.gradientmode.npcustomcolor then
						unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("TAPPED", false, false))
					else
						unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("TAPPED", false, false))
					end
				else
					local isTank = false
					if UnitExists('pet') or (E.myrole == 'TANK') then
						isTank = true
					end
					local unitTarget = UnitName(unit.unit.."target")
					if status ~= nil and type(status) == "number" and isTank then
						if isTank and unitTarget == E.myname then
							print("tank")
							if status == 0 then
								unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("BADTHREAT", false, false))
							elseif status == 1 then
								unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("GOODTHREATTRANSITION", false, false))
							elseif status == 2 then
								unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("BADTHREATTRANSITION", false, false))
							elseif status == 3 then
								unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("GOODTHREAT", false, false))
							end
						elseif isTank and unitTarget ~= E.myname then
							print("offtank")
							if status == 0 then
								unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("BADTHREAT", false, false))
							elseif status == 1 then
								unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("OFFTANKGOODTHREATTRANSITION", false, false))
							elseif status == 2 then
								unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("OFFTANKBADTHREATTRANSITION", false, false))
							elseif status == 3 then
								unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("OFFTANK", false, false))
							end
						end
					else

						if E.db.ElvUI_EltreumUI.gradientmode.npcustomcolor then
							unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom(targettype, false, false))
						else
							unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors(targettype, false, false))
						end
					end
				end
			end
		end
	end
end
hooksecurefunc(NP, "Health_UpdateColor", GradientNameplates)

local function Threat(unit, _, status) --(unit,nameplate,status)
	if status ~= nil and type(status) == "number" then
		GradientNameplates(unit, status)
	end
end
hooksecurefunc(NP, "ThreatIndicator_PostUpdate", Threat)
