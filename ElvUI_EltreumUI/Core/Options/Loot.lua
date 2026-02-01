local E = unpack(ElvUI)
local L = E.Libs.ACL:GetLocale('ElvUI', E.global.general.locale)
local _G = _G
local SetCVar = _G.C_CVar and _G.C_CVar.SetCVar or _G.SetCVar
local ITEM_QUALITY0_DESC = _G.ITEM_QUALITY0_DESC
local ITEM_QUALITY1_DESC = _G.ITEM_QUALITY1_DESC
local ITEM_QUALITY2_DESC = _G.ITEM_QUALITY2_DESC
local ITEM_QUALITY3_DESC = _G.ITEM_QUALITY3_DESC
local ITEM_QUALITY4_DESC = _G.ITEM_QUALITY4_DESC

-- Eltruism loot options
function ElvUI_EltreumUI:LootOptions()
	ElvUI_EltreumUI.Options.args.loot = E.Libs.ACH:Group(E:TextGradient(_G.LOOT, 0.50, 0.70, 1, 0.67, 0.95, 1), L["Add a scrolling loot text that will show items that you loot, filter which items you can loot, enable fast looting and create your own item wishlist"], 85, 'tab')
	ElvUI_EltreumUI.Options.args.loot.icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\loot'
	ElvUI_EltreumUI.Options.args.loot.args.loottext = E.Libs.ACH:Group(L["LootText"], nil, 1, nil,nil,nil,nil,E.Retail)
	ElvUI_EltreumUI.Options.args.loot.args.loottext.args.setting = E.Libs.ACH:Group("", nil, 1)
	ElvUI_EltreumUI.Options.args.loot.args.loottext.args.setting.inline = true
	ElvUI_EltreumUI.Options.args.loot.args.loottext.args.setting.args.description1 = E.Libs.ACH:Description(L["Show a floating loot text"], 1, nil, nil, nil, nil, nil, "full")
	ElvUI_EltreumUI.Options.args.loot.args.loottext.args.setting.args.enable = E.Libs.ACH:Toggle(L["Enable"], L["Toggle On and Off"], 9, nil, false, nil, function() return E.db.ElvUI_EltreumUI.loot.loottext.enable end,function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.enable = value E:StaticPopup_Show('CONFIG_RL') end)
	ElvUI_EltreumUI.Options.args.loot.args.loottext.args.types = E.Libs.ACH:Group(L["Text Types"], nil, 1, "tab")
	ElvUI_EltreumUI.Options.args.loot.args.loottext.args.types.args.honor = E.Libs.ACH:Toggle(_G.HONOR, nil, 1, nil, false, nil, function() return E.db.ElvUI_EltreumUI.loot.loottext.honor end,function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.honor = value end, function() return not E.db.ElvUI_EltreumUI.loot.loottext.enable end)
	ElvUI_EltreumUI.Options.args.loot.args.loottext.args.types.args.currency = E.Libs.ACH:Toggle(_G.CURRENCY, nil, 1, nil, false, nil, function() return E.db.ElvUI_EltreumUI.loot.loottext.currency end,function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.currency = value end, function() return not E.db.ElvUI_EltreumUI.loot.loottext.enable end)
	ElvUI_EltreumUI.Options.args.loot.args.loottext.args.types.args.pet = E.Libs.ACH:Toggle(L["Pets"], nil, 1, nil, false, nil, function() return E.db.ElvUI_EltreumUI.loot.loottext.pet end,function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.pet = value end, function() return not E.db.ElvUI_EltreumUI.loot.loottext.enable end)
	ElvUI_EltreumUI.Options.args.loot.args.loottext.args.types.args.skill = E.Libs.ACH:Toggle(_G.SKILL, nil, 1, nil, false, nil, function() return E.db.ElvUI_EltreumUI.loot.loottext.skill end,function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.skill = value end, function() return not E.db.ElvUI_EltreumUI.loot.loottext.enable end)
	ElvUI_EltreumUI.Options.args.loot.args.loottext.args.filter = E.Libs.ACH:Group(L["Filter"], nil, 1, "tab")
	ElvUI_EltreumUI.Options.args.loot.args.loottext.args.filter.args.quality = E.Libs.ACH:Select(L["Minimum Loot Quality Filter"], L["Only items of this quality or better will be displayed"], 10, {
		["0"] = ITEM_QUALITY0_DESC,
		["1"] = ITEM_QUALITY1_DESC,
		["2"] = ITEM_QUALITY2_DESC,
		["3"] = ITEM_QUALITY3_DESC,
		["4"] = ITEM_QUALITY4_DESC,
	}, false, nil, function() return E.db.ElvUI_EltreumUI.loot.loottext.quality end, function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.quality = value end, function() return not E.db.ElvUI_EltreumUI.loot.loottext.enable end)
	ElvUI_EltreumUI.Options.args.loot.args.loottext.args.filter.args.quality.style = "radio"
	ElvUI_EltreumUI.Options.args.loot.args.loottext.args.scale = E.Libs.ACH:Group(L["Scale"], nil, 1, "tab")
	ElvUI_EltreumUI.Options.args.loot.args.loottext.args.scale.args.description1 = E.Libs.ACH:Description(L["Change the scale of LootText"], 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.loot.args.loottext.args.scale.args.lootscale = E.Libs.ACH:Range(L["Set the size of LootText"], nil, 2, { min = 0.1, max = 1.5, step = 0.05 }, "full", function() return E.db.ElvUI_EltreumUI.loot.loottext.scale end, function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.scale = value end, function() return not E.db.ElvUI_EltreumUI.loot.loottext.enable end)
	ElvUI_EltreumUI.Options.args.loot.args.loottext.args.scale.args.reset = E.Libs.ACH:Execute(L["Reset Scale"], L["Return LootText to its default scale"], 3, function() E.db.ElvUI_EltreumUI.loot.loottext.scale = 0.65 end, nil, false, "full", nil, nil, function() return not E.db.ElvUI_EltreumUI.loot.loottext.enable end)
	ElvUI_EltreumUI.Options.args.loot.args.loottext.args.strata = E.Libs.ACH:Group(L["Strata"], nil, 1, "tab")
	ElvUI_EltreumUI.Options.args.loot.args.loottext.args.strata.args.description1 = E.Libs.ACH:Description(L["Change the strata of the Loot Text"], 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.loot.args.loottext.args.strata.args.lootstrata = E.Libs.ACH:Select(" ", L["Set the level that LootText will be drawn to this"], 2, {
		["BACKGROUND"] = L["Background"],
		["LOW"] = L["Low"],
		["MEDIUM"] = L["Medium"],
		["HIGH"] = L["High"],
		["DIALOG"] = L["Dialog"],
	}, false, nil, function() return E.db.ElvUI_EltreumUI.loot.loottext.strata end, function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.strata = value E:StaticPopup_Show('CONFIG_RL') end, function() return not E.db.ElvUI_EltreumUI.loot.loottext.enable end)
	ElvUI_EltreumUI.Options.args.loot.args.loottext.args.strata.args.lootstrata.style = "radio"
	ElvUI_EltreumUI.Options.args.loot.args.loottext.args.position = E.Libs.ACH:Group(L["Position"], nil, 1, "tab")
	ElvUI_EltreumUI.Options.args.loot.args.loottext.args.position.args.description1 = E.Libs.ACH:Description(" ", 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.loot.args.loottext.args.position.args.x = E.Libs.ACH:Range(L["Change the Horizontal Position of LootText (Default = 0)"], nil, 2, { min = -1000, max = 1000, step = 1 }, "full", function() return E.db.ElvUI_EltreumUI.loot.loottext.xOffset end, function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.xOffset = value end, function() return not E.db.ElvUI_EltreumUI.loot.loottext.enable end)
	ElvUI_EltreumUI.Options.args.loot.args.loottext.args.position.args.y = E.Libs.ACH:Range(L["Change the Vertical Position of LootText (Default = 200)"], nil, 3, { min = -1000, max = 1000, step = 1 }, "full", function() return E.db.ElvUI_EltreumUI.loot.loottext.yOffset end, function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.yOffset = value end, function() return not E.db.ElvUI_EltreumUI.loot.loottext.enable end)
	ElvUI_EltreumUI.Options.args.loot.args.loottext.args.fonts = E.Libs.ACH:Group(L["Fonts"], nil, 1, "tab")
	ElvUI_EltreumUI.Options.args.loot.args.loottext.args.fonts.args.description1 = E.Libs.ACH:Description(" ", 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.loot.args.loottext.args.fonts.args.size = E.Libs.ACH:Range(L["Font Size"], nil, 2, { min = 4, max = 160, step = 1 }, "full", function() return E.db.ElvUI_EltreumUI.loot.loottext.fontsize end, function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.fontsize = value end, function() return not E.db.ElvUI_EltreumUI.loot.loottext.enable end)
	ElvUI_EltreumUI.Options.args.loot.args.loottext.args.fonts.args.description2 = E.Libs.ACH:Description(L["Change the font of LootText to be the ElvUI Default Font found in General"], 3, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.loot.args.loottext.args.fonts.args.customfont = E.Libs.ACH:Toggle(L["Use ElvUI General Font"], L["Change the font of LootText"], 4, nil, false, nil, function() return E.db.ElvUI_EltreumUI.loot.loottext.fontsetting end,function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.fontsetting = value E:StaticPopup_Show('CONFIG_RL') end, function() return E.db.ElvUI_EltreumUI.loot.loottext.fontsettingdmg or E.db.ElvUI_EltreumUI.loot.loottext.fontLSMenable or not E.db.ElvUI_EltreumUI.loot.loottext.enable end)
	ElvUI_EltreumUI.Options.args.loot.args.loottext.args.fonts.args.customfontdmg = E.Libs.ACH:Toggle(L["Use ElvUI Damage Font"], L["Change the font of LootText"], 5, nil, false, nil, function() return E.db.ElvUI_EltreumUI.loot.loottext.fontsettingdmg end,function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.fontsettingdmg = value E:StaticPopup_Show('CONFIG_RL') end, function() return E.db.ElvUI_EltreumUI.loot.loottext.fontsetting or E.db.ElvUI_EltreumUI.loot.loottext.fontLSMenable or not E.db.ElvUI_EltreumUI.loot.loottext.enable end)
	ElvUI_EltreumUI.Options.args.loot.args.loottext.args.fonts.args.customLSMenable = E.Libs.ACH:Toggle(L["Use Custom Font"], L["Change the font of LootText"], 6, nil, false, nil, function() return E.db.ElvUI_EltreumUI.loot.loottext.fontLSMenable end,function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.fontLSMenable = value E:StaticPopup_Show('CONFIG_RL') end, function() return E.db.ElvUI_EltreumUI.loot.loottext.fontsettingdmg or E.db.ElvUI_EltreumUI.loot.loottext.fontsetting end)
	ElvUI_EltreumUI.Options.args.loot.args.loottext.args.fonts.args.customLSMfont = E.Libs.ACH:SharedMediaFont(L["Font"], L["Choose a different font from the preselected ones"], 7, nil, function() return E.db.ElvUI_EltreumUI.loot.loottext.fontLSM end, function(_,fontvalue) E.db.ElvUI_EltreumUI.loot.loottext.fontLSM = fontvalue end, function() return E.db.ElvUI_EltreumUI.loot.loottext.fontsettingdmg or E.db.ElvUI_EltreumUI.loot.loottext.fontsetting or not E.db.ElvUI_EltreumUI.loot.loottext.fontLSMenable end)
	ElvUI_EltreumUI.Options.args.loot.args.fastloot = E.Libs.ACH:Group("Fast Loot", nil, 2)
	ElvUI_EltreumUI.Options.args.loot.args.fastloot.args.enable = E.Libs.ACH:Toggle(L["Enable Fast Loot"], L["Decrease the time it takes for auto loot to work, works with TSM"], 1, nil, false, "full", function() return E.db.ElvUI_EltreumUI.loot.fastloot end,function(_, value) E.db.ElvUI_EltreumUI.loot.fastloot = value SetCVar('autoLootDefault', 1) E:StaticPopup_Show('CONFIG_RL') end, function() return E.db.ElvUI_EltreumUI.loot.fastlootfilter or E.db.ElvUI_EltreumUI.loot.lootwishlistfilter end)
	ElvUI_EltreumUI.Options.args.loot.args.fastloot.args.enablefilter = E.Libs.ACH:Toggle(L["Enable Fast Loot with Loot Quality Filter"], L["Enable filtering item quality, items can still be looted by holding Shift or the mod key setup in Interface"], 2, nil, false, "full", function() return E.db.ElvUI_EltreumUI.loot.fastlootfilter end, function(_, value) E.db.ElvUI_EltreumUI.loot.fastlootfilter = value SetCVar('autoLootDefault', 0) E:StaticPopup_Show('CONFIG_RL') end, function() return E.db.ElvUI_EltreumUI.loot.fastloot or E.db.ElvUI_EltreumUI.loot.lootwishlistfilter end)
	ElvUI_EltreumUI.Options.args.loot.args.fastloot.args.enablewishlist = E.Libs.ACH:Toggle(L["Enable Fast Loot with Wishlist Filter"], L["Items not on the wishlist will not be looted, items can still be looted by holding Shift or the mod key setup in Interface"], 3, nil, false, "full", function() return E.db.ElvUI_EltreumUI.loot.lootwishlistfilter end, function(_, value) E.db.ElvUI_EltreumUI.loot.lootwishlistfilter = value SetCVar('autoLootDefault', 0) E:StaticPopup_Show('CONFIG_RL') end, function() return E.db.ElvUI_EltreumUI.loot.fastloot or E.db.ElvUI_EltreumUI.loot.fastlootfilter or #E.private.ElvUI_EltreumUI.wishlistID == 0 end)
	ElvUI_EltreumUI.Options.args.loot.args.fastloot.args.enablewishlistwarning = E.Libs.ACH:Toggle(L["Enable Wishlist Loot Warning"], L["Show a toast if an item in the wishlist is looted"], 4, nil, false, "full", function() return E.db.ElvUI_EltreumUI.loot.lootwishlistwarning end, function(_, value) E.db.ElvUI_EltreumUI.loot.lootwishlistwarning = value E:StaticPopup_Show('CONFIG_RL') end, function() return #E.private.ElvUI_EltreumUI.wishlistID == 0 end)
	ElvUI_EltreumUI.Options.args.loot.args.fastloot.args.autoclose = E.Libs.ACH:Toggle(L["Enable Automatically Closing Loot Window"], L["Loot Window will automatically close when using filters and the item desired is not found"], 4, nil, false, "full", function() return E.db.ElvUI_EltreumUI.loot.lootautoclose end, function(_, value) E.db.ElvUI_EltreumUI.loot.lootautoclose = value E:StaticPopup_Show('CONFIG_RL') end)
	ElvUI_EltreumUI.Options.args.loot.args.fastloot.args.confirmbop = E.Libs.ACH:Toggle(L["Enable Automatically Confirming Bind on Pickup"], L["Loot Window will automatically confirm looting Bind on Pickup items"], 4, nil, false, "full", function() return E.db.ElvUI_EltreumUI.loot.confirmbop end, function(_, value) E.db.ElvUI_EltreumUI.loot.confirmbop = value end)
	ElvUI_EltreumUI.Options.args.loot.args.fastloot.args.screenshot = E.Libs.ACH:Toggle(L["Enable Screenshotting if an item from the wishlist is looted"], L["Automatically screenshot when you loot an item from the wishlist"], 4, nil, false, "full", function() return E.db.ElvUI_EltreumUI.loot.lootwishlistscreenshot end, function(_, value) E.db.ElvUI_EltreumUI.loot.lootwishlistscreenshot = value E:StaticPopup_Show('CONFIG_RL') end, function() return #E.private.ElvUI_EltreumUI.wishlistID == 0 end, E.Retail)
	ElvUI_EltreumUI.Options.args.loot.args.fastloot.args.filterquality = E.Libs.ACH:Select(L["Minimum Loot Quality Filter"], L["Only items of this quality or better will be looted when using Fast Loot Filter"], 4, {
		["0"] = ITEM_QUALITY0_DESC,
		["1"] = ITEM_QUALITY1_DESC,
		["2"] = ITEM_QUALITY2_DESC,
		["3"] = ITEM_QUALITY3_DESC,
		["4"] = ITEM_QUALITY4_DESC,
	}, false, "full", function() return E.db.ElvUI_EltreumUI.loot.fastlootquality end, function(_, value) E.db.ElvUI_EltreumUI.loot.fastlootquality = value E:StaticPopup_Show('CONFIG_RL') end, function() return E.db.ElvUI_EltreumUI.loot.fastloot or not E.db.ElvUI_EltreumUI.loot.fastlootfilter or E.db.ElvUI_EltreumUI.loot.lootwishlistfilter end)
	ElvUI_EltreumUI.Options.args.loot.args.fastloot.args.sound = E.Libs.ACH:Toggle(L["Enable Playing a Sound if an item from the wishlist is looted"], nil, 4, nil, false, "full", function() return E.db.ElvUI_EltreumUI.loot.lootwishlistsoundenable end, function(_, value) E.db.ElvUI_EltreumUI.loot.lootwishlistsoundenable = value E:StaticPopup_Show('CONFIG_RL') end, function() return #E.private.ElvUI_EltreumUI.wishlistID == 0 end)
	ElvUI_EltreumUI.Options.args.loot.args.fastloot.args.soundLSM = E.Libs.ACH:SharedMediaSound(L["Select a Sound"], L["Choose a Sound from SharedMedia files"], 5, "full", function() return E.db.ElvUI_EltreumUI.loot.lootwishlistsound end, function(_,key) E.db.ElvUI_EltreumUI.loot.lootwishlistsound = key E:StaticPopup_Show('CONFIG_RL') end, function() return not E.db.ElvUI_EltreumUI.loot.lootwishlistsoundenable or (#E.private.ElvUI_EltreumUI.wishlistID == 0) end)
	ElvUI_EltreumUI.Options.args.loot.args.fastloot.args.lootwishlistenter = E.Libs.ACH:Input(L["Item Wishlist (type the Item ID)"], L["Items in your wishlist will display a warning when looted"], 6, nil, "full", function() return E.private.ElvUI_EltreumUI.wishlistID end,
		function(_, value)
			value = _G.tonumber(value)
			local item = _G.Item:CreateFromItemID(value)
			if not item:IsItemEmpty() then
				item:ContinueOnItemLoad(function()
					local itemName = item:GetItemName()
					local itemID = _G.tonumber(value)
					_G.tinsert(E.private.ElvUI_EltreumUI.wishlistName, itemName)
					_G.tinsert(E.private.ElvUI_EltreumUI.wishlistID, itemID)
				end)
			end
		end, nil, nil,
		function(_, value)
			E.PopupDialogs["ELTRUISMINVALID"] = {
				text = L["Invalid Item, you need to add an itemID which can be found in the tooltip or in Wowhead"],
				button1 = _G.OKAY,
				timeout = 0,
				whileDead = 1,
				hideOnEscape = true,
			}
			if _G.tonumber(value) ~= nil then
				value = _G.tonumber(value)
				local item = _G.Item:CreateFromItemID(value)
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
		end)
	ElvUI_EltreumUI.Options.args.loot.args.fastloot.args.lootwishlistremove = E.Libs.ACH:Select(L["Remove item from Wishlist"], _G.REMOVE, 7, E.private.ElvUI_EltreumUI.wishlistName, true, "full", function() return E.private.ElvUI_EltreumUI.wishlistName end, function(_,value)
		local item = _G.tonumber(value)
		_G.tremove(E.private.ElvUI_EltreumUI.wishlistID, item)
		_G.tremove(E.private.ElvUI_EltreumUI.wishlistName, item)
	end)
end
