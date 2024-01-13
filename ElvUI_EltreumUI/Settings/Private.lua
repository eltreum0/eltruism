local E, L, V, P, G = unpack(ElvUI)

-- Eltreum UI Private DB
V.ElvUI_EltreumUI = {

	doomignored = "",
	doomallowed = "",

	nameplatepower = {
		enable = false,
		adjust = false,
		mana = true,
		insanity = true,
		maelstrom = true,
		rage = true,
		energy = true,
		astral = true,
		runic = true,
		fury = true,
		focus = true,
	},

	chat = {
		customicons = {
			["WARRIOR"] = "",
			["PALADIN"] = "",
			["HUNTER"] = "",
			["ROGUE"] = "",
			["PRIEST"] = "",
			["DEATHKNIGHT"] = "",
			["SHAMAN"] = "",
			["MAGE"] = "",
			["WARLOCK"] = "",
			["MONK"] = "",
			["DRUID"] = "",
			["DEMONHUNTER"] = "",
			["EVOKER"] = "",
		},
	},

	combatmusic = {
		enable = false,
		musicfile = "None",
		shufflelist = "None",
		bossmusic = false,
		bossfile = "None",
		disableinstance = false,
	},

	skins = {
		armorybgtexture = "mytexture",
	},

	wishlistID = {},
	wishlistName = {},

	isInstalled ={
		sle = false,
		windtools = false,
		projectazilroka = false,
	}

}
