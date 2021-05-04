local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local sort = sort
local pairs = pairs
local tinsert = table.insert
local tconcat = table.concat
local ReloadUI = ReloadUI

-- Author list
local AUTHORS = {
	'|cff82B4ffEltreum|r',
}

-- Credits and Thank yous list
local THANKYOU = {
	'|cff0070DEAzilroka|r',
	'|cffC41F3BKringel|r',
	'|cffF58CBARepooc|r',
	'Blazeflack',
	'Botanica',
	'|T134297:15:15:0:0:64:64:5:59:5:59|t |cffff7d0aMerathilis|r',
	'|cff9482c9Darth Predator|r',
	'Caedis',
	'Elv',
	E:TextGradient('Simpy but his name might be shorter sometimes even though he fixes a lot of things', 1,.42,.78, 1,.56,.68, .66,.99,.98, .77,.52,1, 1,.48,.81, .98,.95,.68),
	'Tukui Community',
	'Shrom',
	'Pat',
	'|cff00c0faBenik|r',
	'|T136012:15:15:0:0:64:64:5:59:5:59|t |cff006fdcRubgrsch|r |T656558:15:15:0:0:64:64:5:59:5:59|t',
	'|TInterface/AddOns/ElvUI/Media/ChatLogos/FoxWarlock:15:15:0:0:64:64:5:59:5:59|t |cffff2020NihilisticPandemonium|r',
	'|TInterface/AddOns/ElvUI/Media/ChatLogos/Clover:15:15:0:0:64:64:5:59:5:59|t |cffFF7D0ALuckyone|r  -- Especially for allowing the usage of his installer/plugin as a base',
	'AcidWeb |TInterface/AddOns/ElvUI/Media/ChatLogos/Gem:15:15:-1:2:64:64:6:60:8:60|t',
	'Icons8 (www.icons8.com) for some of the icons. List in license.txt'
}

-- SortList
local function SortList(a, b)
	return E:StripString(a) < E:StripString(b)
end

sort(AUTHORS, SortList)
sort(THANKYOU, SortList)

-- Author table
for _, name in pairs(AUTHORS) do
	tinsert(ElvUI_EltreumUI.CreditsList, name)
end
local AUTHORS_STRING = tconcat(AUTHORS, '|n')

-- Thank you table
for _, name in pairs(THANKYOU) do
	tinsert(ElvUI_EltreumUI.CreditsList, name)
end
local THANKYOU_STRING = tconcat(THANKYOU, '|n')

-- EltreumUI ingame options
function ElvUI_EltreumUI:Configtable()
	-- Add EltreumUI version on top of the ElvUI config
	E.Options.name = E.Options.name .. " + " .. ElvUI_EltreumUI.Name .. format(" |cffffffff%s|r", ElvUI_EltreumUI.Version)
	E.Options.args.ElvUI_EltreumUI = {
		order = 6,
		type = 'group',
		name = ElvUI_EltreumUI.Name,
		args = {
			logo = {
				type = 'description',
				name = "",
				order = 6,
				image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\logohq', 512, 128 end,
			},
			installer = {
				order = 7,
				type = 'group',
				name = 'Installer',
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\install',
				args = {
					install = {
						order = 1,
						type = 'group',
						inline = true,
						name = 'Reinstall the plugin to reset settings',
						args = {
							generalVars = {
								order = 1,
								type = 'execute',
								name = 'Install',
								func = function() E:GetModule('PluginInstaller'):Queue(ElvUI_EltreumUI.InstallerData); E:ToggleOptionsUI(); end,
							},
						},
					},
				},
			},
			aurafilters = {
				type = 'group',
				name = 'Aura Filters',
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\aurafilter',
				order = 85,
				args = {
					header1 = {
						order = 1,
						type = 'header',
						name = 'Aura Filters',
					},
					listofauras = {
						order = 19,
						type = 'input',
						width = 'full',
						name = 'Import aura filters by copying the code below and going into Profiles > Import Profile.',
						get = function() return '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' end,
					},
				},
			},
			profiles = {
				type = 'group',
				name = 'Addon Profiles',
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\addon',
				order = 85,
				args = {
					plugins = {
						order = 1,
						type = 'group',
						inline = true,
						name = 'ElvUI Plugins',
						args = {
							addonskins = {
								order = 1,
								type = 'execute',
								name = '|cff16C3F2AddOn|r|cFFFFFFFFSkins|r',
								desc = 'Reset to Eltreum UI defaults.',
								func = function() ElvUI_EltreumUI:AddonSetupAS(); ReloadUI(); end,
								confirm = true,
							},
							projectazilroka = {
								order = 2,
								type = 'execute',
								name = '|cFF16C3F2Project|r|cFFFFFFFFAzilroka|r',
								desc = 'Reset to Eltreum UI defaults.',
								func = function() ElvUI_EltreumUI:AddonSetupPA(); ReloadUI(); end,
								confirm = true,
							},
						},
					},
					bossmods = {
						order = 2,
						type = 'group',
						inline = true,
						name = 'BossMods Profiles',
						args = {
							bigwigs = {
								order = 1,
								type = 'execute',
								name = 'BigWigs',
								desc = 'Reset to Eltreum UI defaults.',
								func = function() ElvUI_EltreumUI:AddonSetupBW(); ReloadUI(); end,
								confirm = true,
							},
							dbm = {
								order = 2,
								type = 'execute',
								name = 'DBM',
								desc = 'Reset to Eltreum UI defaults.',
								func = function() ElvUI_EltreumUI:AddonSetupDBM(); ReloadUI(); end,
								confirm = true,
							},
						},
					},
					addons = {
						order = 4,
						type = 'group',
						inline = true,
						name = 'Addon Profiles',
						args = {
							dynamiccam = {
								order = 1,
								type = 'execute',
								name = 'Dynamic Cam',
								desc = 'Reset to Eltreum UI defaults.',
								func = function() ElvUI_EltreumUI:AddonSetupDynamicCam(); ReloadUI(); end,
								confirm = true,
							},
							immersion = {
								order = 2,
								type = 'execute',
								name = 'Immersion',
								desc = 'Reset to Eltreum UI defaults.',
								func = function() ElvUI_EltreumUI:AddonSetupImmersion(); ReloadUI(); end,
								confirm = true,
							},
							gladiusex = {
								order = 3,
								type = 'execute',
								name = 'Gladius Ex',
								desc = 'Reset to Eltreum UI defaults.',
								func = function() ElvUI_EltreumUI:AddonSetupGladiusEx(); ReloadUI(); end,
								confirm = true,
							},
							exorsus = {
								order = 4,
								type = 'execute',
								name = 'Exorsus Raid Tools',
								desc = 'Reset to Eltreum UI defaults.',
								func = function() ElvUI_EltreumUI:AddonSetupExRT(); ReloadUI(); end,
								confirm = true,
							},
							nameplatesct = {
								order = 5,
								type = 'execute',
								name = 'Nameplate Scrolling Combat Text',
								desc = 'Reset to Eltreum UI defaults.',
								func = function() ElvUI_EltreumUI:AddonSetupNameplateSCT(); ReloadUI(); end,
								confirm = true,
							},
							fct = {
								order = 6,
								type = 'execute',
								name = 'Floating Combat Text',
								desc = 'Reset to Eltreum UI defaults.',
								func = function() ElvUI_EltreumUI:AddonSetupFCT(); ReloadUI(); end,
								confirm = true,
							},
							details = {
								order = 7,
								type = 'execute',
								name = 'Details',
								desc = 'Reset to Eltreum UI defaults.',
								func = function() ElvUI_EltreumUI:AddonSetupDT(); ReloadUI(); end,
								confirm = true,
							},
						},
					},
				},
			},
			actionbars = {
				type = 'group',
				name = 'Custom Glow',
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\customglow',
				order = 85,
				args = {
					glow = {
						type = 'group',
						name = 'Replace Blizzards Default Glow with a Custom class colored Glow',
						guiInline = true,
						order = 10,
						args = {
							enable = {
							type = 'toggle',
							name = 'Enable',
							order = 1,
							get = function() return E.private.ElvUI_EltreumUI.glow.enable end,
							set = function(_, value) E.private.ElvUI_EltreumUI.glow.enable = value; E:StaticPopup_Show('PRIVATE_RL') end,
							},
							addagaphere = {
							order = 2,
							type = "description",
							name = "",
							},
							addanothergapforfun = {
							order = 2,
							type = "description",
							name = "",
							},
							procselection = {
							order = 2,
							type = 'group',
							name = 'Select a Type',
								args = {
									yetanothergap = {
									order = 2,
									type = "description",
									name = "",
									},
									autocast = {
										type = 'toggle',
										name = 'Autocast',
										order = 10,
										desc = 'Adds an autocast style glow using class color',
										disabled = function() return not E.private.ElvUI_EltreumUI.glow.enable or E.private.ElvUI_EltreumUI.glow.pixel or E.private.ElvUI_EltreumUI.glow.blizzard end,
										get = function(info) return E.private.ElvUI_EltreumUI.glow.autocast end,
										set = function(info, value) E.private.ElvUI_EltreumUI.glow.autocast = value; E:StaticPopup_Show('PRIVATE_RL') end,
									},
									pixel = {
										type = 'toggle',
										name = 'Pixel',
										order = 12,
										desc = 'Adds a pixel style glow using class color',
										disabled = function() return not E.private.ElvUI_EltreumUI.glow.enable or E.private.ElvUI_EltreumUI.glow.autocast or E.private.ElvUI_EltreumUI.glow.blizzard end,
										get = function(info) return E.private.ElvUI_EltreumUI.glow.pixel end,
										set = function(info, value) E.private.ElvUI_EltreumUI.glow.pixel = value; E:StaticPopup_Show('PRIVATE_RL') end,
									},
									blizzard = {
										type = 'toggle',
										name = 'Blizzard',
										order = 11,
										desc = 'Adds a Blizzard style glow using class color',
										disabled = function() return not E.private.ElvUI_EltreumUI.glow.enable or E.private.ElvUI_EltreumUI.glow.autocast or E.private.ElvUI_EltreumUI.glow.pixel end,
										get = function(info) return E.private.ElvUI_EltreumUI.glow.blizzard end,
										set = function(info, value) E.private.ElvUI_EltreumUI.glow.blizzard = value; E:StaticPopup_Show('PRIVATE_RL') end,
									},
								},
							},
						},
					},
				},
			},
			cvars = {
				order = 85,
				type = 'group',
				name = 'CVars',
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\cvar',
				args = {
					setup = {
						order = 1,
						type = 'group',
						inline = true,
						name = 'Setup CVars',
						args = {
							generalVars = {
								order = 1,
								type = 'execute',
								name = 'General CVars',
								func = function() ElvUI_EltreumUI:SetupCVars(); end,
								confirm = true,
							},
						},
					},
					generalDesc = {
						order = 2,
						type = 'group',
						inline = true,
						name = 'It will set these CVars:',
						args = {
							cvars = {
								order = 1,
								type = 'description',
								fontSize = 'medium',
								name = '- autoLootDefault true\n- autoQuestWatch 1\n- cameraDistanceMaxZoomFactor 2.6\n- nameplateLargerScale 1.2\n- nameplateMaxDistance 60\n- nameplateMinAlpha 1\n- nameplateMinScale 1\n- nameplateMotion 1\n- nameplateOccludedAlphaMult 0\n- nameplateOverlapH 0.8\n- nameplateOverlapV 1.1\n- nameplateSelectedScale 1\n- nameplateSelfAlpha 1\n- nameplateShowFriendlyMinions 0\n- removeChatDelay 1\n- UnitNameEnemyGuardianName 0\n- UnitNameEnemyMinionName 0\n- UnitNameEnemyPetName 0\n- UnitNameEnemyPlayerName 1\n- UnitNameEnemyTotem 1',
							},
						},
					},
				},
			},
			partyraidsettings = {
				type = 'group',
				name = 'Party/Raid',
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\party',
				order = 85,
				args = {
					partyraiddeath = {
						type = 'group',
						name = 'Play a sound when someone dies in Party or Raid',
						guiInline = true,
						order = 10,
						args = {
							enable = {
							type = 'toggle',
							name = 'Enable',
							order = 1,
							get = function() return E.private.ElvUI_EltreumUI.partyraiddeath.enable end,
							set = function(_, value) E.private.ElvUI_EltreumUI.partyraiddeath.enable = value end,
							},
							addagaphere = {
							order = 2,
							type = "description",
							name = "",
							},
							addanothergapforfun = {
							order = 2,
							type = "description",
							name = "",
							},
							soundselection = {
							order = 2,
							type = 'group',
							name = 'Select a Sound',
								args = {
									yetanothergap = {
									order = 2,
									type = "description",
									name = "",
									},
									bruh = {
										type = 'toggle',
										name = 'Bruh',
										order = 5,
										disabled = function() return not E.private.ElvUI_EltreumUI.partyraiddeath.enable or E.private.ElvUI_EltreumUI.partyraiddeath.robloxoof or E.private.ElvUI_EltreumUI.partyraiddeath.shame or E.private.ElvUI_EltreumUI.partyraiddeath.wow or E.private.ElvUI_EltreumUI.partyraiddeath.mario end,
										get = function(info) return E.private.ElvUI_EltreumUI.partyraiddeath.bruh end,
										set = function(info, value) E.private.ElvUI_EltreumUI.partyraiddeath.bruh = value; PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\bruh.mp3", "Dialog") end,
									},
									robloxoof = {
										type = 'toggle',
										name = 'Oof',
										order = 6,
										disabled = function() return not E.private.ElvUI_EltreumUI.partyraiddeath.enable or E.private.ElvUI_EltreumUI.partyraiddeath.bruh or E.private.ElvUI_EltreumUI.partyraiddeath.shame or E.private.ElvUI_EltreumUI.partyraiddeath.wow or E.private.ElvUI_EltreumUI.partyraiddeath.mario end,
										get = function(info) return E.private.ElvUI_EltreumUI.partyraiddeath.robloxoof end,
										set = function(info, value) E.private.ElvUI_EltreumUI.partyraiddeath.robloxoof = value; PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\oof.mp3", "Dialog") end,
									},
									yetanothergap2 = {
									order = 8,
									type = "description",
									name = "",
									},
									shame = {
										type = 'toggle',
										name = 'Shame',
										order = 13,
										disabled = function() return not E.private.ElvUI_EltreumUI.partyraiddeath.enable or E.private.ElvUI_EltreumUI.partyraiddeath.bruh or E.private.ElvUI_EltreumUI.partyraiddeath.robloxoof or E.private.ElvUI_EltreumUI.partyraiddeath.wow or E.private.ElvUI_EltreumUI.partyraiddeath.mario end,
										get = function(info) return E.private.ElvUI_EltreumUI.partyraiddeath.shame end,
										set = function(info, value) E.private.ElvUI_EltreumUI.partyraiddeath.shame = value; PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\shame.mp3", "Dialog") end,
									},
									wowsound = {
										type = 'toggle',
										name = 'Wow',
										order = 14,
										disabled = function() return not E.private.ElvUI_EltreumUI.partyraiddeath.enable or E.private.ElvUI_EltreumUI.partyraiddeath.bruh or E.private.ElvUI_EltreumUI.partyraiddeath.robloxoof or E.private.ElvUI_EltreumUI.partyraiddeath.shame or E.private.ElvUI_EltreumUI.partyraiddeath.mario end,
										get = function(info) return E.private.ElvUI_EltreumUI.partyraiddeath.wow end,
										set = function(info, value) E.private.ElvUI_EltreumUI.partyraiddeath.wow = value; PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\wow.mp3", "Dialog") end,
									},
									yetanothergap3 = {
									order = 15,
									type = "description",
									name = "",
									},
									mariosound = {
										type = 'toggle',
										name = 'Mario',
										order = 14,
										disabled = function() return not E.private.ElvUI_EltreumUI.partyraiddeath.enable or E.private.ElvUI_EltreumUI.partyraiddeath.bruh or E.private.ElvUI_EltreumUI.partyraiddeath.robloxoof or E.private.ElvUI_EltreumUI.partyraiddeath.shame or E.private.ElvUI_EltreumUI.partyraiddeath.wow end,
										get = function(info) return E.private.ElvUI_EltreumUI.partyraiddeath.mario end,
										set = function(info, value) E.private.ElvUI_EltreumUI.partyraiddeath.mario = value; PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\mariodeath.mp3", "Dialog") end,
									},

								},
							},
						},
					},
				},
			},
			quests = {
				type = 'group',
				name = 'Quests',
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\quest',
				order = 85,
				args = {
					questsettings = {
						order = 1,
						type = 'group',
						inline = true,
						name = 'Collapse Quests during Raid Encounters',
						get = function(info) return E.private.ElvUI_EltreumUI.questsettings[info[#info]] end,
						set = function(info, value) E.private.ElvUI_EltreumUI.questsettings[info[#info]] = value end,
						args = {
							enable = {
								order = 5,
								type = 'toggle',
								name = 'Enable',
								desc = 'Add an ETA to waypoints',
							},
						},
					},
				},
			},
			maps = {
				type = 'group',
				name = 'Maps',
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\map',
				order = 85,
				args = {
					waypointetasetting = {
						order = 1,
						type = 'group',
						inline = true,
						name = 'Add a time to arrive below the waypoint',
						get = function(info) return E.private.ElvUI_EltreumUI.waypointetasetting[info[#info]] end,
						set = function(info, value) E.private.ElvUI_EltreumUI.waypointetasetting[info[#info]] = value; E:StaticPopup_Show('PRIVATE_RL') end,
						args = {
							explainer = {
								order = 1,
								type = "description",
								name = 'The time will be calculated based on player speed and distance',
							},
							explainer2 = {
								order = 2,
								type = "description",
								name = 'If the player is not moving then *** will show up since time cannot be calculated',
							},
							explainer3 = {
								order = 3,
								type = "description",
								name = 'If you move away from the waypoint the time will just increase',
							},
							explainer4 = {
								order = 4,
								type = "description",
								name = '',
							},

							enable = {
								order = 5,
								type = 'toggle',
								name = 'Enable',
								desc = 'Add an ETA to waypoints',
							},
						},
					},
				},
			},
			media = {
				type = 'group',
				name = 'Media',
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\media',
				order = 85,
				args = {
					defaults = {
						order = 1,
						type = 'group',
						inline = true,
						name = 'Reset Fonts, Textures & Skins',
						args = {
							private = {
								order = 1,
								type = 'execute',
								name = 'Reset Media',
								desc = 'Reset Fonts, Textures, Skins to Eltreum UI defaults.',
								func = function() ElvUI_EltreumUI:SetupPrivate(); E:StaggeredUpdateAll(nil, true) end,
								confirm = true,
							},
							addagaphereforfonts = {
							order = 2,
							type = "description",
							name = "",
							},
							kimberley = {
								order = 3,
								type = 'execute',
								name = 'Set Kimberley as Font',
								desc = 'This will set all ElvUI fonts as Kimberley',
								func = function() ElvUI_EltreumUI:SetupFontsKimberley(); E:StaggeredUpdateAll(nil, true) end,
								confirm = true,
							},
							exo2 = {
								order = 3,
								type = 'execute',
								name = 'Set Exo2 as Font',
								desc = 'This will set all ElvUI fonts as Exo2',
								func = function() ElvUI_EltreumUI:SetupFontsExo2(); E:StaggeredUpdateAll(nil, true) end,
								confirm = true,
							},
							gotham = {
								order = 3,
								type = 'execute',
								name = 'Set Gotham as Font',
								desc = 'This will set all ElvUI fonts as Gotham',
								func = function() ElvUI_EltreumUI:SetupFontsGotham(); E:StaggeredUpdateAll(nil, true) end,
								confirm = true,
							},
							roboto = {
								order = 3,
								type = 'execute',
								name = 'Set Roboto as Font',
								desc = 'This will set all ElvUI fonts as Roboto',
								func = function() ElvUI_EltreumUI:SetupFontsRoboto(); E:StaggeredUpdateAll(nil, true) end,
								confirm = true,
							},
						},
					},
				},
			},
			nameplates = {
				type = 'group',
				name = 'Nameplate',
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\nameplate',
				order = 85,
				args = {
					nameplateOptions = {
						order = 1,
						type = 'group',
						inline = true,
						name = 'Toggle Colored Class Borders & Glow',
						get = function(info) return E.private.ElvUI_EltreumUI.nameplateOptions[info[#info]] end,
						set = function(info, value) E.private.ElvUI_EltreumUI.nameplateOptions[info[#info]] = value; E:StaticPopup_Show('PRIVATE_RL') end,
						args = {
							classhover = {
								order = 1,
								type = 'toggle',
								name = 'Class color hover',
								desc = 'Change the color of the hover to be class colored',
								get = function(info) return E.private.ElvUI_EltreumUI.nameplateOptions.ClassColorGlow end,
								set = function(info, value) E.private.ElvUI_EltreumUI.nameplateOptions.ClassColorGlow = value; E:StaticPopup_Show('PRIVATE_RL') end,
							},
							classborder = {
								order = 2,
								type = 'toggle',
								name = 'Class color border',
								desc = 'Change the color of the border glow to be class bordered in nameplates',
								get = function(info) return E.private.ElvUI_EltreumUI.nameplateOptions.ClassBorderNameplate end,
								set = function(info, value) E.private.ElvUI_EltreumUI.nameplateOptions.ClassBorderNameplate = value; E:StaticPopup_Show('PRIVATE_RL') end,
							},
						},
					},
					addsomegap = {
							order = 2,
							type = "description",
							name = "",
					},
					friendlynameplate = {
						order = 2,
						type = 'group',
						inline = true,
						name = 'Show Friendly Nameplates Outside Instances, hide inside instances',
						args = {
							desc = {
								order = 1,
								type = 'toggle',
								name = 'Enable',
								desc = 'Toogle On and Off',
								get = function() return E.private.ElvUI_EltreumUI.friendlynameplatetoggle.enable end,
								set = function(_, value) E.private.ElvUI_EltreumUI.friendlynameplatetoggle.enable = value end,
							},
						}
					},
					verywidenameplate = {
						order = 99,
						type = 'group',
						inline = true,
						name = 'Wide nameplate debuffs and buffs',
						args = {
							desc = {
								order = 1,
								type = 'toggle',
								name = 'Enable',
								desc = 'Toogle On and Off',
								get = function() return E.private.ElvUI_EltreumUI.widenameplate.enable end,
								set = function(_, value) E.private.ElvUI_EltreumUI.widenameplate.enable = value; E:StaticPopup_Show('PRIVATE_RL') end,
							},
						}
					},
				},
			},
			stealth = {
				type = 'group',
				name = 'Stealth Vignette',
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\stealth',
				order = 85,
				args = {
					stealthOptions = {
						order = 1,
						type = 'group',
						inline = true,
						name = 'Toggle a Stealth Effect',
						get = function(info) return E.private.ElvUI_EltreumUI.stealthOptions[info[#info]] end,
						set = function(info, value) E.private.ElvUI_EltreumUI.stealthOptions[info[#info]] = value; E:StaticPopup_Show('PRIVATE_RL') end,
						args = {
							stealthoptions = {
								order = 1,
								type = 'toggle',
								name = 'Enable',
								desc = 'Add a vignette while in stealth',
								get = function(info) return E.private.ElvUI_EltreumUI.stealthOptions.stealtheffect end,
								set = function(info, value) E.private.ElvUI_EltreumUI.stealthOptions.stealtheffect = value; E:StaticPopup_Show('PRIVATE_RL') end,
							},
						},
					},
				},
			},
			afk = {
				type = 'group',
				name = 'AFK',
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\afk',
				order = 85,
				args = {
					afkmusic = {
						order = 1,
						type = 'group',
						inline = true,
						name = 'Play a music of your character race while AFK',
						get = function(info) return E.private.ElvUI_EltreumUI.afkmusic[info[#info]] end,
						set = function(info, value) E.private.ElvUI_EltreumUI.afkmusic[info[#info]] = value;end,
						args = {
							afktoggle = {
								order = 1,
								type = 'toggle',
								name = 'Enable',
								desc = 'Play music while AFK',
								get = function(info) return E.private.ElvUI_EltreumUI.afkmusic.enable end,
								set = function(info, value) E.private.ElvUI_EltreumUI.afkmusic.enable = value; end,
							},
						},
					},
				},
			},
			weakauras = {
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
					explainer7 = {
						order = 2,
						type = "description",
						name = 'My WeakAuras are available here, but are not focused on one class. Consider them more like upcoming features.',
					},
					addaspacehere = {
						order = 3,
						type = "description",
						name = '',
					},
					wago = {
						order = 4,
						type = 'input',
						width = 'normal',
						name = 'All weakauras',
						get = function() return 'wago.io/p/Eltreum' end,
					},
					addsomegap = {
							order = 5,
							type = "description",
							name = "",
					},
					nameplatepowerbar = {
						order = 6,
						type = 'input',
						width = 'full',
						name = 'Nameplate Power Bar',
						get = function() return 'https://wago.io/MHkYMit7S' end,
					},
					addsomegap2 = {
							order = 7,
							type = "description",
							name = "",
					},
					bossnameplate = {
						order = 8,
						type = 'input',
						width = 'full',
						name = 'Boss nameplate at base',
						get = function() return 'https://wago.io/M7yrCgMnE' end,
					},
					addsomegap3 = {
							order = 9,
							type = "description",
							name = "",
					},
					executenameplate = {
						order = 10,
						type = 'input',
						width = 'full',
						name = 'Executes next to nameplates',
						get = function() return 'https://wago.io/afJKwFwAX' end,
					},
				},
			},
			discord = {
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
						name = 'Join the Discord if you have any questions or issues',
					},
					addaspacehere4 = {
						order = 3,
						type = "description",
						name = '',
					},
					discordinvitelink = {
						order = 19,
						type = 'input',
						width = 'full',
						name = '',
						get = function() return 'https://discord.gg/cXfA56gmYW' end,
					},
				},
			},
			credits = {
				type = 'group',
				name = 'Credits',
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\credits',
				order = 97,
				args = {
					author = {
						order = 1,
						type = 'group',
						inline = true,
						name = 'Author',
						args = {
							desc = {
								order = 1,
								type = 'description',
								fontSize = 'medium',
								name = AUTHORS_STRING,
							},
						},
					},
					thankyou = {
						order = 2,
						type = 'group',
						inline = true,
						name = 'Credits and Thank yous',
						args = {
							desc = {
								order = 1,
								type = 'description',
								fontSize = 'medium',
								name = THANKYOU_STRING,
							},
						},
					},
				},
			},
			support = {
				type = 'group',
				name = 'Support',
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\support',
				order = 98,
				args = {
					changelog = {
						order = 1,
						type = 'input',
						width = 'full',
						name = 'New commits, basically a preview of fixes or upcoming features',
						get = function() return 'https://git.tukui.org/eltreum/eltruism/-/commits/master' end,
					},
					issues = {
						order = 2,
						type = 'input',
						width = 'full',
						name = 'Report issues and problems here:',
						get = function() return 'https://git.tukui.org/eltreum/eltruism/-/issues' end,
					},
					tukui = {
						order = 3,
						type = 'input',
						width = 'full',
						name = 'Addon on tukui:',
						get = function() return 'https://www.tukui.org/addons.php?id=209' end,
					},
					curse = {
						order = 4,
						type = 'input',
						width = 'full',
						name = 'Addon on curse:',
						get = function() return 'https://www.curseforge.com/wow/addons/elvui-eltruism' end,
					},
				},
			},
		},
	}

	for _, func in pairs(ElvUI_EltreumUI.Config) do
		func()
	end
end
