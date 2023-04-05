local E, L, V, P, G = unpack(ElvUI)
local UF = E:GetModule('UnitFrames')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc

--Gradient Aurabars
function ElvUI_EltreumUI:AuraBarGradient(unit, bar, _, _, _, _, debuffType, isStealable) --could use isStealable to add a glow or something
	if not unit and not bar then return end
	if E.db.ElvUI_EltreumUI.unitframes.UFmodifications and bar and unit then
		if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableaurabars then
			local r,g,b = bar:GetStatusBarColor()
			if unit == "player" then
				if E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.enableaurabars and not bar.EltruismSparkPlayer then
					bar.spark:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.texture))
					if E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.texture == 'Eltreum-Fade' and not E.db.unitframe.units.player.aurabar.reverseFill then --flip otherwise it will look wrong
						bar.spark:SetTexCoord(1, 0, 0, 1)
					end
					bar.spark:SetBlendMode('BLEND')
					--bar.spark:SetVertexColor(E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.r, E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.g, E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.b, 1)
					bar.spark:SetWidth(E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.width)
					bar.EltruismSparkPlayer = true
				end
				if E.Retail or E.Wrath then
					if E.db.unitframe.colors.transparentAurabars then
						bar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=r-0.3,g= g-0.3,b=b-0.3,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=r,g= g,b= b,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
					else
						bar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=r-0.3,g= g-0.3,b= b-0.3,a= 1}, {r=r,g= g,b= b,a= 1})
					end
				else
					if E.db.unitframe.colors.transparentAurabars then
						bar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, r-0.3, g-0.3, b-0.3, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha, r, g, b, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
					else
						bar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, r-0.3, g-0.3, b-0.3, r, g, b)
					end
				end
			elseif unit == "target" then
				if E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.enableaurabars and not bar.EltruismSparkTarget then
					bar.spark:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.texture))
					if E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.texture == 'Eltreum-Fade' and not E.db.unitframe.units.target.aurabar.reverseFill then --flip otherwise it will look wrong
						bar.spark:SetTexCoord(1, 0, 0, 1)
					end
					bar.spark:SetBlendMode('BLEND')
					--bar.spark:SetVertexColor(E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.r, E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.g, E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.b, 1)
					bar.spark:SetWidth(E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.width)
					bar.EltruismSparkTarget = true
				end
				if E.Retail or E.Wrath then
					if E.db.unitframe.colors.transparentAurabars then
						bar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=r,g= g,b= b,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=r-0.3,g= g-0.3,b= b-0.3,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
					else
						bar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=r,g= g,b= b,a= 1}, {r=r-0.3,g= g-0.3,b= b-0.3,a= 1})
					end
				else
					if E.db.unitframe.colors.transparentAurabars then
						bar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, r, g, b, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha, r-0.3, g-0.3, b-0.3, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
					else
						bar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, r, g, b, r-0.3, g-0.3, b-0.3)
					end
				end
			end
		end
	end
end
hooksecurefunc(UF, "PostUpdateBar_AuraBars", ElvUI_EltreumUI.AuraBarGradient)

--Aurabar Texture same as Unitframe
function ElvUI_EltreumUI:AuraBarTexture(frame)
	if not frame then return end
	if E.db.ElvUI_EltreumUI.unitframes.UFmodifications and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableaurabars then
		if frame and frame.AuraBars and not frame.AuraBarHook then
			hooksecurefunc(frame.AuraBars, 'PostUpdateBar', function(_,_,bar)
				if bar then
					if E.db.ElvUI_EltreumUI.skins.shadow.enable and E.db.ElvUI_EltreumUI.skins.shadow.aura and not bar.shadow then
						bar:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						bar.shadow:ClearAllPoints()
						bar.shadow:SetPoint("TOPLEFT", bar.icon, "TOPLEFT", -3,3)
						bar.shadow:SetPoint("BOTTOMRIGHT", bar, "BOTTOMRIGHT",3,-3)
						ElvUI_EltreumUI:ShadowColor(bar.shadow)
					end
					if bar.bg then
						if E.db.unitframe.colors.transparentAurabars then
							bar.bg:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
						end
						bar.backdrop:SetBackdropColor(0,0,0,0)
					end
				end
			end)
			frame.AuraBarHook = true
		end
	end
end
hooksecurefunc(UF, "Construct_PlayerFrame", ElvUI_EltreumUI.AuraBarTexture)
hooksecurefunc(UF, "Construct_TargetFrame", ElvUI_EltreumUI.AuraBarTexture)
