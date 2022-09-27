local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

-- NameplateSCT profile setup
function ElvUI_EltreumUI:GetNameplateSCTProfile()
	local width = GetPhysicalScreenSize()
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
			["fontFlag"] = (width == 1920 and "OUTLINE") or "THICKOUTLINE",
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
