### 3.5.2 [Complete Changelog](https://github.com/eltreum0/eltruism/blob/main/Changelog.md)
___
Added Borders to Unitframe Auras (buffs/debuffs)\
Updated Nameplate Style Filters to reduce texture usage and use gradient colors instead\
Updated Details Spec icons due to Details changes\
Updated GladiusEx profile\
Updated Battleground Enemies profile\
Updated DynamicCam profile\
Fixed Classic/Wrath using Retail gradient functions\
Fixed a possible error when choosing custom colors for Quest Line in Retail\
Fixed Minimap border and shadow due to ElvUI changes\
Fixed a possible error when checking Bank due to ElvUI changes\
\
For Retail:\
There are various outstanding bugs in Blizzard's UI, such as SetStatusBarTexture causing Statusbar values to be incorrectly set for a frame, Models not inheriting alpha and various others that can be found here <https://github.com/Stanzilla/WoWUIBugs/issues>\
If you are using Light Mode and not Gradient, i recommend checking the new "NONE" texture option to prevent the blinking\
If you are using Light Mode and Gradient, i recommend enabling ElvUI Unitframe Textures instead of Gradient Textures\
Custom Textures in Light Mode will cause issues due to Blizzard bugs\
Aurabar Blinking is due to the SetStatusBarTexture issue mentioned, and can happen even without Eltruism enabled\
Nameplates Blinking is also due to the SetStatusBarTexture issue and happens if there is Texture replacing the existing Texture, this can happen to other nameplate addons like Plater and not just ElvUI Nameplates\
Objective Frame lost its mover in ElvUI but Eltruism has added it back, in order to get it to work you need to enter Edit Mode and move the Quest a bit, you can also change the Max Height there (used to be 550 in Eltruism), then reload. You will now be able to use the mover from ElvUI
