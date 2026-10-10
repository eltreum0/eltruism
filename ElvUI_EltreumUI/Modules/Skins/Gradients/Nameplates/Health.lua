local E = unpack(ElvUI)
local NP = E:GetModule('NamePlates')
local _G = _G
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
local type = _G.type
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

local function GetFrame(arg)
	if type(arg) == "table" then
		if arg.__unit then
			return arg
		elseif arg.__owner and type(arg.__owner) == "table" and arg.__owner.__unit then
			return arg.__owner
		end
	end
end

--style filter gone
--gradient threat
function ElvUI_EltreumUI:ThreatIndicator_PostUpdate(nameplate, status)
	--nameplate.threatStatus
	if ElvUI_EltreumUI:EncounterCheck() then return end
	local frame = GetFrame(nameplate)
	if not frame or not frame.Health or not frame.__unit then return end

	local db = NP.db.threat
	local EltruismDB = E.db.ElvUI_EltreumUI

	if not (status and db.enable and db.useThreatColor and EltruismDB.unitframes.gradientmode.npenable) then return end

	local targetUnit = ElvUI_EltreumUI:GetTargetUnit(frame.__unit)
	local isTank = E.myrole == 'TANK' or E.GroupRoles.player == 'TANK'
	local offTank = isTank and (E:UnitExists(targetUnit) and E:UnitNotUnit(targetUnit, 'player')) and ((db.beingTankedByPet and E.ThreatPets[NP:UnitNPCID(targetUnit)]) or (db.beingTankedByTank and E:UnitTankedByGroup(frame.__unit)))

	if not InCombatLockdown() or UnitIsDead("player") then
		frame.CurrentlyBeingTanked = nil
	end

	local tex = frame.Health:GetStatusBarTexture()
	if not tex then return end
	local orientation = EltruismDB.unitframes.gradientmode.nporientation or "VERTICAL"

	if frame.isRare and EltruismDB.nameplates.nameplateOptions.raretexture then
		local rareTex = E.LSM:Fetch("statusbar", ElvUI_EltreumUI:GetNameplateRareClassTexture())
		if frame.Health.EltruismRareTex ~= rareTex then
			frame.Health:SetStatusBarTexture(rareTex)
			frame.Health.EltruismRareTex = rareTex
		end
		tex:SetGradient(orientation, whiteColor, whiteColor)
	else
		frame.Health.EltruismRareTex = nil
		local threatType
		if status == 3 then -- securely tanking
			threatType = offTank and "OFFTANK" or (isTank and "GOODTHREAT" or "BADTHREAT")
			frame.CurrentlyBeingTanked = UnitGUID(frame.__unit)
		elseif status == 2 then -- insecurely tanking
			threatType = offTank and "OFFTANKBADTHREATTRANSITION" or (isTank and "BADTHREATTRANSITION" or "GOODTHREATTRANSITION")
			frame.CurrentlyBeingTanked = UnitGUID(frame.__unit)
		elseif status == 1 then -- not tanking but threat higher than tank
			threatType = offTank and "OFFTANKGOODTHREATTRANSITION" or (isTank and "GOODTHREATTRANSITION" or "BADTHREATTRANSITION")
			frame.CurrentlyBeingTanked = UnitGUID(frame.__unit)
		else -- not tanking at all
			threatType = isTank and "BADTHREAT" or "GOODTHREAT"
			frame.CurrentlyBeingTanked = UnitGUID(frame.__unit)
		end

		if threatType then
			local minC, maxC = ElvUI_EltreumUI:GetHealthGradient(threatType, false, EltruismDB.unitframes.gradientmode.npcustomcolor)
			tex:SetGradient(orientation, minC, maxC)

			if frame.Health.EltruismNameplateBorder then
				frame.Health.EltruismNameplateBorder:SetBackdropBorderColor(maxC.r,maxC.g,maxC.b, 1)
			end
		end
	end
end

--gradient nameplates
function ElvUI_EltreumUI.GradientNameplates(arg1, arg2, arg3, arg4)
	local db = E.db.ElvUI_EltreumUI
	if not db then return end
	if ElvUI_EltreumUI:EncounterCheck() then return end

	local frame = GetFrame(arg1) or GetFrame(arg2) or GetFrame(arg3) or GetFrame(arg4)
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
function ElvUI_EltreumUI:NP_Update_Health(arg1, arg2, arg3)
	ElvUI_EltreumUI.GradientNameplates(arg1, arg2, arg3)
	ElvUI_EltreumUI.OnUpdateHealth(arg1, arg2, arg3)
end

function ElvUI_EltreumUI:NP_ThreatIndicator_PostUpdate(arg1, arg2, arg3, arg4)
	local status = (type(arg4) == "number" and arg4) or (type(arg3) == "number" and arg3) or (type(arg2) == "number" and arg2) or (arg1 and type(arg1) == "table" and arg1.threatStatus)
	local nameplate = GetFrame(arg1) or GetFrame(arg2) or GetFrame(arg3) or GetFrame(arg4)
	if nameplate then
		ElvUI_EltreumUI:ThreatIndicator_PostUpdate(nameplate, status)
	end
	ElvUI_EltreumUI.OnThreatOrColorUpdate(arg1, arg2, arg3, arg4)
end

function ElvUI_EltreumUI:Health_UpdateColor(arg1, arg2, arg3, arg4)
	ElvUI_EltreumUI.GradientNameplates(arg1, arg2, arg3, arg4)
	ElvUI_EltreumUI.OnThreatOrColorUpdate(arg1, arg2, arg3, arg4)
end

ElvUI_EltreumUI:SecureHook(NP, "StylePlate", "GradientNameplates")
ElvUI_EltreumUI:SecureHook(NP, "Update_Health", "NP_Update_Health")
ElvUI_EltreumUI:SecureHook(NP, "Health_UpdateColor", "Health_UpdateColor")
ElvUI_EltreumUI:SecureHook(NP, "ThreatIndicator_PostUpdate", "NP_ThreatIndicator_PostUpdate")
