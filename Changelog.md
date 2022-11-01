### 🌌 Next Version
The future is uncertain
___
### 3.5.5
Added Class Colors to Party and Raid Borders\
Added a few missing shadows\
Updated Character Item Quality Texture to also change the item Border color to the Set Color\
Updated Nameplate Gradient with a workaround fix for the Health Color flashing\
Updated Target to not Reverse Health and Power\
Removed Key Down CVar due to ElvUI fixing the issue\
### 3.5.4
Added a temporary option to change the Keypress CVar that is currently causing issues in Retail due to 10.0\
Added transparency to Castbar Gradient which will now better follow ElvUI settings\
Added 10.0 dungeon Teleports to the Teleports Datatext\
Added Paladin Battle Res Icon in Retail\
Added Evoker to multiple tags\
Added a few missing shadows\
Updated Hide Arena to Hide in Battlegrounds if Battleground Enemies is loaded since it also adds indicators\
Updated Waypoint function to remove Waypoint once you arrive at the destination\
Updated DynamicCam profile to fix an issue with the new Fade UI default\
Updated Custom Backdrop for Castbars to use a 0.4 alpha\
Updated profile to reverse Target Unitframe\
Updated German Locale by Dlarge\
Fixed SoulShape paging Warlock's ActionBar in Retail\
Fixed an Error on LootText when refunding an item
### 3.5.3
Added cvar to enable all minimap tracking options during install\
Added an option to change the Objective Tracker Height\
Updated Spell Power Prediction for Nameplate Power Bar in Retail\
Updated [eltruism:ReleafIconOutline:player] tag icon outline\
Updated BigWigs profile's Info and Proximity Panels\
Updated Demon Hunter's Fury Power Gradient Color\
Fixed Objective Mover and changed Edit Mode Button to show ElvUI Movers in Retail, Edit Mode Button can be return if Eltruism Button is disabled\
Fixed transparency on unitframes and aurabars, Aurabars will now follow general ElvUI backdrop alpha\
Fixed the disabling of custom textures and other settings to only Light Mode in Retail\
Fixed an issue where some Crafting Descriptions were not showing up in Classic/Wrath\
Fixed Power and Classbar shadows if they are detached from Player Unitframe\
Fixed Loot Frame's Gradient erroring in Classic/Wrath\
Fixed Retail Instance Text
### 3.5.2
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
### 3.5.1
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
Added an option to set Debuff Borders separate from Buffs\
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
### 3.5.0
Added an option to enable automatically enabling the combat logging during raids/dungeons and disabling outside them\
Added a few more missing enchants to Sockets and Enchants in Wrath\
Added Vellum Button to Retail Enchanting Profession Frame\
Added a few items to the block list for Quest Item Bar\
Added Disenchant Button to Enchanting Profession Frame\
Added a few more models to the Target Portrait Fix\
Added an option to adjust Taxi Frame Scale\
Added gradient to Party Pets and Raid Pets\
Added an option to adjust Quest Scale\
Added an option to adjust Map scale\
Added a few more shadows\
Updated Loot Roll frame position to be below the Threat Bar to avoid overlap in Wrath/Classic\
Updated Borders print to only print when enabling during install\
Updated Character Panel Skin to update when swapping specs\
Updated German locale by Dlarge\
Fixed an issue where some combat CVars were not being correctly set in Wrath due to Wrath using a different system\
Updated Pet Action Bar Glow to run on non Hunters and Warlocks\
Fixed Details Spec Icons due to an update from Details
### 3.4.9
Added option to set the Quest Item Bar Vertically\
Added preset settings for Pet Party Frames in Wrath\
Added more models to the Target Portrait Fix\
Added a new sound: Durumu - Wipe\
Added player to Portrait Fix\
Added a few missing shadows\
Updated Inspect Sockets, Enchants and Item Level unit detection\
Updated AFK Music with more possible fixes\
Updated Chinese translation by Neo\
Updated Nameplate Aura Filters\
Fixed a possible issue when using other Quest Trackers besides Questie\
Fixed Number of Groups for Raid2 in Retail\
Fixed Spec Details Profile in Classic Era\
Fixed Questie Hide in Classic Era\
Fixed a shadow in Classic Era\
Fixed Stats Datatext in Classic Era
### 3.4.8
Updated Character Panel Skin while in Combat in Classic/Wrath, it will not be the same but should be more usable and contain a warning about being in Combat\
Updated Quest Skin to adjust the Quest Item Button if the Quests is set on the left side instead of the right side of the screen\
Updated TradeSkill Skin to move the Auctionator Price Check Button if Auctionator is Enabled\
Updated TradeSkill Skin in Classic Wrath to prevent Engineering Tinkers Text Overlap\
Updated Questie Profile Import, which will now not overwrite your current profile\
Updated Target Portrait Fix with many more Models to be detected\
Updated Aurabars to Sort by Ascending\
Updated Aura Filtering Priorities for Profiles\
Fixed Shaman Totem Glows activating when the Classbar was disabled in Classic/Wrath\
Fixed Wowhead Quest Button only appearing when the Quests Skin was enabled\
Fixed AFK Music rarely enabling Sounds
### 3.4.7
Added Engineering Enchants to Sockets in Wrath\
Added Wrath Instance Difficulties (10/25/10 Heroic/25 Heroic)\
Added an option to disable Tooltip Item Level in Classic/Wrath\
Added a setting to change the Volume of Text to Speech to Cooldowns and Mail Text To Speech\
Added options to change the Width and Height of the Quest Item Bar Buttons, alongside button spacing settings\
Added another NPC to the block list for Automatic Quest Turn Ins (Magical Kingdom of Dalaran NPC in Dalaran)\
Updated [eltruism:presence] into [eltruism:stance] which will work with more classes and return their stances in Classic/Wrath, in Retail it will only work with Paladins due to stances being removed\
Updated Sockets and Enchants to not always require Rings and Belt enchants due to professions limitations, and enabled level checking again\
Updated Gradient Aurabars to make them compatible with Transparent and Non Transparent Aura Bars from ElvUI\
Updated Portrait Fix to also use Model detection for some models\
Updated Chat Class Colors to not depend upon Chat Loot Icons\
Updated Quest Item Bar to prevent a keybind issue\
Updated German locale by Dlarge\
Updated MeetingHorn Skin\
Fixed Threat Bar not being centered\
Fixed Non Interruptible Gradient Color not having the correct gradient
### 3.4.6
Added compatibility between Custom Textures and Gradient, now allowing both at the same time\
Added support for ProjectAzilroka's Enhanced Shadows, allowing shadows to change colors if ProjectAzilroka is loaded and using that module\
Added Evoker preliminary Textures and Colors\
Added a button in Eltruism > Installer to reset Nameplate Style Filters\
Updated Wowhead button to check game version\
Updated Quest Item Bar to better detect items\
Updated Threat Databar to not overlap with the Eltruism Datatext Panel\
Updated Addon profiles to better detect ElvUI Font Outlines\
Updated Nameplate Power Bar setup process\
Updated Threat Databar in Classic/Wrath\
Updated Cursor Textures to avoid aliasing in lower resolutions\
Updated Options, making it easier to see which options are incompatible\
Updated Target Portrait Fix, which will now also pause and desaturate dead target models\
Updated Procs in Wrath, adding missing ranks for Kill Shot\
Updated Quest Skin in an attempt to avoid the moving Quest Item in Wrath\
Updated some addon profiles to prevent overwriting existing profiles\
Updated Nameplate Power Bar Prediction\
Fixed a possible error with Cursor when reloading in combat\
Fixed gradient for Target of Target of Target\
Fixed Custom Textures not automatically updating without a reload
### 3.4.5
Added EltreumRefreshDebuff nameplate style filter, which will set nameplates that have expiring debuffs to full scale and alpha, but it requires the player to manually add the debuffs to its list\
Added a shortcut to the EltreumRefreshDebuff nameplate style filter in Eltruism > Nameplates so that its easier to add Debuffs to it\
Added shadows to multiple Alert Frames like Achievements\
Added Shadows to some missing frames\
Added Gradient to Mirror Timers such as the Breath Timer\
Added an option to Automatically Confirm Bind on Pickup Items in Classic/Wrath\
Added Gradient to Classbars/Additional Power Bar\
Added shadows and Gradient to Loot Roll Frame in Classic/Wrath\
Added action paging for stances for Warrior and Death Knight in Classic/Wrath\
Added Cardinal Directions to Minimap\
Updated profiles, enabling smoothbars again and changing the backdrop color\
Updated Details Icon to the new version of Details, also adding Evoker Icons\
Updated some events related to Quest Item Bar\
Updated German locale by Dlarge\
Updated Quest Item Bar\
Fixed a possible error with Details\
Fixed Profession skin not loading when other addons loaded Blizzard's Addons before Eltruism was loaded\
Fixed a possible error with Glows when ElvUI action bars were not enabled\
Fixed Guild Bank Shadows\
Fixed a possible issue with chat custom colors due to the color table loading after the chat history had loaded\
Fixed a possible issue with the Stats on Character Panel being outside the Panel in Retail when the number of stats was too many\
Fixed the Inspect Sockets option button not disabling when the Character Sockets option was disabled\
Fixed action paging for Priests and Death Knights in Classic/Wrath\
Fixed a possible error with Cardinal Directions when using class colors
### 3.4.4
Added some more missing shadows\
Added customizable gradient colors to Details Skins, if the option is enabled in Gradient Colors then Details will use the custom colors\
Added Shadows to BigWigs Skin\
Updated ElvUI FCT profile\
Updated how fonts for other addons are applied during install, now they should use the font you have chosen\
Updated Install process removing Automatic Scale since Eltruism is only really adjusted for the default Scale and not multiple ones (you can use any other scale but profiles won't be adjusted for it)\
Updated Evoker Icons\
Fixed an issue with Borders toggling during install if the profile was already installed\
Fixed Target of Target size in WeakAuras mode if the Healer profile was used\
Fixed Player Power not appearing if using WeakAuras mode with Healer Profile\
Fixed Quests overlapping with the Boss Frame by hiding quests during boss fights when the option was enabled instead of collapsing quests\
Fixed an error when attempting to type a voice for Mail Sound when Text To Speech did not have a voice selected\
Fixed Details having a white bar texture during login\
Fixed some shadow issues\
Fixed an issue with action paging with Demon Hunters\
Fixed spaced power shadows in Party
### 3.4.3
Added Gradient to BigWigs Bars with a BigWigs Skin in Eltruism > Skins\
Added Gradient to Details Bars with a Details Skin in Eltruism > Skins\
Added a few checks for Unitframe Modifications being enabled before applying settings like gradient power and models\
Added the chat command /eltruism translate which will turn off DeepL translation warnings\
Updated Bigwigs, DBM, Capping and ElvUI FCT profiles\
Updated Warlock Model to be different from Paladin\
Updated Pet Castbar color to have a different color between Interruptable and Non Interruptable\
Fixed the Death Animations (such as "You Died") activating inside instances\
*Note: Details alpha/beta versions might have issues with the skin since those versions are meant for Dragonflight and not release, make sure to use the release version from August 31st
### 3.4.2
Added settings for new Totems from ElvUI 12.89\
Added Shadows to Totem Tracker\
Added a missing enchant to sockets\
Updated EltreumTarget Nameplate Style Filter by disabling Health by Class\
Updated gradient functions to improve performance\
Updated tooltip and enabled item quality border\
Updated general Totem Settings due to new totems on all game versions\
Updated PallyPower skin to use icons like the character panel skin(Releaf or Blizzard icons)\
Updated Offhand Weapon Quality Texture in Character Panel Skin in Wrath/Classic\
Fixed Minimap and Chat shadows not changing size when changing the size option for shadows\
Fixed incorrect Group Spacing in Raid2 Healer Layout for Wrath/Classic\
Fixed Inspect Item Level Text sometimes not updating
### 3.4.1
Added Gradient Aurabars and added shadows to Aurabars\
Added Glows for Dispels on Unitframes, enabled in the Healer profile\
Added an option to change Shadow Sizes\
Updated Healer Raid Frames Layouts\
Updated Shadow and Light profile\
Updated PallyPower Skin by adding a few missing buttons\
Fixed some PallyPower shadows\
Fixed an issue where Health Color and Texture for Nameplates when Gradient was enabled were not being disabled\
Fixed the Buff in Arenas function having wrong visibility after ElvUI changed Raid frames\
Fixed an issue when ProjectAzilroka was loaded by some modules were not enabled when creating shadows\
Fixed Shaman Totem Glow order in Wrath/Classic
### 3.4.0
Added a skin to PallyPower\
Added gradient to focus target\
Updated MeetingHorn skin\
Updated a few shadows\
Updated actionbar glows in Wrath/Classic to only load on classes that actually have procs\
Updated the automatic role setup to ignore Death Knights in Wrath\
Updated some class icons\
Updated Chat Positions one pixel down due to the toggles\
Updated Gladdy profile to add Totem Pulse\
Fixed a possible error during Layout install if the LFG channel was not found\
Fixed Tooltip Shadow when Healthbar was set at the bottom\
Fixed some PallyPower Shadows
### 3.3.9
Added Item Level to tooltips in Wrath/Classic\
Added a skin to the Gear Manager Toggle Button\
Added an option to disable moving auras when hiding minimap in combat\
Added gradient to Focus Target\
Added Spirit to the Stats Datatext for the Specs that use it in Classic/Wrath\
Added an option to use custom colors for classes in chat, these colors sue the colors from gradient\
Updated Layouts to use 0.71111111111111 scale as a multiplier for 1080p, 1440p and 4K\
Updated Player and Target Castbar shadows to more reliably be set on the correct position\
Updated Weakauras Actionbar mode\
Updated [name:eltruism:abbreviateshort] to not use "..." and instead use one extra letter\
Updated Layouts to use Locked ActionBars by default\
Updated German locale by Dlarge\
Updated [eltruism:groupnumber] tag to say, for example, "Group 1" instead of just "1"\
Updated some references in how they obtain item info to use a more generic method compatible with non enUS locales\
Updated Inspect Talent frame skin by adjusting some the text/buttons to be more centered\
Fixed an issue with the Quest Skin that could cause an ElvUI message to appear\
Fixed an issue with the Wrath Quest Skin where text sizes would change\
Fixed Achievement Skin in the Objective Frame in Retail when the cursor entered/left the text\
Fixed an issue with unitframe shadows when BenikUI ha detached portrait enabled and Eltruism had Information Panel on top enabled\
Fixed Bars in Quest Skin having a gap when not using ElvUI Thin Borders\
Fixed an issue where shadows would still get created for tooltips when not using ElvUI tooltips
### 3.3.8
Added option to color chat messages by player class\
Added options to hide some blizzard frames\
Added shadows to Inspect tabs\
Updated for ElvUI 12.86\
Updated Inspect Frame Talent Skin to be the same Size as the Player\
Updated a few functions with combat checks that will show messages when they cannot be run in combat\
Updated German locale by Dlarge\
Updated Stats Datatext with more relevant Stats per Spec in Wrath/Classic\
Updated profile by enabling power model during install\
Fixed Close Button on Glyphs not being Interactable\
Fixed Shaman Totem Shadow in Wrath
### 3.3.7
Added new Datatexts for Stats, showing Crit, Mastery, Haste and Versatility in Retail and Power, Hit, Crit and Haste in Classic, alongside main stats\
Added the new Datatexts to the EltruismDataText Panel and updated the Time datatext with a new panel\
Added an option to set unitframes information panel to be on top of the frame\
Added an option to change the background fade of Power Gradient\
Added Gradient to Wrath Boss Unitframes\
Added an option to use ElvUI Unitframes texture in Gradient mode instead of a Gradient Mode specific texture\
Added Atwood's Role Icons\
Added shadows and borders to Focus Target\
Added a button to restore Blizzard's Combat Text in case it was hidden\
Added a [name:eltruism:abbreviateshort] tag which will abbreviate names for Raid frames\
Added the tags [eltruism:hpdeficitpc] and [eltruism:pchpdeficit] which will show health lost and hp % when health is not full\
Added a function to set the cooldown colors to be class colored\
Added Gradient to Cursor's Cast\
Added Releaf's Role Icons\
Updated Raid Frames to new ElvUI Layout\
Updated Custom Texts to new ElvUI layout, some custom texts might need to be refreshed if changing fonts/outlines\
Updated MeetingHorn skin\
Updated German locale by Dlarge\
Updated Sockets and Enchants to show missing sockets and enchants when above 60 instead\
Updated Datatext layout, with a new EltruismTime datatext that has a Time datatext in a larger size, and the new Stat datatexts added to replace friends and missing tables/coords\
Updated Expanded Talents skin by increasing the size of the rank text\
Updated Quest Items and added a few missing items\
Updated ElvUI Cooldown Text options and changed some of the colors\
Updated the Aura Filters to add more Auras when using Show All\
Updated Logic for Aura Borders and Shadows, which should perform better\
Updated Chat Install Logic in Classic, moving LFG to a separate Tab as to prevent spam\
Updated Power Models to not be wiped away when going AFK\
Updated Nameplate Style Filters (EltreumTarget, EltreumRare and ElvUI_Boss) in Wrath due to an issue with world bosses (mainly AV bosses) where the scale would not apply, EltreumTarget will now scale Worldbosses instead of ElvUI_Boss\
Updated EltreumRestedNP and EltreumHideNP Style Filters to once again use Name Only since the issue with stuttering was fixed in ElvUI\
Updated how Eltruism's Nameplate Style Filters are applied, they will now enable or disable when they are toggled on in the options\
Updated a few more checks when installing profiles and skipping some options\
Updated how nameplate IDs are checked and fixed an issue where sometimes gradient would not apply\
Updated Gladdy profile with more Totem options\
Updated the Frame Strata for some borders so text would not overlap\
Updated Party Castbars on Profiles\
Updated other plugins install message to only display when using an Eltruism profile\
Updated objective frame skin to skin the collapse/expand button in Classic\
Updated Quest Item Bar with a few extra items\
Updated Questie profile, disabling DBM hud\
Updated options enabling Boss frame options in Wrath\
Fixed an issue where the character model would overlap the texture quality icons on the Character Panel Skin\
Fixed an issue with one line of localization\
Fixed an issue with Boss Borders multiplying when changing settings\
Fixed an issue where the color of Gradient Castbar interrupts was not using the custom colors\
Fixed an issue where some Role Icons could be missing textures\
Fixed an issue where the Border is Disabled message could be spammed when leveling up and in other scenarios due to how events were firing\
Fixed some texts not changing outline when using the outline functions\
Fixed Borders Auto Adjust turning on when changing specs/profiles\
Fixed missing Role Icons in Wrath\
Fixed Tooltip Shadow when Health bars exist\
Fixed an issue where the Character Panel Skin Font Size wouldn't change it stat colors was not enabled\
Fixed some missing shadows on Player and Target unitframes depending on settings like power position\
Fixed an issue where player model would reset on certain events\
Fixed an error due to ElvUI_Explosives Nameplate Style Filter on Wrath/Classic\
Fixed missing outline function during Roboto font install\
Fixed an action bar overlap in 1080p
### 3.3.6
Added gradient nameplate castbars, which follow the castbar settings from unitframes\
Added an option to set the Information Panel in Unitframes to be on top instead of bottom\
Added Item Set Color to Item Quality Texture, coloring Item Sets differently and also adding color settings for it\
Added bag ilvl to the Item Level Text on the Character Panel Skin, alongside color settings for it\
Updated Power Gradient with the backdrop being also gradient colored if not using a custom backdrop\
Updated the Character Panel Skin Stats to attempt better aligment of the text for other locales\
Updated the default Gradient Castbars to not use reaction since colors for hostile npcs could be confusing with non interruptable spells\
Updated German locales by Dlarge\
Updated procs to remove moongoose bite since it is not a proc in Wrath\
Updated shadows function to better detect Player and Target Power\
Updated Dynamic Datatext to make it only work for Hunters and Warlocks\
Fixed Meeting Horn Skin, thanks to slm20200822\
Fixed an issue with LootText that caused some World Texts and Combat Texts to be larger than expected\
Fixed an issue that caused Item Level text on Inspect frames to not update in Classic/Wrath\
Fixed a debug print when deleting items\
Fixed an issue with the Role Check happening in combat
### 3.3.5
Added an option to turn off gradient npc castbars being colored by reaction and added color options for it\
Added LootText to some created items\
Added options to change the size and font of LootText, which will also affect some Combat Texts\
Added an option to change the scale of the Expanded Talents in Wrath/Classic\
Updated German translations by Dlarge\
Updated the automatic stats setting to detect player spec and more reliably set the correct stats\
Fixed the compatibility check with MerathilisUI after its database was changed\
Fixed player model effects not always appearing\
Fixed possible errors in gradient power due to enemy NPCs having more powers than expected (over 100 power types), this will cause them to fallback to a mana gradient\
Fixed the Stat Dropdown overlapping the stats on the Character Panel Skin for Wrath\
Disabled MeetingHorn skin as I lack access to it in order to test and fix it
### 3.3.4
Added models to power bars and options for it, with nameplate power bar using the same settings as unitframe powers\
Added options for gradient databars such as reputation, experience and honor\
Added options for the nameplate style filter gradient\
Added gradient to tooltips, this option is attached to unitframes\
Added a function that will automatically set the correct role while in a group for Wrath\
Updated German translations by DLarge\
Updated Execute nameplate style filter to apply only a texture in order to not conflict with the gradient colors\
Updated the custom nameplate height function to ignore player personal nameplate\
Fixed a wrong icon for battle res while playing as a warlock in Retail\
Fixed a possible error with shamans and totem bars during install\
Fixed a possible class color overwrite when using custom colors for quests\
Fixed Death Knight missing for Gradient Colors
### 3.3.3
Added new options for the Objective Frame skin, including fonts colors and textures\
Added missing paging for Rogues and Warlocks in Wrath\
Updated the position of some minimap icons\
Updated Cooldown's minimum length to fix Death Knight's cooldowns\
Updated Sockets and Enchants adding a few missing Death Knight runes\
Updated borders in WeakAuras mode\
Updated Nameplate Power Bar to more reliably hide when the nameplate is gone\
Updated default Death Knight class Model background in unitframes\
Updated Death Knight's Runic Power color's for gradient
Fixed text overlap for Runeforging skin\
Fixed Pet/Companion overlapping the button in Wrath\
### 3.3.2
Added full support for Wrath of the Light King Classic\
Added gradient power to player, target, target of target, focus and target of target of target frames, and also the nameplate power bar\
Added French translation by DeepL, much like the Spanish translation this locale is in testing\
Added a new datatext, Eltruism Teleports, which will show the current hearthstone location and if its on cooldown, alongside a list of all teleports you may have that have a cooldown\
Added a new datatext panel, disabling the minimap and chat panels to use this new datatext instead. An option to add it can be found in Eltruism > Installer\
Added shadows to ProjectAzilroka's minimap buttons\
Updated the Weakauras Action Bar function\
Updated German translations by Dlarge\
Updated Draenei Character Background\
Updated general power colors\
Updated Reputation Colors\
Updated AFK functions to prevent misfiring\
Updated the size of the aura border to not overlap the icon\
Updated the position of the Objective Frame for Classic/Wrath\
Updated the position of some stats in the character panel to fix the aligment issue, this may not work on all locales\
Updated Character Panel Skin Custom background by cropping it the same way as other backgrounds when the panel is not seen\
Fixed minimap border overlapping the location text when using rectangle minimap with Shadow and Light or Windtools\
Fixed Classic/Wrath Objective Skin losing green completion color\
Fixed custom colors for unitframes not applying in some scenarios\
Fixed a missing setting for toggling Level and Boss Skins\
Fixed a missing mover for the Totem Bar\
Fixed Threat function firing while dead
### 3.3.1
Updated Quest Skin to also use Custom Gradient colors if they are enabled\
Updated player combat icon position\
Fixed Nameplate Threat Colors always using Custom Gradient colors\
Fixed DELETE item spamming in some scenarios\
Fixed a possible error with a shadow when opening the Guild/Community window\
Fixed Quest Item Bar not always updating
### 3.3.0
Added FSR scale to the FSR always on option so that FSR factor can be set in Classic/TBC/Wrath\
Updated a few shadows for Wrath\
Updated Quest Item Bar to center when it has only one item\
Fixed Class Cres overlapping some bars in Classic/TBC/Wrath\
Fixed a possible error with custom role icons
### 3.2.9
Added an option to use Custom Role Icons, simply enable and type the file name inside Interface > Addons\
Added an option to change the Character Model position on the Character Skin\
Added an option to force AMD's FSR on even when not using a lower scale\
Added options for gradient Reputation and Honor databars\
Added an Option to move the Item Level Text Position\
Added profile for BigWigs for Wrath\
Updated Gladdy profile\
Updated DBM profile font outline\
Updated EltreumExecute nameplate style filter to automatically set the HP % based on class\
Updated Item Level coloring in Classic/TBC/Wrath to reflect the average Item Quality Color\
Updated Nameplate Player Class texture to be disabled if gradient nameplates are being used\
Updated Healer profile Boss Buff/Debuffs\
Updated Eltruism Role Icons\
Updated Character Panel Skin Ammo position to not overlap with Item Level Text\
Fixed Auto Adjust of Borders being enabled when borders were disabled during install\
Fixed Glyphs in Wrath showing some backgrounds\
Fixed Unitframes Health backdrop color\
Fixed Class Crest position in other panels
### 3.2.8
Added an option to change the font size on the Character Panel Skin\
Added an option to hide datatexts outside of combat and show them in combat\
Added alpha option to the Nameplate Power Bar background\
Updated Gradient Mode, finally solving the Gradient colors for Priest in light mode and making it more compatible with other ElvUI settings\
Updated Objective Tracker Skin to better skin World Quests and added a Gradient Bar to it like the others\
Updated WeakAuras Action Bar visibility and added a few checks to prevent errors\
Updated pet unitframe health configuration due to an ElvUI update\
Updated waypoint autopin to more reliably autopin in some scenarios\
Updated German translations by Dlarge\
Updated Action bar out of range color\
Fixed health backdrop alpha in light mode\
Fixed Talking Head not correctly hiding in some situations\
Fixed profile not applying when spec specific profiles were selected
### 3.2.7
Added an option in Eltruism > Media to make the actionbars and power similar to a WeakAura, a command (/eltruism weakauras) was also added\
Added an option to move the cursor anchor using offsets\
Added an option to enable/disable the class colored modifier keys on action bars\
Added a button in Eltruism > Installer to rerun the Database Check and improved the version check\
Added new media, "Oh no no no"\
Updated Character Panel Skin, allow more settings to be independent and also improved compatibility with Shadow and Light armory and Deja Character Stats\
Updated Expanded Talents for Classic/TBC/Wrath, which will now better use the background art\
Updated the Chat Color System messages to better detect messages in other languages than English\
Updated German locale by Dlarge\
Updated Nameplate Style filter for Explosives, now forcing it to have full Alpha and higher Priority\
Updated Quest Items Bar in Retail to more reliably detect quest items\
Fixed Pet Name in Wrath not correctly replacing fonts\
Fixed a possible error if trying to open the game menu while in combat\
Fixed Other stats in Character Panel skin sometimes not being correctly positioned\
Fixed an error with Style Filters
### 3.2.6
Added an option to toggle off gradient texts on character panel skin and use class color instead\
Added a black background option to expanded art in character panel skin\
Updated the item quality texture size to not overlap when not using the character panel skin\
Updated some character skin options to work without expanded art/panel\
Fixed Cooldown's Text To Speech option checking for Mail Text to Speech in order to enable/disable
### 3.2.5
Added models options, which will add models to Player, Pet, Target, Target of Target, Player Castbar and Target Castbar, these can be customized and changed to custom ones instead of being class based\
Added Cooldown, a fork of discoteq's Doom Cooldown Pulse, which will show an icon for skills that are coming of cooldown. This fork includes an option to play Text-To-Speech for the skill coming of cooldown\
Added Text-To-Speech option to Mail sound\
Added an option to change the nameplate overlap whenever entering rested areas, and setting them to normal values once leaving\
Added and updated movers to a new Eltruism category, making it easier to see frames from Eltruism\
Added option to automatically adjust the portrait of the target based on it being a creature or a player\
Added an option to hide the cooldown swipe on nameplates buffs and debuffs\
Added a compatibility check to fix a possible issue with MerathilisUI\
Added a class color to modifier keys (Alt,Shift,Ctrl and so on) on ActionBars\
Updated Inspect Skin making the frame a bit wider as to not overlap as much information, for Retail moved the Item Level text and Dressing Room, for TBC/Wrath an expanded talents skin was also added\
Updated German locale by Dlarge\
Updated Character Panel skin to use more gradients and to use custom gradients it they are enabled\
Updated Custom Nameplate Height function to more reliably detect units that are in combat\
Updated the Database, which will make the Database Converter run and move settings to their new locations, a reload is necessary to save settings. (Thank you Repooc!)\
Fixed an issue with the Loot Screenshot option missing\
Fixed NPCs incorrectly using custom gradient castbars when the custom option was disabled\
Fixed duplicate items in Quest Item Bar and made its position detection better\
Fixed backdrop alpha in some scenarios\
Fixed a possible error with the AFK screen\
Fixed a typo on the combatindicator tag\
Fixed Light mode not using correct textures\
Fixed Class Icon for Focus in Light/Dark Modes\
Fixed Explosives in M+ not using normal nameplate heights\
Fixed PvP Season History check position for Character Skin in Classic/TBC\
Fixed an issue with the Error frame option toggling the Zone option for Skins\
Fixed a missing option for the Character Panel art in Classic/TBC/Wrath\
Fixed some colors in Gradient Mode being incorrect due to an alpha being supplied
Fixed Borders not toggling on and off during install\
Fixed Classic Skill Glows not working
### 3.2.4
Added an option to have enemies that are not engaged in combat or not targeted to have thinner nameplate healthbars, and to use ElvUI's settings or custom settings when they are engaged in combat or targeted\
Added an option to have the target's model show up on the target nameplate\
Added Shadows to Quest Item Bar\
Added support to Blinkii's mMediaTag Interrupt Castbar feature while in Gradient mode\
Added an option to use the combat font for Loot Text instead of the ElvUi general font\
Added options to play a sound when an item from the Wishlist is looted\
Added a mover to the Loot Wishlist\
Added an Effect to Nameplate Power Bar, default disabled but enabled on profile install\
Updated for 9.2.7\
Updated the function that disables Blizzard's Combat text to more reliably only disable if the option was enabled\
Updated the Dungeon/Scenario Block to be more centered\
Updated focus name to use the same format as player and target\
Updated nameplate profile to include some missing settings for nameplate width and height\
Updated german locale by Dlarge\
Updated the entering/leaving combat indicators to not need LootText enabled\
Updated Gradient Nameplates to also make Nameplate Style Filters slightly gradient\
Updated EltreumTarget filter to have a lower priority in order to allow other filters to overwrite it\
Updated Hostile NPC, Hunter and Monk default gradient colors\
Updated Quest Item Bar, which should now more correctly identify usable quest items\
Updated Quest Item Bar Mover, which will now more correctly center itself, no longer misaligning\
Updated MeetingHorn skin to not keep listening for MeetingHorn if the addon is disabled\
Updated Classic/TBC QuestWatch frame skin to add the Header bar from Wrath\
Fixed UnitFrame Fill Orientation in darkmode\
Fixed Enchanting and Profession Skin in TBC/Classic/Wrath not correctly working with the Mouse Wheel\
Fixed Shaman Totem border/shadow loading on TBC PTR\
Fixed Nameplate Gradient Colors sometimes not working with Style Filters\
Fixed a possible error with custom unitframe textures\
Fixed missing castbar custom color in gradient mode\
Fixed a possible error when applying fonts without some of Eltruism's Custom Texts being imported\
Fixed Healer layout missing auto adjusting borders for the pet bar\
Fixed Boss and Arena missing gradients after the gradient rework\
Fixed Target of Target of Target gradient/custom textures\
Fixed Chat fade options not working when Chat was transparent\
Fixed Combat Indicator icon overlapping with name or absorbs in some situations by moving it in the profiles
___
### 3.2.3
Added an option to change Fill Direction of Unitframes\
Fixed an error in Version Check\
Fixed an issue with Custom Textures not correctly applying Textures
___
### 3.2.2
Added Gradient Nameplates and moved some options to a new Gradient Colors option, Gradient Nameplates uses the same colors as Unitframe Gradients so changing colors there will change for both\
Added an option to disable the Eltruism logo while AFK\
Added an option to limit the max distance for the Waypoint Time to Arrive\
Added an option to change the color of the Waypoint and Time To Arrive texts\
Updated ElvUI profiles to use non transparent power since transparent power does not use the texture, also small adjustments to some text positions\
Updated Gradient function, making it use less memory and CPU and allowing light mode to use backdrop alpha, same as dark mode\
Updated backdrop alpha, adding option to hide the backdrop to give unitframes a truly transparent background\
Updated reaction detection, fixing unfriendly npcs\
Updated automatic screenshot to also screenshot achievements in Wrath Beta\
Updated Quest/Objective skin in Retail to be more similar to the Wrath Beta skin\
Updated talent change detection in Wrath Beta, preparing for dual spec ElvUI\
Updated custom textures, adding textures and options for Tapped Units\
Updated EltreumStatus and EltreumHealth custom texts, mostly disabling EltreumStatus and using [eltruism:hpstatusnopc] for EltreumHealth\
Fixed some combat text CVars not correctly applying during login, they should more reliably work now\
Fixed some missing role icons\
Fixed issues in Classic/TBC/Wrath Beta due to changes in ElvUI dev that are not yet released\
Fixed issues in Classic/TBC/Wrath Beta due to some units not existing on those versions\
Fixed an issue with gradient overwriting the tapped unit color by adding an option for gradient tapped units\
Fixed the chat not correctly embedding details in Classic/TBC\
Fixed points position in Craft Skin for Classic/TBC/Wrath\
Fixed Pet Background overlapping Pet Name/Title/Loyalty in TBC/Wrath
___
### 3.2.1
Added Inspect Average Ilvl to Classic/TBC/Wrath\
Added option to change the scale/size of the Character Panel\
Added an option to hide the Button/Key Press on Action Bars\
Added statusbar textures from Dragonflight\
Added more enchants to Classic/TBC/Wrath list\
Added option to change the Player Castbar Spark Texture\
Added [eltruism:lowmana{12}] tag (where 12 is 12% and can be changed), this tag will display nothing and will instead use the emote "OOM" for healers when they fall below that percentage of mana. Works in Retail and Wrath Beta\
Added [eltruism:lowhealth{12}] tag (where 12 is 12% and can be changed), this tag will display nothing and will instead use the emote "HEALME" when the player falls below the health percentage.\
Added [eltruism:hpstatusnopc{1,2}] tag where 1 is a dead texture and 2 is a disconnected texture that can be swapped up to 6 and are made by Releaf. This tag will not report health percentage like [eltruism:hpstatus] and will instead keep the shortvalue only\
Updated profile, changing tags to use [eltruism:hpstatus] and [eltruism:hpstatusnopc] and disabling EltreumStatus custom text for most unitframes.\
Updated EltreumRestedNP Nameplate Style Filter to hide the HP bar of enemies you cannot attack, such as when you are in a sanctuary or when you are unable to attack them\
Updated Wintools, Shadow and Light and ElvUI Floating Combat Text profiles\
Updated german locale by Dlarge\
Updated Eltruism Options to now be the same across versions, a future update is also planned to make it easier to change settings\
Updated some ElvUI profile settings, including new ElvUI Death Knight options\
Updated some Cursor functions to update/run when the options are changed and not require a reload, but a reload is still recommended\
Updated Cursor sizes to increase it slightly\
Fixed some style filters not correctly enabling after being disabled\
Fixed some fonts not correctly setting to outline in resolutions below 4k\
Fixed Retail version being 9.2.7 when 9.2.7 is not yet released\
Fixed Shadows for Power Bars and Class Bars when detached or non spaced\
Fixed Shield/OffHand Quality Texture position in Classic/TBC/Wrath\
Fixed Borders auto adjust not auto adjusting after a spec/profile change in Retail\
Fixed an Inventory is Full error message that could become spammy due to fast loot\
Fixed an issue with Nameplate Power Bar and Death Knights in Wrath Beta\
\
Note: all tags that use arguments such as [eltruism:lowmana{10}] will fail if they are used in conjunction with other tags that use arguments, so do not use more than one tag like that for the same text
___
### 3.2.0
Added [eltruism:combatindicator] tag, which will display the same icon used for Player Combat indicator as a tag for that unit, such as on other players showing their combat status\
Added more checks for settings being double enabled when they shouldn't and added more checks to prevent it from happening\
Updated Character Skin for all versions to become more similar, Classic/TBC/Wrath also have added character name color and icon to inspect, changed the size of the name text and made the reputation dropdown a mouseover\
Updated Character Stats to use general ElvUI font and Font Outline\
Updated german translations by Dlarge\
Updated profile update to only enable autoadjust if borders are clicked during install\
Updated Character Skin Expanded Art Race backgrounds to have higher resolution and better cropping, including on Inspect. Also added new backgrounds options\
Updated profile settings during install to use Race Backgrounds instead of Class Backgrounds\
Updated some style filter disable logic\
Updated default AFK music to be Class based in Retail\
Fixed Character Role Button overlapping some talent trees in Wrath Beta\
Fixed a wrong message during install when detecting addons enabled/disabled\
Fixed Character Skin Specialization not updating when changing specs in Wrath Beta\
Fixed Expanded Talents and Character Skin overlapping in some situations\
Fixed Role Button on Talents in Wrath Beta showing up in the Glyph Panel
___
### 3.1.9
Added Item Quality Textures to character/inspect panel when the character panel skin is enabled\
Added [eltruism:hp{number1,number2}] which will display current health in short value, and when the unit dies it will display an icon from number1, and if disconnected will display an icon from number2\
Added [eltruism:classcolor] which will color targets based on their class, but only for player characters\
Added ptBR translation\
Added FOV slider to Wrath (Beta)\
Added Border to Focus Castbar, alongside settings for it\
Added Heroic Raids to Wrath Beta Instance options\
Added Nameplate Classbar and Powerbar to Nameplate Shadows Options\
Added Borders to missing Temporary Buffs in Auras\
Added Custom and Racial Backgrounds for Character Panel Expanded Art and Inspect Skins, this is why the addon gained a few megabytes in size (does not impact in game size or load time)\
Updated some default textures\
Updated german localization by Dlarge\
Updated Shadows for Wrath Beta\
Updated pet frame castbar, debuff and buff settings\
Updated Nameplate Powerbar to allow smaller adjustments and fixed it not being pixel perfect because of this\
Updated cooldown sound to disable the error speech when enabled, so that the sounds dont stack together\
Updated Sockets to check for Belt Buckles since Wrath will have Belt Buckles\
Updated Classic/TBC/Wrath Class Icons on Character Panel to more correctly be placed next to the Character name\
Updated general Character Panel skin in Classic/TBC/Wrath, which will now only expand on the character panel, and not on other panels\
Updated nameplate debuffs and buffs in Classic/TBC/Wrath to use Fluid mode from ElvUI\
Updated ElvUI Nameplate StyleFilters for Classic/TBC/Wrath to enable ElvUI_Boss, which otherwise would not color some Boss type enemies like target dummies\
Fixed some debuff and buff offsets when using wide nameplate debuffs in Classic/TBC/Wrath\
Fixed some tags not being listed in Available Tags (they were working, just not listed)
___
### 3.1.8
Added an option to play a sound when attempting to use a spell while it is in cooldown, this option can be enabled in Eltruism > Cursor (Default disabled)\
Added EltreumStatus custom text, which will display symbols for the unit being dead or disconnected\
Added some Warcraft 3 sounds\
Added shadows to Shaman Totem Bar (Wrath) and to Pet Action Bar\
Added borders to Shaman Totem Bar (Wrath)\
Added borders to Stance Bar and Pet Action Bar, alongside options for it\
Added [eltruism:dead{x}] tag, where x is a number for the texture between 1 and 6, the texture will appear when the unit dies (textures by Releaf)\
Added [eltruism:dc{x}] tag, where x is a number for the texture between 1 and 6, the texture will appear when the unit disconnects (textures by Releaf)\
Added [eltruism:groupnumber] tag which will display the group number for the first member of that group only. Keep in mind that changing players groups can cause this tag to not correctly report which group the unit belongs to.\
Updated lootroll settings for Classic/TBC/Wrath\
Updated german localization by DLarge\
Updated spanish localization using DeepL and Google Translate, feedback is still welcome\
Updated Shaman Totem Bar layout movers and Objective Frame movers for Wrath\
Updated Nameplate Debuff glow to use the same type glow as action bars\
Fixed Wowhead button alignment in Wrath Beta\
Fixed Glyph frame having dual talent specialization buttons/info\
Fixed Death Knight's Runes not being affected by dark power setting in Wrath Beta\
Fixed Death Knight's gradient, light and dark modes since the class was not being detected in Wrath Beta\
Fixed castbar interrupt gradient coloring both castbars when it should not (fix by Blinkii)\
Fixed AddonSkins hiding wrong chat when Details profile is loaded (Wrath)\
Fixed Wrath's Expanded Talents overlapping with the dual spec buttons
___
### 3.1.7
Added EltreumTarget Nameplate Filter, which will be used instead of ElvUI_Target\
Added [eltruism:presence] tag, which will display the Death Knight's presence in Classic Wrath (Beta)\
Added Questie, Details and DBM profiles to Wrath Beta, which are currently working\
Updated auto adjust to prevent some scenarios where it would activate\
Fixed LootText error when looting some currencies/items\
Fixed [eltruism:smartlevel] in Classic\
Fixed in game navigation being forced on in Retail
___
### 3.1.6
Added support for Wrath of the Lich King Classic Beta\
Added [eltruism:smartlevel] tag which show level the difference when it exists for NPCs and players but hide for players if they are the same level\
Updated auto adjust borders to not enforce class colored borders\
Updated german translations by Dlarge\
Updated gradient castbar colors for non interruptible spells\
Updated Class Colors for castbars, which now prevents Custom Colors for castbars\
Updated Item Levels in Inspect Frame, which now should be faster and more reliable\
Updated shaman totem glow colors\
Fixed gradient castbar colors now properly applying\
Fixed NPC castbars having NPC colors, which could become confusing (thank you Blinkii)\
Updated ProjectAzilroka profile, enabling Moveable Frames by default\
Fixed improperly named texture during install\
Fixed ElvUI_Target nameplate filter having borders forced off if Eltruism nameplate settings were turned off\
Fixed Automatically Closing Loot Window being enabled by default instead of disabled\
Fixed Vehicle Leave Button overlapping tracking options in TBC/Classic
___
### 3.1.5
Fixed an error with boss borders
___
### 3.1.4
Added more border size options\
Added gradient to player and target castbars when non interruptable\
Added gradient to player and target castbars when interrupted\
Added gradient and custom texture to Target of Target of Target\
Added minimap border options to adjust its size\
Added pet border options to adjust its size\
Added V3 statusbar textures by Blinkii\
Updated the nameplate debuff glow function and added an option to customize the timer\
Updated install, adding borders and making Light/Dark a toggle\
Updated gradient chat command to be a toggle, typing it while gradient is active will disable gradient\
Updated gradient function, splitting player and target castbars\
Updated some shadows to not apply when borders are enabled since borders would hide them\
Updated borders function to update without a reload\
Updated borders to check for ElvUI Action Bar Masks being loaded\
Updated auto adjust borders function to apply when changing specs in retail if the profiles are both from Eltruism\
Fixed target class statusbar textures options in nameplates, which was applying player class instead of target\
Fixed an issue where auto adjusting borders would not load with Eltruism profiles\
Fixed an issue where borders could sometimes not be centered correctly on Player/Target unitframes\
Fixed player and target castbar borders on different types of cast attachment\
Fixed aura borders overlapping the timer text
___
### 3.1.3
Added more frames that can have borders, including auras, chat, raid, party, focus, boss and other frames\
Added a warning when ElvUI is out of date during install\
Updated border auto adjust functions, which will now only adjust when using Eltruism profiles
Updated border auto adjust to adjust more settings\
Updated translations by Dlarge\
Updated Warrior Class Panel gradient colors in order to improve readability\
Updated some v2 Statusbar textures\
Fixed some borders overlapping some windows\
Fixed spam messages from Delete Item\
Fixed chat shadows when using dark mode chat\
Fixed Priest Gradient not working correctly\
Fixed Classic and TBC showing options for classes that don't exist in these versions
___
### 3.1.2
Added more statusbar textures for classes\
Added options to use a different version of the statusbar textures for nameplates and light mode\
Added an option to automatically apply custom textures based on the class/reaction\
Updated some labeling related to unitframes\
Updated install process, changing fonts to be after Eltruism modes\
Updated default textures to use version 2 in light mode and nameplates\
Fixed an error when skipping install due to custom texts not being set\
Fixed the positioning of the more skins option in TBC\
Further improved the performance of gradient/unitframe functions
___
### 3.1.1
Added an option for the experience databar to have gradient coloring\
Added borders to minimap and pet unitframe\
Added the [eltruism:difficulty:all] tag, which will color all units and not just enemies\
Improved Gradient functions, which should use less CPU time\
Updated German translation by DLarge\
Updated the hide talking head function\
Updated general profile textures\
Updated Install process and added a new page for addon profiles\
Updated the labeling in Eltruism > Install, where Reset/Update can be used to update Eltruism settings to the current version if using an old install\
Updated WarpDeplete/BattlegroundEnemies/Capping installation\
Updated the quest npc ignore, adding the darkmoon teleport\
Updated the position of the microbar in the DPS profile\
Fixed tabs in Unitframes not being disabled when they should be\
Fixed a possible error when leveling in combat\
Fixed an error with the quest items bar when an item that could be equipped was detected as a quest item\
Fixed transparency in an extra details texture\
Fixed debuff alignment for the pet unitframe\
Fixed border colors not updating when changing zones\
Fixed a possible border error when changing profiles or specializations\
Fixed gradient target castbar not using correct colors when custom colors were changed\
Removed options to load extra media, media will now be loaded by default since ElvUI/WeakAuras fixed the Sharedmedia issue
___
### 3.1.0
Enabled gradient castbar option for Player and Target castbars when using Eltruism profiles\
Added a CVar option to change Field of Vision in Retail\
Fixed castbar gradient colors for interrupts and non interruptible spells\
Fixed chat loot icons not being disabled when chat options were disabled\
Fixed Minimap shadow depending on datatext settings\
Fixed Minimap shadow when using rectangle minimap options from Shadow and Light or Windtools\
Fixed shadows when using 2D portraits\
Removed some unused files
___
### 3.0.9
Added a button during install to swap the background color to a greyer color instead of black\
Added a reload prompt to the action paging swap between Bar1 and Bar4 due to the paging not switching without a reload\
Fixed an error due to a database change in Windtools during install when Windtools was loaded
___
### 3.0.8
Added [eltruism:shortclassification] tag, which displays the difficulty of an enemy in simple letters such as R and R+ for rare and rare elite\
Added partial Chinese localization by Neo\
Added a Skin for MeetingHorn\
Skinned IME frame in some locales\
Fixed the [eltruism:difficulty] tag improperly coloring enemies\
Fixed the minimap shadow being created when ElvUI's minimap module was disabled\
Fixed the EltruismConsumablesWA anchor incorrectly resetting during login\
Updated some profiles to check for the addon being enabled before attempting to apply a profile\
Updated ElvUI nameplate debuff duration detection for the duration glow to activate in 9.2.5\
Updated German translation by Dlarge
___
### 3.0.7
Fixed a possible error when importing Dynamic Status Icons and Capping profiles\
Fixed an error during install due to a database change in Windtools
___
### 3.0.6
Added  tooltip header font setting due to ElvUI update\
Added Eltruism's logo to the options list\
Added new media, including fonts and sounds\
Updated Windtools profile and Shadow and Light profile due to new features introduced in Windtools\
Updated German translations by Dlarge
___
### 3.0.5
Added an option to disable tracking of pet cooldowns on the cursor, default disabled\
Updated arena gradients\
Updated Battle Res frame detection\
Updated default party frame visibility\
Updated nameplate castbar text position\
Updated paladin gradient on character panel skin\
Updated player unitframe power strata in order for its shadow to match target uf shadow\
Updated quest Skin while Shadow and Light is loaded\
Updated the character panel skin lines, making them align a bit better in other locales\
Updated the skip install button to also skip plugin profiles message\
Updated the Shaman and Hunter stat gradients on the character panel skin and used these new colors as the default for custom gradients\
Fixed an error with the character panel skin stats related to ranged stats in TBC/Classic\
Disabled arena frames in BattlegroundEnemies profile\
Removed Party Leader Icon Size option since ElvUI now has a scale option that fulfills the same role
___
### 3.0.4
Added gradient to Boss frames 6, 7 and 8 for Retail\
Added shadows to ElvUI Arena frames\
Added gradients to ElvUI Arena frames\
Updated boss buffs and castbar placement\
Fixed missing gradients on the character panel when using Shadow and Light's Armory mode\
Fixed expanded talents not applying when other addons loaded Blizzard's Talent UI before Eltruism was loaded in TBC/Classic\
Disabled using level in ElvUI nameplates to show target of casts since ElvUI now has an option to show the target in its castbar option
___
### 3.0.3
Fixed Nameplate Buffs and Debuffs border by type not being colored when the ElvUI option was enabled\
Fixed Minimap shadows when Rectangle Minimap was enabled in Shadow and Light or Windtools
___
### 3.0.2
Added gradient to target castbar\
Updated target castbar shadows\
Updated the target tag\
Updated Boss unitframe for the new ElvUI amount of boss units\
Fixed Mail sound being enabled by default when it should be disabled by default\
Fixed an error with the Eltruism Game Menu Button
___
### 3.0.1
Added an option to enable or disable the stat gradients\
Updated Borders class color option to use target and target of target's class and reaction to color the border\
Fixed Character Panel Skin compatibility with Deja Character Stats\
Fixed Character Panel Skin not being correctly sized on other languages
___
### 3.0.0
Added gradient class colors to the character stats panel in the character frame\
Added an option to change the progress bar in the objective frame for Retail\
Added WarpDeplete profile\
Updated player and target castbar shadows detection\
Updated German translations by Dlarge\
Fixed an issue with the mail text font for TBC\
Fixed Battle Ressurection Count/Countdown\
Fixed mail sound playing twice\
Fixed an error with the objective frame skin when ElvUI's skin was disabled\
Fixed an error with the Eltruism Game Menu Button
___
### 2.9.9
Added a Battle Resurrection frame that shows the count and cooldown for battle resurrection when in a party/raid that has the count system in Retail\
Added a check for item existing to chat icons\
Added a second weakaura anchor (EltruismWA2) in case more Weakauras need anchoring\
Added compatibility with TomTom by renaming the commands to /eway and /ewaypoint when TomTom is loaded\
Added a mail sound that can be enabled and customized in Eltruism > Misc\
Added Eltruism button to the game menu, which can be enabled in Eltruism > Misc\
Updated the Enemy Nameplate Level function to show enemy target for spellcasts when max level, and level when the player is not max level\
Updated Details Spec/Blizzard Icons (Details profile v1)\
Updated default ElvUI Arena Frames\
Updated the Hide Raid Unitframes in battlegrounds function to also hide party frames if GladiusEX is loaded in retail since the GladiusEX profile now uses party frames and they show more information than ElvUI party frames\
Updated the target casting tags to better detected when casting and colorize when the target is an NPC according to the player's reaction to the target\
Updated Quest Skins compatibility with Shadow and Light\
Updated the role icon in chat to also show when WindTools is not loaded\
Updated Healer profile\
Fixed !keys not linking in guild chat when not in a party\
Fixed Expanded Stable
___
### 2.9.8
Added BattleGroundEnemies profile for Retail, this profile can be found in Eltruism > Addons\
Added several checks before applying shadows and fixed errors when ElvUI Blizzard Skin was disabled\
Updated Eltruism profile gradient texture to Asphyxia-Norm, this setting is only applied when installing a profile\
Updated NameplateSCT profile damage offset, making it not overlap with buffs/debuffs\
Updated Raid/Raid40 DPS Unitframes, along with Original and Alternative layouts for those frames\
Fixed Close button on Expanded Talents for TBC/Classic\
Fixed a possible error when deleting battle pets\
Fixed a possible double icon when deleting items\
Fixed a possible error when reloading during a boss fight\
Fixed healer layout target and target of target power position and settings
___
### 2.9.7
Added gradient to pet frame\
Added a custom Dark Souls text death animation, replacing the YOU DIED text with anything the user inputs\
Updated resolution detection and font weight functions, with some fonts like player name now more reliably applying the correct outline and not applying thickoutline in cases where it shouldn't\
Updated player/target buff/debuff count/duration text position to avoid overlapping with actionbars and other buffs/debuffs\
Updated Leader Indicator size and moved it to the Unitframes section\
Updated Power Prediction on Nameplate Power Bar to make it blend less with Shadow Priest Insanity Power\
Updated Retail GladiusEX profile\
Fixed Tank and Assist frames not applying priest texture in gradient mode while using light mode\
Fixed a possible error in Dark Mode when applying Gradient Texture\
Fixed a rare error on automatic accept/turn in quests where npc's GUID returned nil
___
### 2.9.6
Added Spell Haste datatext for TBC/Classic\
Added priest gradients to dark mode\
Added priest texture in gradient mode while in light mode\
Updated gradient unit options, splitting player, target, target of target, focus and boss into different options\
Updated default gradient colors for some classes\
Updated cursor cooldown to prevent some low cd skills from spamming\
Updated AFK music to prevent overwriting the game's music setting\
Updated Instance text to hide in some locations, such as garrisons\
Fixed some gradient healthbars not applying correctly due to a missing alpha\
Fixed Player and Target castbar shadows\
Fixed missing Mage class crest in character panel skin\
Fixed power bar prediction coloring not applying correctly\
Further improved detection of item level in chat item links
___
### 2.9.5
Added custom gradient colors to NPCs\
Updated alternative unitframes layout positions\
Updated alternative unitframes option and moved it to Unitframes section\
Fixed Chat Item Levels not showing for items that were not in the player's inventory\
Fixed Guild logo showing when Instance Text was enabled\
Fixed Tank and Assist frames gradient\
Removed the aura filters import for Shadowlands as it was outdated and similar to baseline ElvUI
___
### 2.9.4
Updated Light/Dark Mode to not disable gradient mode when applying\
Fixed Raid Frame detection for TBC/Classic\
Fixed a scenario where light mode and dark mode could be active at the same time, preventing both from working\
Removed the confirmation prompt from the apply button for Light/Dark Mode
___
### 2.9.3
Added gradient to dark mode, making backdrops have gradient colors\
Updated Media, which was split into Media and Unitframes, with unitframes being moved into the new Unitframes menu making it clearer when an option cannot be enabled because another one is enabled\
Updated default Mage gradient colors\
Updated spanish translation using deepL\
Updated chat loot icon by trimming the borders\
Fixed Method Raid Tools profile installation due to a change in MRT's internal profile structure\
Fixed Eltruism Config datatext not showing for some classes in TBC/Classic\
Removed a duplicate world text size in TBC/Classic
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
___
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
