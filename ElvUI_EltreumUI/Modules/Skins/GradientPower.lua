local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local UF = E:GetModule('UnitFrames')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc


local powertype
local unitframe

--set the textures or gradients
function ElvUI_EltreumUI:ApplyUnitGradientTexturePower(unit,name,uf)
	powertype = UnitPowerType(unit)
	if UnitExists(unit) and powertype then
		print(powertype)
		unitframe = _G["ElvUF_"..name]
		if unitframe and unitframe.Power then
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then
				if E.db["ElvUI_EltreumUI"]["unitframes"]["gradientmode"]["enable"..unit] then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation == "HORIZONTAL" then
							if unit == "target" then
								unitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(powertype, true, false))
							else
								unitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
							end
						else
							unitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(powertype, false, false))
						end
					else
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation == "HORIZONTAL" then
							if unit == "target" then
								unitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(powertype, true, false))
							else
								unitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(powertype, false, false))
							end
						else
							unitframe.Power:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(powertype, false, false))
						end
					end
				end
			end
		end
	end
end

function ElvUI_EltreumUI:GradientPower()
	ElvUI_EltreumUI:ApplyUnitGradientTexturePower("player", "Player", "player")
	ElvUI_EltreumUI:ApplyUnitGradientTexturePower("target", "Target", "target")
end
hooksecurefunc(UF, "Construct_PowerBar", ElvUI_EltreumUI.GradientPower)
hooksecurefunc(UF, "PostUpdatePowerColor", ElvUI_EltreumUI.GradientPower)

