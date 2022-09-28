--CursorCooldown is a fork of CooldownToGo by mitchnull, which is licensed under Public Domain. My thanks to mitchnull for making it!
local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local CreateFrame = _G.CreateFrame
local UIParent = _G.UIParent
local C_CVar = _G.C_CVar
local GetTime = _G.GetTime
local GetCursorPosition = _G.GetCursorPosition
local math = _G.math
local UIFrameFadeOut = _G.UIFrameFadeOut
local GetActionInfo = _G.GetActionInfo
local GetPetActionInfo = _G.GetPetActionInfo
local GetSpellInfo = _G.GetSpellInfo
local GetSpellBaseCooldown = _G.GetSpellBaseCooldown
local GetSpellCooldown = _G.GetSpellCooldown
local GetInventoryItemLink = _G.GetInventoryItemLink
local GetContainerItemLink = _G.GetContainerItemLink
local tonumber = _G.tonumber
local GetItemInfo = _G.GetItemInfo
local GetItemCooldown = _G.GetItemCooldown
local GetPetActionCooldown = _G.GetPetActionCooldown
local PlaySoundFile = _G.PlaySoundFile
local start, duration, enabled

--onupdate things
local NormalUpdateDelay = 1 --1.0/10 -- update while hidden
local FadingUpdateDelay = 0.1 --1.0/25 -- update while shown
local lastUpdate = 0 -- time since last real update
local updateDelay = NormalUpdateDelay
--function variables
local fadeStamp -- the timestamp when we should start fading the display
local endStamp -- the timestamp when the cooldown will be over
local finishStamp -- the timestamp when the we are finished with this cooldown
local currGetCooldown, currArg, currStart, currDuration, lastTexture, lastGetCooldown, lastArg, x, y, scaleDivisor, cd, now, start, duration, getEltruismCooldownFrameAlpha
local needUpdate = false
local isActive = false
local isAlmostReady = false
local isReady = false
local isHidden = false
local cooldownsize
local textsize
local name, _, isToken
local typeslot, id
local namepet, texture
local namespell, texturespell
local baseCooldown
local itemLinkinv
local itemLinkcontainer
local idlink
local itemLinkcd, texturecd
local itemIdcd
local texturepetcd, spellIdpetcd
local startcd, durationcd, enabledcd

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

local EltruismCooldownFrame = CreateFrame("MessageFrame", "EltruismCooldown", UIParent)
local EltruismCooldownText = EltruismCooldownFrame:CreateFontString("EltruismCoooldownText", "OVERLAY", "GameFontNormal")
local EltruismCooldownIcon = EltruismCooldownFrame:CreateTexture("EltruismCooldownIcon", "OVERLAY")
local EltruismCooldownMask = EltruismCooldownFrame:CreateMaskTexture()
--EltruismCooldownMask:SetTexture([[Interface\CHARACTERFRAME\TempPortraitAlphaMask]], "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
EltruismCooldownMask:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\circle_mask.TGA", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
EltruismCooldownMask:SetAllPoints(EltruismCooldownFrame)
EltruismCooldownFrame:Hide()

function ElvUI_EltreumUI:CooldownEnable()
	if not E.db.ElvUI_EltreumUI then
		cooldownsize = 28
	elseif E.db.ElvUI_EltreumUI then
		if not E.db.ElvUI_EltreumUI.cursors.cursorcursor then
			cooldownsize = 28
		elseif E.db.ElvUI_EltreumUI.cursors.cursorcursor then
			if E.db.ElvUI_EltreumUI.cursors.cursorcursor.radius then
				cooldownsize = ( (E.db.ElvUI_EltreumUI.cursors.cursorcursor.radius * 2 ) - 1 )
			else
				cooldownsize = 28
			end
		end
	end
	EltruismCooldownFrame:SetWidth(cooldownsize)
	EltruismCooldownFrame:SetHeight(cooldownsize)
	EltruismCooldownFrame:SetJustifyH("CENTER")
	local width = GetPhysicalScreenSize()
	if width == 3840 then
		textsize = ( (cooldownsize * 0.5) + 1)
	else
		textsize = ( (cooldownsize / 3) + 1)
	end

	EltruismCooldownText:SetFont(E.media.normFont, textsize, E.db.general.fontStyle)
	EltruismCooldownText:SetTextColor(1, 1, 1)
	EltruismCooldownText:SetPoint("CENTER")
	EltruismCooldownIcon:SetTexture(nil)
	EltruismCooldownIcon:AddMaskTexture(EltruismCooldownMask)
	EltruismCooldownIcon:ClearAllPoints()
	EltruismCooldownIcon:SetPoint("CENTER")
	EltruismCooldownIcon:SetHeight(cooldownsize +2)
	EltruismCooldownIcon:SetWidth(cooldownsize +2)
	--print("CooldownEnable spam "..math.random(1,99))
	if ElvUI_EltreumUI:IsHooked("UseAction", "checkActionCooldown") then
		return
	else
		ElvUI_EltreumUI:SecureHook("UseAction", "checkActionCooldown") --this enables tracking actions that are not macros
	end

	if ElvUI_EltreumUI:IsHooked("UseContainerItem", "checkContainerItemCooldown") then
		return
	else
		ElvUI_EltreumUI:SecureHook("UseContainerItem", "checkContainerItemCooldown")
	end

	if ElvUI_EltreumUI:IsHooked("UseInventoryItem", "checkInventoryItemCooldown") then
		return
	else
		ElvUI_EltreumUI:SecureHook("UseInventoryItem", "checkInventoryItemCooldown")
	end

	if ElvUI_EltreumUI:IsHooked("UseItemByName", "checkItemCooldown") then
		return
	else
		ElvUI_EltreumUI:SecureHook("UseItemByName", "checkItemCooldown")
	end

	if ElvUI_EltreumUI:IsHooked("CastSpellByName", "checkSpellCooldown") then
		return
	else
		ElvUI_EltreumUI:SecureHook("CastSpellByName", "checkSpellCooldown") -- only needed for pet spells
	end

	if ElvUI_EltreumUI:IsHooked("CastPetAction", "checkPetActionCooldown") then
		return
	else
		ElvUI_EltreumUI:SecureHook("CastPetAction", "checkPetActionCooldown")
	end

	--self:SecureHook("UseAction", "checkActionCooldown") --this enables tracking actions that are not macros
	--self:SecureHook("UseContainerItem", "checkContainerItemCooldown")
	--self:SecureHook("UseInventoryItem", "checkInventoryItemCooldown")
	--self:SecureHook("UseItemByName", "checkItemCooldown")
	--self:SecureHook("CastSpellByName", "checkSpellCooldown") -- only needed for pet spells
	--self:SecureHook("CastPetAction", "checkPetActionCooldown")
	ElvUI_EltreumUI:RegisterEvent("SPELL_UPDATE_COOLDOWN", "updateCooldown")
	ElvUI_EltreumUI:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN", "updateCooldown")
	ElvUI_EltreumUI:RegisterEvent("BAG_UPDATE_COOLDOWN", "updateCooldown")
	ElvUI_EltreumUI:RegisterEvent("PET_BAR_UPDATE_COOLDOWN", "updateCooldown")
	--self:RegisterUnitEvent("UNIT_SPELLCAST_FAILED", "player") --this triggers every single time a spell fails like when out of resources or on cd
end

function ElvUI_EltreumUI:updateStamps(start, duration, show, startHidden)
	--print("updateStamps spam "..math.random(1,99))
	if not start then
		return
	end
	currStart = start
	currDuration = duration
	now = GetTime()
	endStamp = start + duration
	if endStamp < now then
		endStamp = now
	end
	if now + db.holdTime >= endStamp then
		--fadeStamp = endStamp
		EltruismCooldownFrame:SetAlpha(0)
	else
		fadeStamp = now + db.holdTime
	end
	finishStamp = endStamp + db.fadeTime --this is the time at which it will both be off cd and will not be shown
	lastUpdate = NormalUpdateDelay -- to force update in next frame
	isAlmostReady = false
	isHidden = false
	if show then
		if E.db.ElvUI_EltreumUI.cursors.cursor.cooldown then
			EltruismCooldownFrame:Show()
		end
		if startHidden then
			isHidden = true
			EltruismCooldownFrame:SetAlpha(0)
		else
			EltruismCooldownFrame:SetAlpha(1)
			--EltruismCooldownFrame:SetScript("OnUpdate", function(frame, elapsed) --if frame is removed, then pet cooldowns can have issues
			EltruismCooldownFrame:SetScript("OnUpdate", function(_, elapsed) --if frame is removed, then pet cooldowns can have issues
				--print("onupdate spam "..math.random(1,99))
				updateDelay = NormalUpdateDelay
				x, y = GetCursorPosition()
				scaleDivisor = UIParent:GetEffectiveScale()
				EltruismCooldownFrame:ClearAllPoints()
				EltruismCooldownFrame:SetPoint( "CENTER", UIParent, "BOTTOMLEFT", (x / scaleDivisor) + E.db.ElvUI_EltreumUI.cursors.cursor.cooldownoffsetx, (y / scaleDivisor) + E.db.ElvUI_EltreumUI.cursors.cursor.cooldownoffsety )
				lastUpdate = lastUpdate + elapsed
				if lastUpdate < updateDelay then
					return
				else
					lastUpdate = 0
					--print("CooldownUpdate spam "..math.random(1,99))
					if not isActive then
						return
					else
						if needUpdate then
							needUpdate = false
							start, duration = currGetCooldown(currArg)
							if currStart ~= start or currDuration ~= duration then
								ElvUI_EltreumUI:updateStamps(start, duration, false)
							end
						end
						now = GetTime()
						if now > finishStamp then
							--print("cd over now")
							EltruismCooldownFrame:SetScript("OnUpdate", nil)
							isActive = false
							EltruismCooldownText:SetText(nil)
							EltruismCooldownIcon:SetTexture(nil)
							ElvUI_EltreumUI:updateCooldown() -- check lastGetCooldown, lastArg
							return
						elseif now >= endStamp then
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
								EltruismCooldownText:SetFormattedText("%01.f".."m", cd / 60, cd % 60)
								EltruismCooldownText:SetTextColor(1, 1, 1)
							elseif cd > 1 and cd < 60 then
								EltruismCooldownText:SetFormattedText("%01.f", math.floor(cd))
								EltruismCooldownText:SetTextColor(1, 1, 1)
							elseif cd > 0 and cd < 1 then
								EltruismCooldownText:SetFormattedText("%.1f", cd)
								EltruismCooldownText:SetTextColor(1, 0, 0)
							end
						end
						if fadeStamp == nil then --error fix attempt
							fadeStamp = 0
						end
						if now == nil then
							now = 0
						end
						if isHidden then
							return
						elseif now > fadeStamp then --error?
							getEltruismCooldownFrameAlpha = EltruismCooldownFrame:GetAlpha()
							isHidden = true
							UIFrameFadeOut(EltruismCooldownFrame, 1, 1, 0)
							if getEltruismCooldownFrameAlpha <= 0 then
								updateDelay = NormalUpdateDelay
							else
								updateDelay = FadingUpdateDelay
							end
						end
					end
				end
			end)
		end
	end
end

function ElvUI_EltreumUI:showCooldown(texture, getCooldownFunc, arg, hasCooldown)
	--print("showCooldown spam "..math.random(1,99))
	start, duration, enabled = getCooldownFunc(arg)
	if not start or enabled ~= 1 or duration <= GCD then
		if hasCooldown and (isReady or not isActive) then
			lastTexture, lastGetCooldown, lastArg = texture, getCooldownFunc, arg
		end
		return
	end
	if GetTime() - start < db.gracePeriod then
		return
	end
	currGetCooldown, currArg = getCooldownFunc, arg
	isActive = true
	isReady = false
	isAlmostReady = false
	EltruismCooldownIcon:SetTexture(texture)
	EltruismCooldownIcon:AddMaskTexture(EltruismCooldownMask)
	ElvUI_EltreumUI:updateStamps(start, duration, true)
	if duration > 0 and E.db.ElvUI_EltreumUI.cursors.cursor.cooldownsound then
		PlaySoundFile(E.LSM:Fetch("sound", E.db.ElvUI_EltreumUI.cursors.cursor.cooldownfile),"Master")
	end
end

function ElvUI_EltreumUI:checkActionCooldown(slot)
	--print("checkActionCooldown spam "..math.random(1,99))
	typeslot, id, _ = GetActionInfo(slot)
	if typeslot == 'spell' then
		ElvUI_EltreumUI:checkSpellCooldown(id)
	elseif typeslot == 'item' then
		ElvUI_EltreumUI:checkItemCooldown(id)
	end
end

local function findPetActionIndexForSpell(spell)
	--print("findPetActionIndexForSpell spam "..math.random(1,99))
	if not spell then return end
	for i = 1, NUM_PET_ACTION_SLOTS do
		namepet, _, _, isToken = GetPetActionInfo(i)
		if isToken then namepet = _G[name] end
		if namepet == spell and E.db.ElvUI_EltreumUI.cursors.cursor.petcooldown then
			return i
		end
	end
end

function ElvUI_EltreumUI:checkSpellCooldown(spell)
	--print("checkSpellCooldown spam "..math.random(1,99))
	if not spell then return end
	namespell, _, texturespell = GetSpellInfo(spell)
	if E.db.ElvUI_EltreumUI.cursors.cursor.petcooldown and not namespell then
		return ElvUI_EltreumUI:checkPetActionCooldown(findPetActionIndexForSpell(spell))
	end
	baseCooldown = GetSpellBaseCooldown(spell)
	ElvUI_EltreumUI:showCooldown(texturespell, GetSpellCooldown, spell, (baseCooldown and baseCooldown > 0))
end

function ElvUI_EltreumUI:checkInventoryItemCooldown(invSlot)
	--print("checkInventoryItemCooldown spam "..math.random(1,99))
	itemLinkinv = GetInventoryItemLink("player", invSlot)
	ElvUI_EltreumUI:checkItemCooldown(itemLinkinv)
end

function ElvUI_EltreumUI:checkContainerItemCooldown(bagId, bagSlot)
	--print("checkContainerItemCooldown spam "..math.random(1,99))
	itemLinkcontainer = GetContainerItemLink(bagId, bagSlot)
	ElvUI_EltreumUI:checkItemCooldown(itemLinkcontainer)
end

local function itemIdFromLink(link)
	if not link then return nil end
	idlink = link:match("item:(%d+)")
	return tonumber(idlink)
end

function ElvUI_EltreumUI:checkItemCooldown(item)
	--print("checkItemCooldown spam "..math.random(1,99))
	if not item then return end
	_, itemLinkcd, _, _, _, _, _, _, _, texturecd = GetItemInfo(item)
	itemIdcd = itemIdFromLink(itemLinkcd)
	if not itemIdcd then return end
	ElvUI_EltreumUI:showCooldown(texturecd, GetItemCooldown, itemIdcd)
end

function ElvUI_EltreumUI:checkPetActionCooldown(index)
	--print("checkPetActionCooldown spam "..math.random(1,99))
	if not index then return end
	_, texturepetcd, _, _, _, _, spellIdpetcd, _, _ = GetPetActionInfo(index) --shadowlands
	--[[if E.Classic or E.TBC then
		local _, _, texture, _, _, _, _, spellId = GetPetActionInfo(index) --old
	elseif E.Retail then
		local _, texture, _, _, _, _, spellId, _, _ = GetPetActionInfo(index) --shadowlands
	end]]
	if spellIdpetcd then
		ElvUI_EltreumUI:checkSpellCooldown(spellIdpetcd)
	else
		ElvUI_EltreumUI:showCooldown(texture, GetPetActionCooldown, index)
	end
end

--[[
function ElvUI_EltreumUI:UNIT_SPELLCAST_FAILED(unit,id) -- im thinking this might not be needed
	if unit and unit ~= 'player' then
		return
	elseif unit then
		if unit == 'player' or unit == 'pet' then
			self:checkSpellCooldown(id)
		end
	end
end
]]--

function ElvUI_EltreumUI:updateCooldown() --dont think i need event here
	--print("updateCooldown spam "..math.random(1,99))
	if not isActive then
		if lastGetCooldown then
			startcd, durationcd, enabledcd = lastGetCooldown(lastArg)
			if not startcd or enabledcd ~= 1 or durationcd <= GCD then
				return
			end
			currGetCooldown, currArg = lastGetCooldown, lastArg
			lastGetCooldown = nil
			isActive = true
			isReady = false
			isAlmostReady = false
			EltruismCooldownIcon:SetTexture(lastTexture)
			ElvUI_EltreumUI:updateStamps(start, duration, true, true)
			EltruismCooldownFrame:SetAlpha(0)
		end
		return
	end
	if isReady then
		return
	end
	needUpdate = true
end
