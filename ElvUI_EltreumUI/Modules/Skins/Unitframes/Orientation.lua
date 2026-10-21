local E = unpack(ElvUI)
local UF = E:GetModule('UnitFrames')
local _G = _G
local pairs = _G.pairs

local forbiddenKeywords = {
	["Tank"] = true,
	["Raid"] = true,
	["Boss"] = true,
	["Arena"] = true,
	["Assist"] = true,
	["Party"] = true,
}

local function ApplyBackdropAlphas(db, bg, backdrop, tex, isTransparent, barTex, isHealthBar, statusbar)
	if not db then
		db = E.db.ElvUI_EltreumUI and E.db.ElvUI_EltreumUI.unitframes
	end
	if not db or not db.UFmodifications then return end

	local isHidden = db.ufcustomtexture and db.ufcustomtexture.backdrophidden
	local staticSize = db.ufcustomtexture and db.ufcustomtexture.backdroptexturestaticsize
	local rawAlpha = (db.ufcustomtexture and db.ufcustomtexture.backdropalpha) or 1
	local backdropAlpha = isHidden and 0 or rawAlpha

	if isHealthBar then
		local transparentHealth = E.db.unitframe.colors.transparentHealth or isTransparent
		local healthAlpha = transparentHealth and (db.ufcustomtexture and db.ufcustomtexture.healthalpha or 1) or 1

		if db.lightmode then
			if bg then
				bg:SetAlpha(backdropAlpha)
				if not isHidden then
					bg:SetVertexColor(0, 0, 0, backdropAlpha)
				end
			end
			if backdrop then
				backdrop.customBackdropAlpha = backdropAlpha
				backdrop:SetBackdropColor(0, 0, 0, backdropAlpha)
				if isHidden then
					if E.db.unitframe.thinBorders then
						backdrop:Hide()
					elseif backdrop.Center then
						backdrop.Center:Hide()
					end
				else
					if not backdrop:IsShown() then backdrop:Show() end
					if backdrop.Center and backdrop.Center:IsShown() then
						backdrop.Center:Hide()
					end
				end
			end
		elseif db.darkmode then
			local darkBackdropAlpha = backdropAlpha
			if not isHidden and transparentHealth and backdropAlpha == 1 and healthAlpha < 1 then
				darkBackdropAlpha = healthAlpha
			end
			local missingHealthAlpha = (transparentHealth and backdropAlpha == 1 and healthAlpha < 1) and healthAlpha or rawAlpha

			if tex then
				tex:SetAlpha(missingHealthAlpha)
			end
			if backdrop then
				backdrop.customBackdropAlpha = darkBackdropAlpha
				backdrop:SetBackdropColor(0, 0, 0, darkBackdropAlpha)
				if isHidden then
					if E.db.unitframe.thinBorders then
						backdrop:Hide()
					elseif backdrop.Center then
						backdrop.Center:Hide()
					end
					if not transparentHealth and barTex then
						barTex:SetAlpha(0)
					end
				else
					if not backdrop:IsShown() then backdrop:Show() end
					if backdrop.Center then
						if not backdrop.Center:IsShown() then backdrop.Center:Show() end
						backdrop.Center:SetAlpha(darkBackdropAlpha)
					end
					if not transparentHealth and barTex then
						barTex:SetAlpha(darkBackdropAlpha)
					end
				end
			end
		end
	else
		if isHidden then
			if bg then bg:SetAlpha(0) end
			if tex then tex:SetAlpha(0) end
			if backdrop then
				backdrop.customBackdropAlpha = 0
				backdrop:SetBackdropColor(0, 0, 0, 0)
				if E.db.unitframe.thinBorders then
					backdrop:Hide()
				elseif backdrop.Center then
					backdrop.Center:Hide()
				end
			end
		else
			if bg then
				bg:SetAlpha(backdropAlpha)
				if statusbar and staticSize then
					bg:SetAllPoints(statusbar)
				end
			end
			if tex then
				tex:SetAlpha(backdropAlpha)
			end
			if backdrop then
				backdrop.customBackdropAlpha = backdropAlpha
				if not backdrop:IsShown() then backdrop:Show() end
				backdrop:SetBackdropColor(0, 0, 0, backdropAlpha)
				if backdrop.Center and backdrop.Center:IsShown() then
					backdrop.Center:Hide()
				end
			end
		end
	end

	if isHidden or staticSize then
		if backdrop and backdrop.LeftEdge and backdrop.LeftEdge:IsShown() then
			backdrop.LeftEdge:Hide()
			backdrop.BottomLeftCorner:Hide()
			backdrop.TopLeftCorner:Hide()
			backdrop.RightEdge:Hide()
			backdrop.BottomRightCorner:Hide()
			backdrop.TopRightCorner:Hide()
			backdrop.TopEdge:Hide()
			backdrop.BottomEdge:Hide()
		end
	elseif backdrop and backdrop.LeftEdge and not backdrop.LeftEdge:IsShown() then
		backdrop.LeftEdge:Show()
		backdrop.BottomLeftCorner:Show()
		backdrop.TopLeftCorner:Show()
		backdrop.RightEdge:Show()
		backdrop.BottomRightCorner:Show()
		backdrop.TopRightCorner:Show()
		backdrop.TopEdge:Show()
		backdrop.BottomEdge:Show()
	end

end
ElvUI_EltreumUI.ApplyBackdropAlphas = ApplyBackdropAlphas

-- Unitframe Backdrop Texture/Alpha/Fill Direction
function ElvUI_EltreumUI:ToggleTransparentStatusBar(_, isTransparent, statusBar, backdropTex, adjustBackdropPoints, _, reverseFill)
	if not statusBar then return end
	if not E.db.ElvUI_EltreumUI.unitframes.UFmodifications then return end

	local statusbarname = statusBar.GetName and statusBar:GetName()
	local isHealthBar = statusbarname and statusbarname:match("HealthBar")
	local isPowerBar = (statusbarname and (statusbarname:match("Power") or statusbarname:match("PowerBar")))
		or (statusBar.GetParent and statusBar:GetParent().Power == statusBar)
		or (statusBar._owner and statusBar._owner.Power == statusBar)
	local isAuraBar = statusbarname and statusbarname:match("AuraBar")
	local db = E.db.ElvUI_EltreumUI.unitframes
	local gm = db.gradientmode

	local isHidden = db.ufcustomtexture and db.ufcustomtexture.backdrophidden
	local backdropAlpha = isHidden and 0 or (db.ufcustomtexture and db.ufcustomtexture.backdropalpha or 1)
	local bg = statusBar.bg or statusBar.BG

	if isHealthBar then
		local parent = statusBar.GetParent and statusBar:GetParent()
		if parent then
			parent.EltruismBackdropEpoch = nil
		end
		if not isHidden then
			if db.lightmode and bg then
				bg:SetTexture(E.LSM:Fetch("statusbar", db.ufcustomtexture.backdroptexture))
				if E.db.unitframe.colors.transparentHealth then
					bg:SetVertexColor(0, 0, 0, backdropAlpha)
				end
			elseif db.darkmode then
				if statusBar.backdrop and statusBar.backdrop.Center then
					statusBar.backdrop.Center:SetTexture(E.LSM:Fetch("statusbar", db.ufcustomtexture.backdroptexture))
					statusBar.backdrop.Center:SetAlpha(backdropAlpha)
				end
				if E.db.unitframe.colors.transparentHealth and backdropTex then
					backdropTex:SetAlpha(db.ufcustomtexture.backdropalpha or 1)
				end
			end
		else
			if db.lightmode and bg then
				bg:SetAlpha(0)
			elseif db.darkmode and E.db.unitframe.colors.transparentHealth and backdropTex then
				backdropTex:SetAlpha(db.ufcustomtexture.backdropalpha or 1)
			end
			if statusBar.backdrop then
				if E.db.unitframe.thinBorders then
					statusBar.backdrop:Hide()
				elseif statusBar.backdrop.Center then
					statusBar.backdrop.Center:Hide()
				end
			end
		end
	elseif isHidden then
		if bg then
			bg:SetAlpha(0)
		end
		if backdropTex then
			backdropTex:SetAlpha(0)
		end
		if statusBar.backdrop then
			if E.db.unitframe.thinBorders then
				statusBar.backdrop:Hide()
			elseif statusBar.backdrop.Center then
				statusBar.backdrop.Center:Hide()
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
	local barTexture = statusBar:GetStatusBarTexture() -- This fixes Center Pixel offset problem (normally this has > 2 points)
	barTexture:SetInside(nil, 0, 0) -- This also unsnaps the texture

	if isTransparent then
		if isAuraBar then
			local texture = E.LSM:Fetch('statusbar', UF.db.statusbar)
			statusBar:SetStatusBarTexture(texture)
			UF:Update_StatusBar(bg, texture)
		elseif isHealthBar then
			statusBar:SetStatusBarTexture(0, 0, 0, 0)
			if db.lightmode then
				local fetchedTex = E.LSM:Fetch("statusbar", db.ufcustomtexture.backdroptexture or E.db.unitframe.statusbar or UF.db.statusbar)
				UF:Update_StatusBar(bg, fetchedTex)
			elseif db.darkmode then
				local targetTex = E.db.unitframe.statusbar
				if gm.enable then
					targetTex = gm.useUFtexture and E.db.unitframe.statusbar or gm.texture
				end
				local fetchedTex = E.LSM:Fetch("statusbar", targetTex or E.db.unitframe.statusbar or UF.db.statusbar)
				if backdropTex then
					backdropTex:SetTexture(fetchedTex)
				end
				if not isHidden and statusBar.backdrop and statusBar.backdrop.Center then
					statusBar.backdrop.Center:SetTexture(E.LSM:Fetch("statusbar", db.ufcustomtexture.backdroptexture or E.db.unitframe.statusbar or UF.db.statusbar))
				end
			end
		else
			local targetTex = E.db.unitframe.statusbar
			if isPowerBar and db.ufcustomtexture.enable and db.ufcustomtexture.powertexture then
				targetTex = db.ufcustomtexture.powertexture
			elseif gm.enable and not db.ufcustomtexture.enable then
				targetTex = gm.useUFtexture and targetTex or gm.texture
			end

			local fetchedTex = E.LSM:Fetch("statusbar", targetTex or UF.db.statusbar)
			statusBar:SetStatusBarTexture(fetchedTex)
			local bgTex = (db.ufcustomtexture.backdroptexture and E.LSM:Fetch("statusbar", db.ufcustomtexture.backdroptexture)) or fetchedTex
			UF:Update_StatusBar(bg, bgTex)
			if backdropTex then
				backdropTex:SetTexture(bgTex)
			end
		end

		UF:SetStatusBarBackdropPoints(statusBar, barTexture, backdropTex, orientation, reverseFill)
	else --not transparent but texture should be set
		local texture = E.db.unitframe.statusbar
		if isPowerBar and db.ufcustomtexture.enable and db.ufcustomtexture.powertexture then
			texture = db.ufcustomtexture.powertexture
		elseif gm.enable and not db.ufcustomtexture.enable then
			texture = gm.useUFtexture and texture or gm.texture
		end
		local fetchedTex = E.LSM:Fetch('statusbar', texture or UF.db.statusbar)
		statusBar:SetStatusBarTexture(fetchedTex)

		local bgTex = (db.ufcustomtexture.backdroptexture and E.LSM:Fetch("statusbar", db.ufcustomtexture.backdroptexture)) or texture
		UF:Update_StatusBar(bg, bgTex)

		if adjustBackdropPoints then
			UF:SetStatusBarBackdropPoints(statusBar, barTexture, backdropTex, orientation, reverseFill)
		end
	end

	ApplyBackdropAlphas(db, bg, statusBar.backdrop, backdropTex, isTransparent, barTexture, isHealthBar, statusBar)
end
ElvUI_EltreumUI:SecureHook(UF, "ToggleTransparentStatusBar", "ToggleTransparentStatusBar")
