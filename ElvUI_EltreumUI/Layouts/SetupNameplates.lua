local E, L = unpack(ElvUI)
local _G = _G
local pairs = _G.pairs
local SetCVar = _G.C_CVar and _G.C_CVar.SetCVar or _G.SetCVar
local GetPhysicalScreenSize = _G.GetPhysicalScreenSize

-- for rare nameplates
local rareclass = {
	["WARRIOR"] = "Eltreum-Class-Warrior",
	["PALADIN"] = "Eltreum-Class-Paladin",
	["HUNTER"] = "Eltreum-Class-Hunter",
	["ROGUE"] = "Eltreum-Class-Rogue",
	["PRIEST"] = "Eltreum-Class-Priest",
	["DEATHKNIGHT"] = "Eltreum-Class-DeathKnight",
	["SHAMAN"] = "Eltreum-Class-Shaman",
	["MAGE"] = "Eltreum-Class-Mage",
	["WARLOCK"] = "Eltreum-Class-Warlock",
	["MONK"] = "Eltreum-Class-Monk",
	["DRUID"] = "Eltreum-Class-Druid",
	["DEMONHUNTER"] = "Eltreum-Class-DemonHunter",
	["EVOKER"] = "Eltreum-Class-Evoker",
}

-- NamePlate Setup
function ElvUI_EltreumUI:SetupNamePlates()
	if E.private.nameplates.enable then
		local width = GetPhysicalScreenSize()

		-- Toggle on
		E.private["nameplates"]["enable"] = true

		-- Style Filters & CVars
		ElvUI_EltreumUI:SetupStyleFilters()

		--Nameplates
		E.db["nameplates"]["clampToScreen"] = true
		E.db["nameplates"]["colors"]["glowColor"]["b"] = 0.86666476726532
		E.db["nameplates"]["colors"]["glowColor"]["g"] = 0.4392147064209
		E.db["nameplates"]["colors"]["glowColor"]["r"] = 0
		E.db["nameplates"]["colors"]["power"]["ENERGY"]["b"] = 0.53725490196078
		E.db["nameplates"]["colors"]["power"]["ENERGY"]["g"] = 0.96862745098039
		E.db["nameplates"]["colors"]["power"]["ENERGY"]["r"] = 1
		E.db["nameplates"]["colors"]["power"]["MANA"]["b"] = 1
		E.db["nameplates"]["colors"]["power"]["MANA"]["g"] = 0.71372549019608
		E.db["nameplates"]["colors"]["power"]["MANA"]["r"] = 0.49019607843137
		E.db["nameplates"]["colors"]["reactions"]["bad"]["b"] = 0.25098039215686
		E.db["nameplates"]["colors"]["reactions"]["bad"]["g"] = 0.25098039215686
		E.db["nameplates"]["colors"]["reactions"]["bad"]["r"] = 0.78039215686275
		E.db["nameplates"]["colors"]["reactions"]["good"]["b"] = 0.30196078431373
		E.db["nameplates"]["colors"]["reactions"]["good"]["g"] = 0.67843137254902
		E.db["nameplates"]["colors"]["reactions"]["good"]["r"] = 0.29019607843137
		E.db["nameplates"]["colors"]["reactions"]["neutral"]["b"] = 0.36078431372549
		E.db["nameplates"]["colors"]["reactions"]["neutral"]["g"] = 0.76862745098039
		E.db["nameplates"]["colors"]["reactions"]["neutral"]["r"] = 0.85098039215686
		E.db["nameplates"]["colors"]["selection"][2]["g"] = 0.85098039215686
		E.db["nameplates"]["colors"]["selection"][8]["b"] = 0.41960784313725
		E.db["nameplates"]["colors"]["selection"][13]["b"] = 0.27843137254902
		E.db["nameplates"]["colors"]["selection"][13]["g"] = 0.58039215686275
		E.db["nameplates"]["colors"]["selection"][13]["r"] = 0.10196078431373
		E.db["nameplates"]["colors"]["reactions"]["bad"]["b"] = 0.32156862745098
		E.db["nameplates"]["colors"]["reactions"]["bad"]["g"] = 0.32156862745098
		E.db["nameplates"]["colors"]["reactions"]["bad"]["r"] = 1
		E.db["nameplates"]["colors"]["reactions"]["good"]["b"] = 0.44313725490196
		E.db["nameplates"]["colors"]["reactions"]["good"]["g"] = 1
		E.db["nameplates"]["colors"]["reactions"]["good"]["r"] = 0.42745098039216
		E.db["nameplates"]["colors"]["reactions"]["neutral"]["b"] = 0.42352941176471
		E.db["nameplates"]["colors"]["reactions"]["neutral"]["g"] = 0.90196078431373
		E.db["nameplates"]["colors"]["reactions"]["neutral"]["r"] = 1
		E.db["nameplates"]["colors"]["threat"]["badColor"]["b"] = 0.17647058823529
		E.db["nameplates"]["colors"]["threat"]["badColor"]["g"] = 0.17647058823529
		E.db["nameplates"]["colors"]["threat"]["goodColor"]["g"] = 1
		E.db["nameplates"]["colors"]["threat"]["goodColor"]["r"] = 0.27843137254902
		E.db["nameplates"]["colors"]["threat"]["offTankColorBadTransition"]["b"] = 0.38039215686275
		E.db["nameplates"]["colors"]["threat"]["offTankColorBadTransition"]["g"] = 0.6078431372549
		E.db["nameplates"]["colors"]["threat"]["offTankColorBadTransition"]["r"] = 1
		E.db["nameplates"]["colors"]["threat"]["offTankColorGoodTransition"]["b"] = 1
		E.db["nameplates"]["colors"]["threat"]["offTankColorGoodTransition"]["g"] = 0.71372549019608
		E.db["nameplates"]["colors"]["threat"]["offTankColorGoodTransition"]["r"] = 0.49019607843137
		E.db["nameplates"]["colors"]["threat"]["badTransition"]["g"] = 0.50980392156863
		E.db["nameplates"]["colors"]["threat"]["goodTransition"]["g"] = 0.85098039215686
		E.db["nameplates"]["colors"]["threat"]["offTankColor"]["r"] = 0.72941176470588
		E.db["nameplates"]["threat"]["badScale"] = 0.9
		E.db["nameplates"]["threat"]["goodScale"] = 1.1
		E.db["nameplates"]["colors"]["selection"][0]["b"] = 0.17647058823529
		E.db["nameplates"]["colors"]["selection"][0]["g"] = 0.17647058823529
		E.db["nameplates"]["colors"]["selection"][3]["g"] = 1
		E.db["nameplates"]["colors"]["selection"][3]["r"] = 0.27843137254902
		E.db["nameplates"]["colors"]["selection"][13]["b"] = 0.49019607843137
		E.db["nameplates"]["colors"]["selection"][13]["g"] = 1
		E.db["nameplates"]["colors"]["selection"][13]["r"] = 0.16862745098039
		E.db["nameplates"]["cooldown"]["fonts"]["font"] = "Kimberley"
		E.db["nameplates"]["cooldown"]["fonts"]["fontOutline"] = "THICKOUTLINE"

		--remove the by type border colors
		E.db["nameplates"]["colors"]["auraByType"] = false
		--boss mods
		E.db["nameplates"]["bossMods"]["enable"] = true
		E.db["nameplates"]["bossMods"]["anchorPoint"] = 'BOTTOM'
		E.db["nameplates"]["bossMods"]["growthX"] = 'RIGHT'
		E.db["nameplates"]["bossMods"]["growthY"] = 'DOWN'
		E.db["nameplates"]["bossMods"]["size"] = 34
		E.db["nameplates"]["bossMods"]["spacing"] = 1
		E.db["nameplates"]["bossMods"]["yOffset"] = -10
		E.db["nameplates"]["bossMods"]["xOffset"] = 0
		E.db["nameplates"]["colors"]["classResources"]["DEATHKNIGHT"]["b"] = 1
		E.db["nameplates"]["colors"]["classResources"]["DEATHKNIGHT"]["g"] = 1
		E.db["nameplates"]["colors"]["classResources"]["DEATHKNIGHT"]["r"] = 0
		E.db["nameplates"]["colors"]["classResources"]["WARLOCK"]["r"] = 0.58039215686275
		E.db["nameplates"]["colors"]["classResources"]["MONK"][1]["b"] = 0.57254904508591
		E.db["nameplates"]["colors"]["classResources"]["MONK"][1]["g"] = 1
		E.db["nameplates"]["colors"]["classResources"]["MONK"][1]["r"] = 0.078431375324726
		E.db["nameplates"]["colors"]["classResources"]["MONK"][2]["b"] = 0.61568629741669
		E.db["nameplates"]["colors"]["classResources"]["MONK"][2]["g"] = 1
		E.db["nameplates"]["colors"]["classResources"]["MONK"][2]["r"] = 0.082352943718433
		E.db["nameplates"]["colors"]["classResources"]["MONK"][3]["b"] = 0.7294117808342
		E.db["nameplates"]["colors"]["classResources"]["MONK"][3]["g"] = 1
		E.db["nameplates"]["colors"]["classResources"]["MONK"][3]["r"] = 0.098039224743843
		E.db["nameplates"]["colors"]["classResources"]["MONK"][4]["b"] = 0.78039222955704
		E.db["nameplates"]["colors"]["classResources"]["MONK"][4]["g"] = 1
		E.db["nameplates"]["colors"]["classResources"]["MONK"][4]["r"] = 0.094117656350136
		E.db["nameplates"]["colors"]["classResources"]["MONK"][5]["b"] = 0.85490202903748
		E.db["nameplates"]["colors"]["classResources"]["MONK"][5]["g"] = 1
		E.db["nameplates"]["colors"]["classResources"]["MONK"][5]["r"] = 0.10588236153126
		E.db["nameplates"]["colors"]["classResources"]["MONK"][6]["b"] = 0.93333339691162
		E.db["nameplates"]["colors"]["classResources"]["MONK"][6]["g"] = 1
		E.db["nameplates"]["colors"]["classResources"]["MONK"][6]["r"] = 0.11372549831867
		E.db["nameplates"]["colors"]["classResources"]["comboPoints"][1]["b"] = 0.05882353335619
		E.db["nameplates"]["colors"]["classResources"]["comboPoints"][1]["g"] = 0.41960787773132
		E.db["nameplates"]["colors"]["classResources"]["comboPoints"][1]["r"] = 1
		E.db["nameplates"]["colors"]["classResources"]["comboPoints"][2]["b"] = 0.10196079313755
		E.db["nameplates"]["colors"]["classResources"]["comboPoints"][2]["g"] = 0.33725491166115
		E.db["nameplates"]["colors"]["classResources"]["comboPoints"][2]["r"] = 1
		E.db["nameplates"]["colors"]["classResources"]["comboPoints"][3]["b"] = 0.15294118225574
		E.db["nameplates"]["colors"]["classResources"]["comboPoints"][3]["g"] = 0.25098040699959
		E.db["nameplates"]["colors"]["classResources"]["comboPoints"][3]["r"] = 1
		E.db["nameplates"]["colors"]["classResources"]["comboPoints"][4]["b"] = 0.20784315466881
		E.db["nameplates"]["colors"]["classResources"]["comboPoints"][4]["g"] = 0.16078431904316
		E.db["nameplates"]["colors"]["classResources"]["comboPoints"][4]["r"] = 1
		E.db["nameplates"]["colors"]["classResources"]["comboPoints"][5]["b"] = 0.3137255012989
		E.db["nameplates"]["colors"]["classResources"]["comboPoints"][5]["g"] = 0.13333334028721
		E.db["nameplates"]["colors"]["classResources"]["comboPoints"][5]["r"] = 1
		E.db["nameplates"]["colors"]["classResources"]["comboPoints"][6]["b"] = 0.49019610881805
		E.db["nameplates"]["colors"]["classResources"]["comboPoints"][6]["g"] = 0.16078431904316
		E.db["nameplates"]["colors"]["classResources"]["comboPoints"][6]["r"] = 1
		E.db["nameplates"]["colors"]["classResources"]["comboPoints"][7]["b"] = 0.98039221763611
		E.db["nameplates"]["colors"]["classResources"]["comboPoints"][7]["g"] = 0.2549019753933
		E.db["nameplates"]["colors"]["classResources"]["comboPoints"][7]["r"] = 1
		E.db["nameplates"]["colors"]["power"]["PAIN"]["b"] = 1
		E.db["nameplates"]["colors"]["power"]["PAIN"]["g"] = 1
		E.db["nameplates"]["colors"]["power"]["PAIN"]["r"] = 1
		E.db["nameplates"]["colors"]["power"]["RAGE"]["b"] = 0.32156862745098
		E.db["nameplates"]["colors"]["power"]["RAGE"]["g"] = 0.32156862745098
		E.db["nameplates"]["colors"]["power"]["RAGE"]["r"] = 1
		E.db["nameplates"]["colors"]["power"]["FOCUS"]["b"] = 0.38039215686275
		E.db["nameplates"]["colors"]["power"]["FOCUS"]["g"] = 0.6078431372549
		E.db["nameplates"]["colors"]["power"]["FOCUS"]["r"] = 1
		E.db["nameplates"]["colors"]["power"]["FURY"]["b"] = 0.17254901960784
		E.db["nameplates"]["colors"]["power"]["FURY"]["g"] = 0.55686274509804
		E.db["nameplates"]["colors"]["power"]["FURY"]["r"] = 1
		E.db["nameplates"]["colors"]["power"]["INSANITY"]["b"] = 1
		E.db["nameplates"]["colors"]["power"]["INSANITY"]["g"] = 0.20392156862745
		E.db["nameplates"]["colors"]["power"]["INSANITY"]["r"] = 0.79607843137255
		E.db["nameplates"]["colors"]["power"]["LUNAR_POWER"]["b"] = 0.13333333333333
		E.db["nameplates"]["colors"]["power"]["LUNAR_POWER"]["g"] = 0.95294117647059
		E.db["nameplates"]["colors"]["power"]["LUNAR_POWER"]["r"] = 1
		E.db["nameplates"]["colors"]["power"]["MAELSTROM"]["g"] = 0.50196078431373

		--spellsteal style filter
		if E.Retail or E.Wrath then
			E.db["nameplates"]["filters"]["EltreumSpellsteal"]["triggers"]["enable"] = true
		elseif E.Classic then
			E.db["nameplates"]["filters"]["EltreumSpellsteal"]["triggers"]["enable"] = false
		end
		--level style filter
		if E.Retail then
			E.db["nameplates"]["filters"]["EltreumLevel"]["triggers"]["enable"] = false
		elseif E.Classic or E.Wrath then
			E.db["nameplates"]["filters"]["EltreumLevel"]["triggers"]["enable"] = true
		end
		--enable general style filters on all versions
		E.db["nameplates"]["filters"]["EltreumRare"]["triggers"]["enable"] = true
		E.db["nameplates"]["filters"]["EltreumHideNP"]["triggers"]["enable"] = true
		E.db["nameplates"]["filters"]["ElvUI_Target"]["triggers"]["enable"] = true
		E.db["nameplates"]["filters"]["ElvUI_Boss"]["triggers"]["enable"] = false --causes issues with some stuff in bgs
		E.db["nameplates"]["filters"]["EltreumTarget"]["triggers"]["enable"] = true
		E.db["nameplates"]["filters"]["ElvUI_NonTarget"]["triggers"]["enable"] = true
		E.db["nameplates"]["filters"]["EltreumInterrupt"]["triggers"]["enable"] = true
		E.db["nameplates"]["filters"]["EltreumExecute"]["triggers"]["enable"] = true
		E.db["nameplates"]["filters"]["EltreumRestedNP"]["triggers"]["enable"] = true
		E.db["nameplates"]["filters"]["EltreumTotems"]["triggers"]["enable"] = true
		E.db["nameplates"]["highlight"] = false
		E.db["nameplates"]["lowHealthThreshold"] = 0.2

		E.db["nameplates"]["plateSize"]["friendlyWidth"] = 150
		E.db["nameplates"]["plateSize"]["friendlyHeight"] = 30
		E.db["nameplates"]["plateSize"]["enemyWidth"] = 150
		E.db["nameplates"]["plateSize"]["enemyHeight"] = 30
		E.db["nameplates"]["plateSize"]["personalWidth"] = 150
		E.db["nameplates"]["plateSize"]["personalHeight"] = 30

		E.db["nameplates"]["statusbar"] = "ElvUI Norm1"
		E.db["nameplates"]["overlapH"] = 0.8
		E.db["nameplates"]["overlapV"] = 1.1

		--new due to elvui changes
		E.db["nameplates"]["units"]["ENEMY_NPC"]["smartAuraPosition"] = "FLUID_BUFFS_ON_DEBUFFS"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["smartAuraPosition"] = "FLUID_BUFFS_ON_DEBUFFS"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["priority"] = "Blacklist,RaidBuffsElvUI,Dispellable,blockNoDuration,CastByUnit"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["priority"] = "Blacklist,Personal,CCDebuffs,CastByNPC"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["priority"] = "Blacklist,Dispellable,PlayerBuffs,TurtleBuffs"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["priority"] = "Blacklist,Personal,Boss,CCDebuffs,RaidDebuffs,nonPersonal"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["anchorPoint"] = "TOP"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["attachTo"] = "DEBUFFS"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["countFont"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["countFontSize"] = 10
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["countXOffset"] = 2
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["countYOffset"] = -3
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["durationPosition"] = "TOP"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["growthX"] = "LEFT"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["height"] = 18
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["keepSizeRatio"] = false
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["numAuras"] = 6
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["size"] = 25
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["spacing"] = 2
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 5
		E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["anchorPoint"] = "TOP"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["countFont"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["countFontSize"] = 10
		E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["countXOffset"] = 2
		E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["countYOffset"] = -3
		E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["durationPosition"] = "TOP"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["height"] = 18
		E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["keepSizeRatio"] = false
		E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["numAuras"] = 6
		E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["size"] = 25
		E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["spacing"] = 2
		E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 17
		E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["castTimeFormat"] = "REMAINING"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["channelTimeFormat"] = "REMAINING"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["fontOutline"] = "THICKOUTLINE"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["fontSize"] = 10
		E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["displayTarget"] = true
		E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["height"] = 12
		E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["iconOffsetX"] = -4
		E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["iconOffsetY"] = -1
		E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["iconPosition"] = "LEFT"
		if width == 3840 then
			E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["iconSize"] = 32
		else
			E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["iconSize"] = 33
		end
		E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["showIcon"] = true
		E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["textPosition"] = "ONBAR"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["timeToHold"] = 0.6
		E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["yOffset"] = -18
		E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["textYOffset"] = -1
		E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["timeYOffset"] = -1
		E.db["nameplates"]["units"]["ENEMY_NPC"]["eliteIcon"]["position"] = "LEFT"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["eliteIcon"]["size"] = 16
		E.db["nameplates"]["units"]["ENEMY_NPC"]["eliteIcon"]["xOffset"] = -4
		E.db["nameplates"]["units"]["ENEMY_NPC"]["health"]["height"] = 14
		E.db["nameplates"]["units"]["ENEMY_NPC"]["health"]["text"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["health"]["text"]["fontOutline"] = "THICKOUTLINE"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["health"]["text"]["fontSize"] = 12
		E.db["nameplates"]["units"]["ENEMY_NPC"]["health"]["text"]["format"] = "[health:percent] "
		E.db["nameplates"]["units"]["ENEMY_NPC"]["health"]["text"]["parent"] = "Health"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["health"]["text"]["xOffset"] = 4
		E.db["nameplates"]["units"]["ENEMY_NPC"]["health"]["text"]["yOffset"] = -1
		E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["enable"] = true
		E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["fontOutline"] = "OUTLINE"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["fontSize"] = 10
		E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["parent"] = "Health"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["xOffset"] = -6
		E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["yOffset"] = -13
		E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["format"] = ""
		E.db["nameplates"]["units"]["ENEMY_NPC"]["name"]["font"] = "Kimberley"
		if width == 3840 then
			E.db["nameplates"]["units"]["ENEMY_NPC"]["name"]["fontOutline"] = "THICKOUTLINE"
		else
			E.db["nameplates"]["units"]["ENEMY_NPC"]["name"]["fontOutline"] = "OUTLINE"
		end
		--E.db["nameplates"]["units"]["ENEMY_NPC"]["name"]["format"] = "[classification:icon][name]"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["name"]["format"] = "[eltruism:classification][name]"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["name"]["position"] = "CENTER"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["name"]["yOffset"] = 15
		E.db["nameplates"]["units"]["ENEMY_NPC"]["portrait"]["height"] = 30
		E.db["nameplates"]["units"]["ENEMY_NPC"]["portrait"]["position"] = "LEFT"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["portrait"]["width"] = 30
		E.db["nameplates"]["units"]["ENEMY_NPC"]["portrait"]["xOffset"] = -3
		E.db["nameplates"]["units"]["ENEMY_NPC"]["portrait"]["yOffset"] = 3
		E.db["nameplates"]["units"]["ENEMY_NPC"]["power"]["text"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["power"]["text"]["fontOutline"] = "NONE"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["power"]["text"]["fontSize"] = 10
		E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["fontSize"] = 15
		E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["size"] = 25
		E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["spacing"] = 12
		E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["textPosition"] = "RIGHT"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["textXOffset"] = 9
		E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["textYOffset"] = 0
		E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["xOffset"] = 15
		E.db["nameplates"]["units"]["ENEMY_NPC"]["raidTargetIndicator"]["size"] = 32
		E.db["nameplates"]["units"]["ENEMY_NPC"]["raidTargetIndicator"]["xOffset"] = -26

		--using enemy npc title for threat display in classic/tbc
		E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["fontOutline"] = "OUTLINE"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["parent"] = "Health"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["fontSize"] = 10
		E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["position"] = "CENTER"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["yOffset"] = 0
		E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["xOffset"] = -55
		E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["enable"] = true
		E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["format"] = "[threat:percent]"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["anchorPoint"] = "TOP"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["attachTo"] = "DEBUFFS"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["countFont"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["countFontSize"] = 10
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["countXOffset"] = 2
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["countYOffset"] = -3
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["durationPosition"] = "TOP"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["growthX"] = "LEFT"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["height"] = 18
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["keepSizeRatio"] = false
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["numAuras"] = 6
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["size"] = 25
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 5
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["anchorPoint"] = "TOP"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["countFont"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["countFontSize"] = 10
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["countXOffset"] = 2
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["countYOffset"] = -3
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["durationPosition"] = "TOP"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["height"] = 18
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["keepSizeRatio"] = false
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["numAuras"] = 6
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["priority"] = "Blacklist,blockNoDuration,Personal,Boss,CCDebuffs,RaidDebuffs,nonPersonal"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["size"] = 25
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 17
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["castTimeFormat"] = "REMAINING"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["channelTimeFormat"] = "REMAINING"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["fontOutline"] = "THICKOUTLINE"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["fontSize"] = 10
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["height"] = 12
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["iconPosition"] = "LEFT"
		if width == 3840 then
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["iconSize"] = 32
		else
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["iconSize"] = 33
		end
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["iconOffsetX"] = -4
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["iconOffsetY"] = -1
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["showIcon"] = true
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["textPosition"] = "ONBAR"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["timeToHold"] = 0.6
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["yOffset"] = -18
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["textYOffset"] = -1
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["timeYOffset"] = -1
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["health"]["height"] = 14
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["health"]["text"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["health"]["text"]["fontOutline"] = "THICKOUTLINE"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["health"]["text"]["fontSize"] = 12
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["health"]["text"]["parent"] = "Health"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["health"]["text"]["xOffset"] = 4
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["health"]["text"]["yOffset"] = -1
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["enable"] = false
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["fontOutline"] = "THICKOUTLINE"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["fontSize"] = 10
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["yOffset"] = -9
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["name"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["name"]["fontOutline"] = "THICKOUTLINE"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["name"]["format"] = "[namecolor][name][realm:dash]"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["name"]["position"] = "CENTER"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["name"]["yOffset"] = 15
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["power"]["text"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["power"]["text"]["fontOutline"] = "NONE"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["raidTargetIndicator"]["size"] = 32
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["raidTargetIndicator"]["xOffset"] = -26
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["title"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["title"]["fontSize"] = 10
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["title"]["format"] = "[namecolor][guild:brackets]"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["title"]["position"] = "CENTER"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["title"]["yOffset"] = 0

		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["castbar"]["enable"] = false
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["castbar"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["castbar"]["timeToHold"] = 0.6
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["castbar"]["displayTarget"] = true
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["buffs"]["enable"] = true
		--E.db["nameplates"]["units"]["FRIENDLY_NPC"]["buffs"]["enable"] = false
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["buffs"]["anchorPoint"] = "TOP"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["buffs"]["attachTo"] = "DEBUFFS"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["buffs"]["countFont"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["buffs"]["countFontSize"] = 10
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["buffs"]["countXOffset"] = 2
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["buffs"]["countYOffset"] = -3
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["buffs"]["durationPosition"] = "TOP"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["buffs"]["growthX"] = "LEFT"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["buffs"]["height"] = 18
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["buffs"]["keepSizeRatio"] = false
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["buffs"]["numAuras"] = 6
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["buffs"]["priority"] = "Blacklist,blockNoDuration,Personal,TurtleBuffs,CastByNPC"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["buffs"]["size"] = 25
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["buffs"]["yOffset"] = 8
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["buffs"]["maxDuration"] = 1200
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["debuffs"]["anchorPoint"] = "TOP"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["debuffs"]["countFont"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["debuffs"]["countFontSize"] = 10
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["debuffs"]["countXOffset"] = 2
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["debuffs"]["countYOffset"] = -3
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["debuffs"]["durationPosition"] = "TOP"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["debuffs"]["enable"] = false
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["debuffs"]["height"] = 18
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["debuffs"]["keepSizeRatio"] = false
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["debuffs"]["numAuras"] = 6
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["debuffs"]["size"] = 25
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["debuffs"]["yOffset"] = 38
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["health"]["enable"] = false
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["health"]["text"]["enable"] = false
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["health"]["text"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["level"]["enable"] = false
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["level"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["name"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["name"]["fontSize"] = 12
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["name"]["position"] = "CENTER"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["name"]["yOffset"] = 7
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["name"]["format"] = "[namecolor][name]"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["nameOnly"] = false
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["power"]["text"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["fontSize"] = 15
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["size"] = 25
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["spacing"] = 12
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["textPosition"] = "RIGHT"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["textXOffset"] = 9
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["textYOffset"] = 0
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["xOffset"] = 15
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["raidTargetIndicator"]["position"] = "CENTER"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["raidTargetIndicator"]["size"] = 64
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["raidTargetIndicator"]["xOffset"] = 0
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["raidTargetIndicator"]["yOffset"] = 100
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["title"]["enable"] = true
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["title"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["title"]["format"] = "[namecolor][npctitle:brackets]"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["title"]["position"] = "CENTER"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["title"]["yOffset"] = -5

		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["castbar"]["enable"] = false
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["castbar"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["castbar"]["fontOutline"] = "NONE"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["buffs"]["anchorPoint"] = "TOP"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["buffs"]["attachTo"] = "DEBUFFS"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["buffs"]["countFont"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["buffs"]["countFontSize"] = 10
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["buffs"]["countXOffset"] = 2
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["buffs"]["countYOffset"] = -3
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["buffs"]["enable"] = false
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["buffs"]["height"] = 18
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["buffs"]["keepSizeRatio"] = false
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["buffs"]["numAuras"] = 6
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["buffs"]["size"] = 25
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["debuffs"]["anchorPoint"] = "TOP"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["debuffs"]["countFont"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["debuffs"]["countFontSize"] = 10
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["debuffs"]["countXOffset"] = 2
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["debuffs"]["countYOffset"] = -3
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["debuffs"]["enable"] = false
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["debuffs"]["height"] = 18
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["debuffs"]["keepSizeRatio"] = false
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["debuffs"]["numAuras"] = 6
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["debuffs"]["size"] = 25
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["debuffs"]["yOffset"] = 38
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["health"]["enable"] = false
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["health"]["text"]["enable"] = false
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["health"]["text"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["health"]["text"]["fontOutline"] = "NONE"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["health"]["text"]["yOffset"] = -1
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["level"]["enable"] = false
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["level"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["level"]["fontOutline"] = "NONE"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["level"]["fontSize"] = 10
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["level"]["yOffset"] = -8
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["name"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["name"]["fontSize"] = 12
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["name"]["format"] = "[namecolor][name:title][realm:dash]"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["name"]["position"] = "CENTER"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["name"]["yOffset"] = 15
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["power"]["text"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["power"]["text"]["fontOutline"] = "NONE"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["raidTargetIndicator"]["position"] = "CENTER"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["raidTargetIndicator"]["size"] = 39
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["raidTargetIndicator"]["xOffset"] = 0
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["raidTargetIndicator"]["yOffset"] = 30
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["title"]["enable"] = true
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["title"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["title"]["format"] = "[namecolor][guild:brackets]"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["title"]["position"] = "CENTER"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["title"]["yOffset"] = 0

		E.db["nameplates"]["units"]["PLAYER"]["buffs"]["anchorPoint"] = "TOP"
		E.db["nameplates"]["units"]["PLAYER"]["buffs"]["attachTo"] = "DEBUFFS"
		E.db["nameplates"]["units"]["PLAYER"]["buffs"]["countFont"] = "Kimberley"
		E.db["nameplates"]["units"]["PLAYER"]["buffs"]["countFontOutline"] = "THICKOUTLINE"
		E.db["nameplates"]["units"]["PLAYER"]["buffs"]["countFontSize"] = 10
		E.db["nameplates"]["units"]["PLAYER"]["buffs"]["countXOffset"] = 4
		E.db["nameplates"]["units"]["PLAYER"]["buffs"]["countYOffset"] = -4
		E.db["nameplates"]["units"]["PLAYER"]["buffs"]["durationPosition"] = "TOPLEFT"
		E.db["nameplates"]["units"]["PLAYER"]["buffs"]["growthX"] = "LEFT"
		E.db["nameplates"]["units"]["PLAYER"]["buffs"]["numAuras"] = 6
		E.db["nameplates"]["units"]["PLAYER"]["buffs"]["numRows"] = 2
		E.db["nameplates"]["units"]["PLAYER"]["buffs"]["priority"] = "Blacklist,Dispellable,PlayerBuffs,TurtleBuffs"
		E.db["nameplates"]["units"]["PLAYER"]["buffs"]["size"] = 25
		E.db["nameplates"]["units"]["PLAYER"]["buffs"]["spacing"] = 0
		E.db["nameplates"]["units"]["PLAYER"]["buffs"]["yOffset"] = 2
		E.db["nameplates"]["units"]["PLAYER"]["buffs"]["xOffset"] = 0
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["castTimeFormat"] = "REMAINING"
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["channelTimeFormat"] = "REMAINING"
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["fontSize"] = 10
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["height"] = 12
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["width"] = 150
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["iconOffsetY"] = -1
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["iconOffsetX"] = 0
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["iconPosition"] = "LEFT"
		if E.Retail then
			E.db["nameplates"]["units"]["PLAYER"]["castbar"]["iconSize"] = 32
		else
			E.db["nameplates"]["units"]["PLAYER"]["castbar"]["iconSize"] = 28
		end
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["fontOutline"] = "THICKOUTLINE"
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["textPosition"] = "ONBAR"
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["timeToHold"] = 0.6
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["textXOffset"] = 0
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["textYOffset"] = 0
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["timeXOffset"] = 0
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["timeYOffset"] = 0
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["yOffset"] = -14
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["xOffset"] = 0
		E.db["nameplates"]["units"]["PLAYER"]["classpower"]["height"] = 8
		E.db["nameplates"]["units"]["PLAYER"]["classpower"]["width"] = 150
		E.db["nameplates"]["units"]["PLAYER"]["classpower"]["yOffset"] = 12
		E.db["nameplates"]["units"]["PLAYER"]["classpower"]["xOffset"] = 0
		E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["countFont"] = "Kimberley"
		E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["countFontOutline"] = "THICKOUTLINE"
		E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["countFontSize"] = 10
		E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["countXOffset"] = 4
		E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["countYOffset"] = -4
		E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["durationPosition"] = "TOP"
		E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["numAuras"] = 6
		E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["numRows"] = 2
		E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["priority"] = "Blacklist,blockNoDuration,Personal,Boss,CCDebuffs,RaidDebuffs,nonPersonal"
		E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["size"] = 25
		E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["spacing"] = 0
		E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["yOffset"] = 2
		E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["xOffset"] = 0
		E.db["nameplates"]["units"]["PLAYER"]["enable"] = false
		E.db["nameplates"]["units"]["PLAYER"]["health"]["height"] = 14
		E.db["nameplates"]["units"]["PLAYER"]["health"]["text"]["position"] = "CENTER"
		E.db["nameplates"]["units"]["PLAYER"]["health"]["text"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["PLAYER"]["health"]["text"]["fontOutline"] = "THICKOUTLINE"
		E.db["nameplates"]["units"]["PLAYER"]["health"]["text"]["fontSize"] = 12
		E.db["nameplates"]["units"]["PLAYER"]["health"]["text"]["format"] = "[eltruism:hpstatusnopc]"
		E.db["nameplates"]["units"]["PLAYER"]["health"]["text"]["parent"] = "Health"
		E.db["nameplates"]["units"]["PLAYER"]["health"]["text"]["xOffset"] = 0
		E.db["nameplates"]["units"]["PLAYER"]["health"]["text"]["yOffset"] = -1
		E.db["nameplates"]["units"]["PLAYER"]["level"]["enable"] = false
		E.db["nameplates"]["units"]["PLAYER"]["name"]["enable"] = false
		E.db["nameplates"]["units"]["PLAYER"]["portrait"]["enable"] = false
		E.db["nameplates"]["units"]["PLAYER"]["power"]["enable"] = false
		E.db["nameplates"]["units"]["PLAYER"]["power"]["text"]["enable"] = false
		E.db["nameplates"]["units"]["PLAYER"]["raidTargetIndicator"]["enable"] = false
		E.db["nameplates"]["units"]["PLAYER"]["showTitle"] = false
		E.db["nameplates"]["units"]["PLAYER"]["smartAuraPosition"] = "BUFFS_ON_DEBUFFS"
		E.db["nameplates"]["units"]["PLAYER"]["title"]["enable"] = false

		E.db["nameplates"]["units"]["TARGET"]["arrow"] = "Eltruism01"
		E.db["nameplates"]["units"]["TARGET"]["arrowScale"] = 0.3
		E.db["nameplates"]["units"]["TARGET"]["arrowSpacing"] = 0
		E.db["nameplates"]["units"]["TARGET"]["classpower"]["classColor"] = false --no this would set the classbar to have class color as opposed to being nicely colored
		E.db["nameplates"]["units"]["TARGET"]["classpower"]["enable"] = true
		E.db["nameplates"]["units"]["TARGET"]["classpower"]["sortDirection"] = "asc"
		E.db["nameplates"]["units"]["TARGET"]["classpower"]["width"] = 150
		E.db["nameplates"]["units"]["TARGET"]["classpower"]["height"] = 7
		E.db["nameplates"]["units"]["TARGET"]["classpower"]["yOffset"] = 26
		--E.db["nameplates"]["units"]["TARGET"]["glowStyle"] = "style1" --border glow
		--E.db["nameplates"]["units"]["TARGET"]["glowStyle"] = "style2" --background glow
		--E.db["nameplates"]["units"]["TARGET"]["glowStyle"] = "style8" --background glow + side arrow
		E.db["nameplates"]["units"]["TARGET"]["glowStyle"] = "style4" --arrow
		--E.db["nameplates"]["units"]["TARGET"]["glowStyle"] = "none" --no target glow

		if E.Classic then
			E.db["v11NamePlateReset"] = true
			E.db["nameplates"]["motionType"] = "OVERLAP"
		end
		E.db["nameplates"]["visibility"]["enemy"]["totems"] = true
		E.db["nameplates"]["visibility"]["enemy"]["minus"] = true
		E.db["nameplates"]["visibility"]["friendly"]["npcs"] = true
		-- Set CVars
		ElvUI_EltreumUI:NameplateCVars()

		ElvUI_EltreumUI:Print(L["ElvUI NamePlates were setup."])
	end
end

-- Style Filter Setup
function ElvUI_EltreumUI:SetupStyleFilters()
	if E.private.nameplates.enable then
		for _, filterName in pairs({'EltreumTarget', 'EltreumInterrupt', 'EltreumExecute', 'EltreumRefreshDebuff', 'EltreumSpellsteal', 'EltreumRare', 'EltreumHideNP', 'EltreumRestedNP', 'EltreumLevel', 'EltreumTotems', 'EltreumDeadNP'}) do
			E.global["nameplates"]["filters"][filterName] = {}
			E.NamePlates:StyleFilterCopyDefaults(E.global["nameplates"]["filters"][filterName])
			E.db["nameplates"]["filters"][filterName] = { triggers = { enable = true } }
		end

		--actually set the scale since 10.0 seems to break it
		E.global["nameplates"]["filters"]["ElvUI_Target"]["actions"]["scale"] = 1.25
		E.global["nameplates"]["filters"]["ElvUI_Target"]["triggers"]["isTarget"] = true
		E.global["nameplates"]["filters"]["ElvUI_Target"]["triggers"]["requireTarget"] = false
		E.global["nameplates"]["filters"]["ElvUI_Target"]["actions"]["alpha"] = 100
		--reset this because other plugins seem to change it
		E.global["nameplates"]["filters"]["ElvUI_Target"]["actions"]["color"]["border"] = false
		E.global["nameplates"]["filters"]["ElvUI_Target"]["actions"]["color"]["health"] = false
		E.global["nameplates"]["filters"]["ElvUI_Target"]["actions"]["color"]["power"] = false
		E.global["nameplates"]["filters"]["ElvUI_Target"]["actions"]["flash"]["enable"] = false
		E.global["nameplates"]["filters"]["ElvUI_Target"]["actions"]["texture"]["enable"] = false

		-- Non targeted enemies
		E.global["nameplates"]["filters"]["ElvUI_NonTarget"]["actions"]["alpha"] = 100 --20 --test 100% alpha
		E.global["nameplates"]["filters"]["ElvUI_NonTarget"]["actions"]["scale"] = 0.75
		--E.global["nameplates"]["filters"]["ElvUI_NonTarget"]["triggers"]["requireTarget"] = true
		E.global["nameplates"]["filters"]["ElvUI_NonTarget"]["triggers"]["notTarget"] = true
		--E.global["nameplates"]["filters"]["ElvUI_NonTarget"]["triggers"]["priority"] = 4

		-- Target enemy
		E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["color"]["health"] = false
		E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["color"]["healthClass"] = false
		E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["color"]["border"] = true
		E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["color"]["borderColor"]["b"] = 0
		E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["color"]["borderColor"]["g"] = 0
		E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["color"]["borderColor"]["r"] = 0
		E.global["nameplates"]["filters"]["EltreumTarget"]["triggers"]["isTarget"] = true
		--E.global["nameplates"]["filters"]["EltreumTarget"]["triggers"]["requireTarget"] = true
		E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["scale"] = 1.25
		--E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["enable"] = true
		--E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["texture"] = "ElvUI Blank"
		E.global["nameplates"]["filters"]["EltreumTarget"]["triggers"]["classification"]["elite"] = true
		E.global["nameplates"]["filters"]["EltreumTarget"]["triggers"]["classification"]["minus"] = true
		E.global["nameplates"]["filters"]["EltreumTarget"]["triggers"]["classification"]["normal"] = true
		E.global["nameplates"]["filters"]["EltreumTarget"]["triggers"]["classification"]["trivial"] = true
		E.global["nameplates"]["filters"]["EltreumTarget"]["triggers"]["classification"]["worldboss"] = true
		E.global["nameplates"]["filters"]["EltreumTarget"]["triggers"]["priority"] = 2

		--Debuff expiring, refresh it (but player needs to manually add the debuffs)
		E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["actions"]["alpha"] = 100
		E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["actions"]["scale"] = 1.25
		E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["fromMe"] = true
		E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["maxTimeLeft"] = 5
		E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["inCombat"] = true
		E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["notTarget"] = true
		E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["enable"] = false
		E.db["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["enable"] = false
		--E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["requireTarget"] = true

		-- Enemy is casting, draw attention to interrupt
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["color"]["border"] = false
		--E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["color"]["borderColor"]["b"] = 0.22745098039216
		--E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["color"]["borderColor"]["g"] = 0.11764705882353
		--E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["color"]["borderColor"]["r"] = 0.76862745098039
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["color"]["borderColor"]["b"] = 1
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["color"]["borderColor"]["g"] = 0
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["color"]["borderColor"]["r"] = 1
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["color"]["borderColor"]["a"] = 0.7
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["color"]["health"] = false
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["color"]["healthColor"]["r"] = 1
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["color"]["healthColor"]["g"] = 0
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["color"]["healthColor"]["b"] = 1
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["flash"]["color"]["b"] = 0
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["flash"]["color"]["g"] = 0
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["flash"]["color"]["r"] = 0
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["flash"]["speed"] = 7
		if E.version > 13.29 then
			E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["flash"]["enable"] = false
			E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["glow"]["color"][1] = 1
			E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["glow"]["color"][2] = 0
			E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["glow"]["color"][3] = 0.078431375324726
			E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["glow"]["color"][4] = 0.90000000596046
			E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["glow"]["enable"] = true
			E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["glow"]["size"] = 2
			E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["glow"]["speed"] = 0.75
			E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["glow"]["lines"] = 8
			E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["glow"]["style"] = "Pixel Glow"
		else
			E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["flash"]["enable"] = true
		end
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["scale"] = 1.2
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["texture"]["enable"] = true
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["texture"]["texture"] = "Eltreum-Stripes"
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["alpha"] = 100
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["triggers"]["casting"]["interruptible"] = true
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["triggers"]["isNotTapDenied"] = true
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["triggers"]["inCombat"] = true
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["triggers"]["notTarget"] = true
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["triggers"]["priority"] = 1
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["triggers"]["instanceDifficulty"]["dungeon"]["heroic"] = true
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["triggers"]["instanceDifficulty"]["dungeon"]["mythic"] = true
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["triggers"]["instanceDifficulty"]["dungeon"]["mythic+"] = true
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["triggers"]["instanceDifficulty"]["dungeon"]["normal"] = true
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["triggers"]["instanceDifficulty"]["dungeon"]["timewalking"] = true
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["triggers"]["instanceType"]["arena"] = true
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["triggers"]["instanceType"]["none"] = true
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["triggers"]["instanceType"]["party"] = true
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["triggers"]["instanceType"]["pvp"] = true
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["triggers"]["instanceType"]["scenario"] = true

		-- Enemy at execute range, general range bc different classes have different hp% executes
		E.global["nameplates"]["filters"]["EltreumExecute"]["actions"]["color"]["borderColor"]["b"] = 0
		E.global["nameplates"]["filters"]["EltreumExecute"]["actions"]["color"]["borderColor"]["g"] = 0
		E.global["nameplates"]["filters"]["EltreumExecute"]["actions"]["color"]["health"] = true
		E.global["nameplates"]["filters"]["EltreumExecute"]["actions"]["color"]["healthColor"]["b"] = 1
		E.global["nameplates"]["filters"]["EltreumExecute"]["actions"]["color"]["healthColor"]["g"] = 0
		E.global["nameplates"]["filters"]["EltreumExecute"]["actions"]["color"]["healthColor"]["r"] = 0.65
		E.global["nameplates"]["filters"]["EltreumExecute"]["actions"]["flash"]["color"]["b"] = 0
		E.global["nameplates"]["filters"]["EltreumExecute"]["actions"]["flash"]["color"]["g"] = 0
		E.global["nameplates"]["filters"]["EltreumExecute"]["actions"]["flash"]["color"]["r"] = 0
		E.global["nameplates"]["filters"]["EltreumExecute"]["actions"]["flash"]["enable"] = false
		E.global["nameplates"]["filters"]["EltreumExecute"]["actions"]["flash"]["speed"] = 7
		E.global["nameplates"]["filters"]["EltreumExecute"]["actions"]["scale"] = 1.25
		E.global["nameplates"]["filters"]["EltreumExecute"]["actions"]["texture"]["enable"] = true
		E.global["nameplates"]["filters"]["EltreumExecute"]["actions"]["texture"]["texture"] = "ElvUI Norm1"
		E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["healthThreshold"] = true
		E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["isTarget"] = false
		E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["isNotTapDenied"] = true
		E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["playerCanAttack"] = true
		E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["priority"] = 1
		E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["underHealthThreshold"] = 0.2

		--fancy rares
		E.global["nameplates"]["filters"]["EltreumRare"]["actions"]["color"]["health"] = true
		E.global["nameplates"]["filters"]["EltreumRare"]["actions"]["color"]["healthColor"]["b"] = 1
		E.global["nameplates"]["filters"]["EltreumRare"]["actions"]["color"]["healthColor"]["g"] = 1
		E.global["nameplates"]["filters"]["EltreumRare"]["actions"]["color"]["healthColor"]["r"] = 1
		E.global["nameplates"]["filters"]["EltreumRare"]["actions"]["texture"]["enable"] = true
		E.global["nameplates"]["filters"]["EltreumRare"]["actions"]["texture"]["texture"] = rareclass[E.myclass]
		E.global["nameplates"]["filters"]["EltreumRare"]["triggers"]["classification"]["rare"] = true
		E.global["nameplates"]["filters"]["EltreumRare"]["triggers"]["classification"]["rareelite"] = true
		E.global["nameplates"]["filters"]["EltreumRare"]["triggers"]["classification"]["worldboss"] = false --issues in AV bg
		E.global["nameplates"]["filters"]["EltreumRare"]["triggers"]["isNotTapDenied"] = true
		E.global["nameplates"]["filters"]["EltreumRare"]["triggers"]["priority"] = 10
		E.global["nameplates"]["filters"]["EltreumRare"]["actions"]["scale"] = 1.25

		--mainly for mages to steal buffs
		E.global["nameplates"]["filters"]["EltreumSpellsteal"]["triggers"]["class"]["MAGE"] = {}
		E.global["nameplates"]["filters"]["EltreumSpellsteal"]["triggers"]["class"]["MAGE"]["enabled"] = true
		E.global["nameplates"]["filters"]["EltreumSpellsteal"]["triggers"]["buffs"]["hasStealable"] = true
		E.global["nameplates"]["filters"]["EltreumSpellsteal"]["triggers"]["isTarget"] = true
		E.global["nameplates"]["filters"]["EltreumSpellsteal"]["triggers"]["notTarget"] = true
		E.global["nameplates"]["filters"]["EltreumSpellsteal"]["triggers"]["priority"] = 13
		E.global["nameplates"]["filters"]["EltreumSpellsteal"]["actions"]["alpha"] = 100
		E.global["nameplates"]["filters"]["EltreumSpellsteal"]["actions"]["flash"]["enable"] = true
		E.global["nameplates"]["filters"]["EltreumSpellsteal"]["actions"]["scale"] = 1.25

		--hide nameplates for unattackable npcs
		E.global["nameplates"]["filters"]["EltreumHideNP"]["actions"]["nameOnly"] = true
		E.global["nameplates"]["filters"]["EltreumHideNP"]["actions"]["tags"]["name"] = "[namecolor][name]"
		E.global["nameplates"]["filters"]["EltreumHideNP"]["actions"]["tags"]["title"] = "[namecolor][npctitle:brackets]"
		E.global["nameplates"]["filters"]["EltreumHideNP"]["triggers"]["nameplateType"]["enable"] = true
		E.global["nameplates"]["filters"]["EltreumHideNP"]["triggers"]["nameplateType"]["enemyNPC"] = true
		E.global["nameplates"]["filters"]["EltreumHideNP"]["triggers"]["playerCanNotAttack"] = true
		E.global["nameplates"]["filters"]["EltreumHideNP"]["triggers"]["priority"] = 15

		--non target full alpha when resting and not in combat, name only since cannot attack anyway
		E.global["nameplates"]["filters"]["EltreumRestedNP"]["actions"]["alpha"] = 100
		E.global["nameplates"]["filters"]["EltreumRestedNP"]["actions"]["nameOnly"] = true
		E.global["nameplates"]["filters"]["EltreumRestedNP"]["actions"]["tags"]["name"] = "[namecolor][name:title][realm:dash]"
		E.global["nameplates"]["filters"]["EltreumRestedNP"]["actions"]["tags"]["title"] = "[namecolor][npctitle:brackets][guild:brackets]"
		E.global["nameplates"]["filters"]["EltreumRestedNP"]["triggers"]["isResting"] = true
		E.global["nameplates"]["filters"]["EltreumRestedNP"]["triggers"]["outOfCombat"] = true
		E.global["nameplates"]["filters"]["EltreumRestedNP"]["triggers"]["playerCanNotAttack"] = true

		--show enemy level
		E.global["nameplates"]["filters"]["EltreumLevel"]["actions"]["tags"]["level"] = "[difficultycolor][smartlevel]"
		E.global["nameplates"]["filters"]["EltreumLevel"]["triggers"]["isTarget"] = true
		E.global["nameplates"]["filters"]["EltreumLevel"]["triggers"]["mylevel"] = false
		E.global["nameplates"]["filters"]["EltreumLevel"]["triggers"]["notTarget"] = true
		E.global["nameplates"]["filters"]["EltreumLevel"]["triggers"]["notTargetMe"] = false
		E.global["nameplates"]["filters"]["EltreumLevel"]["triggers"]["playerCanAttack"] = true
		--totem portrait filter
		E.global["nameplates"]["filters"]["EltreumTotems"]["actions"]["scale"] = 1.25
		E.global["nameplates"]["filters"]["EltreumTotems"]["actions"]["usePortrait"] = true
		E.global["nameplates"]["filters"]["EltreumTotems"]["triggers"]["creatureType"]["Totem"] = true
		E.global["nameplates"]["filters"]["EltreumTotems"]["triggers"]["creatureType"]["enable"] = true
		E.global["nameplates"]["filters"]["EltreumTotems"]["triggers"]["isTarget"] = true
		E.global["nameplates"]["filters"]["EltreumTotems"]["triggers"]["notTarget"] = true
		E.global["nameplates"]["filters"]["EltreumTotems"]["triggers"]["playerCanAttack"] = true
		E.global["nameplates"]["filters"]["EltreumTotems"]["triggers"]["priority"] = 14

		--hide np of dead targets
		--E.global["nameplates"]["filters"]["EltreumDeadNP"]["actions"]["hide"] = true
		E.global["nameplates"]["filters"]["EltreumDeadNP"]["actions"]["nameOnly"] = true
		E.global["nameplates"]["filters"]["EltreumDeadNP"]["actions"]["tags"]["name"] = "[name]"
		E.global["nameplates"]["filters"]["EltreumDeadNP"]["triggers"]["isDeadOrGhost"] = true
		--E.global["nameplates"]["filters"]["EltreumDeadNP"]["triggers"]["nameplateType"]["enable"] = true
		--E.global["nameplates"]["filters"]["EltreumDeadNP"]["triggers"]["nameplateType"]["enemyNPC"] = true

		--E:StaggeredUpdateAll()
		E:UpdateNamePlates()
		ElvUI_EltreumUI:Print(L["NamePlate Style Filters were set."])
	end
end

--restore nameplate cvars if user wants
function ElvUI_EltreumUI:RestoreNameplateNames()
	SetCVar('nameplateShowFriendlyMinions', 1)
	SetCVar('nameplateShowEnemies', 1)
	SetCVar("nameplateShowFriends", 1)
	SetCVar('UnitNameHostleNPC', 1)
	SetCVar('UnitNameInteractiveNPC', 1)
	SetCVar('UnitNameNPC', 1)
	SetCVar('UnitNameEnemyGuardianName', 1)
	SetCVar('UnitNameEnemyMinionName', 1)
	SetCVar('UnitNameEnemyPetName', 1)
	SetCVar('UnitNameFriendlyPetName', 1)
	SetCVar('UnitNameEnemyPlayerName', 1)
	SetCVar('UnitNameEnemyTotemName', 1)
	SetCVar('UnitNameNonCombatCreatureName', 1)
end
