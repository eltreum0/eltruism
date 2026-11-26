--CursorCooldown was originally inspired by CooldownToGo by mitchnull (Public Domain), rewritten for Eltruism. Thanks to mitchnull for the original idea!
local E = unpack(ElvUI)
local _G = _G
local CreateFrame = _G.CreateFrame
local GetTime = _G.GetTime
local math = _G.math
local mathfloor = math.floor
local GetActionInfo = _G.GetActionInfo
local GetPetActionInfo = _G.GetPetActionInfo
local GetSpellCharges = _G.C_Spell.GetSpellCharges
local GetInventoryItemLink = _G.GetInventoryItemLink
local C_Container = _G.C_Container
local GetContainerItemLink = C_Container.GetContainerItemLink
local C_Item = _G.C_Item
local GetMacroSpell = _G.GetMacroSpell
local GetMacroItem = _G.GetMacroItem
local PlaySoundFile = _G.PlaySoundFile
local GetPhysicalScreenSize = _G.GetPhysicalScreenSize
local Enum = _G.Enum
local wipe = _G.wipe

--onupdate things
local NormalUpdateDelay = 1 --1.0/10 -- update while hidden
local FadingUpdateDelay = 0.1 --1.0/25 -- update while shown
local lastUpdate = 0 -- time since last real update
local lastSecretCheck = 0 --throttle fallback secret polling to 1s
--function variables
local fadeStamp -- the timestamp when we should start fading the display
local endStamp -- the timestamp when the cooldown will be over
local finishStamp -- the timestamp when the we are finished with this cooldown
local currType, currID, currSlot, currPetSpellID, currStart, currDuration, currDurationObj
local lastTexture, lastType, lastID, lastSlot, lastPetSpellID
local cd, now
local needUpdate = false
local isActive = false
local isAlmostReady = false
local isReady = false
local isHidden = false
local isFading = false
local isWaitingAlmostReady = false
local isRedText = false
local isSecretMode = false
local nativeFontString
local cursordb
local spellStartGuess, itemStartGuess, petStartGuess = {}, {}, {}

--gcd things
local GCD = 1.5
if E.myclass == "ROGUE" or E.myclass == "MONK" or E.myclass == "DRUID" then
	GCD = 1
end
--settings
local db = {
	holdTime = 1.0,
	fadeTime = 1.0,
	readyTime = 4.0,
	gracePeriod = 2.2, --time after cd start that pressing a skill will show the cd left
}
local textsize = 15
local cooldownsize = 28

--secret-safe curve so display alpha reacts to remaining duration without reading secret numbers or allocating tables
local almostReadyCurve
if E.Modern then
	almostReadyCurve = E:CreateCurve(Enum.LuaCurveType.Step)
	almostReadyCurve:AddPoint(0, 1)
	almostReadyCurve:AddPoint(db.readyTime, 0)
end

local EltruismCooldownFrame = CreateFrame("MessageFrame", "EltruismCooldown", E.UIParent)
--inner display frame isolates curve-driven secret alpha from EltruismCooldownFrame's E:UIFrameFadeOut
local EltruismCooldownDisplay = CreateFrame("Frame", nil, EltruismCooldownFrame)
EltruismCooldownDisplay:SetAllPoints(EltruismCooldownFrame)
local EltruismCooldownText = EltruismCooldownDisplay:CreateFontString("EltruismCoooldownText", "OVERLAY", "GameFontNormal")
local EltruismCooldownIcon = EltruismCooldownDisplay:CreateTexture("EltruismCooldownIcon", "OVERLAY")
local EltruismCooldownMask = EltruismCooldownDisplay:CreateMaskTexture()
--EltruismCooldownMask:SetTexture([[Interface\CHARACTERFRAME\TempPortraitAlphaMask]], "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
EltruismCooldownMask:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\circle_mask.TGA", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
EltruismCooldownMask:SetAllPoints(EltruismCooldownFrame)
EltruismCooldownFrame:Hide()

--native cooldown widget for secret-value countdown numbers and completion events
local EltruismNativeCooldown = CreateFrame("Cooldown", "EltruismCursorNativeCooldown", EltruismCooldownDisplay, "CooldownFrameTemplate")
EltruismNativeCooldown:SetAllPoints(EltruismCooldownDisplay)
EltruismNativeCooldown:SetDrawSwipe(false)
EltruismNativeCooldown:SetDrawEdge(false)
EltruismNativeCooldown:SetDrawBling(false)
EltruismNativeCooldown:SetHideCountdownNumbers(false)
EltruismNativeCooldown.noCooldownCount = true
if E.Modern then
	EltruismNativeCooldown:SetCountdownMillisecondsThreshold(1)
end
EltruismNativeCooldown:Hide()

local CooldownEventFrame = CreateFrame("Frame")
local EltruismCursorCooldownOnUpdate

local function styleNativeCooldownFont()
	if not E.Modern then return end
	if not nativeFontString then
		nativeFontString = EltruismNativeCooldown:GetCountdownFontString()
	end
	if nativeFontString then
		nativeFontString:SetFont(E.media.normFont, textsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
		nativeFontString:SetTextColor(1, 1, 1)
		nativeFontString:ClearAllPoints()
		nativeFontString:SetPoint("CENTER")
	end
end

local function clearNativeCooldown()
	EltruismNativeCooldown.eltruismExpectingDone = false
	currDurationObj = nil
	EltruismNativeCooldown:Clear()
	EltruismNativeCooldown:Hide()
end

local function onCooldownFadeFinished()
	isFading = false
end

local function fadeOutCooldownFrame()
	isFading = true
	E:UIFrameFadeOut(EltruismCooldownFrame, db.fadeTime, 1, 0)
	EltruismCooldownFrame.FadeObject.finishedFunc = onCooldownFadeFinished
end

local function resetCooldownFrameFade(alpha)
	isFading = false
	E:UIFrameFadeRemoveFrame(EltruismCooldownFrame)
	EltruismCooldownFrame:SetAlpha(alpha)
end

local function getGuessTable(cooldownType)
	if cooldownType == "spell" then
		return spellStartGuess
	elseif cooldownType == "item" then
		return itemStartGuess
	elseif cooldownType == "pet" then
		return petStartGuess
	end
end

local function queryCooldown(cooldownType, id, slot, petSpellID, wantDurationObj)
	return ElvUI_EltreumUI:EltruismCooldownQuery(cooldownType, id, petSpellID, slot, GCD, wantDurationObj, true)
end

local function applySecretDuration(durationObj, restyleFont)
	currDurationObj = durationObj
	if durationObj then
		EltruismNativeCooldown.eltruismExpectingDone = true
		EltruismNativeCooldown:Show()
		EltruismNativeCooldown:SetCooldownFromDurationObject(durationObj)
		if restyleFont or not nativeFontString then
			styleNativeCooldownFont()
		end
	else
		clearNativeCooldown()
	end
end

local function enterSecretAlmostReadyWait()
	if not almostReadyCurve or not currDurationObj then
		return false
	end
	isWaitingAlmostReady = true
	isHidden = true
	resetCooldownFrameFade(1)
	EltruismCooldownDisplay:SetAlpha(currDurationObj:EvaluateRemainingDuration(almostReadyCurve))
	ElvUI_EltreumUI:UpdateCursorPosition(EltruismCooldownFrame, 0, true)
	return true
end

local function triggerSecretReady()
	if not isActive or isReady then return end
	isReady = true
	isSecretMode = true
	isWaitingAlmostReady = false
	local guessTable = getGuessTable(currType)
	if guessTable and currID then
		guessTable[currID] = nil
	end
	clearNativeCooldown()
	EltruismCooldownText:SetText("")
	now = GetTime()
	endStamp = now
	fadeStamp = now
	finishStamp = now + db.fadeTime
	isHidden = false
	EltruismCooldownDisplay:SetAlpha(1)
	EltruismCooldownFrame:Show()
	resetCooldownFrameFade(1)
	ElvUI_EltreumUI:UpdateCursorPosition(EltruismCooldownFrame, 0, true)
	EltruismCooldownFrame:SetScript("OnUpdate", EltruismCursorCooldownOnUpdate)
	lastUpdate = NormalUpdateDelay
	lastSecretCheck = 0
end

EltruismNativeCooldown:SetScript("OnCooldownDone", function(self)
	if self.eltruismExpectingDone then
		self.eltruismExpectingDone = false
		triggerSecretReady()
	end
end)

function ElvUI_EltreumUI:CooldownEnable()
	cursordb = E.db.ElvUI_EltreumUI.cursors.cursor
	cooldownsize = (E.db.ElvUI_EltreumUI.cursors.cursorcursor.radius * 2) - 1
	EltruismCooldownFrame:SetSize(cooldownsize, cooldownsize)
	EltruismCooldownFrame:SetJustifyH("CENTER")
	local width = GetPhysicalScreenSize()
	if width == 3840 then
		textsize = ( (cooldownsize * 0.5) + 1)
	else
		textsize = ( (cooldownsize / 3) + 1)
	end

	EltruismCooldownText:SetFont(E.media.normFont, textsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
	EltruismCooldownText:SetTextColor(1, 1, 1)
	EltruismCooldownText:SetPoint("CENTER")
	styleNativeCooldownFont()
	EltruismCooldownIcon:SetTexture(nil)
	EltruismCooldownIcon:AddMaskTexture(EltruismCooldownMask)
	EltruismCooldownIcon:ClearAllPoints()
	EltruismCooldownIcon:SetPoint("CENTER")
	EltruismCooldownIcon:SetSize(cooldownsize + 2, cooldownsize + 2)
	if not ElvUI_EltreumUI:IsHooked("UseAction", "checkActionCooldown") then
		ElvUI_EltreumUI:SecureHook("UseAction", "checkActionCooldown") --this enables tracking actions that are not macros
	end

	if not ElvUI_EltreumUI:IsHooked(C_Container, "UseContainerItem", "checkContainerItemCooldown") then
		ElvUI_EltreumUI:SecureHook(C_Container, "UseContainerItem", "checkContainerItemCooldown")
	end

	if not ElvUI_EltreumUI:IsHooked("UseInventoryItem", "checkInventoryItemCooldown") then
		ElvUI_EltreumUI:SecureHook("UseInventoryItem", "checkInventoryItemCooldown")
	end

	if C_Item.UseItemByName then
		if not ElvUI_EltreumUI:IsHooked(C_Item,"UseItemByName", "checkItemCooldown") then
			ElvUI_EltreumUI:SecureHook(C_Item,"UseItemByName", "checkItemCooldown")
		end
	elseif _G.UseItemByName then
		if not ElvUI_EltreumUI:IsHooked("UseItemByName", "checkItemCooldown") then
			ElvUI_EltreumUI:SecureHook("UseItemByName", "checkItemCooldown")
		end
	end

	if not ElvUI_EltreumUI:IsHooked("CastSpellByName", "checkSpellCooldown") then
		ElvUI_EltreumUI:SecureHook("CastSpellByName", "checkSpellCooldown") -- only needed for pet spells
	end

	if not ElvUI_EltreumUI:IsHooked("CastPetAction", "checkPetActionCooldown") then
		ElvUI_EltreumUI:SecureHook("CastPetAction", "checkPetActionCooldown")
	end

	ElvUI_EltreumUI:RegisterEvent("SPELL_UPDATE_COOLDOWN", "updateCooldown")
	ElvUI_EltreumUI:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN", "updateCooldown")
	ElvUI_EltreumUI:RegisterEvent("BAG_UPDATE_COOLDOWN", "updateCooldown")
	ElvUI_EltreumUI:RegisterEvent("PET_BAR_UPDATE_COOLDOWN", "updateCooldown")

	CooldownEventFrame:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player", "pet")
	CooldownEventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	CooldownEventFrame:SetScript("OnEvent", function(_, event, unit, _, spellID)
		if event == "PLAYER_ENTERING_WORLD" then
			wipe(spellStartGuess)
			wipe(itemStartGuess)
			wipe(petStartGuess)
			return
		end
		if not spellID or not E:NotSecretValue(spellID) then return end
		if unit == "player" or (unit == "pet" and cursordb.petcooldown) then
			local nowTime = GetTime()
			spellStartGuess[spellID] = nowTime
			local override = ElvUI_EltreumUI:EltruismOverrideSpell(spellID)
			if override ~= spellID then
				spellStartGuess[override] = nowTime
			end
		end
	end)
end

EltruismCursorCooldownOnUpdate = function(_, elapsed)
	--skip cursor repositioning when completely invisible during hidden wait
	if not isHidden or isFading or isWaitingAlmostReady or isReady then
		ElvUI_EltreumUI:UpdateCursorPosition(EltruismCooldownFrame, elapsed)
	end
	lastUpdate = lastUpdate + elapsed
	local delay = (isHidden and not isReady and not isWaitingAlmostReady) and NormalUpdateDelay or FadingUpdateDelay
	if lastUpdate < delay then
		return
	end
	lastUpdate = 0
	if not isActive then
		return
	elseif isSecretMode then
		now = GetTime()
		if needUpdate then
			needUpdate = false
			lastSecretCheck = 0
			local state, startstamp, durationstamp, durationObj = queryCooldown(currType, currID, currSlot, currPetSpellID, true)
			if state == "EXACT" then
				isSecretMode = false
				isWaitingAlmostReady = false
				clearNativeCooldown()
				EltruismCooldownDisplay:SetAlpha(1)
				ElvUI_EltreumUI:updateStamps(startstamp, durationstamp, false)
				return
			elseif state == "SECRET" then
				applySecretDuration(durationObj, false)
			else
				triggerSecretReady()
				return
			end
		end
		if isReady then
			if not finishStamp or now > finishStamp then
				EltruismCooldownFrame:SetScript("OnUpdate", nil)
				isActive = false
				isSecretMode = false
				isWaitingAlmostReady = false
				isFading = false
				clearNativeCooldown()
				EltruismCooldownDisplay:SetAlpha(1)
				EltruismCooldownText:SetText(nil)
				EltruismCooldownIcon:SetTexture(nil)
				ElvUI_EltreumUI:updateCooldown()
				return
			end
		else
			--throttle fallback state checks to 1s
			lastSecretCheck = lastSecretCheck + delay
			if lastSecretCheck >= NormalUpdateDelay then
				lastSecretCheck = 0
				local state, startstamp, durationstamp = queryCooldown(currType, currID, currSlot, currPetSpellID, false)
				if state ~= "SECRET" then
					if state == "EXACT" then
						isSecretMode = false
						isWaitingAlmostReady = false
						clearNativeCooldown()
						EltruismCooldownDisplay:SetAlpha(1)
						ElvUI_EltreumUI:updateStamps(startstamp, durationstamp, false)
						return
					end
					triggerSecretReady()
					return
				end
			end
		end
		if isWaitingAlmostReady then
			if almostReadyCurve and currDurationObj then
				EltruismCooldownDisplay:SetAlpha(currDurationObj:EvaluateRemainingDuration(almostReadyCurve))
			end
			return
		end
		if isHidden then
			if not isReady and endStamp and now >= endStamp then
				enterSecretAlmostReadyWait()
			end
			return
		elseif now > fadeStamp then
			isHidden = true
			fadeOutCooldownFrame()
			if not isReady then
				endStamp = now + db.fadeTime
			end
		end
	else
		if needUpdate then
			needUpdate = false
			local state, startstamp, durationstamp, durationObj = queryCooldown(currType, currID, currSlot, currPetSpellID, true)
			if state == "SECRET" then
				isSecretMode = true
				EltruismCooldownText:SetText("")
				applySecretDuration(durationObj, true)
				return
			elseif state == "EXACT" then
				if currStart ~= startstamp or currDuration ~= durationstamp then
					ElvUI_EltreumUI:updateStamps(startstamp, durationstamp, false)
				end
			elseif not isReady then
				--cooldown reset early out of combat
				ElvUI_EltreumUI:updateStamps(0, 0, false)
			end
		end
		now = GetTime()
		if not finishStamp or now > finishStamp then
			EltruismCooldownFrame:SetScript("OnUpdate", nil)
			isActive = false
			isWaitingAlmostReady = false
			isFading = false
			clearNativeCooldown()
			EltruismCooldownDisplay:SetAlpha(1)
			if isRedText then
				isRedText = false
				EltruismCooldownText:SetTextColor(1, 1, 1)
			end
			EltruismCooldownText:SetText(nil)
			EltruismCooldownIcon:SetTexture(nil)
			ElvUI_EltreumUI:updateCooldown() -- check lastType, lastID
			return
		elseif not endStamp or now >= endStamp then
			if not isReady then
				isReady = true
				EltruismCooldownText:SetText("")
				ElvUI_EltreumUI:updateStamps(currStart, currDuration, true)
			end
		else
			cd = endStamp - now
			if cd <= db.readyTime and not isAlmostReady then
				isAlmostReady = true
				ElvUI_EltreumUI:updateStamps(currStart, currDuration, true)
			end
			if cd > 60 then
				EltruismCooldownText:SetFormattedText("%01.fm", cd / 60)
				if isRedText then
					isRedText = false
					EltruismCooldownText:SetTextColor(1, 1, 1)
				end
			elseif cd >= 1 then
				EltruismCooldownText:SetFormattedText("%01.f", mathfloor(cd))
				if isRedText then
					isRedText = false
					EltruismCooldownText:SetTextColor(1, 1, 1)
				end
			elseif cd > 0 then
				EltruismCooldownText:SetFormattedText("%.1f", cd)
				if not isRedText then
					isRedText = true
					EltruismCooldownText:SetTextColor(1, 0, 0)
				end
			end
		end
		if isHidden then
			return
		elseif now > fadeStamp then
			isHidden = true
			fadeOutCooldownFrame()
		end
	end
end

function ElvUI_EltreumUI:updateStamps(startstamp, durationstamp, show, startHidden)
	if not startstamp or not E:NotSecretValue(startstamp) or not E:NotSecretValue(durationstamp) then
		return
	end
	currStart = startstamp
	currDuration = durationstamp
	now = GetTime()
	endStamp = startstamp + durationstamp
	if endStamp < now then
		endStamp = now
	end
	if now + db.holdTime >= endStamp then
		fadeStamp = endStamp
		resetCooldownFrameFade(0)
	else
		fadeStamp = now + db.holdTime
	end
	finishStamp = endStamp + db.fadeTime --this is the time at which it will both be off cd and will not be shown
	lastUpdate = NormalUpdateDelay -- to force update in next frame
	isAlmostReady = false
	isHidden = false
	if show then
		EltruismCooldownDisplay:SetAlpha(1)
		if cursordb.cooldown then
			EltruismCooldownFrame:Show()
		end
		if startHidden then
			isHidden = true
			resetCooldownFrameFade(0)
		else
			resetCooldownFrameFade(1)
			ElvUI_EltreumUI:UpdateCursorPosition(EltruismCooldownFrame, 0, true)
		end
		EltruismCooldownFrame:SetScript("OnUpdate", EltruismCursorCooldownOnUpdate)
	end
end

function ElvUI_EltreumUI:showCooldown(texture, cooldownType, id, actionSlot, petSpellID, hasCooldown, preState, preStart, preDuration, preDurationObj)
	local state, startcd, durationcd, durationObj
	if preState then
		state, startcd, durationcd, durationObj = preState, preStart, preDuration, preDurationObj
	else
		state, startcd, durationcd, durationObj = queryCooldown(cooldownType, id, actionSlot, petSpellID, true)
	end
	local guessTable = getGuessTable(cooldownType)
	if state == "READY" or state == "GCD" or state == "DISABLED" then
		if guessTable and id then
			guessTable[id] = nil
		end
		if hasCooldown and (isReady or not isActive) then
			lastTexture, lastType, lastID, lastSlot, lastPetSpellID = texture, cooldownType, id, actionSlot, petSpellID
		end
		return
	end

	if state == "SECRET" then
		local nowTime = GetTime()
		if guessTable and id then
			if not guessTable[id] then
				guessTable[id] = nowTime
				return
			end
			if (nowTime - guessTable[id]) < db.gracePeriod then
				return
			end
		end
		currType, currID, currSlot, currPetSpellID = cooldownType, id, actionSlot, petSpellID
		isActive = true
		isReady = false
		isAlmostReady = false
		isSecretMode = true
		isHidden = false
		isWaitingAlmostReady = false
		EltruismCooldownText:SetText("")
		if isRedText then
			isRedText = false
			EltruismCooldownText:SetTextColor(1, 1, 1)
		end
		EltruismCooldownIcon:SetTexture(texture)
		EltruismCooldownIcon:AddMaskTexture(EltruismCooldownMask)
		applySecretDuration(durationObj, true)
		fadeStamp = nowTime + db.holdTime
		endStamp = nowTime + db.holdTime + db.fadeTime
		finishStamp = nowTime + db.holdTime + db.fadeTime
		lastUpdate = NormalUpdateDelay
		lastSecretCheck = 0
		EltruismCooldownDisplay:SetAlpha(1)
		if cursordb.cooldown then
			EltruismCooldownFrame:Show()
		end
		resetCooldownFrameFade(1)
		ElvUI_EltreumUI:UpdateCursorPosition(EltruismCooldownFrame, 0, true)
		EltruismCooldownFrame:SetScript("OnUpdate", EltruismCursorCooldownOnUpdate)
		if cursordb.cooldownsound then
			PlaySoundFile(E.LSM:Fetch("sound", cursordb.cooldownfile),"Master")
		end
		return
	end

	--exact mode
	if GetTime() - startcd < db.gracePeriod then
		return
	end
	clearNativeCooldown()
	isSecretMode = false
	isWaitingAlmostReady = false
	currType, currID, currSlot, currPetSpellID = cooldownType, id, actionSlot, petSpellID
	isActive = true
	isReady = false
	isAlmostReady = false
	EltruismCooldownIcon:SetTexture(texture)
	EltruismCooldownIcon:AddMaskTexture(EltruismCooldownMask)
	ElvUI_EltreumUI:updateStamps(startcd, durationcd, true)
	if durationcd > 0 and cursordb.cooldownsound then
		PlaySoundFile(E.LSM:Fetch("sound", cursordb.cooldownfile),"Master")
	end
end

function ElvUI_EltreumUI:checkActionCooldown(slot)
	local actionType, id = GetActionInfo(slot)
	if actionType == 'spell' then
		ElvUI_EltreumUI:checkSpellCooldown(id, slot)
	elseif actionType == 'item' then
		ElvUI_EltreumUI:checkItemCooldown(id, slot)
	elseif actionType == 'macro' then
		local macroSpell = GetMacroSpell(id)
		if macroSpell then
			ElvUI_EltreumUI:checkSpellCooldown(macroSpell, slot)
		else
			local _, macroItem = GetMacroItem(id)
			if macroItem then
				ElvUI_EltreumUI:checkItemCooldown(macroItem, slot)
			end
		end
	end
end

function ElvUI_EltreumUI:checkSpellCooldown(spell, actionSlot)
	if not spell or not E:NotSecretValue(spell) then return end
	local namespell, spellID, texturespell = ElvUI_EltreumUI:EltruismSpellInfo(spell)
	if cursordb.petcooldown and not namespell then
		return ElvUI_EltreumUI:checkPetActionCooldown(ElvUI_EltreumUI:EltruismPetActionIndex(spell))
	end
	local resolvedID = spellID or spell

	local hasCooldown = false
	if ElvUI_EltreumUI:EltruismSpellBaseCooldown(resolvedID) > 0 then
		hasCooldown = true
		ElvUI_EltreumUI:showCooldown(texturespell, "spell", resolvedID, actionSlot, nil, hasCooldown)
		return
	end

	local chargeInfo = GetSpellCharges(resolvedID)
	if chargeInfo then
		if E:NotSecretValue(chargeInfo.isActive) and chargeInfo.isActive then
			hasCooldown = true
		elseif E:NotSecretValue(chargeInfo.cooldownDuration) and chargeInfo.cooldownDuration and chargeInfo.cooldownDuration > 0 then
			hasCooldown = true
		end
	end

	--single cooldown query reused by showCooldown
	local state, startcd, durationcd, durationObj = ElvUI_EltreumUI:EltruismSpellCooldown(resolvedID, actionSlot, GCD, true, true)
	if state == "EXACT" or state == "SECRET" then
		hasCooldown = true
	end
	ElvUI_EltreumUI:showCooldown(texturespell, "spell", resolvedID, actionSlot, nil, hasCooldown, state, startcd, durationcd, durationObj)
end

function ElvUI_EltreumUI:checkInventoryItemCooldown(invSlot)
	local itemLinkinv = GetInventoryItemLink("player", invSlot)
	ElvUI_EltreumUI:checkItemCooldown(itemLinkinv)
end

function ElvUI_EltreumUI:checkContainerItemCooldown(bagId, bagSlot)
	local itemLinkcontainer = GetContainerItemLink(bagId, bagSlot)
	ElvUI_EltreumUI:checkItemCooldown(itemLinkcontainer)
end

function ElvUI_EltreumUI:checkItemCooldown(item, actionSlot)
	local _, itemIdcd, texturecd = ElvUI_EltreumUI:EltruismItemInfo(item)
	if not itemIdcd then return end
	ElvUI_EltreumUI:showCooldown(texturecd, "item", itemIdcd, actionSlot)
end

function ElvUI_EltreumUI:checkPetActionCooldown(index)
	if not index then return end
	local _, texturepetcd, _, _, _, _, spellIdpetcd = GetPetActionInfo(index)
	if spellIdpetcd and E:NotSecretValue(spellIdpetcd) then
		ElvUI_EltreumUI:checkSpellCooldown(spellIdpetcd)
	else
		ElvUI_EltreumUI:showCooldown(texturepetcd, "pet", index, nil, spellIdpetcd)
	end
end

function ElvUI_EltreumUI:updateCooldown() --dont think i need event here
	if not isActive then
		if lastType and lastID then
			local state, startcd, durationcd, durationObj = queryCooldown(lastType, lastID, lastSlot, lastPetSpellID, true)
			if state == "EXACT" then
				currType, currID, currSlot, currPetSpellID = lastType, lastID, lastSlot, lastPetSpellID
				lastType, lastID, lastSlot, lastPetSpellID = nil, nil, nil, nil
				isActive = true
				isReady = false
				isAlmostReady = false
				isSecretMode = false
				isWaitingAlmostReady = false
				clearNativeCooldown()
				EltruismCooldownIcon:SetTexture(lastTexture)
				ElvUI_EltreumUI:updateStamps(startcd, durationcd, true, true)
			elseif state == "SECRET" then
				currType, currID, currSlot, currPetSpellID = lastType, lastID, lastSlot, lastPetSpellID
				lastType, lastID, lastSlot, lastPetSpellID = nil, nil, nil, nil
				isActive = true
				isReady = false
				isAlmostReady = false
				isSecretMode = true
				isHidden = true
				lastSecretCheck = 0
				EltruismCooldownText:SetText("")
				EltruismCooldownIcon:SetTexture(lastTexture)
				EltruismCooldownIcon:AddMaskTexture(EltruismCooldownMask)
				applySecretDuration(durationObj, true)
				if cursordb.cooldown then
					EltruismCooldownFrame:Show()
				end
				if not enterSecretAlmostReadyWait() then
					isWaitingAlmostReady = false
					resetCooldownFrameFade(0)
				end
				EltruismCooldownFrame:SetScript("OnUpdate", EltruismCursorCooldownOnUpdate)
			end
		end
		return
	end
	if isReady then
		return
	end
	needUpdate = true
end
