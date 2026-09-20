local E = unpack(ElvUI)
local UF = E:GetModule('UnitFrames')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local UnitPowerType = _G.UnitPowerType
local UnitExists = _G.UnitExists
local select = _G.select
local type = _G.type
local IsInGroup = _G.IsInGroup
local ipairs = _G.ipairs
local CreateColor = _G.CreateColor
local function clamp(val)
	if val < 0 then
		return 0
	elseif val > 1 then
		return 1
	end
	return val
end
local fallbackMin = CreateColor(1, 1, 1, 1)
local fallbackMax = CreateColor(1, 1, 1, 1)

--powers there are gradients for since retail has like 100+ power types
local powertypes ={
	["MANA"] = true,
	["RAGE"] = true,
	["FOCUS"] = true,
	["ENERGY"] = true,
	["RUNIC_POWER"] = true,
	["LUNAR_POWER"] = true,
	["ALT_POWER"] = true,
	["MAELSTROM"] = true,
	["INSANITY"] = true,
	["FURY"] = true,
	["PAIN"] = true,
}

--Apply Gradient Power Colors to Unit
function ElvUI_EltreumUI:ApplyUnitGradientPower(unit,name)
	if not unit then return end
	if E:NotSecretUnit(unit) and UnitExists(unit) then --can error now in 12.0.7?
	--if ElvUI_EltreumUI:IsThisASafeSecret(unit,true) and UnitExists(unit) then
		--print(powertype,unit)
		local _, powertype = UnitPowerType(unit)

		local unitframe = _G["ElvUF_"..name]
		if unitframe and unitframe.Power and powertype then
			if E.db.unitframe.colors.transparentPower and E.db.unitframe.colors.custompowerbackdrop then --fix transparent power custom backdrop
				if unitframe.Power.backdrop.Center then
					unitframe.Power.backdrop.Center:SetTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
					unitframe.Power.backdrop.Center:SetVertexColor(E.db.unitframe.colors.power_backdrop.r,E.db.unitframe.colors.power_backdrop.g,E.db.unitframe.colors.power_backdrop.b,E.db.general.backdropfadecolor.a)
					unitframe.Power.backdrop.Center:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
				end
				--[[local shouldFIX = unitframe.USE_MINI_POWERBAR or unitframe.USE_INSET_POWERBAR --spaced or inset only
				if not unitframe.Power.EltruismTransparencyFix and E.db.unitframe.thinBorders and shouldFIX then
					unitframe.Power.backdrop:ClearAllPoints()
					unitframe.Power.backdrop:SetAllPoints(unitframe.Power:GetStatusBarTexture())
					unitframe.Power.backdrop:SetInside(unitframe.Power:GetStatusBarTexture(), 0, 0)
					unitframe.Power.EltruismTransparencyFix = true
				end]]
			end
			if powertypes[powertype] then
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower == "HORIZONTAL" then
						if unit == "target" then
							if E.db.unitframe.colors.transparentPower and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
								unitframe.Power.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, true, true))
							else
								unitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, true, false))
							end
							if not E.db.unitframe.colors.custompowerbackdrop and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
								unitframe.Power.bg:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, true, false, true))
							end
						else
							if E.db.unitframe.colors.transparentPower and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
								unitframe.Power.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, true))
							else
								unitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
							end
							if not E.db.unitframe.colors.custompowerbackdrop and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
								unitframe.Power.bg:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false,true))
							end
						end
					else
						if E.db.unitframe.colors.transparentPower and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
							unitframe.Power.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, true))
						else
							unitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
						end
						if not E.db.unitframe.colors.custompowerbackdrop and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
							unitframe.Power.bg:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false,true))
						end
					end
				else
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower == "HORIZONTAL" then
						if unit == "target" then
							if E.db.unitframe.colors.transparentPower and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
								unitframe.Power.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, true, true))
							else
								unitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, true, false))
							end
							if not E.db.unitframe.colors.custompowerbackdrop and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
								unitframe.Power.bg:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, true, false,true))
							end
						else
							if E.db.unitframe.colors.transparentPower and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
								unitframe.Power.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, true))
							else
								unitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
							end
							if not E.db.unitframe.colors.custompowerbackdrop and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
								unitframe.Power.bg:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false,true))
							end
						end
					else
						if E.db.unitframe.colors.transparentPower and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
							unitframe.Power.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, true))
						else
							unitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
						end
						if not E.db.unitframe.colors.custompowerbackdrop and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
							unitframe.Power.bg:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false,true))
						end
					end
				end
			else
				local r,g,b = unitframe.Power:GetStatusBarColor()
				if r and ElvUI_EltreumUI:IsThisASafeSecret(r,true) then --check for it not being a secret
					if r ~= 1 and g ~= 1 and b ~= 1 then
						local orientation = E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower
						local isTarget = (unit == "target")
						local invert = isTarget and (orientation == "HORIZONTAL")
						local alpha = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha
						if invert then
							fallbackMin:SetRGBA(clamp(r + 0.2), clamp(g + 0.2), clamp(b + 0.2), alpha)
							fallbackMax:SetRGBA(clamp(r - 0.4), clamp(g - 0.4), clamp(b - 0.4), alpha)
							unitframe.Power:GetStatusBarTexture():SetGradient(orientation, fallbackMin, fallbackMax)
						else
							fallbackMin:SetRGBA(clamp(r - 0.4), clamp(g - 0.4), clamp(b - 0.4), alpha)
							fallbackMax:SetRGBA(clamp(r + 0.2), clamp(g + 0.2), clamp(b + 0.2), alpha)
							unitframe.Power:GetStatusBarTexture():SetGradient(orientation, fallbackMin, fallbackMax)
						end
						if not E.db.unitframe.colors.custompowerbackdrop and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
							local bgfade = E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade
							if invert then
								fallbackMin:SetRGBA(clamp((r + 0.2) - bgfade), clamp((g + 0.2) - bgfade), clamp((b + 0.2) - bgfade), 1)
								fallbackMax:SetRGBA(clamp((r - 0.4) - bgfade), clamp((g - 0.4) - bgfade), clamp((b - 0.4) - bgfade), 1)
								unitframe.Power.bg:SetGradient(orientation, fallbackMin, fallbackMax)
							else
								fallbackMin:SetRGBA(clamp((r - 0.4) - bgfade), clamp((g - 0.4) - bgfade), clamp((b - 0.4) - bgfade), 1)
								fallbackMax:SetRGBA(clamp((r + 0.2) - bgfade), clamp((g + 0.2) - bgfade), clamp((b + 0.2) - bgfade), 1)
								unitframe.Power.bg:SetGradient(orientation, fallbackMin, fallbackMax)
							end
						end
					end
				end
			end
		end
	end
end

--Apply Gradient Power Colors to Group Unit
function ElvUI_EltreumUI:ApplyGroupGradientPower(groupunitframe)
	if groupunitframe and groupunitframe.__unit then
		local _, powertype = UnitPowerType(groupunitframe.__unit)
		if powertype then
			if groupunitframe.Power then
				if E.db.unitframe.colors.transparentPower and E.db.unitframe.colors.custompowerbackdrop then --fix transparent power custom backdrop
					if groupunitframe.Power.backdrop.Center then
						groupunitframe.Power.backdrop.Center:SetTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
						groupunitframe.Power.backdrop.Center:SetVertexColor(E.db.unitframe.colors.power_backdrop.r,E.db.unitframe.colors.power_backdrop.g,E.db.unitframe.colors.power_backdrop.b,E.db.general.backdropfadecolor.a)
						groupunitframe.Power.backdrop.Center:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
					end
				end
				if powertypes[powertype] then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom then
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower == "HORIZONTAL" then
							if E.db.unitframe.colors.transparentPower and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
								groupunitframe.Power.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, true))
							else
								groupunitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
							end
							if not E.db.unitframe.colors.custompowerbackdrop and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
								groupunitframe.Power.bg:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false,true))
							end
						else
							if E.db.unitframe.colors.transparentPower and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
								groupunitframe.Power.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, true))
							else
								groupunitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
							end
							if not E.db.unitframe.colors.custompowerbackdrop and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
								groupunitframe.Power.bg:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false,true))
							end
						end
					else
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower == "HORIZONTAL" then
							if E.db.unitframe.colors.transparentPower and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
								groupunitframe.Power.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, true))
							else
								groupunitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
							end
							if not E.db.unitframe.colors.custompowerbackdrop and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
								groupunitframe.Power.bg:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false,true))
							end
						else
							if E.db.unitframe.colors.transparentPower and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
								groupunitframe.Power.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, true))
							else
								groupunitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
							end
							if not E.db.unitframe.colors.custompowerbackdrop and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
								groupunitframe.Power.bg:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false,true))
							end
						end
					end
				else
					local r,g,b = groupunitframe.Power:GetStatusBarColor()
					if r and ElvUI_EltreumUI:IsThisASafeSecret(r,true) then --check for it not being a secret
						if r ~= 1 and g ~= 1 and b ~= 1 then
							local orientation = E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower
							local alpha = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha
							fallbackMin:SetRGBA(clamp(r - 0.4), clamp(g - 0.4), clamp(b - 0.4), alpha)
							fallbackMax:SetRGBA(clamp(r + 0.2), clamp(g + 0.2), clamp(b + 0.2), alpha)
							groupunitframe.Power:GetStatusBarTexture():SetGradient(orientation, fallbackMin, fallbackMax)
							if not E.db.unitframe.colors.custompowerbackdrop and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
								local bgfade = E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade
								fallbackMin:SetRGBA(clamp((r - 0.4) - bgfade), clamp((g - 0.4) - bgfade), clamp((b - 0.4) - bgfade), 1)
								fallbackMax:SetRGBA(clamp((r + 0.2) - bgfade), clamp((g + 0.2) - bgfade), clamp((b + 0.2) - bgfade), 1)
								groupunitframe.Power.bg:SetGradient(orientation, fallbackMin, fallbackMax)
							end
						end
					end
				end
			end
			if groupunitframe.AlternativePower then
				local r,g,b = groupunitframe.AlternativePower:GetStatusBarColor()
				if r and ElvUI_EltreumUI:IsThisASafeSecret(r,true) then --check for it not being a secret
					if r ~= 1 and g ~= 1 and b ~= 1 then
						local orientation = E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower
						local alpha = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha
						fallbackMin:SetRGBA(clamp(r - 0.4), clamp(g - 0.4), clamp(b - 0.4), alpha)
						fallbackMax:SetRGBA(clamp(r + 0.2), clamp(g + 0.2), clamp(b + 0.2), alpha)
						groupunitframe.AlternativePower:GetStatusBarTexture():SetGradient(orientation, fallbackMin, fallbackMax)
						if not E.db.unitframe.colors.custompowerbackdrop and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
							local bgfade = E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade
							fallbackMin:SetRGBA(clamp((r - 0.4) - bgfade), clamp((g - 0.4) - bgfade), clamp((b - 0.4) - bgfade), 1)
							fallbackMax:SetRGBA(clamp((r + 0.2) - bgfade), clamp((g + 0.2) - bgfade), clamp((b + 0.2) - bgfade), 1)
							groupunitframe.AlternativePower.bg:SetGradient(orientation, fallbackMin, fallbackMax)
						end
					end
				end
			end
		end
	end
end

--additional power gradient/combo/runes as well
local function gradientclassbar(powerbar,powerType)
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableclassbar and E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
		for index, bar in ipairs(powerbar) do
			local isRunes = powerType == 'RUNES'
			local colors, powers, fallback = UF:ClassPower_GetColor(UF.db.colors, powerType)
			local color = UF:ClassPower_BarColor(bar, index, colors, powers, isRunes)
			if not color or not color.r then
				if powerbar.GetVertexColor then
					color.r,color.g,color.b = powerbar:GetVertexColor()
				else
					color = fallback
				end
			end
			fallbackMin:SetRGBA(clamp(color.r - 0.3), clamp(color.g - 0.3), clamp(color.b - 0.3), 1)
			fallbackMax:SetRGBA(clamp(color.r), clamp(color.g), clamp(color.b), 1)
			bar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, fallbackMin, fallbackMax)
			if E.db.unitframe.units.player.classbar.fill == "spaced" then
				bar.bg:SetAlpha(0)
				--bar.bg:SetAlpha(E.db.general.backdropfadecolor.a)
				--bar.backdrop.Center:SetAlpha(E.db.general.backdropfadecolor.a)
				if E.db.unitframe.colors.customclasspowerbackdrop then
					bar.backdrop.Center:SetVertexColor(E.db.unitframe.colors.classpower_backdrop.r, E.db.unitframe.colors.classpower_backdrop.g, E.db.unitframe.colors.classpower_backdrop.b)
				end
			else
				bar.bg:SetAlpha(E.db.general.backdropfadecolor.a)
			end
		end
	end
end
function ElvUI_EltreumUI:UFClassPower_SetBarColor(frame)
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableclassbar and E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
		if frame and not frame.EltruismHookedGradientClassPower then
			if frame.ClassPower then
				hooksecurefunc(frame.ClassPower,"UpdateColor", function(powerbar,powerType)
					gradientclassbar(powerbar,powerType)
				end)
			end
			--[[if frame.Runes then
				hooksecurefunc(frame.Runes,"UpdateColor", function(powerbar,powerType)
					gradientclassbar(powerbar,powerType)
				end)
			end]]
			frame.EltruismHookedGradientClassPower = true
		end
	end
end
hooksecurefunc(UF, "Configure_ClassBar", ElvUI_EltreumUI.UFClassPower_SetBarColor)

local individualPowerUnits = {
	player = "Player",
	target = "Target",
	pet = "Pet",
	targettarget = "TargetTarget",
	targettargettarget = "TargetTargetTarget",
	focus = "Focus",
	focustarget = "FocusTarget",
}

local function PowerBar_PostUpdatePowerColor(powerBar, unit)
	if not powerBar then return end
	if ElvUI_EltreumUI:EncounterCheck() then return end
	if not (E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepower and E.db.ElvUI_EltreumUI.unitframes.UFmodifications) then return end

	local parent = powerBar.origParent or (powerBar.GetParent and powerBar:GetParent())
	if not parent then return end

	local frameType = parent.unitframeType
	if not frameType then
		local fUnit = parent.__unit or parent.unit or unit
		if fUnit then
			parent.__unit = fUnit
			ElvUI_EltreumUI:ApplyGroupGradientPower(parent)
		end
		return
	end

	local name = individualPowerUnits[frameType]
	if name then
		ElvUI_EltreumUI:ApplyUnitGradientPower(unit or frameType, name)
	elseif frameType == "boss" then
		local frameName = parent:GetName()
		if frameName then
			ElvUI_EltreumUI:ApplyUnitGradientPower(unit or parent.unit or parent.__unit, frameName:sub(7))
		end
	elseif frameType == "arena" then
		local frameName = parent:GetName()
		if frameName then
			ElvUI_EltreumUI:ApplyUnitGradientPower(unit or parent.unit or parent.__unit, frameName:sub(7))
		end
	else
		if not parent.__unit and (unit or parent.unit) then
			parent.__unit = unit or parent.unit
		end
		ElvUI_EltreumUI:ApplyGroupGradientPower(parent)
	end
end

--Gradient Power Colors
function ElvUI_EltreumUI:GradientPower(unit)--(unit,r,g,b)
	if self and type(self) == "table" and self ~= ElvUI_EltreumUI and self.GetParent and self.GetObjectType and self:GetObjectType() == "StatusBar" then
		PowerBar_PostUpdatePowerColor(self, unit)
		return
	end
	if ElvUI_EltreumUI:EncounterCheck() then return end
	local forced = false
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepower and E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
		ElvUI_EltreumUI:ApplyUnitGradientPower("player", "Player")
		ElvUI_EltreumUI:ApplyUnitGradientPower("target", "Target")
		ElvUI_EltreumUI:ApplyUnitGradientPower("pet", "Pet")
		if ElvUI_EltreumUI:IsThisASafeSecret(nil,nil,true) then
			ElvUI_EltreumUI:ApplyUnitGradientPower("targettarget", "TargetTarget")
			ElvUI_EltreumUI:ApplyUnitGradientPower("targettargettarget", "TargetTargetTarget")
		end
		if E.Retail or E.Mists or E.TBC or E.Wrath then
			ElvUI_EltreumUI:ApplyUnitGradientPower("boss1", "Boss1")
			ElvUI_EltreumUI:ApplyUnitGradientPower("boss2", "Boss2")
			ElvUI_EltreumUI:ApplyUnitGradientPower("boss3", "Boss3")
			ElvUI_EltreumUI:ApplyUnitGradientPower("boss4", "Boss4")
			ElvUI_EltreumUI:ApplyUnitGradientPower("boss5", "Boss5")
			ElvUI_EltreumUI:ApplyUnitGradientPower("boss6", "Boss6")
			ElvUI_EltreumUI:ApplyUnitGradientPower("boss7", "Boss7")
			ElvUI_EltreumUI:ApplyUnitGradientPower("boss8", "Boss8")
			ElvUI_EltreumUI:ApplyUnitGradientPower("focus", "Focus")
			if ElvUI_EltreumUI:IsThisASafeSecret(nil,nil,true) then
				ElvUI_EltreumUI:ApplyUnitGradientPower("focustarget", "FocusTarget")
			end
			ElvUI_EltreumUI:ApplyUnitGradientPower("arena1", "Arena1")
			ElvUI_EltreumUI:ApplyUnitGradientPower("arena2", "Arena2")
			ElvUI_EltreumUI:ApplyUnitGradientPower("arena3", "Arena3")
			ElvUI_EltreumUI:ApplyUnitGradientPower("arena4", "Arena4")
			ElvUI_EltreumUI:ApplyUnitGradientPower("arena5", "Arena5")
		end

		if unit == "testunit" then
			forced = true
		end

		if forced then
			if E.Retail or E.Mists or E.TBC or E.Wrath then
				ElvUI_EltreumUI:ApplyUnitGradientPower("player", "Boss1")
				ElvUI_EltreumUI:ApplyUnitGradientPower("player", "Boss2")
				ElvUI_EltreumUI:ApplyUnitGradientPower("player", "Boss3")
				ElvUI_EltreumUI:ApplyUnitGradientPower("player", "Boss4")
				ElvUI_EltreumUI:ApplyUnitGradientPower("player", "Boss5")
				ElvUI_EltreumUI:ApplyUnitGradientPower("player", "Boss6")
				ElvUI_EltreumUI:ApplyUnitGradientPower("player", "Boss7")
				ElvUI_EltreumUI:ApplyUnitGradientPower("player", "Boss8")
				ElvUI_EltreumUI:ApplyUnitGradientPower("player", "Focus")
				ElvUI_EltreumUI:ApplyUnitGradientPower("player", "FocusTarget")
				ElvUI_EltreumUI:ApplyUnitGradientPower("player", "Arena1")
				ElvUI_EltreumUI:ApplyUnitGradientPower("player", "Arena2")
				ElvUI_EltreumUI:ApplyUnitGradientPower("player", "Arena3")
				ElvUI_EltreumUI:ApplyUnitGradientPower("player", "Arena4")
				ElvUI_EltreumUI:ApplyUnitGradientPower("player", "Arena5")
			end
		end

		--group/raid unitframes
		if IsInGroup() or forced then
			local headergroup = nil
			if _G["ElvUF_Raid1"] and _G["ElvUF_Raid1"]:IsShown() and E.db["unitframe"]["units"]["raid1"]["power"]["enable"] then
				headergroup = _G["ElvUF_Raid1"]
			elseif _G["ElvUF_Raid2"] and _G["ElvUF_Raid2"]:IsShown() and E.db["unitframe"]["units"]["raid2"]["power"]["enable"] then
				headergroup = _G["ElvUF_Raid2"]
			elseif _G["ElvUF_Raid3"] and _G["ElvUF_Raid3"]:IsShown() and E.db["unitframe"]["units"]["raid3"]["power"]["enable"] then
				headergroup = _G["ElvUF_Raid3"]
			elseif _G["ElvUF_Party"] and _G["ElvUF_Party"]:IsShown() and E.db["unitframe"]["units"]["party"]["power"]["enable"] then
				headergroup = _G["ElvUF_Party"]
			end
			if headergroup ~= nil then
				for i = 1, headergroup:GetNumChildren() do
					local group = select(i, headergroup:GetChildren())
					for j = 1, group:GetNumChildren() do
						local groupbutton = select(j, group:GetChildren())
						if groupbutton and groupbutton.Power and groupbutton.Power:IsShown() and groupbutton.__unit then
							ElvUI_EltreumUI:ApplyGroupGradientPower(groupbutton)
						end
					end
				end
			end
		end

		--gradient additional power, transparent other frames if power tranparency is enabled
		if _G["ElvUF_Player_ClassBar"] then
			if E.db.unitframe.colors.transparentPower then --make class bar follow power transparency
				_G["ElvUF_Player_ClassBar"]:SetAlpha(E.db.general.backdropfadecolor.a)
			end
		end
		if _G["ElvUF_Player_Runes"] then
			if E.db.unitframe.colors.transparentPower then --make class bar follow power transparency
				_G["ElvUF_Player_Runes"]:SetAlpha(E.db.general.backdropfadecolor.a)
			end
		end
		if _G["ElvUF_Player_Stagger"] then
			if E.db.unitframe.colors.transparentPower then --make monk's stagger follow power transparency
				_G["ElvUF_Player_Stagger"]:SetAlpha(E.db.general.backdropfadecolor.a)
			end
		end
		if _G["ElvUF_Player"] and _G["ElvUF_Player"].Totems then
			if E.db.unitframe.colors.transparentPower then --make wrath shaman totems follow power transparency
				_G["ElvUF_Player"].Totems:SetAlpha(E.db.general.backdropfadecolor.a)
			end
		end
		if _G["ElvUF_Player_AdditionalPowerBar"] then
			if E.db.unitframe.colors.transparentPower then --make additional power follow power transparency
				_G["ElvUF_Player_AdditionalPowerBar"]:SetAlpha(E.db.general.backdropfadecolor.a)
				_G["ElvUF_Player_AdditionalPowerBar"].ClipFrame:SetAlpha(E.db.general.backdropfadecolor.a)
			end
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableclassbar and not _G["ElvUF_Player_AdditionalPowerBar"].isHooked then
					hooksecurefunc(_G["ElvUF_Player_AdditionalPowerBar"], "SetStatusBarColor", function(_,r,g,b) --i knew the vertex thing from details could be useful
						fallbackMin:SetRGBA(clamp(r - 0.4), clamp(g - 0.4), clamp(b - 0.4), 1)
						fallbackMax:SetRGBA(clamp(r), clamp(g), clamp(b), 1)
						_G["ElvUF_Player_AdditionalPowerBar"]:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, fallbackMin, fallbackMax)
						if E.db.ElvUI_EltreumUI.skins.elvui.SetTemplate then
							_G["ElvUF_Player_AdditionalPowerBar"].bg:SetAlpha(E.db.general.backdropfadecolor.a)
						end
					end)
				_G["ElvUF_Player_AdditionalPowerBar"].isHooked = true
			end
		end
	end
end
hooksecurefunc(UF, "Construct_PowerBar", ElvUI_EltreumUI.GradientPower)
hooksecurefunc(UF, "PostUpdatePowerColor", PowerBar_PostUpdatePowerColor)

--gradient stagger because its special
function ElvUI_EltreumUI:GradientStagger()
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableclassbar and E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
		if _G["ElvUF_Player_Stagger"] and not _G["ElvUF_Player_Stagger"].EltruismHook then
			hooksecurefunc(_G["ElvUF_Player_Stagger"], "SetStatusBarColor", function(stagger,r,g,b)
				fallbackMin:SetRGBA(clamp(r - 0.5), clamp(g - 0.5), clamp(b - 0.5), 1)
				fallbackMax:SetRGBA(clamp(r + 0.2), clamp(g + 0.2), clamp(b + 0.2), 1)
				stagger:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, fallbackMin, fallbackMax)
			end)
			_G["ElvUF_Player_Stagger"].EltruismHook = true
		end
		if _G["ElvNP_TargetClassPowerStagger"] and not _G["ElvNP_TargetClassPowerStagger"].EltruismHook then
			hooksecurefunc(_G["ElvNP_TargetClassPowerStagger"], "SetStatusBarColor", function(npstagger,r,g,b)
				fallbackMin:SetRGBA(clamp(r - 0.5), clamp(g - 0.5), clamp(b - 0.5), 1)
				fallbackMax:SetRGBA(clamp(r + 0.2), clamp(g + 0.2), clamp(b + 0.2), 1)
				npstagger:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, fallbackMin, fallbackMax)
			end)
			_G["ElvNP_TargetClassPowerStagger"].EltruismHook = true
		end
	end
end
hooksecurefunc(UF, "Construct_Stagger", ElvUI_EltreumUI.GradientStagger)

--gradient eclipse, also special
function ElvUI_EltreumUI:GradientEclipse()
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableclassbar and E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
		if _G["ElvUF_Player_EclipsePowerBar"] then
			if E.db.unitframe.colors.transparentPower then --make eclipse follow power transparency
				_G["ElvUF_Player_EclipsePowerBar"].LunarBar:SetAlpha(E.db.general.backdropfadecolor.a)
				_G["ElvUF_Player_EclipsePowerBar"].SolarBar:SetAlpha(E.db.general.backdropfadecolor.a)
			end
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableclassbar and not _G["ElvUF_Player_EclipsePowerBar"].isHooked then
				hooksecurefunc(_G["ElvUF_Player_EclipsePowerBar"].LunarBar, "SetStatusBarColor", function(_,r,g,b) --i knew the vertex thing from details could be useful
					fallbackMin:SetRGBA(clamp(r - 0.4), clamp(g - 0.4), clamp(b - 0.4), 1)
					fallbackMax:SetRGBA(clamp(r), clamp(g), clamp(b), 1)
					_G["ElvUF_Player_EclipsePowerBar"].LunarBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, fallbackMin, fallbackMax)
				end)
				hooksecurefunc(_G["ElvUF_Player_EclipsePowerBar"].SolarBar, "SetStatusBarColor", function(_,r,g,b) --i knew the vertex thing from details could be useful
					fallbackMin:SetRGBA(clamp(r), clamp(g), clamp(b), 1)
					fallbackMax:SetRGBA(clamp(r - 0.4), clamp(g - 0.4), clamp(b - 0.4), 1)
					_G["ElvUF_Player_EclipsePowerBar"].SolarBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, fallbackMin, fallbackMax)
				end)
				_G["ElvUF_Player_EclipsePowerBar"].isHooked = true
			end
			_G["ElvUF_Player_EclipsePowerBar"].Arrow:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ArrowEltruismEclipse.tga")
		end
	end
end
if E.Mists then --this is only cata onwards
	hooksecurefunc(UF, "Construct_DruidEclipseBar", ElvUI_EltreumUI.GradientEclipse)
end

--make power pred use the same texture too
function ElvUI_EltreumUI:Configure_PowerPrediction(frame)
	local pred = frame and frame.PowerPrediction
	if not pred then return end
	if pred.mainBar then
		pred.mainBar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
	end
	local altBar = pred.altBar
	if altBar then
		altBar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
	end
end
hooksecurefunc(UF, "Configure_PowerPrediction", ElvUI_EltreumUI.Configure_PowerPrediction)
