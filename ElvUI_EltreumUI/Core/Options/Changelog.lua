local E = unpack(ElvUI)
local L = E.Libs.ACL:GetLocale('ElvUI', E.global.general.locale)

-- Eltruism Changelog
function ElvUI_EltreumUI:Changelog()

	--changelog
	ElvUI_EltreumUI.Options.args.changelog = E.Libs.ACH:Group(E:TextGradient(L["Changelog"], 0.50, 0.70, 1, 0.67, 0.95, 1), L["Check what has changed in the current version of Eltruism"], 88, 'tab')
	ElvUI_EltreumUI.Options.args.changelog.icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\changelog'
	ElvUI_EltreumUI.Options.args.changelog.args.changelog = E.Libs.ACH:Input(L["Changelog"], "", 1, false, "full", function() return 'https://github.com/eltreum0/eltruism/blob/main/Changelog.md' end)
	ElvUI_EltreumUI.Options.args.changelog.args.description1 = E.Libs.ACH:Description(E.NewSign..E:TextGradient("v"..ElvUI_EltreumUI.Version, 0.50, 0.70, 1, 0.67, 0.95, 1), 2, "large", nil, nil, nil, nil, "full")
	ElvUI_EltreumUI.Options.args.changelog.args.added = E.Libs.ACH:Group(E:TextGradient("Added", 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 3)
	ElvUI_EltreumUI.Options.args.changelog.args.added.inline = true
	ElvUI_EltreumUI.Options.args.changelog.args.added.args.description = E.Libs.ACH:Description([[
Added EltreumWorldCombatFriendly nameplate stylefilter, which will hide friendly units while in combat in the open world
Added the command /eltruism performancecvars, which will change several graphical settings to improve performance
Added the command /eltruism universalborders, which is an update to add borders to all ElvUI frames
Added 2 new borders that are new versions that use the same default border dimensions
Added the command /eltruism universalshadows, which adds shadows to all ElvUI Frames
Added several fonts to the Font Outline and Custom Font functions
Added borders to nameplate castbars
Added a skin for SimpleAddonManager
]], 3, "small", nil, nil, nil, nil, "full")
	ElvUI_EltreumUI.Options.args.changelog.args.updated = E.Libs.ACH:Group(E:TextGradient("Updated", 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 3)
	ElvUI_EltreumUI.Options.args.changelog.args.updated.inline = true
	ElvUI_EltreumUI.Options.args.changelog.args.updated.args.description = E.Libs.ACH:Description([[
Updated how some events are handled to improve how Delve bosses are detected for Quests and Combat Music
Updated Nameplate Health and Castbar Border colors to use unit colors and interrupt status
Updated Ace3 skin to use some ElvUI values and run without needing Eltruism's ElvUI Skin
Updated text on Item Wishlist to use a global string instead of pure English
Updated profile to disable nameplate fade-in animation in ElvUI nameplates
Updated Ace3 skin to make ElvUI Tabs transparent like they used to be
Updated ElvUI profiles to use the new Bank settings
Updated NPC ID list to filter more bosses
Updated Details table cleanup function
Updated ElvUI nameplate Style Filters
Updated Quest hiding while in combat
Updated German locale by Dlarge
Updated ElvUI profiles movers
Updated DeadlyBossMods skin
Updated DynamicCam profile
Updated WindTools profile
Updated RareScanner skin
Updated Auctionator Skin
Updated BigWigs profile
Updated Hekili skin
Updated SimC skin
]], 5, "small", nil, nil, nil, nil, "full")
	ElvUI_EltreumUI.Options.args.changelog.args.fixed = E.Libs.ACH:Group(E:TextGradient("Fixed", 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 4)
	ElvUI_EltreumUI.Options.args.changelog.args.fixed.inline = true
	ElvUI_EltreumUI.Options.args.changelog.args.fixed.args.description = E.Libs.ACH:Description([[
Fixed an issue with the EltreumWorldCombatFriendly Nameplate Style Filter where some nameplates could disappear inside instances
Fixed an issue where Item Deletion stopped working in Mists of Pandaria due to a Blizzard change
Fixed an issue where ElvUI Skin was missing on some buttons such as Actionbars and Bags
Fixed an issue with a missing Atlas for the Pool of Mixed Monstrosities
Fixed some coloring and text on the Objective Tracker Skin for Retail
Fixed an issue with the Objective Max Height in Retail
Fixed an issue while using ElvUI AFK and Eltruism AFK
Fixed an issue with the Objective Mover in Retail
Fixed a compatibility issue with Reforged Armory
Fixed an issue with the Cursor
]], 7, "small", nil, nil, nil, nil, "full")
end
