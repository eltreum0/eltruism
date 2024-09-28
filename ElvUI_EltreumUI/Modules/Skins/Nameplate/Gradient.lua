local E = unpack(ElvUI)
local NP = E:GetModule('NamePlates')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local _, nameplate, db, className, player, reaction, targettype, sf
local UnitIsTapDenied = _G.UnitIsTapDenied
local InCombatLockdown = _G.InCombatLockdown
local UnitClass = _G.UnitClass
local UnitIsPlayer = _G.UnitIsPlayer
local UnitReaction = _G.UnitReaction
local UnitPlayerControlled = _G.UnitPlayerControlled
local UnitCanAttack = _G.UnitCanAttack
local UnitGUID = _G.UnitGUID
local UnitIsDead = _G.UnitIsDead

--gradient threat
function ElvUI_EltreumUI:ThreatIndicator_PostUpdate(unit, status)
	if ElvUI_EltreumUI:EncounterCheck() then return end
	nameplate, db = self.__owner, NP.db.threat
	sf = NP:StyleFilterChanges(nameplate)
	if status and db.enable and db.useThreatColor and not UnitIsTapDenied(unit) and not sf.HealthColor then
		if not nameplate.Health then return end
		--NP:Health_SetColors(nameplate, true)

		-- if gradient use gradient mode
		if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable then
			if not InCombatLockdown() or UnitIsDead("player") then
				nameplate.CurrentlyBeingTanked = nil
			end
			if status == 3 then -- securely tanking
				if self.offTank then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
						nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("OFFTANK", false, false))
					else
						nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("OFFTANK", false, false))
					end
				elseif self.isTank then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
						nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("GOODTHREAT", false, false))
					else
						nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("GOODTHREAT", false, false))
					end
				else
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
						nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("BADTHREAT", false, false))
					else
						nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("BADTHREAT", false, false))
					end
				end
				nameplate.CurrentlyBeingTanked = UnitGUID(nameplate.unit)
			elseif status == 2 then -- insecurely tanking
				if self.offTank then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
						nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("OFFTANKBADTHREATTRANSITION", false, false))
					else
						nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("OFFTANKBADTHREATTRANSITION", false, false))
					end
				elseif self.isTank then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
						nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("BADTHREATTRANSITION", false, false))
					else
						nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("BADTHREATTRANSITION", false, false))
					end
				else
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
						nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("GOODTHREATTRANSITION", false, false))
					else
						nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("GOODTHREATTRANSITION", false, false))
					end
				end
				nameplate.CurrentlyBeingTanked = UnitGUID(nameplate.unit)
			elseif status == 1 then -- not tanking but threat higher than tank
				if self.offTank then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
						nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("OFFTANKGOODTHREATTRANSITION", false, false))
					else
						nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("OFFTANKGOODTHREATTRANSITION", false, false))
					end
				elseif self.isTank then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
						nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("GOODTHREATTRANSITION", false, false))
					else
						nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("GOODTHREATTRANSITION", false, false))
					end
				else
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
						nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("BADTHREATTRANSITION", false, false))
					else
						nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("BADTHREATTRANSITION", false, false))
					end
				end
				nameplate.CurrentlyBeingTanked = UnitGUID(nameplate.unit)
			else -- not tanking at all
				if self.isTank then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
						nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("BADTHREAT", false, false))
					else
						nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("BADTHREAT", false, false))
					end
				else
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
						nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("GOODTHREAT", false, false))
					else
						nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("GOODTHREAT", false, false))
					end
				end
				nameplate.CurrentlyBeingTanked = UnitGUID(nameplate.unit)
			end
		end
	end
end
hooksecurefunc(NP, "ThreatIndicator_PostUpdate", ElvUI_EltreumUI.ThreatIndicator_PostUpdate)

--gradient nameplates
local function GradientNameplates(unit)
	if ElvUI_EltreumUI:EncounterCheck() then return end
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable then
		if unit and unit.Health then
			sf = NP:StyleFilterChanges(unit)
			if sf.HealthColor then
				unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, {r=sf.HealthColor.r,g= sf.HealthColor.g,b= sf.HealthColor.b,a= 1}, {r=sf.HealthColor.r + E.db.ElvUI_EltreumUI.unitframes.gradientmode.stylefilterr,g= sf.HealthColor.g + E.db.ElvUI_EltreumUI.unitframes.gradientmode.stylefilterg,b= sf.HealthColor.b + E.db.ElvUI_EltreumUI.unitframes.gradientmode.stylefilterb,a= 1})
			else
				_, className = UnitClass(unit.unit)
				player = UnitIsPlayer(unit.unit) or (E.Retail and UnitInPartyIsAI(unit.unit))
				reaction = UnitReaction(unit.unit, "player")

				if reaction and reaction >= 5 then
					targettype = "NPCFRIENDLY"
				elseif reaction and reaction == 4 then
					targettype = "NPCNEUTRAL"
				elseif reaction and reaction == 3 then
					targettype = "NPCUNFRIENDLY"
				elseif reaction and reaction <= 2 then
					targettype = "NPCHOSTILE"
				end

				if not InCombatLockdown() or UnitIsDead("player") then
					unit.CurrentlyBeingTanked = nil
				end

				if className and player then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
						unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom(className))
					else
						unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors(className))
					end
				elseif reaction and (unit.CurrentlyBeingTanked ~= UnitGUID(unit.unit)) then
					if UnitIsTapDenied(unit.unit) and not UnitPlayerControlled(unit.unit) then
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
							unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("TAPPED", false, false))
						else
							unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("TAPPED", false, false))
						end
					else
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
							unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom(targettype, false, false))
						else
							unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors(targettype, false, false))
						end
					end
				end
			end
		end
	end
end
hooksecurefunc(NP, "Health_UpdateColor", GradientNameplates)

--power gradient/combo/runes
function ElvUI_EltreumUI:NPClassPower_SetBarColor(bar, r, g, b)
	if ElvUI_EltreumUI:EncounterCheck() then return end
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepower and E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
		bar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, {r=r - 0.3,g= g - 0.3,b= b - 0.3,a= 1}, {r=r,g= g,b= b,a= 1})
		bar.bg:SetAlpha(0)
	end
end
hooksecurefunc(NP, "ClassPower_SetBarColor", ElvUI_EltreumUI.NPClassPower_SetBarColor)

--to fix stylefilter for gradient nameplates
function ElvUI_EltreumUI:StyleFilterClearChanges(frame, HealthColor)
	if ElvUI_EltreumUI:EncounterCheck() then return end
	-- bar stuff
	if HealthColor then
		local h = frame.Health
		if h.r and h.g and h.b then
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable then
				GradientNameplates(frame)
			end
		end
	end
end
hooksecurefunc(NP, "StyleFilterClearChanges", ElvUI_EltreumUI.StyleFilterClearChanges)

--to set slight gradient to style filter
function ElvUI_EltreumUI:StyleFilterSetChanges(frame, actions, HealthColor)
	if ElvUI_EltreumUI:EncounterCheck() then return end
	if HealthColor then
		local hc = (actions.color.healthClass and frame.classColor) or actions.color.healthColor
		if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable then
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
				frame.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, {r=hc.r,g= hc.g,b= hc.b,a= hc.a or 1}, {r=hc.r + E.db.ElvUI_EltreumUI.unitframes.gradientmode.stylefilterr,g= hc.g + E.db.ElvUI_EltreumUI.unitframes.gradientmode.stylefilterg,b= hc.b + E.db.ElvUI_EltreumUI.unitframes.gradientmode.stylefilterb,a= hc.a or 1})
			else
				frame.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, {r=hc.r,g= hc.g,b= hc.b,a= hc.a or 1}, {r=hc.r-0.4,g= hc.g-0.4,b= hc.b-0.4,a= hc.a or 1})
			end
		end
	end
end
hooksecurefunc(NP, "StyleFilterSetChanges", ElvUI_EltreumUI.StyleFilterSetChanges)

--elvui castbar texture/gradient
function ElvUI_EltreumUI:Castbar_CheckInterrupt(unit)
	if ElvUI_EltreumUI:EncounterCheck() then return end
	if unit == 'vehicle' then
		unit = 'player'
	end
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable then
		local _, unitclass = UnitClass(unit)
		local reactiontarget = UnitReaction(unit, "player")
		if self.notInterruptible and UnitCanAttack('player', unit) then
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
				self:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2noninterruptiblecustom,g= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2noninterruptiblecustom,b= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2noninterruptiblecustom,a= 1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1noninterruptiblecustom,g= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1noninterruptiblecustom,b= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1noninterruptiblecustom,a= 1})
			else
				self:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2noninterruptible,g= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2noninterruptible,b= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2noninterruptible,a= 1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1noninterruptible,g= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1noninterruptible,b= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1noninterruptible,a= 1})
			end
		elseif (not self.notInterruptible) and (not ElvUI_EltreumUI:CheckmMediaTagInterrupt()) then
			if UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit)) then
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
					self:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom,g= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom,b= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom,a= 1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom,g= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom,b= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom,a= 1})
				elseif E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
						self:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom(unitclass))
					else
						self:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptablecustom,g= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptablecustom,b= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptablecustom,a= 1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptablecustom,g= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptablecustom,b= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptablecustom,a= 1})
					end
				else
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
						self:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors(unitclass))
					else
						self:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptable,g= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptable,b= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptable, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptable,g= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptable,b= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptable,a= 1})
					end
				end
			else
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
					self:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptablecustom,g= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptablecustom,b= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptablecustom,a= 1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptablecustom,g= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptablecustom,b= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptablecustom,a= 1})
				else
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarreactioninterruptable then
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
							if reactiontarget >= 5 then
								self:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))
							elseif reactiontarget == 4 then
								self:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL"))
							elseif reactiontarget == 3 then
								self:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY"))
							elseif reactiontarget <= 2 then
								self:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))
							end
						else
							if reactiontarget >= 5 then
								self:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))
							elseif reactiontarget == 4 then
								self:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))
							elseif reactiontarget == 3 then
								self:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY"))
							elseif reactiontarget <= 2 then
								self:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))
							end
						end
					else
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
							self:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptablecustom,g= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptablecustom,b= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptablecustom,a= 1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptablecustom,g= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptablecustom,b= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptablecustom,a= 1})
						else
							self:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptable,g= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptable,b= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptable, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptable,g= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptable,b= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptable,a= 1})
						end
					end
				end
			end
		end
	end
end
hooksecurefunc(NP, "Castbar_CheckInterrupt", ElvUI_EltreumUI.Castbar_CheckInterrupt)
