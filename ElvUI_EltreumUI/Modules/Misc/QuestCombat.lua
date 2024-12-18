local E = unpack(ElvUI)
local _G = _G
--local ObjectiveTracker_Collapse = _G.ObjectiveTracker_Collapse
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded
local IsInInstance = _G.IsInInstance
--local ObjectiveTracker_Expand = _G.ObjectiveTracker_Expand
local ObjectiveTrackerFrame = _G.ObjectiveTrackerFrame
local tonumber = _G.tonumber
local string = _G.string
local C_GossipInfo = _G.C_GossipInfo
local IsShiftKeyDown = _G.IsShiftKeyDown
local IsControlKeyDown = _G.IsControlKeyDown
local IsAltKeyDown = _G.IsAltKeyDown

--Collapse Quests during boss fights
function ElvUI_EltreumUI:QuestEncounter()
	if E.db.ElvUI_EltreumUI.quests.enable then
		local _, instanceType = IsInInstance()
		if instanceType == "raid" or instanceType == "party" or instanceType == "scenario" then --and event == "PLAYER_REGEN_DISABLED"
			if E.Retail then
				--ObjectiveTracker_Collapse()
				--ObjectiveTrackerFrame:Hide()
				ObjectiveTrackerFrame:SetParent(E.HiddenFrame)
				--ObjectiveTrackerFrame:SetAlpha(0)
				--_G.ObjectiveTrackerFrame:SetCollapsed(true)
			elseif E.Classic then
				if IsAddOnLoaded("Questie") then
					if _G["Questie_BaseFrame"] then
						_G["Questie_BaseFrame"]:Hide()
					else
						_G.QuestWatchFrame:Hide()
					end
				else
					_G.QuestWatchFrame:Hide()
				end
			elseif E.Cata then
				if IsAddOnLoaded("Questie") then
					if _G["Questie_BaseFrame"] then
						_G["Questie_BaseFrame"]:Hide()
					else
						_G.WatchFrame:Hide()
					end
				else
					_G.WatchFrame:Hide()
				end
			end
		end
	end
end

--expand after encounter is over
function ElvUI_EltreumUI:QuestEncounterEnd()
	if E.db.ElvUI_EltreumUI.quests.enable then
		if InCombatLockdown() then
			E:Delay(3,ElvUI_EltreumUI.QuestEncounterEnd) --retry soon
		else
			local _, instanceType = IsInInstance()
			if instanceType == "raid" or instanceType == "party" or instanceType == "scenario" then --and event == "PLAYER_REGEN_DISABLED"
				if E.Retail then
					if _G["ObjectiveFrameHolder"] then
						ObjectiveTrackerFrame:SetParent(_G["ObjectiveFrameHolder"])
					else
						ObjectiveTrackerFrame:SetParent(UIParent)
					end
					--ObjectiveTrackerFrame:SetAlpha(1)
					--_G.ObjectiveTrackerFrame:SetCollapsed(false)
				elseif E.Classic then
					if IsAddOnLoaded("Questie") then
						if _G["Questie_BaseFrame"] then
							_G["Questie_BaseFrame"]:Show()
						else
							_G.QuestWatchFrame:Show()
						end
					else
						_G.QuestWatchFrame:Show()
					end
				elseif E.Cata then
					if IsAddOnLoaded("Questie") then
						if _G["Questie_BaseFrame"] then
							_G["Questie_BaseFrame"]:Show()
						else
							_G.WatchFrame:Show()
						end
					else
						_G.WatchFrame:Show()
					end
				end
			end
		end
	end
end

--hide quests in arena/bg matches
function ElvUI_EltreumUI:ArenaQuest()
	if E.db.ElvUI_EltreumUI.quests.arena then
		local _, instanceType = IsInInstance()
		if instanceType == "arena" or instanceType == "pvp" then
			if E.Retail then
				--ObjectiveTrackerFrame:Hide()
				ObjectiveTrackerFrame:SetParent(E.HiddenFrame)
				--ObjectiveTrackerFrame:SetAlpha(0)
				--_G.ObjectiveTrackerFrame:SetCollapsed(true)
			elseif E.Classic then
				if IsAddOnLoaded("Questie") then
					if _G["Questie_BaseFrame"] then
						_G["Questie_BaseFrame"]:Hide()
					else
						_G.QuestWatchFrame:Hide()
					end
				else
					_G.QuestWatchFrame:Hide()
				end
			elseif E.Cata then
				if IsAddOnLoaded("Questie") then
					if _G["Questie_BaseFrame"] then
						_G["Questie_BaseFrame"]:Hide()
					else
						_G.WatchFrame:Hide()
					end
				else
					_G.WatchFrame:Hide()
				end
			end
		elseif instanceType == "none" then
			if E.Retail then
				if _G["ObjectiveFrameHolder"] then
					ObjectiveTrackerFrame:SetParent(_G["ObjectiveFrameHolder"])
				else
					ObjectiveTrackerFrame:SetParent(UIParent)
				end
				--ObjectiveTrackerFrame:SetAlpha(1)
			elseif E.Classic then
				if IsAddOnLoaded("Questie") then
					if _G["Questie_BaseFrame"] then
						_G["Questie_BaseFrame"]:Show()
					else
						_G.QuestWatchFrame:Show()
					end
				else
					_G.QuestWatchFrame:Show()
				end
			elseif E.Cata then
				if IsAddOnLoaded("Questie") then
					if _G["Questie_BaseFrame"] then
						_G["Questie_BaseFrame"]:Show()
					else
						_G.WatchFrame:Show()
					end
				else
					_G.WatchFrame:Show()
				end
			end
		end
	end
end

--Collapse/Hide Quests during combat with anything
function ElvUI_EltreumUI:QuestCombat()
	if E.db.ElvUI_EltreumUI.quests.combatenable then
		if E.Retail then
			--[[if _G.ObjectiveTrackerFrame:IsCollapsed() == false then
				_G.ObjectiveTrackerFrame:ToggleCollapsed() --seems like this causes taints
			end]]
			--_G.ObjectiveTrackerFrame:SetCollapsed(true)
			--ObjectiveTrackerFrame:SetAlpha(0)
			ObjectiveTrackerFrame:SetParent(E.HiddenFrame)
			--ObjectiveTracker_Collapse()
		elseif E.Classic then
			if IsAddOnLoaded("Questie") then
				if _G["Questie_BaseFrame"] then
					_G["Questie_BaseFrame"]:Hide()
				else
					_G.QuestWatchFrame:Hide()
				end
			else
				_G.QuestWatchFrame:Hide()
			end
		elseif E.Cata then
			if IsAddOnLoaded("Questie") then
				if _G["Questie_BaseFrame"] then
					_G["Questie_BaseFrame"]:Hide()
				else
					_G.WatchFrame:Hide()
				end
			else
				_G.WatchFrame:Hide()
			end
		end
	end
end

--expand after combat is over
function ElvUI_EltreumUI:QuestCombatEnd()
	if E.db.ElvUI_EltreumUI.quests.combatenable then
		if E.Retail then
			--[[if _G.ObjectiveTrackerFrame:IsCollapsed() then
				_G.ObjectiveTrackerFrame:ToggleCollapsed() --seems like this causes taints
			end]]
			--_G.ObjectiveTrackerFrame:SetCollapsed(false)
			--ObjectiveTrackerFrame:SetAlpha(1)
			if _G["ObjectiveFrameHolder"] then
				ObjectiveTrackerFrame:SetParent(_G["ObjectiveFrameHolder"])
			else
				ObjectiveTrackerFrame:SetParent(UIParent)
			end
			--ObjectiveTracker_Expand()
		elseif E.Classic then
			if IsAddOnLoaded("Questie") then
				if _G["Questie_BaseFrame"] then
					_G["Questie_BaseFrame"]:Show()
				else
					_G.QuestWatchFrame:Show()
				end
			else
				_G.QuestWatchFrame:Show()
			end
		elseif E.Cata then
			if IsAddOnLoaded("Questie") then
				if _G["Questie_BaseFrame"] then
					_G["Questie_BaseFrame"]:Show()
				else
					_G.WatchFrame:Show()
				end
			else
				_G.WatchFrame:Show()
			end
		end
	end
end

--based on Rogue Door Opener by Burzolog
function ElvUI_EltreumUI:RogueAutoOpen()
	if E.db.ElvUI_EltreumUI.quests.rogueopen then

		--get guid
		local guid = UnitGUID("target")
		if not guid then
			return
		end

		--to NPC_ID
		local NPC_ID = tonumber(string.match(guid, "Creature%-%d+%-%d+%-%d+%-%d+%-(%d+)"))

		--get gossip options
		local gossipInfoTable = C_GossipInfo.GetOptions()

		--only run on correct npcs
		if NPC_ID == 97004 or NPC_ID == 96782 or NPC_ID == 93188 then
			if IsShiftKeyDown() or IsControlKeyDown() or IsAltKeyDown() then
				return
			else
				C_GossipInfo.SelectOption(gossipInfoTable[1].gossipOptionID)
			end
		end
	end
end

--hide quests in m+
function ElvUI_EltreumUI:QuestMythicPlusStart()
	if not E.Retail then return end
	if E.db.ElvUI_EltreumUI.quests.mythicplus then
		ObjectiveTrackerFrame:SetParent(E.HiddenFrame)
	end
end

--show quests after m+
function ElvUI_EltreumUI:QuestMythicPlusEnd()
	if not E.Retail then return end
	if E.db.ElvUI_EltreumUI.quests.mythicplus then
		if _G["ObjectiveFrameHolder"] then
			ObjectiveTrackerFrame:SetParent(_G["ObjectiveFrameHolder"])
		else
			ObjectiveTrackerFrame:SetParent(UIParent)
		end
	end
end
