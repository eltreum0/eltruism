local E = unpack(ElvUI)
local NP = E:GetModule('NamePlates')
local _G = _G
local UnitAffectingCombat = _G.UnitAffectingCombat
local UnitThreatSituation = _G.UnitThreatSituation
local UnitCastingInfo = _G.UnitCastingInfo
local CreateFrame = _G.CreateFrame
local mathabs = _G.math.abs
local string_match = _G.string.match
local C_NamePlate_GetNamePlateForUnit = _G.C_NamePlate and _G.C_NamePlate.GetNamePlateForUnit
local C_NamePlate_GetNamePlates = _G.C_NamePlate and _G.C_NamePlate.GetNamePlates
local wipe = _G.wipe
local canaccessvalue = _G.canaccessvalue
local previousTargetPlate
local cachedElvUIHeights = {}
local type = _G.type

local function GetFrame(arg)
	if type(arg) == "table" then
		if arg.__unit then
			return arg
		elseif arg.__owner and type(arg.__owner) == "table" and arg.__owner.__unit then
			return arg.__owner
		end
	end
end

--np custom health height
function ElvUI_EltreumUI:UpdateNameplateHealthHeight(frame)
	if not frame or not frame.__unit then
		return
	end
	local health = frame.Health
	if not health or not health:IsShown() then
		return
	end
	if frame == NP.PlayerFrame or frame.frameType == 'PLAYER' then
		return
	end

	local db = E.db and E.db.ElvUI_EltreumUI
	local opts = db and db.nameplates and db.nameplates.nameplateOptions
	if not (opts and opts.enableHealthHeight) then
		return
	end

	local frameunit = frame.__unit
	local isTarget = E:UnitIsUnit(frameunit, "target")
	local isActive = isTarget

	--check if in combat/threat/casting
	if not isActive and not opts.disableCombatConditions then
		local inCombatVal = UnitAffectingCombat(frameunit)
		local unitInCombat = inCombatVal and E:NotSecretValue(inCombatVal) and inCombatVal

		if not unitInCombat and UnitThreatSituation then
			local threat = UnitThreatSituation("player", frameunit)
			local canAccessThreat = threat and canaccessvalue(threat) and E:NotSecretValue(threat)
			if canAccessThreat and threat > 0 then
				unitInCombat = true
			elseif UnitCastingInfo(frameunit) then
				unitInCombat = true
			end
		end

		isActive = unitInCombat
	end

	local targetHeight
	if isActive then
		if opts.useelvuinpheight and frame.frameType then
			if not cachedElvUIHeights[frame.frameType] then
				local plateDB = NP:PlateDB(frame)
				cachedElvUIHeights[frame.frameType] = (plateDB and plateDB.health and plateDB.health.height) or 30
			end
			targetHeight = cachedElvUIHeights[frame.frameType]
		else
			targetHeight = opts.incombatHeight or 14
		end
	else
		targetHeight = opts.outofcombatHeight or 4
	end

	if targetHeight then
		local currentHeight = health:GetHeight()
		local canAccessCurrentHeight = not currentHeight or (canaccessvalue(currentHeight) and E:NotSecretValue(currentHeight))
		if canAccessCurrentHeight then
			if not currentHeight or mathabs(currentHeight - targetHeight) > 0.05 then
				health:SetHeight(targetHeight)
			end
		else
			health:SetHeight(targetHeight)
		end
	end
end

--custom backdrop modifications
function ElvUI_EltreumUI:NameplateCustomBackdrop(unit)
	local health = unit and unit.Health
	if not health or not unit.__unit or not health:IsShown() then
		return
	end

	local db = E.db and E.db.ElvUI_EltreumUI
	local backdropOpt = db and db.nameplates and db.nameplates.backdrop
	if not (backdropOpt and backdropOpt.BDmodifications) then
		return
	end

	local backdrop = health.backdrop
	if not backdrop then
		return
	end

	if backdropOpt.backdroptexture then
		local newTex = E.LSM:Fetch("statusbar", backdropOpt.backdroptexture)
		if unit.EltruismBackdropTexture ~= newTex then
			backdrop.Center:SetTexture(newTex)
			unit.EltruismBackdropTexture = newTex
		end
	end
	if backdropOpt.backdroptexturestaticsize then
		if not unit.EltruismBackdropPointsSet then
			backdrop.Center:SetAllPoints(health)
			unit.EltruismBackdropPointsSet = true
		end
	end
	if backdropOpt.backdrophidden then
		if backdrop.LeftEdge:IsShown() then
			backdrop.LeftEdge:Hide()
			backdrop.BottomLeftCorner:Hide()
			backdrop.TopLeftCorner:Hide()
			backdrop.RightEdge:Hide()
			backdrop.BottomRightCorner:Hide()
			backdrop.TopRightCorner:Hide()
			backdrop.TopEdge:Hide()
			backdrop.BottomEdge:Hide()
		end
	end
end

--update all visible nameplates
function ElvUI_EltreumUI:UpdateAllNameplateHeights()
	wipe(cachedElvUIHeights)
	if not C_NamePlate_GetNamePlates then return end
	local plates = C_NamePlate_GetNamePlates()
	if plates then
		for i = 1, #plates do
			local blizzPlate = plates[i]
			if blizzPlate and blizzPlate.unitFrame then
				ElvUI_EltreumUI:UpdateNameplateHealthHeight(blizzPlate.unitFrame)
			end
		end
	end
end

--target changed, update it
local function OnTargetChanged(opts)
	if not opts then
		local db = E.db and E.db.ElvUI_EltreumUI
		opts = db and db.nameplates and db.nameplates.nameplateOptions
	end
	if not (opts and opts.enableHealthHeight) then
		return
	end

	local targetPlate = C_NamePlate_GetNamePlateForUnit and C_NamePlate_GetNamePlateForUnit("target")
	local targetFrame = targetPlate and targetPlate.unitFrame

	-- Restore previous target plate if it was different and is still visible
	if previousTargetPlate and previousTargetPlate ~= targetFrame and previousTargetPlate.Health and previousTargetPlate:IsShown() then
		ElvUI_EltreumUI:UpdateNameplateHealthHeight(previousTargetPlate)
	end

	-- Apply target height to newly targeted plate
	if targetFrame then
		ElvUI_EltreumUI:UpdateNameplateHealthHeight(targetFrame)
		previousTargetPlate = targetFrame
	else
		previousTargetPlate = nil
	end
end

--handle events connected to nameplates
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
eventFrame:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
eventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
eventFrame:RegisterEvent("UNIT_FLAGS")
eventFrame:RegisterEvent("UNIT_THREAT_LIST_UPDATE")
eventFrame:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE")
eventFrame:SetScript("OnEvent", function(_, event, unit)
	local db = E.db and E.db.ElvUI_EltreumUI
	local opts = db and db.nameplates and db.nameplates.nameplateOptions
	if not (opts and opts.enableHealthHeight) then
		return
	end

	if event == "PLAYER_TARGET_CHANGED" then
		OnTargetChanged(opts)
	elseif event == "NAME_PLATE_UNIT_REMOVED" then
		if previousTargetPlate and previousTargetPlate.__unit == unit then
			previousTargetPlate = nil
		end
	elseif event == "PLAYER_REGEN_DISABLED" or event == "PLAYER_REGEN_ENABLED" then
		if not opts.disableCombatConditions then
			ElvUI_EltreumUI:UpdateAllNameplateHeights()
		end
	elseif event == "UNIT_FLAGS" or event == "UNIT_THREAT_LIST_UPDATE" or event == "UNIT_THREAT_SITUATION_UPDATE" then
		if unit and C_NamePlate_GetNamePlateForUnit and string_match(unit, "^nameplate%d+$") then
			local plate = C_NamePlate_GetNamePlateForUnit(unit)
			if plate and plate.unitFrame and plate.unitFrame.Health and plate.unitFrame.Health:IsShown() then
				ElvUI_EltreumUI:UpdateNameplateHealthHeight(plate.unitFrame)
			end
		end
	end
end)

function ElvUI_EltreumUI:OnUpdatePlateBase(_, nameplate)
	local db = E.db and E.db.ElvUI_EltreumUI
	local opts = db and db.nameplates and db.nameplates.nameplateOptions
	if not (opts and opts.enableHealthHeight) then
		return
	end

	nameplate = GetFrame(nameplate)
	if nameplate and nameplate.__unit and nameplate.Health and nameplate.Health:IsShown() then
		ElvUI_EltreumUI:NameplateCustomBackdrop(nameplate)
		ElvUI_EltreumUI:UpdateNameplateHealthHeight(nameplate)
		if opts.nameplateBorderSize and opts.nameplateBorderSize > 0 then
			ElvUI_EltreumUI:UpdateNameplateBorders(nameplate)
		end
		if E:UnitIsUnit(nameplate.__unit, "target") then
			previousTargetPlate = nameplate
		end
	end
end
ElvUI_EltreumUI:SecureHook(NP, "UpdatePlateBase", "OnUpdatePlateBase") --fires when elvui updates them

function ElvUI_EltreumUI.OnUpdateHealth(nameplate) --if they are changing health they are likely in combat
	local db = E.db and E.db.ElvUI_EltreumUI
	local opts = db and db.nameplates and db.nameplates.nameplateOptions
	if not (opts and opts.enableHealthHeight) then
		return
	end

	local frame = GetFrame(nameplate)
	if frame and frame.__unit and frame.Health and frame.Health:IsShown() then
		ElvUI_EltreumUI:NameplateCustomBackdrop(frame)
		ElvUI_EltreumUI:UpdateNameplateHealthHeight(frame)
		if opts.nameplateBorderSize and opts.nameplateBorderSize > 0 then
			ElvUI_EltreumUI:UpdateNameplateBorders(frame)
		end
		if E:UnitIsUnit(frame.__unit, "target") then
			previousTargetPlate = frame
		end
	end
end

function ElvUI_EltreumUI.OnThreatOrColorUpdate(nameplate) --handle threat changes
	local db = E.db and E.db.ElvUI_EltreumUI
	local opts = db and db.nameplates and db.nameplates.nameplateOptions
	if not (opts and opts.enableHealthHeight) then
		return
	end

	local frame = GetFrame(nameplate)
	if frame and frame.__unit and frame.Health and frame.Health:IsShown() then
		ElvUI_EltreumUI:UpdateNameplateHealthHeight(frame)
	end
end
