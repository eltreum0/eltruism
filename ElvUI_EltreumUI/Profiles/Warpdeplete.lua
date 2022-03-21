local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local classcolor = E:ClassColor(E.myclass, true)
local classtable = {
	['WARRIOR'] = "Eltreum-Class-Warrior",
	['PALADIN'] = "Eltreum-Class-Paladin",
	['HUNTER'] = "Eltreum-Class-Hunter",
	['ROGUE'] = "Eltreum-Class-Rogue",
	['PRIEST'] = "Eltreum-Class-Priest",
	['DEATHKNIGHT'] = "Eltreum-Class-DeathKnight",
	['SHAMAN'] = "Eltreum-Class-Shaman",
	['MAGE'] = "Eltreum-Class-Mage",
	['WARLOCK'] = "Eltreum-Class-Warlock",
	['MONK'] = "Eltreum-Class-Monk",
	['DRUID'] = "Eltreum-Class-Druid",
	['DEMONHUNTER'] = "Eltreum-Class-DemonHunter",
}

-- WarpDeplete profile setup
function ElvUI_EltreumUI:GetWarpDepleteProfile()
	WarpDepleteDB["profileKeys"][E.mynameRealm] = E.mynameRealm
	WarpDepleteDB["global"]["mdtAlertShown"] = true
	WarpDepleteDB["profiles"][E.mynameRealm] = {
		["timerSuccessColor"] = "ff00ff24",
		["bar1TextureColor"] = tostring(E:RGBToHex(classcolor.r, classcolor.g, classcolor.b, "ff", "")),
		["forcesFont"] = "Kimberley",
		["frameX"] = -3.23811936378479,
		["completedObjectivesColor"] = tostring(E:RGBToHex(classcolor.r, classcolor.g, classcolor.b, "ff", "")),
		["keyDetailsFontSize"] = 14,
		["timerFont"] = "Kimberley",
		["bar3Font"] = "Kimberley",
		["bar3TextureColor"] = tostring(E:RGBToHex(classcolor.r, classcolor.g, classcolor.b, "ff", "")),
		["objectivesFont"] = "Kimberley",
		["keyDetailsFont"] = "Kimberley",
		["prideGlowColor"] = tostring(E:RGBToHex(classcolor.r, classcolor.g, classcolor.b, "ff", "")),
		["deathsFont"] = "Kimberley",
		["completedForcesColor"] = tostring(E:RGBToHex(classcolor.r, classcolor.g, classcolor.b, "ff", "")),
		["bar1Font"] = "Kimberley",
		["bar2TextureColor"] = tostring(E:RGBToHex(classcolor.r, classcolor.g, classcolor.b, "ff", "")),
		["bar2Font"] = "Kimberley",
		["frameY"] = 38.60342788696289,
		["forcesTextureColor"] = tostring(E:RGBToHex(classcolor.r, classcolor.g, classcolor.b, "ff", "")),
		["bar1Texture"] = classtable[E.myclass],
		["bar2Texture"] = classtable[E.myclass],
		--["forcesOverlayTexture"] = "Eltreum-Blank",
		["bar3Texture"] = classtable[E.myclass],
		["forcesTexture"] = classtable[E.myclass],
		["timerRunningColor"] = tostring(E:RGBToHex(classcolor.r, classcolor.g, classcolor.b, "ff", "")),
		["forcesFontSize"] = 18,
		["forcesOverlayTextureColor"] = "ffffffff",
	}
end
