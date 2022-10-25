### 3.5.1 [Complete Changelog](https://github.com/eltreum0/eltruism/blob/main/Changelog.md)
___
Added various fixes for Dragonflight Prepatch\
Added shadows to Archeology Digsite Frame\
Added gradient to Archeology Digsite Frame\
Added option to resize the Archeology Digsite Frame\
Added various shadows for 10.0\
Added Objective Tracker Mover since ElvUI's was removed, Objective Height needs to be manually set in Blizzard's Edit Mode\
Added various models to the Target Portrait Fix\
Added toggles for BigWigs, Chat and Minimap shadows\
Added options to change the scale of the Talents and Profession frames in Retail\
Added Dispel Illusion sound ("Something is not quite right" from Suramar)\
Added a new Texture option for Light Mode, "NONE", which will disable Light Mode Textures\
Updated some files to better load functions\
Updated [eltruism:leader] tag to also show main tank and assist icons\
Updated map shadows in Wrath/Classic to check for Leatrix Maps due to it changing the skin\
Updated Target of Target mover in some resolutions to not overlap when borders are enabled\
Updated tooltip shadows to remove Enhanced shadows since they could break the tooltip shadows\
Updated Action Paging to the new paging in 10.0\
Updated Gradient Power to be enabled separately from Gradient Health\
Updated Waypoint Time to Arrive to calculate based on distance changed since Dragonriding does not give player speed\
Fixed Rare nameplate Style filter not updating when changing classes\
Fixed Role Icons in chat sometimes not applying\
\
For Retail:\
There are various outstanding bugs in Blizzard's UI, such as SetStatusBarTexture causing Statusbar values to be incorrectly set for a frame, Models not inheriting alpha and various others that can be found here <https://github.com/Stanzilla/WoWUIBugs/issues>\
If you are using Light Mode and not Gradient, i recommend checking the new "NONE" texture option to prevent the blinking\
If you are using Light Mode and Gradient, i recommend enabling ElvUI Unitframe Textures instead of Gradient Textures\
Custom Textures in Light Mode will cause issues due to Blizzard bugs\
Aurabar Blinking is due to the SetStatusBarTexture issue mentioned, and can happen even without Eltruism enabled\
Nameplates Blinking is also due to the SetStatusBarTexture issue and happens if there is Texture replacing the existing Texture, this can happen to other nameplate addons like Plater and not just ElvUI Nameplates\
Objective Frame lost its mover in ElvUI but Eltruism has added it back, in order to get it to work you need to enter Edit Mode and move the Quest a bit, you can also change the Max Height there (used to be 550 in Eltruism), then reload. You will now be able to use the mover from ElvUI
