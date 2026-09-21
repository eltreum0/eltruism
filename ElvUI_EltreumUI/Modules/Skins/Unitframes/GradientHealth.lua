local E = unpack(ElvUI)
local UF = E:GetModule('UnitFrames')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
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

--function to check if colormixin tables are equal, if they are return false since its used to do something after that
function ElvUI_EltreumUI:ColorMixinTableMatching(table1,table2)
	local r1,g1,b1,a1 = table1.r,table1.g,table1.b,table1.a
	local r2,g2,b2,a2 = table2.r,table2.g,table2.b,table2.a
	if r1 == r2 and g1 == g2 and b1 == b2 and a1 == a2 then
		return false
	else
		return true
	end
end

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

local backdropEpoch = 0
function ElvUI_EltreumUI:IncrementHealthBackdropEpoch()
	backdropEpoch = backdropEpoch + 1
end

--set the backdrop gradient
function ElvUI_EltreumUI:ApplyGradientBackdrop(unit,frame,englishClass,reactionunit,isGroupFrame,unitDB)
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
		local isPlayer = UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit))
		if isPlayer and (not E:NotSecretValue(englishClass) or not englishClass) then
			englishClass = "ELTRUISM"
		end
		local colorClass = "BACKDROP"
		local invert = false
		if isGroupFrame then
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorbackdrop then
				colorClass = englishClass
			end
		else
			if invertframes[unitDB] then
				invert = true
			elseif unitDB == 'target' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversetarget then
				invert = true
			elseif unitDB == 'focus' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversefocus then
				invert = true
			end

			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorbackdrop then
				if isPlayer then
					colorClass = englishClass
				else
					if reactionunit and E:NotSecretValue(reactionunit) then
						if reactionunit >= 5 then
							colorClass = "NPCFRIENDLY"
						elseif reactionunit == 4 then
							colorClass = "NPCNEUTRAL"
						elseif reactionunit == 3 then
							colorClass = "NPCUNFRIENDLY"
						elseif reactionunit <= 2 then
							colorClass = "NPCHOSTILE"
						end
					end
					if not colorClass or colorClass == "BACKDROP" then
						local canAttack = UnitCanAttack("player", unit)
						if E:NotSecretValue(canAttack) and canAttack then
							colorClass = "NPCHOSTILE"
						else
							local isEnemy = UnitIsEnemy("player", unit)
							if E:NotSecretValue(isEnemy) and isEnemy then
								colorClass = "NPCHOSTILE"
							else
								local isFriend = UnitIsFriend("player", unit)
								if E:NotSecretValue(isFriend) and isFriend then
									colorClass = "NPCFRIENDLY"
								else
									colorClass = "NPCHOSTILE"
								end
							end
						end
					end
				end
			end
		end

		local deadState = 0
		if E.db.ElvUI_EltreumUI.unitframes.gradientmode.usedeadbackdrop then
			local isDead = UnitIsDeadOrGhost(unit)
			if E:NotSecretValue(isDead) and isDead then
				deadState = 1
			elseif isPlayer then
				local isConnected = UnitIsConnected(unit)
				if not (E:NotSecretValue(isConnected) and isConnected) then
					deadState = 3
				end
			else
				local isTap = UnitIsTapDenied(unit)
				if E:NotSecretValue(isTap) and isTap then
					deadState = 2
				end
			end
		end

		local isCustom = E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor
		local orientation = E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation or "HORIZONTAL"

		if frame.EltruismBackdropEpoch == backdropEpoch and
			frame.EltruismBackdropClass == colorClass and
			frame.EltruismBackdropDead == deadState and
			frame.EltruismBackdropInvert == invert and
			frame.EltruismBackdropDebuff == frame.EltruismDebuffExists and
			(not frame.EltruismDebuffExists or (
				frame.EltruismBackdropDebuffR == frame.EltruismDebuffr and
				frame.EltruismBackdropDebuffG == frame.EltruismDebuffg and
				frame.EltruismBackdropDebuffB == frame.EltruismDebuffb and
				frame.EltruismBackdropDebuffA == frame.EltruismDebuffa
			))
		then
			return
		end

		frame.EltruismBackdropEpoch = backdropEpoch
		frame.EltruismBackdropClass = colorClass
		frame.EltruismBackdropDead = deadState
		frame.EltruismBackdropInvert = invert
		frame.EltruismBackdropDebuff = frame.EltruismDebuffExists
		if frame.EltruismDebuffExists then
			frame.EltruismBackdropDebuffR = frame.EltruismDebuffr
			frame.EltruismBackdropDebuffG = frame.EltruismDebuffg
			frame.EltruismBackdropDebuffB = frame.EltruismDebuffb
			frame.EltruismBackdropDebuffA = frame.EltruismDebuffa
		end

		if E.db.unitframe.colors.transparentHealth or E.db.ElvUI_EltreumUI.unitframes.lightmode then
			if frame.Health and frame.Health.backdrop then
				local backdropAlpha = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha or 1
				if backdropAlpha == 1 and E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.healthalpha and E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.healthalpha < 1 then
					backdropAlpha = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.healthalpha
				end
				frame.Health.backdrop:SetAlpha(backdropAlpha)
				if E.db.ElvUI_EltreumUI.unitframes.lightmode then
					frame.Health.backdrop:SetBackdropColor(0, 0, 0, 0)
					if frame.Health.backdrop.Center then
						frame.Health.backdrop.Center:Hide()
					end
					if frame.Health.bg then
						frame.Health.bg:SetAlpha(backdropAlpha)
						frame.Health.bg:SetVertexColor(0, 0, 0, backdropAlpha)
					end
					if frame.Health.backdropTex then
						frame.Health.backdropTex:SetAlpha(backdropAlpha)
						if not frame.EltruismDebuffExists then
							frame.Health.backdropTex:SetVertexColor(0, 0, 0, backdropAlpha)
						end
					end
				else
					frame.Health.backdrop:SetBackdropColor(0, 0, 0, backdropAlpha)
					if frame.Health.backdrop.Center then
						frame.Health.backdrop.Center:Show()
						frame.Health.backdrop.Center:SetAlpha(backdropAlpha)
					end
				end
			end
		end

		if not frame.EltruismDebuffExists then
			local minColor, maxColor = ElvUI_EltreumUI:GetBackdropGradient(colorClass, invert, isCustom)

			if E.db.ElvUI_EltreumUI.unitframes.lightmode then
				if frame.Health.backdropTex then
					frame.Health.backdropTex:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
					frame.Health.backdropTex:SetGradient(orientation, minColor, maxColor)
				end
				if frame.Health.bg then
					frame.Health.bg:SetGradient(orientation, minColor, maxColor)
				end
			elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
				if frame.Health.backdrop.Center then
					frame.Health.backdrop.Center:SetGradient(orientation, minColor, maxColor)
				end
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
			if E.db.ElvUI_EltreumUI.unitframes.lightmode then
				if frame.Health.backdropTex then
					frame.Health.backdropTex:SetGradient("HORIZONTAL", debuffColor, debuffColor)
				end
				if frame.Health.bg then
					frame.Health.bg:SetGradient("HORIZONTAL", debuffColor, debuffColor)
				end
			elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
				if frame.Health.backdrop.Center then
					frame.Health.backdrop.Center:SetGradient("HORIZONTAL", debuffColor, debuffColor)
				end
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
				if E.db.ElvUI_EltreumUI.unitframes.lightmode then
					if frame.Health.backdropTex then
						frame.Health.backdropTex:SetGradient("HORIZONTAL", stateMin, stateMax)
					end
					if frame.Health.bg then
						frame.Health.bg:SetGradient("HORIZONTAL", stateMin, stateMax)
					end
				elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
					if frame.Health.backdrop.Center then
						frame.Health.backdrop.Center:SetGradient("HORIZONTAL", stateMin, stateMax)
					end
				end
			end
		end
	end
end

--set the textures or gradients for single units
function ElvUI_EltreumUI:ApplyUnitGradient(unit,name,unitDB,noOrientation)
	if UnitExists(unit) then
		local _, classunit = UnitClass(unit)
		local reaction = UnitReaction(unit, "player")
		local unitframe = _G["ElvUF_"..name]
		local orientation = E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation or "HORIZONTAL"

		local isPlayer = UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit))
		local isCharmed = UnitIsCharmed(unit)
		isCharmed = E:NotSecretValue(isCharmed) and isCharmed or false

		local isActualPlayer = false
		if unitframe and unitframe.Health then
			if unitframe.realUnit then
				if name == "Player" and unitframe.__unit == "vehicle" then
					isPlayer = false
					isActualPlayer = false
				end
				if name == "Pet" and unitframe.__unit == "player" then
					isPlayer = true
					isActualPlayer = true
					classunit = E.myclass
				end
			end
			local targetUFOrientation = E.db.ElvUI_EltreumUI.unitframes.UForientation
			if not noOrientation and targetUFOrientation and unitframe.Health.EltruismOrientation ~= targetUFOrientation then
				unitframe.Health:SetOrientation(targetUFOrientation)
				unitframe.Health.EltruismOrientation = targetUFOrientation
			end
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
				ElvUI_EltreumUI:ApplyGradientBackdrop(unit,unitframe,classunit,reaction,false,unitDB)
			end
			if E.db.ElvUI_EltreumUI.unitframes.lightmode and E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdrophidden then
				if unitframe.Health.backdropTex then
					unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdroptexture))
					if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdroptexturestaticsize then
						unitframe.Health.backdropTex:SetAllPoints(unitframe.Health)
						if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.fliptargetbackdrop and name == 'Target' then
							unitframe.Health.backdropTex:SetTexCoord(1, 0, 0, 1)
						end
					end
				end
			end

			local colorClass = "BACKDROP"
			if (isPlayer and not isCharmed) or isActualPlayer then
				if not E:NotSecretValue(classunit) or not classunit then
					classunit = E.myclass or "ELTRUISM"
				end
				colorClass = classunit
			else
				local isTap = UnitIsTapDenied(unit)
				isTap = E:NotSecretValue(isTap) and isTap
				local isPlayerControlled = UnitPlayerControlled(unit)
				isPlayerControlled = E:NotSecretValue(isPlayerControlled) and isPlayerControlled
				if isTap and not isPlayerControlled then
					colorClass = "TAPPED"
				else
					if reaction and E:NotSecretValue(reaction) then
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
					if not colorClass or colorClass == "BACKDROP" then
						local canAttack = UnitCanAttack("player", unit)
						if E:NotSecretValue(canAttack) and canAttack then
							colorClass = "NPCHOSTILE"
						else
							local isEnemy = UnitIsEnemy("player", unit)
							if E:NotSecretValue(isEnemy) and isEnemy then
								colorClass = "NPCHOSTILE"
							else
								local isFriend = UnitIsFriend("player", unit)
								if E:NotSecretValue(isFriend) and isFriend then
									colorClass = "NPCFRIENDLY"
								else
									colorClass = "NPCHOSTILE"
								end
							end
						end
					end
				end
			end

			local invert = false
			if invertframes[unitDB] then
				invert = true
			elseif name == 'Target' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversetarget then
				invert = true
			elseif name == 'Focus' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversefocus then
				invert = true
			end

			local isCustom = E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor
			local minColor, maxColor = ElvUI_EltreumUI:GetHealthGradient(colorClass, invert, isCustom)

			local isDead = UnitIsDeadOrGhost(unit)
			isDead = E:NotSecretValue(isDead) and isDead
			local isDisconnected = UnitIsConnected(unit)
			isDisconnected = isPlayer and not (E:NotSecretValue(isDisconnected) and isDisconnected)

			if E.db.ElvUI_EltreumUI.unitframes.lightmode then
				local backdropAlpha = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha or 1
				if backdropAlpha == 1 and E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.healthalpha and E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.healthalpha < 1 then
					backdropAlpha = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.healthalpha
				end
				if unitframe.Health.bg then
					unitframe.Health.bg:SetAlpha(backdropAlpha)
					unitframe.Health.bg:SetVertexColor(0, 0, 0, backdropAlpha)
				end
				if unitframe.Health.backdrop then
					unitframe.Health.backdrop:SetAlpha(backdropAlpha)
					unitframe.Health.backdrop:SetBackdropColor(0, 0, 0, 0)
					if unitframe.Health.backdrop.Center then
						unitframe.Health.backdrop.Center:Hide()
					end
				end
				if unitframe.Health.backdropTex and not unitframe.EltruismDebuffExists then
					unitframe.Health.backdropTex:SetAlpha(backdropAlpha)
					unitframe.Health.backdropTex:SetVertexColor(0, 0, 0, backdropAlpha)
				end

				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db["ElvUI_EltreumUI"]["unitframes"]["gradientmode"]["enable"..unitDB] then
					local barTex = unitframe.Health:GetStatusBarTexture()
					if barTex then
						if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture then
								barTex:SetTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
							else
								barTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
							end
						end
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.usedeadbackdrop and isDead then
							local deadMin, deadMax = ElvUI_EltreumUI:GetDeadColors()
							barTex:SetGradient(orientation, deadMin, deadMax)
						elseif E.db.ElvUI_EltreumUI.unitframes.gradientmode.usedeadbackdrop and isDisconnected then
							local discMin, discMax = ElvUI_EltreumUI:GetDisconnectedColors()
							barTex:SetGradient(orientation, discMin, discMax)
						else
							barTex:SetGradient(orientation, minColor, maxColor)
						end
					end
				end
			elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
				if unitframe.Health.backdrop and unitframe.Health.backdrop.Center then
					unitframe.Health.backdrop.Center:Show()
				end
				if unitframe.Health.backdropTex and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db["ElvUI_EltreumUI"]["unitframes"]["gradientmode"]["enable"..unitDB] then
					if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture then
							unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
						else
							unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
						end
					end
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.usedeadbackdrop and isDead then
						local deadMin, deadMax = ElvUI_EltreumUI:GetDeadColors()
						unitframe.Health.backdropTex:SetGradient(orientation, deadMin, deadMax)
					elseif E.db.ElvUI_EltreumUI.unitframes.gradientmode.usedeadbackdrop and isDisconnected then
						local discMin, discMax = ElvUI_EltreumUI:GetDisconnectedColors()
						unitframe.Health.backdropTex:SetGradient(orientation, discMin, discMax)
					else
						unitframe.Health.backdropTex:SetGradient(orientation, minColor, maxColor)
					end
				end
			end
			if not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
				if E.db.ElvUI_EltreumUI.unitframes.darkmode and unitframe.Health.backdropTex then
					unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdroptexture))
					unitframe.Health.backdropTex:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
				end
			end
		end
	end
end

--set the textures or gradients for group units
function ElvUI_EltreumUI:ApplyGroupGradient(button,noOrientation)
	local unit = button.__unit or button.unit
	if not unit then return end
	local _, buttonclass
	local isPlayer = UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit))
	--due to raid pet, check if is player
	if isPlayer then --C_LFGInfo.IsInLFGFollowerDungeon() could be used
		_, buttonclass = UnitClass(unit)
		if not E:NotSecretValue(buttonclass) or not buttonclass then
			buttonclass = "NPCFRIENDLY"
		end
	else
		buttonclass = "NPCFRIENDLY"
	end
	if buttonclass and button.Health then
		local targetUFOrientation = E.db.ElvUI_EltreumUI.unitframes.UForientation
		if not noOrientation and targetUFOrientation and button.Health.EltruismOrientation ~= targetUFOrientation then
			button.Health:SetOrientation(targetUFOrientation)
			button.Health.EltruismOrientation = targetUFOrientation
		end
		if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
			ElvUI_EltreumUI:ApplyGradientBackdrop(unit,button,buttonclass,nil,true)
		end
		local isCustom = E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor
		local minColor, maxColor = ElvUI_EltreumUI:GetHealthGradient(buttonclass, false, isCustom)

		local isDead = UnitIsDeadOrGhost(unit)
		isDead = E:NotSecretValue(isDead) and isDead
		local isDisconnected = UnitIsConnected(unit)
		isDisconnected = isPlayer and not (E:NotSecretValue(isDisconnected) and isDisconnected)

		if E.db.ElvUI_EltreumUI.unitframes.lightmode then
			local backdropAlpha = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha or 1
			if backdropAlpha == 1 and E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.healthalpha and E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.healthalpha < 1 then
				backdropAlpha = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.healthalpha
			end
			if button.Health.bg then
				button.Health.bg:SetAlpha(backdropAlpha)
				button.Health.bg:SetVertexColor(0, 0, 0, backdropAlpha)
			end
			if button.Health.backdrop then
				button.Health.backdrop:SetAlpha(backdropAlpha)
				button.Health.backdrop:SetBackdropColor(0, 0, 0, 0)
				if button.Health.backdrop.Center then
					button.Health.backdrop.Center:Hide()
				end
			end
			if button.Health.backdropTex and not button.EltruismDebuffExists then
				button.Health.backdropTex:SetAlpha(backdropAlpha)
				button.Health.backdropTex:SetVertexColor(0, 0, 0, backdropAlpha)
			end

			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablegroupunits then
				local barTex = button.Health:GetStatusBarTexture()
				if barTex then
					if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture then
							barTex:SetTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
						else
							barTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
						end
					end
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.usedeadbackdrop and isDead then
						local deadMin, deadMax = ElvUI_EltreumUI:GetDeadColors()
						barTex:SetGradient("HORIZONTAL", deadMin, deadMax)
					elseif E.db.ElvUI_EltreumUI.unitframes.gradientmode.usedeadbackdrop and isDisconnected then
						local discMin, discMax = ElvUI_EltreumUI:GetDisconnectedColors()
						barTex:SetGradient("HORIZONTAL", discMin, discMax)
					else
						barTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, minColor, maxColor)
					end
				end
			end
			if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdrophidden then
				if button.Health.backdropTex then
					button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdroptexture))
					if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdroptexturestaticsize then
						button.Health.backdropTex:SetAllPoints(button.Health)
					end
				end
			end
		elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
			if button.Health.backdrop and button.Health.backdrop.Center then
				button.Health.backdrop.Center:Show()
			end
			if button.Health.backdropTex then
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablegroupunits then
					if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture then
							button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
						else
							button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
						end
					end
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.usedeadbackdrop and isDead then
						local deadMin, deadMax = ElvUI_EltreumUI:GetDeadColors()
						button.Health.backdropTex:SetGradient("HORIZONTAL", deadMin, deadMax)
					elseif E.db.ElvUI_EltreumUI.unitframes.gradientmode.usedeadbackdrop and isDisconnected then
						local discMin, discMax = ElvUI_EltreumUI:GetDisconnectedColors()
						button.Health.backdropTex:SetGradient("HORIZONTAL", discMin, discMax)
					else
						button.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, minColor, maxColor)
					end
				end
			end
		end
		if not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
			if E.db.ElvUI_EltreumUI.unitframes.darkmode and button.Health.backdropTex then
				button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdroptexture))
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

local function HealthBar_PostUpdateHealthColor(healthBar, unit)
	if not healthBar then return end
	if ElvUI_EltreumUI:EncounterCheck() then return end
	if not (E.private.unitframe.enable and E.db.ElvUI_EltreumUI.unitframes.UFmodifications and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db.ElvUI_EltreumUI.unitframes.hasMode) then return end

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
		ElvUI_EltreumUI:ApplyUnitGradient(unit or frameType, info.name, info.db)
	elseif frameType == "boss" then
		local frameName = parent:GetName()
		if frameName then
			ElvUI_EltreumUI:ApplyUnitGradient(unit or parent.unit or parent.__unit, frameName:sub(7), "boss", true)
		end
	elseif frameType == "arena" then
		local frameName = parent:GetName()
		if frameName then
			ElvUI_EltreumUI:ApplyUnitGradient(unit or parent.unit or parent.__unit, frameName:sub(7), "arena", true)
		end
	else
		if not parent.__unit and (unit or parent.unit) then
			parent.__unit = unit or parent.unit
		end
		ElvUI_EltreumUI:ApplyGroupGradient(parent, true)
	end
end

local forced = false
function ElvUI_EltreumUI:GradientUF(unit)
	if self and type(self) == "table" and self ~= ElvUI_EltreumUI and self.GetParent and self.GetObjectType and self:GetObjectType() == "StatusBar" then
		HealthBar_PostUpdateHealthColor(self, unit)
		return
	end
	if ElvUI_EltreumUI:EncounterCheck() then return end
	if E.private.unitframe.enable and E.db.ElvUI_EltreumUI.unitframes.UFmodifications and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db.ElvUI_EltreumUI.unitframes.hasMode then

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
					for i = 1, select("#", party:GetChildren()) do
						local frame = select(i, party:GetChildren())
						if frame and frame.Health then
							ElvUI_EltreumUI:ApplyGroupGradient(frame, true)
						end
					end
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
							for j = 1, select("#", group:GetChildren()) do
								local frame = select(j, group:GetChildren())
								if frame and frame.Health then ElvUI_EltreumUI:ApplyGroupGradient(frame, true) end
							end
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
hooksecurefunc(UF, "PostUpdateHealthColor", HealthBar_PostUpdateHealthColor)
hooksecurefunc(UF, "Update_StatusBars", ElvUI_EltreumUI.GradientUF)

--allows previews to show custom textures and gradients
hooksecurefunc(UF, "ToggleForceShowGroupFrames", function()
	ElvUI_EltreumUI:CustomTexture("testunit")
	ElvUI_EltreumUI:GradientUF("testunit")
	ElvUI_EltreumUI:GradientPower("testunit")
end)
--omnicd fix
hooksecurefunc(UF, "HeaderConfig", function()
	ElvUI_EltreumUI:CustomTexture("testunit")
	ElvUI_EltreumUI:GradientUF("testunit")
	ElvUI_EltreumUI:GradientPower("testunit")
end)
