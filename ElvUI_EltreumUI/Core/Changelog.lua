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
Added Fishing and Titan Reforged cooking ID to Bag Profession Buttons (thanks Dongchen Xu)
Added option previews for Dark/Light modes, textures, AFK music, and Death animations
Added a command (/eltruism transparent) to toggle unitframe transparent health
Added Nameplate Custom Height back using different functions
Added support for Skyborne Elves in several functions
Added Rare 2, Boss 1 and Boss 2 textures to Portrait
Added a Waypoint Name option to Map Waypoints
Added an ElvUI mover for LootText
Added several more shadows
]], 3, "small", nil, nil, nil, nil, "full")

	--updated
	ElvUI_EltreumUI.Options.args.changelog.args.updated = E.Libs.ACH:Group(E:TextGradient("Updated", 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 3)
	ElvUI_EltreumUI.Options.args.changelog.args.updated.inline = true
	ElvUI_EltreumUI.Options.args.changelog.args.updated.args.description = E.Libs.ACH:Description([[
Updated Castbars to unify player and target, improve interrupt handling, and revamp non-interruptible shields
Updated options layout, installation process, and moved combat settings into a dedicated section
Updated Shadows and Universal Borders to improve size, coloring, strata, and aura containers
Updated Quest Objective Tracker progress bars to improve backdrop coloring and dynamic hooks
Updated several tags to improve performance and restore [eltruism:classification] in Retail
Updated DataTexts and Max Camera Distance Zoom to better support Forever and Classic Era
Updated Aurabars to re-add gradients, custom fonts/outlines, thin mode, and fix shadows
Updated Class Combat Indicator to use default ElvUI indicator when unit class is secret
Updated Immersion skin to reliably skin dialogue options and quest reward choices
Updated CVars to show loot sparkle effects when object outline is disabled
Updated Nameplate threat scaling, borders, and power bar autopositioning
Updated hooks, glows, and gradient caching to optimize performance
Updated Tooltip skin to use separate functions and dynamic hooks
Updated Aura Filters and Chat Icons to sync with ElvUI changes
Updated Wishlist to automatically remove items once obtained
Updated Group Power gradient textures and color updates
Updated Thin Mode layout
Updated Localizations
]], 5, "small", nil, nil, nil, nil, "full")

	--fixed
	ElvUI_EltreumUI.Options.args.changelog.args.fixed = E.Libs.ACH:Group(E:TextGradient("Fixed", 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 4)
	ElvUI_EltreumUI.Options.args.changelog.args.fixed.inline = true
	ElvUI_EltreumUI.Options.args.changelog.args.fixed.args.description = E.Libs.ACH:Description([[
Fixed non-interruptible castbar colors persisting across casts, missing gradients, and aurabar debuffs
Fixed texture escape sequences in tags causing classification, role, and class icons to not display
Fixed Nameplate Target Model persisting, Power Bar sizing/clipping, and disabled gradient errors
Fixed health tags in modern WoW when values are secret, restoring short values and status icons
Fixed player and group unitframe textures, backgrounds, and transparency on login and reload
Fixed several errors caused by secret values in combat, character stats, and DataTexts
Fixed a possible issue when applying custom font outlines with mMediaTag enabled
Fixed aura and group borders coloring, container changes, and hiding behavior
Fixed Damage Meter skin after ElvUI changes and name shortening in non-Retail
Fixed border auto adjust in combat lockdown and Minimap border misalignment
Fixed 3D portraits and models not inheriting alpha and nil value errors
Fixed aura positioning overlapping with castbars in the DPS layout
Fixed unitframe gradient backdrop colors when unit class is secret
Fixed BugSack skin after updates and several shadow issues
Fixed Game Menu buttons animation in the Ace3 skin
]], 7, "small", nil, nil, nil, nil, "full")

	--other
	ElvUI_EltreumUI.Options.args.changelog.args.note = E.Libs.ACH:Group(E:TextGradient("Other", 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 3)
	ElvUI_EltreumUI.Options.args.changelog.args.note.inline = true
	ElvUI_EltreumUI.Options.args.changelog.args.note.args.description = E.Libs.ACH:Description([[
Removed profiles for abandoned addons (Gladius, GladiusEx, BattleGroundEnemies, OmniCD, AddOnSkins, ProjectAzilroka)
Removed deprecated friendly nameplate sizing and interaction options in instances
Note: Due to castbar database changes, a database conversion will run automatically.
]], 5, "small", nil, nil, nil, nil, "full")
end
