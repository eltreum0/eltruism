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
local UnitIsDeadOrGhost = _G.UnitIsDeadOrGhost
local UnitIsConnected = _G.UnitIsConnected
local UnitInParty = _G.UnitInParty
local UnitInRaid = _G.UnitInRaid
local UnitCanAttack = _G.UnitCanAttack
local UnitIsEnemy = _G.UnitIsEnemy
local UnitIsFriend = _G.UnitIsFriend
local CreateColor = _G.CreateColor
local select = _G.select
local type = _G.type
local canaccessvalue = _G.canaccessvalue

local gradientEnableTable = {
	player = "enableplayer",
	target = "enabletarget",
	targettarget = "enabletargettarget",
	targettargettarget = "enabletargettargettarget",
	pet = "enablepet",
	boss = "enableboss",
	focus = "enablefocus",
	focustarget = "enablefocustarget",
	arena = "enablearena",
}

local function GetGradientEnableKey(unit)
	if not unit then return nil end
	local enableKey = gradientEnableTable[unit]
	if not enableKey then
		enableKey = "enable"..unit
		gradientEnableTable[unit] = enableKey
	end
	return enableKey
end

--function to check if colormixin tables are equal, if they are return false since its used to do something after that
--[[function ElvUI_EltreumUI:ColorMixinTableMatching(table1,table2)
	local r1,g1,b1,a1 = table1.r,table1.g,table1.b,table1.a
	local r2,g2,b2,a2 = table2.r,table2.g,table2.b,table2.a
	if r1 == r2 and g1 == g2 and b1 == b2 and a1 == a2 then
		return false
	else
		return true
	end
end]]

--function to update extra frames like tank and assist and their targets
local function UpdateTankAssistFrames(button)
	local button1 = _G[button.."1"]
	if not button1 then return end
	if button1:IsVisible() then
		--print("tank gradient firing",math.random(1,99))
		for i = 1, 8 do
			local frame = _G[button..i]
			if frame and frame.Health then
				ElvUI_EltreumUI:ApplyGroupGradient(frame, true)
			end
			local targetFrame = _G[button..i.."Target"]
			if targetFrame and targetFrame.Health then
				ElvUI_EltreumUI:ApplyGroupGradient(targetFrame)
			end
		end
	end
end

local invertframes = {
	["boss"] = true,
	--["target"] = true,
	["targettarget"] = true,
	["arena"] = true,
}

local function GetNPCReactionColorClass(unit, reaction, hasReaction)
	if hasReaction then
		if reaction >= 5 then
			return "NPCFRIENDLY"
		elseif reaction == 4 then
			return "NPCNEUTRAL"
		elseif reaction == 3 then
			return "NPCUNFRIENDLY"
		elseif reaction <= 2 then
			return "NPCHOSTILE"
		end
	end
	if UnitCanAttack("player", unit) or UnitIsEnemy("player", unit) then
		return "NPCHOSTILE"
	elseif UnitIsFriend("player", unit) then
		return "NPCFRIENDLY"
	else
		return "NPCHOSTILE"
	end
end

--set the backdrop gradient
function ElvUI_EltreumUI:ApplyGradientBackdrop(unit,frame,englishClass,reactionunit,isGroupFrame,unitDB,preIsPlayer,preDeadState)
	local UFdb = E.db.ElvUI_EltreumUI.unitframes
	local db = UFdb.gradientmode
	if db.enablebackdrop then
		local hasClass = canaccessvalue(englishClass) and englishClass
		local hasReaction = canaccessvalue(reactionunit) and reactionunit

		local isPlayer
		if preIsPlayer ~= nil then
			isPlayer = preIsPlayer
		else
			isPlayer = UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit))
		end
		if not isGroupFrame and not hasClass and not hasReaction then
			return
		end

		local colorClass = "BACKDROP"
		local invert = false
		if isGroupFrame then
			if db.classcolorbackdrop and hasClass then
				colorClass = englishClass
			end
		else
			if invertframes[unitDB] then
				invert = true
			elseif unitDB == 'target' and db.reversetarget then
				invert = true
			elseif unitDB == 'focus' and db.reversefocus then
				invert = true
			end

			if db.classcolorbackdrop then
				if (isPlayer and hasClass) or (hasClass and not hasReaction) then
					colorClass = englishClass
				elseif hasReaction then
					colorClass = GetNPCReactionColorClass(unit, reactionunit, true)
				end
			end
		end

		if colorClass == "ELTRUISM" then
			return
		end

		local deadState = 0
		if db.usedeadbackdrop then
			if preDeadState ~= nil then
				deadState = preDeadState
			elseif UnitIsDeadOrGhost(unit) then
				deadState = 1
			elseif isPlayer then
				if not UnitIsConnected(unit) then
					deadState = 3
				end
			elseif UnitIsTapDenied(unit) then
				deadState = 2
			end
		end

		local transparentHealth = E.db.unitframe.colors.transparentHealth
		local isHidden = UFdb.ufcustomtexture.backdrophidden
		local rawAlpha = UFdb.ufcustomtexture.backdropalpha or 1
		local backdropAlpha = isHidden and 0 or rawAlpha
		local healthAlpha = transparentHealth and (UFdb.ufcustomtexture.healthalpha or 1) or 1
		if not isHidden and transparentHealth and backdropAlpha == 1 and healthAlpha < 1 then
			backdropAlpha = healthAlpha
		end

		local orientation = db.orientation or "HORIZONTAL"
		local mode = UFdb.lightmode and 1 or (UFdb.darkmode and 2 or 0)
		local texVersion = ElvUI_EltreumUI.EltruismTextureVersion
		local missingPlayerClass = isPlayer and not hasClass
		local hasDebuff = frame.EltruismDebuffExists

		if frame.EltruismBackdropVersion == texVersion
			and frame.EltruismBackdropClass == colorClass
			and frame.EltruismBackdropDead == deadState
			and frame.EltruismBackdropInvert == invert
			and frame.EltruismBackdropCustom == db.customcolor
			and frame.EltruismBackdropOrient == orientation
			and frame.EltruismBackdropAlpha == backdropAlpha
			and frame.EltruismBackdropRawAlpha == rawAlpha
			and frame.EltruismBackdropHealthAlpha == healthAlpha
			and frame.EltruismBackdropTransparent == transparentHealth
			and frame.EltruismBackdropHidden == isHidden
			and frame.EltruismBackdropMode == mode
			and frame.EltruismBackdropMissingClass == missingPlayerClass
			and frame.EltruismBackdropDebuff == hasDebuff
			and (not hasDebuff or (
				frame.EltruismBackdropDebuffR == frame.EltruismDebuffr
				and frame.EltruismBackdropDebuffG == frame.EltruismDebuffg
				and frame.EltruismBackdropDebuffB == frame.EltruismDebuffb
				and frame.EltruismBackdropDebuffA == frame.EltruismDebuffa
			)) then
			return
		end

		frame.EltruismBackdropClass = colorClass
		frame.EltruismBackdropDead = deadState
		frame.EltruismBackdropInvert = invert
		frame.EltruismBackdropCustom = db.customcolor
		frame.EltruismBackdropOrient = orientation
		frame.EltruismBackdropAlpha = backdropAlpha
		frame.EltruismBackdropRawAlpha = rawAlpha
		frame.EltruismBackdropHealthAlpha = healthAlpha
		frame.EltruismBackdropTransparent = transparentHealth
		frame.EltruismBackdropHidden = isHidden
		frame.EltruismBackdropMode = mode
		frame.EltruismBackdropVersion = texVersion
		frame.EltruismBackdropMissingClass = missingPlayerClass
		frame.EltruismBackdropDebuff = hasDebuff
		if hasDebuff then
			frame.EltruismBackdropDebuffR = frame.EltruismDebuffr
			frame.EltruismBackdropDebuffG = frame.EltruismDebuffg
			frame.EltruismBackdropDebuffB = frame.EltruismDebuffb
			frame.EltruismBackdropDebuffA = frame.EltruismDebuffa
		end

		if transparentHealth then
			if frame.Health and frame.Health.backdrop then
				frame.Health.backdrop.customBackdropAlpha = backdropAlpha
				if UFdb.lightmode then
					frame.Health.backdrop:SetBackdropColor(0, 0, 0, backdropAlpha)
					if frame.Health.backdrop.Center and frame.Health.backdrop.Center:IsShown() then
						frame.Health.backdrop.Center:Hide()
					end
					if frame.Health.bg then
						frame.Health.bg:SetAlpha(backdropAlpha)
						if not frame.EltruismDebuffExists then
							frame.Health.bg:SetVertexColor(0, 0, 0, backdropAlpha)
						end
					end
				elseif UFdb.darkmode then
					local missingHealthAlpha = (transparentHealth and rawAlpha == 1 and healthAlpha < 1) and healthAlpha or rawAlpha
					frame.Health.backdrop:SetBackdropColor(0, 0, 0, backdropAlpha)
					if frame.Health.backdrop.Center then
						if isHidden then
							frame.Health.backdrop.Center:Hide()
						else
							if not frame.Health.backdrop.Center:IsShown() then
								frame.Health.backdrop.Center:Show()
							end
							frame.Health.backdrop.Center:SetAlpha(backdropAlpha)
						end
					end
					if frame.Health.backdropTex then
						frame.Health.backdropTex:SetAlpha(missingHealthAlpha)
					end
				end
			end
		end

		local barTex = UFdb.darkmode and frame.Health:GetStatusBarTexture() or nil
		if not frame.EltruismDebuffExists then
			local minColor, maxColor = ElvUI_EltreumUI:GetBackdropGradient(colorClass, invert, db.customcolor, missingPlayerClass)

			if UFdb.lightmode then
				if frame.Health.bg then
					frame.Health.bg:SetGradient(orientation, minColor, maxColor)
				end
			elseif barTex then
				barTex:SetGradient(orientation, minColor, maxColor)
			end
		else
			local debuffColor = frame.EltruismDebuffColor
			if not debuffColor or frame.EltruismDebuffColorR ~= frame.EltruismDebuffr or frame.EltruismDebuffColorG ~= frame.EltruismDebuffg or frame.EltruismDebuffColorB ~= frame.EltruismDebuffb or frame.EltruismDebuffColorA ~= frame.EltruismDebuffa then
				debuffColor = CreateColor(frame.EltruismDebuffr, frame.EltruismDebuffg, frame.EltruismDebuffb, frame.EltruismDebuffa)
				frame.EltruismDebuffColor = debuffColor
				frame.EltruismDebuffColorR = frame.EltruismDebuffr
				frame.EltruismDebuffColorG = frame.EltruismDebuffg
				frame.EltruismDebuffColorB = frame.EltruismDebuffb
				frame.EltruismDebuffColorA = frame.EltruismDebuffa
			end
			if UFdb.lightmode then
				if frame.Health.bg then
					frame.Health.bg:SetGradient("HORIZONTAL", debuffColor, debuffColor)
				end
			elseif barTex then
				barTex:SetGradient("HORIZONTAL", debuffColor, debuffColor)
			end
		end
		if deadState > 0 then
			local stateMin, stateMax
			if deadState == 1 then
				stateMin, stateMax = ElvUI_EltreumUI:GetDeadColors()
			elseif deadState == 2 then
				stateMin, stateMax = ElvUI_EltreumUI:GetTappedColors()
			elseif deadState == 3 then
				stateMin, stateMax = ElvUI_EltreumUI:GetDisconnectedColors()
			end
			if stateMin and stateMax then
				if UFdb.lightmode then
					if frame.Health.bg then
						frame.Health.bg:SetGradient("HORIZONTAL", stateMin, stateMax)
					end
				elseif barTex then
					barTex:SetGradient("HORIZONTAL", stateMin, stateMax)
				end
			end
		end
	end
end
--set the textures or gradients for single units
function ElvUI_EltreumUI:ApplyUnitGradient(unit,name,unitDB,noOrientation,frame,preColorClass,preIsPlayer,preClass,preReaction)
	local UFdb = E.db.ElvUI_EltreumUI.unitframes
	local db = UFdb.gradientmode

	local unitframe, isPlayer, classunit, reaction, hasReaction, colorClass
	if preColorClass then
		unitframe = frame
		isPlayer = preIsPlayer
		classunit = preClass
		reaction = preReaction
		hasReaction = preReaction ~= nil
		if isPlayer then
			if not classunit then return end
		elseif not hasReaction then
			return
		end
		colorClass = preColorClass
	else
		if not UnitExists(unit) then return end
		unitframe = frame or _G["ElvUF_"..name]
		if not (unitframe and unitframe.Health) then return end

		isPlayer = UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit))
		local isActualPlayer = false
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

		hasReaction = false
		if isPlayer then
			if not classunit then
				local _, unitClass = UnitClass(unit)
				classunit = unitClass
			end
			if not canaccessvalue(classunit) or not classunit then
				return
			end
		else
			reaction = UnitReaction(unit, "player")
			if not canaccessvalue(reaction) or not reaction then
				return
			end
			hasReaction = true
		end

		local isCharmed = UnitIsCharmed(unit)
		isCharmed = canaccessvalue(isCharmed) and isCharmed or false
		if (isPlayer and not isCharmed) or isActualPlayer then
			colorClass = classunit
		elseif UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
			colorClass = "TAPPED"
		else
			colorClass = GetNPCReactionColorClass(unit, reaction, hasReaction)
		end
	end

	local health = unitframe.Health
	local targetUFOrientation = UFdb.UForientation
	if not noOrientation and targetUFOrientation and health.EltruismOrientation ~= targetUFOrientation then
		health:SetOrientation(targetUFOrientation)
		health.EltruismOrientation = targetUFOrientation
	end

	local deadState, isDead, isDisconnected = 0, false, false
	if db.usedeadbackdrop then
		if UnitIsDeadOrGhost(unit) then
			deadState = 1
			isDead = true
		elseif isPlayer then
			if not UnitIsConnected(unit) then
				deadState = 3
				isDisconnected = true
			end
		elseif UnitIsTapDenied(unit) then
			deadState = 2
		end
	end

	if db.enablebackdrop then
		ElvUI_EltreumUI:ApplyGradientBackdrop(unit,unitframe,classunit,reaction,false,unitDB,isPlayer,deadState)
	end

	local orientation = db.orientation or "HORIZONTAL"
	local transparentHealth = E.db.unitframe.colors.transparentHealth
	local isHidden = UFdb.ufcustomtexture.backdrophidden
	local rawAlpha = UFdb.ufcustomtexture.backdropalpha or 1
	local backdropAlpha = isHidden and 0 or rawAlpha
	local healthAlpha = transparentHealth and (UFdb.ufcustomtexture.healthalpha or 1) or 1
	if not isHidden and transparentHealth and backdropAlpha == 1 and healthAlpha < 1 then
		backdropAlpha = healthAlpha
	end

	local textureVersion = ElvUI_EltreumUI.EltruismTextureVersion
	local isTextureCached = (health.EltruismTextureVersion == textureVersion)
	if not isHidden and not isTextureCached then
		local shouldFlip = UFdb.ufcustomtexture.fliptargetbackdrop and name == 'Target'
		if UFdb.lightmode and health.bg then
			local bgTexture = E.LSM:Fetch("statusbar", UFdb.ufcustomtexture.backdroptexture)
			if bgTexture and health.EltruismBgTexture ~= bgTexture then
				health.bg:SetTexture(bgTexture)
				health.EltruismBgTexture = bgTexture
			end
			if UFdb.ufcustomtexture.backdroptexturestaticsize then
				if not health.EltruismBgStatic then
					health.bg:SetAllPoints(health)
					health.EltruismBgStatic = true
				end
				if shouldFlip and not health.EltruismBgFlip then
					health.bg:SetTexCoord(1, 0, 0, 1)
					health.EltruismBgFlip = true
				end
			end
		elseif UFdb.darkmode and health.backdrop and health.backdrop.Center then
			local centerTexture = E.LSM:Fetch("statusbar", UFdb.ufcustomtexture.backdroptexture)
			if centerTexture and health.EltruismCenterTexture ~= centerTexture then
				health.backdrop.Center:SetTexture(centerTexture)
				health.EltruismCenterTexture = centerTexture
			end
			if health.EltruismCenterFlip ~= shouldFlip then
				if shouldFlip then
					health.backdrop.Center:SetTexCoord(1, 0, 0, 1)
				else
					health.backdrop.Center:SetTexCoord(0, 1, 0, 1)
				end
				health.EltruismCenterFlip = shouldFlip
			end
		end
		health.EltruismTextureVersion = textureVersion
	end

	local invert = false
	if invertframes[unitDB] then
		invert = true
	elseif name == 'Target' and db.reversetarget then
		invert = true
	elseif name == 'Focus' and db.reversefocus then
		invert = true
	end

	local isCustom = db.customcolor
	if UFdb.lightmode then
		if health.EltruismGradientAlphaVer ~= textureVersion or health.EltruismGradientAlpha ~= backdropAlpha or health.EltruismGradientDebuff ~= unitframe.EltruismDebuffExists then
			if health.bg and not unitframe.EltruismDebuffExists then
				health.bg:SetAlpha(backdropAlpha)
				if not isHidden and not db.enablebackdrop then
					health.bg:SetVertexColor(0, 0, 0, backdropAlpha)
				end
			end
			if health.backdrop then
				health.backdrop.customBackdropAlpha = backdropAlpha
				health.backdrop:SetBackdropColor(0, 0, 0, backdropAlpha)
				if isHidden and E.db.unitframe.thinBorders then
					health.backdrop:Hide()
				else
					if not health.backdrop:IsShown() then
						health.backdrop:Show()
					end
					if health.backdrop.Center and health.backdrop.Center:IsShown() then
						health.backdrop.Center:Hide()
					end
				end
			end
			health.EltruismGradientAlphaVer = textureVersion
			health.EltruismGradientAlpha = backdropAlpha
			health.EltruismGradientDebuff = unitframe.EltruismDebuffExists
		end

		if db.enable and db[GetGradientEnableKey(unitDB)] then
			local barTex = health:GetStatusBarTexture()
			if barTex then
				if not UFdb.ufcustomtexture.enable then
					local targetTexture = db.useUFtexture and (E.db.unitframe.statusbar or UF.db.statusbar) or db.texture
					if not isTextureCached or health.EltruismGradientBarTexture ~= targetTexture then
						local fetchedTex = E.LSM:Fetch("statusbar", targetTexture)
						if fetchedTex and health.EltruismBarTexture ~= fetchedTex then
							barTex:SetTexture(fetchedTex)
							health.EltruismBarTexture = fetchedTex
						end
						health.EltruismGradientBarTexture = targetTexture
					end
				end
				if db.usedeadbackdrop and isDead then
					local deadMin, deadMax = ElvUI_EltreumUI:GetDeadColors()
					barTex:SetGradient(orientation, deadMin, deadMax)
				elseif db.usedeadbackdrop and isDisconnected then
					local discMin, discMax = ElvUI_EltreumUI:GetDisconnectedColors()
					barTex:SetGradient(orientation, discMin, discMax)
				else
					local minColor, maxColor = ElvUI_EltreumUI:GetHealthGradient(colorClass, invert, isCustom)
					barTex:SetGradient(orientation, minColor, maxColor)
				end
			end
		end
	elseif UFdb.darkmode then
		local missingHealthAlpha = (transparentHealth and rawAlpha == 1 and healthAlpha < 1) and healthAlpha or rawAlpha
		if health.EltruismGradientAlphaVer ~= textureVersion or health.EltruismGradientAlpha ~= backdropAlpha or health.EltruismGradientDebuff ~= unitframe.EltruismDebuffExists then
			if health.backdrop then
				health.backdrop.customBackdropAlpha = backdropAlpha
				health.backdrop:SetBackdropColor(0, 0, 0, backdropAlpha)
				if isHidden then
					if E.db.unitframe.thinBorders then
						health.backdrop:Hide()
					elseif health.backdrop.Center then
						health.backdrop.Center:Hide()
					end
				else
					if not health.backdrop:IsShown() then
						health.backdrop:Show()
					end
					if health.backdrop.Center then
						if not health.backdrop.Center:IsShown() then
							health.backdrop.Center:Show()
						end
						health.backdrop.Center:SetAlpha(backdropAlpha)
					end
				end
			end
			if health.backdropTex and not unitframe.EltruismDebuffExists then
				health.backdropTex:SetAlpha(missingHealthAlpha)
			end
			health.EltruismGradientAlphaVer = textureVersion
			health.EltruismGradientAlpha = backdropAlpha
			health.EltruismGradientDebuff = unitframe.EltruismDebuffExists
		end
		if health.backdropTex and db.enable and db[GetGradientEnableKey(unitDB)] then
			if not UFdb.ufcustomtexture.enable then
				local targetTexture = db.useUFtexture and (E.db.unitframe.statusbar or UF.db.statusbar) or db.texture
				if not isTextureCached or health.EltruismGradientBgTexture ~= targetTexture then
					local fetchedTex = E.LSM:Fetch("statusbar", targetTexture)
					if fetchedTex and health.EltruismBackdropTexture ~= fetchedTex then
						health.backdropTex:SetTexture(fetchedTex)
						health.EltruismBackdropTexture = fetchedTex
					end
					health.EltruismGradientBgTexture = targetTexture
				end
			end
			if db.usedeadbackdrop and isDead then
				local deadMin, deadMax = ElvUI_EltreumUI:GetDeadColors()
				health.backdropTex:SetGradient(orientation, deadMin, deadMax)
			elseif db.usedeadbackdrop and isDisconnected then
				local discMin, discMax = ElvUI_EltreumUI:GetDisconnectedColors()
				health.backdropTex:SetGradient(orientation, discMin, discMax)
			else
				local minColor, maxColor = ElvUI_EltreumUI:GetHealthGradient(colorClass, invert, isCustom)
				health.backdropTex:SetGradient(orientation, minColor, maxColor)
			end
		end
	end
	if not db.enable and not UFdb.ufcustomtexture.enable then
		if UFdb.darkmode and health.backdropTex then
			local fetchedTex = E.LSM:Fetch("statusbar", E.db.unitframe.statusbar or UF.db.statusbar)
			if fetchedTex and health.EltruismBackdropTexture ~= fetchedTex then
				health.backdropTex:SetTexture(fetchedTex)
				health.EltruismBackdropTexture = fetchedTex
			end
			local missingHealthAlpha = (transparentHealth and rawAlpha == 1 and healthAlpha < 1) and healthAlpha or rawAlpha
			health.backdropTex:SetAlpha(missingHealthAlpha)
		end
	end
end

--set the textures or gradients for group units
function ElvUI_EltreumUI:ApplyGroupGradient(button,noOrientation,preClass,preIsPlayer)
	local UFdb = E.db.ElvUI_EltreumUI.unitframes
	local db = UFdb.gradientmode
	local health = button.Health
	if not health then return end
	local unit = button.__unit or button.unit
	if not unit then return end

	local buttonclass, isPlayer
	if preClass then
		buttonclass = preClass
		isPlayer = preIsPlayer
	else
		isPlayer = UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit))
		--due to raid pet, check if is player
		if isPlayer then --C_LFGInfo.IsInLFGFollowerDungeon() could be used
			local _, class = UnitClass(unit)
			if canaccessvalue(class) and class then
				buttonclass = class
			else
				buttonclass = "NPCFRIENDLY"
			end
		else
			buttonclass = "NPCFRIENDLY"
		end
	end

	local targetUFOrientation = UFdb.UForientation
	if not noOrientation and targetUFOrientation and health.EltruismOrientation ~= targetUFOrientation then
		health:SetOrientation(targetUFOrientation)
		health.EltruismOrientation = targetUFOrientation
	end

	local deadState, isDead, isDisconnected = 0, false, false
	if db.usedeadbackdrop then
		if UnitIsDeadOrGhost(unit) then
			deadState = 1
			isDead = true
		elseif isPlayer then
			if not UnitIsConnected(unit) then
				deadState = 3
				isDisconnected = true
			end
		elseif UnitIsTapDenied(unit) then
			deadState = 2
		end
	end

	if db.enablebackdrop then
		ElvUI_EltreumUI:ApplyGradientBackdrop(unit,button,buttonclass,nil,true,nil,isPlayer,deadState)
	end

	local transparentHealth = E.db.unitframe.colors.transparentHealth
	local isHidden = UFdb.ufcustomtexture.backdrophidden
	local rawAlpha = UFdb.ufcustomtexture.backdropalpha or 1
	local backdropAlpha = isHidden and 0 or rawAlpha
	local healthAlpha = transparentHealth and (UFdb.ufcustomtexture.healthalpha or 1) or 1
	if not isHidden and transparentHealth and backdropAlpha == 1 and healthAlpha < 1 then
		backdropAlpha = healthAlpha
	end

	local textureVersion = ElvUI_EltreumUI.EltruismTextureVersion
	local isTextureCached = (health.EltruismTextureVersion == textureVersion)
	local isCustom = db.customcolor

	if UFdb.lightmode then
		if health.EltruismGradientAlphaVer ~= textureVersion or health.EltruismGradientAlpha ~= backdropAlpha or health.EltruismGradientDebuff ~= button.EltruismDebuffExists then
			if health.bg and not button.EltruismDebuffExists then
				health.bg:SetAlpha(backdropAlpha)
				if not isHidden and not db.enablebackdrop then
					health.bg:SetVertexColor(0, 0, 0, backdropAlpha)
				end
			end
			if health.backdrop then
				health.backdrop.customBackdropAlpha = backdropAlpha
				health.backdrop:SetBackdropColor(0, 0, 0, backdropAlpha)
				if isHidden and E.db.unitframe.thinBorders then
					health.backdrop:Hide()
				else
					if not health.backdrop:IsShown() then
						health.backdrop:Show()
					end
					if health.backdrop.Center and health.backdrop.Center:IsShown() then
						health.backdrop.Center:Hide()
					end
				end
			end
			health.EltruismGradientAlphaVer = textureVersion
			health.EltruismGradientAlpha = backdropAlpha
			health.EltruismGradientDebuff = button.EltruismDebuffExists
		end

		if db.enable and db.enablegroupunits then
			local barTex = health:GetStatusBarTexture()
			if barTex then
				if not UFdb.ufcustomtexture.enable then
					local targetTexture = db.useUFtexture and (E.db.unitframe.statusbar or UF.db.statusbar) or db.texture
					if not isTextureCached or health.EltruismGradientBarTexture ~= targetTexture then
						local fetchedTex = E.LSM:Fetch("statusbar", targetTexture)
						if fetchedTex and health.EltruismBarTexture ~= fetchedTex then
							barTex:SetTexture(fetchedTex)
							health.EltruismBarTexture = fetchedTex
						end
						health.EltruismGradientBarTexture = targetTexture
					end
				end
				if db.usedeadbackdrop and isDead then
					local deadMin, deadMax = ElvUI_EltreumUI:GetDeadColors()
					barTex:SetGradient("HORIZONTAL", deadMin, deadMax)
				elseif db.usedeadbackdrop and isDisconnected then
					local discMin, discMax = ElvUI_EltreumUI:GetDisconnectedColors()
					barTex:SetGradient("HORIZONTAL", discMin, discMax)
				else
					local minColor, maxColor = ElvUI_EltreumUI:GetHealthGradient(buttonclass, false, isCustom)
					barTex:SetGradient(db.orientation, minColor, maxColor)
				end
			end
		end
		if not isHidden and not isTextureCached and health.bg then
			local bgTexture = E.LSM:Fetch("statusbar", UFdb.ufcustomtexture.backdroptexture)
			if bgTexture and health.EltruismBgTexture ~= bgTexture then
				health.bg:SetTexture(bgTexture)
				health.EltruismBgTexture = bgTexture
			end
			if UFdb.ufcustomtexture.backdroptexturestaticsize and not health.EltruismBgStatic then
				health.bg:SetAllPoints(health)
				health.EltruismBgStatic = true
			end
			health.EltruismTextureVersion = textureVersion
		end
	elseif UFdb.darkmode then
		local missingHealthAlpha = (transparentHealth and rawAlpha == 1 and healthAlpha < 1) and healthAlpha or rawAlpha
		if health.EltruismGradientAlphaVer ~= textureVersion or health.EltruismGradientAlpha ~= backdropAlpha or health.EltruismGradientDebuff ~= button.EltruismDebuffExists then
			if health.backdrop then
				health.backdrop.customBackdropAlpha = backdropAlpha
				health.backdrop:SetBackdropColor(0, 0, 0, backdropAlpha)
				if isHidden then
					if E.db.unitframe.thinBorders then
						health.backdrop:Hide()
					elseif health.backdrop.Center then
						health.backdrop.Center:Hide()
					end
				else
					if not health.backdrop:IsShown() then
						health.backdrop:Show()
					end
					if health.backdrop.Center then
						if not health.backdrop.Center:IsShown() then
							health.backdrop.Center:Show()
						end
						health.backdrop.Center:SetAlpha(backdropAlpha)
					end
				end
			end
			if health.backdropTex and not button.EltruismDebuffExists then
				health.backdropTex:SetAlpha(missingHealthAlpha)
			end
			health.EltruismGradientAlphaVer = textureVersion
			health.EltruismGradientAlpha = backdropAlpha
			health.EltruismGradientDebuff = button.EltruismDebuffExists
		end
		if not isHidden and not isTextureCached and health.backdrop and health.backdrop.Center then
			local centerTexture = E.LSM:Fetch("statusbar", UFdb.ufcustomtexture.backdroptexture)
			if centerTexture and health.EltruismCenterTexture ~= centerTexture then
				health.backdrop.Center:SetTexture(centerTexture)
				health.EltruismCenterTexture = centerTexture
			end
			health.EltruismTextureVersion = textureVersion
		end
		if health.backdropTex and db.enable and db.enablegroupunits then
			if not UFdb.ufcustomtexture.enable then
				local targetTexture = db.useUFtexture and (E.db.unitframe.statusbar or UF.db.statusbar) or db.texture
				if not isTextureCached or health.EltruismGradientBgTexture ~= targetTexture then
					local fetchedTex = E.LSM:Fetch("statusbar", targetTexture)
					if fetchedTex and health.EltruismBackdropTexture ~= fetchedTex then
						health.backdropTex:SetTexture(fetchedTex)
						health.EltruismBackdropTexture = fetchedTex
					end
					health.EltruismGradientBgTexture = targetTexture
				end
			end
			if db.usedeadbackdrop and isDead then
				local deadMin, deadMax = ElvUI_EltreumUI:GetDeadColors()
				health.backdropTex:SetGradient("HORIZONTAL", deadMin, deadMax)
			elseif db.usedeadbackdrop and isDisconnected then
				local discMin, discMax = ElvUI_EltreumUI:GetDisconnectedColors()
				health.backdropTex:SetGradient("HORIZONTAL", discMin, discMax)
			else
				local minColor, maxColor = ElvUI_EltreumUI:GetHealthGradient(buttonclass, false, isCustom)
				health.backdropTex:SetGradient(db.orientation, minColor, maxColor)
			end
		end
	end
	if not db.enable and not UFdb.ufcustomtexture.enable then
		if UFdb.darkmode and health.backdropTex then
			local fetchedTex = E.LSM:Fetch("statusbar", E.db.unitframe.statusbar or UF.db.statusbar)
			if fetchedTex and health.EltruismBackdropTexture ~= fetchedTex then
				health.backdropTex:SetTexture(fetchedTex)
				health.EltruismBackdropTexture = fetchedTex
			end
			local missingHealthAlpha = (transparentHealth and rawAlpha == 1 and healthAlpha < 1) and healthAlpha or rawAlpha
			health.backdropTex:SetAlpha(missingHealthAlpha)
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

local function HealthBar_PostUpdateHealthColor(healthBar, unit)
	local UFdb = E.db.ElvUI_EltreumUI.unitframes
	local db = UFdb.gradientmode
	if not db then return end
	if not healthBar then return end
	if ElvUI_EltreumUI:EncounterCheck() then return end
	if not (E.private.unitframe.enable and UFdb.UFmodifications and db.enable and UFdb.hasMode) then return end

	local parent = healthBar.origParent or (healthBar.GetParent and healthBar:GetParent())
	if not parent then
		ElvUI_EltreumUI:GradientUF(unit)
		return
	end

	local frameType = parent.unitframeType
	if not frameType then
		local fUnit = parent.__unit or parent.unit or unit
		if fUnit then
			parent.__unit = fUnit
			ElvUI_EltreumUI:ApplyGroupGradient(parent, true)
		end
		return
	end

	local info = individualUnits[frameType]
	if info then
		ElvUI_EltreumUI:ApplyUnitGradient(unit or frameType, info.name, info.db, nil, parent)
	elseif frameType == "boss" then
		local frameName = parent:GetName()
		if frameName then
			ElvUI_EltreumUI:ApplyUnitGradient(unit or parent.unit or parent.__unit, frameName:sub(7), "boss", true, parent)
		end
	elseif frameType == "arena" then
		local frameName = parent:GetName()
		if frameName then
			ElvUI_EltreumUI:ApplyUnitGradient(unit or parent.unit or parent.__unit, frameName:sub(7), "arena", true, parent)
		end
	else
		if not parent.__unit and (unit or parent.unit) then
			parent.__unit = unit or parent.unit
		end
		ElvUI_EltreumUI:ApplyGroupGradient(parent, true)
	end
end

local function ApplyGroupGradientChildren(...)
	for i = 1, select("#", ...) do
		local frame = select(i, ...)
		if frame.Health then
			ElvUI_EltreumUI:ApplyGroupGradient(frame, true)
		end
	end
end

local forced = false
function ElvUI_EltreumUI:GradientUF(unit)
	local UFdb = E.db.ElvUI_EltreumUI.unitframes
	local db = UFdb.gradientmode
	if not db then return end
	if self and type(self) == "table" and self ~= ElvUI_EltreumUI and self.GetParent and self.GetObjectType and self:GetObjectType() == "StatusBar" then
		HealthBar_PostUpdateHealthColor(self, unit)
		return
	end
	if ElvUI_EltreumUI:EncounterCheck() then return end
	if E.private.unitframe.enable and UFdb.UFmodifications and db.enable and UFdb.hasMode then

		--main issue = the toggle for some units like boss and arena wont work bc it checks for boss1,boss2... instead of just boss
		ElvUI_EltreumUI:ApplyUnitGradient("player", "Player", "player")
		if UnitExists("target") then
			ElvUI_EltreumUI:ApplyUnitGradient("target", "Target", "target")
		end
		if UnitExists("targettarget") then
			ElvUI_EltreumUI:ApplyUnitGradient("targettarget", "TargetTarget", "targettarget")
		end
		if UnitExists("targettargettarget") then
			ElvUI_EltreumUI:ApplyUnitGradient("targettargettarget", "TargetTargetTarget", "targettargettarget")
		end
		if UnitExists("pet") then
			ElvUI_EltreumUI:ApplyUnitGradient("pet", "Pet", "pet")
		end

		if not E.Classic then
			for i = 1, 8 do
				if UnitExists("boss"..i) then
					ElvUI_EltreumUI:ApplyUnitGradient("boss"..i, "Boss"..i, "boss", true)
				end
			end
			if UnitExists("focus") then
				ElvUI_EltreumUI:ApplyUnitGradient("focus", "Focus", "focus")
			end
			if UnitExists("focustarget") then
				ElvUI_EltreumUI:ApplyUnitGradient("focustarget", "FocusTarget", "focustarget")
			end
			for i = 1, 5 do
				if UnitExists("arena"..i) then
					ElvUI_EltreumUI:ApplyUnitGradient("arena"..i, "Arena"..i, "arena", true)
				end
			end
		end

		forced = (unit == "testunit")

		if forced then
			if not E.Classic then
				for i = 1, 8 do ElvUI_EltreumUI:ApplyUnitGradient("player", "Boss"..i, "boss", true) end
				for i = 1, 5 do ElvUI_EltreumUI:ApplyUnitGradient("player", "Arena"..i, "arena", true) end
			end
		end

		--group/raid unitframes
		if UnitInParty("player") or UnitInRaid("player") or forced then

			--party/raid
			if _G["ElvUF_Party"] and _G["ElvUF_Party"]:IsVisible() then
				--print("party gradient firing",math.random(1,99))
				local party = _G["ElvUF_PartyGroup1"]
				if party then
					ApplyGroupGradientChildren(party:GetChildren())
				end
				if E.db.unitframe.units.party.petsGroup.enable then
					if _G["ElvUF_PartyGroup1UnitButton1Pet"] and _G["ElvUF_PartyGroup1UnitButton1Pet"]:IsVisible() then
						for i = 1, 5 do
							local partypetbutton = _G["ElvUF_PartyGroup1UnitButton"..i.."Pet"]
							if partypetbutton and partypetbutton.Health then
								ElvUI_EltreumUI:ApplyGroupGradient(partypetbutton)
							end
						end
					end
				end
			end
			for raidNum = 1, 3 do
				local raid = _G["ElvUF_Raid"..raidNum]
				if raid and raid:IsVisible() then
					--print("raid gradient firing",math.random(1,99))
					for i = 1, 8 do
						local group = _G["ElvUF_Raid"..raidNum.."Group"..i]
						if group then
							ApplyGroupGradientChildren(group:GetChildren())
						end
					end
				end
			end

			--tank/assist
			UpdateTankAssistFrames("ElvUF_TankUnitButton")
			UpdateTankAssistFrames("ElvUF_AssistUnitButton")

			--raid pets
			if _G["ElvUF_RaidpetGroup1UnitButton1"] and _G["ElvUF_RaidpetGroup1UnitButton1"]:IsVisible() and E.db.unitframe.units.raidpet.enable then
				for i = 1, 40 do
					local raidpetbutton = _G["ElvUF_RaidpetGroup1UnitButton"..i]
					if raidpetbutton and raidpetbutton.Health then
						ElvUI_EltreumUI:ApplyGroupGradient(raidpetbutton, true)
					end
				end
			end
		end
	end
end

function ElvUI_EltreumUI:UF_Update_StatusBars()
	ElvUI_EltreumUI.EltruismTextureVersion = ElvUI_EltreumUI.EltruismTextureVersion + 1
	if ElvUI_EltreumUI.GradientUF then
		ElvUI_EltreumUI:GradientUF()
	end
	if ElvUI_EltreumUI.GradientPower then
		ElvUI_EltreumUI:GradientPower()
	end
end
ElvUI_EltreumUI:SecureHook(UF, "Update_StatusBars", "UF_Update_StatusBars")

function ElvUI_EltreumUI:UF_CreateAndUpdateUF(_, unit)
	if ElvUI_EltreumUI.CustomTexture then
		ElvUI_EltreumUI:CustomTexture(unit)
	end
	if ElvUI_EltreumUI.GradientUF then
		ElvUI_EltreumUI:GradientUF(unit)
	end
	if ElvUI_EltreumUI.GradientPower then
		ElvUI_EltreumUI:GradientPower(unit)
	end
end

--player unitframe needs this otherwise the value will be wrong when its transparent
--since it loads before other frames
if E.CoroutineCallback then
	ElvUI_EltreumUI:SecureHook(UF, "CreateAndUpdateUF", "UF_CreateAndUpdateUF")
	local function Update_UnitFrameTransparencyFix(frame)
		local UFdb = E.db.ElvUI_EltreumUI.unitframes
		if frame and frame.Health and UFdb.UFmodifications then
			local frameType = frame.unitframeType
			if frameType then
				local info = individualUnits[frameType]
				if info then
					ElvUI_EltreumUI:ApplyUnitCustomTexture(frame.__unit or frameType, info.name, info.db, nil, frame)
					if UFdb.gradientmode.enable and UFdb.hasMode then
						ElvUI_EltreumUI:ApplyUnitGradient(frame.__unit or frameType, info.name, info.db, nil, frame)
					end
				end
			end
			if frame.Power and UFdb.gradientmode.enablepower then
				frame.Power.EltruismTextureVersion = nil
				ElvUI_EltreumUI:UF_PostUpdatePowerColor(frame.Power, frame.__unit or frame.unit)
			end
		end
	end
	E:CoroutineCallback(UF.Update_UnitFrame, function(_, frame)
		Update_UnitFrameTransparencyFix(frame)
	end)
	local function UpdateGroupTransparencyChildren(...)
		for i = 1, select("#", ...) do
			local frame = select(i, ...)
			if frame.Health then
				Update_UnitFrameTransparencyFix(frame)
			else
				UpdateGroupTransparencyChildren(frame:GetChildren())
			end
		end
	end
	E:CoroutineCallback(UF.Update_GroupFrame, function(group)
		local header = UF[group]
		if not header then return end
		UpdateGroupTransparencyChildren(header:GetChildren())
	end)
end

function ElvUI_EltreumUI:UF_UpdateTestUnitFrames()
	if ElvUI_EltreumUI.CustomTexture then
		ElvUI_EltreumUI:CustomTexture("testunit")
	end
	if ElvUI_EltreumUI.GradientUF then
		ElvUI_EltreumUI:GradientUF("testunit")
	end
	if ElvUI_EltreumUI.GradientPower then
		ElvUI_EltreumUI:GradientPower("testunit")
	end
end

function ElvUI_EltreumUI:UF_ToggleForceShowGroupFrames(_, group, numGroup)
	ElvUI_EltreumUI:UF_UpdateTestUnitFrames()
	if ElvUI_EltreumUI.Blinkii_ToggleForceShowGroupFrames then
		ElvUI_EltreumUI:Blinkii_ToggleForceShowGroupFrames(group, numGroup)
	end
end

function ElvUI_EltreumUI:UF_HeaderConfig(_, header)
	ElvUI_EltreumUI:UF_UpdateTestUnitFrames()
	if ElvUI_EltreumUI.Blinkii_HeaderConfig then
		ElvUI_EltreumUI:Blinkii_HeaderConfig(header)
	end
end

--allows previews to show custom textures and gradients
ElvUI_EltreumUI:SecureHook(UF, "ToggleForceShowGroupFrames", "UF_ToggleForceShowGroupFrames")
--omnicd fix
ElvUI_EltreumUI:SecureHook(UF, "HeaderConfig", "UF_HeaderConfig")
