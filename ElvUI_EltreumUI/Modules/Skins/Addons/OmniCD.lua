local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc

--omnicd interrupt/statusbars and icons
function ElvUI_EltreumUI:EltruismOmniCD()
	if E.db.ElvUI_EltreumUI.skins.omnicd then

		--omnicd doesnt do normal ace new addon thing
		local OmniCD = _G.OmniCD[1]

		--icons on UF shadows, only hook if shadows are enabled
		if E.db.ElvUI_EltreumUI.skins.shadow.enable then
			hooksecurefunc(OmniCD.Party,"SetBorder",function(_, icon)
				if E.db.ElvUI_EltreumUI.skins.shadow.enable then
					if not icon.shadow then
						icon:CreateShadow(2) --prevent shadow overlap
						ElvUI_EltreumUI:ShadowColor(icon.shadow)
					end
				end
			end)
		end

		--interrupt bars shadows/gradient/position
		hooksecurefunc(OmniCD.Party,"GetStatusBar",function(_, icon)
			 if icon and icon.statusBar then

			 	--shadows
			 	if E.db.ElvUI_EltreumUI.skins.shadow.enable then
					if not icon.statusBar.shadow then
						icon.statusBar:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(icon.statusBar.shadow)
					end
					if not icon.shadow then
						icon:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(icon.shadow)
					end
				end

				--fix overlap
				icon.statusBar:ClearAllPoints()
				icon.statusBar:SetPoint("LEFT", icon, "RIGHT", (E.db.ElvUI_EltreumUI.skins.shadow.length*2)+1, 0)

				--gradient on the BG
				if icon.class and not icon.EltruismHook then
					hooksecurefunc(icon.statusBar.BG,"SetVertexColor", function(self)--(_,r,g,b)
						--print(r,g,b)
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
							self:SetGradient("HORIZONTAL", ElvUI_EltreumUI:GradientColorsCustom(icon.class))
						else
							self:SetGradient("HORIZONTAL", ElvUI_EltreumUI:GradientColors(icon.class))
						end
					end)
					hooksecurefunc(icon.statusBar.CastingBar,"SetStatusBarColor", function()
						--print(r,g,b)
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
							icon.statusBar.CastingBar:GetStatusBarTexture():SetGradient("HORIZONTAL", ElvUI_EltreumUI:GradientColorsCustom(icon.class))
						else
							icon.statusBar.CastingBar:GetStatusBarTexture():SetGradient("HORIZONTAL", ElvUI_EltreumUI:GradientColors(icon.class))
						end
					end)
					icon.EltruismHook = true
				end
			end
		end)
	end
end
S:AddCallbackForAddon('OmniCD', "EltruismOmniCD", ElvUI_EltreumUI.EltruismOmniCD)
