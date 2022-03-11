local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

-- GladiusEx profile setup
function ElvUI_EltreumUI:GetGladiusExProfile()
	if GladiusExDB.profiles.Eltreum then
		--local key = {[E.mynameRealm] = "Eltreum"}
		--table.insert(DynamicCamDB.profileKeys, key)
		table.insert(GladiusExDB.profileKeys, E.mynameRealm)
		GladiusExDB["profileKeys"][E.mynameRealm] = "Eltreum"
	else
		GladiusExDB = {
			["namespaces"] = {
				["party_CastBar"] = {
					["profiles"] = {
						["Eltreum"] = {
							["castBarHeight"] = 15,
							["castTimeTextOffsetX"] = -2,
							["castBarBackgroundHideWhenNotCasting"] = true,
							["castTextAlign"] = "LEFT",
							["castTextOffsetX"] = 15,
							["castIconPosition"] = "LEFT",
							["castTimeTextAlign"] = "RIGHT",
							["castBarBackgroundColor"] = {
								["a"] = 1,
								["r"] = 0,
								["g"] = 0,
								["b"] = 0,
							},
							["castBarRelativePoint"] = "TOPLEFT",
						},
					},
				},
				["Highlight"] = {
				},
				["LibDualSpec-1.0"] = {
					["char"] = {
						["Eltreum"] = {
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
								["r"] = 0,
								["g"] = 0,
								["b"] = 0,
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
					["profiles"] = {
						["Eltreum"] = {
							["drTrackerAdjustSize"] = true,
						},
					},
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
							["IconSize"] = 15,
							["MaxIcons"] = 5,
							["OffsetX"] = -1,
							["BackgroundColor"] = {
								["a"] = 1,
							},
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
									["cooldownsOffsetY"] = -14,
									["cooldownsBorderSize"] = 1,
									["cooldownsSpacingY"] = 5,
									["cooldownsSpacingX"] = 1,
									["cooldownsSpells"] = {
										[205032] = false,
										[1776] = true,
										[108968] = true,
										[204331] = true,
										[236077] = true,
										[51690] = true,
										[207399] = true,
										[235313] = true,
										[207017] = false,
										[61336] = true,
										[236273] = true,
										[213981] = true,
										[204336] = true,
										[212640] = true,
										[206572] = true,
										[198013] = true,
										[31850] = true,
										[204018] = true,
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
										[356567] = true,
										[191634] = true,
										[205495] = true,
										[336128] = false,
										[262161] = true,
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
										[5384] = true,
										[64901] = true,
										[228049] = true,
										[110959] = true,
										[28730] = true,
										[33395] = true,
										[91797] = true,
										[199754] = true,
										[62618] = true,
										[213871] = true,
										[31884] = true,
										[198158] = true,
										[115080] = true,
										[255647] = true,
										[408] = true,
										[207167] = true,
										[1122] = true,
										[31661] = true,
										[12042] = true,
										[201996] = true,
										[198100] = true,
										[48743] = false,
										[86659] = true,
										[152175] = true,
										[345231] = true,
										[51490] = false,
										[255654] = true,
										[212283] = true,
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
										[204437] = true,
										[198817] = true,
										[205629] = true,
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
										[193223] = true,
										[109248] = true,
										[58984] = true,
										[118000] = true,
										[261947] = true,
										[91802] = true,
										[260364] = true,
										[68992] = true,
										[267217] = true,
										[740] = true,
										[102543] = true,
										[202914] = true,
										[194223] = true,
										[33891] = true,
										[115989] = true,
										[47482] = true,
										[66] = true,
										[106951] = true,
										[107079] = true,
										[59544] = true,
										[187650] = true,
										[32375] = true,
										[236320] = true,
										[113858] = true,
										[192058] = true,
										[195457] = true,
										[205025] = true,
										[59752] = true,
										[36554] = true,
										[323436] = true,
										[47568] = true,
										[102560] = true,
										[288853] = true,
										[119996] = true,
										[256948] = true,
										[11426] = true,
										[137639] = true,
										[97462] = true,
										[113724] = true,
										[108199] = true,
										[190784] = true,
										[265187] = true,
										[153561] = true,
										[255937] = true,
										[212619] = true,
										[3411] = true,
										[102558] = true,
										[20594] = true,
										[6940] = true,
										[207684] = true,
										[198529] = true,
										[498] = true,
									},
									["cooldownsMax"] = 20,
									["cooldownsPerColumn"] = 20,
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
							["deadAlpha"] = 0.1,
							["modules"] = {
								["TargetBar"] = true,
							},
							["y"] = {
								["arena2"] = 433.4544752317452,
								["arena4"] = 324.9545051000314,
								["anchor_arena"] = 413.6444402648776,
								["arena5"] = 216.4544836987843,
								["arena3"] = 324.9545051000314,
								["arena1"] = 541.9543940939257,
							},
							["x"] = {
								["arena2"] = 1079.718426693216,
								["arena4"] = 1079.718426693216,
								["anchor_arena"] = 1003.978560402335,
								["arena5"] = 1079.718426693216,
								["arena3"] = 1079.718426693216,
								["arena1"] = 1079.718426693216,
							},
							["backgroundPadding"] = 0,
							["frameScale"] = 1.2,
							["borderSize"] = 1,
							["barWidth"] = 180,
						},
					},
				},
				["Auras"] = {
					["profiles"] = {
						["Eltreum"] = {
							["aurasBuffs"] = false,
							["aurasBuffsSize"] = 15,
							["aurasBuffsOffsetY"] = 59,
							["aurasDebuffs"] = false,
							["aurasBuffsOnlyDispellable"] = true,
							["aurasBuffsMaxRows"] = 1,
						},
					},
				},
				["CastBar"] = {
					["profiles"] = {
						["Eltreum"] = {
							["castBarOffsetX"] = 0,
							["castBarWidth"] = 225,
							["castBarAnchor"] = "BOTTOMLEFT",
							["castTextOffsetX"] = 15,
							["castBarHeight"] = 15,
							["castBarOffsetY"] = -15,
							["castBarBackgroundColor"] = {
								["a"] = 1,
								["r"] = 0,
								["g"] = 0,
								["b"] = 0,
							},
							["castBarBackgroundHideWhenNotCasting"] = true,
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
								["party3"] = 361.9329379659066,
								["anchor_party"] = 366.7108274951861,
								["player"] = 536.6531243520221,
								["arena2"] = 438.4333543499306,
								["party4"] = 274.5728319554655,
								["party2"] = 361.9329379659066,
								["party1"] = 449.2930696111143,
								["arena3"] = 362.8333556373909,
								["arena1"] = 514.0334385116876,
							},
							["x"] = {
								["anchor_arena"] = 817.3122785617234,
								["party3"] = 100.1866858047915,
								["anchor_party"] = 24.68894382393455,
								["player"] = 100.1866858047915,
								["arena2"] = 878.2121920753852,
								["party4"] = 100.1866858047915,
								["party2"] = 100.1866858047915,
								["party1"] = 100.1866858047915,
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
								["r"] = 0,
								["g"] = 0,
								["b"] = 0,
							},
						},
					},
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
				["PetBar"] = {
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
										[110959] = true,
										[31661] = true,
										[12472] = true,
										[6262] = true,
										[198144] = true,
										[86949] = true,
										[153561] = true,
										[336126] = false,
										[336128] = false,
										[336135] = true,
										[198158] = true,
										[12042] = true,
										[190319] = true,
										[205025] = true,
									},
									["cooldownsAnchor"] = "TOPLEFT",
									["cooldownsGrow"] = "DOWNRIGHT",
									["cooldownsRelativePoint"] = "BOTTOMLEFT",
								},
							},
						},
					},
				},
				["party_Clicks"] = {
				},
				["party_Interrupts"] = {
				},
				["Announcements"] = {
					["profiles"] = {
						["Eltreum"] = {
							["health"] = false,
							["spec"] = false,
						},
					},
				},
				["Alerts"] = {
				},
				["TargetBar"] = {
					["profiles"] = {
						["Eltreum"] = {
							["Height"] = 15,
							["BackgroundColor"] = {
								["a"] = 1,
								["r"] = 0,
								["g"] = 0,
								["b"] = 0,
							},
							["Width"] = 222,
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
				["Clicks"] = {
				},
				["ClassIcon"] = {
				},
			},
			["profileKeys"] = {
				[E.mynameRealm] = "Eltreum",
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
end
