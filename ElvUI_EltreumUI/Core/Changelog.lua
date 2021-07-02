local _G = _G
local unpack = _G.unpack
local select = _G.select
local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

function ElvUI_EltreumUI:Changelog()
	return[[
|cff82B4ffv2.4.0|r
Added Cooldown to Cursor
When you try to use your cooldowns again their icon will show up inside Cursor, alongside a timer
The icon will show again when the skill becomes usable
Removed most of the changelog due to it getting too big, its still available in the Changelog.md file included with the addon

|cff82B4ffv2.3.9|r
Fixed Transmog Window
Exorsus Raid Tools was renamed to Method Raid Tools and the references were updated for it
BigWigs profile is now working according to Funkeh's suggestions
Fixed .toc interface version

|cff82B4ffv2.3.8|r
9.1 Compatibility
Wide Transmog updated to support transmogrifying each shoulder separately
Level Up and Event Toast updated to new system
New Misc option that includes some options that didnt fit into other places
Quests can now be hidden in Arenas and Battlegrounds
The following can be found under misc, and are defaulted to off:
Added Arena Buffs, show target and enemy player buffs in arena but hide them elsewhere.
Added option to hide arena unitframes in arena (in case you are using an addon like Gladius/Gladdy/sArena/GladiusEX)
Added option to hide raid frames in battlegrounds (in case you are using an addon like Battleground Enemies)
Rogue Order Hall Auto Open has been moved to Misc
]] end
