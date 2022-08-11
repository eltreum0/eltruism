local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local NP = E:GetModule('NamePlates')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc

--gradient threat
function NP:ThreatIndicator_PostUpdate(unit, status)
	if E.db.ElvUI_EltreumUI.gradientmode.npenable then
		local nameplate, colors, db = self.__owner, NP.db.colors.threat, NP.db.threat
		local sf = NP:StyleFilterChanges(nameplate)
		if not status and not sf.Scale then
			nameplate.ThreatScale = 1
			NP:ScalePlate(nameplate, 1)
		elseif status and db.enable and db.useThreatColor and not UnitIsTapDenied(unit) then
			NP:Health_SetColors(nameplate, true)
			nameplate.ThreatStatus = status
			local Color, Scale
			if UnitExists('pet') or (E.myrole == 'TANK') then
				if not (E.myclass == "HUNTER" or E.myclass == 'WARLOCK') then
					self.isTank = true
				else
					if not IsInGroup() then
						self.PetTank = true
					end
				end
			else
				self.isTank = false
			end
			if (self.isTank or self.PetTank) and UnitName(nameplate.unit.."target") == E.myname then
				if not (E.myclass == "HUNTER" or E.myclass == 'WARLOCK') then
					self.offTank = false
				else
					if UnitName(nameplate.unit.."target") == E.myname then
						nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("BADTHREAT", false, false))
					elseif UnitName(nameplate.unit.."target") == UnitName("pet") then
						self.isTank = false
						self.offTank = true
					end
				end
			elseif (self.isTank or self.PetTank) and UnitName(nameplate.unit.."target") ~= E.myname then
				if not (E.myclass == "HUNTER" or E.myclass == 'WARLOCK') then
					self.offTank = true
				else
					if UnitName(nameplate.unit.."target") == E.myname then
						nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("BADTHREAT", false, false))
					elseif UnitName(nameplate.unit.."target") == UnitName("pet") then
						self.isTank = false
						self.offTank = true
					end
				end
			end
			if not InCombatLockdown() then
				nameplate.CurrentlyBeingTanked = nil
			end

			--print('working', self.isTank, self.offTank,nameplate.unit)
			if status == 3 then -- securely tanking
				if self.isTank then
					nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("GOODTHREAT", false, false))
					nameplate.CurrentlyBeingTanked = nameplate.unit.."isbeingtanked"
				elseif self.offTank then
					nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("OFFTANK", false, false))
					nameplate.CurrentlyBeingTanked = nameplate.unit.."isbeingtanked"
				end
				Scale = self.isTank and db.goodScale or db.badScale
			elseif status == 2 then -- insecurely tanking
				if self.isTank then
					nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("BADTHREATTRANSITION", false, false))
					nameplate.CurrentlyBeingTanked = nameplate.unit.."isbeingtanked"
				elseif self.offTank then
					nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("OFFTANKBADTHREATTRANSITION", false, false))
					nameplate.CurrentlyBeingTanked = nameplate.unit.."isbeingtanked"
				end
				Scale = 1
			elseif status == 1 then -- not tanking but threat higher than tank
				if self.isTank then
					nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("GOODTHREATTRANSITION", false, false))
					nameplate.CurrentlyBeingTanked = nameplate.unit.."isbeingtanked"
				elseif self.offTank then
					nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("OFFTANKGOODTHREATTRANSITION", false, false))
					nameplate.CurrentlyBeingTanked = nameplate.unit.."isbeingtanked"
				end
				Scale = 1
			else -- not tanking at all
				if self.isTank then
					nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("BADTHREAT", false, false))
					nameplate.CurrentlyBeingTanked = nameplate.unit.."isbeingtanked"
				elseif self.offTank then
					nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("GOODTHREAT", false, false))
					nameplate.CurrentlyBeingTanked = nameplate.unit.."isbeingtanked"
				end
				Scale = self.isTank and db.badScale or db.goodScale
			end
			if Scale then
				nameplate.ThreatScale = Scale

				if not sf.Scale then
					NP:ScalePlate(nameplate, Scale)
				end
			end
			if sf.HealthColor then
				return
			end
		end
	end
end

--gradient nameplates
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

			if not InCombatLockdown() then
				unit.CurrentlyBeingTanked = nil
			end

			if className and player then
				if E.db.ElvUI_EltreumUI.gradientmode.npcustomcolor then
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom(className))
				else
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors(className))
				end
			elseif reaction ~= nil and (unit.CurrentlyBeingTanked ~= unit.unit.."isbeingtanked") then
				if UnitIsTapDenied(unit.unit) and not UnitPlayerControlled(unit.unit) then
					if E.db.ElvUI_EltreumUI.gradientmode.npcustomcolor then
						unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("TAPPED", false, false))
					else
						unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("TAPPED", false, false))
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
hooksecurefunc(NP, "Health_UpdateColor", GradientNameplates)

--hooksecurefunc(NP, "ThreatIndicator_PostUpdate", GradientNameplates)
--hooksecurefunc(NP, "Update_ThreatIndicator", GradientNameplates)
--hooksecurefunc(NP, "Update_StatusBars", GradientNameplates)
--hooksecurefunc(NP, "SetupTarget", GradientNameplates)
--hooksecurefunc(NP, "UpdateTargetPlate", GradientNameplates)
--hooksecurefunc(NP, "UpdatePlateSize", GradientNameplates)
--hooksecurefunc(NP, "Style", GradientNameplates)
--hooksecurefunc(NP, "StyleTargetPlate", GradientNameplates)
--hooksecurefunc(NP, "UpdatePlate", GradientNameplates)
--hooksecurefunc(NP, "StyleFilterUpdate", GradientNameplates)
