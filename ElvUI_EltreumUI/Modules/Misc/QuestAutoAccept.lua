local E = unpack(ElvUI)
local _G = _G
local CreateFrame = _G.CreateFrame
local tonumber = _G.tonumber
local string = _G.string
local C_GossipInfo = _G.C_GossipInfo
local IsShiftKeyDown = _G.IsShiftKeyDown
local IsControlKeyDown = _G.IsControlKeyDown
local IsAltKeyDown = _G.IsAltKeyDown
local GetNumAvailableQuests = _G.GetNumAvailableQuests
local SelectAvailableQuest = _G.SelectAvailableQuest
local GetNumActiveQuests = _G.GetNumActiveQuests
local GetActiveTitle = _G.GetActiveTitle
local C_QuestLog = _G.C_QuestLog
local GetActiveQuestID = _G.GetActiveQuestID
local SelectActiveQuest = _G.SelectActiveQuest
local StaticPopup_Hide = _G.StaticPopup_Hide
local next = _G.next

--yet another quest auto accept thing
local EltruismAutoComplete = CreateFrame("FRAME", "EltruismAutoCompleteFrame")
function ElvUI_EltreumUI:AutoAcceptQuests()
	if E.db.ElvUI_EltreumUI.quests.autoaccept then
		local lastgossip
		EltruismAutoComplete:RegisterEvent("QUEST_GREETING")
		EltruismAutoComplete:RegisterEvent("GOSSIP_SHOW")
		EltruismAutoComplete:RegisterEvent("QUEST_DETAIL")
		EltruismAutoComplete:RegisterEvent("QUEST_COMPLETE")
		EltruismAutoComplete:RegisterEvent("QUEST_ACCEPT_CONFIRM")
		EltruismAutoComplete:RegisterEvent("QUEST_PROGRESS")
		EltruismAutoComplete:SetScript("OnEvent", function(_, event)
			if E.db.ElvUI_EltreumUI.dev then
				ElvUI_EltreumUI:Print(event)
			end
			local normal = (IsShiftKeyDown() or IsControlKeyDown() or IsAltKeyDown())
			if E.db.ElvUI_EltreumUI.quests.autoacceptinvert then
				normal = not (IsShiftKeyDown() or IsControlKeyDown() or IsAltKeyDown())
			end
			if normal then
				return
			else
				if E.db.ElvUI_EltreumUI.dev then
					ElvUI_EltreumUI:Print("started quest automation")
				end
				if event == 'QUEST_GREETING' then
					if E.db.ElvUI_EltreumUI.dev then
						ElvUI_EltreumUI:Print("QUEST_GREETING")
					end

					--if accepting quests
					for i = 1, GetNumAvailableQuests() do
						if E.db.ElvUI_EltreumUI.dev then
							ElvUI_EltreumUI:Print("numquests accept loop")
						end
						SelectAvailableQuest(i)
					end

					--if completing quests
					for i = 1, GetNumActiveQuests() do
						if E.db.ElvUI_EltreumUI.dev then
							ElvUI_EltreumUI:Print("numquests complete loop")
						end
						local _, completed = GetActiveTitle(i)
						if E.Retail then
							if completed and not C_QuestLog.IsWorldQuest(GetActiveQuestID(i)) then
								if E.db.ElvUI_EltreumUI.dev then
									ElvUI_EltreumUI:Print("tried to complete "..completed.." and it's not a world quest")
								end
								SelectActiveQuest(i)
							end
						elseif E.Wrath or E.Classic then
							if completed then
								if E.db.ElvUI_EltreumUI.dev then
									ElvUI_EltreumUI:Print("tried to complete "..completed)
								end
								SelectActiveQuest(i)
							end
						end
					end
				end
				if event == 'QUEST_DETAIL' then
					if E.db.ElvUI_EltreumUI.dev then
						ElvUI_EltreumUI:Print("QUEST_DETAIL")
					end
					if E.Retail then
						if QuestGetAutoAccept() then
							if E.db.ElvUI_EltreumUI.dev then
								ElvUI_EltreumUI:Print("its an annoying auto accept quest, panel has been closed")
							end
							CloseQuest()
						else
							if E.db.ElvUI_EltreumUI.dev then
								ElvUI_EltreumUI:Print("not an auto accept quest")
							end
							if not E.db.ElvUI_EltreumUI.quests.acceptdaily then
								if QuestIsDaily() then
									if E.db.ElvUI_EltreumUI.dev then
										ElvUI_EltreumUI:Print("its a daily quest")
									end
									return
								elseif QuestIsWeekly() then
									if E.db.ElvUI_EltreumUI.dev then
										ElvUI_EltreumUI:Print("its a weekly quest")
									end
									return
								else
									AcceptQuest()
									if E.db.ElvUI_EltreumUI.dev then
										ElvUI_EltreumUI:Print("quest accepted")
									end
								end
							else
								AcceptQuest()
								if E.db.ElvUI_EltreumUI.dev then
									ElvUI_EltreumUI:Print("quest accepted")
								end
							end
						end
					elseif E.Wrath or E.Classic then
						AcceptQuest()
						if E.db.ElvUI_EltreumUI.dev then
							ElvUI_EltreumUI:Print("quest accepted")
						end
						if (GetNumQuestChoices() <= 0) then
							if E.db.ElvUI_EltreumUI.dev then
								ElvUI_EltreumUI:Print("no quest choices")
							end
							return
						end
					end
				end
				if event == 'QUEST_ACCEPT_CONFIRM' then
					if E.db.ElvUI_EltreumUI.dev then
						ElvUI_EltreumUI:Print("QUEST_ACCEPT_CONFIRM tried to accept and hide popup")
					end
					ConfirmAcceptQuest()
					StaticPopup_Hide("QUEST_ACCEPT")
				end
				if event == 'GOSSIP_SHOW' then
					if E.db.ElvUI_EltreumUI.dev then
						ElvUI_EltreumUI:Print("GOSSIP_SHOW")
					end
					local guid = UnitGUID("npc")
					if guid == nil then
						return
					end
					local NPC_ID = tonumber(string.match(guid, "Creature%-%d+%-%d+%-%d+%-%d+%-(%d+)"))
					local ignoredNPCS = {
						[164079] = true,
						[174871] = true,
						[164173] = true,
						[111243] = true,
						[142063] = true,
						[141584] = true,
						[88570] = true,
						[87391] = true,
						[18166] = true,
						[142700] = true,
						[143005] = true,
						[142685] = true,
						[142975] = true,
						[143007] = true,
						[142992] = true,
						[142997] = true,
						[142998] = true,
						[142983] = true,
						[142995] = true,
						[142993] = true,
						[142981] = true,
						[143004] = true,
						[142973] = true,
						[142970] = true,
						[142994] = true,
						[142969] = true,
						[142157] = true,
						[143008] = true,
						[142158] = true,
						[142159] = true,
						[142977] = true,
						[172925] = true,
						[169501] = true,
						[181059] = true,
						[182681] = true,
						[54334] = true, --darkmoon tp
						[55382] = true, --darkmoon tp
						[54346] = true, --darkmoon tp
						[28160] = true, --free teleport guy for wrath to scholazar
						[26673] = true, --magical kingdom of dalaran alliance free tp to dalaran
						[29155] = true, --magical kingdom of dalaran horde free tp to dalaran
						[29156] = true, --magical kingdom of dalaran free tp to dalaran
						[196499] = true, --therazal, aiding the accord quest that drops scaling gear, so should be delayed
						[199366] = true, --therazal, aiding the accord quest that drops scaling gear, so should be delayed
						[194584] = true, --Khuri, fishing npc
						[113617] = true, --cos teleport back npc
						[193110] = true, --Khadin, profession npc
					}
					if ignoredNPCS[NPC_ID] then
						if E.db.ElvUI_EltreumUI.dev then
							ElvUI_EltreumUI:Print("npc is in the ignored list")
						end
						return
					else
						--https://wowpedia.fandom.com/wiki/Category:API_namespaces/C_GossipInfo
						--if E.Retail or E.Wrath then
						local active = C_GossipInfo.GetActiveQuests()
						local available = C_GossipInfo.GetAvailableQuests()
						local notcomplete = 0
						local completed = 0
						local loopcomplete = false
						if available[1] and available[1].title ~= nil then
							if E.db.ElvUI_EltreumUI.dev then
								ElvUI_EltreumUI:Print("available quest detected, searching for it")
							end
							for _, k in next, C_GossipInfo.GetAvailableQuests() do --quests to grab
								--local title, questLevel, isTrivial, frequency, repeatable, isComplete, isLegendary, isIgnored, questID = C_GossipInfo.GetAvailableQuests(i)
								if E.db.ElvUI_EltreumUI.dev then
									ElvUI_EltreumUI:Print("iterate and select quest to get")
								end

								for l, v in next, k do
									if l == "questID" then
										C_GossipInfo.SelectAvailableQuest(v)
									end
								end
								--C_GossipInfo.SelectAvailableQuest(i)
							end
						elseif active[1] and active[1].title ~= nil then
							if E.db.ElvUI_EltreumUI.dev then
								ElvUI_EltreumUI:Print("active quest detected, searching for option")
							end
							for i, _ in next, C_GossipInfo.GetActiveQuests() do --quests already grabbed
								if active[i].isComplete then
									completed = completed + 1
								elseif active[i].isComplete ~= true then
									notcomplete = notcomplete +1
								end
								loopcomplete = true
							end
							if loopcomplete then
								for i, k in next, C_GossipInfo.GetActiveQuests() do
									if completed >= 1 then
										if E.db.ElvUI_EltreumUI.dev then
											ElvUI_EltreumUI:Print("iterate and select already active quest")
										end
										for l, v in next, k do
											if l == "questID" then
												C_GossipInfo.SelectActiveQuest(v)
											end
										end
										--C_GossipInfo.SelectActiveQuest(i)
									end
									if completed == 0 then
										if E.db.ElvUI_EltreumUI.dev then
											ElvUI_EltreumUI:Print("selecting gossip instead")
										end
										local gossipInfoTable = C_GossipInfo.GetOptions()

										if #gossipInfoTable == 1 then
											if NPC_ID == 153897 then
												return
											else
												if E.db.ElvUI_EltreumUI.dev then
													ElvUI_EltreumUI:Print("one gossip option found, selecting it")
												end
												if gossipInfoTable[i] and gossipInfoTable[i].gossipOptionID then
													if lastgossip ~= gossipInfoTable[i].gossipOptionID then
														C_GossipInfo.SelectOption(gossipInfoTable[i].gossipOptionID)
														lastgossip = gossipInfoTable[i].gossipOptionID
													end
												end
											end
										elseif #gossipInfoTable == 0 then
											if E.db.ElvUI_EltreumUI.dev then
												ElvUI_EltreumUI:Print("gossip table returning 0 entries")
												--C_GossipInfo.SelectAvailableQuest()
											end
										else
											if E.db.ElvUI_EltreumUI.dev then
												ElvUI_EltreumUI:Print("multiple gossip options detected, looking for blue quest text...1")
											end
											for infonumber = 1, #gossipInfoTable do
												local text = gossipInfoTable[infonumber].name
												if text and text:match("|cFF0000FF") then --quests are marked with a blue (Quests) text too
													if E.db.ElvUI_EltreumUI.dev then
														ElvUI_EltreumUI:Print("blue quest text found, selecting it")
													end
													C_GossipInfo.SelectOption(gossipInfoTable[infonumber].gossipOptionID)
												end
											end
										end
									end
								end
							end
						elseif (not active[1] or active[1].title == nil) or (not available[1] or available[1].title == nil) then
							if E.db.ElvUI_EltreumUI.dev then
								ElvUI_EltreumUI:Print("no available or active quest, looking for gossip instead")
							end
							local gossipInfoTable = C_GossipInfo.GetOptions()
							if E.Retail and C_Map.GetBestMapForUnit('player') == 762 then return end
							if #gossipInfoTable == 1 then
								if NPC_ID == 153897 then
									return
								elseif gossipInfoTable[1].name:match("|cFFFF0000") then
									if E.db.ElvUI_EltreumUI.dev then
										ElvUI_EltreumUI:Print("red gossip found, returning")
									end
									return
								else
									if E.db.ElvUI_EltreumUI.dev then
										ElvUI_EltreumUI:Print("one gossip option found, selecting it")
									end
									C_GossipInfo.SelectOption(gossipInfoTable[1].gossipOptionID)
								end
							else
								if E.db.ElvUI_EltreumUI.dev then
									ElvUI_EltreumUI:Print("multiple gossip options detected, looking for blue quest text...2")
								end
								for i = 1, #gossipInfoTable do
									local text = gossipInfoTable[i].name
									if text and text:match("|cFF0000FF") then --quests are marked with a blue (Quests) text too
										if E.db.ElvUI_EltreumUI.dev then
											ElvUI_EltreumUI:Print("blue quest text found, selecting it")
										end
										C_GossipInfo.SelectOption(gossipInfoTable[i].gossipOptionID)
									end
								end
							end
						end
					end
				end
				if event == 'QUEST_PROGRESS' then
					if E.db.ElvUI_EltreumUI.dev then
						ElvUI_EltreumUI:Print("QUEST_PROGRESS")
					end
					if GetQuestMoneyToGet() > 0 then
						if E.db.ElvUI_EltreumUI.dev then
							ElvUI_EltreumUI:Print("quest requires gold")
						end
						return
					else
						if C_GossipInfo.GetNumActiveQuests() == 0 then --maybe npc only has 1 quest, or its laurent from revendreth and it has a turn in with 0
							if E.db.ElvUI_EltreumUI.dev then
								ElvUI_EltreumUI:Print("unable to determine if quest completed, trying anyway")
							end
							CompleteQuest()
						end
						for i, _ in next, C_GossipInfo.GetActiveQuests() do --quests already grabbed
							local questdump = C_GossipInfo.GetActiveQuests()
							if not questdump[i].isComplete then
								if E.db.ElvUI_EltreumUI.dev then
									ElvUI_EltreumUI:Print("quest not completed")
								end
								return
							elseif questdump[i].isComplete then
								if E.db.ElvUI_EltreumUI.dev then
									ElvUI_EltreumUI:Print("quest completed, turning in")
								end
								CompleteQuest()
							end
						end
					end
				end
				if event == 'QUEST_COMPLETE' then
					if E.db.ElvUI_EltreumUI.dev then
						ElvUI_EltreumUI:Print("QUEST_COMPLETE")
					end
					if GetQuestMoneyToGet() > 0 then
						if E.db.ElvUI_EltreumUI.dev then
							ElvUI_EltreumUI:Print("quest requires gold")
						end
						return
					else
						if GetNumQuestChoices() <= 1 then
							if E.db.ElvUI_EltreumUI.dev then
								ElvUI_EltreumUI:Print("tried to select reward and complete")
							end
							GetQuestReward(GetNumQuestChoices())
						end
					end
				end
			end
		end)
	end
end

