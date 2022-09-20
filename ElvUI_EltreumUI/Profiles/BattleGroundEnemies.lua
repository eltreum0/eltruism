local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

-- Capping profile setup
function ElvUI_EltreumUI:GetBattleGroundEnemiesProfile()
	if IsAddOnLoaded("BattleGroundEnemies") then
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
						["Enemies"] = {
							["40"] = {
								["Position_Y"] = 610,
								["RoleIcon_VerticalPosition"] = 4,
								["Name_Outline"] = "OUTLINE",
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
								["DrTracking_Container_Color"] = {
									[3] = 0,
								},
								["RoleIcon_Size"] = 15,
								["HealthBar_HealthPrediction_Enabled"] = true,
								["PowerBar_Background"] = {
									nil, -- [1]
									nil, -- [2]
									nil, -- [3]
									1, -- [4]
								},
							},
							["LevelText_EnableTextshadow"] = true,
							["RangeIndicator_Everything"] = true,
							["LevelText_Fontsize"] = 14,
							["5"] = {
								["Position_Y"] = 519.1110821469629,
								["Name_Outline"] = "OUTLINE",
								["PowerBar_Texture"] = "ElvUI Blank",
								["BarWidth"] = 250,
								["HealthBar_Texture"] = "ElvUI Norm",
								["NumericTargetindicator_Outline"] = "OUTLINE",
								["Position_X"] = 1116.08794380349,
								["PowerBar_Enabled"] = true,
								["BarHeight"] = 35,
								["Enabled"] = false,
								["HealthBar_HealthPrediction_Enabled"] = true,
							},
							["ShowRealmnames"] = false,
							["15"] = {
								["Position_Y"] = 630.0000249809018,
								["Trinket_Width"] = 30,
								["BarVerticalSpacing"] = 5,
								["RoleIcon_VerticalPosition"] = 6,
								["Auras_Enabled"] = false,
								["DrTracking_Container_OffsetX"] = -1,
								["Name_Outline"] = "OUTLINE",
								["PowerBar_Texture"] = "ElvUI Blank",
								["Racial_Width"] = 30,
								["ObjectiveAndRespawn_Width"] = 30,
								["Racial_OffsetX"] = 1,
								["Spec_AuraDisplay_Enabled"] = false,
								["HealthBar_Background"] = {
									nil, -- [1]
									nil, -- [2]
									nil, -- [3]
									1, -- [4]
								},
								["PowerBar_Background"] = {
									nil, -- [1]
									nil, -- [2]
									nil, -- [3]
									1, -- [4]
								},
								["NumericTargetindicator_Outline"] = "OUTLINE",
								["Spec_Width"] = 30,
								["RacialFiltering_Enabled"] = true,
								["Position_X"] = 999.9999776482582,
								["RoleIcon_Size"] = 15,
								["DrTracking_Container_Color"] = {
									[3] = 0,
								},
								["PowerBar_Enabled"] = true,
								["PowerBar_Height"] = 6,
								["BarHeight"] = 32,
								["HealthBar_HealthPrediction_Enabled"] = true,
								["HealthBar_Texture"] = "ElvUI Norm",
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
								["ObjectiveAndRespawn_EnableTextshadow"] = true,
							},
							["LevelText_Enabled"] = true,
							["RangeIndicator_Alpha"] = 0.5,
							["LevelText_Outline"] = "OUTLINE",
						},
						["Font"] = E.db.general.font,
						["RBG"] = {
							["TargetCalling_SetMark"] = true,
							["EnemiesTargetingMe_Amount"] = 2,
							["EnemiesTargetingMe_Sound"] = "! - Metal Gear Solid",
							["EnemiesTargetingMe_Enabled"] = true,
						},
						["Locked"] = true,
						["lastReadVersion"] = "9.2.0.4",
						["Allies"] = {
							["40"] = {
								["Position_Y"] = 610,
								["RoleIcon_VerticalPosition"] = 5,
								["Name_Outline"] = "OUTLINE",
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
								["Position_X"] = 200,
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
								["Auras_Enabled"] = true,
							},
							["RangeIndicator_Range"] = 34191,
							["RangeIndicator_Everything"] = true,
							["LevelText_Fontsize"] = 14,
							["5"] = {
								["Position_Y"] = 528.7111600573844,
								["Position_X"] = 183.1111287196472,
								["Enabled"] = false,
							},
							["RangeIndicator_Alpha"] = 0.5,
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
								["Auras_Debuffs_Container_RelativePoint"] = "LEFT",
								["Name_Outline"] = "OUTLINE",
								["PowerBar_Texture"] = "ElvUI Blank",
								["Racial_Width"] = 30,
								["ObjectiveAndRespawn_Width"] = 30,
								["Racial_OffsetX"] = -1,
								["HealthBar_Texture"] = "ElvUI Blank",
								["HealthBar_Background"] = {
									nil, -- [1]
									nil, -- [2]
									nil, -- [3]
									1, -- [4]
								},
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
								["Spec_Width"] = 30,
								["Auras_Debuffs_Container_Point"] = "RIGHT",
								["HealthBar_HealthPrediction_Enabled"] = true,
								["Spec_AuraDisplay_Enabled"] = false,
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
								["ObjectiveAndRespawn_EnableTextshadow"] = true,
							},
							["LevelText_Enabled"] = true,
							["ShowRealmnames"] = false,
							["LevelText_Outline"] = "OUTLINE",
						},
					},
				},
			}
		end

		ElvUI_EltreumUI:Print(L["BattleGroundEnemies profile has been set."])
	else
		ElvUI_EltreumUI:Print(L["BattleGroundEnemies is not loaded"])
	end
end
