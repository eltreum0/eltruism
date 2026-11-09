local E, L = unpack(ElvUI)
local valuecolors = E.myClassColor
local _G = _G
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded
local tostring = _G.tostring
local SetCVar = _G.C_CVar and _G.C_CVar.SetCVar or _G.SetCVar
local math = _G.math
local mathceil = math.ceil
local GetPhysicalScreenSize = _G.GetPhysicalScreenSize
local type = _G.type
local GetCVarDefault = _G.C_CVar and _G.C_CVar.GetCVarDefault or _G.GetCVarDefault

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

	--SetupShadowAndLight
	if IsAddOnLoaded("ElvUI_SLE") then
		ElvUI_EltreumUI:GetSLEProfile()
	end

	if IsAddOnLoaded("ElvUI_WindTools") then
		ElvUI_EltreumUI:GetWindToolsProfile()
		E.db["movers"]["WTRaidMarkersBarAnchor"] = "TOPLEFT,ElvUIParent,TOPLEFT,398,1"
	end

	--tag update rate
	E.db["general"]["tagUpdateRate"] = 0.5 --test 0.5, default is 0.2

	-- AB Conversion
	E.db["convertPages"] = true

	--luckyone based optimizations
	E.db["auras"]["buffs"]["seperateOwn"] = 0 -- do not sort auras
	E.db["auras"]["debuffs"]["seperateOwn"] = 0 -- do not sort auras
	--E.db["auras"]["cooldown"]["override"] = false
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

	--target of target
	E.db["unitframe"]["units"]["targettarget"]["enable"] = true

	--modern show class colors
	E.db["nameplates"]["classColorNames"] = true

	--general unitframe
	E.db["unitframe"]["statusbar"] = "ElvUI Norm1"
	E.db["unitframe"]["font"] = "Kimberley"
	E.db["unitframe"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["smartRaidFilter"] = false
	E.db["unitframe"]["targetSound"] = true
	E.db["unitframe"]["debuffHighlighting"] = "FILL"

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

	--disable the custom auras on target
	E.db["unitframe"]["units"]["target"]["auras"]["enable"] = false

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
	--[[E.db["movers"]["PrivateAurasMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-287,-150"
	E.db["unitframe"]["units"]["party"]["privateAuras"]["parent"]["offsetY"] = 12
	E.db["unitframe"]["units"]["raid1"]["privateAuras"]["parent"]["offsetY"] = 5
	E.db["unitframe"]["units"]["raid2"]["privateAuras"]["parent"]["offsetY"] = 5
	E.db["unitframe"]["units"]["raid3"]["privateAuras"]["parent"]["offsetY"] = 5]]

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
	ElvUI_EltreumUI:SetActionBarPaging(4)

	--aura filtering
	ElvUI_EltreumUI:SetupAllAuras("Minimal")

	-- Auras
	E.db["auras"]["buffs"]["barColor"]["b"] = 0.86666476726532
	E.db["auras"]["buffs"]["barColor"]["g"] = 0.4392147064209
	E.db["auras"]["buffs"]["barNoDuration"] = false
	E.db["auras"]["buffs"]["barPosition"] = "LEFT"
	E.db["auras"]["buffs"]["barShow"] = false
	E.db["auras"]["buffs"]["barSize"] = 6
	E.db["auras"]["buffs"]["barSpacing"] = 0
	E.db["auras"]["buffs"]["barTexture"] = "Eltreum-Blank"
	E.db["auras"]["buffs"]["countFont"] = "Kimberley"
	E.db["auras"]["buffs"]["countFontOutline"] = "THICKOUTLINE"
	E.db["auras"]["buffs"]["countFontSize"] = 12
	E.db["auras"]["buffs"]["fadeThreshold"] = 10
	E.db["auras"]["buffs"]["horizontalSpacing"] = 7
	E.db["auras"]["buffs"]["maxWraps"] = 2
	E.db["auras"]["buffs"]["size"] = 32
	E.db["auras"]["buffs"]["sortDir"] = "+"
	E.db["auras"]["buffs"]["timeFont"] = "Kimberley"
	E.db["auras"]["buffs"]["timeFontOutline"] = "THICKOUTLINE"
	E.db["auras"]["buffs"]["timeFontSize"] = 12
	E.db["auras"]["buffs"]["verticalSpacing"] = 14
	E.db["auras"]["buffs"]["wrapAfter"] = 10
	E.db["auras"]["debuffs"]["barColor"]["b"] = 0.86666476726532
	E.db["auras"]["debuffs"]["barColor"]["g"] = 0.4392147064209
	E.db["auras"]["debuffs"]["barNoDuration"] = false
	E.db["auras"]["debuffs"]["barPosition"] = "LEFT"
	E.db["auras"]["debuffs"]["barShow"] = false
	E.db["auras"]["debuffs"]["barSize"] = 6
	E.db["auras"]["debuffs"]["barSpacing"] = 0
	E.db["auras"]["debuffs"]["barTexture"] = "Eltreum-Blank"
	E.db["auras"]["debuffs"]["countFont"] = "Kimberley"
	E.db["auras"]["debuffs"]["countFontOutline"] = "THICKOUTLINE"
	E.db["auras"]["debuffs"]["countFontSize"] = 12
	E.db["auras"]["debuffs"]["horizontalSpacing"] = 7
	E.db["auras"]["debuffs"]["size"] = 32
	E.db["auras"]["debuffs"]["sortDir"] = "+"
	E.db["auras"]["debuffs"]["timeFont"] = "Kimberley"
	E.db["auras"]["debuffs"]["timeFontOutline"] = "THICKOUTLINE"
	E.db["auras"]["debuffs"]["timeFontSize"] = 12
	E.db["auras"]["debuffs"]["verticalSpacing"] = 14
	E.db["auras"]["debuffs"]["wrapAfter"] = 10

	-- aura sorting
	E.db["auras"]["buffs"]["sortMethod"] = "INDEX"
	E.db["auras"]["debuffs"]["sortMethod"] = "INDEX"
	E.db["unitframe"]["units"]["boss"]["buffs"]["sortMethod"] = "INDEX"
	E.db["unitframe"]["units"]["boss"]["debuffs"]["sortMethod"] = "INDEX"
	E.db["unitframe"]["units"]["focus"]["debuffs"]["sortMethod"] = "INDEX"
	E.db["unitframe"]["units"]["party"]["debuffs"]["sortMethod"] = "INDEX"
	E.db["unitframe"]["units"]["pet"]["buffs"]["sortMethod"] = "INDEX"
	E.db["unitframe"]["units"]["pet"]["debuffs"]["sortMethod"] = "INDEX"
	E.db["unitframe"]["units"]["player"]["buffs"]["sortMethod"] = "INDEX"
	E.db["unitframe"]["units"]["player"]["debuffs"]["sortMethod"] = "INDEX"
	E.db["unitframe"]["units"]["target"]["buffs"]["sortMethod"] = "INDEX"
	E.db["unitframe"]["units"]["pet"]["buffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["pet"]["buffs"]["countFontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["pet"]["debuffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["pet"]["debuffs"]["countFontOutline"] = "OUTLINE"

	--new fonts
	E.db["unitframe"]["units"]["raid1"]["auras"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["raid1"]["auras"]["countFontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["raid1"]["auras"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["raid1"]["auras"]["sourceText"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["raid1"]["buffIndicator"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["raid1"]["buffIndicator"]["countFontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["raid2"]["auras"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["raid2"]["auras"]["countFontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["raid2"]["auras"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["raid2"]["auras"]["sourceText"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["raid2"]["buffIndicator"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["raid2"]["buffIndicator"]["countFontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["raid3"]["auras"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["raid3"]["auras"]["countFontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["raid3"]["auras"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["raid3"]["auras"]["sourceText"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["raid3"]["buffIndicator"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["raid3"]["buffIndicator"]["countFontOutline"] = "OUTLINE"

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
	E.db["general"]["itemLevel"]["totalLevelFontSize"] = E.Modern and 22 or 12
	E.db["general"]["itemLevel"]["enchantAbbrev"] = true
	E.db["general"]["itemLevel"]["showItemLevel"] = true
	E.db["general"]["itemLevel"]["showEnchants"] = true
	E.db["general"]["itemLevel"]["showGems"] = true

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
	E.db["unitframe"]["units"]["player"]["aurabar"]["friendlyFilter"]["filterLists"]["group1"]["enable"] = true
	E.db["unitframe"]["units"]["player"]["aurabar"]["friendlyFilter"]["filterLists"]["group1"]["filter"] = 'HELPFUL'
	E.db["unitframe"]["units"]["player"]["aurabar"]["friendlyFilter"]["filterLists"]["group1"]["maxDuration"] = 300
	E.db["unitframe"]["units"]["player"]["aurabar"]["friendlyFilter"]["filterLists"]["group2"]["enable"] = false
	E.db["unitframe"]["units"]["player"]["aurabar"]["friendlyFilter"]["filterLists"]["group2"]["maxDuration"] = 300
	E.db["unitframe"]["units"]["player"]["aurabar"]["friendlyFilter"]["filterLists"]["group3"]["enable"] = false
	E.db["unitframe"]["units"]["player"]["aurabar"]["friendlyFilter"]["filterLists"]["group3"]["maxDuration"] = 300

	---aurabar filter for retail
	--[[E.db["unitframe"]["units"]["player"]["aurabar"]["isAuraBigDefensive"] = true
	E.db["unitframe"]["units"]["player"]["aurabar"]["isAuraDefensive"] = true
	E.db["unitframe"]["units"]["player"]["aurabar"]["isAuraImportant"] = true
	E.db["unitframe"]["units"]["player"]["aurabar"]["isAuraRaid"] = false
]]

	--hide permanent auras
	E.db["unitframe"]["units"]["player"]["aurabar"]["isAuraPermanentPlayer"] = true

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
	E.db["unitframe"]["units"]["target"]["aurabar"]["enemyFilter"]["filterLists"]["group1"]["enable"] = true
	E.db["unitframe"]["units"]["target"]["aurabar"]["enemyFilter"]["filterLists"]["group1"]["maxDuration"] = 300
	E.db["unitframe"]["units"]["target"]["aurabar"]["enemyFilter"]["filterLists"]["group1"]["filter"] = 'HARMFUL|PLAYER|INCLUDE_NAME_PLATE_ONLY|!CROWD_CONTROL'
	E.db["unitframe"]["units"]["target"]["aurabar"]["enemyFilter"]["filterLists"]["group2"]["enable"] = false
	E.db["unitframe"]["units"]["target"]["aurabar"]["enemyFilter"]["filterLists"]["group2"]["maxDuration"] = 300
	E.db["unitframe"]["units"]["target"]["aurabar"]["enemyFilter"]["filterLists"]["group3"]["enable"] = false
	E.db["unitframe"]["units"]["target"]["aurabar"]["enemyFilter"]["filterLists"]["group3"]["maxDuration"] = 300
	E.db["unitframe"]["units"]["target"]["aurabar"]["friendlyFilter"]["filterLists"]["group1"]["enable"] = true
	E.db["unitframe"]["units"]["target"]["aurabar"]["friendlyFilter"]["filterLists"]["group1"]["maxDuration"] = 300
	E.db["unitframe"]["units"]["target"]["aurabar"]["friendlyFilter"]["filterLists"]["group1"]["filter"] = 'HELPFUL|PLAYER'

	---aurabar filter for retail
	--[[E.db["unitframe"]["units"]["target"]["aurabar"]["isAuraBigDefensive"] = true
	E.db["unitframe"]["units"]["target"]["aurabar"]["isAuraCrowdControl"] = true
	E.db["unitframe"]["units"]["target"]["aurabar"]["isAuraImportant"] = true
	E.db["unitframe"]["units"]["target"]["aurabar"]["isAuraRaid"] = false
	E.db["unitframe"]["units"]["target"]["aurabar"]["isAuraRaidPlayerDispellable"] = true]]

	--hide permanent auras
	E.db["unitframe"]["units"]["target"]["aurabar"]["isAuraPermanentPlayer"] = true

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

	-- unitframe colors
	E.db["unitframe"]["colors"]["auraBarBuff"]["b"] = valuecolors.b
	E.db["unitframe"]["colors"]["auraBarBuff"]["g"] = valuecolors.g
	E.db["unitframe"]["colors"]["auraBarBuff"]["r"] = valuecolors.r
	E.db["unitframe"]["colors"]["aurabar_backdrop"]["b"] = 0
	E.db["unitframe"]["colors"]["aurabar_backdrop"]["g"] = 0
	E.db["unitframe"]["colors"]["aurabar_backdrop"]["r"] = 0
	E.db["unitframe"]["colors"]["castClassColor"] = true
	E.db["unitframe"]["colors"]["castColor"]["b"] = 0 --fix interruptable color
	E.db["unitframe"]["colors"]["castColor"]["g"] = 0.58823531866074
	E.db["unitframe"]["colors"]["castColor"]["r"] = 1
	E.db["unitframe"]["colors"]["castbar_backdrop"]["b"] = 0
	E.db["unitframe"]["colors"]["castbar_backdrop"]["g"] = 0
	E.db["unitframe"]["colors"]["castbar_backdrop"]["r"] = 0
	E.db["unitframe"]["colors"]["castbar_backdrop"]["a"] = 0.4
	E.db["unitframe"]["colors"]["castReactionColor"] = false
	E.db["unitframe"]["colors"]["classResources"]["PALADIN"]["b"] = 0.050980392156863
	E.db["unitframe"]["colors"]["classResources"]["PALADIN"]["g"] = 1
	E.db["unitframe"]["colors"]["classResources"]["PALADIN"]["r"] = 1
	--E.db["unitframe"]["colors"]["classResources"]["DEATHKNIGHT"][0]["b"] = 1
	--E.db["unitframe"]["colors"]["classResources"]["DEATHKNIGHT"][0]["g"] = 1
	--E.db["unitframe"]["colors"]["classResources"]["DEATHKNIGHT"][0]["r"] = 0
	--[[E.db["unitframe"]["colors"]["classResources"]["MONK"][1]["b"] = 0.57254904508591
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
	E.db["unitframe"]["colors"]["classResources"]["MONK"][6]["r"] = 0.11372549831867]]
	--plugin export method doesnt seem to work, use table
	E.db.unitframe.colors.classResources.MONK = {
		{r = 0.57254904508591, g = 1, b = 0.078431375324726},
		{r = 0.61568629741669, g = 1, b = 0.082352943718433},
		{r = 0.7294117808342, g = 1, b = 0.098039224743843},
		{r = 0.78039222955704, g = 1, b = 0.094117656350136},
		{r = 0.85490202903748, g = 1, b = 0.10588236153126},
		{r = 0.93333339691162, g = 1, b = 0.11372549831867}
	}
	E.db["unitframe"]["colors"]["classResources"]["MAGE"]["ARCANE_CHARGES"]["r"] = 0
	E.db["unitframe"]["colors"]["classResources"]["MAGE"]["ARCANE_CHARGES"]["g"] = 0.62
	E.db["unitframe"]["colors"]["classResources"]["MAGE"]["ARCANE_CHARGES"]["b"] = 1

	--these are the original version of colors from simpy, looks better with gradient
	E.db["unitframe"]["colors"]["classResources"]["SHAMAN"]["MAELSTROM"]["r"] = 0.58
	E.db["unitframe"]["colors"]["classResources"]["SHAMAN"]["MAELSTROM"]["g"] = 0.51
	E.db["unitframe"]["colors"]["classResources"]["SHAMAN"]["MAELSTROM"]["b"] = 0.79
	--these are the second version of colors from simpy, but they are too dark and dont look good with gradient
	--[[E.db["unitframe"]["colors"]["classResources"]["SHAMAN"]["MAELSTROM"]["r"] = 0.35
	E.db["unitframe"]["colors"]["classResources"]["SHAMAN"]["MAELSTROM"]["g"] = 0.15
	E.db["unitframe"]["colors"]["classResources"]["SHAMAN"]["MAELSTROM"]["b"] = 1]]

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
	E.db["unitframe"]["colors"]["powerPrediction"]["additional"]["a"] = 0.7
	E.db["unitframe"]["colors"]["powerPrediction"]["additional"]["b"] = 1
	E.db["unitframe"]["colors"]["powerPrediction"]["additional"]["g"] = 1
	E.db["unitframe"]["colors"]["powerPrediction"]["additional"]["r"] = 1
	E.db["unitframe"]["colors"]["powerPrediction"]["color"]["a"] = 0.7
	E.db["unitframe"]["colors"]["powerPrediction"]["color"]["b"] = 1
	E.db["unitframe"]["colors"]["powerPrediction"]["color"]["g"] = 1
	E.db["unitframe"]["colors"]["powerPrediction"]["color"]["r"] = 1
	E.db["unitframe"]["colors"]["powerPrediction"]["enable"] = true
	E.db["unitframe"]["units"]["arena"]["power"]["powerPrediction"] = true
	E.db["unitframe"]["units"]["player"]["power"]["powerPrediction"] = true
	E.db["unitframe"]["units"]["target"]["power"]["powerPrediction"] = true
	E.db["unitframe"]["units"]["focus"]["power"]["powerPrediction"] = true

	--movers
	E.db["movers"]["BuffsMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-213,-4"
	E.db["movers"]["DebuffsMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-213,-101"
	E.db["movers"]["ElvAB_6"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,0,205"
	E.db["movers"]["ElvUF_FocusMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,424,-204"
	E.db["movers"]["ElvUF_FocusCastbarMover"] = "TOP,ElvUIParent,TOP,0,-168"
	E.db["movers"]["EnhancedVehicleBar_Mover"] = "BOTTOM,ElvUIParent,BOTTOM,0,-1"
	E.db["movers"]["MawBuffsBelowMinimapMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-4,-260"
	E.db["movers"]["ReputationBarMover"] = "TOP,ElvUIParent,TOP,0,0"
	E.db["movers"]["ExperienceBarMover"] = "TOP,ElvUIParent,TOP,0,-13"
	E.db["movers"]["GMMover"] = "TOP,ElvUIParent,TOP,239,-3"
	E.db["movers"]["HonorBarMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-412,0"
	E.db["movers"]["LossControlMover"] = "TOP,ElvUIParent,TOP,0,-317"
	E.db["movers"]["PetBattleABMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,-1"
	E.db["movers"]["PetBattleStatusMover"] = "TOP,ElvUIParent,TOP,0,1"
	E.db["movers"]["PowerWidgetMover"] = "TOP,ElvUIParent,TOP,0,-102"
	E.db["movers"]["TopCenterContainerMover"] = "TOP,ElvUIParent,TOP,0,-100"
	E.db["movers"]["RaidMarkerBarAnchor"] = "TOPLEFT,ElvUIParent,TOPLEFT,398,1"
	E.db["movers"]["ThreatBarMover"] = "TOP,ElvUIParent,TOP,0,-42"
	E.db["movers"]["AlertFrameMover"] = "TOP,ElvUIParent,TOP,0,-67"
	E.db["movers"]["VehicleSeatMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-210,-150"
	if E.Modern then
		E.db["movers"]["VehicleLeaveButton"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-183,-179"
	else
		E.db["movers"]["VehicleLeaveButton"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-176,-145"
	end
	E.db["movers"]["MoverEltruismInstanceDifficulty"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-146,-21"
	E.db["movers"]["MoverRaidWarningFrame"] = "TOP,ElvUIParent,TOP,0,-182"
	E.db["movers"]["TorghastChoiceToggle"] = "BOTTOM,ElvUIParent,BOTTOM,0,398"
	E.db["movers"]["AddonCompartmentMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-8,-5"
	E.db["movers"]["MinimapButtonAnchor"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,0,-223"
	E.db["movers"]["MinimapMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-6,-3"
	E.db["movers"]["MoverEltruismLootText"] = "BOTTOM,UIParent,BOTTOM,0,277"
	if not E.Modern then
		E.db["movers"]["MirrorTimer1Mover"] = "TOP,ElvUIParent,TOP,-1,-96"
	end

	--objective frame movers
	if E.Classic or E.TBC then
		E.db["movers"]["QuestTimerFrameMover"] = "TOPRIGHT,UIParent,TOPRIGHT,-111,-230"
		E.db["movers"]["QuestWatchFrameMover"] = "TOPRIGHT,UIParent,TOPRIGHT,-109,-337"
	elseif E.Mists or E.Wrath then
		E.db["movers"]["WatchFrameMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-115,-306"
		E.db["movers"]["ObjectiveFrameMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-75,-319"
	elseif E.Modern then
		E.db["movers"]["ObjectiveFrameMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-6,-245"
	end

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

	E.db["nameplates"]["colors"]["castColor"]["b"] = 0 --fix interruptable color
	E.db["nameplates"]["colors"]["castColor"]["g"] = 0.58823531866074
	E.db["nameplates"]["colors"]["castColor"]["r"] = 1

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
	E.db["general"]["minimap"]["icons"]["classHall"]["position"] = "BOTTOMLEFT"
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
		if not E.Modern then
			E.db["general"]["minimap"]["icons"]["mail"]["yOffset"] = -10
		end
	else
		if not E.Modern then
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
	E.db["general"]["totems"]["spacing"] = 5
	E.db["general"]["valuecolor"]["b"] = valuecolors.b
	E.db["general"]["valuecolor"]["g"] = valuecolors.g
	E.db["general"]["valuecolor"]["r"] = valuecolors.r
	E.db["general"]["taintLog"] = false

	E.db["unitframe"]["units"]["player"]["forcehealthreaction"] = false

	-- Bags
	E.db["bags"]["bagSize"] = 35
	E.db["bags"]["bagWidth"] = 412
	E.db["bags"]["bankSize"] = 35
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
	E.db["bags"]["transparent"] = true
	E.db["bags"]["vendorGrays"]["enable"] = true
	E.db["bags"]["moneyFormat"] = "SMART"
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
	--[[E.db["cooldown"]["daysColor"]["g"] = 1
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
	E.db["actionbar"]["cooldown"]["fonts"]["enable"] = false]]
	E.db["cooldown"]["actionbar"]["font"] = "Kimberley"
	E.db["cooldown"]["aurabars"]["font"] = "Kimberley"
	E.db["cooldown"]["auras"]["font"] = "Kimberley"
	E.db["cooldown"]["bags"]["font"] = "Kimberley"
	E.db["cooldown"]["bossbutton"]["font"] = "Kimberley"
	E.db["cooldown"]["cdmanager"]["font"] = "Kimberley"
	E.db["cooldown"]["global"]["font"] = "Kimberley"
	E.db["cooldown"]["nameplates"]["font"] = "Kimberley"
	E.db["cooldown"]["totemtracker"]["font"] = "Kimberley"
	E.db["cooldown"]["unitframe"]["font"] = "Kimberley"
	E.db["cooldown"]["zonebutton"]["font"] = "Kimberley"
	E.db["cooldown"]["actionbar"]["fontOutline"] = "THICKOUTLINE"
	E.db["cooldown"]["aurabars"]["fontOutline"] = "THICKOUTLINE"
	E.db["cooldown"]["auras"]["fontOutline"] = "THICKOUTLINE"
	E.db["cooldown"]["bags"]["fontOutline"] = "THICKOUTLINE"
	E.db["cooldown"]["bossbutton"]["fontOutline"] = "THICKOUTLINE"
	E.db["cooldown"]["cdmanager"]["fontOutline"] = "THICKOUTLINE"
	E.db["cooldown"]["global"]["fontOutline"] = "THICKOUTLINE"
	E.db["cooldown"]["nameplates"]["fontOutline"] = "THICKOUTLINE"
	E.db["cooldown"]["totemtracker"]["fontOutline"] = "THICKOUTLINE"
	E.db["cooldown"]["unitframe"]["fontOutline"] = "THICKOUTLINE"
	E.db["cooldown"]["zonebutton"]["fontOutline"] = "THICKOUTLINE"

	E.db["cooldown"]["actionbar"]["colors"]["edgeCharge"]["a"] = 0
	E.db["cooldown"]["actionbar"]["colors"]["edgeCharge"]["g"] = 0
	E.db["cooldown"]["actionbar"]["colors"]["edgeCharge"]["r"] = 0
	E.db["cooldown"]["actionbar"]["colors"]["edgeLOC"]["a"] = 0
	E.db["cooldown"]["actionbar"]["colors"]["edgeLOC"]["b"] = 0.80000007152557
	E.db["cooldown"]["actionbar"]["colors"]["edgeLOC"]["g"] = 0.20000001788139
	E.db["cooldown"]["actionbar"]["colors"]["swipeCharge"]["a"] = 0.21093778312206
	E.db["cooldown"]["actionbar"]["colors"]["swipeCharge"]["b"] = 0.59607845544815
	E.db["cooldown"]["actionbar"]["colors"]["swipeCharge"]["g"] = 1

	E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["sourceText"]["font"] = "Kimberley"
	E.db["nameplates"]["units"]["ENEMY_NPC"]["castbar"]["targetFont"] = "Kimberley"
	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["sourceText"]["font"] = "Kimberley"
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["buffs"]["sourceText"]["font"] = "Kimberley"
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["castbar"]["targetFont"] = "Kimberley"
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["buffs"]["sourceText"]["font"] = "Kimberley"
	E.db["nameplates"]["units"]["PLAYER"]["castbar"]["targetFont"] = "Kimberley"
	E.db["unitframe"]["units"]["arena"]["auras"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["arena"]["auras"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["arena"]["buffs"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["arena"]["debuffs"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["assist"]["auras"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["assist"]["auras"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["assist"]["buffs"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["assist"]["debuffs"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["boss"]["auras"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["boss"]["auras"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["boss"]["buffs"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["boss"]["debuffs"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["focus"]["auras"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["focus"]["auras"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["focus"]["buffs"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["focus"]["debuffs"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["focustarget"]["auras"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["focustarget"]["auras"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["focustarget"]["buffs"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["focustarget"]["debuffs"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["party"]["auras"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["party"]["auras"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["party"]["buffs"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["party"]["debuffs"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["pet"]["auras"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["pet"]["auras"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["pet"]["buffs"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["pet"]["debuffs"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["pettarget"]["auras"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["pettarget"]["auras"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["pettarget"]["buffs"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["pettarget"]["debuffs"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["player"]["auras"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["player"]["auras"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["player"]["buffs"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["player"]["debuffs"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["raid1"]["auras"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["raid1"]["auras"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["raid1"]["buffs"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["raid1"]["debuffs"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["raid2"]["auras"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["raid2"]["auras"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["raid2"]["buffs"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["raid2"]["debuffs"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["raid3"]["auras"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["raid3"]["auras"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["raid3"]["buffs"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["raid3"]["debuffs"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["raidpet"]["auras"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["raidpet"]["auras"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["raidpet"]["buffs"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["raidpet"]["debuffs"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["tank"]["auras"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["tank"]["auras"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["tank"]["buffs"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["tank"]["debuffs"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["target"]["auras"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["target"]["auras"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["target"]["buffs"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["target"]["debuffs"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["targettarget"]["auras"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["targettarget"]["auras"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["targettarget"]["buffs"]["sourceText"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["targettarget"]["debuffs"]["sourceText"]["font"] = "Kimberley"

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
	if E.Mists or E.TBC or E.Wrath or E.Classic then
		E.db["databars"]["threat"]["enable"] = true
	elseif E.Modern then
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
	if E.Modern then
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
	E.db["datatexts"]["panels"]["LeftChatDataPanel"]["border"] = false
	E.db["datatexts"]["panels"]["LeftChatDataPanel"]["panelTransparency"] = true
	E.db["datatexts"]["panels"]["LeftChatDataPanel"]["backdrop"] = false
	E.db["datatexts"]["panels"]["RightChatDataPanel"]["border"] = false
	E.db["datatexts"]["panels"]["RightChatDataPanel"]["panelTransparency"] = true
	E.db["datatexts"]["panels"]["RightChatDataPanel"]["backdrop"] = false
	if E.Retail then
		E.db["datatexts"]["panels"]["LeftChatDataPanel"][3] = "Missions"
		E.db["datatexts"]["panels"]["LeftChatDataPanel"]["right"] = "System"
		E.db["datatexts"]["panels"]["RightChatDataPanel"][2] = "Combat"
		E.db["datatexts"]["panels"]["RightChatDataPanel"]["border"] = false
		E.db["datatexts"]["panels"]["RightChatDataPanel"]["left"] = "Orderhall"
		E.db["datatexts"]["panels"]["RightChatDataPanel"]["middle"] = "BfA Missions"
		if IsAddOnLoaded("ElvUI_SLE") then
			E.db["datatexts"]["panels"]["MinimapPanel"][2] = "S&L Friends"
		else
			E.db["datatexts"]["panels"]["MinimapPanel"][2] = "Friends"
		end
	else
		if not E.Classic then
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
		E.db["datatexts"]["panels"]["LeftChatDataPanel"]["right"] = "Guild"
		E.db["datatexts"]["panels"]["MinimapPanel"][2] = "Coords"
		E.db["datatexts"]["panels"]["RightChatDataPanel"][2] = "Combat"
		E.db["datatexts"]["panels"]["RightChatDataPanel"]["left"] = "System"
		E.db["datatexts"]["panels"]["RightChatDataPanel"]["middle"] = "Combat Time"
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

	--issue with old tooltip itemCount
	if type(E.db.tooltip.itemCount) ~= "table" then
		E.db.tooltip.itemCount = {
			bags = false,
			bank = false,
			stack = false
		}
	else
		E.db["tooltip"]["itemCount"]["bags"] = false
		E.db["tooltip"]["itemCount"]["bank"] = false
		E.db["tooltip"]["itemCount"]["stack"] = false
	end
	E.db["tooltip"]["modifierID"] = "SHIFT"
	E.db["tooltip"]["showElvUIUsers"] = true
	E.db["tooltip"]["visibility"]["combatOverride"] = "CTRL"
	E.db["tooltip"]["headerFont"] = "Kimberley"
	E.db["tooltip"]["headerFontOutline"] = "OUTLINE"
	E.db["tooltip"]["headerFontSize"] = 12
	E.db["tooltip"]["itemQuality"] = true

	-- ActionBars general
	ElvUI_EltreumUI:ClearActionBarPaging(1)
	E.db["actionbar"]["addNewSpells"] = true
	E.db["actionbar"]["chargeCooldown"] = true
	E.db["actionbar"]["desaturateOnCooldown"] = true
	E.db["actionbar"]["equippedItem"] = false
	E.db["actionbar"]["font"] = "Kimberley"
	E.db["actionbar"]["globalFadeAlpha"] = 1
	E.db["actionbar"]["lockActionBars"] = true
	E.db["actionbar"]["noRangeColor"]["b"] = 0.11764705882353
	E.db["actionbar"]["noRangeColor"]["g"] = 0.11764705882353
	E.db["actionbar"]["noRangeColor"]["r"] = 1
	E.db["actionbar"]["rightClickSelfCast"] = true
	E.db["actionbar"]["transparent"] = true
	E.db["actionbar"]["useDrawSwipeOnCharges"] = true

	-- Bar 1
	E.db["actionbar"]["bar1"]["backdrop"] = false
	E.db["actionbar"]["bar1"]["buttonSpacing"] = 3
	E.db["actionbar"]["bar1"]["buttons"] = 7
	E.db["actionbar"]["bar1"]["countFont"] = "Kimberley"
	E.db["actionbar"]["bar1"]["counttext"] = true
	E.db["actionbar"]["bar1"]["heightMult"] = 1
	E.db["actionbar"]["bar1"]["hotkeyFont"] = "Kimberley"
	E.db["actionbar"]["bar1"]["hotkeytext"] = true
	E.db["actionbar"]["bar1"]["inheritGlobalFade"] = true
	E.db["actionbar"]["bar1"]["keepSizeRatio"] = false
	E.db["actionbar"]["bar1"]["macroFont"] = "Kimberley"
	E.db["actionbar"]["bar1"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"

	-- Bar 2
	E.db["actionbar"]["bar2"]["backdrop"] = false
	E.db["actionbar"]["bar2"]["buttonSpacing"] = 3
	E.db["actionbar"]["bar2"]["buttons"] = 12
	E.db["actionbar"]["bar2"]["countFont"] = "Kimberley"
	E.db["actionbar"]["bar2"]["counttext"] = true
	E.db["actionbar"]["bar2"]["enabled"] = true
	E.db["actionbar"]["bar2"]["heightMult"] = 1
	E.db["actionbar"]["bar2"]["hotkeyFont"] = "Kimberley"
	E.db["actionbar"]["bar2"]["hotkeytext"] = true
	E.db["actionbar"]["bar2"]["inheritGlobalFade"] = true
	E.db["actionbar"]["bar2"]["keepSizeRatio"] = false
	E.db["actionbar"]["bar2"]["macroFont"] = "Kimberley"
	E.db["actionbar"]["bar2"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"

	-- Bar 3
	E.db["actionbar"]["bar3"]["backdrop"] = false
	E.db["actionbar"]["bar3"]["buttonSpacing"] = 3
	E.db["actionbar"]["bar3"]["buttons"] = 12
	E.db["actionbar"]["bar3"]["countFont"] = "Kimberley"
	E.db["actionbar"]["bar3"]["counttext"] = true
	E.db["actionbar"]["bar3"]["heightMult"] = 1
	E.db["actionbar"]["bar3"]["hotkeyFont"] = "Kimberley"
	E.db["actionbar"]["bar3"]["hotkeytext"] = true
	E.db["actionbar"]["bar3"]["inheritGlobalFade"] = true
	E.db["actionbar"]["bar3"]["keepSizeRatio"] = false
	E.db["actionbar"]["bar3"]["macroFont"] = "Kimberley"
	E.db["actionbar"]["bar3"]["mouseover"] = false
	E.db["actionbar"]["bar3"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"

	-- Bar 4
	E.db["actionbar"]["bar4"]["backdrop"] = false
	E.db["actionbar"]["bar4"]["buttonSpacing"] = 3
	E.db["actionbar"]["bar4"]["buttons"] = 12
	E.db["actionbar"]["bar4"]["countFont"] = "Kimberley"
	E.db["actionbar"]["bar4"]["counttext"] = true
	E.db["actionbar"]["bar4"]["heightMult"] = 1
	E.db["actionbar"]["bar4"]["hotkeyFont"] = "Kimberley"
	E.db["actionbar"]["bar4"]["hotkeytext"] = true
	E.db["actionbar"]["bar4"]["inheritGlobalFade"] = true
	E.db["actionbar"]["bar4"]["keepSizeRatio"] = false
	E.db["actionbar"]["bar4"]["macroFont"] = "Kimberley"
	E.db["actionbar"]["bar4"]["mouseover"] = false
	E.db["actionbar"]["bar4"]["visibility"] = "[vehicleui] show; [overridebar] show; [possessbar] show; [petbattle] hide; show;"

	-- Bar 5
	E.db["actionbar"]["bar5"]["backdrop"] = false
	E.db["actionbar"]["bar5"]["buttons"] = 12
	E.db["actionbar"]["bar5"]["countFont"] = "Kimberley"
	E.db["actionbar"]["bar5"]["counttext"] = true
	E.db["actionbar"]["bar5"]["heightMult"] = 1
	E.db["actionbar"]["bar5"]["hotkeyFont"] = "Kimberley"
	E.db["actionbar"]["bar5"]["hotkeytext"] = true
	E.db["actionbar"]["bar5"]["inheritGlobalFade"] = true
	E.db["actionbar"]["bar5"]["keepSizeRatio"] = false
	E.db["actionbar"]["bar5"]["macroFont"] = "Kimberley"
	E.db["actionbar"]["bar5"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"

	-- Bar 6
	E.db["actionbar"]["bar6"]["alpha"] = 1
	E.db["actionbar"]["bar6"]["backdrop"] = false
	E.db["actionbar"]["bar6"]["buttonHeight"] = 24
	E.db["actionbar"]["bar6"]["buttons"] = 12
	E.db["actionbar"]["bar6"]["countFont"] = "Kimberley"
	E.db["actionbar"]["bar6"]["countFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar6"]["counttext"] = true
	E.db["actionbar"]["bar6"]["enabled"] = true
	E.db["actionbar"]["bar6"]["flyoutDirection"] = "UP"
	E.db["actionbar"]["bar6"]["heightMult"] = 1
	E.db["actionbar"]["bar6"]["hotkeyFont"] = "Kimberley"
	E.db["actionbar"]["bar6"]["hotkeyFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar6"]["hotkeytext"] = true
	E.db["actionbar"]["bar6"]["inheritGlobalFade"] = false
	E.db["actionbar"]["bar6"]["keepSizeRatio"] = false
	E.db["actionbar"]["bar6"]["macroFont"] = "Kimberley"
	E.db["actionbar"]["bar6"]["macroFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["bar6"]["macroTextPosition"] = "BOTTOM"
	E.db["actionbar"]["bar6"]["macroTextYOffset"] = 2
	E.db["actionbar"]["bar6"]["macrotext"] = true
	E.db["actionbar"]["bar6"]["mouseover"] = true

	-- Bar 7
	E.db["actionbar"]["bar7"]["countFont"] = "Kimberley"
	E.db["actionbar"]["bar7"]["enabled"] = false
	E.db["actionbar"]["bar7"]["hotkeyFont"] = "Kimberley"
	E.db["actionbar"]["bar7"]["inheritGlobalFade"] = false
	E.db["actionbar"]["bar7"]["macroFont"] = "Kimberley"
	E.db["actionbar"]["bar7"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"

	-- Bar 8
	E.db["actionbar"]["bar8"]["countFont"] = "Kimberley"
	E.db["actionbar"]["bar8"]["enabled"] = false
	E.db["actionbar"]["bar8"]["hotkeyFont"] = "Kimberley"
	E.db["actionbar"]["bar8"]["inheritGlobalFade"] = false
	E.db["actionbar"]["bar8"]["macroFont"] = "Kimberley"
	E.db["actionbar"]["bar8"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"

	-- Bar 9
	E.db["actionbar"]["bar9"]["countFont"] = "Kimberley"
	E.db["actionbar"]["bar9"]["enabled"] = false
	E.db["actionbar"]["bar9"]["hotkeyFont"] = "Kimberley"
	E.db["actionbar"]["bar9"]["inheritGlobalFade"] = false
	E.db["actionbar"]["bar9"]["macroFont"] = "Kimberley"
	E.db["actionbar"]["bar9"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"

	-- Bar 10
	E.db["actionbar"]["bar10"]["countFont"] = "Kimberley"
	E.db["actionbar"]["bar10"]["enabled"] = false
	E.db["actionbar"]["bar10"]["hotkeyFont"] = "Kimberley"
	E.db["actionbar"]["bar10"]["inheritGlobalFade"] = false
	E.db["actionbar"]["bar10"]["macroFont"] = "Kimberley"

	-- Pet Bar
	E.db["actionbar"]["barPet"]["buttons"] = 10
	E.db["actionbar"]["barPet"]["countFont"] = "Kimberley"
	E.db["actionbar"]["barPet"]["hotkeyFont"] = "Kimberley"
	E.db["actionbar"]["barPet"]["inheritGlobalFade"] = true
	E.db["actionbar"]["barPet"]["keepSizeRatio"] = false

	-- Stance Bar
	E.db["actionbar"]["stanceBar"]["backdrop"] = false
	E.db["actionbar"]["stanceBar"]["buttonHeight"] = 20
	E.db["actionbar"]["stanceBar"]["buttonSpacing"] = 3
	E.db["actionbar"]["stanceBar"]["hotkeyFont"] = "Kimberley"
	E.db["actionbar"]["stanceBar"]["hotkeyFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["stanceBar"]["inheritGlobalFade"] = true
	E.db["actionbar"]["stanceBar"]["keepSizeRatio"] = false
	E.db["actionbar"]["stanceBar"]["style"] = "classic"
	E.db["actionbar"]["stanceBar"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"

	-- Microbar
	E.db["actionbar"]["microbar"]["backdrop"] = true
	E.db["actionbar"]["microbar"]["buttonHeight"] = 25
	E.db["actionbar"]["microbar"]["buttonSize"] = 22
	E.db["actionbar"]["microbar"]["buttonSpacing"] = 0
	E.db["actionbar"]["microbar"]["buttonsPerRow"] = 11
	E.db["actionbar"]["microbar"]["enabled"] = false
	E.db["actionbar"]["microbar"]["mouseover"] = true
	E.db["actionbar"]["microbar"]["visibility"] = "[combat] hide; show"

	-- Special Action Buttons
	E.db["actionbar"]["extraActionButton"]["alpha"] = 0.7
	E.db["actionbar"]["extraActionButton"]["clean"] = true
	E.db["actionbar"]["extraActionButton"]["hotkeyFont"] = "Kimberley"
	E.db["actionbar"]["extraActionButton"]["hotkeyFontOutline"] = "THICKOUTLINE"
	E.db["actionbar"]["extraActionButton"]["inheritGlobalFade"] = false
	E.db["actionbar"]["extraActionButton"]["scale"] = 0.7
	E.db["actionbar"]["vehicleExitButton"]["hotkeyFont"] = "Kimberley"
	E.db["actionbar"]["zoneActionButton"]["alpha"] = 0.7
	E.db["actionbar"]["zoneActionButton"]["clean"] = true
	E.db["actionbar"]["zoneActionButton"]["inheritGlobalFade"] = false
	E.db["actionbar"]["zoneActionButton"]["scale"] = 0.7

	--unitframes general
	-- set Dynamic Status Icons
	if IsAddOnLoaded("ElvUI_DynamicStatusIcons") then
		E.db["unitframe"]["units"]["player"]["DynamicStatusIcons"]["anchorPoint"] = "BOTTOMRIGHT"
		E.db["unitframe"]["units"]["player"]["DynamicStatusIcons"]["color"]["b"] = 0.4274500310421
		E.db["unitframe"]["units"]["player"]["DynamicStatusIcons"]["color"]["g"] = 0.60784178972244
		E.db["unitframe"]["units"]["player"]["DynamicStatusIcons"]["color"]["r"] = 0.77646887302399
		E.db["unitframe"]["units"]["player"]["DynamicStatusIcons"]["faceright"] = true
		E.db["unitframe"]["units"]["player"]["DynamicStatusIcons"]["iconpack"] = "Default - Pepe - Traveler"
		E.db["unitframe"]["units"]["player"]["DynamicStatusIcons"]["scale"] = 0.8
		E.db["unitframe"]["units"]["target"]["DynamicStatusIcons"]["anchorPoint"] = "BOTTOMLEFT"
		E.db["unitframe"]["units"]["target"]["DynamicStatusIcons"]["color"]["b"] = 0.4274500310421
		E.db["unitframe"]["units"]["target"]["DynamicStatusIcons"]["color"]["g"] = 0.60784178972244
		E.db["unitframe"]["units"]["target"]["DynamicStatusIcons"]["color"]["r"] = 0.77646887302399
		E.db["unitframe"]["units"]["target"]["DynamicStatusIcons"]["iconpack"] = "Default - Pepe - Clockwork"
		E.db["unitframe"]["units"]["target"]["DynamicStatusIcons"]["scale"] = 0.8
	end

	-- Arena
	E.db["unitframe"]["units"]["arena"]["width"] = 250
	E.db["unitframe"]["units"]["arena"]["height"] = 50
	E.db["unitframe"]["units"]["arena"]["spacing"] = 10
	E.db["unitframe"]["units"]["arena"]["colorOverride"] = "FORCE_OFF"
	E.db["unitframe"]["units"]["arena"]["fader"]["minAlpha"] = 0.8
	E.db["unitframe"]["units"]["arena"]["middleClickFocus"] = true
	E.db["unitframe"]["units"]["arena"]["name"]["text_format"] = ""
	E.db["unitframe"]["units"]["arena"]["buffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["arena"]["buffs"]["countXOffset"] = 2
	E.db["unitframe"]["units"]["arena"]["buffs"]["countYOffset"] = -3
	E.db["unitframe"]["units"]["arena"]["buffs"]["durationPosition"] = "TOP"
	E.db["unitframe"]["units"]["arena"]["buffs"]["height"] = 25
	E.db["unitframe"]["units"]["arena"]["buffs"]["keepSizeRatio"] = false
	E.db["unitframe"]["units"]["arena"]["buffs"]["perrow"] = 6
	E.db["unitframe"]["units"]["arena"]["buffs"]["sizeOverride"] = 30
	E.db["unitframe"]["units"]["arena"]["buffs"]["xOffset"] = -3
	E.db["unitframe"]["units"]["arena"]["buffs"]["yOffset"] = 14
	E.db["unitframe"]["units"]["arena"]["debuffs"]["anchorPoint"] = "BOTTOM"
	E.db["unitframe"]["units"]["arena"]["debuffs"]["attachTo"] = "BUFFS"
	E.db["unitframe"]["units"]["arena"]["debuffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["arena"]["debuffs"]["countXOffset"] = 2
	E.db["unitframe"]["units"]["arena"]["debuffs"]["countYOffset"] = -3
	E.db["unitframe"]["units"]["arena"]["debuffs"]["height"] = 25
	E.db["unitframe"]["units"]["arena"]["debuffs"]["keepSizeRatio"] = false
	E.db["unitframe"]["units"]["arena"]["debuffs"]["perrow"] = 6
	E.db["unitframe"]["units"]["arena"]["debuffs"]["sizeOverride"] = 30
	E.db["unitframe"]["units"]["arena"]["debuffs"]["yOffset"] = -4
	E.db["unitframe"]["units"]["arena"]["castbar"]["customColor"]["enable"] = true
	E.db["unitframe"]["units"]["arena"]["castbar"]["height"] = 15
	E.db["unitframe"]["units"]["arena"]["castbar"]["overlayOnFrame"] = "InfoPanel"
	E.db["unitframe"]["units"]["arena"]["castbar"]["strataAndLevel"]["frameStrata"] = "HIGH"
	E.db["unitframe"]["units"]["arena"]["castbar"]["timeToHold"] = 0.6
	E.db["unitframe"]["units"]["arena"]["castbar"]["width"] = 250
	E.db["unitframe"]["units"]["arena"]["health"]["text_format"] = ""
	E.db["unitframe"]["units"]["arena"]["health"]["xOffset"] = 0
	E.db["unitframe"]["units"]["arena"]["infoPanel"]["enable"] = true
	E.db["unitframe"]["units"]["arena"]["infoPanel"]["height"] = 15
	E.db["unitframe"]["units"]["arena"]["infoPanel"]["transparent"] = true
	E.db["unitframe"]["units"]["arena"]["portrait"]["overlay"] = true
	E.db["unitframe"]["units"]["arena"]["portrait"]["style"] = "Class"
	E.db["unitframe"]["units"]["arena"]["power"]["attachTextTo"] = "Power"
	E.db["unitframe"]["units"]["arena"]["power"]["height"] = 14
	E.db["unitframe"]["units"]["arena"]["power"]["text_format"] = ""
	E.db["unitframe"]["units"]["arena"]["pvpTrinket"]["size"] = 50
	E.db["unitframe"]["units"]["arena"]["pvpTrinket"]["xOffset"] = 0
	E.db["unitframe"]["units"]["arena"]["pvpTrinket"]["yOffset"] = 8
	E.db["unitframe"]["units"]["arena"]["pvpclassificationindicator"]["size"] = 30

	-- Assist
	E.db["unitframe"]["units"]["assist"]["width"] = 120
	E.db["unitframe"]["units"]["assist"]["buffIndicator"]["enable"] = true
	E.db["unitframe"]["units"]["assist"]["colorOverride"] = "FORCE_OFF"
	E.db["unitframe"]["units"]["assist"]["buffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["assist"]["debuffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["assist"]["rdebuffs"]["font"] = "Kimberley"

	-- Boss
	E.db["unitframe"]["units"]["boss"]["width"] = 216
	E.db["unitframe"]["units"]["boss"]["height"] = 45
	E.db["unitframe"]["units"]["boss"]["spacing"] = 10
	E.db["unitframe"]["units"]["boss"]["colorOverride"] = "FORCE_OFF"
	E.db["unitframe"]["units"]["boss"]["threatStyle"] = "BORDERS"
	E.db["unitframe"]["units"]["boss"]["smartAuraPosition"] = "FLUID_BUFFS_ON_DEBUFFS"
	E.db["unitframe"]["units"]["boss"]["buffIndicator"]["size"] = 15
	E.db["unitframe"]["units"]["boss"]["buffs"]["anchorPoint"] = "TOPRIGHT"
	E.db["unitframe"]["units"]["boss"]["buffs"]["attachTo"] = "DEBUFFS"
	E.db["unitframe"]["units"]["boss"]["buffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["boss"]["buffs"]["countXOffset"] = 2
	E.db["unitframe"]["units"]["boss"]["buffs"]["countYOffset"] = -3
	E.db["unitframe"]["units"]["boss"]["buffs"]["durationPosition"] = "TOP"
	E.db["unitframe"]["units"]["boss"]["buffs"]["growthX"] = "LEFT"
	E.db["unitframe"]["units"]["boss"]["buffs"]["height"] = 25
	E.db["unitframe"]["units"]["boss"]["buffs"]["keepSizeRatio"] = false
	E.db["unitframe"]["units"]["boss"]["buffs"]["perrow"] = 7
	E.db["unitframe"]["units"]["boss"]["buffs"]["sizeOverride"] = 30
	E.db["unitframe"]["units"]["boss"]["buffs"]["spacing"] = 2
	E.db["unitframe"]["units"]["boss"]["buffs"]["xOffset"] = -1
	E.db["unitframe"]["units"]["boss"]["buffs"]["yOffset"] = 5
	E.db["unitframe"]["units"]["boss"]["debuffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["boss"]["debuffs"]["countXOffset"] = 2
	E.db["unitframe"]["units"]["boss"]["debuffs"]["countYOffset"] = -3
	E.db["unitframe"]["units"]["boss"]["debuffs"]["durationPosition"] = "TOP"
	E.db["unitframe"]["units"]["boss"]["debuffs"]["growthX"] = "LEFT"
	E.db["unitframe"]["units"]["boss"]["debuffs"]["height"] = 25
	E.db["unitframe"]["units"]["boss"]["debuffs"]["keepSizeRatio"] = false
	E.db["unitframe"]["units"]["boss"]["debuffs"]["perrow"] = 7
	E.db["unitframe"]["units"]["boss"]["debuffs"]["sizeOverride"] = 30
	E.db["unitframe"]["units"]["boss"]["debuffs"]["spacing"] = 2
	E.db["unitframe"]["units"]["boss"]["debuffs"]["xOffset"] = -3
	E.db["unitframe"]["units"]["boss"]["debuffs"]["yOffset"] = -16
	E.db["unitframe"]["units"]["boss"]["castbar"]["overlayOnFrame"] = "InfoPanel"
	E.db["unitframe"]["units"]["boss"]["castbar"]["customColor"]["enable"] = true
	E.db["unitframe"]["units"]["boss"]["fader"]["enable"] = false
	E.db["unitframe"]["units"]["boss"]["fader"]["minAlpha"] = 0.3
	E.db["unitframe"]["units"]["boss"]["fader"]["playertarget"] = true
	E.db["unitframe"]["units"]["boss"]["fader"]["range"] = false
	E.db["unitframe"]["units"]["boss"]["health"]["attachTextTo"] = "InfoPanel"
	E.db["unitframe"]["units"]["boss"]["health"]["position"] = "RIGHT"
	E.db["unitframe"]["units"]["boss"]["health"]["text_format"] = "[healthcolor][eltruism:hpstatusnopc:gradient]"
	E.db["unitframe"]["units"]["boss"]["health"]["xOffset"] = 0
	E.db["unitframe"]["units"]["boss"]["infoPanel"]["enable"] = true
	E.db["unitframe"]["units"]["boss"]["infoPanel"]["height"] = 12
	E.db["unitframe"]["units"]["boss"]["infoPanel"]["transparent"] = true
	E.db["unitframe"]["units"]["boss"]["name"]["attachTextTo"] = "InfoPanel"
	E.db["unitframe"]["units"]["boss"]["name"]["position"] = "LEFT"
	E.db["unitframe"]["units"]["boss"]["name"]["text_format"] = "[name:eltruism:gradient]"
	E.db["unitframe"]["units"]["boss"]["portrait"]["enable"] = true
	E.db["unitframe"]["units"]["boss"]["portrait"]["fullOverlay"] = true
	E.db["unitframe"]["units"]["boss"]["portrait"]["overlay"] = true
	E.db["unitframe"]["units"]["boss"]["portrait"]["overlayAlpha"] = 0.2
	E.db["unitframe"]["units"]["boss"]["power"]["attachTextTo"] = "Power"
	E.db["unitframe"]["units"]["boss"]["power"]["height"] = 12
	E.db["unitframe"]["units"]["boss"]["power"]["xOffset"] = 0
	E.db["unitframe"]["units"]["boss"]["power"]["yOffset"] = 1
	E.db["unitframe"]["units"]["boss"]["raidicon"]["attachTo"] = "CENTER"
	E.db["unitframe"]["units"]["boss"]["raidicon"]["size"] = 24
	E.db["unitframe"]["units"]["boss"]["raidicon"]["yOffset"] = 12

	-- Focus
	E.db["unitframe"]["units"]["focus"]["width"] = 190
	E.db["unitframe"]["units"]["focus"]["height"] = 35
	E.db["unitframe"]["units"]["focus"]["disableMouseoverGlow"] = true
	E.db["unitframe"]["units"]["focus"]["disableTargetGlow"] = true
	E.db["unitframe"]["units"]["focus"]["buffIndicator"]["size"] = 20
	E.db["unitframe"]["units"]["focus"]["castbar"]["customColor"]["colorBackdrop"]["a"] = 0
	E.db["unitframe"]["units"]["focus"]["castbar"]["customColor"]["invertColors"] = false
	E.db["unitframe"]["units"]["focus"]["castbar"]["customColor"]["useClassColor"] = true
	E.db["unitframe"]["units"]["focus"]["castbar"]["customColor"]["useCustomBackdrop"] = true
	E.db["unitframe"]["units"]["focus"]["castbar"]["height"] = 30
	E.db["unitframe"]["units"]["focus"]["castbar"]["strataAndLevel"]["frameStrata"] = "DIALOG"
	E.db["unitframe"]["units"]["focus"]["castbar"]["timeToHold"] = 0.6
	E.db["unitframe"]["units"]["focus"]["castbar"]["width"] = 333
	E.db["unitframe"]["units"]["focus"]["debuffs"]["anchorPoint"] = "TOP"
	E.db["unitframe"]["units"]["focus"]["debuffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["focus"]["debuffs"]["countFontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["focus"]["debuffs"]["countXOffset"] = 2
	E.db["unitframe"]["units"]["focus"]["debuffs"]["countYOffset"] = -3
	E.db["unitframe"]["units"]["focus"]["debuffs"]["durationPosition"] = "TOP"
	E.db["unitframe"]["units"]["focus"]["debuffs"]["height"] = 25
	E.db["unitframe"]["units"]["focus"]["debuffs"]["keepSizeRatio"] = false
	E.db["unitframe"]["units"]["focus"]["debuffs"]["sizeOverride"] = 30
	E.db["unitframe"]["units"]["focus"]["infoPanel"]["enable"] = true
	E.db["unitframe"]["units"]["focus"]["name"]["text_format"] = "[name:eltruism:gradientshort] [eltruism:class:player] [eltruism:raidmarker]"
	E.db["unitframe"]["units"]["focus"]["power"]["attachTextTo"] = "Power"
	E.db["unitframe"]["units"]["focus"]["power"]["height"] = 14
	E.db["unitframe"]["units"]["focus"]["power"]["position"] = "RIGHT"
	E.db["unitframe"]["units"]["focus"]["power"]["text_format"] = "[powercolor][power:current:shortvalue]"
	E.db["unitframe"]["units"]["focus"]["power"]["width"] = "spaced"
	E.db["unitframe"]["units"]["focus"]["power"]["xOffset"] = -7

	-- Party
	E.db["unitframe"]["units"]["party"]["width"] = 200
	E.db["unitframe"]["units"]["party"]["height"] = 60
	E.db["unitframe"]["units"]["party"]["colorOverride"] = "FORCE_OFF"
	E.db["unitframe"]["units"]["party"]["groupBy"] = "ROLE"
	E.db["unitframe"]["units"]["party"]["healPrediction"]["enable"] = true
	E.db["unitframe"]["units"]["party"]["visibility"] = "[@raid6,exists][@party1,noexists] hide;show"
	E.db["unitframe"]["units"]["party"]["buffIndicator"]["enable"] = true
	E.db["unitframe"]["units"]["party"]["buffs"]["anchorPoint"] = "TOP"
	E.db["unitframe"]["units"]["party"]["buffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["party"]["buffs"]["countXOffset"] = 2
	E.db["unitframe"]["units"]["party"]["buffs"]["countYOffset"] = -3
	E.db["unitframe"]["units"]["party"]["buffs"]["durationPosition"] = "TOP"
	E.db["unitframe"]["units"]["party"]["buffs"]["height"] = 25
	E.db["unitframe"]["units"]["party"]["buffs"]["keepSizeRatio"] = false
	E.db["unitframe"]["units"]["party"]["buffs"]["perrow"] = 6
	E.db["unitframe"]["units"]["party"]["castbar"]["customColor"]["colorBackdrop"]["b"] = 0
	E.db["unitframe"]["units"]["party"]["castbar"]["customColor"]["colorBackdrop"]["g"] = 0
	E.db["unitframe"]["units"]["party"]["castbar"]["customColor"]["colorBackdrop"]["r"] = 0
	E.db["unitframe"]["units"]["party"]["castbar"]["customColor"]["enable"] = true
	E.db["unitframe"]["units"]["party"]["castbar"]["customColor"]["transparent"] = false
	E.db["unitframe"]["units"]["party"]["castbar"]["customColor"]["useClassColor"] = true
	E.db["unitframe"]["units"]["party"]["castbar"]["customColor"]["useCustomBackdrop"] = true
	E.db["unitframe"]["units"]["party"]["castbar"]["customTextFont"]["enable"] = true
	E.db["unitframe"]["units"]["party"]["castbar"]["customTextFont"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["party"]["castbar"]["enable"] = true
	E.db["unitframe"]["units"]["party"]["castbar"]["height"] = 15
	E.db["unitframe"]["units"]["party"]["castbar"]["overlayOnFrame"] = "InfoPanel"
	E.db["unitframe"]["units"]["party"]["castbar"]["positionsGroup"]["anchorPoint"] = "LEFT"
	E.db["unitframe"]["units"]["party"]["castbar"]["textColor"]["b"] = 1
	E.db["unitframe"]["units"]["party"]["castbar"]["textColor"]["g"] = 1
	E.db["unitframe"]["units"]["party"]["castbar"]["textColor"]["r"] = 1
	E.db["unitframe"]["units"]["party"]["castbar"]["timeToHold"] = 0.6
	E.db["unitframe"]["units"]["party"]["castbar"]["width"] = 200
	E.db["unitframe"]["units"]["party"]["castbar"]["xOffsetText"] = 2
	E.db["unitframe"]["units"]["party"]["debuffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["party"]["debuffs"]["countFontSize"] = 10
	E.db["unitframe"]["units"]["party"]["debuffs"]["countXOffset"] = 2
	E.db["unitframe"]["units"]["party"]["debuffs"]["countYOffset"] = -3
	E.db["unitframe"]["units"]["party"]["debuffs"]["durationPosition"] = "TOP"
	E.db["unitframe"]["units"]["party"]["debuffs"]["height"] = 25
	E.db["unitframe"]["units"]["party"]["debuffs"]["keepSizeRatio"] = false
	E.db["unitframe"]["units"]["party"]["debuffs"]["numrows"] = 2
	E.db["unitframe"]["units"]["party"]["health"]["position"] = "RIGHT"
	E.db["unitframe"]["units"]["party"]["health"]["text_format"] = ""
	E.db["unitframe"]["units"]["party"]["health"]["xOffset"] = 0
	E.db["unitframe"]["units"]["party"]["infoPanel"]["enable"] = true
	E.db["unitframe"]["units"]["party"]["infoPanel"]["transparent"] = true
	E.db["unitframe"]["units"]["party"]["name"]["attachTextTo"] = "InfoPanel"
	E.db["unitframe"]["units"]["party"]["name"]["position"] = "LEFT"
	E.db["unitframe"]["units"]["party"]["name"]["text_format"] = ""
	E.db["unitframe"]["units"]["party"]["portrait"]["desaturation"] = 0.7
	E.db["unitframe"]["units"]["party"]["portrait"]["fullOverlay"] = true
	E.db["unitframe"]["units"]["party"]["portrait"]["overlay"] = true
	E.db["unitframe"]["units"]["party"]["portrait"]["paused"] = true
	E.db["unitframe"]["units"]["party"]["power"]["attachTextTo"] = "Power"
	E.db["unitframe"]["units"]["party"]["power"]["text_format"] = ""
	E.db["unitframe"]["units"]["party"]["power"]["xOffset"] = 0
	E.db["unitframe"]["units"]["party"]["raidRoleIcons"]["scale"] = 1
	E.db["unitframe"]["units"]["party"]["raidRoleIcons"]["xOffset"] = 0
	E.db["unitframe"]["units"]["party"]["raidicon"]["enable"] = false
	E.db["unitframe"]["units"]["party"]["raidicon"]["yOffset"] = 0
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["party"]["petsGroup"]["buffIndicator"]["enable"] = true
	E.db["unitframe"]["units"]["party"]["petsGroup"]["enable"] = false
	E.db["unitframe"]["units"]["party"]["petsGroup"]["healPrediction"]["enable"] = true

	-- Pet
	E.db["unitframe"]["units"]["pet"]["colorOverride"] = "FORCE_OFF"
	E.db["unitframe"]["units"]["pet"]["health"]["colorHappiness"] = false
	E.db["unitframe"]["units"]["pet"]["health"]["colorPetByUnitClass"] = false
	E.db["unitframe"]["units"]["pet"]["disableTargetGlow"] = false
	E.db["unitframe"]["units"]["pet"]["name"]["text_format"] = ""
	E.db["unitframe"]["units"]["pet"]["buffIndicator"]["size"] = 15
	E.db["unitframe"]["units"]["pet"]["buffs"]["anchorPoint"] = "TOP"
	E.db["unitframe"]["units"]["pet"]["buffs"]["attachTo"] = "FRAME"
	E.db["unitframe"]["units"]["pet"]["buffs"]["enable"] = true
	E.db["unitframe"]["units"]["pet"]["buffs"]["growthX"] = "LEFT"
	E.db["unitframe"]["units"]["pet"]["buffs"]["height"] = 25
	E.db["unitframe"]["units"]["pet"]["buffs"]["keepSizeRatio"] = false
	E.db["unitframe"]["units"]["pet"]["buffs"]["sizeOverride"] = 30
	E.db["unitframe"]["units"]["pet"]["buffs"]["spacing"] = 1
	E.db["unitframe"]["units"]["pet"]["buffs"]["xOffset"] = 0
	E.db["unitframe"]["units"]["pet"]["buffs"]["yOffset"] = 2
	E.db["unitframe"]["units"]["pet"]["debuffs"]["anchorPoint"] = "TOP"
	E.db["unitframe"]["units"]["pet"]["debuffs"]["attachTo"] = "BUFFS"
	E.db["unitframe"]["units"]["pet"]["debuffs"]["enable"] = true
	E.db["unitframe"]["units"]["pet"]["debuffs"]["height"] = 25
	E.db["unitframe"]["units"]["pet"]["debuffs"]["keepSizeRatio"] = false
	E.db["unitframe"]["units"]["pet"]["debuffs"]["sizeOverride"] = 30
	E.db["unitframe"]["units"]["pet"]["debuffs"]["yOffset"] = 1
	E.db["unitframe"]["units"]["pet"]["castbar"]["customColor"]["color"]["b"] = 0
	E.db["unitframe"]["units"]["pet"]["castbar"]["customColor"]["color"]["g"] = 0.50588235294118
	E.db["unitframe"]["units"]["pet"]["castbar"]["customColor"]["color"]["r"] = 0.86274509803922
	E.db["unitframe"]["units"]["pet"]["castbar"]["customColor"]["colorBackdrop"]["a"] = 0
	E.db["unitframe"]["units"]["pet"]["castbar"]["customColor"]["colorBackdrop"]["b"] = 0.50196078431373
	E.db["unitframe"]["units"]["pet"]["castbar"]["customColor"]["colorBackdrop"]["g"] = 0.50196078431373
	E.db["unitframe"]["units"]["pet"]["castbar"]["customColor"]["colorBackdrop"]["r"] = 0.50196078431373
	E.db["unitframe"]["units"]["pet"]["castbar"]["customColor"]["enable"] = true
	E.db["unitframe"]["units"]["pet"]["castbar"]["customColor"]["invertColors"] = false
	E.db["unitframe"]["units"]["pet"]["castbar"]["customColor"]["transparent"] = false
	E.db["unitframe"]["units"]["pet"]["castbar"]["customColor"]["useClassColor"] = true
	E.db["unitframe"]["units"]["pet"]["castbar"]["customColor"]["useCustomBackdrop"] = true
	E.db["unitframe"]["units"]["pet"]["castbar"]["height"] = 15
	E.db["unitframe"]["units"]["pet"]["castbar"]["overlayOnFrame"] = "Health"
	E.db["unitframe"]["units"]["pet"]["castbar"]["timeToHold"] = 0.6
	E.db["unitframe"]["units"]["pet"]["fader"]["casting"] = true
	E.db["unitframe"]["units"]["pet"]["fader"]["combat"] = true
	E.db["unitframe"]["units"]["pet"]["fader"]["health"] = true
	E.db["unitframe"]["units"]["pet"]["fader"]["hover"] = true
	E.db["unitframe"]["units"]["pet"]["fader"]["minAlpha"] = 0
	E.db["unitframe"]["units"]["pet"]["fader"]["playertarget"] = true
	E.db["unitframe"]["units"]["pet"]["fader"]["power"] = true
	E.db["unitframe"]["units"]["pet"]["fader"]["range"] = false
	E.db["unitframe"]["units"]["pet"]["fader"]["unittarget"] = true
	E.db["unitframe"]["units"]["pet"]["fader"]["vehicle"] = true
	E.db["unitframe"]["units"]["pet"]["power"]["text_format"] = ""
	E.db["unitframe"]["units"]["pet"]["power"]["width"] = "inset"

	-- Player
	E.db["unitframe"]["units"]["player"]["width"] = 270
	E.db["unitframe"]["units"]["player"]["colorOverride"] = "FORCE_OFF"
	E.db["unitframe"]["units"]["player"]["disableMouseoverGlow"] = true
	E.db["unitframe"]["units"]["player"]["healPrediction"]["enable"] = true
	E.db["unitframe"]["units"]["player"]["healPrediction"]["absorbStyle"] = "REVERSED"
	E.db["unitframe"]["units"]["player"]["healPrediction"]["anchorPoint"] = "CENTER"
	E.db["unitframe"]["units"]["player"]["fader"]["enable"] = true
	E.db["unitframe"]["units"]["player"]["fader"]["minAlpha"] = 0
	E.db["unitframe"]["units"]["player"]["health"]["position"] = "RIGHT"
	E.db["unitframe"]["units"]["player"]["health"]["text_format"] = ""
	E.db["unitframe"]["units"]["player"]["health"]["xOffset"] = 0
	E.db["unitframe"]["units"]["player"]["name"]["position"] = "LEFT"
	E.db["unitframe"]["units"]["player"]["name"]["text_format"] = ""
	E.db["unitframe"]["units"]["player"]["aurabar"]["attachTo"] = "FRAME"
	E.db["unitframe"]["units"]["player"]["aurabar"]["sortDirection"] = "ASCENDING"
	E.db["unitframe"]["units"]["player"]["aurabar"]["spacing"] = 2
	E.db["unitframe"]["units"]["player"]["aurabar"]["yOffset"] = 1
	E.db["unitframe"]["units"]["player"]["buffs"]["attachTo"] = "FRAME"
	E.db["unitframe"]["units"]["player"]["buffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["player"]["buffs"]["countFontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["player"]["buffs"]["height"] = 25
	E.db["unitframe"]["units"]["player"]["buffs"]["keepSizeRatio"] = false
	E.db["unitframe"]["units"]["player"]["buffs"]["sizeOverride"] = 30
	E.db["unitframe"]["units"]["player"]["debuffs"]["anchorPoint"] = "BOTTOM"
	E.db["unitframe"]["units"]["player"]["debuffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["player"]["debuffs"]["countXOffset"] = 2
	E.db["unitframe"]["units"]["player"]["debuffs"]["height"] = 25
	E.db["unitframe"]["units"]["player"]["debuffs"]["keepSizeRatio"] = false
	E.db["unitframe"]["units"]["player"]["debuffs"]["sizeOverride"] = 30
	E.db["unitframe"]["units"]["player"]["castbar"]["customColor"]["transparent"] = true
	E.db["unitframe"]["units"]["player"]["castbar"]["customColor"]["useClassColor"] = true
	E.db["unitframe"]["units"]["player"]["castbar"]["customColor"]["useCustomBackdrop"] = true
	E.db["unitframe"]["units"]["player"]["castbar"]["iconAttached"] = false
	E.db["unitframe"]["units"]["player"]["castbar"]["iconAttachedTo"] = "Castbar"
	E.db["unitframe"]["units"]["player"]["castbar"]["iconXOffset"] = 0
	E.db["unitframe"]["units"]["player"]["castbar"]["timeToHold"] = 0.6
	E.db["unitframe"]["units"]["player"]["classbar"]["fill"] = "spaced"
	E.db["unitframe"]["units"]["player"]["portrait"]["camDistanceScale"] = 4.2
	E.db["unitframe"]["units"]["player"]["portrait"]["enable"] = true
	E.db["unitframe"]["units"]["player"]["portrait"]["fullOverlay"] = true
	E.db["unitframe"]["units"]["player"]["portrait"]["overlay"] = true
	E.db["unitframe"]["units"]["player"]["portrait"]["overlayAlpha"] = 0.3
	E.db["unitframe"]["units"]["player"]["portrait"]["style"] = "3D"
	E.db["unitframe"]["units"]["player"]["power"]["EnergyManaRegen"] = true --tbc/classic only
	E.db["unitframe"]["units"]["player"]["power"]["attachTextTo"] = "Power"
	E.db["unitframe"]["units"]["player"]["power"]["strataAndLevel"]["useCustomLevel"] = false
	E.db["unitframe"]["units"]["player"]["power"]["strataAndLevel"]["useCustomStrata"] = false
	E.db["unitframe"]["units"]["player"]["power"]["text_format"] = ""
	E.db["unitframe"]["units"]["player"]["power"]["width"] = "spaced"
	E.db["unitframe"]["units"]["player"]["power"]["xOffset"] = 0
	E.db["unitframe"]["units"]["player"]["pvp"]["position"] = "CENTER"
	E.db["unitframe"]["units"]["player"]["pvp"]["text_format"] = ""
	E.db["unitframe"]["units"]["player"]["raidicon"]["attachToObject"] = "Health"
	E.db["unitframe"]["units"]["player"]["raidicon"]["enable"] = false

	-- Raid 1
	E.db["unitframe"]["units"]["raid1"]["width"] = 120
	E.db["unitframe"]["units"]["raid1"]["numGroups"] = 4
	E.db["unitframe"]["units"]["raid1"]["colorOverride"] = "FORCE_OFF"
	E.db["unitframe"]["units"]["raid1"]["growthDirection"] = "DOWN_RIGHT"
	E.db["unitframe"]["units"]["raid1"]["horizontalSpacing"] = 0
	E.db["unitframe"]["units"]["raid1"]["buffIndicator"]["enable"] = true
	E.db["unitframe"]["units"]["raid1"]["buffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["raid1"]["buffs"]["countFontSize"] = 8
	E.db["unitframe"]["units"]["raid1"]["buffs"]["countYOffset"] = -3
	E.db["unitframe"]["units"]["raid1"]["buffs"]["durationPosition"] = "TOP"
	E.db["unitframe"]["units"]["raid1"]["buffs"]["height"] = 15
	E.db["unitframe"]["units"]["raid1"]["buffs"]["keepSizeRatio"] = false
	E.db["unitframe"]["units"]["raid1"]["buffs"]["sizeOverride"] = 20
	E.db["unitframe"]["units"]["raid1"]["debuffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["raid1"]["debuffs"]["countFontSize"] = 8
	E.db["unitframe"]["units"]["raid1"]["debuffs"]["countYOffset"] = -3
	E.db["unitframe"]["units"]["raid1"]["debuffs"]["growthY"] = "DOWN"
	E.db["unitframe"]["units"]["raid1"]["debuffs"]["height"] = 15
	E.db["unitframe"]["units"]["raid1"]["debuffs"]["keepSizeRatio"] = false
	E.db["unitframe"]["units"]["raid1"]["health"]["text_format"] = ""
	E.db["unitframe"]["units"]["raid1"]["infoPanel"]["enable"] = true
	E.db["unitframe"]["units"]["raid1"]["infoPanel"]["transparent"] = true
	E.db["unitframe"]["units"]["raid1"]["name"]["attachTextTo"] = "InfoPanel"
	E.db["unitframe"]["units"]["raid1"]["name"]["position"] = "LEFT"
	E.db["unitframe"]["units"]["raid1"]["name"]["text_format"] = ""
	E.db["unitframe"]["units"]["raid1"]["power"]["enable"] = false
	E.db["unitframe"]["units"]["raid1"]["portrait"]["desaturation"] = 0.7
	E.db["unitframe"]["units"]["raid1"]["portrait"]["fullOverlay"] = true
	E.db["unitframe"]["units"]["raid1"]["portrait"]["overlayAlpha"] = 0.6
	E.db["unitframe"]["units"]["raid1"]["portrait"]["paused"] = true
	E.db["unitframe"]["units"]["raid1"]["raidicon"]["attachToObject"] = "Health"
	E.db["unitframe"]["units"]["raid1"]["raidicon"]["size"] = 12
	E.db["unitframe"]["units"]["raid1"]["rdebuffs"]["duration"]["yOffset"] = 3
	E.db["unitframe"]["units"]["raid1"]["rdebuffs"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["raid1"]["rdebuffs"]["stack"]["yOffset"] = -3
	E.db["unitframe"]["units"]["raid1"]["roleIcon"]["position"] = "TOPRIGHT"
	E.db["unitframe"]["units"]["raid1"]["roleIcon"]["size"] = 12
	E.db["unitframe"]["units"]["raid1"]["roleIcon"]["yOffset"] = -1
	E.db["unitframe"]["units"]["raid1"]["summonIcon"]["attachToObject"] = "Health"
	E.db["unitframe"]["units"]["raid1"]["visibility"] = "[@raid6,noexists][@raid21,exists] hide;show"
	if not E.Retail then
		E.db["unitframe"]["units"]["raid1"]["visibility"] = "[@raid6,noexists][@raid11,exists] hide;show"
	end

	-- Raid 2
	E.db["unitframe"]["units"]["raid2"]["width"] = 120
	E.db["unitframe"]["units"]["raid2"]["numGroups"] = 6
	E.db["unitframe"]["units"]["raid2"]["colorOverride"] = "FORCE_OFF"
	E.db["unitframe"]["units"]["raid2"]["growthDirection"] = "DOWN_RIGHT"
	E.db["unitframe"]["units"]["raid2"]["buffIndicator"]["enable"] = true
	E.db["unitframe"]["units"]["raid2"]["buffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["raid2"]["buffs"]["countFontSize"] = 8
	E.db["unitframe"]["units"]["raid2"]["buffs"]["countYOffset"] = -3
	E.db["unitframe"]["units"]["raid2"]["buffs"]["durationPosition"] = "TOP"
	E.db["unitframe"]["units"]["raid2"]["buffs"]["height"] = 15
	E.db["unitframe"]["units"]["raid2"]["buffs"]["keepSizeRatio"] = false
	E.db["unitframe"]["units"]["raid2"]["buffs"]["sizeOverride"] = 20
	E.db["unitframe"]["units"]["raid2"]["debuffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["raid2"]["debuffs"]["countFontSize"] = 8
	E.db["unitframe"]["units"]["raid2"]["debuffs"]["countYOffset"] = -3
	E.db["unitframe"]["units"]["raid2"]["debuffs"]["growthY"] = "DOWN"
	E.db["unitframe"]["units"]["raid2"]["debuffs"]["height"] = 15
	E.db["unitframe"]["units"]["raid2"]["debuffs"]["keepSizeRatio"] = false
	E.db["unitframe"]["units"]["raid2"]["health"]["text_format"] = ""
	E.db["unitframe"]["units"]["raid2"]["infoPanel"]["enable"] = true
	E.db["unitframe"]["units"]["raid2"]["infoPanel"]["transparent"] = true
	E.db["unitframe"]["units"]["raid2"]["name"]["attachTextTo"] = "InfoPanel"
	E.db["unitframe"]["units"]["raid2"]["name"]["position"] = "LEFT"
	E.db["unitframe"]["units"]["raid2"]["name"]["text_format"] = ""
	E.db["unitframe"]["units"]["raid2"]["power"]["enable"] = false
	E.db["unitframe"]["units"]["raid2"]["portrait"]["desaturation"] = 0.7
	E.db["unitframe"]["units"]["raid2"]["portrait"]["fullOverlay"] = true
	E.db["unitframe"]["units"]["raid2"]["portrait"]["overlayAlpha"] = 0.6
	E.db["unitframe"]["units"]["raid2"]["portrait"]["paused"] = true
	E.db["unitframe"]["units"]["raid2"]["raidicon"]["attachToObject"] = "Health"
	E.db["unitframe"]["units"]["raid2"]["raidicon"]["size"] = 12
	E.db["unitframe"]["units"]["raid2"]["rdebuffs"]["duration"]["yOffset"] = 3
	E.db["unitframe"]["units"]["raid2"]["rdebuffs"]["enable"] = true
	E.db["unitframe"]["units"]["raid2"]["rdebuffs"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["raid2"]["rdebuffs"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["raid2"]["rdebuffs"]["stack"]["yOffset"] = -3
	E.db["unitframe"]["units"]["raid2"]["rdebuffs"]["yOffset"] = 14
	E.db["unitframe"]["units"]["raid2"]["roleIcon"]["enable"] = true
	E.db["unitframe"]["units"]["raid2"]["roleIcon"]["position"] = "TOPRIGHT"
	E.db["unitframe"]["units"]["raid2"]["roleIcon"]["size"] = 12
	E.db["unitframe"]["units"]["raid2"]["roleIcon"]["yOffset"] = -1
	E.db["unitframe"]["units"]["raid2"]["summonIcon"]["attachToObject"] = "Health"
	E.db["unitframe"]["units"]["raid2"]["visibility"] = "[@raid21,noexists][@raid31,exists] hide;show"
	if not E.Retail then
		E.db["unitframe"]["units"]["raid2"]["numGroups"] = 5
		E.db["unitframe"]["units"]["raid2"]["visibility"] = "[@raid11,noexists][@raid26,exists] hide;show"
	end

	-- Raid 3
	E.db["unitframe"]["units"]["raid3"]["colorOverride"] = "FORCE_OFF"
	E.db["unitframe"]["units"]["raid3"]["growthDirection"] = "DOWN_RIGHT"
	E.db["unitframe"]["units"]["raid3"]["buffIndicator"]["enable"] = true
	E.db["unitframe"]["units"]["raid3"]["health"]["text_format"] = ""
	E.db["unitframe"]["units"]["raid3"]["health"]["xOffset"] = 0
	E.db["unitframe"]["units"]["raid3"]["infoPanel"]["enable"] = true
	E.db["unitframe"]["units"]["raid3"]["infoPanel"]["transparent"] = true
	E.db["unitframe"]["units"]["raid3"]["name"]["attachTextTo"] = "InfoPanel"
	E.db["unitframe"]["units"]["raid3"]["name"]["text_format"] = ""
	E.db["unitframe"]["units"]["raid3"]["power"]["enable"] = false
	E.db["unitframe"]["units"]["raid3"]["portrait"]["desaturation"] = 0.7
	E.db["unitframe"]["units"]["raid3"]["portrait"]["fullOverlay"] = true
	E.db["unitframe"]["units"]["raid3"]["portrait"]["overlayAlpha"] = 0.6
	E.db["unitframe"]["units"]["raid3"]["portrait"]["paused"] = true
	E.db["unitframe"]["units"]["raid3"]["raidicon"]["attachToObject"] = "Health"
	E.db["unitframe"]["units"]["raid3"]["raidicon"]["size"] = 12
	E.db["unitframe"]["units"]["raid3"]["rdebuffs"]["duration"]["position"] = "TOP"
	E.db["unitframe"]["units"]["raid3"]["rdebuffs"]["duration"]["yOffset"] = 3
	E.db["unitframe"]["units"]["raid3"]["rdebuffs"]["enable"] = true
	E.db["unitframe"]["units"]["raid3"]["rdebuffs"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["raid3"]["rdebuffs"]["size"] = 20
	E.db["unitframe"]["units"]["raid3"]["rdebuffs"]["stack"]["xOffset"] = 3
	E.db["unitframe"]["units"]["raid3"]["rdebuffs"]["stack"]["yOffset"] = -3
	E.db["unitframe"]["units"]["raid3"]["roleIcon"]["enable"] = true
	E.db["unitframe"]["units"]["raid3"]["roleIcon"]["position"] = "TOPRIGHT"
	E.db["unitframe"]["units"]["raid3"]["roleIcon"]["size"] = 12
	E.db["unitframe"]["units"]["raid3"]["visibility"] = "[@raid31,noexists] hide;show"
	if not E.Retail then
		E.db["unitframe"]["units"]["raid3"]["visibility"] = "[@raid26,noexists] hide;show"
	end

	-- Raid Pets
	E.db["unitframe"]["units"]["raidpet"]["enable"] = false

	-- Tank
	E.db["unitframe"]["units"]["tank"]["width"] = 120
	E.db["unitframe"]["units"]["tank"]["height"] = 30
	E.db["unitframe"]["units"]["tank"]["verticalSpacing"] = 7
	E.db["unitframe"]["units"]["tank"]["colorOverride"] = "FORCE_OFF"
	E.db["unitframe"]["units"]["tank"]["buffIndicator"]["enable"] = true
	E.db["unitframe"]["units"]["tank"]["buffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["tank"]["debuffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["tank"]["debuffs"]["enable"] = true
	E.db["unitframe"]["units"]["tank"]["rdebuffs"]["duration"]["yOffset"] = 3
	E.db["unitframe"]["units"]["tank"]["rdebuffs"]["font"] = "Kimberley"
	E.db["unitframe"]["units"]["tank"]["rdebuffs"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["tank"]["rdebuffs"]["fontSize"] = 14
	E.db["unitframe"]["units"]["tank"]["rdebuffs"]["size"] = 20
	E.db["unitframe"]["units"]["tank"]["rdebuffs"]["stack"]["xOffset"] = -3
	E.db["unitframe"]["units"]["tank"]["targetsGroup"]["height"] = 30

	-- Target
	E.db["unitframe"]["units"]["target"]["width"] = 270
	E.db["unitframe"]["units"]["target"]["colorOverride"] = "FORCE_OFF"
	E.db["unitframe"]["units"]["target"]["disableMouseoverGlow"] = true
	E.db["unitframe"]["units"]["target"]["orientation"] = "RIGHT"
	E.db["unitframe"]["units"]["target"]["healPrediction"]["enable"] = true
	E.db["unitframe"]["units"]["target"]["healPrediction"]["absorbStyle"] = "REVERSED"
	E.db["unitframe"]["units"]["target"]["healPrediction"]["anchorPoint"] = "CENTER"
	E.db["unitframe"]["units"]["target"]["health"]["text_format"] = ""
	E.db["unitframe"]["units"]["target"]["health"]["xOffset"] = 0
	E.db["unitframe"]["units"]["target"]["name"]["position"] = "LEFT"
	E.db["unitframe"]["units"]["target"]["name"]["text_format"] = ""
	E.db["unitframe"]["units"]["target"]["aurabar"]["attachTo"] = "FRAME"
	E.db["unitframe"]["units"]["target"]["aurabar"]["sortDirection"] = "ASCENDING"
	E.db["unitframe"]["units"]["target"]["aurabar"]["spacing"] = 1
	E.db["unitframe"]["units"]["target"]["aurabar"]["yOffset"] = 1
	E.db["unitframe"]["units"]["target"]["buffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["target"]["buffs"]["countXOffset"] = 2
	E.db["unitframe"]["units"]["target"]["buffs"]["countYOffset"] = -3
	E.db["unitframe"]["units"]["target"]["buffs"]["durationPosition"] = "TOP"
	E.db["unitframe"]["units"]["target"]["buffs"]["growthX"] = "RIGHT"
	E.db["unitframe"]["units"]["target"]["buffs"]["height"] = 25
	E.db["unitframe"]["units"]["target"]["buffs"]["keepSizeRatio"] = false
	E.db["unitframe"]["units"]["target"]["buffs"]["maxDuration"] = 1200
	E.db["unitframe"]["units"]["target"]["buffs"]["sizeOverride"] = 30
	E.db["unitframe"]["units"]["target"]["buffs"]["sortDirection"] = "ASCENDING"
	E.db["unitframe"]["units"]["target"]["buffs"]["spacing"] = 2
	E.db["unitframe"]["units"]["target"]["debuffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["target"]["debuffs"]["countFontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["target"]["debuffs"]["growthX"] = "RIGHT"
	E.db["unitframe"]["units"]["target"]["debuffs"]["height"] = 25
	E.db["unitframe"]["units"]["target"]["debuffs"]["keepSizeRatio"] = false
	E.db["unitframe"]["units"]["target"]["debuffs"]["sizeOverride"] = 30
	E.db["unitframe"]["units"]["target"]["debuffs"]["spacing"] = 2
	E.db["unitframe"]["units"]["target"]["castbar"]["customColor"]["colorBackdrop"]["b"] = 0
	E.db["unitframe"]["units"]["target"]["castbar"]["customColor"]["colorBackdrop"]["g"] = 0
	E.db["unitframe"]["units"]["target"]["castbar"]["customColor"]["colorBackdrop"]["r"] = 0
	E.db["unitframe"]["units"]["target"]["castbar"]["customColor"]["useClassColor"] = true
	E.db["unitframe"]["units"]["target"]["castbar"]["customColor"]["useCustomBackdrop"] = true
	E.db["unitframe"]["units"]["target"]["castbar"]["iconAttachedTo"] = "Castbar"
	E.db["unitframe"]["units"]["target"]["castbar"]["iconXOffset"] = 0
	E.db["unitframe"]["units"]["target"]["castbar"]["textColor"]["b"] = 1
	E.db["unitframe"]["units"]["target"]["castbar"]["textColor"]["g"] = 1
	E.db["unitframe"]["units"]["target"]["castbar"]["textColor"]["r"] = 1
	E.db["unitframe"]["units"]["target"]["castbar"]["timeToHold"] = 0.6
	E.db["unitframe"]["units"]["target"]["portrait"]["camDistanceScale"] = 4.2
	E.db["unitframe"]["units"]["target"]["portrait"]["enable"] = true
	E.db["unitframe"]["units"]["target"]["portrait"]["fullOverlay"] = true
	E.db["unitframe"]["units"]["target"]["portrait"]["overlay"] = true
	E.db["unitframe"]["units"]["target"]["portrait"]["overlayAlpha"] = 0.3
	E.db["unitframe"]["units"]["target"]["portrait"]["rotation"] = 291
	E.db["unitframe"]["units"]["target"]["portrait"]["style"] = "3D"
	E.db["unitframe"]["units"]["target"]["portrait"]["xOffset"] = 0.1
	E.db["unitframe"]["units"]["target"]["power"]["attachTextTo"] = "Power"
	E.db["unitframe"]["units"]["target"]["power"]["text_format"] = ""
	E.db["unitframe"]["units"]["target"]["power"]["width"] = "spaced"
	E.db["unitframe"]["units"]["target"]["power"]["xOffset"] = 0
	E.db["unitframe"]["units"]["target"]["raidicon"]["attachToObject"] = "Health"
	E.db["unitframe"]["units"]["target"]["raidicon"]["enable"] = false
	E.db["unitframe"]["units"]["target"]["raidicon"]["yOffset"] = 0

	-- TargetTarget
	E.db["unitframe"]["units"]["targettarget"]["width"] = 130
	E.db["unitframe"]["units"]["targettarget"]["colorOverride"] = "FORCE_OFF"
	E.db["unitframe"]["units"]["targettarget"]["buffs"]["height"] = 25
	E.db["unitframe"]["units"]["targettarget"]["buffs"]["keepSizeRatio"] = false
	E.db["unitframe"]["units"]["targettarget"]["buffs"]["perrow"] = 6
	E.db["unitframe"]["units"]["targettarget"]["buffs"]["sizeOverride"] = 30
	E.db["unitframe"]["units"]["targettarget"]["debuffs"]["enable"] = false
	E.db["unitframe"]["units"]["targettarget"]["infoPanel"]["transparent"] = true
	E.db["unitframe"]["units"]["targettarget"]["name"]["text_format"] = ""
	E.db["unitframe"]["units"]["targettarget"]["power"]["attachTextTo"] = "Power"
	E.db["unitframe"]["units"]["targettarget"]["power"]["position"] = "RIGHT"
	E.db["unitframe"]["units"]["targettarget"]["power"]["text_format"] = ""
	E.db["unitframe"]["units"]["targettarget"]["power"]["width"] = "spaced"
	E.db["unitframe"]["units"]["targettarget"]["power"]["xOffset"] = -2
	E.db["unitframe"]["units"]["targettarget"]["power"]["yOffset"] = 1
	E.db["unitframe"]["units"]["targettarget"]["raidicon"]["attachTo"] = "CENTER"
	E.db["unitframe"]["units"]["targettarget"]["raidicon"]["attachToObject"] = "Health"

	-- TargetTargetTarget
	E.db["unitframe"]["units"]["targettargettarget"]["debuffs"]["countFont"] = "Kimberley"

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
	if E.Modern or E.Mists or E.TBC or E.Wrath then
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
		["justifyH"] = "RIGHT",
		["size"] = 16,
		["text_format"] = "[eltruism:dead][eltruism:dc]",
		["xOffset"] = -2,
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
		["justifyH"] = "LEFT",
		["size"] = 16,
		["text_format"] = "[eltruism:dead][eltruism:dc]",
		["xOffset"] = 2,
		["yOffset"] = 0
	}
	if E.Modern then
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
	else
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
		["justifyH"] = "LEFT",
		["size"] = 16,
		["text_format"] = "[eltruism:dead][eltruism:dc]",
		["xOffset"] = 2,
		["yOffset"] = 3
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
	if E.Modern then
		E.private["general"]["minimap"]["hideTracking"] = true
	end
end

-- Global DB
function ElvUI_EltreumUI:SetupGlobal()
	-- ElvUI Global DB
	if E.Modern then
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
	E.global["datatexts"]["customPanels"]["EltruismDataText"]["tooltipAnchor"] = "ANCHOR_CURSOR"
	E.global["datatexts"]["customPanels"]["EltruismDataText"]["tooltipXOffset"] = 0
	E.global["datatexts"]["customPanels"]["EltruismDataText"]["tooltipYOffset"] = 0
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
	E.global["datatexts"]["customPanels"]["EltruismTime"]["tooltipAnchor"] = "ANCHOR_CURSOR"
	E.global["datatexts"]["customPanels"]["EltruismTime"]["tooltipXOffset"] = 0
	E.global["datatexts"]["customPanels"]["EltruismTime"]["tooltipYOffset"] = 0
	E.global["datatexts"]["customPanels"]["EltruismTime"]["visibility"] = "[petbattle] hide;show"
	E.global["datatexts"]["customPanels"]["EltruismTime"]["height"] = 22
	E.global["datatexts"]["customPanels"]["EltruismTime"]["width"] = 120

	local buttonwidth = _G.RightChatToggleButton:GetWidth()
	--local width = GetPhysicalScreenSize()
	local width = mathceil(E.screenWidth)
	E.global["datatexts"]["customPanels"]["EltruismDataText"]["width"] = 2 + mathceil(width - (buttonwidth * 2))

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
			if E.Forever or (E.Classic and not E.ClassicSOD) then --todo replace with dual once the lib is updated for it
				E.db["datatexts"]["panels"]["EltruismDataText"][1] = "Eltruism"
			else
				E.db["datatexts"]["panels"]["EltruismDataText"][1] = "DualSpecialization"
			end
		end
	end
	E.db["datatexts"]["panels"]["EltruismDataText"]["enable"] = true

	E.db["datatexts"]["panels"]["EltruismTime"][1] = "Time"
	E.db["datatexts"]["panels"]["EltruismTime"]["enable"] = true

	--E.db["datatexts"]["panels"]["EltruismDataText"]["battleground"] = true
	--[[E.db["datatexts"]["battlePanel"]["EltruismDataText"][1] = "PvP: Kills"
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
	E.db["datatexts"]["battlePanel"]["EltruismDataText"][9] = "PvP: Honor Gained"]]

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

	SetCVar("enableMouseoverCast", 1) --this will prevent people not having mouse over cast if the blizzard addon is loaded

	--graphics
	SetCVar("Brightness", 45)
	SetCVar("Contrast", 60)

	-- fast loot
	SetCVar("autoLootRate", 1)

	--Chat CVars
	SetCVar('chatStyle', 'classic')
	SetCVar('whisperMode', 'inline')
	SetCVar('colorChatNamesByClass', 1)
	SetCVar('chatClassColorOverride', 0)
	SetCVar("lootUnderMouse", 1)
	SetCVar("chatBubbles", 1)
	SetCVar("chatBubblesParty", 1)

	if _G.InterfaceOptionsActionBarsPanelPickupActionKeyDropDown then
		_G.InterfaceOptionsActionBarsPanelPickupActionKeyDropDown:SetValue('SHIFT')
		_G.InterfaceOptionsActionBarsPanelPickupActionKeyDropDown:RefreshValue()
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

	if E.Modern then
		if E.Retail then
			SetCVar('cameraDistanceMaxZoomFactor', 2.6)
		else
			SetCVar('cameraDistanceMaxZoomFactor', 4.0)
		end

		--show loot sparkles in case the user has outline disabled
		SetCVar("outlineModeShowLootEffectWhenDisabled", 1)

		--new midnight things
		SetCVar('damageMeterEnabled', 1)
		SetCVar('floatingCombatTextCombatDamage_v2', 1)

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
		SetCVar('ObjectSelectionCircle', 1) --enables/disables the target circle
		SetCVar('rawMouseEnable', 1) --default is 0, not sure if i should enable for everyone
		]]

		--set character to be highlighted in combat only
		SetCVar('findYourselfMode', 2) --"Highlight you character. 0 = circle, 1 = circle & outline, 2 = outline"
		SetCVar('findYourselfAnywhere', 1) --"Always Highlight your character"
		SetCVar('findYourselfAnywhereOnlyInCombat', 1) --"Highlight your character only when in combat"
		SetCVar('findYourselfModeOutline', 1)
		SetCVar('findYourselfModeCircle', 0)
		SetCVar('occludedSilhouettePlayer', 1) --not sure why its black now instead of colored like it was in a previous ptr
		SetCVar('cameraIndirectVisibility', 1) --occluded character visibility
		SetCVar('cameraIndirectOffset', 15) --controls the distance to trigger the occludedSilhouettePlayer
	elseif E.Mists or E.TBC or E.Wrath or E.Classic then
		SetCVar('cameraDistanceMaxZoomFactor', 3.4)
	end
	ElvUI_EltreumUI:Print(L["General CVars have been set."])
end

-- CVars NamePlates
function ElvUI_EltreumUI:NameplateCVars()
	SetCVar('nameplateOtherBottomInset', 0.02)
	SetCVar('nameplateOtherTopInset', 0.1)

	SetCVar('nameplateTargetRadialPosition', 1)
	SetCVar('nameplateLargerScale', 1.2)
	SetCVar('nameplateMinScale', 1)
	SetCVar('nameplateMinAlpha',1)

	SetCVar('nameplateMaxDistance', 60)
	SetCVar('nameplateMotion', 1)
	SetCVar('nameplateOccludedAlphaMult', 0)
	SetCVar("nameplateOverlapH", 0.8)
	SetCVar("nameplateOverlapV", 1.1)
	SetCVar('nameplateSelectedScale', 1.4)
	SetCVar('nameplateSelfAlpha', 1)
	SetCVar('nameplateShowFriendlyMinions', 0)
	SetCVar('nameplateTargetBehindMaxDistance', 40)
	SetCVar('nameplateShowEnemies', 1)
	SetCVar("nameplateShowFriends", 1)
	--SetCVar('nameplateShowFriendlyNpcs',0) --this is npcs, specially inside instances, call in the other function

	--[[12.1.0 new cvars
	nameplateCheckDistanceForTarget --ignores distance to display target np
	nameplateNotSelectedAlpha returns for retail
	]]

	if E.Modern then
		SetCVar("nameplateShowFriendlyPlayers", 1)
		SetCVar("nameplateShowOnlyNameForFriendlyPlayerUnits", 1)
		SetCVar("nameplateUseClassColorForFriendlyPlayerUnitNames", 1)
		E.db.nameplates.visibility.showOnlyNames = true --same as above, but persistent
		SetCVar("nameplatePlayerLargerScale", 1.8)
	else
		SetCVar("nameplateNotSelectedAlpha",0.5)
	end

	--[[
	if E.Forever then --not yet implemented it seems
		nameplateMaxVerticalDistance
		nameplateMaxVerticalDistanceAtMaxRange
	end
	]]

	SetCVar('nameplateMaxAlpha', 1)
	SetCVar('nameplateMaxAlphaDistance', GetCVarDefault('nameplateMaxAlphaDistance'))
	SetCVar('nameplateMaxScale', 1)
	SetCVar('nameplateMaxScaleDistance', 40)
	SetCVar('nameplateMinAlphaDistance', GetCVarDefault('nameplateMinAlphaDistance'))
	SetCVar('nameplateMinScaleDistance', 0)
	SetCVar('nameplatePlayerLargerScale', 1.8)
	SetCVar('nameplateSelectedAlpha', 1)

	if not E.Modern then
		SetCVar('nameplateSelfScale', 1)
		SetCVar('nameplateGlobalScale', 1)
		SetCVar('NamePlateHorizontalScale', 1)
		SetCVar('nameplateClassResourceTopInset', GetCVarDefault('nameplateClassResourceTopInset'))
		SetCVar('nameplateLargeBottomInset', 0.02)
		SetCVar('nameplateLargeTopInset', 0.1)
		SetCVar('nameplateMotionSpeed', GetCVarDefault('nameplateMotionSpeed'))
		SetCVar('nameplateResourceOnTarget', GetCVarDefault('nameplateResourceOnTarget'))
		SetCVar('nameplateSelfBottomInset', GetCVarDefault('nameplateSelfBottomInset'))
		SetCVar('nameplateSelfTopInset', GetCVarDefault('nameplateSelfTopInset'))
	end

	ElvUI_EltreumUI:Print(L["NamePlate CVars have been set."])
end

-- Alternate DPS party layout
function ElvUI_EltreumUI:AlternativeGroupsDPS()
	if ElvDB.profileKeys[E.mynameRealm] and ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") then
		if not E.db.movers then E.db.movers = {} end
		E.db["movers"]["ElvUF_PartyMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,199,-258"
		E.db["movers"]["ElvUF_Raid1Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-432"
		E.db["movers"]["ElvUF_Raid2Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,104,-328"
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
	if ElvDB.profileKeys[E.mynameRealm] and ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") then
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
	--E:UpdateMediaItems()
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
	--E:UpdateMediaItems()
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
