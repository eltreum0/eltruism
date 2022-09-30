local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

-- Dynamic Cam profile setup
function ElvUI_EltreumUI:GetDynamicCamProfile()
	if E.Retail then
		if DynamicCamDB.profiles.Eltreum then
			--local key = {[E.mynameRealm] = "Eltreum"}
			--table.insert(DynamicCamDB.profileKeys, key)
			--table.insert(DynamicCamDB.profileKeys, E.mynameRealm)
			DynamicCamDB["profileKeys"][E.mynameRealm] = "Eltreum"
		else
			DynamicCamDB["profileKeys"][E.mynameRealm] = "Eltreum"
			DynamicCamDB["profiles"]["Eltreum"] = {}
			DynamicCamDB["profiles"]["Eltreum"] = {
				["reactiveZoom"] = {
					["enabled"] = true,
					["maxZoomTime"] = 0.1,
					["addIncrements"] = 1.5,
					["addIncrementsAlways"] = 0,
					["incAddDifference"] = 2,
				},
				["advanced"] = true,
				["version"] = 2,
				["situations"] = {
					["303"] = {
						["view"] = {
							["viewNumber"] = 2,
						},
						["rotation"] = {
							["enabled"] = true,
							["rotationSpeed"] = 3,
							["rotateBack"] = false,
						},
						["hideUI"] = {
							["enabled"] = true,
							["hideEntireUI"] = true,
							["fadeOpacity"] = 0,
						},
					},
					["033"] = {
						["enabled"] = false,
					},
					["023"] = {
						["enabled"] = false,
					},
					["006"] = {
						["enabled"] = false,
					},
					["302"] = {
						["enabled"] = false,
					},
					["005"] = {
						["cameraActions"] = {
							["timeIsMax"] = false,
							["zoomSetting"] = "in",
							["transitionTime"] = 1.5,
							["zoomValue"] = 20,
						},
						["situationSettings"] = {
							["cvars"] = {
								["test_cameraOverShoulder"] = 0,
							},
						},
						["viewZoom"] = {
							["enabled"] = true,
							["zoomTransitionTime"] = 1.5,
							["zoomType"] = "in",
							["zoomValue"] = 14,
						},
						["cameraCVars"] = {
							["test_cameraOverShoulder"] = 0,
						},
					},
					["101"] = {
						["cameraActions"] = {
							["transitionTime"] = 0.5,
							["rotateSpeed"] = 10,
							["zoomValue"] = 3,
							["rotate"] = true,
							["timeIsMax"] = false,
						},
						["rotation"] = {
							["enabled"] = true,
							["rotateBackTime"] = 0.5,
							["rotationTime"] = 0.5,
							["rotateBack"] = false,
						},
						["view"] = {
							["restoreView"] = true,
							["viewNumber"] = 2,
						},
					},
					["002"] = {
						["cameraActions"] = {
							["zoomMax"] = 20,
							["zoomMin"] = 20,
							["transitionTime"] = 1.05,
							["zoomSetting"] = "in",
							["zoomValue"] = 15,
							["timeIsMax"] = false,
						},
						["situationSettings"] = {
							["cvars"] = {
								["test_cameraOverShoulder"] = 0,
							},
						},
						["viewZoom"] = {
							["enabled"] = true,
							["zoomTransitionTime"] = 1.05,
							["zoomType"] = "in",
							["zoomValue"] = 15,
						},
						["cameraCVars"] = {
							["test_cameraOverShoulder"] = 0,
						},
					},
					["030"] = {
						["enabled"] = false,
						["situationSettings"] = {
							["cvars"] = {
								["test_cameraOverShoulder"] = 0,
								["test_cameraDynamicPitch"] = 0,
							},
						},
						["cameraCVars"] = {
							["test_cameraOverShoulder"] = 0,
						},
					},
					["020"] = {
						["enabled"] = false,
						["situationSettings"] = {
							["cvars"] = {
								["test_cameraDynamicPitch"] = 0,
								["test_cameraOverShoulder"] = 0,
							},
						},
						["cameraCVars"] = {
							["test_cameraDynamicPitch"] = 0,
							["test_cameraOverShoulder"] = 0,
						},
					},
					["102"] = {
						["enabled"] = false,
					},
					["050"] = {
						["enabled"] = false,
						["situationSettings"] = {
							["cvars"] = {
								["test_cameraOverShoulder"] = 0,
								["test_cameraDynamicPitch"] = 0,
							},
						},
						["cameraCVars"] = {
							["test_cameraDynamicPitch"] = 0,
							["test_cameraOverShoulder"] = 0,
						},
					},
					["201"] = {
						["enabled"] = false,
					},
					["301"] = {
						["view"] = {
							["enabled"] = true,
							["viewNumber"] = 2,
							["restoreView"] = true,
						},
						["cameraActions"] = {
							["timeIsMax"] = false,
							["zoomValue"] = 2,
						},
						["cameraCVars"] = {
							["test_cameraOverShoulder"] = 1,
							["test_cameraTargetFocusInteractStrengthPitch"] = 1,
							["test_cameraTargetFocusInteractEnable"] = 1,
						},
						["situationSettings"] = {
							["cvars"] = {
								["test_cameraTargetFocusInteractEnable"] = 1,
								["test_cameraOverShoulder"] = 1,
								["test_cameraTargetFocusInteractStrengthPitch"] = 1,
								["test_cameraTargetFocusInteractStrengthYaw"] = 1,
							},
						},
						["viewZoom"] = {
							["enabled"] = true,
							["viewZoomType"] = "view",
						},
					},
					["060"] = {
						["enabled"] = false,
						["situationSettings"] = {
							["cvars"] = {
								["test_cameraOverShoulder"] = 0,
								["test_cameraDynamicPitch"] = 0,
							},
						},
						["cameraCVars"] = {
							["test_cameraDynamicPitch"] = 0,
							["test_cameraOverShoulder"] = 0,
						},
					},
					["031"] = {
						["enabled"] = false,
					},
					["021"] = {
						["enabled"] = false,
					},
					["061"] = {
						["enabled"] = false,
					},
					["001"] = {
						["cameraActions"] = {
							["timeIsMax"] = false,
							["zoomValue"] = 20,
							["transitionTime"] = 1.5,
							["zoomSetting"] = "out",
						},
						["situationSettings"] = {
							["cvars"] = {
								["test_cameraOverShoulder"] = 0,
							},
						},
						["cameraCVars"] = {
							["test_cameraOverShoulder"] = 0,
						},
						["viewZoom"] = {
							["enabled"] = true,
							["zoomTransitionTime"] = 1.5,
							["zoomType"] = "out",
							["zoomValue"] = 20,
						},
					},
					["024"] = {
						["enabled"] = false,
					},
					["051"] = {
						["enabled"] = false,
					},
					["004"] = {
						["enabled"] = false,
						["cameraCVars"] = {
							["test_cameraOverShoulder"] = 0,
						},
						["cameraActions"] = {
							["timeIsMax"] = false,
							["zoomValue"] = 30,
							["transitionTime"] = 1.5,
							["zoomSetting"] = "out",
						},
						["situationSettings"] = {
							["cvars"] = {
								["test_cameraOverShoulder"] = 0,
							},
						},
						["viewZoom"] = {
							["enabled"] = true,
							["zoomTransitionTime"] = 1.5,
							["zoomValue"] = 15,
						},
					},
					["300"] = {
						["view"] = {
							["enabled"] = true,
							["viewNumber"] = 2,
							["restoreView"] = true,
						},
						["cameraActions"] = {
							["timeIsMax"] = false,
							["zoomValue"] = 2,
						},
						["situationSettings"] = {
							["cvars"] = {
								["test_cameraTargetFocusInteractEnable"] = 1,
								["test_cameraOverShoulder"] = 0,
								["test_cameraTargetFocusInteractStrengthPitch"] = 1,
								["test_cameraTargetFocusInteractStrengthYaw"] = 1,
							},
						},
						["cameraCVars"] = {
							["test_cameraOverShoulder"] = 0,
							["test_cameraTargetFocusInteractStrengthPitch"] = 1,
							["test_cameraTargetFocusInteractEnable"] = 1,
						},
						["viewZoom"] = {
							["enabled"] = true,
							["viewZoomType"] = "view",
						},
					},
					["200"] = {
						["view"] = {
							["enabled"] = true,
							["viewNumber"] = 3,
							["restoreView"] = true,
						},
						["viewZoom"] = {
							["viewZoomType"] = "view",
							["enabled"] = true,
							["viewNumber"] = 3,
							["zoomValue"] = 4,
						},
						["executeOnInit"] = "this.spells = {\n  556,     -- Astral Recall\n  3561,    -- Teleport: Stormwind\n  3562,    -- Teleport: Ironforge\n  3563,    -- Teleport: Undercity\n  3565,    -- Teleport: Darnassus\n  3566,    -- Teleport: Thunder Bluff\n  3567,    -- Teleport: Orgrimmar\n  8690,    -- Hearthstone\n  32271,   -- Teleport: Exodar\n  32272,   -- Teleport: Silvermoon\n  33690,   -- Teleport: Shattrath\n  35715,   -- Teleport: Shattrath\n  49358,   -- Teleport: Stonard\n  49359,   -- Teleport: Theramore\n  49844,   -- Using Direbrew's Remote\n  50977,   -- Death Gate\n  53140,   -- Teleport: Dalaran - Northrend\n  54406,   -- Teleport: Dalaran\n  75136,   -- Ethereal Portal\n  88342,   -- Teleport: Tol Barad\n  88344,   -- Teleport: Tol Barad\n  94719,   -- The Innkeeper's Daughter\n  120145,  -- Ancient Teleport: Dalaran\n  132621,  -- Teleport: Vale of Eternal Blossoms\n  132627,  -- Teleport: Vale of Eternal Blossoms\n  136508,  -- Dark Portal\n  140295,  -- Kirin Tor Beacon\n  168487,  -- Home Away from Home\n  168499,  -- Home Away from Home\n  171253,  -- Garrison Hearthstone\n  176242,  -- Teleport: Warspear\n  176248,  -- Teleport: Stormshield\n  189838,  -- Teleport to Shipyard\n  192084,  -- Jump to Skyhold\n  192085,  -- Jump to Skyhold\n  193669,  -- Basic Dimensional Rifting\n  193753,  -- Dreamwalk\n  193759,  -- Teleport: Hall of the Guardian\n  196079,  -- Recall (to the sanctuary of Frostwolf Keep)\n  196080,  -- Recall (to the sanctuary of Dun Baldar)\n  216016,  -- Jump to Skyhold\n  222695,  -- Dalaran Hearthstone\n  223805,  -- Advanced Dimensional Rifting\n  224869,  -- Teleport: Dalaran - Broken Isles\n  225428,  -- Town Portal: Shala'nir\n  225434,  -- Town Portal: Sashj'tar\n  225435,  -- Town Portal: Kal'delar\n  225440,  -- Town Portal: Lian'tril\n  225436,  -- Town Portal: Faronaar\n  227334,  -- Flight Master's Whistle\n  231504,  -- [Tome of] Town Portal\n  231505,  -- [Scroll of] Town Portal\n  248906,  -- Vindicaar Teleport Beacon\n  262100,  -- Recall (to your Great Hall)\n  278244,  -- Greatfather Winter's Hearthstone\n  278559,  -- Headless Horseman's Hearthstone\n  281403,  -- Teleport: Boralus\n  281404,  -- Teleport: Dazar'alor\n  285362,  -- Lunar Elder's Hearthstone\n  285424,  -- Peddlefeet's Lovely Hearthstone\n  286031,  -- Noble Gardener's Hearthstone\n  286331,  -- Fire Eater's Hearthstone\n  286353,  -- Brewfest Reveler's Hearthstone\n  298068,  -- Holographic Digitalization Hearthstone\n  308742,  -- Eternal Traveler's Hearthstone\n  312372,  -- Return to Camp\n  326064,  -- Night Fae Hearthstone\n  335671,  -- Scroll of Teleport: Theater of Pain\n  340200,  -- Necrolord Hearthstone\n  126892,  -- Zen Pilgrimage\n  340767,  -- Chromie's Teleportation Scroll  \n  344587,  -- Teleport: Oribos\n  324031, -- Wormhole Generator: Shadowlands\n  \n}",
						["cameraActions"] = {
							["pitchDegrees"] = 15,
							["rotateSetting"] = "degrees",
							["transitionTime"] = 1,
							["rotateSpeed"] = 80,
							["zoomSetting"] = "set",
							["yawDegrees"] = 270,
							["rotate"] = true,
							["timeIsMax"] = false,
							["zoomValue"] = 4,
						},
						["situationSettings"] = {
							["cvars"] = {
								["test_cameraOverShoulder"] = 0,
							},
						},
						["cameraCVars"] = {
							["test_cameraOverShoulder"] = 0,
						},
						["rotation"] = {
							["enabled"] = true,
							["pitchDegrees"] = 15,
							["rotationType"] = "degrees",
							["rotationSpeed"] = 20,
							["yawDegrees"] = 270,
							["rotateBack"] = false,
						},
					},
					["100"] = {
						["enabled"] = false,
						["cameraActions"] = {
							["zoomValue"] = 30,
							["zoomSetting"] = "out",
						},
						["cameraCVars"] = {
							["test_cameraDynamicPitch"] = 0,
							["test_cameraTargetFocusInteractEnable"] = 0,
							["test_cameraTargetFocusEnemyEnable"] = 0,
						},
					},
					["034"] = {
						["enabled"] = false,
					},
					["103"] = {
						["enabled"] = false,
					},
				},
				["defaultCvars"] = {
					["cameraZoomSpeed"] = 50,
					["test_cameraDynamicPitchBaseFovPadFlying"] = 0.9500000000000001,
					["test_cameraDynamicPitchBaseFovPadDownScale"] = 1,
					["test_cameraDynamicPitchBaseFovPad"] = 0.7000000000000001,
					["test_cameraDynamicPitch"] = 1,
					["test_cameraDynamicPitchSmartPivotCutoffDist"] = 0,
				},
				["firstRun"] = false,
			}
		end
	elseif E.Wrath or E.TBC or E.Classic then
		if DynamicCamDB.profiles.Eltreum then
			local key = {[E.mynameRealm] = "Eltreum"}
			table.insert(DynamicCamDB.profileKeys, key)
		else
			DynamicCamDB["profileKeys"][E.mynameRealm] = "Eltreum"
			DynamicCamDB["profiles"]["Eltreum"] = {}
			DynamicCamDB["profiles"]["Eltreum"] = {
				["reactiveZoom"] = {
					["enabled"] = true,
					["maxZoomTime"] = 0.1,
					["addIncrements"] = 1.5,
					["addIncrementsAlways"] = 0,
					["incAddDifference"] = 2,
				},
				["advanced"] = true,
				["version"] = 2,
				["situations"] = {
					["303"] = {
					},
					["103"] = {
						["enabled"] = false,
					},
					["033"] = {
						["enabled"] = false,
					},
					["023"] = {
						["enabled"] = false,
					},
					["006"] = {
						["enabled"] = false,
					},
					["302"] = {
						["enabled"] = false,
					},
					["101"] = {
						["cameraActions"] = {
							["transitionTime"] = 0.5,
							["rotateSpeed"] = 10,
							["rotate"] = true,
							["timeIsMax"] = false,
						},
					},
					["002"] = {
						["cameraActions"] = {
							["zoomSetting"] = "in",
							["transitionTime"] = 1.05,
							["timeIsMax"] = false,
							["zoomValue"] = 15,
						},
						["cameraCVars"] = {
							["test_cameraOverShoulder"] = 0,
						},
					},
					["030"] = {
						["enabled"] = false,
						["cameraCVars"] = {
							["test_cameraOverShoulder"] = 0,
							["test_cameraDynamicPitch"] = 0,
						},
					},
					["020"] = {
						["enabled"] = false,
						["cameraCVars"] = {
							["test_cameraDynamicPitch"] = 0,
							["test_cameraOverShoulder"] = 0,
						},
					},
					["102"] = {
						["enabled"] = false,
					},
					["050"] = {
						["enabled"] = false,
						["cameraCVars"] = {
							["test_cameraOverShoulder"] = 0,
							["test_cameraDynamicPitch"] = 0,
						},
					},
					["201"] = {
						["enabled"] = false,
					},
					["301"] = {
						["cameraActions"] = {
							["timeIsMax"] = false,
						},
						["view"] = {
							["enabled"] = true,
							["viewNumber"] = 2,
							["restoreView"] = true,
						},
						["cameraCVars"] = {
							["test_cameraTargetFocusInteractEnable"] = 1,
							["test_cameraOverShoulder"] = 1,
							["test_cameraTargetFocusInteractStrengthPitch"] = 1,
							["test_cameraTargetFocusInteractStrengthYaw"] = 1,
						},
					},
					["005"] = {
						["cameraActions"] = {
							["zoomSetting"] = "in",
							["transitionTime"] = 1.5,
							["timeIsMax"] = false,
							["zoomValue"] = 14,
						},
						["cameraCVars"] = {
							["test_cameraOverShoulder"] = 0,
						},
					},
					["034"] = {
						["enabled"] = false,
					},
					["021"] = {
						["enabled"] = false,
					},
					["004"] = {
						["cameraActions"] = {
							["zoomSetting"] = "set",
							["transitionTime"] = 1.5,
							["timeIsMax"] = false,
							["zoomValue"] = 25,
						},
						["cameraCVars"] = {
							["test_cameraOverShoulder"] = 0,
						},
					},
					["001"] = {
						["cameraActions"] = {
							["zoomSetting"] = "out",
							["transitionTime"] = 1.5,
							["timeIsMax"] = false,
							["zoomValue"] = 20,
						},
						["cameraCVars"] = {
							["test_cameraOverShoulder"] = 0,
						},
					},
					["024"] = {
						["enabled"] = false,
					},
					["051"] = {
						["enabled"] = false,
					},
					["061"] = {
						["enabled"] = false,
					},
					["300"] = {
						["view"] = {
							["enabled"] = true,
							["viewNumber"] = 2,
							["restoreView"] = true,
						},
						["cameraActions"] = {
							["timeIsMax"] = false,
						},
						["cameraCVars"] = {
							["test_cameraTargetFocusInteractEnable"] = 1,
							["test_cameraOverShoulder"] = 0,
							["test_cameraTargetFocusInteractStrengthPitch"] = 1,
							["test_cameraTargetFocusInteractStrengthYaw"] = 1,
						},
					},
					["200"] = {
						["view"] = {
							["enabled"] = true,
							["viewNumber"] = 3,
							["restoreView"] = true,
						},
						["executeOnInit"] = "this.spells = {\n  556,     -- Astral Recall\n  3561,    -- Teleport: Stormwind\n  3562,    -- Teleport: Ironforge\n  3563,    -- Teleport: Undercity\n  3565,    -- Teleport: Darnassus\n  3566,    -- Teleport: Thunder Bluff\n  3567,    -- Teleport: Orgrimmar\n  8690,    -- Hearthstone\n  32271,   -- Teleport: Exodar\n  32272,   -- Teleport: Silvermoon\n  33690,   -- Teleport: Shattrath\n  35715,   -- Teleport: Shattrath\n  49358,   -- Teleport: Stonard\n  49359,   -- Teleport: Theramore\n  49844,   -- Using Direbrew's Remote\n  50977,   -- Death Gate\n  53140,   -- Teleport: Dalaran - Northrend\n  54406,   -- Teleport: Dalaran\n  75136,   -- Ethereal Portal\n  88342,   -- Teleport: Tol Barad\n  88344,   -- Teleport: Tol Barad\n  94719,   -- The Innkeeper's Daughter\n  120145,  -- Ancient Teleport: Dalaran\n  132621,  -- Teleport: Vale of Eternal Blossoms\n  132627,  -- Teleport: Vale of Eternal Blossoms\n  136508,  -- Dark Portal\n  140295,  -- Kirin Tor Beacon\n  168487,  -- Home Away from Home\n  168499,  -- Home Away from Home\n  171253,  -- Garrison Hearthstone\n  176242,  -- Teleport: Warspear\n  176248,  -- Teleport: Stormshield\n  189838,  -- Teleport to Shipyard\n  192084,  -- Jump to Skyhold\n  192085,  -- Jump to Skyhold\n  193669,  -- Basic Dimensional Rifting\n  193753,  -- Dreamwalk\n  193759,  -- Teleport: Hall of the Guardian\n  196079,  -- Recall (to the sanctuary of Frostwolf Keep)\n  196080,  -- Recall (to the sanctuary of Dun Baldar)\n  216016,  -- Jump to Skyhold\n  222695,  -- Dalaran Hearthstone\n  223805,  -- Advanced Dimensional Rifting\n  224869,  -- Teleport: Dalaran - Broken Isles\n  225428,  -- Town Portal: Shala'nir\n  225434,  -- Town Portal: Sashj'tar\n  225435,  -- Town Portal: Kal'delar\n  225440,  -- Town Portal: Lian'tril\n  225436,  -- Town Portal: Faronaar\n  227334,  -- Flight Master's Whistle\n  231504,  -- [Tome of] Town Portal\n  231505,  -- [Scroll of] Town Portal\n  248906,  -- Vindicaar Teleport Beacon\n  262100,  -- Recall (to your Great Hall)\n  278244,  -- Greatfather Winter's Hearthstone\n  278559,  -- Headless Horseman's Hearthstone\n  281403,  -- Teleport: Boralus\n  281404,  -- Teleport: Dazar'alor\n  285362,  -- Lunar Elder's Hearthstone\n  285424,  -- Peddlefeet's Lovely Hearthstone\n  286031,  -- Noble Gardener's Hearthstone\n  286331,  -- Fire Eater's Hearthstone\n  286353,  -- Brewfest Reveler's Hearthstone\n  298068,  -- Holographic Digitalization Hearthstone\n  308742,  -- Eternal Traveler's Hearthstone\n  312372,  -- Return to Camp\n  326064,  -- Night Fae Hearthstone\n  335671,  -- Scroll of Teleport: Theater of Pain\n  340200,  -- Necrolord Hearthstone\n  126892,  -- Zen Pilgrimage\n  340767,  -- Chromie's Teleportation Scroll  \n  344587,  -- Teleport: Oribos\n  \n}",
						["cameraActions"] = {
							["pitchDegrees"] = 15,
							["rotateSetting"] = "degrees",
							["zoomSetting"] = "set",
							["timeIsMax"] = false,
							["zoomValue"] = 4,
							["yawDegrees"] = 270,
							["rotate"] = true,
							["transitionTime"] = 1,
						},
						["cameraCVars"] = {
							["test_cameraOverShoulder"] = 0,
						},
					},
					["100"] = {
						["enabled"] = false,
					},
					["031"] = {
						["enabled"] = false,
					},
					["060"] = {
						["enabled"] = false,
						["cameraCVars"] = {
							["test_cameraOverShoulder"] = 0,
							["test_cameraDynamicPitch"] = 0,
						},
					},
				},
				["defaultCvars"] = {
					["cameraZoomSpeed"] = 50,
					["test_cameraDynamicPitchBaseFovPadFlying"] = 0.95,
					["test_cameraDynamicPitchBaseFovPadDownScale"] = 1,
					["test_cameraDynamicPitchBaseFovPad"] = 0.7,
					["test_cameraDynamicPitch"] = 1,
					["test_cameraDynamicPitchSmartPivotCutoffDist"] = 0,
				},
				["firstRun"] = false,
			}
		end
	end
	DynamicCam.db:SetProfile("Eltreum")
end
