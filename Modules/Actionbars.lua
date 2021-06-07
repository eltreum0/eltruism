local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

-- Skill Glow
local LCG = LibStub('LibCustomGlow-1.0')
function ElvUI_EltreumUI:SkillGlow()
	local r, g, b = unpack(E.media.rgbvaluecolor)
	local skillglowcolor = {r, g, b, 1}
	local customglow = LibStub("LibButtonGlow-1.0")
	if E.db.ElvUI_EltreumUI.glow.enable then
		if E.db.ElvUI_EltreumUI.glow.pixel then
			--local actionType, actionID = GetPetActionInfo(button:GetAttribute("pet"))  maybe pet?
			--local actionType, actionID = GetActionInfo(button:GetAttribute("action"))
			-- need to figure out pet AutoCastable, PetActionButton
			function customglow.ShowOverlayGlow(button)
				if button:GetAttribute("type") == "action" then
					LCG.PixelGlow_Start(button, skillglowcolor, 9, 1, 3, 5, 5, 5, false, nil, high)
				end
			end
			function customglow.HideOverlayGlow(button)
				LCG.PixelGlow_Stop(button)
			end
		end
		if E.db.ElvUI_EltreumUI.glow.autocast then
			function customglow.ShowOverlayGlow(button)
				if button:GetAttribute("type") == "action" then
					LCG.AutoCastGlow_Start(button, skillglowcolor, 8, 0.8, 2, 5, 5)
				end
			end
			function customglow.HideOverlayGlow(button)
				LCG.AutoCastGlow_Stop(button)
			end
		end
		if E.db.ElvUI_EltreumUI.glow.blizzard then
			function customglow.ShowOverlayGlow(button)
				if button:GetAttribute("type") == "action" then
					LCG.ButtonGlow_Start(button, skillglowcolor, 0.5)
				end
			end
			function customglow.HideOverlayGlow(button)
				LCG.ButtonGlow_Stop(button)
			end
		end
	end
end
