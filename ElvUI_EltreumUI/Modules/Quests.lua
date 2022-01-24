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


--Collapse Quests during boss fights
function ElvUI_EltreumUI:QuestEncounter()
	if E.db.ElvUI_EltreumUI.questsettings.enable then
		local _, instanceType = IsInInstance()
		if instanceType == "raid" or instanceType == "party" or instanceType == "scenario" then --and event == "PLAYER_REGEN_DISABLED"
			if ElvUI_EltreumUI.Retail then
				ObjectiveTracker_Collapse()
			elseif ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
				QuestWatchFrame:Hide()
			end
		end
	end
end
--expand after encounter is over
function ElvUI_EltreumUI:QuestEncounterEnd()
	if E.db.ElvUI_EltreumUI.questsettings.enable then
		local _, instanceType = IsInInstance()
		if instanceType == "raid" or instanceType == "party" or instanceType == "scenario" then --and event == "PLAYER_REGEN_DISABLED"
			if ElvUI_EltreumUI.Retail then
				ObjectiveTracker_Expand()
			elseif ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
				QuestWatchFrame:Show()
			end
		end
	end
end
--hide quests in arena/bg matches
function ElvUI_EltreumUI:ArenaQuest()
	if E.db.ElvUI_EltreumUI.questsettings.arena then
		local _, instanceType = IsInInstance()
		if instanceType == "arena" or instanceType == "pvp" then
			if ElvUI_EltreumUI.Retail then
				ObjectiveTrackerFrame:Hide()
			elseif ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
				QuestWatchFrame:Hide()
			end
		elseif instanceType == "none" then
			if ElvUI_EltreumUI.Retail then
				ObjectiveTrackerFrame:Show()
			elseif ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
				QuestWatchFrame:Show()
			end
		end
	end
end
--Collapse/Hide Quests during combat with anything
function ElvUI_EltreumUI:QuestCombat()
	if E.db.ElvUI_EltreumUI.questsettings.combatenable then
		if ElvUI_EltreumUI.Retail then
			ObjectiveTracker_Collapse()
		elseif ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
			QuestWatchFrame:Hide()
		end
	end
end
--expand after combat is over
function ElvUI_EltreumUI:QuestCombatEnd()
	if E.db.ElvUI_EltreumUI.questsettings.combatenable then
		if ElvUI_EltreumUI.Retail then
			ObjectiveTracker_Expand()
		elseif ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
			QuestWatchFrame:Show()
		end
	end
end

--based on Rogue Door Opener by Burzolog
local RogueOrderHallAutoOpen = CreateFrame("Frame", "EltruismRogueOrderHallAutoOpen")
RogueOrderHallAutoOpen:Hide()
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
					--ElvUI_EltreumUI:Print('you hold a modifier key')
					return
				else
					C_GossipInfo.SelectOption(1)
				end
			end
		end
		RogueOrderHallAutoOpen:SetScript("OnEvent", handle_NPC_Interaction)
	end
end

--yet another quest auto accept thing
local EltruismAutoComplete = CreateFrame("FRAME", "EltruismAutoCompleteFrame")
function ElvUI_EltreumUI:AutoAcceptQuests()
	--print("77777777")
	if E.db.ElvUI_EltreumUI.questsettings.autoaccept then
		--print("6666")
		EltruismAutoComplete:RegisterEvent("QUEST_GREETING")
		EltruismAutoComplete:RegisterEvent("GOSSIP_SHOW")
		EltruismAutoComplete:RegisterEvent("QUEST_DETAIL")
		EltruismAutoComplete:RegisterEvent("QUEST_COMPLETE")
		EltruismAutoComplete:RegisterEvent("QUEST_ACCEPT_CONFIRM")
		EltruismAutoComplete:RegisterEvent("QUEST_PROGRESS")
		EltruismAutoComplete:SetScript("OnEvent", function(_, event)

			local normal = (IsShiftKeyDown() or IsControlKeyDown() or IsAltKeyDown())
			if E.db.ElvUI_EltreumUI.questsettings.autoacceptinvert then
				--print("888888")
				normal = not (IsShiftKeyDown() or IsControlKeyDown() or IsAltKeyDown())
			end
			if normal then
				--print("9999999")
				--ElvUI_EltreumUI:Print('you didnt hold a modifier key')
				return
			else
				--print("+++++++")
				if event == 'QUEST_DETAIL' then
					--print("11111")
					if ElvUI_EltreumUI.Retail then
						if QuestGetAutoAccept() then
							--print("222222")
							CloseQuest()
						else
							--print("33333")
							if QuestIsDaily() then
								--print("44444444")
								return
							elseif QuestIsWeekly() then
								--print("5555555")
								return
							end
							AcceptQuest()
							--print("aaaaa")
						end
					elseif ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
						AcceptQuest()
						if (GetNumQuestChoices() <= 0) then
							return
						end
					end
				end
				if event == 'QUEST_ACCEPT_CONFIRM' then
					ConfirmAcceptQuest()
					StaticPopup_Hide("QUEST_ACCEPT")
					--print("bbbb")
				end
				if event == 'GOSSIP_SHOW' then
					---print("cccc")
					if ElvUI_EltreumUI.Retail then
						for i, k in next, C_GossipInfo.GetAvailableQuests() do
							C_GossipInfo.SelectAvailableQuest(i)
						end
					elseif ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
						if (GetNumGossipAvailableQuests() > 0) then
							local arg = {GetGossipAvailableQuests()}
							local i = 1
							while(arg[i]) do
								SelectGossipAvailableQuest(i)
								i = i + 1
							end
						end
						if (GetNumGossipActiveQuests() > 0) then
							local numactive = GetNumGossipActiveQuests()
							for i = 1, numactive do
								SelectGossipActiveQuest(i)
								AcceptQuest()
								if (GetNumQuestChoices() <= 0) then
									return
								end
								i = i + 1
							end
						end
					end
				end
				if event == 'QUEST_GREETING' then
					--print("ffff")
					--if accepting quests
					for i = 1, GetNumAvailableQuests() do
						---print("gggg")
						SelectAvailableQuest(i)
					end

					--if completing quests
					for i = 1, GetNumActiveQuests() do
					--print("hhhhh")
						local _, completed = GetActiveTitle(i)
						if completed and not C_QuestLog.IsWorldQuest(GetActiveQuestID(i)) then
							--print("iiiiii")
							SelectActiveQuest(i)
						end
					end
				end
				if event == 'QUEST_PROGRESS' then
					--print("ddddd")
					if GetQuestMoneyToGet() > 0 then
						return
					else
						CompleteQuest()
					end
				end
				if event == 'QUEST_COMPLETE' then
				--print("eeeeeee")
					if GetQuestMoneyToGet() > 0 then
						return
					else
						if GetNumQuestChoices() <= 1 then
							GetQuestReward(GetNumQuestChoices())
						end
					end
				end

			end
		end)
	end
end
