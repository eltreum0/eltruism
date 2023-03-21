local E, L, V, P, G = unpack(ElvUI)

if not E.private.ElvUI_EltreumUI then return end
if not E.private.ElvUI_EltreumUI.install_version then return end
local classcolorsescape = {
	["DEATHKNIGHT"]	= "C41E3A",
	["DEMONHUNTER"]	= "A330C9",
	["DRUID"] = "FF7C0A",
	["HUNTER"] = "AAD372",
	["MAGE"] = "3FC7EB",
	["MONK"] = "00FF98",
	["PALADIN"]	= "F48CBA",
	["PRIEST"] = "FFFFFF",
	["ROGUE"] = "FFF468",
	["SHAMAN"] = "0070DD",
	["WARLOCK"] = "8788EE",
	["WARRIOR"] = "C69B6D",
	["EVOKER"] = "33937F",
}

--Color Mod keys messages
if not E.db.ElvUI_EltreumUI then return end
if not E.db.ElvUI_EltreumUI.skins then return end
if E.db.ElvUI_EltreumUI.skins.colormodkey then
	L["KEY_ALT"] = "|cff"..classcolorsescape[E.myclass]..L["KEY_ALT"].."|r"
	L["KEY_CTRL"] = "|cff"..classcolorsescape[E.myclass]..L["KEY_CTRL"].."|r"
	L["KEY_DELETE"] = "|cff"..classcolorsescape[E.myclass]..L["KEY_DELETE"].."|r"
	L["KEY_HOME"] = "|cff"..classcolorsescape[E.myclass]..L["KEY_HOME"].."|r"
	L["KEY_INSERT"] = "|cff"..classcolorsescape[E.myclass]..L["KEY_INSERT"].."|r"
	L["KEY_MOUSEBUTTON"] = "|cff"..classcolorsescape[E.myclass]..L["KEY_MOUSEBUTTON"] .."|r"
	L["KEY_MOUSEWHEELDOWN"] = "|cff"..classcolorsescape[E.myclass]..L["KEY_MOUSEWHEELDOWN"].."|r"
	L["KEY_MOUSEWHEELUP"] = "|cff"..classcolorsescape[E.myclass]..L["KEY_MOUSEWHEELUP"].."|r"
	L["KEY_NUMPAD"] = "|cff"..classcolorsescape[E.myclass]..L["KEY_NUMPAD"].."|r"
	L["KEY_PAGEDOWN"] = "|cff"..classcolorsescape[E.myclass]..L["KEY_PAGEDOWN"].."|r"
	L["KEY_PAGEUP"] = "|cff"..classcolorsescape[E.myclass]..L["KEY_PAGEUP"].."|r"
	L["KEY_SHIFT"] = "|cff"..classcolorsescape[E.myclass]..L["KEY_SHIFT"].."|r"
	L["KEY_SPACE"] = "|cff"..classcolorsescape[E.myclass]..L["KEY_SPACE"] .."|r"
	L["KEY_NMULTIPLY"] = "|cff"..classcolorsescape[E.myclass]..L["KEY_NMULTIPLY"].."|r"
	L["KEY_NMINUS"] = "|cff"..classcolorsescape[E.myclass]..L["KEY_NMINUS"].."|r"
	L["KEY_NPLUS"] = "|cff"..classcolorsescape[E.myclass]..L["KEY_NPLUS"].."|r"
	L["KEY_NEQUALS"] = "|cff"..classcolorsescape[E.myclass]..L["KEY_NEQUALS"].."|r"
end
