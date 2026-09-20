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

		if isHealthBar then
			if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdrophidden then
				if backdropTex then
					backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdroptexture))
					if E.db.unitframe.colors.transparentHealth or E.db.ElvUI_EltreumUI.unitframes.lightmode then
						local backdropAlpha = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha or 1
						if backdropAlpha == 1 and E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.healthalpha and E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.healthalpha < 1 then
							backdropAlpha = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.healthalpha
						end
						backdropTex:SetAlpha(backdropAlpha)
						if E.db.ElvUI_EltreumUI.unitframes.lightmode then
							backdropTex:SetVertexColor(0, 0, 0, backdropAlpha)
						end
					end
				end
			elseif E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdrophidden then
				if E.db.ElvUI_EltreumUI.unitframes.lightmode then
					if backdropTex and backdropTex.SetAlpha then
						backdropTex:SetAlpha(0)
					end
				elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
					if (E.db.unitframe.colors.transparentHealth or E.db.ElvUI_EltreumUI.unitframes.lightmode) and backdropTex and backdropTex.SetAlpha then
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
		if statusbarname then
			for i = 1, #forbiddenKeywords do
				if statusbarname:find(forbiddenKeywords[i], 1, true) then
					forbiddenframe = true
					break
				end
			end
		end

		local orientation = statusBar:GetOrientation()

		if E.db.ElvUI_EltreumUI.unitframes.UForientation == "VERTICAL" and isHealthBar and not forbiddenframe then
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
				--statusBar:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
			else
				statusBar:SetStatusBarTexture(0, 0, 0, 0)
				local targetTex
				if isHealthBar then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then
						targetTex = E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture and E.db.unitframe.statusbar or E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture
					elseif E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
						targetTex = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdroptexture
					else
						targetTex = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdroptexture
					end
				else
					targetTex = UF.db.statusbar
				end
				local fetchedTex = E.LSM:Fetch("statusbar", targetTex or UF.db.statusbar or E.db.unitframe.statusbar)
				UF:Update_StatusBar(statusBar.bg or statusBar.BG or backdropTex, fetchedTex)
				if backdropTex then
					backdropTex:SetTexture(fetchedTex)
				end
				if isHealthBar then
					local backdropAlpha = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha or 1
					if backdropAlpha == 1 and E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.healthalpha and E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.healthalpha < 1 then
						backdropAlpha = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.healthalpha
					end
					local bg = statusBar.bg or statusBar.BG
					if E.db.ElvUI_EltreumUI.unitframes.lightmode then
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
					elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
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
				end
			end

			UF:SetStatusBarBackdropPoints(statusBar, barTexture, backdropTex, orientation, reverseFill)
		else
			local texture = E.LSM:Fetch('statusbar', UF.db.statusbar)
			statusBar:SetStatusBarTexture(texture)
			UF:Update_StatusBar(statusBar.bg or statusBar.BG, texture)
			if isHealthBar then
				local backdropAlpha = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha or 1
				if backdropAlpha == 1 and E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.healthalpha and E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.healthalpha < 1 then
					backdropAlpha = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.healthalpha
				end
				local bg = statusBar.bg or statusBar.BG
				if E.db.ElvUI_EltreumUI.unitframes.lightmode then
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
				elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
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
