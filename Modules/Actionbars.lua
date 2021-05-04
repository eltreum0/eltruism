local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local pairs = pairs
local SetCVar = SetCVar
local IsAddOnLoaded = IsAddOnLoaded


-- Skill Glow
local LCG = LibStub('LibCustomGlow-1.0')
function ElvUI_EltreumUI:SkillGlow()
	local r, g, b = unpack(E.media.rgbvaluecolor)
	local skillglowcolor = {r, g, b, 1}
	local customglow = LibStub("LibButtonGlow-1.0")
	if E.private.ElvUI_EltreumUI.glow.enable then
		if E.private.ElvUI_EltreumUI.glow.pixel then
			--local actionType, actionID = GetPetActionInfo(button:GetAttribute("pet"))
			-- need to figure out pet AutoCastable, PetActionButton
			function customglow.ShowOverlayGlow(button)
				if button:GetAttribute("type") == "action" then
					local actionType, actionID = GetActionInfo(button:GetAttribute("action"))
					----PixelGlow_Start(frame[, color[, N[, frequency[, length[, th[, xOffset[, yOffset[, border[ ,key]]]]]]]])
					LCG.PixelGlow_Start(button, skillglowcolor, 9, 1, 3, 5, 5, 5, false, nil, high)
				end
			end
			function customglow.HideOverlayGlow(button)
				LCG.PixelGlow_Stop(button)
			end
		end
		if E.private.ElvUI_EltreumUI.glow.autocast then
			function customglow.ShowOverlayGlow(button)
				if button:GetAttribute("type") == "action" then
					local actionType, actionID = GetActionInfo(button:GetAttribute("action"))
					----AutoCastGlow_Start(frame[, color[, N[, frequency[, scale[, xOffset[, yOffset[, key]]]]]]])
					----N - number of particle groups. Each group contains 4 particles. Defaul value is 4;
					LCG.AutoCastGlow_Start(button, skillglowcolor, 8, 0.8, 2, 5, 5)
				end
			end
			function customglow.HideOverlayGlow(button)
				LCG.AutoCastGlow_Stop(button)
			end
		end
		if E.private.ElvUI_EltreumUI.glow.blizzard then
			function customglow.ShowOverlayGlow(button)
				if button:GetAttribute("type") == "action" then
					local actionType, actionID = GetActionInfo(button:GetAttribute("action"))
					----ButtonGlow_Start(frame[, color[, frequency]]])
					LCG.ButtonGlow_Start(button, skillglowcolor, 0.5)
				end
			end
			function customglow.HideOverlayGlow(button)
				LCG.ButtonGlow_Stop(button)
			end
		end
	end
end
