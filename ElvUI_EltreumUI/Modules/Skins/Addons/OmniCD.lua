local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc

--omnicd interrupt/statusbars and icons
function ElvUI_EltreumUI:EltruismOmniCD()
	if E.db.ElvUI_EltreumUI.skins.omnicd then

		--omnicd name bar mode disables draw layer instead, so we need a check for that since api to check for enabled layers doesnt exist it seems
		local nameBar = false
		local currentprofile = OmniCDDB["profileKeys"][E.mynameRealm]
		if OmniCDDB["profiles"][currentprofile]["Party"]["party"]["extraBars"]["raidBar0"]["nameBar"] then
			nameBar = true
		end

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
			hooksecurefunc(OmniCD.Party,"SetExBorder",function(_, icon)
				if E.db.ElvUI_EltreumUI.skins.shadow.enable then
					if not icon.shadow then
						icon:CreateShadow(2) --prevent shadow overlap
						ElvUI_EltreumUI:ShadowColor(icon.shadow)
					end
				end
			end)
			hooksecurefunc(OmniCD.Party,"SetExIconName",function(_, icon)
				if E.db.ElvUI_EltreumUI.skins.shadow.enable then
					if not icon.shadow then
						icon:CreateShadow(2) --prevent shadow overlap
						ElvUI_EltreumUI:ShadowColor(icon.shadow)
					end
				end
			end)
		end
		--SetExStatusBarColor
		--interrupt bars shadows/gradient/position
		hooksecurefunc(OmniCD.Party,"GetStatusBar",function(_, icon)
			 if icon and icon.statusBar then

				--shadows
				if E.db.ElvUI_EltreumUI.skins.shadow.enable then
					if not icon.statusBar.shadow and not nameBar then
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
				if icon.statusBar.CastingBar then
					S:HandleStatusBar(icon.statusBar.CastingBar)
				end

				--recreate the left border, which doesn't exist anymore
				if icon.statusBar.borderRight and icon.statusBar.borderRight.SetColorTexture then
					hooksecurefunc(icon.statusBar.borderRight,"SetColorTexture", function(_,r,g,b)
						if not icon.statusBar then return end
						if not icon.statusBar.borderLeft then
							icon.statusBar.borderLeft = icon.statusBar:CreateTexture()
							icon.statusBar.borderLeft:SetColorTexture(OmniCD.db.icons.borderColor.r, OmniCD.db.icons.borderColor.g, OmniCD.db.icons.borderColor.b)
							icon.statusBar.borderLeft:SetPoint("TOPLEFT", icon.statusBar, "TOPLEFT", 0, 0)
							icon.statusBar.borderLeft:SetPoint("BOTTOMLEFT", icon.statusBar, "BOTTOMLEFT", 0, 0)
							icon.statusBar.borderLeft:SetColorTexture(r, g, b)
						else
							icon.statusBar.borderLeft:SetColorTexture(r, g, b)
						end
					end)
				end

				--gradient on the BG
				if icon.class and not icon.EltruismHook then
					hooksecurefunc(icon.statusBar.BG,"SetVertexColor", function(bar)
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
							bar:SetGradient("HORIZONTAL", ElvUI_EltreumUI:GradientColorsCustom(bar:GetParent():GetParent().class))
						else
							bar:SetGradient("HORIZONTAL", ElvUI_EltreumUI:GradientColors(bar:GetParent():GetParent().class))
						end
					end)
					hooksecurefunc(icon.statusBar.CastingBar,"SetStatusBarColor", function(bar2)
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
							bar2:GetStatusBarTexture():SetGradient("HORIZONTAL", ElvUI_EltreumUI:GradientColorsCustom(bar2:GetParent():GetParent().class))
						else
							bar2:GetStatusBarTexture():SetGradient("HORIZONTAL", ElvUI_EltreumUI:GradientColors(bar2:GetParent():GetParent().class))
						end
					end)
					icon.EltruismHook = true
				end
			end
		end)
	end
end
S:AddCallbackForAddon('OmniCD', "EltruismOmniCD", ElvUI_EltreumUI.EltruismOmniCD)
