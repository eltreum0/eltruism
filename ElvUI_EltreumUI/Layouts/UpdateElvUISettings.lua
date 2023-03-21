local E, L, V, P, G = unpack(ElvUI)

--profile updates, so that whole profile doesnt need to be reimported
function ElvUI_EltreumUI:UpdateElvUISettings()
	E.db["unitframe"]["colors"]["classResources"]["MONK"][1]["b"] = 0.57254904508591
	E.db["unitframe"]["colors"]["classResources"]["MONK"][1]["g"] = 1
	E.db["unitframe"]["colors"]["classResources"]["MONK"][1]["r"] = 0.078431375324726
	E.db["unitframe"]["colors"]["classResources"]["MONK"][2]["b"] = 0.61568629741669
	E.db["unitframe"]["colors"]["classResources"]["MONK"][2]["g"] = 1
	E.db["unitframe"]["colors"]["classResources"]["MONK"][2]["r"] = 0.082352943718433
	E.db["unitframe"]["colors"]["classResources"]["MONK"][3]["b"] = 0.7294117808342
	E.db["unitframe"]["colors"]["classResources"]["MONK"][3]["g"] = 1
	E.db["unitframe"]["colors"]["classResources"]["MONK"][3]["r"] = 0.098039224743843
	E.db["unitframe"]["colors"]["classResources"]["MONK"][4]["b"] = 0.78039222955704
	E.db["unitframe"]["colors"]["classResources"]["MONK"][4]["g"] = 1
	E.db["unitframe"]["colors"]["classResources"]["MONK"][4]["r"] = 0.094117656350136
	E.db["unitframe"]["colors"]["classResources"]["MONK"][5]["b"] = 0.85490202903748
	E.db["unitframe"]["colors"]["classResources"]["MONK"][5]["g"] = 1
	E.db["unitframe"]["colors"]["classResources"]["MONK"][5]["r"] = 0.10588236153126
	E.db["unitframe"]["colors"]["classResources"]["MONK"][6]["b"] = 0.93333339691162
	E.db["unitframe"]["colors"]["classResources"]["MONK"][6]["g"] = 1
	E.db["unitframe"]["colors"]["classResources"]["MONK"][6]["r"] = 0.11372549831867
	E.db["unitframe"]["colors"]["classResources"]["chargedComboPoint"]["g"] = 0.63921570777893
	E.db["unitframe"]["colors"]["classResources"]["chargedComboPoint"]["r"] = 0.16078431904316
	E.db["unitframe"]["colors"]["classResources"]["comboPoints"][1]["b"] = 0.05882353335619
	E.db["unitframe"]["colors"]["classResources"]["comboPoints"][1]["g"] = 0.41960787773132
	E.db["unitframe"]["colors"]["classResources"]["comboPoints"][1]["r"] = 1
	E.db["unitframe"]["colors"]["classResources"]["comboPoints"][2]["b"] = 0.10196079313755
	E.db["unitframe"]["colors"]["classResources"]["comboPoints"][2]["g"] = 0.33725491166115
	E.db["unitframe"]["colors"]["classResources"]["comboPoints"][2]["r"] = 1
	E.db["unitframe"]["colors"]["classResources"]["comboPoints"][3]["b"] = 0.15294118225574
	E.db["unitframe"]["colors"]["classResources"]["comboPoints"][3]["g"] = 0.25098040699959
	E.db["unitframe"]["colors"]["classResources"]["comboPoints"][3]["r"] = 1
	E.db["unitframe"]["colors"]["classResources"]["comboPoints"][4]["b"] = 0.20784315466881
	E.db["unitframe"]["colors"]["classResources"]["comboPoints"][4]["g"] = 0.16078431904316
	E.db["unitframe"]["colors"]["classResources"]["comboPoints"][4]["r"] = 1
	E.db["unitframe"]["colors"]["classResources"]["comboPoints"][5]["b"] = 0.3137255012989
	E.db["unitframe"]["colors"]["classResources"]["comboPoints"][5]["g"] = 0.13333334028721
	E.db["unitframe"]["colors"]["classResources"]["comboPoints"][5]["r"] = 1
	E.db["unitframe"]["colors"]["classResources"]["comboPoints"][6]["b"] = 0.49019610881805
	E.db["unitframe"]["colors"]["classResources"]["comboPoints"][6]["g"] = 0.16078431904316
	E.db["unitframe"]["colors"]["classResources"]["comboPoints"][6]["r"] = 1
	E.db["unitframe"]["colors"]["classResources"]["comboPoints"][7]["b"] = 0.98039221763611
	E.db["unitframe"]["colors"]["classResources"]["comboPoints"][7]["g"] = 0.2549019753933
	E.db["unitframe"]["colors"]["classResources"]["comboPoints"][7]["r"] = 1

	if E.Retail then
		E.db["bags"]["split"]["bag5"] = true
		E.db["bags"]["split"]["bagSpacing"] = 7
		E.db["bags"]["split"]["player"] = true
	end

	E.db["movers"]["TopCenterContainerMover"] = "TOP,ElvUIParent,TOP,0,-100"


	E.db["unitframe"]["units"]["target"]["aurabar"]["priority"] = "Blacklist,blockNoDuration,Personal,Boss,RaidDebuffs,Dispellable,PlayerBuffs,RaidBuffsElvUI,TurtleBuffs"

	E.db["nameplates"]["units"]["ENEMY_NPC"]["name"]["format"] = "[eltruism:classification][name]"

	ElvUI_EltreumUI:Print(L["Settings for ElvUI were updated."])
end
