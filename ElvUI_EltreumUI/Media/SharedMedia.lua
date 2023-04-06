local E, L, V, P, G = unpack(ElvUI)
local _G = _G
local LSM = E.Libs.LSM

-- Statusbar

LSM:Register("statusbar", "Asphyxia-Norm", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\AsphyxiaNorm.tga]])

LSM:Register("statusbar", "Eltreum-Class-DeathKnight", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-DK.tga]])
LSM:Register("statusbar", "Eltreum-Class-DeathKnightV2", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-DKv2.tga]])
LSM:Register("statusbar", "Eltreum-Class-DemonHunter", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-DH.tga]])
LSM:Register("statusbar", "Eltreum-Class-DemonHunterV2", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-DHv2.tga]])
LSM:Register("statusbar", "Eltreum-Class-Druid", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-DR.tga]])
LSM:Register("statusbar", "Eltreum-Class-DruidV2", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-DRv2.tga]])
LSM:Register("statusbar", "Eltreum-Class-Hunter", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-HT.tga]])
LSM:Register("statusbar", "Eltreum-Class-HunterV2", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-HTv2.tga]])
LSM:Register("statusbar", "Eltreum-Class-Mage", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-MG.tga]])
LSM:Register("statusbar", "Eltreum-Class-MageV2", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-MGv2.tga]])
LSM:Register("statusbar", "Eltreum-Class-Monk", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-MK.tga]])
LSM:Register("statusbar", "Eltreum-Class-MonkV2", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-MKv2.tga]])
LSM:Register("statusbar", "Eltreum-Class-Paladin", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-PL.tga]])
LSM:Register("statusbar", "Eltreum-Class-PaladinV2", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-PLv2.tga]])
LSM:Register("statusbar", "Eltreum-Class-Priest", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-PR.tga]])
LSM:Register("statusbar", "Eltreum-Class-PriestV2", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-PRv2.tga]])
LSM:Register("statusbar", "Eltreum-Class-Rogue", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-RG.tga]])
LSM:Register("statusbar", "Eltreum-Class-RogueV2", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-RGv2.tga]])
LSM:Register("statusbar", "Eltreum-Class-Shaman", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-SH.tga]])
LSM:Register("statusbar", "Eltreum-Class-ShamanV2", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-SHv2.tga]])
LSM:Register("statusbar", "Eltreum-Class-Warrior", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-WA.tga]])
LSM:Register("statusbar", "Eltreum-Class-WarriorV2", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-WAv2.tga]])
LSM:Register("statusbar", "Eltreum-Class-Warlock", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-WL.tga]])
LSM:Register("statusbar", "Eltreum-Class-WarlockV2", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-WLv2.tga]])
LSM:Register("statusbar", "Eltreum-Class-DeathKnightV3", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-DKV3.tga]])
LSM:Register("statusbar", "Eltreum-Class-DemonHunterV3", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-DHV3.tga]])
LSM:Register("statusbar", "Eltreum-Class-DruidV3", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-DRV3.tga]])
LSM:Register("statusbar", "Eltreum-Class-HunterV3", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-HTV3.tga]])
LSM:Register("statusbar", "Eltreum-Class-MageV3", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-MGV3.tga]])
LSM:Register("statusbar", "Eltreum-Class-MonkV3", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-MKV3.tga]])
LSM:Register("statusbar", "Eltreum-Class-PaladinV3", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-PLV3.tga]])
LSM:Register("statusbar", "Eltreum-Class-PriestV3", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-PRV3.tga]])
LSM:Register("statusbar", "Eltreum-Class-RogueV3", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-RGV3.tga]])
LSM:Register("statusbar", "Eltreum-Class-ShamanV3", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-SHV3.tga]])
LSM:Register("statusbar", "Eltreum-Class-WarriorV3", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-WAV3.tga]])
LSM:Register("statusbar", "Eltreum-Class-WarlockV3", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-WLV3.tga]])
LSM:Register("statusbar", "Eltreum-Class-Evoker", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-EV.tga]])
LSM:Register("statusbar", "Eltreum-Class-EvokerV2", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-EVv2.tga]])
LSM:Register("statusbar", "Eltreum-Class-EvokerV3", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-EVV3.tga]])
LSM:Register("statusbar", "None", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\None.tga]])

LSM:Register("statusbar", "Eltreum-Tapped", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-Tapped.tga]])
LSM:Register("statusbar", "Eltreum-TappedV2", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-TappedV2.tga]])
LSM:Register("statusbar", "Eltreum-TappedV3", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-TappedV3.tga]])

LSM:Register("statusbar", "Eltreum-bottom", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-bottom.tga]])
LSM:Register("statusbar", "Eltreum-left", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-left.tga]])
LSM:Register("statusbar", "Eltreum-right", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-right.tga]])
LSM:Register("statusbar", "Eltreum-top", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-top.tga]])

LSM:Register("statusbar", "Eltreum1pixel", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum1pixel.tga]])
LSM:Register("statusbar", "Eltreum2pixel", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum2pixel.tga]])
LSM:Register("statusbar", "Eltreum3pixel", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum3pixel.tga]])
LSM:Register("statusbar", "Eltreum4pixel", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum4pixel.tga]])
LSM:Register("statusbar", "Eltreum5pixel", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum5pixel.tga]])
LSM:Register("statusbar", "Eltreum6pixel", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum6pixel.tga]])
LSM:Register("statusbar", "Eltreum7pixel", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum7pixel.tga]])
LSM:Register("statusbar", "Eltreum7pixelB", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum7pixelB.tga]])
LSM:Register("statusbar", "Eltreum8pixel", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum8pixel.tga]])
LSM:Register("statusbar", "Eltreum9pixel", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum9pixel.tga]])
LSM:Register("statusbar", "Eltreum10pixel", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum10pixel.tga]])

LSM:Register("statusbar", "Eltreum-Stripes", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-Stripes.tga]])
LSM:Register("statusbar", "Eltreum-Stripes2", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-Stripes2.tga]])
LSM:Register("statusbar", "Eltreum-Stripes3", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-Stripes3.tga]])
LSM:Register("statusbar", "Eltreum-Stripes4", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-Stripes4.tga]])
LSM:Register("statusbar", "Eltreum-Blank", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-Blank.tga]])
LSM:Register("statusbar", "Eltreum-Elvui-Norm", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-Elvui-Norm.tga]])
LSM:Register("statusbar", "Eltreum-Dark", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-Dark.tga]])
LSM:Register("statusbar", "Eltreum-20%", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-20pc.tga]])
LSM:Register("statusbar", "Eltreum-30%", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-30pc.tga]])
LSM:Register("statusbar", "Eltreum-Fade", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\EltreumFade.tga]])
LSM:Register("statusbar", "Eltreum-Transparent", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Eltreum-Transparent.tga]])

--from dragonflight/10.0
LSM:Register("statusbar", "Dragonflight01", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Dragonflight01.tga]])
LSM:Register("statusbar", "Dragonflight02", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Dragonflight02.tga]])
LSM:Register("statusbar", "Dragonflight03", [[Interface\Addons\ElvUI_EltreumUI\Media\Statusbar\Dragonflight03.tga]])

-- Fonts
LSM:Register("font", "Exo2 Extra Bold", [[Interface\Addons\ElvUI_EltreumUI\Media\Fonts\Exo2-ExtraBold.ttf]])
LSM:Register("font", "GothamNarrow Black", [[Interface\Addons\ElvUI_EltreumUI\Media\Fonts\GothamNarrowBlack.ttf]])
LSM:Register('font', "Kimberley", [[Interface\AddOns\ElvUI_EltreumUI\Media\Fonts\Kimberley.ttf]])
LSM:Register("font", "Roboto", [[Interface\Addons\ElvUI_EltreumUI\Media\Fonts\Roboto-Bold.ttf]])
LSM:Register("font", "Pepsi-Cyr-Lat", [[Interface\Addons\ElvUI_EltreumUI\Media\Fonts\Pepsi-Cyr-Lat.ttf]])
LSM:Register("font", "Noto Sans", [[Interface\Addons\ElvUI_EltreumUI\Media\Fonts\NotoSans-Regular.ttf]])
LSM:Register("font", "Inter", [[Interface\Addons\ElvUI_EltreumUI\Media\Fonts\Inter-SemiBold.ttf]])
LSM:Register("font", "Good Brush", [[Interface\Addons\ElvUI_EltreumUI\Media\Fonts\GoodBrush.ttf]])
LSM:Register("font", "GothamXNarrow Black", [[Interface\Addons\ElvUI_EltreumUI\Media\Fonts\GothamXNarrowBlack.ttf]])
LSM:Register("font", "JosefinSans-Bold", [[Interface\Addons\ElvUI_EltreumUI\Media\Fonts\JosefinSans-Bold.ttf]])
LSM:Register("font", "Neuropol", [[Interface\Addons\ElvUI_EltreumUI\Media\Fonts\neuropolxrg.ttf]])
LSM:Register("font", "OptimusPrinceps", [[Interface\Addons\ElvUI_EltreumUI\Media\Fonts\OptimusPrinceps.ttf]])
LSM:Register("font", "Pricedown", [[Interface\Addons\ElvUI_EltreumUI\Media\Fonts\pricedown.ttf]])
LSM:Register("font", "Reckoner", [[Interface\Addons\ElvUI_EltreumUI\Media\Fonts\Reckoner.ttf]])
LSM:Register("font", "Reckoner Bold", [[Interface\Addons\ElvUI_EltreumUI\Media\Fonts\Reckoner_Bold.ttf]])

-- Sound
LSM:Register("sound", "bruh", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\bruh.ogg]])
LSM:Register("sound", "Frankly thats a skill issue", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\ionskillissue.ogg]])
LSM:Register("sound", "! - Metal Gear Solid", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\metalgear.ogg]])
LSM:Register("sound", "Interface-10", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\Interface-sound-10.ogg]])
LSM:Register("sound", "You_Died", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\You_Died.ogg]])
LSM:Register("sound", "Todd Horward - It just works", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\Itjustworks.ogg]])
LSM:Register("sound", "Will Smith - Ah ahaha", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\WillSmith-Ahaha.ogg]])
LSM:Register("sound", "Will Smith - Rewind", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\WillSmith-Rewind-Long.ogg]])
LSM:Register("sound", "Will Smith - That's Hot", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\WillSmith-Thats-hot.ogg]])
LSM:Register("sound", "Oof", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\oof.ogg]])
LSM:Register("sound", "This is no time for caution", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\caution.ogg]])
LSM:Register("sound", "Its not Possible", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\necessary.ogg]])
LSM:Register("sound", "We are too late", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\Weretoolate.ogg]])
LSM:Register("sound", "Shame", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\shame.ogg]])
LSM:Register("sound", "Queen Azshara - What a shame", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\QueenAzsharaWhatAShame.ogg]])
LSM:Register("sound", "Queen Azshara - How disappointing", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\QueenAzsharaDissapointing.ogg]])
LSM:Register("sound", "Wow", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\wow.ogg]])
LSM:Register("sound", "GTA - Wasted", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\wasted.ogg]])
LSM:Register("sound", "GTA2 - Wasted", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\wasted2.ogg]])
LSM:Register("sound", "Mario Game Over", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\mariodeath.ogg]])
LSM:Register("sound", "Xera", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\xera.ogg]])
LSM:Register("sound", "Mission Failed", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\codmissionfailed.ogg]])
LSM:Register("sound", "Boomerang-1", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\boomerang.ogg]])
LSM:Register("sound", "Rules of Nature", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\Rules-of-Nature.ogg]])
LSM:Register("sound", "Oh no no no", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\ohnonono.ogg]])
LSM:Register("sound", "Dispel Illusion", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\DispelIllusion.ogg]])
LSM:Register("sound", "Withered Run Away", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\Withered.ogg]])
LSM:Register("sound", "Overwatch - Death", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\OverwatchDeath.ogg]])

--Warcraft 3 sounds
LSM:Register("sound", "Warcraft 3 - Night Elf Ally Dies", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\WC3NightElfAllyHeroDies.ogg]])
LSM:Register("sound", "Warcraft 3 - Night Elf Hero Dies", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\WC3NightElfHeroDies.ogg]])
LSM:Register("sound", "Warcraft 3 - Night Elf Unit Attack", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\WC3NightElfUnitAttack.ogg]])
LSM:Register("sound", "Warcraft 3 - Human Hero Dies", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\WC3HumanHeroDies.ogg]])
LSM:Register("sound", "Warcraft 3 - Human Ally Dies", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\WC3HumanAllyHeroDies.ogg]])
LSM:Register("sound", "Warcraft 3 - Naga Ally Dies", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\WC3NagaAllyHeroDies.ogg]])
LSM:Register("sound", "Warcraft 3 - Naga Hero Dies", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\WC3NagaHeroDies.ogg]])
LSM:Register("sound", "Warcraft 3 - Naga Unit Attack", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\WC3NagaUnitAttack.ogg]])
LSM:Register("sound", "Warcraft 3 - Orc Ally Dies", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\WC3OrcAllyHeroDies.ogg]])
LSM:Register("sound", "Warcraft 3 - Orc Hero Dies", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\WC3OrcHeroDies.ogg]])
LSM:Register("sound", "Warcraft 3 - Undead Ally Dies", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\WC3UndeadAllyHeroDies.ogg]])
LSM:Register("sound", "Warcraft 3 - Undead Under Attack", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\WC3UndeadUnderAttack.ogg]])
LSM:Register("sound", "Warcraft 3 - Undead Hero Dies", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\WC3UndeadHeroDies.ogg]])
LSM:Register("sound", "Warcraft 3 - Undead Unit Attack", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\WC3UndeadUnitAttack.ogg]])
LSM:Register("sound", "Warcraft 3 - Blademaster Excellent Choice", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\WC3Blademaster.ogg]])
LSM:Register("sound", "Warcraft 3 - Blademaster Twinblade ", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\WC3BlademasterTwinblade.ogg]])
LSM:Register("sound", "Warcraft 3 - Rokhan Hear", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\WC3RokhanHear.ogg]])
LSM:Register("sound", "Warcraft 3 - Rokhan Be Happy", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\WC3RokhanBeHappy.ogg]])
LSM:Register("sound", "Warcraft 3 - Rokhan Feel", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\WC3RokhanFeel.ogg]])
LSM:Register("sound", "Warcraft 3 - Taz'dingo", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\WC3RokhanTazdingo.ogg]])
LSM:Register("sound", "Durumu - Wipe", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\DurumuWipe.ogg]])
LSM:Register("sound", "AmanThul - Wipe", [[Interface\Addons\ElvUI_EltreumUI\Media\Sound\AmanThulWipe.ogg]])

-- Border
LSM:Register("border", "Eltreum-Border-1", [[Interface\Addons\ElvUI_EltreumUI\Media\border\Eltreum-Border-1.tga]])
LSM:Register("border", "Eltreum-Border-2", [[Interface\Addons\ElvUI_EltreumUI\Media\border\Eltreum-Border-2.tga]])
LSM:Register("border", "RenaitreBeveled10", [[Interface\Addons\ElvUI_EltreumUI\Media\border\RenaitreBeveled10.tga]])
LSM:Register("border", "RenaitreBeveled10x", [[Interface\Addons\ElvUI_EltreumUI\Media\border\RenaitreBeveled10x.tga]])
LSM:Register("border", "RenaitreFade10", [[Interface\Addons\ElvUI_EltreumUI\Media\border\RenaitreFade10.tga]])
LSM:Register("border", "RenDefine", [[Interface\Addons\ElvUI_EltreumUI\Media\border\RenDefine.tga]])
LSM:Register("border", "RenFade", [[Interface\Addons\ElvUI_EltreumUI\Media\border\RenFade.tga]])
LSM:Register("border", "RenFadeB", [[Interface\Addons\ElvUI_EltreumUI\Media\border\RenFadeB.tga]])
LSM:Register("border", "fer01", [[Interface\Addons\ElvUI_EltreumUI\Media\border\fer1.tga]])
LSM:Register("border", "fer02", [[Interface\Addons\ElvUI_EltreumUI\Media\border\fer2.tga]])
LSM:Register("border", "fer03", [[Interface\Addons\ElvUI_EltreumUI\Media\border\fer3.tga]])
LSM:Register("border", "fer04", [[Interface\Addons\ElvUI_EltreumUI\Media\border\fer4.tga]])
LSM:Register("border", "fer05", [[Interface\Addons\ElvUI_EltreumUI\Media\border\fer5.tga]])
LSM:Register("border", "fer06", [[Interface\Addons\ElvUI_EltreumUI\Media\border\fer6.tga]])
LSM:Register("border", "fer07", [[Interface\Addons\ElvUI_EltreumUI\Media\border\fer7.tga]])
LSM:Register("border", "fer08", [[Interface\Addons\ElvUI_EltreumUI\Media\border\fer8.tga]])
LSM:Register("border", "fer09", [[Interface\Addons\ElvUI_EltreumUI\Media\border\fer9.tga]])
LSM:Register("border", "fer10", [[Interface\Addons\ElvUI_EltreumUI\Media\border\fer10.tga]])
LSM:Register("border", "fer11", [[Interface\Addons\ElvUI_EltreumUI\Media\border\fer11.tga]])
LSM:Register("border", "fer12", [[Interface\Addons\ElvUI_EltreumUI\Media\border\fer12.tga]])
LSM:Register("border", "fer13", [[Interface\Addons\ElvUI_EltreumUI\Media\border\fer13.tga]])
LSM:Register("border", "RenaitreBeveled11", [[Interface\Addons\ElvUI_EltreumUI\Media\border\RenaitreBeveled11.tga]])
LSM:Register("border", "RenaitreBeveled11x", [[Interface\Addons\ElvUI_EltreumUI\Media\border\RenaitreBeveled11x.tga]])
LSM:Register("border", "RenaitreFade10blk", [[Interface\Addons\ElvUI_EltreumUI\Media\border\RenaitreFade10blk.tga]])
LSM:Register("border", "RenaitreFade10x", [[Interface\Addons\ElvUI_EltreumUI\Media\border\RenaitreFade10x.tga]])
LSM:Register("border", "RenaitreFade10xblk", [[Interface\Addons\ElvUI_EltreumUI\Media\border\RenaitreFade10xblk.tga]])
LSM:Register("border", "RenaitreFade11", [[Interface\Addons\ElvUI_EltreumUI\Media\border\RenaitreFade11.tga]])
LSM:Register("border", "RenaitreFade11blk", [[Interface\Addons\ElvUI_EltreumUI\Media\border\RenaitreFade11blk.tga]])
LSM:Register("border", "RenaitreFade11x", [[Interface\Addons\ElvUI_EltreumUI\Media\border\RenaitreFade11x.tga]])
LSM:Register("border", "RenaitreFade11xblk", [[Interface\Addons\ElvUI_EltreumUI\Media\border\RenaitreFade11xblk.tga]])

-- Texture
LSM:Register("texture", "Eltreum-Death Knight", [[Interface\Addons\ElvUI_EltreumUI\Media\Textures\Classes\DeathKnight.tga]])
LSM:Register("texture", "Eltreum-Demon Hunter", [[Interface\Addons\ElvUI_EltreumUI\Media\Textures\Classes\DemonHunter.tga]])
LSM:Register("texture", "Eltreum-Druid", [[Interface\Addons\ElvUI_EltreumUI\Media\Textures\Classes\Druid.tga]])
LSM:Register("texture", "Eltreum-Hunter", [[Interface\Addons\ElvUI_EltreumUI\Media\Textures\Classes\Hunter.tga]])
LSM:Register("texture", "Eltreum-Mage", [[Interface\Addons\ElvUI_EltreumUI\Media\Textures\Classes\Mage.tga]])
LSM:Register("texture", "Eltreum-Monk", [[Interface\Addons\ElvUI_EltreumUI\Media\Textures\Classes\Monk.tga]])
LSM:Register("texture", "Eltreum-Paladin", [[Interface\Addons\ElvUI_EltreumUI\Media\Textures\Classes\Paladin.tga]])
LSM:Register("texture", "Eltreum-Priest", [[Interface\Addons\ElvUI_EltreumUI\Media\Textures\Classes\Priest.tga]])
LSM:Register("texture", "Eltreum-Rogue", [[Interface\Addons\ElvUI_EltreumUI\Media\Textures\Classes\Rogue.tga]])
LSM:Register("texture", "Eltreum-Shaman", [[Interface\Addons\ElvUI_EltreumUI\Media\Textures\Classes\Shaman.tga]])
LSM:Register("texture", "Eltreum-Warlock", [[Interface\Addons\ElvUI_EltreumUI\Media\Textures\Classes\Warlock.tga]])
LSM:Register("texture", "Eltreum-Warrior", [[Interface\Addons\ElvUI_EltreumUI\Media\Textures\Classes\Warrior.tga]])

-- Background
LSM:Register("background", "Eltreum-StealthOverlay", [[Interface\Addons\ElvUI_EltreumUI\Media\Textures\StealthOverlay.tga]])

--other combat icons
E.Media.CombatIcons.Eltruism01 = [[Interface\Addons\ElvUI_EltreumUI\Media\Textures\Combat\fight1.tga]]
E.Media.CombatIcons.Eltruism02 = [[Interface\Addons\ElvUI_EltreumUI\Media\Textures\Combat\fight2.tga]]
E.Media.CombatIcons.Eltruism03 = [[Interface\Addons\ElvUI_EltreumUI\Media\Textures\Combat\fight3.tga]]
E.Media.CombatIcons.Eltruism04 = [[Interface\Addons\ElvUI_EltreumUI\Media\Textures\Combat\fight4.tga]]
E.Media.CombatIcons.Eltruism05 = [[Interface\Addons\ElvUI_EltreumUI\Media\Textures\Combat\fight5.tga]]
E.Media.CombatIcons.Eltruism06 = [[Interface\Addons\ElvUI_EltreumUI\Media\Textures\Combat\fight6.tga]]
E.Media.CombatIcons.Eltruism07 = [[Interface\Addons\ElvUI_EltreumUI\Media\Textures\Combat\fight7.tga]]
E.Media.CombatIcons.Eltruism08 = [[Interface\Addons\ElvUI_EltreumUI\Media\Textures\Combat\fight8.tga]]
E.Media.CombatIcons.Eltruism09 = [[Interface\Addons\ElvUI_EltreumUI\Media\Textures\Combat\fight9.tga]]
E.Media.CombatIcons.Eltruism10 = [[Interface\Addons\ElvUI_EltreumUI\Media\Textures\Combat\fight10.tga]]
E.Media.CombatIcons.Eltruism11 = [[Interface\Addons\ElvUI_EltreumUI\Media\Textures\Combat\fight11.tga]]
E.Media.CombatIcons.Eltruism12 = [[Interface\Addons\ElvUI_EltreumUI\Media\Textures\Combat\fight12.tga]]
E.Media.CombatIcons.Eltruism13 = [[Interface\Addons\ElvUI_EltreumUI\Media\Textures\Combat\fight13.tga]]
E.Media.CombatIcons.Eltruism14 = [[Interface\Addons\ElvUI_EltreumUI\Media\Textures\Combat\fight14.tga]]
E.Media.CombatIcons.Eltruism15 = [[Interface\Addons\ElvUI_EltreumUI\Media\Textures\Combat\fight15.tga]]

--other rest icons
E.Media.RestIcons.Eltruism01 = [[Interface\Addons\ElvUI_EltreumUI\Media\Textures\Rest\rest1.tga]]
E.Media.RestIcons.Eltruism02 = [[Interface\Addons\ElvUI_EltreumUI\Media\Textures\Rest\rest2.tga]]
