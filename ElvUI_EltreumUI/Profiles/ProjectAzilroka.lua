local E, L, V, P, G = unpack(ElvUI)
local _G = _G

-- ProjectAzilroka profile setup
function ElvUI_EltreumUI:GetPAProfile()
	local PA = _G.ProjectAzilroka
	--PA.data:SetProfile("Default")
	if ProjectAzilrokaDB.profiles.Eltreum then
		table.insert(ProjectAzilrokaDB.profileKeys, E.mynameRealm)
		ProjectAzilrokaDB["profileKeys"][E.mynameRealm] = "Eltreum"
		E.private.ElvUI_EltreumUI.isInstalled.projectazilroka = true
	else
		ProjectAzilrokaDB["profiles"]["Eltreum"] = {}
		ProjectAzilrokaDB["profiles"]["Eltreum"] = {
			["AuraReminder"] = {
				["Enable"] = false,
				["Sound"] = 'Warning',
				["Filters"] = { Global = {} },
			},
			["QuestSounds"] = {
				["Enable"] = true,
				["Throttle"] = 3,
				["Channel"] = 'SFX',
				["QuestComplete"] = 'Peon Quest Complete',
				["UseSoundID"] = false,
				["QuestSounds"] = {
					["ObjectiveCompleteID"] = "None",
					["ObjectiveProgressID"] = "None",
					["ObjectiveComplete"] = "None",
					["QuestCompleteID"] = "None",
					["ObjectiveProgress"] = "None",
				},
			},
			["FasterLoot"] = {
				["Enable"] = false
			},
			["Cooldown"] = {
				["Enable"] = false
			},
			["DragonOverlay"] = {
				["Enable"] = false,
				["Strata"] = 'MEDIUM',
				["Level"] = 12,
				["IconSize"] = 32,
				["Width"] = 128,
				["Height"] = 64,
				["worldboss"] = 'Chromatic',
				["elite"] = 'HeavenlyGolden',
				["rare"] = 'Onyx',
				["rareelite"] = 'HeavenlyOnyx',
				["ClassIcon"] = false,
				["FlipDragon"] = false,
				["ClassIconPoints"] = {
					["point"] = 'CENTER',
					["relativeTo"] = PA.Tukui and 'oUF_TukuiTarget' or PA.ElvUI and 'ElvUF_Target' or PA.NUI and 'NihilistUF_Target' or 'oUF_Target',
					["relativePoint"] = 'TOP',
					["xOffset"] = 0,
					["yOffset"] = 5,
				},
				["DragonPoints"] = {
					["point"] = 'CENTER',
					["relativeTo"] = PA.Tukui and 'oUF_TukuiTarget' or PA.ElvUI and 'ElvUF_Target' or PA.NUI and 'NihilistUF_Target' or 'oUF_Target',
					["relativePoint"] = 'TOP',
					["xOffset"] = 0,
					["yOffset"] = 5,
				},
			},
			["EnhancedShadows"] = {
				["Enable"] = false,
				["ColorByClass"] = true,
				["Size"] = 3,
				["Color"] = { 0, 0, 0, 1 },
			},
			["EnhancedFriendsList"] = {
				["Enable"] = true,
				["StatusIconPack"] = "Square",
				["Texture"] = "ElvUI Norm1",
				["NameFont"] = E.db.general.font,
				["NameFontSize"] = 12,
				["NameFontFlag"] = ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle),
				["InfoFont"] = E.db.general.font,
				["InfoFontSize"] = 12,
				["InfoFontFlag"] = ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle),
				["ShowLevel"] = true,
				["DiffLevel"] = true,
				["ShowStatusHighlight"] = true,
				["ShowStatusBackground"] = false,
				["GameIconPack"] = 'Launcher'
			},
			["MasterExperience"] = {
				["Enable"] = false,
				["ColorByClass"] = false,
				["BattleNet"] = true,
				["Party"] = true,
				["GrowthDirection"] = 'UP',
				["Width"] = 256,
				["Height"] = 20,
				["Font"] = E.db.general.font,
				["FontSize"] = 12,
				["FontFlag"] = ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle),
				["Colors"] = {
					["Experience"] = { r = 0, g = .4, b = 1, a = .8 },
					["Rested"] = { r = 1, g = 0, b = 1, a = .2},
					["Quest"] = { r = 0, g = 1, b = 0, a = .5}
				},
			},
			["MouseoverAuras"] = {
				["Enable"] = false,
				["Size"] = 16,
				["Spacing"] = 1,
				["cooldown"] = {
					["Enable"] = true,
					["threshold"] = 3,
					["hideBlizzard"] = false,
					["useIndicatorColor"] = false,
					["expiringColor"] = { r = 1, g = 0, b = 0 },
					["secondsColor"] = { r = 1, g = 1, b = 0 },
					["minutesColor"] = { r = 1, g = 1, b = 1 },
					["hoursColor"] = { r = 0.4, g = 1, b = 1 },
					["daysColor"] = { r = 0.4, g = 0.4, b = 1 },
					["expireIndicator"] = { r = 1, g = 1, b = 1 },
					["secondsIndicator"] = { r = 1, g = 1, b = 1 },
					["minutesIndicator"] = { r = 1, g = 1, b = 1 },
					["hoursIndicator"] = { r = 1, g = 1, b = 1 },
					["daysIndicator"] = { r = 1, g = 1, b = 1 },
					["hhmmColorIndicator"] = { r = 1, g = 1, b = 1 },
					["mmssColorIndicator"] = { r = 1, g = 1, b = 1 },
					["checkSeconds"] = false,
					["hhmmColor"] = { r = 0.43, g = 0.43, b = 0.43 },
					["mmssColor"] = { r = 0.56, g = 0.56, b = 0.56 },
					["hhmmThreshold"] = -1,
					["mmssThreshold"] = -1,
					["fonts"] = {
						["enable"] = false,
						["font"] = 'PT Sans Narrow',
						["fontOutline"] = 'OUTLINE',
						["fontSize"] = 18,
					},
				},
			},
			["MovableFrames"] = {
				["Enable"] = true,
				["ClampedToScreen"] = true,
			},
			["TorghastBuffs"] = {
				["Enable"] = false,
				["Masque"] = false,
				["countFont"] = 'Homespun',
				["countFontOutline"] = 'MONOCHROMEOUTLINE',
				["countFontSize"] = 10,
				["countXOffset"] = 0,
				["countYOffset"] = 0,
				["growthDirection"] = 'LEFT_DOWN',
				["horizontalSpacing"] = 1,
				["maxWraps"] = 5,
				["size"] = 26,
				["sortDir"] = '-',
				["sortMethod"] = 'INDEX',
				["verticalSpacing"] = 1,
				["wrapAfter"] = 10,
			},
			["OzCooldowns"] = {
				["Enable"] = false,
				["Announce"] = true,
				["DurationText"] = true,
				["Masque"] = false,
				["SuppressDuration"] = 60,
				["IgnoreDuration"] = 300,
				["Size"] = 36,
				["SortByDuration"] = true,
				["Spacing"] = 4,
				["SpellCDs"] = {},
				["StackFont"] = 'Arial Narrow',
				["StackFontFlag"] = 'OUTLINE',
				["StackFontSize"] = 12,
				["StatusBar"] = true,
				["StatusBarTexture"] = 'Blizzard Raid Bar',
				["StatusBarTextureColor"] = { .24, .54, .78 },
				["StatusBarGradient"] = false,
				["Tooltips"] = true,
				["Vertical"] = false,
				["UpdateSpeed"] = .1,
				["Cooldown"] = {
					["Enable"] = false
				},
			},
			["TargetSounds"] = {
				["Enable"] = false,
			},
			["stAddonManager"] = {
				["Enable"] = true,
				["NumAddOns"] = 20,
				["FrameWidth"] = 470,
				["Font"] = E.db.general.font,
				["FontSize"] = 15,
				["FontFlag"] = ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle),
				["ButtonHeight"] = 20,
				["ButtonWidth"] = 20,
				["CheckColor"] = { 0, .66, 1},
				["ClassColor"] = true,
				["CheckTexture"] = "Eltreum-Elvui-Norm",
				["EnableRequiredAddons"] = true,
				["EnableOptionalAddons"] = false,
			},
			["SquareMinimapButtons"] = {
				["Enable"] = true,
				["Strata"] = 'MEDIUM',
				["Level"] = 12,
				["BarMouseOver"] = true,
				["BarEnabled"] = true,
				["Backdrop"] = true,
				["IconSize"] = 24,
				["ButtonsPerRow"] = 8,
				["ButtonSpacing"] = 1,
				["HideGarrison"] = false,
				["MoveGarrison"] = true,
				["MoveMail"] = false,
				["MoveTracker"] = false,
				["MoveQueue"] = false,
				["MoveGameTimeFrame"] = true,
				["Shadows"] = false,
				["ReverseDirection"] = true,
				["Visibility"] = 'show',
			},
			["iFilger"] = {
				["Enable"] = false,
				["Cooldown"] = {
					["Enable"] = false
				},
			},
		}
		ProjectAzilrokaDB["profileKeys"][E.mynameRealm] = "Eltreum"
		E.private.ElvUI_EltreumUI.isInstalled.projectazilroka = true
	end
end
