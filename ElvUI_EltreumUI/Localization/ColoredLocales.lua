local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))


if not E.private.ElvUI_EltreumUI.install_version then return end

--Color System messages
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
}

--store originals
local KEY_ALT = L["KEY_ALT"]
local KEY_CTRL = L["KEY_CTRL"]
local KEY_DELETE = L["KEY_DELETE"]
local KEY_HOME = L["KEY_HOME"]
local KEY_INSERT = L["KEY_INSERT"]
local KEY_MOUSEBUTTON = L["KEY_MOUSEBUTTON"]
local KEY_MOUSEWHEELDOWN = L["KEY_MOUSEWHEELDOWN"]
local KEY_MOUSEWHEELUP = L["KEY_MOUSEWHEELUP"]
local KEY_NUMPAD = L["KEY_NUMPAD"]
local KEY_PAGEDOWN = L["KEY_PAGEDOWN"]
local KEY_PAGEUP = L["KEY_PAGEUP"]
local KEY_SHIFT = L["KEY_SHIFT"]
local KEY_SPACE = L["KEY_SPACE"]
local KEY_NMULTIPLY = L["KEY_NMULTIPLY"]
local KEY_NMINUS = L["KEY_NMINUS"]
local KEY_NPLUS = L["KEY_NPLUS"]
local KEY_NEQUALS = L["KEY_NEQUALS"]

--replace with colored class
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

if not E.db.ElvUI_EltreumUI.skins.colormodkey then
	L["KEY_ALT"] = KEY_ALT
	L["KEY_CTRL"] = KEY_CTRL
	L["KEY_DELETE"] = KEY_DELETE
	L["KEY_HOME"] = KEY_HOME
	L["KEY_INSERT"] = KEY_INSERT
	L["KEY_MOUSEBUTTON"] = KEY_MOUSEBUTTON
	L["KEY_MOUSEWHEELDOWN"] = KEY_MOUSEWHEELDOWN
	L["KEY_MOUSEWHEELUP"] = KEY_MOUSEWHEELUP
	L["KEY_NUMPAD"] = KEY_NUMPAD
	L["KEY_PAGEDOWN"] = KEY_PAGEDOWN
	L["KEY_PAGEUP"] = KEY_PAGEUP
	L["KEY_SHIFT"] = KEY_SHIFT
	L["KEY_SPACE"] = KEY_SPACE
	L["KEY_NMULTIPLY"] = KEY_NMULTIPLY
	L["KEY_NMINUS"] = KEY_NMINUS
	L["KEY_NPLUS"] = KEY_NPLUS
	L["KEY_NEQUALS"] = KEY_NEQUALS
end
