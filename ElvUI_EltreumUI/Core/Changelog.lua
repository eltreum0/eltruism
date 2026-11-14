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
Added an option to hide the Blizzard Ranged Swing Timer in Forever when no timer is active
]], 3, "small", nil, nil, nil, nil, "full")

	--updated
	ElvUI_EltreumUI.Options.args.changelog.args.updated = E.Libs.ACH:Group(E:TextGradient("Updated", 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 3)
	ElvUI_EltreumUI.Options.args.changelog.args.updated.inline = true
	ElvUI_EltreumUI.Options.args.changelog.args.updated.args.description = E.Libs.ACH:Description([[
Updated DBM skin to match Ace3 styling, optimizing bar and timer hooks, textures, and options
Updated performance across shadows, unitframes, gradients, borders, tooltips, and nameplates
Updated keystone commands (/!key and /!keys) to improve detection and bag scanning
Updated specialization detection to better support Retail, Forever, and Classic
Updated Stats datatext to cache calculations and support Devourer Demon Hunters
Updated [eltruism:leader] and [eltruism:leader:emoji] tags with secret checks
Updated HereBeDragons pin masking on the rectangle minimap for Questie
Updated Localizations
]], 5, "small", nil, nil, nil, nil, "full")

	--fixed
	ElvUI_EltreumUI.Options.args.changelog.args.fixed = E.Libs.ACH:Group(E:TextGradient("Fixed", 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 4)
	ElvUI_EltreumUI.Options.args.changelog.args.fixed.inline = true
	ElvUI_EltreumUI.Options.args.changelog.args.fixed.args.description = E.Libs.ACH:Description([[
Fixed portrait models and custom textures continuing to show when portraits are disabled
Fixed leader and assist icons not displaying properly across unitframes and group frames
Fixed custom sound errors in DBM profiles by utilizing Voice Encounter Mods
Fixed ammo text not displaying in Forever and other versions that have ammo
Fixed avoidance calculations in Classic when defense values are secret
Fixed stance detection and bar switching in dynamic functions
Fixed Player and Target of Target Dispel Glow
]], 7, "small", nil, nil, nil, nil, "full")

	--other
--	ElvUI_EltreumUI.Options.args.changelog.args.note = E.Libs.ACH:Group(E:TextGradient("Other", 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 3)
--	ElvUI_EltreumUI.Options.args.changelog.args.note.inline = true
--	ElvUI_EltreumUI.Options.args.changelog.args.note.args.description = E.Libs.ACH:Description([[
--]], 5, "small", nil, nil, nil, nil, "full")
end
