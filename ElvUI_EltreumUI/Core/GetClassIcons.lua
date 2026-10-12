local E = unpack(ElvUI)
local GetScreenWidth =_G.GetScreenWidth

local classIconsReleaf = {
	["16"] ={
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\WarriorReleaf]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\PaladinReleaf]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\HunterReleaf]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\RogueReleaf]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\PriestReleaf]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\DeathKnightReleaf]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\ShamanReleaf]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\MageReleaf]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\WarlockReleaf]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\MonkReleaf]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\DruidReleaf]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\DemonHunterReleaf]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\EvokerReleaf]],
	},
	["32"] ={
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\WarriorReleaf]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\PaladinReleaf]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\HunterReleaf]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\RogueReleaf]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\PriestReleaf]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\DeathKnightReleaf]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\ShamanReleaf]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\MageReleaf]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\WarlockReleaf]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\MonkReleaf]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\DruidReleaf]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\DemonHunterReleaf]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\EvokerReleaf]],
	},
	["64"] ={
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\WarriorReleaf]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\PaladinReleaf]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\HunterReleaf]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\RogueReleaf]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\PriestReleaf]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\DeathKnightReleaf]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\ShamanReleaf]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\MageReleaf]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\WarlockReleaf]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\MonkReleaf]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\DruidReleaf]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\DemonHunterReleaf]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\EvokerReleaf]],
	},
	["128"] ={
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\WarriorReleaf]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\PaladinReleaf]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\HunterReleaf]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\RogueReleaf]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\PriestReleaf]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\DeathKnightReleaf]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\ShamanReleaf]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\MageReleaf]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\WarlockReleaf]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\MonkReleaf]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\DruidReleaf]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\DemonHunterReleaf]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\EvokerReleaf]],
	},
}
local classIconsBlizzard = {
	["16"] ={
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\Warrior]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\Paladin]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\Hunter]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\Rogue]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\Priest]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\DeathKnight]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\Shaman]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\Mage]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\Warlock]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\Monk]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\Druid]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\DemonHunter]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\Evoker]],
	},
	["32"] ={
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\Warrior]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\Paladin]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\Hunter]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\Rogue]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\Priest]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\DeathKnight]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\Shaman]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\Mage]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\Warlock]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\Monk]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\Druid]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\DemonHunter]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\Evoker]],
	},
	["64"] ={
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\Warrior]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\Paladin]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\Hunter]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\Rogue]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\Priest]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\DeathKnight]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\Shaman]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\Mage]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\Warlock]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\Monk]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\Druid]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\DemonHunter]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\Evoker]],
	},
	["128"] ={
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\Warrior]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\Paladin]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\Hunter]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\Rogue]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\Priest]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\DeathKnight]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\Shaman]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\Mage]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\Warlock]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\Monk]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\Druid]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\DemonHunter]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\Evoker]],
	},
}
local classIconsBorder = {
	["16"] = {
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\WarriorIconReleaf]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\PaladinIconReleaf]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\HunterIconReleaf]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\RogueIconReleaf]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\PriestIconReleaf]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\DeathKnightIconReleaf]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\ShamanIconReleaf]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\MageIconReleaf]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\WarlockIconReleaf]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\MonkIconReleaf]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\DruidIconReleaf]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\DemonHunterIconReleaf]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\EvokerIconReleaf]],
	},
	["32"] = {
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\WarriorIconReleaf]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\PaladinIconReleaf]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\HunterIconReleaf]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\RogueIconReleaf]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\PriestIconReleaf]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\DeathKnightIconReleaf]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\ShamanIconReleaf]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\MageIconReleaf]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\WarlockIconReleaf]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\MonkIconReleaf]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\DruidIconReleaf]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\DemonHunterIconReleaf]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\EvokerIconReleaf]],
	},
	["64"] = {
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\WarriorIconReleaf]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\PaladinIconReleaf]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\HunterIconReleaf]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\RogueIconReleaf]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\PriestIconReleaf]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\DeathKnightIconReleaf]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\ShamanIconReleaf]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\MageIconReleaf]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\WarlockIconReleaf]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\MonkIconReleaf]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\DruidIconReleaf]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\DemonHunterIconReleaf]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\EvokerIconReleaf]],
	},
	["128"] = {
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\WarriorIconReleaf]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\PaladinIconReleaf]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\HunterIconReleaf]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\RogueIconReleaf]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\PriestIconReleaf]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\DeathKnightIconReleaf]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\ShamanIconReleaf]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\MageIconReleaf]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\WarlockIconReleaf]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\MonkIconReleaf]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\DruidIconReleaf]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\DemonHunterIconReleaf]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\EvokerIconReleaf]],
	},
}
local classIconsShadow = {
	["16"] = {
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\WarriorShadow]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\PaladinShadow]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\HunterShadow]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\RogueShadow]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\PriestShadow]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\DeathKnightShadow]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\ShamanShadow]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\MageShadow]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\WarlockShadow]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\MonkShadow]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\DruidShadow]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\DemonHunterShadow]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\EvokerShadow]],
	},
	["32"] = {
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\WarriorShadow]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\PaladinShadow]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\HunterShadow]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\RogueShadow]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\PriestShadow]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\DeathKnightShadow]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\ShamanShadow]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\MageShadow]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\WarlockShadow]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\MonkShadow]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\DruidShadow]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\DemonHunterShadow]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\EvokerShadow]],
	},
	["64"] = {
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\WarriorShadow]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\PaladinShadow]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\HunterShadow]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\RogueShadow]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\PriestShadow]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\DeathKnightShadow]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\ShamanShadow]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\MageShadow]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\WarlockShadow]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\MonkShadow]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\DruidShadow]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\DemonHunterShadow]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\EvokerShadow]],
	},
	["128"] = {
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\WarriorShadow]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\PaladinShadow]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\HunterShadow]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\RogueShadow]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\PriestShadow]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\DeathKnightShadow]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\ShamanShadow]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\MageShadow]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\WarlockShadow]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\MonkShadow]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\DruidShadow]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\DemonHunterShadow]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\EvokerShadow]],
	},
}
local classIconsOutline = {
	["16"] = {
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\Warrior1]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\Paladin1]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\Hunter1]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\Rogue1]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\Priest1]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\DeathKnight1]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\Shaman1]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\Mage1]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\Warlock1]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\Monk1]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\Druid1]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\DemonHunter1]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\Evoker1]],
	},
	["32"] = {
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\Warrior1]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\Paladin1]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\Hunter1]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\Rogue1]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\Priest1]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\DeathKnight1]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\Shaman1]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\Mage1]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\Warlock1]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\Monk1]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\Druid1]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\DemonHunter1]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\Evoker1]],
	},
	["64"] = {
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\Warrior1]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\Paladin1]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\Hunter1]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\Rogue1]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\Priest1]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\DeathKnight1]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\Shaman1]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\Mage1]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\Warlock1]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\Monk1]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\Druid1]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\DemonHunter1]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\Evoker1]],
	},
	["128"] = {
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\Warrior1]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\Paladin1]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\Hunter1]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\Rogue1]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\Priest1]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\DeathKnight1]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\Shaman1]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\Mage1]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\Warlock1]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\Monk1]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\Druid1]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\DemonHunter1]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\Evoker1]],
	},
}
local OriginalIcons = {
	["16"] = {
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\WarriorOriginal]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\PaladinOriginal]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\HunterOriginal]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\RogueOriginal]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\PriestOriginal]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\DeathKnightOriginal]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\ShamanOriginal]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\MageOriginal]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\WarlockOriginal]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\MonkOriginal]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\DruidOriginal]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\DemonHunterOriginal]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\EvokerOriginal]],
	},
	["32"] = {
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\WarriorOriginal]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\PaladinOriginal]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\HunterOriginal]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\RogueOriginal]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\PriestOriginal]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\DeathKnightOriginal]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\ShamanOriginal]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\MageOriginal]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\WarlockOriginal]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\MonkOriginal]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\DruidOriginal]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\DemonHunterOriginal]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\EvokerOriginal]],
	},
	["64"] = {
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\WarriorOriginal]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\PaladinOriginal]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\HunterOriginal]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\RogueOriginal]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\PriestOriginal]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\DeathKnightOriginal]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\ShamanOriginal]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\MageOriginal]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\WarlockOriginal]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\MonkOriginal]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\DruidOriginal]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\DemonHunterOriginal]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\EvokerOriginal]],
	},
	["128"] = {
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\WarriorOriginal]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\PaladinOriginal]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\HunterOriginal]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\RogueOriginal]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\PriestOriginal]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\DeathKnightOriginal]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\ShamanOriginal]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\MageOriginal]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\WarlockOriginal]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\MonkOriginal]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\DruidOriginal]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\DemonHunterOriginal]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\EvokerOriginal]],
	},
}
local classSymbols = {
	["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\ClassSymbols\Warrior]],
	["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\ClassSymbols\Paladin]],
	["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\ClassSymbols\Hunter]],
	["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\ClassSymbols\Rogue]],
	["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\ClassSymbols\Priest]],
	["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\ClassSymbols\DeathKnight]],
	["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\ClassSymbols\Shaman]],
	["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\ClassSymbols\Mage]],
	["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\ClassSymbols\Warlock]],
	["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\ClassSymbols\Monk]],
	["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\ClassSymbols\Druid]],
	["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\ClassSymbols\DemonHunter]],
	["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\ClassSymbols\Evoker]],
}
local gradient = {
	["16"] = {
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\WarriorGradient]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\PaladinGradient]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\HunterGradient]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\RogueGradient]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\PriestGradient]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\DeathKnightGradient]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\ShamanGradient]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\MageGradient]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\WarlockGradient]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\MonkGradient]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\DruidGradient]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\DemonHunterGradient]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\EvokerGradient]],
	},
	["32"] = {
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\WarriorGradient]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\PaladinGradient]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\HunterGradient]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\RogueGradient]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\PriestGradient]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\DeathKnightGradient]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\ShamanGradient]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\MageGradient]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\WarlockGradient]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\MonkGradient]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\DruidGradient]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\DemonHunterGradient]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\EvokerGradient]],
	},
	["64"] = {
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\WarriorGradient]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\PaladinGradient]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\HunterGradient]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\RogueGradient]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\PriestGradient]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\DeathKnightGradient]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\ShamanGradient]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\MageGradient]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\WarlockGradient]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\MonkGradient]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\DruidGradient]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\DemonHunterGradient]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\EvokerGradient]],
	},
	["128"] = {
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\WarriorGradient]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\PaladinGradient]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\HunterGradient]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\RogueGradient]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\PriestGradient]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\DeathKnightGradient]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\ShamanGradient]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\MageGradient]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\WarlockGradient]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\MonkGradient]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\DruidGradient]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\DemonHunterGradient]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\EvokerGradient]],
	},
}
local blackandwhite = {
	["16"] = {
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\WarriorBW]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\PaladinBW]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\HunterBW]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\RogueBW]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\PriestBW]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\DeathKnightBW]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\ShamanBW]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\MageBW]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\WarlockBW]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\MonkBW]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\DruidBW]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\DemonHunterBW]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\EvokerBW]],
	},
	["32"] = {
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\WarriorBW]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\PaladinBW]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\HunterBW]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\RogueBW]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\PriestBW]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\DeathKnightBW]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\ShamanBW]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\MageBW]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\WarlockBW]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\MonkBW]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\DruidBW]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\DemonHunterBW]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\EvokerBW]],
	},
	["64"] = {
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\WarriorBW]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\PaladinBW]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\HunterBW]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\RogueBW]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\PriestBW]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\DeathKnightBW]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\ShamanBW]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\MageBW]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\WarlockBW]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\MonkBW]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\DruidBW]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\DemonHunterBW]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\EvokerBW]],
	},
	["128"] = {
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\WarriorBW]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\PaladinBW]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\HunterBW]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\RogueBW]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\PriestBW]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\DeathKnightBW]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\ShamanBW]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\MageBW]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\WarlockBW]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\MonkBW]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\DruidBW]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\DemonHunterBW]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\EvokerBW]],
	},
}
local UGG = {
	["16"] = {
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\WarriorUGG]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\PaladinUGG]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\HunterUGG]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\RogueUGG]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\PriestUGG]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\DeathKnightUGG]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\ShamanUGG]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\MageUGG]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\WarlockUGG]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\MonkUGG]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\DruidUGG]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\DemonHunterUGG]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\EvokerUGG]],
	},
	["32"] = {
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\WarriorUGG]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\PaladinUGG]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\HunterUGG]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\RogueUGG]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\PriestUGG]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\DeathKnightUGG]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\ShamanUGG]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\MageUGG]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\WarlockUGG]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\MonkUGG]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\DruidUGG]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\DemonHunterUGG]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\EvokerUGG]],
	},
	["64"] = {
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\WarriorUGG]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\PaladinUGG]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\HunterUGG]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\RogueUGG]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\PriestUGG]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\DeathKnightUGG]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\ShamanUGG]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\MageUGG]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\WarlockUGG]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\MonkUGG]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\DruidUGG]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\DemonHunterUGG]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\EvokerUGG]],
	},
	["128"] = {
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\WarriorUGG]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\PaladinUGG]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\HunterUGG]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\RogueUGG]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\PriestUGG]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\DeathKnightUGG]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\ShamanUGG]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\MageUGG]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\WarlockUGG]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\MonkUGG]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\DruidUGG]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\DemonHunterUGG]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\EvokerUGG]],
	},
}
local UGGGREY = {
	["16"] = {
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\WarriorUGGBW]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\PaladinUGGBW]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\HunterUGGBW]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\RogueUGGBW]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\PriestUGGBW]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\DeathKnightUGGBW]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\ShamanUGGBW]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\MageUGGBW]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\WarlockUGGBW]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\MonkUGGBW]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\DruidUGGBW]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\DemonHunterUGGBW]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\16\EvokerUGGBW]],
	},
	["32"] = {
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\WarriorUGGBW]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\PaladinUGGBW]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\HunterUGGBW]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\RogueUGGBW]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\PriestUGGBW]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\DeathKnightUGGBW]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\ShamanUGGBW]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\MageUGGBW]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\WarlockUGGBW]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\MonkUGGBW]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\DruidUGGBW]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\DemonHunterUGGBW]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\EvokerUGGBW]],
	},
	["64"] = {
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\WarriorUGGBW]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\PaladinUGGBW]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\HunterUGGBW]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\RogueUGGBW]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\PriestUGGBW]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\DeathKnightUGGBW]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\ShamanUGGBW]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\MageUGGBW]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\WarlockUGGBW]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\MonkUGGBW]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\DruidUGGBW]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\DemonHunterUGGBW]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\64\EvokerUGGBW]],
	},
	["128"] = {
		["WARRIOR"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\WarriorUGGBW]],
		["PALADIN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\PaladinUGGBW]],
		["HUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\HunterUGGBW]],
		["ROGUE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\RogueUGGBW]],
		["PRIEST"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\PriestUGGBW]],
		["DEATHKNIGHT"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\DeathKnightUGGBW]],
		["SHAMAN"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\ShamanUGGBW]],
		["MAGE"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\MageUGGBW]],
		["WARLOCK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\WarlockUGGBW]],
		["MONK"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\MonkUGGBW]],
		["DRUID"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\DruidUGGBW]],
		["DEMONHUNTER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\DemonHunterUGGBW]],
		["EVOKER"] = [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\128\EvokerUGGBW]],
	},
}

--return icons for other functions
local ScreenWidth = GetScreenWidth()
local escapeSequence = E.Modern and ":16:16:0:0|t" or ":0:0:0:0|t"
local escapeSequence2 = E.Modern and ":16:16:0:0:64:64:64:0:0:64|t" or ":0:0:0:0:64:64:64:0:0:64|t"
function ElvUI_EltreumUI:GetClassIcons(icon,unitclass,invert,resolution,nostring)
	if ScreenWidth < 2000 then
		if resolution == "32" then
			resolution = "16"
		elseif resolution == "64" then
			resolution = "32"
		end
	end
	if nostring then
		if not E:NotSecretValue(unitclass) then --secret class so do something else
			return [[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\secret]]
		end
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
		if not E:NotSecretValue(unitclass) then --secret class so do something else
			return [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\secret]]..escapeSequence
		end
		if not invert then
			if icon == "RELEAF" then
				return "|T"..classIconsReleaf[resolution][unitclass]..escapeSequence
			elseif icon == "OUTLINE" then
				return "|T"..classIconsOutline[resolution][unitclass]..escapeSequence
			elseif icon == "BLIZZARD" then
				return "|T"..classIconsBlizzard[resolution][unitclass]..escapeSequence
			elseif icon == "BORDER" then
				return "|T"..classIconsBorder[resolution][unitclass]..escapeSequence
			elseif icon == "SHADOW" then
				return "|T"..classIconsShadow[resolution][unitclass]..escapeSequence
			elseif icon == "ORIGINAL" then
				return "|T"..OriginalIcons[resolution][unitclass]..escapeSequence
			elseif icon == "GRADIENT" then
				return "|T"..gradient[resolution][unitclass]..escapeSequence
			elseif icon == "SYMBOLS" then
				return "|T"..classSymbols[unitclass]..escapeSequence
			elseif icon == "BW" then
				return "|T"..blackandwhite[resolution][unitclass]..escapeSequence
			elseif icon == "UGG" then
				return "|T"..UGG[resolution][unitclass]..escapeSequence
			elseif icon == "UGGGREY" then
				return "|T"..UGGGREY[resolution][unitclass]..escapeSequence
			elseif icon == "CUSTOM" then
				return "|T"..E.private.ElvUI_EltreumUI.chat.customicons[unitclass]..escapeSequence
			end
		else
			if icon == "RELEAF" then
				return "|T"..classIconsReleaf[resolution][unitclass]..escapeSequence2
			elseif icon == "OUTLINE" then
				return "|T"..classIconsOutline[resolution][unitclass]..escapeSequence2
			elseif icon == "BLIZZARD" then
				return "|T"..classIconsBlizzard[resolution][unitclass]..escapeSequence2
			elseif icon == "BORDER" then
				return "|T"..classIconsBorder[resolution][unitclass]..escapeSequence2
			elseif icon == "SHADOW" then
				return "|T"..classIconsShadow[resolution][unitclass]..escapeSequence2
			elseif icon == "ORIGINAL" then
				return "|T"..OriginalIcons[resolution][unitclass]..escapeSequence2
			elseif icon == "GRADIENT" then
				return "|T"..gradient[resolution][unitclass]..escapeSequence2
			elseif icon == "SYMBOLS" then
				return "|T"..classSymbols[unitclass]..escapeSequence2
			elseif icon == "BW" then
				return "|T"..blackandwhite[resolution][unitclass]..escapeSequence2
			elseif icon == "UGG" then
				return "|T"..UGG[resolution][unitclass]..escapeSequence2
			elseif icon == "UGGGREY" then
				return "|T"..UGGGREY[resolution][unitclass]..escapeSequence2
			elseif icon == "CUSTOM" then
				return "|T"..E.private.ElvUI_EltreumUI.chat.customicons[unitclass]..escapeSequence2
			end
		end
	end
end
