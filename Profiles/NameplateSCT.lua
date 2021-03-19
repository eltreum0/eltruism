local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

local unpack = unpack


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
		["yOffset"] = 75,
		["enableMSQ"] = false,
		["truncate"] = false,
		["modOffTargetStrata"] = true,
		["fontFlag"] = "THICKOUTLINE",
		["font"] = "Kimberley",
		["strata"] = {
			["offTarget"] = "LOW",
		},
		["yOffsetIcon"] = 2,
		["animations"] = {
			["miss"] = "rainfall",
		},
		["textShadow"] = false,
	},
}
	
end
