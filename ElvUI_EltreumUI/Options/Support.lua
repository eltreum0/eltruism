local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

function ElvUI_EltreumUI:SupportOptions()
	local support = {
		type = 'group',
		name = L["Support"],
		icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\support',
		order = 98,
		args = {
			gitlink = {
				order = 1,
				type = 'input',
				width = 'full',
				name = L["Changelog"],
				get = function() return 'https://github.com/eltreum0/eltruism/blob/main/Changelog.md' end,
			},
			issues = {
				order = 2,
				type = 'input',
				width = 'full',
				name = L["Report issues and problems here:"],
				get = function() return 'https://github.com/eltreum0/eltruism/issues' end,
			},
			tukui = {
				order = 3,
				type = 'input',
				width = 'full',
				name = L["Addon on Tukui:"],
				get = function() return 'https://www.tukui.org/classic-tbc-addons.php?id=10' end,
			},
			curse = {
				order = 4,
				type = 'input',
				width = 'full',
				name = L["Addon on CurseForge:"],
				get = function() return 'https://www.curseforge.com/wow/addons/elvui-eltruism' end,
			},
		},
	}
	return support
end
