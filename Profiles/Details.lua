local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

-- Details profile setup


function ElvUI_EltreumUI:GetDetailsProfile()

	if ElvUI_EltreumUI.Retail then
		local key = "Eltreum Dual"
		_detalhes_global = {
			["npcid_pool"] = {
			},
			["death_recap"] = {
				["show_segments"] = true,
				["enabled"] = true,
				["show_life_percent"] = true,
				["relevance_time"] = 12,
			},
			["spell_pool"] = {
			},
			["encounter_spell_pool"] = {
			},
			["immersion_pets_on_solo_play"] = false,
			["npcid_ignored"] = {
			},
			["report_where"] = "GUILD",
			["auto_open_news_window"] = false,
			["got_first_run"] = true,
			["always_use_profile"] = true,
			["plater"] = {
				["realtime_dps_enabled"] = false,
				["damage_taken_shadow"] = true,
				["realtime_dps_player_shadow"] = true,
				["realtime_dps_player_enabled"] = false,
				["realtime_dps_player_size"] = 12,
				["damage_taken_size"] = 12,
				["realtime_dps_color"] = {
					1, -- [1]
					1, -- [2]
					0, -- [3]
					1, -- [4]
				},
				["realtime_dps_anchor"] = {
					["y"] = 0,
					["x"] = 0,
					["side"] = 7,
				},
				["damage_taken_anchor"] = {
					["y"] = 0,
					["x"] = 0,
					["side"] = 7,
				},
				["realtime_dps_size"] = 12,
				["realtime_dps_player_color"] = {
					1, -- [1]
					1, -- [2]
					0, -- [3]
					1, -- [4]
				},
				["damage_taken_color"] = {
					1, -- [1]
					1, -- [2]
					0, -- [3]
					1, -- [4]
				},
				["realtime_dps_player_anchor"] = {
					["y"] = 0,
					["x"] = 0,
					["side"] = 7,
				},
				["damage_taken_enabled"] = false,
				["realtime_dps_shadow"] = true,
			},
			["report_pos"] = {
				1, -- [1]
				1, -- [2]
			},
			["latest_report_table"] = {
				{
					1, -- [1]
					2, -- [2]
					1, -- [3]
					5, -- [4]
					"RAID", -- [5]
				}, -- [1]
				{
					1, -- [1]
					4, -- [2]
					1, -- [3]
					5, -- [4]
					"RAID", -- [5]
				}, -- [2]
				{
					1, -- [1]
					4, -- [2]
					1, -- [3]
					5, -- [4]
					"GUILD", -- [5]
				}, -- [3]
				{
					1, -- [1]
					4, -- [2]
					5, -- [3]
					10, -- [4]
					"RAID", -- [5]
				}, -- [4]
			},
			["exp90temp"] = {
				["delete_damage_TCOB"] = true,
			},
			["__profiles"] = {
				[key] = {
					["show_arena_role_icon"] = false,
					["capture_real"] = {
						["heal"] = true,
						["spellcast"] = true,
						["miscdata"] = true,
						["aura"] = true,
						["energy"] = true,
						["damage"] = true,
					},
					["row_fade_in"] = {
						"in", -- [1]
						0.2, -- [2]
					},
					["streamer_config"] = {
						["faster_updates"] = false,
						["quick_detection"] = false,
						["reset_spec_cache"] = false,
						["no_alerts"] = false,
						["disable_mythic_dungeon"] = false,
						["use_animation_accel"] = true,
					},
					["all_players_are_group"] = false,
					["use_row_animations"] = true,
					["report_heal_links"] = false,
					["remove_realm_from_name"] = true,
					["minimum_overall_combat_time"] = 10,
					["event_tracker"] = {
						["enabled"] = false,
						["font_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["line_height"] = 16,
						["line_color"] = {
							0.1, -- [1]
							0.1, -- [2]
							0.1, -- [3]
							0.3, -- [4]
						},
						["font_shadow"] = "NONE",
						["font_size"] = 10,
						["font_face"] = "Friz Quadrata TT",
						["frame"] = {
							["show_title"] = true,
							["strata"] = "LOW",
							["backdrop_color"] = {
								0.16, -- [1]
								0.16, -- [2]
								0.16, -- [3]
								0.47, -- [4]
							},
							["locked"] = false,
							["height"] = 300,
							["width"] = 250,
						},
						["line_texture"] = "Details Serenity",
						["options_frame"] = {
						},
					},
					["report_to_who"] = "",
					["class_specs_coords"] = {
						[62] = {
							0.251953125, -- [1]
							0.375, -- [2]
							0.125, -- [3]
							0.25, -- [4]
						},
						[63] = {
							0.375, -- [1]
							0.5, -- [2]
							0.125, -- [3]
							0.25, -- [4]
						},
						[250] = {
							0, -- [1]
							0.125, -- [2]
							0, -- [3]
							0.125, -- [4]
						},
						[251] = {
							0.125, -- [1]
							0.25, -- [2]
							0, -- [3]
							0.125, -- [4]
						},
						[252] = {
							0.25, -- [1]
							0.375, -- [2]
							0, -- [3]
							0.125, -- [4]
						},
						[253] = {
							0.875, -- [1]
							1, -- [2]
							0, -- [3]
							0.125, -- [4]
						},
						[254] = {
							0, -- [1]
							0.125, -- [2]
							0.125, -- [3]
							0.25, -- [4]
						},
						[255] = {
							0.125, -- [1]
							0.25, -- [2]
							0.125, -- [3]
							0.25, -- [4]
						},
						[66] = {
							0.125, -- [1]
							0.25, -- [2]
							0.25, -- [3]
							0.375, -- [4]
						},
						[257] = {
							0.5, -- [1]
							0.625, -- [2]
							0.25, -- [3]
							0.375, -- [4]
						},
						[258] = {
							0.6328125, -- [1]
							0.75, -- [2]
							0.25, -- [3]
							0.375, -- [4]
						},
						[259] = {
							0.75, -- [1]
							0.875, -- [2]
							0.25, -- [3]
							0.375, -- [4]
						},
						[260] = {
							0.875, -- [1]
							1, -- [2]
							0.25, -- [3]
							0.375, -- [4]
						},
						[577] = {
							0.25, -- [1]
							0.375, -- [2]
							0.5, -- [3]
							0.625, -- [4]
						},
						[262] = {
							0.125, -- [1]
							0.25, -- [2]
							0.375, -- [3]
							0.5, -- [4]
						},
						[581] = {
							0.375, -- [1]
							0.5, -- [2]
							0.5, -- [3]
							0.625, -- [4]
						},
						[264] = {
							0.375, -- [1]
							0.5, -- [2]
							0.375, -- [3]
							0.5, -- [4]
						},
						[265] = {
							0.5, -- [1]
							0.625, -- [2]
							0.375, -- [3]
							0.5, -- [4]
						},
						[266] = {
							0.625, -- [1]
							0.75, -- [2]
							0.375, -- [3]
							0.5, -- [4]
						},
						[267] = {
							0.75, -- [1]
							0.875, -- [2]
							0.375, -- [3]
							0.5, -- [4]
						},
						[268] = {
							0.625, -- [1]
							0.75, -- [2]
							0.125, -- [3]
							0.25, -- [4]
						},
						[269] = {
							0.875, -- [1]
							1, -- [2]
							0.125, -- [3]
							0.25, -- [4]
						},
						[270] = {
							0.75, -- [1]
							0.875, -- [2]
							0.125, -- [3]
							0.25, -- [4]
						},
						[70] = {
							0.251953125, -- [1]
							0.375, -- [2]
							0.25, -- [3]
							0.375, -- [4]
						},
						[102] = {
							0.375, -- [1]
							0.5, -- [2]
							0, -- [3]
							0.125, -- [4]
						},
						[71] = {
							0.875, -- [1]
							1, -- [2]
							0.375, -- [3]
							0.5, -- [4]
						},
						[103] = {
							0.5, -- [1]
							0.625, -- [2]
							0, -- [3]
							0.125, -- [4]
						},
						[72] = {
							0, -- [1]
							0.125, -- [2]
							0.5, -- [3]
							0.625, -- [4]
						},
						[104] = {
							0.625, -- [1]
							0.75, -- [2]
							0, -- [3]
							0.125, -- [4]
						},
						[73] = {
							0.125, -- [1]
							0.25, -- [2]
							0.5, -- [3]
							0.625, -- [4]
						},
						[64] = {
							0.5, -- [1]
							0.625, -- [2]
							0.125, -- [3]
							0.25, -- [4]
						},
						[105] = {
							0.75, -- [1]
							0.875, -- [2]
							0, -- [3]
							0.125, -- [4]
						},
						[65] = {
							0, -- [1]
							0.125, -- [2]
							0.25, -- [3]
							0.375, -- [4]
						},
						[256] = {
							0.375, -- [1]
							0.5, -- [2]
							0.25, -- [3]
							0.375, -- [4]
						},
						[261] = {
							0, -- [1]
							0.125, -- [2]
							0.375, -- [3]
							0.5, -- [4]
						},
						[263] = {
							0.25, -- [1]
							0.375, -- [2]
							0.375, -- [3]
							0.5, -- [4]
						},
					},
					["profile_save_pos"] = true,
					["tooltip"] = {
						["header_statusbar"] = {
							0.3, -- [1]
							0.3, -- [2]
							0.3, -- [3]
							0.8, -- [4]
							false, -- [5]
							false, -- [6]
							"WorldState Score", -- [7]
						},
						["fontcolor_right"] = {
							1, -- [1]
							0.7, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["line_height"] = 17,
						["tooltip_max_targets"] = 2,
						["icon_size"] = {
							["W"] = 17,
							["H"] = 17,
						},
						["tooltip_max_pets"] = 2,
						["anchor_relative"] = "top",
						["abbreviation"] = 3,
						["anchored_to"] = 1,
						["fontsize"] = 10,
						["header_text_color"] = {
							1, -- [1]
							0.9176470588235294, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["show_amount"] = false,
						["background"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							0.8, -- [4]
						},
						["submenu_wallpaper"] = true,
						["fontsize_title"] = 10,
						["fontcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["commands"] = {
						},
						["tooltip_max_abilities"] = 6,
						["fontface"] = "Kimberley",
						["border_color"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["border_texture"] = "Details BarBorder 3",
						["anchor_offset"] = {
							0, -- [1]
							0, -- [2]
						},
						["fontshadow"] = true,
						["menus_bg_texture"] = "Interface\\SPELLBOOK\\Spellbook-Page-1",
						["border_size"] = 14,
						["maximize_method"] = 1,
						["anchor_screen_pos"] = {
							507.7, -- [1]
							-350.5, -- [2]
						},
						["anchor_point"] = "bottom",
						["menus_bg_coords"] = {
							0.309777336120606, -- [1]
							0.924000015258789, -- [2]
							0.213000011444092, -- [3]
							0.279000015258789, -- [4]
						},
						["icon_border_texcoord"] = {
							["R"] = 0.921875,
							["L"] = 0.078125,
							["T"] = 0.078125,
							["B"] = 0.921875,
						},
						["menus_bg_color"] = {
							0.8, -- [1]
							0.8, -- [2]
							0.8, -- [3]
							0.2, -- [4]
						},
					},
					["ps_abbreviation"] = 3,
					["world_combat_is_trash"] = false,
					["update_speed"] = 0.199999988079071,
					["bookmark_text_size"] = 11,
					["animation_speed_mintravel"] = 0.45,
					["track_item_level"] = true,
					["windows_fade_in"] = {
						"in", -- [1]
						0.2, -- [2]
					},
					["instances_menu_click_to_open"] = false,
					["overall_clear_newchallenge"] = true,
					["current_dps_meter"] = {
						["enabled"] = false,
						["font_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["arena_enabled"] = true,
						["font_shadow"] = "NONE",
						["font_size"] = 18,
						["mythic_dungeon_enabled"] = true,
						["font_face"] = "Friz Quadrata TT",
						["sample_size"] = 5,
						["frame"] = {
							["show_title"] = false,
							["strata"] = "LOW",
							["backdrop_color"] = {
								0, -- [1]
								0, -- [2]
								0, -- [3]
								0.2, -- [4]
							},
							["locked"] = false,
							["height"] = 65,
							["width"] = 220,
						},
						["update_interval"] = 0.3,
						["options_frame"] = {
						},
					},
					["data_cleanup_logout"] = false,
					["instances_disable_bar_highlight"] = false,
					["trash_concatenate"] = false,
					["color_by_arena_team"] = true,
					["animation_speed"] = 33,
					["disable_stretch_from_toolbar"] = false,
					["disable_lock_ungroup_buttons"] = true,
					["memory_ram"] = 64,
					["disable_window_groups"] = false,
					["instances_suppress_trash"] = 0,
					["options_window"] = {
						["scale"] = 1,
					},
					["animation_speed_maxtravel"] = 3,
					["instances"] = {
						{
							["__pos"] = {
								["normal"] = {
									["y"] = -446.5714721679688,
									["x"] = 667.3021850585938,
									["w"] = 205.9999542236328,
									["h"] = 158.2857513427734,
								},
								["solo"] = {
									["y"] = 2,
									["x"] = 1,
									["w"] = 300,
									["h"] = 200,
								},
							},
							["hide_in_combat_type"] = 1,
							["clickthrough_window"] = false,
							["menu_anchor"] = {
								16, -- [1]
								0, -- [2]
								["side"] = 2,
							},
							["bg_r"] = 0.09411764705882353,
							["hide_out_of_combat"] = false,
							["color_buttons"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["toolbar_icon_file"] = "Interface\\AddOns\\Details\\images\\toolbar_icons_2",
							["micro_displays_locked"] = true,
							["fontstrings_width"] = 35,
							["tooltip"] = {
								["n_abilities"] = 3,
								["n_enemies"] = 3,
							},
							["switch_all_roles_in_combat"] = false,
							["clickthrough_toolbaricons"] = false,
							["row_info"] = {
								["textR_outline"] = true,
								["spec_file"] = "Interface\\AddOns\\Details\\images\\spec_icons_normal",
								["textL_outline"] = true,
								["texture_highlight"] = "Interface\\FriendsFrame\\UI-FriendsList-Highlight",
								["textR_show_data"] = {
									true, -- [1]
									true, -- [2]
									false, -- [3]
								},
								["textL_enable_custom_text"] = false,
								["fixed_text_color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["space"] = {
									["right"] = 0,
									["left"] = 0,
									["between"] = 1,
								},
								["texture_background_class_color"] = false,
								["textL_outline_small_color"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
									1, -- [4]
								},
								["font_face_file"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\\\Fonts\\Kimberley.otf",
								["textL_custom_text"] = "{data1}. {data3}{data2}",
								["models"] = {
									["upper_model"] = "Spells\\AcidBreath_SuperGreen.M2",
									["lower_model"] = "World\\EXPANSION02\\DOODADS\\Coldarra\\COLDARRALOCUS.m2",
									["upper_alpha"] = 0.5,
									["lower_enabled"] = false,
									["lower_alpha"] = 0.1,
									["upper_enabled"] = false,
								},
								["textL_translit_text"] = true,
								["texture_custom_file"] = "Interface\\",
								["texture_file"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum7pixel.tga",
								["height"] = 21,
								["font_size"] = 11,
								["icon_file"] = "Interface\\AddOns\\Details\\images\\classes_small",
								["icon_grayscale"] = false,
								["backdrop"] = {
									["enabled"] = false,
									["size"] = 2.259999990463257,
									["color"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["texture"] = "Details BarBorder 2",
								},
								["textR_bracket"] = "NONE",
								["texture_custom"] = "",
								["textL_outline_small"] = true,
								["fixed_texture_color"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
								},
								["textL_show_number"] = true,
								["textR_enable_custom_text"] = false,
								["textR_outline_small"] = true,
								["textR_custom_text"] = "{data1}. {data3}{data2}",
								["texture"] = "Eltreum7pixel",
								["fixed_texture_background_color"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
									0.150228589773178, -- [4]
								},
								["texture_background_file"] = "Interface\\Addons\\SharedMedia_MyMedia\\statusbar\\Empty.tga",
								["textR_class_colors"] = false,
								["textR_outline_small_color"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
									1, -- [4]
								},
								["textL_class_colors"] = true,
								["texture_background"] = "Empty",
								["alpha"] = 1,
								["no_icon"] = false,
								["icon_offset"] = {
									0, -- [1]
									0, -- [2]
								},
								["start_after_icon"] = true,
								["font_face"] = "Kimberley",
								["texture_class_colors"] = true,
								["percent_type"] = 1,
								["fast_ps_update"] = false,
								["textR_separator"] = "NONE",
								["use_spec_icons"] = true,
							},
							["switch_tank"] = false,
							["plugins_grow_direction"] = 2,
							["menu_icons"] = {
								true, -- [1]
								true, -- [2]
								true, -- [3]
								true, -- [4]
								false, -- [5]
								false, -- [6]
								["space"] = -2,
								["shadow"] = true,
							},
							["desaturated_menu"] = true,
							["micro_displays_side"] = 2,
							["window_scale"] = 1,
							["hide_icon"] = false,
							["toolbar_side"] = 1,
							["bg_g"] = 0.09411764705882353,
							["menu_icons_alpha"] = 0.5,
							["bg_b"] = 0.09411764705882353,
							["switch_healer_in_combat"] = false,
							["color"] = {
								0, -- [1]
								0, -- [2]
								0, -- [3]
								0, -- [4]
							},
							["hide_on_context"] = {
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [1]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [2]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [3]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [4]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [5]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [6]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [7]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [8]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [9]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [10]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [11]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [12]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [13]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [14]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [15]
							},
							["skin"] = "Minimalistic",
							["following"] = {
								["bar_color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
								},
								["enabled"] = true,
								["text_color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
								},
							},
							["switch_healer"] = false,
							["fontstrings_text2_anchor"] = 70,
							["__snapV"] = false,
							["__snapH"] = false,
							["StatusBarSaved"] = {
								["center"] = "",
								["right"] = "",
								["options"] = {
									["DETAILS_STATUSBAR_PLUGIN_PDPS"] = {
										["isHidden"] = true,
										["segmentType"] = 2,
										["textFace"] = "Accidental Presidency",
										["textColor"] = {
											1, -- [1]
											1, -- [2]
											1, -- [3]
											1, -- [4]
										},
										["textAlign"] = 3,
										["timeType"] = 1,
										["textSize"] = 10,
										["textYMod"] = 1,
									},
									["DETAILS_STATUSBAR_PLUGIN_PSEGMENT"] = {
										["isHidden"] = true,
										["segmentType"] = 2,
										["textFace"] = "Accidental Presidency",
										["textColor"] = {
											1, -- [1]
											1, -- [2]
											1, -- [3]
											1, -- [4]
										},
										["textAlign"] = 1,
										["timeType"] = 1,
										["textSize"] = 10,
										["textYMod"] = 1,
									},
									["DETAILS_STATUSBAR_PLUGIN_CLOCK"] = {
										["isHidden"] = true,
										["segmentType"] = 2,
										["textFace"] = "Accidental Presidency",
										["textColor"] = {
											1, -- [1]
											1, -- [2]
											1, -- [3]
											1, -- [4]
										},
										["textAlign"] = 2,
										["timeType"] = 1,
										["textSize"] = 10,
										["textYMod"] = 1,
									},
								},
								["left"] = "",
							},
							["grab_on_top"] = false,
							["__was_opened"] = true,
							["instance_button_anchor"] = {
								-27, -- [1]
								1, -- [2]
							},
							["version"] = 3,
							["fontstrings_text4_anchor"] = 0,
							["__locked"] = true,
							["menu_alpha"] = {
								["enabled"] = false,
								["onleave"] = 1,
								["ignorebars"] = false,
								["iconstoo"] = true,
								["onenter"] = 1,
							},
							["switch_all_roles_after_wipe"] = false,
							["row_show_animation"] = {
								["anim"] = "Fade",
								["options"] = {
								},
							},
							["bars_inverted"] = false,
							["strata"] = "LOW",
							["clickthrough_incombatonly"] = true,
							["__snap"] = {
								[3] = 2,
							},
							["stretch_button_side"] = 1,
							["hide_in_combat_alpha"] = 0,
							["bars_sort_direction"] = 1,
							["show_statusbar"] = false,
							["libwindow"] = {
								["y"] = 22.85706329345703,
								["x"] = -204.93603515625,
								["point"] = "BOTTOMRIGHT",
								["scale"] = 1,
							},
							["statusbar_info"] = {
								["alpha"] = 0,
								["overlay"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
								},
							},
							["backdrop_texture"] = "None",
							["menu_anchor_down"] = {
								16, -- [1]
								-3, -- [2]
							},
							["bg_alpha"] = 0.1800000071525574,
							["switch_tank_in_combat"] = false,
							["bars_grow_direction"] = 1,
							["switch_damager_in_combat"] = false,
							["icon_desaturated"] = false,
							["clickthrough_rows"] = false,
							["auto_current"] = true,
							["attribute_text"] = {
								["enabled"] = true,
								["shadow"] = true,
								["side"] = 1,
								["text_color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["custom_text"] = "{name}",
								["text_face"] = "Kimberley",
								["anchor"] = {
									0, -- [1]
									3, -- [2]
								},
								["text_size"] = 12,
								["enable_custom_text"] = false,
								["show_timer"] = false,
							},
							["auto_hide_menu"] = {
								["left"] = true,
								["right"] = false,
							},
							["switch_damager"] = false,
							["hide_in_combat"] = false,
							["posicao"] = {
								["normal"] = {
									["y"] = -446.5714721679688,
									["x"] = 667.3021850585938,
									["w"] = 205.9999542236328,
									["h"] = 158.2857513427734,
								},
								["solo"] = {
									["y"] = 2,
									["x"] = 1,
									["w"] = 300,
									["h"] = 200,
								},
							},
							["skin_custom"] = "",
							["ignore_mass_showhide"] = false,
							["wallpaper"] = {
								["overlay"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["texcoord"] = {
									0, -- [1]
									1, -- [2]
									0, -- [3]
									0.7, -- [4]
								},
								["enabled"] = false,
								["anchor"] = "all",
								["height"] = 114.042518615723,
								["alpha"] = 0.5,
								["width"] = 283.000183105469,
							},
							["total_bar"] = {
								["enabled"] = false,
								["only_in_group"] = true,
								["icon"] = "Interface\\ICONS\\INV_Sigil_Thorim",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
								},
							},
							["show_sidebars"] = false,
							["fontstrings_text3_anchor"] = 35,
							["use_multi_fontstrings"] = true,
							["menu_icons_size"] = 0.8500000238418579,
						}, -- [1]
						{
							["__pos"] = {
								["normal"] = {
									["y"] = -446.5714721679688,
									["x"] = 872.0086059570312,
									["w"] = 203.4126281738281,
									["h"] = 158.2857513427734,
								},
								["solo"] = {
									["y"] = 2,
									["x"] = 1,
									["w"] = 300,
									["h"] = 200,
								},
							},
							["hide_in_combat_type"] = 1,
							["clickthrough_window"] = false,
							["menu_anchor"] = {
								16, -- [1]
								0, -- [2]
								["side"] = 2,
							},
							["bg_r"] = 0.09411764705882353,
							["hide_out_of_combat"] = false,
							["color_buttons"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["toolbar_icon_file"] = "Interface\\AddOns\\Details\\images\\toolbar_icons_2",
							["micro_displays_locked"] = true,
							["fontstrings_width"] = 35,
							["tooltip"] = {
								["n_abilities"] = 3,
								["n_enemies"] = 3,
							},
							["switch_all_roles_in_combat"] = false,
							["clickthrough_toolbaricons"] = false,
							["row_info"] = {
								["textR_outline"] = true,
								["spec_file"] = "Interface\\AddOns\\Details\\images\\spec_icons_normal",
								["textL_outline"] = true,
								["texture_highlight"] = "Interface\\FriendsFrame\\UI-FriendsList-Highlight",
								["textR_show_data"] = {
									true, -- [1]
									true, -- [2]
									false, -- [3]
								},
								["textL_enable_custom_text"] = false,
								["fixed_text_color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["space"] = {
									["right"] = 0,
									["left"] = 0,
									["between"] = 1,
								},
								["texture_background_class_color"] = false,
								["textL_outline_small_color"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
									1, -- [4]
								},
								["font_face_file"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Font\\Kimberley.otf",
								["textL_custom_text"] = "{data1}. {data3}{data2}",
								["models"] = {
									["upper_model"] = "Spells\\AcidBreath_SuperGreen.M2",
									["lower_model"] = "World\\EXPANSION02\\DOODADS\\Coldarra\\COLDARRALOCUS.m2",
									["upper_alpha"] = 0.5,
									["lower_enabled"] = false,
									["lower_alpha"] = 0.1,
									["upper_enabled"] = false,
								},
								["textL_translit_text"] = true,
								["texture_custom_file"] = "Interface\\",
								["texture_file"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum7pixel.tga",
								["height"] = 21,
								["font_size"] = 11,
								["icon_file"] = "Interface\\AddOns\\Details\\images\\classes_small",
								["icon_grayscale"] = false,
								["backdrop"] = {
									["enabled"] = false,
									["size"] = 2.259999990463257,
									["color"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["texture"] = "Details BarBorder 2",
								},
								["textR_bracket"] = "NONE",
								["texture_custom"] = "",
								["textL_outline_small"] = true,
								["fixed_texture_color"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
								},
								["textL_show_number"] = true,
								["textR_enable_custom_text"] = false,
								["textR_outline_small"] = true,
								["textR_custom_text"] = "{data1}. {data3}{data2}",
								["texture"] = "Eltreum7pixel",
								["fixed_texture_background_color"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
									0.150228589773178, -- [4]
								},
								["texture_background_file"] = "Interface\\Addons\\SharedMedia_MyMedia\\statusbar\\Empty.tga",
								["textR_class_colors"] = false,
								["textR_outline_small_color"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
									1, -- [4]
								},
								["textL_class_colors"] = true,
								["texture_background"] = "Empty",
								["alpha"] = 1,
								["no_icon"] = false,
								["icon_offset"] = {
									0, -- [1]
									0, -- [2]
								},
								["start_after_icon"] = true,
								["font_face"] = "Kimberley",
								["texture_class_colors"] = true,
								["percent_type"] = 1,
								["fast_ps_update"] = false,
								["textR_separator"] = "NONE",
								["use_spec_icons"] = true,
							},
							["switch_tank"] = false,
							["plugins_grow_direction"] = 2,
							["menu_icons"] = {
								true, -- [1]
								true, -- [2]
								true, -- [3]
								true, -- [4]
								false, -- [5]
								false, -- [6]
								["space"] = -2,
								["shadow"] = true,
							},
							["desaturated_menu"] = true,
							["micro_displays_side"] = 2,
							["window_scale"] = 1,
							["hide_icon"] = false,
							["toolbar_side"] = 1,
							["bg_g"] = 0.09411764705882353,
							["menu_icons_alpha"] = 0.5,
							["bg_b"] = 0.09411764705882353,
							["switch_healer_in_combat"] = false,
							["color"] = {
								0, -- [1]
								0, -- [2]
								0, -- [3]
								0, -- [4]
							},
							["hide_on_context"] = {
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [1]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [2]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [3]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [4]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [5]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [6]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [7]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [8]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [9]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [10]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [11]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [12]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [13]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [14]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [15]
							},
							["skin"] = "Minimalistic",
							["following"] = {
								["bar_color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
								},
								["enabled"] = true,
								["text_color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
								},
							},
							["switch_healer"] = false,
							["fontstrings_text2_anchor"] = 70,
							["__snapV"] = false,
							["__snapH"] = false,
							["StatusBarSaved"] = {
								["center"] = "",
								["right"] = "",
								["options"] = {
									["DETAILS_STATUSBAR_PLUGIN_PDPS"] = {
										["isHidden"] = true,
										["timeType"] = 1,
										["maxSectionIds"] = 18,
										["segmentType"] = 2,
										["textFace"] = "Accidental Presidency",
										["textYMod"] = 1,
										["textAlign"] = 3,
										["textSize"] = 10,
										["textColor"] = {
											1, -- [1]
											1, -- [2]
											1, -- [3]
											1, -- [4]
										},
									},
									["DETAILS_STATUSBAR_PLUGIN_PSEGMENT"] = {
										["isHidden"] = true,
										["timeType"] = 1,
										["maxSectionIds"] = 18,
										["segmentType"] = 2,
										["textFace"] = "Accidental Presidency",
										["textYMod"] = 1,
										["textAlign"] = 1,
										["textSize"] = 10,
										["textColor"] = {
											1, -- [1]
											1, -- [2]
											1, -- [3]
											1, -- [4]
										},
									},
									["DETAILS_STATUSBAR_PLUGIN_CLOCK"] = {
										["isHidden"] = true,
										["timeType"] = 1,
										["maxSectionIds"] = 18,
										["segmentType"] = 2,
										["textFace"] = "Accidental Presidency",
										["textYMod"] = 1,
										["textAlign"] = 2,
										["textSize"] = 10,
										["textColor"] = {
											1, -- [1]
											1, -- [2]
											1, -- [3]
											1, -- [4]
										},
									},
								},
								["left"] = "",
							},
							["grab_on_top"] = false,
							["__was_opened"] = true,
							["instance_button_anchor"] = {
								-27, -- [1]
								1, -- [2]
							},
							["version"] = 3,
							["fontstrings_text4_anchor"] = 0,
							["__locked"] = true,
							["menu_alpha"] = {
								["enabled"] = false,
								["onleave"] = 1,
								["ignorebars"] = false,
								["iconstoo"] = true,
								["onenter"] = 1,
							},
							["switch_all_roles_after_wipe"] = false,
							["row_show_animation"] = {
								["anim"] = "Fade",
								["options"] = {
								},
							},
							["bars_inverted"] = false,
							["strata"] = "LOW",
							["clickthrough_incombatonly"] = true,
							["__snap"] = {
								1, -- [1]
							},
							["stretch_button_side"] = 1,
							["hide_in_combat_alpha"] = 0,
							["bars_sort_direction"] = 1,
							["show_statusbar"] = false,
							["libwindow"] = {
								["y"] = 22.85706329345703,
								["x"] = -1.5234375,
								["point"] = "BOTTOMRIGHT",
								["scale"] = 1,
							},
							["statusbar_info"] = {
								["alpha"] = 0,
								["overlay"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
								},
							},
							["backdrop_texture"] = "None",
							["menu_anchor_down"] = {
								16, -- [1]
								-3, -- [2]
							},
							["bg_alpha"] = 0.1800000071525574,
							["switch_tank_in_combat"] = false,
							["bars_grow_direction"] = 1,
							["switch_damager_in_combat"] = false,
							["icon_desaturated"] = false,
							["clickthrough_rows"] = false,
							["auto_current"] = true,
							["attribute_text"] = {
								["enabled"] = true,
								["shadow"] = true,
								["side"] = 1,
								["text_color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["custom_text"] = "{name}",
								["text_face"] = "Kimberley",
								["anchor"] = {
									0, -- [1]
									3, -- [2]
								},
								["text_size"] = 12,
								["enable_custom_text"] = false,
								["show_timer"] = false,
							},
							["auto_hide_menu"] = {
								["left"] = true,
								["right"] = false,
							},
							["switch_damager"] = false,
							["hide_in_combat"] = false,
							["posicao"] = {
								["normal"] = {
									["y"] = -446.5714721679688,
									["x"] = 872.0086059570312,
									["w"] = 203.4126281738281,
									["h"] = 158.2857513427734,
								},
								["solo"] = {
									["y"] = 2,
									["x"] = 1,
									["w"] = 300,
									["h"] = 200,
								},
							},
							["skin_custom"] = "",
							["ignore_mass_showhide"] = false,
							["wallpaper"] = {
								["overlay"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["texcoord"] = {
									0, -- [1]
									1, -- [2]
									0, -- [3]
									0.7, -- [4]
								},
								["enabled"] = false,
								["anchor"] = "all",
								["height"] = 114.042518615723,
								["alpha"] = 0.5,
								["width"] = 283.000183105469,
							},
							["total_bar"] = {
								["enabled"] = false,
								["only_in_group"] = true,
								["icon"] = "Interface\\ICONS\\INV_Sigil_Thorim",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
								},
							},
							["show_sidebars"] = false,
							["fontstrings_text3_anchor"] = 35,
							["use_multi_fontstrings"] = true,
							["menu_icons_size"] = 0.850000023841858,
						}, -- [2]
					},
					["hotcorner_topleft"] = {
						["hide"] = false,
					},
					["font_faces"] = {
						["menus"] = "Kimberley",
					},
					["deadlog_limit"] = 16,
					["instances_segments_locked"] = true,
					["instances_no_libwindow"] = false,
					["segments_amount"] = 40,
					["report_lines"] = 5,
					["data_broker_text"] = "",
					["clear_ungrouped"] = true,
					["skin"] = "Dark Theme",
					["override_spellids"] = true,
					["font_sizes"] = {
						["menus"] = 10,
					},
					["total_abbreviation"] = 2,
					["report_schema"] = 1,
					["animation_speed_triggertravel"] = 5,
					["minimum_combat_time"] = 5,
					["use_battleground_server_parser"] = false,
					["cloud_capture"] = true,
					["damage_taken_everything"] = false,
					["scroll_speed"] = 2,
					["new_window_size"] = {
						["height"] = 158,
						["width"] = 310,
					},
					["chat_tab_embed"] = {
						["enabled"] = false,
						["tab_name"] = "",
						["x_offset"] = 0,
						["y_offset"] = 0,
						["single_window"] = false,
					},
					["deadlog_events"] = 32,
					["use_scroll"] = false,
					["close_shields"] = false,
					["class_coords"] = {
						["HUNTER"] = {
							0, -- [1]
							0.25, -- [2]
							0.25, -- [3]
							0.5, -- [4]
						},
						["WARRIOR"] = {
							0, -- [1]
							0.25, -- [2]
							0, -- [3]
							0.25, -- [4]
						},
						["SHAMAN"] = {
							0.25, -- [1]
							0.49609375, -- [2]
							0.25, -- [3]
							0.5, -- [4]
						},
						["MAGE"] = {
							0.25, -- [1]
							0.49609375, -- [2]
							0, -- [3]
							0.25, -- [4]
						},
						["PET"] = {
							0.25, -- [1]
							0.49609375, -- [2]
							0.75, -- [3]
							1, -- [4]
						},
						["DRUID"] = {
							0.7421875, -- [1]
							0.98828125, -- [2]
							0, -- [3]
							0.25, -- [4]
						},
						["MONK"] = {
							0.5, -- [1]
							0.73828125, -- [2]
							0.5, -- [3]
							0.75, -- [4]
						},
						["DEATHKNIGHT"] = {
							0.25, -- [1]
							0.5, -- [2]
							0.5, -- [3]
							0.75, -- [4]
						},
						["WARLOCK"] = {
							0.7421875, -- [1]
							0.98828125, -- [2]
							0.25, -- [3]
							0.5, -- [4]
						},
						["UNKNOW"] = {
							0.5, -- [1]
							0.75, -- [2]
							0.75, -- [3]
							1, -- [4]
						},
						["PRIEST"] = {
							0.49609375, -- [1]
							0.7421875, -- [2]
							0.25, -- [3]
							0.5, -- [4]
						},
						["UNGROUPPLAYER"] = {
							0.5, -- [1]
							0.75, -- [2]
							0.75, -- [3]
							1, -- [4]
						},
						["Alliance"] = {
							0.49609375, -- [1]
							0.7421875, -- [2]
							0.75, -- [3]
							1, -- [4]
						},
						["ENEMY"] = {
							0, -- [1]
							0.25, -- [2]
							0.75, -- [3]
							1, -- [4]
						},
						["DEMONHUNTER"] = {
							0.73828126, -- [1]
							1, -- [2]
							0.5, -- [3]
							0.75, -- [4]
						},
						["Horde"] = {
							0.7421875, -- [1]
							0.98828125, -- [2]
							0.75, -- [3]
							1, -- [4]
						},
						["PALADIN"] = {
							0, -- [1]
							0.25, -- [2]
							0.5, -- [3]
							0.75, -- [4]
						},
						["ROGUE"] = {
							0.49609375, -- [1]
							0.7421875, -- [2]
							0, -- [3]
							0.25, -- [4]
						},
						["MONSTER"] = {
							0, -- [1]
							0.25, -- [2]
							0.75, -- [3]
							1, -- [4]
						},
					},
					["overall_clear_logout"] = false,
					["disable_alldisplays_window"] = false,
					["trash_auto_remove"] = true,
					["window_clamp"] = {
						-8, -- [1]
						0, -- [2]
						21, -- [3]
						-14, -- [4]
					},
					["windows_fade_out"] = {
						"out", -- [1]
						0.2, -- [2]
					},
					["numerical_system_symbols"] = "auto",
					["clear_graphic"] = true,
					["class_colors"] = {
						["HUNTER"] = {
							0.67, -- [1]
							0.83, -- [2]
							0.45, -- [3]
						},
						["WARRIOR"] = {
							0.78, -- [1]
							0.61, -- [2]
							0.43, -- [3]
						},
						["ROGUE"] = {
							1, -- [1]
							0.96, -- [2]
							0.41, -- [3]
						},
						["MAGE"] = {
							0.41, -- [1]
							0.8, -- [2]
							0.94, -- [3]
						},
						["ARENA_YELLOW"] = {
							1, -- [1]
							1, -- [2]
							0.25, -- [3]
						},
						["UNGROUPPLAYER"] = {
							0.4, -- [1]
							0.4, -- [2]
							0.4, -- [3]
						},
						["DRUID"] = {
							1, -- [1]
							0.49, -- [2]
							0.04, -- [3]
						},
						["MONK"] = {
							0, -- [1]
							1, -- [2]
							0.59, -- [3]
						},
						["DEATHKNIGHT"] = {
							0.77, -- [1]
							0.12, -- [2]
							0.23, -- [3]
						},
						["PET"] = {
							0.3, -- [1]
							0.4, -- [2]
							0.5, -- [3]
						},
						["UNKNOW"] = {
							0.2, -- [1]
							0.2, -- [2]
							0.2, -- [3]
						},
						["PRIEST"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
						},
						["SHAMAN"] = {
							0, -- [1]
							0.44, -- [2]
							0.87, -- [3]
						},
						["ARENA_GREEN"] = {
							0.4, -- [1]
							1, -- [2]
							0.4, -- [3]
						},
						["ENEMY"] = {
							0.94117, -- [1]
							0, -- [2]
							0.0196, -- [3]
							1, -- [4]
						},
						["DEMONHUNTER"] = {
							0.64, -- [1]
							0.19, -- [2]
							0.79, -- [3]
						},
						["version"] = 1,
						["NEUTRAL"] = {
							1, -- [1]
							1, -- [2]
							0, -- [3]
						},
						["PALADIN"] = {
							0.96, -- [1]
							0.55, -- [2]
							0.73, -- [3]
						},
						["WARLOCK"] = {
							0.58, -- [1]
							0.51, -- [2]
							0.79, -- [3]
						},
					},
					["segments_auto_erase"] = 3,
					["options_group_edit"] = true,
					["broadcaster_enabled"] = false,
					["minimap"] = {
						["minimapPos"] = 220,
						["radius"] = 160,
						["hide"] = true,
						["onclick_what_todo"] = 1,
						["text_format"] = 3,
						["text_type"] = 1,
					},
					["instances_amount"] = 2,
					["max_window_size"] = {
						["height"] = 450,
						["width"] = 480,
					},
					["deny_score_messages"] = false,
					["only_pvp_frags"] = false,
					["disable_stretch_button"] = true,
					["default_bg_color"] = 0.0941,
					["standard_skin"] = false,
					["segments_amount_to_save"] = 40,
					["segments_panic_mode"] = false,
					["overall_flag"] = 16,
					["overall_clear_newboss"] = true,
					["row_fade_out"] = {
						"out", -- [1]
						0.2, -- [2]
					},
					["player_details_window"] = {
						["scale"] = 1,
						["skin"] = "ElvUI",
						["bar_texture"] = "Skyline",
					},
					["numerical_system"] = 1,
					["pvp_as_group"] = true,
					["force_activity_time_pvp"] = true,
					["class_icons_small"] = "Interface\\AddOns\\Details\\images\\classes_small",
					["memory_threshold"] = 3,
					["disable_reset_button"] = false,
					["animate_scroll"] = false,
					["death_tooltip_width"] = 350,
					["time_type"] = 2,
					["default_bg_alpha"] = 0.5,
					["time_type_original"] = 2,
				},
			},
			["immersion_special_units"] = true,
			["deathlog_healingdone_min_arena"] = 400,
			["boss_mods_timers"] = {
				["encounter_timers_dbm"] = {
					["332687"] = {
						"332687", -- [1]
						"Timer332687cdcount	2", -- [2]
						"~Roar (2)", -- [3]
						31.9, -- [4]
						892447, -- [5]
						"cdcount", -- [6]
						332687, -- [7]
						2, -- [8]
						"2394", -- [9]
						["id"] = 2399,
					},
					["319626"] = {
						"319626", -- [1]
						"Timer319626cd", -- [2]
						"~Phantasmal Parasite", -- [3]
						3.3, -- [4]
						236298, -- [5]
						"cd", -- [6]
						319626, -- [7]
						3, -- [8]
						"2389", -- [9]
						["id"] = 2364,
					},
					["246220"] = {
						"246220", -- [1]
						"Timer246220next", -- [2]
						"Fel Bombardment", -- [3]
						9.7, -- [4]
						132212, -- [5]
						"next", -- [6]
						246220, -- [7]
						5, -- [8]
						"1992", -- [9]
						["id"] = 2076,
					},
					["323877"] = {
						"323877", -- [1]
						"Timer323877nextcount	1", -- [2]
						"Laser (1)", -- [3]
						8, -- [4]
						892834, -- [5]
						"nextcount", -- [6]
						323877, -- [7]
						2, -- [8]
						"2409", -- [9]
						["id"] = 2394,
					},
					["244057"] = {
						"244057", -- [1]
						"Timer244057cd", -- [2]
						"~Enflame Corruption", -- [3]
						48.3, -- [4]
						135822, -- [5]
						"cd", -- [6]
						244057, -- [7]
						3, -- [8]
						"1987", -- [9]
						["id"] = 2074,
					},
					["345397"] = {
						"345397", -- [1]
						"Timer345397cdcount	1", -- [2]
						"~Wave of Blood (1)", -- [3]
						12, -- [4]
						1035055, -- [5]
						"cdcount", -- [6]
						345397, -- [7]
						2, -- [8]
						"2393", -- [9]
						["id"] = 2398,
					},
					["331314"] = {
						"331314", -- [1]
						"Timer331314active", -- [2]
						"Destructive Impact ends", -- [3]
						12, -- [4]
						135860, -- [5]
						"active", -- [6]
						331314, -- [7]
						5, -- [8]
						"2394", -- [9]
						["id"] = 2399,
					},
					["153153"] = {
						"153153", -- [1]
						"Timer153153cd", -- [2]
						"~Dark Communion", -- [3]
						24, -- [4]
						632353, -- [5]
						"cd", -- [6]
						153153, -- [7]
						1, -- [8]
						"1139", -- [9]
						["id"] = 1677,
					},
					["244042"] = {
						"244042", -- [1]
						"Timer244042next", -- [2]
						"Marked Prey", -- [3]
						25.2, -- [4]
						458727, -- [5]
						"next", -- [6]
						244042, -- [7]
						3, -- [8]
						"1983", -- [9]
						["id"] = 2069,
					},
					["321009"] = {
						"321009", -- [1]
						"Timer321009cd	1", -- [2]
						"~Charged Spear", -- [3]
						3.6, -- [4]
						1508065, -- [5]
						"cd", -- [6]
						321009, -- [7]
						3, -- [8]
						"2399", -- [9]
						["id"] = 2357,
					},
					["244677"] = {
						"244677", -- [1]
						"Timer244677cd", -- [2]
						"~Transport Portal", -- [3]
						36.5, -- [4]
						459027, -- [5]
						"cd", -- [6]
						244677, -- [7]
						1, -- [8]
						"1985", -- [9]
						["id"] = 2064,
					},
					["324148"] = {
						"324148", -- [1]
						"Timer324148cd", -- [2]
						"~Dark Stride", -- [3]
						10.1, -- [4]
						132303, -- [5]
						"cd", -- [6]
						324148, -- [7]
						3, -- [8]
						"2416", -- [9]
						["id"] = 2356,
					},
					["107120"] = {
						"107120", -- [1]
						"Timer107120next", -- [2]
						"Frenzied Assault", -- [3]
						6, -- [4]
						132152, -- [5]
						"next", -- [6]
						107120, -- [7]
						5, -- [8]
						"676", -- [9]
						["id"] = 1406,
					},
					["320012"] = {
						"320012", -- [1]
						"Timer320012cd", -- [2]
						"~Unholy Frenzy", -- [3]
						6, -- [4]
						136224, -- [5]
						"cd", -- [6]
						320012, -- [7]
						5, -- [8]
						"2391", -- [9]
						["id"] = 2388,
					},
					["ej5081"] = {
						"ej5081", -- [1]
						"Timerej5081cd", -- [2]
						"~Fel Crystal", -- [3]
						15, -- [4]
						136170, -- [5]
						"cd", -- [6]
						"ej5081", -- [7]
						1, -- [8]
						"530", -- [9]
						["id"] = 1897,
					},
					["244410"] = {
						"244410", -- [1]
						"Timer244410next", -- [2]
						"Decimation", -- [3]
						15.8, -- [4]
						236216, -- [5]
						"next", -- [6]
						244410, -- [7]
						3, -- [8]
						"1992", -- [9]
						["id"] = 2076,
					},
					["320787"] = {
						"320787", -- [1]
						"Timer320787cd", -- [2]
						"~Summon Power Crystal", -- [3]
						7.4, -- [4]
						132776, -- [5]
						"cd", -- [6]
						320787, -- [7]
						5, -- [8]
						"2409", -- [9]
						["id"] = 2394,
					},
					["200227"] = {
						"200227", -- [1]
						"Timer200227cd", -- [2]
						"~Tangled Web", -- [3]
						35, -- [4]
						237431, -- [5]
						"cd", -- [6]
						200227, -- [7]
						3, -- [8]
						"1500", -- [9]
						["id"] = 1826,
					},
					["331634"] = {
						"331634", -- [1]
						"Timer331634cd", -- [2]
						"~Dark Recital", -- [3]
						24.5, -- [4]
						607854, -- [5]
						"cd", -- [6]
						331634, -- [7]
						3, -- [8]
						"2426", -- [9]
						["id"] = 2412,
					},
					["237590"] = {
						"237590", -- [1]
						"Timer237590cd", -- [2]
						"~Hopeless Reflection", -- [3]
						27, -- [4]
						1391776, -- [5]
						"cd", -- [6]
						237590, -- [7]
						3, -- [8]
						"1898", -- [9]
						["id"] = 2051,
					},
					["30496"] = {
						"30496", -- [1]
						"Timer30496next", -- [2]
						"Lesser Shadow Fissure", -- [3]
						8.3, -- [4]
						136160, -- [5]
						"next", -- [6]
						30496, -- [7]
						3, -- [8]
						"566", -- [9]
						["id"] = 1936,
					},
					["154135"] = {
						"154135", -- [1]
						"Timer154135cdcount	1", -- [2]
						"~Burst (1)", -- [3]
						20, -- [4]
						525026, -- [5]
						"cdcount", -- [6]
						154135, -- [7]
						2, -- [8]
						"966", -- [9]
						["id"] = 1699,
					},
					["322554"] = {
						"322554", -- [1]
						"Timer322554next", -- [2]
						"Castigate", -- [3]
						3.7, -- [4]
						458735, -- [5]
						"next", -- [6]
						322554, -- [7]
						3, -- [8]
						"2415", -- [9]
						["id"] = 2361,
					},
					["152801"] = {
						"152801", -- [1]
						"Timer152801cd", -- [2]
						"~Void Vortex", -- [3]
						23, -- [4]
						236296, -- [5]
						"cd", -- [6]
						152801, -- [7]
						2, -- [8]
						"1168", -- [9]
						["id"] = 1688,
					},
					["339690"] = {
						"339690", -- [1]
						"Timer339690cdcount3	1", -- [2]
						"~Crystalize (1)", -- [3]
						23.1, -- [4]
						132780, -- [5]
						"cdcount", -- [6]
						339690, -- [7]
						5, -- [8]
						"2425", -- [9]
						["id"] = 2417,
					},
					["234015"] = {
						"234015", -- [1]
						"Timer234015cdcount	2", -- [2]
						"~Tormenting Burst (2)", -- [3]
						17, -- [4]
						136123, -- [5]
						"cdcount", -- [6]
						234015, -- [7]
						2, -- [8]
						"1867", -- [9]
						["id"] = 2048,
					},
					["320102"] = {
						"320102", -- [1]
						"Timer320102cdcount	1", -- [2]
						"~Blood and Glory (1)", -- [3]
						33.9, -- [4]
						1322720, -- [5]
						"cdcount", -- [6]
						320102, -- [7]
						3, -- [8]
						"2390", -- [9]
						["id"] = 2366,
					},
					["ej22131"] = {
						"ej22131", -- [1]
						"Timerej22131nextcount	1", -- [2]
						"Crimson Cabalist (1)", -- [3]
						9.7, -- [4]
						3528307, -- [5]
						"nextcount", -- [6]
						"ej22131", -- [7]
						1, -- [8]
						"2424", -- [9]
						["id"] = 2407,
					},
					["118958"] = {
						"118958", -- [1]
						"Timer118958target	Glintrok Ironhide", -- [2]
						"Iron Protector: Glintrok Ironhide", -- [3]
						15, -- [4]
						134951, -- [5]
						"target", -- [6]
						118958, -- [7]
						0, -- [8]
						"690", -- [9]
						["id"] = 2129,
					},
					["319713"] = {
						"319713", -- [1]
						"Timer319713cd", -- [2]
						"~Juggernaut Rush", -- [3]
						15.5, -- [4]
						132335, -- [5]
						"cd", -- [6]
						319713, -- [7]
						3, -- [8]
						"2388", -- [9]
						["id"] = 2360,
					},
					["346654"] = {
						"346654", -- [1]
						"Timer346654cd", -- [2]
						"~Drain Essence", -- [3]
						15.5, -- [4]
						1003601, -- [5]
						"cd", -- [6]
						346654, -- [7]
						5, -- [8]
						"2426", -- [9]
						["id"] = 2412,
					},
					["239132"] = {
						"239132", -- [1]
						"Timer239132cdcount	1", -- [2]
						"~Rupture Realities (1)", -- [3]
						31, -- [4]
						135801, -- [5]
						"cdcount", -- [6]
						239132, -- [7]
						2, -- [8]
						"1873", -- [9]
						["id"] = 2038,
					},
					["246779"] = {
						"246779", -- [1]
						"Timer246779cd", -- [2]
						"~Diabolic Bomb", -- [3]
						11, -- [4]
						1097742, -- [5]
						"cd", -- [6]
						246779, -- [7]
						3, -- [8]
						"2004", -- [9]
						["id"] = 2088,
					},
					["ej21953"] = {
						"ej21953", -- [1]
						"Timerej21953cdcount	1", -- [2]
						"~Soul Infuser (1)", -- [3]
						130, -- [4]
						607854, -- [5]
						"cdcount", -- [6]
						"ej21953", -- [7]
						1, -- [8]
						"2422", -- [9]
						["id"] = 2402,
					},
					["323437"] = {
						"323437", -- [1]
						"Timer323437cd", -- [2]
						"~Stigma of Pride", -- [3]
						10, -- [4]
						538039, -- [5]
						"cd", -- [6]
						323437, -- [7]
						5, -- [8]
						"2413", -- [9]
						["id"] = 2381,
					},
					["342425"] = {
						"342425", -- [1]
						"Timer342425cdcount	1", -- [2]
						"~Stone Fist (1)", -- [3]
						26.4, -- [4]
						136225, -- [5]
						"cdcount", -- [6]
						342425, -- [7]
						5, -- [8]
						"2425", -- [9]
						["id"] = 2417,
					},
					["153764"] = {
						"153764", -- [1]
						"Timer153764next", -- [2]
						"Claws of Argus", -- [3]
						34, -- [4]
						136157, -- [5]
						"next", -- [6]
						153764, -- [7]
						6, -- [8]
						"1216", -- [9]
						["id"] = 1678,
					},
					["153396"] = {
						"153396", -- [1]
						"Timer153396next", -- [2]
						"Curtain of Flame", -- [3]
						16, -- [4]
						135793, -- [5]
						"next", -- [6]
						153396, -- [7]
						3, -- [8]
						"1216", -- [9]
						["id"] = 1678,
					},
					["119922"] = {
						"119922", -- [1]
						"Timer119922cd", -- [2]
						"~Shockwave", -- [3]
						19, -- [4]
						451165, -- [5]
						"cd", -- [6]
						119922, -- [7]
						3, -- [8]
						"708", -- [9]
						["id"] = 1442,
					},
					["325361"] = {
						"325361", -- [1]
						"Timer325361target2	Tawariel", -- [2]
						"Glyph of Destruction: Tawariel", -- [3]
						4, -- [4]
						236219, -- [5]
						"target", -- [6]
						325361, -- [7]
						2, -- [8]
						"2418", -- [9]
						["id"] = 2405,
					},
					["323810"] = {
						"323810", -- [1]
						"Timer323810cd", -- [2]
						"~Piercing Blur", -- [3]
						10.6, -- [4]
						1029589, -- [5]
						"cd", -- [6]
						323810, -- [7]
						3, -- [8]
						"2407", -- [9]
						["id"] = 2363,
					},
					["251570"] = {
						"251570", -- [1]
						"Timer251570next", -- [2]
						"Soulbomb", -- [3]
						30.3, -- [4]
						1778228, -- [5]
						"next", -- [6]
						251570, -- [7]
						3, -- [8]
						"2031", -- [9]
						["id"] = 2092,
					},
					["334488"] = {
						"334488", -- [1]
						"Timer334488cd", -- [2]
						"~Sever Flesh", -- [3]
						6, -- [4]
						3616005, -- [5]
						"cd", -- [6]
						334488, -- [7]
						5, -- [8]
						"2392", -- [9]
						["id"] = 2389,
					},
					["123655"] = {
						"123655", -- [1]
						"Timer123655target	Hadir", -- [2]
						"Traumatic Blow: Hadir", -- [3]
						5, -- [4]
						132355, -- [5]
						"target", -- [6]
						123655, -- [7]
						0, -- [8]
						"708", -- [9]
						["id"] = 1442,
					},
					["154671"] = {
						"154671", -- [1]
						"Timer154671cd", -- [2]
						"~Ritual of Bones", -- [3]
						20, -- [4]
						136243, -- [5]
						"cd", -- [6]
						154671, -- [7]
						1, -- [8]
						"1160", -- [9]
						["id"] = 1682,
					},
					["320596"] = {
						"320596", -- [1]
						"Timer320596cd", -- [2]
						"~Heaving Retch", -- [3]
						10.6, -- [4]
						136182, -- [5]
						"cd", -- [6]
						320596, -- [7]
						3, -- [8]
						"2395", -- [9]
						["id"] = 2387,
					},
					["332619"] = {
						"332619", -- [1]
						"Timer332619cdcount	1", -- [2]
						"~Shattering Pain (1)", -- [3]
						13.3, -- [4]
						1357802, -- [5]
						"cdcount", -- [6]
						332619, -- [7]
						5, -- [8]
						"2424", -- [9]
						["id"] = 2407,
					},
					["333493"] = {
						"333493", -- [1]
						"Timer333493cd", -- [2]
						"~Necrotic Breath", -- [3]
						29.4, -- [4]
						2576093, -- [5]
						"cd", -- [6]
						333493, -- [7]
						3, -- [8]
						"2391", -- [9]
						["id"] = 2388,
					},
					["153006"] = {
						"153006", -- [1]
						"Timer153006next", -- [2]
						"Consecrated Light", -- [3]
						7, -- [4]
						135981, -- [5]
						"next", -- [6]
						153006, -- [7]
						2, -- [8]
						"1185", -- [9]
						["id"] = 1686,
					},
					["240319"] = {
						"240319", -- [1]
						"Timer240319next", -- [2]
						"Hatching", -- [3]
						30.5, -- [4]
						132832, -- [5]
						"next", -- [6]
						240319, -- [7]
						1, -- [8]
						"1856", -- [9]
						["id"] = 2036,
					},
					["324427"] = {
						"324427", -- [1]
						"Timer324427cd", -- [2]
						"~Empyreal Ordnance", -- [3]
						16.9, -- [4]
						1405806, -- [5]
						"cd", -- [6]
						324427, -- [7]
						3, -- [8]
						"2414", -- [9]
						["id"] = 2358,
					},
					["153804"] = {
						"153804", -- [1]
						"Timer153804cd", -- [2]
						"~Inhale", -- [3]
						27.1, -- [4]
						463565, -- [5]
						"cd", -- [6]
						153804, -- [7]
						6, -- [8]
						"1140", -- [9]
						["id"] = 1679,
					},
					["346762"] = {
						"346762", -- [1]
						"Timer346762cd", -- [2]
						"~Soul Spikes", -- [3]
						32.1, -- [4]
						3259845, -- [5]
						"cd", -- [6]
						346762, -- [7]
						3, -- [8]
						"2426", -- [9]
						["id"] = 2412,
					},
					["327227"] = {
						"327227", -- [1]
						"Timer327227cdcount	1", -- [2]
						"~Ravage (1)", -- [3]
						53.2, -- [4]
						136129, -- [5]
						"cdcount", -- [6]
						327227, -- [7]
						2, -- [8]
						"2424", -- [9]
						["id"] = 2407,
					},
					["322908"] = {
						"322908", -- [1]
						"Timer322908next", -- [2]
						"Backdraft", -- [3]
						18.2, -- [4]
						1029595, -- [5]
						"next", -- [6]
						322908, -- [7]
						2, -- [8]
						"2412", -- [9]
						["id"] = 2359,
					},
					["322304"] = {
						"322304", -- [1]
						"Timer322304cd", -- [2]
						"~Malignant Growth", -- [3]
						5.6, -- [4]
						2576086, -- [5]
						"cd", -- [6]
						322304, -- [7]
						1, -- [8]
						"2404", -- [9]
						["id"] = 2386,
					},
					["236072"] = {
						"236072", -- [1]
						"Timer236072nextcount	1", -- [2]
						"Wailing Souls (1)", -- [3]
						59.4, -- [4]
						136194, -- [5]
						"nextcount", -- [6]
						236072, -- [7]
						2, -- [8]
						"1896", -- [9]
						["id"] = 2054,
					},
					["233062"] = {
						"233062", -- [1]
						"Timer233062next", -- [2]
						"Infernal Burning", -- [3]
						54, -- [4]
						135802, -- [5]
						"next", -- [6]
						233062, -- [7]
						2, -- [8]
						"1862", -- [9]
						["id"] = 2032,
					},
					["325245"] = {
						"325245", -- [1]
						"Timer325245cd", -- [2]
						"~Shadow Ambush", -- [3]
						6.1, -- [4]
						1305160, -- [5]
						"cd", -- [6]
						325245, -- [7]
						3, -- [8]
						"2423", -- [9]
						["id"] = 2385,
					},
					["329509"] = {
						"329509", -- [1]
						"Timer329509cd", -- [2]
						"~Blazing Surge", -- [3]
						28.8, -- [4]
						524795, -- [5]
						"cd", -- [6]
						329509, -- [7]
						3, -- [8]
						"2422", -- [9]
						["id"] = 2402,
					},
					["322574"] = {
						"322574", -- [1]
						"Timer322574cd", -- [2]
						"~Coalesce Manifestation", -- [3]
						14.6, -- [4]
						132331, -- [5]
						"cd", -- [6]
						322574, -- [7]
						1, -- [8]
						"2415", -- [9]
						["id"] = 2361,
					},
					["325064"] = {
						"325064", -- [1]
						"Timer325064cd", -- [2]
						"~Beam", -- [3]
						29.1, -- [4]
						3684828, -- [5]
						"cd", -- [6]
						325064, -- [7]
						3, -- [8]
						"2420", -- [9]
						["id"] = 2406,
					},
					["321894"] = {
						"321894", -- [1]
						"Timer321894cd", -- [2]
						"~Dark Exile", -- [3]
						26.5, -- [4]
						2576087, -- [5]
						"cd", -- [6]
						321894, -- [7]
						3, -- [8]
						"2396", -- [9]
						["id"] = 2390,
					},
					["107140"] = {
						"107140", -- [1]
						"Timer107140cd", -- [2]
						"~Magnetic Shroud", -- [3]
						20, -- [4]
						132488, -- [5]
						"cd", -- [6]
						107140, -- [7]
						0, -- [8]
						"673", -- [9]
						["id"] = 1303,
					},
					["246329"] = {
						"246329", -- [1]
						"Timer246329cd", -- [2]
						"~Shadow Blades", -- [3]
						10.9, -- [4]
						135855, -- [5]
						"cd", -- [6]
						246329, -- [7]
						3, -- [8]
						"1986", -- [9]
						["id"] = 2073,
					},
					["332683"] = {
						"332683", -- [1]
						"Timer332683cast", -- [2]
						"Shattering Blast ", -- [3]
						5, -- [4]
						1519262, -- [5]
						"cast", -- [6]
						332683, -- [7]
						2, -- [8]
						"2425", -- [9]
						["id"] = 2417,
					},
					["239153"] = {
						"239153", -- [1]
						"Timer239153cd", -- [2]
						"~Spontaneous Fragmentation", -- [3]
						10, -- [4]
						429590, -- [5]
						"cd", -- [6]
						239153, -- [7]
						5, -- [8]
						"1897", -- [9]
						["id"] = 2052,
					},
					["334266"] = {
						"334266", -- [1]
						"Timer334266nextcount	1", -- [2]
						"Beam (1)", -- [3]
						10.1, -- [4]
						342917, -- [5]
						"nextcount", -- [6]
						334266, -- [7]
						3, -- [8]
						"2428", -- [9]
						["id"] = 2383,
					},
					["324667"] = {
						"324667", -- [1]
						"Timer324667next", -- [2]
						"Slime Wave", -- [3]
						7, -- [4]
						132104, -- [5]
						"next", -- [6]
						324667, -- [7]
						5, -- [8]
						"2419", -- [9]
						["id"] = 2382,
					},
					["157168"] = {
						"157168", -- [1]
						"Timer157168target3	Sckug-Ner'zhul", -- [2]
						"Fixate: Sckug-Ner'zhul", -- [3]
						12, -- [4]
						841383, -- [5]
						"target", -- [6]
						157168, -- [7]
						3, -- [8]
						"1225", -- [9]
						["id"] = 1714,
					},
					["342863"] = {
						"342863", -- [1]
						"Timer342863cd", -- [2]
						"~Screech", -- [3]
						28, -- [4]
						136116, -- [5]
						"cd", -- [6]
						342863, -- [7]
						3, -- [8]
						"2393", -- [9]
						["id"] = 2398,
					},
					["238502"] = {
						"238502", -- [1]
						"Timer238502cdcount	1", -- [2]
						"~Focused Dreadflame (1)", -- [3]
						31.8, -- [4]
						236216, -- [5]
						"cdcount", -- [6]
						238502, -- [7]
						3, -- [8]
						"1898", -- [9]
						["id"] = 2051,
					},
					["232913"] = {
						"232913", -- [1]
						"Timer232913cd", -- [2]
						"~Befouling Ink", -- [3]
						11.6, -- [4]
						1500933, -- [5]
						"cd", -- [6]
						232913, -- [7]
						3, -- [8]
						"1861", -- [9]
						["id"] = 2037,
					},
					["321226"] = {
						"321226", -- [1]
						"Timer321226cd", -- [2]
						"~Land of the Dead", -- [3]
						8.6, -- [4]
						136179, -- [5]
						"cd", -- [6]
						321226, -- [7]
						1, -- [8]
						"2391", -- [9]
						["id"] = 2388,
					},
					["321873"] = {
						"321873", -- [1]
						"Timer321873cd", -- [2]
						"~Freeze Tag", -- [3]
						18.4, -- [4]
						1698698, -- [5]
						"cd", -- [6]
						321873, -- [7]
						3, -- [8]
						"2402", -- [9]
						["id"] = 2392,
					},
					["320655"] = {
						"320655", -- [1]
						"Timer320655cd", -- [2]
						"~Crunch", -- [3]
						5, -- [4]
						132358, -- [5]
						"cd", -- [6]
						320655, -- [7]
						5, -- [8]
						"2395", -- [9]
						["id"] = 2387,
					},
					["344496"] = {
						"344496", -- [1]
						"Timer344496cdcount3	1", -- [2]
						"~Eruption (1)", -- [3]
						29.4, -- [4]
						2101174, -- [5]
						"cdcount", -- [6]
						344496, -- [7]
						3, -- [8]
						"2425", -- [9]
						["id"] = 2417,
					},
					["251447"] = {
						"251447", -- [1]
						"Timer251447cd", -- [2]
						"~Corrupting Maw", -- [3]
						8.9, -- [4]
						136126, -- [5]
						"cd", -- [6]
						251447, -- [7]
						5, -- [8]
						"1987", -- [9]
						["id"] = 2074,
					},
					["32358"] = {
						"32358", -- [1]
						"Timer32358active", -- [2]
						"Dark Shell ends", -- [3]
						7, -- [4]
						136121, -- [5]
						"active", -- [6]
						32358, -- [7]
						5, -- [8]
						"534", -- [9]
						["id"] = 1900,
					},
					["247376"] = {
						"247376", -- [1]
						"Timer247376cd", -- [2]
						"~Pulse Grenade", -- [3]
						12.5, -- [4]
						133009, -- [5]
						"cd", -- [6]
						247376, -- [7]
						3, -- [8]
						"2009", -- [9]
						["id"] = 2082,
					},
					["244722"] = {
						"244722", -- [1]
						"Timer244722cd", -- [2]
						"~Shock Grenade", -- [3]
						15, -- [4]
						133009, -- [5]
						"cd", -- [6]
						244722, -- [7]
						3, -- [8]
						"1997", -- [9]
						["id"] = 2070,
					},
					["319654"] = {
						"319654", -- [1]
						"Timer319654cd", -- [2]
						"~Hungering Drain", -- [3]
						10.7, -- [4]
						571321, -- [5]
						"cd", -- [6]
						319654, -- [7]
						4, -- [8]
						"2388", -- [9]
						["id"] = 2360,
					},
					["247923"] = {
						"247923", -- [1]
						"Timer247923cdcount	1", -- [2]
						"~Shrapnel Blast (1)", -- [3]
						12, -- [4]
						133710, -- [5]
						"cdcount", -- [6]
						247923, -- [7]
						3, -- [8]
						"2009", -- [9]
						["id"] = 2082,
					},
					["320141"] = {
						"320141", -- [1]
						"Timer320141next", -- [2]
						"Doom!!!", -- [3]
						45.5, -- [4]
						136129, -- [5]
						"next", -- [6]
						320141, -- [7]
						2, -- [8]
						"2409", -- [9]
						["id"] = 2394,
					},
					["323143"] = {
						"323143", -- [1]
						"Timer323143cd", -- [2]
						"~Telekinetic Toss", -- [3]
						6, -- [4]
						135822, -- [5]
						"cd", -- [6]
						323143, -- [7]
						3, -- [8]
						"2413", -- [9]
						["id"] = 2381,
					},
					["254452"] = {
						"254452", -- [1]
						"Timer254452cd", -- [2]
						"~Ravenous Blaze", -- [3]
						4, -- [4]
						525024, -- [5]
						"cd", -- [6]
						254452, -- [7]
						3, -- [8]
						"1984", -- [9]
						["id"] = 2063,
					},
					["244131"] = {
						"244131", -- [1]
						"Timer244131cd", -- [2]
						"~Consuming Sphere", -- [3]
						48.3, -- [4]
						237016, -- [5]
						"cd", -- [6]
						244131, -- [7]
						3, -- [8]
						"1987", -- [9]
						["id"] = 2074,
					},
					["239739"] = {
						"239739", -- [1]
						"Timer239739nextcount	1", -- [2]
						"Dark Mark (1)", -- [3]
						31.6, -- [4]
						633004, -- [5]
						"nextcount", -- [6]
						239739, -- [7]
						3, -- [8]
						"1873", -- [9]
						["id"] = 2038,
					},
					["334404"] = {
						"334404", -- [1]
						"Timer334404cd", -- [2]
						"~Spreadshot", -- [3]
						6, -- [4]
						132208, -- [5]
						"cd", -- [6]
						334404, -- [7]
						2, -- [8]
						"2429", -- [9]
						["id"] = 2418,
					},
					["243999"] = {
						"243999", -- [1]
						"Timer243999cd", -- [2]
						"~Dark Fissure", -- [3]
						17.4, -- [4]
						136201, -- [5]
						"cd", -- [6]
						243999, -- [7]
						3, -- [8]
						"1983", -- [9]
						["id"] = 2069,
					},
					["331209"] = {
						"331209", -- [1]
						"Timer331209cdcount	1", -- [2]
						"~Hateful Gaze (1)", -- [3]
						50.1, -- [4]
						136215, -- [5]
						"cdcount", -- [6]
						331209, -- [7]
						3, -- [8]
						"2394", -- [9]
						["id"] = 2399,
					},
					["323845"] = {
						"323845", -- [1]
						"Timer323845cd", -- [2]
						"~Wicked Rush", -- [3]
						5.7, -- [4]
						589068, -- [5]
						"cd", -- [6]
						323845, -- [7]
						3, -- [8]
						"2407", -- [9]
						["id"] = 2363,
					},
					["244093"] = {
						"244093", -- [1]
						"Timer244093next", -- [2]
						"Necrotic Embrace", -- [3]
						35, -- [4]
						1029009, -- [5]
						"next", -- [6]
						244093, -- [7]
						3, -- [8]
						"1983", -- [9]
						["id"] = 2069,
					},
					["234621"] = {
						"234621", -- [1]
						"Timer234621cdcount	1", -- [2]
						"~Devouring Maw (1)", -- [3]
						40, -- [4]
						463487, -- [5]
						"cdcount", -- [6]
						234621, -- [7]
						3, -- [8]
						"1861", -- [9]
						["id"] = 2037,
					},
					["325725"] = {
						"325725", -- [1]
						"Timer325725cdcount	1", -- [2]
						"~Cosmic Artifice (1)", -- [3]
						3.7, -- [4]
						1033912, -- [5]
						"cdcount", -- [6]
						325725, -- [7]
						3, -- [8]
						"2410", -- [9]
						["id"] = 2396,
					},
					["322746"] = {
						"322746", -- [1]
						"Timer322746cd", -- [2]
						"~Corrupted Blood", -- [3]
						8.5, -- [4]
						136133, -- [5]
						"cd", -- [6]
						322746, -- [7]
						3, -- [8]
						"2408", -- [9]
						["id"] = 2395,
					},
					["324205"] = {
						"324205", -- [1]
						"Timer324205cd", -- [2]
						"~Blinding Flash", -- [3]
						15.7, -- [4]
						1029583, -- [5]
						"cd", -- [6]
						324205, -- [7]
						3, -- [8]
						"2416", -- [9]
						["id"] = 2356,
					},
					["240396"] = {
						"240396", -- [1]
						"Timer240396nextcount	1", -- [2]
						"Rain of the Destroyer (1)", -- [3]
						15, -- [4]
						135803, -- [5]
						"nextcount", -- [6]
						240396, -- [7]
						3, -- [8]
						"1873", -- [9]
						["id"] = 2038,
					},
					["107047"] = {
						"107047", -- [1]
						"Timer107047cd", -- [2]
						"~Impaling Strike", -- [3]
						25.5, -- [4]
						132105, -- [5]
						"cd", -- [6]
						107047, -- [7]
						0, -- [8]
						"675", -- [9]
						["id"] = 1405,
					},
					["32361"] = {
						"32361", -- [1]
						"Timer32361target	Shadowfiend", -- [2]
						"Crystal Prison: Shadowfiend", -- [3]
						5, -- [4]
						135988, -- [5]
						"target", -- [6]
						32361, -- [7]
						3, -- [8]
						"535", -- [9]
						["id"] = 1901,
					},
					["232827"] = {
						"232827", -- [1]
						"Timer232827cdcount	1", -- [2]
						"~Crashing Wave (1)", -- [3]
						30, -- [4]
						135861, -- [5]
						"cdcount", -- [6]
						232827, -- [7]
						3, -- [8]
						"1861", -- [9]
						["id"] = 2037,
					},
					["335354"] = {
						"335354", -- [1]
						"Timer335354cdcount	1", -- [2]
						"~Chain Slam (1)", -- [3]
						28.3, -- [4]
						132507, -- [5]
						"cdcount", -- [6]
						335354, -- [7]
						3, -- [8]
						"2394", -- [9]
						["id"] = 2399,
					},
					["313606"] = {
						"313606", -- [1]
						"Timer313606cd", -- [2]
						"~Flight", -- [3]
						30.5, -- [4]
						135737, -- [5]
						"cd", -- [6]
						313606, -- [7]
						6, -- [8]
						"2399", -- [9]
						["id"] = 2357,
					},
					["ej5973"] = {
						"ej5973", -- [1]
						"Timerej5973cd", -- [2]
						"~Circle of Flame", -- [3]
						8, -- [4]
						236216, -- [5]
						"cd", -- [6]
						"ej5973", -- [7]
						3, -- [8]
						"698", -- [9]
						["id"] = 1441,
					},
					["106877"] = {
						"106877", -- [1]
						"Timer106877next", -- [2]
						"Sha Spike", -- [3]
						9, -- [4]
						628268, -- [5]
						"next", -- [6]
						106877, -- [7]
						0, -- [8]
						"685", -- [9]
						["id"] = 1305,
					},
					["323730"] = {
						"323730", -- [1]
						"Timer323730cd", -- [2]
						"~Frozen Binds", -- [3]
						8.9, -- [4]
						135834, -- [5]
						"cd", -- [6]
						323730, -- [7]
						3, -- [8]
						"2396", -- [9]
						["id"] = 2390,
					},
					["244152"] = {
						"244152", -- [1]
						"Timer244152cast", -- [2]
						"Apocalypse Drive ", -- [3]
						30, -- [4]
						1122135, -- [5]
						"cast", -- [6]
						244152, -- [7]
						6, -- [8]
						"1992", -- [9]
						["id"] = 2076,
					},
					["153954"] = {
						"153954", -- [1]
						"Timer153954cd", -- [2]
						"~Cast Down", -- [3]
						15, -- [4]
						1029578, -- [5]
						"cd", -- [6]
						153954, -- [7]
						1, -- [8]
						"968", -- [9]
						["id"] = 1701,
					},
					["332794"] = {
						"332794", -- [1]
						"Timer332794cdcount	1", -- [2]
						"~Fatal Finesse (1)", -- [3]
						17.4, -- [4]
						1357795, -- [5]
						"cdcount", -- [6]
						332794, -- [7]
						3, -- [8]
						"2424", -- [9]
						["id"] = 2407,
					},
					["106923"] = {
						"106923", -- [1]
						"Timer106923next", -- [2]
						"Static Field", -- [3]
						18, -- [4]
						136050, -- [5]
						"next", -- [6]
						106923, -- [7]
						3, -- [8]
						"673", -- [9]
						["id"] = 1303,
					},
					["236712"] = {
						"236712", -- [1]
						"Timer236712cd", -- [2]
						"~Lunar Beacon", -- [3]
						18, -- [4]
						429383, -- [5]
						"cd", -- [6]
						236712, -- [7]
						3, -- [8]
						"1903", -- [9]
						["id"] = 2050,
					},
					["319592"] = {
						"319592", -- [1]
						"Timer319592cd", -- [2]
						"~Stone Shattering Leap", -- [3]
						20.6, -- [4]
						1016245, -- [5]
						"cd", -- [6]
						319592, -- [7]
						3, -- [8]
						"2387", -- [9]
						["id"] = 2380,
					},
					["336258"] = {
						"336258", -- [1]
						"Timer336258fades", -- [2]
						"Solitary Prey fades", -- [3]
						6, -- [4]
						892448, -- [5]
						"fades", -- [6]
						336258, -- [7]
						5, -- [8]
						"2423", -- [9]
						["id"] = 2385,
					},
					["326851"] = {
						"326851", -- [1]
						"Timer326851cdcount	1", -- [2]
						"~Blood Price (1)", -- [3]
						22.3, -- [4]
						1035055, -- [5]
						"cdcount", -- [6]
						326851, -- [7]
						2, -- [8]
						"2424", -- [9]
						["id"] = 2407,
					},
					["155327"] = {
						"155327", -- [1]
						"Timer155327cd", -- [2]
						"~Soul Vessel", -- [3]
						20, -- [4]
						136213, -- [5]
						"cd", -- [6]
						155327, -- [7]
						6, -- [8]
						"1186", -- [9]
						["id"] = 1685,
					},
					["ej21993"] = {
						"ej21993", -- [1]
						"Timerej21993cdcount	1", -- [2]
						"~Bleakwing Assassin (1)", -- [3]
						70, -- [4]
						3565724, -- [5]
						"cdcount", -- [6]
						"ej21993", -- [7]
						1, -- [8]
						"2422", -- [9]
						["id"] = 2402,
					},
					["329951"] = {
						"329951", -- [1]
						"Timer329951nextcount	1", -- [2]
						"Impale (1)", -- [3]
						27.5, -- [4]
						1357795, -- [5]
						"nextcount", -- [6]
						329951, -- [7]
						3, -- [8]
						"2424", -- [9]
						["id"] = 2407,
					},
					["244000"] = {
						"244000", -- [1]
						"Timer244000cd", -- [2]
						"~Felstorm Barrage", -- [3]
						25.2, -- [4]
						1122135, -- [5]
						"cd", -- [6]
						244000, -- [7]
						3, -- [8]
						"1985", -- [9]
						["id"] = 2064,
					},
					["241564"] = {
						"241564", -- [1]
						"Timer241564cd", -- [2]
						"~Sorrowful Wail", -- [3]
						15.2, -- [4]
						460857, -- [5]
						"cd", -- [6]
						241564, -- [7]
						2, -- [8]
						"1898", -- [9]
						["id"] = 2051,
					},
					["230139"] = {
						"230139", -- [1]
						"Timer230139cdcount	1", -- [2]
						"~Hydra Shot (1)", -- [3]
						25.2, -- [4]
						133578, -- [5]
						"cdcount", -- [6]
						230139, -- [7]
						3, -- [8]
						"1861", -- [9]
						["id"] = 2037,
					},
					["233272"] = {
						"233272", -- [1]
						"Timer233272nextcount	1", -- [2]
						"Shattering Star (1)", -- [3]
						34, -- [4]
						517112, -- [5]
						"nextcount", -- [6]
						233272, -- [7]
						3, -- [8]
						"1862", -- [9]
						["id"] = 2032,
					},
					["322614"] = {
						"322614", -- [1]
						"Timer322614cd", -- [2]
						"~Mind Link", -- [3]
						18.1, -- [4]
						3528276, -- [5]
						"cd", -- [6]
						322614, -- [7]
						3, -- [8]
						"2405", -- [9]
						["id"] = 2393,
					},
					["250333"] = {
						"250333", -- [1]
						"Timer250333cast", -- [2]
						"Torment of Khaz'goroth ", -- [3]
						85, -- [4]
						615339, -- [5]
						"cast", -- [6]
						250333, -- [7]
						6, -- [8]
						"1986", -- [9]
						["id"] = 2073,
					},
					["168375"] = {
						"168375", -- [1]
						"Timer168375next", -- [2]
						"Grasping Vine", -- [3]
						30.4, -- [4]
						959842, -- [5]
						"next", -- [6]
						168375, -- [7]
						3, -- [8]
						"1207", -- [9]
						["id"] = 1757,
					},
					["150755"] = {
						"150755", -- [1]
						"Timer150755cd", -- [2]
						"~Summon Unstable Slag", -- [3]
						20, -- [4]
						135790, -- [5]
						"cd", -- [6]
						150755, -- [7]
						1, -- [8]
						"889", -- [9]
						["id"] = 1654,
					},
					["119981"] = {
						"119981", -- [1]
						"Timer119981cd", -- [2]
						"~Whirling Dervish", -- [3]
						22, -- [4]
						132845, -- [5]
						"cd", -- [6]
						119981, -- [7]
						0, -- [8]
						"708", -- [9]
						["id"] = 1442,
					},
					["333231"] = {
						"333231", -- [1]
						"Timer333231cd", -- [2]
						"~Searing Death", -- [3]
						10.2, -- [4]
						2576089, -- [5]
						"cd", -- [6]
						333231, -- [7]
						3, -- [8]
						"2397", -- [9]
						["id"] = 2391,
					},
					["342280"] = {
						"342280", -- [1]
						"Timer342280cd", -- [2]
						"~Bottled Anima", -- [3]
						19.4, -- [4]
						3684825, -- [5]
						"cd", -- [6]
						342280, -- [7]
						3, -- [8]
						"2420", -- [9]
						["id"] = 2406,
					},
					["244768"] = {
						"244768", -- [1]
						"Timer244768cd", -- [2]
						"~Desolate Gaze", -- [3]
						78, -- [4]
						236301, -- [5]
						"cd", -- [6]
						244768, -- [7]
						3, -- [8]
						"1987", -- [9]
						["id"] = 2074,
					},
					["328921"] = {
						"328921", -- [1]
						"Timer328921cd", -- [2]
						"~Blood Shroud", -- [3]
						112, -- [4]
						538040, -- [5]
						"cd", -- [6]
						328921, -- [7]
						6, -- [8]
						"2393", -- [9]
						["id"] = 2398,
					},
					["153002"] = {
						"153002", -- [1]
						"Timer153002next", -- [2]
						"Holy Shield", -- [3]
						30, -- [4]
						135874, -- [5]
						"next", -- [6]
						153002, -- [7]
						3, -- [8]
						"1185", -- [9]
						["id"] = 1686,
					},
					["327608"] = {
						"327608", -- [1]
						"Timer327608cd", -- [2]
						"~Beckon Slime", -- [3]
						25, -- [4]
						3459153, -- [5]
						"cd", -- [6]
						327608, -- [7]
						1, -- [8]
						"2419", -- [9]
						["id"] = 2382,
					},
					["112944"] = {
						"112944", -- [1]
						"Timer112944next", -- [2]
						"Carrot Breath", -- [3]
						18, -- [4]
						134010, -- [5]
						"next", -- [6]
						112944, -- [7]
						0, -- [8]
						"669", -- [9]
						["id"] = 1413,
					},
					["253520"] = {
						"253520", -- [1]
						"Timer253520next", -- [2]
						"Fulminating Pulse", -- [3]
						20.3, -- [4]
						514018, -- [5]
						"next", -- [6]
						253520, -- [7]
						3, -- [8]
						"1986", -- [9]
						["id"] = 2073,
					},
					["235267"] = {
						"235267", -- [1]
						"Timer235267nextcount	2", -- [2]
						"Mass Instability (2)", -- [3]
						22, -- [4]
						535593, -- [5]
						"nextcount", -- [6]
						235267, -- [7]
						3, -- [8]
						"1897", -- [9]
						["id"] = 2052,
					},
					["118961"] = {
						"118961", -- [1]
						"Timer118961target	Uwont-Sargeras", -- [2]
						"Chase Down: Uwont-Sargeras", -- [3]
						11, -- [4]
						461121, -- [5]
						"target", -- [6]
						118961, -- [7]
						0, -- [8]
						"657", -- [9]
						["id"] = 1304,
					},
					["321948"] = {
						"321948", -- [1]
						"Timer321948cd", -- [2]
						"~Localized Explosion", -- [3]
						14.3, -- [4]
						236214, -- [5]
						"cd", -- [6]
						321948, -- [7]
						3, -- [8]
						"2398", -- [9]
						["id"] = 2400,
					},
					["236544"] = {
						"236544", -- [1]
						"Timer236544cd", -- [2]
						"~Doomed Sundering", -- [3]
						18, -- [4]
						1033912, -- [5]
						"cd", -- [6]
						236544, -- [7]
						5, -- [8]
						"1896", -- [9]
						["id"] = 2054,
					},
					["235230"] = {
						"235230", -- [1]
						"Timer235230cdcount	1", -- [2]
						"~Fel Squall (1)", -- [3]
						35, -- [4]
						841219, -- [5]
						"cdcount", -- [6]
						235230, -- [7]
						2, -- [8]
						"1867", -- [9]
						["id"] = 2048,
					},
					["ej12489"] = {
						"ej12489", -- [1]
						"Timerej12489next", -- [2]
						"Dread Felbat", -- [3]
						20, -- [4]
						132182, -- [5]
						"next", -- [6]
						"ej12489", -- [7]
						1, -- [8]
						"1499", -- [9]
						["id"] = 1828,
					},
					["327664"] = {
						"327664", -- [1]
						"Timer327664cd", -- [2]
						"~Embalming Ichor", -- [3]
						9.7, -- [4]
						1001622, -- [5]
						"cd", -- [6]
						327664, -- [7]
						3, -- [8]
						"2392", -- [9]
						["id"] = 2389,
					},
					["341621"] = {
						"341621", -- [1]
						"Timer341621cd", -- [2]
						"~Expose Desires", -- [3]
						12.1, -- [4]
						3684826, -- [5]
						"cd", -- [6]
						341621, -- [7]
						5, -- [8]
						"2420", -- [9]
						["id"] = 2406,
					},
					["232192"] = {
						"232192", -- [1]
						"Timer232192next", -- [2]
						"Commanding Roar", -- [3]
						17.3, -- [4]
						642418, -- [5]
						"next", -- [6]
						232192, -- [7]
						1, -- [8]
						"1856", -- [9]
						["id"] = 2036,
					},
					["320823"] = {
						"320823", -- [1]
						"Timer320823cd", -- [2]
						"~Experimental Squirrel Bomb", -- [3]
						7.9, -- [4]
						133709, -- [5]
						"cd", -- [6]
						320823, -- [7]
						5, -- [8]
						"2409", -- [9]
						["id"] = 2394,
					},
					["197810"] = {
						"197810", -- [1]
						"Timer197810cd", -- [2]
						"~Wicked Slam", -- [3]
						35.8, -- [4]
						1109118, -- [5]
						"cd", -- [6]
						197810, -- [7]
						2, -- [8]
						"1499", -- [9]
						["id"] = 1828,
					},
					["332313"] = {
						"332313", -- [1]
						"Timer332313cd", -- [2]
						"~Brood Assassins", -- [3]
						15.2, -- [4]
						1370997, -- [5]
						"cd", -- [6]
						332313, -- [7]
						1, -- [8]
						"2423", -- [9]
						["id"] = 2385,
					},
					["325506"] = {
						"325506", -- [1]
						"Timer325506cdcount	1	Creature-0-4230-2296-5369-165764-00001A273B", -- [2]
						"~Concussive Smash (1)", -- [3]
						24.1, -- [4]
						1016245, -- [5]
						"cdcount", -- [6]
						325506, -- [7]
						5, -- [8]
						"2422", -- [9]
						["id"] = 2402,
					},
					["239207"] = {
						"239207", -- [1]
						"Timer239207cdcount	1", -- [2]
						"~Touch of Sargeras (1)", -- [3]
						14.5, -- [4]
						840404, -- [5]
						"cdcount", -- [6]
						239207, -- [7]
						3, -- [8]
						"1873", -- [9]
						["id"] = 2038,
					},
					["329217"] = {
						"329217", -- [1]
						"Timer329217cd", -- [2]
						"~Slime Lunge", -- [3]
						33.2, -- [4]
						451165, -- [5]
						"cd", -- [6]
						329217, -- [7]
						3, -- [8]
						"2403", -- [9]
						["id"] = 2384,
					},
					["327616"] = {
						"327616", -- [1]
						"Timer327616cd", -- [2]
						"~Waltz of Blood", -- [3]
						30.7, -- [4]
						133886, -- [5]
						"cd", -- [6]
						327616, -- [7]
						3, -- [8]
						"2426", -- [9]
						["id"] = 2412,
					},
					["330042"] = {
						"330042", -- [1]
						"Timer330042cdcount	1", -- [2]
						"~Massacre (1)", -- [3]
						64.9, -- [4]
						136129, -- [5]
						"cdcount", -- [6]
						330042, -- [7]
						3, -- [8]
						"2424", -- [9]
						["id"] = 2407,
					},
					["244056"] = {
						"244056", -- [1]
						"Timer244056cd", -- [2]
						"~Siphon Corruption", -- [3]
						25.5, -- [4]
						538560, -- [5]
						"cd", -- [6]
						244056, -- [7]
						3, -- [8]
						"1987", -- [9]
						["id"] = 2074,
					},
					["320772"] = {
						"320772", -- [1]
						"Timer320772cd", -- [2]
						"~Comet Storm", -- [3]
						16.5, -- [4]
						1033907, -- [5]
						"cd", -- [6]
						320772, -- [7]
						3, -- [8]
						"2396", -- [9]
						["id"] = 2390,
					},
					["248317"] = {
						"248317", -- [1]
						"Timer248317cdcount	1", -- [2]
						"~Soulblight Orb (1)", -- [3]
						35.2, -- [4]
						1778225, -- [5]
						"cdcount", -- [6]
						248317, -- [7]
						3, -- [8]
						"2031", -- [9]
						["id"] = 2092,
					},
					["236442"] = {
						"236442", -- [1]
						"Timer236442cd", -- [2]
						"~Twilight Volley", -- [3]
						15.5, -- [4]
						1391677, -- [5]
						"cd", -- [6]
						236442, -- [7]
						2, -- [8]
						"1903", -- [9]
						["id"] = 2050,
					},
					["332572"] = {
						"332572", -- [1]
						"Timer332572cdcount	1", -- [2]
						"~Falling Rubble (1)", -- [3]
						12.5, -- [4]
						1385913, -- [5]
						"cdcount", -- [6]
						332572, -- [7]
						3, -- [8]
						"2394", -- [9]
						["id"] = 2399,
					},
					["325360"] = {
						"325360", -- [1]
						"Timer325360nextcount	1", -- [2]
						"Rite of Supremacy (1)", -- [3]
						11, -- [4]
						3528311, -- [5]
						"nextcount", -- [6]
						325360, -- [7]
						2, -- [8]
						"2421", -- [9]
						["id"] = 2362,
					},
					["325399"] = {
						"325399", -- [1]
						"Timer325399cd", -- [2]
						"~Hyperlight Spark", -- [3]
						5, -- [4]
						132317, -- [5]
						"cd", -- [6]
						325399, -- [7]
						2, -- [8]
						"2418", -- [9]
						["id"] = 2405,
					},
					["254926"] = {
						"254926", -- [1]
						"Timer254926cdcount	1", -- [2]
						"~Reverberating Strike (1)", -- [3]
						14.2, -- [4]
						135814, -- [5]
						"cdcount", -- [6]
						254926, -- [7]
						3, -- [8]
						"2004", -- [9]
						["id"] = 2088,
					},
					["334498"] = {
						"334498", -- [1]
						"Timer334498cdcount	1", -- [2]
						"~Seismic Upheaval (1)", -- [3]
						50.2, -- [4]
						136025, -- [5]
						"cdcount", -- [6]
						334498, -- [7]
						3, -- [8]
						"2425", -- [9]
						["id"] = 2417,
					},
					["246504"] = {
						"246504", -- [1]
						"Timer246504cast", -- [2]
						"Initializing ", -- [3]
						32.3, -- [4]
						986486, -- [5]
						"cast", -- [6]
						246504, -- [7]
						6, -- [8]
						"2004", -- [9]
						["id"] = 2088,
					},
					["ej21952"] = {
						"ej21952", -- [1]
						"Timerej21952cdcount	1", -- [2]
						"~Vile Occultist (1)", -- [3]
						70, -- [4]
						538040, -- [5]
						"cdcount", -- [6]
						"ej21952", -- [7]
						1, -- [8]
						"2422", -- [9]
						["id"] = 2402,
					},
					["334522"] = {
						"334522", -- [1]
						"Timer334522nextcount	1", -- [2]
						"Consume (1)", -- [3]
						89, -- [4]
						1778226, -- [5]
						"nextcount", -- [6]
						334522, -- [7]
						2, -- [8]
						"2428", -- [9]
						["id"] = 2383,
					},
					["233264"] = {
						"233264", -- [1]
						"Timer233264nextcount	1", -- [2]
						"Embrace of the Eclipse (1)", -- [3]
						48, -- [4]
						236152, -- [5]
						"nextcount", -- [6]
						233264, -- [7]
						5, -- [8]
						"1903", -- [9]
						["id"] = 2050,
					},
					["111723"] = {
						"111723", -- [1]
						"Timer111723next", -- [2]
						"Fixate", -- [3]
						5.5, -- [4]
						136088, -- [5]
						"next", -- [6]
						111723, -- [7]
						3, -- [8]
						"649", -- [9]
						["id"] = 1419,
					},
					["248165"] = {
						"248165", -- [1]
						"Timer248165cdcount	1", -- [2]
						"~Cone of Death (1)", -- [3]
						30.3, -- [4]
						348565, -- [5]
						"cdcount", -- [6]
						248165, -- [7]
						3, -- [8]
						"2031", -- [9]
						["id"] = 2092,
					},
					["236305"] = {
						"236305", -- [1]
						"Timer236305nextcount	1", -- [2]
						"Incorporeal Shot (1)", -- [3]
						48, -- [4]
						959793, -- [5]
						"nextcount", -- [6]
						236305, -- [7]
						3, -- [8]
						"1903", -- [9]
						["id"] = 2050,
					},
					["319589"] = {
						"319589", -- [1]
						"Timer319589cd", -- [2]
						"~Grasping Hands", -- [3]
						8.2, -- [4]
						2576086, -- [5]
						"cd", -- [6]
						319589, -- [7]
						3, -- [8]
						"2389", -- [9]
						["id"] = 2364,
					},
					["321754"] = {
						"321754", -- [1]
						"Timer321754cd", -- [2]
						"~Icebound Aegis", -- [3]
						11.7, -- [4]
						236224, -- [5]
						"cd", -- [6]
						321754, -- [7]
						5, -- [8]
						"2396", -- [9]
						["id"] = 2390,
					},
					["236542"] = {
						"236542", -- [1]
						"Timer236542cd", -- [2]
						"~Sundering Doom", -- [3]
						7, -- [4]
						1120185, -- [5]
						"cd", -- [6]
						236542, -- [7]
						5, -- [8]
						"1896", -- [9]
						["id"] = 2054,
					},
					["244693"] = {
						"244693", -- [1]
						"Timer244693cd", -- [2]
						"~Wake of Flame", -- [3]
						10.7, -- [4]
						524795, -- [5]
						"cd", -- [6]
						244693, -- [7]
						3, -- [8]
						"1984", -- [9]
						["id"] = 2063,
					},
					["327796"] = {
						"327796", -- [1]
						"Timer327796nextcount	1", -- [2]
						"Night Hunter (1)", -- [3]
						12.1, -- [4]
						1357795, -- [5]
						"nextcount", -- [6]
						327796, -- [7]
						3, -- [8]
						"2424", -- [9]
						["id"] = 2407,
					},
					["246840"] = {
						"246840", -- [1]
						"Timer246840cdcount	1", -- [2]
						"~Ruiner (1)", -- [3]
						21.1, -- [4]
						135798, -- [5]
						"cdcount", -- [6]
						246840, -- [7]
						3, -- [8]
						"2004", -- [9]
						["id"] = 2088,
					},
					["106933"] = {
						"106933", -- [1]
						"Timer106933next", -- [2]
						"Prey Time", -- [3]
						14.5, -- [4]
						132278, -- [5]
						"next", -- [6]
						106933, -- [7]
						3, -- [8]
						"675", -- [9]
						["id"] = 1405,
					},
					["235924"] = {
						"235924", -- [1]
						"Timer235924cdcount	1", -- [2]
						"~Spear of Anguish (1)", -- [3]
						20.7, -- [4]
						135131, -- [5]
						"cdcount", -- [6]
						235924, -- [7]
						3, -- [8]
						"1896", -- [9]
						["id"] = 2054,
					},
					["343273"] = {
						"343273", -- [1]
						"Timer343273cdcount	2	Vehicle-0-3778-2296-1244-172858-000014C362", -- [2]
						"~Ravenous Feast (2)", -- [3]
						18.2, -- [4]
						132127, -- [5]
						"cdcount", -- [6]
						343273, -- [7]
						3, -- [8]
						"2425", -- [9]
						["id"] = 2417,
					},
					["329110"] = {
						"329110", -- [1]
						"Timer329110cd", -- [2]
						"~Slime Injection", -- [3]
						10.9, -- [4]
						3459797, -- [5]
						"cd", -- [6]
						329110, -- [7]
						5, -- [8]
						"2403", -- [9]
						["id"] = 2384,
					},
					["327039"] = {
						"327039", -- [1]
						"Timer327039cdcount	1", -- [2]
						"~Feeding Time (1)", -- [3]
						20, -- [4]
						1357795, -- [5]
						"cdcount", -- [6]
						327039, -- [7]
						3, -- [8]
						"2424", -- [9]
						["id"] = 2407,
					},
					["106851"] = {
						"106851", -- [1]
						"Timer106851next", -- [2]
						"Blackout Brew", -- [3]
						10.5, -- [4]
						136090, -- [5]
						"next", -- [6]
						106851, -- [7]
						3, -- [8]
						"670", -- [9]
						["id"] = 1414,
					},
					["232061"] = {
						"232061", -- [1]
						"Timer232061next", -- [2]
						"Draw In", -- [3]
						58, -- [4]
						893777, -- [5]
						"next", -- [6]
						232061, -- [7]
						6, -- [8]
						"1856", -- [9]
						["id"] = 2036,
					},
					["326039"] = {
						"326039", -- [1]
						"Timer326039next", -- [2]
						"Endless Torment", -- [3]
						24.2, -- [4]
						1394887, -- [5]
						"next", -- [6]
						326039, -- [7]
						2, -- [8]
						"2421", -- [9]
						["id"] = 2362,
					},
					["323177"] = {
						"323177", -- [1]
						"Timer323177cd", -- [2]
						"~Tears of the Forest", -- [3]
						13.5, -- [4]
						463570, -- [5]
						"cd", -- [6]
						323177, -- [7]
						3, -- [8]
						"2400", -- [9]
						["id"] = 2397,
					},
					["342321"] = {
						"342321", -- [1]
						"Timer342321cd2", -- [2]
						"~Concentrated Anima", -- [3]
						54.7, -- [4]
						3684827, -- [5]
						"cd", -- [6]
						342321, -- [7]
						1, -- [8]
						"2420", -- [9]
						["id"] = 2406,
					},
					["154175"] = {
						"154175", -- [1]
						"Timer154175cdsource	Unknown	Unknown", -- [2]
						"~Body Slam: Boss", -- [3]
						15, -- [4]
						237580, -- [5]
						"cdsource", -- [6]
						154175, -- [7]
						3, -- [8]
						"1140", -- [9]
						["id"] = 1679,
					},
					["329107"] = {
						"329107", -- [1]
						"Timer329107cast", -- [2]
						"Extinction ", -- [3]
						16, -- [4]
						3636841, -- [5]
						"cast", -- [6]
						329107, -- [7]
						2, -- [8]
						"2418", -- [9]
						["id"] = 2405,
					},
					["322550"] = {
						"322550", -- [1]
						"Timer322550cd", -- [2]
						"~Accelerated Incubation", -- [3]
						45.2, -- [4]
						2141733, -- [5]
						"cd", -- [6]
						322550, -- [7]
						1, -- [8]
						"2405", -- [9]
						["id"] = 2393,
					},
					["241635"] = {
						"241635", -- [1]
						"Timer241635nextcount	3", -- [2]
						"Hammer of Creation (3)", -- [3]
						12, -- [4]
						135875, -- [5]
						"nextcount", -- [6]
						241635, -- [7]
						5, -- [8]
						"1897", -- [9]
						["id"] = 2052,
					},
					["230358"] = {
						"230358", -- [1]
						"Timer230358cd", -- [2]
						"~Thundering Shock", -- [3]
						10, -- [4]
						839974, -- [5]
						"cd", -- [6]
						230358, -- [7]
						3, -- [8]
						"1861", -- [9]
						["id"] = 2037,
					},
					["115003"] = {
						"115003", -- [1]
						"Timer115003active", -- [2]
						"Carbonation ends", -- [3]
						23, -- [4]
						132792, -- [5]
						"active", -- [6]
						115003, -- [7]
						0, -- [8]
						"670", -- [9]
						["id"] = 1414,
					},
					["322711"] = {
						"322711", -- [1]
						"Timer322711cd", -- [2]
						"~Refracted Sinlight", -- [3]
						29.6, -- [4]
						537468, -- [5]
						"cd", -- [6]
						322711, -- [7]
						3, -- [8]
						"2406", -- [9]
						["id"] = 2401,
					},
					["164974"] = {
						"164974", -- [1]
						"Timer164974next", -- [2]
						"Dark Eclipse", -- [3]
						45.5, -- [4]
						236151, -- [5]
						"next", -- [6]
						164974, -- [7]
						6, -- [8]
						"1139", -- [9]
						["id"] = 1677,
					},
					["323685"] = {
						"323685", -- [1]
						"Timer323685cd", -- [2]
						"~Grasping Rift", -- [3]
						22.7, -- [4]
						2576095, -- [5]
						"cd", -- [6]
						323685, -- [7]
						3, -- [8]
						"2417", -- [9]
						["id"] = 2404,
					},
					["328789"] = {
						"328789", -- [1]
						"Timer328789cd", -- [2]
						"~Annihilation", -- [3]
						27, -- [4]
						2101973, -- [5]
						"cd", -- [6]
						328789, -- [7]
						2, -- [8]
						"2418", -- [9]
						["id"] = 2405,
					},
					["239379"] = {
						"239379", -- [1]
						"Timer239379nextcount", -- [2]
						"Glaive Storm (Unknown", -- [3]
						54, -- [4]
						648707, -- [5]
						"nextcount", -- [6]
						239379, -- [7]
						3, -- [8]
						"1903", -- [9]
						["id"] = 2050,
					},
					["107268"] = {
						"107268", -- [1]
						"Timer107268target	Themythlife-Frostmourne", -- [2]
						"Sabotage: Themythlife-Frostmourne", -- [3]
						5, -- [4]
						133713, -- [5]
						"target", -- [6]
						107268, -- [7]
						0, -- [8]
						"655", -- [9]
						["id"] = 1397,
					},
					["343005"] = {
						"343005", -- [1]
						"Timer343005cd", -- [2]
						"~Blind Swipe", -- [3]
						20.3, -- [4]
						366938, -- [5]
						"cd", -- [6]
						343005, -- [7]
						5, -- [8]
						"2393", -- [9]
						["id"] = 2398,
					},
					["257296"] = {
						"257296", -- [1]
						"Timer257296cdcount	1", -- [2]
						"~Tortured Rage (1)", -- [3]
						12, -- [4]
						136146, -- [5]
						"cdcount", -- [6]
						257296, -- [7]
						2, -- [8]
						"2031", -- [9]
						["id"] = 2092,
					},
					["106984"] = {
						"106984", -- [1]
						"Timer106984next", -- [2]
						"Invoke Lightning", -- [3]
						6, -- [4]
						136050, -- [5]
						"next", -- [6]
						106984, -- [7]
						0, -- [8]
						"673", -- [9]
						["id"] = 1303,
					},
					["323597"] = {
						"323597", -- [1]
						"Timer323597cd", -- [2]
						"~Spectral Procession", -- [3]
						15.5, -- [4]
						236548, -- [5]
						"cd", -- [6]
						323597, -- [7]
						1, -- [8]
						"2411", -- [9]
						["id"] = 2403,
					},
					["199811"] = {
						"199811", -- [1]
						"Timer199811next", -- [2]
						"Blink Strikes", -- [3]
						15, -- [4]
						1033906, -- [5]
						"next", -- [6]
						199811, -- [7]
						3, -- [8]
						"1500", -- [9]
						["id"] = 1826,
					},
					["322936"] = {
						"322936", -- [1]
						"Timer322936cd", -- [2]
						"~Crumbling Slam", -- [3]
						4, -- [4]
						134459, -- [5]
						"cd", -- [6]
						322936, -- [7]
						5, -- [8]
						"2406", -- [9]
						["id"] = 2401,
					},
					["241721"] = {
						"241721", -- [1]
						"Timer241721active", -- [2]
						"Illidan's Sightless Gaze ends", -- [3]
						20, -- [4]
						236415, -- [5]
						"active", -- [6]
						241721, -- [7]
						5, -- [8]
						"1898", -- [9]
						["id"] = 2051,
					},
					["323608"] = {
						"323608", -- [1]
						"Timer323608cd", -- [2]
						"~Dark Devastation", -- [3]
						15.7, -- [4]
						2576088, -- [5]
						"cd", -- [6]
						323608, -- [7]
						3, -- [8]
						"2417", -- [9]
						["id"] = 2404,
					},
					["102573"] = {
						"102573", -- [1]
						"Timer102573cd", -- [2]
						"~Lightning Breath", -- [3]
						6.8, -- [4]
						135781, -- [5]
						"cd", -- [6]
						102573, -- [7]
						5, -- [8]
						"673", -- [9]
						["id"] = 1303,
					},
					["115002"] = {
						"115002", -- [1]
						"Timer115002next", -- [2]
						"Summon Gripping Hatred", -- [3]
						45.5, -- [4]
						134335, -- [5]
						"next", -- [6]
						115002, -- [7]
						1, -- [8]
						"686", -- [9]
						["id"] = 1306,
					},
					["323236"] = {
						"323236", -- [1]
						"Timer323236cd", -- [2]
						"~Unleashed Suffering", -- [3]
						15.7, -- [4]
						1035037, -- [5]
						"cd", -- [6]
						323236, -- [7]
						3, -- [8]
						"2413", -- [9]
						["id"] = 2381,
					},
					["330711"] = {
						"330711", -- [1]
						"Timer330711cd", -- [2]
						"~Shriek", -- [3]
						48.3, -- [4]
						136147, -- [5]
						"cd", -- [6]
						330711, -- [7]
						2, -- [8]
						"2393", -- [9]
						["id"] = 2398,
					},
					["335013"] = {
						"335013", -- [1]
						"Timer335013cd", -- [2]
						"~Rift Blast", -- [3]
						20.3, -- [4]
						3528282, -- [5]
						"cd", -- [6]
						335013, -- [7]
						3, -- [8]
						"2418", -- [9]
						["id"] = 2405,
					},
					["322943"] = {
						"322943", -- [1]
						"Timer322943cd", -- [2]
						"~Heave Debris", -- [3]
						13.5, -- [4]
						1500971, -- [5]
						"cd", -- [6]
						322943, -- [7]
						3, -- [8]
						"2406", -- [9]
						["id"] = 2401,
					},
					["212030"] = {
						"212030", -- [1]
						"Timer212030cd", -- [2]
						"~Shadow Slash", -- [3]
						13, -- [4]
						607850, -- [5]
						"cd", -- [6]
						212030, -- [7]
						3, -- [8]
						"1499", -- [9]
						["id"] = 1828,
					},
					["330978"] = {
						"330978", -- [1]
						"Timer330978cd", -- [2]
						"~Dredger Servants", -- [3]
						13.5, -- [4]
						461806, -- [5]
						"cd", -- [6]
						330978, -- [7]
						1, -- [8]
						"2426", -- [9]
						["id"] = 2412,
					},
					["328857"] = {
						"328857", -- [1]
						"Timer328857cd", -- [2]
						"~Bite", -- [3]
						8.1, -- [4]
						132278, -- [5]
						"cd", -- [6]
						328857, -- [7]
						5, -- [8]
						"2393", -- [9]
						["id"] = 2398,
					},
					["322818"] = {
						"322818", -- [1]
						"Timer322818cd", -- [2]
						"~Lost Confidence", -- [3]
						24.6, -- [4]
						237555, -- [5]
						"cd", -- [6]
						322818, -- [7]
						3, -- [8]
						"2412", -- [9]
						["id"] = 2359,
					},
					["232722"] = {
						"232722", -- [1]
						"Timer232722cdcount	1", -- [2]
						"~Slicing Tornado (1)", -- [3]
						30, -- [4]
						999952, -- [5]
						"cdcount", -- [6]
						232722, -- [7]
						3, -- [8]
						"1861", -- [9]
						["id"] = 2037,
					},
					["119374"] = {
						"119374", -- [1]
						"Timer119374next", -- [2]
						"Whirlwind", -- [3]
						15, -- [4]
						132369, -- [5]
						"next", -- [6]
						119374, -- [7]
						3, -- [8]
						"698", -- [9]
						["id"] = 1441,
					},
					["323943"] = {
						"323943", -- [1]
						"Timer323943cd", -- [2]
						"~Run Through", -- [3]
						10, -- [4]
						132337, -- [5]
						"cd", -- [6]
						323943, -- [7]
						3, -- [8]
						"2412", -- [9]
						["id"] = 2359,
					},
					["233556"] = {
						"233556", -- [1]
						"Timer233556cast", -- [2]
						"Corrupted Matrix ", -- [3]
						8, -- [4]
						1097741, -- [5]
						"cast", -- [6]
						233556, -- [7]
						5, -- [8]
						"1873", -- [9]
						["id"] = 2038,
					},
					["236694"] = {
						"236694", -- [1]
						"Timer236694cd", -- [2]
						"~Call Moontalon", -- [3]
						8, -- [4]
						132150, -- [5]
						"cd", -- [6]
						236694, -- [7]
						1, -- [8]
						"1903", -- [9]
						["id"] = 2050,
					},
					["154159"] = {
						"154159", -- [1]
						"Timer154159next", -- [2]
						"Energize", -- [3]
						20, -- [4]
						1029582, -- [5]
						"next", -- [6]
						154159, -- [7]
						5, -- [8]
						"966", -- [9]
						["id"] = 1699,
					},
					["329725"] = {
						"329725", -- [1]
						"Timer329725nextcount	1", -- [2]
						"Expunge (1)", -- [3]
						33, -- [4]
						1778228, -- [5]
						"nextcount", -- [6]
						329725, -- [7]
						3, -- [8]
						"2428", -- [9]
						["id"] = 2383,
					},
					["320230"] = {
						"320230", -- [1]
						"Timer320230cd", -- [2]
						"~Explosion!", -- [3]
						31.6, -- [4]
						1360978, -- [5]
						"cd", -- [6]
						320230, -- [7]
						2, -- [8]
						"2398", -- [9]
						["id"] = 2400,
					},
					["346698"] = {
						"346698", -- [1]
						"Timer346698cd", -- [2]
						"~Summon Dutiful Attendant", -- [3]
						7.3, -- [4]
						3528307, -- [5]
						"cd", -- [6]
						346698, -- [7]
						5, -- [8]
						"2426", -- [9]
						["id"] = 2412,
					},
					["157039"] = {
						"157039", -- [1]
						"Timer157039cd", -- [2]
						"~Demonic Leap", -- [3]
						23, -- [4]
						132368, -- [5]
						"cd", -- [6]
						157039, -- [7]
						3, -- [8]
						"1225", -- [9]
						["id"] = 1714,
					},
					["233431"] = {
						"233431", -- [1]
						"Timer233431cd", -- [2]
						"~Calcified Quills", -- [3]
						8.5, -- [4]
						1029749, -- [5]
						"cd", -- [6]
						233431, -- [7]
						3, -- [8]
						"1867", -- [9]
						["id"] = 2048,
					},
					["251356"] = {
						"251356", -- [1]
						"Timer251356cast", -- [2]
						"Focusing Power ", -- [3]
						15, -- [4]
						1388064, -- [5]
						"cast", -- [6]
						251356, -- [7]
						6, -- [8]
						"1987", -- [9]
						["id"] = 2074,
					},
					["236596"] = {
						"236596", -- [1]
						"Timer236596cd", -- [2]
						"~Rapid Shot", -- [3]
						15.8, -- [4]
						1035040, -- [5]
						"cd", -- [6]
						236596, -- [7]
						3, -- [8]
						"1903", -- [9]
						["id"] = 2050,
					},
					["152979"] = {
						"152979", -- [1]
						"Timer152979next", -- [2]
						"Soul Shred", -- [3]
						37, -- [4]
						828455, -- [5]
						"next", -- [6]
						152979, -- [7]
						6, -- [8]
						"1168", -- [9]
						["id"] = 1688,
					},
					["169613"] = {
						"169613", -- [1]
						"Timer169613cast", -- [2]
						"Genesis ", -- [3]
						17, -- [4]
						132125, -- [5]
						"cast", -- [6]
						169613, -- [7]
						5, -- [8]
						"1210", -- [9]
						["id"] = 1756,
					},
					["334757"] = {
						"334757", -- [1]
						"Timer334757cd", -- [2]
						"~Shades of Bargast", -- [3]
						17.5, -- [4]
						1709932, -- [5]
						"cd", -- [6]
						334757, -- [7]
						1, -- [8]
						"2429", -- [9]
						["id"] = 2418,
					},
					["131521"] = {
						"131521", -- [1]
						"Timer131521active", -- [2]
						"Ring of Malice ends", -- [3]
						15, -- [4]
						136194, -- [5]
						"active", -- [6]
						131521, -- [7]
						0, -- [8]
						"686", -- [9]
						["id"] = 1306,
					},
					["236459"] = {
						"236459", -- [1]
						"Timer236459cdcount	1", -- [2]
						"~Soulbind (1)", -- [3]
						14.2, -- [4]
						607854, -- [5]
						"cdcount", -- [6]
						236459, -- [7]
						3, -- [8]
						"1896", -- [9]
						["id"] = 2054,
					},
					["334970"] = {
						"334970", -- [1]
						"Timer334970cast", -- [2]
						"Coalescing ", -- [3]
						25, -- [4]
						458969, -- [5]
						"cast", -- [6]
						334970, -- [7]
						6, -- [8]
						"2410", -- [9]
						["id"] = 2396,
					},
					["30739"] = {
						"30739", -- [1]
						"Timer30739cd", -- [2]
						"~Blade Dance", -- [3]
						72, -- [4]
						132350, -- [5]
						"cd", -- [6]
						30739, -- [7]
						2, -- [8]
						"569", -- [9]
						["id"] = 1938,
					},
					["322795"] = {
						"322795", -- [1]
						"Timer322795next", -- [2]
						"Meat Hooks", -- [3]
						5.8, -- [4]
						1373906, -- [5]
						"next", -- [6]
						322795, -- [7]
						1, -- [8]
						"2401", -- [9]
						["id"] = 2365,
					},
					["335300"] = {
						"335300", -- [1]
						"Timer335300cdcount	1", -- [2]
						"~Chain Link (1)", -- [3]
						4.7, -- [4]
						463560, -- [5]
						"cdcount", -- [6]
						335300, -- [7]
						3, -- [8]
						"2394", -- [9]
						["id"] = 2399,
					},
					["335114"] = {
						"335114", -- [1]
						"Timer335114cdcount	1", -- [2]
						"~Sinseeker (1)", -- [3]
						28.8, -- [4]
						236174, -- [5]
						"cdcount", -- [6]
						335114, -- [7]
						3, -- [8]
						"2429", -- [9]
						["id"] = 2418,
					},
					["235059"] = {
						"235059", -- [1]
						"Timer235059cdcount	1", -- [2]
						"~Rupturing Singularity (1)", -- [3]
						55.2, -- [4]
						1041232, -- [5]
						"cdcount", -- [6]
						235059, -- [7]
						3, -- [8]
						"1898", -- [9]
						["id"] = 2051,
					},
					["234295"] = {
						"234295", -- [1]
						"Timer234295cast", -- [2]
						"Armageddon Rain ", -- [3]
						9, -- [4]
						136186, -- [5]
						"cast", -- [6]
						234295, -- [7]
						2, -- [8]
						"1898", -- [9]
						["id"] = 2051,
					},
					["328117"] = {
						"328117", -- [1]
						"Timer328117stage", -- [2]
						"Stage", -- [3]
						16.5, -- [4]
						1357812, -- [5]
						"stage", -- [6]
						328117, -- [7]
						6, -- [8]
						"2424", -- [9]
						["id"] = 2407,
					},
					["192072"] = {
						"192072", -- [1]
						"Timer192072cd", -- [2]
						"~Call Reinforcements", -- [3]
						20, -- [4]
						298644, -- [5]
						"cd", -- [6]
						192072, -- [7]
						1, -- [8]
						"1480", -- [9]
						["id"] = 1810,
					},
					["169120"] = {
						"169120", -- [1]
						"Timer169120next", -- [2]
						"Font of Life", -- [3]
						15, -- [4]
						236160, -- [5]
						"next", -- [6]
						169120, -- [7]
						1, -- [8]
						"1210", -- [9]
						["id"] = 1756,
					},
					["330964"] = {
						"330964", -- [1]
						"Timer330964cd", -- [2]
						"~Dancing Fools", -- [3]
						24, -- [4]
						132333, -- [5]
						"cd", -- [6]
						330964, -- [7]
						1, -- [8]
						"2426", -- [9]
						["id"] = 2412,
					},
					["241636"] = {
						"241636", -- [1]
						"Timer241636nextcount	4", -- [2]
						"Hammer of Obliteration (4)", -- [3]
						18, -- [4]
						1038844, -- [5]
						"nextcount", -- [6]
						241636, -- [7]
						5, -- [8]
						"1897", -- [9]
						["id"] = 2052,
					},
					["234059"] = {
						"234059", -- [1]
						"Timer234059cdcount	1", -- [2]
						"~Unbound Chaos (1)", -- [3]
						7, -- [4]
						135795, -- [5]
						"cdcount", -- [6]
						234059, -- [7]
						3, -- [8]
						"1873", -- [9]
						["id"] = 2038,
					},
					["247716"] = {
						"247716", -- [1]
						"Timer247716cd", -- [2]
						"~Charged Blasts", -- [3]
						8.4, -- [4]
						236216, -- [5]
						"cd", -- [6]
						247716, -- [7]
						3, -- [8]
						"2009", -- [9]
						["id"] = 2082,
					},
					["318406"] = {
						"318406", -- [1]
						"Timer318406cd", -- [2]
						"~Tenderizing Smash", -- [3]
						14.5, -- [4]
						623773, -- [5]
						"cd", -- [6]
						318406, -- [7]
						3, -- [8]
						"2401", -- [9]
						["id"] = 2365,
					},
					["329770"] = {
						"329770", -- [1]
						"Timer329770cd", -- [2]
						"~Planting Seed", -- [3]
						21.6, -- [4]
						3575389, -- [5]
						"cd", -- [6]
						329770, -- [7]
						5, -- [8]
						"2418", -- [9]
						["id"] = 2405,
					},
					["233983"] = {
						"233983", -- [1]
						"Timer233983cd", -- [2]
						"~Echoing Anguish", -- [3]
						22.9, -- [4]
						136181, -- [5]
						"cd", -- [6]
						233983, -- [7]
						3, -- [8]
						"1867", -- [9]
						["id"] = 2048,
					},
					["325258"] = {
						"325258", -- [1]
						"Timer325258cd", -- [2]
						"~Master of Death", -- [3]
						9.5, -- [4]
						3163624, -- [5]
						"cd", -- [6]
						325258, -- [7]
						3, -- [8]
						"2410", -- [9]
						["id"] = 2396,
					},
					["46165"] = {
						"46165", -- [1]
						"Timer46165next", -- [2]
						"Shock Barrier", -- [3]
						60, -- [4]
						136051, -- [5]
						"next", -- [6]
						46165, -- [7]
						4, -- [8]
						"533", -- [9]
						["id"] = 1894,
					},
					["232249"] = {
						"232249", -- [1]
						"Timer232249cd", -- [2]
						"~Crashing Comet", -- [3]
						8.5, -- [4]
						135797, -- [5]
						"cd", -- [6]
						232249, -- [7]
						3, -- [8]
						"1862", -- [9]
						["id"] = 2032,
					},
					["153067"] = {
						"153067", -- [1]
						"Timer153067next", -- [2]
						"Void Devastation", -- [3]
						67.5, -- [4]
						535592, -- [5]
						"next", -- [6]
						153067, -- [7]
						3, -- [8]
						"1168", -- [9]
						["id"] = 1688,
					},
					["323059"] = {
						"323059", -- [1]
						"Timer323059active", -- [2]
						"Droman's Wrath ends", -- [3]
						12, -- [4]
						134218, -- [5]
						"active", -- [6]
						323059, -- [7]
						6, -- [8]
						"2400", -- [9]
						["id"] = 2397,
					},
					["326271"] = {
						"326271", -- [1]
						"Timer326271cd", -- [2]
						"~Stasis Trap", -- [3]
						10.5, -- [4]
						613397, -- [5]
						"cd", -- [6]
						326271, -- [7]
						3, -- [8]
						"2418", -- [9]
						["id"] = 2405,
					},
					["106872"] = {
						"106872", -- [1]
						"Timer106872cd", -- [2]
						"~Disorienting Smash", -- [3]
						13, -- [4]
						136175, -- [5]
						"cd", -- [6]
						106872, -- [7]
						0, -- [8]
						"685", -- [9]
						["id"] = 1305,
					},
					["233894"] = {
						"233894", -- [1]
						"Timer233894cd", -- [2]
						"~Suffocating Dark", -- [3]
						24, -- [4]
						136194, -- [5]
						"cd", -- [6]
						233894, -- [7]
						3, -- [8]
						"1867", -- [9]
						["id"] = 2048,
					},
					["340758"] = {
						"340758", -- [1]
						"Timer340758cd", -- [2]
						"~Spirits", -- [3]
						25, -- [4]
						3256113, -- [5]
						"cd", -- [6]
						340758, -- [7]
						3, -- [8]
						"2418", -- [9]
						["id"] = 2405,
					},
					["322773"] = {
						"322773", -- [1]
						"Timer322773cd", -- [2]
						"~Blood Barrier", -- [3]
						26.5, -- [4]
						1394887, -- [5]
						"cd", -- [6]
						322773, -- [7]
						6, -- [8]
						"2408", -- [9]
						["id"] = 2395,
					},
					["319702"] = {
						"319702", -- [1]
						"Timer319702cd", -- [2]
						"~Blood Torrent", -- [3]
						7.5, -- [4]
						1394887, -- [5]
						"cd", -- [6]
						319702, -- [7]
						2, -- [8]
						"2387", -- [9]
						["id"] = 2380,
					},
					["119684"] = {
						"119684", -- [1]
						"Timer119684cd", -- [2]
						"~Ground Slam", -- [3]
						9.5, -- [4]
						451165, -- [5]
						"cd", -- [6]
						119684, -- [7]
						3, -- [8]
						"698", -- [9]
						["id"] = 1441,
					},
					["333932"] = {
						"333932", -- [1]
						"Timer333932cdcount	1", -- [2]
						"~Hand of Destruction (1)", -- [3]
						46.6, -- [4]
						136225, -- [5]
						"cdcount", -- [6]
						333932, -- [7]
						2, -- [8]
						"2424", -- [9]
						["id"] = 2407,
					},
					["156857"] = {
						"156857", -- [1]
						"Timer156857cd", -- [2]
						"~Rain of Fire", -- [3]
						15, -- [4]
						136186, -- [5]
						"cd", -- [6]
						156857, -- [7]
						4, -- [8]
						"1225", -- [9]
						["id"] = 1714,
					},
					["321247"] = {
						"321247", -- [1]
						"Timer321247cd", -- [2]
						"~Final Harvest", -- [3]
						38.6, -- [4]
						2576087, -- [5]
						"cd", -- [6]
						321247, -- [7]
						2, -- [8]
						"2391", -- [9]
						["id"] = 2388,
					},
					["192094"] = {
						"192094", -- [1]
						"Timer192094cd", -- [2]
						"~Impaling Spear", -- [3]
						28, -- [4]
						135130, -- [5]
						"cd", -- [6]
						192094, -- [7]
						3, -- [8]
						"1480", -- [9]
						["id"] = 1810,
					},
					["321834"] = {
						"321834", -- [1]
						"Timer321834cd", -- [2]
						"~Dodge Ball", -- [3]
						8.1, -- [4]
						132387, -- [5]
						"cd", -- [6]
						321834, -- [7]
						3, -- [8]
						"2402", -- [9]
						["id"] = 2392,
					},
					["319650"] = {
						"319650", -- [1]
						"Timer319650cd", -- [2]
						"~Vicious Headbutt", -- [3]
						5.9, -- [4]
						132091, -- [5]
						"cd", -- [6]
						319650, -- [7]
						5, -- [8]
						"2388", -- [9]
						["id"] = 2360,
					},
					["328791"] = {
						"328791", -- [1]
						"Timer328791next", -- [2]
						"Ritual of Woe", -- [3]
						8.2, -- [4]
						237536, -- [5]
						"next", -- [6]
						328791, -- [7]
						2, -- [8]
						"2413", -- [9]
						["id"] = 2381,
					},
					["325552"] = {
						"325552", -- [1]
						"Timer325552cd", -- [2]
						"~Cytotoxic Slash", -- [3]
						3.1, -- [4]
						348565, -- [5]
						"cd", -- [6]
						325552, -- [7]
						5, -- [8]
						"2423", -- [9]
						["id"] = 2385,
					},
					["334765"] = {
						"334765", -- [1]
						"Timer334765cdcount	1", -- [2]
						"~Heart Rend (1)", -- [3]
						28.9, -- [4]
						135811, -- [5]
						"cdcount", -- [6]
						334765, -- [7]
						3, -- [8]
						"2425", -- [9]
						["id"] = 2417,
					},
					["326707"] = {
						"326707", -- [1]
						"Timer326707nextcount	1", -- [2]
						"Cleansing Pain (1)", -- [3]
						5.8, -- [4]
						3528313, -- [5]
						"nextcount", -- [6]
						326707, -- [7]
						5, -- [8]
						"2424", -- [9]
						["id"] = 2407,
					},
					["320050"] = {
						"320050", -- [1]
						"Timer320050cdcount	1", -- [2]
						"~Might of Maldraxxus (1)", -- [3]
						17.1, -- [4]
						1115905, -- [5]
						"cdcount", -- [6]
						320050, -- [7]
						6, -- [8]
						"2390", -- [9]
						["id"] = 2366,
					},
					["154350"] = {
						"154350", -- [1]
						"Timer154350cd", -- [2]
						"~Omen of Death", -- [3]
						10.5, -- [4]
						136022, -- [5]
						"cd", -- [6]
						154350, -- [7]
						3, -- [8]
						"1160", -- [9]
						["id"] = 1682,
					},
					["324527"] = {
						"324527", -- [1]
						"Timer324527next", -- [2]
						"Plaguestomp", -- [3]
						7, -- [4]
						1044089, -- [5]
						"next", -- [6]
						324527, -- [7]
						3, -- [8]
						"2419", -- [9]
						["id"] = 2382,
					},
					["320326"] = {
						"320326", -- [1]
						"Timer320326cd", -- [2]
						"~Displaced Blastwave", -- [3]
						9.4, -- [4]
						1408832, -- [5]
						"cd", -- [6]
						320326, -- [7]
						3, -- [8]
						"2398", -- [9]
						["id"] = 2400,
					},
					["238570"] = {
						"238570", -- [1]
						"Timer238570nextcount	1", -- [2]
						"Tormented Cries (1)", -- [3]
						119, -- [4]
						463286, -- [5]
						"nextcount", -- [6]
						238570, -- [7]
						6, -- [8]
						"1896", -- [9]
						["id"] = 2054,
					},
					["ej5934"] = {
						"ej5934", -- [1]
						"Timerej5934next", -- [2]
						"Sharpshooter Guard", -- [3]
						21, -- [4]
						970886, -- [5]
						"next", -- [6]
						"ej5934", -- [7]
						1, -- [8]
						"569", -- [9]
						["id"] = 1938,
					},
					["252861"] = {
						"252861", -- [1]
						"Timer252861nextcount	1", -- [2]
						"Storm of Darkness (1)", -- [3]
						26, -- [4]
						136194, -- [5]
						"nextcount", -- [6]
						252861, -- [7]
						2, -- [8]
						"1986", -- [9]
						["id"] = 2073,
					},
					["255826"] = {
						"255826", -- [1]
						"Timer255826cdcount	1", -- [2]
						"~Edge of Obliteration (1)", -- [3]
						21, -- [4]
						1778227, -- [5]
						"cdcount", -- [6]
						255826, -- [7]
						2, -- [8]
						"2031", -- [9]
						["id"] = 2092,
					},
					["329298"] = {
						"329298", -- [1]
						"Timer329298cdcount	1", -- [2]
						"~Miasma (1)", -- [3]
						3, -- [4]
						1390943, -- [5]
						"cdcount", -- [6]
						329298, -- [7]
						3, -- [8]
						"2428", -- [9]
						["id"] = 2383,
					},
					["346657"] = {
						"346657", -- [1]
						"Timer346657cd", -- [2]
						"~Eruption", -- [3]
						35, -- [4]
						3528311, -- [5]
						"cd", -- [6]
						346657, -- [7]
						3, -- [8]
						"2426", -- [9]
						["id"] = 2412,
					},
					["230920"] = {
						"230920", -- [1]
						"Timer230920cd", -- [2]
						"~Consuming Hunger", -- [3]
						20, -- [4]
						237395, -- [5]
						"cd", -- [6]
						230920, -- [7]
						1, -- [8]
						"1861", -- [9]
						["id"] = 2037,
					},
					["328731"] = {
						"328731", -- [1]
						"Timer328731cast	Creature-0-4230-2296-5369-168962-00001A2763", -- [2]
						"Phoenix Embers ", -- [3]
						20, -- [4]
						628267, -- [5]
						"cast", -- [6]
						328731, -- [7]
						1, -- [8]
						"2422", -- [9]
						["id"] = 2402,
					},
					["111668"] = {
						"111668", -- [1]
						"Timer111668next", -- [2]
						"Battering Headbutt", -- [3]
						33, -- [4]
						236195, -- [5]
						"next", -- [6]
						111668, -- [7]
						0, -- [8]
						"649", -- [9]
						["id"] = 1419,
					},
					["247552"] = {
						"247552", -- [1]
						"Timer247552cd", -- [2]
						"~Sleep Canister", -- [3]
						7, -- [4]
						136090, -- [5]
						"cd", -- [6]
						247552, -- [7]
						3, -- [8]
						"2009", -- [9]
						["id"] = 2082,
					},
					["320644"] = {
						"320644", -- [1]
						"Timer320644cdcount	1", -- [2]
						"~Brutal Combo (1)", -- [3]
						5.8, -- [4]
						1390946, -- [5]
						"cdcount", -- [6]
						320644, -- [7]
						5, -- [8]
						"2390", -- [9]
						["id"] = 2366,
					},
					["119946"] = {
						"119946", -- [1]
						"Timer119946cd", -- [2]
						"~Ravage", -- [3]
						26, -- [4]
						132142, -- [5]
						"cd", -- [6]
						119946, -- [7]
						3, -- [8]
						"708", -- [9]
						["id"] = 1442,
					},
					["319733"] = {
						"319733", -- [1]
						"Timer319733cd", -- [2]
						"~Stone Call", -- [3]
						10.9, -- [4]
						463493, -- [5]
						"cd", -- [6]
						319733, -- [7]
						1, -- [8]
						"2387", -- [9]
						["id"] = 2380,
					},
					["236378"] = {
						"236378", -- [1]
						"Timer236378cdcount	1", -- [2]
						"~Wailing Reflection (1)", -- [3]
						56, -- [4]
						463284, -- [5]
						"cdcount", -- [6]
						236378, -- [7]
						3, -- [8]
						"1898", -- [9]
						["id"] = 2051,
					},
					["233441"] = {
						"233441", -- [1]
						"Timer233441cdcount	1", -- [2]
						"~Bone Saw (1)", -- [3]
						64.5, -- [4]
						999952, -- [5]
						"cdcount", -- [6]
						233441, -- [7]
						2, -- [8]
						"1867", -- [9]
						["id"] = 2048,
					},
					["254429"] = {
						"254429", -- [1]
						"Timer254429cd", -- [2]
						"~Weight of Darkness", -- [3]
						73.1, -- [4]
						136194, -- [5]
						"cd", -- [6]
						254429, -- [7]
						3, -- [8]
						"1987", -- [9]
						["id"] = 2074,
					},
					["244072"] = {
						"244072", -- [1]
						"Timer244072cd", -- [2]
						"~Molten Touch", -- [3]
						18, -- [4]
						135807, -- [5]
						"cd", -- [6]
						244072, -- [7]
						3, -- [8]
						"1987", -- [9]
						["id"] = 2074,
					},
					["334053"] = {
						"334053", -- [1]
						"Timer334053cd", -- [2]
						"~Purifying Blast", -- [3]
						8.4, -- [4]
						3528286, -- [5]
						"cd", -- [6]
						334053, -- [7]
						3, -- [8]
						"2414", -- [9]
						["id"] = 2358,
					},
					["334625"] = {
						"334625", -- [1]
						"Timer334625cd", -- [2]
						"~Abyssal Detonation", -- [3]
						20.1, -- [4]
						3528303, -- [5]
						"cd", -- [6]
						334625, -- [7]
						2, -- [8]
						"2412", -- [9]
						["id"] = 2359,
					},
					["320966"] = {
						"320966", -- [1]
						"Timer320966cd", -- [2]
						"~Overhead Slash", -- [3]
						8.3, -- [4]
						3284464, -- [5]
						"cd", -- [6]
						320966, -- [7]
						5, -- [8]
						"2399", -- [9]
						["id"] = 2357,
					},
					["159382"] = {
						"159382", -- [1]
						"Timer159382active", -- [2]
						"Quills ends", -- [3]
						17, -- [4]
						132927, -- [5]
						"active", -- [6]
						159382, -- [7]
						2, -- [8]
						"967", -- [9]
						["id"] = 1700,
					},
					["236710"] = {
						"236710", -- [1]
						"Timer236710cd", -- [2]
						"~Erupting Reflection", -- [3]
						18.5, -- [4]
						1357814, -- [5]
						"cd", -- [6]
						236710, -- [7]
						3, -- [8]
						"1898", -- [9]
						["id"] = 2051,
					},
					["319619"] = {
						"319619", -- [1]
						"Timer319619cd", -- [2]
						"~Displacement Trap", -- [3]
						4.5, -- [4]
						132206, -- [5]
						"cd", -- [6]
						319619, -- [7]
						3, -- [8]
						"2398", -- [9]
						["id"] = 2400,
					},
					["157001"] = {
						"157001", -- [1]
						"Timer157001cd", -- [2]
						"~Chaos Wave", -- [3]
						10, -- [4]
						607850, -- [5]
						"cd", -- [6]
						157001, -- [7]
						3, -- [8]
						"1225", -- [9]
						["id"] = 1714,
					},
					["233055"] = {
						"233055", -- [1]
						"Timer233055cd", -- [2]
						"~Infernal Spike", -- [3]
						4, -- [4]
						1118739, -- [5]
						"cd", -- [6]
						233055, -- [7]
						3, -- [8]
						"1862", -- [9]
						["id"] = 2032,
					},
					["258068"] = {
						"258068", -- [1]
						"Timer258068cdcount	1", -- [2]
						"~Sargeras' Gaze (1)", -- [3]
						8.2, -- [4]
						1357795, -- [5]
						"cdcount", -- [6]
						258068, -- [7]
						3, -- [8]
						"2031", -- [9]
						["id"] = 2092,
					},
					["245227"] = {
						"245227", -- [1]
						"Timer245227next", -- [2]
						"Assume Command", -- [3]
						90, -- [4]
						132333, -- [5]
						"next", -- [6]
						245227, -- [7]
						6, -- [8]
						"1997", -- [9]
						["id"] = 2070,
					},
					["319521"] = {
						"319521", -- [1]
						"Timer319521cd", -- [2]
						"~Draw Soul", -- [3]
						15.5, -- [4]
						2576083, -- [5]
						"cd", -- [6]
						319521, -- [7]
						3, -- [8]
						"2389", -- [9]
						["id"] = 2364,
					},
					["111728"] = {
						"111728", -- [1]
						"Timer111728nextcount	1", -- [2]
						"Stomp (1)", -- [3]
						20.5, -- [4]
						132368, -- [5]
						"nextcount", -- [6]
						111728, -- [7]
						2, -- [8]
						"649", -- [9]
						["id"] = 1419,
					},
					["320376"] = {
						"320376", -- [1]
						"Timer320376cd	Creature-0-4220-2286-11134-164578-0000A0BAB4", -- [2]
						"~Mutlilate", -- [3]
						10, -- [4]
						237517, -- [5]
						"cd", -- [6]
						320376, -- [7]
						3, -- [8]
						"2392", -- [9]
						["id"] = 2389,
					},
					["250669"] = {
						"250669", -- [1]
						"Timer250669nextcount	1", -- [2]
						"Soulburst (1)", -- [3]
						30.3, -- [4]
						1778229, -- [5]
						"nextcount", -- [6]
						250669, -- [7]
						3, -- [8]
						"2031", -- [9]
						["id"] = 2092,
					},
					["249121"] = {
						"249121", -- [1]
						"Timer249121cdcount	1", -- [2]
						"~Final Doom (1)", -- [3]
						59.3, -- [4]
						132097, -- [5]
						"cdcount", -- [6]
						249121, -- [7]
						4, -- [8]
						"2025", -- [9]
						["id"] = 2075,
					},
					["334929"] = {
						"334929", -- [1]
						"Timer334929cdcount	1", -- [2]
						"~Serrated Swipe (1)", -- [3]
						8.1, -- [4]
						1396975, -- [5]
						"cdcount", -- [6]
						334929, -- [7]
						5, -- [8]
						"2425", -- [9]
						["id"] = 2417,
					},
					["248332"] = {
						"248332", -- [1]
						"Timer248332cdcount	1", -- [2]
						"~Rain of Fel (1)", -- [3]
						6, -- [4]
						135797, -- [5]
						"cdcount", -- [6]
						248332, -- [7]
						3, -- [8]
						"2025", -- [9]
						["id"] = 2075,
					},
					["322236"] = {
						"322236", -- [1]
						"Timer322236cd", -- [2]
						"~Touch of Slime", -- [3]
						6, -- [4]
						254105, -- [5]
						"cd", -- [6]
						322236, -- [7]
						5, -- [8]
						"2404", -- [9]
						["id"] = 2386,
					},
					["237722"] = {
						"237722", -- [1]
						"Timer237722next", -- [2]
						"Blowback", -- [3]
						40.9, -- [4]
						236256, -- [5]
						"next", -- [6]
						237722, -- [7]
						6, -- [8]
						"1897", -- [9]
						["id"] = 2052,
					},
					["334485"] = {
						"334485", -- [1]
						"Timer334485cd", -- [2]
						"~Recharge", -- [3]
						44.9, -- [4]
						3565449, -- [5]
						"cd", -- [6]
						334485, -- [7]
						6, -- [8]
						"2416", -- [9]
						["id"] = 2356,
					},
					["339706"] = {
						"339706", -- [1]
						"Timer339706cd", -- [2]
						"~Ghostly Charge", -- [3]
						17, -- [4]
						3511738, -- [5]
						"cd", -- [6]
						339706, -- [7]
						3, -- [8]
						"2417", -- [9]
						["id"] = 2404,
					},
					["245627"] = {
						"245627", -- [1]
						"Timer245627next", -- [2]
						"Whirling Saber", -- [3]
						8, -- [4]
						999952, -- [5]
						"next", -- [6]
						245627, -- [7]
						3, -- [8]
						"1986", -- [9]
						["id"] = 2073,
					},
					["255199"] = {
						"255199", -- [1]
						"Timer255199cd", -- [2]
						"~Avatar of Aggramar", -- [3]
						20.9, -- [4]
						135947, -- [5]
						"cd", -- [6]
						255199, -- [7]
						5, -- [8]
						"2031", -- [9]
						["id"] = 2092,
					},
					["236519"] = {
						"236519", -- [1]
						"Timer236519cd", -- [2]
						"~Moon Burn", -- [3]
						9.1, -- [4]
						136057, -- [5]
						"cd", -- [6]
						236519, -- [7]
						3, -- [8]
						"1903", -- [9]
						["id"] = 2050,
					},
					["251448"] = {
						"251448", -- [1]
						"Timer251448cd", -- [2]
						"~Burning Maw", -- [3]
						8.2, -- [4]
						135813, -- [5]
						"cd", -- [6]
						251448, -- [7]
						5, -- [8]
						"1987", -- [9]
						["id"] = 2074,
					},
					["342077"] = {
						"342077", -- [1]
						"Timer342077cd", -- [2]
						"~Echolocation", -- [3]
						14.2, -- [4]
						132097, -- [5]
						"cd", -- [6]
						342077, -- [7]
						3, -- [8]
						"2393", -- [9]
						["id"] = 2398,
					},
					["245546"] = {
						"245546", -- [1]
						"Timer245546next", -- [2]
						"Summon Reinforcements", -- [3]
						8, -- [4]
						237559, -- [5]
						"next", -- [6]
						245546, -- [7]
						1, -- [8]
						"1997", -- [9]
						["id"] = 2070,
					},
					["111600"] = {
						"111600", -- [1]
						"Timer111600target	Themythlife-Frostmourne", -- [2]
						"Screeching Swarm: Themythlife-Frostmourne", -- [3]
						10, -- [4]
						538518, -- [5]
						"target", -- [6]
						111600, -- [7]
						0, -- [8]
						"649", -- [9]
						["id"] = 1419,
					},
					["334009"] = {
						"334009", -- [1]
						"Timer334009cdcount3	1", -- [2]
						"~Leap (1)", -- [3]
						29.4, -- [4]
						2101174, -- [5]
						"cdcount", -- [6]
						334009, -- [7]
						3, -- [8]
						"2425", -- [9]
						["id"] = 2417,
					},
					["118988"] = {
						"118988", -- [1]
						"Timer118988target	Glintrok Oracle", -- [2]
						"Reckless Inspiration: Glintrok Oracle", -- [3]
						20, -- [4]
						236310, -- [5]
						"target", -- [6]
						118988, -- [7]
						0, -- [8]
						"690", -- [9]
						["id"] = 2129,
					},
					["328885"] = {
						"328885", -- [1]
						"Timer328885next", -- [2]
						"Greater Castigation", -- [3]
						5.8, -- [4]
						3528313, -- [5]
						"next", -- [6]
						328885, -- [7]
						3, -- [8]
						"2422", -- [9]
						["id"] = 2402,
					},
					["230227"] = {
						"230227", -- [1]
						"Timer230227cd", -- [2]
						"~From the Abyss", -- [3]
						18, -- [4]
						133898, -- [5]
						"cd", -- [6]
						230227, -- [7]
						1, -- [8]
						"1861", -- [9]
						["id"] = 2037,
					},
					["231854"] = {
						"231854", -- [1]
						"Timer231854nextcount	1", -- [2]
						"Unchecked Rage (1)", -- [3]
						20, -- [4]
						132344, -- [5]
						"nextcount", -- [6]
						231854, -- [7]
						2, -- [8]
						"1856", -- [9]
						["id"] = 2036,
					},
					["154032"] = {
						"154032", -- [1]
						"Timer154032cd", -- [2]
						"~Lens Flare", -- [3]
						27.3, -- [4]
						1029587, -- [5]
						"cd", -- [6]
						154032, -- [7]
						3, -- [8]
						"968", -- [9]
						["id"] = 1701,
					},
					["320272"] = {
						"320272", -- [1]
						"Timer320272cd", -- [2]
						"~Spectral Transference", -- [3]
						10.5, -- [4]
						2576086, -- [5]
						"cd", -- [6]
						320272, -- [7]
						5, -- [8]
						"2397", -- [9]
						["id"] = 2391,
					},
					["322893"] = {
						"322893", -- [1]
						"Timer322893next", -- [2]
						"Slipstream", -- [3]
						10, -- [4]
						648840, -- [5]
						"next", -- [6]
						322893, -- [7]
						2, -- [8]
						"2412", -- [9]
						["id"] = 2359,
					},
					["323552"] = {
						"323552", -- [1]
						"Timer323552cd", -- [2]
						"~Volley of Power", -- [3]
						12, -- [4]
						1394887, -- [5]
						"cd", -- [6]
						323552, -- [7]
						4, -- [8]
						"2411", -- [9]
						["id"] = 2403,
					},
					["nil"] = {
						"nil", -- [1]
						"Record Victory", -- [2]
						"Record Victory", -- [3]
						230.5269999999982, -- [4]
						237538, -- [5]
						nil, -- [6]
						nil, -- [7]
						0, -- [8]
						"2394", -- [9]
						["id"] = 2399,
					},
					["329181"] = {
						"329181", -- [1]
						"Timer329181cdcount	1", -- [2]
						"~Wracking Pain (1)", -- [3]
						21.1, -- [4]
						3528313, -- [5]
						"cdcount", -- [6]
						329181, -- [7]
						5, -- [8]
						"2424", -- [9]
						["id"] = 2407,
					},
					["327411"] = {
						"327411", -- [1]
						"Timer327411cd", -- [2]
						"~Curse of Stone", -- [3]
						21.3, -- [4]
						516666, -- [5]
						"cd", -- [6]
						327411, -- [7]
						3, -- [8]
						"2387", -- [9]
						["id"] = 2380,
					},
					["ej5927"] = {
						"ej5927", -- [1]
						"Timerej5927next", -- [2]
						"Heathen Guard", -- [3]
						27.5, -- [4]
						970886, -- [5]
						"next", -- [6]
						"ej5927", -- [7]
						1, -- [8]
						"569", -- [9]
						["id"] = 1938,
					},
					["157465"] = {
						"157465", -- [1]
						"Timer157465cd", -- [2]
						"~Fate", -- [3]
						25, -- [4]
						237537, -- [5]
						"cd", -- [6]
						157465, -- [7]
						3, -- [8]
						"1185", -- [9]
						["id"] = 1686,
					},
					["320359"] = {
						"320359", -- [1]
						"Timer320359cast", -- [2]
						"Escape ", -- [3]
						30, -- [4]
						132307, -- [5]
						"cast", -- [6]
						320359, -- [7]
						6, -- [8]
						"2392", -- [9]
						["id"] = 2389,
					},
					["324608"] = {
						"324608", -- [1]
						"Timer324608cd", -- [2]
						"~Charged Stomp", -- [3]
						14.3, -- [4]
						460957, -- [5]
						"cd", -- [6]
						324608, -- [7]
						3, -- [8]
						"2414", -- [9]
						["id"] = 2358,
					},
					["ej5930"] = {
						"ej5930", -- [1]
						"Timerej5930next", -- [2]
						"Reaver Guard", -- [3]
						21, -- [4]
						970886, -- [5]
						"next", -- [6]
						"ej5930", -- [7]
						1, -- [8]
						"569", -- [9]
						["id"] = 1938,
					},
					["31422"] = {
						"31422", -- [1]
						"Timer31422active", -- [2]
						"Time Stop ends", -- [3]
						4, -- [4]
						135728, -- [5]
						"active", -- [6]
						31422, -- [7]
						3, -- [8]
						"554", -- [9]
						["id"] = 1919,
					},
					["331618"] = {
						"331618", -- [1]
						"Timer331618cdcount	1", -- [2]
						"~Oppressive Banner (1)", -- [3]
						10.7, -- [4]
						3578234, -- [5]
						"cdcount", -- [6]
						331618, -- [7]
						1, -- [8]
						"2390", -- [9]
						["id"] = 2366,
					},
					["239362"] = {
						"239362", -- [1]
						"Timer239362next", -- [2]
						"Delicious Bufferfish", -- [3]
						12.5, -- [4]
						533422, -- [5]
						"next", -- [6]
						239362, -- [7]
						5, -- [8]
						"1861", -- [9]
						["id"] = 2037,
					},
					["321828"] = {
						"321828", -- [1]
						"Timer321828cd", -- [2]
						"~Patty Cake", -- [3]
						13.4, -- [4]
						134470, -- [5]
						"cd", -- [6]
						321828, -- [7]
						3, -- [8]
						"2402", -- [9]
						["id"] = 2392,
					},
					["322654"] = {
						"322654", -- [1]
						"Timer322654cd", -- [2]
						"~Acid Expulsion", -- [3]
						8, -- [4]
						132104, -- [5]
						"cd", -- [6]
						322654, -- [7]
						3, -- [8]
						"2405", -- [9]
						["id"] = 2393,
					},
					["200024"] = {
						"200024", -- [1]
						"Timer200024cd", -- [2]
						"~Nether Venom", -- [3]
						25, -- [4]
						237155, -- [5]
						"cd", -- [6]
						200024, -- [7]
						3, -- [8]
						"1500", -- [9]
						["id"] = 1826,
					},
					["120195"] = {
						"120195", -- [1]
						"Timer120195next", -- [2]
						"Meteor", -- [3]
						42, -- [4]
						135821, -- [5]
						"next", -- [6]
						120195, -- [7]
						3, -- [8]
						"708", -- [9]
						["id"] = 1442,
					},
					["334852"] = {
						"334852", -- [1]
						"Timer334852cd", -- [2]
						"~Howl", -- [3]
						13.9, -- [4]
						3386971, -- [5]
						"cd", -- [6]
						334852, -- [7]
						3, -- [8]
						"2429", -- [9]
						["id"] = 2418,
					},
					["ej22082"] = {
						"ej22082", -- [1]
						"Timerej22082cdcount	1", -- [2]
						"~Pestering Fiend (1)", -- [3]
						100, -- [4]
						134085, -- [5]
						"cdcount", -- [6]
						"ej22082", -- [7]
						1, -- [8]
						"2422", -- [9]
						["id"] = 2402,
					},
					["245161"] = {
						"245161", -- [1]
						"Timer245161cd", -- [2]
						"~Entropic Mine", -- [3]
						5.1, -- [4]
						133009, -- [5]
						"cd", -- [6]
						245161, -- [7]
						3, -- [8]
						"1997", -- [9]
						["id"] = 2070,
					},
					["243983"] = {
						"243983", -- [1]
						"Timer243983cd", -- [2]
						"~Collapsing World", -- [3]
						10.5, -- [4]
						1044088, -- [5]
						"cd", -- [6]
						243983, -- [7]
						2, -- [8]
						"1985", -- [9]
						["id"] = 2064,
					},
					["153810"] = {
						"153810", -- [1]
						"Timer153810cd", -- [2]
						"~Summon Solar Flare", -- [3]
						11, -- [4]
						574795, -- [5]
						"cd", -- [6]
						153810, -- [7]
						3, -- [8]
						"967", -- [9]
						["id"] = 1700,
					},
					["106853"] = {
						"106853", -- [1]
						"Timer106853cd", -- [2]
						"~Fists of Fury", -- [3]
						23, -- [4]
						305703, -- [5]
						"cd", -- [6]
						106853, -- [7]
						0, -- [8]
						"657", -- [9]
						["id"] = 1304,
					},
					["238587"] = {
						"238587", -- [1]
						"Timer238587cdcount	1", -- [2]
						"~Rain of Brimstone (1)", -- [3]
						12.1, -- [4]
						517112, -- [5]
						"cdcount", -- [6]
						238587, -- [7]
						5, -- [8]
						"1862", -- [9]
						["id"] = 2032,
					},
					["322232"] = {
						"322232", -- [1]
						"Timer322232cd", -- [2]
						"~Infectious Rain", -- [3]
						19.1, -- [4]
						132100, -- [5]
						"cd", -- [6]
						322232, -- [7]
						3, -- [8]
						"2404", -- [9]
						["id"] = 2386,
					},
					["120201"] = {
						"120201", -- [1]
						"Timer120201cd", -- [2]
						"~Conflagrate", -- [3]
						22, -- [4]
						135807, -- [5]
						"cd", -- [6]
						120201, -- [7]
						3, -- [8]
						"708", -- [9]
						["id"] = 1442,
					},
					["238430"] = {
						"238430", -- [1]
						"Timer238430cdcount	1", -- [2]
						"~Bursting Dreadflame (1)", -- [3]
						11, -- [4]
						460698, -- [5]
						"cdcount", -- [6]
						238430, -- [7]
						3, -- [8]
						"1898", -- [9]
						["id"] = 2051,
					},
					["112992"] = {
						"112992", -- [1]
						"Timer112992next", -- [2]
						"Furlwind", -- [3]
						15, -- [4]
						132369, -- [5]
						"next", -- [6]
						112992, -- [7]
						2, -- [8]
						"669", -- [9]
						["id"] = 1413,
					},
					["339550"] = {
						"339550", -- [1]
						"Timer339550cd", -- [2]
						"~Echo of Battle", -- [3]
						7, -- [4]
						1778230, -- [5]
						"cd", -- [6]
						339550, -- [7]
						3, -- [8]
						"2417", -- [9]
						["id"] = 2404,
					},
					["324449"] = {
						"324449", -- [1]
						"Timer324449cd", -- [2]
						"~Manifest Death", -- [3]
						23.9, -- [4]
						2576087, -- [5]
						"cd", -- [6]
						324449, -- [7]
						3, -- [8]
						"2417", -- [9]
						["id"] = 2404,
					},
					["236571"] = {
						"236571", -- [1]
						"Timer236571cd", -- [2]
						"~Shadowy Blades", -- [3]
						27, -- [4]
						1035040, -- [5]
						"cd", -- [6]
						236571, -- [7]
						3, -- [8]
						"1873", -- [9]
						["id"] = 2038,
					},
					["255594"] = {
						"255594", -- [1]
						"Timer255594cdcount	1", -- [2]
						"~Sky and Sea (1)", -- [3]
						10.1, -- [4]
						1385912, -- [5]
						"cdcount", -- [6]
						255594, -- [7]
						5, -- [8]
						"2031", -- [9]
						["id"] = 2092,
					},
					["326171"] = {
						"326171", -- [1]
						"Timer326171cd", -- [2]
						"~Shatter Reality", -- [3]
						60, -- [4]
						463285, -- [5]
						"cd", -- [6]
						326171, -- [7]
						2, -- [8]
						"2410", -- [9]
						["id"] = 2396,
					},
					["243976"] = {
						"243976", -- [1]
						"Timer243976next", -- [2]
						"Torment of Frost", -- [3]
						100, -- [4]
						236209, -- [5]
						"next", -- [6]
						243976, -- [7]
						6, -- [8]
						"1983", -- [9]
						["id"] = 2069,
					},
					["322903"] = {
						"322903", -- [1]
						"Timer322903cd", -- [2]
						"~Gloom Squall", -- [3]
						34.5, -- [4]
						1035055, -- [5]
						"cd", -- [6]
						322903, -- [7]
						2, -- [8]
						"2407", -- [9]
						["id"] = 2363,
					},
					["329455"] = {
						"329455", -- [1]
						"Timer329455nextcount	1", -- [2]
						"Desolate (1)", -- [3]
						22, -- [4]
						1778230, -- [5]
						"nextcount", -- [6]
						329455, -- [7]
						2, -- [8]
						"2428", -- [9]
						["id"] = 2383,
					},
					["235271"] = {
						"235271", -- [1]
						"Timer235271nextcount	2", -- [2]
						"Infusion (2)", -- [3]
						2, -- [4]
						1122135, -- [5]
						"nextcount", -- [6]
						235271, -- [7]
						3, -- [8]
						"1897", -- [9]
						["id"] = 2052,
					},
					["333387"] = {
						"333387", -- [1]
						"Timer333387cdcount	1", -- [2]
						"~Wicked Blade (1)", -- [3]
						16.6, -- [4]
						589068, -- [5]
						"cdcount", -- [6]
						333387, -- [7]
						3, -- [8]
						"2425", -- [9]
						["id"] = 2417,
					},
					["323137"] = {
						"323137", -- [1]
						"Timer323137cd", -- [2]
						"~Bewildering Pollen", -- [3]
						15.8, -- [4]
						134219, -- [5]
						"cd", -- [6]
						323137, -- [7]
						5, -- [8]
						"2400", -- [9]
						["id"] = 2397,
					},
					["322681"] = {
						"322681", -- [1]
						"Timer322681cd", -- [2]
						"~Meat Hook", -- [3]
						10.6, -- [4]
						1373906, -- [5]
						"cd", -- [6]
						322681, -- [7]
						3, -- [8]
						"2392", -- [9]
						["id"] = 2389,
					},
					["320637"] = {
						"320637", -- [1]
						"Timer320637cd", -- [2]
						"~Fetid Gas", -- [3]
						22, -- [4]
						646782, -- [5]
						"cd", -- [6]
						320637, -- [7]
						3, -- [8]
						"2395", -- [9]
						["id"] = 2387,
					},
					["240910"] = {
						"240910", -- [1]
						"Timer240910cdcount	1", -- [2]
						"~Armageddon (1)", -- [3]
						10, -- [4]
						136186, -- [5]
						"cdcount", -- [6]
						240910, -- [7]
						5, -- [8]
						"1898", -- [9]
						["id"] = 2051,
					},
					["243967"] = {
						"243967", -- [1]
						"Timer243967next", -- [2]
						"Torment of Flames", -- [3]
						5, -- [4]
						236220, -- [5]
						"next", -- [6]
						243967, -- [7]
						6, -- [8]
						"1983", -- [9]
						["id"] = 2069,
					},
					["319685"] = {
						"319685", -- [1]
						"Timer319685cd", -- [2]
						"~Severing Smash", -- [3]
						34.2, -- [4]
						1778230, -- [5]
						"cd", -- [6]
						319685, -- [7]
						6, -- [8]
						"2388", -- [9]
						["id"] = 2360,
					},
					["320180"] = {
						"320180", -- [1]
						"Timer320180cd", -- [2]
						"~Noxious Spores", -- [3]
						17.7, -- [4]
						464341, -- [5]
						"cd", -- [6]
						320180, -- [7]
						3, -- [8]
						"2397", -- [9]
						["id"] = 2391,
					},
					["114459"] = {
						"114459", -- [1]
						"Timer114459fades", -- [2]
						"Fizzy Bubbles fades", -- [3]
						20, -- [4]
						512902, -- [5]
						"fades", -- [6]
						114459, -- [7]
						0, -- [8]
						"670", -- [9]
						["id"] = 1414,
					},
					["44194"] = {
						"44194", -- [1]
						"Timer44194cd", -- [2]
						"~Phoenix", -- [3]
						45, -- [4]
						134373, -- [5]
						"cd", -- [6]
						44194, -- [7]
						1, -- [8]
						"533", -- [9]
						["id"] = 1894,
					},
					["328437"] = {
						"328437", -- [1]
						"Timer328437cd", -- [2]
						"~Tear", -- [3]
						14, -- [4]
						526520, -- [5]
						"cd", -- [6]
						328437, -- [7]
						3, -- [8]
						"2418", -- [9]
						["id"] = 2405,
					},
					["ej21954"] = {
						"ej21954", -- [1]
						"Timerej21954cdcount	1", -- [2]
						"~Rockbound Vanquisher (1)", -- [3]
						50, -- [4]
						2065633, -- [5]
						"cdcount", -- [6]
						"ej21954", -- [7]
						1, -- [8]
						"2422", -- [9]
						["id"] = 2402,
					},
					["325877"] = {
						"325877", -- [1]
						"Timer325877cd", -- [2]
						"~Ember Blast", -- [3]
						20.1, -- [4]
						135826, -- [5]
						"cd", -- [6]
						325877, -- [7]
						3, -- [8]
						"2422", -- [9]
						["id"] = 2402,
					},
					["246516"] = {
						"246516", -- [1]
						"Timer246516cdcount	1", -- [2]
						"~Apocalypse Protocol (1)", -- [3]
						31.8, -- [4]
						135796, -- [5]
						"cdcount", -- [6]
						246516, -- [7]
						6, -- [8]
						"2004", -- [9]
						["id"] = 2088,
					},
					["334945"] = {
						"334945", -- [1]
						"Timer334945cd", -- [2]
						"~Lunge", -- [3]
						18.1, -- [4]
						1029718, -- [5]
						"cd", -- [6]
						334945, -- [7]
						3, -- [8]
						"2429", -- [9]
						["id"] = 2418,
					},
					["244688"] = {
						"244688", -- [1]
						"Timer244688nextcount	1", -- [2]
						"Taeshalach Technique (1)", -- [3]
						14.3, -- [4]
						510053, -- [5]
						"nextcount", -- [6]
						244688, -- [7]
						5, -- [8]
						"1984", -- [9]
						["id"] = 2063,
					},
					["153991"] = {
						"153991", -- [1]
						"Timer153991cd", -- [2]
						"~Torn Spirits", -- [3]
						25.5, -- [4]
						237563, -- [5]
						"cd", -- [6]
						153991, -- [7]
						1, -- [8]
						"1186", -- [9]
						["id"] = 1685,
					},
					["323687"] = {
						"323687", -- [1]
						"Timer323687cd", -- [2]
						"~Arcane Lightning", -- [3]
						7.2, -- [4]
						136099, -- [5]
						"cd", -- [6]
						323687, -- [7]
						3, -- [8]
						"2398", -- [9]
						["id"] = 2400,
					},
					["332318"] = {
						"332318", -- [1]
						"Timer332318cdcount	1", -- [2]
						"~Stomp (1)", -- [3]
						18.2, -- [4]
						136025, -- [5]
						"cdcount", -- [6]
						332318, -- [7]
						3, -- [8]
						"2394", -- [9]
						["id"] = 2399,
					},
					["197776"] = {
						"197776", -- [1]
						"Timer197776cd", -- [2]
						"~Fel Fissure", -- [3]
						5, -- [4]
						1118738, -- [5]
						"cd", -- [6]
						197776, -- [7]
						3, -- [8]
						"1499", -- [9]
						["id"] = 1828,
					},
				},
				["encounter_timers_bw"] = {
					["323437"] = {
						"Lord Chamberlain", -- [1]
						"323437", -- [2]
						"Stigma of Pride", -- [3]
						41, -- [4]
						538039, -- [5]
						["id"] = 2381,
					},
					["322943"] = {
						"Halkias, the Sin-Stained Goliath", -- [1]
						"322943", -- [2]
						"Heave Debris", -- [3]
						12, -- [4]
						1500971, -- [5]
						["id"] = 2401,
					},
					["329104"] = {
						"Lord Chamberlain", -- [1]
						"329104", -- [2]
						"Door of Shadows", -- [3]
						25, -- [4]
						134430, -- [5]
						["id"] = 2381,
					},
					["329340"] = {
						"High Adjudicator Aleez", -- [1]
						"329340", -- [2]
						"Anima Fountain", -- [3]
						22, -- [4]
						1392546, -- [5]
						["id"] = 2403,
					},
					["323236"] = {
						"Lord Chamberlain", -- [1]
						"323236", -- [2]
						"Unleashed Suffering", -- [3]
						15.5, -- [4]
						1035037, -- [5]
						["id"] = 2381,
					},
					["319941"] = {
						"Echelon", -- [1]
						"319941", -- [2]
						"Stone Shattering Leap", -- [3]
						23.5, -- [4]
						1016245, -- [5]
						["id"] = 2380,
					},
					["323650"] = {
						"High Adjudicator Aleez", -- [1]
						"323650", -- [2]
						"Haunting Fixation", -- [3]
						16, -- [4]
						841379, -- [5]
						["id"] = 2403,
					},
					["328206"] = {
						"Echelon", -- [1]
						"328206", -- [2]
						"Curse of Stone", -- [3]
						22, -- [4]
						516666, -- [5]
						["id"] = 2380,
					},
					["323150"] = {
						"Lord Chamberlain", -- [1]
						"323150", -- [2]
						"Telekinetic Toss", -- [3]
						6, -- [4]
						136243, -- [5]
						["id"] = 2381,
					},
					["328791"] = {
						"Lord Chamberlain", -- [1]
						"328791", -- [2]
						"Ritual of Woe", -- [3]
						36, -- [4]
						237536, -- [5]
						["id"] = 2381,
					},
					["323552"] = {
						"High Adjudicator Aleez", -- [1]
						"323552", -- [2]
						"Volley of Power", -- [3]
						12, -- [4]
						1394887, -- [5]
						["id"] = 2403,
					},
					["326389"] = {
						"Echelon", -- [1]
						"326389", -- [2]
						"Blood Torrent", -- [3]
						9.5, -- [4]
						1394887, -- [5]
						["id"] = 2380,
					},
					["322711"] = {
						"Halkias, the Sin-Stained Goliath", -- [1]
						"322711", -- [2]
						"Beams", -- [3]
						31, -- [4]
						537468, -- [5]
						["id"] = 2401,
					},
					["319733"] = {
						"Echelon", -- [1]
						"319733", -- [2]
						"Stone Call", -- [3]
						15.5, -- [4]
						463493, -- [5]
						["id"] = 2380,
					},
				},
			},
			["tutorial"] = {
				["unlock_button"] = 4,
				["main_help_button"] = 4148,
				["logons"] = 4148,
				["ENCOUNTER_BREAKDOWN_CHART"] = true,
				["ctrl_click_close_tutorial"] = false,
				["DISABLE_ONDEATH_PANEL"] = true,
				["ENCOUNTER_BREAKDOWN_PHASES"] = true,
				["FORGE_TUTORIAL"] = true,
				["ENCOUNTER_BREAKDOWN_SPELLAURAS"] = true,
				["alert_frames"] = {
					false, -- [1]
					false, -- [2]
					false, -- [3]
					false, -- [4]
					false, -- [5]
					false, -- [6]
				},
				["WINDOW_LOCK_UNLOCK1"] = true,
				["OVERALLDATA_WARNING1"] = 8,
				["DETAILS_INFO_TUTORIAL2"] = 10,
				["version_announce"] = 0,
				["HISTORYPANEL_TUTORIAL"] = true,
				["MIN_COMBAT_TIME"] = true,
				["bookmark_tutorial"] = false,
				["DETAILS_INFO_TUTORIAL1"] = true,
			},
			["spell_school_cache"] = {
				["Call to Chaos"] = 32,
				["Plague Seed"] = 32,
				["Shadow Word: Pain"] = 32,
				["Arcane Sphere"] = 64,
				["Triple Bite"] = 8,
				["Echo Finger Laser X-treme"] = 4,
				["Fire Bolt"] = 4,
				["Strike"] = 1,
				["Aerial Rocket Chicken Barrage"] = 4,
				["Ravenous Feast"] = 1,
				["Heart Hemorrhage"] = 32,
				["Energy Bolt"] = 64,
				["Blazing Touch"] = 4,
				["Illidan's Sightless Gaze"] = 4,
				["Holy Word: Chastise"] = 2,
				["Feeding Time"] = 1,
				["Brambles"] = 8,
				["Frost Strike Off-Hand"] = 16,
				["Heedless Charge"] = 1,
				["Jagged Swipe"] = 1,
				["Kill Command"] = 1,
				["Dark Recital"] = 32,
				["Sorrowful Wail"] = 32,
				["Stab"] = 1,
				["Soul Flay"] = 32,
				["Carnage"] = 1,
				["Shrapnel Blast"] = 1,
				["Dark Devastation"] = 32,
				["Phoenix Flames"] = 4,
				["Dark Fissure"] = 32,
				["Corrupting Maw"] = 32,
				["Firebloom"] = 4,
				["Infectious Rain"] = 8,
				["Withergrove Shardling"] = 32,
				["Armageddon Rain"] = 4,
				["Crunch"] = 1,
				["Shadow Ball"] = 32,
				["Serrated Tear"] = 1,
				["Death Bolt"] = 32,
				["Indemnification"] = 32,
				["Poison"] = 8,
				["Serpent Sting"] = 8,
				["Deadly Bargain"] = 32,
				["Iron Shackles"] = 1,
				["Comet Storm"] = 16,
				["Light Infusion"] = 2,
				["Embalming Ichor"] = 40,
				["Dark Bolt"] = 32,
				["Avalanche"] = 16,
				["Plague Rot"] = 8,
				["Lingering Doubt"] = 64,
				["Victory Rush"] = 1,
				["Pulverizing Meteor"] = 8,
				["Blazing Nova"] = 4,
				["Necrotic Breath"] = 32,
				["Grab"] = 1,
				["Blastwire"] = 4,
				["Pool of Shadows"] = 32,
				["Replicated Anima"] = 32,
				["Talon Rake"] = 1,
				["Burning Maw"] = 4,
				["Molten Remnants"] = 4,
				["Pierce"] = 1,
				["Remorseless Winter"] = 16,
				["Tortured Echoes"] = 32,
				["Blackout Kick"] = 1,
				["Carnivorous Bite"] = 1,
				["Web"] = 1,
				["Poison Bomb"] = 8,
				["Mangle"] = 1,
				["Starfire"] = 64,
				["Lingering Wail"] = 32,
				["Sins of the Past"] = 32,
				["Fanning the Flames"] = 4,
				["Power Overwhelming"] = 64,
				["Withering Touch"] = 8,
				["Anima Shedding"] = 1,
				["Ripple of Darkness"] = 32,
				["Unleashed Rage"] = 32,
				["Bestial Wrath"] = 1,
				["Horrified"] = 32,
				["Impale"] = 1,
				["Putrid Bile"] = 8,
				["Rake"] = 1,
				["Anima Fountain"] = 32,
				["Overwhelming Power!"] = 64,
				["Collapsing World"] = 32,
				["Aerial Bombardment"] = 32,
				["Stonequake"] = 1,
				["Crystalline Burst"] = 8,
				["Insatiable Hunger"] = 1,
				["Shattering Chain"] = 1,
				["Tiro-Autom�tico"] = 1,
				["Empowered Flare"] = 4,
				["Wracking Pain"] = 32,
				["Drain Essence"] = 32,
				["Blood Barrage"] = 32,
				["Impaling Harpoon"] = 1,
				["Liquefying Ooze"] = 8,
				["Cobra Shot"] = 1,
				["Crumbling Foundation"] = 1,
				["Energize"] = 4,
				["Ghostly Charge"] = 32,
				["Shoot"] = 1,
				["Juggernaut Rush"] = 1,
				["Howling Blast"] = 16,
				["Gash"] = 1,
				["High Explosive Sheep"] = 4,
				["Fel Bombardment"] = 4,
				["Murder Prey"] = 1,
				["Infernal Rockets"] = 4,
				["Arcanic Oubliette"] = 96,
				["Reverberating Eruption"] = 8,
				["Turbulent Anima"] = 32,
				["Hand of Destruction"] = 32,
				["Crimson Flurry"] = 1,
				["Plague Annihilation"] = 40,
				["Shadow Blades"] = 32,
				["Massacre"] = 32,
				["Shared Suffering"] = 32,
				["Piercing Barb"] = 32,
				["Ravage"] = 32,
				["Ground Pound"] = 1,
				["Indignation"] = 1,
				["Whirling Saber"] = 4,
				["Reaping Scythe"] = 1,
				["Debilitating Poison"] = 8,
				["Storming"] = 8,
				["Sear"] = 4,
				["Lingering Eruption"] = 32,
				["Burning Flash"] = 4,
				["Destructive Impact"] = 1,
				["Infernal Spike"] = 4,
				["Sleep Canister"] = 8,
				["Dirge of the Fallen Sanctum"] = 8,
				["Death Blow"] = 32,
				["Sludge Bolt"] = 8,
				["Echoing Smash"] = 1,
				["Armageddon Hail"] = 1,
				["Molten Aura"] = 4,
				["Dusk Elegy"] = 32,
				["Twilight Glaive"] = 32,
				["Stone Shards"] = 8,
				["Slam"] = 1,
				["Turned to Stone"] = 1,
				["Sundering Doom"] = 32,
				["Pyroblast"] = 4,
				["Jaws of Stone"] = 1,
				["Goblin Dragon Gun"] = 4,
				["Lash Out"] = 1,
				["Unstable Affliction"] = 32,
				["Bramble Patch"] = 8,
				["Magnetic Shroud"] = 8,
				["Telekinetic Collision"] = 1,
				["Shadow Rune"] = 32,
				["Rending Charge"] = 1,
				["Shredding Claws"] = 1,
				["Painful Memories"] = 32,
				["Venomfangs"] = 8,
				["Shattered"] = 8,
				["Retribution Aura"] = 2,
				["Shadow Word: Death"] = 32,
				["Dark Exile"] = 32,
				["Carbonation"] = 16,
				["Holy Shield"] = 2,
				["Anima Surge"] = 64,
				["Fists of Fury Strike"] = 4,
				["Ferocious Claw"] = 1,
				["Furlwind"] = 1,
				["Crushing Embrace"] = 1,
				["Death Grasp"] = 32,
				["Pulse Grenade"] = 8,
				["Smack"] = 1,
				["Fulminating Burst"] = 4,
				["Unstable Footing"] = 8,
				["Drain Soul"] = 32,
				["Searing Death"] = 32,
				["Spectral Bolt"] = 32,
				["Frost Fever"] = 16,
				["Final Say"] = 32,
				["Claw"] = 1,
				["Flare"] = 64,
				["Smoldering Ire"] = 32,
				["Cluster Bombardment"] = 32,
				["Bruising Strike"] = 1,
				["Lightning Breath"] = 8,
				["Fatal Finesse"] = 32,
				["Burning Remnant"] = 4,
				["Soulless"] = 32,
				["Ball of Fire"] = 4,
				["Festering Rot"] = 40,
				["Sintouched Anima"] = 32,
				["Crushed Soul"] = 32,
				["Gathering Power"] = 4,
				["Lingering Embers"] = 4,
				["Rain of Fire"] = 4,
				["Inevitable"] = 1,
				["Mind Link"] = 32,
				["Black Winds"] = 32,
				["Charged Anima"] = 64,
				["Echos of Carnage"] = 32,
				["Corpse Breath"] = 32,
				["Fulminating Pulse"] = 4,
				["Frozen Binds"] = 16,
				["Consume"] = 32,
				["Greater Castigation"] = 32,
				["Befouling Ink"] = 32,
				["Armageddon Blast"] = 4,
				["Viral Globs"] = 8,
				["Fragments of Shadow"] = 32,
				["Surging Anima"] = 64,
				["Blade Dance"] = 1,
				["Cartilaginous Legs"] = 32,
				["Unbound Cosmos"] = 32,
				["Withered Winds"] = 8,
				["Fel Infusion"] = 4,
				["Bloodbound"] = 1,
				["Inexorable Assault"] = 16,
				["Collapsing Fissure"] = 32,
				["Meat Hook"] = 1,
				["Waltz of Blood"] = 32,
				["Corrupted Blood"] = 32,
				["Hydra Acid"] = 8,
				["Earthgrab"] = 1,
				["Ignite"] = 4,
				["Rapid Infection"] = 8,
				["Shadow Burst"] = 32,
				["Twisted Pain"] = 1,
				["Burning Maul"] = 4,
				["Rocket Launch"] = 4,
				["Ring of Malice"] = 32,
				["Vanquished"] = 1,
				["Parasitic Incapacitation"] = 1,
				["Shocked"] = 4,
				["Mantid Munition Explosion"] = 4,
				["Loose Anima"] = 32,
				["Fall of the Unworthy"] = 1,
				["Life Link"] = 1,
				["Chaos Pulse"] = 4,
				["Thrash"] = 1,
				["Bleeding"] = 1,
				["Rain of the Destroyer"] = 4,
				["Power Word: Radiance"] = 2,
				["Smoldering Remnants"] = 4,
				["Wild Bite"] = 1,
				["Disgusting Guts"] = 40,
				["Obliterating Rift"] = 32,
				["Vile Gas"] = 40,
				["Slime Wave"] = 8,
				["Oppressive Atmosphere"] = 32,
				["Blood Torrent"] = 32,
				["Soul Eruption"] = 32,
				["Melee"] = 1,
				["Shattering Strike"] = 8,
				["Kitten Claws"] = 1,
				["Alone in the Darkness"] = 32,
				["Arcane Lightning"] = 64,
				["Deathbolt Rift"] = 32,
				["Touch of Anguish"] = 32,
				["Rupturing Singularity"] = 64,
				["Bursting Ooze"] = 1,
				["Entanglement"] = 8,
				["Descent"] = 1,
				["Ritual of Bones"] = 32,
				["Spinning Crane Kick"] = 1,
				["Thunderstorm"] = 8,
				["Rotting"] = 8,
				["Bloodletting Pounce"] = 1,
				["Destabilize"] = 1,
				["Sanctified Ground"] = 2,
				["Queensguard's Vigil"] = 8,
				["Obliterate"] = 1,
				["Rupturing Slam"] = 1,
				["Frost Strike"] = 16,
				["Chain Link"] = 1,
				["Conflagrate"] = 4,
				["Volcanic Plume"] = 4,
				["Finishing Blow"] = 1,
				["Exsanguinating Bite"] = 1,
				["Taeshalach's Reach"] = 1,
				["Annihilation"] = 4,
				["Shared Pain"] = 32,
				["Phantasmal Parasite"] = 32,
				["Echoing Annihilation"] = 8,
				["Ferment"] = 1,
				["Wicked Slice"] = 32,
				["Jagged Gash"] = 1,
				["Disease Cloud"] = 40,
				["Jagged Abrasion"] = 1,
				["Sha Spike"] = 32,
				["Seismic Upheaval"] = 8,
				["Fel Pool"] = 4,
				["Sinseeker"] = 32,
				["Mind Flay"] = 32,
				["Desolation"] = 32,
				["Manifest Pain"] = 32,
				["Anima Puddle"] = 8,
				["Colossal Roar"] = 1,
				["Deep Wounds"] = 1,
				["Shattering Scream"] = 32,
				["Pestilence Bolt"] = 8,
				["Fetid Bite"] = 8,
				["Omen of Death"] = 32,
				["Unchecked Rage"] = 1,
				["Gluttonous Miasma"] = 32,
				["Swift Slash"] = 1,
				["Evasive Lunge"] = 1,
				["Echoing Blast"] = 8,
				["Shackle the Unworthy"] = 64,
				["Colossus Smash"] = 1,
				["Tantrum"] = 1,
				["Soul Singe"] = 32,
				["Shadow Burn"] = 32,
				["Brutal Strike"] = 1,
				["Magma Eruption"] = 4,
				["Rapid Fire"] = 1,
				["Wicked Blast"] = 32,
				["Stone Shattering Leap"] = 8,
				["Fount of Pestilence"] = 8,
				["Wicked Laceration"] = 1,
				["Anima Web"] = 32,
				["Smash"] = 1,
				["Chaos Flames"] = 124,
				["Diabolic Bomb"] = 32,
				["Ritual of Woe"] = 32,
				["Iron Spikes"] = 1,
				["Strafing Run"] = 4,
				["Peck"] = 1,
				["Erupt"] = 8,
				["Empowered Portal: Xoroth"] = 4,
				["Body Slam"] = 1,
				["Fel Squall"] = 4,
				["Aura of Dread"] = 32,
				["Grim Venom"] = 8,
				["Soul Vessel"] = 32,
				["Frigid Cold"] = 16,
				["Thunderclap"] = 8,
				["Shared Cognition"] = 32,
				["Stoke the Flames"] = 4,
				["Ring of Fire"] = 4,
				["Bottled Anima"] = 32,
				["Displacement Trap"] = 1,
				["Briarskin"] = 8,
				["Anima Field"] = 64,
				["Agitated Water"] = 16,
				["Anima Toxin"] = 8,
				["Dark Stride"] = 1,
				["Immediate Extermination"] = 32,
				["Displaced Blastwave"] = 64,
				["Falling Rubble"] = 1,
				["Icebound Aegis"] = 16,
				["Necrotic Pitch"] = 32,
				["Hallowed Ground"] = 2,
				["Fel Eruption"] = 32,
				["Dissonance"] = 32,
				["Collapsing Foundation"] = 1,
				["Sanguine Ichor"] = 32,
				["Blood Price"] = 32,
				["Razorice"] = 16,
				["Corrupt Aegis"] = 4,
				["Wake of Flame"] = 4,
				["Lightning Shield"] = 8,
				["Heave Debris"] = 1,
				["A Murder of Crows"] = 1,
				["Stone Spike"] = 1,
				["Soul Infusion"] = 32,
				["Bite"] = 1,
				["Conflagration"] = 4,
				["Bursting Dreadflame"] = 4,
				["Cleaving Strike"] = 1,
				["Tormented Eruption"] = 4,
				["Focused Dreadburst"] = 4,
				["Screeching Swarm"] = 32,
				["Downward Strike"] = 1,
				["Oozing Outbreak"] = 8,
				["Acid Globule"] = 8,
				["Hammer of Creation"] = 2,
				["Manifest Death"] = 32,
				["Smoldering Plumage"] = 4,
				["Eye of Dread"] = 32,
				["Refracted Sinlight"] = 32,
				["Cannon"] = 1,
				["Hungering Drain"] = 32,
				["Cosmic Collapse"] = 32,
				["Exsanguinated"] = 1,
				["Hopelessness"] = 32,
				["Frostbolt Volley"] = 16,
				["Castigate"] = 32,
				["Obliterate Off-Hand"] = 1,
				["Maul"] = 1,
				["Chill of the Beyond"] = 32,
				["Void Devastation"] = 32,
				["Sunfire"] = 8,
				["Empowered Portal: Nathreza"] = 32,
				["Dread Orb"] = 32,
				["Void Blast"] = 32,
				["Localized Explosive Contrivance"] = 64,
				["Lunar Strike"] = 64,
				["Petrifying Howl"] = 8,
				["Flames of the Forge"] = 4,
				["Burning Remnants"] = 4,
				["Reverberating Vulnerability"] = 1,
				["Arcane Shot"] = 64,
				["Spectral Glaive"] = 96,
				["Chi Wave"] = 8,
				["Echoing Screech"] = 1,
				["Torment of Flames"] = 4,
				["Earsplitting Shriek"] = 1,
				["Savage Flurry"] = 1,
				["Seared Skin"] = 4,
				["Ricocheting Blade"] = 1,
				["Charged Blasts"] = 4,
				["Stomp"] = 1,
				["Fetid Spit"] = 8,
				["Whirlwind"] = 1,
				["Slimy Morsel"] = 1,
				["Growing Pride"] = 32,
				["Vicious Wound"] = 1,
				["Deathshade Volley"] = 32,
				["Necrotic Ichor"] = 32,
				["Decomposing Acid"] = 8,
				["Soul Split"] = 32,
				["Fire Blast"] = 4,
				["Bladestorm"] = 1,
				["Warped Desires"] = 32,
				["Shadow Ambush"] = 32,
				["Rancor"] = 32,
				["Reverberating Leap"] = 1,
				["Smoldering Stygia"] = 4,
				["Pulse from Beyond"] = 32,
				["Cleave"] = 1,
				["Auto Shot"] = 1,
				["Templar's Verdict"] = 2,
				["Prideful Eruption"] = 32,
				["Choking Shadow"] = 32,
				["Corpo-a-Corpo"] = 1,
				["Shattering Pain"] = 32,
				["Freezing Burst"] = 16,
				["Purifying Blast"] = 64,
				["Scorch"] = 4,
				["Carrot Breath"] = 1,
				["Valiant Strike"] = 1,
				["Moon Burn"] = 64,
				["Dart"] = 1,
				["Residue"] = 32,
				["Quietus Strike"] = 1,
				["Giant Fists"] = 1,
				["Quietus"] = 32,
				["Consecrated Light"] = 2,
				["Moonfire"] = 64,
				["Apocalypse Blast"] = 4,
				["Pinning Shot"] = 1,
				["Suffocating Dark"] = 32,
				["Touch of the Grave"] = 32,
				["The Jailer's Mark"] = 32,
				["Echoing Eruption"] = 8,
				["Shadowcore Oil Blast"] = 32,
				["Curse of Obliteration"] = 32,
				["Meteor Swarm"] = 4,
				["Venomblades"] = 8,
				["Hot!"] = 4,
				["Anima Spit"] = 2,
				["Lumbering Swipe"] = 1,
				["Frost Shock"] = 16,
				["Hydra Shot"] = 1,
				["Fetid Gas"] = 8,
				["Deep Connection"] = 64,
				["Crescendo"] = 32,
				["Shadow Shot"] = 32,
				["Barbed Shot"] = 1,
				["Tail Sweep"] = 1,
				["Shattered Conduits"] = 64,
				["Stream of Blades"] = 1,
				["Acid Expulsion"] = 8,
				["Luring Destruction"] = 4,
				["Gravity Lapse"] = 64,
				["Coagulating Ooze"] = 40,
				["Ravenous Blaze"] = 4,
				["Rotten Strike"] = 8,
				["Dark Eclipse"] = 32,
				["Crush Armor"] = 1,
				["Dimensional Tear"] = 64,
				["Unchecked Flame"] = 4,
				["Buzz-Saw"] = 1,
				["Assassinate"] = 8,
				["Echoing Sonar"] = 1,
				["Crashing Comet"] = 4,
				["Razorshard Ice"] = 16,
				["Quick Strike"] = 1,
				["Essence Absorption"] = 32,
				["Deathspike"] = 32,
				["Shattered Dominion"] = 32,
				["Decay"] = 32,
				["Slime Lunge"] = 1,
				["Bruise"] = 1,
				["Unstable Soul"] = 4,
				["Scorn"] = 32,
				["Shadow Storm"] = 32,
				["Ruiner"] = 4,
				["Volatile Ejection"] = 32,
				["Death Shroud"] = 32,
				["Dark Claw"] = 32,
				["Infernal Detonation"] = 4,
				["Empowered Portal: Rancora"] = 8,
				["Shattering Ruby"] = 1,
				["Overload"] = 64,
				["Possession"] = 32,
				["Terrifying Chaos"] = 32,
				["Double Strike"] = 1,
				["Unleashed Shadow"] = 32,
				["Splintered Heart of Al'ar"] = 4,
				["Archon's Bastion"] = 1,
				["Burn"] = 4,
				["Stasis Trap"] = 64,
				["Ravenous Swipe"] = 1,
				["Unchecked Growth"] = 8,
				["Dark Spin"] = 1,
				["Wrath"] = 8,
				["Spilled Essence"] = 32,
				["Night Hunter"] = 1,
				["Empowered Shrapnel Blast"] = 4,
				["Storm of Darkness"] = 32,
				["Seeds of Sorrow"] = 8,
				["Unleashed Flames"] = 4,
				["Shattering Stone"] = 8,
				["Calcified Quills"] = 1,
				["Burden of Sin"] = 32,
				["Eternal Skirmish"] = 32,
				["Touch of Slime"] = 8,
				["Glass Shards"] = 1,
				["Sense of Dread"] = 32,
				["Tornado Slam"] = 1,
				["Concentrated Anima"] = 32,
				["Master of Death"] = 32,
				["Quills"] = 1,
				["Feedback Overload"] = 4,
				["Heart Strike"] = 1,
				["Latent Eruption"] = 32,
				["Throw Axe"] = 1,
				["Frenzied Assault"] = 1,
				["Oopsie"] = 8,
				["Enveloping Webbing"] = 8,
				["Mortal Strike"] = 1,
				["Smouldering"] = 4,
				["Fireball"] = 4,
				["Wrong Moves"] = 32,
				["Eruption"] = 4,
				["Lingering Anima"] = 32,
				["Shuriken Storm"] = 1,
				["Noxious Fog"] = 40,
				["Mandible Strike"] = 8,
				["Valiant Bolt"] = 64,
				["Soul Anguish"] = 32,
				["Consumption"] = 32,
				["Unleashed Anima"] = 64,
				["Necrotic Bolt"] = 32,
				["Consume Slime"] = 1,
				["Divine Storm"] = 2,
				["Soul Rot"] = 32,
				["Fire Bomb"] = 4,
				["Anima Rejection"] = 8,
				["Dread Cleave"] = 32,
				["Wicked Bolt"] = 32,
				["Overcharged Soul"] = 8,
				["Hungering Strikes"] = 32,
				["Crimson Chorus"] = 32,
				["Crushing Fear"] = 32,
				["Acid Bomb"] = 8,
				["Soul Spikes"] = 32,
				["Expunge"] = 32,
				["Explosive Contrivance"] = 64,
				["Hew"] = 1,
				["Immolation Aura"] = 4,
				["Unleashed Volatility"] = 32,
				["Soultaint"] = 1,
				["Divert Power"] = 4,
				["Seismic Leap"] = 1,
				["Essence Extraction"] = 32,
				["Noxious Spores"] = 40,
				["Whispers of the Dark Star"] = 32,
				["Shock Grenade"] = 4,
				["Highly Concentrated Anima"] = 32,
				["Concentrated Plague"] = 8,
				["Glyph of Destruction"] = 64,
				["Engorge"] = 32,
				["Entropic Blast"] = 4,
				["Container Breach"] = 32,
			},
			["deathlog_healingdone_min"] = 1,
			["exit_log"] = {
				"1 - Closing Janela Info.", -- [1]
				"2 - Clearing user place from instances.", -- [2]
				"4 - Reversing switches.", -- [3]
				"6 - Saving Config.", -- [4]
				"7 - Saving Profiles.", -- [5]
				"8 - Saving nicktag cache.", -- [6]
			},
			["mythic_plus"] = {
				["make_overall_boss_only"] = false,
				["mythicrun_chart_frame"] = {
				},
				["merge_boss_trash"] = true,
				["delay_to_show_graphic"] = 5,
				["always_in_combat"] = false,
				["make_overall_when_done"] = true,
				["delete_trash_after_merge"] = true,
				["show_damage_graphic"] = true,
				["mythicrun_chart_frame_ready"] = {
				},
				["boss_dedicated_segment"] = true,
				["mythicrun_chart_frame_minimized"] = {
				},
				["last_mythicrun_chart"] = {
				},
			},
			["custom"] = {
				{
					["source"] = false,
					["author"] = "Details!",
					["desc"] = "Show who in your raid used a potion during the encounter.",
					["icon"] = "Interface\\ICONS\\INV_Potion_03",
					["attribute"] = false,
					["name"] = "Potion Used",
					["script"] = "				--init:\n				local combat, instance_container, instance = ...\n				local total, top, amount = 0, 0, 0\n				\n				--get the misc actor container\n				local misc_container = combat:GetActorList ( DETAILS_ATTRIBUTE_MISC )\n				\n				--do the loop:\n				for _, player in ipairs ( misc_container ) do \n					\n					--only player in group\n					if (player:IsGroupPlayer()) then\n						\n						local found_potion = false\n						\n						--get the spell debuff uptime container\n						local debuff_uptime_container = player.debuff_uptime and player.debuff_uptime_spells and player.debuff_uptime_spells._ActorTable\n						if (debuff_uptime_container) then\n							--potion of focus (can't use as pre-potion, so, its amount is always 1\n							local focus_potion = debuff_uptime_container [DETAILS_FOCUS_POTION_ID]\n							\n							if (focus_potion) then\n								total = total + 1\n								found_potion = true\n								if (top < 1) then\n									top = 1\n								end\n								--add amount to the player \n								instance_container:AddValue (player, 1)\n							end\n						end\n						\n						--get the spell buff uptime container\n						local buff_uptime_container = player.buff_uptime and player.buff_uptime_spells and player.buff_uptime_spells._ActorTable\n						if (buff_uptime_container) then\n							for spellId, _ in pairs (DetailsFramework.PotionIDs) do\n								local potionUsed = buff_uptime_container [spellId]\n				\n								if (potionUsed) then\n									local used = potionUsed.activedamt\n									if (used and used > 0) then\n										total = total + used\n										found_potion = true\n										if (used > top) then\n											top = used\n										end\n				\n										--add amount to the player \n										instance_container:AddValue (player, used)\n									end\n								end\n							end\n						end\n						\n						if (found_potion) then\n							amount = amount + 1\n						end    \n					end\n				end\n				\n				--return:\n				return total, top, amount\n				",
					["target"] = false,
					["tooltip"] = "			--init:\n			local player, combat, instance = ...\n			\n			--get the debuff container for potion of focus\n			local debuff_uptime_container = player.debuff_uptime and player.debuff_uptime_spells and player.debuff_uptime_spells._ActorTable\n			if (debuff_uptime_container) then\n				local focus_potion = debuff_uptime_container [DETAILS_FOCUS_POTION_ID]\n				if (focus_potion) then\n				local name, _, icon = GetSpellInfo (DETAILS_FOCUS_POTION_ID)\n				GameCooltip:AddLine (name, 1) --> can use only 1 focus potion (can't be pre-potion)\n				_detalhes:AddTooltipBackgroundStatusbar()\n				GameCooltip:AddIcon (icon, 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				end\n			end\n			\n			--get the misc actor container\n			local buff_uptime_container = player.buff_uptime and player.buff_uptime_spells and player.buff_uptime_spells._ActorTable\n			if (buff_uptime_container) then\n				for spellId, _ in pairs (DetailsFramework.PotionIDs) do\n					local potionUsed = buff_uptime_container [spellId]\n			\n					if (potionUsed) then\n						local name, _, icon = GetSpellInfo (spellId)\n						GameCooltip:AddLine (name, potionUsed.activedamt)\n						_detalhes:AddTooltipBackgroundStatusbar()\n						GameCooltip:AddIcon (icon, 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n					end\n				end\n			end\n			",
					["spellid"] = false,
					["script_version"] = 6,
				}, -- [1]
				{
					["source"] = false,
					["total_script"] = false,
					["author"] = "Details! Team",
					["percent_script"] = false,
					["desc"] = "Show who in your raid group used the healthstone or a heal potion.",
					["icon"] = "Interface\\ICONS\\INV_Stone_04",
					["spellid"] = false,
					["name"] = "Health Potion & Stone",
					["script"] = "			--get the parameters passed\n			local combat, instance_container, instance = ...\n			--declade the values to return\n			local total, top, amount = 0, 0, 0\n			\n			--do the loop\n			local AllHealCharacters = combat:GetActorList (DETAILS_ATTRIBUTE_HEAL)\n			for index, character in ipairs (AllHealCharacters) do\n				local AllSpells = character:GetSpellList()\n				local found = false\n				for spellid, spell in pairs (AllSpells) do\n					if (DETAILS_HEALTH_POTION_LIST [spellid]) then\n						instance_container:AddValue (character, spell.total)\n						total = total + spell.total\n						if (top < spell.total) then\n							top = spell.total\n						end\n						found = true\n					end\n				end\n			\n				if (found) then\n					amount = amount + 1\n				end\n			end\n			--loop end\n			--return the values\n			return total, top, amount\n			",
					["target"] = false,
					["tooltip"] = "			--get the parameters passed\n			local actor, combat, instance = ...\n			\n			--get the cooltip object (we dont use the convencional GameTooltip here)\n			local GameCooltip = GameCooltip\n			local R, G, B, A = 0, 0, 0, 0.75\n			\n			local hs = actor:GetSpell (6262)\n			if (hs) then\n				GameCooltip:AddLine (select (1, GetSpellInfo(6262)),  _detalhes:ToK(hs.total))\n				GameCooltip:AddIcon (select (3, GetSpellInfo (6262)), 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				GameCooltip:AddStatusBar (100, 1, R, G, B, A)\n			end\n			\n			local pot = actor:GetSpell (DETAILS_HEALTH_POTION_ID)\n			if (pot) then\n				GameCooltip:AddLine (select (1, GetSpellInfo(DETAILS_HEALTH_POTION_ID)),  _detalhes:ToK(pot.total))\n				GameCooltip:AddIcon (select (3, GetSpellInfo (DETAILS_HEALTH_POTION_ID)), 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				GameCooltip:AddStatusBar (100, 1, R, G, B, A)\n			end\n			\n			local pot = actor:GetSpell (DETAILS_REJU_POTION_ID)\n			if (pot) then\n				GameCooltip:AddLine (select (1, GetSpellInfo(DETAILS_REJU_POTION_ID)),  _detalhes:ToK(pot.total))\n				GameCooltip:AddIcon (select (3, GetSpellInfo (DETAILS_REJU_POTION_ID)), 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				GameCooltip:AddStatusBar (100, 1, R, G, B, A)\n			end\n\n			--Cooltip code\n			",
					["attribute"] = false,
					["script_version"] = 15,
				}, -- [2]
				{
					["source"] = false,
					["author"] = "Details!",
					["tooltip"] = "				\n			",
					["percent_script"] = "				local value, top, total, combat, instance = ...\n				return string.format (\"%.1f\", value/top*100)\n			",
					["desc"] = "Tells how much time each character spent doing damage.",
					["icon"] = "Interface\\Buttons\\UI-MicroStream-Red",
					["spellid"] = false,
					["name"] = "Damage Activity Time",
					["script"] = "				--init:\n				local combat, instance_container, instance = ...\n				local total, amount = 0, 0\n\n				--get the misc actor container\n				local damage_container = combat:GetActorList ( DETAILS_ATTRIBUTE_DAMAGE )\n				\n				--do the loop:\n				for _, player in ipairs ( damage_container ) do \n					if (player.grupo) then\n						local activity = player:Tempo()\n						total = total + activity\n						amount = amount + 1\n						--add amount to the player \n						instance_container:AddValue (player, activity)\n					end\n				end\n				\n				--return:\n				return total, combat:GetCombatTime(), amount\n			",
					["target"] = false,
					["total_script"] = "				local value, top, total, combat, instance = ...\n				local minutos, segundos = math.floor (value/60), math.floor (value%60)\n				return minutos .. \"m \" .. segundos .. \"s\"\n			",
					["attribute"] = false,
					["script_version"] = 3,
				}, -- [3]
				{
					["source"] = false,
					["author"] = "Details!",
					["tooltip"] = "				\n			",
					["percent_script"] = "				local value, top, total, combat, instance = ...\n				return string.format (\"%.1f\", value/top*100)\n			",
					["desc"] = "Tells how much time each character spent doing healing.",
					["icon"] = "Interface\\Buttons\\UI-MicroStream-Green",
					["spellid"] = false,
					["name"] = "Healing Activity Time",
					["script"] = "				--init:\n				local combat, instance_container, instance = ...\n				local total, top, amount = 0, 0, 0\n\n				--get the misc actor container\n				local damage_container = combat:GetActorList ( DETAILS_ATTRIBUTE_HEAL )\n				\n				--do the loop:\n				for _, player in ipairs ( damage_container ) do \n					if (player.grupo) then\n						local activity = player:Tempo()\n						total = total + activity\n						amount = amount + 1\n						--add amount to the player \n						instance_container:AddValue (player, activity)\n					end\n				end\n				\n				--return:\n				return total, combat:GetCombatTime(), amount\n			",
					["target"] = false,
					["total_script"] = "				local value, top, total, combat, instance = ...\n				local minutos, segundos = math.floor (value/60), math.floor (value%60)\n				return minutos .. \"m \" .. segundos .. \"s\"\n			",
					["attribute"] = false,
					["script_version"] = 2,
				}, -- [4]
				{
					["source"] = false,
					["author"] = "Details!",
					["desc"] = "Show the crowd control amount for each player.",
					["total_script"] = "				local value, top, total, combat, instance = ...\n				return floor (value)\n			",
					["icon"] = "Interface\\ICONS\\Spell_Frost_FreezingBreath",
					["spellid"] = false,
					["name"] = "Crowd Control Done",
					["tooltip"] = "				local actor, combat, instance = ...\n				local spells = {}\n				for spellid, spell in pairs (actor.cc_done_spells._ActorTable) do\n				    tinsert (spells, {spellid, spell.counter})\n				end\n\n				table.sort (spells, _detalhes.Sort2)\n\n				for index, spell in ipairs (spells) do\n				    local name, _, icon = GetSpellInfo (spell [1])\n				    GameCooltip:AddLine (name, spell [2])\n				    _detalhes:AddTooltipBackgroundStatusbar()\n				    GameCooltip:AddIcon (icon, 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				end\n\n				local targets = {}\n				for playername, amount in pairs (actor.cc_done_targets) do\n				    tinsert (targets, {playername, amount})\n				end\n\n				table.sort (targets, _detalhes.Sort2)\n\n				_detalhes:AddTooltipSpellHeaderText (\"Targets\", \"yellow\", #targets)\n				local class, _, _, _, _, r, g, b = _detalhes:GetClass (actor.nome)\n				_detalhes:AddTooltipHeaderStatusbar (1, 1, 1, 0.6)\n\n				for index, target in ipairs (targets) do\n				    GameCooltip:AddLine (target[1], target [2])\n				    _detalhes:AddTooltipBackgroundStatusbar()\n				    \n				    local class, _, _, _, _, r, g, b = _detalhes:GetClass (target [1])\n				    if (class and class ~= \"UNKNOW\") then\n					local texture, l, r, t, b = _detalhes:GetClassIcon (class)\n					GameCooltip:AddIcon (\"Interface\\\\AddOns\\\\Details\\\\images\\\\classes_small_alpha\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height, l, r, t, b)\n				    else\n					GameCooltip:AddIcon (\"Interface\\\\GossipFrame\\\\IncompleteQuestIcon\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				    end\n				    --\n				end\n			",
					["target"] = false,
					["script"] = "				local combat, instance_container, instance = ...\n				local total, top, amount = 0, 0, 0\n\n				local misc_actors = combat:GetActorList (DETAILS_ATTRIBUTE_MISC)\n\n				for index, character in ipairs (misc_actors) do\n					if (character.cc_done and character:IsPlayer()) then\n						local cc_done = floor (character.cc_done)\n						instance_container:AddValue (character, cc_done)\n						total = total + cc_done\n						if (cc_done > top) then\n							top = cc_done\n						end\n						amount = amount + 1\n					end\n				end\n\n				return total, top, amount\n			",
					["attribute"] = false,
					["script_version"] = 11,
				}, -- [5]
				{
					["source"] = false,
					["author"] = "Details!",
					["desc"] = "Show the amount of crowd control received for each player.",
					["total_script"] = "				local value, top, total, combat, instance = ...\n				return floor (value)\n			",
					["icon"] = "Interface\\ICONS\\Spell_Frost_ChainsOfIce",
					["spellid"] = false,
					["name"] = "Crowd Control Received",
					["tooltip"] = "				local actor, combat, instance = ...\n				local name = actor:name()\n				local spells, from = {}, {}\n				local misc_actors = combat:GetActorList (DETAILS_ATTRIBUTE_MISC)\n\n				for index, character in ipairs (misc_actors) do\n				    if (character.cc_done and character:IsPlayer()) then\n					local on_actor = character.cc_done_targets [name]\n					if (on_actor) then\n					    tinsert (from, {character:name(), on_actor})\n					    \n					    for spellid, spell in pairs (character.cc_done_spells._ActorTable) do\n						\n						local spell_on_actor = spell.targets [name]\n						if (spell_on_actor) then\n						    local has_spell\n						    for index, spell_table in ipairs (spells) do\n							if (spell_table [1] == spellid) then\n							    spell_table [2] = spell_table [2] + spell_on_actor\n							    has_spell = true\n							end\n						    end\n						    if (not has_spell) then\n							tinsert (spells, {spellid, spell_on_actor}) \n						    end\n						end\n						\n					    end            \n					end\n				    end\n				end\n\n				table.sort (from, _detalhes.Sort2)\n				table.sort (spells, _detalhes.Sort2)\n\n				for index, spell in ipairs (spells) do\n				    local name, _, icon = GetSpellInfo (spell [1])\n				    GameCooltip:AddLine (name, spell [2])\n				    _detalhes:AddTooltipBackgroundStatusbar()\n				    GameCooltip:AddIcon (icon, 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)    \n				end\n\n				_detalhes:AddTooltipSpellHeaderText (\"From\", \"yellow\", #from)\n				_detalhes:AddTooltipHeaderStatusbar (1, 1, 1, 0.6)\n\n				for index, t in ipairs (from) do\n				    GameCooltip:AddLine (t[1], t[2])\n				    _detalhes:AddTooltipBackgroundStatusbar()\n				    \n				    local class, _, _, _, _, r, g, b = _detalhes:GetClass (t [1])\n				    if (class and class ~= \"UNKNOW\") then\n					local texture, l, r, t, b = _detalhes:GetClassIcon (class)\n					GameCooltip:AddIcon (\"Interface\\\\AddOns\\\\Details\\\\images\\\\classes_small_alpha\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height, l, r, t, b)\n				    else\n					GameCooltip:AddIcon (\"Interface\\\\GossipFrame\\\\IncompleteQuestIcon\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				    end     \n				    \n				end\n			",
					["target"] = false,
					["script"] = "				local combat, instance_container, instance = ...\n				local total, top, amt = 0, 0, 0\n\n				local misc_actors = combat:GetActorList (DETAILS_ATTRIBUTE_MISC)\n				DETAILS_CUSTOM_CC_RECEIVED_CACHE = DETAILS_CUSTOM_CC_RECEIVED_CACHE or {}\n				wipe (DETAILS_CUSTOM_CC_RECEIVED_CACHE)\n\n				for index, character in ipairs (misc_actors) do\n				    if (character.cc_done and character:IsPlayer()) then\n					\n					for player_name, amount in pairs (character.cc_done_targets) do\n					    local target = combat (1, player_name) or combat (2, player_name)\n					    if (target and target:IsPlayer()) then\n						instance_container:AddValue (target, amount)\n						total = total + amount\n						if (amount > top) then\n						    top = amount\n						end\n						if (not DETAILS_CUSTOM_CC_RECEIVED_CACHE [player_name]) then\n						    DETAILS_CUSTOM_CC_RECEIVED_CACHE [player_name] = true\n						    amt = amt + 1\n						end\n					    end\n					end\n					\n				    end\n				end\n\n				return total, top, amt\n			",
					["attribute"] = false,
					["script_version"] = 3,
				}, -- [6]
				{
					["source"] = false,
					["tooltip"] = "			--config:\n			--Background RBG and Alpha:\n			local R, G, B, A = 0, 0, 0, 0.75\n			local R, G, B, A = 0.1960, 0.1960, 0.1960, 0.8697\n\n			--get the parameters passed\n			local spell, combat, instance = ...\n\n			--get the cooltip object (we dont use the convencional GameTooltip here)\n			local GC = GameCooltip\n			GC:SetOption (\"YSpacingMod\", 0)\n\n			local role = DetailsFramework.UnitGroupRolesAssigned (\"player\")\n\n			if (spell.n_dmg) then\n			    \n			    local spellschool, schooltext = spell.spellschool, \"\"\n			    if (spellschool) then\n				local t = _detalhes.spells_school [spellschool]\n				if (t and t.name) then\n				    schooltext = t.formated\n				end\n			    end\n			    \n			    local total_hits = spell.counter\n			    local combat_time = instance.showing:GetCombatTime()\n			    \n			    local debuff_uptime_total, cast_string = \"\", \"\"\n			    local misc_actor = instance.showing (4, _detalhes.playername)\n			    if (misc_actor) then\n				local debuff_uptime = misc_actor.debuff_uptime_spells and misc_actor.debuff_uptime_spells._ActorTable [spell.id] and misc_actor.debuff_uptime_spells._ActorTable [spell.id].uptime\n				if (debuff_uptime) then\n				    debuff_uptime_total = floor (debuff_uptime / instance.showing:GetCombatTime() * 100)\n				end\n				\n				local spell_cast = misc_actor.spell_cast and misc_actor.spell_cast [spell.id]\n				\n				if (not spell_cast and misc_actor.spell_cast) then\n				    local spellname = GetSpellInfo (spell.id)\n				    for casted_spellid, amount in pairs (misc_actor.spell_cast) do\n					local casted_spellname = GetSpellInfo (casted_spellid)\n					if (casted_spellname == spellname) then\n					    spell_cast = amount .. \" (|cFFFFFF00?|r)\"\n					end\n				    end\n				end\n				if (not spell_cast) then\n				    spell_cast = \"(|cFFFFFF00?|r)\"\n				end\n				cast_string = cast_string .. spell_cast\n			    end\n			    \n			    --Cooltip code\n			    GC:AddLine (\"Casts:\", cast_string or \"?\")\n			    GC:AddStatusBar (100, 1, R, G, B, A)\n			    \n			    if (debuff_uptime_total ~= \"\") then\n				GC:AddLine (\"Uptime:\", (debuff_uptime_total or \"?\") .. \"%\")\n				GC:AddStatusBar (100, 1, R, G, B, A)\n			    end\n			    \n			    GC:AddLine (\"Hits:\", spell.counter)\n			    GC:AddStatusBar (100, 1, R, G, B, A)\n			    \n			    local average = spell.total / total_hits\n			    GC:AddLine (\"Average:\", _detalhes:ToK (average))\n			    GC:AddStatusBar (100, 1, R, G, B, A)\n			    \n			    GC:AddLine (\"E-Dps:\", _detalhes:ToK (spell.total / combat_time))\n			    GC:AddStatusBar (100, 1, R, G, B, A)\n			    \n			    GC:AddLine (\"School:\", schooltext)\n			    GC:AddStatusBar (100, 1, R, G, B, A)\n			    \n			    --GC:AddLine (\" \")\n			    \n			    GC:AddLine (\"Normal Hits: \", spell.n_amt .. \" (\" ..floor ( spell.n_amt/total_hits*100) .. \"%)\")\n			    GC:AddStatusBar (100, 1, R, G, B, A)\n			    \n			    local n_average = spell.n_dmg / spell.n_amt\n			    local T = (combat_time*spell.n_dmg)/spell.total\n			    local P = average/n_average*100\n			    T = P*T/100\n			    \n			    GC:AddLine (\"Average / E-Dps: \",  _detalhes:ToK (n_average) .. \" / \" .. format (\"%.1f\",spell.n_dmg / T ))\n			    GC:AddStatusBar (100, 1, R, G, B, A)\n			    \n			    --GC:AddLine (\" \")\n			    \n			    GC:AddLine (\"Critical Hits: \", spell.c_amt .. \" (\" ..floor ( spell.c_amt/total_hits*100) .. \"%)\")\n			    GC:AddStatusBar (100, 1, R, G, B, A)\n			    \n			    if (spell.c_amt > 0) then\n				local c_average = spell.c_dmg/spell.c_amt\n				local T = (combat_time*spell.c_dmg)/spell.total\n				local P = average/c_average*100\n				T = P*T/100\n				local crit_dps = spell.c_dmg / T\n				\n				GC:AddLine (\"Average / E-Dps: \",  _detalhes:ToK (c_average) .. \" / \" .. _detalhes:comma_value (crit_dps))\n			    else\n				GC:AddLine (\"Average / E-Dps: \",  \"0 / 0\")    \n			    end\n			    \n			    GC:AddStatusBar (100, 1, R, G, B, A)\n\n			    \n			elseif (spell.n_curado) then\n			    \n			    local spellschool, schooltext = spell.spellschool, \"\"\n			    if (spellschool) then\n				local t = _detalhes.spells_school [spellschool]\n				if (t and t.name) then\n				    schooltext = t.formated\n				end\n			    end\n			    \n			    local total_hits = spell.counter\n			    local combat_time = instance.showing:GetCombatTime()\n			    \n			    --Cooltip code\n			    GC:AddLine (\"Hits:\", spell.counter)\n			    GC:AddStatusBar (100, 1, R, G, B, A)\n			    \n			    local average = spell.total / total_hits\n			    GC:AddLine (\"Average:\", _detalhes:ToK (average))\n			    GC:AddStatusBar (100, 1, R, G, B, A)\n			    \n			    GC:AddLine (\"E-Hps:\", _detalhes:ToK (spell.total / combat_time))\n			    GC:AddStatusBar (100, 1, R, G, B, A)\n			    \n			    GC:AddLine (\"School:\", schooltext)\n			    GC:AddStatusBar (100, 1, R, G, B, A)\n			    \n			    --GC:AddLine (\" \")\n			    \n			    GC:AddLine (\"Normal Hits: \", spell.n_amt .. \" (\" ..floor ( spell.n_amt/total_hits*100) .. \"%)\")\n			    GC:AddStatusBar (100, 1, R, G, B, A)\n			    \n			    local n_average = spell.n_curado / spell.n_amt\n			    local T = (combat_time*spell.n_curado)/spell.total\n			    local P = average/n_average*100\n			    T = P*T/100\n			    \n			    GC:AddLine (\"Average / E-Dps: \",  _detalhes:ToK (n_average) .. \" / \" .. format (\"%.1f\",spell.n_curado / T ))\n			    GC:AddStatusBar (100, 1, R, G, B, A)\n			    \n			    --GC:AddLine (\" \")\n			    \n			    GC:AddLine (\"Critical Hits: \", spell.c_amt .. \" (\" ..floor ( spell.c_amt/total_hits*100) .. \"%)\")\n			    GC:AddStatusBar (100, 1, R, G, B, A)\n			    \n			    if (spell.c_amt > 0) then\n				local c_average = spell.c_curado/spell.c_amt\n				local T = (combat_time*spell.c_curado)/spell.total\n				local P = average/c_average*100\n				T = P*T/100\n				local crit_dps = spell.c_curado / T\n				\n				GC:AddLine (\"Average / E-Hps: \",  _detalhes:ToK (c_average) .. \" / \" .. _detalhes:comma_value (crit_dps))\n			    else\n				GC:AddLine (\"Average / E-Hps: \",  \"0 / 0\")    \n			    end\n			    \n			    GC:AddStatusBar (100, 1, R, G, B, A)\n			end\n			",
					["percent_script"] = "				local value, top, total, combat, instance = ...\n				local dps = _detalhes:ToK (floor (value) / combat:GetCombatTime())\n				local percent = string.format (\"%.1f\", value/total*100)\n				return dps .. \", \" .. percent\n			",
					["desc"] = "Show your spells in the window.",
					["author"] = "Details!",
					["attribute"] = false,
					["name"] = "My Spells",
					["script"] = "				--get the parameters passed\n				local combat, instance_container, instance = ...\n				--declade the values to return\n				local total, top, amount = 0, 0, 0\n\n				local player\n				local pet_attribute\n				\n				local role = DetailsFramework.UnitGroupRolesAssigned (\"player\")\n				local spec = DetailsFramework.GetSpecialization()\n				role = spec and DetailsFramework.GetSpecializationRole (spec) or role\n\n				if (role == \"DAMAGER\") then\n					player = combat (DETAILS_ATTRIBUTE_DAMAGE, _detalhes.playername)\n					pet_attribute = DETAILS_ATTRIBUTE_DAMAGE\n				elseif (role == \"HEALER\") then    \n					player = combat (DETAILS_ATTRIBUTE_HEAL, _detalhes.playername)\n					pet_attribute = DETAILS_ATTRIBUTE_HEAL\n				else\n					player = combat (DETAILS_ATTRIBUTE_DAMAGE, _detalhes.playername)\n					pet_attribute = DETAILS_ATTRIBUTE_DAMAGE\n				end\n\n				--do the loop\n\n				if (player) then\n					local spells = player:GetSpellList()\n					for spellid, spell in pairs (spells) do\n						instance_container:AddValue (spell, spell.total)\n						total = total + spell.total\n						if (top < spell.total) then\n							top = spell.total\n						end\n						amount = amount + 1\n					end\n				    \n					for _, PetName in ipairs (player.pets) do\n						local pet = combat (pet_attribute, PetName)\n						if (pet) then\n							for spellid, spell in pairs (pet:GetSpellList()) do\n								instance_container:AddValue (spell, spell.total, nil, \" (\" .. PetName:gsub ((\" <.*\"), \"\") .. \")\")\n								total = total + spell.total\n								if (top < spell.total) then\n									top = spell.total\n								end\n								amount = amount + 1\n							end\n						end\n					end\n				end\n\n				--return the values\n				return total, top, amount\n			",
					["target"] = false,
					["spellid"] = false,
					["icon"] = "Interface\\CHATFRAME\\UI-ChatIcon-Battlenet",
					["script_version"] = 8,
				}, -- [7]
				{
					["source"] = false,
					["author"] = "Details!",
					["desc"] = "Show the amount of damage applied on targets marked with skull.",
					["icon"] = "Interface\\TARGETINGFRAME\\UI-RaidTargetingIcon_8",
					["attribute"] = false,
					["name"] = "Damage On Skull Marked Targets",
					["script"] = "				--get the parameters passed\n				local Combat, CustomContainer, Instance = ...\n				--declade the values to return\n				local total, top, amount = 0, 0, 0\n				\n				--raid target flags: \n				-- 128: skull \n				-- 64: cross\n				-- 32: square\n				-- 16: moon\n				-- 8: triangle\n				-- 4: diamond\n				-- 2: circle\n				-- 1: star\n				\n				--do the loop\n				for _, actor in ipairs (Combat:GetActorList (DETAILS_ATTRIBUTE_DAMAGE)) do\n				    if (actor:IsPlayer()) then\n					if (actor.raid_targets [128]) then\n					    CustomContainer:AddValue (actor, actor.raid_targets [128])\n					end        \n				    end\n				end\n\n				--if not managed inside the loop, get the values of total, top and amount\n				total, top = CustomContainer:GetTotalAndHighestValue()\n				amount = CustomContainer:GetNumActors()\n\n				--return the values\n				return total, top, amount\n			",
					["target"] = false,
					["tooltip"] = "				--get the parameters passed\n				local actor, combat, instance = ...\n\n				--get the cooltip object (we dont use the convencional GameTooltip here)\n				local GameCooltip = GameCooltip\n\n				--Cooltip code\n				local format_func = Details:GetCurrentToKFunction()\n\n				--Cooltip code\n				local RaidTargets = actor.raid_targets\n\n				local DamageOnStar = RaidTargets [128]\n				if (DamageOnStar) then\n				    --RAID_TARGET_8 is the built-in localized word for 'Skull'.\n				    GameCooltip:AddLine (RAID_TARGET_8 .. \":\", format_func (_, DamageOnStar))\n				    GameCooltip:AddIcon (\"Interface\\\\TARGETINGFRAME\\\\UI-RaidTargetingIcon_8\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				    Details:AddTooltipBackgroundStatusbar()\n				end\n			",
					["spellid"] = false,
					["script_version"] = 3,
				}, -- [8]
				{
					["source"] = false,
					["author"] = "Details!",
					["desc"] = "Show the amount of damage applied on targets marked with any other mark.",
					["icon"] = "Interface\\TARGETINGFRAME\\UI-RaidTargetingIcon_5",
					["attribute"] = false,
					["name"] = "Damage On Other Marked Targets",
					["script"] = "				--get the parameters passed\n				local Combat, CustomContainer, Instance = ...\n				--declade the values to return\n				local total, top, amount = 0, 0, 0\n\n				--do the loop\n				for _, actor in ipairs (Combat:GetActorList (DETAILS_ATTRIBUTE_DAMAGE)) do\n				    if (actor:IsPlayer()) then\n					local total = (actor.raid_targets [1] or 0) --star\n					total = total + (actor.raid_targets [2] or 0) --circle\n					total = total + (actor.raid_targets [4] or 0) --diamond\n					total = total + (actor.raid_targets [8] or 0) --tiangle\n					total = total + (actor.raid_targets [16] or 0) --moon\n					total = total + (actor.raid_targets [32] or 0) --square\n					total = total + (actor.raid_targets [64] or 0) --cross\n					\n					if (total > 0) then\n					    CustomContainer:AddValue (actor, total)\n					end\n				    end\n				end\n\n				--if not managed inside the loop, get the values of total, top and amount\n				total, top = CustomContainer:GetTotalAndHighestValue()\n				amount = CustomContainer:GetNumActors()\n\n				--return the values\n				return total, top, amount\n			",
					["target"] = false,
					["tooltip"] = "				--get the parameters passed\n				local actor, combat, instance = ...\n\n				--get the cooltip object\n				local GameCooltip = GameCooltip\n\n				local format_func = Details:GetCurrentToKFunction()\n\n				--Cooltip code\n				local RaidTargets = actor.raid_targets\n\n				local DamageOnStar = RaidTargets [1]\n				if (DamageOnStar) then\n				    GameCooltip:AddLine (RAID_TARGET_1 .. \":\", format_func (_, DamageOnStar))\n				    GameCooltip:AddIcon (\"Interface\\\\TARGETINGFRAME\\\\UI-RaidTargetingIcon_1\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				    Details:AddTooltipBackgroundStatusbar()\n				end\n\n				local DamageOnCircle = RaidTargets [2]\n				if (DamageOnCircle) then\n				    GameCooltip:AddLine (RAID_TARGET_2 .. \":\", format_func (_, DamageOnCircle))\n				    GameCooltip:AddIcon (\"Interface\\\\TARGETINGFRAME\\\\UI-RaidTargetingIcon_2\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				    Details:AddTooltipBackgroundStatusbar()\n				end\n\n				local DamageOnDiamond = RaidTargets [4]\n				if (DamageOnDiamond) then\n				    GameCooltip:AddLine (RAID_TARGET_3 .. \":\", format_func (_, DamageOnDiamond))\n				    GameCooltip:AddIcon (\"Interface\\\\TARGETINGFRAME\\\\UI-RaidTargetingIcon_3\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				    Details:AddTooltipBackgroundStatusbar()\n				end\n\n				local DamageOnTriangle = RaidTargets [8]\n				if (DamageOnTriangle) then\n				    GameCooltip:AddLine (RAID_TARGET_4 .. \":\", format_func (_, DamageOnTriangle))\n				    GameCooltip:AddIcon (\"Interface\\\\TARGETINGFRAME\\\\UI-RaidTargetingIcon_4\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				    Details:AddTooltipBackgroundStatusbar()\n				end\n\n				local DamageOnMoon = RaidTargets [16]\n				if (DamageOnMoon) then\n				    GameCooltip:AddLine (RAID_TARGET_5 .. \":\", format_func (_, DamageOnMoon))\n				    GameCooltip:AddIcon (\"Interface\\\\TARGETINGFRAME\\\\UI-RaidTargetingIcon_5\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				    Details:AddTooltipBackgroundStatusbar()\n				end\n\n				local DamageOnSquare = RaidTargets [32]\n				if (DamageOnSquare) then\n				    GameCooltip:AddLine (RAID_TARGET_6 .. \":\", format_func (_, DamageOnSquare))\n				    GameCooltip:AddIcon (\"Interface\\\\TARGETINGFRAME\\\\UI-RaidTargetingIcon_6\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				    Details:AddTooltipBackgroundStatusbar()\n				end\n\n				local DamageOnCross = RaidTargets [64]\n				if (DamageOnCross) then\n				    GameCooltip:AddLine (RAID_TARGET_7 .. \":\", format_func (_, DamageOnCross))\n				    GameCooltip:AddIcon (\"Interface\\\\TARGETINGFRAME\\\\UI-RaidTargetingIcon_7\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				    Details:AddTooltipBackgroundStatusbar()\n				end\n			",
					["spellid"] = false,
					["script_version"] = 3,
				}, -- [9]
				{
					["source"] = false,
					["author"] = "Details!",
					["desc"] = "Damage done to shields",
					["icon"] = "Interface\\ICONS\\Spell_Holy_PowerWordShield",
					["attribute"] = false,
					["name"] = "Damage on Shields",
					["script"] = "				--get the parameters passed\n				local Combat, CustomContainer, Instance = ...\n				--declade the values to return\n				local total, top, amount = 0, 0, 0\n\n				--do the loop\n				for index, actor in ipairs (Combat:GetActorList(1)) do\n				    if (actor:IsPlayer()) then\n					\n					--get the actor total damage absorbed\n					local totalAbsorb = actor.totalabsorbed\n					\n					--get the damage absorbed by all the actor pets\n					for petIndex, petName in ipairs (actor.pets) do\n					    local pet = Combat :GetActor (1, petName)\n					    if (pet) then\n						totalAbsorb = totalAbsorb + pet.totalabsorbed\n					    end\n					end\n					\n					--add the value to the actor on the custom container\n					CustomContainer:AddValue (actor, totalAbsorb)        \n					\n				    end\n				end\n				--loop end\n\n				--if not managed inside the loop, get the values of total, top and amount\n				total, top = CustomContainer:GetTotalAndHighestValue()\n				amount = CustomContainer:GetNumActors()\n\n				--return the values\n				return total, top, amount\n			",
					["target"] = false,
					["tooltip"] = "				--get the parameters passed\n				local actor, Combat, instance = ...\n\n				--get the cooltip object (we dont use the convencional GameTooltip here)\n				local GameCooltip = GameCooltip\n\n				--Cooltip code\n				--get the actor total damage absorbed\n				local totalAbsorb = actor.totalabsorbed\n				local format_func = Details:GetCurrentToKFunction()\n\n				--get the damage absorbed by all the actor pets\n				for petIndex, petName in ipairs (actor.pets) do\n				    local pet = Combat :GetActor (1, petName)\n				    if (pet) then\n					totalAbsorb = totalAbsorb + pet.totalabsorbed\n				    end\n				end\n\n				GameCooltip:AddLine (actor:Name(), format_func (_, actor.totalabsorbed))\n				Details:AddTooltipBackgroundStatusbar()\n\n				for petIndex, petName in ipairs (actor.pets) do\n				    local pet = Combat :GetActor (1, petName)\n				    if (pet) then\n					totalAbsorb = totalAbsorb + pet.totalabsorbed\n					\n					GameCooltip:AddLine (petName, format_func (_, pet.totalabsorbed))\n					Details:AddTooltipBackgroundStatusbar()        \n					\n				    end\n				end\n			",
					["spellid"] = false,
					["script_version"] = 1,
				}, -- [10]
				{
					["source"] = false,
					["author"] = "Effecta-Stormrage",
					["percent_script"] = false,
					["total_script"] = false,
					["desc"] = "Number of CCs casted",
					["spellid"] = false,
					["name"] = "Crowd Control",
					["script"] = "							--get the parameters passed\n							local Combat, CustomContainer, Instance = ...\n							--declade the values to return\n							local total, top, amount = 0, 0, 0\n							\n							--do the loop\n								--CustomContainer:AddValue (actor, actor.value)\n							--loop end\n							\n							--if not managed inside the loop, get the values of total, top and amount\n							total, top = CustomContainer:GetTotalAndHighestValue()\n							amount = CustomContainer:GetNumActors()\n							\n							--return the values\n							return total, top, amount\n						",
					["target"] = false,
					["tooltip"] = "							--get the parameters passed\n							local actor, combat, instance = ...\n							\n							--get the cooltip object (we dont use the convencional GameTooltip here)\n							local GameCooltip = GameCooltip\n							\n							--Cooltip code\n						",
					["icon"] = 237579,
					["attribute"] = false,
				}, -- [11]
				{
					["source"] = false,
					["author"] = "Bass",
					["total_script"] = "        local value, top, total, Combat, Instance, Actor = ...\n\n        local format_func = Details:GetCurrentToKFunction()\n        if _G.Details_Elitism then\n            local damage, cnt = _G.Details_Elitism:GetRecord(Combat:GetCombatNumber(), Actor.my_actor.serial)\n            return \"\" .. format_func(_, damage) .. \" (\" .. cnt .. \")\"\n            -- return _G.Details_Elitism:GetDisplayText(Combat:GetCombatNumber(), Actor.my_actor.serial)\n        end\n        return \"\"\n    ",
					["desc"] = "Show how much avoidable damage was taken.",
					["attribute"] = false,
					["script"] = "        local Combat, CustomContainer, Instance = ...\n        local total, top, amount = 0, 0, 0\n\n        if _G.Details_Elitism then\n            local Container = Combat:GetActorList(DETAILS_ATTRIBUTE_MISC)\n            for _, player in ipairs(Container) do\n                if player:IsGroupPlayer() then\n                    -- we only record the players in party\n                    local damage, cnt = _G.Details_Elitism:GetRecord(Combat:GetCombatNumber(), player:guid())\n                    if damage > 0 or cnt > 0 then\n                        CustomContainer:AddValue(player, damage)\n                    end\n                end\n            end\n\n            total, top = CustomContainer:GetTotalAndHighestValue()\n            amount = CustomContainer:GetNumActors()\n        end\n\n        return total, top, amount\n    ",
					["name"] = "Avoidable Damage Taken",
					["tooltip"] = "        local Actor, Combat, Instance = ...\n        local GameCooltip = GameCooltip\n\n        if _G.Details_Elitism then\n            local realCombat\n            for i = -1, 25 do\n                local current = Details:GetCombat(i)\n                if current and current:GetCombatNumber() == Combat.combat_counter then\n                    realCombat = current\n                    break\n                end\n            end\n\n            if not realCombat then return end\n\n            local sortedList = {}\n            _, _, spells = _G.Details_Elitism:GetRecord(Combat:GetCombatNumber(), realCombat[1]:GetActor(Actor.nome):guid())\n            for spellID, spelldata in pairs(spells) do\n                tinsert(sortedList, {spellID, spelldata.sum})\n            end\n            -- local spellList = realCombat[1]:GetActor(Actor.nome):GetSpellList()\n            -- local orbName = _G.Details_Elitism:RequireOrbName()\n            -- for spellID, spellTable in pairs(spellList) do\n            --     local amount = spellTable.targets[orbName]\n            --     if amount then\n            --         tinsert(sortedList, {spellID, amount})\n            --     end\n            -- end\n            sort(sortedList, Details.Sort2)\n\n            local format_func = Details:GetCurrentToKFunction()\n            for _, tbl in ipairs(sortedList) do\n                local spellID, amount = unpack(tbl)\n                local spellName, _, spellIcon = Details.GetSpellInfo(spellID)\n\n                GameCooltip:AddLine(spellName, format_func(_, amount))\n                Details:AddTooltipBackgroundStatusbar()\n                GameCooltip:AddIcon(spellIcon, 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n            end\n        end\n    ",
					["target"] = false,
					["spellid"] = false,
					["icon"] = 2175503,
					["script_version"] = 1,
				}, -- [12]
				{
					["source"] = false,
					["author"] = "Bass",
					["total_script"] = "        local value, top, total, Combat, Instance, Actor = ...\n\n        local format_func = Details:GetCurrentToKFunction()\n        if _G.Details_Elitism then\n            local cnt, _ = _G.Details_Elitism:GetAuraRecord(Combat:GetCombatNumber(), Actor.my_actor.serial)\n            return \"\" .. cnt\n        end\n        return \"\"\n    ",
					["desc"] = "Show how many avoidable abilities hit players.",
					["attribute"] = false,
					["script"] = "        local Combat, CustomContainer, Instance = ...\n        local total, top, amount = 0, 0, 0\n\n        if _G.Details_Elitism then\n            local Container = Combat:GetActorList(DETAILS_ATTRIBUTE_MISC)\n            for _, player in ipairs(Container) do\n                if player:IsGroupPlayer() then\n                    -- we only record the players in party\n                    local cnt, _ = _G.Details_Elitism:GetAuraRecord(Combat:GetCombatNumber(), player:guid())\n                    -- _G.Details_Elitism:Debug(\"guid %s target %s hit %s\", player:guid() or 0, target or 0,hit or 0)\n                    if cnt > 0 then\n                        CustomContainer:AddValue(player, cnt)\n                    end\n                end\n            end\n\n            total, top = CustomContainer:GetTotalAndHighestValue()\n            amount = CustomContainer:GetNumActors()\n        end\n\n        return total, top, amount\n    ",
					["name"] = "Avoidable Abilities Taken",
					["tooltip"] = "        local Actor, Combat, Instance = ...\n        local GameCooltip = GameCooltip\n\n        if _G.Details_Elitism then\n            local realCombat\n            for i = -1, 25 do\n                local current = Details:GetCombat(i)\n                if current and current:GetCombatNumber() == Combat.combat_counter then\n                    realCombat = current\n                    break\n                end\n            end\n\n            if not realCombat then return end\n\n            local sortedList = {}\n            _, spells = _G.Details_Elitism:GetAuraRecord(Combat:GetCombatNumber(), realCombat[1]:GetActor(Actor.nome):guid())\n            for spellID, spelldata in pairs(spells) do\n                tinsert(sortedList, {spellID, spelldata.cnt})\n            end\n            -- local spellList = realCombat[1]:GetActor(Actor.nome):GetSpellList()\n            -- local orbName = _G.Details_Elitism:RequireOrbName()\n            -- for spellID, spellTable in pairs(spellList) do\n            --     local amount = spellTable.targets[orbName]\n            --     if amount then\n            --         tinsert(sortedList, {spellID, amount})\n            --     end\n            -- end\n            sort(sortedList, Details.Sort2)\n\n            local format_func = Details:GetCurrentToKFunction()\n            for _, tbl in ipairs(sortedList) do\n                local spellID, cnt = unpack(tbl)\n                local spellName, _, spellIcon = Details.GetSpellInfo(spellID)\n\n                GameCooltip:AddLine(spellName, format_func(_, cnt))\n                Details:AddTooltipBackgroundStatusbar()\n                GameCooltip:AddIcon(spellIcon, 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n            end\n        end\n    ",
					["target"] = false,
					["spellid"] = false,
					["icon"] = 2175503,
					["script_version"] = 1,
				}, -- [13]
				{
					["source"] = false,
					["total_script"] = "				local value, top, total, combat, instance = ...\n				return value\n			",
					["author"] = "Details!",
					["percent_script"] = "				local value, top, total, combat, instance = ...\n\n				--get the time of overall combat\n				local OverallCombatTime = Details:GetCombat (-1):GetCombatTime()\n				\n				--get the time of current combat if the player is in combat\n				if (Details.in_combat) then\n					local CurrentCombatTime = Details:GetCombat (0):GetCombatTime()\n					OverallCombatTime = OverallCombatTime + CurrentCombatTime\n				end\n				\n				--calculate the DPS and return it as percent\n				local totalValue = value\n				\n				--build the string\n				local ToK = Details:GetCurrentToKFunction()\n				local s = ToK (_, value / OverallCombatTime)\n				\n				return s\n			",
					["desc"] = "Show overall damage done on the fly.",
					["attribute"] = false,
					["script"] = "				--init:\n				local combat, instance_container, instance = ...\n				local total, top, amount = 0, 0, 0\n				\n				--get the overall combat\n				local OverallCombat = Details:GetCombat (-1)\n				--get the current combat\n				local CurrentCombat = Details:GetCombat (0)\n				\n				if (not OverallCombat.GetActorList or not CurrentCombat.GetActorList) then\n					return 0, 0, 0\n				end\n				\n				--get the damage actor container for overall\n				local damage_container_overall = OverallCombat:GetActorList ( DETAILS_ATTRIBUTE_DAMAGE )\n				--get the damage actor container for current\n				local damage_container_current = CurrentCombat:GetActorList ( DETAILS_ATTRIBUTE_DAMAGE )\n				\n				--do the loop:\n				for _, player in ipairs ( damage_container_overall ) do \n					--only player in group\n					if (player:IsGroupPlayer()) then\n						instance_container:AddValue (player, player.total)\n					end\n				end\n				\n				if (Details.in_combat) then\n					for _, player in ipairs ( damage_container_current ) do \n						--only player in group\n						if (player:IsGroupPlayer()) then\n							instance_container:AddValue (player, player.total)        \n						end\n					end\n				end\n				\n				total, top =  instance_container:GetTotalAndHighestValue()\n				amount =  instance_container:GetNumActors()\n				\n				--return:\n				return total, top, amount\n			",
					["name"] = "Dynamic Overall Damage",
					["tooltip"] = "				--get the parameters passed\n				local actor, combat, instance = ...\n\n				--get the cooltip object (we dont use the convencional GameTooltip here)\n				local GameCooltip = GameCooltip2\n\n				--Cooltip code\n				--get the overall combat\n				local OverallCombat = Details:GetCombat (-1)\n				--get the current combat\n				local CurrentCombat = Details:GetCombat (0)\n\n				local AllSpells = {}\n\n				local playerTotal = 0\n\n				--overall\n				local player = OverallCombat [1]:GetActor (actor.nome)\n				playerTotal = playerTotal + player.total\n				local playerSpells = player:GetSpellList()\n				for spellID, spellTable in pairs (playerSpells) do\n					AllSpells [spellID] = spellTable.total\n				end\n\n				--current\n				local player = CurrentCombat [1]:GetActor (actor.nome)\n				if (player) then\n					playerTotal = playerTotal + player.total\n					local playerSpells = player:GetSpellList()\n					for spellID, spellTable in pairs (playerSpells) do\n						AllSpells [spellID] = (AllSpells [spellID] or 0) + (spellTable.total or 0)\n					end\n				end\n\n				local sortedList = {}\n				for spellID, total in pairs (AllSpells) do\n					tinsert (sortedList, {spellID, total})\n				end\n				table.sort (sortedList, Details.Sort2)\n\n				local format_func = Details:GetCurrentToKFunction()\n\n				--build the tooltip\n\n				local topSpellTotal = sortedList and sortedList[1] and sortedList[1][2] or 0\n\n				for i, t in ipairs (sortedList) do\n					local spellID, total = unpack (t)\n					if (total > 1) then\n						local spellName, _, spellIcon = Details.GetSpellInfo (spellID)\n						\n						local spellPercent = total / playerTotal * 100\n						local formatedSpellPercent = format(\"%.1f\", spellPercent)\n						\n						if (string.len(formatedSpellPercent) < 4) then\n							formatedSpellPercent = formatedSpellPercent  .. \"0\"\n						end\n						\n						GameCooltip:AddLine (spellName, format_func (_, total) .. \"    \" .. formatedSpellPercent  .. \"%\")\n						\n						Details:AddTooltipBackgroundStatusbar(false, total / topSpellTotal * 100)\n						GameCooltip:AddIcon (spellIcon, 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height, 0.078125, 0.921875, 0.078125, 0.921875)\n						\n					end\n				end\n			",
					["target"] = false,
					["spellid"] = false,
					["icon"] = "Interface\\Buttons\\Spell-Reset",
					["script_version"] = 6,
				}, -- [14]
			},
			["damage_scroll_auto_open"] = false,
			["latest_news_saw"] = "v9.0.5.8357",
			["realm_sync"] = true,
			["current_exp_raid_encounters"] = {
				[2417] = true,
				[2418] = true,
				[2412] = true,
				[2405] = true,
				[2398] = true,
				[2406] = true,
				[2399] = true,
				[2407] = true,
				[2402] = true,
				[2383] = true,
			},
			["run_code"] = {
				["on_groupchange"] = "\n-- this code runs when the player enter or leave a group",
				["on_zonechanged"] = "\n-- when the player changes zone, this code will run",
				["on_init"] = "\n-- code to run when Details! initializes, put here code which only will run once\n-- this also will run then the profile is changed\n\n--size of the death log tooltip in the Deaths display (default 350)\nDetails.death_tooltip_width = 350;\n\n--when in arena or battleground, details! silently switch to activity time (goes back to the old setting on leaving, default true)\nDetails.force_activity_time_pvp = true;\n\n--speed of the bar animations (default 33)\nDetails.animation_speed = 33;\n\n--threshold to trigger slow or fast speed (default 0.45)\nDetails.animation_speed_mintravel = 0.45;\n\n--call to update animations\nDetails:RefreshAnimationFunctions();\n\n--max window size, does require a /reload to work (default 480 x 450)\nDetails.max_window_size.width = 480;\nDetails.max_window_size.height = 450;\n\n--use the arena team color as the class color (default true)\nDetails.color_by_arena_team = true;\n\n--use the role icon in the player bar when inside an arena (default false)\nDetails.show_arena_role_icon = false;\n\n--how much time the update warning is shown (default 10)\nDetails.update_warning_timeout = 10;",
				["on_specchanged"] = "\n-- run when the player changes its spec",
				["on_leavecombat"] = "\n-- this code runs when the player leave combat",
				["on_entercombat"] = "\n-- this code runs when the player enters in combat",
			},
			["show_totalhitdamage_on_overkill"] = false,
			["exit_errors"] = {
				"v9.0.2.8246 Interface\\AddOns\\Details\\core\\meta.lua:644: attempt to perform arithmetic on field '?' (a nil value)", -- [1]
			},
			["data_wipes_exp"] = {
				["9"] = true,
				["14"] = false,
				["13"] = false,
				["12"] = false,
				["11"] = false,
				["10"] = false,
			},
			["spellid_ignored"] = {
			},
			["createauraframe"] = {
				["y"] = 0.0001068115234375,
				["x"] = 0.00018310546875,
				["point"] = "CENTER",
				["scale"] = 1,
			},
			["global_plugin_database"] = {
				["DETAILS_PLUGIN_ENCOUNTER_DETAILS"] = {
					["encounter_timers_dbm"] = {
					},
					["encounter_timers_bw"] = {
					},
				},
			},
			["savedStyles"] = {
			},
			["savedCustomSpells"] = {
				{
					2, -- [1]
					"Auto Shot", -- [2]
					"Interface\\ICONS\\INV_Weapon_Bow_07", -- [3]
				}, -- [1]
				{
					3, -- [1]
					"Environment (Falling)", -- [2]
					"Interface\\ICONS\\Spell_Magic_FeatherFall", -- [3]
				}, -- [2]
				{
					55090, -- [1]
					"Scourge Strike (Physical)", -- [2]
					237530, -- [3]
				}, -- [3]
				{
					4, -- [1]
					"Environment (Drowning)", -- [2]
					"Interface\\ICONS\\Ability_Suffocate", -- [3]
				}, -- [4]
				{
					5, -- [1]
					"Environment (Fatigue)", -- [2]
					"Interface\\ICONS\\Spell_Arcane_MindMastery", -- [3]
				}, -- [5]
				{
					6, -- [1]
					"Environment (Fire)", -- [2]
					"Interface\\ICONS\\INV_SummerFest_FireSpirit", -- [3]
				}, -- [6]
				{
					7, -- [1]
					"Environment (Lava)", -- [2]
					"Interface\\ICONS\\Ability_Rhyolith_Volcano", -- [3]
				}, -- [7]
				{
					8, -- [1]
					"Environment (Slime)", -- [2]
					"Interface\\ICONS\\Ability_Creature_Poison_02", -- [3]
				}, -- [8]
				{
					59638, -- [1]
					"Frostbolt (Mirror Image)", -- [2]
					135846, -- [3]
				}, -- [9]
				{
					49184, -- [1]
					"Howling Blast (Main Target)", -- [2]
					135833, -- [3]
				}, -- [10]
				{
					44461, -- [1]
					"Living Bomb (explosion)", -- [2]
					236220, -- [3]
				}, -- [11]
				{
					278227, -- [1]
					"Barkspines (Trinket)", -- [2]
					134439, -- [3]
				}, -- [12]
				{
					268998, -- [1]
					"Kindled Soul (Trinket)", -- [2]
					651093, -- [3]
				}, -- [13]
				{
					196917, -- [1]
					"Light of the Martyr (Damage)", -- [2]
					135938, -- [3]
				}, -- [14]
				{
					120761, -- [1]
					"Glaive Toss (Glaive #2)", -- [2]
					132330, -- [3]
				}, -- [15]
				{
					278812, -- [1]
					"Lion's Grace (Trinket)", -- [2]
					464140, -- [3]
				}, -- [16]
				{
					270827, -- [1]
					"Webweaver's Soul Gem (Trinket)", -- [2]
					237431, -- [3]
				}, -- [17]
				{
					212739, -- [1]
					"Epidemic (Main Target)", -- [2]
					136066, -- [3]
				}, -- [18]
				{
					279664, -- [1]
					"Bloody Bile (Trinket)", -- [2]
					136007, -- [3]
				}, -- [19]
				{
					237680, -- [1]
					"Howling Blast (AoE)", -- [2]
					135833, -- [3]
				}, -- [20]
				{
					215969, -- [1]
					"Epidemic (AoE)", -- [2]
					136066, -- [3]
				}, -- [21]
				{
					278359, -- [1]
					"Blood Hatred (Trinket)", -- [2]
					132175, -- [3]
				}, -- [22]
				{
					278155, -- [1]
					"Lingering Power of Xalzaix (Trinket)", -- [2]
					254105, -- [3]
				}, -- [23]
				{
					271115, -- [1]
					"Ignition Mage's Fuse (Trinket)", -- [2]
					1119937, -- [3]
				}, -- [24]
				{
					277179, -- [1]
					"Gladiator's Medallion (Trinket)", -- [2]
					252267, -- [3]
				}, -- [25]
				{
					70890, -- [1]
					"Scourge Strike (Shadow)", -- [2]
					237530, -- [3]
				}, -- [26]
				{
					278057, -- [1]
					"Volatile Blood Explosion (Trinket)", -- [2]
					538040, -- [3]
				}, -- [27]
				{
					277185, -- [1]
					"Gladiator's Badge (Trinket)", -- [2]
					135884, -- [3]
				}, -- [28]
				{
					228649, -- [1]
					"Blackout Kick (Passive)", -- [2]
					574575, -- [3]
				}, -- [29]
				{
					121414, -- [1]
					"Glaive Toss (Glaive #1)", -- [2]
					132330, -- [3]
				}, -- [30]
				{
					94472, -- [1]
					"Atonement (critical)", -- [2]
					135887, -- [3]
				}, -- [31]
				{
					277187, -- [1]
					"Gladiator's Emblem (Trinket)", -- [2]
					132344, -- [3]
				}, -- [32]
				{
					277181, -- [1]
					"Gladiator's Insignia (Trinket)", -- [2]
					134501, -- [3]
				}, -- [33]
				{
					278862, -- [1]
					"Chill of the Runes (Trinket)", -- [2]
					252270, -- [3]
				}, -- [34]
				{
					271462, -- [1]
					"Rotcrusted Voodoo Doll (Trinket)", -- [2]
					1716867, -- [3]
				}, -- [35]
				{
					270925, -- [1]
					"Waterspout (Trinket)", -- [2]
					1698701, -- [3]
				}, -- [36]
				{
					271071, -- [1]
					"Conch of Dark Whispers (Trinket)", -- [2]
					1498840, -- [3]
				}, -- [37]
				{
					271465, -- [1]
					"Rotcrusted Voodoo Doll (Trinket)", -- [2]
					1716867, -- [3]
				}, -- [38]
				{
					33778, -- [1]
					"Lifebloom (Bloom)", -- [2]
					134206, -- [3]
				}, -- [39]
				{
					88082, -- [1]
					"Fireball (Mirror Image)", -- [2]
					135812, -- [3]
				}, -- [40]
				{
					1, -- [1]
					"Melee", -- [2]
					"Interface\\ICONS\\INV_Sword_04", -- [3]
				}, -- [41]
				{
					278383, -- [1]
					"Ruffling Tempest (Trinket)", -- [2]
					2103829, -- [3]
				}, -- [42]
				{
					271671, -- [1]
					"Cacaphonous Chord (Trinket)", -- [2]
					454048, -- [3]
				}, -- [43]
				{
					98021, -- [1]
					"Health Exchange", -- [2]
					237586, -- [3]
				}, -- [44]
				{
					339538, -- [1]
					"Templar's Verdict (Templar's Vindication)", -- [2]
					461860, -- [3]
				}, -- [45]
				{
					345020, -- [1]
					"Skulking Predator (Trinket)", -- [2]
					2103921, -- [3]
				}, -- [46]
				{
					108271, -- [1]
					"Astral Shift", -- [2]
					"Interface\\Addons\\Details\\images\\icon_astral_shift", -- [3]
				}, -- [47]
			},
			["update_warning_timeout"] = 10,
			["item_level_pool"] = {
			},
			["raid_data"] = {
				["mythic_raid_data"] = {
				},
			},
			["switchSaved"] = {
				["slots"] = 32,
				["table"] = {
					{
						["atributo"] = 1,
						["sub_atributo"] = 1,
					}, -- [1]
					{
						["atributo"] = 2,
						["sub_atributo"] = 1,
					}, -- [2]
					{
						["atributo"] = 1,
						["sub_atributo"] = 6,
					}, -- [3]
					{
						["atributo"] = 4,
						["sub_atributo"] = 5,
					}, -- [4]
					{
					}, -- [5]
					{
					}, -- [6]
					{
					}, -- [7]
					{
					}, -- [8]
					{
					}, -- [9]
					{
					}, -- [10]
					{
					}, -- [11]
					{
					}, -- [12]
					{
					}, -- [13]
					{
					}, -- [14]
					{
					}, -- [15]
					{
					}, -- [16]
					{
					}, -- [17]
					{
					}, -- [18]
					{
					}, -- [19]
					{
					}, -- [20]
					{
					}, -- [21]
					{
					}, -- [22]
					{
					}, -- [23]
					{
					}, -- [24]
					{
					}, -- [25]
					{
					}, -- [26]
					{
					}, -- [27]
					{
					}, -- [28]
					{
					}, -- [29]
					{
					}, -- [30]
					{
					}, -- [31]
					{
					}, -- [32]
				},
			},
			["always_use_profile_name"] = "Eltreum Dual",
			["profile_by_spec"] = {
			},
			["always_use_profile_exception"] = {
			},
			["details_auras"] = {
			},
			["displays_by_spec"] = {
			},
			["savedTimeCaptures"] = {
				{
					"Player Damage Done", -- [1]
					"\n	-- the goal of this script is get the current combat then get your character and extract your damage done.\n	-- the first thing to do is get the combat, so, we use here the command \"_detalhes:GetCombat ( \"overall\" \"current\" or \"segment number\")\"\n	\n	local current_combat = _detalhes:GetCombat (\"current\") --> getting the current combat\n	\n	-- the next step is request your character from the combat\n	-- to do this, we take the combat which here we named \"current_combat\" and tells what we want inside parentheses.\n	\n	local my_self = current_combat (DETAILS_ATTRIBUTE_DAMAGE, _detalhes.playername)\n	\n	-- _detalhes.playername holds the name of your character.\n	-- DETAILS_ATTRIBUTE_DAMAGE means we want the damage table, _HEAL _ENERGY _MISC is the other 3 tables.\n	\n	-- before we proceed, the result needs to be checked to make sure its a valid result.\n	\n	if (not my_self) then\n		return 0 -- the combat doesnt have *you*, this happens when you didn't deal any damage in the combat yet.\n	end\n	\n	-- now its time to get the total damage.\n	\n	local my_damage = my_self.total\n	\n	-- then finally return the amount to the capture.\n	\n	return my_damage\n	\n", -- [2]
					{
						["max_value"] = 0,
						["last_value"] = 0,
					}, -- [3]
					"Chart Viewer", -- [4]
					"1.0", -- [5]
					"Interface\\ICONS\\Ability_MeleeDamage", -- [6]
					true, -- [7]
				}, -- [1]
			},
			["plugin_window_pos"] = {
				["y"] = 122.9224853515625,
				["x"] = -22.85458374023438,
				["point"] = "CENTER",
				["scale"] = 1,
			},
			["damage_scroll_position"] = {
			},
			["performance_profiles"] = {
				["Dungeon"] = {
					["enabled"] = false,
					["update_speed"] = 1,
					["aura"] = true,
					["miscdata"] = true,
					["heal"] = true,
					["use_row_animations"] = false,
					["energy"] = false,
					["damage"] = true,
				},
				["RaidFinder"] = {
					["enabled"] = false,
					["update_speed"] = 1,
					["aura"] = true,
					["miscdata"] = true,
					["heal"] = true,
					["use_row_animations"] = false,
					["energy"] = false,
					["damage"] = true,
				},
				["Battleground15"] = {
					["enabled"] = false,
					["update_speed"] = 1,
					["aura"] = true,
					["miscdata"] = true,
					["heal"] = true,
					["use_row_animations"] = false,
					["energy"] = false,
					["damage"] = true,
				},
				["Raid15"] = {
					["enabled"] = false,
					["update_speed"] = 1,
					["aura"] = true,
					["miscdata"] = true,
					["heal"] = true,
					["use_row_animations"] = false,
					["energy"] = false,
					["damage"] = true,
				},
				["Mythic"] = {
					["enabled"] = false,
					["update_speed"] = 1,
					["aura"] = true,
					["miscdata"] = true,
					["heal"] = true,
					["use_row_animations"] = false,
					["energy"] = false,
					["damage"] = true,
				},
				["Arena"] = {
					["enabled"] = false,
					["update_speed"] = 1,
					["aura"] = true,
					["miscdata"] = true,
					["heal"] = true,
					["use_row_animations"] = false,
					["energy"] = false,
					["damage"] = true,
				},
				["Raid30"] = {
					["enabled"] = false,
					["update_speed"] = 1,
					["aura"] = true,
					["miscdata"] = true,
					["heal"] = true,
					["use_row_animations"] = false,
					["energy"] = false,
					["damage"] = true,
				},
				["Battleground40"] = {
					["enabled"] = false,
					["update_speed"] = 1,
					["aura"] = true,
					["miscdata"] = true,
					["heal"] = true,
					["use_row_animations"] = false,
					["energy"] = false,
					["damage"] = true,
				},
			},
			["last_changelog_size"] = 6382,
			["immersion_unit_special_icons"] = true,
			["lastUpdateWarning"] = 1614995822,
			["dungeon_data"] = {
			},

		}
		_detalhes:ApplyProfile(key)
	end
	if ElvUI_EltreumUI.Classic then
		local key = "Eltreum Dual"
		_detalhes_global = {
			["npcid_pool"] = {
			},
			["death_recap"] = {
				["show_segments"] = false,
				["enabled"] = true,
				["show_life_percent"] = false,
				["relevance_time"] = 7,
			},
			["spell_pool"] = {
			},
			["encounter_spell_pool"] = {
			},
			["dungeon_data"] = {
			},
			["got_first_run"] = true,
			["report_pos"] = {
				1, -- [1]
				1, -- [2]
			},
			["latest_report_table"] = {
			},
			["__profiles"] = {
				[key] = {
					["show_arena_role_icon"] = false,
					["capture_real"] = {
						["heal"] = true,
						["spellcast"] = true,
						["miscdata"] = true,
						["aura"] = true,
						["energy"] = true,
						["damage"] = true,
					},
					["row_fade_in"] = {
						"in", -- [1]
						0.2, -- [2]
					},
					["streamer_config"] = {
						["faster_updates"] = false,
						["quick_detection"] = false,
						["reset_spec_cache"] = false,
						["no_alerts"] = false,
						["use_animation_accel"] = true,
						["disable_mythic_dungeon"] = false,
					},
					["all_players_are_group"] = false,
					["use_row_animations"] = true,
					["report_heal_links"] = false,
					["remove_realm_from_name"] = true,
					["minimum_overall_combat_time"] = 10,
					["event_tracker"] = {
						["enabled"] = false,
						["font_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["line_height"] = 16,
						["line_color"] = {
							0.1, -- [1]
							0.1, -- [2]
							0.1, -- [3]
							0.3, -- [4]
						},
						["font_shadow"] = "NONE",
						["font_size"] = 10,
						["font_face"] = "Friz Quadrata TT",
						["frame"] = {
							["show_title"] = true,
							["strata"] = "LOW",
							["backdrop_color"] = {
								0.16, -- [1]
								0.16, -- [2]
								0.16, -- [3]
								0.47, -- [4]
							},
							["locked"] = false,
							["height"] = 300,
							["width"] = 250,
						},
						["line_texture"] = "Details Serenity",
						["options_frame"] = {
						},
					},
					["report_to_who"] = "",
					["class_specs_coords"] = {
						[62] = {
							0.251953125, -- [1]
							0.375, -- [2]
							0.125, -- [3]
							0.25, -- [4]
						},
						[63] = {
							0.375, -- [1]
							0.5, -- [2]
							0.125, -- [3]
							0.25, -- [4]
						},
						[250] = {
							0, -- [1]
							0.125, -- [2]
							0, -- [3]
							0.125, -- [4]
						},
						[251] = {
							0.125, -- [1]
							0.25, -- [2]
							0, -- [3]
							0.125, -- [4]
						},
						[252] = {
							0.25, -- [1]
							0.375, -- [2]
							0, -- [3]
							0.125, -- [4]
						},
						[253] = {
							0.875, -- [1]
							1, -- [2]
							0, -- [3]
							0.125, -- [4]
						},
						[254] = {
							0, -- [1]
							0.125, -- [2]
							0.125, -- [3]
							0.25, -- [4]
						},
						[255] = {
							0.125, -- [1]
							0.25, -- [2]
							0.125, -- [3]
							0.25, -- [4]
						},
						[66] = {
							0.125, -- [1]
							0.25, -- [2]
							0.25, -- [3]
							0.375, -- [4]
						},
						[257] = {
							0.5, -- [1]
							0.625, -- [2]
							0.25, -- [3]
							0.375, -- [4]
						},
						[258] = {
							0.6328125, -- [1]
							0.75, -- [2]
							0.25, -- [3]
							0.375, -- [4]
						},
						[259] = {
							0.75, -- [1]
							0.875, -- [2]
							0.25, -- [3]
							0.375, -- [4]
						},
						[260] = {
							0.875, -- [1]
							1, -- [2]
							0.25, -- [3]
							0.375, -- [4]
						},
						[577] = {
							0.25, -- [1]
							0.375, -- [2]
							0.5, -- [3]
							0.625, -- [4]
						},
						[262] = {
							0.125, -- [1]
							0.25, -- [2]
							0.375, -- [3]
							0.5, -- [4]
						},
						[581] = {
							0.375, -- [1]
							0.5, -- [2]
							0.5, -- [3]
							0.625, -- [4]
						},
						[264] = {
							0.375, -- [1]
							0.5, -- [2]
							0.375, -- [3]
							0.5, -- [4]
						},
						[265] = {
							0.5, -- [1]
							0.625, -- [2]
							0.375, -- [3]
							0.5, -- [4]
						},
						[266] = {
							0.625, -- [1]
							0.75, -- [2]
							0.375, -- [3]
							0.5, -- [4]
						},
						[267] = {
							0.75, -- [1]
							0.875, -- [2]
							0.375, -- [3]
							0.5, -- [4]
						},
						[268] = {
							0.625, -- [1]
							0.75, -- [2]
							0.125, -- [3]
							0.25, -- [4]
						},
						[269] = {
							0.875, -- [1]
							1, -- [2]
							0.125, -- [3]
							0.25, -- [4]
						},
						[270] = {
							0.75, -- [1]
							0.875, -- [2]
							0.125, -- [3]
							0.25, -- [4]
						},
						[70] = {
							0.251953125, -- [1]
							0.375, -- [2]
							0.25, -- [3]
							0.375, -- [4]
						},
						[102] = {
							0.375, -- [1]
							0.5, -- [2]
							0, -- [3]
							0.125, -- [4]
						},
						[71] = {
							0.875, -- [1]
							1, -- [2]
							0.375, -- [3]
							0.5, -- [4]
						},
						[103] = {
							0.5, -- [1]
							0.625, -- [2]
							0, -- [3]
							0.125, -- [4]
						},
						[72] = {
							0, -- [1]
							0.125, -- [2]
							0.5, -- [3]
							0.625, -- [4]
						},
						[104] = {
							0.625, -- [1]
							0.75, -- [2]
							0, -- [3]
							0.125, -- [4]
						},
						[73] = {
							0.125, -- [1]
							0.25, -- [2]
							0.5, -- [3]
							0.625, -- [4]
						},
						[64] = {
							0.5, -- [1]
							0.625, -- [2]
							0.125, -- [3]
							0.25, -- [4]
						},
						[105] = {
							0.75, -- [1]
							0.875, -- [2]
							0, -- [3]
							0.125, -- [4]
						},
						[65] = {
							0, -- [1]
							0.125, -- [2]
							0.25, -- [3]
							0.375, -- [4]
						},
						[256] = {
							0.375, -- [1]
							0.5, -- [2]
							0.25, -- [3]
							0.375, -- [4]
						},
						[261] = {
							0, -- [1]
							0.125, -- [2]
							0.375, -- [3]
							0.5, -- [4]
						},
						[263] = {
							0.25, -- [1]
							0.375, -- [2]
							0.375, -- [3]
							0.5, -- [4]
						},
					},
					["profile_save_pos"] = true,
					["tooltip"] = {
						["header_statusbar"] = {
							0.3, -- [1]
							0.3, -- [2]
							0.3, -- [3]
							0.8, -- [4]
							false, -- [5]
							false, -- [6]
							"WorldState Score", -- [7]
						},
						["fontcolor_right"] = {
							1, -- [1]
							0.7, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["line_height"] = 17,
						["tooltip_max_targets"] = 2,
						["icon_size"] = {
							["W"] = 17,
							["H"] = 17,
						},
						["tooltip_max_pets"] = 2,
						["anchor_relative"] = "top",
						["abbreviation"] = 3,
						["anchored_to"] = 1,
						["show_amount"] = false,
						["header_text_color"] = {
							1, -- [1]
							0.9176, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["fontsize"] = 14,
						["background"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							0.8, -- [4]
						},
						["submenu_wallpaper"] = true,
						["fontsize_title"] = 10,
						["icon_border_texcoord"] = {
							["B"] = 0.921875,
							["L"] = 0.078125,
							["T"] = 0.078125,
							["R"] = 0.921875,
						},
						["commands"] = {
						},
						["tooltip_max_abilities"] = 6,
						["fontface"] = "Kimberley",
						["border_color"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["border_texture"] = "None",
						["anchor_offset"] = {
							0, -- [1]
							0, -- [2]
						},
						["fontshadow"] = true,
						["menus_bg_texture"] = "Interface\\SPELLBOOK\\Spellbook-Page-1",
						["border_size"] = 14,
						["maximize_method"] = 1,
						["anchor_screen_pos"] = {
							507.7, -- [1]
							-350.5, -- [2]
						},
						["anchor_point"] = "bottom",
						["menus_bg_coords"] = {
							0.309777336120606, -- [1]
							0.924000015258789, -- [2]
							0.213000011444092, -- [3]
							0.279000015258789, -- [4]
						},
						["fontcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["menus_bg_color"] = {
							0.8, -- [1]
							0.8, -- [2]
							0.8, -- [3]
							0.2, -- [4]
						},
					},
					["ps_abbreviation"] = 3,
					["world_combat_is_trash"] = false,
					["update_speed"] = 0.2,
					["bookmark_text_size"] = 11,
					["animation_speed_mintravel"] = 0.45,
					["track_item_level"] = true,
					["windows_fade_in"] = {
						"in", -- [1]
						0.2, -- [2]
					},
					["instances_menu_click_to_open"] = false,
					["overall_clear_newchallenge"] = false,
					["current_dps_meter"] = {
						["enabled"] = false,
						["font_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["arena_enabled"] = true,
						["font_shadow"] = "NONE",
						["font_size"] = 18,
						["mythic_dungeon_enabled"] = true,
						["sample_size"] = 5,
						["font_face"] = "Friz Quadrata TT",
						["frame"] = {
							["show_title"] = false,
							["strata"] = "LOW",
							["backdrop_color"] = {
								0, -- [1]
								0, -- [2]
								0, -- [3]
								0.2, -- [4]
							},
							["locked"] = false,
							["height"] = 65,
							["width"] = 220,
						},
						["update_interval"] = 0.3,
						["options_frame"] = {
						},
					},
					["data_cleanup_logout"] = false,
					["instances_disable_bar_highlight"] = false,
					["trash_concatenate"] = false,
					["color_by_arena_team"] = true,
					["animation_speed"] = 33,
					["disable_stretch_from_toolbar"] = false,
					["disable_lock_ungroup_buttons"] = true,
					["memory_ram"] = 64,
					["disable_window_groups"] = false,
					["instances_suppress_trash"] = 0,
					["instances"] = {
						{
							["__pos"] = {
								["normal"] = {
									["y"] = -446.82544708252,
									["x"] = 667.302185058594,
									["w"] = 205.999954223633,
									["h"] = 157.777816772461,
								},
								["solo"] = {
									["y"] = 2,
									["x"] = 1,
									["w"] = 300,
									["h"] = 200,
								},
							},
							["hide_in_combat_type"] = 1,
							["clickthrough_window"] = false,
							["menu_anchor"] = {
								16, -- [1]
								0, -- [2]
								["side"] = 2,
							},
							["bg_r"] = 0,
							["hide_out_of_combat"] = false,
							["color_buttons"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["toolbar_icon_file"] = "Interface\\AddOns\\Details\\images\\toolbar_icons",
							["skin_custom"] = "",
							["tooltip"] = {
								["n_abilities"] = 3,
								["n_enemies"] = 3,
							},
							["switch_all_roles_in_combat"] = false,
							["clickthrough_toolbaricons"] = false,
							["attribute_text"] = {
								["show_timer"] = {
									true, -- [1]
									true, -- [2]
									true, -- [3]
								},
								["shadow"] = true,
								["side"] = 1,
								["text_color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["custom_text"] = "{name}",
								["text_face"] = "Kimberley",
								["anchor"] = {
									3, -- [1]
									3, -- [2]
								},
								["text_size"] = 12,
								["enable_custom_text"] = false,
								["enabled"] = true,
							},
							["ignore_mass_showhide"] = false,
							["switch_all_roles_after_wipe"] = false,
							["menu_icons"] = {
								true, -- [1]
								true, -- [2]
								true, -- [3]
								true, -- [4]
								true, -- [5]
								false, -- [6]
								["space"] = -2,
								["shadow"] = false,
							},
							["switch_damager"] = false,
							["auto_hide_menu"] = {
								["left"] = true,
								["right"] = false,
							},
							["window_scale"] = 1,
							["hide_icon"] = false,
							["toolbar_side"] = 1,
							["bg_g"] = 0,
							["bg_b"] = 0,
							["switch_healer_in_combat"] = false,
							["color"] = {
								0, -- [1]
								0, -- [2]
								0, -- [3]
								0, -- [4]
							},
							["hide_on_context"] = {
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [1]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [2]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [3]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [4]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [5]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [6]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [7]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [8]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [9]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [10]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [11]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [12]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [13]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [14]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [15]
							},
							["skin"] = "Minimalistic",
							["following"] = {
								["enabled"] = true,
								["bar_color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
								},
								["text_color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
								},
							},
							["switch_healer"] = false,
							["StatusBarSaved"] = {
								["center"] = "DETAILS_STATUSBAR_PLUGIN_CLOCK",
								["right"] = "DETAILS_STATUSBAR_PLUGIN_PDPS",
								["options"] = {
									["DETAILS_STATUSBAR_PLUGIN_PDPS"] = {
										["textYMod"] = 1,
										["textXMod"] = 0,
										["textFace"] = "Accidental Presidency",
										["textAlign"] = 0,
										["textStyle"] = 2,
										["textSize"] = 10,
										["textColor"] = {
											1, -- [1]
											1, -- [2]
											1, -- [3]
											1, -- [4]
										},
									},
									["DETAILS_STATUSBAR_PLUGIN_PSEGMENT"] = {
										["textColor"] = {
											1, -- [1]
											1, -- [2]
											1, -- [3]
											1, -- [4]
										},
										["segmentType"] = 2,
										["textFace"] = "Accidental Presidency",
										["textXMod"] = 0,
										["textAlign"] = 0,
										["textStyle"] = 2,
										["textSize"] = 10,
										["textYMod"] = 1,
									},
									["DETAILS_STATUSBAR_PLUGIN_CLOCK"] = {
										["textColor"] = {
											1, -- [1]
											1, -- [2]
											1, -- [3]
											1, -- [4]
										},
										["textXMod"] = 6,
										["textFace"] = "Accidental Presidency",
										["textAlign"] = 0,
										["textStyle"] = 2,
										["timeType"] = 1,
										["textSize"] = 10,
										["textYMod"] = 1,
									},
								},
								["left"] = "DETAILS_STATUSBAR_PLUGIN_PSEGMENT",
							},
							["instance_button_anchor"] = {
								-27, -- [1]
								1, -- [2]
							},
							["version"] = 3,
							["__snapV"] = false,
							["__locked"] = true,
							["menu_alpha"] = {
								["enabled"] = false,
								["onenter"] = 1,
								["iconstoo"] = true,
								["ignorebars"] = false,
								["onleave"] = 1,
							},
							["__snapH"] = false,
							["micro_displays_locked"] = true,
							["__was_opened"] = true,
							["strata"] = "LOW",
							["clickthrough_incombatonly"] = true,
							["__snap"] = {
								[3] = 2,
							},
							["show_statusbar"] = false,
							["hide_in_combat_alpha"] = 0,
							["menu_icons_size"] = 0.850000023841858,
							["plugins_grow_direction"] = 1,
							["libwindow"] = {
								["y"] = 22.857063293457,
								["x"] = -204.93603515625,
								["point"] = "BOTTOMRIGHT",
								["scale"] = 1,
							},
							["statusbar_info"] = {
								["alpha"] = 0,
								["overlay"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
								},
							},
							["bars_grow_direction"] = 1,
							["menu_anchor_down"] = {
								16, -- [1]
								-3, -- [2]
							},
							["switch_damager_in_combat"] = false,
							["row_show_animation"] = {
								["anim"] = "Fade",
								["options"] = {
								},
							},
							["total_bar"] = {
								["enabled"] = false,
								["only_in_group"] = true,
								["icon"] = "Interface\\ICONS\\INV_Sigil_Thorim",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
								},
							},
							["grab_on_top"] = false,
							["bars_sort_direction"] = 1,
							["backdrop_texture"] = "Details Ground",
							["auto_current"] = true,
							["bg_alpha"] = 0,
							["switch_tank_in_combat"] = false,
							["clickthrough_rows"] = false,
							["hide_in_combat"] = false,
							["posicao"] = {
								["normal"] = {
									["y"] = -446.82544708252,
									["x"] = 667.302185058594,
									["w"] = 205.999954223633,
									["h"] = 157.777816772461,
								},
								["solo"] = {
									["y"] = 2,
									["x"] = 1,
									["w"] = 300,
									["h"] = 200,
								},
							},
							["row_info"] = {
								["textR_outline"] = true,
								["spec_file"] = "Interface\\AddOns\\Details\\images\\spec_icons_normal",
								["textL_outline"] = true,
								["textR_outline_small"] = true,
								["textR_show_data"] = {
									true, -- [1]
									true, -- [2]
									false, -- [3]
								},
								["textL_enable_custom_text"] = false,
								["fixed_text_color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
								},
								["space"] = {
									["right"] = 0,
									["left"] = 0,
									["between"] = 1,
								},
								["texture_background_class_color"] = false,
								["textL_outline_small_color"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
									1, -- [4]
								},
								["font_face_file"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Fonts\\Kimberley.otf",
								["backdrop"] = {
									["enabled"] = false,
									["size"] = 12,
									["color"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										0, -- [4]
									},
									["texture"] = "None",
								},
								["font_size"] = 12,
								["texture_custom_file"] = "Interface\\",
								["texture_file"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum7pixel.tga",
								["use_spec_icons"] = false,
								["models"] = {
									["upper_model"] = "Spells\\AcidBreath_SuperGreen.M2",
									["lower_model"] = "World\\EXPANSION02\\DOODADS\\Coldarra\\COLDARRALOCUS.m2",
									["upper_alpha"] = 0.5,
									["lower_enabled"] = false,
									["lower_alpha"] = 0.1,
									["upper_enabled"] = false,
								},
								["icon_file"] = "Interface\\AddOns\\Details\\images\\classes_small",
								["icon_grayscale"] = false,
								["textL_custom_text"] = "{data1}. {data3}{data2}",
								["textR_bracket"] = "NONE",
								["textR_enable_custom_text"] = true,
								["texture"] = "Eltreum7pixel",
								["fixed_texture_color"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
								},
								["textL_show_number"] = true,
								["percent_type"] = 1,
								["textL_outline_small"] = true,
								["textR_custom_text"] = "{data1}   {data2}",
								["fixed_texture_background_color"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
									0, -- [4]
								},
								["texture_highlight"] = "Interface\\FriendsFrame\\UI-FriendsList-Highlight",
								["texture_background_file"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga",
								["textR_class_colors"] = false,
								["textR_outline_small_color"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
									1, -- [4]
								},
								["textL_class_colors"] = true,
								["texture_background"] = "Eltreum-Blank",
								["alpha"] = 1,
								["no_icon"] = false,
								["icon_offset"] = {
									0, -- [1]
									0, -- [2]
								},
								["texture_custom"] = "",
								["font_face"] = "Kimberley",
								["texture_class_colors"] = true,
								["start_after_icon"] = true,
								["fast_ps_update"] = false,
								["textR_separator"] = "NONE",
								["height"] = 21,
							},
							["desaturated_menu"] = true,
							["wallpaper"] = {
								["enabled"] = false,
								["texcoord"] = {
									0, -- [1]
									1, -- [2]
									0, -- [3]
									0.7, -- [4]
								},
								["overlay"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["anchor"] = "all",
								["height"] = 114.042518615723,
								["alpha"] = 0.5,
								["width"] = 283.000183105469,
							},
							["stretch_button_side"] = 1,
							["switch_tank"] = false,
							["show_sidebars"] = false,
							["micro_displays_side"] = 2,
							["bars_inverted"] = false,
						}, -- [1]
						{
							["__pos"] = {
								["normal"] = {
									["y"] = -446.82544708252,
									["x"] = 871.754699707031,
									["w"] = 202.904693603516,
									["h"] = 157.777816772461,
								},
								["solo"] = {
									["y"] = 2,
									["x"] = 1,
									["w"] = 300,
									["h"] = 200,
								},
							},
							["hide_in_combat_type"] = 1,
							["clickthrough_window"] = false,
							["menu_anchor"] = {
								16, -- [1]
								0, -- [2]
								["side"] = 2,
							},
							["bg_r"] = 0,
							["hide_out_of_combat"] = false,
							["color_buttons"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["toolbar_icon_file"] = "Interface\\AddOns\\Details\\images\\toolbar_icons",
							["skin_custom"] = "",
							["tooltip"] = {
								["n_abilities"] = 3,
								["n_enemies"] = 3,
							},
							["switch_all_roles_in_combat"] = false,
							["clickthrough_toolbaricons"] = false,
							["attribute_text"] = {
								["show_timer"] = {
									true, -- [1]
									true, -- [2]
									true, -- [3]
								},
								["shadow"] = true,
								["side"] = 1,
								["text_color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["custom_text"] = "{name}",
								["text_face"] = "Kimberley",
								["anchor"] = {
									3, -- [1]
									3, -- [2]
								},
								["text_size"] = 12,
								["enable_custom_text"] = false,
								["enabled"] = true,
							},
							["ignore_mass_showhide"] = false,
							["switch_all_roles_after_wipe"] = false,
							["menu_icons"] = {
								true, -- [1]
								true, -- [2]
								true, -- [3]
								true, -- [4]
								true, -- [5]
								false, -- [6]
								["space"] = -2,
								["shadow"] = false,
							},
							["switch_damager"] = false,
							["auto_hide_menu"] = {
								["left"] = true,
								["right"] = false,
							},
							["window_scale"] = 1,
							["hide_icon"] = false,
							["toolbar_side"] = 1,
							["bg_g"] = 0,
							["bg_b"] = 0,
							["switch_healer_in_combat"] = false,
							["color"] = {
								0, -- [1]
								0, -- [2]
								0, -- [3]
								0, -- [4]
							},
							["hide_on_context"] = {
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [1]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [2]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [3]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [4]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [5]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [6]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [7]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [8]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [9]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [10]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [11]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [12]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [13]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [14]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [15]
							},
							["skin"] = "Minimalistic",
							["following"] = {
								["enabled"] = true,
								["bar_color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
								},
								["text_color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
								},
							},
							["switch_healer"] = false,
							["StatusBarSaved"] = {
								["center"] = "DETAILS_STATUSBAR_PLUGIN_CLOCK",
								["right"] = "DETAILS_STATUSBAR_PLUGIN_PDPS",
								["options"] = {
									["DETAILS_STATUSBAR_PLUGIN_PDPS"] = {
										["textYMod"] = 1,
										["textXMod"] = 0,
										["textFace"] = "Accidental Presidency",
										["textAlign"] = 0,
										["textStyle"] = 2,
										["textSize"] = 10,
										["textColor"] = {
											1, -- [1]
											1, -- [2]
											1, -- [3]
											1, -- [4]
										},
									},
									["DETAILS_STATUSBAR_PLUGIN_PSEGMENT"] = {
										["textColor"] = {
											1, -- [1]
											1, -- [2]
											1, -- [3]
											1, -- [4]
										},
										["segmentType"] = 2,
										["textFace"] = "Accidental Presidency",
										["textXMod"] = 0,
										["textAlign"] = 0,
										["textStyle"] = 2,
										["textSize"] = 10,
										["textYMod"] = 1,
									},
									["DETAILS_STATUSBAR_PLUGIN_CLOCK"] = {
										["textColor"] = {
											1, -- [1]
											1, -- [2]
											1, -- [3]
											1, -- [4]
										},
										["textXMod"] = 6,
										["textFace"] = "Accidental Presidency",
										["textAlign"] = 0,
										["textStyle"] = 2,
										["timeType"] = 1,
										["textSize"] = 10,
										["textYMod"] = 1,
									},
								},
								["left"] = "DETAILS_STATUSBAR_PLUGIN_PSEGMENT",
							},
							["instance_button_anchor"] = {
								-27, -- [1]
								1, -- [2]
							},
							["version"] = 3,
							["__snapV"] = false,
							["__locked"] = true,
							["menu_alpha"] = {
								["enabled"] = false,
								["onenter"] = 1,
								["iconstoo"] = true,
								["ignorebars"] = false,
								["onleave"] = 1,
							},
							["__snapH"] = false,
							["micro_displays_locked"] = true,
							["__was_opened"] = true,
							["strata"] = "LOW",
							["clickthrough_incombatonly"] = true,
							["__snap"] = {
								1, -- [1]
							},
							["show_statusbar"] = false,
							["hide_in_combat_alpha"] = 0,
							["menu_icons_size"] = 0.850000023841858,
							["plugins_grow_direction"] = 1,
							["libwindow"] = {
								["y"] = 22.857063293457,
								["x"] = -2.0313720703125,
								["point"] = "BOTTOMRIGHT",
								["scale"] = 1,
							},
							["statusbar_info"] = {
								["alpha"] = 0,
								["overlay"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
								},
							},
							["bars_grow_direction"] = 1,
							["menu_anchor_down"] = {
								16, -- [1]
								-3, -- [2]
							},
							["switch_damager_in_combat"] = false,
							["row_show_animation"] = {
								["anim"] = "Fade",
								["options"] = {
								},
							},
							["total_bar"] = {
								["enabled"] = false,
								["only_in_group"] = true,
								["icon"] = "Interface\\ICONS\\INV_Sigil_Thorim",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
								},
							},
							["grab_on_top"] = false,
							["bars_sort_direction"] = 1,
							["backdrop_texture"] = "Details Ground",
							["auto_current"] = true,
							["bg_alpha"] = 0,
							["switch_tank_in_combat"] = false,
							["clickthrough_rows"] = false,
							["hide_in_combat"] = false,
							["posicao"] = {
								["normal"] = {
									["y"] = -446.82544708252,
									["x"] = 871.754699707031,
									["w"] = 202.904693603516,
									["h"] = 157.777816772461,
								},
								["solo"] = {
									["y"] = 2,
									["x"] = 1,
									["w"] = 300,
									["h"] = 200,
								},
							},
							["row_info"] = {
								["textR_outline"] = true,
								["spec_file"] = "Interface\\AddOns\\Details\\images\\spec_icons_normal",
								["textL_outline"] = true,
								["textR_outline_small"] = true,
								["textR_show_data"] = {
									true, -- [1]
									true, -- [2]
									false, -- [3]
								},
								["textL_enable_custom_text"] = false,
								["fixed_text_color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
								},
								["space"] = {
									["right"] = 0,
									["left"] = 0,
									["between"] = 1,
								},
								["texture_background_class_color"] = false,
								["textL_outline_small_color"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
									1, -- [4]
								},
								["font_face_file"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Fonts\\Kimberley.otf",
								["backdrop"] = {
									["enabled"] = false,
									["size"] = 12,
									["color"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										0, -- [4]
									},
									["texture"] = "None",
								},
								["font_size"] = 12,
								["texture_custom_file"] = "Interface\\",
								["texture_file"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum7pixel.tga",
								["use_spec_icons"] = false,
								["models"] = {
									["upper_model"] = "Spells\\AcidBreath_SuperGreen.M2",
									["lower_model"] = "World\\EXPANSION02\\DOODADS\\Coldarra\\COLDARRALOCUS.m2",
									["upper_alpha"] = 0.5,
									["lower_enabled"] = false,
									["lower_alpha"] = 0.1,
									["upper_enabled"] = false,
								},
								["icon_file"] = "Interface\\AddOns\\Details\\images\\classes_small",
								["icon_grayscale"] = false,
								["textL_custom_text"] = "{data1}. {data3}{data2}",
								["textR_bracket"] = "NONE",
								["textR_enable_custom_text"] = true,
								["texture"] = "Eltreum7pixel",
								["fixed_texture_color"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
								},
								["textL_show_number"] = true,
								["percent_type"] = 1,
								["textL_outline_small"] = true,
								["textR_custom_text"] = "{data1}   {data2}",
								["fixed_texture_background_color"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
									0, -- [4]
								},
								["texture_highlight"] = "Interface\\FriendsFrame\\UI-FriendsList-Highlight",
								["texture_background_file"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga",
								["textR_class_colors"] = false,
								["textR_outline_small_color"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
									1, -- [4]
								},
								["textL_class_colors"] = true,
								["texture_background"] = "Eltreum-Blank",
								["alpha"] = 1,
								["no_icon"] = false,
								["icon_offset"] = {
									0, -- [1]
									0, -- [2]
								},
								["texture_custom"] = "",
								["font_face"] = "Kimberley",
								["texture_class_colors"] = true,
								["start_after_icon"] = true,
								["fast_ps_update"] = false,
								["textR_separator"] = "NONE",
								["height"] = 21,
							},
							["desaturated_menu"] = true,
							["wallpaper"] = {
								["enabled"] = false,
								["texcoord"] = {
									0, -- [1]
									1, -- [2]
									0, -- [3]
									0.7, -- [4]
								},
								["overlay"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["anchor"] = "all",
								["height"] = 114.042518615723,
								["alpha"] = 0.5,
								["width"] = 283.000183105469,
							},
							["stretch_button_side"] = 1,
							["switch_tank"] = false,
							["show_sidebars"] = false,
							["micro_displays_side"] = 2,
							["bars_inverted"] = false,
						}, -- [2]
					},
					["options_window"] = {
						["scale"] = 1,
					},
					["animation_speed_maxtravel"] = 3,
					["hotcorner_topleft"] = {
						["hide"] = false,
					},
					["deadlog_limit"] = 16,
					["font_faces"] = {
						["menus"] = "Kimberley",
					},
					["instances_segments_locked"] = false,
					["instances_no_libwindow"] = false,
					["data_broker_text"] = "",
					["segments_amount"] = 18,
					["report_lines"] = 5,
					["clear_ungrouped"] = true,
					["font_sizes"] = {
						["menus"] = 14,
					},
					["skin"] = "WoW Interface",
					["override_spellids"] = true,
					["total_abbreviation"] = 2,
					["report_schema"] = 1,
					["animation_speed_triggertravel"] = 5,
					["use_battleground_server_parser"] = false,
					["minimum_combat_time"] = 5,
					["use_scroll"] = false,
					["cloud_capture"] = true,
					["damage_taken_everything"] = false,
					["scroll_speed"] = 2,
					["new_window_size"] = {
						["height"] = 158,
						["width"] = 310,
					},
					["chat_tab_embed"] = {
						["enabled"] = false,
						["y_offset"] = 0,
						["x_offset"] = 0,
						["tab_name"] = "",
						["single_window"] = false,
					},
					["deadlog_events"] = 32,
					["overall_clear_logout"] = false,
					["close_shields"] = false,
					["class_coords"] = {
						["HUNTER"] = {
							0, -- [1]
							0.25, -- [2]
							0.25, -- [3]
							0.5, -- [4]
						},
						["WARRIOR"] = {
							0, -- [1]
							0.25, -- [2]
							0, -- [3]
							0.25, -- [4]
						},
						["ROGUE"] = {
							0.49609375, -- [1]
							0.7421875, -- [2]
							0, -- [3]
							0.25, -- [4]
						},
						["MAGE"] = {
							0.25, -- [1]
							0.49609375, -- [2]
							0, -- [3]
							0.25, -- [4]
						},
						["PET"] = {
							0.25, -- [1]
							0.49609375, -- [2]
							0.75, -- [3]
							1, -- [4]
						},
						["DRUID"] = {
							0.7421875, -- [1]
							0.98828125, -- [2]
							0, -- [3]
							0.25, -- [4]
						},
						["MONK"] = {
							0.5, -- [1]
							0.73828125, -- [2]
							0.5, -- [3]
							0.75, -- [4]
						},
						["DEATHKNIGHT"] = {
							0.25, -- [1]
							0.5, -- [2]
							0.5, -- [3]
							0.75, -- [4]
						},
						["MONSTER"] = {
							0, -- [1]
							0.25, -- [2]
							0.75, -- [3]
							1, -- [4]
						},
						["UNKNOW"] = {
							0.5, -- [1]
							0.75, -- [2]
							0.75, -- [3]
							1, -- [4]
						},
						["PRIEST"] = {
							0.49609375, -- [1]
							0.7421875, -- [2]
							0.25, -- [3]
							0.5, -- [4]
						},
						["SHAMAN"] = {
							0.25, -- [1]
							0.49609375, -- [2]
							0.25, -- [3]
							0.5, -- [4]
						},
						["Alliance"] = {
							0.49609375, -- [1]
							0.7421875, -- [2]
							0.75, -- [3]
							1, -- [4]
						},
						["WARLOCK"] = {
							0.7421875, -- [1]
							0.98828125, -- [2]
							0.25, -- [3]
							0.5, -- [4]
						},
						["DEMONHUNTER"] = {
							0.73828126, -- [1]
							1, -- [2]
							0.5, -- [3]
							0.75, -- [4]
						},
						["Horde"] = {
							0.7421875, -- [1]
							0.98828125, -- [2]
							0.75, -- [3]
							1, -- [4]
						},
						["PALADIN"] = {
							0, -- [1]
							0.25, -- [2]
							0.5, -- [3]
							0.75, -- [4]
						},
						["UNGROUPPLAYER"] = {
							0.5, -- [1]
							0.75, -- [2]
							0.75, -- [3]
							1, -- [4]
						},
						["ENEMY"] = {
							0, -- [1]
							0.25, -- [2]
							0.75, -- [3]
							1, -- [4]
						},
					},
					["force_class_icons"] = false,
					["disable_alldisplays_window"] = false,
					["trash_auto_remove"] = true,
					["window_clamp"] = {
						-8, -- [1]
						0, -- [2]
						21, -- [3]
						-14, -- [4]
					},
					["windows_fade_out"] = {
						"out", -- [1]
						0.2, -- [2]
					},
					["numerical_system_symbols"] = "auto",
					["clear_graphic"] = true,
					["class_colors"] = {
						["HUNTER"] = {
							0.67, -- [1]
							0.83, -- [2]
							0.45, -- [3]
						},
						["WARRIOR"] = {
							0.78, -- [1]
							0.61, -- [2]
							0.43, -- [3]
						},
						["ROGUE"] = {
							1, -- [1]
							0.96, -- [2]
							0.41, -- [3]
						},
						["Rogue"] = {
							1, -- [1]
							0.96, -- [2]
							0.41, -- [3]
						},
						["Ungroupplayer"] = {
							0.4, -- [1]
							0.4, -- [2]
							0.4, -- [3]
						},
						["Enemy"] = {
							0.94117, -- [1]
							0, -- [2]
							0.0196, -- [3]
							1, -- [4]
						},
						["ARENA_YELLOW"] = {
							1, -- [1]
							1, -- [2]
							0.25, -- [3]
						},
						["PET"] = {
							0.3, -- [1]
							0.4, -- [2]
							0.5, -- [3]
						},
						["DRUID"] = {
							1, -- [1]
							0.49, -- [2]
							0.04, -- [3]
						},
						["MONK"] = {
							0, -- [1]
							1, -- [2]
							0.59, -- [3]
						},
						["Shaman"] = {
							0, -- [1]
							0.44, -- [2]
							0.87, -- [3]
						},
						["Monk"] = {
							0, -- [1]
							1, -- [2]
							0.59, -- [3]
						},
						["Mage"] = {
							0.41, -- [1]
							0.8, -- [2]
							0.94, -- [3]
						},
						["Warlock"] = {
							0.58, -- [1]
							0.51, -- [2]
							0.79, -- [3]
						},
						["version"] = 1,
						["DEMONHUNTER"] = {
							0.64, -- [1]
							0.19, -- [2]
							0.79, -- [3]
						},
						["SHAMAN"] = {
							0, -- [1]
							0.44, -- [2]
							0.87, -- [3]
						},
						["ENEMY"] = {
							0.94117, -- [1]
							0, -- [2]
							0.0196, -- [3]
							1, -- [4]
						},
						["ARENA_GREEN"] = {
							0.4, -- [1]
							1, -- [2]
							0.4, -- [3]
						},
						["UNGROUPPLAYER"] = {
							0.4, -- [1]
							0.4, -- [2]
							0.4, -- [3]
						},
						["Warrior"] = {
							0.78, -- [1]
							0.61, -- [2]
							0.43, -- [3]
						},
						["Hunter"] = {
							0.67, -- [1]
							0.83, -- [2]
							0.45, -- [3]
						},
						["WARLOCK"] = {
							0.58, -- [1]
							0.51, -- [2]
							0.79, -- [3]
						},
						["UNKNOW"] = {
							0.2, -- [1]
							0.2, -- [2]
							0.2, -- [3]
						},
						["Deathknight"] = {
							0.77, -- [1]
							0.12, -- [2]
							0.23, -- [3]
						},
						["Paladin"] = {
							0.96, -- [1]
							0.55, -- [2]
							0.73, -- [3]
						},
						["Unknow"] = {
							0.2, -- [1]
							0.2, -- [2]
							0.2, -- [3]
						},
						["Neutral"] = {
							1, -- [1]
							1, -- [2]
							0, -- [3]
						},
						["DEATHKNIGHT"] = {
							0.77, -- [1]
							0.12, -- [2]
							0.23, -- [3]
						},
						["PALADIN"] = {
							0.96, -- [1]
							0.55, -- [2]
							0.73, -- [3]
						},
						["Pet"] = {
							0.3, -- [1]
							0.4, -- [2]
							0.5, -- [3]
						},
						["PRIEST"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
						},
						["MAGE"] = {
							0.41, -- [1]
							0.8, -- [2]
							0.94, -- [3]
						},
						["Druid"] = {
							1, -- [1]
							0.49, -- [2]
							0.04, -- [3]
						},
						["Version"] = 1,
						["Arena_green"] = {
							0.4, -- [1]
							1, -- [2]
							0.4, -- [3]
						},
						["Priest"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
						},
						["NEUTRAL"] = {
							1, -- [1]
							1, -- [2]
							0, -- [3]
						},
						["Arena_yellow"] = {
							1, -- [1]
							1, -- [2]
							0.25, -- [3]
						},
						["Demonhunter"] = {
							0.64, -- [1]
							0.19, -- [2]
							0.79, -- [3]
						},
					},
					["segments_auto_erase"] = 3,
					["options_group_edit"] = true,
					["broadcaster_enabled"] = false,
					["minimap"] = {
						["onclick_what_todo"] = 1,
						["radius"] = 160,
						["text_type"] = 1,
						["minimapPos"] = 220,
						["text_format"] = 3,
						["hide"] = true,
					},
					["instances_amount"] = 2,
					["max_window_size"] = {
						["height"] = 450,
						["width"] = 480,
					},
					["deny_score_messages"] = false,
					["only_pvp_frags"] = false,
					["disable_stretch_button"] = true,
					["default_bg_color"] = 0.0941,
					["standard_skin"] = false,
					["segments_amount_to_save"] = 18,
					["segments_panic_mode"] = false,
					["overall_flag"] = 16,
					["overall_clear_newboss"] = true,
					["row_fade_out"] = {
						"out", -- [1]
						0.2, -- [2]
					},
					["player_details_window"] = {
						["scale"] = 1,
						["bar_texture"] = "Skyline",
						["skin"] = "ElvUI",
					},
					["numerical_system"] = 1,
					["class_icons_small"] = "Interface\\AddOns\\Details\\images\\classes_small",
					["force_activity_time_pvp"] = true,
					["memory_threshold"] = 3,
					["pvp_as_group"] = true,
					["disable_reset_button"] = false,
					["animate_scroll"] = false,
					["death_tooltip_width"] = 350,
					["time_type"] = 2,
					["default_bg_alpha"] = 0.5,
					["time_type_original"] = 2,
				},
			},
			["boss_mods_timers"] = {
				["encounter_timers_bw"] = {
				},
				["encounter_timers_dbm"] = {
				},
			},
			["disable_talent_feature"] = false,
			["spell_school_cache"] = {
			},
			["deathlog_healingdone_min"] = 1,
			["plater"] = {
				["realtime_dps_enabled"] = false,
				["damage_taken_anchor"] = {
					["y"] = 0,
					["x"] = 0,
					["side"] = 7,
				},
				["realtime_dps_player_shadow"] = true,
				["damage_taken_enabled"] = false,
				["realtime_dps_player_size"] = 12,
				["damage_taken_size"] = 12,
				["realtime_dps_color"] = {
					1, -- [1]
					1, -- [2]
					0, -- [3]
					1, -- [4]
				},
				["realtime_dps_anchor"] = {
					["y"] = 0,
					["x"] = 0,
					["side"] = 7,
				},
				["realtime_dps_size"] = 12,
				["damage_taken_shadow"] = true,
				["damage_taken_color"] = {
					1, -- [1]
					1, -- [2]
					0, -- [3]
					1, -- [4]
				},
				["realtime_dps_player_color"] = {
					1, -- [1]
					1, -- [2]
					0, -- [3]
					1, -- [4]
				},
				["realtime_dps_player_anchor"] = {
					["y"] = 0,
					["x"] = 0,
					["side"] = 7,
				},
				["realtime_dps_player_enabled"] = false,
				["realtime_dps_shadow"] = true,
			},
			["data_sync"] = false,
			["mobs_data"] = {
			},
			["run_code"] = {
				["on_groupchange"] = "\n-- this code runs when the player enter or leave a group",
				["on_zonechanged"] = "\n-- when the player changes zone, this code will run",
				["on_init"] = "\n-- code to run when Details! initializes, put here code which only will run once\n-- this also will run then the profile is changed\n\n--size of the death log tooltip in the Deaths display (default 350)\nDetails.death_tooltip_width = 350;\n\n--when in arena or battleground, details! silently switch to activity time (goes back to the old setting on leaving, default true)\nDetails.force_activity_time_pvp = true;\n\n--speed of the bar animations (default 33)\nDetails.animation_speed = 33;\n\n--threshold to trigger slow or fast speed (default 0.45)\nDetails.animation_speed_mintravel = 0.45;\n\n--call to update animations\nDetails:RefreshAnimationFunctions();\n\n--max window size, does require a /reload to work (default 480 x 450)\nDetails.max_window_size.width = 480;\nDetails.max_window_size.height = 450;\n\n--use the arena team color as the class color (default true)\nDetails.color_by_arena_team = true;\n\n--use the role icon in the player bar when inside an arena (default false)\nDetails.show_arena_role_icon = false;\n\n--how much time the update warning is shown (default 10)\nDetails.update_warning_timeout = 10;",
				["on_specchanged"] = "\n-- run when the player changes its spec",
				["on_leavecombat"] = "\n-- this code runs when the player leave combat",
				["on_entercombat"] = "\n-- this code runs when the player enters in combat",
			},
			["report_where"] = "SAY",
			["createauraframe"] = {
			},
			["global_plugin_database"] = {
			},
			["show_totalhitdamage_on_overkill"] = false,
			["mobs_data_compiled"] = {
			},
			["item_level_pool"] = {
			},
			["savedCustomSpells"] = {
				{
					3, -- [1]
					"Environment (Falling)", -- [2]
					"Interface\\ICONS\\Spell_Magic_FeatherFall", -- [3]
				}, -- [1]
				{
					1, -- [1]
					"Melee", -- [2]
					"Interface\\ICONS\\INV_Sword_04", -- [3]
				}, -- [2]
				{
					4, -- [1]
					"Environment (Drowning)", -- [2]
					"Interface\\ICONS\\Ability_Suffocate", -- [3]
				}, -- [3]
				{
					5, -- [1]
					"Environment (Fatigue)", -- [2]
					"Interface\\ICONS\\Spell_Arcane_MindMastery", -- [3]
				}, -- [4]
				{
					7, -- [1]
					"Environment (Lava)", -- [2]
					"Interface\\ICONS\\Ability_Rhyolith_Volcano", -- [3]
				}, -- [5]
			},
			["update_warning_timeout"] = 10,
			["plugin_window_pos"] = {
				["y"] = 0.0001068115234375,
				["x"] = 6.1035156250e-05,
				["point"] = "CENTER",
				["scale"] = 1,
			},
			["mythic_plus"] = {
				["make_overall_boss_only"] = false,
				["mythicrun_chart_frame"] = {
				},
				["merge_boss_trash"] = true,
				["delay_to_show_graphic"] = 5,
				["always_in_combat"] = false,
				["make_overall_when_done"] = true,
				["delete_trash_after_merge"] = true,
				["show_damage_graphic"] = true,
				["mythicrun_chart_frame_ready"] = {
				},
				["boss_dedicated_segment"] = true,
				["mythicrun_chart_frame_minimized"] = {
				},
				["last_mythicrun_chart"] = {
				},
			},
			["raid_data"] = {
			},
			["tutorial"] = {
				["bookmark_tutorial"] = false,
				["main_help_button"] = 2,
				["alert_frames"] = {
					false, -- [1]
					false, -- [2]
					false, -- [3]
					false, -- [4]
					false, -- [5]
					false, -- [6]
				},
				["logons"] = 2,
				["OPTIONS_PANEL_OPENED"] = true,
				["ATTRIBUTE_SELECT_TUTORIAL1"] = true,
				["ctrl_click_close_tutorial"] = false,
				["unlock_button"] = 4,
				["version_announce"] = 0,
			},
			["always_use_profile_name"] = "Eltreum Dual",
			["savedStyles"] = {
			},
			["always_use_profile_exception"] = {
			},
			["details_auras"] = {
			},
			["switchSaved"] = {
				["slots"] = 16,
				["table"] = {
					{
						["atributo"] = 1,
						["sub_atributo"] = 1,
					}, -- [1]
					{
						["atributo"] = 2,
						["sub_atributo"] = 1,
					}, -- [2]
					{
						["atributo"] = 1,
						["sub_atributo"] = 6,
					}, -- [3]
					{
						["atributo"] = 4,
						["sub_atributo"] = 5,
					}, -- [4]
					{
					}, -- [5]
					{
					}, -- [6]
					{
					}, -- [7]
					{
					}, -- [8]
					{
					}, -- [9]
					{
					}, -- [10]
					{
					}, -- [11]
					{
					}, -- [12]
					{
					}, -- [13]
					{
					}, -- [14]
					{
					}, -- [15]
					{
					}, -- [16]
				},
			},
			["savedTimeCaptures"] = {
			},
			["latest_news_saw"] = "",
			["custom"] = {
				{
					["source"] = false,
					["author"] = "Details!",
					["desc"] = "Show who in your raid used a potion during the encounter.",
					["tooltip"] = "			--init:\n			local player, combat, instance = ...\n\n			--get the debuff container for potion of focus\n			local debuff_uptime_container = player.debuff_uptime and player.debuff_uptime_spells and player.debuff_uptime_spells._ActorTable\n			if (debuff_uptime_container) then\n			    local focus_potion = debuff_uptime_container [DETAILS_FOCUS_POTION_ID]\n			    if (focus_potion) then\n				local name, _, icon = GetSpellInfo (DETAILS_FOCUS_POTION_ID)\n				GameCooltip:AddLine (name, 1) --> can use only 1 focus potion (can't be pre-potion)\n				_detalhes:AddTooltipBackgroundStatusbar()\n				GameCooltip:AddIcon (icon, 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n			    end\n			end\n\n			--get the buff container for all the others potions\n			local buff_uptime_container = player.buff_uptime and player.buff_uptime_spells and player.buff_uptime_spells._ActorTable\n			if (buff_uptime_container) then\n			    --potion of the jade serpent\n			    local jade_serpent_potion = buff_uptime_container [DETAILS_INT_POTION_ID]\n			    if (jade_serpent_potion) then\n				local name, _, icon = GetSpellInfo (DETAILS_INT_POTION_ID)\n				GameCooltip:AddLine (name, jade_serpent_potion.activedamt)\n				_detalhes:AddTooltipBackgroundStatusbar()\n				GameCooltip:AddIcon (icon, 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n			    end\n			    \n			    --potion of mogu power\n			    local mogu_power_potion = buff_uptime_container [DETAILS_STR_POTION_ID]\n			    if (mogu_power_potion) then\n				local name, _, icon = GetSpellInfo (DETAILS_STR_POTION_ID)\n				GameCooltip:AddLine (name, mogu_power_potion.activedamt)\n				_detalhes:AddTooltipBackgroundStatusbar()\n				GameCooltip:AddIcon (icon, 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n			    end\n			    \n			    --mana potion\n			    local mana_potion = buff_uptime_container [DETAILS_MANA_POTION_ID]\n			    if (mana_potion) then\n				local name, _, icon = GetSpellInfo (DETAILS_MANA_POTION_ID)\n				GameCooltip:AddLine (name, mana_potion.activedamt)\n				_detalhes:AddTooltipBackgroundStatusbar()\n				GameCooltip:AddIcon (icon, 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n			    end\n			    \n			    --prolongued power\n			    local prolongued_power = buff_uptime_container [DETAILS_AGI_POTION_ID]\n			    if (prolongued_power) then\n				local name, _, icon = GetSpellInfo (DETAILS_AGI_POTION_ID)\n				GameCooltip:AddLine (name, prolongued_power.activedamt)\n				_detalhes:AddTooltipBackgroundStatusbar()\n				GameCooltip:AddIcon (icon, 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n			    end\n			    \n			    --potion of the mountains\n			    local mountains_potion = buff_uptime_container [DETAILS_STAMINA_POTION_ID]\n			    if (mountains_potion) then\n				local name, _, icon = GetSpellInfo (DETAILS_STAMINA_POTION_ID)\n				GameCooltip:AddLine (name, mountains_potion.activedamt)\n				_detalhes:AddTooltipBackgroundStatusbar()\n				GameCooltip:AddIcon (icon, 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n			    end\n			end\n		",
					["icon"] = "Interface\\ICONS\\INV_Potion_03",
					["name"] = "Potion Used",
					["spellid"] = false,
					["target"] = false,
					["script"] = "				--init:\n				local combat, instance_container, instance = ...\n				local total, top, amount = 0, 0, 0\n\n				--get the misc actor container\n				local misc_container = combat:GetActorList ( DETAILS_ATTRIBUTE_MISC )\n\n				--do the loop:\n				for _, player in ipairs ( misc_container ) do \n				    \n				    --only player in group\n				    if (player:IsGroupPlayer()) then\n					\n					local found_potion = false\n					\n					--get the spell debuff uptime container\n					local debuff_uptime_container = player.debuff_uptime and player.debuff_uptime_spells and player.debuff_uptime_spells._ActorTable\n					if (debuff_uptime_container) then\n					    --potion of focus (can't use as pre-potion, so, its amount is always 1\n					    local focus_potion = debuff_uptime_container [DETAILS_FOCUS_POTION_ID]\n\n					    if (focus_potion) then\n						total = total + 1\n						found_potion = true\n						if (top < 1) then\n						    top = 1\n						end\n						--add amount to the player \n						instance_container:AddValue (player, 1)\n					    end\n					end\n					\n					--get the spell buff uptime container\n					local buff_uptime_container = player.buff_uptime and player.buff_uptime_spells and player.buff_uptime_spells._ActorTable\n					if (buff_uptime_container) then\n					    \n					    --potion of the jade serpent\n					    local jade_serpent_potion = buff_uptime_container [DETAILS_INT_POTION_ID]\n					    if (jade_serpent_potion) then\n						local used = jade_serpent_potion.activedamt\n						if (used > 0) then\n						    total = total + used\n						    found_potion = true\n						    if (used > top) then\n							top = used\n						    end\n						    --add amount to the player \n						    instance_container:AddValue (player, used)\n						end\n					    end\n					    \n					    --potion of mogu power\n					    local mogu_power_potion = buff_uptime_container [DETAILS_STR_POTION_ID]\n					    if (mogu_power_potion) then\n						local used = mogu_power_potion.activedamt\n						if (used > 0) then\n						    total = total + used\n						    found_potion = true\n						    if (used > top) then\n							top = used\n						    end\n						    --add amount to the player \n						    instance_container:AddValue (player, used)\n						end\n					    end\n					    \n					    --mana potion\n					    local mana_potion = buff_uptime_container [DETAILS_MANA_POTION_ID]\n					    if (mana_potion) then\n						local used = mana_potion.activedamt\n						if (used > 0) then\n						    total = total + used\n						    found_potion = true\n						    if (used > top) then\n							top = used\n						    end\n						    --add amount to the player \n						    instance_container:AddValue (player, used)\n						end\n					    end\n					    \n					    --potion of prolongued power\n					    local prolongued_power = buff_uptime_container [DETAILS_AGI_POTION_ID]\n					    if (prolongued_power) then\n						local used = prolongued_power.activedamt\n						if (used > 0) then\n						    total = total + used\n						    found_potion = true\n						    if (used > top) then\n							top = used\n						    end\n						    --add amount to the player \n						    instance_container:AddValue (player, used)\n						end\n					    end\n					    \n					    --potion of the mountains\n					    local mountains_potion = buff_uptime_container [DETAILS_STAMINA_POTION_ID]\n					    if (mountains_potion) then\n						local used = mountains_potion.activedamt\n						if (used > 0) then\n						    total = total + used\n						    found_potion = true\n						    if (used > top) then\n							top = used\n						    end\n						    --add amount to the player \n						    instance_container:AddValue (player, used)\n						end\n					    end\n					end\n					\n					if (found_potion) then\n					    amount = amount + 1\n					end    \n				    end\n				end\n\n				--return:\n				return total, top, amount\n				",
					["attribute"] = false,
					["script_version"] = 5,
				}, -- [1]
				{
					["source"] = false,
					["total_script"] = false,
					["author"] = "Details! Team",
					["percent_script"] = false,
					["desc"] = "Show who in your raid group used the healthstone or a heal potion.",
					["icon"] = "Interface\\ICONS\\INV_Stone_04",
					["spellid"] = false,
					["name"] = "Health Potion & Stone",
					["script"] = "			--get the parameters passed\n			local combat, instance_container, instance = ...\n			--declade the values to return\n			local total, top, amount = 0, 0, 0\n			\n			--do the loop\n			local AllHealCharacters = combat:GetActorList (DETAILS_ATTRIBUTE_HEAL)\n			for index, character in ipairs (AllHealCharacters) do\n				local AllSpells = character:GetSpellList()\n				local found = false\n				for spellid, spell in pairs (AllSpells) do\n					if (DETAILS_HEALTH_POTION_LIST [spellid]) then\n						instance_container:AddValue (character, spell.total)\n						total = total + spell.total\n						if (top < spell.total) then\n							top = spell.total\n						end\n						found = true\n					end\n				end\n			\n				if (found) then\n					amount = amount + 1\n				end\n			end\n			--loop end\n			--return the values\n			return total, top, amount\n			",
					["target"] = false,
					["tooltip"] = "			--get the parameters passed\n			local actor, combat, instance = ...\n			\n			--get the cooltip object (we dont use the convencional GameTooltip here)\n			local GameCooltip = GameCooltip\n			local R, G, B, A = 0, 0, 0, 0.75\n			\n			local hs = actor:GetSpell (6262)\n			if (hs) then\n				GameCooltip:AddLine (select (1, GetSpellInfo(6262)),  _detalhes:ToK(hs.total))\n				GameCooltip:AddIcon (select (3, GetSpellInfo (6262)), 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				GameCooltip:AddStatusBar (100, 1, R, G, B, A)\n			end\n			\n			local pot = actor:GetSpell (DETAILS_HEALTH_POTION_ID)\n			if (pot) then\n				GameCooltip:AddLine (select (1, GetSpellInfo(DETAILS_HEALTH_POTION_ID)),  _detalhes:ToK(pot.total))\n				GameCooltip:AddIcon (select (3, GetSpellInfo (DETAILS_HEALTH_POTION_ID)), 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				GameCooltip:AddStatusBar (100, 1, R, G, B, A)\n			end\n			\n			local pot = actor:GetSpell (DETAILS_REJU_POTION_ID)\n			if (pot) then\n				GameCooltip:AddLine (select (1, GetSpellInfo(DETAILS_REJU_POTION_ID)),  _detalhes:ToK(pot.total))\n				GameCooltip:AddIcon (select (3, GetSpellInfo (DETAILS_REJU_POTION_ID)), 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				GameCooltip:AddStatusBar (100, 1, R, G, B, A)\n			end\n\n			--Cooltip code\n			",
					["attribute"] = false,
					["script_version"] = 15,
				}, -- [2]
				{
					["source"] = false,
					["author"] = "Details!",
					["tooltip"] = "				\n			",
					["percent_script"] = "				local value, top, total, combat, instance = ...\n				return string.format (\"%.1f\", value/top*100)\n			",
					["desc"] = "Tells how much time each character spent doing damage.",
					["icon"] = "Interface\\Buttons\\UI-MicroStream-Red",
					["spellid"] = false,
					["name"] = "Damage Activity Time",
					["script"] = "				--init:\n				local combat, instance_container, instance = ...\n				local total, amount = 0, 0\n\n				--get the misc actor container\n				local damage_container = combat:GetActorList ( DETAILS_ATTRIBUTE_DAMAGE )\n				\n				--do the loop:\n				for _, player in ipairs ( damage_container ) do \n					if (player.grupo) then\n						local activity = player:Tempo()\n						total = total + activity\n						amount = amount + 1\n						--add amount to the player \n						instance_container:AddValue (player, activity)\n					end\n				end\n				\n				--return:\n				return total, combat:GetCombatTime(), amount\n			",
					["target"] = false,
					["total_script"] = "				local value, top, total, combat, instance = ...\n				local minutos, segundos = math.floor (value/60), math.floor (value%60)\n				return minutos .. \"m \" .. segundos .. \"s\"\n			",
					["attribute"] = false,
					["script_version"] = 2,
				}, -- [3]
				{
					["source"] = false,
					["author"] = "Details!",
					["tooltip"] = "				\n			",
					["percent_script"] = "				local value, top, total, combat, instance = ...\n				return string.format (\"%.1f\", value/top*100)\n			",
					["desc"] = "Tells how much time each character spent doing healing.",
					["icon"] = "Interface\\Buttons\\UI-MicroStream-Green",
					["spellid"] = false,
					["name"] = "Healing Activity Time",
					["script"] = "				--init:\n				local combat, instance_container, instance = ...\n				local total, top, amount = 0, 0, 0\n\n				--get the misc actor container\n				local damage_container = combat:GetActorList ( DETAILS_ATTRIBUTE_HEAL )\n				\n				--do the loop:\n				for _, player in ipairs ( damage_container ) do \n					if (player.grupo) then\n						local activity = player:Tempo()\n						total = total + activity\n						amount = amount + 1\n						--add amount to the player \n						instance_container:AddValue (player, activity)\n					end\n				end\n				\n				--return:\n				return total, combat:GetCombatTime(), amount\n			",
					["target"] = false,
					["total_script"] = "				local value, top, total, combat, instance = ...\n				local minutos, segundos = math.floor (value/60), math.floor (value%60)\n				return minutos .. \"m \" .. segundos .. \"s\"\n			",
					["attribute"] = false,
					["script_version"] = 2,
				}, -- [4]
				{
					["source"] = false,
					["author"] = "Details!",
					["desc"] = "Show the crowd control amount for each player.",
					["total_script"] = "				local value, top, total, combat, instance = ...\n				return floor (value)\n			",
					["icon"] = "Interface\\ICONS\\Spell_Frost_FreezingBreath",
					["spellid"] = false,
					["name"] = "Crowd Control Done",
					["tooltip"] = "				local actor, combat, instance = ...\n				local spells = {}\n				for spellid, spell in pairs (actor.cc_done_spells._ActorTable) do\n				    tinsert (spells, {spellid, spell.counter})\n				end\n\n				table.sort (spells, _detalhes.Sort2)\n\n				for index, spell in ipairs (spells) do\n				    local name, _, icon = GetSpellInfo (spell [1])\n				    GameCooltip:AddLine (name, spell [2])\n				    _detalhes:AddTooltipBackgroundStatusbar()\n				    GameCooltip:AddIcon (icon, 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				end\n\n				local targets = {}\n				for playername, amount in pairs (actor.cc_done_targets) do\n				    tinsert (targets, {playername, amount})\n				end\n\n				table.sort (targets, _detalhes.Sort2)\n\n				_detalhes:AddTooltipSpellHeaderText (\"Targets\", \"yellow\", #targets)\n				local class, _, _, _, _, r, g, b = _detalhes:GetClass (actor.nome)\n				_detalhes:AddTooltipHeaderStatusbar (1, 1, 1, 0.6)\n\n				for index, target in ipairs (targets) do\n				    GameCooltip:AddLine (target[1], target [2])\n				    _detalhes:AddTooltipBackgroundStatusbar()\n				    \n				    local class, _, _, _, _, r, g, b = _detalhes:GetClass (target [1])\n				    if (class and class ~= \"UNKNOW\") then\n					local texture, l, r, t, b = _detalhes:GetClassIcon (class)\n					GameCooltip:AddIcon (\"Interface\\\\AddOns\\\\Details\\\\images\\\\classes_small_alpha\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height, l, r, t, b)\n				    else\n					GameCooltip:AddIcon (\"Interface\\\\GossipFrame\\\\IncompleteQuestIcon\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				    end\n				    --\n				end\n			",
					["target"] = false,
					["script"] = "				local combat, instance_container, instance = ...\n				local total, top, amount = 0, 0, 0\n\n				local misc_actors = combat:GetActorList (DETAILS_ATTRIBUTE_MISC)\n\n				for index, character in ipairs (misc_actors) do\n					if (character.cc_done and character:IsPlayer()) then\n						local cc_done = floor (character.cc_done)\n						instance_container:AddValue (character, cc_done)\n						total = total + cc_done\n						if (cc_done > top) then\n							top = cc_done\n						end\n						amount = amount + 1\n					end\n				end\n\n				return total, top, amount\n			",
					["attribute"] = false,
					["script_version"] = 11,
				}, -- [5]
				{
					["source"] = false,
					["author"] = "Details!",
					["desc"] = "Show the amount of crowd control received for each player.",
					["total_script"] = "				local value, top, total, combat, instance = ...\n				return floor (value)\n			",
					["icon"] = "Interface\\ICONS\\Spell_Frost_ChainsOfIce",
					["spellid"] = false,
					["name"] = "Crowd Control Received",
					["tooltip"] = "				local actor, combat, instance = ...\n				local name = actor:name()\n				local spells, from = {}, {}\n				local misc_actors = combat:GetActorList (DETAILS_ATTRIBUTE_MISC)\n\n				for index, character in ipairs (misc_actors) do\n				    if (character.cc_done and character:IsPlayer()) then\n					local on_actor = character.cc_done_targets [name]\n					if (on_actor) then\n					    tinsert (from, {character:name(), on_actor})\n					    \n					    for spellid, spell in pairs (character.cc_done_spells._ActorTable) do\n						\n						local spell_on_actor = spell.targets [name]\n						if (spell_on_actor) then\n						    local has_spell\n						    for index, spell_table in ipairs (spells) do\n							if (spell_table [1] == spellid) then\n							    spell_table [2] = spell_table [2] + spell_on_actor\n							    has_spell = true\n							end\n						    end\n						    if (not has_spell) then\n							tinsert (spells, {spellid, spell_on_actor}) \n						    end\n						end\n						\n					    end            \n					end\n				    end\n				end\n\n				table.sort (from, _detalhes.Sort2)\n				table.sort (spells, _detalhes.Sort2)\n\n				for index, spell in ipairs (spells) do\n				    local name, _, icon = GetSpellInfo (spell [1])\n				    GameCooltip:AddLine (name, spell [2])\n				    _detalhes:AddTooltipBackgroundStatusbar()\n				    GameCooltip:AddIcon (icon, 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)    \n				end\n\n				_detalhes:AddTooltipSpellHeaderText (\"From\", \"yellow\", #from)\n				_detalhes:AddTooltipHeaderStatusbar (1, 1, 1, 0.6)\n\n				for index, t in ipairs (from) do\n				    GameCooltip:AddLine (t[1], t[2])\n				    _detalhes:AddTooltipBackgroundStatusbar()\n				    \n				    local class, _, _, _, _, r, g, b = _detalhes:GetClass (t [1])\n				    if (class and class ~= \"UNKNOW\") then\n					local texture, l, r, t, b = _detalhes:GetClassIcon (class)\n					GameCooltip:AddIcon (\"Interface\\\\AddOns\\\\Details\\\\images\\\\classes_small_alpha\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height, l, r, t, b)\n				    else\n					GameCooltip:AddIcon (\"Interface\\\\GossipFrame\\\\IncompleteQuestIcon\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				    end     \n				    \n				end\n			",
					["target"] = false,
					["script"] = "				local combat, instance_container, instance = ...\n				local total, top, amt = 0, 0, 0\n\n				local misc_actors = combat:GetActorList (DETAILS_ATTRIBUTE_MISC)\n				DETAILS_CUSTOM_CC_RECEIVED_CACHE = DETAILS_CUSTOM_CC_RECEIVED_CACHE or {}\n				wipe (DETAILS_CUSTOM_CC_RECEIVED_CACHE)\n\n				for index, character in ipairs (misc_actors) do\n				    if (character.cc_done and character:IsPlayer()) then\n					\n					for player_name, amount in pairs (character.cc_done_targets) do\n					    local target = combat (1, player_name) or combat (2, player_name)\n					    if (target and target:IsPlayer()) then\n						instance_container:AddValue (target, amount)\n						total = total + amount\n						if (amount > top) then\n						    top = amount\n						end\n						if (not DETAILS_CUSTOM_CC_RECEIVED_CACHE [player_name]) then\n						    DETAILS_CUSTOM_CC_RECEIVED_CACHE [player_name] = true\n						    amt = amt + 1\n						end\n					    end\n					end\n					\n				    end\n				end\n\n				return total, top, amt\n			",
					["attribute"] = false,
					["script_version"] = 3,
				}, -- [6]
				{
					["source"] = false,
					["desc"] = "Show your spells in the window.",
					["author"] = "Details!",
					["percent_script"] = "				local value, top, total, combat, instance = ...\n				local dps = _detalhes:ToK (floor (value) / combat:GetCombatTime())\n				local percent = string.format (\"%.1f\", value/total*100)\n				return dps .. \", \" .. percent\n			",
					["total_script"] = "local value, top, total, combat, instance = ...\n			local dps = _detalhes:ToK (floor (value) / combat:GetCombatTime())\n			local percent = string.format (\"%.1f\", value/total*100)\n\n			return math.floor (value) .. \" (\" .. dps .. \", \" .. percent .. \"\"",
					["icon"] = "Interface\\CHATFRAME\\UI-ChatIcon-Battlenet",
					["spellid"] = false,
					["name"] = "My Spells",
					["tooltip"] = "				--config:\n				--Background RBG and Alpha:\n				local R, G, B, A = 0, 0, 0, 0.75\n				local R, G, B, A = 0.1960, 0.1960, 0.1960, 0.8697\n				\n				--get the parameters passed\n				local spell, combat, instance = ...\n				\n				--get the cooltip object (we dont use the convencional GameTooltip here)\n				local GC = GameCooltip\n				GC:SetOption (\"YSpacingMod\", 2)\n				local role = DetailsFramework.UnitGroupRolesAssigned (\"player\")\n				\n				if (spell.n_dmg) then\n					\n					local spellschool, schooltext = spell.spellschool, \"\"\n					if (spellschool) then\n						local t = _detalhes.spells_school [spellschool]\n						if (t and t.name) then\n							schooltext = t.formated\n						end\n					end\n					\n					local total_hits = spell.counter\n					local combat_time = instance.showing:GetCombatTime()\n					\n					local debuff_uptime_total, cast_string = \"\", \"\"\n					local misc_actor = instance.showing (4, _detalhes.playername)\n					if (misc_actor) then\n						local debuff_uptime = misc_actor.debuff_uptime_spells and misc_actor.debuff_uptime_spells._ActorTable [spell.id] and misc_actor.debuff_uptime_spells._ActorTable [spell.id].uptime\n						if (debuff_uptime) then\n							debuff_uptime_total = floor (debuff_uptime / instance.showing:GetCombatTime() * 100)\n						end\n						\n						local spell_cast = misc_actor.spell_cast and misc_actor.spell_cast [spell.id]\n						\n						if (not spell_cast and misc_actor.spell_cast) then\n							local spellname = GetSpellInfo (spell.id)\n							for casted_spellid, amount in pairs (misc_actor.spell_cast) do\n								local casted_spellname = GetSpellInfo (casted_spellid)\n								if (casted_spellname == spellname) then\n									spell_cast = amount .. \" (|cFFFFFF00?|r)\"\n								end\n							end\n						end\n						if (not spell_cast) then\n							spell_cast = \"(|cFFFFFF00?|r)\"\n						end\n						cast_string = cast_string .. spell_cast\n					end\n					\n					--Cooltip code\n					GC:AddLine (\"Casts:\", cast_string or \"?\")\n					GC:AddStatusBar (100, 1, R, G, B, A)\n					GC:AddIcon (\"\", 1, 1, 1, 16)\n					\n					if (debuff_uptime_total ~= \"\") then\n						GC:AddLine (\"Uptime:\", (debuff_uptime_total or \"?\") .. \"%\")\n						GC:AddStatusBar (100, 1, R, G, B, A)\n						GC:AddIcon (\"\", 1, 1, 1, 16)\n					end\n					\n					GC:AddLine (\"Hits:\", spell.counter)\n					GC:AddStatusBar (100, 1, R, G, B, A)\n					GC:AddIcon (\"\", 1, 1, 1, 16)\n					\n					local average = spell.total / total_hits\n					GC:AddLine (\"Average:\", _detalhes:ToK (average))\n					GC:AddStatusBar (100, 1, R, G, B, A)\n					GC:AddIcon (\"\", 1, 1, 1, 16)\n					\n					GC:AddLine (\"E-Dps:\", _detalhes:ToK (spell.total / combat_time))\n					GC:AddStatusBar (100, 1, R, G, B, A)\n					GC:AddIcon (\"\", 1, 1, 1, 16)\n					\n					GC:AddLine (\"School:\", schooltext)\n					GC:AddStatusBar (100, 1, R, G, B, A)\n					GC:AddIcon (\"\", 1, 1, 1, 16)\n					\n					--GC:AddLine (\" \")\n					\n					GC:AddLine (\"Normal Hits: \", spell.n_amt .. \" (\" ..floor ( spell.n_amt/total_hits*100) .. \"%)\")\n					GC:AddStatusBar (100, 1, R, G, B, A)\n					GC:AddIcon (\"\", 1, 1, 1, 16)\n					\n					local n_average = spell.n_dmg / spell.n_amt\n					local T = (combat_time*spell.n_dmg)/spell.total\n					local P = average/n_average*100\n					T = P*T/100\n					\n					GC:AddLine (\"Average / E-Dps: \",  _detalhes:ToK (n_average) .. \" / \" .. format (\"%.1f\",spell.n_dmg / T ))\n					GC:AddStatusBar (100, 1, R, G, B, A)\n					GC:AddIcon (\"\", 1, 1, 1, 16)\n					\n					--GC:AddLine (\" \")\n					\n					GC:AddLine (\"Critical Hits: \", spell.c_amt .. \" (\" ..floor ( spell.c_amt/total_hits*100) .. \"%)\")\n					GC:AddStatusBar (100, 1, R, G, B, A)\n					GC:AddIcon (\"\", 1, 1, 1, 16)\n					\n					if (spell.c_amt > 0) then\n						local c_average = spell.c_dmg/spell.c_amt\n						local T = (combat_time*spell.c_dmg)/spell.total\n						local P = average/c_average*100\n						T = P*T/100\n						local crit_dps = spell.c_dmg / T\n						\n						GC:AddLine (\"Average / E-Dps: \",  _detalhes:ToK (c_average) .. \" / \" .. _detalhes:comma_value (crit_dps))\n					else\n						GC:AddLine (\"Average / E-Dps: \",  \"0 / 0\")    \n					end\n					\n					GC:AddStatusBar (100, 1, R, G, B, A)\n					GC:AddIcon (\"\", 1, 1, 1, 16)\n					\n					GC:AddLine (\"Multistrike: \", spell.m_amt .. \" (\" ..floor ( spell.m_amt/total_hits*100) .. \"%)\")\n					GC:AddStatusBar (100, 1, R, G, B, A)\n					GC:AddIcon (\"\", 1, 1, 1, 16)\n					\n					\n					GC:AddLine (\"On Normal / On Critical:\", spell.m_amt - spell.m_crit .. \"  / \" .. spell.m_crit)\n					GC:AddStatusBar (100, 1, R, G, B, A)\n					GC:AddIcon (\"\", 1, 1, 1, 16)\n					\n				elseif (spell.n_curado) then\n					\n					local spellschool, schooltext = spell.spellschool, \"\"\n					if (spellschool) then\n						local t = _detalhes.spells_school [spellschool]\n						if (t and t.name) then\n							schooltext = t.formated\n						end\n					end\n					\n					local total_hits = spell.counter\n					local combat_time = instance.showing:GetCombatTime()\n					\n					--Cooltip code\n					GC:AddLine (\"Hits:\", spell.counter)\n					GC:AddStatusBar (100, 1, R, G, B, A)\n					\n					local average = spell.total / total_hits\n					GC:AddLine (\"Average:\", _detalhes:ToK (average))\n					GC:AddStatusBar (100, 1, R, G, B, A)\n					\n					GC:AddLine (\"E-Hps:\", _detalhes:ToK (spell.total / combat_time))\n					GC:AddStatusBar (100, 1, R, G, B, A)\n					\n					GC:AddLine (\"School:\", schooltext)\n					GC:AddStatusBar (100, 1, R, G, B, A)\n					\n					--GC:AddLine (\" \")\n					\n					GC:AddLine (\"Normal Hits: \", spell.n_amt .. \" (\" ..floor ( spell.n_amt/total_hits*100) .. \"%)\")\n					GC:AddStatusBar (100, 1, R, G, B, A)\n					\n					local n_average = spell.n_curado / spell.n_amt\n					local T = (combat_time*spell.n_curado)/spell.total\n					local P = average/n_average*100\n					T = P*T/100\n					\n					GC:AddLine (\"Average / E-Dps: \",  _detalhes:ToK (n_average) .. \" / \" .. format (\"%.1f\",spell.n_curado / T ))\n					GC:AddStatusBar (100, 1, R, G, B, A)\n					\n					--GC:AddLine (\" \")\n					\n					GC:AddLine (\"Critical Hits: \", spell.c_amt .. \" (\" ..floor ( spell.c_amt/total_hits*100) .. \"%)\")\n					GC:AddStatusBar (100, 1, R, G, B, A)\n					\n					if (spell.c_amt > 0) then\n						local c_average = spell.c_curado/spell.c_amt\n						local T = (combat_time*spell.c_curado)/spell.total\n						local P = average/c_average*100\n						T = P*T/100\n						local crit_dps = spell.c_curado / T\n						\n						GC:AddLine (\"Average / E-Hps: \",  _detalhes:ToK (c_average) .. \" / \" .. _detalhes:comma_value (crit_dps))\n					else\n						GC:AddLine (\"Average / E-Hps: \",  \"0 / 0\")    \n					end\n					\n					GC:AddStatusBar (100, 1, R, G, B, A)\n					\n					--GC:AddLine (\" \")\n					\n					GC:AddLine (\"Multistrike: \", spell.m_amt .. \" (\" ..floor ( spell.m_amt/total_hits*100) .. \"%)\")\n					GC:AddStatusBar (100, 1, R, G, B, A)\n					\n					GC:AddLine (\"On Normal / On Critical:\", spell.m_amt - spell.m_crit .. \"  / \" .. spell.m_crit)\n					GC:AddStatusBar (100, 1, R, G, B, A)\n				end\n\n			",
					["target"] = false,
					["script"] = "				--get the parameters passed\n				local combat, instance_container, instance = ...\n				--declade the values to return\n				local total, top, amount = 0, 0, 0\n\n				local player\n				local pet_attribute\n				\n				local role = DetailsFramework.UnitGroupRolesAssigned (\"player\")\n				local spec = DetailsFramework.GetSpecialization()\n				role = spec and DetailsFramework.GetSpecializationRole (spec) or role\n\n				if (role == \"DAMAGER\") then\n					player = combat (DETAILS_ATTRIBUTE_DAMAGE, _detalhes.playername)\n					pet_attribute = DETAILS_ATTRIBUTE_DAMAGE\n				elseif (role == \"HEALER\") then    \n					player = combat (DETAILS_ATTRIBUTE_HEAL, _detalhes.playername)\n					pet_attribute = DETAILS_ATTRIBUTE_HEAL\n				else\n					player = combat (DETAILS_ATTRIBUTE_DAMAGE, _detalhes.playername)\n					pet_attribute = DETAILS_ATTRIBUTE_DAMAGE\n				end\n\n				--do the loop\n\n				if (player) then\n					local spells = player:GetSpellList()\n					for spellid, spell in pairs (spells) do\n						instance_container:AddValue (spell, spell.total)\n						total = total + spell.total\n						if (top < spell.total) then\n							top = spell.total\n						end\n						amount = amount + 1\n					end\n				    \n					for _, PetName in ipairs (player.pets) do\n						local pet = combat (pet_attribute, PetName)\n						if (pet) then\n							for spellid, spell in pairs (pet:GetSpellList()) do\n								instance_container:AddValue (spell, spell.total, nil, \" (\" .. PetName:gsub ((\" <.*\"), \"\") .. \")\")\n								total = total + spell.total\n								if (top < spell.total) then\n									top = spell.total\n								end\n								amount = amount + 1\n							end\n						end\n					end\n				end\n\n				--return the values\n				return total, top, amount\n			",
					["attribute"] = false,
					["script_version"] = 9,
				}, -- [7]
				{
					["source"] = false,
					["author"] = "Details!",
					["desc"] = "Show the amount of damage applied on targets marked with skull.",
					["tooltip"] = "				--get the parameters passed\n				local actor, combat, instance = ...\n\n				--get the cooltip object (we dont use the convencional GameTooltip here)\n				local GameCooltip = GameCooltip\n\n				--Cooltip code\n				local format_func = Details:GetCurrentToKFunction()\n\n				--Cooltip code\n				local RaidTargets = actor.raid_targets\n\n				local DamageOnStar = RaidTargets [128]\n				if (DamageOnStar) then\n				    --RAID_TARGET_8 is the built-in localized word for 'Skull'.\n				    GameCooltip:AddLine (RAID_TARGET_8 .. \":\", format_func (_, DamageOnStar))\n				    GameCooltip:AddIcon (\"Interface\\\\TARGETINGFRAME\\\\UI-RaidTargetingIcon_8\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				    Details:AddTooltipBackgroundStatusbar()\n				end\n			",
					["icon"] = "Interface\\TARGETINGFRAME\\UI-RaidTargetingIcon_8",
					["name"] = "Damage On Skull Marked Targets",
					["spellid"] = false,
					["target"] = false,
					["script"] = "				--get the parameters passed\n				local Combat, CustomContainer, Instance = ...\n				--declade the values to return\n				local total, top, amount = 0, 0, 0\n				\n				--raid target flags: \n				-- 128: skull \n				-- 64: cross\n				-- 32: square\n				-- 16: moon\n				-- 8: triangle\n				-- 4: diamond\n				-- 2: circle\n				-- 1: star\n				\n				--do the loop\n				for _, actor in ipairs (Combat:GetActorList (DETAILS_ATTRIBUTE_DAMAGE)) do\n				    if (actor:IsPlayer()) then\n					if (actor.raid_targets [128]) then\n					    CustomContainer:AddValue (actor, actor.raid_targets [128])\n					end        \n				    end\n				end\n\n				--if not managed inside the loop, get the values of total, top and amount\n				total, top = CustomContainer:GetTotalAndHighestValue()\n				amount = CustomContainer:GetNumActors()\n\n				--return the values\n				return total, top, amount\n			",
					["attribute"] = false,
					["script_version"] = 4,
				}, -- [8]
				{
					["source"] = false,
					["author"] = "Details!",
					["desc"] = "Show the amount of damage applied on targets marked with any other mark.",
					["tooltip"] = "				--get the parameters passed\n				local actor, combat, instance = ...\n\n				--get the cooltip object\n				local GameCooltip = GameCooltip\n\n				local format_func = Details:GetCurrentToKFunction()\n\n				--Cooltip code\n				local RaidTargets = actor.raid_targets\n\n				local DamageOnStar = RaidTargets [1]\n				if (DamageOnStar) then\n				    GameCooltip:AddLine (RAID_TARGET_1 .. \":\", format_func (_, DamageOnStar))\n				    GameCooltip:AddIcon (\"Interface\\\\TARGETINGFRAME\\\\UI-RaidTargetingIcon_1\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				    Details:AddTooltipBackgroundStatusbar()\n				end\n\n				local DamageOnCircle = RaidTargets [2]\n				if (DamageOnCircle) then\n				    GameCooltip:AddLine (RAID_TARGET_2 .. \":\", format_func (_, DamageOnCircle))\n				    GameCooltip:AddIcon (\"Interface\\\\TARGETINGFRAME\\\\UI-RaidTargetingIcon_2\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				    Details:AddTooltipBackgroundStatusbar()\n				end\n\n				local DamageOnDiamond = RaidTargets [4]\n				if (DamageOnDiamond) then\n				    GameCooltip:AddLine (RAID_TARGET_3 .. \":\", format_func (_, DamageOnDiamond))\n				    GameCooltip:AddIcon (\"Interface\\\\TARGETINGFRAME\\\\UI-RaidTargetingIcon_3\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				    Details:AddTooltipBackgroundStatusbar()\n				end\n\n				local DamageOnTriangle = RaidTargets [8]\n				if (DamageOnTriangle) then\n				    GameCooltip:AddLine (RAID_TARGET_4 .. \":\", format_func (_, DamageOnTriangle))\n				    GameCooltip:AddIcon (\"Interface\\\\TARGETINGFRAME\\\\UI-RaidTargetingIcon_4\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				    Details:AddTooltipBackgroundStatusbar()\n				end\n\n				local DamageOnMoon = RaidTargets [16]\n				if (DamageOnMoon) then\n				    GameCooltip:AddLine (RAID_TARGET_5 .. \":\", format_func (_, DamageOnMoon))\n				    GameCooltip:AddIcon (\"Interface\\\\TARGETINGFRAME\\\\UI-RaidTargetingIcon_5\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				    Details:AddTooltipBackgroundStatusbar()\n				end\n\n				local DamageOnSquare = RaidTargets [32]\n				if (DamageOnSquare) then\n				    GameCooltip:AddLine (RAID_TARGET_6 .. \":\", format_func (_, DamageOnSquare))\n				    GameCooltip:AddIcon (\"Interface\\\\TARGETINGFRAME\\\\UI-RaidTargetingIcon_6\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				    Details:AddTooltipBackgroundStatusbar()\n				end\n\n				local DamageOnCross = RaidTargets [64]\n				if (DamageOnCross) then\n				    GameCooltip:AddLine (RAID_TARGET_7 .. \":\", format_func (_, DamageOnCross))\n				    GameCooltip:AddIcon (\"Interface\\\\TARGETINGFRAME\\\\UI-RaidTargetingIcon_7\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				    Details:AddTooltipBackgroundStatusbar()\n				end\n			",
					["icon"] = "Interface\\TARGETINGFRAME\\UI-RaidTargetingIcon_5",
					["name"] = "Damage On Other Marked Targets",
					["spellid"] = false,
					["target"] = false,
					["script"] = "				--get the parameters passed\n				local Combat, CustomContainer, Instance = ...\n				--declade the values to return\n				local total, top, amount = 0, 0, 0\n\n				--do the loop\n				for _, actor in ipairs (Combat:GetActorList (DETAILS_ATTRIBUTE_DAMAGE)) do\n				    if (actor:IsPlayer()) then\n					local total = (actor.raid_targets [1] or 0) --star\n					total = total + (actor.raid_targets [2] or 0) --circle\n					total = total + (actor.raid_targets [4] or 0) --diamond\n					total = total + (actor.raid_targets [8] or 0) --tiangle\n					total = total + (actor.raid_targets [16] or 0) --moon\n					total = total + (actor.raid_targets [32] or 0) --square\n					total = total + (actor.raid_targets [64] or 0) --cross\n					\n					if (total > 0) then\n					    CustomContainer:AddValue (actor, total)\n					end\n				    end\n				end\n\n				--if not managed inside the loop, get the values of total, top and amount\n				total, top = CustomContainer:GetTotalAndHighestValue()\n				amount = CustomContainer:GetNumActors()\n\n				--return the values\n				return total, top, amount\n			",
					["attribute"] = false,
					["script_version"] = 4,
				}, -- [9]
				{
					["source"] = false,
					["author"] = "Details!",
					["desc"] = "Show overall damage done on the fly.",
					["total_script"] = "				local value, top, total, combat, instance = ...\n\n				--get the time of overall combat\n				local OverallCombatTime = Details:GetCombat (-1):GetCombatTime()\n				\n				--get the time of current combat if the player is in combat\n				if (Details.in_combat) then\n					local CurrentCombatTime = Details:GetCombat (0):GetCombatTime()\n					OverallCombatTime = OverallCombatTime + CurrentCombatTime\n				end\n				\n				--build the string\n				local ToK = Details:GetCurrentToKFunction()\n				local s = ToK (_, value / OverallCombatTime)\n				\n				if (instance.row_info.textR_show_data[3]) then\n					s = ToK (_, value) .. \" (\" .. s .. \", \"\n				else\n					s = ToK (_, value) .. \" (\" .. s\n				end\n				\n				return s\n			",
					["icon"] = "Interface\\Buttons\\Spell-Reset",
					["spellid"] = false,
					["name"] = "Dynamic Overall Damage",
					["tooltip"] = "				--get the parameters passed\n				local actor, combat, instance = ...\n				\n				--get the cooltip object (we dont use the convencional GameTooltip here)\n				local GameCooltip = GameCooltip2\n				\n				--Cooltip code\n				--get the overall combat\n				local OverallCombat = Details:GetCombat (-1)\n				--get the current combat\n				local CurrentCombat = Details:GetCombat (0)\n				\n				local AllSpells = {}\n				\n				--overall\n				local player = OverallCombat [1]:GetActor (actor.nome)\n				if (player) then\n					local playerSpells = player:GetSpellList()\n					for spellID, spellTable in pairs (playerSpells) do\n						local spellName, _, spellIcon = Details.GetSpellInfoC  (spellID)\n						AllSpells [spellName] = spellTable.total\n					end\n				end\n				\n				--current\n				local player = CurrentCombat [1]:GetActor (actor.nome)\n				if (player) then\n					local playerSpells = player:GetSpellList()\n					for spellID, spellTable in pairs (playerSpells) do\n						local spellName, _, spellIcon = Details.GetSpellInfoC  (spellID)\n						AllSpells [spellName] = (AllSpells [spellName] or 0) + (spellTable.total or 0)\n					end\n				end\n				\n				local sortedList = {}\n				for spellID, total in pairs (AllSpells) do\n					tinsert (sortedList, {spellID, total})\n				end\n				table.sort (sortedList, Details.Sort2)\n				\n				local format_func = Details:GetCurrentToKFunction()\n				\n				--build the tooltip\n				for i, t in ipairs (sortedList) do\n					local spellID, total = unpack (t)\n					if (total > 1) then\n						local spellName, _, spellIcon = Details.GetSpellInfoC  (spellID)\n						\n						GameCooltip:AddLine (spellName, format_func (_, total))\n						Details:AddTooltipBackgroundStatusbar()\n						GameCooltip:AddIcon (spellIcon, 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n					end\n				end\n			",
					["target"] = false,
					["script"] = "				--init:\n				local combat, instance_container, instance = ...\n				local total, top, amount = 0, 0, 0\n				\n				--get the overall combat\n				local OverallCombat = Details:GetCombat (-1)\n				--get the current combat\n				local CurrentCombat = Details:GetCombat (0)\n				\n				--check if the actor list of overall and current combat is valid\n				if (not OverallCombat.GetActorList or not CurrentCombat.GetActorList) then\n					return 0, 0, 0\n				end\n				\n				--get the damage actor container for overall\n				local damage_container_overall = OverallCombat:GetActorList ( DETAILS_ATTRIBUTE_DAMAGE )\n				--get the damage actor container for current\n				local damage_container_current = CurrentCombat:GetActorList ( DETAILS_ATTRIBUTE_DAMAGE )\n				\n				--check if the results from getactorlist is a table and has more than 1 actor on it\n				if (type (damage_container_overall) ~= \"table\") then\n					return 0, 0, 0\n				end\n				\n				--do the loop:\n				for _, player in ipairs ( damage_container_overall ) do \n					--only player in group\n					if (player and player:IsGroupPlayer()) then\n						instance_container:AddValue (player, player.total)\n					end\n				end\n				\n				--does the player is in combat?\n				--if true need to add the data from the current fight as well\n				if (UnitAffectingCombat(\"player\")) then\n					for _, player in ipairs ( damage_container_current ) do \n						--only player in group\n						if (player and player:IsGroupPlayer()) then\n							instance_container:AddValue (player, player.total)        \n						end\n					end\n				end\n				\n				total, top =  instance_container:GetTotalAndHighestValue()\n				amount =  instance_container:GetNumActors()\n				\n				--return:\n				return total, top, amount\n			",
					["attribute"] = false,
					["script_version"] = 6,
				}, -- [10]
				{
					["source"] = false,
					["author"] = "Details!",
					["desc"] = "Damage done to shields",
					["tooltip"] = "				--get the parameters passed\n				local actor, Combat, instance = ...\n\n				--get the cooltip object (we dont use the convencional GameTooltip here)\n				local GameCooltip = GameCooltip\n\n				--Cooltip code\n				--get the actor total damage absorbed\n				local totalAbsorb = actor.totalabsorbed\n				local format_func = Details:GetCurrentToKFunction()\n\n				--get the damage absorbed by all the actor pets\n				for petIndex, petName in ipairs (actor.pets) do\n				    local pet = Combat :GetActor (1, petName)\n				    if (pet) then\n					totalAbsorb = totalAbsorb + pet.totalabsorbed\n				    end\n				end\n\n				GameCooltip:AddLine (actor:Name(), format_func (_, actor.totalabsorbed))\n				Details:AddTooltipBackgroundStatusbar()\n\n				for petIndex, petName in ipairs (actor.pets) do\n				    local pet = Combat :GetActor (1, petName)\n				    if (pet) then\n					totalAbsorb = totalAbsorb + pet.totalabsorbed\n					\n					GameCooltip:AddLine (petName, format_func (_, pet.totalabsorbed))\n					Details:AddTooltipBackgroundStatusbar()        \n					\n				    end\n				end\n			",
					["icon"] = "Interface\\ICONS\\Spell_Holy_PowerWordShield",
					["name"] = "Damage on Shields",
					["spellid"] = false,
					["target"] = false,
					["script"] = "				--get the parameters passed\n				local Combat, CustomContainer, Instance = ...\n				--declade the values to return\n				local total, top, amount = 0, 0, 0\n\n				--do the loop\n				for index, actor in ipairs (Combat:GetActorList(1)) do\n				    if (actor:IsPlayer()) then\n					\n					--get the actor total damage absorbed\n					local totalAbsorb = actor.totalabsorbed\n					\n					--get the damage absorbed by all the actor pets\n					for petIndex, petName in ipairs (actor.pets) do\n					    local pet = Combat :GetActor (1, petName)\n					    if (pet) then\n						totalAbsorb = totalAbsorb + pet.totalabsorbed\n					    end\n					end\n					\n					--add the value to the actor on the custom container\n					CustomContainer:AddValue (actor, totalAbsorb)        \n					\n				    end\n				end\n				--loop end\n\n				--if not managed inside the loop, get the values of total, top and amount\n				total, top = CustomContainer:GetTotalAndHighestValue()\n				amount = CustomContainer:GetNumActors()\n\n				--return the values\n				return total, top, amount\n			",
					["attribute"] = false,
					["script_version"] = 2,
				}, -- [11]
			},
			["performance_profiles"] = {
				["Dungeon"] = {
					["enabled"] = false,
					["update_speed"] = 1,
					["miscdata"] = true,
					["aura"] = true,
					["heal"] = true,
					["use_row_animations"] = false,
					["energy"] = false,
					["damage"] = true,
				},
				["RaidFinder"] = {
					["enabled"] = false,
					["update_speed"] = 1,
					["miscdata"] = true,
					["aura"] = true,
					["heal"] = true,
					["use_row_animations"] = false,
					["energy"] = false,
					["damage"] = true,
				},
				["Battleground15"] = {
					["enabled"] = false,
					["update_speed"] = 1,
					["miscdata"] = true,
					["aura"] = true,
					["heal"] = true,
					["use_row_animations"] = false,
					["energy"] = false,
					["damage"] = true,
				},
				["Battleground40"] = {
					["enabled"] = false,
					["update_speed"] = 1,
					["miscdata"] = true,
					["aura"] = true,
					["heal"] = true,
					["use_row_animations"] = false,
					["energy"] = false,
					["damage"] = true,
				},
				["Mythic"] = {
					["enabled"] = false,
					["update_speed"] = 1,
					["miscdata"] = true,
					["aura"] = true,
					["heal"] = true,
					["use_row_animations"] = false,
					["energy"] = false,
					["damage"] = true,
				},
				["Arena"] = {
					["enabled"] = false,
					["update_speed"] = 1,
					["miscdata"] = true,
					["aura"] = true,
					["heal"] = true,
					["use_row_animations"] = false,
					["energy"] = false,
					["damage"] = true,
				},
				["Raid30"] = {
					["enabled"] = false,
					["update_speed"] = 1,
					["miscdata"] = true,
					["aura"] = true,
					["heal"] = true,
					["use_row_animations"] = false,
					["energy"] = false,
					["damage"] = true,
				},
				["Raid15"] = {
					["enabled"] = false,
					["update_speed"] = 1,
					["miscdata"] = true,
					["aura"] = true,
					["heal"] = true,
					["use_row_animations"] = false,
					["energy"] = false,
					["damage"] = true,
				},
			},
			["exit_log"] = {
				"1 - Closing Janela Info.", -- [1]
				"2 - Clearing user place from instances.", -- [2]
				"4 - Reversing switches.", -- [3]
				"6 - Saving Config.", -- [4]
				"7 - Saving Profiles.", -- [5]
				"8 - Saving nicktag cache.", -- [6]
			},
			["realm_sync"] = true,
			["lastUpdateWarning"] = 0,
			["always_use_profile"] = false,
		}

		_detalhes:ApplyProfile(key)
	end


	if ElvUI_EltreumUI.TBC then
		local key = "Eltreum Dual"
		_detalhes_global = {
			["npcid_pool"] = {
			},
			["death_recap"] = {
				["show_segments"] = true,
				["enabled"] = true,
				["show_life_percent"] = true,
				["relevance_time"] = 12,
			},
			["spell_pool"] = {
			},
			["encounter_spell_pool"] = {
			},
			["immersion_pets_on_solo_play"] = false,
			["npcid_ignored"] = {
			},
			["report_where"] = "GUILD",
			["auto_open_news_window"] = false,
			["got_first_run"] = true,
			["always_use_profile"] = true,
			["plater"] = {
				["realtime_dps_enabled"] = false,
				["damage_taken_shadow"] = true,
				["realtime_dps_player_shadow"] = true,
				["realtime_dps_player_enabled"] = false,
				["realtime_dps_player_size"] = 12,
				["damage_taken_size"] = 12,
				["realtime_dps_color"] = {
					1, -- [1]
					1, -- [2]
					0, -- [3]
					1, -- [4]
				},
				["realtime_dps_anchor"] = {
					["y"] = 0,
					["x"] = 0,
					["side"] = 7,
				},
				["damage_taken_anchor"] = {
					["y"] = 0,
					["x"] = 0,
					["side"] = 7,
				},
				["realtime_dps_size"] = 12,
				["realtime_dps_player_color"] = {
					1, -- [1]
					1, -- [2]
					0, -- [3]
					1, -- [4]
				},
				["damage_taken_color"] = {
					1, -- [1]
					1, -- [2]
					0, -- [3]
					1, -- [4]
				},
				["realtime_dps_player_anchor"] = {
					["y"] = 0,
					["x"] = 0,
					["side"] = 7,
				},
				["damage_taken_enabled"] = false,
				["realtime_dps_shadow"] = true,
			},
			["report_pos"] = {
				1, -- [1]
				1, -- [2]
			},
			["latest_report_table"] = {
				{
					1, -- [1]
					2, -- [2]
					1, -- [3]
					5, -- [4]
					"RAID", -- [5]
				}, -- [1]
				{
					1, -- [1]
					4, -- [2]
					1, -- [3]
					5, -- [4]
					"RAID", -- [5]
				}, -- [2]
				{
					1, -- [1]
					4, -- [2]
					1, -- [3]
					5, -- [4]
					"GUILD", -- [5]
				}, -- [3]
				{
					1, -- [1]
					4, -- [2]
					5, -- [3]
					10, -- [4]
					"RAID", -- [5]
				}, -- [4]
			},
			["exp90temp"] = {
				["delete_damage_TCOB"] = true,
			},
			["__profiles"] = {
				[key] = {
					["show_arena_role_icon"] = false,
					["capture_real"] = {
						["heal"] = true,
						["spellcast"] = true,
						["miscdata"] = true,
						["aura"] = true,
						["energy"] = true,
						["damage"] = true,
					},
					["row_fade_in"] = {
						"in", -- [1]
						0.2, -- [2]
					},
					["streamer_config"] = {
						["faster_updates"] = false,
						["quick_detection"] = false,
						["reset_spec_cache"] = false,
						["no_alerts"] = false,
						["disable_mythic_dungeon"] = false,
						["use_animation_accel"] = true,
					},
					["all_players_are_group"] = false,
					["use_row_animations"] = true,
					["report_heal_links"] = false,
					["remove_realm_from_name"] = true,
					["minimum_overall_combat_time"] = 10,
					["event_tracker"] = {
						["enabled"] = false,
						["font_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["line_height"] = 16,
						["line_color"] = {
							0.1, -- [1]
							0.1, -- [2]
							0.1, -- [3]
							0.3, -- [4]
						},
						["font_shadow"] = "NONE",
						["font_size"] = 10,
						["font_face"] = "Friz Quadrata TT",
						["frame"] = {
							["show_title"] = true,
							["strata"] = "LOW",
							["backdrop_color"] = {
								0.16, -- [1]
								0.16, -- [2]
								0.16, -- [3]
								0.47, -- [4]
							},
							["locked"] = false,
							["height"] = 300,
							["width"] = 250,
						},
						["line_texture"] = "Details Serenity",
						["options_frame"] = {
						},
					},
					["report_to_who"] = "",
					["class_specs_coords"] = {
						[62] = {
							0.251953125, -- [1]
							0.375, -- [2]
							0.125, -- [3]
							0.25, -- [4]
						},
						[63] = {
							0.375, -- [1]
							0.5, -- [2]
							0.125, -- [3]
							0.25, -- [4]
						},
						[250] = {
							0, -- [1]
							0.125, -- [2]
							0, -- [3]
							0.125, -- [4]
						},
						[251] = {
							0.125, -- [1]
							0.25, -- [2]
							0, -- [3]
							0.125, -- [4]
						},
						[252] = {
							0.25, -- [1]
							0.375, -- [2]
							0, -- [3]
							0.125, -- [4]
						},
						[253] = {
							0.875, -- [1]
							1, -- [2]
							0, -- [3]
							0.125, -- [4]
						},
						[254] = {
							0, -- [1]
							0.125, -- [2]
							0.125, -- [3]
							0.25, -- [4]
						},
						[255] = {
							0.125, -- [1]
							0.25, -- [2]
							0.125, -- [3]
							0.25, -- [4]
						},
						[66] = {
							0.125, -- [1]
							0.25, -- [2]
							0.25, -- [3]
							0.375, -- [4]
						},
						[257] = {
							0.5, -- [1]
							0.625, -- [2]
							0.25, -- [3]
							0.375, -- [4]
						},
						[258] = {
							0.6328125, -- [1]
							0.75, -- [2]
							0.25, -- [3]
							0.375, -- [4]
						},
						[259] = {
							0.75, -- [1]
							0.875, -- [2]
							0.25, -- [3]
							0.375, -- [4]
						},
						[260] = {
							0.875, -- [1]
							1, -- [2]
							0.25, -- [3]
							0.375, -- [4]
						},
						[577] = {
							0.25, -- [1]
							0.375, -- [2]
							0.5, -- [3]
							0.625, -- [4]
						},
						[262] = {
							0.125, -- [1]
							0.25, -- [2]
							0.375, -- [3]
							0.5, -- [4]
						},
						[581] = {
							0.375, -- [1]
							0.5, -- [2]
							0.5, -- [3]
							0.625, -- [4]
						},
						[264] = {
							0.375, -- [1]
							0.5, -- [2]
							0.375, -- [3]
							0.5, -- [4]
						},
						[265] = {
							0.5, -- [1]
							0.625, -- [2]
							0.375, -- [3]
							0.5, -- [4]
						},
						[266] = {
							0.625, -- [1]
							0.75, -- [2]
							0.375, -- [3]
							0.5, -- [4]
						},
						[267] = {
							0.75, -- [1]
							0.875, -- [2]
							0.375, -- [3]
							0.5, -- [4]
						},
						[268] = {
							0.625, -- [1]
							0.75, -- [2]
							0.125, -- [3]
							0.25, -- [4]
						},
						[269] = {
							0.875, -- [1]
							1, -- [2]
							0.125, -- [3]
							0.25, -- [4]
						},
						[270] = {
							0.75, -- [1]
							0.875, -- [2]
							0.125, -- [3]
							0.25, -- [4]
						},
						[70] = {
							0.251953125, -- [1]
							0.375, -- [2]
							0.25, -- [3]
							0.375, -- [4]
						},
						[102] = {
							0.375, -- [1]
							0.5, -- [2]
							0, -- [3]
							0.125, -- [4]
						},
						[71] = {
							0.875, -- [1]
							1, -- [2]
							0.375, -- [3]
							0.5, -- [4]
						},
						[103] = {
							0.5, -- [1]
							0.625, -- [2]
							0, -- [3]
							0.125, -- [4]
						},
						[72] = {
							0, -- [1]
							0.125, -- [2]
							0.5, -- [3]
							0.625, -- [4]
						},
						[104] = {
							0.625, -- [1]
							0.75, -- [2]
							0, -- [3]
							0.125, -- [4]
						},
						[73] = {
							0.125, -- [1]
							0.25, -- [2]
							0.5, -- [3]
							0.625, -- [4]
						},
						[64] = {
							0.5, -- [1]
							0.625, -- [2]
							0.125, -- [3]
							0.25, -- [4]
						},
						[105] = {
							0.75, -- [1]
							0.875, -- [2]
							0, -- [3]
							0.125, -- [4]
						},
						[65] = {
							0, -- [1]
							0.125, -- [2]
							0.25, -- [3]
							0.375, -- [4]
						},
						[256] = {
							0.375, -- [1]
							0.5, -- [2]
							0.25, -- [3]
							0.375, -- [4]
						},
						[261] = {
							0, -- [1]
							0.125, -- [2]
							0.375, -- [3]
							0.5, -- [4]
						},
						[263] = {
							0.25, -- [1]
							0.375, -- [2]
							0.375, -- [3]
							0.5, -- [4]
						},
					},
					["profile_save_pos"] = true,
					["tooltip"] = {
						["header_statusbar"] = {
							0.3, -- [1]
							0.3, -- [2]
							0.3, -- [3]
							0.8, -- [4]
							false, -- [5]
							false, -- [6]
							"WorldState Score", -- [7]
						},
						["fontcolor_right"] = {
							1, -- [1]
							0.7, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["line_height"] = 17,
						["tooltip_max_targets"] = 2,
						["icon_size"] = {
							["W"] = 17,
							["H"] = 17,
						},
						["tooltip_max_pets"] = 2,
						["anchor_relative"] = "top",
						["abbreviation"] = 3,
						["anchored_to"] = 1,
						["fontsize"] = 10,
						["header_text_color"] = {
							1, -- [1]
							0.9176470588235294, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["show_amount"] = false,
						["background"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							0.8, -- [4]
						},
						["submenu_wallpaper"] = true,
						["fontsize_title"] = 10,
						["fontcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["commands"] = {
						},
						["tooltip_max_abilities"] = 6,
						["fontface"] = "Kimberley",
						["border_color"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["border_texture"] = "Details BarBorder 3",
						["anchor_offset"] = {
							0, -- [1]
							0, -- [2]
						},
						["fontshadow"] = true,
						["menus_bg_texture"] = "Interface\\SPELLBOOK\\Spellbook-Page-1",
						["border_size"] = 14,
						["maximize_method"] = 1,
						["anchor_screen_pos"] = {
							507.7, -- [1]
							-350.5, -- [2]
						},
						["anchor_point"] = "bottom",
						["menus_bg_coords"] = {
							0.309777336120606, -- [1]
							0.924000015258789, -- [2]
							0.213000011444092, -- [3]
							0.279000015258789, -- [4]
						},
						["icon_border_texcoord"] = {
							["R"] = 0.921875,
							["L"] = 0.078125,
							["T"] = 0.078125,
							["B"] = 0.921875,
						},
						["menus_bg_color"] = {
							0.8, -- [1]
							0.8, -- [2]
							0.8, -- [3]
							0.2, -- [4]
						},
					},
					["ps_abbreviation"] = 3,
					["world_combat_is_trash"] = false,
					["update_speed"] = 0.199999988079071,
					["bookmark_text_size"] = 11,
					["animation_speed_mintravel"] = 0.45,
					["track_item_level"] = true,
					["windows_fade_in"] = {
						"in", -- [1]
						0.2, -- [2]
					},
					["instances_menu_click_to_open"] = false,
					["overall_clear_newchallenge"] = true,
					["current_dps_meter"] = {
						["enabled"] = false,
						["font_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["arena_enabled"] = true,
						["font_shadow"] = "NONE",
						["font_size"] = 18,
						["mythic_dungeon_enabled"] = true,
						["font_face"] = "Friz Quadrata TT",
						["sample_size"] = 5,
						["frame"] = {
							["show_title"] = false,
							["strata"] = "LOW",
							["backdrop_color"] = {
								0, -- [1]
								0, -- [2]
								0, -- [3]
								0.2, -- [4]
							},
							["locked"] = false,
							["height"] = 65,
							["width"] = 220,
						},
						["update_interval"] = 0.3,
						["options_frame"] = {
						},
					},
					["data_cleanup_logout"] = false,
					["instances_disable_bar_highlight"] = false,
					["trash_concatenate"] = false,
					["color_by_arena_team"] = true,
					["animation_speed"] = 33,
					["disable_stretch_from_toolbar"] = false,
					["disable_lock_ungroup_buttons"] = true,
					["memory_ram"] = 64,
					["disable_window_groups"] = false,
					["instances_suppress_trash"] = 0,
					["options_window"] = {
						["scale"] = 1,
					},
					["animation_speed_maxtravel"] = 3,
					["instances"] = {
						{
							["__pos"] = {
								["normal"] = {
									["y"] = -446.5714721679688,
									["x"] = 667.3021850585938,
									["w"] = 205.9999542236328,
									["h"] = 158.2857513427734,
								},
								["solo"] = {
									["y"] = 2,
									["x"] = 1,
									["w"] = 300,
									["h"] = 200,
								},
							},
							["hide_in_combat_type"] = 1,
							["clickthrough_window"] = false,
							["menu_anchor"] = {
								16, -- [1]
								0, -- [2]
								["side"] = 2,
							},
							["bg_r"] = 0.09411764705882353,
							["hide_out_of_combat"] = false,
							["color_buttons"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["toolbar_icon_file"] = "Interface\\AddOns\\Details\\images\\toolbar_icons_2",
							["micro_displays_locked"] = true,
							["fontstrings_width"] = 35,
							["tooltip"] = {
								["n_abilities"] = 3,
								["n_enemies"] = 3,
							},
							["switch_all_roles_in_combat"] = false,
							["clickthrough_toolbaricons"] = false,
							["row_info"] = {
								["textR_outline"] = true,
								["spec_file"] = "Interface\\AddOns\\Details\\images\\spec_icons_normal",
								["textL_outline"] = true,
								["texture_highlight"] = "Interface\\FriendsFrame\\UI-FriendsList-Highlight",
								["textR_show_data"] = {
									true, -- [1]
									true, -- [2]
									false, -- [3]
								},
								["textL_enable_custom_text"] = false,
								["fixed_text_color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["space"] = {
									["right"] = 0,
									["left"] = 0,
									["between"] = 1,
								},
								["texture_background_class_color"] = false,
								["textL_outline_small_color"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
									1, -- [4]
								},
								["font_face_file"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\\\Fonts\\Kimberley.otf",
								["textL_custom_text"] = "{data1}. {data3}{data2}",
								["models"] = {
									["upper_model"] = "Spells\\AcidBreath_SuperGreen.M2",
									["lower_model"] = "World\\EXPANSION02\\DOODADS\\Coldarra\\COLDARRALOCUS.m2",
									["upper_alpha"] = 0.5,
									["lower_enabled"] = false,
									["lower_alpha"] = 0.1,
									["upper_enabled"] = false,
								},
								["textL_translit_text"] = true,
								["texture_custom_file"] = "Interface\\",
								["texture_file"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum7pixel.tga",
								["height"] = 21,
								["font_size"] = 11,
								["icon_file"] = "Interface\\AddOns\\Details\\images\\classes_small",
								["icon_grayscale"] = false,
								["backdrop"] = {
									["enabled"] = false,
									["size"] = 2.259999990463257,
									["color"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["texture"] = "Details BarBorder 2",
								},
								["textR_bracket"] = "NONE",
								["texture_custom"] = "",
								["textL_outline_small"] = true,
								["fixed_texture_color"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
								},
								["textL_show_number"] = true,
								["textR_enable_custom_text"] = false,
								["textR_outline_small"] = true,
								["textR_custom_text"] = "{data1}. {data3}{data2}",
								["texture"] = "Eltreum7pixel",
								["fixed_texture_background_color"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
									0.150228589773178, -- [4]
								},
								["texture_background_file"] = "Interface\\Addons\\SharedMedia_MyMedia\\statusbar\\Empty.tga",
								["textR_class_colors"] = false,
								["textR_outline_small_color"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
									1, -- [4]
								},
								["textL_class_colors"] = true,
								["texture_background"] = "Empty",
								["alpha"] = 1,
								["no_icon"] = false,
								["icon_offset"] = {
									0, -- [1]
									0, -- [2]
								},
								["start_after_icon"] = true,
								["font_face"] = "Kimberley",
								["texture_class_colors"] = true,
								["percent_type"] = 1,
								["fast_ps_update"] = false,
								["textR_separator"] = "NONE",
								["use_spec_icons"] = true,
							},
							["switch_tank"] = false,
							["plugins_grow_direction"] = 2,
							["menu_icons"] = {
								true, -- [1]
								true, -- [2]
								true, -- [3]
								true, -- [4]
								false, -- [5]
								false, -- [6]
								["space"] = -2,
								["shadow"] = true,
							},
							["desaturated_menu"] = true,
							["micro_displays_side"] = 2,
							["window_scale"] = 1,
							["hide_icon"] = false,
							["toolbar_side"] = 1,
							["bg_g"] = 0.09411764705882353,
							["menu_icons_alpha"] = 0.5,
							["bg_b"] = 0.09411764705882353,
							["switch_healer_in_combat"] = false,
							["color"] = {
								0, -- [1]
								0, -- [2]
								0, -- [3]
								0, -- [4]
							},
							["hide_on_context"] = {
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [1]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [2]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [3]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [4]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [5]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [6]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [7]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [8]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [9]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [10]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [11]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [12]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [13]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [14]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [15]
							},
							["skin"] = "Minimalistic",
							["following"] = {
								["bar_color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
								},
								["enabled"] = true,
								["text_color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
								},
							},
							["switch_healer"] = false,
							["fontstrings_text2_anchor"] = 70,
							["__snapV"] = false,
							["__snapH"] = false,
							["StatusBarSaved"] = {
								["center"] = "",
								["right"] = "",
								["options"] = {
									["DETAILS_STATUSBAR_PLUGIN_PDPS"] = {
										["isHidden"] = true,
										["segmentType"] = 2,
										["textFace"] = "Accidental Presidency",
										["textColor"] = {
											1, -- [1]
											1, -- [2]
											1, -- [3]
											1, -- [4]
										},
										["textAlign"] = 3,
										["timeType"] = 1,
										["textSize"] = 10,
										["textYMod"] = 1,
									},
									["DETAILS_STATUSBAR_PLUGIN_PSEGMENT"] = {
										["isHidden"] = true,
										["segmentType"] = 2,
										["textFace"] = "Accidental Presidency",
										["textColor"] = {
											1, -- [1]
											1, -- [2]
											1, -- [3]
											1, -- [4]
										},
										["textAlign"] = 1,
										["timeType"] = 1,
										["textSize"] = 10,
										["textYMod"] = 1,
									},
									["DETAILS_STATUSBAR_PLUGIN_CLOCK"] = {
										["isHidden"] = true,
										["segmentType"] = 2,
										["textFace"] = "Accidental Presidency",
										["textColor"] = {
											1, -- [1]
											1, -- [2]
											1, -- [3]
											1, -- [4]
										},
										["textAlign"] = 2,
										["timeType"] = 1,
										["textSize"] = 10,
										["textYMod"] = 1,
									},
								},
								["left"] = "",
							},
							["grab_on_top"] = false,
							["__was_opened"] = true,
							["instance_button_anchor"] = {
								-27, -- [1]
								1, -- [2]
							},
							["version"] = 3,
							["fontstrings_text4_anchor"] = 0,
							["__locked"] = true,
							["menu_alpha"] = {
								["enabled"] = false,
								["onleave"] = 1,
								["ignorebars"] = false,
								["iconstoo"] = true,
								["onenter"] = 1,
							},
							["switch_all_roles_after_wipe"] = false,
							["row_show_animation"] = {
								["anim"] = "Fade",
								["options"] = {
								},
							},
							["bars_inverted"] = false,
							["strata"] = "LOW",
							["clickthrough_incombatonly"] = true,
							["__snap"] = {
								[3] = 2,
							},
							["stretch_button_side"] = 1,
							["hide_in_combat_alpha"] = 0,
							["bars_sort_direction"] = 1,
							["show_statusbar"] = false,
							["libwindow"] = {
								["y"] = 22.85706329345703,
								["x"] = -204.93603515625,
								["point"] = "BOTTOMRIGHT",
								["scale"] = 1,
							},
							["statusbar_info"] = {
								["alpha"] = 0,
								["overlay"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
								},
							},
							["backdrop_texture"] = "None",
							["menu_anchor_down"] = {
								16, -- [1]
								-3, -- [2]
							},
							["bg_alpha"] = 0.1800000071525574,
							["switch_tank_in_combat"] = false,
							["bars_grow_direction"] = 1,
							["switch_damager_in_combat"] = false,
							["icon_desaturated"] = false,
							["clickthrough_rows"] = false,
							["auto_current"] = true,
							["attribute_text"] = {
								["enabled"] = true,
								["shadow"] = true,
								["side"] = 1,
								["text_color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["custom_text"] = "{name}",
								["text_face"] = "Kimberley",
								["anchor"] = {
									0, -- [1]
									3, -- [2]
								},
								["text_size"] = 12,
								["enable_custom_text"] = false,
								["show_timer"] = false,
							},
							["auto_hide_menu"] = {
								["left"] = true,
								["right"] = false,
							},
							["switch_damager"] = false,
							["hide_in_combat"] = false,
							["posicao"] = {
								["normal"] = {
									["y"] = -446.5714721679688,
									["x"] = 667.3021850585938,
									["w"] = 205.9999542236328,
									["h"] = 158.2857513427734,
								},
								["solo"] = {
									["y"] = 2,
									["x"] = 1,
									["w"] = 300,
									["h"] = 200,
								},
							},
							["skin_custom"] = "",
							["ignore_mass_showhide"] = false,
							["wallpaper"] = {
								["overlay"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["texcoord"] = {
									0, -- [1]
									1, -- [2]
									0, -- [3]
									0.7, -- [4]
								},
								["enabled"] = false,
								["anchor"] = "all",
								["height"] = 114.042518615723,
								["alpha"] = 0.5,
								["width"] = 283.000183105469,
							},
							["total_bar"] = {
								["enabled"] = false,
								["only_in_group"] = true,
								["icon"] = "Interface\\ICONS\\INV_Sigil_Thorim",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
								},
							},
							["show_sidebars"] = false,
							["fontstrings_text3_anchor"] = 35,
							["use_multi_fontstrings"] = true,
							["menu_icons_size"] = 0.8500000238418579,
						}, -- [1]
						{
							["__pos"] = {
								["normal"] = {
									["y"] = -446.5714721679688,
									["x"] = 872.0086059570312,
									["w"] = 203.4126281738281,
									["h"] = 158.2857513427734,
								},
								["solo"] = {
									["y"] = 2,
									["x"] = 1,
									["w"] = 300,
									["h"] = 200,
								},
							},
							["hide_in_combat_type"] = 1,
							["clickthrough_window"] = false,
							["menu_anchor"] = {
								16, -- [1]
								0, -- [2]
								["side"] = 2,
							},
							["bg_r"] = 0.09411764705882353,
							["hide_out_of_combat"] = false,
							["color_buttons"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["toolbar_icon_file"] = "Interface\\AddOns\\Details\\images\\toolbar_icons_2",
							["micro_displays_locked"] = true,
							["fontstrings_width"] = 35,
							["tooltip"] = {
								["n_abilities"] = 3,
								["n_enemies"] = 3,
							},
							["switch_all_roles_in_combat"] = false,
							["clickthrough_toolbaricons"] = false,
							["row_info"] = {
								["textR_outline"] = true,
								["spec_file"] = "Interface\\AddOns\\Details\\images\\spec_icons_normal",
								["textL_outline"] = true,
								["texture_highlight"] = "Interface\\FriendsFrame\\UI-FriendsList-Highlight",
								["textR_show_data"] = {
									true, -- [1]
									true, -- [2]
									false, -- [3]
								},
								["textL_enable_custom_text"] = false,
								["fixed_text_color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["space"] = {
									["right"] = 0,
									["left"] = 0,
									["between"] = 1,
								},
								["texture_background_class_color"] = false,
								["textL_outline_small_color"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
									1, -- [4]
								},
								["font_face_file"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Font\\Kimberley.otf",
								["textL_custom_text"] = "{data1}. {data3}{data2}",
								["models"] = {
									["upper_model"] = "Spells\\AcidBreath_SuperGreen.M2",
									["lower_model"] = "World\\EXPANSION02\\DOODADS\\Coldarra\\COLDARRALOCUS.m2",
									["upper_alpha"] = 0.5,
									["lower_enabled"] = false,
									["lower_alpha"] = 0.1,
									["upper_enabled"] = false,
								},
								["textL_translit_text"] = true,
								["texture_custom_file"] = "Interface\\",
								["texture_file"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum7pixel.tga",
								["height"] = 21,
								["font_size"] = 11,
								["icon_file"] = "Interface\\AddOns\\Details\\images\\classes_small",
								["icon_grayscale"] = false,
								["backdrop"] = {
									["enabled"] = false,
									["size"] = 2.259999990463257,
									["color"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["texture"] = "Details BarBorder 2",
								},
								["textR_bracket"] = "NONE",
								["texture_custom"] = "",
								["textL_outline_small"] = true,
								["fixed_texture_color"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
								},
								["textL_show_number"] = true,
								["textR_enable_custom_text"] = false,
								["textR_outline_small"] = true,
								["textR_custom_text"] = "{data1}. {data3}{data2}",
								["texture"] = "Eltreum7pixel",
								["fixed_texture_background_color"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
									0.150228589773178, -- [4]
								},
								["texture_background_file"] = "Interface\\Addons\\SharedMedia_MyMedia\\statusbar\\Empty.tga",
								["textR_class_colors"] = false,
								["textR_outline_small_color"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
									1, -- [4]
								},
								["textL_class_colors"] = true,
								["texture_background"] = "Empty",
								["alpha"] = 1,
								["no_icon"] = false,
								["icon_offset"] = {
									0, -- [1]
									0, -- [2]
								},
								["start_after_icon"] = true,
								["font_face"] = "Kimberley",
								["texture_class_colors"] = true,
								["percent_type"] = 1,
								["fast_ps_update"] = false,
								["textR_separator"] = "NONE",
								["use_spec_icons"] = true,
							},
							["switch_tank"] = false,
							["plugins_grow_direction"] = 2,
							["menu_icons"] = {
								true, -- [1]
								true, -- [2]
								true, -- [3]
								true, -- [4]
								false, -- [5]
								false, -- [6]
								["space"] = -2,
								["shadow"] = true,
							},
							["desaturated_menu"] = true,
							["micro_displays_side"] = 2,
							["window_scale"] = 1,
							["hide_icon"] = false,
							["toolbar_side"] = 1,
							["bg_g"] = 0.09411764705882353,
							["menu_icons_alpha"] = 0.5,
							["bg_b"] = 0.09411764705882353,
							["switch_healer_in_combat"] = false,
							["color"] = {
								0, -- [1]
								0, -- [2]
								0, -- [3]
								0, -- [4]
							},
							["hide_on_context"] = {
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [1]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [2]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [3]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [4]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [5]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [6]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [7]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [8]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [9]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [10]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [11]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [12]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [13]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [14]
								{
									["enabled"] = false,
									["inverse"] = false,
									["value"] = 100,
								}, -- [15]
							},
							["skin"] = "Minimalistic",
							["following"] = {
								["bar_color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
								},
								["enabled"] = true,
								["text_color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
								},
							},
							["switch_healer"] = false,
							["fontstrings_text2_anchor"] = 70,
							["__snapV"] = false,
							["__snapH"] = false,
							["StatusBarSaved"] = {
								["center"] = "",
								["right"] = "",
								["options"] = {
									["DETAILS_STATUSBAR_PLUGIN_PDPS"] = {
										["isHidden"] = true,
										["timeType"] = 1,
										["maxSectionIds"] = 18,
										["segmentType"] = 2,
										["textFace"] = "Accidental Presidency",
										["textYMod"] = 1,
										["textAlign"] = 3,
										["textSize"] = 10,
										["textColor"] = {
											1, -- [1]
											1, -- [2]
											1, -- [3]
											1, -- [4]
										},
									},
									["DETAILS_STATUSBAR_PLUGIN_PSEGMENT"] = {
										["isHidden"] = true,
										["timeType"] = 1,
										["maxSectionIds"] = 18,
										["segmentType"] = 2,
										["textFace"] = "Accidental Presidency",
										["textYMod"] = 1,
										["textAlign"] = 1,
										["textSize"] = 10,
										["textColor"] = {
											1, -- [1]
											1, -- [2]
											1, -- [3]
											1, -- [4]
										},
									},
									["DETAILS_STATUSBAR_PLUGIN_CLOCK"] = {
										["isHidden"] = true,
										["timeType"] = 1,
										["maxSectionIds"] = 18,
										["segmentType"] = 2,
										["textFace"] = "Accidental Presidency",
										["textYMod"] = 1,
										["textAlign"] = 2,
										["textSize"] = 10,
										["textColor"] = {
											1, -- [1]
											1, -- [2]
											1, -- [3]
											1, -- [4]
										},
									},
								},
								["left"] = "",
							},
							["grab_on_top"] = false,
							["__was_opened"] = true,
							["instance_button_anchor"] = {
								-27, -- [1]
								1, -- [2]
							},
							["version"] = 3,
							["fontstrings_text4_anchor"] = 0,
							["__locked"] = true,
							["menu_alpha"] = {
								["enabled"] = false,
								["onleave"] = 1,
								["ignorebars"] = false,
								["iconstoo"] = true,
								["onenter"] = 1,
							},
							["switch_all_roles_after_wipe"] = false,
							["row_show_animation"] = {
								["anim"] = "Fade",
								["options"] = {
								},
							},
							["bars_inverted"] = false,
							["strata"] = "LOW",
							["clickthrough_incombatonly"] = true,
							["__snap"] = {
								1, -- [1]
							},
							["stretch_button_side"] = 1,
							["hide_in_combat_alpha"] = 0,
							["bars_sort_direction"] = 1,
							["show_statusbar"] = false,
							["libwindow"] = {
								["y"] = 22.85706329345703,
								["x"] = -1.5234375,
								["point"] = "BOTTOMRIGHT",
								["scale"] = 1,
							},
							["statusbar_info"] = {
								["alpha"] = 0,
								["overlay"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
								},
							},
							["backdrop_texture"] = "None",
							["menu_anchor_down"] = {
								16, -- [1]
								-3, -- [2]
							},
							["bg_alpha"] = 0.1800000071525574,
							["switch_tank_in_combat"] = false,
							["bars_grow_direction"] = 1,
							["switch_damager_in_combat"] = false,
							["icon_desaturated"] = false,
							["clickthrough_rows"] = false,
							["auto_current"] = true,
							["attribute_text"] = {
								["enabled"] = true,
								["shadow"] = true,
								["side"] = 1,
								["text_color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["custom_text"] = "{name}",
								["text_face"] = "Kimberley",
								["anchor"] = {
									0, -- [1]
									3, -- [2]
								},
								["text_size"] = 12,
								["enable_custom_text"] = false,
								["show_timer"] = false,
							},
							["auto_hide_menu"] = {
								["left"] = true,
								["right"] = false,
							},
							["switch_damager"] = false,
							["hide_in_combat"] = false,
							["posicao"] = {
								["normal"] = {
									["y"] = -446.5714721679688,
									["x"] = 872.0086059570312,
									["w"] = 203.4126281738281,
									["h"] = 158.2857513427734,
								},
								["solo"] = {
									["y"] = 2,
									["x"] = 1,
									["w"] = 300,
									["h"] = 200,
								},
							},
							["skin_custom"] = "",
							["ignore_mass_showhide"] = false,
							["wallpaper"] = {
								["overlay"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["texcoord"] = {
									0, -- [1]
									1, -- [2]
									0, -- [3]
									0.7, -- [4]
								},
								["enabled"] = false,
								["anchor"] = "all",
								["height"] = 114.042518615723,
								["alpha"] = 0.5,
								["width"] = 283.000183105469,
							},
							["total_bar"] = {
								["enabled"] = false,
								["only_in_group"] = true,
								["icon"] = "Interface\\ICONS\\INV_Sigil_Thorim",
								["color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
								},
							},
							["show_sidebars"] = false,
							["fontstrings_text3_anchor"] = 35,
							["use_multi_fontstrings"] = true,
							["menu_icons_size"] = 0.850000023841858,
						}, -- [2]
					},
					["hotcorner_topleft"] = {
						["hide"] = false,
					},
					["font_faces"] = {
						["menus"] = "Kimberley",
					},
					["deadlog_limit"] = 16,
					["instances_segments_locked"] = true,
					["instances_no_libwindow"] = false,
					["segments_amount"] = 40,
					["report_lines"] = 5,
					["data_broker_text"] = "",
					["clear_ungrouped"] = true,
					["skin"] = "Dark Theme",
					["override_spellids"] = true,
					["font_sizes"] = {
						["menus"] = 10,
					},
					["total_abbreviation"] = 2,
					["report_schema"] = 1,
					["animation_speed_triggertravel"] = 5,
					["minimum_combat_time"] = 5,
					["use_battleground_server_parser"] = false,
					["cloud_capture"] = true,
					["damage_taken_everything"] = false,
					["scroll_speed"] = 2,
					["new_window_size"] = {
						["height"] = 158,
						["width"] = 310,
					},
					["chat_tab_embed"] = {
						["enabled"] = false,
						["tab_name"] = "",
						["x_offset"] = 0,
						["y_offset"] = 0,
						["single_window"] = false,
					},
					["deadlog_events"] = 32,
					["use_scroll"] = false,
					["close_shields"] = false,
					["class_coords"] = {
						["HUNTER"] = {
							0, -- [1]
							0.25, -- [2]
							0.25, -- [3]
							0.5, -- [4]
						},
						["WARRIOR"] = {
							0, -- [1]
							0.25, -- [2]
							0, -- [3]
							0.25, -- [4]
						},
						["SHAMAN"] = {
							0.25, -- [1]
							0.49609375, -- [2]
							0.25, -- [3]
							0.5, -- [4]
						},
						["MAGE"] = {
							0.25, -- [1]
							0.49609375, -- [2]
							0, -- [3]
							0.25, -- [4]
						},
						["PET"] = {
							0.25, -- [1]
							0.49609375, -- [2]
							0.75, -- [3]
							1, -- [4]
						},
						["DRUID"] = {
							0.7421875, -- [1]
							0.98828125, -- [2]
							0, -- [3]
							0.25, -- [4]
						},
						["MONK"] = {
							0.5, -- [1]
							0.73828125, -- [2]
							0.5, -- [3]
							0.75, -- [4]
						},
						["DEATHKNIGHT"] = {
							0.25, -- [1]
							0.5, -- [2]
							0.5, -- [3]
							0.75, -- [4]
						},
						["WARLOCK"] = {
							0.7421875, -- [1]
							0.98828125, -- [2]
							0.25, -- [3]
							0.5, -- [4]
						},
						["UNKNOW"] = {
							0.5, -- [1]
							0.75, -- [2]
							0.75, -- [3]
							1, -- [4]
						},
						["PRIEST"] = {
							0.49609375, -- [1]
							0.7421875, -- [2]
							0.25, -- [3]
							0.5, -- [4]
						},
						["UNGROUPPLAYER"] = {
							0.5, -- [1]
							0.75, -- [2]
							0.75, -- [3]
							1, -- [4]
						},
						["Alliance"] = {
							0.49609375, -- [1]
							0.7421875, -- [2]
							0.75, -- [3]
							1, -- [4]
						},
						["ENEMY"] = {
							0, -- [1]
							0.25, -- [2]
							0.75, -- [3]
							1, -- [4]
						},
						["DEMONHUNTER"] = {
							0.73828126, -- [1]
							1, -- [2]
							0.5, -- [3]
							0.75, -- [4]
						},
						["Horde"] = {
							0.7421875, -- [1]
							0.98828125, -- [2]
							0.75, -- [3]
							1, -- [4]
						},
						["PALADIN"] = {
							0, -- [1]
							0.25, -- [2]
							0.5, -- [3]
							0.75, -- [4]
						},
						["ROGUE"] = {
							0.49609375, -- [1]
							0.7421875, -- [2]
							0, -- [3]
							0.25, -- [4]
						},
						["MONSTER"] = {
							0, -- [1]
							0.25, -- [2]
							0.75, -- [3]
							1, -- [4]
						},
					},
					["overall_clear_logout"] = false,
					["disable_alldisplays_window"] = false,
					["trash_auto_remove"] = true,
					["window_clamp"] = {
						-8, -- [1]
						0, -- [2]
						21, -- [3]
						-14, -- [4]
					},
					["windows_fade_out"] = {
						"out", -- [1]
						0.2, -- [2]
					},
					["numerical_system_symbols"] = "auto",
					["clear_graphic"] = true,
					["class_colors"] = {
						["HUNTER"] = {
							0.67, -- [1]
							0.83, -- [2]
							0.45, -- [3]
						},
						["WARRIOR"] = {
							0.78, -- [1]
							0.61, -- [2]
							0.43, -- [3]
						},
						["ROGUE"] = {
							1, -- [1]
							0.96, -- [2]
							0.41, -- [3]
						},
						["MAGE"] = {
							0.41, -- [1]
							0.8, -- [2]
							0.94, -- [3]
						},
						["ARENA_YELLOW"] = {
							1, -- [1]
							1, -- [2]
							0.25, -- [3]
						},
						["UNGROUPPLAYER"] = {
							0.4, -- [1]
							0.4, -- [2]
							0.4, -- [3]
						},
						["DRUID"] = {
							1, -- [1]
							0.49, -- [2]
							0.04, -- [3]
						},
						["MONK"] = {
							0, -- [1]
							1, -- [2]
							0.59, -- [3]
						},
						["DEATHKNIGHT"] = {
							0.77, -- [1]
							0.12, -- [2]
							0.23, -- [3]
						},
						["PET"] = {
							0.3, -- [1]
							0.4, -- [2]
							0.5, -- [3]
						},
						["UNKNOW"] = {
							0.2, -- [1]
							0.2, -- [2]
							0.2, -- [3]
						},
						["PRIEST"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
						},
						["SHAMAN"] = {
							0, -- [1]
							0.44, -- [2]
							0.87, -- [3]
						},
						["ARENA_GREEN"] = {
							0.4, -- [1]
							1, -- [2]
							0.4, -- [3]
						},
						["ENEMY"] = {
							0.94117, -- [1]
							0, -- [2]
							0.0196, -- [3]
							1, -- [4]
						},
						["DEMONHUNTER"] = {
							0.64, -- [1]
							0.19, -- [2]
							0.79, -- [3]
						},
						["version"] = 1,
						["NEUTRAL"] = {
							1, -- [1]
							1, -- [2]
							0, -- [3]
						},
						["PALADIN"] = {
							0.96, -- [1]
							0.55, -- [2]
							0.73, -- [3]
						},
						["WARLOCK"] = {
							0.58, -- [1]
							0.51, -- [2]
							0.79, -- [3]
						},
					},
					["segments_auto_erase"] = 3,
					["options_group_edit"] = true,
					["broadcaster_enabled"] = false,
					["minimap"] = {
						["minimapPos"] = 220,
						["radius"] = 160,
						["hide"] = true,
						["onclick_what_todo"] = 1,
						["text_format"] = 3,
						["text_type"] = 1,
					},
					["instances_amount"] = 2,
					["max_window_size"] = {
						["height"] = 450,
						["width"] = 480,
					},
					["deny_score_messages"] = false,
					["only_pvp_frags"] = false,
					["disable_stretch_button"] = true,
					["default_bg_color"] = 0.0941,
					["standard_skin"] = false,
					["segments_amount_to_save"] = 40,
					["segments_panic_mode"] = false,
					["overall_flag"] = 16,
					["overall_clear_newboss"] = true,
					["row_fade_out"] = {
						"out", -- [1]
						0.2, -- [2]
					},
					["player_details_window"] = {
						["scale"] = 1,
						["skin"] = "ElvUI",
						["bar_texture"] = "Skyline",
					},
					["numerical_system"] = 1,
					["pvp_as_group"] = true,
					["force_activity_time_pvp"] = true,
					["class_icons_small"] = "Interface\\AddOns\\Details\\images\\classes_small",
					["memory_threshold"] = 3,
					["disable_reset_button"] = false,
					["animate_scroll"] = false,
					["death_tooltip_width"] = 350,
					["time_type"] = 2,
					["default_bg_alpha"] = 0.5,
					["time_type_original"] = 2,
				},
			},
			["immersion_special_units"] = true,
			["deathlog_healingdone_min_arena"] = 400,
			["boss_mods_timers"] = {
				["encounter_timers_dbm"] = {
					["332687"] = {
						"332687", -- [1]
						"Timer332687cdcount	2", -- [2]
						"~Roar (2)", -- [3]
						31.9, -- [4]
						892447, -- [5]
						"cdcount", -- [6]
						332687, -- [7]
						2, -- [8]
						"2394", -- [9]
						["id"] = 2399,
					},
					["319626"] = {
						"319626", -- [1]
						"Timer319626cd", -- [2]
						"~Phantasmal Parasite", -- [3]
						3.3, -- [4]
						236298, -- [5]
						"cd", -- [6]
						319626, -- [7]
						3, -- [8]
						"2389", -- [9]
						["id"] = 2364,
					},
					["246220"] = {
						"246220", -- [1]
						"Timer246220next", -- [2]
						"Fel Bombardment", -- [3]
						9.7, -- [4]
						132212, -- [5]
						"next", -- [6]
						246220, -- [7]
						5, -- [8]
						"1992", -- [9]
						["id"] = 2076,
					},
					["323877"] = {
						"323877", -- [1]
						"Timer323877nextcount	1", -- [2]
						"Laser (1)", -- [3]
						8, -- [4]
						892834, -- [5]
						"nextcount", -- [6]
						323877, -- [7]
						2, -- [8]
						"2409", -- [9]
						["id"] = 2394,
					},
					["244057"] = {
						"244057", -- [1]
						"Timer244057cd", -- [2]
						"~Enflame Corruption", -- [3]
						48.3, -- [4]
						135822, -- [5]
						"cd", -- [6]
						244057, -- [7]
						3, -- [8]
						"1987", -- [9]
						["id"] = 2074,
					},
					["345397"] = {
						"345397", -- [1]
						"Timer345397cdcount	1", -- [2]
						"~Wave of Blood (1)", -- [3]
						12, -- [4]
						1035055, -- [5]
						"cdcount", -- [6]
						345397, -- [7]
						2, -- [8]
						"2393", -- [9]
						["id"] = 2398,
					},
					["331314"] = {
						"331314", -- [1]
						"Timer331314active", -- [2]
						"Destructive Impact ends", -- [3]
						12, -- [4]
						135860, -- [5]
						"active", -- [6]
						331314, -- [7]
						5, -- [8]
						"2394", -- [9]
						["id"] = 2399,
					},
					["153153"] = {
						"153153", -- [1]
						"Timer153153cd", -- [2]
						"~Dark Communion", -- [3]
						24, -- [4]
						632353, -- [5]
						"cd", -- [6]
						153153, -- [7]
						1, -- [8]
						"1139", -- [9]
						["id"] = 1677,
					},
					["244042"] = {
						"244042", -- [1]
						"Timer244042next", -- [2]
						"Marked Prey", -- [3]
						25.2, -- [4]
						458727, -- [5]
						"next", -- [6]
						244042, -- [7]
						3, -- [8]
						"1983", -- [9]
						["id"] = 2069,
					},
					["321009"] = {
						"321009", -- [1]
						"Timer321009cd	1", -- [2]
						"~Charged Spear", -- [3]
						3.6, -- [4]
						1508065, -- [5]
						"cd", -- [6]
						321009, -- [7]
						3, -- [8]
						"2399", -- [9]
						["id"] = 2357,
					},
					["244677"] = {
						"244677", -- [1]
						"Timer244677cd", -- [2]
						"~Transport Portal", -- [3]
						36.5, -- [4]
						459027, -- [5]
						"cd", -- [6]
						244677, -- [7]
						1, -- [8]
						"1985", -- [9]
						["id"] = 2064,
					},
					["324148"] = {
						"324148", -- [1]
						"Timer324148cd", -- [2]
						"~Dark Stride", -- [3]
						10.1, -- [4]
						132303, -- [5]
						"cd", -- [6]
						324148, -- [7]
						3, -- [8]
						"2416", -- [9]
						["id"] = 2356,
					},
					["107120"] = {
						"107120", -- [1]
						"Timer107120next", -- [2]
						"Frenzied Assault", -- [3]
						6, -- [4]
						132152, -- [5]
						"next", -- [6]
						107120, -- [7]
						5, -- [8]
						"676", -- [9]
						["id"] = 1406,
					},
					["320012"] = {
						"320012", -- [1]
						"Timer320012cd", -- [2]
						"~Unholy Frenzy", -- [3]
						6, -- [4]
						136224, -- [5]
						"cd", -- [6]
						320012, -- [7]
						5, -- [8]
						"2391", -- [9]
						["id"] = 2388,
					},
					["ej5081"] = {
						"ej5081", -- [1]
						"Timerej5081cd", -- [2]
						"~Fel Crystal", -- [3]
						15, -- [4]
						136170, -- [5]
						"cd", -- [6]
						"ej5081", -- [7]
						1, -- [8]
						"530", -- [9]
						["id"] = 1897,
					},
					["244410"] = {
						"244410", -- [1]
						"Timer244410next", -- [2]
						"Decimation", -- [3]
						15.8, -- [4]
						236216, -- [5]
						"next", -- [6]
						244410, -- [7]
						3, -- [8]
						"1992", -- [9]
						["id"] = 2076,
					},
					["320787"] = {
						"320787", -- [1]
						"Timer320787cd", -- [2]
						"~Summon Power Crystal", -- [3]
						7.4, -- [4]
						132776, -- [5]
						"cd", -- [6]
						320787, -- [7]
						5, -- [8]
						"2409", -- [9]
						["id"] = 2394,
					},
					["200227"] = {
						"200227", -- [1]
						"Timer200227cd", -- [2]
						"~Tangled Web", -- [3]
						35, -- [4]
						237431, -- [5]
						"cd", -- [6]
						200227, -- [7]
						3, -- [8]
						"1500", -- [9]
						["id"] = 1826,
					},
					["331634"] = {
						"331634", -- [1]
						"Timer331634cd", -- [2]
						"~Dark Recital", -- [3]
						24.5, -- [4]
						607854, -- [5]
						"cd", -- [6]
						331634, -- [7]
						3, -- [8]
						"2426", -- [9]
						["id"] = 2412,
					},
					["237590"] = {
						"237590", -- [1]
						"Timer237590cd", -- [2]
						"~Hopeless Reflection", -- [3]
						27, -- [4]
						1391776, -- [5]
						"cd", -- [6]
						237590, -- [7]
						3, -- [8]
						"1898", -- [9]
						["id"] = 2051,
					},
					["30496"] = {
						"30496", -- [1]
						"Timer30496next", -- [2]
						"Lesser Shadow Fissure", -- [3]
						8.3, -- [4]
						136160, -- [5]
						"next", -- [6]
						30496, -- [7]
						3, -- [8]
						"566", -- [9]
						["id"] = 1936,
					},
					["154135"] = {
						"154135", -- [1]
						"Timer154135cdcount	1", -- [2]
						"~Burst (1)", -- [3]
						20, -- [4]
						525026, -- [5]
						"cdcount", -- [6]
						154135, -- [7]
						2, -- [8]
						"966", -- [9]
						["id"] = 1699,
					},
					["322554"] = {
						"322554", -- [1]
						"Timer322554next", -- [2]
						"Castigate", -- [3]
						3.7, -- [4]
						458735, -- [5]
						"next", -- [6]
						322554, -- [7]
						3, -- [8]
						"2415", -- [9]
						["id"] = 2361,
					},
					["152801"] = {
						"152801", -- [1]
						"Timer152801cd", -- [2]
						"~Void Vortex", -- [3]
						23, -- [4]
						236296, -- [5]
						"cd", -- [6]
						152801, -- [7]
						2, -- [8]
						"1168", -- [9]
						["id"] = 1688,
					},
					["339690"] = {
						"339690", -- [1]
						"Timer339690cdcount3	1", -- [2]
						"~Crystalize (1)", -- [3]
						23.1, -- [4]
						132780, -- [5]
						"cdcount", -- [6]
						339690, -- [7]
						5, -- [8]
						"2425", -- [9]
						["id"] = 2417,
					},
					["234015"] = {
						"234015", -- [1]
						"Timer234015cdcount	2", -- [2]
						"~Tormenting Burst (2)", -- [3]
						17, -- [4]
						136123, -- [5]
						"cdcount", -- [6]
						234015, -- [7]
						2, -- [8]
						"1867", -- [9]
						["id"] = 2048,
					},
					["320102"] = {
						"320102", -- [1]
						"Timer320102cdcount	1", -- [2]
						"~Blood and Glory (1)", -- [3]
						33.9, -- [4]
						1322720, -- [5]
						"cdcount", -- [6]
						320102, -- [7]
						3, -- [8]
						"2390", -- [9]
						["id"] = 2366,
					},
					["ej22131"] = {
						"ej22131", -- [1]
						"Timerej22131nextcount	1", -- [2]
						"Crimson Cabalist (1)", -- [3]
						9.7, -- [4]
						3528307, -- [5]
						"nextcount", -- [6]
						"ej22131", -- [7]
						1, -- [8]
						"2424", -- [9]
						["id"] = 2407,
					},
					["118958"] = {
						"118958", -- [1]
						"Timer118958target	Glintrok Ironhide", -- [2]
						"Iron Protector: Glintrok Ironhide", -- [3]
						15, -- [4]
						134951, -- [5]
						"target", -- [6]
						118958, -- [7]
						0, -- [8]
						"690", -- [9]
						["id"] = 2129,
					},
					["319713"] = {
						"319713", -- [1]
						"Timer319713cd", -- [2]
						"~Juggernaut Rush", -- [3]
						15.5, -- [4]
						132335, -- [5]
						"cd", -- [6]
						319713, -- [7]
						3, -- [8]
						"2388", -- [9]
						["id"] = 2360,
					},
					["346654"] = {
						"346654", -- [1]
						"Timer346654cd", -- [2]
						"~Drain Essence", -- [3]
						15.5, -- [4]
						1003601, -- [5]
						"cd", -- [6]
						346654, -- [7]
						5, -- [8]
						"2426", -- [9]
						["id"] = 2412,
					},
					["239132"] = {
						"239132", -- [1]
						"Timer239132cdcount	1", -- [2]
						"~Rupture Realities (1)", -- [3]
						31, -- [4]
						135801, -- [5]
						"cdcount", -- [6]
						239132, -- [7]
						2, -- [8]
						"1873", -- [9]
						["id"] = 2038,
					},
					["246779"] = {
						"246779", -- [1]
						"Timer246779cd", -- [2]
						"~Diabolic Bomb", -- [3]
						11, -- [4]
						1097742, -- [5]
						"cd", -- [6]
						246779, -- [7]
						3, -- [8]
						"2004", -- [9]
						["id"] = 2088,
					},
					["ej21953"] = {
						"ej21953", -- [1]
						"Timerej21953cdcount	1", -- [2]
						"~Soul Infuser (1)", -- [3]
						130, -- [4]
						607854, -- [5]
						"cdcount", -- [6]
						"ej21953", -- [7]
						1, -- [8]
						"2422", -- [9]
						["id"] = 2402,
					},
					["323437"] = {
						"323437", -- [1]
						"Timer323437cd", -- [2]
						"~Stigma of Pride", -- [3]
						10, -- [4]
						538039, -- [5]
						"cd", -- [6]
						323437, -- [7]
						5, -- [8]
						"2413", -- [9]
						["id"] = 2381,
					},
					["342425"] = {
						"342425", -- [1]
						"Timer342425cdcount	1", -- [2]
						"~Stone Fist (1)", -- [3]
						26.4, -- [4]
						136225, -- [5]
						"cdcount", -- [6]
						342425, -- [7]
						5, -- [8]
						"2425", -- [9]
						["id"] = 2417,
					},
					["153764"] = {
						"153764", -- [1]
						"Timer153764next", -- [2]
						"Claws of Argus", -- [3]
						34, -- [4]
						136157, -- [5]
						"next", -- [6]
						153764, -- [7]
						6, -- [8]
						"1216", -- [9]
						["id"] = 1678,
					},
					["153396"] = {
						"153396", -- [1]
						"Timer153396next", -- [2]
						"Curtain of Flame", -- [3]
						16, -- [4]
						135793, -- [5]
						"next", -- [6]
						153396, -- [7]
						3, -- [8]
						"1216", -- [9]
						["id"] = 1678,
					},
					["119922"] = {
						"119922", -- [1]
						"Timer119922cd", -- [2]
						"~Shockwave", -- [3]
						19, -- [4]
						451165, -- [5]
						"cd", -- [6]
						119922, -- [7]
						3, -- [8]
						"708", -- [9]
						["id"] = 1442,
					},
					["325361"] = {
						"325361", -- [1]
						"Timer325361target2	Tawariel", -- [2]
						"Glyph of Destruction: Tawariel", -- [3]
						4, -- [4]
						236219, -- [5]
						"target", -- [6]
						325361, -- [7]
						2, -- [8]
						"2418", -- [9]
						["id"] = 2405,
					},
					["323810"] = {
						"323810", -- [1]
						"Timer323810cd", -- [2]
						"~Piercing Blur", -- [3]
						10.6, -- [4]
						1029589, -- [5]
						"cd", -- [6]
						323810, -- [7]
						3, -- [8]
						"2407", -- [9]
						["id"] = 2363,
					},
					["251570"] = {
						"251570", -- [1]
						"Timer251570next", -- [2]
						"Soulbomb", -- [3]
						30.3, -- [4]
						1778228, -- [5]
						"next", -- [6]
						251570, -- [7]
						3, -- [8]
						"2031", -- [9]
						["id"] = 2092,
					},
					["334488"] = {
						"334488", -- [1]
						"Timer334488cd", -- [2]
						"~Sever Flesh", -- [3]
						6, -- [4]
						3616005, -- [5]
						"cd", -- [6]
						334488, -- [7]
						5, -- [8]
						"2392", -- [9]
						["id"] = 2389,
					},
					["123655"] = {
						"123655", -- [1]
						"Timer123655target	Hadir", -- [2]
						"Traumatic Blow: Hadir", -- [3]
						5, -- [4]
						132355, -- [5]
						"target", -- [6]
						123655, -- [7]
						0, -- [8]
						"708", -- [9]
						["id"] = 1442,
					},
					["154671"] = {
						"154671", -- [1]
						"Timer154671cd", -- [2]
						"~Ritual of Bones", -- [3]
						20, -- [4]
						136243, -- [5]
						"cd", -- [6]
						154671, -- [7]
						1, -- [8]
						"1160", -- [9]
						["id"] = 1682,
					},
					["320596"] = {
						"320596", -- [1]
						"Timer320596cd", -- [2]
						"~Heaving Retch", -- [3]
						10.6, -- [4]
						136182, -- [5]
						"cd", -- [6]
						320596, -- [7]
						3, -- [8]
						"2395", -- [9]
						["id"] = 2387,
					},
					["332619"] = {
						"332619", -- [1]
						"Timer332619cdcount	1", -- [2]
						"~Shattering Pain (1)", -- [3]
						13.3, -- [4]
						1357802, -- [5]
						"cdcount", -- [6]
						332619, -- [7]
						5, -- [8]
						"2424", -- [9]
						["id"] = 2407,
					},
					["333493"] = {
						"333493", -- [1]
						"Timer333493cd", -- [2]
						"~Necrotic Breath", -- [3]
						29.4, -- [4]
						2576093, -- [5]
						"cd", -- [6]
						333493, -- [7]
						3, -- [8]
						"2391", -- [9]
						["id"] = 2388,
					},
					["153006"] = {
						"153006", -- [1]
						"Timer153006next", -- [2]
						"Consecrated Light", -- [3]
						7, -- [4]
						135981, -- [5]
						"next", -- [6]
						153006, -- [7]
						2, -- [8]
						"1185", -- [9]
						["id"] = 1686,
					},
					["240319"] = {
						"240319", -- [1]
						"Timer240319next", -- [2]
						"Hatching", -- [3]
						30.5, -- [4]
						132832, -- [5]
						"next", -- [6]
						240319, -- [7]
						1, -- [8]
						"1856", -- [9]
						["id"] = 2036,
					},
					["324427"] = {
						"324427", -- [1]
						"Timer324427cd", -- [2]
						"~Empyreal Ordnance", -- [3]
						16.9, -- [4]
						1405806, -- [5]
						"cd", -- [6]
						324427, -- [7]
						3, -- [8]
						"2414", -- [9]
						["id"] = 2358,
					},
					["153804"] = {
						"153804", -- [1]
						"Timer153804cd", -- [2]
						"~Inhale", -- [3]
						27.1, -- [4]
						463565, -- [5]
						"cd", -- [6]
						153804, -- [7]
						6, -- [8]
						"1140", -- [9]
						["id"] = 1679,
					},
					["346762"] = {
						"346762", -- [1]
						"Timer346762cd", -- [2]
						"~Soul Spikes", -- [3]
						32.1, -- [4]
						3259845, -- [5]
						"cd", -- [6]
						346762, -- [7]
						3, -- [8]
						"2426", -- [9]
						["id"] = 2412,
					},
					["327227"] = {
						"327227", -- [1]
						"Timer327227cdcount	1", -- [2]
						"~Ravage (1)", -- [3]
						53.2, -- [4]
						136129, -- [5]
						"cdcount", -- [6]
						327227, -- [7]
						2, -- [8]
						"2424", -- [9]
						["id"] = 2407,
					},
					["322908"] = {
						"322908", -- [1]
						"Timer322908next", -- [2]
						"Backdraft", -- [3]
						18.2, -- [4]
						1029595, -- [5]
						"next", -- [6]
						322908, -- [7]
						2, -- [8]
						"2412", -- [9]
						["id"] = 2359,
					},
					["322304"] = {
						"322304", -- [1]
						"Timer322304cd", -- [2]
						"~Malignant Growth", -- [3]
						5.6, -- [4]
						2576086, -- [5]
						"cd", -- [6]
						322304, -- [7]
						1, -- [8]
						"2404", -- [9]
						["id"] = 2386,
					},
					["236072"] = {
						"236072", -- [1]
						"Timer236072nextcount	1", -- [2]
						"Wailing Souls (1)", -- [3]
						59.4, -- [4]
						136194, -- [5]
						"nextcount", -- [6]
						236072, -- [7]
						2, -- [8]
						"1896", -- [9]
						["id"] = 2054,
					},
					["233062"] = {
						"233062", -- [1]
						"Timer233062next", -- [2]
						"Infernal Burning", -- [3]
						54, -- [4]
						135802, -- [5]
						"next", -- [6]
						233062, -- [7]
						2, -- [8]
						"1862", -- [9]
						["id"] = 2032,
					},
					["325245"] = {
						"325245", -- [1]
						"Timer325245cd", -- [2]
						"~Shadow Ambush", -- [3]
						6.1, -- [4]
						1305160, -- [5]
						"cd", -- [6]
						325245, -- [7]
						3, -- [8]
						"2423", -- [9]
						["id"] = 2385,
					},
					["329509"] = {
						"329509", -- [1]
						"Timer329509cd", -- [2]
						"~Blazing Surge", -- [3]
						28.8, -- [4]
						524795, -- [5]
						"cd", -- [6]
						329509, -- [7]
						3, -- [8]
						"2422", -- [9]
						["id"] = 2402,
					},
					["322574"] = {
						"322574", -- [1]
						"Timer322574cd", -- [2]
						"~Coalesce Manifestation", -- [3]
						14.6, -- [4]
						132331, -- [5]
						"cd", -- [6]
						322574, -- [7]
						1, -- [8]
						"2415", -- [9]
						["id"] = 2361,
					},
					["325064"] = {
						"325064", -- [1]
						"Timer325064cd", -- [2]
						"~Beam", -- [3]
						29.1, -- [4]
						3684828, -- [5]
						"cd", -- [6]
						325064, -- [7]
						3, -- [8]
						"2420", -- [9]
						["id"] = 2406,
					},
					["321894"] = {
						"321894", -- [1]
						"Timer321894cd", -- [2]
						"~Dark Exile", -- [3]
						26.5, -- [4]
						2576087, -- [5]
						"cd", -- [6]
						321894, -- [7]
						3, -- [8]
						"2396", -- [9]
						["id"] = 2390,
					},
					["107140"] = {
						"107140", -- [1]
						"Timer107140cd", -- [2]
						"~Magnetic Shroud", -- [3]
						20, -- [4]
						132488, -- [5]
						"cd", -- [6]
						107140, -- [7]
						0, -- [8]
						"673", -- [9]
						["id"] = 1303,
					},
					["246329"] = {
						"246329", -- [1]
						"Timer246329cd", -- [2]
						"~Shadow Blades", -- [3]
						10.9, -- [4]
						135855, -- [5]
						"cd", -- [6]
						246329, -- [7]
						3, -- [8]
						"1986", -- [9]
						["id"] = 2073,
					},
					["332683"] = {
						"332683", -- [1]
						"Timer332683cast", -- [2]
						"Shattering Blast ", -- [3]
						5, -- [4]
						1519262, -- [5]
						"cast", -- [6]
						332683, -- [7]
						2, -- [8]
						"2425", -- [9]
						["id"] = 2417,
					},
					["239153"] = {
						"239153", -- [1]
						"Timer239153cd", -- [2]
						"~Spontaneous Fragmentation", -- [3]
						10, -- [4]
						429590, -- [5]
						"cd", -- [6]
						239153, -- [7]
						5, -- [8]
						"1897", -- [9]
						["id"] = 2052,
					},
					["334266"] = {
						"334266", -- [1]
						"Timer334266nextcount	1", -- [2]
						"Beam (1)", -- [3]
						10.1, -- [4]
						342917, -- [5]
						"nextcount", -- [6]
						334266, -- [7]
						3, -- [8]
						"2428", -- [9]
						["id"] = 2383,
					},
					["324667"] = {
						"324667", -- [1]
						"Timer324667next", -- [2]
						"Slime Wave", -- [3]
						7, -- [4]
						132104, -- [5]
						"next", -- [6]
						324667, -- [7]
						5, -- [8]
						"2419", -- [9]
						["id"] = 2382,
					},
					["157168"] = {
						"157168", -- [1]
						"Timer157168target3	Sckug-Ner'zhul", -- [2]
						"Fixate: Sckug-Ner'zhul", -- [3]
						12, -- [4]
						841383, -- [5]
						"target", -- [6]
						157168, -- [7]
						3, -- [8]
						"1225", -- [9]
						["id"] = 1714,
					},
					["342863"] = {
						"342863", -- [1]
						"Timer342863cd", -- [2]
						"~Screech", -- [3]
						28, -- [4]
						136116, -- [5]
						"cd", -- [6]
						342863, -- [7]
						3, -- [8]
						"2393", -- [9]
						["id"] = 2398,
					},
					["238502"] = {
						"238502", -- [1]
						"Timer238502cdcount	1", -- [2]
						"~Focused Dreadflame (1)", -- [3]
						31.8, -- [4]
						236216, -- [5]
						"cdcount", -- [6]
						238502, -- [7]
						3, -- [8]
						"1898", -- [9]
						["id"] = 2051,
					},
					["232913"] = {
						"232913", -- [1]
						"Timer232913cd", -- [2]
						"~Befouling Ink", -- [3]
						11.6, -- [4]
						1500933, -- [5]
						"cd", -- [6]
						232913, -- [7]
						3, -- [8]
						"1861", -- [9]
						["id"] = 2037,
					},
					["321226"] = {
						"321226", -- [1]
						"Timer321226cd", -- [2]
						"~Land of the Dead", -- [3]
						8.6, -- [4]
						136179, -- [5]
						"cd", -- [6]
						321226, -- [7]
						1, -- [8]
						"2391", -- [9]
						["id"] = 2388,
					},
					["321873"] = {
						"321873", -- [1]
						"Timer321873cd", -- [2]
						"~Freeze Tag", -- [3]
						18.4, -- [4]
						1698698, -- [5]
						"cd", -- [6]
						321873, -- [7]
						3, -- [8]
						"2402", -- [9]
						["id"] = 2392,
					},
					["320655"] = {
						"320655", -- [1]
						"Timer320655cd", -- [2]
						"~Crunch", -- [3]
						5, -- [4]
						132358, -- [5]
						"cd", -- [6]
						320655, -- [7]
						5, -- [8]
						"2395", -- [9]
						["id"] = 2387,
					},
					["344496"] = {
						"344496", -- [1]
						"Timer344496cdcount3	1", -- [2]
						"~Eruption (1)", -- [3]
						29.4, -- [4]
						2101174, -- [5]
						"cdcount", -- [6]
						344496, -- [7]
						3, -- [8]
						"2425", -- [9]
						["id"] = 2417,
					},
					["251447"] = {
						"251447", -- [1]
						"Timer251447cd", -- [2]
						"~Corrupting Maw", -- [3]
						8.9, -- [4]
						136126, -- [5]
						"cd", -- [6]
						251447, -- [7]
						5, -- [8]
						"1987", -- [9]
						["id"] = 2074,
					},
					["32358"] = {
						"32358", -- [1]
						"Timer32358active", -- [2]
						"Dark Shell ends", -- [3]
						7, -- [4]
						136121, -- [5]
						"active", -- [6]
						32358, -- [7]
						5, -- [8]
						"534", -- [9]
						["id"] = 1900,
					},
					["247376"] = {
						"247376", -- [1]
						"Timer247376cd", -- [2]
						"~Pulse Grenade", -- [3]
						12.5, -- [4]
						133009, -- [5]
						"cd", -- [6]
						247376, -- [7]
						3, -- [8]
						"2009", -- [9]
						["id"] = 2082,
					},
					["244722"] = {
						"244722", -- [1]
						"Timer244722cd", -- [2]
						"~Shock Grenade", -- [3]
						15, -- [4]
						133009, -- [5]
						"cd", -- [6]
						244722, -- [7]
						3, -- [8]
						"1997", -- [9]
						["id"] = 2070,
					},
					["319654"] = {
						"319654", -- [1]
						"Timer319654cd", -- [2]
						"~Hungering Drain", -- [3]
						10.7, -- [4]
						571321, -- [5]
						"cd", -- [6]
						319654, -- [7]
						4, -- [8]
						"2388", -- [9]
						["id"] = 2360,
					},
					["247923"] = {
						"247923", -- [1]
						"Timer247923cdcount	1", -- [2]
						"~Shrapnel Blast (1)", -- [3]
						12, -- [4]
						133710, -- [5]
						"cdcount", -- [6]
						247923, -- [7]
						3, -- [8]
						"2009", -- [9]
						["id"] = 2082,
					},
					["320141"] = {
						"320141", -- [1]
						"Timer320141next", -- [2]
						"Doom!!!", -- [3]
						45.5, -- [4]
						136129, -- [5]
						"next", -- [6]
						320141, -- [7]
						2, -- [8]
						"2409", -- [9]
						["id"] = 2394,
					},
					["323143"] = {
						"323143", -- [1]
						"Timer323143cd", -- [2]
						"~Telekinetic Toss", -- [3]
						6, -- [4]
						135822, -- [5]
						"cd", -- [6]
						323143, -- [7]
						3, -- [8]
						"2413", -- [9]
						["id"] = 2381,
					},
					["254452"] = {
						"254452", -- [1]
						"Timer254452cd", -- [2]
						"~Ravenous Blaze", -- [3]
						4, -- [4]
						525024, -- [5]
						"cd", -- [6]
						254452, -- [7]
						3, -- [8]
						"1984", -- [9]
						["id"] = 2063,
					},
					["244131"] = {
						"244131", -- [1]
						"Timer244131cd", -- [2]
						"~Consuming Sphere", -- [3]
						48.3, -- [4]
						237016, -- [5]
						"cd", -- [6]
						244131, -- [7]
						3, -- [8]
						"1987", -- [9]
						["id"] = 2074,
					},
					["239739"] = {
						"239739", -- [1]
						"Timer239739nextcount	1", -- [2]
						"Dark Mark (1)", -- [3]
						31.6, -- [4]
						633004, -- [5]
						"nextcount", -- [6]
						239739, -- [7]
						3, -- [8]
						"1873", -- [9]
						["id"] = 2038,
					},
					["334404"] = {
						"334404", -- [1]
						"Timer334404cd", -- [2]
						"~Spreadshot", -- [3]
						6, -- [4]
						132208, -- [5]
						"cd", -- [6]
						334404, -- [7]
						2, -- [8]
						"2429", -- [9]
						["id"] = 2418,
					},
					["243999"] = {
						"243999", -- [1]
						"Timer243999cd", -- [2]
						"~Dark Fissure", -- [3]
						17.4, -- [4]
						136201, -- [5]
						"cd", -- [6]
						243999, -- [7]
						3, -- [8]
						"1983", -- [9]
						["id"] = 2069,
					},
					["331209"] = {
						"331209", -- [1]
						"Timer331209cdcount	1", -- [2]
						"~Hateful Gaze (1)", -- [3]
						50.1, -- [4]
						136215, -- [5]
						"cdcount", -- [6]
						331209, -- [7]
						3, -- [8]
						"2394", -- [9]
						["id"] = 2399,
					},
					["323845"] = {
						"323845", -- [1]
						"Timer323845cd", -- [2]
						"~Wicked Rush", -- [3]
						5.7, -- [4]
						589068, -- [5]
						"cd", -- [6]
						323845, -- [7]
						3, -- [8]
						"2407", -- [9]
						["id"] = 2363,
					},
					["244093"] = {
						"244093", -- [1]
						"Timer244093next", -- [2]
						"Necrotic Embrace", -- [3]
						35, -- [4]
						1029009, -- [5]
						"next", -- [6]
						244093, -- [7]
						3, -- [8]
						"1983", -- [9]
						["id"] = 2069,
					},
					["234621"] = {
						"234621", -- [1]
						"Timer234621cdcount	1", -- [2]
						"~Devouring Maw (1)", -- [3]
						40, -- [4]
						463487, -- [5]
						"cdcount", -- [6]
						234621, -- [7]
						3, -- [8]
						"1861", -- [9]
						["id"] = 2037,
					},
					["325725"] = {
						"325725", -- [1]
						"Timer325725cdcount	1", -- [2]
						"~Cosmic Artifice (1)", -- [3]
						3.7, -- [4]
						1033912, -- [5]
						"cdcount", -- [6]
						325725, -- [7]
						3, -- [8]
						"2410", -- [9]
						["id"] = 2396,
					},
					["322746"] = {
						"322746", -- [1]
						"Timer322746cd", -- [2]
						"~Corrupted Blood", -- [3]
						8.5, -- [4]
						136133, -- [5]
						"cd", -- [6]
						322746, -- [7]
						3, -- [8]
						"2408", -- [9]
						["id"] = 2395,
					},
					["324205"] = {
						"324205", -- [1]
						"Timer324205cd", -- [2]
						"~Blinding Flash", -- [3]
						15.7, -- [4]
						1029583, -- [5]
						"cd", -- [6]
						324205, -- [7]
						3, -- [8]
						"2416", -- [9]
						["id"] = 2356,
					},
					["240396"] = {
						"240396", -- [1]
						"Timer240396nextcount	1", -- [2]
						"Rain of the Destroyer (1)", -- [3]
						15, -- [4]
						135803, -- [5]
						"nextcount", -- [6]
						240396, -- [7]
						3, -- [8]
						"1873", -- [9]
						["id"] = 2038,
					},
					["107047"] = {
						"107047", -- [1]
						"Timer107047cd", -- [2]
						"~Impaling Strike", -- [3]
						25.5, -- [4]
						132105, -- [5]
						"cd", -- [6]
						107047, -- [7]
						0, -- [8]
						"675", -- [9]
						["id"] = 1405,
					},
					["32361"] = {
						"32361", -- [1]
						"Timer32361target	Shadowfiend", -- [2]
						"Crystal Prison: Shadowfiend", -- [3]
						5, -- [4]
						135988, -- [5]
						"target", -- [6]
						32361, -- [7]
						3, -- [8]
						"535", -- [9]
						["id"] = 1901,
					},
					["232827"] = {
						"232827", -- [1]
						"Timer232827cdcount	1", -- [2]
						"~Crashing Wave (1)", -- [3]
						30, -- [4]
						135861, -- [5]
						"cdcount", -- [6]
						232827, -- [7]
						3, -- [8]
						"1861", -- [9]
						["id"] = 2037,
					},
					["335354"] = {
						"335354", -- [1]
						"Timer335354cdcount	1", -- [2]
						"~Chain Slam (1)", -- [3]
						28.3, -- [4]
						132507, -- [5]
						"cdcount", -- [6]
						335354, -- [7]
						3, -- [8]
						"2394", -- [9]
						["id"] = 2399,
					},
					["313606"] = {
						"313606", -- [1]
						"Timer313606cd", -- [2]
						"~Flight", -- [3]
						30.5, -- [4]
						135737, -- [5]
						"cd", -- [6]
						313606, -- [7]
						6, -- [8]
						"2399", -- [9]
						["id"] = 2357,
					},
					["ej5973"] = {
						"ej5973", -- [1]
						"Timerej5973cd", -- [2]
						"~Circle of Flame", -- [3]
						8, -- [4]
						236216, -- [5]
						"cd", -- [6]
						"ej5973", -- [7]
						3, -- [8]
						"698", -- [9]
						["id"] = 1441,
					},
					["106877"] = {
						"106877", -- [1]
						"Timer106877next", -- [2]
						"Sha Spike", -- [3]
						9, -- [4]
						628268, -- [5]
						"next", -- [6]
						106877, -- [7]
						0, -- [8]
						"685", -- [9]
						["id"] = 1305,
					},
					["323730"] = {
						"323730", -- [1]
						"Timer323730cd", -- [2]
						"~Frozen Binds", -- [3]
						8.9, -- [4]
						135834, -- [5]
						"cd", -- [6]
						323730, -- [7]
						3, -- [8]
						"2396", -- [9]
						["id"] = 2390,
					},
					["244152"] = {
						"244152", -- [1]
						"Timer244152cast", -- [2]
						"Apocalypse Drive ", -- [3]
						30, -- [4]
						1122135, -- [5]
						"cast", -- [6]
						244152, -- [7]
						6, -- [8]
						"1992", -- [9]
						["id"] = 2076,
					},
					["153954"] = {
						"153954", -- [1]
						"Timer153954cd", -- [2]
						"~Cast Down", -- [3]
						15, -- [4]
						1029578, -- [5]
						"cd", -- [6]
						153954, -- [7]
						1, -- [8]
						"968", -- [9]
						["id"] = 1701,
					},
					["332794"] = {
						"332794", -- [1]
						"Timer332794cdcount	1", -- [2]
						"~Fatal Finesse (1)", -- [3]
						17.4, -- [4]
						1357795, -- [5]
						"cdcount", -- [6]
						332794, -- [7]
						3, -- [8]
						"2424", -- [9]
						["id"] = 2407,
					},
					["106923"] = {
						"106923", -- [1]
						"Timer106923next", -- [2]
						"Static Field", -- [3]
						18, -- [4]
						136050, -- [5]
						"next", -- [6]
						106923, -- [7]
						3, -- [8]
						"673", -- [9]
						["id"] = 1303,
					},
					["236712"] = {
						"236712", -- [1]
						"Timer236712cd", -- [2]
						"~Lunar Beacon", -- [3]
						18, -- [4]
						429383, -- [5]
						"cd", -- [6]
						236712, -- [7]
						3, -- [8]
						"1903", -- [9]
						["id"] = 2050,
					},
					["319592"] = {
						"319592", -- [1]
						"Timer319592cd", -- [2]
						"~Stone Shattering Leap", -- [3]
						20.6, -- [4]
						1016245, -- [5]
						"cd", -- [6]
						319592, -- [7]
						3, -- [8]
						"2387", -- [9]
						["id"] = 2380,
					},
					["336258"] = {
						"336258", -- [1]
						"Timer336258fades", -- [2]
						"Solitary Prey fades", -- [3]
						6, -- [4]
						892448, -- [5]
						"fades", -- [6]
						336258, -- [7]
						5, -- [8]
						"2423", -- [9]
						["id"] = 2385,
					},
					["326851"] = {
						"326851", -- [1]
						"Timer326851cdcount	1", -- [2]
						"~Blood Price (1)", -- [3]
						22.3, -- [4]
						1035055, -- [5]
						"cdcount", -- [6]
						326851, -- [7]
						2, -- [8]
						"2424", -- [9]
						["id"] = 2407,
					},
					["155327"] = {
						"155327", -- [1]
						"Timer155327cd", -- [2]
						"~Soul Vessel", -- [3]
						20, -- [4]
						136213, -- [5]
						"cd", -- [6]
						155327, -- [7]
						6, -- [8]
						"1186", -- [9]
						["id"] = 1685,
					},
					["ej21993"] = {
						"ej21993", -- [1]
						"Timerej21993cdcount	1", -- [2]
						"~Bleakwing Assassin (1)", -- [3]
						70, -- [4]
						3565724, -- [5]
						"cdcount", -- [6]
						"ej21993", -- [7]
						1, -- [8]
						"2422", -- [9]
						["id"] = 2402,
					},
					["329951"] = {
						"329951", -- [1]
						"Timer329951nextcount	1", -- [2]
						"Impale (1)", -- [3]
						27.5, -- [4]
						1357795, -- [5]
						"nextcount", -- [6]
						329951, -- [7]
						3, -- [8]
						"2424", -- [9]
						["id"] = 2407,
					},
					["244000"] = {
						"244000", -- [1]
						"Timer244000cd", -- [2]
						"~Felstorm Barrage", -- [3]
						25.2, -- [4]
						1122135, -- [5]
						"cd", -- [6]
						244000, -- [7]
						3, -- [8]
						"1985", -- [9]
						["id"] = 2064,
					},
					["241564"] = {
						"241564", -- [1]
						"Timer241564cd", -- [2]
						"~Sorrowful Wail", -- [3]
						15.2, -- [4]
						460857, -- [5]
						"cd", -- [6]
						241564, -- [7]
						2, -- [8]
						"1898", -- [9]
						["id"] = 2051,
					},
					["230139"] = {
						"230139", -- [1]
						"Timer230139cdcount	1", -- [2]
						"~Hydra Shot (1)", -- [3]
						25.2, -- [4]
						133578, -- [5]
						"cdcount", -- [6]
						230139, -- [7]
						3, -- [8]
						"1861", -- [9]
						["id"] = 2037,
					},
					["233272"] = {
						"233272", -- [1]
						"Timer233272nextcount	1", -- [2]
						"Shattering Star (1)", -- [3]
						34, -- [4]
						517112, -- [5]
						"nextcount", -- [6]
						233272, -- [7]
						3, -- [8]
						"1862", -- [9]
						["id"] = 2032,
					},
					["322614"] = {
						"322614", -- [1]
						"Timer322614cd", -- [2]
						"~Mind Link", -- [3]
						18.1, -- [4]
						3528276, -- [5]
						"cd", -- [6]
						322614, -- [7]
						3, -- [8]
						"2405", -- [9]
						["id"] = 2393,
					},
					["250333"] = {
						"250333", -- [1]
						"Timer250333cast", -- [2]
						"Torment of Khaz'goroth ", -- [3]
						85, -- [4]
						615339, -- [5]
						"cast", -- [6]
						250333, -- [7]
						6, -- [8]
						"1986", -- [9]
						["id"] = 2073,
					},
					["168375"] = {
						"168375", -- [1]
						"Timer168375next", -- [2]
						"Grasping Vine", -- [3]
						30.4, -- [4]
						959842, -- [5]
						"next", -- [6]
						168375, -- [7]
						3, -- [8]
						"1207", -- [9]
						["id"] = 1757,
					},
					["150755"] = {
						"150755", -- [1]
						"Timer150755cd", -- [2]
						"~Summon Unstable Slag", -- [3]
						20, -- [4]
						135790, -- [5]
						"cd", -- [6]
						150755, -- [7]
						1, -- [8]
						"889", -- [9]
						["id"] = 1654,
					},
					["119981"] = {
						"119981", -- [1]
						"Timer119981cd", -- [2]
						"~Whirling Dervish", -- [3]
						22, -- [4]
						132845, -- [5]
						"cd", -- [6]
						119981, -- [7]
						0, -- [8]
						"708", -- [9]
						["id"] = 1442,
					},
					["333231"] = {
						"333231", -- [1]
						"Timer333231cd", -- [2]
						"~Searing Death", -- [3]
						10.2, -- [4]
						2576089, -- [5]
						"cd", -- [6]
						333231, -- [7]
						3, -- [8]
						"2397", -- [9]
						["id"] = 2391,
					},
					["342280"] = {
						"342280", -- [1]
						"Timer342280cd", -- [2]
						"~Bottled Anima", -- [3]
						19.4, -- [4]
						3684825, -- [5]
						"cd", -- [6]
						342280, -- [7]
						3, -- [8]
						"2420", -- [9]
						["id"] = 2406,
					},
					["244768"] = {
						"244768", -- [1]
						"Timer244768cd", -- [2]
						"~Desolate Gaze", -- [3]
						78, -- [4]
						236301, -- [5]
						"cd", -- [6]
						244768, -- [7]
						3, -- [8]
						"1987", -- [9]
						["id"] = 2074,
					},
					["328921"] = {
						"328921", -- [1]
						"Timer328921cd", -- [2]
						"~Blood Shroud", -- [3]
						112, -- [4]
						538040, -- [5]
						"cd", -- [6]
						328921, -- [7]
						6, -- [8]
						"2393", -- [9]
						["id"] = 2398,
					},
					["153002"] = {
						"153002", -- [1]
						"Timer153002next", -- [2]
						"Holy Shield", -- [3]
						30, -- [4]
						135874, -- [5]
						"next", -- [6]
						153002, -- [7]
						3, -- [8]
						"1185", -- [9]
						["id"] = 1686,
					},
					["327608"] = {
						"327608", -- [1]
						"Timer327608cd", -- [2]
						"~Beckon Slime", -- [3]
						25, -- [4]
						3459153, -- [5]
						"cd", -- [6]
						327608, -- [7]
						1, -- [8]
						"2419", -- [9]
						["id"] = 2382,
					},
					["112944"] = {
						"112944", -- [1]
						"Timer112944next", -- [2]
						"Carrot Breath", -- [3]
						18, -- [4]
						134010, -- [5]
						"next", -- [6]
						112944, -- [7]
						0, -- [8]
						"669", -- [9]
						["id"] = 1413,
					},
					["253520"] = {
						"253520", -- [1]
						"Timer253520next", -- [2]
						"Fulminating Pulse", -- [3]
						20.3, -- [4]
						514018, -- [5]
						"next", -- [6]
						253520, -- [7]
						3, -- [8]
						"1986", -- [9]
						["id"] = 2073,
					},
					["235267"] = {
						"235267", -- [1]
						"Timer235267nextcount	2", -- [2]
						"Mass Instability (2)", -- [3]
						22, -- [4]
						535593, -- [5]
						"nextcount", -- [6]
						235267, -- [7]
						3, -- [8]
						"1897", -- [9]
						["id"] = 2052,
					},
					["118961"] = {
						"118961", -- [1]
						"Timer118961target	Uwont-Sargeras", -- [2]
						"Chase Down: Uwont-Sargeras", -- [3]
						11, -- [4]
						461121, -- [5]
						"target", -- [6]
						118961, -- [7]
						0, -- [8]
						"657", -- [9]
						["id"] = 1304,
					},
					["321948"] = {
						"321948", -- [1]
						"Timer321948cd", -- [2]
						"~Localized Explosion", -- [3]
						14.3, -- [4]
						236214, -- [5]
						"cd", -- [6]
						321948, -- [7]
						3, -- [8]
						"2398", -- [9]
						["id"] = 2400,
					},
					["236544"] = {
						"236544", -- [1]
						"Timer236544cd", -- [2]
						"~Doomed Sundering", -- [3]
						18, -- [4]
						1033912, -- [5]
						"cd", -- [6]
						236544, -- [7]
						5, -- [8]
						"1896", -- [9]
						["id"] = 2054,
					},
					["235230"] = {
						"235230", -- [1]
						"Timer235230cdcount	1", -- [2]
						"~Fel Squall (1)", -- [3]
						35, -- [4]
						841219, -- [5]
						"cdcount", -- [6]
						235230, -- [7]
						2, -- [8]
						"1867", -- [9]
						["id"] = 2048,
					},
					["ej12489"] = {
						"ej12489", -- [1]
						"Timerej12489next", -- [2]
						"Dread Felbat", -- [3]
						20, -- [4]
						132182, -- [5]
						"next", -- [6]
						"ej12489", -- [7]
						1, -- [8]
						"1499", -- [9]
						["id"] = 1828,
					},
					["327664"] = {
						"327664", -- [1]
						"Timer327664cd", -- [2]
						"~Embalming Ichor", -- [3]
						9.7, -- [4]
						1001622, -- [5]
						"cd", -- [6]
						327664, -- [7]
						3, -- [8]
						"2392", -- [9]
						["id"] = 2389,
					},
					["341621"] = {
						"341621", -- [1]
						"Timer341621cd", -- [2]
						"~Expose Desires", -- [3]
						12.1, -- [4]
						3684826, -- [5]
						"cd", -- [6]
						341621, -- [7]
						5, -- [8]
						"2420", -- [9]
						["id"] = 2406,
					},
					["232192"] = {
						"232192", -- [1]
						"Timer232192next", -- [2]
						"Commanding Roar", -- [3]
						17.3, -- [4]
						642418, -- [5]
						"next", -- [6]
						232192, -- [7]
						1, -- [8]
						"1856", -- [9]
						["id"] = 2036,
					},
					["320823"] = {
						"320823", -- [1]
						"Timer320823cd", -- [2]
						"~Experimental Squirrel Bomb", -- [3]
						7.9, -- [4]
						133709, -- [5]
						"cd", -- [6]
						320823, -- [7]
						5, -- [8]
						"2409", -- [9]
						["id"] = 2394,
					},
					["197810"] = {
						"197810", -- [1]
						"Timer197810cd", -- [2]
						"~Wicked Slam", -- [3]
						35.8, -- [4]
						1109118, -- [5]
						"cd", -- [6]
						197810, -- [7]
						2, -- [8]
						"1499", -- [9]
						["id"] = 1828,
					},
					["332313"] = {
						"332313", -- [1]
						"Timer332313cd", -- [2]
						"~Brood Assassins", -- [3]
						15.2, -- [4]
						1370997, -- [5]
						"cd", -- [6]
						332313, -- [7]
						1, -- [8]
						"2423", -- [9]
						["id"] = 2385,
					},
					["325506"] = {
						"325506", -- [1]
						"Timer325506cdcount	1	Creature-0-4230-2296-5369-165764-00001A273B", -- [2]
						"~Concussive Smash (1)", -- [3]
						24.1, -- [4]
						1016245, -- [5]
						"cdcount", -- [6]
						325506, -- [7]
						5, -- [8]
						"2422", -- [9]
						["id"] = 2402,
					},
					["239207"] = {
						"239207", -- [1]
						"Timer239207cdcount	1", -- [2]
						"~Touch of Sargeras (1)", -- [3]
						14.5, -- [4]
						840404, -- [5]
						"cdcount", -- [6]
						239207, -- [7]
						3, -- [8]
						"1873", -- [9]
						["id"] = 2038,
					},
					["329217"] = {
						"329217", -- [1]
						"Timer329217cd", -- [2]
						"~Slime Lunge", -- [3]
						33.2, -- [4]
						451165, -- [5]
						"cd", -- [6]
						329217, -- [7]
						3, -- [8]
						"2403", -- [9]
						["id"] = 2384,
					},
					["327616"] = {
						"327616", -- [1]
						"Timer327616cd", -- [2]
						"~Waltz of Blood", -- [3]
						30.7, -- [4]
						133886, -- [5]
						"cd", -- [6]
						327616, -- [7]
						3, -- [8]
						"2426", -- [9]
						["id"] = 2412,
					},
					["330042"] = {
						"330042", -- [1]
						"Timer330042cdcount	1", -- [2]
						"~Massacre (1)", -- [3]
						64.9, -- [4]
						136129, -- [5]
						"cdcount", -- [6]
						330042, -- [7]
						3, -- [8]
						"2424", -- [9]
						["id"] = 2407,
					},
					["244056"] = {
						"244056", -- [1]
						"Timer244056cd", -- [2]
						"~Siphon Corruption", -- [3]
						25.5, -- [4]
						538560, -- [5]
						"cd", -- [6]
						244056, -- [7]
						3, -- [8]
						"1987", -- [9]
						["id"] = 2074,
					},
					["320772"] = {
						"320772", -- [1]
						"Timer320772cd", -- [2]
						"~Comet Storm", -- [3]
						16.5, -- [4]
						1033907, -- [5]
						"cd", -- [6]
						320772, -- [7]
						3, -- [8]
						"2396", -- [9]
						["id"] = 2390,
					},
					["248317"] = {
						"248317", -- [1]
						"Timer248317cdcount	1", -- [2]
						"~Soulblight Orb (1)", -- [3]
						35.2, -- [4]
						1778225, -- [5]
						"cdcount", -- [6]
						248317, -- [7]
						3, -- [8]
						"2031", -- [9]
						["id"] = 2092,
					},
					["236442"] = {
						"236442", -- [1]
						"Timer236442cd", -- [2]
						"~Twilight Volley", -- [3]
						15.5, -- [4]
						1391677, -- [5]
						"cd", -- [6]
						236442, -- [7]
						2, -- [8]
						"1903", -- [9]
						["id"] = 2050,
					},
					["332572"] = {
						"332572", -- [1]
						"Timer332572cdcount	1", -- [2]
						"~Falling Rubble (1)", -- [3]
						12.5, -- [4]
						1385913, -- [5]
						"cdcount", -- [6]
						332572, -- [7]
						3, -- [8]
						"2394", -- [9]
						["id"] = 2399,
					},
					["325360"] = {
						"325360", -- [1]
						"Timer325360nextcount	1", -- [2]
						"Rite of Supremacy (1)", -- [3]
						11, -- [4]
						3528311, -- [5]
						"nextcount", -- [6]
						325360, -- [7]
						2, -- [8]
						"2421", -- [9]
						["id"] = 2362,
					},
					["325399"] = {
						"325399", -- [1]
						"Timer325399cd", -- [2]
						"~Hyperlight Spark", -- [3]
						5, -- [4]
						132317, -- [5]
						"cd", -- [6]
						325399, -- [7]
						2, -- [8]
						"2418", -- [9]
						["id"] = 2405,
					},
					["254926"] = {
						"254926", -- [1]
						"Timer254926cdcount	1", -- [2]
						"~Reverberating Strike (1)", -- [3]
						14.2, -- [4]
						135814, -- [5]
						"cdcount", -- [6]
						254926, -- [7]
						3, -- [8]
						"2004", -- [9]
						["id"] = 2088,
					},
					["334498"] = {
						"334498", -- [1]
						"Timer334498cdcount	1", -- [2]
						"~Seismic Upheaval (1)", -- [3]
						50.2, -- [4]
						136025, -- [5]
						"cdcount", -- [6]
						334498, -- [7]
						3, -- [8]
						"2425", -- [9]
						["id"] = 2417,
					},
					["246504"] = {
						"246504", -- [1]
						"Timer246504cast", -- [2]
						"Initializing ", -- [3]
						32.3, -- [4]
						986486, -- [5]
						"cast", -- [6]
						246504, -- [7]
						6, -- [8]
						"2004", -- [9]
						["id"] = 2088,
					},
					["ej21952"] = {
						"ej21952", -- [1]
						"Timerej21952cdcount	1", -- [2]
						"~Vile Occultist (1)", -- [3]
						70, -- [4]
						538040, -- [5]
						"cdcount", -- [6]
						"ej21952", -- [7]
						1, -- [8]
						"2422", -- [9]
						["id"] = 2402,
					},
					["334522"] = {
						"334522", -- [1]
						"Timer334522nextcount	1", -- [2]
						"Consume (1)", -- [3]
						89, -- [4]
						1778226, -- [5]
						"nextcount", -- [6]
						334522, -- [7]
						2, -- [8]
						"2428", -- [9]
						["id"] = 2383,
					},
					["233264"] = {
						"233264", -- [1]
						"Timer233264nextcount	1", -- [2]
						"Embrace of the Eclipse (1)", -- [3]
						48, -- [4]
						236152, -- [5]
						"nextcount", -- [6]
						233264, -- [7]
						5, -- [8]
						"1903", -- [9]
						["id"] = 2050,
					},
					["111723"] = {
						"111723", -- [1]
						"Timer111723next", -- [2]
						"Fixate", -- [3]
						5.5, -- [4]
						136088, -- [5]
						"next", -- [6]
						111723, -- [7]
						3, -- [8]
						"649", -- [9]
						["id"] = 1419,
					},
					["248165"] = {
						"248165", -- [1]
						"Timer248165cdcount	1", -- [2]
						"~Cone of Death (1)", -- [3]
						30.3, -- [4]
						348565, -- [5]
						"cdcount", -- [6]
						248165, -- [7]
						3, -- [8]
						"2031", -- [9]
						["id"] = 2092,
					},
					["236305"] = {
						"236305", -- [1]
						"Timer236305nextcount	1", -- [2]
						"Incorporeal Shot (1)", -- [3]
						48, -- [4]
						959793, -- [5]
						"nextcount", -- [6]
						236305, -- [7]
						3, -- [8]
						"1903", -- [9]
						["id"] = 2050,
					},
					["319589"] = {
						"319589", -- [1]
						"Timer319589cd", -- [2]
						"~Grasping Hands", -- [3]
						8.2, -- [4]
						2576086, -- [5]
						"cd", -- [6]
						319589, -- [7]
						3, -- [8]
						"2389", -- [9]
						["id"] = 2364,
					},
					["321754"] = {
						"321754", -- [1]
						"Timer321754cd", -- [2]
						"~Icebound Aegis", -- [3]
						11.7, -- [4]
						236224, -- [5]
						"cd", -- [6]
						321754, -- [7]
						5, -- [8]
						"2396", -- [9]
						["id"] = 2390,
					},
					["236542"] = {
						"236542", -- [1]
						"Timer236542cd", -- [2]
						"~Sundering Doom", -- [3]
						7, -- [4]
						1120185, -- [5]
						"cd", -- [6]
						236542, -- [7]
						5, -- [8]
						"1896", -- [9]
						["id"] = 2054,
					},
					["244693"] = {
						"244693", -- [1]
						"Timer244693cd", -- [2]
						"~Wake of Flame", -- [3]
						10.7, -- [4]
						524795, -- [5]
						"cd", -- [6]
						244693, -- [7]
						3, -- [8]
						"1984", -- [9]
						["id"] = 2063,
					},
					["327796"] = {
						"327796", -- [1]
						"Timer327796nextcount	1", -- [2]
						"Night Hunter (1)", -- [3]
						12.1, -- [4]
						1357795, -- [5]
						"nextcount", -- [6]
						327796, -- [7]
						3, -- [8]
						"2424", -- [9]
						["id"] = 2407,
					},
					["246840"] = {
						"246840", -- [1]
						"Timer246840cdcount	1", -- [2]
						"~Ruiner (1)", -- [3]
						21.1, -- [4]
						135798, -- [5]
						"cdcount", -- [6]
						246840, -- [7]
						3, -- [8]
						"2004", -- [9]
						["id"] = 2088,
					},
					["106933"] = {
						"106933", -- [1]
						"Timer106933next", -- [2]
						"Prey Time", -- [3]
						14.5, -- [4]
						132278, -- [5]
						"next", -- [6]
						106933, -- [7]
						3, -- [8]
						"675", -- [9]
						["id"] = 1405,
					},
					["235924"] = {
						"235924", -- [1]
						"Timer235924cdcount	1", -- [2]
						"~Spear of Anguish (1)", -- [3]
						20.7, -- [4]
						135131, -- [5]
						"cdcount", -- [6]
						235924, -- [7]
						3, -- [8]
						"1896", -- [9]
						["id"] = 2054,
					},
					["343273"] = {
						"343273", -- [1]
						"Timer343273cdcount	2	Vehicle-0-3778-2296-1244-172858-000014C362", -- [2]
						"~Ravenous Feast (2)", -- [3]
						18.2, -- [4]
						132127, -- [5]
						"cdcount", -- [6]
						343273, -- [7]
						3, -- [8]
						"2425", -- [9]
						["id"] = 2417,
					},
					["329110"] = {
						"329110", -- [1]
						"Timer329110cd", -- [2]
						"~Slime Injection", -- [3]
						10.9, -- [4]
						3459797, -- [5]
						"cd", -- [6]
						329110, -- [7]
						5, -- [8]
						"2403", -- [9]
						["id"] = 2384,
					},
					["327039"] = {
						"327039", -- [1]
						"Timer327039cdcount	1", -- [2]
						"~Feeding Time (1)", -- [3]
						20, -- [4]
						1357795, -- [5]
						"cdcount", -- [6]
						327039, -- [7]
						3, -- [8]
						"2424", -- [9]
						["id"] = 2407,
					},
					["106851"] = {
						"106851", -- [1]
						"Timer106851next", -- [2]
						"Blackout Brew", -- [3]
						10.5, -- [4]
						136090, -- [5]
						"next", -- [6]
						106851, -- [7]
						3, -- [8]
						"670", -- [9]
						["id"] = 1414,
					},
					["232061"] = {
						"232061", -- [1]
						"Timer232061next", -- [2]
						"Draw In", -- [3]
						58, -- [4]
						893777, -- [5]
						"next", -- [6]
						232061, -- [7]
						6, -- [8]
						"1856", -- [9]
						["id"] = 2036,
					},
					["326039"] = {
						"326039", -- [1]
						"Timer326039next", -- [2]
						"Endless Torment", -- [3]
						24.2, -- [4]
						1394887, -- [5]
						"next", -- [6]
						326039, -- [7]
						2, -- [8]
						"2421", -- [9]
						["id"] = 2362,
					},
					["323177"] = {
						"323177", -- [1]
						"Timer323177cd", -- [2]
						"~Tears of the Forest", -- [3]
						13.5, -- [4]
						463570, -- [5]
						"cd", -- [6]
						323177, -- [7]
						3, -- [8]
						"2400", -- [9]
						["id"] = 2397,
					},
					["342321"] = {
						"342321", -- [1]
						"Timer342321cd2", -- [2]
						"~Concentrated Anima", -- [3]
						54.7, -- [4]
						3684827, -- [5]
						"cd", -- [6]
						342321, -- [7]
						1, -- [8]
						"2420", -- [9]
						["id"] = 2406,
					},
					["154175"] = {
						"154175", -- [1]
						"Timer154175cdsource	Unknown	Unknown", -- [2]
						"~Body Slam: Boss", -- [3]
						15, -- [4]
						237580, -- [5]
						"cdsource", -- [6]
						154175, -- [7]
						3, -- [8]
						"1140", -- [9]
						["id"] = 1679,
					},
					["329107"] = {
						"329107", -- [1]
						"Timer329107cast", -- [2]
						"Extinction ", -- [3]
						16, -- [4]
						3636841, -- [5]
						"cast", -- [6]
						329107, -- [7]
						2, -- [8]
						"2418", -- [9]
						["id"] = 2405,
					},
					["322550"] = {
						"322550", -- [1]
						"Timer322550cd", -- [2]
						"~Accelerated Incubation", -- [3]
						45.2, -- [4]
						2141733, -- [5]
						"cd", -- [6]
						322550, -- [7]
						1, -- [8]
						"2405", -- [9]
						["id"] = 2393,
					},
					["241635"] = {
						"241635", -- [1]
						"Timer241635nextcount	3", -- [2]
						"Hammer of Creation (3)", -- [3]
						12, -- [4]
						135875, -- [5]
						"nextcount", -- [6]
						241635, -- [7]
						5, -- [8]
						"1897", -- [9]
						["id"] = 2052,
					},
					["230358"] = {
						"230358", -- [1]
						"Timer230358cd", -- [2]
						"~Thundering Shock", -- [3]
						10, -- [4]
						839974, -- [5]
						"cd", -- [6]
						230358, -- [7]
						3, -- [8]
						"1861", -- [9]
						["id"] = 2037,
					},
					["115003"] = {
						"115003", -- [1]
						"Timer115003active", -- [2]
						"Carbonation ends", -- [3]
						23, -- [4]
						132792, -- [5]
						"active", -- [6]
						115003, -- [7]
						0, -- [8]
						"670", -- [9]
						["id"] = 1414,
					},
					["322711"] = {
						"322711", -- [1]
						"Timer322711cd", -- [2]
						"~Refracted Sinlight", -- [3]
						29.6, -- [4]
						537468, -- [5]
						"cd", -- [6]
						322711, -- [7]
						3, -- [8]
						"2406", -- [9]
						["id"] = 2401,
					},
					["164974"] = {
						"164974", -- [1]
						"Timer164974next", -- [2]
						"Dark Eclipse", -- [3]
						45.5, -- [4]
						236151, -- [5]
						"next", -- [6]
						164974, -- [7]
						6, -- [8]
						"1139", -- [9]
						["id"] = 1677,
					},
					["323685"] = {
						"323685", -- [1]
						"Timer323685cd", -- [2]
						"~Grasping Rift", -- [3]
						22.7, -- [4]
						2576095, -- [5]
						"cd", -- [6]
						323685, -- [7]
						3, -- [8]
						"2417", -- [9]
						["id"] = 2404,
					},
					["328789"] = {
						"328789", -- [1]
						"Timer328789cd", -- [2]
						"~Annihilation", -- [3]
						27, -- [4]
						2101973, -- [5]
						"cd", -- [6]
						328789, -- [7]
						2, -- [8]
						"2418", -- [9]
						["id"] = 2405,
					},
					["239379"] = {
						"239379", -- [1]
						"Timer239379nextcount", -- [2]
						"Glaive Storm (Unknown", -- [3]
						54, -- [4]
						648707, -- [5]
						"nextcount", -- [6]
						239379, -- [7]
						3, -- [8]
						"1903", -- [9]
						["id"] = 2050,
					},
					["107268"] = {
						"107268", -- [1]
						"Timer107268target	Themythlife-Frostmourne", -- [2]
						"Sabotage: Themythlife-Frostmourne", -- [3]
						5, -- [4]
						133713, -- [5]
						"target", -- [6]
						107268, -- [7]
						0, -- [8]
						"655", -- [9]
						["id"] = 1397,
					},
					["343005"] = {
						"343005", -- [1]
						"Timer343005cd", -- [2]
						"~Blind Swipe", -- [3]
						20.3, -- [4]
						366938, -- [5]
						"cd", -- [6]
						343005, -- [7]
						5, -- [8]
						"2393", -- [9]
						["id"] = 2398,
					},
					["257296"] = {
						"257296", -- [1]
						"Timer257296cdcount	1", -- [2]
						"~Tortured Rage (1)", -- [3]
						12, -- [4]
						136146, -- [5]
						"cdcount", -- [6]
						257296, -- [7]
						2, -- [8]
						"2031", -- [9]
						["id"] = 2092,
					},
					["106984"] = {
						"106984", -- [1]
						"Timer106984next", -- [2]
						"Invoke Lightning", -- [3]
						6, -- [4]
						136050, -- [5]
						"next", -- [6]
						106984, -- [7]
						0, -- [8]
						"673", -- [9]
						["id"] = 1303,
					},
					["323597"] = {
						"323597", -- [1]
						"Timer323597cd", -- [2]
						"~Spectral Procession", -- [3]
						15.5, -- [4]
						236548, -- [5]
						"cd", -- [6]
						323597, -- [7]
						1, -- [8]
						"2411", -- [9]
						["id"] = 2403,
					},
					["199811"] = {
						"199811", -- [1]
						"Timer199811next", -- [2]
						"Blink Strikes", -- [3]
						15, -- [4]
						1033906, -- [5]
						"next", -- [6]
						199811, -- [7]
						3, -- [8]
						"1500", -- [9]
						["id"] = 1826,
					},
					["322936"] = {
						"322936", -- [1]
						"Timer322936cd", -- [2]
						"~Crumbling Slam", -- [3]
						4, -- [4]
						134459, -- [5]
						"cd", -- [6]
						322936, -- [7]
						5, -- [8]
						"2406", -- [9]
						["id"] = 2401,
					},
					["241721"] = {
						"241721", -- [1]
						"Timer241721active", -- [2]
						"Illidan's Sightless Gaze ends", -- [3]
						20, -- [4]
						236415, -- [5]
						"active", -- [6]
						241721, -- [7]
						5, -- [8]
						"1898", -- [9]
						["id"] = 2051,
					},
					["323608"] = {
						"323608", -- [1]
						"Timer323608cd", -- [2]
						"~Dark Devastation", -- [3]
						15.7, -- [4]
						2576088, -- [5]
						"cd", -- [6]
						323608, -- [7]
						3, -- [8]
						"2417", -- [9]
						["id"] = 2404,
					},
					["102573"] = {
						"102573", -- [1]
						"Timer102573cd", -- [2]
						"~Lightning Breath", -- [3]
						6.8, -- [4]
						135781, -- [5]
						"cd", -- [6]
						102573, -- [7]
						5, -- [8]
						"673", -- [9]
						["id"] = 1303,
					},
					["115002"] = {
						"115002", -- [1]
						"Timer115002next", -- [2]
						"Summon Gripping Hatred", -- [3]
						45.5, -- [4]
						134335, -- [5]
						"next", -- [6]
						115002, -- [7]
						1, -- [8]
						"686", -- [9]
						["id"] = 1306,
					},
					["323236"] = {
						"323236", -- [1]
						"Timer323236cd", -- [2]
						"~Unleashed Suffering", -- [3]
						15.7, -- [4]
						1035037, -- [5]
						"cd", -- [6]
						323236, -- [7]
						3, -- [8]
						"2413", -- [9]
						["id"] = 2381,
					},
					["330711"] = {
						"330711", -- [1]
						"Timer330711cd", -- [2]
						"~Shriek", -- [3]
						48.3, -- [4]
						136147, -- [5]
						"cd", -- [6]
						330711, -- [7]
						2, -- [8]
						"2393", -- [9]
						["id"] = 2398,
					},
					["335013"] = {
						"335013", -- [1]
						"Timer335013cd", -- [2]
						"~Rift Blast", -- [3]
						20.3, -- [4]
						3528282, -- [5]
						"cd", -- [6]
						335013, -- [7]
						3, -- [8]
						"2418", -- [9]
						["id"] = 2405,
					},
					["322943"] = {
						"322943", -- [1]
						"Timer322943cd", -- [2]
						"~Heave Debris", -- [3]
						13.5, -- [4]
						1500971, -- [5]
						"cd", -- [6]
						322943, -- [7]
						3, -- [8]
						"2406", -- [9]
						["id"] = 2401,
					},
					["212030"] = {
						"212030", -- [1]
						"Timer212030cd", -- [2]
						"~Shadow Slash", -- [3]
						13, -- [4]
						607850, -- [5]
						"cd", -- [6]
						212030, -- [7]
						3, -- [8]
						"1499", -- [9]
						["id"] = 1828,
					},
					["330978"] = {
						"330978", -- [1]
						"Timer330978cd", -- [2]
						"~Dredger Servants", -- [3]
						13.5, -- [4]
						461806, -- [5]
						"cd", -- [6]
						330978, -- [7]
						1, -- [8]
						"2426", -- [9]
						["id"] = 2412,
					},
					["328857"] = {
						"328857", -- [1]
						"Timer328857cd", -- [2]
						"~Bite", -- [3]
						8.1, -- [4]
						132278, -- [5]
						"cd", -- [6]
						328857, -- [7]
						5, -- [8]
						"2393", -- [9]
						["id"] = 2398,
					},
					["322818"] = {
						"322818", -- [1]
						"Timer322818cd", -- [2]
						"~Lost Confidence", -- [3]
						24.6, -- [4]
						237555, -- [5]
						"cd", -- [6]
						322818, -- [7]
						3, -- [8]
						"2412", -- [9]
						["id"] = 2359,
					},
					["232722"] = {
						"232722", -- [1]
						"Timer232722cdcount	1", -- [2]
						"~Slicing Tornado (1)", -- [3]
						30, -- [4]
						999952, -- [5]
						"cdcount", -- [6]
						232722, -- [7]
						3, -- [8]
						"1861", -- [9]
						["id"] = 2037,
					},
					["119374"] = {
						"119374", -- [1]
						"Timer119374next", -- [2]
						"Whirlwind", -- [3]
						15, -- [4]
						132369, -- [5]
						"next", -- [6]
						119374, -- [7]
						3, -- [8]
						"698", -- [9]
						["id"] = 1441,
					},
					["323943"] = {
						"323943", -- [1]
						"Timer323943cd", -- [2]
						"~Run Through", -- [3]
						10, -- [4]
						132337, -- [5]
						"cd", -- [6]
						323943, -- [7]
						3, -- [8]
						"2412", -- [9]
						["id"] = 2359,
					},
					["233556"] = {
						"233556", -- [1]
						"Timer233556cast", -- [2]
						"Corrupted Matrix ", -- [3]
						8, -- [4]
						1097741, -- [5]
						"cast", -- [6]
						233556, -- [7]
						5, -- [8]
						"1873", -- [9]
						["id"] = 2038,
					},
					["236694"] = {
						"236694", -- [1]
						"Timer236694cd", -- [2]
						"~Call Moontalon", -- [3]
						8, -- [4]
						132150, -- [5]
						"cd", -- [6]
						236694, -- [7]
						1, -- [8]
						"1903", -- [9]
						["id"] = 2050,
					},
					["154159"] = {
						"154159", -- [1]
						"Timer154159next", -- [2]
						"Energize", -- [3]
						20, -- [4]
						1029582, -- [5]
						"next", -- [6]
						154159, -- [7]
						5, -- [8]
						"966", -- [9]
						["id"] = 1699,
					},
					["329725"] = {
						"329725", -- [1]
						"Timer329725nextcount	1", -- [2]
						"Expunge (1)", -- [3]
						33, -- [4]
						1778228, -- [5]
						"nextcount", -- [6]
						329725, -- [7]
						3, -- [8]
						"2428", -- [9]
						["id"] = 2383,
					},
					["320230"] = {
						"320230", -- [1]
						"Timer320230cd", -- [2]
						"~Explosion!", -- [3]
						31.6, -- [4]
						1360978, -- [5]
						"cd", -- [6]
						320230, -- [7]
						2, -- [8]
						"2398", -- [9]
						["id"] = 2400,
					},
					["346698"] = {
						"346698", -- [1]
						"Timer346698cd", -- [2]
						"~Summon Dutiful Attendant", -- [3]
						7.3, -- [4]
						3528307, -- [5]
						"cd", -- [6]
						346698, -- [7]
						5, -- [8]
						"2426", -- [9]
						["id"] = 2412,
					},
					["157039"] = {
						"157039", -- [1]
						"Timer157039cd", -- [2]
						"~Demonic Leap", -- [3]
						23, -- [4]
						132368, -- [5]
						"cd", -- [6]
						157039, -- [7]
						3, -- [8]
						"1225", -- [9]
						["id"] = 1714,
					},
					["233431"] = {
						"233431", -- [1]
						"Timer233431cd", -- [2]
						"~Calcified Quills", -- [3]
						8.5, -- [4]
						1029749, -- [5]
						"cd", -- [6]
						233431, -- [7]
						3, -- [8]
						"1867", -- [9]
						["id"] = 2048,
					},
					["251356"] = {
						"251356", -- [1]
						"Timer251356cast", -- [2]
						"Focusing Power ", -- [3]
						15, -- [4]
						1388064, -- [5]
						"cast", -- [6]
						251356, -- [7]
						6, -- [8]
						"1987", -- [9]
						["id"] = 2074,
					},
					["236596"] = {
						"236596", -- [1]
						"Timer236596cd", -- [2]
						"~Rapid Shot", -- [3]
						15.8, -- [4]
						1035040, -- [5]
						"cd", -- [6]
						236596, -- [7]
						3, -- [8]
						"1903", -- [9]
						["id"] = 2050,
					},
					["152979"] = {
						"152979", -- [1]
						"Timer152979next", -- [2]
						"Soul Shred", -- [3]
						37, -- [4]
						828455, -- [5]
						"next", -- [6]
						152979, -- [7]
						6, -- [8]
						"1168", -- [9]
						["id"] = 1688,
					},
					["169613"] = {
						"169613", -- [1]
						"Timer169613cast", -- [2]
						"Genesis ", -- [3]
						17, -- [4]
						132125, -- [5]
						"cast", -- [6]
						169613, -- [7]
						5, -- [8]
						"1210", -- [9]
						["id"] = 1756,
					},
					["334757"] = {
						"334757", -- [1]
						"Timer334757cd", -- [2]
						"~Shades of Bargast", -- [3]
						17.5, -- [4]
						1709932, -- [5]
						"cd", -- [6]
						334757, -- [7]
						1, -- [8]
						"2429", -- [9]
						["id"] = 2418,
					},
					["131521"] = {
						"131521", -- [1]
						"Timer131521active", -- [2]
						"Ring of Malice ends", -- [3]
						15, -- [4]
						136194, -- [5]
						"active", -- [6]
						131521, -- [7]
						0, -- [8]
						"686", -- [9]
						["id"] = 1306,
					},
					["236459"] = {
						"236459", -- [1]
						"Timer236459cdcount	1", -- [2]
						"~Soulbind (1)", -- [3]
						14.2, -- [4]
						607854, -- [5]
						"cdcount", -- [6]
						236459, -- [7]
						3, -- [8]
						"1896", -- [9]
						["id"] = 2054,
					},
					["334970"] = {
						"334970", -- [1]
						"Timer334970cast", -- [2]
						"Coalescing ", -- [3]
						25, -- [4]
						458969, -- [5]
						"cast", -- [6]
						334970, -- [7]
						6, -- [8]
						"2410", -- [9]
						["id"] = 2396,
					},
					["30739"] = {
						"30739", -- [1]
						"Timer30739cd", -- [2]
						"~Blade Dance", -- [3]
						72, -- [4]
						132350, -- [5]
						"cd", -- [6]
						30739, -- [7]
						2, -- [8]
						"569", -- [9]
						["id"] = 1938,
					},
					["322795"] = {
						"322795", -- [1]
						"Timer322795next", -- [2]
						"Meat Hooks", -- [3]
						5.8, -- [4]
						1373906, -- [5]
						"next", -- [6]
						322795, -- [7]
						1, -- [8]
						"2401", -- [9]
						["id"] = 2365,
					},
					["335300"] = {
						"335300", -- [1]
						"Timer335300cdcount	1", -- [2]
						"~Chain Link (1)", -- [3]
						4.7, -- [4]
						463560, -- [5]
						"cdcount", -- [6]
						335300, -- [7]
						3, -- [8]
						"2394", -- [9]
						["id"] = 2399,
					},
					["335114"] = {
						"335114", -- [1]
						"Timer335114cdcount	1", -- [2]
						"~Sinseeker (1)", -- [3]
						28.8, -- [4]
						236174, -- [5]
						"cdcount", -- [6]
						335114, -- [7]
						3, -- [8]
						"2429", -- [9]
						["id"] = 2418,
					},
					["235059"] = {
						"235059", -- [1]
						"Timer235059cdcount	1", -- [2]
						"~Rupturing Singularity (1)", -- [3]
						55.2, -- [4]
						1041232, -- [5]
						"cdcount", -- [6]
						235059, -- [7]
						3, -- [8]
						"1898", -- [9]
						["id"] = 2051,
					},
					["234295"] = {
						"234295", -- [1]
						"Timer234295cast", -- [2]
						"Armageddon Rain ", -- [3]
						9, -- [4]
						136186, -- [5]
						"cast", -- [6]
						234295, -- [7]
						2, -- [8]
						"1898", -- [9]
						["id"] = 2051,
					},
					["328117"] = {
						"328117", -- [1]
						"Timer328117stage", -- [2]
						"Stage", -- [3]
						16.5, -- [4]
						1357812, -- [5]
						"stage", -- [6]
						328117, -- [7]
						6, -- [8]
						"2424", -- [9]
						["id"] = 2407,
					},
					["192072"] = {
						"192072", -- [1]
						"Timer192072cd", -- [2]
						"~Call Reinforcements", -- [3]
						20, -- [4]
						298644, -- [5]
						"cd", -- [6]
						192072, -- [7]
						1, -- [8]
						"1480", -- [9]
						["id"] = 1810,
					},
					["169120"] = {
						"169120", -- [1]
						"Timer169120next", -- [2]
						"Font of Life", -- [3]
						15, -- [4]
						236160, -- [5]
						"next", -- [6]
						169120, -- [7]
						1, -- [8]
						"1210", -- [9]
						["id"] = 1756,
					},
					["330964"] = {
						"330964", -- [1]
						"Timer330964cd", -- [2]
						"~Dancing Fools", -- [3]
						24, -- [4]
						132333, -- [5]
						"cd", -- [6]
						330964, -- [7]
						1, -- [8]
						"2426", -- [9]
						["id"] = 2412,
					},
					["241636"] = {
						"241636", -- [1]
						"Timer241636nextcount	4", -- [2]
						"Hammer of Obliteration (4)", -- [3]
						18, -- [4]
						1038844, -- [5]
						"nextcount", -- [6]
						241636, -- [7]
						5, -- [8]
						"1897", -- [9]
						["id"] = 2052,
					},
					["234059"] = {
						"234059", -- [1]
						"Timer234059cdcount	1", -- [2]
						"~Unbound Chaos (1)", -- [3]
						7, -- [4]
						135795, -- [5]
						"cdcount", -- [6]
						234059, -- [7]
						3, -- [8]
						"1873", -- [9]
						["id"] = 2038,
					},
					["247716"] = {
						"247716", -- [1]
						"Timer247716cd", -- [2]
						"~Charged Blasts", -- [3]
						8.4, -- [4]
						236216, -- [5]
						"cd", -- [6]
						247716, -- [7]
						3, -- [8]
						"2009", -- [9]
						["id"] = 2082,
					},
					["318406"] = {
						"318406", -- [1]
						"Timer318406cd", -- [2]
						"~Tenderizing Smash", -- [3]
						14.5, -- [4]
						623773, -- [5]
						"cd", -- [6]
						318406, -- [7]
						3, -- [8]
						"2401", -- [9]
						["id"] = 2365,
					},
					["329770"] = {
						"329770", -- [1]
						"Timer329770cd", -- [2]
						"~Planting Seed", -- [3]
						21.6, -- [4]
						3575389, -- [5]
						"cd", -- [6]
						329770, -- [7]
						5, -- [8]
						"2418", -- [9]
						["id"] = 2405,
					},
					["233983"] = {
						"233983", -- [1]
						"Timer233983cd", -- [2]
						"~Echoing Anguish", -- [3]
						22.9, -- [4]
						136181, -- [5]
						"cd", -- [6]
						233983, -- [7]
						3, -- [8]
						"1867", -- [9]
						["id"] = 2048,
					},
					["325258"] = {
						"325258", -- [1]
						"Timer325258cd", -- [2]
						"~Master of Death", -- [3]
						9.5, -- [4]
						3163624, -- [5]
						"cd", -- [6]
						325258, -- [7]
						3, -- [8]
						"2410", -- [9]
						["id"] = 2396,
					},
					["46165"] = {
						"46165", -- [1]
						"Timer46165next", -- [2]
						"Shock Barrier", -- [3]
						60, -- [4]
						136051, -- [5]
						"next", -- [6]
						46165, -- [7]
						4, -- [8]
						"533", -- [9]
						["id"] = 1894,
					},
					["232249"] = {
						"232249", -- [1]
						"Timer232249cd", -- [2]
						"~Crashing Comet", -- [3]
						8.5, -- [4]
						135797, -- [5]
						"cd", -- [6]
						232249, -- [7]
						3, -- [8]
						"1862", -- [9]
						["id"] = 2032,
					},
					["153067"] = {
						"153067", -- [1]
						"Timer153067next", -- [2]
						"Void Devastation", -- [3]
						67.5, -- [4]
						535592, -- [5]
						"next", -- [6]
						153067, -- [7]
						3, -- [8]
						"1168", -- [9]
						["id"] = 1688,
					},
					["323059"] = {
						"323059", -- [1]
						"Timer323059active", -- [2]
						"Droman's Wrath ends", -- [3]
						12, -- [4]
						134218, -- [5]
						"active", -- [6]
						323059, -- [7]
						6, -- [8]
						"2400", -- [9]
						["id"] = 2397,
					},
					["326271"] = {
						"326271", -- [1]
						"Timer326271cd", -- [2]
						"~Stasis Trap", -- [3]
						10.5, -- [4]
						613397, -- [5]
						"cd", -- [6]
						326271, -- [7]
						3, -- [8]
						"2418", -- [9]
						["id"] = 2405,
					},
					["106872"] = {
						"106872", -- [1]
						"Timer106872cd", -- [2]
						"~Disorienting Smash", -- [3]
						13, -- [4]
						136175, -- [5]
						"cd", -- [6]
						106872, -- [7]
						0, -- [8]
						"685", -- [9]
						["id"] = 1305,
					},
					["233894"] = {
						"233894", -- [1]
						"Timer233894cd", -- [2]
						"~Suffocating Dark", -- [3]
						24, -- [4]
						136194, -- [5]
						"cd", -- [6]
						233894, -- [7]
						3, -- [8]
						"1867", -- [9]
						["id"] = 2048,
					},
					["340758"] = {
						"340758", -- [1]
						"Timer340758cd", -- [2]
						"~Spirits", -- [3]
						25, -- [4]
						3256113, -- [5]
						"cd", -- [6]
						340758, -- [7]
						3, -- [8]
						"2418", -- [9]
						["id"] = 2405,
					},
					["322773"] = {
						"322773", -- [1]
						"Timer322773cd", -- [2]
						"~Blood Barrier", -- [3]
						26.5, -- [4]
						1394887, -- [5]
						"cd", -- [6]
						322773, -- [7]
						6, -- [8]
						"2408", -- [9]
						["id"] = 2395,
					},
					["319702"] = {
						"319702", -- [1]
						"Timer319702cd", -- [2]
						"~Blood Torrent", -- [3]
						7.5, -- [4]
						1394887, -- [5]
						"cd", -- [6]
						319702, -- [7]
						2, -- [8]
						"2387", -- [9]
						["id"] = 2380,
					},
					["119684"] = {
						"119684", -- [1]
						"Timer119684cd", -- [2]
						"~Ground Slam", -- [3]
						9.5, -- [4]
						451165, -- [5]
						"cd", -- [6]
						119684, -- [7]
						3, -- [8]
						"698", -- [9]
						["id"] = 1441,
					},
					["333932"] = {
						"333932", -- [1]
						"Timer333932cdcount	1", -- [2]
						"~Hand of Destruction (1)", -- [3]
						46.6, -- [4]
						136225, -- [5]
						"cdcount", -- [6]
						333932, -- [7]
						2, -- [8]
						"2424", -- [9]
						["id"] = 2407,
					},
					["156857"] = {
						"156857", -- [1]
						"Timer156857cd", -- [2]
						"~Rain of Fire", -- [3]
						15, -- [4]
						136186, -- [5]
						"cd", -- [6]
						156857, -- [7]
						4, -- [8]
						"1225", -- [9]
						["id"] = 1714,
					},
					["321247"] = {
						"321247", -- [1]
						"Timer321247cd", -- [2]
						"~Final Harvest", -- [3]
						38.6, -- [4]
						2576087, -- [5]
						"cd", -- [6]
						321247, -- [7]
						2, -- [8]
						"2391", -- [9]
						["id"] = 2388,
					},
					["192094"] = {
						"192094", -- [1]
						"Timer192094cd", -- [2]
						"~Impaling Spear", -- [3]
						28, -- [4]
						135130, -- [5]
						"cd", -- [6]
						192094, -- [7]
						3, -- [8]
						"1480", -- [9]
						["id"] = 1810,
					},
					["321834"] = {
						"321834", -- [1]
						"Timer321834cd", -- [2]
						"~Dodge Ball", -- [3]
						8.1, -- [4]
						132387, -- [5]
						"cd", -- [6]
						321834, -- [7]
						3, -- [8]
						"2402", -- [9]
						["id"] = 2392,
					},
					["319650"] = {
						"319650", -- [1]
						"Timer319650cd", -- [2]
						"~Vicious Headbutt", -- [3]
						5.9, -- [4]
						132091, -- [5]
						"cd", -- [6]
						319650, -- [7]
						5, -- [8]
						"2388", -- [9]
						["id"] = 2360,
					},
					["328791"] = {
						"328791", -- [1]
						"Timer328791next", -- [2]
						"Ritual of Woe", -- [3]
						8.2, -- [4]
						237536, -- [5]
						"next", -- [6]
						328791, -- [7]
						2, -- [8]
						"2413", -- [9]
						["id"] = 2381,
					},
					["325552"] = {
						"325552", -- [1]
						"Timer325552cd", -- [2]
						"~Cytotoxic Slash", -- [3]
						3.1, -- [4]
						348565, -- [5]
						"cd", -- [6]
						325552, -- [7]
						5, -- [8]
						"2423", -- [9]
						["id"] = 2385,
					},
					["334765"] = {
						"334765", -- [1]
						"Timer334765cdcount	1", -- [2]
						"~Heart Rend (1)", -- [3]
						28.9, -- [4]
						135811, -- [5]
						"cdcount", -- [6]
						334765, -- [7]
						3, -- [8]
						"2425", -- [9]
						["id"] = 2417,
					},
					["326707"] = {
						"326707", -- [1]
						"Timer326707nextcount	1", -- [2]
						"Cleansing Pain (1)", -- [3]
						5.8, -- [4]
						3528313, -- [5]
						"nextcount", -- [6]
						326707, -- [7]
						5, -- [8]
						"2424", -- [9]
						["id"] = 2407,
					},
					["320050"] = {
						"320050", -- [1]
						"Timer320050cdcount	1", -- [2]
						"~Might of Maldraxxus (1)", -- [3]
						17.1, -- [4]
						1115905, -- [5]
						"cdcount", -- [6]
						320050, -- [7]
						6, -- [8]
						"2390", -- [9]
						["id"] = 2366,
					},
					["154350"] = {
						"154350", -- [1]
						"Timer154350cd", -- [2]
						"~Omen of Death", -- [3]
						10.5, -- [4]
						136022, -- [5]
						"cd", -- [6]
						154350, -- [7]
						3, -- [8]
						"1160", -- [9]
						["id"] = 1682,
					},
					["324527"] = {
						"324527", -- [1]
						"Timer324527next", -- [2]
						"Plaguestomp", -- [3]
						7, -- [4]
						1044089, -- [5]
						"next", -- [6]
						324527, -- [7]
						3, -- [8]
						"2419", -- [9]
						["id"] = 2382,
					},
					["320326"] = {
						"320326", -- [1]
						"Timer320326cd", -- [2]
						"~Displaced Blastwave", -- [3]
						9.4, -- [4]
						1408832, -- [5]
						"cd", -- [6]
						320326, -- [7]
						3, -- [8]
						"2398", -- [9]
						["id"] = 2400,
					},
					["238570"] = {
						"238570", -- [1]
						"Timer238570nextcount	1", -- [2]
						"Tormented Cries (1)", -- [3]
						119, -- [4]
						463286, -- [5]
						"nextcount", -- [6]
						238570, -- [7]
						6, -- [8]
						"1896", -- [9]
						["id"] = 2054,
					},
					["ej5934"] = {
						"ej5934", -- [1]
						"Timerej5934next", -- [2]
						"Sharpshooter Guard", -- [3]
						21, -- [4]
						970886, -- [5]
						"next", -- [6]
						"ej5934", -- [7]
						1, -- [8]
						"569", -- [9]
						["id"] = 1938,
					},
					["252861"] = {
						"252861", -- [1]
						"Timer252861nextcount	1", -- [2]
						"Storm of Darkness (1)", -- [3]
						26, -- [4]
						136194, -- [5]
						"nextcount", -- [6]
						252861, -- [7]
						2, -- [8]
						"1986", -- [9]
						["id"] = 2073,
					},
					["255826"] = {
						"255826", -- [1]
						"Timer255826cdcount	1", -- [2]
						"~Edge of Obliteration (1)", -- [3]
						21, -- [4]
						1778227, -- [5]
						"cdcount", -- [6]
						255826, -- [7]
						2, -- [8]
						"2031", -- [9]
						["id"] = 2092,
					},
					["329298"] = {
						"329298", -- [1]
						"Timer329298cdcount	1", -- [2]
						"~Miasma (1)", -- [3]
						3, -- [4]
						1390943, -- [5]
						"cdcount", -- [6]
						329298, -- [7]
						3, -- [8]
						"2428", -- [9]
						["id"] = 2383,
					},
					["346657"] = {
						"346657", -- [1]
						"Timer346657cd", -- [2]
						"~Eruption", -- [3]
						35, -- [4]
						3528311, -- [5]
						"cd", -- [6]
						346657, -- [7]
						3, -- [8]
						"2426", -- [9]
						["id"] = 2412,
					},
					["230920"] = {
						"230920", -- [1]
						"Timer230920cd", -- [2]
						"~Consuming Hunger", -- [3]
						20, -- [4]
						237395, -- [5]
						"cd", -- [6]
						230920, -- [7]
						1, -- [8]
						"1861", -- [9]
						["id"] = 2037,
					},
					["328731"] = {
						"328731", -- [1]
						"Timer328731cast	Creature-0-4230-2296-5369-168962-00001A2763", -- [2]
						"Phoenix Embers ", -- [3]
						20, -- [4]
						628267, -- [5]
						"cast", -- [6]
						328731, -- [7]
						1, -- [8]
						"2422", -- [9]
						["id"] = 2402,
					},
					["111668"] = {
						"111668", -- [1]
						"Timer111668next", -- [2]
						"Battering Headbutt", -- [3]
						33, -- [4]
						236195, -- [5]
						"next", -- [6]
						111668, -- [7]
						0, -- [8]
						"649", -- [9]
						["id"] = 1419,
					},
					["247552"] = {
						"247552", -- [1]
						"Timer247552cd", -- [2]
						"~Sleep Canister", -- [3]
						7, -- [4]
						136090, -- [5]
						"cd", -- [6]
						247552, -- [7]
						3, -- [8]
						"2009", -- [9]
						["id"] = 2082,
					},
					["320644"] = {
						"320644", -- [1]
						"Timer320644cdcount	1", -- [2]
						"~Brutal Combo (1)", -- [3]
						5.8, -- [4]
						1390946, -- [5]
						"cdcount", -- [6]
						320644, -- [7]
						5, -- [8]
						"2390", -- [9]
						["id"] = 2366,
					},
					["119946"] = {
						"119946", -- [1]
						"Timer119946cd", -- [2]
						"~Ravage", -- [3]
						26, -- [4]
						132142, -- [5]
						"cd", -- [6]
						119946, -- [7]
						3, -- [8]
						"708", -- [9]
						["id"] = 1442,
					},
					["319733"] = {
						"319733", -- [1]
						"Timer319733cd", -- [2]
						"~Stone Call", -- [3]
						10.9, -- [4]
						463493, -- [5]
						"cd", -- [6]
						319733, -- [7]
						1, -- [8]
						"2387", -- [9]
						["id"] = 2380,
					},
					["236378"] = {
						"236378", -- [1]
						"Timer236378cdcount	1", -- [2]
						"~Wailing Reflection (1)", -- [3]
						56, -- [4]
						463284, -- [5]
						"cdcount", -- [6]
						236378, -- [7]
						3, -- [8]
						"1898", -- [9]
						["id"] = 2051,
					},
					["233441"] = {
						"233441", -- [1]
						"Timer233441cdcount	1", -- [2]
						"~Bone Saw (1)", -- [3]
						64.5, -- [4]
						999952, -- [5]
						"cdcount", -- [6]
						233441, -- [7]
						2, -- [8]
						"1867", -- [9]
						["id"] = 2048,
					},
					["254429"] = {
						"254429", -- [1]
						"Timer254429cd", -- [2]
						"~Weight of Darkness", -- [3]
						73.1, -- [4]
						136194, -- [5]
						"cd", -- [6]
						254429, -- [7]
						3, -- [8]
						"1987", -- [9]
						["id"] = 2074,
					},
					["244072"] = {
						"244072", -- [1]
						"Timer244072cd", -- [2]
						"~Molten Touch", -- [3]
						18, -- [4]
						135807, -- [5]
						"cd", -- [6]
						244072, -- [7]
						3, -- [8]
						"1987", -- [9]
						["id"] = 2074,
					},
					["334053"] = {
						"334053", -- [1]
						"Timer334053cd", -- [2]
						"~Purifying Blast", -- [3]
						8.4, -- [4]
						3528286, -- [5]
						"cd", -- [6]
						334053, -- [7]
						3, -- [8]
						"2414", -- [9]
						["id"] = 2358,
					},
					["334625"] = {
						"334625", -- [1]
						"Timer334625cd", -- [2]
						"~Abyssal Detonation", -- [3]
						20.1, -- [4]
						3528303, -- [5]
						"cd", -- [6]
						334625, -- [7]
						2, -- [8]
						"2412", -- [9]
						["id"] = 2359,
					},
					["320966"] = {
						"320966", -- [1]
						"Timer320966cd", -- [2]
						"~Overhead Slash", -- [3]
						8.3, -- [4]
						3284464, -- [5]
						"cd", -- [6]
						320966, -- [7]
						5, -- [8]
						"2399", -- [9]
						["id"] = 2357,
					},
					["159382"] = {
						"159382", -- [1]
						"Timer159382active", -- [2]
						"Quills ends", -- [3]
						17, -- [4]
						132927, -- [5]
						"active", -- [6]
						159382, -- [7]
						2, -- [8]
						"967", -- [9]
						["id"] = 1700,
					},
					["236710"] = {
						"236710", -- [1]
						"Timer236710cd", -- [2]
						"~Erupting Reflection", -- [3]
						18.5, -- [4]
						1357814, -- [5]
						"cd", -- [6]
						236710, -- [7]
						3, -- [8]
						"1898", -- [9]
						["id"] = 2051,
					},
					["319619"] = {
						"319619", -- [1]
						"Timer319619cd", -- [2]
						"~Displacement Trap", -- [3]
						4.5, -- [4]
						132206, -- [5]
						"cd", -- [6]
						319619, -- [7]
						3, -- [8]
						"2398", -- [9]
						["id"] = 2400,
					},
					["157001"] = {
						"157001", -- [1]
						"Timer157001cd", -- [2]
						"~Chaos Wave", -- [3]
						10, -- [4]
						607850, -- [5]
						"cd", -- [6]
						157001, -- [7]
						3, -- [8]
						"1225", -- [9]
						["id"] = 1714,
					},
					["233055"] = {
						"233055", -- [1]
						"Timer233055cd", -- [2]
						"~Infernal Spike", -- [3]
						4, -- [4]
						1118739, -- [5]
						"cd", -- [6]
						233055, -- [7]
						3, -- [8]
						"1862", -- [9]
						["id"] = 2032,
					},
					["258068"] = {
						"258068", -- [1]
						"Timer258068cdcount	1", -- [2]
						"~Sargeras' Gaze (1)", -- [3]
						8.2, -- [4]
						1357795, -- [5]
						"cdcount", -- [6]
						258068, -- [7]
						3, -- [8]
						"2031", -- [9]
						["id"] = 2092,
					},
					["245227"] = {
						"245227", -- [1]
						"Timer245227next", -- [2]
						"Assume Command", -- [3]
						90, -- [4]
						132333, -- [5]
						"next", -- [6]
						245227, -- [7]
						6, -- [8]
						"1997", -- [9]
						["id"] = 2070,
					},
					["319521"] = {
						"319521", -- [1]
						"Timer319521cd", -- [2]
						"~Draw Soul", -- [3]
						15.5, -- [4]
						2576083, -- [5]
						"cd", -- [6]
						319521, -- [7]
						3, -- [8]
						"2389", -- [9]
						["id"] = 2364,
					},
					["111728"] = {
						"111728", -- [1]
						"Timer111728nextcount	1", -- [2]
						"Stomp (1)", -- [3]
						20.5, -- [4]
						132368, -- [5]
						"nextcount", -- [6]
						111728, -- [7]
						2, -- [8]
						"649", -- [9]
						["id"] = 1419,
					},
					["320376"] = {
						"320376", -- [1]
						"Timer320376cd	Creature-0-4220-2286-11134-164578-0000A0BAB4", -- [2]
						"~Mutlilate", -- [3]
						10, -- [4]
						237517, -- [5]
						"cd", -- [6]
						320376, -- [7]
						3, -- [8]
						"2392", -- [9]
						["id"] = 2389,
					},
					["250669"] = {
						"250669", -- [1]
						"Timer250669nextcount	1", -- [2]
						"Soulburst (1)", -- [3]
						30.3, -- [4]
						1778229, -- [5]
						"nextcount", -- [6]
						250669, -- [7]
						3, -- [8]
						"2031", -- [9]
						["id"] = 2092,
					},
					["249121"] = {
						"249121", -- [1]
						"Timer249121cdcount	1", -- [2]
						"~Final Doom (1)", -- [3]
						59.3, -- [4]
						132097, -- [5]
						"cdcount", -- [6]
						249121, -- [7]
						4, -- [8]
						"2025", -- [9]
						["id"] = 2075,
					},
					["334929"] = {
						"334929", -- [1]
						"Timer334929cdcount	1", -- [2]
						"~Serrated Swipe (1)", -- [3]
						8.1, -- [4]
						1396975, -- [5]
						"cdcount", -- [6]
						334929, -- [7]
						5, -- [8]
						"2425", -- [9]
						["id"] = 2417,
					},
					["248332"] = {
						"248332", -- [1]
						"Timer248332cdcount	1", -- [2]
						"~Rain of Fel (1)", -- [3]
						6, -- [4]
						135797, -- [5]
						"cdcount", -- [6]
						248332, -- [7]
						3, -- [8]
						"2025", -- [9]
						["id"] = 2075,
					},
					["322236"] = {
						"322236", -- [1]
						"Timer322236cd", -- [2]
						"~Touch of Slime", -- [3]
						6, -- [4]
						254105, -- [5]
						"cd", -- [6]
						322236, -- [7]
						5, -- [8]
						"2404", -- [9]
						["id"] = 2386,
					},
					["237722"] = {
						"237722", -- [1]
						"Timer237722next", -- [2]
						"Blowback", -- [3]
						40.9, -- [4]
						236256, -- [5]
						"next", -- [6]
						237722, -- [7]
						6, -- [8]
						"1897", -- [9]
						["id"] = 2052,
					},
					["334485"] = {
						"334485", -- [1]
						"Timer334485cd", -- [2]
						"~Recharge", -- [3]
						44.9, -- [4]
						3565449, -- [5]
						"cd", -- [6]
						334485, -- [7]
						6, -- [8]
						"2416", -- [9]
						["id"] = 2356,
					},
					["339706"] = {
						"339706", -- [1]
						"Timer339706cd", -- [2]
						"~Ghostly Charge", -- [3]
						17, -- [4]
						3511738, -- [5]
						"cd", -- [6]
						339706, -- [7]
						3, -- [8]
						"2417", -- [9]
						["id"] = 2404,
					},
					["245627"] = {
						"245627", -- [1]
						"Timer245627next", -- [2]
						"Whirling Saber", -- [3]
						8, -- [4]
						999952, -- [5]
						"next", -- [6]
						245627, -- [7]
						3, -- [8]
						"1986", -- [9]
						["id"] = 2073,
					},
					["255199"] = {
						"255199", -- [1]
						"Timer255199cd", -- [2]
						"~Avatar of Aggramar", -- [3]
						20.9, -- [4]
						135947, -- [5]
						"cd", -- [6]
						255199, -- [7]
						5, -- [8]
						"2031", -- [9]
						["id"] = 2092,
					},
					["236519"] = {
						"236519", -- [1]
						"Timer236519cd", -- [2]
						"~Moon Burn", -- [3]
						9.1, -- [4]
						136057, -- [5]
						"cd", -- [6]
						236519, -- [7]
						3, -- [8]
						"1903", -- [9]
						["id"] = 2050,
					},
					["251448"] = {
						"251448", -- [1]
						"Timer251448cd", -- [2]
						"~Burning Maw", -- [3]
						8.2, -- [4]
						135813, -- [5]
						"cd", -- [6]
						251448, -- [7]
						5, -- [8]
						"1987", -- [9]
						["id"] = 2074,
					},
					["342077"] = {
						"342077", -- [1]
						"Timer342077cd", -- [2]
						"~Echolocation", -- [3]
						14.2, -- [4]
						132097, -- [5]
						"cd", -- [6]
						342077, -- [7]
						3, -- [8]
						"2393", -- [9]
						["id"] = 2398,
					},
					["245546"] = {
						"245546", -- [1]
						"Timer245546next", -- [2]
						"Summon Reinforcements", -- [3]
						8, -- [4]
						237559, -- [5]
						"next", -- [6]
						245546, -- [7]
						1, -- [8]
						"1997", -- [9]
						["id"] = 2070,
					},
					["111600"] = {
						"111600", -- [1]
						"Timer111600target	Themythlife-Frostmourne", -- [2]
						"Screeching Swarm: Themythlife-Frostmourne", -- [3]
						10, -- [4]
						538518, -- [5]
						"target", -- [6]
						111600, -- [7]
						0, -- [8]
						"649", -- [9]
						["id"] = 1419,
					},
					["334009"] = {
						"334009", -- [1]
						"Timer334009cdcount3	1", -- [2]
						"~Leap (1)", -- [3]
						29.4, -- [4]
						2101174, -- [5]
						"cdcount", -- [6]
						334009, -- [7]
						3, -- [8]
						"2425", -- [9]
						["id"] = 2417,
					},
					["118988"] = {
						"118988", -- [1]
						"Timer118988target	Glintrok Oracle", -- [2]
						"Reckless Inspiration: Glintrok Oracle", -- [3]
						20, -- [4]
						236310, -- [5]
						"target", -- [6]
						118988, -- [7]
						0, -- [8]
						"690", -- [9]
						["id"] = 2129,
					},
					["328885"] = {
						"328885", -- [1]
						"Timer328885next", -- [2]
						"Greater Castigation", -- [3]
						5.8, -- [4]
						3528313, -- [5]
						"next", -- [6]
						328885, -- [7]
						3, -- [8]
						"2422", -- [9]
						["id"] = 2402,
					},
					["230227"] = {
						"230227", -- [1]
						"Timer230227cd", -- [2]
						"~From the Abyss", -- [3]
						18, -- [4]
						133898, -- [5]
						"cd", -- [6]
						230227, -- [7]
						1, -- [8]
						"1861", -- [9]
						["id"] = 2037,
					},
					["231854"] = {
						"231854", -- [1]
						"Timer231854nextcount	1", -- [2]
						"Unchecked Rage (1)", -- [3]
						20, -- [4]
						132344, -- [5]
						"nextcount", -- [6]
						231854, -- [7]
						2, -- [8]
						"1856", -- [9]
						["id"] = 2036,
					},
					["154032"] = {
						"154032", -- [1]
						"Timer154032cd", -- [2]
						"~Lens Flare", -- [3]
						27.3, -- [4]
						1029587, -- [5]
						"cd", -- [6]
						154032, -- [7]
						3, -- [8]
						"968", -- [9]
						["id"] = 1701,
					},
					["320272"] = {
						"320272", -- [1]
						"Timer320272cd", -- [2]
						"~Spectral Transference", -- [3]
						10.5, -- [4]
						2576086, -- [5]
						"cd", -- [6]
						320272, -- [7]
						5, -- [8]
						"2397", -- [9]
						["id"] = 2391,
					},
					["322893"] = {
						"322893", -- [1]
						"Timer322893next", -- [2]
						"Slipstream", -- [3]
						10, -- [4]
						648840, -- [5]
						"next", -- [6]
						322893, -- [7]
						2, -- [8]
						"2412", -- [9]
						["id"] = 2359,
					},
					["323552"] = {
						"323552", -- [1]
						"Timer323552cd", -- [2]
						"~Volley of Power", -- [3]
						12, -- [4]
						1394887, -- [5]
						"cd", -- [6]
						323552, -- [7]
						4, -- [8]
						"2411", -- [9]
						["id"] = 2403,
					},
					["nil"] = {
						"nil", -- [1]
						"Record Victory", -- [2]
						"Record Victory", -- [3]
						230.5269999999982, -- [4]
						237538, -- [5]
						nil, -- [6]
						nil, -- [7]
						0, -- [8]
						"2394", -- [9]
						["id"] = 2399,
					},
					["329181"] = {
						"329181", -- [1]
						"Timer329181cdcount	1", -- [2]
						"~Wracking Pain (1)", -- [3]
						21.1, -- [4]
						3528313, -- [5]
						"cdcount", -- [6]
						329181, -- [7]
						5, -- [8]
						"2424", -- [9]
						["id"] = 2407,
					},
					["327411"] = {
						"327411", -- [1]
						"Timer327411cd", -- [2]
						"~Curse of Stone", -- [3]
						21.3, -- [4]
						516666, -- [5]
						"cd", -- [6]
						327411, -- [7]
						3, -- [8]
						"2387", -- [9]
						["id"] = 2380,
					},
					["ej5927"] = {
						"ej5927", -- [1]
						"Timerej5927next", -- [2]
						"Heathen Guard", -- [3]
						27.5, -- [4]
						970886, -- [5]
						"next", -- [6]
						"ej5927", -- [7]
						1, -- [8]
						"569", -- [9]
						["id"] = 1938,
					},
					["157465"] = {
						"157465", -- [1]
						"Timer157465cd", -- [2]
						"~Fate", -- [3]
						25, -- [4]
						237537, -- [5]
						"cd", -- [6]
						157465, -- [7]
						3, -- [8]
						"1185", -- [9]
						["id"] = 1686,
					},
					["320359"] = {
						"320359", -- [1]
						"Timer320359cast", -- [2]
						"Escape ", -- [3]
						30, -- [4]
						132307, -- [5]
						"cast", -- [6]
						320359, -- [7]
						6, -- [8]
						"2392", -- [9]
						["id"] = 2389,
					},
					["324608"] = {
						"324608", -- [1]
						"Timer324608cd", -- [2]
						"~Charged Stomp", -- [3]
						14.3, -- [4]
						460957, -- [5]
						"cd", -- [6]
						324608, -- [7]
						3, -- [8]
						"2414", -- [9]
						["id"] = 2358,
					},
					["ej5930"] = {
						"ej5930", -- [1]
						"Timerej5930next", -- [2]
						"Reaver Guard", -- [3]
						21, -- [4]
						970886, -- [5]
						"next", -- [6]
						"ej5930", -- [7]
						1, -- [8]
						"569", -- [9]
						["id"] = 1938,
					},
					["31422"] = {
						"31422", -- [1]
						"Timer31422active", -- [2]
						"Time Stop ends", -- [3]
						4, -- [4]
						135728, -- [5]
						"active", -- [6]
						31422, -- [7]
						3, -- [8]
						"554", -- [9]
						["id"] = 1919,
					},
					["331618"] = {
						"331618", -- [1]
						"Timer331618cdcount	1", -- [2]
						"~Oppressive Banner (1)", -- [3]
						10.7, -- [4]
						3578234, -- [5]
						"cdcount", -- [6]
						331618, -- [7]
						1, -- [8]
						"2390", -- [9]
						["id"] = 2366,
					},
					["239362"] = {
						"239362", -- [1]
						"Timer239362next", -- [2]
						"Delicious Bufferfish", -- [3]
						12.5, -- [4]
						533422, -- [5]
						"next", -- [6]
						239362, -- [7]
						5, -- [8]
						"1861", -- [9]
						["id"] = 2037,
					},
					["321828"] = {
						"321828", -- [1]
						"Timer321828cd", -- [2]
						"~Patty Cake", -- [3]
						13.4, -- [4]
						134470, -- [5]
						"cd", -- [6]
						321828, -- [7]
						3, -- [8]
						"2402", -- [9]
						["id"] = 2392,
					},
					["322654"] = {
						"322654", -- [1]
						"Timer322654cd", -- [2]
						"~Acid Expulsion", -- [3]
						8, -- [4]
						132104, -- [5]
						"cd", -- [6]
						322654, -- [7]
						3, -- [8]
						"2405", -- [9]
						["id"] = 2393,
					},
					["200024"] = {
						"200024", -- [1]
						"Timer200024cd", -- [2]
						"~Nether Venom", -- [3]
						25, -- [4]
						237155, -- [5]
						"cd", -- [6]
						200024, -- [7]
						3, -- [8]
						"1500", -- [9]
						["id"] = 1826,
					},
					["120195"] = {
						"120195", -- [1]
						"Timer120195next", -- [2]
						"Meteor", -- [3]
						42, -- [4]
						135821, -- [5]
						"next", -- [6]
						120195, -- [7]
						3, -- [8]
						"708", -- [9]
						["id"] = 1442,
					},
					["334852"] = {
						"334852", -- [1]
						"Timer334852cd", -- [2]
						"~Howl", -- [3]
						13.9, -- [4]
						3386971, -- [5]
						"cd", -- [6]
						334852, -- [7]
						3, -- [8]
						"2429", -- [9]
						["id"] = 2418,
					},
					["ej22082"] = {
						"ej22082", -- [1]
						"Timerej22082cdcount	1", -- [2]
						"~Pestering Fiend (1)", -- [3]
						100, -- [4]
						134085, -- [5]
						"cdcount", -- [6]
						"ej22082", -- [7]
						1, -- [8]
						"2422", -- [9]
						["id"] = 2402,
					},
					["245161"] = {
						"245161", -- [1]
						"Timer245161cd", -- [2]
						"~Entropic Mine", -- [3]
						5.1, -- [4]
						133009, -- [5]
						"cd", -- [6]
						245161, -- [7]
						3, -- [8]
						"1997", -- [9]
						["id"] = 2070,
					},
					["243983"] = {
						"243983", -- [1]
						"Timer243983cd", -- [2]
						"~Collapsing World", -- [3]
						10.5, -- [4]
						1044088, -- [5]
						"cd", -- [6]
						243983, -- [7]
						2, -- [8]
						"1985", -- [9]
						["id"] = 2064,
					},
					["153810"] = {
						"153810", -- [1]
						"Timer153810cd", -- [2]
						"~Summon Solar Flare", -- [3]
						11, -- [4]
						574795, -- [5]
						"cd", -- [6]
						153810, -- [7]
						3, -- [8]
						"967", -- [9]
						["id"] = 1700,
					},
					["106853"] = {
						"106853", -- [1]
						"Timer106853cd", -- [2]
						"~Fists of Fury", -- [3]
						23, -- [4]
						305703, -- [5]
						"cd", -- [6]
						106853, -- [7]
						0, -- [8]
						"657", -- [9]
						["id"] = 1304,
					},
					["238587"] = {
						"238587", -- [1]
						"Timer238587cdcount	1", -- [2]
						"~Rain of Brimstone (1)", -- [3]
						12.1, -- [4]
						517112, -- [5]
						"cdcount", -- [6]
						238587, -- [7]
						5, -- [8]
						"1862", -- [9]
						["id"] = 2032,
					},
					["322232"] = {
						"322232", -- [1]
						"Timer322232cd", -- [2]
						"~Infectious Rain", -- [3]
						19.1, -- [4]
						132100, -- [5]
						"cd", -- [6]
						322232, -- [7]
						3, -- [8]
						"2404", -- [9]
						["id"] = 2386,
					},
					["120201"] = {
						"120201", -- [1]
						"Timer120201cd", -- [2]
						"~Conflagrate", -- [3]
						22, -- [4]
						135807, -- [5]
						"cd", -- [6]
						120201, -- [7]
						3, -- [8]
						"708", -- [9]
						["id"] = 1442,
					},
					["238430"] = {
						"238430", -- [1]
						"Timer238430cdcount	1", -- [2]
						"~Bursting Dreadflame (1)", -- [3]
						11, -- [4]
						460698, -- [5]
						"cdcount", -- [6]
						238430, -- [7]
						3, -- [8]
						"1898", -- [9]
						["id"] = 2051,
					},
					["112992"] = {
						"112992", -- [1]
						"Timer112992next", -- [2]
						"Furlwind", -- [3]
						15, -- [4]
						132369, -- [5]
						"next", -- [6]
						112992, -- [7]
						2, -- [8]
						"669", -- [9]
						["id"] = 1413,
					},
					["339550"] = {
						"339550", -- [1]
						"Timer339550cd", -- [2]
						"~Echo of Battle", -- [3]
						7, -- [4]
						1778230, -- [5]
						"cd", -- [6]
						339550, -- [7]
						3, -- [8]
						"2417", -- [9]
						["id"] = 2404,
					},
					["324449"] = {
						"324449", -- [1]
						"Timer324449cd", -- [2]
						"~Manifest Death", -- [3]
						23.9, -- [4]
						2576087, -- [5]
						"cd", -- [6]
						324449, -- [7]
						3, -- [8]
						"2417", -- [9]
						["id"] = 2404,
					},
					["236571"] = {
						"236571", -- [1]
						"Timer236571cd", -- [2]
						"~Shadowy Blades", -- [3]
						27, -- [4]
						1035040, -- [5]
						"cd", -- [6]
						236571, -- [7]
						3, -- [8]
						"1873", -- [9]
						["id"] = 2038,
					},
					["255594"] = {
						"255594", -- [1]
						"Timer255594cdcount	1", -- [2]
						"~Sky and Sea (1)", -- [3]
						10.1, -- [4]
						1385912, -- [5]
						"cdcount", -- [6]
						255594, -- [7]
						5, -- [8]
						"2031", -- [9]
						["id"] = 2092,
					},
					["326171"] = {
						"326171", -- [1]
						"Timer326171cd", -- [2]
						"~Shatter Reality", -- [3]
						60, -- [4]
						463285, -- [5]
						"cd", -- [6]
						326171, -- [7]
						2, -- [8]
						"2410", -- [9]
						["id"] = 2396,
					},
					["243976"] = {
						"243976", -- [1]
						"Timer243976next", -- [2]
						"Torment of Frost", -- [3]
						100, -- [4]
						236209, -- [5]
						"next", -- [6]
						243976, -- [7]
						6, -- [8]
						"1983", -- [9]
						["id"] = 2069,
					},
					["322903"] = {
						"322903", -- [1]
						"Timer322903cd", -- [2]
						"~Gloom Squall", -- [3]
						34.5, -- [4]
						1035055, -- [5]
						"cd", -- [6]
						322903, -- [7]
						2, -- [8]
						"2407", -- [9]
						["id"] = 2363,
					},
					["329455"] = {
						"329455", -- [1]
						"Timer329455nextcount	1", -- [2]
						"Desolate (1)", -- [3]
						22, -- [4]
						1778230, -- [5]
						"nextcount", -- [6]
						329455, -- [7]
						2, -- [8]
						"2428", -- [9]
						["id"] = 2383,
					},
					["235271"] = {
						"235271", -- [1]
						"Timer235271nextcount	2", -- [2]
						"Infusion (2)", -- [3]
						2, -- [4]
						1122135, -- [5]
						"nextcount", -- [6]
						235271, -- [7]
						3, -- [8]
						"1897", -- [9]
						["id"] = 2052,
					},
					["333387"] = {
						"333387", -- [1]
						"Timer333387cdcount	1", -- [2]
						"~Wicked Blade (1)", -- [3]
						16.6, -- [4]
						589068, -- [5]
						"cdcount", -- [6]
						333387, -- [7]
						3, -- [8]
						"2425", -- [9]
						["id"] = 2417,
					},
					["323137"] = {
						"323137", -- [1]
						"Timer323137cd", -- [2]
						"~Bewildering Pollen", -- [3]
						15.8, -- [4]
						134219, -- [5]
						"cd", -- [6]
						323137, -- [7]
						5, -- [8]
						"2400", -- [9]
						["id"] = 2397,
					},
					["322681"] = {
						"322681", -- [1]
						"Timer322681cd", -- [2]
						"~Meat Hook", -- [3]
						10.6, -- [4]
						1373906, -- [5]
						"cd", -- [6]
						322681, -- [7]
						3, -- [8]
						"2392", -- [9]
						["id"] = 2389,
					},
					["320637"] = {
						"320637", -- [1]
						"Timer320637cd", -- [2]
						"~Fetid Gas", -- [3]
						22, -- [4]
						646782, -- [5]
						"cd", -- [6]
						320637, -- [7]
						3, -- [8]
						"2395", -- [9]
						["id"] = 2387,
					},
					["240910"] = {
						"240910", -- [1]
						"Timer240910cdcount	1", -- [2]
						"~Armageddon (1)", -- [3]
						10, -- [4]
						136186, -- [5]
						"cdcount", -- [6]
						240910, -- [7]
						5, -- [8]
						"1898", -- [9]
						["id"] = 2051,
					},
					["243967"] = {
						"243967", -- [1]
						"Timer243967next", -- [2]
						"Torment of Flames", -- [3]
						5, -- [4]
						236220, -- [5]
						"next", -- [6]
						243967, -- [7]
						6, -- [8]
						"1983", -- [9]
						["id"] = 2069,
					},
					["319685"] = {
						"319685", -- [1]
						"Timer319685cd", -- [2]
						"~Severing Smash", -- [3]
						34.2, -- [4]
						1778230, -- [5]
						"cd", -- [6]
						319685, -- [7]
						6, -- [8]
						"2388", -- [9]
						["id"] = 2360,
					},
					["320180"] = {
						"320180", -- [1]
						"Timer320180cd", -- [2]
						"~Noxious Spores", -- [3]
						17.7, -- [4]
						464341, -- [5]
						"cd", -- [6]
						320180, -- [7]
						3, -- [8]
						"2397", -- [9]
						["id"] = 2391,
					},
					["114459"] = {
						"114459", -- [1]
						"Timer114459fades", -- [2]
						"Fizzy Bubbles fades", -- [3]
						20, -- [4]
						512902, -- [5]
						"fades", -- [6]
						114459, -- [7]
						0, -- [8]
						"670", -- [9]
						["id"] = 1414,
					},
					["44194"] = {
						"44194", -- [1]
						"Timer44194cd", -- [2]
						"~Phoenix", -- [3]
						45, -- [4]
						134373, -- [5]
						"cd", -- [6]
						44194, -- [7]
						1, -- [8]
						"533", -- [9]
						["id"] = 1894,
					},
					["328437"] = {
						"328437", -- [1]
						"Timer328437cd", -- [2]
						"~Tear", -- [3]
						14, -- [4]
						526520, -- [5]
						"cd", -- [6]
						328437, -- [7]
						3, -- [8]
						"2418", -- [9]
						["id"] = 2405,
					},
					["ej21954"] = {
						"ej21954", -- [1]
						"Timerej21954cdcount	1", -- [2]
						"~Rockbound Vanquisher (1)", -- [3]
						50, -- [4]
						2065633, -- [5]
						"cdcount", -- [6]
						"ej21954", -- [7]
						1, -- [8]
						"2422", -- [9]
						["id"] = 2402,
					},
					["325877"] = {
						"325877", -- [1]
						"Timer325877cd", -- [2]
						"~Ember Blast", -- [3]
						20.1, -- [4]
						135826, -- [5]
						"cd", -- [6]
						325877, -- [7]
						3, -- [8]
						"2422", -- [9]
						["id"] = 2402,
					},
					["246516"] = {
						"246516", -- [1]
						"Timer246516cdcount	1", -- [2]
						"~Apocalypse Protocol (1)", -- [3]
						31.8, -- [4]
						135796, -- [5]
						"cdcount", -- [6]
						246516, -- [7]
						6, -- [8]
						"2004", -- [9]
						["id"] = 2088,
					},
					["334945"] = {
						"334945", -- [1]
						"Timer334945cd", -- [2]
						"~Lunge", -- [3]
						18.1, -- [4]
						1029718, -- [5]
						"cd", -- [6]
						334945, -- [7]
						3, -- [8]
						"2429", -- [9]
						["id"] = 2418,
					},
					["244688"] = {
						"244688", -- [1]
						"Timer244688nextcount	1", -- [2]
						"Taeshalach Technique (1)", -- [3]
						14.3, -- [4]
						510053, -- [5]
						"nextcount", -- [6]
						244688, -- [7]
						5, -- [8]
						"1984", -- [9]
						["id"] = 2063,
					},
					["153991"] = {
						"153991", -- [1]
						"Timer153991cd", -- [2]
						"~Torn Spirits", -- [3]
						25.5, -- [4]
						237563, -- [5]
						"cd", -- [6]
						153991, -- [7]
						1, -- [8]
						"1186", -- [9]
						["id"] = 1685,
					},
					["323687"] = {
						"323687", -- [1]
						"Timer323687cd", -- [2]
						"~Arcane Lightning", -- [3]
						7.2, -- [4]
						136099, -- [5]
						"cd", -- [6]
						323687, -- [7]
						3, -- [8]
						"2398", -- [9]
						["id"] = 2400,
					},
					["332318"] = {
						"332318", -- [1]
						"Timer332318cdcount	1", -- [2]
						"~Stomp (1)", -- [3]
						18.2, -- [4]
						136025, -- [5]
						"cdcount", -- [6]
						332318, -- [7]
						3, -- [8]
						"2394", -- [9]
						["id"] = 2399,
					},
					["197776"] = {
						"197776", -- [1]
						"Timer197776cd", -- [2]
						"~Fel Fissure", -- [3]
						5, -- [4]
						1118738, -- [5]
						"cd", -- [6]
						197776, -- [7]
						3, -- [8]
						"1499", -- [9]
						["id"] = 1828,
					},
				},
				["encounter_timers_bw"] = {
					["323437"] = {
						"Lord Chamberlain", -- [1]
						"323437", -- [2]
						"Stigma of Pride", -- [3]
						41, -- [4]
						538039, -- [5]
						["id"] = 2381,
					},
					["322943"] = {
						"Halkias, the Sin-Stained Goliath", -- [1]
						"322943", -- [2]
						"Heave Debris", -- [3]
						12, -- [4]
						1500971, -- [5]
						["id"] = 2401,
					},
					["329104"] = {
						"Lord Chamberlain", -- [1]
						"329104", -- [2]
						"Door of Shadows", -- [3]
						25, -- [4]
						134430, -- [5]
						["id"] = 2381,
					},
					["329340"] = {
						"High Adjudicator Aleez", -- [1]
						"329340", -- [2]
						"Anima Fountain", -- [3]
						22, -- [4]
						1392546, -- [5]
						["id"] = 2403,
					},
					["323236"] = {
						"Lord Chamberlain", -- [1]
						"323236", -- [2]
						"Unleashed Suffering", -- [3]
						15.5, -- [4]
						1035037, -- [5]
						["id"] = 2381,
					},
					["319941"] = {
						"Echelon", -- [1]
						"319941", -- [2]
						"Stone Shattering Leap", -- [3]
						23.5, -- [4]
						1016245, -- [5]
						["id"] = 2380,
					},
					["323650"] = {
						"High Adjudicator Aleez", -- [1]
						"323650", -- [2]
						"Haunting Fixation", -- [3]
						16, -- [4]
						841379, -- [5]
						["id"] = 2403,
					},
					["328206"] = {
						"Echelon", -- [1]
						"328206", -- [2]
						"Curse of Stone", -- [3]
						22, -- [4]
						516666, -- [5]
						["id"] = 2380,
					},
					["323150"] = {
						"Lord Chamberlain", -- [1]
						"323150", -- [2]
						"Telekinetic Toss", -- [3]
						6, -- [4]
						136243, -- [5]
						["id"] = 2381,
					},
					["328791"] = {
						"Lord Chamberlain", -- [1]
						"328791", -- [2]
						"Ritual of Woe", -- [3]
						36, -- [4]
						237536, -- [5]
						["id"] = 2381,
					},
					["323552"] = {
						"High Adjudicator Aleez", -- [1]
						"323552", -- [2]
						"Volley of Power", -- [3]
						12, -- [4]
						1394887, -- [5]
						["id"] = 2403,
					},
					["326389"] = {
						"Echelon", -- [1]
						"326389", -- [2]
						"Blood Torrent", -- [3]
						9.5, -- [4]
						1394887, -- [5]
						["id"] = 2380,
					},
					["322711"] = {
						"Halkias, the Sin-Stained Goliath", -- [1]
						"322711", -- [2]
						"Beams", -- [3]
						31, -- [4]
						537468, -- [5]
						["id"] = 2401,
					},
					["319733"] = {
						"Echelon", -- [1]
						"319733", -- [2]
						"Stone Call", -- [3]
						15.5, -- [4]
						463493, -- [5]
						["id"] = 2380,
					},
				},
			},
			["tutorial"] = {
				["unlock_button"] = 4,
				["main_help_button"] = 4148,
				["logons"] = 4148,
				["ENCOUNTER_BREAKDOWN_CHART"] = true,
				["ctrl_click_close_tutorial"] = false,
				["DISABLE_ONDEATH_PANEL"] = true,
				["ENCOUNTER_BREAKDOWN_PHASES"] = true,
				["FORGE_TUTORIAL"] = true,
				["ENCOUNTER_BREAKDOWN_SPELLAURAS"] = true,
				["alert_frames"] = {
					false, -- [1]
					false, -- [2]
					false, -- [3]
					false, -- [4]
					false, -- [5]
					false, -- [6]
				},
				["WINDOW_LOCK_UNLOCK1"] = true,
				["OVERALLDATA_WARNING1"] = 8,
				["DETAILS_INFO_TUTORIAL2"] = 10,
				["version_announce"] = 0,
				["HISTORYPANEL_TUTORIAL"] = true,
				["MIN_COMBAT_TIME"] = true,
				["bookmark_tutorial"] = false,
				["DETAILS_INFO_TUTORIAL1"] = true,
			},
			["spell_school_cache"] = {
				["Call to Chaos"] = 32,
				["Plague Seed"] = 32,
				["Shadow Word: Pain"] = 32,
				["Arcane Sphere"] = 64,
				["Triple Bite"] = 8,
				["Echo Finger Laser X-treme"] = 4,
				["Fire Bolt"] = 4,
				["Strike"] = 1,
				["Aerial Rocket Chicken Barrage"] = 4,
				["Ravenous Feast"] = 1,
				["Heart Hemorrhage"] = 32,
				["Energy Bolt"] = 64,
				["Blazing Touch"] = 4,
				["Illidan's Sightless Gaze"] = 4,
				["Holy Word: Chastise"] = 2,
				["Feeding Time"] = 1,
				["Brambles"] = 8,
				["Frost Strike Off-Hand"] = 16,
				["Heedless Charge"] = 1,
				["Jagged Swipe"] = 1,
				["Kill Command"] = 1,
				["Dark Recital"] = 32,
				["Sorrowful Wail"] = 32,
				["Stab"] = 1,
				["Soul Flay"] = 32,
				["Carnage"] = 1,
				["Shrapnel Blast"] = 1,
				["Dark Devastation"] = 32,
				["Phoenix Flames"] = 4,
				["Dark Fissure"] = 32,
				["Corrupting Maw"] = 32,
				["Firebloom"] = 4,
				["Infectious Rain"] = 8,
				["Withergrove Shardling"] = 32,
				["Armageddon Rain"] = 4,
				["Crunch"] = 1,
				["Shadow Ball"] = 32,
				["Serrated Tear"] = 1,
				["Death Bolt"] = 32,
				["Indemnification"] = 32,
				["Poison"] = 8,
				["Serpent Sting"] = 8,
				["Deadly Bargain"] = 32,
				["Iron Shackles"] = 1,
				["Comet Storm"] = 16,
				["Light Infusion"] = 2,
				["Embalming Ichor"] = 40,
				["Dark Bolt"] = 32,
				["Avalanche"] = 16,
				["Plague Rot"] = 8,
				["Lingering Doubt"] = 64,
				["Victory Rush"] = 1,
				["Pulverizing Meteor"] = 8,
				["Blazing Nova"] = 4,
				["Necrotic Breath"] = 32,
				["Grab"] = 1,
				["Blastwire"] = 4,
				["Pool of Shadows"] = 32,
				["Replicated Anima"] = 32,
				["Talon Rake"] = 1,
				["Burning Maw"] = 4,
				["Molten Remnants"] = 4,
				["Pierce"] = 1,
				["Remorseless Winter"] = 16,
				["Tortured Echoes"] = 32,
				["Blackout Kick"] = 1,
				["Carnivorous Bite"] = 1,
				["Web"] = 1,
				["Poison Bomb"] = 8,
				["Mangle"] = 1,
				["Starfire"] = 64,
				["Lingering Wail"] = 32,
				["Sins of the Past"] = 32,
				["Fanning the Flames"] = 4,
				["Power Overwhelming"] = 64,
				["Withering Touch"] = 8,
				["Anima Shedding"] = 1,
				["Ripple of Darkness"] = 32,
				["Unleashed Rage"] = 32,
				["Bestial Wrath"] = 1,
				["Horrified"] = 32,
				["Impale"] = 1,
				["Putrid Bile"] = 8,
				["Rake"] = 1,
				["Anima Fountain"] = 32,
				["Overwhelming Power!"] = 64,
				["Collapsing World"] = 32,
				["Aerial Bombardment"] = 32,
				["Stonequake"] = 1,
				["Crystalline Burst"] = 8,
				["Insatiable Hunger"] = 1,
				["Shattering Chain"] = 1,
				["Tiro-Autom�tico"] = 1,
				["Empowered Flare"] = 4,
				["Wracking Pain"] = 32,
				["Drain Essence"] = 32,
				["Blood Barrage"] = 32,
				["Impaling Harpoon"] = 1,
				["Liquefying Ooze"] = 8,
				["Cobra Shot"] = 1,
				["Crumbling Foundation"] = 1,
				["Energize"] = 4,
				["Ghostly Charge"] = 32,
				["Shoot"] = 1,
				["Juggernaut Rush"] = 1,
				["Howling Blast"] = 16,
				["Gash"] = 1,
				["High Explosive Sheep"] = 4,
				["Fel Bombardment"] = 4,
				["Murder Prey"] = 1,
				["Infernal Rockets"] = 4,
				["Arcanic Oubliette"] = 96,
				["Reverberating Eruption"] = 8,
				["Turbulent Anima"] = 32,
				["Hand of Destruction"] = 32,
				["Crimson Flurry"] = 1,
				["Plague Annihilation"] = 40,
				["Shadow Blades"] = 32,
				["Massacre"] = 32,
				["Shared Suffering"] = 32,
				["Piercing Barb"] = 32,
				["Ravage"] = 32,
				["Ground Pound"] = 1,
				["Indignation"] = 1,
				["Whirling Saber"] = 4,
				["Reaping Scythe"] = 1,
				["Debilitating Poison"] = 8,
				["Storming"] = 8,
				["Sear"] = 4,
				["Lingering Eruption"] = 32,
				["Burning Flash"] = 4,
				["Destructive Impact"] = 1,
				["Infernal Spike"] = 4,
				["Sleep Canister"] = 8,
				["Dirge of the Fallen Sanctum"] = 8,
				["Death Blow"] = 32,
				["Sludge Bolt"] = 8,
				["Echoing Smash"] = 1,
				["Armageddon Hail"] = 1,
				["Molten Aura"] = 4,
				["Dusk Elegy"] = 32,
				["Twilight Glaive"] = 32,
				["Stone Shards"] = 8,
				["Slam"] = 1,
				["Turned to Stone"] = 1,
				["Sundering Doom"] = 32,
				["Pyroblast"] = 4,
				["Jaws of Stone"] = 1,
				["Goblin Dragon Gun"] = 4,
				["Lash Out"] = 1,
				["Unstable Affliction"] = 32,
				["Bramble Patch"] = 8,
				["Magnetic Shroud"] = 8,
				["Telekinetic Collision"] = 1,
				["Shadow Rune"] = 32,
				["Rending Charge"] = 1,
				["Shredding Claws"] = 1,
				["Painful Memories"] = 32,
				["Venomfangs"] = 8,
				["Shattered"] = 8,
				["Retribution Aura"] = 2,
				["Shadow Word: Death"] = 32,
				["Dark Exile"] = 32,
				["Carbonation"] = 16,
				["Holy Shield"] = 2,
				["Anima Surge"] = 64,
				["Fists of Fury Strike"] = 4,
				["Ferocious Claw"] = 1,
				["Furlwind"] = 1,
				["Crushing Embrace"] = 1,
				["Death Grasp"] = 32,
				["Pulse Grenade"] = 8,
				["Smack"] = 1,
				["Fulminating Burst"] = 4,
				["Unstable Footing"] = 8,
				["Drain Soul"] = 32,
				["Searing Death"] = 32,
				["Spectral Bolt"] = 32,
				["Frost Fever"] = 16,
				["Final Say"] = 32,
				["Claw"] = 1,
				["Flare"] = 64,
				["Smoldering Ire"] = 32,
				["Cluster Bombardment"] = 32,
				["Bruising Strike"] = 1,
				["Lightning Breath"] = 8,
				["Fatal Finesse"] = 32,
				["Burning Remnant"] = 4,
				["Soulless"] = 32,
				["Ball of Fire"] = 4,
				["Festering Rot"] = 40,
				["Sintouched Anima"] = 32,
				["Crushed Soul"] = 32,
				["Gathering Power"] = 4,
				["Lingering Embers"] = 4,
				["Rain of Fire"] = 4,
				["Inevitable"] = 1,
				["Mind Link"] = 32,
				["Black Winds"] = 32,
				["Charged Anima"] = 64,
				["Echos of Carnage"] = 32,
				["Corpse Breath"] = 32,
				["Fulminating Pulse"] = 4,
				["Frozen Binds"] = 16,
				["Consume"] = 32,
				["Greater Castigation"] = 32,
				["Befouling Ink"] = 32,
				["Armageddon Blast"] = 4,
				["Viral Globs"] = 8,
				["Fragments of Shadow"] = 32,
				["Surging Anima"] = 64,
				["Blade Dance"] = 1,
				["Cartilaginous Legs"] = 32,
				["Unbound Cosmos"] = 32,
				["Withered Winds"] = 8,
				["Fel Infusion"] = 4,
				["Bloodbound"] = 1,
				["Inexorable Assault"] = 16,
				["Collapsing Fissure"] = 32,
				["Meat Hook"] = 1,
				["Waltz of Blood"] = 32,
				["Corrupted Blood"] = 32,
				["Hydra Acid"] = 8,
				["Earthgrab"] = 1,
				["Ignite"] = 4,
				["Rapid Infection"] = 8,
				["Shadow Burst"] = 32,
				["Twisted Pain"] = 1,
				["Burning Maul"] = 4,
				["Rocket Launch"] = 4,
				["Ring of Malice"] = 32,
				["Vanquished"] = 1,
				["Parasitic Incapacitation"] = 1,
				["Shocked"] = 4,
				["Mantid Munition Explosion"] = 4,
				["Loose Anima"] = 32,
				["Fall of the Unworthy"] = 1,
				["Life Link"] = 1,
				["Chaos Pulse"] = 4,
				["Thrash"] = 1,
				["Bleeding"] = 1,
				["Rain of the Destroyer"] = 4,
				["Power Word: Radiance"] = 2,
				["Smoldering Remnants"] = 4,
				["Wild Bite"] = 1,
				["Disgusting Guts"] = 40,
				["Obliterating Rift"] = 32,
				["Vile Gas"] = 40,
				["Slime Wave"] = 8,
				["Oppressive Atmosphere"] = 32,
				["Blood Torrent"] = 32,
				["Soul Eruption"] = 32,
				["Melee"] = 1,
				["Shattering Strike"] = 8,
				["Kitten Claws"] = 1,
				["Alone in the Darkness"] = 32,
				["Arcane Lightning"] = 64,
				["Deathbolt Rift"] = 32,
				["Touch of Anguish"] = 32,
				["Rupturing Singularity"] = 64,
				["Bursting Ooze"] = 1,
				["Entanglement"] = 8,
				["Descent"] = 1,
				["Ritual of Bones"] = 32,
				["Spinning Crane Kick"] = 1,
				["Thunderstorm"] = 8,
				["Rotting"] = 8,
				["Bloodletting Pounce"] = 1,
				["Destabilize"] = 1,
				["Sanctified Ground"] = 2,
				["Queensguard's Vigil"] = 8,
				["Obliterate"] = 1,
				["Rupturing Slam"] = 1,
				["Frost Strike"] = 16,
				["Chain Link"] = 1,
				["Conflagrate"] = 4,
				["Volcanic Plume"] = 4,
				["Finishing Blow"] = 1,
				["Exsanguinating Bite"] = 1,
				["Taeshalach's Reach"] = 1,
				["Annihilation"] = 4,
				["Shared Pain"] = 32,
				["Phantasmal Parasite"] = 32,
				["Echoing Annihilation"] = 8,
				["Ferment"] = 1,
				["Wicked Slice"] = 32,
				["Jagged Gash"] = 1,
				["Disease Cloud"] = 40,
				["Jagged Abrasion"] = 1,
				["Sha Spike"] = 32,
				["Seismic Upheaval"] = 8,
				["Fel Pool"] = 4,
				["Sinseeker"] = 32,
				["Mind Flay"] = 32,
				["Desolation"] = 32,
				["Manifest Pain"] = 32,
				["Anima Puddle"] = 8,
				["Colossal Roar"] = 1,
				["Deep Wounds"] = 1,
				["Shattering Scream"] = 32,
				["Pestilence Bolt"] = 8,
				["Fetid Bite"] = 8,
				["Omen of Death"] = 32,
				["Unchecked Rage"] = 1,
				["Gluttonous Miasma"] = 32,
				["Swift Slash"] = 1,
				["Evasive Lunge"] = 1,
				["Echoing Blast"] = 8,
				["Shackle the Unworthy"] = 64,
				["Colossus Smash"] = 1,
				["Tantrum"] = 1,
				["Soul Singe"] = 32,
				["Shadow Burn"] = 32,
				["Brutal Strike"] = 1,
				["Magma Eruption"] = 4,
				["Rapid Fire"] = 1,
				["Wicked Blast"] = 32,
				["Stone Shattering Leap"] = 8,
				["Fount of Pestilence"] = 8,
				["Wicked Laceration"] = 1,
				["Anima Web"] = 32,
				["Smash"] = 1,
				["Chaos Flames"] = 124,
				["Diabolic Bomb"] = 32,
				["Ritual of Woe"] = 32,
				["Iron Spikes"] = 1,
				["Strafing Run"] = 4,
				["Peck"] = 1,
				["Erupt"] = 8,
				["Empowered Portal: Xoroth"] = 4,
				["Body Slam"] = 1,
				["Fel Squall"] = 4,
				["Aura of Dread"] = 32,
				["Grim Venom"] = 8,
				["Soul Vessel"] = 32,
				["Frigid Cold"] = 16,
				["Thunderclap"] = 8,
				["Shared Cognition"] = 32,
				["Stoke the Flames"] = 4,
				["Ring of Fire"] = 4,
				["Bottled Anima"] = 32,
				["Displacement Trap"] = 1,
				["Briarskin"] = 8,
				["Anima Field"] = 64,
				["Agitated Water"] = 16,
				["Anima Toxin"] = 8,
				["Dark Stride"] = 1,
				["Immediate Extermination"] = 32,
				["Displaced Blastwave"] = 64,
				["Falling Rubble"] = 1,
				["Icebound Aegis"] = 16,
				["Necrotic Pitch"] = 32,
				["Hallowed Ground"] = 2,
				["Fel Eruption"] = 32,
				["Dissonance"] = 32,
				["Collapsing Foundation"] = 1,
				["Sanguine Ichor"] = 32,
				["Blood Price"] = 32,
				["Razorice"] = 16,
				["Corrupt Aegis"] = 4,
				["Wake of Flame"] = 4,
				["Lightning Shield"] = 8,
				["Heave Debris"] = 1,
				["A Murder of Crows"] = 1,
				["Stone Spike"] = 1,
				["Soul Infusion"] = 32,
				["Bite"] = 1,
				["Conflagration"] = 4,
				["Bursting Dreadflame"] = 4,
				["Cleaving Strike"] = 1,
				["Tormented Eruption"] = 4,
				["Focused Dreadburst"] = 4,
				["Screeching Swarm"] = 32,
				["Downward Strike"] = 1,
				["Oozing Outbreak"] = 8,
				["Acid Globule"] = 8,
				["Hammer of Creation"] = 2,
				["Manifest Death"] = 32,
				["Smoldering Plumage"] = 4,
				["Eye of Dread"] = 32,
				["Refracted Sinlight"] = 32,
				["Cannon"] = 1,
				["Hungering Drain"] = 32,
				["Cosmic Collapse"] = 32,
				["Exsanguinated"] = 1,
				["Hopelessness"] = 32,
				["Frostbolt Volley"] = 16,
				["Castigate"] = 32,
				["Obliterate Off-Hand"] = 1,
				["Maul"] = 1,
				["Chill of the Beyond"] = 32,
				["Void Devastation"] = 32,
				["Sunfire"] = 8,
				["Empowered Portal: Nathreza"] = 32,
				["Dread Orb"] = 32,
				["Void Blast"] = 32,
				["Localized Explosive Contrivance"] = 64,
				["Lunar Strike"] = 64,
				["Petrifying Howl"] = 8,
				["Flames of the Forge"] = 4,
				["Burning Remnants"] = 4,
				["Reverberating Vulnerability"] = 1,
				["Arcane Shot"] = 64,
				["Spectral Glaive"] = 96,
				["Chi Wave"] = 8,
				["Echoing Screech"] = 1,
				["Torment of Flames"] = 4,
				["Earsplitting Shriek"] = 1,
				["Savage Flurry"] = 1,
				["Seared Skin"] = 4,
				["Ricocheting Blade"] = 1,
				["Charged Blasts"] = 4,
				["Stomp"] = 1,
				["Fetid Spit"] = 8,
				["Whirlwind"] = 1,
				["Slimy Morsel"] = 1,
				["Growing Pride"] = 32,
				["Vicious Wound"] = 1,
				["Deathshade Volley"] = 32,
				["Necrotic Ichor"] = 32,
				["Decomposing Acid"] = 8,
				["Soul Split"] = 32,
				["Fire Blast"] = 4,
				["Bladestorm"] = 1,
				["Warped Desires"] = 32,
				["Shadow Ambush"] = 32,
				["Rancor"] = 32,
				["Reverberating Leap"] = 1,
				["Smoldering Stygia"] = 4,
				["Pulse from Beyond"] = 32,
				["Cleave"] = 1,
				["Auto Shot"] = 1,
				["Templar's Verdict"] = 2,
				["Prideful Eruption"] = 32,
				["Choking Shadow"] = 32,
				["Corpo-a-Corpo"] = 1,
				["Shattering Pain"] = 32,
				["Freezing Burst"] = 16,
				["Purifying Blast"] = 64,
				["Scorch"] = 4,
				["Carrot Breath"] = 1,
				["Valiant Strike"] = 1,
				["Moon Burn"] = 64,
				["Dart"] = 1,
				["Residue"] = 32,
				["Quietus Strike"] = 1,
				["Giant Fists"] = 1,
				["Quietus"] = 32,
				["Consecrated Light"] = 2,
				["Moonfire"] = 64,
				["Apocalypse Blast"] = 4,
				["Pinning Shot"] = 1,
				["Suffocating Dark"] = 32,
				["Touch of the Grave"] = 32,
				["The Jailer's Mark"] = 32,
				["Echoing Eruption"] = 8,
				["Shadowcore Oil Blast"] = 32,
				["Curse of Obliteration"] = 32,
				["Meteor Swarm"] = 4,
				["Venomblades"] = 8,
				["Hot!"] = 4,
				["Anima Spit"] = 2,
				["Lumbering Swipe"] = 1,
				["Frost Shock"] = 16,
				["Hydra Shot"] = 1,
				["Fetid Gas"] = 8,
				["Deep Connection"] = 64,
				["Crescendo"] = 32,
				["Shadow Shot"] = 32,
				["Barbed Shot"] = 1,
				["Tail Sweep"] = 1,
				["Shattered Conduits"] = 64,
				["Stream of Blades"] = 1,
				["Acid Expulsion"] = 8,
				["Luring Destruction"] = 4,
				["Gravity Lapse"] = 64,
				["Coagulating Ooze"] = 40,
				["Ravenous Blaze"] = 4,
				["Rotten Strike"] = 8,
				["Dark Eclipse"] = 32,
				["Crush Armor"] = 1,
				["Dimensional Tear"] = 64,
				["Unchecked Flame"] = 4,
				["Buzz-Saw"] = 1,
				["Assassinate"] = 8,
				["Echoing Sonar"] = 1,
				["Crashing Comet"] = 4,
				["Razorshard Ice"] = 16,
				["Quick Strike"] = 1,
				["Essence Absorption"] = 32,
				["Deathspike"] = 32,
				["Shattered Dominion"] = 32,
				["Decay"] = 32,
				["Slime Lunge"] = 1,
				["Bruise"] = 1,
				["Unstable Soul"] = 4,
				["Scorn"] = 32,
				["Shadow Storm"] = 32,
				["Ruiner"] = 4,
				["Volatile Ejection"] = 32,
				["Death Shroud"] = 32,
				["Dark Claw"] = 32,
				["Infernal Detonation"] = 4,
				["Empowered Portal: Rancora"] = 8,
				["Shattering Ruby"] = 1,
				["Overload"] = 64,
				["Possession"] = 32,
				["Terrifying Chaos"] = 32,
				["Double Strike"] = 1,
				["Unleashed Shadow"] = 32,
				["Splintered Heart of Al'ar"] = 4,
				["Archon's Bastion"] = 1,
				["Burn"] = 4,
				["Stasis Trap"] = 64,
				["Ravenous Swipe"] = 1,
				["Unchecked Growth"] = 8,
				["Dark Spin"] = 1,
				["Wrath"] = 8,
				["Spilled Essence"] = 32,
				["Night Hunter"] = 1,
				["Empowered Shrapnel Blast"] = 4,
				["Storm of Darkness"] = 32,
				["Seeds of Sorrow"] = 8,
				["Unleashed Flames"] = 4,
				["Shattering Stone"] = 8,
				["Calcified Quills"] = 1,
				["Burden of Sin"] = 32,
				["Eternal Skirmish"] = 32,
				["Touch of Slime"] = 8,
				["Glass Shards"] = 1,
				["Sense of Dread"] = 32,
				["Tornado Slam"] = 1,
				["Concentrated Anima"] = 32,
				["Master of Death"] = 32,
				["Quills"] = 1,
				["Feedback Overload"] = 4,
				["Heart Strike"] = 1,
				["Latent Eruption"] = 32,
				["Throw Axe"] = 1,
				["Frenzied Assault"] = 1,
				["Oopsie"] = 8,
				["Enveloping Webbing"] = 8,
				["Mortal Strike"] = 1,
				["Smouldering"] = 4,
				["Fireball"] = 4,
				["Wrong Moves"] = 32,
				["Eruption"] = 4,
				["Lingering Anima"] = 32,
				["Shuriken Storm"] = 1,
				["Noxious Fog"] = 40,
				["Mandible Strike"] = 8,
				["Valiant Bolt"] = 64,
				["Soul Anguish"] = 32,
				["Consumption"] = 32,
				["Unleashed Anima"] = 64,
				["Necrotic Bolt"] = 32,
				["Consume Slime"] = 1,
				["Divine Storm"] = 2,
				["Soul Rot"] = 32,
				["Fire Bomb"] = 4,
				["Anima Rejection"] = 8,
				["Dread Cleave"] = 32,
				["Wicked Bolt"] = 32,
				["Overcharged Soul"] = 8,
				["Hungering Strikes"] = 32,
				["Crimson Chorus"] = 32,
				["Crushing Fear"] = 32,
				["Acid Bomb"] = 8,
				["Soul Spikes"] = 32,
				["Expunge"] = 32,
				["Explosive Contrivance"] = 64,
				["Hew"] = 1,
				["Immolation Aura"] = 4,
				["Unleashed Volatility"] = 32,
				["Soultaint"] = 1,
				["Divert Power"] = 4,
				["Seismic Leap"] = 1,
				["Essence Extraction"] = 32,
				["Noxious Spores"] = 40,
				["Whispers of the Dark Star"] = 32,
				["Shock Grenade"] = 4,
				["Highly Concentrated Anima"] = 32,
				["Concentrated Plague"] = 8,
				["Glyph of Destruction"] = 64,
				["Engorge"] = 32,
				["Entropic Blast"] = 4,
				["Container Breach"] = 32,
			},
			["deathlog_healingdone_min"] = 1,
			["exit_log"] = {
				"1 - Closing Janela Info.", -- [1]
				"2 - Clearing user place from instances.", -- [2]
				"4 - Reversing switches.", -- [3]
				"6 - Saving Config.", -- [4]
				"7 - Saving Profiles.", -- [5]
				"8 - Saving nicktag cache.", -- [6]
			},
			["mythic_plus"] = {
				["make_overall_boss_only"] = false,
				["mythicrun_chart_frame"] = {
				},
				["merge_boss_trash"] = true,
				["delay_to_show_graphic"] = 5,
				["always_in_combat"] = false,
				["make_overall_when_done"] = true,
				["delete_trash_after_merge"] = true,
				["show_damage_graphic"] = true,
				["mythicrun_chart_frame_ready"] = {
				},
				["boss_dedicated_segment"] = true,
				["mythicrun_chart_frame_minimized"] = {
				},
				["last_mythicrun_chart"] = {
				},
			},
			["custom"] = {
				{
					["source"] = false,
					["author"] = "Details!",
					["desc"] = "Show who in your raid used a potion during the encounter.",
					["icon"] = "Interface\\ICONS\\INV_Potion_03",
					["attribute"] = false,
					["name"] = "Potion Used",
					["script"] = "				--init:\n				local combat, instance_container, instance = ...\n				local total, top, amount = 0, 0, 0\n				\n				--get the misc actor container\n				local misc_container = combat:GetActorList ( DETAILS_ATTRIBUTE_MISC )\n				\n				--do the loop:\n				for _, player in ipairs ( misc_container ) do \n					\n					--only player in group\n					if (player:IsGroupPlayer()) then\n						\n						local found_potion = false\n						\n						--get the spell debuff uptime container\n						local debuff_uptime_container = player.debuff_uptime and player.debuff_uptime_spells and player.debuff_uptime_spells._ActorTable\n						if (debuff_uptime_container) then\n							--potion of focus (can't use as pre-potion, so, its amount is always 1\n							local focus_potion = debuff_uptime_container [DETAILS_FOCUS_POTION_ID]\n							\n							if (focus_potion) then\n								total = total + 1\n								found_potion = true\n								if (top < 1) then\n									top = 1\n								end\n								--add amount to the player \n								instance_container:AddValue (player, 1)\n							end\n						end\n						\n						--get the spell buff uptime container\n						local buff_uptime_container = player.buff_uptime and player.buff_uptime_spells and player.buff_uptime_spells._ActorTable\n						if (buff_uptime_container) then\n							for spellId, _ in pairs (DetailsFramework.PotionIDs) do\n								local potionUsed = buff_uptime_container [spellId]\n				\n								if (potionUsed) then\n									local used = potionUsed.activedamt\n									if (used and used > 0) then\n										total = total + used\n										found_potion = true\n										if (used > top) then\n											top = used\n										end\n				\n										--add amount to the player \n										instance_container:AddValue (player, used)\n									end\n								end\n							end\n						end\n						\n						if (found_potion) then\n							amount = amount + 1\n						end    \n					end\n				end\n				\n				--return:\n				return total, top, amount\n				",
					["target"] = false,
					["tooltip"] = "			--init:\n			local player, combat, instance = ...\n			\n			--get the debuff container for potion of focus\n			local debuff_uptime_container = player.debuff_uptime and player.debuff_uptime_spells and player.debuff_uptime_spells._ActorTable\n			if (debuff_uptime_container) then\n				local focus_potion = debuff_uptime_container [DETAILS_FOCUS_POTION_ID]\n				if (focus_potion) then\n				local name, _, icon = GetSpellInfo (DETAILS_FOCUS_POTION_ID)\n				GameCooltip:AddLine (name, 1) --> can use only 1 focus potion (can't be pre-potion)\n				_detalhes:AddTooltipBackgroundStatusbar()\n				GameCooltip:AddIcon (icon, 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				end\n			end\n			\n			--get the misc actor container\n			local buff_uptime_container = player.buff_uptime and player.buff_uptime_spells and player.buff_uptime_spells._ActorTable\n			if (buff_uptime_container) then\n				for spellId, _ in pairs (DetailsFramework.PotionIDs) do\n					local potionUsed = buff_uptime_container [spellId]\n			\n					if (potionUsed) then\n						local name, _, icon = GetSpellInfo (spellId)\n						GameCooltip:AddLine (name, potionUsed.activedamt)\n						_detalhes:AddTooltipBackgroundStatusbar()\n						GameCooltip:AddIcon (icon, 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n					end\n				end\n			end\n			",
					["spellid"] = false,
					["script_version"] = 6,
				}, -- [1]
				{
					["source"] = false,
					["total_script"] = false,
					["author"] = "Details! Team",
					["percent_script"] = false,
					["desc"] = "Show who in your raid group used the healthstone or a heal potion.",
					["icon"] = "Interface\\ICONS\\INV_Stone_04",
					["spellid"] = false,
					["name"] = "Health Potion & Stone",
					["script"] = "			--get the parameters passed\n			local combat, instance_container, instance = ...\n			--declade the values to return\n			local total, top, amount = 0, 0, 0\n			\n			--do the loop\n			local AllHealCharacters = combat:GetActorList (DETAILS_ATTRIBUTE_HEAL)\n			for index, character in ipairs (AllHealCharacters) do\n				local AllSpells = character:GetSpellList()\n				local found = false\n				for spellid, spell in pairs (AllSpells) do\n					if (DETAILS_HEALTH_POTION_LIST [spellid]) then\n						instance_container:AddValue (character, spell.total)\n						total = total + spell.total\n						if (top < spell.total) then\n							top = spell.total\n						end\n						found = true\n					end\n				end\n			\n				if (found) then\n					amount = amount + 1\n				end\n			end\n			--loop end\n			--return the values\n			return total, top, amount\n			",
					["target"] = false,
					["tooltip"] = "			--get the parameters passed\n			local actor, combat, instance = ...\n			\n			--get the cooltip object (we dont use the convencional GameTooltip here)\n			local GameCooltip = GameCooltip\n			local R, G, B, A = 0, 0, 0, 0.75\n			\n			local hs = actor:GetSpell (6262)\n			if (hs) then\n				GameCooltip:AddLine (select (1, GetSpellInfo(6262)),  _detalhes:ToK(hs.total))\n				GameCooltip:AddIcon (select (3, GetSpellInfo (6262)), 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				GameCooltip:AddStatusBar (100, 1, R, G, B, A)\n			end\n			\n			local pot = actor:GetSpell (DETAILS_HEALTH_POTION_ID)\n			if (pot) then\n				GameCooltip:AddLine (select (1, GetSpellInfo(DETAILS_HEALTH_POTION_ID)),  _detalhes:ToK(pot.total))\n				GameCooltip:AddIcon (select (3, GetSpellInfo (DETAILS_HEALTH_POTION_ID)), 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				GameCooltip:AddStatusBar (100, 1, R, G, B, A)\n			end\n			\n			local pot = actor:GetSpell (DETAILS_REJU_POTION_ID)\n			if (pot) then\n				GameCooltip:AddLine (select (1, GetSpellInfo(DETAILS_REJU_POTION_ID)),  _detalhes:ToK(pot.total))\n				GameCooltip:AddIcon (select (3, GetSpellInfo (DETAILS_REJU_POTION_ID)), 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				GameCooltip:AddStatusBar (100, 1, R, G, B, A)\n			end\n\n			--Cooltip code\n			",
					["attribute"] = false,
					["script_version"] = 15,
				}, -- [2]
				{
					["source"] = false,
					["author"] = "Details!",
					["tooltip"] = "				\n			",
					["percent_script"] = "				local value, top, total, combat, instance = ...\n				return string.format (\"%.1f\", value/top*100)\n			",
					["desc"] = "Tells how much time each character spent doing damage.",
					["icon"] = "Interface\\Buttons\\UI-MicroStream-Red",
					["spellid"] = false,
					["name"] = "Damage Activity Time",
					["script"] = "				--init:\n				local combat, instance_container, instance = ...\n				local total, amount = 0, 0\n\n				--get the misc actor container\n				local damage_container = combat:GetActorList ( DETAILS_ATTRIBUTE_DAMAGE )\n				\n				--do the loop:\n				for _, player in ipairs ( damage_container ) do \n					if (player.grupo) then\n						local activity = player:Tempo()\n						total = total + activity\n						amount = amount + 1\n						--add amount to the player \n						instance_container:AddValue (player, activity)\n					end\n				end\n				\n				--return:\n				return total, combat:GetCombatTime(), amount\n			",
					["target"] = false,
					["total_script"] = "				local value, top, total, combat, instance = ...\n				local minutos, segundos = math.floor (value/60), math.floor (value%60)\n				return minutos .. \"m \" .. segundos .. \"s\"\n			",
					["attribute"] = false,
					["script_version"] = 3,
				}, -- [3]
				{
					["source"] = false,
					["author"] = "Details!",
					["tooltip"] = "				\n			",
					["percent_script"] = "				local value, top, total, combat, instance = ...\n				return string.format (\"%.1f\", value/top*100)\n			",
					["desc"] = "Tells how much time each character spent doing healing.",
					["icon"] = "Interface\\Buttons\\UI-MicroStream-Green",
					["spellid"] = false,
					["name"] = "Healing Activity Time",
					["script"] = "				--init:\n				local combat, instance_container, instance = ...\n				local total, top, amount = 0, 0, 0\n\n				--get the misc actor container\n				local damage_container = combat:GetActorList ( DETAILS_ATTRIBUTE_HEAL )\n				\n				--do the loop:\n				for _, player in ipairs ( damage_container ) do \n					if (player.grupo) then\n						local activity = player:Tempo()\n						total = total + activity\n						amount = amount + 1\n						--add amount to the player \n						instance_container:AddValue (player, activity)\n					end\n				end\n				\n				--return:\n				return total, combat:GetCombatTime(), amount\n			",
					["target"] = false,
					["total_script"] = "				local value, top, total, combat, instance = ...\n				local minutos, segundos = math.floor (value/60), math.floor (value%60)\n				return minutos .. \"m \" .. segundos .. \"s\"\n			",
					["attribute"] = false,
					["script_version"] = 2,
				}, -- [4]
				{
					["source"] = false,
					["author"] = "Details!",
					["desc"] = "Show the crowd control amount for each player.",
					["total_script"] = "				local value, top, total, combat, instance = ...\n				return floor (value)\n			",
					["icon"] = "Interface\\ICONS\\Spell_Frost_FreezingBreath",
					["spellid"] = false,
					["name"] = "Crowd Control Done",
					["tooltip"] = "				local actor, combat, instance = ...\n				local spells = {}\n				for spellid, spell in pairs (actor.cc_done_spells._ActorTable) do\n				    tinsert (spells, {spellid, spell.counter})\n				end\n\n				table.sort (spells, _detalhes.Sort2)\n\n				for index, spell in ipairs (spells) do\n				    local name, _, icon = GetSpellInfo (spell [1])\n				    GameCooltip:AddLine (name, spell [2])\n				    _detalhes:AddTooltipBackgroundStatusbar()\n				    GameCooltip:AddIcon (icon, 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				end\n\n				local targets = {}\n				for playername, amount in pairs (actor.cc_done_targets) do\n				    tinsert (targets, {playername, amount})\n				end\n\n				table.sort (targets, _detalhes.Sort2)\n\n				_detalhes:AddTooltipSpellHeaderText (\"Targets\", \"yellow\", #targets)\n				local class, _, _, _, _, r, g, b = _detalhes:GetClass (actor.nome)\n				_detalhes:AddTooltipHeaderStatusbar (1, 1, 1, 0.6)\n\n				for index, target in ipairs (targets) do\n				    GameCooltip:AddLine (target[1], target [2])\n				    _detalhes:AddTooltipBackgroundStatusbar()\n				    \n				    local class, _, _, _, _, r, g, b = _detalhes:GetClass (target [1])\n				    if (class and class ~= \"UNKNOW\") then\n					local texture, l, r, t, b = _detalhes:GetClassIcon (class)\n					GameCooltip:AddIcon (\"Interface\\\\AddOns\\\\Details\\\\images\\\\classes_small_alpha\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height, l, r, t, b)\n				    else\n					GameCooltip:AddIcon (\"Interface\\\\GossipFrame\\\\IncompleteQuestIcon\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				    end\n				    --\n				end\n			",
					["target"] = false,
					["script"] = "				local combat, instance_container, instance = ...\n				local total, top, amount = 0, 0, 0\n\n				local misc_actors = combat:GetActorList (DETAILS_ATTRIBUTE_MISC)\n\n				for index, character in ipairs (misc_actors) do\n					if (character.cc_done and character:IsPlayer()) then\n						local cc_done = floor (character.cc_done)\n						instance_container:AddValue (character, cc_done)\n						total = total + cc_done\n						if (cc_done > top) then\n							top = cc_done\n						end\n						amount = amount + 1\n					end\n				end\n\n				return total, top, amount\n			",
					["attribute"] = false,
					["script_version"] = 11,
				}, -- [5]
				{
					["source"] = false,
					["author"] = "Details!",
					["desc"] = "Show the amount of crowd control received for each player.",
					["total_script"] = "				local value, top, total, combat, instance = ...\n				return floor (value)\n			",
					["icon"] = "Interface\\ICONS\\Spell_Frost_ChainsOfIce",
					["spellid"] = false,
					["name"] = "Crowd Control Received",
					["tooltip"] = "				local actor, combat, instance = ...\n				local name = actor:name()\n				local spells, from = {}, {}\n				local misc_actors = combat:GetActorList (DETAILS_ATTRIBUTE_MISC)\n\n				for index, character in ipairs (misc_actors) do\n				    if (character.cc_done and character:IsPlayer()) then\n					local on_actor = character.cc_done_targets [name]\n					if (on_actor) then\n					    tinsert (from, {character:name(), on_actor})\n					    \n					    for spellid, spell in pairs (character.cc_done_spells._ActorTable) do\n						\n						local spell_on_actor = spell.targets [name]\n						if (spell_on_actor) then\n						    local has_spell\n						    for index, spell_table in ipairs (spells) do\n							if (spell_table [1] == spellid) then\n							    spell_table [2] = spell_table [2] + spell_on_actor\n							    has_spell = true\n							end\n						    end\n						    if (not has_spell) then\n							tinsert (spells, {spellid, spell_on_actor}) \n						    end\n						end\n						\n					    end            \n					end\n				    end\n				end\n\n				table.sort (from, _detalhes.Sort2)\n				table.sort (spells, _detalhes.Sort2)\n\n				for index, spell in ipairs (spells) do\n				    local name, _, icon = GetSpellInfo (spell [1])\n				    GameCooltip:AddLine (name, spell [2])\n				    _detalhes:AddTooltipBackgroundStatusbar()\n				    GameCooltip:AddIcon (icon, 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)    \n				end\n\n				_detalhes:AddTooltipSpellHeaderText (\"From\", \"yellow\", #from)\n				_detalhes:AddTooltipHeaderStatusbar (1, 1, 1, 0.6)\n\n				for index, t in ipairs (from) do\n				    GameCooltip:AddLine (t[1], t[2])\n				    _detalhes:AddTooltipBackgroundStatusbar()\n				    \n				    local class, _, _, _, _, r, g, b = _detalhes:GetClass (t [1])\n				    if (class and class ~= \"UNKNOW\") then\n					local texture, l, r, t, b = _detalhes:GetClassIcon (class)\n					GameCooltip:AddIcon (\"Interface\\\\AddOns\\\\Details\\\\images\\\\classes_small_alpha\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height, l, r, t, b)\n				    else\n					GameCooltip:AddIcon (\"Interface\\\\GossipFrame\\\\IncompleteQuestIcon\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				    end     \n				    \n				end\n			",
					["target"] = false,
					["script"] = "				local combat, instance_container, instance = ...\n				local total, top, amt = 0, 0, 0\n\n				local misc_actors = combat:GetActorList (DETAILS_ATTRIBUTE_MISC)\n				DETAILS_CUSTOM_CC_RECEIVED_CACHE = DETAILS_CUSTOM_CC_RECEIVED_CACHE or {}\n				wipe (DETAILS_CUSTOM_CC_RECEIVED_CACHE)\n\n				for index, character in ipairs (misc_actors) do\n				    if (character.cc_done and character:IsPlayer()) then\n					\n					for player_name, amount in pairs (character.cc_done_targets) do\n					    local target = combat (1, player_name) or combat (2, player_name)\n					    if (target and target:IsPlayer()) then\n						instance_container:AddValue (target, amount)\n						total = total + amount\n						if (amount > top) then\n						    top = amount\n						end\n						if (not DETAILS_CUSTOM_CC_RECEIVED_CACHE [player_name]) then\n						    DETAILS_CUSTOM_CC_RECEIVED_CACHE [player_name] = true\n						    amt = amt + 1\n						end\n					    end\n					end\n					\n				    end\n				end\n\n				return total, top, amt\n			",
					["attribute"] = false,
					["script_version"] = 3,
				}, -- [6]
				{
					["source"] = false,
					["tooltip"] = "			--config:\n			--Background RBG and Alpha:\n			local R, G, B, A = 0, 0, 0, 0.75\n			local R, G, B, A = 0.1960, 0.1960, 0.1960, 0.8697\n\n			--get the parameters passed\n			local spell, combat, instance = ...\n\n			--get the cooltip object (we dont use the convencional GameTooltip here)\n			local GC = GameCooltip\n			GC:SetOption (\"YSpacingMod\", 0)\n\n			local role = DetailsFramework.UnitGroupRolesAssigned (\"player\")\n\n			if (spell.n_dmg) then\n			    \n			    local spellschool, schooltext = spell.spellschool, \"\"\n			    if (spellschool) then\n				local t = _detalhes.spells_school [spellschool]\n				if (t and t.name) then\n				    schooltext = t.formated\n				end\n			    end\n			    \n			    local total_hits = spell.counter\n			    local combat_time = instance.showing:GetCombatTime()\n			    \n			    local debuff_uptime_total, cast_string = \"\", \"\"\n			    local misc_actor = instance.showing (4, _detalhes.playername)\n			    if (misc_actor) then\n				local debuff_uptime = misc_actor.debuff_uptime_spells and misc_actor.debuff_uptime_spells._ActorTable [spell.id] and misc_actor.debuff_uptime_spells._ActorTable [spell.id].uptime\n				if (debuff_uptime) then\n				    debuff_uptime_total = floor (debuff_uptime / instance.showing:GetCombatTime() * 100)\n				end\n				\n				local spell_cast = misc_actor.spell_cast and misc_actor.spell_cast [spell.id]\n				\n				if (not spell_cast and misc_actor.spell_cast) then\n				    local spellname = GetSpellInfo (spell.id)\n				    for casted_spellid, amount in pairs (misc_actor.spell_cast) do\n					local casted_spellname = GetSpellInfo (casted_spellid)\n					if (casted_spellname == spellname) then\n					    spell_cast = amount .. \" (|cFFFFFF00?|r)\"\n					end\n				    end\n				end\n				if (not spell_cast) then\n				    spell_cast = \"(|cFFFFFF00?|r)\"\n				end\n				cast_string = cast_string .. spell_cast\n			    end\n			    \n			    --Cooltip code\n			    GC:AddLine (\"Casts:\", cast_string or \"?\")\n			    GC:AddStatusBar (100, 1, R, G, B, A)\n			    \n			    if (debuff_uptime_total ~= \"\") then\n				GC:AddLine (\"Uptime:\", (debuff_uptime_total or \"?\") .. \"%\")\n				GC:AddStatusBar (100, 1, R, G, B, A)\n			    end\n			    \n			    GC:AddLine (\"Hits:\", spell.counter)\n			    GC:AddStatusBar (100, 1, R, G, B, A)\n			    \n			    local average = spell.total / total_hits\n			    GC:AddLine (\"Average:\", _detalhes:ToK (average))\n			    GC:AddStatusBar (100, 1, R, G, B, A)\n			    \n			    GC:AddLine (\"E-Dps:\", _detalhes:ToK (spell.total / combat_time))\n			    GC:AddStatusBar (100, 1, R, G, B, A)\n			    \n			    GC:AddLine (\"School:\", schooltext)\n			    GC:AddStatusBar (100, 1, R, G, B, A)\n			    \n			    --GC:AddLine (\" \")\n			    \n			    GC:AddLine (\"Normal Hits: \", spell.n_amt .. \" (\" ..floor ( spell.n_amt/total_hits*100) .. \"%)\")\n			    GC:AddStatusBar (100, 1, R, G, B, A)\n			    \n			    local n_average = spell.n_dmg / spell.n_amt\n			    local T = (combat_time*spell.n_dmg)/spell.total\n			    local P = average/n_average*100\n			    T = P*T/100\n			    \n			    GC:AddLine (\"Average / E-Dps: \",  _detalhes:ToK (n_average) .. \" / \" .. format (\"%.1f\",spell.n_dmg / T ))\n			    GC:AddStatusBar (100, 1, R, G, B, A)\n			    \n			    --GC:AddLine (\" \")\n			    \n			    GC:AddLine (\"Critical Hits: \", spell.c_amt .. \" (\" ..floor ( spell.c_amt/total_hits*100) .. \"%)\")\n			    GC:AddStatusBar (100, 1, R, G, B, A)\n			    \n			    if (spell.c_amt > 0) then\n				local c_average = spell.c_dmg/spell.c_amt\n				local T = (combat_time*spell.c_dmg)/spell.total\n				local P = average/c_average*100\n				T = P*T/100\n				local crit_dps = spell.c_dmg / T\n				\n				GC:AddLine (\"Average / E-Dps: \",  _detalhes:ToK (c_average) .. \" / \" .. _detalhes:comma_value (crit_dps))\n			    else\n				GC:AddLine (\"Average / E-Dps: \",  \"0 / 0\")    \n			    end\n			    \n			    GC:AddStatusBar (100, 1, R, G, B, A)\n\n			    \n			elseif (spell.n_curado) then\n			    \n			    local spellschool, schooltext = spell.spellschool, \"\"\n			    if (spellschool) then\n				local t = _detalhes.spells_school [spellschool]\n				if (t and t.name) then\n				    schooltext = t.formated\n				end\n			    end\n			    \n			    local total_hits = spell.counter\n			    local combat_time = instance.showing:GetCombatTime()\n			    \n			    --Cooltip code\n			    GC:AddLine (\"Hits:\", spell.counter)\n			    GC:AddStatusBar (100, 1, R, G, B, A)\n			    \n			    local average = spell.total / total_hits\n			    GC:AddLine (\"Average:\", _detalhes:ToK (average))\n			    GC:AddStatusBar (100, 1, R, G, B, A)\n			    \n			    GC:AddLine (\"E-Hps:\", _detalhes:ToK (spell.total / combat_time))\n			    GC:AddStatusBar (100, 1, R, G, B, A)\n			    \n			    GC:AddLine (\"School:\", schooltext)\n			    GC:AddStatusBar (100, 1, R, G, B, A)\n			    \n			    --GC:AddLine (\" \")\n			    \n			    GC:AddLine (\"Normal Hits: \", spell.n_amt .. \" (\" ..floor ( spell.n_amt/total_hits*100) .. \"%)\")\n			    GC:AddStatusBar (100, 1, R, G, B, A)\n			    \n			    local n_average = spell.n_curado / spell.n_amt\n			    local T = (combat_time*spell.n_curado)/spell.total\n			    local P = average/n_average*100\n			    T = P*T/100\n			    \n			    GC:AddLine (\"Average / E-Dps: \",  _detalhes:ToK (n_average) .. \" / \" .. format (\"%.1f\",spell.n_curado / T ))\n			    GC:AddStatusBar (100, 1, R, G, B, A)\n			    \n			    --GC:AddLine (\" \")\n			    \n			    GC:AddLine (\"Critical Hits: \", spell.c_amt .. \" (\" ..floor ( spell.c_amt/total_hits*100) .. \"%)\")\n			    GC:AddStatusBar (100, 1, R, G, B, A)\n			    \n			    if (spell.c_amt > 0) then\n				local c_average = spell.c_curado/spell.c_amt\n				local T = (combat_time*spell.c_curado)/spell.total\n				local P = average/c_average*100\n				T = P*T/100\n				local crit_dps = spell.c_curado / T\n				\n				GC:AddLine (\"Average / E-Hps: \",  _detalhes:ToK (c_average) .. \" / \" .. _detalhes:comma_value (crit_dps))\n			    else\n				GC:AddLine (\"Average / E-Hps: \",  \"0 / 0\")    \n			    end\n			    \n			    GC:AddStatusBar (100, 1, R, G, B, A)\n			end\n			",
					["percent_script"] = "				local value, top, total, combat, instance = ...\n				local dps = _detalhes:ToK (floor (value) / combat:GetCombatTime())\n				local percent = string.format (\"%.1f\", value/total*100)\n				return dps .. \", \" .. percent\n			",
					["desc"] = "Show your spells in the window.",
					["author"] = "Details!",
					["attribute"] = false,
					["name"] = "My Spells",
					["script"] = "				--get the parameters passed\n				local combat, instance_container, instance = ...\n				--declade the values to return\n				local total, top, amount = 0, 0, 0\n\n				local player\n				local pet_attribute\n				\n				local role = DetailsFramework.UnitGroupRolesAssigned (\"player\")\n				local spec = DetailsFramework.GetSpecialization()\n				role = spec and DetailsFramework.GetSpecializationRole (spec) or role\n\n				if (role == \"DAMAGER\") then\n					player = combat (DETAILS_ATTRIBUTE_DAMAGE, _detalhes.playername)\n					pet_attribute = DETAILS_ATTRIBUTE_DAMAGE\n				elseif (role == \"HEALER\") then    \n					player = combat (DETAILS_ATTRIBUTE_HEAL, _detalhes.playername)\n					pet_attribute = DETAILS_ATTRIBUTE_HEAL\n				else\n					player = combat (DETAILS_ATTRIBUTE_DAMAGE, _detalhes.playername)\n					pet_attribute = DETAILS_ATTRIBUTE_DAMAGE\n				end\n\n				--do the loop\n\n				if (player) then\n					local spells = player:GetSpellList()\n					for spellid, spell in pairs (spells) do\n						instance_container:AddValue (spell, spell.total)\n						total = total + spell.total\n						if (top < spell.total) then\n							top = spell.total\n						end\n						amount = amount + 1\n					end\n				    \n					for _, PetName in ipairs (player.pets) do\n						local pet = combat (pet_attribute, PetName)\n						if (pet) then\n							for spellid, spell in pairs (pet:GetSpellList()) do\n								instance_container:AddValue (spell, spell.total, nil, \" (\" .. PetName:gsub ((\" <.*\"), \"\") .. \")\")\n								total = total + spell.total\n								if (top < spell.total) then\n									top = spell.total\n								end\n								amount = amount + 1\n							end\n						end\n					end\n				end\n\n				--return the values\n				return total, top, amount\n			",
					["target"] = false,
					["spellid"] = false,
					["icon"] = "Interface\\CHATFRAME\\UI-ChatIcon-Battlenet",
					["script_version"] = 8,
				}, -- [7]
				{
					["source"] = false,
					["author"] = "Details!",
					["desc"] = "Show the amount of damage applied on targets marked with skull.",
					["icon"] = "Interface\\TARGETINGFRAME\\UI-RaidTargetingIcon_8",
					["attribute"] = false,
					["name"] = "Damage On Skull Marked Targets",
					["script"] = "				--get the parameters passed\n				local Combat, CustomContainer, Instance = ...\n				--declade the values to return\n				local total, top, amount = 0, 0, 0\n				\n				--raid target flags: \n				-- 128: skull \n				-- 64: cross\n				-- 32: square\n				-- 16: moon\n				-- 8: triangle\n				-- 4: diamond\n				-- 2: circle\n				-- 1: star\n				\n				--do the loop\n				for _, actor in ipairs (Combat:GetActorList (DETAILS_ATTRIBUTE_DAMAGE)) do\n				    if (actor:IsPlayer()) then\n					if (actor.raid_targets [128]) then\n					    CustomContainer:AddValue (actor, actor.raid_targets [128])\n					end        \n				    end\n				end\n\n				--if not managed inside the loop, get the values of total, top and amount\n				total, top = CustomContainer:GetTotalAndHighestValue()\n				amount = CustomContainer:GetNumActors()\n\n				--return the values\n				return total, top, amount\n			",
					["target"] = false,
					["tooltip"] = "				--get the parameters passed\n				local actor, combat, instance = ...\n\n				--get the cooltip object (we dont use the convencional GameTooltip here)\n				local GameCooltip = GameCooltip\n\n				--Cooltip code\n				local format_func = Details:GetCurrentToKFunction()\n\n				--Cooltip code\n				local RaidTargets = actor.raid_targets\n\n				local DamageOnStar = RaidTargets [128]\n				if (DamageOnStar) then\n				    --RAID_TARGET_8 is the built-in localized word for 'Skull'.\n				    GameCooltip:AddLine (RAID_TARGET_8 .. \":\", format_func (_, DamageOnStar))\n				    GameCooltip:AddIcon (\"Interface\\\\TARGETINGFRAME\\\\UI-RaidTargetingIcon_8\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				    Details:AddTooltipBackgroundStatusbar()\n				end\n			",
					["spellid"] = false,
					["script_version"] = 3,
				}, -- [8]
				{
					["source"] = false,
					["author"] = "Details!",
					["desc"] = "Show the amount of damage applied on targets marked with any other mark.",
					["icon"] = "Interface\\TARGETINGFRAME\\UI-RaidTargetingIcon_5",
					["attribute"] = false,
					["name"] = "Damage On Other Marked Targets",
					["script"] = "				--get the parameters passed\n				local Combat, CustomContainer, Instance = ...\n				--declade the values to return\n				local total, top, amount = 0, 0, 0\n\n				--do the loop\n				for _, actor in ipairs (Combat:GetActorList (DETAILS_ATTRIBUTE_DAMAGE)) do\n				    if (actor:IsPlayer()) then\n					local total = (actor.raid_targets [1] or 0) --star\n					total = total + (actor.raid_targets [2] or 0) --circle\n					total = total + (actor.raid_targets [4] or 0) --diamond\n					total = total + (actor.raid_targets [8] or 0) --tiangle\n					total = total + (actor.raid_targets [16] or 0) --moon\n					total = total + (actor.raid_targets [32] or 0) --square\n					total = total + (actor.raid_targets [64] or 0) --cross\n					\n					if (total > 0) then\n					    CustomContainer:AddValue (actor, total)\n					end\n				    end\n				end\n\n				--if not managed inside the loop, get the values of total, top and amount\n				total, top = CustomContainer:GetTotalAndHighestValue()\n				amount = CustomContainer:GetNumActors()\n\n				--return the values\n				return total, top, amount\n			",
					["target"] = false,
					["tooltip"] = "				--get the parameters passed\n				local actor, combat, instance = ...\n\n				--get the cooltip object\n				local GameCooltip = GameCooltip\n\n				local format_func = Details:GetCurrentToKFunction()\n\n				--Cooltip code\n				local RaidTargets = actor.raid_targets\n\n				local DamageOnStar = RaidTargets [1]\n				if (DamageOnStar) then\n				    GameCooltip:AddLine (RAID_TARGET_1 .. \":\", format_func (_, DamageOnStar))\n				    GameCooltip:AddIcon (\"Interface\\\\TARGETINGFRAME\\\\UI-RaidTargetingIcon_1\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				    Details:AddTooltipBackgroundStatusbar()\n				end\n\n				local DamageOnCircle = RaidTargets [2]\n				if (DamageOnCircle) then\n				    GameCooltip:AddLine (RAID_TARGET_2 .. \":\", format_func (_, DamageOnCircle))\n				    GameCooltip:AddIcon (\"Interface\\\\TARGETINGFRAME\\\\UI-RaidTargetingIcon_2\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				    Details:AddTooltipBackgroundStatusbar()\n				end\n\n				local DamageOnDiamond = RaidTargets [4]\n				if (DamageOnDiamond) then\n				    GameCooltip:AddLine (RAID_TARGET_3 .. \":\", format_func (_, DamageOnDiamond))\n				    GameCooltip:AddIcon (\"Interface\\\\TARGETINGFRAME\\\\UI-RaidTargetingIcon_3\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				    Details:AddTooltipBackgroundStatusbar()\n				end\n\n				local DamageOnTriangle = RaidTargets [8]\n				if (DamageOnTriangle) then\n				    GameCooltip:AddLine (RAID_TARGET_4 .. \":\", format_func (_, DamageOnTriangle))\n				    GameCooltip:AddIcon (\"Interface\\\\TARGETINGFRAME\\\\UI-RaidTargetingIcon_4\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				    Details:AddTooltipBackgroundStatusbar()\n				end\n\n				local DamageOnMoon = RaidTargets [16]\n				if (DamageOnMoon) then\n				    GameCooltip:AddLine (RAID_TARGET_5 .. \":\", format_func (_, DamageOnMoon))\n				    GameCooltip:AddIcon (\"Interface\\\\TARGETINGFRAME\\\\UI-RaidTargetingIcon_5\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				    Details:AddTooltipBackgroundStatusbar()\n				end\n\n				local DamageOnSquare = RaidTargets [32]\n				if (DamageOnSquare) then\n				    GameCooltip:AddLine (RAID_TARGET_6 .. \":\", format_func (_, DamageOnSquare))\n				    GameCooltip:AddIcon (\"Interface\\\\TARGETINGFRAME\\\\UI-RaidTargetingIcon_6\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				    Details:AddTooltipBackgroundStatusbar()\n				end\n\n				local DamageOnCross = RaidTargets [64]\n				if (DamageOnCross) then\n				    GameCooltip:AddLine (RAID_TARGET_7 .. \":\", format_func (_, DamageOnCross))\n				    GameCooltip:AddIcon (\"Interface\\\\TARGETINGFRAME\\\\UI-RaidTargetingIcon_7\", 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n				    Details:AddTooltipBackgroundStatusbar()\n				end\n			",
					["spellid"] = false,
					["script_version"] = 3,
				}, -- [9]
				{
					["source"] = false,
					["author"] = "Details!",
					["desc"] = "Damage done to shields",
					["icon"] = "Interface\\ICONS\\Spell_Holy_PowerWordShield",
					["attribute"] = false,
					["name"] = "Damage on Shields",
					["script"] = "				--get the parameters passed\n				local Combat, CustomContainer, Instance = ...\n				--declade the values to return\n				local total, top, amount = 0, 0, 0\n\n				--do the loop\n				for index, actor in ipairs (Combat:GetActorList(1)) do\n				    if (actor:IsPlayer()) then\n					\n					--get the actor total damage absorbed\n					local totalAbsorb = actor.totalabsorbed\n					\n					--get the damage absorbed by all the actor pets\n					for petIndex, petName in ipairs (actor.pets) do\n					    local pet = Combat :GetActor (1, petName)\n					    if (pet) then\n						totalAbsorb = totalAbsorb + pet.totalabsorbed\n					    end\n					end\n					\n					--add the value to the actor on the custom container\n					CustomContainer:AddValue (actor, totalAbsorb)        \n					\n				    end\n				end\n				--loop end\n\n				--if not managed inside the loop, get the values of total, top and amount\n				total, top = CustomContainer:GetTotalAndHighestValue()\n				amount = CustomContainer:GetNumActors()\n\n				--return the values\n				return total, top, amount\n			",
					["target"] = false,
					["tooltip"] = "				--get the parameters passed\n				local actor, Combat, instance = ...\n\n				--get the cooltip object (we dont use the convencional GameTooltip here)\n				local GameCooltip = GameCooltip\n\n				--Cooltip code\n				--get the actor total damage absorbed\n				local totalAbsorb = actor.totalabsorbed\n				local format_func = Details:GetCurrentToKFunction()\n\n				--get the damage absorbed by all the actor pets\n				for petIndex, petName in ipairs (actor.pets) do\n				    local pet = Combat :GetActor (1, petName)\n				    if (pet) then\n					totalAbsorb = totalAbsorb + pet.totalabsorbed\n				    end\n				end\n\n				GameCooltip:AddLine (actor:Name(), format_func (_, actor.totalabsorbed))\n				Details:AddTooltipBackgroundStatusbar()\n\n				for petIndex, petName in ipairs (actor.pets) do\n				    local pet = Combat :GetActor (1, petName)\n				    if (pet) then\n					totalAbsorb = totalAbsorb + pet.totalabsorbed\n					\n					GameCooltip:AddLine (petName, format_func (_, pet.totalabsorbed))\n					Details:AddTooltipBackgroundStatusbar()        \n					\n				    end\n				end\n			",
					["spellid"] = false,
					["script_version"] = 1,
				}, -- [10]
				{
					["source"] = false,
					["author"] = "Effecta-Stormrage",
					["percent_script"] = false,
					["total_script"] = false,
					["desc"] = "Number of CCs casted",
					["spellid"] = false,
					["name"] = "Crowd Control",
					["script"] = "							--get the parameters passed\n							local Combat, CustomContainer, Instance = ...\n							--declade the values to return\n							local total, top, amount = 0, 0, 0\n							\n							--do the loop\n								--CustomContainer:AddValue (actor, actor.value)\n							--loop end\n							\n							--if not managed inside the loop, get the values of total, top and amount\n							total, top = CustomContainer:GetTotalAndHighestValue()\n							amount = CustomContainer:GetNumActors()\n							\n							--return the values\n							return total, top, amount\n						",
					["target"] = false,
					["tooltip"] = "							--get the parameters passed\n							local actor, combat, instance = ...\n							\n							--get the cooltip object (we dont use the convencional GameTooltip here)\n							local GameCooltip = GameCooltip\n							\n							--Cooltip code\n						",
					["icon"] = 237579,
					["attribute"] = false,
				}, -- [11]
				{
					["source"] = false,
					["author"] = "Bass",
					["total_script"] = "        local value, top, total, Combat, Instance, Actor = ...\n\n        local format_func = Details:GetCurrentToKFunction()\n        if _G.Details_Elitism then\n            local damage, cnt = _G.Details_Elitism:GetRecord(Combat:GetCombatNumber(), Actor.my_actor.serial)\n            return \"\" .. format_func(_, damage) .. \" (\" .. cnt .. \")\"\n            -- return _G.Details_Elitism:GetDisplayText(Combat:GetCombatNumber(), Actor.my_actor.serial)\n        end\n        return \"\"\n    ",
					["desc"] = "Show how much avoidable damage was taken.",
					["attribute"] = false,
					["script"] = "        local Combat, CustomContainer, Instance = ...\n        local total, top, amount = 0, 0, 0\n\n        if _G.Details_Elitism then\n            local Container = Combat:GetActorList(DETAILS_ATTRIBUTE_MISC)\n            for _, player in ipairs(Container) do\n                if player:IsGroupPlayer() then\n                    -- we only record the players in party\n                    local damage, cnt = _G.Details_Elitism:GetRecord(Combat:GetCombatNumber(), player:guid())\n                    if damage > 0 or cnt > 0 then\n                        CustomContainer:AddValue(player, damage)\n                    end\n                end\n            end\n\n            total, top = CustomContainer:GetTotalAndHighestValue()\n            amount = CustomContainer:GetNumActors()\n        end\n\n        return total, top, amount\n    ",
					["name"] = "Avoidable Damage Taken",
					["tooltip"] = "        local Actor, Combat, Instance = ...\n        local GameCooltip = GameCooltip\n\n        if _G.Details_Elitism then\n            local realCombat\n            for i = -1, 25 do\n                local current = Details:GetCombat(i)\n                if current and current:GetCombatNumber() == Combat.combat_counter then\n                    realCombat = current\n                    break\n                end\n            end\n\n            if not realCombat then return end\n\n            local sortedList = {}\n            _, _, spells = _G.Details_Elitism:GetRecord(Combat:GetCombatNumber(), realCombat[1]:GetActor(Actor.nome):guid())\n            for spellID, spelldata in pairs(spells) do\n                tinsert(sortedList, {spellID, spelldata.sum})\n            end\n            -- local spellList = realCombat[1]:GetActor(Actor.nome):GetSpellList()\n            -- local orbName = _G.Details_Elitism:RequireOrbName()\n            -- for spellID, spellTable in pairs(spellList) do\n            --     local amount = spellTable.targets[orbName]\n            --     if amount then\n            --         tinsert(sortedList, {spellID, amount})\n            --     end\n            -- end\n            sort(sortedList, Details.Sort2)\n\n            local format_func = Details:GetCurrentToKFunction()\n            for _, tbl in ipairs(sortedList) do\n                local spellID, amount = unpack(tbl)\n                local spellName, _, spellIcon = Details.GetSpellInfo(spellID)\n\n                GameCooltip:AddLine(spellName, format_func(_, amount))\n                Details:AddTooltipBackgroundStatusbar()\n                GameCooltip:AddIcon(spellIcon, 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n            end\n        end\n    ",
					["target"] = false,
					["spellid"] = false,
					["icon"] = 2175503,
					["script_version"] = 1,
				}, -- [12]
				{
					["source"] = false,
					["author"] = "Bass",
					["total_script"] = "        local value, top, total, Combat, Instance, Actor = ...\n\n        local format_func = Details:GetCurrentToKFunction()\n        if _G.Details_Elitism then\n            local cnt, _ = _G.Details_Elitism:GetAuraRecord(Combat:GetCombatNumber(), Actor.my_actor.serial)\n            return \"\" .. cnt\n        end\n        return \"\"\n    ",
					["desc"] = "Show how many avoidable abilities hit players.",
					["attribute"] = false,
					["script"] = "        local Combat, CustomContainer, Instance = ...\n        local total, top, amount = 0, 0, 0\n\n        if _G.Details_Elitism then\n            local Container = Combat:GetActorList(DETAILS_ATTRIBUTE_MISC)\n            for _, player in ipairs(Container) do\n                if player:IsGroupPlayer() then\n                    -- we only record the players in party\n                    local cnt, _ = _G.Details_Elitism:GetAuraRecord(Combat:GetCombatNumber(), player:guid())\n                    -- _G.Details_Elitism:Debug(\"guid %s target %s hit %s\", player:guid() or 0, target or 0,hit or 0)\n                    if cnt > 0 then\n                        CustomContainer:AddValue(player, cnt)\n                    end\n                end\n            end\n\n            total, top = CustomContainer:GetTotalAndHighestValue()\n            amount = CustomContainer:GetNumActors()\n        end\n\n        return total, top, amount\n    ",
					["name"] = "Avoidable Abilities Taken",
					["tooltip"] = "        local Actor, Combat, Instance = ...\n        local GameCooltip = GameCooltip\n\n        if _G.Details_Elitism then\n            local realCombat\n            for i = -1, 25 do\n                local current = Details:GetCombat(i)\n                if current and current:GetCombatNumber() == Combat.combat_counter then\n                    realCombat = current\n                    break\n                end\n            end\n\n            if not realCombat then return end\n\n            local sortedList = {}\n            _, spells = _G.Details_Elitism:GetAuraRecord(Combat:GetCombatNumber(), realCombat[1]:GetActor(Actor.nome):guid())\n            for spellID, spelldata in pairs(spells) do\n                tinsert(sortedList, {spellID, spelldata.cnt})\n            end\n            -- local spellList = realCombat[1]:GetActor(Actor.nome):GetSpellList()\n            -- local orbName = _G.Details_Elitism:RequireOrbName()\n            -- for spellID, spellTable in pairs(spellList) do\n            --     local amount = spellTable.targets[orbName]\n            --     if amount then\n            --         tinsert(sortedList, {spellID, amount})\n            --     end\n            -- end\n            sort(sortedList, Details.Sort2)\n\n            local format_func = Details:GetCurrentToKFunction()\n            for _, tbl in ipairs(sortedList) do\n                local spellID, cnt = unpack(tbl)\n                local spellName, _, spellIcon = Details.GetSpellInfo(spellID)\n\n                GameCooltip:AddLine(spellName, format_func(_, cnt))\n                Details:AddTooltipBackgroundStatusbar()\n                GameCooltip:AddIcon(spellIcon, 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height)\n            end\n        end\n    ",
					["target"] = false,
					["spellid"] = false,
					["icon"] = 2175503,
					["script_version"] = 1,
				}, -- [13]
				{
					["source"] = false,
					["total_script"] = "				local value, top, total, combat, instance = ...\n				return value\n			",
					["author"] = "Details!",
					["percent_script"] = "				local value, top, total, combat, instance = ...\n\n				--get the time of overall combat\n				local OverallCombatTime = Details:GetCombat (-1):GetCombatTime()\n				\n				--get the time of current combat if the player is in combat\n				if (Details.in_combat) then\n					local CurrentCombatTime = Details:GetCombat (0):GetCombatTime()\n					OverallCombatTime = OverallCombatTime + CurrentCombatTime\n				end\n				\n				--calculate the DPS and return it as percent\n				local totalValue = value\n				\n				--build the string\n				local ToK = Details:GetCurrentToKFunction()\n				local s = ToK (_, value / OverallCombatTime)\n				\n				return s\n			",
					["desc"] = "Show overall damage done on the fly.",
					["attribute"] = false,
					["script"] = "				--init:\n				local combat, instance_container, instance = ...\n				local total, top, amount = 0, 0, 0\n				\n				--get the overall combat\n				local OverallCombat = Details:GetCombat (-1)\n				--get the current combat\n				local CurrentCombat = Details:GetCombat (0)\n				\n				if (not OverallCombat.GetActorList or not CurrentCombat.GetActorList) then\n					return 0, 0, 0\n				end\n				\n				--get the damage actor container for overall\n				local damage_container_overall = OverallCombat:GetActorList ( DETAILS_ATTRIBUTE_DAMAGE )\n				--get the damage actor container for current\n				local damage_container_current = CurrentCombat:GetActorList ( DETAILS_ATTRIBUTE_DAMAGE )\n				\n				--do the loop:\n				for _, player in ipairs ( damage_container_overall ) do \n					--only player in group\n					if (player:IsGroupPlayer()) then\n						instance_container:AddValue (player, player.total)\n					end\n				end\n				\n				if (Details.in_combat) then\n					for _, player in ipairs ( damage_container_current ) do \n						--only player in group\n						if (player:IsGroupPlayer()) then\n							instance_container:AddValue (player, player.total)        \n						end\n					end\n				end\n				\n				total, top =  instance_container:GetTotalAndHighestValue()\n				amount =  instance_container:GetNumActors()\n				\n				--return:\n				return total, top, amount\n			",
					["name"] = "Dynamic Overall Damage",
					["tooltip"] = "				--get the parameters passed\n				local actor, combat, instance = ...\n\n				--get the cooltip object (we dont use the convencional GameTooltip here)\n				local GameCooltip = GameCooltip2\n\n				--Cooltip code\n				--get the overall combat\n				local OverallCombat = Details:GetCombat (-1)\n				--get the current combat\n				local CurrentCombat = Details:GetCombat (0)\n\n				local AllSpells = {}\n\n				local playerTotal = 0\n\n				--overall\n				local player = OverallCombat [1]:GetActor (actor.nome)\n				playerTotal = playerTotal + player.total\n				local playerSpells = player:GetSpellList()\n				for spellID, spellTable in pairs (playerSpells) do\n					AllSpells [spellID] = spellTable.total\n				end\n\n				--current\n				local player = CurrentCombat [1]:GetActor (actor.nome)\n				if (player) then\n					playerTotal = playerTotal + player.total\n					local playerSpells = player:GetSpellList()\n					for spellID, spellTable in pairs (playerSpells) do\n						AllSpells [spellID] = (AllSpells [spellID] or 0) + (spellTable.total or 0)\n					end\n				end\n\n				local sortedList = {}\n				for spellID, total in pairs (AllSpells) do\n					tinsert (sortedList, {spellID, total})\n				end\n				table.sort (sortedList, Details.Sort2)\n\n				local format_func = Details:GetCurrentToKFunction()\n\n				--build the tooltip\n\n				local topSpellTotal = sortedList and sortedList[1] and sortedList[1][2] or 0\n\n				for i, t in ipairs (sortedList) do\n					local spellID, total = unpack (t)\n					if (total > 1) then\n						local spellName, _, spellIcon = Details.GetSpellInfo (spellID)\n						\n						local spellPercent = total / playerTotal * 100\n						local formatedSpellPercent = format(\"%.1f\", spellPercent)\n						\n						if (string.len(formatedSpellPercent) < 4) then\n							formatedSpellPercent = formatedSpellPercent  .. \"0\"\n						end\n						\n						GameCooltip:AddLine (spellName, format_func (_, total) .. \"    \" .. formatedSpellPercent  .. \"%\")\n						\n						Details:AddTooltipBackgroundStatusbar(false, total / topSpellTotal * 100)\n						GameCooltip:AddIcon (spellIcon, 1, 1, _detalhes.tooltip.line_height, _detalhes.tooltip.line_height, 0.078125, 0.921875, 0.078125, 0.921875)\n						\n					end\n				end\n			",
					["target"] = false,
					["spellid"] = false,
					["icon"] = "Interface\\Buttons\\Spell-Reset",
					["script_version"] = 6,
				}, -- [14]
			},
			["damage_scroll_auto_open"] = false,
			["latest_news_saw"] = "v9.0.5.8357",
			["realm_sync"] = true,
			["current_exp_raid_encounters"] = {
				[2417] = true,
				[2418] = true,
				[2412] = true,
				[2405] = true,
				[2398] = true,
				[2406] = true,
				[2399] = true,
				[2407] = true,
				[2402] = true,
				[2383] = true,
			},
			["run_code"] = {
				["on_groupchange"] = "\n-- this code runs when the player enter or leave a group",
				["on_zonechanged"] = "\n-- when the player changes zone, this code will run",
				["on_init"] = "\n-- code to run when Details! initializes, put here code which only will run once\n-- this also will run then the profile is changed\n\n--size of the death log tooltip in the Deaths display (default 350)\nDetails.death_tooltip_width = 350;\n\n--when in arena or battleground, details! silently switch to activity time (goes back to the old setting on leaving, default true)\nDetails.force_activity_time_pvp = true;\n\n--speed of the bar animations (default 33)\nDetails.animation_speed = 33;\n\n--threshold to trigger slow or fast speed (default 0.45)\nDetails.animation_speed_mintravel = 0.45;\n\n--call to update animations\nDetails:RefreshAnimationFunctions();\n\n--max window size, does require a /reload to work (default 480 x 450)\nDetails.max_window_size.width = 480;\nDetails.max_window_size.height = 450;\n\n--use the arena team color as the class color (default true)\nDetails.color_by_arena_team = true;\n\n--use the role icon in the player bar when inside an arena (default false)\nDetails.show_arena_role_icon = false;\n\n--how much time the update warning is shown (default 10)\nDetails.update_warning_timeout = 10;",
				["on_specchanged"] = "\n-- run when the player changes its spec",
				["on_leavecombat"] = "\n-- this code runs when the player leave combat",
				["on_entercombat"] = "\n-- this code runs when the player enters in combat",
			},
			["show_totalhitdamage_on_overkill"] = false,
			["exit_errors"] = {
				"v9.0.2.8246 Interface\\AddOns\\Details\\core\\meta.lua:644: attempt to perform arithmetic on field '?' (a nil value)", -- [1]
			},
			["data_wipes_exp"] = {
				["9"] = true,
				["14"] = false,
				["13"] = false,
				["12"] = false,
				["11"] = false,
				["10"] = false,
			},
			["spellid_ignored"] = {
			},
			["createauraframe"] = {
				["y"] = 0.0001068115234375,
				["x"] = 0.00018310546875,
				["point"] = "CENTER",
				["scale"] = 1,
			},
			["global_plugin_database"] = {
				["DETAILS_PLUGIN_ENCOUNTER_DETAILS"] = {
					["encounter_timers_dbm"] = {
					},
					["encounter_timers_bw"] = {
					},
				},
			},
			["savedStyles"] = {
			},
			["savedCustomSpells"] = {
				{
					2, -- [1]
					"Auto Shot", -- [2]
					"Interface\\ICONS\\INV_Weapon_Bow_07", -- [3]
				}, -- [1]
				{
					3, -- [1]
					"Environment (Falling)", -- [2]
					"Interface\\ICONS\\Spell_Magic_FeatherFall", -- [3]
				}, -- [2]
				{
					55090, -- [1]
					"Scourge Strike (Physical)", -- [2]
					237530, -- [3]
				}, -- [3]
				{
					4, -- [1]
					"Environment (Drowning)", -- [2]
					"Interface\\ICONS\\Ability_Suffocate", -- [3]
				}, -- [4]
				{
					5, -- [1]
					"Environment (Fatigue)", -- [2]
					"Interface\\ICONS\\Spell_Arcane_MindMastery", -- [3]
				}, -- [5]
				{
					6, -- [1]
					"Environment (Fire)", -- [2]
					"Interface\\ICONS\\INV_SummerFest_FireSpirit", -- [3]
				}, -- [6]
				{
					7, -- [1]
					"Environment (Lava)", -- [2]
					"Interface\\ICONS\\Ability_Rhyolith_Volcano", -- [3]
				}, -- [7]
				{
					8, -- [1]
					"Environment (Slime)", -- [2]
					"Interface\\ICONS\\Ability_Creature_Poison_02", -- [3]
				}, -- [8]
				{
					59638, -- [1]
					"Frostbolt (Mirror Image)", -- [2]
					135846, -- [3]
				}, -- [9]
				{
					49184, -- [1]
					"Howling Blast (Main Target)", -- [2]
					135833, -- [3]
				}, -- [10]
				{
					44461, -- [1]
					"Living Bomb (explosion)", -- [2]
					236220, -- [3]
				}, -- [11]
				{
					278227, -- [1]
					"Barkspines (Trinket)", -- [2]
					134439, -- [3]
				}, -- [12]
				{
					268998, -- [1]
					"Kindled Soul (Trinket)", -- [2]
					651093, -- [3]
				}, -- [13]
				{
					196917, -- [1]
					"Light of the Martyr (Damage)", -- [2]
					135938, -- [3]
				}, -- [14]
				{
					120761, -- [1]
					"Glaive Toss (Glaive #2)", -- [2]
					132330, -- [3]
				}, -- [15]
				{
					278812, -- [1]
					"Lion's Grace (Trinket)", -- [2]
					464140, -- [3]
				}, -- [16]
				{
					270827, -- [1]
					"Webweaver's Soul Gem (Trinket)", -- [2]
					237431, -- [3]
				}, -- [17]
				{
					212739, -- [1]
					"Epidemic (Main Target)", -- [2]
					136066, -- [3]
				}, -- [18]
				{
					279664, -- [1]
					"Bloody Bile (Trinket)", -- [2]
					136007, -- [3]
				}, -- [19]
				{
					237680, -- [1]
					"Howling Blast (AoE)", -- [2]
					135833, -- [3]
				}, -- [20]
				{
					215969, -- [1]
					"Epidemic (AoE)", -- [2]
					136066, -- [3]
				}, -- [21]
				{
					278359, -- [1]
					"Blood Hatred (Trinket)", -- [2]
					132175, -- [3]
				}, -- [22]
				{
					278155, -- [1]
					"Lingering Power of Xalzaix (Trinket)", -- [2]
					254105, -- [3]
				}, -- [23]
				{
					271115, -- [1]
					"Ignition Mage's Fuse (Trinket)", -- [2]
					1119937, -- [3]
				}, -- [24]
				{
					277179, -- [1]
					"Gladiator's Medallion (Trinket)", -- [2]
					252267, -- [3]
				}, -- [25]
				{
					70890, -- [1]
					"Scourge Strike (Shadow)", -- [2]
					237530, -- [3]
				}, -- [26]
				{
					278057, -- [1]
					"Volatile Blood Explosion (Trinket)", -- [2]
					538040, -- [3]
				}, -- [27]
				{
					277185, -- [1]
					"Gladiator's Badge (Trinket)", -- [2]
					135884, -- [3]
				}, -- [28]
				{
					228649, -- [1]
					"Blackout Kick (Passive)", -- [2]
					574575, -- [3]
				}, -- [29]
				{
					121414, -- [1]
					"Glaive Toss (Glaive #1)", -- [2]
					132330, -- [3]
				}, -- [30]
				{
					94472, -- [1]
					"Atonement (critical)", -- [2]
					135887, -- [3]
				}, -- [31]
				{
					277187, -- [1]
					"Gladiator's Emblem (Trinket)", -- [2]
					132344, -- [3]
				}, -- [32]
				{
					277181, -- [1]
					"Gladiator's Insignia (Trinket)", -- [2]
					134501, -- [3]
				}, -- [33]
				{
					278862, -- [1]
					"Chill of the Runes (Trinket)", -- [2]
					252270, -- [3]
				}, -- [34]
				{
					271462, -- [1]
					"Rotcrusted Voodoo Doll (Trinket)", -- [2]
					1716867, -- [3]
				}, -- [35]
				{
					270925, -- [1]
					"Waterspout (Trinket)", -- [2]
					1698701, -- [3]
				}, -- [36]
				{
					271071, -- [1]
					"Conch of Dark Whispers (Trinket)", -- [2]
					1498840, -- [3]
				}, -- [37]
				{
					271465, -- [1]
					"Rotcrusted Voodoo Doll (Trinket)", -- [2]
					1716867, -- [3]
				}, -- [38]
				{
					33778, -- [1]
					"Lifebloom (Bloom)", -- [2]
					134206, -- [3]
				}, -- [39]
				{
					88082, -- [1]
					"Fireball (Mirror Image)", -- [2]
					135812, -- [3]
				}, -- [40]
				{
					1, -- [1]
					"Melee", -- [2]
					"Interface\\ICONS\\INV_Sword_04", -- [3]
				}, -- [41]
				{
					278383, -- [1]
					"Ruffling Tempest (Trinket)", -- [2]
					2103829, -- [3]
				}, -- [42]
				{
					271671, -- [1]
					"Cacaphonous Chord (Trinket)", -- [2]
					454048, -- [3]
				}, -- [43]
				{
					98021, -- [1]
					"Health Exchange", -- [2]
					237586, -- [3]
				}, -- [44]
				{
					339538, -- [1]
					"Templar's Verdict (Templar's Vindication)", -- [2]
					461860, -- [3]
				}, -- [45]
				{
					345020, -- [1]
					"Skulking Predator (Trinket)", -- [2]
					2103921, -- [3]
				}, -- [46]
				{
					108271, -- [1]
					"Astral Shift", -- [2]
					"Interface\\Addons\\Details\\images\\icon_astral_shift", -- [3]
				}, -- [47]
			},
			["update_warning_timeout"] = 10,
			["item_level_pool"] = {
			},
			["raid_data"] = {
				["mythic_raid_data"] = {
				},
			},
			["switchSaved"] = {
				["slots"] = 32,
				["table"] = {
					{
						["atributo"] = 1,
						["sub_atributo"] = 1,
					}, -- [1]
					{
						["atributo"] = 2,
						["sub_atributo"] = 1,
					}, -- [2]
					{
						["atributo"] = 1,
						["sub_atributo"] = 6,
					}, -- [3]
					{
						["atributo"] = 4,
						["sub_atributo"] = 5,
					}, -- [4]
					{
					}, -- [5]
					{
					}, -- [6]
					{
					}, -- [7]
					{
					}, -- [8]
					{
					}, -- [9]
					{
					}, -- [10]
					{
					}, -- [11]
					{
					}, -- [12]
					{
					}, -- [13]
					{
					}, -- [14]
					{
					}, -- [15]
					{
					}, -- [16]
					{
					}, -- [17]
					{
					}, -- [18]
					{
					}, -- [19]
					{
					}, -- [20]
					{
					}, -- [21]
					{
					}, -- [22]
					{
					}, -- [23]
					{
					}, -- [24]
					{
					}, -- [25]
					{
					}, -- [26]
					{
					}, -- [27]
					{
					}, -- [28]
					{
					}, -- [29]
					{
					}, -- [30]
					{
					}, -- [31]
					{
					}, -- [32]
				},
			},
			["always_use_profile_name"] = "Eltreum Dual",
			["profile_by_spec"] = {
			},
			["always_use_profile_exception"] = {
			},
			["details_auras"] = {
			},
			["displays_by_spec"] = {
			},
			["savedTimeCaptures"] = {
				{
					"Player Damage Done", -- [1]
					"\n	-- the goal of this script is get the current combat then get your character and extract your damage done.\n	-- the first thing to do is get the combat, so, we use here the command \"_detalhes:GetCombat ( \"overall\" \"current\" or \"segment number\")\"\n	\n	local current_combat = _detalhes:GetCombat (\"current\") --> getting the current combat\n	\n	-- the next step is request your character from the combat\n	-- to do this, we take the combat which here we named \"current_combat\" and tells what we want inside parentheses.\n	\n	local my_self = current_combat (DETAILS_ATTRIBUTE_DAMAGE, _detalhes.playername)\n	\n	-- _detalhes.playername holds the name of your character.\n	-- DETAILS_ATTRIBUTE_DAMAGE means we want the damage table, _HEAL _ENERGY _MISC is the other 3 tables.\n	\n	-- before we proceed, the result needs to be checked to make sure its a valid result.\n	\n	if (not my_self) then\n		return 0 -- the combat doesnt have *you*, this happens when you didn't deal any damage in the combat yet.\n	end\n	\n	-- now its time to get the total damage.\n	\n	local my_damage = my_self.total\n	\n	-- then finally return the amount to the capture.\n	\n	return my_damage\n	\n", -- [2]
					{
						["max_value"] = 0,
						["last_value"] = 0,
					}, -- [3]
					"Chart Viewer", -- [4]
					"1.0", -- [5]
					"Interface\\ICONS\\Ability_MeleeDamage", -- [6]
					true, -- [7]
				}, -- [1]
			},
			["plugin_window_pos"] = {
				["y"] = 122.9224853515625,
				["x"] = -22.85458374023438,
				["point"] = "CENTER",
				["scale"] = 1,
			},
			["damage_scroll_position"] = {
			},
			["performance_profiles"] = {
				["Dungeon"] = {
					["enabled"] = false,
					["update_speed"] = 1,
					["aura"] = true,
					["miscdata"] = true,
					["heal"] = true,
					["use_row_animations"] = false,
					["energy"] = false,
					["damage"] = true,
				},
				["RaidFinder"] = {
					["enabled"] = false,
					["update_speed"] = 1,
					["aura"] = true,
					["miscdata"] = true,
					["heal"] = true,
					["use_row_animations"] = false,
					["energy"] = false,
					["damage"] = true,
				},
				["Battleground15"] = {
					["enabled"] = false,
					["update_speed"] = 1,
					["aura"] = true,
					["miscdata"] = true,
					["heal"] = true,
					["use_row_animations"] = false,
					["energy"] = false,
					["damage"] = true,
				},
				["Raid15"] = {
					["enabled"] = false,
					["update_speed"] = 1,
					["aura"] = true,
					["miscdata"] = true,
					["heal"] = true,
					["use_row_animations"] = false,
					["energy"] = false,
					["damage"] = true,
				},
				["Mythic"] = {
					["enabled"] = false,
					["update_speed"] = 1,
					["aura"] = true,
					["miscdata"] = true,
					["heal"] = true,
					["use_row_animations"] = false,
					["energy"] = false,
					["damage"] = true,
				},
				["Arena"] = {
					["enabled"] = false,
					["update_speed"] = 1,
					["aura"] = true,
					["miscdata"] = true,
					["heal"] = true,
					["use_row_animations"] = false,
					["energy"] = false,
					["damage"] = true,
				},
				["Raid30"] = {
					["enabled"] = false,
					["update_speed"] = 1,
					["aura"] = true,
					["miscdata"] = true,
					["heal"] = true,
					["use_row_animations"] = false,
					["energy"] = false,
					["damage"] = true,
				},
				["Battleground40"] = {
					["enabled"] = false,
					["update_speed"] = 1,
					["aura"] = true,
					["miscdata"] = true,
					["heal"] = true,
					["use_row_animations"] = false,
					["energy"] = false,
					["damage"] = true,
				},
			},
			["last_changelog_size"] = 6382,
			["immersion_unit_special_icons"] = true,
			["lastUpdateWarning"] = 1614995822,
			["dungeon_data"] = {
			},

		}
		_detalhes:ApplyProfile(key)
	end

end
