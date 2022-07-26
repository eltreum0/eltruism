local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

function ElvUI_EltreumUI:CvarOptions()
	local cvars = {
		order = 85,
		type = 'group',
		name = L["CVars"],
		icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\cvar',
		args = {
			header2 = {
				order = 4,
				type = "description",
				name = L["Customize CVars"],
				width = 'full',
				image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
			},
			nameplateOtherBottomInset = {
				type = 'range',
				name = L["Nameplate Other Bottom Inset"],
				desc = L["In screen % the inset from the Bottom"],
				order = 5,
				min = 0.01,
				max = 1,
				step = 0.01,
				width = "full",
				get = function() return E.db.ElvUI_EltreumUI.cvars.nameplateOtherBottomInset end,
				set = function(_, value) E.db.ElvUI_EltreumUI.cvars.nameplateOtherBottomInset = value SetCVar('nameplateOtherBottomInset', value) end,
			},
			nameplateOtherTopInset = {
				type = 'range',
				name = L["Nameplate Other Top Inset"],
				desc = L["In screen % the inset from the Top"],
				order = 5,
				min = 0.01,
				max = 1,
				step = 0.01,
				width = "full",
				get = function() return E.db.ElvUI_EltreumUI.cvars.nameplateOtherTopInset end,
				set = function(_, value) E.db.ElvUI_EltreumUI.cvars.nameplateOtherTopInset = value SetCVar('nameplateOtherTopInset', value) end,
			},
			nameplateTargetRadialPosition = {
				order = 5,
				type = 'select',
				name = L["Nameplate Target Radial Position"],
				desc = L["When target is off screen, position its nameplate radially around sides and bottom."],
				width = "full",
				values = {
					["1"] = L["Target Only"],
					["2"] = L["All in Combat"],
				},
				style = 'radio',
				get = function() return C_CVar.GetCVar('nameplateTargetRadialPosition') end,
				set = function(_, value) E.db.ElvUI_EltreumUI.cvars.nameplateTargetRadialPosition = value SetCVar('nameplateTargetRadialPosition', value) end,
			},
			cameraDistanceMaxZoomFactor = {
				type = 'range',
				name = L["Camera Distance Max Zoom Factor"],
				desc = L["Maximum Camera Zoom Out"],
				order = 5,
				min = 1,
				max = 3.4,
				step = 0.1,
				width = "full",
				get = function() return E.db.ElvUI_EltreumUI.cvars.cameraDistanceMaxZoomFactor end,
				set = function(_, value) E.db.ElvUI_EltreumUI.cvars.cameraDistanceMaxZoomFactor = value SetCVar('cameraDistanceMaxZoomFactor', value) end,
			},
			header1 = {
				order = 6,
				type = "description",
				name = "",
				width = 'full',
				image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
			},
			setup = {
				order = 7,
				type = 'group',
				inline = true,
				name = L["Setup CVars"],
				args = {
					generalVars = {
						order = 1,
						type = 'execute',
						name = L["General CVars"],
						func = function() ElvUI_EltreumUI:SetupCVars() ElvUI_EltreumUI:NameplateCVars() end,
						confirm = true,
					},
				},
			},
			generalDesc = {
				order = 8,
				type = 'group',
				inline = true,
				name = L["It will set these CVars:"],
				args = {
					cvarslist = {
						order = 1,
						type = 'description',
						fontSize = 'medium',
						name = '- autoLootDefault 1\n- ShowClassColorInFriendlyNameplate 1\n- removeChatDelay 1\n- autoQuestWatch 1\n- cameraDistanceMaxZoomFactor 2.6\n- nameplateLargerScale 1.2\n- nameplateMaxDistance 60\n- nameplateMinAlpha 1\n- nameplateMinScale 1\n- nameplateMotion 1\n- nameplateOccludedAlphaMult 0\n- nameplateOverlapH 0.8\n- nameplateOverlapV 1.1\n- nameplateSelectedScale 1\n- nameplateSelfAlpha 1\n- nameplateShowFriendlyMinions 0\n- nameplateOtherBottomInset 0.02\n- nameplateOtherTopInset 0.1\n- nameplateTargetRadialPosition 1\n- nameplateTargetBehindMaxDistance 40\n- UnitNameEnemyGuardianName 0\n- UnitNameEnemyMinionName 0\n- UnitNameEnemyPetName 0\n- UnitNameEnemyPlayerName 1\n- UnitNameEnemyTotemName 1\n- UnitNameNPC 1',
					},
				},
			},
		},
	}
	return cvars
end
