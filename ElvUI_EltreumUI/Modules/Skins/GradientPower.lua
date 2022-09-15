local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local UF = E:GetModule('UnitFrames')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local powertype, _
local unitframe

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
		if unitframe and unitframe.Power and powertypes[powertype] then
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
		end
	end
end

--Gradient Power Colors
function ElvUI_EltreumUI:GradientPower()
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepower then
		ElvUI_EltreumUI:ApplyGradientPower("player", "Player")
		ElvUI_EltreumUI:ApplyGradientPower("target", "Target")
		ElvUI_EltreumUI:ApplyGradientPower("targettarget", "TargetTarget")
		ElvUI_EltreumUI:ApplyGradientPower("pet", "Pet")
		ElvUI_EltreumUI:ApplyGradientPower("targettargettarget", "TargetTargetTarget"," targetargettarget")
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
	end
end
hooksecurefunc(UF, "Construct_PowerBar", ElvUI_EltreumUI.GradientPower)
hooksecurefunc(UF, "PostUpdatePowerColor", ElvUI_EltreumUI.GradientPower)

