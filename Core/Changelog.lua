local _G = _G
local unpack = _G.unpack
local select = _G.select
local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

function ElvUI_EltreumUI:Changelog()
	return[[
    v2.0.0
    -------
Initial Classic/TBC Support! Report any bugs in the Discord
Added combat music! Type the path to your file in the settings
Added class colored level up and boss loot by Aftermathh
Style Filter StealThisBuff fixed to be mage only
Changed the size of the Gladius Ex profile
Enabled Class Totems

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
