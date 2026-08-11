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
	if _G[button.."1"] and _G[button.."1"]:IsVisible() then
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

--set the backdrop gradient
function ElvUI_EltreumUI:ApplyGradientBackdrop(unit,frame,englishClass,reactionunit,isGroupFrame,name)
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
		if E.db.unitframe.colors.transparentHealth then
			if frame.Health and frame.Health.backdrop then
				if E.db.unitframe.thinBorders then
					frame.Health.backdrop:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
				else
					frame.Health.backdrop.Center:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
				end
				if E.db.ElvUI_EltreumUI.unitframes.lightmode then
					if frame.Health.bg then
						frame.Health.bg:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
					end
					if frame.Health.backdropTex then
						frame.Health.backdropTex:SetVertexColor(0,0,0,E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
					end
				end
			end
		end

		if not frame.EltruismDebuffExists then
			local isPlayer = UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit))

			local colorClass = "BACKDROP"
			local invert = false
			if isGroupFrame then
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorbackdrop then
					colorClass = "NPCFRIENDLY"
				end
			else
				if not isPlayer and not reactionunit then
					return
				end

				if invertframes[name] then
					invert = true
				elseif name == 'Target' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversetarget then
					invert = true
				elseif name == 'Focus' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversefocus then
					invert = true
				end

				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorbackdrop then
					if isPlayer then
						colorClass = englishClass
					else
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
				end
			end

			local minColor, maxColor
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
				minColor, maxColor = ElvUI_EltreumUI:GradientColorsCustom(colorClass, invert, true, true)
			else
				minColor, maxColor = ElvUI_EltreumUI:GradientColors(colorClass, invert, true, true)
			end

			-- Apply to explicit lightmode / darkmode structures
			if E.db.ElvUI_EltreumUI.unitframes.lightmode then
				if frame.Health.backdropTex then
					frame.Health.backdropTex:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
					frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, minColor, maxColor)
				end
			elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
				if frame.Health.backdrop.Center then
					frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, minColor, maxColor)
				end
			end
		else
			local r, g, b, a = frame.EltruismDebuffr, frame.EltruismDebuffg, frame.EltruismDebuffb, frame.EltruismDebuffa
			if E.db.ElvUI_EltreumUI.unitframes.lightmode then
				if frame.Health.backdropTex then
					frame.Health.backdropTex:SetGradient("HORIZONTAL", {r = r, g = g, b = b, a = a}, {r = r, g = g, b = b, a = a})
				end
			elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
				if frame.Health.backdrop.Center then
					frame.Health.backdrop.Center:SetGradient("HORIZONTAL", {r = r, g = g, b = b, a = a}, {r = r, g = g, b = b, a = a})
				end
			end
		end
		if E.db.ElvUI_EltreumUI.unitframes.gradientmode.usedeadbackdrop then
			local stateColor
			if UnitIsDeadOrGhost(unit) then
				stateColor = E.db.unitframe.colors.health_backdrop_dead
			elseif UnitIsTapDenied(unit) then
				stateColor = E.db.unitframe.colors.tapped
			elseif not UnitIsConnected(unit) then
				stateColor = E.db.unitframe.colors.disconnected
			end
			if stateColor then
				if E.db.ElvUI_EltreumUI.unitframes.lightmode then
					if frame.Health.backdropTex then
						frame.Health.backdropTex:SetGradient("HORIZONTAL", {r = ElvUI_EltreumUI:Interval(stateColor.r - 0.3, 0, 1), g = ElvUI_EltreumUI:Interval(stateColor.g - 0.3, 0, 1), b = ElvUI_EltreumUI:Interval(stateColor.b - 0.3, 0, 1), a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r = stateColor.r, g = stateColor.g, b = stateColor.b, a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
					end
				elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
					if frame.Health.backdrop.Center then
						frame.Health.backdrop.Center:SetGradient("HORIZONTAL", {r = ElvUI_EltreumUI:Interval(stateColor.r - 0.3, 0, 1), g = ElvUI_EltreumUI:Interval(stateColor.g - 0.3, 0, 1), b = ElvUI_EltreumUI:Interval(stateColor.b - 0.3, 0, 1), a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r = stateColor.r, g = stateColor.g, b = stateColor.b, a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
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
		if not E:NotSecretValue(classunit) then return end --dont do gradient when class is secret (cant get colors)
		local reaction = UnitReaction(unit, "player")
		local unitframe = _G["ElvUF_"..name]
		local orientation = E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation or "HORIZONTAL"

		local isPlayer = UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit))
		local isCharmed = E:NotSecretValue(UnitIsCharmed(unit)) and UnitIsCharmed(unit) or false

		local isActualPlayer = false
		if unitframe and unitframe.Health then
			if unitframe.realUnit then
				if name == "Player" and unitframe.unit == "vehicle" then
					isPlayer = false
					isActualPlayer = false
				end
				if name == "Pet" and unitframe.unit == "player" then
					isPlayer = true
					isActualPlayer = true
					classunit = E.myclass
				end
			end
			if not noOrientation then
				unitframe.Health:SetOrientation(E.db.ElvUI_EltreumUI.unitframes.UForientation)
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
				colorClass = classunit
			else
				if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
					colorClass = "TAPPED"
				elseif reaction then
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
			end

			local invert = false
			if invertframes[unitDB] then
				invert = true
			elseif name == 'Target' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversetarget then
				invert = true
			elseif name == 'Focus' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversefocus then
				invert = true
			end

			local minColor, maxColor
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
				minColor, maxColor = ElvUI_EltreumUI:GradientColorsCustom(colorClass, invert, E.db.unitframe.colors.transparentHealth, false, false, true)
			else
				minColor, maxColor = ElvUI_EltreumUI:GradientColors(colorClass, invert, E.db.unitframe.colors.transparentHealth, false, false, true)
			end

			if E.db.ElvUI_EltreumUI.unitframes.lightmode then
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db["ElvUI_EltreumUI"]["unitframes"]["gradientmode"]["enable"..unitDB] then
					if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture then
							unitframe.Health:GetStatusBarTexture():SetTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
						else
							unitframe.Health:GetStatusBarTexture():SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
						end
					end
					unitframe.Health:GetStatusBarTexture():SetGradient(orientation, minColor, maxColor)
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.usedeadbackdrop then
						if UnitIsDeadOrGhost(unit) then
							unitframe.Health:GetStatusBarTexture():SetGradient(orientation, {r = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.r - 0.3, 0, 1), g = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.g - 0.3, 0, 1), b = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.b - 0.3, 0, 1), a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r = E.db.unitframe.colors.health_backdrop_dead.r, g = E.db.unitframe.colors.health_backdrop_dead.g, b = E.db.unitframe.colors.health_backdrop_dead.b, a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
						elseif not UnitIsConnected(unit) then
							unitframe.Health:GetStatusBarTexture():SetGradient(orientation, {r = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.disconnected.r - 0.3, 0, 1), g = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.disconnected.g - 0.3, 0, 1), b = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.disconnected.b - 0.3, 0, 1), a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r = E.db.unitframe.colors.disconnected.r, g = E.db.unitframe.colors.disconnected.g, b = E.db.unitframe.colors.disconnected.b, a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
						end
					end
				end
			elseif E.db.ElvUI_EltreumUI.unitframes.darkmode and unitframe.Health.backdropTex then
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db["ElvUI_EltreumUI"]["unitframes"]["gradientmode"]["enable"..unitDB] then
					if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture then
							unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
						else
							unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
						end
					end
					unitframe.Health.backdropTex:SetGradient(orientation, minColor, maxColor)
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.usedeadbackdrop then
						if UnitIsDeadOrGhost(unit) then
							unitframe.Health.backdropTex:SetGradient(orientation, {r = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.r - 0.3, 0, 1), g = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.g - 0.3, 0, 1), b = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.b - 0.3, 0, 1), a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r = E.db.unitframe.colors.health_backdrop_dead.r, g = E.db.unitframe.colors.health_backdrop_dead.g, b = E.db.unitframe.colors.health_backdrop_dead.b, a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
						elseif not UnitIsConnected(unit) then
							unitframe.Health.backdropTex:SetGradient(orientation, {r = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.disconnected.r - 0.3, 0, 1), g = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.disconnected.g - 0.3, 0, 1), b = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.disconnected.b - 0.3, 0, 1), a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r = E.db.unitframe.colors.disconnected.r, g = E.db.unitframe.colors.disconnected.g, b = E.db.unitframe.colors.disconnected.b, a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
						end
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
	local _, buttonclass
	--due to raid pet, check if is player
	if UnitIsPlayer(button.unit) or (E.Retail and UnitInPartyIsAI(button.unit)) then --C_LFGInfo.IsInLFGFollowerDungeon() could be used
		_, buttonclass = UnitClass(button.unit)
	else
		buttonclass = "NPCFRIENDLY"
	end
	if not E:NotSecretValue(buttonclass) then return end --dont do gradient when class is secret (cant get colors)
	if buttonclass and button.Health then
		if not noOrientation then
			button.Health:SetOrientation(E.db.ElvUI_EltreumUI.unitframes.UForientation)
		end
		if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
			ElvUI_EltreumUI:ApplyGradientBackdrop(button.unit,button,buttonclass,nil,true)
		end
		local minColor, maxColor
		if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
			minColor, maxColor = ElvUI_EltreumUI:GradientColorsCustom(buttonclass, false, E.db.unitframe.colors.transparentHealth, false, false, true)
		else
			minColor, maxColor = ElvUI_EltreumUI:GradientColors(buttonclass, false, E.db.unitframe.colors.transparentHealth, false, false, true)
		end
		if E.db.ElvUI_EltreumUI.unitframes.lightmode then
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablegroupunits then
				if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture then
						button.Health:GetStatusBarTexture():SetTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
					else
						button.Health:GetStatusBarTexture():SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
					end
				end
				button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, minColor, maxColor)
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.usedeadbackdrop then
					if UnitIsDeadOrGhost(button.unit) then
						button.Health:GetStatusBarTexture():SetGradient("HORIZONTAL", {r = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.r - 0.3, 0, 1), g = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.g - 0.3, 0, 1), b = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.b - 0.3, 0, 1), a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r = E.db.unitframe.colors.health_backdrop_dead.r, g = E.db.unitframe.colors.health_backdrop_dead.g, b = E.db.unitframe.colors.health_backdrop_dead.b, a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
					elseif not UnitIsConnected(button.unit) then
						button.Health:GetStatusBarTexture():SetGradient("HORIZONTAL", {r = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.disconnected.r - 0.3, 0, 1), g = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.disconnected.g - 0.3, 0, 1), b = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.disconnected.b - 0.3, 0, 1), a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r = E.db.unitframe.colors.disconnected.r, g = E.db.unitframe.colors.disconnected.g, b = E.db.unitframe.colors.disconnected.b, a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
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
		elseif E.db.ElvUI_EltreumUI.unitframes.darkmode and button.Health.backdropTex then
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablegroupunits then
				if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture then
						button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
					else
						button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
					end
				end
				button.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, minColor, maxColor)
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.usedeadbackdrop then
					if UnitIsDeadOrGhost(button.unit) then
						button.Health.backdropTex:SetGradient("HORIZONTAL", {r = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.r - 0.3, 0, 1), g = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.g - 0.3, 0, 1), b = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.b - 0.3, 0, 1), a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r = E.db.unitframe.colors.health_backdrop_dead.r, g = E.db.unitframe.colors.health_backdrop_dead.g, b = E.db.unitframe.colors.health_backdrop_dead.b, a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
					elseif not UnitIsConnected(button.unit) then
						button.Health.backdropTex:SetGradient("HORIZONTAL", {r = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.disconnected.r - 0.3, 0, 1), g = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.disconnected.g - 0.3, 0, 1), b = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.disconnected.b - 0.3, 0, 1), a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r = E.db.unitframe.colors.disconnected.r, g = E.db.unitframe.colors.disconnected.g, b = E.db.unitframe.colors.disconnected.b, a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
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

local forced = false
function ElvUI_EltreumUI:GradientUF(unit)
	if ElvUI_EltreumUI:EncounterCheck() then return end
	if E.private.unitframe.enable and E.db.ElvUI_EltreumUI.unitframes.UFmodifications and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and (E.db.ElvUI_EltreumUI.unitframes.lightmode or E.db.ElvUI_EltreumUI.unitframes.darkmode) then

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
		if _G.UnitInParty("player") or _G.UnitInRaid("player") or forced then

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
hooksecurefunc(UF, "PostUpdateHealthColor", ElvUI_EltreumUI.GradientUF)
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
