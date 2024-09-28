local E = unpack(ElvUI)
local _G = _G
local GetPhysicalScreenSize = _G.GetPhysicalScreenSize

--sets action bars/powers to be similar to weakaura's layouts
function ElvUI_EltreumUI:WeakAurasLikeActionBars(value)
	if not E.db.movers then E.db.movers = {} end

	if (E.db.ElvUI_EltreumUI.otherstuff.ABlikeWA or value) and E.private.actionbar.enable and E.private.unitframe.enable then
		local width = GetPhysicalScreenSize()

		--hide keypresses
		E.db["ElvUI_EltreumUI"]["skins"]["hideABkeypress"] = true

		--general actionbars settings
		E.db["actionbar"]["chargeCooldown"] = true
		E.db["actionbar"]["colorSwipeNormal"]["a"] = 1
		E.db["actionbar"]["cooldown"]["mmssThreshold"] = 60
		E.db["actionbar"]["cooldown"]["threshold"] = 5
		E.db["actionbar"]["desaturateOnCooldown"] = true
		E.db["unitframe"]["units"]["player"]["classbar"]["spacing"] = 5

		--fix debuffs
		E.db["unitframe"]["units"]["player"]["debuffs"]["yOffset"] = -44
		E.db["unitframe"]["units"]["target"]["buffs"]["yOffset"] = -44

		--unitframe stuff
		E.db["unitframe"]["units"]["targettarget"]["width"] = 100
		E.db["unitframe"]["units"]["player"]["power"]["autoHide"] = false

		--bar specific settings
		E.db["actionbar"]["bar1"]["backdropSpacing"] = 0
		E.db["actionbar"]["bar1"]["buttonHeight"] = 26
		E.db["actionbar"]["bar1"]["buttonSize"] = 43
		E.db["actionbar"]["bar1"]["buttonSpacing"] = 3
		E.db["actionbar"]["bar1"]["buttons"] = 8
		E.db["actionbar"]["bar1"]["enabled"] = true
		E.db["actionbar"]["bar1"]["flyoutDirection"] = "UP"
		E.db["actionbar"]["bar1"]["hotkeytext"] = false
		E.db["actionbar"]["bar1"]["inheritGlobalFade"] = true
		E.db["actionbar"]["bar1"]["keepSizeRatio"] = false
		E.db["actionbar"]["bar1"]["showGrid"] = false
		E.db["actionbar"]["bar1"]["buttonsPerRow"] = 8
		E.db["actionbar"]["bar1"]["visibility"] = "[vehicleui] show; [overridebar] show; [possessbar] show; [petbattle] hide; show;"
		if E.Retail or E.Cata then
			E.db["actionbar"]["bar1"]["paging"]["DEATHKNIGHT"] = "[overridebar] 18; [vehicleui] 16;[possessbar] 16;[bonusbar:5] 11;"
			E.db["actionbar"]["bar1"]["paging"]["DEMONHUNTER"] = "[overridebar] 18; [vehicleui] 16;[possessbar] 16;[bonusbar:5] 11;"
			E.db["actionbar"]["bar1"]["paging"]["DRUID"] = "[overridebar] 18; [vehicleui] 16; [possessbar] 16; [bonusbar:1,nostealth] 7; [bonusbar:1,stealth] 8; [bonusbar:2] 10; [bonusbar:3] 9; [bonusbar:4] 10;[bonusbar:5] 11;"
			E.db["actionbar"]["bar1"]["paging"]["HUNTER"] = "[overridebar] 18; [vehicleui] 16;[possessbar] 16;[bonusbar:5] 11;"
			E.db["actionbar"]["bar1"]["paging"]["MAGE"] = "[overridebar] 18; [vehicleui] 16;[possessbar] 16;[bonusbar:5] 11;"
			E.db["actionbar"]["bar1"]["paging"]["MONK"] = "[overridebar] 18; [vehicleui] 16; [possessbar] 16;[bonusbar:5] 11;"
			E.db["actionbar"]["bar1"]["paging"]["PALADIN"] = "[overridebar] 18; [vehicleui] 16; [possessbar] 16;[bonusbar:5] 11;"
			E.db["actionbar"]["bar1"]["paging"]["PRIEST"] = "[overridebar] 18; [vehicleui] 16; [possessbar] 16;[bonusbar:5] 11;"
			E.db["actionbar"]["bar1"]["paging"]["ROGUE"] = "[bonusbar:1] 7;[bonusbar:1,nostealth] 4; [bonusbar:1,stealth] 7; [overridebar] 18; [vehicleui] 16; [possessbar] 16;[bonusbar:2] 8;[bonusbar:5] 11;" --other other besides this was causing problems with shadow dance
			E.db["actionbar"]["bar1"]["paging"]["SHAMAN"] = "[overridebar] 18; [vehicleui] 16; [possessbar] 16;[bonusbar:5] 11;"
			E.db["actionbar"]["bar1"]["paging"]["WARLOCK"] = "[overridebar] 18; [vehicleui] 16;[possessbar] 16;[bonusbar:5] 11;"
			E.db["actionbar"]["bar1"]["paging"]["WARRIOR"] = "[overridebar] 18; [vehicleui] 16;[possessbar] 16;[bonusbar:5] 11;[stance:1] 7; [stance:2] 8; [stance:3] 9;"
			E.db["actionbar"]["bar1"]["paging"]["EVOKER"] = "[overridebar] 18; [vehicleui] 16; [possessbar] 16;[bonusbar:5] 11;[bonusbar:1] 7;"
		else
			E.db["actionbar"]["bar1"]["paging"]["DEATHKNIGHT"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[bonusbar:5] 11;"
			E.db["actionbar"]["bar1"]["paging"]["DEMONHUNTER"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[bonusbar:5] 11;"
			E.db["actionbar"]["bar1"]["paging"]["DRUID"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12; [bonusbar:1,nostealth] 7; [bonusbar:1,stealth] 8; [bonusbar:2] 10; [bonusbar:3] 9; [bonusbar:4] 10;[bonusbar:5] 11;"
			E.db["actionbar"]["bar1"]["paging"]["HUNTER"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[bonusbar:5] 11;"
			E.db["actionbar"]["bar1"]["paging"]["MAGE"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[bonusbar:5] 11;"
			E.db["actionbar"]["bar1"]["paging"]["MONK"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12;[bonusbar:5] 11;"
			E.db["actionbar"]["bar1"]["paging"]["PALADIN"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12;[bonusbar:5] 11;"
			E.db["actionbar"]["bar1"]["paging"]["ROGUE"] = "[bonusbar:1] 7;[bonusbar:1,nostealth] 4; [bonusbar:1,stealth] 7; [vehicleui] 12; [overridebar] 14; [possessbar] 12;[bonusbar:2] 8;[bonusbar:5] 11;" --other other besides this was causing problems with shadow dance
			E.db["actionbar"]["bar1"]["paging"]["SHAMAN"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12;[bonusbar:5] 11;"
			E.db["actionbar"]["bar1"]["paging"]["WARLOCK"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[form:1] 7;[bonusbar:5] 11;"
			E.db["actionbar"]["bar1"]["paging"]["WARRIOR"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[bonusbar:5] 11;[stance:1] 7; [stance:2] 8; [stance:3] 9;"
			E.db["actionbar"]["bar1"]["paging"]["PRIEST"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 16;[bonusbar:5] 11; [stance:1] 7;"
		end
		E.db["actionbar"]["bar2"]["buttonHeight"] = 26
		E.db["actionbar"]["bar2"]["buttonSize"] = 43
		E.db["actionbar"]["bar2"]["buttonSpacing"] = 3
		E.db["actionbar"]["bar2"]["buttons"] = 8
		E.db["actionbar"]["bar2"]["enabled"] = true
		E.db["actionbar"]["bar2"]["hotkeytext"] = false
		E.db["actionbar"]["bar2"]["inheritGlobalFade"] = true
		E.db["actionbar"]["bar2"]["keepSizeRatio"] = false
		E.db["actionbar"]["bar2"]["showGrid"] = false
		E.db["actionbar"]["bar2"]["buttonsPerRow"] = 8
		E.db["actionbar"]["bar2"]["visibility"] = "[vehicleui] show; [overridebar] show; [possessbar] show; [petbattle] hide; show;"

		E.db["actionbar"]["bar1"]["mouseover"] = false
		E.db["actionbar"]["bar2"]["mouseover"] = false
		E.db["actionbar"]["bar3"]["mouseover"] = true
		E.db["actionbar"]["bar4"]["mouseover"] = true
		E.db["actionbar"]["bar5"]["mouseover"] = true

		--adjust based on class having a classbar or not
		_G.ElvUF_PlayerMover:ClearAllPoints()
		_G.ElvUF_PlayerCastbarMover:ClearAllPoints()
		_G.ElvUF_TargetCastbarMover:ClearAllPoints()
		_G.ElvUF_TargetMover:ClearAllPoints()

		E.db["movers"]["ClassBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,346"
		E.db["movers"]["PlayerPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,338"
		E.db["unitframe"]["units"]["player"]["power"]["detachedWidth"] = 359
		E.db["unitframe"]["units"]["player"]["classbar"]["detachedWidth"] = 359
		E.db["movers"]["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,308"
		E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,280"
		E.db["movers"]["ShiftAB"] = "BOTTOM,ElvUIParent,BOTTOM,0,258"
		if _G.ElvUF_Player_ClassBar and _G.ElvUF_Player_ClassBar:IsVisible() then
			E.db["unitframe"]["units"]["player"]["classbar"]["detachedWidth"] = 365
			E.db["unitframe"]["units"]["player"]["power"]["detachedWidth"] = 366
			E.db["movers"]["ElvUF_PlayerMover"] = "TOPRIGHT,ElvUF_Player_ClassBar,TOPLEFT,-6,3"
			E.db["movers"]["ElvUF_TargetMover"] = "TOPLEFT,ElvUF_Player_ClassBar,TOPRIGHT,6,3"
			E.db["movers"]["ElvUF_PlayerCastbarMover"] = "TOP,ElvUF_Player,BOTTOM,15,-10"
			E.db["movers"]["ElvUF_TargetCastbarMover"] = "TOP,ElvUF_Target,BOTTOM,14,-10"
			E.db["movers"]["TargetPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,256,301"
			E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-399,309"
			E.db["movers"]["TargetTargetPowerBarMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-403,301"
			if width == 2560 then
				E.db["unitframe"]["units"]["player"]["classbar"]["detachedWidth"] = 361
				E.db["unitframe"]["units"]["player"]["power"]["detachedWidth"] = 360
				E.db["movers"]["ClassBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,1,346"
				E.db["movers"]["PlayerPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,338"
				E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-399,311"
			elseif width == 3840 then
				E.db["unitframe"]["units"]["player"]["classbar"]["detachedWidth"] = 361
				E.db["unitframe"]["units"]["player"]["power"]["detachedWidth"] = 359
				E.db["movers"]["ClassBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,2,346"
				E.db["movers"]["PlayerPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,1,338"
				E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-399,310"
			end
		elseif (_G.ElvUF_Player.Totems and _G.ElvUF_Player.Totems:IsVisible()) then
			E.db["movers"]["ClassBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,2,346"
			E.db["movers"]["PlayerPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,1,337"
			E.db["unitframe"]["units"]["player"]["classbar"]["detachedWidth"] = 361
			E.db["unitframe"]["units"]["player"]["power"]["detachedWidth"] = 360
			E.db["unitframe"]["units"]["player"]["classbar"]["spacing"] = 5
			E.db["movers"]["ElvUF_PlayerMover"] = "TOPRIGHT,ElvUF_PlayerTotem1,BOTTOMLEFT,-6,6"
			E.db["movers"]["ElvUF_TargetMover"] = "TOPLEFT,ElvUF_PlayerTotem4,BOTTOMRIGHT,6,6"
			E.db["movers"]["ElvUF_PlayerCastbarMover"] = "TOP,ElvUF_Player,BOTTOM,15,-10"
			E.db["movers"]["ElvUF_TargetCastbarMover"] = "TOP,ElvUF_Target,BOTTOM,14,-10"
			E.db["movers"]["TargetPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,256,301"
			E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-397,308"
			E.db["movers"]["TargetTargetPowerBarMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-402,301"
			if width == 2560 then
				E.db["unitframe"]["units"]["player"]["power"]["detachedWidth"] = 365
				E.db["unitframe"]["units"]["player"]["classbar"]["detachedWidth"] = 362
				E.db["movers"]["ClassBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,1,346"
				E.db["movers"]["PlayerPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,337"
				E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-397,309"
			elseif width == 1920 then
				E.db["unitframe"]["units"]["player"]["power"]["detachedWidth"] = 366
				E.db["unitframe"]["units"]["player"]["classbar"]["detachedWidth"] = 366
				E.db["movers"]["PlayerPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,337"
				E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-397,307"
				E.db["movers"]["ClassBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,346"
				E.db["unitframe"]["units"]["player"]["classbar"]["spacing"] = 6
			end
		elseif _G.ElvUF_Player_Runes and _G.ElvUF_Player_Runes:IsVisible() then
			E.db["movers"]["ClassBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,1,346"
			E.db["unitframe"]["units"]["player"]["classbar"]["detachedWidth"] = 362

			E.db["movers"]["ElvUF_PlayerMover"] = "TOPRIGHT,ElvUF_Player_PowerBar,BOTTOMLEFT,-6,13"
			E.db["movers"]["ElvUF_TargetMover"] = "TOPLEFT,ElvUF_Player_PowerBar,BOTTOMRIGHT,4,13"
			E.db["movers"]["ElvUF_PlayerCastbarMover"] = "TOP,ElvUF_Player,BOTTOM,15,-10"
			E.db["movers"]["ElvUF_TargetCastbarMover"] = "TOP,ElvUF_Target,BOTTOM,14,-10"
			E.db["movers"]["TargetPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,256,301"
			E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-397,308"
			E.db["movers"]["TargetTargetPowerBarMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-402,301"
			if width == 2560 then
				E.db["unitframe"]["units"]["player"]["power"]["detachedWidth"] = 360
				E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-397,309"
			elseif width == 1920 then
				E.db["unitframe"]["units"]["player"]["power"]["detachedWidth"] = 361
				E.db["unitframe"]["units"]["player"]["classbar"]["detachedWidth"] = 361
				E.db["movers"]["PlayerPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,1,338"
				E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-397,307"
			end
		elseif _G.ElvUF_Player_AdditionalPowerBar and _G.ElvUF_Player_AdditionalPowerBar:IsVisible() then
			E.db["movers"]["ElvUF_PlayerMover"] = "TOPRIGHT,ElvUF_Player_AdditionalPowerBar,BOTTOMLEFT,-6,6"
			E.db["movers"]["ElvUF_TargetMover"] = "TOPLEFT,ElvUF_Player_AdditionalPowerBar,BOTTOMRIGHT,6,6"
			E.db["movers"]["ElvUF_PlayerCastbarMover"] = "TOP,ElvUF_Player,BOTTOM,15,-10"
			E.db["movers"]["ElvUF_TargetCastbarMover"] = "TOP,ElvUF_Target,BOTTOM,14,-10"
			E.db["movers"]["TargetPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,256,301"
			E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-397,308"
			E.db["movers"]["TargetTargetPowerBarMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-401,301"
			if width == 1920 then
				E.db["unitframe"]["units"]["player"]["power"]["detachedWidth"] = 365
				E.db["unitframe"]["units"]["player"]["classbar"]["detachedWidth"] = 365
				E.db["movers"]["PlayerPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,1,338"
				E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-397,307"
			end
		elseif _G.ElvUF_Player_Stagger and _G.ElvUF_Player_Stagger:IsVisible() then
			E.db["movers"]["ElvUF_PlayerMover"] = "TOPRIGHT,ElvUF_Player_Stagger,BOTTOMLEFT,-6,6"
			E.db["movers"]["ElvUF_TargetMover"] = "TOPLEFT,ElvUF_Player_Stagger,BOTTOMRIGHT,6,6"
			E.db["movers"]["ElvUF_PlayerCastbarMover"] = "TOP,ElvUF_Player,BOTTOM,15,-10"
			E.db["movers"]["ElvUF_TargetCastbarMover"] = "TOP,ElvUF_Target,BOTTOM,14,-10"
			E.db["movers"]["TargetPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,256,301"
			E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-397,308"
			E.db["movers"]["TargetTargetPowerBarMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-401,301"
			if width == 1920 then
				E.db["unitframe"]["units"]["player"]["power"]["detachedWidth"] = 365
				E.db["unitframe"]["units"]["player"]["classbar"]["detachedWidth"] = 365
				E.db["movers"]["PlayerPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,1,338"
				E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-397,307"
			elseif width == 2560 then
				E.db["unitframe"]["units"]["player"]["power"]["detachedWidth"] = 360
				E.db["unitframe"]["units"]["player"]["classbar"]["detachedWidth"] = 360
				E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-397,309"
			end
		else
			E.db["actionbar"]["bar1"]["buttonHeight"] = 36
			E.db["actionbar"]["bar2"]["buttonHeight"] = 36
			E.db["unitframe"]["units"]["player"]["classbar"]["detachedWidth"] = 362
			E.db["unitframe"]["units"]["player"]["power"]["detachedWidth"] = 360
			E.db["movers"]["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,299"
			E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,262"
			E.db["movers"]["ShiftAB"] = "BOTTOM,ElvUIParent,BOTTOM,0,240"
			E.db["movers"]["ElvUF_PlayerMover"] = "TOPRIGHT,ElvUF_Player_PowerBar,BOTTOMLEFT,-6,5"
			E.db["movers"]["ElvUF_TargetMover"] = "TOPLEFT,ElvUF_Player_PowerBar,BOTTOMRIGHT,6,5"
			E.db["movers"]["ElvUF_PlayerCastbarMover"] = "TOP,ElvUF_Player,BOTTOM,15,-10"
			E.db["movers"]["ElvUF_TargetCastbarMover"] = "TOP,ElvUF_Target,BOTTOM,14,-10"
			E.db["movers"]["TargetPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,256,292"
			E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-397,299"
			E.db["movers"]["TargetTargetPowerBarMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-401,292"
			if width == 2560 then
				E.db["unitframe"]["units"]["player"]["power"]["detachedWidth"] = 360
				E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-397,300"
			elseif width == 1920 then
				E.db["unitframe"]["units"]["player"]["power"]["detachedWidth"] = 366
				E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-397,298"
			end
		end

		--unitframes, making sure it detaches
		E.db["unitframe"]["units"]["player"]["classbar"]["detachFromFrame"] = true
		E.db["unitframe"]["units"]["player"]["classbar"]["fill"] = "spaced"
		E.db["unitframe"]["units"]["player"]["classbar"]["height"] = 7
		E.db["unitframe"]["units"]["player"]["height"] = 45
		E.db["unitframe"]["units"]["player"]["power"]["detachFromFrame"] = true
		E.db["unitframe"]["units"]["player"]["power"]["height"] = 7
		E.db["unitframe"]["units"]["player"]["power"]["position"] = "CENTER"

		--adjust power text
		if E.db["unitframe"]["units"]["player"]["customTexts"] and E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"]["justifyH"] = "CENTER"
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"]["size"] = 16
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

		ElvUI_EltreumUI:Print("Enabled WeakAuras ActionBars Mode, please reload")
	else
		--dont hide keypress
		E.db["ElvUI_EltreumUI"]["skins"]["hideABkeypress"] = false

		E.db["actionbar"]["bar1"]["hotkeytext"] = true
		E.db["actionbar"]["bar1"]["showGrid"] = true
		E.db["actionbar"]["bar2"]["hotkeytext"] = true
		E.db["actionbar"]["bar2"]["showGrid"] = true
		E.db["actionbar"]["bar3"]["mouseover"] = false
		E.db["actionbar"]["bar4"]["mouseover"] = false
		E.db["actionbar"]["bar5"]["mouseover"] = false

		--to fix the anchor
		_G.ElvUF_PlayerMover:ClearAllPoints()
		E.db["movers"]["ElvUF_PlayerMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,510,339"
		_G.ElvUF_PlayerCastbarMover:ClearAllPoints()
		E.db["movers"]["ElvUF_PlayerCastbarMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,510,309"
		_G.ElvUF_TargetCastbarMover:ClearAllPoints()
		E.db["movers"]["ElvUF_TargetCastbarMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-510,308"
		_G.ElvUF_TargetMover:ClearAllPoints()
		E.db["movers"]["ElvUF_TargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-510,339"
		E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-371,339"
		--local point, relativeTo, relativePoint, xOfs, yOfs = strsplit("," ,E.db["movers"]["ElvAB_1"])
		--print(point, relativeTo, relativePoint, xOfs, yOfs)

		--fix unitframes health/power/class
		E.db["unitframe"]["units"]["player"]["height"] = 54
		E.db["unitframe"]["units"]["target"]["height"] = 54
		E.db["unitframe"]["units"]["targettarget"]["height"] = 54
		E.db["unitframe"]["units"]["player"]["classbar"]["height"] = 10
		E.db["unitframe"]["units"]["player"]["power"]["height"] = 15
		E.db["unitframe"]["units"]["target"]["power"]["height"] = 15
		E.db["unitframe"]["units"]["target"]["power"]["detachFromFrame"] = false
		E.db["unitframe"]["units"]["targettarget"]["power"]["detachFromFrame"] = false
		E.db["unitframe"]["units"]["player"]["classbar"]["detachFromFrame"] = false
		E.db["unitframe"]["units"]["player"]["power"]["detachFromFrame"] = false

		--adjust power text
		if E.db["unitframe"]["units"]["player"]["customTexts"] and E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"]["justifyH"] = "RIGHT"
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"]["size"] = 10
		else
			E.db["unitframe"]["units"]["player"]["power"]["position"] = "RIGHT"
			E.db["unitframe"]["units"]["player"]["power"]["text_format"] = "[power:current:shortvalue]"
		end

		ElvUI_EltreumUI:Print("Disabled WeakAuras ActionBars Mode, please reload")
	end
	E:UpdateActionBars()
	E:UpdateUnitFrames()
	E:UpdateMoverPositions()

	E:StaticPopup_Show('CONFIG_RL')
end
