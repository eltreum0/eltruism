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

local borderEdges = {
	"LeftEdge",
	"RightEdge",
	"BottomEdge",
	"TopEdge",
	"TopLeftCorner",
	"TopRightCorner",
	"BottomLeftCorner",
	"BottomRightCorner",
}

local function HideBorders(frame)
	if not frame then return end
	if frame.SetBackdropBorderColor then
		frame:SetBackdropBorderColor(0, 0, 0, 0)
	end
	for i = 1, #borderEdges do
		local edge = frame[borderEdges[i]]
		if edge then
			if edge.Hide then edge:Hide() end
			if edge.SetAlpha then edge:SetAlpha(0) end
			if edge.SetVertexColor then edge:SetVertexColor(0, 0, 0, 0) end
		end
	end
	if frame.iborder and frame.iborder.Hide then frame.iborder:Hide() end
	if frame.oborder and frame.oborder.Hide then frame.oborder:Hide() end
	if frame.backdrop then
		HideBorders(frame.backdrop)
	end
end

local function ShowBorders(frame)
	if not frame then return end
	if frame.SetBackdropBorderColor then
		local borderR, borderG, borderB, borderA = 0, 0, 0, 1
		if E.db.general and E.db.general.bordercolor then
			borderR, borderG, borderB, borderA = E.db.general.bordercolor.r, E.db.general.bordercolor.g, E.db.general.bordercolor.b, E.db.general.bordercolor.a or 1
		end
		frame:SetBackdropBorderColor(borderR, borderG, borderB, borderA)
	end
	for i = 1, #borderEdges do
		local edge = frame[borderEdges[i]]
		if edge then
			if edge.Show then edge:Show() end
			if edge.SetAlpha then edge:SetAlpha(1) end
		end
	end
	if frame.iborder and frame.iborder.Show then frame.iborder:Show() end
	if frame.oborder and frame.oborder.Show then frame.oborder:Show() end
	if frame.backdrop then
		ShowBorders(frame.backdrop)
	end
end

local function ApplyBackdropAlphas(db, bg, backdrop, tex, isTransparent, barTex, isHealthBar, statusbar)
	if not db then
		db = E.db.ElvUI_EltreumUI and E.db.ElvUI_EltreumUI.unitframes
	end
	if not db or not db.UFmodifications then return end

	local isHidden = db.ufcustomtexture and db.ufcustomtexture.backdrophidden
	local rawAlpha = db.ufcustomtexture and db.ufcustomtexture.backdropalpha or 1
	local backdropAlpha = isHidden and 0 or rawAlpha
	local transparentHealth = E.db.unitframe.colors.transparentHealth or isTransparent
	local healthAlpha = transparentHealth and (db.ufcustomtexture and db.ufcustomtexture.healthalpha or 1) or 1
	if isHealthBar and not isHidden then
		if not transparentHealth then
			backdropAlpha = 1
		elseif healthAlpha < 1 then
			backdropAlpha = healthAlpha
		end
	else
		local sbName = statusbar and statusbar.GetName and statusbar:GetName()
		local isPowerBar = (sbName and (sbName:match("Power") or sbName:match("PowerBar")))
			or (statusbar and statusbar.GetParent and statusbar:GetParent().Power == statusbar)
			or (statusbar and statusbar._owner and statusbar._owner.Power == statusbar)
		if isPowerBar and not isHidden then
			local transparentPower = E.db.unitframe.colors.transparentPower or isTransparent
			if not transparentPower then
				backdropAlpha = 1
			end
		end
	end
	local hideEdges = isHidden or (rawAlpha ~= 1) or (backdropAlpha < 0.999)

	if db.lightmode then
		if bg then
			if isHidden or backdropAlpha == 0 then
				if bg.SetAlpha then bg:SetAlpha(0) end
				if bg.SetVertexColor then bg:SetVertexColor(0, 0, 0, 0) end
			else
				if bg.SetAlpha then bg:SetAlpha(backdropAlpha) end
				if bg.SetVertexColor then bg:SetVertexColor(0, 0, 0, backdropAlpha) end
			end
		end

		if backdrop then
			backdrop.customBackdropAlpha = backdropAlpha
			if isHidden or backdropAlpha == 0 then
				backdrop:SetAlpha(0)
				if backdrop.Hide then backdrop:Hide() end
				HideBorders(backdrop)
			else
				if not backdrop:IsShown() then backdrop:Show() end
				backdrop:SetAlpha(1)
				backdrop:SetBackdropColor(0, 0, 0, backdropAlpha)

				if db.ufcustomtexture and db.ufcustomtexture.backdroptexturestaticsize then
					if backdrop.Center then backdrop.Center:SetAllPoints() end
				end
				if backdrop.Center then
					if not backdrop.Center:IsShown() then backdrop.Center:Show() end
					backdrop.Center:SetAlpha(backdropAlpha)
				end

				if hideEdges then
					HideBorders(backdrop)
				else
					ShowBorders(backdrop)
				end
			end
		end

		if tex then
			if isHidden or backdropAlpha == 0 then
				if tex.SetAlpha then tex:SetAlpha(0) end
				if tex.SetVertexColor then tex:SetVertexColor(0, 0, 0, 0) end
			else
				tex:SetAlpha(backdropAlpha)
				if tex.SetVertexColor then tex:SetVertexColor(0, 0, 0, backdropAlpha) end
			end
		end

	elseif db.darkmode then
		if bg then
			if isHidden or backdropAlpha == 0 then
				if bg.SetAlpha then bg:SetAlpha(0) end
			else
				if bg.SetAlpha then bg:SetAlpha(backdropAlpha) end
			end
		end

		if backdrop then
			backdrop.customBackdropAlpha = backdropAlpha
			if isHidden or backdropAlpha == 0 then
				backdrop:SetAlpha(0)
				if backdrop.Hide then backdrop:Hide() end
				HideBorders(backdrop)
			else
				if not backdrop:IsShown() then backdrop:Show() end
				backdrop:SetAlpha(1)
				backdrop:SetBackdropColor(0, 0, 0, backdropAlpha)
				if backdrop.Center then
					if not backdrop.Center:IsShown() then backdrop.Center:Show() end
					backdrop.Center:SetAlpha(backdropAlpha)
				end
				if hideEdges then
					HideBorders(backdrop)
				else
					ShowBorders(backdrop)
				end
			end
		end

		if tex then
			if isHidden or backdropAlpha == 0 then
				if tex.SetAlpha then tex:SetAlpha(0) end
			else
				if tex.SetAlpha then tex:SetAlpha(backdropAlpha) end
			end
		end
	end

	if statusbar then
		if hideEdges then
			HideBorders(statusbar)
		else
			ShowBorders(statusbar)
		end
	end
end
ElvUI_EltreumUI.ApplyBackdropAlphas = ApplyBackdropAlphas
ElvUI_EltreumUI.HideBorders = HideBorders
ElvUI_EltreumUI.ShowBorders = ShowBorders

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
	local rawAlpha = db.ufcustomtexture and db.ufcustomtexture.backdropalpha or 1
	local backdropAlpha = isHidden and 0 or rawAlpha
	local transparentHealth = E.db.unitframe.colors.transparentHealth or isTransparent
	local healthAlpha = transparentHealth and (db.ufcustomtexture and db.ufcustomtexture.healthalpha or 1) or 1
	if isHealthBar and not isHidden then
		if not transparentHealth then
			backdropAlpha = 1
		elseif healthAlpha < 1 then
			backdropAlpha = healthAlpha
		end
	elseif isPowerBar and not isHidden then
		local transparentPower = E.db.unitframe.colors.transparentPower or isTransparent
		if not transparentPower then
			backdropAlpha = 1
		end
	end

	if isHealthBar or isPowerBar then
		local parent = statusBar.GetParent and statusBar:GetParent()
		if parent then
			parent.EltruismBackdropEpoch = nil
		end
		if not isHidden then
			local barBackdropTexture = isHealthBar and db.ufcustomtexture.backdroptexture or (db.ufcustomtexture.powertexture or db.ufcustomtexture.backdroptexture)
			if db.lightmode and statusBar.backdrop and statusBar.backdrop.Center then
				statusBar.backdrop.Center:SetTexture(E.LSM:Fetch("statusbar", barBackdropTexture))
			end
			if backdropTex then
				backdropTex:SetTexture(E.LSM:Fetch("statusbar", barBackdropTexture))
				local isBarTransparent = (isHealthBar and transparentHealth) or (isPowerBar and (E.db.unitframe.colors.transparentPower or isTransparent))
				if isBarTransparent then
					if db.lightmode then
						backdropTex:SetVertexColor(0, 0, 0, backdropAlpha)
					elseif db.darkmode then
						backdropTex:SetAlpha(backdropAlpha)
					end
				end
			end
		else
			if backdropTex then
				backdropTex:SetAlpha(0)
			end
			if statusBar.backdrop then
				statusBar.backdrop:SetAlpha(0)
				if E.db.unitframe.thinBorders then
					statusBar.backdrop:Hide()
				else
					statusBar.backdrop.Center:Hide()
				end
				HideBorders(statusBar.backdrop)
			end
		end
	elseif isHidden then
		if backdropTex then
			backdropTex:SetAlpha(0)
		end
		if statusBar.backdrop then
			statusBar.backdrop:SetAlpha(0)
			if E.db.unitframe.thinBorders then
				statusBar.backdrop:Hide()
			else
				statusBar.backdrop.Center:Hide()
			end
			HideBorders(statusBar.backdrop)
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

		if adjustBackdropPoints then
			UF:SetStatusBarBackdropPoints(statusBar, barTexture, backdropTex, orientation, reverseFill)
		end
	end

	ApplyBackdropAlphas(db, statusBar.bg or statusBar.BG, statusBar.backdrop, backdropTex, isTransparent, barTexture, isHealthBar, statusBar)

	local parent = statusBar.GetParent and statusBar:GetParent()
	if parent and parent ~= _G.UIParent and parent ~= _G.ElvUIParent then
		if parent.backdrop then
			ApplyBackdropAlphas(db, nil, parent.backdrop, nil, isTransparent, nil, false, parent)
		end
		if parent.Power then
			local powerTrans = E.db.unitframe.colors.transparentPower
			ApplyBackdropAlphas(db, parent.Power.bg, parent.Power.backdrop, parent.Power.backdropTex, powerTrans, nil, false, parent.Power)
		end
		if parent.AdditionalPower then
			ApplyBackdropAlphas(db, parent.AdditionalPower.bg, parent.AdditionalPower.backdrop, nil, isTransparent, nil, false, parent.AdditionalPower)
		end
		if parent.ClassPower then
			if parent.ClassPower.backdrop then
				ApplyBackdropAlphas(db, nil, parent.ClassPower.backdrop, nil, isTransparent, nil, false, parent.ClassPower)
			end
			for j = 1, 10 do
				local bar = parent.ClassPower[j]
				if bar then
					ApplyBackdropAlphas(db, bar.bg or bar.BG, bar.backdrop, nil, isTransparent, nil, false, bar)
				end
			end
		end
	end

	local extraFrames = {
		"ElvUF_Player_PowerBar",
		"ElvUF_Player_CastBar",
		"ElvUF_Player_ClassBar",
		"ElvUF_Player_AdditionalPowerBar",
		"ElvUF_Player_AltPowerBar",
		"ElvUF_Player_Stagger",
		"ElvUF_Target_PowerBar",
		"ElvUF_Target_CastBar",
	}
	for i = 1, #extraFrames do
		local frame = _G[extraFrames[i]]
		if frame then
			local isExtraPower = extraFrames[i]:find("Power") ~= nil
			local extraTrans = isExtraPower and E.db.unitframe.colors.transparentPower or isTransparent
			if frame.backdrop then
				ApplyBackdropAlphas(db, nil, frame.backdrop, nil, extraTrans, nil, false, frame)
			end
			if frame.bg or frame.BG then
				ApplyBackdropAlphas(db, frame.bg or frame.BG, frame.backdrop, nil, extraTrans, nil, false, frame)
			end
			for j = 1, 10 do
				local subBar = frame[j]
				if subBar then
					ApplyBackdropAlphas(db, subBar.bg or subBar.BG, subBar.backdrop, nil, extraTrans, nil, false, subBar)
				end
			end
		end
	end

	if _G["ElvUF_Player_AdditionalPowerBar"] and not _G["ElvUF_Player_AdditionalPowerBar"].EltruismBackdropHook then
		_G.hooksecurefunc(_G["ElvUF_Player_AdditionalPowerBar"], "SetStatusBarColor", function()
			if ElvUI_EltreumUI.ApplyBackdropAlphas and E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
				ElvUI_EltreumUI.ApplyBackdropAlphas(E.db.ElvUI_EltreumUI.unitframes, _G["ElvUF_Player_AdditionalPowerBar"].bg, _G["ElvUF_Player_AdditionalPowerBar"].backdrop, nil, isTransparent, nil, false, _G["ElvUF_Player_AdditionalPowerBar"])
			end
		end)
		_G["ElvUF_Player_AdditionalPowerBar"].EltruismBackdropHook = true
	end
end
ElvUI_EltreumUI:SecureHook(UF, "ToggleTransparentStatusBar", "ToggleTransparentStatusBar")
