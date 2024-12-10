local E, L = unpack(ElvUI)
local valuecolors = E:ClassColor(E.myclass, true)
local _G = _G
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded
local tostring = _G.tostring
local SetCVar = _G.C_CVar and _G.C_CVar.SetCVar or _G.SetCVar
local math = _G.math
local GetPhysicalScreenSize = _G.GetPhysicalScreenSize

function ElvUI_EltreumUI:SetupGeneralLayout()
	if not E.db.movers then E.db.movers = {} end
	local width = GetPhysicalScreenSize()
	-- Setup UI Scale
	E.global["general"]["UIScale"] = 0.71111111111111

	-- Setup Global DB
	ElvUI_EltreumUI:SetupGlobal()

	-- Setup Private DB
	ElvUI_EltreumUI:SetupPrivate()

	--Setup CVars
	ElvUI_EltreumUI:SetupCVars()

	--Setup Eltruism DataText
	ElvUI_EltreumUI:SetupDataText()

	--make Aura Filters use Textured Icons
	ElvUI_EltreumUI:AuraFiltersUpdate()

	-- ProjectAzilroka Profile
	ElvUI_EltreumUI:AddonSetupPA()

	-- AddOnSkins Profile
	ElvUI_EltreumUI:AddonSetupAS()

	--SetupShadowAndLight
	if IsAddOnLoaded("ElvUI_SLE") then
		ElvUI_EltreumUI:GetSLEProfile()
	end

	if IsAddOnLoaded("ProjectAzilroka") then
		--E.db["movers"]["SquareMinimapButtonBarMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-5,-226"
		E.db["movers"]["SquareMinimapButtonBarMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-6,-205"
	end

	if IsAddOnLoaded("ElvUI_WindTools") then
		ElvUI_EltreumUI:GetWindToolsProfile()
	end

	--tag update rate
	E.db["general"]["tagUpdateRate"] = 0.25 --test 0.5, default is 0.25

	-- AB Conversion
	E.db["convertPages"] = true

	--luckyone based optimizations
	E.db["auras"]["buffs"]["seperateOwn"] = 0 -- do not sort auras
	E.db["auras"]["debuffs"]["seperateOwn"] = 0 -- do not sort auras
	E.db["auras"]["cooldown"]["override"] = false
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

	--to make sure its correct height
	E.db["unitframe"]["units"]["player"]["height"] = 54
	E.db["unitframe"]["units"]["player"]["infoPanel"]["enable"] = false
	E.db["unitframe"]["units"]["target"]["height"] = 54
	E.db["unitframe"]["units"]["target"]["infoPanel"]["enable"] = false
	E.db["unitframe"]["units"]["targettarget"]["height"] = 54
	E.db["unitframe"]["units"]["player"]["classbar"]["height"] = 10
	E.db["unitframe"]["units"]["player"]["power"]["height"] = 15
	E.db["unitframe"]["units"]["target"]["power"]["height"] = 15

	--reverse target
	E.db["unitframe"]["units"]["target"]["health"]["reverseFill"] = false
	E.db["unitframe"]["units"]["target"]["power"]["reverseFill"] = false

	--general pixel perfect things
	E.private["general"]["pixelPerfect"] = true
	E.db["unitframe"]["thinBorders"] = true
	E.db["nameplates"]["thinBorders"] = true

	--transparent things
	E.db["unitframe"]["colors"]["transparentAurabars"] = true
	E.db["unitframe"]["colors"]["transparentCastbar"] = true
	E.db["unitframe"]["colors"]["transparentHealth"] = true
	E.db["unitframe"]["colors"]["transparentPower"] = true

	--combat icon
	E.db["unitframe"]["units"]["focus"]["CombatIcon"]["xOffset"] = -87
	E.db["unitframe"]["units"]["focus"]["CombatIcon"]["yOffset"] = 10
	E.db["unitframe"]["units"]["focus"]["CombatIcon"]["enable"] = false
	E.db["unitframe"]["units"]["party"]["CombatIcon"]["color"]["b"] = 1
	E.db["unitframe"]["units"]["party"]["CombatIcon"]["color"]["g"] = 1
	E.db["unitframe"]["units"]["party"]["CombatIcon"]["defaultColor"] = true
	E.db["unitframe"]["units"]["party"]["CombatIcon"]["enable"] = false
	E.db["unitframe"]["units"]["party"]["CombatIcon"]["texture"] = "Eltruism16"

	E.db["unitframe"]["units"]["player"]["CombatIcon"]["anchorPoint"] = "RIGHT"
	E.db["unitframe"]["units"]["player"]["CombatIcon"]["defaultColor"] = true
	E.db["unitframe"]["units"]["player"]["CombatIcon"]["texture"] = "Eltruism15"
	E.db["unitframe"]["units"]["player"]["CombatIcon"]["size"] = 30
	E.db["unitframe"]["units"]["player"]["CombatIcon"]["xOffset"] = 15
	E.db["unitframe"]["units"]["player"]["CombatIcon"]["yOffset"] = 0
	E.db["unitframe"]["units"]["player"]["CombatIcon"]["enable"] = true
	E.db["unitframe"]["units"]["target"]["CombatIcon"]["anchorPoint"] = "LEFT"
	E.db["unitframe"]["units"]["target"]["CombatIcon"]["defaultColor"] = true
	E.db["unitframe"]["units"]["target"]["CombatIcon"]["xOffset"] = -15
	E.db["unitframe"]["units"]["target"]["CombatIcon"]["yOffset"] = 0
	E.db["unitframe"]["units"]["target"]["CombatIcon"]["texture"] = "Eltruism29"
	E.db["unitframe"]["units"]["target"]["CombatIcon"]["size"] = 30
	E.db["unitframe"]["units"]["target"]["CombatIcon"]["enable"] = true

	--private auras
	E.db["movers"]["PrivateAurasMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-287,-150"
	E.db["unitframe"]["units"]["party"]["privateAuras"]["parent"]["offsetY"] = 12
	E.db["unitframe"]["units"]["raid1"]["privateAuras"]["parent"]["offsetY"] = 5
	E.db["unitframe"]["units"]["raid2"]["privateAuras"]["parent"]["offsetY"] = 5
	E.db["unitframe"]["units"]["raid3"]["privateAuras"]["parent"]["offsetY"] = 5

	--rest icon
	E.db["unitframe"]["units"]["player"]["RestIcon"]["color"]["a"] = 1.00
	E.db["unitframe"]["units"]["player"]["RestIcon"]["color"]["r"] = valuecolors.r
	E.db["unitframe"]["units"]["player"]["RestIcon"]["color"]["g"] = valuecolors.g
	E.db["unitframe"]["units"]["player"]["RestIcon"]["color"]["b"] = valuecolors.b
	E.db["unitframe"]["units"]["player"]["RestIcon"]["defaultColor"] = false
	E.db["unitframe"]["units"]["player"]["RestIcon"]["size"] = 15
	E.db["unitframe"]["units"]["player"]["RestIcon"]["texture"] = "Eltruism01"
	E.db["unitframe"]["units"]["player"]["RestIcon"]["xOffset"] = 13
	E.db["unitframe"]["units"]["player"]["RestIcon"]["yOffset"] = 1

	--bag search
	E.db["bags"]["spinner"]["color"]["r"] = valuecolors.r
	E.db["bags"]["spinner"]["color"]["g"] = valuecolors.g
	E.db["bags"]["spinner"]["color"]["b"] = valuecolors.b

	--paging
	if E.Retail or E.Cata then
		E.db["actionbar"]["bar4"]["paging"]["DEATHKNIGHT"] = "[overridebar] 18; [vehicleui] 16;[possessbar] 16;[bonusbar:5] 11;"
		E.db["actionbar"]["bar4"]["paging"]["DEMONHUNTER"] = "[overridebar] 18; [vehicleui] 16;[possessbar] 16;[bonusbar:5] 11;"
		E.db["actionbar"]["bar4"]["paging"]["DRUID"] = "[overridebar] 18; [vehicleui] 16; [possessbar] 16; [bonusbar:1,nostealth] 7; [bonusbar:1,stealth] 8; [bonusbar:2] 10; [bonusbar:3] 9; [bonusbar:4] 10;[bonusbar:5] 11;"
		E.db["actionbar"]["bar4"]["paging"]["HUNTER"] = "[overridebar] 18; [vehicleui] 16;[possessbar] 16;[bonusbar:5] 11;"
		E.db["actionbar"]["bar4"]["paging"]["MAGE"] = "[overridebar] 18; [vehicleui] 16;[possessbar] 16;[bonusbar:5] 11;"
		E.db["actionbar"]["bar4"]["paging"]["MONK"] = "[overridebar] 18; [vehicleui] 16; [possessbar] 16;[bonusbar:5] 11;"
		E.db["actionbar"]["bar4"]["paging"]["PALADIN"] = "[overridebar] 18; [vehicleui] 16; [possessbar] 16;[bonusbar:5] 11;"
		E.db["actionbar"]["bar4"]["paging"]["PRIEST"] = "[overridebar] 18; [vehicleui] 16; [possessbar] 16;[bonusbar:5] 11;"
		E.db["actionbar"]["bar4"]["paging"]["ROGUE"] = "[bonusbar:1] 7;[bonusbar:1,nostealth] 4; [bonusbar:1,stealth] 7; [overridebar] 18; [vehicleui] 16; [possessbar] 16;[bonusbar:2] 8;[bonusbar:5] 11;" --other other besides this was causing problems with shadow dance
		E.db["actionbar"]["bar4"]["paging"]["SHAMAN"] = "[overridebar] 18; [vehicleui] 16; [possessbar] 16;[bonusbar:5] 11;"
		E.db["actionbar"]["bar4"]["paging"]["WARLOCK"] = "[overridebar] 18; [vehicleui] 16;[possessbar] 16;[bonusbar:5] 11;"
		E.db["actionbar"]["bar4"]["paging"]["WARRIOR"] = "[overridebar] 18; [vehicleui] 16;[possessbar] 16;[bonusbar:5] 11;[stance:1] 7; [stance:2] 8; [stance:3] 9;"
		E.db["actionbar"]["bar4"]["paging"]["EVOKER"] = "[overridebar] 18; [vehicleui] 16; [possessbar] 16;[bonusbar:5] 11;[bonusbar:1] 7;"
	else
		E.db["actionbar"]["bar4"]["paging"]["DEATHKNIGHT"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[bonusbar:5] 11;"
		E.db["actionbar"]["bar4"]["paging"]["DEMONHUNTER"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[bonusbar:5] 11;"
		E.db["actionbar"]["bar4"]["paging"]["DRUID"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12; [bonusbar:1,nostealth] 7; [bonusbar:1,stealth] 8; [bonusbar:2] 10; [bonusbar:3] 9; [bonusbar:4] 10;[bonusbar:5] 11;"
		E.db["actionbar"]["bar4"]["paging"]["HUNTER"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[bonusbar:5] 11;"
		E.db["actionbar"]["bar4"]["paging"]["MAGE"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[bonusbar:5] 11;"
		E.db["actionbar"]["bar4"]["paging"]["MONK"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12;[bonusbar:5] 11;"
		E.db["actionbar"]["bar4"]["paging"]["PALADIN"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12;[bonusbar:5] 11;"
		E.db["actionbar"]["bar4"]["paging"]["ROGUE"] = "[bonusbar:1] 7;[bonusbar:1,nostealth] 4; [bonusbar:1,stealth] 7; [vehicleui] 12; [overridebar] 14; [possessbar] 12;[bonusbar:2] 8;[bonusbar:5] 11;" --other other besides this was causing problems with shadow dance
		E.db["actionbar"]["bar4"]["paging"]["SHAMAN"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12;[bonusbar:5] 11;"
		E.db["actionbar"]["bar4"]["paging"]["WARLOCK"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[form:1] 7;[bonusbar:5] 11;"
		E.db["actionbar"]["bar4"]["paging"]["WARRIOR"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[bonusbar:5] 11; [stance:1] 7; [stance:2] 8; [stance:3] 9;"
		E.db["actionbar"]["bar4"]["paging"]["PRIEST"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 16;[bonusbar:5] 11; [stance:1] 7;"
	end

	--aura filtering
	ElvUI_EltreumUI:SetupAllAuras("Minimal")
	--[[
		E.db["unitframe"]["units"]["player"]["debuffs"]["priority"] = "Blacklist,blockNoDuration,Personal,nonPersonal"
		E.db["unitframe"]["units"]["player"]["buffs"]["priority"] = "Blacklist,Personal,nonPersonal"
		E.db["unitframe"]["units"]["arena"]["debuffs"]["priority"] = "Blacklist,Personal,CCDebuffs"
		E.db["unitframe"]["units"]["focus"]["debuffs"]["priority"] = "Blacklist,Personal,CCDebuffs"
		E.db["unitframe"]["units"]["boss"]["debuffs"]["priority"] = "Blacklist,CCDebuffs,RaidDebuffs"
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["priority"] = "Blacklist,RaidDebuffs,Dispellable"
		E.db["unitframe"]["units"]["raid2"]["debuffs"]["priority"] = "Blacklist,RaidDebuffs,Dispellable"
		E.db["unitframe"]["units"]["raid3"]["debuffs"]["priority"] = "Blacklist,RaidDebuffs,Dispellable"
		E.db["unitframe"]["units"]["party"]["debuffs"]["priority"] = "Blacklist,RaidDebuffs,Dispellable"
		E.db["unitframe"]["units"]["tank"]["debuffs"]["priority"] = "Blacklist,Boss,RaidDebuffs,CCDebuffs,Dispellable,Whitelist"
		E.db["unitframe"]["units"]["tank"]["buffs"]["priority"] = "Blacklist,TurtleBuffs,RaidBuffsElvUI"
		E.db["unitframe"]["units"]["assist"]["buffs"]["priority"] = "Blacklist,TurtleBuffs,RaidBuffsElvUI"
		--E.db["unitframe"]["units"]["target"]["aurabar"]["priority"] = "Blacklist,blockNoDuration,Personal,CCDebuffs,RaidDebuffs,Dispellable,PlayerBuffs,RaidBuffsElvUI,TurtleBuffs"
		E.db["unitframe"]["units"]["target"]["aurabar"]["priority"] = "Blacklist,blockNoDuration,Personal,Boss,RaidDebuffs,PlayerBuffs,RaidBuffsElvUI,TurtleBuffs"
		E.db["unitframe"]["units"]["target"]["buffs"]["priority"] = "Blacklist,Dispellable,blockNoDuration,PlayerBuffs,nonPersonal,RaidBuffsElvUI,TurtleBuffs"
		E.db["unitframe"]["units"]["target"]["debuffs"]["priority"] = "Blacklist,Personal,CCDebuffs"
		E.db["unitframe"]["units"]["pet"]["buffs"]["priority"] = "Blacklist,blockNoDuration,Personal,MyPet"
		E.db["unitframe"]["units"]["pet"]["debuffs"]["priority"] = "Blacklist,Personal,nonPersonal"
		E.db["unitframe"]["units"]["focustarget"]["buffs"]["priority"] = "Blacklist,Personal,PlayerBuffs,Dispellable"
		E.db["unitframe"]["units"]["arena"]["buffs"]["priority"] = "Blacklist,Dispellable,RaidBuffsElvUI,TurtleBuffs"
		E.db["unitframe"]["units"]["focus"]["buffs"]["priority"] = "Blacklist,Dispellable,RaidBuffsElvUI,TurtleBuffs"
		E.db["unitframe"]["units"]["boss"]["buffs"]["priority"] = "Blacklist,Dispellable,RaidBuffsElvUI,TurtleBuffs"
	]]

	E.db["unitframe"]["units"]["pet"]["buffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["pet"]["buffs"]["countFontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["pet"]["debuffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["pet"]["debuffs"]["countFontOutline"] = "OUTLINE"

	--fix possible issue
	E.db["unitframe"]["units"]["party"]["health"]["orientation"] = "HORIZONTAL"
	E.db["unitframe"]["units"]["player"]["health"]["orientation"] = "HORIZONTAL"
	E.db["unitframe"]["units"]["focus"]["health"]["orientation"] = "HORIZONTAL"
	E.db["unitframe"]["units"]["raid1"]["health"]["orientation"] = "HORIZONTAL"
	E.db["unitframe"]["units"]["raid2"]["health"]["orientation"] = "HORIZONTAL"
	E.db["unitframe"]["units"]["raid3"]["health"]["orientation"] = "HORIZONTAL"
	E.db["unitframe"]["units"]["tank"]["health"]["orientation"] = "HORIZONTAL"
	E.db["unitframe"]["units"]["assist"]["health"]["orientation"] = "HORIZONTAL"
	E.db["unitframe"]["units"]["target"]["health"]["orientation"] = "HORIZONTAL"
	E.db["unitframe"]["units"]["pet"]["health"]["orientation"] = "HORIZONTAL"
	E.db["unitframe"]["units"]["focustarget"]["health"]["orientation"] = "HORIZONTAL"
	E.db["unitframe"]["units"]["arena"]["health"]["orientation"] = "HORIZONTAL"
	E.db["unitframe"]["units"]["boss"]["health"]["orientation"] = "HORIZONTAL"

	--new fonts
	E.private["general"]["nameplateFont"] = "Kimberley"
	E.private["general"]["nameplateFontOutline"] = "OUTLINE"
	E.private["general"]["nameplateLargeFont"] = "Kimberley"
	E.private["general"]["nameplateLargeFontOutline"] = "OUTLINE"
	E.private["general"]["nameplateLargeFontSize"] = 11
	E.db["general"]["fonts"]["worldsubzone"]["enable"] = true
	E.db["general"]["fonts"]["worldsubzone"]["font"] = "Kimberley"
	E.db["general"]["fonts"]["worldsubzone"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["worldsubzone"]["size"] = 28
	E.db["general"]["fonts"]["worldzone"]["enable"] = true
	E.db["general"]["fonts"]["worldzone"]["font"] = "Kimberley"
	E.db["general"]["fonts"]["worldzone"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["worldzone"]["size"] = 42
	E.db["general"]["fonts"]["pvpsubzone"]["enable"] = true
	E.db["general"]["fonts"]["pvpsubzone"]["font"] = "Kimberley"
	E.db["general"]["fonts"]["pvpsubzone"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["pvpsubzone"]["size"] = 20
	E.db["general"]["fonts"]["pvpzone"]["enable"] = true
	E.db["general"]["fonts"]["pvpzone"]["font"] = "Kimberley"
	E.db["general"]["fonts"]["pvpzone"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["pvpzone"]["size"] = 22
	E.db["general"]["fonts"]["objective"]["enable"] = false
	E.db["general"]["fonts"]["objective"]["font"] = "Kimberley"
	E.db["general"]["fonts"]["objective"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["objective"]["size"] = 12
	E.db["general"]["fonts"]["questtitle"]["enable"] = true
	E.db["general"]["fonts"]["questtitle"]["font"] = "Kimberley"
	E.db["general"]["fonts"]["questtitle"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["questtitle"]["size"] = 18
	E.db["general"]["fonts"]["questtext"]["enable"] = true
	E.db["general"]["fonts"]["questtext"]["font"] = "Kimberley"
	E.db["general"]["fonts"]["questtext"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["questtext"]["size"] = 14
	E.db["general"]["fonts"]["questsmall"]["enable"] = true
	E.db["general"]["fonts"]["questsmall"]["font"] = "Kimberley"
	E.db["general"]["fonts"]["questsmall"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["questsmall"]["size"] = 13
	E.db["general"]["fonts"]["cooldown"]["enable"] = true
	E.db["general"]["fonts"]["cooldown"]["font"] = "Kimberley"
	E.db["general"]["fonts"]["cooldown"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["cooldown"]["size"] = 20
	E.db["general"]["fonts"]["errortext"]["enable"] = true
	E.db["general"]["fonts"]["errortext"]["font"] = "Kimberley"
	E.db["general"]["fonts"]["errortext"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["errortext"]["size"] = 14
	E.db["general"]["fonts"]["mailbody"]["enable"] = true
	E.db["general"]["fonts"]["mailbody"]["font"] = "Kimberley"
	E.db["general"]["fonts"]["mailbody"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["mailbody"]["size"] = 14
	E.db["general"]["fonts"]["talkingtext"]["enable"] = true
	E.db["general"]["fonts"]["talkingtext"]["font"] = "Kimberley"
	E.db["general"]["fonts"]["talkingtext"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["talkingtext"]["size"] = 18
	E.db["general"]["fonts"]["talkingtitle"]["enable"] = true
	E.db["general"]["fonts"]["talkingtitle"]["font"] = "Kimberley"
	E.db["general"]["fonts"]["talkingtitle"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["talkingtitle"]["size"] = 20
	E.db["general"]["itemLevel"]["totalLevelFont"] = "Kimberley"
	E.db["general"]["itemLevel"]["totalLevelFontOutline"] = "OUTLINE"
	E.db["general"]["itemLevel"]["totalLevelFontSize"] = E.Retail and 22 or 12
	E.db["general"]["itemLevel"]["enchantAbbrev"] = true
	E.db["general"]["itemLevel"]["showItemLevel"] = true
	E.db["general"]["itemLevel"]["showEnchants"] = true
	E.db["general"]["itemLevel"]["showGems"] = true

	-- unitframe colors
	E.db["unitframe"]["colors"]["auraBarBuff"]["b"] = valuecolors.b
	E.db["unitframe"]["colors"]["auraBarBuff"]["g"] = valuecolors.g
	E.db["unitframe"]["colors"]["auraBarBuff"]["r"] = valuecolors.r
	E.db["unitframe"]["colors"]["aurabar_backdrop"]["b"] = 0
	E.db["unitframe"]["colors"]["aurabar_backdrop"]["g"] = 0
	E.db["unitframe"]["colors"]["aurabar_backdrop"]["r"] = 0
	E.db["unitframe"]["colors"]["castClassColor"] = true
	E.db["unitframe"]["colors"]["castColor"]["b"] = valuecolors.b
	E.db["unitframe"]["colors"]["castColor"]["g"] = valuecolors.g
	E.db["unitframe"]["colors"]["castColor"]["r"] = valuecolors.r
	E.db["unitframe"]["colors"]["castbar_backdrop"]["b"] = 0
	E.db["unitframe"]["colors"]["castbar_backdrop"]["g"] = 0
	E.db["unitframe"]["colors"]["castbar_backdrop"]["r"] = 0
	E.db["unitframe"]["colors"]["castbar_backdrop"]["a"] = 0.4
	E.db["unitframe"]["colors"]["castReactionColor"] = false
	E.db["unitframe"]["colors"]["classResources"]["PALADIN"]["b"] = 0.050980392156863
	E.db["unitframe"]["colors"]["classResources"]["PALADIN"]["g"] = 1
	E.db["unitframe"]["colors"]["classResources"]["PALADIN"]["r"] = 1
	E.db["unitframe"]["colors"]["classResources"]["WARLOCK"]["r"] = 0.58039215686275
	--E.db["unitframe"]["colors"]["classResources"]["DEATHKNIGHT"][0]["b"] = 1
	--E.db["unitframe"]["colors"]["classResources"]["DEATHKNIGHT"][0]["g"] = 1
	--E.db["unitframe"]["colors"]["classResources"]["DEATHKNIGHT"][0]["r"] = 0
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
	E.db["unitframe"]["colors"]["classbackdrop"] = true
	E.db["unitframe"]["colors"]["healthclass"] = false
	E.db["unitframe"]["colors"]["customhealthbackdrop"] = false
	E.db["unitframe"]["colors"]["health_backdrop"]["b"] = 0
	E.db["unitframe"]["colors"]["health_backdrop"]["g"] = 0
	E.db["unitframe"]["colors"]["health_backdrop"]["r"] = 0
	E.db["unitframe"]["colors"]["classpower_backdrop"]["b"] = 0
	E.db["unitframe"]["colors"]["classpower_backdrop"]["g"] = 0
	E.db["unitframe"]["colors"]["classpower_backdrop"]["r"] = 0
	E.db["unitframe"]["colors"]["colorhealthbyvalue"] = false
	E.db["unitframe"]["colors"]["customaurabarbackdrop"] = true
	E.db["unitframe"]["colors"]["customcastbarbackdrop"] = true
	E.db["unitframe"]["colors"]["customclasspowerbackdrop"] = true
	E.db["unitframe"]["colors"]["custompowerbackdrop"] = true
	E.db["unitframe"]["colors"]["frameGlow"]["mainGlow"]["class"] = true
	E.db["unitframe"]["colors"]["frameGlow"]["mainGlow"]["enable"] = true
	E.db["unitframe"]["colors"]["frameGlow"]["mouseoverGlow"]["class"] = true
	E.db["unitframe"]["colors"]["frameGlow"]["mouseoverGlow"]["color"]["a"] = 1
	E.db["unitframe"]["colors"]["frameGlow"]["mouseoverGlow"]["enable"] = false
	E.db["unitframe"]["colors"]["healPrediction"]["maxOverflow"] = 0.01
	E.db["unitframe"]["colors"]["healPrediction"]["healAbsorbs"]["a"] = 0.35
	E.db["unitframe"]["colors"]["healPrediction"]["others"]["a"] = 0.35
	E.db["unitframe"]["colors"]["healPrediction"]["overabsorbs"]["a"] = 0.35
	E.db["unitframe"]["colors"]["healPrediction"]["overhealabsorbs"]["a"] = 0.35
	E.db["unitframe"]["colors"]["healPrediction"]["personal"]["a"] = 0.35
	E.db["unitframe"]["colors"]["health"]["b"] = 0
	E.db["unitframe"]["colors"]["health"]["g"] = 0
	E.db["unitframe"]["colors"]["health"]["r"] = 0
	E.db["unitframe"]["colors"]["healthMultiplier"] = 0.75
	E.db["unitframe"]["colors"]["health_backdrop_dead"]["b"] = 0
	E.db["unitframe"]["colors"]["health_backdrop_dead"]["g"] = 0
	E.db["unitframe"]["colors"]["health_backdrop_dead"]["r"] = 0
	E.db["unitframe"]["colors"]["power"]["ALT_POWER"]["b"] = 0.8
	E.db["unitframe"]["colors"]["power"]["ALT_POWER"]["g"] = 0.40
	E.db["unitframe"]["colors"]["power"]["ALT_POWER"]["r"] = 0.2
	E.db["unitframe"]["colors"]["power"]["ENERGY"]["b"] = 0.54
	E.db["unitframe"]["colors"]["power"]["ENERGY"]["g"] = 0.97
	E.db["unitframe"]["colors"]["power"]["ENERGY"]["r"] = 1
	E.db["unitframe"]["colors"]["power"]["FOCUS"]["b"] = 0.25
	E.db["unitframe"]["colors"]["power"]["FOCUS"]["g"] = 0.50
	E.db["unitframe"]["colors"]["power"]["FOCUS"]["r"] = 1
	E.db["unitframe"]["colors"]["power"]["FURY"]["b"] = 1
	E.db["unitframe"]["colors"]["power"]["FURY"]["g"] = 0.26
	E.db["unitframe"]["colors"]["power"]["FURY"]["r"] = 0.79
	E.db["unitframe"]["colors"]["power"]["INSANITY"]["b"] = 1
	E.db["unitframe"]["colors"]["power"]["INSANITY"]["g"] = 0.25
	E.db["unitframe"]["colors"]["power"]["INSANITY"]["r"] = 0.50
	E.db["unitframe"]["colors"]["power"]["LUNAR_POWER"]["b"] = 0.90
	E.db["unitframe"]["colors"]["power"]["LUNAR_POWER"]["g"] = 0.52
	E.db["unitframe"]["colors"]["power"]["LUNAR_POWER"]["r"] = 0.30
	E.db["unitframe"]["colors"]["power"]["MAELSTROM"]["r"] = 0
	E.db["unitframe"]["colors"]["power"]["MAELSTROM"]["g"] = 0.5
	E.db["unitframe"]["colors"]["power"]["MAELSTROM"]["b"] = 1
	E.db["unitframe"]["colors"]["power"]["MANA"]["b"] = 1
	E.db["unitframe"]["colors"]["power"]["MANA"]["g"] = 0.71
	E.db["unitframe"]["colors"]["power"]["MANA"]["r"] = 0.49
	E.db["unitframe"]["colors"]["power"]["PAIN"]["r"] = 1
	E.db["unitframe"]["colors"]["power"]["PAIN"]["g"] = 0.61
	E.db["unitframe"]["colors"]["power"]["PAIN"]["b"] = 0
	E.db["unitframe"]["colors"]["power"]["RAGE"]["b"] = 0.32
	E.db["unitframe"]["colors"]["power"]["RAGE"]["g"] = 0.32
	E.db["unitframe"]["colors"]["power"]["RAGE"]["r"] = 1
	E.db["unitframe"]["colors"]["power"]["RUNIC_POWER"]["r"] = 0
	E.db["unitframe"]["colors"]["power"]["RUNIC_POWER"]["g"] = 0.82
	E.db["unitframe"]["colors"]["power"]["RUNIC_POWER"]["b"] = 1
	E.db["unitframe"]["colors"]["power_backdrop"]["b"] = 0
	E.db["unitframe"]["colors"]["power_backdrop"]["g"] = 0
	E.db["unitframe"]["colors"]["power_backdrop"]["r"] = 0

	--movers
	E.db["movers"]["MoverEltruismInstanceDifficulty"] = "TOPRIGHT,UIParent,TOPRIGHT,-146,-21"
	E.db["movers"]["MoverRaidWarningFrame"] = "TOP,UIParent,TOP,0,-182"
	E.db["movers"]["TorghastChoiceToggle"] = "BOTTOM,ElvUIParent,BOTTOM,0,398"
	E.db["movers"]["AddonCompartmentMover"] = "TOPRIGHT,UIParent,TOPRIGHT,-8,-5"

	--its actually alt power on some fights like vigilant guardian
	E.db["unitframe"]["units"]["party"]["classbar"]["enable"] = false
	E.db["unitframe"]["units"]["raid1"]["classbar"]["enable"] = false
	E.db["unitframe"]["units"]["raid2"]["classbar"]["enable"] = false
	E.db["unitframe"]["units"]["raid3"]["classbar"]["enable"] = false

	--reverse target castbar
	E.db["unitframe"]["units"]["target"]["castbar"]["reverse"] = true

	-- dont detach on normal profile
	E.db["unitframe"]["units"]["player"]["power"]["detachFromFrame"] = false
	E.db["unitframe"]["units"]["player"]["classbar"]["detachFromFrame"] = false
	E.db["unitframe"]["units"]["targettarget"]["power"]["detachFromFrame"] = false
	E.db["unitframe"]["units"]["target"]["power"]["detachFromFrame"] = false

	--dk things
	E.db["unitframe"]["colors"]["chargingRunes"] = true
	E.db["unitframe"]["colors"]["runeBySpec"] = true
	E.db["nameplates"]["colors"]["chargingRunes"] = true
	E.db["nameplates"]["colors"]["runeBySpec"] = true

	-- General
	E.db["general"]["altPowerBar"]["font"] = "Kimberley"
	E.db["general"]["altPowerBar"]["fontOutline"] = "THICKOUTLINE"
	E.db["general"]["altPowerBar"]["statusBarColorGradient"] = true
	E.db["general"]["autoRepair"] = "GUILD"
	E.db["general"]["autoTrackReputation"] = true
	E.db["general"]["backdropcolor"]["b"] = 0.098039215686275
	E.db["general"]["backdropcolor"]["g"] = 0.098039215686275
	E.db["general"]["backdropcolor"]["r"] = 0.098039215686275
	E.db["general"]["bordercolor"]["b"] = 0
	E.db["general"]["bordercolor"]["g"] = 0
	E.db["general"]["bordercolor"]["r"] = 0
	E.db["general"]["backdropfadecolor"]["a"] = 0.70000001788139
	E.db["general"]["backdropfadecolor"]["b"] = 0
	E.db["general"]["backdropfadecolor"]["g"] = 0
	E.db["general"]["backdropfadecolor"]["r"] = 0
	E.db["general"]["bonusObjectivePosition"] = "RIGHT"
	E.db["general"]["bottomPanel"] = false
	E.db["general"]["cropIcon"] = 2
	E.db["general"]["font"] = "Kimberley"
	E.db["general"]["fontStyle"] = "OUTLINE"
	E.db["general"]["interruptAnnounce"] = "RAID"
	E.db["general"]["itemLevel"]["itemLevelFont"] = "Kimberley"
	E.db["general"]["loginmessage"] = false
	E.db["general"]["lootRoll"]["leftButtons"] = true
	E.db["general"]["lootRoll"]["nameFont"] = "Kimberley"
	E.db["general"]["lootRoll"]["statusBarTexture"] = "ElvUI Norm1"
	E.db["general"]["minimap"]["icons"]["calendar"]["position"] = "TOPLEFT"
	E.db["general"]["minimap"]["icons"]["calendar"]["xOffset"] = 3
	E.db["general"]["minimap"]["icons"]["calendar"]["yOffset"] = -38
	E.db["general"]["minimap"]["icons"]["classHall"]["position"] = "BOTTOM"
	E.db["general"]["minimap"]["icons"]["classHall"]["scale"] = 1
	E.db["general"]["minimap"]["icons"]["difficulty"]["position"] = "BOTTOM"
	E.db["general"]["minimap"]["icons"]["difficulty"]["scale"] = 1.2
	E.db["general"]["minimap"]["icons"]["mail"]["position"] = "BOTTOM"
	E.db["general"]["minimap"]["icons"]["mail"]["scale"] = 1.2
	E.db["general"]["minimap"]["icons"]["mail"]["texture"] = "Mail1"
	E.db["general"]["minimap"]["icons"]["mail"]["xOffset"] = 0
	E.db["general"]["itemLevel"]["itemLevelRarity"] = false

	E.db["general"]["minimap"]["icons"]["mail"]["yOffset"] = 0
	if E.db["datatexts"]["panels"]["EltruismDataText"] and E.db["datatexts"]["panels"]["EltruismDataText"]["enable"] then
		E.db["movers"]["DTPanelEltruismDataTextMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,0"
		if not E.Retail then
			E.db["general"]["minimap"]["icons"]["mail"]["yOffset"] = -10
		end
	else
		if not E.Retail then
			E.db["general"]["minimap"]["icons"]["mail"]["yOffset"] = -27
		end
	end

	E.db["general"]["minimap"]["locationFont"] = "Kimberley"
	E.db["general"]["minimap"]["locationFontOutline"] = "THICKOUTLINE"
	E.db["general"]["minimap"]["locationFontSize"] = 14
	E.db["general"]["minimap"]["locationText"] = "SHOW"
	E.db["general"]["minimap"]["resetZoom"]["enable"] = true
	E.db["general"]["minimap"]["resetZoom"]["time"] = 10
	E.db["general"]["minimap"]["size"] = 200
	E.db["general"]["queueStatus"]["font"] = "Kimberley"
	E.db["general"]["queueStatus"]["fontOutline"] = "OUTLINE"
	E.db["general"]["queueStatus"]["fontSize"] = 18
	E.db["general"]["queueStatus"]["position"] = "LEFT"
	E.db["general"]["queueStatus"]["xOffset"] = -30
	E.db["general"]["queueStatus"]["yOffset"] = 0
	E.db["general"]["minimap"]["timeFont"] = "Kimberley"
	E.db["general"]["addonCompartment"]["fontOutline"] = "OUTLINE"
	E.db["general"]["addonCompartment"]["font"] = "Kimberley"
	E.db["general"]["guildBank"]["countFont"] = "Kimberley"
	E.db["general"]["guildBank"]["countFontOutline"] = "OUTLINE"
	E.db["general"]["guildBank"]["countFontSize"] = 12
	E.db["general"]["guildBank"]["itemLevelFont"] = "Kimberley"
	E.db["general"]["guildBank"]["itemLevelFontOutline"] = "OUTLINE"
	E.db["general"]["guildBank"]["itemLevelFontSize"] = 12
	E.db["general"]["objectiveFrameAutoHideInKeystone"] = false
	E.db["general"]["objectiveFrameAutoHide"] = false
	E.db["general"]["objectiveFrameHeight"] = 550
	E.db["general"]["resurrectSound"] = true
	E.db["general"]["talkingHeadFrameScale"] = 0.5
	E.db["general"]["totems"]["growthDirection"] = "HORIZONTAL"
	E.db["general"]["totems"]["size"] = 30
	E.db["general"]["totems"]["sortDirection"] = "DESCENDING"
	E.db["general"]["totems"]["spacing"] = 3
	E.db["general"]["valuecolor"]["b"] = valuecolors.b
	E.db["general"]["valuecolor"]["g"] = valuecolors.g
	E.db["general"]["valuecolor"]["r"] = valuecolors.r
	E.db["general"]["vehicleSeatIndicatorSize"] = 76
	E.db["general"]["taintLog"] = false

	E.db["unitframe"]["units"]["player"]["forcehealthreaction"] = false

	-- Bags
	E.db["bags"]["bagSize"] = 35
	E.db["bags"]["bagWidth"] = 412
	E.db["bags"]["bankSize"] = 35
	E.db["bags"]["bankWidth"] = 412
	E.db["bags"]["clearSearchOnClose"] = true
	E.db["bags"]["countFont"] = "Kimberley"
	E.db["bags"]["countFontOutline"] = "OUTLINE"
	E.db["bags"]["countFontSize"] = 12
	E.db["bags"]["itemInfoFont"] = "Kimberley"
	E.db["bags"]["itemInfoFontOutline"] = "OUTLINE"
	E.db["bags"]["itemLevelFontSize"] = 12
	E.db["bags"]["itemLevelFont"] = "Kimberley"
	E.db["bags"]["itemLevelFontOutline"] = "OUTLINE"
	E.db["bags"]["junkDesaturate"] = true
	E.db["bags"]["junkIcon"] = true
	E.db["bags"]["scrapIcon"] = true --not in classic
	E.db["bags"]["showBindType"] = true
	E.db["bags"]["split"]["bagSpacing"] = 7
	E.db["bags"]["transparent"] = true
	E.db["bags"]["vendorGrays"]["enable"] = true
	if E.Retail then
		E.db["bags"]["split"]["bag5"] = true
		E.db["bags"]["split"]["player"] = true
	end
	E.db["bags"]["moneyFormat"] = "SMART"

	-- Chat
	E.db["chat"]["chatHistory"] = false
	--E.db["chat"]["hideCopyButton"] = true
	E.db["chat"]["hideVoiceButtons"] = true
	E.db["chat"]["fadeTabsNoBackdrop"] = true
	E.db["chat"]["fadeUndockedTabs"] = true
	E.db["chat"]["noAlertInCombat"] = true
	E.db["chat"]["panelBackdrop"] = "HIDEBOTH"
	E.db["chat"]["font"] = "Kimberley"
	E.db["chat"]["fontOutline"] = "OUTLINE"
	E.db["chat"]["fontSize"] = 12
	E.db["chat"]["inactivityTimer"] = 20
	E.db["chat"]["panelColor"]["a"] = 0.70000001788139
	E.db["chat"]["panelColor"]["b"] = 0
	E.db["chat"]["panelColor"]["g"] = 0
	E.db["chat"]["panelColor"]["r"] = 0
	E.db["chat"]["panelTabTransparency"] = false
	E.db["chat"]["panelHeight"] = 180
	E.db["chat"]["panelWidthRight"] = 400
	E.db["chat"]["tabFont"] = "Kimberley"
	E.db["chat"]["tabFontSize"] = 14
	E.db["chat"]["tabFontOutline"] = "OUTLINE"
	E.db["chat"]["tabSelectorColor"]["b"] = valuecolors.b
	E.db["chat"]["tabSelectorColor"]["g"] = valuecolors.g
	E.db["chat"]["tabSelectorColor"]["r"] = valuecolors.r
	E.db["chat"]["throttleInterval"] = 20
	E.db["chat"]["LeftChatDataPanelAnchor"] = "BELOW_CHAT"
	E.db["chat"]["RightChatDataPanelAnchor"] = "BELOW_CHAT"

	-- Cooldown Text
	E.db["cooldown"]["daysColor"]["g"] = 1
	E.db["cooldown"]["daysColor"]["r"] = 1
	E.db["cooldown"]["expireIndicator"]["b"] = 0.2
	E.db["cooldown"]["expireIndicator"]["g"] = 0.2
	E.db["cooldown"]["expireIndicator"]["r"] = 1
	E.db["cooldown"]["fonts"]["enable"] = true
	E.db["cooldown"]["fonts"]["font"] = "Kimberley"
	E.db["cooldown"]["fonts"]["fontOutline"] = "THICKOUTLINE"
	E.db["cooldown"]["hhmmColor"]["b"] = 1
	E.db["cooldown"]["hhmmColor"]["g"] = 1
	E.db["cooldown"]["hhmmColor"]["r"] = 1
	E.db["cooldown"]["hoursColor"]["r"] = 1
	E.db["cooldown"]["mmssColor"]["b"] = 1
	E.db["cooldown"]["mmssColor"]["g"] = 1
	E.db["cooldown"]["mmssColor"]["r"] = 1
	E.db["cooldown"]["secondsColor"]["b"] = 1
	E.db["cooldown"]["threshold"] = 5
	E.db["cooldown"]["useIndicatorColor"] = true
	E.db["cooldown"]["targetAura"] = true
	if E.myclass == "PRIEST" then
		E.db["cooldown"]["daysIndicator"]["b"] = 0.7
		E.db["cooldown"]["daysIndicator"]["g"] = 0.7
		E.db["cooldown"]["daysIndicator"]["r"] = 0.7
		E.db["cooldown"]["hhmmColorIndicator"]["b"] = 0.7
		E.db["cooldown"]["hhmmColorIndicator"]["g"] = 0.7
		E.db["cooldown"]["hhmmColorIndicator"]["r"] = 0.7
		E.db["cooldown"]["hoursIndicator"]["b"] = 0.7
		E.db["cooldown"]["hoursIndicator"]["g"] = 0.7
		E.db["cooldown"]["hoursIndicator"]["r"] = 0.7
		E.db["cooldown"]["minutesIndicator"]["b"] = 0.7
		E.db["cooldown"]["minutesIndicator"]["g"] = 0.7
		E.db["cooldown"]["minutesIndicator"]["r"] = 0.7
		E.db["cooldown"]["mmssColorIndicator"]["b"] = 0.7
		E.db["cooldown"]["mmssColorIndicator"]["g"] = 0.7
		E.db["cooldown"]["mmssColorIndicator"]["r"] = 0.7
		E.db["cooldown"]["secondsIndicator"]["b"] = 0.7
		E.db["cooldown"]["secondsIndicator"]["g"] = 0.7
		E.db["cooldown"]["secondsIndicator"]["r"] = 0.7
		E.db["actionbar"]["cooldown"]["targetAuraIndicator"]["b"] = 0.7
		E.db["actionbar"]["cooldown"]["targetAuraIndicator"]["g"] = 0.7
		E.db["actionbar"]["cooldown"]["targetAuraIndicator"]["r"] = 0.7
	else
		E.db["cooldown"]["daysIndicator"]["b"] = valuecolors.b
		E.db["cooldown"]["daysIndicator"]["g"] = valuecolors.g
		E.db["cooldown"]["daysIndicator"]["r"] = valuecolors.r
		E.db["cooldown"]["hhmmColorIndicator"]["b"] = valuecolors.b
		E.db["cooldown"]["hhmmColorIndicator"]["g"] = valuecolors.g
		E.db["cooldown"]["hhmmColorIndicator"]["r"] = valuecolors.r
		E.db["cooldown"]["hoursIndicator"]["b"] = valuecolors.b
		E.db["cooldown"]["hoursIndicator"]["g"] = valuecolors.g
		E.db["cooldown"]["hoursIndicator"]["r"] = valuecolors.r
		E.db["cooldown"]["minutesIndicator"]["b"] = valuecolors.b
		E.db["cooldown"]["minutesIndicator"]["g"] = valuecolors.g
		E.db["cooldown"]["minutesIndicator"]["r"] = valuecolors.r
		E.db["cooldown"]["mmssColorIndicator"]["b"] = valuecolors.b
		E.db["cooldown"]["mmssColorIndicator"]["g"] = valuecolors.g
		E.db["cooldown"]["mmssColorIndicator"]["r"] = valuecolors.r
		E.db["cooldown"]["secondsIndicator"]["b"] = valuecolors.b
		E.db["cooldown"]["secondsIndicator"]["g"] = valuecolors.g
		E.db["cooldown"]["secondsIndicator"]["r"] = valuecolors.r
		E.db["actionbar"]["cooldown"]["targetAuraIndicator"]["b"] = valuecolors.b
		E.db["actionbar"]["cooldown"]["targetAuraIndicator"]["g"] = valuecolors.g
		E.db["actionbar"]["cooldown"]["targetAuraIndicator"]["r"] = valuecolors.r
	end
	E.db["actionbar"]["cooldown"]["mmssThreshold"] = 60
	E.db["actionbar"]["cooldown"]["useIndicatorColor"] = true
	E.db["actionbar"]["cooldown"]["expiringAuraColor"]["r"] = 1
	E.db["actionbar"]["cooldown"]["expiringAuraColor"]["b"] = 0.2
	E.db["actionbar"]["cooldown"]["expiringAuraColor"]["g"] = 0.2
	E.db["actionbar"]["cooldown"]["daysColor"]["r"] = 1
	E.db["actionbar"]["cooldown"]["daysColor"]["g"] = 1
	E.db["actionbar"]["cooldown"]["daysColor"]["b"] = 1
	E.db["actionbar"]["cooldown"]["expiringAuraIndicator"]["b"] = 0.2
	E.db["actionbar"]["cooldown"]["expiringAuraIndicator"]["g"] = 0.2
	E.db["actionbar"]["cooldown"]["expiringAuraIndicator"]["r"] = 1
	E.db["actionbar"]["cooldown"]["minutesIndicator"]["b"] = 1
	E.db["actionbar"]["cooldown"]["minutesIndicator"]["g"] = 1
	E.db["actionbar"]["cooldown"]["minutesIndicator"]["r"] = 1
	E.db["actionbar"]["cooldown"]["override"] = false
	E.db["actionbar"]["cooldown"]["secondsIndicator"]["b"] = 1
	E.db["actionbar"]["cooldown"]["secondsIndicator"]["g"] = 1
	E.db["actionbar"]["cooldown"]["secondsIndicator"]["r"] = 1
	E.db["actionbar"]["cooldown"]["targetAuraColor"]["b"] = 0.45490196078431
	E.db["actionbar"]["cooldown"]["targetAuraColor"]["g"] = 1
	E.db["actionbar"]["cooldown"]["targetAuraColor"]["r"] = 0.18823529411765
	E.db["actionbar"]["cooldown"]["targetAuraIndicator"]["b"] = valuecolors.b
	E.db["actionbar"]["cooldown"]["targetAuraIndicator"]["g"] = valuecolors.g
	E.db["actionbar"]["cooldown"]["targetAuraIndicator"]["r"] = valuecolors.r
	E.db["actionbar"]["cooldown"]["threshold"] = 5
	E.db["actionbar"]["cooldown"]["fonts"]["enable"] = false

	E.db["actionbar"]["targetReticleColor"]["b"] = valuecolors.b
	E.db["actionbar"]["targetReticleColor"]["g"] = valuecolors.g
	E.db["actionbar"]["targetReticleColor"]["r"] = valuecolors.r

	E.db["actionbar"]["bar1"]["buttonsPerRow"] = 7
	E.db["actionbar"]["bar2"]["buttonsPerRow"] = 12
	E.db["actionbar"]["bar3"]["buttonsPerRow"] = 12
	E.db["actionbar"]["bar4"]["buttonsPerRow"] = 12
	E.db["actionbar"]["bar5"]["buttonsPerRow"] = 12
	E.db["actionbar"]["bar6"]["buttonsPerRow"] = 12

	--make sure bar4 is enabled
	E.db["actionbar"]["bar4"]["enabled"] = true

	E.db["actionbar"]["bar1"]["showGrid"] = true
	E.db["actionbar"]["bar2"]["showGrid"] = true
	E.db["actionbar"]["bar3"]["showGrid"] = true
	E.db["actionbar"]["bar4"]["showGrid"] = true

	-- DataBars
	E.db["databars"]["threat"]["font"] = "Kimberley"
	E.db["databars"]["threat"]["fontOutline"] = "OUTLINE"
	E.db["databars"]["threat"]["fontSize"] = 12
	E.db["databars"]["threat"]["height"] = 22
	E.db["databars"]["threat"]["orientation"] = "HORIZONTAL"
	E.db["databars"]["threat"]["width"] = 450
	E.db["databars"]["threat"]["frameLevel"] = 3
	E.db["databars"]["threat"]["frameStrata"] = "MEDIUM"
	if E.Cata or E.Classic then
		E.db["databars"]["threat"]["enable"] = true
	elseif E.Retail then
		E.db["databars"]["threat"]["enable"] = false
	end
	E.db["databars"]["azerite"]["font"] = "Kimberley"
	E.db["databars"]["azerite"]["fontOutline"] = "THICKOUTLINE"
	E.db["databars"]["azerite"]["fontSize"] = 12
	E.db["databars"]["azerite"]["height"] = 203
	E.db["databars"]["azerite"]["hideInCombat"] = true
	E.db["databars"]["azerite"]["mouseover"] = true
	E.db["databars"]["azerite"]["width"] = 10
	E.db["databars"]["azerite"]["enable"] = false
	--E.db["databars"]["colors"]["experience"]["a"] = 0.5
	E.db["databars"]["colors"]["experience"]["a"] = 1 --better with gradient xp
	E.db["databars"]["colors"]["honor"]["a"] = 0.5
	E.db["databars"]["colors"]["rested"]["a"] = 0.20000004768372
	--custom faction colors for reputation
	E.db["databars"]["colors"]["factionColors"][1]["b"] = 0.07843137254902
	E.db["databars"]["colors"]["factionColors"][1]["g"] = 0.07843137254902
	E.db["databars"]["colors"]["factionColors"][1]["r"] = 1
	E.db["databars"]["colors"]["factionColors"][2]["b"] = 0.21960784313725
	E.db["databars"]["colors"]["factionColors"][2]["g"] = 0.30196078431373
	E.db["databars"]["colors"]["factionColors"][3]["g"] = 0.27058823529412
	E.db["databars"]["colors"]["factionColors"][3]["r"] = 0.74901960784314
	E.db["databars"]["colors"]["factionColors"][4]["g"] = 0.70196078431373
	E.db["databars"]["colors"]["factionColors"][4]["r"] = 0.90196078431373
	E.db["databars"]["colors"]["factionColors"][5]["b"] = 0.10196078431373
	E.db["databars"]["colors"]["factionColors"][6]["b"] = 0.55686274509804
	E.db["databars"]["colors"]["factionColors"][6]["g"] = 1
	E.db["databars"]["colors"]["factionColors"][7]["b"] = 1
	E.db["databars"]["colors"]["factionColors"][7]["g"] = 0.66666666666667
	E.db["databars"]["colors"]["factionColors"][8]["b"] = 1
	E.db["databars"]["colors"]["factionColors"][8]["g"] = 0.32156862745098
	E.db["databars"]["colors"]["factionColors"][9]["b"] = 1
	E.db["databars"]["colors"]["factionColors"][9]["g"] = 0
	E.db["databars"]["colors"]["factionColors"][9]["r"] = 0.44313725490196
	E.db["databars"]["colors"]["useCustomFactionColors"] = true


	E.db["databars"]["customTexture"] = true

	--new experience
	E.db["databars"]["experience"]["enable"] = true
	E.db["databars"]["experience"]["font"] = "Kimberley"
	E.db["databars"]["experience"]["fontOutline"] = "OUTLINE"
	E.db["databars"]["experience"]["fontSize"] = 10
	E.db["databars"]["experience"]["height"] = 12
	E.db["databars"]["experience"]["mouseover"] = true
	E.db["databars"]["experience"]["questCompletedOnly"] = true
	if E.Retail then
		E.db["databars"]["experience"]["questCurrentZoneOnly"] = true
	else
		E.db["databars"]["experience"]["questCurrentZoneOnly"] = false
	end
	E.db["databars"]["experience"]["questTrackedOnly"] = true
	E.db["databars"]["experience"]["showBubbles"] = true
	E.db["databars"]["experience"]["showLevel"] = true
	E.db["databars"]["experience"]["textFormat"] = "PERCENT"
	E.db["databars"]["experience"]["width"] = 500
	E.db["databars"]["petExperience"]["enable"] = false
	E.db["databars"]["reputation"]["enable"] = true
	E.db["databars"]["reputation"]["font"] = "Kimberley"
	E.db["databars"]["reputation"]["fontOutline"] = "OUTLINE"
	E.db["databars"]["reputation"]["fontSize"] = 10
	E.db["databars"]["reputation"]["height"] = 12
	E.db["databars"]["reputation"]["mouseover"] = true
	E.db["databars"]["reputation"]["showBubbles"] = true
	E.db["databars"]["reputation"]["textFormat"] = "REM"
	E.db["databars"]["reputation"]["width"] = 500
	E.db["databars"]["honor"]["enable"] = false
	E.db["databars"]["honor"]["font"] = "Kimberley"
	E.db["databars"]["honor"]["height"] = 203
	E.db["databars"]["honor"]["hideBelowMaxLevel"] = true
	E.db["databars"]["honor"]["hideInCombat"] = true
	E.db["databars"]["honor"]["hideOutsidePvP"] = true
	E.db["databars"]["honor"]["mouseover"] = true
	E.db["databars"]["honor"]["orientation"] = "VERTICAL"
	E.db["databars"]["honor"]["width"] = 10

	-- DataTexts
	E.db["datatexts"]["font"] = "Kimberley"
	if width == 3840 then
		E.db["datatexts"]["fontOutline"] = "THICKOUTLINE"
		E.db["actionbar"]["fontOutline"] = "THICKOUTLINE"
	else
		E.db["datatexts"]["fontOutline"] = "OUTLINE"
		E.db["actionbar"]["fontOutline"] = "OUTLINE"
	end
	E.db["datatexts"]["noCombatClick"] = true
	E.db["datatexts"]["noCombatHover"] = true
	E.db["datatexts"]["panels"]["MinimapPanel"][1] = "Time"
	E.db["datatexts"]["panels"]["MinimapPanel"]["border"] = false
	if E.Retail then
		E.db["datatexts"]["panels"]["LeftChatDataPanel"][3] = "Missions"
		E.db["datatexts"]["panels"]["LeftChatDataPanel"]["border"] = false
		E.db["datatexts"]["panels"]["LeftChatDataPanel"]["panelTransparency"] = true
		E.db["datatexts"]["panels"]["LeftChatDataPanel"]["backdrop"] = false
		E.db["datatexts"]["panels"]["LeftChatDataPanel"]["right"] = "System"
		E.db["datatexts"]["panels"]["RightChatDataPanel"][2] = "Combat"
		E.db["datatexts"]["panels"]["RightChatDataPanel"]["border"] = false
		E.db["datatexts"]["panels"]["RightChatDataPanel"]["left"] = "Orderhall"
		E.db["datatexts"]["panels"]["RightChatDataPanel"]["middle"] = "BfA Missions"
		E.db["datatexts"]["panels"]["RightChatDataPanel"]["panelTransparency"] = true
		E.db["datatexts"]["panels"]["RightChatDataPanel"]["backdrop"] = false
		if IsAddOnLoaded("ElvUI_SLE") then
			E.db["datatexts"]["panels"]["MinimapPanel"][2] = "S&L Friends"
		else
			E.db["datatexts"]["panels"]["MinimapPanel"][2] = "Friends"
		end
	elseif E.Classic or E.Cata then
		if E.Cata then
			E.db["datatexts"]["panels"]["LeftChatDataPanel"][1] = "DualSpecialization"
		else
			E.db["datatexts"]["panels"]["LeftChatDataPanel"][1] = "Eltruism"
		end
		E.db["datatexts"]["panels"]["LeftChatDataPanel"]["left"] = "Eltruism"
		E.db["datatexts"]["panels"]["LeftChatDataPanel"][2] = "Durability"
		E.db["datatexts"]["panels"]["LeftChatDataPanel"]["middle"] = "Durability"
		if E.myclass == 'HUNTER' or E.myclass == 'WARLOCK' then
			E.db["datatexts"]["panels"]["LeftChatDataPanel"][3] = "Ammo"
		else
			E.db["datatexts"]["panels"]["LeftChatDataPanel"][3] = "Friends"
		end
		E.db["datatexts"]["panels"]["LeftChatDataPanel"]["border"] = false
		E.db["datatexts"]["panels"]["LeftChatDataPanel"]["panelTransparency"] = true
		E.db["datatexts"]["panels"]["LeftChatDataPanel"]["backdrop"] = false
		E.db["datatexts"]["panels"]["LeftChatDataPanel"]["right"] = "Guild"
		E.db["datatexts"]["panels"]["MinimapPanel"][2] = "Coords"
		E.db["datatexts"]["panels"]["RightChatDataPanel"][2] = "Combat"
		E.db["datatexts"]["panels"]["RightChatDataPanel"]["border"] = false
		E.db["datatexts"]["panels"]["RightChatDataPanel"]["left"] = "System"
		E.db["datatexts"]["panels"]["RightChatDataPanel"]["middle"] = "Combat Time"
		E.db["datatexts"]["panels"]["RightChatDataPanel"]["panelTransparency"] = true
		E.db["datatexts"]["panels"]["RightChatDataPanel"]["backdrop"] = false
	end

	-- Tooltip
	E.db["tooltip"]["alwaysShowRealm"] = true
	E.db["tooltip"]["colorAlpha"] = 0.7
	E.db["tooltip"]["cursorAnchor"] = true
	E.db["tooltip"]["font"] = "Kimberley"
	E.db["tooltip"]["fontOutline"] = "OUTLINE"
	E.db["tooltip"]["healthBar"]["font"] = "Kimberley"
	E.db["tooltip"]["healthBar"]["fontOutline"] = "OUTLINE"
	E.db["tooltip"]["healthBar"]["height"] = 15
	E.db["tooltip"]["healthBar"]["statusPosition"] = "TOP"
	E.db["tooltip"]["itemCount"] = "NONE"
	E.db["tooltip"]["modifierID"] = "SHIFT"
	E.db["tooltip"]["showElvUIUsers"] = true
	E.db["tooltip"]["visibility"]["combatOverride"] = "CTRL"
	E.db["tooltip"]["headerFont"] = "Kimberley"
	E.db["tooltip"]["headerFontOutline"] = "OUTLINE"
	E.db["tooltip"]["headerFontSize"] = 12
	E.db["tooltip"]["itemQuality"] = true

	-- ActionBars general
	E.db["actionbar"]["bar1"]["inheritGlobalFade"] = true
	E.db["actionbar"]["bar2"]["inheritGlobalFade"] = true
	E.db["actionbar"]["bar3"]["inheritGlobalFade"] = true
	E.db["actionbar"]["bar4"]["inheritGlobalFade"] = true
	E.db["actionbar"]["bar5"]["inheritGlobalFade"] = true
	E.db["actionbar"]["barPet"]["inheritGlobalFade"] = true
	E.db["actionbar"]["bar6"]["inheritGlobalFade"] = false
	E.db["actionbar"]["bar7"]["inheritGlobalFade"] = false
	E.db["actionbar"]["bar8"]["inheritGlobalFade"] = false
	E.db["actionbar"]["bar9"]["inheritGlobalFade"] = false
	E.db["actionbar"]["bar10"]["inheritGlobalFade"] = false
	E.db["actionbar"]["extraActionButton"]["inheritGlobalFade"] = false
	E.db["actionbar"]["zoneActionButton"]["inheritGlobalFade"] = false
	E.db["actionbar"]["stanceBar"]["inheritGlobalFade"] = true
	E.db["actionbar"]["equippedItem"] = false

	E.db["actionbar"]["bar1"]["hotkeytext"] = true
	E.db["actionbar"]["bar2"]["hotkeytext"] = true
	E.db["actionbar"]["bar3"]["hotkeytext"] = true
	E.db["actionbar"]["bar4"]["hotkeytext"] = true
	E.db["actionbar"]["bar5"]["hotkeytext"] = true
	E.db["actionbar"]["bar6"]["hotkeytext"] = true
	E.db["actionbar"]["bar1"]["counttext"] = true
	E.db["actionbar"]["bar2"]["counttext"] = true
	E.db["actionbar"]["bar3"]["counttext"] = true
	E.db["actionbar"]["bar4"]["counttext"] = true
	E.db["actionbar"]["bar5"]["counttext"] = true
	E.db["actionbar"]["bar6"]["counttext"] = true
	E.db["actionbar"]["bar1"]["heightMult"] = 1
	E.db["actionbar"]["bar2"]["heightMult"] = 1
	E.db["actionbar"]["bar3"]["heightMult"] = 1
	E.db["actionbar"]["bar4"]["heightMult"] = 1
	E.db["actionbar"]["bar5"]["heightMult"] = 1
	E.db["actionbar"]["bar6"]["heightMult"] = 1
	E.db["actionbar"]["bar1"]["backdrop"] = false
	E.db["actionbar"]["bar2"]["backdrop"] = false
	E.db["actionbar"]["bar3"]["backdrop"] = false
	E.db["actionbar"]["bar4"]["backdrop"] = false
	E.db["actionbar"]["bar5"]["backdrop"] = false
	E.db["actionbar"]["bar6"]["backdrop"] = false
	E.db["actionbar"]["barPet"]["buttons"] = 10
	E.db["actionbar"]["stanceBar"]["backdrop"] = false
	E.db["actionbar"]["noRangeColor"]["b"] = 0.11764705882353
	E.db["actionbar"]["noRangeColor"]["g"] = 0.11764705882353
	E.db["actionbar"]["noRangeColor"]["r"] = 1

	--unitframes general
	E.db["unitframe"]["units"]["focus"]["width"] = 190
	E.db["unitframe"]["units"]["player"]["width"] = 270
	E.db["unitframe"]["units"]["target"]["width"] = 270
	E.db["unitframe"]["units"]["targettarget"]["width"] = 130
	E.db["unitframe"]["units"]["arena"]["width"] = 250
	E.db["unitframe"]["units"]["assist"]["width"] = 120
	E.db["unitframe"]["units"]["boss"]["width"] = 216
	E.db["unitframe"]["units"]["party"]["width"] = 200
	E.db["unitframe"]["units"]["tank"]["width"] = 120

	-- Custom Text: Party
	E.db["unitframe"]["units"]["party"]["customTexts"] = E.db["unitframe"]["units"]["party"]["customTexts"] or {}
	E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyHealth"] = {
		["attachTextTo"] = "Health",
		["enable"] = true,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "RIGHT",
		["size"] = 16,
		["text_format"] = "[eltruism:raidmarker] [eltruism:hpstatusnopc:gradient]",
		["xOffset"] = 0,
		["yOffset"] = 0
	}
	E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyName"] = {
		["attachTextTo"] = "InfoPanel",
		["enable"] = true,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "LEFT",
		["size"] = 12,
		["text_format"] = "[name:eltruism:gradientshort] [difficultycolor][smartlevel]",
		["xOffset"] = 2,
		["yOffset"] = -2,
	}
	E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyPower"] = {
		["attachTextTo"] = "Power",
		["enable"] = true,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "RIGHT",
		["size"] = 11,
		["text_format"] = "[powercolor][power:current:shortvalue]",
		["xOffset"] = 0,
		["yOffset"] = -1,
	}
	E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyAbsorb"] = {
		["attachTextTo"] = "Health",
		["enable"] = false,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "RIGHT",
		["size"] = 11,
		["text_format"] = "||cffFFFF00[absorbs]||r ",
		["xOffset"] = 6,
		["yOffset"] = 0
	}
	E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumStatus"] = {
		["attachTextTo"] = "Health",
		["enable"] = false,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "CENTER",
		["size"] = 40,
		["text_format"] = "[eltruism:dead][eltruism:dc]",
		["xOffset"] = 0,
		["yOffset"] = 0
	}

	-- Custom Text: Arena
	E.db["unitframe"]["units"]["arena"]["customTexts"] = E.db["unitframe"]["units"]["arena"]["customTexts"] or {}
	if E.Retail or E.Cata then
		E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaHealth"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "Kimberley",
			["fontOutline"] = "OUTLINE",
			["justifyH"] = "LEFT",
			["size"] = 16,
			["text_format"] = "[eltruism:hpstatusnopc:gradient]",
			["xOffset"] = 0,
			["yOffset"] = 0
		}
		E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaName"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "Kimberley",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 12,
			["text_format"] = "[name:eltruism:gradientshort] [difficultycolor][smartlevel]",
			["xOffset"] = 2,
			["yOffset"] = 0
		}
		E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaPower"] = {
			["attachTextTo"] = "Power",
			["enable"] = true,
			["font"] = "Kimberley",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "LEFT",
			["size"] = 11,
			["text_format"] = "[powercolor][power:current:shortvalue]",
			["xOffset"] = 1,
			["yOffset"] = -1
		}
		E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumStatus"] = {
			["attachTextTo"] = "Health",
			["enable"] = false,
			["font"] = "Kimberley",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "CENTER",
			["size"] = 40,
			["text_format"] = "[eltruism:dead][eltruism:dc]",
			["xOffset"] = -50,
			["yOffset"] = 0
		}
	elseif E.Classic then
		E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaHealth"] = {
			["attachTextTo"] = "Health",
			["enable"] = false,
			["font"] = "Kimberley",
			["fontOutline"] = "OUTLINE",
			["justifyH"] = "LEFT",
			["size"] = 16,
			["text_format"] = "[eltruism:hpstatusnopc:gradient]",
			["xOffset"] = 0,
			["yOffset"] = 0
		}
		E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaName"] = {
			["attachTextTo"] = "Health",
			["enable"] = false,
			["font"] = "Kimberley",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 12,
			["text_format"] = "[name:eltruism:gradientshort] [difficultycolor][smartlevel]",
			["xOffset"] = 2,
			["yOffset"] = 0
		}
		E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaPower"] = {
			["attachTextTo"] = "Power",
			["enable"] = false,
			["font"] = "Kimberley",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "LEFT",
			["size"] = 11,
			["text_format"] = "[powercolor][power:current:shortvalue]",
			["xOffset"] = 1,
			["yOffset"] = -1
		}
	end

	-- Custom Text: Pet
	E.db["unitframe"]["units"]["pet"]["customTexts"] = E.db["unitframe"]["units"]["pet"]["customTexts"] or {}
	if E.Classic then
		E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "Kimberley",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "CENTER",
			["size"] = 12,
			["text_format"] = "[name:eltruism:gradient][happiness:discord]",
			["xOffset"] = 0,
			["yOffset"] = 0
		}
	else
		E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "Kimberley",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "CENTER",
			["size"] = 12,
			["text_format"] = "[name:eltruism:gradient]",
			["xOffset"] = 0,
			["yOffset"] = 0
		}
	end
	-- Custom Text: Player
	E.db["unitframe"]["units"]["player"]["customTexts"] = E.db["unitframe"]["units"]["player"]["customTexts"] or {}
	E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPlayerAbsorb"] = {
		["attachTextTo"] = "Health",
		["enable"] = false,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "RIGHT",
		["size"] = 12,
		["text_format"] = "||cffFFFF00[absorbs]||r ",
		["xOffset"] = 0,
		["yOffset"] = 15
	}
	E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumHealth"] = {
		["attachTextTo"] = "Health",
		["enable"] = true,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "RIGHT",
		["size"] = 14,
		["text_format"] = "[eltruism:hpstatus:gradient]",
		["xOffset"] = 0,
		["yOffset"] = 0
	}
	E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumName"] = {
		["attachTextTo"] = "Health",
		["enable"] = true,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "LEFT",
		["size"] = 16,
		["text_format"] = "[name:eltruism:gradient] [eltruism:class:player] [eltruism:raidmarker]",
		["xOffset"] = 2,
		["yOffset"] = 0
	}
	E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPower"] = {
		["attachTextTo"] = "Power",
		["enable"] = true,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "RIGHT",
		["size"] = 10,
		["text_format"] = "[powercolor][power:current:shortvalue]",
		["xOffset"] = 0,
		["yOffset"] = -1
	}
	E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPvP"] = {
		["attachTextTo"] = "Health",
		["enable"] = true,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "CENTER",
		["size"] = 15,
		["text_format"] = "[mouseover]||cFFB04F4F[pvptimer]||r",
		["xOffset"] = 0,
		["yOffset"] = 0
	}
	E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumStatus"] = {
		["attachTextTo"] = "Health",
		["enable"] = false,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "CENTER",
		["size"] = 27,
		["text_format"] = "[eltruism:dead][eltruism:dc]",
		["xOffset"] = 50,
		["yOffset"] = 0
	}
	E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumStance"] = {
		["attachTextTo"] = "Health",
		["enable"] = true,
		["font"] = "Kimberley",
		["fontOutline"] = "OUTLINE",
		["justifyH"] = "LEFT",
		["size"] = 10,
		["text_format"] = "[eltruism:stance]",
		["xOffset"] = 4,
		["yOffset"] = -15,
	}

	-- Custom Text: Raid1
	E.db["unitframe"]["units"]["raid1"]["customTexts"] = E.db["unitframe"]["units"]["raid1"]["customTexts"] or {}
	E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumGroup"] = {
		["attachTextTo"] = "Health",
		["enable"] = false,
		["font"] = "Kimberley",
		["fontOutline"] = "NONE",
		["justifyH"] = "LEFT",
		["size"] = 8,
		["text_format"] = " Group [group]",
		["xOffset"] = 37,
		["yOffset"] = 10
	}
	E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Absorb"] = {
		["attachTextTo"] = "Health",
		["enable"] = false,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "CENTER",
		["size"] = 10,
		["text_format"] = "||cffFFFF00[absorbs]||r",
		["xOffset"] = 45,
		["yOffset"] = 0
	}
	E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Health"]= {
		["attachTextTo"] = "InfoPanel",
		["enable"] = true,
		["font"] = "Kimberley",
		["fontOutline"] = "OUTLINE",
		["justifyH"] = "RIGHT",
		["size"] = 10,
		["text_format"] = "[eltruism:hpstatusnopc:gradient]",
		["xOffset"] = 0,
		["yOffset"] = -1
	}
	E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Name"] = {
		["attachTextTo"] = "InfoPanel",
		["enable"] = true,
		["font"] = "Kimberley",
		["fontOutline"] = "OUTLINE",
		["justifyH"] = "LEFT",
		["size"] = 10,
		["text_format"] = "[name:eltruism:gradientshort]",
		["xOffset"] = 0,
		["yOffset"] = 0
	}
	E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumStatus"] = {
		["attachTextTo"] = "Health",
		["enable"] = false,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "CENTER",
		["size"] = 25,
		["text_format"] = "[eltruism:dead][eltruism:dc]",
		["xOffset"] = 0,
		["yOffset"] = 0
	}

	-- Custom Text: Raid2
	E.db["unitframe"]["units"]["raid2"]["customTexts"] = E.db["unitframe"]["units"]["raid2"]["customTexts"] or {}
	E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumGroup"] = {
		["attachTextTo"] = "Health",
		["enable"] = false,
		["font"] = "Kimberley",
		["fontOutline"] = "NONE",
		["justifyH"] = "LEFT",
		["size"] = 8,
		["text_format"] = " Group [group]",
		["xOffset"] = 37,
		["yOffset"] = 10
	}
	E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Absorb"] = {
		["attachTextTo"] = "Health",
		["enable"] = false,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "CENTER",
		["size"] = 10,
		["text_format"] = "||cffFFFF00[absorbs]||r",
		["xOffset"] = 45,
		["yOffset"] = 0
	}
	E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Health"]= {
		["attachTextTo"] = "InfoPanel",
		["enable"] = true,
		["font"] = "Kimberley",
		["fontOutline"] = "OUTLINE",
		["justifyH"] = "RIGHT",
		["size"] = 10,
		["text_format"] = "[eltruism:hpstatusnopc:gradient]",
		["xOffset"] = 0,
		["yOffset"] = -1
	}
	E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Name"] = {
		["attachTextTo"] = "InfoPanel",
		["enable"] = true,
		["font"] = "Kimberley",
		["fontOutline"] = "OUTLINE",
		["justifyH"] = "LEFT",
		["size"] = 10,
		["text_format"] = "[name:eltruism:gradientshort]",
		["xOffset"] = 0,
		["yOffset"] = 0
	}
	E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumStatus"] = {
		["attachTextTo"] = "Health",
		["enable"] = false,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "CENTER",
		["size"] = 25,
		["text_format"] = "[eltruism:dead][eltruism:dc]",
		["xOffset"] = 0,
		["yOffset"] = 0
	}

	-- Custom Text: Raid3
	E.db["unitframe"]["units"]["raid3"]["customTexts"] = E.db["unitframe"]["units"]["raid3"]["customTexts"] or {}
	E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Absorb"] = {
		["attachTextTo"] = "Health",
		["enable"] = false,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "CENTER",
		["size"] = 10,
		["text_format"] = "||cffFFFF00[absorbs]||r",
		["xOffset"] = 37,
		["yOffset"] = 12
	}
	E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumGroup"] = {
		["attachTextTo"] = "Health",
		["enable"] = false,
		["font"] = "Kimberley",
		["fontOutline"] = "NONE",
		["justifyH"] = "LEFT",
		["size"] = 8,
		["text_format"] = " Group [group]",
		["xOffset"] = 40,
		["yOffset"] = 12
	}
	E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Health"] = {
		["attachTextTo"] = "InfoPanel",
		["enable"] = true,
		["font"] = "Kimberley",
		["fontOutline"] = "OUTLINE",
		["justifyH"] = "RIGHT",
		["size"] = 10,
		["text_format"] = "[eltruism:hpstatusnopc:gradient]",
		["xOffset"] = 0,
		["yOffset"] = 0
	}
	E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Name"] = {
		["attachTextTo"] = "InfoPanel",
		["enable"] = true,
		["font"] = "Kimberley",
		["fontOutline"] = "OUTLINE",
		["justifyH"] = "LEFT",
		["size"] = 10,
		["text_format"] = "[name:eltruism:gradientshort]",
		["xOffset"] = 0,
		["yOffset"] = 0
	}
	E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumStatus"] = {
		["attachTextTo"] = "Health",
		["enable"] = false,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "CENTER",
		["size"] = 20,
		["text_format"] = "[eltruism:dead][eltruism:dc]",
		["xOffset"] = 0,
		["yOffset"] = 0
	}

	-- Custom Text: Target
	E.db["unitframe"]["units"]["target"]["customTexts"] = E.db["unitframe"]["units"]["target"]["customTexts"] or {}
	E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetAbsorb"] = {
		["attachTextTo"] = "Health",
		["enable"] = false,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "RIGHT",
		["size"] = 12,
		["text_format"] = "||cffFFFF00[absorbs]||r",
		["xOffset"] = 0,
		["yOffset"] = 15
	}
	E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetHealth"] = {
		["attachTextTo"] = "Health",
		["enable"] = true,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "LEFT",
		["size"] = 14,
		["text_format"] = "[eltruism:hpstatus:gradient]",
		["xOffset"] = 2,
		["yOffset"] = 0
	}
	E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumStatus"] = {
		["attachTextTo"] = "Health",
		["enable"] = false,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "CENTER",
		["size"] = 27,
		["text_format"] = "[eltruism:dead][eltruism:dc]",
		["xOffset"] = -50,
		["yOffset"] = 0
	}
	if E.Retail then
		E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "Kimberley",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 16,
			["text_format"] = "[eltruism:raidmarker] [eltruism:class:player] [name:eltruism:gradientshort]",
			["xOffset"] = -2,
			["yOffset"] = 0
		}
	elseif E.Cata or E.Classic then
		E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"] = {
			["attachTextTo"] = "Health",
			["enable"] = true,
			["font"] = "Kimberley",
			["fontOutline"] = "THICKOUTLINE",
			["justifyH"] = "RIGHT",
			["size"] = 16,
			["text_format"] = "[eltruism:raidmarker] [eltruism:class:player] [eltruism:difficulty][name:eltruism:gradientshort]",
			["xOffset"] = -2,
			["yOffset"] = 0
		}
	end
	E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetPower"] = {
		["attachTextTo"] = "Power",
		["enable"] = true,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "LEFT",
		["size"] = 10,
		["text_format"] = "[powercolor][power:current:shortvalue]",
		["xOffset"] = 2,
		["yOffset"] = -1
	}
	E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetofTarget"] = {
		["attachTextTo"] = "Frame",
		["enable"] = false,
		["font"] = "Kimberley",
		["fontOutline"] = "OUTLINE",
		["justifyH"] = "RIGHT",
		["size"] = 10,
		["text_format"] = "Target: [eltruism:targetcast]",
		["xOffset"] = -5,
		["yOffset"] = -14
	}

	-- Custom Text: TargetTarget
	E.db["unitframe"]["units"]["targettarget"]["customTexts"] = E.db["unitframe"]["units"]["targettarget"]["customTexts"] or {}
	E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetHealth"] = {
		["attachTextTo"] = "Health",
		["enable"] = false,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "LEFT",
		["size"] = 11,
		["text_format"] = "[eltruism:hpstatusnopc:gradient]",
		["xOffset"] = 2,
		["yOffset"] = 3
	}
	E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetName"] = {
		["attachTextTo"] = "Health",
		["enable"] = true,
		["font"] = "Kimberley",
		["fontOutline"] = "OUTLINE",
		["justifyH"] = "CENTER",
		["size"] = 12,
		["text_format"] = "[name:eltruism:gradientshort]",
		["xOffset"] = 0,
		["yOffset"] = 3
	}
	E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumPower"] = {
		["attachTextTo"] = "Power",
		["enable"] = true,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "CENTER",
		["size"] = 9,
		["text_format"] = "[powercolor][power:current:shortvalue]",
		["xOffset"] = 0,
		["yOffset"] = -1
	}
	E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumStatus"] = {
		["attachTextTo"] = "Health",
		["enable"] = true,
		["font"] = "Kimberley",
		["fontOutline"] = "THICKOUTLINE",
		["justifyH"] = "CENTER",
		["size"] = 15,
		["text_format"] = "[eltruism:dead][eltruism:dc]",
		["xOffset"] = 0,
		["yOffset"] = 22
	}

	ElvUI_EltreumUI:Print(L["General Layout has been set."])
end

-- Private DB
function ElvUI_EltreumUI:SetupPrivate()
	-- ElvUI Private DB
	E.private["general"]["chatBubbleFont"] = "Kimberley"
	E.private["general"]["chatBubbleFontOutline"] = "OUTLINE"
	E.private["general"]["chatBubbleFontSize"] = 10
	E.private["general"]["chatBubbleName"] = true
	E.private["general"]["dmgfont"] = "Kimberley"
	E.private["general"]["glossTex"] = "ElvUI Norm1"
	E.private["general"]["namefont"] = "Kimberley"
	E.private["general"]["normTex"] = "ElvUI Norm1"
	E.private["theme"] = "class"
	E.private["skins"]["parchmentRemoverEnable"] = true
	E.private["skins"]["blizzard"]["enable"] = true
	E.private["skins"]["blizzard"]["objectiveTracker"] = true
	E.private["skins"]["ace3Enable"] = true
	E.private["skins"]["checkBoxSkin"] = true
	E.private["general"]["totemBar"] = true
	E.private["install_complete"] = tostring(E.version)
	E.private["general"]["nameplateFont"] = "Kimberley"
	E.private["general"]["nameplateFontSize"] = 10
	E.private["general"]["nameplateLargeFont"] = "Kimberley"
	E.private["general"]["nameplateLargeFontSize"] = 10
	E.private["general"]["raidUtility"] = true
	if E.Retail then
		E.private["general"]["minimap"]["hideTracking"] = true
	end
end

-- Global DB
function ElvUI_EltreumUI:SetupGlobal()
	-- ElvUI Global DB
	if E.Retail then
		E.global["general"]["commandBarSetting"] = "ENABLED_RESIZEPARENT"
	end
	E.global["general"]["smallerWorldMap"] = false
	E.global["general"]["smallerWorldMapScale"] = 1
	E.global["general"]["mapAlphaWhenMoving"] = 0.35
	E.global["general"]["WorldMapCoordinates"]["position"] = "TOPLEFT"
	E.global["general"]["fadeMapDuration"] = 0.1
	-- Custom DataText
	E.global["datatexts"]["settings"]["Experience"]["textFormat"] = "PERCENT"
	E.global["datatexts"]["settings"]["Friends"]["hideAFK"] = true
	E.global["datatexts"]["settings"]["Friends"]["hideApp"] = true
	E.global["datatexts"]["settings"]["Friends"]["hideBSAp"] = true
	E.global["datatexts"]["settings"]["Gold"]["goldCoins"] = false
	--E.global["datatexts"]["settings"]["Time"]["time24"] = true
	E.global["datatexts"]["settings"]["Combat"]["TimeFull"] = false
	E.global["datatexts"]["settings"]["Durability"]["percThreshold"] = 40
end

--create Eltruism datatext
function ElvUI_EltreumUI:SetupDataText()
	if not E.db.movers then E.db.movers = {} end

	--create panel
	E.DataTexts:BuildPanelFrame('EltruismDataText')

	--config the panel
	E.global["datatexts"]["customPanels"]["EltruismDataText"]["backdrop"] = false
	E.global["datatexts"]["customPanels"]["EltruismDataText"]["panelTransparency"] = false
	E.global["datatexts"]["customPanels"]["EltruismDataText"]["border"] = false
	E.global["datatexts"]["customPanels"]["EltruismDataText"]["frameLevel"] = 1
	E.global["datatexts"]["customPanels"]["EltruismDataText"]["frameStrata"] = "LOW"
	E.global["datatexts"]["customPanels"]["EltruismDataText"]["growth"] = "HORIZONTAL"
	E.global["datatexts"]["customPanels"]["EltruismDataText"]["mouseover"] = false
	E.global["datatexts"]["customPanels"]["EltruismDataText"]["name"] = "Eltruism"
	E.global["datatexts"]["customPanels"]["EltruismDataText"]["numPoints"] = 9
	E.global["datatexts"]["customPanels"]["EltruismDataText"]["textJustify"] = "CENTER"
	E.global["datatexts"]["customPanels"]["EltruismDataText"]["tooltipAnchor"] = "ANCHOR_TOPLEFT"
	E.global["datatexts"]["customPanels"]["EltruismDataText"]["tooltipXOffset"] = -17
	E.global["datatexts"]["customPanels"]["EltruismDataText"]["tooltipYOffset"] = 4
	E.global["datatexts"]["customPanels"]["EltruismDataText"]["visibility"] = "[petbattle] hide;show"
	E.global["datatexts"]["customPanels"]["EltruismDataText"]["height"] = 23

	--create panel
	E.DataTexts:BuildPanelFrame('EltruismTime')

	--config the panel
	E.global["datatexts"]["customPanels"]["EltruismTime"]["backdrop"] = false
	E.global["datatexts"]["customPanels"]["EltruismTime"]["panelTransparency"] = false
	E.global["datatexts"]["customPanels"]["EltruismTime"]["border"] = false
	E.global["datatexts"]["customPanels"]["EltruismTime"]["frameLevel"] = 2
	E.global["datatexts"]["customPanels"]["EltruismTime"]["frameStrata"] = "LOW"
	E.global["datatexts"]["customPanels"]["EltruismTime"]["fonts"]["enable"] = true
	E.global["datatexts"]["customPanels"]["EltruismTime"]["fonts"]["font"] = "Kimberley"
	E.global["datatexts"]["customPanels"]["EltruismTime"]["fonts"]["fontOutline"] = "THICKOUTLINE"
	E.global["datatexts"]["customPanels"]["EltruismTime"]["fonts"]["fontSize"] = 18
	E.global["datatexts"]["customPanels"]["EltruismTime"]["growth"] = "HORIZONTAL"
	E.global["datatexts"]["customPanels"]["EltruismTime"]["mouseover"] = false
	E.global["datatexts"]["customPanels"]["EltruismTime"]["name"] = "Eltruism"
	E.global["datatexts"]["customPanels"]["EltruismTime"]["numPoints"] = 1
	E.global["datatexts"]["customPanels"]["EltruismTime"]["textJustify"] = "CENTER"
	E.global["datatexts"]["customPanels"]["EltruismTime"]["tooltipAnchor"] = "ANCHOR_TOPLEFT"
	E.global["datatexts"]["customPanels"]["EltruismTime"]["tooltipXOffset"] = -17
	E.global["datatexts"]["customPanels"]["EltruismTime"]["tooltipYOffset"] = 4
	E.global["datatexts"]["customPanels"]["EltruismTime"]["visibility"] = "[petbattle] hide;show"
	E.global["datatexts"]["customPanels"]["EltruismTime"]["height"] = 22
	E.global["datatexts"]["customPanels"]["EltruismTime"]["width"] = 120

	local buttonwidth = _G.RightChatToggleButton:GetWidth()
	--local width = GetPhysicalScreenSize()
	local width = ceil(E.screenWidth)
	E.global["datatexts"]["customPanels"]["EltruismDataText"]["width"] = 2 + math.ceil(width - (buttonwidth * 2))

	--scale stuff for 4k
	--print(buttonwidth,width,E:PixelBestSize())
	--0.632098738

	--local width = GetPhysicalScreenSize()
	--[[if width == 3840 or width == 2560 then
		--E.global["datatexts"]["customPanels"]["EltruismDataText"]["width"] = 2094
		E.global["datatexts"]["customPanels"]["EltruismDataText"]["width"] = 1914
	else
		E.global["datatexts"]["customPanels"]["EltruismDataText"]["width"] = 1912
	end]]

	E.db["datatexts"]["panels"]["EltruismDataText"][2] = "Durability"
	E.db["datatexts"]["panels"]["EltruismDataText"][3] = "EltruismTeleports"
	E.db["datatexts"]["panels"]["EltruismDataText"][4] = "Eltruism Stats 1"
	E.db["datatexts"]["panels"]["EltruismDataText"][5] = ""
	E.db["datatexts"]["panels"]["EltruismDataText"][6] = "Eltruism Stats 2"
	E.db["datatexts"]["panels"]["EltruismDataText"][7] = "System"
	E.db["datatexts"]["panels"]["EltruismDataText"][8] = "Combat"
	E.db["datatexts"]["panels"]["EltruismDataText"][9] = "Gold"
	if E.Retail then
		E.db["datatexts"]["panels"]["EltruismDataText"][1] = "Talent/Loot Specialization"
	else
		if E.Classic and (E.myclass == 'HUNTER' or E.myclass == 'WARLOCK') then
			E.db["datatexts"]["panels"]["EltruismDataText"][1] = "Ammo"
		else
			--E.db["datatexts"]["panels"]["EltruismDataText"][1] = "Eltruism"
			E.db["datatexts"]["panels"]["EltruismDataText"][1] = "DualSpecialization"
		end
	end
	E.db["datatexts"]["panels"]["EltruismDataText"]["enable"] = true

	E.db["datatexts"]["panels"]["EltruismTime"][1] = "Time"
	E.db["datatexts"]["panels"]["EltruismTime"]["enable"] = true

	E.db["datatexts"]["panels"]["EltruismDataText"]["battleground"] = true
	E.db["datatexts"]["battlePanel"]["EltruismDataText"][1] = "PvP: Kills"
	E.db["datatexts"]["battlePanel"]["EltruismDataText"][2] = "PvP: Deaths"
	if E.Retail then
		E.db["datatexts"]["battlePanel"]["EltruismDataText"][3] = "PvP: Objectives"
	else
		E.db["datatexts"]["battlePanel"]["EltruismDataText"][3] = "PvP: Damage Done"
	end
	E.db["datatexts"]["battlePanel"]["EltruismDataText"][4] = "Eltruism Stats 1"
	E.db["datatexts"]["battlePanel"]["EltruismDataText"][5] = ""
	E.db["datatexts"]["battlePanel"]["EltruismDataText"][6] = "Eltruism Stats 2"
	E.db["datatexts"]["battlePanel"]["EltruismDataText"][7] = "System"
	E.db["datatexts"]["battlePanel"]["EltruismDataText"][8] = "Combat"
	E.db["datatexts"]["battlePanel"]["EltruismDataText"][9] = "PvP: Honor Gained"

	--hide other panels since now its in one panel
	E.db["datatexts"]["panels"]["LeftChatDataPanel"]["enable"] = false
	E.db["datatexts"]["panels"]["MinimapPanel"]["enable"] = false
	E.db["datatexts"]["panels"]["RightChatDataPanel"]["enable"] = false

	--adjust chat due to new datatext
	E.db["movers"]["LeftChatMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,-1,22"
	E.db["movers"]["RightChatMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,0,22"
	E.db["movers"]["DTPanelEltruismDataTextMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,0"
	E.db["movers"]["DTPanelEltruismTimeMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,0"

	E:UpdateDataTexts()
	E:UpdateMoverPositions()

	--show the chat buttons because they are attached to the chat datatext not panel
	_G.LeftChatToggleButton:SetAlpha(1)
	_G.LeftChatToggleButton:Show()
	_G.RightChatToggleButton:SetAlpha(1)
	_G.RightChatToggleButton:Show()
end

-- CVars General
function ElvUI_EltreumUI:SetupCVars()
	-- ElvUI CVars
	SetCVar('removeChatDelay', 1)
	SetCVar('autoLootDefault', 1)
	SetCVar('autoQuestWatch', 1)
	SetCVar('UnitNameEnemyGuardianName', 0)
	SetCVar('UnitNameEnemyMinionName', 0)
	SetCVar('UnitNameEnemyPetName', 0)
	SetCVar('UnitNameFriendlyPetName', 0)
	SetCVar('UnitNameEnemyPlayerName', 1)
	SetCVar('UnitNameEnemyTotemName', 1)
	SetCVar('UnitNameNonCombatCreatureName', 0)
	SetCVar('UnitNameNPC', 1)
	SetCVar('UnitNameOwn', 0)
	SetCVar("ShowClassColorInFriendlyNameplate", 1)
	SetCVar('statusTextDisplay', 'BOTH')
	SetCVar('screenshotQuality', 10)
	SetCVar('chatMouseScroll', 1)
	SetCVar('wholeChatWindowClickable', 0)
	SetCVar('showTutorials', 0)
	SetCVar('UberTooltips', 1)
	SetCVar('alwaysShowActionBars', 1)
	SetCVar('lockActionBars', 1)
	SetCVar('ActionButtonUseKeyDown', 1)
	SetCVar('fstack_preferParentKeys', 0) --Add back the frame names via fstack!
	SetCVar('threatWarning', 3)
	SetCVar('showNPETutorials', 0)
	SetCVar('showQuestTrackingTooltips', 1)
	--SetCVar('Sound_EnableErrorSpeech', 1)
	SetCVar('alwaysCompareItems', 0) --dont always compare
	SetCVar('allowCompareWithToggle', 1) --compare using shift
	SetCVar('instantQuestText', 1) -- makes quest text show fast instead of per line
	SetCVar('maxFPSLoading', 30) --smoother loading bar
	SetCVar('PushToTalkSound', 0) --disable tts queue sound (may be protected and not apply though)

	-- fast loot
	SetCVar("autoLootRate", 1)

	--Chat CVars
	SetCVar('chatStyle', 'classic')
	SetCVar('whisperMode', 'inline')
	SetCVar('colorChatNamesByClass', 1)
	SetCVar('chatClassColorOverride', 0)

	if _G.InterfaceOptionsActionBarsPanelPickupActionKeyDropDown then
		_G.InterfaceOptionsActionBarsPanelPickupActionKeyDropDown:SetValue('SHIFT')
		_G.InterfaceOptionsActionBarsPanelPickupActionKeyDropDown:RefreshValue()
	end

	if E.Retail then
		SetCVar('cameraDistanceMaxZoomFactor', 2.6)
		--occluded character visibility
		SetCVar('cameraIndirectVisibility', 1)
		SetCVar('cameraIndirectOffset', 15)
	else
		SetCVar('cameraDistanceMaxZoomFactor', 3.4)
	end

	--new softtarget (only function if player enables interact with target option, which these cvars do not enable)
	SetCVar('SoftTargetInteractRange', 5)
	SetCVar('SoftTargetIconGameObject', 1)
	SetCVar('SoftTargetIconInteract', 1)
	SetCVar('SoftTargetInteract', 3) --3 enables, 0 disables
	SetCVar('SoftTargetInteractArc', 2)
	SetCVar('SoftTargetNameplateInteract', 1)
	SetCVar('SoftTargetLowPriorityIcons', 1)
	SetCVar('SoftTargetIconEnemy', 0)
	SetCVar('SoftTargetIconFriend', 0)
	SetCVar('WorldTextMinSize', 6)

	if E.Retail then
		--this makes it so that the non nameplate names are hidden
		SetCVar('UnitNameHostleNPC', 0) --Display names for hostile NPCs, even when they are dead
		SetCVar('UnitNameInteractiveNPC', 0) --Display names for interactive NPCs
		SetCVar('UnitNameNPC', 0)

		--spell overlay
		SetCVar('spellActivationOverlayOpacity', 0.5)
		SetCVar('displaySpellActivationOverlays', 1)

		SetCVar('minimapTrackingShowAll', 1) --return old tracking on right click

		SetCVar('missingTransmogSourceInItemTooltips', 1)

		--[[
		SetCVar('findYourselfAnywhere', 0) --"Always Highlight your character"
		SetCVar('findYourselfAnywhereOnlyInCombat', 0) --"Highlight your character only when in combat"
		SetCVar('findYourselfInBG', 0) --"Always Highlight your character in Battlegrounds"
		SetCVar('findYourselfInBGOnlyInCombat', 9) --"Highlight your character in Battlegrounds only when in combat"
		SetCVar('findYourselfInRaid', 0) --"Always Highlight your character in Raids"
		SetCVar('findYourselfInRaidOnlyInCombat', 0) --"Highlight your character in Raids only when in combat"
		SetCVar('findYourselfMode', 1) --"Highlight you character. 0 = circle, 1 = circle & outline"
		]]
	elseif E.Cata or E.Classic then
		SetCVar("lootUnderMouse", 1)
		SetCVar("chatBubbles", 1)
		SetCVar("chatBubblesParty", 1)
	end
	ElvUI_EltreumUI:Print(L["General CVars have been set."])
end

-- CVars NamePlates
function ElvUI_EltreumUI:NameplateCVars()
	SetCVar('nameplateOtherBottomInset', 0.02)
	SetCVar('nameplateOtherTopInset', 0.1)
	SetCVar('nameplateLargeBottomInset', 0.02)
	SetCVar('nameplateLargeTopInset', 0.1)
	SetCVar('nameplateTargetRadialPosition', 1)
	SetCVar('nameplateLargerScale', 1.2)
	SetCVar('nameplateMinScale', 1)
	SetCVar('nameplateMinAlpha',1)
	SetCVar('nameplateGlobalScale', 1)
	SetCVar('nameplateMaxDistance', 60)
	SetCVar('nameplateMotion', 1)
	SetCVar('nameplateOccludedAlphaMult', 0)
	SetCVar("nameplateOverlapH", 0.8)
	SetCVar("nameplateOverlapV", 1.1)
	SetCVar('nameplateSelectedScale', 1)
	SetCVar('nameplateSelfAlpha', 1)
	SetCVar('nameplateShowFriendlyMinions', 0)
	SetCVar('nameplateTargetBehindMaxDistance', 40)
	SetCVar('nameplateShowEnemies', 1)
	SetCVar("nameplateShowFriends", 1)
	ElvUI_EltreumUI:Print(L["NamePlate CVars have been set."])
end

-- Alternate DPS party layout
function ElvUI_EltreumUI:AlternativeGroupsDPS()
	if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") then
		if not E.db.movers then E.db.movers = {} end
		E.db["movers"]["ElvUF_PartyMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,199,-258"
		E.db["movers"]["ElvUF_Raid1Mover"] = "TOPLEFT,UIParent,TOPLEFT,4,-432"
		E.db["movers"]["ElvUF_Raid2Mover"] = "TOPLEFT,UIParent,TOPLEFT,104,-328"
		E.db["movers"]["ElvUF_Raid3Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,7,-321"
		E.db["unitframe"]["units"]["raid1"]["numGroups"] = 4
		E.db["unitframe"]["units"]["raid1"]["height"] = 30
		E.db["unitframe"]["units"]["raid1"]["growthDirection"] = "DOWN_LEFT"
		--E.db["unitframe"]["units"]["raid1"]["groupSpacing"] = 10
		E.db["unitframe"]["units"]["raid1"]["groupSpacing"] = 2
		--E.db["unitframe"]["units"]["raid1"]["groupsPerRowCol"] = 2
		E.db["unitframe"]["units"]["raid1"]["groupsPerRowCol"] = 1
		--E.db["unitframe"]["units"]["raid1"]["horizontalSpacing"] = 25
		E.db["unitframe"]["units"]["raid1"]["horizontalSpacing"] = 3
		E.db["unitframe"]["units"]["raid1"]["verticalSpacing"] = 3
		E.db["unitframe"]["units"]["raid1"]["width"] = 120
		E.db["unitframe"]["units"]["raid2"]["groupsPerRowCol"] = 2
		E.db["unitframe"]["units"]["raid3"]["groupSpacing"] = 5
		E.db["unitframe"]["units"]["raid3"]["groupsPerRowCol"] = 2
		E.db["unitframe"]["units"]["raid3"]["growthDirection"] = "DOWN_RIGHT"
		E.db["unitframe"]["units"]["raid3"]["height"] = 30
		E.db["unitframe"]["units"]["raid3"]["horizontalSpacing"] = 2
		E.db["unitframe"]["units"]["raid3"]["width"] = 120
		E.db["unitframe"]["units"]["raid3"]["verticalSpacing"] = 3

		ElvUI_EltreumUI:Print(L["Alternative Group, Raid and Raid40 layout has been set"])

		E.db.ElvUI_EltreumUI.otherstuff.alternativegroups = true

		E:UpdateLayout()
		E:UpdateUnitFrames()
		E:UpdateMoverPositions()
	else
		ElvUI_EltreumUI:Print(L["The alternative layout was made for the Eltruism DPS/Tank profile, please switch to it to use it"])
	end
end

-- Original DPS party layout
function ElvUI_EltreumUI:OriginalGroupsDPS()
	if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") then
		if not E.db.movers then E.db.movers = {} end
		E.db["movers"]["ElvUF_PartyMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-247"
		E.db["movers"]["ElvUF_Raid1Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,0,1"
		E.db["movers"]["ElvUF_Raid2Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,0,1"
		E.db["movers"]["ElvUF_Raid3Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,0,1"
		E.db["unitframe"]["units"]["raid1"]["numGroups"] = 4
		E.db["unitframe"]["units"]["raid1"]["height"] = 28
		E.db["unitframe"]["units"]["raid1"]["groupSpacing"] = 6
		E.db["unitframe"]["units"]["raid1"]["groupsPerRowCol"] = 4
		E.db["unitframe"]["units"]["raid1"]["horizontalSpacing"] = 0
		E.db["unitframe"]["units"]["raid1"]["verticalSpacing"] = 3
		E.db["unitframe"]["units"]["raid1"]["growthDirection"] = "DOWN_RIGHT"
		E.db["unitframe"]["units"]["raid1"]["width"] = 120
		E.db["unitframe"]["units"]["raid3"]["height"] = 28
		E.db["unitframe"]["units"]["raid3"]["groupSpacing"] = 6
		E.db["unitframe"]["units"]["raid3"]["groupsPerRowCol"] = 4
		E.db["unitframe"]["units"]["raid3"]["growthDirection"] = "DOWN_RIGHT"
		E.db["unitframe"]["units"]["raid3"]["height"] = 29
		E.db["unitframe"]["units"]["raid3"]["horizontalSpacing"] = 2
		E.db["unitframe"]["units"]["raid3"]["width"] = 120
		E.db["unitframe"]["units"]["raid3"]["verticalSpacing"] = 3

		ElvUI_EltreumUI:Print(L["Original Group, Raid and Raid40 layout has been set"])

		E.db.ElvUI_EltreumUI.otherstuff.alternativegroups = false

		E:UpdateLayout()
		E:UpdateUnitFrames()
		E:UpdateMoverPositions()
	else
		ElvUI_EltreumUI:Print(L["The original layout was made for the Eltruism DPS/Tank profile, please switch to it to use it"])
	end
end

--a more grey and less dark background
function ElvUI_EltreumUI:GreyBg()
	E.db["general"]["backdropcolor"]["b"] = 0.098039215686275
	E.db["general"]["backdropcolor"]["g"] = 0.098039215686275
	E.db["general"]["backdropcolor"]["r"] = 0.098039215686275
	E.db["general"]["backdropfadecolor"]["a"] = 0.80000001192093
	E.db["general"]["backdropfadecolor"]["b"] = 0.13725490196078
	E.db["general"]["backdropfadecolor"]["g"] = 0.13725490196078
	E.db["general"]["backdropfadecolor"]["r"] = 0.13725490196078

	E.db.ElvUI_EltreumUI.unitframes.greybackground = true
	E:UpdateMediaItems()
	ElvUI_EltreumUI:Print("ElvUI set to Grey Background")
end

--the traditional black/dark background
function ElvUI_EltreumUI:BlackBg()
	E.db["general"]["backdropcolor"]["b"] = 0.098039215686275
	E.db["general"]["backdropcolor"]["g"] = 0.098039215686275
	E.db["general"]["backdropcolor"]["r"] = 0.098039215686275
	E.db["general"]["backdropfadecolor"]["a"] = 0.70000001788139
	E.db["general"]["backdropfadecolor"]["b"] = 0
	E.db["general"]["backdropfadecolor"]["g"] = 0
	E.db["general"]["backdropfadecolor"]["r"] = 0

	E.db.ElvUI_EltreumUI.unitframes.greybackground = false
	E:UpdateMediaItems()
	ElvUI_EltreumUI:Print("ElvUI set to Black Background")
end

function ElvUI_EltreumUI:CheckBackground()
	if not E.db.ElvUI_EltreumUI.unitframes.greybackground then
		ElvUI_EltreumUI:GreyBg()
	elseif E.db.ElvUI_EltreumUI.unitframes.greybackground then
		ElvUI_EltreumUI:BlackBg()
	else
		ElvUI_EltreumUI:GreyBg()
	end
end
