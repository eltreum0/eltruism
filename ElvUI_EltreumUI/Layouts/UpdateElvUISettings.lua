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

			--rerun elvui style filters due to elvui np changes
			ElvUI_EltreumUI:SetupStyleFilters()

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
