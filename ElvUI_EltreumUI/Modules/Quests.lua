local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local IsInInstance = _G.IsInInstance
local CreateFrame = _G.CreateFrame
local UnitGUID = _G.UnitGUID
local tonumber = _G.tonumber
local string = _G.string
local C_GossipInfo = _G.C_GossipInfo
local IsControlKeyDown = _G.IsControlKeyDown
local IsShiftKeyDown = _G.IsShiftKeyDown
local IsAltKeyDown = _G.IsAltKeyDown
local IsAddOnLoaded = _G.IsAddOnLoaded

if ElvUI_EltreumUI.Retail then
	--Collapse Quests during boss fights
	function ElvUI_EltreumUI:QuestEncounter()
		if E.db.ElvUI_EltreumUI.questsettings.enable then
			local _, instanceType = IsInInstance()
			if instanceType == "raid" or instanceType == "party" or instanceType == "scenario" then --and event == "PLAYER_REGEN_DISABLED"
				ObjectiveTracker_Collapse()
			end
		end
	end
	--expand after encounter is over
	function ElvUI_EltreumUI:QuestEncounterEnd()
		if E.db.ElvUI_EltreumUI.questsettings.enable then
			local _, instanceType = IsInInstance()
			if instanceType == "raid" or instanceType == "party" or instanceType == "scenario" then --and event == "PLAYER_REGEN_DISABLED"
				ObjectiveTracker_Expand()
			end
		end
	end
	--hide quests in arena matches
	function ElvUI_EltreumUI:ArenaQuest()
		if ElvUI_EltreumUI.Retail then
			if E.db.ElvUI_EltreumUI.questsettings.arena then
				local _, instanceType = IsInInstance()
				if instanceType == "arena" or instanceType == "pvp" then
					ObjectiveTrackerFrame:Hide()
				elseif instanceType == "none" then
					ObjectiveTrackerFrame:Show()
				end
			end
		end
	end
end

--based on Rogue Door Opener by Burzolog
local RogueOrderHallAutoOpen = CreateFrame("Frame", "EltruismRogueOrderHallAutoOpen")
RogueOrderHallAutoOpen:RegisterEvent("GOSSIP_SHOW")
function ElvUI_EltreumUI:RogueAutoOpen()
	if not IsAddOnLoaded("ElvUI_EltreumUI") then
		return
	elseif not E.private.ElvUI_EltreumUI then
		return
	elseif E.db.ElvUI_EltreumUI.questsettings == nil then
		E.db.ElvUI_EltreumUI.questsettings = {
			enable = true,
			rogueopen = true,
		}
	end
	if E.db.ElvUI_EltreumUI.questsettings.rogueopen then
		local guid = UnitGUID("npc")
		--ElvUI_EltreumUI:Print('got guid from npc')
		if not guid then
			return nil
		end
		local NPC_ID = tonumber(string.match(guid, "Creature%-%d+%-%d+%-%d+%-%d+%-(%d+)"))

		local function handle_NPC_Interaction()
			if C_GossipInfo.GetNumOptions() ~= 2 then
				--ElvUI_EltreumUI:Print('not the right amount of gossip')
				return
			end
			local gossipInfoTable = C_GossipInfo.GetOptions()
			if gossipInfoTable[1].type ~= "gossip" then
				--ElvUI_EltreumUI:Print('not a gossip at first')
				return
			end
			if NPC_ID == 97004 or NPC_ID == 96782 or NPC_ID == 93188 then
				--ElvUI_EltreumUI:Print('its the right npc')
				if IsShiftKeyDown() or IsControlKeyDown() or IsAltKeyDown() then
					--ElvUI_EltreumUI:Print('you held a modfier key')
					return
				else
					C_GossipInfo.SelectOption(1)
				end
			end
		end
		RogueOrderHallAutoOpen:SetScript("OnEvent", handle_NPC_Interaction)
	end
end
