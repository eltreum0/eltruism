local E = unpack(ElvUI)
local _G = _G

-- Dynamic Cam profile setup
function ElvUI_EltreumUI:GetDynamicCamProfile()
	local DynamicCamDB = _G.DynamicCamDB

	if DynamicCamDB.profiles.Eltreum then
		--local key = {[E.mynameRealm] = "Eltreum"}
		--table.insert(DynamicCamDB.profileKeys, key)
		--table.insert(DynamicCamDB.profileKeys, E.mynameRealm)
		DynamicCamDB["profileKeys"][E.mynameRealm] = "Eltreum"
	else
		DynamicCamDB["profileKeys"][E.mynameRealm] = "Eltreum"
		DynamicCamDB["profiles"]["Eltreum"] = {}
		DynamicCamDB["profiles"]["Eltreum"] = {
			["version"] = 4,
			["situations"] = {
			},
			["standardSettings"] = {
				["reactiveZoomAddIncrements"] = 1.5,
				["reactiveZoomIncAddDifference"] = 2,
				["reactiveZoomAddIncrementsAlways"] = 0,
				["shoulderOffsetZoomUpperBound"] = 8,
				["cvars"] = {
					["cameraZoomSpeed"] = 50,
					["cameraPitchMoveSpeed"] = 160,
					["test_cameraDynamicPitchBaseFovPadFlying"] = 0.9500000000000001,
					["test_cameraDynamicPitchBaseFovPadDownScale"] = 1,
					["test_cameraDynamicPitchBaseFovPad"] = 0.7000000000000001,
					["test_cameraDynamicPitch"] = 1,
					["cameraDistanceMaxZoomFactor"] = E.Retail and 2.6 or 4.0,
					["test_cameraDynamicPitchSmartPivotCutoffDist"] = 0,
				},
			},
			["firstRun"] = false,
		}

		--better handle the situations
		E:CopyTable(DynamicCamDB["profiles"]["Eltreum"]["situations"], _G.DynamicCam["defaults"]["profile"]["situations"])
		DynamicCamDB["profiles"]["Eltreum"]["situations"]["303"] = {
			["enabled"] = true,
			["hideUI"] = {
				["fadeOpacity"] = 0,
				["hideEntireUI"] = true,
			},
			["rotation"] = {
				["enabled"] = true,
				["rotationSpeed"] = 3,
				["rotateBack"] = false,
			},
		}
		DynamicCamDB["profiles"]["Eltreum"]["situations"]["005"] = {
			["enabled"] = true,
			["situationSettings"] = {
				["cvars"] = {
					["test_cameraOverShoulder"] = 0,
				},
			},
			["viewZoom"] = {
				["enabled"] = true,
				["zoomMax"] = 20,
				["zoomMin"] = 20,
				["zoomType"] = "range",
				["zoomValue"] = 20,
				["zoomTransitionTime"] = 1.5,
			},
		}
		DynamicCamDB["profiles"]["Eltreum"]["situations"]["020"] = {
			["enabled"] = true,
			["situationSettings"] = {
				["cvars"] = {
					["test_cameraDynamicPitch"] = 0,
					["test_cameraOverShoulder"] = 0,
				},
			},
		}
		DynamicCamDB["profiles"]["Eltreum"]["situations"]["002"] = {
			["enabled"] = true,
			["situationSettings"] = {
				["cvars"] = {
					["test_cameraOverShoulder"] = 0,
				},
			},
			["viewZoom"] = {
				["enabled"] = true,
				["zoomMax"] = 20,
				["zoomTransitionTime"] = 1.05,
				["zoomType"] = "range",
				["zoomValue"] = 15,
				["zoomMin"] = 20,
			},
		}
		DynamicCamDB["profiles"]["Eltreum"]["situations"]["050"] = {
			["enabled"] = true,
			["situationSettings"] = {
				["cvars"] = {
					["test_cameraDynamicPitch"] = 0,
					["test_cameraOverShoulder"] = 0,
				},
			},
		}
		DynamicCamDB["profiles"]["Eltreum"]["situations"]["301"] = {
			["enabled"] = true,
			["situationSettings"] = {
				["cvars"] = {
					["test_cameraOverShoulder"] = 1,
					["test_cameraTargetFocusInteractStrengthPitch"] = 1,
					["test_cameraTargetFocusInteractEnable"] = 1,
				},
			},
			["viewZoom"] = {
				["enabled"] = true,
			},
		}
		DynamicCamDB["profiles"]["Eltreum"]["situations"]["060"] = {
			["enabled"] = true,
			["situationSettings"] = {
				["cvars"] = {
					["test_cameraDynamicPitch"] = 0,
					["test_cameraOverShoulder"] = 0,
				},
			},
		}
		DynamicCamDB["profiles"]["Eltreum"]["situations"]["160"] = {
			["enabled"] = true,
			["rotation"] = {
				["enabled"] = true,
				["rotateBackTime"] = 0.5,
				["rotationTime"] = 0.5,
				["rotateBack"] = false,
			},
		}
		DynamicCamDB["profiles"]["Eltreum"]["situations"]["001"] = {
			["enabled"] = true,
			["situationSettings"] = {
				["cvars"] = {
					["test_cameraOverShoulder"] = 0,
				},
			},
			["viewZoom"] = {
				["enabled"] = true,
				["zoomType"] = "out",
				["zoomValue"] = 20,
				["zoomTransitionTime"] = 1.5,
			},
		}
		DynamicCamDB["profiles"]["Eltreum"]["situations"]["004"] = {
			["enabled"] = true,
			["situationSettings"] = {
				["cvars"] = {
					["test_cameraOverShoulder"] = 0,
				},
			},
			["viewZoom"] = {
				["enabled"] = true,
				["zoomType"] = "out",
				["zoomValue"] = 30,
				["zoomTransitionTime"] = 1.5,
			},
		}
		DynamicCamDB["profiles"]["Eltreum"]["situations"]["300"] = {
			["enabled"] = true,
			["situationSettings"] = {
				["cvars"] = {
					["test_cameraOverShoulder"] = 0,
					["test_cameraTargetFocusInteractStrengthPitch"] = 1,
					["test_cameraTargetFocusInteractEnable"] = 1,
				},
			},
			["viewZoom"] = {
				["enabled"] = true,
			},
		}
		DynamicCamDB["profiles"]["Eltreum"]["situations"]["200"] = {
			["enabled"] = true,
			["situationSettings"] = {
				["cvars"] = {
					["test_cameraOverShoulder"] = 0,
				},
			},
			["rotation"] = {
				["enabled"] = true,
				["pitchDegrees"] = 15,
				["rotationType"] = "degrees",
				["rotationSpeed"] = 80,
				["yawDegrees"] = 270,
				["rotateBack"] = false,
			},
			["viewZoom"] = {
				["enabled"] = true,
				["zoomValue"] = 4,
				["viewNumber"] = 3,
			},
		}
		DynamicCamDB["profiles"]["Eltreum"]["situations"]["030"] = {
			["enabled"] = true,
			["situationSettings"] = {
				["cvars"] = {
					["test_cameraOverShoulder"] = 0,
				},
			},
			["viewZoom"] = {
				["enabled"] = true,
				["zoomValue"] = 39,
			},
		}
		DynamicCamDB["profiles"]["Eltreum"]["situations"]["100"] = {
			["enabled"] = true,
			["situationSettings"] = {
				["cvars"] = {
					["test_cameraDynamicPitch"] = 1,
					["test_cameraTargetFocusInteractEnable"] = 1,
					["test_cameraTargetFocusEnemyEnable"] = 0,
					["test_cameraTargetFocusInteractStrengthYaw"] = 1,
					["test_cameraTargetFocusEnemyStrengthPitch"] = 0.4,
					["test_cameraTargetFocusInteractStrengthPitch"] = 0.75,
					["test_cameraDynamicPitchBaseFovPad"] = 0.7000000000000001,
					["test_cameraDynamicPitchBaseFovPadDownScale"] = 1,
					["test_cameraTargetFocusEnemyStrengthYaw"] = 0.5,
					["test_cameraDynamicPitchSmartPivotCutoffDist"] = 0,
					["test_cameraDynamicPitchBaseFovPadFlying"] = 0.9500000000000001,
				},
			},
			["viewZoom"] = {
				["enabled"] = true,
				["zoomTransitionTime"] = 0.75,
				["zoomType"] = "out",
				["zoomValue"] = 30,
				["zoomTimeIsMax"] = true,
			},
		}
	end
	_G.DynamicCam.db:SetProfile("Eltreum")
end
