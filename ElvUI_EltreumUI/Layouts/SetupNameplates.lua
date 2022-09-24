local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local pairs = _G.pairs
local SetCVar = _G.SetCVar

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
}

-- NamePlate Setup
function ElvUI_EltreumUI:SetupNamePlates(addon)
	if E.private["nameplates"]["enable"] == true then
		if addon == 'ElvUI' then
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
			E.db["nameplates"]["colors"]["threat"]["badColor"]["b"] = 0.18039215686275
			E.db["nameplates"]["colors"]["threat"]["badColor"]["g"] = 0.18039215686275
			E.db["nameplates"]["colors"]["threat"]["badTransition"]["g"] = 0.50980392156863
			E.db["nameplates"]["colors"]["threat"]["goodTransition"]["g"] = 0.85098039215686
			E.db["nameplates"]["colors"]["threat"]["offTankColor"]["r"] = 0.72941176470588
			E.db["nameplates"]["colors"]["threat"]["offTankColorBadTransition"]["b"] = 0.27058823529412
			E.db["nameplates"]["colors"]["threat"]["offTankColorBadTransition"]["g"] = 0.43137254901961
			E.db["nameplates"]["colors"]["threat"]["offTankColorBadTransition"]["r"] = 0.70980392156863
			E.db["nameplates"]["colors"]["threat"]["offTankColorGoodTransition"]["b"] = 0.63137254901961
			E.db["nameplates"]["colors"]["threat"]["offTankColorGoodTransition"]["g"] = 0.45098039215686
			E.db["nameplates"]["colors"]["threat"]["offTankColorGoodTransition"]["r"] = 0.30980392156863
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
			if E.Retail or E.Wrath or E.TBC then
				E.db["nameplates"]["filters"]["EltreumSpellsteal"]["triggers"]["enable"] = true
			elseif E.Classic then
				E.db["nameplates"]["filters"]["EltreumSpellsteal"]["triggers"]["enable"] = false
			end
			--level style filter
			if E.Retail then
				E.db["nameplates"]["filters"]["EltreumLevel"]["triggers"]["enable"] = false
			elseif E.Classic or E.Wrath or E.TBC then
				E.db["nameplates"]["filters"]["ElvUI_Explosives"]["triggers"]["enable"] = false
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

			E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["priority"] = "Blacklist,RaidBuffsElvUI,Dispellable,blockNoDuration,PlayerBuffs,TurtleBuffs,CastByUnit"
			E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["priority"] = "Blacklist,Personal,CCDebuffs"
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["priority"] = "Blacklist,Dispellable,PlayerBuffs,TurtleBuffs"
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["priority"] = "Blacklist,blockNoDuration,Personal,Boss,CCDebuffs,RaidDebuffs,nonPersonal"

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
			E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["iconOffsetX"] = -1
			E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["iconOffsetY"] = -1
			E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["iconPosition"] = "LEFT"
			E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["iconSize"] = 28
			if width == 1920 then
				E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["iconSize"] = 29
			end
			E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["showIcon"] = true
			E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["textPosition"] = "ONBAR"
			E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["timeToHold"] = 0.4
			E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["yOffset"] = -14
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
			E.db["nameplates"]["units"]["ENEMY_NPC"]["name"]["fontOutline"] = "THICKOUTLINE"
			if width == 3840 then
				E.db["nameplates"]["units"]["ENEMY_NPC"]["name"]["fontOutline"] = "THICKOUTLINE"
			else
				E.db["nameplates"]["units"]["ENEMY_NPC"]["name"]["fontOutline"] = "OUTLINE"
			end
			E.db["nameplates"]["units"]["ENEMY_NPC"]["name"]["format"] = "[classification:icon][name]"
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
			E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["textPosition"] = "TOPRIGHT"
			E.db["nameplates"]["units"]["ENEMY_NPC"]["questIcon"]["xOffset"] = 4
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
			if E.Classic or E.Wrath or E.TBC then
				E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["enable"] = true
				E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["format"] = "[threat:percent]"
			elseif E.Retail then
				E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["enable"] = true
				E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["format"] = "[threat:percent]"
			end

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
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["iconSize"] = 28
			if width == 1920 then
				E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["iconSize"] = 29
			end
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["iconOffsetX"] = -1
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["iconOffsetY"] = -1
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["showIcon"] = true
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["textPosition"] = "ONBAR"
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["timeToHold"] = 0.4
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["yOffset"] = -14
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
			E.db["nameplates"]["units"]["FRIENDLY_NPC"]["castbar"]["timeToHold"] = 0.5
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
			E.db["nameplates"]["units"]["FRIENDLY_NPC"]["nameOnly"] = false
			E.db["nameplates"]["units"]["FRIENDLY_NPC"]["power"]["text"]["font"] = "Kimberley"
			E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["font"] = "Kimberley"
			E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["fontSize"] = 15
			E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["size"] = 25
			E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["textPosition"] = "TOPRIGHT"
			E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["xOffset"] = 4
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
			E.db["nameplates"]["units"]["PLAYER"]["castbar"]["timeToHold"] = 0.5
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
			E.db["nameplates"]["units"]["PLAYER"]["health"]["text"]["format"] = "[health:current-percent:shortvalue]"
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

			E.db["nameplates"]["units"]["TARGET"]["arrow"] = "Arrow21"
			E.db["nameplates"]["units"]["TARGET"]["arrowScale"] = 0.4
			E.db["nameplates"]["units"]["TARGET"]["arrowSpacing"] = 0
			E.db["nameplates"]["units"]["TARGET"]["classpower"]["classColor"] = false --no this would set the classbar to have class color as opposed to being nicely colored
			E.db["nameplates"]["units"]["TARGET"]["classpower"]["enable"] = true
			E.db["nameplates"]["units"]["TARGET"]["classpower"]["sortDirection"] = "asc"
			E.db["nameplates"]["units"]["TARGET"]["classpower"]["width"] = 150
			E.db["nameplates"]["units"]["TARGET"]["classpower"]["yOffset"] = 26
			--E.db["nameplates"]["units"]["TARGET"]["glowStyle"] = "style1" --border glow
			E.db["nameplates"]["units"]["TARGET"]["glowStyle"] = "style2" --background glow
			--E.db["nameplates"]["units"]["TARGET"]["glowStyle"] = "style8" --background glow + side arrow
			--E.db["nameplates"]["units"]["TARGET"]["arrow"] = "Arrow21" --the arrow
			if E.Classic then
				--E.db["nameplates"]["units"]["TARGET"]["glowStyle"] = "style2"
				E.db["v11NamePlateReset"] = true
				E.db["nameplates"]["motionType"] = "OVERLAP"
			end
			E.db["nameplates"]["visibility"]["enemy"]["totems"] = true
			E.db["nameplates"]["visibility"]["enemy"]["minus"] = true
			E.db["nameplates"]["visibility"]["friendly"]["npcs"] = true
			-- Set CVars
			ElvUI_EltreumUI:NameplateCVars()
			end
			ElvUI_EltreumUI:Print(L["ElvUI NamePlates were setup."])
	end
end
-- Style Filter Setup
function ElvUI_EltreumUI:SetupStyleFilters()
	if E.private["nameplates"]["enable"] == true then
		for _, filterName in pairs({'EltreumTarget', 'EltreumInterrupt', 'EltreumExecute', 'EltreumRefreshDebuff', 'EltreumSpellsteal', 'EltreumRare', 'EltreumHideNP', 'EltreumRestedNP', 'EltreumLevel', 'EltreumTotems'}) do
			E.global["nameplates"]["filters"][filterName] = {}
			E.NamePlates:StyleFilterCopyDefaults(E.global["nameplates"]["filters"][filterName])
			E.db["nameplates"]["filters"][filterName] = { triggers = { enable = true } }
		end

		--fix explosive alpha/priority
		if E.Retail then
			E.global["nameplates"]["filters"]["ElvUI_Explosives"]["triggers"]["priority"] = 1
			E.global["nameplates"]["filters"]["ElvUI_Explosives"]["triggers"]["names"]["120651"] = true
			E.global["nameplates"]["filters"]["ElvUI_Explosives"]["actions"]["alpha"] = 100
			E.global["nameplates"]["filters"]["ElvUI_Explosives"]["actions"]["scale"] = 1.25
			E.global["nameplates"]["filters"]["ElvUI_Explosives"]["actions"]["color"]["healthColor"]["r"] = 0
			E.global["nameplates"]["filters"]["ElvUI_Explosives"]["actions"]["color"]["healthColor"]["g"] = 1
			E.global["nameplates"]["filters"]["ElvUI_Explosives"]["actions"]["color"]["healthColor"]["b"] = 1
			E.global["nameplates"]["filters"]["ElvUI_Explosives"]["actions"]["usePortrait"] = true
		end

		-- Non targeted enemies
		E.global["nameplates"]["filters"]["ElvUI_NonTarget"]["actions"]["alpha"] = 20
		E.global["nameplates"]["filters"]["ElvUI_NonTarget"]["actions"]["scale"] = 0.75
		E.global["nameplates"]["filters"]["ElvUI_NonTarget"]["triggers"]["requireTarget"] = true
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
		E.global["nameplates"]["filters"]["EltreumTarget"]["triggers"]["requireTarget"] = true
		E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["scale"] = 1.25
		E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["enable"] = true
		E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["texture"] = "ElvUI Blank"
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
		E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["requireTarget"] = true

		--from Filters.lua
		if E.Retail then
			-- Death Knight
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["47476"] = true -- Strangulate
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["108194"] = true -- Asphyxiate UH
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["221562"] = true -- Asphyxiate Blood
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["207171"] = true -- Winter is Coming
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["206961"] = true -- Tremble Before Me
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["207167"] = true -- Blinding Sleet
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["212540"] = true -- Flesh Hook (Pet)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["91807"] = true -- Shambling Rush (Pet)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["204085"] = true -- Deathchill
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["233395"] = true -- Frozen Center
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["212332"] = true -- Smash (Pet)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["212337"] = true -- Powerful Smash (Pet)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["91800"] = true -- Gnaw (Pet)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["91797"] = true -- Monstrous Blow (Pet)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["210141"] = true -- Zombie Explosion
			-- Demon Hunter
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["207685"] = true -- Sigil of Misery
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["217832"] = true -- Imprison
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["221527"] = true -- Imprison (Banished version)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["204490"] = true -- Sigil of Silence
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["179057"] = true -- Chaos Nova
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["211881"] = true -- Fel Eruption
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["205630"] = true -- Illidan's Grasp
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["208618"] = true -- Illidan's Grasp (Afterward)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["213491"] = true -- Demonic Trample (it's this one or the other)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["208645"] = true -- Demonic Trample
			-- Druid
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["81261"] = true -- Solar Beam
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["5211"] = true -- Mighty Bash
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["163505"] = true -- Rake
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["203123"] = true -- Maim
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["202244"] = true -- Overrun
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["99"] = true -- Incapacitating Roar
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["33786"] = true -- Cyclone
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["45334"] = true -- Immobilized
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["102359"] = true -- Mass Entanglement
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["339"] = true -- Entangling Roots
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["2637"] = true -- Hibernate
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["102793"] = true -- Ursol's Vortex
			-- Hunter
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["202933"] = true -- Spider Sting (it's this one or the other)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["233022"] = true -- Spider Sting
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["213691"] = true -- Scatter Shot
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["19386"] = true -- Wyvern Sting
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["3355"] = true -- Freezing Trap
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["203337"] = true -- Freezing Trap (Survival PvPT)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["209790"] = true -- Freezing Arrow
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["24394"] = true -- Intimidation
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["117526"] = true -- Binding Shot
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["190927"] = true -- Harpoon
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["201158"] = true -- Super Sticky Tar
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["162480"] = true -- Steel Trap
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["212638"] = true -- Tracker's Net
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["200108"] = true -- Ranger's Net
			-- Mage
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["61721"] = true -- Rabbit (Poly)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["61305"] = true -- Black Cat (Poly)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["28272"] = true -- Pig (Poly)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["28271"] = true -- Turtle (Poly)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["126819"] = true -- Porcupine (Poly)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["161354"] = true -- Monkey (Poly)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["161353"] = true -- Polar bear (Poly)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["61780"] = true -- Turkey (Poly)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["161355"] = true -- Penguin (Poly)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["161372"] = true -- Peacock (Poly)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["277787"] = true -- Direhorn (Poly)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["277792"] = true -- Bumblebee (Poly)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["118"] = true -- Polymorph
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["82691"] = true -- Ring of Frost
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["31661"] = true -- Dragon's Breath
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["122"] = true -- Frost Nova
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["33395"] = true -- Freeze
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["157997"] = true -- Ice Nova
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["228600"] = true -- Glacial Spike
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["198121"] = true -- Frostbite
			-- Monk
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["119381"] = true -- Leg Sweep
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["202346"] = true -- Double Barrel
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["115078"] = true -- Paralysis
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["198909"] = true -- Song of Chi-Ji
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["202274"] = true -- Incendiary Brew
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["233759"] = true -- Grapple Weapon
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["123407"] = true -- Spinning Fire Blossom
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["116706"] = true -- Disable
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["232055"] = true -- Fists of Fury (it's this one or the other)
			-- Paladin
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["853"] = true -- Hammer of Justice
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["20066"] = true -- Repentance
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["105421"] = true -- Blinding Light
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["31935"] = true -- Avenger's Shield
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["217824"] = true -- Shield of Virtue
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["205290"] = true -- Wake of Ashes
			-- Priest
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["9484"] = true -- Shackle Undead
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["200196"] = true -- Holy Word: Chastise
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["200200"] = true -- Holy Word: Chastise
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["226943"] = true -- Mind Bomb
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["605"] = true -- Mind Control
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["8122"] = true -- Psychic Scream
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["15487"] = true -- Silence
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["64044"] = true -- Psychic Horror
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["453"] = true -- Mind Soothe
			-- Rogue
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["2094"] = true -- Blind
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["6770"] = true -- Sap
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["1776"] = true -- Gouge
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["1330"] = true -- Garrote - Silence
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["207777"] = true -- Dismantle
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["199804"] = true -- Between the Eyes
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["408"] = true -- Kidney Shot
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["1833"] = true -- Cheap Shot
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["207736"] = true -- Shadowy Duel (Smoke effect)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["212182"] = true -- Smoke Bomb
			-- Shaman
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["51514"] = true -- Hex
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["211015"] = true -- Hex (Cockroach)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["211010"] = true -- Hex (Snake)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["211004"] = true -- Hex (Spider)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["210873"] = true -- Hex (Compy)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["196942"] = true -- Hex (Voodoo Totem)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["269352"] = true -- Hex (Skeletal Hatchling)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["277778"] = true -- Hex (Zandalari Tendonripper)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["277784"] = true -- Hex (Wicker Mongrel)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["118905"] = true -- Static Charge
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["77505"] = true -- Earthquake (Knocking down)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["118345"] = true -- Pulverize (Pet)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["204399"] = true -- Earthfury
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["204437"] = true -- Lightning Lasso
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["157375"] = true -- Gale Force
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["64695"] = true -- Earthgrab
			-- Warlock
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["710"] = true -- Banish
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["6789"] = true -- Mortal Coil
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["118699"] = true -- Fear
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["6358"] = true -- Seduction (Succub)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["171017"] = true -- Meteor Strike (Infernal)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["22703"] = true -- Infernal Awakening (Infernal CD)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["30283"] = true -- Shadowfury
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["89766"] = true -- Axe Toss
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["233582"] = true -- Entrenched in Flame
			-- Warrior
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["5246"] = true -- Intimidating Shout
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["132169"] = true -- Storm Bolt
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["132168"] = true -- Shockwave
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["199085"] = true -- Warpath
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["105771"] = true -- Charge
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["199042"] = true -- Thunderstruck
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["236077"] = true -- Disarm
			-- Racial
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["20549"] = true -- War Stomp
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["107079"] = true -- Quaking Palm
		else
			--wrath/tbc

			--for druid
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["778"] = true -- Faerie Fire (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["9749"] = true -- Faerie Fire (Rank 3)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["9907"] = true -- Faerie Fire (Rank 4)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["17390"] = true -- Faerie Fire (Feral) (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["17391"] = true -- Faerie Fire (Feral) (Rank 3)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["17392"] = true -- Faerie Fire (Feral) (Rank 4)

			--for hutner
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["14267"] = true -- Wing Clip (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["14268"] = true -- Wing Clip (Rank 3)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["19410"] = true -- Improved Concussive Shot

			--for paladin
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["2878"] = true -- Turn Undead (Rank 1)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["5627"] = true -- Turn Undead (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["31935"] = true -- Avenger's Shield
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["2812"] = true -- Holy Wrath (Rank 1)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["10318"] = true -- Holy Wrath (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["27139"] = true -- Holy Wrath (Rank 3)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["48816"] = true -- Holy Wrath (Rank 4)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["48817"] = true -- Holy Wrath (Rank 5)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["63529"] = true -- Silenced - Shield of the Templar

			--for rogue (tbc)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["14251"] = true -- Riposte
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["11201"] = true -- Crippling Poison (Rank 2)

			--for warrior
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["7372"] = true -- Hamstring (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["7373"] = true -- Hamstring (Rank 3)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["25212"] = true -- Hamstring (Rank 4)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["7405"] = true -- Sunder Armor (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["8380"] = true -- Sunder Armor (Rank 3)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["11596"] = true -- Sunder Armor (Rank 4)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["11597"] = true -- Sunder Armor (Rank 5)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["25225"] = true -- Sunder Armor (Rank 6)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["12798"] = true -- Revenge Stun

			--for mace spec
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["5530"] = true -- Mace Stun Effect
			--racial
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["44041"] = true -- Chastise

			--classic classic only
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["19675"] = true -- Feral Charge Effect
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["10911"] = true -- Mind Control (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["10912"] = true -- Mind Control (Rank 3)
			--Winter's Chill Debuff
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["12579"] = true -- Winter's Chill


			--Death Knight
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["55741"] = true -- Desecration
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["47481"] = true -- Gnaw (Ghoul)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["49203"] = true -- Hungering Cold
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["47476"] = true -- Strangulate
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["53534"] = true -- Chains of Ice
			-- Druid
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["339"] = true -- Entangling Roots (Rank 1)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["1062"] = true -- Entangling Roots (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["5195"] = true -- Entangling Roots (Rank 3)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["5196"] = true -- Entangling Roots (Rank 4)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["9852"] = true -- Entangling Roots (Rank 5)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["9853"] = true -- Entangling Roots (Rank 6)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["26989"] = true -- Entangling Roots (Rank 7)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["53308"] = true -- Entangling Roots (Rank 8)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["19975"] = true -- Entangling Roots (Nature's Grasp) (Rank 1)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["19974"] = true -- Entangling Roots (Nature's Grasp) (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["19973"] = true -- Entangling Roots (Nature's Grasp) (Rank 3)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["19972"] = true -- Entangling Roots (Nature's Grasp) (Rank 4)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["19971"] = true -- Entangling Roots (Nature's Grasp) (Rank 5)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["19970"] = true -- Entangling Roots (Nature's Grasp) (Rank 6)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["27010"] = true -- Entangling Roots (Nature's Grasp) (Rank 7)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["53313"] = true -- Entangling Roots (Nature's Grasp) (Rank 8)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["2637"] = true -- Hibernate (Rank 1)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["18657"] = true -- Hibernate (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["18658"] = true -- Hibernate (Rank 3)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["45334"] = true -- Feral Charge Effect
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["5211"] = true -- Bash (Rank 1)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["6798"] = true -- Bash (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["8983"] = true -- Bash (Rank 3)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["16922"] = true -- Celestial Focus (Starfire Stun)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["9005"] = true -- Pounce (Rank 1)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["9823"] = true -- Pounce (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["9827"] = true -- Pounce (Rank 3)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["27006"] = true -- Pounce (Rank 4)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["49803"] = true -- Pounce (Rank 5)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["770"] = true -- Faerie Fire
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["16857"] = true -- Faerie Fire (Feral)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["22570"] = true -- Maim (Rank 1)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["49802"] = true -- Maim (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["33786"] = true -- Cyclone
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["50259"] = true -- Dazed (Feral Charge - Cat)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["61391"] = true -- Typhoon
			-- Hunter
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["60210"] = true -- Freezing Arrow Effect
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["3355"] = true -- Freezing Trap Effect (Rank 1)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["14308"] = true -- Freezing Trap Effect (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["14309"] = true -- Freezing Trap Effect (Rank 3)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["13810"] = true -- Frost Trap Aura
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["19503"] = true -- Scatter Shot
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["5116"] = true -- Concussive Shot
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["2974"] = true -- Wing Clip
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["1513"] = true -- Scare Beast (Rank 1)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["14326"] = true -- Scare Beast (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["14327"] = true -- Scare Beast (Rank 3)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["24394"] = true -- Intimidation
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["19386"] = true -- Wyvern Sting (Rank 1)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["24132"] = true -- Wyvern Sting (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["24133"] = true -- Wyvern Sting (Rank 3)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["27068"] = true -- Wyvern Sting (Rank 4)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["49011"] = true -- Wyvern Sting (Rank 5)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["49012"] = true -- Wyvern Sting (Rank 6)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["19229"] = true -- Improved Wing Clip
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["19306"] = true -- Counterattack (Rank 1)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["20909"] = true -- Counterattack (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["20910"] = true -- Counterattack (Rank 3)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["27067"] = true -- Counterattack (Rank 4)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["48998"] = true -- Counterattack (Rank 5)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["48999"] = true -- Counterattack (Rank 6)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["34490"] = true -- Silencing Shot
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["25999"] = true -- Charge (Boar)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["19185"] = true -- Entrapment
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["53359"] = true -- Chimera Shot - Scorpid
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["35101"] = true -- Concussive Barrage
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["61394"] = true -- Glyph of Freezing Trap
			-- Mage
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["118"] = true -- Polymorph (Rank 1)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["12824"] = true -- Polymorph (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["12825"] = true -- Polymorph (Rank 3)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["12826"] = true -- Polymorph (Rank 4)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["28271"] = true -- Polymorph (Turtle)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["28272"] = true -- Polymorph (Pig)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["59634"] = true -- Polymorph (Penguin)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["61305"] = true -- Polymorph (Black Cat)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["61721"] = true -- Polymorph (Rabbit)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["61780"] = true -- Polymorph (Turkey)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["31661"] = true -- Dragon's Breath (Rank 1)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["33041"] = true -- Dragon's Breath (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["33042"] = true -- Dragon's Breath (Rank 3)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["33043"] = true -- Dragon's Breath (Rank 4)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["42949"] = true -- Dragon's Breath (Rank 5)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["42950"] = true -- Dragon's Breath (Rank 6)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["122"] = true -- Frost Nova (Rank 1)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["865"] = true -- Frost Nova (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["6131"] = true -- Frost Nova (Rank 3)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["10230"] = true -- Frost Nova (Rank 4)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["27088"] = true -- Frost Nova (Rank 5)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["42917"] = true -- Frost Nova (Rank 6)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["12494"] = true -- Frostbite
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["116"] = true -- Frostbolt (Rank 1)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["205"] = true -- Frostbolt (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["837"] = true -- Frostbolt (Rank 3)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["7322"] = true -- Frostbolt (Rank 4)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["8406"] = true -- Frostbolt (Rank 5)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["8407"] = true -- Frostbolt (Rank 6)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["8408"] = true -- Frostbolt (Rank 7)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["10179"] = true -- Frostbolt (Rank 8)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["10180"] = true -- Frostbolt (Rank 9)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["10181"] = true -- Frostbolt (Rank 10)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["25304"] = true -- Frostbolt (Rank 11)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["27071"] = true -- Frostbolt (Rank 12)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["27072"] = true -- Frostbolt (Rank 13)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["38697"] = true -- Frostbolt (Rank 14)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["42841"] = true -- Frostbolt (Rank 15)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["42842"] = true -- Frostbolt (Rank 16)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["12355"] = true -- Impact
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["18469"] = true -- Silenced - Improved Counterspell
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["33395"] = true -- Freeze (Water Elemental)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["11113"] = true -- Blast Wave
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["12484"] = true -- Chilled (Blizzard) (Rank 1)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["12485"] = true -- Chilled (Blizzard) (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["12486"] = true -- Chilled (Blizzard) (Rank 3)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["6136"] = true -- Chilled (Frost Armor)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["7321"] = true -- Chilled (Ice Armor)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["120"] = true -- Cone of Cold
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["44572"] = true -- Deep Freeze
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["64346"] = true -- Fiery Payback
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["44614"] = true -- Frostfire Bolt (Rank 1)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["47610"] = true -- Frostfire Bolt (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["31589"] = true -- Slow

			--missing in elvui list for mage
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["10159"] = true --Cone of Cold
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["10160"] = true --Cone of Cold
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["10161"] = true --Cone of Cold
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["27087"] = true --Cone of Cold
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["42930"] = true --Cone of Cold
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["42931"] = true --Cone of Cold
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["8492"] = true --Cone of Cold

			-- Paladin
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["853"] = true -- Hammer of Justice (Rank 1)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["5588"] = true -- Hammer of Justice (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["5589"] = true -- Hammer of Justice (Rank 3)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["10308"] = true -- Hammer of Justice (Rank 4)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["20066"] = true -- Repentance
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["20170"] = true -- Stun (Seal of Justice Proc)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["10326"] = true -- Turn Evil
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["63529"] = true -- Silenced - Shield of the Templar
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["31935"] = true -- Avenger's Shield
			-- Priest
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["8122"] = true -- Psychic Scream (Rank 1)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["8124"] = true -- Psychic Scream (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["10888"] = true -- Psychic Scream (Rank 3)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["10890"] = true -- Psychic Scream (Rank 4)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["605"] = true -- Mind Control
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["15269"] = true -- Blackout
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["15407"] = true -- Mind Flay (Rank 1)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["17311"] = true -- Mind Flay (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["17312"] = true -- Mind Flay (Rank 3)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["17313"] = true -- Mind Flay (Rank 4)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["17314"] = true -- Mind Flay (Rank 5)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["18807"] = true -- Mind Flay (Rank 6)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["25387"] = true -- Mind Flay (Rank 7)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["48155"] = true -- Mind Flay (Rank 8)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["48156"] = true -- Mind Flay (Rank 9)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["9484"] = true -- Shackle Undead (Rank 1)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["9485"] = true -- Shackle Undead (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["10955"] = true -- Shackle Undead (Rank 3)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["64044"] = true -- Psychic Horror
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["64058"] = true -- Psychic Horror (Disarm)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["15487"] = true -- Silence
			-- Rogue
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["6770"] = true -- Sap (Rank 1)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["2070"] = true -- Sap (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["11297"] = true -- Sap (Rank 3)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["51724"] = true -- Sap (Rank 4)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["2094"] = true -- Blind
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["408"] = true -- Kidney Shot (Rank 1)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["8643"] = true -- Kidney Shot (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["1833"] = true -- Cheap Shot
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["1776"] = true -- Gouge (Rank 1)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["1777"] = true -- Gouge (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["8629"] = true -- Gouge (Rank 3)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["11285"] = true -- Gouge (Rank 4)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["11286"] = true -- Gouge (Rank 5)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["38764"] = true -- Gouge (Rank 6)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["1330"] = true -- Garrote - Silence
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["18425"] = true -- Silenced - Improved Kick
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["51722"] = true -- Dismantle
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["31125"] = true -- Blade Twisting (Rank 1)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["51585"] = true -- Blade Twisting (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["3409"] = true -- Crippling Poison
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["26679"] = true -- Deadly Throw
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["32747"] = true -- Interrupt (Deadly Throw)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["51693"] = true -- Waylay
			-- Shaman
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["2484"] = true -- Earthbind Totem
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["8056"] = true -- Frost Shock (Rank 1)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["8058"] = true -- Frost Shock (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["10472"] = true -- Frost Shock (Rank 3)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["10473"] = true -- Frost Shock (Rank 4)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["25464"] = true -- Frost Shock (Rank 5)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["49235"] = true -- Frost Shock (Rank 6)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["49236"] = true -- Frost Shock (Rank 7)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["39796"] = true -- Stoneclaw Totem
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["58861"] = true -- Bash (Spirit Wolf)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["51514"] = true -- Hex
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["8034"] = true -- Frostbrand Attack (Rank 1)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["8037"] = true -- Frostbrand Attack (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["10458"] = true -- Frostbrand Attack (Rank 3)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["16352"] = true -- Frostbrand Attack (Rank 4)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["16353"] = true -- Frostbrand Attack (Rank 5)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["25501"] = true -- Frostbrand Attack (Rank 6)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["58797"] = true -- Frostbrand Attack (Rank 7)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["58798"] = true -- Frostbrand Attack (Rank 8)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["58799"] = true -- Frostbrand Attack (Rank 9)
			-- Warlock
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["5782"] = true -- Fear (Rank 1)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["6213"] = true -- Fear (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["6215"] = true -- Fear (Rank 3)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["6358"] = true -- Seduction (Succubus)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["18223"] = true -- Curse of Exhaustion
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["18093"] = true -- Pyroclasm
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["710"] = true -- Banish (Rank 1)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["18647"] = true -- Banish (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["30413"] = true -- Shadowfury
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["6789"] = true -- Death Coil (Rank 1)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["17925"] = true -- Death Coil (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["17926"] = true -- Death Coil (Rank 3)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["27223"] = true -- Death Coil (Rank 4)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["5484"] = true -- Howl of Terror (Rank 1)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["17928"] = true -- Howl of Terror (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["24259"] = true -- Spell Lock (Felhunter)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["18118"] = true -- Aftermath
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["20812"] = true -- Cripple (Doomguard)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["60995"] = true -- Demon Charge (Metamorphosis)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["1098"] = true -- Enslave Demon (Rank 1)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["11725"] = true -- Enslave Demon (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["11726"] = true -- Enslave Demon (Rank 3)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["61191"] = true -- Enslave Demon (Rank 4)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["63311"] = true -- Glyph of Shadowflame
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["30153"] = true -- Intercept (Felguard)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["31117"] = true -- Unstable Affliction (Silence)
			-- Warrior
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["20511"] = true -- Intimidating Shout (Cower)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["5246"] = true -- Intimidating Shout (Fear)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["1715"] = true -- Hamstring
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["12809"] = true -- Concussion Blow
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["20253"] = true -- Intercept Stun (Rank 1)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["20614"] = true -- Intercept Stun (Rank 2)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["20615"] = true -- Intercept Stun (Rank 3)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["25273"] = true -- Intercept Stun (Rank 4)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["25274"] = true -- Intercept Stun (Rank 5)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["7386"] = true -- Sunder Armor
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["7922"] = true -- Charge Stun
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["18498"] = true -- Silenced - Gag Order
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["46968"] = true -- Shockwave
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["23694"] = true -- Improved Hamstring
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["58373"] = true -- Glyph of Hamstring
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["676"] = true -- Disarm
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["12323"] = true -- Piercing Howl
			-- Racial
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["20549"] = true -- War Stomp
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["28730"] = true -- Arcane Torrent (Mana)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["25046"] = true -- Arcane Torrent (Energy)
			E.global["nameplates"]["filters"]["EltreumRefreshDebuff"]["triggers"]["debuffs"]["names"]["50613"] = true -- Arcane Torrent (Runic Power)
		end

		-- Enemy is casting, draw attention to interrupt
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["color"]["border"] = true
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["color"]["borderColor"]["b"] = 0.22745098039216
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["color"]["borderColor"]["g"] = 0.11764705882353
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["color"]["borderColor"]["r"] = 0.76862745098039
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["flash"]["color"]["b"] = 0
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["flash"]["color"]["g"] = 0
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["flash"]["color"]["r"] = 0
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["flash"]["enable"] = true
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["flash"]["speed"] = 7
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["scale"] = 1.2
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["texture"]["enable"] = true
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["texture"]["texture"] = "Eltreum-Stripes"
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["actions"]["alpha"] = 100
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["triggers"]["casting"]["interruptible"] = true
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["triggers"]["inCombat"] = true
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["triggers"]["notTarget"] = true
		E.global["nameplates"]["filters"]["EltreumInterrupt"]["triggers"]["priority"] = 1

		-- Enemy at execute range, general range bc different classes have different hp% executes
		E.global["nameplates"]["filters"]["EltreumExecute"]["actions"]["color"]["borderColor"]["b"] = 0
		E.global["nameplates"]["filters"]["EltreumExecute"]["actions"]["color"]["borderColor"]["g"] = 0
		E.global["nameplates"]["filters"]["EltreumExecute"]["actions"]["color"]["health"] = false --if true then gradient doesnt look as good
		E.global["nameplates"]["filters"]["EltreumExecute"]["actions"]["color"]["healthColor"]["b"] = 0.11764705882353
		E.global["nameplates"]["filters"]["EltreumExecute"]["actions"]["color"]["healthColor"]["g"] = 0.16470588235294
		E.global["nameplates"]["filters"]["EltreumExecute"]["actions"]["color"]["healthColor"]["r"] = 0.69411764705882
		E.global["nameplates"]["filters"]["EltreumExecute"]["actions"]["flash"]["color"]["b"] = 0
		E.global["nameplates"]["filters"]["EltreumExecute"]["actions"]["flash"]["color"]["g"] = 0
		E.global["nameplates"]["filters"]["EltreumExecute"]["actions"]["flash"]["color"]["r"] = 0
		E.global["nameplates"]["filters"]["EltreumExecute"]["actions"]["flash"]["enable"] = false
		E.global["nameplates"]["filters"]["EltreumExecute"]["actions"]["flash"]["speed"] = 7
		E.global["nameplates"]["filters"]["EltreumExecute"]["actions"]["scale"] = 1.25
		E.global["nameplates"]["filters"]["EltreumExecute"]["actions"]["texture"]["enable"] = true
		E.global["nameplates"]["filters"]["EltreumExecute"]["actions"]["texture"]["texture"] = "Asphyxia-Norm"
		E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["healthThreshold"] = true
		E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["isTarget"] = true
		E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["playerCanAttack"] = true
		E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["priority"] = 1
		E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["underHealthThreshold"] = 0.2
		E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["DEATHKNIGHT"] = {}
		E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["DEATHKNIGHT"]["enabled"] = true
		E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["HUNTER"] = {}
		E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["HUNTER"]["enabled"] = true
		E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["MAGE"] = {}
		E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["MAGE"]["enabled"] = true
		E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["MONK"] = {}
		E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["MONK"]["enabled"] = true
		E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["PALADIN"] = {}
		E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["PALADIN"]["enabled"] = true
		E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["PRIEST"] = {}
		E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["PRIEST"]["enabled"] = true
		E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["ROGUE"] = {}
		E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["ROGUE"]["enabled"] = true
		E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["WARLOCK"] = {}
		E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["WARLOCK"]["enabled"] = true
		E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["WARRIOR"] = {}
		E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["WARRIOR"]["enabled"] = true
		if E.Retail then
			E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["DEATHKNIGHT"]["specs"] = {}
			E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["DEATHKNIGHT"]["specs"][252] = true
			E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["HUNTER"]["specs"] = {}
			E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["HUNTER"]["specs"][253] = true
			E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["HUNTER"]["specs"][254] = true
			E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["HUNTER"]["specs"][255] = true
			E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["MAGE"]["specs"] = {}
			E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["MAGE"]["specs"][63] = true
			E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["MONK"]["specs"] = {}
			E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["MONK"]["specs"][268] = true
			E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["MONK"]["specs"][269] = true
			E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["MONK"]["specs"][270] = true
			E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["PALADIN"]["specs"] = {}
			E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["PALADIN"]["specs"][65] = true
			E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["PALADIN"]["specs"][66] = true
			E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["PALADIN"]["specs"][70] = true
			E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["PRIEST"]["specs"] = {}
			E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["PRIEST"]["specs"][258] = true
			E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["ROGUE"]["specs"] = {}
			E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["ROGUE"]["specs"][259] = true
			E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["WARLOCK"]["specs"] = {}
			E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["WARLOCK"]["specs"][265] = true
			E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["WARLOCK"]["specs"][267] = true
			E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["WARRIOR"]["specs"] = {}
			E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["WARRIOR"]["specs"][71] = true
			E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["WARRIOR"]["specs"][72] = true
			E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["class"]["WARRIOR"]["specs"][73] = true
		end

		--fancy rares
		E.global["nameplates"]["filters"]["EltreumRare"]["actions"]["color"]["health"] = true
		E.global["nameplates"]["filters"]["EltreumRare"]["actions"]["color"]["healthColor"]["b"] = 1
		E.global["nameplates"]["filters"]["EltreumRare"]["actions"]["color"]["healthColor"]["g"] = 1
		E.global["nameplates"]["filters"]["EltreumRare"]["actions"]["color"]["healthColor"]["r"] = 1
		E.global["nameplates"]["filters"]["EltreumRare"]["actions"]["texture"]["enable"] = true
		E.global["nameplates"]["filters"]["EltreumRare"]["actions"]["texture"]["texture"] = (rareclass[E.myclass])
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

		--E:StaggeredUpdateAll(nil, true)
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
end
