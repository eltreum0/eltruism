local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local UF = E:GetModule('UnitFrames')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local powertype, _
local unitframe

--Apply Gradient Power Colors
function ElvUI_EltreumUI:ApplyGradientPower(unit,name)
	_, powertype = UnitPowerType(unit)
	if UnitExists(unit) and powertype then
		--print(powertype)
		unitframe = _G["ElvUF_"..name]
		if unitframe and unitframe.Power then
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom then
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower == "HORIZONTAL" then
					if unit == "target" then
						unitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, true, false))
					else
						unitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
					end
				else
					unitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
				end
			else
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower == "HORIZONTAL" then
					if unit == "target" then
						unitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, true, false))
					else
						unitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
					end
				else
					unitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
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
		if E.Retail then
			ElvUI_EltreumUI:ApplyUnitGradientTexture("boss1", "Boss1", "boss")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("boss2", "Boss2", "boss")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("boss3", "Boss3", "boss")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("boss4", "Boss4", "boss")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("boss5", "Boss5", "boss")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("boss6", "Boss6", "boss")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("boss7", "Boss7", "boss")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("boss8", "Boss8", "boss")
		end
		if E.Retail or E.TBC or E.Wrath then
			ElvUI_EltreumUI:ApplyUnitGradientTexture("focus", "Focus", "focus")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("arena1", "Arena1", "arena")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("arena2", "Arena2", "arena")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("arena3", "Arena3", "arena")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("arena4", "Arena4", "arena")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("arena5", "Arena5", "arena")
		end
	end
end
hooksecurefunc(UF, "Construct_PowerBar", ElvUI_EltreumUI.GradientPower)
hooksecurefunc(UF, "PostUpdatePowerColor", ElvUI_EltreumUI.GradientPower)

