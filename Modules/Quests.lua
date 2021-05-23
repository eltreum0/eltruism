local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local pairs = pairs
local SetCVar = SetCVar
local IsAddOnLoaded = IsAddOnLoaded


if ElvUI_EltreumUI.Retail then

	--Collapse Quests during boss fights
	function ElvUI_EltreumUI:QuestEncounter()
		if E.private.ElvUI_EltreumUI.questsettings.enable then
			local inInstance, instanceType = IsInInstance()
			if instanceType == "raid" or instanceType == "party" or instanceType == "scenario" then  --and event == "PLAYER_REGEN_DISABLED"
				ObjectiveTracker_Collapse()
				if ObjectiveTrackerFrame:IsVisible() or ObjectiveTracker_Expand() then
					ObjectiveTracker_Collapse()
				end
			end
		end
	end

	function ElvUI_EltreumUI:ArenaQuest()
		if ElvUI_EltreumUI.Retail then
			if E.private.ElvUI_EltreumUI.questsettings.enable then
				local inInstance, instanceType = IsInInstance()
				if instanceType == "arena" then  --and event == "PLAYER_REGEN_DISABLED"
					ObjectiveTrackerFrame:Hide()
					if ObjectiveTrackerFrame:IsVisible() or ObjectiveTracker_Expand() then
						ObjectiveTrackerFrame:Hide()
					end
				end
			end
		end
	end

end
