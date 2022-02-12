local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

--Collapse Quests during boss fights
function ElvUI_EltreumUI:QuestEncounter()
	if E.db.ElvUI_EltreumUI.questsettings.enable then
		local _, instanceType = IsInInstance()
		if instanceType == "raid" or instanceType == "party" or instanceType == "scenario" then --and event == "PLAYER_REGEN_DISABLED"
			if ElvUI_EltreumUI.Retail then
				ObjectiveTracker_Collapse()
			elseif ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
				QuestWatchFrame:Hide()
				if IsAddOnLoaded("Questie") then
					_G["Questie_BaseFrame"]:Hide()
				end
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
				if IsAddOnLoaded("Questie") then
					_G["Questie_BaseFrame"]:Show()
				end
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
				if IsAddOnLoaded("Questie") then
					_G["Questie_BaseFrame"]:Hide()
				end
			end
		elseif instanceType == "none" then
			if ElvUI_EltreumUI.Retail then
				ObjectiveTrackerFrame:Show()
			elseif ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
				QuestWatchFrame:Show()
				if IsAddOnLoaded("Questie") then
					_G["Questie_BaseFrame"]:Show()
				end
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
			if IsAddOnLoaded("Questie") then
				_G["Questie_BaseFrame"]:Hide()
			end
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
			if IsAddOnLoaded("Questie") then
				_G["Questie_BaseFrame"]:Show()
			end
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
	if E.db.ElvUI_EltreumUI.questsettings.autoaccept then
		--print("quest automation is enabled")
		EltruismAutoComplete:RegisterEvent("QUEST_GREETING")
		EltruismAutoComplete:RegisterEvent("GOSSIP_SHOW")
		EltruismAutoComplete:RegisterEvent("QUEST_DETAIL")
		EltruismAutoComplete:RegisterEvent("QUEST_COMPLETE")
		EltruismAutoComplete:RegisterEvent("QUEST_ACCEPT_CONFIRM")
		EltruismAutoComplete:RegisterEvent("QUEST_PROGRESS")
		EltruismAutoComplete:SetScript("OnEvent", function(_, event)
			--print(event)
			local normal = (IsShiftKeyDown() or IsControlKeyDown() or IsAltKeyDown())
			if E.db.ElvUI_EltreumUI.questsettings.autoacceptinvert then
				--print("inverted the mod keys")
				normal = not (IsShiftKeyDown() or IsControlKeyDown() or IsAltKeyDown())
			end
			if normal then
				--print("using normal keys")
				return
			else
				--print("started quest automation")
				if event == 'QUEST_DETAIL' then
					--print("QUEST_DETAIL")
					if ElvUI_EltreumUI.Retail then
						if QuestGetAutoAccept() then
							--print("its an annoying auto accept quest, panel has been closed")
							CloseQuest()
						else
							if ElvUI_EltreumUI.Retail then
								--print("not an auto accept quest")
								if not E.db.ElvUI_EltreumUI.questsettings.acceptdaily then
									if QuestIsDaily() then
										--print("its a daily quest")
										return
									elseif QuestIsWeekly() then
										--print("its a weekly quest")
										return
									else
										AcceptQuest()
										--print("quest accepted")
									end
								else
									AcceptQuest()
									--print("quest accepted")
								end
							elseif ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
								AcceptQuest()
							end
						end
					elseif ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
						AcceptQuest()
						--print("quest accepted")
						if (GetNumQuestChoices() <= 0) then
							--print("no quest choices")
							return
						end
					end
				end
				if event == 'QUEST_ACCEPT_CONFIRM' then
					--print("QUEST_ACCEPT_CONFIRM tried to accept and hide popup")
					ConfirmAcceptQuest()
					StaticPopup_Hide("QUEST_ACCEPT")
				end
				if event == 'GOSSIP_SHOW' then
					--print("GOSSIP_SHOW")
					if ElvUI_EltreumUI.Retail then
						for i, k in next, C_GossipInfo.GetAvailableQuests() do
							--print("iterate and select quest")
							C_GossipInfo.SelectAvailableQuest(i)
						end
					elseif ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
						if (GetNumGossipAvailableQuests() > 0) then
							--print("number of available quests > 0")
							local questlist = {GetGossipAvailableQuests()}
							local i = 1
							while(questlist[i]) do
								--print("tried to select quests with while "..math.random(1,99))
								SelectGossipAvailableQuest(i)
								i = i + 1
							end
						end
						if (GetNumGossipActiveQuests() > 0) then
							--print("number of active quests > 0")
							for i = 1, GetNumGossipActiveQuests() do
								--print("tried to select and accept quests in a loop"..math.random(1,99))
								SelectGossipActiveQuest(i)
								if ElvUI_EltreumUI.Retail then
									if not E.db.ElvUI_EltreumUI.questsettings.acceptdaily then
										if QuestIsDaily() then
											--print("its a daily quest")
											return
										elseif QuestIsWeekly() then
											--print("its a weekly quest")
											return
										else
											AcceptQuest()
										end
									else
										AcceptQuest()
									end
									if (GetNumQuestChoices() <= 0) then
										--print("no quest choices")
										return
									end
								elseif ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
									AcceptQuest()
									if (GetNumQuestChoices() <= 0) then
										return
									end
								end

								i = i + 1
							end
						end
					end
				end
				if event == 'QUEST_GREETING' then
					--print("QUEST_GREETING")

					--if accepting quests
					for i = 1, GetNumAvailableQuests() do
						--print("numquests accept loop")
						SelectAvailableQuest(i)
					end

					--if completing quests
					for i = 1, GetNumActiveQuests() do
					--print("numquests complete loop")
						local _, completed = GetActiveTitle(i)
						if ElvUI_EltreumUI.Retail then
							if completed and not C_QuestLog.IsWorldQuest(GetActiveQuestID(i)) then
								--print("tried to complete "..completed.." and it's not a world quest")
								SelectActiveQuest(i)
							end
						elseif ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
							if completed then
								--print("tried to complete "..completed)
								SelectActiveQuest(i)
							end
						end
					end
				end
				if event == 'QUEST_PROGRESS' then
					--print("QUEST_PROGRESS")
					if GetQuestMoneyToGet() > 0 then
						--print("quest requires gold")
						return
					else
						--print("tried to complete quest")
						CompleteQuest()
					end
				end
				if event == 'QUEST_COMPLETE' then
				--print("QUEST_COMPLETE")
					if GetQuestMoneyToGet() > 0 then
						--print("quest requires gold")
						return
					else
						if ElvUI_EltreumUI.Retail then
							if GetNumQuestChoices() <= 1 then
								--print("tried to select reward and complete")
								GetQuestReward(GetNumQuestChoices())
							end
						elseif ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
							if GetNumQuestChoices() == 1 then
								GetQuestReward(1)
								--print("tried to select reward and complete")
								QuestFrameCompleteButton:Click()
							end
							if GetNumQuestChoices() == 0 then
								--print("tried to complete")
								QuestFrameCompleteButton:Click()
								QuestFrameCompleteQuestButton:Click()
							end
						end
					end
				end
			end
		end)
	end
end

