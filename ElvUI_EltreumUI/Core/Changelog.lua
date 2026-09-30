local E = unpack(ElvUI)
local L = E.Libs.ACL:GetLocale('ElvUI', E.global.general.locale)

-- Eltruism Changelog
function ElvUI_EltreumUI:Changelog()

	--changelog
	ElvUI_EltreumUI.Options.args.changelog = E.Libs.ACH:Group(E:TextGradient(L["Changelog"], 0.50, 0.70, 1, 0.67, 0.95, 1), L["Check what has changed in the current version of Eltruism"], 11, 'tab')
	ElvUI_EltreumUI.Options.args.changelog.icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\changelog'
	ElvUI_EltreumUI.Options.args.changelog.args.changelog = E.Libs.ACH:Input(L["Changelog"], "", 1, false, "full", function() return 'https://github.com/eltreum0/eltruism/blob/main/Changelog.md' end)
	ElvUI_EltreumUI.Options.args.changelog.args.description1 = E.Libs.ACH:Description(E.NewSign..E:TextGradient("v"..ElvUI_EltreumUI.Version, 0.50, 0.70, 1, 0.67, 0.95, 1), 2, "large", nil, nil, nil, nil, "full")

	--added
	ElvUI_EltreumUI.Options.args.changelog.args.added = E.Libs.ACH:Group(E:TextGradient("Added", 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 3)
	ElvUI_EltreumUI.Options.args.changelog.args.added.inline = true
	ElvUI_EltreumUI.Options.args.changelog.args.added.args.description = E.Libs.ACH:Description([[
Added support for World of Warcraft Forever
Added an ElvUI mover for LootText
Added option previews for Dark/Light modes, textures, AFK music, and Death animations
Added a command (/eltruism transparent) to toggle unitframe transparent health
Added cooking profession ID for Titan Reforged (thanks Dongchen Xu)
Added Nameplate Custom Height back using different functions
Added support for Skyborne Elves in several functions
Added several more shadows
]], 3, "small", nil, nil, nil, nil, "full")

	--updated
	ElvUI_EltreumUI.Options.args.changelog.args.updated = E.Libs.ACH:Group(E:TextGradient("Updated", 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 3)
	ElvUI_EltreumUI.Options.args.changelog.args.updated.inline = true
	ElvUI_EltreumUI.Options.args.changelog.args.updated.args.description = E.Libs.ACH:Description([[
Updated Class Combat Indicator to use default ElvUI indicator when unit class is secret
Updated the Installation process, optimizing it
Updated Aurabars to re-add gradients, thin mode, update settings, and fix shadows
Updated options layout and moved combat settings into a dedicated section
Updated Gradient functions to cache values and improve performance
Updated Castbars to better handle interrupts in Retail and Forever
Updated Aura Filters to once again work in non Modern versions
Updated DataTexts to better support Forever and Classic Era
Updated Nameplate threat scaling to avoid scaling issues
Updated Group Power gradient textures and color updates
Updated Castbars to unify player and target castbars
Updated Nameplate borders to use threat colors
Updated Glows to optimize execution
Updated localizations
]], 5, "small", nil, nil, nil, nil, "full")

	--fixed
	ElvUI_EltreumUI.Options.args.changelog.args.fixed = E.Libs.ACH:Group(E:TextGradient("Fixed", 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 4)
	ElvUI_EltreumUI.Options.args.changelog.args.fixed.inline = true
	ElvUI_EltreumUI.Options.args.changelog.args.fixed.args.description = E.Libs.ACH:Description([[
Fixed group borders having forced class colors when class-colored borders were disabled
Fixed several errors caused by secret values in combat, character stats, and DataTexts
Fixed unitframe textures and backgrounds when using transparent health
Fixed Minimap border misalignment when auto adjust is enabled
Fixed 3D models not inheriting alpha and nil alpha errors
Fixed Damage Meter skin after ElvUI skin changes
Fixed default Nameplate Power Bar size in Retail
Fixed aura borders due to container changes
Fixed BugSack skin after updates
]], 7, "small", nil, nil, nil, nil, "full")

	--other
	ElvUI_EltreumUI.Options.args.changelog.args.note = E.Libs.ACH:Group(E:TextGradient("Other", 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 3)
	ElvUI_EltreumUI.Options.args.changelog.args.note.inline = true
	ElvUI_EltreumUI.Options.args.changelog.args.note.args.description = E.Libs.ACH:Description([[
Removed profiles for addons that have abandoned Retail (Gladius, GladiusEx, BattleGroundEnemies, OmniCD, AddOnSkins, ProjectAzilroka)
Note: Due to castbar database changes, a database conversion will run automatically.
]], 5, "small", nil, nil, nil, nil, "full")
end
