--CursorCooldown is a fork of CooldownToGo by mitchnull, which is licensed under Public Domain. My thanks to mitchnull for making it!
local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G

local tonumber = _G.tonumber
local GetTime = _G.GetTime
local GetActionInfo = _G.GetActionInfo
local GetPetActionCooldown = _G.GetPetActionCooldown
local GetPetActionInfo = _G.GetPetActionInfo
local GetSpellInfo = _G.GetSpellInfo
local GetSpellCooldown = _G.GetSpellCooldown
local GetSpellBaseCooldown = _G.GetSpellBaseCooldown
local GetInventoryItemLink = _G.GetInventoryItemLink
local GetContainerItemLink = _G.GetContainerItemLink
local GetItemInfo = _G.GetItemInfo
local GetItemCooldown = _G.GetItemCooldown
local NUM_PET_ACTION_SLOTS = NUM_PET_ACTION_SLOTS
local CreateFrame = _G.CreateFrame
local UIParent = _G.UIParent
local GetCursorPosition = _G.GetCursorPosition
local LibStub = _G.LibStub
local math = _G.math

--onupdate things
local NormalUpdateDelay = 1.0/10 -- update frequency == 1/NormalUpdateDelay
local FadingUpdateDelay = 1.0/25 -- update frequency while fading == 1/FadingUpdateDelay, must be <= NormalUpdateDelay
local lastUpdate = 0 -- time since last real update
local updateDelay = NormalUpdateDelay

local Icon = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\logo.tga]]
local db
local fadeStamp -- the timestamp when we should start fading the display
local endStamp -- the timestamp when the cooldown will be over
local finishStamp -- the timestamp when the we are finished with this cooldown
local currGetCooldown
local currArg
local currStart
local currDuration
local lastTexture
local lastGetCooldown
local lastArg
local needUpdate = false
local isActive = false
local isAlmostReady = false
local isReady = false
local isHidden = false
local myclass = E.myclass

--gcd things
local GCD = 1.5
if myclass == "ROGUE" or myclass == "MONK" or myclass == "DRUID" then
	GCD = 1
end

local defaults = {
	profile = {
		holdTime = 1.0,
		fadeTime = 1.0,
		readyTime = 4.0,
		gracePeriod = 0.5,
	},
}

local function itemIdFromLink(link)
	if not link then return nil end
	local id = link:match("item:(%d+)")
	return tonumber(id)
end

local cooldownsize
function ElvUI_EltreumUI:SetupCDSize()
	if not E.db.ElvUI_EltreumUI then
		cooldownsize = 28
	elseif E.db.ElvUI_EltreumUI then
		if not E.db.ElvUI_EltreumUI.cursorcursor then
			cooldownsize = 28
		elseif E.db.ElvUI_EltreumUI.cursorcursor then
			if E.db.ElvUI_EltreumUI.cursorcursor.radius then
				cooldownsize = ( (E.db.ElvUI_EltreumUI.cursorcursor.radius * 2 ) - 2 )
			else
				cooldownsize = 28
			end
		end
	end
end

function ElvUI_EltreumUI:updateLayout()
	self.icon:ClearAllPoints()
	self.icon:SetPoint("CENTER")
	self:SetupCDSize()
	self.icon:SetHeight(cooldownsize +2)
	self.icon:SetWidth(cooldownsize +2)
end

local mask
local EltruismCooldownFrame = CreateFrame("MessageFrame", "EltruismCooldown", UIParent)
EltruismCooldownFrame:Hide()
function ElvUI_EltreumUI:createCooldownFrame()
	self:SetupCDSize()
	EltruismCooldownFrame:SetWidth(cooldownsize)
	EltruismCooldownFrame:SetHeight(cooldownsize)
	EltruismCooldownFrame:SetJustifyH("CENTER")
	self.EltruismCooldownFrame = EltruismCooldownFrame
	mask = EltruismCooldownFrame:CreateMaskTexture()
	mask:SetTexture([[Interface\CHARACTERFRAME\TempPortraitAlphaMask]], "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
	mask:SetAllPoints(EltruismCooldownFrame)

	local text = EltruismCooldownFrame:CreateFontString("EltruismCoooldownText", "OVERLAY", "GameFontNormal")
	local textsize = ( (cooldownsize / 2) + 1)
	text:SetFont(E.media.normFont, textsize, "OUTLINE")
	text:SetTextColor(1, 1, 1)
	text:SetPoint("CENTER")
	self.text = text

	local icon = EltruismCooldownFrame:CreateTexture("EltruismCooldownIcon", "OVERLAY")
	self.icon = icon
	self.iconTexture = icon
	self.iconTexture:SetTexture(Icon)
	self.iconTexture:AddMaskTexture(mask)
	self:updateLayout()
end

function ElvUI_EltreumUI:CooldownInitialize()
	self.db = LibStub("AceDB-3.0"):New("ElvUI_EltreumUIDB", defaults)
	db = self.db.profile
	if not self.EltruismCooldownFrame then
		self:createCooldownFrame()
	end
end

function ElvUI_EltreumUI:CooldownEnable()
	if ElvUI_EltreumUI:IsHooked("UseAction", "checkActionCooldown") then
		return
	else
		self:SecureHook("UseAction", "checkActionCooldown") --this enables tracking actions that are not macros
	end

	if ElvUI_EltreumUI:IsHooked("UseContainerItem", "checkContainerItemCooldown") then
		return
	else
		self:SecureHook("UseContainerItem", "checkContainerItemCooldown")
	end

	if ElvUI_EltreumUI:IsHooked("UseInventoryItem", "checkInventoryItemCooldown") then
		return
	else
		self:SecureHook("UseInventoryItem", "checkInventoryItemCooldown")
	end

	if ElvUI_EltreumUI:IsHooked("UseItemByName", "checkItemCooldown") then
		return
	else
		self:SecureHook("UseItemByName", "checkItemCooldown")
	end

	if ElvUI_EltreumUI:IsHooked("CastSpellByName", "checkSpellCooldown") then
		return
	else
		self:SecureHook("CastSpellByName", "checkSpellCooldown") -- only needed for pet spells
	end

	if ElvUI_EltreumUI:IsHooked("CastPetAction", "checkPetActionCooldown") then
		return
	else
		self:SecureHook("CastPetAction", "checkPetActionCooldown")
	end

	--self:SecureHook("UseAction", "checkActionCooldown") --this enables tracking actions that are not macros
	--self:SecureHook("UseContainerItem", "checkContainerItemCooldown")
	--self:SecureHook("UseInventoryItem", "checkInventoryItemCooldown")
	--self:SecureHook("UseItemByName", "checkItemCooldown")
	--self:SecureHook("CastSpellByName", "checkSpellCooldown") -- only needed for pet spells
	--self:SecureHook("CastPetAction", "checkPetActionCooldown")
	self:RegisterEvent("SPELL_UPDATE_COOLDOWN", "updateCooldown")
	self:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN", "updateCooldown")
	self:RegisterEvent("BAG_UPDATE_COOLDOWN", "updateCooldown")
	self:RegisterEvent("PET_BAR_UPDATE_COOLDOWN", "updateCooldown")
	--self:RegisterEvent("UNIT_SPELLCAST_FAILED") --this triggers every single time a spell fails like when out of resources or on cd
end

function ElvUI_EltreumUI:CooldownUpdate()
	if not isActive then
		return
	end
	if needUpdate then
		needUpdate = false
		local start, duration = currGetCooldown(currArg)
		if currStart ~= start or currDuration ~= duration then
			self:updateStamps(start, duration, false)
		end
	end
	local now = GetTime()
	if now > finishStamp then
		isActive = false
		self.text:SetText(nil)
		self.iconTexture:SetTexture(nil)
		self:updateCooldown() -- check lastGetCooldown, lastArg
		return
	end
	if now >= endStamp then
		if not isReady then
			isReady = true
			self.text:SetText("")
			self:updateStamps(currStart, currDuration, true)
		end
	else
		local cd = endStamp - now
		if cd <= db.readyTime and not isAlmostReady then
			isAlmostReady = true
			self:updateStamps(currStart, currDuration, true)
		end
		if cd > 60 then
			self.text:SetFormattedText("%01.f".."m", cd / 60, cd % 60)
			self.text:SetTextColor(1, 1, 1)
		elseif cd > 1 and cd < 60 then
			self.text:SetFormattedText("%01.f", math.floor(cd))
			self.text:SetTextColor(1, 1, 1)
		else
			self.text:SetFormattedText("%.1f", cd)
			self.text:SetTextColor(1, 0, 0)
		end
	end
	if isHidden then
		return
	end
	if now > fadeStamp then
		local alpha = 1 - ((now - fadeStamp) / db.fadeTime)
		if alpha <= 0 then
			isHidden = true
			self.EltruismCooldownFrame:SetAlpha(0)
			updateDelay = NormalUpdateDelay
		else
			self.EltruismCooldownFrame:SetAlpha(alpha)
			updateDelay = FadingUpdateDelay
		end
	end
end

function ElvUI_EltreumUI:updateStamps(start, duration, show, startHidden)
	if not start then
		return
	end
	currStart = start
	currDuration = duration
	local now = GetTime()
	endStamp = start + duration
	if endStamp < now then
		endStamp = now
	end
	if now + db.holdTime >= endStamp then
		fadeStamp = endStamp
	else
		fadeStamp = now + db.holdTime
	end
	finishStamp = endStamp + db.fadeTime
	lastUpdate = NormalUpdateDelay -- to force update in next frame
	isAlmostReady = false
	isHidden = false
	if show then
		updateDelay = NormalUpdateDelay
		if E.db.ElvUI_EltreumUI.cursor.cooldown then
			self.EltruismCooldownFrame:Show()
		end
		if startHidden then
			isHidden = true
			self.EltruismCooldownFrame:SetAlpha(0)
			--unregister onupdate when hidden
			EltruismCooldownFrame:SetScript("OnUpdate", nil)
		else
			self.EltruismCooldownFrame:SetAlpha(1)

			--throttling here using elapsed makes the frame not sync up, idk if i can make it sync with a throttle
			-- so instead we make it not update at all when hidden
			EltruismCooldownFrame:SetScript("OnUpdate", function(frame, elapsed) --if frame is removed, then pet cooldowns can have issues
				---print("cooldown spam "..math.random(1,99))
				local x, y = GetCursorPosition()
				local scaleDivisor = UIParent:GetEffectiveScale()
				EltruismCooldownFrame:ClearAllPoints()
				EltruismCooldownFrame:SetPoint( "CENTER", UIParent, "BOTTOMLEFT", x / scaleDivisor , y / scaleDivisor )
				lastUpdate = lastUpdate + elapsed
				if lastUpdate < updateDelay then return end
				lastUpdate = 0
				self:CooldownUpdate(elapsed)
				--[[if isHidden == true then
					EltruismCooldownFrame:SetScript("OnUpdate", nil)
					print("stopped updating")
				end]]
			end)

		end
	end
end

function ElvUI_EltreumUI:showCooldown(texture, getCooldownFunc, arg, hasCooldown)
	local start, duration, enabled = getCooldownFunc(arg)
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
	self.iconTexture:SetTexture(texture)
	self.iconTexture:AddMaskTexture(mask)
	self:updateStamps(start, duration, true)
end

function ElvUI_EltreumUI:checkActionCooldown(slot)
	local type, id, _ = GetActionInfo(slot)
	if type == 'spell' then
		self:checkSpellCooldown(id)
	elseif type == 'item' then
		self:checkItemCooldown(id)
	end
end

local function findPetActionIndexForSpell(spell)
	if not spell then return end
	for i = 1, NUM_PET_ACTION_SLOTS do
		local name, _, _, isToken = GetPetActionInfo(i)
		if isToken then name = _G[name] end
		if name == spell then
			return i
		end
	end
end

function ElvUI_EltreumUI:checkSpellCooldown(spell)
	if not spell then return end
	local name, _, texture = GetSpellInfo(spell)
	if not name then
		 return self:checkPetActionCooldown(findPetActionIndexForSpell(spell))
	end
	local baseCooldown = GetSpellBaseCooldown(spell)
	self:showCooldown(texture, GetSpellCooldown, spell, (baseCooldown and baseCooldown > 0))
end

function ElvUI_EltreumUI:checkInventoryItemCooldown(invSlot)
	local itemLink = GetInventoryItemLink("player", invSlot)
	self:checkItemCooldown(itemLink)
end

function ElvUI_EltreumUI:checkContainerItemCooldown(bagId, bagSlot)
	local itemLink = GetContainerItemLink(bagId, bagSlot)
	self:checkItemCooldown(itemLink)
end

function ElvUI_EltreumUI:checkItemCooldown(item)
	if not item then return end
	local _, itemLink, _, _, _, _, _, _, _, texture = GetItemInfo(item)
	local itemId = itemIdFromLink(itemLink)
	if not itemId then return end
	self:showCooldown(texture, GetItemCooldown, itemId)
end

function ElvUI_EltreumUI:checkPetActionCooldown(index)
	if not index then return end
	local texture, spellId
	local _, texture, _, _, _, _, spellId, _, _ = GetPetActionInfo(index) --shadowlands
	--[[if ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
		local _, _, texture, _, _, _, _, spellId = GetPetActionInfo(index) --old
	elseif ElvUI_EltreumUI.Retail then
		local _, texture, _, _, _, _, spellId, _, _ = GetPetActionInfo(index) --shadowlands
	end]]
	if spellId then
		self:checkSpellCooldown(spellId)
	else
		self:showCooldown(texture, GetPetActionCooldown, index)
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
	if not isActive then
		if lastGetCooldown then
			local start, duration, enabled = lastGetCooldown(lastArg)
			if not start or enabled ~= 1 or duration <= GCD then
				return
			end
			currGetCooldown, currArg = lastGetCooldown, lastArg
			lastGetCooldown = nil
			isActive = true
			isReady = false
			isAlmostReady = false
			self.iconTexture:SetTexture(lastTexture)
			self:updateStamps(start, duration, true, true)
			self.EltruismCooldownFrame:SetAlpha(0)
		end
		return
	end
	if isReady then
		return
	end
	needUpdate = true
end
