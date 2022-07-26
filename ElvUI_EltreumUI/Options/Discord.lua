local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

function ElvUI_EltreumUI:OptionsDiscord()
	local discord = {
		type = 'group',
		name = 'Discord',
		icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\discord',
		order = 96,
		args = {
			logodiscord = {
				type = 'description',
				name = "",
				order = 1,
				image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\disc', 256, 128 end,
			},
			explainer8 = {
				order = 2,
				type = "description",
				name = L["Join the Discord if you have any questions or issues"],
			},
			addaspacehere4 = {
				order = 3,
				type = "description",
				name = L["Keep in mind the discord is in English"],
			},
			discordinvitelink = {
				order = 19,
				type = 'input',
				width = 'full',
				name = '',
				get = function() return 'https://discord.gg/rBXNxUY6pk' end,
			},
		},
	}
	return discord
end
