local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local unpack = unpack

-- Shadow&Light profile setup
function ElvUI_EltreumUI:GetGladiusExProfile()
	GladiusExDB = {
		["namespaces"] = {
			["party_CastBar"] = {
				["profiles"] = {
					["Eltreum"] = {
						["castBarHeight"] = 15,
						["castTimeTextOffsetX"] = -2,
						["castBarBackgroundHideWhenNotCasting"] = true,
						["castBarRelativePoint"] = "TOPLEFT",
						["castTextAlign"] = "LEFT",
						["castTextOffsetX"] = 15,
						["castIconPosition"] = "LEFT",
						["castTimeTextAlign"] = "RIGHT",
						["castBarBackgroundColor"] = {
							["a"] = 1,
							["b"] = 0,
							["g"] = 0,
							["r"] = 0,
						},
						["castBarAnchor"] = "TOPRIGHT",
					},
				},
			},
			["Highlight"] = {
			},
			["LibDualSpec-1.0"] = {
				["char"] = {
					["Numbered - Stormrage"] = {
						["enabled"] = false,
					},
				},
			},
			["party_Alerts"] = {
			},
			["party_HealthBar"] = {
				["profiles"] = {
					["Eltreum"] = {
						["healthBarBackgroundColor"] = {
							["a"] = 1,
							["b"] = 0,
							["g"] = 0,
							["r"] = 0,
						},
					},
				},
			},
			["party_ClassIcon"] = {
			},
			["party_Highlight"] = {
			},
			["party_DRTracker"] = {
				["profiles"] = {
					["Eltreum"] = {
						["drTrackerOffsetX"] = -2,
					},
				},
			},
			["DRTracker"] = {
			},
			["party_PowerBar"] = {
				["profiles"] = {
					["Eltreum"] = {
						["powerBarHeight"] = 5,
					},
				},
			},
			["SkillHistory"] = {
				["profiles"] = {
					["Eltreum"] = {
						["Crop"] = false,
						["OffsetX"] = -5,
						["OffsetY"] = -3,
						["BackgroundColor"] = {
							["a"] = 1,
						},
						["MaxIcons"] = 4,
					},
				},
			},
			["party_TargetBar"] = {
				["profiles"] = {
					["Eltreum"] = {
						["IconPosition"] = "LEFT",
						["Anchor"] = "BOTTOMLEFT",
						["RelativePoint"] = "TOPLEFT",
					},
				},
			},
			["Cooldowns"] = {
				["profiles"] = {
					["Eltreum"] = {
						["groups"] = {
							["group_2"] = {
								["cooldownsGrow"] = "UPLEFT",
							},
							["group_1"] = {
								["cooldownsSpells"] = {
									[205032] = false,
									[1776] = true,
									[108968] = true,
									[204331] = true,
									[236077] = true,
									[77606] = true,
									[51690] = true,
									[207399] = true,
									[235313] = true,
									[207017] = false,
									[51052] = true,
									[61336] = true,
									[236273] = true,
									[213981] = true,
									[204336] = true,
									[212640] = true,
									[206572] = true,
									[198013] = true,
									[152279] = true,
									[113858] = true,
									[199483] = true,
									[114050] = true,
									[1044] = true,
									[147362] = true,
									[190925] = true,
									[199804] = true,
									[108238] = true,
									[198144] = true,
									[114051] = true,
									[213602] = true,
									[12975] = true,
									[12472] = true,
									[227847] = true,
									[113860] = true,
									[108271] = true,
									[186265] = true,
									[6262] = true,
									[114052] = true,
									[51533] = true,
									[265221] = true,
									[235450] = true,
									[211881] = true,
									[57330] = false,
									[336126] = false,
									[107570] = true,
									[191634] = true,
									[205495] = true,
									[336128] = false,
									[260364] = true,
									[185311] = true,
									[209584] = true,
									[201664] = true,
									[212459] = true,
									[205369] = true,
									[100] = true,
									[46584] = true,
									[1850] = true,
									[205179] = true,
									[336135] = true,
									[271877] = true,
									[212653] = true,
									[205180] = true,
									[207736] = true,
									[207289] = true,
									[64901] = true,
									[228049] = true,
									[179057] = true,
									[110959] = true,
									[28730] = true,
									[33395] = true,
									[63560] = true,
									[91797] = true,
									[199754] = true,
									[62618] = true,
									[213871] = true,
									[31884] = true,
									[198158] = true,
									[115080] = true,
									[217832] = true,
									[255647] = true,
									[408] = true,
									[207167] = true,
									[279302] = true,
									[1122] = true,
									[31661] = true,
									[47481] = true,
									[12042] = true,
									[201996] = true,
									[198100] = true,
									[48743] = false,
									[86659] = true,
									[152175] = true,
									[51490] = false,
									[255654] = true,
									[207684] = true,
									[47482] = true,
									[91802] = true,
									[109304] = true,
									[116011] = false,
									[231895] = true,
									[213691] = true,
									[86949] = true,
									[46924] = true,
									[2825] = true,
									[84714] = true,
									[201430] = true,
									[20572] = true,
									[586] = true,
									[26297] = true,
									[7744] = true,
									[198111] = true,
									[190319] = true,
									[212356] = true,
									[5217] = false,
									[64044] = true,
									[123904] = true,
									[202137] = true,
									[204437] = true,
									[198817] = true,
									[55709] = true,
									[236696] = true,
									[206803] = true,
									[5277] = true,
									[20549] = true,
									[233759] = true,
									[20589] = true,
									[316262] = true,
									[197862] = true,
									[53490] = false,
									[69070] = true,
									[122278] = true,
									[187707] = true,
									[221562] = true,
									[278326] = true,
									[58984] = true,
									[118000] = true,
									[193223] = true,
									[267217] = true,
									[740] = true,
									[102543] = true,
									[68992] = true,
									[33891] = true,
									[66] = true,
									[106951] = true,
									[107079] = true,
									[202914] = true,
									[6940] = true,
									[261947] = true,
									[59544] = true,
									[187650] = true,
									[32375] = true,
									[192058] = true,
									[195457] = true,
									[205025] = true,
									[11426] = true,
									[59752] = true,
									[36554] = true,
									[102560] = true,
									[47568] = true,
									[288853] = true,
									[119996] = true,
									[205629] = true,
									[256948] = true,
									[3411] = true,
									[97462] = true,
									[137639] = true,
									[113724] = true,
									[115989] = true,
									[42650] = true,
									[108199] = true,
									[20594] = true,
									[190784] = true,
									[265187] = true,
									[262161] = true,
									[109248] = true,
									[255937] = true,
									[194223] = true,
									[212619] = true,
									[212283] = true,
									[205604] = true,
									[5384] = true,
									[102558] = true,
									[198529] = true,
									[236320] = true,
									[153561] = true,
									[498] = true,
								},
								["cooldownsMax"] = 20,
								["cooldownsSpacingY"] = 5,
								["cooldownsSpacingX"] = 1,
								["cooldownsBorderSize"] = 1,
							},
						},
					},
				},
			},
			["arena"] = {
				["profiles"] = {
					["Eltreum"] = {
						["backdropColor"] = {
							["a"] = 1,
						},
						["modules"] = {
							["TargetBar"] = true,
							["Auras"] = true,
						},
						["y"] = {
							["arena2"] = 483.061429761794,
							["arena1"] = 573.3614282239942,
							["anchor_arena"] = 376.3112606813011,
							["arena3"] = 392.7613031257679,
							["arena5"] = 212.1611139406286,
							["arena4"] = 302.4612192143504,
						},
						["x"] = {
							["arena2"] = 1181.823087783829,
							["arena1"] = 1181.823087783829,
							["anchor_arena"] = 1118.823088856712,
							["arena3"] = 1181.823087783829,
							["arena5"] = 1181.823087783829,
							["arena4"] = 1181.823087783829,
						},
						["backgroundPadding"] = 0,
						["borderSize"] = 1,
						["barWidth"] = 180,
					},
				},
			},
			["Auras"] = {
				["profiles"] = {
					["Eltreum"] = {
						["aurasBuffs"] = false,
						["aurasDebuffs"] = false,
						["aurasBuffsOnlyDispellable"] = true,
						["aurasBuffsMaxRows"] = 1,
					},
				},
			},
			["CastBar"] = {
				["profiles"] = {
					["Eltreum"] = {
						["castBarBackgroundHideWhenNotCasting"] = true,
						["castBarHeight"] = 15,
						["castBarBackgroundColor"] = {
							["a"] = 1,
							["b"] = 0,
							["g"] = 0,
							["r"] = 0,
						},
						["castTextOffsetX"] = 15,
					},
				},
			},
			["party"] = {
				["profiles"] = {
					["Eltreum"] = {
						["backdropColor"] = {
							["a"] = 1,
						},
						["modules"] = {
							["TargetBar"] = true,
						},
						["y"] = {
							["anchor_arena"] = 432.133354457219,
							["party3"] = 301.6107645169195,
							["anchor_party"] = 366.7108274951861,
							["player"] = 520.0109957829372,
							["arena2"] = 438.4333543499306,
							["party1"] = 447.2109115734966,
							["party2"] = 374.4108700886645,
							["party4"] = 228.8106803074788,
							["arena3"] = 362.8333556373909,
							["arena1"] = 514.0334385116876,
						},
						["x"] = {
							["anchor_arena"] = 817.3122785617234,
							["party3"] = 83.48890009796787,
							["anchor_party"] = 24.68894382393455,
							["player"] = 83.48890009796787,
							["arena2"] = 878.2121920753852,
							["party1"] = 83.48890009796787,
							["party2"] = 83.48890009796787,
							["party4"] = 83.48890009796787,
							["arena3"] = 878.2121920753852,
							["arena1"] = 878.2121920753852,
						},
						["backgroundPadding"] = 0,
						["borderSize"] = 1,
						["barWidth"] = 180,
					},
				},
			},
			["party_SkillHistory"] = {
				["profiles"] = {
					["Eltreum"] = {
						["MaxIcons"] = 3,
						["OffsetY"] = -10,
						["RelativePoint"] = "TOPRIGHT",
					},
				},
			},
			["PowerBar"] = {
				["profiles"] = {
					["Eltreum"] = {
						["powerBarHeight"] = 5,
					},
				},
			},
			["Interrupts"] = {
			},
			["party_Announcements"] = {
				["profiles"] = {
					["Eltreum"] = {
						["resurrect"] = false,
						["spec"] = false,
						["health"] = false,
					},
				},
			},
			["HealthBar"] = {
				["profiles"] = {
					["Eltreum"] = {
						["healthBarBackgroundColor"] = {
							["a"] = 1,
							["b"] = 0,
							["g"] = 0,
							["r"] = 0,
						},
					},
				},
			},
			["Clicks"] = {
			},
			["Tags"] = {
				["profiles"] = {
					["Eltreum"] = {
						["tagsTexts"] = {
							["PowerBar Left Text"] = {
								["offsetY"] = 0,
								["offsetX"] = 1,
								["text"] = "[spec] [class]",
							},
						},
					},
				},
			},
			["party_Cooldowns"] = {
				["profiles"] = {
					["Eltreum"] = {
						["groups"] = {
							["group_2"] = {
								["cooldownsGrow"] = "UPLEFT",
							},
							["group_1"] = {
								["cooldownsSpells"] = {
									[66] = true,
									[108199] = true,
									[221562] = true,
									[110959] = true,
									[31661] = true,
									[205025] = true,
									[12472] = true,
									[6262] = true,
									[279302] = true,
									[198144] = true,
									[77606] = true,
									[12042] = true,
									[152279] = true,
									[86949] = true,
									[153561] = true,
									[336126] = false,
									[336135] = true,
									[42650] = true,
									[336128] = false,
									[198158] = true,
									[190319] = true,
									[63560] = true,
								},
								["cooldownsAnchor"] = "TOPLEFT",
								["cooldownsRelativePoint"] = "BOTTOMLEFT",
								["cooldownsGrow"] = "DOWNRIGHT",
							},
						},
					},
				},
			},
			["party_Clicks"] = {
			},
			["party_Auras"] = {
				["profiles"] = {
					["Eltreum"] = {
						["aurasDebuffsGrow"] = "UPLEFT",
						["aurasBuffsRelativePoint"] = "TOPLEFT",
						["aurasDebuffsRelativePoint"] = "TOPRIGHT",
						["aurasBuffsGrow"] = "UPRIGHT",
						["aurasDebuffsAnchor"] = "BOTTOMRIGHT",
						["aurasBuffsOnlyDispellable"] = true,
						["aurasBuffsAnchor"] = "BOTTOMLEFT",
					},
				},
			},
			["Announcements"] = {
				["profiles"] = {
					["Eltreum"] = {
						["health"] = false,
						["spec"] = false,
					},
				},
			},
			["party_Tags"] = {
				["profiles"] = {
					["Eltreum"] = {
						["tagsTexts"] = {
							["PowerBar Left Text"] = {
								["offsetY"] = 0,
								["offsetX"] = 1,
								["text"] = "[spec] [class]",
							},
						},
					},
				},
			},
			["TargetBar"] = {
				["profiles"] = {
					["Eltreum"] = {
						["BackgroundColor"] = {
							["a"] = 1,
							["b"] = 0,
							["g"] = 0,
							["r"] = 0,
						},
					},
				},
			},
			["Alerts"] = {
			},
			["party_Interrupts"] = {
			},
			["PetBar"] = {
			},
			["party_PetBar"] = {
				["profiles"] = {
					["Eltreum"] = {
						["IconPosition"] = "RIGHT",
						["Anchor"] = "BOTTOMRIGHT",
						["RelativePoint"] = "TOPRIGHT",
					},
				},
			},
			["ClassIcon"] = {
			},
		},
		["profileKeys"] = {
		["Default - Profile"] = "Eltreum",
	},
		["profiles"] = {
			["Eltreum"] = {
				["globalFont"] = "Kimberley",
				["globalBarTexture"] = "ElvUI Blank",
				["showParty"] = false,
				["globalFontSize"] = 12,
				["superFS"] = false,
				["locked"] = true,
				["advancedOptions"] = true,
			},
		},
	}
GladiusEx.dbi:SetProfile("Eltreum")

end