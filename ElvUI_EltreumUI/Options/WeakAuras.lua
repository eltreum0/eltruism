local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

function ElvUI_EltreumUI:OptionsWeakAuras()
	local weakauras = {
		type = 'group',
		icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\weakauras',
		name = 'WeakAuras',
		order = 95,
		args = {
			header1 = {
				order = 1,
				type = 'header',
				name = 'WeakAuras',
			},
			explain1 = {
				order = 2,
				type = "description",
				name = L["You can set your Weakauras to anchor to custom locations making it easier to move them"],
			},
			explain2 = {
				order = 3,
				type = "description",
				name = L["In order to use this feature, simply go to your Weakaura, and go to its Group options, scroll down to Position Settings and set the Anchored To Select Frame, then type either |cff82B4ffEltruismWA|r or |cff82B4ffEltruismConsumablesWA|r to anchor the weakaura to the preset location"],
			},
			explain3 = {
				order = 4,
				type = "description",
				name = L["Setting "].."|cff82B4ffEltruismWA|r"..L[" or "].."|cff82B4ffEltruismConsumablesWA|r"..L[" as the anchor will move them to the locations, keep in mind you might need to change the X and Y offset of the weakaura to zero"],
			},
			explainer1 = {
				order = 5,
				type = "group",
				name = L["How to use the Anchors"],
				inline = true,
				args = {
					addaspaceher544e = {
						order = 86,
						type = "description",
						name = '',
					},
					explainer7 = {
						order = 87,
						type = "description",
						name = L["Open WeakAuras, go to your group Weakauras and in Group change Position Settings > Anchored To > Select Frame > EltruismWA or EltruismConsumablesWA"],
					},
					demopic = {
						order = 98,
						type = "description",
						name = "",
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\WADemo', 512, 1024 end,
					},
				},
			},
		},
	}
	return weakauras
end
