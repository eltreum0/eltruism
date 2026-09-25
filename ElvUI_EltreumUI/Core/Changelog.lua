local E = unpack(ElvUI)
local L = E.Libs.ACL:GetLocale('ElvUI', E.global.general.locale)

-- Eltruism Changelog
function ElvUI_EltreumUI:Changelog()

	--changelog
	ElvUI_EltreumUI.Options.args.changelog = E.Libs.ACH:Group(E:TextGradient(L["Changelog"], 0.50, 0.70, 1, 0.67, 0.95, 1), L["Check what has changed in the current version of Eltruism"], 88, 'tab')
	ElvUI_EltreumUI.Options.args.changelog.icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\changelog'
	ElvUI_EltreumUI.Options.args.changelog.args.changelog = E.Libs.ACH:Input(L["Changelog"], "", 1, false, "full", function() return 'https://github.com/eltreum0/eltruism/blob/main/Changelog.md' end)
	ElvUI_EltreumUI.Options.args.changelog.args.description1 = E.Libs.ACH:Description(E.NewSign..E:TextGradient("v"..ElvUI_EltreumUI.Version, 0.50, 0.70, 1, 0.67, 0.95, 1), 2, "large", nil, nil, nil, nil, "full")

	--added
	ElvUI_EltreumUI.Options.args.changelog.args.added = E.Libs.ACH:Group(E:TextGradient("Added", 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 3)
	ElvUI_EltreumUI.Options.args.changelog.args.added.inline = true
	ElvUI_EltreumUI.Options.args.changelog.args.added.args.description = E.Libs.ACH:Description([[
Added support for World of Warcraft Forever
Added Nameplate Custom Height back using different functions
Added support for Skyborne Elves in several functions
]], 3, "small", nil, nil, nil, nil, "full")

	--updated
	ElvUI_EltreumUI.Options.args.changelog.args.updated = E.Libs.ACH:Group(E:TextGradient("Updated", 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 3)
	ElvUI_EltreumUI.Options.args.changelog.args.updated.inline = true
	ElvUI_EltreumUI.Options.args.changelog.args.updated.args.description = E.Libs.ACH:Description([[
Updated Class Combat Indicator to use default ElvUI indicator when the unit's class is secret
Updated Gradient functions to optimize how they run
Updated Options to add Previews to several textures
Updated how Alphas and Dev versions are released
Updated Aurabar to readd Gradient in Retail
Updated how ElvUI version checking is done
Updated Glows to optimize how they run
Updated Aurabar to skin it again
Updated Aurabar shadows
]], 5, "small", nil, nil, nil, nil, "full")

	--fixed
	ElvUI_EltreumUI.Options.args.changelog.args.fixed = E.Libs.ACH:Group(E:TextGradient("Fixed", 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 4)
	ElvUI_EltreumUI.Options.args.changelog.args.fixed.inline = true
	ElvUI_EltreumUI.Options.args.changelog.args.fixed.args.description = E.Libs.ACH:Description([[
Fixed group borders having forced class colors when class colored borders were disabled
Fixed a missing texture on unitframes when the health was transparent
Fixed default Nameplate Power Bar size in Retail
Fixed BugSack skin after it was updated
Fixed Borders due to container changes
]], 7, "small", nil, nil, nil, nil, "full")
end
