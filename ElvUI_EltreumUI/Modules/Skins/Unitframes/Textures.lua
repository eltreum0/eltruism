local E = unpack(ElvUI)
local UF = E:GetModule('UnitFrames')
local _G = _G
local UnitExists = _G.UnitExists
local UnitClass = _G.UnitClass
local UnitReaction = _G.UnitReaction
local UnitIsPlayer = _G.UnitIsPlayer
local UnitIsTapDenied = _G.UnitIsTapDenied
local UnitPlayerControlled = _G.UnitPlayerControlled
local UnitIsCharmed = _G.UnitIsCharmed
local UnitInPartyIsAI = _G.UnitInPartyIsAI
local UnitCanAttack = _G.UnitCanAttack
local UnitIsEnemy = _G.UnitIsEnemy
local UnitIsFriend = _G.UnitIsFriend
local UnitInParty = _G.UnitInParty
local UnitInRaid = _G.UnitInRaid
local type = _G.type
local select = _G.select
local string = _G.string
local strfind = string.find
local canaccessvalue = _G.canaccessvalue
local IsEncounterInProgress = _G.IsEncounterInProgress

local gradientEnableTable = {
	player = "enableplayer",
	target = "enabletarget",
	targettarget = "enabletargettarget",
	targettargettarget = "enabletargettargettarget",
	pet = "enablepet",
	boss = "enableboss",
	boss1 = "enableboss1",
	boss2 = "enableboss2",
	boss3 = "enableboss3",
	boss4 = "enableboss4",
	boss5 = "enableboss5",
	boss6 = "enableboss6",
	boss7 = "enableboss7",
	boss8 = "enableboss8",
	focus = "enablefocus",
	focustarget = "enablefocustarget",
	arena = "enablearena",
	arena1 = "enablearena1",
	arena2 = "enablearena2",
	arena3 = "enablearena3",
	arena4 = "enablearena4",
	arena5 = "enablearena5",
}

local customTextureTable = {
	player = "playertexture",
	target = "targettexture",
	targettarget = "targettargettexture",
	targettargettarget = "targettargettargettexture",
	pet = "pettexture",
	boss = "bosstexture",
	focus = "focustexture",
	focustarget = "focustargettexture",
	arena = "arenatexture",
}

local function GetGradientEnableKey(unit)
	if not unit then return nil end
	local key = gradientEnableTable[unit]
	if not key then
		key = "enable"..unit
		gradientEnableTable[unit] = key
	end
	return key
end

local function GetCustomTextureKey(unit)
	if not unit then return nil end
	local key = customTextureTable[unit]
	if not key then
		key = unit.."texture"
		customTextureTable[unit] = key
	end
	return key
end

local function ApplyHealthTextures(UFdb, elvDB, health, healthTexture, isTransparent, shouldFlip, hasDebuff, hasBackdropGradient, barTex)
	barTex = barTex or health:GetStatusBarTexture()
	local backdropTex = health.backdropTex
	local bg = health.bg
	local ufCustom = UFdb.ufcustomtexture
	local isHidden = ufCustom.backdrophidden
	local textureVersion = ElvUI_EltreumUI.EltruismTextureVersion
	local isTextureCached = (health.EltruismTextureVersion == textureVersion)
	local mode = UFdb.darkmode and 2 or (UFdb.lightmode and 1 or 0)
	local rawAlpha = ufCustom.backdropalpha or 1
	local backdropAlpha = isHidden and 0 or rawAlpha
	local healthAlpha = isTransparent and (ufCustom.healthalpha or 1) or 1
	local staticSize = ufCustom.backdroptexturestaticsize
	local isStatic = not not staticSize
	local defaultTexName = elvDB.statusbar or UF.db.statusbar
	local bgTexName = ufCustom.backdroptexture or elvDB.statusbar

	if mode == 2 then
		if isTransparent then
			if barTex and (not isTextureCached or health.EltruismBarTexture ~= "__COLOR_ZERO") then
				barTex:SetColorTexture(0, 0, 0, 0)
				health.EltruismBarTexture = "__COLOR_ZERO"
				health.EltruismBarTexName = nil
			end
		else
			if barTex and defaultTexName and (not isTextureCached or health.EltruismBarTexName ~= defaultTexName or not health.EltruismBarTexture or health.EltruismBarTexture == "__COLOR_ZERO") then
				local defaultTex = (elvDB.statusbar and E.LSM:Fetch("statusbar", elvDB.statusbar)) or (UF.db.statusbar and E.LSM:Fetch("statusbar", UF.db.statusbar))
				if defaultTex then
					if health.EltruismBarTexture ~= defaultTex then
						barTex:SetTexture(defaultTex)
						health.EltruismBarTexture = defaultTex
					end
					health.EltruismBarTexName = defaultTexName
				end
			end
		end
		if backdropTex and healthTexture and (not isTextureCached or health.EltruismBackdropTexture ~= healthTexture) then
			backdropTex:SetTexture(healthTexture)
			health.EltruismBackdropTexture = healthTexture
		end
		local center = health.backdrop and health.backdrop.Center
		if center and not isHidden and bgTexName then
			if not isTextureCached or health.EltruismCenterTexName ~= bgTexName or (shouldFlip ~= nil and health.EltruismCenterFlip ~= shouldFlip) then
				local backdropTexture = (ufCustom.backdroptexture and E.LSM:Fetch("statusbar", ufCustom.backdroptexture)) or (elvDB.statusbar and E.LSM:Fetch("statusbar", elvDB.statusbar))
				if backdropTexture then
					if not isTextureCached or health.EltruismCenterTexture ~= backdropTexture then
						center:SetTexture(backdropTexture)
						health.EltruismCenterTexture = backdropTexture
					end
					health.EltruismCenterTexName = bgTexName
					if shouldFlip ~= nil and (not isTextureCached or health.EltruismCenterFlip ~= shouldFlip) then
						if shouldFlip then
							center:SetTexCoord(1, 0, 0, 1)
						else
							center:SetTexCoord(0, 1, 0, 1)
						end
						health.EltruismCenterFlip = shouldFlip
					end
				end
			end
		end
	elseif mode == 1 then
		if barTex and healthTexture and (not isTextureCached or health.EltruismBarTexture ~= healthTexture) then
			barTex:SetTexture(healthTexture)
			health.EltruismBarTexture = healthTexture
		end
		if bg and not isHidden and bgTexName then
			if not isTextureCached or health.EltruismBgTexName ~= bgTexName or health.EltruismBgStatic ~= isStatic or (isStatic and shouldFlip ~= nil and health.EltruismBgFlip ~= shouldFlip) then
				local backdropTexture = (ufCustom.backdroptexture and E.LSM:Fetch("statusbar", ufCustom.backdroptexture)) or (elvDB.statusbar and E.LSM:Fetch("statusbar", elvDB.statusbar))
				if backdropTexture then
					if not isTextureCached or health.EltruismBgTexture ~= backdropTexture then
						bg:SetTexture(backdropTexture)
						health.EltruismBgTexture = backdropTexture
					end
					health.EltruismBgTexName = bgTexName
					if isStatic then
						if not isTextureCached or not health.EltruismBgStatic then
							bg:SetAllPoints(health)
							health.EltruismBgStatic = true
						end
						if shouldFlip ~= nil and (not isTextureCached or health.EltruismBgFlip ~= shouldFlip) then
							if shouldFlip then
								bg:SetTexCoord(1, 0, 0, 1)
							else
								bg:SetTexCoord(0, 1, 0, 1)
							end
							health.EltruismBgFlip = shouldFlip
						end
					else
						health.EltruismBgStatic = false
					end
				end
			end
		end
	end

	health.EltruismTextureVersion = textureVersion

	if not isTextureCached
		or health.EltruismAlphaMode ~= mode
		or health.EltruismAlphaTransparent ~= isTransparent
		or health.EltruismAlphaHidden ~= isHidden
		or health.EltruismAlphaStatic ~= staticSize
		or health.EltruismAlphaRaw ~= rawAlpha
		or health.EltruismAlphaHealth ~= healthAlpha then
		health.EltruismAlphaMode = mode
		health.EltruismAlphaTransparent = isTransparent
		health.EltruismAlphaHidden = isHidden
		health.EltruismAlphaStatic = staticSize
		health.EltruismAlphaRaw = rawAlpha
		health.EltruismAlphaHealth = healthAlpha
		ElvUI_EltreumUI.ApplyBackdropAlphas(UFdb, bg, health.backdrop, backdropTex, isTransparent, barTex, true, health)
	elseif mode == 1 and bg and not isHidden and not hasDebuff and not hasBackdropGradient then
		bg:SetVertexColor(0, 0, 0, backdropAlpha)
	end
end

--set the textures for single units
function ElvUI_EltreumUI:ApplyUnitCustomTexture(unit,name,unittexture,noOrientation,frame,hasBackdropGradient,needColorClass)
	if not UnitExists(unit) then return end
	local unitframe = frame or _G["ElvUF_"..name]
	local health = unitframe and unitframe.Health
	local barTex = health and health:GetStatusBarTexture()
	if not barTex then return end

	local UFdb = E.db.ElvUI_EltreumUI.unitframes
	local elvDB = E.db.unitframe

	local isPlayer = UnitIsPlayer(unit)
	isPlayer = (canaccessvalue(isPlayer) and isPlayer) or (E.Retail and UnitInPartyIsAI(unit))
	local isActualPlayer = false
	local classunit, reaction

	if unitframe.realUnit then
		if name == "Player" and unitframe.__unit == "vehicle" then
			isPlayer = false
			isActualPlayer = false
		elseif name == "Pet" and unitframe.__unit == "player" then
			isPlayer = true
			isActualPlayer = true
			classunit = E.myclass
		end
	end

	local hasClass, hasReaction
	local isCharmed = false
	if isPlayer then
		if not classunit then
			local _, unitClass = UnitClass(unit)
			classunit = unitClass
		end
		hasClass = classunit and canaccessvalue(classunit)
		if not isActualPlayer then
			local charmed = UnitIsCharmed(unit)
			isCharmed = canaccessvalue(charmed) and charmed or false
		end
		if not hasClass or isCharmed then
			reaction = UnitReaction(unit, "player")
			hasReaction = reaction and canaccessvalue(reaction)
		end
	else
		reaction = UnitReaction(unit, "player")
		hasReaction = reaction and canaccessvalue(reaction)
		if not hasReaction then
			local _, unitClass = UnitClass(unit)
			classunit = unitClass
			hasClass = classunit and canaccessvalue(classunit)
		end
	end

	if not hasClass and not hasReaction then return end

	local targetUFOrientation = UFdb.UForientation
	if not noOrientation and targetUFOrientation and health.EltruismOrientation ~= targetUFOrientation then
		health:SetOrientation(targetUFOrientation)
		health.EltruismOrientation = targetUFOrientation
	end

	local ufCustom = UFdb.ufcustomtexture
	local grad = UFdb.gradientmode
	local gradUnitEnabled = grad.enable and (grad[GetGradientEnableKey(unit)] or grad[GetGradientEnableKey(unittexture)])
	local resolveClass = needColorClass or (ufCustom.enable and ufCustom.classdetect) or (UFdb.uftextureversion and UFdb.uftextureversion ~= "NONE")

	local colorClass
	if (isPlayer and not isCharmed) or isActualPlayer then
		colorClass = hasClass and classunit or (E.myclass or "ELTRUISM")
	elseif resolveClass then
		local isTap = UnitIsTapDenied(unit)
		isTap = canaccessvalue(isTap) and isTap
		local isPlayerControlled = UnitPlayerControlled(unit)
		isPlayerControlled = canaccessvalue(isPlayerControlled) and isPlayerControlled

		if isTap and not isPlayerControlled then
			colorClass = "TAPPED"
		else
			if hasReaction then
				if reaction >= 5 then
					colorClass = "NPCFRIENDLY"
				elseif reaction == 4 then
					colorClass = "NPCNEUTRAL"
				elseif reaction == 3 then
					colorClass = "NPCUNFRIENDLY"
				elseif reaction <= 2 then
					colorClass = "NPCHOSTILE"
				end
			end
			if not colorClass then
				local canAttack = UnitCanAttack("player", unit)
				if canaccessvalue(canAttack) and canAttack then
					colorClass = "NPCHOSTILE"
				else
					local isEnemy = UnitIsEnemy("player", unit)
					if canaccessvalue(isEnemy) and isEnemy then
						colorClass = "NPCHOSTILE"
					else
						local isFriend = UnitIsFriend("player", unit)
						if canaccessvalue(isFriend) and isFriend then
							colorClass = "NPCFRIENDLY"
						else
							colorClass = "NPCHOSTILE"
						end
					end
				end
			end
		end
	else
		colorClass = "ELTRUISM"
	end

	local mode = UFdb.darkmode and 2 or (UFdb.lightmode and 1 or 0)
	local isHidden = ufCustom.backdrophidden
	local isTransparent = (health.isTransparent ~= nil and health.isTransparent) or elvDB.colors.transparentHealth
	local shouldFlip = ufCustom.fliptargetbackdrop and name == 'Target'
	local textureVersion = ElvUI_EltreumUI.EltruismTextureVersion

	if health.EltruismTextureVersion == textureVersion
		and health.EltruismAppliedClass == colorClass
		and health.EltruismAppliedUnitTex == unittexture
		and health.EltruismAppliedMode == mode
		and health.EltruismCustomTexEnable == ufCustom.enable
		and health.EltruismClassDetect == ufCustom.classdetect
		and health.EltruismGradEnable == gradUnitEnabled
		and health.EltruismAppliedFlip == shouldFlip
		and health.EltruismAlphaTransparent == isTransparent
		and health.EltruismAlphaHidden == isHidden then
		if mode == 1 and not isHidden and not unitframe.EltruismDebuffExists and not hasBackdropGradient and health.bg then
			health.bg:SetVertexColor(0, 0, 0, ufCustom.backdropalpha or 1)
		end
		return colorClass, isPlayer, hasClass and classunit or nil, hasReaction and reaction or nil
	end

	local healthTexture
	if (isPlayer and not isCharmed) or isActualPlayer then
		if ufCustom.enable then
			if ufCustom.classdetect then
				healthTexture = ElvUI_EltreumUI:UnitframeClassTextureCustom(colorClass)
			else
				local customTex = ufCustom[GetCustomTextureKey(unittexture)]
				healthTexture = E.LSM:Fetch("statusbar", customTex or elvDB.statusbar or UF.db.statusbar)
			end
		elseif gradUnitEnabled then
			local texKey = grad.useUFtexture and (elvDB.statusbar or UF.db.statusbar) or (grad.texture or elvDB.statusbar or UF.db.statusbar)
			healthTexture = E.LSM:Fetch("statusbar", texKey)
		elseif UFdb.uftextureversion and UFdb.uftextureversion ~= "NONE" then
			healthTexture = ElvUI_EltreumUI:UnitframeClassTexture(colorClass)
		else
			healthTexture = E.LSM:Fetch("statusbar", elvDB.statusbar or UF.db.statusbar)
		end
	elseif ufCustom.enable and not ufCustom.classdetect then
		local customTex = ufCustom[GetCustomTextureKey(unittexture)]
		healthTexture = E.LSM:Fetch("statusbar", customTex or elvDB.statusbar or UF.db.statusbar)
	elseif not ufCustom.enable and gradUnitEnabled then
		local texKey = grad.useUFtexture and (elvDB.statusbar or UF.db.statusbar) or (grad.texture or elvDB.statusbar or UF.db.statusbar)
		healthTexture = E.LSM:Fetch("statusbar", texKey)
	elseif (ufCustom.enable and ufCustom.classdetect) or (UFdb.uftextureversion and UFdb.uftextureversion ~= "NONE") then
		if ufCustom.enable then
			healthTexture = ElvUI_EltreumUI:UnitframeClassTextureCustom(colorClass)
		else
			healthTexture = ElvUI_EltreumUI:UnitframeClassTexture(colorClass)
		end
	else
		healthTexture = E.LSM:Fetch("statusbar", elvDB.statusbar or UF.db.statusbar)
	end

	health.EltruismAppliedClass = colorClass
	health.EltruismAppliedUnitTex = unittexture
	health.EltruismAppliedMode = mode
	health.EltruismCustomTexEnable = ufCustom.enable
	health.EltruismClassDetect = ufCustom.classdetect
	health.EltruismGradEnable = gradUnitEnabled
	health.EltruismAppliedFlip = shouldFlip

	ApplyHealthTextures(UFdb, elvDB, health, healthTexture, isTransparent, shouldFlip, unitframe.EltruismDebuffExists, hasBackdropGradient, barTex)
	return colorClass, isPlayer, hasClass and classunit or nil, hasReaction and reaction or nil
end

--set the textures for group units
function ElvUI_EltreumUI:ApplyGroupCustomTexture(button,noOrientation,frametype,hasBackdropGradient)
	local unit = button.__unit or button.unit
	if not unit then return end
	local health = button.Health
	if not health then return end

	local UFdb = E.db.ElvUI_EltreumUI.unitframes
	local elvDB = E.db.unitframe
	local barTex = health:GetStatusBarTexture()

	local targetUFOrientation = UFdb.UForientation
	if not noOrientation and targetUFOrientation and health.EltruismOrientation ~= targetUFOrientation then
		health:SetOrientation(targetUFOrientation)
		health.EltruismOrientation = targetUFOrientation
	end

	--due to raid pet, check if is player
	local buttonclass = "NPCFRIENDLY"
	local isPlayer = UnitIsPlayer(unit)
	isPlayer = (canaccessvalue(isPlayer) and isPlayer) or (E.Retail and UnitInPartyIsAI(unit))
	if isPlayer then
		local _, class = UnitClass(unit)
		if canaccessvalue(class) and class then
			buttonclass = class
		end
	end

	local ufCustom = UFdb.ufcustomtexture
	local grad = UFdb.gradientmode
	local gradGroupEnabled = grad.enable and grad.enablegroupunits
	local mode = UFdb.darkmode and 2 or (UFdb.lightmode and 1 or 0)
	local isHidden = ufCustom.backdrophidden
	local isTransparent = (health.isTransparent ~= nil and health.isTransparent) or elvDB.colors.transparentHealth
	local textureVersion = ElvUI_EltreumUI.EltruismTextureVersion

	if health.EltruismTextureVersion == textureVersion
		and health.EltruismAppliedClass == buttonclass
		and health.EltruismAppliedFrameType == frametype
		and health.EltruismAppliedMode == mode
		and health.EltruismCustomTexEnable == ufCustom.enable
		and health.EltruismNoClassTex == ufCustom.noclasstexture
		and health.EltruismGradEnable == gradGroupEnabled
		and health.EltruismAlphaTransparent == isTransparent
		and health.EltruismAlphaHidden == isHidden then
		if mode == 1 and not isHidden and not button.EltruismDebuffExists and not hasBackdropGradient and health.bg then
			health.bg:SetVertexColor(0, 0, 0, ufCustom.backdropalpha or 1)
		end
		return buttonclass, isPlayer
	end

	local healthTexture
	if ufCustom.enable then
		if not ufCustom.noclasstexture then
			healthTexture = ElvUI_EltreumUI:UnitframeClassTextureCustom(buttonclass)
		else
			if frametype == "raid" then
				healthTexture = ElvUI_EltreumUI:UnitframeClassTextureCustom("RAID")
			elseif frametype == "party" then
				healthTexture = ElvUI_EltreumUI:UnitframeClassTextureCustom("PARTY")
			else
				healthTexture = ElvUI_EltreumUI:UnitframeClassTexture(buttonclass)
			end
		end
	elseif gradGroupEnabled then
		local texKey = grad.useUFtexture and (elvDB.statusbar or UF.db.statusbar) or (grad.texture or elvDB.statusbar or UF.db.statusbar)
		healthTexture = E.LSM:Fetch("statusbar", texKey)
	elseif UFdb.uftextureversion and UFdb.uftextureversion ~= "NONE" then
		healthTexture = ElvUI_EltreumUI:UnitframeClassTexture(buttonclass)
	else
		healthTexture = E.LSM:Fetch("statusbar", elvDB.statusbar or UF.db.statusbar)
	end

	health.EltruismAppliedClass = buttonclass
	health.EltruismAppliedFrameType = frametype
	health.EltruismAppliedMode = mode
	health.EltruismCustomTexEnable = ufCustom.enable
	health.EltruismNoClassTex = ufCustom.noclasstexture
	health.EltruismGradEnable = gradGroupEnabled

	ApplyHealthTextures(UFdb, elvDB, health, healthTexture, isTransparent, nil, button.EltruismDebuffExists, hasBackdropGradient, barTex)
	return buttonclass, isPlayer
end

local function ApplyGroupTextureChildren(unitType, ...)
	for j = 1, select("#", ...) do
		local frame = select(j, ...)
		if frame.Health then
			ElvUI_EltreumUI:ApplyGroupCustomTexture(frame, true, unitType)
		end
	end
end

local forced = false
function ElvUI_EltreumUI:CustomTexture(unit)
	if ElvUI_EltreumUI:EncounterCheck() then return end
	ElvUI_EltreumUI.EltruismTextureVersion = (ElvUI_EltreumUI.EltruismTextureVersion or 0) + 1
	local UFdb = E.db.ElvUI_EltreumUI.unitframes
	if not UFdb then return end
	if E.private.unitframe.enable and UFdb.UFmodifications then

		--main issue = the toggle for some units like boss and arena wont work bc it checks for boss1,boss2... instead of just boss
		if E.db.unitframe.units.player.enable then
			ElvUI_EltreumUI:ApplyUnitCustomTexture("player", "Player","player")
		end
		if E.db.unitframe.units.target.enable then
			ElvUI_EltreumUI:ApplyUnitCustomTexture("target", "Target","target")
		end
		if E.db.unitframe.units.targettarget.enable then
			ElvUI_EltreumUI:ApplyUnitCustomTexture("targettarget", "TargetTarget","targettarget")
		end
		if E.db.unitframe.units.targettargettarget.enable then
			ElvUI_EltreumUI:ApplyUnitCustomTexture("targettargettarget", "TargetTargetTarget","targettargettarget")
		end
		ElvUI_EltreumUI:ApplyUnitCustomTexture("pet", "Pet","pet")

		if E.Retail or E.Mists or E.TBC or E.Wrath then
			ElvUI_EltreumUI:ApplyUnitCustomTexture("boss1", "Boss1", "boss",true)
			ElvUI_EltreumUI:ApplyUnitCustomTexture("boss2", "Boss2", "boss",true)
			ElvUI_EltreumUI:ApplyUnitCustomTexture("boss3", "Boss3", "boss",true)
			ElvUI_EltreumUI:ApplyUnitCustomTexture("boss4", "Boss4", "boss",true)
			ElvUI_EltreumUI:ApplyUnitCustomTexture("boss5", "Boss5", "boss",true)
			ElvUI_EltreumUI:ApplyUnitCustomTexture("boss6", "Boss6", "boss",true)
			ElvUI_EltreumUI:ApplyUnitCustomTexture("boss7", "Boss7", "boss",true)
			ElvUI_EltreumUI:ApplyUnitCustomTexture("boss8", "Boss8", "boss",true)
		end
		if not E.Classic then
			ElvUI_EltreumUI:ApplyUnitCustomTexture("focus", "Focus", "focus")
			ElvUI_EltreumUI:ApplyUnitCustomTexture("focustarget", "FocusTarget", "focus")
			ElvUI_EltreumUI:ApplyUnitCustomTexture("arena1", "Arena1", "arena",true)
			ElvUI_EltreumUI:ApplyUnitCustomTexture("arena2", "Arena2", "arena",true)
			ElvUI_EltreumUI:ApplyUnitCustomTexture("arena3", "Arena3", "arena",true)
			ElvUI_EltreumUI:ApplyUnitCustomTexture("arena4", "Arena4", "arena",true)
			ElvUI_EltreumUI:ApplyUnitCustomTexture("arena5", "Arena5", "arena",true)
		end

		if unit == "testunit" then
			forced = true
			unit = "player"
		else
			forced = false
		end

		if forced then
			if E.Retail or E.Mists or E.TBC or E.Wrath then
				ElvUI_EltreumUI:ApplyUnitCustomTexture("player", "Boss1", "boss",true)
				ElvUI_EltreumUI:ApplyUnitCustomTexture("player", "Boss2", "boss",true)
				ElvUI_EltreumUI:ApplyUnitCustomTexture("player", "Boss3", "boss",true)
				ElvUI_EltreumUI:ApplyUnitCustomTexture("player", "Boss4", "boss",true)
				ElvUI_EltreumUI:ApplyUnitCustomTexture("player", "Boss5", "boss",true)
				ElvUI_EltreumUI:ApplyUnitCustomTexture("player", "Boss6", "boss",true)
				ElvUI_EltreumUI:ApplyUnitCustomTexture("player", "Boss7", "boss",true)
				ElvUI_EltreumUI:ApplyUnitCustomTexture("player", "Boss8", "boss",true)
				ElvUI_EltreumUI:ApplyUnitCustomTexture("player", "Arena1", "arena",true)
				ElvUI_EltreumUI:ApplyUnitCustomTexture("player", "Arena2", "arena",true)
				ElvUI_EltreumUI:ApplyUnitCustomTexture("player", "Arena3", "arena",true)
				ElvUI_EltreumUI:ApplyUnitCustomTexture("player", "Arena4", "arena",true)
				ElvUI_EltreumUI:ApplyUnitCustomTexture("player", "Arena5", "arena",true)
			end
		end

		--group/raid unitframes
		if ((type(unit) == "string" and UnitExists(unit)) or UnitInParty("player") or UnitInRaid("player") or forced) then

			--party/raid
			if _G["ElvUF_Party"] and _G["ElvUF_Party"]:IsVisible() then
				local partyGroup = _G["ElvUF_PartyGroup1"]
				if partyGroup then
					ApplyGroupTextureChildren("party", partyGroup:GetChildren())
				end
				if E.db.unitframe.units.party.petsGroup.enable then
					if _G["ElvUF_PartyGroup1UnitButton1Pet"] and _G["ElvUF_PartyGroup1UnitButton1Pet"]:IsVisible() then
						for i = 1, 5 do
							local partypetbutton = _G["ElvUF_PartyGroup1UnitButton"..i.."Pet"]
							if partypetbutton and partypetbutton.Health then
								ElvUI_EltreumUI:ApplyGroupCustomTexture(partypetbutton,true)
							end
						end
					end
				end
			end

			if _G["ElvUF_Raid1"] and _G["ElvUF_Raid1"]:IsVisible() then
				for i = 1, 8 do
					local raidGroup = _G["ElvUF_Raid1Group"..i]
					if raidGroup then
						ApplyGroupTextureChildren("raid", raidGroup:GetChildren())
					end
				end
			end

			if _G["ElvUF_Raid2"] and _G["ElvUF_Raid2"]:IsVisible() then
				for i = 1, 8 do
					local raidGroup = _G["ElvUF_Raid2Group"..i]
					if raidGroup then
						ApplyGroupTextureChildren("raid", raidGroup:GetChildren())
					end
				end
			end

			if _G["ElvUF_Raid3"] and _G["ElvUF_Raid3"]:IsVisible() then
				for i = 1, 8 do
					local raidGroup = _G["ElvUF_Raid3Group"..i]
					if raidGroup then
						ApplyGroupTextureChildren("raid", raidGroup:GetChildren())
					end
				end
			end

			--tanks
			if _G["ElvUF_TankUnitButton1"] and _G["ElvUF_TankUnitButton1"]:IsVisible() then
				for i = 1, 8 do
					local frame = _G["ElvUF_TankUnitButton"..i]
					if frame and frame.Health then
						ElvUI_EltreumUI:ApplyGroupCustomTexture(frame,true)
					end
				end
			end

			--tank targets
			if _G["ElvUF_TankUnitButton1Target"] and _G["ElvUF_TankUnitButton1Target"]:IsVisible() then
				for i = 1, 8 do
					local frame = _G["ElvUF_TankUnitButton"..i.."Target"]
					if frame and frame.Health then
						ElvUI_EltreumUI:ApplyGroupCustomTexture(frame)
					end
				end
			end

			--raid assist
			if _G["ElvUF_AssistUnitButton1"] and _G["ElvUF_AssistUnitButton1"]:IsVisible() then
				for i = 1, 8 do
					local frame = _G["ElvUF_AssistUnitButton"..i]
					if frame and frame.Health then
						ElvUI_EltreumUI:ApplyGroupCustomTexture(frame,true)
					end
				end
			end

			--raid assist targets
			if _G["ElvUF_AssistUnitButton1Target"] and _G["ElvUF_AssistUnitButton1Target"]:IsVisible() then
				for i = 1, 8 do
					local frame = _G["ElvUF_AssistUnitButton"..i.."Target"]
					if frame and frame.Health then
						ElvUI_EltreumUI:ApplyGroupCustomTexture(frame)
					end
				end
			end

			--raid pets
			if _G["ElvUF_RaidpetGroup1UnitButton1"] and _G["ElvUF_RaidpetGroup1UnitButton1"]:IsVisible() and E.db.unitframe.units.raidpet.enable then
				for i = 1, 40 do
					local frame = _G["ElvUF_RaidpetGroup1UnitButton"..i]
					if frame and frame.Health then
						ElvUI_EltreumUI:ApplyGroupCustomTexture(frame,true)
					end
				end
			end
		end
	end
end
local individualUnits = {
	player = { name = "Player", db = "player" },
	target = { name = "Target", db = "target" },
	targettarget = { name = "TargetTarget", db = "targettarget" },
	targettargettarget = { name = "TargetTargetTarget", db = "targettargettarget" },
	pet = { name = "Pet", db = "pet" },
	focus = { name = "Focus", db = "focus" },
	focustarget = { name = "FocusTarget", db = "focustarget" },
}

function ElvUI_EltreumUI:PostUpdateHealth(bar, unit)
	if not E.private.unitframe.enable then return end
	local edb = E.db.ElvUI_EltreumUI
	if edb.encountercheck and IsEncounterInProgress() then return end
	local parent = bar.origParent or bar:GetParent()
	if not parent then return end

	local UFdb = edb.unitframes
	if not UFdb.UFmodifications then return end

	local u = unit or parent.__unit or parent.unit
	if UFdb.portraitdead and (parent.Portrait or parent.Portrait3D or parent.EltruismPortrait) then
		ElvUI_EltreumUI.UpdateUnitPortraitDead(parent, u)
	end

	local elvDB = E.db.unitframe
	local grad = UFdb.gradientmode
	local hasGradient = grad and grad.enable and UFdb.hasMode
	local hasBackdropGradient = hasGradient and grad.enablebackdrop

	local frameType = parent.unitframeType
	if not frameType then
		local fUnit = parent.__unit or parent.unit or u
		if fUnit then
			parent.__unit = fUnit
			local buttonclass, isPlayer = ElvUI_EltreumUI:ApplyGroupCustomTexture(parent, true, nil, hasBackdropGradient)
			if hasGradient and buttonclass then
				ElvUI_EltreumUI:ApplyGroupGradient(parent, true, buttonclass, isPlayer)
			end
		end
		return
	end

	local info = individualUnits[frameType]
	if info then
		if elvDB.units[frameType] and not elvDB.units[frameType].enable then return end
		local unitID = u or frameType
		local colorClass, isPlayer, classunit, reaction = ElvUI_EltreumUI:ApplyUnitCustomTexture(unitID, info.name, info.db, nil, parent, hasBackdropGradient, hasGradient)
		if hasGradient and colorClass then
			ElvUI_EltreumUI:ApplyUnitGradient(unitID, info.name, info.db, nil, parent, colorClass, isPlayer, classunit, reaction)
		end
	elseif frameType == "boss" and (E.Retail or E.Mists or E.TBC or E.Wrath) then
		local bossName = parent.EltruismBossName
		local bossUnit = parent.EltruismBossUnit
		if not bossName then
			local frameName = parent:GetName()
			bossName = frameName and frameName:sub(7)
			bossUnit = parent.unit or parent.__unit or (bossName and bossName:lower())
			parent.EltruismBossName = bossName
			parent.EltruismBossUnit = bossUnit
		end
		if bossName and bossUnit then
			local colorClass, isPlayer, classunit, reaction = ElvUI_EltreumUI:ApplyUnitCustomTexture(bossUnit, bossName, "boss", true, parent, hasBackdropGradient, hasGradient)
			if hasGradient and colorClass then
				ElvUI_EltreumUI:ApplyUnitGradient(bossUnit, bossName, "boss", true, parent, colorClass, isPlayer, classunit, reaction)
			end
		end
	elseif frameType == "arena" and not E.Classic then
		local arenaName = parent.EltruismArenaName
		local arenaUnit = parent.EltruismArenaUnit
		if not arenaName then
			local frameName = parent:GetName()
			arenaName = frameName and frameName:sub(7)
			arenaUnit = parent.unit or parent.__unit or (arenaName and arenaName:lower())
			parent.EltruismArenaName = arenaName
			parent.EltruismArenaUnit = arenaUnit
		end
		if arenaName and arenaUnit then
			local colorClass, isPlayer, classunit, reaction = ElvUI_EltreumUI:ApplyUnitCustomTexture(arenaUnit, arenaName, "arena", true, parent, hasBackdropGradient, hasGradient)
			if hasGradient and colorClass then
				ElvUI_EltreumUI:ApplyUnitGradient(arenaUnit, arenaName, "arena", true, parent, colorClass, isPlayer, classunit, reaction)
			end
		end
	elseif frameType == "party" then
		local pUnit = parent.unit
		local isPet = parent.EltruismIsPartyPet
		if parent.EltruismLastPartyUnit ~= pUnit then
			isPet = pUnit and strfind(pUnit, "pet")
			parent.EltruismLastPartyUnit = pUnit
			parent.EltruismIsPartyPet = isPet
		end
		local buttonclass, isPlayer = ElvUI_EltreumUI:ApplyGroupCustomTexture(parent, true, not isPet and "party" or nil, hasBackdropGradient)
		if hasGradient and buttonclass then
			ElvUI_EltreumUI:ApplyGroupGradient(parent, true, buttonclass, isPlayer)
		end
	elseif frameType == "raid" or frameType == "raid1" or frameType == "raid2" or frameType == "raid3" then
		local buttonclass, isPlayer = ElvUI_EltreumUI:ApplyGroupCustomTexture(parent, true, "raid", hasBackdropGradient)
		if hasGradient and buttonclass then
			ElvUI_EltreumUI:ApplyGroupGradient(parent, true, buttonclass, isPlayer)
		end
	elseif frameType == "tank" or frameType == "assist" or frameType == "raidpet" then
		local buttonclass, isPlayer = ElvUI_EltreumUI:ApplyGroupCustomTexture(parent, true, nil, hasBackdropGradient)
		if hasGradient and buttonclass then
			ElvUI_EltreumUI:ApplyGroupGradient(parent, true, buttonclass, isPlayer)
		end
	end
end
ElvUI_EltreumUI:SecureHook(UF, "PostUpdateHealthColor", "PostUpdateHealth")
ElvUI_EltreumUI:SecureHook(UF, "Style", "CustomTexture") --old target of target hook

-- replace absorb texture with unitframe texture
function ElvUI_EltreumUI:SetTexture_HealComm(_, obj)
	if not obj or type(obj) ~= "table" then return end
	local UFdb = E.db.ElvUI_EltreumUI.unitframes
	local customTex = UFdb and UFdb.UFmodifications and UFdb.ufcustomtexture
	if not customTex then return end

	local textureName
	if customTex.enableHealComm then
		textureName = E.db.unitframe.statusbar
	elseif customTex.enableHealCommCustom then
		textureName = customTex.enableHealCommTexture
	else
		return
	end

	if ElvUI_EltreumUI:EncounterCheck() then return end

	local texture = E.LSM:Fetch("statusbar", textureName)
	if texture then
		if obj.healingPlayer and obj.healingPlayer.SetStatusBarTexture then
			obj.healingPlayer:SetStatusBarTexture(texture)
		end
		if obj.healingOther and obj.healingOther.SetStatusBarTexture then
			obj.healingOther:SetStatusBarTexture(texture)
		end
		if obj.damageAbsorb and obj.damageAbsorb.SetStatusBarTexture then
			obj.damageAbsorb:SetStatusBarTexture(texture)
		end
		if obj.healAbsorb and obj.healAbsorb.SetStatusBarTexture then
			obj.healAbsorb:SetStatusBarTexture(texture)
		end
	end
end
ElvUI_EltreumUI:SecureHook(UF, "SetTexture_HealComm", "SetTexture_HealComm")

