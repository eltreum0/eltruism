local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local pairs = pairs
local SetCVar = SetCVar
local IsAddOnLoaded = IsAddOnLoaded

--Collapse Quests during boss fights
function ElvUI_EltreumUI:QuestEncounter()
	if E.private.ElvUI_EltreumUI.questsettings.enable then
		local inInstance, instanceType = IsInInstance()
		if instanceType == "raid" or instanceType == "party" then  --and event == "PLAYER_REGEN_DISABLED"
			ObjectiveTracker_Collapse()
			if ObjectiveTrackerFrame:IsVisible() then
				ObjectiveTracker_Collapse()
			end

		end
	end
end
