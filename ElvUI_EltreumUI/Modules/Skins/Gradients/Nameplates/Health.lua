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

local whiteColor = CreateColor(1, 1, 1, 1)

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

					if nameplate.Health.EltruismNameplateBorder then
						nameplate.Health.EltruismNameplateBorder:SetBackdropBorderColor(maxC.r,maxC.g,maxC.b, 1)
					end
				end
			end
		end
	end
end
hooksecurefunc(NP, "ThreatIndicator_PostUpdate", ElvUI_EltreumUI.ThreatIndicator_PostUpdate)

--gradient nameplates
local bordercolor = E.myClassColor
function ElvUI_EltreumUI.GradientNameplates(unit,unit2)
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
		if E.Modern then
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
					if frame.Health.EltruismNameplateBorder then
						frame.Health.EltruismNameplateBorder:SetBackdropBorderColor(maxC.r,maxC.g,maxC.b, 1)
					end
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
hooksecurefunc(NP, "Health_UpdateColor", ElvUI_EltreumUI.GradientNameplates)
hooksecurefunc(NP, "StylePlate", ElvUI_EltreumUI.GradientNameplates)
hooksecurefunc(NP, "Update_Health", ElvUI_EltreumUI.GradientNameplates)
