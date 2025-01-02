local E = unpack(ElvUI)
local UF = E:GetModule('UnitFrames')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local powertype, _
local unitframe, isHooked, staggerframe, npstaggerframe,isHookedstagger
local UnitPowerType = _G.UnitPowerType
local UnitExists = _G.UnitExists
local headergroup, group, groupbutton
local select = _G.select
local forced = false
local IsInGroup = _G.IsInGroup

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
	if unit == "testunit" then
		forced = true
		unit = "player"
	else
		forced = false
	end

	_, powertype = UnitPowerType(unit)
	if UnitExists(unit) and powertype then
		--print(powertype,unit)
		unitframe = _G["ElvUF_"..name]
		if unitframe and unitframe.Power then
			if E.db.unitframe.colors.transparentPower and E.db.unitframe.colors.custompowerbackdrop then --fix transparent power custom backdrop
				unitframe.Power.backdrop.Center:SetTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
				unitframe.Power.BG:SetVertexColor(E.db.unitframe.colors.power_backdrop.r,E.db.unitframe.colors.power_backdrop.g,E.db.unitframe.colors.power_backdrop.b,E.db.general.backdropfadecolor.a)
				if unitframe.Power.backdropTex then
					unitframe.Power.backdropTex:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
				end
				local shouldFIX = unitframe.USE_MINI_POWERBAR or unitframe.USE_INSET_POWERBAR --spaced or inset only
				if not unitframe.Power.EltruismTransparencyFix and E.db.unitframe.thinBorders and shouldFIX then
					unitframe.Power.backdrop:ClearAllPoints()
					unitframe.Power.backdrop:SetAllPoints(unitframe.Power:GetStatusBarTexture())
					unitframe.Power.backdrop:SetInside(unitframe.Power:GetStatusBarTexture(), 0, 0)
					unitframe.Power.EltruismTransparencyFix = true
				end
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
								unitframe.Power.BG:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, true, false, true))
							end
						else
							if E.db.unitframe.colors.transparentPower and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
								unitframe.Power.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, true))
							else
								unitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
							end
							if not E.db.unitframe.colors.custompowerbackdrop and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
								unitframe.Power.BG:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false,true))
							end
						end
					else
						if E.db.unitframe.colors.transparentPower and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
							unitframe.Power.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, true))
						else
							unitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
						end
						if not E.db.unitframe.colors.custompowerbackdrop and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
							unitframe.Power.BG:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false,true))
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
								unitframe.Power.BG:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, true, false,true))
							end
						else
							if E.db.unitframe.colors.transparentPower and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
								unitframe.Power.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, true))
							else
								unitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
							end
							if not E.db.unitframe.colors.custompowerbackdrop and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
								unitframe.Power.BG:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false,true))
							end
						end
					else
						if E.db.unitframe.colors.transparentPower and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
							unitframe.Power.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, true))
						else
							unitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
						end
						if not E.db.unitframe.colors.custompowerbackdrop and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
							unitframe.Power.BG:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false,true))
						end
					end
				end
			else
				local r,g,b = unitframe.Power:GetStatusBarColor()
				if r ~= 1 and g ~= 1 and b ~= 1 then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower == "HORIZONTAL" then
						if unit == "target" then
							unitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, {r=r + 0.2,g= g + 0.2,b= b + 0.2,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=r - 0.4,g= g - 0.4,b= b - 0.4,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
							if not E.db.unitframe.colors.custompowerbackdrop and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
								unitframe.Power.BG:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, {r=(r + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= (g + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= (b + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}, {r=(r - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= (g - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= (b - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1})
							end
						else
							unitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, {r=r - 0.4,g= g - 0.4,b= b - 0.4, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=r + 0.2,g= g + 0.2,b= b + 0.2,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
							if not E.db.unitframe.colors.custompowerbackdrop and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
								unitframe.Power.BG:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, {r=(r - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade, g=(g - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= (b - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}, {r=(r + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= (g + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= (b + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1})
							end
						end
					else
						unitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, {r=r - 0.4,g= g - 0.4,b= b - 0.4,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=r + 0.2,g= g + 0.2, b=b + 0.2, a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
						if not E.db.unitframe.colors.custompowerbackdrop and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
							unitframe.Power.BG:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, {r=(r - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= (g - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= (b - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}, {r=(r + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= (g + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= (b + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1})
						end
					end
				end
			end
		end
	end
end

--Apply Gradient Power Colors to Group Unit
function ElvUI_EltreumUI:ApplyGroupGradientPower(groupunitframe)
	if groupunitframe and groupunitframe.unit then
		_, powertype = UnitPowerType(groupunitframe.unit)
		if powertype then
			if groupunitframe.Power then
				if E.db.unitframe.colors.transparentPower and E.db.unitframe.colors.custompowerbackdrop then --fix transparent power custom backdrop
					groupunitframe.Power.backdrop.Center:SetTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
					groupunitframe.Power.BG:SetVertexColor(E.db.unitframe.colors.power_backdrop.r,E.db.unitframe.colors.power_backdrop.g,E.db.unitframe.colors.power_backdrop.b,E.db.general.backdropfadecolor.a)
					if groupunitframe.Power.backdropTex then
						groupunitframe.Power.backdropTex:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
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
								groupunitframe.Power.BG:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false,true))
							end
						else
							if E.db.unitframe.colors.transparentPower and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
								groupunitframe.Power.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, true))
							else
								groupunitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
							end
							if not E.db.unitframe.colors.custompowerbackdrop and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
								groupunitframe.Power.BG:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false,true))
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
								groupunitframe.Power.BG:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false,true))
							end
						else
							if E.db.unitframe.colors.transparentPower and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
								groupunitframe.Power.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, true))
							else
								groupunitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
							end
							if not E.db.unitframe.colors.custompowerbackdrop and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
								groupunitframe.Power.BG:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false,true))
							end
						end
					end
				else
					local r,g,b = groupunitframe.Power:GetStatusBarColor()
					if r ~= 1 and g ~= 1 and b ~= 1 then
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower == "HORIZONTAL" then
							groupunitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, {r=r - 0.4,g= g - 0.4,b= b - 0.4, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=r + 0.2,g= g + 0.2,b= b + 0.2,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
							if not E.db.unitframe.colors.custompowerbackdrop and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
								groupunitframe.Power.BG:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, {r=(r - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade, g=(g - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= (b - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}, {r=(r + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= (g + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= (b + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1})
							end
						else
							groupunitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, {r=r - 0.4,g= g - 0.4,b= b - 0.4,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=r + 0.2,g= g + 0.2, b=b + 0.2, a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
							if not E.db.unitframe.colors.custompowerbackdrop and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
								groupunitframe.Power.BG:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, {r=(r - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= (g - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= (b - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}, {r=(r + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= (g + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= (b + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1})
							end
						end
					end
				end
			end
			if groupunitframe.AlternativePower then
				local r,g,b = groupunitframe.AlternativePower:GetStatusBarColor()
				if r ~= 1 and g ~= 1 and b ~= 1 then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower == "HORIZONTAL" then
						groupunitframe.AlternativePower:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, {r=r - 0.4,g= g - 0.4,b= b - 0.4, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=r + 0.2,g= g + 0.2,b= b + 0.2,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
						if not E.db.unitframe.colors.custompowerbackdrop and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
							groupunitframe.AlternativePower.BG:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, {r=(r - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade, g=(g - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= (b - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}, {r=(r + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= (g + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= (b + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1})
						end
					else
						groupunitframe.AlternativePower:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, {r=r - 0.4,g= g - 0.4,b= b - 0.4,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=r + 0.2,g= g + 0.2, b=b + 0.2, a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
						if not E.db.unitframe.colors.custompowerbackdrop and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
							groupunitframe.AlternativePower.BG:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, {r=(r - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= (g - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= (b - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}, {r=(r + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= (g + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= (b + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1})
						end
					end
				end
			end
		end
	end
end

--additional power gradient/combo/runes as well
function ElvUI_EltreumUI:UFClassPower_SetBarColor(bar, r, g, b)
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableclassbar and E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
		bar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, {r= r - 0.3,g= g - 0.3,b= b - 0.3,a= 1}, {r=r,g= g,b= b,a= 1})
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
hooksecurefunc(UF, "ClassPower_SetBarColor", ElvUI_EltreumUI.UFClassPower_SetBarColor)

--Gradient Power Colors
function ElvUI_EltreumUI:GradientPower(unit)--(unit,r,g,b)
	if ElvUI_EltreumUI:EncounterCheck() then return end
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepower and E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
		ElvUI_EltreumUI:ApplyUnitGradientPower("player", "Player")
		ElvUI_EltreumUI:ApplyUnitGradientPower("target", "Target")
		ElvUI_EltreumUI:ApplyUnitGradientPower("targettarget", "TargetTarget")
		ElvUI_EltreumUI:ApplyUnitGradientPower("pet", "Pet")
		ElvUI_EltreumUI:ApplyUnitGradientPower("targettargettarget", "TargetTargetTarget")
		if E.Retail or E.Cata then
			ElvUI_EltreumUI:ApplyUnitGradientPower("boss1", "Boss1")
			ElvUI_EltreumUI:ApplyUnitGradientPower("boss2", "Boss2")
			ElvUI_EltreumUI:ApplyUnitGradientPower("boss3", "Boss3")
			ElvUI_EltreumUI:ApplyUnitGradientPower("boss4", "Boss4")
			ElvUI_EltreumUI:ApplyUnitGradientPower("boss5", "Boss5")
			ElvUI_EltreumUI:ApplyUnitGradientPower("boss6", "Boss6")
			ElvUI_EltreumUI:ApplyUnitGradientPower("boss7", "Boss7")
			ElvUI_EltreumUI:ApplyUnitGradientPower("boss8", "Boss8")
			ElvUI_EltreumUI:ApplyUnitGradientPower("focus", "Focus")
			ElvUI_EltreumUI:ApplyUnitGradientPower("focustarget", "FocusTarget")
			ElvUI_EltreumUI:ApplyUnitGradientPower("arena1", "Arena1")
			ElvUI_EltreumUI:ApplyUnitGradientPower("arena2", "Arena2")
			ElvUI_EltreumUI:ApplyUnitGradientPower("arena3", "Arena3")
			ElvUI_EltreumUI:ApplyUnitGradientPower("arena4", "Arena4")
			ElvUI_EltreumUI:ApplyUnitGradientPower("arena5", "Arena5")
		end

		if unit == "testunit" then
			forced = true
		else
			forced = false
		end

		if forced then
			if E.Retail or E.Cata then
				ElvUI_EltreumUI:ApplyUnitGradientPower("testunit", "Boss1")
				ElvUI_EltreumUI:ApplyUnitGradientPower("testunit", "Boss2")
				ElvUI_EltreumUI:ApplyUnitGradientPower("testunit", "Boss3")
				ElvUI_EltreumUI:ApplyUnitGradientPower("testunit", "Boss4")
				ElvUI_EltreumUI:ApplyUnitGradientPower("testunit", "Boss5")
				ElvUI_EltreumUI:ApplyUnitGradientPower("testunit", "Boss6")
				ElvUI_EltreumUI:ApplyUnitGradientPower("testunit", "Boss7")
				ElvUI_EltreumUI:ApplyUnitGradientPower("testunit", "Boss8")
				ElvUI_EltreumUI:ApplyUnitGradientPower("testunit", "Focus")
				ElvUI_EltreumUI:ApplyUnitGradientPower("testunit", "FocusTarget")
				ElvUI_EltreumUI:ApplyUnitGradientPower("testunit", "Arena1")
				ElvUI_EltreumUI:ApplyUnitGradientPower("testunit", "Arena2")
				ElvUI_EltreumUI:ApplyUnitGradientPower("testunit", "Arena3")
				ElvUI_EltreumUI:ApplyUnitGradientPower("testunit", "Arena4")
				ElvUI_EltreumUI:ApplyUnitGradientPower("testunit", "Arena5")
			end
		end

		--group/raid unitframes
		if IsInGroup() or forced then
			headergroup = nil
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
					group = select(i, headergroup:GetChildren())
					for j = 1, group:GetNumChildren() do
						groupbutton = select(j, group:GetChildren())
						if groupbutton and groupbutton.Power and groupbutton.Power:IsShown() and groupbutton.unit then
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
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableclassbar and not isHooked then
					hooksecurefunc(_G["ElvUF_Player_AdditionalPowerBar"], "SetStatusBarColor", function(_,r,g,b) --i knew the vertex thing from details could be useful
						_G["ElvUF_Player_AdditionalPowerBar"]:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, {r=r - 0.4,g= g - 0.4,b= b - 0.4,a= 1}, {r=r,g= g,b= b,a= 1})
						if E.db.ElvUI_EltreumUI.skins.elvui.SetTemplate then
							_G["ElvUF_Player_AdditionalPowerBar"].bg:SetAlpha(E.db.general.backdropfadecolor.a)
						end
					end)
				isHooked = true
			end
		end
	end
end
hooksecurefunc(UF, "Construct_PowerBar", ElvUI_EltreumUI.GradientPower)
hooksecurefunc(UF, "PostUpdatePowerColor", ElvUI_EltreumUI.GradientPower)

--gradient stagger because its special
function ElvUI_EltreumUI:GradientStagger()
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableclassbar and E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
		if not isHookedstagger then
			staggerframe = _G["ElvUF_Player_Stagger"]
			if staggerframe then
				hooksecurefunc(staggerframe, "SetStatusBarColor", function(stagger,r,g,b)
					stagger:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, {r=r - 0.5,g= g - 0.5,b= b - 0.5,a= 1}, {r=r + 0.2,g= g + 0.2,b= b + 0.2,a= 1})
				end)
			end
			npstaggerframe = _G["ElvNP_TargetClassPowerStagger"]
			if npstaggerframe then
				hooksecurefunc(npstaggerframe, "SetStatusBarColor", function(npstagger,r,g,b)
					npstagger:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, {r=r - 0.5,g= g - 0.5,b= b - 0.5,a= 1}, {r=r + 0.2,g= g + 0.2,b= b + 0.2,a= 1})
				end)
			end
			isHookedstagger = true
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
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableclassbar and not isHooked then
				hooksecurefunc(_G["ElvUF_Player_EclipsePowerBar"].LunarBar, "SetStatusBarColor", function(_,r,g,b) --i knew the vertex thing from details could be useful
					_G["ElvUF_Player_EclipsePowerBar"].LunarBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, {r=r - 0.4,g= g - 0.4,b= b - 0.4,a= 1}, {r=r,g= g,b= b,a= 1})
				end)
				hooksecurefunc(_G["ElvUF_Player_EclipsePowerBar"].SolarBar, "SetStatusBarColor", function(_,r,g,b) --i knew the vertex thing from details could be useful
					_G["ElvUF_Player_EclipsePowerBar"].SolarBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, {r=r,g= g,b= b,a= 1}, {r=r - 0.4,g= g - 0.4,b= b - 0.4,a= 1})
				end)
				isHooked = true
			end
			_G["ElvUF_Player_EclipsePowerBar"].Arrow:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ArrowEltruismEclipse.tga")
		end
	end
end
if E.Cata then
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
