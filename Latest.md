### 3.2.1 [Complete Changelog](https://github.com/eltreum0/eltruism/blob/main/Changelog.md)
___
Added Inspect Average Ilvl to Classic/TBC/Wrath\
Added option to change the scale/size of the Character Panel\
Added an option to hide the Button/Key Press on Action Bars\
Added statusbar textures from Dragonflight\
Added more enchants to Classic/TBC/Wrath list\
Added option to change the Player Castbar Spark Texture\
Added [eltruism:lowmana{12}] tag (where 12 is 12% and can be changed), this tag will display nothing and will instead use the emote "OOM" for healers when they fall below that percentage of mana. Works in Retail and Wrath Beta\
Added [eltruism:lowhealth{12}] tag (where 12 is 12% and can be changed), this tag will display nothing and will instead use the emote "HEALME" when the player falls below the health percentage.\
Added [eltruism:hpstatusnopc{1,2}] tag where 1 is a dead texture and 2 is a disconnected texture that can be swapped up to 6 and are made by Releaf. This tag will not report health percentage like [eltruism:hpstatus] and will instead keep the shortvalue only\
Updated profile, changing tags to use [eltruism:hpstatus] and [eltruism:hpstatusnopc] and disabling EltreumStatus custom text for most unitframes.
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
