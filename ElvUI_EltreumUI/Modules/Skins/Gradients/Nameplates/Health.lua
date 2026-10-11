local E = unpack(ElvUI)
local NP = E:GetModule('NamePlates')
local _G = _G
local UnitIsTapDenied = _G.UnitIsTapDenied
local UnitClass = _G.UnitClass
local UnitIsPlayer = _G.UnitIsPlayer
local UnitReaction = _G.UnitReaction
local UnitPlayerControlled = _G.UnitPlayerControlled
local UnitInPartyIsAI = _G.UnitInPartyIsAI
local UnitCanAttack = _G.UnitCanAttack
local UnitIsEnemy = _G.UnitIsEnemy
local UnitIsFriend = _G.UnitIsFriend
local UnitAffectingCombat = _G.UnitAffectingCombat
local CreateColor = _G.CreateColor
local type = _G.type
local whiteColor = CreateColor(1, 1, 1, 1)

local function GetFrame(arg)
	if type(arg) == "table" then
		if arg.__unit then
			return arg
		elseif arg.__owner and type(arg.__owner) == "table" and arg.__owner.__unit then
			return arg.__owner
		end
	end
end

function ElvUI_EltreumUI:GetNameplateTargetType(frame, unit)
	unit = unit or (frame and frame.__unit)
	if not unit then return "NPCNEUTRAL" end

	local reaction = (UnitReaction(unit, "player") or UnitReaction("player", unit))
	if not reaction and frame then
		reaction = frame.repReaction or frame.reaction
	end

	if reaction and E:NotSecretValue(reaction) then
		if reaction <= 2 then
			return "NPCHOSTILE"
		elseif reaction == 3 then
			return "NPCUNFRIENDLY"
		elseif reaction == 4 then
			local canAttack = UnitCanAttack("player", unit)
			local isEnemy = UnitIsEnemy("player", unit)
			local inCombat = UnitAffectingCombat(unit) or UnitAffectingCombat("player")
			local frameIsEnemy = frame and (frame.isEnemy or frame.frameType == "ENEMY_NPC" or frame.frameType == "ENEMY_PLAYER")
			if ((E:NotSecretValue(canAttack) and canAttack) or (E:NotSecretValue(isEnemy) and isEnemy) or frameIsEnemy) and (inCombat or frameIsEnemy) then
				return "NPCHOSTILE"
			else
				return "NPCNEUTRAL"
			end
		elseif reaction >= 5 then
			return "NPCFRIENDLY"
		end
	end

	-- Fallback when reaction is nil, unknown, or secret
	local canAttack = UnitCanAttack("player", unit)
	local isEnemy = UnitIsEnemy("player", unit)
	local frameIsEnemy = frame and (frame.isEnemy or frame.frameType == "ENEMY_NPC" or frame.frameType == "ENEMY_PLAYER")
	if (E:NotSecretValue(canAttack) and canAttack) or (E:NotSecretValue(isEnemy) and isEnemy) or frameIsEnemy then
		return "NPCHOSTILE"
	else
		local isFriend = UnitIsFriend("player", unit)
		local frameIsFriend = frame and (frame.isFriend or frame.frameType == "FRIENDLY_NPC" or frame.frameType == "FRIENDLY_PLAYER")
		if (E:NotSecretValue(isFriend) and isFriend) or frameIsFriend then
			return "NPCFRIENDLY"
		else
			return "NPCNEUTRAL"
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

	if not (status and db.enable and db.useThreatColor and EltruismDB.unitframes.gradientmode.npenable and not UnitIsTapDenied(frame.__unit)) then
		if EltruismDB and EltruismDB.unitframes and EltruismDB.unitframes.gradientmode and EltruismDB.unitframes.gradientmode.npenable then
			ElvUI_EltreumUI.GradientNameplates(frame)
		end
		return
	end

	local targetUnit = ElvUI_EltreumUI:GetTargetUnit(frame.__unit)
	local isTank = E.myrole == 'TANK' or E.GroupRoles.player == 'TANK'
	local offTank = isTank and (E:UnitExists(targetUnit) and E:UnitNotUnit(targetUnit, 'player')) and ((db.beingTankedByPet and E.ThreatPets[NP:UnitNPCID(targetUnit)]) or (db.beingTankedByTank and E:UnitTankedByGroup(frame.__unit)))

	local tex = frame.Health:GetStatusBarTexture()
	if not tex then return end
	local orientation = EltruismDB.unitframes.gradientmode.nporientation or "VERTICAL"

	if frame.isRare and EltruismDB.nameplates.nameplateOptions.raretexture then
		local rareTex = E.LSM:Fetch("statusbar", ElvUI_EltreumUI:GetNameplateRareClassTexture())
		if frame.Health.EltruismRareTex ~= rareTex then
			frame.Health:SetStatusBarTexture(rareTex)
			frame.Health.EltruismRareTex = rareTex
		end
		if frame.Health.EltruismRareOrient ~= orientation or frame.EltruismForceGradient then
			tex:SetGradient(orientation, whiteColor, whiteColor)
			frame.Health.EltruismRareOrient = orientation
			frame.EltruismForceGradient = nil
		end
	else
		frame.Health.EltruismRareTex = nil
		frame.Health.EltruismRareOrient = nil
		local threatType
		if status == 3 then -- securely tanking
			threatType = offTank and "OFFTANK" or (isTank and "GOODTHREAT" or "BADTHREAT")
		elseif status == 2 then -- insecurely tanking
			threatType = offTank and "OFFTANKBADTHREATTRANSITION" or (isTank and "BADTHREATTRANSITION" or "GOODTHREATTRANSITION")
		elseif status == 1 then -- not tanking but threat higher than tank
			threatType = offTank and "OFFTANKGOODTHREATTRANSITION" or (isTank and "GOODTHREATTRANSITION" or "BADTHREATTRANSITION")
		else -- not tanking at all
			threatType = offTank and "OFFTANK" or (isTank and "BADTHREAT" or "GOODTHREAT")
		end

		if threatType then
			local custom = EltruismDB.unitframes.gradientmode.npcustomcolor
			if frame.EltruismLastThreatType ~= threatType or frame.EltruismLastThreatOrient ~= orientation or frame.EltruismLastThreatCustom ~= custom or frame.EltruismForceGradient then
				local minC, maxC = ElvUI_EltreumUI:GetHealthGradient(threatType, false, custom)
				tex:SetGradient(orientation, minC, maxC)
				frame.EltruismLastThreatType = threatType
				frame.EltruismLastThreatOrient = orientation
				frame.EltruismLastThreatCustom = custom
				frame.EltruismLastColorKey = nil
				frame.EltruismForceGradient = nil

				if frame.Health.EltruismNameplateBorder then
					frame.Health.EltruismNameplateBorder:SetBackdropBorderColor(maxC.r, maxC.g, maxC.b, 1)
				end
			end
		end
	end
end

--gradient nameplates
function ElvUI_EltreumUI.GradientNameplates(nameplate)
	local db = E.db.ElvUI_EltreumUI
	if not db then return end
	if ElvUI_EltreumUI:EncounterCheck() then return end

	local frame = GetFrame(nameplate)
	if not frame or not frame.__unit or not frame.Health or not frame.Health:IsShown() then
		return
	end

	local npEnabled = db.unitframes.gradientmode.npenable
	local borderFrame = frame.Health.EltruismNameplateBorder
	local bordersEnabled = borderFrame and db.borders and db.borders.bordercolors

	if not npEnabled and not bordersEnabled then return end

	local unit = frame.__unit
	local _, className = UnitClass(unit)
	if not E:NotSecretValue(className) then --secret class so do something else
		className = E.myclass
	end

	local isPlayer = frame.isPlayer or UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit))
	local tapdenied = UnitIsTapDenied(unit)
	local targettype = ElvUI_EltreumUI:GetNameplateTargetType(frame, unit)

	local hasThreat = frame.threatStatus and not tapdenied and NP.db.threat and NP.db.threat.enable and NP.db.threat.useThreatColor

	if npEnabled then
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
				if frame.Health.EltruismRareOrient ~= orientation or frame.EltruismForceGradient then
					tex:SetGradient(orientation, whiteColor, whiteColor)
					frame.Health.EltruismRareOrient = orientation
					frame.EltruismForceGradient = nil
				end
			elseif hasThreat then
				ElvUI_EltreumUI:ThreatIndicator_PostUpdate(frame, frame.threatStatus)
			else
				frame.Health.EltruismRareTex = nil
				frame.Health.EltruismRareOrient = nil
				frame.EltruismLastThreatType = nil

				local colorKey
				if isPlayer and className then
					colorKey = className
				elseif tapdenied and not UnitPlayerControlled(unit) then
					colorKey = "TAPPED"
				else
					colorKey = targettype
				end

				if colorKey then
					local custom = db.unitframes.gradientmode.npcustomcolor
					if frame.EltruismLastColorKey ~= colorKey or frame.EltruismLastGradientOrient ~= orientation or frame.EltruismLastColorCustom ~= custom or frame.EltruismForceGradient then
						local minC, maxC = ElvUI_EltreumUI:GetHealthGradient(colorKey, false, custom)
						tex:SetGradient(orientation, minC, maxC)
						frame.EltruismLastColorKey = colorKey
						frame.EltruismLastGradientOrient = orientation
						frame.EltruismLastColorCustom = custom
						frame.EltruismForceGradient = nil

						if borderFrame then
							borderFrame:SetBackdropBorderColor(maxC.r, maxC.g, maxC.b, 1)
						end
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
end
function ElvUI_EltreumUI:NP_Update_Health(_, nameplate)
	local plate = GetFrame(nameplate)
	if not plate then return end
	plate.EltruismForceGradient = true
	ElvUI_EltreumUI.GradientNameplates(plate)
	ElvUI_EltreumUI.OnUpdateHealth(plate)
end

function ElvUI_EltreumUI:NP_ThreatIndicator_PostUpdate(indicator, _, status)
	local nameplate = indicator and (indicator.__owner or GetFrame(indicator))
	if nameplate then
		ElvUI_EltreumUI:ThreatIndicator_PostUpdate(nameplate, status or nameplate.threatStatus)
		ElvUI_EltreumUI.OnThreatOrColorUpdate(nameplate)
	end
end

function ElvUI_EltreumUI:Health_UpdateColor(healthOrFrame)
	local plate = GetFrame(healthOrFrame)
	if not plate then return end
	plate.EltruismForceGradient = true
	ElvUI_EltreumUI.GradientNameplates(plate)
	ElvUI_EltreumUI.OnThreatOrColorUpdate(plate)
end

function ElvUI_EltreumUI:NP_StylePlate(_, nameplate)
	local plate = GetFrame(nameplate)
	if not plate then return end
	plate.EltruismForceGradient = true
	plate.EltruismLastThreatType = nil
	plate.EltruismLastColorKey = nil
	if ElvUI_EltreumUI.GradientNameplates then
		ElvUI_EltreumUI.GradientNameplates(plate)
	end
	if ElvUI_EltreumUI.NameplateShadowsAndBorders then
		ElvUI_EltreumUI:NameplateShadowsAndBorders(plate)
	end
	if ElvUI_EltreumUI.NP_StylePlate_Classification then
		ElvUI_EltreumUI:NP_StylePlate_Classification(plate)
	end
end

ElvUI_EltreumUI:SecureHook(NP, "StylePlate", "NP_StylePlate")
ElvUI_EltreumUI:SecureHook(NP, "Update_Health", "NP_Update_Health")
ElvUI_EltreumUI:SecureHook(NP, "Health_UpdateColor", "Health_UpdateColor")
ElvUI_EltreumUI:SecureHook(NP, "ThreatIndicator_PostUpdate", "NP_ThreatIndicator_PostUpdate")
