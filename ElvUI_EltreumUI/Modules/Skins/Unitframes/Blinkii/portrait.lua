local E = unpack(ElvUI)

local _G = _G
local SetPortraitTexture = _G.SetPortraitTexture
local UnitExists = _G.UnitExists
local tinsert = _G.tinsert
local UF = E:GetModule("UnitFrames")
local UnitGUID = _G.UnitGUID
local select, strsplit = _G.select, _G.strsplit
local mathmax = _G.math.max
local mathmin = _G.math.min
local UnitIsDead = _G.UnitIsDead
local UnitIsPlayer = _G.UnitIsPlayer
local UnitInPartyIsAI = _G.UnitInPartyIsAI
local UnitFactionGroup = _G.UnitFactionGroup
local UnitClass = _G.UnitClass
local UnitReaction = _G.UnitReaction
local UnitClassification = _G.UnitClassification
local InCombatLockdown = _G.InCombatLockdown
local UnitCastingInfo = _G.UnitCastingInfo
local UnitChannelInfo = _G.UnitChannelInfo
local CreateFrame = _G.CreateFrame
local hooksecurefunc = _G.hooksecurefunc

ElvUI_EltreumUI.Portraits = {}
local module = ElvUI_EltreumUI.Portraits
if not module then return end

local colors = {}
local isTrilinear = true
local useTextureColor = false

local bg_textures = {
	[1] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\Blinkii\\bg_1.tga",
	[2] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\Blinkii\\bg_2.tga",
	[3] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\Blinkii\\bg_3.tga",
	[4] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\Blinkii\\bg_4.tga",
	[5] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\Blinkii\\bg_5.tga",
	empty = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\Blinkii\\empty.tga",
	unknown = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\Blinkii\\unknown.tga",
}

local function SetTextures(frame, texture)
	if isTrilinear then
		frame:SetTexture(texture, "CLAMP", "CLAMP", "TRILINEAR")
	else
		frame:SetTexture(texture)
	end
end

local function mirrorTexture(texture, mirror, top)
	if texture.classIcons then
		local coords = texture.classCoords
		if #coords == 8 then
			texture:SetTexCoord(unpack((mirror and { coords[5], coords[6], coords[7], coords[8], coords[1], coords[2], coords[3], coords[4] } or coords)))
		else
			texture:SetTexCoord(unpack((mirror and { coords[2], coords[1], coords[3], coords[4] } or coords)))
		end
	else
		texture:SetTexCoord(mirror and 1 or 0, mirror and 0 or 1, top and 1 or 0, top and 0 or 1)
	end
end

local function setColor(texture, color, mirror)
	if not texture or not color then return end

	if type(color.a) == "table" and type(color.b) == "table" then
		if E.db.ElvUI_EltreumUI.unitframes.portraits.general.gradient then
			local a, b = color.a, color.b
			if mirror and (E.db.ElvUI_EltreumUI.unitframes.portraits.general.ori == "HORIZONTAL") then
				a, b = b, a
			end
			texture:SetGradient(E.db.ElvUI_EltreumUI.unitframes.portraits.general.ori, a, b)
		else
			texture:SetVertexColor(color.a.r, color.a.g, color.a.b, color.a.a)
		end
	elseif color.r and color.g and color.b and color.a then
		texture:SetVertexColor(color.r, color.g, color.b, color.a)
	end
end

local cachedFaction = {}

local function getColor(unit, isPlayer, isDead)
	local defaultColor = colors.default

	if isPlayer == nil then isPlayer = UnitIsPlayer(unit) end

	if E.db.ElvUI_EltreumUI.unitframes.portraits.general.deathcolor and isDead then return colors.death end

	if E.db.ElvUI_EltreumUI.unitframes.portraits.general.default then return defaultColor end

	if isPlayer or (E.Retail and UnitInPartyIsAI(unit)) then
		if E.db.ElvUI_EltreumUI.unitframes.portraits.general.reaction then
			local playerFaction = cachedFaction.player or select(1, UnitFactionGroup("player"))
			cachedFaction.player = playerFaction
			local unitFaction = cachedFaction[UnitGUID(unit)] or select(1, UnitFactionGroup(unit))
			cachedFaction[UnitGUID(unit)] = unitFaction

			return colors[(playerFaction == unitFaction) and "friendly" or "enemy"]
		else
			local _, class = UnitClass(unit)
			return colors[class]
		end
	else
		local reaction = UnitReaction(unit, "player")
		return colors[reaction and ((reaction <= 3) and "enemy" or (reaction == 4) and "neutral" or "friendly") or "enemy"]
	end
end

local function adjustColor(color, shift)
	if not color then return end
	if not shift then return end
	if not color.r then return end
	return {
		r = color.r * shift,
		g = color.g * shift,
		b = color.b * shift,
		a = color.a,
	}
end

local function UpdateIconBackground(tx, unit, mirror)
	local portraits = E.db.ElvUI_EltreumUI.unitframes.portraits
	local shadow = portraits.shadow

	SetTextures(tx, bg_textures[portraits.general.bgstyle])

	local color = shadow.classBG and getColor(unit) or shadow.background
	local ColorShift = shadow.bgColorShift

	if color then
		local bgColor
		if type(color.a) == "table" then
			bgColor = {
				a = adjustColor(color.a, ColorShift),
				b = adjustColor(color.b, ColorShift),
			}
		else
			bgColor = adjustColor(color, ColorShift)
		end

		if bgColor then setColor(tx, bgColor, mirror) end
	end
end

local function DeadDesaturation(self)
	if self.unit_is_dead then
		self.portrait:SetDesaturated(true)
		self.isDesaturated = true
	elseif self.isDesaturated then
		self.portrait:SetDesaturated(false)
		self.isDesaturated = false
	end
end

local function SetPortraits(frame, unit, masking, mirror)
	if E.db.ElvUI_EltreumUI.unitframes.portraits.general.classicons and (UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit))) then
		local class = select(2, UnitClass(unit))
		if not class then return end

		local style = E.db.ElvUI_EltreumUI.unitframes.portraits.general.classiconstyle
		local classIcons = ElvUI_EltreumUI.ClassIcons.mMT[style] or ElvUI_EltreumUI.ClassIcons.Custom[style]

		if not classIcons then
			SetPortraitTexture(frame.portrait, unit, true)
		else
			local defaultTexCoords = ElvUI_EltreumUI.ClassIcons.data
			local coords = classIcons.texCoords and classIcons.texCoords[class] or defaultTexCoords[class].texCoords
			if not coords then return end

			SetTextures(frame.portrait, classIcons.texture)

			frame.portrait.classIcons = unit
			frame.portrait.classCoords = coords
			frame.portrait:SetTexCoord(unpack(coords))
		end
	else
		if frame.portrait.classIcons then
			frame.portrait.classIcons = nil
			frame.portrait.classCoords = nil
		end
		SetPortraitTexture(frame.portrait, unit, true)
	end

	if frame.iconbg then UpdateIconBackground(frame.iconbg, unit, mirror) end

	if E.db.ElvUI_EltreumUI.unitframes.portraits.general.desaturation then DeadDesaturation(frame) end

	mirrorTexture(frame.portrait, mirror)
end

local function GetOffset(size)
	local offset = E.db.ElvUI_EltreumUI.unitframes.portraits.zoom
	if offset == 0 or not offset then
		return 0
	else
		local maxOffset = size / 2
		local zoom = (1 - offset) * size / 2

		zoom = mathmax(-maxOffset, mathmin(zoom, maxOffset))
		return zoom
	end
end

local function UpdateTexture(portraitFrame, textureType, texture, level, color, reverse)
	if not portraitFrame[textureType] then
		portraitFrame[textureType] = portraitFrame:CreateTexture("ElvUI_EltreumUI" .. textureType .. "-" .. portraitFrame.name, "OVERLAY", nil, level)
		portraitFrame[textureType]:SetAllPoints(portraitFrame)
	end

	local mirror = portraitFrame.settings.mirror
	SetTextures(portraitFrame[textureType], texture)
	if reverse ~= nil then mirror = reverse end
	mirrorTexture(portraitFrame[textureType], mirror, portraitFrame.textures.flip)

	if color then setColor(portraitFrame[textureType], color, mirror) end
end

local function UpdateExtraTexture(portraitFrame, classification)
	classification = (classification == "rareelite") and "rare" or classification
	if not classification then return end
	local extraTextures = portraitFrame.textures[classification] and portraitFrame.textures[classification].texture
	SetTextures(portraitFrame.extra, extraTextures)

	-- Border
	if E.db.ElvUI_EltreumUI.unitframes.portraits.shadow.border then
		extraTextures = portraitFrame.textures[classification].border
		SetTextures(portraitFrame.extraBorder, extraTextures)
	end

	-- Shadow
	if E.db.ElvUI_EltreumUI.unitframes.portraits.shadow.enable then
		extraTextures = portraitFrame.textures[classification].shadow
		SetTextures(portraitFrame.extraShadow, extraTextures)
	end
end

local function GetNPCID(unit)
	if ElvUI_EltreumUI:IsThisASafeSecret(nil,true) then
		return " "
	else
		local guid = UnitGUID(unit)
		return guid and select(6, strsplit("-", guid))
	end
end

local function HideRareElite(frame)
	if E.db.ElvUI_EltreumUI.unitframes.portraits.shadow.enable and frame.extraShadow then frame.extraShadow:Hide() end
	if E.db.ElvUI_EltreumUI.unitframes.portraits.shadow.border and frame.extraBorder then frame.extraBorder:Hide() end
	frame.extra:Hide()
end

local simpleClassification = {
	worldboss = "boss",
	rareelite = "rareelite",
	elite = "elite",
	rare = "rare",
}

local function CheckRareElite(frame, unit, unitColor)
	local c = UnitClassification(unit) --"worldboss", "rareelite", "elite", "rare", "normal", "trivial", or "minus"
	local npcID = GetNPCID(unit)
	if not npcID then return end
	local classification = (ElvUI_EltreumUI:GetBossIconTextureAndID(nil,true,npcID) and "boss" or simpleClassification[c])

	if classification then
		local color = useTextureColor and (unitColor or colors[classification]) or colors[classification]

		UpdateExtraTexture(frame, classification)
		setColor(frame.extra, color)
		if E.db.ElvUI_EltreumUI.unitframes.portraits.shadow.enable then
			if frame.extraShadow then frame.extraShadow:Show() end
			if E.db.ElvUI_EltreumUI.unitframes.portraits.shadow.border and frame.extraBorder then
				local borderColor = colors.border[classification] or colors.border.default
				setColor(frame.extraBorder, borderColor)
				frame.extraBorder:Show()
			end
		end
		frame.extra:Show()
	else
		HideRareElite(frame)
	end
end

local function UpdatePortrait(portraitFrame, force)
	-- get textures
	portraitFrame.textures = ElvUI_EltreumUI:GetTextures(portraitFrame.settings.texture)
	portraitFrame.unit = portraitFrame.parent.unit

	local texture, offset
	local setting = portraitFrame.settings
	local unit = force and "player" or (UnitExists(portraitFrame.unit) and portraitFrame.unit or (portraitFrame.parent.unit or "player"))
	local parent = portraitFrame.parent
	local unitColor = getColor(unit)

	-- Portraits Frame
	if not InCombatLockdown() and (setting and setting.point) then
		portraitFrame:SetSize(setting.size, setting.size)
		portraitFrame:ClearAllPoints()
		portraitFrame:SetPoint(setting.point, parent, setting.relativePoint, setting.x, setting.y)

		if setting.strata ~= "AUTO" then portraitFrame:SetFrameStrata(setting.strata) end
		portraitFrame:SetFrameLevel(setting.level)
	end

	-- Portrait Texture
	texture = portraitFrame.textures.texture
	UpdateTexture(portraitFrame, "texture", texture, 4, unitColor)

	-- Unit Portrait
	offset = GetOffset(setting.size)
	UpdateTexture(portraitFrame, "portrait", bg_textures.unknown, 1)
	SetPortraits(portraitFrame, unit, false, setting.mirror)
	portraitFrame.portrait:SetPoint("TOPLEFT", 0 + offset, 0 - offset)
	portraitFrame.portrait:SetPoint("BOTTOMRIGHT", 0 - offset, 0 + offset)

	-- Portrait Mask
	if portraitFrame.textures.extraMask then
		if setting.mirror then
			texture = portraitFrame.textures.mask.b
		else
			texture = portraitFrame.textures.mask.a
		end
	else
		texture = portraitFrame.textures.mask
	end

	if not portraitFrame.mask then
		portraitFrame.mask = portraitFrame:CreateMaskTexture()
		portraitFrame.mask:SetAllPoints(portraitFrame)
		portraitFrame.portrait:AddMaskTexture(portraitFrame.mask)
	end

	portraitFrame.mask:SetTexture(texture, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")

	--local color = (E.db.ElvUI_EltreumUI.unitframes.portraits.shadow.classBG and unitColor or E.db.ElvUI_EltreumUI.unitframes.portraits.shadow.background)
	UpdateTexture(portraitFrame, "iconbg", bg_textures[E.db.ElvUI_EltreumUI.unitframes.portraits.general.bgstyle], -5)
	portraitFrame.iconbg:AddMaskTexture(portraitFrame.mask)
	--end

	-- Portrait Shadow
	if E.db.ElvUI_EltreumUI.unitframes.portraits.shadow.enable then
		texture = portraitFrame.textures.shadow
		UpdateTexture(portraitFrame, "shadow", texture, -4, E.db.ElvUI_EltreumUI.unitframes.portraits.shadow.color)
		portraitFrame.shadow:Show()
	elseif portraitFrame.shadow then
		portraitFrame.shadow:Hide()
	end

	-- Inner Portrait Shadow
	if E.db.ElvUI_EltreumUI.unitframes.portraits.shadow.inner then
		texture = portraitFrame.textures.inner
		UpdateTexture(portraitFrame, "innerShadow", texture, 2, E.db.ElvUI_EltreumUI.unitframes.portraits.shadow.innerColor)
		portraitFrame.innerShadow:Show()
	elseif portraitFrame.innerShadow then
		portraitFrame.innerShadow:Show()
	end

	-- Portrait Border
	if E.db.ElvUI_EltreumUI.unitframes.portraits.shadow.border then
		texture = portraitFrame.textures.border
		UpdateTexture(portraitFrame, "border", texture, 2, colors.border.default)
	end

	-- Rare/Elite Texture
	if setting.extraEnable then
		-- Texture
		texture = portraitFrame.textures.rare.texture
		UpdateTexture(portraitFrame, "extra", texture, -6, colors.border.default, not portraitFrame.settings.mirror)

		-- Border
		if E.db.ElvUI_EltreumUI.unitframes.portraits.shadow.border then
			texture = portraitFrame.textures.rare.border
			UpdateTexture(portraitFrame, "extraBorder", texture, -7, colors.border.default, not portraitFrame.settings.mirror)
			portraitFrame.extraBorder:Hide()
		end

		-- Shadow
		if E.db.ElvUI_EltreumUI.unitframes.portraits.shadow.enable then
			texture = portraitFrame.textures.rare.shadow
			UpdateTexture(portraitFrame, "extraShadow", texture, -8, E.db.ElvUI_EltreumUI.unitframes.portraits.shadow.color, not portraitFrame.settings.mirror)
			portraitFrame.extraShadow:Hide()
		end

		CheckRareElite(portraitFrame, unit, unitColor)
	end

	-- Corner
	if portraitFrame.textures.corner then
		texture = portraitFrame.textures.corner.texture
		UpdateTexture(portraitFrame, "corner", texture, 5, unitColor)

		-- Border
		if E.db.ElvUI_EltreumUI.unitframes.portraits.shadow.border then
			texture = portraitFrame.textures.corner.border
			UpdateTexture(portraitFrame, "cornerBorder", texture, 6, colors.border.default)
			portraitFrame.cornerBorder:Show()
		end

		portraitFrame.corner:Show()
	elseif portraitFrame.corner then
		portraitFrame.corner:Hide()

		if portraitFrame.cornerBorder then portraitFrame.cornerBorder:Hide() end
	end
end

local function SetCastEvents(portrait, unregistering)
	local castEvents = { "UNIT_SPELLCAST_START", "UNIT_SPELLCAST_CHANNEL_START", "UNIT_SPELLCAST_INTERRUPTED", "UNIT_SPELLCAST_STOP", "UNIT_SPELLCAST_CHANNEL_STOP" }
	local empowerEvents = { "UNIT_SPELLCAST_EMPOWER_START", "UNIT_SPELLCAST_EMPOWER_STOP" }

	if unregistering then
		for _, event in pairs(castEvents) do
			portrait:UnregisterEvent(event)
		end

		if E.Retail then
			for _, event in pairs(empowerEvents) do
				portrait:UnregisterEvent(event)
			end
		end
	else
		for _, event in pairs(castEvents) do
			if portrait.isPartyFrame then
				portrait:RegisterEvent(event)
			else
				portrait:RegisterUnitEvent(event, portrait.unit)
			end
			tinsert(portrait.allEvents, event)
		end

		if E.Retail then
			for _, event in pairs(empowerEvents) do
				if portrait.isPartyFrame then
					portrait:RegisterEvent(event)
				else
					portrait:RegisterUnitEvent(event, portrait.unit)
				end
				tinsert(portrait.allEvents, event)
			end
		end
	end
end

local function SetScripts(portrait, force)
	if not portrait.isBuild then
		-- party event
		if portrait.isPartyFrame then
			-- events for all party frames
			local partyEvents = { "GROUP_ROSTER_UPDATE", "PARTY_MEMBER_ENABLE", "UNIT_MODEL_CHANGED", "UNIT_PORTRAIT_UPDATE", "UNIT_CONNECTION" }
			for _, event in ipairs(partyEvents) do
				portrait:RegisterEvent(event)
				tinsert(portrait.allEvents, event)
			end

			-- events for cast icon
			if portrait.settings.cast then
				SetCastEvents(portrait)
				portrait.castEventsSet = true
			end
		else
			-- specific events for unit
			local unitEvents = { "UNIT_MODEL_CHANGED", "UNIT_PORTRAIT_UPDATE", "UNIT_CONNECTION" }

			for _, event in ipairs(unitEvents) do
				portrait:RegisterUnitEvent(event, portrait.unit)
				tinsert(portrait.allEvents, event)
			end

			if E.db.ElvUI_EltreumUI.unitframes.portraits.general.desaturation then
				local healthEvent = "UNIT_HEALTH"
				portrait:RegisterUnitEvent(healthEvent, portrait.unit)
				tinsert(portrait.allEvents, healthEvent)
			end

			-- specific events for player and pet if player is in vehicle
			if E.Retail or E.Mists then
				if portrait.unit == "player" then
					portrait:RegisterEvent("VEHICLE_UPDATE")
					tinsert(portrait.allEvents, "VEHICLE_UPDATE")
					portrait:RegisterUnitEvent("UNIT_ENTERED_VEHICLE", portrait.unit)
					tinsert(portrait.allEvents, "UNIT_ENTERED_VEHICLE")
					portrait:RegisterUnitEvent("UNIT_EXITED_VEHICLE", portrait.unit)
					tinsert(portrait.allEvents, "UNIT_EXITED_VEHICLE")
				end
				if portrait.unit == "pet" then
					portrait:RegisterEvent("VEHICLE_UPDATE")
					tinsert(portrait.allEvents, "VEHICLE_UPDATE")
				end
			end

			if portrait.events then
				for _, event in pairs(portrait.events) do
					portrait:RegisterUnitEvent(event)
					tinsert(portrait.allEvents, event)
				end
			end

			if portrait.unitEvents then
				for _, event in pairs(portrait.unitEvents) do
					portrait:RegisterUnitEvent(event, event == "UNIT_TARGET" and "target" or portrait.unit)
					tinsert(portrait.allEvents, event)
				end
			end

			-- events for cast icon
			if portrait.settings.cast then
				SetCastEvents(portrait)
				portrait.castEventsSet = true
			end
		end

		-- events for all units
		portrait:RegisterEvent("PLAYER_ENTERING_WORLD")
		tinsert(portrait.allEvents, "PLAYER_ENTERING_WORLD")
		portrait:RegisterEvent("PORTRAITS_UPDATED")
		tinsert(portrait.allEvents, "PORTRAITS_UPDATED")

		--disable due to overlapping with other elements and blocking chat for example
		--[[
		-- scripts to interact with mouse
		portrait:SetAttribute("unit", portrait.unit)
		portrait:SetAttribute("*type1", "target")
		portrait:SetAttribute("*type2", "togglemenu")
		portrait:SetAttribute("type3", "focus")
		portrait:SetAttribute("toggleForVehicle", true)
		portrait:SetAttribute("ping-receiver", true)
		portrait:RegisterForClicks("AnyUp")]]

		portrait.isBuild = true
	end

	-- update cast events
	if force then
		if portrait.settings.cast and not portrait.castEventsSet then
			SetCastEvents(portrait)
			portrait.castEventsSet = true
		elseif portrait.castEventsSet then
			SetCastEvents(portrait, true)
			portrait.castEventsSet = false
		end
	end
end

local function UpdateAllPortraits(force)
	local units = {
		"Player",
		"Target",
		"Pet",
		"Focus",
		"TargetTarget",
		"Party1",
		"Party2",
		"Party3",
		"Party4",
		"Party5",
		"Arena1",
		"Arena2",
		"Arena3",
		"Arena4",
		"Arena5",
		"Boss1",
		"Boss2",
		"Boss3",
		"Boss4",
		"Boss5",
		"Boss6",
		"Boss7",
		"Boss8",
	}
	for _, name in ipairs(units) do
		if module[name] then
			UpdatePortrait(module[name])

			-- update for demo frames
			if force then SetScripts(module[name], force) end
		end
	end
end

local function CastIcon(self)
	-- local texture = select(3, UnitCastingInfo(self.unit))

	-- if not texture then texture = select(3, UnitChannelInfo(self.unit)) end
	return select(3, UnitCastingInfo(self.unit)) or select(3, UnitChannelInfo(self.unit))
end

local function AddCastIcon(self)
	local texture = CastIcon(self)
	if texture then
		self.portrait:SetTexture(texture)
		if self.portrait.classIcons then
			self.portrait.classIcons = nil
			self.portrait.classCoords = nil
		end

		mirrorTexture(self.portrait, self.settings.mirror)
	end
end

local function RemovePortrait(unitPortrait)
	if unitPortrait and unitPortrait.allEvents then
		for _, event in pairs(unitPortrait.allEvents) do
			unitPortrait:UnregisterEvent(event)
		end
	end

	unitPortrait:Hide()
	unitPortrait = nil
end

local castStarted = {
	UNIT_SPELLCAST_START = true,
	UNIT_SPELLCAST_CHANNEL_START = true,
	UNIT_SPELLCAST_EMPOWER_START = true,
}

local castStopped = {
	UNIT_SPELLCAST_INTERRUPTED = true,
	UNIT_SPELLCAST_STOP = true,
	UNIT_SPELLCAST_CHANNEL_STOP = true,
	UNIT_SPELLCAST_EMPOWER_STOP = true,
}

local function UpdatePortraitTexture(self, unit)
	if not InCombatLockdown() and self:GetAttribute("unit") ~= unit then self:SetAttribute("unit", unit) end
	local isPlayer = UnitIsPlayer(unit)
	local unitColor = getColor(unit, isPlayer, self.unit_is_dead)

	SetPortraits(self, unit, false, self.settings.mirror)
	setColor(self.texture, unitColor, self.settings.mirror)

	if E.db.ElvUI_EltreumUI.unitframes.portraits.general.corner and self.textures.corner then setColor(self.corner, unitColor, self.settings.mirror) end

	if self.settings.extraEnable and self.extra and not isPlayer then
		CheckRareElite(self, unit, unitColor)
	elseif self.extra then
		HideRareElite(self)
	end
end

local function UnitEvent(self, event)
	local unit = self.unit

	if E.db.ElvUI_EltreumUI.unitframes.portraits.general.desaturation or E.db.ElvUI_EltreumUI.unitframes.portraits.general.deathcolor then self.unit_is_dead = UnitIsDead(unit) end

	if castStopped[event] or (self.isCasting and not CastIcon(self)) then
		self.isCasting = false
		UpdatePortraitTexture(self, unit)
	elseif self.isCasting or castStarted[event] then
		if self.settings.cast or self.isCasting then
			self.empowering = (event == "UNIT_SPELLCAST_EMPOWER_START")
			self.isCasting = true

			AddCastIcon(self)
		end
	else
		UpdatePortraitTexture(self, unit)
	end
end

local function shouldHandleEvent(event, eventUnit, self)
	return (event == "UNIT_TARGET" and (eventUnit == "player" or eventUnit == "target" or eventUnit == "targettarget"))
		or (event == "PLAYER_TARGET_CHANGED" and (self.unit == "target" or self.unit == "targettarget"))
		or event == "PLAYER_FOCUS_CHANGED" and self.parent.unit == "focus"
		or eventUnit == self.unit
end

local forceUpdateParty = {
	UNIT_CONNECTION = true,
	GROUP_ROSTER_UPDATE = true,
	PARTY_MEMBER_ENABLE = true,
	PORTRAITS_UPDATED = true,
}

local function PartyUnitOnEvent(self, event, eventUnit)
	if not UnitExists(self.parent.unit) then return end

	if event == "UNIT_HEALTH" and eventUnit == self.unit then DeadDesaturation(self) end

	self.unit = self.parent.unit

	if E.db.ElvUI_EltreumUI.unitframes.portraits.general.desaturation and not self.eventDesaturationIsSet then
		self:RegisterUnitEvent("UNIT_HEALTH", self.unit)
		tinsert(self.allEvents, "UNIT_HEALTH")
		self.eventDesaturationIsSet = true
	end

	if event == "GROUP_ROSTER_UPDATE" then
		-- force party portraits update
		for i = 1, 5 do
			module["Party" .. i].unit = module["Party" .. i].parent.unit
			UnitEvent(module["Party" .. i], event)
		end
	elseif eventUnit == self.unit or forceUpdateParty[event] then
		UnitEvent(self, event)
	end
end

local function BossUnitOnEvent(self, event, eventUnit)
	if not UnitExists(self.parent.unit) then return end

	if event == "UNIT_HEALTH" and eventUnit == self.unit then DeadDesaturation(self) end

	if eventUnit == self.unit or event == "INSTANCE_ENCOUNTER_ENGAGE_UNIT" or event == "PORTRAITS_UPDATED" then UnitEvent(self, event) end
end

local function PlayerPetUnitOnEvent(self, event, eventUnit)
	if not UnitExists(self.parent.unit) then return end

	if event == "UNIT_HEALTH" and eventUnit == self.unit then DeadDesaturation(self) end

	if eventUnit == "vehicle" or _G.ElvUF_Player.unit == "vehicle" then
		self.unit = (self.parent.realUnit == "player") and "pet" or "player"
	else
		self.unit = self.parent.unit
	end

	if eventUnit == self.unit or _G.ElvUF_Player.unit == "vehicle" or event == "UNIT_EXITED_VEHICLE" or event == "UNIT_ENTERED_VEHICLE" or event == "VEHICLE_UPDATE" then UnitEvent(self, event) end
end

local function OtherUnitOnEvent(self, event, eventUnit)
	if not UnitExists(self.unit) then return end

	if event == "UNIT_HEALTH" and eventUnit == self.unit then DeadDesaturation(self) end

	if shouldHandleEvent(event, eventUnit, self) then UnitEvent(self, event) end
end

local function CreatePortraits(name, unit, parentFrame, unitSettings, events, unitEvents)
	local partyFrames = {
		Party1 = true,
		Party2 = true,
		Party3 = true,
		Party4 = true,
		Party5 = true,
	}
	local bossFrames = {
		Boss1 = true,
		Boss2 = true,
		Boss3 = true,
		Boss4 = true,
		Boss5 = true,
		Boss6 = true,
		Boss7 = true,
		Boss8 = true,
	}

	if not module[name] then
		module[name] = CreateFrame("Button", "ElvUI_EltreumUI_Portrait_" .. name, parentFrame, "SecureUnitButtonTemplate") -- CreatePortrait(parentFrame, unitSettings, unit)
		module[name].parent = parentFrame
		module[name].unit = unit
		module[name].isPartyFrame = partyFrames[name]
		module[name].isBossFrame = bossFrames[name]
		module[name].events = events or nil
		module[name].unitEvents = unitEvents or nil
		module[name].allEvents = {}
		module[name].name = name
	end

	-- update settings
	module[name].settings = unitSettings
	module[name].textures = ElvUI_EltreumUI:GetTextures(unitSettings.texture)

	-- add event function
	if module[name] and not module[name].scriptsSet then
		if module[name].isPartyFrame then
			module[name]:SetScript("OnEvent", PartyUnitOnEvent)
		elseif module[name].isBossFrame then
			module[name]:SetScript("OnEvent", BossUnitOnEvent)
		elseif name == "Player" or name == "Pet" then
			module[name]:SetScript("OnEvent", PlayerPetUnitOnEvent)
		else
			module[name]:SetScript("OnEvent", OtherUnitOnEvent)
		end

		SetScripts(module[name])
		module[name].scriptsSet = true
	end

	-- Update Portrait
	UpdatePortrait(module[name])
end

local function ToggleForceShowGroupFrames(_, group, numGroup)
	if group == "boss" or group == "arena" then
		local name = (group == "boss") and "Boss" or "Arena"

		for i = 1, numGroup do
			if module[name .. i] then UpdatePortrait(module[name .. i], true) end
		end
	end
end

local function HeaderConfig(_, header, configMode)
	if header.groups and header.groupName == "party" then
		for i = 1, #header.groups[1] do
			if module["Party" .. i] then UpdatePortrait(module["Party" .. i], true) end
		end
	end
end

function ElvUI_EltreumUI:InitializePortraits(force)
	--update settings
	isTrilinear = E.db.ElvUI_EltreumUI.unitframes.portraits.general.trilinear
	useTextureColor = E.db.ElvUI_EltreumUI.unitframes.portraits.general.usetexturecolor

	-- update colors
	colors = E.db.ElvUI_EltreumUI.unitframes.portraits.colors

	-- initialize portraits
	if E.db.ElvUI_EltreumUI.unitframes.portraits.general.enable then
		if _G.ElvUF_Player and E.db.ElvUI_EltreumUI.unitframes.portraits.player.enable then
			CreatePortraits("Player", "player", _G.ElvUF_Player, E.db.ElvUI_EltreumUI.unitframes.portraits.player)
		elseif module.Player then
			RemovePortrait(module.Player)
		end

		if _G.ElvUF_Target and E.db.ElvUI_EltreumUI.unitframes.portraits.target.enable then
			CreatePortraits("Target", "target", _G.ElvUF_Target, E.db.ElvUI_EltreumUI.unitframes.portraits.target, { "PLAYER_TARGET_CHANGED" })
		elseif module.Target then
			RemovePortrait(module.Target)
		end

		if _G.ElvUF_Pet and E.db.ElvUI_EltreumUI.unitframes.portraits.pet.enable then
			CreatePortraits("Pet", "pet", _G.ElvUF_Pet, E.db.ElvUI_EltreumUI.unitframes.portraits.pet)
		elseif module.Pet then
			RemovePortrait(module.Pet)
		end

		if _G.ElvUF_TargetTarget and E.db.ElvUI_EltreumUI.unitframes.portraits.targettarget.enable then
			CreatePortraits("TargetTarget", "targettarget", _G.ElvUF_TargetTarget, E.db.ElvUI_EltreumUI.unitframes.portraits.targettarget, { "PLAYER_TARGET_CHANGED" }, { "UNIT_TARGET" })
		elseif module.TargetTarget then
			RemovePortrait(module.TargetTarget)
		end

		if _G.ElvUF_Focus and E.db.ElvUI_EltreumUI.unitframes.portraits.focus.enable then
			CreatePortraits("Focus", "focus", _G.ElvUF_Focus, E.db.ElvUI_EltreumUI.unitframes.portraits.focus, { "PLAYER_FOCUS_CHANGED" })
		elseif module.Focus then
			RemovePortrait(module.Focus)
		end

		if _G.ElvUF_PartyGroup1UnitButton1 and E.db.ElvUI_EltreumUI.unitframes.portraits.party.enable then
			for i = 1, 5 do
				CreatePortraits("Party" .. i, _G["ElvUF_PartyGroup1UnitButton" .. i].unit, _G["ElvUF_PartyGroup1UnitButton" .. i], E.db.ElvUI_EltreumUI.unitframes.portraits.party)
			end
		elseif module.Party1 then
			for i = 1, 5 do
				RemovePortrait(module["Party" .. i])
			end
		end

		if _G.ElvUF_Boss1 and E.db.ElvUI_EltreumUI.unitframes.portraits.boss.enable then
			for i = 1, 8 do
				if _G["ElvUF_Boss" .. i] then
					CreatePortraits("Boss" .. i, _G["ElvUF_Boss" .. i].unit, _G["ElvUF_Boss" .. i], E.db.ElvUI_EltreumUI.unitframes.portraits.boss, { "INSTANCE_ENCOUNTER_ENGAGE_UNIT", "UNIT_TARGETABLE_CHANGED" })
				end
			end
		elseif module.Boss1 then
			for i = 1, 8 do
				RemovePortrait(module["Boss" .. i])
			end
		end

		if _G.ElvUF_Arena1 and E.db.ElvUI_EltreumUI.unitframes.portraits.arena.enable then
			for i = 1, 5 do
				CreatePortraits("Arena" .. i, _G["ElvUF_Arena" .. i].unit, _G["ElvUF_Arena" .. i], E.db.ElvUI_EltreumUI.unitframes.portraits.arena, { "ARENA_OPPONENT_UPDATE" }, { "UNIT_NAME_UPDATE" })

				if E.Retail then tinsert(module["Arena" .. i].events, "ARENA_PREP_OPPONENT_SPECIALIZATIONS") end
			end
		elseif module.Arena1 then
			for i = 1, 5 do
				RemovePortrait(module["Arena" .. i])
			end
		end

		-- update all portraits, force = update cast events
		UpdateAllPortraits(force)

		-- for demo frames - party, boss & arena
		if not module.needReloadUI then
			hooksecurefunc(UF, "ToggleForceShowGroupFrames", ToggleForceShowGroupFrames)
			hooksecurefunc(UF, "HeaderConfig", HeaderConfig)
			module.needReloadUI = true
		end
	else
		for _, unitPortrait in pairs(module) do
			if type(unitPortrait) == "table" and unitPortrait.portrait then RemovePortrait(unitPortrait) end
		end
	end

	module.loaded = E.db.ElvUI_EltreumUI.unitframes.portraits.general.enable
end
