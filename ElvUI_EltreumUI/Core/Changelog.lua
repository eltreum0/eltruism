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
Added an option to display player Level in Chat with difficulty coloring
Added Several Glow styles to Custom Glow via the new LibEltreumGlow
Added Power Texture option to Unitframe Custom Textures
Added Duel music to Combat Events with duel detection
Added a skin for FollowTheArrow
]], 3, "small", nil, nil, nil, nil, "full")

	--updated
	ElvUI_EltreumUI.Options.args.changelog.args.updated = E.Libs.ACH:Group(E:TextGradient("Updated", 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 3)
	ElvUI_EltreumUI.Options.args.changelog.args.updated.inline = true
	ElvUI_EltreumUI.Options.args.changelog.args.updated.args.description = E.Libs.ACH:Description([[
Updated Custom Glow to use LibEltreumGlow, replacing active glows smoothly, improving performance, and adding repeat controls
Updated Character Panel, Cursor Cooldown, and Nameplate Power Bar to optimize event handling and performance
Updated LootText to use custom scroll functions and removed the Blizzard_CombatText dependency
Updated Dispel Glow to once again work in Retail and Forever after the aura containers change
Updated Aura Borders registration to simplify and improve container handling
Updated Mail arrival notification with updated flipbook animations
Updated Performance Optimization to disable Target of Target
Updated Skyborne Elf race icons with in-game textures
Updated Forever Character Panel to fix its skin
Updated Evoker default gradient colors
Updated several shadows for Forever
Updated Localizations
]], 5, "small", nil, nil, nil, nil, "full")

	--fixed
	ElvUI_EltreumUI.Options.args.changelog.args.fixed = E.Libs.ACH:Group(E:TextGradient("Fixed", 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 4)
	ElvUI_EltreumUI.Options.args.changelog.args.fixed.inline = true
	ElvUI_EltreumUI.Options.args.changelog.args.fixed.args.description = E.Libs.ACH:Description([[
Fixed unitframe and castbar backdrop alpha and texture hiding when using static or hidden backdrops
Fixed a possible issue when using map addons where the wowhead button would become unresponsive
Fixed Craft and Beast Training frame expansion and button sizing in Classic Era and TBC
Fixed Damage Meter skin errors when specialization is nil and improved secret checks
Fixed an issue where Target of Target could be missing class color in Dark Mode
Fixed the [name:eltruism:gradientreverse] tag using the target instead of unit
Fixed secret value issues across Character Panel stats and Blinkii portraits
Fixed an issue with the Damage Meter after Spec Icon became secret
Fixed a possible issue with the Eltruism Stats datatext in combat
Fixed an issue where Bags would not be openable in combat
Fixed PetBattleFrame shadow error in non-Mists clients
Fixed an issue where the Tooltip could start blinking
Fixed an issue where Edit Mode toggle was missing
Fixed Shaman totem options in Custom Glow
]], 7, "small", nil, nil, nil, nil, "full")

	--other
--	ElvUI_EltreumUI.Options.args.changelog.args.note = E.Libs.ACH:Group(E:TextGradient("Other", 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 3)
--	ElvUI_EltreumUI.Options.args.changelog.args.note.inline = true
--	ElvUI_EltreumUI.Options.args.changelog.args.note.args.description = E.Libs.ACH:Description([[
--]], 5, "small", nil, nil, nil, nil, "full")
end
