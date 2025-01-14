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

		if E.db.ElvUI_EltreumUI.unitframes.thinmodeaurabars then --thin mode aurabars?
			bar:SetHeight(5)
			bar.icon:SetSize(25,15)
			bar.icon:ClearAllPoints()
			bar.icon:SetPoint("BOTTOMRIGHT",bar,"BOTTOMLEFT",-7,0)
			bar.icon:SetTexCoord(0.08, 0.92, 0.2799995956419, 0.7200004043581)

			bar.nameText:ClearAllPoints()
			bar.nameText:SetPoint('LEFT', bar, 'LEFT', 4, 4)
			bar.timeText:ClearAllPoints()
			bar.timeText:SetPoint('RIGHT', bar, 'RIGHT', -2, 4)
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
						ElvUI_EltreumUI:ShadowColor(bar.shadow)
						if E.db.ElvUI_EltreumUI.unitframes.thinmodeaurabars then
							if bar.shadow then
								bar.shadow:ClearAllPoints()
								bar.shadow:SetPoint("TOPRIGHT", bar.backdrop, "TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								bar.shadow:SetPoint("BOTTOMLEFT", bar.backdrop, "BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								if bar.backdrop and not bar.backdrop.shadow then
									bar.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
									ElvUI_EltreumUI:ShadowColor(bar.backdrop.shadow)
									if bar.icon and bar.icon.backdrop then
										bar.backdrop.shadow:ClearAllPoints()
										bar.backdrop.shadow:SetPoint("TOPRIGHT",bar.icon.backdrop, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
										bar.backdrop.shadow:SetPoint("BOTTOMLEFT",bar.icon.backdrop, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
									end
								end
							end
						else
							bar.shadow:ClearAllPoints()
							bar.shadow:SetPoint("TOPLEFT", bar.icon, "TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
							bar.shadow:SetPoint("BOTTOMRIGHT", bar, "BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
						end
					end
					if bar.bg then
						if E.db.unitframe.colors.transparentAurabars then
							--bar.bg:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
							if E.db.unitframe.colors.customaurabarbackdrop then
								bar.bg:SetVertexColor(E.db.unitframe.colors.aurabar_backdrop.r,E.db.unitframe.colors.aurabar_backdrop.g,E.db.unitframe.colors.aurabar_backdrop.b,E.db.general.backdropfadecolor.a)
								if bar.backdropTex then
									bar.backdropTex:SetVertexColor(E.db.unitframe.colors.aurabar_backdrop.r,E.db.unitframe.colors.aurabar_backdrop.g,E.db.unitframe.colors.aurabar_backdrop.b,E.db.general.backdropfadecolor.a)
								end
							else
								bar.bg:SetVertexColor(0,0,0,E.db.general.backdropfadecolor.a)
								if bar.backdropTex then
									bar.backdropTex:SetVertexColor(0,0,0,E.db.general.backdropfadecolor.a)
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
