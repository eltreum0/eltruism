local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local unpack = unpack

-- NameplateSCT profile setup
function ElvUI_EltreumUI:GetNameplateSCTProfile()
	if ElvUI_EltreumUI.Retail or ElvUI_EltreumUI.Classic then
		NameplateSCTDB = {
			["global"] = {
				["iconScale"] = 0.8,
				["sizing"] = {
					["critsScale"] = 3,
					["smallHitsScale"] = 0.5,
				},
				["personal"] = false,
				["yOffset"] = 75,
				["enableMSQ"] = false,
				["truncate"] = false,
				["modOffTargetStrata"] = true,
				["fontFlag"] = "THICKOUTLINE",
				["shouldDisplayOverkill"] = true,
				["font"] = "Kimberley",
				["strata"] = {
					["target"] = "BACKGROUND",
					["offTarget"] = "BACKGROUND",
				},
				["yOffsetIcon"] = 2,
				["animations"] = {
					["miss"] = "rainfall",
				},
				["textShadow"] = false,
			},
		}
	elseif ElvUI_EltreumUI.TBC then
		NameplateSCTDB = {
			["global"] = {
				["iconScale"] = 0.8,
				["sizing"] = {
					["critsScale"] = 3,
					["smallHitsScale"] = 0.5,
				},
				["personal"] = false,
				["shouldDisplayOverkill"] = true,
				["yOffset"] = 75,
				["enableMSQ"] = false,
				["truncate"] = false,
				["modOffTargetStrata"] = true,
				["fontFlag"] = "THICKOUTLINE",
				["font"] = "Kimberley",
				["strata"] = {
					["target"] = "BACKGROUND",
					["offTarget"] = "BACKGROUND",
				},
				["yOffsetIcon"] = 2,
				["animations"] = {
					["miss"] = "rainfall",
				},
				["textShadow"] = false,
			},
		}
	end
end
