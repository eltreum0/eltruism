local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

-- Gladdy profile setup
function ElvUI_EltreumUI:GetGladdyProfile()
	if IsAddOnLoaded("Gladdy") then
		if GladdyXZ.profiles.Eltreum then
			--local key = {[E.mynameRealm] = "Eltreum"}
			--table.insert(GladdyXZ.profileKeys, key)
			table.insert(GladdyXZ.profileKeys, E.mynameRealm)
			GladdyXZ["profileKeys"][E.mynameRealm] = "Eltreum"
		else
			GladdyXZ = {
				["profileKeys"] = {
					[E.mynameRealm] = "Eltreum",
				},
				["profiles"] = {
					["Eltreum"] = {
						["drBorderColor"] = {
							["b"] = 0.6666666666666666,
							["g"] = 0.6666666666666666,
							["r"] = 0.6666666666666666,
						},
						["buffsIconSize"] = 23,
						["drCooldownAlpha"] = 0.9,
						["castBarBgColor"] = {
							["a"] = 0.4000000357627869,
							["b"] = 0.7372549019607844,
							["g"] = 0.7372549019607844,
							["r"] = 0.7372549019607844,
						},
						["drFontScale"] = 0.9,
						["trinketBorderColor"] = {
							["b"] = 0.6666666666666666,
							["g"] = 0.6666666666666666,
							["r"] = 0.6666666666666666,
						},
						["buffsBuffsCooldownGrowDirection"] = "LEFT",
						["npTremorFont"] = "Kimberley",
						["ciYOffset"] = -3.99993896484375,
						["ciBorderStyle"] = "Interface\\AddOns\\Gladdy\\Images\\Border_Gloss",
						["petHealthBarTexture"] = "Eltreum-Elvui-Norm",
						["npTotemPlatesAlphaAlways"] = true,
						["buffsBuffsXOffset"] = -50,
						["classIconBorderColor"] = {
							["b"] = 0.6666666666666666,
							["g"] = 0.6666666666666666,
							["r"] = 0.6666666666666666,
						},
						["powerBarHeight"] = 16,
						["racialWidthFactor"] = 1,
						["buffsBorderColor"] = {
							["b"] = 0.6666666666666666,
							["g"] = 0.6666666666666666,
							["r"] = 0.6666666666666666,
						},
						["npTotemsShowFriendly"] = false,
						["healthBarBorderStyle"] = "None",
						["healthBarBgColor"] = {
							["a"] = 1,
						},
						["cooldownFont"] = "Kimberley",
						["locked"] = true,
						["auraFont"] = "Kimberley",
						["y"] = 537.3210845994763,
						["x"] = 994.2277052363715,
						["bottomMargin"] = 50.99993896484375,
						["trinketFont"] = "Kimberley",
						["trinketFontScale"] = 1.3,
						["auraBuffBorderColor"] = {
							["b"] = 0.6666666666666666,
							["g"] = 0.6666666666666666,
							["r"] = 0.6666666666666666,
						},
						["petHeight"] = 19,
						["ciXOffset"] = 99.9998779296875,
						["buffsCooldownGrowDirection"] = "LEFT",
						["powerBarBgColor"] = {
							["a"] = 0.3500000238418579,
							["b"] = 0.8,
							["g"] = 0.8,
							["r"] = 0.8,
						},
						["castBarIconStyle"] = "Interface\\AddOns\\Gladdy\\Images\\Border_Gloss",
						["castBarColor"] = {
							["g"] = 0.8980392156862745,
							["b"] = 0.4274509803921568,
						},
						["castBarIconColor"] = {
							["b"] = 0.6666666666666666,
							["g"] = 0.6666666666666666,
							["r"] = 0.6666666666666666,
						},
						["leaderBorder"] = false,
						["cooldownCooldownAlpha"] = 0.9,
						["healthBarHeight"] = 30,
						["petHealthBarBorderSize"] = 6,
						["racialXOffset"] = 267,
						["racialBorderColor"] = {
							["b"] = 0.6666666666666666,
							["g"] = 0.6666666666666666,
							["r"] = 0.6666666666666666,
						},
						["classIconSpecIcon"] = true,
						["powerBarBorderSize"] = 1,
						["petWidth"] = 100,
						["cooldownSize"] = 26,
						["highlightInset"] = true,
						["drGrowDirection"] = "LEFT",
						["shadowsightTimerX"] = 2.031761169433594,
						["racialCooldownAlpha"] = 0.9,
						["racialBorderStyle"] = "Interface\\AddOns\\Gladdy\\Images\\Border_Gloss",
						["petHealthBarFont"] = "Kimberley",
						["trinketXOffset"] = 220,
						["ciBorderColor"] = {
							["b"] = 0.6666666666666666,
							["g"] = 0.6666666666666666,
							["r"] = 0.6666666666666666,
						},
						["newLayout"] = true,
						["castBarYOffset"] = -48,
						["buffsBuffsIconSize"] = 19,
						["petYOffset"] = 21.50006103515625,
						["cooldownFontScale"] = 0.6,
						["racialSize"] = 47,
						["powerPercentage"] = true,
						["drXOffset"] = -78.9998779296875,
						["auraBorderStyle"] = "Interface\\AddOns\\Gladdy\\Images\\Border_Gloss",
						["buffsCooldownAlpha"] = 0.9,
						["buffsBorderStyle"] = "Interface\\AddOns\\Gladdy\\Images\\Border_Gloss",
						["announcements"] = {
							["spec"] = false,
							["trinketUsed"] = false,
						},
						["racialFont"] = "Kimberley",
						["buffsYOffset"] = -32.50006103515625,
						["healthBarBorderSize"] = 0.5,
						["npTotemPlatesBorderStyle"] = "Interface\\AddOns\\Gladdy\\Images\\Border_squared_blp",
						["auraCooldownAlpha"] = 0.9,
						["petHealthBarBorderStyle"] = "None",
						["barWidth"] = 220,
						["cooldownMaxIconsPerLine"] = 14,
						["buffsEnabled"] = false,
						["buffsFont"] = "Kimberley",
						["buffsBuffsYOffset"] = -56.5,
						["castBarTexture"] = "Eltreum-Elvui-Norm",
						["classIconWidthFactor"] = 1,
						["petXOffset"] = -18,
						["castBarIconSize"] = 20,
						["drFont"] = "Kimberley",
						["cooldownXOffset"] = 1,
						["highlightBorderSize"] = 2,
						["healthBarFont"] = "Kimberley",
						["buffsFontScale"] = 0.7000000000000001,
						["petEnabled"] = false,
						["powerBarBorderStyle"] = "None",
						["castBarBorderSize"] = 4,
						["trinketCooldownAlpha"] = 0.9,
						["classIconSize"] = 48,
						["cooldownBorderColor"] = {
							["b"] = 0.6666666666666666,
							["g"] = 0.6666666666666666,
							["r"] = 0.6666666666666666,
						},
						["castBarXOffset"] = -25.9998779296875,
						["healthBarTexture"] = "Eltreum-Elvui-Norm",
						["castBarBorderStyle"] = "None",
						["npTotemColors"] = {
							["totem3738"] = {
								["alpha"] = 0.4,
							},
							["totem8177"] = {
								["color"] = {
									["g"] = 0,
									["b"] = 0,
								},
								["alpha"] = 0.4,
							},
							["totem30706"] = {
								["alpha"] = 0.4,
							},
							["totem8190"] = {
								["alpha"] = 0.4,
							},
							["totem5730"] = {
								["alpha"] = 0.4,
							},
							["totem6495"] = {
								["alpha"] = 0.4,
							},
							["totem2484"] = {
								["color"] = {
									["r"] = 0,
									["g"] = 0,
									["b"] = 0,
								},
								["alpha"] = 0.4,
							},
							["totem5394"] = {
								["alpha"] = 0.4,
							},
							["totem8227"] = {
								["alpha"] = 0.4,
							},
							["totem8143"] = {
								["color"] = {
									["r"] = 0,
									["g"] = 0,
									["b"] = 0,
								},
								["alpha"] = 0.4,
							},
							["totem5675"] = {
								["alpha"] = 0.4,
							},
							["totem10595"] = {
								["alpha"] = 0.4,
							},
							["totem33663"] = {
								["alpha"] = 0.4,
							},
							["totem8181"] = {
								["alpha"] = 0.4,
							},
							["totem8170"] = {
								["alpha"] = 0.4,
							},
							["totem3599"] = {
								["alpha"] = 0.4,
							},
							["totem8512"] = {
								["color"] = {
									["r"] = 0,
									["b"] = 0,
								},
								["alpha"] = 0.4,
							},
							["totem8071"] = {
								["alpha"] = 0.4,
							},
							["totem32982"] = {
								["alpha"] = 0.4,
							},
							["totem16190"] = {
								["color"] = {
									["r"] = 0,
									["g"] = 0,
									["b"] = 0,
								},
								["alpha"] = 0.4,
							},
							["totem8075"] = {
								["alpha"] = 0.4,
							},
							["totem8184"] = {
								["alpha"] = 0.4,
							},
							["totem1535"] = {
								["alpha"] = 0.4,
							},
						},
						["shadowsightTimerY"] = 14.73023414611816,
						["auraDebuffBorderColor"] = {
							["b"] = 0.6666666666666666,
							["g"] = 0.6666666666666666,
							["r"] = 0.6666666666666666,
						},
						["castBarFont"] = "Kimberley",
						["buffsXOffset"] = -50,
						["cooldownYOffset"] = 28.4000244140625,
						["powerBarTexture"] = "Eltreum-Elvui-Norm",
						["petPortraitBorderStyle"] = "Interface\\AddOns\\Gladdy\\Images\\Border_Gloss",
						["healthActual"] = true,
						["cooldown"] = false,
						["castBarWidth"] = 265,
						["powerBarFont"] = "Kimberley",
						["drYOffset"] = -0.5,
						["trinketSize"] = 47,
						["trinketWidthFactor"] = 1,
						["drIconSize"] = 31,
						["classIconXOffset"] = -48,
						["classIconBorderStyle"] = "Interface\\AddOns\\Gladdy\\Images\\Border_Gloss",
						["trinketBorderStyle"] = "Interface\\AddOns\\Gladdy\\Images\\Border_Gloss",
						["racialYOffset"] = 0.0001220703125,
					},
				},
			}
		end
	end
end
