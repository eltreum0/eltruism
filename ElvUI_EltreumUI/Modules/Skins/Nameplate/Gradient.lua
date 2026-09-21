local E = unpack(ElvUI)
local NP = E:GetModule('NamePlates')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local UnitIsTapDenied = _G.UnitIsTapDenied
local InCombatLockdown = _G.InCombatLockdown
local UnitClass = _G.UnitClass
local UnitIsPlayer = _G.UnitIsPlayer
local UnitReaction = _G.UnitReaction
local UnitPlayerControlled = _G.UnitPlayerControlled
local UnitCanAttack = _G.UnitCanAttack
local UnitGUID = _G.UnitGUID
local UnitIsDead = _G.UnitIsDead
local UnitInPartyIsAI = _G.UnitInPartyIsAI
local CreateColor = _G.CreateColor

local function clamp(val)
	if val < 0 then
		return 0
	elseif val > 1 then
		return 1
	end
	return val
end
local whiteColor = CreateColor(1, 1, 1, 1)
local npPowerMin = CreateColor(1, 1, 1, 1)
local npPowerMax = CreateColor(1, 1, 1, 1)

--style filter gone
--gradient threat
function ElvUI_EltreumUI:ThreatIndicator_PostUpdate(nameplate, status)
	--nameplate.threatStatus
	if ElvUI_EltreumUI:EncounterCheck() then return end
	local db = NP.db.threat
	if status and db.enable and db.useThreatColor then
		if not nameplate.Health then return end
		local targetUnit = nameplate.__unit..'target'
		local isTank = E.myrole == 'TANK' or E.GroupRoles.player == 'TANK'
		local offTank = isTank and (E:UnitExists(targetUnit) and E:UnitNotUnit(targetUnit, 'player')) and ((db.beingTankedByPet and E.ThreatPets[NP:UnitNPCID(targetUnit)]) or (db.beingTankedByTank and E:UnitTankedByGroup(nameplate.__unit)))

		-- if gradient use gradient mode
		if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable then
			if not InCombatLockdown() or UnitIsDead("player") then
				nameplate.CurrentlyBeingTanked = nil
			end
			local tex = nameplate.Health:GetStatusBarTexture()
			if not tex then return end
			local orientation = E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation or "VERTICAL"

			if nameplate.isRare and E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.raretexture then
				nameplate.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", ElvUI_EltreumUI:GetNameplateRareClassTexture()))
				tex:SetGradient(orientation, whiteColor, whiteColor)
			else
				local threatType
				if status == 3 then -- securely tanking
					threatType = offTank and "OFFTANK" or (isTank and "GOODTHREAT" or "BADTHREAT")
					nameplate.CurrentlyBeingTanked = UnitGUID(nameplate.__unit)
				elseif status == 2 then -- insecurely tanking
					threatType = offTank and "OFFTANKBADTHREATTRANSITION" or (isTank and "BADTHREATTRANSITION" or "GOODTHREATTRANSITION")
					nameplate.CurrentlyBeingTanked = UnitGUID(nameplate.__unit)
				elseif status == 1 then -- not tanking but threat higher than tank
					threatType = offTank and "OFFTANKGOODTHREATTRANSITION" or (isTank and "GOODTHREATTRANSITION" or "BADTHREATTRANSITION")
					nameplate.CurrentlyBeingTanked = UnitGUID(nameplate.__unit)
				else -- not tanking at all
					threatType = isTank and "BADTHREAT" or "GOODTHREAT"
					nameplate.CurrentlyBeingTanked = UnitGUID(nameplate.__unit)
				end

				if threatType then
					local minC, maxC = ElvUI_EltreumUI:GetHealthGradient(threatType, false, E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor)
					tex:SetGradient(orientation, minC, maxC)
				end
			end
		end
	end
end
hooksecurefunc(NP, "ThreatIndicator_PostUpdate", ElvUI_EltreumUI.ThreatIndicator_PostUpdate)

--gradient nameplates
local bordercolor = E.myClassColor
local function GradientNameplates(unit,unit2)
	if not E.db.ElvUI_EltreumUI then return end
	if ElvUI_EltreumUI:EncounterCheck() then return end

	local frame = (unit and unit.__unit and unit) or (unit2 and unit2.__unit and unit2)
	if not frame or not frame.__unit or not frame.Health or not frame.Health:IsShown() then
		return
	end

	local _, className = UnitClass(frame.__unit)
	if not E:NotSecretValue(className) then --secret class so do something else
		className = E.myclass
	end
	local isPlayer = UnitIsPlayer(frame.__unit) or (E.Retail and UnitInPartyIsAI(frame.__unit))
	local reaction = UnitReaction(frame.__unit, "player")
	local tapdenied = UnitIsTapDenied(frame.__unit)
	local targettype

	if reaction and reaction >= 5 then
		targettype = "NPCFRIENDLY"
	elseif reaction and reaction == 4 then
		targettype = "NPCNEUTRAL"
	elseif reaction and reaction == 3 then
		targettype = "NPCUNFRIENDLY"
	elseif reaction and reaction <= 2 then
		targettype = "NPCHOSTILE"
	else --no reaction?
		targettype = "NPCNEUTRAL"
	end

	local hasThreat = frame.threatStatus and not tapdenied and NP.db.threat and NP.db.threat.enable and NP.db.threat.useThreatColor

	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable then
		if not InCombatLockdown() or UnitIsDead("player") then
			frame.CurrentlyBeingTanked = nil
		end

		local isOK
		if E.Retail then
			isOK = not frame.CurrentlyBeingTanked
		else
			isOK = (frame.CurrentlyBeingTanked ~= UnitGUID(frame.__unit))
		end

		local classification = frame.classification
		if (classification == 'worldboss' or classification == 'rareelite' or classification == 'rare') and not _G.IsInInstance() then
			frame.isRare = true
		else
			frame.isRare = false
		end

		local orientation = E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation or "VERTICAL"
		local tex = frame.Health:GetStatusBarTexture()
		if tex then
			if frame.isRare and E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.raretexture then
				frame.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", ElvUI_EltreumUI:GetNameplateRareClassTexture()))
				tex:SetGradient(orientation, whiteColor, whiteColor)
			elseif not hasThreat then
				local colorKey
				if className and isPlayer then
					colorKey = className
				elseif reaction and isOK then
					if tapdenied and not UnitPlayerControlled(frame.__unit) then
						colorKey = "TAPPED"
					elseif targettype then
						colorKey = targettype
					end
				end

				if colorKey then
					local minC, maxC = ElvUI_EltreumUI:GetHealthGradient(colorKey, false, E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor)
					tex:SetGradient(orientation, minC, maxC)
				end
			end
		end
	end

	if frame.Health.EltruismNameplateBorder and E.db.ElvUI_EltreumUI.borders and E.db.ElvUI_EltreumUI.borders.bordercolors then
		local borderKey = E.db.ElvUI_EltreumUI.borders.classcolor and (isPlayer and className or targettype) or "static"
		if frame.Health.EltruismNameplateBorder.EltruismBorderKey ~= borderKey then
			frame.Health.EltruismNameplateBorder.EltruismBorderKey = borderKey
			if E.db.ElvUI_EltreumUI.borders.classcolor then
				if isPlayer then
					bordercolor = ElvUI_EltreumUI:GetClassColorsRGB(className)
				else
					bordercolor = ElvUI_EltreumUI:GetClassColorsRGB(targettype)
				end
				if bordercolor and bordercolor.r then
					frame.Health.EltruismNameplateBorder:SetBackdropBorderColor(bordercolor.r, bordercolor.g, bordercolor.b, 1)
				end
			else
				local bc = E.db.ElvUI_EltreumUI.borders.bordercolors
				frame.Health.EltruismNameplateBorder:SetBackdropBorderColor(bc.r, bc.g, bc.b, 1)
			end
		end
	end

	if hasThreat then
		ElvUI_EltreumUI:ThreatIndicator_PostUpdate(frame, frame.threatStatus) --send to threat color
	end
end
hooksecurefunc(NP, "Health_UpdateColor", GradientNameplates)
hooksecurefunc(NP, "StylePlate", GradientNameplates)
hooksecurefunc(NP, "Update_Health", GradientNameplates)

--power gradient/combo/runes
function ElvUI_EltreumUI:NPClassPower_SetBarColor(bar, r, g, b)
	if ElvUI_EltreumUI:EncounterCheck() then return end
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable and E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
		if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepower then
			if bar.classPowerID or bar.token then --use somechecking for classpower and power bars
				local tex = bar:GetStatusBarTexture()
				if tex then
					local orientation = E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation or "VERTICAL"
					npPowerMin:SetRGBA(clamp(r - 0.3), clamp(g - 0.3), clamp(b - 0.3), 1)
					npPowerMax:SetRGBA(clamp(r), clamp(g), clamp(b), 1)
					tex:SetGradient(orientation, npPowerMin, npPowerMax)
				end
			else
				local parent = bar:GetParent()
				GradientNameplates(parent or bar)
			end
			--bar.bg:SetAlpha(0)
		else
			local parent = bar:GetParent()
			GradientNameplates(parent or bar)
		end
	end
end
hooksecurefunc(NP, "SetStatusBarColor", ElvUI_EltreumUI.NPClassPower_SetBarColor)
--will need to likely hook ClassPower_UpdateColor AND Power_UpdateColor

--style filters were removed
--[[
--to fix stylefilter for gradient nameplates
function ElvUI_EltreumUI:StyleFilterClearChanges(frame)
	if ElvUI_EltreumUI:EncounterCheck() then return end
	-- bar stuff
	local h = frame.Health
	if h.r and h.g and h.b then
		if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable then
			GradientNameplates(frame)
		end
	end
end
hooksecurefunc(NP, "StyleFilterClearChanges", ElvUI_EltreumUI.StyleFilterClearChanges)

--to set slight gradient to style filter
function ElvUI_EltreumUI:StyleFilterSetChanges(frame)
	if ElvUI_EltreumUI:EncounterCheck() then return end
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable then
		if frame.StyleFilterChanges.health and frame.StyleFilterChanges.health.colors then
			local hc = frame.StyleFilterChanges.health.color
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
				frame.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation or "VERTICAL", {r=hc.r,g= hc.g,b= hc.b,a= hc.a or 1}, {r=hc.r + E.db.ElvUI_EltreumUI.unitframes.gradientmode.stylefilterr,g= hc.g + E.db.ElvUI_EltreumUI.unitframes.gradientmode.stylefilterg,b= hc.b + E.db.ElvUI_EltreumUI.unitframes.gradientmode.stylefilterb,a= hc.a or 1})
			else
				frame.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation or "VERTICAL", {r=hc.r,g= hc.g,b= hc.b,a= hc.a or 1}, {r=hc.r-0.4,g= hc.g-0.4,b= hc.b-0.4,a= hc.a or 1})
			end
		end
	end
end
hooksecurefunc(NP, "StyleFilterSetChanges", ElvUI_EltreumUI.StyleFilterSetChanges)
]]

--elvui castbar texture/gradient
function ElvUI_EltreumUI:Castbar_CheckInterrupt(unit)
	if ElvUI_EltreumUI:EncounterCheck() then return end
	if unit == 'vehicle' then
		unit = 'player'
	end
	local _, unitclass = UnitClass(unit)
	if not E:NotSecretValue(unitclass) then --secret class so do something else
		unitclass = E.myclass
	end
	local reactiontarget = UnitReaction(unit, "player")
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable then
		local tex = self:GetStatusBarTexture()
		if tex then
			local orientation = E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation or "VERTICAL"
			local gm = E.db.ElvUI_EltreumUI.unitframes.gradientmode
			if self.notInterruptible and UnitCanAttack('player', unit) then
				local c1, c2 = ElvUI_EltreumUI:GetCastbarGradient(gm.npcustomcolor and "noninterruptible_custom" or "noninterruptible_default")
				tex:SetGradient(orientation, c1, c2)
			elseif (not self.notInterruptible) and (not ElvUI_EltreumUI:CheckmMediaTagInterrupt()) then
				if UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit)) then
					if gm.npcustomcolor and not gm.classcolortargetcastbar then
						local c1, c2 = ElvUI_EltreumUI:GetCastbarGradient("target_custom")
						tex:SetGradient(orientation, c1, c2)
					elseif gm.classcolortargetcastbar then
						local c1, c2 = ElvUI_EltreumUI:GetHealthGradient(unitclass, false, gm.npcustomcolor)
						tex:SetGradient(orientation, c1, c2)
					else
						local c1, c2 = ElvUI_EltreumUI:GetCastbarGradient(gm.npcustomcolor and "interruptible_custom" or "interruptible_default")
						tex:SetGradient(orientation, c1, c2)
					end
				else
					if gm.npcustomcolor and not gm.classcolortargetcastbar then
						local c1, c2 = ElvUI_EltreumUI:GetCastbarGradient("interruptible_custom")
						tex:SetGradient(orientation, c1, c2)
					else
						if gm.targetcastbarreactioninterruptable then
							local reactionKey
							if reactiontarget and reactiontarget >= 5 then
								reactionKey = "NPCFRIENDLY"
							elseif reactiontarget == 4 then
								reactionKey = "NPCNEUTRAL"
							elseif reactiontarget == 3 then
								reactionKey = "NPCUNFRIENDLY"
							elseif reactiontarget and reactiontarget <= 2 then
								reactionKey = "NPCHOSTILE"
							end
							if reactionKey then
								local c1, c2 = ElvUI_EltreumUI:GetHealthGradient(reactionKey, false, gm.customcolor and gm.classcolortargetcastbar)
								tex:SetGradient(orientation, c1, c2)
							end
						else
							local c1, c2 = ElvUI_EltreumUI:GetCastbarGradient(gm.npcustomcolor and "interruptible_custom" or "interruptible_default")
							tex:SetGradient(orientation, c1, c2)
						end
					end
				end
			end
		end
	end
	if self.EltruismNameplateBorder then
		local borderType = (self.notInterruptible and UnitCanAttack('player', unit)) and "nointerrupt" or (((not self.notInterruptible) and (not ElvUI_EltreumUI:CheckmMediaTagInterrupt())) and "interrupt" or nil)
		if borderType and self.EltruismNameplateBorder.EltruismCastBorderKey ~= borderType then
			self.EltruismNameplateBorder.EltruismCastBorderKey = borderType
			if borderType == "nointerrupt" then
				self.EltruismNameplateBorder:SetBackdropBorderColor(E.db.nameplates.colors.castNoInterruptColor.r, E.db.nameplates.colors.castNoInterruptColor.g, E.db.nameplates.colors.castNoInterruptColor.b, 1)
			else
				self.EltruismNameplateBorder:SetBackdropBorderColor(E.db.nameplates.colors.castColor.r, E.db.nameplates.colors.castColor.g, E.db.nameplates.colors.castColor.b, 1)
			end
		end
	end
end
if not E.Retail then
	hooksecurefunc(NP, "Castbar_CheckInterrupt", ElvUI_EltreumUI.Castbar_CheckInterrupt)
end
--interrupted
function ElvUI_EltreumUI:Castbar_PostCastFail()
	if self.EltruismNameplateBorder then
		self.EltruismNameplateBorder.EltruismCastBorderKey = "failed"
		self.EltruismNameplateBorder:SetBackdropBorderColor(E.db.nameplates.colors.castInterruptedColor.r, E.db.nameplates.colors.castInterruptedColor.g, E.db.nameplates.colors.castInterruptedColor.b, 1)
	end
end
if not E.Retail then
	hooksecurefunc(NP, "Castbar_PostCastFail", ElvUI_EltreumUI.Castbar_PostCastFail)
end
