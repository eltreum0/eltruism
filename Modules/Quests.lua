local _G = _G
local unpack = _G.unpack
local select = _G.select
local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local pairs = _G.pairs
local SetCVar = _G.SetCVar
local IsAddOnLoaded = _G.IsAddOnLoaded
local IsInInstance = _G.IsInInstance
local ObjectiveTracker_Collapse = _G.ObjectiveTracker_Collapse
local ObjectiveTrackerFrame = _G.ObjectiveTrackerFrame
local ObjectiveTracker_Expand = _G.ObjectiveTracker_Expand

--Collapse Quests during boss fights
function ElvUI_EltreumUI:QuestEncounter()
	if E.private.ElvUI_EltreumUI.questsettings.enable then
		local inInstance, instanceType = IsInInstance()
		if instanceType == "raid" or instanceType == "party" then  --and event == "PLAYER_REGEN_DISABLED"
			ObjectiveTracker_Collapse()
			if ObjectiveTrackerFrame:IsVisible() or ObjectiveTracker_Expand() then
				ObjectiveTracker_Collapse()
			end
		end
	end
end
