local E, L, V, P, G = unpack(ElvUI)
local _G = _G
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded

-- Questie profile setup
function ElvUI_EltreumUI:GetQuestieProfile()
	if not E.Retail then
		if IsAddOnLoaded("Questie") then
			if QuestieConfig.profiles.Eltreum then
				table.insert(QuestieConfig.profileKeys, E.mynameRealm)
				QuestieConfig["profileKeys"][E.mynameRealm] = "Eltreum"
			else
				QuestieConfig["profiles"]["Eltreum"] = {}
				QuestieConfig["profiles"]["Eltreum"] = {
					["trackerFontOutline"] = ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle),

					["trackerFontHeader"] = E.db.general.font,
					["trackerFontObjective"] = E.db.general.font,
					["trackerFontZone"] = E.db.general.font,
					["trackerFontQuest"] = E.db.general.font,

					["trackerFontSizeHeader"] = 14,
					["trackerFontSizeZone"] = 13,
					["trackerFontSizeQuest"] = 12,
					["trackerFontSizeObjective"] = 12,

					["nameplateTargetFrameX"] = -252,
					["nameplateTargetFrameY"] = 17,

					["questMinimapObjectiveColors"] = true,

					["nameplateX"] = 146,
					["nameplateY"] = 0,
					["nameplateTargetFrameEnabled"] = true,

					["alwaysGlowMinimap"] = true,
					["questObjectiveColors"] = true,
					["collapseCompletedQuests"] = true,
					["nameplateTargetFrameScale"] = 1,
					["trackerSortObjectives"] = "byProximity",
					["soundOnQuestComplete"] = true,



					["trackerEnabled"] = false,
					["onlyPartyShared"] = true,
					["hideTrackerInCombat"] = false,
					["mapShowHideEnabled"] = false,
					["mapCoordinatesEnabled"] = false,
					["disableYellComms"] = true,
					["globalTrackerLocation"] = false,
					["currentBorderEnabled"] = true,
					["currentBackdropFader"] = true,
					["trackerbindOpenQuestLog"] = "right",
					["trackerColorObjectives"] = "whiteAndGreen",
				}
				QuestieConfig["profileKeys"][E.mynameRealm] = "Eltreum"
			end
		end
	end
end
