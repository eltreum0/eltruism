local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

-- Capping profile setup
function ElvUI_EltreumUI:GetBattleGroundEnemiesProfile()
	if BattleGroundEnemiesDB.profiles.Eltreum then
		--local key = {[E.mynameRealm] = "Eltreum"}
		--table.insert(CappingSettings.profileKeys, key)
		table.insert(BattleGroundEnemiesDB.profileKeys, E.mynameRealm)
		BattleGroundEnemiesDB["profileKeys"][E.mynameRealm] = "Eltreum"
	else
		BattleGroundEnemiesDB = {
			["profileKeys"] = {
				[E.mynameRealm] = "Eltreum"
			},
			["profiles"] = {
				["Eltreum"] = {
					["onlyShowWhenNewVersion"] = true,
					["MyFocus_Color"] = {
						nil, -- [1]
						0, -- [2]
						0, -- [3]
					},
					["Allies"] = {
						["40"] = {
							["Position_Y"] = 610,
							["RoleIcon_VerticalPosition"] = 5,
							["Name_Outline"] = "OUTLINE",
							["Spec_AuraDisplay_Cooldown_Outline"] = "OUTLINE",
							["PowerBar_Texture"] = "ElvUI Norm",
							["Framescale"] = 0.75,
							["HealthBar_Texture"] = "ElvUI Blank",
							["HealthBar_Background"] = {
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								1, -- [4]
							},
							["NumericTargetindicator_Outline"] = "OUTLINE",
							["Auras_Enabled"] = true,
							["Position_X"] = 200,
							["Racial_Cooldown_Outline"] = "OUTLINE",
							["PowerBar_Background"] = {
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								1, -- [4]
							},
							["DrTracking_Container_Color"] = {
								[3] = 0,
							},
							["DrTracking_GrowDirection"] = "leftwards",
							["HealthBar_HealthPrediction_Enabled"] = true,
							["Trinket_Cooldown_Outline"] = "OUTLINE",
						},
						["RangeIndicator_Range"] = 34191,
						["RangeIndicator_Everything"] = true,
						["LevelText_Fontsize"] = 14,
						["ShowRealmnames"] = false,
						["15"] = {
							["Auras_Debuffs_Container_RelativeTo"] = "DRContainer",
							["Auras_Debuffs_DebuffTypeFiltering_Enabled"] = false,
							["Position_Y"] = 630,
							["Trinket_Width"] = 30,
							["BarVerticalSpacing"] = 5,
							["Auras_Debuffs_Size"] = 27,
							["PowerBar_Background"] = {
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								1, -- [4]
							},
							["RoleIcon_VerticalPosition"] = 6,
							["Racial_OffsetX"] = -1,
							["Auras_Debuffs_Container_RelativePoint"] = "LEFT",
							["ObjectiveAndRespawn_EnableTextshadow"] = true,
							["Name_Outline"] = "OUTLINE",
							["PowerBar_Texture"] = "ElvUI Blank",
							["Racial_Width"] = 30,
							["RacialFiltering_Filterlist"] = {
								[26297] = true,
								[107079] = true,
								[121093] = true,
								[50613] = true,
								[20549] = true,
								[59543] = true,
								[59544] = true,
								[68992] = true,
								[25046] = true,
								[59547] = true,
								[59548] = true,
								[202719] = true,
								[33697] = true,
								[59542] = true,
								[69070] = true,
								[155145] = true,
								[129597] = true,
								[33702] = true,
								[20572] = true,
								[59545] = true,
								[28880] = true,
								[20589] = true,
								[69179] = true,
								[7744] = true,
								[232633] = true,
								[58984] = true,
								[20594] = true,
								[59752] = true,
								[28730] = true,
								[80483] = true,
							},
							["Spec_Width"] = 30,
							["ObjectiveAndRespawn_Width"] = 30,
							["HealthBar_Texture"] = "ElvUI Blank",
							["HealthBar_Background"] = {
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								1, -- [4]
							},
							["Spec_AuraDisplay_Enabled"] = false,
							["NumericTargetindicator_Outline"] = "OUTLINE",
							["RacialFiltering_Enabled"] = true,
							["Position_X"] = 200,
							["RoleIcon_Size"] = 15,
							["DrTracking_Container_Color"] = {
								[3] = 0,
							},
							["PowerBar_Enabled"] = true,
							["PowerBar_Height"] = 6,
							["BarHeight"] = 32,
							["DrTracking_GrowDirection"] = "leftwards",
							["PlayerCount_EnableTextshadow"] = true,
							["PlayerCount_Outline"] = "OUTLINE",
							["Auras_Debuffs_Container_Point"] = "RIGHT",
							["HealthBar_HealthPrediction_Enabled"] = true,
						},
						["LevelText_Enabled"] = true,
						["RangeIndicator_Alpha"] = 0.5,
						["LevelText_Outline"] = "OUTLINE",
					},
					["Font"] = "Kimberley",
					["RBG"] = {
						["TargetCalling_SetMark"] = true,
						["EnemiesTargetingMe_Amount"] = 2,
						["EnemiesTargetingMe_Sound"] = "! - Metal Gear Solid",
						["EnemiesTargetingMe_Enabled"] = true,
					},
					["Locked"] = true,
					["lastReadVersion"] = "9.0.5.6",
					["Enemies"] = {
						["40"] = {
							["Position_Y"] = 610,
							["PlayerCount_Outline"] = "OUTLINE",
							["RoleIcon_VerticalPosition"] = 4,
							["DrTracking_Cooldown_Outline"] = "OUTLINE",
							["Name_Outline"] = "OUTLINE",
							["Spec_AuraDisplay_Cooldown_Outline"] = "OUTLINE",
							["PowerBar_Texture"] = "ElvUI Norm",
							["Framescale"] = 0.75,
							["HealthBar_Texture"] = "ElvUI Norm",
							["HealthBar_Background"] = {
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								1, -- [4]
							},
							["NumericTargetindicator_Outline"] = "OUTLINE",
							["Position_X"] = 1000,
							["PowerBar_Background"] = {
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								1, -- [4]
							},
							["Racial_Cooldown_Outline"] = "OUTLINE",
							["DrTracking_Container_Color"] = {
								[3] = 0,
							},
							["RoleIcon_Size"] = 15,
							["HealthBar_HealthPrediction_Enabled"] = true,
							["Trinket_Cooldown_Outline"] = "OUTLINE",
						},
						["LevelText_EnableTextshadow"] = true,
						["RangeIndicator_Everything"] = true,
						["LevelText_Fontsize"] = 14,
						["RangeIndicator_Alpha"] = 0.5,
						["15"] = {
							["Position_Y"] = 630,
							["Trinket_Width"] = 30,
							["BarVerticalSpacing"] = 5,
							["PowerBar_Background"] = {
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								1, -- [4]
							},
							["RoleIcon_VerticalPosition"] = 6,
							["Auras_Enabled"] = false,
							["DrTracking_Container_OffsetX"] = -1,
							["ObjectiveAndRespawn_EnableTextshadow"] = true,
							["Name_Outline"] = "OUTLINE",
							["PowerBar_Texture"] = "ElvUI Blank",
							["Racial_OffsetX"] = 1,
							["ObjectiveAndRespawn_Width"] = 30,
							["RacialFiltering_Filterlist"] = {
								[26297] = true,
								[107079] = true,
								[80483] = true,
								[50613] = true,
								[59542] = true,
								[59543] = true,
								[59544] = true,
								[68992] = true,
								[25046] = true,
								[59547] = true,
								[59548] = true,
								[121093] = true,
								[33697] = true,
								[20549] = true,
								[69070] = true,
								[59752] = true,
								[20594] = true,
								[33702] = true,
								[20572] = true,
								[58984] = true,
								[28880] = true,
								[20589] = true,
								[69179] = true,
								[7744] = true,
								[232633] = true,
								[59545] = true,
								[129597] = true,
								[155145] = true,
								[28730] = true,
								[202719] = true,
							},
							["Spec_AuraDisplay_Enabled"] = false,
							["HealthBar_Background"] = {
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								1, -- [4]
							},
							["NumericTargetindicator_Outline"] = "OUTLINE",
							["RacialFiltering_Enabled"] = true,
							["Position_X"] = 1000,
							["RoleIcon_Size"] = 15,
							["DrTracking_Container_Color"] = {
								[3] = 0,
							},
							["PowerBar_Enabled"] = true,
							["PowerBar_Height"] = 6,
							["BarHeight"] = 32,
							["Racial_Width"] = 30,
							["HealthBar_HealthPrediction_Enabled"] = true,
							["Spec_Width"] = 30,
							["HealthBar_Texture"] = "ElvUI Norm",
							["PlayerCount_Outline"] = "OUTLINE",
						},
						["LevelText_Enabled"] = true,
						["ShowRealmnames"] = false,
						["LevelText_Outline"] = "OUTLINE",
					},
				},
			},
		}
	end
end
