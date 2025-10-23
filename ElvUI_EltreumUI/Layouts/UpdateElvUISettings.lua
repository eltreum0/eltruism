local E, L = unpack(ElvUI)

--profile updates, so that whole profile doesnt need to be reimported
function ElvUI_EltreumUI:UpdateElvUISettings(update)
	if not E.db.movers then E.db.movers = {} end

	if update then
		if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") or ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer") or ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Thin") then

			--[[if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") then
				E.db["movers"]["TotemTrackerMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,276" --adjusted for the additional power in druid/monk in mop
				E.db["movers"]["AdditionalPowerMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,260"
			end

			if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer") then
				E.db["movers"]["AdditionalPowerMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,341" --move it below the castbar for monk/druid in mop
			end

			if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Thin") then
				E.db["movers"]["AdditionalPowerMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,260" --due to new monk/druid in mop
			end]]

			--[[if E.Retail then
				ElvUI_EltreumUI:ModelsToggle(true) --disable models after layout for now due to the 3D model bug
			end]]

			--rerun elvui style filters due to elvui np changes (but only if it was an old version)
			if E.private.ElvUI_EltreumUI.install_version < "4.3.9" then
				ElvUI_EltreumUI:SetupStyleFilters()
			end

			--disable the custom auras on target and enemy npc
			E.db["unitframe"]["units"]["target"]["auras"]["enable"] = false
			E.db["nameplates"]["units"]["ENEMY_NPC"]["auras"]["enable"] = false

			--fix power prediction color overlapping some other colors
			E.db["unitframe"]["colors"]["powerPrediction"]["additional"]["a"] = 0.7
			E.db["unitframe"]["colors"]["powerPrediction"]["additional"]["b"] = 1
			E.db["unitframe"]["colors"]["powerPrediction"]["additional"]["g"] = 1
			E.db["unitframe"]["colors"]["powerPrediction"]["additional"]["r"] = 1
			E.db["unitframe"]["colors"]["powerPrediction"]["color"]["a"] = 0.7
			E.db["unitframe"]["colors"]["powerPrediction"]["color"]["b"] = 1
			E.db["unitframe"]["colors"]["powerPrediction"]["color"]["g"] = 1
			E.db["unitframe"]["colors"]["powerPrediction"]["color"]["r"] = 1
			E.db["unitframe"]["colors"]["powerPrediction"]["enable"] = true

			E.db["bags"]["bankCombined"] = true
			E.db["bags"]["bankSize"] = 35
			E.db["bags"]["bankWidth"] = 920
			E.db["bags"]["split"]["alwaysProfessionBank"] = true
			E.db["bags"]["split"]["bag5"] = true
			E.db["bags"]["split"]["bagSpacing"] = 7
			E.db["bags"]["split"]["bank"] = true
			E.db["bags"]["split"]["bank10"] = true
			E.db["bags"]["split"]["bank11"] = true
			E.db["bags"]["split"]["bank7"] = true
			E.db["bags"]["split"]["bank8"] = true
			E.db["bags"]["split"]["bank9"] = true
			E.db["bags"]["split"]["bankSpacing"] = 1
			E.db["bags"]["split"]["player"] = true
			E.db["bags"]["split"]["warband"] = true
			E.db["bags"]["split"]["warband14"] = true
			E.db["bags"]["split"]["warband15"] = true
			E.db["bags"]["split"]["warband16"] = true
			E.db["bags"]["useBlizzardJunk"] = false
			E.db["bags"]["warbandSize"] = 35

			E.db["movers"]["ObjectiveFrameMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-6,-254"

			--new anchors
			E.db["tooltip"]["cursorAnchorType"] = "ANCHOR_CURSOR"
			E.db["auras"]["buffs"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["auras"]["buffs"]["tooltipAnchorX"] = 0
			E.db["auras"]["buffs"]["tooltipAnchorY"] = 0
			E.db["auras"]["debuffs"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["auras"]["debuffs"]["tooltipAnchorX"] = 0
			E.db["auras"]["debuffs"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["arena"]["auras"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["arena"]["auras"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["arena"]["auras"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["arena"]["buffs"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["arena"]["buffs"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["arena"]["buffs"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["arena"]["debuffs"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["arena"]["debuffs"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["arena"]["debuffs"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["assist"]["auras"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["assist"]["auras"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["assist"]["auras"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["assist"]["buffs"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["assist"]["buffs"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["assist"]["buffs"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["assist"]["debuffs"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["assist"]["debuffs"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["assist"]["debuffs"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["boss"]["auras"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["boss"]["auras"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["boss"]["auras"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["boss"]["buffs"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["boss"]["buffs"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["boss"]["buffs"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["boss"]["debuffs"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["boss"]["debuffs"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["boss"]["debuffs"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["focus"]["aurabar"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["focus"]["aurabar"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["focus"]["aurabar"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["focus"]["auras"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["focus"]["auras"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["focus"]["auras"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["focus"]["buffs"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["focus"]["buffs"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["focus"]["buffs"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["focus"]["debuffs"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["focus"]["debuffs"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["focus"]["debuffs"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["focustarget"]["auras"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["focustarget"]["auras"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["focustarget"]["auras"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["focustarget"]["buffs"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["focustarget"]["buffs"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["focustarget"]["buffs"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["focustarget"]["debuffs"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["focustarget"]["debuffs"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["focustarget"]["debuffs"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["party"]["auras"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["party"]["auras"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["party"]["auras"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["party"]["buffs"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["party"]["buffs"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["party"]["buffs"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["party"]["debuffs"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["party"]["debuffs"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["party"]["debuffs"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["pet"]["aurabar"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["pet"]["aurabar"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["pet"]["aurabar"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["pet"]["auras"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["pet"]["auras"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["pet"]["auras"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["pet"]["buffs"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["pet"]["buffs"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["pet"]["buffs"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["pet"]["debuffs"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["pet"]["debuffs"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["pet"]["debuffs"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["pettarget"]["buffs"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["pettarget"]["buffs"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["pettarget"]["buffs"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["player"]["aurabar"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["player"]["aurabar"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["player"]["aurabar"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["player"]["auras"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["player"]["auras"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["player"]["auras"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["player"]["buffs"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["player"]["buffs"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["player"]["buffs"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["player"]["debuffs"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["player"]["debuffs"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["player"]["debuffs"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["raid1"]["auras"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["raid1"]["auras"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["raid1"]["auras"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["raid1"]["buffs"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["raid1"]["buffs"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["raid1"]["buffs"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["raid1"]["debuffs"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["raid1"]["debuffs"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["raid1"]["debuffs"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["raid2"]["auras"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["raid2"]["auras"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["raid2"]["auras"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["raid2"]["buffs"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["raid2"]["buffs"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["raid2"]["buffs"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["raid2"]["debuffs"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["raid2"]["debuffs"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["raid2"]["debuffs"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["raid3"]["auras"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["raid3"]["auras"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["raid3"]["auras"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["raid3"]["buffs"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["raid3"]["buffs"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["raid3"]["buffs"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["raid3"]["debuffs"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["raid3"]["debuffs"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["raid3"]["debuffs"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["raidpet"]["auras"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["raidpet"]["auras"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["raidpet"]["auras"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["raidpet"]["buffs"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["raidpet"]["buffs"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["raidpet"]["buffs"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["raidpet"]["debuffs"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["raidpet"]["debuffs"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["raidpet"]["debuffs"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["tank"]["auras"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["tank"]["auras"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["tank"]["auras"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["tank"]["buffs"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["tank"]["buffs"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["tank"]["buffs"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["tank"]["debuffs"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["tank"]["debuffs"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["tank"]["debuffs"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["target"]["aurabar"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["target"]["aurabar"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["target"]["aurabar"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["target"]["auras"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["target"]["auras"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["target"]["auras"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["target"]["buffs"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["target"]["buffs"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["target"]["buffs"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["target"]["debuffs"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["target"]["debuffs"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["target"]["debuffs"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["targettarget"]["auras"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["targettarget"]["auras"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["targettarget"]["auras"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["targettarget"]["buffs"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["targettarget"]["buffs"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["targettarget"]["buffs"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["targettarget"]["debuffs"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["targettarget"]["debuffs"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["targettarget"]["debuffs"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["targettargettarget"]["auras"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["targettargettarget"]["auras"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["targettargettarget"]["auras"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["targettargettarget"]["buffs"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["targettargettarget"]["buffs"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["targettargettarget"]["buffs"]["tooltipAnchorY"] = 0
			E.db["unitframe"]["units"]["targettargettarget"]["debuffs"]["tooltipAnchorType"] = "ANCHOR_CURSOR"
			E.db["unitframe"]["units"]["targettargettarget"]["debuffs"]["tooltipAnchorX"] = 0
			E.db["unitframe"]["units"]["targettargettarget"]["debuffs"]["tooltipAnchorY"] = 0

			ElvUI_EltreumUI:Print(L["Settings for ElvUI were updated."])
		end
	else
		--luckyone based optimizations
		E.db["auras"]["buffs"]["seperateOwn"] = 0 -- do not sort auras
		E.db["auras"]["debuffs"]["seperateOwn"] = 0 -- do not sort auras
		E.db["chat"]["fade"] = true -- fade text again
		E.db["unitframe"]["units"]["assist"]["enable"] = false --disable assist/tank frames
		E.db["unitframe"]["units"]["tank"]["enable"] = false --disable assist/tank frames
		E.db["unitframe"]["units"]["boss"]["fader"]["smooth"] = 0 --used to be 0.25
		E.db["unitframe"]["units"]["player"]["fader"]["smooth"] = 0 --used to be 0.25
		E.db["unitframe"]["units"]["target"]["fader"]["smooth"] = 0 --used to be 0.25
		E.db["unitframe"]["units"]["targettarget"]["fader"]["smooth"] = 0
		E.db["unitframe"]["units"]["focus"]["fader"]["smooth"] = 0 --used to be 0.25
		E.db["unitframe"]["units"]["pet"]["fader"]["smooth"] = 0 --used to be 0.25
		E.db["unitframe"]["units"]["arena"]["fader"]["smooth"] = 0
		E.db["unitframe"]["units"]["boss"]["fader"]["smooth"] = 0
		E.db["unitframe"]["units"]["party"]["fader"]["smooth"] = 0
		E.db["unitframe"]["units"]["raid1"]["fader"]["smooth"] = 0
		E.db["unitframe"]["units"]["raid2"]["fader"]["smooth"] = 0
		E.db["unitframe"]["units"]["raid3"]["fader"]["smooth"] = 0
		E.db["general"]["altPowerBar"]["smoothbars"] = false --was true
		E.db["nameplates"]["smoothbars"] = false --was true
		E.db["unitframe"]["smoothbars"] = false --was true
		E.db["tooltip"]["inspectDataEnable"] = false --was true
		E.db["tooltip"]["mythicDataEnable"] = false --was true
		E.db["tooltip"]["role"] = false --was true
		E.db["tooltip"]["targetInfo"] = false --was true
		E.db["tooltip"]["showMount"] = false --was true

		--disable rarity color, so that items color by lowest ilvl > highest
		E.db["general"]["itemLevel"]["itemLevelRarity"] = false
		E.db["general"]["itemLevel"]["enchantAbbrev"] = true
		E.db["general"]["itemLevel"]["showItemLevel"] = true
		E.db["general"]["itemLevel"]["showEnchants"] = true
		E.db["general"]["itemLevel"]["showGems"] = true

		ElvUI_EltreumUI:Print(L["Settings for ElvUI were updated."])
	end
end
