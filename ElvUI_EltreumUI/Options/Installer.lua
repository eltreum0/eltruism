local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

function ElvUI_EltreumUI:InstallerOptions()
	local installer = {
		order = 7,
		type = 'group',
		name = L["Installer"],
		icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\install',
		args = {
			header5 = {
				order = 1,
				type = "description",
				name = L["Eltruism Installer"],
				width = 'full',
				image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
			},
			install = {
				order = 2,
				type = 'group',
				inline = true,
				name = "",
				args = {
					pluginagain = {
						order = 1,
						type = 'execute',
						name = L["Launch Eltruism Installer"],
						width = 'full',
						desc = L["Launches the Eltruism install prompt"],
						func = function() E:GetModule('PluginInstaller'):Queue(ElvUI_EltreumUI.InstallerData) E:ToggleOptionsUI() end,
					},
					eltruismsettings = {
						order = 2,
						type = 'execute',
						name = L["Reset/Update Eltruism Settings"],
						width = 'full',
						desc = L["Resets/Updates Eltruism Settings to Eltreum's Defaults"],
						func = function() ElvUI_EltreumUI:UpdateSettings() E:StaticPopup_Show('CONFIG_RL') end,
					},
				},
			},
			header6 = {
				order = 3,
				type = "description",
				name = L["Nameplates"],
				width = 'full',
				image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
			},
			resetnameplates = {
				order = 4,
				type = 'group',
				inline = true,
				name = "",
				args = {
					nameplateagain = {
						order = 1,
						type = 'execute',
						name = L["Reset nameplates to Eltruism settings"],
						width = 'full',
						func = function() ElvUI_EltreumUI:SetupNamePlates('ElvUI') ElvUI_EltreumUI:ResolutionOutline() end,
					},
				},
			},
			header7 = {
				order = 5,
				type = "description",
				name = L["Chat"],
				width = 'full',
				image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
			},
			resetchat = {
				order = 6,
				type = 'group',
				inline = true,
				name = "",
				args = {
					resetchatagain = {
						order = 1,
						type = 'execute',
						name = L["Reset Chat to ElvUI Settings"],
						width = 'full',
						func = function() E:SetupChat() ElvUI_EltreumUI:Print(L["ElvUI Chat has been set."]) end,
					},
				},
			},
			header8 = {
				order = 7,
				type = "description",
				name = L["Layouts"],
				width = 'full',
				image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
			},
			resetlayout = {
				order = 8,
				type = 'group',
				inline = true,
				name = "",
				args = {
					resetdps = {
						order = 1,
						type = 'execute',
						name = L["Reset layout to Eltruism DPS/Tank"],
						width = 'full',
						func = function() E.data:SetProfile('Eltreum DPS/Tank ('..E.mynameRealm..')') ElvUI_EltreumUI:SetupGeneralLayout() ElvUI_EltreumUI:SetupLayoutDPS() end,
					},
					resethealer = {
						order = 1,
						type = 'execute',
						name = L["Reset layout to Eltruism Healer"],
						width = 'full',
						func = function() E.data:SetProfile('Eltreum Healer ('..E.mynameRealm..')') ElvUI_EltreumUI:SetupGeneralLayout() ElvUI_EltreumUI:SetupLayoutHealer() end,
					},
				},
			},
			header9 = {
				order = 9,
				type = "description",
				name = L["Skip Plugins"],
				width = 'full',
				image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
			},
			skipplugin = {
				order = 10,
				type = 'group',
				inline = true,
				name = "",
				args = {
					resethealer = {
						order = 1,
						type = 'execute',
						name = L["Skip Plugins install message"],
						desc = L["Make the warnings to install profiles for other plugins stop"],
						width = 'full',
						func = function()
							E.private.ElvUI_EltreumUI.isInstalled.sle = true
							E.private.ElvUI_EltreumUI.isInstalled.windtools = true
							E.private.ElvUI_EltreumUI.isInstalled.projectazilroka = true
						end,
					},
				},
			},
			header10 = {
				order = 11,
				type = "description",
				name = L["Clear Details! Damage Meter tables to free up memory"],
				width = 'full',
				image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
			},
			detailstable = {
				order = 12,
				type = 'group',
				name = "",
				width = "full",
				inline = true,
				args = {
					detailstableexecute = {
						order = 12,
						type = 'execute',
						name = L["Clear Details Tables"],
						desc = L["Set Details tables to be empty"],
						width = 'full',
						confirm = true,
						func = function() ElvUI_EltreumUI:EmptyDetailsTable() end,
					},
				},
			},
		},
	}
	return installer
end
