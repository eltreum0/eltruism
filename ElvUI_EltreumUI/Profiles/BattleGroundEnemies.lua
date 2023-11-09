local E, L, V, P, G = unpack(ElvUI)
local _G = _G
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded
local table = _G.table

-- Capping profile setup
function ElvUI_EltreumUI:GetBattleGroundEnemiesProfile()
	if IsAddOnLoaded("BattleGroundEnemies") then
		if BattleGroundEnemiesDB.profiles.Eltreum then
			--local key = {[E.mynameRealm] = "Eltreum"}
			--table.insert(CappingSettings.profileKeys, key)
			table.insert(BattleGroundEnemiesDB.profileKeys, E.mynameRealm)
			BattleGroundEnemiesDB["profileKeys"][E.mynameRealm] = "Eltreum"
		else
			BattleGroundEnemiesDB["profileKeys"][E.mynameRealm] = "Eltreum"
			BattleGroundEnemiesDB["profiles"]["Eltreum"] = {}
			BattleGroundEnemiesDB["profiles"]["Eltreum"] = {
				["onlyShowWhenNewVersion"] = true,
				["MyFocus_Color"] = {
					nil, -- [1]
					0, -- [2]
					0, -- [3]
				},
				["Allies"] = {
					["40"] = {
						["RoleIcon_VerticalPosition"] = 5,
						["Auras_Enabled"] = true,
						["DrTracking_GrowDirection"] = "leftwards",
						["HealthBar_Texture"] = "ElvUI Blank",
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
						["DrTracking_Container_Color"] = {
							[3] = 0,
						},
						["HealthBar_HealthPrediction_Enabled"] = true,
						["Name_Outline"] = "OUTLINE",
						["NumericTargetindicator_Outline"] = "OUTLINE",
						["ButtonModules"] = {
							["healthBar"] = {
								["Texture"] = "ElvUI Norm1",
							},
						},
						["PowerBar_Texture"] = "ElvUI Norm",
						["Position_Y"] = 650,
						["Framescale"] = 0.75,
						["Position_X"] = 200,
					},
					["RangeIndicator_Range"] = 34191,
					["LevelText_Fontsize"] = 14,
					["ShowRealmnames"] = false,
					["15"] = {
						["RoleIcon_VerticalPosition"] = 6,
						["Racial_OffsetX"] = -1,
						["PlayerCount_EnableTextshadow"] = true,
						["Auras_Debuffs_DebuffTypeFiltering_Enabled"] = false,
						["DrTracking_Container_Color"] = {
							[3] = 0,
						},
						["PowerBar_Enabled"] = true,
						["PowerBar_Height"] = 6,
						["RoleIcon_Size"] = 15,
						["Position_Y"] = 630,
						["Trinket_Width"] = 30,
						["Racial_Width"] = 30,
						["BarHeight"] = 32,
						["Auras_Debuffs_Container_RelativePoint"] = "LEFT",
						["Spec_Width"] = 30,
						["ObjectiveAndRespawn_Width"] = 30,
						["HealthBar_Texture"] = "ElvUI Blank",
						["Spec_AuraDisplay_Enabled"] = false,
						["HealthBar_Background"] = {
							nil, -- [1]
							nil, -- [2]
							nil, -- [3]
							1, -- [4]
						},
						["Auras_Debuffs_Container_RelativeTo"] = "DRContainer",
						["Auras_Debuffs_Container_Point"] = "RIGHT",
						["ObjectiveAndRespawn_EnableTextshadow"] = true,
						["Name_Outline"] = "OUTLINE",
						["PowerBar_Texture"] = "ElvUI Blank",
						["DrTracking_GrowDirection"] = "leftwards",
						["NumericTargetindicator_Outline"] = "OUTLINE",
						["BarVerticalSpacing"] = 5,
						["ButtonModules"] = {
							["healthBar"] = {
								["Texture"] = "ElvUI Norm1",
							},
							["Power"] = {
								["Texture"] = "ElvUI Norm1",
							},
						},
						["Auras_Debuffs_Size"] = 27,
						--["RacialFiltering_Enabled"] = true,
						["PowerBar_Background"] = {
							nil, -- [1]
							nil, -- [2]
							nil, -- [3]
							1, -- [4]
						},
						["HealthBar_HealthPrediction_Enabled"] = true,
						["Position_X"] = 200,
					},
					["LevelText_Enabled"] = true,
					["5"] = {
						["Enabled"] = false,
						["Position_Y"] = 528.7111600573844,
						["Position_X"] = 183.1111287196472,
					},
					["RangeIndicator_Alpha"] = 0.5,
					["LevelText_Outline"] = "OUTLINE",
				},
				["Font"] = "Kimberley",
				["RBG"] = {
					["TargetCalling_NotificationSound"] = "Warcraft 3 - Blademaster Twinblade ",
					["TargetCalling_SetMark"] = true,
					["EnemiesTargetingMe_Amount"] = 2,
					["EnemiesTargetingMe_Enabled"] = true,
					["EnemiesTargetingMe_Sound"] = "! - Metal Gear Solid",
				},
				["Locked"] = true,
				["lastReadVersion"] = "9.2.0.4",
				["Enemies"] = {
					["40"] = {
						["RoleIcon_VerticalPosition"] = 4,
						["PowerBar_Texture"] = "ElvUI Norm",
						["HealthBar_Texture"] = "ElvUI Norm",
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
						["HealthBar_HealthPrediction_Enabled"] = true,
						["Name_Outline"] = "OUTLINE",
						["DrTracking_Container_Color"] = {
							[3] = 0,
						},
						["NumericTargetindicator_Outline"] = "OUTLINE",
						["RoleIcon_Size"] = 15,
						["ButtonModules"] = {
							["healthBar"] = {
								["Texture"] = "ElvUI Norm1",
							},
						},
						["Position_Y"] = 650,
						["Framescale"] = 0.75,
						["Position_X"] = 1064,
					},
					["LevelText_EnableTextshadow"] = true,
					["RangeIndicator_Alpha"] = 0.5,
					["15"] = {
						["RoleIcon_VerticalPosition"] = 6,
						["PowerBar_Texture"] = "ElvUI Blank",
						["DrTracking_Container_Color"] = {
							[3] = 0,
						},
						["PowerBar_Enabled"] = true,
						["PowerBar_Height"] = 6,
						["RoleIcon_Size"] = 15,
						["Position_Y"] = 630.0000249809018,
						["Trinket_Width"] = 30,
						["Racial_Width"] = 30,
						["BarHeight"] = 32,
						["Spec_Width"] = 30,
						["ObjectiveAndRespawn_Width"] = 30,
						["HealthBar_Texture"] = "ElvUI Norm",
						["HealthBar_Background"] = {
							nil, -- [1]
							nil, -- [2]
							nil, -- [3]
							1, -- [4]
						},
						["Spec_AuraDisplay_Enabled"] = false,
						["PowerBar_Background"] = {
							nil, -- [1]
							nil, -- [2]
							nil, -- [3]
							1, -- [4]
						},
						["HealthBar_HealthPrediction_Enabled"] = true,
						["Name_Outline"] = "OUTLINE",
						["BarVerticalSpacing"] = 5,
						["NumericTargetindicator_Outline"] = "OUTLINE",
						["DrTracking_Container_OffsetX"] = -1,
						["ButtonModules"] = {
							["healthBar"] = {
								["Texture"] = "ElvUI Norm1",
							},
							["Power"] = {
								["Texture"] = "ElvUI Norm1",
							},
						},
						["Auras_Enabled"] = false,
						--["RacialFiltering_Enabled"] = true,
						["ObjectiveAndRespawn_EnableTextshadow"] = true,
						["Racial_OffsetX"] = 1,
						["Position_X"] = 999.9999776482582,
					},
					["LevelText_Enabled"] = true,
					["LevelText_Fontsize"] = 14,
					["5"] = {
						["BarHeight"] = 35,
						["PowerBar_Texture"] = "ElvUI Blank",
						["HealthBar_Texture"] = "ElvUI Norm",
						["Enabled"] = false,
						["HealthBar_HealthPrediction_Enabled"] = true,
						["Name_Outline"] = "OUTLINE",
						["NumericTargetindicator_Outline"] = "OUTLINE",
						["PowerBar_Enabled"] = true,
						["Position_Y"] = 519.1110821469629,
						["BarWidth"] = 250,
						["Position_X"] = 1116.08794380349,
					},
					["ShowRealmnames"] = false,
					["LevelText_Outline"] = "OUTLINE",
				},
			}
		end

		ElvUI_EltreumUI:Print(L["BattleGroundEnemies profile has been set."])
	else
		ElvUI_EltreumUI:Print(L["BattleGroundEnemies is not loaded"])
	end
end
