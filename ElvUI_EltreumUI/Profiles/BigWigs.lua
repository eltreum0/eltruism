local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local LoadAddOn = LoadAddOn
local _G = _G

-- BigWigs profile setup
function ElvUI_EltreumUI:GetBigWigsProfile()

	if not IsAddOnLoaded("BigWigs_Core") then
		LoadAddOn("BigWigs_Core")
	end

	if not IsAddOnLoaded("BigWigs_Plugins") then
		LoadAddOn("BigWigs_Plugins")
	end


	if ElvUI_EltreumUI.Retail then

		--create profile
		BigWigs3DB["profiles"] = BigWigs3DB["profiles"] or {}
		BigWigs3DB["profiles"]["Eltreum"] = BigWigs3DB["profiles"]["Eltreum"] or {}
		BigWigsIconDB["hide"] = true
		BigWigs3DB["namespaces"]["BigWigs_Plugins_Victory"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Plugins_Victory"]["profiles"] or {}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_Victory"]["profiles"]["Eltreum"] = {
			["bigwigsMsg"] = true,
			["blizzMsg"] = false,
		}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_AutoReply"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Plugins_AutoReply"]["profiles"] or {}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_AutoReply"]["profiles"]["Eltreum"] = {
			["disabled"] = false,
			["exitCombat"] = 4,
			["mode"] = 4,
		}

		BigWigs3DB["namespaces"]["BigWigs_Plugins_BossBlock"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Plugins_BossBlock"]["profiles"] or {}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_BossBlock"]["profiles"]["Eltreum"] = {
			["blockTalkingHeads"] = {
				true, -- [1]
				nil, -- [2]
				nil, -- [3]
				true, -- [4]
			},
		}

		BigWigs3DB["namespaces"]["BigWigs_Plugins_Countdown"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Plugins_Countdown"]["profiles"] or {}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_Countdown"]["profiles"]["Eltreum"] = {
			["fontSize"] = 100,
			["fontName"] = "Kimberley",
		}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_AltPower"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Plugins_AltPower"]["profiles"] or {}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_AltPower"]["profiles"]["Eltreum"] = {
			["outline"] = "OUTLINE",
			["fontName"] = "Kimberley",
			["barTextColor"] = {
				nil, -- [1]
				1, -- [2]
				1, -- [3]
			},
			["position"] = {
				"TOP", -- [1]
				"TOP", -- [2]
				-355, -- [3]
				-23, -- [4]
			},
			["barColor"] = {
				1, -- [1]
				0.4862745098039216, -- [2]
				0.0392156862745098, -- [3]
				1, -- [4]
			},
		}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_Wipe"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Plugins_Wipe"]["profiles"] or {}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_Wipe"]["profiles"]["Eltreum"] = {
			["wipeSound"] = "bruh",
		}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_InfoBox"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Plugins_InfoBox"]["profiles"] or {}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_InfoBox"]["profiles"]["Eltreum"] = {
			["posx"] = 1072.500811813545,
			["posy"] = 499.0887122036947,
		}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_Bars"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Plugins_Bars"]["profiles"] or {}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_Bars"]["profiles"]["Eltreum"] = {
			["BigWigsEmphasizeAnchor_y"] = 541.4666533765339,
			["visibleBarLimit"] = 15,
			["BigWigsAnchor_width"] = 382.0000305175781,
			["BigWigsAnchor_y"] = 151,
			["emphasizeGrowup"] = true,
			["BigWigsAnchor_x"] = 1096,
			["spacing"] = 14,
			["emphasizeTime"] = 10,
			["barStyle"] = "AddOnSkins Half-Bar",
			["BigWigsEmphasizeAnchor_height"] = 11.00001621246338,
			["growup"] = true,
			["BigWigsEmphasizeAnchor_width"] = 180,
			["fontName"] = "Kimberley",
			["BigWigsAnchor_height"] = 9.999991416931152,
			["visibleBarLimitEmph"] = 6,
			["outline"] = "OUTLINE",
			["BigWigsEmphasizeAnchor_x"] = 928.2226282354313,
			["texture"] = "Eltreum-Blank",
		}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_Proximity"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Plugins_Proximity"]["profiles"] or {}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_Proximity"]["profiles"]["Eltreum"] = {
			["fontSize"] = 16,
			["fontName"] = "Kimberley",
			["width"] = 135.2697906494141,
			["objects"] = {
				["background"] = false,
			},
			["posy"] = 590,
			["height"] = 93.07933044433594,
			["posx"] = 1080,
		}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_Statistics"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Plugins_Statistics"]["profiles"] or {}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_Statistics"]["profiles"]["Eltreum"] = {
			["showBar"] = true,
		}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_Messages"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Plugins_Messages"]["profiles"] or {}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_Messages"]["profiles"]["Eltreum"] = {
			["emphFontName"] = "Kimberley",
			["emphPosition"] = {
				"TOP", -- [1]
				"TOP", -- [2]
				nil, -- [3]
				-160, -- [4]
			},
			["fontName"] = "Kimberley",
			["normalPosition"] = {
				nil, -- [1]
				nil, -- [2]
				nil, -- [3]
				-100, -- [4]
			},
		}

		-- Set the profile
		BigWigs.db:SetProfile("Eltreum")
	end
	if ElvUI_EltreumUI.Classic then
		BigWigsClassicDB = {}
		BigWigsClassicDB["profiles"] = BigWigsClassicDB["profiles"] or {}
		BigWigsClassicDB["namespaces"] = {}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Victory"] = {}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_AutoReply"] = {}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Bars"] = {}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Wipe"] = {}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_InfoBox"] = {}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Proximity"] = {}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Statistics"] = {}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Messages"] = {}

		--create profile
		BigWigsClassicDB["profiles"]["Eltreum"] = BigWigsClassicDB["profiles"]["Eltreum"] or {}
		BigWigsIconClassicDB["hide"] = true
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Victory"]["profiles"] = BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Victory"]["profiles"] or {}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Victory"]["profiles"]["Eltreum"] = {
			["bigwigsMsg"] = true,
			["soundName"] = "BigWigs: Victory Classic",
		}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_AutoReply"]["profiles"] = BigWigsClassicDB["namespaces"]["BigWigs_Plugins_AutoReply"]["profiles"] or {}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_AutoReply"]["profiles"]["Eltreum"] = {
			["disabled"] = false,
			["exitCombat"] = 4,
			["mode"] = 4,
		}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Bars"]["profiles"] = BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Bars"]["profiles"] or {}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Bars"]["profiles"]["Eltreum"] = {
			["outline"] = "OUTLINE",
			["fontSize"] = 13,
			["BigWigsEmphasizeAnchor_height"] = 7.99999332427979,
			["BigWigsEmphasizeAnchor_width"] = 162.031753540039,
			["BigWigsAnchor_width"] = 385.587371826172,
			["BigWigsAnchor_y"] = 168.033525275613,
			["fontName"] = "Kimberley",
			["BigWigsAnchor_height"] = 7.99999332427979,
			["BigWigsEmphasizeAnchor_x"] = 818.844212129385,
			["fontSizeEmph"] = 12,
			["BigWigsAnchor_x"] = 1094.35555997652,
			["spacing"] = 18,
			["barStyle"] = "AddOnSkins Half-Bar",
			["growup"] = true,
			["BigWigsEmphasizeAnchor_y"] = 595.183449336742,
			["texture"] = "Eltreum-Blank",
		}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Wipe"]["profiles"] = BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Wipe"]["profiles"] or {}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Wipe"]["profiles"]["Eltreum"] = {
			["wipeSound"] = "We are too late",
		}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_InfoBox"]["profiles"] = BigWigsClassicDB["namespaces"]["BigWigs_Plugins_InfoBox"]["profiles"] or {}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_InfoBox"]["profiles"]["Eltreum"] = {
			["posx"] = 1072.500811813545,
			["posy"] = 499.0887122036947,
		}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Messages"]["profiles"] = BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Messages"]["profiles"] or {}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Messages"]["profiles"]["Eltreum"] = {
			["emphFontName"] = "Kimberley",
			["emphPosition"] = {
				"TOP", -- [1]
				"TOP", -- [2]
				nil, -- [3]
				-160, -- [4]
			},
			["fontName"] = "Kimberley",
			["growUpwards"] = false,
			["normalPosition"] = {
				nil, -- [1]
				nil, -- [2]
				nil, -- [3]
				-100, -- [4]
			},
		}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Proximity"]["profiles"] = BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Proximity"]["profiles"] or {}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Proximity"]["profiles"]["Eltreum"] = {
			["posx"] = 1080,
			["posy"] = 650,
			["fontName"] = "Kimberley",
			["width"] = 139.999984741211,
		}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Statistics"]["profiles"] = BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Statistics"]["profiles"] or {}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Statistics"]["profiles"]["Eltreum"] = {
			["showBar"] = true,
		}

		BigWigs.db:SetProfile("Eltreum")
	end
	if ElvUI_EltreumUI.TBC then
		--create profile
		BigWigsClassicDB["profiles"] = BigWigsClassicDB["profiles"] or {}
		BigWigsClassicDB["profiles"]["Eltreum"] = BigWigsClassicDB["profiles"]["Eltreum"] or {}
		BigWigsIconClassicDB["hide"] = true
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Victory"]["profiles"] = BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Victory"]["profiles"] or {}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Victory"]["profiles"]["Eltreum"] = {
			["soundName"] = "BigWigs: Victory Classic",
		}

		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_AutoReply"]["profiles"] = BigWigsClassicDB["namespaces"]["BigWigs_Plugins_AutoReply"]["profiles"] or {}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_AutoReply"]["profiles"]["Eltreum"] = {
			["disabled"] = false,
			["exitCombat"] = 4,
			["mode"] = 3,
		}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Countdown"]["profiles"] = BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Countdown"]["profiles"] or {}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Countdown"]["profiles"]["Eltreum"] = {
			["fontSize"] = 100,
			["fontName"] = "Kimberley",
		}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_InfoBox"]["profiles"] = BigWigsClassicDB["namespaces"]["BigWigs_Plugins_InfoBox"]["profiles"] or {}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_InfoBox"]["profiles"]["Eltreum"] = {
			["posx"] = 179.7010284338503,
			["posy"] = 753.3776360958364,
		}

		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Bars"]["profiles"] = BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Bars"]["profiles"] or {}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Bars"]["profiles"]["Eltreum"] = {
			["outline"] = "OUTLINE",
			["BigWigsAnchor_width"] = 378,
			["BigWigsEmphasizeAnchor_height"] = 9,
			["growup"] = true,
			["fontName"] = "Kimberley",
			["BigWigsAnchor_height"] = 12.0000057220459,
			["BigWigsAnchor_y"] = 152,
			["spacing"] = 13,
			["BigWigsEmphasizeAnchor_y"] = 610.26668882597,
			["texture"] = "Eltreum-Blank",
			["barStyle"] = "AddOnSkins Half-Bar",
			["BigWigsAnchor_x"] = 1100,
			["fontSizeEmph"] = 11,
			["BigWigsEmphasizeAnchor_x"] = 818.0444929047226,
			["BigWigsEmphasizeAnchor_width"] = 161.7144317626953,
		}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Statistics"]["profiles"] = BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Statistics"]["profiles"] or {}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Statistics"]["profiles"]["Eltreum"] = {
			["showBar"] = true,
		}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Proximity"]["profiles"] = BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Proximity"]["profiles"] or {}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Proximity"]["profiles"]["Eltreum"] = {
			["fontSize"] = 16,
			["fontName"] = "Kimberley",
			["width"] = 139.9999847412109,
			["posy"] = 740,
			["posx"] = 296,
		}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Pull"]["profiles"] = BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Pull"]["profiles"] or {}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Pull"]["profiles"]["Eltreum"] = {
			["combatLog"] = true,
		}

		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Messages"]["profiles"] = BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Messages"]["profiles"] or {}
		BigWigsClassicDB["namespaces"]["BigWigs_Plugins_Messages"]["profiles"]["Eltreum"] = {
			["outline"] = "OUTLINE",
			["emphFontName"] = "Kimberley",
			["emphPosition"] = {
				"TOP", -- [1]
				"TOP", -- [2]
				nil, -- [3]
				-6, -- [4]
			},
			["fontName"] = "Kimberley",
			["growUpwards"] = false,
			["emphOutline"] = "OUTLINE",
			["normalPosition"] = {
				nil, -- [1]
				nil, -- [2]
				nil, -- [3]
				-100, -- [4]
			},
		}

		BigWigs.db:SetProfile("Eltreum")
	end
end
