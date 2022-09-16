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
						["healthBarBgColor"] = {
							["a"] = 1,
						},
						["drBorderColor"] = {
							["b"] = 0.6666666666666666,
							["g"] = 0.6666666666666666,
							["r"] = 0.6666666666666666,
						},
						["buffsIconSize"] = 23,
						["drCooldownAlpha"] = 0.9,
						["shadowsightTimerX"] = 2.031761169433594,
						["racialCooldownAlpha"] = 0.9,
						["locked"] = true,
						["racialBorderStyle"] = "Interface\\AddOns\\Gladdy\\Images\\Border_Gloss",
						["barWidth"] = 220,
						["castBarBgColor"] = {
							["a"] = 0.4000000357627869,
							["b"] = 0.7372549019607844,
							["g"] = 0.7372549019607844,
							["r"] = 0.7372549019607844,
						},
						["trinketSize"] = 47,
						["healthBarBorderStyle"] = "None",
						["auraFont"] = "Kimberley",
						["ciYOffset"] = -3.99993896484375,
						["petPortraitBorderStyle"] = "Interface\\AddOns\\Gladdy\\Images\\Border_Gloss",
						["ciXOffset"] = 99.9998779296875,
						["trinketXOffset"] = 220,
						["y"] = 537.3210845994763,
						["x"] = 994.2277052363715,
						["ciBorderColor"] = {
							["b"] = 0.6666666666666666,
							["g"] = 0.6666666666666666,
							["r"] = 0.6666666666666666,
						},
						["totemPulseCooldownWidth"] = 30,
						["petYOffset"] = 21.50006103515625,
						["castBarWidth"] = 265,
						["bottomMargin"] = 50.99993896484375,
						["drFontScale"] = 0.9,
						["trinketBorderColor"] = {
							["b"] = 0.6666666666666666,
							["g"] = 0.6666666666666666,
							["r"] = 0.6666666666666666,
						},
						["classIconSpecIcon"] = true,
						["trinketFontScale"] = 1.3,
						["trinketWidthFactor"] = 1,
						["auraBuffBorderColor"] = {
							["b"] = 0.6666666666666666,
							["g"] = 0.6666666666666666,
							["r"] = 0.6666666666666666,
						},
						["castBarTexture"] = "Eltreum-Elvui-Norm",
						["petHeight"] = 19,
						["buffsBuffsCooldownGrowDirection"] = "LEFT",
						["buffsEnabled"] = false,
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
						["drFont"] = "Kimberley",
						["petHealthBarTexture"] = "Eltreum-Elvui-Norm",
						["npTremorFont"] = "Kimberley",
						["cooldownXOffset"] = 1,
						["buffsCooldownGrowDirection"] = "LEFT",
						["highlightBorderSize"] = 2,
						["cooldownFont"] = "Kimberley",
						["powerBarBgColor"] = {
							["a"] = 0.3500000238418579,
							["b"] = 0.8,
							["g"] = 0.8,
							["r"] = 0.8,
						},
						["buffsBuffsIconSize"] = 19,
						["buffsBuffsXOffset"] = -50,
						["powerPercentage"] = true,
						["healthBarFont"] = "Kimberley",
						["racialYOffset"] = 0.0001220703125,
						["ciBorderStyle"] = "Interface\\AddOns\\Gladdy\\Images\\Border_Gloss",
						["healthBarTexture"] = "Eltreum-Elvui-Norm",
						["castBarIconStyle"] = "Interface\\AddOns\\Gladdy\\Images\\Border_Gloss",
						["npTotemPlatesAlphaAlways"] = true,
						["cooldownFontScale"] = 0.6,
						["petHealthBarFont"] = "Kimberley",
						["racialSize"] = 47,
						["castBarBorderSize"] = 4,
						["petEnabled"] = false,
						["powerBarBorderStyle"] = "None",
						["drXOffset"] = -78.9998779296875,
						["trinketCooldownAlpha"] = 0.9,
						["castBarXOffset"] = -25.9998779296875,
						["castBarIconSize"] = 20,
						["buffsBuffsYOffset"] = -56.5,
						["classIconBorderColor"] = {
							["b"] = 0.6666666666666666,
							["g"] = 0.6666666666666666,
							["r"] = 0.6666666666666666,
						},
						["cooldownYOffset"] = 28.4000244140625,
						["auraBorderStyle"] = "Interface\\AddOns\\Gladdy\\Images\\Border_Gloss",
						["classIconSize"] = 48,
						["classIconWidthFactor"] = 1,
						["castBarColor"] = {
							["g"] = 0.8980392156862745,
							["b"] = 0.4274509803921568,
						},
						["castBarIconColor"] = {
							["b"] = 0.6666666666666666,
							["g"] = 0.6666666666666666,
							["r"] = 0.6666666666666666,
						},
						["classIconXOffset"] = -48,
						["leaderBorder"] = false,
						["castBarBorderStyle"] = "None",
						["cooldownMaxIconsPerLine"] = 14,
						["buffsBorderStyle"] = "Interface\\AddOns\\Gladdy\\Images\\Border_Gloss",
						["powerBarHeight"] = 16,
						["trinketBorderStyle"] = "Interface\\AddOns\\Gladdy\\Images\\Border_Gloss",
						["announcements"] = {
							["trinketUsed"] = false,
							["spec"] = false,
						},
						["shadowsightTimerY"] = 14.73023414611816,
						["highlightInset"] = true,
						["petHealthBarBorderStyle"] = "None",
						["auraDebuffBorderColor"] = {
							["b"] = 0.6666666666666666,
							["g"] = 0.6666666666666666,
							["r"] = 0.6666666666666666,
						},
						["cooldownCooldownAlpha"] = 0.9,
						["newLayout"] = true,
						["racialFont"] = "Kimberley",
						["healthBarHeight"] = 30,
						["totemPulseTextFont"] = "Kimberley",
						["drYOffset"] = -0.5,
						["buffsYOffset"] = -32.50006103515625,
						["petHealthBarBorderSize"] = 6,
						["powerBarTexture"] = "Eltreum-Elvui-Norm",
						["drIconSize"] = 31,
						["racialWidthFactor"] = 1,
						["healthBarBorderSize"] = 0.5,
						["npTotemPlatesBorderStyle"] = "Interface\\AddOns\\Gladdy\\Images\\Border_squared_blp",
						["buffsFont"] = "Kimberley",
						["racialXOffset"] = 267,
						["petXOffset"] = -18,
						["racialBorderColor"] = {
							["b"] = 0.6666666666666666,
							["g"] = 0.6666666666666666,
							["r"] = 0.6666666666666666,
						},
						["buffsFontScale"] = 0.7000000000000001,
						["buffsCooldownAlpha"] = 0.9,
						["totemPulseBarTexture"] = "ElvUI Norm1",
						["cooldownBorderColor"] = {
							["b"] = 0.6666666666666666,
							["g"] = 0.6666666666666666,
							["r"] = 0.6666666666666666,
						},
						["castBarYOffset"] = -48,
						["totemPulseCooldownHeight"] = 30,
						["powerBarFont"] = "Kimberley",
						["buffsXOffset"] = -50,
						["auraCooldownAlpha"] = 0.9,
						["castBarFont"] = "Kimberley",
						["totemPulseBarHeight"] = 30,
						["buffsBorderColor"] = {
							["b"] = 0.6666666666666666,
							["g"] = 0.6666666666666666,
							["r"] = 0.6666666666666666,
						},
						["npTotemsShowFriendly"] = false,
						["powerBarBorderSize"] = 1,
						["totemPulseBarWidth"] = 30,
						["petWidth"] = 100,
						["cooldownSize"] = 26,
						["trinketFont"] = "Kimberley",
						["classIconBorderStyle"] = "Interface\\AddOns\\Gladdy\\Images\\Border_Gloss",
						["healthActual"] = true,
						["cooldown"] = false,
						["drGrowDirection"] = "LEFT",
					},
				},
			}
		end
	end
end
