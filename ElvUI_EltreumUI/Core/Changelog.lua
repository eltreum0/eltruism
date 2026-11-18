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
Added a Secret Tracker datatext to Retail and Forever in order monitor active addon restriction states
Added a command (/eltruism newchar) to run Chat Setup, CVars, and Edit Mode on alts
]], 3, "small", nil, nil, nil, nil, "full")

	--updated
	ElvUI_EltreumUI.Options.args.changelog.args.updated = E.Libs.ACH:Group(E:TextGradient("Updated", 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 3)
	ElvUI_EltreumUI.Options.args.changelog.args.updated.inline = true
	ElvUI_EltreumUI.Options.args.changelog.args.updated.args.description = E.Libs.ACH:Description([[
Updated ActionBar vehicle and override paging in Forever for GamePad UI compatibility (requires ElvUI dev or future 16.02+)
Updated F.A.Q tab, renaming it to Help with organized categories, updated answers, and quick actions
Updated Objective Tracker anchor to better position itself after a level up in Forever and Retail
Updated Enemy NPC nameplate castbar target settings to use ElvUI's separate target display
Updated Cursor Cooldown to once again work in Retail and Forever
Updated Cooldown Pulse to once again work in Retail and Forever
Updated Damage Meter Skin, enabling Specialization Icons again
Updated Localizations
]], 5, "small", nil, nil, nil, nil, "full")

	--fixed
	ElvUI_EltreumUI.Options.args.changelog.args.fixed = E.Libs.ACH:Group(E:TextGradient("Fixed", 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 4)
	ElvUI_EltreumUI.Options.args.changelog.args.fixed.inline = true
	ElvUI_EltreumUI.Options.args.changelog.args.fixed.args.description = E.Libs.ACH:Description([[
Fixed button and tab text staying yellow after clicking or hovering a Button
]], 7, "small", nil, nil, nil, nil, "full")

	--other
--	ElvUI_EltreumUI.Options.args.changelog.args.note = E.Libs.ACH:Group(E:TextGradient("Other", 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 3)
--	ElvUI_EltreumUI.Options.args.changelog.args.note.inline = true
--	ElvUI_EltreumUI.Options.args.changelog.args.note.args.description = E.Libs.ACH:Description([[
--]], 5, "small", nil, nil, nil, nil, "full")
end
