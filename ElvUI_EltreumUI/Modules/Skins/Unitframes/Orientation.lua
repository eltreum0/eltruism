local E = unpack(ElvUI)
local UF = E:GetModule('UnitFrames')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc

local forbiddenKeywords = {
	"Tank",
	"Raid",
	"Boss",
	"Arena",
	"Assist",
	"Party",
}

--Unitframe Backdrop Texture/Alpha/Fill Direction
function ElvUI_EltreumUI:ToggleTransparentStatusBar(isTransparent, statusBar, backdropTex, adjustBackdropPoints, _, reverseFill)
	if not statusBar then return end
	if E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
		local statusbarname = statusBar.GetName and statusBar:GetName()
		local isHealthBar = statusbarname and statusbarname:match("HealthBar")
		local isAuraBar = statusbarname and statusbarname:match("AuraBar")
		local db = E.db.ElvUI_EltreumUI.unitframes
		local gm = db.gradientmode

		if isHealthBar then
			if not db.ufcustomtexture.backdrophidden then
				if backdropTex then
					backdropTex:SetTexture(E.LSM:Fetch("statusbar", db.ufcustomtexture.backdroptexture))
					if E.db.unitframe.colors.transparentHealth or db.lightmode then
						local backdropAlpha = db.ufcustomtexture.backdropalpha or 1
						if backdropAlpha == 1 and db.ufcustomtexture.healthalpha and db.ufcustomtexture.healthalpha < 1 then
							backdropAlpha = db.ufcustomtexture.healthalpha
						end
						backdropTex:SetAlpha(backdropAlpha)
						if db.lightmode then
							backdropTex:SetVertexColor(0, 0, 0, backdropAlpha)
						end
					end
				end
			elseif db.ufcustomtexture.backdrophidden then
				if db.lightmode then
					if backdropTex and backdropTex.SetAlpha then
						backdropTex:SetAlpha(0)
					end
				elseif db.darkmode then
					if (E.db.unitframe.colors.transparentHealth or db.lightmode) and backdropTex and backdropTex.SetAlpha then
						backdropTex:SetAlpha(db.ufcustomtexture.backdropalpha)
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
		if statusbarname then
			for i = 1, #forbiddenKeywords do
				if statusbarname:find(forbiddenKeywords[i], 1, true) then
					forbiddenframe = true
					break
				end
			end
		end

		local orientation = statusBar:GetOrientation()

		if db.UForientation == "VERTICAL" and isHealthBar and not forbiddenframe then
			orientation = "VERTICAL"
		end
		--from elvui
		local barTexture = statusBar:GetStatusBarTexture() -- This fixes Center Pixel offset problem (normally this has > 2 points)
		barTexture:SetInside(nil, 0, 0) -- This also unsnaps the texture

		if isTransparent then
			if isAuraBar then
				local texture = E.LSM:Fetch('statusbar', UF.db.statusbar)
				statusBar:SetStatusBarTexture(texture)
				UF:Update_StatusBar(statusBar.bg or statusBar.BG, texture)
				--statusBar:SetAlpha(db.ufcustomtexture.backdropalpha)
			elseif isHealthBar then
				statusBar:SetStatusBarTexture(0, 0, 0, 0)
				local targetTex
				if gm.enable then
					targetTex = gm.useUFtexture and E.db.unitframe.statusbar or gm.texture
				elseif db.ufcustomtexture.enable then
					targetTex = db.ufcustomtexture.backdroptexture
				else
					targetTex = db.ufcustomtexture.backdroptexture
				end
				local fetchedTex = E.LSM:Fetch("statusbar", targetTex or UF.db.statusbar or E.db.unitframe.statusbar)
				UF:Update_StatusBar(statusBar.bg or statusBar.BG or backdropTex, fetchedTex)
				if backdropTex then
					backdropTex:SetTexture(fetchedTex)
				end
				local backdropAlpha = db.ufcustomtexture.backdropalpha or 1
				if backdropAlpha == 1 and db.ufcustomtexture.healthalpha and db.ufcustomtexture.healthalpha < 1 then
					backdropAlpha = db.ufcustomtexture.healthalpha
				end
				local bg = statusBar.bg or statusBar.BG
				if db.lightmode then
					if bg then
						if bg.SetAlpha then bg:SetAlpha(backdropAlpha) end
						if bg.SetVertexColor then bg:SetVertexColor(0, 0, 0, backdropAlpha) end
					end
					if statusBar.backdrop then
						statusBar.backdrop:SetAlpha(backdropAlpha)
						statusBar.backdrop:SetBackdropColor(0, 0, 0, 0)
						if statusBar.backdrop.Center then
							statusBar.backdrop.Center:Hide()
						end
					end
					if backdropTex then
						backdropTex:SetAlpha(backdropAlpha)
						if backdropTex.SetVertexColor then
							backdropTex:SetVertexColor(0, 0, 0, backdropAlpha)
						end
					end
				elseif db.darkmode then
					if bg and bg.SetAlpha then
						bg:SetAlpha(backdropAlpha)
					end
					if statusBar.backdrop then
						if E.db.unitframe.thinBorders then
							statusBar.backdrop:SetAlpha(backdropAlpha)
						elseif statusBar.backdrop.Center then
							statusBar.backdrop.Center:Show()
							statusBar.backdrop.Center:SetAlpha(backdropAlpha)
						end
						statusBar.backdrop:SetBackdropColor(0, 0, 0, backdropAlpha)
					end
				end
			else
				local targetTex
				if gm.enable then
					if gm.useUFtexture then
						targetTex = E.db.unitframe.statusbar
					else
						targetTex = gm.texture
					end
				else
					targetTex = E.db.unitframe.statusbar
				end
				local fetchedTex = E.LSM:Fetch("statusbar", targetTex or E.db.unitframe.statusbar or UF.db.statusbar)
				statusBar:SetStatusBarTexture(fetchedTex)
				UF:Update_StatusBar(statusBar.bg or statusBar.BG or backdropTex, fetchedTex)
				if backdropTex then
					backdropTex:SetTexture(fetchedTex)
				end
			end

			UF:SetStatusBarBackdropPoints(statusBar, barTexture, backdropTex, orientation, reverseFill)
		else
			local texture = E.LSM:Fetch('statusbar', E.db.unitframe.statusbar or UF.db.statusbar)
			statusBar:SetStatusBarTexture(texture)
			UF:Update_StatusBar(statusBar.bg or statusBar.BG, texture)
			if isHealthBar then
				local backdropAlpha = db.ufcustomtexture.backdropalpha or 1
				if backdropAlpha == 1 and db.ufcustomtexture.healthalpha and db.ufcustomtexture.healthalpha < 1 then
					backdropAlpha = db.ufcustomtexture.healthalpha
				end
				local bg = statusBar.bg or statusBar.BG
				if db.lightmode then
					if bg then
						if bg.SetAlpha then bg:SetAlpha(backdropAlpha) end
						if bg.SetVertexColor then bg:SetVertexColor(0, 0, 0, backdropAlpha) end
					end
					if statusBar.backdrop then
						statusBar.backdrop:SetAlpha(backdropAlpha)
						statusBar.backdrop:SetBackdropColor(0, 0, 0, 0)
						if statusBar.backdrop.Center then
							statusBar.backdrop.Center:Hide()
						end
					end
					if backdropTex then
						backdropTex:SetAlpha(backdropAlpha)
						if backdropTex.SetVertexColor then
							backdropTex:SetVertexColor(0, 0, 0, backdropAlpha)
						end
					end
				elseif db.darkmode then
					if bg and bg.SetAlpha then
						bg:SetAlpha(backdropAlpha)
					end
					if statusBar.backdrop then
						if E.db.unitframe.thinBorders then
							statusBar.backdrop:SetAlpha(backdropAlpha)
						elseif statusBar.backdrop.Center then
							statusBar.backdrop.Center:Show()
							statusBar.backdrop.Center:SetAlpha(backdropAlpha)
						end
						statusBar.backdrop:SetBackdropColor(0, 0, 0, backdropAlpha)
					end
					if backdropTex then
						backdropTex:SetAlpha(backdropAlpha)
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
