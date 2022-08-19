local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local fadeInTime, fadeOutTime, maxAlpha, animScale, iconSize, holdTime, showSpellName, ignoredSpells, invertIgnored
local cooldowns, animating, watching = { }, { }, { }
local GetTime = GetTime

local defaultSettings = {
    fadeInTime = 0.3,
    fadeOutTime = 0.7,
    maxAlpha = 0.7,
    animScale = 1.5,
    iconSize = 75,
    holdTime = 0,
    petOverlay = {1,1,1},
    showSpellName = nil,
    x = UIParent:GetWidth()*UIParent:GetEffectiveScale()/2,
    y = UIParent:GetHeight()*UIParent:GetEffectiveScale()/2
}

local defaultSettingsPerCharacter = {
    ignoredSpells = "",
    invertIgnored = false
}


---create frames
local DCP = CreateFrame("frame")
DCP:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
DCP:SetMovable(true)
DCP:RegisterForDrag("LeftButton")
DCP:SetScript("OnDragStart", function(self) self:StartMoving() end)
DCP:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    defaultSettings.x = self:GetLeft()+self:GetWidth()/2
    defaultSettings.y = self:GetBottom()+self:GetHeight()/2
    self:ClearAllPoints()
    self:SetPoint("CENTER",UIParent,"BOTTOMLEFT",defaultSettings.x,defaultSettings.y)
end)
DCP.TextFrame = DCP:CreateFontString(nil, "ARTWORK")
DCP.TextFrame:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
DCP.TextFrame:SetShadowOffset(2,-2)
DCP.TextFrame:SetPoint("CENTER",DCP,"CENTER")
DCP.TextFrame:SetWidth(185)
DCP.TextFrame:SetJustifyH("CENTER")
DCP.TextFrame:SetTextColor(1,1,1)

local DCPT = DCP:CreateTexture(nil,"BACKGROUND")
DCPT:SetAllPoints(DCP)

-----------------------
-- Utility Functions --
-----------------------
local function tcount(tab)
    local n = 0
    for _ in pairs(tab) do
        n = n + 1
    end
    return n
end

local function memoize(f)
    local cache = nil

    local memoized = {}

    local function get()
        if (cache == nil) then
            cache = f()
        end

        return cache
    end

    memoized.resetCache = function()
        cache = nil
    end

    setmetatable(memoized, {__call = get})

    return memoized
end

local function GetPetActionIndexByName(name)
    for i=1, NUM_PET_ACTION_SLOTS, 1 do
        if (GetPetActionInfo(i) == name) then
            return i
        end
    end
    return nil
end

local function RefreshLocals()
    fadeInTime = defaultSettings.fadeInTime
    fadeOutTime = defaultSettings.fadeOutTime
    maxAlpha = defaultSettings.maxAlpha
    animScale = defaultSettings.animScale
    iconSize = defaultSettings.iconSize
    holdTime = defaultSettings.holdTime
    showSpellName = defaultSettings.showSpellName
    invertIgnored = defaultSettingsPerCharacter.invertIgnored

    ignoredSpells = { }
    for _,v in ipairs(  {  strsplit("," ,defaultSettingsPerCharacter.ignoredSpells)}    ) do
    	if ignoredSpells[v] then
        	ignoredSpells[strtrim(v)] = true
        end
    end
end

--------------------------
-- Cooldown / Animation --
--------------------------
local elapsed = 0
local runtimer = 0
local function OnUpdate(_,update)
    elapsed = elapsed + update
    if (elapsed > 0.05) then
        for i,v in pairs(watching) do
            if (GetTime() >= v[1] + 0.5) then
                local getCooldownDetails
                if (v[2] == "spell") then
                    getCooldownDetails = memoize(function()
                        local start, duration, enabled = GetSpellCooldown(v[3])
                        return {
                            name = GetSpellInfo(v[3]),
                            texture = GetSpellTexture(v[3]),
                            start = start,
                            duration = duration,
                            enabled = enabled
                        }
                    end)
                elseif (v[2] == "item") then
                    getCooldownDetails = memoize(function()
                        local start, duration, enabled = GetItemCooldown(i)
                        return {
                            name = GetItemInfo(i),
                            texture = v[3],
                            start = start,
                            duration = duration,
                            enabled = enabled
                        }
                    end)
                elseif (v[2] == "pet") then
                    getCooldownDetails = memoize(function()
                        local name, texture = GetPetActionInfo(v[3])
                        local start, duration, enabled = GetPetActionCooldown(v[3])
                        return {
                            name = name,
                            texture = texture,
                            isPet = true,
                            start = start,
                            duration = duration,
                            enabled = enabled
                        }
                    end)
                end

                local cooldown = getCooldownDetails()
                if ((ignoredSpells[cooldown.name] ~= nil) ~= invertIgnored) then
                    watching[i] = nil
                else
                    if (cooldown.enabled ~= 0) then
                        if (cooldown.duration and cooldown.duration > 2.0 and cooldown.texture) then
                            cooldowns[i] = getCooldownDetails
                        end
                    end
                    if (not (cooldown.enabled == 0 and v[2] == "spell")) then
                        watching[i] = nil
                    end
                end
            end
        end
        for i,getCooldownDetails in pairs(cooldowns) do
            local cooldown = getCooldownDetails()
            local remaining = cooldown.duration-(GetTime()-cooldown.start)
            if (remaining <= 0) then
                tinsert(animating, {cooldown.texture,cooldown.isPet,cooldown.name})
                cooldowns[i] = nil
            end
        end

        elapsed = 0
        if (#animating == 0 and tcount(watching) == 0 and tcount(cooldowns) == 0) then
            DCP:SetScript("OnUpdate", nil)
            return
        end
    end

    if (#animating > 0) then
        runtimer = runtimer + update
        if (runtimer > (fadeInTime + holdTime + fadeOutTime)) then
            tremove(animating,1)
            runtimer = 0
            DCP.TextFrame:SetText(nil)
            DCPT:SetTexture(nil)
            DCPT:SetVertexColor(1,1,1)
        else
            if (not DCPT:GetTexture()) then
                if (animating[1][3] ~= nil and showSpellName) then
                    DCP.TextFrame:SetText(animating[1][3])
                end
                DCPT:SetTexture(animating[1][1])
                if animating[1][2] then
                    DCPT:SetVertexColor(unpack(defaultSettings.petOverlay))
                end
            end
            local alpha = maxAlpha
            if (runtimer < fadeInTime) then
                alpha = maxAlpha * (runtimer / fadeInTime)
            elseif (runtimer >= fadeInTime + holdTime) then
                alpha = maxAlpha - ( maxAlpha * ((runtimer - holdTime - fadeInTime) / fadeOutTime))
            end
            DCP:SetAlpha(alpha)
            local scale = iconSize+(iconSize*((animScale-1)*(runtimer/(fadeInTime+holdTime+fadeOutTime))))
            DCP:SetWidth(scale)
            DCP:SetHeight(scale)
        end
    end
end

--------------------
-- Event Handlers --
--------------------
function DCP:ADDON_LOADED(addon)

    RefreshLocals()
    self:SetPoint("CENTER",UIParent,"BOTTOMLEFT",defaultSettings.x,defaultSettings.y)
    self:UnregisterEvent("ADDON_LOADED")
end
DCP:RegisterEvent("ADDON_LOADED")

function DCP:SPELL_UPDATE_COOLDOWN()
    for i,getCooldownDetails in pairs(cooldowns) do
        getCooldownDetails.resetCache()
    end
end
DCP:RegisterEvent("SPELL_UPDATE_COOLDOWN")

function DCP:UNIT_SPELLCAST_SUCCEEDED(unit,lineID,spellID)
    if (unit == "player") then
        watching[spellID] = {GetTime(),"spell",spellID}
        if (not self:IsMouseEnabled()) then
            self:SetScript("OnUpdate", OnUpdate)
        end
    end
end
DCP:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")

function DCP:COMBAT_LOG_EVENT_UNFILTERED()
    local _,event,_,_,_,sourceFlags,_,_,_,_,_,spellID = CombatLogGetCurrentEventInfo()
    if (event == "SPELL_CAST_SUCCESS") then
        if (bit.band(sourceFlags,COMBATLOG_OBJECT_TYPE_PET) == COMBATLOG_OBJECT_TYPE_PET and bit.band(sourceFlags,COMBATLOG_OBJECT_AFFILIATION_MINE) == COMBATLOG_OBJECT_AFFILIATION_MINE) then
            local name = GetSpellInfo(spellID)
            local index = GetPetActionIndexByName(name)
            if (index and not select(7,GetPetActionInfo(index))) then
                watching[spellID] = {GetTime(),"pet",index}
            elseif (not index and spellID) then
                watching[spellID] = {GetTime(),"spell",spellID}
            else
                return
            end
            if (not self:IsMouseEnabled()) then
                self:SetScript("OnUpdate", OnUpdate)
            end
        end
    end
end
DCP:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

function DCP:PLAYER_ENTERING_WORLD()
    local inInstance,instanceType = IsInInstance()
    if (inInstance and instanceType == "arena") then
        self:SetScript("OnUpdate", nil)
        wipe(cooldowns)
        wipe(watching)
    end
end
DCP:RegisterEvent("PLAYER_ENTERING_WORLD")

hooksecurefunc("UseAction", function(slot)
    local actionType,itemID = GetActionInfo(slot)
    if (actionType == "item") then
        local texture = GetActionTexture(slot)
        watching[itemID] = {GetTime(),"item",texture}
    end
end)

hooksecurefunc("UseInventoryItem", function(slot)
    local itemID = GetInventoryItemID("player", slot);
    if (itemID) then
        local texture = GetInventoryItemTexture("player", slot)
        watching[itemID] = {GetTime(),"item",texture}
    end
end)
hooksecurefunc("UseContainerItem", function(bag,slot)
    local itemID = GetContainerItemID(bag, slot)
    if (itemID) then
        local texture = select(10, GetItemInfo(itemID))
        watching[itemID] = {GetTime(),"item",texture}
    end
end)



-------------------
-- Options Frame -- --TOPO replace with elvui
-------------------

SlashCmdList["DOOMCOOLDOWNPULSE"] = function() if (not DCP_OptionsFrame) then DCP:CreateOptionsFrame() end DCP_OptionsFrame:Show() end
SLASH_DOOMCOOLDOWNPULSE1 = "/dcp"
SLASH_DOOMCOOLDOWNPULSE2 = "/cooldownpulse"
SLASH_DOOMCOOLDOWNPULSE3 = "/doomcooldownpulse"

function DCP:CreateOptionsFrame()
    local sliders = {
        { text = "Icon Size", value = "iconSize", min = 30, max = 125, step = 5 },
        { text = "Fade In Time", value = "fadeInTime", min = 0, max = 1.5, step = 0.1 },
        { text = "Fade Out Time", value = "fadeOutTime", min = 0, max = 1.5, step = 0.1 },
        { text = "Max Opacity", value = "maxAlpha", min = 0, max = 1, step = 0.1 },
        { text = "Max Opacity Hold Time", value = "holdTime", min = 0, max = 1.5, step = 0.1 },
        { text = "Animation Scaling", value = "animScale", min = 0, max = 2, step = 0.1 },
    }

    local buttons = {
        { text = "Close", func = function(self) self:GetParent():Hide() end },
        { text = "Test", func = function(self)
            DCP_OptionsFrameButton3:SetText("Unlock")
            DCP:EnableMouse(false)
            RefreshLocals()
            tinsert(animating,{"Interface\\Icons\\Spell_Nature_Earthbind",nil,"Spell Name"})
            DCP:SetScript("OnUpdate", OnUpdate)
            end },
        { text = "Unlock", func = function(self)
            if (self:GetText() == "Unlock") then
                RefreshLocals()
                DCP:SetWidth(iconSize)
                DCP:SetHeight(iconSize)
                self:SetText("Lock")
                DCP:SetScript("OnUpdate", nil)
                DCP:SetAlpha(1)
                DCPT:SetTexture("Interface\\Icons\\Spell_Nature_Earthbind")
                DCP:EnableMouse(true)
            else
                DCP:SetAlpha(0)
                self:SetText("Unlock")
                DCP:EnableMouse(false)
            end end },
        { text = "Defaults", func = function(self)
            for i,v in pairs(defaultSettings) do
                defaultSettings[i] = v
            end
            for i,v in pairs(defaultSettingsPerCharacter) do
                defaultSettingsPerCharacter[i] = v
            end
            for i,v in pairs(sliders) do
                getglobal("DCP_OptionsFrameSlider"..i):SetValue(defaultSettings[v.value])
            end
            DCP_OptionsFramePetColorBox:GetNormalTexture():SetVertexColor(unpack(defaultSettings.petOverlay))
            DCP_OptionsFrameIgnoreTypeButtonWhitelist:SetChecked(false)
            DCP_OptionsFrameIgnoreTypeButtonBlacklist:SetChecked(true)
            DCP_OptionsFrameIgnoreBox:SetText("")
            DCP:ClearAllPoints()
            DCP:SetPoint("CENTER",UIParent,"BOTTOMLEFT",defaultSettings.x,defaultSettings.y)
            end },
    }

    local optionsframe = CreateFrame("frame","DCP_OptionsFrame",UIParent,BackdropTemplateMixin and "BackdropTemplate")
    optionsframe:SetBackdrop({
      bgFile="Interface\\DialogFrame\\UI-DialogBox-Background",
      edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border",
      tile=1, tileSize=32, edgeSize=32,
      insets={left=11, right=12, top=12, bottom=11}
    })
    optionsframe:SetWidth(220)
    optionsframe:SetHeight(540)
    optionsframe:SetPoint("CENTER",UIParent)
    optionsframe:EnableMouse(true)
    optionsframe:SetMovable(true)
    optionsframe:RegisterForDrag("LeftButton")
    optionsframe:SetScript("OnDragStart", function(self) self:StartMoving() end)
    optionsframe:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    optionsframe:SetFrameStrata("FULLSCREEN_DIALOG")
    optionsframe:SetScript("OnHide", function() RefreshLocals() end)
    tinsert(UISpecialFrames, "DCP_OptionsFrame")

    local header = optionsframe:CreateTexture(nil,"ARTWORK")
    header:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header.blp")
    header:SetWidth(350)
    header:SetHeight(68)
    header:SetPoint("TOP",optionsframe,"TOP",0,12)

    local headertext = optionsframe:CreateFontString(nil,"ARTWORK","GameFontNormal")
    headertext:SetPoint("TOP",header,"TOP",0,-14)
    headertext:SetText("Doom_CooldownPulse")

    for i,v in pairs(sliders) do
        local slider = CreateFrame("slider", "DCP_OptionsFrameSlider"..i, optionsframe, "OptionsSliderTemplate")
        if (i == 1) then
            slider:SetPoint("TOP",optionsframe,"TOP",0,-40)
        else
            slider:SetPoint("TOP",getglobal("DCP_OptionsFrameSlider"..(i-1)),"BOTTOM",0,-35)
        end
        local valuetext = slider:CreateFontString(nil,"ARTWORK","GameFontNormalSmall")
        valuetext:SetPoint("TOP",slider,"BOTTOM",0,-1)
        valuetext:SetText(format("%.1f",defaultSettings[v.value]))
        getglobal("DCP_OptionsFrameSlider"..i.."Text"):SetText(v.text)
        getglobal("DCP_OptionsFrameSlider"..i.."Low"):SetText(v.min)
        getglobal("DCP_OptionsFrameSlider"..i.."High"):SetText(v.max)
        slider:SetMinMaxValues(v.min,v.max)
        slider:SetValueStep(v.step)
        slider:SetValue(defaultSettings[v.value])
        slider:SetScript("OnValueChanged",function()
            local val=slider:GetValue() defaultSettings[v.value]=val
            valuetext:SetText(format("%.1f",val))
            if (DCP:IsMouseEnabled()) then
                DCP:SetWidth(defaultSettings.iconSize)
                DCP:SetHeight(defaultSettings.iconSize)
            end end)
    end

    local pettext = optionsframe:CreateFontString(nil,"ARTWORK","GameFontNormalSmall")
    pettext:SetPoint("TOPLEFT","DCP_OptionsFrameSlider"..#sliders,"BOTTOMLEFT",-15,-30)
    pettext:SetText("Pet color overlay:")

    local petcolorselect = CreateFrame('Button',"DCP_OptionsFramePetColorBox",optionsframe)
    petcolorselect:SetPoint("LEFT",pettext,"RIGHT",10,0)
    petcolorselect:SetWidth(20)
    petcolorselect:SetHeight(20)
    petcolorselect:SetNormalTexture('Interface/ChatFrame/ChatFrameColorSwatch')
    petcolorselect:GetNormalTexture():SetVertexColor(unpack(defaultSettings.petOverlay))
    petcolorselect:SetScript("OnEnter",function(self) GameTooltip:SetOwner(self, "ANCHOR_CURSOR") GameTooltip:SetText("Note: Use white if you don't want any overlay for pet cooldowns") end)
    petcolorselect:SetScript("OnLeave",function(self) GameTooltip:Hide() end)
    petcolorselect:SetScript('OnClick', function(self)
        self.r,self.g,self.b = unpack(defaultSettings.petOverlay)
        OpenColorPicker(self)
        ColorPickerFrame:SetPoint("TOPLEFT",optionsframe,"TOPRIGHT")
        end)
    petcolorselect.swatchFunc = function(self) defaultSettings.petOverlay={ColorPickerFrame:GetColorRGB()} petcolorselect:GetNormalTexture():SetVertexColor(ColorPickerFrame:GetColorRGB()) end
    petcolorselect.cancelFunc = function(self) defaultSettings.petOverlay={self.r,self.g,self.b} petcolorselect:GetNormalTexture():SetVertexColor(unpack(defaultSettings.petOverlay)) end

    local petcolorselectbg = petcolorselect:CreateTexture(nil, 'BACKGROUND')
    petcolorselectbg:SetWidth(17)
    petcolorselectbg:SetHeight(17)
    petcolorselectbg:SetTexture(1,1,1)
    petcolorselectbg:SetPoint('CENTER')

    local spellnametext = optionsframe:CreateFontString(nil,"ARTWORK","GameFontNormalSmall")
    spellnametext:SetPoint("TOPLEFT",pettext,"BOTTOMLEFT",0,-18)
    spellnametext:SetText("Show spell name:")

    local spellnamecbt = CreateFrame("CheckButton","DCP_OptionsFrameSpellNameCheckButton",optionsframe,"OptionsCheckButtonTemplate")
    spellnamecbt:SetPoint("LEFT",spellnametext,"RIGHT",6,0)
    spellnamecbt:SetChecked(defaultSettings.showSpellName)
    spellnamecbt:SetScript("OnClick", function(self)
        local newState = self:GetChecked()
        self:SetChecked(newState)
        defaultSettings.showSpellName = newState
        RefreshLocals()
    end)

    local ignoretext = optionsframe:CreateFontString(nil,"ARTWORK","GameFontNormalSmall")
    ignoretext:SetPoint("TOPLEFT",spellnametext,"BOTTOMLEFT",0,-18)
    ignoretext:SetText("Filter spells:")

    local ignoretypebuttonblacklist = CreateFrame("Checkbutton","DCP_OptionsFrameIgnoreTypeButtonBlacklist",optionsframe,"UIRadioButtonTemplate")
    ignoretypebuttonblacklist:SetPoint("TOPLEFT",ignoretext,"BOTTOMLEFT",0,-4)
    ignoretypebuttonblacklist:SetChecked(not defaultSettingsPerCharacter.invertIgnored)
    ignoretypebuttonblacklist:SetScript("OnClick", function()
        DCP_OptionsFrameIgnoreTypeButtonWhitelist:SetChecked(false)
        defaultSettingsPerCharacter.invertIgnored = false
        RefreshLocals()
    end)

    local ignoretypetextblacklist = optionsframe:CreateFontString(nil,"ARTWORK","GameFontNormalSmall")
    ignoretypetextblacklist:SetPoint("LEFT",ignoretypebuttonblacklist,"RIGHT",4,0)
    ignoretypetextblacklist:SetText("Blacklist")

    local ignoretypebuttonwhitelist = CreateFrame("Checkbutton","DCP_OptionsFrameIgnoreTypeButtonWhitelist",optionsframe,"UIRadioButtonTemplate")
    ignoretypebuttonwhitelist:SetPoint("LEFT",ignoretypetextblacklist,"RIGHT",10,0)
    ignoretypebuttonwhitelist:SetChecked(defaultSettingsPerCharacter.invertIgnored)
    ignoretypebuttonwhitelist:SetScript("OnClick", function()
        DCP_OptionsFrameIgnoreTypeButtonBlacklist:SetChecked(false)
        defaultSettingsPerCharacter.invertIgnored = true
        RefreshLocals()
    end)

    local ignoretypetextwhitelist = optionsframe:CreateFontString(nil,"ARTWORK","GameFontNormalSmall")
    ignoretypetextwhitelist:SetPoint("LEFT",ignoretypebuttonwhitelist,"RIGHT",4,0)
    ignoretypetextwhitelist:SetText("Whitelist")

    local ignorebox = CreateFrame("EditBox","DCP_OptionsFrameIgnoreBox",optionsframe,"InputBoxTemplate")
    ignorebox:SetAutoFocus(false)
    ignorebox:SetPoint("TOPLEFT",ignoretypebuttonblacklist,"BOTTOMLEFT",4,2)
    ignorebox:SetWidth(170)
    ignorebox:SetHeight(32)
    ignorebox:SetText(defaultSettingsPerCharacter.ignoredSpells)
    ignorebox:SetScript("OnEnter",function(self) GameTooltip:SetOwner(self, "ANCHOR_CURSOR") GameTooltip:SetText("Note: Separate multiple spells with commas") end)
    ignorebox:SetScript("OnLeave",function(self) GameTooltip:Hide() end)
    ignorebox:SetScript("OnEnterPressed", function(self) self:ClearFocus() end)
    ignorebox:SetScript("OnEditFocusLost",function(self)
        defaultSettingsPerCharacter.ignoredSpells = ignorebox:GetText()
        RefreshLocals()
    end)

    for i,v in pairs(buttons) do
        local button = CreateFrame("Button", "DCP_OptionsFrameButton"..i, optionsframe, "UIPanelButtonTemplate")
        button:SetHeight(24)
        button:SetWidth(75)
        button:SetPoint("BOTTOM", optionsframe, "BOTTOM", ((i%2==0 and -1) or 1)*45, ceil(i/2)*15 + (ceil(i/2)-1)*15)
        button:SetText(v.text)
        button:SetScript("OnClick", function(self) PlaySound(852) v.func(self) end)
    end
end
