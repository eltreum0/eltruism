local E = unpack(ElvUI)
local UF = E:GetModule('UnitFrames')
local _G = _G
local pairs = _G.pairs
local hooksecurefunc = _G.hooksecurefunc

local forbiddenKeywords = {
	["Tank"] = true,
	["Raid"] = true,
	["Boss"] = true,
	["Arena"] = true,
	["Assist"] = true,
	["Party"] = true,
}

local function ApplyBackdropAlphas(db, bg, backdrop, tex)
	local transparentHealth = E.db.unitframe.colors.transparentHealth
	local backdropAlpha = transparentHealth and (db.ufcustomtexture.backdropalpha or 1) or 1
	local healthAlpha = transparentHealth and (db.ufcustomtexture.healthalpha or 1) or 1
	if backdropAlpha == 1 and healthAlpha < 1 then
		backdropAlpha = healthAlpha
	end

	if db.lightmode then
		if bg then
			if bg.SetAlpha then bg:SetAlpha(backdropAlpha) end
			if bg.SetVertexColor then bg:SetVertexColor(0, 0, 0, backdropAlpha) end
		end
		if backdrop then
			backdrop.customBackdropAlpha = backdropAlpha
			backdrop:SetBackdropColor(0, 0, 0, backdropAlpha)
			if transparentHealth and backdrop.Center then backdrop.Center:Hide() end
		end
		if tex then
			tex:SetAlpha(backdropAlpha)
			if tex.SetVertexColor then tex:SetVertexColor(0, 0, 0, backdropAlpha) end
		end
	elseif db.darkmode then
		if bg and bg.SetAlpha then bg:SetAlpha(backdropAlpha) end
		if backdrop then
			if backdrop.Center then
				if not backdrop.Center:IsShown() then
					backdrop.Center:Show()
				end
				backdrop.Center:SetAlpha(backdropAlpha)
			end
			backdrop.customBackdropAlpha = backdropAlpha
			backdrop:SetBackdropColor(0, 0, 0, backdropAlpha)
		end
		if tex and tex.SetAlpha then tex:SetAlpha(backdropAlpha) end
	end
end
ElvUI_EltreumUI.ApplyBackdropAlphas = ApplyBackdropAlphas

-- Unitframe Backdrop Texture/Alpha/Fill Direction
function ElvUI_EltreumUI:ToggleTransparentStatusBar(isTransparent, statusBar, backdropTex, adjustBackdropPoints, _, reverseFill)
	if not statusBar then return end
	if not E.db.ElvUI_EltreumUI.unitframes.UFmodifications then return end

	local statusbarname = statusBar.GetName and statusBar:GetName()
	local isHealthBar = statusbarname and statusbarname:match("HealthBar")
	local isAuraBar = statusbarname and statusbarname:match("AuraBar")
	local db = E.db.ElvUI_EltreumUI.unitframes
	local gm = db.gradientmode

	local transparentHealth = E.db.unitframe.colors.transparentHealth
	local backdropAlpha = transparentHealth and (E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha or 1) or 1
	local healthAlpha = transparentHealth and (E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.healthalpha or 1) or 1
	if backdropAlpha == 1 and healthAlpha < 1 then
		backdropAlpha = healthAlpha
	end

	if isHealthBar then
		local parent = statusBar:GetParent()
		if parent then
			parent.EltruismBackdropEpoch = nil
		end
		if not db.ufcustomtexture.backdrophidden then
			if backdropTex then
				backdropTex:SetTexture(E.LSM:Fetch("statusbar", db.ufcustomtexture.backdroptexture))
				if E.db.unitframe.colors.transparentHealth then
					if db.lightmode then
						backdropTex:SetVertexColor(0, 0, 0, backdropAlpha)
					elseif db.darkmode then
						backdropTex:SetAlpha(backdropAlpha)
					end
				end
			end
		elseif E.db.unitframe.colors.transparentHealth then
			if backdropTex then
				backdropTex:SetAlpha(backdropAlpha)
			end
			if statusBar.backdrop then
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
		for keyword in pairs(forbiddenKeywords) do
			if statusbarname:find(keyword, 1, true) then
				forbiddenframe = true
				break
			end
		end
	end

	local orientation = statusBar:GetOrientation()

	if db.UForientation == "VERTICAL" and isHealthBar and not forbiddenframe then
		orientation = "VERTICAL"
	end

	-- from elvui
	local barTexture = statusBar:GetStatusBarTexture()  -- This fixes Center Pixel offset problem (normally this has > 2 points)
	barTexture:SetInside(nil, 0, 0) -- This also unsnaps the texture

	if isTransparent then
		if isAuraBar then
			local texture = E.LSM:Fetch('statusbar', UF.db.statusbar)
			statusBar:SetStatusBarTexture(texture)
			UF:Update_StatusBar(statusBar.bg or statusBar.BG, texture)
			--statusBar:SetAlpha(db.ufcustomtexture.backdropalpha)
		elseif isHealthBar then
			statusBar:SetStatusBarTexture(0, 0, 0, 0)
			local targetTex = db.ufcustomtexture.backdroptexture
			if gm.enable then
				targetTex = gm.useUFtexture and E.db.unitframe.statusbar or gm.texture
			end

			local fetchedTex = E.LSM:Fetch("statusbar", targetTex or E.db.unitframe.statusbar or UF.db.statusbar)
			UF:Update_StatusBar(statusBar.bg or statusBar.BG or backdropTex, fetchedTex)
			if backdropTex then
				backdropTex:SetTexture(fetchedTex)
			end

			ApplyBackdropAlphas(db, statusBar.bg or statusBar.BG, statusBar.backdrop, backdropTex)
		else
			local targetTex = E.db.unitframe.statusbar
			if gm.enable then
				targetTex = gm.useUFtexture and targetTex or gm.texture
			end

			local fetchedTex = E.LSM:Fetch("statusbar", targetTex or E.db.unitframe.statusbar or UF.db.statusbar)
			statusBar:SetStatusBarTexture(fetchedTex)
			UF:Update_StatusBar(statusBar.bg or statusBar.BG or backdropTex, fetchedTex)
			if backdropTex then
				backdropTex:SetTexture(fetchedTex)
			end
		end

		UF:SetStatusBarBackdropPoints(statusBar, barTexture, backdropTex, orientation, reverseFill)
	else --not transparent but texture should be set
		local texture = E.LSM:Fetch('statusbar', E.db.unitframe.statusbar or UF.db.statusbar)
		statusBar:SetStatusBarTexture(texture)
		UF:Update_StatusBar(statusBar.bg or statusBar.BG, texture)

		if isHealthBar then
			ApplyBackdropAlphas(db, statusBar.bg or statusBar.BG, statusBar.backdrop, backdropTex)
		end

		if adjustBackdropPoints then
			UF:SetStatusBarBackdropPoints(statusBar, barTexture, backdropTex, orientation, reverseFill)
		end
	end
end
hooksecurefunc(UF, "ToggleTransparentStatusBar", ElvUI_EltreumUI.ToggleTransparentStatusBar)
