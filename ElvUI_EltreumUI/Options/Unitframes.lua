local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

function ElvUI_EltreumUI:UnitframesOptions()
	local unitframes = {
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
						get = function() return E.db.ElvUI_EltreumUI.UFmodifications end,
						set = function(_, value) E.db.ElvUI_EltreumUI.UFmodifications = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					uftypeselect = {
						type = "description",
						name = L["Choose between custom textures or gradient mode"],
						order = 2,
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					unitframesenable = {
						order = 3,
						name = L["Enable Custom Textures"],
						type = "toggle",
						desc = L["Enable Custom Textures"],
						width = 'full',
						disabled = function() return E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.UFmodifications end,
						get = function() return E.db.ElvUI_EltreumUI.ufcustomtexture.enable end,
						set = function(_, value) E.db.ElvUI_EltreumUI.ufcustomtexture.enable = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					enablegradient = {
						order = 3,
						type = 'toggle',
						name = L["Enable Gradient (Requires Dark or Light Modes)"],
						desc = L["Enable Gradient colors for Health"],
						width = 'full',
						disabled = function() return E.db.ElvUI_EltreumUI.ufcustomtexture.enable or not E.db.ElvUI_EltreumUI.UFmodifications end,
						get = function() return E.db.ElvUI_EltreumUI.gradientmode.enable end,
						set = function(_, value) E.db.ElvUI_EltreumUI.gradientmode.enable = value E:StaticPopup_Show('CONFIG_RL') end,
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
						disabled = function() return E.db.ElvUI_EltreumUI.lightmode or not E.db.ElvUI_EltreumUI.UFmodifications end,
						get = function() return E.db.ElvUI_EltreumUI.darkmode end,
						set = function(_, value) E.db.ElvUI_EltreumUI.darkmode = value end,
					},
					light = {
						order = 97,
						type = 'toggle',
						name = L["Light Mode"],
						width = 'full',
						desc = L["This will set colors to class based with black backgrounds when losing health"],
						disabled = function() return E.db.ElvUI_EltreumUI.darkmode or not E.db.ElvUI_EltreumUI.UFmodifications end,
						get = function() return E.db.ElvUI_EltreumUI.lightmode end,
						set = function(_, value) E.db.ElvUI_EltreumUI.lightmode = value end,
					},
					applymode = {
						order = 98,
						type = 'execute',
						name = L["Apply"],
						--width = 'full',
						desc = L["Apply the mode selected"],
						disabled = function() return (not E.db.ElvUI_EltreumUI.UFmodifications) or (not (E.db.ElvUI_EltreumUI.lightmode or E.db.ElvUI_EltreumUI.darkmode)) end,
						func = function()
							if E.db.ElvUI_EltreumUI.lightmode == true then
								ElvUI_EltreumUI:LightMode()
								E:StaggeredUpdateAll(nil, true)
							elseif E.db.ElvUI_EltreumUI.darkmode == true then
								ElvUI_EltreumUI:DarkMode()
								E:StaggeredUpdateAll(nil, true)
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
						--desc = L["Choose the direction of the gradient"],
						order = 100,
						values = {
							["V1"] = L["Version 1"],
							["V2"] = L["Version 2"],
							["V3"] = L["Version 3"],
						},
						style = 'radio',
						disabled = function() return E.db.ElvUI_EltreumUI.ufcustomtexture.enable or not E.db.ElvUI_EltreumUI.UFmodifications end,
						get = function() return E.db.ElvUI_EltreumUI.uftextureversion end,
						set = function(_, value) E.db.ElvUI_EltreumUI.uftextureversion = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					headerufbackdrop = {
						order = 984,
						type = "description",
						name = L["Backdrops"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					ufbackdropTex = {
						order = 985,
						type = 'select',
						--width = "double",
						dialogControl = 'LSM30_Statusbar',
						name = L["Backdrop Texture"],
						desc = L["Select a Texture"],
						values = AceGUIWidgetLSMlists.statusbar,
						disabled = function() return E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.UFmodifications end,
						get = function() return E.db.ElvUI_EltreumUI.ufcustomtexture.backdroptexture end,
						set = function(self,key) E.db.ElvUI_EltreumUI.ufcustomtexture.backdroptexture = key end,
					},
					backdropgap = {
						order = 986,
						type = "description",
						name = "",
						width = "full",
					},
					ufbackdropTexalpha = {
						type = 'range',
						name = L["Backdrop Alpha"],
						desc = L["Change the transparency of the backdrop"],
						order = 987,
						min = 0.1,
						max = 1,
						step = 0.01,
						--width = "full",
						disabled = function() return not E.db.ElvUI_EltreumUI.UFmodifications end,
						get = function() return E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha end,
						set = function(_, value) E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha = value end,
					},
					darkpowerdesc = {
						order = 988,
						type = "description",
						name = L["Change the Class Power background"],
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
						width = "full",
					},
					darkpowerenable = {
						order = 989,
						type = 'toggle',
						width = "full",
						name = L["Dark Power Background"],
						desc = L["Sets Class Power backgrounds to be black"],
						get = function() return E.db.ElvUI_EltreumUI.darkpowercolor end,
						set = function(_, value) E.db.ElvUI_EltreumUI.darkpowercolor = value end,
					},
					header8898 = {
						order = 990,
						type = "description",
						name = "",
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					castbarspark = {
						order = 991,
						type = "description",
						name = L["Customize the player castbar spark"],
						width = "full",
					},
					castbarsparkenable = {
						order = 992,
						type = 'toggle',
						name = L["Enable"],
						width = "full",
						desc = L["Customize Player CastBar Spark"],
						get = function() return E.db.ElvUI_EltreumUI.sparkcustomcolor.enable end,
						set = function(_, value) E.db.ElvUI_EltreumUI.sparkcustomcolor.enable = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					colorspark = {
						order = 993,
						type = 'color',
						name = L["Custom Color"],
						hasAlpha = false,
						disabled = function() return not E.db.ElvUI_EltreumUI.sparkcustomcolor.enable end,
						get = function()
							local glowcustomcolor = E.db.ElvUI_EltreumUI.sparkcustomcolor
							local d = P.ElvUI_EltreumUI.sparkcustomcolor
							return glowcustomcolor.r, glowcustomcolor.g, glowcustomcolor.b, glowcustomcolor.a, d.r, d.g, d.b, d.a
						end,
						set = function(_, r, g, b, a)
							local glowcustomcolor = E.db.ElvUI_EltreumUI.sparkcustomcolor
							glowcustomcolor.r, glowcustomcolor.g, glowcustomcolor.b = r, g, b E:StaticPopup_Show('CONFIG_RL')
						end,
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
						disabled = function() return not E.db.ElvUI_EltreumUI.sparkcustomcolor.enable end,
						get = function() return E.db.ElvUI_EltreumUI.sparkcustomcolor.width end,
						set = function(_, value) E.db.ElvUI_EltreumUI.sparkcustomcolor.width = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					headergaphere = {
						order = 995,
						type = "description",
						name = L["Alternative unitframe layouts"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					layoutdescriptiongap = {
						order = 996,
						type = 'description',
						name = "",
						width = "full",
					},
					layoutdescription = {
						order = 997,
						type = 'description',
						fontSize = 'medium',
						name = L["DPS/Tank layouts were created with pure dps classes in mind, if you play a class with more raid cooldowns like a Shaman, Druid or Paladin you might want to use the alternative layout in order to make it easier for you to use your cooldowns on the members of your group"],
					},
					alternativegroups = {
						order = 998,
						type = 'execute',
						name = L["Alternative Layout"],
						func = function() ElvUI_EltreumUI:AlternativeGroupsDPS() end,
					},
					originalgroups = {
						order = 999,
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
				disabled = function() return E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.UFmodifications or not E.db.ElvUI_EltreumUI.ufcustomtexture.enable end,
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
						disabled = function() return not E.db.ElvUI_EltreumUI.ufcustomtexture.enable end,
						get = function() return E.db.ElvUI_EltreumUI.ufcustomtexture.classdetect end,
						set = function(_, value) E.db.ElvUI_EltreumUI.ufcustomtexture.classdetect = value end,
					},
					playertexture = {
						order = 104,
						type = 'select',
						width = "double",
						dialogControl = 'LSM30_Statusbar',
						name = L["Player Texture"],
						desc = L["Select a Texture"],
						values = AceGUIWidgetLSMlists.statusbar,
						disabled = function() return not E.db.ElvUI_EltreumUI.ufcustomtexture.enable end,
						get = function() return E.db.ElvUI_EltreumUI.ufcustomtexture.playertexture end,
						set = function(self,key) E.db.ElvUI_EltreumUI.ufcustomtexture.playertexture = key ElvUI_EltreumUI:GradientCustomTexture() end,
					},
					castbartex = {
						order = 105,
						type = 'select',
						width = "double",
						dialogControl = 'LSM30_Statusbar',
						name = L["Player Castbar Texture"],
						desc = L["Select a Texture"],
						values = AceGUIWidgetLSMlists.statusbar,
						disabled = function() return not E.db.ElvUI_EltreumUI.ufcustomtexture.enable end,
						get = function() return E.db.ElvUI_EltreumUI.ufcustomtexture.castbartexture end,
						set = function(self,key) E.db.ElvUI_EltreumUI.ufcustomtexture.castbartexture = key end,
					},
					targettexture = {
						order = 106,
						type = 'select',
						width = "double",
						dialogControl = 'LSM30_Statusbar',
						name = L["Target Texture"],
						desc = L["Select a Texture"],
						values = AceGUIWidgetLSMlists.statusbar,
						disabled = function() return not E.db.ElvUI_EltreumUI.ufcustomtexture.enable end,
						get = function() return E.db.ElvUI_EltreumUI.ufcustomtexture.targettexture end,
						set = function(self,key) E.db.ElvUI_EltreumUI.ufcustomtexture.targettexture = key end,
					},
					targettargettexture = {
						order = 107,
						type = 'select',
						width = "double",
						dialogControl = 'LSM30_Statusbar',
						name = L["Target of Target Texture"],
						desc = L["Select a Texture"],
						values = AceGUIWidgetLSMlists.statusbar,
						disabled = function() return not E.db.ElvUI_EltreumUI.ufcustomtexture.enable end,
						get = function() return E.db.ElvUI_EltreumUI.ufcustomtexture.targettargettexture end,
						set = function(self,key) E.db.ElvUI_EltreumUI.ufcustomtexture.targettargettexture = key end,
					},
					targettargettargettexture = {
						order = 107,
						type = 'select',
						width = "double",
						dialogControl = 'LSM30_Statusbar',
						name = L["Target of Target of Target Texture"],
						desc = L["Select a Texture"],
						values = AceGUIWidgetLSMlists.statusbar,
						disabled = function() return not E.db.ElvUI_EltreumUI.ufcustomtexture.enable end,
						get = function() return E.db.ElvUI_EltreumUI.ufcustomtexture.targettargettargettexture end,
						set = function(self,key) E.db.ElvUI_EltreumUI.ufcustomtexture.targettargettargettexture = key end,
					},
					focustexture = {
						order = 108,
						type = 'select',
						width = "double",
						dialogControl = 'LSM30_Statusbar',
						name = L["Focus Texture"],
						desc = L["Select a Texture"],
						values = AceGUIWidgetLSMlists.statusbar,
						disabled = function() return not E.db.ElvUI_EltreumUI.ufcustomtexture.enable end,
						get = function() return E.db.ElvUI_EltreumUI.ufcustomtexture.focustexture end,
						set = function(self,key) E.db.ElvUI_EltreumUI.ufcustomtexture.focustexture = key end,
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
						disabled = function() return not E.db.ElvUI_EltreumUI.ufcustomtexture.enable end,
						get = function() return E.db.ElvUI_EltreumUI.ufcustomtexture.deathknighttexture end,
						set = function(self,key) E.db.ElvUI_EltreumUI.ufcustomtexture.deathknighttexture = key end,
					},
					druidtexture = {
						order = 110,
						type = 'select',
						width = "double",
						dialogControl = 'LSM30_Statusbar',
						name = L["Druid"],
						desc = L["Select a Texture"],
						values = AceGUIWidgetLSMlists.statusbar,
						disabled = function() return not E.db.ElvUI_EltreumUI.ufcustomtexture.enable end,
						get = function() return E.db.ElvUI_EltreumUI.ufcustomtexture.druidtexture end,
						set = function(self,key) E.db.ElvUI_EltreumUI.ufcustomtexture.druidtexture = key end,
					},
					huntertexture = {
						order = 110,
						type = 'select',
						width = "double",
						dialogControl = 'LSM30_Statusbar',
						name = L["Hunter"],
						desc = L["Select a Texture"],
						values = AceGUIWidgetLSMlists.statusbar,
						disabled = function() return not E.db.ElvUI_EltreumUI.ufcustomtexture.enable end,
						get = function() return E.db.ElvUI_EltreumUI.ufcustomtexture.huntertexture end,
						set = function(self,key) E.db.ElvUI_EltreumUI.ufcustomtexture.huntertexture = key end,
					},
					magetexture = {
						order = 110,
						type = 'select',
						width = "double",
						dialogControl = 'LSM30_Statusbar',
						name = L["Mage"],
						desc = L["Select a Texture"],
						values = AceGUIWidgetLSMlists.statusbar,
						disabled = function() return not E.db.ElvUI_EltreumUI.ufcustomtexture.enable end,
						get = function() return E.db.ElvUI_EltreumUI.ufcustomtexture.magetexture end,
						set = function(self,key) E.db.ElvUI_EltreumUI.ufcustomtexture.magetexture = key end,
					},
					paladintexture = {
						order = 110,
						type = 'select',
						width = "double",
						dialogControl = 'LSM30_Statusbar',
						name = L["Paladin"],
						desc = L["Select a Texture"],
						values = AceGUIWidgetLSMlists.statusbar,
						disabled = function() return not E.db.ElvUI_EltreumUI.ufcustomtexture.enable end,
						get = function() return E.db.ElvUI_EltreumUI.ufcustomtexture.paladintexture end,
						set = function(self,key) E.db.ElvUI_EltreumUI.ufcustomtexture.paladintexture = key end,
					},
					priesttexture = {
						order = 110,
						type = 'select',
						width = "double",
						dialogControl = 'LSM30_Statusbar',
						name = L["Priest"],
						desc = L["Select a Texture"],
						values = AceGUIWidgetLSMlists.statusbar,
						disabled = function() return not E.db.ElvUI_EltreumUI.ufcustomtexture.enable end,
						get = function() return E.db.ElvUI_EltreumUI.ufcustomtexture.priesttexture end,
						set = function(self,key) E.db.ElvUI_EltreumUI.ufcustomtexture.priesttexture = key end,
					},
					roguetexture = {
						order = 110,
						type = 'select',
						width = "double",
						dialogControl = 'LSM30_Statusbar',
						name = L["Rogue"],
						desc = L["Select a Texture"],
						values = AceGUIWidgetLSMlists.statusbar,
						disabled = function() return not E.db.ElvUI_EltreumUI.ufcustomtexture.enable end,
						get = function() return E.db.ElvUI_EltreumUI.ufcustomtexture.roguetexture end,
						set = function(self,key) E.db.ElvUI_EltreumUI.ufcustomtexture.roguetexture = key end,
					},
					shamantexture = {
						order = 110,
						type = 'select',
						width = "double",
						dialogControl = 'LSM30_Statusbar',
						name = L["Shaman"],
						desc = L["Select a Texture"],
						values = AceGUIWidgetLSMlists.statusbar,
						disabled = function() return not E.db.ElvUI_EltreumUI.ufcustomtexture.enable end,
						get = function() return E.db.ElvUI_EltreumUI.ufcustomtexture.shamantexture end,
						set = function(self,key) E.db.ElvUI_EltreumUI.ufcustomtexture.shamantexture = key end,
					},
					warlocktexture = {
						order = 110,
						type = 'select',
						width = "double",
						dialogControl = 'LSM30_Statusbar',
						name = L["Warlock"],
						desc = L["Select a Texture"],
						values = AceGUIWidgetLSMlists.statusbar,
						disabled = function() return not E.db.ElvUI_EltreumUI.ufcustomtexture.enable end,
						get = function() return E.db.ElvUI_EltreumUI.ufcustomtexture.warlocktexture end,
						set = function(self,key) E.db.ElvUI_EltreumUI.ufcustomtexture.warlocktexture = key end,
					},
					warriortexture = {
						order = 110,
						type = 'select',
						width = "double",
						dialogControl = 'LSM30_Statusbar',
						name = L["Warrior"],
						desc = L["Select a Texture"],
						values = AceGUIWidgetLSMlists.statusbar,
						disabled = function() return not E.db.ElvUI_EltreumUI.ufcustomtexture.enable end,
						get = function() return E.db.ElvUI_EltreumUI.ufcustomtexture.warriortexture end,
						set = function(self,key) E.db.ElvUI_EltreumUI.ufcustomtexture.warriortexture = key end,
					},
					npcfriendlytexture = {
						order = 111,
						type = 'select',
						width = "double",
						dialogControl = 'LSM30_Statusbar',
						name = L["Friendly NPC"],
						desc = L["Select a Texture"],
						values = AceGUIWidgetLSMlists.statusbar,
						disabled = function() return not E.db.ElvUI_EltreumUI.ufcustomtexture.enable end,
						get = function() return E.db.ElvUI_EltreumUI.ufcustomtexture.npcfriendly end,
						set = function(self,key) E.db.ElvUI_EltreumUI.ufcustomtexture.npcfriendly = key end,
					},
					npcneutraltexture = {
						order = 111,
						type = 'select',
						width = "double",
						dialogControl = 'LSM30_Statusbar',
						name = L["Neutral NPC"],
						desc = L["Select a Texture"],
						values = AceGUIWidgetLSMlists.statusbar,
						disabled = function() return not E.db.ElvUI_EltreumUI.ufcustomtexture.enable end,
						get = function() return E.db.ElvUI_EltreumUI.ufcustomtexture.npcneutral end,
						set = function(self,key) E.db.ElvUI_EltreumUI.ufcustomtexture.npcneutral = key end,
					},
					npcunfriendlytexture = {
						order = 111,
						type = 'select',
						width = "double",
						dialogControl = 'LSM30_Statusbar',
						name = L["Unfriendly NPC"],
						desc = L["Select a Texture"],
						values = AceGUIWidgetLSMlists.statusbar,
						disabled = function() return not E.db.ElvUI_EltreumUI.ufcustomtexture.enable end,
						get = function() return E.db.ElvUI_EltreumUI.ufcustomtexture.npcunfriendly end,
						set = function(self,key) E.db.ElvUI_EltreumUI.ufcustomtexture.npcunfriendly = key end,
					},
					npchostiletexture = {
						order = 111,
						type = 'select',
						width = "double",
						dialogControl = 'LSM30_Statusbar',
						name = L["Hostile NPC"],
						desc = L["Select a Texture"],
						values = AceGUIWidgetLSMlists.statusbar,
						disabled = function() return not E.db.ElvUI_EltreumUI.ufcustomtexture.enable end,
						get = function() return E.db.ElvUI_EltreumUI.ufcustomtexture.npchostile end,
						set = function(self,key) E.db.ElvUI_EltreumUI.ufcustomtexture.npchostile = key end,
					},
				},
			},
			gradient = {
				type = "group",
				name = L["Gradient"],
				order = 3,
				disabled = function() return E.db.ElvUI_EltreumUI.ufcustomtexture.enable or not E.db.ElvUI_EltreumUI.UFmodifications or not E.db.ElvUI_EltreumUI.gradientmode.enable end,
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
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable end,
						get = function() return E.db.ElvUI_EltreumUI.gradientmode.enableplayer end,
						set = function(_, value) E.db.ElvUI_EltreumUI.gradientmode.enableplayer = value end,
					},
					enabletarget = {
						order = 2,
						type = 'toggle',
						name = L["Enable for Target"],
						desc = L["Enable Gradient colors for Health"],
						width = 'full',
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable end,
						get = function() return E.db.ElvUI_EltreumUI.gradientmode.enabletarget end,
						set = function(_, value) E.db.ElvUI_EltreumUI.gradientmode.enabletarget = value end,
					},
					enabletargettarget = {
						order = 2,
						type = 'toggle',
						name = L["Enable for Target of Target"],
						desc = L["Enable Gradient colors for Health"],
						width = 'full',
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable end,
						get = function() return E.db.ElvUI_EltreumUI.gradientmode.enabletargettarget end,
						set = function(_, value) E.db.ElvUI_EltreumUI.gradientmode.enabletargettarget = value end,
					},
					enabletargettargettarget = {
						order = 2,
						type = 'toggle',
						name = L["Enable for Target of Target of Target"],
						desc = L["Enable Gradient colors for Health"],
						width = 'full',
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable end,
						get = function() return E.db.ElvUI_EltreumUI.gradientmode.enabletargettargettarget end,
						set = function(_, value) E.db.ElvUI_EltreumUI.gradientmode.enabletargettargettarget = value end,
					},
					enablefocus = {
						order = 2,
						type = 'toggle',
						name = L["Enable for Focus"],
						desc = L["Enable Gradient colors for Health"],
						width = 'full',
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable end,
						get = function() return E.db.ElvUI_EltreumUI.gradientmode.enablefocus end,
						set = function(_, value) E.db.ElvUI_EltreumUI.gradientmode.enablefocus = value end,
					},
					enablearena = {
						order = 2,
						type = 'toggle',
						name = L["Enable for Arena"],
						desc = L["Enable Gradient colors for Health"],
						width = 'full',
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable end,
						get = function() return E.db.ElvUI_EltreumUI.gradientmode.enablearena end,
						set = function(_, value) E.db.ElvUI_EltreumUI.gradientmode.enablearena = value end,
					},
					enablegroupunits = {
						order = 2,
						type = 'toggle',
						name = L["Enable for Group Units"],
						desc = L["Enable Gradient colors for Health"],
						width = 'full',
						--disabled = function() return true end,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable end,
						get = function() return E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits end,
						set = function(_, value) E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits = value end,
					},
					enablecastbargradient = {
						order = 2,
						type = 'toggle',
						name = L["Enable for Player Castbar"],
						desc = L["Enable Gradient colors for Player Castbar"],
						width = 'full',
						--disabled = function() return true end,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable end,
						get = function() return E.db.ElvUI_EltreumUI.gradientmode.enableplayercastbar end,
						set = function(_, value) E.db.ElvUI_EltreumUI.gradientmode.enableplayercastbar = value end,
					},
					enablecastbargradientnoninterruptplayer = {
						order = 2,
						type = 'toggle',
						name = L["Enable for Player Castbar (Non Interruptible)"],
						desc = L["Enable Gradient colors for Player Castbar (Non Interruptible)"],
						width = 'full',
						--disabled = function() return true end,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable end,
						get = function() return E.db.ElvUI_EltreumUI.gradientmode.enableplayercastbarnoninterruptible end,
						set = function(_, value) E.db.ElvUI_EltreumUI.gradientmode.enableplayercastbarnoninterruptible = value end,
					},
					enablecastbargradientinterruptedplayer = {
						order = 2,
						type = 'toggle',
						name = L["Enable for Player Castbar (Interrupted)"],
						desc = L["Enable Gradient colors for Player Castbar (Interrupted)"],
						width = 'full',
						--disabled = function() return true end,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable end,
						get = function() return E.db.ElvUI_EltreumUI.gradientmode.enableplayercastbarinterrupted end,
						set = function(_, value) E.db.ElvUI_EltreumUI.gradientmode.enableplayercastbarinterrupted = value end,
					},
					enabletargetcastbargradient = {
						order = 2,
						type = 'toggle',
						name = L["Enable for Target Castbar"],
						desc = L["Enable Gradient colors for Target Castbar"],
						width = 'full',
						--disabled = function() return true end,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable end,
						get = function() return E.db.ElvUI_EltreumUI.gradientmode.enabletargetcastbar end,
						set = function(_, value) E.db.ElvUI_EltreumUI.gradientmode.enabletargetcastbar = value end,
					},
					enablecastbargradientnoninterrupttarget = {
						order = 2,
						type = 'toggle',
						name = L["Enable for Target Castbar (Non Interruptible)"],
						desc = L["Enable Gradient colors for Target Castbar (Non Interruptible)"],
						width = 'full',
						--disabled = function() return true end,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable end,
						get = function() return E.db.ElvUI_EltreumUI.gradientmode.enabletargetcastbarnoninterruptible end,
						set = function(_, value) E.db.ElvUI_EltreumUI.gradientmode.enabletargetcastbarnoninterruptible = value end,
					},
					enablecastbargradientinterruptedtarget = {
						order = 2,
						type = 'toggle',
						name = L["Enable for Target Castbar (Interrupted)"],
						desc = L["Enable Gradient colors for Target Castbar (Interrupted)"],
						width = 'full',
						--disabled = function() return true end,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable end,
						get = function() return E.db.ElvUI_EltreumUI.gradientmode.enabletargetcastbarinterrupted end,
						set = function(_, value) E.db.ElvUI_EltreumUI.gradientmode.enabletargetcastbarinterrupted = value end,
					},
					enablecustomcolor = {
						order = 3,
						type = 'toggle',
						name = L["Custom Color"],
						desc = L["Enable Custom Colors"],
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable end,
						get = function() return E.db.ElvUI_EltreumUI.gradientmode.customcolor end,
						set = function(_, value) E.db.ElvUI_EltreumUI.gradientmode.customcolor = value ElvUI_EltreumUI:GradientColorTableUpdate() end,
					},
					gradientorientation = {
						type = 'select',
						name = L["Gradient Orientation"],
						desc = L["Choose the direction of the gradient"],
						order = 3,
						values = {
							["HORIZONTAL"] = L["Horizontal"],
							["VERTICAL"] = L["Vertical"],
						},
						style = 'radio',
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable end,
						get = function() return E.db.ElvUI_EltreumUI.gradientmode.orientation end,
						set = function(_, value) E.db.ElvUI_EltreumUI.gradientmode.orientation = value end,
					},
					gradienttexture = {
						order = 3,
						type = 'select',
						width = "double",
						dialogControl = 'LSM30_Statusbar',
						name = L["Gradient Texture"],
						desc = L["Select a Texture"],
						values = AceGUIWidgetLSMlists.statusbar,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable end,
						get = function() return E.db.ElvUI_EltreumUI.gradientmode.texture end,
						set = function(self,key) E.db.ElvUI_EltreumUI.gradientmode.texture = key ElvUI_EltreumUI:GradientCustomTexture() end,
					},
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
						disabled = function() return E.db.ElvUI_EltreumUI.gradientmode.classcolorplayercastbar or not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor or not E.db.ElvUI_EltreumUI.gradientmode.enableplayercastbar end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.playercastbarR1
							local dg = P.ElvUI_EltreumUI.gradientmode.playercastbarG1
							local db = P.ElvUI_EltreumUI.gradientmode.playercastbarB1
							return E.db.ElvUI_EltreumUI.gradientmode.playercastbarR1, E.db.ElvUI_EltreumUI.gradientmode.playercastbarG1, E.db.ElvUI_EltreumUI.gradientmode.playercastbarB1, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.playercastbarR1, E.db.ElvUI_EltreumUI.gradientmode.playercastbarG1, E.db.ElvUI_EltreumUI.gradientmode.playercastbarB1 = r, g, b
						end,
					},
					gradientcast2 = {
						order = 6,
						type = 'color',
						name = L["Color 2"],
						hasAlpha = false,
						disabled = function() return E.db.ElvUI_EltreumUI.gradientmode.classcolorplayercastbar or not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor or not E.db.ElvUI_EltreumUI.gradientmode.enableplayercastbar end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.playercastbarR2
							local dg = P.ElvUI_EltreumUI.gradientmode.playercastbarG2
							local db = P.ElvUI_EltreumUI.gradientmode.playercastbarB2
							return E.db.ElvUI_EltreumUI.gradientmode.playercastbarR2, E.db.ElvUI_EltreumUI.gradientmode.playercastbarG2, E.db.ElvUI_EltreumUI.gradientmode.playercastbarB2, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.playercastbarR2, E.db.ElvUI_EltreumUI.gradientmode.playercastbarG2, E.db.ElvUI_EltreumUI.gradientmode.playercastbarB2 = r, g, b
						end,
					},
					checkelvuiclasscolorcastbar = {
						order = 7,
						type = 'toggle',
						name = L["Class Colors"],
						desc = L["Use Class Colors instead of Custom Colors"],
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor or not E.db.ElvUI_EltreumUI.gradientmode.enableplayercastbar end,
						get = function() return E.db.ElvUI_EltreumUI.gradientmode.classcolorplayercastbar end,
						set = function(_, value) E.db.ElvUI_EltreumUI.gradientmode.classcolorplayercastbar = value end,
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
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor or not E.db.ElvUI_EltreumUI.gradientmode.enableplayercastbarnoninterruptible end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.playercastbarR1noninterruptible
							local dg = P.ElvUI_EltreumUI.gradientmode.playercastbarG1noninterruptible
							local db = P.ElvUI_EltreumUI.gradientmode.playercastbarB1noninterruptible
							return E.db.ElvUI_EltreumUI.gradientmode.playercastbarR1noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarG1noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarB1noninterruptiblecustom, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.playercastbarR1noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarG1noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarB1noninterruptiblecustom = r, g, b
						end,
					},
					gradientcast2cantinterruptplayer = {
						order = 9,
						type = 'color',
						name = L["Color 2"],
						hasAlpha = false,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor or not E.db.ElvUI_EltreumUI.gradientmode.enableplayercastbarnoninterruptible end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.playercastbarR2noninterruptible
							local dg = P.ElvUI_EltreumUI.gradientmode.playercastbarG2noninterruptible
							local db = P.ElvUI_EltreumUI.gradientmode.playercastbarB2noninterruptible
							return E.db.ElvUI_EltreumUI.gradientmode.playercastbarR2noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarG2noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarB2noninterruptiblecustom, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.playercastbarR2noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarG2noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarB2noninterruptiblecustom = r, g, b
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
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor or not E.db.ElvUI_EltreumUI.gradientmode.enableplayercastbarinterrupted end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.playercastbarR1interrupted
							local dg = P.ElvUI_EltreumUI.gradientmode.playercastbarG1interrupted
							local db = P.ElvUI_EltreumUI.gradientmode.playercastbarB1interrupted
							return E.db.ElvUI_EltreumUI.gradientmode.playercastbarR1interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarG1interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarB1interruptedcustom, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.playercastbarR1interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarG1interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarB1interruptedcustom = r, g, b
						end,
					},
					gradientcast2interruptedplayer = {
						order = 12,
						type = 'color',
						name = L["Color 2"],
						hasAlpha = false,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor or not E.db.ElvUI_EltreumUI.gradientmode.enableplayercastbarinterrupted end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.playercastbarR2interrupted
							local dg = P.ElvUI_EltreumUI.gradientmode.playercastbarG2interrupted
							local db = P.ElvUI_EltreumUI.gradientmode.playercastbarB2interrupted
							return E.db.ElvUI_EltreumUI.gradientmode.playercastbarR2interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarG2interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarB2interruptedcustom, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.playercastbarR2interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarG2interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarB2interruptedcustom = r, g, b
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
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor or not E.db.ElvUI_EltreumUI.gradientmode.enabletargetcastbar end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.targetcastbarR1
							local dg = P.ElvUI_EltreumUI.gradientmode.targetcastbarG1
							local db = P.ElvUI_EltreumUI.gradientmode.targetcastbarB1
							return E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR1custom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG1custom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB1custom, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR1custom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG1custom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB1custom = r, g, b
						end,
					},
					gradientcast2target = {
						order = 15,
						type = 'color',
						name = L["Color 2"],
						hasAlpha = false,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor or not E.db.ElvUI_EltreumUI.gradientmode.enabletargetcastbar end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.targetcastbarR2
							local dg = P.ElvUI_EltreumUI.gradientmode.targetcastbarG2
							local db = P.ElvUI_EltreumUI.gradientmode.targetcastbarB2
							return E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR2custom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG2custom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB2custom, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR2custom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG2custom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB2custom = r, g, b
						end,
					},
					checkelvuiclasscolorcastbartarget = {
						order = 16,
						type = 'toggle',
						name = L["Class Colors"],
						desc = L["Use Class Colors instead of Custom Colors"],
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor or not E.db.ElvUI_EltreumUI.gradientmode.enabletargetcastbar end,
						get = function() return E.db.ElvUI_EltreumUI.gradientmode.classcolortargetcastbar end,
						set = function(_, value) E.db.ElvUI_EltreumUI.gradientmode.classcolortargetcastbar = value end,
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
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor or not E.db.ElvUI_EltreumUI.gradientmode.enabletargetcastbarnoninterruptible end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.targetcastbarR1noninterruptible
							local dg = P.ElvUI_EltreumUI.gradientmode.targetcastbarG1noninterruptible
							local db = P.ElvUI_EltreumUI.gradientmode.targetcastbarB1noninterruptible
							return E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR1noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG1noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB1noninterruptiblecustom, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR1noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG1noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB1noninterruptiblecustom = r, g, b
						end,
					},
					gradientcast2noninterruptibletargetcustom = {
						order = 18,
						type = 'color',
						name = L["Color 2"],
						hasAlpha = false,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor or not E.db.ElvUI_EltreumUI.gradientmode.enabletargetcastbarnoninterruptible end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.targetcastbarR2noninterruptible
							local dg = P.ElvUI_EltreumUI.gradientmode.targetcastbarG2noninterruptible
							local db = P.ElvUI_EltreumUI.gradientmode.targetcastbarB2noninterruptible
							return E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR2noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG2noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB2noninterruptiblecustom, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR2noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG2noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB2noninterruptiblecustom = r, g, b
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
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor or not E.db.ElvUI_EltreumUI.gradientmode.enabletargetcastbarinterrupted end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.targetcastbarR1interrupted
							local dg = P.ElvUI_EltreumUI.gradientmode.targetcastbarG1interrupted
							local db = P.ElvUI_EltreumUI.gradientmode.targetcastbarB1interrupted
							return E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR1interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG1interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB1interruptedcustom, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR1interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG1interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB1interruptedcustom = r, g, b
						end,
					},
					gradientcast2interruptedtarget = {
						order = 21,
						type = 'color',
						name = L["Color 2"],
						hasAlpha = false,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor or not E.db.ElvUI_EltreumUI.gradientmode.enabletargetcastbarinterrupted end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.targetcastbarR2interrupted
							local dg = P.ElvUI_EltreumUI.gradientmode.targetcastbarG2interrupted
							local db = P.ElvUI_EltreumUI.gradientmode.targetcastbarB2interrupted
							return E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR2interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG2interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB2interruptedcustom, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR2interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG2interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB2interruptedcustom = r, g, b
						end,
					},
					header2 = {
						order = 64,
						type = "description",
						name = L["Death Knight"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					gradientdeathknight1 = {
						order = 65,
						type = 'color',
						name = L["Color 1"],
						hasAlpha = false,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.deathknightcustomcolorR1
							local dg = P.ElvUI_EltreumUI.gradientmode.deathknightcustomcolorG1
							local db = P.ElvUI_EltreumUI.gradientmode.deathknightcustomcolorB1
							return E.db.ElvUI_EltreumUI.gradientmode.deathknightcustomcolorR1, E.db.ElvUI_EltreumUI.gradientmode.deathknightcustomcolorG1, E.db.ElvUI_EltreumUI.gradientmode.deathknightcustomcolorB1, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.deathknightcustomcolorR1, E.db.ElvUI_EltreumUI.gradientmode.deathknightcustomcolorG1, E.db.ElvUI_EltreumUI.gradientmode.deathknightcustomcolorB1 = r, g, b
							ElvUI_EltreumUI:GradientColorTableUpdate()
						end,
					},
					gradientdeathknight2 = {
						order = 66,
						type = 'color',
						name = L["Color 2"],
						hasAlpha = false,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.deathknightcustomcolorR2
							local dg = P.ElvUI_EltreumUI.gradientmode.deathknightcustomcolorG2
							local db = P.ElvUI_EltreumUI.gradientmode.deathknightcustomcolorB2
							return E.db.ElvUI_EltreumUI.gradientmode.deathknightcustomcolorR2, E.db.ElvUI_EltreumUI.gradientmode.deathknightcustomcolorG2, E.db.ElvUI_EltreumUI.gradientmode.deathknightcustomcolorB2, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.deathknightcustomcolorR2, E.db.ElvUI_EltreumUI.gradientmode.deathknightcustomcolorG2, E.db.ElvUI_EltreumUI.gradientmode.deathknightcustomcolorB2 = r, g, b
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
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.druidcustomcolorR1
							local dg = P.ElvUI_EltreumUI.gradientmode.druidcustomcolorG1
							local db = P.ElvUI_EltreumUI.gradientmode.druidcustomcolorB1
							return E.db.ElvUI_EltreumUI.gradientmode.druidcustomcolorR1, E.db.ElvUI_EltreumUI.gradientmode.druidcustomcolorG1, E.db.ElvUI_EltreumUI.gradientmode.druidcustomcolorB1, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.druidcustomcolorR1, E.db.ElvUI_EltreumUI.gradientmode.druidcustomcolorG1, E.db.ElvUI_EltreumUI.gradientmode.druidcustomcolorB1 = r, g, b
							ElvUI_EltreumUI:GradientColorTableUpdate()
						end,
					},
					gradientdruid2 = {
						order = 72,
						type = 'color',
						name = L["Color 2"],
						hasAlpha = false,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.druidcustomcolorR2
							local dg = P.ElvUI_EltreumUI.gradientmode.druidcustomcolorG2
							local db = P.ElvUI_EltreumUI.gradientmode.druidcustomcolorB2
							return E.db.ElvUI_EltreumUI.gradientmode.druidcustomcolorR2, E.db.ElvUI_EltreumUI.gradientmode.druidcustomcolorG2, E.db.ElvUI_EltreumUI.gradientmode.druidcustomcolorB2, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.druidcustomcolorR2, E.db.ElvUI_EltreumUI.gradientmode.druidcustomcolorG2, E.db.ElvUI_EltreumUI.gradientmode.druidcustomcolorB2 = r, g, b
							ElvUI_EltreumUI:GradientColorTableUpdate()
						end,
					},
					header5 = {
						order = 73,
						type = "description",
						name = L["Hunter"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					gradienthunter1 = {
						order = 74,
						type = 'color',
						name = L["Color 1"],
						hasAlpha = false,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.huntercustomcolorR1
							local dg = P.ElvUI_EltreumUI.gradientmode.huntercustomcolorG1
							local db = P.ElvUI_EltreumUI.gradientmode.huntercustomcolorB1
							return E.db.ElvUI_EltreumUI.gradientmode.huntercustomcolorR1, E.db.ElvUI_EltreumUI.gradientmode.huntercustomcolorG1, E.db.ElvUI_EltreumUI.gradientmode.huntercustomcolorB1, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.huntercustomcolorR1, E.db.ElvUI_EltreumUI.gradientmode.huntercustomcolorG1, E.db.ElvUI_EltreumUI.gradientmode.huntercustomcolorB1 = r, g, b
							ElvUI_EltreumUI:GradientColorTableUpdate()
						end,
					},
					gradienthunter2 = {
						order = 75,
						type = 'color',
						name = L["Color 2"],
						hasAlpha = false,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.huntercustomcolorR2
							local dg = P.ElvUI_EltreumUI.gradientmode.huntercustomcolorG2
							local db = P.ElvUI_EltreumUI.gradientmode.huntercustomcolorB2
							return E.db.ElvUI_EltreumUI.gradientmode.huntercustomcolorR2, E.db.ElvUI_EltreumUI.gradientmode.huntercustomcolorG2, E.db.ElvUI_EltreumUI.gradientmode.huntercustomcolorB2, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.huntercustomcolorR2, E.db.ElvUI_EltreumUI.gradientmode.huntercustomcolorG2, E.db.ElvUI_EltreumUI.gradientmode.huntercustomcolorB2 = r, g, b
							ElvUI_EltreumUI:GradientColorTableUpdate()
						end,
					},
					header6 = {
						order = 76,
						type = "description",
						name = L["Mage"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					gradientmage1 = {
						order = 77,
						type = 'color',
						name = L["Color 1"],
						hasAlpha = false,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.magecustomcolorR1
							local dg = P.ElvUI_EltreumUI.gradientmode.magecustomcolorG1
							local db = P.ElvUI_EltreumUI.gradientmode.magecustomcolorB1
							return E.db.ElvUI_EltreumUI.gradientmode.magecustomcolorR1, E.db.ElvUI_EltreumUI.gradientmode.magecustomcolorG1, E.db.ElvUI_EltreumUI.gradientmode.magecustomcolorB1, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.magecustomcolorR1, E.db.ElvUI_EltreumUI.gradientmode.magecustomcolorG1, E.db.ElvUI_EltreumUI.gradientmode.magecustomcolorB1 = r, g, b
							ElvUI_EltreumUI:GradientColorTableUpdate()
						end,
					},
					gradientmage2 = {
						order = 78,
						type = 'color',
						name = L["Color 2"],
						hasAlpha = false,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.magecustomcolorR2
							local dg = P.ElvUI_EltreumUI.gradientmode.magecustomcolorG2
							local db = P.ElvUI_EltreumUI.gradientmode.magecustomcolorB2
							return E.db.ElvUI_EltreumUI.gradientmode.magecustomcolorR2, E.db.ElvUI_EltreumUI.gradientmode.magecustomcolorG2, E.db.ElvUI_EltreumUI.gradientmode.magecustomcolorB2, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.magecustomcolorR2, E.db.ElvUI_EltreumUI.gradientmode.magecustomcolorG2, E.db.ElvUI_EltreumUI.gradientmode.magecustomcolorB2 = r, g, b
							ElvUI_EltreumUI:GradientColorTableUpdate()
						end,
					},
					header8 = {
						order = 82,
						type = "description",
						name = L["Paladin"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					gradientpaladin1 = {
						order = 83,
						type = 'color',
						name = L["Color 1"],
						hasAlpha = false,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.paladincustomcolorR1
							local dg = P.ElvUI_EltreumUI.gradientmode.paladincustomcolorG1
							local db = P.ElvUI_EltreumUI.gradientmode.paladincustomcolorB1
							return E.db.ElvUI_EltreumUI.gradientmode.paladincustomcolorR1, E.db.ElvUI_EltreumUI.gradientmode.paladincustomcolorG1, E.db.ElvUI_EltreumUI.gradientmode.paladincustomcolorB1, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.paladincustomcolorR1, E.db.ElvUI_EltreumUI.gradientmode.paladincustomcolorG1, E.db.ElvUI_EltreumUI.gradientmode.paladincustomcolorB1 = r, g, b
							ElvUI_EltreumUI:GradientColorTableUpdate()
						end,
					},
					gradientpaladin2 = {
						order = 84,
						type = 'color',
						name = L["Color 2"],
						hasAlpha = false,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.paladincustomcolorR2
							local dg = P.ElvUI_EltreumUI.gradientmode.paladincustomcolorG2
							local db = P.ElvUI_EltreumUI.gradientmode.paladincustomcolorB2
							return E.db.ElvUI_EltreumUI.gradientmode.paladincustomcolorR2, E.db.ElvUI_EltreumUI.gradientmode.paladincustomcolorG2, E.db.ElvUI_EltreumUI.gradientmode.paladincustomcolorB2, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.paladincustomcolorR2, E.db.ElvUI_EltreumUI.gradientmode.paladincustomcolorG2, E.db.ElvUI_EltreumUI.gradientmode.paladincustomcolorB2 = r, g, b
							ElvUI_EltreumUI:GradientColorTableUpdate()
						end,
					},
					header9 = {
						order = 85,
						type = "description",
						name = L["Priest"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					gradientpriest1 = {
						order = 86,
						type = 'color',
						name = L["Color 1"],
						hasAlpha = false,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.priestcustomcolorR1
							local dg = P.ElvUI_EltreumUI.gradientmode.priestcustomcolorG1
							local db = P.ElvUI_EltreumUI.gradientmode.priestcustomcolorB1
							return E.db.ElvUI_EltreumUI.gradientmode.priestcustomcolorR1, E.db.ElvUI_EltreumUI.gradientmode.priestcustomcolorG1, E.db.ElvUI_EltreumUI.gradientmode.priestcustomcolorB1, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.priestcustomcolorR1, E.db.ElvUI_EltreumUI.gradientmode.priestcustomcolorG1, E.db.ElvUI_EltreumUI.gradientmode.priestcustomcolorB1 = r, g, b
							ElvUI_EltreumUI:GradientColorTableUpdate()
						end,
					},
					gradientpriest2 = {
						order = 87,
						type = 'color',
						name = L["Color 2"],
						hasAlpha = false,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.priestcustomcolorR2
							local dg = P.ElvUI_EltreumUI.gradientmode.priestcustomcolorG2
							local db = P.ElvUI_EltreumUI.gradientmode.priestcustomcolorB2
							return E.db.ElvUI_EltreumUI.gradientmode.priestcustomcolorR2, E.db.ElvUI_EltreumUI.gradientmode.priestcustomcolorG2, E.db.ElvUI_EltreumUI.gradientmode.priestcustomcolorB2, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.priestcustomcolorR2, E.db.ElvUI_EltreumUI.gradientmode.priestcustomcolorG2, E.db.ElvUI_EltreumUI.gradientmode.priestcustomcolorB2 = r, g, b
							ElvUI_EltreumUI:GradientColorTableUpdate()
						end,
					},
					header10 = {
						order = 88,
						type = "description",
						name = L["Rogue"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					gradientrogue1 = {
						order = 89,
						type = 'color',
						name = L["Color 1"],
						hasAlpha = false,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.roguecustomcolorR1
							local dg = P.ElvUI_EltreumUI.gradientmode.roguecustomcolorG1
							local db = P.ElvUI_EltreumUI.gradientmode.roguecustomcolorB1
							return E.db.ElvUI_EltreumUI.gradientmode.roguecustomcolorR1, E.db.ElvUI_EltreumUI.gradientmode.roguecustomcolorG1, E.db.ElvUI_EltreumUI.gradientmode.roguecustomcolorB1, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.roguecustomcolorR1, E.db.ElvUI_EltreumUI.gradientmode.roguecustomcolorG1, E.db.ElvUI_EltreumUI.gradientmode.roguecustomcolorB1 = r, g, b
							ElvUI_EltreumUI:GradientColorTableUpdate()
						end,
					},
					gradientrogue2 = {
						order = 90,
						type = 'color',
						name = L["Color 2"],
						hasAlpha = false,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.roguecustomcolorR2
							local dg = P.ElvUI_EltreumUI.gradientmode.roguecustomcolorG2
							local db = P.ElvUI_EltreumUI.gradientmode.roguecustomcolorB2
							return E.db.ElvUI_EltreumUI.gradientmode.roguecustomcolorR2, E.db.ElvUI_EltreumUI.gradientmode.roguecustomcolorG2, E.db.ElvUI_EltreumUI.gradientmode.roguecustomcolorB2, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.roguecustomcolorR2, E.db.ElvUI_EltreumUI.gradientmode.roguecustomcolorG2, E.db.ElvUI_EltreumUI.gradientmode.roguecustomcolorB2 = r, g, b
							ElvUI_EltreumUI:GradientColorTableUpdate()
						end,
					},
					header11 = {
						order = 91,
						type = "description",
						name = L["Shaman"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					gradientshaman1 = {
						order = 92,
						type = 'color',
						name = L["Color 1"],
						hasAlpha = false,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.shamancustomcolorR1
							local dg = P.ElvUI_EltreumUI.gradientmode.shamancustomcolorG1
							local db = P.ElvUI_EltreumUI.gradientmode.shamancustomcolorB1
							return E.db.ElvUI_EltreumUI.gradientmode.shamancustomcolorR1, E.db.ElvUI_EltreumUI.gradientmode.shamancustomcolorG1, E.db.ElvUI_EltreumUI.gradientmode.shamancustomcolorB1, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.shamancustomcolorR1, E.db.ElvUI_EltreumUI.gradientmode.shamancustomcolorG1, E.db.ElvUI_EltreumUI.gradientmode.shamancustomcolorB1 = r, g, b
							ElvUI_EltreumUI:GradientColorTableUpdate()
						end,
					},
					gradientshaman2 = {
						order = 93,
						type = 'color',
						name = L["Color 2"],
						hasAlpha = false,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.shamancustomcolorR2
							local dg = P.ElvUI_EltreumUI.gradientmode.shamancustomcolorG2
							local db = P.ElvUI_EltreumUI.gradientmode.shamancustomcolorB2
							return E.db.ElvUI_EltreumUI.gradientmode.shamancustomcolorR2, E.db.ElvUI_EltreumUI.gradientmode.shamancustomcolorG2, E.db.ElvUI_EltreumUI.gradientmode.shamancustomcolorB2, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.shamancustomcolorR2, E.db.ElvUI_EltreumUI.gradientmode.shamancustomcolorG2, E.db.ElvUI_EltreumUI.gradientmode.shamancustomcolorB2 = r, g, b
							ElvUI_EltreumUI:GradientColorTableUpdate()
						end,
					},
					header12 = {
						order = 94,
						type = "description",
						name = L["Warlock"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					gradientwarlock1 = {
						order = 95,
						type = 'color',
						name = L["Color 1"],
						hasAlpha = false,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.warlockcustomcolorR1
							local dg = P.ElvUI_EltreumUI.gradientmode.warlockcustomcolorG1
							local db = P.ElvUI_EltreumUI.gradientmode.warlockcustomcolorB1
							return E.db.ElvUI_EltreumUI.gradientmode.warlockcustomcolorR1, E.db.ElvUI_EltreumUI.gradientmode.warlockcustomcolorG1, E.db.ElvUI_EltreumUI.gradientmode.warlockcustomcolorB1, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.warlockcustomcolorR1, E.db.ElvUI_EltreumUI.gradientmode.warlockcustomcolorG1, E.db.ElvUI_EltreumUI.gradientmode.warlockcustomcolorB1 = r, g, b
							ElvUI_EltreumUI:GradientColorTableUpdate()
						end,
					},
					gradientwarlock2 = {
						order = 96,
						type = 'color',
						name = L["Color 2"],
						hasAlpha = false,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.warlockcustomcolorR2
							local dg = P.ElvUI_EltreumUI.gradientmode.warlockcustomcolorG2
							local db = P.ElvUI_EltreumUI.gradientmode.warlockcustomcolorB2
							return E.db.ElvUI_EltreumUI.gradientmode.warlockcustomcolorR2, E.db.ElvUI_EltreumUI.gradientmode.warlockcustomcolorG2, E.db.ElvUI_EltreumUI.gradientmode.warlockcustomcolorB2, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.warlockcustomcolorR2, E.db.ElvUI_EltreumUI.gradientmode.warlockcustomcolorG2, E.db.ElvUI_EltreumUI.gradientmode.warlockcustomcolorB2 = r, g, b
							ElvUI_EltreumUI:GradientColorTableUpdate()
						end,
					},
					header13 = {
						order = 97,
						type = "description",
						name = L["Warrior"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					gradientwarrior1 = {
						order = 98,
						type = 'color',
						name = L["Color 1"],
						hasAlpha = false,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.warriorcustomcolorR1
							local dg = P.ElvUI_EltreumUI.gradientmode.warriorcustomcolorG1
							local db = P.ElvUI_EltreumUI.gradientmode.warriorcustomcolorB1
							return E.db.ElvUI_EltreumUI.gradientmode.warriorcustomcolorR1, E.db.ElvUI_EltreumUI.gradientmode.warriorcustomcolorG1, E.db.ElvUI_EltreumUI.gradientmode.warriorcustomcolorB1, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.warriorcustomcolorR1, E.db.ElvUI_EltreumUI.gradientmode.warriorcustomcolorG1, E.db.ElvUI_EltreumUI.gradientmode.warriorcustomcolorB1 = r, g, b
							ElvUI_EltreumUI:GradientColorTableUpdate()
						end,
					},
					gradientwarrior2 = {
						order = 99,
						type = 'color',
						name = L["Color 2"],
						hasAlpha = false,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.warriorcustomcolorR2
							local dg = P.ElvUI_EltreumUI.gradientmode.warriorcustomcolorG2
							local db = P.ElvUI_EltreumUI.gradientmode.warriorcustomcolorB2
							return E.db.ElvUI_EltreumUI.gradientmode.warriorcustomcolorR2, E.db.ElvUI_EltreumUI.gradientmode.warriorcustomcolorG2, E.db.ElvUI_EltreumUI.gradientmode.warriorcustomcolorB2, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.warriorcustomcolorR2, E.db.ElvUI_EltreumUI.gradientmode.warriorcustomcolorG2, E.db.ElvUI_EltreumUI.gradientmode.warriorcustomcolorB2 = r, g, b
							ElvUI_EltreumUI:GradientColorTableUpdate()
						end,
					},
					header14 = {
						order = 100,
						type = "description",
						name = L["Friendly NPC"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					friendlynpc1 = {
						order = 101,
						type = 'color',
						name = L["Color 1"],
						desc = L["NPCs use Target Castbar colors not NPC colors for their castbars"],
						hasAlpha = false,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.npcfriendlyR1
							local dg = P.ElvUI_EltreumUI.gradientmode.npcfriendlyG1
							local db = P.ElvUI_EltreumUI.gradientmode.npcfriendlyB1
							return E.db.ElvUI_EltreumUI.gradientmode.npcfriendlyR1, E.db.ElvUI_EltreumUI.gradientmode.npcfriendlyG1, E.db.ElvUI_EltreumUI.gradientmode.npcfriendlyB1, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.npcfriendlyR1, E.db.ElvUI_EltreumUI.gradientmode.npcfriendlyG1, E.db.ElvUI_EltreumUI.gradientmode.npcfriendlyB1 = r, g, b
							ElvUI_EltreumUI:GradientColorTableUpdate()
						end,
					},
					friendlynpc2 = {
						order = 102,
						type = 'color',
						name = L["Color 2"],
						desc = L["NPCs use Target Castbar colors not NPC colors for their castbars"],
						hasAlpha = false,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.npcfriendlyR2
							local dg = P.ElvUI_EltreumUI.gradientmode.npcfriendlyG2
							local db = P.ElvUI_EltreumUI.gradientmode.npcfriendlyB2
							return E.db.ElvUI_EltreumUI.gradientmode.npcfriendlyR2, E.db.ElvUI_EltreumUI.gradientmode.npcfriendlyG2, E.db.ElvUI_EltreumUI.gradientmode.npcfriendlyB2, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.npcfriendlyR2, E.db.ElvUI_EltreumUI.gradientmode.npcfriendlyG2, E.db.ElvUI_EltreumUI.gradientmode.npcfriendlyB2 = r, g, b
							ElvUI_EltreumUI:GradientColorTableUpdate()
						end,
					},
					header15 = {
						order = 103,
						type = "description",
						name = L["Neutral NPC"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					neutralnpc1 = {
						order = 104,
						type = 'color',
						name = L["Color 1"],
						desc = L["NPCs use Target Castbar colors not NPC colors for their castbars"],
						hasAlpha = false,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.npcneutralR1
							local dg = P.ElvUI_EltreumUI.gradientmode.npcneutralG1
							local db = P.ElvUI_EltreumUI.gradientmode.npcneutralB1
							return E.db.ElvUI_EltreumUI.gradientmode.npcneutralR1, E.db.ElvUI_EltreumUI.gradientmode.npcneutralG1, E.db.ElvUI_EltreumUI.gradientmode.npcneutralB1, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.npcneutralR1, E.db.ElvUI_EltreumUI.gradientmode.npcneutralG1, E.db.ElvUI_EltreumUI.gradientmode.npcneutralB1 = r, g, b
							ElvUI_EltreumUI:GradientColorTableUpdate()
						end,
					},
					neutralnpc2 = {
						order = 105,
						type = 'color',
						name = L["Color 2"],
						desc = L["NPCs use Target Castbar colors not NPC colors for their castbars"],
						hasAlpha = false,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.npcneutralR2
							local dg = P.ElvUI_EltreumUI.gradientmode.npcneutralG2
							local db = P.ElvUI_EltreumUI.gradientmode.npcneutralB2
							return E.db.ElvUI_EltreumUI.gradientmode.npcneutralR2, E.db.ElvUI_EltreumUI.gradientmode.npcneutralG2, E.db.ElvUI_EltreumUI.gradientmode.npcneutralB2, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.npcneutralR2, E.db.ElvUI_EltreumUI.gradientmode.npcneutralG2, E.db.ElvUI_EltreumUI.gradientmode.npcneutralB2 = r, g, b
							ElvUI_EltreumUI:GradientColorTableUpdate()
						end,
					},
					header16 = {
						order = 105,
						type = "description",
						name = L["Unfriendly NPC"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					unfriendlynpc1 = {
						order = 106,
						type = 'color',
						name = L["Color 1"],
						desc = L["NPCs use Target Castbar colors not NPC colors for their castbars"],
						hasAlpha = false,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.npcunfriendlyR1
							local dg = P.ElvUI_EltreumUI.gradientmode.npcunfriendlyG1
							local db = P.ElvUI_EltreumUI.gradientmode.npcunfriendlyB1
							return E.db.ElvUI_EltreumUI.gradientmode.npcunfriendlyR1, E.db.ElvUI_EltreumUI.gradientmode.npcunfriendlyG1, E.db.ElvUI_EltreumUI.gradientmode.npcunfriendlyB1, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.npcunfriendlyR1, E.db.ElvUI_EltreumUI.gradientmode.npcunfriendlyG1, E.db.ElvUI_EltreumUI.gradientmode.npcunfriendlyB1 = r, g, b
							ElvUI_EltreumUI:GradientColorTableUpdate()
						end,
					},
					unfriendlynpc2 = {
						order = 107,
						type = 'color',
						name = L["Color 2"],
						desc = L["NPCs use Target Castbar colors not NPC colors for their castbars"],
						hasAlpha = false,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.npcunfriendlyR2
							local dg = P.ElvUI_EltreumUI.gradientmode.npcunfriendlyG2
							local db = P.ElvUI_EltreumUI.gradientmode.npcunfriendlyB2
							return E.db.ElvUI_EltreumUI.gradientmode.npcunfriendlyR2, E.db.ElvUI_EltreumUI.gradientmode.npcunfriendlyG2, E.db.ElvUI_EltreumUI.gradientmode.npcunfriendlyB2, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.npcunfriendlyR2, E.db.ElvUI_EltreumUI.gradientmode.npcunfriendlyG2, E.db.ElvUI_EltreumUI.gradientmode.npcunfriendlyB2 = r, g, b
							ElvUI_EltreumUI:GradientColorTableUpdate()
						end,
					},
					header17 = {
						order = 108,
						type = "description",
						name = L["Hostile NPC"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					hostilenpc1 = {
						order = 109,
						type = 'color',
						name = L["Color 1"],
						desc = L["NPCs use Target Castbar colors not NPC colors for their castbars"],
						hasAlpha = false,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.npchostileR1
							local dg = P.ElvUI_EltreumUI.gradientmode.npchostileG1
							local db = P.ElvUI_EltreumUI.gradientmode.npchostileB1
							return E.db.ElvUI_EltreumUI.gradientmode.npchostileR1, E.db.ElvUI_EltreumUI.gradientmode.npchostileG1, E.db.ElvUI_EltreumUI.gradientmode.npchostileB1, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.npchostileR1, E.db.ElvUI_EltreumUI.gradientmode.npchostileG1, E.db.ElvUI_EltreumUI.gradientmode.npchostileB1 = r, g, b
							ElvUI_EltreumUI:GradientColorTableUpdate()
						end,
					},
					hostilenpc2 = {
						order = 110,
						type = 'color',
						name = L["Color 2"],
						desc = L["NPCs use Target Castbar colors not NPC colors for their castbars"],
						hasAlpha = false,
						disabled = function() return not E.db.ElvUI_EltreumUI.gradientmode.enable or not E.db.ElvUI_EltreumUI.gradientmode.customcolor end,
						get = function()
							local dr = P.ElvUI_EltreumUI.gradientmode.npchostileR2
							local dg = P.ElvUI_EltreumUI.gradientmode.npchostileG2
							local db = P.ElvUI_EltreumUI.gradientmode.npchostileB2
							return E.db.ElvUI_EltreumUI.gradientmode.npchostileR2, E.db.ElvUI_EltreumUI.gradientmode.npchostileG2, E.db.ElvUI_EltreumUI.gradientmode.npchostileB2, 1, dr, dg, db, 1
						end,
						set = function(_, r, g, b, a)
							E.db.ElvUI_EltreumUI.gradientmode.npchostileR2, E.db.ElvUI_EltreumUI.gradientmode.npchostileG2, E.db.ElvUI_EltreumUI.gradientmode.npchostileB2 = r, g, b
							ElvUI_EltreumUI:GradientColorTableUpdate()
						end,
					},
				}
			},
		},
	}
	return unitframes
end
