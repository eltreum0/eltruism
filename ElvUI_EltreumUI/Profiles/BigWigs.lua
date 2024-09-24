local E, L, V, P, G = unpack(ElvUI)
local _G = _G
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded
local LoadAddOn = _G.C_AddOns and _G.C_AddOns.LoadAddOn or _G.LoadAddOn

-- BigWigs profile setup
function ElvUI_EltreumUI:GetBigWigsProfile()

	if not IsAddOnLoaded("BigWigs_Core") then
		LoadAddOn("BigWigs_Core")
	end

	if not IsAddOnLoaded("BigWigs_Plugins") then
		LoadAddOn("BigWigs_Plugins")
	end

	if BigWigs3DB["profiles"] and BigWigs3DB["profiles"]["Eltreum"] then
		table.insert(BigWigs3DB.profileKeys, E.mynameRealm)
		BigWigs3DB["profileKeys"][E.mynameRealm] = "Eltreum"
	else
		--create profile
		BigWigs3DB["profiles"] = BigWigs3DB["profiles"] or {}
		BigWigs3DB["profiles"]["Eltreum"] = BigWigs3DB["profiles"]["Eltreum"] or {}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_AutoReply"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Plugins_AutoReply"]["profiles"] or {}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_AutoReply"]["profiles"]["Eltreum"] = {
			["disabled"] = false,
			["exitCombat"] = 4,
			["mode"] = 4,
		}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_Countdown"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Plugins_Countdown"]["profiles"] or {}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_Countdown"]["profiles"]["Eltreum"] = {
			["fontSize"] = 100,
			["fontName"] = E.db.general.font,
		}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_InfoBox"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Plugins_InfoBox"]["profiles"] or {}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_InfoBox"]["profiles"]["Eltreum"] = {
			["posx"] = 386,
			["posy"] = 121,
		}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_Bars"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Plugins_Bars"]["profiles"] or {}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_Bars"]["profiles"]["Eltreum"] = {
			--["BigWigsEmphasizeAnchor_y"] = 541,
			["visibleBarLimit"] = 15,
			--["BigWigsAnchor_width"] = 379,
			--["BigWigsAnchor_y"] = 160,
			["emphasizeGrowup"] = true,
			--["BigWigsAnchor_x"] = 1093,
			["spacing"] = 15,
			["emphasizeTime"] = 10,
			--["barStyle"] = "AddOnSkins Half-Bar",
			["barStyle"] = "Eltruism",
			--["BigWigsEmphasizeAnchor_height"] = 15,
			["growup"] = true,
			--["BigWigsEmphasizeAnchor_width"] = 180,
			["fontName"] = E.db.general.font,
			--["BigWigsAnchor_height"] = 15,
			["visibleBarLimitEmph"] = 6,
			["outline"] = ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle),
			--["BigWigsEmphasizeAnchor_x"] = 928,
			["texture"] = "ElvUI Norm1",
			["expHeight"] = 15,
			["normalHeight"] = 15,
			["normalWidth"] = 384,
			["expWidth"] = 180,
			["expPosition"] = {
				nil,
				"TOP",
				350,
				-350,
			},
			["normalPosition"] = {
				"RIGHT",
				"RIGHT",
				-4,
				-281,
			},
		}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_Statistics"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Plugins_Statistics"]["profiles"] or {}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_Statistics"]["profiles"]["Eltreum"] = {
			["showBar"] = true,
		}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_Proximity"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Plugins_Proximity"]["profiles"] or {}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_Proximity"]["profiles"]["Eltreum"] = {
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
		BigWigs3DB["namespaces"]["BigWigs_Plugins_Messages"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Plugins_Messages"]["profiles"] or {}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_Messages"]["profiles"]["Eltreum"] = {
			["outline"] = ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle),
			["emphFontName"] = E.db.general.font,
			["emphPosition"] = {
				nil,
				"TOP",
				nil,
				-160,
				"UIParent",
			},
			["fontName"] = E.db.general.font,
			["growUpwards"] = false,
			["emphOutline"] = ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle),
			["normalPosition"] = {
				"RIGHT",
				"RIGHT",
				"TOP",
				nil,
				-100,
				"UIParent",
				nil,
				-200,
			},
		}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_Colors"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Plugins_Colors"]["profiles"] or {}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_Colors"]["profiles"]["Eltreum"] = {
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
		BigWigs3DB["namespaces"]["BigWigs_Plugins_Wipe"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Plugins_Wipe"]["profiles"] or {}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_Wipe"]["profiles"]["Eltreum"] = {
			["wipeSound"] = "AmanThul - Wipe",
		}

		BigWigs3DB["namespaces"]["BigWigs_Plugins_Nameplates"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Plugins_Nameplates"]["profiles"] or {}
		BigWigs3DB["namespaces"]["BigWigs_Plugins_Nameplates"]["profiles"]["Eltreum"] = {
			["textFontName"] = "Kimberley",
			["iconGrowDirectionStart"] = "TOPRIGHT",
			["updated"] = true,
			["iconGlowFrequency"] = 0.3000000000000003,
			["iconOffsetY"] = 65,
			["iconSpacing"] = 2,
			["iconFontName"] = E.db.general.font,
			["textSpacing"] = 1,
			["textOutline"] = ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle),
			["iconFontSize"] = 12,
			["iconGlowPixelThickness"] = 2,
			["iconZoom"] = 0.02,
			["textOffsetY"] = 85,
			["iconOffsetX"] = -10,
			["iconHeight"] = 18,
			["iconGlowColor"] = {
				0,
				1,
				0.5960784554481506,
			},
			["iconWidth"] = 25,
		}

		if E.Retail then
			BigWigsIconDB["hide"] = true

			BigWigs3DB["namespaces"]["BigWigs_Plugins_BossBlock"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Plugins_BossBlock"]["profiles"] or {}
			BigWigs3DB["namespaces"]["BigWigs_Plugins_BossBlock"]["profiles"]["Eltreum"] = {
				["blockTalkingHeads"] = {
					true, -- [1]
					nil, -- [2]
					nil, -- [3]
					true, -- [4]
				},
			}
			BigWigs3DB["namespaces"]["BigWigs_Plugins_AltPower"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Plugins_AltPower"]["profiles"] or {}
			BigWigs3DB["namespaces"]["BigWigs_Plugins_AltPower"]["profiles"]["Eltreum"] = {
				["outline"] = ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle),
				["fontName"] = E.db.general.font,
				["barTextColor"] = {
					nil, -- [1]
					1, -- [2]
					1, -- [3]
				},
				["position"] = {
					"TOP",
					"TOP",
					-355,
					-23,
				},
				["barColor"] = {
					1, -- [1]
					0.4862745098039216, -- [2]
					0.0392156862745098, -- [3]
					1, -- [4]
				},
			}
			BigWigs3DB["namespaces"]["BigWigs_Plugins_Victory"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Plugins_Victory"]["profiles"] or {}
			BigWigs3DB["namespaces"]["BigWigs_Plugins_Victory"]["profiles"]["Eltreum"] = {
				["bigwigsMsg"] = true,
				["blizzMsg"] = false,
			}
		else
			BigWigsIconDB["hide"] = true

			BigWigs3DB["namespaces"]["BigWigs_Plugins_Victory"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Plugins_Victory"]["profiles"] or {}
			BigWigs3DB["namespaces"]["BigWigs_Plugins_Victory"]["profiles"]["Eltreum"] = {
				["bigwigsMsg"] = true,
			}
		end

		-- Set the profile
		if BigWigs3DB["profileKeys"][E.mynameRealm] then
			BigWigs3DB["profileKeys"][E.mynameRealm] = "Eltreum"
		else
			table.insert(BigWigs3DB.profileKeys, E.mynameRealm)
			BigWigs3DB["profileKeys"][E.mynameRealm] = "Eltreum"
		end
	end
end
