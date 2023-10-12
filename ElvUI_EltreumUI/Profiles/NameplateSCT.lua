local E, L, V, P, G = unpack(ElvUI)

-- NameplateSCT profile setup
function ElvUI_EltreumUI:GetNameplateSCTProfile()
	NameplateSCTDB = {
		["global"] = {
			["iconScale"] = 0.8,
			["sizing"] = {
				["critsScale"] = 3,
				["smallHitsScale"] = 0.5,
			},
			["personal"] = false,
			["shouldDisplayOverkill"] = true,
			--["yOffset"] = 75,
			["yOffset"] = 120,
			["enableMSQ"] = false,
			["truncate"] = false,
			["modOffTargetStrata"] = true,
			["fontFlag"] = ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle),
			["font"] = E.db.general.font,
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
