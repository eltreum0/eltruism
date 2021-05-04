local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

local pairs = pairs
local SetCVar = SetCVar
local IsAddOnLoaded = IsAddOnLoaded
local NP = E:GetModule('NamePlates')
local UF = E:GetModule('UnitFrames')


-- Attempt at non aspect ratio nameplate debuffs similar to plater
function ElvUI_EltreumUI:PostUpdateIcon(unit, button)
	if E.private.ElvUI_EltreumUI.widenameplate.enable then
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 38
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 38
		if button and button.spellID then
			if not string.find(unit, "nameplate") then
				return
			end
			local width =  25
			local height =  18
			-- this is the worst number of /reload of all time for me
			button.icon:SetTexCoord(0.07, 0.93, 0.21, 0.79)
			button:SetWidth(25)
			button:SetHeight(18)
			button.count:Point('BOTTOMRIGHT', 0, -3)
		end
		UF:PostUpdateAura(unit, button)
	else
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 43
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 43
	end
end

function ElvUI_EltreumUI:Construct_Auras(nameplate)
	nameplate.Buffs.PostUpdateIcon = ElvUI_EltreumUI.PostUpdateIcon
	nameplate.Debuffs.PostUpdateIcon = ElvUI_EltreumUI.PostUpdateIcon
end
hooksecurefunc(NP, "Construct_Auras", ElvUI_EltreumUI.Construct_Auras)

-- Change classpower background, ty Benik for the great help
local function ClassPowerColor()
    NP.multiplier = 0
end
hooksecurefunc(NP, 'Initialize', ClassPowerColor)
local function RuneBackground()
	NP.multiplier = 0
end
hooksecurefunc(NP, 'Construct_Runes', RuneBackground)

--- Friendly Nameplate Control
function ElvUI_EltreumUI:FriendlyNameplates()
	if E.private.ElvUI_EltreumUI.friendlynameplatetoggle.enable then
		local inInstance, instanceType = IsInInstance()
		if instanceType == "party" or instanceType == "raid" or instanceType == "pvp" or instanceType == "arena" or instanceType == "scenario" then
		--E:SetupCVars(noDisplayMsg)
			SetCVar("nameplateShowFriends", 0)
		end
		if instanceType == "none" then
		--E:SetupCVars(noDisplayMsg)
			SetCVar("nameplateShowFriends", 1)
		end
	end
end

-- Nameplate options for Border and Glow
function ElvUI_EltreumUI:NamePlateOptions()
	local nameplateclasscolors
	nameplateclasscolors = E:ClassColor(E.myclass, true)
	if E.private.ElvUI_EltreumUI.nameplateOptions.ClassColorGlow then
		E.db["nameplates"]["colors"]["glowColor"]["b"] = nameplateclasscolors.b
		E.db["nameplates"]["colors"]["glowColor"]["r"] = nameplateclasscolors.r
		E.db["nameplates"]["colors"]["glowColor"]["g"] = nameplateclasscolors.g
	end
	if E.private.ElvUI_EltreumUI.nameplateOptions.ClassBorderNameplate then
		E.global["nameplate"]["filters"]["ElvUI_Target"]["actions"]["color"]["borderColor"]["b"] = nameplateclasscolors.b
		E.global["nameplate"]["filters"]["ElvUI_Target"]["actions"]["color"]["borderColor"]["g"] = nameplateclasscolors.g
		E.global["nameplate"]["filters"]["ElvUI_Target"]["actions"]["color"]["borderColor"]["r"] = nameplateclasscolors.r
		E.global["nameplate"]["filters"]["ElvUI_Target"]["actions"]["color"]["border"] = true
	end
end



-- NamePlate Setup
function ElvUI_EltreumUI:SetupNamePlates(addon)

	if addon == 'ElvUI' then

		-- Toggle on
		E.private["nameplates"]["enable"] = true

		-- Style Filters & CVars
		ElvUI_EltreumUI:SetupStyleFilters()

		--Nameplates
		E.db["nameplates"]["clampToScreen"] = true
		E.db["nameplates"]["colors"]["classResources"]["DEATHKNIGHT"]["b"] = 1
		E.db["nameplates"]["colors"]["classResources"]["DEATHKNIGHT"]["g"] = 1
		E.db["nameplates"]["colors"]["classResources"]["DEATHKNIGHT"]["r"] = 0
		E.db["nameplates"]["colors"]["classResources"]["WARLOCK"]["r"] = 0.58039215686275
		E.db["nameplates"]["colors"]["glowColor"]["b"] = 0.86666476726532
		E.db["nameplates"]["colors"]["glowColor"]["g"] = 0.4392147064209
		E.db["nameplates"]["colors"]["glowColor"]["r"] = 0
		E.db["nameplates"]["colors"]["power"]["ENERGY"]["b"] = 0.53725490196078
		E.db["nameplates"]["colors"]["power"]["ENERGY"]["g"] = 0.96862745098039
		E.db["nameplates"]["colors"]["power"]["ENERGY"]["r"] = 1
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
		E.db["nameplates"]["colors"]["power"]["MANA"]["b"] = 1
		E.db["nameplates"]["colors"]["power"]["MANA"]["g"] = 0.71372549019608
		E.db["nameplates"]["colors"]["power"]["MANA"]["r"] = 0.49019607843137
		E.db["nameplates"]["colors"]["power"]["PAIN"]["b"] = 1
		E.db["nameplates"]["colors"]["power"]["PAIN"]["g"] = 1
		E.db["nameplates"]["colors"]["power"]["PAIN"]["r"] = 1
		E.db["nameplates"]["colors"]["power"]["RAGE"]["b"] = 0.32156862745098
		E.db["nameplates"]["colors"]["power"]["RAGE"]["g"] = 0.32156862745098
		E.db["nameplates"]["colors"]["power"]["RAGE"]["r"] = 1
		E.db["nameplates"]["cooldown"]["fonts"]["font"] = "Kimberley"
		E.db["nameplates"]["cooldown"]["fonts"]["fontOutline"] = "THICKOUTLINE"
		E.db["nameplates"]["filters"]["EnemyCasting"]["triggers"]["enable"] = true
		E.db["nameplates"]["filters"]["ExecuteRange"]["triggers"]["enable"] = true
		E.db["nameplates"]["filters"]["Pandemic"]["triggers"]["enable"] = false
		E.db["nameplates"]["filters"]["StealThisBuff"]["triggers"]["enable"] = true
		E.db["nameplates"]["highlight"] = false
		E.db["nameplates"]["lowHealthThreshold"] = 0.2
		E.db["nameplates"]["plateSize"]["friendlyHeight"] = 10
		E.db["nameplates"]["plateSize"]["friendlyWidth"] = 140
		E.db["nameplates"]["smoothbars"] = true
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["anchorPoint"] = "TOPRIGHT"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["countFont"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["countFontSize"] = 10
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["durationPosition"] = "TOPLEFT"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["growthX"] = "LEFT"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["numAuras"] = 6
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["size"] = 25
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["spacing"] = 0
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 43
		E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["castTimeFormat"] = "REMAINING"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["channelTimeFormat"] = "REMAINING"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["fontOutline"] = "THICKOUTLINE"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["fontSize"] = 10
		E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["height"] = 12
		E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["iconPosition"] = "LEFT"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["iconSize"] = 12
		E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["showIcon"] = false
		E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["textPosition"] = "ONBAR"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["timeToHold"] = 0.4
		E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["yOffset"] = -15
		E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["countFont"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["countFontSize"] = 10
		E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["durationPosition"] = "TOPLEFT"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["numAuras"] = 6
		E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["size"] = 25
		E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["spacing"] = 0
		E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 17
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
		E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["enable"] = false
		E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["fontOutline"] = "THICKOUTLINE"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["fontSize"] = 10
		E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["xOffset"] = 3
		E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["yOffset"] = -8
		E.db["nameplates"]["units"]["ENEMY_NPC"]["name"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_NPC"]["name"]["fontOutline"] = "THICKOUTLINE"
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
		E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["anchorPoint"] = "TOPRIGHT"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["countFont"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["countFontSize"] = 10
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["durationPosition"] = "TOPLEFT"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["growthX"] = "LEFT"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["numAuras"] = 6
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["size"] = 25
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["spacing"] = 0
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 43
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["castTimeFormat"] = "REMAINING"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["channelTimeFormat"] = "REMAINING"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["fontOutline"] = "THICKOUTLINE"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["fontSize"] = 10
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["height"] = 12
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["iconPosition"] = "LEFT"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["iconSize"] = 12
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["showIcon"] = false
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["textPosition"] = "ONBAR"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["timeToHold"] = 0.4
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["castbar"]["yOffset"] = -15
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["countFont"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["countFontSize"] = 10
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["durationPosition"] = "TOPLEFT"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["numAuras"] = 6
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["size"] = 25
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["spacing"] = 0
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 17
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
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["pvpclassificationindicator"]["position"] = "CENTER"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["pvpclassificationindicator"]["size"] = 100
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["pvpclassificationindicator"]["yOffset"] = 100
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["pvpindicator"]["position"] = "CENTER"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["pvpindicator"]["size"] = 24
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["pvpindicator"]["yOffset"] = 32
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["raidTargetIndicator"]["size"] = 32
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["raidTargetIndicator"]["xOffset"] = -26
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["title"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["title"]["fontSize"] = 10
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["title"]["format"] = "[namecolor][guild:brackets]"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["title"]["position"] = "CENTER"
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["title"]["yOffset"] = 0
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["buffs"]["countFont"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["buffs"]["enable"] = false
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["castbar"]["enable"] = false
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["castbar"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["castbar"]["timeToHold"] = 0.5
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["debuffs"]["countFont"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["debuffs"]["enable"] = false
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
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["fontOutline"] = "THICKOUTLINE"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["questIcon"]["xOffset"] = 2
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["raidTargetIndicator"]["position"] = "CENTER"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["raidTargetIndicator"]["size"] = 64
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["raidTargetIndicator"]["xOffset"] = 0
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["raidTargetIndicator"]["yOffset"] = 100
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["title"]["enable"] = true
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["title"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["title"]["format"] = "[namecolor][npctitle:brackets]"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["title"]["position"] = "CENTER"
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["title"]["yOffset"] = -5
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["buffs"]["countFont"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["buffs"]["countFontOutline"] = "NONE"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["buffs"]["enable"] = false
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["castbar"]["enable"] = false
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["castbar"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["castbar"]["fontOutline"] = "NONE"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["debuffs"]["countFont"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["debuffs"]["countFontOutline"] = "NONE"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["debuffs"]["countFontSize"] = 10
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["debuffs"]["enable"] = false
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["debuffs"]["numAuras"] = 8
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["debuffs"]["size"] = 25
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["debuffs"]["spacing"] = 0
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
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["pvpclassificationindicator"]["position"] = "CENTER"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["pvpclassificationindicator"]["size"] = 100
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["pvpclassificationindicator"]["yOffset"] = 100
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["pvpindicator"]["position"] = "CENTER"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["pvpindicator"]["size"] = 25
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["pvpindicator"]["yOffset"] = 35
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["raidTargetIndicator"]["position"] = "CENTER"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["raidTargetIndicator"]["size"] = 39
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["raidTargetIndicator"]["xOffset"] = 0
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["raidTargetIndicator"]["yOffset"] = 30
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["title"]["enable"] = true
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["title"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["title"]["format"] = "[namecolor][guild:brackets]"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["title"]["position"] = "CENTER"
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["title"]["yOffset"] = 0
		E.db["nameplates"]["units"]["PLAYER"]["buffs"]["countFont"] = "Kimberley"
		E.db["nameplates"]["units"]["PLAYER"]["buffs"]["countFontOutline"] = "NONE"
		E.db["nameplates"]["units"]["PLAYER"]["buffs"]["numAuras"] = 8
		E.db["nameplates"]["units"]["PLAYER"]["buffs"]["size"] = 17
		E.db["nameplates"]["units"]["PLAYER"]["buffs"]["spacing"] = 2
		E.db["nameplates"]["units"]["PLAYER"]["buffs"]["yOffset"] = 11
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["castTimeFormat"] = "REMAINING"
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["channelTimeFormat"] = "REMAINING"
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["fontOutline"] = "NONE"
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["fontSize"] = 10
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["height"] = 12
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["iconOffsetY"] = -1
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["iconPosition"] = "LEFT"
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["iconSize"] = 13
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["textPosition"] = "ONBAR"
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["timeToHold"] = 0.5
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["width"] = 139
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["xOffset"] = 6
		E.db["nameplates"]["units"]["PLAYER"]["castbar"]["yOffset"] = -30
		E.db["nameplates"]["units"]["PLAYER"]["classpower"]["height"] = 8
		E.db["nameplates"]["units"]["PLAYER"]["classpower"]["width"] = 150
		E.db["nameplates"]["units"]["PLAYER"]["classpower"]["yOffset"] = 15
		E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["anchorPoint"] = "TOPLEFT"
		E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["countFont"] = "Kimberley"
		E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["countFontOutline"] = "NONE"
		E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["growthX"] = "RIGHT"
		E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["numAuras"] = 8
		E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["size"] = 17
		E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["spacing"] = 2
		E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["yOffset"] = 28
		E.db["nameplates"]["units"]["PLAYER"]["health"]["height"] = 20
		E.db["nameplates"]["units"]["PLAYER"]["health"]["text"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["PLAYER"]["health"]["text"]["fontOutline"] = "THICKOUTLINE"
		E.db["nameplates"]["units"]["PLAYER"]["health"]["text"]["fontSize"] = 10
		E.db["nameplates"]["units"]["PLAYER"]["health"]["text"]["format"] = "[health:current-percent:shortvalue]"
		E.db["nameplates"]["units"]["PLAYER"]["health"]["text"]["parent"] = "Health"
		E.db["nameplates"]["units"]["PLAYER"]["health"]["text"]["position"] = "TOPRIGHT"
		E.db["nameplates"]["units"]["PLAYER"]["health"]["text"]["yOffset"] = -15
		E.db["nameplates"]["units"]["PLAYER"]["level"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["PLAYER"]["level"]["fontOutline"] = "NONE"
		E.db["nameplates"]["units"]["PLAYER"]["name"]["enable"] = true
		E.db["nameplates"]["units"]["PLAYER"]["name"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["PLAYER"]["name"]["fontOutline"] = "THICKOUTLINE"
		E.db["nameplates"]["units"]["PLAYER"]["name"]["fontSize"] = 10
		E.db["nameplates"]["units"]["PLAYER"]["name"]["parent"] = "Health"
		E.db["nameplates"]["units"]["PLAYER"]["name"]["xOffset"] = 2
		E.db["nameplates"]["units"]["PLAYER"]["name"]["yOffset"] = -15
		E.db["nameplates"]["units"]["PLAYER"]["portrait"]["classicon"] = false
		E.db["nameplates"]["units"]["PLAYER"]["power"]["height"] = 20
		E.db["nameplates"]["units"]["PLAYER"]["portrait"]["position"] = "CENTER"
		E.db["nameplates"]["units"]["PLAYER"]["portrait"]["width"] = 20
		E.db["nameplates"]["units"]["PLAYER"]["portrait"]["xOffset"] = 18
		E.db["nameplates"]["units"]["PLAYER"]["portrait"]["yOffset"] = 0
		E.db["nameplates"]["units"]["PLAYER"]["power"]["text"]["enable"] = true
		E.db["nameplates"]["units"]["PLAYER"]["power"]["text"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["PLAYER"]["power"]["text"]["fontOutline"] = "THICKOUTLINE"
		E.db["nameplates"]["units"]["PLAYER"]["power"]["text"]["fontSize"] = 10
		E.db["nameplates"]["units"]["PLAYER"]["power"]["text"]["format"] = "[powercolor][power:current:shortvalue]"
		E.db["nameplates"]["units"]["PLAYER"]["power"]["text"]["parent"] = "Power"
		E.db["nameplates"]["units"]["PLAYER"]["power"]["text"]["position"] = "TOPRIGHT"
		E.db["nameplates"]["units"]["PLAYER"]["power"]["text"]["xOffset"] = 1
		E.db["nameplates"]["units"]["PLAYER"]["power"]["text"]["yOffset"] = -11
		E.db["nameplates"]["units"]["PLAYER"]["power"]["yOffset"] = -17
		E.db["nameplates"]["units"]["PLAYER"]["pvpclassificationindicator"]["position"] = "CENTER"
		E.db["nameplates"]["units"]["PLAYER"]["pvpclassificationindicator"]["size"] = 100
		E.db["nameplates"]["units"]["PLAYER"]["pvpclassificationindicator"]["xOffset"] = 25
		E.db["nameplates"]["units"]["PLAYER"]["pvpclassificationindicator"]["yOffset"] = 7
		E.db["nameplates"]["units"]["PLAYER"]["pvpindicator"]["position"] = "CENTER"
		E.db["nameplates"]["units"]["PLAYER"]["pvpindicator"]["showBadge"] = false
		E.db["nameplates"]["units"]["PLAYER"]["pvpindicator"]["size"] = 64
		E.db["nameplates"]["units"]["PLAYER"]["pvpindicator"]["yOffset"] = 54
		E.db["nameplates"]["units"]["PLAYER"]["raidTargetIndicator"]["enable"] = false
		E.db["nameplates"]["units"]["PLAYER"]["raidTargetIndicator"]["position"] = "CENTER"
		E.db["nameplates"]["units"]["PLAYER"]["raidTargetIndicator"]["xOffset"] = 0
		E.db["nameplates"]["units"]["PLAYER"]["raidTargetIndicator"]["yOffset"] = 20
		E.db["nameplates"]["units"]["PLAYER"]["showTitle"] = false
		E.db["nameplates"]["units"]["PLAYER"]["title"]["font"] = "Kimberley"
		E.db["nameplates"]["units"]["PLAYER"]["title"]["fontOutline"] = "NONE"
		E.db["nameplates"]["units"]["PLAYER"]["title"]["format"] = ""
		E.db["nameplates"]["units"]["PLAYER"]["visibility"]["hideDelay"] = 0
		E.db["nameplates"]["units"]["PLAYER"]["visibility"]["showInCombat"] = false
		E.db["nameplates"]["units"]["PLAYER"]["visibility"]["showWithTarget"] = true
		E.db["nameplates"]["units"]["TARGET"]["arrow"] = "Arrow21"
		E.db["nameplates"]["units"]["TARGET"]["arrowScale"] = 0.4
		E.db["nameplates"]["units"]["TARGET"]["arrowSpacing"] = 0
		E.db["nameplates"]["units"]["TARGET"]["classpower"]["classColor"] = true
		E.db["nameplates"]["units"]["TARGET"]["classpower"]["enable"] = true
		E.db["nameplates"]["units"]["TARGET"]["classpower"]["sortDirection"] = "asc"
		E.db["nameplates"]["units"]["TARGET"]["classpower"]["width"] = 150
		E.db["nameplates"]["units"]["TARGET"]["classpower"]["yOffset"] = 26
		E.db["nameplates"]["visibility"]["enemy"]["totems"] = true

		-- Set CVars
		ElvUI_EltreumUI:NameplateCVars()

		end
end

-- Style Filter Setup
function ElvUI_EltreumUI:SetupStyleFilters()
	for _, filterName in pairs({'ElvUI_Explosives', 'ElvUI_NonTarget', 'ElvUI_Target', 'EnemyCasting', 'ExecuteRange', 'Pandemic', 'StealThisBuff'}) do
		E.global["nameplate"]["filters"][filterName] = {}
		E.NamePlates:StyleFilterCopyDefaults(E.global["nameplate"]["filters"][filterName])
		E.db["nameplates"]["filters"][filterName] = { triggers = { enable = true } }
	end

	-- Explosives
	E.global["nameplate"]["filters"]["ElvUI_Explosives"]["actions"]["color"]["health"] = false
	E.global["nameplate"]["filters"]["ElvUI_Explosives"]["actions"]["color"]["healthColor"]["b"] = 1
	E.global["nameplate"]["filters"]["ElvUI_Explosives"]["actions"]["color"]["healthColor"]["g"] = 1
	E.global["nameplate"]["filters"]["ElvUI_Explosives"]["actions"]["color"]["healthColor"]["r"] = 1
	E.global["nameplate"]["filters"]["ElvUI_Explosives"]["actions"]["scale"] = 1
	E.global["nameplate"]["filters"]["ElvUI_Explosives"]["actions"]["usePortrait"] = false
	E.global["nameplate"]["filters"]["ElvUI_Explosives"]["triggers"]["nameplateType"]["enable"] = false
	E.global["nameplate"]["filters"]["ElvUI_Explosives"]["triggers"]["nameplateType"]["enemyNPC"] = false
	E.global["nameplate"]["filters"]["ElvUI_Explosives"]["triggers"]["priority"] = 3
	-- Non targeted enemies
	E.global["nameplate"]["filters"]["ElvUI_NonTarget"]["actions"]["alpha"] = 20
	E.global["nameplate"]["filters"]["ElvUI_NonTarget"]["actions"]["scale"] = 0.75
	E.global["nameplate"]["filters"]["ElvUI_NonTarget"]["triggers"]["nameplateType"]["enable"] = false
	E.global["nameplate"]["filters"]["ElvUI_NonTarget"]["triggers"]["nameplateType"]["enemyNPC"] = false
	E.global["nameplate"]["filters"]["ElvUI_NonTarget"]["triggers"]["nameplateType"]["enemyPlayer"] = false
	E.global["nameplate"]["filters"]["ElvUI_NonTarget"]["triggers"]["nameplateType"]["friendlyNPC"] = false
	E.global["nameplate"]["filters"]["ElvUI_NonTarget"]["triggers"]["nameplateType"]["friendlyPlayer"] = false
	E.global["nameplate"]["filters"]["ElvUI_NonTarget"]["triggers"]["requireTarget"] = true
	E.global["nameplate"]["filters"]["ElvUI_NonTarget"]["triggers"]["notTarget"] = true
	E.global["nameplate"]["filters"]["ElvUI_NonTarget"]["triggers"]["priority"] = 4
	-- Target enemy
	E.global["nameplate"]["filters"]["ElvUI_Target"]["actions"]["color"]["border"] = true
	E.global["nameplate"]["filters"]["ElvUI_Target"]["actions"]["color"]["borderColor"]["b"] = 0.86666476726532
	E.global["nameplate"]["filters"]["ElvUI_Target"]["actions"]["color"]["borderColor"]["g"] = 0.4392147064209
	E.global["nameplate"]["filters"]["ElvUI_Target"]["actions"]["color"]["borderColor"]["r"] = 0
	E.global["nameplate"]["filters"]["ElvUI_Target"]["triggers"]["isTarget"] = true
	E.global["nameplate"]["filters"]["ElvUI_Target"]["triggers"]["requireTarget"] = true
	E.global["nameplate"]["filters"]["ElvUI_Target"]["actions"]["scale"] = 1.25
	E.global["nameplate"]["filters"]["ElvUI_Target"]["actions"]["texture"]["enable"] = true
	E.global["nameplate"]["filters"]["ElvUI_Target"]["actions"]["texture"]["texture"] = "ElvUI Blank"
	-- Enemy is casting, draw attention to interrupt
	E.global["nameplate"]["filters"]["EnemyCasting"]["actions"]["color"]["border"] = true
	E.global["nameplate"]["filters"]["EnemyCasting"]["actions"]["color"]["borderColor"]["b"] = 0.22745098039216
	E.global["nameplate"]["filters"]["EnemyCasting"]["actions"]["color"]["borderColor"]["g"] = 0.11764705882353
	E.global["nameplate"]["filters"]["EnemyCasting"]["actions"]["color"]["borderColor"]["r"] = 0.76862745098039
	E.global["nameplate"]["filters"]["EnemyCasting"]["actions"]["flash"]["color"]["b"] = 0
	E.global["nameplate"]["filters"]["EnemyCasting"]["actions"]["flash"]["color"]["g"] = 0
	E.global["nameplate"]["filters"]["EnemyCasting"]["actions"]["flash"]["color"]["r"] = 0
	E.global["nameplate"]["filters"]["EnemyCasting"]["actions"]["flash"]["enable"] = true
	E.global["nameplate"]["filters"]["EnemyCasting"]["actions"]["flash"]["speed"] = 1
	E.global["nameplate"]["filters"]["EnemyCasting"]["actions"]["scale"] = 1.2
	E.global["nameplate"]["filters"]["EnemyCasting"]["actions"]["texture"]["enable"] = true
	E.global["nameplate"]["filters"]["EnemyCasting"]["actions"]["texture"]["texture"] = "Ohi MetalPlate"
	E.global["nameplate"]["filters"]["EnemyCasting"]["triggers"]["casting"]["interruptible"] = true
	E.global["nameplate"]["filters"]["EnemyCasting"]["triggers"]["inCombat"] = true
	E.global["nameplate"]["filters"]["EnemyCasting"]["triggers"]["notTarget"] = true
	E.global["nameplate"]["filters"]["EnemyCasting"]["triggers"]["priority"] = 12
	-- Enemy at execute range, general range bc different classes have different hp% executes
	E.global["nameplate"]["filters"]["ExecuteRange"]["actions"]["color"]["borderColor"]["b"] = 0
	E.global["nameplate"]["filters"]["ExecuteRange"]["actions"]["color"]["borderColor"]["g"] = 0
	E.global["nameplate"]["filters"]["ExecuteRange"]["actions"]["color"]["healthColor"]["b"] = 0.011764705882353
	E.global["nameplate"]["filters"]["ExecuteRange"]["actions"]["color"]["healthColor"]["g"] = 0
	E.global["nameplate"]["filters"]["ExecuteRange"]["actions"]["flash"]["color"]["b"] = 0
	E.global["nameplate"]["filters"]["ExecuteRange"]["actions"]["flash"]["color"]["g"] = 0
	E.global["nameplate"]["filters"]["ExecuteRange"]["actions"]["flash"]["color"]["r"] = 0
	E.global["nameplate"]["filters"]["ExecuteRange"]["actions"]["flash"]["enable"] = true
	E.global["nameplate"]["filters"]["ExecuteRange"]["actions"]["flash"]["speed"] = 2
	E.global["nameplate"]["filters"]["ExecuteRange"]["actions"]["scale"] = 1.25
	E.global["nameplate"]["filters"]["ExecuteRange"]["actions"]["texture"]["texture"] = "Ohi MetalPlate"
	E.global["nameplate"]["filters"]["ExecuteRange"]["triggers"]["healthThreshold"] = true
	E.global["nameplate"]["filters"]["ExecuteRange"]["triggers"]["isTarget"] = true
	E.global["nameplate"]["filters"]["ExecuteRange"]["triggers"]["priority"] = 10
	E.global["nameplate"]["filters"]["ExecuteRange"]["triggers"]["underHealthThreshold"] = 0.2

	E:StaggeredUpdateAll(nil, true)


	ElvUI_EltreumUI:Print('NamePlates have been setup.')
end
