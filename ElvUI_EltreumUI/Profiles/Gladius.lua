local E, L, V, P, G = unpack(ElvUI)
local _G = _G
local table = _G.table

-- Gladdy profile setup
function ElvUI_EltreumUI:GetGladiusProfile()
	if Gladius2DB.profiles.Eltreum then
		--local key = {[E.mynameRealm] = "Eltreum"}
		--table.insert(Gladius2DB.profileKeys, key)
		table.insert(Gladius2DB.profileKeys, E.mynameRealm)
		Gladius2DB["profileKeys"][E.mynameRealm] = "Eltreum"
	else
		Gladius2DB["profiles"]["Eltreum"] = {}
		Gladius2DB["profiles"]["Eltreum"] = {
			["targetBarWidth"] = 69,
			["modules"] = {
				["Auras"] = true,
			},
			["castBarHeight"] = 16,
			["aurasBuffsRelativePoint"] = "TOPLEFT",
			["powerBarUseDefaultColorRunicPower"] = true,
			["powerBarUseDefaultColorFocus"] = true,
			["aurasBuffsPerColumn"] = 14,
			["trinketOffsetX"] = 0,
			["powerBarUseDefaultColorEnergy"] = true,
			["classIconCrop"] = true,
			["timerOmniCC"] = true,
			["targetBarAttachTo"] = "DRTracker",
			["aurasBuffsAttachTo"] = "Frame",
			["targetBarOffsetX"] = -100,
			["tagsVersion"] = 4,
			["dispellGloss"] = false,
			["locked"] = true,
			["classIconGloss"] = false,
			["x"] = {
				["arena1"] = 1067.200311415531,
			},
			["targetBarIconCrop"] = true,
			["RacialIconCrop"] = true,
			["bottomMargin"] = 46,
			["powerBarUseDefaultColorRage"] = true,
			["aurasBuffsHeight"] = 20,
			["aurasBuffsOffsetY"] = 25,
			["healthBarBackgroundColor"] = {
				["a"] = 1,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["aurasBuffs"] = true,
			["aurasDebuffsHeight"] = 20,
			["targetBarRelativePoint"] = "BOTTOMLEFT",
			["aurasBuffsWidth"] = 20,
			["aurasDebuffsRelativePoint"] = "TOPRIGHT",
			["RacialGloss"] = false,
			["globalFont"] = E.db.general.font,
			["backgroundColor"] = {
				["a"] = 0,
			},
			["castTextSize"] = 12,
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
			["powerBarBackgroundColor"] = {
				["a"] = 1,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["trinketIconCrop"] = true,
			["castBarTexture"] = "ElvUI Norm1",
			["auraVersion"] = 1,
			["drTrackerAdjustSize"] = false,
			["powerBarUseDefaultColorMana"] = true,
			["aurasBuffsOffsetX"] = -41,
			["aurasDebuffsWidth"] = 20,
			["drTrackerGlossColor"] = {
				["a"] = 1,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["drTrackerSize"] = 40,
			["drTrackerCooldown"] = true,
			["healthBarTexture"] = "ElvUI Norm1",
			["powerBarTexture"] = "ElvUI Norm1",
			["dispellAttachTo"] = "Racial",
			["castBarBackgroundColor"] = {
				["a"] = 1,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["aurasBuffsGrow"] = "UPRIGHT",
			["barWidth"] = 220,
			["aurasBuffsSpacingY"] = 2,
			["y"] = {
				["arena1"] = 576.0668358927651,
			},
			["targetBarTexture"] = "ElvUI Norm1",
			["backgroundPadding"] = 0,
			["targetBarAdjustWidth"] = false,
			["targetBarAnchor"] = "LEFT",
		}
		Gladius2DB["profileKeys"][E.mynameRealm] = "Eltreum"
	end
end
