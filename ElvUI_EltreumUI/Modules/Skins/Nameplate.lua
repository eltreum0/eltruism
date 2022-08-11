local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local NP = E:GetModule('NamePlates')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc

--gradient nameplates
local threatstatus
local function GradientNameplates(unit)
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


					if isTank == true and InCombatLockdown() then
						local unitTarget = UnitName(unit.unit.."target")
						threatstatus = UnitThreatSituation('player', unit.unit)
						if threatstatus ~= nil and threatstatus >= 0 then

							if isTank and (unitTarget == E.myname) then
								print("maintank", threatstatus)
								if threatstatus == 0 then
									unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("BADTHREAT", false, false))
								elseif threatstatus == 1 then
									unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("GOODTHREATTRANSITION", false, false))
								elseif threatstatus == 2 then
									unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("BADTHREATTRANSITION", false, false))
								elseif threatstatus == 3 then
									unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("GOODTHREAT", false, false))
								end
							elseif isTank and unitTarget ~= E.myname then
								print("offtank", threatstatus)
								if threatstatus == 0 then
									unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("BADTHREAT", false, false))
								elseif threatstatus == 1 then
									unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("OFFTANKGOODTHREATTRANSITION", false, false))
								elseif threatstatus == 2 then
									unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("OFFTANKBADTHREATTRANSITION", false, false))
								elseif threatstatus == 3 then
									unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("OFFTANK", false, false))
								end
							end
						elseif threatstatus == nil then
							if (unitTarget == E.myname) then
								print("unknown threat scenario, just guessing bad")
								unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("BADTHREAT", false, false))
							elseif unitTarget ~= E.myname then
								print("unknown threat scenario, just guessing good")
								unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("GOODTHREAT", false, false))
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
--hooksecurefunc(NP, "Update_StatusBars", GradientNameplates)
--hooksecurefunc(NP, "SetupTarget", GradientNameplates)
--hooksecurefunc(NP, "UpdateTargetPlate", GradientNameplates)
--hooksecurefunc(NP, "Update_ThreatIndicator", GradientNameplates)
--hooksecurefunc(NP, "ThreatIndicator_PostUpdate", GradientNameplates)
--hooksecurefunc(NP, "UpdatePlateSize", GradientNameplates)
--hooksecurefunc(NP, "Style", GradientNameplates)
--hooksecurefunc(NP, "StyleTargetPlate", GradientNameplates)
--hooksecurefunc(NP, "UpdatePlate", GradientNameplates)
--hooksecurefunc(NP, "StyleFilterUpdate", GradientNameplates)

