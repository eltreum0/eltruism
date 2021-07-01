local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local tostring = _G.tostring
local tonumber = _G.tonumber
local pairs = _G.pairs
local GetTime = _G.GetTime
local GetActionInfo = _G.GetActionInfo
local GetPetActionCooldown = _G.GetPetActionCooldown
local GetPetActionInfo = _G.GetPetActionInfo
local GetSpellBookItemName = _G.GetSpellBookItemName
local GetSpellLink = _G.GetSpellLink
local GetSpellInfo = _G.GetSpellInfo
local GetSpellCooldown = _G.GetSpellCooldown
local GetSpellBaseCooldown = _G.GetSpellBaseCooldown
local GetInventoryItemLink = _G.GetInventoryItemLink
local GetContainerItemLink = _G.GetContainerItemLink
local GetItemInfo = _G.GetItemInfo
local GetItemCooldown = _G.GetItemCooldown
local NUM_PET_ACTION_SLOTS = NUM_PET_ACTION_SLOTS
local GameFontNormal = _G.GameFontNormal
local CreateFrame = _G.CreateFrame
local UIParent = _G.UIParent
local LSM = _G.LSM
local GetCursorPosition = _G.GetCursorPosition
local LibStub = _G.LibStub



-- hard-coded config stuff
local NormalUpdateDelay = 1.0/10 -- update frequency == 1/NormalUpdateDelay
local FadingUpdateDelay = 1.0/25 -- update frequency while fading == 1/FadingUpdateDelay, must be <= NormalUpdateDelay
local DefaultFontName = E.media.normFont
local DefaultFontPath = GameFontNormal:GetFont()
local Icon = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\logo.tga]]

-- internal vars
local db
local _ -- throwaway
local lastUpdate = 0 -- time since last real update
local updateDelay = NormalUpdateDelay
local fadeStamp -- the timestamp when we should start fading the display
local hideStamp -- the timestamp when we should hide the display
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
local GCD = 1.5

local defaults = {
    profile = {
        holdTime = 1.0,
        fadeTime = 2.0,
        readyTime = 1.0,
        gracePeriod = 0.5,
    },
}

local function itemIdFromLink(link)
    if not link then return nil end
    local id = link:match("item:(%d+)")
    return tonumber(id)
end

local function spellIdFromLink(link)
    if not link then return nil end
    local id = link:match("spell:(%d+)")
    return tonumber(id)
end

local function petActionIndexFromLink(link)
    if not link then return nil end
    local id = link:match("petbar:(%d+)")
    return tonumber(id)
end

local cooldownsize = E.db.ElvUI_EltreumUI.cursorcast.radius + 1


function ElvUI_EltreumUI:updateLayout()
    self.icon:ClearAllPoints()
    self.icon:SetPoint("CENTER")
    self.icon:SetHeight(cooldownsize)
    self.icon:SetWidth(cooldownsize)
end

function ElvUI_EltreumUI:createFrame()
    local frame = CreateFrame("MessageFrame", "ElvUI_EltreumUIFrame", UIParent)
    frame:Hide()
    --frame:SetFrameStrata(defaults.profile.strata)
    frame:SetClampedToScreen()
    frame:SetMovable(true)
    --frame:SetWidth(20)
    --frame:SetHeight(20)
    --frame:SetFont(E.media.normFont, 72, "OUTLINE")
    frame:SetJustifyH("CENTER")
    self.frame = frame

    local text = frame:CreateFontString("EltruismCoooldownText", "OVERLAY", "GameFontNormal")
    text:SetFont(E.media.normFont, 16, "OUTLINE")
    --text:SetText("EltruismCooldown")
    text:SetTextColor(1, 1, 1)
    text:SetPoint("CENTER")
    self.text = text

    local icon = frame:CreateTexture("EltruismCooldownIcon", "OVERLAY")
    self.icon = icon
    self.iconTexture = icon
    self.iconTexture:SetTexture(Icon)
    self:updateLayout()
    --self.icon:SetDrawSwipe(Icon)

    frame:SetScript("OnUpdate", function(frame, elapsed)
    	local x, y = GetCursorPosition()
		local scaleDivisor = UIParent:GetEffectiveScale()
		frame:ClearAllPoints()
		frame:SetPoint( "CENTER", UIParent, "BOTTOMLEFT", x / scaleDivisor , y / scaleDivisor )
        lastUpdate = lastUpdate + elapsed
        if lastUpdate < updateDelay then return end
        lastUpdate = 0
        self:OnUpdate(elapsed)
    end)
end

function ElvUI_EltreumUI:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("ElvUI_EltreumUIDB", defaults)
    self.db.RegisterCallback(self, "OnProfileChanged", "profileChanged")
    self.db.RegisterCallback(self, "OnProfileCopied", "profileChanged")
    self.db.RegisterCallback(self, "OnProfileReset", "profileChanged")
    db = self.db.profile

    if not self.frame then
        self:createFrame()
    end
end

function ElvUI_EltreumUI:OnEnable(first)
    self:SecureHook("UseAction", "checkActionCooldown")
    self:SecureHook("UseContainerItem", "checkContainerItemCooldown")
    self:SecureHook("UseInventoryItem", "checkInventoryItemCooldown")
    self:SecureHook("UseItemByName", "checkItemCooldown")
    self:SecureHook("CastSpellByName", "checkSpellCooldown") -- only needed for pet spells
    self:SecureHook("CastPetAction", "checkPetActionCooldown")
    self:RegisterEvent("SPELL_UPDATE_COOLDOWN", "updateCooldown")
    self:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN", "updateCooldown")
    self:RegisterEvent("BAG_UPDATE_COOLDOWN", "updateCooldown")
    self:RegisterEvent("PET_BAR_UPDATE_COOLDOWN", "updateCooldown")
    self:RegisterEvent("UNIT_SPELLCAST_FAILED") -- FIXME: RegisterUnitEvent("UNIT_SPELLCAST_FAILED", "player", "pet")
end


function ElvUI_EltreumUI:profileChanged()
    db = self.db.profile
end

function ElvUI_EltreumUI:OnUpdate(elapsed)
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
        elseif cd > 1 and cd < 60 then
            self.text:SetFormattedText("%01.f", math.floor(cd))
        else
        	self.text:SetFormattedText("%4.1f", cd)
        end
    end
    if isHidden then
        return
    end
    if now > fadeStamp then
        local alpha = 1 - ((now - fadeStamp) / db.fadeTime)
        if alpha <= 0 then
            isHidden = true
            self.frame:SetAlpha(0)
            updateDelay = NormalUpdateDelay
        else
            self.frame:SetAlpha(alpha)
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
    hideStamp = fadeStamp + db.fadeTime
    lastUpdate = NormalUpdateDelay -- to force update in next frame
    isAlmostReady = false
    isHidden = false
    if show then
        updateDelay = NormalUpdateDelay
        self.frame:Show()
        if startHidden then
            isHidden = true
            self.frame:SetAlpha(0)
        else
            self.frame:SetAlpha(1)
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
    self.iconTexture:SetTexCoord(0.07, 0.93, 0.07, 0.93)
    SetPortraitToTexture(self.iconTexture, texture)
    self:updateStamps(start, duration, true)
end

function ElvUI_EltreumUI:checkActionCooldown(slot)
    local type, id, subtype = GetActionInfo(slot)
    -- printf("### action: %s, type=%s, id=%s, subtype=%s", tostring(slot), tostring(type), tostring(id), tostring(subtype))
    if type == 'spell' then
        self:checkSpellCooldown(id)
    elseif type == 'item' then
        self:checkItemCooldown(id)
    end
end

local function findPetActionIndexForSpell(spell)
    if not spell then return end
    -- printf("### findPetActionIndexForSpell(%s)", tostring(spell))
    for i = 1, NUM_PET_ACTION_SLOTS do
        local name, sub, _, isToken = GetPetActionInfo(i)
        if isToken then name = _G[name] end
        -- printf("### %s: name: %s, sub: %s, isToken: %s", tostring(i), tostring(name), tostring(sub), tostring(isToken))
        if name == spell then
            return i
        end
    end
end

function ElvUI_EltreumUI:checkSpellCooldown(spell)
    -- print("### spell: " .. tostring(spell))
    if not spell then return end
    local name, _, texture = GetSpellInfo(spell)
    if not name then
         return self:checkPetActionCooldown(findPetActionIndexForSpell(spell))
    end
    local baseCooldown = GetSpellBaseCooldown(spell)
    self:showCooldown(texture, GetSpellCooldown, spell, (baseCooldown and baseCooldown > 0))
end

function ElvUI_EltreumUI:checkInventoryItemCooldown(invSlot)
    -- print("### invItem: " .. tostring(invSlot))
    local itemLink = GetInventoryItemLink("player", invSlot)
    self:checkItemCooldown(itemLink)
end

function ElvUI_EltreumUI:checkContainerItemCooldown(bagId, bagSlot)
    -- print("### containerItem: " .. tostring(bagId) .. ", " .. tostring(bagSlot))
    local itemLink = GetContainerItemLink(bagId, bagSlot)
    self:checkItemCooldown(itemLink)
end

function ElvUI_EltreumUI:checkItemCooldown(item)
    -- print("### item: " .. tostring(item))
    if not item then return end
    local _, itemLink, _, _, _, _, _, _, _, texture = GetItemInfo(item)
    local itemId = itemIdFromLink(itemLink)
    if not itemId then return end
    self:showCooldown(texture, GetItemCooldown, itemId)
end

function ElvUI_EltreumUI:checkPetActionCooldown(index)
    -- print("### checkPetActionCooldown: " .. tostring(index))
    if not index then return end
    local _, _, texture, _, _, _, _, spellId = GetPetActionInfo(index)
    if spellId then
        self:checkSpellCooldown(spellId)
    else
        self:showCooldown(texture, GetPetActionCooldown, index)
    end
end

function ElvUI_EltreumUI:UNIT_SPELLCAST_FAILED(event, unit, name, rank, seq, id)
    -- print("### unit: " .. tostring(unit) .. ", name: " .. tostring(name) .. ", rank: " .. tostring(rank) .. ", seq: " .. tostring(seq) .. ", id: " .. tostring(id))
    if unit == 'player' or unit == 'pet' then
        self:checkSpellCooldown(id)
    end
end

function ElvUI_EltreumUI:updateCooldown(event)
    -- printf("### updateCooldown: %s", tostring(event))
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
            self.frame:SetAlpha(0)
        end
        return
    end
    if isReady then
        return
    end
    needUpdate = true
end
