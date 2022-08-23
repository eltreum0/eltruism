local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local valuecolors = E:ClassColor(E.myclass, true)
local _G = _G
local IsAddOnLoaded = _G.IsAddOnLoaded
local tostring = _G.tostring
local SetCVar = _G.SetCVar


function ElvUI_EltreumUI:WeakAurasLikeActionBars()
	local point, relativeTo, relativePoint, xOfs, yOfs = strsplit("," ,E.db["movers"]["ElvAB_1"])
	print(point, relativeTo, relativePoint, xOfs, yOfs)




E.db["ElvUI_EltreumUI"]["skins"]["hideABkeypress"] = true

E.db["actionbar"]["bar1"]["backdropSpacing"] = 0
E.db["actionbar"]["bar1"]["buttonHeight"] = 30
E.db["actionbar"]["bar1"]["buttonSize"] = 43
E.db["actionbar"]["bar1"]["buttonSpacing"] = 3
E.db["actionbar"]["bar1"]["buttons"] = 8
E.db["actionbar"]["bar1"]["countFont"] = "Kimberley"
E.db["actionbar"]["bar1"]["countFontOutline"] = "THICKOUTLINE"
E.db["actionbar"]["bar1"]["hotkeyFont"] = "Kimberley"
E.db["actionbar"]["bar1"]["hotkeyFontOutline"] = "THICKOUTLINE"
E.db["actionbar"]["bar1"]["hotkeytext"] = false
E.db["actionbar"]["bar1"]["inheritGlobalFade"] = true
E.db["actionbar"]["bar1"]["keepSizeRatio"] = false
E.db["actionbar"]["bar1"]["macroFont"] = "Kimberley"
E.db["actionbar"]["bar1"]["macroFontOutline"] = "THICKOUTLINE"
E.db["actionbar"]["bar1"]["macroTextPosition"] = "BOTTOM"
E.db["actionbar"]["bar1"]["macroTextYOffset"] = 2
E.db["actionbar"]["bar1"]["macrotext"] = true
E.db["actionbar"]["bar1"]["paging"]["DRUID"] = ""
E.db["actionbar"]["bar1"]["paging"]["PALADIN"] = ""
E.db["actionbar"]["bar1"]["paging"]["PRIEST"] = ""
E.db["actionbar"]["bar1"]["paging"]["ROGUE"] = ""
E.db["actionbar"]["bar1"]["showGrid"] = false
E.db["actionbar"]["bar1"]["visibility"] = "[vehicleui] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"

E.db["actionbar"]["bar2"]["buttonHeight"] = 30
E.db["actionbar"]["bar2"]["buttonSize"] = 43
E.db["actionbar"]["bar2"]["buttonSpacing"] = 3
E.db["actionbar"]["bar2"]["buttons"] = 8
E.db["actionbar"]["bar2"]["countFont"] = "Kimberley"
E.db["actionbar"]["bar2"]["countFontOutline"] = "THICKOUTLINE"
E.db["actionbar"]["bar2"]["enabled"] = true
E.db["actionbar"]["bar2"]["hotkeyFont"] = "Kimberley"
E.db["actionbar"]["bar2"]["hotkeyFontOutline"] = "THICKOUTLINE"
E.db["actionbar"]["bar2"]["hotkeytext"] = false
E.db["actionbar"]["bar2"]["inheritGlobalFade"] = true
E.db["actionbar"]["bar2"]["keepSizeRatio"] = false
E.db["actionbar"]["bar2"]["macroFont"] = "Kimberley"
E.db["actionbar"]["bar2"]["macroFontOutline"] = "THICKOUTLINE"
E.db["actionbar"]["bar2"]["macroTextPosition"] = "BOTTOM"
E.db["actionbar"]["bar2"]["macroTextYOffset"] = 2
E.db["actionbar"]["bar2"]["macrotext"] = true
E.db["actionbar"]["bar2"]["paging"]["DEATHKNIGHT"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;"
E.db["actionbar"]["bar2"]["paging"]["DRUID"] = ""
E.db["actionbar"]["bar2"]["showGrid"] = false
E.db["actionbar"]["bar2"]["visibility"] = "[vehicleui] show; [overridebar] show; [possessbar] show; [petbattle] hide; show;"

E.db["actionbar"]["transparent"] = true
E.db["actionbar"]["useDrawSwipeOnCharges"] = true

E.db["movers"]["ClassBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,1,347"
E.db["movers"]["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,303"
E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,271"
E.db["movers"]["ElvNP_PlayerMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,334"
E.db["movers"]["ElvUF_TargetMover"] = "BOTTOM,ElvUIParent,BOTTOM,320,307"
E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-413,307"
E.db["movers"]["PlayerPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,337"
E.db["movers"]["PowerWidgetMover"] = "TOP,ElvUIParent,TOP,0,-102"

E.db["unitframe"]["units"]["player"]["classbar"]["detachFromFrame"] = true
E.db["unitframe"]["units"]["player"]["classbar"]["detachedWidth"] = 364
E.db["unitframe"]["units"]["player"]["classbar"]["fill"] = "spaced"
E.db["unitframe"]["units"]["player"]["classbar"]["height"] = 7
E.db["unitframe"]["units"]["player"]["classbar"]["sortDirection"] = "NONE"

E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"]["attachTextTo"] = "Power"
E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"]["enable"] = true
E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"]["font"] = "Kimberley"
E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"]["fontOutline"] = "THICKOUTLINE"
E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"]["justifyH"] = "CENTER"
E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"]["size"] = 12
E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"]["text_format"] = "[powercolor][power:current:shortvalue]"
E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"]["xOffset"] = 0
E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"]["yOffset"] = -1

E.db["unitframe"]["units"]["player"]["health"]["position"] = "RIGHT"
E.db["unitframe"]["units"]["player"]["health"]["text_format"] = ""
E.db["unitframe"]["units"]["player"]["health"]["xOffset"] = 0
E.db["unitframe"]["units"]["player"]["height"] = 45

E.db["unitframe"]["units"]["player"]["power"]["EnergyManaRegen"] = true
E.db["unitframe"]["units"]["player"]["power"]["attachTextTo"] = "Power"
E.db["unitframe"]["units"]["player"]["power"]["detachFromFrame"] = true
E.db["unitframe"]["units"]["player"]["power"]["detachedWidth"] = 361
E.db["unitframe"]["units"]["player"]["power"]["height"] = 7
E.db["unitframe"]["units"]["player"]["power"]["position"] = "CENTER"
E.db["unitframe"]["units"]["player"]["power"]["powerPrediction"] = true
E.db["unitframe"]["units"]["player"]["power"]["text_format"] = ""
E.db["unitframe"]["units"]["player"]["power"]["width"] = "spaced"
E.db["unitframe"]["units"]["player"]["power"]["xOffset"] = 0
E.db["unitframe"]["units"]["player"]["pvp"]["position"] = "CENTER"
E.db["unitframe"]["units"]["player"]["pvp"]["text_format"] = ""



end
