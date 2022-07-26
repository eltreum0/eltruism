local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

function ElvUI_EltreumUI:AFKOptions()
	local afk = {
		type = 'group',
		name = L["A.F.K"],
		icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\afk',
		order = 85,
		args = {
			header7 = {
				order = 1,
				type = "description",
				name = "",
				width = 'full',
				image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
			},
			afkmusic = {
				order = 2,
				type = 'group',
				inline = true,
				name = L["Play music while you are AFK"],
				args = {
					enable = {
					type = 'toggle',
					name = L["Enable"],
					order = 1,
					get = function() return E.db.ElvUI_EltreumUI.afkmusic.enable end,
					set = function(_, value) E.db.ElvUI_EltreumUI.afkmusic.enable = value end,
					},
				},
			},
		},
	}
	return afk
end
