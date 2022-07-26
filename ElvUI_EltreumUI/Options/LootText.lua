local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

function ElvUI_EltreumUI:LootOptions()
	local loottext = {
		type = 'group',
		name = L["Loot"],
		icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\loot',
		order = 85,
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
						get = function() return E.db.ElvUI_EltreumUI.loottext.enable end,
						set = function(_, value) E.db.ElvUI_EltreumUI.loottext.enable = value E:StaticPopup_Show('CONFIG_RL') end,
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
									disabled = function() return not E.db.ElvUI_EltreumUI.loottext.enable end,
									get = function() return E.db.ElvUI_EltreumUI.loottext.honor end,
									set = function(_, value) E.db.ElvUI_EltreumUI.loottext.honor = value end,
								},
								currency = {
									type = 'toggle',
									name = CURRENCY,
									order = 5,
									disabled = function() return not E.db.ElvUI_EltreumUI.loottext.enable end,
									get = function() return E.db.ElvUI_EltreumUI.loottext.currency end,
									set = function(_, value) E.db.ElvUI_EltreumUI.loottext.currency = value end,
								},
								pet = {
									type = 'toggle',
									name = L["Pets"],
									order = 5,
									disabled = function() return not E.db.ElvUI_EltreumUI.loottext.enable end,
									get = function() return E.db.ElvUI_EltreumUI.loottext.pet end,
									set = function(_, value) E.db.ElvUI_EltreumUI.loottext.pet = value end,
								},
							}
					},
					header1 = {
						order = 3,
						type = "description",
						name = "",
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					lootscale = {
						type = 'range',
						name = L["Change the scale of LootText"],
						desc = L["Set the size of LootText"],
						order = 4,
						min = .1,
						max = 1.5,
						step = .05,
						width = "full",
						disabled = function() return not E.db.ElvUI_EltreumUI.loottext.enable end,
						get = function() return E.db.ElvUI_EltreumUI.loottext.scale end,
						set = function(_, value) E.db.ElvUI_EltreumUI.loottext.scale = value end,
					},
					addgaptobenice = {
						order = 5,
						type = "description",
						name = "",
					},
					lootscalereset = {
						type = 'execute',
						name = L["Reset Scale"],
						desc = L["Return LootText to its default scale"],
						order = 9,
						disabled = function() return not E.db.ElvUI_EltreumUI.loottext.enable end,
						func = function() E.db.ElvUI_EltreumUI.loottext.scale = 0.65 end,
					},
					header2 = {
						order = 10,
						type = "description",
						name = "",
						width = 'full',
						image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end,
					},
					lootstrata = {
						type = 'select',
						name = L["Change the strata of the Loot Text"],
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
						disabled = function() return not E.db.ElvUI_EltreumUI.loottext.enable end,
						get = function() return E.db.ElvUI_EltreumUI.loottext.strata end,
						set = function(_, value) E.db.ElvUI_EltreumUI.loottext.strata = value E:StaticPopup_Show('CONFIG_RL') end,
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
						disabled = function() return not E.db.ElvUI_EltreumUI.loottext.enable end,
						get = function() return E.db.ElvUI_EltreumUI.loottext.xOffset end,
						set = function(_, value) E.db.ElvUI_EltreumUI.loottext.xOffset = value end,
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
						disabled = function() return not E.db.ElvUI_EltreumUI.loottext.enable end,
						get = function() return E.db.ElvUI_EltreumUI.loottext.yOffset end,
						set = function(_, value) E.db.ElvUI_EltreumUI.loottext.yOffset = value end,
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
						name = L["Change the font of LootText to be that the ElvUI Default Font found in General"],
						width = 'full',
						order = 17,
					},
					customfontloot = {
						type = 'toggle',
						name = L["Use ElvUI General Font"],
						desc = L["Change the font of LootText"],
						order = 18,
						get = function() return E.db.ElvUI_EltreumUI.loottext.fontsetting end,
						set = function(_, value) E.db.ElvUI_EltreumUI.loottext.fontsetting = value E:StaticPopup_Show('CONFIG_RL') end,
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
			fastlootenable = {
				order = 39,
				name = L["Enable Fast Loot"],
				type = "toggle",
				desc = L["Decrease the time it takes for auto loot to work, works with TSM"],
				width = 'full',
				disabled = function() return E.db.ElvUI_EltreumUI.otherstuff.fastlootfilter or E.db.ElvUI_EltreumUI.otherstuff.lootwishlistfilter end,
				get = function() return E.db.ElvUI_EltreumUI.otherstuff.fastloot end,
				set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.fastloot = value SetCVar('autoLootDefault', 1) E:StaticPopup_Show('CONFIG_RL') end,
			},
			fastlootenablefilter = {
				order = 40,
				name = L["Enable Fast Loot with Loot Quality Filter"],
				type = "toggle",
				desc = L["Enable filtering item quality, items can still be looted by holding Shift or the mod key setup in Interface"],
				width = 'full',
				disabled = function() return E.db.ElvUI_EltreumUI.otherstuff.fastloot or E.db.ElvUI_EltreumUI.otherstuff.lootwishlistfilter end,
				get = function() return E.db.ElvUI_EltreumUI.otherstuff.fastlootfilter end,
				set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.fastlootfilter = value SetCVar('autoLootDefault', 0) E:StaticPopup_Show('CONFIG_RL') end,
			},
			lootwishlistfilter = {
				order = 41,
				name = L["Enable Fast Loot with Wishlist Filter"],
				type = "toggle",
				desc = L["Items not on the wishlist will not be looted, items can still be looted by holding Shift or the mod key setup in Interface"],
				width = 'full',
				disabled = function() return E.db.ElvUI_EltreumUI.otherstuff.fastloot or E.db.ElvUI_EltreumUI.otherstuff.fastlootfilter or #E.private.ElvUI_EltreumUI.wishlistID == 0 end,
				get = function() return E.db.ElvUI_EltreumUI.otherstuff.lootwishlistfilter end,
				set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.lootwishlistfilter = value SetCVar('autoLootDefault', 0) E:StaticPopup_Show('CONFIG_RL') end,
			},
			lootwishlistwarning = {
				order = 42,
				name = L["Enable Wishlist Loot Warning"],
				type = "toggle",
				desc = L["Show a toast if an item in the wishlist is looted"],
				width = 'full',
				disabled = function() return #E.private.ElvUI_EltreumUI.wishlistID == 0 end,
				get = function() return E.db.ElvUI_EltreumUI.otherstuff.lootwishlistwarning end,
				set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.lootwishlistwarning = value E:StaticPopup_Show('CONFIG_RL') end,
			},
			lootautoclose = {
				order = 43,
				name = L["Enable Automatically Closing Loot Window"],
				type = "toggle",
				desc = L["Loot Window will automatically close when using filters and the item desired is not found"],
				width = 'full',
				get = function() return E.db.ElvUI_EltreumUI.otherstuff.lootautoclose end,
				set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.lootautoclose = value E:StaticPopup_Show('CONFIG_RL') end,
			},
			lootscreenshot = {
				order = 43,
				name = L["Enable Screenshotting if an item from the wishlist is looted"],
				type = "toggle",
				desc = L["Automatically screenshot when you loot an item from the wishlist"],
				width = 'full',
				disabled = function() return #E.private.ElvUI_EltreumUI.wishlistID == 0 end,
				get = function() return E.db.ElvUI_EltreumUI.otherstuff.lootwishlistscreenshot end,
				set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.lootwishlistscreenshot = value E:StaticPopup_Show('CONFIG_RL') end,
			},
			fastlootenablefilterquality = {
				order = 43,
				type = 'select',
				name = L["Minimum Loot Quality Filter"],
				desc = L["Only items of this quality or better will be looted when using Fast Loot Filter"],
				values = {
					["0"] = L["Poor"],
					["1"] = L["Common"],
					["2"] = L["Uncommon"],
					["3"] = L["Rare"],
					["4"] = L["Epic"],
				},
				style = 'radio',
				disabled = function() return E.db.ElvUI_EltreumUI.otherstuff.fastloot or not E.db.ElvUI_EltreumUI.otherstuff.fastlootfilter or E.db.ElvUI_EltreumUI.otherstuff.lootwishlistfilter end,
				get = function() return E.db.ElvUI_EltreumUI.otherstuff.fastlootquality end,
				set = function(_, value) E.db.ElvUI_EltreumUI.otherstuff.fastlootquality = value E:StaticPopup_Show('CONFIG_RL') end,
			},
			lootwishlist = {
				order = 44,
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
				order = 45,
				type = 'select',
				width = "double",
				name = L["Remove item from Wishlist"],
				desc = L["Remove"],
				values = E.private.ElvUI_EltreumUI.wishlistName,
				get = function() return E.private.ElvUI_EltreumUI.wishlistName end,
				set = function(_,value)
					local item = tonumber(value)
					tremove(E.private.ElvUI_EltreumUI.wishlistID, item)
					tremove(E.private.ElvUI_EltreumUI.wishlistName, item)
				 end,
			},
		},
	}
	return loottext
end
