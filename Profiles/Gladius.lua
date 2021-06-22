local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local unpack = unpack

-- Gladdy profile setup
function ElvUI_EltreumUI:SetupGladius()
	Gladius2DB = {
		["profileKeys"] = {
		},
		["profiles"] = {
			["Eltreum"] = {
				["targetBarWidth"] = 69,
				["modules"] = {
					["Auras"] = true,
				},
				["aurasBuffsRelativePoint"] = "TOPLEFT",
				["powerBarUseDefaultColorRunicPower"] = true,
				["aurasBuffsPerColumn"] = 14,
				["tags"] = {
					["maxhealth"] = {
						["func"] = "function(unit)\nreturn not Gladius.test and UnitHealthMax(unit) or Gladius.testing[unit].maxHealth\nend",
						["events"] = "UNIT_HEALTH UNIT_MAXHEALTH UNIT_NAME_UPDATE",
					},
					["class:short"] = {
						["preparation"] = true,
						["func"] = "function(unit)\nreturn not Gladius.test and Gladius.L[LOCALIZED_CLASS_NAMES_MALE[Gladius.buttons[unit].class]..\":short\"] or Gladius.L[LOCALIZED_CLASS_NAMES_MALE[Gladius.testing[unit].unitClass]..\":short\"]\nend",
						["events"] = "UNIT_NAME_UPDATE",
					},
					["health:short"] = {
						["func"] = "function(unit)\nlocal health = not Gladius.test and UnitHealth(unit) or Gladius.testing[unit].health\nif (health > 999) then\nreturn strformat(\"%.1fk\", (health / 1000))\nelse\nreturn health\nend\nend",
						["events"] = "UNIT_HEALTH UNIT_MAXHEALTH UNIT_NAME_UPDATE",
					},
					["class"] = {
						["preparation"] = true,
						["func"] = "function(unit)\nreturn not Gladius.test and LOCALIZED_CLASS_NAMES_MALE[Gladius.buttons[unit].class] or LOCALIZED_CLASS_NAMES_MALE[Gladius.testing[unit].unitClass]\nend",
						["events"] = "UNIT_NAME_UPDATE",
					},
					["power:short"] = {
						["func"] = "function(unit)\nlocal power = not Gladius.test and UnitPower(unit) or Gladius.testing[unit].power\nif (power > 999) then\nreturn strformat(\"%.1fk\", (power / 1000))\nelse\nreturn power\nend\nend",
						["events"] = "UNIT_POWER_UPDATE UNIT_DISPLAYPOWER UNIT_NAME_UPDATE",
					},
					["race"] = {
						["func"] = "function(unit)\nreturn not Gladius.test and UnitRace(unit) or Gladius.testing[unit].unitRace\nend",
						["events"] = "UNIT_NAME_UPDATE",
					},
					["maxpower:short"] = {
						["func"] = "function(unit)\nlocal power = not Gladius.test and UnitPowerMax(unit) or Gladius.testing[unit].maxPower\nif (power > 999) then\nreturn strformat(\"%.1fk\", (power / 1000))\nelse\nreturn power\nend\nend",
						["events"] = "UNIT_MAXPOWER UNIT_DISPLAYPOWER UNIT_NAME_UPDATE",
					},
					["power"] = {
						["func"] = "function(unit)\nreturn not Gladius.test and UnitPower(unit) or Gladius.testing[unit].power\nend",
						["events"] = "UNIT_POWER_UPDATE UNIT_DISPLAYPOWER UNIT_NAME_UPDATE",
					},
					["name:status"] = {
						["func"] = "function(unit)\nreturn UnitIsDeadOrGhost(unit) and Gladius.L[\"DEAD\"] or (UnitName(unit) or unit)\nend",
						["events"] = "UNIT_NAME_UPDATE UNIT_HEALTH",
					},
					["spec"] = {
						["preparation"] = true,
						["func"] = "function(unit)\nreturn Gladius.test and Gladius.testing[unit].unitSpec or Gladius.buttons[unit].spec\nend",
						["events"] = "UNIT_NAME_UPDATE GLADIUS_SPEC_UPDATE",
					},
					["power:percentage"] = {
						["func"] = "function(unit)\nlocal power = not Gladius.test and UnitPower(unit) or Gladius.testing[unit].power\nlocal maxPower = not Gladius.test and UnitPowerMax(unit) or Gladius.testing[unit].maxPower\nreturn strformat(\"%.1f%%\", (power / maxPower * 100))\nend",
						["events"] = "UNIT_POWER_UPDATE UNIT_MAXPOWER UNIT_DISPLAYPOWER UNIT_NAME_UPDATE",
					},
					["name"] = {
						["func"] = "function(unit)\nreturn UnitName(unit) or unit\nend",
						["events"] = "UNIT_NAME_UPDATE",
					},
					["spec:short"] = {
						["preparation"] = true,
						["func"] = "function(unit)\nlocal spec = Gladius.test and Gladius.testing[unit].unitSpec or Gladius.buttons[unit].spec\nif (spec == nil or spec == \"\") then\nreturn \"\"\nend\nreturn Gladius.L[spec..\":short\"]\nend",
						["events"] = "UNIT_NAME_UPDATE GLADIUS_SPEC_UPDATE",
					},
					["health:percentage"] = {
						["func"] = "function(unit)\nlocal health = not Gladius.test and UnitHealth(unit) or Gladius.testing[unit].health\nlocal maxHealth = not Gladius.test and UnitHealthMax(unit) or Gladius.testing[unit].maxHealth\nreturn strformat(\"%.1f%%\", (health / maxHealth * 100))\nend",
						["events"] = "UNIT_HEALTH UNIT_MAXHEALTH UNIT_NAME_UPDATE",
					},
					["maxpower"] = {
						["func"] = "function(unit)\nreturn not Gladius.test and UnitPowerMax(unit) or Gladius.testing[unit].maxPower\nend",
						["events"] = "UNIT_MAXPOWER UNIT_DISPLAYPOWER UNIT_NAME_UPDATE",
					},
					["maxhealth:short"] = {
						["func"] = "function(unit)\nlocal health = not Gladius.test and UnitHealthMax(unit) or Gladius.testing[unit].maxHealth\nif (health > 999) then\nreturn strformat(\"%.1fk\", (health / 1000))\nelse\nreturn health\nend\nend",
						["events"] = "UNIT_HEALTH UNIT_MAXHEALTH UNIT_NAME_UPDATE",
					},
					["health"] = {
						["func"] = "function(unit)\nreturn not Gladius.test and UnitHealth(unit) or Gladius.testing[unit].health\nend",
						["events"] = "UNIT_HEALTH UNIT_MAXHEALTH UNIT_NAME_UPDATE",
					},
				},
				["trinketOffsetX"] = 0,
				["powerBarUseDefaultColorEnergy"] = true,
				["timerOmniCC"] = true,
				["targetBarAttachTo"] = "DRTracker",
				["aurasBuffsAttachTo"] = "Frame",
				["targetBarOffsetX"] = -100,
				["tagsVersion"] = 4,
				["dispellGloss"] = false,
				["locked"] = true,
				["classIconGloss"] = false,
				["aurasBuffsSpacingY"] = 2,
				["x"] = {
					["arena1"] = 1067.200311415531,
				},
				["RacialIconCrop"] = true,
				["bottomMargin"] = 46,
				["powerBarUseDefaultColorRage"] = true,
				["aurasBuffsHeight"] = 20,
				["aurasBuffsOffsetY"] = 25,
				["aurasBuffs"] = true,
				["aurasDebuffsHeight"] = 20,
				["targetBarAdjustWidth"] = false,
				["aurasBuffsWidth"] = 20,
				["RacialGloss"] = false,
				["globalFont"] = "Kimberley",
				["backgroundColor"] = {
					["a"] = 0,
				},
				["trinketGloss"] = false,
				["globalFontSize"] = 13,
				["direction"] = 2,
				["targetBarOffsetY"] = -20,
				["classIconOffsetX"] = 1,
				["dispellOffsetX"] = 2,
				["announcements"] = {
					["health"] = false,
					["spec"] = false,
					["enemies"] = false,
				},
				["aurasBuffsSpacingX"] = 2,
				["aurasDebuffsOffsetY"] = -25,
				["drTrackerOffsetY"] = 0,
				["castTimeTextSize"] = 12,
				["highlightWidth"] = 2,
				["auraVersion"] = 1,
				["y"] = {
					["arena1"] = 576.0668358927651,
				},
				["powerBarTexture"] = "Eltreum-Elvui-Norm",
				["trinketIconCrop"] = true,
				["aurasDebuffsRelativePoint"] = "TOPRIGHT",
				["castBarTexture"] = "Eltreum-Elvui-Norm",
				["castBarHeight"] = 16,
				["powerBarUseDefaultColorFocus"] = true,
				["aurasDebuffsWidth"] = 20,
				["barWidth"] = 220,
				["targetBarAnchor"] = "LEFT",
				["aurasBuffsOffsetX"] = -41,
				["healthBarTexture"] = "Eltreum-Elvui-Norm",
				["drTrackerSize"] = 40,
				["drTrackerCooldown"] = true,
				["targetBarRelativePoint"] = "BOTTOMLEFT",
				["dispellAttachTo"] = "Racial",
				["targetBarTexture"] = "Eltreum-Elvui-Norm",
				["classIconCrop"] = true,
				["aurasBuffsGrow"] = "UPRIGHT",
				["powerBarUseDefaultColorMana"] = true,
				["drTrackerAdjustSize"] = false,
				["castTextSize"] = 12,
				["backgroundPadding"] = 0,
				["targetBarIconCrop"] = true,
			},
		},
	}

end
