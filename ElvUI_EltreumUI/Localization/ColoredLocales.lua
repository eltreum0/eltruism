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
	["PALADIN"] = "F48CBA",
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
	-- these should be the modifiers only, so shift, alt, ctrl and meta (windows/mac os key).
	L["KEY_SHIFT"] = "|cff"..classcolorsescape[E.myclass]..L["KEY_SHIFT"].."|r"
	L["KEY_ALT"] = "|cff"..classcolorsescape[E.myclass]..L["KEY_ALT"].."|r"
	L["KEY_CTRL"] = "|cff"..classcolorsescape[E.myclass]..L["KEY_CTRL"].."|r"
	L["KEY_META"] = "|cff"..classcolorsescape[E.myclass]..L["KEY_META"].."|r"
end
