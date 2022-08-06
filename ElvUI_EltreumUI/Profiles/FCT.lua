local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

-- Floating Combat Text profile setup
function ElvUI_EltreumUI:GetFCTProfile()
	ElvFCT = {
		["nameplates"] = {
			["frames"] = {
				["Player"] = {
					["showIcon"] = true,
					["showHots"] = true,
					["alternateIcon"] = true,
					["showDots"] = true,
				},
				["EnemyNPC"] = {
					["advanced"] = {
						["OffsetY"] = 100,
					},
					["textShake"] = true,
					["isTarget"] = false,
					["fontSize"] = 16,
					["prefix"] = "",
					["font"] = "Kimberley",
					["showDots"] = true,
					["critFontSize"] = 60,
					["shakeDuration"] = 0.4,
					["numberStyle"] = "BLIZZARD",
					["spellY"] = 100,
					["critFont"] = "Kimberley",
				},
				["FriendlyPlayer"] = {
					["enable"] = false,
					["isTarget"] = false,
					["showHots"] = true,
					["showDots"] = true,
				},
				["EnemyPlayer"] = {
					["advanced"] = {
						["OffsetY"] = 100,
					},
					["textShake"] = true,
					["isTarget"] = false,
					["fontSize"] = 16,
					["prefix"] = "",
					["font"] = "Kimberley",
					["showDots"] = true,
					["critFontSize"] = 60,
					["shakeDuration"] = 0.4,
					["numberStyle"] = "BLIZZARD",
					["spellY"] = 100,
					["critFont"] = "Kimberley",
				},
				["FriendlyNPC"] = {
					["enable"] = false,
					["isTarget"] = false,
				},
			},
		},
		["unitframes"] = {
			["enable"] = false,
		},
	}
end
