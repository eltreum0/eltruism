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
		if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable then
			if not InCombatLockdown() or UnitIsDead("player") then
				nameplate.CurrentlyBeingTanked = nil
			end
			if sf.HealthColor then
				return
			else
				if E.db.ElvUI_EltreumUI.dev then
					ElvUI_EltreumUI:Print(nameplate.CurrentlyBeingTanked,self.isTank,self.offTank,status)
				end
				if status == 3 then -- securely tanking
					--Color = self.offTank and colors.offTankColor or self.isTank and colors.goodColor or colors.badColor
					if self.isTank then
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
							nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("GOODTHREAT", false, false))
						else
							nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("GOODTHREAT", false, false))
						end
						nameplate.CurrentlyBeingTanked = UnitGUID(nameplate.unit)
					elseif self.offTank then
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
							nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("OFFTANK", false, false))
						else
							nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("OFFTANK", false, false))
						end
						nameplate.CurrentlyBeingTanked = UnitGUID(nameplate.unit)
					elseif (not self.isTank or not self.offTank) then
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
							nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("BADTHREAT", false, false))
						else
							nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("BADTHREAT", false, false))
						end
						nameplate.CurrentlyBeingTanked = UnitGUID(nameplate.unit)
					end
					Scale = self.isTank and db.goodScale or db.badScale
				elseif status == 2 then -- insecurely tanking
					--Color = self.offTank and colors.offTankColorBadTransition or self.isTank and colors.badTransition or colors.goodTransition
					if self.isTank then
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
							nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("BADTHREATTRANSITION", false, false))
						else
							nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("BADTHREATTRANSITION", false, false))
						end
						nameplate.CurrentlyBeingTanked = UnitGUID(nameplate.unit)
					elseif self.offTank then
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
							nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("OFFTANKBADTHREATTRANSITION", false, false))
						else
							nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("OFFTANKBADTHREATTRANSITION", false, false))
						end
						nameplate.CurrentlyBeingTanked = UnitGUID(nameplate.unit)
					elseif (not self.isTank or not self.offTank) then
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
							nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("GOODTHREATTRANSITION", false, false))
						else
							nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("GOODTHREATTRANSITION", false, false))
						end
						nameplate.CurrentlyBeingTanked = UnitGUID(nameplate.unit)
					end
					Scale = 1
				elseif status == 1 then -- not tanking but threat higher than tank
					--Color = self.offTank and colors.offTankColorGoodTransition or self.isTank and colors.goodTransition or colors.badTransition
					if self.isTank then
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
							nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("GOODTHREATTRANSITION", false, false))
						else
							nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("GOODTHREATTRANSITION", false, false))
						end
						nameplate.CurrentlyBeingTanked = UnitGUID(nameplate.unit)
					elseif self.offTank then
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
							nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("OFFTANKGOODTHREATTRANSITION", false, false))
						else
							nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("OFFTANKGOODTHREATTRANSITION", false, false))
						end
						nameplate.CurrentlyBeingTanked = UnitGUID(nameplate.unit)
					elseif (not self.isTank or not self.offTank) then
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
							nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("BADTHREATTRANSITION", false, false))
						else
							nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("BADTHREATTRANSITION", false, false))
						end
						nameplate.CurrentlyBeingTanked = UnitGUID(nameplate.unit)
					end
					Scale = 1
				else -- not tanking at all
					--Color = self.isTank and colors.badColor or colors.goodColor
					if self.isTank then
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
							nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("BADTHREAT", false, false))
						else
							nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("BADTHREAT", false, false))
						end
						nameplate.CurrentlyBeingTanked = UnitGUID(nameplate.unit)
					elseif self.offTank then
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
							nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("GOODTHREAT", false, false))
						else
							nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("GOODTHREAT", false, false))
						end
						nameplate.CurrentlyBeingTanked = UnitGUID(nameplate.unit)
					elseif (not self.isTank or not self.offTank) then
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
							nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("GOODTHREAT", false, false))
						else
							nameplate.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("GOODTHREAT", false, false))
						end
					end
					Scale = self.isTank and db.badScale or db.goodScale
				end
				if Scale then
					nameplate.ThreatScale = Scale

					if not sf.Scale then
						NP:ScalePlate(nameplate, Scale)
					end
				end
			end
		elseif not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable then -- use regular elvui mode
			if status == 3 then -- securely tanking
				Color = self.offTank and colors.offTankColor or self.isTank and colors.goodColor or colors.badColor
				Scale = self.isTank and db.goodScale or db.badScale
				nameplate.CurrentlyBeingTanked = UnitGUID(nameplate.unit)
			elseif status == 2 then -- insecurely tanking
				Color = self.offTank and colors.offTankColorBadTransition or self.isTank and colors.badTransition or colors.goodTransition
				Scale = 1
				nameplate.CurrentlyBeingTanked = UnitGUID(nameplate.unit)
			elseif status == 1 then -- not tanking but threat higher than tank
				Color = self.offTank and colors.offTankColorGoodTransition or self.isTank and colors.goodTransition or colors.badTransition
				Scale = 1
				nameplate.CurrentlyBeingTanked = UnitGUID(nameplate.unit)
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
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable then
		if unit and unit.Health then
			_, className = UnitClass(unit.unit)
			player = UnitIsPlayer(unit.unit)
			reaction = UnitReaction(unit.unit, "player")

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
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepower and E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
		bar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, r - 0.3, g - 0.3, b - 0.3, r, g, b)
	end
end
hooksecurefunc(NP, "ClassPower_SetBarColor", ElvUI_EltreumUI.NPClassPower_SetBarColor)

--np custom health height conditions
local heighttable = {
	["FRIENDLY_NPC"] = 30,
	["ENEMY_NPC"] = 30,
	["ENEMY_PLAYER"] = 30,
	["FRIENDLY_PLAYER"] = 30,
	["PLAYER"] = 30,
}
local tableupdate = CreateFrame("FRAME")
tableupdate:RegisterEvent("PLAYER_ENTERING_WORLD")
tableupdate:RegisterEvent("PLAYER_STARTED_MOVING")
tableupdate:SetScript("OnEvent",function()
	tableupdate:UnregisterAllEvents()
	heighttable = {
		["FRIENDLY_NPC"] = E.db.nameplates.units.FRIENDLY_NPC.health.height or P.nameplates.units.FRIENDLY_NPC.health.height,
		["ENEMY_NPC"] = E.db.nameplates.units.ENEMY_NPC.health.height or P.nameplates.units.ENEMY_NPC.health.height,
		["ENEMY_PLAYER"] = E.db.nameplates.units.ENEMY_PLAYER.health.height or P.nameplates.units.ENEMY_PLAYER.health.height,
		["FRIENDLY_PLAYER"] = E.db.nameplates.units.FRIENDLY_PLAYER.health.height or P.nameplates.units.FRIENDLY_NPC.health.height,
		["PLAYER"] = E.db.nameplates.units.PLAYER.health.height or P.nameplates.units.PLAYER.health.height,
	}
end)
function ElvUI_EltreumUI:NameplateCustomOptions(unit)
	if (E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.enableHealthHeight) and unit and unit.unit and unit.unit:match("nameplate") then

		--check if its not explosive
		if (unit.unitGUID and unit.unitGUID:match("-120651-")) or UnitIsUnit(unit.unit,"player") then
			return
		end

		if (not UnitAffectingCombat(unit.unit)) and (UnitThreatSituation("player", unit.unit) == nil) then
			if UnitIsUnit(unit.unit, "target") then
				if E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.useelvuinpheight then
					unit.Health:SetHeight(heighttable[unit.frameType])
				else
					unit.Health:SetHeight(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.incombatHeight)
				end
			else
				unit.Health:SetHeight(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.outofcombatHeight)
			end
		elseif UnitAffectingCombat(unit.unit) or (UnitThreatSituation("player", unit.unit) ~= nil) then
			if E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.useelvuinpheight then
				unit.Health:SetHeight(heighttable[unit.frameType])
			else
				unit.Health:SetHeight(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.incombatHeight)
			end
		end
	end
end
hooksecurefunc(NP, "StyleFilterUpdate", ElvUI_EltreumUI.NameplateCustomOptions)

--Adds a model of the Target to the Target nameplate
local target3d = CreateFrame('PlayerModel', "EltruismNameplateModel")
--function to set model settings
local function SetNameplateModelSettings(nameplate)
	target3d:ClearModel()
	target3d:SetUnit(nameplate.unit)
	target3d:SetDesaturation(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.desaturation)
	target3d:SetPaused(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.paused)
	target3d:SetPortraitZoom(1) --allows the same cam as elvui UF
	target3d:SetCamDistanceScale(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.CamDistanceScale)
	target3d:SetViewTranslation(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.ViewTranslationx*100,E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.ViewTranslationy*100)
	target3d:SetRotation(rad(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.Rotation))
	target3d:SetAlpha(0)
	target3d:SetParent(nameplate.Health)
	target3d:SetFrameLevel(nameplate.Health:GetFrameLevel())
	target3d:SetSize(E.db.nameplates.plateSize.enemyWidth or P.nameplates.plateSize.enemyWidth, E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.incombatHeight)
	target3d:ClearAllPoints()
	target3d:SetPoint("CENTER", nameplate.Health, "CENTER")
	target3d:SetInside(nameplate.Health, 0, 0) --(obj, anchor, xOffset, yOffset, anchor2, noScale)
	target3d:SetAlpha(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.modelalpha)
	--target3d:SetAnimation(3) --stand still
	--target3d:FreezeAnimation(60, 0, 55) -- Freeze the talking animation at the frame 55
	--target3d:SetFacing(-(math.pi/2)) --better than rotation?
	--adds fog
	--target3d:SetFogColor(r,g,b)
	--target3d:SetFogNear(0)
	--target3d:SetFogFar(10)
	--or light (dont use with fog)
	--target3d:SetLight(enabled, omni, dirX,dirY,dirZ, ambIntensity,ambR,ambG,ambB, dirIntensity,dirR,dirG,dirB)
end

function ElvUI_EltreumUI:NameplateModel(nameplate)
	if E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.targetmodel then

		if UnitExists("target") then
			if nameplate and nameplate.unit then
				ElvUI_EltreumUI:NameplateCustomOptions(nameplate) --testing sending unit to other function
				if nameplate.Health and nameplate.Health:IsVisible() then

					--original, but can have wrong camera
					SetNameplateModelSettings(nameplate)

					--first delay, for selecting a target and fixing camera
					E:Delay(0.098, function()
						if UnitExists("target") then
							SetNameplateModelSettings(nameplate)
							target3d:SetAlpha(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.modelalpha)
						end
					end)

					--second delay, for when swapping targets too fast can cause it to incorrectly set the previous target
					E:Delay(0.150, function()
						if UnitExists("target") then
							SetNameplateModelSettings(nameplate)
							target3d:SetAlpha(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.modelalpha)
						end
					end)

				else
					target3d:ClearAllPoints()
					target3d:SetAlpha(0)
				end
			end
		else
			target3d:ClearAllPoints()
			target3d:SetAlpha(0)
		end
	end
end
hooksecurefunc(NP, "SetupTarget", ElvUI_EltreumUI.NameplateModel)

local FallbackColor = {r=1, b=1, g=1}

--to fix stylefilter for gradient nameplates
function NP:StyleFilterClearChanges(frame, HealthColor, PowerColor, Borders, HealthFlash, HealthTexture, Scale, Alpha, NameTag, PowerTag, HealthTag, TitleTag, LevelTag, Portrait, NameOnly, Visibility)
	db = NP:PlateDB(frame)

	local c = frame.StyleFilterChanges
	if c then wipe(c) end

	if not NameOnly then -- Only update these if it wasn't NameOnly. Otherwise, it leads to `Update_Tags` which does the job.
		if NameTag then frame:Tag(frame.Name, db.name.format) frame.Name:UpdateTag() end
		if PowerTag then frame:Tag(frame.Power.Text, db.power.text.format) frame.Power.Text:UpdateTag() end
		if HealthTag then frame:Tag(frame.Health.Text, db.health.text.format) frame.Health.Text:UpdateTag() end
		if TitleTag then frame:Tag(frame.Title, db.title.format) frame.Title:UpdateTag() end
		if LevelTag then frame:Tag(frame.Level, db.level.format) frame.Level:UpdateTag() end
	end

	-- generic stuff
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

	-- bar stuff
	if HealthColor then
		local h = frame.Health
		if h.r and h.g and h.b then
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable then
				GradientNameplates(frame)
			else
				h:SetStatusBarColor(h.r, h.g, h.b)
			end
			frame.Cutaway.Health:SetVertexColor(h.r * 1.5, h.g * 1.5, h.b * 1.5, 1)
		end
	end
	if PowerColor then
		local pc = NP.db.colors.power[frame.Power.token] or _G.PowerBarColor[frame.Power.token] or FallbackColor
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
		local tx = E.LSM:Fetch('statusbar', NP.db.statusbar)
		frame.Health:SetStatusBarTexture(tx)
	end
end

--to set slight gradient to style filter
function NP:StyleFilterSetChanges(frame, actions, HealthColor, PowerColor, Borders, HealthFlash, HealthTexture, Scale, Alpha, NameTag, PowerTag, HealthTag, TitleTag, LevelTag, Portrait, NameOnly, Visibility)
	local c = frame.StyleFilterChanges
	if not c then return end

	local db = NP:PlateDB(frame)

	if Visibility or NameOnly then
		c.NameOnly, c.Visibility = NameOnly, Visibility

		NP:DisablePlate(frame, NameOnly, NameOnly)

		if Visibility then
			frame:ClearAllPoints() -- lets still move the frame out cause its clickable otherwise
			frame:Point('TOP', E.UIParent, 'BOTTOM', 0, -500)
			return -- We hide it. Lets not do other things (no point)
		end
	end

	-- Keeps Tag changes after NameOnly
	if NameTag then
		c.NameTag = true
		frame:Tag(frame.Name, actions.tags.name)
		frame.Name:UpdateTag()
	end
	if PowerTag then
		c.PowerTag = true
		frame:Tag(frame.Power.Text, actions.tags.power)
		frame.Power.Text:UpdateTag()
	end
	if HealthTag then
		c.HealthTag = true
		frame:Tag(frame.Health.Text, actions.tags.health)
		frame.Health.Text:UpdateTag()
	end
	if TitleTag then
		c.TitleTag = true
		frame:Tag(frame.Title, actions.tags.title)
		frame.Title:UpdateTag()
	end
	if LevelTag then
		c.LevelTag = true
		frame:Tag(frame.Level, actions.tags.level)
		frame.Level:UpdateTag()
	end

	-- generic stuff
	if Scale then
		c.Scale = true
		NP:ScalePlate(frame, actions.scale)
	end
	if Alpha then
		c.Alpha = true
		NP:PlateFade(frame, NP.db.fadeIn and 1 or 0, frame:GetAlpha(), actions.alpha * 0.01)
	end
	if Portrait then
		c.Portrait = true
		NP:Update_Portrait(frame)
		frame.Portrait:ForceUpdate()
	end

	if NameOnly then
		return -- skip the other stuff now
	end

	-- bar stuff
	if HealthColor then
		local hc = (actions.color.healthClass and frame.classColor) or actions.color.healthColor
		c.HealthColor = hc -- used by Health_UpdateColor

		if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable then
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
				frame.Health:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation,hc.r, hc.g, hc.b, hc.a or 1, hc.r + E.db.ElvUI_EltreumUI.unitframes.gradientmode.stylefilterr, hc.g + E.db.ElvUI_EltreumUI.unitframes.gradientmode.stylefilterg, hc.b + E.db.ElvUI_EltreumUI.unitframes.gradientmode.stylefilterb, hc.a or 1)
			else
				frame.Health:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation,hc.r, hc.g, hc.b, hc.a or 1, hc.r-0.4, hc.g-0.4, hc.b-0.4, hc.a or 1)
			end
		else
			frame.Health:SetStatusBarColor(hc.r, hc.g, hc.b, hc.a or 1)
		end

		frame.Cutaway.Health:SetVertexColor(hc.r * 1.5, hc.g * 1.5, hc.b * 1.5, hc.a or 1)
	end
	if PowerColor then
		local pc = (actions.color.powerClass and frame.classColor) or actions.color.powerColor
		c.PowerColor = true

		frame.Power:SetStatusBarColor(pc.r, pc.g, pc.b, pc.a or 1)
		frame.Cutaway.Power:SetVertexColor(pc.r * 1.5, pc.g * 1.5, pc.b * 1.5, pc.a or 1)
	end
	if Borders then
		local bc = (actions.color.borderClass and frame.classColor) or actions.color.borderColor
		c.Borders = true

		NP:StyleFilterBorderLock(frame.Health.backdrop, bc.r, bc.g, bc.b, bc.a or 1)

		if frame.Power.backdrop and db.power.enable then
			NP:StyleFilterBorderLock(frame.Power.backdrop, bc.r, bc.g, bc.b, bc.a or 1)
		end
	end
	if HealthFlash then
		local fc = (actions.flash.class and frame.classColor) or actions.flash.color
		c.HealthFlash = true

		if not HealthTexture then
			frame.HealthFlashTexture:SetTexture(E.LSM:Fetch('statusbar', NP.db.statusbar))
		end

		frame.HealthFlashTexture:SetVertexColor(fc.r, fc.g, fc.b)

		local anim = frame.HealthFlashTexture.anim or NP:StyleFilterSetupFlash(frame.HealthFlashTexture)
		anim.fadein:SetToAlpha(fc.a or 1)
		anim.fadeout:SetFromAlpha(fc.a or 1)

		frame.HealthFlashTexture:Show()
		E:Flash(frame.HealthFlashTexture, actions.flash.speed * 0.1, true)
	end
	if HealthTexture then
		local tx = E.LSM:Fetch('statusbar', actions.texture.texture)
		c.HealthTexture = true

		frame.Health:SetStatusBarTexture(tx)

		if HealthFlash then
			frame.HealthFlashTexture:SetTexture(tx)
		end
	end
end

--elvui castbar texture/gradient
function NP:Castbar_CheckInterrupt(unit)
	if unit == 'vehicle' then
		unit = 'player'
	end
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable then
		local _, unitclass = UnitClass(unit)
		local reactiontarget = UnitReaction(unit, "player")
		if self.notInterruptible and UnitCanAttack('player', unit) then
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
				self:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1noninterruptiblecustom)
			else
				self:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1noninterruptible)
			end
			if self.Icon and NP.db.colors.castbarDesaturate then
				self.Icon:SetDesaturated(true)
			end
		else
			if UnitIsPlayer(unit) then
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
					self:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom)
				elseif E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor and E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
					self:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom(unitclass))
				else
					self:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors(unitclass))
				end
			else
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
					self:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom)
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
							self:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptablecustom)
						else
							self:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptable)
						end
					end
				end
			end
			if self.Icon then
				self.Icon:SetDesaturated(false)
			end
		end
	else
		if self.notInterruptible and UnitCanAttack('player', unit) then
			self:SetStatusBarColor(NP.db.colors.castNoInterruptColor.r, NP.db.colors.castNoInterruptColor.g, NP.db.colors.castNoInterruptColor.b)
			if self.Icon and NP.db.colors.castbarDesaturate then
				self.Icon:SetDesaturated(true)
			end
		else
			self:SetStatusBarColor(NP.db.colors.castColor.r, NP.db.colors.castColor.g, NP.db.colors.castColor.b)
			if self.Icon then
				self.Icon:SetDesaturated(false)
			end
		end
	end
end
