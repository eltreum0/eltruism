local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local NP = E:GetModule('NamePlates')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc

--gradient threat
function NP:ThreatIndicator_PostUpdate(unit, status)
	local nameplate, colors, db = self.__owner, NP.db.colors.threat, NP.db.threat
	local sf = NP:StyleFilterChanges(nameplate)
	if not status and not sf.Scale then
		nameplate.ThreatScale = 1
		NP:ScalePlate(nameplate, 1)
	elseif status and db.enable and db.useThreatColor and not UnitIsTapDenied(unit) then
		NP:Health_SetColors(nameplate, true)
		nameplate.ThreatStatus = status
		local Color, Scale
		-- if gradient use gradient mode
		if E.db.ElvUI_EltreumUI.gradientmode.npenable then
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
			if (self.isTank or self.PetTank) and UnitName(nameplate.unit.."target") == E.myname and not sf.HealthColor then
				if not (E.myclass == "HUNTER" or E.myclass == 'WARLOCK') then
					self.offTank = false
				else
					nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("BADTHREAT", false, false))
					nameplate.CurrentlyBeingTanked = nameplate.unit.."isbeingtanked"
				end
			elseif (self.isTank or self.PetTank) and UnitName(nameplate.unit.."target") ~= E.myname and not sf.HealthColor then
				if not (E.myclass == "HUNTER" or E.myclass == 'WARLOCK') then
					self.offTank = true
				else
					if UnitName(nameplate.unit.."target") == UnitName("pet") then
						nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("GOODTHREAT", false, false))
						nameplate.CurrentlyBeingTanked = nameplate.unit.."isbeingtanked"
					end
				end
			end
			if not InCombatLockdown() then
				nameplate.CurrentlyBeingTanked = nil
			end
			if status == 3 then -- securely tanking
				if self.isTank and not sf.HealthColor then
					nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("GOODTHREAT", false, false))
					nameplate.CurrentlyBeingTanked = nameplate.unit.."isbeingtanked"
				elseif self.offTank  and not sf.HealthColor then
					nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("OFFTANK", false, false))
					nameplate.CurrentlyBeingTanked = nameplate.unit.."isbeingtanked"
				end
				Scale = self.isTank and db.goodScale or db.badScale
			elseif status == 2 then -- insecurely tanking
				if self.isTank and not sf.HealthColor then
					nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("BADTHREATTRANSITION", false, false))
					nameplate.CurrentlyBeingTanked = nameplate.unit.."isbeingtanked"
				elseif self.offTank  and not sf.HealthColor then
					nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("OFFTANKBADTHREATTRANSITION", false, false))
					nameplate.CurrentlyBeingTanked = nameplate.unit.."isbeingtanked"
				end
				Scale = 1
			elseif status == 1 then -- not tanking but threat higher than tank
				if self.isTank and not sf.HealthColor then
					nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("GOODTHREATTRANSITION", false, false))
					nameplate.CurrentlyBeingTanked = nameplate.unit.."isbeingtanked"
				elseif self.offTank  and not sf.HealthColor then
					nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("OFFTANKGOODTHREATTRANSITION", false, false))
					nameplate.CurrentlyBeingTanked = nameplate.unit.."isbeingtanked"
				end
				Scale = 1
			else -- not tanking at all
				if self.isTank and not sf.HealthColor then
					nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("BADTHREAT", false, false))
					nameplate.CurrentlyBeingTanked = nameplate.unit.."isbeingtanked"
				elseif self.offTank and not sf.HealthColor then
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
		else -- use regular elvui mode
			if status == 3 then -- securely tanking
				Color = self.offTank and colors.offTankColor or self.isTank and colors.goodColor or colors.badColor
				Scale = self.isTank and db.goodScale or db.badScale
			elseif status == 2 then -- insecurely tanking
				Color = self.offTank and colors.offTankColorBadTransition or self.isTank and colors.badTransition or colors.goodTransition
				Scale = 1
			elseif status == 1 then -- not tanking but threat higher than tank
				Color = self.offTank and colors.offTankColorGoodTransition or self.isTank and colors.goodTransition or colors.badTransition
				Scale = 1
			else -- not tanking at all
				Color = self.isTank and colors.badColor or colors.goodColor
				Scale = self.isTank and db.badScale or db.goodScale
			end

			if sf.HealthColor then
				self.r, self.g, self.b = Color.r, Color.g, Color.b
			else
				nameplate.Health:SetStatusBarColor(Color.r, Color.g, Color.b)
			end
			if Scale then
				nameplate.ThreatScale = Scale

				if not sf.Scale then
					NP:ScalePlate(nameplate, Scale)
				end
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

			local sf = NP:StyleFilterChanges(unit)
			if sf.HealthColor then
				return
			else
				if reaction and reaction >= 5 then
					targettype = "NPCFRIENDLY"
				elseif reaction and reaction == 4 then
					targettype = "NPCNEUTRAL"
				elseif reaction and reaction == 3 then
					targettype = "NPCUNFRIENDLY"
				elseif reaction and reaction <= 2 then
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
end
hooksecurefunc(NP, "Health_UpdateColor", GradientNameplates)
