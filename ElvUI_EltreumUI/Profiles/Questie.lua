local E, L, V, P, G = unpack(ElvUI)
local _G  = _G
local IsAddOnLoaded = _G.IsAddOnLoaded
local LoadAddOn = _G.LoadAddOn

-- Questie profile setup
function ElvUI_EltreumUI:GetQuestieProfile()
	if not E.Retail then
		if not IsAddOnLoaded("Questie") then
			LoadAddOn("Questie")
		end
		QuestieConfig["global"]["TrackerWidth"] = 0
		QuestieConfig["global"]["trackerbindSetTomTom"] = "left"
		QuestieConfig["global"]["trackerFontObjective"] = E.db.general.font
		QuestieConfig["global"]["trackerEnabled"] = false --enables/disables the actual objective tracker
		QuestieConfig["global"]["trackerFontZone"] = E.db.general.font
		QuestieConfig["global"]["trackerFontOutline"] = "Outline"
		QuestieConfig["global"]["trackerFontHeader"] = E.db.general.font
		QuestieConfig["global"]["trackerBorderEnabled"] = true
		QuestieConfig["global"]["trackerFontSizeHeader"] = 14
		QuestieConfig["global"]["trackerBackdropFader"] = true
		QuestieConfig["global"]["trackerFontSizeObjective"] = 12
		QuestieConfig["global"]["trackerFontQuest"] = E.db.general.font
		QuestieConfig["global"]["trackerbindOpenQuestLog"] = "right"
		QuestieConfig["global"]["trackerFontSizeQuest"] = 12
		QuestieConfig["global"]["trackerSortObjectives"] = "byProximity"
		QuestieConfig["global"]["trackerColorObjectives"] = "whiteAndGreen"

		QuestieConfig["global"]["dbmHUDEnable"] = false
		QuestieConfig["global"]["DBMHUDZoom"] = 200
		QuestieConfig["global"]["dbmHUDRadius"] = 4
		QuestieConfig["global"]["dbmHUDShowQuest"] = false

		QuestieConfig["global"]["nameplateX"] = -25
		QuestieConfig["global"]["nameplateY"] = 0
		QuestieConfig["global"]["nameplateTargetFrameY"] = 5
		QuestieConfig["global"]["nameplateTargetFrameX"] = -171

		QuestieConfig["global"]["questMinimapObjectiveColors"] = true
		QuestieConfig["global"]["questObjectiveColors"] = true

		QuestieConfig["global"]["mapCoordinatesEnabled"] = false
		QuestieConfig["global"]["disableYellComms"] = true
		QuestieConfig["global"]["globalTrackerLocation"] = false
		QuestieConfig["global"]["hideTrackerInCombat"] = false
		QuestieConfig["global"]["mapShowHideEnabled"] = false
		QuestieConfig["global"]["onlyPartyShared"] = true
		QuestieConfig["global"]["collapseCompletedQuests"] = true
	end
end
