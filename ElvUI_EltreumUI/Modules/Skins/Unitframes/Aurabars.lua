local E = unpack(ElvUI)
local _G = _G
local UF = E:GetModule('UnitFrames')
local hooksecurefunc = _G.hooksecurefunc

--Gradient Aurabars
function ElvUI_EltreumUI:AuraBarGradient(unit, bar) --could use isStealable to add a glow or something
	if not unit and not bar then return end
	if E.db.ElvUI_EltreumUI.unitframes.UFmodifications and bar and unit then
		if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableaurabars then
			if not bar.EltruismHook then
				hooksecurefunc(bar,"SetStatusBarColor", function(_,r,g,b)
					if bar.unit then
						if bar.unit == "player" then
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
							if E.db.unitframe.colors.transparentAurabars then
								bar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=r-0.3,g= g-0.3,b=b-0.3,a= E.db.general.backdropfadecolor.a}, {r=r,g= g,b= b,a= E.db.general.backdropfadecolor.a})
							else
								bar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=r-0.3,g= g-0.3,b= b-0.3,a= 1}, {r=r,g= g,b= b,a= 1})
							end
						elseif bar.unit == "target" then
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
							if E.db.unitframe.colors.transparentAurabars then
								bar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=r,g= g,b= b,a= E.db.general.backdropfadecolor.a}, {r=r-0.3,g= g-0.3,b= b-0.3,a= E.db.general.backdropfadecolor.a})
							else
								bar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=r,g= g,b= b,a= 1}, {r=r-0.3,g= g-0.3,b= b-0.3,a= 1})
							end
						end
					end
				end)
				bar.EltruismHook = true
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
							--bar.bg:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
							if E.db.unitframe.colors.customaurabarbackdrop then
								bar.bg:SetVertexColor(E.db.unitframe.colors.aurabar_backdrop.r,E.db.unitframe.colors.aurabar_backdrop.g,E.db.unitframe.colors.aurabar_backdrop.b,E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
								if bar.backdropTex then
									bar.backdropTex:SetVertexColor(E.db.unitframe.colors.aurabar_backdrop.r,E.db.unitframe.colors.aurabar_backdrop.g,E.db.unitframe.colors.aurabar_backdrop.b,E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
								end
							else
								bar.bg:SetVertexColor(0,0,0,E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
								if bar.backdropTex then
									bar.backdropTex:SetVertexColor(0,0,0,E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
								end
							end
						end
						if bar.unit == "target" and E.db.unitframe.units.target.aurabar.reverseFill then
							bar.backdrop:SetBackdropColor(0,0,0,E.db.general.backdropfadecolor.a)
						elseif bar.unit == "player" and E.db.unitframe.units.player.aurabar.reverseFill then
							bar.backdrop:SetBackdropColor(0,0,0,E.db.general.backdropfadecolor.a)
						else
							bar.backdrop:SetBackdropColor(0,0,0,0)
						end
					end
				end
			end)
			frame.AuraBarHook = true
		end
	end
end
hooksecurefunc(UF, "Construct_PlayerFrame", ElvUI_EltreumUI.AuraBarTexture)
hooksecurefunc(UF, "Construct_TargetFrame", ElvUI_EltreumUI.AuraBarTexture)
