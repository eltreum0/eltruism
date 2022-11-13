local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local tinsert = _G.table.insert
local tconcat = _G.table.concat
local unpack = _G.unpack
local select = _G.select
local sort = _G.sort
local pairs = _G.pairs
local table = _G.table
local format = _G.format
local MINIMAP_LABEL = _G.MINIMAP_LABEL
local AURAS = _G.AURAS
local BINDING_HEADER_CHAT = _G.BINDING_HEADER_CHAT
local HONOR = _G.HONOR
local CURRENCY = _G.CURRENCY
local tostring = _G.tostring
local PlaySoundFile = _G.PlaySoundFile
local tonumber = _G.tonumber
local SetCVar = _G.SetCVar
local C_CVar = _G.C_CVar
local OKAY = _G.OKAY
local Item = _G.Item
local tremove = _G.tremove
local AceGUIWidgetLSMlists = _G.AceGUIWidgetLSMlists

--Author list
local AUTHORS = {
	'|cff82B4ffEltreum|r',
}

-- Credits and Thank yous list
local THANKYOU = {
	'|cff0070DEAzilroka|r',
	'|cffC41F3BKringel|r',
	'|cFF99CCFFAftermathh|r',
	'|cffF58CBARepooc|r Especially for the huge helps',
	'Blazeflack',
	'Botanica',
	'|cffFFC44DHydra|r',
	'|T134297:15:15:0:0:64:64:5:59:5:59|t |cffff7d0aMerathilis|r',
	'|cff9482c9Darth Predator|r',
	'Caedis',
	'Elv',
	E:TextGradient('Simpy, his name might be shorter sometimes even though he fixes a lot of things', 0.27,0.72,0.86, 0.51,0.36,0.80, 0.69,0.28,0.94, 0.94,0.28,0.63, 1.00,0.51,0.00, 0.27,0.96,0.43),
	--E:TextGradient('Simpy he fixes a lot of things but he cant see power colors right', 0.27,0.72,0.86, 0.51,0.36,0.80, 0.69,0.28,0.94, 0.94,0.28,0.63, 1.00,0.51,0.00, 0.27,0.96,0.43),
	'Shrom',
	'Pat',
	'|cff00c0faBenik|r',
	'|T136012:15:15:0:0:64:64:5:59:5:59|t |cff006fdcRubgrsch|r',
	'|cff8788EENihilistzsche|r',
	'|TInterface/AddOns/ElvUI/Core/Media/ChatLogos/Clover:15:15:0:0:64:64:5:59:5:59|t |cffFF7D0ALuckyone|r Especially for allowing the usage of his installer/plugin as a model',
	'|TInterface/AddOns/ElvUI_EltreumUI/Media/Textures/releaf:15:15:0:0:64:64:5:59:5:59|t |cffFF7D0AReleaf|r for the alternate class icons',
	'|TInterface/AddOns/ElvUI_EltreumUI/Media/Textures/tukuidiscord:15:15:0:0:64:64:5:59:5:59|t Tukui Community for all the help and motivation',
	'|TInterface/AddOns/ElvUI_EltreumUI/Media/Textures/addonsdiscord:15:15:0:0:64:64:5:59:5:59|t WoW AddOns; for answering a lot of questions',
	'AcidWeb |TInterface/AddOns/ElvUI/Core/Media/ChatLogos/Gem:15:15:-1:2:64:64:6:60:8:60|t',
	'|cff8E44ADB|r|cff2ECC71lin|r|cff3498DBkii|r',
	'|cff960000Atwood|r - for some of the role icons',
}

local DONATORS = {
	'|cffB50909Akiao|r',
	'|cffB50909Artan|r',
	'|cffB50909BralumConquest|r',
	'|cffB50909Brovenn|r',
	'|cffB50909Daxxarri|r',
	'|cffB50909Dlarge|r',
	'|cffB50909Dreamador|r',
	'|cffB50909Dreandor|r',
	'|cffB50909Gently Caress the Constabulary|r',
	'|cffB50909Greevir|r',
	'|cffB50909Jazz|r',
	'|cffB50909Jiberish|r',
	'|cffB50909Madlampy|r',
	'|cffB50909Michael_|r',
	'|cffB50909Morthart|r',
	'|cffB50909Nekator|r',
	'|cffB50909Nyhilatiant|r',
	'|cffB50909Vxt|r',
}

local TRANSLATORS = {
	'|cffCC3333Khornan|r - German Translation',
	'|cffCC3333Dlarge|r - German Translation',
	'|cffCC3333Neo|r - Chinese Translation',
	'DeepL artificial intelligence for French and Spanish translations',
}

-- SortList
local function SortList(a, b)
	return E:StripString(a) < E:StripString(b)
end

sort(AUTHORS, SortList)
sort(THANKYOU, SortList)
sort(DONATORS, SortList)
sort(TRANSLATORS, SortList)

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

-- Donators table
for _, name in pairs(DONATORS) do
	tinsert(ElvUI_EltreumUI.CreditsList, name)
end
local DONATORS_STRING = tconcat(DONATORS, '|n')

-- Translators table
for _, name in pairs(TRANSLATORS) do
	tinsert(ElvUI_EltreumUI.CreditsList, name)
end
local TRANSLATORS_STRING = tconcat(TRANSLATORS, '|n')

-- Eltruism ingame options
function ElvUI_EltreumUI:Configtable()
	-- Add Eltruism version on top of the ElvUI config
	E.Options.name = E.Options.name .. " + " .. ElvUI_EltreumUI.Name .. format(" |cffffffff%s|r", ElvUI_EltreumUI.Version)
	E.Options.args.ElvUI_EltreumUI = {
		order = 6,
		type = 'group',
		name = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\tinylogo.tga:18:18:0:0|t" .. ElvUI_EltreumUI.Name,
		args = {
			logo = {
				type = 'description',
				name = "",
				order = 6,
				image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\logohq', 320, 80 end,
			},
			installer = {
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
								func = function() E:GetModule('PluginInstaller'):Queue(ElvUI_EltreumUI.InstallerData) E:ToggleOptions() end,
							},
							eltruismsettings = {
								order = 2,
								type = 'execute',
								name = L["Reset/Update Eltruism Settings"],
								width = 'full',
								desc = L["Resets/Updates Eltruism Settings to Eltreum's Defaults"],
								func = function() ElvUI_EltreumUI:UpdateEltruismSettings() E:StaticPopup_Show('CONFIG_RL') end,
							},
							elvuisettings = {
								order = 3,
								type = 'execute',
								name = L["Reset/Update ElvUI Settings"],
								width = 'full',
								desc = L["Resets/Updates ElvUI Settings to Eltreum's Defaults"],
								func = function() ElvUI_EltreumUI:UpdateElvUISettings() end,
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
							nameplatereset = {
								order = 1,
								type = 'execute',
								name = L["Reset nameplates to Eltruism settings"],
								width = 'full',
								func = function() ElvUI_EltreumUI:SetupNamePlates('ElvUI') ElvUI_EltreumUI:ResolutionOutline() end,
							},
							nameplatestylefilter = {
								order = 2,
								type = 'execute',
								name = L["Reset Nameplate Style Filters"],
								width = 'full',
								func = function() ElvUI_EltreumUI:SetupStyleFilters() end,
							},
						},
					},
					header7 = {
						order = 5,
						type = "description",
						name = CHAT_LABEL,
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
								func = function()
									E:SetupChat()
									ElvUI_EltreumUI:Print(L["ElvUI Chat has been set."])
									--for classic chat lfg
									local lfg
									if E.global.general.locale == "enUS" then
										lfg = "LookingForGroup"
									elseif E.global.general.locale == "deDE" then
										lfg = "SucheNachGruppe"
									elseif E.global.general.locale == "esMX" or E.global.general.locale == "esES" then
										lfg = "BuscarGrupo"
									elseif E.global.general.locale == "frFR" then
										lfg = "RechercheDeGroupe"
									elseif E.global.general.locale == "ruRU" then
										lfg = "ПоискСпутников"
									elseif E.global.general.locale == "zhTW" then
										lfg = "尋求組隊"
									else
										lfg = "LookingForGroup"
									end
									if not E.Retail then --remove lfg spam from general and creat tab for it
										if lfg then
											ChatFrame_RemoveChannel(_G.ChatFrame1, lfg)
											FCF_OpenNewWindow()
											ChatFrame_RemoveAllMessageGroups(_G.ChatFrame5)
											FCF_SetWindowName(_G.ChatFrame5, 'LFG')
											ChatFrame_AddChannel(_G.ChatFrame5, lfg)
											FCFTab_UpdateColors(_G.ChatFrame5Tab)
											FCFDock_SelectWindow(_G.GENERAL_CHAT_DOCK, _G.ChatFrame1)
										end
									end
								end,
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
							resetoradddatatext = {
								order = 2,
								type = 'execute',
								name = L["Reset/Add Eltruism Datatext Panel"],
								width = 'full',
								func = function() ElvUI_EltreumUI:SetupDataText() E:UpdateMoverPositions() end,
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
					headerdb = {
						order = 11,
						type = "description",
						name = L["Database Check"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					databasecheck = {
						order = 12,
						type = 'group',
						inline = true,
						name = "",
						args = {
							resethealer = {
								order = 1,
								type = 'execute',
								name = L["Run Database Check"],
								desc = L["Perform a Database Check if you are updating from a very old version as some settings have changed places and the Database Check will convert them"],
								width = 'full',
								confirm = true,
								func = function() ElvUI_EltreumUI:DatabaseConversions(true) end,
							},
						},
					},
					header10 = {
						order = 21,
						type = "description",
						name = L["Clear Details! Damage Meter tables to free up memory"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					detailstable = {
						order = 22,
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
			},
			afk = {
				type = 'group',
				name = L["A.F.K"],
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\afk',
				order = 85,
				args = {
					header1 = {
						order = 1,
						type = "description",
						name = L["Play music while you are AFK"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					enableretail = {
						type = 'toggle',
						name = L["Enable"],
						order = 2,
						get = function() return E.db.ElvUI_EltreumUI.otherstuff.afkmusic.enable end,
						set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.afkmusic.enable = value end,
					},
					header2 = {
						order = 3,
						type = "description",
						name = "",
						width = 'full',
						hidden = not E.Retail,
					},
					afksoundtyperetail = {
						order = 4,
						type = 'group',
						inline = true,
						name = L["Select a type of music"],
						hidden = not E.Retail,
						args = {
							racial = {
								type = 'toggle',
								name = L["Racial Music"],
								order = 5,
								disabled = function() return not E.db.ElvUI_EltreumUI.otherstuff.afkmusic.enable or E.db.ElvUI_EltreumUI.otherstuff.afkmusic.playerclass end,
								get = function() return E.db.ElvUI_EltreumUI.otherstuff.afkmusic.racial end,
								set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.afkmusic.racial = value end,
							},
							playerclass = {
								type = 'toggle',
								name = L["Class Music"],
								order = 5,
								disabled = function() return not E.db.ElvUI_EltreumUI.otherstuff.afkmusic.enable or E.db.ElvUI_EltreumUI.otherstuff.afkmusic.racial end,
								get = function() return E.db.ElvUI_EltreumUI.otherstuff.afkmusic.playerclass end,
								set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.afkmusic.playerclass = value end,
							},
						},
					},
					header3 = {
						order = 6,
						type = "description",
						name = "Eltruism Logo",
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					enablelogo = {
						type = 'toggle',
						name = L["Enable"],
						width = "full",
						order = 7,
						get = function() return E.db.ElvUI_EltreumUI.otherstuff.afklogo end,
						set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.afklogo = value end,
					},
				},
			},
			addonsprofiles = {
				type = 'group',
				name = L["Addons"],
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\addon',
				order = 85,
				childGroups = "tab",
				args = {
					elvui = {
						type = 'group',
						name = L["ElvUI Plugins"],
						order = 1,
						args = {
							header1 = {
								order = 1,
								type = "description",
								name = "Azilroka Addons",
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							addonskins = {
								order = 2,
								type = 'execute',
								name = '|cff16C3F2AddOn|r|cFFFFFFFFSkins|r',
								desc = L["Reset to Eltruism defaults."],
								confirm = true,
								width = 'double',
								func = function() ElvUI_EltreumUI:AddonSetupAS() E:StaticPopup_Show('CONFIG_RL') end,
							},
							header2 = {
								order = 3,
								type = "description",
								name = "",
								width = 'full',
							},
							projectazilroka = {
								order = 3,
								type = 'execute',
								name = '|cFF16C3F2Project|r|cFFFFFFFFAzilroka|r',
								desc = L["Reset to Eltruism defaults."],
								confirm = true,
								width = 'double',
								func = function() ElvUI_EltreumUI:AddonSetupPA() E:StaticPopup_Show('CONFIG_RL') end,
							},
							header3 = {
								order = 4,
								type = "description",
								name = "Shadow and Light",
								width = 'full',
								hidden = not E.Retail,
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							shadowandlight = {
								order = 5,
								type = 'execute',
								name = E:TextGradient(L["Shadow and Light"], 0.2,0,0.6,0.2,0.2,0.8,0.2,1,0),
								desc = L["Reset to Eltruism defaults."],
								confirm = true,
								width = 'double',
								hidden = not E.Retail,
								func = function() ElvUI_EltreumUI:GetSLEProfile() E:StaticPopup_Show('CONFIG_RL') end,
							},
							header4 = {
								order = 6,
								type = "description",
								name = "Windtools",
								width = 'full',
								hidden = not E.Retail,
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							windtools = {
								order = 7,
								type = 'execute',
								name = "|cff45aaf2W|r|cff4795efi|r|cff4a80ecn|r|cff498aedd|r|cff469ff0T|r|cff60b1e8o|r|cff98c0d5o|r|cffc1ccc6l|r|cffc1ccc6s|r",
								desc = L["Reset to Eltruism defaults."],
								confirm = true,
								width = 'double',
								hidden = not E.Retail,
								func = function() ElvUI_EltreumUI:GetWindToolsProfile() E:StaticPopup_Show('CONFIG_RL') end,
							},
							header5 = {
								order = 8,
								type = "description",
								name = "Dynamic Status Icons",
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							dynamicstatusicons = {
								order = 9,
								type = 'execute',
								name = '|cFF16C3F2Dynamic Status |r|cFFFFFFFFIcons|r',
								desc = L["Reset to Eltruism defaults."],
								confirm = true,
								width = 'double',
								func = function() ElvUI_EltreumUI:SetupDynamicStatusIcons() E:StaticPopup_Show('CONFIG_RL') end,
							},
						},
					},
					bossmods = {
						type = 'group',
						name = L["BossMods Profiles"],
						order = 2,
						args = {
							header1 = {
								order = 1,
								type = "description",
								name = "",
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							bigwigs = {
								order = 2,
								type = 'execute',
								name = 'BigWigs',
								desc = L["Reset to Eltruism defaults."],
								width = 'double',
								func = function() ElvUI_EltreumUI:AddonSetupBW() E:StaticPopup_Show('CONFIG_RL') end,
							},
							header2 = {
								order = 3,
								type = "description",
								name = "",
								width = 'full',
							},
							dbm = {
								order = 3,
								type = 'execute',
								name = 'DBM',
								desc = L["Reset to Eltruism defaults."],
								width = 'double',
								func = function() ElvUI_EltreumUI:AddonSetupDBM() E:StaticPopup_Show('CONFIG_RL') end,
							},
							header4 = {
								order = 4,
								type = "description",
								name = "",
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							mrt = {
								order = 4,
								type = 'execute',
								name = 'Method Raid Tools',
								desc = L["Reset to Eltruism defaults."],
								width = 'double',
								func = function() ElvUI_EltreumUI:AddonSetupMRT() E:StaticPopup_Show('CONFIG_RL') end,
							},
						},
					},
					addons = {
						type = 'group',
						name = L["Addon Profiles"],
						order = 3,
						args = {
							header1 = {
								order = 1,
								type = "description",
								name = L["Misc"].." "..L["AddOns"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							dynamiccam = {
								order = 2,
								type = 'execute',
								name = 'Dynamic Cam',
								desc = L["Reset to Eltruism defaults."],
								width = 'double',
								func = function() ElvUI_EltreumUI:AddonSetupDynamicCam() E:StaticPopup_Show('CONFIG_RL') end,
							},
							header2 = {
								order = 3,
								type = "description",
								name = "",
								width = 'full',
							},
							immersion = {
								order = 4,
								type = 'execute',
								name = 'Immersion',
								desc = L["Reset to Eltruism defaults."],
								width = 'double',
								func = function() ElvUI_EltreumUI:AddonSetupImmersion() E:StaticPopup_Show('CONFIG_RL') end,
							},
							header3 = {
								order = 5,
								type = "description",
								name = "",
								width = 'full',
							},
							warpdeplete = {
								order = 6,
								type = 'execute',
								name = 'WarpDeplete',
								desc = L["Reset to Eltruism defaults."],
								width = 'double',
								hidden = not E.Retail,
								func = function() ElvUI_EltreumUI:GetWarpDepleteProfile() E:StaticPopup_Show('CONFIG_RL') end,
							},
							header4 = {
								order = 7,
								type = "description",
								name = "",
								width = 'full',
							},
							questie = {
								order = 8,
								type = 'execute',
								name = 'Questie',
								desc = L["Reset to Eltruism defaults."],
								width = 'double',
								hidden = E.Retail,
								func = function() ElvUI_EltreumUI:AddonSetupQuestie() E:StaticPopup_Show('CONFIG_RL') end,
							},
							header5pvp = {
								order = 9,
								type = "description",
								name = "PvP Addons",
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							battlegroundenemies = {
								order = 10,
								type = 'execute',
								name = 'BattleGroundEnemies',
								desc = L["Reset to Eltruism defaults."],
								width = 'double',
								func = function() ElvUI_EltreumUI:GetBattleGroundEnemiesProfile() E:StaticPopup_Show('CONFIG_RL') end,
							},
							header6 = {
								order = 11,
								type = "description",
								name = "",
								width = 'full',
							},
							capping = {
								order = 12,
								type = 'execute',
								name = 'Capping',
								desc = L["Reset to Eltruism defaults."],
								width = 'double',
								func = function() ElvUI_EltreumUI:GetCappingProfile() E:StaticPopup_Show('CONFIG_RL') end,
							},
							header7 = {
								order = 13,
								type = "description",
								name = "",
								width = 'full',
							},
							gladiusex = {
								order = 14,
								type = 'execute',
								name = 'Gladius Ex',
								desc = L["Reset to Eltruism defaults."],
								width = 'double',
								hidden = not E.Retail,
								func = function() ElvUI_EltreumUI:AddonSetupGladiusEx() E:StaticPopup_Show('CONFIG_RL') end,
							},
							gladdy = {
								order = 15,
								type = 'execute',
								name = 'Gladddy',
								desc = L["Reset to Eltruism defaults."],
								width = 'double',
								hidden = E.Retail or E.Classic,
								func = function() ElvUI_EltreumUI:SetupGladdy() E:StaticPopup_Show('CONFIG_RL') end,
							},
							header7 = {
								order = 16,
								type = "description",
								name = "",
								width = 'full',
								hidden = E.Retail or E.Classic,
							},
							gladius = {
								order = 17,
								type = 'execute',
								name = 'Gladius',
								desc = L["Reset to Eltruism defaults."],
								width = 'double',
								hidden = E.Retail or E.Classic,
								func = function() ElvUI_EltreumUI:SetupGladius() E:StaticPopup_Show('CONFIG_RL') end,
							},
							header8 = {
								order = 18,
								type = "description",
								name = L["Combat Text Addons"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							nameplatesct = {
								order = 19,
								type = 'execute',
								name = 'NameplateSCT',
								desc = L["Reset to Eltruism defaults."],
								width = 'double',
								func = function() ElvUI_EltreumUI:AddonSetupNameplateSCT() E:StaticPopup_Show('CONFIG_RL') end,
							},
							header9 = {
								order = 20,
								type = "description",
								name = "",
								width = 'full',
							},
							fct = {
								order = 95,
								type = 'execute',
								name = 'ElvUI Floating Combat Text',
								desc = L["Reset to Eltruism defaults."],
								width = 'double',
								func = function() ElvUI_EltreumUI:AddonSetupFCT() E:StaticPopup_Show('CONFIG_RL') end,
							},
							header10 = {
								order = 96,
								type = "description",
								name = L["Details Profiles"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							details = {
								order = 97,
								type = 'execute',
								name = L["Details v1 - Blizzard Flat Icons"],
								desc = L["Reset to Eltruism defaults."],
								width = 'double',
								func = function() ElvUI_EltreumUI:AddonSetupDT() E:StaticPopup_Show('CONFIG_RL') end,
							},
							header11 = {
								order = 98,
								type = "description",
								name = "",
								width = 'full',
							},
							details2 = {
								order = 98,
								type = 'execute',
								name = L["Details v2 - Releaf Transparent Icons"],
								desc = L["Reset to Eltruism defaults."],
								width = 'double',
								func = function() ElvUI_EltreumUI:AddonSetupDTReleaf() E:StaticPopup_Show('CONFIG_RL') end,
							},
							header12 = {
								order = 99,
								type = "description",
								name = "",
								width = 'full',
							},
							details3 = {
								order = 99,
								type = 'execute',
								name = L["Details v3 - Releaf Solid Icons"],
								desc = L["Reset to Eltruism defaults."],
								width = 'double',
								func = function() ElvUI_EltreumUI:AddonSetupDTReleafv3() E:StaticPopup_Show('CONFIG_RL') end,
							},
						},
					},
				},
			},
			aurafilters = {
				type = 'group',
				name = L["Aura Filters"],
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\aurafilter',
				childGroups = "tab",
				order = 85,
				args = {
					player = {
						type = 'group',
						name = L["Player"],
						order = 2,
						args = {
							header = {
								order = 1,
								type = 'group',
								name = L["Select how auras will be displayed for Player"],
								inline = true,
								args = {
									headerline1 = {
										order = 1,
										type = "description",
										name = "",
										width = 'full',
										image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
									},
									playerallbuffs = {
										order = 6,
										type = 'execute',
										name = L["All Player Buffs"],
										desc = L["Set filters to show more buffs on Player"],
										width = 'double',
										func = function() ElvUI_EltreumUI:SetupBuffs('player', 'Everything') end,
									},
									playeralldebuffs = {
										order = 6,
										type = 'execute',
										name = L["All Player Debuffs"],
										desc = L["Set filters to show more debuffs on Player"],
										width = 'double',
										func = function() ElvUI_EltreumUI:SetupDebuffs('player', 'Everything') end,
									},
									headerline2 = {
										order = 7,
										type = "description",
										name = "",
										width = 'full',
										image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
									},
									playerEltruismbuffs = {
										order = 9,
										type = 'execute',
										name = L["Eltruism Player Buffs"],
										desc = L["Set filters to be Eltruism defaults on Player"],
										width = 'double',
										func = function() ElvUI_EltreumUI:SetupBuffs('player', 'Eltruism') end,
									},
									playerEltruismdebuffs = {
										order = 9,
										type = 'execute',
										name = L["Eltruism Player Debuffs"],
										desc = L["Set filters to be Eltruism defaults on Player"],
										width = 'double',
										func = function() ElvUI_EltreumUI:SetupDebuffs('player', 'Eltruism') end,
									},
								},
							},
						},
					},
					target = {
						type = 'group',
						name = TARGET,
						order = 2,
						args = {
							header = {
								order = 1,
								type = 'group',
								name = L["Select how auras will be displayed for Target"],
								inline = true,
								args = {
									headerline1 = {
										order = 1,
										type = "description",
										name = "",
										width = 'full',
										image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
									},
									targetalldebuffs = {
										order = 6,
										type = 'execute',
										name = L["All Target Debuffs"],
										desc = L["Set filters to show more debuffs on Target"],
										width = 'double',
										func = function() ElvUI_EltreumUI:SetupDebuffs('target', 'Everything') end,
									},
									targetallbuffs = {
										order = 6,
										type = 'execute',
										name = L["All Target Buffs"],
										desc = L["Set filters to show more buffs on Target"],
										width = 'double',
										func = function() ElvUI_EltreumUI:SetupBuffs('target', 'Everything') end,
									},
									headerline2 = {
										order = 7,
										type = "description",
										name = "",
										width = 'full',
										image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
									},
									targetEltruismdebuffs = {
										order = 9,
										type = 'execute',
										name = L["Eltruism Target Debuffs"],
										desc = L["Set filters to be Eltruism defaults on Target"],
										width = 'double',
										func = function() ElvUI_EltreumUI:SetupDebuffs('target', 'Eltruism') end,
									},
									targetEltruismbuffs = {
										order = 9,
										type = 'execute',
										name = L["Eltruism Target Buffs"],
										desc = L["Set filters to be Eltruism defaults on Target"],
										width = 'double',
										func = function() ElvUI_EltreumUI:SetupBuffs('target', 'Eltruism') end,
									},
								},
							},
						},
					},
					focus= {
						type = 'group',
						name = POWER_TYPE_FOCUS,
						order = 2,
						hidden = E.Classic,
						args = {
							header = {
								order = 1,
								type = 'group',
								name = L["Select how auras will be displayed for Focus"],
								inline = true,
								args = {
									headerline1 = {
										order = 1,
										type = "description",
										name = "",
										width = 'full',
										image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
									},
									focusallbuffs = {
										order = 6,
										type = 'execute',
										name = L["All Focus Buffs"],
										desc = L["Set filters to show more buffs on Focus"],
										width = 'double',
										func = function() ElvUI_EltreumUI:SetupBuffs('focus', 'Everything') end,
									},
									focusalldebuffs = {
										order = 6,
										type = 'execute',
										name = L["All Focus Debuffs"],
										desc = L["Set filters to show more debuffs on Focus"],
										width = 'double',
										func = function() ElvUI_EltreumUI:SetupDebuffs('focus', 'Everything') end,
									},
									headerline2 = {
										order = 7,
										type = "description",
										name = "",
										width = 'full',
										image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
									},
									focusEltruismbuffs = {
										order = 9,
										type = 'execute',
										name = L["Eltruism Focus Buffs"],
										desc = L["Set filters to be Eltruism defaults on Focus"],
										width = 'double',
										func = function() ElvUI_EltreumUI:SetupBuffs('focus', 'Eltruism') end,
									},
									focusEltruismdebuffs = {
										order = 9,
										type = 'execute',
										name = L["Eltruism Focus Debuffs"],
										desc = L["Set filters to be Eltruism defaults on Focus"],
										width = 'double',
										func = function() ElvUI_EltreumUI:SetupDebuffs('focus', 'Eltruism') end,
									},
								},
							},
						},
					},
					boss = {
						type = 'group',
						name = L["Boss"],
						order = 2,
						hidden = not (E.Retail or E.Wrath),
						args = {
							header = {
								order = 1,
								type = 'group',
								name = L["Select how auras will be displayed for Boss"],
								inline = true,
								args = {
									headerline1 = {
										order = 1,
										type = "description",
										name = "",
										width = 'full',
										image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
									},
									bossallbuffs = {
										order = 6,
										type = 'execute',
										name = L["All Boss Buffs"],
										desc = L["Set filters to show more buffs on Boss"],
										width = 'double',
										func = function() ElvUI_EltreumUI:SetupBuffs('boss', 'Everything') end,
									},
									bossalldebuffs = {
										order = 6,
										type = 'execute',
										name = L["All Boss Debuffs"],
										desc = L["Set filters to show more debuffs on Boss"],
										width = 'double',
										func = function() ElvUI_EltreumUI:SetupDebuffs('boss', 'Everything') end,
									},
									headerline2 = {
										order = 7,
										type = "description",
										name = "",
										width = 'full',
										image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
									},
									bossEltruismbuffs = {
										order = 9,
										type = 'execute',
										name = L["Eltruism Boss Buffs"],
										desc = L["Set filters to be Eltruism defaults on Boss"],
										width = 'double',
										func = function() ElvUI_EltreumUI:SetupBuffs('boss', 'Eltruism') end,
									},
									bossEltruismdebuffs = {
										order = 9,
										type = 'execute',
										name = L["Eltruism Boss Debuffs"],
										desc = L["Set filters to be Eltruism defaults on Boss"],
										width = 'double',
										func = function() ElvUI_EltreumUI:SetupDebuffs('boss', 'Eltruism') end,
									},
								},
							},
						}
					},
					nameplate= {
						type = 'group',
						name = L["Nameplates"],
						order = 2,
						args = {
							header = {
								order = 1,
								type = 'group',
								name = L["Select how auras will be displayed for Nameplates"],
								inline = true,
								args = {
									headerline1 = {
										order = 1,
										type = "description",
										name = "",
										width = 'full',
										image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
									},
									nameplateallbuffs = {
										order = 6,
										type = 'execute',
										name = L["All Nameplate Buffs"],
										desc = L["Set filters to show more buffs on Nameplates"],
										width = 'double',
										func = function() ElvUI_EltreumUI:SetupBuffs('nameplate', 'Everything') end,
									},
									nameplatealldebuffs = {
										order = 6,
										type = 'execute',
										name = L["All Nameplate Debuffs"],
										desc = L["Set filters to show more debuffs on Nameplates"],
										width = 'double',
										func = function() ElvUI_EltreumUI:SetupDebuffs('nameplate', 'Everything') end,
									},
									headerline2 = {
										order = 7,
										type = "description",
										name = "",
										width = 'full',
										image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
									},
									nameplateEltruismbuffs = {
										order = 9,
										type = 'execute',
										name = L["Eltruism Nameplate Buffs"],
										desc = L["Set filters to be Eltruism defaults on Nameplates"],
										width = 'double',
										func = function() ElvUI_EltreumUI:SetupBuffs('nameplate', 'Eltruism') end,
									},
									nameplateEltruismdebuffs = {
										order = 9,
										type = 'execute',
										name = L["Eltruism Nameplate Debuffs"],
										desc = L["Set filters to be Eltruism defaults on Nameplates"],
										width = 'double',
										func = function() ElvUI_EltreumUI:SetupDebuffs('nameplate', 'Eltruism') end,
									},
								},
							},
						}
					},
				},
			},
			borders = {
				type = 'group',
				name = L["Borders"],
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\border',
				order = 85,
				childGroups = "tab",
				args = {
					general = {
						type = 'group',
						name = L["General"],
						order = 1,
						args = {
							headerline1 = {
								order = 1,
								type = "description",
								name = L["Enable Borders"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							enable = {
								type = 'toggle',
								name = L["Enable"],
								width = "full",
								order = 2,
								get = function() return E.db.ElvUI_EltreumUI.borders.borders end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.borders = value ElvUI_EltreumUI:Borders() E:StaticPopup_Show('CONFIG_RL') end,
							},
							enableautoadjust = {
								type = 'toggle',
								name = L["Enable Auto-adjusting the actionbar spacing and position"],
								desc = L["Adjusts actionbar spacing and position based on borders being enabled or not"],
								width = "full",
								order = 3,
								get = function() return E.db.ElvUI_EltreumUI.borders.borderautoadjust end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.borderautoadjust = value ElvUI_EltreumUI:Borders() E:StaticPopup_Show('CONFIG_RL') end,
							},
							headerline2 = {
								order = 93,
								type = "description",
								name = L["Choose the Border Texture to be used:"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							sharedmediatexture = {
								order = 94,
								type = 'select',
								width = "full",
								dialogControl = 'LSM30_Border',
								name = "",
								desc = L["Select a Texture"],
								values = AceGUIWidgetLSMlists.border,
								get = function() return E.db.ElvUI_EltreumUI.borders.texture end,
								disabled = function() return E.db.ElvUI_EltreumUI.borders.borderautoadjust or not E.db.ElvUI_EltreumUI.borders.borders end,
								set = function(self,key) E.db.ElvUI_EltreumUI.borders.texture = key ElvUI_EltreumUI:Borders() end,
							},
							classcolors = {
								type = 'toggle',
								name = L["Use Class Colors"],
								--width = "full",
								order = 95,
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders end,
								get = function() return E.db.ElvUI_EltreumUI.borders.classcolor end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.classcolor = value ElvUI_EltreumUI:Borders() E:StaticPopup_Show('CONFIG_RL') end,
							},
							colorborders = {
								order = 96,
								type = 'color',
								name = L["Custom Color"],
								hasAlpha = false,
								disabled = function() return E.db.ElvUI_EltreumUI.borders.classcolor end,
								get = function()
									local customcolorborders = E.db.ElvUI_EltreumUI.borders.bordercolors
									local d = P.ElvUI_EltreumUI.borders.bordercolors
									return customcolorborders.r, customcolorborders.g, customcolorborders.b, customcolorborders.a, d.r, d.g, d.b, d.a
								end,
								set = function(_, r, g, b, a)
									local customcolorborders = E.db.ElvUI_EltreumUI.borders.bordercolors
									customcolorborders.r, customcolorborders.g, customcolorborders.b = r, g, b E:StaticPopup_Show('CONFIG_RL') ElvUI_EltreumUI:Borders()
								end,
							},
							headerline3 = {
								order = 97,
								type = "description",
								name = L["Change the size of the borders:"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							borderABsize = {
								type = 'range',
								name = L["Actionbar Thickness"],
								order = 98,
								min = 1,
								max = 200,
								step = 0.1,
								width = "full",
								disabled = function() return E.db.ElvUI_EltreumUI.borders.borderautoadjust or not E.db.ElvUI_EltreumUI.borders.borders or not E.private.actionbar.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.baredgesize end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.baredgesize = value ElvUI_EltreumUI:Borders() end,
							},
							borderUFsize = {
								type = 'range',
								name = L["Unitframe Thickness"],
								order = 99,
								min = 1,
								max = 200,
								step = 0.1,
								width = "full",
								disabled = function() return E.db.ElvUI_EltreumUI.borders.borderautoadjust or not E.db.ElvUI_EltreumUI.borders.borders or not E.private.unitframe.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.playertargetsize end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.playertargetsize = value ElvUI_EltreumUI:Borders() end,
							},
							bordergroupUFsize = {
								type = 'range',
								name = L["Group Unitframe Thickness"],
								order = 99,
								min = 1,
								max = 200,
								step = 0.1,
								width = "full",
								disabled = function() return E.db.ElvUI_EltreumUI.borders.borderautoadjust or not E.db.ElvUI_EltreumUI.borders.borders or not E.private.unitframe.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.groupsize end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.groupsize = value ElvUI_EltreumUI:Borders() end,
							},
							bordercastbarsize = {
								type = 'range',
								name = L["Castbar Thickness"],
								order = 99,
								min = 1,
								max = 200,
								step = 0.1,
								width = "full",
								disabled = function() return E.db.ElvUI_EltreumUI.borders.borderautoadjust or not E.db.ElvUI_EltreumUI.borders.borders or not E.private.unitframe.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.playertargetcastsize end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.playertargetcastsize = value ElvUI_EltreumUI:Borders() end,
							},
							borderpetsize = {
								type = 'range',
								name = L["Pet Thickness"],
								order = 99,
								min = 1,
								max = 200,
								step = 0.1,
								width = "full",
								disabled = function() return E.db.ElvUI_EltreumUI.borders.borderautoadjust or not E.db.ElvUI_EltreumUI.borders.borders or not E.private.unitframe.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.petsize end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.petsize = value ElvUI_EltreumUI:Borders() end,
							},
							borderfocussize = {
								type = 'range',
								name = L["Focus Thickness"],
								order = 99,
								min = 1,
								max = 200,
								step = 0.1,
								width = "full",
								hidden = E.Classic,
								disabled = function() return E.db.ElvUI_EltreumUI.borders.borderautoadjust or not E.db.ElvUI_EltreumUI.borders.borders or not E.private.unitframe.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.focussize end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.focussize = value ElvUI_EltreumUI:Borders() end,
							},
							borderbosssize = {
								type = 'range',
								name = L["Boss Thickness"],
								order = 99,
								min = 1,
								max = 200,
								step = 0.1,
								width = "full",
								hidden = not (E.Retail or E.Wrath),
								disabled = function() return E.db.ElvUI_EltreumUI.borders.borderautoadjust or not E.db.ElvUI_EltreumUI.borders.borders or not E.private.unitframe.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.bosssize end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.bosssize = value ElvUI_EltreumUI:Borders() end,
							},
							bordertotemsize = {
								type = 'range',
								name = L["Shaman Totem Thickness"],
								order = 99,
								min = 1,
								max = 200,
								step = 0.1,
								width = "full",
								hidden = not E.Wrath,
								disabled = function() return E.db.ElvUI_EltreumUI.borders.borderautoadjust or not E.db.ElvUI_EltreumUI.borders.borders end,
								get = function() return E.db.ElvUI_EltreumUI.borders.totemedgesize end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.totemedgesize = value ElvUI_EltreumUI:Borders() end,
							},
							borderaurasize = {
								type = 'range',
								name = L["Aura Thickness"],
								order = 100,
								min = 1,
								max = 200,
								step = 0.1,
								width = "full",
								disabled = function() return E.db.ElvUI_EltreumUI.borders.borderautoadjust or not E.db.ElvUI_EltreumUI.borders.borders end,
								get = function() return E.db.ElvUI_EltreumUI.borders.aurasize end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.aurasize = value ElvUI_EltreumUI:AuraBorders() end,
							},
							borderchatsize = {
								type = 'range',
								name = L["Chat Thickness"],
								order = 101,
								min = 1,
								max = 200,
								step = 0.1,
								width = "full",
								disabled = function() return E.db.ElvUI_EltreumUI.borders.borderautoadjust or not E.db.ElvUI_EltreumUI.borders.borders end,
								get = function() return E.db.ElvUI_EltreumUI.borders.chatsize end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.chatsize = value ElvUI_EltreumUI:Borders() end,
							},
							borderminimapsize = {
								type = 'range',
								name = L["Minimap Thickness"],
								order = 102,
								min = 1,
								max = 200,
								step = 0.1,
								width = "full",
								disabled = function() return E.db.ElvUI_EltreumUI.borders.borderautoadjust or not E.db.ElvUI_EltreumUI.borders.borders end,
								get = function() return E.db.ElvUI_EltreumUI.borders.minimapsize end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.minimapsize = value ElvUI_EltreumUI:Borders() end,
							},
							borderstancesize = {
								type = 'range',
								name = L["Stance Bar Thickness"],
								order = 102,
								min = 1,
								max = 200,
								step = 0.1,
								width = "full",
								disabled = function() return E.db.ElvUI_EltreumUI.borders.borderautoadjust or not E.db.ElvUI_EltreumUI.borders.borders end,
								get = function() return E.db.ElvUI_EltreumUI.borders.stanceedgesize end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.stanceedgesize = value ElvUI_EltreumUI:Borders() end,
							},
							borderpetabsize = {
								type = 'range',
								name = L["Pet Action Bar Thickness"],
								order = 102,
								min = 1,
								max = 200,
								step = 0.1,
								width = "full",
								disabled = function() return E.db.ElvUI_EltreumUI.borders.borderautoadjust or not E.db.ElvUI_EltreumUI.borders.borders end,
								get = function() return E.db.ElvUI_EltreumUI.borders.petactionedgesize end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.petactionedgesize = value ElvUI_EltreumUI:Borders() end,
							},
						},
					},
					actionbarsborders = {
						order = 2,
						type = 'group',
						--inline = true,
						disabled = function() return E.db.ElvUI_EltreumUI.borders.borderautoadjust or not E.db.ElvUI_EltreumUI.borders.borders end,
						name = L["ActionBars"],
						childGroups = "tab",
						args = {
							gap0 = {
								order = 1,
								type = "description",
								name = L["(All settings require a reload)"],
								width = 'full',
								--image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},


							gap1 = {
								order = 5,
								type = "description",
								name = L["Action Bar 1"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							bar1enable = {
								type = 'toggle',
								name = L["Enable"],
								order = 6,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar1.enabled end,
								get = function() return E.db.ElvUI_EltreumUI.borders.bar1borders end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.bar1borders = value ElvUI_EltreumUI:Borders() end,
							},
							bar1xsize = {
								type = 'range',
								name = L["Bar 1 X offset"],
								order = 7,
								min = 1,
								max = 200,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar1.enabled end,
								get = function() return E.db.ElvUI_EltreumUI.borders.bar1xborder end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.bar1xborder = value ElvUI_EltreumUI:Borders() end,
							},
							bar1ysize = {
								type = 'range',
								name = L["Bar 1 Y offset"],
								order = 7,
								min = 1,
								max = 200,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar1.enabled end,
								get = function() return E.db.ElvUI_EltreumUI.borders.bar1yborder end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.bar1yborder = value ElvUI_EltreumUI:Borders() end,
							},
							gap2 = {
								order = 8,
								type = "description",
								name = L["Action Bar 2"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							bar2enable = {
								type = 'toggle',
								name = L["Enable"],
								order = 9,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar2.enabled end,
								get = function() return E.db.ElvUI_EltreumUI.borders.bar2borders end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.bar2borders = value ElvUI_EltreumUI:Borders() end,
							},
							bar2xsize = {
								type = 'range',
								name = L["Bar 2 X offset"],
								order = 10,
								min = 1,
								max = 200,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar2.enabled end,
								get = function() return E.db.ElvUI_EltreumUI.borders.bar2xborder end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.bar2xborder = value ElvUI_EltreumUI:Borders() end,
							},
							bar2ysize = {
								type = 'range',
								name = L["Bar 2 Y offset"],
								order = 10,
								min = 1,
								max = 200,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar2.enabled end,
								get = function() return E.db.ElvUI_EltreumUI.borders.bar2yborder end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.bar2yborder = value ElvUI_EltreumUI:Borders() end,
							},
							gap3 = {
								order = 11,
								type = "description",
								name = L["Action Bar 3"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							bar3enable = {
								type = 'toggle',
								name = L["Enable"],
								order = 12,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar3.enabled end,
								get = function() return E.db.ElvUI_EltreumUI.borders.bar3borders end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.bar3borders = value ElvUI_EltreumUI:Borders() end,
							},
							bar3xsize = {
								type = 'range',
								name = L["Bar 3 X offset"],
								order = 13,
								min = 1,
								max = 200,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar3.enabled end,
								get = function() return E.db.ElvUI_EltreumUI.borders.bar3xborder end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.bar3xborder = value ElvUI_EltreumUI:Borders() end,
							},
							bar3ysize = {
								type = 'range',
								name = L["Bar 3 Y offset"],
								order = 13,
								min = 1,
								max = 200,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar3.enabled end,
								get = function() return E.db.ElvUI_EltreumUI.borders.bar3yborder end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.bar3yborder = value ElvUI_EltreumUI:Borders() end,
							},
							gap4 = {
								order = 14,
								type = "description",
								name = L["Action Bar 4"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							bar4enable = {
								type = 'toggle',
								name = L["Enable"],
								order = 15,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar4.enabled end,
								get = function() return E.db.ElvUI_EltreumUI.borders.bar4borders end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.bar4borders = value ElvUI_EltreumUI:Borders() end,
							},
							bar4xsize = {
								type = 'range',
								name = L["Bar 4 X offset"],
								order = 16,
								min = 1,
								max = 200,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar4.enabled end,
								get = function() return E.db.ElvUI_EltreumUI.borders.bar4xborder end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.bar4xborder = value ElvUI_EltreumUI:Borders() end,
							},
							bar4ysize = {
								type = 'range',
								name = L["Bar 4 Y offset"],
								order = 16,
								min = 1,
								max = 200,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar4.enabled end,
								get = function() return E.db.ElvUI_EltreumUI.borders.bar4yborder end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.bar4yborder = value ElvUI_EltreumUI:Borders() end,
							},
							gap5 = {
								order = 17,
								type = "description",
								name = L["Action Bar 5"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							bar5enable = {
								type = 'toggle',
								name = L["Enable"],
								order = 18,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar5.enabled end,
								get = function() return E.db.ElvUI_EltreumUI.borders.bar5borders end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.bar5borders = value ElvUI_EltreumUI:Borders() end,
							},
							bar5xsize = {
								type = 'range',
								name = L["Bar 5 X offset"],
								order = 19,
								min = 1,
								max = 200,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar5.enabled end,
								get = function() return E.db.ElvUI_EltreumUI.borders.bar5xborder end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.bar5xborder = value ElvUI_EltreumUI:Borders() end,
							},
							bar5ysize = {
								type = 'range',
								name = L["Bar 5 Y offset"],
								order = 19,
								min = 1,
								max = 200,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar5.enabled end,
								get = function() return E.db.ElvUI_EltreumUI.borders.bar5yborder end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.bar5yborder = value ElvUI_EltreumUI:Borders() end,
							},
							gap6 = {
								order = 20,
								type = "description",
								name = L["Action Bar 6"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							bar6enable = {
								type = 'toggle',
								name = L["Enable"],
								order = 21,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar6.enabled end,
								get = function() return E.db.ElvUI_EltreumUI.borders.bar6borders end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.bar6borders = value ElvUI_EltreumUI:Borders() end,
							},
							bar6xsize = {
								type = 'range',
								name = L["Bar 6 X offset"],
								order = 22,
								min = 1,
								max = 200,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar6.enabled end,
								get = function() return E.db.ElvUI_EltreumUI.borders.bar6xborder end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.bar6xborder = value ElvUI_EltreumUI:Borders() end,
							},
							bar6ysize = {
								type = 'range',
								name = L["Bar 6 Y offset"],
								order = 22,
								min = 1,
								max = 200,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar6.enabled end,
								get = function() return E.db.ElvUI_EltreumUI.borders.bar6yborder end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.bar6yborder = value ElvUI_EltreumUI:Borders() end,
							},
							gap7totem = {
								order = 23,
								type = "description",
								name = L["Shaman Totem Bar"],
								width = 'full',
								hidden = not E.Wrath,
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							totemenable = {
								type = 'toggle',
								name = L["Enable"],
								order = 24,
								width = "full",
								hidden = not E.Wrath,
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders end,
								get = function() return E.db.ElvUI_EltreumUI.borders.totembar end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.totembar = value ElvUI_EltreumUI:Borders() end,
							},
							totemxsize = {
								type = 'range',
								name = L["Totem X offset"],
								order = 25,
								min = 1,
								max = 200,
								step = 0.1,
								width = "full",
								hidden = not E.Wrath,
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar6.enabled end,
								get = function() return E.db.ElvUI_EltreumUI.borders.totemxborder end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.totemxborder = value ElvUI_EltreumUI:Borders() end,
							},
							totemysize = {
								type = 'range',
								name = L["Totem Y offset"],
								order = 25,
								min = 1,
								max = 200,
								step = 0.1,
								width = "full",
								hidden = not E.Wrath,
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar6.enabled end,
								get = function() return E.db.ElvUI_EltreumUI.borders.totemyborder end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.totemyborder = value ElvUI_EltreumUI:Borders() end,
							},
							gap8 = {
								order = 26,
								type = "description",
								name = L["Stance Bar"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							stanceenable = {
								type = 'toggle',
								name = L["Enable"],
								order = 27,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders end,
								get = function() return E.db.ElvUI_EltreumUI.borders.stanceborders end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.stanceborders = value ElvUI_EltreumUI:Borders() end,
							},
							stancexsize = {
								type = 'range',
								name = L["Stance X offset"],
								order = 28,
								min = 1,
								max = 200,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.stanceBar.enabled end,
								get = function() return E.db.ElvUI_EltreumUI.borders.stancexborder end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.stancexborder = value ElvUI_EltreumUI:Borders() end,
							},
							stanceysize = {
								type = 'range',
								name = L["Stance Y offset"],
								order = 28,
								min = 1,
								max = 200,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.stanceBar.enabled end,
								get = function() return E.db.ElvUI_EltreumUI.borders.stanceyborder end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.stanceyborder = value ElvUI_EltreumUI:Borders() end,
							},
							gap9 = {
								order = 29,
								type = "description",
								name = L["Pet Action Bar"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							petactionenable = {
								type = 'toggle',
								name = L["Enable"],
								order = 30,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders end,
								get = function() return E.db.ElvUI_EltreumUI.borders.petactionborders end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.petactionborders = value ElvUI_EltreumUI:Borders() end,
							},
							petactionxsize = {
								type = 'range',
								name = L["Pet Action Bar X offset"],
								order = 31,
								min = 1,
								max = 200,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.barPet.enabled end,
								get = function() return E.db.ElvUI_EltreumUI.borders.petactionxborder end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.petactionxborder = value ElvUI_EltreumUI:Borders() end,
							},
							petactionysize = {
								type = 'range',
								name = L["Pet Action Bar Y offset"],
								order = 31,
								min = 1,
								max = 200,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.barPet.enabled end,
								get = function() return E.db.ElvUI_EltreumUI.borders.petactionyborder end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.petactionyborder = value ElvUI_EltreumUI:Borders() end,
							},
						},
					},
					ufborders = {
						type = 'group',
						disabled = function() return E.db.ElvUI_EltreumUI.borders.borderautoadjust or not E.db.ElvUI_EltreumUI.borders.borders end,
						name = L["Unitframes"],
						order = 2,
						args = {
							gap0 = {
								order = 1,
								type = "description",
								name = L["(All settings require a reload)"],
								width = 'full',
								--image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							gapplayer = {
								order = 2,
								type = "description",
								name = L["Player Border"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							barplayer = {
								type = 'toggle',
								name = L["Enable"],
								order = 3,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.player.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.playerborder end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.playerborder = value ElvUI_EltreumUI:Borders() end,
							},
							borderxplayer = {
								type = 'range',
								name = L["Border X offset"],
								order = 4,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.player.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.xplayer end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.xplayer = value ElvUI_EltreumUI:Borders() end,
							},
							borderyplayer = {
								type = 'range',
								name = L["Border Y offset"],
								order = 4,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.player.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.yplayer end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.yplayer = value ElvUI_EltreumUI:Borders() end,
							},
							gapplayercast = {
								order = 5,
								type = "description",
								name = L["Player Castbar Border"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							barcastplayer = {
								type = 'toggle',
								name = L["Enable"],
								order = 6,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.player.castbar.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.playercastborder end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.playercastborder = value ElvUI_EltreumUI:Borders() end,
							},
							borderxcastplayer = {
								type = 'range',
								name = L["Border X offset"],
								order = 7,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.player.castbar.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.xplayercast end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.xplayercast = value ElvUI_EltreumUI:Borders() end,
							},
							borderycastplayer = {
								type = 'range',
								name = L["Border Y offset"],
								order = 7,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.player.castbar.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.yplayercast end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.yplayercast = value ElvUI_EltreumUI:Borders() end,
							},
							gaptarget = {
								order = 29,
								type = "description",
								name = L["Target Border"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							bartarget = {
								type = 'toggle',
								name = L["Enable"],
								order = 30,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.target.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.targetborder end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.targetborder = value ElvUI_EltreumUI:Borders() end,
							},
							borderxtarget = {
								type = 'range',
								name = L["Border X offset"],
								order = 31,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.target.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.xtarget end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.xtarget = value ElvUI_EltreumUI:Borders() end,
							},
							borderytarget = {
								type = 'range',
								name = L["Border Y offset"],
								order = 31,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.target.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.ytarget end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.ytarget = value ElvUI_EltreumUI:Borders() end,
							},
							gaptargetcast = {
								order = 32,
								type = "description",
								name = L["Target Castbar Border"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							bartargetcast = {
								type = 'toggle',
								name = L["Enable"],
								order = 33,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.target.castbar.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.targetcastborder end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.targetcastborder = value ElvUI_EltreumUI:Borders() end,
							},
							borderxcasttarget = {
								type = 'range',
								name = L["Border X offset"],
								order = 34,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.target.castbar.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.xcasttarget end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.xcasttarget = value ElvUI_EltreumUI:Borders() end,
							},
							borderycasttarget = {
								type = 'range',
								name = L["Border Y offset"],
								order = 34,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.target.castbar.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.ycasttarget end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.ycasttarget = value ElvUI_EltreumUI:Borders() end,
							},
							gaptargettarget = {
								order = 35,
								type = "description",
								name = L["Target of Target Border"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							bartargettarget = {
								type = 'toggle',
								name = L["Enable"],
								order = 36,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.targettarget.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.targettargetborder end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.targettargetborder = value ElvUI_EltreumUI:Borders() end,
							},
							borderxtargettarget = {
								type = 'range',
								name = L["Border X offset"],
								order = 37,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.targettarget.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.xtargettarget end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.xtargettarget = value ElvUI_EltreumUI:Borders() end,
							},
							borderytargettarget = {
								type = 'range',
								name = L["Border Y offset"],
								order = 38,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.targettarget.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.ytargettarget end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.ytargettarget = value ElvUI_EltreumUI:Borders() end,
							},
							gapparty = {
								order = 39,
								type = "description",
								name = L["Party Border"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							barparty = {
								type = 'toggle',
								name = L["Enable"],
								order = 40,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.party.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.partyborders end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.partyborders = value ElvUI_EltreumUI:Borders() end,
							},
							borderxparty = {
								type = 'range',
								name = L["Border X offset"],
								order = 41,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.party.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.partysizex end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.partysizex = value ElvUI_EltreumUI:Borders() end,
							},
							borderyparty = {
								type = 'range',
								name = L["Border Y offset"],
								order = 42,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.party.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.partysizey end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.partysizey = value ElvUI_EltreumUI:Borders() end,
							},
							gapraid = {
								order = 43,
								type = "description",
								name = L["Raid1 Border"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							barraid = {
								type = 'toggle',
								name = L["Enable"],
								order = 44,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.raid1.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.raidborders end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.raidborders = value ElvUI_EltreumUI:Borders() end,
							},
							borderxraid = {
								type = 'range',
								name = L["Border X offset"],
								order = 45,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.raid1.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.raidsizex end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.raidsizex = value ElvUI_EltreumUI:Borders() end,
							},
							borderyraid = {
								type = 'range',
								name = L["Border Y offset"],
								order = 46,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.raid1.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.raidsizey end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.raidsizey = value ElvUI_EltreumUI:Borders() end,
							},
							gapraid2 = {
								order = 47,
								type = "description",
								name = L["Raid2 Border"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							barraid2 = {
								type = 'toggle',
								name = L["Enable"],
								order = 48,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.raid2.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.raid2borders end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.raid2borders = value ElvUI_EltreumUI:Borders() end,
							},
							borderxraid2 = {
								type = 'range',
								name = L["Border X offset"],
								order = 49,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.raid2.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.raid2sizex end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.raid2sizex = value ElvUI_EltreumUI:Borders() end,
							},
							borderyraid2 = {
								type = 'range',
								name = L["Border Y offset"],
								order = 50,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.raid2.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.raid2sizey end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.raid2sizey = value ElvUI_EltreumUI:Borders() end,
							},
							gapraid40 = {
								order = 51,
								type = "description",
								name = L["Raid3 Border"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							barraid40 = {
								type = 'toggle',
								name = L["Enable"],
								order = 52,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.raid3.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.raid40borders end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.raid40borders = value ElvUI_EltreumUI:Borders() end,
							},
							borderxraid40 = {
								type = 'range',
								name = L["Border X offset"],
								order = 53,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.raid3.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.raid40sizex end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.raid40sizex = value ElvUI_EltreumUI:Borders() end,
							},
							borderyraid40 = {
								type = 'range',
								name = L["Border Y offset"],
								order = 54,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.raid3.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.raid40sizey end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.raid40sizey = value ElvUI_EltreumUI:Borders() end,
							},
							gapfocus = {
								order = 55,
								type = "description",
								name = L["Focus Border"],
								width = 'full',
								hidden = E.Classic,
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							barfocus= {
								type = 'toggle',
								name = L["Enable"],
								order = 56,
								width = "full",
								hidden = E.Classic,
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.focus.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.focusborder end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.focusborder = value ElvUI_EltreumUI:Borders() end,
							},
							borderxfocus = {
								type = 'range',
								name = L["Border X offset"],
								order = 57,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								hidden = E.Classic,
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.focus.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.xfocus end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.xfocus = value ElvUI_EltreumUI:Borders() end,
							},
							borderyfocus = {
								type = 'range',
								name = L["Border Y offset"],
								order = 58,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								hidden = E.Classic,
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.focus.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.yfocus end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.yfocus = value ElvUI_EltreumUI:Borders() end,
							},
							gapfocuscast = {
								order = 59,
								type = "description",
								name = L["Focus Castbar Border"],
								width = 'full',
								hidden = E.Classic,
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							barfocuscast = {
								type = 'toggle',
								name = L["Enable"],
								order = 60,
								width = "full",
								hidden = E.Classic,
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.focus.enable or not E.db.unitframe.units.focus.castbar.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.focuscastborder end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.focuscastborder = value ElvUI_EltreumUI:Borders() end,
							},
							borderxcastfocus = {
								type = 'range',
								name = L["Border X offset"],
								order = 61,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								hidden = E.Classic,
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.focus.enable or not E.db.unitframe.units.focus.castbar.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.xcastfocus end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.xcastfocus = value ElvUI_EltreumUI:Borders() end,
							},
							borderycastfocus = {
								type = 'range',
								name = L["Border Y offset"],
								order = 62,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								hidden = E.Classic,
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.focus.enable or not E.db.unitframe.units.focus.castbar.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.ycastfocus end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.ycastfocus = value ElvUI_EltreumUI:Borders() end,
							},
							gapfocustarget = {
								order = 63,
								type = "description",
								name = L["Focus Target Border"],
								width = 'full',
								hidden = E.Classic,
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							barfocustarget = {
								type = 'toggle',
								name = L["Enable"],
								order = 64,
								width = "full",
								hidden = E.Classic,
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.focustarget.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.focustargetborder end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.focustargetborder = value ElvUI_EltreumUI:Borders() end,
							},
							borderxfocustarget = {
								type = 'range',
								name = L["Border X offset"],
								order = 65,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								hidden = E.Classic,
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.focustarget.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.xfocustarget end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.xfocustarget = value ElvUI_EltreumUI:Borders() end,
							},
							borderyfocustarget = {
								type = 'range',
								name = L["Border Y offset"],
								order = 66,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								hidden = E.Classic,
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.focus.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.yfocustarget end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.yfocustarget = value ElvUI_EltreumUI:Borders() end,
							},
							gapboss = {
								order = 95,
								type = "description",
								name = L["Boss Border"],
								width = 'full',
								hidden = not (E.Retail or E.Wrath),
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							barboss= {
								type = 'toggle',
								name = L["Enable"],
								order = 96,
								width = "full",
								hidden = not (E.Retail or E.Wrath),
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.boss.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.bossborder end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.bossborder = value ElvUI_EltreumUI:Borders() end,
							},
							borderxboss = {
								type = 'range',
								name = L["Border X offset"],
								order = 97,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								hidden = not (E.Retail or E.Wrath),
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.boss.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.xboss end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.xboss = value ElvUI_EltreumUI:Borders() end,
							},
							borderyboss = {
								type = 'range',
								name = L["Border Y offset"],
								order = 98,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								hidden = not (E.Retail or E.Wrath),
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.boss.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.yboss end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.yboss = value ElvUI_EltreumUI:Borders() end,
							},
							gappet = {
								order = 100,
								type = "description",
								name = L["Pet Border"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							petenable = {
								type = 'toggle',
								name = L["Enable"],
								order = 101,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.pet.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.petborder end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.petborder = value ElvUI_EltreumUI:Borders() end,
							},
							borderxpet = {
								type = 'range',
								name = L["Border X offset"],
								order = 102,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.pet.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.petsizex end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.petsizex = value ElvUI_EltreumUI:Borders() end,
							},
							borderypet = {
								type = 'range',
								name = L["Border Y offset"],
								order = 102,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.unitframe.units.pet.enable end,
								get = function() return E.db.ElvUI_EltreumUI.borders.petsizey end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.petsizey = value ElvUI_EltreumUI:Borders() end,
							},
						},
					},
					npborder = {
						type = 'group',
						disabled = function() return E.db.ElvUI_EltreumUI.borders.borderautoadjust or not E.db.ElvUI_EltreumUI.borders.borders end,
						name = L["Nameplate"],
						order = 3,
						args = {
							gap0 = {
								order = 1,
								type = "description",
								name = L["(All settings require a reload)"],
								width = 'full',
								--image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							gappowerbar = {
								order = 35,
								type = "description",
								name = L["Nameplate Power Bar Border"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							barpowerbar = {
								type = 'toggle',
								name = L["Enable"],
								order = 36,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.private.ElvUI_EltreumUI.nameplatepower end,
								get = function() return E.db.ElvUI_EltreumUI.borders.powerbarborder end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.powerbarborder = value ElvUI_EltreumUI:Borders() end,
							},
							borderpowerbarsize = {
								type = 'range',
								name = L["Nameplate Power Bar Thickness"],
								order = 37,
								min = 1,
								max = 200,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.private.ElvUI_EltreumUI.nameplatepower end,
								get = function() return E.db.ElvUI_EltreumUI.borders.powerbarsize end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.powerbarsize = value ElvUI_EltreumUI:Borders() end,
							},
							borderxpowerbar = {
								type = 'range',
								name = L["Border X offset"],
								order = 38,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.private.ElvUI_EltreumUI.nameplatepower end,
								get = function() return E.db.ElvUI_EltreumUI.borders.xpowerbar end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.xpowerbar = value ElvUI_EltreumUI:Borders() end,
							},
							borderypowerbar = {
								type = 'range',
								name = L["Border Y offset"],
								order = 39,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.private.ElvUI_EltreumUI.nameplatepower end,
								get = function() return E.db.ElvUI_EltreumUI.borders.ypowerbar end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.ypowerbar = value ElvUI_EltreumUI:Borders() end,
							},
						},
					},
					otherborder = {
						type = 'group',
						name = L["Other"],
						disabled = function() return E.db.ElvUI_EltreumUI.borders.borderautoadjust or not E.db.ElvUI_EltreumUI.borders.borders end,
						order = 4,
						args = {
							headerline1 = {
								order = 1,
								type = "description",
								name = MINIMAP_LABEL,
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							enableminimap = {
								type = 'toggle',
								name = L["Enable"].." "..MINIMAP_LABEL,
								width = "full",
								order = 2,
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders end,
								get = function() return E.db.ElvUI_EltreumUI.borders.minimapborder end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.minimapborder = value E:StaticPopup_Show('CONFIG_RL') ElvUI_EltreumUI:Borders() end,
							},
							mapbordersizex = {
								type = 'range',
								name = MINIMAP_LABEL.." "..L["Border X offset"],
								order = 3,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.ElvUI_EltreumUI.borders.minimapborder end,
								get = function() return E.db.ElvUI_EltreumUI.borders.minimapsizex end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.minimapsizex = value ElvUI_EltreumUI:Borders() end,
							},
							mapbordersizey = {
								type = 'range',
								name = MINIMAP_LABEL.." "..L["Border Y offset"],
								order = 4,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.ElvUI_EltreumUI.borders.minimapborder end,
								get = function() return E.db.ElvUI_EltreumUI.borders.minimapsizey end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.minimapsizey = value ElvUI_EltreumUI:Borders() end,
							},
							headerline2 = {
								order = 91,
								type = "description",
								name = AURAS,
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							enableaura = {
								type = 'toggle',
								name = L["Enable"].." "..AURAS,
								width = "full",
								order = 92,
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders end,
								get = function() return E.db.ElvUI_EltreumUI.borders.auraborder end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.auraborder = value E:StaticPopup_Show('CONFIG_RL') ElvUI_EltreumUI:AuraBorders() end,
							},
							aurabordersizex = {
								type = 'range',
								name = L["Aura Border X offset"],
								order = 93,
								min = 1,
								max = 100,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.ElvUI_EltreumUI.borders.auraborder end,
								get = function() return E.db.ElvUI_EltreumUI.borders.aurasizex end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.aurasizex = value ElvUI_EltreumUI:AuraBorders() end,
							},
							aurabordersizey = {
								type = 'range',
								name = L["Aura Border Y offset"],
								order = 94,
								min = 1,
								max = 100,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.ElvUI_EltreumUI.borders.auraborder end,
								get = function() return E.db.ElvUI_EltreumUI.borders.aurasizey end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.aurasizey = value ElvUI_EltreumUI:AuraBorders() end,
							},
							debuffaurabordersizex = {
								type = 'range',
								name = L["Debuff Aura Border X offset"],
								order = 95,
								min = 1,
								max = 100,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.ElvUI_EltreumUI.borders.auraborder end,
								get = function() return E.db.ElvUI_EltreumUI.borders.debuffaurasizex end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.debuffaurasizex = value ElvUI_EltreumUI:AuraBorders() end,
							},
							debuffaurabordersizey = {
								type = 'range',
								name = L["Debuff Aura Border Y offset"],
								order = 96,
								min = 1,
								max = 100,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.ElvUI_EltreumUI.borders.auraborder end,
								get = function() return E.db.ElvUI_EltreumUI.borders.debuffaurasizey end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.debuffaurasizey = value ElvUI_EltreumUI:AuraBorders() end,
							},
							headerlineUFborder = {
								order = 97,
								type = "description",
								name = E.NewSign..L["Unitframe Auras"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							enableaurauf = {
								type = 'toggle',
								name = E.NewSign..L["Enable Unitframe Auras"],
								width = "full",
								order = 98,
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders end,
								get = function() return E.db.ElvUI_EltreumUI.borders.auraborderuf end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.auraborderuf = value E:StaticPopup_Show('CONFIG_RL') ElvUI_EltreumUI:UFAuraBorders() end,
							},
							ufaurabordersizex = {
								type = 'range',
								name = E.NewSign..L["Unitframe Aura Border X offset"],
								order = 99,
								min = 1,
								max = 100,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.ElvUI_EltreumUI.borders.auraborderuf end,
								get = function() return E.db.ElvUI_EltreumUI.borders.ufbuffsizex end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.ufbuffsizex = value ElvUI_EltreumUI:UFAuraBorders() end,
							},
							ufaurabordersizey = {
								type = 'range',
								name = E.NewSign..L["Unitframe Aura Border Y offset"],
								order = 100,
								min = 1,
								max = 100,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.ElvUI_EltreumUI.borders.auraborderuf end,
								get = function() return E.db.ElvUI_EltreumUI.borders.ufbuffsizey end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.ufbuffsizey = value ElvUI_EltreumUI:UFAuraBorders() end,
							},
							ufdebuffaurabordersizex = {
								type = 'range',
								name = E.NewSign..L["Unitframes Debuff Aura Border X offset"],
								order = 101,
								min = 1,
								max = 100,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.ElvUI_EltreumUI.borders.auraborderuf end,
								get = function() return E.db.ElvUI_EltreumUI.borders.ufdebuffsizex end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.ufdebuffsizex = value ElvUI_EltreumUI:UFAuraBorders() end,
							},
							ufdebuffaurabordersizey = {
								type = 'range',
								name = E.NewSign..L["Unitframes Debuff Aura Border Y offset"],
								order = 102,
								min = 1,
								max = 100,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.ElvUI_EltreumUI.borders.auraborderuf end,
								get = function() return E.db.ElvUI_EltreumUI.borders.ufdebuffsizey end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.ufdebuffsizey = value ElvUI_EltreumUI:UFAuraBorders() end,
							},
							headerline3 = {
								order = 195,
								type = "description",
								name = BINDING_HEADER_CHAT,
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							enablechat = {
								type = 'toggle',
								name = L["Enable"].." "..BINDING_HEADER_CHAT,
								width = "full",
								order = 196,
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders end,
								get = function() return E.db.ElvUI_EltreumUI.borders.chatborder end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.chatborder = value E:StaticPopup_Show('CONFIG_RL') ElvUI_EltreumUI:Borders() end,
							},
							leftchatbordersizex = {
								type = 'range',
								name = L["Left Chat Border X offset"],
								order = 197,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders end,
								get = function() return E.db.ElvUI_EltreumUI.borders.leftchatborderx end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.leftchatborderx = value ElvUI_EltreumUI:Borders() end,
							},
							leftchatbordersizey = {
								type = 'range',
								name = L["Left Chat Border Y offset"],
								order = 198,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders end,
								get = function() return E.db.ElvUI_EltreumUI.borders.leftchatbordery end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.leftchatbordery = value ElvUI_EltreumUI:Borders() end,
							},
							rightchatbordersizex = {
								type = 'range',
								name = L["Right Chat Border X offset"],
								order = 199,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders end,
								get = function() return E.db.ElvUI_EltreumUI.borders.rightchatborderx end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.rightchatborderx = value ElvUI_EltreumUI:Borders() end,
							},
							rightchatbordersizey = {
								type = 'range',
								name = L["Right Chat Border Y offset"],
								order = 200,
								min = 1,
								max = 800,
								step = 0.1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.borders.borders end,
								get = function() return E.db.ElvUI_EltreumUI.borders.rightchatbordery end,
								set = function(_, value) E.db.ElvUI_EltreumUI.borders.rightchatbordery = value ElvUI_EltreumUI:Borders() end,
							},
						},
					}
				},
			},
			chat = {
				type = 'group',
				name = CHAT_LABEL,
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\chat',
				order = 85,
				args = {
					header0 = {
						order = 1,
						type = "description",
						name = "",
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					chatfadeenable = {
						order = 2,
						type = 'toggle',
						name = L["Enable ElvUI Chat modifications"],
						width = 'full',
						desc = L["Enable adding more functions to ElvUI Chat"],
						get = function() return E.db.ElvUI_EltreumUI.chat.enable end,
						set = function(_, value) E.db.ElvUI_EltreumUI.chat.enable = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					header1 = {
						order = 3,
						type = "description",
						name = L["Add mouse over to the left chat panel"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					leftmouseover = {
						order = 5,
						type = 'toggle',
						name = L["Left Chat Mouse Over"],
						desc = L["Toggle the option"],
						width = 'full',
						disabled = function() return not E.db.ElvUI_EltreumUI.chat.enable end,
						get = function() return E.db.ElvUI_EltreumUI.chat.leftmouseover end,
						set = function(_, value) E.db.ElvUI_EltreumUI.chat.leftmouseover = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					header2 = {
						order = 6,
						type = "description",
						name = L["Add a fade to the left chat panel, controlled by ElvUI Chat > Text Fade > Inactivity Timer"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					leftfade = {
						order = 7,
						type = 'toggle',
						name = L["Left Inactivity Fader"],
						width = 'full',
						desc = L["Toggle the option"],
						disabled = function() return not E.db.ElvUI_EltreumUI.chat.enable end,
						get = function() return E.db.ElvUI_EltreumUI.chat.leftfader end,
						set = function(_, value) E.db.ElvUI_EltreumUI.chat.leftfader = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					header3 = {
						order = 8,
						type = "description",
						name = L["Add mouse over to the left chat panel"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					rightmouseover = {
						order = 9,
						type = 'toggle',
						name = L["Right Chat Mouse Over"],
						desc = L["Toggle the option"],
						width = 'full',
						disabled = function() return not E.db.ElvUI_EltreumUI.chat.enable end,
						get = function() return E.db.ElvUI_EltreumUI.chat.rightmouseover end,
						set = function(_, value) E.db.ElvUI_EltreumUI.chat.rightmouseover = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					header4 = {
						order = 10,
						type = "description",
						name = L["Add a fade to the right chat panel, controlled by ElvUI Chat > Text Fade > Inactivity Timer"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					rightfade = {
						order = 11,
						type = 'toggle',
						name = L["Right Inactivity Fader"],
						desc = L["Toggle the option"],
						width = 'full',
						disabled = function() return not E.db.ElvUI_EltreumUI.chat.enable end,
						get = function() return E.db.ElvUI_EltreumUI.chat.rightfader end,
						set = function(_, value) E.db.ElvUI_EltreumUI.chat.rightfader = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					header5 = {
						order = 12,
						type = "description",
						name = L["Combat Hide"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					leftcombathide = {
						order = 13,
						type = 'toggle',
						name = L["Hide Left Chat in Combat"],
						width = 'full',
						desc = L["Toggle the option"],
						disabled = function() return not E.db.ElvUI_EltreumUI.chat.enable end,
						get = function() return E.db.ElvUI_EltreumUI.chat.leftcombathide end,
						set = function(_, value) E.db.ElvUI_EltreumUI.chat.leftcombathide = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					rightcombathide = {
						order = 14,
						type = 'toggle',
						name = L["Hide Right Chat in Combat"],
						width = 'full',
						desc = L["Toggle the option"],
						disabled = function() return not E.db.ElvUI_EltreumUI.chat.enable end,
						get = function() return E.db.ElvUI_EltreumUI.chat.rightcombathide end,
						set = function(_, value) E.db.ElvUI_EltreumUI.chat.rightcombathide = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					header6 = {
						order = 15,
						type = "description",
						name = L["Invert left mouse click so that chat starts faded and mouse click will make it stop fading"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					invertmouse = {
						order = 16,
						type = 'toggle',
						name = L["Invert Mouse Click"],
						width = 'full',
						desc = L["Toggle the option on"],
						disabled = function() return not E.db.ElvUI_EltreumUI.chat.enable end,
						get = function() return E.db.ElvUI_EltreumUI.chat.invertclick end,
						set = function(_, value) E.db.ElvUI_EltreumUI.chat.invertclick = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					header7 = {
						order = 17,
						type = "description",
						name = L["Add color to some chat messages"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					colorsysmsgs = {
						order = 88,
						type = 'toggle',
						name = L["Enable on System Messages"],
						width = 'full',
						desc = L["Toggle the option on"],
						disabled = function() return not E.db.ElvUI_EltreumUI.chat.enable end,
						get = function() return E.db.ElvUI_EltreumUI.chat.colorsysmsg end,
						set = function(_, value) E.db.ElvUI_EltreumUI.chat.colorsysmsg = value end,
					},
					classcolormsgs = {
						order = 89,
						type = 'toggle',
						name = L["Enable on Chat Messages"],
						width = 'double',
						desc = L["Toggle the option on"],
						disabled = function() return not E.db.ElvUI_EltreumUI.chat.enable end,
						get = function() return E.db.ElvUI_EltreumUI.chat.classcolorchat end,
						set = function(_, value) E.db.ElvUI_EltreumUI.chat.classcolorchat = value end,
					},
					classcolormsgscustom = {
						order = 90,
						type = 'toggle',
						name = L["Custom Color"],
						--width = 'double',
						desc = L["Toggle the option on"],
						disabled = function() return not E.db.ElvUI_EltreumUI.chat.enable or not E.db.ElvUI_EltreumUI.chat.classcolorchat end,
						get = function() return E.db.ElvUI_EltreumUI.chat.classcolorchatcustom end,
						set = function(_, value) E.db.ElvUI_EltreumUI.chat.classcolorchatcustom = value end,
					},
					headerkeys = {
						order = 189,
						type = "description",
						name = L["!key Chat Command"],
						width = 'full',
						hidden = not E.Retail,
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					mpluskeys = {
						order = 190,
						type = 'toggle',
						name = L["Enable !key and !keys chat command"],
						width = 'full',
						hidden = not E.Retail,
						desc = L["Will link your key and covenant in guild or party chat"],
						get = function() return E.db.ElvUI_EltreumUI.otherstuff.mpluskeys end,
						set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.mpluskeys = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					header8 = {
						order = 191,
						type = "description",
						name = L["Enhance Item Links in Chat"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					chatlooticons = {
						order = 192,
						type = 'toggle',
						name = L["Enable Chat Icons"],
						width = 'full',
						desc = L["Toggle the option on"],
						disabled = function() return not E.db.ElvUI_EltreumUI.chat.enable end,
						get = function() return E.db.ElvUI_EltreumUI.chat.looticons end,
						set = function(_, value) E.db.ElvUI_EltreumUI.chat.looticons = value end,
					},
					chatitemlevels = {
						order = 193,
						type = 'toggle',
						name = L["Enable Item Levels"],
						width = 'full',
						desc = L["Toggle the option on"],
						disabled = function() return not E.db.ElvUI_EltreumUI.chat.enable or not E.db.ElvUI_EltreumUI.chat.looticons end,
						get = function() return E.db.ElvUI_EltreumUI.chat.itemlevels end,
						set = function(_, value) E.db.ElvUI_EltreumUI.chat.itemlevels = value end,
					},
					header9 = {
						order = 194,
						type = "description",
						name = L["Customize the Chat tabs"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					darkchat = {
						order = 195,
						type = 'execute',
						name = L["Dark Chat"],
						--width = 'double',
						func = function() ElvUI_EltreumUI:DarkChat() E:StaticPopup_Show('CONFIG_RL') end,
					},
					lightchat = {
						order = 196,
						type = 'execute',
						name = L["Transparent Chat"],
						--width = 'double',
						func = function() ElvUI_EltreumUI:TransparentChat() E:StaticPopup_Show('CONFIG_RL') end,
					},
				},
			},
			combatmusic = {
				type = 'group',
				name = L["Combat Music"],
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\music',
				order = 85,
				args = {
					header1 = {
						order = 1,
						type = "description",
						name = L["Play music during combat"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					moremusicsettings = {
						order = 2,
						type = 'group',
						inline = true,
						name = "",
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
			},
			cooldown = {
				type = 'group',
				name = L["Cooldown"],
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\cooldown',
				order = 85,
				args = {
					header1 = {
						order = 1,
						type = "description",
						name = L["Cooldown"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					enable = {
						order = 2,
						type = 'toggle',
						name = L["Enable Cooldown Pulse"],
						desc = L["Show a Skill Pulse when its cooldown is ending"],
						width = 'full',
						get = function() return E.db.ElvUI_EltreumUI.skins.doom.enable end,
						set = function(_, value) E.db.ElvUI_EltreumUI.skins.doom.enable = value ElvUI_EltreumUI:Doom() E:StaticPopup_Show('PRIVATE_RL') end,
					},
					showSpellName = {
						order = 3,
						type = 'toggle',
						name = L["Show Spell Name"],
						desc = L["Displays a Text with the name of the spell"],
						width = 'full',
						disabled = function() return not E.db.ElvUI_EltreumUI.skins.doom.enable end,
						get = function() return E.db.ElvUI_EltreumUI.skins.doom.showSpellName end,
						set = function(_, value) E.db.ElvUI_EltreumUI.skins.doom.showSpellName = value ElvUI_EltreumUI:Doom() E:StaticPopup_Show('PRIVATE_RL') end,
					},
					fadeInTime = {
						type = 'range',
						name = L["Fade In Time"],
						desc = L["Time it takes for the icon to fade in"],
						order = 4,
						min = 0,
						max = 5,
						step = 0.1,
						--width = "full",
						disabled = function() return not E.db.ElvUI_EltreumUI.skins.doom.enable end,
						get = function() return E.db.ElvUI_EltreumUI.skins.doom.fadeInTime end,
						set = function(_, value) E.db.ElvUI_EltreumUI.skins.doom.fadeInTime = value ElvUI_EltreumUI:Doom() end,
					},
					fadeOutTime = {
						type = 'range',
						name = L["Fade Out Time"],
						desc = L["Time it takes for the icon to fade out"],
						order = 4,
						min = 0,
						max = 5,
						step = 0.1,
						--width = "full",
						disabled = function() return not E.db.ElvUI_EltreumUI.skins.doom.enable end,
						get = function() return E.db.ElvUI_EltreumUI.skins.doom.fadeOutTime end,
						set = function(_, value) E.db.ElvUI_EltreumUI.skins.doom.fadeOutTime = value ElvUI_EltreumUI:Doom() end,
					},
					maxAlpha = {
						type = 'range',
						name = L["Alpha"],
						desc = L["Transparency of the Icon"],
						order = 4,
						min = 0,
						max = 100,
						step = 0.1,
						--width = "full",
						disabled = function() return not E.db.ElvUI_EltreumUI.skins.doom.enable end,
						get = function() return E.db.ElvUI_EltreumUI.skins.doom.maxAlpha end,
						set = function(_, value) E.db.ElvUI_EltreumUI.skins.doom.maxAlpha = value ElvUI_EltreumUI:Doom() end,
					},
					animScale = {
						type = 'range',
						name = L["Animation Scale"],
						desc = L["Animation will scale to this size"],
						order = 4,
						min = 0,
						max = 5,
						step = 0.1,
						--width = "full",
						disabled = function() return not E.db.ElvUI_EltreumUI.skins.doom.enable end,
						get = function() return E.db.ElvUI_EltreumUI.skins.doom.animScale end,
						set = function(_, value) E.db.ElvUI_EltreumUI.skins.doom.animScale = value ElvUI_EltreumUI:Doom() end,
					},
					iconSize = {
						type = 'range',
						name = L["Icon Size"],
						desc = L["Size of the Icon"],
						order = 4,
						min = 6,
						max = 200,
						step = 0.1,
						--width = "full",
						disabled = function() return not E.db.ElvUI_EltreumUI.skins.doom.enable end,
						get = function() return E.db.ElvUI_EltreumUI.skins.doom.iconSize end,
						set = function(_, value) E.db.ElvUI_EltreumUI.skins.doom.iconSize = value ElvUI_EltreumUI:Doom() end,
					},
					holdTime = {
						type = 'range',
						name = L["Hold Time"],
						desc = L["How long the Icon will appear"],
						order = 4,
						min = 0,
						max = 5,
						step = 0.1,
						--width = "full",
						disabled = function() return not E.db.ElvUI_EltreumUI.skins.doom.enable end,
						get = function() return E.db.ElvUI_EltreumUI.skins.doom.holdTime end,
						set = function(_, value) E.db.ElvUI_EltreumUI.skins.doom.holdTime = value ElvUI_EltreumUI:Doom() end,
					},
					graceperiod = {
						type = 'range',
						name = L["Minimum Cooldown Length"],
						desc = L["Cooldowns must be longer than this to show up"],
						order = 4,
						min = 0,
						max = 120,
						step = 1,
						--width = "full",
						disabled = function() return not E.db.ElvUI_EltreumUI.skins.doom.enable end,
						get = function() return E.db.ElvUI_EltreumUI.skins.doom.graceperiod end,
						set = function(_, value) E.db.ElvUI_EltreumUI.skins.doom.graceperiod = value ElvUI_EltreumUI:Doom() end,
					},
					doomignored = {
						order = 5,
						type = 'input',
						name = L["Ignored Spells, use a comma to separate spells"],
						desc = L["List of spells ignored, use a comma to separate spells"],
						width = 'full',
						get = function() return E.private.ElvUI_EltreumUI.doomignored end,
						set = function(_, value) E.private.ElvUI_EltreumUI.doomignored = value ElvUI_EltreumUI:Doom() E:StaticPopup_Show('PRIVATE_RL') end,
					},
					ttsvoice = {
						order = 80,
						type = "description",
						name = L["Text to Speech"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					ttsvoicetoggle = {
						type = 'toggle',
						name = L["Enable"],
						order = 81,
						disabled = function() return not E.db.ElvUI_EltreumUI.skins.doom.enable end,
						get = function() return E.db.ElvUI_EltreumUI.skins.doom.tts end,
						set = function(_, value) E.db.ElvUI_EltreumUI.skins.doom.tts = value ElvUI_EltreumUI:Doom() end,
					},
					ttsvoiceselect = {
						type = 'select',
						name= L["Text to Speech Config"],
						order = 82,
						values =
						function()
							local Voices = {}
							for i, v in pairs(C_VoiceChat.GetTtsVoices()) do
								--Voices[i] = v.name
								Voices[i] = v.voiceID
							end
							return Voices
						end,
						validate = function(_, value)
							if tonumber(value) ~= nil then
								return true
							else
								return false
							end
						end,
						--[[sorting = function()
							return sort(Voices, SortList)
						end,]]
						style = 'radio',
						disabled = function() return not E.db.ElvUI_EltreumUI.skins.doom.enable or not E.db.ElvUI_EltreumUI.skins.doom.tts end,
						get = function() return E.db.ElvUI_EltreumUI.skins.doom.ttsvoice end,
						set = function(_, value) E.db.ElvUI_EltreumUI.skins.doom.ttsvoice = tonumber(value) C_VoiceChat.SpeakText(E.db.ElvUI_EltreumUI.skins.doom.ttsvoice, TEXT_TO_SPEECH, Enum.VoiceTtsDestination.LocalPlayback, 0, E.db.ElvUI_EltreumUI.skins.doom.ttsvolume) end,
					},
					volume = {
						type = 'range',
						name = VOLUME,
						order = 103,
						min = 1,
						max = 100,
						step = 1,
						width = "full",
						disabled = function() return not E.db.ElvUI_EltreumUI.skins.doom.enable or not E.db.ElvUI_EltreumUI.skins.doom.tts end,
						get = function() return E.db.ElvUI_EltreumUI.skins.doom.ttsvolume end,
						set = function(_, value) E.db.ElvUI_EltreumUI.skins.doom.ttsvolume = value end,
					},
					previewgap = {
						order = 104,
						type = "description",
						name = PREVIEW,
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					preview ={
						order = 105,
						type = "execute",
						name = PREVIEW,
						width = 'full',
						func = function() ElvUI_EltreumUI:PreviewDoom() end,
					},
				},
			},
			cursor = {
				type = 'group',
				name = L["Cursor"],
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\cursor',
				order = 85,
				childGroups = "tab",
				args = {
					cursorgeneral = {
						order = 1,
						type = 'group',
						name= L["General"],
						args = {
							header = {
								order = 1,
								type = "description",
								name= "",
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							enable = {
								order = 1,
								type = 'toggle',
								name = L["Enable cursor rings for Casts, GCD and Combat"],
								desc = L["Add a rings around the mouse cursor for GCD, casts and combat"],
								width = 'full',
								get = function() return E.db.ElvUI_EltreumUI.cursors.cursor.enable end,
								set = function(_, value) E.db.ElvUI_EltreumUI.cursors.cursor.enable = value end,
							},
							enablecombat = {
								order = 2,
								type = 'toggle',
								name = L["Enable cursor only during combat"],
								desc = L["Cursor will only show during combat"],
								width = 'full',
								disabled = function() return not E.db.ElvUI_EltreumUI.cursors.cursor.enable end,
								get = function() return E.db.ElvUI_EltreumUI.cursors.cursor.combat end,
								set = function(_, value) E.db.ElvUI_EltreumUI.cursors.cursor.combat = value E:StaticPopup_Show('PRIVATE_RL') end,
							},
							enablecd = {
								order = 3,
								type = 'toggle',
								name = L["Enable cooldown tracking"],
								desc = L["Add a cooldown icon when trying to use skills that are on cooldown, and a cooldown flash when they are ready"],
								width = 'full',
								disabled = function() return not E.db.ElvUI_EltreumUI.cursors.cursor.enable end,
								get = function() return E.db.ElvUI_EltreumUI.cursors.cursor.cooldown end,
								set = function(_, value) E.db.ElvUI_EltreumUI.cursors.cursor.cooldown = value E:StaticPopup_Show('PRIVATE_RL') end,
							},
							enablepetcd = {
								order = 4,
								type = 'toggle',
								name = L["Enable pet cooldown tracking"],
								desc = L["Add a cooldown icon when trying to use skills that are on cooldown, and a cooldown flash when they are ready"],
								width = 'full',
								disabled = function() return not E.db.ElvUI_EltreumUI.cursors.cursor.enable end,
								get = function() return E.db.ElvUI_EltreumUI.cursors.cursor.petcooldown end,
								set = function(_, value) E.db.ElvUI_EltreumUI.cursors.cursor.petcooldown = value E:StaticPopup_Show('PRIVATE_RL') end,
							},
							header99 = {
								order = 97,
								type = "description",
								name= L["Cooldown Sound"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							enablecdsound = {
								order = 98,
								type = 'toggle',
								name = L["Play a Sound when attempting to use a skill that is on cooldown."],
								width = 'full',
								disabled = function() return not E.db.ElvUI_EltreumUI.cursors.cursor.cooldown end,
								get = function() return E.db.ElvUI_EltreumUI.cursors.cursor.cooldownsound end,
								set = function(_, value) E.db.ElvUI_EltreumUI.cursors.cursor.cooldownsound = value
									if value == true then
										SetCVar('Sound_EnableErrorSpeech', 0)
									else
										SetCVar('Sound_EnableErrorSpeech', 1)
									end
									E:StaticPopup_Show('PRIVATE_RL') end,
							},
							cdsound = {
								order = 99,
								type = 'select',
								width = "double",
								dialogControl = 'LSM30_Sound',
								name = L["Select a Sound"],
								desc = L["Choose a Sound from SharedMedia files"],
								values = AceGUIWidgetLSMlists.sound,
								get = function() return E.db.ElvUI_EltreumUI.cursors.cursor.cooldownfile end,
								disabled = function() return not E.db.ElvUI_EltreumUI.cursors.cursor.cooldownsound or not E.db.ElvUI_EltreumUI.cursors.cursor.cooldown end,
								set = function(self,key) E.db.ElvUI_EltreumUI.cursors.cursor.cooldownfile = key E:StaticPopup_Show('CONFIG_RL') end,
							},
							header1 = {
								order = 120,
								type = "description",
								name= L["Change the size of the World of Warcraft Cursor"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							setsize = {
								order = 121,
								type = 'select',
								name = L["Select a size"],
								desc = L["Choose this size"],
								values = {
									["-1"] = L["Autodetect"],
									["0"] = '32x32',
									["1"] = '48x48',
									["2"] = '64x64',
									["3"] = '128x128',
								},
								style = 'radio',
								get = function() return E.db.ElvUI_EltreumUI.cursors.cursor.size end,
								set = function(_, value) ElvUI_EltreumUI:CursorSize(value) end,
							},
							headerhardwarecursor = {
								order = 122,
								type = "description",
								name= L["Attempt to fix Cursor Lag"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							fixlag = {
								order = 123,
								type = 'select',
								name = " ",
								desc = L["Software cursor is how the cursor was before Battle for Azeroth, Hardware cursor is faster but will cause problems with addons that attach to it"],
								--width = 'full',
								values = {
									["0"] = L["Software Cursor"],
									["1"] = L["Hardware Cursor"],
								},
								style = 'radio',
								get = function() return C_CVar.GetCVar('HardwareCursor') end,
								set = function(_, value) E.db.ElvUI_EltreumUI.cursors.cursor.fixlag = value SetCVar('HardwareCursor', value) end,
							},
						},
					},
					cursorcolors = {
						order = 6,
						type = 'group',
						name = L["Cursor Colors"],
						disabled = function() return not E.db.ElvUI_EltreumUI.cursors.cursor.enable end,
						args = {
							nicegap17 = {
								order = 11,
								type = "description",
								name = L["Cursor Colors "]..'|cffff0000('..L["Requires a Reload"]..")|r",
								width = 'full',
							},
							header12 = {
								order = 11,
								type = "description",
								name = "",
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							castclasscolor = {
								type = 'toggle',
								name = L["Class Colored Casts"],
								order = 12,
								desc = L["Use Class Colors for Cast"],
								disabled = function() return not E.db.ElvUI_EltreumUI.cursors.cursor.enable end,
								get = function() return E.db.ElvUI_EltreumUI.cursors.cursorcast.classcolor end,
								set = function(_, value) E.db.ElvUI_EltreumUI.cursors.cursorcast.classcolor = value ElvUI_EltreumUI:CastCursor() end,
							},
							colorcast = {
								order = 13,
								type = 'color',
								name = L["Custom Color Cast"],
								hasAlpha = false,
								disabled = function() return (not E.db.ElvUI_EltreumUI.cursors.cursor.enable) or E.db.ElvUI_EltreumUI.cursors.cursorcast.classcolor end,
								get = function()
									local cursorcast = E.db.ElvUI_EltreumUI.cursors.cursorcast
									local d = P.ElvUI_EltreumUI.cursors.cursorcast
									return cursorcast.r, cursorcast.g, cursorcast.b, cursorcast.a, d.r, d.g, d.b, d.a
								end,
								set = function(_, r, g, b, a)
									local cursorcast = E.db.ElvUI_EltreumUI.cursors.cursorcast
									cursorcast.r, cursorcast.g, cursorcast.b = r, g, b ElvUI_EltreumUI:CastCursor()
								end,
							},
							gradientcastcursor = {
								type = 'toggle',
								name = L["Gradient"],
								order = 14,
								disabled = function() return not E.db.ElvUI_EltreumUI.cursors.cursor.enable or not E.db.ElvUI_EltreumUI.cursors.cursorcast.classcolor end,
								get = function() return E.db.ElvUI_EltreumUI.cursors.cursorcast.gradient end,
								set = function(_, value) E.db.ElvUI_EltreumUI.cursors.cursorcast.gradient = value ElvUI_EltreumUI:CastCursor() end,
							},
							nicegap1 = {
								order = 92,
								type = "description",
								name = "",
								width = 'full',
							},
							gcdclasscolor = {
								type = 'toggle',
								name = L["Class Colored GCD"],
								order = 93,
								desc = L["Use Class Colors for GCD"],
								disabled = function() return not E.db.ElvUI_EltreumUI.cursors.cursor.enable end,
								get = function() return E.db.ElvUI_EltreumUI.cursors.cursorgcd.classcolor end,
								set = function(_, value) E.db.ElvUI_EltreumUI.cursors.cursorgcd.classcolor = value ElvUI_EltreumUI:CastCursor() end,
							},
							colorgcd = {
								order = 94,
								type = 'color',
								name = L["Custom Color GCD"],
								hasAlpha = false,
								disabled = function() return E.db.ElvUI_EltreumUI.cursors.cursorgcd.classcolor or (not E.db.ElvUI_EltreumUI.cursors.cursor.enable ) end,
								get = function()
									local cursorgcd = E.db.ElvUI_EltreumUI.cursors.cursorgcd
									local d = P.ElvUI_EltreumUI.cursors.cursorgcd
									return cursorgcd.r, cursorgcd.g, cursorgcd.b, cursorgcd.a, d.r, d.g, d.b, d.a
								end,
								set = function(_, r, g, b, a)
									local cursorgcd = E.db.ElvUI_EltreumUI.cursors.cursorgcd
									cursorgcd.r, cursorgcd.g, cursorgcd.b = r, g, b ElvUI_EltreumUI:CastCursor()
								end,
							},
							nicegap2 = {
								order = 95,
								type = "description",
								name = "",
								width = 'full',
							},
							cursorcursorclasscolor = {
								type = 'toggle',
								name = L["Class Colored Combat"],
								order = 96,
								desc = L["Use Class Colors for Cursor"],
								disabled = function() return not E.db.ElvUI_EltreumUI.cursors.cursor.enable end,
								get = function() return E.db.ElvUI_EltreumUI.cursors.cursorcursor.classcolor end,
								set = function(_, value) E.db.ElvUI_EltreumUI.cursors.cursorcursor.classcolor = value ElvUI_EltreumUI:CastCursor() end,
							},
							cursorcursorcolor = {
								order = 97,
								type = 'color',
								name = L["Custom Color Combat"],
								hasAlpha = false,
								disabled = function() return E.db.ElvUI_EltreumUI.cursors.cursorcursor.classcolor or (not E.db.ElvUI_EltreumUI.cursors.cursor.enable) end,
								get = function()
									local cursorcursor = E.db.ElvUI_EltreumUI.cursors.cursorcursor
									local d = P.ElvUI_EltreumUI.cursors.cursorcursor
									return cursorcursor.r, cursorcursor.g, cursorcursor.b, cursorcursor.a, d.r, d.g, d.b, d.a
								end,
								set = function(_, r, g, b, a)
									local cursorcursor = E.db.ElvUI_EltreumUI.cursors.cursorcursor
									cursorcursor.r, cursorcursor.g, cursorcursor.b = r, g, b ElvUI_EltreumUI:CastCursor()
								end,
							},
						},
					},
					cursortype = {
						order = 7,
						type = 'group',
						name = L["Cursor Type"],
						disabled = function() return not E.db.ElvUI_EltreumUI.cursors.cursor.enable end,
						args = {
							topbar = {
								order = 0,
								type = "description",
								name = L["Choose a type of cursor by clicking it"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							gap = {
								order = 1,
								type = "description",
								name = "",
								width = 'full',
							},
							gap2 = {
								order = 2,
								type = "description",
								name = "",
								width = 'full',
							},
							gap3 = {
								order = 3,
								type = "description",
								name = "",
								width = 'full',
							},
							currentring = {
								order = 5,
								type = 'description',
								name = function() return L["Currently selected cursor: "]..ElvUI_EltreumUI:CurrentTypeofCursor() end,
								desc = L["Choose a type of cursor by clicking it"],
							},
							showring1 = {
								order = 90,
								type = "execute",
								image = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring1',
								name = L["Type 1"],
								desc = L["The Cursor will use this type as its texture"],
								func = function() E.db.ElvUI_EltreumUI.cursors.cursor.ring = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring1.tga' ElvUI_EltreumUI:CastCursor() end,
							},
							showring2 = {
								order = 91,
								type = "execute",
								image = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring2',
								name = L["Type 2"],
								desc = 'The Cursor will use this type as its texture',
								confirm = true,
								func = function() E.db.ElvUI_EltreumUI.cursors.cursor.ring = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring2.tga' ElvUI_EltreumUI:CastCursor() end,
							},
							showring3 = {
								order = 92,
								type = "execute",
								image = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring3',
								name = L["Type 3"],
								desc = L["The Cursor will use this type as its texture"],
								confirm = true,
								func = function() E.db.ElvUI_EltreumUI.cursors.cursor.ring = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring3.tga' ElvUI_EltreumUI:CastCursor() end,
							},
							showring4 = {
								order = 93,
								type = "execute",
								image = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring4',
								name = L["Type 4"],
								desc = L["The Cursor will use this type as its texture"],
								confirm = true,
								func = function() E.db.ElvUI_EltreumUI.cursors.cursor.ring = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring4.tga' ElvUI_EltreumUI:CastCursor() end,
							},
							showring5 = {
								order = 94,
								type = "execute",
								image = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring5',
								name = L["Type 5"],
								desc = L["The Cursor will use this type as its texture"],
								confirm = true,
								func = function() E.db.ElvUI_EltreumUI.cursors.cursor.ring = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring5.tga' ElvUI_EltreumUI:CastCursor() end,
							},
							showring6 = {
								order = 95,
								type = "execute",
								image = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring6',
								name = L["Type 6"],
								desc = L["The Cursor will use this type as its texture"],
								confirm = true,
								func = function() E.db.ElvUI_EltreumUI.cursors.cursor.ring = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring6.tga' ElvUI_EltreumUI:CastCursor() end,
							},
							showring7 = {
								order = 96,
								type = "execute",
								image = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring7',
								name = L["Type 7"],
								desc = L["The Cursor will use this type as its texture"],
								confirm = true,
								func = function() E.db.ElvUI_EltreumUI.cursors.cursor.ring = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring7.tga' ElvUI_EltreumUI:CastCursor() end,
							},
							showring8 = {
								order = 97,
								type = "execute",
								image = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring8',
								name = L["Type 8"],
								desc = L["The Cursor will use this type as its texture"],
								confirm = true,
								func = function() E.db.ElvUI_EltreumUI.cursors.cursor.ring = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring8.tga' ElvUI_EltreumUI:CastCursor() end,
							},
							showring9 = {
								order = 98,
								type = "execute",
								image = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring9',
								name = L["Type 9"],
								desc = L["The Cursor will use this type as its texture"],
								confirm = true,
								func = function() E.db.ElvUI_EltreumUI.cursors.cursor.ring = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring9.tga' ElvUI_EltreumUI:CastCursor() end,
							},
							showring10 = {
								order = 99,
								type = "execute",
								image = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring10',
								name = L["Type 10"],
								desc = L["The Cursor will use this type as its texture"],
								confirm = true,
								func = function() E.db.ElvUI_EltreumUI.cursors.cursor.ring = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring10.tga' ElvUI_EltreumUI:CastCursor() end,
							},
						},
					},
					cursorsize = {
						order = 3,
						type = 'group',
						name = L["Cursor Sizes"],
						disabled = function() return not E.db.ElvUI_EltreumUI.cursors.cursor.enable end,
						args = {
							header1 = {
								order = 18,
								type = "description",
								name = "",
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							nicegap3 = {
								order = 18,
								type = "description",
								name = L["Cursor Sizes "]..'|cffff0000('..L["Requires a Reload"]..")|r",
								width = 'full',
							},
							castradius = {
								type = 'range',
								name = L["Cast Radius (Default: 25)"],
								desc = L["Set the radius of the cast cursor"],
								order = 19,
								min = 10,
								max = 50,
								step = 1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.cursors.cursor.enable end,
								get = function() return E.db.ElvUI_EltreumUI.cursors.cursorcast.radius end,
								set = function(_, value) E.db.ElvUI_EltreumUI.cursors.cursorcast.radius = value ElvUI_EltreumUI:CastCursor() end,
							},
							castthickness = {
								type = 'range',
								name = L["Cast Thickness (Default: 5)"],
								desc = L["Set the radius of the cast cursor"],
								order = 19,
								min = 1,
								max = 10,
								step = 1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.cursors.cursor.enable end,
								get = function() return E.db.ElvUI_EltreumUI.cursors.cursorcast.thickness end,
								set = function(_, value) E.db.ElvUI_EltreumUI.cursors.cursorcast.thickness = value ElvUI_EltreumUI:CastCursor() end,
							},
							gcdradius = {
								type = 'range',
								name = L["GCD Radius (Default: 20)"],
								desc = L["Set the radius of the gcd cursor"],
								order = 19,
								min = 10,
								max = 50,
								step = 1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.cursors.cursor.enable end,
								get = function() return E.db.ElvUI_EltreumUI.cursors.cursorgcd.radius end,
								set = function(_, value) E.db.ElvUI_EltreumUI.cursors.cursorgcd.radius = value ElvUI_EltreumUI:CastCursor() end,
							},
							gcdthickness = {
								type = 'range',
								name = L["GCD Thickness (Default: 5)"],
								desc = L["Set the thickness of the gcd cursor"],
								order = 19,
								min = 1,
								max = 10,
								step = 1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.cursors.cursor.enable end,
								get = function() return E.db.ElvUI_EltreumUI.cursors.cursorgcd.thickness end,
								set = function(_, value) E.db.ElvUI_EltreumUI.cursors.cursorgcd.thickness = value ElvUI_EltreumUI:CastCursor() end,
							},
							cursorcursorradius = {
								type = 'range',
								name = L["Combat Cursor Radius (Default: 15)"],
								desc = L["Set the radius of the combat cursor"],
								order = 19,
								min = 10,
								max = 50,
								step = 1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.cursors.cursor.enable end,
								get = function() return E.db.ElvUI_EltreumUI.cursors.cursorcursor.radius end,
								set = function(_, value) E.db.ElvUI_EltreumUI.cursors.cursorcursor.radius = value ElvUI_EltreumUI:CastCursor() end,
							},
							cursorcursorthickness = {
								type = 'range',
								name = L["Combat Cursor Thickness (Default: 5)"],
								desc = L["Set the thickness of the combat cursor"],
								order = 19,
								min = 1,
								max = 10,
								step = 1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.cursors.cursor.enable end,
								get = function() return E.db.ElvUI_EltreumUI.cursors.cursorcursor.thickness end,
								set = function(_, value) E.db.ElvUI_EltreumUI.cursors.cursorcursor.thickness = value ElvUI_EltreumUI:CastCursor() end,
							},
							header2 = {
								order = 20,
								type = "description",
								name = "",
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							nicegap4 = {
								order = 21,
								type = "description",
								name = L["Cursor Position"],
								width = 'full',
							},
							coooldownx = {
								type = 'range',
								name = L["Set X offset"],
								order = 22,
								min = -200,
								max = 200,
								step = 1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.cursors.cursor.enable or not E.db.ElvUI_EltreumUI.cursors.cursor.cooldown end,
								get = function() return E.db.ElvUI_EltreumUI.cursors.cursor.cooldownoffsetx end,
								set = function(_, value) E.db.ElvUI_EltreumUI.cursors.cursor.cooldownoffsetx = value end,
							},
							coooldowny = {
								type = 'range',
								name = L["Set Y offset"],
								order = 22,
								min = -200,
								max = 200,
								step = 1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.cursors.cursor.enable or not E.db.ElvUI_EltreumUI.cursors.cursor.cooldown end,
								get = function() return E.db.ElvUI_EltreumUI.cursors.cursor.cooldownoffsety end,
								set = function(_, value) E.db.ElvUI_EltreumUI.cursors.cursor.cooldownoffsety = value end,
							},
						},
					},
				},
			},
			customglow = {
				type = 'group',
				name = L["Custom Glow"],
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\customglow',
				order = 85,
				childGroups = "tab",
				args = {
					general = {
						type = 'group',
						name = L["General"],
						order = 1,
						args = {
							generalglowop1 = {
								order = 50,
								type = "description",
								name = L["Replace Blizzards Default Glow with a Custom Glow"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							enable = {
								type = 'toggle',
								name = L["Enable on Action Bars"],
								order = 51,
								width = 'full',
								get = function() return E.db.ElvUI_EltreumUI.glow.enable end,
								set = function(_, value) E.db.ElvUI_EltreumUI.glow.enable = value end,
							},
							enablepet = {
								type = 'toggle',
								name = L["Enable on Pet Bar"],
								order = 52,
								width = 'full',
								get = function() return E.db.ElvUI_EltreumUI.glow.enablepet end,
								set = function(_, value) E.db.ElvUI_EltreumUI.glow.enablepet = value end,
							},
							enableuf = {
								order = 53,
								type = 'toggle',
								name = E.NewSign..L["Enable on Unitframes"],
								desc = L["Add a glow when Unitframes have a debuff"],
								width = 'full',
								get = function() return E.db.ElvUI_EltreumUI.glow.enableUFs end,
								set = function(_, value) E.db.ElvUI_EltreumUI.glow.enableUFs = value end,
							},
							enablenp = {
								order = 54,
								type = 'toggle',
								name = L["Enable on Nameplate"],
								desc = L["Add a glow when buffs or debuffs are expiring on nameplates"],
								width = 'full',
								get = function() return E.db.ElvUI_EltreumUI.nameplates.widenameplate.npglow end,
								set = function(_, value) E.db.ElvUI_EltreumUI.nameplates.widenameplate.npglow = value end,
							},
							debuffduration = {
								type = 'range',
								name = L["Debuff Timer"],
								desc = L["Time at which the glow will start"],
								order = 55,
								min = 1,
								max = 30,
								step = 1,
								width = "double",
								disabled = function() return not E.db.ElvUI_EltreumUI.nameplates.widenameplate.npglow end,
								get = function() return E.db.ElvUI_EltreumUI.glow.numberdebuff end,
								set = function(_, value) E.db.ElvUI_EltreumUI.glow.numberdebuff = value end,
							},
							headerlinetotemsglow = {
								order = 93,
								type = "description",
								name = L["Shaman Totems"],
								width = 'full',
								hidden = E.Retail,
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							enabletotem = {
								type = 'toggle',
								name = L["Enable on Shaman Totems"],
								order = 94,
								width = 'full',
								hidden = E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.glow.enable end,
								get = function() return E.db.ElvUI_EltreumUI.glow.enabletotem end,
								set = function(_, value) E.db.ElvUI_EltreumUI.glow.enabletotem = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							enabletotem1 = {
								type = 'toggle',
								name = L["Enable on Shaman Fire Totem"],
								order = 95,
								width = 'full',
								hidden = E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.glow.enable or not E.db.ElvUI_EltreumUI.glow.enabletotem end,
								get = function() return E.db.ElvUI_EltreumUI.glow.totem1 end,
								set = function(_, value) E.db.ElvUI_EltreumUI.glow.totem1 = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							enabletotem2 = {
								type = 'toggle',
								name = L["Enable on Shaman Earth Totem"],
								order = 96,
								width = 'full',
								hidden = E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.glow.enable or not E.db.ElvUI_EltreumUI.glow.enabletotem end,
								get = function() return E.db.ElvUI_EltreumUI.glow.totem2 end,
								set = function(_, value) E.db.ElvUI_EltreumUI.glow.totem2 = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							enabletotem3 = {
								type = 'toggle',
								name = L["Enable on Shaman Water Totem"],
								order = 97,
								width = 'full',
								hidden = E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.glow.enable or not E.db.ElvUI_EltreumUI.glow.enabletotem end,
								get = function() return E.db.ElvUI_EltreumUI.glow.totem3 end,
								set = function(_, value) E.db.ElvUI_EltreumUI.glow.totem3 = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							enabletotem4 = {
								type = 'toggle',
								name = L["Enable on Shaman Air Totem"],
								order = 98,
								width = 'full',
								hidden = E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.glow.enable or not E.db.ElvUI_EltreumUI.glow.enabletotem end,
								get = function() return E.db.ElvUI_EltreumUI.glow.totem4 end,
								set = function(_, value) E.db.ElvUI_EltreumUI.glow.totem4 = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							headerline1 = {
								order = 99,
								type = "description",
								name = L["Select a Type"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							autocast = {
								type = 'toggle',
								name = L["Autocast"],
								order = 100,
								desc = L["Adds an autocast style glow using class color"],
								disabled = function() return not E.db.ElvUI_EltreumUI.glow.enable or E.db.ElvUI_EltreumUI.glow.pixel or E.db.ElvUI_EltreumUI.glow.blizzard end,
								get = function() return E.db.ElvUI_EltreumUI.glow.autocast end,
								set = function(_, value) E.db.ElvUI_EltreumUI.glow.autocast = value end,
							},
							pixel = {
								type = 'toggle',
								name = L["Pixel"],
								order = 101,
								desc = L["Adds a pixel style glow using class color"],
								disabled = function() return not E.db.ElvUI_EltreumUI.glow.enable or E.db.ElvUI_EltreumUI.glow.autocast or E.db.ElvUI_EltreumUI.glow.blizzard end,
								get = function() return E.db.ElvUI_EltreumUI.glow.pixel end,
								set = function(_, value) E.db.ElvUI_EltreumUI.glow.pixel = value end,
							},
							blizzard = {
								type = 'toggle',
								name = 'Blizzard',
								order = 102,
								desc = L["Adds a Blizzard style glow using class color"],
								disabled = function() return not E.db.ElvUI_EltreumUI.glow.enable or E.db.ElvUI_EltreumUI.glow.autocast or E.db.ElvUI_EltreumUI.glow.pixel end,
								get = function() return E.db.ElvUI_EltreumUI.glow.blizzard end,
								set = function(_, value) E.db.ElvUI_EltreumUI.glow.blizzard = value end,
							},
							previewgap = {
								order = 103,
								type = "description",
								name = L["Preview the Glow"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							preview ={
								order = 104,
								type = "execute",
								name = PREVIEW,
								desc = L["Preview the Glow, you will need to toggle it off and on to update the glow"],
								width = 'full',
								func = function() ElvUI_EltreumUI:PreviewGlow() end,
							},
						},
					},
					glowcolor = {
						type = 'group',
						name = L["Glow Colors"],
						order = 2,
						disabled = function() return not E.db.ElvUI_EltreumUI.glow.enable and not E.db.ElvUI_EltreumUI.nameplates.widenameplate.npglow and not E.db.ElvUI_EltreumUI.glow.enablepet end,
						args = {
							headerline1 = {
								order = 1,
								type = "description",
								name = L["Action Bars"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							classcolorab = {
								type = 'toggle',
								name = L["Use Class Colors"],
								order = 3,
								desc = L["Toggle Class Colored glows"],
								disabled = function() return not E.db.ElvUI_EltreumUI.glow.enable end,
								get = function() return E.db.ElvUI_EltreumUI.glow.colorclass end,
								set = function(_, value) E.db.ElvUI_EltreumUI.glow.colorclass = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							colorab = {
								order = 4,
								type = 'color',
								name = L["Custom Color"],
								hasAlpha = false,
								disabled = function() return E.db.ElvUI_EltreumUI.glow.colorclass or not E.db.ElvUI_EltreumUI.glow.enable end,
								get = function()
									local glowcustomcolor = E.db.ElvUI_EltreumUI.glow.glowcustomcolor
									local d = P.ElvUI_EltreumUI.glow.glowcustomcolor
									return glowcustomcolor.r, glowcustomcolor.g, glowcustomcolor.b, glowcustomcolor.a, d.r, d.g, d.b, d.a
								end,
								set = function(_, r, g, b, a)
									local glowcustomcolor = E.db.ElvUI_EltreumUI.glow.glowcustomcolor
									glowcustomcolor.r, glowcustomcolor.g, glowcustomcolor.b = r, g, b E:StaticPopup_Show('CONFIG_RL')
								end,
							},
							headerline2 = {
								order = 5,
								type = "description",
								name = L["Pet Bar"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							classcolorpet = {
								type = 'toggle',
								name = L["Use Class Colors"],
								order = 6,
								desc = L["Toggle Class Colored glows"],
								disabled = function() return not E.db.ElvUI_EltreumUI.glow.enablepet end,
								get = function() return E.db.ElvUI_EltreumUI.glow.colorclasspet end,
								set = function(_, value) E.db.ElvUI_EltreumUI.glow.colorclasspet = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							colorpet = {
								order = 7,
								type = 'color',
								name = L["Custom Color"],
								hasAlpha = false,
								disabled = function() return E.db.ElvUI_EltreumUI.glow.colorclasspet or not E.db.ElvUI_EltreumUI.glow.enablepet end,
								get = function()
									local glowcustomcolorpet = E.db.ElvUI_EltreumUI.glow.glowcustomcolorpet
									local d = P.ElvUI_EltreumUI.glow.glowcustomcolorpet
									return glowcustomcolorpet.r, glowcustomcolorpet.g, glowcustomcolorpet.b, glowcustomcolorpet.a, d.r, d.g, d.b, d.a
								end,
								set = function(_, r, g, b, a)
									local glowcustomcolorpet = E.db.ElvUI_EltreumUI.glow.glowcustomcolorpet
									glowcustomcolorpet.r, glowcustomcolorpet.g, glowcustomcolorpet.b = r, g, b E:StaticPopup_Show('CONFIG_RL')
								end,
							},
							headerline3 = {
								order = 8,
								type = "description",
								name = L["Nameplate Buff/Debuff"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							classcolornp = {
								type = 'toggle',
								name = L["Use Class Colors"],
								order = 9,
								desc = L["Toggle Class Colored glows"],
								disabled = function() return not E.db.ElvUI_EltreumUI.nameplates.widenameplate.npglow end,
								get = function() return E.db.ElvUI_EltreumUI.glow.colorclassnp end,
								set = function(_, value) E.db.ElvUI_EltreumUI.glow.colorclassnp = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							colornp = {
								order = 10,
								type = 'color',
								name = L["Custom Color"],
								hasAlpha = false,
								disabled = function() return E.db.ElvUI_EltreumUI.glow.colorclassnp or not E.db.ElvUI_EltreumUI.nameplates.widenameplate.npglow end,
								get = function()
									local glowcustomcolornp = E.db.ElvUI_EltreumUI.glow.glowcustomcolornp
									local d = P.ElvUI_EltreumUI.glow.glowcustomcolornp
									return glowcustomcolornp.r, glowcustomcolornp.g, glowcustomcolornp.b, glowcustomcolornp.a, d.r, d.g, d.b, d.a
								end,
								set = function(_, r, g, b, a)
									local glowcustomcolornp = E.db.ElvUI_EltreumUI.glow.glowcustomcolornp
									glowcustomcolornp.r, glowcustomcolornp.g, glowcustomcolornp.b = r, g, b E:StaticPopup_Show('CONFIG_RL')
								end,
							},
							headertotem1 = {
								order = 11,
								type = "description",
								name = L["Shaman Fire Totem"],
								width = 'full',
								hidden = E.Retail,
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							classcolortotem1 = {
								type = 'toggle',
								name = L["Use Type Colors"],
								order = 12,
								desc = L["Toggle Totem to use it's own Type Colors"],
								hidden = E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.glow.enable or not E.db.ElvUI_EltreumUI.glow.enabletotem end,
								get = function() return E.db.ElvUI_EltreumUI.glow.totemtypecolor end,
								set = function(_, value) E.db.ElvUI_EltreumUI.glow.totemtypecolor = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							colortotem1 = {
								order = 13,
								type = 'color',
								name = L["Custom Color"],
								hidden = E.Retail,
								hasAlpha = false,
								disabled = function() return E.db.ElvUI_EltreumUI.glow.totemtypecolor or not E.db.ElvUI_EltreumUI.glow.enable or not E.db.ElvUI_EltreumUI.glow.enabletotem end,
								get = function()
									local glowtotem1customcolor = E.db.ElvUI_EltreumUI.glow.glowtotem1customcolor
									local d = P.ElvUI_EltreumUI.glow.glowtotem1customcolor
									return glowtotem1customcolor.r, glowtotem1customcolor.g, glowtotem1customcolor.b, glowtotem1customcolor.a, d.r, d.g, d.b, d.a
								end,
								set = function(_, r, g, b, a)
									local glowtotem1customcolor = E.db.ElvUI_EltreumUI.glow.glowtotem1customcolor
									glowtotem1customcolor.r, glowtotem1customcolor.g, glowtotem1customcolor.b = r, g, b E:StaticPopup_Show('CONFIG_RL')
								end,
							},
							headertotem2 = {
								order = 14,
								type = "description",
								name = L["Shaman Earth Totem"],
								width = 'full',
								hidden = E.Retail,
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							classcolortotem2 = {
								type = 'toggle',
								name = L["Use Type Colors"],
								order = 15,
								desc = L["Toggle Totem to use it's own Type Colors"],
								hidden = E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.glow.enable or not E.db.ElvUI_EltreumUI.glow.enabletotem end,
								get = function() return E.db.ElvUI_EltreumUI.glow.totemtypecolor end,
								set = function(_, value) E.db.ElvUI_EltreumUI.glow.totemtypecolor = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							colortotem2 = {
								order = 16,
								type = 'color',
								name = L["Custom Color"],
								hasAlpha = false,
								hidden = E.Retail,
								disabled = function() return E.db.ElvUI_EltreumUI.glow.totemtypecolor or not E.db.ElvUI_EltreumUI.glow.enable or not E.db.ElvUI_EltreumUI.glow.enabletotem end,
								get = function()
									local glowtotem2customcolor = E.db.ElvUI_EltreumUI.glow.glowtotem2customcolor
									local d = P.ElvUI_EltreumUI.glow.glowtotem2customcolor
									return glowtotem2customcolor.r, glowtotem2customcolor.g, glowtotem2customcolor.b, glowtotem2customcolor.a, d.r, d.g, d.b, d.a
								end,
								set = function(_, r, g, b, a)
									local glowtotem2customcolor = E.db.ElvUI_EltreumUI.glow.glowtotem2customcolor
									glowtotem2customcolor.r, glowtotem2customcolor.g, glowtotem2customcolor.b = r, g, b E:StaticPopup_Show('CONFIG_RL')
								end,
							},
							headertotem3 = {
								order = 17,
								type = "description",
								name = L["Shaman Water Totem"],
								width = 'full',
								hidden = E.Retail,
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							classcolortotem3 = {
								type = 'toggle',
								name = L["Use Type Colors"],
								order = 18,
								desc = L["Toggle Totem to use it's own Type Colors"],
								hidden = E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.glow.enable or not E.db.ElvUI_EltreumUI.glow.enabletotem end,
								get = function() return E.db.ElvUI_EltreumUI.glow.totemtypecolor end,
								set = function(_, value) E.db.ElvUI_EltreumUI.glow.totemtypecolor = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							colortotem3 = {
								order = 19,
								type = 'color',
								name = L["Custom Color"],
								hasAlpha = false,
								hidden = E.Retail,
								disabled = function() return E.db.ElvUI_EltreumUI.glow.totemtypecolor or not E.db.ElvUI_EltreumUI.glow.enable or not E.db.ElvUI_EltreumUI.glow.enabletotem end,
								get = function()
									local glowtotem3customcolor = E.db.ElvUI_EltreumUI.glow.glowtotem3customcolor
									local d = P.ElvUI_EltreumUI.glow.glowtotem3customcolor
									return glowtotem3customcolor.r, glowtotem3customcolor.g, glowtotem3customcolor.b, glowtotem3customcolor.a, d.r, d.g, d.b, d.a
								end,
								set = function(_, r, g, b, a)
									local glowtotem3customcolor = E.db.ElvUI_EltreumUI.glow.glowtotem3customcolor
									glowtotem3customcolor.r, glowtotem3customcolor.g, glowtotem3customcolor.b = r, g, b E:StaticPopup_Show('CONFIG_RL')
								end,
							},
							headertotem4 = {
								order = 20,
								type = "description",
								name = L["Shaman Air Totem"],
								width = 'full',
								hidden = E.Retail,
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							classcolortotem4 = {
								type = 'toggle',
								name = L["Use Type Colors"],
								order = 21,
								desc = L["Toggle Totem to use it's own Type Colors"],
								hidden = E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.glow.enable or not E.db.ElvUI_EltreumUI.glow.enabletotem end,
								get = function() return E.db.ElvUI_EltreumUI.glow.totemtypecolor end,
								set = function(_, value) E.db.ElvUI_EltreumUI.glow.totemtypecolor = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							colortotem4 = {
								order = 22,
								type = 'color',
								name = L["Custom Color"],
								hasAlpha = false,
								hidden = E.Retail,
								disabled = function() return E.db.ElvUI_EltreumUI.glow.totemtypecolor or not E.db.ElvUI_EltreumUI.glow.enable or not E.db.ElvUI_EltreumUI.glow.enabletotem end,
								get = function()
									local glowtotem4customcolor = E.db.ElvUI_EltreumUI.glow.glowtotem4customcolor
									local d = P.ElvUI_EltreumUI.glow.glowtotem4customcolor
									return glowtotem4customcolor.r, glowtotem4customcolor.g, glowtotem4customcolor.b, glowtotem4customcolor.a, d.r, d.g, d.b, d.a
								end,
								set = function(_, r, g, b, a)
									local glowtotem4customcolor = E.db.ElvUI_EltreumUI.glow.glowtotem4customcolor
									glowtotem4customcolor.r, glowtotem4customcolor.g, glowtotem4customcolor.b = r, g, b E:StaticPopup_Show('CONFIG_RL')
								end,
							},
						},
					},
					pixelglow = {
						type = 'group',
						name = L["Pixel Glow"],
						order = 3,
						disabled = function() return not E.db.ElvUI_EltreumUI.glow.enable and not E.db.ElvUI_EltreumUI.nameplates.widenameplate.npglow and not E.db.ElvUI_EltreumUI.glow.enablepet end,
						args = {
							headerline1 = {
								order = 1,
								type = "description",
								name = "",
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							borderpixel = {
								type = 'toggle',
								name = L["Enable Pixel Border"],
								desc = L["Enable a border for the Pixel Glow"],
								order = 83,
								width = "full",
								get = function() return E.db.ElvUI_EltreumUI.glow.borderpixel end,
								set = function(_, value) E.db.ElvUI_EltreumUI.glow.borderpixel = value end,
							},
							addagapherepixel2 = {
								order = 85,
								type = "description",
								name = "",
								width = "full",
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							numberpixel = {
								type = 'range',
								name = L["Number of Pixels (Default is 9)"],
								desc = L["Set the number of pixels in pixel glow"],
								order = 85,
								min = 1,
								max = 20,
								step = 1,
								width = "full",
								get = function() return E.db.ElvUI_EltreumUI.glow.numberpixel end,
								set = function(_, value) E.db.ElvUI_EltreumUI.glow.numberpixel = value end,
							},
							addagapherepixel3 = {
								order = 86,
								type = "description",
								width = "full",
								name = "",
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							frequencypixel = {
								type = 'range',
								name = L["Pixel Frequency (Default is 1)"],
								desc = L["Set the frequency pixel glow"],
								order = 86,
								min = -10,
								max = 10,
								step = 0.01,
								width = "full",
								get = function() return E.db.ElvUI_EltreumUI.glow.frequencypixel end,
								set = function(_, value) E.db.ElvUI_EltreumUI.glow.frequencypixel = value end,
							},
							addagapherepixel4 = {
								order = 87,
								type = "description",
								width = "full",
								name = "",
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							lengthpixel = {
								type = 'range',
								name = L["Pixel Length (Default is 3)"],
								desc = L["Set the length of pixels"],
								order = 87,
								min = 1,
								max = 20,
								step = 1,
								width = "full",
								get = function() return E.db.ElvUI_EltreumUI.glow.lengthpixel end,
								set = function(_, value) E.db.ElvUI_EltreumUI.glow.lengthpixel = value end,
							},
							addagapherepixel5 = {
								order = 88,
								type = "description",
								width = "full",
								name = "",
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							thicknesspixel = {
								type = 'range',
								name = L["Pixel Thickness (Default is 5)"],
								desc = L["Set the thickness of pixels"],
								order = 88,
								min = 1,
								max = 10,
								step = 1,
								width = "full",
								get = function() return E.db.ElvUI_EltreumUI.glow.thicknesspixel end,
								set = function(_, value) E.db.ElvUI_EltreumUI.glow.thicknesspixel = value end,
							},
							addagapherepixel6 = {
								order = 89,
								type = "description",
								width = "full",
								name = "",
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							pixelxOffset = {
								type = 'range',
								name = L["Pixel Horizontal Offset (Default is 5)"],
								desc = L["Set the horizontal offset of pixels"],
								order = 89,
								min = 1,
								max = 10,
								step = 1,
								width = "full",
								get = function() return E.db.ElvUI_EltreumUI.glow.pixelxOffset end,
								set = function(_, value) E.db.ElvUI_EltreumUI.glow.pixelxOffset = value end,
							},
							addagapherepixel7 = {
								order = 90,
								type = "description",
								width = "full",
								name = "",
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							pixelyOffset = {
								type = 'range',
								name = L["Pixel Vertical Offset (Default is 5)"],
								desc = L["Set the vertical offset of pixels"],
								order = 90,
								min = 1,
								max = 10,
								step = 1,
								width = "full",
								get = function() return E.db.ElvUI_EltreumUI.glow.pixelyOffset end,
								set = function(_, value) E.db.ElvUI_EltreumUI.glow.pixelyOffset = value end,
							},
						}
					},
					autocast = {
						type = 'group',
						name = L["Autocast Glow"],
						order = 3,
						disabled = function() return not E.db.ElvUI_EltreumUI.glow.enable and not E.db.ElvUI_EltreumUI.nameplates.widenameplate.npglow and not E.db.ElvUI_EltreumUI.glow.enablepet end,
						args = {
							headerline1 = {
								order = 1,
								type = "description",
								name = L["Autocast Glow"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							numberauto = {
								type = 'range',
								name = L["Autocast Particle Groups (Default is 8)"],
								desc = L["Set the number of groups for autocast, for each group you get 4 particles"],
								order = 92,
								min = 1,
								max = 10,
								step = 1,
								width = "full",
								get = function() return E.db.ElvUI_EltreumUI.glow.numberauto end,
								set = function(_, value) E.db.ElvUI_EltreumUI.glow.numberauto = value end,
							},
							headerline2 = {
								order = 93,
								type = "description",
								name = "",
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							frequencyauto = {
								type = 'range',
								name = L["Autocast Frequency (Default is 0.8)"],
								desc = L["Speed for Autocast, set to negative to inverse direction of rotation"],
								order = 93,
								min = -3,
								max = 3,
								step = 0.1,
								width = "full",
								get = function() return E.db.ElvUI_EltreumUI.glow.frequencyauto end,
								set = function(_, value) E.db.ElvUI_EltreumUI.glow.frequencyauto = value end,
							},
							headerline3 = {
								order = 94,
								type = "description",
								name = "",
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							autoscale = {
								type = 'range',
								name = L["Autocast Scale (Default is 2)"],
								desc = L["Change the size of Autocast"],
								order = 94,
								min = -3,
								max = 3,
								step = 0.1,
								width = "full",
								get = function() return E.db.ElvUI_EltreumUI.glow.autoscale end,
								set = function(_, value) E.db.ElvUI_EltreumUI.glow.autoscale = value end,
							},
							headerline4 = {
								order = 95,
								type = "description",
								name = "",
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							autoxOffset = {
								type = 'range',
								name = L["Autocast Horizontal Offset (Default is 5)"],
								desc = L["Set the horizontal offset of autocast"],
								order = 96,
								min = 1,
								max = 10,
								step = 1,
								width = "full",
								get = function() return E.db.ElvUI_EltreumUI.glow.autoxOffset end,
								set = function(_, value) E.db.ElvUI_EltreumUI.glow.autoxOffset = value end,
							},
							headerline5 = {
								order = 97,
								type = "description",
								name = "",
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							autoyOffset = {
								type = 'range',
								name = L["Autocast Vertical Offset (Default is 5)"],
								desc = L["Set the vertical offset of autocast"],
								order = 97,
								min = 1,
								max = 10,
								step = 1,
								width = "full",
								get = function() return E.db.ElvUI_EltreumUI.glow.autoyOffset end,
								set = function(_, value) E.db.ElvUI_EltreumUI.glow.autoyOffset = value end,
							},
						}
					},
					blizz = {
						type = 'group',
						name = L["Blizzard Glow"],
						order = 3,
						disabled = function() return not E.db.ElvUI_EltreumUI.glow.enable and not E.db.ElvUI_EltreumUI.nameplates.widenameplate.npglow and not E.db.ElvUI_EltreumUI.glow.enablepet end,
						args = {
							headerline2 = {
								order = 93,
								type = "description",
								name = L["Blizzard Glow"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							frequencyblizz = {
								type = 'range',
								name = L["Blizzard Frequency (Default is 0.5)"],
								desc = L["Speed for Blizzard glow"],
								order = 99,
								min = 0.1,
								max = 3,
								step = 0.1,
								width = "full",
								get = function() return E.db.ElvUI_EltreumUI.glow.frequencyblizz end,
								set = function(_, value) E.db.ElvUI_EltreumUI.glow.frequencyblizz = value end,
							},
						}
					},
				},
			},
			cvars = {
				order = 85,
				type = 'group',
				name = L["CVars"],
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\cvar',
				args = {
					header = {
						order = 1,
						type = "description",
						name = L["Customize CVars"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					cameraFOV = {
						type = 'range',
						name = L["Camera Field of View"],
						desc = L["This allows you to zoom out further with the camera to increase the field of view."],
						order = 2,
						min = 50,
						max = 90,
						step = 1,
						width = "full",
						hidden = not E.Retail and not E.Wrath,
						get = function() return E.db.ElvUI_EltreumUI.cvars.cameraFOV end,
						set = function(_, value) E.db.ElvUI_EltreumUI.cvars.cameraFOV = value SetCVar('camerafov', value) end,
					},
					cameraDistanceMaxZoomFactor = {
						type = 'range',
						name = L["Camera Distance Max Zoom Factor"],
						desc = L["Maximum Camera Zoom Out"],
						order = 3,
						min = 1,
						max = function()
							if not E.Wrath then
								return 2.6
							else
								return 3.4
							end
						end,
						step = 0.1,
						width = "full",
						get = function() return E.db.ElvUI_EltreumUI.cvars.cameraDistanceMaxZoomFactor end,
						set = function(_, value) E.db.ElvUI_EltreumUI.cvars.cameraDistanceMaxZoomFactor = value SetCVar('cameraDistanceMaxZoomFactor', value) end,
					},
					header2 = {
						order = 4,
						type = "description",
						name = "",
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
					header3 = {
						order = 6,
						type = "description",
						name = L["Nameplate Target Radial Position"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					nameplateTargetRadialPosition = {
						order = 7,
						type = 'select',
						name = " ",
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
					header4 = {
						order = 197,
						type = "description",
						name = L["Setup CVars"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					setup = {
						order = 198,
						type = 'group',
						inline = true,
						name = "",
						args = {
							generalVars = {
								order = 1,
								type = 'execute',
								name = L["General CVars"],
								width = 'full',
								func = function() ElvUI_EltreumUI:SetupCVars() ElvUI_EltreumUI:NameplateCVars() end,
								confirm = true,
							},
						},
					},
					generalDesc = {
						order = 199,
						type = 'group',
						inline = true,
						name = L["It will set these CVars:"],
						args = {
							cvars = {
								order = 1,
								type = 'description',
								fontSize = 'medium',
								name = '- autoLootDefault 1\n- ShowClassColorInFriendlyNameplate 1\n- removeChatDelay 1\n- autoQuestWatch 1\n- cameraDistanceMaxZoomFactor 2.6\n- nameplateLargerScale 1.2\n- nameplateMaxDistance 60\n- nameplateMinAlpha 1\n- nameplateMinScale 1\n- nameplateMotion 1\n- nameplateOccludedAlphaMult 0\n- nameplateOverlapH 0.8\n- nameplateOverlapV 1.1\n- nameplateSelectedScale 1\n- nameplateSelfAlpha 1\n- nameplateShowFriendlyMinions 0\n- nameplateOtherBottomInset 0.02\n- nameplateOtherTopInset 0.1\n- nameplateTargetRadialPosition 1\n- nameplateTargetBehindMaxDistance 40\n- nameplateShowEnemies 1\n- nameplateShowFriends 1\n- UnitNameEnemyGuardianName 0\n- UnitNameEnemyMinionName 0\n- UnitNameEnemyPetName 0\n- UnitNameEnemyPlayerName 1\n- UnitNameEnemyTotemName 1\n- UnitNameFriendlyPetName 0\n- UnitNameNPC 1\n- statusTextDisplay BOTH\n- screenshotQuality 10\n- chatMouseScroll 1\n- wholeChatWindowClickable 0\n- showTutorials 0\n- UberTooltips 1\n- alwaysCompareItems 0\n- allowCompareWithToggle 1\n- instantQuestText 1\n- autoLootRate 1\n- showQuestTrackingTooltips 1\n- lootUnderMouse 1\n- equipmentManager 1\n- previewTalents 1\n- WorldTextMinSize 6',
							},
						},
					},
				},
			},
			gradient = {
				type = 'group',
				name = L["Gradient Colors"],
				order = 85,
				childGroups = "tab",
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\gradient',
				args = {
					class = {
						order = 1,
						type = 'group',
						name = L["Custom Class Colors"],
						args = {
							headernp = {
								order = 1,
								type = "description",
								name = "",
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							enablecustomcolornp = {
								order = 2,
								type = 'toggle',
								name = L["Nameplate Custom Color"],
								desc = L["Enable Custom Colors for Nameplates"],
								width = 'full',
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor = value ElvUI_EltreumUI:GradientColorTableUpdate() end,
							},
							headeruf = {
								order = 3,
								type = "description",
								name = "",
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							enablecustomcoloruf = {
								order = 4,
								type = 'toggle',
								name = L["Unitframe Custom Color"],
								desc = L["Enable Custom Colors for Unitframes"],
								width = 'full',
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor = value ElvUI_EltreumUI:GradientColorTableUpdate() end,
							},
							header2 = {
								order = 64,
								type = "description",
								name = L["Death Knight"],
								width = 'full',
								hidden = not E.Retail and not E.Wrath,
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							gradientdeathknight1 = {
								order = 65,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								hidden = not E.Retail and not E.Wrath,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.deathknightcustomcolorR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.deathknightcustomcolorG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.deathknightcustomcolorB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.deathknightcustomcolorR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.deathknightcustomcolorG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.deathknightcustomcolorB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.deathknightcustomcolorR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.deathknightcustomcolorG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.deathknightcustomcolorB1 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							gradientdeathknight2 = {
								order = 66,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								hidden = not E.Retail and not E.Wrath,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.deathknightcustomcolorR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.deathknightcustomcolorG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.deathknightcustomcolorB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.deathknightcustomcolorR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.deathknightcustomcolorG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.deathknightcustomcolorB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.deathknightcustomcolorR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.deathknightcustomcolorG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.deathknightcustomcolorB2 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							header3 = {
								order = 67,
								type = "description",
								name = L["Demon Hunter"],
								width = 'full',
								hidden = not E.Retail,
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							gradientdemonhunter1 = {
								order = 68,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								hidden = not E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.demonhuntercustomcolorR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.demonhuntercustomcolorG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.demonhuntercustomcolorB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.demonhuntercustomcolorR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.demonhuntercustomcolorG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.demonhuntercustomcolorB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.demonhuntercustomcolorR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.demonhuntercustomcolorG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.demonhuntercustomcolorB1 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							gradientdemonhunter2 = {
								order = 69,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								hidden = not E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.demonhuntercustomcolorR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.demonhuntercustomcolorG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.demonhuntercustomcolorB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.demonhuntercustomcolorR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.demonhuntercustomcolorG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.demonhuntercustomcolorB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.demonhuntercustomcolorR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.demonhuntercustomcolorG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.demonhuntercustomcolorB2 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							header4 = {
								order = 70,
								type = "description",
								name = L["Druid"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							gradientdruid1 = {
								order = 71,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.druidcustomcolorR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.druidcustomcolorG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.druidcustomcolorB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.druidcustomcolorR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.druidcustomcolorG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.druidcustomcolorB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.druidcustomcolorR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.druidcustomcolorG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.druidcustomcolorB1 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							gradientdruid2 = {
								order = 72,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.druidcustomcolorR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.druidcustomcolorG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.druidcustomcolorB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.druidcustomcolorR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.druidcustomcolorG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.druidcustomcolorB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.druidcustomcolorR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.druidcustomcolorG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.druidcustomcolorB2 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							header3evoker = {
								order = 73,
								type = "description",
								name = L["Evoker"],
								width = 'full',
								hidden = not E.Retail,
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							gradientevoker1 = {
								order = 74,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								hidden = not E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.evokercustomcolorR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.evokercustomcolorG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.evokercustomcolorB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.evokercustomcolorR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.evokercustomcolorG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.evokercustomcolorB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.evokercustomcolorR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.evokercustomcolorG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.evokercustomcolorB1 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							gradientevoker2 = {
								order = 75,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								hidden = not E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.evokercustomcolorR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.evokercustomcolorG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.evokercustomcolorB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.evokercustomcolorR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.evokercustomcolorG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.evokercustomcolorB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.evokercustomcolorR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.evokercustomcolorG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.evokercustomcolorB2 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							header5 = {
								order = 76,
								type = "description",
								name = L["Hunter"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							gradienthunter1 = {
								order = 77,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.huntercustomcolorR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.huntercustomcolorG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.huntercustomcolorB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.huntercustomcolorR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.huntercustomcolorG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.huntercustomcolorB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.huntercustomcolorR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.huntercustomcolorG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.huntercustomcolorB1 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							gradienthunter2 = {
								order = 78,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.huntercustomcolorR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.huntercustomcolorG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.huntercustomcolorB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.huntercustomcolorR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.huntercustomcolorG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.huntercustomcolorB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.huntercustomcolorR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.huntercustomcolorG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.huntercustomcolorB2 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							header6 = {
								order = 79,
								type = "description",
								name = L["Mage"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							gradientmage1 = {
								order = 80,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.magecustomcolorR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.magecustomcolorG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.magecustomcolorB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.magecustomcolorR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.magecustomcolorG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.magecustomcolorB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.magecustomcolorR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.magecustomcolorG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.magecustomcolorB1 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							gradientmage2 = {
								order = 81,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.magecustomcolorR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.magecustomcolorG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.magecustomcolorB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.magecustomcolorR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.magecustomcolorG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.magecustomcolorB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.magecustomcolorR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.magecustomcolorG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.magecustomcolorB2 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							header7 = {
								order = 82,
								type = "description",
								name = L["Monk"],
								width = 'full',
								hidden = not E.Retail,
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							gradientmonk1 = {
								order = 83,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								hidden = not E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.monkcustomcolorR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.monkcustomcolorG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.monkcustomcolorB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.monkcustomcolorR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.monkcustomcolorG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.monkcustomcolorB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.monkcustomcolorR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.monkcustomcolorG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.monkcustomcolorB1 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							gradientmonk2 = {
								order = 84,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								hidden = not E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.monkcustomcolorR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.monkcustomcolorG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.monkcustomcolorB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.monkcustomcolorR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.monkcustomcolorG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.monkcustomcolorB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.monkcustomcolorR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.monkcustomcolorG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.monkcustomcolorB2 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							header8 = {
								order = 85,
								type = "description",
								name = L["Paladin"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							gradientpaladin1 = {
								order = 86,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.paladincustomcolorR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.paladincustomcolorG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.paladincustomcolorB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.paladincustomcolorR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.paladincustomcolorG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.paladincustomcolorB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.paladincustomcolorR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.paladincustomcolorG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.paladincustomcolorB1 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							gradientpaladin2 = {
								order = 87,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.paladincustomcolorR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.paladincustomcolorG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.paladincustomcolorB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.paladincustomcolorR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.paladincustomcolorG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.paladincustomcolorB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.paladincustomcolorR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.paladincustomcolorG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.paladincustomcolorB2 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							header9 = {
								order = 88,
								type = "description",
								name = L["Priest"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							gradientpriest1 = {
								order = 89,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.priestcustomcolorR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.priestcustomcolorG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.priestcustomcolorB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.priestcustomcolorR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.priestcustomcolorG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.priestcustomcolorB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.priestcustomcolorR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.priestcustomcolorG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.priestcustomcolorB1 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							gradientpriest2 = {
								order = 90,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.priestcustomcolorR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.priestcustomcolorG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.priestcustomcolorB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.priestcustomcolorR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.priestcustomcolorG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.priestcustomcolorB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.priestcustomcolorR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.priestcustomcolorG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.priestcustomcolorB2 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							header10 = {
								order = 91,
								type = "description",
								name = L["Rogue"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							gradientrogue1 = {
								order = 92,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.roguecustomcolorR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.roguecustomcolorG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.roguecustomcolorB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.roguecustomcolorR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.roguecustomcolorG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.roguecustomcolorB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.roguecustomcolorR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.roguecustomcolorG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.roguecustomcolorB1 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							gradientrogue2 = {
								order = 93,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.roguecustomcolorR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.roguecustomcolorG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.roguecustomcolorB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.roguecustomcolorR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.roguecustomcolorG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.roguecustomcolorB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.roguecustomcolorR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.roguecustomcolorG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.roguecustomcolorB2 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							header11 = {
								order = 94,
								type = "description",
								name = L["Shaman"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							gradientshaman1 = {
								order = 95,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.shamancustomcolorR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.shamancustomcolorG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.shamancustomcolorB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.shamancustomcolorR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.shamancustomcolorG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.shamancustomcolorB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.shamancustomcolorR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.shamancustomcolorG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.shamancustomcolorB1 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							gradientshaman2 = {
								order = 96,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.shamancustomcolorR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.shamancustomcolorG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.shamancustomcolorB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.shamancustomcolorR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.shamancustomcolorG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.shamancustomcolorB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.shamancustomcolorR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.shamancustomcolorG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.shamancustomcolorB2 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							header12 = {
								order = 97,
								type = "description",
								name = L["Warlock"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							gradientwarlock1 = {
								order = 98,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.warlockcustomcolorR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.warlockcustomcolorG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.warlockcustomcolorB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.warlockcustomcolorR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.warlockcustomcolorG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.warlockcustomcolorB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.warlockcustomcolorR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.warlockcustomcolorG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.warlockcustomcolorB1 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							gradientwarlock2 = {
								order = 99,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.warlockcustomcolorR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.warlockcustomcolorG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.warlockcustomcolorB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.warlockcustomcolorR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.warlockcustomcolorG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.warlockcustomcolorB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.warlockcustomcolorR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.warlockcustomcolorG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.warlockcustomcolorB2 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							header13 = {
								order = 100,
								type = "description",
								name = L["Warrior"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							gradientwarrior1 = {
								order = 101,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.warriorcustomcolorR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.warriorcustomcolorG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.warriorcustomcolorB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.warriorcustomcolorR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.warriorcustomcolorG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.warriorcustomcolorB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.warriorcustomcolorR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.warriorcustomcolorG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.warriorcustomcolorB1 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							gradientwarrior2 = {
								order = 102,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.warriorcustomcolorR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.warriorcustomcolorG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.warriorcustomcolorB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.warriorcustomcolorR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.warriorcustomcolorG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.warriorcustomcolorB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.warriorcustomcolorR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.warriorcustomcolorG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.warriorcustomcolorB2 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							header14 = {
								order = 103,
								type = "description",
								name = L["Friendly NPC"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							friendlynpc1 = {
								order = 104,
								type = 'color',
								name = L["Color 1"],
								desc = L["NPCs use Target Castbar colors not NPC colors for their castbars"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.npcfriendlyR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.npcfriendlyG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.npcfriendlyB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcfriendlyR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcfriendlyG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcfriendlyB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcfriendlyR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcfriendlyG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcfriendlyB1 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							friendlynpc2 = {
								order = 105,
								type = 'color',
								name = L["Color 2"],
								desc = L["NPCs use Target Castbar colors not NPC colors for their castbars"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.npcfriendlyR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.npcfriendlyG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.npcfriendlyB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcfriendlyR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcfriendlyG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcfriendlyB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcfriendlyR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcfriendlyG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcfriendlyB2 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							header15 = {
								order = 106,
								type = "description",
								name = L["Neutral NPC"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							neutralnpc1 = {
								order = 107,
								type = 'color',
								name = L["Color 1"],
								desc = L["NPCs use Target Castbar colors not NPC colors for their castbars"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.npcneutralR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.npcneutralG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.npcneutralB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcneutralR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcneutralG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcneutralB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcneutralR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcneutralG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcneutralB1 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							neutralnpc2 = {
								order = 108,
								type = 'color',
								name = L["Color 2"],
								desc = L["NPCs use Target Castbar colors not NPC colors for their castbars"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.npcneutralR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.npcneutralG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.npcneutralB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcneutralR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcneutralG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcneutralB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcneutralR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcneutralG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcneutralB2 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							header16 = {
								order = 109,
								type = "description",
								name = L["Unfriendly NPC"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							unfriendlynpc1 = {
								order = 110,
								type = 'color',
								name = L["Color 1"],
								desc = L["NPCs use Target Castbar colors not NPC colors for their castbars"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.npcunfriendlyR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.npcunfriendlyG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.npcunfriendlyB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcunfriendlyR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcunfriendlyG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcunfriendlyB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcunfriendlyR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcunfriendlyG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcunfriendlyB1 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							unfriendlynpc2 = {
								order = 111,
								type = 'color',
								name = L["Color 2"],
								desc = L["NPCs use Target Castbar colors not NPC colors for their castbars"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.npcunfriendlyR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.npcunfriendlyG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.npcunfriendlyB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcunfriendlyR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcunfriendlyG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcunfriendlyB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcunfriendlyR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcunfriendlyG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcunfriendlyB2 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							header17 = {
								order = 112,
								type = "description",
								name = L["Hostile NPC"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							hostilenpc1 = {
								order = 113,
								type = 'color',
								name = L["Color 1"],
								desc = L["NPCs use Target Castbar colors not NPC colors for their castbars"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.npchostileR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.npchostileG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.npchostileB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.npchostileR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.npchostileG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.npchostileB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.npchostileR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.npchostileG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.npchostileB1 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							hostilenpc2 = {
								order = 114,
								type = 'color',
								name = L["Color 2"],
								desc = L["NPCs use Target Castbar colors not NPC colors for their castbars"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.npchostileR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.npchostileG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.npchostileB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.npchostileR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.npchostileG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.npchostileB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.npchostileR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.npchostileG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.npchostileB2 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							header17tapped = {
								order = 115,
								type = "description",
								name = L["Tapped NPC"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							tappednpc1 = {
								order = 116,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.tappedR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.tappedG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.tappedB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.tappedR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.tappedG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.tappedB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.tappedR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.tappedG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.tappedB1 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							tappednpc2 = {
								order = 117,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.tappedR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.tappedG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.tappedB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.tappedR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.tappedG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.tappedB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.tappedR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.tappedG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.tappedB2 = r, g, b
									ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
						},
					},
					unitframe = {
						order = 2,
						type = 'group',
						name = L["Unitframe Colors"],
						args = {
							headercastbar = {
								order = 4,
								type = "description",
								name = L["Player Castbar"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							gradientcast1 = {
								order = 5,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								disabled = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorplayercastbar or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableplayercastbar end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							gradientcast2 = {
								order = 6,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								disabled = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorplayercastbar or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableplayercastbar end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							checkelvuiclasscolorcastbar = {
								order = 7,
								type = 'toggle',
								name = L["Class Colors"],
								desc = L["Use Class Colors instead of Custom Colors"],
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableplayercastbar end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorplayercastbar end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorplayercastbar = value end,
							},
							headercastbarcantinterruptplayer = {
								order = 7,
								type = "description",
								name = L["Player Castbar (Non Interruptible)"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							gradientcast1cantinterruptplayer = {
								order = 8,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableplayercastbarnoninterruptible end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1noninterruptible
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1noninterruptible
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1noninterruptible
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1noninterruptiblecustom, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1noninterruptiblecustom = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							gradientcast2cantinterruptplayer = {
								order = 9,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableplayercastbarnoninterruptible end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2noninterruptible
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2noninterruptible
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2noninterruptible
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2noninterruptiblecustom, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2noninterruptiblecustom = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							headercastbarinterruptedplayer = {
								order = 10,
								type = "description",
								name = L["Player Castbar (Interrupted)"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							gradientcast1interruptedplayer = {
								order = 11,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableplayercastbarinterrupted end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1interrupted
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1interrupted
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1interrupted
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1interruptedcustom, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1interruptedcustom = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							gradientcast2interruptedplayer = {
								order = 12,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableplayercastbarinterrupted end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2interrupted
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2interrupted
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2interrupted
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2interruptedcustom, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2interruptedcustom = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							headercastbartarget = {
								order = 13,
								type = "description",
								name = L["Target Castbar"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							gradientcast1target = {
								order = 14,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enabletargetcastbar end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							gradientcast2target = {
								order = 15,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enabletargetcastbar end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							checkelvuiclasscolorcastbartarget = {
								order = 16,
								type = 'toggle',
								name = L["Class Colors"],
								desc = L["Use Class Colors instead of Custom Colors"],
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enabletargetcastbar end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar = value end,
							},
							headercastbarnoninterruptibletargetcustom = {
								order = 16,
								type = "description",
								name = L["Target Castbar (Non Interruptible)"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							gradientcast1noninterruptibletargetcustom = {
								order = 17,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enabletargetcastbarnoninterruptible end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1noninterruptible
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1noninterruptible
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1noninterruptible
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1noninterruptiblecustom, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1noninterruptiblecustom = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							gradientcast2noninterruptibletargetcustom = {
								order = 18,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enabletargetcastbarnoninterruptible end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2noninterruptible
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2noninterruptible
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2noninterruptible
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2noninterruptiblecustom, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2noninterruptiblecustom = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							headercastbarinterruptedtarget = {
								order = 19,
								type = "description",
								name = L["Target Castbar (Interrupted)"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							gradientcast1interruptedtarget = {
								order = 20,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enabletargetcastbarinterrupted end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interrupted
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interrupted
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interrupted
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptedcustom, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptedcustom = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							gradientcast2interruptedtarget = {
								order = 21,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enabletargetcastbarinterrupted end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interrupted
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interrupted
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interrupted
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptedcustom, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptedcustom = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							npcreactioncastbar = {
								order = 22,
								type = "description",
								name = L["NPC Castbars (Interruptible)"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							npcgradientinterruptible1 = {
								order = 23,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable or E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarreactioninterruptable end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptable
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptable
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptable
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptablecustom, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptablecustom = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							npcgradientinterruptible2 = {
								order = 24,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable or E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarreactioninterruptable end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptable
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptable
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptable
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptablecustom, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptablecustom = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							npcreactioncastbarenable = {
								order = 25,
								type = 'toggle',
								name = L["Color by Reaction"],
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enabletargetcastbar end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarreactioninterruptable end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarreactioninterruptable = value end,
							},
						},
					},
					nameplate = {
						order = 3,
						type = 'group',
						name = L["Nameplate Colors"],
						args = {
							headergoodthreat = {
								order = 10,
								type = "description",
								name = L["Good Threat"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							goodthreat1 = {
								order = 11,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.goodthreatR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.goodthreatG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.goodthreatB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreatR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreatG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreatB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreatR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreatG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreatB1 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							goodthreat2 = {
								order = 12,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.goodthreatR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.goodthreatG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.goodthreatB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreatR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreatG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreatB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreatR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreatG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreatB2 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							headerbadthreat = {
								order = 13,
								type = "description",
								name = L["Bad Threat"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							badthreat1 = {
								order = 14,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.badthreatR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.badthreatG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.badthreatB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreatR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreatG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreatB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreatR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreatG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreatB1 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							badthreat2 = {
								order = 15,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.badthreatR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.badthreatG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.badthreatB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreatR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreatG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreatB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreatR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreatG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreatB2 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							headergoodthreattransition = {
								order = 16,
								type = "description",
								name = L["Good Threat Transition"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							goodthreattransition1 = {
								order = 17,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionB1 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							goodthreattransition2 = {
								order = 18,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionB2 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							headerbadthreattransition = {
								order = 19,
								type = "description",
								name = L["Bad Threat Transition"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							badthreattransition1 = {
								order = 20,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionB1 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							badthreattransition2 = {
								order = 21,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionB2 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							headerofftank = {
								order = 22,
								type = "description",
								name = L["Off Tank"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							offtank1 = {
								order = 23,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.offtankR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.offtankG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.offtankB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.offtankR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.offtankG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.offtankB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.offtankR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.offtankG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.offtankB1 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							offtank2 = {
								order = 24,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.offtankR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.offtankG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.offtankB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.offtankR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.offtankG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.offtankB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.offtankR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.offtankG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.offtankB2 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							headerbadthreattransitionofftank = {
								order = 25,
								type = "description",
								name = L["Off Tank Bad Threat Transition"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							badthreattransition1offtank = {
								order = 26,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionofftankR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionofftankG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionofftankB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionofftankR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionofftankG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionofftankB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionofftankR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionofftankG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionofftankB1 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							badthreattransition2offtank = {
								order = 27,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionofftankR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionofftankG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionofftankB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionofftankR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionofftankG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionofftankB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionofftankR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionofftankG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionofftankB2 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							headergoodthreattransitionofftank = {
								order = 28,
								type = "description",
								name = L["Off Tank Good Threat Transition"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							goodthreattransition1offtank = {
								order = 29,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionofftankR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionofftankG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionofftankB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionofftankR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionofftankG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionofftankB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionofftankR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionofftankG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionofftankB1 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							goodthreattransition2offtank = {
								order = 30,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionofftankR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionofftankG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionofftankB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionofftankR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionofftankG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionofftankB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionofftankR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionofftankG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionofftankB2 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							stylefilter = {
								order = 31,
								type = "description",
								name = L["Style Filter"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							stylefilterred = {
								type = 'range',
								name = L["Red"],
								order = 65,
								min = -1,
								max = 1,
								step = 0.01,
								desc = L["This is how much the color will gain or lose this value"],
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.stylefilterr end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.stylefilterr = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							stylefiltergreen = {
								type = 'range',
								name = L["Green"],
								order = 66,
								min = -1,
								max = 1,
								step = 0.01,
								desc = L["This is how much the color will gain or lose this value"],
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.stylefilterg end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.stylefilterg = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							stylefilterblue = {
								type = 'range',
								name = L["Blue"],
								order = 67,
								min = -1,
								max = 1,
								step = 0.01,
								desc = L["This is how much the color will gain or lose this value"],
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.stylefilterb end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.stylefilterb = value E:StaticPopup_Show('CONFIG_RL') end,
							},
						},
					},
					power = {
						order = 4,
						type = 'group',
						name = L["Power Colors"],
						args = {
							enablepowercustom = {
								order = 3,
								type = 'toggle',
								name = L["Enable Custom Gradient Power"],
								desc = L["Enable Custom Gradient Power Colors"],
								width = 'full',
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepower and not E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom = value ElvUI_EltreumUI:GradientColorTableUpdate() end,
							},
							headermana = {
								order = 10,
								type = "description",
								name = MANA,
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							mana1 = {
								order = 11,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.manaR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.manaG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.manaB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.manaR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.manaG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.manaB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.manaR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.manaG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.manaB1 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							mana2 = {
								order = 12,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.manaR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.manaG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.manaB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.manaR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.manaG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.manaB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.manaR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.manaG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.manaB2 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							headerrage = {
								order = 13,
								type = "description",
								name = RAGE,
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							rage1 = {
								order = 14,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.rageR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.rageG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.rageB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.rageR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.rageG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.rageB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.rageR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.rageG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.rageB1 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							rage2 = {
								order = 15,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.rageR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.rageG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.rageB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.rageR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.rageG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.rageB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.rageR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.rageG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.rageB2 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							headerfocus = {
								order = 16,
								type = "description",
								name = POWER_TYPE_FOCUS,
								width = 'full',
								hidden = not E.Retail,
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							focus1 = {
								order = 17,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								hidden = not E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.focusR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.focusG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.focusB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.focusR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.focusG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.focusB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.focusR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.focusG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.focusB1 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							focus2 = {
								order = 18,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								hidden = not E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.focusR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.focusG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.focusB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.focusR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.focusG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.focusB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.focusR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.focusG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.focusB2 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							headerenergy = {
								order = 19,
								type = "description",
								name = ENERGY,
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							energy1 = {
								order = 20,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.energyR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.energyG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.energyB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.energyR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.energyG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.energyB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.energyR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.energyG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.energyB1 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							energy2 = {
								order = 21,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.energyR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.energyG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.energyB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.energyR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.energyG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.energyB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.energyR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.energyG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.energyB2 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							headerrunicpower = {
								order = 22,
								type = "description",
								name = function()
									if not E.Classic then
										return RUNIC_POWER
									else
										return "Runic Power"
									end
								end,
								width = 'full',
								hidden = not E.Retail and not E.Wrath,
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							runicpower1 = {
								order = 23,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								hidden = not E.Retail and not E.Wrath,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.runicpowerR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.runicpowerG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.runicpowerB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.runicpowerR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.runicpowerG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.runicpowerB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.runicpowerR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.runicpowerG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.runicpowerB1 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							runicpower2 = {
								order = 24,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								hidden = not E.Retail and not E.Wrath,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.runicpowerR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.runicpowerG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.runicpowerB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.runicpowerR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.runicpowerG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.runicpowerB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.runicpowerR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.runicpowerG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.runicpowerB2 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							headerlunarpower = {
								order = 25,
								type = "description",
								name = POWER_TYPE_LUNAR_POWER,
								width = 'full',
								hidden = not E.Retail,
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							lunarpower1 = {
								order = 26,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								hidden = not E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.lunarpowerR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.lunarpowerG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.lunarpowerB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.lunarpowerR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.lunarpowerG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.lunarpowerB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.lunarpowerR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.lunarpowerG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.lunarpowerB1 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							lunarpower2 = {
								order = 27,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								hidden = not E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.lunarpowerR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.lunarpowerG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.lunarpowerB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.lunarpowerR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.lunarpowerG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.lunarpowerB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.lunarpowerR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.lunarpowerG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.lunarpowerB2 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							headeraltpower = {
								order = 28,
								type = "description",
								name = ALTERNATE_RESOURCE_TEXT,
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							altpower1 = {
								order = 29,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.altpowerR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.altpowerG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.altpowerB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.altpowerR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.altpowerG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.altpowerB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.altpowerR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.altpowerG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.altpowerB1 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							altpower2 = {
								order = 30,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.altpowerR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.altpowerG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.altpowerB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.altpowerR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.altpowerG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.altpowerB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.altpowerR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.altpowerG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.altpowerB2 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							headermaelstrom = {
								order = 31,
								type = "description",
								name = POWER_TYPE_MAELSTROM,
								width = 'full',
								hidden = not E.Retail,
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							maelstrom1 = {
								order = 32,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								hidden = not E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.maelstromR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.maelstromG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.maelstromB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.maelstromR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.maelstromG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.maelstromB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.maelstromR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.maelstromG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.maelstromB1 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							maelstrom2 = {
								order = 33,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								hidden = not E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.maelstromR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.maelstromG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.maelstromB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.maelstromR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.maelstromG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.maelstromB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.maelstromR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.maelstromG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.maelstromB2 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							headerinsanity = {
								order = 34,
								type = "description",
								name = INSANITY_POWER,
								width = 'full',
								hidden = not E.Retail,
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							insanity1 = {
								order = 35,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								hidden = not E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.insanityR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.insanityG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.insanityB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.insanityR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.insanityG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.insanityB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.insanityR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.insanityG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.insanityB1 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							insanity2 = {
								order = 36,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								hidden = not E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.insanityR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.insanityG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.insanityB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.insanityR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.insanityG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.insanityB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.insanityR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.insanityG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.insanityB2 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							headerfury = {
								order = 37,
								type = "description",
								name = POWER_TYPE_FURY,
								width = 'full',
								hidden = not E.Retail,
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							fury1 = {
								order = 38,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								hidden = not E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.furyR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.furyG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.furyB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.furyR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.furyG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.furyB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.furyR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.furyG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.furyB1 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							fury2 = {
								order = 39,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								hidden = not E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.furyR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.furyG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.furyB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.furyR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.furyG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.furyB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.furyR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.furyG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.furyB2 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							headerpain = {
								order = 40,
								type = "description",
								name = POWER_TYPE_PAIN,
								width = 'full',
								hidden = not E.Retail,
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							pain1 = {
								order = 41,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								hidden = not E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.painR1
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.painG1
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.painB1
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.painR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.painG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.painB1, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.painR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.painG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.painB1 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
							pain2 = {
								order = 42,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								hidden = not E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom end,
								get = function()
									local dr = P.ElvUI_EltreumUI.unitframes.gradientmode.painR2
									local dg = P.ElvUI_EltreumUI.unitframes.gradientmode.painG2
									local db = P.ElvUI_EltreumUI.unitframes.gradientmode.painB2
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.painR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.painG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.painB2, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.painR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.painG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.painB2 = r, g, b ElvUI_EltreumUI:GradientColorTableUpdate()
								end,
							},
						},
					},
				},
			},
			loottext = {
				type = 'group',
				name = LOOT,
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\loot',
				childGroups = "tab",
				order = 85,
				args = {
					loottext = {
						order = 1,
						type = "group",
						name = "LootText",
						args = {
							header1 = {
								order = 1,
								type = "description",
								name = "",
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							lootsetting = {
								order = 2,
								type = 'group',
								inline = true,
								name = L["Show a floating loot text"],
								args = {
									desc = {
										type = 'toggle',
										name = L["Enable"],
										desc = L["Toggle On and Off"],
										order = 1,
										get = function() return E.db.ElvUI_EltreumUI.loot.loottext.enable end,
										set = function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.enable = value E:StaticPopup_Show('CONFIG_RL') end,
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
									suboptions = {
										order = 2,
										type = 'group',
										name = L["Choose which types of text:"],
											args = {
												yetanothergap = {
												order = 2,
												type = "description",
												name = "",
												},
												honor = {
													type = 'toggle',
													name = HONOR,
													order = 5,
													disabled = function() return not E.db.ElvUI_EltreumUI.loot.loottext.enable end,
													get = function() return E.db.ElvUI_EltreumUI.loot.loottext.honor end,
													set = function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.honor = value end,
												},
												currency = {
													type = 'toggle',
													name = CURRENCY,
													order = 5,
													disabled = function() return not E.db.ElvUI_EltreumUI.loot.loottext.enable end,
													get = function() return E.db.ElvUI_EltreumUI.loot.loottext.currency end,
													set = function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.currency = value end,
												},
												pet = {
													type = 'toggle',
													name = L["Pets"],
													order = 5,
													disabled = function() return not E.db.ElvUI_EltreumUI.loot.loottext.enable end,
													get = function() return E.db.ElvUI_EltreumUI.loot.loottext.pet end,
													set = function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.pet = value end,
												},
												filterquality = {
													order = 6,
													type = 'select',
													name = L["Minimum Loot Quality Filter"],
													desc = L["Only items of this quality or better will be displayed"],
													values = {
														["0"] = ITEM_QUALITY0_DESC,
														["1"] = ITEM_QUALITY1_DESC,
														["2"] = ITEM_QUALITY2_DESC,
														["3"] = ITEM_QUALITY3_DESC,
														["4"] = ITEM_QUALITY4_DESC,
													},
													style = 'radio',
													disabled = function() return not E.db.ElvUI_EltreumUI.loot.loottext.enable end,
													get = function() return E.db.ElvUI_EltreumUI.loot.loottext.quality end,
													set = function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.quality = value end,
												},
											}
									},
									header1 = {
										order = 3,
										type = "description",
										name = L["Change the scale of LootText"],
										width = 'full',
										image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
									},
									lootscale = {
										type = 'range',
										name = " ",
										desc = L["Set the size of LootText"],
										order = 4,
										min = .1,
										max = 1.5,
										step = .05,
										width = "full",
										disabled = function() return not E.db.ElvUI_EltreumUI.loot.loottext.enable end,
										get = function() return E.db.ElvUI_EltreumUI.loot.loottext.scale end,
										set = function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.scale = value end,
									},
									lootscalereset = {
										type = 'execute',
										name = L["Reset Scale"],
										desc = L["Return LootText to its default scale"],
										order = 9,
										width = "full",
										disabled = function() return not E.db.ElvUI_EltreumUI.loot.loottext.enable end,
										func = function() E.db.ElvUI_EltreumUI.loot.loottext.scale = 0.65 end,
									},
									header2 = {
										order = 10,
										type = "description",
										name = L["Change the strata of the Loot Text"],
										width = 'full',
										image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
									},
									lootstrata = {
										type = 'select',
										name = " ",
										desc = L["Set the level that LootText will be drawn to this"],
										order = 11,
										values = {
											["BACKGROUND"] = L["Background"],
											["LOW"] = L["Low"],
											["MEDIUM"] = L["Medium"],
											["HIGH"] = L["High"],
											["DIALOG"] = L["Dialog"],
										},
										style = 'radio',
										disabled = function() return not E.db.ElvUI_EltreumUI.loot.loottext.enable end,
										get = function() return E.db.ElvUI_EltreumUI.loot.loottext.strata end,
										set = function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.strata = value E:StaticPopup_Show('CONFIG_RL') end,
									},
									header99 = {
										order = 12,
										type = "description",
										name = "",
										width = 'full',
										image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
									},
									lootscalex = {
										type = 'range',
										name = L["Change the Horizontal Position of LootText (Default = 0)"],
										desc = L["Set X offset"],
										order = 13,
										min = -1000,
										max = 1000,
										step = 1,
										width = "full",
										disabled = function() return not E.db.ElvUI_EltreumUI.loot.loottext.enable end,
										get = function() return E.db.ElvUI_EltreumUI.loot.loottext.xOffset end,
										set = function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.xOffset = value end,
										--confirm = true,
									},
									lootscaley = {
										type = 'range',
										name = L["Change the Vertical Position of LootText (Default = 200)"],
										desc = L["Set Y offset"],
										order = 14,
										min = -1000,
										max = 1000,
										step = 1,
										width = "full",
										disabled = function() return not E.db.ElvUI_EltreumUI.loot.loottext.enable end,
										get = function() return E.db.ElvUI_EltreumUI.loot.loottext.yOffset end,
										set = function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.yOffset = value end,
										--confirm = true,
									},
									header98 = {
										order = 15,
										type = "description",
										name = "",
										width = 'full',
										image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
									},
									customfontlootgap = {
										type = 'description',
										name = '',
										width = 'full',
										order = 16,
									},
									customfontlootdesc = {
										type = 'description',
										name = L["Change the font of LootText to be the ElvUI Default Font found in General"],
										width = 'full',
										order = 17,
									},
									fontsize = {
										type = 'range',
										name = L["Font Size"],
										order = 18,
										min = 4,
										max = 160,
										step = 1,
										--width = "single",
										disabled = function() return not E.db.ElvUI_EltreumUI.loot.loottext.enable end,
										get = function() return E.db.ElvUI_EltreumUI.loot.loottext.fontsize end,
										set = function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.fontsize = value end,
									},
									customfontloot = {
										type = 'toggle',
										name = L["Use ElvUI General Font"],
										desc = L["Change the font of LootText"],
										width = 'full',
										order = 19,
										disabled = function() return E.db.ElvUI_EltreumUI.loot.loottext.fontsettingdmg or E.db.ElvUI_EltreumUI.loot.loottext.fontLSMenable or not E.db.ElvUI_EltreumUI.loot.loottext.enable end,
										get = function() return E.db.ElvUI_EltreumUI.loot.loottext.fontsetting end,
										set = function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.fontsetting = value E:StaticPopup_Show('CONFIG_RL') end,
									},
									customfontlootdmg = {
										type = 'toggle',
										name = L["Use ElvUI Damage Font"],
										desc = L["Change the font of LootText"],
										width = 'full',
										order = 20,
										disabled = function() return E.db.ElvUI_EltreumUI.loot.loottext.fontsetting or E.db.ElvUI_EltreumUI.loot.loottext.fontLSMenable or not E.db.ElvUI_EltreumUI.loot.loottext.enable end,
										get = function() return E.db.ElvUI_EltreumUI.loot.loottext.fontsettingdmg end,
										set = function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.fontsettingdmg = value E:StaticPopup_Show('CONFIG_RL') end,
									},
									customLSMfont = {
										type = 'toggle',
										name = L["Use Custom Font"],
										desc = L["Change the font of LootText"],
										width = 'full',
										order = 21,
										disabled = function() return E.db.ElvUI_EltreumUI.loot.loottext.fontsettingdmg or E.db.ElvUI_EltreumUI.loot.loottext.fontsetting end,
										get = function() return E.db.ElvUI_EltreumUI.loot.loottext.fontLSMenable end,
										set = function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.fontLSMenable = value E:StaticPopup_Show('CONFIG_RL') end,
									},
									sharedmediafontloot = {
										order = 22,
										type = 'select',
										--width = "single",
										dialogControl = 'LSM30_Font',
										name = L["Font"],
										desc = L["Choose a different font from the preselected ones"],
										values = AceGUIWidgetLSMlists.font,
										disabled = function() return E.db.ElvUI_EltreumUI.loot.loottext.fontsettingdmg or E.db.ElvUI_EltreumUI.loot.loottext.fontsetting or not E.db.ElvUI_EltreumUI.loot.loottext.fontLSMenable end,
										get = function()
											return E.db.ElvUI_EltreumUI.loot.loottext.fontLSM
										end,
										set = function(self,fontvalue)
											E.db.ElvUI_EltreumUI.loot.loottext.fontLSM = fontvalue
										end,
									},
								},
							},
							header13 = {
								order = 38,
								type = "description",
								name = "",
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
						},
					},
					fastloot = {
						order = 2,
						type = "group",
						name = "Fast Loot",
						args = {
							fastlootenable = {
								order = 39,
								name = L["Enable Fast Loot"],
								type = "toggle",
								desc = L["Decrease the time it takes for auto loot to work, works with TSM"],
								width = 'full',
								disabled = function() return E.db.ElvUI_EltreumUI.loot.fastlootfilter or E.db.ElvUI_EltreumUI.loot.lootwishlistfilter end,
								get = function() return E.db.ElvUI_EltreumUI.loot.fastloot end,
								set = function(_, value) E.db.ElvUI_EltreumUI.loot.fastloot = value SetCVar('autoLootDefault', 1) E:StaticPopup_Show('CONFIG_RL') end,
							},
							fastlootenablefilter = {
								order = 40,
								name = L["Enable Fast Loot with Loot Quality Filter"],
								type = "toggle",
								desc = L["Enable filtering item quality, items can still be looted by holding Shift or the mod key setup in Interface"],
								width = 'full',
								disabled = function() return E.db.ElvUI_EltreumUI.loot.fastloot or E.db.ElvUI_EltreumUI.loot.lootwishlistfilter end,
								get = function() return E.db.ElvUI_EltreumUI.loot.fastlootfilter end,
								set = function(_, value) E.db.ElvUI_EltreumUI.loot.fastlootfilter = value SetCVar('autoLootDefault', 0) E:StaticPopup_Show('CONFIG_RL') end,
							},
							lootwishlistfilter = {
								order = 41,
								name = L["Enable Fast Loot with Wishlist Filter"],
								type = "toggle",
								desc = L["Items not on the wishlist will not be looted, items can still be looted by holding Shift or the mod key setup in Interface"],
								width = 'full',
								disabled = function() return E.db.ElvUI_EltreumUI.loot.fastloot or E.db.ElvUI_EltreumUI.loot.fastlootfilter or #E.private.ElvUI_EltreumUI.wishlistID == 0 end,
								get = function() return E.db.ElvUI_EltreumUI.loot.lootwishlistfilter end,
								set = function(_, value) E.db.ElvUI_EltreumUI.loot.lootwishlistfilter = value SetCVar('autoLootDefault', 0) E:StaticPopup_Show('CONFIG_RL') end,
							},
							lootwishlistwarning = {
								order = 42,
								name = L["Enable Wishlist Loot Warning"],
								type = "toggle",
								desc = L["Show a toast if an item in the wishlist is looted"],
								width = 'full',
								disabled = function() return #E.private.ElvUI_EltreumUI.wishlistID == 0 end,
								get = function() return E.db.ElvUI_EltreumUI.loot.lootwishlistwarning end,
								set = function(_, value) E.db.ElvUI_EltreumUI.loot.lootwishlistwarning = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							lootautoclose = {
								order = 43,
								name = L["Enable Automatically Closing Loot Window"],
								type = "toggle",
								desc = L["Loot Window will automatically close when using filters and the item desired is not found"],
								width = 'full',
								get = function() return E.db.ElvUI_EltreumUI.loot.lootautoclose end,
								set = function(_, value) E.db.ElvUI_EltreumUI.loot.lootautoclose = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							lootconfirmbop = {
								order = 43,
								name = L["Enable Automatically Confirming Bind on Pickup"],
								type = "toggle",
								desc = L["Loot Window will automatically confirm looting Bind on Pickup items"],
								width = 'full',
								hidden = E.Retail,
								get = function() return E.db.ElvUI_EltreumUI.loot.confirmbop end,
								set = function(_, value) E.db.ElvUI_EltreumUI.loot.confirmbop = value end,
							},
							lootscreenshot = {
								order = 43,
								name = L["Enable Screenshotting if an item from the wishlist is looted"],
								type = "toggle",
								desc = L["Automatically screenshot when you loot an item from the wishlist"],
								width = 'full',
								disabled = function() return #E.private.ElvUI_EltreumUI.wishlistID == 0 end,
								get = function() return E.db.ElvUI_EltreumUI.loot.lootwishlistscreenshot end,
								set = function(_, value) E.db.ElvUI_EltreumUI.loot.lootwishlistscreenshot = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							fastlootenablefilterquality = {
								order = 43,
								type = 'select',
								name = L["Minimum Loot Quality Filter"],
								desc = L["Only items of this quality or better will be looted when using Fast Loot Filter"],
								values = {
									["0"] = ITEM_QUALITY0_DESC,
									["1"] = ITEM_QUALITY1_DESC,
									["2"] = ITEM_QUALITY2_DESC,
									["3"] = ITEM_QUALITY3_DESC,
									["4"] = ITEM_QUALITY4_DESC,
								},
								style = 'radio',
								disabled = function() return E.db.ElvUI_EltreumUI.loot.fastloot or not E.db.ElvUI_EltreumUI.loot.fastlootfilter or E.db.ElvUI_EltreumUI.loot.lootwishlistfilter end,
								get = function() return E.db.ElvUI_EltreumUI.loot.fastlootquality end,
								set = function(_, value) E.db.ElvUI_EltreumUI.loot.fastlootquality = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							soundscreenshot = {
								order = 44,
								name = L["Enable Playing a Sound if an item from the wishlist is looted"],
								type = "toggle",
								width = 'full',
								disabled = function() return #E.private.ElvUI_EltreumUI.wishlistID == 0 end,
								get = function() return E.db.ElvUI_EltreumUI.loot.lootwishlistsoundenable end,
								set = function(_, value) E.db.ElvUI_EltreumUI.loot.lootwishlistsoundenable = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							sharedmediasoundwishlist = {
								order = 45,
								type = 'select',
								width = "double",
								dialogControl = 'LSM30_Sound',
								name = L["Select a Sound"],
								desc = L["Choose a Sound from SharedMedia files"],
								values = AceGUIWidgetLSMlists.sound,
								disabled = function() return not E.db.ElvUI_EltreumUI.loot.lootwishlistsoundenable or (#E.private.ElvUI_EltreumUI.wishlistID == 0) end,
								get = function() return E.db.ElvUI_EltreumUI.loot.lootwishlistsound end,
								set = function(self,key) E.db.ElvUI_EltreumUI.loot.lootwishlistsound = key E:StaticPopup_Show('CONFIG_RL') end,
							},
							lootwishlist = {
								order = 94,
								type = 'input',
								name = L["Item Wishlist (type the Item ID)"],
								desc = L["Items in your wishlist will display a warning when looted"],
								width = 'double',
								get = function() return E.private.ElvUI_EltreumUI.wishlistID end,
								validate = function(_, value)
									E.PopupDialogs["ELTRUISMINVALID"] = {
										text = L["Invalid Item, you need to add an itemID which can be found in the tooltip or in Wowhead"],
										button1 = OKAY,
										timeout = 0,
										whileDead = 1,
										hideOnEscape = true,
									}
									if tonumber(value) ~= nil then
										value = tonumber(value)
										local item = Item:CreateFromItemID(value)
										if item == nil then
											return E:StaticPopup_Show('ELTRUISMINVALID') and false
										elseif item:IsItemEmpty() then
											return E:StaticPopup_Show('ELTRUISMINVALID') and false
										else
											return true
										end
									else
										return E:StaticPopup_Show('ELTRUISMINVALID') and false
									end
								end,
								set = function(_, value)
									value = tonumber(value)
									local item = Item:CreateFromItemID(value)
									if not item:IsItemEmpty() then
										item:ContinueOnItemLoad(function()
											local itemName = item:GetItemName()
											local itemID = tonumber(value)
											tinsert(E.private.ElvUI_EltreumUI.wishlistName, itemName)
											tinsert(E.private.ElvUI_EltreumUI.wishlistID, itemID)
										end)
									end
								end,
							},
							lootwishlistremove = {
								order = 95,
								type = 'select',
								width = "double",
								name = L["Remove item from Wishlist"],
								desc = REMOVE,
								values = E.private.ElvUI_EltreumUI.wishlistName,
								get = function() return E.private.ElvUI_EltreumUI.wishlistName end,
								set = function(_,value)
									local item = tonumber(value)
									tremove(E.private.ElvUI_EltreumUI.wishlistID, item)
									tremove(E.private.ElvUI_EltreumUI.wishlistName, item)
								end,
							},
						},
					},
				},
			},
			maps = {
				type = 'group',
				name = L["Maps"],
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\map',
				order = 85,
				args = {
					header1 = {
						order = 1,
						type = "description",
						name = "",
						width = 'full',
						hidden = not E.Retail,
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					waypointetasetting = {
						order = 2,
						type = 'group',
						inline = true,
						hidden = not E.Retail,
						name = L["Add a time to arrive below the waypoint"],
						args = {
							explainer = {
								order = 1,
								type = "description",
								name = L["The time will be calculated based on player speed and distance"],
							},
							explainer2 = {
								order = 2,
								type = "description",
								name = L["If the player is not moving then *** will show up since time cannot be calculated"],
							},
							explainer3 = {
								order = 3,
								type = "description",
								name = L["If you move away from the waypoint the time will just increase"],
							},
							explainer4 = {
								order = 4,
								type = "description",
								name = '',
							},
							enable = {
								order = 5,
								type = 'toggle',
								name = L["Enable ETA"],
								desc = L["Add an ETA to waypoints"],
								get = function() return E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.enable end,
								set = function(_, value) E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.enable = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							enableautopin = {
								order = 7,
								type = 'toggle',
								name = L["Enable Autopin"],
								desc = L["Automatically pin the Waypoint"],
								disabled = function() return not E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.enable end,
								get = function() return E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.autopin end,
								set = function(_, value) E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.autopin = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							enablelimit = {
								order = 9,
								type = 'toggle',
								name = L["Limit Max Distance"],
								hidden = function() if E.Retail then return false else return true end end,
								disabled = function() return not E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.enable end,
								get = function() return E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.limitmaxdistance or not E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.enable end,
								set = function(_, value) E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.limitmaxdistance = value end,
							},
							etacolor = {
								order = 10,
								type = 'color',
								name = L["Text Color"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.enable end,
								get = function() return E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorR, E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorG, E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorB, 1, P.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorR, P.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorG, P.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorB, 1 end,
								set = function(_, r, g, b, a) E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorR, E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorG, E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorB = r, g, b E:StaticPopup_Show('CONFIG_RL') end,
							},
							enablelimitd = {
								type = 'range',
								name = L["Max Distance"],
								order = 11,
								min = 200,
								max = 10000,
								step = 10,
								width = "full",
								hidden = function() if E.Retail then return false else return true end end,
								disabled = function() return not E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.limitmaxdistance or not E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.enable end,
								get = function() return E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.distance end,
								set = function(_, value) E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.distance = value end,
							},
						},
					},
					header2 = {
						order = 3,
						type = "description",
						name = "",
						width = 'full',
						hidden = not E.Retail,
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					waytext = {
						order = 4,
						type = 'group',
						inline = true,
						hidden = not E.Retail,
						name = L["Enable the /way and /waypoint commands"],
						args = {
							explainer = {
								order = 1,
								type = "description",
								name = L["You can type /way or /waypoint"],
							},
							explainer2 = {
								order = 2,
								type = "description",
								name = L["Use formats such as:"],
							},
							explainer3 = {
								order = 3,
								type = "description",
								name = L["XX YY, XX.XX YY.YY, XX,XX YY,YY and XXX YYY"],
							},
							explainer4 = {
								order = 4,
								type = "description",
								name = L["Other Formats can end up causing errors"],
							},
							enable = {
								order = 5,
								type = 'toggle',
								name = L["Enable"],
								desc = L["Enable the /way and /waypoint commands"],
								get = function() return E.db.ElvUI_EltreumUI.waypoints.waytext.enable end,
								set = function(_, value) E.db.ElvUI_EltreumUI.waypoints.waytext.enable = value end,
							},
						},
					},
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
								width = "full",
							},
							enable = {
								order = 5,
								type = 'toggle',
								name = L["Enable"],
								desc = L["Automatically hide the Minimap in combat"],
								get = function() return E.db.ElvUI_EltreumUI.otherstuff.mapcombathide end,
								set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.mapcombathide = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							enableaurapos = {
								order = 6,
								type = 'toggle',
								name = L["Adjust Auras Position"],
								desc = L["Automatically move auras to the Top Right when minimap is hidden"],
								disabled = function() return not E.db.ElvUI_EltreumUI.otherstuff.mapcombathide end,
								get = function() return E.db.ElvUI_EltreumUI.otherstuff.mapcombathideadjustaura end,
								set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.mapcombathideadjustaura = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							header3cardinal = {
								order = 7,
								type = "description",
								name = L["Minimap Cardinal Directions"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							enablecardinal = {
								order = 8,
								type = 'toggle',
								name = L["Enable Cardinal Directions"],
								desc = L["Add North, East, South, West to Minimap"],
								width = "full",
								disabled = function() return C_CVar.GetCVar("rotateMinimap") == "1" end,
								get = function() return E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.enable end,
								set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.enable = value ElvUI_EltreumUI:MinimapCardinalDirections() end,
							},
							cardinaloffset = {
								type = 'range',
								name = L["Cardinal Text Offset"],
								order = 9,
								min = -50,
								max = 50,
								step = 1,
								--width = "double",
								disabled = function() return C_CVar.GetCVar("rotateMinimap") == "1" or not E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.enable end,
								get = function() return E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.offset end,
								set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.offset = value ElvUI_EltreumUI:MinimapCardinalDirections() end,
							},
							fontsize = {
								type = 'range',
								name = L["Font Size"],
								order = 10,
								min = 4,
								max = 30,
								step = 1,
								--width = "single",
								disabled = function() return C_CVar.GetCVar("rotateMinimap") == "1" or not E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.enable end,
								get = function() return E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.fontsize end,
								set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.fontsize = value ElvUI_EltreumUI:MinimapCardinalDirections() end,
							},
							linebreak = {
								order = 11,
								type = "description",
								name = "",
								width = 'full',
							},
							cardinalclasscolor = {
								order = 12,
								type = 'toggle',
								name = L["Use Class Colors"],
								--width = "full",
								disabled = function() return C_CVar.GetCVar("rotateMinimap") == "1" or not E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.enable end,
								get = function() return E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.classcolor end,
								set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.classcolor = value ElvUI_EltreumUI:MinimapCardinalDirections() end,
							},
							cardinalcustomcolor = {
								order = 13,
								type = 'color',
								name = L["Custom Color"],
								hasAlpha = false,
								disabled = function() return C_CVar.GetCVar("rotateMinimap") == "1" or not E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.enable or E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.classcolor end,
								get = function()
									return E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.r, E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.g, E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.b, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.r, E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.g, E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.b = r, g, b ElvUI_EltreumUI:MinimapCardinalDirections()
								end,
							},
						},
					},
					headertaxiscale = {
						order = 7,
						type = "description",
						name = "",
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					taxiscale = {
						type = 'range',
						name = E.NewSign..L["Flight Frame Scale"],
						order = 8,
						min = 0.1,
						max = 3,
						step = 0.01,
						--width = "double",
						get = function() return E.db.ElvUI_EltreumUI.otherstuff.taxiscale end,
						set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.taxiscale = value
							if _G["TaxiFrame"] then
								_G["TaxiFrame"]:SetScale(value)
							end
							if _G["FlightMapFrame"] then
								_G["FlightMapFrame"]:SetScale(value)
							end
						end,
					},
				},
			},
			media = {
				type = 'group',
				name = L["Media"],
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\media',
				childGroups = "tab",
				order = 85,
				args = {
					general = {
						type = 'group',
						name = L["Setup Media"],
						order = 1,
						args = {
							header7 = {
								order = 1,
								type = "description",
								name = "",
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							private = {
								order = 2,
								type = 'execute',
								name = L["Reset all Media"],
								desc = L["Reset Fonts, Textures, Skins to Eltreum UI defaults."],
								width = 'full',
								func = function() ElvUI_EltreumUI:SetupPrivate() E:StaggeredUpdateAll(nil, true) E:StaticPopup_Show('CONFIG_RL') end,
								confirm = true,
							},
							header1 = {
								order = 3,
								type = "description",
								name = "",
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							fontdescription= {
								order = 3,
								type = "description",
								name = L["Set the fonts used in Eltruism. Kimberley is the default font"],
							},
							kimberley = {
								order = 4,
								type = 'execute',
								name = 'Kimberley',
								desc = L["This will set all ElvUI fonts as Kimberley"],
								func = function() ElvUI_EltreumUI:SetupFontsKimberley() E:StaggeredUpdateAll(nil, true) end,
								confirm = true,
							},
							exo2 = {
								order = 5,
								type = 'execute',
								name = 'Exo2',
								desc = L["This will set all ElvUI fonts as Exo2"],
								func = function() ElvUI_EltreumUI:SetupFontsExo2() E:StaggeredUpdateAll(nil, true) end,
								confirm = true,
							},
							addagaphereforfonts = {
								order = 6,
								type = "description",
								name = "",
								--width = "full",
							},
							gotham = {
								order = 7,
								type = 'execute',
								name = 'Gotham',
								desc = L["This will set all ElvUI fonts as Gotham"],
								func = function() ElvUI_EltreumUI:SetupFontsGotham() E:StaggeredUpdateAll(nil, true) end,
								confirm = true,
							},
							roboto = {
								order = 7,
								type = 'execute',
								name = 'Roboto',
								desc = L["This will set all ElvUI fonts as Roboto"],
								func = function() ElvUI_EltreumUI:SetupFontsRoboto() E:StaggeredUpdateAll(nil, true) end,
								confirm = true,
							},
							sharedmediafont = {
								order = 8,
								type = 'select',
								width = "double",
								dialogControl = 'LSM30_Font',
								name = L["Or choose a custom font"],
								desc = L["Choose a different font from the preselected ones"],
								values = AceGUIWidgetLSMlists.font,
								get = function()
									return E.db.ElvUI_EltreumUI.otherstuff.fonts.playerfont
								end,
								set = function(self,fontvalue)
									E.db.ElvUI_EltreumUI.otherstuff.fonts.playerfont = fontvalue
									ElvUI_EltreumUI:SetupCustomFont(fontvalue)
								end,
							},
							addagaphereforoutlines = {
								order = 9,
								type = "description",
								name = "",
							},
							addagaphereagain = {
								order = 9,
								type = "description",
								name = "",
							},
							header3 = {
								order = 10,
								type = "description",
								name = "",
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							fontoutline = {
								order = 11,
								type = "description",
								name = L["Set the Font Outlines everywhere. Use Default to return to Eltruism default settings"],
								width = "full",
							},
							default = {
								order = 12,
								type = 'execute',
								name = L["Defaults"],
								desc = L["This will set fonts to Eltruism defaults, recommended for 4K"],
								func = function() ElvUI_EltreumUI:SetupFontsOutlineDefault() E:StaggeredUpdateAll(nil, true) E:StaticPopup_Show('CONFIG_RL') end,
								confirm = true,
							},
							none = {
								order = 12,
								type = 'execute',
								name = L["None"],
								desc = L["This will set fonts to no outline"],
								func = function() ElvUI_EltreumUI:SetupFontsOutlineCustom("NONE") E:StaggeredUpdateAll(nil, true) E:StaticPopup_Show('CONFIG_RL') end,
								confirm = true,
							},
							outlinegap = {
								order = 13,
								type = "description",
								name = "",
							},
							outline = {
								order = 13,
								type = 'execute',
								name = L["Outline"],
								desc = L["This will set fonts to use outline, recommended for 1440p and 1080p"],
								func = function() ElvUI_EltreumUI:SetupFontsOutlineCustom("OUTLINE") E:StaggeredUpdateAll(nil, true) E:StaticPopup_Show('CONFIG_RL') end,
								confirm = true,
							},
							thick = {
								order = 13,
								type = 'execute',
								name = L["Thick Outline"],
								desc = L["This will set fonts to use thick outline"],
								func = function() ElvUI_EltreumUI:SetupFontsOutlineCustom("THICKOUTLINE") E:StaggeredUpdateAll(nil, true) E:StaticPopup_Show('CONFIG_RL') end,
								confirm = true,
							},
							header448 = {
								order = 94,
								type = "description",
								name = "",
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							bgmode = {
								order = 95,
								type = "description",
								name = L["Change the ElvUI background"],
								width = "full",
							},
							grey = {
								order = 96,
								type = 'execute',
								name = L["Grey Background"],
								desc = L["This will set the background to be a grey color"],
								func = function() ElvUI_EltreumUI:GreyBg() E:UpdateMediaItems() end,
								confirm = true,
							},
							black = {
								order = 97,
								type = 'execute',
								name = L["Black Background"],
								desc = L["This will set the background to be a black color"],
								func = function() ElvUI_EltreumUI:BlackBg() E:UpdateMediaItems() end,
								confirm = true,
							},
							header5 = {
								order = 124,
								type = "description",
								name = "",
								width = 'full',
								hidden = E.Retail,
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							dynamicdatatext12123 = {
								order = 125,
								type = "description",
								hidden = E.Retail,
								name = L["Dynamic Datatext that changes according to class to show Ammo or Soul Shards when playing Hunter, Warrior, Rogue or Warlock"],
								width = "full",
							},
							dynamicenable = {
								order = 126,
								type = 'toggle',
								name = L["Enable"],
								desc = L["Enable the Dynamic Datatext"],
								hidden = E.Retail,
								get = function() return E.db.ElvUI_EltreumUI.otherstuff.dynamicdatatext end,
								set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.dynamicdatatext = value end,
							},
							headerweakaurabar = {
								order = 130,
								type = "description",
								name = L["WeakAuras Action Bar"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							weakaurabar = {
								order = 131,
								type = 'toggle',
								name = L["Move ActionBars and Power to be similar to WeakAuras"],
								desc = L["Overwrites some profile settings to move ActionBars, Unitframes and Powers to look more similar to a WeakAura. |cffFF0000WARNING:|r This will overwrite some of your profile settings with no way to restore"],
								confirm = true,
								width = 'full',
								get = function() return E.db.ElvUI_EltreumUI.otherstuff.ABlikeWA end,
								set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.ABlikeWA = value
									ElvUI_EltreumUI:WeakAurasLikeActionBars(value)
									E:StaticPopup_Show('CONFIG_RL')
								end,
							},
							headerFSR = {
								order = 132,
								type = "description",
								name = L["AMD FSR"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							forceFSRon = {
								order = 133,
								type = 'toggle',
								name = L["Enable AMD FSR even if not scaling"],
								desc = L["Forces AMD's FSR to sharpen image even if you aren't running a lower resolution"],
								width = 'full',
								get = function()
									if C_CVar.GetCVar('ResampleAlwaysSharpen') == '0' then
										return false
									elseif C_CVar.GetCVar('ResampleAlwaysSharpen') == '1' then
										return true
									end
								end,
								set = function(_, value)
									if value == true then
								 		SetCVar('ResampleAlwaysSharpen', 1)
								 	else
								 		SetCVar('ResampleAlwaysSharpen', 0)
								 	end
								 end,
							},
							forceFSRsharpness = {
								order = 134,
								type = 'range',
								name = RESAMPLE_QUALITY_FSR,
								--desc = L["FSR Sharpness"],
								min = 0,
								max = 2,
								step = 0.1,
								width = "full",
								disabled = function()
									if C_CVar.GetCVar('ResampleAlwaysSharpen') == '1' then
										return false
									elseif C_CVar.GetCVar('ResampleAlwaysSharpen') == '0' then
										return true
									end
								end,
								hidden = E.Retail,
								get = function() return tonumber(C_CVar.GetCVar('ResampleSharpness')) end,
								set = function(_, value) SetCVar('ResampleSharpness', value) end,
							},
						},
					},
				},
			},
			misc = {
				type = 'group',
				name = L["Misc"],
				--childGroups = "tab",
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\misc',
				order = 85,
				args = {
					header0 = {
						order = 1,
						type = "description",
						name = L["Show Eltruism Game Menu Button"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					gamemenu = {
						type = 'toggle',
						name = L["Enable"],
						order = 2,
						get = function() return E.db.ElvUI_EltreumUI.otherstuff.gamemenu end,
						set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.gamemenu = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					header1 = {
						order = 3,
						type = "description",
						name = L["Show Buffs in Arena and hide them outside (will overwrite Eltruism default settings)"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					arenabuffs = {
						type = 'toggle',
						name = L["Enable"],
						order = 4,
						get = function() return E.db.ElvUI_EltreumUI.unitframes.arenabuffs end,
						set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.arenabuffs = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					header2 = {
						order = 5,
						type = "description",
						hidden = E.Classic,
						name = function()
							if E.Retail then
								return L["Hide Arena Frames in Arena due to Gladius/GladiusEX or another addon"]
							else
								return L["Hide Arena Frames in Arena due to Gladius/Gladdy or another addon"]
							end
						end,
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					arenaUF = {
						type = 'toggle',
						name = L["Enable"],
						hidden = E.Classic,
						order = 6,
						get = function() return E.db.ElvUI_EltreumUI.unitframes.arenaunitframes end,
						set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.arenaunitframes = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					header3 = {
						order = 7,
						type = "description",
						name = L["Hide Raid Unitframes in battlegrounds due to addons like Battleground Enemies"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					bgUF = {
						type = 'toggle',
						name = L["Enable"],
						order = 8,
						get = function() return E.db.ElvUI_EltreumUI.unitframes.bgunitframes end,
						set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.bgunitframes = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					header4 = {
						order = 9,
						type = "description",
						name = "",
						width = 'full',
						hidden = not E.Retail,
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					rogueorderhallautoopen = {
						order = 10,
						type = "description",
						hidden = not E.Retail,
						name = L["Auto open the Rogue Order Hall, to avoid opening hold CTRL or SHIFT or ALT while talking to the NPC"],
						width = "full",
					},
					rogueenable = {
						order = 11,
						type = 'toggle',
						name = L["Enable"],
						desc = L["Enable the Rogue Order Hall Auto Open"],
						hidden = not E.Retail,
						get = function() return E.db.ElvUI_EltreumUI.quests.rogueopen end,
						set = function(_, value) E.db.ElvUI_EltreumUI.quests.rogueopen = value end,
					},
					header5 = {
						order = 12,
						type = "description",
						name = "",
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					xpdatabar = {
						order = 13,
						type = "toggle",
						name = L["Dynamically toggle the mouseover of the Experience Bar"],
						desc = L["Shows XP bar when below max level, makes it mouseover when max level"],
						width = 'full',
						get = function() return E.db.ElvUI_EltreumUI.otherstuff.dynamicxpbar end,
						set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.dynamicxpbar = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					header6 = {
						order = 26,
						type = "description",
						name = "",
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					combatextindicator = {
						order = 27,
						type = "toggle",
						name = L["Enable Entering/Leaving Combat Indicator Texts"],
						desc = L["Adds a +Combat and -Combat for when entering and leaving combat"],
						width = 'full',
						get = function() return E.db.ElvUI_EltreumUI.loot.loottext.combatindicator end,
						set = function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.combatindicator = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					header7 = {
						order = 28,
						type = "description",
						name = "",
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					darksouls = {
						order = 29,
						type = "toggle",
						name = L["Enable a Dark Souls death animation"],
						desc = L["Plays an animation when you die"],
						width = 'full',
						disabled = function() return E.db.ElvUI_EltreumUI.skins.playerdeathgta or E.db.ElvUI_EltreumUI.skins.playerdeathcustom end,
						get = function() return E.db.ElvUI_EltreumUI.skins.playerdeath end,
						set = function(_, value) E.db.ElvUI_EltreumUI.skins.playerdeath = value end,
					},
					gta = {
						order = 29,
						type = "toggle",
						name = L["Enable a GTA death animation"],
						desc = L["Plays an animation when you die"],
						width = 'full',
						disabled = function() return E.db.ElvUI_EltreumUI.skins.playerdeath or E.db.ElvUI_EltreumUI.skins.playerdeathcustom end,
						get = function() return E.db.ElvUI_EltreumUI.skins.playerdeathgta end,
						set = function(_, value) E.db.ElvUI_EltreumUI.skins.playerdeathgta = value end,
					},
					customdeath = {
						order = 30,
						type = "toggle",
						name = L["Enable a Custom death animation"],
						desc = L["Plays an animation when you die"],
						width = 'full',
						disabled = function() return E.db.ElvUI_EltreumUI.skins.playerdeathgta or E.db.ElvUI_EltreumUI.skins.playerdeath end,
						get = function() return E.db.ElvUI_EltreumUI.skins.playerdeathcustom end,
						set = function(_, value) E.db.ElvUI_EltreumUI.skins.playerdeathcustom = value end,
					},
					customdeathtext = {
						order = 31,
						type = 'input',
						name = L["Custom Death Text"],
						desc = L["The text displayed when you die using the custom text option"],
						--width = 'double',
						disabled = function() return E.db.ElvUI_EltreumUI.skins.playerdeathgta or E.db.ElvUI_EltreumUI.skins.playerdeath or (not E.db.ElvUI_EltreumUI.skins.playerdeathcustom) end,
						get = function() return E.db.ElvUI_EltreumUI.skins.playerdeathcustomtext end,
						set = function(_, value) E.db.ElvUI_EltreumUI.skins.playerdeathcustomtext = tostring(value) E:StaticPopup_Show('PRIVATE_RL') end,
					},
					header8 = {
						order = 33,
						type = "description",
						name = "",
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					rollsound = {
						order = 34,
						type = "toggle",
						name = L["Add Sounds to /roll when someone gets a 1 or a 100"],
						desc = L["Plays a sound if someone rolls 1 or 100 out 100"],
						width = 'full',
						get = function() return E.db.ElvUI_EltreumUI.chat.rollsound end,
						set = function(_, value) E.db.ElvUI_EltreumUI.chat.rollsound = value PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\WillSmith-Ahaha.ogg", "Master") E:StaticPopup_Show('CONFIG_RL') end,
					},
					header9 = {
						order = 35,
						type = "description",
						name = "",
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					worldtext = {
						order = 36,
						type = "description",
						name = L["Change the Scale of the World Text"],
						desc = L["Such as the floating XP, floating reputation changes and others"],
						width = 'full',
					},
					worldtextscale = {
						type = 'range',
						name = L["Select the size of the World Text"],
						order = 37,
						min = 0.2,
						max = 2,
						step = 0.1,
						width = "full",
						get = function() return E.db.ElvUI_EltreumUI.otherstuff.worldtextscale end,
						set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.worldtextscale = value ElvUI_EltreumUI:WorldTextScale(value) end,
					},
					header10 = {
						order = 47,
						type = "description",
						name = "",
						width = 'full',
						hidden = not E.Retail,
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					hidetalkdesc = {
						order = 48,
						type = "description",
						name = L["Hide Talking Head"],
						hidden = not E.Retail,
						width = 'full',
					},
					hidetalkenable = {
						order = 49,
						name = L["Enable"],
						type = "toggle",
						hidden = not E.Retail,
						desc = L["Prevent Blizzard's Talking Head from appearing"],
						width = 'full',
						get = function() return E.db.ElvUI_EltreumUI.skins.hidetalkinghead end,
						set = function(_, value) E.db.ElvUI_EltreumUI.skins.hidetalkinghead = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					header11 = {
						order = 50,
						type = "description",
						name = "",
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					autossdesc = {
						order = 51,
						type = "description",
						name = L["Automatically take Screenshots"],
						width = 'full',
					},
					autossenable = {
						order = 52,
						name = L["Enable"],
						type = "toggle",
						desc = L["Automatically take Screenshots such as when leveling up"],
						width = 'full',
						get = function() return E.db.ElvUI_EltreumUI.otherstuff.screenshot end,
						set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.screenshot = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					header12 = {
						order = 53,
						type = "description",
						name = L["Stealth"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					stealthframeoptions = {
						order = 54,
						type = 'toggle',
						name = L["Add a vignette effect while in stealth"],
						width = 'full',
						desc = L["Turn the effect on"],
						get = function() return E.db.ElvUI_EltreumUI.skins.stealtheffect end,
						set = function(_, value) E.db.ElvUI_EltreumUI.skins.stealtheffect = value end,
					},
					header13 = {
						order = 55,
						type = "description",
						name = L["Item Deletion"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					autotypedelete = {
						order = 56,
						type = 'toggle',
						name = L["Automatically type DELETE on the popup"],
						width = 'full',
						desc = L["Will not delete the item, will simply type DELETE instead you needing to type it"],
						get = function() return E.db.ElvUI_EltreumUI.otherstuff.delete end,
						set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.delete = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					headerdatatexthiding = {
						order = 57,
						type = "description",
						name = L["Datatext Hiding"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					rightchatdatatexthide = {
						order = 58,
						type = 'toggle',
						name = L["Hide Right Chat Datatext out of Combat"],
						width = 'full',
						disabled = function() return not E.db.datatexts.panels.RightChatDataPanel.enable end,
						get = function() return E.db.ElvUI_EltreumUI.otherstuff.rightdatatextcombatshow end,
						set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.rightdatatextcombatshow = value end,
					},
					leftchatdatatexthide = {
						order = 58,
						type = 'toggle',
						name = L["Hide Left Chat Datatext out of Combat"],
						width = 'full',
						disabled = function() return not E.db.datatexts.panels.LeftChatDataPanel.enable end,
						get = function() return E.db.ElvUI_EltreumUI.otherstuff.leftdatatextcombatshow end,
						set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.leftdatatextcombatshow = value end,
					},
					header14 = {
						order = 88,
						type = "description",
						name = L["Play a Sound when receiving mail"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					enablesoundmail = {
						type = 'toggle',
						name = L["Enable"],
						width = "full",
						order = 89,
						get = function() return E.db.ElvUI_EltreumUI.otherstuff.mailsoundenable end,
						set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.mailsoundenable = value end,
					},
					mailsoundselect = {
						type = 'select',
						name= "",
						order = 90,
						values = {
							["tts"] = L["Text to Speech"],
							["sharedmedia"] = CUSTOM,
						},
						style = 'radio',
						disabled = function() return not E.db.ElvUI_EltreumUI.otherstuff.mailsoundenable end,
						get = function() return E.db.ElvUI_EltreumUI.otherstuff.mailsoundtype end,
						set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.mailsoundtype = value end,
					},
					sharedmediasoundmail = {
						order = 91,
						type = 'select',
						width = "double",
						dialogControl = 'LSM30_Sound',
						name = L["Select a Sound"],
						desc = L["Choose a Sound from SharedMedia files"],
						values = AceGUIWidgetLSMlists.sound,
						get = function() return E.db.ElvUI_EltreumUI.otherstuff.mailsound end,
						disabled = function() return not E.db.ElvUI_EltreumUI.otherstuff.mailsoundenable or E.db.ElvUI_EltreumUI.otherstuff.mailsoundtype == "tts" end,
						set = function(self,key) E.db.ElvUI_EltreumUI.otherstuff.mailsound = key E:StaticPopup_Show('CONFIG_RL') end,
					},
					soundmailtts = {
						type = 'input',
						name = L["Text to Speech announcement"],
						width = "full",
						order = 92,
						disabled = function() return not E.db.ElvUI_EltreumUI.otherstuff.mailsoundenable or E.db.ElvUI_EltreumUI.otherstuff.mailsoundtype == "sharedmedia" end,
						get = function() return E.db.ElvUI_EltreumUI.otherstuff.mailsoundttstext end,
						set = function(_, value)
							E.db.ElvUI_EltreumUI.otherstuff.mailsoundttstext = tostring(value)
							if E.db.ElvUI_EltreumUI.otherstuff.mailsoundttsvoice ~= nil then
								C_VoiceChat.SpeakText(E.db.ElvUI_EltreumUI.otherstuff.mailsoundttsvoice, tostring(value) , Enum.VoiceTtsDestination.LocalPlayback, 0, E.db.ElvUI_EltreumUI.otherstuff.mailsoundttsvoicevolume)
							end
						end,
					},
					ttsvoiceselect = {
						type = 'select',
						name= L["Text to Speech Config"],
						order = 93,
						values =
						function()
							local Voices = {}
							for i, v in pairs(C_VoiceChat.GetTtsVoices()) do
								Voices[i] = v.voiceID
							end
							return Voices
						end,
						validate = function(_, value)
							if tonumber(value) ~= nil then
								return true
							else
								return false
							end
						end,
						style = 'radio',
						disabled = function() return not E.db.ElvUI_EltreumUI.otherstuff.mailsoundenable or E.db.ElvUI_EltreumUI.otherstuff.mailsoundtype ~= "tts" end,
						get = function() return E.db.ElvUI_EltreumUI.otherstuff.mailsoundttsvoice end,
						set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.mailsoundttsvoice = tonumber(value)
							C_VoiceChat.SpeakText(E.db.ElvUI_EltreumUI.otherstuff.mailsoundttsvoice, TEXT_TO_SPEECH, Enum.VoiceTtsDestination.LocalPlayback, 0, E.db.ElvUI_EltreumUI.otherstuff.mailsoundttsvoicevolume)
						end,
					},
					volume = {
						type = 'range',
						name = VOLUME,
						order = 94,
						min = 1,
						max = 100,
						step = 1,
						width = "full",
						disabled = function() return not E.db.ElvUI_EltreumUI.otherstuff.mailsoundenable or E.db.ElvUI_EltreumUI.otherstuff.mailsoundtype ~= "tts" end,
						get = function() return E.db.ElvUI_EltreumUI.otherstuff.mailsoundttsvoicevolume end,
						set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.mailsoundttsvoicevolume = value end,
					},
					header15 = {
						order = 95,
						type = "description",
						name = L["Blizzard Floating Combat Text"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					blizzcombatexttoggle = {
						order = 96,
						name = L["Disable Combat Text"],
						type = "toggle",
						desc = L["Enable or disable Blizzard's default Floating Combat Text"],
						width = 'full',
						get = function() return E.db.ElvUI_EltreumUI.otherstuff.blizzcombattext end,
						set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.blizzcombattext = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					blizzcombatextmana = {
						order = 97,
						name = L["Enable Resource Gains"],
						type = "toggle",
						desc = L["Enable or disable Blizzard's default Floating Combat Text for Mana/Rage/Energy and other resouces"],
						width = 'full',
						get = function() return E.db.ElvUI_EltreumUI.otherstuff.blizzcombatmana end,
						set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.blizzcombatmana = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					restorecombatext = {
						order = 98,
						name = L["Restore All Blizzard Combat Text"],
						type = 'execute',
						width = 'full',
						func = function() ElvUI_EltreumUI:RestoreBlizzCombatText() E:StaticPopup_Show('CONFIG_RL') end,
					},
					header16 = {
						order = 198,
						type = "description",
						name = "",
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					apswap = {
						order = 199,
						type = 'execute',
						name = L["Swap Action Paging and visibility for Bar1 and Bar4"],
						--desc = "",
						width = 'full',
						confirm = true,
						func = function() ElvUI_EltreumUI:ActionPagingSwap() E:StaticPopup_Show('CONFIG_RL') end,
					},
				},
			},
			nameplates = {
				type = 'group',
				name = L["Nameplates"],
				order = 85,
				childGroups = "tab",
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\nameplate',
				args = {
					general = {
						order = 1,
						type = 'group',
						name = L["General"],
						args = {
							header = {
								order = 1,
								type = "description",
								name = L["Class Colored Nameplate Options"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							classhover = {
								order = 2,
								type = 'toggle',
								name = L["Hover"],
								width = 'double',
								desc = L["Change the color of the hover to be class colored"],
								get = function() return E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.ClassColorGlow end,
								set = function(_, value) E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.ClassColorGlow = value ElvUI_EltreumUI:SetStyleFilters() end,
							},
							classborder = {
								order = 3,
								type = 'toggle',
								name = L["Border"],
								width = 'double',
								desc = L["Change the color of the border glow to be class bordered in nameplates"],
								get = function() return E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.ClassBorderNameplate end,
								set = function(_, value) E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.ClassBorderNameplate = value ElvUI_EltreumUI:SetStyleFilters() end,
							},
							classtexture = {
								order = 4,
								type = 'toggle',
								name = L["Player Class Texture"],
								width = 'double',
								desc = L["Change the texture of the nameplate to be a class gradient of the player's class"],
								disabled = function() return E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.targetclasstexture end,
								get = function() return E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.nameplatetexture end,
								set = function(_, value) E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.nameplatetexture = value ElvUI_EltreumUI:SetStyleFilters() end,
							},
							targetclasstexture = {
								order = 4,
								type = 'toggle',
								name = L["Target Class Texture"],
								width = 'double',
								desc = L["Change the texture of the nameplate to be a class gradient of the target's class"],
								disabled = function() return E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.nameplatetexture end,
								get = function() return E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.targetclasstexture end,
								set = function(_, value) E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.targetclasstexture = value ElvUI_EltreumUI:SetStyleFilters() end,
							},
							headernptextv = {
								order = 5,
								type = "description",
								name= L["Nameplate Texture Version"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							textureselect = {
								type = 'select',
								name= "",
								order = 6,
								values = {
									["V1"] = L["Version 1"],
									["V2"] = L["Version 2"],
									["V3"] = L["Version 3"],
									["NONE"] = L["None"],
								},
								style = 'radio',
								disabled = function() return (not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.nameplatetexture and not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.targetclasstexture) end,
								get = function() return E.db.ElvUI_EltreumUI.nameplates.nptextureversion end,
								set = function(_, value) E.db.ElvUI_EltreumUI.nameplates.nptextureversion = value end,
							},
							headernpheight = {
								order = 7,
								type = "description",
								name= L["Custom Health Height"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							enableCustomHealthHeight = {
								order = 8,
								type = 'toggle',
								name = L["Enable Custom Health Heights"],
								desc = L["Changes Nameplate Health Height depending on conditions"],
								width = 'full',
								get = function() return E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.enableHealthHeight end,
								set = function(_, value) E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.enableHealthHeight = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							enableCustomHealthHeightelvui = {
								order = 8,
								type = 'toggle',
								name = L["Use ElvUI Health Heights"],
								desc = L["Use ElvUI Nameplate Health Heights when targeted or in combat"],
								width = 'full',
								disabled = function() return not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.enableHealthHeight end,
								get = function() return E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.useelvuinpheight end,
								set = function(_, value) E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.useelvuinpheight = value end,
							},
							enableCustomHealthHeightnocombat = {
								type = 'range',
								name = L["Out of Combat/Not Targeted"],
								desc = L["Choose the Health Height for Nameplates not in combat or not targeted"],
								order = 12,
								min = 1,
								max = 40,
								step = 1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.enableHealthHeight end,
								get = function() return E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.outofcombatHeight end,
								set = function(_, value) E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.outofcombatHeight = value end,
							},
							enableCustomHealthHeightincombat = {
								type = 'range',
								name = L["In Combat/Targeted"],
								desc = L["Choose the Health Height for Nameplates that are in combat or targeted"],
								order = 12,
								min = 1,
								max = 40,
								step = 1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.enableHealthHeight or E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.useelvuinpheight end,
								get = function() return E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.incombatHeight end,
								set = function(_, value) E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.incombatHeight = value end,
							},
							header2 = {
								order = 905,
								type = "description",
								name = L["Control how Blizzard Friendly Nameplates behave"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							hidehealthinsideinstances = {
								order = 906,
								type = 'toggle',
								name = L["Show Blizzard Friendly Nameplates but Hide Healthbar"],
								desc = L["Show Blizzard Friendly Nameplates but Hide Healthbar"],
								width = 'full',
								disabled = function() return (E.db.ElvUI_EltreumUI.nameplates.friendlynameplatetoggle.disablefriendly or E.db.ElvUI_EltreumUI.nameplates.friendlynameplatetoggle.hidefriendly) end,
								get = function() return E.db.ElvUI_EltreumUI.nameplates.friendlynameplatetoggle.friendlynames end,
								set = function(_, value) E.db.ElvUI_EltreumUI.nameplates.friendlynameplatetoggle.friendlynames = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							nofriendlyinstances = {
								order = 907,
								type = 'toggle',
								name = L["Hide Blizzard Friendly Nameplates inside Instances"],
								desc = L["Hide Blizzard Friendly Nameplates inside Instances"],
								width = 'full',
								disabled = function() return (E.db.ElvUI_EltreumUI.nameplates.friendlynameplatetoggle.friendlynames or E.db.ElvUI_EltreumUI.nameplates.friendlynameplatetoggle.hidefriendly) end,
								get = function() return E.db.ElvUI_EltreumUI.nameplates.friendlynameplatetoggle.disablefriendly end,
								set = function(_, value) E.db.ElvUI_EltreumUI.nameplates.friendlynameplatetoggle.disablefriendly = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							dontshowfriendlyatall = {
								order = 908,
								type = 'toggle',
								name = L["Hide Blizzard Friendly Nameplates everywhere"],
								desc = L["Hide Blizzard Friendly Nameplates everywhere"],
								width = 'full',
								disabled = function() return (E.db.ElvUI_EltreumUI.nameplates.friendlynameplatetoggle.friendlynames or E.db.ElvUI_EltreumUI.nameplates.friendlynameplatetoggle.disablefriendly) end,
								get = function() return E.db.ElvUI_EltreumUI.nameplates.friendlynameplatetoggle.hidefriendly end,
								set = function(_, value) E.db.ElvUI_EltreumUI.nameplates.friendlynameplatetoggle.hidefriendly = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							header33 = {
								order = 909,
								type = "description",
								name = L["Smart Classbar"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							classbarautohide = {
								order = 910,
								type = 'toggle',
								name = L["Enable Smart Classbar"],
								desc = L["Automatically hide the Classbar if the Target is Friendly, show if it is an enemy"],
								get = function() return E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.classbarautohide end,
								set = function(_, value) E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.classbarautohide = value end,
							},
							header3 = {
								order = 911,
								type = "description",
								name = L["Wide nameplate debuffs and buffs"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							verywidenameplate = {
								order = 912,
								type = 'toggle',
								name = L["Make Buffs and Debuffs Wide on Nameplates"],
								desc = L["Toggle On and Off"],
								width = 'full',
								get = function() return E.db.ElvUI_EltreumUI.nameplates.widenameplate.enable end,
								set = function(_, value) E.db.ElvUI_EltreumUI.nameplates.widenameplate.enable = value end,
							},
							headerhideswipe = {
								order = 913,
								type = 'description',
								name = L["Hide Cooldown Swipe"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							hidecdswipenp = {
								order = 914,
								type = 'toggle',
								name = L["Hide Cooldown Swipe on Buffs and Debuffs"],
								desc = L["Toggle On and Off"],
								width = 'full',
								get = function() return E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.hideSwipe end,
								set = function(_, value) E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.hideSwipe = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							headerhidenontarget = {
								order = 915,
								type = 'description',
								name = L["Hide Debuffs on Non Target"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							hidenontargetdebuffs = {
								order = 916,
								type = 'toggle',
								name = L["Hide Debuffs on Non Targeted Nameplates, show when Targeted"],
								desc = L["Toggle On and Off"],
								width = 'full',
								get = function() return E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.hidedebuffsnontarget end,
								set = function(_, value) E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.hidedebuffsnontarget = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							header4 = {
								order = 1911,
								type = "description",
								name = L["Enemy Nameplate Level"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							dynamiclevel = {
								order = 1912,
								type = 'toggle',
								name = L["Hide level on enemy nameplates when you are max level"],
								desc = L["Toggle On and Off"],
								width = 'full',
								get = function() return E.db.ElvUI_EltreumUI.nameplates.nameplatelevel end,
								set = function(_, value) E.db.ElvUI_EltreumUI.nameplates.nameplatelevel = value end,
							},
							header5 = {
								order = 1913,
								type = "description",
								name = L["Automatically Hide NPC Names"],
								width = 'full',
								hidden = not E.Retail,
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							hidenpcname = {
								order = 1914,
								type = 'toggle',
								name = L["Hide NPC Names when they are too far away to have Nameplates"],
								desc = L["Toggle On and Off"],
								width = 'full',
								hidden = not E.Retail,
								get = function() return E.db.ElvUI_EltreumUI.cvars.autohidenpcname end,
								set = function(_, value) E.db.ElvUI_EltreumUI.cvars.autohidenpcname = value end,
							},
							headerrested = {
								order = 1915,
								type = "description",
								name = L["Rested Nameplates"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							restednp = {
								order = 1916,
								type = 'toggle',
								name = L["Decrease Nameplate Overlap when Resting"],
								desc = L["Toggle On and Off"],
								width = 'full',
								get = function() return E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.restedoverlap end,
								set = function(_, value) E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.restedoverlap = value end,
							},
							headerrestore = {
								order = 1917,
								type = "description",
								name = L["Restore Hidden Names"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							restorenames = {
								order = 1918,
								type = 'execute',
								name = function()
									if E.Retail then
										return L["Restore Unit Names hidden by Hide NPC Names"]
									else
										return L["Restore Unit Names Hidden during install"]
									end
								end,
								width = 'full',
								desc = function()
									if E.Retail then
										return L["Use this button to restore names should you have disabled the Hide NPC Names option"]
									else
										return L["Use this button to restore names"]
									end
								end,
								func = function() ElvUI_EltreumUI:RestoreNameplateNames() end,
							},
							headerdebufffilter = {
								order = 1919,
								type = "description",
								name = "",
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							nameplaterefreshdebufffilter = {
								order = 1920,
								type = 'execute',
								name = L["Manage Debuff Style Filter"],
								width = 'full',
								desc = L["Add debuffs to the Style Filter to make Nameplates with expiring Debuffs show full alpha and scale"],
								disabled = function() return not E.global["nameplates"]["filters"]["EltreumRefreshDebuff"] end,
								func = function() local C, L = unpack(E.Config) C:StyleFilterSetConfig("EltreumRefreshDebuff") E.Libs.AceConfigDialog:SelectGroup('ElvUI', 'nameplates', "stylefilters", "triggers", "debuffs") end,
							},
						},
					},
					powerbar = {
						order = 2,
						type = 'group',
						name= L["Nameplate Power Bar"],
						args = {
							header5 = {
								order = 10,
								type = "description",
								name = "",
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							nameplatepower = {
								order = 11,
								type = 'group',
								inline = true,
								name = L["Nameplate Power Bar"],
								args = {
									enablepowerbar = {
										order = 1,
										type = 'toggle',
										name = L["Enable Nameplate Power Bar"],
										desc = L["Enable an extra Power Bar on Nameplates for missing powers"],
										width = 'full',
										get = function() return E.private.ElvUI_EltreumUI.nameplatepower.enable end,
										set = function(_, value) E.private.ElvUI_EltreumUI.nameplatepower.enable = value E:StaticPopup_Show('PRIVATE_RL') end,
									},
									enableadjust = {
										order = 2,
										type = 'toggle',
										name = L["Enable Auto-adjusting Buffs/Debuffs"],
										desc = L["Enable Auto-adjusting the position of Buffs/Debuffs"],
										width = 'full',
										disabled = function() return not E.private.ElvUI_EltreumUI.nameplatepower.enable end,
										get = function() return E.private.ElvUI_EltreumUI.nameplatepower.adjust end,
										set = function(_, value) E.private.ElvUI_EltreumUI.nameplatepower.adjust = value E:StaticPopup_Show('PRIVATE_RL') end,
									},
									header998747 = {
										order = 3,
										type = "description",
										name = L["Nameplate Powerbar Position"],
										width = 'full',
										image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
									},
									enableautoadjust = {
										order = 4,
										type = 'toggle',
										name = L["Enable Auto-adjusting the Vertical Position of the Power Bar"],
										desc = L["Power Bar will move automatically based on class/spec/druid form"],
										width = 'full',
										disabled = function() return not E.private.ElvUI_EltreumUI.nameplatepower.enable end,
										get = function() return E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition end,
										set = function(_, value) E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition = value end,
									},
									powerbarYoffset = {
										type = 'range',
										name = L["Select the Y Offset for the Power Bar (Default 16)"],
										desc = L["Set Y Offset"],
										order = 5,
										min = -100,
										max = 100,
										step = 0.1,
										width = "full",
										disabled = function() return E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition end,
										get = function() return E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy end,
										set = function(_, value) E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy = value end,
									},
									header98879 = {
										order = 6,
										type = "description",
										name = L["Nameplate Powerbar Size"],
										width = 'full',
										image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
									},
									powerbarsizeX = {
										type = 'range',
										name = L["Select the Horizontal Size of the Power Bar (Default 132)"],
										desc = L["Set Horizontal Size"],
										order = 7,
										min = 10,
										max = 300,
										step = 0.1,
										width = "full",
										disabled = function() return not E.private.ElvUI_EltreumUI.nameplatepower.enable end,
										get = function() return E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizex end,
										set = function(_, value) E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizex = value end,
									},
									powerbarsizeY = {
										type = 'range',
										name = L["Select the Vertical Size of the Power Bar (Default 6)"],
										desc = L["Set Vertical Size"],
										order = 8,
										min = 2,
										max = 20,
										step = 0.1,
										width = "full",
										disabled = function() return not E.private.ElvUI_EltreumUI.nameplatepower.enable end,
										get = function() return E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizey end,
										set = function(_, value) E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizey = value end,
									},
									header998 = {
										order = 9,
										type = "description",
										name = L["Nameplate Powerbar Appearance"],
										width = 'full',
										image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
									},
									nameplatepowerfont = {
										order = 10,
										type = 'select',
										-- width = "double",
										dialogControl = 'LSM30_Font',
										name = L["Font"],
										desc = L["Choose a font for the Nameplate Powerbar Text"],
										values = AceGUIWidgetLSMlists.font,
										get = function()
											return E.db.ElvUI_EltreumUI.nameplates.nameplatepower.font
										end,
										set = function(self,fontvalue)
											E.db.ElvUI_EltreumUI.nameplates.nameplatepower.font = fontvalue
										end,
									},
									nameplatepowerfontsize = {
										type = 'range',
										name = L["Font Size"],
										desc = L["Nameplate Powerbar Font Size"],
										order = 11,
										min = 8,
										max = 36,
										step = 1,
										--width = "double",
										get = function() return E.db.ElvUI_EltreumUI.nameplates.nameplatepower.fontsize end,
										set = function(_, value) E.db.ElvUI_EltreumUI.nameplates.nameplatepower.fontsize = tonumber(value) end,
									},
									powerbarbackgroundcolor = {
										order = 12,
										type = 'color',
										name = L["Background Color"],
										hasAlpha = true,
										disabled = function() return not E.private.ElvUI_EltreumUI.nameplatepower.enable end,
										get = function()
											local customcolorpowerbar = E.db.ElvUI_EltreumUI.nameplates.nameplatepower
											local d = P.ElvUI_EltreumUI.nameplates.nameplatepower
											return customcolorpowerbar.r, customcolorpowerbar.g, customcolorpowerbar.b, customcolorpowerbar.a, d.r, d.g, d.b, d.a
										end,
										set = function(_, r, g, b, a)
											local customcolorpowerbar = E.db.ElvUI_EltreumUI.nameplates.nameplatepower
											customcolorpowerbar.r, customcolorpowerbar.g, customcolorpowerbar.b, customcolorpowerbar.a = r, g, b, a
										end,
									},
									sharedmediatexture = {
										order = 13,
										type = 'select',
										--width = "double",
										dialogControl = 'LSM30_Statusbar',
										name = L["Choose the Power Bar Texture"],
										desc = L["Select a Texture"],
										values = AceGUIWidgetLSMlists.statusbar,
										disabled = function() return not E.private.ElvUI_EltreumUI.nameplatepower.enable end,
										get = function() return E.db.ElvUI_EltreumUI.nameplates.nameplatepower.texture end,
										set = function(self,key) E.db.ElvUI_EltreumUI.nameplates.nameplatepower.texture = key end,
									},
									modeleffect = {
										type = 'toggle',
										name = L["Effect"],
										desc = L["Add an Effect"],
										order = 14,
										disabled = function() return not E.private.ElvUI_EltreumUI.nameplatepower.enable end,
										get = function() return E.db.ElvUI_EltreumUI.nameplates.nameplatepower.modeleffect end,
										set = function(_, value) E.db.ElvUI_EltreumUI.nameplates.nameplatepower.modeleffect = value end,
									},
									powerbargradient = {
										type = 'toggle',
										name = L["Gradient"],
										desc = L["Gradient Colors"],
										order = 15,
										disabled = function() return not E.private.ElvUI_EltreumUI.nameplatepower.enable end,
										get = function() return E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient end,
										set = function(_, value) E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient = value end,
									},
									opengradientcolors = {
										order = 16,
										type = 'execute',
										name = L["Colors"],
										width = 'full',
										desc = L["Customize Colors"],
										func = function()
											if not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable then
												E.Libs.AceConfigDialog:SelectGroup('ElvUI', 'unitframe','allColorsGroup','classResourceGroup')
											else
												E.Libs.AceConfigDialog:SelectGroup('ElvUI', 'ElvUI_EltreumUI', "gradient", "power")
											end
										end,
									},
									header9987 = {
										order = 101,
										type = "description",
										name = "",
										width = 'full',
										image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
									},
									describethis = {
										order = 102,
										type = "description",
										name = L["Select the power types to be displayed:"],
									},
									addagapforspace8 = {
										order = 103,
										type = "description",
										name = "",
									},
									mana = {
										type = 'toggle',
										name = MANA,
										order = 104,
										disabled = function() return not E.private.ElvUI_EltreumUI.nameplatepower.enable end,
										get = function() return E.private.ElvUI_EltreumUI.nameplatepower.mana end,
										set = function(_, value) E.private.ElvUI_EltreumUI.nameplatepower.mana = value E:StaticPopup_Show('PRIVATE_RL') end,
									},
									rage = {
										type = 'toggle',
										name = RAGE,
										order = 104,
										disabled = function() return not E.private.ElvUI_EltreumUI.nameplatepower.enable end,
										get = function() return E.private.ElvUI_EltreumUI.nameplatepower.rage end,
										set = function(_, value) E.private.ElvUI_EltreumUI.nameplatepower.rage = value E:StaticPopup_Show('PRIVATE_RL') end,
									},
									energy = {
										type = 'toggle',
										name = ENERGY,
										order = 104,
										disabled = function() return not E.private.ElvUI_EltreumUI.nameplatepower.enable end,
										get = function() return E.private.ElvUI_EltreumUI.nameplatepower.energy end,
										set = function(_, value) E.private.ElvUI_EltreumUI.nameplatepower.energy = value E:StaticPopup_Show('PRIVATE_RL') end,
									},
									astral = {
										type = 'toggle',
										name = POWER_TYPE_LUNAR_POWER,
										order = 104,
										hidden = not E.Retail,
										disabled = function() return not E.private.ElvUI_EltreumUI.nameplatepower.enable end,
										get = function() return E.private.ElvUI_EltreumUI.nameplatepower.astral end,
										set = function(_, value) E.private.ElvUI_EltreumUI.nameplatepower.astral = value E:StaticPopup_Show('PRIVATE_RL') end,
									},
									runic = {
										type = 'toggle',
										name = function()
											if not E.Classic then
												return RUNIC_POWER
											else
												return "Runic Power"
											end
										end,
										order = 104,
										hidden = not E.Retail and not E.Wrath,
										disabled = function() return not E.private.ElvUI_EltreumUI.nameplatepower.enable end,
										get = function() return E.private.ElvUI_EltreumUI.nameplatepower.runic end,
										set = function(_, value) E.private.ElvUI_EltreumUI.nameplatepower.runic = value E:StaticPopup_Show('PRIVATE_RL') end,
									},
									insanity = {
										type = 'toggle',
										name = INSANITY_POWER,
										order = 104,
										hidden = not E.Retail,
										disabled = function() return not E.private.ElvUI_EltreumUI.nameplatepower.enable end,
										get = function() return E.private.ElvUI_EltreumUI.nameplatepower.insanity end,
										set = function(_, value) E.private.ElvUI_EltreumUI.nameplatepower.insanity = value E:StaticPopup_Show('PRIVATE_RL') end,
									},
									maelstrom = {
										type = 'toggle',
										name = POWER_TYPE_MAELSTROM,
										order = 104,
										hidden = not E.Retail,
										disabled = function() return not E.private.ElvUI_EltreumUI.nameplatepower.enable end,
										get = function() return E.private.ElvUI_EltreumUI.nameplatepower.maelstrom end,
										set = function(_, value) E.private.ElvUI_EltreumUI.nameplatepower.maelstrom = value E:StaticPopup_Show('PRIVATE_RL') end,
									},
									fury = {
										type = 'toggle',
										name = POWER_TYPE_FURY,
										order = 104,
										hidden = not E.Retail,
										disabled = function() return not E.private.ElvUI_EltreumUI.nameplatepower.enable end,
										get = function() return E.private.ElvUI_EltreumUI.nameplatepower.fury end,
										set = function(_, value) E.private.ElvUI_EltreumUI.nameplatepower.fury = value E:StaticPopup_Show('PRIVATE_RL') end,
									},
									focus = {
										type = 'toggle',
										name = POWER_TYPE_FOCUS,
										order = 104,
										hidden = not E.Retail,
										disabled = function() return not E.private.ElvUI_EltreumUI.nameplatepower.enable end,
										get = function() return E.private.ElvUI_EltreumUI.nameplatepower.focus end,
										set = function(_, value) E.private.ElvUI_EltreumUI.nameplatepower.focus = value E:StaticPopup_Show('PRIVATE_RL') end,
									},
								}
							},
						},
					},
					gradientnp = {
						order = 3,
						type = 'group',
						name = L["Gradient"],
						args = {
							header = {
								order = 1,
								type = "description",
								name = L["Gradient Colors"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							enablegradientnp = {
								order = 2,
								type = 'toggle',
								name = L["Enable Gradient Nameplates"],
								desc = L["Enable Gradient colors for Nameplates. |cffFF0000WARNING:|r This will overwrite some default ElvUI NP settings, if you dont want this, please disable this feature."],
								width = 'full',
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable = value end,
							},
							enablecustomcolornp = {
								order = 3,
								type = 'toggle',
								name = L["Custom Color"],
								desc = L["Enable Custom Colors"],
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor = value ElvUI_EltreumUI:GradientColorTableUpdate() end,
							},
							opengradientcolors = {
								order = 4,
								type = 'execute',
								name = L["Colors"],
								width = 'full',
								desc = L["Customize Colors"],
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable end,
								func = function() E.Libs.AceConfigDialog:SelectGroup('ElvUI', 'ElvUI_EltreumUI', "gradient") end,
							},
							gradientorientation = {
								type = 'select',
								name = L["Gradient Orientation"],
								desc = L["Choose the direction of the gradient"],
								order = 10,
								values = {
									["HORIZONTAL"] = L["Horizontal"],
									["VERTICAL"] = L["Vertical"],
								},
								style = 'radio',
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation = value E:StaticPopup_Show('CONFIG_RL') end,
							},
						},
					},
					model = {
						order = 3,
						type = 'group',
						name = L["Target Model"],
						args = {
							targetmodel = {
								order = 895,
								type = "description",
								name= L["Target Model"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							enabletargetmodel = {
								order = 896,
								type = 'toggle',
								name = L["Enable Target Model"],
								desc = L["Shows the target's model on the target nameplate"],
								--width = 'double',
								get = function() return E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.targetmodel end,
								set = function(_, value) E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.targetmodel = value end,
							},
							enabletargetmodelpause = {
								order = 897,
								type = 'toggle',
								name = L["Pause"],
								--width = 'double',
								disabled = function() return not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.targetmodel end,
								get = function() return E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.paused end,
								set = function(_, value) E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.paused = value end,
							},
							modelgap = {
								order = 898,
								type = "description",
								name = "",
								--width = 'double',
							},
							enabletargetmodelCamDistance = {
								type = 'range',
								name = L["Camera Distance Scale"],
								order = 899,
								min = 0.01,
								max = 10,
								step = 0.01,
								--width = "double",
								disabled = function() return not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.targetmodel end,
								get = function() return E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.CamDistanceScale end,
								set = function(_, value) E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.CamDistanceScale = value end,
							},
							enabletargetmodelViewTranslationx = {
								type = 'range',
								name = L["X-Offset"],
								order = 900,
								min = -1,
								max = 1,
								step = 0.01,
								--width = "double",
								disabled = function() return not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.targetmodel end,
								get = function() return E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.ViewTranslationx end,
								set = function(_, value) E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.ViewTranslationx = value end,
							},
							enabletargetmodelViewTranslationy = {
								type = 'range',
								name = L["Y-Offset"],
								order = 901,
								min = -1,
								max = 1,
								step = 0.01,
								--width = "double",
								disabled = function() return not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.targetmodel end,
								get = function() return E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.ViewTranslationy end,
								set = function(_, value) E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.ViewTranslationy = value end,
							},
							enabletargetmodelRotation = {
								type = 'range',
								name = L["Model Rotation"],
								order = 902,
								min = 0,
								max = 360,
								step = 0.1,
								--width = "double",
								disabled = function() return not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.targetmodel end,
								get = function() return E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.Rotation end,
								set = function(_, value) E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.Rotation = value end,
							},
							enabletargetmodelalpha = {
								type = 'range',
								name = L["Model Alpha"],
								order = 903,
								min = 0,
								max = 1,
								step = 0.1,
								--width = "double",
								disabled = function() return not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.targetmodel end,
								get = function() return E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.modelalpha end,
								set = function(_, value) E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.modelalpha = value end,
							},
							enabletargetmodelDesaturate = {
								type = 'range',
								name = L["Desaturate"],
								order = 904,
								min = 0,
								max = 1,
								step = 0.1,
								--width = "double",
								disabled = function() return not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.targetmodel end,
								get = function() return E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.desaturation end,
								set = function(_, value) E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.desaturation = value end,
							},
						},
					},
				},
			},
			partyraidsettings = {
				type = 'group',
				name = L["Party/Raid"],
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\party',
				order = 85,
				args = {
					headergap1 = {
						order = 1,
						type = "description",
						name = L["Play a sound when someone dies in Party or Raid"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					enablesound = {
						type = 'toggle',
						name = L["Enable"],
						width = "full",
						order = 6,
						get = function() return E.db.ElvUI_EltreumUI.otherstuff.partyraiddeath.enable end,
						set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.partyraiddeath.enable = value end,
					},
					disablebgs = {
						type = 'toggle',
						name = L["Disable in Battlegrounds/Arenas"],
						width = "full",
						order = 7,
						disabled = function() return not E.db.ElvUI_EltreumUI.otherstuff.partyraiddeath.enable end,
						get = function() return E.db.ElvUI_EltreumUI.otherstuff.partyraiddeath.bgdisable end,
						set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.partyraiddeath.bgdisable = value end,
					},
					sharedmediasound = {
						order = 8,
						type = 'select',
						width = "double",
						dialogControl = 'LSM30_Sound',
						name = L["Select a Sound"],
						desc = L["Choose a Sound from SharedMedia files"],
						values = AceGUIWidgetLSMlists.sound,
						get = function() return E.db.ElvUI_EltreumUI.otherstuff.partyraiddeath.playerdeathsound end,
						disabled = function() return not E.db.ElvUI_EltreumUI.otherstuff.partyraiddeath.enable end,
						set = function(self,key) E.db.ElvUI_EltreumUI.otherstuff.partyraiddeath.playerdeathsound = key E:StaticPopup_Show('CONFIG_RL') end,
					},
					header52 = {
						order = 9,
						type = "description",
						name = "",
						width = 'full',
						hidden = not E.Retail,
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					bresenable = {
						order = 10,
						type = "toggle",
						name = L["Show a Battle Resurrection Count and Cooldown Frame"],
						desc = L["Enables a frame that shows a cooldown and count for battle ressurections while in an instance that has them"],
						width = 'full',
						hidden = not E.Retail,
						get = function() return E.db.ElvUI_EltreumUI.otherstuff.bres end,
						set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.bres = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					layoutdescriptiongap2 = {
						order = 13,
						type = 'description',
						name = "",
						width = "full",
					},
					headergapisntances = {
						order = 13,
						type = "description",
						name = L["Instance Texts"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					instancetextenable = {
						type = 'toggle',
						name = L["Enable"],
						width = "full",
						order = 14,
						get = function() return E.db.ElvUI_EltreumUI.skins.instances.enable end,
						set = function(_, value) E.db.ElvUI_EltreumUI.skins.instances.enable = value end,
					},
					instancecolor = {
						order = 15,
						type = 'color',
						name = L["Instance Text Color"],
						hasAlpha = false,
						width = "full",
						disabled = function() return (not E.db.ElvUI_EltreumUI.skins.instances.enable) end,
						get = function() return E.db.ElvUI_EltreumUI.skins.instances.r, E.db.ElvUI_EltreumUI.skins.instances.g, E.db.ElvUI_EltreumUI.skins.instances.b, 1, P.ElvUI_EltreumUI.skins.instances.r, P.ElvUI_EltreumUI.skins.instances.g, P.ElvUI_EltreumUI.skins.instances.b, 1 end,
						set = function(_, r, g, b, a) E.db.ElvUI_EltreumUI.skins.instances.r, E.db.ElvUI_EltreumUI.skins.instances.g, E.db.ElvUI_EltreumUI.skins.instances.b = r, g, b end,
					},
					instancefontsize = {
						type = 'range',
						name = L["Font Size"],
						desc = L["Instance text Font Size"],
						order = 16,
						min = 4,
						max = 72,
						step = 1,
						width = "double",
						disabled = function() return (not E.db.ElvUI_EltreumUI.skins.instances.enable) end,
						get = function() return E.db.ElvUI_EltreumUI.skins.instances.fontsize end,
						set = function(_, value) E.db.ElvUI_EltreumUI.skins.instances.fontsize = tonumber(value) end,
					},
					headergapisntance2 = {
						order = 17,
						type = "description",
						name = COMBAT_LOG,
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					instancetextenable = {
						type = 'toggle',
						name = L["Enable Automatic Combat Log"],
						width = "full",
						order = 18,
						get = function() return E.db.ElvUI_EltreumUI.cvars.combatlog end,
						set = function(_, value) E.db.ElvUI_EltreumUI.cvars.combatlog = value end,
					},
					headergapisntance3 = {
						order = 79,
						type = "description",
						name = "",
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					DungeonNormal = {
						order = 80,
						type = 'input',
						name = L["Dungeon"],
						desc = L["The text displayed when in a normal dungeon"],
						--width = 'double',
						disabled = function() return (not E.db.ElvUI_EltreumUI.skins.instances.enable) end,
						get = function() return E.db.ElvUI_EltreumUI.skins.instances.DungeonNormal end,
						set = function(_, value) E.db.ElvUI_EltreumUI.skins.instances.DungeonNormal = tostring(value) E:StaticPopup_Show('PRIVATE_RL') end,
					},
					DungeonHeroic = {
						order = 80,
						type = 'input',
						name = L["Dungeon (Heroic)"],
						desc = L["The text displayed when in a heroic dungeon"],
						--width = 'double',
						hidden = E.Classic,
						disabled = function() return (not E.db.ElvUI_EltreumUI.skins.instances.enable) end,
						get = function() return E.db.ElvUI_EltreumUI.skins.instances.DungeonHeroic end,
						set = function(_, value) E.db.ElvUI_EltreumUI.skins.instances.DungeonHeroic = tostring(value) E:StaticPopup_Show('PRIVATE_RL') end,
					},
					DungeonTimwalking = {
						order = 80,
						type = 'input',
						name = L["Dungeon (Timewalking)"],
						desc = L["The text displayed when in a timewalking dungeon"],
						--width = 'double',
						hidden = not E.Retail,
						disabled = function() return (not E.db.ElvUI_EltreumUI.skins.instances.enable) end,
						get = function() return E.db.ElvUI_EltreumUI.skins.instances.DungeonTimewalker end,
						set = function(_, value) E.db.ElvUI_EltreumUI.skins.instances.DungeonTimewalker = tostring(value) E:StaticPopup_Show('PRIVATE_RL') end,
					},
					DungeonMzero = {
						order = 80,
						type = 'input',
						name = L["Dungeon (Mythic)"],
						desc = L["The text displayed when in a mythic dungeon"],
						--width = 'double',
						hidden = not E.Retail,
						disabled = function() return (not E.db.ElvUI_EltreumUI.skins.instances.enable) end,
						get = function() return E.db.ElvUI_EltreumUI.skins.instances.DungeonMythic end,
						set = function(_, value) E.db.ElvUI_EltreumUI.skins.instances.DungeonMythic = tostring(value) E:StaticPopup_Show('PRIVATE_RL') end,
					},
					DungeonMplus = {
						order = 80,
						type = 'input',
						name = L["Dungeon (Mythic Plus)"],
						desc = L["The text displayed when in a mythic plus dungeon"],
						--width = 'double',
						hidden = not E.Retail,
						disabled = function() return (not E.db.ElvUI_EltreumUI.skins.instances.enable) end,
						get = function() return E.db.ElvUI_EltreumUI.skins.instances.DungeonMythicPlus end,
						set = function(_, value) E.db.ElvUI_EltreumUI.skins.instances.DungeonMythicPlus = tostring(value) E:StaticPopup_Show('PRIVATE_RL') end,
					},
					Raid = {
						order = 80,
						type = 'input',
						name = L["Raid (Normal)"],
						desc = L["The text displayed when in a normal raid"],
						--width = 'double',
						disabled = function() return (not E.db.ElvUI_EltreumUI.skins.instances.enable) end,
						get = function() return E.db.ElvUI_EltreumUI.skins.instances.Raid end,
						set = function(_, value) E.db.ElvUI_EltreumUI.skins.instances.Raid = tostring(value) E:StaticPopup_Show('PRIVATE_RL') end,
					},
					Raid10 = {
						order = 80,
						type = 'input',
						name = L["Raid (Normal)"].." 10",
						desc = L["The text displayed when in a normal raid"],
						--width = 'double',
						disabled = function() return (not E.db.ElvUI_EltreumUI.skins.instances.enable) end,
						get = function() return E.db.ElvUI_EltreumUI.skins.instances.Raid10 end,
						set = function(_, value) E.db.ElvUI_EltreumUI.skins.instances.Raid10 = tostring(value) E:StaticPopup_Show('PRIVATE_RL') end,
					},
					Raid25 = {
						order = 80,
						type = 'input',
						name = L["Raid (Normal)"].." 25",
						desc = L["The text displayed when in a normal raid"],
						--width = 'double',
						disabled = function() return (not E.db.ElvUI_EltreumUI.skins.instances.enable) end,
						get = function() return E.db.ElvUI_EltreumUI.skins.instances.Raid25 end,
						set = function(_, value) E.db.ElvUI_EltreumUI.skins.instances.Raid25 = tostring(value) E:StaticPopup_Show('PRIVATE_RL') end,
					},
					RaidHeroic = {
						order = 80,
						type = 'input',
						name = L["Raid (Heroic)"],
						desc = L["The text displayed when in a heroic raid"],
						--width = 'double',
						hidden = E.Classic or E.Wrath,
						disabled = function() return (not E.db.ElvUI_EltreumUI.skins.instances.enable) end,
						get = function() return E.db.ElvUI_EltreumUI.skins.instances.RaidHeroic end,
						set = function(_, value) E.db.ElvUI_EltreumUI.skins.instances.RaidHeroic = tostring(value) E:StaticPopup_Show('PRIVATE_RL') end,
					},
					RaidHeroic25 = {
						order = 80,
						type = 'input',
						name = L["Raid (Heroic)"].." 25",
						desc = L["The text displayed when in a heroic raid"],
						--width = 'double',
						hidden = E.Classic or E.Retail,
						disabled = function() return (not E.db.ElvUI_EltreumUI.skins.instances.enable) end,
						get = function() return E.db.ElvUI_EltreumUI.skins.instances.Raid25Heroic end,
						set = function(_, value) E.db.ElvUI_EltreumUI.skins.instances.Raid25Heroic = tostring(value) E:StaticPopup_Show('PRIVATE_RL') end,
					},
					RaidHeroic10 = {
						order = 80,
						type = 'input',
						name = L["Raid (Heroic)"].." 10",
						desc = L["The text displayed when in a heroic raid"],
						--width = 'double',
						hidden = E.Classic or E.Retail,
						disabled = function() return (not E.db.ElvUI_EltreumUI.skins.instances.enable) end,
						get = function() return E.db.ElvUI_EltreumUI.skins.instances.Raid10Heroic end,
						set = function(_, value) E.db.ElvUI_EltreumUI.skins.instances.Raid10Heroic = tostring(value) E:StaticPopup_Show('PRIVATE_RL') end,
					},
					RaidLFR = {
						order = 80,
						type = 'input',
						name = L["Raid (LFR)"],
						desc = L["The text displayed when in a lfr raid"],
						--width = 'double',
						hidden = not E.Retail,
						disabled = function() return (not E.db.ElvUI_EltreumUI.skins.instances.enable) end,
						get = function() return E.db.ElvUI_EltreumUI.skins.instances.RaidLFR end,
						set = function(_, value) E.db.ElvUI_EltreumUI.skins.instances.RaidLFR = tostring(value) E:StaticPopup_Show('PRIVATE_RL') end,
					},
					RaidMythic = {
						order = 80,
						type = 'input',
						name = L["Raid (Mythic)"],
						desc = L["The text displayed when in a mythic raid"],
						--width = 'double',
						hidden = not E.Retail,
						disabled = function() return (not E.db.ElvUI_EltreumUI.skins.instances.enable) end,
						get = function() return E.db.ElvUI_EltreumUI.skins.instances.MythicRaid end,
						set = function(_, value) E.db.ElvUI_EltreumUI.skins.instances.MythicRaid = tostring(value) E:StaticPopup_Show('PRIVATE_RL') end,
					},
					RaidTimewalking = {
						order = 80,
						type = 'input',
						name = L["Raid (Timewalking)"],
						desc = L["The text displayed when in a timewalking raid"],
						--width = 'double',
						hidden = not E.Retail,
						disabled = function() return (not E.db.ElvUI_EltreumUI.skins.instances.enable) end,
						get = function() return E.db.ElvUI_EltreumUI.skins.instances.RaidTimewalker end,
						set = function(_, value) E.db.ElvUI_EltreumUI.skins.instances.RaidTimewalker = tostring(value) E:StaticPopup_Show('PRIVATE_RL') end,
					},
					Guild = {
						order = 80,
						type = 'input',
						name = L["Guild"],
						desc = L["The text displayed when in a guild group"],
						--width = 'double',
						hidden = not E.Retail,
						disabled = function() return (not E.db.ElvUI_EltreumUI.skins.instances.enable) end,
						get = function() return E.db.ElvUI_EltreumUI.skins.instances.guild end,
						set = function(_, value) E.db.ElvUI_EltreumUI.skins.instances.guild = tostring(value) E:StaticPopup_Show('PRIVATE_RL') end,
					},
				},
			},
			quests = {
				type = 'group',
				name = QUESTS_LABEL,
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\quest',
				order = 85,
				args = {
					headergaphere112 = {
						order = 1,
						type = "description",
						name = "",
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					autoaccept = {
						order = 2,
						type = 'toggle',
						name = L["Enable Automatically accepting/turning in Quests when not holding CTRL/SHIFT/ALT"],
						desc = L["You will automatically accept and turn in quests that do not require gold, are not weekly and are not daily"],
						width = 'full',
						get = function() return E.db.ElvUI_EltreumUI.quests.autoaccept end,
						set = function(_, value) E.db.ElvUI_EltreumUI.quests.autoaccept = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					autoacceptdailyweekly = {
						order = 3,
						type = 'toggle',
						name = L["Accept Daily and Weekly quests"],
						desc = L["You will also automatically accept Daily and Weekly Quests"],
						width = 'full',
						get = function() return E.db.ElvUI_EltreumUI.quests.acceptdaily end,
						set = function(_, value) E.db.ElvUI_EltreumUI.quests.acceptdaily = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					autoacceptinvert = {
						order = 3,
						type = 'toggle',
						name = L["Invert CTRL/SHIFT/ALT"],
						desc = L["You will only accept and turn in quests if you hold CTRL/SHIFT/ALT while talking to the NPC"],
						width = 'full',
						get = function() return E.db.ElvUI_EltreumUI.quests.autoacceptinvert end,
						set = function(_, value) E.db.ElvUI_EltreumUI.quests.autoacceptinvert = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					headergaphereitembar = {
						order = 4,
						type = "description",
						name = L["Quest Item Bar"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					questitembar = {
						order = 5,
						type = 'toggle',
						name = L["Enable Quest Item Bar"],
						desc = L["Add a Quest Item bar, keybind can be changed in Keybinds > ElvUI Eltruism"],
						width = 'full',
						get = function() return E.db.ElvUI_EltreumUI.quests.questitems end,
						set = function(_, value) E.db.ElvUI_EltreumUI.quests.questitems = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					questitembarab1 = {
						order = 6,
						type = 'toggle',
						name = L["Quest Item Bar follows visibility settings for ElvUI Action Bar 1"],
						desc = L["The Quest Item Bar will appear only when ElvUI Action Bar 1 appears, following its settings"],
						width = 'full',
						disabled = function() return (not E.db.ElvUI_EltreumUI.quests.questitems) or E.db.ElvUI_EltreumUI.quests.questitemsfade end,
						get = function() return E.db.ElvUI_EltreumUI.quests.questitemsbar1 end,
						set = function(_, value) E.db.ElvUI_EltreumUI.quests.questitemsbar1 = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					questitembarmouseover = {
						order = 7,
						type = 'toggle',
						name = L["Quest Item Bar Button Mouse Over"],
						desc = L["Each Button in the Quest Item Bar will appear only if the cursor is over it"],
						width = 'full',
						disabled = function() return (not E.db.ElvUI_EltreumUI.quests.questitems) or E.db.ElvUI_EltreumUI.quests.questitemsbar1 end,
						get = function() return E.db.ElvUI_EltreumUI.quests.questitemsfade end,
						set = function(_, value) E.db.ElvUI_EltreumUI.quests.questitemsfade = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					questiconsizes = {
						order = 8,
						type = "description",
						name = L["Quest Item Bar Button Size"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					questitemsbarsizex = {
						type = 'range',
						name = L["Width"],
						desc = L["Change the size of the button on the Quest Item Bar"],
						order = 9,
						min = 10,
						max = 100,
						step = 1,
						width = "double",
						disabled = function() return not E.db.ElvUI_EltreumUI.quests.questitems end,
						get = function() return E.db.ElvUI_EltreumUI.quests.questitemsize end,
						set = function(_, value) E.db.ElvUI_EltreumUI.quests.questitemsize = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					questitemsbarsizey = {
						type = 'range',
						name = L["Height"],
						desc = L["Change the size of the button on the Quest Item Bar"],
						order = 9,
						min = 10,
						max = 100,
						step = 1,
						width = "double",
						disabled = function() return not E.db.ElvUI_EltreumUI.quests.questitems end,
						get = function() return E.db.ElvUI_EltreumUI.quests.questitemsizey end,
						set = function(_, value) E.db.ElvUI_EltreumUI.quests.questitemsizey = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					questitemspacing = {
						type = 'range',
						name = L["Button Spacing"],
						desc = L["The spacing between buttons."],
						order = 10,
						min = 0,
						max = 20,
						step = 1,
						width = "double",
						disabled = function() return not E.db.ElvUI_EltreumUI.quests.questitems end,
						get = function() return E.db.ElvUI_EltreumUI.quests.questitemspacing end,
						set = function(_, value) E.db.ElvUI_EltreumUI.quests.questitemspacing = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					setorientation = {
						type = 'select',
						name = L["Bar Direction"],
						order = 12,
						values = {
							["HORIZONTAL"] = L["Horizontal"],
							["VERTICAL"] = L["Vertical"],
						},
						style = 'radio',
						disabled = function() return not E.db.ElvUI_EltreumUI.quests.questitems end,
						get = function() return E.db.ElvUI_EltreumUI.quests.questorientation end,
						set = function(_, value) E.db.ElvUI_EltreumUI.quests.questorientation = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					headergaphere9487 = {
						order = 95,
						type = "description",
						name = "",
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					questsettings = {
						order = 96,
						type = 'toggle',
						name = L["Collapse Quests during Encounters/Boss Fights"],
						desc = L["Collapse Quests when the boss fight starts"],
						width = 'full',
						get = function() return E.db.ElvUI_EltreumUI.quests.enable end,
						set = function(_, value) E.db.ElvUI_EltreumUI.quests.enable = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					headergaphere2 = {
						order = 97,
						type = "description",
						name = "",
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					questcombatsettings = {
						order = 98,
						type = 'toggle',
						name = L["Collapse Quests during any combat event"],
						desc = L["Collapse Quests when you enter combat"],
						width = 'full',
						get = function() return E.db.ElvUI_EltreumUI.quests.combatenable end,
						set = function(_, value) E.db.ElvUI_EltreumUI.quests.combatenable = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					headergaphere3 = {
						order = 99,
						type = "description",
						name = "",
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					arenaquestsettings = {
						order = 100,
						type = 'toggle',
						width = 'full',
						name = L["Hide Quests during Battlegrounds and Arenas"],
						desc = L["Hide Quests during Battlegrounds and Arenas"],
						get = function() return E.db.ElvUI_EltreumUI.quests.arena end,
						set = function(_, value) E.db.ElvUI_EltreumUI.quests.arena = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					headergaphere4 = {
						order = 101,
						type = "description",
						name = "",
						width = 'full',
						hidden = not E.Retail,
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					objectiveanchor = {
						order = 102,
						type = 'toggle',
						width = 'full',
						name = E.NewSign..L["Objective Frame Anchor"],
						desc = L["Reactivate the ElvUI Objective Frame Anchor and Mover"],
						hidden = not E.Retail,
						get = function() return E.db.ElvUI_EltreumUI.quests.anchor end,
						set = function(_, value) E.db.ElvUI_EltreumUI.quests.anchor = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					objectiveheight = {
						type = 'range',
						name = E.NewSign..L["Objective Frame Height"],
						desc = L["Height of the objective tracker. Increase size to be able to see more objectives."],
						order = 103,
						min = 100,
						max = 900,
						step = 1,
						width = "double",
						hidden = not E.Retail,
						disabled = function() return not E.db.ElvUI_EltreumUI.quests.anchor end,
						get = function()
							if ObjectiveTrackerFrame then
								return ObjectiveTrackerFrame.editModeHeight
							else
								return 1
							end
						end,
						set = function(_, value)
							if ObjectiveTrackerFrame then
								E.db.ElvUI_EltreumUI.skins.questsettings.objectiveFrameHeight = value
								ObjectiveTrackerFrame.editModeHeight = value
								Enum.EditModeObjectiveTrackerSetting.Height = value
								ObjectiveTrackerFrame:SetHeight(value)
								ObjectiveTracker_UpdateHeight()
							end
						end,
					},
				},
			},
			skins = {
				order = 85,
				type = 'group',
				name = L["Skins"],
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\paint',
				childGroups = "tab",
				args = {
					general = {
						type = 'group',
						name = L["General"],
						order = 1,
						args = {
							header11 = {
								order = 1,
								type = "description",
								name = "",
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							zonetext = {
								order = 2,
								type = "description",
								name = L["Make more texts use ElvUI font settings"],
								width = 'full',
							},
							errorenable = {
								order = 3,
								name = L["Enable for Error Frame"],
								type = "toggle",
								desc = L["Enable for Error Frame"],
								width = 'full',
								get = function() return E.db.ElvUI_EltreumUI.skins.blizzframes.errorframe end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.blizzframes.errorframe = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							errorsize = {
								type = 'range',
								name = L["Error Frame Font Size"],
								desc = L["Error Frame Font Size"],
								order = 4,
								min = 8,
								max = 36,
								step = 1,
								width = "double",
								get = function() return E.db.ElvUI_EltreumUI.skins.blizzframes.errorframefontsize end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.blizzframes.errorframefontsize = tonumber(value) E:StaticPopup_Show('CONFIG_RL') end,
							},
							zoneenable = {
								order = 34,
								name = L["Enable for Zones, Mail and others"],
								type = "toggle",
								desc = L["Such as the Zones, Mail and others"],
								width = 'full',
								get = function() return E.db.ElvUI_EltreumUI.skins.zones end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.zones = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							headerhideblizz = {
								order = 35,
								type = "description",
								name = L["Hide Blizzard Frames"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							hideerrorframe = {
								order = 36,
								name = L["Hide Error Frame"],
								type = "toggle",
								desc = L["Hide the Red Error Text"],
								width = 'full',
								get = function() return E.db.ElvUI_EltreumUI.skins.blizzframes.hideerrorframe end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.blizzframes.hideerrorframe = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							hidezonetext = {
								order = 36,
								name = L["Hide Zone Text"],
								type = "toggle",
								desc = L["Hide the text that appears when changing zones"],
								width = 'full',
								get = function() return E.db.ElvUI_EltreumUI.skins.blizzframes.hidezone end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.blizzframes.hidezone = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							hidealertframe = {
								order = 36,
								name = L["Hide Alert Frame"],
								desc = L["Hide the Alert Frame that appears when looting a rare item or earning an achievement"],
								type = "toggle",
								width = 'full',
								get = function() return E.db.ElvUI_EltreumUI.skins.blizzframes.hidealert end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.blizzframes.hidealert = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							hidebossbannerframe = {
								order = 36,
								name = L["Hide Boss Banner Frame"],
								desc = L["Hide the boss banner that appears when killing a raid boss or completing a Mythic+ dungeon"],
								type = "toggle",
								width = 'full',
								hidden = not E.Retail,
								get = function() return E.db.ElvUI_EltreumUI.skins.blizzframes.hideboss end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.blizzframes.hideboss = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							professionskins = {
								order = 37,
								type = "description",
								name = L["Skin Profession Frame"],
								--hidden = E.Retail,
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
								width = 'full',
							},
							professionenable = {
								order = 38,
								name = L["Enable"],
								type = "toggle",
								desc = L["Skin the Profession/Tradeskill Frame"],
								--hidden = E.Retail,
								--width = 'full',
								get = function() return E.db.ElvUI_EltreumUI.skins.professions end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.professions = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							professionscale = {
								type = 'range',
								name = E.NewSign..L["Scale"],
								hidden = not E.Retail,
								order = 38,
								min = 0.2,
								max = 1.3,
								step = 0.01,
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.professions end,
								get = function() return E.db.ElvUI_EltreumUI.skins.professionscale end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.professionscale = value _G.ProfessionsFrame:SetScale(value) end,
							},
							header64546 = {
								order = 39,
								type = "description",
								name = L["Add a Level Up toast"],
								hidden = E.Retail,
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							skinenable = {
								order = 40,
								type = 'toggle',
								name = L["Enable"],
								desc = L["Enable a toast showing up when you level up"],
								hidden = E.Retail,
								get = function() return E.db.ElvUI_EltreumUI.skins.levelbossinstance end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.levelbossinstance = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							levelBosskins = {
								order = 41,
								type = "description",
								hidden = not E.Retail,
								name = L["Skin Level Up, Boss Loot and Instance Entrance frames to be class colored"],
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
								width = "full",
							},
							skinenableboss = {
								order = 42,
								type = 'toggle',
								name = L["Enable"],
								hidden = not E.Retail,
								desc = L["Enable the Skins"],
								get = function() return E.db.ElvUI_EltreumUI.skins.levelbossinstance end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.levelbossinstance = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							tbctalentinfo = {
								order = 43,
								type = "description",
								name = L["Expand the Talents to show the entire tree"],
								hidden = E.Retail,
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
								width = "full",
							},
							tbctalents = {
								order = 44,
								type = 'toggle',
								name = L["Expanded Talents"],
								desc = L["Expand Talents to cover the full tree"],
								hidden = E.Retail,
								get = function() return E.db.ElvUI_EltreumUI.skins.tbctalents end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.tbctalents = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							talentscale = {
								type = 'range',
								name = L["Scale"],
								hidden = E.Retail,
								order = 45,
								min = 0.1,
								max = 2,
								step = 0.01,
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.tbctalents end,
								get = function() return E.db.ElvUI_EltreumUI.skins.expandedtalentscale end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.expandedtalentscale = value _G.PlayerTalentFrame:SetScale(value) end,
							},
							retailtalentinfo = {
								order = 43,
								type = "description",
								name = L["Talents"],
								hidden = not E.Retail,
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
								width = "full",
							},
							retailtalentscale = {
								type = 'range',
								name = E.NewSign..L["Scale"],
								hidden = not E.Retail,
								order = 45,
								min = 0.1,
								max = 1.3,
								step = 0.01,
								get = function() return E.db.ElvUI_EltreumUI.skins.expandedtalentscale end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.expandedtalentscale = value
									if _G.ClassTalentFrame then
										_G.ClassTalentFrame:SetScale(value)
									end
								end,
							},
							expandedstable = {
								order = 50,
								type = "description",
								hidden = not E.Retail,
								name = L["Expand Hunter Stables to show all pets and improve search"],
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
								width = "full",
							},
							stableenable = {
								order = 51,
								type = 'toggle',
								name = L["Enable"],
								hidden = not E.Retail,
								desc = L["Enable the Expanded Stable"],
								get = function() return E.db.ElvUI_EltreumUI.skins.expandedstable end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.expandedstable = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							header79745 = {
								order = 52,
								type = "description",
								name = "",
								width = 'full',
								hidden = not E.Retail,
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							raidbossemoteframe = {
								order = 53,
								type = "description",
								hidden = not E.Retail,
								name = L["Remove Blizzard's Boss Emote Frame"],
								width = "full",
							},
							removebossemote = {
								order = 54,
								type = 'toggle',
								name = L["Enable"],
								hidden = not E.Retail,
								desc = L["Enable removing the Alert Frame that can show up in the middle of the screen"],
								get = function() return E.db.ElvUI_EltreumUI.skins.bossemote end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.bossemote = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							header8897 = {
								order = 55,
								type = "description",
								name = "",
								width = 'full',
								hidden = not E.Retail,
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							widertransmog = {
								order = 56,
								type = "description",
								hidden = not E.Retail,
								name = L["Expand Transmog Window to better show your character"],
								width = "full",
							},
							widetransmogenable = {
								order = 57,
								type = 'toggle',
								name = L["Enable"],
								desc = L["Enable the Wider Transmog Window"],
								hidden = not E.Retail,
								get = function() return E.db.ElvUI_EltreumUI.skins.widertransmog end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.widertransmog = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							headerhidekeypressab = {
								order = 94,
								type = "description",
								name = L["Hide Actionbar Button Press"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							hideABkeypress = {
								order = 95,
								type = 'toggle',
								name = L["Enable"],
								get = function() return E.db.ElvUI_EltreumUI.skins.hideABkeypress end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.hideABkeypress = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							gapabcolor = {
								order = 96,
								type = "description",
								name = L["Color Modifier Keys"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							colorabtext = {
								order = 97,
								type = 'toggle',
								name = L["Enable"],
								width = 'full',
								desc = L["Add Class Color to Modifier Keys like ALT and CTRL on the ActionBars"],
								get = function() return E.db.ElvUI_EltreumUI.skins.colormodkey end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.colormodkey = value end,
							},
							cdcolorheader = {
								order = 98,
								type = "description",
								name = L["Class Colored Cooldowns"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							cdclasscolor = {
								order = 99,
								type = 'toggle',
								name = L["Enable"],
								width = 'full',
								desc = L["Sets Cooldowns to be Class Colored"],
								get = function() return E.db.ElvUI_EltreumUI.skins.classcolorcooldowns end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.classcolorcooldowns = value ElvUI_EltreumUI:CooldownColors() end,
							},
							headerilvltooltip = {
								order = 100,
								type = "description",
								name = L["Item Level on Tooltip"],
								width = 'full',
								hidden = E.Retail,
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							ilvltooltip = {
								order = 101,
								type = 'toggle',
								name = L["Enable"],
								width = 'full',
								desc = L["Shows Item Level on Tooltips"],
								hidden = E.Retail,
								get = function() return E.db.ElvUI_EltreumUI.skins.ilvltooltip end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.ilvltooltip = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							headerroleicon = {
								order = 161,
								type = "description",
								name = L["Replace role icons with Eltruism role icons"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							roleiconsenable = {
								order = 162,
								type = 'toggle',
								name = L["Enable Eltruism Icons"],
								width = 'full',
								get = function() return E.db.ElvUI_EltreumUI.otherstuff.eltruismroleicons end,
								set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.eltruismroleicons = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							roleiconpick = {
								order = 163,
								type = 'select',
								name = "",
								values = {
									["ELTRUISM"] = "Eltruism "..E:TextureString('Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\sword',':20:20')..E:TextureString('Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\pharmacy',':20:20')..E:TextureString('Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\shield',':20:20'),
									["ATWOODELVUI"] = 'Atwood ElvUI '..E:TextureString('Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\ElvUI\\DPS',':20:20')..E:TextureString('Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\ElvUI\\Healer',':20:20')..E:TextureString('Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\ElvUI\\Tank',':20:20'),
									["ATWOODGLOW"] = 'Atwood Glow '..E:TextureString('Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Glow\\DPS',':20:20')..E:TextureString('Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Glow\\Healer',':20:20')..E:TextureString('Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Glow\\Tank',':20:20'),
									["ATWOODGRAVED"] = 'Atwood '..E:TextureString('Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Graved\\DPS',':20:20')..E:TextureString('Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Graved\\Healer',':20:20')..E:TextureString('Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Graved\\Tank',':20:20'),
									["ATWOODGREY"] = 'Atwood Grey '..E:TextureString('Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Grey\\DPS',':20:20')..E:TextureString('Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Grey\\Healer',':20:20')..E:TextureString('Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Grey\\Tank',':20:20'),
									["ATWOODWHITE"] = 'Atwood White '..E:TextureString('Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\White\\DPS',':20:20')..E:TextureString('Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\White\\Healer',':20:20')..E:TextureString('Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\White\\Tank',':20:20'),
									["RELEAF"] = 'Releaf '..E:TextureString('Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Releaf\\DPS',':20:20')..E:TextureString('Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Releaf\\Healer',':20:20')..E:TextureString('Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Releaf\\Tank',':20:20'),
									["CUSTOM"] = 'Custom',
								},
								sorting = {
									"ELTRUISM",
									"ATWOODELVUI",
									"ATWOODGLOW",
									"ATWOODGRAVED",
									"ATWOODGREY",
									"ATWOODWHITE",
									"RELEAF",
									"CUSTOM"
								},
								style = 'radio',
								disabled = function() return not E.db.ElvUI_EltreumUI.otherstuff.eltruismroleicons end,
								get = function() return E.db.ElvUI_EltreumUI.otherstuff.roleiconstype end,
								set = function(_,value) E.db.ElvUI_EltreumUI.otherstuff.roleiconstype = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							customroleicons = {
								order = 197,
								type = 'group',
								inline = true,
								name = L["Name of file inside Interface\\Addons"],
								args = {
									headerroleiconcustomtankinput = {
										order = 165,
										type = 'input',
										name = L["Tank"]..tostring(E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomtank),
										desc = L["Example: "].."mytexture.tga or mytexture or mytexture.jpg",
										width = 'full',
										disabled = function() return not E.db.ElvUI_EltreumUI.otherstuff.eltruismroleicons or E.db.ElvUI_EltreumUI.otherstuff.roleiconstype ~= 'CUSTOM' end,
										get = function() return E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomtank end,
										set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomtank = value E:StaticPopup_Show('CONFIG_RL') end,
									},
									headerroleiconcustomhealerinput = {
										order = 167,
										type = 'input',
										name = L["Healer"],
										desc = L["Example: "].."mytexture.tga or mytexture or mytexture.jpg",
										width = 'full',
										disabled = function() return not E.db.ElvUI_EltreumUI.otherstuff.eltruismroleicons or E.db.ElvUI_EltreumUI.otherstuff.roleiconstype ~= 'CUSTOM' end,
										get = function() return E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomhealer end,
										set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomhealer = value E:StaticPopup_Show('CONFIG_RL') end,
									},
									headerroleiconcustomdpsinput = {
										order = 169,
										type = 'input',
										name = L["DPS"],
										desc = L["Example: "].."mytexture.tga or mytexture or mytexture.jpg",
										width = 'full',
										disabled = function() return not E.db.ElvUI_EltreumUI.otherstuff.eltruismroleicons or E.db.ElvUI_EltreumUI.otherstuff.roleiconstype ~= 'CUSTOM' end,
										get = function() return E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomdps end,
										set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomdps = value E:StaticPopup_Show('CONFIG_RL') end,
									},
								},
							},
							otherskins = {
								order = 198,
								type = "description",
								name = L["Other Skins"],
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
								width = "full",
							},
							meetinghorn = {
								order = 200,
								type = 'toggle',
								name = L["Skin MeetingHorn"],
								desc = L["Skin MeetingHorn"],
								hidden = E.Retail,
								width = "full",
								get = function() return E.db.ElvUI_EltreumUI.skins.meetinghorn end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.meetinghorn = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							pallypower = {
								order = 200,
								type = 'toggle',
								name = L["Skin PallyPower"],
								desc = L["Skin PallyPower"],
								hidden = E.Retail,
								width = "full",
								get = function() return E.db.ElvUI_EltreumUI.skins.pallypower end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.pallypower = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							bigwigs = {
								order = 200,
								type = 'toggle',
								name = L["Skin BigWigs"],
								desc = L["Add Gradient to BigWigs Bars"],
								--width = "full",
								get = function() return E.db.ElvUI_EltreumUI.skins.bigwigs end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.bigwigs = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							bigwigsshadows = {
								order = 201,
								type = 'toggle',
								name = L["Shadows"],
								desc = L["Add Shadows to BigWigs Bars"],
								--width = "full",
								get = function() return E.db.ElvUI_EltreumUI.skins.shadow.bigwigs end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.shadow.bigwigs = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							detailsbigwigsgap = {
								order = 900,
								type = "description",
								name = "",
								width = "full",
							},
							detailsskin = {
								order = 901,
								type = 'toggle',
								name = L["Skin Details"],
								desc = L["Add gradient to Details Bars"],
								--width = "full",
								get = function() return E.db.ElvUI_EltreumUI.skins.details end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.details = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							detailsskintexture = {
								order = 902,
								type = 'toggle',
								name = L["Replace Texture"],
								desc = L["Replace Details Bar Texture"],
								--width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.details end,
								get = function() return E.db.ElvUI_EltreumUI.skins.detailstextureoverwrite end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.detailstextureoverwrite = value E:StaticPopup_Show('CONFIG_RL') end,
							},
						},
					},
					character = {
						type = 'group',
						name = L["Character"],
						order = 2,
						args = {
							headersocket = {
								order = 1,
								type = "description",
								name = L["Sockets and Enchants"],
								hidden = E.Retail,
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							anchorgapheresocket = {
								order = 2,
								type = "description",
								name = "",
								width = 'full',
								hidden = E.Retail,
							},
							socketsonchar = {
								order = 3,
								type = 'toggle',
								name = L["Add Sockets and Enchants to the Character Panel"],
								width = 'full',
								hidden = E.Retail,
								desc = L["Enable this option"],
								get = function() return E.db.ElvUI_EltreumUI.skins.sockets end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.sockets = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							socketsoninspect = {
								order = 4,
								type = 'toggle',
								name = L["Add Sockets and Enchants to the Inspect Frame"],
								width = 'full',
								hidden = E.Retail,
								desc = L["Enable this option"],
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.sockets end,
								get = function() return E.db.ElvUI_EltreumUI.skins.socketsinspect end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.socketsinspect = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							headerfirst = {
								order = 80,
								type = "description",
								name = L["Item Levels"],
								hidden = E.Retail,
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							anchorgaphere = {
								order = 81,
								type = "description",
								name = "",
								hidden = E.Retail,
								width = 'full',
							},
							skincharpanel = {
								order = 82,
								type = 'toggle',
								name = L["Add Item Levels to the Character Panel"],
								hidden = E.Retail,
								width = 'full',
								desc = L["Enable this option"],
								get = function() return E.db.ElvUI_EltreumUI.skins.ilvls end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.ilvls = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							inspectilvl = {
								order = 82,
								type = 'toggle',
								name = L["Add Item Levels to the Inspect Panel"],
								hidden = E.Retail,
								width = 'full',
								desc = L["Enable this option"],
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.ilvls end,
								get = function() return E.db.ElvUI_EltreumUI.skins.ilvlsinspect end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.ilvlsinspect = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							header831 = {
								order = 83,
								type = "description",
								hidden = E.Retail,
								name = "",
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							ilvlanchor = {
								order = 84,
								type = 'select',
								name = L["Ilvl Anchor Point"],
								desc = L["Choose where the Ilvl will be attach to on the items"],
								hidden = E.Retail,
								values = {
									["CENTER"] = "Center",
									["LEFT"] = 'Left',
									["RIGHT"] = 'Right',
									["TOP"] = 'Top',
									["TOPLEFT"] = 'Top Left',
									["TOPRIGHT"] = 'Top Right',
									["BOTTOM"] = 'Bottom',
									["BOTTOMLEFT"] = 'Bottom Left',
									["BOTTOMRIGHT"] = 'Bottom Right',
								},
								style = 'radio',
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.ilvls end,
								get = function() return E.db.ElvUI_EltreumUI.skins.ilvlanchor end,
								set = function(_,value) E.db.ElvUI_EltreumUI.skins.ilvlanchor = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							ilvlfontx = {
								type = 'range',
								name = L["Ilvl Font X Offset"],
								hidden = E.Retail,
								order = 85,
								min = -100,
								max = 100,
								step = 1,
								--width = "double",
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.ilvls end,
								get = function() return E.db.ElvUI_EltreumUI.skins.ilvlanchorx end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.ilvlanchorx = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							ilvlfonty = {
								type = 'range',
								name = L["Ilvl Font Y Offset"],
								hidden = E.Retail,
								order = 86,
								min = -100,
								max = 100,
								step = 1,
								--width = "double",
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.ilvls end,
								get = function() return E.db.ElvUI_EltreumUI.skins.ilvlanchory end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.ilvlanchory = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							header838 = {
								order = 117,
								type = "description",
								hidden = E.Retail,
								name = "",
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							ilvlfontweight = {
								order = 118,
								type = 'select',
								name = L["Ilvl Font Outline"],
								desc = L["Choose the Ilvl font outline"],
								hidden = E.Retail,
								values = {
									["OUTLINE"] = "Outline",
									["THICKOUTLINE"] = 'Thick Outline',
									["MONOCHROME"] = 'Monochrome',
								},
								style = 'radio',
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.ilvls end,
								get = function() return E.db.ElvUI_EltreumUI.skins.ilvlfontweight end,
								set = function(_,value) E.db.ElvUI_EltreumUI.skins.ilvlfontweight = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							header840 = {
								order = 119,
								type = "description",
								hidden = E.Retail,
								name = "",
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							ilvlfontsize = {
								type = 'range',
								name = L["Ilvl Font Size"],
								desc = L["Change the Ilvl font size"],
								hidden = E.Retail,
								order = 120,
								min = 4,
								max = 72,
								step = 1,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.ilvls end,
								get = function() return E.db.ElvUI_EltreumUI.skins.ilvlfontsize end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.ilvlfontsize = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							header844 = {
								order = 121,
								type = "description",
								name = L["Character Panel"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							expandart = {
								order = 122,
								type = 'toggle',
								name = L["Expand Character Art"],
								width = 'full',
								desc = L["Enable this option"],
								get = function() return E.db.ElvUI_EltreumUI.skins.expandarmorybg end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.expandarmorybg = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							expandamoryclassic = {
								order = 123,
								type = 'toggle',
								name = L["Expand Character Panel"],
								width = 'full',
								desc = L["Enable this option"],
								get = function() return E.db.ElvUI_EltreumUI.skins.classicarmory end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.classicarmory = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							expandartcrest = {
								order = 124,
								type = 'toggle',
								name = L["Add Crest to Character Panel"],
								width = 'full',
								desc = L["Enable this option"],
								get = function() return E.db.ElvUI_EltreumUI.skins.expandarmorycrest end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.expandarmorycrest = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							gapalphaart = {
								order = 125,
								type = "description",
								name = "",
								width = 'full',
							},
							expandartalpha = {
								type = 'range',
								name = L["Art Alpha"],
								desc = L["Change the transparency of the Art"],
								order = 126,
								min = 0.01,
								max = 1,
								step = 0.01,
								--width = "double",
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.expandarmorybg end,
								get = function() return E.db.ElvUI_EltreumUI.skins.expandarmorybgalpha end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.expandarmorybgalpha = value _G["EltruismCharacterBG"]:SetAlpha(value) end,
							},
							armorybgtextureselect = {
								order = 127,
								type = 'select',
								name = L["Background Texture Type"],
								desc = L["Choose between a Class, Race or Custom Background"],
								--width = "double",
								values = {
									["CLASS"] = CLASS,
									["RACE"] = RACE,
									["RAGNAROS"] = L["Ragnaros"],
									["SPACECLOUD"] = L["SpaceCloud"],
									["RAVNYR"] = L["Ravnyr"],
									["BLACK"] = L["Black"],
									["CUSTOM"] = CUSTOM,
								},
								sorting = {
									"CLASS",
									"RACE",
									"RAGNAROS",
									"SPACECLOUD",
									"RAVNYR",
									"BLACK",
									"CUSTOM"
								},
								style = 'radio',
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.expandarmorybg end,
								get = function() return E.db.ElvUI_EltreumUI.skins.armorybgtype end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.armorybgtype = value ElvUI_EltreumUI:ExpandedCharacterStats() end,
							},
							bgcustomtexture = {
								order = 128,
								type = 'input',
								name = L["Name of file inside Interface\\Addons"],
								desc = L["Example: "].."mytexture.tga or mytexture or mytexture.jpg",
								width = 'double',
								disabled = function() return E.db.ElvUI_EltreumUI.skins.armorybgtype ~= "CUSTOM" end,
								get = function() return E.private.ElvUI_EltreumUI.skins.armorybgtexture end,
								set = function(_, value) E.private.ElvUI_EltreumUI.skins.armorybgtexture = value ElvUI_EltreumUI:ExpandedCharacterStats() end,
							},
							expandvignetteenable = {
								order = 129,
								type = 'toggle',
								name = L["Add a Vignette over the Character Art"],
								width = 'full',
								desc = L["Enable this option"],
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.expandarmorybg end,
								get = function() return E.db.ElvUI_EltreumUI.skins.armoryvignette end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.armoryvignette = value ElvUI_EltreumUI:ExpandedCharacterStats() end,
							},
							expandvignettealpha = {
								type = 'range',
								name = L["Vignette Alpha"],
								desc = L["Change the transparency of the Vignette"],
								order = 130,
								min = 0.01,
								max = 1,
								step = 0.01,
								--width = "double",
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.expandarmorybg or not E.db.ElvUI_EltreumUI.skins.armoryvignette end,
								get = function() return E.db.ElvUI_EltreumUI.skins.armoryvignettealpha end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.armoryvignettealpha = value _G["EltruismCharacterBGVignette"]:SetAlpha(value) end,
							},
							header834gap = {
								order = 145,
								type = "description",
								name = "",
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							characterpanelscale = {
								type = 'range',
								name = L["Character Panel Scale"],
								desc = L["Change the size of the Character Panel"],
								order = 146,
								min = 0.2,
								max = 2,
								step = 0.01,
								width = 'full',
								get = function() return E.db.ElvUI_EltreumUI.skins.characterpanelscale end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.characterpanelscale = value
									_G["CharacterFrame"]:SetScale(value)
									if _G["CharacterModelFrame"] then
										_G["CharacterModelFrame"]:SetIgnoreParentScale(false)
									else
										_G["CharacterModelScene"]:SetIgnoreParentScale(false)
									end
								end,
							},
							gapmodelcam1 = {
								order = 147,
								type = "description",
								name = L["Character Model"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							modelcamzoom = {
								type = 'range',
								name = L["Character Model Zoom"],
								order = 148,
								min = -2,
								max = 2,
								step = 0.01,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.expandarmorybg end,
								get = function()
									if E.Retail then
										return E.db.ElvUI_EltreumUI.skins.charactermodelcam.zoomretail
									else
										return E.db.ElvUI_EltreumUI.skins.charactermodelcam.zoomclassic
									end
								end,
								set = function(_, value)
									if E.Retail then
										E.db.ElvUI_EltreumUI.skins.charactermodelcam.zoomretail = value
									else
										E.db.ElvUI_EltreumUI.skins.charactermodelcam.zoomclassic = value
									end
								end,
							},
							modelcamx = {
								type = 'range',
								name = L["Character Model X Offset"],
								order = 149,
								min = -2,
								max = 2,
								step = 0.01,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.expandarmorybg end,
								get = function()
									if E.Retail then
										return E.db.ElvUI_EltreumUI.skins.charactermodelcam.xretail
									else
										return E.db.ElvUI_EltreumUI.skins.charactermodelcam.xclassic
									end
								end,
								set = function(_, value)
									if E.Retail then
										E.db.ElvUI_EltreumUI.skins.charactermodelcam.xretail = value
									else
										E.db.ElvUI_EltreumUI.skins.charactermodelcam.xclassic = value
									end
								end,
							},
							modelcamy = {
								type = 'range',
								name = L["Character Model Y Offset"],
								order = 150,
								min = -2,
								max = 2,
								step = 0.01,
								width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.expandarmorybg end,
								get = function()
									if E.Retail then
										return E.db.ElvUI_EltreumUI.skins.charactermodelcam.yretail
									else
										return E.db.ElvUI_EltreumUI.skins.charactermodelcam.yclassic
									end
								end,
								set = function(_, value)
									if E.Retail then
										E.db.ElvUI_EltreumUI.skins.charactermodelcam.yretail = value
									else
										E.db.ElvUI_EltreumUI.skins.charactermodelcam.yclassic = value
									end
								end,
							},
							header843stats = {
								order = 151,
								type = "description",
								name = "",
								width = 'full',
								hidden = E.Retail,
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							autoarmorystats = {
								order = 152,
								type = 'toggle',
								name = L["Automatically swap the Character Stats to your main ones"],
								width = 'full',
								hidden = E.Retail,
								desc = L["Enable this option"],
								get = function() return E.db.ElvUI_EltreumUI.skins.classicarmoryautostats end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.classicarmoryautostats = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							headeritemq1823col = {
								order = 153,
								type = "description",
								name = "",
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							itemqualitycolors = {
								order = 154,
								type = 'toggle',
								name = L["Add Item Quality Texture"],
								width = 'full',
								desc = L["Enable this option"],
								get = function() return E.db.ElvUI_EltreumUI.skins.itemquality end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.itemquality = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							colorsetsdifferently = {
								order = 156,
								type = 'toggle',
								name = L["Add Item Set Colors"],
								width = 'double',
								desc = L["Enable this option"],
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.itemquality end,
								get = function() return E.db.ElvUI_EltreumUI.skins.itemsetenable end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.itemsetenable = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							itemsetcustomcolor = {
								order = 157,
								name = L["Enable Custom Set Colors"],
								type = "toggle",
								width = 'double',
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.itemsetenable or not E.db.ElvUI_EltreumUI.skins.itemquality end,
								get = function() return E.db.ElvUI_EltreumUI.skins.itemsetcustomcolor end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.itemsetcustomcolor = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							itemsetcustomcolor1 = {
								order = 158,
								type = 'color',
								name = L["Color"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.itemsetenable or not E.db.ElvUI_EltreumUI.skins.itemquality or not E.db.ElvUI_EltreumUI.skins.itemsetcustomcolor end,
								get = function()
									local dr = P.ElvUI_EltreumUI.skins.itemsetcolor.r
									local dg = P.ElvUI_EltreumUI.skins.itemsetcolor.g
									local db = P.ElvUI_EltreumUI.skins.itemsetcolor.b
									return E.db.ElvUI_EltreumUI.skins.itemsetcolor.r, E.db.ElvUI_EltreumUI.skins.itemsetcolor.g, E.db.ElvUI_EltreumUI.skins.itemsetcolor.b, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.skins.itemsetcolor.r, E.db.ElvUI_EltreumUI.skins.itemsetcolor.g, E.db.ElvUI_EltreumUI.skins.itemsetcolor.b = r, g, b
								end,
							},
							headerequipandbagilvl = {
								order = 159,
								type = "description",
								name = "",
								width = 'full',
								hidden = not E.Retail,
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							equipandbagilvlenable = {
								order = 160,
								name = L["Enable Comparing Equipped and Bag Ilvl"],
								type = "toggle",
								width = 'full',
								hidden = not E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.classicarmory end,
								get = function() return E.db.ElvUI_EltreumUI.skins.ilvltextcolordifferenceenable end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.ilvltextcolordifferenceenable = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							equipandbagilvlenablecustomcolor = {
								order = 161,
								name = L["Enable Custom Colors"],
								type = "toggle",
								width = 'full',
								hidden = not E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.ilvltextcolordifferenceenable or not E.db.ElvUI_EltreumUI.skins.classicarmory end,
								get = function() return E.db.ElvUI_EltreumUI.skins.ilvltextcolordifferencecustom end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.ilvltextcolordifferencecustom = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							equipandbagilvlenablecustomcolor1 = {
								order = 162,
								type = 'color',
								name = L["Bad Color"],
								hasAlpha = false,
								hidden = not E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.ilvltextcolordifferencecustom or not E.db.ElvUI_EltreumUI.skins.ilvltextcolordifferenceenable or not E.db.ElvUI_EltreumUI.skins.classicarmory end,
								get = function()
									local dr = P.ElvUI_EltreumUI.skins.ilvltextcolordifference.badR
									local dg = P.ElvUI_EltreumUI.skins.ilvltextcolordifference.badG
									local db = P.ElvUI_EltreumUI.skins.ilvltextcolordifference.badB
									return E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.badR, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.badG, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.badB, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.badR, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.badG, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.badB = r, g, b
								end,
							},
							equipandbagilvlenablecustomcolor2 = {
								order = 163,
								type = 'color',
								name = L["Medium Color"],
								hasAlpha = false,
								hidden = not E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.ilvltextcolordifferencecustom or not E.db.ElvUI_EltreumUI.skins.ilvltextcolordifferenceenable or not E.db.ElvUI_EltreumUI.skins.classicarmory end,
								get = function()
									local dr = P.ElvUI_EltreumUI.skins.ilvltextcolordifference.mediumR
									local dg = P.ElvUI_EltreumUI.skins.ilvltextcolordifference.mediumG
									local db = P.ElvUI_EltreumUI.skins.ilvltextcolordifference.mediumB
									return E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.mediumR, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.mediumG, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.mediumB, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.mediumR, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.mediumG, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.mediumB = r, g, b
								end,
							},
							equipandbagilvlenablecustomcolor3 = {
								order = 164,
								type = 'color',
								name = L["Good Color"],
								hasAlpha = false,
								hidden = not E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.ilvltextcolordifferencecustom or not E.db.ElvUI_EltreumUI.skins.ilvltextcolordifferenceenable or not E.db.ElvUI_EltreumUI.skins.classicarmory end,
								get = function()
									local dr = P.ElvUI_EltreumUI.skins.ilvltextcolordifference.goodR
									local dg = P.ElvUI_EltreumUI.skins.ilvltextcolordifference.goodG
									local db = P.ElvUI_EltreumUI.skins.ilvltextcolordifference.goodB
									return E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.goodR, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.goodG, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.goodB, 1, dr, dg, db, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.goodR, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.goodG, E.db.ElvUI_EltreumUI.skins.ilvltextcolordifference.goodB = r, g, b
								end,
							},
							headerstat5 = {
								order = 233,
								type = "description",
								name = "",
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							statcolors = {
								order = 234,
								type = 'toggle',
								name = function()
									if E.Retail then
										return L["Add Class Gradient Colors to Stats"]
									else
										return L["Add Class Colors to Text"]
									end
								end,
								width = 'full',
								desc = L["Enable this option"],
								get = function() return E.db.ElvUI_EltreumUI.skins.statcolors end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.statcolors = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							othergradientcolors = {
								order = 235,
								type = 'toggle',
								name = function()
									if E.Retail then
										return L["Add Class Gradient Colors to Other Texts"]
									else
										return L["Add Class Gradient Colors to Text"]
									end
								end,
								width = 'full',
								desc = L["Enable this option"],
								get = function() return E.db.ElvUI_EltreumUI.skins.characterskingradients end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.characterskingradients = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							gapfontsize1 = {
								order = 236,
								type = "description",
								name = "",
								width = 'full',
							},
							characterpanelfontsize = {
								type = 'range',
								name = L["Font Size"],
								order = 237,
								min = 8,
								max = 40,
								step = 1,
								--width = "double",
								get = function() return E.db.ElvUI_EltreumUI.skins.armoryfontsize end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.armoryfontsize = value ElvUI_EltreumUI:ExpandedCharacterStats() PaperDollFrame_UpdateStats() end,
							},
							header85 = {
								order = 238,
								type = "description",
								name = "",
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							iconsoncharacter = {
								order = 239,
								type = 'toggle',
								name = L["Add Class Icons to Character Panel"],
								width = 'full',
								desc = L["Enable this option"],
								get = function() return E.db.ElvUI_EltreumUI.skins.classiconsoncharacterpanel end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.classiconsoncharacterpanel = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							blizzicons = {
								order = 240,
								type = 'toggle',
								name = L["Use Blizzard Icons"],
								width = 'full',
								desc = L["Enable Blizzard Icons"],
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.classiconsoncharacterpanel or E.db.ElvUI_EltreumUI.skins.classiconsreleaf end,
								get = function() return E.db.ElvUI_EltreumUI.skins.classiconsblizz end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.classiconsblizz = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							releaficons= {
								order = 241,
								type = 'toggle',
								name = L["Use Blizzard Icons colored by Releaf"],
								width = 'full',
								desc = L["Enable Releaf Icons"],
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.classiconsoncharacterpanel or E.db.ElvUI_EltreumUI.skins.classiconsblizz end,
								get = function() return E.db.ElvUI_EltreumUI.skins.classiconsreleaf end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.classiconsreleaf = value E:StaticPopup_Show('CONFIG_RL') end,
							},
						},
					},
					shadows = {
						type = 'group',
						name = L["Shadows"],
						order = 2,
						args = {
							shadowsdesc = {
								order = 1,
								type = "description",
								name = L["Add Shadows to Frames"],
								desc = L["Add Shadows to some frames"],
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
								width = 'full',
							},
							shadowsenable = {
								order = 2,
								name = L["Enable General Shadows"],
								type = "toggle",
								desc = L["Add Shadows to frames like Player, target, Chats and others"],
								width = 'full',
								get = function() return E.db.ElvUI_EltreumUI.skins.shadow.enable end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.shadow.enable = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							shadowsenableab = {
								order = 3,
								name = L["ActionBars"],
								type = "toggle",
								desc = L["Add Shadows to Actionbars"],
								width = 'full',
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.shadow.enable end,
								get = function() return E.db.ElvUI_EltreumUI.skins.shadow.actionbars end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.shadow.actionbars = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							shadowsenableraid = {
								order = 4,
								name = L["Raid"],
								type = "toggle",
								desc = L["Add Shadows to Raid Frames"],
								width = 'full',
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.shadow.enable end,
								get = function() return E.db.ElvUI_EltreumUI.skins.shadow.raid end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.shadow.raid = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							shadowsenableminimap = {
								order = 4,
								name = MINIMAP_LABEL,
								type = "toggle",
								desc = L["Add Shadows to the Minimap"],
								width = 'full',
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.shadow.enable end,
								get = function() return E.db.ElvUI_EltreumUI.skins.shadow.minimap end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.shadow.minimap = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							shadowsenablechat = {
								order = 4,
								name = E.NewSign..CHAT_LABEL,
								type = "toggle",
								desc = L["Add Shadows to the Chat Frames"],
								width = 'full',
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.shadow.enable end,
								get = function() return E.db.ElvUI_EltreumUI.skins.shadow.chat end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.shadow.chat = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							header845 = {
								order = 98,
								type = "description",
								name = L["Other Shadows (can become CPU/Memory Intensive)"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							shadowsenablenp = {
								order = 99,
								name = L["Nameplate Health"],
								type = "toggle",
								desc = L["Add Shadows to Nameplate Healthbars"],
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.shadow.enable end,
								get = function() return E.db.ElvUI_EltreumUI.skins.shadow.nameplates end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.shadow.nameplates = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							shadowsenablenpauras = {
								order = 99,
								name = L["Nameplate Aura"],
								type = "toggle",
								desc = L["Add Shadows to Nameplate Auras"],
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.shadow.enable end,
								get = function() return E.db.ElvUI_EltreumUI.skins.shadow.npauras end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.shadow.npauras = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							shadowsenablenpportrait = {
								order = 99,
								name = L["Nameplate Portrait"],
								type = "toggle",
								desc = L["Add Shadows to Nameplate Portraits"],
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.shadow.enable end,
								get = function() return E.db.ElvUI_EltreumUI.skins.shadow.npportrait end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.shadow.npportrait = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							shadowsenablenppower = {
								order = 99,
								name = L["Nameplate Power"],
								type = "toggle",
								desc = L["Add Shadows to Nameplate Powers"],
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.shadow.enable end,
								get = function() return E.db.ElvUI_EltreumUI.skins.shadow.nppower end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.shadow.nppower = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							shadowsenablenpcastbar = {
								order = 99,
								name = L["Nameplate Castbar"],
								type = "toggle",
								desc = L["Add Shadows to Nameplate Castbars"],
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.shadow.enable end,
								get = function() return E.db.ElvUI_EltreumUI.skins.shadow.npcastbar end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.shadow.npcastbar = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							shadowsenableufaura = {
								order = 99,
								name = L["Unitframe Aura"],
								type = "toggle",
								desc = L["Add Shadows to Unitframe Auras"],
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.shadow.enable end,
								get = function() return E.db.ElvUI_EltreumUI.skins.shadow.ufaura end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.shadow.ufaura = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							shadowsenableaura = {
								order = 99,
								name = L["Aura"],
								type = "toggle",
								desc = L["Add Aura Shadows (Aura list next to the minimap)"],
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.shadow.enable end,
								get = function() return E.db.ElvUI_EltreumUI.skins.shadow.aura end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.shadow.aura = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							headershadowsize = {
								order = 100,
								type = "description",
								name = L["Shadow Size"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							shadowsize = {
								type = 'range',
								name = "",
								order = 101,
								min = 1,
								max = 10,
								step = 1,
								--width = "double",
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.shadow.enable end,
								get = function() return E.db.ElvUI_EltreumUI.skins.shadow.length end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.shadow.length = value E:StaticPopup_Show('CONFIG_RL') end,
							},
						},
					},
					quests = {
						type = 'group',
						name = L["Quests"],
						order = 2,
						args = {
							questskinsheader = {
								order = 1,
								type = "description",
								name = L["Skin Objective Frame"],
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
								width = 'full',
							},
							questenableskin = {
								order = 2,
								name = L["Enable Skin"],
								type = "toggle",
								desc = L["Skin the Objective/Quest Frame"],
								width = 'full',
								get = function() return E.db.ElvUI_EltreumUI.skins.quests end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.quests = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							questskinsheader2 = {
								order = 3,
								type = "description",
								name = "",
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
								width = 'full',
							},
							showwowhead = {
								order = 3,
								name = L["Enable Wowhead Button on Quest Log"],
								type = "toggle",
								desc = L["Show a button for Wowhead quest links"],
								width = 'full',
								get = function() return E.db.ElvUI_EltreumUI.skins.questswowhead end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.questswowhead = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							questskinsheader3 = {
								order = 4,
								type = "description",
								name = "",
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
								width = 'full',
							},
							questenableshadow = {
								order = 4,
								name = L["Enable Shadows"],
								type = "toggle",
								--width = 'full',
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.quests end,
								get = function() return E.db.ElvUI_EltreumUI.skins.questsettings.lineshadow end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.questsettings.lineshadow = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							retailprogressheader = {
								order = 5,
								type = "description",
								name = "",
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
								hidden = not E.Retail,
								width = 'full',
							},
							retailprogressbartexture = {
								order = 5,
								type = 'select',
								width = "double",
								dialogControl = 'LSM30_Statusbar',
								name = L["Choose the Progress Bar Texture"],
								desc = L["Select a Texture"],
								hidden = not E.Retail,
								values = AceGUIWidgetLSMlists.statusbar,
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.quests end,
								get = function() return E.db.ElvUI_EltreumUI.skins.queststatusbartexture end,
								set = function(self,key) E.db.ElvUI_EltreumUI.skins.queststatusbartexture = key E:StaticPopup_Show('CONFIG_RL') end,
							},
							lineheader1 = {
								order = 6,
								type = "description",
								name = L["Line"],
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
								width = 'full',
							},
							linetexture = {
								order = 7,
								type = 'select',
								width = "double",
								dialogControl = 'LSM30_Statusbar',
								name = L["Line Texture"],
								desc = L["Select a Texture"],
								values = AceGUIWidgetLSMlists.statusbar,
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.quests end,
								get = function() return E.db.ElvUI_EltreumUI.skins.questsettings.texture end,
								set = function(_,key) E.db.ElvUI_EltreumUI.skins.questsettings.texture = key E:StaticPopup_Show('CONFIG_RL') end,
							},
							linesizex = {
								type = 'range',
								name = L["Line Width"],
								order = 8,
								min = 1,
								max = 400,
								step = 1,
								width = "double",
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.quests end,
								get = function() return E.db.ElvUI_EltreumUI.skins.questsettings.sizex end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.questsettings.sizex = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							linesizey = {
								type = 'range',
								name = L["Line Height"],
								order = 9,
								min = 1,
								max = 80,
								step = 1,
								width = "double",
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.quests end,
								get = function() return E.db.ElvUI_EltreumUI.skins.questsettings.sizey end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.questsettings.sizey = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							linebuttonsize = {
								type = 'range',
								name = L["Button Size"],
								order = 10,
								min = 4,
								max = 40,
								step = 1,
								hidden = E.Retail,
								width = "double",
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.quests end,
								get = function() return E.db.ElvUI_EltreumUI.skins.questsettings.linebuttonsize end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.questsettings.linebuttonsize = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							linecustomcolorenable = {
								order = 11,
								name = L["Enable Custom Colors"],
								type = "toggle",
								width = 'full',
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.quests end,
								get = function() return E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							customcolorsline1 = {
								order = 12,
								type = 'color',
								name = L["Custom Color"].."1",
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor or not E.db.ElvUI_EltreumUI.skins.quests end,
								get = function()
									return E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor1r, E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor1g, E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor1b, 1, P.ElvUI_EltreumUI.skins.questsettings.linecustomcolor1r, P.ElvUI_EltreumUI.skins.questsettings.linecustomcolor1g, P.ElvUI_EltreumUI.skins.questsettings.linecustomcolor1b, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor1r, E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor1g, E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor1b = r, g, b E:StaticPopup_Show('CONFIG_RL')
								end,
							},
							customcolorsline2 = {
								order = 12,
								type = 'color',
								name = L["Custom Color"].."2",
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor or not E.db.ElvUI_EltreumUI.skins.quests end,
								get = function()
									return E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor2r, E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor2g, E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor2b, 1, P.ElvUI_EltreumUI.skins.questsettings.linecustomcolor2r, P.ElvUI_EltreumUI.skins.questsettings.linecustomcolor2g, P.ElvUI_EltreumUI.skins.questsettings.linecustomcolor2b, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor2r, E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor2g, E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor2b = r, g, b E:StaticPopup_Show('CONFIG_RL')
								end,
							},
							questskinslinetextureheader1 = {
								order = 91,
								type = "description",
								name = L["Text"],
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
								width = 'full',
							},
							customcolorenable = {
								order = 92,
								name = L["Enable Custom Colors"],
								type = "toggle",
								width = 'full',
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.quests end,
								get = function() return E.db.ElvUI_EltreumUI.skins.questsettings.customcolor end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.questsettings.customcolor = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							customcolorstext = {
								order = 93,
								type = 'color',
								name = L["Custom Color"],
								hasAlpha = false,
								width = 'full',
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.questsettings.customcolor or not E.db.ElvUI_EltreumUI.skins.quests end,
								get = function()
									return E.db.ElvUI_EltreumUI.skins.questsettings.customr, E.db.ElvUI_EltreumUI.skins.questsettings.customg, E.db.ElvUI_EltreumUI.skins.questsettings.customb, 1, P.ElvUI_EltreumUI.skins.questsettings.customr, P.ElvUI_EltreumUI.skins.questsettings.customg, P.ElvUI_EltreumUI.skins.questsettings.customb, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.skins.questsettings.customr, E.db.ElvUI_EltreumUI.skins.questsettings.customg, E.db.ElvUI_EltreumUI.skins.questsettings.customb = r, g, b E:StaticPopup_Show('CONFIG_RL')
								end,
							},
							fontsize = {
								type = 'range',
								name = L["Font Size"],
								order = 94,
								min = 6,
								max = 80,
								step = 1,
								--width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.quests end,
								get = function() return E.db.ElvUI_EltreumUI.skins.questsettings.fontSize end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.questsettings.fontSize = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							questscaleheader = {
								order = 95,
								type = "description",
								name = "",
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
								width = 'full',
							},
							questscale = {
								type = 'range',
								order = 96,
								name = L["Quest Detail Scale"],
								min = 0.01,
								max = 3,
								step = 0.01,
								--width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.skins.quests end,
								get = function() return E.db.ElvUI_EltreumUI.skins.questsettings.questScale end,
								set = function(_, value) E.db.ElvUI_EltreumUI.skins.questsettings.questScale = value
									if _G["QuestFrame"] then
										_G["QuestFrame"]:SetScale(value)
									end
									if _G["QuestLogDetailFrame"] then
										_G["QuestLogDetailFrame"]:SetScale(value)
									end
									if _G["QuestLogFrame"] then
										_G["QuestLogFrame"]:SetScale(value)
									end
									if _G["GossipFrame"] then
										_G["GossipFrame"]:SetScale(value)
									end
									if _G["WorldMapFrame"] and E.Retail then
										_G["WorldMapFrame"]:SetScale(value)
									end
								end,
							},
						},
					},
					databars = {
						type = 'group',
						name = L["DataBars"],
						order = 5,
						args = {
							header8898 = {
								order = 58,
								type = "description",
								name = "",
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							gradientxp = {
								order = 59,
								type = "description",
								name = L["Add a gradient color to the Experience Bar"],
								width = "full",
							},
							gradientxpenable = {
								order = 60,
								type = 'toggle',
								name = L["Enable"],
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientXP end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientXP = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							gradientxpcolor = {
								order = 61,
								type = 'color',
								name = L["Color"],
								hasAlpha = false,
								width = 'full',
								desc = L["This is the second color on the Experience Bar, the first can be found in ElvUI Databars section"],
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientXP end,
								get = function()
									return E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientXPcolors.r, E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientXPcolors.g, E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientXPcolors.b, 1, P.ElvUI_EltreumUI.unitframes.gradientmode.gradientXPcolors.r, P.ElvUI_EltreumUI.unitframes.gradientmode.gradientXPcolors.g, P.ElvUI_EltreumUI.unitframes.gradientmode.gradientXPcolors.b, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientXPcolors.r, E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientXPcolors.g, E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientXPcolors.b = r, g, b E:StaticPopup_Show('CONFIG_RL')
								end,
							},
							header8898rep = {
								order = 62,
								type = "description",
								name = "",
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							gradientrep = {
								order = 63,
								type = "description",
								name = L["Add a gradient color to the Reputation Bar"],
								width = "full",
							},
							gradientrepenable = {
								order = 64,
								type = 'toggle',
								name = L["Enable"],
								width = 'full',
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputation end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputation = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							repred = {
								type = 'range',
								name = L["Red"],
								order = 65,
								min = -1,
								max = 1,
								step = 0.01,
								desc = L["This is how much the color will gain or lose this value"],
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputation end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputationcolors.r end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputationcolors.r = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							repgreen = {
								type = 'range',
								name = L["Green"],
								order = 66,
								min = -1,
								max = 1,
								step = 0.01,
								desc = L["This is how much the color will gain or lose this value"],
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputation end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputationcolors.g end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputationcolors.g = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							repblue = {
								type = 'range',
								name = L["Blue"],
								order = 67,
								min = -1,
								max = 1,
								step = 0.01,
								desc = L["This is how much the color will gain or lose this value"],
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputation end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputationcolors.b end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputationcolors.b = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							header8898honor = {
								order = 68,
								type = "description",
								name = "",
								width = 'full',
								hidden = not E.Retail,
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							gradienthonor = {
								order = 69,
								type = "description",
								name = L["Add a gradient color to the Honor Bar"],
								width = "full",
								hidden = not E.Retail,
							},
							gradienthonorenable = {
								order = 70,
								type = 'toggle',
								name = L["Enable"],
								width = 'full',
								hidden = not E.Retail,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientHonor end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientHonor = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							honorred = {
								type = 'range',
								name = L["Red"],
								order = 71,
								min = -1,
								max = 1,
								step = 0.01,
								hidden = not E.Retail,
								desc = L["This is how much the color will gain or lose this value"],
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientHonor end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientHonorcolors.r end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientHonorcolors.r = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							honorgreen = {
								type = 'range',
								name = L["Green"],
								order = 72,
								min = -1,
								max = 1,
								step = 0.01,
								hidden = not E.Retail,
								desc = L["This is how much the color will gain or lose this value"],
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientHonor end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientHonorcolors.g end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientHonorcolors.g = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							honorblue = {
								type = 'range',
								name = L["Blue"],
								order = 73,
								min = -1,
								max = 1,
								step = 0.01,
								hidden = not E.Retail,
								desc = L["This is how much the color will gain or lose this value"],
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientHonor end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientHonorcolors.b end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientHonorcolors.b = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							header8898digsite = {
								order = 74,
								type = "description",
								name = "",
								width = 'full',
								hidden = not E.Retail,
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							gradientdigsite = {
								order = 75,
								type = "description",
								name = L["Gradient Archeology Digsite Bar"],
								width = "full",
								hidden = not E.Retail,
							},
							digsitewidth = {
								type = 'range',
								name = L["Width"],
								order = 76,
								min = 10,
								max = 600,
								step = 1,
								hidden = not E.Retail,
								--width = "double",
								get = function() return E.db.ElvUI_EltreumUI.otherstuff.archeology.sizex end,
								set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.archeology.sizex = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							digsiteheight = {
								type = 'range',
								name = L["Height"],
								order = 76,
								min = 5,
								max = 400,
								step = 1,
								hidden = not E.Retail,
								--width = "double",
								get = function() return E.db.ElvUI_EltreumUI.otherstuff.archeology.sizey end,
								set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.archeology.sizey = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							digsitegap = {
								order = 77,
								type = "description",
								name = "",
								width = 'full',
								hidden = not E.Retail,
							},
							gradientdigcolor1 = {
								order = 77,
								type = 'color',
								name = L["Color 1"],
								hasAlpha = false,
								--width = 'full',
								hidden = not E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable end,
								get = function()
									return E.db.ElvUI_EltreumUI.otherstuff.archeology.r1, E.db.ElvUI_EltreumUI.otherstuff.archeology.g1, E.db.ElvUI_EltreumUI.otherstuff.archeology.b1, 1, P.ElvUI_EltreumUI.otherstuff.archeology.r1, P.ElvUI_EltreumUI.otherstuff.archeology.g1, P.ElvUI_EltreumUI.otherstuff.archeology.b1, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.otherstuff.archeology.r1, E.db.ElvUI_EltreumUI.otherstuff.archeology.g1, E.db.ElvUI_EltreumUI.otherstuff.archeology.b1 = r, g, b E:StaticPopup_Show('CONFIG_RL')
								end,
							},
							gradientdigcolor2 = {
								order = 78,
								type = 'color',
								name = L["Color 2"],
								hasAlpha = false,
								--width = 'full',
								hidden = not E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable end,
								get = function()
									return E.db.ElvUI_EltreumUI.otherstuff.archeology.r2, E.db.ElvUI_EltreumUI.otherstuff.archeology.g2, E.db.ElvUI_EltreumUI.otherstuff.archeology.b2, 1, P.ElvUI_EltreumUI.otherstuff.archeology.r2, P.ElvUI_EltreumUI.otherstuff.archeology.g2, P.ElvUI_EltreumUI.otherstuff.archeology.b2, 1
								end,
								set = function(_, r, g, b, a)
									E.db.ElvUI_EltreumUI.otherstuff.archeology.r2, E.db.ElvUI_EltreumUI.otherstuff.archeology.g2, E.db.ElvUI_EltreumUI.otherstuff.archeology.b2 = r, g, b E:StaticPopup_Show('CONFIG_RL')
								end,
							},
							digsitefontsize = {
								type = 'range',
								name = L["Font Size"],
								order = 79,
								min = 4,
								max = 40,
								step = 1,
								width = "full",
								hidden = not E.Retail,
								get = function() return E.db.ElvUI_EltreumUI.otherstuff.archeology.archeologyfontsize end,
								set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.archeology.archeologyfontsize = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							digsiteoffsetx = {
								type = 'range',
								name = L["Text X offset"],
								order = 80,
								min = -100,
								max = 100,
								step = 1,
								width = "full",
								hidden = not E.Retail,
								get = function() return E.db.ElvUI_EltreumUI.otherstuff.archeology.archeologyfontoffsetx end,
								set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.archeology.archeologyfontoffsetx = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							digsiteoffsety = {
								type = 'range',
								name = L["Text Y offset"],
								order = 80,
								min = -100,
								max = 100,
								step = 1,
								width = "full",
								hidden = not E.Retail,
								get = function() return E.db.ElvUI_EltreumUI.otherstuff.archeology.archeologyfontoffsety end,
								set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.archeology.archeologyfontoffsety = value E:StaticPopup_Show('CONFIG_RL') end,
							},
						},
					},
				},
			},
			unitframes = {
				type = 'group',
				name = L["Unitframes"],
				order = 85,
				childGroups = "tab",
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\unitframes',
				args = {
					general = {
						type = 'group',
						name = L["General"],
						order = 1,
						args = {
							enableUFmod = {
								order = 1,
								type = 'toggle',
								width = "full",
								name = L["Enable Unitframe Modifications"],
								desc = L["Enable changing textures and gradients for ElvUI unitframes"],
								get = function() return E.db.ElvUI_EltreumUI.unitframes.UFmodifications end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.UFmodifications = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							uftypeselect = {
								type = "description",
								name = "",--L["Choose between custom textures or gradient mode"],
								order = 2,
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							unitframesenable = {
								order = 3,
								name = L["Enable Custom Textures"],
								type = "toggle",
								desc = L["Requires Light Mode Enabled"],
								width = 'full',
								disabled = function() return (not E.db.ElvUI_EltreumUI.unitframes.lightmode and not E.db.ElvUI_EltreumUI.unitframes.darkmode) or not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable = value
									if E.Retail then
										E:StaticPopup_Show('CONFIG_RL')
									end
								end,
							},
							enablegradient = {
								order = 3,
								type = 'toggle',
								name = L["Enable Gradient (Requires Dark or Light Modes)"],
								desc = L["Enable Gradient colors for Health"],
								width = 'full',
								disabled = function() return (not E.db.ElvUI_EltreumUI.unitframes.lightmode and not E.db.ElvUI_EltreumUI.unitframes.darkmode) or not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable = value ElvUI_EltreumUI:GradientColorTableUpdate() end,
							},
							enablepower = {
								order = 4,
								type = 'toggle',
								name = L["Enable Gradient Power"],
								desc = L["Enable Gradient Power Colors"],
								width = 'full',
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepower end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepower = value ElvUI_EltreumUI:GradientColorTableUpdate() end,
							},
							enableaurabars = {
								order = 5,
								type = 'toggle',
								name = L["Enable Gradient Aurabars"],
								desc = L["Enable Gradient Aurabars"],
								width = 'full',
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableaurabars end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableaurabars = value ElvUI_EltreumUI:GradientColorTableUpdate() end,
							},
							darklightmode = {
								order = 96,
								type = "description",
								name = L["Change the look of frames to Dark or Light mode"],
								width = "full",
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							dark = {
								order = 97,
								type = 'toggle',
								name = L["Dark Mode"],
								width = 'full',
								desc = L["This will set colors to black with class colors when losing health"],
								disabled = function() return E.db.ElvUI_EltreumUI.unitframes.lightmode or not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.darkmode end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.darkmode = value end,
							},
							light = {
								order = 97,
								type = 'toggle',
								name = L["Light Mode"],
								width = 'full',
								desc = L["This will set colors to class based with black backgrounds when losing health"],
								disabled = function() return E.db.ElvUI_EltreumUI.unitframes.darkmode or not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.lightmode end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.lightmode = value end,
							},
							applymode = {
								order = 98,
								type = 'execute',
								name = L["Apply"],
								--width = 'full',
								desc = L["Apply the mode selected"],
								disabled = function() return (not E.db.ElvUI_EltreumUI.unitframes.UFmodifications) end,
								func = function()
									if E.db.ElvUI_EltreumUI.unitframes.lightmode then
										ElvUI_EltreumUI:LightMode()
										E:StaggeredUpdateAll(nil, true)
										E:StaticPopup_Show('CONFIG_RL')
									elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
										ElvUI_EltreumUI:DarkMode()
										E:StaggeredUpdateAll(nil, true)
										E:StaticPopup_Show('CONFIG_RL')
									else
										ElvUI_EltreumUI:LightMode()
										E:StaggeredUpdateAll(nil, true)
										E:StaticPopup_Show('CONFIG_RL')
									end
								end,
								--confirm = true,
							},
							headeruftextv = {
								order = 99,
								type = "description",
								name= L["Light Mode Texture Version"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							textureselect = {
								type = 'select',
								name= "",
								order = 100,
								values = {
									["V1"] = L["Version 1"],
									["V2"] = L["Version 2"],
									["V3"] = L["Version 3"],
									["NONE"] = L["None"],
								},
								style = 'radio',
								disabled = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable or E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable or not E.db.ElvUI_EltreumUI.unitframes.UFmodifications or not E.db.ElvUI_EltreumUI.unitframes.lightmode end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.uftextureversion end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.uftextureversion = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							headerorientation = {
								order = 101,
								type = "description",
								name = L["Unitframe Fill Orientation"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							setorientation = {
								type = 'select',
								name = "",
								order = 102,
								values = {
									["HORIZONTAL"] = L["Horizontal"],
									["VERTICAL"] = L["Vertical"],
								},
								style = 'radio',
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.UForientation end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.UForientation = value end,
							},
							headerufbackdrop = {
								order = 103,
								type = "description",
								name = L["Backdrops"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							backdrophide = {
								order = 104,
								type = 'toggle',
								width = "full",
								name = L["Hide Backdrop"],
								desc = L["Sets the Backdrop as Transparent/Hidden"],
								get = function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdrophidden end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdrophidden = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							ufbackdropTex = {
								order = 105,
								type = 'select',
								--width = "double",
								dialogControl = 'LSM30_Statusbar',
								name = L["Backdrop Texture"],
								desc = L["Select a Texture"],
								values = AceGUIWidgetLSMlists.statusbar,
								disabled = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable or E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable or not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdroptexture end,
								set = function(self,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdroptexture = key end,
							},
							ufbackdropTexalpha = {
								type = 'range',
								name = L["Backdrop Alpha"],
								desc = L["Change the transparency of the backdrop"],
								order = 106,
								min = 0,
								max = 1,
								step = 0.01,
								--width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha = value end,
							},
							powerbgfade = {
								type = 'range',
								name = L["Gradient Power Backdrop"],
								desc = L["Change how much the Gradient Power Backdrop will Fade"],
								order = 106,
								min = 0,
								max = 1,
								step = 0.01,
								--width = "full",
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepower or not E.db.ElvUI_EltreumUI.unitframes.UFmodifications or E.db.unitframe.colors.custompowerbackdrop end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade = value end,
							},
							portraitfix = {
								order = 107,
								type = "description",
								name = L["Target Portrait Fix"],
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
								width = "full",
							},
							portraitfixenable = {
								order = 108,
								type = 'toggle',
								width = "full",
								name = L["Automatically rotate Target Portrait"],
								desc = L["Detects target's species and uses it to fix the rotation of the Target's 3D Portrait"],
								get = function() return E.db.ElvUI_EltreumUI.unitframes.portraitfix end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraitfix = value end,
							},
							infoPanelOnTopheader = {
								order = 986,
								type = "description",
								name = L["Information Panel"],
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
								width = "full",
							},
							infoPanelOnTop = {
								order = 987,
								type = 'toggle',
								width = "full",
								name = L["Enable Information Panel on Top"],
								desc = L["Sets Information panel to be on Top instead of Bottom of the unitframe"],
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.infopanelontop end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.infopanelontop = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							infoPanelOnTopall = {
								order = 988,
								type = 'toggle',
								width = "full",
								name = L["Enable on All Unitframes"],
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.UFmodifications or not E.db.ElvUI_EltreumUI.unitframes.infopanelontop end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.infopanelontopallframes end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.infopanelontopallframes = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							darkpowerdesc = {
								order = 989,
								type = "description",
								name = L["Change the Class Power background"],
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
								width = "full",
							},
							darkpowerenable = {
								order = 990,
								type = 'toggle',
								width = "full",
								name = L["Dark Power Background"],
								desc = L["Sets Class Power backgrounds to be black"],
								get = function() return E.db.ElvUI_EltreumUI.unitframes.darkpowercolor end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.darkpowercolor = value end,
							},
							castbarspark = {
								order = 991,
								type = "description",
								name = L["Customize the player castbar spark"],
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
								width = "full",
							},
							castbarsparkenable = {
								order = 992,
								type = 'toggle',
								name = L["Enable"],
								width = "full",
								desc = L["Customize Player CastBar Spark"],
								get = function() return E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.enable end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.enable = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							colorspark = {
								order = 993,
								type = 'color',
								name = L["Custom Color"],
								hasAlpha = false,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.enable end,
								get = function()
									local glowcustomcolor = E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor
									local d = P.ElvUI_EltreumUI.unitframes.sparkcustomcolor
									return glowcustomcolor.r, glowcustomcolor.g, glowcustomcolor.b, glowcustomcolor.a, d.r, d.g, d.b, d.a
								end,
								set = function(_, r, g, b, a)
									local glowcustomcolor = E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor
									glowcustomcolor.r, glowcustomcolor.g, glowcustomcolor.b = r, g, b E:StaticPopup_Show('CONFIG_RL')
								end,
							},
							sparktexture = {
								order = 993,
								type = 'select',
								--width = "double",
								dialogControl = 'LSM30_Statusbar',
								name = L["Spark Texture"],
								desc = L["Select a Texture"],
								values = AceGUIWidgetLSMlists.statusbar,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.texture end,
								set = function(self,key) E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.texture = key end,
							},
							sparkwidth = {
								type = 'range',
								name = L["Width"],
								desc = L["Set Width of the Spark (Default 3)"],
								order = 994,
								min = 1,
								max = 20,
								step = 1,
								--width = "double",
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.width end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.width = value E:StaticPopup_Show('CONFIG_RL') end,
							},
							headergaphere = {
								order = 1995,
								type = "description",
								name = L["Alternative unitframe layouts"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							layoutdescriptiongap = {
								order = 1996,
								type = 'description',
								name = "",
								width = "full",
							},
							layoutdescription = {
								order = 1997,
								type = 'description',
								fontSize = 'medium',
								name = L["DPS/Tank layouts were created with pure dps classes in mind, if you play a class with more raid cooldowns like a Shaman, Druid or Paladin you might want to use the alternative layout in order to make it easier for you to use your cooldowns on the members of your group"],
							},
							alternativegroups = {
								order = 1998,
								type = 'execute',
								name = L["Alternative Layout"],
								func = function() ElvUI_EltreumUI:AlternativeGroupsDPS() end,
							},
							originalgroups = {
								order = 1999,
								type = 'execute',
								name = L["Original Layout"],
								func = function() ElvUI_EltreumUI:OriginalGroupsDPS() end,
							},
						},
					},
					textures = {
						type = 'group',
						name = L["Textures"],
						order = 2,
						disabled = function() return (not E.db.ElvUI_EltreumUI.unitframes.lightmode and not E.db.ElvUI_EltreumUI.unitframes.darkmode) or not E.db.ElvUI_EltreumUI.unitframes.UFmodifications or not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end,
						args = {
							unitframesdesc = {
								order = 102,
								type = "description",
								name = L["Customize Unitframe textures"],
								desc = L["Choose custom textures for some unitframes"],
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
								width = 'full',
							},
							classdetect = {
								order = 103,
								name = L["Automatically Detect Classes for Player, Target, Target of Target and Focus"],
								type = "toggle",
								desc = L["Use the custom texture based on it's class instead of general texture for Player, Target, Target of Target and Focus"],
								width = 'full',
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.classdetect end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.classdetect = value end,
							},
							playertexture = {
								order = 104,
								type = 'select',
								width = "double",
								dialogControl = 'LSM30_Statusbar',
								name = L["Player Texture"],
								desc = L["Select a Texture"],
								values = AceGUIWidgetLSMlists.statusbar,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.playertexture end,
								set = function(self,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.playertexture = key ElvUI_EltreumUI:GradientColorTableUpdate() ElvUI_EltreumUI:CustomTexture() end,
							},
							castbartex = {
								order = 105,
								type = 'select',
								width = "double",
								dialogControl = 'LSM30_Statusbar',
								name = L["Player Castbar Texture"],
								desc = L["Select a Texture"],
								values = AceGUIWidgetLSMlists.statusbar,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.castbartexture end,
								set = function(self,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.castbartexture = key ElvUI_EltreumUI:GradientColorTableUpdate() ElvUI_EltreumUI:CustomTexture() end,
							},
							targettexture = {
								order = 106,
								type = 'select',
								width = "double",
								dialogControl = 'LSM30_Statusbar',
								name = L["Target Texture"],
								desc = L["Select a Texture"],
								values = AceGUIWidgetLSMlists.statusbar,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettexture end,
								set = function(self,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettexture = key ElvUI_EltreumUI:GradientColorTableUpdate() ElvUI_EltreumUI:CustomTexture() end,
							},
							targettargettexture = {
								order = 107,
								type = 'select',
								width = "double",
								dialogControl = 'LSM30_Statusbar',
								name = L["Target of Target Texture"],
								desc = L["Select a Texture"],
								values = AceGUIWidgetLSMlists.statusbar,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettexture end,
								set = function(self,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettexture = key ElvUI_EltreumUI:GradientColorTableUpdate() ElvUI_EltreumUI:CustomTexture() end,
							},
							targettargettargettexture = {
								order = 107,
								type = 'select',
								width = "double",
								dialogControl = 'LSM30_Statusbar',
								name = L["Target of Target of Target Texture"],
								desc = L["Select a Texture"],
								values = AceGUIWidgetLSMlists.statusbar,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettargettexture end,
								set = function(self,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettargettexture = key ElvUI_EltreumUI:GradientColorTableUpdate() ElvUI_EltreumUI:CustomTexture() end,
							},
							focustexture = {
								order = 108,
								type = 'select',
								width = "double",
								dialogControl = 'LSM30_Statusbar',
								name = L["Focus Texture"],
								desc = L["Select a Texture"],
								values = AceGUIWidgetLSMlists.statusbar,
								hidden = E.Classic,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.focustexture end,
								set = function(self,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.focustexture = key ElvUI_EltreumUI:GradientColorTableUpdate() ElvUI_EltreumUI:CustomTexture() end,
							},
							headerclasses = {
								order = 109,
								type = "description",
								name = L["Class Textures"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							dktexture = {
								order = 110,
								type = 'select',
								width = "double",
								dialogControl = 'LSM30_Statusbar',
								name = L["Death Knight"],
								desc = L["Select a Texture"],
								values = AceGUIWidgetLSMlists.statusbar,
								hidden = not E.Retail and not E.Wrath,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture end,
								set = function(self,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture = key ElvUI_EltreumUI:GradientColorTableUpdate() ElvUI_EltreumUI:CustomTexture() end,
							},
							dhtexture = {
								order = 110,
								type = 'select',
								width = "double",
								dialogControl = 'LSM30_Statusbar',
								name = L["Demon Hunter"],
								desc = L["Select a Texture"],
								values = AceGUIWidgetLSMlists.statusbar,
								hidden = not E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture end,
								set = function(self,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture = key ElvUI_EltreumUI:GradientColorTableUpdate() ElvUI_EltreumUI:CustomTexture() end,
							},
							druidtexture = {
								order = 110,
								type = 'select',
								width = "double",
								dialogControl = 'LSM30_Statusbar',
								name = L["Druid"],
								desc = L["Select a Texture"],
								values = AceGUIWidgetLSMlists.statusbar,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture end,
								set = function(self,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture = key ElvUI_EltreumUI:GradientColorTableUpdate() ElvUI_EltreumUI:CustomTexture() end,
							},
							huntertexture = {
								order = 110,
								type = 'select',
								width = "double",
								dialogControl = 'LSM30_Statusbar',
								name = L["Hunter"],
								desc = L["Select a Texture"],
								values = AceGUIWidgetLSMlists.statusbar,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture end,
								set = function(self,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture = key ElvUI_EltreumUI:GradientColorTableUpdate() ElvUI_EltreumUI:CustomTexture() end,
							},
							magetexture = {
								order = 110,
								type = 'select',
								width = "double",
								dialogControl = 'LSM30_Statusbar',
								name = L["Mage"],
								desc = L["Select a Texture"],
								values = AceGUIWidgetLSMlists.statusbar,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture end,
								set = function(self,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture = key ElvUI_EltreumUI:GradientColorTableUpdate() ElvUI_EltreumUI:CustomTexture() end,
							},
							monktexture = {
								order = 110,
								type = 'select',
								width = "double",
								dialogControl = 'LSM30_Statusbar',
								name = L["Monk"],
								desc = L["Select a Texture"],
								values = AceGUIWidgetLSMlists.statusbar,
								hidden = not E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture end,
								set = function(self,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture = key ElvUI_EltreumUI:GradientColorTableUpdate() ElvUI_EltreumUI:CustomTexture() end,
							},
							evokertexture = {
								order = 110,
								type = 'select',
								width = "double",
								dialogControl = 'LSM30_Statusbar',
								name = L["Evoker"],
								desc = L["Select a Texture"],
								values = AceGUIWidgetLSMlists.statusbar,
								hidden = not E.Retail,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture end,
								set = function(self,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture = key ElvUI_EltreumUI:GradientColorTableUpdate() ElvUI_EltreumUI:CustomTexture() end,
							},
							paladintexture = {
								order = 110,
								type = 'select',
								width = "double",
								dialogControl = 'LSM30_Statusbar',
								name = L["Paladin"],
								desc = L["Select a Texture"],
								values = AceGUIWidgetLSMlists.statusbar,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture end,
								set = function(self,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture = key ElvUI_EltreumUI:GradientColorTableUpdate() ElvUI_EltreumUI:CustomTexture() end,
							},
							priesttexture = {
								order = 110,
								type = 'select',
								width = "double",
								dialogControl = 'LSM30_Statusbar',
								name = L["Priest"],
								desc = L["Select a Texture"],
								values = AceGUIWidgetLSMlists.statusbar,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture end,
								set = function(self,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture = key ElvUI_EltreumUI:GradientColorTableUpdate() ElvUI_EltreumUI:CustomTexture() end,
							},
							roguetexture = {
								order = 110,
								type = 'select',
								width = "double",
								dialogControl = 'LSM30_Statusbar',
								name = L["Rogue"],
								desc = L["Select a Texture"],
								values = AceGUIWidgetLSMlists.statusbar,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture end,
								set = function(self,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture = key ElvUI_EltreumUI:GradientColorTableUpdate() ElvUI_EltreumUI:CustomTexture() end,
							},
							shamantexture = {
								order = 110,
								type = 'select',
								width = "double",
								dialogControl = 'LSM30_Statusbar',
								name = L["Shaman"],
								desc = L["Select a Texture"],
								values = AceGUIWidgetLSMlists.statusbar,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture end,
								set = function(self,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture = key ElvUI_EltreumUI:GradientColorTableUpdate() ElvUI_EltreumUI:CustomTexture() end,
							},
							warlocktexture = {
								order = 110,
								type = 'select',
								width = "double",
								dialogControl = 'LSM30_Statusbar',
								name = L["Warlock"],
								desc = L["Select a Texture"],
								values = AceGUIWidgetLSMlists.statusbar,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture end,
								set = function(self,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture = key ElvUI_EltreumUI:GradientColorTableUpdate() ElvUI_EltreumUI:CustomTexture() end,
							},
							warriortexture = {
								order = 110,
								type = 'select',
								width = "double",
								dialogControl = 'LSM30_Statusbar',
								name = L["Warrior"],
								desc = L["Select a Texture"],
								values = AceGUIWidgetLSMlists.statusbar,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture end,
								set = function(self,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture = key ElvUI_EltreumUI:GradientColorTableUpdate() ElvUI_EltreumUI:CustomTexture() end,
							},
							npcfriendlytexture = {
								order = 111,
								type = 'select',
								width = "double",
								dialogControl = 'LSM30_Statusbar',
								name = L["Friendly NPC"],
								desc = L["Select a Texture"],
								values = AceGUIWidgetLSMlists.statusbar,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly end,
								set = function(self,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly = key ElvUI_EltreumUI:GradientColorTableUpdate() ElvUI_EltreumUI:CustomTexture() end,
							},
							npcneutraltexture = {
								order = 111,
								type = 'select',
								width = "double",
								dialogControl = 'LSM30_Statusbar',
								name = L["Neutral NPC"],
								desc = L["Select a Texture"],
								values = AceGUIWidgetLSMlists.statusbar,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral end,
								set = function(self,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral = key ElvUI_EltreumUI:GradientColorTableUpdate() ElvUI_EltreumUI:CustomTexture() end,
							},
							npcunfriendlytexture = {
								order = 111,
								type = 'select',
								width = "double",
								dialogControl = 'LSM30_Statusbar',
								name = L["Unfriendly NPC"],
								desc = L["Select a Texture"],
								values = AceGUIWidgetLSMlists.statusbar,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly end,
								set = function(self,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly = key ElvUI_EltreumUI:GradientColorTableUpdate() ElvUI_EltreumUI:CustomTexture() end,
							},
							npchostiletexture = {
								order = 111,
								type = 'select',
								width = "double",
								dialogControl = 'LSM30_Statusbar',
								name = L["Hostile NPC"],
								desc = L["Select a Texture"],
								values = AceGUIWidgetLSMlists.statusbar,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile end,
								set = function(self,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile = key ElvUI_EltreumUI:GradientColorTableUpdate() ElvUI_EltreumUI:CustomTexture() end,
							},
							tappedtexture = {
								order = 111,
								type = 'select',
								width = "double",
								dialogControl = 'LSM30_Statusbar',
								name = L["Tapped NPC"],
								desc = L["Select a Texture"],
								values = AceGUIWidgetLSMlists.statusbar,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture end,
								set = function(self,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture = key ElvUI_EltreumUI:GradientColorTableUpdate() ElvUI_EltreumUI:CustomTexture() end,
							},
						},
					},
					gradient = {
						type = "group",
						name = L["Gradient"],
						order = 3,
						disabled = function() return (not E.db.ElvUI_EltreumUI.unitframes.lightmode and not E.db.ElvUI_EltreumUI.unitframes.darkmode) or not E.db.ElvUI_EltreumUI.unitframes.UFmodifications or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable end,
						args = {
							header1 = {
								order = 1,
								type = "description",
								name = L["Gradient Colors"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							enableplayer = {
								order = 2,
								type = 'toggle',
								name = L["Enable for Player"],
								desc = L["Enable Gradient colors for Health"],
								width = 'full',
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableplayer end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableplayer = value end,
							},
							enabletarget = {
								order = 2,
								type = 'toggle',
								name = L["Enable for Target"],
								desc = L["Enable Gradient colors for Health"],
								width = 'full',
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.enabletarget end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.enabletarget = value end,
							},
							enabletargettarget = {
								order = 2,
								type = 'toggle',
								name = L["Enable for Target of Target"],
								desc = L["Enable Gradient colors for Health"],
								width = 'full',
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.enabletargettarget end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.enabletargettarget = value end,
							},
							enabletargettargettarget = {
								order = 2,
								type = 'toggle',
								name = L["Enable for Target of Target of Target"],
								desc = L["Enable Gradient colors for Health"],
								width = 'full',
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.enabletargettargettarget end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.enabletargettargettarget = value end,
							},
							enablefocus = {
								order = 2,
								type = 'toggle',
								name = L["Enable for Focus"],
								desc = L["Enable Gradient colors for Health"],
								width = 'full',
								hidden = E.Classic,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablefocus end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablefocus = value end,
							},
							enablefocustarget = {
								order = 2,
								type = 'toggle',
								name = L["Enable for Focus Target"],
								desc = L["Enable Gradient colors for Health"],
								width = 'full',
								hidden = E.Classic,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablefocustarget end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablefocustarget = value end,
							},
							enableboss = {
								order = 2,
								type = 'toggle',
								name = L["Enable for Boss"],
								desc = L["Enable Gradient colors for Health"],
								width = 'full',
								hidden = not (E.Retail or E.Wrath),
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableboss end,
								set = function(_, value)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableboss = value
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableboss1 = value
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableboss2 = value
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableboss3 = value
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableboss4 = value
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableboss5 = value
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableboss6 = value
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableboss7 = value
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableboss8 = value
								end,
							},
							enablearena = {
								order = 2,
								type = 'toggle',
								name = L["Enable for Arena"],
								desc = L["Enable Gradient colors for Health"],
								width = 'full',
								hidden = E.Classic,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablearena end,
								set = function(_, value)
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablearena = value
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablearena1 = value
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablearena2 = value
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablearena3 = value
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablearena4 = value
									E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablearena5 = value
								end,
							},
							enablegroupunits = {
								order = 2,
								type = 'toggle',
								name = L["Enable for Group Units"],
								desc = L["Enable Gradient colors for Health"],
								width = 'full',
								--disabled = function() return true end,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablegroupunits end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablegroupunits = value end,
							},
							enablecastbargradient = {
								order = 2,
								type = 'toggle',
								name = L["Enable for Player Castbar"],
								desc = L["Enable Gradient colors for Player Castbar"],
								width = 'full',
								--disabled = function() return true end,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableplayercastbar end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableplayercastbar = value end,
							},
							enablecastbargradientnoninterruptplayer = {
								order = 2,
								type = 'toggle',
								name = L["Enable for Player Castbar (Non Interruptible)"],
								desc = L["Enable Gradient colors for Player Castbar (Non Interruptible)"],
								width = 'full',
								--disabled = function() return true end,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableplayercastbarnoninterruptible end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableplayercastbarnoninterruptible = value end,
							},
							enablecastbargradientinterruptedplayer = {
								order = 2,
								type = 'toggle',
								name = L["Enable for Player Castbar (Interrupted)"],
								desc = L["Enable Gradient colors for Player Castbar (Interrupted)"],
								width = 'full',
								--disabled = function() return true end,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableplayercastbarinterrupted end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableplayercastbarinterrupted = value end,
							},
							enabletargetcastbargradient = {
								order = 2,
								type = 'toggle',
								name = L["Enable for Target Castbar"],
								desc = L["Enable Gradient colors for Target Castbar"],
								width = 'full',
								--disabled = function() return true end,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.enabletargetcastbar end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.enabletargetcastbar = value end,
							},
							enablecastbargradientnoninterrupttarget = {
								order = 2,
								type = 'toggle',
								name = L["Enable for Target Castbar (Non Interruptible)"],
								desc = L["Enable Gradient colors for Target Castbar (Non Interruptible)"],
								width = 'full',
								--disabled = function() return true end,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.enabletargetcastbarnoninterruptible end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.enabletargetcastbarnoninterruptible = value end,
							},
							enablecastbargradientinterruptedtarget = {
								order = 2,
								type = 'toggle',
								name = L["Enable for Target Castbar (Interrupted)"],
								desc = L["Enable Gradient colors for Target Castbar (Interrupted)"],
								width = 'full',
								--disabled = function() return true end,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.enabletargetcastbarinterrupted end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.enabletargetcastbarinterrupted = value end,
							},
							enablecustomcolor = {
								order = 3,
								type = 'toggle',
								name = L["Custom Color"],
								desc = L["Enable Custom Colors"],
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor = value ElvUI_EltreumUI:GradientColorTableUpdate() end,
							},
							opengradientcolors = {
								order = 4,
								type = 'execute',
								name = L["Colors"],
								width = 'full',
								desc = L["Customize Colors"],
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable end,
								func = function() E.Libs.AceConfigDialog:SelectGroup('ElvUI', 'ElvUI_EltreumUI', "gradient", "class") end,
							},
							gradientorientation = {
								type = 'select',
								name = L["Gradient Orientation"],
								desc = L["Choose the direction of the gradient"],
								order = 5,
								values = {
									["HORIZONTAL"] = L["Horizontal"],
									["VERTICAL"] = L["Vertical"],
								},
								style = 'radio',
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation = value end,
							},
							gradientorientationPower = {
								type = 'select',
								name = L["Gradient Power Orientation"],
								desc = L["Choose the direction of the gradient"],
								order = 6,
								values = {
									["HORIZONTAL"] = L["Horizontal"],
									["VERTICAL"] = L["Vertical"],
								},
								style = 'radio',
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower = value end,
							},
							gradienttexture = {
								order = 7,
								type = 'select',
								--width = "double",
								dialogControl = 'LSM30_Statusbar',
								name = L["Gradient Texture"],
								desc = L["Select a Texture"],
								values = AceGUIWidgetLSMlists.statusbar,
								disabled = function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable or E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture end,
								set = function(self,key) E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture = key ElvUI_EltreumUI:CustomTexture() end,
							},
							useelvUFtexture = {
								order = 8,
								type = 'toggle',
								width = "double",
								name = L["Use ElvUI Unitframe Texture"],
								desc = L["Uses ElvUI Unitframe Statusbar texture instead"],
								disabled = function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture = value ElvUI_EltreumUI:GradientColorTableUpdate() end,
							},
						}
					},
					models = {
						type = "group",
						name = L["Models"],
						order = 4,
						disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end,
						args = {
							header1 = {
								order = 1,
								type = "description",
								name = "|cffFF0000WARNING:|r"..L[" This can be a very demanding feature, it's not recommended to use models for performance."],
								width = 'full',
							},
							header2 = {
								order = 3,
								type = "description",
								name = L["Unitframe Models"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							modelenable = {
								type = 'toggle',
								name = L["Enable Models/Effects"],
								desc = L["Enable adding models as effects on unitframes"],
								order = 4,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.models.unitframe end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.models.unitframe = value ElvUI_EltreumUI:PlayerUFEffects() ElvUI_EltreumUI:TargetUFEffects() ElvUI_EltreumUI:TargetTargetUFEffects() end,
							},
							selectmodeltype = {
								order = 6,
								type = 'select',
								name = L["Choose between Class Based Models or a Custom Model"],
								values = {
									["CLASS"] = CLASS,
									["CUSTOM"] = CUSTOM,
								},
								style = 'radio',
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.models.unitframe or not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.models.modeltype end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.models.modeltype = value ElvUI_EltreumUI:PlayerUFEffects() ElvUI_EltreumUI:TargetUFEffects() ElvUI_EltreumUI:TargetTargetUFEffects() end,
							},
							custommodelpath = {
								order = 7,
								type = 'input',
								name = function()
									if E.Retail then
										return L["Type the Model ID, such as 165575"]
									else
										return L["Type the Model Path, such as spells/arcanebreath.m2"]
									end
								end,
								width = 'full',
								disabled = function() return E.db.ElvUI_EltreumUI.unitframes.models.modeltype == 'CLASS' or not E.db.ElvUI_EltreumUI.unitframes.models.unitframe or not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end,
								validate = function(_, value)
									E.PopupDialogs["ELTRUISMINVALIDMODEL"] = {
										text = L["Invalid Model, you need to add a Model ID/Path"],
										button1 = OKAY,
										timeout = 0,
										whileDead = 1,
										hideOnEscape = true,
									}
									if E.Retail then
										if tonumber(value) ~= nil then
											return true
										else
											return E:StaticPopup_Show('ELTRUISMINVALIDMODEL') and false
										end
									else
										return true
									end
								end,
								get = function()
									if E.Retail then
										return tostring(E.db.ElvUI_EltreumUI.unitframes.models.custommodel)
									else
										return tostring(E.db.ElvUI_EltreumUI.unitframes.models.custommodelclassic)
									end
								end,
								set = function(_, value)
									if E.Retail then
										E.db.ElvUI_EltreumUI.unitframes.models.custommodel = tonumber(value)
									else
										E.db.ElvUI_EltreumUI.unitframes.models.custommodelclassic = tostring(value)
									end

									ElvUI_EltreumUI:PlayerUFEffects() ElvUI_EltreumUI:TargetUFEffects() ElvUI_EltreumUI:TargetTargetUFEffects()
								end,
							},
							ufmodelalpha = {
								type = 'range',
								name = L["Light Mode Alpha"],
								order = 80,
								min = 0,
								max = 1,
								step = 0.01,
								width = "double",
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.models.unitframe or not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.models.ufalpha end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.models.ufalpha = value ElvUI_EltreumUI:PlayerUFEffects() ElvUI_EltreumUI:TargetUFEffects() ElvUI_EltreumUI:TargetTargetUFEffects() end,
							},
							ufmodelalphadark = {
								type = 'range',
								name = L["Dark Mode Alpha"],
								order = 81,
								min = 0,
								max = 1,
								step = 0.01,
								width = "double",
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.models.unitframe or not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.models.ufalphadark end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.models.ufalphadark = value ElvUI_EltreumUI:PlayerUFEffects() ElvUI_EltreumUI:TargetUFEffects() ElvUI_EltreumUI:TargetTargetUFEffects() end,
							},
							ufmodeldesaturation = {
								type = 'range',
								name = L["Desaturation"],
								order = 82,
								min = 0,
								max = 1,
								step = 0.01,
								width = "double",
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.models.unitframe or not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.models.ufdesaturation end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.models.ufdesaturation = value ElvUI_EltreumUI:PlayerUFEffects() ElvUI_EltreumUI:TargetUFEffects() ElvUI_EltreumUI:TargetTargetUFEffects() end,
							},
							headercast = {
								order = 120,
								type = "description",
								name = L["Castbar Models"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							castbarmodeleffect = {
								type = 'toggle',
								name = L["Enable Models/Effects"],
								desc = L["Enable adding models as effects on Castbars"],
								order = 121,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.models.castbar end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.models.castbar = value ElvUI_EltreumUI:CastbarEffects() end,
							},
							selectmodeltypecast = {
								order = 122,
								type = 'select',
								name = L["Choose between a Default Model or a Custom Model"],
								values = {
									["DEFAULT"] = L["Default"],
									["CUSTOM"] = CUSTOM,
								},
								sorting = {
									"DEFAULT",
									"CUSTOM",
								},
								style = 'radio',
								disabled = function() return (not E.db.ElvUI_EltreumUI.unitframes.UFmodifications or not E.db.ElvUI_EltreumUI.unitframes.models.castbar) end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.models.modeltypecast end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.models.modeltypecast = value ElvUI_EltreumUI:CastbarEffects() end,
							},
							custommodelpathcast = {
								order = 123,
								type = 'input',
								name = function()
									if E.Retail then
										return L["Type the Model ID, such as 165821"]
									else
										return L["Type the Model Path, such as spells/corruption_impactdot_med_base.m2"]
									end
								end,
								width = 'full',
								disabled = function() return E.db.ElvUI_EltreumUI.unitframes.models.modeltypecast == "DEFAULT" or (not E.db.ElvUI_EltreumUI.unitframes.UFmodifications or not E.db.ElvUI_EltreumUI.unitframes.models.castbar) end,
								validate = function(_, value)
									E.PopupDialogs["ELTRUISMINVALIDMODELCAST"] = {
										text = L["Invalid Model, you need to add a Model ID/Path"],
										button1 = OKAY,
										timeout = 0,
										whileDead = 1,
										hideOnEscape = true,
									}
									if E.Retail then
										if tonumber(value) ~= nil then
											return true
										else
											return E:StaticPopup_Show('ELTRUISMINVALIDMODELCAST') and false
										end
									else
										return true
									end
								end,
								get = function()
									if E.Retail then
										return tostring(E.db.ElvUI_EltreumUI.unitframes.models.custommodelcast)
									else
										return tostring(E.db.ElvUI_EltreumUI.unitframes.models.custommodelclassiccast)
									end
								end,
								set = function(_, value)
									if E.Retail then
										E.db.ElvUI_EltreumUI.unitframes.models.custommodelcast = tonumber(value)
									else
										E.db.ElvUI_EltreumUI.unitframes.models.custommodelclassiccast = tostring(value)
									end
									ElvUI_EltreumUI:CastbarEffects()
								end,
							},
							headerpower = {
								order = 124,
								type = "description",
								name = L["Power Bar Models"],
								width = 'full',
								image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
							},
							powerbarmodeleffect = {
								type = 'toggle',
								name = L["Enable Models/Effects"],
								order = 125,
								disabled = function() return not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.models.powerbar end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.models.powerbar = value ElvUI_EltreumUI:PlayerUFEffects() end,
							},
							selectmodeltypepower = {
								order = 126,
								type = 'select',
								name = L["Choose between a Default Model or a Custom Model"],
								values = {
									["DEFAULT"] = L["Default"],
									["CUSTOM"] = CUSTOM,
								},
								sorting = {
									"DEFAULT",
									"CUSTOM",
								},
								style = 'radio',
								disabled = function() return (not E.db.ElvUI_EltreumUI.unitframes.UFmodifications or not E.db.ElvUI_EltreumUI.unitframes.models.powerbar) end,
								get = function() return E.db.ElvUI_EltreumUI.unitframes.models.modeltypepower end,
								set = function(_, value) E.db.ElvUI_EltreumUI.unitframes.models.modeltypepower = value ElvUI_EltreumUI:PlayerUFEffects() end,
							},
							custommodelpathpower = {
								order = 127,
								type = 'input',
								name = function()
									if E.Retail then
										return L["Type the Model ID, such as 165821"]
									else
										return L["Type the Model Path, such as spells/corruption_impactdot_med_base.m2"]
									end
								end,
								width = 'full',
								disabled = function() return E.db.ElvUI_EltreumUI.unitframes.models.modeltypepower == "DEFAULT" or (not E.db.ElvUI_EltreumUI.unitframes.UFmodifications or not E.db.ElvUI_EltreumUI.unitframes.models.powerbar) end,
								validate = function(_, value)
									E.PopupDialogs["ELTRUISMINVALIDMODELPOWER"] = {
										text = L["Invalid Model, you need to add a Model ID/Path"],
										button1 = OKAY,
										timeout = 0,
										whileDead = 1,
										hideOnEscape = true,
									}
									if E.Retail then
										if tonumber(value) ~= nil then
											return true
										else
											return E:StaticPopup_Show('ELTRUISMINVALIDMODELPOWER') and false
										end
									else
										return true
									end
								end,
								get = function()
									if E.Retail then
										return tostring(E.db.ElvUI_EltreumUI.unitframes.models.custommodelpower)
									else
										return tostring(E.db.ElvUI_EltreumUI.unitframes.models.custommodelclassicpower)
									end
								end,
								set = function(_, value)
									if E.Retail then
										E.db.ElvUI_EltreumUI.unitframes.models.custommodelpower = tonumber(value)
									else
										E.db.ElvUI_EltreumUI.unitframes.models.custommodelclassicpower = tostring(value)
									end
									ElvUI_EltreumUI:PlayerUFEffects()
								end,
							},
						},
					},
				},
			},
			weakauras = {
				type = 'group',
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\weakauras',
				name = L["WeakAuras"],
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
			},
			credits = {
				type = 'group',
				name = L["Credits"],
				icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\credits',
				order = 97,
				args = {
					author = {
						order = 1,
						type = 'group',
						inline = true,
						name = L["Author"],
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
						name = L["Credits and Thank yous"],
						args = {
							desc = {
								order = 1,
								type = 'description',
								fontSize = 'medium',
								name = THANKYOU_STRING,
							},
						},
					},
					donatorss = {
						order = 3,
						type = 'group',
						inline = true,
						name = L["Donators"],
						args = {
							desc = {
								order = 1,
								type = 'description',
								fontSize = 'medium',
								name = DONATORS_STRING,
							},
						},
					},
					translators = {
						order = 4,
						type = 'group',
						inline = true,
						name = L["Translators"],
						args = {
							desc = {
								order = 1,
								type = 'description',
								fontSize = 'medium',
								name = TRANSLATORS_STRING,
							},
						},
					},
					licensewarning = {
						order = 99,
						type = 'group',
						inline = true,
						name = L["License"],
						args = {
							desc = {
								order = 1,
								type = 'description',
								fontSize = 'medium',
								name = function()
									if E.Retail then
										return 'Cursor is a fork of CastCursor by michaelsp which licensed under GNU GPLv3\nCursor Cooldowns is a fork of CooldownToGo by mitchnull which is licensed under Public Domain\nExpand Hunter Stables is merged from Improved Stable Frame by Cybeloras which is licensed under GNU GPLv3\nIcons8 (www.icons8.com) for some of the icons. List in license.txt\nLootText is a fork of SLoTe from xavjer which is licensed under GNU GPLv3\nRogue Door Opener is a fork of Rogue Door Opener by Burzolog which licensed under GNU GPLv3\nLoot Icons are merged from Chat Loot Icons by Stanzilla which is licensed under Public Domain\nQuest Items is a merge of QBar by Aezay, which is licensed under GNU GPLv3\nCooldown is a fork of discoteq\'s Doom Cooldown Pulse which is licensed under MIT License'
									else
										return 'Cursor is a fork of CastCursor by michaelsp which licensed under GNU GPLv3\nCursor Cooldowns is a fork of CooldownToGo by mitchnull which is licensed under Public Domain\nIcons8 (www.icons8.com) for some of the icons. List in license.txt\nLootText is a fork of SLoTe from xavjer which is licensed under GNU GPLv3\nLoot Icons are merged from Chat Loot Icons by Stanzilla which is licensed under Public Domain\nThe Item Level shown on the Character Panel Skin uses code from Simple Item level by Kemayo, licensed under BSD\nQuest Items is a merge of QBar by Aezay, which is licensed under GNU GPLv3\nSockets and Enchants is a fork of Kibs Item Levels by Kibsgaard which is licensed under Public Domain'
									end
								end,
							},
						},
					},
				},
			},
			support = {
				type = 'group',
				name = GAMEMENU_SUPPORT,
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
						get = function()
							if E.Retail then
								return 'https://www.tukui.org/addons.php?id=209'
							elseif E.Wrath then
								return 'https://www.tukui.org/classic-wotlk-addons.php?id=10'
							elseif E.Classic then
								return 'https://www.tukui.org/classic-addons.php?id=49'
							end
						end,
					},
					curse = {
						order = 4,
						type = 'input',
						width = 'full',
						name = L["Addon on CurseForge:"],
						get = function() return 'https://www.curseforge.com/wow/addons/elvui-eltruism' end,
					},
					wago = {
						order = 5,
						type = 'input',
						width = 'full',
						name = L["Addon on Wago:"],
						get = function() return 'https://addons.wago.io/addons/elvui-eltruism' end,
					},
				},
			},
		},
	}
	for _, func in pairs(ElvUI_EltreumUI.Config) do
		func()
	end
end

--in case i split options into modules
--[[
tinsert(ElvUI_EltreumUI.Config, function()
	E.Config.args.ElvUI_EltreumUI.args.NAMEOFOPTION = {
		type = 'group',
		name = "SOME NAME HERE",
		icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\aurafilter',
		childGroups = "tab",
		order = 15,
		args = {
			someoption = {
			},
		},
	}
end)
]]
