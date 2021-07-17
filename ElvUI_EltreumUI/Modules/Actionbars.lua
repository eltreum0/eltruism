local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

-- Skill Glow
local LCG = LibStub('LibCustomGlow-1.0')
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
	local customglow = LibStub("LibButtonGlow-1.0")
	if E.db.ElvUI_EltreumUI.glow.enable then
		if E.db.ElvUI_EltreumUI.glow.pixel then
			--local actionType, actionID = GetPetActionInfo(button:GetAttribute("pet"))  maybe pet?
			--local actionType, actionID = GetActionInfo(button:GetAttribute("action"))
			-- need to figure out pet AutoCastable, PetActionButton
			function customglow.ShowOverlayGlow(button)
				if button:GetAttribute("type") == "action" then
					--PixelGlow_Start(frame[, color[, N[, frequency[, length[, th[, xOffset[, yOffset[, border[ ,key]]]]]]]])
					LCG.PixelGlow_Start(button, skillglowcolor, E.db.ElvUI_EltreumUI.glow.numberpixel, E.db.ElvUI_EltreumUI.glow.frequencypixel, E.db.ElvUI_EltreumUI.glow.lengthpixel, E.db.ElvUI_EltreumUI.glow.thicknesspixel, E.db.ElvUI_EltreumUI.glow.pixelxOffset, E.db.ElvUI_EltreumUI.glow.pixelyOffset, E.db.ElvUI_EltreumUI.glow.borderpixel, nil, high)
				end
			end
			function customglow.HideOverlayGlow(button)
				LCG.PixelGlow_Stop(button)
			end
		end
		if E.db.ElvUI_EltreumUI.glow.autocast then
			function customglow.ShowOverlayGlow(button)
				if button:GetAttribute("type") == "action" then
					--AutoCastGlow_Start(frame[, color[, N[, frequency[, scale[, xOffset[, yOffset[, key]]]]]]])
					LCG.AutoCastGlow_Start(button, skillglowcolor, E.db.ElvUI_EltreumUI.glow.numberauto, E.db.ElvUI_EltreumUI.glow.frequencyauto, E.db.ElvUI_EltreumUI.glow.autoscale, E.db.ElvUI_EltreumUI.glow.autoxOffset, E.db.ElvUI_EltreumUI.glow.autoyOffset)
				end
			end
			function customglow.HideOverlayGlow(button)
				LCG.AutoCastGlow_Stop(button)
			end
		end
		if E.db.ElvUI_EltreumUI.glow.blizzard then
			function customglow.ShowOverlayGlow(button)
				if button:GetAttribute("type") == "action" then
					--ButtonGlow_Start(frame[, color[, frequency]]])
					LCG.ButtonGlow_Start(button, skillglowcolor, E.db.ElvUI_EltreumUI.glow.frequencyblizz)
				end
			end
			function customglow.HideOverlayGlow(button)
				LCG.ButtonGlow_Stop(button)
			end
		end
	end
end


local AB = E:GetModule('ActionBars')
function ElvUI_EltreumUI:UpdatePet(event, unit)
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
	for i = 1, NUM_PET_ACTION_SLOTS, 1 do
		local _, _, _, _, _, autoCastEnabled, _ = GetPetActionInfo(i)
		local buttonName = 'PetActionButton'..i
		local button = _G[buttonName]

		if autoCastEnabled then
			AutoCastShine_AutoCastStop(button.AutoCastShine)
			--if E.db.ElvUI_EltreumUI.glow.pixel then
				--PixelGlow_Start(frame[, color[, N[, frequency[, length[, th[, xOffset[, yOffset[, border[ ,key]]]]]]]])
				LCG.PixelGlow_Start(button, skillglowcolor, 10, 0.25, 5, 2, 0, 0, false, nil, high)
			--end
			--if E.db.ElvUI_EltreumUI.glow.autocast then
				--LCG.AutoCastGlow_Start(button, skillglowcolor, 4, 0.4, 1, 0, 0)
			--end
			--if E.db.ElvUI_EltreumUI.glow.blizzard then
			--	LCG.ButtonGlow_Start(button, skillglowcolor, E.db.ElvUI_EltreumUI.glow.frequencyblizz)
			--end
		else
			AutoCastShine_AutoCastStop(button.AutoCastShine)
			--if E.db.ElvUI_EltreumUI.glow.pixel then
				LCG.PixelGlow_Stop(button)
			--end
			--if E.db.ElvUI_EltreumUI.glow.autocast then
				--LCG.AutoCastGlow_Stop(button)
			--end
			--if E.db.ElvUI_EltreumUI.glow.blizzard then
			--	LCG.ButtonGlow_Stop(button)
			--end
		end
	end
end
hooksecurefunc(AB, "UpdatePet", ElvUI_EltreumUI.UpdatePet)
