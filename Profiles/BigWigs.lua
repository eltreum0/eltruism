local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

local LoadAddOn = LoadAddOn

-- BigWigs profile setup
function ElvUI_EltreumUI:GetBigWigsProfile()
	LoadAddOn("BigWigs")
	LoadAddOn("BigWigs_Options")

	if ElvUI_EltreumUI.Retail then
		BigWigs3DB = {
			["global"] = {
				["watchedMovies"] = {
				},
			},
			["namespaces"] = {
				["BigWigs_Plugins_Victory"] = {
					["profiles"] = {
						["Eltreum"] = {
							["bigwigsMsg"] = true,
							["blizzMsg"] = false,
						},
					},
				},
				["BigWigs_Bosses_Sun King's Salvation"] = {
					["profiles"] = {
						["Eltreum"] = {
							["custom_off_-21952"] = true,
							[325877] = 3130103,
							["custom_off_-22090"] = true,
							["custom_off_-22232"] = true,
						},
					},
				},
				["BigWigs_Plugins_Alt Power"] = {
				},
				["LibDualSpec-1.0"] = {
				},
				["BigWigs_Bosses_Artificer Xy'mox"] = {
					["profiles"] = {
						["Eltreum"] = {
							[329107] = 3130103,
							["custom_off_328437"] = true,
							[328789] = 3130103,
						},
					},
				},
				["BigWigs_Bosses_Mortanis"] = {
				},
				["BigWigs_Plugins_Sounds"] = {
				},
				["BigWigs_Bosses_N'Zoth, the Corruptor"] = {
					["profiles"] = {
					},
				},
				["BigWigs_Bosses_Lady Inerva Darkvein"] = {
					["profiles"] = {
						["Eltreum"] = {
							[331550] = 3064567,
							["custom_off_324983"] = true,
							["custom_off_332664"] = true,
						},
					},
				},
				["BigWigs_Plugins_AutoReply"] = {
					["profiles"] = {
						["Eltreum"] = {
							["disabled"] = false,
							["exitCombat"] = 4,
							["mode"] = 4,
						},
					},
				},
				["BigWigs_Bosses_Hungering Destroyer"] = {
					["profiles"] = {
						["Eltreum"] = {
							["custom_off_329298"] = true,
							["custom_off_334266"] = true,
							[334266] = 4178167,
						},
					},
				},
				["BigWigs_Bosses_Shriekwing"] = {
					["profiles"] = {
						["Eltreum"] = {
							[342863] = 3129591,
							["stages"] = 3130103,
							[342074] = 4178167,
							[345936] = 3130103,
						},
					},
				},
				["BigWigs_Plugins_BossBlock"] = {
					["profiles"] = {
						["Eltreum"] = {
							["blockTalkingHeads"] = {
								true, -- [1]
								nil, -- [2]
								nil, -- [3]
								true, -- [4]
							},
						},
					},
				},
				["BigWigs_Plugins_Countdown"] = {
					["profiles"] = {
						["Eltreum"] = {
							["fontSize"] = 100,
							["fontName"] = "Kimberley",
						},
					},
				},
				["BigWigs_Plugins_AltPower"] = {
					["profiles"] = {
						["Eltreum"] = {
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
						},
					},
				},
				["BigWigs_Plugins_Raid Icons"] = {
					["profiles"] = {
					},
				},
				["BigWigs_Plugins_Colors"] = {
				},
				["BigWigs_Plugins_Wipe"] = {
					["profiles"] = {
						["Eltreum"] = {
							["wipeSound"] = "bruh",
						},
					},
				},
				["BigWigs_Plugins_InfoBox"] = {
					["profiles"] = {
						["Eltreum"] = {
							["posx"] = 1072.500811813545,
							["posy"] = 499.0887122036947,
						},
					},
				},
				["BigWigs_Plugins_Bars"] = {
					["profiles"] = {
						["Default"] = {
							["BigWigsAnchor_width"] = 220.0000610351563,
							["BigWigsEmphasizeAnchor_height"] = 21.99996376037598,
							["BigWigsAnchor_height"] = 15.99998664855957,
						},
						["Eltreum"] = {
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
						},
					},
				},
				["BigWigs_Bosses_The Council of Blood"] = {
					["profiles"] = {
						["Eltreum"] = {
							["custom_off_-22948"] = true,
							["custom_off_-22653"] = true,
							["custom_off_-22433"] = true,
						},
					},
				},
				["BigWigs_Plugins_Super Emphasize"] = {
				},
				["BigWigs_Bosses_Sire Denathrius"] = {
					["profiles"] = {
						["Eltreum"] = {
							["custom_off_332794"] = true,
							[329951] = 4178167,
							[326707] = 3130103,
							["custom_off_329951"] = true,
							[336162] = 3130103,
							["custom_off_327796"] = true,
							[327796] = 4178167,
						},
					},
				},
				["BigWigs_Plugins_Proximity"] = {
					["profiles"] = {
						["Eltreum"] = {
							["fontSize"] = 16,
							["fontName"] = "Kimberley",
							["width"] = 135.2697906494141,
							["objects"] = {
								["background"] = false,
							},
							["posy"] = 590,
							["height"] = 93.07933044433594,
							["posx"] = 1080,
						},
					},
				},
				["BigWigs_Bosses_Sludgefist"] = {
					["profiles"] = {
						["Eltreum"] = {
							[331314] = 3130103,
						},
					},
				},
				["BigWigs_Plugins_Statistics"] = {
					["profiles"] = {
						["Eltreum"] = {
							["showBar"] = true,
						},
					},
				},
				["BigWigs_Plugins_Messages"] = {
					["profiles"] = {
						["Eltreum"] = {
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
						},
					},
				},
				["BigWigs_Bosses_Stone Legion Generals"] = {
					["profiles"] = {
						["Eltreum"] = {
							["custom_off_334765"] = true,
							[342733] = 4112631,
							[333387] = 4112631,
							["custom_off_-22761"] = true,
							[339690] = 4178167,
							[342544] = 3130103,
							["custom_off_339690"] = true,
							[344496] = 4178167,
							["custom_off_333387"] = true,
							["custom_off_-22772"] = true,
						},
					},
				},
				["BigWigs_Plugins_Pull"] = {
					["profiles"] = {
					},
				},
				["BigWigs_Bosses_Huntsman Altimor"] = {
					["profiles"] = {
						["Eltreum"] = {
							["custom_off_334757"] = true,
							["custom_off_335114"] = true,
							[334757] = 3130103,
						},
					},
				},
			},
			["profileKeys"] = {
				[E.mynameRealm] = "Eltreum",
			},
			["profiles"] = {
				["Default"] = {
				},
				["Eltreum"] = {
				},
			},
		}
		BigWigsIconDB = {
			["hide"] = true,
		}
		BigWigsStatsDB = {
		}
	end

	if ElvUI_EltreumUI.Classic then
		BigWigsClassicDB = {
			["namespaces"] = {
				["BigWigs_Plugins_Victory"] = {
					["profiles"] = {
						["Default"] = {
							["bigwigsMsg"] = true,
							["soundName"] = "BigWigs: Victory Classic",
						},
					},
				},
				["BigWigs_Plugins_Colors"] = {
				},
				["BigWigs_Plugins_Raid Icons"] = {
				},
				["BigWigs_Plugins_BossBlock"] = {
				},
				["BigWigs_Plugins_Bars"] = {
					["profiles"] = {
						["Default"] = {
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
						},
					},
				},
				["BigWigs_Plugins_Wipe"] = {
					["profiles"] = {
						["Default"] = {
							["wipeSound"] = "We are too late",
						},
					},
				},
				["BigWigs_Plugins_Super Emphasize"] = {
				},
				["BigWigs_Plugins_Sounds"] = {
				},
				["BigWigs_Plugins_InfoBox"] = {
					["profiles"] = {
						["Default"] = {
							["posx"] = 945.566939463497,
							["posy"] = 110.822176762612,
						},
					},
				},
				["BigWigs_Plugins_Messages"] = {
					["profiles"] = {
						["Default"] = {
							["emphPosition"] = {
								"TOP", -- [1]
								"TOP", -- [2]
								nil, -- [3]
								-31, -- [4]
							},
							["normalPosition"] = {
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								-188, -- [4]
							},
							["emphFontName"] = "Kimberley",
							["fontName"] = "Kimberley",
							["growUpwards"] = false,
						},
					},
				},
				["BigWigs_Plugins_AutoReply"] = {
					["profiles"] = {
						["Default"] = {
							["disabled"] = false,
							["mode"] = 3,
						},
					},
				},
				["BigWigs_Plugins_Proximity"] = {
					["profiles"] = {
						["Default"] = {
							["posx"] = 1080,
							["posy"] = 650,
							["fontName"] = "Kimberley",
							["width"] = 139.999984741211,
						},
					},
				},
				["BigWigs_Plugins_Statistics"] = {
					["profiles"] = {
						["Default"] = {
							["showBar"] = true,
						},
					},
				},
				["BigWigs_Plugins_Pull"] = {
				},
				["BigWigs_Plugins_Countdown"] = {
				},
			},
			["profileKeys"] = {
				["Eltruism - Faerlina"] = "Default",
			},
			["profiles"] = {
				["Default"] = {
				},
			},
		}
		BigWigsIconClassicDB = {
			["hide"] = true,
		}
		BigWigsStatsClassicDB = {
		}
		BigWigs3DB = {
			["namespaces"] = {
				["BigWigs_Plugins_Victory"] = {
					["profiles"] = {
						["Eltreum"] = {
							["bigwigsMsg"] = true,
							["blizzMsg"] = false,
						},
					},
				},
				["BigWigs_Bosses_Sun King's Salvation"] = {
					["profiles"] = {
						["Eltreum"] = {
							["custom_off_-22232"] = true,
							["custom_off_-21952"] = true,
							[325877] = 3130103,
							["custom_off_-22090"] = true,
						},
					},
				},
				["BigWigs_Plugins_Alt Power"] = {
				},
				["LibDualSpec-1.0"] = {
				},
				["BigWigs_Bosses_Artificer Xy'mox"] = {
					["profiles"] = {
						["Eltreum"] = {
							[329107] = 3130103,
							["custom_off_328437"] = true,
							[328789] = 3130103,
						},
					},
				},
				["BigWigs_Plugins_BossBlock"] = {
					["profiles"] = {
						["Eltreum"] = {
							["blockTalkingHeads"] = {
								true, -- [1]
								nil, -- [2]
								nil, -- [3]
								true, -- [4]
							},
						},
					},
				},
				["BigWigs_Plugins_Sounds"] = {
				},
				["BigWigs_Bosses_N'Zoth, the Corruptor"] = {
					["profiles"] = {
					},
				},
				["BigWigs_Bosses_Lady Inerva Darkvein"] = {
					["profiles"] = {
						["Eltreum"] = {
							[331550] = 3064567,
							["custom_off_324983"] = true,
							["custom_off_332664"] = true,
						},
					},
				},
				["BigWigs_Plugins_AutoReply"] = {
					["profiles"] = {
						["Eltreum"] = {
							["exitCombat"] = 4,
							["mode"] = 4,
							["disabled"] = false,
						},
					},
				},
				["BigWigs_Bosses_Hungering Destroyer"] = {
					["profiles"] = {
						["Eltreum"] = {
							["custom_off_334266"] = true,
							[334266] = 4178167,
							["custom_off_329298"] = true,
						},
					},
				},
				["BigWigs_Bosses_Shriekwing"] = {
					["profiles"] = {
						["Eltreum"] = {
							[342074] = 4178167,
							[342863] = 3129591,
							[345936] = 3130103,
							["stages"] = 3130103,
						},
					},
				},
				["BigWigs_Bosses_Mortanis"] = {
				},
				["BigWigs_Plugins_Countdown"] = {
					["profiles"] = {
						["Eltreum"] = {
							["fontName"] = "Kimberley",
							["fontSize"] = 100,
						},
					},
				},
				["BigWigs_Plugins_AltPower"] = {
					["profiles"] = {
						["Eltreum"] = {
							["outline"] = "OUTLINE",
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
							["fontName"] = "Kimberley",
							["barColor"] = {
								1, -- [1]
								0.486274509803922, -- [2]
								0.0392156862745098, -- [3]
								1, -- [4]
							},
						},
					},
				},
				["BigWigs_Plugins_Wipe"] = {
					["profiles"] = {
						["Eltreum"] = {
							["wipeSound"] = "bruh",
						},
					},
				},
				["BigWigs_Plugins_Colors"] = {
				},
				["BigWigs_Plugins_Raid Icons"] = {
					["profiles"] = {
					},
				},
				["BigWigs_Plugins_InfoBox"] = {
					["profiles"] = {
						["Eltreum"] = {
							["posx"] = 1072.50081181355,
							["posy"] = 499.088712203695,
						},
					},
				},
				["BigWigs_Plugins_Bars"] = {
					["profiles"] = {
						["Default"] = {
							["BigWigsAnchor_width"] = 220.000061035156,
							["BigWigsEmphasizeAnchor_height"] = 21.999963760376,
							["BigWigsAnchor_height"] = 15.9999866485596,
						},
						["Eltreum"] = {
							["BigWigsEmphasizeAnchor_y"] = 541.466653376534,
							["visibleBarLimit"] = 15,
							["BigWigsAnchor_width"] = 382.000030517578,
							["BigWigsAnchor_y"] = 151,
							["emphasizeGrowup"] = true,
							["BigWigsAnchor_x"] = 1096,
							["spacing"] = 14,
							["emphasizeTime"] = 10,
							["barStyle"] = "AddOnSkins Half-Bar",
							["BigWigsEmphasizeAnchor_height"] = 11.0000162124634,
							["growup"] = true,
							["BigWigsEmphasizeAnchor_width"] = 180,
							["fontName"] = "Kimberley",
							["BigWigsAnchor_height"] = 9.99999141693115,
							["visibleBarLimitEmph"] = 6,
							["outline"] = "OUTLINE",
							["BigWigsEmphasizeAnchor_x"] = 928.222628235431,
							["texture"] = "Eltreum-Blank",
						},
					},
				},
				["BigWigs_Bosses_Stone Legion Generals"] = {
					["profiles"] = {
						["Eltreum"] = {
							["custom_off_334765"] = true,
							[339690] = 4178167,
							[342544] = 3130103,
							[333387] = 4112631,
							["custom_off_339690"] = true,
							["custom_off_-22761"] = true,
							[342733] = 4112631,
							["custom_off_333387"] = true,
							[344496] = 4178167,
							["custom_off_-22772"] = true,
						},
					},
				},
				["BigWigs_Plugins_Super Emphasize"] = {
				},
				["BigWigs_Plugins_Proximity"] = {
					["profiles"] = {
						["Eltreum"] = {
							["objects"] = {
								["background"] = false,
							},
							["fontSize"] = 16,
							["posx"] = 1080,
							["height"] = 93.079330444336,
							["posy"] = 590,
							["fontName"] = "Kimberley",
							["width"] = 135.269790649414,
						},
					},
				},
				["BigWigs_Bosses_Sludgefist"] = {
					["profiles"] = {
						["Eltreum"] = {
							[331314] = 3130103,
						},
					},
				},
				["BigWigs_Bosses_Sire Denathrius"] = {
					["profiles"] = {
						["Eltreum"] = {
							[326707] = 3130103,
							["custom_off_332794"] = true,
							[327796] = 4178167,
							["custom_off_327796"] = true,
							[329951] = 4178167,
							[336162] = 3130103,
							["custom_off_329951"] = true,
						},
					},
				},
				["BigWigs_Plugins_Statistics"] = {
					["profiles"] = {
						["Eltreum"] = {
							["showBar"] = true,
						},
					},
				},
				["BigWigs_Plugins_Messages"] = {
					["profiles"] = {
						["Eltreum"] = {
							["emphPosition"] = {
								"TOP", -- [1]
								"TOP", -- [2]
								nil, -- [3]
								-160, -- [4]
							},
							["emphFontName"] = "Kimberley",
							["fontName"] = "Kimberley",
							["normalPosition"] = {
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								-100, -- [4]
							},
						},
					},
				},
				["BigWigs_Bosses_The Council of Blood"] = {
					["profiles"] = {
						["Eltreum"] = {
							["custom_off_-22948"] = true,
							["custom_off_-22653"] = true,
							["custom_off_-22433"] = true,
						},
					},
				},
				["BigWigs_Plugins_Pull"] = {
					["profiles"] = {
					},
				},
				["BigWigs_Bosses_Huntsman Altimor"] = {
					["profiles"] = {
						["Eltreum"] = {
							[334757] = 3130103,
							["custom_off_335114"] = true,
							["custom_off_334757"] = true,
						},
					},
				},
			},
			["global"] = {
				["watchedMovies"] = {
				},
			},
			["profileKeys"] = {
				["Eltruism - Faerlina"] = "Eltreum",
			},
			["profiles"] = {
				["Default"] = {
				},
				["Eltreum"] = {
				},
			},
		}
		BigWigsIconDB = {
			["hide"] = true,
		}
		BigWigsStatsDB = {
		}
	end

end
