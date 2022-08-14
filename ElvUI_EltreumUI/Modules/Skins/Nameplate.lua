local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local NP = E:GetModule('NamePlates')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local nameplate, colors, db
local sf
local db
local Color, Scale
local targettype
local reaction
local _, className
local player
local h
local pc
local tx
local UnitIsTapDenied = _G.UnitIsTapDenied
local InCombatLockdown = _G.InCombatLockdown
local UnitClass = _G.UnitClass
local UnitIsPlayer = _G.UnitIsPlayer
local UnitReaction = _G.UnitReaction
local UnitPlayerControlled = _G.UnitPlayerControlled
local UnitAffectingCombat = _G.UnitAffectingCombat
local UnitIsUnit = _G.UnitIsUnit
local CreateFrame = _G.CreateFrame

--gradient threat
function NP:ThreatIndicator_PostUpdate(unit, status)
	nameplate, colors, db = self.__owner, NP.db.colors.threat, NP.db.threat
	sf = NP:StyleFilterChanges(nameplate)
	if not status and not sf.Scale then
		nameplate.ThreatScale = 1
		NP:ScalePlate(nameplate, 1)
	elseif status and db.enable and db.useThreatColor and not UnitIsTapDenied(unit) then
		NP:Health_SetColors(nameplate, true)
		nameplate.ThreatStatus = status

		-- if gradient use gradient mode
		if E.db.ElvUI_EltreumUI.gradientmode.npenable then
			if not InCombatLockdown() then
				nameplate.CurrentlyBeingTanked = nil
			end
			if sf.HealthColor then
				return
			end
			if status == 3 then -- securely tanking
				--Color = self.offTank and colors.offTankColor or self.isTank and colors.goodColor or colors.badColor
				if self.isTank and not sf.HealthColor then
					nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("GOODTHREAT", false, false))
					nameplate.CurrentlyBeingTanked = nameplate.unit.."isbeingtanked"
				elseif self.offTank  and not sf.HealthColor then
					nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("OFFTANK", false, false))
					nameplate.CurrentlyBeingTanked = nameplate.unit.."isbeingtanked"
				elseif (not self.isTank or not self.offTank) and not sf.HealthColor then
					nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("BADTHREAT", false, false))
					nameplate.CurrentlyBeingTanked = nameplate.unit.."isbeingtanked"
				end
				Scale = self.isTank and db.goodScale or db.badScale
			elseif status == 2 then -- insecurely tanking
				--Color = self.offTank and colors.offTankColorBadTransition or self.isTank and colors.badTransition or colors.goodTransition
				if self.isTank and not sf.HealthColor then
					nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("BADTHREATTRANSITION", false, false))
					nameplate.CurrentlyBeingTanked = nameplate.unit.."isbeingtanked"
				elseif self.offTank  and not sf.HealthColor then
					nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("OFFTANKBADTHREATTRANSITION", false, false))
					nameplate.CurrentlyBeingTanked = nameplate.unit.."isbeingtanked"
				elseif (not self.isTank or not self.offTank) and not sf.HealthColor then
					nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("GOODTHREATTRANSITION", false, false))
					nameplate.CurrentlyBeingTanked = nameplate.unit.."isbeingtanked"
				end
				Scale = 1
			elseif status == 1 then -- not tanking but threat higher than tank
				--Color = self.offTank and colors.offTankColorGoodTransition or self.isTank and colors.goodTransition or colors.badTransition
				if self.isTank and not sf.HealthColor then
					nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("GOODTHREATTRANSITION", false, false))
					nameplate.CurrentlyBeingTanked = nameplate.unit.."isbeingtanked"
				elseif self.offTank  and not sf.HealthColor then
					nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("OFFTANKGOODTHREATTRANSITION", false, false))
					nameplate.CurrentlyBeingTanked = nameplate.unit.."isbeingtanked"
				elseif (not self.isTank or not self.offTank) and not sf.HealthColor then
					nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("BADTHREATTRANSITION", false, false))
					nameplate.CurrentlyBeingTanked = nameplate.unit.."isbeingtanked"
				end
				Scale = 1
			else -- not tanking at all
				--Color = self.isTank and colors.badColor or colors.goodColor
				if self.isTank and not sf.HealthColor then
					nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("BADTHREAT", false, false))
					nameplate.CurrentlyBeingTanked = nameplate.unit.."isbeingtanked"
				elseif self.offTank and not sf.HealthColor then
					nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("GOODTHREAT", false, false))
					nameplate.CurrentlyBeingTanked = nameplate.unit.."isbeingtanked"
				elseif (not self.isTank or not self.offTank) and not sf.HealthColor then
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
		elseif not E.db.ElvUI_EltreumUI.gradientmode.npenable then -- use regular elvui mode
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
			_, className = UnitClass(unit.unit)
			player = UnitIsPlayer(unit.unit)
			reaction =  UnitReaction(unit.unit, "player")

			sf = NP:StyleFilterChanges(unit)
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




--[[
local swapped
local targettableGUID = {}
local targettableUNIT = {}
local previoustargettableUNIT = {}

--Custom Health Height Conditions
function ElvUI_EltreumUI:CustomHealthHeight(nameplate)
	--print(unit,nameplate)

	--nameplate hack attempt
	if UnitExists("target") then
		nptarget = C_NamePlate.GetNamePlateForUnit("target")
		if nptarget then
			nptargetunit = nptarget.UnitFrame.BuffFrame.unit
			nptargetunitGUID = UnitGUID(nptarget.UnitFrame.BuffFrame.unit)

			targettableUNIT[1] = nptargetunit
			tinsert(previoustargettableUNIT, nptargetunit)
			if previoustargettableUNIT[2] ~= targettableUNIT[1] then
				print("aa")
			end

			if targettableGUID[1] ~= nptargetunitGUID then
				print("c",nptargetunitGUID)

				targettableGUID[1] = nptargetunitGUID
				swapped = true
			elseif targettableGUID[1] == nptargetunitGUID then
				--print("a",nptargetunitGUID)
				swapped = false
			end
		end
	else
		--print("b",nptargetunitGUID)
		targettableGUID[1] = nil
		swapped = false
	end

	if nameplate and nameplate.Health then
			--print(UnitIsUnit(nameplate.unit, "target"), nameplate.unit)
		if not UnitAffectingCombat(nameplate.unit) then
			if targettableGUID[1] ~= nil and UnitIsUnit(nptargetunit, "target") then
				--print("1")
				nameplate.Health:SetHeight(E.db.ElvUI_EltreumUI.nameplateOptions.incombatHeight)
			elseif targettableGUID[1] == nil then
				--print("4")
				nameplate.Health:SetHeight(E.db.ElvUI_EltreumUI.nameplateOptions.outofcombatHeight)
			else
				--print("2")
				nameplate.Health:SetHeight(E.db.ElvUI_EltreumUI.nameplateOptions.outofcombatHeight)
			end
		elseif UnitAffectingCombat(nameplate.unit) then
			--print("3")
			nameplate.Health:SetHeight(E.db.ElvUI_EltreumUI.nameplateOptions.incombatHeight)
		end
	end
end]]

--[[
local targetunit
function ElvUI_EltreumUI:CustomHealthHeight(unit)
	if E.db.ElvUI_EltreumUI.nameplateOptions.enableHealthHeight then
		if unit and unit.unit and UnitExists(unit.unit) and unit.Health then
			targetunit = unit
			if not UnitAffectingCombat(unit.unit) and not UnitIsUnit(unit.unit, "target") then
				unit.Health:SetHeight(E.db.ElvUI_EltreumUI.nameplateOptions.outofcombatHeight)
			elseif UnitAffectingCombat(unit.unit) or UnitIsUnit(unit.unit, "target") then
				unit.Health:SetHeight(E.db.ElvUI_EltreumUI.nameplateOptions.incombatHeight)
			end
		end
	end
end

hooksecurefunc(NP, "Health_UpdateColor", ElvUI_EltreumUI.CustomHealthHeight)
hooksecurefunc(NP, "SetupTarget", ElvUI_EltreumUI.CustomHealthHeight)
hooksecurefunc(NP, "StyleFilterSetVariables", ElvUI_EltreumUI.CustomHealthHeight)

]]

local nptarget, nptargetunit
function ElvUI_EltreumUI:CustomHealthHeight(unit)
	if E.db.ElvUI_EltreumUI.nameplateOptions.enableHealthHeight then
		if unit then
			if not UnitAffectingCombat(unit.unit) then
				nptarget = C_NamePlate.GetNamePlateForUnit("target")
				if nptarget then
					nptargetunit = nptarget.UnitFrame.BuffFrame.unit
				end
				if nptargetunit and UnitIsUnit(unit.unit, nptargetunit) then
					unit.Health:SetHeight(E.db.ElvUI_EltreumUI.nameplateOptions.incombatHeight)
				else
					unit.Health:SetHeight(E.db.ElvUI_EltreumUI.nameplateOptions.outofcombatHeight)
				end
			elseif UnitAffectingCombat(unit.unit) then
				unit.Health:SetHeight(E.db.ElvUI_EltreumUI.nameplateOptions.incombatHeight)
			end
		end
	end
end

--hooksecurefunc(NP, "Health_UpdateColor", ElvUI_EltreumUI.CustomHealthHeight)
--hooksecurefunc(NP, "SetupTarget", ElvUI_EltreumUI.CustomHealthHeight)
hooksecurefunc(NP, "StyleFilterConditionCheck", ElvUI_EltreumUI.CustomHealthHeight)
--hooksecurefunc(NP, "StyleFilterSetVariables", ElvUI_EltreumUI.CustomHealthHeight)
hooksecurefunc(NP, "StyleFilterClearVariables", ElvUI_EltreumUI.CustomHealthHeight)
--hooksecurefunc(NP, "StylePlate", ElvUI_EltreumUI.CustomHealthHeight)

--fix stylefilter for gradient nameplates
function NP:StyleFilterClearChanges(frame, HealthColor, PowerColor, Borders, HealthFlash, HealthTexture, Scale, Alpha, NameTag, PowerTag, HealthTag, TitleTag, LevelTag, Portrait, NameOnly, Visibility)
	db = NP:PlateDB(frame)

	if frame.StyleFilterChanges then
		wipe(frame.StyleFilterChanges)
	end

	if Visibility then
		NP:StyleFilterBaseUpdate(frame, true)
		frame:ClearAllPoints() -- pull the frame back in
		frame:Point('CENTER')
	end
	if HealthColor then
		h = frame.Health
		if h.r and h.g and h.b then
			h:SetStatusBarColor(h.r, h.g, h.b)
			if E.db.ElvUI_EltreumUI.gradientmode.npenable then
				GradientNameplates(frame)
			end
			frame.Cutaway.Health:SetVertexColor(h.r * 1.5, h.g * 1.5, h.b * 1.5, 1)
		end
	end
	if PowerColor then
		pc = NP.db.colors.power[frame.Power.token] or _G.PowerBarColor[frame.Power.token] or {r=1, b=1, g=1}
		frame.Power:SetStatusBarColor(pc.r, pc.g, pc.b)
		frame.Cutaway.Power:SetVertexColor(pc.r * 1.5, pc.g * 1.5, pc.b * 1.5, 1)
	end
	if Borders then
		NP:StyleFilterBorderLock(frame.Health.backdrop)

		if frame.Power.backdrop and db.power.enable then
			NP:StyleFilterBorderLock(frame.Power.backdrop)
		end
	end
	if HealthFlash then
		E:StopFlash(frame.HealthFlashTexture)
		frame.HealthFlashTexture:Hide()
	end
	if HealthTexture then
		tx = E.LSM:Fetch('statusbar', NP.db.statusbar)
		frame.Health:SetStatusBarTexture(tx)
	end
	if Scale then
		NP:ScalePlate(frame, frame.ThreatScale or 1)
	end
	if Alpha then
		NP:PlateFade(frame, NP.db.fadeIn and 1 or 0, (frame.FadeObject and frame.FadeObject.endAlpha) or 0.5, 1)
	end
	if Portrait then
		NP:Update_Portrait(frame)
		frame.Portrait:ForceUpdate()
	end
	if NameOnly then
		NP:StyleFilterBaseUpdate(frame)
	else -- Only update these if it wasn't NameOnly. Otherwise, it leads to `Update_Tags` which does the job.
		if NameTag then frame:Tag(frame.Name, db.name.format) frame.Name:UpdateTag() end
		if PowerTag then frame:Tag(frame.Power.Text, db.power.text.format) frame.Power.Text:UpdateTag() end
		if HealthTag then frame:Tag(frame.Health.Text, db.health.text.format) frame.Health.Text:UpdateTag() end
		if TitleTag then frame:Tag(frame.Title, db.title.format) frame.Title:UpdateTag() end
		if LevelTag then frame:Tag(frame.Level, db.level.format) frame.Level:UpdateTag() end
	end
end
