### 🌌 Next Version
The future is uncertain
___
### 2.9.2
Added player castbar gradient\
Added auto-adjusting actionbar spacing and positions based on borders being enabled, this option is disabled by default and can be enabled in Eltruism > Borders\
Updated autoadjust textures, which is now Dark Power Background, making your class power in unitframes and nameplates have a black color instead of a shade of the power\
Updated chat item level by disabling consumables from showing ilvl\
Updated Eltruism Honor/Arena Points Datatext by adding Conquest Points and enabling it in Retail\
Updated shadows, some shadows will now not be created when borders is enabled to prevent overlapping\
Updated Waypoint ETA, which will now try to prevent waypoints from being registed inside instances/pvp where they should not be\
Fixed Healer layout buffs being wrongly attached to debuffs instead of the frame\
Fixed Instance Text not hiding default blizzard icons for difficulty\
Fixed Method Raid Tools textures\
Disabled chat link levels in Windtools profile\
Disabled instance text in Shadow and Light profile
___
### 2.9.1
Added an option to disable raid shadows\
Fixed Instance Text not hiding in some situations\
Fixed Raid Shadows positioning\
Fixed an error with nameplate style filters in retail
___
### 2.9.0
Added gradients to tanks, assists and boss unitframes
Added an option to disable sockets and enchants showing on inspection for TBC/Classic
Added shadows to raid, tank and assist frames
Fixed DBM profile missing fonts
Fixed Instance Text not hiding the Guild Icon
Fixed Boss debuff/buff icon position
Fixed Boss health color due to light/dark/gradient mode
Disabled the announcement in the Windtools profile
___
### 2.8.9
Added another check in an attempt to prevent sockets from erroring when inspecting players inside instances\
Added Honor/Arena Points Datatext for TBC/Classic\
Added gradients to NPCs\
Updated Nameplate Stylefilters\
Updated Dynamic Cam Profile, removing instance events/druid forms which were causing the camera to reset\
Updated border textures\
Fixed an issue that caused action bar borders to not apply\
Fixed Death Knights gradients being wrong color in gradient mode by default\
### 2.8.8
Added Gradient Mode, which will add gradient colors to unitframes. This option uses a separate texture and can be found in Eltruism > Media > Gradient where colors and textures can be customized\
Note that for group units priests cannot have gradients and gradient mode, just like Light Mode, requires Auto Adjusting textures to be enabled in Eltruism > Media\
Added automatically placing the keystone inside the pedestal when using the !keys command\
Added Instance text, allowing the text that appears inside instances to be customized, this text can be moved using /moveui\
Added a loot icon to the wishlist toast that appears when looting an item from the wishlist\
Added a shortcut button in the spellbook for the click casting interface in Retail\
Added enhancement console from Zereth Mortis to the ignore list of automatic quests\
Attempted a fix for a socket and enchants error when inspecting a player inside an instance\
Updated locales\
Updated install process\
Updated Quest Items icons\
Updated automatic quest turn in and accept\
Updated the healer layout for player/target unitframes, changing buffs/debuffs/aurabars and positioning the player power bar in case the player decides to use it while detached from frame\
Updated the automatic positioning of the nameplate power bar\
Fixed some shadows not being created when borders was enabled
___
### 2.8.7
Improved how the background texture is applied\
Profiles will now apply Asphyxia-Norm texture and 0.7 alpha for the background texture, your settings will not be changed unless you reapply the profile\
Added options to change the font and font size of the nameplate power bar text\
Added [eltruism:leader] tag, which will show an icon for party leader or assist\
Added [name:eltruism:abbreviate20] tag, which will abbreviate at 20 characters instead of the normal 16\
Added [eltruism:newline] tag, which will add a line break\
Added Pocopoc to the automatic quest ignore list\
Updated how ilvl is calculated during login in TBC/Classic\
Updated player/target/targettarget border size\
Updated how borders are applied and shadows are applied, since some shadows conflict with borders they will not show up if borders are activated.\
Updated healer layout for TBC/Classic, adding party pets\
Updated quest item bar icon texture
___
### 2.8.6
Added options in Eltruism > Media > Unitframe to change the backdrop texture of unitframes, and to change the backdrop alpha\
Added custom glow to actionbars in TBC/Classic\
Added options to enable/disable the !key and !keys chat commands\
Added more npcs to the automatic quest turn in ignore list\
Added Pepsi-Cyr-Lat font\
Added an option to change the font size of the Error Frame\
Added a mover for the Raid Warning Frame\
Updated german translations by Khornan and spanish translations using deepL\
Updated how friendly nameplates is applied\
Updated waypoint ETA to also show itself when the player has a waypoint when logging in\
Updated how fonts are applied, they should no longer overwrite light/dark mode texts\
Updated Item Levels for TBC/Classic, making it use less memory and be generally faster\
Updated automatic quest turn, improving how gossips and quests are detected\
Updated Details v3 Icons\
Fixed debuff positions in the party unitframe for the DPS Layout
___
### 2.8.5
Fixed custom class textures for unitframes
___
### 2.8.4 
Updated german translation with additional translations by Khornan\
Added options to change class textures when using light mode in Eltruism > Media > Unitframes\
Added !keys and !key commands adapted from Luckyone's M+ keys weakaura\
Fixed some quests not turning in when using automatic turnin\
Fixed loading german translation\
Fixed enchanting material scroll bar not hiding in TBC
Improved the cursor cooldown mask texture
___
### 2.8.3
Added German language translation by Khornan\
Added options to change the Player, Target, Target of Target and Focus unitframe textures, this option can be found in Eltruism > Media > Unitframes and needs light mode or class colors enabled in ElvUI unitframes\
Added a check to prevent fast looting when a BoP that needs confirmation is detected\
Improved the Minimap combat hide, which will now also move auras to where the minimap was, and move them back once the minimap is shown\
Improved the Quest Automatic Turn-in when gossips were involved, also added an ignore list for some npcs that shouldn't be automatically interacted with\
Made the System/Interface window movable
___
### 2.8.2 
Added option to change the font for the Error Frame and Raid Boss Emote Frame\
Added an option to hide the Error Frame\
Added a dark bar to the Dark Souls death animation\
Added a GTA death animation\
Updated the Pet castbar to not be transparent since the text was overlapping with the Pet unitframe\
Updated the Weakauras tutorial image since the previous one was for single Weakauras, which was causing misunderstandings\
Improved the addon profile importing for some addons\
Improved the install logic detection of Gladdy and Gladius for TBC\
Fixed an error with Database Converter due to a change in game version checking
___
### 2.8.1
Added test Spanish translation using DeepL automatic translation.\
Added a popup if ElvUI is out date, since Eltruism is a plugin for ElvUI if its out of date a lot of problems can happen\
Added [eltruism:levelskull] tag which displays the unit's level or a skull if the level difference is too high\
Fixed Enchanting/TradeSkill window increasing the number of crafts when it shouldn't\
Fixed the Enchant button when TSM was loaded\
Fixed error with instant loot if the inventor was full\
Fixed Death animation playing when in a party/raid in TBC/Classic\
Fixed Nameplate Debuff Glow showing up on debuffs that had no duration\
Fixed waypoint time to arrive not attaching to some quests\
Improved quest detection for wowhead button in Retail\
Updated Auras in Eltruism > Aura Filters\
Updated locale files since many changes happened since they were originally made
___
### 2.8.0
Added Wowhead button for quests\
Added Dark Souls death animation for player death, default disabled and can enabled in Eltruism > Misc\
Improved the Delete Item with the item texture and item link in the message to make it clearer which item is being deleted\
Fixed an error in loot options when the wishlist was empty
___
### 2.7.9
Added an option to display the item level of the item being linked in chat\
Added an option to display the Class Crest in the Character Panel (Eltruism > Skins> Character)\
Added an option to also accept weekly and daily quests automatically for retail\
Added an option to filter loot items by quality\
Added an option to put loot items into a wish list, which can also display a toast once the item is looted, alongside another option to restrict items to be looted only from the wishlist\
Added a few items that are not considered quest items to the quest item bar\
Skinned the professions window to be wider, this skin can be enabled in Eltruism > Skins\
Fixed Aura Filters and Alternative Layout not applying due to the profile name change
___
### 2.7.8
Reworked many functions and how they are registered, resulting in improved performance and memory usage, especially in combat\
Set smoothbars to off and friendly nameplates inside instances to off since it's been discovered that they impact performance. It is recommended to do the same, by going into ElvUI > Unitframes/Nameplates and unchecking Smooth Bars, then ElvUI > Eltruism > Nameplates > Hide Friendly Nameplates inside instances\
Fixed an annoying World Quest Title being displayed when it shouldn't\
Fixed Class Icon on Character Panel not showing up in the reputation and currency tabs for Retail
___
### 2.7.7
Added a mover for the Error Frame, along with making it use the ElvUI General Font and Font Size\
Added Capping profile, which can be found in Eltruism > Addons\
Added Method Raid Tools profile for TBC/Classic\
Fixed missing Threat bar for TBC/Classic\
Fixed ElvUI Floating Combat Text not showing up on other targets\
Improved how addon profiles are applied, detecting if the profile already exists and if so just setting your character to use it\
Improved the Socket and Enchants loading function\
Improved how Item Levels detects tabards and shirts\
Improved how Zone text is applied
___
### 2.7.6
Added Light mode to Party/Raid/Raid40 Unitframes\
Added [eltruism:effectivehp] tag which will show effective hp for tanks based on the target's level for TBC/Classic\
Added glows to Shaman Totems in TBC/Classic (Eltruism > Custom Glow)\
Updated Priest Statusbar Texture\
Fixed Automatic Experience Databar not working sometimes\
Fixed Classic/TBC Shaman power not having shadows and not being colored. This option is liked to Auto Texture in Eltruism > Media\
Fixed the Quest Log scrollbar overlapping the quest titles
___
### 2.7.5
Added a button in Eltruism > Installer that will reset Eltruism settings\
Improved the Quests skins for Classic by adding a bigger Quest Log to it\
Updated Instant Loot to be compatible with TSM Destroy\
Updated how shadows are applied\
Updated the profile install process with the profile naming using your character name and realm name to prevent possible overwrites from happening
___
### 2.7.4
Added a button in Eltruism > Nameplates that restores all unit names should you disable the automatic name toggling.
Fixed a few options that were overlapping in the Eltruism menu\
Fixed World Quest banner colors for some classes
___
### 2.7.3
Added Sockets and Enchants to the Character Panel for TBC and Classic (Classic only has Enchants), this option can be enabled in Eltruism > Skins > Character. This module is a fork of Kibs Item Level by Kibsgaard, which is licensed under Public Domain\
Skinned the World Quest Banner and the quests statusbars\
Fixed Druid Smart classbar not working\
Fixed some World Quests not showing emotes due to the Raid Boss Emote Frame\
Eltruism Database has been revamped, with almost all settings being disabled now.\
A Database converter will be run the first time you load into the game, copying your settings over to the profile. The original settings now will be set on the layout install and players that skip the install can choose what to enable at will. Make sure to reload after running the database converter to save your settings
___
### 2.7.2
Improved Media loading\
Made Quest Item Bar disabled by default, if you still want to use it simply enable it in Eltruism > Quests\
Updated the Party/Raid sound selection, now any sound can be selected\
Updated many functions, decreasing their cpu/memory use\
Added an option to disable the Party/Raid death sound during battlegrounds and arenas\
Added an option to automatically type DELETE on certain popups\
Fixed Waypoint Time to Arrive not updating when selecting World Quests\
Fixed Light Mode texture not updating on druid shapeshift and when loading in\
Fixed an action paging issue for Druids when doing some world quests
___
### 2.7.1
Improved the Retail Character Panel skin, making it more compatible with Shadow & Light\
Added some checks to prevent possible taints related to Quest Items while being in combat\
Fixed a possible scenario where things on the Character Panel could get multiplied\
Fixed a rare error with cursor cooldown\
Fixed Player and Target Castbar shadows not being correctly placed when the castbar was set to be inside the power bar
___
### 2.7.0
Fixed Quest Items showing up inside instances when it shouldn't\
Fixed Blizzard Combat Text getting disabled/enabled when it shouldn't\
Added some missing shadows\
Skinned the Scenario Block, used in places like Dungeons/Raids/M+
___
### 2.6.9
Added a grey background mode for ElvUI, simply type /eltruism background to switch between grey and black backgrounds, or go to Eltruism > Media and choose which mode to use\
Added Quest Items, which will display quest items in a bar. Default keybind for the first is ], but it can be changed in the default Blizzard UI (Keybinds > ElvUI Eltruism). Quest Items is a fork of QBar by Aezay\
Fixed an error when attempting to automatically turn in quests in TBC/Classic\
Fixed missing smart classbar for Brewmaster Monks
___
### 2.6.8
Added an option to disable the automatic pinning of waypoints in Retail\
Added an option to automatically accept and turn in quests\
Improved the Party/Raid Death function\
Improved the Cursor Cooldown function\
Updated the Light Mode texture switch when your target changes target (target of target)\
Updated the Install process\
Updated the Retail Quest Skin, which under some scenarios could end up using more memory than needed\
Fixed a bug where the position of Buffs/Debuffs on nameplates couldn't be adjusted\
Fixed the Quest Skin on Retail causing unnecessary memory usage\
Fixed Combat Music playing instead of Boss Music inside instances
___
### 2.6.7
Update for ElvUI 12.62/2.34/1.60\
Improved the install process by revamping the pages\
Improved the Hybrid spec detection for TBC/Classic\
Improved the Dark/Light mode switch and the Dark/Transparent chat mode switch\
Fixed the Character Panel art sometimes having wrong alpha\
Fixed the Target of Target statusbar not updating sometimes in Light mode
___
### 2.6.6
Added an option for Nameplate Texture to be based on the Target's Class/Reaction\
Added borders to Target of Target unitframe\
Updated Details install with a new profile, this profile is equal to v2 but the icons are not as transparent. All three profiles are still available\
Fixed a dev print that wasn't supposed to be on release
___
### 2.6.5
Added various shadows, such as Nameplate Healthbars, which can be enabled in the Eltruism > Skins settings\
Fixed shaman Power Prediction in Retail\
Updated the Eltruism Options, with some settings now showing up in tabs instead\
Updated the detection of targets for Light mode, adding more reactions\
Updated the Combat Music function, now simply type the name of the sound file inside Interface\Addons, and Combat Music can now play during Boss Fights in TBC/Retail\
Updated specialization in the character panel for TBC/Classic, which now displays hybrids\
Updated the chat install process\
Updated the code behind the layout install process\
Updated the automatic stats for TBC/Classic with Shaman now also getting spell stats
___
### 2.6.4
Added an option to toggle the automatic stats in the Character Panel for TBC/Classic\
Added an option to load the extra media\
Updated Dynamic Cam profile for Retail\
Updated DBM profile\
Updated various addon profile import functions\
Updated Light mode name colors\
Fixed the Player Title Dropdown in TBC/Classic\
Fixed Healer Layout Buffs and Debuffs\
Fixed Cursor being stuck in some situations\
Fixed Aura shadows not updating
___
### 2.6.3
Added Power Prediction to Nameplate Power Bar\
Added an option to show Cursor outside of combat\
Added an option to hide the Minimap while in combat\
Added options to customize the player castbar spark\
Added borders to Nameplate Power Bar\
Added an option to change the background of the Nameplate Power Bar\
Added a Smart Classbar option for Nameplates\
Added a Level Up toast for TBC and Classic\
Added a skin to the Character Panel for TBC and Classic, which includes a fork of Simple Item Levels by kemayo\
Added options to change the colors of the borders\
Added Quests to TBC and Classic, also adding an option for any combat event\
Added Crystalzcuhei as a font option during install\
Added an option to automatically show or hide the experience bar depending on level\
Added an option to display floating Power gains (such as Mana/Rage/Energy)\
Added more options to control some CVars\
Added a new Nameplate filter for Totems, if you can attack a totem its portrait will be shown\
Added a new tag [eltruism:raidmarker] which will display the raid marker icon\
Added a new tag [eltruism:difficulty] which will color the enemy npc according to its difficulty compared to the player's level\
Added a new tag [eltruism:targetcast] which will show the target of an enemy spellcast\
Added a new tag [eltruism:targetcast:indicator] which will show the target of an enemy spellcast alongside a Target > text\
Added new commands: /eltruism color and /eltruism chat, color will toggle between dark and light mode, and chat will toggle between dark and transparent mode

Updated Light and Dark Modes, now Light mode will have the Target Unitframe Texture as its own class based texture, with the player keeping its own and power and classbars not being affected by it\
Updated Cursor, GCD, Combat Cursor and Cooldown Cursor functions\
Updated references to FCT to make it clearer that it's Simpy's ElvUI FCT\
Updated references to nameplates due to a change in ElvUI code\
Updated Chat Fade to register events only when enabled\
Updated Dynamic Cam Profile for Retail due to Dynamic Cam's internal changes
Updated Chat, which is now transparent with a new option in Eltruism > Chat to revert to the dark mode or switch to the transparent mode if the user wants

Fixed an error when setting fonts without Project Azilroka installed\
Fixed shadows showing up when chat panels were disabled\
Fixed player castbar shadows being mismatched in some scenarios\
Fixed some missing shadows\
Fixed Auto Screenshot not working in some situations\
Fixed some unitframe texts not being disabled before setting up custom texts\
Fixed pet cooldowns not always working with Cursor Cooldowns\
Fixed Target of Target Height on Healer Profile\
Fixed Expanded Talents for Season of Mastery\
Fixed Objective/Quest Tracker position due to Questie (only for new installations of Questie)\
Fixed an issue where disabling wide nameplate auras would also disable the nameplate glows\
Fixed an issue when using certain combinations of characters with the /way command could cause errors\
Fixed an issue where some install options would be disabled when they shouldn't\
Fixed an issue with nameplate power bar visibility when using Plater instead of ElvUI Nameplates
___
### 2.6.2
Fixed an error that occurred when ElvUI unitframes were disabled
___
### 2.6.1
Fixed an error causing the install of the healer profile to fail when Shadow and Light was enabled
___
### 2.6.0
Fixed an error causing the install prompt to not appear due to a change in WindTools
___
### 2.5.9
Fixed an error related to shadows when ElvUI Action Bars were disabled
___
### 2.5.8
Fixed Shadow and Light Profile not applying and failing to install Eltruism Profile due to a database change
___
### 2.5.7
Updated all versions to newest ElvUI and game versions\
Fixed Nameplate Buffs and Debuffs's position being adjusted even when auto adjust was disabled\
Fixed Action Bar 4 showing up during pet battles\
Moved the Raid Pet frames for Burning Crusade Classic and Classic to allow healers heal pets more easily\
Fixed Expanded Talents on Classic
___
### v2.5.6
Fixed duplicate name text\
Fixed error on install due to a Shadow & Light change\
Changed action paging for Rogue due to an issue with Shadowdance
___
### v2.5.5
Updated toc for TBC classic\
Attempted to fix errors related to font file format\
If you still have errors or issues, please report to the Eltruism discord, thank you
___
### v2.5.4
Fixed GothanNarrow font not working well with French localization\
Fixed chat loot icons being enabled even when chat modifications were disabled
___
### v2.5.3
Disabled the Hardware Cursor change by default\
Changed how detecting combat text addons work, now it is an option in Eltruism >Misc
___
### v2.5.2
Fixed tags in TBC due to a new ElvUI version\
Fixed buffs being too high on nameplates due to a change in how they are handled
___
### v2.5.1
Fixed shadows error related to unitframes
___
### v2.5.0
Added a check for resolution for pet unitframe\
Enabled buffs and debuffs on pet unitframe for DPS/Tank profile \
Changed castbar on Healer profile to fit the shadows, this change will be pushed if you login with the healer profile after updating\
Added a button in Eltruism > Media to swap action paging and visibility for Action Bar 1 and Action Bar 4\
Added more checks before creating shadows to prevent errors\
Tweaked class icons in light mode to not be so pixelated\
Set most chat fade options to be disabled by default, making it user preference to enable them
___
### v2.4.9
Updated tags for new ElvUI version\
Added an option to disable hardware cursor, resolving the cursor lag introduced in Battle for Azeroth
___
### v2.4.8
Fixed Multiple Class Icons on Character Frame\
Added check for elvui bags before adding shadows to prevent errors
___
### v2.4.7
Removed SmartAura from Pet Unitframe\
Added a check for ProjectAzilroka before applying shadows to stAddonManager\
Added an option to skip plugin install warnings on login
___
### v2.4.6
Eltruism now only requires ElvUI and AddOnSkins. ProjectAzilroka, Shadow & Light and Windtools are highly recommended screenshots still use them, but you no longer need to have to use Eltruism\
Updated layout for ElvUI 12.38\
Added loot icons which is merged from Stanzilla's Chat Loot Icons which is Public Domain\
Added Shadows to frames\
Added an option to hide the NPC Talking Head Popup\
Added InstantLoot, yet another fast looter\
Added Skins to the default Objective Frame/Quest Log\
Optimized nameplates and other functions\
Hid the copy chat and Voice Buttons on the layouts\
Nameplate Power Bar will now break down big numbers such as 50000 becoming 50k\
Waypoint Time to Arrive now has unlimited range, automatically tracks new waypoints and the font follows ElvUI General Font
___
### v2.4.5
Added a Preview for Custom Glow, you will need to toggle it on and off to update the glow options\
Updated Time to Arrive to use less CPU\
Fixed Buffs being moved when auto adjust was turned off\
Cooldown will now color the text red when below 1 second
___
### v2.4.4
Added glow to pet action bars, this setting is also available for TBC/Classic in Eltruism > Custom Glow\
Added glow to expiring debuffs on nameplates, this can be turned off in Eltruism > Custom Glow\
Moved the timer text for Buffs & Debuffs on Nameplates to a more readable position (top)\
Added Colors to some events in Chat\
Added an option to play a sound when someone rolls a 1 or a 100 (default off)\
Added Combat indicator Floating Text, +Combat when entering combat and -Combat when leaving combat, this setting can be toggled off in Eltruism > Misc\
Added mana to Raid and Raid40 uniframes for Classic/TBC\
Removed the 75% alpha from action bars for DPS/Tank profiles\
Fixed missing Arcane Mage Debuff mover when using Nameplate Power Bar\
Disabled Flash on EltreumExecute Nameplate Style Filter\
Readded Cast Icons on Nameplates and changed their position/size\
Retail can now have threat on nameplates just like Classic/TBC if you enable Nameplate titles on Enemy NPC and/or Enemy Player
___
### v2.4.3
Added an option to hide Blizzard Boss Alerts (default on)\
Added more fonts and textures\
Changed textures and flash on EltreumExecute and EltreumInterrupt nameplate filters\
Split Textures on Unitframes from Light Mode and Dark Mode\
Updated AddOnSkins hide chat to current ElvUI chat frames, this might only work on the alpha version of AddOnSkins for now
___
### v2.4.2
Improved Party/Raid death detection\
Split Cooldown from Cursor, now you can enable one without needing the other\
Fixed Light Mode not having gradient unitframes\
Fixed Class Icon on Armory being blurry sometimes
___
### v2.4.1
Added Class Icons by Releaf\
Added a second Details profile that includes class icons by Releaf
Added an option to switch icon types on character profile
Added custom dead and offline indicators in Retail using Releaf's textures
Updated chat install according to ElvUI changes
Fixed switching Dark Mode > Light Mode > Dark mode\
Fixed cooldown being enabled when cursor was disabled
___
### v2.4.0
Added Class Icons to Player and Target unitframe Name\
Borders is now released\
Added Cooldown to Cursor\
When you try to use your cooldowns again their icon will show up inside Cursor, alongside a timer\
The icon will show again when the skill becomes usable\
Revamped changelog into a markdown file linked in the Support options menu\
Added support for Dynamic Status Icons when importing profile
___
### v2.3.9
Fixed Transmog Window\
Exorsus Raid Tools was renamed to Method Raid Tools and the references were updated for it\
BigWigs profile is now working according to Funkeh's suggestions\
Fixed .toc interface version
___
### v2.3.8
9.1 Compatibility\
Wide Transmog updated to support transmogrifying each shoulder separately\
Level Up and Event Toast updated to new system\
New Misc option that includes some options that didnt fit into other places\
Quests can now be hidden in Arenas and Battlegrounds\
The following can be found under misc, and are defaulted to off:\
Added Arena Buffs, show target and enemy player buffs in arena but hide them elsewhere.\
Added option to hide arena unitframes in arena (in case you are using an addon like Gladius/Gladdy/sArena/GladiusEX)\
Added option to hide raid frames in battlegrounds (in case you are using an addon like Battleground Enemies)\
Rogue Order Hall Auto Open has been moved to Misc
___
### v2.3.7
Improved event detection for Nameplate Power Bar (Thanks Repooc!)\
Hunter and Demon Hunter power bars will now follow Unitframe Power Colors like other classes\
Left Chat hide will now behave the same as Right Chat hide\
Moved the Focus Castbar into an easier to see position\
Changed Experience and Reputation databars to on the top of the screen, disabled honor and azerite databars
___
### v2.3.6
Added Borders (Beta), disabled by default\
You will need to adjust the borders if using them with profile or setting outside of the defaults for Eltruism DPS/Tank\
Added Border media, credits in the License folder\
Fixed AFK music error for Undead players since the race code is Scourge\
Changed code for Nameplate Power Bar\
Nameplate Power Bar colors will now follow Unitframe Power Colors so they can be changed by the user over there\
Changed BigWigs and Details import logic (thanks Luckyone!)
___
### v2.3.5
Tweak chat hide so that it will hide without a mouse click\
Prepared for 9.1\
Changed classpower on nameplates that was defaulting to class color when it was meant not to\
LootText will now have trimmed icons without the grey border
___
### v2.3.4
Added Localization Support (only English is live for now)\
Added World Text Scale option\
Fixed overlapping debuffs on nameplates due to Nameplate Power Bar\
Moved the Focus to the top left side since on the right side there are boss frames and Arena frames and it should not overlap the Alternate Unitframes
___
### v2.3.3
Improved module loading between TBC/Classic/Retail\
Fixed missing Demon Hunter Power Bar due to the position being behind the nameplate\
Added Gladius and Gladdy profiles for TBC
___
### v2.3.2
Added more options to Nameplate Power Bar, such as changing its size, position, and texture\
Fixed Nameplate Power Bar not appearing for retail Shamans until they swapped specs\
Bundled ElvUI Chat and CVArs setup with Eltruism Install\
ElvUI Install prompt will now be skipped since Eltruism sets the same things or overwrites things\
Swapped Chat functions: Now it starts disabled and after a left click it can fade
___
### v2.3.1
Chat Fade/Hide can now be toggled off by Left clicking on either chat, clicking again will enable the Fade/hide again\
Quests will now expand when the boss encounter ends\
Reworked Classic/TBC Druid logic for Nameplate Power Bar\
Changed BigWigs profile name to Default so that it doesn't get reset with a reload\
Fixed missing Enemy Player Buffs/Debuffs on Aura Filters\
Added Expanded Stables to Shadowlands Hunters, merged from Improved Stable Frame by Cybeloras and licensed under GNU GPLv3\
Rogue Order Hall will automatically open following Rogue Door Opener by Burzolog licensed under GNU GPLv3
___
### v2.3.0
Added Chat Modifications, check Eltruism > Chat for the options\
Added Expanded Transmog Window to Shadowlands\
Spellsteal filter will now check for player class\
Waypoint Timer will now follow ElvUI general font\
Optimized Nameplate Power Bar\
Fixed Nameplate Power Bar showing on neutral or unattackable NPCs\
Fixed LootText not showing Gold earned when in other locales\
Fixed Stealth not working when entering world or the first time stealth was used
___
### v2.2.9
Fixed Classic/TBC feral druid power bar overlapping combo points\
Added ElvUI movers that can be used as Weakauras anchors: EltruismWA and ELtruismConsumables\
Simply open your weakaura group and in Display > Anchored To > Select Frame > Type either EltruismWA or EltruismConsumables\
The Weakauras will anchor to the mover and now you can use /moveui to move them.
___
### v2.2.8
Added aura filter options to show more buffs/debuffs\
Added more options to Cursor\
Added more options to Action Bars Glow\
Reworked Shadow and Light and Windtools dependencies: Eltruism still requires them for Shadowlands, but not on Curse due to TBC/Classic issues
___
### v2.2.7
Added option for LootText to use ElvUI General Font (Found in ElvUI > General > Media)\
Changed LootText icon scaling to be more inline with the font\
Removed Weakauras page from install since most of them are now options in the plugin
___
### v2.2.6
Added Nameplate Power Bars - Based on the Weakaura\
Added expanded talents to Classic\
Added AFK music to TBC and Classic\
Added Class Icons to Character Panel\
Added tags to show Class Icons on unitframes/nameplates\
Added Role Icons to Role Swap message\
Modified Dynamic Datatext to Show Icon for Ammo/Soul Shards\
Fixed an error due to scroll wheel being killed on talent window\
Tweaked the Healing Profile Tank and Assist Frames
___
### v2.2.5
Fixed TBC Expanded Talents --Thanks Gregory!\
Reworked Version Checks to have less errors
___
### v2.2.4
Added option to change the position of LootText\
Fixes for TBC Expanded Talents
___
### v2.2.3
Added Expanded Talents for TBC\
Added options in Media for the Expanded Talents, Level Up skin and Boss Loot Frames depending on game version\
Added threat to Enemy NPC nameplates\
Fixed errors when user first installing Eltruism\
Fixed missing possession bar on Death Knights\
Fixed the Healer Layout Tank and Assist Frames
___
### v2.2.2
Fixed error when ElvUI nameplates were turned off
___
### v2.2.1
Added option to change the strata of LootText\
Fixed an error due to a missing table for Rare Style Filter
___
### v2.2.0
Added scale option to LootText\
Optimization/Cleaning Pass\
Added dynamic datatexts that change according to player class, showing Ammo/Soul Shards for Hunters and warlocks, and Friends for other classes\
Fixed heal prediction being gray for some classes in TBC/Classic due to a low alpha value\
Dynamic Level tags on enemy nameplates that will show only when the player is below max level\
Due to how aura filters work in ElvUI it's recommended to go to |cffff0000ElvUI > Unitframes > Group Units > Party/Raid/Raid40 > Aura Indicator > Set them to Textured Icon with Display Timer|r
___
### v2.1.9
Fixed repeating install process prompt due to a database change
___
### v2.1.8
Revamped Changelog to fit more versions\
Layout now has additional checks for resolution\
Added class check to change left chat datatext panel to count Ammo/Soul Shards if playing Hunter or Warlock in Classic/TBC\
Do note that the datatext will not dynamically swap if you change characters\
Further streamlined the install process code
___
### v2.1.7
Added new Cursors, changed their file path\
Revamped Cursor options\
Changed some internal code\
Improved Party/Raid death according to Simpy's suggestion
___
### v2.1.6

Fixed Cursor error related to instances
___
### v2.1.5
Added an option to change the size of the cursor\
Added images showing the rings for the cursor\
Fixed abbreviation when using cyrillic letters
___
### v2.1.4
Added Cursor, a fork of CastCursor by michaelsp (this module is GNU GPLv3)\
Changed how version checking works\
Added alternative layouts for party/raid/raid40 for the DPS/Tank profiles\
Tweaked install process to offer alternative layouts for certain classes\
The original layouts for those frames were made with pure dps classes in mind,\
if your class has off heals or raid cooldowns you might want to use the alternative layout\
Check it in Eltruism > Party/Raid
___
### v2.1.3
Updated settings to ElvUI's newest version\
Changed TBC/Classic profiles to show mana/energy regen
___
### v2.1.2
Added option to reset nameplates to Eltruism defaults\
Tweaked nameplate class borders, colors, and textures when option is off
___
### v2.1.1
Fixed friendly nameplates being forced on during login
___
### v2.1.0
Converted database to profile from private\
Renamed Nameplate Stylefilters to avoid confusion, please remove the |cffff0000EnemyCasting, ExecuteRange, StealThisBuff and HideThis nameplate filters|r\
Fixed Details! TBC profile due to Details! changes\
Fixed Pet Unitframe happiness missing when using Custom Fonts\
Reworked absorb logic for Retail profiles (disabled for DPS, enabled for Healer)
___
### v2.0.9
Streamlined install process\
Updated ProjectAzilroka profile\
Added missing Party Castbar to Retail Healer profile and TBC profiles\
Added new death sound (Ion's - Frankly that's a skill issue)\
Added custom fonts option (Eltruism > Media)\
Fixed a rare issue with Shadow and Light viewport on profile install
___
### v2.0.8
Added power bar to pets\
Update function has been changed\
Added level to enemy nameplates in Classic/TBC\
Fixed .toc versions
___
### v2.0.7
Condensed the install screen to be faster\
Fixed ProjectAzilroka install due to its internal change\
Revamped Threat bar in Classic/TBC to be in the Left Chat Datatext
___
### v2.0.6
Tweaked init function for quests
___
### v2.0.5
Removed Quest options in Classic/TBC due to those versions not supporting the function
___
### v2.0.4
Fixed a bug with LootText when awarded honor in Classic and Burning Crusade Classic\
More pet unitframe changes to accommodate name length and happiness tracking\
Changed the DBM HUD size in Questie profile\
Warning: DBM HUD will cause bugs in bgs due to not being supported in instances
___
### v2.0.3
Improved Font Outline detection\
Friendly Nameplate disable option added\
Pet bar change to accommodate name length and happiness\
Other minor changes to profile\
Questie profile for Classic and Burning Crusade Classic\
You will need to reload after questie builds the database and reload again after setting the profile\
Classic Questie has some issues for now, and you might need several reloads due to a known bug with townsfolk
___
### v2.0.2
Added Dark Mode and Light Mode\
Can be found in Eltruism > Media\
Fixed Bigwigs profile for TBC due to new version
___
### v2.0.1
Fixed absorb tags in Classic/TBC\
Fixed nameplate clamping to screen in TBC\
Fixed LootText test command in TBC
Fixed datatext height
___
### v2.0.0
Added combat music! Type the path to your file in the settings\
Classic/TBC Support! Report any bugs in the Discord\
Many addons weren't updated for TBC yet, so profiles might not work\
Added class colored level up and boss loot by Aftermathh\
Style Filter StealThisBuff fixed to be mage only\
Enabled Class Totems\
Changed the size and position of the Gladius Ex profile\
Recommended settings for font outline:
- 4K resolution: Use profile default
- 1440p resolution: Eltruism > Media > Outline
- 1080p resolution: Eltruism > Media > Outline\
Implemented automatic switching of font outlines
___
### v1.9.3
Added /way and /waypoint command, usage:\
/way XX YY or /waypoint XX YY\
/way XXX YYY or /waypoint XXX YYY\
/way XX.XX YY.YY or /waypoint XX.XX YY.YY\
/way XX,XX YY,XX or /waypoint XX,XX YY,YY\
It will only work in places where waypoints work\
Any other types of inputs may result in an error\
Added option to enable/disable the /way and /waypoint commands\
Added checks for installed addons\
Added Font Outline options to Media\
Fixed missing Sepsis paging for Night Fae Rogues (thanks to Naifu)
___
### v1.9.2
Fixed a CVar bug due to triggering in combat\
Fixed full inventory in LootText
___
### v1.9.1
Removed test print
___
### v1.9
Added LootText, a fork of SLoTE. (This module of Eltruism is GNU GPLv3)\
You can test LootText by typing '/eltruism loot'\
Added a version check which will automatically update settings if the user is out of date\
Changed Class Texture on Nameplates, Mage and Shaman use a different texture to avoid the green color\
Included a nameplate filter for rares that is active with Class Textures on Nameplates\
Changed the Friendly Nameplate option, now it will show friendly names inside instances also, with the previous setting being a separate option\
Fixed a missing friendly nameplate setting that was not exported\
Changed a few CVar values for nameplates\
Moved dependencies, added checks on the installer for missing addons\
Turned minimap bar into mouse over\
Fixed pet on healer profile\
Added a few commands:\
/eltruism config - open Eltruism plugin settings\
/eltruism options - open Eltruism plugin settings\
/eltruism install - prompt the installer\
/eltruism setup - prompt the installer\
/eltruism loot - Display a test message for LootText
___
### v1.8.1
Added Changelog to options\
Tweaked Quests during encounters\
Fixed AFK music muting music on login
___
### v1.8
Version check for Shadow & Light\
Added media (class textures)\
Split Functions into Modules\
Fixed a duplicate Font when importing other fonts\
Class Gradient on Target Nameplate (default off!)\
AFK Class Music\
Quest Collapse during boss encounters to prevent overlap with boss frame\
Roboto Font added as option during install
___
### v1.7
New option to change font during the install, choose between Kimberley, Exo2 and GothamNarrow\
New media added\
Tweaks to AFK sound, should no longer play duplicate sounds\
Fixed DBM Y-Offset that was broken due to a change in DBM
___
### v1.6
Wide Nameplate Buffs and Debuffs\
Nameplate Buffs and Debuffs stack count moved to lower right when using wide nameplate\
New death sounds\
Nameplate tweaks to make them stick inside the screen while targeted\
Tweaks to font outlines\
Minor tweaks to profiles
___
### v1.5.2
Fixed action paging for some classes
___
### v1.5.1
Fixed global fade on healer profile\
Updated the waypoint options
___
### v1.5.0
Revamped Waypoint Time to arrive, decreasing memory usage by a lot!\
Added Role Icons\
Layout Changes\
Added Weakaura recommendations that were made for this addon
___
### v1.4.5
Changed Action bar visibility options\
Now you can have actionbars on all the time by disabling Inherit Global Fade on each bar
___
### v1.4.4
New death sound (Wilson Wow)\
New media available\
Tweaked Enemy Player Nameplates\
Tweaked install process\
Fixed missing chat height
___
### v1.4.3
Fix global soundHandle\
Tweaked Nameplate classpower background color
___
### v1.4.2
Fixed classpower position
___
### v1.4.1
Time to Arrive includes the memory usage of the SuperTrackedFrame and should reset automatically just like Blizzard's code, but for now it will reflect Blizzard's memory usage\
Added Time to Arrive text below Waypoints\
Tweaked a few profile settings\
Fixed SuperTrackedFrame inside instances
___
### v1.4.0
Added time to arrive text below waypoints\
This setting includes the memory usage of the SuperTrackedFrame, and should reset automatically just like Blizzard's code\
Tweaked a few profile settings
___
### v1.3.2
Fixed CVar taint from friendly nameplates near WQ areas\
Fixed missing music for some races
___
### v1.3.2
AFK music is now working correctly
___
### v1.3.0
Added options to nameplates\
Friendly Nameplates will now show outside instances, and hide while inside instances\
Test version for Racial AFK Music added
___
### v1.2.0
Added a function to play a sound when someone dies
___
### v1.1.0
Healer profile was changed
Additional Media
___
### v1.0.0
Initial version\
Added Layout for DPS and Healer\
Added Options Menu\
Added Media\
Added Class Glow to Action Bars
