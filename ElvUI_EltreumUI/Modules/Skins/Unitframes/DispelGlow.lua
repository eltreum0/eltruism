local ElvUI_EltreumUI, E, L, V, P, G = unpack((select(2, ...)))
local UF = E:GetModule('UnitFrames')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local LCG = E.Libs.CustomGlow
--local LCG = LibStub('LibCustomGlow-1.0')

--glow dispellable debuffs
function ElvUI_EltreumUI:UFGlow(object, debuffType, _, wasFiltered)
	if E.private.unitframe.enable and E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
		if E.db.ElvUI_EltreumUI.glow.enableUFs then
			local name = object:GetName()
			if (name ~= "ElvUF_Player" and name ~= "ElvUF_Target") then
				if debuffType then
					if not wasFiltered then
						--local canDispel = filtercheck:StyleFilterDispelCheck(object, debuffType)
						local color = UF.db.colors.debuffHighlight[debuffType]
						if E.db.ElvUI_EltreumUI.glow.pixel then
							LCG.PixelGlow_Start(object, {color.r, color.g, color.b, 1}, 7, 0.25, 14, 4, 3, 3, false, nil, 6)
						elseif E.db.ElvUI_EltreumUI.glow.autocast then
							LCG.AutoCastGlow_Start(object, {color.r, color.g, color.b, 1}, 8, 0.4, 2, 3, 3)
						elseif E.db.ElvUI_EltreumUI.glow.blizzard then
							LCG.ButtonGlow_Start(object, {color.r, color.g, color.b, 1}, 0.5)
						end
					end
				else
					if E.db.ElvUI_EltreumUI.glow.pixel then
						LCG.PixelGlow_Stop(object)
					elseif E.db.ElvUI_EltreumUI.glow.autocast then
						LCG.AutoCastGlow_Stop(object)
					elseif E.db.ElvUI_EltreumUI.glow.blizzard then
						LCG.ButtonGlow_Stop(object)
					end
				end
			end
		end
	end
end
hooksecurefunc(UF, "PostUpdate_AuraHighlight", ElvUI_EltreumUI.UFGlow)
