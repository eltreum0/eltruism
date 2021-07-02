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



function ElvUI_EltreumUI:KnownIssues()
	if ElvUI_EltreumUI.Retail then
		return[[
|cff82B4ffKnown Blizzard Issues|r

Map:
There is a known issue with the map causing framerate drops that was hotfixed but later broken by another hotfix

Character:
Sapphire Skyblazer Missing From Mount Journal After Purchase

Quests:
Campaign Skip not Available from Bolvar
"Rebuild Our Trust" Not Available After Reset
Can't Complete Quest - A Unified Effort
Can't Turn in Quest - The Vessels of Jewels

Items:
Legendary Crafting Item Ranks Reset
Wrong Item Level on Mythic+ Reward from Great Vault
Didn't Get Tower Knowledge from Torghast
Items with a Use Ability May Not Function

]]	end
	if ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
		return[[
|cff82B4ffKnown Blizzard Issues|r

The join Battleground button can become tainted and unable to be clicked

Master Looter settings can cause mouse clicks to stop working on unitframes

Healing Prediction and Power prediction are currently not working correctly in Burning Crusade Classic

There is a bug causing Cross-realm invites to occur

There are graphical differences between Burning Crusade Classic and the original Burning Crusade

Leaving an Arena match can cause a disconnection

Players can randomly be kicked from battlegrounds by the system

Battlegrounds can cause players to become saved to instances

Zone text can be colored wrong on player versus player realms

Eyes of the Beast can cause players to disconnect if recast on a pet while the pet is moving or jumping

]]	end
end
