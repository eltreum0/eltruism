local E, L, V, P, G = unpack(ElvUI)
local _G = _G
local table = _G.table

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
							["castBarWidth"] = 221.6,
							["castBarAttachMode"] = "Widget",
							["castBarPosition"] = "BOTTOMLEFT",
							["castBarOffsetY"] = -15,
							["castBarHeight"] = 15,
							["castTimeTextOffsetX"] = -2,
							["castTextAlign"] = "LEFT",
							["castTimeTextAlign"] = "RIGHT",
							["castBarBackgroundColor"] = {
								["a"] = 1,
								["r"] = 0,
								["g"] = 0,
								["b"] = 0,
							},
							["castBarOffsetX"] = 0,
							["castIconPosition"] = "LEFT",
							["castTextOffsetX"] = 15,
							["castBarAnchor"] = "BOTTOMLEFT",
						},
					},
				},
				["Highlight"] = {
				},
				["LibDualSpec-1.0"] = {
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
					["profiles"] = {
						["Eltreum"] = {
							["classIconPosition"] = "LEFT",
						},
					},
				},
				["party_Highlight"] = {
				},
				["party_DRTracker"] = {
					["profiles"] = {
						["Eltreum"] = {
							["drTrackerOffsetX"] = 0,
							["drTrackerSize"] = 40,
							["drTrackerMargin"] = 0,
							["drTrackerAttachTo"] = "Frame",
						},
					},
				},
				["DRTracker"] = {
					["profiles"] = {
						["Eltreum"] = {
							["drTrackerOffsetX"] = -1,
							["drTrackerSize"] = 40,
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
							["OffsetX"] = 0,
							["IconSize"] = 15,
							["Margin"] = 0,
							["MaxIcons"] = 5,
							["BackgroundColor"] = {
								["a"] = 1,
							},
						},
					},
				},
				["party_TargetBar"] = {
					["profiles"] = {
						["Eltreum"] = {
							["Height"] = 15,
							["Width"] = 221.6,
							["IconPosition"] = "LEFT",
							["RelativePoint"] = "TOPLEFT",
							["Anchor"] = "BOTTOMLEFT",
							["BackgroundColor"] = {
								["a"] = 1,
								["r"] = 0,
								["g"] = 0,
								["b"] = 0,
							},
						},
					},
				},
				["Cooldowns"] = {
					["profiles"] = {
						["Eltreum"] = {
							["groups"] = {
								["group_2"] = {
									["cooldownsPerColumn"] = 1,
									["cooldownsMax"] = 1,
									["cooldownsGrow"] = "UPLEFT",
									["cooldownsTooltips"] = true,
									["cooldownsOffsetX"] = 0,
								},
								["group_1"] = {
									["cooldownsOffsetY"] = -13,
									["cooldownsBorderSize"] = 1,
									["cooldownsSpacingY"] = 5,
									["cooldownsSpacingX"] = 1,
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
							["margin"] = 10,
							["y"] = {
								["arena2"] = 432.4890295696787,
								["arena4"] = 324.9545051000314,
								["anchor_arena"] = 429,
								["arena5"] = 216.4544836987843,
								["arena3"] = 358.5334505219453,
								["arena1"] = 506.4445869160227,
							},
							["x"] = {
								["arena2"] = 1140.156711635973,
								["arena4"] = 1079.718426693216,
								["anchor_arena"] = 1108,
								["arena5"] = 1079.718426693216,
								["arena3"] = 1140.156711635973,
								["arena1"] = 1140.156711635973,
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
							["castBarWidth"] = 221.6,
							["castBarOffsetY"] = -15,
							["castBarHeight"] = 15,
							["castBarBackgroundColor"] = {
								["a"] = 1,
								["r"] = 0,
								["g"] = 0,
								["b"] = 0,
							},
							["castBarOffsetX"] = 0,
							["castTextOffsetX"] = 15,
							["castBarAnchor"] = "BOTTOMLEFT",
						},
					},
				},
				["party"] = {
					["profiles"] = {
						["Eltreum"] = {
							["backdropColor"] = {
								["a"] = 1,
							},
							["deadAlpha"] = 0.1,
							["modules"] = {
								["TargetBar"] = true,
							},
							["margin"] = 10,
							["y"] = {
								["anchor_arena"] = 429,
								["arena4"] = 324.9545051000314,
								["arena3"] = 324.9545051000314,
								["player"] = 509.2890314293436,
								["arena2"] = 433.4544752317452,
								["party2"] = 359.9556727786057,
								["anchor_party"] = 429,
								["party1"] = 434.6223629546694,
								["arena5"] = 216.4544836987843,
								["arena1"] = 541.9543940939257,
							},
							["x"] = {
								["anchor_arena"] = 1108,
								["arena1"] = 1079.718426693216,
								["arena3"] = 1079.718426693216,
								["player"] = 39.51109307913271,
								["arena2"] = 1079.718426693216,
								["party1"] = 39.51109307913271,
								["anchor_party"] = 16,
								["party2"] = 39.51109307913271,
								["arena5"] = 1079.718426693216,
								["arena4"] = 1079.718426693216,
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
							["OffsetX"] = 0,
							["RelativePoint"] = "BOTTOMLEFT",
							["IconSize"] = 15,
							["BackgroundColor"] = {
								["a"] = 1,
							},
							["AttachTo"] = "DRTracker",
							["MaxIcons"] = 5,
							["OffsetY"] = -8,
							["Margin"] = 0,
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
							["health"] = false,
							["spec"] = false,
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
									["cooldownsMax"] = 1,
									["cooldownsGrow"] = "UPRIGHT",
									["cooldownsTooltips"] = true,
									["cooldownsPerColumn"] = 1,
								},
								["group_1"] = {
									["cooldownsLocked"] = true,
									["cooldownsBorderSize"] = 1,
									["cooldownsPerColumn"] = 20,
									["cooldownsGroupByUnit"] = true,
									["cooldownsAttachTo"] = "CastBar",
									["cooldownsAnchor"] = "BOTTOMLEFT",
									["cooldownsSpacingY"] = 5,
									["cooldownsSpacingX"] = 1,
									["cooldownsOffsetY"] = -23,
									["cooldownsRelativePoint"] = "BOTTOMLEFT",
									["cooldownsGrow"] = "DOWNRIGHT",
									["cooldownsMax"] = 20,
								},
							},
						},
					},
				},
				["party_Clicks"] = {
					["profiles"] = {
						["Eltreum"] = {
							["clickAttributes"] = {
								["Left"] = {
									["button"] = "1",
									["macro"] = "",
									["action"] = "target",
								},
								["Right"] = {
									["button"] = "2",
									["macro"] = "",
									["action"] = "focus",
								},
							},
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
				["party_Interrupts"] = {
				},
				["Alerts"] = {
				},
				["TargetBar"] = {
					["profiles"] = {
						["Eltreum"] = {
							["Height"] = 15,
							["Width"] = 221.6,
							["BackgroundColor"] = {
								["a"] = 1,
								["r"] = 0,
								["g"] = 0,
								["b"] = 0,
							},
						},
					},
				},
				["party_Tags"] = {
					["profiles"] = {
						["Eltreum"] = {
							["tagsTexts"] = {
								["PowerBar Left Text"] = {
									["text"] = "[spec] [class]",
									["offsetX"] = 1,
									["offsetY"] = 0,
								},
							},
						},
					},
				},
				["party_Auras"] = {
					["profiles"] = {
						["Eltreum"] = {
							["aurasBuffs"] = false,
							["aurasDebuffsGrow"] = "UPLEFT",
							["aurasBuffsSize"] = 15,
							["aurasBuffsRelativePoint"] = "TOPLEFT",
							["aurasDebuffsRelativePoint"] = "TOPRIGHT",
							["aurasBuffsOffsetY"] = 59,
							["aurasBuffsGrow"] = "UPRIGHT",
							["aurasDebuffsAnchor"] = "BOTTOMRIGHT",
							["aurasDebuffs"] = false,
							["aurasBuffsOnlyDispellable"] = true,
							["aurasBuffsMaxRows"] = 1,
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
					["globalBarTexture"] = "ElvUI Norm1",
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
