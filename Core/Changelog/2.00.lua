local _G = _G
local unpack = _G.unpack
local select = _G.select
local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

function ElvUI_EltreumUI:Changelogv2()
	return[[
    v2.2.4
    -------
Added option to change the position of LootText
TBC Expanded Talents fixes

    v2.2.3
    -------
Added Expanded Talents for TBC
Added options in Media for the Expanded Talents, Level Up skin and Boss Loot Frames depending on game version
Added threat to Enemy NPC nameplates
Fixed errors when user first installing Eltruism
Fixed missing possesion bar on Death Knights
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

    v2.1.9
    -------
Fixed repeating install process prompt due to a database change

    v2.1.8
    -------
Revamped Changelog in order to fit more versions
Layout now has additional checks for resolution
Added class check to change left chat datatext panel to count Ammo/Soul Shards if playing Hunter or Warlock in Classic/TBC
Do note that the datatext will not dynamically swap if you change characters
Further streamlined the install process code

    v2.1.7
    -------
Added new Cursors, changed their file path
Revamped Cursor options
Changed some internal code
Improved Party/Raid death according to Simpy's suggestion

    v2.1.6
    -------
Fixed Cursor error related to instances

    v2.1.5
    -------
Added an option to change the size of the cursor
Added images showing the rings for the cursor
Fixed abbreviation when using cyrillic letters

    v2.1.4
    -------
Added Cursor, a fork of CastCursor by michaelsp (this module is GNU GPLv3)
Changed how version checking works
Added alternative layouts for party/raid/raid40 for the DPS/Tank profiles
Tweaked install process to offer alternative layouts for certain classes
The original layouts for those frames were made with pure dps classes in mind,
if your class has off heals or raid cooldowns you might want to use the alternative layout
Check it in Eltruism > Party/Raid

    v2.1.3
    -------
Updated settings to ElvUI's newest version
Changed TBC/Classic profiles to show mana/energy regen

    v2.1.2
    -------
Added option to reset nameplates to Eltruism defaults
Tweaked nameplate class borders, colors and textures when option is off

    v2.1.1
    -------
Fixed friendly nameplates being forced on during login

    v2.1.0
    -------
Converted database to profile from private
Renamed Nameplate Stylefilters to avoid confusion, please remove the |cffff0000EnemyCasting, ExecuteRange, StealThisBuff and HideThis nameplate filters|r
Fixed Details! TBC profile due to Details! changes
Fixed Pet Unitframe happiness missing when using Custom Fonts
Reworked absorb logic for Retail profiles (disabled for DPS, enabled for Healer)

    v2.0.9
    -------
Streamlined install process
Updated ProjectAzilroka profile
Added missing Party Castbar to Retail Healer profile and TBC profiles
Added new death sound (Ion's - Frankly that's a skill issue)
Added custom fonts option (Eltruism > Media)
Fixed a rare issue with Shadow and Light viewport on profile install

    v2.0.8
    -------
Added power bar to pets
Update function has been changed
Added level to enemy nameplates in Classic/TBC
Fixed .toc versions

    v2.0.7
    -------
Condensed the install screen to be faster
Fixed ProjectAzilroka install due to its internal change
Revamped Threat bar in Classic/TBC to be in the Left Chat Datatext

    v2.0.6
    -------
Tweaked init function for quests

    v2.0.5
    -------
Removed Quest options in Classic/TBC due to those versions not supporting the function

    v2.0.4
    -------
Fixed a bug with LootText when awarded honor in Classic and Burning Crusade Classic
More pet unitframe changes to accommodate name length and happiness tracking
Changed the DBM HUD size in Questie profile
Warning: DBM HUD will cause bugs in bgs due to not being supported in instances

    v2.0.3
    -------
Improved Font Outline detection
Friendly Nameplate disable option added
Pet bar change to accommodate name length and happiness
Other minor changes to profile
Questie profile for Classic and Burning Crusade Classic
You will need to reload after questie builds the database and reload again after setting the profile
Classic Questie has some issues at the moment and you might need several reloads due to a known bug with townsfolk

    v2.0.2
    -------
Added Dark Mode and Light Mode
Can be found in Eltruism > Media
Fixed Bigwigs profile for TBC due to new version

    v2.0.1
    -------
Fixed absorb tags in Classic/TBC
Fixed nameplate clamping to screen in TBC
Fixed LootText test command in TBC
Fixed datatext height

    v2.0.0
    -------
Added combat music! Type the path to your file in the settings
Classic/TBC Support! Report any bugs in the Discord
Many addons weren't updated for TBC yet, so profiles might not work
Added class colored level up and boss loot by Aftermathh
Style Filter StealThisBuff fixed to be mage only
Enabled Class Totems
Changed the size and position of the Gladius Ex profile
Recommended settings for font outline:
    - 4K resolution: Use profile default
    - 1440p resolution: Eltruism > Media > Outline
    - 1080p resolution: Eltruism > Media > Outline
Implemented automatic switching of font outlines
]] end
