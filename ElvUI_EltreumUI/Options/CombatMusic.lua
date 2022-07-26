local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

function ElvUI_EltreumUI:CombatMusicOptions()
	local combatmusic = {
		type = 'group',
		name = L["Combat Music"],
		icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\music',
		order = 85,
		args = {
			header1 = {
				order = 11,
				type = "description",
				name = "",
				width = 'full',
				image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
			},
			moremusicsettings = {
				order = 1,
				type = 'group',
				inline = true,
				name = L["Play music during combat"],
				args = {
					enable = {
						order = 1,
						type = 'toggle',
						name = L["Enable Combat Music"],
						desc = L["Enable music during combat"],
						width = 'full',
						get = function() return E.private.ElvUI_EltreumUI.combatmusic.enable end,
						set = function(_, value) E.private.ElvUI_EltreumUI.combatmusic.enable = value E:StaticPopup_Show('PRIVATE_RL') end,
					},
					enableboss = {
						order = 1,
						type = 'toggle',
						name = L["Enable Boss Music"],
						desc = L["Enable music during combat"],
						width = 'full',
						get = function() return E.private.ElvUI_EltreumUI.combatmusic.bossmusic end,
						set = function(_, value) E.private.ElvUI_EltreumUI.combatmusic.bossmusic = value E:StaticPopup_Show('PRIVATE_RL') end,
					},
					instancemusic = {
						order = 2,
						type = 'toggle',
						name = L["Disable Combat Music in Instances"],
						desc = L["Disable music during combat in instances"],
						width = 'full',
						disabled = function() return not E.private.ElvUI_EltreumUI.combatmusic.enable end,
						get = function() return E.private.ElvUI_EltreumUI.combatmusic.disableinstance end,
						set = function(_, value) E.private.ElvUI_EltreumUI.combatmusic.disableinstance = value E:StaticPopup_Show('PRIVATE_RL') end,
					},
					header2 = {
						order = 2,
						type = "description",
						name = L["Normal Combat Music"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					combatpathtofile = {
						order = 3,
						type = 'group',
						inline = true,
						name = L["Name of file inside Interface\\Addons"],
						args = {
							howtomusic = {
							order = 2,
							type = "description",
							name = L["Example: "].."mymusic.mp3",
							},
							somegap = {
								order = 3,
								type = "description",
								name = "",
							},
							soundpath = {
								order = 6,
								icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\music',
								type = 'input',
								name = '',
								desc = '',
								width = 'full',
								get = function() return E.private.ElvUI_EltreumUI.combatmusic.musicfile end,
								set = function(_, value) E.private.ElvUI_EltreumUI.combatmusic.musicfile = value E:StaticPopup_Show('PRIVATE_RL') end,
							}
						}
					},
					header3 = {
						order = 6,
						type = "description",
						name = L["Boss Combat Music"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					bosspathtofile = {
						order = 7,
						type = 'group',
						inline = true,
						name = L["Name of file inside Interface\\Addons"],
						args = {
							howtomusic = {
							order = 2,
							type = "description",
							name = L["Example: "].."mymusic.mp3",
							},
							somegap = {
								order = 3,
								type = "description",
								name = "",
							},
							soundpath = {
								order = 6,
								icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\music',
								type = 'input',
								name = '',
								desc = '',
								width = 'full',
								get = function() return E.private.ElvUI_EltreumUI.combatmusic.bossfile end,
								set = function(_, value) E.private.ElvUI_EltreumUI.combatmusic.bossfile = value E:StaticPopup_Show('PRIVATE_RL') end,
							}
						}
					},
				},
			},
		},
	}
	return combatmusic
end
