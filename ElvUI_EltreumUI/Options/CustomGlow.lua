local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

function ElvUI_EltreumUI:CustomGlowOptions()
	local customglow = {
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
						order = 1,
						type = "description",
						name = L["Replace Blizzards Default Glow with a Custom Glow"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					enable = {
						type = 'toggle',
						name = "Enable Glows",
						order = 2,
						width = 'full',
						get = function() return E.db.ElvUI_EltreumUI.glow.enable end,
						set = function(_, value) E.db.ElvUI_EltreumUI.glow.enable = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					enablepet = {
						type = 'toggle',
						name = L["Enable on Pet Bar"],
						order = 3,
						width = 'full',
						get = function() return E.db.ElvUI_EltreumUI.glow.enablepet end,
						set = function(_, value) E.db.ElvUI_EltreumUI.glow.enablepet = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					enablenp = {
						order = 4,
						type = 'toggle',
						name = L["Enable on Nameplate"],
						desc = L["Add a glow when buffs or debuffs are expiring on nameplates"],
						width = 'full',
						get = function() return E.db.ElvUI_EltreumUI.widenameplate.npglow end,
						set = function(_, value) E.db.ElvUI_EltreumUI.widenameplate.npglow = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					debuffduration = {
						type = 'range',
						name = L["Debuff Timer"],
						desc = L["Time at which the glow will start"],
						order = 5,
						min = 1,
						max = 30,
						step = 1,
						width = "double",
						get = function() return E.db.ElvUI_EltreumUI.glow.numberdebuff end,
						set = function(_, value) E.db.ElvUI_EltreumUI.glow.numberdebuff = value end,
					},
					headerlinetotemsglow = {
						order = 6,
						type = "description",
						name = L["Shaman Totems"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					enabletotem = {
						type = 'toggle',
						name = L["Enable on Shaman Totems"],
						order = 7,
						width = 'full',
						disabled = function() return not E.db.ElvUI_EltreumUI.glow.enable end,
						get = function() return E.db.ElvUI_EltreumUI.glow.enabletotem end,
						set = function(_, value) E.db.ElvUI_EltreumUI.glow.enabletotem = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					enabletotem1 = {
						type = 'toggle',
						name = L["Enable on Shaman Fire Totem"],
						order = 8,
						width = 'full',
						disabled = function() return not E.db.ElvUI_EltreumUI.glow.enable or not E.db.ElvUI_EltreumUI.glow.enabletotem end,
						get = function() return E.db.ElvUI_EltreumUI.glow.totem1 end,
						set = function(_, value) E.db.ElvUI_EltreumUI.glow.totem1 = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					enabletotem2 = {
						type = 'toggle',
						name = L["Enable on Shaman Earth Totem"],
						order = 9,
						width = 'full',
						disabled = function() return not E.db.ElvUI_EltreumUI.glow.enable or not E.db.ElvUI_EltreumUI.glow.enabletotem end,
						get = function() return E.db.ElvUI_EltreumUI.glow.totem2 end,
						set = function(_, value) E.db.ElvUI_EltreumUI.glow.totem2 = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					enabletotem3 = {
						type = 'toggle',
						name = L["Enable on Shaman Water Totem"],
						order = 10,
						width = 'full',
						disabled = function() return not E.db.ElvUI_EltreumUI.glow.enable or not E.db.ElvUI_EltreumUI.glow.enabletotem end,
						get = function() return E.db.ElvUI_EltreumUI.glow.totem3 end,
						set = function(_, value) E.db.ElvUI_EltreumUI.glow.totem3 = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					enabletotem4 = {
						type = 'toggle',
						name = L["Enable on Shaman Air Totem"],
						order = 11,
						width = 'full',
						disabled = function() return not E.db.ElvUI_EltreumUI.glow.enable or not E.db.ElvUI_EltreumUI.glow.enabletotem end,
						get = function() return E.db.ElvUI_EltreumUI.glow.totem4 end,
						set = function(_, value) E.db.ElvUI_EltreumUI.glow.totem4 = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					headerline1 = {
						order = 12,
						type = "description",
						name = L["Select a Type"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					autocast = {
						type = 'toggle',
						name = L["Autocast"],
						order = 13,
						desc = L["Adds an autocast style glow using class color"],
						disabled = function() return not E.db.ElvUI_EltreumUI.glow.enable or E.db.ElvUI_EltreumUI.glow.pixel or E.db.ElvUI_EltreumUI.glow.blizzard end,
						get = function() return E.db.ElvUI_EltreumUI.glow.autocast end,
						set = function(_, value) E.db.ElvUI_EltreumUI.glow.autocast = value end,
					},
					pixel = {
						type = 'toggle',
						name = L["Pixel"],
						order = 13,
						desc = L["Adds a pixel style glow using class color"],
						disabled = function() return not E.db.ElvUI_EltreumUI.glow.enable or E.db.ElvUI_EltreumUI.glow.autocast or E.db.ElvUI_EltreumUI.glow.blizzard end,
						get = function() return E.db.ElvUI_EltreumUI.glow.pixel end,
						set = function(_, value) E.db.ElvUI_EltreumUI.glow.pixel = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					blizzard = {
						type = 'toggle',
						name = 'Blizzard',
						order = 13,
						desc = L["Adds a Blizzard style glow using class color"],
						disabled = function() return not E.db.ElvUI_EltreumUI.glow.enable or E.db.ElvUI_EltreumUI.glow.autocast or E.db.ElvUI_EltreumUI.glow.pixel end,
						get = function() return E.db.ElvUI_EltreumUI.glow.blizzard end,
						set = function(_, value) E.db.ElvUI_EltreumUI.glow.blizzard = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					previewgap = {
						order = 14,
						type = "description",
						name = L["Preview the Glow"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					preview ={
						order = 15,
						type = "execute",
						name = L["Preview"],
						desc = L["Preview the Glow, you will need to toggle it off and on to update the glow"],
						func = function() ElvUI_EltreumUI:PreviewGlow() end,
					},
				},
			},
			glowcolor = {
				type = 'group',
				name = L["Glow Colors"],
				order = 2,
				args = {
					headertotem1 = {
						order = 1,
						type = "description",
						name = L["Shaman Fire Totem"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					classcolortotem1 = {
						type = 'toggle',
						name = L["Use Type Colors"],
						order = 2,
						desc = L["Toggle Totem to use it's own Type Colors"],
						get = function() return E.db.ElvUI_EltreumUI.glow.totemtypecolor end,
						set = function(_, value) E.db.ElvUI_EltreumUI.glow.totemtypecolor = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					colortotem1 = {
						order = 3,
						type = 'color',
						name = L["Custom Color"],
						hasAlpha = false,
						disabled = function() return E.db.ElvUI_EltreumUI.glow.totemtypecolor end,
						get = function()
							local glowtotem1customcolor = E.db.ElvUI_EltreumUI.glowtotem1customcolor
							local d = P.ElvUI_EltreumUI.glowtotem1customcolor
							return glowtotem1customcolor.r, glowtotem1customcolor.g, glowtotem1customcolor.b, glowtotem1customcolor.a, d.r, d.g, d.b, d.a
						end,
						set = function(_, r, g, b, a)
							local glowtotem1customcolor = E.db.ElvUI_EltreumUI.glowtotem1customcolor
							glowtotem1customcolor.r, glowtotem1customcolor.g, glowtotem1customcolor.b = r, g, b E:StaticPopup_Show('CONFIG_RL')
						end,
					},
					headertotem2 = {
						order = 4,
						type = "description",
						name = L["Shaman Earth Totem"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					classcolortotem2 = {
						type = 'toggle',
						name = L["Use Type Colors"],
						order = 5,
						desc = L["Toggle Totem to use it's own Type Colors"],
						get = function() return E.db.ElvUI_EltreumUI.glow.totemtypecolor end,
						set = function(_, value) E.db.ElvUI_EltreumUI.glow.totemtypecolor = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					colortotem2 = {
						order = 6,
						type = 'color',
						name = L["Custom Color"],
						hasAlpha = false,
						disabled = function() return E.db.ElvUI_EltreumUI.glow.totemtypecolor end,
						get = function()
							local glowtotem2customcolor = E.db.ElvUI_EltreumUI.glowtotem2customcolor
							local d = P.ElvUI_EltreumUI.glowtotem2customcolor
							return glowtotem2customcolor.r, glowtotem2customcolor.g, glowtotem2customcolor.b, glowtotem2customcolor.a, d.r, d.g, d.b, d.a
						end,
						set = function(_, r, g, b, a)
							local glowtotem2customcolor = E.db.ElvUI_EltreumUI.glowtotem2customcolor
							glowtotem2customcolor.r, glowtotem2customcolor.g, glowtotem2customcolor.b = r, g, b E:StaticPopup_Show('CONFIG_RL')
						end,
					},
					headertotem3 = {
						order = 7,
						type = "description",
						name = L["Shaman Water Totem"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					classcolortotem3 = {
						type = 'toggle',
						name = L["Use Type Colors"],
						order = 8,
						desc = L["Toggle Totem to use it's own Type Colors"],
						get = function() return E.db.ElvUI_EltreumUI.glow.totemtypecolor end,
						set = function(_, value) E.db.ElvUI_EltreumUI.glow.totemtypecolor = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					colortotem3 = {
						order = 9,
						type = 'color',
						name = L["Custom Color"],
						hasAlpha = false,
						disabled = function() return E.db.ElvUI_EltreumUI.glow.totemtypecolor end,
						get = function()
							local glowtotem3customcolor = E.db.ElvUI_EltreumUI.glowtotem3customcolor
							local d = P.ElvUI_EltreumUI.glowtotem3customcolor
							return glowtotem3customcolor.r, glowtotem3customcolor.g, glowtotem3customcolor.b, glowtotem3customcolor.a, d.r, d.g, d.b, d.a
						end,
						set = function(_, r, g, b, a)
							local glowtotem3customcolor = E.db.ElvUI_EltreumUI.glowtotem3customcolor
							glowtotem3customcolor.r, glowtotem3customcolor.g, glowtotem3customcolor.b = r, g, b E:StaticPopup_Show('CONFIG_RL')
						end,
					},
					headertotem4 = {
						order = 10,
						type = "description",
						name = L["Shaman Air Totem"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					classcolortotem4 = {
						type = 'toggle',
						name = L["Use Type Colors"],
						order = 11,
						desc = L["Toggle Totem to use it's own Type Colors"],
						get = function() return E.db.ElvUI_EltreumUI.glow.totemtypecolor end,
						set = function(_, value) E.db.ElvUI_EltreumUI.glow.totemtypecolor = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					colortotem4 = {
						order = 12,
						type = 'color',
						name = L["Custom Color"],
						hasAlpha = false,
						disabled = function() return E.db.ElvUI_EltreumUI.glow.totemtypecolor end,
						get = function()
							local glowtotem4customcolor = E.db.ElvUI_EltreumUI.glowtotem4customcolor
							local d = P.ElvUI_EltreumUI.glowtotem4customcolor
							return glowtotem4customcolor.r, glowtotem4customcolor.g, glowtotem4customcolor.b, glowtotem4customcolor.a, d.r, d.g, d.b, d.a
						end,
						set = function(_, r, g, b, a)
							local glowtotem4customcolor = E.db.ElvUI_EltreumUI.glowtotem4customcolor
							glowtotem4customcolor.r, glowtotem4customcolor.g, glowtotem4customcolor.b = r, g, b E:StaticPopup_Show('CONFIG_RL')
						end,
					},
					headerline2 = {
						order = 94,
						type = "description",
						name = L["Pet Bar"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					classcolorpet = {
						type = 'toggle',
						name = L["Use Class Colors"],
						order = 95,
						desc = L["Toggle Class Colored glows"],
						get = function() return E.db.ElvUI_EltreumUI.glow.colorclasspet end,
						set = function(_, value) E.db.ElvUI_EltreumUI.glow.colorclasspet = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					colorpet = {
						order = 96,
						type = 'color',
						name = L["Custom Color"],
						hasAlpha = false,
						disabled = function() return E.db.ElvUI_EltreumUI.glow.colorclasspet end,
						get = function()
							local glowcustomcolorpet = E.db.ElvUI_EltreumUI.glowcustomcolorpet
							local d = P.ElvUI_EltreumUI.glowcustomcolorpet
							return glowcustomcolorpet.r, glowcustomcolorpet.g, glowcustomcolorpet.b, glowcustomcolorpet.a, d.r, d.g, d.b, d.a
						end,
						set = function(_, r, g, b, a)
							local glowcustomcolorpet = E.db.ElvUI_EltreumUI.glowcustomcolorpet
							glowcustomcolorpet.r, glowcustomcolorpet.g, glowcustomcolorpet.b = r, g, b E:StaticPopup_Show('CONFIG_RL')
						end,
					},
					headerline3 = {
						order = 97,
						type = "description",
						name = L["Nameplate Buff/Debuff"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					classcolornp = {
						type = 'toggle',
						name = L["Use Class Colors"],
						order = 98,
						desc = L["Toggle Class Colored glows"],
						get = function() return E.db.ElvUI_EltreumUI.glow.colorclassnp end,
						set = function(_, value) E.db.ElvUI_EltreumUI.glow.colorclassnp = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					colornp = {
						order = 99,
						type = 'color',
						name = L["Custom Color"],
						hasAlpha = false,
						disabled = function() return E.db.ElvUI_EltreumUI.glow.colorclassnp end,
						get = function()
							local glowcustomcolornp = E.db.ElvUI_EltreumUI.glowcustomcolornp
							local d = P.ElvUI_EltreumUI.glowcustomcolornp
							return glowcustomcolornp.r, glowcustomcolornp.g, glowcustomcolornp.b, glowcustomcolornp.a, d.r, d.g, d.b, d.a
						end,
						set = function(_, r, g, b, a)
							local glowcustomcolornp = E.db.ElvUI_EltreumUI.glowcustomcolornp
							glowcustomcolornp.r, glowcustomcolornp.g, glowcustomcolornp.b = r, g, b E:StaticPopup_Show('CONFIG_RL')
						end,
					},
					headerline100 = {
						order = 100,
						type = "description",
						name = L["Action Bars"],
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					classcolorab = {
						type = 'toggle',
						name = L["Use Class Colors"],
						order = 101,
						desc = L["Toggle Class Colored glows"],
						get = function() return E.db.ElvUI_EltreumUI.glow.colorclass end,
						set = function(_, value) E.db.ElvUI_EltreumUI.glow.colorclass = value E:StaticPopup_Show('CONFIG_RL') end,
					},
					colorab = {
						order = 102,
						type = 'color',
						name = L["Custom Color"],
						hasAlpha = false,
						disabled = function() return E.db.ElvUI_EltreumUI.glow.colorclass end,
						get = function()
							local glowcustomcolor = E.db.ElvUI_EltreumUI.glowcustomcolor
							local d = P.ElvUI_EltreumUI.glowcustomcolor
							return glowcustomcolor.r, glowcustomcolor.g, glowcustomcolor.b, glowcustomcolor.a, d.r, d.g, d.b, d.a
						end,
						set = function(_, r, g, b, a)
							local glowcustomcolor = E.db.ElvUI_EltreumUI.glowcustomcolor
							glowcustomcolor.r, glowcustomcolor.g, glowcustomcolor.b = r, g, b E:StaticPopup_Show('CONFIG_RL')
						end,
					},
				},
			},
			pixelglow = {
				type = 'group',
				name = L["Pixel Glow"],
				order = 3,
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
						max = 10,
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
						min = 1,
						max = 10,
						step = 1,
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
						max = 10,
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
	}
	return customglow
end
