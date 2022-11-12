local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local UF = E:GetModule('UnitFrames')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local powertype, _
local unitframe, Additionalframe, isHooked, staggerframe, npstaggerframe,isHookedstagger
local UnitPowerTyp = _G.UnitPowerType
local UnitExists = _G.UnitExists

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

--Apply Gradient Power Colors
function ElvUI_EltreumUI:ApplyGradientPower(unit,name)
	_, powertype = UnitPowerType(unit)
	if UnitExists(unit) and powertype then
		--print(powertype,unit)
		unitframe = _G["ElvUF_"..name]
		if unitframe and unitframe.Power then
			if powertypes[powertype] then
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower == "HORIZONTAL" then
						if unit == "target" then
							unitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, true, false))
							if not E.db.unitframe.colors.custompowerbackdrop then
								unitframe.Power.BG:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, true, false, true))
							end
						else
							unitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
							if not E.db.unitframe.colors.custompowerbackdrop then
								unitframe.Power.BG:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false,true))
							end
						end
					else
						unitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
						if not E.db.unitframe.colors.custompowerbackdrop then
							unitframe.Power.BG:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false,true))
						end
					end
				else
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower == "HORIZONTAL" then
						if unit == "target" then
							unitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, true, false))
							if not E.db.unitframe.colors.custompowerbackdrop then
								unitframe.Power.BG:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, true, false,true))
							end
						else
							unitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
							if not E.db.unitframe.colors.custompowerbackdrop then
								unitframe.Power.BG:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false,true))
							end
						end
					else
						unitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
						if not E.db.unitframe.colors.custompowerbackdrop then
							unitframe.Power.BG:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false,true))
						end
					end
				end
			else
				local r,g,b = unitframe.Power:GetStatusBarColor()
				if r ~= 1 and g ~= 1 and b ~= 1 then
					if E.Retail then
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower == "HORIZONTAL" then
							if unit == "target" then
								unitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, {r=r + 0.2,g= g + 0.2,b= b + 0.2,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=r - 0.4,g= g - 0.4,b= b - 0.4,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
								if not E.db.unitframe.colors.custompowerbackdrop then
									unitframe.Power.BG:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, {r=(r + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= (g + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= (b + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}, {r=(r - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= (g - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= (b - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1})
								end
							else
								unitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, {r=r - 0.4,g= g - 0.4,b= b - 0.4, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=r + 0.2,g= g + 0.2,b= b + 0.2,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
								if not E.db.unitframe.colors.custompowerbackdrop then
									unitframe.Power.BG:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, {r=(r - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade, g=(g - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= (b - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}, {r=(r + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= (g + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= (b + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1})
								end
							end
						else
							unitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, {r=r - 0.4,g= g - 0.4,b= b - 0.4,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=r + 0.2,g= g + 0.2, b=b + 0.2, a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
							if not E.db.unitframe.colors.custompowerbackdrop then
								unitframe.Power.BG:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, {r=(r - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= (g - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= (b - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}, {r=(r + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= (g + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= (b + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1})
							end
						end
					else
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower == "HORIZONTAL" then
							if unit == "target" then
								unitframe.Power:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, r + 0.2, g + 0.2, b + 0.2, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha,r - 0.4,g - 0.4,b - 0.4,E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
								if not E.db.unitframe.colors.custompowerbackdrop then
									unitframe.Power.BG:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, (r + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,(g + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,(b + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,(r - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,(g - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,(b - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade)
								end
							else
								unitframe.Power:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower,r - 0.4,g - 0.4,b - 0.4,E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha,r + 0.2,g + 0.2,b + 0.2,E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
								if not E.db.unitframe.colors.custompowerbackdrop then
									unitframe.Power.BG:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, (r - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade, (g - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,(b - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,(r + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,(g + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,(b + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade)
								end
							end
						else
							unitframe.Power:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower,r - 0.4,g - 0.4,b - 0.4,E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha,r + 0.2,g + 0.2,b + 0.2, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
							if not E.db.unitframe.colors.custompowerbackdrop then
								unitframe.Power.BG:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower,(r - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,(g - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,(b - 0.4) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade, (r + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,(g + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,(b + 0.2) - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade)
							end
						end
					end
				end
			end
		end
	end
end

--additional power gradient/combo/runes as well
function ElvUI_EltreumUI:UFClassPower_SetBarColor(bar, r, g, b)
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepower and E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
		if E.Retail then
			bar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, {r= r - 0.3,g= g - 0.3,b= b - 0.3,a= 1}, {r=r,g= g,b= b,a= 1})
		else
			bar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, r - 0.3, g - 0.3, b - 0.3, r, g, b)
		end
	end
end
hooksecurefunc(UF, "ClassPower_SetBarColor", ElvUI_EltreumUI.UFClassPower_SetBarColor)

--Gradient Power Colors
function ElvUI_EltreumUI:GradientPower()--(unit,r,g,b)
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepower and E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
		ElvUI_EltreumUI:ApplyGradientPower("player", "Player")
		ElvUI_EltreumUI:ApplyGradientPower("target", "Target")
		ElvUI_EltreumUI:ApplyGradientPower("targettarget", "TargetTarget")
		ElvUI_EltreumUI:ApplyGradientPower("pet", "Pet")
		ElvUI_EltreumUI:ApplyGradientPower("targettargettarget", "TargetTargetTarget")
		if E.Retail or E.Wrath then
			ElvUI_EltreumUI:ApplyGradientPower("boss1", "Boss1")
			ElvUI_EltreumUI:ApplyGradientPower("boss2", "Boss2")
			ElvUI_EltreumUI:ApplyGradientPower("boss3", "Boss3")
			ElvUI_EltreumUI:ApplyGradientPower("boss4", "Boss4")
			ElvUI_EltreumUI:ApplyGradientPower("boss5", "Boss5")
			ElvUI_EltreumUI:ApplyGradientPower("boss6", "Boss6")
			ElvUI_EltreumUI:ApplyGradientPower("boss7", "Boss7")
			ElvUI_EltreumUI:ApplyGradientPower("boss8", "Boss8")
		end
		if not E.Classic then
			ElvUI_EltreumUI:ApplyGradientPower("focus", "Focus")
			ElvUI_EltreumUI:ApplyGradientPower("focustarget", "FocusTarget")
			ElvUI_EltreumUI:ApplyGradientPower("arena1", "Arena1")
			ElvUI_EltreumUI:ApplyGradientPower("arena2", "Arena2")
			ElvUI_EltreumUI:ApplyGradientPower("arena3", "Arena3")
			ElvUI_EltreumUI:ApplyGradientPower("arena4", "Arena4")
			ElvUI_EltreumUI:ApplyGradientPower("arena5", "Arena5")
		end

		--gradient additional power
		if not isHooked then
			Additionalframe = _G["ElvUF_Player_AdditionalPowerBar"]
			if Additionalframe then
				hooksecurefunc(Additionalframe, "SetStatusBarColor", function(_,r,g,b) --i knew the vertex thing from details could be useful
					if E.Retail then
						Additionalframe:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, {r=r - 0.4,g= g - 0.4,b= b - 0.4,a= 1}, {r=r,g= g,b= b,a= 1})
					else
						Additionalframe:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, r - 0.4, g - 0.4, b - 0.4, r, g, b)
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
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepower and E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
		if not isHookedstagger then
			staggerframe = _G["ElvUF_Player_Stagger"]
			if staggerframe then
				hooksecurefunc(staggerframe, "SetStatusBarColor", function(self,r,g,b)
					if E.Retail then
						self:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, {r=r - 0.5,g= g - 0.5,b= b - 0.5,a= 1}, {r=r + 0.2,g= g + 0.2,b= b + 0.2,a= 1})
					else
						self:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, r - 0.5, g - 0.5, b - 0.5, r + 0.2, g + 0.2, b + 0.2)
					end
				end)
			end
			npstaggerframe = _G["ElvNP_TargetClassPowerStagger"]
			if npstaggerframe then
				hooksecurefunc(npstaggerframe, "SetStatusBarColor", function(self,r,g,b)
					if E.Retail then
						self:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, {r=r - 0.5,g= g - 0.5,b= b - 0.5,a= 1}, {r=r + 0.2,g= g + 0.2,b= b + 0.2,a= 1})
					else
						self:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, r - 0.5, g - 0.5, b - 0.5, r + 0.2, g + 0.2, b + 0.2)
					end
				end)
			end
			isHookedstagger = true
		end
	end
end
hooksecurefunc(UF, "Construct_Stagger", ElvUI_EltreumUI.GradientStagger)
