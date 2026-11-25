--cursor rings for casts, gcd and combat (originally inspired by CastCursor by michaelsp)
local E = unpack(ElvUI)
local _G = _G

local CreateFrame = _G.CreateFrame
local InCombatLockdown = _G.InCombatLockdown
local GetTime = _G.GetTime
local tonumber = _G.tonumber
local strmatch = _G.string.match
local SetCVar = _G.C_CVar.SetCVar
local UnitCastingInfo = _G.UnitCastingInfo
local UnitChannelInfo = _G.UnitChannelInfo
local UnitCastingDuration = _G.UnitCastingDuration
local UnitChannelDuration = _G.UnitChannelDuration
local UnitEmpoweredChannelDuration = _G.UnitEmpoweredChannelDuration
local GetUnitEmpowerHoldAtMaxTime = _G.GetUnitEmpowerHoldAtMaxTime
local C_Spell = _G.C_Spell
local GetSpellCooldown = C_Spell.GetSpellCooldown
local GetSpellCooldownDuration = C_Spell.GetSpellCooldownDuration
local tostring = _G.tostring

local DEFAULT_RING = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring3.tga'
local GCD_SPELL_ID = 61304

local rootFrame, cursorFrame, cursorTex, gcdFrame, castFrame

local function createSwipeRing(name, level)
	local cd = CreateFrame("Cooldown", name, rootFrame)
	cd:SetPoint("CENTER", rootFrame, "CENTER", 0, 0)
	cd:SetFrameStrata("TOOLTIP")
	cd:SetFrameLevel(level)
	cd:SetDrawSwipe(true)
	cd:SetDrawEdge(false)
	cd:SetDrawBling(false)
	cd:SetHideCountdownNumbers(true)
	cd.noCooldownCount = true
	cd:SetReverse(true)
	cd:SetUseCircularEdge(true)
	cd:Hide()
	return cd
end

local cursordb, castdb, gcddb, combatdb
local castVisible, gcdVisible, combatVisible = false, false, false
local activeCastID
local castR, castG, castB, castA = 1, 1, 1, 1
local gcdR, gcdG, gcdB, gcdA = 1, 1, 1, 1
local useCastGradient = false
local gradR1, gradG1, gradB1 = 1, 1, 1
local gradR2, gradG2, gradB2 = 1, 1, 1
local castGradActive = false
local castGradStart = 0
local castGradInvDur = 0

local function onRootUpdate(self, elapsed)
	ElvUI_EltreumUI:UpdateCursorPosition(self, elapsed)
	if castGradActive then
		local progress = (GetTime() - castGradStart) * castGradInvDur
		if progress >= 1 then
			castFrame:SetSwipeColor(gradR2, gradG2, gradB2, castA)
			castGradActive = false
		elseif progress > 0 then
			castFrame:SetSwipeColor(
				gradR1 + (gradR2 - gradR1) * progress,
				gradG1 + (gradG2 - gradG1) * progress,
				gradB1 + (gradB2 - gradB1) * progress,
				castA
			)
		end
	end
end

local function updateRootVisibility()
	if castVisible or gcdVisible or combatVisible then
		if not rootFrame:IsShown() then
			rootFrame:Show()
			ElvUI_EltreumUI:UpdateCursorPosition(rootFrame, 0, true)
			rootFrame:SetScript("OnUpdate", onRootUpdate)
		end
	else
		if rootFrame:IsShown() then
			rootFrame:SetScript("OnUpdate", nil)
			rootFrame:Hide()
		end
	end
end

local function setCastVisible(visible)
	castVisible = visible
	if visible then
		castFrame:Show()
	else
		castGradActive = false
		castFrame:Clear()
		castFrame:Hide()
	end
	updateRootVisibility()
end

local function setGCDVisible(visible)
	gcdVisible = visible
	if visible then
		gcdFrame:Show()
	else
		gcdFrame:Clear()
		gcdFrame:Hide()
	end
	updateRootVisibility()
end

local function setCombatVisible(visible)
	combatVisible = visible
	if visible then
		cursorFrame:Show()
	else
		cursorFrame:Hide()
	end
	updateRootVisibility()
end

local function startCastSwipe(startSec, durationSec, durationObj)
	if useCastGradient then
		castFrame:SetSwipeColor(gradR1, gradG1, gradB1, castA)
	else
		castFrame:SetSwipeColor(castR, castG, castB, castA)
	end

	if startSec and durationSec and durationSec > 0 then
		castFrame:SetCooldown(startSec, durationSec)
		if useCastGradient then
			castGradStart = startSec
			castGradInvDur = 1 / durationSec
			castGradActive = true
		else
			castGradActive = false
		end
		setCastVisible(true)
	elseif durationObj then
		castGradActive = false
		castFrame:SetCooldownFromDurationObject(durationObj)
		setCastVisible(true)
	else
		setCastVisible(false)
	end
end

local function handleCastStart()
	local name, _, _, startMS, endMS, _, castID = UnitCastingInfo("player")
	if not name then
		activeCastID = nil
		setCastVisible(false)
		return
	end
	activeCastID = (castID and E:NotSecretValue(castID)) and castID or nil
	if startMS and endMS and E:NotSecretValue(startMS) and E:NotSecretValue(endMS) then
		startCastSwipe(startMS * 0.001, (endMS - startMS) * 0.001, nil)
	else
		local durationObj = UnitCastingDuration("player")
		startCastSwipe(nil, nil, durationObj)
	end
end

local function handleChannelStart(isEmpower)
	local name, _, _, startMS, endMS, _, _, _, _, numEmpowerStages = UnitChannelInfo("player")
	if not name then
		activeCastID = nil
		setCastVisible(false)
		return
	end
	activeCastID = nil
	if startMS and endMS and E:NotSecretValue(startMS) and E:NotSecretValue(endMS) then
		if E.Modern and numEmpowerStages and E:NotSecretValue(numEmpowerStages) and numEmpowerStages > 0 then
			local holdMS = GetUnitEmpowerHoldAtMaxTime("player")
			if holdMS and E:NotSecretValue(holdMS) then
				endMS = endMS + holdMS
			end
		end
		startCastSwipe(startMS * 0.001, (endMS - startMS) * 0.001, nil)
	else
		local durationObj
		if isEmpower then
			durationObj = UnitEmpoweredChannelDuration("player", true)
		end
		if not durationObj then
			durationObj = UnitChannelDuration("player")
		end
		startCastSwipe(nil, nil, durationObj)
	end
end

local function handleCastStop(event, castID)
	if event == "UNIT_SPELLCAST_FAILED" then
		if castID and activeCastID and E:NotSecretValue(castID) and castID ~= activeCastID then
			return
		end
		if UnitCastingInfo("player") or UnitChannelInfo("player") then
			return
		end
	elseif event == "UNIT_SPELLCAST_STOP" or event == "UNIT_SPELLCAST_INTERRUPTED" then
		if castID and activeCastID and E:NotSecretValue(castID) and castID ~= activeCastID then
			return
		end
	end
	activeCastID = nil
	setCastVisible(false)
end

local function OnCastCooldownDone()
	activeCastID = nil
	setCastVisible(false)
end

local function OnGCDCooldownDone()
	setGCDVisible(false)
end

local function OnCastFrameEvent(_, event, unit, castID)
	if unit and unit ~= "player" then return end
	if event == "UNIT_SPELLCAST_START" or event == "UNIT_SPELLCAST_DELAYED" then
		handleCastStart()
	elseif event == "UNIT_SPELLCAST_CHANNEL_START" or event == "UNIT_SPELLCAST_CHANNEL_UPDATE" then
		handleChannelStart(false)
	elseif event == "UNIT_SPELLCAST_EMPOWER_START" or event == "UNIT_SPELLCAST_EMPOWER_UPDATE" then
		handleChannelStart(true)
	else
		handleCastStop(event, castID)
	end
end

local function queryAndShowGCD(spellID)
	local queryID = (E.Modern or E.Mists or E.Wrath or E.TBC) and GCD_SPELL_ID or ((spellID and E:NotSecretValue(spellID)) and spellID or GCD_SPELL_ID)
	local info = GetSpellCooldown(queryID)
	if info then
		if info.startTime and info.duration and E:NotSecretValue(info.startTime) and E:NotSecretValue(info.duration) then
			if info.startTime > 0 and info.duration > 0 and (E.Modern or info.duration <= 1.51) then
				gcdFrame:SetSwipeColor(gcdR, gcdG, gcdB, gcdA)
				gcdFrame:SetCooldown(info.startTime, info.duration)
				setGCDVisible(true)
			end
			return
		end
		--secret gcd values on E.Modern (Midnight)
		if E:NotSecretValue(info.isActive) and info.isActive then
			local durationObj = GetSpellCooldownDuration(GCD_SPELL_ID)
			if durationObj then
				gcdFrame:SetSwipeColor(gcdR, gcdG, gcdB, gcdA)
				gcdFrame:SetCooldownFromDurationObject(durationObj)
				setGCDVisible(true)
			end
		end
	end
end

local function OnGCDFrameEvent(_, event, unit, _, spellID)
	if unit and unit ~= "player" then return end
	if event == "UNIT_SPELLCAST_START" or event == "UNIT_SPELLCAST_SUCCEEDED" then
		queryAndShowGCD(spellID)
	elseif gcdVisible then
		local info = GetSpellCooldown(GCD_SPELL_ID)
		if info and info.duration and E:NotSecretValue(info.duration) and info.duration == 0 then
			setGCDVisible(false)
		end
	end
end

local function OnCursorFrameEvent(_, event)
	setCombatVisible(event == "PLAYER_REGEN_DISABLED")
end

local function CreateCursorFrames()
	rootFrame = CreateFrame("Frame", "EltruismCursorRoot", E.UIParent)
	rootFrame:SetSize(8, 8)
	rootFrame:Hide()

	cursorFrame = CreateFrame("Frame", "EltruismCursorCursor", rootFrame)
	cursorFrame:SetPoint("CENTER", rootFrame, "CENTER", 0, 0)
	cursorFrame:SetFrameStrata("TOOLTIP")
	cursorFrame:SetFrameLevel(1)
	cursorTex = cursorFrame:CreateTexture(nil, "OVERLAY")
	cursorTex:SetAllPoints(cursorFrame)
	cursorFrame:Hide()

	gcdFrame = createSwipeRing("EltruismCursorGCD", 2)
	castFrame = createSwipeRing("EltruismCursorCast", 3)

	castFrame:SetScript("OnCooldownDone", OnCastCooldownDone)
	gcdFrame:SetScript("OnCooldownDone", OnGCDCooldownDone)
	castFrame:SetScript("OnEvent", OnCastFrameEvent)
	gcdFrame:SetScript("OnEvent", OnGCDFrameEvent)
	cursorFrame:SetScript("OnEvent", OnCursorFrameEvent)
end

function ElvUI_EltreumUI:CursorInit()
	if E.db.ElvUI_EltreumUI.cursors.cursor.enable then
		ElvUI_EltreumUI:CastCursor()
		if E.db.ElvUI_EltreumUI.cursors.cursor.cooldown then
			ElvUI_EltreumUI:CooldownEnable() --starts cursor module with cooldowns
		end
	end
end

--detect the current cursor for options
function ElvUI_EltreumUI:CurrentTypeofCursor()
	local currentring = E.db.ElvUI_EltreumUI.cursors.cursor.ring
	if currentring then
		local ringNum = strmatch(currentring, "[Rr]ing(%d+)")
		if ringNum then
			return '|cff82B4ffType ' .. ringNum .. '|r'
		end
	end
	return currentring or ""
end

--change cursor size based on user input
function ElvUI_EltreumUI:CursorSize(value)
	local num = tonumber(value)
	if num and num >= -1 and num <= 4 then
		SetCVar("cursorSizePreferred", num)
		E.db.ElvUI_EltreumUI.cursors.cursor.size = tostring(num)
	end
end

local function resolveColor(db, defaultAlpha)
	if db.classcolor then
		return E.myClassColor.r, E.myClassColor.g, E.myClassColor.b, db.a or defaultAlpha
	end
	return db.r, db.g, db.b, db.a or defaultAlpha
end

--setup and update cursor rings
function ElvUI_EltreumUI:CastCursor()
	local cursors = E.db.ElvUI_EltreumUI.cursors
	cursordb = cursors.cursor
	castdb = cursors.cursorcast
	gcddb = cursors.cursorgcd
	combatdb = cursors.cursorcursor

	if not cursordb.enable then
		if not rootFrame then return end
		castFrame:UnregisterAllEvents()
		gcdFrame:UnregisterAllEvents()
		cursorFrame:UnregisterAllEvents()
		activeCastID = nil
		setCastVisible(false)
		setGCDVisible(false)
		setCombatVisible(false)
		return
	end

	if not rootFrame then CreateCursorFrames() end

	if cursordb.fixlag == 0 or cursordb.fixlag == "0" then
		SetCVar("HardwareCursor", 0)
	end

	castR, castG, castB, castA = resolveColor(castdb, 1)
	useCastGradient = (castdb.classcolor and castdb.gradient) and true or false
	if useCastGradient then
		local uf = E.db.ElvUI_EltreumUI.unitframes
		local ufgrad = uf and uf.gradientmode
		local useCustomGrad = ufgrad and (ufgrad.customcolor or ufgrad.npcustomcolor)
		local minColor, maxColor
		if useCustomGrad then
			minColor, maxColor = ElvUI_EltreumUI:GradientColorsCustom(E.myclass, false, false)
		else
			minColor, maxColor = ElvUI_EltreumUI:GradientColors(E.myclass, false, false)
		end
		if minColor and maxColor and minColor.GetRGB and maxColor.GetRGB then
			gradR1, gradG1, gradB1 = minColor:GetRGB()
			gradR2, gradG2, gradB2 = maxColor:GetRGB()
		else
			gradR1, gradG1, gradB1 = castR, castG, castB
			gradR2, gradG2, gradB2 = castR, castG, castB
		end
	end

	gcdR, gcdG, gcdB, gcdA = resolveColor(gcddb, 1)
	local combatR, combatG, combatB, combatA = resolveColor(combatdb, 1)

	local ringTexture = cursordb.ring or DEFAULT_RING
	castFrame:SetSize(castdb.radius * 2, castdb.radius * 2)
	castFrame:SetSwipeTexture(ringTexture)
	castFrame:SetSwipeColor(useCastGradient and gradR1 or castR, useCastGradient and gradG1 or castG, useCastGradient and gradB1 or castB, castA)

	gcdFrame:SetSize(gcddb.radius * 2, gcddb.radius * 2)
	gcdFrame:SetSwipeTexture(ringTexture)
	gcdFrame:SetSwipeColor(gcdR, gcdG, gcdB, gcdA)

	cursorFrame:SetSize(combatdb.radius * 2, combatdb.radius * 2)
	cursorTex:SetTexture(ringTexture)
	cursorTex:SetVertexColor(combatR, combatG, combatB, combatA)

	castFrame:UnregisterAllEvents()
	castFrame:RegisterUnitEvent("UNIT_SPELLCAST_START", "player")
	castFrame:RegisterUnitEvent("UNIT_SPELLCAST_DELAYED", "player")
	castFrame:RegisterUnitEvent("UNIT_SPELLCAST_STOP", "player")
	castFrame:RegisterUnitEvent("UNIT_SPELLCAST_FAILED", "player")
	castFrame:RegisterUnitEvent("UNIT_SPELLCAST_INTERRUPTED", "player")
	castFrame:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_START", "player")
	castFrame:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_UPDATE", "player")
	castFrame:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_STOP", "player")
	if E.Modern then
		castFrame:RegisterUnitEvent("UNIT_SPELLCAST_EMPOWER_START", "player")
		castFrame:RegisterUnitEvent("UNIT_SPELLCAST_EMPOWER_UPDATE", "player")
		castFrame:RegisterUnitEvent("UNIT_SPELLCAST_EMPOWER_STOP", "player")
	end

	gcdFrame:UnregisterAllEvents()
	gcdFrame:RegisterUnitEvent("UNIT_SPELLCAST_START", "player")
	gcdFrame:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player")
	gcdFrame:RegisterUnitEvent("UNIT_SPELLCAST_STOP", "player")
	gcdFrame:RegisterUnitEvent("UNIT_SPELLCAST_INTERRUPTED", "player")

	cursorFrame:UnregisterAllEvents()
	if cursordb.combat then
		cursorFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
		cursorFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
		setCombatVisible(InCombatLockdown())
	else
		setCombatVisible(true)
	end
end
