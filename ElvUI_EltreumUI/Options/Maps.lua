local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

function ElvUI_EltreumUI:MapOptions()
	local maps = {
		type = 'group',
		name = L["Maps"],
		icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\map',
		order = 85,
		args = {
			header3 = {
				order = 5,
				type = "description",
				name = "",
				width = 'full',
				image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
			},
			mapcombathide = {
				order = 6,
				type = 'group',
				inline = true,
				name = L["Minimap"],
				args = {
					explainer4 = {
						order = 4,
						type = "description",
						name = L["Hide Minimap while in Combat"],
					},
					enable = {
						order = 5,
						type = 'toggle',
						name = 'Enable',
						desc = L["Automatically hide the Minimap in combat"],
						get = function() return E.db.ElvUI_EltreumUI.otherstuff.mapcombathide end,
						set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.mapcombathide = value E:StaticPopup_Show('CONFIG_RL') end,
					},
				},
			},
		},
	}
	return maps
end
