local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

-- Questie profile setup
function ElvUI_EltreumUI:GetQuestieProfile()
	if not E.Retail then
		if not IsAddOnLoaded("Questie") then
			LoadAddOn("Questie")
		end
		QuestieConfig = {
			["dbIsCompiled"] = false,
			["global"] = {
				["trackerbindSetTomTom"] = "left",
				["DBMHUDZoom"] = 200,
				["questObjectiveColors"] = true,
				["dbmHUDRadius"] = 4,
				["trackerFontObjective"] = "Kimberley",
				--["trackerEnabled"] = true, --enables/disables the actual objective tracker
				["trackerEnabled"] = false,
				["mapCoordinatesEnabled"] = false,
				["professionTrainers"] = {},
				["trackerFontZone"] = "Kimberley",
				["trackerFontOutline"] = "Outline",
				["disableYellComms"] = true,
				["globalTrackerLocation"] = false,
				["questieTLoc"] = "global",
				["classSpecificTownsfolk"] = {
					["HUNTER"] = {
						["Class Trainer"] = {},
					},
					["WARRIOR"] = {
						["Class Trainer"] = {},
					},
					["ROGUE"] = {
						["Class Trainer"] = {},
					},
					["MAGE"] = {
						["Class Trainer"] = {},
					},
					["PRIEST"] = {
						["Class Trainer"] = {},
					},
					["WARLOCK"] = {
						["Class Trainer"] = {},
					},
					["DRUID"] = {
						["Class Trainer"] = {},
					},
					["SHAMAN"] = {
						["Class Trainer"] = {},
					},
					["PALADIN"] = {
						["Class Trainer"] = {},
					},
				},
				["trackerFontHeader"] = "Kimberley",
				["trackerBorderEnabled"] = true,
				["TrackerWidth"] = 0,
				["petFoodVendorTypes"] = {},
				["hideTrackerInCombat"] = false,
				["questMinimapObjectiveColors"] = true,
				["trackerFontSizeHeader"] = 14,
				["nameplateX"] = -30,
				["trackerBackdropFader"] = true,
				["trackerFontSizeObjective"] = 12,
				["mapShowHideEnabled"] = false,
				["trackerFontQuest"] = "Kimberley",
				["trackerbindOpenQuestLog"] = "right",
				["dbmHUDShowQuest"] = false,
				["factionSpecificTownsfolk"] = {
					["Horde"] = {
						["Spirit Healer"] = {},
						["Mailbox"] = {},
					},
					["Alliance"] = {
						["Spirit Healer"] = {},
						["Mailbox"] = {},
					},
				},
				["townsfolk"] = {
					["Repair"] = {},
					["Flight Master"] = {},
					["Innkeeper"] = {},
					["Weapon Master"] = {},
					["Auctioneer"] = {},
					["Battlemaster"] = {},
					["Banker"] = {},
				},
				["trackerFontSizeQuest"] = 12,
				["nameplateY"] = 0,
				["onlyPartyShared"] = true,
				["dbmHUDEnable"] = true,
				["trackerSortObjectives"] = "byProximity",
				["migrationVersion"] = {
				},
				["collapseCompletedQuests"] = true,
				["trackerColorObjectives"] = "whiteAndGreen",
				["hasSeenBetaMessage"] = true,
			},
			["profileKeys"] = {
			},
			["dbCompiledOnVersion"] = "v6.8.2",
			["npcBin"] = "",
			["dbCompiledLang"] = "enUS",
			["profiles"] = {
				["Eltreum"] = {
				},
			},
			["char"] = {
			},
			["itemBin"] = "",
			["questBin"] = "",
			["npcPtrs"] = "",
			["questPtrs"] = "",
			["objPtrs"] = "",
			["itemPtrs"] = "",
			["objBin"] = "",
		}
	end
end
