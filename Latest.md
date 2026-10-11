### 5.1.6 [Complete Changelog](https://github.com/eltreum0/eltruism/blob/main/Changelog.md)
___
Added support for World of Warcraft Forever  
Added an ElvUI mover for LootText  
Added option previews for Dark/Light modes, textures, AFK music, and Death animations  
Added a command (/eltruism transparent) to toggle unitframe transparent health  
Added cooking profession ID for Titan Reforged (thanks Dongchen Xu)  
Added Fishing to the Bag Profession Buttons  
Added Nameplate Custom Height back using different functions  
Added support for Skyborne Elves in several functions  
Added a Waypoint Name option to Map Waypoints  
Added several more shadows  
Updated Shadows to better work with aura containers and adjusted strata to prevent clipping  
Updated Class Combat Indicator to use default ElvUI indicator when unit class is secret  
Updated hooks across modules to better support ElvUI_CPU and avoid duplicate hooks  
Updated Aurabars to re-add gradients, thin mode, update settings, and fix shadows  
Updated Max Camera Distance Zoom to allow up to 4 in World of Warcraft Forever  
Updated CVars to show loot sparkle effects when object outline is disabled  
Updated options layout and moved combat settings into a dedicated section  
Updated Gradient functions to cache values and improve performance  
Updated Castbars to better handle interrupts in Retail and Forever  
Updated Aurabars to also apply custom font and outline settings  
Updated [eltruism:classification] to once again work in Retail  
Updated DataTexts to better support Forever and Classic Era  
Updated secret checking functions to use new modern APIs  
Updated Nameplate threat scaling to avoid scaling issues  
Updated Group Power gradient textures and color updates  
Updated Universal Borders to improve Size and Coloring  
Updated Castbars to unify player and target castbars  
Updated the Installation process, optimizing it  
Updated Nameplate borders to use threat colors  
Updated Chat Icons to sync with ElvUI changes  
Updated several tags to improve performance  
Updated Nameplate Power Bar autopositioning  
Updated Aura Filters to work once again  
Updated Glows to optimize execution  
Updated Thin Mode layout  
Updated localizations  
Fixed health tags in modern WoW when values are secret, restoring short values and status icons  
Fixed aura borders due to container changes and ensured they hide immediately when disabled  
Fixed group borders having forced class colors when class-colored borders were disabled  
Fixed several errors caused by secret values in combat, character stats, and DataTexts  
Fixed shadows appearing on Nameplate elements when Nameplate shadows were disabled  
Fixed a possible issue when applying custom font outlines with mMediaTag enabled  
Fixed Blizzard Damage Meter shortening character names in non-Retail versions  
Fixed unitframe textures and backgrounds when using transparent health  
Fixed aura positioning overlapping with castbars in the DPS layout  
Fixed player and group unitframe transparency on login and reload  
Fixed Nameplate Target Model persisting when having no target  
Fixed Minimap border misalignment when auto adjust is enabled  
Fixed 3D models not inheriting alpha and nil alpha errors  
Fixed Nameplate Power Bar clipping and positioning issues  
Fixed Game Menu buttons animation in the Ace3 skin  
Fixed default Nameplate Power Bar size in Retail  
Fixed Damage Meter skin after ElvUI skin changes  
Fixed Blizzard Damage Meter bar shadow clipping  
Fixed missing gradient on Nameplate Castbars  
Fixed debuff backdrop on Aurabars  
Fixed BugSack skin after updates  
Removed profiles for addons that have abandoned Retail (Gladius, GladiusEx, BattleGroundEnemies, OmniCD, AddOnSkins, ProjectAzilroka)  
Removed the DeepL translation warning and the /eltruism translate command  
Note: Due to castbar database changes, a database conversion will run automatically.
