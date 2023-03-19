local E, L, V, P, G = unpack(ElvUI)
local _G  = _G
local IsAddOnLoaded = _G.IsAddOnLoaded
local LoadAddOn = _G.LoadAddOn
local bigwigstype

-- BigWigs profile setup
function ElvUI_EltreumUI:GetBigWigsProfile()

	if not IsAddOnLoaded("BigWigs_Core") then
		LoadAddOn("BigWigs_Core")
	end

	if not IsAddOnLoaded("BigWigs_Plugins") then
		LoadAddOn("BigWigs_Plugins")
	end

	if E.Retail then
		bigwigstype = BigWigs3DB
	else
		bigwigstype = BigWigsClassicDB
	end

	--create profile
	bigwigstype["profiles"] = bigwigstype["profiles"] or {}
	bigwigstype["profiles"]["Eltreum"] = bigwigstype["profiles"]["Eltreum"] or {}
	bigwigstype["namespaces"]["BigWigs_Plugins_AutoReply"]["profiles"] = bigwigstype["namespaces"]["BigWigs_Plugins_AutoReply"]["profiles"] or {}
	bigwigstype["namespaces"]["BigWigs_Plugins_AutoReply"]["profiles"]["Eltreum"] = {
		["disabled"] = false,
		["exitCombat"] = 4,
		["mode"] = 4,
	}
	bigwigstype["namespaces"]["BigWigs_Plugins_Countdown"]["profiles"] = bigwigstype["namespaces"]["BigWigs_Plugins_Countdown"]["profiles"] or {}
	bigwigstype["namespaces"]["BigWigs_Plugins_Countdown"]["profiles"]["Eltreum"] = {
		["fontSize"] = 100,
		["fontName"] = E.db.general.font,
	}
	bigwigstype["namespaces"]["BigWigs_Plugins_InfoBox"]["profiles"] = bigwigstype["namespaces"]["BigWigs_Plugins_InfoBox"]["profiles"] or {}
	bigwigstype["namespaces"]["BigWigs_Plugins_InfoBox"]["profiles"]["Eltreum"] = {
		["posx"] = 386,
		["posy"] = 121,
	}
	bigwigstype["namespaces"]["BigWigs_Plugins_Bars"]["profiles"] = bigwigstype["namespaces"]["BigWigs_Plugins_Bars"]["profiles"] or {}
	bigwigstype["namespaces"]["BigWigs_Plugins_Bars"]["profiles"]["Eltreum"] = {
		["BigWigsEmphasizeAnchor_y"] = 541,
		["visibleBarLimit"] = 15,
		["BigWigsAnchor_width"] = 379,
		["BigWigsAnchor_y"] = 160,
		["emphasizeGrowup"] = true,
		["BigWigsAnchor_x"] = 1093,
		["spacing"] = 15,
		["emphasizeTime"] = 10,
		["emphasizeGrowup"] = true,
		--["barStyle"] = "AddOnSkins Half-Bar",
		["barStyle"] = "Eltruism",
		["BigWigsEmphasizeAnchor_height"] = 15,
		["growup"] = true,
		["BigWigsEmphasizeAnchor_width"] = 180,
		["fontName"] = E.db.general.font,
		["BigWigsAnchor_height"] = 15,
		["visibleBarLimitEmph"] = 6,
		["outline"] = "OUTLINE",
		["BigWigsEmphasizeAnchor_x"] = 928,
		["texture"] = "ElvUI Norm1",
		["outline"] = "OUTLINE",
	}
	bigwigstype["namespaces"]["BigWigs_Plugins_Statistics"]["profiles"] = bigwigstype["namespaces"]["BigWigs_Plugins_Statistics"]["profiles"] or {}
	bigwigstype["namespaces"]["BigWigs_Plugins_Statistics"]["profiles"]["Eltreum"] = {
		["showBar"] = true,
	}
	bigwigstype["namespaces"]["BigWigs_Plugins_Proximity"]["profiles"] = bigwigstype["namespaces"]["BigWigs_Plugins_Proximity"]["profiles"] or {}
	bigwigstype["namespaces"]["BigWigs_Plugins_Proximity"]["profiles"]["Eltreum"] = {
		["fontSize"] = 16,
		["fontName"] = E.db.general.font,
		["width"] = 135,
		["objects"] = {
			["background"] = false,
		},
		["posy"] = 121,
		["height"] = 93,
		["posx"] = 928,
	}
	bigwigstype["namespaces"]["BigWigs_Plugins_Messages"]["profiles"] = bigwigstype["namespaces"]["BigWigs_Plugins_Messages"]["profiles"] or {}
	bigwigstype["namespaces"]["BigWigs_Plugins_Messages"]["profiles"]["Eltreum"] = {
		["outline"] = "OUTLINE",
		["emphFontName"] = E.db.general.font,
		["emphPosition"] = {
			"TOP", -- [1]
			"TOP", -- [2]
			nil, -- [3]
			-160, -- [4]
		},
		["fontName"] = E.db.general.font,
		["growUpwards"] = false,
		["emphOutline"] = "OUTLINE",
		["normalPosition"] = {
			nil, -- [1]
			nil, -- [2]
			nil, -- [3]
			-100, -- [4]
		},
	}
	bigwigstype["namespaces"]["BigWigs_Plugins_Colors"]["profiles"] = bigwigstype["namespaces"]["BigWigs_Plugins_Colors"]["profiles"] or {}
	bigwigstype["namespaces"]["BigWigs_Plugins_Colors"]["profiles"]["Eltreum"] = {
		["barColor"] = {
			["BigWigs_Plugins_Colors"] = {
				["default"] = {
					0.5098039507865906, -- [1]
					0.7019608020782471, -- [2]
					1, -- [3]
				},
			},
		},
		["barEmphasized"] = {
			["BigWigs_Plugins_Colors"] = {
				["default"] = {
					0.7098039388656616, -- [1]
					0.03529411926865578, -- [2]
					0.03529411926865578, -- [3]
				},
			},
		},
	}
	bigwigstype["namespaces"]["BigWigs_Plugins_Wipe"]["profiles"] = bigwigstype["namespaces"]["BigWigs_Plugins_Wipe"]["profiles"] or {}
	bigwigstype["namespaces"]["BigWigs_Plugins_Wipe"]["profiles"]["Eltreum"] = {
		["wipeSound"] = "AmanThul - Wipe",
	}

	if E.Retail then
		BigWigsIconDB["hide"] = true

		bigwigstype["namespaces"]["BigWigs_Plugins_BossBlock"]["profiles"] = bigwigstype["namespaces"]["BigWigs_Plugins_BossBlock"]["profiles"] or {}
		bigwigstype["namespaces"]["BigWigs_Plugins_BossBlock"]["profiles"]["Eltreum"] = {
			["blockTalkingHeads"] = {
				true, -- [1]
				nil, -- [2]
				nil, -- [3]
				true, -- [4]
			},
		}
		bigwigstype["namespaces"]["BigWigs_Plugins_AltPower"]["profiles"] = bigwigstype["namespaces"]["BigWigs_Plugins_AltPower"]["profiles"] or {}
		bigwigstype["namespaces"]["BigWigs_Plugins_AltPower"]["profiles"]["Eltreum"] = {
			["outline"] = "OUTLINE",
			["fontName"] = E.db.general.font,
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
		bigwigstype["namespaces"]["BigWigs_Plugins_Victory"]["profiles"] = bigwigstype["namespaces"]["BigWigs_Plugins_Victory"]["profiles"] or {}
		bigwigstype["namespaces"]["BigWigs_Plugins_Victory"]["profiles"]["Eltreum"] = {
			["bigwigsMsg"] = true,
			["blizzMsg"] = false,
		}
	else
		BigWigsIconClassicDB["hide"] = true

		bigwigstype["namespaces"]["BigWigs_Plugins_Victory"]["profiles"] = bigwigstype["namespaces"]["BigWigs_Plugins_Victory"]["profiles"] or {}
		bigwigstype["namespaces"]["BigWigs_Plugins_Victory"]["profiles"]["Eltreum"] = {
			["bigwigsMsg"] = true,
		}
	end

	-- Set the profile
	bigwigstype["profileKeys"] = {[E.mynameRealm] = "Eltreum",
	}

end
