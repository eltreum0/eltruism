local E = unpack(ElvUI)

local classIconsReleaf = {
	["16"] ={
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\WarriorReleaf.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\PaladinReleaf.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\HunterReleaf.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\RogueReleaf.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\PriestReleaf.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\DeathKnightReleaf.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\ShamanReleaf.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\MageReleaf.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\WarlockReleaf.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\MonkReleaf.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\DruidReleaf.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\DemonHunterReleaf.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\EvokerReleaf.tga",
	},
	["32"] ={
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\WarriorReleaf.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\PaladinReleaf.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\HunterReleaf.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\RogueReleaf.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\PriestReleaf.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\DeathKnightReleaf.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\ShamanReleaf.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\MageReleaf.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\WarlockReleaf.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\MonkReleaf.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\DruidReleaf.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\DemonHunterReleaf.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\EvokerReleaf.tga",
	},
	["64"] ={
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\WarriorReleaf.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\PaladinReleaf.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\HunterReleaf.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\RogueReleaf.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\PriestReleaf.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\DeathKnightReleaf.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\ShamanReleaf.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\MageReleaf.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\WarlockReleaf.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\MonkReleaf.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\DruidReleaf.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\DemonHunterReleaf.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\EvokerReleaf.tga",
	},
	["128"] ={
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\WarriorReleaf.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\PaladinReleaf.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\HunterReleaf.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\RogueReleaf.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\PriestReleaf.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\DeathKnightReleaf.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\ShamanReleaf.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\MageReleaf.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\WarlockReleaf.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\MonkReleaf.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\DruidReleaf.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\DemonHunterReleaf.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\EvokerReleaf.tga",
	},
}
local classIconsBlizzard = {
	["16"] ={
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\Warrior.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\Paladin.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\Hunter.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\Rogue.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\Priest.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\DeathKnight.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\Shaman.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\Mage.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\Warlock.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\Monk.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\Druid.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\DemonHunter.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\Evoker.tga",
	},
	["32"] ={
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\Warrior.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\Paladin.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\Hunter.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\Rogue.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\Priest.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\DeathKnight.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\Shaman.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\Mage.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\Warlock.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\Monk.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\Druid.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\DemonHunter.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\Evoker.tga",
	},
	["64"] ={
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\Warrior.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\Paladin.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\Hunter.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\Rogue.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\Priest.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\DeathKnight.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\Shaman.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\Mage.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\Warlock.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\Monk.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\Druid.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\DemonHunter.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\Evoker.tga",
	},
	["128"] ={
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Warrior.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Paladin.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Hunter.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Rogue.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Priest.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\DeathKnight.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Shaman.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Mage.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Warlock.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Monk.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Druid.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\DemonHunter.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Evoker.tga",
	},
}
local classIconsBorder = {
	["16"] = {
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\WarriorIconReleaf.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\PaladinIconReleaf.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\HunterIconReleaf.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\RogueIconReleaf.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\PriestIconReleaf.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\DeathKnightIconReleaf.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\ShamanIconReleaf.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\MageIconReleaf.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\WarlockIconReleaf.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\MonkIconReleaf.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\DruidIconReleaf.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\DemonHunterIconReleaf.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\EvokerIconReleaf.tga",
	},
	["32"] = {
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\WarriorIconReleaf.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\PaladinIconReleaf.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\HunterIconReleaf.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\RogueIconReleaf.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\PriestIconReleaf.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\DeathKnightIconReleaf.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\ShamanIconReleaf.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\MageIconReleaf.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\WarlockIconReleaf.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\MonkIconReleaf.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\DruidIconReleaf.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\DemonHunterIconReleaf.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\EvokerIconReleaf.tga",
	},
	["64"] = {
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\WarriorIconReleaf.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\PaladinIconReleaf.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\HunterIconReleaf.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\RogueIconReleaf.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\PriestIconReleaf.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\DeathKnightIconReleaf.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\ShamanIconReleaf.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\MageIconReleaf.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\WarlockIconReleaf.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\MonkIconReleaf.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\DruidIconReleaf.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\DemonHunterIconReleaf.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\EvokerIconReleaf.tga",
	},
	["128"] = {
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\WarriorIconReleaf.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\PaladinIconReleaf.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\HunterIconReleaf.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\RogueIconReleaf.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\PriestIconReleaf.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\DeathKnightIconReleaf.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\ShamanIconReleaf.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\MageIconReleaf.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\WarlockIconReleaf.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\MonkIconReleaf.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\DruidIconReleaf.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\DemonHunterIconReleaf.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\EvokerIconReleaf.tga",
	},
}
local classIconsShadow = {
	["16"] = {
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\WarriorShadow.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\PaladinShadow.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\HunterShadow.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\RogueShadow.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\PriestShadow.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\DeathKnightShadow.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\ShamanShadow.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\MageShadow.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\WarlockShadow.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\MonkShadow.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\DruidShadow.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\DemonHunterShadow.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\EvokerShadow.tga",
	},
	["32"] = {
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\WarriorShadow.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\PaladinShadow.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\HunterShadow.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\RogueShadow.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\PriestShadow.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\DeathKnightShadow.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\ShamanShadow.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\MageShadow.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\WarlockShadow.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\MonkShadow.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\DruidShadow.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\DemonHunterShadow.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\EvokerShadow.tga",
	},
	["64"] = {
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\WarriorShadow.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\PaladinShadow.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\HunterShadow.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\RogueShadow.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\PriestShadow.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\DeathKnightShadow.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\ShamanShadow.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\MageShadow.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\WarlockShadow.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\MonkShadow.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\DruidShadow.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\DemonHunterShadow.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\EvokerShadow.tga",
	},
	["128"] = {
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\WarriorShadow.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\PaladinShadow.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\HunterShadow.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\RogueShadow.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\PriestShadow.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\DeathKnightShadow.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\ShamanShadow.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\MageShadow.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\WarlockShadow.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\MonkShadow.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\DruidShadow.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\DemonHunterShadow.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\EvokerShadow.tga",
	},
}
local classIconsOutline = {
	["16"] = {
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\Warrior1.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\Paladin1.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\Hunter1.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\Rogue1.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\Priest1.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\DeathKnight1.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\Shaman1.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\Mage1.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\Warlock1.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\Monk1.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\Druid1.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\DemonHunter1.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\Evoker1.tga",
	},
	["32"] = {
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\Warrior1.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\Paladin1.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\Hunter1.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\Rogue1.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\Priest1.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\DeathKnight1.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\Shaman1.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\Mage1.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\Warlock1.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\Monk1.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\Druid1.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\DemonHunter1.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\Evoker1.tga",
	},
	["64"] = {
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\Warrior1.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\Paladin1.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\Hunter1.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\Rogue1.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\Priest1.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\DeathKnight1.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\Shaman1.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\Mage1.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\Warlock1.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\Monk1.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\Druid1.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\DemonHunter1.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\Evoker1.tga",
	},
	["128"] = {
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Warrior1.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Paladin1.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Hunter1.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Rogue1.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Priest1.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\DeathKnight1.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Shaman1.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Mage1.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Warlock1.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Monk1.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Druid1.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\DemonHunter1.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Evoker1.tga",
	},
}
local OriginalIcons = {
	["16"] = {
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\WarriorOriginal.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\PaladinOriginal.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\HunterOriginal.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\RogueOriginal.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\PriestOriginal.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\DeathKnightOriginal.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\ShamanOriginal.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\MageOriginal.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\WarlockOriginal.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\MonkOriginal.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\DruidOriginal.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\DemonHunterOriginal.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\EvokerOriginal.tga",
	},
	["32"] = {
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\WarriorOriginal.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\PaladinOriginal.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\HunterOriginal.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\RogueOriginal.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\PriestOriginal.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\DeathKnightOriginal.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\ShamanOriginal.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\MageOriginal.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\WarlockOriginal.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\MonkOriginal.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\DruidOriginal.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\DemonHunterOriginal.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\EvokerOriginal.tga",
	},
	["64"] = {
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\WarriorOriginal.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\PaladinOriginal.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\HunterOriginal.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\RogueOriginal.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\PriestOriginal.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\DeathKnightOriginal.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\ShamanOriginal.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\MageOriginal.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\WarlockOriginal.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\MonkOriginal.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\DruidOriginal.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\DemonHunterOriginal.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\EvokerOriginal.tga",
	},
	["128"] = {
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\WarriorOriginal.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\PaladinOriginal.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\HunterOriginal.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\RogueOriginal.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\PriestOriginal.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\DeathKnightOriginal.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\ShamanOriginal.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\MageOriginal.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\WarlockOriginal.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\MonkOriginal.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\DruidOriginal.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\DemonHunterOriginal.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\EvokerOriginal.tga",
	},
}
local classSymbols = {
	["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\Warrior.tga",
	["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\Paladin.tga",
	["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\Hunter.tga",
	["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\Rogue.tga",
	["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\Priest.tga",
	["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\DeathKnight.tga",
	["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\Shaman.tga",
	["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\Mage.tga",
	["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\Warlock.tga",
	["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\Monk.tga",
	["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\Druid.tga",
	["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\DemonHunter.tga",
	["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\Evoker.tga",
}
local gradient = {
	["16"] = {
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\WarriorGradient.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\PaladinGradient.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\HunterGradient.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\RogueGradient.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\PriestGradient.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\DeathKnightGradient.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\ShamanGradient.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\MageGradient.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\WarlockGradient.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\MonkGradient.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\DruidGradient.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\DemonHunterGradient.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\EvokerGradient.tga",
	},
	["32"] = {
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\WarriorGradient.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\PaladinGradient.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\HunterGradient.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\RogueGradient.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\PriestGradient.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\DeathKnightGradient.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\ShamanGradient.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\MageGradient.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\WarlockGradient.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\MonkGradient.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\DruidGradient.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\DemonHunterGradient.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\EvokerGradient.tga",
	},
	["64"] = {
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\WarriorGradient.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\PaladinGradient.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\HunterGradient.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\RogueGradient.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\PriestGradient.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\DeathKnightGradient.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\ShamanGradient.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\MageGradient.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\WarlockGradient.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\MonkGradient.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\DruidGradient.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\DemonHunterGradient.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\EvokerGradient.tga",
	},
	["128"] = {
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\WarriorGradient.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\PaladinGradient.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\HunterGradient.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\RogueGradient.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\PriestGradient.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\DeathKnightGradient.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\ShamanGradient.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\MageGradient.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\WarlockGradient.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\MonkGradient.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\DruidGradient.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\DemonHunterGradient.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\EvokerGradient.tga",
	},
}
local blackandwhite = {
	["16"] = {
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\WarriorBW.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\PaladinBW.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\HunterBW.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\RogueBW.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\PriestBW.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\DeathKnightBW.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\ShamanBW.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\MageBW.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\WarlockBW.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\MonkBW.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\DruidBW.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\DemonHunterBW.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\EvokerBW.tga",
	},
	["32"] = {
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\WarriorBW.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\PaladinBW.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\HunterBW.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\RogueBW.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\PriestBW.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\DeathKnightBW.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\ShamanBW.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\MageBW.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\WarlockBW.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\MonkBW.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\DruidBW.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\DemonHunterBW.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\EvokerBW.tga",
	},
	["64"] = {
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\WarriorBW.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\PaladinBW.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\HunterBW.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\RogueBW.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\PriestBW.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\DeathKnightBW.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\ShamanBW.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\MageBW.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\WarlockBW.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\MonkBW.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\DruidBW.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\DemonHunterBW.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\EvokerBW.tga",
	},
	["128"] = {
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\WarriorBW.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\PaladinBW.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\HunterBW.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\RogueBW.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\PriestBW.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\DeathKnightBW.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\ShamanBW.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\MageBW.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\WarlockBW.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\MonkBW.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\DruidBW.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\DemonHunterBW.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\EvokerBW.tga",
	},
}
local UGG = {
	["16"] = {
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\WarriorUGG.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\PaladinUGG.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\HunterUGG.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\RogueUGG.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\PriestUGG.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\DeathKnightUGG.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\ShamanUGG.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\MageUGG.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\WarlockUGG.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\MonkUGG.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\DruidUGG.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\DemonHunterUGG.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\EvokerUGG.tga",
	},
	["32"] = {
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\WarriorUGG.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\PaladinUGG.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\HunterUGG.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\RogueUGG.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\PriestUGG.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\DeathKnightUGG.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\ShamanUGG.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\MageUGG.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\WarlockUGG.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\MonkUGG.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\DruidUGG.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\DemonHunterUGG.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\EvokerUGG.tga",
	},
	["64"] = {
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\WarriorUGG.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\PaladinUGG.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\HunterUGG.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\RogueUGG.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\PriestUGG.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\DeathKnightUGG.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\ShamanUGG.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\MageUGG.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\WarlockUGG.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\MonkUGG.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\DruidUGG.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\DemonHunterUGG.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\EvokerUGG.tga",
	},
	["128"] = {
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\WarriorUGG.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\PaladinUGG.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\HunterUGG.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\RogueUGG.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\PriestUGG.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\DeathKnightUGG.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\ShamanUGG.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\MageUGG.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\WarlockUGG.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\MonkUGG.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\DruidUGG.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\DemonHunterUGG.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\EvokerUGG.tga",
	},
}
local UGGGREY = {
	["16"] = {
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\WarriorUGGBW.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\PaladinUGGBW.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\HunterUGGBW.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\RogueUGGBW.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\PriestUGGBW.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\DeathKnightUGGBW.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\ShamanUGGBW.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\MageUGGBW.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\WarlockUGGBW.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\MonkUGGBW.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\DruidUGGBW.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\DemonHunterUGGBW.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\16\\EvokerUGGBW.tga",
	},
	["32"] = {
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\WarriorUGGBW.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\PaladinUGGBW.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\HunterUGGBW.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\RogueUGGBW.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\PriestUGGBW.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\DeathKnightUGGBW.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\ShamanUGGBW.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\MageUGGBW.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\WarlockUGGBW.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\MonkUGGBW.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\DruidUGGBW.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\DemonHunterUGGBW.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\EvokerUGGBW.tga",
	},
	["64"] = {
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\WarriorUGGBW.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\PaladinUGGBW.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\HunterUGGBW.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\RogueUGGBW.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\PriestUGGBW.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\DeathKnightUGGBW.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\ShamanUGGBW.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\MageUGGBW.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\WarlockUGGBW.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\MonkUGGBW.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\DruidUGGBW.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\DemonHunterUGGBW.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\64\\EvokerUGGBW.tga",
	},
	["128"] = {
		["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\WarriorUGGBW.tga",
		["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\PaladinUGGBW.tga",
		["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\HunterUGGBW.tga",
		["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\RogueUGGBW.tga",
		["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\PriestUGGBW.tga",
		["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\DeathKnightUGGBW.tga",
		["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\ShamanUGGBW.tga",
		["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\MageUGGBW.tga",
		["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\WarlockUGGBW.tga",
		["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\MonkUGGBW.tga",
		["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\DruidUGGBW.tga",
		["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\DemonHunterUGGBW.tga",
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\EvokerUGGBW.tga",
	},
}

--return icons for other functions
local ScreenWidth = GetScreenWidth()
function ElvUI_EltreumUI:GetClassIcons(icon,unitclass,invert,resolution,nostring)
	if ScreenWidth < 2000 then
		if resolution == "32" then
			resolution = "16"
		elseif resolution == "64" then
			resolution = "32"
		end
	end
	if nostring then
		if icon == "RELEAF" then
			return classIconsReleaf[resolution][unitclass]
		elseif icon == "OUTLINE" then
			return classIconsOutline[resolution][unitclass]
		elseif icon == "BLIZZARD" then
			return classIconsBlizzard[resolution][unitclass]
		elseif icon == "BORDER" then
			return classIconsBorder[resolution][unitclass]
		elseif icon == "SHADOW" then
			return classIconsShadow[resolution][unitclass]
		elseif icon == "ORIGINAL" then
			return OriginalIcons[resolution][unitclass]
		elseif icon == "GRADIENT" then
			return gradient[resolution][unitclass]
		elseif icon == "SYMBOLS" then
			return classSymbols[unitclass]
		elseif icon == "BW" then
			return blackandwhite[resolution][unitclass]
		elseif icon == "UGG" then
			return UGG[resolution][unitclass]
		elseif icon == "UGGGREY" then
			return UGGGREY[resolution][unitclass]
		elseif icon == "CUSTOM" then
			return E.private.ElvUI_EltreumUI.chat.customicons[unitclass]
		end
	else
		if not invert then
			if icon == "RELEAF" then
				return "|T"..classIconsReleaf[resolution][unitclass]..":0:0:0:0|t"
			elseif icon == "OUTLINE" then
				return "|T"..classIconsOutline[resolution][unitclass]..":0:0:0:0|t"
			elseif icon == "BLIZZARD" then
				return "|T"..classIconsBlizzard[resolution][unitclass]..":0:0:0:0|t"
			elseif icon == "BORDER" then
				return "|T"..classIconsBorder[resolution][unitclass]..":0:0:0:0|t"
			elseif icon == "SHADOW" then
				return "|T"..classIconsShadow[resolution][unitclass]..":0:0:0:0|t"
			elseif icon == "ORIGINAL" then
				return "|T"..OriginalIcons[resolution][unitclass]..":0:0:0:0|t"
			elseif icon == "GRADIENT" then
				return "|T"..gradient[resolution][unitclass]..":0:0:0:0|t"
			elseif icon == "SYMBOLS" then
				return "|T"..classSymbols[unitclass]..":0:0:0:0|t"
			elseif icon == "BW" then
				return  "|T"..blackandwhite[resolution][unitclass]..":0:0:0:0|t"
			elseif icon == "UGG" then
				return  "|T"..UGG[resolution][unitclass]..":0:0:0:0|t"
			elseif icon == "UGGGREY" then
				return  "|T"..UGGGREY[resolution][unitclass]..":0:0:0:0|t"
			elseif icon == "CUSTOM" then
				return "|T"..E.private.ElvUI_EltreumUI.chat.customicons[unitclass]..":0:0:0:0|t"
			end
		else
			if icon == "RELEAF" then
				return "|T"..classIconsReleaf[resolution][unitclass]..":0:0:0:0:64:64:64:0:0:64|t"
			elseif icon == "OUTLINE" then
				return "|T"..classIconsOutline[resolution][unitclass]..":0:0:0:0:64:64:64:0:0:64|t"
			elseif icon == "BLIZZARD" then
				return "|T"..classIconsBlizzard[resolution][unitclass]..":0:0:0:0:64:64:64:0:0:64|t"
			elseif icon == "BORDER" then
				return "|T"..classIconsBorder[resolution][unitclass]..":0:0:0:0:64:64:64:0:0:64|t"
			elseif icon == "SHADOW" then
				return "|T"..classIconsShadow[resolution][unitclass]..":0:0:0:0:64:64:64:0:0:64|t"
			elseif icon == "ORIGINAL" then
				return "|T"..OriginalIcons[resolution][unitclass]..":0:0:0:0:64:64:64:0:0:64|t"
			elseif icon == "GRADIENT" then
				return "|T"..gradient[resolution][unitclass]..":0:0:0:0:64:64:64:0:0:64|t"
			elseif icon == "SYMBOLS" then
				return "|T"..classSymbols[unitclass]..":0:0:0:0:64:64:64:0:0:64|t"
			elseif icon == "BW" then
				return "|T"..blackandwhite[resolution][unitclass]..":0:0:0:0:64:64:64:0:0:64|t"
			elseif icon == "UGG" then
				return "|T"..UGG[resolution][unitclass]..":0:0:0:0:64:64:64:0:0:64|t"
			elseif icon == "UGGGREY" then
				return "|T"..UGGGREY[resolution][unitclass]..":0:0:0:0:64:64:64:0:0:64|t"
			elseif icon == "CUSTOM" then
				return "|T"..E.private.ElvUI_EltreumUI.chat.customicons[unitclass]..":0:0:0:0:64:64:64:0:0:64|t"
			end
		end
	end
end
