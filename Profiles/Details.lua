local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

-- Details profile setup
function ElvUI_EltreumUI:GetDetailsProfile()
	local key = "Eltreum Dual"
	if ElvUI_EltreumUI.Retail then
		-- Create profile if it doesn't exist yet
		_detalhes_global["__profiles"][key] = _detalhes_global["__profiles"][key] or {}

		-- Clear Cache
		_detalhes_global["encounter_spell_pool"] = {}
		_detalhes_global["npcid_pool"] = {}
		_detalhes_global["spell_pool"] = {}
		_detalhes_global["spell_school_cache"] = {}

		--setup profile
		_detalhes_global["__profiles"][key] = _detalhes_global["__profiles"][key] or {}
		_detalhes_global["__profiles"][key] = {
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
					["class_specs_coords"] = {},
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
					["class_coords"] = {},
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
		}

		-- General db
		_detalhes["always_use_profile"] = true
		_detalhes["always_use_profile_name"] = key

		-- Load the profile
		_detalhes:ApplyProfile(key)
	end
	if ElvUI_EltreumUI.Classic then
		-- Create profile if it doesn't exist yet
		_detalhes_global["__profiles"][key] = _detalhes_global["__profiles"][key] or {}

		-- Clear Cache
		_detalhes_global["encounter_spell_pool"] = {}
		_detalhes_global["npcid_pool"] = {}
		_detalhes_global["spell_pool"] = {}
		_detalhes_global["spell_school_cache"] = {}

		--setup profile
		_detalhes_global["__profiles"][key] = _detalhes_global["__profiles"][key] or {}
		_detalhes_global["__profiles"][key] = {
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
		}



		-- General db
		_detalhes["always_use_profile"] = true
		_detalhes["always_use_profile_name"] = key

		-- Load the profile
		_detalhes:ApplyProfile(key)



		_detalhes:ApplyProfile(key)
	end
	if ElvUI_EltreumUI.TBC then
		local key = "Eltreum Dual"
		-- Create profile if it doesn't exist yet
		_detalhes_global["__profiles"][key] = _detalhes_global["__profiles"][key] or {}

		-- Clear Cache
		_detalhes_global["encounter_spell_pool"] = {}
		_detalhes_global["npcid_pool"] = {}
		_detalhes_global["spell_pool"] = {}
		_detalhes_global["spell_school_cache"] = {}

		--setup profile
		_detalhes_global["__profiles"][key] = _detalhes_global["__profiles"][key] or {}
		_detalhes_global["__profiles"][key] = {
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
				["disable_mythic_dungeon"] = true,
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
				["abbreviation"] = 2,
				["anchored_to"] = 1,
				["show_amount"] = true,
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
					0.8700000047683716, -- [4]
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
				["border_texture"] = "Details BarBorder 3",
				["anchor_offset"] = {
					0, -- [1]
					0, -- [2]
				},
				["menus_bg_texture"] = "Interface\\SPELLBOOK\\Spellbook-Page-1",
				["maximize_method"] = 1,
				["border_size"] = 14,
				["fontshadow"] = true,
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
			["fade_speed"] = 0.15,
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
			["time_type_original"] = 2,
			["options_window"] = {
				["scale"] = 1,
			},
			["animation_speed_maxtravel"] = 3,
			["default_bg_alpha"] = 0.5,
			["time_type"] = 2,
			["font_faces"] = {
				["menus"] = "Kimberley",
			},
			["death_tooltip_width"] = 350,
			["animate_scroll"] = false,
			["clear_ungrouped"] = true,
			["instances"] = {
				{
					["__pos"] = {
						["normal"] = {
							["y"] = -446.5714721679688,
							["x"] = 667.3016967773438,
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
					["bg_r"] = 0.0941176470588235,
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
						["textR_outline_small"] = true,
						["textL_outline_small"] = true,
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
							["size"] = 2.259999990463257,
							["color"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["texture"] = "Details BarBorder 2",
						},
						["font_size"] = 12,
						["textL_translit_text"] = true,
						["height"] = 21,
						["texture_file"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum7pixel.tga",
						["textR_bracket"] = "NONE",
						["texture_custom_file"] = "Interface\\",
						["icon_file"] = "Interface\\AddOns\\Details\\images\\classes_small",
						["icon_grayscale"] = false,
						["textL_custom_text"] = "{data1}. {data3}{data2}",
						["use_spec_icons"] = true,
						["textR_enable_custom_text"] = false,
						["textR_show_data"] = {
							true, -- [1]
							true, -- [2]
							false, -- [3]
						},
						["fixed_texture_color"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["textL_show_number"] = true,
						["texture_custom"] = "",
						["texture_highlight"] = "Interface\\FriendsFrame\\UI-FriendsList-Highlight",
						["textR_custom_text"] = "{data1} ({data2}, {data3}%)",
						["texture"] = "Eltreum7pixel",
						["fixed_texture_background_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							0, -- [4]
						},
						["texture_background_file"] = "Interface\\AddOns\\Details\\images\\bar4_vidro",
						["textL_class_colors"] = true,
						["textR_outline_small_color"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["texture_background"] = "Details Vidro",
						["textR_class_colors"] = false,
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
						["models"] = {
							["upper_model"] = "Spells\\AcidBreath_SuperGreen.M2",
							["lower_model"] = "World\\EXPANSION02\\DOODADS\\Coldarra\\COLDARRALOCUS.m2",
							["upper_alpha"] = 0.5,
							["lower_enabled"] = false,
							["lower_alpha"] = 0.1,
							["upper_enabled"] = false,
						},
					},
					["switch_tank"] = false,
					["plugins_grow_direction"] = 2,
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
					["desaturated_menu"] = true,
					["micro_displays_side"] = 2,
					["window_scale"] = 1,
					["hide_icon"] = false,
					["toolbar_side"] = 1,
					["bg_g"] = 0.0941176470588235,
					["menu_icons_alpha"] = 0.5,
					["bg_b"] = 0.0941176470588235,
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
					["fontstrings_text2_anchor"] = 70,
					["__snapV"] = false,
					["__snapH"] = false,
					["StatusBarSaved"] = {
						["center"] = "DETAILS_STATUSBAR_PLUGIN_CLOCK",
						["right"] = "DETAILS_STATUSBAR_PLUGIN_PDPS",
						["options"] = {
							["DETAILS_STATUSBAR_PLUGIN_PDPS"] = {
								["segmentType"] = 2,
								["textFace"] = "Accidental Presidency",
								["textYMod"] = 1,
								["timeType"] = 1,
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
								["segmentType"] = 2,
								["textFace"] = "Accidental Presidency",
								["textYMod"] = 1,
								["timeType"] = 1,
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
								["segmentType"] = 2,
								["textFace"] = "Accidental Presidency",
								["textYMod"] = 1,
								["timeType"] = 1,
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
						["left"] = "DETAILS_STATUSBAR_PLUGIN_PSEGMENT",
					},
					["grab_on_top"] = false,
					["__was_opened"] = true,
					["instance_button_anchor"] = {
						-27, -- [1]
						1, -- [2]
					},
					["bg_alpha"] = 0.183960914611816,
					["fontstrings_text4_anchor"] = 0,
					["__locked"] = true,
					["menu_alpha"] = {
						["enabled"] = false,
						["onenter"] = 1,
						["iconstoo"] = true,
						["ignorebars"] = false,
						["onleave"] = 1,
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
					["icon_desaturated"] = false,
					["show_statusbar"] = false,
					["libwindow"] = {
						["y"] = 22.85706329345703,
						["x"] = -204.936279296875,
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
					["switch_damager"] = false,
					["switch_tank_in_combat"] = false,
					["bars_grow_direction"] = 1,
					["switch_damager_in_combat"] = false,
					["bars_sort_direction"] = 1,
					["clickthrough_rows"] = false,
					["auto_current"] = true,
					["auto_hide_menu"] = {
						["left"] = true,
						["right"] = false,
					},
					["version"] = 3,
					["attribute_text"] = {
						["enabled"] = true,
						["shadow"] = true,
						["side"] = 1,
						["text_size"] = 12,
						["custom_text"] = "{name}",
						["text_face"] = "Kimberley",
						["anchor"] = {
							0, -- [1]
							3, -- [2]
						},
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["enable_custom_text"] = false,
						["show_timer"] = false,
					},
					["hide_in_combat"] = false,
					["posicao"] = {
						["normal"] = {
							["y"] = -446.5714721679688,
							["x"] = 667.3016967773438,
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
				}, -- [1]
				{
					["__pos"] = {
						["normal"] = {
							["y"] = -446.5714721679688,
							["x"] = 872.0079956054688,
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
					["bg_r"] = 0.0941176470588235,
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
						["textR_outline_small"] = true,
						["textL_outline_small"] = true,
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
							["size"] = 2.259999990463257,
							["color"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["texture"] = "Details BarBorder 2",
						},
						["font_size"] = 12,
						["textL_translit_text"] = true,
						["height"] = 21,
						["texture_file"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum7pixel.tga",
						["textR_bracket"] = "NONE",
						["texture_custom_file"] = "Interface\\",
						["icon_file"] = "Interface\\AddOns\\Details\\images\\classes_small",
						["icon_grayscale"] = false,
						["textL_custom_text"] = "{data1}. {data3}{data2}",
						["use_spec_icons"] = true,
						["textR_enable_custom_text"] = false,
						["textR_show_data"] = {
							true, -- [1]
							true, -- [2]
							false, -- [3]
						},
						["fixed_texture_color"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["textL_show_number"] = true,
						["texture_custom"] = "",
						["texture_highlight"] = "Interface\\FriendsFrame\\UI-FriendsList-Highlight",
						["textR_custom_text"] = "{data1} ({data2}, {data3}%)",
						["texture"] = "Eltreum7pixel",
						["fixed_texture_background_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							0, -- [4]
						},
						["texture_background_file"] = "Interface\\AddOns\\Details\\images\\bar4_vidro",
						["textL_class_colors"] = true,
						["textR_outline_small_color"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["texture_background"] = "Details Vidro",
						["textR_class_colors"] = false,
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
						["models"] = {
							["upper_model"] = "Spells\\AcidBreath_SuperGreen.M2",
							["lower_model"] = "World\\EXPANSION02\\DOODADS\\Coldarra\\COLDARRALOCUS.m2",
							["upper_alpha"] = 0.5,
							["lower_enabled"] = false,
							["lower_alpha"] = 0.1,
							["upper_enabled"] = false,
						},
					},
					["switch_tank"] = false,
					["plugins_grow_direction"] = 2,
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
					["desaturated_menu"] = true,
					["micro_displays_side"] = 2,
					["window_scale"] = 1,
					["hide_icon"] = false,
					["toolbar_side"] = 1,
					["bg_g"] = 0.0941176470588235,
					["menu_icons_alpha"] = 0.5,
					["bg_b"] = 0.0941176470588235,
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
					["fontstrings_text2_anchor"] = 70,
					["__snapV"] = false,
					["__snapH"] = false,
					["StatusBarSaved"] = {
						["center"] = "DETAILS_STATUSBAR_PLUGIN_THREAT",
						["right"] = "DETAILS_STATUSBAR_PLUGIN_PDPS",
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
							["DETAILS_STATUSBAR_PLUGIN_THREAT"] = {
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
								["textAlign"] = 1,
								["timeType"] = 1,
								["textSize"] = 10,
								["textYMod"] = 1,
							},
						},
						["left"] = "DETAILS_STATUSBAR_PLUGIN_CLOCK",
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
						["onenter"] = 1,
						["iconstoo"] = true,
						["ignorebars"] = false,
						["onleave"] = 1,
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
						["x"] = -1.5238037109375,
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
					["bg_alpha"] = 0.183960914611816,
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
						["text_size"] = 12,
						["custom_text"] = "{name}",
						["text_face"] = "Kimberley",
						["anchor"] = {
							0, -- [1]
							3, -- [2]
						},
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
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
							["x"] = 872.0079956054688,
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
			["report_lines"] = 5,
			["memory_threshold"] = 3,
			["pvp_as_group"] = true,
			["skin"] = "Minimalistic",
			["override_spellids"] = true,
			["force_activity_time_pvp"] = true,
			["class_icons_small"] = "Interface\\AddOns\\Details\\images\\classes_small",
			["numerical_system"] = 1,
			["player_details_window"] = {
				["scale"] = 1,
				["bar_texture"] = "Skyline",
				["skin"] = "ElvUI",
			},
			["minimum_combat_time"] = 5,
			["trash_auto_remove"] = true,
			["cloud_capture"] = true,
			["damage_taken_everything"] = false,
			["scroll_speed"] = 2,
			["font_sizes"] = {
				["menus"] = 10,
			},
			["chat_tab_embed"] = {
				["enabled"] = false,
				["y_offset"] = 0,
				["x_offset"] = 0,
				["tab_name"] = "",
				["single_window"] = false,
			},
			["deadlog_events"] = 32,
			["overall_clear_newtorghast"] = true,
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
				["ROGUE"] = {
					0.49609375, -- [1]
					0.7421875, -- [2]
					0, -- [3]
					0.25, -- [4]
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
				["UNGROUPPLAYER"] = {
					0.5, -- [1]
					0.75, -- [2]
					0.75, -- [3]
					1, -- [4]
				},
				["WARLOCK"] = {
					0.7421875, -- [1]
					0.98828125, -- [2]
					0.25, -- [3]
					0.5, -- [4]
				},
			},
			["overall_clear_newboss"] = true,
			["disable_alldisplays_window"] = false,
			["numerical_system_symbols"] = "auto",
			["windows_fade_out"] = {
				"out", -- [1]
				0.2, -- [2]
			},
			["segments_amount_to_save"] = 40,
			["standard_skin"] = false,
			["clear_graphic"] = true,
			["hotcorner_topleft"] = {
				["hide"] = false,
			},
			["animation_speed_triggertravel"] = 5,
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
			["default_bg_color"] = 0.0941,
			["only_pvp_frags"] = false,
			["disable_stretch_button"] = true,
			["segments_auto_erase"] = 1,
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
				["WARLOCK"] = {
					0.58, -- [1]
					0.51, -- [2]
					0.79, -- [3]
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
				["SHAMAN"] = {
					0, -- [1]
					0.44, -- [2]
					0.87, -- [3]
				},
				["PALADIN"] = {
					0.96, -- [1]
					0.55, -- [2]
					0.73, -- [3]
				},
			},
			["deny_score_messages"] = false,
			["segments_panic_mode"] = false,
			["overall_flag"] = 16,
			["window_clamp"] = {
				-8, -- [1]
				0, -- [2]
				21, -- [3]
				-14, -- [4]
			},
			["row_fade_out"] = {
				"out", -- [1]
				0.2, -- [2]
			},
			["overall_clear_logout"] = false,
			["new_window_size"] = {
				["height"] = 158,
				["width"] = 310,
			},
			["use_scroll"] = false,
			["report_schema"] = 1,
			["use_battleground_server_parser"] = false,
			["total_abbreviation"] = 2,
			["disable_reset_button"] = false,
			["data_broker_text"] = "",
			["segments_amount"] = 40,
			["instances_no_libwindow"] = false,
			["deadlog_limit"] = 16,
			["instances_segments_locked"] = true,
		}
		-- General db
		_detalhes["always_use_profile"] = true
		_detalhes["always_use_profile_name"] = key
		-- Load the profile
		_detalhes:ApplyProfile(key)
	end
end
