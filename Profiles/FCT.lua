local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local unpack = unpack

-- Floating Combat Text profile setup
function ElvUI_EltreumUI:GetFCTProfile()

	ElvFCT = {
	["nameplates"] = {
		["frames"] = {
			["EnemyNPC"] = {
				["advanced"] = {
					["OffsetY"] = 70,
				},
				["font"] = "Kimberley",
				["textShake"] = true,
				["prefix"] = "",
				["numberStyle"] = "BLIZZARD",
				["showDots"] = true,
				["critFontSize"] = 60,
				["shakeDuration"] = 0.4,
				["critShake"] = true,
				["fontSize"] = 16,
				["critFont"] = "Kimberley",
			},
			["FriendlyPlayer"] = {
				["enable"] = false,
			},
			["EnemyPlayer"] = {
				["advanced"] = {
					["OffsetY"] = 70,
				},
				["font"] = "Kimberley",
				["textShake"] = true,
				["prefix"] = "",
				["numberStyle"] = "BLIZZARD",
				["showDots"] = true,
				["critFontSize"] = 60,
				["shakeDuration"] = 0.4,
				["fontSize"] = 16,
				["critFont"] = "Kimberley",
			},
			["FriendlyNPC"] = {
				["enable"] = false,
			},
		},
	},
	["unitframes"] = {
		["enable"] = false,
	},
}
	
end