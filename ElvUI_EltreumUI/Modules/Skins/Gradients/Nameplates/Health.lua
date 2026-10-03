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
local UnitGUID = _G.UnitGUID
local UnitIsDead = _G.UnitIsDead
local UnitInPartyIsAI = _G.UnitInPartyIsAI
local CreateColor = _G.CreateColor
local CreateFrame = _G.CreateFrame

local whiteColor = CreateColor(1, 1, 1, 1)

local reactionToTargetType = {
	[1] = "NPCHOSTILE",
	[2] = "NPCHOSTILE",
	[3] = "NPCUNFRIENDLY",
	[4] = "NPCNEUTRAL",
	[5] = "NPCFRIENDLY",
	[6] = "NPCFRIENDLY",
	[7] = "NPCFRIENDLY",
	[8] = "NPCFRIENDLY",
}

--style filter gone
--gradient threat
function ElvUI_EltreumUI:ThreatIndicator_PostUpdate(nameplate, status)
	--nameplate.threatStatus
	if ElvUI_EltreumUI:EncounterCheck() then return end
	local db = NP.db.threat
	local EltruismDB = E.db.ElvUI_EltreumUI

	if not (status and db.enable and db.useThreatColor and EltruismDB.unitframes.gradientmode.npenable) then return end
	if not nameplate.Health then return end

	local targetUnit = ElvUI_EltreumUI:GetTargetUnit(nameplate.__unit)
	local isTank = E.myrole == 'TANK' or E.GroupRoles.player == 'TANK'
	local offTank = isTank and (E:UnitExists(targetUnit) and E:UnitNotUnit(targetUnit, 'player')) and ((db.beingTankedByPet and E.ThreatPets[NP:UnitNPCID(targetUnit)]) or (db.beingTankedByTank and E:UnitTankedByGroup(nameplate.__unit)))

	if not InCombatLockdown() or UnitIsDead("player") then
		nameplate.CurrentlyBeingTanked = nil
	end

	local tex = nameplate.Health:GetStatusBarTexture()
	if not tex then return end
	local orientation = EltruismDB.unitframes.gradientmode.nporientation or "VERTICAL"

	if nameplate.isRare and EltruismDB.nameplates.nameplateOptions.raretexture then
		local rareTex = E.LSM:Fetch("statusbar", ElvUI_EltreumUI:GetNameplateRareClassTexture())
		if nameplate.Health.EltruismRareTex ~= rareTex then
			nameplate.Health:SetStatusBarTexture(rareTex)
			nameplate.Health.EltruismRareTex = rareTex
		end
		tex:SetGradient(orientation, whiteColor, whiteColor)
	else
		nameplate.Health.EltruismRareTex = nil
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
			local minC, maxC = ElvUI_EltreumUI:GetHealthGradient(threatType, false, EltruismDB.unitframes.gradientmode.npcustomcolor)
			tex:SetGradient(orientation, minC, maxC)

			if nameplate.Health.EltruismNameplateBorder then
				nameplate.Health.EltruismNameplateBorder:SetBackdropBorderColor(maxC.r,maxC.g,maxC.b, 1)
			end
		end
	end
end
hooksecurefunc(NP, "ThreatIndicator_PostUpdate", ElvUI_EltreumUI.ThreatIndicator_PostUpdate)

--gradient nameplates
function ElvUI_EltreumUI.GradientNameplates(unit,unit2)
	local db = E.db.ElvUI_EltreumUI
	if not db then return end
	if ElvUI_EltreumUI:EncounterCheck() then return end

	local frame = (unit and unit.__unit and unit) or (unit2 and unit2.__unit and unit2)
	if not frame or not frame.__unit or not frame.Health or not frame.Health:IsShown() then
		return
	end

	local npEnabled = db.unitframes.gradientmode.npenable
	local borderFrame = frame.Health.EltruismNameplateBorder
	local bordersEnabled = borderFrame and db.borders and db.borders.bordercolors

	if not npEnabled and not bordersEnabled then return end

	local _, className = UnitClass(frame.__unit)
	if not E:NotSecretValue(className) then --secret class so do something else
		className = E.myclass
	end

	local isPlayer = UnitIsPlayer(frame.__unit) or (E.Retail and UnitInPartyIsAI(frame.__unit))
	local reaction = UnitReaction(frame.__unit, "player")
	local tapdenied = UnitIsTapDenied(frame.__unit)
	local targettype = reaction and reactionToTargetType[reaction] or "NPCNEUTRAL"

	local hasThreat = frame.threatStatus and not tapdenied and NP.db.threat and NP.db.threat.enable and NP.db.threat.useThreatColor

	if npEnabled then
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
		frame.isRare = (classification == 'worldboss' or classification == 'rareelite' or classification == 'rare') and not ElvUI_EltreumUI:IsInInstance()

		local orientation = db.unitframes.gradientmode.nporientation or "VERTICAL"
		local tex = frame.Health:GetStatusBarTexture()

		if tex then
			if frame.isRare and db.nameplates.nameplateOptions.raretexture then
				local rareTex = E.LSM:Fetch("statusbar", ElvUI_EltreumUI:GetNameplateRareClassTexture())
				if frame.Health.EltruismRareTex ~= rareTex then
					frame.Health:SetStatusBarTexture(rareTex)
					frame.Health.EltruismRareTex = rareTex
				end
				tex:SetGradient(orientation, whiteColor, whiteColor)
			elseif not hasThreat then
				frame.Health.EltruismRareTex = nil
				local colorKey
				if className and isPlayer then
					colorKey = className
				elseif reaction and isOK then
					if tapdenied and not UnitPlayerControlled(frame.__unit) then
						colorKey = "TAPPED"
					else
						colorKey = targettype
					end
				end

				if colorKey then
					local minC, maxC = ElvUI_EltreumUI:GetHealthGradient(colorKey, false, db.unitframes.gradientmode.npcustomcolor)
					tex:SetGradient(orientation, minC, maxC)
					if borderFrame then
						borderFrame:SetBackdropBorderColor(maxC.r, maxC.g, maxC.b, 1)
					end
				end
			end
		end
	end

	if bordersEnabled then
		local borderKey = db.borders.classcolor and (isPlayer and className or targettype) or "static"
		if borderFrame.EltruismBorderKey ~= borderKey then
			borderFrame.EltruismBorderKey = borderKey
			if db.borders.classcolor then
				local bordercolor = ElvUI_EltreumUI:GetClassColorsRGB(isPlayer and className or targettype)
				if bordercolor and bordercolor.r then
					borderFrame:SetBackdropBorderColor(bordercolor.r, bordercolor.g, bordercolor.b, 1)
				end
			else
				local bc = db.borders.bordercolors
				borderFrame:SetBackdropBorderColor(bc.r, bc.g, bc.b, 1)
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
