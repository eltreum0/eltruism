local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G

--sets action bars/powers to be similar to weakaura's layouts
function ElvUI_EltreumUI:WeakAurasLikeActionBars()
	local point, relativeTo, relativePoint, xOfs, yOfs = strsplit("," ,E.db["movers"]["ElvAB_1"])
	print(point, relativeTo, relativePoint, xOfs, yOfs)

	E.db["ElvUI_EltreumUI"]["skins"]["hideABkeypress"] = true

	--general actionbars settings
	E.db["actionbar"]["chargeCooldown"] = true
	E.db["actionbar"]["colorSwipeNormal"]["a"] = 1
	E.db["actionbar"]["cooldown"]["mmssThreshold"] = 60
	E.db["actionbar"]["cooldown"]["threshold"] = 5
	E.db["actionbar"]["desaturateOnCooldown"] = true

	--bar specific settings
	E.db["actionbar"]["bar1"]["backdropSpacing"] = 0
	E.db["actionbar"]["bar1"]["buttonHeight"] = 30
	E.db["actionbar"]["bar1"]["buttonSize"] = 43
	E.db["actionbar"]["bar1"]["buttonSpacing"] = 3
	E.db["actionbar"]["bar1"]["buttons"] = 8
	E.db["actionbar"]["bar1"]["flyoutDirection"] = "UP"
	E.db["actionbar"]["bar1"]["hotkeytext"] = false
	E.db["actionbar"]["bar1"]["inheritGlobalFade"] = true
	E.db["actionbar"]["bar1"]["keepSizeRatio"] = false
	E.db["actionbar"]["bar1"]["showGrid"] = false
	E.db["actionbar"]["bar1"]["visibility"] = "[vehicleui] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
	E.db["actionbar"]["bar2"]["buttonHeight"] = 30
	E.db["actionbar"]["bar2"]["buttonSize"] = 43
	E.db["actionbar"]["bar2"]["buttonSpacing"] = 3
	E.db["actionbar"]["bar2"]["buttons"] = 8
	E.db["actionbar"]["bar2"]["enabled"] = true
	E.db["actionbar"]["bar2"]["hotkeytext"] = false
	E.db["actionbar"]["bar2"]["inheritGlobalFade"] = true
	E.db["actionbar"]["bar2"]["keepSizeRatio"] = false
	E.db["actionbar"]["bar2"]["showGrid"] = false
	E.db["actionbar"]["bar2"]["visibility"] = "[vehicleui] show; [overridebar] show; [possessbar] show; [petbattle] hide; show;"
	E.db["actionbar"]["bar3"]["mouseover"] = true
	E.db["actionbar"]["bar4"]["mouseover"] = true

	--adjust based on class having a classbar or not
	if _G.ElvUF_Player.Totems and _G.ElvUF_Player.Totems:IsVisible() == true then
		E.db["movers"]["ClassBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,1,346"
		E.db["movers"]["PlayerPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,337"
		E.db["movers"]["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,303"
		E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,271"
		E.db["movers"]["ShiftAB"] = "BOTTOM,ElvUIParent,BOTTOM,0,248"
	else
		E.db["movers"]["PlayerPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,346"
		E.db["movers"]["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,312"
		E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,280"
		E.db["movers"]["ShiftAB"] = "BOTTOM,ElvUIParent,BOTTOM,0,257"
	end

	--other movers


	--[[E.db["movers"]["ElvUF_PlayerMover"] = "BOTTOM,ElvUIParent,BOTTOM,-320,307"
	E.db["movers"]["ElvUF_PlayerCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,-306,269"
	E.db["movers"]["ElvUF_TargetMover"] = "BOTTOM,ElvUIParent,BOTTOM,320,307"
	E.db["movers"]["ElvUF_TargetCastbarMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-520,269"
	E.db["movers"]["TargetPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,256,301"
	E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-413,307"
	E.db["movers"]["TargetTargetPowerBarMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-417,301"]]

	E.db["movers"]["ElvUF_PlayerMover"] = "TOPRIGHT,ElvUF_Player_PowerBar,BOTTOMLEFT,-4,5"
	E.db["movers"]["ElvUF_TargetMover"] = "TOPLEFT,ElvUF_Player_PowerBar,BOTTOMRIGHT,4,5"

	E.db["movers"]["ElvUF_PlayerCastbarMover"] = "TOP,ElvUF_Player,BOTTOM,15,-10"
	E.db["movers"]["ElvUF_TargetCastbarMover"] = "TOP,ElvUF_Target,BOTTOM,14,-10"

	E.db["movers"]["TargetPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,256,301"
	E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-413,307"
	E.db["movers"]["TargetTargetPowerBarMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-417,301"

	--unitframes, making sure it detaches
	E.db["unitframe"]["units"]["player"]["classbar"]["detachFromFrame"] = true
	E.db["unitframe"]["units"]["player"]["classbar"]["detachedWidth"] = 364
	E.db["unitframe"]["units"]["player"]["classbar"]["fill"] = "spaced"
	E.db["unitframe"]["units"]["player"]["classbar"]["height"] = 7
	E.db["unitframe"]["units"]["player"]["height"] = 45
	E.db["unitframe"]["units"]["player"]["power"]["detachFromFrame"] = true
	E.db["unitframe"]["units"]["player"]["power"]["detachedWidth"] = 361
	E.db["unitframe"]["units"]["player"]["power"]["height"] = 7
	E.db["unitframe"]["units"]["player"]["power"]["position"] = "CENTER"

	--adjust power text
	if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"] then
		E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"]["justifyH"] = "CENTER"
		E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"]["size"] = 12
		E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"]["text_format"] = "[power:current:shortvalue]"
	else
		E.db["unitframe"]["units"]["player"]["power"]["position"] = "CENTER"
		E.db["unitframe"]["units"]["player"]["power"]["text_format"] = "[power:current:shortvalue]"
	end

	--fix unitframes health/power/class
	E.db["unitframe"]["units"]["target"]["height"] = 45
	E.db["unitframe"]["units"]["player"]["power"]["width"] = "spaced"
	E.db["unitframe"]["units"]["target"]["power"]["attachTextTo"] = "Power"
	E.db["unitframe"]["units"]["target"]["power"]["detachFromFrame"] = true
	E.db["unitframe"]["units"]["target"]["power"]["detachedWidth"] = 132
	E.db["unitframe"]["units"]["target"]["power"]["height"] = 15
	E.db["unitframe"]["units"]["target"]["power"]["width"] = "spaced"
	E.db["unitframe"]["units"]["targettarget"]["height"] = 45
	E.db["unitframe"]["units"]["targettarget"]["power"]["detachFromFrame"] = true
	E.db["unitframe"]["units"]["targettarget"]["power"]["detachedWidth"] = 90
	E.db["unitframe"]["units"]["targettarget"]["power"]["height"] = 15
	E.db["unitframe"]["units"]["targettarget"]["power"]["width"] = "spaced"

	E:UpdateActionBars()
	E:UpdateUnitFrames()
	E:UpdateMoverPositions()
end
