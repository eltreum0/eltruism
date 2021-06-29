local _G = _G
local unpack = _G.unpack
local select = _G.select
local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

function ElvUI_EltreumUI:Changelogv220()
	return[[
    v2.3.8
    -------
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

    v2.3.7
    -------
Improved event detection for Nameplate Power Bar (Thanks Repooc!)
Hunter and Demon Hunter power bars will now follow Unitframe Power Colors like other classes
Left Chat hide will now behave the same as Right Chat hide
Moved the Focus Castbar into an easier to see position
Changed Experience and Reputation databars to on the top of the screen, disabled honor and azerite databars

    v2.3.6
    -------
Added Borders (Beta), disabled by default
You will need to adjust the borders if using them with profile or setting outside of the defaults for Eltruism DPS/Tank
Added Border media, credits in the License folder
Fixed AFK music error for Undead players since the race code is Scourge
Changed code for Nameplate Power Bar
Nameplate Power Bar colors will now follow Unitframe Power Colors so they can be changed by the user over there
Changed BigWigs and Details import logic (thanks Luckyone!)

    v2.3.5
    -------
Tweak chat hide so that it will hide without a mouse click
Prepared for 9.1
Changed classpower on nameplates that was defaulting to class color when it was meant not to
LootText will now have trimmed icons without the grey border

    v2.3.4
    -------
Added Localization Support (only English is live at the moment)
Added World Text Scale option
Fixed overlapping debuffs on nameplates due to Nameplate Power Bar
Moved the Focus to the top left side since on the right side there are boss frames and Arena frames and it should not overlap the Alternate Unitframes

    v2.3.3
    -------
Improved module loading between TBC/Classic/Retail
Fixed missing Demon Hunter Power Bar due to the position being behind the nameplate
Added Gladius and Gladdy profiles for TBC

    v2.3.2
    -------
Added more options to Nameplate Power Bar, such as changing its size, position and texture
Fixed Nameplate Power Bar not appearing for retail Shamans until they swapped specs
Bundled ElvUI Chat and CVArs setup with Eltruism Install
ElvUI Install prompt will now be skipped since Eltruism sets the same things or overwrites things
Swapped Chat functions: Now it starts disabled and after a left click it can fade

    v2.3.1
    -------
Chat Fade/Hide can now be toggled off by Left clicking on either chat, clicking again will enable the Fade/hide again
Quests will now expand when the boss encounter ends
Reworked Classic/TBC Druid logic for Nameplate Power Bar
Changed BigWigs profile name to Default so that it doesn't get reset with a reload
Fixed missing Enemy Player Buffs/Debuffs on Aura Filters
Added Expanded Stables to Shadowlands Hunters, merged from Improved Stable Frame by Cybeloras and licensed under GNU GPLv3
Rogue Order Hall will automatically open following Rogue Door Opener by Burzolog licensed under GNU GPLv3

    v2.3.0
    -------
Added Chat Modifications, check Eltruism > Chat for the options
Added Expanded Transmog Window to Shadowlands
Spellsteal filter will now check for player class
Waypoint Timer will now follow ElvUI general font
Optimized Nameplate Power Bar
Fixed Nameplate Power Bar showing on neutral or unattackable NPCs
Fixed LootText not showing Gold earned when in other locales
Fixed Stealth not working when entering world or the first time stealth was used

    v2.2.9
    -------
Fixed Classic/TBC feral druid power bar overlapping combo points
Added ElvUI movers that can be used as Weakauras anchors: EltruismWA and ELtruismConsumables
Simply open your weakaura group and in Display > Anchored To > Select Frame > Type either EltruismWA or EltruismConsumables
The Weakauras will anchor to the mover and now you can use /moveui to move them.

    v2.2.8
    -------
Added aura filter options to show more buffs/debuffs
Added more options to Cursor
Added more options to Action Bars Glow
Reworked Shadow and Light and Windtools dependencies: Eltruism still requires them for Shadowlands, but not on Curse due to TBC/Classic issues

    v2.2.7
    -------
Added option for LootText to use ElvUI General Font (Found in ElvUI > General > Media)
Changed LootText icon scaling to be more inline with the font
Removed Weakauras page from install since most of them are now options in the plugin

    v2.2.6
    -------
Added Nameplate Power Bars - Based on the Weakaura
Added expanded talents to Classic
Added AFK music to TBC and Classic
Added Class Icons to Character Panel
Added tags to show Class Icons on unitframes/nameplates
Added Role Icons to Role Swap message
Modified Dynamic Datatext to Show Icon for Ammo/Soul Shards
Fixed an error due to scroll wheel being killed on talent window
Tweaked the Healing Profile Tank and Assist Frames

    v2.2.5
    -------
Fixed TBC Expanded Talents --Thanks Gregory!
Reworked Version Checks to have less errors

    v2.2.4
    -------
Added option to change the position of LootText
Fixes for TBC Expanded Talents

    v2.2.3
    -------
Added Expanded Talents for TBC
Added options in Media for the Expanded Talents, Level Up skin and Boss Loot Frames depending on game version
Added threat to Enemy NPC nameplates
Fixed errors when user first installing Eltruism
Fixed missing possession bar on Death Knights
Fixed the Healer Layout Tank and Assist Frames

    v2.2.2
    -------
Fixed error when ElvUI nameplates were turned off

    v2.2.1
    -------
Added option to change the strata of LootText
Fixed an error due to a missing table for Rare Style Filter

    v2.2.0
    -------
Added scale option to LootText
Optimization/Cleaning Pass
Added dynamic datatexts that change according to player class, showing Ammo/Soul Shards for Hunters and warlocks, and Friends for other classes
Fixed heal prediction being gray for some classes in TBC/Classic due to a low alpha value
Dynamic Level tags on enemy nameplates that will show only when the player is below max level
Due to how aura filters work in ElvUI it's recommended to go to |cffff0000ElvUI > Unitframes > Group Units > Party/Raid/Raid40 > Aura Indicator > Set them to Textured Icon with Display Timer|r
]] end
