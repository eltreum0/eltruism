local E = unpack(ElvUI)
local UF = E:GetModule('UnitFrames')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc

--Unitframe Backdrop Texture/Alpha/Fill Direction
function ElvUI_EltreumUI:ToggleTransparentStatusBar(isTransparent, statusBar, backdropTex, adjustBackdropPoints, _, reverseFill)
	if not statusBar then return end
	if E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
		local statusbarname = statusBar.GetName and statusBar:GetName()
		local isHealthBar = statusbarname and statusbarname:match("HealthBar")
		local isAuraBar = statusbarname and statusbarname:match("AuraBar")

		if isHealthBar then
			if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdrophidden then
				if backdropTex and backdropTex.SetTexture then
					backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdroptexture))
				end
				if E.db.unitframe.colors.transparentHealth and backdropTex and backdropTex.SetAlpha then
					backdropTex:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
				end
			elseif E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdrophidden then
				if E.db.ElvUI_EltreumUI.unitframes.lightmode then
					if backdropTex and backdropTex.SetAlpha then
						backdropTex:SetAlpha(0)
					end
				elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
					if E.db.unitframe.colors.transparentHealth and backdropTex and backdropTex.SetAlpha then
						backdropTex:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
					end
				end
				if statusBar and statusBar.backdrop and isHealthBar then
					if E.db.unitframe.thinBorders then
						statusBar.backdrop:Hide()
					else
						statusBar.backdrop.Center:Hide()
					end
				end
			end
		end

		local forbiddenframe = false
		if statusbarname and (statusbarname:match("Tank") or statusbarname:match("Raid") or statusbarname:match("Boss") or statusbarname:match("Arena") or statusbarname:match("Assist") or statusbarname:match("Party")) then
			forbiddenframe = true
		end

		local orientation = statusBar:GetOrientation()

		if E.db.ElvUI_EltreumUI.unitframes.UForientation == "VERTICAL" and isHealthBar and not forbiddenframe then
			orientation = "VERTICAL"
		end
		local barTexture = statusBar:GetStatusBarTexture() -- This fixes Center Pixel offset problem (normally this has > 2 points)
		barTexture:SetInside(nil, 0, 0) -- This also unsnaps the texture

		if isTransparent then
			if isAuraBar then
				statusBar:SetStatusBarTexture(E.LSM:Fetch('statusbar', UF.db.statusbar))
				UF:Update_StatusBar(statusBar.bg or statusBar.BG, E.LSM:Fetch('statusbar', UF.db.statusbar))
				--statusBar:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
			else
				statusBar:SetStatusBarTexture(0, 0, 0, 0)
				if E.db.ElvUI_EltreumUI.unitframes.darkmode and isHealthBar then
					local targetTex
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then
						targetTex = E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture and E.db.unitframe.statusbar or E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture
					elseif E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
						targetTex = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdroptexture
					else
						targetTex = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdroptexture
					end
					local fetchedTex = E.LSM:Fetch("statusbar", targetTex)
					UF:Update_StatusBar(statusBar.bg or statusBar.BG or backdropTex, fetchedTex)
					if backdropTex and backdropTex.SetTexture then
						backdropTex:SetTexture(fetchedTex)
					end
				else
					UF:Update_StatusBar(statusBar.bg or statusBar.BG, E.media.blankTex)
				end
			end

			UF:SetStatusBarBackdropPoints(statusBar, barTexture, backdropTex, orientation, reverseFill)
		else
			local texture = E.LSM:Fetch('statusbar', UF.db.statusbar)
			statusBar:SetStatusBarTexture(texture)
			UF:Update_StatusBar(statusBar.bg or statusBar.BG, texture)
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop and isHealthBar then --was causing the black color
				if E.db.ElvUI_EltreumUI.unitframes.lightmode then
					if backdropTex then
						backdropTex:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
						--backdropTex:SetTexture(E.db.general.backdropfadecolor.r, E.db.general.backdropfadecolor.g, E.db.general.backdropfadecolor.b, E.db.general.backdropfadecolor.a)
					end
				end
			end
			if adjustBackdropPoints then
				UF:SetStatusBarBackdropPoints(statusBar, barTexture, backdropTex, orientation, reverseFill)
			end
		end
	end
end
hooksecurefunc(UF,"ToggleTransparentStatusBar", ElvUI_EltreumUI.ToggleTransparentStatusBar)
