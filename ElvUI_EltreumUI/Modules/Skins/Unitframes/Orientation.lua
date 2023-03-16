local ElvUI_EltreumUI, E, L, V, P, G = unpack((select(2, ...)))
local UF = E:GetModule('UnitFrames')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc

--Unitframe Backdrop Texture/Alpha/Fill Direction
function UF:ToggleTransparentStatusBar(isTransparent, statusBar, backdropTex, adjustBackdropPoints, invertColors, reverseFill)
	statusBar.isTransparent = isTransparent
	statusBar.invertColors = invertColors
	statusBar.backdropTex = backdropTex

	if not statusBar.hookedColor then
		hooksecurefunc(statusBar, 'SetStatusBarColor', UF.UpdateBackdropTextureColor)
		statusBar.hookedColor = true
	end

	if E.db.ElvUI_EltreumUI.unitframes.UFmodifications and statusBar:GetName():match("HealthBar") then
		if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdrophidden then
			backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdroptexture))
			backdropTex:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
			--if statusBar and statusBar.backdrop and E.db.ElvUI_EltreumUI.unitframes.lightmode then
				--statusBar.backdrop:SetBackdropColor(0,0,0,E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
				--statusBar.backdrop:Hide()
				--backdropTex:Hide()
			--end
		elseif E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdrophidden then
			if E.db.ElvUI_EltreumUI.unitframes.lightmode then
				if backdropTex then
					backdropTex:SetAlpha(0)
				end
			end
			if statusBar and statusBar.backdrop and statusBar:GetName():match("HealthBar") then
				statusBar.backdrop:Hide()
			end
		end
	end

	local orientation = statusBar:GetOrientation()
	if E.db.ElvUI_EltreumUI.unitframes.UForientation == "VERTICAL" and statusBar:GetName():match("HealthBar") and E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
		orientation = "VERTICAL"
	end
	local barTexture = statusBar:GetStatusBarTexture() -- This fixes Center Pixel offset problem (normally this has > 2 points)
	barTexture:SetInside(nil, 0, 0) -- This also unsnaps the texture

	UF:HandleStatusBarTemplate(statusBar, statusBar:GetParent(), isTransparent)

	if isTransparent then
		if E.db.ElvUI_EltreumUI.unitframes.UFmodifications and statusBar:GetName():match("AuraBar") then
			statusBar:SetStatusBarTexture(E.LSM:Fetch('statusbar', UF.db.statusbar))
			UF:Update_StatusBar(statusBar.bg or statusBar.BG, E.LSM:Fetch('statusbar', UF.db.statusbar))
			--statusBar:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
		else
			statusBar:SetStatusBarTexture(0, 0, 0, 0)
			UF:Update_StatusBar(statusBar.bg or statusBar.BG, E.media.blankTex)
		end

		UF:SetStatusBarBackdropPoints(statusBar, barTexture, backdropTex, orientation, reverseFill)
	else
		local texture = E.LSM:Fetch('statusbar', UF.db.statusbar)
		statusBar:SetStatusBarTexture(texture)
		UF:Update_StatusBar(statusBar.bg or statusBar.BG, texture)

		if adjustBackdropPoints then
			UF:SetStatusBarBackdropPoints(statusBar, barTexture, backdropTex, orientation, reverseFill)
		end
	end
end
