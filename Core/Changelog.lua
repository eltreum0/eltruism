local _G = _G
local unpack = _G.unpack
local select = _G.select
local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

function ElvUI_EltreumUI:Changelog()
	return[[
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

    v1.9.3
    -------
Added /way and /waypoint command, usage:
    /way XX YY or /waypoint XX YY
    /way XXX YYY or /waypoint XXX YYY
    /way XX.XX YY.YY or /waypoint XX.XX YY.YY
    /way XX,XX YY,XX or /waypoint XX,XX YY,YY
It will only work in places where waypoints work
Any other types of inputs may result in an error
Added option to enable/disable the /way and /waypoint commands
Added checks for installed addons
Added Font Outline options to Media
Fixed missing Sepsis paging for Night Fae Rogues (thanks to Naifu)

    v1.9.2
    -------
Fixed a CVar bug due to triggering in combat
Fixed full inventory in LootText

    v1.9.1
    -------
Removed test print

    v1.9
    -------
Added LootText, a fork of SLoTE. (This module of Eltruism is GNU GPLv3)
You can test LootText by typing '/eltruism loot'
Added a version check which will automatically update settings if the user is out of date
Changed Class Texture on Nameplates, Mage and Shaman use a different texture to avoid the green color
Included a nameplate filter for rares that is active with Class Textures on Nameplates
Changed the Friendly Nameplate option, now it will show friendly names inside instances also, with the previous setting being a separate option
Fixed a missing friendly nameplate setting that was not exported
Changed a few CVar values for nameplates
Moved dependencies, added checks on the installer for missing addons
Turned minimap bar into mouse over
Fixed pet on healer profile
Added a few commands:
/eltruism config - open Eltruism plugin settings
/eltruism options - open Eltruism plugin settings
/eltruism install - prompt the installer
/eltruism setup - prompt the installer
/eltruism loot - Display a test message for LootText

    v1.8.1
    -------
Added Changelog to options
Tweaked Quests during encounters
Fixed AFK music muting music on login

    v1.8
    -------
Version check for Shadow & Light
Added media (class textures)
Split Functions into Modules
Fixed a duplicate Font when importing other fonts
Class Gradient on Target Nameplate (default off!)
AFK Class Music
Quest Collapse during boss encounters to prevent overlap with boss frame
Roboto Font added as option during install

    v1.7
    -------
New option to change font during the install, choose between Kimberley, Exo2 and GothamNarrow
New media added
Tweaks to AFK sound, should no longer play duplicate sounds
Fixed DBM Y-Offset that was broken due to a change in DBM

    v1.6
    -------
Wide Nameplate Buffs and Debuffs
Nameplate Buffs and Debuffs stack count moved to lower right when using wide nameplate
New death sounds
Nameplate tweaks to make them stick inside the screen while targeted
Tweaks to font outlines
Minor tweaks to profiles

    v1.5.2
    -------
Fixed action paging for some classes

    v1.5.1
    -------
Fixed global fade on healer profile
Updated the waypoint options

    v1.5.0
    -------
Revamped Waypoint Time to arrive, decreasing memory usage by a lot!
Added Role Icons
Layout Changes
Added Weakaura recommendations that were made for this addon

    v1.4.5
    -------
Changed Action bar visibility options
Now you can have actionbars on all the time by disabling Inherit Global Fade on each bar

    v1.4.4
    -------
New death sound (Wilson Wow)
New media available
Tweaked Enemy Player Nameplates
Tweaked install process
Fixed missing chat height

    v1.4.3
    -------
Fix global soundHandle
Tweaked Nameplate classpower background color

    v1.4.2
    -------
Fixed classpower position

    v1.4.1
    -------
Time to Arrive includes the memory usage of the SuperTrackedFrame and should reset automatically just like Blizzard's code, but for now it will reflect Blizzard's memory usage
Added Time to Arrive text below Waypoints
Tweaked a few profile settings
Fixed SuperTrackedFrame inside instances

    v1.4.0
    -------
Added time to arrive text below waypoints
This setting includes the memory usage of the SuperTrackedFrame, and should reset automatically just like Blizzard's code
Tweaked a few profile settings

    v1.3.2
    -------
Fixed CVar taint from friendly nameplates near WQ areas
Fixed missing music for some races

    v1.3.2
    -------
AFK music is now working correctly

    v1.3.0
    -------
Added options to nameplates
Friendly Nameplates will now show outside instances, and hide while inside instances
Test version for Racial AFK Music added

    v1.2.0
    -------
Added a function to play a sound when someone dies

    v1.1.0
    -------
Healer profile was changed
Additional Media

    v1.0.0
    -------
Initial version
Added Layout for DPS and Healer
Added Options Menu
Added Media
Added Class Glow to Action Bars
]] end
