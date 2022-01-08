local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local AB = E:GetModule('ActionBars')
local LCG = E.Libs.CustomGlow

-- Skill Glow
function ElvUI_EltreumUI:SkillGlow()
	local skillglowcolor
	if not E.db.ElvUI_EltreumUI.glow.colorclass then
		local glowcustomcolor = E.db.ElvUI_EltreumUI.glowcustomcolor
		local r, g, b = glowcustomcolor.r, glowcustomcolor.g, glowcustomcolor.b
		skillglowcolor = {r, g, b, 1}
	end
	if E.db.ElvUI_EltreumUI.glow.colorclass then
		local r, g, b = unpack(E.media.rgbvaluecolor)
		skillglowcolor = {r, g, b, 1}
	end
	if E.db.ElvUI_EltreumUI.glow.enable then
		if E.db.ElvUI_EltreumUI.glow.pixel then
			function LCG.ShowOverlayGlow(button)
				if button:GetAttribute("type") == "action" then
					LCG.PixelGlow_Start(button, skillglowcolor, E.db.ElvUI_EltreumUI.glow.numberpixel, E.db.ElvUI_EltreumUI.glow.frequencypixel, E.db.ElvUI_EltreumUI.glow.lengthpixel, E.db.ElvUI_EltreumUI.glow.thicknesspixel, E.db.ElvUI_EltreumUI.glow.pixelxOffset, E.db.ElvUI_EltreumUI.glow.pixelyOffset, E.db.ElvUI_EltreumUI.glow.borderpixel, nil, high)
				end
			end
			function LCG.HideOverlayGlow(button)
				LCG.PixelGlow_Stop(button)
			end
		end
		if E.db.ElvUI_EltreumUI.glow.autocast then
			function LCG.ShowOverlayGlow(button)
				if button:GetAttribute("type") == "action" then
					LCG.AutoCastGlow_Start(button, skillglowcolor, E.db.ElvUI_EltreumUI.glow.numberauto, E.db.ElvUI_EltreumUI.glow.frequencyauto, E.db.ElvUI_EltreumUI.glow.autoscale, E.db.ElvUI_EltreumUI.glow.autoxOffset, E.db.ElvUI_EltreumUI.glow.autoyOffset)
				end
			end
			function LCG.HideOverlayGlow(button)
				LCG.AutoCastGlow_Stop(button)
			end
		end
		if E.db.ElvUI_EltreumUI.glow.blizzard then
			function LCG.ShowOverlayGlow(button)
				if button:GetAttribute("type") == "action" then
					LCG.ButtonGlow_Start(button, skillglowcolor, E.db.ElvUI_EltreumUI.glow.frequencyblizz)
				end
			end
			function LCG.HideOverlayGlow(button)
				LCG.ButtonGlow_Stop(button)
			end
		end
	end
end

--Skill Glow Pet
function ElvUI_EltreumUI:SkillGlowPet(event, unit)
	local skillglowcolor
	if not E.db.ElvUI_EltreumUI.glow.colorclass then
		local glowcustomcolor = E.db.ElvUI_EltreumUI.glowcustomcolorpet
		local r, g, b = glowcustomcolor.r, glowcustomcolor.g, glowcustomcolor.b
		skillglowcolor = {r, g, b, 1}
	end
	if E.db.ElvUI_EltreumUI.glow.colorclass then
		local r, g, b = unpack(E.media.rgbvaluecolor)
		skillglowcolor = {r, g, b, 1}
	end

	if E.db.ElvUI_EltreumUI.glow.enablepet then
		for i = 1, NUM_PET_ACTION_SLOTS, 1 do
			local _, _, _, _, _, autoCastEnabled, _ = GetPetActionInfo(i)
			local buttonName = 'PetActionButton'..i
			local button = _G[buttonName]

			if autoCastEnabled then
				AutoCastShine_AutoCastStop(button.AutoCastShine)
				if E.db.ElvUI_EltreumUI.glow.pixel then
					--PixelGlow_Start(frame[, color[, N[, frequency[, length[, th[, xOffset[, yOffset[, border[ ,key]]]]]]]])
					LCG.PixelGlow_Start(button, skillglowcolor, 10, 0.25, 5, 2, 0, 0, false, nil, high)
				end
				if E.db.ElvUI_EltreumUI.glow.autocast then
					--AutoCastGlow_Start(frame[, color[, N[, frequency[, scale[, xOffset[, yOffset[, key]]]]]]])
					LCG.AutoCastGlow_Start(button, skillglowcolor, 16, 0.25, 0.7, 0, 0)
				end
				if E.db.ElvUI_EltreumUI.glow.blizzard then
					--ButtonGlow_Start(frame[, color[, frequency]]])
					LCG.ButtonGlow_Start(button, skillglowcolor, 0.125)
				end
			else
				AutoCastShine_AutoCastStop(button.AutoCastShine)
				if E.db.ElvUI_EltreumUI.glow.pixel then
					LCG.PixelGlow_Stop(button)
				end
				if E.db.ElvUI_EltreumUI.glow.autocast then
					LCG.AutoCastGlow_Stop(button)
				end
				if E.db.ElvUI_EltreumUI.glow.blizzard then
					LCG.ButtonGlow_Stop(button)
				end
			end
		end
	end
end
hooksecurefunc(AB, "UpdatePet", ElvUI_EltreumUI.SkillGlowPet)

--Preview the Glow as asked by Releaf
local EltruismGlowPreview = CreateFrame("Frame", "EltruismGlowPreview")
EltruismGlowPreview:SetSize(40, 40)
EltruismGlowPreview:ClearAllPoints()
EltruismGlowPreview:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 50)
EltruismGlowPreview:SetFrameStrata("DIALOG")
local EltruismGlowTexture = EltruismGlowPreview:CreateTexture()
EltruismGlowPreview:Hide()
function ElvUI_EltreumUI:PreviewGlow()
	EltruismGlowTexture:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\GlowPreview.tga")
	EltruismGlowTexture:SetAllPoints(EltruismGlowPreview)
	EltruismGlowPreview:SetMovable(true)
	EltruismGlowPreview:EnableMouse(true)
	EltruismGlowPreview:RegisterForDrag("LeftButton")
	EltruismGlowPreview:SetScript("OnDragStart", EltruismGlowPreview.StartMoving)
	EltruismGlowPreview:SetScript("OnDragStop",EltruismGlowPreview.StopMovingOrSizing)

	local skillglowcolor
	if not E.db.ElvUI_EltreumUI.glow.colorclass then
		local glowcustomcolor = E.db.ElvUI_EltreumUI.glowcustomcolor
		local r, g, b = glowcustomcolor.r, glowcustomcolor.g, glowcustomcolor.b
		skillglowcolor = {r, g, b, 1}
	end
	if E.db.ElvUI_EltreumUI.glow.colorclass then
		local r, g, b = unpack(E.media.rgbvaluecolor)
		skillglowcolor = {r, g, b, 1}
	end
	if EltruismGlowPreview:IsShown() then
		LCG.PixelGlow_Stop(EltruismGlowPreview)
		LCG.AutoCastGlow_Stop(EltruismGlowPreview)
		LCG.ButtonGlow_Stop(EltruismGlowPreview)
		EltruismGlowPreview:Hide()
	else
		EltruismGlowPreview:Show()
		if E.db.ElvUI_EltreumUI.glow.pixel then
			LCG.PixelGlow_Start(EltruismGlowPreview, skillglowcolor, E.db.ElvUI_EltreumUI.glow.numberpixel, E.db.ElvUI_EltreumUI.glow.frequencypixel, E.db.ElvUI_EltreumUI.glow.lengthpixel, E.db.ElvUI_EltreumUI.glow.thicknesspixel, E.db.ElvUI_EltreumUI.glow.pixelxOffset, E.db.ElvUI_EltreumUI.glow.pixelyOffset, E.db.ElvUI_EltreumUI.glow.borderpixel, nil, high)
		end
		if E.db.ElvUI_EltreumUI.glow.autocast then
			LCG.AutoCastGlow_Start(EltruismGlowPreview, skillglowcolor, E.db.ElvUI_EltreumUI.glow.numberauto, E.db.ElvUI_EltreumUI.glow.frequencyauto, E.db.ElvUI_EltreumUI.glow.autoscale, E.db.ElvUI_EltreumUI.glow.autoxOffset, E.db.ElvUI_EltreumUI.glow.autoyOffset)
		end
		if E.db.ElvUI_EltreumUI.glow.blizzard then
			LCG.ButtonGlow_Start(EltruismGlowPreview, skillglowcolor, E.db.ElvUI_EltreumUI.glow.frequencyblizz)
		end
	end
end
